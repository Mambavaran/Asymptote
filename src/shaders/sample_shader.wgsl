struct Data {
    offset: vec3<f32>,
};
@group(0)@binding(0)
var<uniform> data: Data;

struct VertexInput {
    @location(0) position: vec3<f32>,
    @location(1) tex_coords: vec2<f32>,
};

struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) tex_coords: vec2<f32>,
};

@vertex
fn vs_main(
    model: VertexInput,
) -> VertexOutput {
    
    var out: VertexOutput;

    let x = model.position + data.offset;

    out.tex_coords = model.tex_coords;
    out.clip_position = vec4<f32>(x , 1.0);

    return out;
}


@group(1)@binding(0)
var t_texture: texture_2d<f32>;
@group(1)@binding(1)
var s_texture: sampler;

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    return textureSample(t_texture, s_texture, in.tex_coords);
}
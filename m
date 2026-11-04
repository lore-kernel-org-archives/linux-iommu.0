Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793786979;
	b=JxGO0DeZhVItZHRC9TC/OPk1w8k2gH++625plhbPgJAsePyxTvCm+Z19oEL+IQUoH0a9
	 qWuujmM2YQOx8qVcDJRJXjUNoVTwWJnulJf4E8d5cj4MdN1SymMSuO0FS0YSJa3Hn/YOi
	 qjKxeBNQ9b3ruk/ZO17ze31ccihVlknMNufmRBO+rlAcsxYmBgcHvne6x6mzc2rRsl5/y
	 cA9a0b/+89sG6CqLgc/wj9wvjfYs113Z++GjcL8iBul0GJquDcLYzDEKtPxlAcgMamDCh
	 XQyyID/OJ7EfIPf1wy3w8QJPNuBqOLk7wWlNh0JkNsQUNIAR2cVRnCRTE/EQsQwsIzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GRB1e0g/RzNosgVh22Q4nbJS5JXGJ4/s7oJ6tqlGbYg=;
	b=y/3wcv/gyHeW0WIK0bx282f2t9M3O1tNpI8om3Igs4On/XR7ycQKSDHZ/4pq3wW4HEAo
	 fwVKDD4KDq8FebScKC3SXSLTFH+eEyZ3XOnNt/K81tGpme+EmiQ8NTKc5KgQ09wlWJies
	 3wYLd4LlrFiFzVrP/i+ouCAdmD3c2XfEWCSfaXMwDTf0c6DyJz5/tDm+23eJ1LSqryn0A
	 oIjst8ovd5kfYxq1egV4X+GfLw4ZRfUeWUo+GHNVk2zPC8ETnt3gdxFnMPIUoJNN4MLBL
	 ag8W00KdymPEiJuP/hOohnSUomC3KuJ/K9udWF30f67bo3PzT+Tg+v5423LxRdeA72g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=tomeuvizoso.net;
	spf=pass smtp.mailfrom=tomeuvizoso.net;
	dkim=pass header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HmEXRWa5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543A0606A329
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 10:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 543A0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HmEXRWa5
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e55db58cfso58489985a.1
        for <iommu@lists.linux.dev>; Wed, 04 Nov 2026 02:09:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793786977; cv=none;
        d=google.com; s=arc-20260327;
        b=MitvF25BWgTC1lT09gI9jUIjrtCyETVPVauS6bmMFVze1iAm88XB6MSgozMjT36E6Y
         bK8efcMYg36pv3t7H0eDT3Lq7178ospNeJaav+8LpuNZRGZbTEChz3t23Fi48Toby6TE
         jkUPZQY5Q/S3N7TJVpXArFZZb2CppJn+WXJc2e1KMzf+lpAM/Hj0aMTn+tMuKO2FZEay
         yCdcuC0yguKobhAYyuEWuZdKNEW5QDoYCBm+kGbynKJINvIjVEMBHL+yPsi93094amN0
         ZgnusWvJPnKNBI/l9K3PISQOj3IAHmK0InEPRzRkZEoszQfEBqWqrnUH3pSaw/qayOlb
         fp7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GRB1e0g/RzNosgVh22Q4nbJS5JXGJ4/s7oJ6tqlGbYg=;
        fh=eAXCzjnIXuTqn22TEf8XXoPvVnNbyXNEplIrlnFank0=;
        b=BEhEvsupexjE2YzgiI7n/jWxG/Kfd+vgHJIj0yiopYzs/YlEJMH5gUnqt1z5vVAyMq
         b72YfAISJxBm/2fT3CNhudKzxplri8rf0iR7eMM9cKjAqWlRb7Yn2YAD3aGUIpaXaDXp
         UZmji8hBYooiEkV6A0cTuZL41Q/beX/iSgLsDEgHXJbCbUtna1j3FT2rpOXOPfyTBx3D
         F9nOcIMGbtNWxRx6tZnpvnWsvo9k8e7Z0zDIFEXrLZbttJXuoszyMkYenS7TnaqRfMNl
         +g+0+uohJ027lDbTrZHumWpsX2gtjY4VuUSNNVVxD/MUJYvgoe2gCM7k0hGhI2h7i82z
         r4XQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20260707.gappssmtp.com; s=20260707; t=1793786977; x=1794391777; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GRB1e0g/RzNosgVh22Q4nbJS5JXGJ4/s7oJ6tqlGbYg=;
        b=HmEXRWa5ot6PlXKF9EGCZA+QIHYkHOc+X+6ZUMMSB3fUN7cUZwmOCUQmskx8DyKLcV
         jF3cAkkKtmj4nCP1sOrrbagi9xu2gJVlVCCiOWeVsEICCq/67J43PAKwdO+jaQBg9KKC
         M5bktdhRMCs93RkX/0gf4y5ttxsHk+4Yg/jSxCOXkk2rsq3n2k2IIOcDMnowZ4R49vMt
         p27mJNW9+gY/Hb6LyIQo0zf7EgTls9xaZetKjxWZ+4alFPAMHwTuXMIK1Ns2VhIzbu1D
         gUyKq7BVYOFZtTTnNa7aQ8uR668V0SNs5g1eEMxfSnejkqQ6ZX1MDCDQhBHhs+u7tZCX
         enfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793786977; x=1794391777;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GRB1e0g/RzNosgVh22Q4nbJS5JXGJ4/s7oJ6tqlGbYg=;
        b=bcHQkpkJcSt3onNyayzZoWH16H8vMV3lG/yLjfoSxlP/7waEzfDeWlz9tETtemKGRl
         A9ru6BHA5EWVtbmprpkdGbfDhugqbExcq/nrDYpYfGMreNxb2Vl9hmna5m+4sV45oZ9i
         /K1bg1yKz2Dk9TPZ1BRVs1ipEK/2pY3PkyFts4pNEWK5gMoyK/TMNW3D6MC3G82pAlgU
         44slTOmkLbG0QgcygP3Q6Jnym7/mYVHuXgghhr01r+fNjCxepLgmDdWGQ0gUPSleymsg
         zRVx5X80A795uP3pJLd/gSxuHcx4wg1ieS1hQQvx4jLJtlOG1RrMinnEM3HyJXiZDi98
         3M3w==
X-Forwarded-Encrypted: i=1; AKwUvByvso8tnMmgBDZwcrMWKykdBaUBpi6HLqKZvuvIwwqsFVGBU9t0AxWVsh11SuiPSYPaKZzuiw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+0imARhBOy4f6ObdD1f2DJOmO5qzM4frRR5tNUxPnSojjAYvhi
	W/LMG0RnCVq0buXG4+LkYEgt1LgaJjfA/SmKBLXU3be21GNPI2/Qu7HrdQOL1S+ck/4shI14ktX
	UmaPm2tbJoRSo6DhhvdYakR+WweOz81VQ27YlibfDOQ==
X-Gm-Gg: AYBFou2rBRvAhEUW1kbnypP2CIfhgO95OyEeCw2XY84BG4gj68iZXjEyxJhJ/+yw2vd
	8O97o7PGD19hzMb0817jisKtyS00RPkvM28LRYEfGNVH/0asz7hGiMLf63QQKKbND0zDXNde89E
	C40cowVz7NYRMHXs46n79/N/dBgbQuNXF9Z65kYbQZMbcT5nt6hmi52qKOLgKtJ6ig85qsaPVWy
	jvYgw5zaRmBQBAL0dMyOjZT3lZfttbrq/TfqsQtUyIEKNJfBwhM9OPC8O5pzphrpNeDxOZDFct0
	bBMVzv9zg+QRg/qMXhjk3NlBp/CIlvL2GArY95md6+j0foVGgrOllkAK50qJmmH06mj26eY8s1q
	u3RwuSktlA6FW3obqnYglvGmGdS/qDhZwVZHI5PQGeeraanEB4fkpHyZs7OBHStvxDAfkrnfuJ6
	ncvWFrCAQpajXUPc59+A8=
X-Received: by 2002:a05:620a:460b:b0:937:6de8:b40 with SMTP id
 af79cd13be357-944217194b4mr2663985585a.15.1793786977174; Wed, 04 Nov 2026
 02:09:37 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261101082307.151957-1-gahing@gahingwoo.com>
In-Reply-To: <20261101082307.151957-1-gahing@gahingwoo.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Wed, 4 Nov 2026 11:09:25 +0100
X-Gm-Features: AclHuK8sSyrPUh77ae7umfCvxuLdQ-s4Z2b2nFvZD8O11RHz5Wmhve3hcOyzmnA
Message-ID: <CAPsqS2SOj-+VQxsFvMQ1Hqcep55J0yT++76QZ8or4a9kmF7Bdw@mail.gmail.com>
Subject: Re: [PATCH v15 00/15] accel/rocket: RK3576 NPU (RKNN) enablement
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org, 
	p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com, 
	royalnet026@gmail.com, abel.vesa@oss.qualcomm.com, 
	sebastian.reichel@collabora.com, sidong.yang@furiosa.ai, 
	u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com, 
	diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl, 
	jeff.hugo@oss.qualcomm.com, rfoss@kernel.org, dri-devel@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, iommu@lists.linux.dev, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 9:31=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> wr=
ote:
>
> This adds the RK3576 NPU to accel/rocket.
>
> v15 is v14 rebased onto next-20261030. v14's 12/15 no longer applied
> there, because Sidong Yang's regcmd validation added two defines in the
> spot where 12/15 adds its own. Nothing else changed, and the tags carry
> over.
>
> Leonard Lausen has the series running on a NanoPi M5 and posted a board
> patch on top of it:
> https://lore.kernel.org/all/20261019090348.378183-2-leonard@lausen.nl/
>
> On Sashiko's two points about v14 9/15, I measured a CM5-IO. U-Boot
> hands over with the NPU domains on, and the power domain driver still
> probes. The NPU QoS is saved before its first power-on, so it is not
> zeroed. The domain whose QoS does get zeroed is the GPU, on mainline
> without this series, and that fix went out on its own:
> https://lore.kernel.org/all/20261101055633.101309-1-gahing@gahingwoo.com/
>
> 1/15 is the patch that carries Igor Paunovic's name. It is also part
> of his DVFS series, so whichever lands first, the other drops it.
>
> Ulf offered to take 7, 9 and 10. 1 to 5, 11 and 12 go through accel,
> and 13 to 15 through rockchip. 15/15 needs 9, 10 and 12 to 14 first.
> Without 9, 10 and 13, the ROCK 4D takes an SError at boot when the NPU
> domain powers on.
>
> Link to v14: https://lore.kernel.org/all/20260924102135.92217-1-gahing@ga=
hingwoo.com/

Hi,

Could you please add a GET_PARAM IOCTL to this series for userspace to
query the hardware version? I think I would return an enum that
matches the NPU DT compatibles one to one. Then userspace can have a
hardware database indexed by that value with sram, register map, etc.

Regards,

Tomeu

> Igor Paunovic (1):
>   accel/rocket: request the core clocks by name
>
> Jiaxing Hu (14):
>   accel/rocket: take the completion register writes under job_lock
>   accel/rocket: wait for a running IRQ handler before resetting a core
>   accel/rocket: let the core suspend after a reset
>   accel/rocket: factor the completion tail out of the IRQ handler
>   dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
>   dt-bindings: power: rockchip: allow resets in a power domain node
>   dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
>   pmdomain: rockchip: add optional per-domain power-on settle delay
>   pmdomain: rockchip: cycle an optional power-domain reset on power-on
>   accel/rocket: select the per-core clock and reset counts from match
>     data
>   accel/rocket: add RK3576 NPU (RKNN) support
>   arm64: dts: rockchip: add NPU core domain clocks and resets to rk3576
>   arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
>   arm64: dts: rockchip: enable the NPU on rk3576-rock-4d
>
>  .../bindings/iommu/rockchip,iommu.yaml        |  28 ++++
>  .../npu/rockchip,rk3588-rknn-core.yaml        |  47 +++++-
>  .../power/rockchip,power-controller.yaml      |   8 +
>  .../boot/dts/rockchip/rk3576-rock-4d.dts      |  22 +++
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  86 +++++++++-
>  drivers/accel/rocket/rocket_core.c            |  32 +++-
>  drivers/accel/rocket/rocket_core.h            |  11 +-
>  drivers/accel/rocket/rocket_device.c          |   7 +-
>  drivers/accel/rocket/rocket_drv.c             |  42 ++++-
>  drivers/accel/rocket/rocket_drv.h             |   2 +
>  drivers/accel/rocket/rocket_job.c             | 157 +++++++++++++++---
>  drivers/pmdomain/rockchip/pm-domains.c        |  89 +++++++---
>  12 files changed, 467 insertions(+), 64 deletions(-)
>
>
> base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
> --
> 2.43.0
>

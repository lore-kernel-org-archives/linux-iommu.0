Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8BC12B163
	for <iommu@lists.linux.dev>; Thu,  4 Apr 2024 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252479; cv=none; b=iTOyyLV+A9/HdBN+t57i5nrM55sv52MFY2fA1HLgp8O+3M3KKiA3nZzyITjzpl9cXCn9guOWSpGCRe7aNexJFHqblOuF8t7DApA6IrVB9ppzZw8z8Z8zc6m6QWdEj+Y9muaBgwK2H47hbbw3+O1zDcKgPiTNTpKH0BvUTmdvgV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252479; c=relaxed/simple;
	bh=OA/jUJ05jo1vzjvMVzohJkoM+kxDKZwUgLxh7dqwh/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cqY1wn5QxqrOg3aaZnJLe8Uu9IzYjtNn5vE39bBMmvuZ3cBBkQZrRfw7f1eqA6EddDgtdd2qPzGLIiiTxYQJMlTeZCR30faGsWa706cckVn6MFtoBl1QdJa8BiaEyLKRZNdkvA53/U9IlmKe6l3Cws4AjXJlJuLkpIcbO/Pv5aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=t2Gx4hur; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="t2Gx4hur"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e50e8dcc72so617649a34.3
        for <iommu@lists.linux.dev>; Thu, 04 Apr 2024 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1712252476; x=1712857276; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PDCUlJMzIv/laHrjUCGrOmU4Uxm0ZKwh32oebCX4CUg=;
        b=t2Gx4hurtjaiiNFSrwHYYpP9Wp9yAhVNrtSr5DWIFLNpJtFsQD9VA4xp6t9PQMGinQ
         kXE/P3yp1VUwYfut+tfmf7My6c1IHvKWPV1PDQYibmrxjMMfQUFlqupRtVvgoSVAwZlP
         5NGI3hGNJVOMzqZ7kaQGmktcrmgziqOe38KO4nodOyd3TDS3u60JQYLnTDnVaI7Fr/Tb
         5iVdVqmmEm6MR0lZlkFJ2cB7voyFfw9VCbXxdVMyxhKrLdiS/gjXSvSh4GqRJ8WE14lh
         3qNkFrObYVdw8bEd3aTicRSKbKxfKKo0zUN0MVWAzo3z8WiimtFoLoXAjLGQNo5KiSZD
         h8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712252476; x=1712857276;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDCUlJMzIv/laHrjUCGrOmU4Uxm0ZKwh32oebCX4CUg=;
        b=SuC9sFymoTW5hMhsySLjTSmzafss/4uL/xBWfO9seOG2KNdKbtglU1A5QI47+q8m6G
         DA11sBBMeoq+E+8dL2bikLaMPcMAsrBct+OO2MvbG3CX5mwIjhxFYe7CDYhAjWRzrOFj
         Xj9rS/30/GV3a8GUu9SqNxrDJhdezGrDp2arf7dWqKZBIc7NvDIggUCH2g+z6y0beZFa
         QPZVbNgkN5uLLh/jK+lnNvSov6mLoFe6+Rjyp06WJESV2IsgRNw5cZo36QEQODDangXa
         Yo00TefVsVaYG7UU5AKlFmJEp4MbssjwaRaCnyCLzCUtrn/lPd1zlqGiMrUci7dl/a+V
         /ong==
X-Forwarded-Encrypted: i=1; AJvYcCWLCc22FEY8aNH9Se32g6u0dsZicrdSZ3QbKyD6qupa/Q7KvOPlG3AM2WTkkfNJqv3KwzeZT7LdkxtJpVyqoVutb9WwySc=
X-Gm-Message-State: AOJu0YyHkffL9jjYIKJqNA51ecYGICBVo/iRi2xoe517PVGYp74q5QU0
	43yp6bApbHTinb1YEekmO64YcH7xcigR0XugWdASkFnSnxwbhR1kDHM6hP4Lyio=
X-Google-Smtp-Source: AGHT+IH6SPgr9ERE/vwlY2jNucRJ8k5kekJ4QNJCT/jjb/z1ac1mW4/lQwO5MYeuUEjOj8KsCc0l4g==
X-Received: by 2002:a05:6870:c194:b0:22e:15fd:e247 with SMTP id h20-20020a056870c19400b0022e15fde247mr3396329oad.5.1712252476562;
        Thu, 04 Apr 2024 10:41:16 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:6448:fa75:a4ff:fe45:b56])
        by smtp.gmail.com with ESMTPSA id l13-20020a37f50d000000b0078a4d950935sm6051176qkk.12.2024.04.04.10.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 10:41:16 -0700 (PDT)
Message-ID: <bbcb66e9499120a86b367e7abdac2d8e2e704bfb.camel@ndufresne.ca>
Subject: Re: [PATCH v2 0/2] Enable JPEG encoding on rk3588
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, 
	linux-kernel@vger.kernel.org
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Philipp Zabel
 <p.zabel@pengutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Sebastian
 Reichel <sebastian.reichel@collabora.com>,  Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, Dragan Simic <dsimic@manjaro.org>,
 Shreeya Patel <shreeya.patel@collabora.com>, Chris Morgan
 <macromorgan@hotmail.com>, Andy Yan <andy.yan@rock-chips.com>, Nicolas
 Frattaroli <frattaroli.nicolas@gmail.com>,  linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  iommu@lists.linux.dev
Date: Thu, 04 Apr 2024 13:41:15 -0400
In-Reply-To: <20240327134115.424846-1-linkmauve@linkmauve.fr>
References: <20240327134115.424846-1-linkmauve@linkmauve.fr>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi,

Le mercredi 27 mars 2024 =C3=A0 14:41 +0100, Emmanuel Gil Peyrot a =C3=A9cr=
it=C2=A0:
> Only the JPEG encoder is available for now, although there are patches
> for the undocumented VP8 encoder floating around[0].

[0] seems like a broken link. The VP8 encoder RFC is for RK3399 (and Hantro=
 H1
posted by ST more recently). The TRM says "VEPU121(JPEG encoder only)", whi=
ch
suggest that the H.264 and VP8 encoders usually found on the VEPU121 are
removed. As Rockchip have remove the synthesize register while modifying th=
e H1
IP, it is difficult to verify. Confusingly the H.264 specific registers are
documented in the TRM around VEPU121.

>=20
> This has been tested on a rock-5b, resulting in four /dev/video*
> encoders.  The userspace program I=E2=80=99ve been using to test them is
> Onix[1], using the jpeg-encoder example, it will pick one of these four
> at random (but displays the one it picked):
> % ffmpeg -i <input image> -pix_fmt yuvj420p temp.yuv
> % jpeg-encoder temp.yuv <width> <height> NV12 <quality> output.jpeg

I don't like that we exposing each identical cores a separate video nodes. =
I
think we should aim for 1 device, and then multi-plex and schedule de cores=
 from
inside the Linux kernel.

Not doing this now means we'll never have an optimal hardware usage
distribution. Just consider two userspace software wanting to do jpeg encod=
ing.
If they both take a guess, they may endup using a single core. Where with p=
roper
scheduling in V4L2, the kernel will be able to properly distribute the load=
. I
insist on this, since if we merge you changes it becomes an ABI and we can'=
t
change it anymore.

I understand that this impose a rework of the mem2mem framework so that we =
can
run multiple jobs, but this will be needed anyway on RK3588, since the rkvd=
ec2,
which we don't have a driver yet is also multi-core, but you need to use 2 =
cores
when the resolution is close to 8K.

Nicolas

>=20
> [0] https://patchwork.kernel.org/project/linux-rockchip/list/?series=3D78=
9885
> [1] https://crates.io/crates/onix
>=20
> Changes since v1:
> - Dropped patches 1 and 4.
> - Use the proper compatible form, since this device should be fully
>   compatible with the VEPU of rk356x.
> - Describe where the VEPU121 name comes from, and list other encoders
>   and decoders present in this SoC.
> - Properly test the device tree changes, I previously couldn=E2=80=99t si=
nce I
>   was using a too recent version of python-jsonschema=E2=80=A6
>=20
> Emmanuel Gil Peyrot (2):
>   media: dt-binding: media: Document rk3588=E2=80=99s VEPU121
>   arm64: dts: rockchip: Add VEPU121 to rk3588
>=20
>  .../bindings/media/rockchip,rk3568-vepu.yaml  |  8 +-
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 80 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 2 deletions(-)
>=20


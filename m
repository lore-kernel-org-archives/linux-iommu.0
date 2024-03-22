Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A94F4E1DD
	for <iommu@lists.linux.dev>; Fri, 22 Mar 2024 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119437; cv=none; b=Cwq/1J2R5aEia8kUCATsS+mKZlEQtwcyjcpcW8LjbaJXZQAJG8C8NhxidZ64BgaOx+04C50kU8Jc/GRxT2zitBC6nNeyhH/cgQy+5VebKog8IWKK+dknOks+LrNHhesTVg/M7ur+tfBYeNHkV+0TS32LE2WFQcp2wcwO3xsLANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119437; c=relaxed/simple;
	bh=o3JhQ0qHV6zswN/4yjEibtmn3jJU5IgKzMreC96p6CA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YKShhoFj6uHB3Dg4CQ3LzCh5adhqDm0BzUrtwGf7drr0uiQ7g+vkempOOZhjE9DzO4I6Zo1gVTvp1awtvHB/1+hHxy2Fo49x2xxRwdOQ2UfTTUMiKOBmqfRS0HY9TLklM/++Z3ccW0L195sxG0NjJTOchd6KxbpIkl4a5pawTqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=vnohXErv; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="vnohXErv"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4765c5905a8so800701137.0
        for <iommu@lists.linux.dev>; Fri, 22 Mar 2024 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1711119434; x=1711724234; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZorJDZHV3S35zuqaxSThGm8XOeoTPpTjb5tz8dN4eJI=;
        b=vnohXErvbRTFxGcvKSHcS+oF4F1l5jxTpMOK/waH8+elD80s7/TuaRZ/5IVczZR9hh
         NzTFfbwZjqgBaQDwO/9uaE586R0D5UG0YnraBNCL1pq76EtGGOBUujI8Mnlul2m7u3bw
         bA8fM98rr5VCpBh5iytLfvgcARX8Kx2C/JZ/dVRmli+5TV0zzT2xfw/Bbwl4Xoarx+RZ
         DvgEmvV8OZ3Oo5l3oHc+9aHVPN+Lju9ioUR/+tQ27saD6Y3XOY9m/UNFjgrJXPX2M0xX
         XeS+YYZqOJaMeXZR8kxshUWwTWD7OWcibUj18LMXGDVY5NQtwShlp690hp9VwQKV1zo4
         eh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711119434; x=1711724234;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZorJDZHV3S35zuqaxSThGm8XOeoTPpTjb5tz8dN4eJI=;
        b=P4zvluAhla15HyurZRmvIa0pb9g6hL/yqGmviN1mTtg7Z+QCd/ojZc2wgGyVn0jGR5
         z2pMBzMETYkwGC8jQizvjxPwijZwgRNTexp9yU5yRhJ4+G3+Kv3AIbVU2G7GMyc1cXQg
         Tq3rItyR4XNDsg/XjmLyAAQGxVzzqLl4RgTYYOXfslSsY8a4IkPQzrXIEx/1PZLlumlN
         K71TbFb7AxGeYeIxzrzFIHWP2vB69rL+9rPQDWXbV7Rt/+3GHYTXRf7pio60UGO0R9QR
         fsv5wef3nT6G2LhSkzuoPvl9yIVh6IPbE872PAza1660pwtqznzq5QInzIqyxxCQcFcy
         MBAw==
X-Forwarded-Encrypted: i=1; AJvYcCUkyu9mPVndwc90+ryPw1JgnBM8Heb7HN/UNiF0hsF9VcOsJ8X9PN+eDcuAYL7D8PFcGf/7rD8sozR5qlzJXW1w8bHfxL0=
X-Gm-Message-State: AOJu0Yy6xamnyFruNasMYx3OaYGEwvhgrNREm9jckyhbFMMxMKVaEsy+
	60yDfSYEDBzJdjSr9W4Ufq6GUHDgztUQf01F7QcOTwHOHiDFmxM1lC2niodDAWQ=
X-Google-Smtp-Source: AGHT+IF7KOamQ/ZSV2W2kGIMahMBrt6DfYcXh8dFA2yNq70TGAUvTUROE3goyGZT3KN/zY040q01ew==
X-Received: by 2002:a05:6102:1789:b0:476:577f:aad8 with SMTP id je9-20020a056102178900b00476577faad8mr2952736vsb.14.1711119434492;
        Fri, 22 Mar 2024 07:57:14 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:10:d05::7a9])
        by smtp.gmail.com with ESMTPSA id e10-20020a37db0a000000b00789fc91dcf1sm816098qki.87.2024.03.22.07.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:57:14 -0700 (PDT)
Message-ID: <f490bd15fd8ee36cd3e759483bbcfb3288cace74.camel@ndufresne.ca>
Subject: Re: [PATCH 2/4] media: dt-binding: media: Document
 =?UTF-8?Q?rk3588=E2=80=99s?= vepu121
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Emmanuel Gil Peyrot
 <linkmauve@linkmauve.fr>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Philipp Zabel
 <p.zabel@pengutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, Dragan Simic <dsimic@manjaro.org>, 
 Shreeya Patel <shreeya.patel@collabora.com>, Chris Morgan
 <macromorgan@hotmail.com>, Andy Yan <andy.yan@rock-chips.com>, Nicolas
 Frattaroli <frattaroli.nicolas@gmail.com>,  linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  iommu@lists.linux.dev
Date: Fri, 22 Mar 2024 10:57:12 -0400
In-Reply-To: <2798331.BEx9A2HvPv@diego>
References: <20240320173736.2720778-1-linkmauve@linkmauve.fr>
	 <855507987.0ifERbkFSE@diego>
	 <70439a01-7949-46bf-a701-c82ba961171a@linaro.org>
	 <2798331.BEx9A2HvPv@diego>
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

Le jeudi 21 mars 2024 =C3=A0 10:32 +0100, Heiko St=C3=BCbner a =C3=A9crit=
=C2=A0:
> Am Donnerstag, 21. M=C3=A4rz 2024, 10:19:54 CET schrieb Krzysztof Kozlows=
ki:
> > On 21/03/2024 09:47, Heiko St=C3=BCbner wrote:
> > > > >      enum:
> > > > >        - rockchip,rk3568-vepu
> > > > > +      - rockchip,rk3588-vepu121
> > > >=20
> > > > What is 121?
> > >=20
> > > That is the strange naming of the ip block inside the soc.
> > >=20
> > > I.e. the rk3588 TRM lists a number of different video encoders and de=
coders:
> > > - VDPU121 is decoding h.263 and mpeg1,2,4
> > > - VDPU381 is decoding h.265, h.264 and some more
> > > - VDPU720 is decoding jpeg
> > > - VDPU981 decodes AV1
> > > - VEPU121 is the jpeg encoder above
> > > - VEPU580 encodes h.264 and h.265
> > >=20
> > > Each of those are separate IP blocks with their own io-memory, their =
own
> > > interrupts and their own iommus, etc.
> >=20
> > Thanks for explanation. Short introduction in commit msg would be nice
> > (e.g. VEPU121, one of two VEPU encoders). OTOH, why not documenting all
> > of them? Bindings are supposed to be as complete as possible.
>=20
> We have a concurrent series for the vdpu121 running at
>   https://lore.kernel.org/all/20240316071100.2419369-1-liujianfeng1994@gm=
ail.com
>=20
> I think not all of those encoders/decoders are based on the Hantro IP
> or at least at the moment we don't know this yet.
> Hence people adding compatibles for the blocks they have actually
> managed to run on their hardware.

Correct, on top of this legacy core, only VDPU981 (AV1 decode) is a chip fr=
om
Hantro / Verisilicon. Everything else looks like their own design and deriv=
ed
from their original rkvdec codec pack. We didn't name this AV1 decoder afte=
r VSI
brand as we didn't have the proper version information available, but we su=
spect
that is variant of their VSI9000D cores. In short, we tried to avoid docume=
nting
our speculation, even if we believe we are right.

>=20
> Bindings are supposed to be as complete as possible, but revising a wrong
> binding later is very hard. And the whole media part is full of binary li=
braries
> in the vendor kernel and has not the best documentation.

I agree with this, but I must give to RK that despite the lack of documenta=
tion,
their CODEC software is fully open-source and blob free on this platform.

>=20
> So I guess people are just cautious ;-)
>=20

exactly!

Nicolas


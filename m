Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CEF1FECB9
	for <iommu@lists.linux.dev>; Wed,  8 Jan 2025 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354243; cv=none; b=YFDM6kZ7ap7VwpWSqQPyRIodWWVkh3YDx6RTC8xRW2xaesPM+3t7HOPMoAlLsYDBqR2ktSxY10ycP1aXoMec0RBmOTcuECpk89H3r8oy0KCP6E5MuzNnyu+d/McHC10J3SIemhoX2osRekNHDv8SJJpruPd80Y1oWGLEFuQupqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354243; c=relaxed/simple;
	bh=IMcXXDdCAV533bHrMk2RPmqW4y8bePfWrlfqcCK5DkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uD8Dk1I2dlvO3R4HcjApAjXa8j6gOfO2bFDDF+3I1TB2XaYstCDCA7UPvcBVDXs8xdLwwYJRpK3KG6muCSSZN3cQfPB1tNp1BrTvWFViecAMmzs0jgrykEN7Dx1SwQm5NEYEf9bvzN4Q180dko+tQv2P35EQrWUbe+9QaKSBfjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0IeJaaa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0IeJaaa"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3862d161947so8114170f8f.3
        for <iommu@lists.linux.dev>; Wed, 08 Jan 2025 08:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736354239; x=1736959039; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oaZvubb6b/5Y65DKB0twQiviVJsKDAVdNYBE/1h2cAM=;
        b=S0IeJaaaVCj0662YPHl53cfU70yYJ+3B4i2HHtSF0+qRsM2cnrCBZRAv+hU0ydcenS
         IqtOCp3Jgv7KOvW7MqdVz8i/PNg47+amfoVkGubS2MnaFiniXm5lOfxqge0Uja278z6b
         PVZBSg/tIP4JjkW/XOaaEjKjnE4NT+5gwDcYa0925a7juhlwHUwaSdeLsPPKzpGoNsYZ
         2sApF8lFeYx0nA5mkezLtMKCSw0Om8cMG5E9Cw7TrkHn6udRDKg3aQgJsrnyrgvUZP5m
         Cnlf8hd39nUabc+AsFNUGqXGUJVznAyFj33VTcSDv8EKuOdKrsg7HOXHV8p8YbQnuvJZ
         NLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736354239; x=1736959039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaZvubb6b/5Y65DKB0twQiviVJsKDAVdNYBE/1h2cAM=;
        b=pNlUse1OsFvD0j8acVH4fxEChQ0ew4umA5tGintg/LMwIn8TJXkTFR2p/j/HFwyfo6
         PGijHM6qWfF0jlkXKqXQsJh7qbhXJhWupSavV3obytlBqa5o3ajqz+mjFVfodN2EXMM/
         9ce0fmFKPiWfOGsoxG4suqvPho6fWRzRNj+yGARd0a2/QKcb8dFfQ4eH/tJ5Ha6KOK61
         xcanrrQO8Mjo347ChQEeHvUSB4NnV/tkbUkvX4Hr1WTn2T9KXe+ySMzfq7FGNKwUsETs
         RDmwgU+UxcrFYljkq4fxlTDXHHNImXIBFTReHStUGC7TYphkdLl23QnQxjZHX0aiaOBR
         vnZg==
X-Forwarded-Encrypted: i=1; AJvYcCUEbT6EzPFR7fWwWGlDRXs8WX1s8UiNkfeMLjN1NCv5ZXUphJChhOfy+l+EThAmwT0ZktEPQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJzgJo2XXfsbHTf0OymWe8WGmA5Oe7FAO/6E+cP4XQIP7qAgKU
	phY2CZyn2MYJuatx1pHsHis9HLHpEf48o78vuWfCN0AdfHyQqGaYHiAZGA==
X-Gm-Gg: ASbGncukdJDjBSvRJYndTWp+/oLfr+bac9nugGmyvB5xaZmj7UMB7fHKWFMYEPXriTQ
	lAky+8CjwwJtrPeban2pdBh/9ltfIKuhHZpvYEAeiZUN/BSre3qXojx942nRgrWGDFzn0HuEWlC
	zD6smSZ8Yg7my97Cx2MiMhes7kYHqILxNZDE9eXT0hh6bpUkDS4SLlQyV7TRzONV0GoW5sUSEsp
	6uSTYSuAfrE4VxGPLMpKBezXIbIswrTeuAX6ng3g3lp7zU5fbcUMqlz57cAP002tzy8ytOk+w54
	TTrIdKYKnkZ9riRUDwQaH+b+8FcrpOo4k+k6BuyHL3g=
X-Google-Smtp-Source: AGHT+IHK2KDzhIt68MjkOew8+0ynFBPykBHBW0JWlGbcvjRJxnfeN213vuCJpkbuwwJfUjUouQWekQ==
X-Received: by 2002:adf:ae59:0:b0:38a:88b8:97a9 with SMTP id ffacd0b85a97d-38a88b898b4mr2057382f8f.2.1736354238605;
        Wed, 08 Jan 2025 08:37:18 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832c45sm52816674f8f.32.2025.01.08.08.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 08:37:17 -0800 (PST)
Date: Wed, 8 Jan 2025 17:37:15 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-leds@vger.kernel.org, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Correct indentation and style in DTS example
Message-ID: <6ugtusk3yhbr4rbuzompfb2apequpxtdpy3zk3xmrhowpne3nw@2h5cvtpd6qsw>
X-NVConfidentiality: public
References: <20250107131456.247610-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3vdnth2dvkpxqrns"
Content-Disposition: inline
In-Reply-To: <20250107131456.247610-1-krzysztof.kozlowski@linaro.org>


--3vdnth2dvkpxqrns
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: Correct indentation and style in DTS example
MIME-Version: 1.0

On Tue, Jan 07, 2025 at 02:14:56PM +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
>=20
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> This applies cleanly on v6.13-rc6 and on next-20250107, so I expect no
> conflicts between Rob's tree and other maintainers' trees.
>=20
> Rob,
> Can you apply it to DT tree?
> ---
>  .../arm/arm,trace-buffer-extension.yaml       |  10 +-
>  .../bindings/arm/stm32/st,mlahb.yaml          |  20 +-
>  .../bindings/dsp/mediatek,mt8195-dsp.yaml     |  42 ++--
>  ...ntel,ixp4xx-network-processing-engine.yaml |  52 ++---
>  .../bindings/fpga/xlnx,versal-fpga.yaml       |   2 +-
>  .../bindings/interconnect/qcom,rpmh.yaml      |  28 +--
>  .../bindings/iommu/riscv,iommu.yaml           |   6 +-
>  .../devicetree/bindings/leds/leds-mt6360.yaml | 195 +++++++++---------
>  .../devicetree/bindings/mips/brcm/soc.yaml    |  42 ++--
>  .../misc/intel,ixp4xx-ahb-queue-manager.yaml  |   6 +-
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml |  78 +++----
>  .../bindings/mtd/technologic,nand.yaml        |   2 +-
>  .../bindings/nvmem/amlogic,meson6-efuse.yaml  |   2 +-
>  .../bindings/pci/ti,j721e-pci-ep.yaml         |  34 +--
>  .../bindings/power/reset/qcom,pon.yaml        |  62 +++---
>  .../nvidia,tegra264-bpmp-shmem.yaml           |  15 +-
>  .../bindings/rtc/renesas,rzn1-rtc.yaml        |  22 +-
>  .../amlogic/amlogic,meson-gx-hhi-sysctrl.yaml |  26 +--
>  .../bindings/soc/qcom/qcom,eud.yaml           |  38 ++--
>  .../bindings/soc/ti/wkup-m3-ipc.yaml          |  32 +--
>  20 files changed, 357 insertions(+), 357 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--3vdnth2dvkpxqrns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmd+qbsACgkQ3SOs138+
s6HTwg/9FTrBpsyb2c6RxUphewMFJvl+V6nLpfbmnIG7/hlhP5n2Rosba8pnC16d
JnflQ606ls+DtDBqIImY3LYZcPjcRx/ddXj/H3o2NLFsbbTmOKGEJ6SPhi/YR4Is
AFQMkKbLiMldJyCEH9X+NMmIOEGN44f9eHb6CSpLTAsgPYi2Ppi20vtS+ktX2N8V
9hoO0I8YspPvsj3TqOf1vzPMM9aEb7L6norpLMW8MMIWnkUInUhW5gyxs/OPNma4
OJs7ev/OrjPkBxACJwgiLtBGTVJR56080XgSm7GRqVMnR6NhOGMN/g5x/rrBjy0F
5gprsK059F7h3/oyI5Wn315lnjP9VPjC0OIF08WHRlo0c5zA8TDKYQACT6obPHUh
04nYCErIHSixvHlX91uKHGhfHA79vbttEXCIwrXiuUVOTcoMZBGCzv9njLBIoPdl
v5wzOIzZ+V66lAbWRGTjMcRjO1bx0vM+QpmHvjlEQubggzHG0csIRQB/68wk6min
F+kvzSh1aTJkTNUOYn6BBtbzqjCf8y5NHidBSXBWXhP308OXkwy7fUGqIfrIny7T
41KrDRyFAMooM175JQmuMExgOcRi6fGKmvKQ0MXsNR4FTt9NZ5rvTnkxi1qH8uWv
68sSPZB2xOA8iPax09mEhKUKuyYQPa+Ue1EZlHtc75XMisXE1SQ=
=bVty
-----END PGP SIGNATURE-----

--3vdnth2dvkpxqrns--

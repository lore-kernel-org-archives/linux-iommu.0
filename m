Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4E221F39
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768567448; cv=none; b=cwhiF6MvebspO6WTAYTckawLP01QOBTWi9z7iSa38aNuQzQav2yNS5XceGFQFVfnG//k0OTQZYDxw2isPqjn22QppTjuNDEk1VACvOUCaUf3yPFy56UZdXUjex9XJoeImdSNMzY9AaRLNaMauQL+4lJIX90GBogEHE9meaAMdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768567448; c=relaxed/simple;
	bh=b+D73NJzR5tkQbyHArcS0qpplRGo9n9mhRHkUIUu64E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paTw3YvIZWSvUF7oZx7UuXYRfxw9psT7tWnHFxQ4FSJHzYH1naz1qRUdm9N/f2Zqkay2H4Pk4SO2KAv3dUjz5hbjoumAiItlAIsl5SQNBA8MIX36kHI/M02GjPx8Y2FgoE4aAS29PVHMIkAHBZwyxaMymRZsUuYr1SCurXXry1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWUSBXU7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWUSBXU7"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso13601245e9.2
        for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 04:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768567445; x=1769172245; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZCf9q4Eq3f7Zk60HL0G320nGRoPqD1TASM4Kn6lCNs=;
        b=UWUSBXU7ws0KiaD6upRHZf6VWRjgNgimbasetRuHwYM3zWGozdLm6qY1iU8t2tt2Lb
         x1SNpQfhLIRumks6hE7RRQlhGei/SzjIUXTPxOapHPzbbcc3qhm3/6CUy8JIl8iAqBgp
         AaGOX0y/h7bQShPnPoHjmf8Kj7N5JibM5b5f1x+eVtydYg+RY65brVFdEoMV+n73aCNI
         neB2muvKbc6WifHZ00sGKmMlgIhPAk+TmMz9AVdTtSBQfF/WvUq7KWOVFoimWy6YlC05
         ccXeRzuweBVKgtmUrUmKDD84ZW3X4bFWvg4lWs/4B55HS/fM7fnomD2eyA4cuqIv2Bgh
         zLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768567445; x=1769172245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZCf9q4Eq3f7Zk60HL0G320nGRoPqD1TASM4Kn6lCNs=;
        b=d+ew5f681weGU7HiSAizYUqtDT5QIb6ZssimlFAAWRgm/2m0bjNIp2zorxO6DjqhHR
         g08xiw0/+LkvwjnPhGlj150VrSDDRTFUX98/Mvgg21atE1h4MPZR5ogDmlcgKD0UuTmN
         h6n7DvC6iDmb955R+2iBwjSVcWJN1xdS21AHdT+09aoXUx8G2KQbw0LXjQ4hVTOI5gpa
         Fhj+4tX8n/0eoXsE8uNHWAJZk2xsU9bN2iTqgoEU9HOGsgMzW8jnFRiz/7oGGG/6Vv+n
         HEr42VH0Hl9FFCWwpTobP2Whp3sePat1tlJJhmFmzfsLyUdm2elTDnjJqnF43SDiVyNM
         IcGA==
X-Forwarded-Encrypted: i=1; AJvYcCXf6gMoF6in4r2cUj79+rCn02aKJ2FukBPaEplk7n/ZfvwqgIzC/mi7I2MqhWOkldzV8kq1Qg==@lists.linux.dev
X-Gm-Message-State: AOJu0YziDTFcteVkf6CPUQYYGMqJKT9boJlBeTNjTFohTKr4Aj+6jn8a
	OTHDiNUavJBMp0IHXf8+k0FKCnowWnNaKVKE3cGZJK/yxc3Bmcjra43+
X-Gm-Gg: AY/fxX6CvxxOWMnn4WtxKvjx9k3lXexqgOhPIS/tbrFbHlNpFLpRAmMsNDkQkBTtk5x
	aiH0ezuQJG+hTF3vBQQb6jdwth1TOWdRmtpEgQa/yq/ax6E86ooFWqrwgALsgLMe42i/soB0mLC
	PEz+dlOUfFjNtrAoId8D0gEQiiJLiK/XrPpKuEBppJeCL4rSt8SYolEaeACihi2FHDWqohwOMBV
	TkcT+sG9G/RnUin2ql54LGO06Nl99A4zuJQqEARKBfeMjPmQeJGeiSedwtGth8xLDkpjGN30NP8
	Gho6CEngiSl+Aad1JSZ65LNLpzJpM86Z5UOHb0817mKLMJOSryjoCQQhEpCIrcYmqib7pfk3Csz
	Comc39tStRYhhxfdlPvx9QbCHtMszimRJOj6oS6qefuPZbPV/gD5ZGXn/HSjwawKApDouVGdEcK
	ZMO3qOmuOlUukaArTIZv1WjCcIjj2giNmqdW1veprRkVxPRe6az1XEGXykVinLMGsJGhrBBIB+P
	g==
X-Received: by 2002:a05:600c:8b56:b0:477:79f8:daa8 with SMTP id 5b1f17b1804b1-4801e34307emr39892975e9.17.1768567445526;
        Fri, 16 Jan 2026 04:44:05 -0800 (PST)
Received: from orome (p200300e41f0ffa00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:fa00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e886834sm42518255e9.7.2026.01.16.04.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 04:44:04 -0800 (PST)
Date: Fri, 16 Jan 2026 13:44:02 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nicolinc@nvidia.com, 
	jonathanh@nvidia.com, vdumpa@nvidia.com, jgg@ziepe.ca, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V8 3/4] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
Message-ID: <aWoyh0e2ncSsNW9y@orome>
References: <20260113054935.1945785-1-amhetre@nvidia.com>
 <20260113054935.1945785-4-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uf7gopu5xawojzkn"
Content-Disposition: inline
In-Reply-To: <20260113054935.1945785-4-amhetre@nvidia.com>


--uf7gopu5xawojzkn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V8 3/4] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
MIME-Version: 1.0

On Tue, Jan 13, 2026 at 05:49:34AM +0000, Ashish Mhetre wrote:
> The Command Queue Virtualization (CMDQV) hardware is part of the
> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
> virtualizing the command queue for the SMMU.
>=20
> Add a new device tree binding document for nvidia,tegra264-cmdqv.
>=20
> Also update the arm,smmu-v3 binding to include an optional nvidia,cmdqv
> property. This property is a phandle to the CMDQV device node, allowing
> the SMMU driver to associate with its corresponding CMDQV instance.
> Restrict this property usage to Nvidia Tegra264 only.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  .../bindings/iommu/arm,smmu-v3.yaml           | 27 +++++++++++-
>  .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 42 +++++++++++++++++++
>  2 files changed, 68 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra2=
64-cmdqv.yaml

Applied, thanks.

Thierry

--uf7gopu5xawojzkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmlqMpIACgkQ3SOs138+
s6F4CRAAs/LaZnTRigpuhM/Lhm5MOiVhksuu5bLPcQ++2uSJQtflBIADQkopKC3r
xfOY31m01LUKx75CeQGi7ekB6+wgtvMbIpX1Hr1caTIH3MLxrkgOumZJHKyclrYZ
vl3Ztc2CdmzUwSOXvNxtH/HwIzTXPOfMme+eBDZjT2iV2BxNMJc2KPuFI0HruduH
B/QqVO8FLcmIvPGqtneO8oaXtF/xrxiUojjxPdJmVNxUvdl/EIDf+VvQcEnhR+P0
YYFgMfEk493Vhi/XMhXAg9zKwm+1yhoC7vXdklGW8IMezknR79HxrzjXx/Z9DUK6
YFhItt0501jfhq+dqNWl7NaYDQtm/b2GxXHQ//cN2N+jEUSJDxbEec8YRPFJVlTL
+dlwu3GYvSatPHYP9tRzGuq13EK8EXtH9y5XYxl7+K314jo1kfv1YE/Acjva2hwu
kycXUDVl3ryPFeJuZX41H5jDGtbkh+cWdfm2hDdhwR93xBl4gMfQ96krMNwmfCJn
g1aIIQJDGg91F+17Bc4TkCIEscdp9026BmBJ8XzismHOM/uFw0hB+K4+dAX1TpvL
7uNCBSgP8MoXEN1i0tCaSq8N9zXvzp59DoCM99F8tpg8JLHR/oD3nYfqNS7rNwQn
JI9Gam81/Bg1MWrwgwqtKlN+oi3k0OvZfFyIEzEyavI45jDBk4k=
=ntP8
-----END PGP SIGNATURE-----

--uf7gopu5xawojzkn--

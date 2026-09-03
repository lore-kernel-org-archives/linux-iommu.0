Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0A36604B
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457016; cv=none; b=Z12kmFL83D7ZU6D3+z4ZD+l/fPT561i5VSdIDR3ttq4ZTvtjPpBZXuQesLbx9eZUgLlYzdekqH3wqoRx11mA7lvK5lYwHUiciUgqw6yCeY72dmA1xz2OqxRSp/KkJerdgevSjAHaleSlb7O577x4ZnrDdnsXrGsYJFUNkwMS2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457016; c=relaxed/simple;
	bh=9vVYNkg365ZBN2v9CaKO6rgeacfMt8Z2fEwZgvgMjlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MD1PforwVgZO6qAr1KCArqOEJ/1YeL7NWcvBAnqk46xxIYCJkFOR2N9pVmjGgzcw4yYAvT0NVoUtI0dMsmcJf2JmvTM879oIj2nkFR6cV6jgbH8QZgfq1xtIWC+U2JblLbtBIf9TwZ/ZV/0Nox8G49GDXA3P/OkbM/PyyZPHhBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TEysronw; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TEysronw"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-398a5aad413so33226a91.3
        for <iommu@lists.linux.dev>; Thu, 03 Sep 2026 10:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788457014; x=1789061814;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w2Aov07r6Jwf275OvFRY1wyNlBWFC331fRMJS+I0Mp4=;
        b=IXijLUv67IvegBgWOdLqSWiMpmcXzdsfySIKaeAliXe2jLuZlfUOnZ/TG5Zb22V6ns
         f2AAxjfuEKOtZR4MdyksYpvVMMrLUsHJEXRVOhHqsbG/AuvKYUEbqBTlYz25Uadhh/sh
         bnHUcXdPn009yBrPJ7LloMTPRlrqaejsb3d2V8Iqun5RYovlTsGU7KsnBt4OqUrPTQJ2
         ZQRlwBrJvswTTR3kcXj3+j8elso34Vo8RCal4c2PMQZ/4Ehg9Yy9r4sMwK8P5asa0sUc
         NSRtB9R+ob1XNxsBRDDn87wp3uj8l71JZm4Ld12/dhe2q/eCA1qguWmN0A0TkigMqQwt
         j63A==
X-Forwarded-Encrypted: i=1; AKwUvBxOg6JfZsGFf4Fraf0yKbNrQd5Oj85R0hNqbEPXGSUHWVfeZsiyInR1GRgDj7+wkfdhZXuRUQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nWoyrhPZw6IwsfihUnzTeJfofWYe0J53PsgeCWybPk3vIMXFJe
	VaWdjp1WcA6WnsE9JL2yBVzbNsErtaLF1mnHJv1fuPvF6ZkHs7l6zGyEhs9WHHCglrZF59LMxro
	kSP+hB1L7SUQ1GR0n63d6iTGGhkrblz3nJyl3fZ9CMVSaeKdMmPsN3VJK7sERrdB+UVhx9TKIbK
	NLgzDqLJjocPEnyoj71CVYbAkSKroDU6FKLfz7+O8s7MRr7qR41utOp+J7J1vNePw3aBJZXu6Ir
	z4CNnK5Tyg=
X-Gm-Gg: AYBFou2jcJYNwdOueDEdUb6U5QBDesGQTAQqM5HagR2bd3uF4DmzeWVq/cUtfR8hUPL
	dLOeCRplQNQ5C0FCtAx4aI1C3rcP2hqywW2GHn/eVKGPPjOkB9P+fDHloaTOw4NQzRm4OzhrxnA
	6GuDlXHprrI+smdLz2xmGkSXRORitfcd6swzdYfXNXl3H9+4jHRY0VPiC2vg4UcNBOant2kcIGQ
	xy8I9SHbU0VWj3IMoLDUlKjKgEcgZnxWx6c9d5Tm655giHypvn0O+F/O6PKES/VJrsCDmWIlFl1
	tRoiDIVSMakKFAwKBVmVrZV5HRE6to6WyZPktZ+QG/jGzAM4aezT5E1rG/1ybhXlhc7NYxp2TE9
	LmdOTnWRBKTozaLZ5HEpd7qF9JDkGb05fbn6/We4bBdqSAZMth0KS4ly7q4xg3JWs5SPIaIRizH
	Znkwmug2CyuJ1DXhpAdozxLnYRXmo6XfAr6d1i
X-Received: by 2002:a17:90b:5243:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-39b2614df1emr146644a91.5.1788457013436;
        Thu, 03 Sep 2026 10:36:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39b160990basm1302424a91.8.2026.09.03.10.36.52
        for <iommu@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2026 10:36:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2580a59d0dso4752166b.0
        for <iommu@lists.linux.dev>; Thu, 03 Sep 2026 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788457011; x=1789061811; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w2Aov07r6Jwf275OvFRY1wyNlBWFC331fRMJS+I0Mp4=;
        b=TEysronwnKEktE3beS5UJPbM6JaQZkMtIpWRPBBcI36a1oY1qd1KeEsnif9LQWld2H
         SkuvONeTet4VsAzdpFa/vtYFmliJsgTqEjCBnX7pkBZ7sTB/PXwNv43E6J1q4dS9dZbl
         /v2U+SDMlBsJygN30toHJA3chvPl+wCSP1knw=
X-Forwarded-Encrypted: i=1; AKwUvBwZmoqsy4C5EvfXakPXi6LM/kEeS7blX4gkjWt6/v3a7G+BYd42IqvAQKxs0+2iyt301nQH8g==@lists.linux.dev
X-Received: by 2002:a17:906:4fd0:b0:c25:1a5:62a4 with SMTP id a640c23a62f3a-c260ca1ed90mr19714066b.17.1788457011130;
        Thu, 03 Sep 2026 10:36:51 -0700 (PDT)
X-Received: by 2002:a17:906:4fd0:b0:c25:1a5:62a4 with SMTP id
 a640c23a62f3a-c260ca1ed90mr19708766b.17.1788457010559; Thu, 03 Sep 2026
 10:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260902-bcm2712-iommu-submit-v4-0-9dbb657578c1@reactivated.net> <20260902-bcm2712-iommu-submit-v4-2-9dbb657578c1@reactivated.net>
In-Reply-To: <20260902-bcm2712-iommu-submit-v4-2-9dbb657578c1@reactivated.net>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Thu, 3 Sep 2026 13:36:37 -0400
X-Gm-Features: AcwNN1WO37iCo5lJmw0oA9Ue67-E06_V_rh5wuozhzpJ0Sb09NLYr5P6ip9-VKo
Message-ID: <CA+-6iNyAU9uw1QyA8TaBWOvhWuxe=DdbeEzoHgM9Gk3TSsSccA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
To: Daniel Drake <dan@reactivated.net>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	nick.hollinghurst@raspberrypi.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000dd2489065a979817"

--000000000000dd2489065a979817
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 1:58=E2=80=AFPM Daniel Drake <dan@reactivated.net> w=
rote:
>
> Add bindings for the Broadcom BCM2712 IOMMUs and their shared TLB cache.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Daniel Drake <dan@reactivated.net>
> ---
>  .../bindings/iommu/brcm,bcm2712-iommu.yaml         | 54 ++++++++++++++++=
++++++
>  .../bindings/iommu/brcm,bcm2712-iommuc.yaml        | 40 ++++++++++++++++
>  2 files changed, 94 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.y=
aml b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml
> new file mode 100644
> index 000000000000..5ca8ce469ec3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/brcm,bcm2712-iommu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM2712 IOMMU
> +
> +maintainers:
> +  - Daniel Drake <dan@reactivated.net>
> +  - Florian Fainelli <florian.fainelli@broadcom.com>
> +  - Jim Quinlan <james.quinlan@broadcom.com>
> +
> +description:
> +  The BCM2712 SoC features multiple independent IOMMU instances providin=
g
> +  address translation for multimedia hardware blocks, such as the VC6 di=
splay
> +  pipeline, camera receivers, and ISP. Each IOMMU has its own page table=
s,
> +  control registers, and local TLB, and is additionally linked to a cent=
ralized
> +  L2 TLB (IOMMUC).
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm2712-iommu
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#iommu-cells':
> +    const: 0
> +
> +  brcm,iommu-cache:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the shared IOMMU cache (IOMMUC). Each IOMMU instance ca=
ches
> +      translated descriptors in this centralized L2 TLB cache block and =
must
> +      trigger cache invalidation commands on it when updating or unmappi=
ng page
> +      table entries.
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#iommu-cells'
> +  - brcm,iommu-cache

Hello Daniel,
What are your thoughts on allowing the iommu work without the cache
property, ie having its presence be optional?  I work on the Broadcom
version of the Rpi4/5 SoCs,  and  (a) on certain workloads the cache
slightly degrades performance or (b) on some chips there is no cache
associated with a specific iommu.  This is probably on me to implement
these possibilities, but I just wanted to give you a heads-up.

LGTM

Regards,
Jim Quinlan
Broadcom WCC/CM/STB


> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    iommu@5200 {
> +        compatible =3D "brcm,bcm2712-iommu";
> +        reg =3D <0x5200 0x80>;
> +        brcm,iommu-cache =3D <&iommuc>;
> +        #iommu-cells =3D <0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommuc.=
yaml b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommuc.yaml
> new file mode 100644
> index 000000000000..47c584ad667a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommuc.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/brcm,bcm2712-iommuc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM2712 Shared IOMMU Cache (IOMMUC)
> +
> +maintainers:
> +  - Daniel Drake <dan@reactivated.net>
> +  - Florian Fainelli <florian.fainelli@broadcom.com>
> +  - Jim Quinlan <james.quinlan@broadcom.com>
> +
> +description:
> +  The BCM2712 IOMMUC is a centralized Translation Lookaside Buffer (TLB)=
 cache
> +  which accelerates address translation across the SoC's IOMMU devices. =
If an
> +  address mapping is not found in the IOMMU's local TLB cache, then this
> +  IOMMUC is consulted as a L2 TLB. The SoC includes a single IOMMUC whic=
h is
> +  shared between all IOMMUs, and it must be explicitly invalidated when
> +  modifying or unmapping IOMMU page tables.
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm2712-iommuc
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    iommuc@5b00 {
> +        compatible =3D "brcm,bcm2712-iommuc";
> +        reg =3D <0x5b00 0x80>;
> +    };
>
> --
> 2.55.0
>

--000000000000dd2489065a979817
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
P6nIShznyqOL2EoCa0IXujxvXUo0pANFYsDhrCVF5JOVPeEL3Y2m+4flRtOI+YlRQoepb+TEVdkY
/g1rlWG7GIYrtHxrFFRvn2/Iqqpv/x5kzJgoTYFOyTTGlXIqGkKTqCWFrN09kJWzhhmxhxtJprJs
KveDLF8yhHSbqmXfKTkT+CIrynXXDro+80qXEXC8CM9W9d+2lDDM+hWTlC6Pt/ikMYf/ZB4K2Nr8
VFruDYGZfAHhh9/lqK3SpS2Z/8cB88K62U+Eb1yNAgMBAAGjggHeMIIB2jAOBgNVHQ8BAf8EBAMC
BaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKGOmh0dHA6Ly9z
ZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAyMy5jcnQwOQYIKwYB
BQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMzBlBgNV
HSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIwNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wQQYDVR0fBDowODA2oDSg
MoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCUGA1Ud
EQQeMByBGmphbWVzLnF1aW5sYW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQiuRLoBkhIaas+1j3yf23P
ffVFcjANBgkqhkiG9w0BAQsFAAOCAgEAp1y0fznw9Uo7UzExANVpYjj+OG1c3C7MhWOvAd7LvfPX
BSFisMaabop5Pyfc/sWzb/jCNfVkkDW5Ij2mzpUsUca2qpILoFhOUT9b0d+nc48MCZ4/Wj6vX5QJ
i9VdYeuv3DYASZsQdH8iYnV5X5YCYo1AO/pyW+M4gG022Nsji9+3A9zkx8JRPDIXkPaDLrzcGD9L
rEVIYnnSK9b/4VHzITVgEmSsUTAIzOD6M6TzgrSoJZFmKNMXlAqo+m1nlNyJkM4OyOvaDx5y+2hA
mp4tzD9gJNU9TzQpQRZFz53+c8BkCpzvcHqT8lMluRlCrIYWqaSOUDHX9HPYvzbtO4iYV+irMdGN
2PBz6Wtfaoi1xTfFSKK9ON1mvxACK+E4B5gycSoZcOBADTbGXLDMqiygl7Wz0oooAPqZpUnaD1nc
x/pX7N8Ff6YK+iN3vVah34vLkE1CMFyDQMtyTCzQPW+7XCTxCL9ML3LBAF+eNAtKpPOsrGIdRHy5
6oQr+2ZquSMvWj447q4v3sk1LHs7ata+sP8/kmcPKn3WPXQ/4xMevqFVyv2VIFrBK9ZnOZ//fz8R
7SjJ7t2kOITvbWcMkizMc33S9hfmYiXaVTjIi89NiO3EXCJouYShpptgGNG6mpYHcddnfdKiILOS
06KlKNuHO4IpRmaGrzcDjsUQQSn8amMxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgwHM7pH5w7o7Qb7yXUwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIFMV
o5hS0DDcFFymAnqwogOvaV9pgIoyUXi5QGwpHtP3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDkwMzE3MzY1MVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAIzWmrBxBmtqvJ5fvCTDX/aWzJ6BL5gam9b2hTUZ
9nJipfJH7zY0ySmtLtTH68YaRM6qBrQrK26GOie4J25KBfJdB0TNg76LvAqJTuVmmxmJYrHYR9NG
JXykSfh2rK1tzyAiUgMqUoucRvGIcqj8MnIszqG9zSfv+dA0sqflE0PxNpUltusbCI0YtqfW5kW3
XrKMCVHj3XYikNzEaBQY5EpTkXmmH7T6T83xNLf78cSosCvv0wNdn/PAuG1l1ylqrXVZZgqGcauD
rlxsl+KQrXq/YDZWi0bW9lFXg1ax2y1KM4LN7ac4E54UFP8pZuV+pLlpgbFvI/6RRHnpT5Uu+N8=
--000000000000dd2489065a979817--

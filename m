Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1A1A8C3F;
	Thu, 20 Jun 2024 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878660; cv=none; b=juT00rO+1D1YgaT0mDzZqDe7IVWpCDHLpLpBUdwRUpnBNXhmXykbJnrE3G+xJPNyPLdXv0koyrRR2U7QZ94GfvWeanFv3/NohIoLbuRnB3yRgA0NOLXhTRVu2ijMqRWQtM/Pvz7esD7+G6uND2276OqNe5z3gmREdH50RzflHik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878660; c=relaxed/simple;
	bh=h7V0DxoSMVHG8VEd6s7x6wFAS8w5u2rt7fpd1rRse9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g32HeyOZLdAH3ZR2wnHMGa9smfnjhBmafsBZSQWeaMpqW8KDYt9xb6grjCXcHKNLA4z0mcPiycvr2C4JpgwxdvN5wXSBWKKw0BsRfcd7AcWXiXRg1/5D0XD//UabG7X6bIcgWQyj2xyGS6ornyOIvmO9Zv5BBUX8ozYzR44+G60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5295e488248so878232e87.2;
        Thu, 20 Jun 2024 03:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718878654; x=1719483454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bf8vNA5yuOytQH9oqGaxBvwD+CmbF2hsnog35+f66vs=;
        b=c1Da/w2SlROrEfayLcsEF283Nq5ylEGgI6LChl7Vhcyj2MkI9kMp8Ho60c9ZZtQqCb
         8UsYrRigNEX9J/B8e33VbGTVjcTW48sDXCML0CytauvESKZZbAWTqEKcwLJhyrsC1UWq
         NgyMolirzlO0zUxoFa8QbjYedMZAiSW1XV7rSmcmeOtmB2JAGz6AqXRNL6zo7IYj219S
         qP2taWOhy+xd0HXn7SOuX7ZinGaVVxA7vew731VsG/zokbH2dFI+HdhEbS8A5gldWqwp
         XRZ75dFWQrvRKRFJD+FK4SoI+IxX7s48Y+AUy9JF2jD4TCbYGcpHQVUPO7L6VhO5ukbT
         IfWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLkjTb0GKx9ivzlcwN2/T2icz+xRU1nU8fORT9rkNrgQslhVgyNAeffJrKQMdaws8DuVJw+xv1Wfqfdrz4IcQ7Nrh/FoCsbJxC5FMxa1LPNteGfRWhEROYCMuMhyfkpznl3g==
X-Gm-Message-State: AOJu0YzC+qDmf0g3EiFsxeP3xaat+Oec0Fww0VyY1L9Y0jlN3sPEwDrN
	ColZhR2GQkfCf+O8nR6l4gCr4nxKorWboygTAB5znWAeGhdhb5dZCjfXJRB0R9U=
X-Google-Smtp-Source: AGHT+IE4tyOFfBCgwv6PClEL/jO25mQauscTQyN5xPYMofFdSZH5Jqpzl3Ao1LCO8lBauQ74cGUZhw==
X-Received: by 2002:ac2:523a:0:b0:52b:c23f:9451 with SMTP id 2adb3069b0e04-52ccaa373damr2519686e87.38.1718878654318;
        Thu, 20 Jun 2024 03:17:34 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2825711sm2008343e87.21.2024.06.20.03.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 03:17:33 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso6592061fa.2;
        Thu, 20 Jun 2024 03:17:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtM1FFC6iklrbsQeOqLDXOltU9KnhDU0fl4N8etrXQEIDbLF2umgcR4yDcEDo3GXVliXgVAmShNzTn9YlejlR2hCtLc6z4cJlJUIh262cFOeANINhiYzPprSkQvcVuub5YnQ==
X-Received: by 2002:a2e:3c18:0:b0:2ec:3c55:3056 with SMTP id
 38308e7fff4ca-2ec3cfe174dmr28682841fa.44.1718878652049; Thu, 20 Jun 2024
 03:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240616224056.29159-1-andre.przywara@arm.com> <20240616224056.29159-4-andre.przywara@arm.com>
In-Reply-To: <20240616224056.29159-4-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 20 Jun 2024 18:17:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v65-tPgwJW4Yy80nBBkFg7kvtu_50Skd_ZF9gSFNAJzbRg@mail.gmail.com>
Message-ID: <CAGb2v65-tPgwJW4Yy80nBBkFg7kvtu_50Skd_ZF9gSFNAJzbRg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: iommu: add new compatible strings
To: Andre Przywara <andre.przywara@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>, 
	Philippe Simons <simons.philippe@gmail.com>, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 6:42=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> The Allwinner H616 and A523 contain IOMMU IP very similar to the H6, but
> use a different reset value for the bypass register, which makes them
> strictly speaking incompatible.
>
> Add a new compatible string for the H616, and a version for the A523,
> falling back to the H616.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  .../bindings/iommu/allwinner,sun50i-h6-iommu.yaml          | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-=
iommu.yaml b/Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-io=
mmu.yaml
> index e20016f120175..a8409db4a3e3d 100644
> --- a/Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.y=
aml
> +++ b/Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.y=
aml
> @@ -17,7 +17,12 @@ properties:
>        The content of the cell is the master ID.
>
>    compatible:
> -    const: allwinner,sun50i-h6-iommu
> +    oneOf:
> +      - const: allwinner,sun50i-h6-iommu
> +      - const: allwinner,sun50i-h616-iommu
> +      - items:
> +          - const: allwinner,sun55i-a523-iommu
> +          - const: allwinner,sun50i-h616-iommu
>
>    reg:
>      maxItems: 1
> --
> 2.39.4
>
>

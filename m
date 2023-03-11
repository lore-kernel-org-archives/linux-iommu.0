Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4E97B
	for <iommu@lists.linux.dev>; Sat, 11 Mar 2023 13:53:43 +0000 (UTC)
X-KPN-MessageId: 07fbba2c-c014-11ed-91cc-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 07fbba2c-c014-11ed-91cc-005056994fde;
	Sat, 11 Mar 2023 14:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=subject:to:from:message-id:date;
	bh=ALu8+PmipZgEw89/BHca117Pe0D8mE1E2egBqYsyknM=;
	b=sjrN4u6wyciZj9Su2klp6z3W5MCqUI4mPWTKfBbjNphlQpEhkPS4wh3rIecb3c9eaUJOuWTNt1hov
	 H6aOeQnqLPd+q4DWPnyS3wPBhj9sLhJheCwDHM7/i8vxVeFWNVE6xEa+cl0YinRNOHZiH6oUOAqsP1
	 Hg0l7NZdPp8ea5f/8s9lBOa4tk4+DEbmNvAtT4uVOZskqqgXIfdUmNDYgoA9Z0efxAVR1/Zqzgogsz
	 g9ahkxaNZmgg/59ZUTxRRG5crdRNv4pztZGVwXqjc4HZ2TljAjTu7HWhWrmZJOv349Lhf/8DRBElL1
	 QyC0R1je529u6l/iY0dII4zJt815itg==
X-KPN-MID: 33|VMtRr8A7spxYaBX6YlEci9XrlWDUmmIYGebVH5TkcyTisB5tkpzSAZc1l3g947k
 GmoE2OYFIfwA6A5NxaH5tNnosy8GNrgIb+RWPh4xV4/U=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|kZZ8dqbp5Z6By5V/8lQMaupPovkbLuGHIJzRTJ7QFsjhtZ3+Snv1SYpmNLmvJAg
 kXcXwGJ6a9eCqgA7x4IvYVw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id f8a10bc9-c013-11ed-9d31-00505699d6e5;
	Sat, 11 Mar 2023 14:52:33 +0100 (CET)
Date: Sat, 11 Mar 2023 14:52:32 +0100
Message-Id: <874jqrcs4f.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Sven Peter <sven@svenpeter.dev>
Cc: marcan@marcan.st, sven@svenpeter.dev, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, alyssa@rosenzweig.io,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org
In-Reply-To: <20230311133856.63840-2-sven@svenpeter.dev> (message from Sven
	Peter on Sat, 11 Mar 2023 14:38:54 +0100)
Subject: Re: [PATCH v3 1/3] dt-bindings: iommu: dart: Add t8103-usb4-dart compatible
References: <20230311133856.63840-1-sven@svenpeter.dev> <20230311133856.63840-2-sven@svenpeter.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

> From: Sven Peter <sven@svenpeter.dev>
> Date: Sat, 11 Mar 2023 14:38:54 +0100
> 
> This DART variant is found in the t8103 (M1) SoCs and used for the
> USB4/Thunderbolt PCIe ports. Unlike the regular t8103 DART these support
> up to 64 SIDs and require a slightly different MMIO layout.
> 
> Acked-by: Hector Martin <marcan@marcan.st>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  Documentation/devicetree/bindings/iommu/apple,dart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> index 903edf85d72e..7adb1de455a5 100644
> --- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> +++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> @@ -24,6 +24,7 @@ properties:
>    compatible:
>      enum:
>        - apple,t8103-dart
> +      - apple,t8103-usb4-dart
>        - apple,t8110-dart
>        - apple,t6000-dart
>  
> -- 
> 2.25.1
> 
> 
> 

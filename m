Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC4143F8DF
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661189; cv=pass; b=kX57nG6Ld/XrPKn96rps535ZqqWCihDYRVQYenFpmHBh/YayHt8/pGuz19FQq+UT6M4pROHDM3mC1yB9SM8W5VaBGdhf7GFCMW+fc3Z6LZuF4PfZoRqYvcuv2VGTm8m9nOr+bA9OFbGk62zuy7GRFy1fjXXBjjVLApHxnPOY0pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661189; c=relaxed/simple;
	bh=NGrK7unDAm/B2x/Ykw7H2riNy8GEYeiyVELFClUTNpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIspL+Mf7hz3l51HUwFsG5wIVxPe16Sl9arHiwbc6hgyWqpxWy0unobY1mehuy57jZwO97GcObKFt0f7bp+oOZDj5s4aTrfzr5uxHScEKSwMi2Fpt38qIqePySeGu+4NvtD/QfomukbG2gyvn/hLuK3BvmNW7Sq5zEH8txw9044=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2NrGxkE; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2NrGxkE"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-85630eea63bso368607b3.3
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 05:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787661184; cv=none;
        d=google.com; s=arc-20260327;
        b=SXOjOEz5eT6cOzYadCUBWCttLIDnU2mRBjveA1haxpaImnA0FoVWpCs5UTGvGenftt
         ZM+dU1zUj5vSzLhLlTYEJaKTMldlu5f+y3mLtTPPbqtuH0pJHxXNMuNkl7Lz1ZsVqDEb
         +Qv0BhmNO4nbWW6zq38avn6FwuvxekGqc4sEe4z+gviL+W5UeLALEmcAGdQrWOofH0Nb
         WFzDPX0+TBY+eYZQwuld8mL9yukJYxvIGEAvrlTD8vX8LsKBFEXNmsfn1fx20YAbJ/eq
         u54dE2Cg6XOP+M70h6yTPwoVDYySuUxCYyDb83LMSYZ4oWfcliI17PAExs0xKcCaZ52D
         WtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j5Ct481F4wkRupatYcRj24aj8wwNlrEwHJD/XdnqyS4=;
        fh=+orogZRReVkLn8YDPxFodbYP2Gcr0hop4kcq4hqP3hg=;
        b=VqdeiRKY7OJ51ba5F6wIYmLzJ+TZCTkuaDOvo206Vfmq5T1zfJSnzymrgsNUo7wepj
         Y6JahYGNLUnrlHHgufQocPR8VuURADJRp4G1LXAktFfsk252wG5I3h+7YL69zJ0xf2FY
         s1MapWXSFPsRIr2guCRNq/blNJGs3I6qSuexiTT6EHWvXHDl00k2eey5K2/jAJOe6UXw
         dTAwCtZC/y/DQimt0QaaSAX0LJ4ZmfnzGqe6TKZLCHaqnKzlVjHXmDdQuIBoLpYNzyNb
         65Dalbq37CR6fSKRINDX72fW9ge0s60aNPS/XYu9er1sIkYAZGBPGZpI3WzqKo5PC6h+
         +s9g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787661184; x=1788265984; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j5Ct481F4wkRupatYcRj24aj8wwNlrEwHJD/XdnqyS4=;
        b=T2NrGxkENkfgqsJxSMmTLIEINb7Xa4AWF4/l4eBHKXBEqhCxdmGb1pT8wg0plJERDu
         0GJdUx1XcZLyy4PKIA5W7v3s+DBUwuYWm9lJ+moOUfidHQMkCxenX6uQ6bijt+2uiRPc
         /VbwN+JRgrxd2UrHVuYKnYZjOyEUMGr8bsNlWQufIKwdk8uJDLsfEorUX1O0+GNqBuqW
         dWOuJqI/v7QwTblb6bTaz5CR4dKNnLypejOAE6TbL0XVLcWmOcXl+b1IYTWS6Q8RylPY
         O/1YxSrKiJju5d072KCxNBsl1LIhRNVYLpX0PbV0keg7/Y67kAvAvfZST/KyNzoEhqHZ
         jBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661184; x=1788265984;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5Ct481F4wkRupatYcRj24aj8wwNlrEwHJD/XdnqyS4=;
        b=VP+W+i0IvKAfHxoe9Woyu6+F110MmJzoGKZ6caoQg7HaU9cUBSlOtNy42Xz81c0b/5
         mB5Y2+5N7mdPQ0Q9mwZurG92EOml+DBkub/uMA1GsfgdWJnaPcutl31t1vHTrKYC4RzG
         iyMEDh/ZPvkdmqaMk6NHZbp7gS+pDBdnUmQFWC234p8D8LAv9Y/ytiGTaMdJysupyBxx
         R9n/qRd1cq3q9C/1nPxJqYy1TMPJPAPpxgdJOpKgY0T9vXT7Y6ywZ4kuFQ+GrGdvvPX2
         lMj+tk8yzmL0zit7SVBeuYqDOTLWYizFtiYb+aI4hm2KuNRgPHLrIVnFAxTesepq2GaW
         6LPw==
X-Forwarded-Encrypted: i=1; AHgh+RoY7XmEx4rmYPpiSJaGcgHgDgT/yIGw0+j0MjSydQ41QTzMXcLit/3ibCzL5dVteMBsaNgXWQ==@lists.linux.dev
X-Gm-Message-State: AFuF++ns2PVz6eYDknJfOhFtTh0dLi1uQ8ZeMfiIi+jktI+Y/tMV2PLd
	OrRCwU7u8UdkJim3c84UVBEy1X0sIzkVRLpeDtiCPG/PX5saRUkhE4KW8uAdR2NgB5nb3M/H6MW
	1zyfXAWloc+Tv6i/z+2vdoy585KOnzBU=
X-Gm-Gg: AR+sD13UZTnqWieNcnM0v0vbnsr0WNFapsWR1wDjcG81E9Cn9+j2M76MC2ud4YO4w0J
	Ayh56DiuQXoZn1LFwIJTcmCfaPwzlBLsBLkTHhnyiB1pIjLDku24YPKxEjjlYlFgQxUUuBbA8I5
	YtUTjwpDVbG3ZjfUgNToqsGz4Qntd7zxAD48hWql3dYDO19hMQRaexsDrghxbygJdBSPj5nLnGp
	PC5doXBj3Tq3c2iC8eZHALVC8j3/8HA2c9ugFkfg3KNq7uyBEnP18ZsQ6eqR8WO9GI4lY73o5az
	9acWp7BbRM2/T0PS2ycqHbSIgaFdeOSDn6IF3Ymbwon4mw==
X-Received: by 2002:a05:690c:6b03:b0:7ba:f0d0:5e9b with SMTP id
 00721157ae682-849f4692ca7mr107963927b3.2.1787661184163; Tue, 25 Aug 2026
 05:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
 <ed82f56171bbab8b150d3512412cda12e7e09a7d.1787568944.git.gahing@gahingwoo.com>
In-Reply-To: <ed82f56171bbab8b150d3512412cda12e7e09a7d.1787568944.git.gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Tue, 25 Aug 2026 14:32:52 +0200
X-Gm-Features: AcwNN1Xtzi2WJl1KccSUfPCnVd1JKytTLunfgDKRxF-zeJjSJm8murTNkgUrOck
Message-ID: <CAEWPSH7AcRb4uAnhmcL+kk3mQrgqYsQAYR=JQjJdkFGVK4qfHw@mail.gmail.com>
Subject: Re: [PATCH v9 05/13] dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
	ogabbay@kernel.org, zhangqing@rock-chips.com, u.kleine-koenig@baylibre.com, 
	chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net, 
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiaxing,

One small thing I noticed while applying the series for the
RK3588 re-run: the cover letter says this patch carries a git
note naming the base and the one prerequisite, but the posted
mail has no Notes section - perhaps format-patch ran without
--notes. Mentioning it only because Rob's bot asked on v8 for
the dependency to be recorded in the patch itself, and it would
be a pity to collect the same remark again on v10.

Regards,
Igor

On Mon, Aug 24, 2026 at 1:10=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> The RK3576 NPU has two cores of the same RKNN block the RK3588 binding
> already describes, but it wires them up differently: two extra CBUF
> clocks, two power domains per core, and a single reset instead of two.
> It also has no NPU SRAM supply.
>
> Widen the property ranges to cover both, then pin each SoC back to its
> own shape in allOf so nothing loosens for RK3588, and keep sram-supply
> required for rockchip,rk3588-rknn-core only.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../npu/rockchip,rk3588-rknn-core.yaml        | 47 +++++++++++++++++--
>  1 file changed, 44 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-c=
ore.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.=
yaml
> index caca2a490..3b611b64c 100644
> --- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yam=
l
> +++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yam=
l
> @@ -21,6 +21,7 @@ properties:
>
>    compatible:
>      enum:
> +      - rockchip,rk3576-rknn-core
>        - rockchip,rk3588-rknn-core
>
>    reg:
> @@ -33,14 +34,18 @@ properties:
>        - const: core # Main NPU core processing unit registers
>
>    clocks:
> -    maxItems: 4
> +    minItems: 4
> +    maxItems: 6
>
>    clock-names:
> +    minItems: 4
>      items:
>        - const: aclk
>        - const: hclk
>        - const: npu
>        - const: pclk
> +      - const: aclk_cbuf
> +      - const: hclk_cbuf
>
>    interrupts:
>      maxItems: 1
> @@ -51,12 +56,15 @@ properties:
>    npu-supply: true
>
>    power-domains:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>
>    resets:
> +    minItems: 1
>      maxItems: 2
>
>    reset-names:
> +    minItems: 1
>      items:
>        - const: srst_a
>        - const: srst_h
> @@ -75,7 +83,40 @@ required:
>    - resets
>    - reset-names
>    - npu-supply
> -  - sram-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3588-rknn-core
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +        clock-names:
> +          maxItems: 4
> +        power-domains:
> +          maxItems: 1
> +        resets:
> +          minItems: 2
> +        reset-names:
> +          minItems: 2
> +      required:
> +        - sram-supply
> +    else:
> +      properties:
> +        clocks:
> +          minItems: 6
> +        clock-names:
> +          minItems: 6
> +        power-domains:
> +          minItems: 2
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          maxItems: 1
> +        sram-supply: false
>
>  additionalProperties: false
>
> --
> 2.43.0
>

Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69B02561
	for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 14:50:09 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-13af2d12469so3767834fac.13
        for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 07:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wnm8CTZGfD6ls1hnKruN6hj9x0O7kfsoToo4nL1JtNg=;
        b=svfInJ+tp/7vMmdiPZtKyNr4RDHVMLRPlJR5TwFj49sZ//YhsSZUYJESEriB8NU8Xv
         B7wzKG9ejpi3oHeC5wDKYlIk1TPfJE24wMoHEUaAHEYOu/nBiLJvW8lfAh/1Bw8RXpMJ
         iFK38CG0nxIP6d27f9kMgC6rRuU6+GxyoSzwAAuhZBa0dlQNlVl9ZfURMvVSfFFKKW6E
         g/pgiK36W40VRo8ZymO16kIiE18LrvTaLOV6YieujiSp5WSp3G0JrzxZ51DdC/3EYtXd
         xs3o/I1tY0XuFnD+RjLpn8brbIxGvyuR6wHr/75scAtlW76VJKjNfvJehHbtCoEKh4Bv
         QjnQ==
X-Gm-Message-State: ACrzQf3fYeDfAG63fZ0NadzTBHugwEqwsMeVym21CtodI2MIEG18WBl6
	an3KFWRcvLDeSJDgrq+rMA==
X-Google-Smtp-Source: AMsMyM6bXQm2nnbvgzyu5lgBTRIgIReCxfP3ps0Jhw/HDJ+XOqUmns6D6PYXY8dJYipwV1+ojjA7oA==
X-Received: by 2002:a05:6870:c092:b0:132:a01f:7c31 with SMTP id c18-20020a056870c09200b00132a01f7c31mr12925185oad.56.1666363808748;
        Fri, 21 Oct 2022 07:50:08 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t21-20020a05683014d500b00661946468c6sm1172952otq.31.2022.10.21.07.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 07:50:08 -0700 (PDT)
Received: (nullmailer pid 3719169 invoked by uid 1000);
	Fri, 21 Oct 2022 14:50:09 -0000
Date: Fri, 21 Oct 2022 09:50:09 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, iommu@lists.linux.dev, devicetree@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 resend] dt-bindings: iommu: renesas,ipmmu-vmsa: R-Car
 V3U is R-Car Gen4
Message-ID: <166636380847.3719105.11808204724147299494.robh@kernel.org>
References: <c1fb71448a8400986fd30d51a1bb2704376c0306.1666361055.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1fb71448a8400986fd30d51a1bb2704376c0306.1666361055.git.geert+renesas@glider.be>

On Fri, 21 Oct 2022 16:06:02 +0200, Geert Uytterhoeven wrote:
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  Hence move its compatible value to the R-Car Gen4 section.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
> v3:
> - Add Reviewed-by,
> 
> v2:
>   - Add Acked-by, Reviewed-by,
>   - Add blank lines to improve readability.
> ---
>  .../devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml       | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Applied, thanks!

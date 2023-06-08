Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F71519930
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 18:28:32 +0000 (UTC)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-33b1da9a8acso4322815ab.3
        for <iommu@lists.linux.dev>; Thu, 08 Jun 2023 11:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686248911; x=1688840911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6AjDwR0ptMSx+JUF8hl+KxGxvEo5Yse4u2Qkil1oAQ=;
        b=X+4rUDtcc3Tr47PXR3NEzm/328GkpDJgQpuEU+J84dpP+yklAa/3/6u/sq/fqMi9B7
         8EBkdLLcFZHoJCh4BYVbTEWG9a/+XjyTx1gga8uW3J6ryQfzw4tlUxEQEFV/E/qT51lW
         ObJldbeIVOmjXNTN8y6GaU/bsdfUxCbXGd0g9FLDCBXfrfMD6KeXIMoHZeCTy0ZH5Rir
         mdz/qC8l3hnkcg1Q+tF0/2RgPkjdMais4bRScd0+KmXd5ikdYMEdyJNBXNRklFY6yrUI
         biHqClNv2hPMrTjxAuWl/yZBQH8gMGohO2huJzzJDFFnETZxfM574z+6O6lJGXMWUaX0
         qMLQ==
X-Gm-Message-State: AC+VfDwyHSk6w5u9jkqzffy6aqfC+29m8vXDMb4TUGTFamzcOMXIvPN/
	bPXXIDjnl4ZWiEfpDb8rcw==
X-Google-Smtp-Source: ACHHUZ6ZgczaCvQ9WREBX6XZ35ncxDkUp3kUdO8Gb7NQSIE0NE4s5OeN57L3IH1YqN0JwR5VbNdOZQ==
X-Received: by 2002:a92:c908:0:b0:33b:abaf:d493 with SMTP id t8-20020a92c908000000b0033babafd493mr12283395ilp.16.1686248911076;
        Thu, 08 Jun 2023 11:28:31 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l15-20020a92280f000000b0033842c3f6b4sm541876ilf.83.2023.06.08.11.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 11:28:30 -0700 (PDT)
Received: (nullmailer pid 3198330 invoked by uid 1000);
	Thu, 08 Jun 2023 18:28:28 -0000
Date: Thu, 8 Jun 2023 12:28:28 -0600
From: Rob Herring <robh@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>, Saravana Kannan <saravanak@google.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3 02/11] of/irq: Set FWNODE_FLAG_BEST_EFFORT for the
 interrupt controller DT nodes
Message-ID: <20230608182828.GA3183987-robh@kernel.org>
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-3-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508142842.854564-3-apatel@ventanamicro.com>

+Saravana

On Mon, May 08, 2023 at 07:58:33PM +0530, Anup Patel wrote:
> The RISC-V APLIC interrupt controller driver is a regular platform
> driver so we need to ensure that it is probed as soon as possible.
> To achieve this, we mark the interrupt controller device nodes with
> FWNODE_FLAG_BEST_EFFORT (just like console DT node).
> 
> Fixes: 8f486cab263c ("driver core: fw_devlink: Allow firmware to mark devices as best effort")

It is good practice to Cc the commit author of what you are fixing.

> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/of/irq.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 174900072c18..94e1d9245cff 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -535,6 +535,16 @@ void __init of_irq_init(const struct of_device_id *matches)
>  	INIT_LIST_HEAD(&intc_desc_list);
>  	INIT_LIST_HEAD(&intc_parent_list);
>  
> +	/*
> +	 * We need interrupt controller platform drivers to work as soon

If it's platform drivers/devices you care about, then perhaps this 
should be done when platform devices are created.

> +	 * as possible so mark the interrupt controller device nodes with
> +	 * FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to delay
> +	 * the probe of the interrupt controller device for suppliers
> +	 * without drivers.
> +	 */
> +	for_each_node_with_property(np, "interrupt-controller")

This function only operates on nodes matching 'matches', but this 
operates on everything.

It does make sense that if we init an interrupt controller here, then we 
will surely want to probe its driver later on. So maybe just move 
setting FWNODE_FLAG_BEST_EFFORT within 
for_each_matching_node_and_match() below.

> +		np->fwnode.flags |= FWNODE_FLAG_BEST_EFFORT;
> +
>  	for_each_matching_node_and_match(np, matches, &match) {
>  		if (!of_property_read_bool(np, "interrupt-controller") ||
>  				!of_device_is_available(np))
> -- 
> 2.34.1
> 

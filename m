Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5F21E32C6
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750107261; cv=none; b=a4zUUZ9YFvj1zSjvBg2fphl1vB4GyeZf3025RLuOmdSTAEOr2yD7dvrwg/AfZq5uxSwGPCjf8c87pchwK92a24qjl+nUQx+4ZQ8wE2dkeYi6wXrmUK80EbI8Ncmz9aqlr9Ke0+jxDwW4TuBimUVmKJlbbyxPbumsdk69H8SZeUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750107261; c=relaxed/simple;
	bh=d/MoWHZ5e+lhoKDdKuybDi6aTjfFIDhV5u0kgLlN9P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dl0NFM2+fTTT3Zksjw+VeXVEKc1D7AbKuv93B5jk4svKR3VxJ5Sf65hLMeXmQySYeOMuxHuK6ZRAJ1yDrxeaO+15HPSmygdHwem+zgN2aO2wcVQ3vpCLueUSMN1T1toqFTfZtIlnI3Nke7pkIv1OlDSsflwRhO23MfaIY+3CJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RF+PDkWY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RF+PDkWY"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2348ac8e0b4so17025ad.1
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 13:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750107259; x=1750712059; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bylXQEyRsEC9se7T35uUhgi7mwDCmJDoSYBlOu6gy74=;
        b=RF+PDkWY4t2EwEph+Q5GGyGPTDNhkK4m7QinO8EpLLzoq0+itH+NJTXTMLkNmCPLSX
         qC3DZMaBUpPxulfoW16JrUyAQBUItjOAe+d9EziAv6o4hKO9K3dhsWyXuzU9l7FNyRv9
         IugpU7DfgAzwHWeMSNj3gHw8QL45nxE12AAFhwTLIjS7scfGzb53uuvxQugWS0XSqiEo
         /2O8UUzZLAhtLn1lcbEZ8OMgeXHZqOMzPdy9fiE8286O8xETpLLIfbatFlcOYvTyO5+3
         2Bw3xg4coXqRDD4iyX9Gr5Rdijq48TAMJZUiqEqUxegcCFy35U0skHLYX3JJzuUsTuqv
         UNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750107259; x=1750712059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bylXQEyRsEC9se7T35uUhgi7mwDCmJDoSYBlOu6gy74=;
        b=wJWQF7C7nXT1AcBm2S4Mjq0NBCZHp7V3lLpGW4+CtX9zPoqx2t1651l5tb2miIcVY1
         zQ1fM0ORAIPcJjJCbdm59ticuxaf67lbj6og1yBkmO2T5iKsyQvqCP1ul0lkbTsKXQip
         tPTAzLTPDsk5c9paKkxU0xAwjwsh8Ejr0LgL3gwoNAB/qpzjQUUzI3VDmHtL4Dj6hRCr
         22CnQ3lKj3CGKUmvq7gnAcX1PhLgcBTOaH1HN9khrqT/LV7Rd6MKjVUy8+BgXQvzPjfH
         88D4fYLvBqsc4mE/NOunQOYKkG+UaE+FE41hi3R77wKL4vccG1B39+fHHiuL8kh85CDD
         I2pg==
X-Forwarded-Encrypted: i=1; AJvYcCU8O390FuMpXf6sI1vYPhvEUW69KKwdrZnEuYtCWqIyT2F8+L13biNlu03z0U3VHjFKs9hI0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwX1SsLtloW7Db+450mlpz721kwuGHhn+oUhhi8TfNMzxrz/Rvu
	DCCNOanIRk2fWSEwIE76oDsZoPYObLvjYb5t0cSZXux2m1iZ79iuKL0qKQYLEW37hOyTVn2+S59
	3CfHOXw==
X-Gm-Gg: ASbGncv+752BVet+OjWL6HfF+6ZZsc2xMQ56DxZdEdgFSad+GlgyLSsSxzPDMDZkmvM
	Ye27SL9JmIrth8rg0rGyq8NCDMPCqF2GePhZD025xvfz+M/j+Zqy1axJwJbc4+gllUxClCGRoaZ
	saretrAI4ukN/PallS25hMWMuZerAoIeX87kCyY5TSBC2f8PEJ3L9Jf3aiZyJXC6bf/e9hAQckP
	RaoORWS4/yWtjF6i3DaugJsJckyro0ckvtrG48/ByBx6w2DCWoj+4A9k8KtCeIhjrsFopkPre5g
	UxBEfkJW9KZunihL7PRWJ3rLyBBjE1y7WV7yEDpt8Q0F89CcOyihGq97+4ralaOp4DyRsqEobPn
	Y6gg3dyNAlF8/8cbgtB2Q
X-Google-Smtp-Source: AGHT+IF85pxVw9iF4idB17Pc9J6nncgf4wJ2a0JAQZ7KU8U2NL+V9q0BdH+v8rwfWv0L8lWMxivrUQ==
X-Received: by 2002:a17:902:e54f:b0:22c:3cda:df11 with SMTP id d9443c01a7336-2366c5bfaaamr6196145ad.10.1750107259136;
        Mon, 16 Jun 2025 13:54:19 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083bb2sm7561368b3a.94.2025.06.16.13.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 13:54:16 -0700 (PDT)
Date: Mon, 16 Jun 2025 20:54:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Xueqi Zhang <xueqi.zhang@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Ning li <ning.li@mediatek.com>, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 7/8] iommu/arm-smmu-v3: Invoke rpm operation before
 accessing the hw
Message-ID: <aFCEb744WpRpcDxM@google.com>
References: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
 <20250616025628.25454-8-xueqi.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616025628.25454-8-xueqi.zhang@mediatek.com>

On Mon, Jun 16, 2025 at 10:56:13AM +0800, Xueqi Zhang wrote:

Hi Xueqi,

> Invoke rpm operation before accessing the SMMU hw.
> 
> Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 84 ++++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +
>  2 files changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 154417b380fa..88912b0f8132 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -122,6 +122,22 @@ static void parse_driver_options(struct arm_smmu_device *smmu)
>  	} while (arm_smmu_options[++i].opt);
>  }
>  
> +static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> +{
> +	if (smmu && smmu->impl && smmu->impl->smmu_power_get)
> +		return smmu->impl->smmu_power_get(smmu);
> +
> +	return 0;
> +}
> +
> +static int arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> +{
> +	if (smmu && smmu->impl && smmu->impl->smmu_power_put)
> +		return smmu->impl->smmu_power_put(smmu);
> +
> +	return 0;
> +}
> +

I've been working on enabling PM runtime for arm-smmu-v3 for a while, 
I just posted the RFCv3 for that series [1]. I see that you need some
implementation specific rpm calls too, I think it would be nice if we
could align on this?

Perhaps, you could rebase this on top of my series OR we can collaborate
for the runtime PM series where you can contribute only the rpm patches
from this series to handle your implmentation? 
Let me know what you think! 

>  /* Low-level queue manipulation functions */
>  static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
>  {
> @@ -2082,23 +2098,35 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
>  static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
>  {
>  	struct arm_smmu_device *smmu = dev;
> +	int ret;
> +
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret)
> +		return IRQ_NONE;
>  
>  	arm_smmu_evtq_thread(irq, dev);
>  	if (smmu->features & ARM_SMMU_FEAT_PRI)
>  		arm_smmu_priq_thread(irq, dev);
>  
> +	arm_smmu_rpm_put(smmu);
>  	return IRQ_HANDLED;
>  }
>  
>  static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
>  {
> +
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret)
> +		return IRQ_WAKE_THREAD;
>  
>  	arm_smmu_gerror_handler(irq, dev);
>  
>  	if (smmu->impl && smmu->impl->combined_irq_handle)
>  		smmu->impl->combined_irq_handle(irq, smmu);
>  
> +	arm_smmu_rpm_put(smmu);
>  	return IRQ_WAKE_THREAD;
>  }
>  
> @@ -2255,6 +2283,11 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  	struct arm_smmu_domain *smmu_domain = cookie;
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	struct arm_smmu_cmdq_ent cmd;
> +	int ret;
> +
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret)
> +		return;
>  
>  	/*
>  	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
> @@ -2271,6 +2304,8 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>  	}
>  	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
> +
> +	arm_smmu_rpm_put(smmu);
>  }
>  
>  static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
> @@ -2353,6 +2388,11 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
>  			.leaf	= leaf,
>  		},
>  	};
> +	int ret;
> +
> +	ret = arm_smmu_rpm_get(smmu_domain->smmu);
> +	if (ret)
> +		return;

I'm afraid we aren't going for a hard rpm_get in such functions in our
design as per the the discussions in the rpm series[1]. It would be 
great if you could review that too and drop some comments there, I'd be
happy to understand and collaborate to meet your requirements as well :)

[...]

>  static const struct of_device_id arm_smmu_of_match[] = {
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index f45c4bf84bc1..cd96ff9cbc54 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -792,6 +792,7 @@ struct arm_smmu_device {
>  
>  	struct rb_root			streams;
>  	struct mutex			streams_mutex;
> +
>  	const struct arm_smmu_v3_impl	*impl;
>  };
>  
> @@ -1004,6 +1005,8 @@ struct arm_smmu_v3_impl {
>  	int (*combined_irq_handle)(int irq, struct arm_smmu_device *smmu_dev);
>  	int (*smmu_evt_handler)(int irq, struct arm_smmu_device *smmu_dev,
>  				u64 *evt, struct ratelimit_state *rs);
> +	int (*smmu_power_get)(struct arm_smmu_device *smmu);
> +	int (*smmu_power_put)(struct arm_smmu_device *smmu);
>  };
>  
>  struct arm_smmu_device *arm_smmu_v3_impl_init(struct arm_smmu_device *smmu);
> -- 
> 2.46.0
> 

Thanks,
Praan

[1] https://lore.kernel.org/all/20250616203149.2649118-1-praan@google.com/

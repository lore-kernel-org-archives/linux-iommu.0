Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221275;
	b=riHmvXIUx4Ris+2wOprTk68YA9H2TOfKvOITzx7lWx5U2ih4YBvibyuszgZGmdWGs8jd
	 y0u8LaLZv6IoxWkB9K4WJ98NcO9GRWat8gwCOcA1aD64HiJAdfpYIf+feAVFAuurSWSsb
	 LkwyWxlFfo0Z5pYq83QQpLmvwEqoDI4lHflDS9t7esreDtIWEgIyBzRTeeJkK+lsVMSFj
	 FI7VO39eIKBUUhs8XkWNmucrpuCooMBoqG89cV/GDYyWQtddpB1fyBR4qINYygF9spSCy
	 sPmwnxYFRGeaGtVKHNMVU9xK9xMnCC/Hfz6BZMrtvLby5Hns1ux3vnGZh0JNujmsuDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Wzi6KrhT88vehfKY7qgpQ1+JN6+5jlpjxZmv28MWhTQ=;
	b=r0EC66culiZQAD6I6NDugIXqF4ItJG0IlzB+vkRpS1M7puiOujnm6v5h8ctTLOVvioB1
	 H+9l7/+CsMgzKCKHGZGfYdoYrmkTdZCfHUC/DEZLPMFbKD2xPCD0mAGJABYz+X/bGteUi
	 j8apPAuKStVH25mJdk3SmyUtzllOZMbcr7mHiOGPxLviVDJnXUH1ZFkIwNa5kCDVsK8yU
	 RoC+Zo1pcgH4oD2KtnWGAZBg/H9077xJgXFIPmdP5KQl7HWBTU+JPF/kivKuM2oXd2fjq
	 RZXGMPvOyuiUfYL/NU56YDIMXMLM21x4cXq1iPdWaHDc057gBrGUiEJYW7U/y0SYN7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lvhMgIv5;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9649E606A31C
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 10:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9649E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lvhMgIv5
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a018493d57so23165e9.0
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 02:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794221273; x=1794826073; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wzi6KrhT88vehfKY7qgpQ1+JN6+5jlpjxZmv28MWhTQ=;
        b=lvhMgIv58U7ffRHDCt/oCi3qU15SiX0HvooEudCydM5Z8TFMwsmp9sZ3kiS7XAdttt
         +1V+tbGCE8hSrrFJ45OClPuiNnUt7QcoRb7ThfabT+Th3f2OLdTYF2Sya/SABjB98ABy
         ALoXSziBO5COtMTb9y3Tz05Y/ANN1WVn4PCJyg7QtH+CnvPVhcrTxKxnQ1ORUNGo76Jq
         Hxnpl7Xm1pzVfQAOZPIHRsjVhokywRxX3/SERkf6WvduDijnpxMY7iJin+Mnj+OsROUU
         dTkVaND9A3E2pIs8JbvArDDzBP3BcZu1Z91KcjxNVhroUfNTnRrH3EYtwggsMfW9PKfY
         QTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221273; x=1794826073;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wzi6KrhT88vehfKY7qgpQ1+JN6+5jlpjxZmv28MWhTQ=;
        b=rBDbXPdKAlnxDTt34LbpJ4DmPVbVoZk8wUqjw2T6jLVn8zRhwToZHJMM4uHNJSJmWg
         stU8CloEoqK1rKv76kl9dVx7Wk2c0+IV3sWGRSNWxyUHFUtQ+g1XgP6IDLAHcb5gTOwD
         N1Sf5+kUB1H/Fe2s/THBcVtzUq6/mYTKbqIA+2HcYvnZ9LdcPHOmU0tirqNRjZqw66Mp
         tNidLIhRHq3G1w6oDSFujgWacpzYjD1Xxh/BwbusIvuPCLXvPAgFqb0gfBvrjDbAhzmF
         B71EA9h8w8joqEKn02zfluavxWm+G3XNiWYnF8gpNAyDcxNXngTI3HCZiOOGg2/h3zWj
         //ew==
X-Forwarded-Encrypted: i=1; AL+hErGaAHlQ7B+5aKHpSACUVsxHnOX9xhViyXhWCS37jnVz4mL6i0BXMWj3E9CsFR9tjBboJ6bvtg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9kQA1d2ixvEM+JzB21fa+FiqMSQ1vuK7OEve0PB9k+7+nbCpsG
	2OQrgQoz6tvEUotH04x8x7FBfp8hfG/HodN3PugBdOZxaU4SQ0lu0pKno5SiQh4uZQ==
X-Gm-Gg: AYBFou1EIuomwtgmNBLALvVMfG8YctjiRkt+Vd8sjRBqCennjoJYMMRoVNf3P6577Jo
	fxmCmHyArKGxzMh9yYJ6nHcIkJ46o1uOyOlDpfTeu7DupNOryE+2wdgg47JBuNZvS3T6rFt3H/7
	x1YAvvUDDkqA87klKdpDt2PbwsSKB/+pd4VpyUJv07lHqCoQlrw4o1Kl1XPyKwlIHPVYL+/Vlem
	hr2QOVTmZwlhB7+5jION6gMeiCNF14lutDxieuNyDIAtm+er16lOi8punAnZPuPChrsBtW6MAHN
	OSTU6oXRDG2+RGiUmbumTNeY89ATwiPMz1MdFpgSArx4Ts8JkquqAlL08+W+quatxH7lcrpd4nw
	s67Q9yG+7w9rHVdhuR4BKiXSNqaRXwxdRPX356uZERmEyOuUvfZ85WI1o9RskOt5TdV+bfPC6cn
	dAkOdoHs6LEsXGLWaIX0CqUdzp6bdI35fIHti6zY8nzM5UIGQuRgB7//ccSQRhFrTOwhtFjFvFa
	7VBEsQH1rTlsKppUVQV91uz2iM2KI+i0FIKZtr4YG61Pqpwlpbn7XwaMRE8jKp4y8PG0FT0VTvz
	gzsYFtQ5oBpxz6SjRYYId+RtkkIRsTHNm1VccDEpRle7IP3YJT4/D3nYoXy7zadh+WNZ5Q==
X-Received: by 2002:a05:600c:2d91:b0:4a1:d373:5759 with SMTP id 5b1f17b1804b1-4b8b04d3e52mr1256155e9.8.1794221272587;
        Mon, 09 Nov 2026 02:47:52 -0800 (PST)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90f1117fasm149512245e9.13.2026.11.09.02.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:47:51 -0800 (PST)
Date: Mon, 9 Nov 2026 10:47:46 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com
Subject: Re: [PATCH v9 11/25] iommu/arm-smmu-v3-kvm: Add the kernel driver
Message-ID: <avGk0ilyJh3obmKx@google.com>
References: <20261015200903.2735565-1-smostafa@google.com>
 <20261015200903.2735565-12-smostafa@google.com>
 <auzvygiGRTWgJXzF@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auzvygiGRTWgJXzF@nvidia.com>

On Thu, Nov 05, 2026 at 01:06:18PM -0800, Nicolin Chen wrote:
> On Thu, Oct 15, 2026 at 08:08:42PM +0000, Mostafa Saleh wrote:
> > +static struct platform_driver smmuv3_nesting_driver;
> > +static int __init smmuv3_nesting_probe(struct platform_device *pdev)
> 
> Could it use a different naming than "nesting"?
> 
> "Nesting" is widely used in iommufd path for nested translation.
> 
> Here, it could be smmuv3_pkvm_driver?

Sure, pkvm/hyp works.

> 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +#ifdef CONFIG_ARM_SMMU_V3_PKVM
> > +/*
> > + * Two devices are involved: the aux device bound to this driver, and the
> > + * physical platform device bound to the pKVM init driver, which only uses it
> > + * for discovery. This driver keeps using the platform device, as it carries
> > + * the fwnode the IOMMU core and consumers link to, the DMA configuration and
> > + * the IRQs.
> 
> It would be nicer to have a diagram or so to show the co-relationship
> among different devices and drivers.
> 
> I assume the regular arm-smmu-v3 driver is a part of the picture too,
> when the pkvm driver binding fails?
> 

I can add some ASCII diagram.
If pKVM driver fails, no aux devices are created and the main driver
probes the platform SMMUv3 devices as usual.

> > +static struct auxiliary_driver arm_smmu_driver_emu = {
> > +	.driver = {
> > +		.suppress_bind_attrs = true,
> > +	},
> > +	.name = "arm-smmu-v3-emu",
> > +	.id_table = arm_smmu_aux_table,
> > +	.probe = arm_smmu_device_probe_emu,
> > +	.remove = arm_smmu_device_remove_emu,
> > +	.shutdown = arm_smmu_device_shutdown_emu,
> > +};
> > +
> > +module_auxiliary_driver(arm_smmu_driver_emu);
> > +#endif
> 
> Nit:
> #endif /* CONFIG_ARM_SMMU_V3_PKVM */

Will fix it.

Thanks,
Mostafa

> 
> Nicolin

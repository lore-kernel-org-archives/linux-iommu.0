Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E11E5B63
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483677; cv=none; b=gj36HaoSUQQ2rhMwcvNnHs+5a4x/RiipfdUypgc2C5m/CAtU3yXXVrjbVZddOKyas1fvEi7iYhLpJDcpixvyBTiOUBzs+PSqmki2DNanSixxbbnlW9zrrRPH3VPnDcXomzmwoPvct1Qyk7DYQKVmTvkKFJtHQFFbXrcZ2q6t4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483677; c=relaxed/simple;
	bh=bG9TxTD/lfyqkdSHvMetNEaP8nWqlrsNbjV9DFeaFP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFIiD0CzWy3+qSsRmKR9DmXgthh0s/p37kFmz/8aXkRRFwYY2LBjH7Y/idKtPcjO4KMe7JgDW2UxMQOUT1/tcMb7ppyGSn+pyY4Td5AU49VVrh1AZj00R7WGw9YvCwoEeMklXQzuByPh1nJWad/h/Plllli1RRDiqpJt37wCcUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wl0y81P2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wl0y81P2"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-237f18108d2so274345ad.0
        for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 02:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752483674; x=1753088474; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0cxrQqb0jpt8b/sc2zV313XiZaZHh32gcCu7m4bvXDc=;
        b=wl0y81P2o9LOqdxjir31XK47XJup+5V6/sWcuOAIvDeCc7sf0bk3SdvGaGEPwRIb7Y
         isBRiFmMLZMCD6iOyPsME+aJ9bSadZQO4PEqnbpe55hbhFF5i+qSGxZbz4S9vyI/gUId
         3SoF9Vz1TOyPEuN8berkQW4XdGfW8oaztl+UiHOvguu6zVfQX+p/dUshSfGe9VZhzI5W
         SB9Yya15OhTFcK0sUSwaE5ocFSm79jSuazSlbrNAdqFMbAKTUcyQB4kklA+TOTbT34gL
         WyTUL9TnmdplNTULT8eMV43VqA+Z+pewc4+VYxMdp0t/zRJJU4nyte4rrlcnYj0gTt2B
         qI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752483674; x=1753088474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cxrQqb0jpt8b/sc2zV313XiZaZHh32gcCu7m4bvXDc=;
        b=wy5YUkgIPXEsjlkLl8ByASNR7fHWg18T+GRpbExl/jkTbxl+az9JP6TaB2r5G+cO39
         LAxs1uAJe3dmDT/YMijTS/W7iGWD8X4AYooHCOy6InZ19tztxsSugHoGfCRmmvpb1+Px
         4Ne9Ctv9yn7bclRdbEYHY5srw1KYSPjAN9/CXyTlxNbEVW1xaciJa5JqOQfPPrBJADWV
         qP+C4xYyhJJYbe+lMl3r5ZczB+cJDKLuFY1mLdrenSVVj6gnqE4ZReGoysj70iOFppiZ
         vqnzShEUqTwlTaxJEvbs0G2MMGdWWsdCFUflgR0/KYeDdivCgkrW968dsu/t3UUoOeSC
         TkDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6kRYLyTWlxBqfmymrRolz7Shal7gFjU0FVX4KY9JS8ohV1xjbAu/TeCZSe1B4F00rcSKzAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDcRbymuLSTIQjKk8cQjXKM/wwEbK8dl2QxqZWsE34vu03QvFh
	Tg92pQuEJ1VdkhAx84SX4d7SB/PzSnzA+VDtx6GCfpd46+vYwGQHSjUnJJWSMZn5fg==
X-Gm-Gg: ASbGncs+46YqbWbOVn40+qEbVzFryPyR7vr4X0ENWHToQFxekndgzmWmL/uwikLflNQ
	wonDsqQuJQqHiGbMGcf/viZ2CyGfdk12WD04CkuIMvRod6fnp61fCOAh+S12KxL4CShoQzYk4Zu
	c2lcayuHTNL0WHzLffuKqW25hWy1Ec5PSg2dvKPc46Kvf3P/AJFfoDi3IsylQ+NzMB1qwWTtWYx
	KUTFqT7Z2ZiQSMOMHcvfj1aWBdk/zCkKL8/enrvX4Q4qtsRJb20o0JF1AiN/E5Va7PjbnUZQfz5
	OWnG+hr8iHpzvnJMHNyNoJPPE8VjDe0doTC9mVRrWQuo7GgZSvG44wmy5Z2cjwccalYplDK0qOn
	sH3ikp9zJeR5M88n6PMXdodEd87m0INLXgf+XYRlhgWebuzPwPfCNoGYi
X-Google-Smtp-Source: AGHT+IE85Y3NxyMyW1kaviY2+Lx+g7Ud5iWmAdn/SWe0D7UOgPgGXbouv0fuX4pX29Nc+kGxPfOPQg==
X-Received: by 2002:a17:902:d50e:b0:234:a44e:fee8 with SMTP id d9443c01a7336-23df7b45ea5mr2997565ad.27.1752483673915;
        Mon, 14 Jul 2025 02:01:13 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23df3d7065bsm48781895ad.250.2025.07.14.02.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:01:13 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:01:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v3 4/8] iommu/arm-smmu-v3: Cache and restore MSI
 config
Message-ID: <aHTHUxQTT6kXy5tS@google.com>
References: <20250616203149.2649118-1-praan@google.com>
 <20250616203149.2649118-5-praan@google.com>
 <aG06iNeVAkEoZ8Ou@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aG06iNeVAkEoZ8Ou@google.com>

On Tue, Jul 08, 2025 at 03:34:32PM +0000, Mostafa Saleh wrote:
> On Mon, Jun 16, 2025 at 08:31:45PM +0000, Pranjal Shrivastava wrote:
> > The SMMU's MSI configuration registers (*_IRQ_CFGn) containing target
> > address, data and memory attributes lose their state when the SMMU is
> > powered down. We'll need to cache and restore their contents to ensure
> > that MSIs work after the system resumes.
> > 
> > To address this, cache the original `msi_msg` within the `msi_desc`
> > when the configuration is first written by `arm_smmu_write_msi_msg`.
> > This primarily includes the target address and data since the memory
> > attributes are fixed.
> > 
> > Introduce a new helper `arm_smmu_resume_msis` which will later be called
> > during the driver's resume callback. The helper would retrieve the
> > cached MSI message for each relevant interrupt (evtq, gerr, priq) via
> > get_cached_msi_msg & re-config the registers via arm_smmu_write_msi_msg
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 45 +++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 9ce00c959034..4699d3294d3e 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -3962,6 +3962,9 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> >  	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> >  	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
> >  
> > +	/* Cache the msi_msg for resume */
> > +	desc->msg = *msg;
> 
> All callers to arm_smmu_write_msi_msg() get the msg from
> get_cached_msi_msg() which already returns msi_desc::msg of this irq,
> so that seems redundant.
> 

Can you point me to the caller? I quick grep shows me that only vfio,
dw-dma and some spi drivers call get_cached_msi_msg().. I can't also
find a place where the assignment desc->msg = msg happens except for in
PCIe bus.

> 
> > +
> >  	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
> >  	doorbell &= MSI_CFG0_ADDR_MASK;
> >  
> > @@ -3970,6 +3973,48 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> >  	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
> >  }
> >  
> > +static void arm_smmu_resume_msis(struct arm_smmu_device *smmu)
> > +{
> > +	unsigned int irq;
> > +	struct msi_desc *desc;
> > +	struct msi_msg msg;
> > +
> > +	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
> > +		return;
> > +
> > +	if (!smmu->dev->msi.domain)
> > +		return;
> Is there a reason that is needed?
> 
> I’d expect irq_get_msi_desc() to return NULL if MSI is not used.

Do you mean that this check is redundant as moving ahead we anyway seem
to check irq_get_msi_desc for each irq?

> Otherwise, I think dev_get_msi_domain() would be more suitable to check?

Ack.

> 
> > +
> > +	irq = smmu->evtq.q.irq;
> > +	desc = irq ? irq_get_msi_desc(irq) : NULL;
> > +	if (desc) {
> > +		get_cached_msi_msg(irq, &msg);
> > +		arm_smmu_write_msi_msg(desc, &msg);
> > +	} else {
> > +		dev_err(smmu->dev, "Failed to resume evtq msi");
> > +	}
> > +
> > +	irq = smmu->gerr_irq;
> > +	desc = irq ? irq_get_msi_desc(irq) : NULL;
> > +	if (desc) {
> > +		get_cached_msi_msg(irq, &msg);
> > +		arm_smmu_write_msi_msg(desc, &msg);
> > +	} else {
> > +		dev_err(smmu->dev, "Failed to resume gerror msi");
> > +	}
> > +
> > +	if (smmu->features & ARM_SMMU_FEAT_PRI) {
> > +		irq = smmu->priq.q.irq;
> > +		desc = irq ? irq_get_msi_desc(irq) : NULL;
> > +		if (desc) {
> > +			get_cached_msi_msg(smmu->priq.q.irq, &msg);
> > +			arm_smmu_write_msi_msg(desc, &msg);
> > +		} else {
> > +			dev_err(smmu->dev, "Failed to resume priq msi");
> > +		}
> > +	}
> > +}
> > +
> 
> This pattern seems to repeat, maybe it’s better in a macro
> 
> Something as:
> #define smmu_resume_msi(smmu, _irq)  {	\
> 	unsigned int irq;	\
> 	struct msi_desc *desc; \
> 	struct msi_msg msg; \
> 	irq = smmu->_irq; \
> 	desc = irq ? irq_get_msi_desc(irq) : NULL; \
> 	if (desc) { \
> 		get_cached_msi_msg(irq, &msg); \
> 		arm_smmu_write_msi_msg(desc, &msg); \
> 	} else {	\
> 		dev_err(smmu->dev, "Failed to resume %s\n", #_irq);	\
> 	} \
> }
> 

Yup, that looks good. Thanks!

> static void arm_smmu_resume_msis(struct arm_smmu_device *smmu)
> {
> 	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
> 		return;
> 
> 	if (!smmu->dev->msi.domain)
> 		return;
> 
> 	smmu_resume_msi(smmu, evtq.q.irq);
> 	smmu_resume_msi(smmu, gerr_irq);
> 	if (smmu->features & ARM_SMMU_FEAT_PRI)
> 		smmu_resume_msi(smmu, priq.q.irq);
> }
> 
> 
> Thanks,
> Mostafa
> 
> >  static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
> >  {
> >  	int ret, nvec = ARM_SMMU_MAX_MSIS;
> > -- 
> > 2.50.0.rc2.692.g299adb8693-goog
> > 

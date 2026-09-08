Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E8647C0E1
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788899040; cv=none; b=r7VqKGmQRMZk79atL3d5eEeoOgD+pQIvlLWfWylNB3KW5W1fHCCVkYeeV6gUCZxan1acId76u63GyQdtIqvJ1bEEN2Apz2C6+OhgGX/UHSXfE7sDRrLlTvM67iDa+wPS7DEcC5+BVZRfoncUIyt8nWGM5gE+lGCQZJng0fyuCKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788899040; c=relaxed/simple;
	bh=Mbc3IuEFfITqWEsrPLsFQSDVe8b+rBgtX7jU9Bd3a1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgY0K6Zlh+nOc7Ynw2ONkRiGgK9q6BcRENpaOMF+gNwLPtRcPsKfxM1Ss7pqaTyc8leuKv2DasN3WaHYaE+kinTLD0qaQlyv8OzHV4nca77MapxhxofTBT7oeNlaHWeBRnG95eHE0ovBXrHKJVdA98HbpQY7+yR+uyq0lZilvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QUiE0ekd; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QUiE0ekd"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca07so2205ad.1
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788899038; x=1789503838; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1I3msafLVMvvHTnjs1M742qvOTnA2IGWYTqmBJm7pXk=;
        b=QUiE0ekdKrHCcyQ/jCQx1X6K13FLk7Wr/Cjkls/1gRYhRCkJB22383gRlu1U7MIJ7v
         J73OeQVgFQ05DDrQ3BcjNfsL6htCFwQYD1eG2oMe2L8kYDODIFhW3CFhWkBDahSpLzgV
         Z4Jrx9B5gD659+I5TTd2V7D0bYAiL3ZloZRNA3wuSPVzXXucoh6juV9OBmvbq/SjVgg9
         Pv53JwybiShbrLPTbBUhQI3FHmrbuO+2wsWr3blFMmK8ji5ialGO0t7QKNZXD47nV8Oo
         wExDFu36Udf1N8XuER9QFKhFsywoT6qsFxvRW294gRPngLxa1vAXt96UocPNaopxwGnQ
         e2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788899038; x=1789503838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1I3msafLVMvvHTnjs1M742qvOTnA2IGWYTqmBJm7pXk=;
        b=orRWv6s3pjcUKQ1O92B1nnKvygQDZD1m2BDbOQEhipkUsBJ3B7StAQ3hpQbsgMPd7w
         t11lCd7fg5SJZmX/YcNR6YEFWyRc6iCgMJmRSQkW+NuOlZLA7CKVcrTMryJFuwCLV95l
         etzoOhwRH1G5h4XHwCLi2Epz+6ulwLAeswQOv6D7Lyr/l6AygxEjnxMQmNIeUOXYcHRK
         aNQOCSTxOVayQOGIp6TJfKrx3lyciEgYaj2E9fVthhufMFOfXDBHtmUZu3m2pOIjSVdr
         wMjyZAjHHiYCNZY6CzFGIlQK/F2SluY8sS3nixnbYFSZF2xfgFTvD2Geh6e3QzSvbchY
         0uYA==
X-Gm-Message-State: AFuF++kL6BalmiEPlk/mvPTFw25R/mXvQ6J9Sl9AJ2lVoqSI+oqQltt1
	0iWrNhZs1kH3ps8VyWbW7gEvJ33RRBBeIDlWJUSikMWzILso6ljSrOj25z5fS5NlEw==
X-Gm-Gg: AYBFou3kMUeWDNvDDuoP++2PalqGRi7wWITezjghZ9Lgs9NTEcWRISL+NckXAJiKm6O
	fblFDYD8rhKgIKiXQVKhdROxBQqfiQVDn/L4MnYlN8gVDz/9Q+P67nj2IDdBp8ZgJq2yM9oRIbf
	PWMgUB20yrnjwr+TPdehJ4ZvJ467iSeQJ0B5Gy2NfA+1zqM9tY3uln64UhAiYio9SMxudAqFVDX
	h6ytoFgH3sCjz8FH3gcu8HmE7fo7MiLuqXGYZc+//AWBtRfwaE4tJ9Rxyr3i64kle+/O26zl+jp
	WBmCoQav8/xV+hUo+Y3idUS3Gdqhixvb3RETEYCujoMfeaQ7NWUSKJEprvIFYtiCpOBlEHdQp9h
	8EZ3RKot9Csn05nTgUvptOZNm0ki8E6jBIc9DXmqrWidSoomRT+cm/vRfqLYoTgpXo6odIYFwct
	OJ5KPvdBNfDr3yXVqmQyS4mNWcyIfcFXEpt+/yxpodw0RWhrz/Q0GVHGd7JoC64rUKxHd/rRzQ+
	eRxj3ADGJjNEz2GmwuyfYf5mQ==
X-Received: by 2002:a17:902:c94b:b0:2ca:4bb4:4bd with SMTP id d9443c01a7336-2dcfc99344fmr4355ad.5.1788899037835;
        Tue, 08 Sep 2026 13:23:57 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435648esm45959637c88.5.2026.09.08.13.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:23:56 -0700 (PDT)
Date: Tue, 8 Sep 2026 20:23:49 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v10 08/15] iommu/arm-smmu-v3: Cache and restore MSI config
Message-ID: <aqBu1W6fBVKikMUd@google.com>
References: <20260908171712.356645-1-praan@google.com>
 <20260908171712.356645-9-praan@google.com>
 <87pkyn1pqm.ffs@fw13>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pkyn1pqm.ffs@fw13>

On Tue, Sep 08, 2026 at 09:56:33PM +0200, Thomas Gleixner wrote:
> On Tue, Sep 08 2026 at 17:17, Pranjal Shrivastava wrote:
> > +static void __maybe_unused arm_smmu_resume_msis(struct arm_smmu_device *smmu)
> > +{
> > +	/* Clear the MSI address regs as they reset to unknown value */
> > +	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
> > +	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
> > +
> > +	if (smmu->features & ARM_SMMU_FEAT_PRI)
> > +		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
> > +
> > +	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
> > +		return;
> > +
> > +	if (!smmu->dev->msi.domain) {
> > +		dev_err(smmu->dev, "msi_domain absent during resume\n");
> > +		smmu->features &= ~ARM_SMMU_FEAT_MSI;
> > +		return;
> 
> If dev->msi.domain == NULL then arm_smmu_setup_msis() already cleared
> the MSI feature bit. Has it magically been set again or does resume run
> before init or does dev->msi.domain magically disappear during suspend?
> 
> I'm all for defensive programming, but this is voodoo and not structured
> defense.
> 
> Aside of that dev->msi.domain is the patently wrong condition. For
> devices which instantiate a MSI device domain dev->msi.domain points to
> the MSI parent domain and not to the actual relevant device domain.
> 
> You can't query that easily by chasing pointers (for a reason), but
> there is no point to do so. See below and the patch I sent you.
> 

Guilty of voodoo defense. You're completely right—FEAT_MSI was already
vleared on fallback during probe, and checking the parent domain here was
misguided. Dropping that entirely. (I added the check here and then
updated the setup_msis() part).

> > +	platform_device_msi_rewrite(smmu->dev, smmu->gerr_irq, arm_smmu_write_msi_msg);
> > +	platform_device_msi_rewrite(smmu->dev, smmu->evtq.q.irq, arm_smmu_write_msi_msg);
> > +
> > +	if (smmu->features & ARM_SMMU_FEAT_PRI)
> > +		platform_device_msi_rewrite(smmu->dev, smmu->priq.q.irq, arm_smmu_write_msi_msg);
> 
> And that's exactly the point I made about sprinkling this stuff all over
> the place and thereby violating all layering rules.
> 
> Done correctly this whole function boils down to:
> 
> static void __maybe_unused arm_smmu_resume_msis(struct arm_smmu_device *smmu)
> {
> 	/* Clear the MSI address regs as they reset to unknown value */
> 	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
> 	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
> 
> 	if (smmu->features & ARM_SMMU_FEAT_PRI)
> 		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
> 
>         msi_device_domain_restore_msi_msgs(smmu->dev, 0);
> }
> 
> It just works simply because the function returns early when there is no
> domain or the domain is not a MSI device domain, which is correct
> because there is nothing to do when nothing is set up.
> 
> But that results in too comprehensible code I fear.
> 

I certainly won't complain about code being too comprehensible! :)
This is much cleaner than what I had.

I'll drop my implementation of patch 7 (platform_device_msi_rewrite) 
completely in favor of your core msi_device_domain_restore_msi_msgs() 
helper, simplify patch 8 to this and take it for a spin.

Thanks,
Praan

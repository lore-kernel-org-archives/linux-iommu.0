Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F217745
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 21:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005433; cv=none; b=O9fy7shIQV9nJQmIFrYMsYKTej349IeKL3vmhNvFrRgWym+erj7DDH2xwqEya+IuRrBHe35uTC/TCQ3sUKzLfnLSyS9MwHeZDYBkA71FzPIxWresJwRQMDM5rvTkr21vFdgAMNgBa/lS3CjxrbHY4rKeH+uQp3vA9Gptq4LVgcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005433; c=relaxed/simple;
	bh=LjiKCqOO2mfryQqvbQEkYi6M4VahEZhDeMv2JiXIWl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyH/lZDTHfjgEc1f5BmOvwFnv0mMXvwhjuDXHJMyNt6Vt7QQ2nzSuXxdXzuzJtjJZOxM/SO78ZMagiuW9i92uLaBLdgGpTFngIbsWVpcDp2xghrlT6mHxzrFZ/FZE6kzTOHJyeaCpr44y+k6FPk2WtM3AZ7r+67KFnyeGdmekMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TYdEcBKH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TYdEcBKH"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso185ad.0
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 14:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780005432; x=1780610232; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2GShboWfCH+geXdhp6U7pMNHFToJXb2v7Io6huPy9A=;
        b=TYdEcBKH05Fvs5OEnQsblz4Re3JXGVBBFPZ+C6lzrp2zyBTWN/199AhLpBRXtxiz+L
         9eYt5mFbfHOrhaP9qH8Y7GGTRcgazbxiGanL1AagG9oAJZtPDjfguDu1gkOzHhj9Xev6
         Io4TZgO0XkniNXiUyy4pS6hTtk1mU3zQC5bDgOBciz1ZLanrLDmXkVwYaofJUmYz08lG
         2LUwZ1Mpm0NP4mPKJjA4DebWSV7/FWiLNzK3M3BQ2Sk+mnXYWe+Gs/br8ixBmYHPmwMx
         lG706fSGbHr+UeYyr9XBkD53JlGtDNDcHkhO2nmapEja58WRFJUYmvc+9ZsfVifYbq9Y
         sInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780005432; x=1780610232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2GShboWfCH+geXdhp6U7pMNHFToJXb2v7Io6huPy9A=;
        b=HcyZgPV7SOE5HtZ2YAwtoAEwmkTqNrLYkxhevli6slhNSp4V9mIlfvAbaV1kLwooYx
         9DM3+lKtFOYFOFiyL16icZozuhL2P7Eaai3DcZcvfPGtcq1eW+vwmlPPoTy9vNqzCQtf
         bGS24nss4dFDMARunbpvNlJzO04Cp2cpVyjL3fsJniJftgJINS8H9T1klUF05n0lPv35
         WFOEjDLcVLdLfmw5ko/H/yfTMZStkyeAQtISP6Dft5JemIb/Hg0MDNWulKUzqqzL5ujh
         X9Uxy+FklFu2swHOPkNKf/3p9Me77TRmFnsNrYJt4cjytgBd5SZ+THnFSg5XFTyUCu4K
         fHFw==
X-Gm-Message-State: AOJu0YzXBvUAW5RCjJfcDtOe5Pq1CGSCEnt/DN8SRIwpgdTBJMpcM40T
	CZ5VFqaFqyQCbdb6exJ2LkiBVkkz3+1NaQa2y/4Akf0R2IynaLDN5nA2YRNEyqEzSw==
X-Gm-Gg: Acq92OFxwlh4pCH81hqm+WHPmvMCQPU14nKbI0n0KCuxXWDhwLy1uUVnCQAvsF5LE+Y
	ItVr3q7pTQ8YDlVpPKpDp99bV9pqdEBGouJDcFt0qEni4gv4klcUCl558bXs+tyrELeYj/ykT8g
	15idaQLhnvcwMp+ihrP7XjY/gnYOOvWQ/QNkasgeMg0pKrqsVRGtJYlU7XOOUJun5LbllE/t/1p
	4NXLNU7i8aLJywNSyXXJJRvA2wO3BoumSERZtrQWJuMzK0oBr+HKZenqAcFEvVNLLePJEunuNdl
	BHytegKBhAj8QQ25sZXW+A7UiueWgA1osU1UVIQQQ1fFhzhWz+Z7AvXKQVR67xa9SA/abX8yxJ/
	tyeko+F8c8WIclotdeYOyTFZ8ww3LNUHT4McGqIklp+Qu/Mrw0O88eKBmJ5Fd0aI2kaKD/3SqYN
	QjDlfehJaPq3p8z66uT5FFRq15lphDiWl1rzMa9ixp6dzvWaTo9s9+7KSQbgcW6zoREoDt
X-Received: by 2002:a17:902:e844:b0:2b0:7a9b:82f3 with SMTP id d9443c01a7336-2bf2097502dmr215445ad.8.1780005431489;
        Thu, 28 May 2026 14:57:11 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbe1f9377sm46400a91.13.2026.05.28.14.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 14:57:10 -0700 (PDT)
Date: Thu, 28 May 2026 21:57:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 05/11] iommu/arm-smmu-v3: Cache and restore MSI config
Message-ID: <ahi6MJaAene0ogY8@google.com>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-6-praan@google.com>
 <ahiLFoRk4xaxr2vn@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahiLFoRk4xaxr2vn@Asurada-Nvidia>

On Thu, May 28, 2026 at 11:36:06AM -0700, Nicolin Chen wrote:
> On Wed, May 27, 2026 at 10:14:01PM +0000, Pranjal Shrivastava wrote:
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
> > get_cached_msi_msg & re-config the registers via arm_smmu_write_msi_msg.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> > +static void arm_smmu_resume_msi(struct arm_smmu_device *smmu,
> > +				unsigned int irq, const char *name)
> > +{
> > +	struct msi_desc *desc;
> > +	struct msi_msg msg;
> > +
> > +	if (!irq)
> > +		return;
> > +
> > +	desc = irq_get_msi_desc(irq);
> > +	if (!desc) {
> > +		dev_err(smmu->dev, "Failed to resume msi: %s", name);
> > +		return;
> > +	}
> > +
> > +	get_cached_msi_msg(irq, &msg);
> 
> I wonder if we could use __get_cached_msi_msg() since we got desc?

We could've (and that's a nice suggestion), but unfortunately it 
(__get_cached_msi_msg) is not exported via EXPORT_SYMBOL_GPL() :(
We could break modular builds as CONFIG_ARM_SMMU_V3 is tristate.

Let me know if you have a strong preference about exporting it, we can
add a patch in the next versions.

Thanks,
Praan

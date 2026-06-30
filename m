Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB910299927
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 05:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795664; cv=none; b=omFMbpNmmibr05k2Z5EFT5Qwmox/MMKJPtG/JFYrHLdCQKvEVKCucjZlZDBSyfiVL+PCFQ1la8Jpl4xc9z8QvogKs84nHlDJmCZR/ArrfoDZj8RlzOSQR/fvLVxAazJSZn3FKQjbekjyZERRvs5MMBd5G8nz8WAObVZMR7dAUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795664; c=relaxed/simple;
	bh=cshp6EzvH/z+lGb8qp51J7AAzfUL7EToPgWpEXGShdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7BDBSO84zHWyJQxD6ciHat/f26dncBUDd0eA+/QIjWFbj4u/dig4wHar20fnPtcMIsQeE9tRX/RUkJagVoOjoynJKUWmEbn2Myy8UP5tiVTvr7TpCfN+tZMwpE2OZfo3y6ckDmLCvrRcNE6EF52nuwzG17R1qKurdWG9SxUsMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFNhhi3S; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFNhhi3S"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c81db32393so34085ad.0
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 22:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782795661; x=1783400461; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qZlx3+QrS8E5J6yUhrTaagwhrce5Kq0xuQVQ07nl46w=;
        b=ZFNhhi3SCjC1Ju3Udz3I1snUMyJ4hFGPbgzlnSpYd7ZejR2E+KR/ZSltaRSF6pkUlB
         PwRjp3fNL76dkvcMJmBwCDWwFJ6nnXGtPGvskPGVzfLRs0vYqaTuvx4SNLzb7oYVley2
         NMmg3+LaprfNyg5A4MDMwdPRAiZ5c37CblXSeYeMlk0EkzCBnHtFEYyiw+3fCug+wQTS
         0EY9fnh0byTcx9tK5dJLqf8AwaV+oyk8zOmMIP8FS7/yqjgn0xRzL6BMY9kONGp02VXH
         a0bf9iS7tqwBypBOxygi+uBhqXDNKm1pyAAK7dcvs8RZheLDDT7PU9Sn6ktIRytfj26e
         XteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782795661; x=1783400461;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qZlx3+QrS8E5J6yUhrTaagwhrce5Kq0xuQVQ07nl46w=;
        b=C/z+PleFfMusm53AmQ1/MTCF5RiSAVC/z/UR7ZcC7Y6dTabMN2K4WvvXRVdHoEFks0
         DcYR3W1Hb8k1lj0A7IZ/ImhUX859KOLR90DC1s2hUHo2BIuPqUQZruCfsUsnl/rjwWfs
         NJw0JUiGJNBYtyOv3lQFhQgf2WtQvzy+Z0JCNSz2usmw+ZnRlADIyzLpKgQW3DpIWB4i
         uHE8XXhsMtTuBlhgnzPVQhVaKd/VsY2atmSlYB9xD3dv1SEkA4CBdfdIFSP/27x4kO/8
         40AE26VQbrIMVtCZgMZVjnNxiWaO9j1Z7KsCQ5z8XsSgNCE4sxhQUFN7idB33Xq36xNQ
         0ezw==
X-Forwarded-Encrypted: i=1; AHgh+RrFCEXY/OaozBlX66uF4zAbID6kDF2cX5Cutd8cWMl9ammV7GKx3w9hDQ9UlngnRC9GFEY4JQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9l5HvLl+5x9Mnq0HZY9m26RhwtaDgoQ9Hc9TnPzfkK+0QJhVs
	85HPXB/BLtVJQ0g0bnU750CngAYrnEIwBYPA6ehsOjyDWczn2Qnl2Uxs3Nf3Yv7Cog==
X-Gm-Gg: AfdE7cn2scMBlE1bw1okLPM9lF30wPbVwaALIcXLW44z5I6CWs3EYKCEyi4iLHqhEAr
	AgE2F0yLZvWcx40q/Hnx4upfsvJlGho4pmj9YhijDJgO0RSQP1dqG/3LIHzYrCBvxTPzNxH58FM
	TEITEpJ92v7PEXRaUP5/OHR82S5upUSS3yvxuOpvrBdoSl3Wn0dnRO4KQkAPuiN4SIU74Wci1Ai
	ds8flScegWCQLWJBnSNAcfTEGaK2VOP3QVt7GLxIUDyOEdfJTLCTsj+UMnmLhUzEa+9EULiWs1W
	WYON1q5ptYk1AI2PTixzO10D/uw32umLLf7PeYpHsHs6BVvXoiKfCF37JUcIltjr8rjowUYsT8s
	TXqiNnJhmSQRh3Q+HFxnwxQx10SJbzxWXVOpmqPjiBeh98bIeJao45q+XsPKs6eRL7xznWAZA4m
	SlN8oqnTTjAQSYroBTiyFDmCBwGBrspQVuNn97FVN4kTD66Z0=
X-Received: by 2002:a17:903:240c:b0:2c1:ee6e:be1d with SMTP id d9443c01a7336-2ca3df01df2mr507815ad.27.1782795660514;
        Mon, 29 Jun 2026 22:01:00 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a02cd237sm986590b3a.32.2026.06.29.22.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 22:00:59 -0700 (PDT)
Date: Tue, 30 Jun 2026 05:00:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v6 3/7] iommu/arm-smmu-v3: Do not enable EVTQ/PRIQ
 interrupts in kdump kernel
Message-ID: <akNNhjmOulawZwX1@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <e643786d849d274c1d8dcfc03795f572aef812bd.1779265413.git.nicolinc@nvidia.com>
 <akIxS7kuhuLRHAMg@google.com>
 <akNCuEfZ30Gf21iQ@nvidia.com>
 <akNM5peYovV3GdV4@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akNM5peYovV3GdV4@google.com>

On Tue, Jun 30, 2026 at 04:58:14AM +0000, Pranjal Shrivastava wrote:
> On Mon, Jun 29, 2026 at 09:14:48PM -0700, Nicolin Chen wrote:
> > On Mon, Jun 29, 2026 at 08:48:11AM +0000, Pranjal Shrivastava wrote:
> > > On Wed, May 20, 2026 at 10:03:20AM -0700, Nicolin Chen wrote:
> > > > @@ -5020,19 +5029,30 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> > > >  		/*
> > > >  		 * Cavium ThunderX2 implementation doesn't support unique irq
> > > >  		 * lines. Use a single irq line for all the SMMUv3 interrupts.
> > > > +		 *
> > > > +		 * In kdump, EVTQ/PRIQ are disabled, so no threaded handling.
> > > >  		 */
> > > > -		ret = devm_request_threaded_irq(smmu->dev, irq,
> > > > -					arm_smmu_combined_irq_handler,
> > > > -					arm_smmu_combined_irq_thread,
> > > > -					IRQF_ONESHOT,
> > > > -					"arm-smmu-v3-combined-irq", smmu);
> > > > +		if (is_kdump_kernel())
> > > > +			ret = devm_request_irq(smmu->dev, irq,
> > > > +					       arm_smmu_combined_irq_handler, 0,
> > > > +					       "arm-smmu-v3-combined-irq",
> > > > +					       smmu);
> > > 
> > 
> > Are you sure?
> > 
> > __setup_irq():
> > 1497-   /*
> > 1498:    * IRQF_ONESHOT means the interrupt source in the IRQ chip will be
> > 1499-    * masked until the threaded handled is done. If there is no thread
> > 1500:    * handler then it makes no sense to have IRQF_ONESHOT.
> > 1501-    */
> > 1502:   WARN_ON_ONCE(new->flags & IRQF_ONESHOT && !new->thread_fn);
> 
> I meant without IRQF_ONESHOT: 
> 
> is_kdump_kernel() ? 0 : IRQF_ONESHOT, note that devm_request_irq is just:
> 
> static inline int __must_check
> devm_request_irq(struct device *dev, unsigned int irq, irq_handler_t handler,
> 		 unsigned long irqflags, const char *devname, void *dev_id)
> {
> 	return devm_request_threaded_irq(dev, irq, handler, NULL, irqflags | IRQF_COND_ONESHOT,
> 					 devname, dev_id);
> }
> 
> Not a strong opinion though, just suggesting a way to remove the if.
> 

I though I had given an R-b earlier, but I didn't.
With that nit:
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

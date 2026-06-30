Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0903E1CEB
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 04:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795504; cv=none; b=vAgO1/bzxXwdh6BCexgJ5xnNeyo8MqU4gSeUIJ+e9GdEmKoj40eE5HdnHbIeNYIMemIRvYA3vv1M8HIm7dmdhtR7aJV7hW64wha+CNVjrgke+AK8M89u7qtaIjhQRXbbe05iTAvuyOanPFMAqondF2SAYoltaMgi/cOwEc1/KiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795504; c=relaxed/simple;
	bh=PDtmAlN/l3AacalC3gwsynICMhrvd+rFwPMR8b97xBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWGYUmsadC4V8IleRXzN0nf6zXT/qyS6c2HurA9BAu1G6rE5zj2PU8zAeCGxNPrrYWN5bJLjpWmr+9K6fXXJSacjf9vxHN7S0dimuie8rqvFdWAFPctYCkcOM5RB12buxtR+vnX4hwaP134m5jpsyf2IBi4BkIEezLD6hiZIOC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L7As44px; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L7As44px"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c9b2ac97cdso19365ad.1
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 21:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782795502; x=1783400302; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BTfbnMUIEG0n8Nzn7+iH305BTPpn6kW1wYaDzBzIPgA=;
        b=L7As44pxsM1ts01NDuzFy1PClcyixkkw2xwl7J9q7qJ/56q/0+jFWr4wsz8syO1xAX
         +1Qtttzi7Zk+gJ70OklkdPyY2Nm2AXzHVKQtTkC2I2AoXOo0oM3TZfEGYXuvSLJc4KAg
         oIqySWJVNKItoD9GbAfw71wKHVMWG2TypBoDurhuEiezfVyyU46RCLgG1OxQWIqc3GGS
         AQGp/izXc4+VCrTpMkCbgsPERRIn60rcJMKGJ2ZqA3e2QNOScTd10rxiP3af47cDUksl
         HltHHIu0QSartvYo0p1BUMJwSVaTGGVqBFM7iztyEOzuGM8DHEZMohkaWuvSsA4hZiGi
         qBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782795502; x=1783400302;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BTfbnMUIEG0n8Nzn7+iH305BTPpn6kW1wYaDzBzIPgA=;
        b=S9ARBgL1wbn56zc2NE+YToSTvcotzoHkKS8qnEQPtNrn93JJbtMgiKTFtJY5RUo7kE
         hxtKUl+wrhA1jgGp6icUyP2nouXOcYKGeGRtij3sCmAzlPW3jKKMiIVw1OoEbynXlBGB
         sZ/pYkdSfo3bU4uuKmCwoPRnpzRO9zJ1Ir5I08Zzm4ysrJ9Ec2mTc2XfF+sTIDu+/mm7
         +4jqu+8L53GCvJdSt82lkCBLUwkdC3Sws+rYsBE6tB5bFTfBH3OTsCvP/8aDu1VFFeEK
         fIM5zPPuW1rpt0ZQ6JqgAF3wVN/RWFVaaTmTdn7iJ4gdvdElFqVufbDZU+HiB2Qpa9qR
         hYiw==
X-Forwarded-Encrypted: i=1; AHgh+Rr0opA0rAzY4K/gAhnlA3qq6YaNMvVzWG9VlHRx4/GuBhugI26Ywnlh3+47ZKtiqIFTIigmqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBNIXSvv+up8k1wHIt8M1RN2+MoEhD69QWTntJgHcRIqjcYt5c
	W1AVrhn5SMI3kZtxrFebS1FkhRqJ6X50DZRISW7h1Txp7Wmpw3UtaEJZcdlzlX3FeA==
X-Gm-Gg: AfdE7clbB5LGly2/90D8cVXeV0P6IhXbHzk4w4VmbTIxyEQL2pCCUJsLwUir2Wy6p2+
	UBPCYI35Qxm8QZL5JnWjrJESeKRW57mfj9t5JkF5nIDbvZIEaCaq5J7rP0aXbM27U/V3tEeJ1yz
	UJ6AwbqcTaWbZ+PHl+WQSL8CrKzVC1T7lnOSHGpL8deryW/8Q5U0MkLvmORVxLZumBTDu9NiB2m
	ZHzUxc1yh0DqppLXrntowZs4sKE53Rh5RBoBpnKiL5Qslx5PTqjkYVwbyEmRfNacPf2PziofV0I
	Cl+c+2oUapeLCDR88OKUcCAAJqPT7Lq+/K3UDnJcbMMOCP6u5XNg7h4NXsUs2d318mEGl5PKjOq
	uKUpq2LArJu3AAWcg0S1Aj67OvfdScmF+ibeJ8zRFpxaoDufsZy4Zyen8ZMJl9BfOnd/ouOkIIc
	hW1bRPBScID5eWkZu6A+ZldqL9CqvWIFX0lAB5o2hPKztBSgI=
X-Received: by 2002:a17:903:26c5:b0:2bf:3579:cdaa with SMTP id d9443c01a7336-2ca380db35emr922105ad.10.1782795501571;
        Mon, 29 Jun 2026 21:58:21 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38052f3281dsm859454a91.12.2026.06.29.21.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 21:58:20 -0700 (PDT)
Date: Tue, 30 Jun 2026 04:58:14 +0000
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
Message-ID: <akNM5peYovV3GdV4@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <e643786d849d274c1d8dcfc03795f572aef812bd.1779265413.git.nicolinc@nvidia.com>
 <akIxS7kuhuLRHAMg@google.com>
 <akNCuEfZ30Gf21iQ@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akNCuEfZ30Gf21iQ@nvidia.com>

On Mon, Jun 29, 2026 at 09:14:48PM -0700, Nicolin Chen wrote:
> On Mon, Jun 29, 2026 at 08:48:11AM +0000, Pranjal Shrivastava wrote:
> > On Wed, May 20, 2026 at 10:03:20AM -0700, Nicolin Chen wrote:
> > > @@ -5020,19 +5029,30 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> > >  		/*
> > >  		 * Cavium ThunderX2 implementation doesn't support unique irq
> > >  		 * lines. Use a single irq line for all the SMMUv3 interrupts.
> > > +		 *
> > > +		 * In kdump, EVTQ/PRIQ are disabled, so no threaded handling.
> > >  		 */
> > > -		ret = devm_request_threaded_irq(smmu->dev, irq,
> > > -					arm_smmu_combined_irq_handler,
> > > -					arm_smmu_combined_irq_thread,
> > > -					IRQF_ONESHOT,
> > > -					"arm-smmu-v3-combined-irq", smmu);
> > > +		if (is_kdump_kernel())
> > > +			ret = devm_request_irq(smmu->dev, irq,
> > > +					       arm_smmu_combined_irq_handler, 0,
> > > +					       "arm-smmu-v3-combined-irq",
> > > +					       smmu);
> > 
> > This `if` isn't needed, we can continue using devm_request_threaded_irq,
> > if you look at the doc for devm_request_threaded_irq [1] it says:
> [...]
> > So, we can pass handler() here while leaving the thread_fn == NULL:
> > 
> > ret = devm_request_threaded_irq(smmu->dev, irq,
> >          arm_smmu_combined_irq_handler,
> >          is_kdump_kernel() ? NULL : arm_smmu_combined_irq_thread,
> >          IRQF_ONESHOT,
> >          "arm-smmu-v3-combined-irq", smmu);
> 
> Are you sure?
> 
> __setup_irq():
> 1497-   /*
> 1498:    * IRQF_ONESHOT means the interrupt source in the IRQ chip will be
> 1499-    * masked until the threaded handled is done. If there is no thread
> 1500:    * handler then it makes no sense to have IRQF_ONESHOT.
> 1501-    */
> 1502:   WARN_ON_ONCE(new->flags & IRQF_ONESHOT && !new->thread_fn);

I meant without IRQF_ONESHOT: 

is_kdump_kernel() ? 0 : IRQF_ONESHOT, note that devm_request_irq is just:

static inline int __must_check
devm_request_irq(struct device *dev, unsigned int irq, irq_handler_t handler,
		 unsigned long irqflags, const char *devname, void *dev_id)
{
	return devm_request_threaded_irq(dev, irq, handler, NULL, irqflags | IRQF_COND_ONESHOT,
					 devname, dev_id);
}

Not a strong opinion though, just suggesting a way to remove the if.

> 
> > Additionally, the arm_smmu_combined_irq_handler() returns 
> > IRQ_WAKE_THREAD unconditionally, which causes us to hit the warn_on[3] in
> > __handle_irq_event_percpu.
> 
> arm_smmu_combined_irq_handler() does not return IRQ_WAKE_THREAD
> unconditionally.
> 
> This is the first part of PATCH-3 in v6:

Ahh I missed that, somehow.

Thanks,
Praan

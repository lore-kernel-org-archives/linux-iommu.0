Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795280543;
	b=fToHrgS6LnfBPh1HBMy2QzRcwVWqJyEFrdz+u21uNZl1zCzBF0oKvpUiHWws+Nslq1nf
	 8As3gW4L5Qz4LoljA57ZZ32fiZMC4Q4B05f52ouuZ5RaUaBHhHPvgS6P93jUFlTsTaK9C
	 RRuFo/o9GLHGB8O/cKIzR43TwgGpLbfzCTzVeS4R+rcDE6gMTrc3NRXw1Q11+90nqU35f
	 XVcbGMYptJ9AVlvpNiIhzAE0rae3wie+FbIRLvkD0jCpUVODd5ReBVKD0r98KSJXx5wEJ
	 I/Sf4/ESgUTWoqXVmDdskdXee+snJTbIMSJaAy4HrmS+36PPLMiFf6BFnKVYOyskE4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795280543;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dMtaAY/RAlKbBtwNvRopdcHPdD6orOkNe2lC7iDdMNw=;
	b=t1tITiR7QHWyxZ+iX5X5VTBKBxZKYsuAnzSJm2BvjfuTaT6ur3jARSSp1Mp6SzaJ/l5p
	 a3l3U8m7xRxUhlB7ffFeZ8hst6Ecs8lL0YGEaXPEUcxF0yHfgTYIoKC9T/E9eA8BJUfQD
	 KNjo6KsnXltztG0wBJwBXGzZhig6O68w8hpR/F/wKHPVwicfA08p8UR4hbknxmBjL2u/s
	 XnoUxhRb9cFhei4RVnIgQa4eiesQ8at4eItJ74l4JZz75emHwP9VzueEW9Y298JXfq/dD
	 dDTCzJEwAhWw+s8YuOdKV2jOXtDybmQcnzJM+xYUQE0A4k7zx1STQPSF5hMaSFb0QKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BdeUELnF;
	arc=none smtp.remote-ip=95.215.58.65
Received: from mta1.migadu.com (out-65.mta1.migadu.com [95.215.58.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAAD606A32A
	for <iommu@lists.linux.dev>; Sat, 21 Nov 2026 17:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFAAD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BdeUELnF
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=120vruIvVuVMsi4eadSo5mQWHm7BqnKtIE9tM2dix/Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795280539; v=1; x=1795885339;
 b=BdeUELnFusdi4TW9ZcGg2IqmMKk+d2Lx+lb15psooUk/UHZRLaRFZHQAKz7A3vAYT39yaa7s
 xSiAlEk6skdrxvRoG+dnpjUlpMu1f5zECSw6No1SkbS6Opvr6igsAVgSIbbuAQ/fvUU8DBZbOmU
 XFB2QttYodDmae0e4merQxus=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 66ce02f06bdb1801;
	Sat, 21 Nov 2026 17:02:19 +0000
X-Mizu-Trace-ID: 66ce02f06bdb1801
X-Migadu-Flow: FLOW_OUT
Date: Sat, 21 Nov 2026 18:01:46 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: andrew.jones@oss.qualcomm.com, anup@brainfault.org, 
	atish.patra@linux.dev, fangyu.yu@linux.alibaba.com, iommu@lists.linux.dev, 
	jgg@nvidia.com, jgg@ziepe.ca, joro@8bytes.org, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com, tglx@kernel.org, 
	tomasz.jeznach@linux.dev, will@kernel.org, zhangzhanpeng.jasper@bytedance.com, 
	zong.li@sifive.com, gsh517025@gmail.com
Subject: Re: [RFC PATCH v3 04/14] iommu/riscv: Reject live S2 replacement
 with forwarded IRQs
Message-ID: <awHLO6bWYw5V0k4p@orel>
References: <20260928143113.49838-5-andrew.jones@oss.qualcomm.com>
 <202610090914.6999EfSj006317@mse-fl1.zte.com.cn>
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
In-Reply-To: <202610090914.6999EfSj006317@mse-fl1.zte.com.cn>

On Fri, Oct 09, 2026 at 05:05:30PM +0800, Gong Shuai wrote:
> Hi Drew,
> 
> > MSI forwarding state is tied to the S2 domain MSI table. Replacing a
> > device's S2 domain while one of its IRQs is forwarded would leave the
> > IRQ state referring to the detached table.
> > 
> > Reject direct S2-to-S2 replacement when the moving device has forwarded
> > IRQs. Introduce a per-device nr_forwarded_irqs counter, rather than
> > domain-wide accounting, so other devices in the same IOMMU group can
> > still move and can be rolled back if a later device fails.
> > 
> > Later patches which introduce interrupt remapping support will manage
> > the newly introduced nr_forwarded_irqs counter.
> > 
> > Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> > ---
> >  drivers/iommu/riscv/iommu.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> > 
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 57f2884dec42..d48667112cd9 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -872,6 +872,7 @@ PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
> >  /* Private IOMMU data for managed devices, dev_iommu_priv_* */
> >  struct riscv_iommu_info {
> >  	struct riscv_iommu_domain *domain;
> > +	unsigned int nr_forwarded_irqs;
> >  };
> >  
> >  static struct riscv_iommu_msi_table *riscv_iommu_domain_msi_table(struct iommu_domain *iommu_domain)
> > @@ -1432,6 +1433,36 @@ static int riscv_iommu_msi_table_alloc(struct riscv_iommu_domain *domain,
> >  	return 0;
> >  }
> >  
> > +static bool riscv_iommu_can_attach_paging_domain(struct iommu_domain *iommu_domain,
> > +						 struct device *dev,
> > +						 struct iommu_domain *old)
> > +{
> > +	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> > +	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
> > +	bool new_is_s2 = domain->gscid;
> > +	struct riscv_iommu_msi_table *new_msi_table, *old_msi_table;
> > +
> > +	if (iommu_domain == old)
> > +		return true;
> > +
> > +	new_msi_table = riscv_iommu_domain_msi_table(iommu_domain);
> > +	old_msi_table = riscv_iommu_domain_msi_table(old);
> > +
> > +	if (new_msi_table)
> > +		lockdep_assert_held(&new_msi_table->lock);
> > +	if (old_msi_table)
> > +		lockdep_assert_held(&old_msi_table->lock);
> > +
> > +	/*
> > +	 * Per-device accounting allows other devices in the same IOMMU group
> > +	 * to move or roll back while this device has forwarded interrupts.
> > +	 */
> > +	if (new_is_s2 && old_msi_table && info->nr_forwarded_irqs)
> 
> This check might miss one case. old_msi_table comes from this
> attach's old domain, so only a direct S2 to S2 swap is caught.
> A device with live forwarded IRQs can still be moved to blocking
> and then to a different S2 domain, and on that second attach old
> is the blocking domain, so old_msi_table is NULL and the check
> passes. This is only from reading the code, I have no test program
> that triggers it.
> 
> If you think this is a real gap, one idea would be to record the
> table the forwarding was set up on in riscv_iommu_info(a pointer to
> riscv_iommu_msi_table), set when the first IRQ of the device is
> forwarded and cleared when the last one is unforwarded. The pointer
> survives the blocking hop, since attaching to blocking domain only
> clears info->domain. Then can_attach here will reject when the new
> domain's table differs from it. That covers both the direct and the
> blocking case, and the PCI reset path still works because the device
> returns to the same S2 domain. The unforward path can use the pointer
> instead of info->domain. Note that the S2 domain owning the table
> must not be freed while a device still points at that table.
> 

Hi Shuai,

Yes, this is a gap and I agree we should track and check the association
for the fix. For v4, I'm looking at moving the MSI table configuration
into a VM-wide object which S2 domains reference, similar to GICv4's
its_vm. The recorded pointer would then be to that object, which the
hypervisor keeps alive until every forward is undone.

Thanks,
drew

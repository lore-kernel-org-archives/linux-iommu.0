Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E1F390985
	for <iommu@lists.linux.dev>; Sun, 31 May 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780247618; cv=none; b=ujPBNYv9N4VATlqpWIl4Tl1kOknvVQs3/7RJ5v7OP8VDmrhHZeGs0gx284PCNdvtU1gXWSUoxOm8VyOUdMS/esLvNrsitzIgNUrzr9hpmdOc0H9DP3qOsaMkuy3luGmvSdfpND5UjWDrmYI1uVRNMwAvtWJ/kS7u4Ciodz9wwQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780247618; c=relaxed/simple;
	bh=7FI94Dq1nh1tq5EHXeCQHA7vvcz73nqzDPko5g+75sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSfEPKr3QEzG4iqEzzUJq+fa8Xil9MaL2THsMd+tJqAeibzIrxiKyRcDoWHi0UXyG3RYQmrxWtYbYVnF18g0udxOGTnIBbyR0PrC8EJ+G6Tz5UcM4ku7uC4XZlprqTTD2Kfu4MKmkk3BV2EmBUhR+HHqfeCQQ+3eRh2Bv1SGEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jy2w8oti; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jy2w8oti"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0b1a48855so715ad.0
        for <iommu@lists.linux.dev>; Sun, 31 May 2026 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780247617; x=1780852417; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qtFz/hC3O8enmBfuHY94wDqD/sImgOOHpNXD3ZxO5m0=;
        b=jy2w8otiarLgB0QlpqfredCAF9QT7MUuLUDXfHVFDVzvbvz4poaj0Xg5URzRefpklI
         65K8eUUAagOk4mDwpI7G0b01Ts2E7I+vBlcHqUd7iZke91noMVLxePPkhN4dvCn5/y/t
         bDKrYN94w369wQ5huWCUUywSFHYzvXaZtOc9CD3j0oMiFrO/vx8Gz5qPnx1wbM/8VTPP
         ykrvw1sG8JJWgLY666mIYdOS9dbBQ13lTNqWv0LWgsrxjZPVVir+ZfZCGTKiT7IxKvOh
         IpQPcRrJTTnzAm0mbbAp30jkUy3xGHJzsTM4VtZscdaf0pdzt2N3Y8aANyD9Wm7ubB7u
         9RRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780247617; x=1780852417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtFz/hC3O8enmBfuHY94wDqD/sImgOOHpNXD3ZxO5m0=;
        b=PFXUobsFswnjkk+R8JxaWy/EsCZL8aRSQ3gECftzeDC10p8PwSlHemXnbgnG4paOkW
         3B08ARYmZx0Ibf3+h3TT/9bLIKkksgkLspO9u6kZjzeAqvQCRjAUxgQ3mrm3B6fcTvf4
         zrFbe0SO01cyiGPWa6upUX1aZqQYIP7R0UQd4jnylwm2P44FtBL/LKE5xSuCN+60p849
         FSn7ZnNxPRXMBTq/H9uPRPo9TWMn95ADWw0vamW0lqXCaffafyEB2PxeruHJBGJVqLJN
         XegIUcZ7lFPYH4tS62Uhob7EWAzdgAxsRea/vwtAJcHvWPYbEG+CL0iubOwbBGhgBm3k
         XOHA==
X-Gm-Message-State: AOJu0YwLdA2nqliv6mpxiICav0lEobW+MO2oLcpG8y4Ctwf65WEHCtew
	kLyYa4oe24kqVe6KB0DLtYQ9a4SIlccpQkh6cPWJpvfdcErX9E1Ad3ZB5oBaOuYdPA==
X-Gm-Gg: Acq92OGe3KiUdB1+My8LF6RpltiJoxHbpoTpxDpqEEYeqC8riLij3XI4utr0l1h4ZRk
	tY+Ys0PEHCVrDM1u5+CUPwGNs7VldOm9sR5BBMicF99u4gIwmpbClxcpymWPlbdA1Fknx/R022m
	xXFNyYzqUCxsgDfxw1e+YYzXrECl9M0tkHDLAmEUgvLca+op6HbZq1KMGQQQun+2hfes9ukEyki
	DNGgShxHbzW2zQVNR2USo4RqdAOj0H5UhV3TpqNvBlSZk2n+qIEwbfRHd6Rb06/gUo2hIKKnO64
	82SFuWeTlSypFfJ5SA5q17+2guG/29sgWCtB1zSF18Kc/yf/mvSIqlivfeBYUPqJekEoXrTqf4Z
	1ooNjpjA9G2KEs6RilFxkS2jFDFsVq5ZOkhjzr80BBZP/DI3P+5O0CB21U3a+yTvzjDY34NFApu
	GRLnRI/YWKmlM2zW/342BYWUugYthMKbRSXsOrK6hrozAHLZa79/fYz8j3yuw4+1E6bRoDO+I=
X-Received: by 2002:a17:903:41c6:b0:2b0:b0c9:96e2 with SMTP id d9443c01a7336-2c07cb6c77dmr2512555ad.21.1780247616106;
        Sun, 31 May 2026 10:13:36 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b01727sm84542255ad.53.2026.05.31.10.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 10:13:35 -0700 (PDT)
Date: Sun, 31 May 2026 17:13:28 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v6 4/6] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Message-ID: <ahxsODjvubhUjJjG@google.com>
References: <20260529111208.387412-1-praan@google.com>
 <20260529111208.387412-5-praan@google.com>
 <ahoKeEmFhU8nWV3P@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahoKeEmFhU8nWV3P@Asurada-Nvidia>

On Fri, May 29, 2026 at 02:51:52PM -0700, Nicolin Chen wrote:
> On Fri, May 29, 2026 at 11:12:06AM +0000, Pranjal Shrivastava wrote:
> > The SMMUv3 driver currently has a two-phase commit in its ATS enablement
> > flow. During arm_smmu_attach_prepare(), it predicts whether ATS will be
> > enabled using arm_smmu_ats_supported() and accordingly increments
> > nr_ats_masters and merges ATS invalidations into the domain's invs array.
> > 
> > However, the actual hardware enablement via pci_enable_ats() happens
> > later in arm_smmu_attach_commit(). If this call to pci_enable_ats fails,
> > the SMMU driver's ATS state tracking remains polluted, i.e., the driver
> > tracks ATS as enabled on a master that is not actually using it. This
> > leads to an incorrect nr_ats_masters and triggers a warning in the PCI
> > core during detach:
> > 
> >  1 [  127.925080] ------------[ cut here ]------------
> >  2 [  127.925084] WARNING: drivers/pci/ats.c:132 at pci_disable_ats+0x94/0xa8
> >  3 ...
> >  4 [  128.068169] Call trace:
> >  5 [  128.070603]  pci_disable_ats+0x94/0xa8 (P)
> >  6 [  128.074688]  arm_smmu_attach_prepare+0x104/0x310
> >  7 [  128.079292]  arm_smmu_attach_dev_ste+0x128/0x1e0
> > 
> > The issue was exposed under heavy load when running a VFIO-based DMA
> > map stress test (iova_stress).
> > 
> > Following the addition of the arm_smmu_master_prepare_ats() [1] helper during
> > device probe, failable ATS configuration (STU setup) is now handled early
> > during probe. This ensures that any master reaching the attach phase is
> > guaranteed to have a valid ATS configuration.
> > 
> > Update arm_smmu_enable_ats() to use the WARN() macro for any
> > subsequent enablement failures during the commit phase. Since probe
> > checks now preclude software configuration errors, any failure here is
> > considered a kernel bug.
> 
> The commit message feels like mixing a stale background and the
> real requirement (based on the latest code line). Could that DMA
> map stress test still trigger the WARN_ON in pci_disable_ats(),
> after having arm_smmu_master_prepare_ats()?
> 
> It'd be nicer if the writing can be simplified a bit.

Ack. I'll re-word and remove stale context.

> 
> >  	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
> > -	if (pci_enable_ats(pdev, stu))
> > -		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
> > +
> > +	/*
> > +	 * Any failure at this point is a kernel bug. pci_ats_supported()
> > +	 * and pci_prepare_ats() have already verified the hardware capability
> > +	 * and programmed the STU. Thus, pci_enable_ats() should not fail here.
> > +	 */
> 
> The patch that removes pci_ats_supported() from pci_prepare_ats()
> is dropped in this v6. So, my previous comments may stay true and
> the two lines can be enough?
> 
>  	/*
>  	 * As pci_prepare_ats() have already verified the hardware capability
>  	 * and programmed the STE, pci_enable_ats() should not fail here.
>  	 */
> 
> > +	WARN(pci_enable_ats(pdev, stu),
> > +	     "Failed to enable ATS (STU %zu)\n", stu);

Ack. I'll update this.

> 
> https://sashiko.dev/#/patchset/20260529111208.387412-1-praan%40google.com
> Please check Sashiko review (for other patches in this series too).

Yup, already sent out a series [1] to address Sashiko findings
separately.

> 
> I think it'd be cleaner to just have:
> 
> -	if (pci_enable_ats(pdev, stu))
> +	if (WARN_ON(pci_enable_ats(pdev, stu)))

Sure.. I'll also maybe keep the dev_err log that we have, knowing STU
mismatch is slightly helpful.

Thanks,
Praan

[1] https://lore.kernel.org/all/20260531170254.60493-1-praan@google.com/

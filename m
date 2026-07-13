Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34A310645
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958621; cv=none; b=RroDzOZn2cjxBwOLzWHjiEan90vzQnns0wmeyQiKXOoxVTZrk6aVSK0CHowxNpMdlPdHcC2JG7W5mgviOdFoYauV9gTQcfu2Cb6/07LSaOk6UJYQu+3V0wdNVrm4RvTMLLFVLOWWPNs1YagjBEIXjq31ChGDsENFoFzDNX0lPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958621; c=relaxed/simple;
	bh=Pylmx3Gl6thtuFKM5DfdQyuRxFbrHIWdSRzSM7xJa5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSMMSlVU50SD2CogyQw/beDbJ3Mm1we0mbw99NWATEPyMeWTOedD2w9svT7R/u6uucBMyDRRI4TjBx3CMQp2KhL5mtt0ufiPxb3ARSavg4a7mL/0Kbb3XGfmmTnZy2UTGsqt70s0lp8iywZAtQQs1GpzPaEIitqODW7WlTF87bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oLB5L55O; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLB5L55O"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-472326ca506so2722393f8f.2
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783958619; x=1784563419; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=56E+7FMMOWqDmBxT+WtZLGSI2R/SROVQv8aPW35xP7c=;
        b=oLB5L55OVTUDQpSN7zyidCYDaezc86MdWMNCssJyVsJCp0Zr4PEY7lY/LxbQexsJtt
         /uC/ZJGqfIzOeTrQAcxhDlE6XM8SAZtfk+mWgGgPDR78iv8ka3R8IfeETzpsEq5lthCa
         h0AiFZftLv58O8rIPWH2d2RMtD19q7ZMDU5CwA20WojHpV62JUTt3+e3TVNgNJxJML4a
         /Woj+F5V1y9yYMPRYHpig6DGBmFqcqHB2XK48QZ7NbZ5uM8xaCNcBt4oizEWQIpwpUkw
         4cq855Elk8eZ+v7qegN0hgT+i5xzU7VQf9+PwdcihuuSio4okbSmsLIjM8EpPxdF+HfQ
         6eIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783958619; x=1784563419;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56E+7FMMOWqDmBxT+WtZLGSI2R/SROVQv8aPW35xP7c=;
        b=Afo1ippDuzJlUEN6qMvAnVIETDOSB7ublI49fTzkPHg1K/uBggaAYxD2DdhnlsPPRf
         /AZLbcVE+IU5ChQc9GcMxiKexCd+i0JlZU1Rk9LgC0ovQ9ZDFvD8/HFMe4waCVRzwmoy
         pL1X4ku3g8nn7jnPiky9G7aVDCc+32/dD8KgzatgLdL0DE0Pl5SHsWiKzbh5+Ztb2qrC
         vP4fouAPOfJoUAEHsr9SArp0+Nt+RUgQLgewBYKP02Tba69tWfNUC+PHXxpcyULSvWzP
         yQCU6ClpFpAjdh5WXheo9sb0iTr35hthZgR11tTTolKpUVV2QsFjgxSCvX/QRP+mYx39
         klOQ==
X-Forwarded-Encrypted: i=1; AHgh+RoiXCmvX/XoUHGiFEfxHgWkgqCqUatryIjtOtMFqy8eE8zdTo0+mcxALhpwqz3opFy4jKSjdw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5LMElEl0Eof0xxhPTY2lgMk2TYYlVLHTBeB50KYxco286wnpb
	79mMfMx+eeKBI44UrQX5QzKyWLbZL0Vu5yINiTWhLZDHTnx1VGGarQ8+p+8Irupvow==
X-Gm-Gg: AfdE7ckcJrjKnXhPRLpn2JrOZe8V6n/DmxLa00ZOyRYeh7EbVGp7hxlcwJxl9fsHpFI
	s74bmV/1+6UDmPYDri5cc1tsqg58GTsam/Q90eO8/G8I9/i3pzoI4CNaQmQFC5HQGDztmDfwb1K
	2XMh3S+jN5stsYj29WohDEyaoc6lceMlCEZ40QNryniQudUjg7NREM+oKN1hhdLMxhBlp97MjFL
	rDbb73AUln8Z6IsK+RJCklc4cbFL1GutDTea7DCqwFMne1ooKF/6lU7UhOMWC9jFNaLfUqe+P9v
	Nb44PmBGxdvinr96iwH/jE3i/6wsayjsAfw/JWl16t/+cA/kHD5syqtDAQ8EeAgRX52mj2VmFKZ
	wrVlLf9GY5D2c9bysfP79b06Fzxe6JZgDegTVryo0rRBo346ZTaD8qHmZCqw/H7dGhBZK42KQJn
	FH6VoorcLxllCrudHMg+mTvIrLWFEvmZIg5O7ZmScIA5/qPEongQc=
X-Received: by 2002:a05:600c:1d89:b0:493:f29d:d591 with SMTP id 5b1f17b1804b1-493f8837f95mr107335125e9.39.1783958618287;
        Mon, 13 Jul 2026 09:03:38 -0700 (PDT)
Received: from google.com (137.69.77.34.bc.googleusercontent.com. [34.77.69.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464b7f84sm323988f8f.27.2026.07.13.09.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:03:37 -0700 (PDT)
Date: Mon, 13 Jul 2026 17:03:33 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	jgg@ziepe.ca, mark.rutland@arm.com, qperret@google.com,
	tabba@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 08/25] KVM: arm64: iommu: Shadow host stage-2 page
 table
Message-ID: <alUMVU7DYcrvgAYi@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-9-smostafa@google.com>
 <alTnAy7jvjUamwUA@google.com>
 <alTvf7iiOWn4PKE8@google.com>
 <alUA7zsJO1FGnss-@google.com>
 <alUJa5cbjjqZ8n72@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alUJa5cbjjqZ8n72@google.com>

On Mon, Jul 13, 2026 at 03:51:07PM +0000, Mostafa Saleh wrote:
> On Mon, Jul 13, 2026 at 04:14:55PM +0100, Vincent Donnefort wrote:
> > On Mon, Jul 13, 2026 at 02:00:31PM +0000, Mostafa Saleh wrote:
> > > On Mon, Jul 13, 2026 at 02:24:19PM +0100, Vincent Donnefort wrote:
> > > > On Fri, May 01, 2026 at 11:19:10AM +0000, Mostafa Saleh wrote:
> > > > > Create a page-table for the IOMMU that shadows the host CPU stage-2
> > > > > to establish DMA isolation.
> > > > > 
> > > > > An initial snapshot is created after the driver init, then
> > > > > on every permission change a callback would be called for
> > > > > the IOMMU driver to update the page table.
> > > > > 
> > > 
> > > [...]
> > > 
> > > > > +	 */
> > > > > +	if (pte && !kvm_pte_valid(pte))
> > > > > +		return 0;
> > > > > +
> > > > > +	if (kvm_pte_valid(pte)) {
> > > > > +		prot = pkvm_to_iommu_prot(kvm_pgtable_stage2_pte_prot(pte));
> > > > > +		/* If the range is mapped in a single PTE, it must be the same type.*/
> > > > > +		if (!addr_is_memory(start))
> > > > > +			prot |= IOMMU_MMIO;
> > > > > +
> > > > > +		return kvm_iommu_ops->host_stage2_idmap(start, end, prot);
> > > > 
> > > > Do we really need to do that when is_memory()? 
> > > > 
> > > > fix_host_ownership_walker() by calling host_stage2_idmap_locked() and
> > > > host_stage2_set_owner_locked() should already handle the memory region. That
> > > > would also get rid of kvm_idmap_initialized.
> > > > 
> > > > So this one here could only take care of the MMIO?
> > > > 
> > > > Overall we would have a common point of synchro which is
> > > > fix_host_ownership_walker() after which the host ownership is ready for both
> > > > CPU stage-2 and the IOMMU?
> > > > 
> > > 
> > > I am not sure I understand, this is another empty page table, so we
> > > have to walk all of the host CPU stage-2 page table to shadow it in the
> > > IOMMU. if you are refering to the case where it handle zero ptes for
> > > memory, I can drop that but it will not change much in this logic.
> > 
> > In fixup_host_ownership() we already walk the hyp pgtable to know what needs to be
> > map/unmapped from the host stage-2. Can't we rely on that for the IOMMU
> > page-table as well?
> > 
> > As of, fix_host_ownership() could handle the host stage-2 __and__ the iommu? 
> 
> fix_host_ownership() only walks the hypervisor page table, and fixes the
> hypervisor pages in the host.

Yeah, Looking closer I don't think my proposal simplify things so much in the
end.

> That means that the IOMMU page table has
> to  be fully populated first, then we unmap the donated pages.
> That seems more complicated and it feels that decoupling the IOMMU
> logic outside of this would be better.

Why more complicated? That's actually another solution I was thinking about, to
just map everything as soon as possible and let host_stage2_idmap_locked() and
host_stage2_set_owner_locked() unmap what is needed here. (and also in
__pkvm_host_donate_hyp_mmio())

We wouldn't need any specific setup walker for the iommu at all.

> 
> Also, I rely on the IOMMU init to be done at the end of setup, so we
> do not have to clean the IOMMU init if any other part of KVM fails.

We could just leak those pages if it fails?

> 
> > 
> > > 
> > > > > +	}
> > > > > +
> > > > > +	/* In case of invalid PTE, we need to figure out which part of it is MMIO */
> > > 
> > > [...]
> > > 

[...]

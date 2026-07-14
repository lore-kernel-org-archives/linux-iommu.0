Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121E143B482
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019418; cv=none; b=Qcpxr3Dwc7CQ18G/iARetT4dncTlJdmPMNZ/ml6DAX9eVxQz1HXG7WfuLKmg9k6IX4ZwEe4tsOaTRvSSl4gc73iQtxRt3SxAxbZOEH3jzZwWTn7FU7syAV4tv9HDAiHfbzq4fW15YfO4bWoG9B+qCEO/cuem6ijYPaC98ca1Iic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019418; c=relaxed/simple;
	bh=Bzdu5b5y55NorpL/qYxPJhHOrlRCKuhOC+OyuSYeTXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnjjH45aPxOH4DJGA7HYG+Bc15llpMonZznG1dulYB1YdeXRXIRS2HX+14gblnNd5FzS/Qw1bHiE0Qhroez9vHOI/ej7c//3r/D2N2QFZlYijzkpKZ8qJGmxiJaaWe1mCYpt0WjXkSfr98CLNGTbW48TiFAnYh/+u1ZNaIVPQ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K0lAVd4Y; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K0lAVd4Y"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so45105e9.0
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784019415; x=1784624215; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QyZuaZgVMmJscBeBh04gUUQoTYZ+pKlntaOnTL9z2uQ=;
        b=K0lAVd4Y3oPghYqS6FR3C2OjEW7e8wVg5zaG4muLP0kYfDrNfJos/v0cs3xghN6gDZ
         obTQ8pnptuILZQokAjdo8KMqn7p6KbVKZWiTYzqp9q9Bh43gxRAPa6HCRXHN8gMMWsXW
         LKDQBx/TkTZ8OaMpwO9aEjqMRzC70XDChMWgaVf2uir5K1Zy58Ub9l7n4pqyQxB1QERC
         b6Uv9xi4KaiJTF3VktWLWvMzLoo1IaaoW4h5n/HKnuTxKhF3p4T/Q9X4PHxsM9NwwjjS
         yHKFc0Hm2GMN481/xeiGfWddq9IfkW7Cmz5lslSAxx4xF8L6+J0VYMuEou6Wkz1dtJCs
         F03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784019415; x=1784624215;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QyZuaZgVMmJscBeBh04gUUQoTYZ+pKlntaOnTL9z2uQ=;
        b=QwQL9x7fYSXczWNiHQJnrt2Opo3e8Teq9/+JUJ+PV3NPF6RorrsL+nyeb5x4Q6950a
         bxYawlYRG3UWT+u/gw7g74vz87up6FxojRw/7eQIaG7MqrqsZUkvPmM+6d/+BFHPr4H9
         LctWLMUBasv5WhwETI7LdllRO2U1Io6T70Yrxb8TG08T4Da9cVYErufM9F+MOkAwldoT
         RoV7yvMe7zRRm/nPGYNOwZDeciELk3XYM3efGjnKaXbWs27zUUYh59rfhFq0ELXr9Vc8
         wYgZGQFKEj/uB+kiJCMd2X3at9qGgxVIWo18fYmQbB+QqT4J5XK6FPZ70/hAcVJ95qZy
         9BcA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7OasiR8uvm+q4bT1VvVjQXWh1DLbLJFClBbNWWwzS25GfPnlcKxWzYENNoDeC3jDsNKfpqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyHVGC5p1pZXSECOr6HE+TMcUtUBVODdSYLY9yug687JkunsPX
	juAxRHtMCEBI3XCQCtXAAEDV50SC8PQsJPV1PUiJ9gP+JZ+WSFCKgTRxa7CU8BisuA==
X-Gm-Gg: AfdE7clOmRvY1wlR7hWhfRrIxPe+Xz65D3ObIU5yozuInCsS5Bh29igkSyDbmtlSfKC
	+kXcO8dlMoQsvZhrWUNrvT3EwbXrBoyJiTpuFr1y60v3tkZMCw6gR4X6cHvWu8LkpCZbn4NF1lR
	z+bni232IApvz2FkshRPdvwQqhSW0EJ3xz8+DavS/5Yo6SOwaZhAhM7SpO+b1KcAvxEf1ynhRsg
	GngWyJ26VvFvHXT/SQKrk+tEi5cpeEErX7RJQ0j+9y/HKK/wrC9uE20umGZS29iHYXV+4fWO2Gz
	4RDyG/7gXeMiVKnbt6MVEMCmrMqy78Paa59eoQzcULXBCiuHu8hnmBkvNOTcePUb78RQboxID3+
	PEj9yTjqk/j3Ld8bwxZj/MPwAgbkxHjN5fgFkSZdJ3QMskxSWQw9gpyVKGkvKkuOl00OPRZ49EM
	9BAAw36dz7Ilrxn6oWOZXGIue7+r8VDepSMTucI3yrpTFIE4zA
X-Received: by 2002:a05:600c:8b6f:b0:492:668f:410c with SMTP id 5b1f17b1804b1-494688928b1mr1719985e9.10.1784019414601;
        Tue, 14 Jul 2026 01:56:54 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f9402sm64121965e9.13.2026.07.14.01.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:56:53 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:56:50 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	jgg@ziepe.ca, mark.rutland@arm.com, qperret@google.com,
	tabba@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 08/25] KVM: arm64: iommu: Shadow host stage-2 page
 table
Message-ID: <alX50s8IglxiEHMB@google.com>
References: <20260501111928.259252-9-smostafa@google.com>
 <alTnAy7jvjUamwUA@google.com>
 <alTvf7iiOWn4PKE8@google.com>
 <alUA7zsJO1FGnss-@google.com>
 <alUJa5cbjjqZ8n72@google.com>
 <alUMVU7DYcrvgAYi@google.com>
 <alUsLFBQ5qKFOgwQ@google.com>
 <alXwXRGqECTUZ3ou@google.com>
 <alXzcrnxWADIEL2H@google.com>
 <alX3nHLykNc_nng5@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alX3nHLykNc_nng5@google.com>

On Tue, Jul 14, 2026 at 09:47:24AM +0100, Vincent Donnefort wrote:
> On Tue, Jul 14, 2026 at 08:29:38AM +0000, Mostafa Saleh wrote:
> > On Tue, Jul 14, 2026 at 09:16:29AM +0100, Vincent Donnefort wrote:
> > > On Mon, Jul 13, 2026 at 06:19:24PM +0000, Mostafa Saleh wrote:
> > > > 
> > > > That would walk the table twice, first time with a massive map, then
> > > > to unmap the pages that was just mapped, issuing TLB invalidations
> > > > for all of those, also as the IOMMU page table code never frees tables
> > > > that means we would immediately exahust the IOMMU pool.
> > > 
> > > Well the massive map is pretty quick we would mostly just allocate the PGD? And
> > > then it would be just for the subsequent unmaps to split the blocks. So nothing
> > > to be freed really and no risk to exhaust the pool. But if you put the calls to
> > > the host_stage2_* functions that's pretty transparent.
> > 
> > Not for the IOMMU, everything is mapped with a leaf mapping, because
> 
> Ha Ok my bad, I didn't get that!
> 
> > the pgtable code does not support splitting blocks, this is something
> > I plan to add support for in a follow up series after this one is
> > merged along side other optimizations.
> > 
> > > 
> > > Just to make sure I am clear. Here's what it could look like:
> > > 
> > > in iommu.c:
> > > 
> > > int kvm_iommu_stage2_idmap_init(struct kvm_s2_mmu *host_mmu)
> > > {
> > > 	u64 addr = 0;
> > > 
> > > 	for (i = 0; i < hyp_memblock_nr; i++) { 
> > > 		kvm_iommu_stage2_idmap(addr, reg->start, IOMMU_MMIO);
> > > 
> > > 		addr = reg->start + reg->size;
> > > 		kvm_iommu_stage2_idmap(reg->start, addr, IOMMU_READ | IOMMU_WRITE);
> > > 	}
> > > 
> > > 	kvm_iommu_stage2_idmap(addr, kvm_phys_size(host_mmu), IOMMU_MMIO);
> > > }
> > > 
> > > in mem_protect.c:
> > > 
> > > int kvm_host_prepare_stage2(void *pgt_pool_base)
> > > {
> > > 	...
> > > 
> > > 	return kvm_iommu_stage2_idmap_init(mmu);
> > > 
> > > 	/* 
> > > 	 * From here, all the changes to the host stage-2 will be reported to
> > > 	 * the iommu driver
> > > 	 */
> > > }
> > > 
> > > On the pro side: no custom walker and we really couple the iommu idmap to the
> > > host stage-2 map.
> > > 
> > > On the con side: As you've pointed out, we'd need indeed the iommu to be ready
> > > early enough.
> > > 
> > > If you want to stick to the snapshot function, could we have the walker to
> > > first walk the hyp_memblock? the .arg could just pass if we are walking a MMIO
> > > region? That would avoid that find_mem_range_from() and I believe would
> > > massively simplify the snapshot walker.
> > > 
> > 
> > I see, let me try that.
> > 
> > 
> > Unrelated to this, but while looking into option#2 I see that
> > __pkvm_guest_share_host() does not call either of the
> > host_stage2_set_owner* so that requires another explicit
> > pkvm_iommu_host_stage2_idmap() call.
> 
> It does! it calls __host_set_page_state_range() which calls
> host_stage2_idmap_locked().

But host_stage2_idmap_locked() does not call any set_owner variant,
so __pkvm_guest_share_host() would require an explicit
pkvm_iommu_host_stage2_idmap() call.

Thanks,
Mostafa

> 
> FTR, I don't really like __host_set_page_state_range(). And we removed it
> recently from our Android tree. Because there's just a special case in
> __host_set_page_state_range() to cover guest_share_host. So we can easily
> replace all the callers with __host_update_page_state() and and call the
> idmap explicitely in __pkvm_guest_share_host().
> 
> > 
> > I still plan to use option#2 in v7.
> > 
> > Thanks,
> > Mostafa
> > 

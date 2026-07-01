Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A78494A19
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913003; cv=none; b=Td0JUhgH3IlHc8jgeUsAplNcM+jMiQKvSguHsIYUAMMRV4GLwBVxyhX/38bQTT+pl5YGt9IHMNaiCzlHvqm+kvhY4t8e60VJAfYSPC5CtW1yu3nWWeeVSUnDDAstkeuccUtGfq3NjkViMP3HoqkTOgiWZM1RuC4QJe//hZxsSFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913003; c=relaxed/simple;
	bh=Rvbe9sFMJGpQWup1UcjTJpn3Xq27G7UIqOzhJnx5NSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aw2WMamVmaFBBrjnwuwLIRugFMh4bCWNQryHPVqdV1/3GFiijFuIDilRz4pg2fScZbfeyafJuhEzllai/tXo5bz2W+D5MsTLD6Bu6IBuAJagUWj6CMwXkie2ugN2S7Hl0+tZKDyCWXgvOJIbotVqAMUhM68Wlthbqx6QkJrE2pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZoAD4qXY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZoAD4qXY"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c81db32393so58595ad.0
        for <iommu@lists.linux.dev>; Wed, 01 Jul 2026 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782912999; x=1783517799; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qS13cSENFGcBB0bnz6k1QAxOjQr0kz2UqGp/5+eDOd8=;
        b=ZoAD4qXYmH3FQ4Ju9t9U6ma8BQ//lxJ0GNyfGZBFVbwCD/p9u32GvjBuIvmyjaJuSo
         ePheiXApnCb7lnSFggqGFg+7vik0kk/h/TWOXIRCgdygXT4+r8Asu1rOgljdq7Tp/X5z
         m5jfY6ebiTlCLZZDOdcLk7nXjREK49ARtBVLmwNMMLqllvlyoULV8bE640Q+yVlzC0V6
         VWDAbpRSuxjSCiHzf1hcyb5yO9Ldt/zDURE6XnDICKoc5TTrtPKBIQv3soIr6oai8xPM
         w9k6gmnM12qUw5K8Lt1zfh2Z8cEo/k8b3b4eATRpmle5f9VcTJt5jLDNf5PMZ9cOrFBF
         hPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912999; x=1783517799;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qS13cSENFGcBB0bnz6k1QAxOjQr0kz2UqGp/5+eDOd8=;
        b=UFL6A3GzKxp2LGSXX8i34ptvpagZPLjaJWLt0MUQFotuDEg7dOrUvqIgufO82YDp3W
         uu0LgiSuUdVBebN1rAhc9UfhnPDWfkW+uDFJZ5sV5XFlOQs3uXgT8uKCO1mYrgCZ7r7A
         vS2lblZPLG6CEqKKGP3t8VRJBPNiPi1qfsgwh4HF74A06T7JQT3bJBQgfqzFjk0i3P9a
         f/stWXaLwAs1+/upDjWe/esvB35mgMzD+/seih5cTDgm2HrzSQa1YwOLyJaTyHJMuKvH
         Du72N8ae0Ig3mgU8WsUHRN7XOW03VgKA05ORC3ytkivCxg5IbdrKKdG4DzrLRZ6LWn/9
         +WlQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7UgugOfCXZykxgJ9jkbVFmq4t5Lu4ifCH/YA80msEZ2Qoq79I/pdqyCNW7Q7290sn0ZbsJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKOaAIe7W/766vrZPlaGW8+in0xflhozpteqItCDXjJW8e4Nmz
	cLIRjauJOhEbucV9i3Hs+V+xHlHZ0iJ22gB6gsYlEcchZq3uinN/2Oiaa5d3i6dwoA==
X-Gm-Gg: AfdE7cnyU6T9DMMUwOTaLzQNI3YElV1DGOZa8jTX6fwB/CnRoEKgyTbzBq+PM3Mpk+I
	vHB2xkPJ4OtHat15907xYOjXwKv7IwRxgEYzMsrTBONKlSMUe/2W3Puki5SNe9IJgeKuwnSLEgA
	18EEpPeNFHtzW/G7Y/6ekkzJtWx1ZOriJVEmBRJjmjRo3vJLYOyLB8yJ27b5EhvICdA56ezemyr
	fB8PeBl6xYHCUrxGC4dUt4CtFK/xhZqzNiCPuHcofwie8eJUhVjza3gia+uT1aoDhfvkAkoL6NG
	LjoT+N8yWIr/2NET4nrIlirb5kmPTrXaUJ29wcu1iFH9LVdmGUF2xctfz87H3SZzCQtJMMy+SMG
	Xwwfjs7Uk4fE1x7J4lvtZpNgtF6bsxlXY8pnWYQ8cizxTXm3qgmmwC3sof7OTqVRT6uKQ1+jy7O
	jgtLOKLZJpmq+qB7ZGrGsSXIIxIRDPgN/p/1z4k/bsjBTuN5U=
X-Received: by 2002:a17:903:283:b0:2ca:1bbe:c3e0 with SMTP id d9443c01a7336-2ca8f1bb537mr296825ad.0.1782912998682;
        Wed, 01 Jul 2026 06:36:38 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479fffa65bsm4111750b3a.21.2026.07.01.06.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:36:36 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:36:29 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <akUX3T3fIoN42sdM@google.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
 <akPX_N0P2EcI_jbV@google.com>
 <akPhuF9pAWaBXzpi@google.com>
 <20260630185942.GF7481@nvidia.com>
 <akUQj2pa1W-MekgF@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akUQj2pa1W-MekgF@google.com>

On Wed, Jul 01, 2026 at 01:05:19PM +0000, Mostafa Saleh wrote:
> On Tue, Jun 30, 2026 at 03:59:42PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 30, 2026 at 03:33:12PM +0000, Mostafa Saleh wrote:
> > 
> > > For example patch#1 verifies log2size and split and both are read
> > > from HW registers. Same for the base address or other addresses as
> > > the page tables, they  might be corrupted due to a buggy driver.
> > > My point is that, it is really hard to assume that the previous state
> > > of registers/STE/page-tables were valid or even consistent, when the
> > > kernel crashed and did not transition the state gracefully.
> > 
> > Sure, and this mechanism is probably not very useful for debugging
> > these kinds of errors in the SMMU driver. Oh well, that isn't a common
> > source of kernel crashes :)
> 
> I hope not! Although memory corruption can happen due to many other
> reasons :/
> 
> I am not trying to bikeshed, but I wondering if there is a more
> reliable way rather than doing archaeology from a panicked kernel
> SMMUv3 configuration, as I am worried that will be even harder to
> debug if it goes wrong.
> 
> >  
> > > Similarly for TLBs, the kernel might have panicked in the middle of an
> > > unmap or free domain. (not to mention what that means for RPM where
> > > a device reset with unknown TLBs)
> > 
> > TLB is fine. kdump works by carving out a chunk of memory for the
> > future crash kernel. When the kernel boots it ignores all the memory
> > used by the prior kernel. So DMA can keep running into the old kernels
> > memory with no issue. It doesn't matter if the TLBs are inconsistent or
> > not.
> 
> Ideally if a TLB is to be missed (because of the panic), it should not
> point to kdump memory as it is carved-out. However, it is still a leap to
> assume that the TLBs are in a good shape as I mentioned with RPM (or
> even if the device resets transiently for some reason) it can end up
> with garbage in its TLBs.

Regarding RPM, I can say that even if we panicked while SMMU was off in
the previous kernel, when we call device_reset() in the new kernel we
still issue the TLBI_ALL with the reset.

However, I agree with the overall problem, i.e. IF an active device
unmaps the DMA addr after the transaction in the previous kernel, 
(with the SMMU powered ON) but the TLBI was missed due to a crash/panic,
Any new DMA in the new kernel may alias onto a memory in the previous 
(crashed) kernel, not the kdump kernel.

That way, I agree that continuing DMA could be problematic as we may
corrupt the very memory we'd wanna analyze for a crash.

Thanks,
Praan


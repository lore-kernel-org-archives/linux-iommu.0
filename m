Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D1E2737E1
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752623540; cv=none; b=U3DVr0y/X8o26JTzzo7tOhUhb4ouhN3TSkbihp98S3gE6U5/OQg/9empjSTf5LQuVOXGUmncWpM+dUWAAh/Lj0NZcssxp+rPTLpIZY5rnpV4MD+GxoOCY6PjhsroZNRya5NPpbHLR/nsG5tg7n0I0IlYVRoHl0RuVikl+PorMxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752623540; c=relaxed/simple;
	bh=iOOC22qE24wPMHCbCeHyYpP3vN/5QujkvqzBT/v5kPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZU3caaOedY1efwz74GHf+hpCEiZvzCs1Q57Svh5AdDOTBqw3+tbCp4I8l6aH5oCq4KAoL5BKmnf7LI+IPgQio9XaQSbNPdfJ0R67VU9j+JG6h/rPksH2XoNdnDtnj85KSERvyGE6jVQjiAdJIDYfZn390nhjF1TlgZPc4HEJOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I56EhkuA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I56EhkuA"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso2060a12.1
        for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 16:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752623535; x=1753228335; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iOOC22qE24wPMHCbCeHyYpP3vN/5QujkvqzBT/v5kPo=;
        b=I56EhkuAmCRiUXZ2K8exQUQyUZOv2Z4K634AlGwcQZPSTW3IPyZDszeJyTCjyMrtL4
         SXorQGQy8gx867b3t5mYMniWTeKJASuzOBa80jIv+GL2GFa4roV7GiY4Jxmz7u9/WfNn
         UV94xwvpYYPO/gMIPn+kSVMPWwpwJ/aBFvvlei6WQfO0h9LmW94n8V+IOr+FMjaEMgri
         ce99++1qKwjlgPwf9XSCutiPTJyrWlYn9q3BQPNe4gGNKzBgLhGSaF0E1D6Rtq1FX/QI
         QezBQpl2DswFDNvr/0ao+/aDRCjA52K/RGIVsNvK/8FpSZ0emNtkp/taY/N7wdfUPJ5d
         Zt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752623535; x=1753228335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOOC22qE24wPMHCbCeHyYpP3vN/5QujkvqzBT/v5kPo=;
        b=nH/d3f1UI1uTIqNsKqUnj5b3UxN7mO/2tbyQKTZJaMTxMZcdvOwUzQPPIRZDD0TIxB
         3mAPEDGVoIaxK2CIevGzJDCHoDQ6QnohLE+h0QMdVd/FxR5Nv7wLlWECsWrczDFPUfRC
         bMI1aLLTVRB8o9IcqKk+FQFdbx7SqhLl7Oh0UjzgEDsIbeamOWD4zvJI4MG0mb2zsIcf
         EwIgWuX3m88h0jk9PdpH3mMx5hz1x28l1PZW0JybWrowtu94G9YmzKuc/dgVNpWNyv/T
         lqsXGhhQohbvEYHbzUJLCZwN22bCJw7l/L0VkVqRdhkvtqTZAVdoemLNXIwN03EK58Ue
         CsKw==
X-Forwarded-Encrypted: i=1; AJvYcCWmgLrjP2OwDsNuFGvH5/+eyvkCd0JPHBUfW7vg7Ondsl18sm/fHPHVHcq/3pTu+QF4H6iKGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkvlrPelq6DNpn/PBOTaL3+QHJxjI2bJo4U2tZeB946E59Ctur
	qbfsBSoLiaAaVPHLf2XAmgNZSQzrCA0N/PIx9NLdjWoIUQfxU3hr8MSBHJ+eKjRWqSXGUQoQMZZ
	RDjCBC5Ffv5EDad2R7CKzFT/qPEH2Shg5CuZEISw7
X-Gm-Gg: ASbGncuEVNu3KETFiPorLx3erWegmO3fMwn+FpO13HAmQiiTzFwmxgJSm34IVYGDYUJ
	xkzyvPVESeiqsyzUzKNHgPdswczLlGzuP8wpXSn4e/QkL3g1uEInOME2PAIec0WFNKRb5SkGN8d
	OnrJ8GUyz6HRRvFFApsu7x8ByxbGnCpWAU+P0a1KCcBpuRd3kqBvZEu6sz91egfdDTakE+YORu4
	woER2AgTyYROOg=
X-Google-Smtp-Source: AGHT+IECgAh0TayNXuam8GHntaRgc8x8AxRP+iVxal7exRS2WfAN9/8+9SLnvuOedYYKDKagINx+AwkZJTJ9Ynu5DM0=
X-Received: by 2002:a05:6402:1295:b0:60e:5391:a9e5 with SMTP id
 4fb4d7f45d1cf-61287c0c9eemr7421a12.5.1752623535079; Tue, 15 Jul 2025 16:52:15
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616203149.2649118-1-praan@google.com> <20250616203149.2649118-6-praan@google.com>
 <CAJZ5v0jq7DL4z+q5XKcVUZQgojcxA8DgrMFncs1Z6skm+PVEmA@mail.gmail.com>
 <aG6P6F-MEvL4SfNz@google.com> <CAJZ5v0gGjt+pRbq2k7qL6E+TGhm8PYHm_VVrwg2ZEjSWk+5FRg@mail.gmail.com>
 <aG6hpoMx1QwwP195@google.com> <CAJZ5v0jyYpu=qA-_QKVoNhzRZRNKe5cFt718fo6pxR6iRkD2bw@mail.gmail.com>
 <aG-BC6B4R1ViEDM1@google.com> <CAJZ5v0id-sRxVxupWPKPGikSm5_QeO_WKgYdK2BUbY4m7dbndw@mail.gmail.com>
 <aHDlhyPmjCT7rz-i@google.com>
In-Reply-To: <aHDlhyPmjCT7rz-i@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 15 Jul 2025 16:52:04 -0700
X-Gm-Features: Ac12FXxOZzoZ62U_lxTFVMl8HGkQdgYM-WulkGGnlplZ9Z6UHi0gYh7aU5tsNT0
Message-ID: <CAE2F3rAPB8rVz38ygAxatdAunS9oMNJ5WvMiB+M8Am71MEHVVQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/8] pm: runtime: Introduce pm_runtime_get_if_not_suspended()
To: Pranjal Shrivastava <praan@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I think the underlying problem is that we need certainty as to whether
SMMU is enabled or disabled, and if we find it in either
RPM_SUSPENDING or RPM_RESUMING state, then we don't have this
certainty. Creating certainty would require waiting for an in-progress
rpm suspend or resume operation to finish which we can't do, because
iommu_map and iommu_unmap can be called from atomic context where we
wouldn't be able to wait.

Before discussing suitable approaches, I think we need to agree on the
requirements. After our discussion with Will, I believe the
requirements are as follows:

We can elide i.e. skip TLB invalidations only when SMMU is either
disabled or powered off.

At any time and even in the absence of any client transactions, SMMU
can perform speculative translation table walks and cache the results.
In particular, Will provided the following example (I hope I'm
depicting this correctly here):

In __arm_lpae_unmap() where it says "/* Also flush any partial walks
*/", we skip over io_pgtable_tlb_flush_walk() and subsequently free
the page table in __arm_lpae_free_pgtable(). The memory location that
previously contained the page table is then re-allocated for some
different and unrelated purpose while the SMMU hardware still stores a
pointer to this memory location in its walk cache due to the driver
previously skipping the TLBI command. SMMU might then perform a
speculative translation table walk and misinterpret the new data as a
table descriptor which includes a pointer to a next level translation
table (i.e. use-after-free). SMMU could then follow that garbage
pointer and read from an unpredictable location. If this unpredictable
location turns out to be read sensitive like an interrupt acknowledge
register, we might potentially end up with very subtle types of
misbehavior.

Due to these requirements, I believe the following approach will *not* work:
Elide TLBI commands when device is in RPM_RESUMING state: While in
this state, SMMU could already be enabled and perform speculative
translation table walks.
Elide TLBI commands when device is in RPM_SUSPENDING state: While in
this state, SMMU could still be enabled, perform speculative
translation table walks and run in to the use-after-free situation
described earlier

I propose a custom synchronization mechanism where we use a spinlock
protected variable that determines whether SMMU is enabled or
disabled. In the suspend/resume callbacks, we disable or enable SMMU
and update this variable while holding the spinlock. In the map/unmap
path we briefly grab the spinlock while examining this new variable.
Only if we find that SMMU is disabled, we elide TLBI commands.
My concern with this, though, is that the additional spinlock might
spoil the performance gains of the lockless command queue insertion
algorithm.

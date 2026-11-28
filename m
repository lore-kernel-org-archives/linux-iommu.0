Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795870828;
	b=AqRFjxXlggtxLQlXlEo1eTC5pB/q6qkrHST89fIRNBONZGLz1jYsKRVjSdaO4dWrhv0Z
	 1wqKJVc2OPUQbdfgzKhgfr1IYJqnpWVEsfHjhEcA/nEYb8oqy37ozqMOqEaqGmiHU5uVz
	 NIeAcYbw7F7M+T0rIj8A5Ce1lOerCxpC0A3p9naPX2I2tYLyoJW1gFL/SpElBZxRRZ3nV
	 U1brPzMma9PLeqmwYUGslPfO8jsdRB/Ejh8YI8icYafHbp+MX11YnY32N+N+eDxZpS4Xr
	 SkvxqAoRHwKu+GTIWCKKbvaHWe41yKA8vi7EH+2LTZds9yf5jWCIaNhQFGg2vaud5Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795870828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=d6BkAp7ECdk7km8IXzswx291+eDVbqVT1bK4nfJre9c=;
	b=PTeeJM9M8QMJurXT9GbU6mP+/ZzzWM1NnehrpNMjjUviD9LH+fo6FjiFhVQ02NXc0tmo
	 oZ+yej8gcPaiqsGpv+njyKeIDkYM/FlDUtpBYM7JecDxDAftxHPEGIO7qHoXhndA6s86E
	 hi8sKwhWqvhljZQbDxJKy2dAiRDGjRekAkDSNsIGgfcWsti6NI0HgtIt0A0c1kklYI332
	 DHhTu5GTBDwVrm+1NqqUUjp1Ko/MptFIdVPDtOMgCJCVeWVsWFNTbk0MxCx6YhSmNeGcl
	 CdbYq7+m1oUmTxpz2ebVud3M1IzQ/FewcI9ex+ctbMwSIj3UQaurfBrnZNIUjZ1Ky6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hKyb1Ji2;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276C6606A325
	for <iommu@lists.linux.dev>; Sat, 28 Nov 2026 13:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 276C6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hKyb1Ji2
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c429d9d05f0so839999366b.1
        for <iommu@lists.linux.dev>; Sat, 28 Nov 2026 05:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795870826; x=1796475626; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d6BkAp7ECdk7km8IXzswx291+eDVbqVT1bK4nfJre9c=;
        b=hKyb1Ji22YDkmkkfFlDn3osSIIa06nFyCF0JN/jUeblhCPfkdPsfeHLOCTXZ3khURA
         ASO5u55mSfFDBJrPQ7T0P3oxUvAr7hOJmYsKBJ3yOkmfqiW5igbPP/7j5NXt7dsgdhIU
         QFd6f+V5Ug6kZN/jH7HIn2kqVPcmY3oooCsf2kFIj0TGmiIgs+DkUSNlE1GfU+UIhjXS
         yNNCFxbO3xQjyKJeA8ZDOVgqIM9gDDDfUOtrzhisOV3CWo0JXurpoXNnEFVBZDDuiwcf
         gddO13G3OeDXPh7y6gkYOcZsYmFJYbGoO8kc4oe3J3cMdez43Fnf49R3/fSt5Yhwn2eN
         0R3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795870826; x=1796475626;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d6BkAp7ECdk7km8IXzswx291+eDVbqVT1bK4nfJre9c=;
        b=SgP7ennI/YAbWLCvmmic++1sWWwMQVygb5tIwk7+L1MGdoKV+crTumZe5e43QlF8i6
         qtD/Eu0qTySLMCY8vI6FBDJZwz3ZuSnc1OTnCxLp1+YXEdPyMJfPsAkmt36RXF7FWWwQ
         NdBN0q+9YpDwEfHdEKZkqiMuc1st8X28FefwAKs4bSrBwRsH9meYTeuYoR5Iklgi2DUb
         03bJWVvCIh3L5Wepay5aNAvftYfE2LafpV5rLW8u01Ya7RIw7l9qvTwLbSKxZcqcbg5B
         HwH6fRiJFihumPGkHDnSqGRZe5Twzu6kxCDoHjlaZ4cWsIoQcE6eUA5u/EP5yG/iSoUH
         sYXA==
X-Forwarded-Encrypted: i=1; AL+hErGMM+bdxuymASYs3FjWhSd/1raD4e49b/8Z33UaUTZtN+ymYaiGNTjSPqle8Cac8jfZE6Imsw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9GVDB44c1UEGGKjPClLFCVtVpUBKnkqrSovgKca0ulfV2tcuOm
	BcriQ93xgIs7GfjySJH46ED+fYVUXNMwlcehFMHLtZnBUSkGrRJsElxqRLCiC+zham+wj7DLUO3
	7Em+WaV3pDz+TMEc+DA==
X-Received: from ejtf9.prod.google.com ([2002:a17:906:4949:b0:c31:8840:5c0c])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:3d21:b0:c51:24a4:1dfb with SMTP id a640c23a62f3a-c513ac7edecmr1624478866b.40.1795870826056;
 Sat, 28 Nov 2026 05:00:26 -0800 (PST)
Date: Sat, 28 Nov 2026 13:00:25 +0000
In-Reply-To: <avnuP7SWE2BdBFBL@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-3-tarunsahu@google.com>
 <avnuP7SWE2BdBFBL@kernel.org>
Message-ID: <9huzpkvpglg6.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 02/19] kho: block: Record the entry size in the block header
From: tarunsahu@google.com
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, robin.murphy@arm.com, maz@kernel.org, 
	will@kernel.org, David Matlack <dmatlack@google.com>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org, 
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Mike Rapoport <rppt@kernel.org> writes:

> On Tue, Nov 10, 2026 at 05:01:45AM +0000, Tarun Sahu wrote:
>> Subsystems using the KHO Serialization Blocks framework currently do
>> not record the serialized entry size in the block header. The entry size
>> is only known to individual callers, which must track and store it in an
>> owning serialized data structure. If a newer source kernel adds fields
>> to an entry, the changed entry size breaks the stride when an older
>> target kernel iterates over blocks.
>> 
>> Add an entry_size field to struct kho_block_header_ser. On the outgoing
>> side, record bs->entry_size into every block header during allocation.
>> During restoration, derive the entry stride directly from the block
>> header instead of relying on caller-supplied dimensions. The
>> kho_block_set_init() interface remains unchanged. A zero entry size,
>> or one that differs between blocks of a set, is rejected during
>> restoration.
>> 
>> This change modifies the serialized layout of struct kho_block_header_ser
>
> Imperative voice please.


Okay, Will take care of that everywhere. Thanks
>
>> and shifts the offset of serialized entries within preserved blocks.
>> Bump KHO_FDT_COMPATIBLE from kho-v4 to kho-v5 so that pre-v5 and post-v5
>> kernels cleanly reject mismatched handover state during boot. Also
>> update the stale compatible string example in the documentation.
>> 
>> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>> ---
>>  include/linux/kho/abi/block.h          | 10 ++++----
>>  include/linux/kho/abi/kexec_handover.h |  6 ++---
>>  kernel/liveupdate/kho_block.c          | 32 +++++++++++++++++++++++---
>>  3 files changed, 38 insertions(+), 10 deletions(-)
>> 
>> @@ -264,8 +274,21 @@ int kho_block_set_restore(struct kho_block_set *bs, u64 head_pa)
>>  	}
>>  
>>  	while (next_pa) {
>> +		u64 capacity;
>> +
>>  		ser = phys_to_virt(next_pa);
>> -		if (!ser->count || ser->count > bs->count_per_block) {
>> +		if (!ser->entry_size || (entry_size && ser->entry_size != entry_size)) {
>> +			pr_warn("Block contains invalid entry size: %llu\n",
>> +				ser->entry_size);
>> +			err = -EINVAL;
>> +			goto err_destroy;
>> +		}
>> +		entry_size = ser->entry_size;
>> +		bs->entry_size = entry_size;
>> +		capacity = (KHO_BLOCK_SIZE - sizeof(*ser)) / bs->entry_size;
>> +		bs->count_per_block = capacity;
>
> Nit: can't we just initialize bs->count_per_block directly and drop
> 'capacity' and the change of the following line?
>
> We are not very strict with 80-chars limit in kho/luo anyway.
>
Sounds good. I will update it.

~Tarun
>> +
>> +		if (!ser->count || ser->count > capacity) {
>>  			pr_warn("Block contains invalid entry count: %llu\n",
>>  				ser->count);
>>  			err = -EINVAL;
>
> -- 
> Sincerely yours,
> Mike.

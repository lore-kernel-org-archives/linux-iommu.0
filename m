Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443FA19D092
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 00:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951367; cv=none; b=F8O4F1NH1Jzn+T/RqPTJmcikwIppd/8wafVFyt81PK49O6dqqyX1gJ9mgVnN6nK743AxZI5ng5Q9M8NQTjcExv47CPl+DQBrPLo2MWhiJKuqC1mljDo2wTkN9jbqEH08PxTZBFdEFJ2q0ElSgcdUh3BLQIA1qHuxeJPXmSh3t4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951367; c=relaxed/simple;
	bh=iBCjZsNh3SRSbwVqKwjZlanD4uaJXSQ+DBZTbOJ2auQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2bhhIdE4YqBcktvT13BBIhdN+vA7R3TXG5IZAAKXp3l7+5CiS/p5v83ZgRWVCt6+lS3iGbLc8CoYxmAUjScJIiw6dN5J+eaPMUrFSs0mOu7YuFQp5ef1lqoE02du/kAIcnU/vjtLSPgMcSpr2udLTbbzz6QaVPJgzowdmR72fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CsokWGID; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CsokWGID"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e51d3d83cso64418185a.2
        for <iommu@lists.linux.dev>; Wed, 01 Jul 2026 17:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782951365; x=1783556165; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SpRDP2ezaOKhK6W6X5fU8vOvQc+ihhDBQ+gm9ShOsoo=;
        b=CsokWGIDz/JFueklowlWD6vINbKhSO4hMfM6SoUjM4qvOUr7/h7/jyz4DYsYhNDEnd
         Y9XRIRoX+iaFsudz4J+I5LAm+0K07w7W6S9fbtcEuEghaCDuVH915p+U+PHx992/OUEn
         abX6KUHxiXwzi+rJ/cab6opyb0wmmxXilRJWNt6a40Ro1edfg6/KZLi97JpRxBwMHpS1
         MFZ0TACuU94xo+fbZzdjU93nHwE7QpT1G0qmFtjy3tI03m6gfOetwyQJt/tNmJK7Ykpn
         un8nTjeVBo2IJWQnIFqtS7MX9FjrGRaaH0+JhprQQkjymvoJM2yoquKR3EfTh1prYdu1
         8qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782951365; x=1783556165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpRDP2ezaOKhK6W6X5fU8vOvQc+ihhDBQ+gm9ShOsoo=;
        b=o7FHTgCjDjafIETbs9E9oodoLbLCbuhzGL0I+rEtAfdcHu2dN2UQfC39j5qXtQd7yr
         QCY4+LPd66FMSBjj6pLUMJ/1mt2Mbt8a9rF65GsWks9F8It+5U4aiTRSBkNHA3oxtRIw
         CIKq9Ypsko7Y9WlnYY3q8fF7B7jz+noYngr/OftnAuTxn5ZuNSrOg7Bt85U3NTyBluXp
         8tBzQ7WyGWppCNs1QPcE58DCYOCsU01P59I/aeGlp9q9fsEqFfVTjdfk0Uxb1ZdnIC5m
         RnRc5khS1vcHjb11/HTuIC8eTN6TwIl7UwWXsdiXDgxicdb4gZMMoBlaX6gnue2oudPG
         4gZw==
X-Forwarded-Encrypted: i=1; AFNElJ+8HwE+MdkZakw1a/GINdjWPS0OYnocXjf4mpRzF/txpmByg6iWUk1vUMrfvw7/1lHBSZD1Iw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKGXxYMjbqX8UgzzS9KSFmpF4/s40Pzy1FcmJs4koY58EeDrND
	G1t78B1zKRKPqXoBpG9REKF00oy0x2gjeTzm8EtR98Y6rXunrkLWlBPgOVQTKEzhl6w=
X-Gm-Gg: AfdE7cnu1T/3YhcywuaiPjlyoaHxjTZL0EHXYOV9uHwY/WhG+sdYVdIRyv3/yMTwI6h
	EK/8ADxNvinY4sHaM73/oTeS0hL0JND7NvmgHUn8JzAlPv/BWCeXtvMVlARxPu3ybId39Qtw9FY
	RJT6lrxbcFr6yyQgNwjOB+cOwb3Lc7MYf+a4lwhoJ1SRnTKITCdWO62SFXHWYZ+zC29R7htyD5X
	cEbuYoPzRqtQIwymRqUVB5rK+h89ayv1yPoBqGcBFgb3tt/orB59nh+ZHTC4mJs7eujk86nBG6C
	MtcJT1XsC9VoGhCfIo/PtJwy5CM4rPv4t6kN4fdlyRBAZl36lpntRNc2BNVJsfhVFW9+U3EPuB6
	n0FzCA+rKnNnk+ACsyaY0yIEHatGKXnpYqaqJ2430vxoQQBOSi3kenOtazT5JKW9vTt2gSUrrV1
	ZKzWpDvvjbgIBLB41sReGNb6AcKxTkT/RObay09XOMFz+lOJ5GMN660zq/3ueE8P5MBuI=
X-Received: by 2002:a05:620a:4016:b0:915:8f76:7ffa with SMTP id af79cd13be357-92e782c6315mr515090585a.45.1782951365126;
        Wed, 01 Jul 2026 17:16:05 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e80040ff1sm81033885a.21.2026.07.01.17.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 17:16:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wf563-00000004cjY-2WuA;
	Wed, 01 Jul 2026 21:16:03 -0300
Date: Wed, 1 Jul 2026 21:16:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Kyle McMartin <jkkm@meta.com>, Breno Leitao <leitao@debian.org>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <20260702001603.GN7525@ziepe.ca>
References: <20260701154528.768976-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701154528.768976-1-kas@kernel.org>

On Wed, Jul 01, 2026 at 04:45:28PM +0100, Kiryl Shutsemau (Meta) wrote:
> The command, event and PRI queues are sized from the maxima the hardware
> advertises in IDR1, which can be several megabytes each. On systems with
> many SMMUv3 instances that cost is paid per instance and adds up to tens
> of megabytes of coherent DMA in the capture kernel.
> 
> A kdump capture kernel runs from a small crashkernel reservation and only
> has to drive the few devices used to save the dump, so deep queues serve
> no purpose. The queues carry invalidation commands and fault records, not
> DMA data, so dump throughput is unaffected; a shallower queue only bounds
> how many commands may be in flight before a sync, which does not matter for
> the capture kernel's small device count and modest I/O.
> 
> Clamp every queue to a single page when is_kdump_kernel() is true. Doing
> it in arm_smmu_init_one_queue() covers the command, event and PRI queues
> in one place. The command queue still holds at least one batch plus a sync
> (256 entries on a 4K-page kernel, well above CMDQ_BATCH_ENTRIES), so
> command batching keeps working.
> 
> Suggested-by: Kyle McMartin <jkkm@meta.com>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Make sense to me

> +	if (is_kdump_kernel()) {
> +		u32 ent_sz_shift = ilog2(dwords) + 3;
> +
> +		q->llq.max_n_shift = min_t(u32, q->llq.max_n_shift,
> +					   PAGE_SHIFT - ent_sz_shift);

I saw lately many people saying you should not use min_t, why is it
needed here?

Jason

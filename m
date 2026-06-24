Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA19377545
	for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782330424; cv=none; b=r8WpvaEC1GV+rsiWTRF8z1ClT/2w8IuRRTfUAYgZktu2yX0+Qg3MFGvUxRcvLRKFtuMRrGIZCDsF2D7fiRyNfzFCGyn0ScLVOyA2/lQYMzUcKMgL5Xf2Es8zDn8KWnP6xbumxFLCimSIblUz3WeSw5p5oX+KlhfxXsnnDLA4A4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782330424; c=relaxed/simple;
	bh=U7+5a7mF4yevOAZjcMJDLHcjRKIy3zj8rl1DXS+GKns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ+/B9lnGp0YzK9kO3YhoHPBs4dVj/UXwyQBj3jA7KnImMf4Re+LNXg7m3/zpTBDZvujJ/Tkc2mx1ksQNltvHO3TnnkSxkoUPNeg+1CTvTWko53DaNJuAJBr8yEIMNEddvFVch325vXfMLi4LOb6tFZBQWJl+ZeJF0ohdKMR8Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZG3rEKvs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZG3rEKvs"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c73cefe192so745ad.1
        for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 12:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782330422; x=1782935222; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2aGwSxMPCxEakwoSKIAkNM8dD8i9uBjtEeqjT8n3zZc=;
        b=ZG3rEKvspwY0+1Oztd7Kjzdc/NfAG+YurAXfknyfIoutepBq5Fb2OwLtiYg9svzNtv
         htLb+xdPj6RpWM7jZUToxEo/nc3qc1xu5PVXkPrYPEcQT058A9mX2EGFFz3hgj23tAMC
         mbqmZjIllPjYRA056QX4MSdA3XAjRC4jI4LfyErZ74WevjbI7obOAZzdE9fZ89pAOcog
         kGaXXLk+wWFTHrH9Mr1kQFmHKjjORPqP9YHBeocgaWVXn/tJHSxTv+xcxUqehEv3qdgt
         HqxnmTTWr8fwg1GzB8ujV17aMLJm5hMVPYfFuEcLVLoWIeR5qIr+bc5wipmwyLAnq+8H
         pLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782330422; x=1782935222;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2aGwSxMPCxEakwoSKIAkNM8dD8i9uBjtEeqjT8n3zZc=;
        b=RtR9PYRkrWPUL+dvqu+TRyRBdsR0LZakWqAnxFcMS6VKreMVKGAm7ecK5Cmw5peqTw
         oOm53y3gtdG+LTRqECgCXx6yemZ6KUUAV7RXkdb8zzeEZelmJyr09FM4dUvm6Hyswj/2
         1rI9Jn2gS1vBSxzpdKQ05awqUePvhYsy5k6qcdfflcbvLABC6SCvdjo/R2+uXtuRwP0t
         DImkarB8jeGqsv/wrAK27qtY3GzUpcw/psErfEkTT19Vi86w8fWWi+6LLPh723ji4BTj
         s/7MATZ0sndLlgtq8Smm+medqAVszGme9903QKYIpmop7uJe8srkhJkwOnE7I37aSjQn
         r38w==
X-Forwarded-Encrypted: i=1; AHgh+RoihRWB+PH+1PXPmzW8J6MS3FBGYFcivgv3kTu8raR+M5qZ4OIqs/7JIpovvFXbv6YAwThfuA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf8+rp9rHCy/9fZOp+Lb6vDlMLK/8z/KQpSKxhqhSff6oJkMjX
	+7pgrE2XZiF5pZC2wUNlDODNISIJld2P61cCD2R7pOp/Gr8a/awgtG7lZssHm9YjSA==
X-Gm-Gg: AfdE7cmM+9GkBP6zb0xnZMqC8PKZvQNeM+mc2Ym80Py8tFUFcpxQ2axECeL9YHVBBAk
	OnPHdM4pKarzojV25On3BlvnEQYKfAMZS/ryEUM6XEk0KyUjkfYDoD/GBSefokRPnD9Leo19dMr
	l1bzRv/RkzKSXYHytOTyoaphvPG99J6HPF90o5GSRdOCxPB4sXAMFf3YwVKZwJgBzU6/H4r328M
	yHVt14qiTE5yTj57SNyfsOHXjw6lIer7lFQHkS40FR+4c+IeTTMVL2Dmdzmt7sWzB9yBlbBWv/n
	f3AlopsNoY7m8RUqYYsx5XftPEJ7SF9RlfLpg8R/J+jPE1+hNwRNgNwtfrgfmuYHqOgSZ+S+NYA
	nfGlNTOv8wLKFti6weHn8YHKVcjMCIhK7TMlXX46t7PyC0VtJvzax7eNFC1nn/cHZWYzpncQIfF
	g2aksZ6YhqnJeUyfJXRperMdoeusZbRdeU17GbC/U5mcrXUusknk/pplY8UbGsKgSVyBNMQ32pU
	99VSrJ1
X-Received: by 2002:a17:902:eccc:b0:2c7:f348:2110 with SMTP id d9443c01a7336-2c7fada6dcfmr14055ad.5.1782330421347;
        Wed, 24 Jun 2026 12:47:01 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5b07bdbsm4752985ad.36.2026.06.24.12.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:47:00 -0700 (PDT)
Date: Wed, 24 Jun 2026 19:46:57 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 1/4] dma: Add DMA allocation preservation KHO ABI
Message-ID: <ajwvUwWo7j2Bsx6f@google.com>
References: <20260505002737.2213734-1-skhawaja@google.com>
 <20260505002737.2213734-2-skhawaja@google.com>
 <aicBp4tSyzyYBnzn@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aicBp4tSyzyYBnzn@google.com>

On Mon, Jun 08, 2026 at 05:53:43PM +0000, Pranjal Shrivastava wrote:
>On Tue, May 05, 2026 at 12:27:34AM +0000, Samiullah Khawaja wrote:
>> The DMA allocations can be backed by a variety of allocators. Add KHO
>> ABI for the preservation of contiguous allocations that are done through
>> dma-direct.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  include/linux/kho/abi/dma_alloc.h | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>  create mode 100644 include/linux/kho/abi/dma_alloc.h
>>
>> diff --git a/include/linux/kho/abi/dma_alloc.h b/include/linux/kho/abi/dma_alloc.h
>> new file mode 100644
>> index 000000000000..46e61db81abe
>> --- /dev/null
>> +++ b/include/linux/kho/abi/dma_alloc.h
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_KHO_ABI_DMA_ALLOC_H
>> +#define _LINUX_KHO_ABI_DMA_ALLOC_H
>> +
>> +#include <linux/types.h>
>> +
>> +/**
>> + * DOC: DMA Alloc ABI
>> + *
>> + * This header defines the structures used to serialize the state of DMA
>> + * allocations, done by device driver, across a Live Update.
>> + *
>> + * Only DMA allocations done through dma-direct that are contiguous and
>> + * allocated using alloc_page are supported.
>> + */
>> +
>> +/**
>> + * struct dma_alloc_ser - Serialized state of a single DMA allocation
>> + * @page_phys: Physical address of the preserved pages
>> + * @size: Size of the DMA allocation
>> + * @force_decrypted: Whether the memory is force decrypted in previous kernel
>> + */
>> +struct dma_alloc_ser {
>> +	u64 page_phys;
>> +	u64 size;
>> +	u8 force_decrypted;
>
>Should we also stope attrs in this ser state here? There might be flags
>like DMA_ATTR_NO_KERNEL_MAPPING which would need to be preserved across
>a kexec?
>

Agree, as replied on the other patch.
>> +	u8 padding[7];
>> +} __packed;
>> +
>> +#endif /* _LINUX_KHO_ABI_DMA_ALLOC_H */
>> --
>> 2.54.0.545.g6539524ca2-goog
>>
>
>Thanks,
>Praan

Thanks,
Sami

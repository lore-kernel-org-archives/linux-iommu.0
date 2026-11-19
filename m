Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087203;
	b=xBREeRVqZdhttgsECSxdJ84SxnHBseYAQvU754otQtlNy1FH0IUAyiLLNRt/i9NcxeJG
	 t0rN0XQJvJa1kdrS7i2KVOzS8d4Fik8fnnUoTl2kORvnSSSyHINF4mv30JyUfsaZujdjG
	 t1BHw4PPLr2SrxlfC8eO9QNxjiZJEbXYt/d/NKZwC7Yy6olOc1TYnu4ehwQqeU6/x0j1u
	 44+1XkEgrbOlgt/3tTJ6tJZbIEvt2tGfPHN75+oLHypmQAeJcnNUEZy8bedJQivlxyzT6
	 3UR0wnzP8DC5dWhuN/JCgbbAtfp9vIHkk7rGbiiM8gkCBHFK2i60pACtT9rXLkvpI1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087203;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=QjhX4svqgENH27PAAoOn+DesXkt70aYnU/WTBMxaRlI=;
	b=rBU44v445PPBhj4TavZCTZR+NdC2rpd9XoRua2SPwWaM16km4LYArReYhJp7HBH9drnW
	 SNbpATGlfX4rWus2i1/10w5i7G7Dqt54a9flckghlVu9n1OHyVUJ0a8yY7XL3DLFw7Hni
	 Tc7PUybozF+kXG8TwpsUu6OqPZsvBkAr0SI2FV3sfQsCZfCvwjdvUfNfiZpMyQouuKUbx
	 qrVepjUfy7eMhcDcDxBUz4L0JL11PPLF8h6NfFyoSO0PGd+jXpmNr5BW7W5PHHQy8r23n
	 TXBosjcJ07nYk14KKIOHuBZJLPyJlqgVfMvVwSZOgdf2x7f7m4pu8HKBHEg0GMs16GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=qPqvot4d;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E111606A324
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 11:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E111606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=qPqvot4d
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261119112000euoutp02f7ea4dcb26b944641800becca96ef04e~pbkw_cV8o1233212332euoutp02O
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 11:20:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261119112000euoutp02f7ea4dcb26b944641800becca96ef04e~pbkw_cV8o1233212332euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795087200;
	bh=QjhX4svqgENH27PAAoOn+DesXkt70aYnU/WTBMxaRlI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=qPqvot4d9oG/iUwx+maS5xSX5X6XoywUKZkobSFZ98vTznvDeQMcEYOwy0iWW8oWm
	 /Gy9af7GwuNK0BXMNEWESJdOLJAtysBA3piqxHZOIWBPykY8Aye2lYL6YUzUmJLAhb
	 IkRymHot4ISztBj69JwR4JvLdW7dhTwgmmqIM/Ro=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261119111959eucas1p2bd4a85981864901886c2f6e9681855f3~pbkwmyhTr0716707167eucas1p2y;
	Thu, 19 Nov 2026 11:19:59 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261119111959eusmtip2279ca40ca3a7bf37097daea13deb112f~pbkv7OMEZ1620516205eusmtip2I;
	Thu, 19 Nov 2026 11:19:59 +0000 (GMT)
Message-ID: <fa38a878-1735-4682-b208-5de1616f7e4f@samsung.com>
Date: Thu, 19 Nov 2026 12:19:58 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2] dma-contiguous: support percentage sizes in
 cma_pernuma= and numa_cma=
To: Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Robin
	Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>, David
	Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	nh-open-source@amazon.com, linux-mm@kvack.org, The AWS Nitro Enclaves Team
	<aws-nitro-enclaves-devel@amazon.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261114145328.1307-1-graf@amazon.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261119111959eucas1p2bd4a85981864901886c2f6e9681855f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261114145340eucas1p2f7699b88eae34f7904cf68109dc3eb4f
X-EPHeader: CA
X-CMS-RootMailID: 20261114145340eucas1p2f7699b88eae34f7904cf68109dc3eb4f
References: <CGME20261114145340eucas1p2f7699b88eae34f7904cf68109dc3eb4f@eucas1p2.samsung.com>
	<20261114145328.1307-1-graf@amazon.com>

On 14.11.2026 15:53, Alexander Graf wrote:
> While CMA_SIZE_PERCENTAGE supports percentages for built-in defaults, the
> CMA allocation kernel parameters currently only take a fixed size argument.
> That makes it difficult to have a single system image that sizes its CMA
> allocation based on the available memory. To use CMA as backing pool for
> large, physically contiguous guest memory, I want to be able to say
> "allocate 90% of system RAM minus 1 GiB for CMA". Per NUMA node.
>
> Extend the CMA parser logic to accept command line options like this:
>
>   cma_pernuma=80% numa_cma=0:95%-1G,1:4G
>
> To avoid incomplete allocations on parsing errors, check for them
> before actually allocating.


This looks like an over-engineered feature. I doubt that kernel is the right
place to implement such advanced sizing. If You need to explicitly control
the amount of CMA on the target machines, maybe You could do it in some
scripts deploying the kernel configuration? Calculating it there should be
much more flexible imho...


> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
> v1 -> v2:
>
>   - Reject an empty numa_cma= and a trailing comma (Sashiko)
>   - Keep the last valid size for each option or node, so an explicit 0
>     now overrides a percentage (Sashiko)
>   - Parse percentages as plain decimal, and reject sizes that a 32-bit
>     phys_addr_t cannot hold
>   - Reject a bare cma_pernuma or numa_cma without "=", which mainline
>     dereferences as NULL
>   - Rework the kernel-parameters.txt text accordingly
>
> v1: https://lore.kernel.org/all/20261111140440.43024-1-graf@amazon.com/
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


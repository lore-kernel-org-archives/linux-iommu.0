Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD322D6417
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911844; cv=none; b=m4tyW/ZYUYbXJGqbQiCCibZYVOkZ/BmAWJMTTY4zdxwEpEm0swhrTsgbo1mz8wtJsDPd9cS7jA8qxWOx/Ku8B1/gcJHJw1k4kQQnR4v9AkGfAc9t3nWPpEdlGQbJhkSyH1m7ncSqNWDsAWrIe9P5pCcWuIBmGJ/5ymPEpAYfQHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911844; c=relaxed/simple;
	bh=qGgugLzUTF5jBQJluxDQZOG2jhzpt6KDo9yVbc1/1VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=kGQea0Gs1NcsqUNUuQYHUJ8Xy4L75AZhJRz5/kyliYOYw5OGjeIYv6T7jrUmY48DvcFKqf/Shbqfk6+vbnNEzkZ58kDlvJS/eBHd92iLor5qAQAOBTT6K5YD863Qu+IAmyIU+WJ7N8HrO2C/pKCEhbNGJULeVefPPUlm0S0hk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aCZ6Wyhq; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aCZ6Wyhq"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250811113041euoutp013c371b5dd567f187ff27995726b27998~aswWB7lLJ1939019390euoutp01M
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 11:30:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250811113041euoutp013c371b5dd567f187ff27995726b27998~aswWB7lLJ1939019390euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754911841;
	bh=L6xMk6WoA+buVIq01BGEkoQ9iUsmyv2TEFGyNGAxPvI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=aCZ6WyhqHucubjHfPCL4JvoF9vpsRLQVN2YNwSULHFq2LqWjJzzcXnIWiykaRyvfG
	 lBtSy4j2ks5amL1xZs57ygWCYKQ2bsEJ+zd8H9qEWMnHc9kZXU/ydNgSg9/L30F89m
	 U3wXJ23nvywkRE/lSCi8mFBfkeZzjJd1zDm5uxFU=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250811113040eucas1p112d10619f5915f725da35e16d640191f~aswVziK5V3122431224eucas1p1Z;
	Mon, 11 Aug 2025 11:30:40 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250811113040eusmtip2261b30366c04882f44de8c395abc0fb9~aswVf-owA1993919939eusmtip2L;
	Mon, 11 Aug 2025 11:30:40 +0000 (GMT)
Message-ID: <207dbba6-2f2c-47dd-a30f-7baf3c2a05f3@samsung.com>
Date: Mon, 11 Aug 2025 13:30:39 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] swiotlb: Remove redundant __GFP_NOWARN
To: Qianfeng Rong <rongqianfeng@vivo.com>, Robin Murphy
	<robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: willy@infradead.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250805023222.332920-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250811113040eucas1p112d10619f5915f725da35e16d640191f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250805023241eucas1p26fcc7632e9f845824f4fb4b98477c654
X-EPHeader: CA
X-CMS-RootMailID: 20250805023241eucas1p26fcc7632e9f845824f4fb4b98477c654
References: <CGME20250805023241eucas1p26fcc7632e9f845824f4fb4b98477c654@eucas1p2.samsung.com>
	<20250805023222.332920-1-rongqianfeng@vivo.com>

On 05.08.2025 04:32, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
> made GFP_NOWAIT implicitly include __GFP_NOWARN.
>
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
> (e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
> up these redundant flags across subsystems.
>
> No functional changes.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Thanks, applied to dma-mapping-for-next branch.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


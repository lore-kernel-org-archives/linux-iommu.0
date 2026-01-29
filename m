Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E70B3783A5
	for <iommu@lists.linux.dev>; Thu, 29 Jan 2026 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678790; cv=none; b=q3XNug6p+lULt0xJXmJYuvg5FVkH4KUSmgYgD2JxLGUfzAAPD3D2f4dA7gOTz5rz3dECc1CO4M/CBDETXWeQcN+5/gzNvPM1prpEvkpR4y8DWNOgg712dIr1/BSdS5eK4JSgmaj7lLHKcwE0j713+xPE9s89qkQ9PV6/rvC8loI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678790; c=relaxed/simple;
	bh=ccCONtcKXqhEmPk5QvgW5SUMXkuoJOfXstA43EsiTc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=jPMpApevMKF0XQHBT+Wn6fuSzANbNIGZpEkNVNs/QuZo+P+n4+ls0X+9sgHwKFRenxWF2fZx9Doo0gHEf5yThr2rlRZ4J/NEinexo5YdffE9a+RODPTxeW7263JPsQOg1BXyoC14HFFGAh5Wr16ZYvAm/RwPbhjw2o0NaJku4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=q50TIiOA; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q50TIiOA"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260129092626euoutp02f10bf824b84bd202df629ced67ba0810~PKXreW5b-1964819648euoutp02f
	for <iommu@lists.linux.dev>; Thu, 29 Jan 2026 09:26:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260129092626euoutp02f10bf824b84bd202df629ced67ba0810~PKXreW5b-1964819648euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769678786;
	bh=lwek8TSmv+iAAOe/4I9DJSelYRcZUta7xs3BWN/rHR8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=q50TIiOAkKe0oT5Exb6V9nrwyJidUB8VdusDlzjB4JuJGkHHxJjKlDHv+tojGpxng
	 qeunvWEupx1C90g/MpXUTIbiQNDxbmGOM9qMe/ImXzOVsAMSKWEf6ySBLiB2w2Memo
	 zRPx/rGjTkkqLh2TbOOWH04zpK7S/AVGET7zM0Ik=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260129092626eucas1p136c77b24b0fbc18b7d5c70351503b81c~PKXrWGvNi3254632546eucas1p1y;
	Thu, 29 Jan 2026 09:26:26 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260129092625eusmtip15a81d9ceb1844cd1e892901fc4754e07~PKXrFv2mQ0295602956eusmtip1h;
	Thu, 29 Jan 2026 09:26:25 +0000 (GMT)
Message-ID: <54bbe979-e6cd-47b6-bbe6-dbc58def3fc9@samsung.com>
Date: Thu, 29 Jan 2026 10:26:25 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3] dma/pool: distinguish between missing and exhausted
 atomic pools
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: vigneshr@ti.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260128133554.3056582-1-s-adivi@ti.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260129092626eucas1p136c77b24b0fbc18b7d5c70351503b81c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260128133621eucas1p22cd752b033c780f52b6fee2dfaec1593
X-EPHeader: CA
X-CMS-RootMailID: 20260128133621eucas1p22cd752b033c780f52b6fee2dfaec1593
References: <CGME20260128133621eucas1p22cd752b033c780f52b6fee2dfaec1593@eucas1p2.samsung.com>
	<20260128133554.3056582-1-s-adivi@ti.com>

On 28.01.2026 14:35, Sai Sree Kartheek Adivi wrote:
> Currently, dma_alloc_from_pool() unconditionally warns and dumps a stack
> trace when an allocation fails, with the message "Failed to get suitable
> pool".
>
> This conflates two distinct failure modes:
> 1. Configuration error: No atomic pool is available for the requested
>     DMA mask (a fundamental system setup issue)
> 2. Resource Exhaustion: A suitable pool exists but is currently full (a
>     recoverable runtime state)
>
> This lack of distinction prevents drivers from using __GFP_NOWARN to
> suppress error messages during temporary pressure spikes, such as when
> awaiting synchronous reclaim of descriptors.
>
> Refactor the error handling to distinguish these cases:
> - If no suitable pool is found, keep the unconditional WARN regarding
>    the missing pool.
> - If a pool was found but is exhausted, respect __GFP_NOWARN and update
>    the warning message to explicitly state "DMA pool exhausted".
>
> Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>

Applied to dma-mapping-fixes. Thanks!


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


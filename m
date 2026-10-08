Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E45394EB0
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454094; cv=none; b=fdswM/F1iR3iHZ1tsCS1nztaEo8Llb/EJEB+doCQ6c+99NKqAMunV57gyN2vqsQWossh0TN0593YrXvI5SWCXUASCDgWzsks6RQTaSoyroU17FrXQX+Vim6QOeiWWquYXXYePBxnJN21cA2bvJlAzouvNK7uCAeEO4DU4Mshmeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454094; c=relaxed/simple;
	bh=zQgFjchZZC7S3VyqKk+8K37VIQAceuw7hsVTiaB97K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=rR4ih5HhUVgwc0qj2hytzcdPuyoGEa49ZJOts+5AYUmrsIyJLeX8IzdggvawEiLo+yEUN7xVGUKqvX6MmBomJ83J/FqiUFdAW68rcdlYntL5phYOwSerJOKfSQsZn5zGPR0iosLe7KPuboawnQbbk64sIVE3JFCcOkMO0akzWZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bLcNtjau; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bLcNtjau"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261008100810euoutp0289c1862d4f908c43174f6ebecfeefa7d~chgDb0K5c2389323893euoutp02X
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 10:08:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261008100810euoutp0289c1862d4f908c43174f6ebecfeefa7d~chgDb0K5c2389323893euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791454090;
	bh=qPIIfNHfK+h832BLKqeX1sylPKmD+Ti0Dfta4FiZqP4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=bLcNtjaux4RXD1Zv9OViOFRKXdAlVTHlEcRBEg+lvwTvd/1kv5HfviXHeCafy/089
	 8HNz4Zeexx6iCJPzb9X8BbByKvnenXuDB4yHMbqYIzX4pbTWHQ/YoiQuyQb4AsfEHI
	 h332YKwT7wosHEHSRKflY6qIKWxmehbMgfr4un3U=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261008100809eucas1p178afec767296085a137e7ae9493011d4~chgDP0jCF3207032070eucas1p1Z;
	Thu,  8 Oct 2026 10:08:09 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261008100809eusmtip2ffe3f4e519b7b5d1f8f7f822ebdfc383~chgC7yDxz2266322663eusmtip23;
	Thu,  8 Oct 2026 10:08:09 +0000 (GMT)
Message-ID: <8a43211a-4f13-4e5a-a549-289a633762f5@samsung.com>
Date: Thu, 8 Oct 2026 12:08:08 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma: swiotlb: use KiB in restricted pool allocation log
To: Francesco Valla <francesco@valla.it>, Robin Murphy
	<robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261008-swiotlb-size-print-v1-1-374493b5c5a6@valla.it>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261008100809eucas1p178afec767296085a137e7ae9493011d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261007220543eucas1p19170ec07885046129718b630c71ab9cb
X-EPHeader: CA
X-CMS-RootMailID: 20261007220543eucas1p19170ec07885046129718b630c71ab9cb
References: <CGME20261007220543eucas1p19170ec07885046129718b630c71ab9cb@eucas1p1.samsung.com>
	<20261008-swiotlb-size-print-v1-1-374493b5c5a6@valla.it>

On 08.10.2026 00:05, Francesco Valla wrote:
> Update the allocation logs for restricted memory pools to use KiBs
> instead of MiBs, to avoid truncation when the size of the memory area is
> not a multiple of a MiB.
>
> Without this modification, pools smaller than 1MiB are logged as 0MiB.
>
> The same modification has already been performed for coherent memory
> pools [1].
>
> Link: https://lore.kernel.org/all/20260629223759.2637162-1-sharaienko@google.com/ [1]
> Signed-off-by: Francesco Valla <francesco@valla.it>

Applied to dma-mapping-for-next. Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


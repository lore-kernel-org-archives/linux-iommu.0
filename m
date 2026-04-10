Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D513DEAE0
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823653; cv=none; b=SqxjRDLSyAkOFMuel8eCI9CQKlsvSeOw7iArISfKpmbNfKC/5E+7XN3bNBV1A0rUcSyUZlmry1kZalIwPBYPrzKv5I7lPrYSLMMXugIakVyfKoc3XvTBRMR6COLXOQOcsdo43vJKSd61QAr0Gpj/lUWsltzeq/clZFHvpntbKqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823653; c=relaxed/simple;
	bh=51YK6I53KlWTkGpTMwW2r2N8AZPPMihRKqkSq8enjS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=quoqEX24SAS1TMRfkRsk/QUaAah63fbT+yXB78az+lu1k8IIa45rjIEsfxq3Pu48CXa3+SHSZqm4gvZdG8ReqJbHdiyhs8aTt5uLRNOBlefOy9/A5j+dbTyYyw4uMzEutld/flOEJku/o+l1Z7fsD62vVTyphfk8GVlqt3OQDh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NqtE3ZUG; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NqtE3ZUG"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260410122049euoutp014389cc58939f4e3cbf90970c6cc97433~k-jNeCuTH1906719067euoutp015
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 12:20:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260410122049euoutp014389cc58939f4e3cbf90970c6cc97433~k-jNeCuTH1906719067euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1775823649;
	bh=lN5zWO6+anmGDngLkOfFZEph7VAV3nISscwbspgkQFg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=NqtE3ZUGhjK5b+8l3UJojriJ5nrit/EwmaDAMcMN1Br+4xN1xUNTVGwRO9rgOuFEb
	 Bx2jTuJ8f+oN9wlq+XE/SWAFwLerZjUb96fqzAMZHDkFsEJdpJG3ASlCz+YzeKizNO
	 GJFKrCnlGUMsKgU/vRZdu0YCgkUV/c9nFfJj/i48=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260410122049eucas1p2207046638096d1540b23f0a14d6169ac~k-jNEfoaG3206132061eucas1p2p;
	Fri, 10 Apr 2026 12:20:49 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260410122047eusmtip17c8b02f981e525f46be03f8d2d0e134f~k-jLa09If3110231102eusmtip1Z;
	Fri, 10 Apr 2026 12:20:47 +0000 (GMT)
Message-ID: <9e3f7066-f147-4854-b662-9027fa7d3c80@samsung.com>
Date: Fri, 10 Apr 2026 14:20:46 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2] dma-buf: heaps: system: document system_cc_shared
 heap
To: Sumit Semwal <sumit.semwal@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	iommu@lists.linux.dev, linux-media@vger.kernel.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com,
	tjmercier@google.com, christian.koenig@amd.com, robin.murphy@arm.com,
	jgg@ziepe.ca, leon@kernel.org, ptesarik@suse.com, catalin.marinas@arm.com,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com,
	thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
	suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAO_48GFt21rv0PJd2Csa0O4OEpN053_p__4Zux+m7jQdHSagEg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260410122049eucas1p2207046638096d1540b23f0a14d6169ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260410121457eucas1p1450d22bb1d09d9978fe68e801d8c2a58
X-EPHeader: CA
X-CMS-RootMailID: 20260410121457eucas1p1450d22bb1d09d9978fe68e801d8c2a58
References: <20260407092617.635223-1-jiri@resnulli.us>
	<CGME20260410121457eucas1p1450d22bb1d09d9978fe68e801d8c2a58@eucas1p1.samsung.com>
	<CAO_48GFt21rv0PJd2Csa0O4OEpN053_p__4Zux+m7jQdHSagEg@mail.gmail.com>

On 10.04.2026 14:14, Sumit Semwal wrote:
> On Tue, 7 Apr 2026 at 14:56, Jiri Pirko <jiri@resnulli.us> wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Document the system_cc_shared dma-buf heap that was introduced
>> recently. Describe its purpose, availability conditions and
>> relation to confidential computing VMs.
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> Reviewed-by: T.J.Mercier <tjmercier@google.com>
> Thank you for the patch!
>
> Marek: Since you're taking the dependent patches through your tree,
> could you please use:
> Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
>
> and take this as well?

Yes, sure. Applied to dma-mapping-for-next. Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592970;
	b=QaoddyOu8tyP8m+rNuBULNvTmjC50zafwqLnCd3TBUKb2q/683cLSd1R/JBAeB6ljK/f
	 XZPQbXS/sb/iyqyxTZBEZrWQQEC7jNbC2ntlf61qxAVAzBQH1BB0est2dMxH90V4fShi+
	 Yr4U3dmREq7EPK/ZDiHRnhkUhNsEeE4c2NNmG93DmGg33M5ZGHoO6N/sS77eFhhFD09qo
	 VVrg+oO1BzXOZg+buZT2wgWN1zFOOZWP8wcSOz6x7O+Ks4QjN3wY9RcYmZfXrpFE3cEnE
	 qzla1Dtkn6xXEddznsRwhg74D+3a77nKn/F2R/0cpmWEzex6E/+Zfx1nnS0QtCMkC6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592970;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=moULo+zYqg9swYV2aKHcAmhUVeIT6ck6nZOqYtJcyA0=;
	b=1dmbMzA2cDeRunm7HT0l/RcDQMr09Pvd3OMrGzrASQGD055vRLkqh+jIZEupevWo6JBN
	 DcYo1f4lw5Xzhg6WeYE5i9ShI0r0/R++00cWQA13twL/Uev1quFkGXqIym0qiRoP5rFv/
	 WRvzj1J5gvq+llw1efZFDla7enc/BEdkGzfMK4QUmDKYpN3KvisbhUQVxll1/4P1YjwbV
	 cLFusXqJRjPocs2BMTC+CYHuQ1ZRcvHA+rkR2phnrvAhhshni3zdc5xtrRxicK1dX1chb
	 FyNfER1OfnG5SszYBqzoTi7dkUZ5+8ZRZ97DxwLzHUNLMFeXIrc15Xv2bNgQOKoiyMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="HzE8z/K7";
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61BC606A329
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 07:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D61BC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=HzE8z/K7
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261125074926euoutp029765d8f66614f9a5a723a1ad7e004711~rOkoxzrUh0699806998euoutp02Z
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 07:49:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261125074926euoutp029765d8f66614f9a5a723a1ad7e004711~rOkoxzrUh0699806998euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795592966;
	bh=moULo+zYqg9swYV2aKHcAmhUVeIT6ck6nZOqYtJcyA0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=HzE8z/K7YIo7l12YV/WBlCx/dzvLRQck2HKCLMwZ3251NSKWzDT3hQGVaEf1Ty211
	 30Tx1DzsTky7ZE/NQtIt+isMxW3Mtq4GSt62e00wU2iVvnuCABhCH+70pVHMoP5Xkf
	 nJv5VJZGMGRVqpZaF9xbfes/3qQpbNCB3qgqREG4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261125074926eucas1p18d5e57c2c8f3be85a85a007270c860be~rOkok6o3m0116101161eucas1p1f;
	Wed, 25 Nov 2026 07:49:26 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261125074926eusmtip28e4bfe207a1ea602f1386a1e9d05e2fd~rOkoEOvjx1909919099eusmtip2-;
	Wed, 25 Nov 2026 07:49:25 +0000 (GMT)
Message-ID: <bfe80e4a-572b-4362-834d-8c4a26c6d03a@samsung.com>
Date: Wed, 25 Nov 2026 08:49:25 +0100
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
Subject: Re: [PATCH] dma: swiotlb: Use system_percpu_wq for dynamic pool
 freeing
To: Kohei Enju <enju.kohei@fujitsu.com>, Robin Murphy
	<robin.murphy@arm.com>, "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Petr Tesarik <ptesarik@suse.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261125-swiotlb-replace-system_wq-v1-1-83807c6afb75@fujitsu.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261125074926eucas1p18d5e57c2c8f3be85a85a007270c860be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261125003956eucas1p215758cc5f1caa01a5389246c60b1d79a
X-EPHeader: CA
X-CMS-RootMailID: 20261125003956eucas1p215758cc5f1caa01a5389246c60b1d79a
References: <CGME20261125003956eucas1p215758cc5f1caa01a5389246c60b1d79a@eucas1p2.samsung.com>
	<20261125-swiotlb-replace-system_wq-v1-1-83807c6afb75@fujitsu.com>

On 25.11.2026 01:39, Kohei Enju wrote:
> system_wq is deprecated, and queueing dynamic SWIOTLB pool teardown work
> on it causes the following warning:
>
>   workqueue: work func swiotlb_dyn_free_work enqueued on deprecated workqueue. Use system_{percpu|dfl}_wq instead.
>
> Use system_percpu_wq instead, which preserves the per-CPU workqueue
> behavior of system_wq.
>
> Fixes: e13d4d9a4915 ("dma: swiotlb: free dynamic pools from process context")
> Signed-off-by: Kohei Enju <enju.kohei@fujitsu.com>

Applied to dma-mapping-for-next, thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


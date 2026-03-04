Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4F371886
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618436; cv=none; b=Tmmj4LSGPJRtEvJIW2E9wBkWNpPEtMmdoq5ize116lIHIxH9LfPhqy4Lvmnd3mdUuc0iEHmavlQQkE5FxivSpCcf3dCneJGTnX/8fy06TiPuH/NqeZOX35It4h2095FPNu4HDFRuTSr6mvlfFvyW8z8/+1HG7ZxKQbsD0FgDwQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618436; c=relaxed/simple;
	bh=YBpPCsW0X6dwI9chaUbCAqQQr9Rj9bvxyNGKF94Sqho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=HWzpTwPcoSn40tjJrVky6G2yvdD9lcT3H021N4CuyqNLDPUJs4L21taRzLfpgP2sRDNs8fjnb4DEyJKKwgrXajtwZRMFirk7vDrm7qYW011+X4ClG7ODsRAZygmOz49JUC0AbV1aroOznn4uO4ZfoN/NjDmATLxZMXkCmeX9FqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tqavopu7; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tqavopu7"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260304100032euoutp01d4e179ad06eafd171272a5648e00b75c~ZmxKfmV5t1477814778euoutp01v
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 10:00:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260304100032euoutp01d4e179ad06eafd171272a5648e00b75c~ZmxKfmV5t1477814778euoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772618432;
	bh=MsvRD4cFUfZG8OZibfY1jkyvnc1twBB3a0mO7hOEVWU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tqavopu7Ld00D70aw5KmgP0g4kQXjdyq+7bZrbcBc3zeuzGdTjhjt/C2RKsVkmCpp
	 4naspZ5+9AidaczMHg/bQrewYncAg6VvSyUXaQUSG3y4jn4yhSBxGqei+7Bg2SXIVE
	 GJnjdrNK8obNuN/6GfIZqO3SczU1sC+ZoUOgJZoU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260304100032eucas1p244a7c9f991575cafb653f812ffd7e89e~ZmxKEZPio3115531155eucas1p2c;
	Wed,  4 Mar 2026 10:00:32 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260304100031eusmtip1d611a4c01234db781b2da6218263306f~ZmxJoTmkK1157411574eusmtip12;
	Wed,  4 Mar 2026 10:00:31 +0000 (GMT)
Message-ID: <cd026591-c278-4f89-9d21-1a2125a85a44@samsung.com>
Date: Wed, 4 Mar 2026 11:00:30 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYXJtNjQ6IHN3aW90bGI6IERvbuKAmXQgc2hyaW5r?=
 =?UTF-8?Q?_default_buffer_when_bounce_is_forced?=
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, suzuki.poulose@arm.com, steven.price@arm.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <yq5a8qd6iep6.fsf@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260304100032eucas1p244a7c9f991575cafb653f812ffd7e89e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260206061145eucas1p1917446df9763565b2b5ef829c5350a69
X-EPHeader: CA
X-CMS-RootMailID: 20260206061145eucas1p1917446df9763565b2b5ef829c5350a69
References: <20260120070102.182977-1-aneesh.kumar@kernel.org>
	<aYOVf066Fdr9L-nw@arm.com>
	<CGME20260206061145eucas1p1917446df9763565b2b5ef829c5350a69@eucas1p1.samsung.com>
	<yq5a8qd6iep6.fsf@kernel.org>

On 06.02.2026 07:11, Aneesh Kumar K.V wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
>> On Tue, Jan 20, 2026 at 12:31:02PM +0530, Aneesh Kumar K.V (Arm) wrote:
>>> arm64 reduces the default swiotlb size (for unaligned kmalloc()
>>> bouncing) when it detects that no swiotlb bouncing is needed.
>>>
>>> If swiotlb bouncing is explicitly forced via the command line
>>> (swiotlb=force), this heuristic must not apply. Add a swiotlb helper to
>>> query the forced-bounce state and use it to skip the resize when
>>> bouncing is forced.
>> I think the logic you proposed in reply to Robin might work better but
>> have you actually hit a problem that triggered this patch? Do people
>> passing swiotlb=force expect a specific size for the buffer?
>>
> This issue was observed while implementing swiotlb for a trusted device.
> I was testing the protected swiotlb space using the swiotlb=force
> option, which causes the device to use swiotlb even in protected mode.
> As per Robin, an end user using the swiotlb=force option will also
> specify a custom swiotlb size

Does the above mean that it works fine when user provides both 
swiotlb=force and custom swiotlb size, so no changes in the code are 
actually needed?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


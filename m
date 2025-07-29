Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B734291C2C
	for <iommu@lists.linux.dev>; Tue, 29 Jul 2025 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792365; cv=none; b=OLFIfdUVQ8NHF6j9KMuqOXGya/k7+8Bb9xFWo/wkPF/M/V6Zq33e3PQ8/aQoC/ecF0xfkrJFOSUynEcbZoV88gDEcoOh9qZM/nL5SVXnThiMzVMtA1Sclhdh/n32FPB15PJnNfAiPm2Lfott5IsTGl0Ae5dCtpI03zp7nfNqbmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792365; c=relaxed/simple;
	bh=F0U9tOsIWBxB5V9QFWwOrrJvwb5CFCLHmznPY0NkiR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=lFI0RO6yVQko05zI6uNrP0Ftmu5JQ56BG7aXREnay4UbThfqwm/x8fBTzobPb2sL62d3zrZHQu413JWtUfR/Howl0cfmbpTXZIZNOsRa/MRSB5iPzHGQ32vVbzZAPgRcPuOtAetkTPJszCNnPtX5FQ5zcY5RIONFJJu8hSTobGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FH7I6dI5; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FH7I6dI5"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250729123241euoutp01e3a6c1ef71cd45697709a094eb58fd6b~WuNxCiW3U0754507545euoutp01D
	for <iommu@lists.linux.dev>; Tue, 29 Jul 2025 12:32:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250729123241euoutp01e3a6c1ef71cd45697709a094eb58fd6b~WuNxCiW3U0754507545euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753792361;
	bh=3LYZR9mSVhFgVzlWrABq7dBJzbVgSWzdA/30Vq0AO04=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=FH7I6dI5sBRxcwRbJG+kjCooSVoVWcjOdaqo2cUnIV6ovpI2KQkMVC3tzS19o+GMV
	 k3nhk0Hc6FeDilvatyOHF9+BoSAJ9qGUjZJIQSwO3VN3n63xYFaxiW6o2tWXMq1fb3
	 AjAmOY6MN47ftYcBpK9pFRoZthkTEUi0MPzwPEHc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250729123240eucas1p2da5025405c8d21253ab726c3af3958ee~WuNwgaLii1976519765eucas1p2M;
	Tue, 29 Jul 2025 12:32:40 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250729123239eusmtip1a18af246575151c14321af4e1dcb2ca6~WuNv_1VOc2440624406eusmtip1w;
	Tue, 29 Jul 2025 12:32:39 +0000 (GMT)
Message-ID: <f8c0cbdc-9c68-46bb-8dad-1d7c80f3f741@samsung.com>
Date: Tue, 29 Jul 2025 14:32:39 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Barry Song <21cnbao@gmail.com>, Qinxin Xia <xiaqinxin@huawei.com>
Cc: robin.murphy@arm.com, jonathan.cameron@huawei.com,
	prime.zeng@huawei.com, fanghao11@huawei.com, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, iommu@lists.linux.dev
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAGsJ_4zSw57DMyRZM24BUdDpbi4+BRfgWUqxSKurCsAVC7Kptw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250729123240eucas1p2da5025405c8d21253ab726c3af3958ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250724094224eucas1p13a911259338ac1890d4baed8b9998fb0
X-EPHeader: CA
X-CMS-RootMailID: 20250724094224eucas1p13a911259338ac1890d4baed8b9998fb0
References: <20250724085600.4101321-1-xiaqinxin@huawei.com>
	<20250724085600.4101321-3-xiaqinxin@huawei.com>
	<CAGsJ_4zVR3R7erGP57vxM8vKBARG8BttA=FsCVFjy4QtswcsQw@mail.gmail.com>
	<c7f7d9b3-2ab3-4ebd-99fb-071733573291@huawei.com>
	<CGME20250724094224eucas1p13a911259338ac1890d4baed8b9998fb0@eucas1p1.samsung.com>
	<CAGsJ_4zSw57DMyRZM24BUdDpbi4+BRfgWUqxSKurCsAVC7Kptw@mail.gmail.com>

On 24.07.2025 11:42, Barry Song wrote:
> On Thu, Jul 24, 2025 at 5:35 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>> On 2025/7/24 17:07:08, Barry Song <21cnbao@gmail.com> wrote:
>>> On Thu, Jul 24, 2025 at 4:56 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>>> The padding field in the structure was previously reserved to
>>>> maintain a stable interface for potential new fields, ensuring
>>>> compatibility with user-space shared data structures.
>>>> However,it was accidentally removed by tiantao in a prior commit,
>>>> which may lead to incompatibility between user space and the kernel.
>>>>
>>>> This patch reinstates the padding to restore the original structure
>>>> layout and preserve compatibility.
>>>>
>>>> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header file for map_benchmark definition")
>>>> Cc: stable@vger.kernel.org
>>>> Acked-by: Barry Song <baohua@kernel.org>
>>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>>> I don’t think these two patches should be part of the same series. This
>>> one is a bug fix and should be handled separately—ideally picked up on
>>> its own and backported to stable.
>>>
>>> Also, the subject should not say "Add"—it should be "Restore". I assume
>>> Marek can handle it?
> ...
>> Ok, I will send a new version to fix it.
> If Marek can help fix it while picking it up into the dma-mapping tree, you
> might not need to send a new version.
>
> Honestly, I hope this gets merged soon—it feels like it's been
> overdue for quite a while.

I'm sorry, I wasn't aware that this need to go via dma-mapping tree. I 
will take it after this merge window.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


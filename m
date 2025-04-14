Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC09C25D204
	for <iommu@lists.linux.dev>; Mon, 14 Apr 2025 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624955; cv=none; b=VX7kr+ymb50JF2rLod7fmz0GihnmoH72RdHEDBG+2xuw4av/F0sOoPjvypHB8gVHOyL+WUCn79bsAyUb1brU4Vr9pWw7GMDgwF+xm+MqrTjJ+jtT+OEBsXS8GgK+UZA43FdJ99rFKhiP4cMJx6XpGCT9PHxOSPUZsVMoiHUHk1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624955; c=relaxed/simple;
	bh=Q2m9ZrABVSuBpbhOeAjVE5x9R14zox7JUL8LuSWF2Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=RKuYNluCM/RtxJ+H4k6AsTFKZ9gdTmIMZnUgvNie5ZikdkQiWcusHHSt6815CLIkZN+jIGQVvFyN4v4G1ZCn/NBY6i8EWUZecTD9n3bUq1ukJViUKw5tfwD78Ky5V1H7lTGzsBgzmrarLxqXqkgcDAfAzsjYcGD6v9yJMvqAo0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FBQ1kGdM; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FBQ1kGdM"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250414100224euoutp01f4fa97ae660b079afde67013d7418809~2JyTZw-1o1764717647euoutp01M
	for <iommu@lists.linux.dev>; Mon, 14 Apr 2025 10:02:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250414100224euoutp01f4fa97ae660b079afde67013d7418809~2JyTZw-1o1764717647euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744624944;
	bh=CQ/Mexkd9UWOwgHiElf+yh/sO2d1kwDM+dtAGV0p8qo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=FBQ1kGdM0yzduIyfb1CKlynFE/yFm7TwRrOLkcytSUIbkeOHgyNTFQdWdXotS+/2j
	 xRoXNMvBYXJOYHF+iW8uCPjhr2bfjZR4ec0v+6ImnY/cDrAkAJPXm3cGj7ocU2Dtat
	 FrJbl8yN9sPy5RHyIkHUUnb1e/S/IBdJhaMIYmGQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250414100224eucas1p1d7900093465f4bfe9815b8e25f5018d7~2JyTEwQ5o1141111411eucas1p1b;
	Mon, 14 Apr 2025 10:02:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id C6.02.20409.03DDCF76; Mon, 14
	Apr 2025 11:02:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250414100224eucas1p12892ef03f22b1a0255c48802f80e2c05~2JySosd9q1137911379eucas1p13;
	Mon, 14 Apr 2025 10:02:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250414100224eusmtrp1dee4c60e7b25f2bfee4c9ec6b5b0d58d~2JySoCgP-0222602226eusmtrp1T;
	Mon, 14 Apr 2025 10:02:24 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-cd-67fcdd305538
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id AB.B5.19654.F2DDCF76; Mon, 14
	Apr 2025 11:02:23 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250414100222eusmtip1754828cfce7ee82b10396ee4e191a87c~2JyRdjQld0723607236eusmtip1Y;
	Mon, 14 Apr 2025 10:02:22 +0000 (GMT)
Message-ID: <77f411d3-379a-421c-bd41-55e4de6fa8c0@samsung.com>
Date: Mon, 14 Apr 2025 12:02:20 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] dma/mapping.c: WARN_ONCE on dma_addressing_limited()
 being true
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Balbir
	Singh <balbirs@nvidia.com>, Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Robin Murphy
	<robin.murphy@arm.com>, Ingo Molnar <mingo@kernel.org>, Kees Cook
	<kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Andy
	Lutomirski <luto@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Bert
	Karwatzki <spasswolf@web.de>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <4b6f9eb7-7de0-4d0f-b235-fd203f4a8542@amd.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7djP87oGd/+kG8w6LWUx7c5uVoslc48z
	WyxpyrB4ex/IOz1hEZPFry8WFuvenme1uLxrDpvF+V1rWS1W/zvFaHG89wCTxcEPT1gtXk+8
	zWrxqO8tuwOfR+ulv2wea+atYfRYsKnUY/MKLY9NqzrZPE7M+M3i8WLzTEaP3uZ3bB6fN8l5
	3H62jSWAK4rLJiU1J7MstUjfLoEro+XZZOaCWwIVG89dZW9gPMnbxcjJISFgIvGuq5Gli5GL
	Q0hgBaPEy3vzmSGcL4wS719OY4NwPjNKnHrYw9TFyAHWcu9yOEi3kMByRom1J4ohaj4ySsy5
	e40dJMErYCex+9ARMJtFQFViZd87Zoi4oMTJmU9YQGxRAXmJ+7dmgNUIC4RIfLl2jhVkkIhA
	N6PEp7tfwM5gFuhnljj5YStYB7OAuMStJ/OZQGw2AUOJrrddbCAXcQpYS2xaEAJRIi/RvHU2
	WK+EwGZOiQtTV7FDXO0isessH8TPwhKvjm9hh7BlJE5P7mGBqG9nlFjw+z4ThDOBUaLh+S1G
	iCpriTvnfoEtYxbQlFi/Sx8i7CjR1fOYEWI+n8SNt4IQN/BJTNo2nRkizCvR0SYEUa0mMev4
	Ori1By9cYp7AqDQLKVhmIXlyFpJvZiHsXcDIsopRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93
	EyMw5Z3+d/zLDsblrz7qHWJk4mA8xCjBwawkwsvl/CtdiDclsbIqtSg/vqg0J7X4EKM0B4uS
	OO+i/a3pQgLpiSWp2ampBalFMFkmDk6pBqbonR8aox96LfW5+M8jLkNM6Y3xrncT7DVZX0S+
	a857/MLx/r6P0gaCq3k2nyqV1kj3b57+qcZq+rTXwi7fEgK31b95aCE+sfT3Y4F3z5rW/33m
	9J1v8Z3TGQqZ/3RtrpvdCD3B1P1/TdE5dtvkRvsqgzmTH4c9Unr9Z1rfZ5W34RrhwUGLI/sq
	N1eFVM770v1utbbL76CSHd6/8/82NNcsVVrF7Z7o1VD6NGJqmuTitHe25Zdvz+Zi4Nx9ZbGy
	nNnpMyd+GTyrUjvDK9C7d0q6v5D7ZIVlrhJt84JyHxz0Dpe2l1/essSzLfHGKjUmp7ztbGnT
	jsgsPBo26VMLg+2TUzteaB26zvVa1USsyEmJpTgj0VCLuag4EQDzqkLv6AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xu7r6d/+kG3xdaGUx7c5uVoslc48z
	WyxpyrB4ex/IOz1hEZPFry8WFuvenme1uLxrDpvF+V1rWS1W/zvFaHG89wCTxcEPT1gtXk+8
	zWrxqO8tuwOfR+ulv2wea+atYfRYsKnUY/MKLY9NqzrZPE7M+M3i8WLzTEaP3uZ3bB6fN8l5
	3H62jSWAK0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjf
	LkEvo+XZZOaCWwIVG89dZW9gPMnbxcjBISFgInHvcngXIxeHkMBSRold8++wdzFyAsVlJE5O
	a2CFsIUl/lzrYgOxhQTeM0q8bRMDsXkF7CR2HzoCVs8ioCqxsu8dM0RcUOLkzCcsILaogLzE
	/VszwGqEBUIkWvr2soAsExHoZpS4MP0CmMMs0M8s8fPsDXaIM6YySZx/+QNsHbOAuMStJ/OZ
	QGw2AUOJrrcgZ3BwcApYS2xaEAJRYibRtbWLEcKWl2jeOpt5AqPQLCSHzEIyaRaSlllIWhYw
	sqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjPJtx35u2cG48tVHvUOMTByMhxglOJiVRHi5
	nH+lC/GmJFZWpRblxxeV5qQWH2I0BYbGRGYp0eR8YJrJK4k3NDMwNTQxszQwtTQzVhLnZbty
	Pk1IID2xJDU7NbUgtQimj4mDU6qByXEJ+/6DE1rvr/oRqbh6jlz787enP/3VDFQLMt1f6elg
	PmlZ47vbiT42fOHaD792VTcx1n57KlCo+sTMoMzf03+yLJvz7IdCe5T/nWHf5bJgXqSCgJ3k
	2ajSgoUcLM/f/r37Y2q6+97NPKt1NuSU1TG0mJ95PsHtwhvGTNFJyb8Oit8Ja/km0rB8jt3V
	jEiLl50q3zk/77aIC3NfHeovdyElRvbAaZ198b56DwzM9xtqVJd+n3w44tDdOXfTux/cvyXy
	LO3ZY/OHwq//PO2tn7ecQ27Co/sKhRu4zwg+v7rssUms5dpgidfzFk559T2paqdK7vW65rrZ
	diXZb/c7Rtyu458WeGB/o/HDc8XuXkosxRmJhlrMRcWJAFmh31x7AwAA
X-CMS-MailID: 20250414100224eucas1p12892ef03f22b1a0255c48802f80e2c05
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250414094539eucas1p25aa8c91172e59f370354d1c9799763e2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250414094539eucas1p25aa8c91172e59f370354d1c9799763e2
References: <20250412094110.3208838-1-balbirs@nvidia.com>
	<Z_yjDsmjjCAMHUrh@infradead.org>
	<22a1216b-4ab4-493e-a1f9-1588840339d8@nvidia.com>
	<CGME20250414094539eucas1p25aa8c91172e59f370354d1c9799763e2@eucas1p2.samsung.com>
	<4b6f9eb7-7de0-4d0f-b235-fd203f4a8542@amd.com>

On 14.04.2025 11:45, Christian König wrote:
> Am 14.04.25 um 10:25 schrieb Balbir Singh:
>> On 4/14/25 15:54, Christoph Hellwig wrote:
>>> On Sat, Apr 12, 2025 at 07:41:10PM +1000, Balbir Singh wrote:
>>>> In the debug and resolution of an issue involving forced use of bounce
>>>> buffers, 7170130e4c72 ("x86/mm/init: Handle the special case of device
>>>> private pages in add_pages(), to not increase max_pfn and trigger
>>>> dma_addressing_limited() bounce buffers"). It would have been easier
>>>> to debug the issue if dma_addressing_limited() had a warning about a
>>>> device not being able to address all of memory and thus forcing all
>>>> accesses through a bounce buffer. Please see[2].
>>>>
>>>> A warning would have let the user of the system know that in their
>>>> particular case, use_dma32 is set due to the addressing limitation
>>>> and this would impact performance of the driver in use.
>>>>
>>>> Implement a WARN_ONCE() to point to the potential use of bounce buffers
>>>> when we hit the condition. When swiotlb is used,
>>>> dma_addressing_limited() is used to determine the size of maximum dma
>>>> buffer size in dma_direct_max_mapping_size(). The warning could be
>>>> triggered in that check as well.
>>> dma_addressing_limited is a perfectly expected condition, and returns
>>> true for many devices and still plenty system configuation.  A kernel
>>> warning with a stacktrace is not acceptable for that.  A simple one-line
>>> dev_info might be ok, but could still be rather spammy on many systems.
>>>
>> Thanks for the review!
>>
>> I'll convert it to a dev_info(). We can remove it, if it causes confusion
>> or users complain about it?
> I would even say that this should be only debugging level.
>
> As Christoph explained it is perfectly normal for device to not be able to address everything in the system. So even an info print sounds like to much.
>
> But I totally agree that it is interesting for debugging, that issue was really hard to nail down.

Right, please use dev_debug().

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


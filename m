Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7960926981A
	for <iommu@lists.linux.dev>; Wed,  9 Apr 2025 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210643; cv=none; b=KHa1q9n+Js6SeBJXgr0Tmvspo5l4OZO55jGUVwrz1pufkEp5N2gIMGuD/pD1Z4WSF/bJLi/RTO2ij0CzbbZ8XGrKFT027FKA+4pCnD5JgsFAPFXhuh4f43Ok5yXIQagnKYigHjxa8J0GquZsPW3Qu4Fq+LNcsYcJL67eY6Xu6J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210643; c=relaxed/simple;
	bh=pjfSeuLPVBAQn+LkAC6CaVgrqz5G7ixyn15ncvGjkKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=HBs97eknVjXgxRO0+0SHiPPjjvNS/fK1tnI6Wm6L3unmKFEaqu6ydzrZQ6NOTO+aBfUEQMRIFGj6EE+vrfIBa7dfTuNxRUCfDhR60kJUK9OS4yQnejiR8jntMQBuYA84EeBf3fsUBTrzU5VvZqWvnzp0CBaXw4HCPHoP2IFjcIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iIztZUFK; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iIztZUFK"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250409145719euoutp01941a5e5ced4e8585759b01d45ddab692~0rlXpRAiE1483814838euoutp01P
	for <iommu@lists.linux.dev>; Wed,  9 Apr 2025 14:57:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250409145719euoutp01941a5e5ced4e8585759b01d45ddab692~0rlXpRAiE1483814838euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744210639;
	bh=Yha5fxmt9Z3U4yCtDlYZ8avZRDhv2VDiruB2EG1+TZo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=iIztZUFKDZY4QVCO6zSth9zPgsvMMSmx0qMIOB07XqNFSkJpTmDQYHYw1DPYbLiBq
	 NT1T2iLVfeWJ+moY6abMDkxsoAcHn1jx4Ev2Y3C1RHqd+HpgxisMsnSFvG6ph5A255
	 prHJlXj5ieM9T34kcwBY4jTLdR+3EY2RaaY7/g7Q=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250409145719eucas1p2ad84f6af2002edc79e7d6e10b75beb64~0rlXWHIuh2592425924eucas1p2n;
	Wed,  9 Apr 2025 14:57:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id E3.9F.20397.FCA86F76; Wed,  9
	Apr 2025 15:57:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250409145718eucas1p16597d26ed3fbea97307fc964cd9e5268~0rlWtsRXb1538315383eucas1p1H;
	Wed,  9 Apr 2025 14:57:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250409145718eusmtrp16e8c5c3b447b4f6489bed767ac91d1c8~0rlWtJyQ61977719777eusmtrp19;
	Wed,  9 Apr 2025 14:57:18 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-9b-67f68acf2849
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 3F.43.19654.ECA86F76; Wed,  9
	Apr 2025 15:57:18 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250409145717eusmtip2ee05530ac9517db0b5cea501963c38ec~0rlV-duWP0701107011eusmtip2U;
	Wed,  9 Apr 2025 14:57:17 +0000 (GMT)
Message-ID: <cfe88721-e5fa-423f-aec9-92bc9b7bb92e@samsung.com>
Date: Wed, 9 Apr 2025 16:57:16 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] [RESEND 3] dma/contiguous: avoid warning about
 unused size_bytes
To: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Michal Nazarewicz <mina86@mina86.com>,
	Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <3f3ed85e-187b-4b06-812b-fe34e23511d9@app.fastmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djPc7rnu76lGyzrFrbobZrOZPF30jF2
	i21bNrFa/PpiYbH39VZ2i7NNb9gtLu+aw2ax4HgLq8XBD09YHTg91sxbw+jx+9ckRo9NqzrZ
	PO5c28PmMe9koMeLzTMZPdb9ecXk0bdlFaPH501yAZxRXDYpqTmZZalF+nYJXBmn9yxkL+jk
	rJjyaw5LA+N69i5GTg4JAROJiecOAdlcHEICKxglLi3azQrhfAFyls+Bcj4zSqz9Ox2uZfXH
	r8wQieWMEr2f30M5HxklTl2fxAhSxStgJ/H/9j82EJtFQEViTvc8Zoi4oMTJmU9YQGxRAXmJ
	+7dmgE0VFoiV+PLjF5gtIhAhMXv6D7DVzALdTBJtN9rAhjILiEvcejKfCcRmEzCU6HrbBbaA
	U8BF4sSH/2wQNfIS29/OAbtIQqCZU+LE2vNMEHe7SJz80MIKYQtLvDq+BeofGYnTk3tYIBra
	GSUW/L7PBOFMYJRoeH6LEaLKWuLOuV9AKziAVmhKrN+lDxF2lFjddocZJCwhwCdx460gxBF8
	EpO2TYcK80p0tAlBVKtJzDq+Dm7twQuXmCcwKs1CCpdZSN6cheSdWQh7FzCyrGIUTy0tzk1P
	LTbOSy3XK07MLS7NS9dLzs/dxAhMYKf/Hf+6g3HFq496hxiZOBgPMUpwMCuJ8E7I+5YuxJuS
	WFmVWpQfX1Sak1p8iFGag0VJnHfR/tZ0IYH0xJLU7NTUgtQimCwTB6dUA1Px5JMRL6O3f/h1
	OqDLTPtR6fPuYx1z06PTbQxMO/PunmSWr2Pryrdu+en483qCl53jrh0NOzzd5l7/2n16XeuL
	sicqfbu5uCJFtyvOm2j4nOX4lcvFisG2P961idt9kg5y2LXlTfSSbzf1JfYHMR3NZb+VfPr9
	e9fHgamHreXm6HYemOjo6q9t2SR7Jox74Y0NYjKvPykcnWv+1q2RdcHDSzUTkz13LtZrrD3z
	zjTwdMDpd8KmKYF21ataj+wzUzb+8nvq5TVOnl4t3SKbpX9NEjyndN5j/6qqYPlcX1dp9uPG
	PR1zuwsbY5qOPN1Xu+6QR+WduvvHZK8VewUvXPTUd931/AXJpzlUmcPa7iixFGckGmoxFxUn
	AgCr+6VjzwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7rnur6lG8z9qmbR2zSdyeLvpGPs
	Ftu2bGK1+PXFwmLv663sFmeb3rBbXN41h81iwfEWVouDH56wOnB6rJm3htHj969JjB6bVnWy
	edy5tofNY97JQI8Xm2cyeqz784rJo2/LKkaPz5vkAjij9GyK8ktLUhUy8otLbJWiDS2M9Awt
	LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJO71nIXtDJWTHl1xyWBsb17F2MnBwSAiYS
	qz9+Ze5i5OIQEljKKPHx5E9miISMxMlpDawQtrDEn2tdbBBF7xklbl6YAFbEK2An8f/2PzYQ
	m0VARWJO9zyouKDEyZlPWEBsUQF5ifu3ZoBtExaIlfjy4xeYLSIQITG37RfYZmaBXiaJzR+b
	2CE2nGOSaDzVD9bNLCAucevJfCYQm03AUKLrbRfYNk4BF4kTH/6zQdSYSXRt7WKEsOUltr+d
	wzyBUWgWkkNmIRk1C0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG7LZjP7fs
	YFz56qPeIUYmDsZDjBIczEoivBPyvqUL8aYkVlalFuXHF5XmpBYfYjQFhsZEZinR5Hxgysgr
	iTc0MzA1NDGzNDC1NDNWEudlu3I+TUggPbEkNTs1tSC1CKaPiYNTqoFp0UnnYAm3aVL6yyZU
	hxw2Crj97Xx2S6hhj412iIKwVeHTKXYFrzq0ZzySWsjQoqCz8uULvfglEzcV9aRarExwSiu9
	8+KK2pE0l7o7dY6y/RzzD+7SYOljNn07I9BHt3aLvMsuv73/rASrNDwUPzsey5XkuJri+8P2
	FuuXC2I3Ov7d0hKR15jRfTbIb3LMy9aF7t4zDcNORRUG5H1f/YNrp6+ZZprIYvkqw43FnbKf
	3A/KV4Tbdd4XmzY/x2jnK7Ofe4y8rt0QXTzTquPdTvV1lzVLejvcYnS353MvKteYN+fqkV1X
	VXdvXvj6qUlw/NdXoblxjqfkG1PZkuR1z+3iYLnCfFdVP+xIV8tDViWW4oxEQy3mouJEAHdV
	WLRhAwAA
X-CMS-MailID: 20250409145718eucas1p16597d26ed3fbea97307fc964cd9e5268
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250409122452eucas1p2fd6f06f30de0c6b37b510a10081b724a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250409122452eucas1p2fd6f06f30de0c6b37b510a10081b724a
References: <20250409122131.2766719-1-arnd@kernel.org>
	<CGME20250409122452eucas1p2fd6f06f30de0c6b37b510a10081b724a@eucas1p2.samsung.com>
	<20250409122441.2875424-1-arnd@kernel.org>
	<59af67fa-ca0d-48f6-8b78-b1c694af9dfd@samsung.com>
	<Z_aHdH7Ei_cffeIL@smile.fi.intel.com>
	<3f3ed85e-187b-4b06-812b-fe34e23511d9@app.fastmail.com>

On 09.04.2025 16:51, Arnd Bergmann wrote:
> On Wed, Apr 9, 2025, at 16:43, Andy Shevchenko wrote:
>> On Wed, Apr 09, 2025 at 04:35:57PM +0200, Marek Szyprowski wrote:
>>> On 09.04.2025 14:24, Arnd Bergmann wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> When building with W=1, this variable is unused for configs with
>>>> CONFIG_CMA_SIZE_SEL_PERCENTAGE=y:
>>>>
>>>> kernel/dma/contiguous.c:67:26: error: 'size_bytes' defined but not used [-Werror=unused-const-variable=]
>>>>
>>>> Change this to a macro to avoid the warning.
>>>>
>>>> -static const phys_addr_t size_bytes __initconst =
>>>> -	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
>>>> +#define size_bytes (CMA_SIZE_MBYTES * SZ_1M)
>> This had phys_addr_t type before, do we still have the platforms when it can be
>> bigger than 32-bit integer?
> It can certainly be larger on 64-bit systems, I think I messed it
> up. Marek, can you fix this to put back the cast, or should I
> send a patch on top?

I will drop this one then as I didn't push my branch yet and apply v2, 
which seems to be fine.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


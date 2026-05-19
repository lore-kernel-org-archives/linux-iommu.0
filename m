Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4117435201A
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193304; cv=none; b=I+PhBFnzosjSRkjefEj/hY4HxGGNBfNw3fxLGTaRTjcdSkHyl6L9qbInrTmQchBuLYlLrw5jr+pyU+mfWPu8BqsJBP/DXGVbhoIsFi+KsH9nxBXSFuDqIR/zhP22gE7FLN8ALgORW5gDjVzgYj4svGhx3gGGN/5GgVPfaUQ539M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193304; c=relaxed/simple;
	bh=yEq+2AUx1iOyJ+ggeki2srnGk+8QDGUdyumUhEhu2W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqKBl1v+VEO9HMSHuDirF4KfnVsyBvSyhLP4rTSJ0zYdbC4IG3NlMB2kP0GC2SylSY4MA1ffFlD2/hAPiaJfJa87q9et5QjKpdB03zhyvCdgXbqWFnAb4C85bhM3FDQc8R7pJjtXz9i+6nULklk5fm+d+DHUgrfOxV9b3PSoCp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VZJ846qK; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VZJ846qK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Pkn43UvNGw6BE5zjZWg8ESNySvNLqNay7t6miFcYPts=;
	b=VZJ846qKlOsYHg/yLUb/3dNMvHg/l6AMwX3W5afN0zcb6T+X8AzIT8Uzux4xuA
	t4M/R5ZfEDpEhmaaYS/QmOz4GZGMbGcQFcD96QI1EEQRRlOWQKJ4uru0xHpoYEde
	MUxt/Cx8o9V9zZvTeqhqTQievT6yp52uUdEcnmbtVo/t4=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDHJy+cVQxqHS7ODw--.243S2;
	Tue, 19 May 2026 20:20:47 +0800 (CST)
Message-ID: <941b93d9-2251-4222-8914-73bb7d4e6ac7@163.com>
Date: Tue, 19 May 2026 20:20:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iommu/arm-smmu: Use FIELD_MODIFY() for bitfield
 operations
To: Will Deacon <will@kernel.org>
Cc: robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260430164545.49637-1-18255117159@163.com>
 <agxAvl02rcPoEHaq@willie-the-truck>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <agxAvl02rcPoEHaq@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PigvCgDHJy+cVQxqHS7ODw--.243S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr4UKF1xZr15GF43ZFykAFb_yoWkKFg_Xr
	18Ja1kXr15JFyakr4fCF1fZrnxt39rJFy2v390qay7JasxZFW5JFZ3CF95C3W7Wws2kFy7
	KFZ8ZwsYqFy29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRUGYtUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wAbvmoMVaBgwwAA3+



On 5/19/26 18:51, Will Deacon wrote:
> On Fri, May 01, 2026 at 12:45:43AM +0800, Hans Zhang wrote:
>> Replace open-coded bitfield modifications with the standard FIELD_MODIFY()
>> macro. This improves code readability and adds type/range checking without
>> functional changes.
> 
> Does it _really_ improve the readability? '&=' and '|=' patterns are
> pretty idiomatic C code, if you ask me.
> 
>> FIELD_MODIFY() internally performs the same mask-clear + set operation but
>> eliminates repetitive boilerplate.
>>
>> ---
>> Hi, If the Maintainers think it's not necessary, please ignore it.
> 
> I don't really mind the code either way, so I think I'd prefer to leave
> it as-is unless somebody wants to convince me otherwise...
> 
> Will

Hi Will,

It's not like that. Please take a look at the accepted patch below.



https://lore.kernel.org/linux-pci/20260505165436.GA737933@bhelgaas/

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=42ec65b46a4fc7565d48daa42bf025fdc67800eb

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=5fd6f2154734f447e83b6de9a08d16848605191e


Best regards,
Hans



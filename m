Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CFE1CAA0
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136473; cv=none; b=jCbyEz6wcW6wN22wJJkg7iW7fIw7l+14wEDWqqG3KFqdi/pX+J5ZZ9j3xDy/lSTGSus3YRmQrFvDVw9RHSjh5t2GNU6AIYPfioLA0MwCsoIdAXTl0dn+qf/KV7poJXbNaY4OHSduFu/cfOIbN8t+iOrwbQLUs1u6+ZJQvVajhgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136473; c=relaxed/simple;
	bh=kceg1RKuaGLopnR5e28ESsP0l2T+8rKChglAS/2r7yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxOeHw8W2sR9fjpU5VlocD89mhk9ajWOqkBCrV1WXGvrFUXrJiQYTQd0RwauWPjSHP+0tE3MUxdldCap0takZcEAQNx6/x0u7EXqOwDPdJFVEZTIDJDEBsok9hTrHUNGXmoev0oOlgiRrZEgb/xvFyUZUp2wAyPILjQwTczuydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC8431FB;
	Mon,  5 Feb 2024 04:35:13 -0800 (PST)
Received: from [10.57.48.140] (unknown [10.57.48.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61F623F762;
	Mon,  5 Feb 2024 04:34:30 -0800 (PST)
Message-ID: <51315925-21ac-427c-abea-4d652ed5280f@arm.com>
Date: Mon, 5 Feb 2024 12:34:28 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu/ipmmu-vmsa: Use devm_platform_get_and_ioremap_resource() in
 ipmmu_probe()
Content-Language: en-GB
To: Markus Elfring <Markus.Elfring@web.de>, iommu@lists.linux.dev,
 kernel-janitors@vger.kernel.org, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <e01cdb99-8497-4fec-b423-a0bfb483ac75@web.de>
 <324d4e02-6a5a-4112-a3a7-d7aeb5876acc@arm.com>
 <49fc6a59-2c07-4366-b32f-0599c2418916@web.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <49fc6a59-2c07-4366-b32f-0599c2418916@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-05 11:52 am, Markus Elfring wrote:
>>> Thus reuse existing functionality instead of keeping duplicate source code.
>>
>> Much as I detest the get_and_ioremap_resource obfuscator, it's not even appropriate here since nothing else is using "res".
> 
> I got the impression that this local variable is needed to perform
> a desired function call.

Yes, the call to devm_ioremap_resource(). Which you're proposing to 
remove...

Thanks,
Robin.

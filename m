Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95FF230264
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 07:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384821; cv=none; b=h0nxdQL+Rpm0qMAfgsWsGhztfvgVZYtB8f1tmTk1tdXSyqtz1noN17SiNmjWTGedEeLAkD6i3mGLUgpBsVbjrThIwH/nO09DoAPe6qhzJAqAxohMD3olDIFfhDhfu6HN4obi8ojN8CYD2jx7gkT9pE15SAWR3yA/tVKHA+B5HXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384821; c=relaxed/simple;
	bh=DTz0l1CPlwcOmC/EdhTZxlKDYVw0V8nOZLapoPDyw48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXQHAacYpxVAZRPpaZB7psyn6eF9TrQL2bcniV6Hn3mJL30cTFcBc1DMMUYE//EEI14tyIWgwYrMdGQbj6VySZZr9KbFLljl5PGaW6L+A5j4Lg0/2fyJ72HzZWXDCCkP0h/0Gw/Gd748lTsqj9rOPvwzUzA/qiLioukCLK/uiiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GEQ/LdJ1; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GEQ/LdJ1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780384816; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ty7WBMdgyvAcjMvYBg1GQGZHoG5B7wiV2KVXBalzJ9Y=;
	b=GEQ/LdJ1jcjOTc1QI3XpjCiK+3FBA4AJjXb6kHP6NdmFI5xVmYHqBEfy4I4I7/k1Y63wgowc7Q2xGUYg0nqfqVTWBtOCTmbvURdXkM1GxLDWW1bW0XeoujzjtuO8DtP0dlVZJUOU9Xkhga8u59GM0I/HSSVE0UaVcdnnfO1Tz9c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X43U1av_1780384805;
Received: from 30.221.133.117(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X43U1av_1780384805 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 15:20:14 +0800
Message-ID: <605cbc0f-dcfb-4edd-8756-1c376c9bb6ef@linux.alibaba.com>
Date: Tue, 2 Jun 2026 15:20:05 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] iommu/generic_pt: implement iova_to_phys_length
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 alex@shazbot.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
 baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 dwmw2@infradead.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
 wei.guo.simon@linux.alibaba.com,
 alikernel-developer <alikernel-developer@linux.alibaba.com>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>
 <20260531235421.GW2487554@ziepe.ca>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20260531235421.GW2487554@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/6/1 7:54, Jason Gunthorpe 写道:
> On Sun, May 31, 2026 at 05:36:31PM +0800, Guanghui Feng wrote:
>> @@ -159,45 +164,51 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
>>   	case PT_ENTRY_TABLE:
>>   		return pt_descend(&pts, arg, descend_fn);
>>   	case PT_ENTRY_OA:
>> -		*res = pt_entry_oa_exact(&pts);
>> +		data->phys = pt_entry_oa_exact(&pts);
>> +		data->length = BIT(pt_entry_oa_lg2sz(&pts));
> BIT is the wrong function, it uses the wrong type. log2_to_int() is
> type'd properly
>
> This also needs to keep walking and accumulating length for
> consecutive PTEs until it reaches a non-contiguity.
>
> The other drivers don't need to have that complexity.
>
> Jason

pt_entry_oa_lg2sz has already considered continuous PTEs.

Does this mean that multiple PTEs need to be traversed additionally for 
consecutive PA address mappings?


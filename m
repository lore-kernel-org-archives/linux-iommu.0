Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA212D29CF
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305826; cv=none; b=Mx/GVcdWUo8Lr7xQMt98W1wd3yhU0P9FabIpP3O3fRvMNFpWjvnReXHKsVMLn84rY1JyST+T8Fyy26Aop3fh9p2UjTzEwsqV9uc7obiVZ4S9fX8i0sNJENFpxq+w7gXy65i8fATgvmnt4HvvblpKJuR5HHvbDJMJbI+Pnn7lYaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305826; c=relaxed/simple;
	bh=xtrFTobGDn5WnG6Mj6cJxzRVVsbN03TVsXGRl0SV3lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ek7rq4Phpeyc97za98jwp8LoAkeSp6RkMcc7eYAAnk9D55LSzC5hQGf18VBCBxv9W62wpVuDp7nV+faSmRMxCWLJSN5w9e8vMZWA51nYTnPYVNReCpWmCE5FuZJDAdmM9K3Uybe3jBuNz+JK39PDvfk0N8StqwkdoJeo98nVWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rWGws0rT; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rWGws0rT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780305821; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ep5nKo6DRclkdaB0Yg7vYnUiOGxV48mwn6/e9YS/4RY=;
	b=rWGws0rTyXK4FtsX90kzbGqooV63l8stf01h2B5IOl4faHEUaFXlO7FCMHjtDVxhxqMrAG08CYhmTIpDd5W70/BYzkBHfHvzQK99tbL299Efa8VqMhbQzwqtxcmfqXuo6kouRTVSYLcO81u4XQuv/4mKaatZunbNP15w4o1LaUI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X3zS2An_1780305818;
Received: from 30.221.133.117(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X3zS2An_1780305818 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 01 Jun 2026 17:23:39 +0800
Message-ID: <87bd39ee-6fd6-451e-9ae6-ca2faad84ce9@linux.alibaba.com>
Date: Mon, 1 Jun 2026 17:23:38 +0800
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

Yes, log2_to_int should be used.

> This also needs to keep walking and accumulating length for
> consecutive PTEs until it reaches a non-contiguity.
>
> The other drivers don't need to have that complexity.

Yes

> Jason

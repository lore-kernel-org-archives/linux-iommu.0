Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C463D3DD507
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969137; cv=none; b=pxmXFAQSq1+Tf7Y4meoov3gWizRQVxWs8qIotBACk5ncNi2rRmKlzfSzWSkeZzLwrhF/KGQPkiz9i7FHf8us2uC9ncEZ/DzaidUxlsa9ryrhwim9vQPbzAuxS+LfCGsKl6EXZ3QSiDdW22oGKuNtsImxUvmHNFO83iq3Zkf0wbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969137; c=relaxed/simple;
	bh=gh4ISTYUiIW9johbiax+l6SZSfz22BWtKn8lmSdmObM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liieU7nfF6n6eJYEC2fN6m8vRIuJYuAOpBSL3iriS0YemD6+3BeldldI2fdq/sNnx+KHPq7qs51dIpkit+m5IdmYALXEG/jQeTyAcoG0kaj/zip3iz34gFSqtaZ8rjJaMMnVWEQ5+ETxWewfSqAS9sDClbpf3I61rafaNEUiuR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fsH2oYL8; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fsH2oYL8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774969122; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tACwgQDWbVk27ylJMF9B6FzO93snfvhwfBmEAutzVHg=;
	b=fsH2oYL8mYbxWYjASqlfMl4l7w1w+/zbZ9Y+YLOPeapW/xDOOeykj6ZTlZJKE7YoYH/f9G0oWdU4iXTjURf1Kzy/b4UOiV7eAOqdc0Eg/VXCYs9BMSsA9+L5M1mWjX80Pc7V5q/xfOOW3/jeJEiNUgzAPwRg8Dqwa/B5WA00CkY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X04hCUe_1774969108;
Received: from 30.221.133.110(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X04hCUe_1774969108 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 31 Mar 2026 22:58:41 +0800
Message-ID: <59a44055-1541-4c98-8768-3ff91ed3a984@linux.alibaba.com>
Date: Tue, 31 Mar 2026 22:58:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix illegal access in IOMMU debugfs
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Vasant Hegde <vasant.hegde@amd.com>
Cc: suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, ming.shu@amd.com
References: <20260319073754.651998-1-guanghuifeng@linux.alibaba.com>
 <yrbucydywdvk5zsvbnmxvz5dtmomw5p5vmnbs7prarffqsmgn5@3twhzcpcyxlv>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <yrbucydywdvk5zsvbnmxvz5dtmomw5p5vmnbs7prarffqsmgn5@3twhzcpcyxlv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I am very willing to participate in the upstream community feature review.

Thanks.


在 2026/3/27 16:29, Jörg Rödel 写道:
> On Thu, Mar 19, 2026 at 03:37:52PM +0800, Guanghui Feng wrote:
>> In AMD IOMMU debugfs,
>> 1. set the device, address, and other information to be accessed
>> 2. After verifying the legitimacy of the device, address, and other
>> information in step 1, access and obtain the information
>>
>> However, before actually accessing the device, invalid device or address
>> information might be set again after the legitimacy verification in step
>> 2, thus triggering an unauthorized access issue.
>>
>> Guanghui Feng (2):
>>    iommu/amd: Fix illegal device-id access in IOMMU debugfs
>>    iommu/amd: Fix illegal cap/mmio access in IOMMU debugfs
>>
>>   drivers/iommu/amd/debugfs.c | 63 ++++++++++++++++++-------------------
>>   1 file changed, 31 insertions(+), 32 deletions(-)
> Applied, thanks.
>
> Vasant, this patch-set fixes pretty serious issues. Can you please further
> review the AMD IOMMU debugfs code to make it more robust and secure?
>
> -Joerg

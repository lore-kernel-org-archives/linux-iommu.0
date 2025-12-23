Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521BE2222D8
	for <iommu@lists.linux.dev>; Tue, 23 Dec 2025 03:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766460349; cv=none; b=A0j0cuAHQvtXR9wn7nTfUEETSgyU5DDKqHW6W4WPx2ELbV6iZDyz9LwIdrd39Hx/MY/hCuo83Eqd3EqpI1GG+zoGo5h8e5bgjaz+TopMgSXbId2+kvUTNuPwuJhKjv1EQ1oasA7amil19xqHnWh/nd1IxtQZUxUcr9IJvrEZBSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766460349; c=relaxed/simple;
	bh=9dCP4FsDLumwpkElFWctBJZTr8vJOcDYeU5fGLnpcbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E8HE/ekudrc1CzHL0DLbwGrkvkHrJkHygXa/2arp4egxlLxyOn05yetIuDQITMCY57uGEWK62gWefImK+wqRxo1gnPxK4SmptKuo8+JQwnnjwQ5zH411g+0Eq9J5suM4CPq1E9JqtMVfM+4FM15gExiDXVpFn8OOvVFMsKCgEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=IVlExJ7n; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="IVlExJ7n"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0PBpKwccTzRMXdiNPApslc9uzlno6KdcbLq8sFtXThw=;
	b=IVlExJ7nEYSWUARq6X3ok4Dw50CDbGSfOfSyLYqAeCXQaWmXNMOET/UmUqQmm27uerej2O/gO
	Pf24X406DQuVbNRz5Bx44bkWufv7pDn8LujBZsfQs3ebPsU4P57J79hRLBsE/wezAcaVEY5zQ89
	XXTjgZH3L/n1R28EpZ1VByg=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4db0gh4mHkz1K98x;
	Tue, 23 Dec 2025 11:22:40 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id C20AD40563;
	Tue, 23 Dec 2025 11:25:44 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Dec 2025 11:25:44 +0800
Message-ID: <6833038b-7338-458f-92f3-67eb6faf1a03@huawei.com>
Date: Tue, 23 Dec 2025 11:25:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dma-mapping: benchmark: modify the framework to
 adapt to more map modes
To: Barry Song <21cnbao@gmail.com>
CC: <jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
	<iommu@lists.linux.dev>, <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20251222153246.2220659-1-xiaqinxin@huawei.com>
 <20251222153246.2220659-2-xiaqinxin@huawei.com>
 <CAGsJ_4y_xTJJRBzvSszg0qOAX7tAahJYzLaKcTPuJg6ctJsyUg@mail.gmail.com>
 <7fd4101c-d778-468f-98be-43cccdb03b1a@huawei.com>
 <CAGsJ_4z-KRNTJsce_6pCOjEDtsiHHOh4C9K9iY1o_3--RMM-=w@mail.gmail.com>
 <294a3819-d850-4d90-8112-da9a21a6acf1@huawei.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <294a3819-d850-4d90-8112-da9a21a6acf1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/12/23 11:13:32, Qinxin Xia <xiaqinxin@huawei.com> wrote:
> 
> 
> On 2025/12/23 10:58:28, Barry Song <21cnbao@gmail.com> wrote:
>> I’ve reviewed it many times. You are:
>>
>> +               if (!mb_ops->prepare_data)
>> +                       mb_ops->prepare_data(mparam);
>>
>> not
>>                 if (mb_ops->prepare_data)
>>                         mb_ops->prepare_data(mparam);
>> Am I crazy?
>>
>> Thanks
>> Barry
> Yes, I've found the mistake...
> 
> So in my just reply, I mentioned the correct modification of the
> "if (mb_ops->prepare_data)" and suggested that if you want to test it
> before the next version, you can modify the patch in this way.
> 
> Sorry for the confusion
> 

if (!mb_ops->prepare_data) is a bug. Thank you for catching it.
I've tested the correct version and it works.

-- 
Thanks,
Qinxin


Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B479B23C511
	for <iommu@lists.linux.dev>; Mon,  4 Aug 2025 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295166; cv=none; b=nNGsKWB9Nd07rqGf158TZgelowKfzCUzmm1ar3/ycWE4zNSWzybNALgG9knM29ItS8hx9BNrs4KafZH/dWl9r/qxizRze9WpyiONb1+v9DdVCwHQIHGaquk31Ha32sBUqqUj7ffhbYBwSjz3LpZ/blu0WOskfdUGQ3WVkQgauU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295166; c=relaxed/simple;
	bh=1FXpLi6vLvB+S2Zn4AuuAuGH5pvGTvR0uSJtW3wz/zY=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VWGJPPuIiHZ1R6gtx3zkRFpGjIHXTH6wWHuFErq44zssW7DdtuNVyqyBaN+lsh6nl5/0vQv8ZaYV1IVv1WKBs2iaGMflqHXGRgAjxsE3CH9Y8/2U/kas+7EWj0KptramhN71Y5MroTfogJUaN6F1WoDA0sCE1Mn26jnuo68MGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bwTgj2Fhhz14MGq;
	Mon,  4 Aug 2025 16:07:45 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9FB4B18007F;
	Mon,  4 Aug 2025 16:12:40 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 16:12:40 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 16:12:39 +0800
CC: <robin.murphy@arm.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<yangyicong@hisilicon.com>
Subject: Re: [PATCH 2/2] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Barry Song <21cnbao@gmail.com>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Qinxin Xia <xiaqinxin@huawei.com>
References: <20250724085600.4101321-1-xiaqinxin@huawei.com>
 <20250724085600.4101321-3-xiaqinxin@huawei.com>
 <CAGsJ_4zVR3R7erGP57vxM8vKBARG8BttA=FsCVFjy4QtswcsQw@mail.gmail.com>
 <c7f7d9b3-2ab3-4ebd-99fb-071733573291@huawei.com>
 <CGME20250724094224eucas1p13a911259338ac1890d4baed8b9998fb0@eucas1p1.samsung.com>
 <CAGsJ_4zSw57DMyRZM24BUdDpbi4+BRfgWUqxSKurCsAVC7Kptw@mail.gmail.com>
 <f8c0cbdc-9c68-46bb-8dad-1d7c80f3f741@samsung.com>
 <CAGsJ_4zs8=n+J4Xtd=Un8+p3c=FCOTji9qMfBsOKcc8sFG0v9A@mail.gmail.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <c5170042-ac38-b0db-ba51-c5fce5363d40@huawei.com>
Date: Mon, 4 Aug 2025 16:12:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAGsJ_4zs8=n+J4Xtd=Un8+p3c=FCOTji9qMfBsOKcc8sFG0v9A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200018.china.huawei.com (7.202.195.108)

Hi Barry,

On 2025/8/4 12:47, Barry Song wrote:
> On Tue, Jul 29, 2025 at 8:32 PM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>>
>> On 24.07.2025 11:42, Barry Song wrote:
>>> On Thu, Jul 24, 2025 at 5:35 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>>> On 2025/7/24 17:07:08, Barry Song <21cnbao@gmail.com> wrote:
>>>>> On Thu, Jul 24, 2025 at 4:56 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>>>>> The padding field in the structure was previously reserved to
>>>>>> maintain a stable interface for potential new fields, ensuring
>>>>>> compatibility with user-space shared data structures.
>>>>>> However,it was accidentally removed by tiantao in a prior commit,
>>>>>> which may lead to incompatibility between user space and the kernel.
>>>>>>
>>>>>> This patch reinstates the padding to restore the original structure
>>>>>> layout and preserve compatibility.
>>>>>>
>>>>>> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header file for map_benchmark definition")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Acked-by: Barry Song <baohua@kernel.org>
>>>>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>>>>> I don’t think these two patches should be part of the same series. This
>>>>> one is a bug fix and should be handled separately—ideally picked up on
>>>>> its own and backported to stable.
>>>>>
>>>>> Also, the subject should not say "Add"—it should be "Restore". I assume
>>>>> Marek can handle it?
>>> ...
>>>> Ok, I will send a new version to fix it.
>>> If Marek can help fix it while picking it up into the dma-mapping tree, you
>>> might not need to send a new version.
>>>
>>> Honestly, I hope this gets merged soon—it feels like it's been
>>> overdue for quite a while.
>>
>> I'm sorry, I wasn't aware that this need to go via dma-mapping tree. I
>> will take it after this merge window.
> 
> Thank you, Marek! I also noticed that Xiang Chen’s email has been invalid
> for quite a while, likely he moved to another company some time ago. It looks
> like Yicong has volunteered to take this on:
> 
> https://lkml.indiana.edu/2408.1/08865.html
> 
> I'm not sure if that's still the case. If it is, would Yicong be able to
> resend the email with my ack?
> 

thanks for reminding. I think currently Qinxin is more suitable to help with this.
she's working on the smmu stuffs and help look after this benchmark tool internally
for some time :)

Maybe she can help along with you (ack the fact that you're always helping to review
the codes) if it's ok with you.

Thanks.


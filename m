Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D025D91C
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841030; cv=none; b=JcdUxw7fdIPLPnMGwiFD/kj/LSNf071RZC69p1BXdlUuPZfvvfEy5xxYxgqLzYyGBBHhUkQy8NY4aA3DH/wQ/497jBirEtKxIhNoV+YswLT/B0hyoVJOE0UBwGuMyqjwBcDF6YHQNHk9eWhMmgmXNMT18LAP1s2FmLWZf1HublE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841030; c=relaxed/simple;
	bh=69YRwo3d+IzmMUrKrXRlkcQmX8B/thsIlgjmIfQrKxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qrzk+dDiTbc/Zn4x2Lli7Cuu/Mm3gckbAMTIWn75PXm12nH0hzlKhBsAX8ZbOE4qHRlwrdLZ8HXTU90llr9Y4hBxEOy3r5Z2c8JLC5xilt0KqWOSHd4m4iVfzSdyT9rKH9i8x2kpFf3At/emVGQAdmVShoO6q7RAUwd+z17lJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YQssxjw4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YQssxjw4"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DFY25t018492;
	Tue, 13 Feb 2024 16:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=cx0t23HoX6H9c9e9WIaTu2hn04NXYBDN/IjTf2lh1OI=;
 b=YQssxjw4MPdWhgf2l8+IF25HUy2E5RuEKzQ9FgOIEBxUHVFSgUsxhmuTlACYtcmNmnue
 qZ5+U4sBzfiHwJBd2PWG9XZyDPQ9Ky/0ou8ATICAcrBooSN/QyxjPJ92MGvJjzKQLPjx
 wQGUQkPxxzpQskCNOEe0OZSntQnwoaIocJqHv7e92e9FdyumPMckXPjToTvyzuwDrIy7
 8EdqZPGE9Vsokl8QneOaVcX0wublQ9PU4TqMb0HSuo0bjOJgy0MiZ8yj1sEjJ+RUiDy9
 6Ipssfe+AtSMfN0nNhwOKrL3lUc4/Hshtgn62PJ6nRWqp/mTiUKVdKDfQ7YbApNLXlZL xA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8b2y9abp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 16:16:55 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41DDt8VB004251;
	Tue, 13 Feb 2024 16:16:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv08k2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 16:16:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DGGcmE23986736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 16:16:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE1DF20043;
	Tue, 13 Feb 2024 16:16:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CAB82004D;
	Tue, 13 Feb 2024 16:16:37 +0000 (GMT)
Received: from [9.43.52.14] (unknown [9.43.52.14])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 16:16:37 +0000 (GMT)
Message-ID: <3b056ec8-8ec5-4a0c-9104-d73d218978a6@linux.ibm.com>
Date: Tue, 13 Feb 2024 21:46:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [revert commit 83b3836bf83f09beea5f592b126cfdd1bc921e48]
 [mainline] [6.8.0-rc3]kernel BUG at
 arch/powerpc/platforms/pseries/iommu.c:100!
To: Jason Gunthorpe <jgg@nvidia.com>,
        Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Cc: iommu@lists.linux.dev, robin.murphy@arm.com, will@kernel.org
References: <20240207163211.GG10476@nvidia.com>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <20240207163211.GG10476@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fgopL3K57Cp-Vj0KNxwFtNSoOSkl_9bs
X-Proofpoint-ORIG-GUID: fgopL3K57Cp-Vj0KNxwFtNSoOSkl_9bs
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_08,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 clxscore=1011 bulkscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130128

On 2/7/24 22:02, Jason Gunthorpe wrote:
> On Wed, Feb 07, 2024 at 09:53:30PM +0530, Venkat Rao Bagalkote wrote:
>>     Greetings!!!
>>
>>     [revert commit 83b3836bf83f09beea5f592b126cfdd1bc921e48] [mainline]
>>     [6.8.0-rc3]kernel BUG at arch/powerpc/platforms/pseries/iommu.c:100!
>>
>>     Reverting below commit id issue is not seen.
>> 83b3836bf83f09beea5f592b126cfdd1bc921e48
>>       iommu: Allow ops->default_domain to work when !CONFIG_IOMMU_DMA
> Well, you'll get probing failures if you revert it, so this seems like
> a false bisection.. Though no doubt it will land on one of the earlier
> iommu patches.

I did bisect the issue. The issue is with the commit

a8ca9fc9134c ("powerpc/iommu: Do not do platform domain attach atctions 
after probe")

>> [ 7843.149112] NIP [c0000000000ff4d4] iommu_reconfig_notifier+0x94/0x200
>> [ 7843.149123] LR [c0000000000ff4cc] iommu_reconfig_notifier+0x8c/0x200
>> [ 7843.149129] Call Trace:
>> [ 7843.149131] [c0000013aed5fae0] [c0000000000ff4cc] iommu_reconfig_notifier+0x8
>> c/0x200 (unreliable)
>> [ 7843.149138] [c0000013aed5fb10] [c0000000001a27b0] notifier_call_chain+0xb8/0x
>> 19c
>> [ 7843.149146] [c0000013aed5fb70] [c0000000001a2a78] blocking_notifier_call_chai
>> n+0x64/0x98
>> [ 7843.149152] [c0000013aed5fbb0] [c000000000c4a898] of_reconfig_notify+0x44/0xd
>> c
>> [ 7843.149160] [c0000013aed5fc20] [c000000000c4add4] of_detach_node+0x78/0xb0
>> [ 7843.149165] [c0000013aed5fc70] [c0000000000f96a8] ofdt_write.part.0+0x86c/0xb
>> b8
>> [ 7843.149171] [c0000013aed5fce0] [c00000000069b4bc] proc_reg_write+0xf4/0x150
>> [ 7843.149178] [c0000013aed5fd10] [c0000000005bfeb4] vfs_write+0xf8/0x488
>> [ 7843.149184] [c0000013aed5fdc0] [c0000000005c0570] ksys_write+0x84/0x140
>> [ 7843.149189] [c0000013aed5fe10] [c000000000033358] system_call_exception+0x138
>> /0x330
>> [ 7843.149196] [c0000013aed5fe50] [c00000000000d05c] system_call_vectored_common
>> +0x15c/0x2ec
> What is all this?
>
> Why is it reaching into the iommu space and messing it up from a
> notifier and then crashing when it is not in the state it expects?
>
> If a DT property is being removed shouldn't that be achieved by
> removing the device first and letting the normal iommu driver release
> flow run?

I see this is initiated from the drmgr tool from powerpc-utils. Its actually

operating on the device tree first.

> I have no idea what this is doing, but it looks sketchy :\
>
> Shivaprasad/Ovidiu can you look at this? It looks like some case with
> hot device removal?

Yes. This is happening with hot unplug case. The issue here is a missing

iommu_group_put() call in spapr_tce_platform_iommu_attach_dev() leading 
to the leak.


I have posted the fix here -

https://lore.kernel.org/all/170784021983.6249.10039296655906636112.stgit@linux.ibm.com/


Thanks,

Shivaprasad


> Thanks,
> Jason

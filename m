Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A975C3CF04A
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774438663; cv=none; b=ST0SiJqAjhTIrkdCdEOW/MOmX5+SghbL3/IzmU4FR1RxF49w6vnRdmaSj/v3Q4zCHjorh6ja6zbOPYNYd6SJusWVh8+8NHO8+iuHWCzmKYdYFVsx5JQtkN1lpdTl2xjUzKwemXE1+kOvYcmqgzdk3NjlHnFJcEppN9hWrq4qrN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774438663; c=relaxed/simple;
	bh=OpHMq2Rwk+cHJUi6ucAWHmWHcc8uQgZLnTLd68+v77E=;
	h=Message-ID:Subject:To:Cc:References:From:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KJjyb9DPrF0uN24LDTyKKUEabVC8vo1/RsLR4Qe6uEIKqArUcB3LEHlSbrOIBZybBJ1dKu5MC2gacAK1ziScuQkPkKqeSHCaAYwXlDQkZ8SOkuiC6SSOEpSP+4+XOZdsZMMKcwoMYWBu3L8hOg+DEO1mtiOymhJqLTyxgIMnoqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=n73F1WCF; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="n73F1WCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1774438653;
	bh=67Gy+VnN3oFuCNR5UFCTTdcpheVUk88Eke4bfP3m3ds=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To;
	b=n73F1WCF49h8GVooxEejrstnALmjhduVS7CsEsd2eJJCZDYwiOx3j9EkocH1vp6MP
	 4dDcmo5HltOrxL0oL75+OV53xi5MJlYekXCMwebbCSf3S8Uz0pBPE920BQcp0KAZz6
	 l5Sq1vxiVDV37ZODgHZVuMS45VnI4NPoHDd62mXI=
Received: from [172.25.24.32] ([175.152.51.41])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 95E30AD5; Wed, 25 Mar 2026 19:37:30 +0800
X-QQ-mid: xmsmtpt1774438650thcxh2kcu
Message-ID: <tencent_EEE4C4F7FAB342FCD386C3DB1F07C12E2205@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAaMbr5V7GqnugeRPyk237F0py3DV2vm0bbBFQ1WEzz4+2QblzYM
	 pE0qEqrQvnLSj6ZfC6dQbCVx3IWbegVEqzs754UvKAYBDLi739zHS8+nNVr1Eupm3xKDa/xH3FsR
	 nCQYVdtwk3QcP1Os+BuWG5QXXzUCZ4gguFLMBbQxY+68ziwx36MSFh/wtndAHxTcHe6LfdIQihIO
	 Wj4XPjbGR48AZPBeXZHMS/LwgMWcKTiuXNe4x1uErmpLcoViUClG9o44hka1Y5WRz28IrCX3vIvV
	 2wCPwAuvaA7/YSENDFWVdK5K+7nbaWR5y9uCHxcnbzq8Jb42lrrL2E7+QlSRk74+8iV3Yinis9kS
	 a2/3EwFI/Saa1Drw9Ob4+JpZcB7b0ym0Z0mlDhpSPQTY8U1JUsDPZP0l8eLJPzMHz/NUwRcEC7OQ
	 9FRfO9VF4G+xY00vEfHeK9pqYgxVZkHv6cujBxbHnrXy5kouNM+aUCPZWtK/bH8rwo/g9B2YMuyi
	 rCx6Bf1umczfnxeYAJtee3pKr6cMjWO3cHECMNi/osWaQgHTRQpAzb/fhm8wIaUpmnMeZylvIZeg
	 ngE7ETL5So+99BWf32AWhvDAcCnNYvnDf+GXpvjQy24448Kur1uueOL8QZ7fAmZ0TY3XtDILT+XW
	 LOcMiQYbvIr+YDv7zQT6NjLnM882ZcVyPALAN47WhYNZP+HLbnTFd5PTxa/PGGCw/lllt3mq8V4T
	 jZyZYunn9jqKoKLo11/CSJtmmjwnSyqPtZpCrqSgclTjDdd57Mor7rjoOgDuBs7jHQm93lWaXlK0
	 h1SsUdGePxD4rN/XxiWNPry18IepQNd/FgLUZ5J7n1VX6adADQkU7/7Qcriu8W0CSIc+/EXeIrTY
	 vQiDt6Hc2N3f7DTR/lClCh3usgTrfzgqxC+Kodlh4yuyh/oiV38rv+BlhzuQKQkUjUECK7SHdCed
	 Y/pMXqYL1rLQUc2ftCnNA72owWpXuy5zXKpAYvK+sjGF6TZ3IXhEW5L4U2qC9BKqepWtIw4/fQs4
	 /DJqogWOOt6XMhycoxAgSWQ0JA4mM4+DfVSlmT6A==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
Subject: Re: [PATCH v1] iommu/amd: Recognize Hygon southbridge IOAPIC for
 interrupt remapping
To: Wei Wang <wei.w.wang@hotmail.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
 vasant.hegde@amd.com, aik@amd.com, jgg@nvidia.com, kevin.tian@intel.com,
 xuyongwei@open-hieco.net
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <SI2PR01MB43930F54C5B058A26D768C5FDC49A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <tencent_EA83212045B49C785F5B55047CD670E8FB0A@qq.com>
 <SI2PR01MB439392D470CAB8EAB472839EDC49A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
From: Pu Wen <pu_wen@foxmail.com>
X-OQ-MSGID: <a5b0a089-46e1-cc01-32f6-34a9cefbc4ef@foxmail.com>
Date: Wed, 25 Mar 2026 19:37:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <SI2PR01MB439392D470CAB8EAB472839EDC49A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2026/3/25 19:23, Wei Wang wrote:
> On 3/25/26 6:54 PM, Pu Wen wrote:
>> On 2026/3/25 17:39, Wei Wang wrote:
>>> Hygon systems use the AMD IOMMU driver but newer Hygon platforms report
>>> the southbridge IOAPIC at a different PCI device (00:0b.0), whereas AMD
>>> systems use device 00:14.0.
>> ......
>>> +/* SB IOAPIC device IDs */
>>> +#define IOAPIC_SB_DEVID_AMD    ((0x00 << 8) | PCI_DEVFN(0x14, 0))
>>> +#define IOAPIC_SB_DEVID_HYGON    ((0x00 << 8) | PCI_DEVFN(0x0b, 0))
>> These macro definitions is not accurate, old Hygon processor also use
>> device 0x14, as you mentioned device 0xb is only for 'newer Hygon 
>> platforms'.
>>
> 
> Yes, I noticed that. I mentioned this in the commit log:
> 
> Older Hygon systems still use the original AMD device ID (00:14.0) while
> newer systems use 00:0b.0, so a strict CPU vendor check is insufficient.
> 
> That is also why the code uses the logical OR:
> if (devid == IOAPIC_SB_DEVID_AMD || devid == IOAPIC_SB_DEVID_HYGON)

IMO, if only newer Hygon processor will use device 0xb, the macro should
use a exact name(eg: with a new Hygon family/model), let IOAPIC_SB_DEVID
as the common macro for AMD and Hygon.

-- 
Regards,
Pu Wen


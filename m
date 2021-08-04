Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44DCC432BE
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 07:04:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5018260EEA
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 07:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5018260EEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 09625401E7;
	Wed,  4 Aug 2021 07:04:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TbRlPMIwZLrk; Wed,  4 Aug 2021 07:04:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8172740198;
	Wed,  4 Aug 2021 07:04:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54A7DC0010;
	Wed,  4 Aug 2021 07:04:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85BEBC000E;
 Wed,  4 Aug 2021 07:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76D78401B3;
 Wed,  4 Aug 2021 07:04:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id az7YND3Ewayo; Wed,  4 Aug 2021 07:04:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E8EA40198;
 Wed,  4 Aug 2021 07:04:01 +0000 (UTC)
Received: from [192.168.1.87] (unknown [223.178.56.171])
 by linux.microsoft.com (Postfix) with ESMTPSA id 2C02F20B36E0;
 Wed,  4 Aug 2021 00:03:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C02F20B36E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1628060640;
 bh=9ZaqFTUSUabTOCq0gU0pkK9jc2pEBX00jmp+GcZOv0g=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=JHIEvDfmp/H7TPFi3UdGVZV5txesuMGg+GjVhE4Jx7Xljpo0hIVLuneKK/qsbLfLm
 zs5+T6qQbrLgMqQSh9cbdsu1Bb5/KjbY6RPzr4A4WlW4CuC9bLlCVUIE1HuFqgG3r0
 Ors/l3/xf672Y0iQsGVu3qb7pyPhE38/p4VW+cOs=
Subject: Re: [RFC v1 6/8] mshv: command line option to skip devices in PV-IOMMU
To: Wei Liu <wei.liu@kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-7-wei.liu@kernel.org>
 <4a6918ea-e3e5-55c9-a12d-bee7261301fd@linux.microsoft.com>
 <20210803215617.fzx2vrzhsabrrolc@liuwe-devbox-debian-v2>
From: Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <8d9b6b9a-62b1-95ea-1bb6-258e72c1800d@linux.microsoft.com>
Date: Wed, 4 Aug 2021 12:33:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803215617.fzx2vrzhsabrrolc@liuwe-devbox-debian-v2>
Content-Language: en-US
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, pasha.tatashin@soleen.com,
 Will Deacon <will@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 04-08-2021 03:26, Wei Liu wrote:
>>>  	struct iommu_domain domain;
>>> @@ -774,6 +784,41 @@ static struct iommu_device *hv_iommu_probe_device(struct device *dev)
>>>  	if (!dev_is_pci(dev))
>>>  		return ERR_PTR(-ENODEV);
>>>  
>>> +	/*
>>> +	 * Skip the PCI device specified in `pci_devs_to_skip`. This is a
>>> +	 * temporary solution until we figure out a way to extract information
>>> +	 * from the hypervisor what devices it is already using.
>>> +	 */
>>> +	if (pci_devs_to_skip && *pci_devs_to_skip) {
>>> +		int pos = 0;
>>> +		int parsed;
>>> +		int segment, bus, slot, func;
>>> +		struct pci_dev *pdev = to_pci_dev(dev);
>>> +
>>> +		do {
>>> +			parsed = 0;
>>> +
>>> +			sscanf(pci_devs_to_skip + pos,
>>> +				" (%x:%x:%x.%x) %n",
>>> +				&segment, &bus, &slot, &func, &parsed);
>>> +
>>> +			if (parsed <= 0)
>>> +				break;
>>> +
>>> +			if (pci_domain_nr(pdev->bus) == segment &&
>>> +				pdev->bus->number == bus &&
>>> +				PCI_SLOT(pdev->devfn) == slot &&
>>> +				PCI_FUNC(pdev->devfn) == func)
>>> +			{
>>> +				dev_info(dev, "skipped by MSHV IOMMU\n");
>>> +				return ERR_PTR(-ENODEV);
>>> +			}
>>> +
>>> +			pos += parsed;
>>> +
>>> +		} while (pci_devs_to_skip[pos]);
>>
>> Is there a possibility of pci_devs_to_skip + pos > sizeof(pci_devs_to_skip)
>> and also a valid memory ?
> 
> pos should point to the last parsed position. If parsing fails pos does
> not get updated and the code breaks out of the loop. If parsing is
> success pos should point to either the start of next element of '\0'
> (end of string). To me this is good enough.

The point is, hypothetically the address to pci_devs_to_skip + pos can be valid address (later to '\0'), and thus there is a possibility, that parsing may not fail.
Another, there is also a possibility of sscanf faulting accessing the illegal address, if pci_devs_to_skip[pos] turns out to be not NULL or valid address.

> 
>> I would recommend to have a check of size as well before accessing the
>> array content, just to be safer accessing any memory.
>>
> 
> What check do you have in mind?

Something like,
size_t len = strlen(pci_devs_to_skip);
do {

	len -= parsed;
} while (len);

OR

do {
...
	pos += parsed;
} while (pos < len);

Further, I'm also fine with the existing code, if you think this won't break and already been taken care. Thanks.

Regards,

~Praveen.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

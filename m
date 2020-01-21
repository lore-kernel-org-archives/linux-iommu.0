Return-Path: <SRS0=p6pp=3K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78639C33CAA
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 10:14:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3149B24653
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 10:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3149B24653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DCBFB84F0F;
	Tue, 21 Jan 2020 10:14:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w5cm6iac+DTT; Tue, 21 Jan 2020 10:14:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 99FC6879A6;
	Tue, 21 Jan 2020 10:14:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82D41C0176;
	Tue, 21 Jan 2020 10:14:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF7C6C0174
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 10:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 956A3204BC
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 10:14:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jsGRsj69SJuj for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jan 2020 10:14:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by silver.osuosl.org (Postfix) with ESMTPS id 458692040E
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 10:14:13 +0000 (UTC)
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 3F14B58FB758E2E8A7C0;
 Tue, 21 Jan 2020 10:14:09 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 21 Jan 2020 10:14:08 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 21 Jan
 2020 10:14:08 +0000
Subject: Re: [RFC PATCH 0/4] iommu: Per-group default domain type
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>
References: <20200101052648.14295-1-baolu.lu@linux.intel.com>
 <ba7a7e6a-8b23-fca0-a8bb-72c4dbfa8390@huawei.com>
 <f417cd0b-1bf7-7da2-3a64-b8b74b03da02@linux.intel.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <0fbcbd62-cf8a-1c3c-c702-f9bf59497867@huawei.com>
Date: Tue, 21 Jan 2020 10:14:07 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <f417cd0b-1bf7-7da2-3a64-b8b74b03da02@linux.intel.com>
Content-Language: en-US
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 21/01/2020 00:43, Lu Baolu wrote:
>>> An IOMMU group represents the smallest set of devices that are 
>>> considered
>>> to be isolated. All devices belonging to an IOMMU group share a default
>>> domain for DMA APIs. There are two types of default domain: 
>>> IOMMU_DOMAIN_DMA
>>> and IOMMU_DOMAIN_IDENTITY. The former means IOMMU translation, while the
>>> latter means IOMMU by-pass.
>>>
>>> Currently, the default domain type for the IOMMU groups is determined
>>> globally. All IOMMU groups use a single default domain type. The global
>>> default domain type can be adjusted by kernel build configuration or
>>> kernel parameters.
>>>
>>> More and more users are looking forward to a fine grained default domain
>>> type. For example, with the global default domain type set to 
>>> translation,
>>> the OEM verndors or end users might want some trusted and fast-speed 
>>> devices
>>> to bypass IOMMU for performance gains. On the other hand, with global
>>> default domain type set to by-pass, some devices with limited system
>>> memory addressing capability might want IOMMU translation to remove the
>>> bounce buffer overhead.
>>
>> Hi Lu Baolu,
>>
>> Do you think that it would be a more common usecase to want 
>> kernel-managed devices to be passthrough for performance reasons and 
>> some select devices to be in DMA domain, like those with limited 
>> address cap or whose drivers request huge amounts of memory?
>>
>> I just think it would be more manageable to set kernel commandline 
>> parameters for this, i.e. those select few which want DMA domain.
>>

Hi Baolu,

> 
> It's just two sides of a coin. Currently, iommu subsystem make DMA
> domain by default, that's the reason why I selected to let user set
> which devices are willing to use identity domains.
> 

OK, understood.

There was an alternate solution here which would allow per-group type to 
be updated via sysfs:

https://lore.kernel.org/linux-iommu/cover.1566353521.git.sai.praneeth.prakhya@intel.com/

Any idea what happened to that?

Cheers,
John

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

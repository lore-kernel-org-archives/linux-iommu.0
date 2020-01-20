Return-Path: <SRS0=4rPt=3J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55500C33CB1
	for <iommu@archiver.kernel.org>; Mon, 20 Jan 2020 09:45:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F15E207E0
	for <iommu@archiver.kernel.org>; Mon, 20 Jan 2020 09:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F15E207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D922685478;
	Mon, 20 Jan 2020 09:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id di-F9_zEst6f; Mon, 20 Jan 2020 09:45:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 69B7D853E5;
	Mon, 20 Jan 2020 09:45:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A502C0176;
	Mon, 20 Jan 2020 09:45:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23FBEC0174
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jan 2020 09:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 208598544C
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jan 2020 09:45:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Rr-8MnjTLBg for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jan 2020 09:44:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D2D0C853E5
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jan 2020 09:44:56 +0000 (UTC)
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 3DA39BD29D6DA30D2A22;
 Mon, 20 Jan 2020 09:44:53 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 20 Jan 2020 09:44:52 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 20 Jan
 2020 09:44:52 +0000
Subject: Re: [RFC PATCH 0/4] iommu: Per-group default domain type
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>
References: <20200101052648.14295-1-baolu.lu@linux.intel.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <ba7a7e6a-8b23-fca0-a8bb-72c4dbfa8390@huawei.com>
Date: Mon, 20 Jan 2020 09:44:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200101052648.14295-1-baolu.lu@linux.intel.com>
Content-Language: en-US
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
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

On 01/01/2020 05:26, Lu Baolu wrote:
> An IOMMU group represents the smallest set of devices that are considered
> to be isolated. All devices belonging to an IOMMU group share a default
> domain for DMA APIs. There are two types of default domain: IOMMU_DOMAIN_DMA
> and IOMMU_DOMAIN_IDENTITY. The former means IOMMU translation, while the
> latter means IOMMU by-pass.
> 
> Currently, the default domain type for the IOMMU groups is determined
> globally. All IOMMU groups use a single default domain type. The global
> default domain type can be adjusted by kernel build configuration or
> kernel parameters.
> 
> More and more users are looking forward to a fine grained default domain
> type. For example, with the global default domain type set to translation,
> the OEM verndors or end users might want some trusted and fast-speed devices
> to bypass IOMMU for performance gains. On the other hand, with global
> default domain type set to by-pass, some devices with limited system
> memory addressing capability might want IOMMU translation to remove the
> bounce buffer overhead.

Hi Lu Baolu,

Do you think that it would be a more common usecase to want 
kernel-managed devices to be passthrough for performance reasons and 
some select devices to be in DMA domain, like those with limited address 
cap or whose drivers request huge amounts of memory?

I just think it would be more manageable to set kernel commandline 
parameters for this, i.e. those select few which want DMA domain.

Thanks,
John

> 
> This series proposes per-group default domain type to meet these demands.
> It adds a per-device iommu_passthrough attribute. By setting this
> attribute, end users or device vendors are able to tell the IOMMU subsystem
> that this device is willing to use a default domain of IOMMU_DOMAIN_IDENTITY.
> The IOMMU device probe procedure is reformed to pre-allocate groups for
> all devices on a specific bus before adding the devices into the groups.
> This enables the IOMMU device probe precedure to determine a per-group
> default domain type before allocating IOMMU domains and attaching them
> to devices.
> 
> Please help to review it. Your comments and suggestions are appricated.
> 
> Best regards,
> baolu
> 
> Lu Baolu (4):
>    driver core: Add iommu_passthrough to struct device
>    PCI: Add "pci=iommu_passthrough=" parameter for iommu passthrough
>    iommu: Preallocate iommu group when probing devices
>    iommu: Determine default domain type before allocating domain
> 
>   .../admin-guide/kernel-parameters.txt         |   5 +
>   drivers/iommu/iommu.c                         | 127 ++++++++++++++----
>   drivers/pci/pci.c                             |  34 +++++
>   drivers/pci/pci.h                             |   1 +
>   drivers/pci/probe.c                           |   2 +
>   include/linux/device.h                        |   3 +
>   6 files changed, 143 insertions(+), 29 deletions(-)
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E1DC433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 03:15:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFD364DDE
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 03:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFD364DDE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7788A2037B;
	Wed,  3 Feb 2021 03:15:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aOqwsMtvXZa9; Wed,  3 Feb 2021 03:15:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6CEEC2041E;
	Wed,  3 Feb 2021 03:15:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 487C9C0174;
	Wed,  3 Feb 2021 03:15:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E645C013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 03:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 543868709D
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 03:15:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PmIGgOZSztUF for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 03:15:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BB4D28701C
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 03:15:34 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DVmxD46Gsz163RX;
 Wed,  3 Feb 2021 11:14:08 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Wed, 3 Feb 2021
 11:15:18 +0800
Subject: Re: [RFC PATCH 0/3] iommu/arm-smmu-v3: Add debug interfaces for SMMUv3
To: Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>
References: <1611911184-116261-1-git-send-email-wangzhou1@hisilicon.com>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5001d8b3-ed2c-f3e3-80c5-d0b6b5df634c@hisilicon.com>
Date: Wed, 3 Feb 2021 11:15:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1611911184-116261-1-git-send-email-wangzhou1@hisilicon.com>
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On 2021/1/29 17:06, Zhou Wang wrote:
> This RFC series is the followed patch of this discussion:
> https://www.spinics.net/lists/arm-kernel/msg866187.html. 
> 
> Currently there is no debug interface about SMMUv3 driver, which makes it
> not convenient when we want to dump some information, like the value of
> CD/STE, S1/S2 page table, SMMU registers or cmd/event/pri queues.
> 
> This series tries to add support of dumping CD/STE and page table. The
> interface design is that user sets device/pasid firstly by sysfs files
> and then read related sysfs file to get information:
> 
>  (currently only support PCI device)
>  echo <domain>:<bus>:<dev>.<fun> > /sys/kernel/debug/iommu/smmuv3/pci_dev
>  echo <pasid> > /sys/kernel/debug/iommu/smmuv3/pasid
>  
>  Then value in CD and STE can be got by:
>  cat /sys/kernel/debug/iommu/smmuv3/ste
>  cat /sys/kernel/debug/iommu/smmuv3/cd
>  
>  S1 and S2 page tables can be got by:
>  cat /sys/kernel/debug/iommu/smmuv3/pt_dump_s1
>  cat /sys/kernel/debug/iommu/smmuv3/pt_dump_s2
> 
> For STE, CD and page table, related device and pasid are set in pci_dev
> and pasid files as above.
> 
> First and second patch export some help functions or macros in arm-smmu-v3
> and io-pgtable-arm codes, so we can reuse them in debugfs.c. As a RFC, this
> series does not go further to dump SMMU registers and cmd/event/pri queues.
> I am not sure this series is in the right way, so let's post it out and have a
> discussion. Looking forward to any feedback.
> 
> Zhou Wang (3):
>   iommu/arm-smmu-v3: Export cd/ste get functions
>   iommu/io-pgtable: Export page table walk needed functions and macros
>   iommu/arm-smmu-v3: Add debug interfaces for SMMUv3
> 
>  drivers/iommu/Kconfig                       |  11 +
>  drivers/iommu/arm/arm-smmu-v3/Makefile      |   1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  10 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  10 +
>  drivers/iommu/arm/arm-smmu-v3/debugfs.c     | 398 ++++++++++++++++++++++++++++
>  drivers/iommu/io-pgtable-arm.c              |  47 +---
>  drivers/iommu/io-pgtable-arm.h              |  43 +++
>  7 files changed, 475 insertions(+), 45 deletions(-)
>  create mode 100644 drivers/iommu/arm/arm-smmu-v3/debugfs.c
> 

Any comments about this series?

Best,
Zhou

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

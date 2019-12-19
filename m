Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68093C43603
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:12:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DCE220716
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCE220716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 29C5586F17;
	Thu, 19 Dec 2019 12:12:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xbrci2fvWHyE; Thu, 19 Dec 2019 12:12:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9393D86D4C;
	Thu, 19 Dec 2019 12:12:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8078BC1D81;
	Thu, 19 Dec 2019 12:12:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AC71C077D
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8A3F685456
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:12:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wiKrTEhuXGmc for <iommu@lists.linuxfoundation.org>;
 Thu, 19 Dec 2019 12:12:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3CD0F8329B
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:12:37 +0000 (UTC)
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 709D27273C57EE7CE5D8;
 Thu, 19 Dec 2019 12:12:33 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 19 Dec 2019 12:12:33 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Dec
 2019 12:12:32 +0000
Subject: Re: [PATCH v4 00/16] iommu: Permit modular builds of ARM SMMU[v3]
 drivers
To: Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
 <iommu@lists.linuxfoundation.org>
References: <20191219120352.382-1-will@kernel.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <40ccd748-26bc-df16-76f8-b5ebf11ee520@huawei.com>
Date: Thu, 19 Dec 2019 12:12:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191219120352.382-1-will@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Bjorn
 Helgaas <bhelgaas@google.com>, kernel-team@android.com, Ard
 Biesheuvel <ardb@kernel.org>
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

On 19/12/2019 12:03, Will Deacon wrote:
> Hi all,
> 
> This is version four of the patches I previously posted here:
> 
>    v1: https://lore.kernel.org/lkml/20191030145112.19738-1-will@kernel.org/
>    v2: https://lore.kernel.org/lkml/20191108151608.20932-1-will@kernel.org
>    v3: https://lore.kernel.org/lkml/20191121114918.2293-1-will@kernel.org
> 
> Changes since v3 include:
> 
>    * Based on v5.5-rc1
>    * ACPI/IORT support (thanks to Ard)
>    * Export pci_{enable,disable}_ats() (thanks to Greg)
>    * Added review tags

Since it looks like not much has changed since v3, and I even tested 
removal of smmu-v3.ko [0] - this should be ok for the series:

Tested-by: John Garry <john.garry@huawei.com> # smmu v3

[0] 
https://lore.kernel.org/linux-iommu/c8eb97b1-dab5-cc25-7669-2819f64a885d@huawei.com/

> 
> I tested this on AMD Seattle by loading arm-smmu-mod.ko from the initrd.
> 
> Cheers,
> 
> Will
> 
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Jordan Crouse <jcrouse@codeaurora.org>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> 
> --->8
> 
> Ard Biesheuvel (1):
>    iommu/arm-smmu: Support SMMU module probing from the IORT
> 
> Greg Kroah-Hartman (1):
>    PCI/ATS: Restore EXPORT_SYMBOL_GPL() for pci_{enable,disable}_ats()
> 
> Will Deacon (14):
>    drivers/iommu: Export core IOMMU API symbols to permit modular drivers
>    iommu/of: Request ACS from the PCI core when configuring IOMMU linkage
>    PCI: Export pci_ats_disabled() as a GPL symbol to modules
>    drivers/iommu: Take a ref to the IOMMU driver prior to ->add_device()
>    iommu/of: Take a ref to the IOMMU driver during ->of_xlate()
>    drivers/iommu: Allow IOMMU bus ops to be unregistered
>    Revert "iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular"
>    Revert "iommu/arm-smmu: Make arm-smmu explicitly non-modular"
>    iommu/arm-smmu: Prevent forced unbinding of Arm SMMU drivers
>    iommu/arm-smmu-v3: Unregister IOMMU and bus ops on device removal
>    iommu/arm-smmu-v3: Allow building as a module
>    iommu/arm-smmu: Unregister IOMMU and bus ops on device removal
>    iommu/arm-smmu: Allow building as a module
>    iommu/arm-smmu: Update my email address in MODULE_AUTHOR()
> 
>   drivers/acpi/arm64/iort.c   |   4 +-
>   drivers/iommu/Kconfig       |  16 ++++-
>   drivers/iommu/Makefile      |   3 +-
>   drivers/iommu/arm-smmu-v3.c |  94 +++++++++++++++++---------
>   drivers/iommu/arm-smmu.c    | 128 +++++++++++++++++++++++++-----------
>   drivers/iommu/iommu-sysfs.c |   5 ++
>   drivers/iommu/iommu.c       |  32 ++++++++-
>   drivers/iommu/of_iommu.c    |  19 ++++--
>   drivers/pci/ats.c           |   2 +
>   drivers/pci/pci.c           |   1 +
>   include/linux/iommu.h       |   4 +-
>   11 files changed, 223 insertions(+), 85 deletions(-)
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768C8C433DB
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 17:04:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CE164E00
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 17:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CE164E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 096D62E131;
	Fri, 29 Jan 2021 17:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ci30FeVfAap4; Fri, 29 Jan 2021 17:04:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1D8412046C;
	Fri, 29 Jan 2021 17:04:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09B09C0FA7;
	Fri, 29 Jan 2021 17:04:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACAEEC013A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 17:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 94BB485FA6
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 17:04:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lp9pgsx2zmFy for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 17:04:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D0F2085E25
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 17:04:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF3D013A1;
 Fri, 29 Jan 2021 09:04:02 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63C843F71B;
 Fri, 29 Jan 2021 09:04:01 -0800 (PST)
Subject: Re: [PATCH v3 2/3] perf/smmuv3: Add a MODULE_SOFTDEP() to indicate
 dependency on SMMU
To: John Garry <john.garry@huawei.com>, Zhen Lei
 <thunder.leizhen@huawei.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
 <20210127113258.1421-3-thunder.leizhen@huawei.com>
 <67e0859b-2633-3516-527f-57557e210fa1@arm.com>
 <4b116f38-84da-9ef9-350c-8900944b0433@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a5595eae-0de9-e454-8a3d-5718512422ee@arm.com>
Date: Fri, 29 Jan 2021 17:03:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <4b116f38-84da-9ef9-350c-8900944b0433@huawei.com>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
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

On 2021-01-29 15:34, John Garry wrote:
> On 29/01/2021 15:12, Robin Murphy wrote:
>> On 2021-01-27 11:32, Zhen Lei wrote:
>>> The MODULE_SOFTDEP() gives user space a hint of the loading sequence. 
>>> And
>>> when command "modprobe arm_smmuv3_pmu" is executed, the 
>>> arm_smmu_v3.ko is
>>> automatically loaded in advance.
>>
>> Why do we need this? If probe order doesn't matter when both drivers 
>> are built-in, why should module load order?
>>
>> TBH I'm not sure why we even have a Kconfig dependency on ARM_SMMU_V3, 
>> given that the drivers operate completely independently :/
> 
> Can that Kconfig dependency just be removed? I think that it was added 
> under the idea that there is no point in having the SMMUv3 PMU driver 
> without the SMMUv3 driver.

A PMCG *might* be usable for simply counting transactions to measure 
device activity regardless of its associated SMMU being enabled. Either 
way, it's not really Kconfig's job to decide what makes sense (beyond 
the top-level "can this driver *ever* be used on this platform" 
visibility choices). Imagine if we gave every PCI/USB/etc. device driver 
an explicit dependency on at least one host controller driver being 
enabled...

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

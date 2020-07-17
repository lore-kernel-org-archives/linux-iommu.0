Return-Path: <SRS0=Ppoz=A4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDC4C433E3
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 11:58:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416212065D
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 11:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416212065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 15D02860E0;
	Fri, 17 Jul 2020 11:58:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ldimAI3xAk9y; Fri, 17 Jul 2020 11:58:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 63F5085F7B;
	Fri, 17 Jul 2020 11:58:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42A21C07FF;
	Fri, 17 Jul 2020 11:58:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A411C0733
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 11:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 72ED087DA2
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 11:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FbPEjkkfCpvO for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jul 2020 11:58:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 087A987D60
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 11:58:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32E7730E;
 Fri, 17 Jul 2020 04:58:10 -0700 (PDT)
Received: from [10.57.35.46] (unknown [10.57.35.46])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55CBD3F66E;
 Fri, 17 Jul 2020 04:58:07 -0700 (PDT)
Subject: Re: [PATCH v10 5/5] iommu/arm-smmu: Add global/context fault
 implementation hooks
To: Will Deacon <will@kernel.org>, Krishna Reddy <vdumpa@nvidia.com>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-6-vdumpa@nvidia.com>
 <20200713134450.GC2739@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <616235dc-c290-d5c4-47c2-19402213dc11@arm.com>
Date: Fri, 17 Jul 2020 12:58:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713134450.GC2739@willie-the-truck>
Content-Language: en-GB
Cc: jonathanh@nvidia.com, devicetree@vger.kernel.org, treding@nvidia.com,
 bhuntsman@nvidia.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, praithatha@nvidia.com, talho@nvidia.com,
 snikam@nvidia.com, robh+dt@kernel.org, nicolinc@nvidia.com,
 linux-tegra@vger.kernel.org, yhsu@nvidia.com, mperttunen@nvidia.com,
 linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
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

On 2020-07-13 14:44, Will Deacon wrote:
> On Tue, Jul 07, 2020 at 10:00:17PM -0700, Krishna Reddy wrote:
>> Add global/context fault hooks to allow vendor specific implementations
>> override default fault interrupt handlers.
>>
>> Update NVIDIA implementation to override the default global/context fault
>> interrupt handlers and handle interrupts across the two ARM MMU-500s that
>> are programmed identically.
>>
>> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
>> ---
>>   drivers/iommu/arm-smmu-nvidia.c | 99 +++++++++++++++++++++++++++++++++
>>   drivers/iommu/arm-smmu.c        | 17 +++++-
>>   drivers/iommu/arm-smmu.h        |  3 +
>>   3 files changed, 117 insertions(+), 2 deletions(-)
> 
> Given that faults shouldn't occur during normal operation, is this patch
> actually necessary?

Indeed they shouldn't, but if something *does* happen to go wrong then I 
think it's worth having proper handling in place, since the consequences 
otherwise include a screaming "spurious" fault or just silently losing 
some transactions and possibly locking up part of the system altogether 
(depending on HUPCF at least - I recall MMU-500 also behaving funnily 
WRT TLB maintenance while an IRQ is outstanding, but that was long 
enough ago that it might have been related to the old CFCFG behaviour).

Until we sort out the reserved memory regions thing (the new IORT spec 
is due Real Soon Now(TM)...) some systems are going to keep suffering 
transient context faults during boot - those may make the display 
unhappy until it gets reset, but we certainly don't want to invite the 
possibility of them wedging the SMMU itself.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

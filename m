Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0858C433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 12:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A75B0404C7;
	Fri, 29 Apr 2022 12:26:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jOv4ikLYygT7; Fri, 29 Apr 2022 12:26:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 419E840104;
	Fri, 29 Apr 2022 12:26:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16C15C0039;
	Fri, 29 Apr 2022 12:26:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F289C002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 12:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E1C760BF0
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 12:26:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qpe3hJ5hf4ao for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 12:26:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79C6B60ACF
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 12:26:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CB3A1063;
 Fri, 29 Apr 2022 05:26:49 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CD6E3F73B;
 Fri, 29 Apr 2022 05:26:45 -0700 (PDT)
Message-ID: <27dc8d16-5e10-ae13-d91f-bc7826d34af1@arm.com>
Date: Fri, 29 Apr 2022 13:26:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC 13/19] iommu/arm-smmu-v3: Add feature detection for
 BBML
Content-Language: en-GB
To: Joao Martins <joao.m.martins@oracle.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-14-joao.m.martins@oracle.com>
 <8e897628-61fa-b3fb-b609-44eeda11b45e@arm.com>
 <fdb44064-c4ab-9bd1-f984-e3772b539c13@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <fdb44064-c4ab-9bd1-f984-e3772b539c13@oracle.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On 2022-04-29 12:54, Joao Martins wrote:
> On 4/29/22 12:11, Robin Murphy wrote:
>> On 2022-04-28 22:09, Joao Martins wrote:
>>> From: Kunkun Jiang <jiangkunkun@huawei.com>
>>>
>>> This detects BBML feature and if SMMU supports it, transfer BBMLx
>>> quirk to io-pgtable.
>>>
>>> BBML1 requires still marking PTE nT prior to performing a
>>> translation table update, while BBML2 requires neither break-before-make
>>> nor PTE nT bit being set. For dirty tracking it needs to clear
>>> the dirty bit so checking BBML2 tells us the prerequisite. See SMMUv3.2
>>> manual, section "3.21.1.3 When SMMU_IDR3.BBML == 2 (Level 2)" and
>>> "3.21.1.2 When SMMU_IDR3.BBML == 1 (Level 1)"
>>
>> You can drop this, and the dependencies on BBML elsewhere, until you get
>> round to the future large-page-splitting work, since that's the only
>> thing this represents. Not much point having the feature flags without
>> an actual implementation, or any users.
>>
> OK.
> 
> My thinking was that the BBML2 meant *also* that we don't need that break-before-make
> thingie upon switching translation table entries. It seems that from what you
> say, BBML2 then just refers to this but only on the context of switching between
> hugepages/normal pages (?), not in general on all bits of the PTE (which we woud .. upon
> switching from writeable-dirty to writeable-clean with DBM-set).

Yes, BBML is purely about swapping between a block (hugepage) entry and 
a table representing the exact equivalent mapping.

A break-before-make procedure isn't required when just changing 
permissions, and AFAICS it doesn't apply to changing the DBM bit either, 
but as mentioned I think we could probably just not do that anyway.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

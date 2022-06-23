Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16463C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 09:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 996FC41734;
	Thu, 23 Jun 2022 09:42:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 996FC41734
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2mT2DPhDZClT; Thu, 23 Jun 2022 09:42:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 09D4342492;
	Thu, 23 Jun 2022 09:42:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09D4342492
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97430C0039;
	Thu, 23 Jun 2022 09:42:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A2ABC002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 09:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 41E3284608
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 09:42:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 41E3284608
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QHtMfKh1jpkH for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 09:42:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F6F0845F4
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F6F0845F4
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 09:42:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D398312FC;
 Thu, 23 Jun 2022 02:42:54 -0700 (PDT)
Received: from [10.57.85.4] (unknown [10.57.85.4])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23B3E3F792;
 Thu, 23 Jun 2022 02:42:54 -0700 (PDT)
Message-ID: <82767d0d-a04b-4432-0e7e-77bcca095e09@arm.com>
Date: Thu, 23 Jun 2022 10:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 3/7] iommu/amd: Fix sparse warning
Content-Language: en-GB
To: Joerg Roedel <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>
References: <20220603112107.8603-1-vasant.hegde@amd.com>
 <20220603112107.8603-4-vasant.hegde@amd.com> <YrQeXdR8yPOyv957@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YrQeXdR8yPOyv957@8bytes.org>
Cc: iommu@lists.linux-foundation.org
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

On 2022-06-23 09:03, Joerg Roedel wrote:
> On Fri, Jun 03, 2022 at 04:51:03PM +0530, Vasant Hegde wrote:
>> Fix below sparse warning:
>>    CHECK   drivers/iommu/amd/iommu.c
>>    drivers/iommu/amd/iommu.c:73:24: warning: symbol 'amd_iommu_ops' was not declared. Should it be static?
>>
>> Also we are going to introduce v2 page table which has different
>> pgsize_bitmaps. Hence remove 'const' qualifier.
> 
> I am not a fan of removing the consts. Please use separate ops
> structures for v2 page-tables and make then const as well. This probably
> also has some optimization potential in the future when we can make the
> ops call-back functions page-table specific.

TBH it's probably time to retire iommu_ops->pgsize_bitmap anyway. At the 
very least it would be logical to move it to iommu_domain_ops now, but 
maybe we could skip ahead and just rely on drivers initialising 
domain->pgsize_bitmap directly in their .domain_alloc?

(and FWIW I'm leaning towards the same for the domain->ops as well; the 
more I look at ops->default_domain_ops, the more it starts looking like 
a stupid mess... my stupid mess... sorry about that)

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DA8C43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 14:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 158BA40CB0;
	Wed, 22 Jun 2022 14:33:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 158BA40CB0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LUczcFnCLP11; Wed, 22 Jun 2022 14:33:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DEF6140012;
	Wed, 22 Jun 2022 14:33:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DEF6140012
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9428CC0039;
	Wed, 22 Jun 2022 14:33:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BDF8C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:33:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 433E141A49
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:33:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 433E141A49
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6qPUNmW9F3Th for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 14:33:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6531941A41
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6531941A41
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:33:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7540D6E;
 Wed, 22 Jun 2022 07:33:12 -0700 (PDT)
Received: from [10.57.41.243] (unknown [10.57.41.243])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0FF23F792;
 Wed, 22 Jun 2022 07:33:11 -0700 (PDT)
Message-ID: <1e206563-4fb6-923c-9a3c-0d068d400ddf@arm.com>
Date: Wed, 22 Jun 2022 15:33:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] swiotlb: Remove redundant swiotlb_force
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>
References: <20220622142952.320057-1-steven.price@arm.com>
 <20220622143219.GA31314@lst.de>
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20220622143219.GA31314@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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

On 22/06/2022 15:32, Christoph Hellwig wrote:
> On Wed, Jun 22, 2022 at 03:29:52PM +0100, Steven Price wrote:
>> The variable (and enum) was removed in commit c6af2aa9ffc9 ("swiotlb:
>> make the swiotlb_init interface more useful") but the declaration was
>> left in swiotlb.h. Tidy up by removing the declaration as well.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
> 
> I just applied an identical patch from Dongli Zhang a few hours ago.

Ah, I missed that. Sorry for the noise!

Steve
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

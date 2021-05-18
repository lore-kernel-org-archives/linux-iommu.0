Return-Path: <SRS0=LVl/=KN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37774C433B4
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 09:25:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E322F6135D
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 09:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E322F6135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B48FD607F9;
	Tue, 18 May 2021 09:25:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zbg4dJ51p2Sd; Tue, 18 May 2021 09:25:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B946C60682;
	Tue, 18 May 2021 09:25:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89640C000D;
	Tue, 18 May 2021 09:25:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6ADFFC0001
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 09:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4D538405A0
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 09:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4AgMZXYB8rdy for <iommu@lists.linux-foundation.org>;
 Tue, 18 May 2021 09:25:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9F96405EA
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 09:25:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35D301FB;
 Tue, 18 May 2021 02:25:33 -0700 (PDT)
Received: from [10.57.66.179] (unknown [10.57.66.179])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 361083F719;
 Tue, 18 May 2021 02:25:30 -0700 (PDT)
Subject: Re: [PATCH v3] iommu/iova: put free_iova_mem() outside of spinlock
 iova_rbtree_lock
To: Joerg Roedel <joro@8bytes.org>, chenxiang <chenxiang66@hisilicon.com>
References: <1618816415-95649-1-git-send-email-chenxiang66@hisilicon.com>
 <YKOEHh5CECej06ah@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <811c5e6d-5ba6-d678-b5b8-180d38b879b7@arm.com>
Date: Tue, 18 May 2021 10:25:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKOEHh5CECej06ah@8bytes.org>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, will@kernel.org, linuxarm@openeuler.org,
 linuxarm@huawei.com
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

On 2021-05-18 10:08, Joerg Roedel wrote:
> On Mon, Apr 19, 2021 at 03:13:35PM +0800, chenxiang wrote:
>> From: Xiang Chen <chenxiang66@hisilicon.com>
>>
>> It is not necessary to put free_iova_mem() inside of spinlock/unlock
>> iova_rbtree_lock which only leads to more completion for the spinlock.
>> It has a small promote on the performance after the change. And also
>> rename private_free_iova() as remove_iova() because the function will not
>> free iova after that change.
>>
>> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
>> ---
>>   drivers/iommu/iova.c | 18 +++++++++++-------
>>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> Looks good to me, but I'll wait for Robins opinion before applying.

Go ahead - I acked the resend[1] :)

Thanks,
Robin.

[1] 
https://lore.kernel.org/linux-iommu/9edc6849-f9ff-f6fc-30a0-8bb2e8d3bd0d@arm.com/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C466C2D0A8
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 06:32:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96423221E8
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 06:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCQbjFVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96423221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 28F5B203E5;
	Wed, 23 Sep 2020 06:32:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rqULMWHwsFNr; Wed, 23 Sep 2020 06:32:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 16CD320396;
	Wed, 23 Sep 2020 06:32:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8867C0859;
	Wed, 23 Sep 2020 06:32:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A444C0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 06:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 88B9685E98
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 06:32:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j27C3lCcQJL5 for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 06:32:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7170F85E93
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 06:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600842774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNYXvNzELYq54wu7W3RCN3nmnlEFmyGx388a6Bc/HMA=;
 b=ZCQbjFVvQLI5Rjr75v+L+cJbGMNprnFc6Kmv9o9n1NYwxPe+Kp39tuXEJCp1cRJFiCR4jf
 6Bm6gPmhnzXH5j7fvYhk8cOzDCugTSyjAaHchLJlMlCwUXYTMPeUUG+gm7UTUFdJ4iMzYU
 vQbBr1hk2qSyIu+S4DowishcqvaZtMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-OsAsDADyNyWgWEaMZInWBA-1; Wed, 23 Sep 2020 02:32:49 -0400
X-MC-Unique: OsAsDADyNyWgWEaMZInWBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD408807100;
 Wed, 23 Sep 2020 06:32:47 +0000 (UTC)
Received: from [10.36.112.29] (ovpn-112-29.ams2.redhat.com [10.36.112.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4694B78822;
 Wed, 23 Sep 2020 06:32:45 +0000 (UTC)
Subject: Re: [PATCH v2] iommu/arm: Add module parameter to set msi iova address
To: Will Deacon <will@kernel.org>,
 Vennila Megavannan <vemegava@linux.microsoft.com>
References: <20200914181307.117792-1-vemegava@linux.microsoft.com>
 <20200921204545.GA3811@willie-the-truck>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <85f7d1ae-71a9-4e95-8a30-03cc699d4794@redhat.com>
Date: Wed, 23 Sep 2020 08:32:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200921204545.GA3811@willie-the-truck>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: jean-philippe@linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, tyhicks@linux.microsoft.com,
 srinath.mannam@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

Hi Will,

On 9/21/20 10:45 PM, Will Deacon wrote:
> On Mon, Sep 14, 2020 at 11:13:07AM -0700, Vennila Megavannan wrote:
>> From: Srinath Mannam <srinath.mannam@broadcom.com>
>>
>> Add provision to change default value of MSI IOVA base to platform's
>> suitable IOVA using module parameter. The present hardcoded MSI IOVA base
>> may not be the accessible IOVA ranges of platform.
>>
>> If any platform has the limitaion to access default MSI IOVA, then it can
>> be changed using "arm-smmu.msi_iova_base=0xa0000000" command line argument.
>>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> Co-developed-by: Vennila Megavannan <vemegava@linux.microsoft.com>
>> Signed-off-by: Vennila Megavannan <vemegava@linux.microsoft.com>
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 ++++-
>>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 5 ++++-
>>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> This feels pretty fragile. Wouldn't it be better to realise that there's
> a region conflict with iommu_dma_get_resv_regions() and move the MSI window
> accordingly at runtime?

Since cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back
into dma specific path"), the PCI host bridge windows are not exposed by
iommu_dma_get_resv_regions() anymore. If I understood correctly, what is
attempted here is to avoid the collision between such PCI host bridge
window and the MSI IOVA range.

Thanks

Eric
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

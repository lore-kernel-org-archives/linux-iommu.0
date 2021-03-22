Return-Path: <SRS0=3kXM=IU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A36C433DB
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 15:03:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2040619B1
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 15:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2040619B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 75C7D4027F;
	Mon, 22 Mar 2021 15:03:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YPFsx_bG0V5o; Mon, 22 Mar 2021 15:03:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 853524022B;
	Mon, 22 Mar 2021 15:03:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45F1AC000A;
	Mon, 22 Mar 2021 15:03:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97430C0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 15:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 75E2D60705
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 15:03:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y3hu6RIW29Zh for <iommu@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 15:03:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A0216066A
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 15:03:18 +0000 (UTC)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F3yFk4McTz682dy;
 Mon, 22 Mar 2021 22:54:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 22 Mar 2021 16:03:15 +0100
Received: from [10.210.167.192] (10.210.167.192) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 15:03:14 +0000
Subject: Re: [PATCH 1/6] iommu: Move IOVA power-of-2 roundup into allocator
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, 
 "will@kernel.org" <will@kernel.org>, "jejb@linux.ibm.com"
 <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
References: <1616160348-29451-1-git-send-email-john.garry@huawei.com>
 <1616160348-29451-2-git-send-email-john.garry@huawei.com>
 <ee935a6d-a94c-313e-f0ed-e14cc6dac055@arm.com>
 <73d459de-b5cc-e2f5-bcd7-2ee23c8d5075@huawei.com>
 <afc2fc05-a799-cb14-debd-d36afed8f456@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <08c0f4b9-8713-fa97-3986-3cfb0d6b820b@huawei.com>
Date: Mon, 22 Mar 2021 15:01:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <afc2fc05-a799-cb14-debd-d36afed8f456@arm.com>
Content-Language: en-US
X-Originating-IP: [10.210.167.192]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>
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

On 19/03/2021 19:20, Robin Murphy wrote:

Hi Robin,

>> So then we have the issue of how to dynamically increase this rcache
>> threshold. The problem is that we may have many devices associated with
>> the same domain. So, in theory, we can't assume that when we increase
>> the threshold that some other device will try to fast free an IOVA which
>> was allocated prior to the increase and was not rounded up.
>>
>> I'm very open to better (or less bad) suggestions on how to do this ...
> ...but yes, regardless of exactly where it happens, rounding up or not
> is the problem for rcaches in general. I've said several times that my
> preferred approach is to not change it that dynamically at all, but
> instead treat it more like we treat the default domain type.
> 

Can you remind me of that idea? I don't remember you mentioning using 
default domain handling as a reference in any context.

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF49C388F7
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 14:25:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80042477C
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 14:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VhBDHkEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80042477C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 585C72051D;
	Wed, 28 Oct 2020 14:25:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FG6AmmCHCLcm; Wed, 28 Oct 2020 14:25:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 69B9C20555;
	Wed, 28 Oct 2020 14:25:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 441B3C088B;
	Wed, 28 Oct 2020 14:25:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46F47C0051;
 Wed, 28 Oct 2020 14:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2FA7986A34;
 Wed, 28 Oct 2020 14:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9ZVvZgRpXVfI; Wed, 28 Oct 2020 14:25:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com
 [207.171.190.10])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2C5CA85DE6;
 Wed, 28 Oct 2020 14:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1603895103; x=1635431103;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=1BTfA+rxnyipf7FL9JfHzZ8nLKWKah94WTAk0YJt0lI=;
 b=VhBDHkEW+ooCxM4C9jt0kAw1QaWkd794HsF0cH3rfiIYCx1WtkVCaaWE
 yl74bVVkMlPYcF7U7pyA37kEuDWHq9zxeLdf25o4huJIqBUDc105DM3xB
 EaCnWZxom8b/EoHyI9unwLWVvWbf3B899jdRZZ4t3Ij4SU3W6oSU87rSm M=;
X-IronPort-AV: E=Sophos;i="5.77,426,1596499200"; d="scan'208";a="88221100"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 28 Oct 2020 14:24:12 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS
 id C42D4A1F4E; Wed, 28 Oct 2020 14:24:11 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 28 Oct 2020 14:24:11 +0000
Received: from edge-cache-113.e-fra50.amazon.com (10.43.161.24) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 28 Oct 2020 14:24:07 +0000
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
To: Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com> <20200220161309.GB12709@lst.de>
 <20200221153340.4cdcde81.pasic@linux.ibm.com>
 <20200222140408-mutt-send-email-mst@kernel.org>
 <20200224171657.GB7278@lst.de>
Message-ID: <691d8c8e-665c-b05f-383f-78377fcf6741@amazon.com>
Date: Wed, 28 Oct 2020 15:24:03 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20200224171657.GB7278@lst.de>
Content-Language: en-US
X-Originating-IP: [10.43.161.24]
X-ClientProxiedBy: EX13D31UWC002.ant.amazon.com (10.43.162.220) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>,
 Michael Mueller <mimu@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>
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
From: Alexander Graf via iommu <iommu@lists.linux-foundation.org>
Reply-To: Alexander Graf <graf@amazon.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 24.02.20 18:16, Christoph Hellwig wrote:
> On Sat, Feb 22, 2020 at 02:07:58PM -0500, Michael S. Tsirkin wrote:
>> On Fri, Feb 21, 2020 at 03:33:40PM +0100, Halil Pasic wrote:
>>> AFAIU you have a positive attitude towards the idea, that
>>> !F_VIRTIO_PLATFORM implies 'no DMA API is used by virtio'
>>> should be scrapped.
>>>
>>> I would like to accomplish that without adverse effects to virtio-ccw
>>> (because caring for virtio-ccw is a part of job description).
>>>
>>> Regards,
>>> Halil
>>
>> It is possible, in theory. IIRC the main challenge is that DMA API
>> has overhead of indirect function calls even when all it
>> does it return back the PA without changes.
> 
> That overhead is gone now, the DMA direct calls are direct calls these
> days.

Michael, would that mitigate your concerns to just always use the DMA 
API? If not, wouldn't it make sense to benchmark and pinpoint Christoph 
to paths that do slow things down, so we can finally move virtio into a 
world where it doesn't bypass the kernel DMA infrastructure.


Alex





Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

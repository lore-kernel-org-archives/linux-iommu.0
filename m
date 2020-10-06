Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64388C41604
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 15:41:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07F2206F7
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 15:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyjqsJnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07F2206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9AA6984DFD;
	Tue,  6 Oct 2020 15:41:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r4R-dWDLj8Sc; Tue,  6 Oct 2020 15:41:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0518984CCE;
	Tue,  6 Oct 2020 15:41:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA97BC016F;
	Tue,  6 Oct 2020 15:41:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A057DC0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 15:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8979D2002A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 15:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vQxNy0BDOrLD for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 15:41:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 2B85A1FEAE
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 15:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601998895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c1hC8pyEeVJeN5O+RBkwX/g7tx41qIl2D0l8V0M7ZJk=;
 b=UyjqsJnEL+HSQ4GelMpBbXMiFAGAS4g6L8xHpeKG5kRf5V/lzRd/GCj0bii9R6yLR9Ogqf
 I8wGst6V4adtWAYQzI3VejRt1olM7l+ik7n6/t3FNNmEZxGXxxzH4JZSMofzbUnyNW71Vs
 1oQ2EN5Q6UG2rBVo+vX/BFrbAEiMV+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-r-pNAetkOuCBgRY3acUVMw-1; Tue, 06 Oct 2020 11:41:31 -0400
X-MC-Unique: r-pNAetkOuCBgRY3acUVMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3E0D1084C90;
 Tue,  6 Oct 2020 15:41:25 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF9975C1C4;
 Tue,  6 Oct 2020 15:41:19 +0000 (UTC)
Subject: Re: [RFC 0/3] iommu: Reserved regions for IOVAs beyond dma_mask and
 iommu aperture
To: Christoph Hellwig <hch@lst.de>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20200928195037.22654-1-eric.auger@redhat.com>
 <20200928164224.12350d84@w520.home>
 <1cbaf3e7-cf88-77f6-4cc4-46dcd60eb649@redhat.com>
 <20200929121849.455af184@w520.home>
 <20201005104410.GA12138@e121166-lin.cambridge.arm.com>
 <20201005130852.GB2163@lst.de>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1b5102d6-2a85-e73a-4676-63b1228f7144@redhat.com>
Date: Tue, 6 Oct 2020 17:41:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201005130852.GB2163@lst.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, dwmw2@infradead.org,
 eric.auger.pro@gmail.com
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

Hi all,

On 10/5/20 3:08 PM, Christoph Hellwig wrote:
> On Mon, Oct 05, 2020 at 11:44:10AM +0100, Lorenzo Pieralisi wrote:
>>> I see that there are both OF and ACPI hooks in pci_dma_configure() and
>>> both modify dev->dma_mask, which is what pci-sysfs is exposing here,
>>> but I'm not convinced this even does what it's intended to do.  The
>>> driver core calls this via the bus->dma_configure callback before
>>> probing a driver, but then what happens when the driver calls
>>> pci_set_dma_mask()?  This is just a wrapper for dma_set_mask() and I
>>> don't see anywhere that would take into account the existing
>>> dev->dma_mask.  It seems for example that pci_dma_configure() could
>>> produce a 42 bit mask as we have here, then the driver could override
>>> that with anything that the dma_ops.dma_supported() callback finds
>>> acceptable, and I don't see any instances where the current
>>> dev->dma_mask is considered.  Am I overlooking something? 
>>
>> I don't think so but Christoph and Robin can provide more input on
>> this - it is a long story.
>>
>> ACPI and OF bindings set a default dma_mask (and dev->bus_dma_limit),
>> this does not prevent a driver from overriding the dev->dma_mask but DMA
>> mapping code still takes into account the dev->bus_dma_limit.
>>
>> This may help:
>>
>> git log -p 03bfdc31176c

Thank you Lorenzo for the pointer.
> 
> This is at best a historic artefact.  Bus drivers have no business
> messing with the DMA mask, dev->bus_dma_limit is the way to communicate
> addressing limits on the bus (or another interconnect closer to the CPU).
> 
Then could I envision to use the dev->bus_dma_limit instead of the
dev->dma_mask?

Nevertheless, I would need a way to let the userspace know that the
usable IOVA ranges reported by VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
takes into account the addressing limits of the bus.

Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

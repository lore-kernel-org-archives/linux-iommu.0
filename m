Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82188C4727D
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 15:29:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E01206DD
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 15:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4a7KgpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E01206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8B90A20551;
	Tue,  6 Oct 2020 15:29:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4aGOmIzkRUx8; Tue,  6 Oct 2020 15:29:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5FCDF2052B;
	Tue,  6 Oct 2020 15:29:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42855C016F;
	Tue,  6 Oct 2020 15:29:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5224BC0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 15:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 40C6487061
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 15:29:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D2-pOuyqtM6K for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 15:29:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 01F6087042
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601998175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3TQyn0r0hHJtyWnHzP2XsiJelQMbh2EnW4oVHas18k=;
 b=L4a7KgpJqlF5Frn19gxbj/K2uMtGqZksQXEvwofgg+OWuxk6H5/wq5tjmOX0To3lqXKdDc
 CANrqDFg/dAiLBsfy1V+yB/m68FI1H1AvfInVmKU4IVZfpQaT0eGHQUrpOy/kHzX5o26dA
 Du4bTRhtDYns2tFdyO2AqUUCgWz0BxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-XNZ3tFqAPmCyxpBT5oD_sA-1; Tue, 06 Oct 2020 11:29:31 -0400
X-MC-Unique: XNZ3tFqAPmCyxpBT5oD_sA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7226018A072C;
 Tue,  6 Oct 2020 15:29:29 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C32255764;
 Tue,  6 Oct 2020 15:29:23 +0000 (UTC)
Subject: Re: [PATCH v10 11/11] vfio: Document nested stage control
To: Zenghui Yu <yuzenghui@huawei.com>, eric.auger.pro@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com, robin.murphy@arm.com
References: <20200320161911.27494-1-eric.auger@redhat.com>
 <20200320161911.27494-12-eric.auger@redhat.com>
 <26a85a63-6cc1-0348-e703-cb31ddd75339@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4df9f189-7a1b-be1f-0b1a-1669534a98d7@redhat.com>
Date: Tue, 6 Oct 2020 17:29:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <26a85a63-6cc1-0348-e703-cb31ddd75339@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Hi Zenghui,

On 9/24/20 3:42 PM, Zenghui Yu wrote:
> Hi Eric,
> 
> On 2020/3/21 0:19, Eric Auger wrote:
>> The VFIO API was enhanced to support nested stage control: a bunch of
>> new iotcls, one DMA FAULT region and an associated specific IRQ.
>>
>> Let's document the process to follow to set up nested mode.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> [...]
> 
>> +The userspace must be prepared to receive faults. The VFIO-PCI device
>> +exposes one dedicated DMA FAULT region: it contains a ring buffer and
>> +its header that allows to manage the head/tail indices. The region is
>> +identified by the following index/subindex:
>> +- VFIO_REGION_TYPE_NESTED/VFIO_REGION_SUBTYPE_NESTED_DMA_FAULT
>> +
>> +The DMA FAULT region exposes a VFIO_REGION_INFO_CAP_PRODUCER_FAULT
>> +region capability that allows the userspace to retrieve the ABI version
>> +of the fault records filled by the host.
> 
> Nit: I don't see this capability in the code.

Thank you very much for the review. I am late doing the respin but I
will take into account all your comments.

Thanks!

Eric
> 
> 
> Thanks,
> Zenghui
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

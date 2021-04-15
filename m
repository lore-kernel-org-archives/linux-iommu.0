Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84882C433B4
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 13:11:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B40B611AC
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 13:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B40B611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E260940129;
	Thu, 15 Apr 2021 13:11:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Th0JyP_OK6-a; Thu, 15 Apr 2021 13:11:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id C23454016C;
	Thu, 15 Apr 2021 13:11:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E726C000B;
	Thu, 15 Apr 2021 13:11:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA00EC000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 13:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A9B006075E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 13:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gaJbcgzDincx for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 13:11:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9DC8C60680
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 13:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618492300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJFJJborCVJEMqUuUmQ0ihhHIFtN58LgRcEx9fJY0yk=;
 b=YfdYhD1KXOQofVDi6ddoyfUiLfmOSpXtVQo48PGgsItO1LiUx5Bi46thUvFlk12UnUU5rl
 Cjjp7LYpRteqZB7Wtz1KvjifuKM/0sZQQ9SA5V1Q9mEUmsuW+csMfblwdqfiW8Fl7JO0I1
 B2Zwi1X8/2q0XKteF2uCgdI0xB/S12A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-8zek38_XN6qIhkiadECvyA-1; Thu, 15 Apr 2021 09:11:36 -0400
X-MC-Unique: 8zek38_XN6qIhkiadECvyA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 279A710054F6;
 Thu, 15 Apr 2021 13:11:33 +0000 (UTC)
Received: from [10.36.114.81] (ovpn-114-81.ams2.redhat.com [10.36.114.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0911660C22;
 Thu, 15 Apr 2021 13:11:21 +0000 (UTC)
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
References: <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401160337.GJ1463678@nvidia.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
Date: Thu, 15 Apr 2021 15:11:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210401160337.GJ1463678@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

Hi Jason,

On 4/1/21 6:03 PM, Jason Gunthorpe wrote:
> On Thu, Apr 01, 2021 at 02:08:17PM +0000, Liu, Yi L wrote:
> 
>> DMA page faults are delivered to root-complex via page request message and
>> it is per-device according to PCIe spec. Page request handling flow is:
>>
>> 1) iommu driver receives a page request from device
>> 2) iommu driver parses the page request message. Get the RID,PASID, faulted
>>    page and requested permissions etc.
>> 3) iommu driver triggers fault handler registered by device driver with
>>    iommu_report_device_fault()
> 
> This seems confused.
> 
> The PASID should define how to handle the page fault, not the driver.

In my series I don't use PASID at all. I am just enabling nested stage
and the guest uses a single context. I don't allocate any user PASID at
any point.

When there is a fault at physical level (a stage 1 fault that concerns
the guest), this latter needs to be reported and injected into the
guest. The vfio pci driver registers a fault handler to the iommu layer
and in that fault handler it fills a circ bugger and triggers an eventfd
that is listened to by the VFIO-PCI QEMU device. this latter retrives
the faault from the mmapped circ buffer, it knowns which vIOMMU it is
attached to, and passes the fault to the vIOMMU.
Then the vIOMMU triggers and IRQ in the guest.

We are reusing the existing concepts from VFIO, region, IRQ to do that.

For that use case, would you also use /dev/ioasid?

Thanks

Eric
> 
> I don't remember any device specific actions in ATS, so what is the
> driver supposed to do?
> 
>> 4) device driver's fault handler signals an event FD to notify userspace to
>>    fetch the information about the page fault. If it's VM case, inject the
>>    page fault to VM and let guest to solve it.
> 
> If the PASID is set to 'report page fault to userspace' then some
> event should come out of /dev/ioasid, or be reported to a linked
> eventfd, or whatever.
> 
> If the PASID is set to 'SVM' then the fault should be passed to
> handle_mm_fault
> 
> And so on.
> 
> Userspace chooses what happens based on how they configure the PASID
> through /dev/ioasid.
> 
> Why would a device driver get involved here?
> 
>> Eric has sent below series for the page fault reporting for VM with passthru
>> device.
>> https://lore.kernel.org/kvm/20210223210625.604517-5-eric.auger@redhat.com/
> 
> It certainly should not be in vfio pci. Everything using a PASID needs
> this infrastructure, VDPA, mdev, PCI, CXL, etc.
> 
> Jason
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

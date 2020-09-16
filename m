Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EBDC433E2
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 16:51:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F69D205CB
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 16:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVq6PL6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F69D205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ABC028742B;
	Wed, 16 Sep 2020 16:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mpvV7CEYK8ao; Wed, 16 Sep 2020 16:50:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 17D428741B;
	Wed, 16 Sep 2020 16:50:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED993C0859;
	Wed, 16 Sep 2020 16:50:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF301C0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 16:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C7C1E8741E
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 16:50:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HR3atyo6Bmgl for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 16:50:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C434E8741B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 16:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600275055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OHlFrQhUqBL1DWeL5u4a54eYPkpfgwlp82rza8GtDRI=;
 b=RVq6PL6jjYuc/mketxL/4YZwgV8qhi2Jb58YMQ4F+dSqSBmxXGE9wF10lkvUfV2TYQ2Wj0
 mFLM5NGoTP8uFO8wtWfcW2cHijms/AbC/0vtiqAa6ZybP5Llexi/kqjdUR3eHyNTfMlFVq
 JI7yw3LtsHmXdJUK3mxgMJ57yZFS7eY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-vMiUF0y-M1-PFV9VUZuMag-1; Wed, 16 Sep 2020 12:50:51 -0400
X-MC-Unique: vMiUF0y-M1-PFV9VUZuMag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4C0C8797E1;
 Wed, 16 Sep 2020 16:50:49 +0000 (UTC)
Received: from [10.36.112.29] (ovpn-112-29.ams2.redhat.com [10.36.112.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B26D778809;
 Wed, 16 Sep 2020 16:50:33 +0000 (UTC)
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
To: Jason Gunthorpe <jgg@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20200914105857.3f88a271@x1.home>
 <20200914174121.GI904879@nvidia.com> <20200914122328.0a262a7b@x1.home>
 <20200914190057.GM904879@nvidia.com> <20200914163310.450c8d6e@x1.home>
 <20200915142906.GX904879@nvidia.com>
 <MWHPR11MB1645934DB27033011316059B8C210@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200916083217.GA5316@myrica> <20200916145148.GD6199@nvidia.com>
 <20200916162052.GE5316@myrica> <20200916163246.GC3699@nvidia.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <47671ace-9b8f-7eca-0529-1191f00ed904@redhat.com>
Date: Wed, 16 Sep 2020 18:50:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200916163246.GC3699@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Wu, Hao" <hao.wu@intel.com>
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

Hi,
On 9/16/20 6:32 PM, Jason Gunthorpe wrote:
> On Wed, Sep 16, 2020 at 06:20:52PM +0200, Jean-Philippe Brucker wrote:
>> On Wed, Sep 16, 2020 at 11:51:48AM -0300, Jason Gunthorpe wrote:
>>> On Wed, Sep 16, 2020 at 10:32:17AM +0200, Jean-Philippe Brucker wrote:
>>>> And this is the only PASID model for Arm SMMU (and AMD IOMMU, I believe):
>>>> the PASID space of a PCI function cannot be shared between host and guest,
>>>> so we assign the whole PASID table along with the RID. Since we need the
>>>> BIND, INVALIDATE, and report APIs introduced here to support nested
>>>> translation, a /dev/sva interface would need to support this mode as well.
>>>
>>> Well, that means this HW cannot support PASID capable 'SIOV' style
>>> devices in guests.
>>
>> It does not yet support Intel SIOV, no. It does support the standards,
>> though: PCI SR-IOV to partition a device and PASIDs in a guest.
> 
> SIOV is basically standards based, it is better thought of as a
> cookbook on how to use PASID and IOMMU together.
> 
>>> I admit whole function PASID delegation might be something vfio-pci
>>> should handle - but only if it really doesn't fit in some /dev/sva
>>> after we cover the other PASID cases.
>>
>> Wouldn't that be the duplication you're trying to avoid?  A second
>> channel for bind, invalidate, capability and fault reporting
>> mechanisms?
> 
> Yes, which is why it seems like it would be nicer to avoid it. Why I
> said "might" :)
> 
>> If we extract SVA parts of vfio_iommu_type1 into a separate chardev,
>> PASID table pass-through [1] will have to use that.
> 
> Yes, '/dev/sva' (which is a terrible name) would want to be the uAPI
> entry point for controlling the vIOMMU related to PASID.
> 
> Does anything in the [1] series have tight coupling to VFIO other than
> needing to know a bus/device/function? It looks like it is mostly
> exposing iommu_* functions as uAPI?

this series does not use any PASID so it fits quite nicely into the VFIO
framework I think. Besides cache invalidation that takes the struct
device, other operations (MSI binding and PASID table passing operate on
the iommu domain). Also we use the VFIO memory region and
interrupt/eventfd registration mechanism to return faults.

Thanks

Eric
> 
> Jason
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

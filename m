Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C77C433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 07:09:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C9D6137A
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 07:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D5C9D6137A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8F7E6065F;
	Wed, 29 Sep 2021 07:09:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xRb86kmzdl_S; Wed, 29 Sep 2021 07:09:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9A67D60656;
	Wed, 29 Sep 2021 07:09:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72DF1C0011;
	Wed, 29 Sep 2021 07:09:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39B67C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 07:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1569560656
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 07:09:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p46Jw1l5-3Al for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 07:09:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E259C6065F
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 07:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632899352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HT5SZ0TnRfXLHpISWqHTNLhMm8Om7aNvjCr5xAmuCp4=;
 b=KCvBUCaXs24OgpuGQ5yyTZWnjI6DchCQ/XirRrje5B2OjDG55f7P8cHgn8+NpIQVCbSSZJ
 2cg+na98PaVAoXYL+Vk7kIuDhUkXb0mcFioZU04SEIqAylttLQU3icmAouD+BMZE97V3To
 hD+mfspCLMa/zYv5LJ5z4JhtRw5Z7lo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-t-ZNd9F0MOCWSQSe2aDP4w-1; Wed, 29 Sep 2021 03:09:11 -0400
X-MC-Unique: t-ZNd9F0MOCWSQSe2aDP4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3109F100C661;
 Wed, 29 Sep 2021 07:09:08 +0000 (UTC)
Received: from localhost (unknown [10.39.192.252])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFDBD6B55A;
 Wed, 29 Sep 2021 07:08:26 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, David Gibson
 <david@gibson.dropbear.id.au>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [RFC 03/20] vfio: Add vfio_[un]register_device()
In-Reply-To: <BN9PR11MB543356CD7AD9F45793D1ED118CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
Organization: Red Hat GmbH
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com> <YVPS43bNjvzdxdiM@yekko>
 <BN9PR11MB543356CD7AD9F45793D1ED118CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Wed, 29 Sep 2021 09:08:25 +0200
Message-ID: <871r576eqe.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Wed, Sep 29 2021, "Tian, Kevin" <kevin.tian@intel.com> wrote:

>> From: David Gibson <david@gibson.dropbear.id.au>
>> Sent: Wednesday, September 29, 2021 10:44 AM
>> 
>> > One alternative option is to arrange device nodes in sub-directories based
>> > on the device type. But doing so also adds one trouble to userspace. The
>> > current vfio uAPI is designed to have the user query device type via
>> > VFIO_DEVICE_GET_INFO after opening the device. With this option the user
>> > instead needs to figure out the device type before opening the device, to
>> > identify the sub-directory.
>> 
>> Wouldn't this be up to the operator / configuration, rather than the
>> actual software though?  I would assume that typically the VFIO
>> program would be pointed at a specific vfio device node file to use,
>> e.g.
>> 	my-vfio-prog -d /dev/vfio/pci/0000:0a:03.1
>> 
>> Or more generally, if you're expecting userspace to know a name in a
>> uniqu pattern, they can equally well know a "type/name" pair.
>> 
>
> You are correct. Currently:
>
> -device, vfio-pci,host=DDDD:BB:DD.F
> -device, vfio-pci,sysfdev=/sys/bus/pci/devices/ DDDD:BB:DD.F
> -device, vfio-platform,sysdev=/sys/bus/platform/devices/PNP0103:00
>
> above is definitely type/name information to find the related node. 
>
> Actually even for Jason's proposal we still need such information to
> identify the sysfs path.
>
> Then I feel type-based sub-directory does work. Adding another link
> to sysfs sounds unnecessary now. But I'm not sure whether we still
> want to create /dev/vfio/devices/vfio0 thing and related udev rule
> thing that you pointed out in another mail.

Still reading through this whole thread, but type-based subdirectories
also make the most sense to me. I don't really see userspace wanting to
grab just any device and then figure out whether it is the device it was
looking for, but rather immediately go to a specific device or at least
a device of a specific type.

Sequentially-numbered devices tend to become really unwieldy in my
experience if you are working on a system with loads of devices.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

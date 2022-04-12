Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED38C433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 20:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B349B4176D;
	Tue, 12 Apr 2022 20:50:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1UkeB3jkNu3b; Tue, 12 Apr 2022 20:50:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5334640923;
	Tue, 12 Apr 2022 20:50:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2213EC0033;
	Tue, 12 Apr 2022 20:50:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32B45C002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 20:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 194CE60E50
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 20:50:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fs7ZXE0IEWG4 for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 20:50:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2844460E2A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 20:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649796639;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTclCY2PTi8CSDgKlOSlZc3QOg3fg6Ez1f25r7u5uXA=;
 b=itk733terIZpBYq7enxflqVWWG9ln1PnWmzqdFdETvGUuErpnlVCBn3T46mx0Ea5QiOMng
 S63QiY+oIPjpvagAlVtDZyJGUy1uxmJqWsBM+Yhcbp7C2TQTb2lTZaF5nvQevTc2dfiO+W
 XDKhnsoFv0oONEqqjw41N3ZR1/HKCr8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-XcbW68tGPgS8iF4poeTTEQ-1; Tue, 12 Apr 2022 16:50:36 -0400
X-MC-Unique: XcbW68tGPgS8iF4poeTTEQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 f12-20020a05600c154c00b0038ea9ed0a4aso1753478wmg.1
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=VTclCY2PTi8CSDgKlOSlZc3QOg3fg6Ez1f25r7u5uXA=;
 b=Tzbg0M5Jvi9zWJlaEPyNb1TBpwCuExZiE64MZp7mts0dH8jZOCtxuLMYnLC17g5xVD
 08QFKc5jaBnr1VAUdz2btTZuWj87M8pOFlSAMRGtFAoTFQw4fDOIgICJJGbN5U+Ofzsy
 lzvAulGYmi6YS+FDcYmXjEzsHv/4ImTOGdYstBvzM2FjExHaYV40BHm+J58EfBrAkQUQ
 8pMnXRj+VzuOQPWOawQqL7lRMA7knTGneTcBc3ly91zQDyOZUipJ8BumvuDQfhTiC3xI
 uFriPHkAJZz0716JcTjJFftL4my3zXJ0YtQYrXWACJma0Yp3CARoMqAcuu4mw45Mpi3j
 zhDA==
X-Gm-Message-State: AOAM531KxawbGuxJWF5ubtBBgYz9XyUa1W5A5Y5R30mo4EeMDt+BD1vU
 UYf8w1tKKfBT9KFKdy8cBup508IC2jZEML+IJzwO3pOguJixIql8PkyirkviO6OjEPzFZDrtWpG
 mexjIvo0xJhGct744bUCxiL3HdLA72w==
X-Received: by 2002:adf:c10b:0:b0:1ed:c40f:7f91 with SMTP id
 r11-20020adfc10b000000b001edc40f7f91mr29804512wre.276.1649796635544; 
 Tue, 12 Apr 2022 13:50:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmJKPemp0S1viyNeeGB5SVWz2K1HYl+erdOjRDV3JLEfZWouYnHyc+zRQG1SoY56CZE5J71w==
X-Received: by 2002:adf:c10b:0:b0:1ed:c40f:7f91 with SMTP id
 r11-20020adfc10b000000b001edc40f7f91mr29804494wre.276.1649796635277; 
 Tue, 12 Apr 2022 13:50:35 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 p125-20020a1c2983000000b0038e5ca446bcsm484112wmp.5.2022.04.12.13.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 13:50:34 -0700 (PDT)
Subject: Re: [PATCH RFC 00/12] IOMMUFD Generic interface
To: Jason Gunthorpe <jgg@nvidia.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <17084696-4b85-8fe7-47e0-b15d4c56d403@redhat.com>
 <20220412202239.GL2120790@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <80cceffd-6213-7c85-e50a-71b931bd0b80@redhat.com>
Date: Tue, 12 Apr 2022 22:50:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220412202239.GL2120790@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 iommu@lists.linux-foundation.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jason,

On 4/12/22 10:22 PM, Jason Gunthorpe wrote:
> On Tue, Apr 12, 2022 at 10:13:32PM +0200, Eric Auger wrote:
>> Hi,
>>
>> On 3/18/22 6:27 PM, Jason Gunthorpe wrote:
>>> iommufd is the user API to control the IOMMU subsystem as it relates to
>>> managing IO page tables that point at user space memory.
>>>
>>> It takes over from drivers/vfio/vfio_iommu_type1.c (aka the VFIO
>>> container) which is the VFIO specific interface for a similar idea.
>>>
>>> We see a broad need for extended features, some being highly IOMMU device
>>> specific:
>>>  - Binding iommu_domain's to PASID/SSID
>>>  - Userspace page tables, for ARM, x86 and S390
>>>  - Kernel bypass'd invalidation of user page tables
>>>  - Re-use of the KVM page table in the IOMMU
>>>  - Dirty page tracking in the IOMMU
>>>  - Runtime Increase/Decrease of IOPTE size
>>>  - PRI support with faults resolved in userspace
>> This series does not have any concept of group fds anymore and the API
>> is device oriented.
>> I have a question wrt pci bus reset capability.
>>
>> 8b27ee60bfd6 ("vfio-pci: PCI hot reset interface")
>> introduced VFIO_DEVICE_PCI_GET_HOT_RESET_INFO and VFIO_DEVICE_PCI_HOT_RESET
>>
>> Maybe we can reuse VFIO_DEVICE_GET_PCI_HOT_RESET_INFO to retrieve the devices and iommu groups that need to be checked and involved in the bus reset. If I understand correctly we now need to make sure the devices are handled in the same security context (bound to the same iommufd)
>>
>> however VFIO_DEVICE_PCI_HOT_RESET operate on a collection of group fds.
>>
>> How do you see the porting of this functionality onto /dev/iommu?
> I already made a patch that converts VFIO_DEVICE_PCI_HOT_RESET to work
> on a generic notion of a file and the underlying infrastructure to
> allow it to accept either a device or group fd.
>
> Same for the similar issue in KVM.
>
> It is part of three VFIO series I will be posting. First is up here:
>
> https://lore.kernel.org/kvm/0-v1-a8faf768d202+125dd-vfio_mdev_no_group_jgg@nvidia.com/
>
> Overall the strategy is to contain the vfio_group as an internal detail
> of vfio.ko and external interfaces use either a struct vfio_device *
> or a struct file *
Thank you for the quick reply. Yi and I will look at this series. I
guess we won't support the bus reset functionality in our first QEMU
porting onto /dev/iommu until that code stabilizes.

Eric
>
> Jason
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

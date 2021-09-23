Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49041C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 07:25:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD0A60F70
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 07:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAD0A60F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B8560406F1;
	Thu, 23 Sep 2021 07:25:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DJUEh2cE4SFW; Thu, 23 Sep 2021 07:25:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 59F3A40151;
	Thu, 23 Sep 2021 07:25:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BC0DC0011;
	Thu, 23 Sep 2021 07:25:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80113C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 07:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 685D9415F9
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 07:25:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z3KMeVrrWIAL for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 07:25:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23AAE4158E
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 07:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632381936;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FvNkPyLF+1kcsTR6hdilBDqHZDnrfR2QQ6CleyZplLs=;
 b=Ffv5dO7vp4qwq9e0lpQSn7WhOrYIaQ8yKfsTI3ZPkycRU8cDcgSirkn/qMLnqr78+XBh4K
 7fBzQfHKybgVUPA+oMvKcxMleG2POcD2ajPd+pJb2LIsa5JPlNzcJYjqIctHAUrUz2tW5A
 vxZ0VwYSbeHxLjl1hUytGHylmmIF0Ek=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-uGtbkPv8Ns6YMhY2x-66BA-1; Thu, 23 Sep 2021 03:25:31 -0400
X-MC-Unique: uGtbkPv8Ns6YMhY2x-66BA-1
Received: by mail-wr1-f72.google.com with SMTP id
 f7-20020a5d50c7000000b0015e288741a4so4363620wrt.9
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 00:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=FvNkPyLF+1kcsTR6hdilBDqHZDnrfR2QQ6CleyZplLs=;
 b=TSkwNn0A/XC0M+HY53vXnI/MFDhSmU2/jZjlyayx/Mnk0diXsAUqbHFv1Jykwkebo0
 +TiZ3ckJfWmnxkggGgkmZzCzOIu7j8vN6e0O28ksjZiPncvwCIL4vx36aj7qlpynpk2V
 2px3Ezq9N3EzDAikK9yZzk14+IQ+61PdxRhso88KqO9TTWlIpylljaz84XQ0NVBKrItI
 e05RDXag9t2Tdm+pRFvk4h+3bycoyVhuppySB5fw+WrpOahRQzcH6yt6JZ85bwyPalF6
 KCl9hEk2DiEYyWpG1zB5E7P/UBO+G2iqROnDPHNOjODE9jxTL4ZrQYXOMVDvIlAmt+Zn
 AGOQ==
X-Gm-Message-State: AOAM530tPU10eFw9OZtz5b6ajr1xunNrs04lTPDAW6FUPfBL9MV6LshR
 u/7TQNXN9URHZXNIZ02xGv+WoUO6wazQadWKWjESKkHRiS/jzPoRvXUWUHF3E64qrH1989AhP4l
 sPWQfqWhYcT5C+yD4xvVQ93T8mSwj5A==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr3162711wru.243.1632381930664; 
 Thu, 23 Sep 2021 00:25:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGEfOyPkvpzZWpr9l9SkDYU2vwNuyGcQuSIPfvYxfPQ2pBpa+znyeIdD2Ff7pAnFgXSYPtrQ==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr3162668wru.243.1632381930433; 
 Thu, 23 Sep 2021 00:25:30 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id r9sm4325952wru.2.2021.09.23.00.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Sep 2021 00:25:29 -0700 (PDT)
Subject: Re: [RFC 03/20] vfio: Add vfio_[un]register_device()
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com>
 <20210921160108.GO327412@nvidia.com>
 <BN9PR11MB54330421CA825F5CAA44BAC98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922010014.GE327412@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <7d717ad0-fb9b-2af0-7818-147dc5d21373@redhat.com>
Date: Thu, 23 Sep 2021 09:25:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210922010014.GE327412@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
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

Hi,

On 9/22/21 3:00 AM, Jason Gunthorpe wrote:
> On Wed, Sep 22, 2021 at 12:54:02AM +0000, Tian, Kevin wrote:
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>> Sent: Wednesday, September 22, 2021 12:01 AM
>>>
>>>>  One open about how to organize the device nodes under
>>> /dev/vfio/devices/.
>>>> This RFC adopts a simple policy by keeping a flat layout with mixed
>>> devname
>>>> from all kinds of devices. The prerequisite of this model is that devnames
>>>> from different bus types are unique formats:
>>> This isn't reliable, the devname should just be vfio0, vfio1, etc
>>>
>>> The userspace can learn the correct major/minor by inspecting the
>>> sysfs.
>>>
>>> This whole concept should disappear into the prior patch that adds the
>>> struct device in the first place, and I think most of the code here
>>> can be deleted once the struct device is used properly.
>>>
>> Can you help elaborate above flow? This is one area where we need
>> more guidance.
>>
>> When Qemu accepts an option "-device vfio-pci,host=DDDD:BB:DD.F",
>> how does Qemu identify which vifo0/1/... is associated with the specified 
>> DDDD:BB:DD.F? 
> When done properly in the kernel the file:
>
> /sys/bus/pci/devices/DDDD:BB:DD.F/vfio/vfioX/dev
>
> Will contain the major:minor of the VFIO device.
>
> Userspace then opens the /dev/vfio/devices/vfioX and checks with fstat
> that the major:minor matches.
>
> in the above pattern "pci" and "DDDD:BB:DD.FF" are the arguments passed
> to qemu.
I guess this would be the same for platform devices, for instance
/sys/bus/platform/devices/AMDI8001:01/vfio/vfioX/dev, right?

Thanks

Eric
>
> You can look at this for some general over engineered code to handle
> opening from a sysfs handle like above:
>
> https://github.com/linux-rdma/rdma-core/blob/master/util/open_cdev.c
>
> Jason
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

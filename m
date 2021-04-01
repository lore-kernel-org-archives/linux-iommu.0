Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1859BC433ED
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 12:05:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B883661004
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 12:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B883661004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72D0B84A27;
	Thu,  1 Apr 2021 12:05:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zvVNWDJSQbwN; Thu,  1 Apr 2021 12:05:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 494A084A17;
	Thu,  1 Apr 2021 12:05:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A260C000D;
	Thu,  1 Apr 2021 12:05:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12E9CC000D
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 12:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5F2B60BB6
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 12:05:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5TzB_OE8sLK3 for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 12:05:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9DF0C606DB
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 12:05:20 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 r10-20020a05600c35cab029010c946c95easo771050wmq.4
 for <iommu@lists.linux-foundation.org>; Thu, 01 Apr 2021 05:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=VYLRwOTaWYW2z/hdkbfC5Hb+/bml3aFiLVAb7iH5y5U=;
 b=T5/EZgsNWYvWOQYgR1iqHUswyZyy/ySbnJl+K6AMxf53GW61QFhYWgQJGadYeU9aLg
 bPKC1laCu3/Ih0DCjVXgv1dGJ0uZTBGRg75RCrmrdwxatAAzAR/MajoHaiA8mNXuMiKb
 W98rgPel0JxE3vIjfE5Z/0Ud5sXoegvU55MZUrDfgbWuV+ST3HE9afJFEB49yIGk4vpi
 vIZAVgzScOJBo/yxQvP/GaRKKOto4df7lSqS6tRCj2KDrmxMGLF7Bj1KPg7H5JCjGWCf
 fbWE/CS2GIv8VcBwAmcWsOhOnxQU2234Q4saAAdEl9WUBzi2deDEOuHfMUoJfCvlVreb
 fq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VYLRwOTaWYW2z/hdkbfC5Hb+/bml3aFiLVAb7iH5y5U=;
 b=doKWyyHT6syDvmo3ru5FMn+STS8Al3Y0G/wiKVpdwWxnMOxj1nTxcavmMlX9JFOm76
 aGl21arROdv8hA2mHAZrCR7C0cOQKi3eWj8TPvAXWNmGfeeYHOKvWzxCjqBUxA1mHa2P
 6U31M4SUl46rBXoSTaLKjdAYQa/LaMq5H1L7gu1sBiKDZe1EEbEXPLmamPP8Tn4FMBI3
 zEy6Jux62huqUeLl1QVB4khfYG9bEPM6+dTux2x4w9hq0u3bAZWLQWjwNSdYJa5j+tEu
 gv8KC2cWh1rljbthLXB3jVG1oJFeM+dspwOJ2M455D2HQwQGjRm+m7y2rC2CDBSC/uGE
 Nn4g==
X-Gm-Message-State: AOAM5318kBMPcQEReQH3NembRd5s/gcYHahQjPM76HlSLBieiqbhnTls
 ugkwZE8e5+E9JygU5cW1/cB+aw==
X-Google-Smtp-Source: ABdhPJy0qG57PkM01e01Hu/6+A5S1r7E+S8pF/AryMmiCAAjTaPoWTsGUnnh6jY5cr49ITAArntJUg==
X-Received: by 2002:a7b:c38d:: with SMTP id s13mr7702836wmj.44.1617278718807; 
 Thu, 01 Apr 2021 05:05:18 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id o5sm9470674wrx.60.2021.04.01.05.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 05:05:18 -0700 (PDT)
Date: Thu, 1 Apr 2021 14:05:00 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YGW27KFt9eQB9X2z@myrica>
References: <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Thu, Apr 01, 2021 at 07:04:01AM +0000, Liu, Yi L wrote:
> > - how about AMD and ARM's vSVA support? Their PASID allocation and page
> > table
> >   happens within guest. They only need to bind the guest PASID table to
> > host.

In this case each VM has its own IOASID space, and the host IOASID
allocator doesn't participate. Plus this only makes sense when assigning a
whole VF to a guest, and VFIO is the tool for this. So I wouldn't shoehorn
those ops into /dev/ioasid, though we do need a transport for invalidate
commands.

> >   Above model seems unable to fit them. (Jean, Eric, Jacob please feel free
> >   to correct me)
> > - this per-ioasid SVA operations is not aligned with the native SVA usage
> >   model. Native SVA bind is per-device.

Bare-metal SVA doesn't need /dev/ioasid either. A program uses a device
handle to either ask whether SVA is enabled, or to enable it explicitly.
With or without /dev/ioasid, that step is required. OpenCL uses the first
method - automatically enable "fine-grain system SVM" if available, and
provide a flag to userspace.

So userspace does not need to know about PASID. It's only one method for
doing SVA (some GPUs are context-switching page tables instead).

> After reading your reply in https://lore.kernel.org/linux-iommu/20210331123801.GD1463678@nvidia.com/#t
> So you mean /dev/ioasid FD is per-VM instead of per-ioasid, so above skeleton
> doesn't suit your idea. I draft below skeleton to see if our mind is the
> same. But I still believe there is an open on how to fit ARM and AMD's
> vSVA support in this the per-ioasid SVA operation model. thoughts?
> 
> +-----------------------------+-----------------------------------------------+
> |      userspace              |               kernel space                    |
> +-----------------------------+-----------------------------------------------+
> | ioasid_fd =                 | /dev/ioasid does below:                       |
> | open("/dev/ioasid", O_RDWR);|   struct ioasid_fd_ctx {                      |
> |                             |       struct list_head ioasid_list;           |
> |                             |       ...                                     |
> |                             |   } ifd_ctx; // ifd_ctx is per ioasid_fd      |
> +-----------------------------+-----------------------------------------------+
> | ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
> |       ALLOC, &ioasid);      |   struct ioasid_data {                        |
> |                             |       ioasid_t ioasid;                        |
> |                             |       struct list_head device_list;           |
> |                             |       struct list_head next;                  |
> |                             |       ...                                     |
> |                             |   } id_data; // id_data is per ioasid         |
> |                             |                                               |
> |                             |   list_add(&id_data.next,                     |
> |                             |            &ifd_ctx.ioasid_list);             |
> +-----------------------------+-----------------------------------------------+
> | ioctl(device_fd,            | VFIO does below:                              |
> |       DEVICE_ALLOW_IOASID,  | 1) get ioasid_fd, check if ioasid_fd is valid |
> |       ioasid_fd,            | 2) check if ioasid is allocated from ioasid_fd|
> |       ioasid);              | 3) register device/domain info to /dev/ioasid |
> |                             |    tracked in id_data.device_list             |
> |                             | 4) record the ioasid in VFIO's per-device     |
> |                             |    ioasid list for future security check      |
> +-----------------------------+-----------------------------------------------+
> | ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
> |       BIND_PGTBL,           | 1) find ioasid's id_data                      |
> |       pgtbl_data,           | 2) loop the id_data.device_list and tell iommu|
> |       ioasid);              |    give ioasid access to the devices          |
> +-----------------------------+-----------------------------------------------+
> | ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
> |       UNBIND_PGTBL,         | 1) find ioasid's id_data                      |
> |       ioasid);              | 2) loop the id_data.device_list and tell iommu|
> |                             |    clear ioasid access to the devices         |
> +-----------------------------+-----------------------------------------------+
> | ioctl(device_fd,            | VFIO does below:                              |
> |      DEVICE_DISALLOW_IOASID,| 1) check if ioasid is associated in VFIO's    |
> |       ioasid_fd,            |    device ioasid list.                        |
> |       ioasid);              | 2) unregister device/domain info from         |
> |                             |    /dev/ioasid, clear in id_data.device_list  |
> +-----------------------------+-----------------------------------------------+
> | ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
> |       FREE, ioasid);        |  list_del(&id_data.next);                     |
> +-----------------------------+-----------------------------------------------+


Also wondering about:

* Querying IOMMU nesting capabilities before binding page tables (which
  page table formats are supported?). We were planning to have a VFIO cap,
  but I'm guessing we need to go back to the sysfs solution?

* Invalidation, probably an ioasid_fd ioctl?

* Page faults, page response. From and to devices, and don't necessarily
  have a PASID. But needed by vdpa as well, so that's also going through
  /dev/ioasid?

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

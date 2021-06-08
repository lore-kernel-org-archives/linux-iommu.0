Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EAFC47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 00:30:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6B260FDA
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 00:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6B260FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61945403EE;
	Tue,  8 Jun 2021 00:30:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qCfX99WPLgIi; Tue,  8 Jun 2021 00:30:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1F4E403D0;
	Tue,  8 Jun 2021 00:30:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89796C000D;
	Tue,  8 Jun 2021 00:30:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84482C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 00:30:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 696AB403D0
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 00:30:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z-mZgqA4156d for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 00:30:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5CC0640393
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 00:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623112239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qRFthXhnfNdpVeZQpXUHrCiK/YuVLkK7snUpJsmtFSw=;
 b=cfWWTzpfzq4DrKqIpjvmyoOT0vQcC8HUwhCMMGdLJRKdDoLr15r0Mn9PczYcAEYvGfr73e
 vip1ofRLFjxu9vOS1mzIVyPi8fUFT8J7GIZnldM5pk1jJOHy+r2vN0DEb23ly4K3dlH/x6
 ridJkLHt8yNzHXpJz18rhqHQPimfAOA=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-emqTqn9ZOcKiyHhGEoebWg-1; Mon, 07 Jun 2021 20:30:38 -0400
X-MC-Unique: emqTqn9ZOcKiyHhGEoebWg-1
Received: by mail-ot1-f69.google.com with SMTP id
 59-20020a9d0dc10000b02902a57e382ca1so12679870ots.7
 for <iommu@lists.linux-foundation.org>; Mon, 07 Jun 2021 17:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=qRFthXhnfNdpVeZQpXUHrCiK/YuVLkK7snUpJsmtFSw=;
 b=jh+i4+ksFGw+P5j/vcTBJcoP5dv3RQignQqvsKJ3ZIMq9h6WbdSXynB1YMPY7oFSmr
 61bhucn6g+dAcjSteW6xxKrxQ4ca3B/GcjUErmdue5oSOqGNSvbA+DeR4Ui7jqhOjWu+
 FfZyjOBe+ZTYEzufudR3reJUDvNOrj5xa7HwP5jKumA7O8I7qvzYXiu5LDP3nzF/GQGg
 dDruXo/ftBfybChCbrBwvgLQQ/S6Tj55A1T7xj6iXIhdZbTmNAAbx0m9h4t5OTD3VHH0
 qqeBE/TIB5dF6aZJTrXj+mNvLrrOHyvKjKqYiBkJz+lw0zYz+Wgidr4Ogw/vT98LvAYv
 +fSw==
X-Gm-Message-State: AOAM5319F+PA2mmIT7tRtRYsd94c6YwYjREt2RmkXr12mgyn8EJD+YrA
 HHjIoaZwgJhde9sPqOLZaNYfK1MjU8LdQORycz83f3BYRcBgNvM6c/VDuhUXzk/ONyMw0FsxzAq
 Xx6J7eB0yiJewzpSBdb7CBQNM6FbIQw==
X-Received: by 2002:a4a:d4c7:: with SMTP id r7mr15457999oos.85.1623112236844; 
 Mon, 07 Jun 2021 17:30:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4eei97hBgAKcdGsumzHAwD9jcuRq8Dyz7XrNXw9xxI85L9wd4TC3u+DkEQiYQaWLvp82kXg==
X-Received: by 2002:a4a:d4c7:: with SMTP id r7mr15457984oos.85.1623112236604; 
 Mon, 07 Jun 2021 17:30:36 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id v22sm2561303oic.37.2021.06.07.17.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jun 2021 17:30:36 -0700 (PDT)
Date: Mon, 7 Jun 2021 18:30:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210607183034.7665cf02.alex.williamson@redhat.com>
In-Reply-To: <20210607230353.GR1002214@nvidia.com>
References: <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <20210604152918.57d0d369.alex.williamson@redhat.com>
 <20210604230108.GB1002214@nvidia.com>
 <20210607094148.7e2341fc.alex.williamson@redhat.com>
 <20210607181858.GM1002214@nvidia.com>
 <20210607125946.056aafa2.alex.williamson@redhat.com>
 <20210607190802.GO1002214@nvidia.com>
 <20210607134128.58c2ea31.alex.williamson@redhat.com>
 <20210607230353.GR1002214@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, 7 Jun 2021 20:03:53 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Jun 07, 2021 at 01:41:28PM -0600, Alex Williamson wrote:
> 
> > > Compatibility is important, but when I look in the kernel code I see
> > > very few places that call wbinvd(). Basically all DRM for something
> > > relavent to qemu.
> > > 
> > > That tells me that the vast majority of PCI devices do not generate
> > > no-snoop traffic.  
> > 
> > Unfortunately, even just looking at devices across a couple laptops
> > most devices do support and have NoSnoop+ set by default.    
> 
> Yes, mine too, but that doesn't mean the device is issuing nosnoop
> transactions, it just means the OS is allowing it to do so if it wants.
> 
> As I said, without driver support the feature cannot be used, and
> there is no driver support in Linux outside DRM, unless it is
> hidden.. Certainly I've never run into it..
> 
> Even mlx5 is setting the nosnoop bit, but I have a fairly high
> confidence that we don't set the TLP bit for anything Linux does.
> 
> > It's not safe for QEMU to make an assumption that only GPUs will
> > actually make use of it.  
> 
> Not 100% safe, but if you know you are running Linux OS in the VM you
> can look at the drivers the devices need and make a determination.

QEMU doesn't know what guest it's running or what driver the guest is
using.  QEMU can only create safe configurations by default, the same
as done now using vfio.  Anything outside of that scope would require
experimental opt-in support by the user or a guarantee from the device
vendor that the device cannot ever (not just for the existing drivers)
create non-coherent TLPs. Thanks,

Alex

> > Yes, QEMU can reject a hot-unplug event, but then QEMU retains the
> > privilege that the device grants it.  Releasing the device and
> > retaining the privileged gained by it seems wrong.  Thanks,  
> 
> It is not completely ideal, but it is such a simplification, and I
> can't really see a drawback..
> 
> Jason
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

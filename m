Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A11BC48BDF
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 15:52:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC18C61245
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 15:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC18C61245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BF3E83CEB;
	Fri, 18 Jun 2021 15:52:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TG121PhLuEsW; Fri, 18 Jun 2021 15:52:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 67C1D83CEF;
	Fri, 18 Jun 2021 15:52:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4215FC0022;
	Fri, 18 Jun 2021 15:52:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06CEDC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 15:52:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 494E583CEE
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 15:52:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5mV2sKH93RjP for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 15:52:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 897D583CEF
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 15:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624031521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2JEl/D8fElGUs5qE1bIG8tGOHlH8JDuVtFpyPtPAcRM=;
 b=JEFPYe7eYkoNs0u1MF2VlyQ3u0ZtH+8Qz6FK7E9IFj6Vf7dGULakGJI49asSHs8uJYouXW
 fj/L9iteQXMWKHhQpcCPk598sJhvzbcCGhi1cXXZzt8CHX72ZI68u3vjlBC780B7frsuI1
 /TiZlB75ke9C+cwaQnw2Iwq/FM/U0LQ=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-iDFWJIjIPIePFMqG1KChIA-1; Fri, 18 Jun 2021 11:52:00 -0400
X-MC-Unique: iDFWJIjIPIePFMqG1KChIA-1
Received: by mail-il1-f198.google.com with SMTP id
 w14-20020a92c88e0000b02901edfbb11919so6070169ilo.10
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 08:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=2JEl/D8fElGUs5qE1bIG8tGOHlH8JDuVtFpyPtPAcRM=;
 b=QMIWcabYagOAu3kZum8X5m+NZwFHS6HFwHXGN0MswYlMissNLyOoIlLAsmeGA8KWCX
 a6fz+2RKfcS3h7MMaRCcVUrq9TEccKGuekA2vrjyvHNrVjz/uNyLHnV7xanO6FKgyPo4
 WOJYdLv7mwQ6kPA9fDD5bKpz+Tg7slP1biNJ4TYZMo/LlbkLwym4FKqs+N/TqTaKUhu1
 BF9nAKmfujm02OB/c+NK/5fzVQ+aWAY2QRx56XgsNr55j8vXodbDFSs+XL6ydhrBPg0d
 ZMiwdkzOMuE2SJEx0e/TgsR+KQpebeeTwv6t5h38rRojdRVa2TFhhCa2P/LvePNHjqxi
 Br7g==
X-Gm-Message-State: AOAM533ZbHPEctlnrP0cLck+et5ZDPLEmVzfzq0e3AvQpvL3xmeUyMlj
 6dn1jv39Y4fKMs2uPO1JnssqVzCmWy5lX8o88BontO8fmIROSTJd+2p9/UPbyHhSvVJwpenirFN
 Kqdvhf3GyOjcO4lfqkO3tpoq56w00VQ==
X-Received: by 2002:a05:6e02:1383:: with SMTP id
 d3mr6838009ilo.172.1624031519707; 
 Fri, 18 Jun 2021 08:51:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyba3VKvMFyZqbrNjMBnKEoGABQfH7jzv5PsLUxAyjyr9uMPZs6fX5eNRt3vqIMNQW+GtEqg==
X-Received: by 2002:a05:6e02:1383:: with SMTP id
 d3mr6837986ilo.172.1624031519497; 
 Fri, 18 Jun 2021 08:51:59 -0700 (PDT)
Received: from redhat.com (c-73-14-100-188.hsd1.co.comcast.net.
 [73.14.100.188])
 by smtp.gmail.com with ESMTPSA id y13sm4516131ioa.51.2021.06.18.08.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 08:51:59 -0700 (PDT)
Date: Fri, 18 Jun 2021 09:51:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <20210618095157.131eb309.alex.williamson@redhat.com>
In-Reply-To: <20210618153735.GA37688@otc-nc-03>
References: <20210612105711.7ac68c83.alex.williamson@redhat.com>
 <20210614140711.GI1002214@nvidia.com>
 <20210614102814.43ada8df.alex.williamson@redhat.com>
 <MWHPR11MB1886239C82D6B66A732830B88C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615101215.4ba67c86.alex.williamson@redhat.com>
 <MWHPR11MB188692A6182B1292FADB3BDB8C0F9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210616133937.59050e1a.alex.williamson@redhat.com>
 <MWHPR11MB18865DF9C50F295820D038798C0E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YMykBzUHmATPbmdV@8bytes.org> <20210618151506.GG1002214@nvidia.com>
 <20210618153735.GA37688@otc-nc-03>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@nvidia.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "parav@mellanox.com" <parav@mellanox.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

On Fri, 18 Jun 2021 08:37:35 -0700
"Raj, Ashok" <ashok.raj@intel.com> wrote:

> On Fri, Jun 18, 2021 at 12:15:06PM -0300, Jason Gunthorpe wrote:
> > On Fri, Jun 18, 2021 at 03:47:51PM +0200, Joerg Roedel wrote:  
> > > Hi Kevin,
> > > 
> > > On Thu, Jun 17, 2021 at 07:31:03AM +0000, Tian, Kevin wrote:  
> > > > Now let's talk about the new IOMMU behavior:
> > > > 
> > > > -   A device is blocked from doing DMA to any resource outside of
> > > >     its group when it's probed by the IOMMU driver. This could be a
> > > >     special state w/o attaching to any domain, or a new special domain
> > > >     type which differentiates it from existing domain types (identity, 
> > > >     dma, or unmanged). Actually existing code already includes a
> > > >     IOMMU_DOMAIN_BLOCKED type but nobody uses it.  
> > > 
> > > There is a reason for the default domain to exist: Devices which require
> > > RMRR mappings to be present. You can't just block all DMA from devices
> > > until a driver takes over, we put much effort into making sure there is
> > > not even a small window in time where RMRR regions (unity mapped regions
> > > on AMD) are not mapped.  
> > 
> > Yes, I think the DMA blocking can only start around/after a VFIO type
> > driver has probed() and bound to a device in the group, not much
> > different from today.  
> 
> Does this mean when a device has a required "RMRR" that requires a unity
> mapping we block assigning those devices to guests? I remember we had some
> restriction but there was a need to go around it at some point in time.
> 
> - Either we disallow assigning devices with RMRR
> - Break that unity map when the device is probed and after which any RMRR
>   access from device will fault.

We currently disallow assignment of RMRR encumbered devices except for
the known cases of USB and IGD.  In the general case, an RMRR imposes
a requirement on the host system to maintain ranges of identity mapping
that is incompatible with userspace ownership of the device and IOVA
address space.  AFAICT, nothing changes in the /dev/iommu model that
would make it safe to entrust userspace with RMRR encumbered devices.
Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

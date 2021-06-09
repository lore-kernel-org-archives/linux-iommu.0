Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8009FC48BCD
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 16:15:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DCD610A2
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 16:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DCD610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E364540187;
	Wed,  9 Jun 2021 16:15:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UPnBePSauOu7; Wed,  9 Jun 2021 16:15:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CDE01401E9;
	Wed,  9 Jun 2021 16:15:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAB40C000D;
	Wed,  9 Jun 2021 16:15:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82236C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 16:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F9A8605FB
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 16:15:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hp2tQU8XSFCI for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 16:15:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C1406059F
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 16:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623255339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKvRJP1Qn2FuRIKKae+xpipPvYviXO+rudBhyvwgw04=;
 b=FuD6yEWNMgy5KrBMn6UbrHl09tce9ajQ3R6jyLO5HS9J93hOIvzd+N7wJ6zFFEgScpzZii
 yrDmFGkEZ05n5CVcegmQ56irwoj2Sp63LFEtHT1DoFHY9zAHRj8ThGhJDRU3kWLrnP5zEu
 V3gxx//hRKH/xqdWRlEoPaiM0ux9ycc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-6Pf3f7GTNCWjVltWe1Z_5Q-1; Wed, 09 Jun 2021 12:15:35 -0400
X-MC-Unique: 6Pf3f7GTNCWjVltWe1Z_5Q-1
Received: by mail-ot1-f69.google.com with SMTP id
 108-20020a9d0bf50000b02903d55be6ada3so13308941oth.22
 for <iommu@lists.linux-foundation.org>; Wed, 09 Jun 2021 09:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=ZKvRJP1Qn2FuRIKKae+xpipPvYviXO+rudBhyvwgw04=;
 b=WbChwW1NQBzHhpLFQw3OO1RDJz3ejau/Y5GKECbm7VkKlFgKf8yBjFlDYSeojPxIVU
 0QsQQGKKSftMbrWsHQZnWvLF0ADudqfQ4eze8+OIeX6YaKNSkaNWgYom67S+wbzRlND/
 bCPP8e8QBzbO1wSHDwmgsvRaeK6NAdeg0vgOuUiRCuVH8BPHkz2kU/SB8BqaSazZSjZU
 m5yeCOMhxicJb+L5OpMrT5fb9EMIjBGL/+cAU66d4S+pbgojhBu7GcxB5Js19NW0axnU
 wj/ID7bUDv1glFo7gML9K579ZjkLSEC3Zvnvn436CK6+KYN6Q5hKykDSw+ViGdZa0fzn
 fAWg==
X-Gm-Message-State: AOAM533x6a3N+uCGAbTi9X4sM8YGhUN8bNXkrPNrQUC2rhAUGycis0zH
 M+XXi6K1UmvvOyPXk/oqjbURxfnGqQUmEibA4s6LfYH53+WH33zv6lbCxVjQ8AC6hnao8IGbSt6
 Fo8YgrsgQmrrDKgAMQBnXf1YIt+vWag==
X-Received: by 2002:a9d:6042:: with SMTP id v2mr179324otj.170.1623255335012;
 Wed, 09 Jun 2021 09:15:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYk1fCbBjXzJvcPumlKeytJWmAtK0sJebJhCUtHFNxQQubDFY1axQko6MBR1VcZ3NidsA9KA==
X-Received: by 2002:a9d:6042:: with SMTP id v2mr179287otj.170.1623255334638;
 Wed, 09 Jun 2021 09:15:34 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id x9sm76559oto.79.2021.06.09.09.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jun 2021 09:15:34 -0700 (PDT)
Date: Wed, 9 Jun 2021 10:15:32 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <20210609101532.452851eb.alex.williamson@redhat.com>
In-Reply-To: <YMDjfmJKUDSrbZbo@8bytes.org>
References: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YMCy48Xnt/aphfh3@8bytes.org> <20210609123919.GA1002214@nvidia.com>
 <YMDC8tOMvw4FtSek@8bytes.org> <20210609150009.GE1002214@nvidia.com>
 <YMDjfmJKUDSrbZbo@8bytes.org>
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
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "parav@mellanox.com" <parav@mellanox.com>,
 "Enrico Weigelt, metux IT
 consult" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
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

On Wed, 9 Jun 2021 17:51:26 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> On Wed, Jun 09, 2021 at 12:00:09PM -0300, Jason Gunthorpe wrote:
> > Only *drivers* know what the actual device is going to do, devices do
> > not. Since the group doesn't have drivers it is the wrong layer to be
> > making choices about how to configure the IOMMU.  
> 
> Groups don't carry how to configure IOMMUs, that information is
> mostly in the IOMMU domains. And those (or an abstraction of them) is
> configured through /dev/ioasid. So not sure what you wanted to say with
> the above.
> 
> All a group carries is information about which devices are not
> sufficiently isolated from each other and thus need to always be in the
> same domain.
> 
> > The device centric approach is my attempt at this, and it is pretty
> > clean, I think.  
> 
> Clean, but still insecure.
> 
> > All ACS does is prevent P2P operations, if you assign all the group
> > devices into the same /dev/iommu then you may not care about that
> > security isolation property. At the very least it is policy for user
> > to decide, not kernel.  
> 
> It is a kernel decision, because a fundamental task of the kernel is to
> ensure isolation between user-space tasks as good as it can. And if a
> device assigned to one task can interfer with a device of another task
> (e.g. by sending P2P messages), then the promise of isolation is broken.

AIUI, the IOASID model will still enforce IOMMU groups, but it's not an
explicit part of the interface like it is for vfio.  For example the
IOASID model allows attaching individual devices such that we have
granularity to create per device IOASIDs, but all devices within an
IOMMU group are required to be attached to an IOASID before they can be
used.  It's not entirely clear to me yet how that last bit gets
implemented though, ie. what barrier is in place to prevent device
usage prior to reaching this viable state.

> > Groups should be primarily about isolation security, not about IOASID
> > matching.  
> 
> That doesn't make any sense, what do you mean by 'IOASID matching'?

One of the problems with the vfio interface use of groups is that we
conflate the IOMMU group for both isolation and granularity.  I think
what Jason is referring to here is that we still want groups to be the
basis of isolation, but we don't want a uAPI that presumes all devices
within the group must use the same IOASID.  For example, if a user owns
an IOMMU group consisting of non-isolated functions of a multi-function
device, they should be able to create a vIOMMU VM where each of those
functions has its own address space.  That can't be done today, the
entire group would need to be attached to the VM under a PCIe-to-PCI
bridge to reflect the address space limitation imposed by the vfio
group uAPI model.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=Ewjr=LG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4B2C48BE8
	for <iommu@archiver.kernel.org>; Sat, 12 Jun 2021 16:57:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CA6611CB
	for <iommu@archiver.kernel.org>; Sat, 12 Jun 2021 16:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CA6611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 412C5401D6;
	Sat, 12 Jun 2021 16:57:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y3hmROdutITj; Sat, 12 Jun 2021 16:57:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F31CD4017A;
	Sat, 12 Jun 2021 16:57:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC4D2C000E;
	Sat, 12 Jun 2021 16:57:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23A55C000B
 for <iommu@lists.linux-foundation.org>; Sat, 12 Jun 2021 16:57:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF8F940185
 for <iommu@lists.linux-foundation.org>; Sat, 12 Jun 2021 16:57:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EqIAUBBDJ41d for <iommu@lists.linux-foundation.org>;
 Sat, 12 Jun 2021 16:57:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D69AC4017A
 for <iommu@lists.linux-foundation.org>; Sat, 12 Jun 2021 16:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623517037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shhxkeyT6sH5lJV4f12+U24GPPhn47S3juDgxTTkERI=;
 b=aoatqcD4IDqiQcGVyVmhTcM+WDiodee0qJYFOG7Rv5p8ecN/eVoyGesLMnuMmaOLOQ55dU
 sZPwopSQ+Ee4oCUVWv+ZRyiTOyCj8AEg2eB32r+pEH9/e+yBbQRoVk/KcAeBqe4RczRerD
 9B16zWSewqfq/LOKc64/DevlaFE2b/Q=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-pGEVv7l_MZCwDzIcGVi_VA-1; Sat, 12 Jun 2021 12:57:16 -0400
X-MC-Unique: pGEVv7l_MZCwDzIcGVi_VA-1
Received: by mail-oo1-f72.google.com with SMTP id
 r17-20020a4a96510000b029024988968d95so3997982ooi.2
 for <iommu@lists.linux-foundation.org>; Sat, 12 Jun 2021 09:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=shhxkeyT6sH5lJV4f12+U24GPPhn47S3juDgxTTkERI=;
 b=IZQwPXQ6l0c6bQx19OZ6zyxR8D+R4/GOXVdKJeVMnfHqfdV863nTZ48GygzfWEcBn9
 qk9Wof4UX2WfoijR6Ypvj6SyTycfUt8GzVyokm4/Q230LH3Mo0fk+KWqXHIUDAKEDJoF
 rzZ2KsxI4JuZRsAN83A9wLTLlIMHSNUd9N0Xh+hhKqNKirkIkD0YNIg2JqvrpZntL68F
 SOairtp19pLrDFfbHIZPCL9rtA7Ps7QJYtahZ0ttxX6zzp/9ESGWZDWPQvqkHEAXdWY+
 SV9e2CQtiZXiCN5uOhB1yWDrzh2OLg+oYcMs6FKNMNedDPFkIDnl2EreBrMJg52nZoNN
 ryrA==
X-Gm-Message-State: AOAM531rWT1q+cFLuE3xfOfzcPHy0OQSrRuMZqwk28UX7N94QWEjkhy/
 9v80awjV/w5q0aFc94P4VAzYgKunUdNXRMXhGnGcT9xkjBRPvuO+LL9R9DmcDuq18AHtDCohXZy
 nLsukd2puF6oF0XAzHhX+DEpyHrndyQ==
X-Received: by 2002:a9d:7a55:: with SMTP id z21mr7445177otm.207.1623517035264; 
 Sat, 12 Jun 2021 09:57:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuTiKSVBxMD+ahZaJ1En1PUkcexZpbiOJtftxlXbhzmxQW4kNWjPJHfTiwexjJMeyyHeq+vg==
X-Received: by 2002:a9d:7a55:: with SMTP id z21mr7445167otm.207.1623517034995; 
 Sat, 12 Jun 2021 09:57:14 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id z5sm441638oth.6.2021.06.12.09.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Jun 2021 09:57:14 -0700 (PDT)
Date: Sat, 12 Jun 2021 10:57:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <20210612105711.7ac68c83.alex.williamson@redhat.com>
In-Reply-To: <20210612012846.GC1002214@nvidia.com>
References: <20210609123919.GA1002214@nvidia.com> <YMDC8tOMvw4FtSek@8bytes.org>
 <20210609150009.GE1002214@nvidia.com> <YMDjfmJKUDSrbZbo@8bytes.org>
 <20210609101532.452851eb.alex.williamson@redhat.com>
 <20210609102722.5abf62e1.alex.williamson@redhat.com>
 <20210609184940.GH1002214@nvidia.com>
 <20210610093842.6b9a4e5b.alex.williamson@redhat.com>
 <20210611164529.GR1002214@nvidia.com>
 <20210611133828.6c6e8b29.alex.williamson@redhat.com>
 <20210612012846.GC1002214@nvidia.com>
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
 Jonathan Corbet <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>, "Enrico Weigelt, metux IT
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

On Fri, 11 Jun 2021 22:28:46 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Jun 11, 2021 at 01:38:28PM -0600, Alex Williamson wrote:
> 
> > That's fine for a serial port, but not a device that can do DMA.
> > The entire point of vfio is to try to provide secure, DMA capable
> > userspace drivers.  If we relax enforcement of that isolation we've
> > failed.  
> 
> I don't understand why the IOASID matters at all in this. Can you
> explain? What is the breach of isolation?

I think we're arguing past each other again.  VFIO does not care one
iota how userspace configures IOASID domains for devices.  OTOH, VFIO
must be absolutely obsessed that the devices we're providing userspace
access to are isolated and continue to be isolated for the extent of
that access.  Given that we define that a group is the smallest set of
devices that can be isolated, that means that for a device to be
isolated, the group needs to be isolated.

VFIO currently has a contract with the IOMMU backend that a group is
attached to an IOMMU context (container) and from that point forward,
all devices within that group are known to be isolated.

I'm trying to figure out how a device based interface to the IOASID can
provide that same contract or whether VFIO needs to be able to monitor
the IOASID attachments of the devices in a group to control whether
device access is secure.

As I outlined to Kevin, I think it makes a lot of sense to maintain a
group interface to the IOASID where registering a group signifies a
hand-off of responsibility to the IOASIDfd that it is responsible for
the isolation of those devices.  From there we can determine the value
of exposing VFIO device fds directly and whether any of the VFIO
interfaces for attaching devices to IOASIDs make sense versus switching
to the IOASIDfd at that point.

Otherwise, for a device centric VFIO/IOASID model, I need to understand
exactly when and how VFIO can know that it's safe to provide access to
a device and how the IOASID model guarantees the ongoing safety of that
access, which must encompass the safety relative to the entire group.

For example, is it VFIO's job to BIND every device in the group?  Does
binding the device represent the point at which the IOASID takes
responsibility for the isolation of the device?  If instead it's the
ATTACH of a device that provides the isolation, how is VFIO supposed to
handle device access across a group when one device is DETACH'd by the
user?  If ATTACH is the point where isolation is guaranteed, can a
DETACH occur through the IOASIDfd rather than the VFIOfd?  It seems
like the IOASIDfd is going to need ways to manipulate device:IOASID
mappings outside of VFIO, so again I wonder if we should switch to an
IOASID uAPI at that point rather than using VFIO.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

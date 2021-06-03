Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F021C4708F
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 02:51:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C68F613E6
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 02:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C68F613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D05F483E05;
	Thu,  3 Jun 2021 02:51:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id By7Cc7tdAYOg; Thu,  3 Jun 2021 02:51:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id E760083E01;
	Thu,  3 Jun 2021 02:51:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE017C000E;
	Thu,  3 Jun 2021 02:51:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85844C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 02:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 719C54057F
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 02:51:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qi_DylW75RiT for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 02:51:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B5624057E
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 02:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622688661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axWy42FNcYCinIuczFvW033N1IzY7BuvZJoBLU9MXh0=;
 b=jRs8XOughcXjUtl1jobal6W/rOxJPf96F9netdeWFZtm4qNqNx3NTdTdGKRRnX2HfrkU4Q
 HQ1gc7iXXwHoxW92zmXIRuqtxzATAlVsMA1ou6ZYJ/sGoXFCZBGiwBz6ZZfrxqKEx1Ah4+
 MInLM0hrK1nWmhSQnHx6mJnebfYb4zw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-VwaRfV1uMHqJj9BOUQk92A-1; Wed, 02 Jun 2021 22:50:57 -0400
X-MC-Unique: VwaRfV1uMHqJj9BOUQk92A-1
Received: by mail-oi1-f198.google.com with SMTP id
 12-20020aca120c0000b02901e9c963da89so2279177ois.5
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 19:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=axWy42FNcYCinIuczFvW033N1IzY7BuvZJoBLU9MXh0=;
 b=MXD/C8+Kt/Shov2mY7jmIijV/yyJX0QAsbxwjosA7WskM+NzYPW9f9ygtt+aHFTDyx
 Gkvtm1QRZWovagMKzRZ5xglk3Qe6C+ZIJweyhavBAfpnZrBmpppqwigN/Tr52iv8CuPt
 mbzXCijT1cQlP4v8BmM6e1lGq7xRN6rcoKU7rJFiFcQB45PVS85EtsTxWoWb+LjwJubw
 KdhyXciGgMo5ocOdFs7YD1H1Kd+LHDD2HpLUxtwGXEFusIgYkYbuGNrNQvC+3vC9GXfo
 mh/UY69HR98vqxKD3Qe+qd0X24dtmynWlMzJxGwY0lLUmkGTIFvmtZwSVQQFRcHbcKYL
 oitw==
X-Gm-Message-State: AOAM533eF6TrWIyKVS2ZlYAoNSH9TZsZ2T/s7Gh0HjHipoca6Tk/5BhK
 YIWzb+vymYnISGI9unPDVr45cnCr6eJVKefhzLCgXGjeqVANZgJSRxziQVS5jxg2aI5/QP3I78q
 rGU4qEtWJnA5eig1xcUA1dCVElmX88Q==
X-Received: by 2002:a05:6830:1d0:: with SMTP id
 r16mr4027074ota.116.1622688656870; 
 Wed, 02 Jun 2021 19:50:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuwJmm05loclZmkVCVWQVnwxKgIEoGf6EmbF0Iu9rFnz/PZ9y74D9ApsDmv+T7LVn7CtVHPQ==
X-Received: by 2002:a05:6830:1d0:: with SMTP id
 r16mr4027052ota.116.1622688656589; 
 Wed, 02 Jun 2021 19:50:56 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id l1sm378451oos.37.2021.06.02.19.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 19:50:56 -0700 (PDT)
Date: Wed, 2 Jun 2021 20:50:54 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210602205054.3505c9c3.alex.williamson@redhat.com>
In-Reply-To: <20210602224536.GJ1002214@nvidia.com>
References: <20210601162225.259923bc.alex.williamson@redhat.com>
 <MWHPR11MB1886E8454A58661DC2CDBA678C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210602160140.GV1002214@nvidia.com>
 <20210602111117.026d4a26.alex.williamson@redhat.com>
 <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <20210602224536.GJ1002214@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
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
 Robin Murphy <robin.murphy@arm.com>,
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

On Wed, 2 Jun 2021 19:45:36 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jun 02, 2021 at 02:37:34PM -0600, Alex Williamson wrote:
> 
> > Right.  I don't follow where you're jumping to relaying DMA_PTE_SNP
> > from the guest page table... what page table?    
> 
> I see my confusion now, the phrasing in your earlier remark led me
> think this was about allowing the no-snoop performance enhancement in
> some restricted way.
> 
> It is really about blocking no-snoop 100% of the time and then
> disabling the dangerous wbinvd when the block is successful.
> 
> Didn't closely read the kvm code :\
> 
> If it was about allowing the optimization then I'd expect the guest to
> enable no-snoopable regions via it's vIOMMU and realize them to the
> hypervisor and plumb the whole thing through. Hence my remark about
> the guest page tables..
> 
> So really the test is just 'were we able to block it' ?

Yup.  Do we really still consider that there's some performance benefit
to be had by enabling a device to use no-snoop?  This seems largely a
legacy thing.

> > This support existed before mdev, IIRC we needed it for direct
> > assignment of NVIDIA GPUs.  
> 
> Probably because they ignored the disable no-snoop bits in the control
> block, or reset them in some insane way to "fix" broken bioses and
> kept using it even though by all rights qemu would have tried hard to
> turn it off via the config space. Processing no-snoop without a
> working wbinvd would be fatal. Yeesh
> 
> But Ok, back the /dev/ioasid. This answers a few lingering questions I
> had..
> 
> 1) Mixing IOMMU_CAP_CACHE_COHERENCY and !IOMMU_CAP_CACHE_COHERENCY
>    domains.
> 
>    This doesn't actually matter. If you mix them together then kvm
>    will turn on wbinvd anyhow, so we don't need to use the DMA_PTE_SNP
>    anywhere in this VM.
> 
>    This if two IOMMU's are joined together into a single /dev/ioasid
>    then we can just make them both pretend to be
>    !IOMMU_CAP_CACHE_COHERENCY and both not set IOMMU_CACHE.

Yes and no.  Yes, if any domain is !IOMMU_CAP_CACHE_COHERENCY then we
need to emulate wbinvd, but no we'll use IOMMU_CACHE any time it's
available based on the per domain support available.  That gives us the
most consistent behavior, ie. we don't have VMs emulating wbinvd
because they used to have a device attached where the domain required
it and we can't atomically remap with new flags to perform the same as
a VM that never had that device attached in the first place.

> 2) How to fit this part of kvm in some new /dev/ioasid world
> 
>    What we want to do here is iterate over every ioasid associated
>    with the group fd that is passed into kvm.

Yeah, we need some better names, binding a device to an ioasid (fd) but
then attaching a device to an allocated ioasid (non-fd)... I assume
you're talking about the latter ioasid.

>    Today the group fd has a single container which specifies the
>    single ioasid so this is being done trivially.
> 
>    To reorg we want to get the ioasid from the device not the
>    group (see my note to David about the groups vs device rational)
> 
>    This is just iterating over each vfio_device in the group and
>    querying the ioasid it is using.

The IOMMU API group interfaces is largely iommu_group_for_each_dev()
anyway, we still need to account for all the RIDs and aliases of a
group.

>    Or perhaps more directly: an op attaching the vfio_device to the
>    kvm and having some simple helper 
>          '(un)register ioasid with kvm (kvm, ioasid)'
>    that the vfio_device driver can call that just sorts this out.

We could almost eliminate the device notion altogether here, use an
ioasidfd_for_each_ioasid() but we really want a way to trigger on each
change to the composition of the device set for the ioasid, which is
why we currently do it on addition or removal of a group, where the
group has a consistent set of IOMMU properties.  Register a notifier
callback via the ioasidfd?  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

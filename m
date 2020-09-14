Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF848C43461
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 16:59:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3735420719
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 16:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFyjJX9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3735420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C602220401;
	Mon, 14 Sep 2020 16:59:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uIyjzpTC+Xmg; Mon, 14 Sep 2020 16:59:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E2E5A203B8;
	Mon, 14 Sep 2020 16:59:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5DCAC0859;
	Mon, 14 Sep 2020 16:59:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFFB5C0859
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 16:59:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7C600866ED
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 16:59:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m5RtvRIKCv3z for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 16:59:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D08D7866E9
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 16:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600102753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tkEtnAMzbXyUWN1Kd3VSWr/ao1qWSMw1ylDPJkGR9o=;
 b=DFyjJX9g8K2+69VCXRnTpZbSOK4zRai1vPVgY56QrsWCO44ymo0DLK44ju1xwHC/WaW2iV
 qKg/n8+52YcxWPfFNjp4sjm8Z1ejL2+uzPRhvBgrFlgEFgwTWtn6v2rxI4Rv2e3+qwrU6X
 EvXy6dX3921XFB6GF3XWgdK4NmsuJtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-Vbaak6A8P1mJweCqqa3Yjg-1; Mon, 14 Sep 2020 12:59:11 -0400
X-MC-Unique: Vbaak6A8P1mJweCqqa3Yjg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F0F5107466B;
 Mon, 14 Sep 2020 16:59:09 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14D5627C21;
 Mon, 14 Sep 2020 16:58:58 +0000 (UTC)
Date: Mon, 14 Sep 2020 10:58:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200914105857.3f88a271@x1.home>
In-Reply-To: <20200914163354.GG904879@nvidia.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <411c81c0-f13c-37cc-6c26-cafb42b46b15@redhat.com>
 <20200914133113.GB1375106@myrica>
 <20200914134738.GX904879@nvidia.com>
 <20200914162247.GA63399@otc-nc-03>
 <20200914163354.GG904879@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 "Raj, Ashok" <ashok.raj@intel.com>, kvm@vger.kernel.org,
 iommu@lists.linux-foundation.org, stefanha@gmail.com,
 Jason Wang <jasowang@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, jun.j.tian@intel.com, yi.y.sun@intel.com,
 hao.wu@intel.com
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

On Mon, 14 Sep 2020 13:33:54 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Sep 14, 2020 at 09:22:47AM -0700, Raj, Ashok wrote:
> > Hi Jason,
> > 
> > On Mon, Sep 14, 2020 at 10:47:38AM -0300, Jason Gunthorpe wrote:  
> > > On Mon, Sep 14, 2020 at 03:31:13PM +0200, Jean-Philippe Brucker wrote:
> > >   
> > > > > Jason suggest something like /dev/sva. There will be a lot of other
> > > > > subsystems that could benefit from this (e.g vDPA).  
> > > > 
> > > > Do you have a more precise idea of the interface /dev/sva would provide,
> > > > how it would interact with VFIO and others?  vDPA could transport the
> > > > generic iommu.h structures via its own uAPI, and call the IOMMU API
> > > > directly without going through an intermediate /dev/sva handle.  
> > > 
> > > Prior to PASID IOMMU really only makes sense as part of vfio-pci
> > > because the iommu can only key on the BDF. That can't work unless the
> > > whole PCI function can be assigned. It is hard to see how a shared PCI
> > > device can work with IOMMU like this, so may as well use vfio.
> > > 
> > > SVA and various vIOMMU models change this, a shared PCI driver can
> > > absoultely work with a PASID that is assigned to a VM safely, and
> > > actually don't need to know if their PASID maps a mm_struct or
> > > something else.  
> > 
> > Well, IOMMU does care if its a native mm_struct or something that belongs
> > to guest. Because you need ability to forward page-requests and pickup
> > page-responses from guest. Since there is just one PRQ on the IOMMU and
> > responses can't be sent directly. You have to depend on vIOMMU type
> > interface in guest to make all of this magic work right?  
> 
> Yes, IOMMU cares, but not the PCI Driver. It just knows it has a
> PASID. Details on how page faultings is handled or how the mapping is
> setup is abstracted by the PASID.
> 
> > > This new PASID allocator would match the guest memory layout and  
> > 
> > Not sure what you mean by "match guest memory layout"? 
> > Probably, meaning first level is gVA or gIOVA?   
> 
> It means whatever the qemu/viommu/guest/etc needs across all the
> IOMMU/arch implementations.
> 
> Basically, there should only be two ways to get a PASID
>  - From mm_struct that mirrors the creating process
>  - Via '/dev/sva' which has an complete interface to create and
>    control a PASID suitable for virtualization and more
> 
> VFIO should not have its own special way to get a PASID.

"its own special way" is arguable, VFIO is just making use of what's
being proposed as the uapi via its existing IOMMU interface.  PASIDs
are also a system resource, so we require some degree of access control
and quotas for management of PASIDs.  Does libvirt now get involved to
know whether an assigned device requires PASIDs such that access to
this dev file is provided to QEMU?  How does the kernel validate usage
or implement quotas when disconnected from device ownership?  PASIDs
would be an obvious DoS path if any user can create arbitrary
allocations.  If we can move code out of VFIO, I'm all for it, but I
think it needs to be better defined than "implement magic universal sva
uapi interface" before we can really consider it.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

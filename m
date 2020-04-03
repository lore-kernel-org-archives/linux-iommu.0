Return-Path: <SRS0=dWuT=5T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D2FC43331
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 15:14:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ADF620719
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 15:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbG5P+O8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADF620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1CBB788314;
	Fri,  3 Apr 2020 15:14:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xiXHoSltuWsg; Fri,  3 Apr 2020 15:14:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5F78C882AC;
	Fri,  3 Apr 2020 15:14:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46511C1831;
	Fri,  3 Apr 2020 15:14:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36A09C07FF
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 15:14:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 114CA2034A
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 15:14:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rco0RiRmojSo for <iommu@lists.linux-foundation.org>;
 Fri,  3 Apr 2020 15:14:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id 9B0C72033B
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585926877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVs6NhxQjzozD2M9mDMSQSn8sBMyBHI3OmZY795chUs=;
 b=JbG5P+O85KnRGspxazVuEbG2BZcIjDflC1bIUxeP0TenXyc97nECRvMmASEBI+3PVCkKBb
 JuDZ6j4CB2hLC2c3c2/wVbTUmkEE/8c6zM0K6lurg6lnkgkr29fXiDqNaEsn0pBSN4pCv2
 XAtxYwDFoZkJetNBPOfrljxE/j+KmfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-IVqN5ft4P02cANa9XT4wtg-1; Fri, 03 Apr 2020 11:14:33 -0400
X-MC-Unique: IVqN5ft4P02cANa9XT4wtg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ABA618B5FA9;
 Fri,  3 Apr 2020 15:14:31 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 003F15C1BE;
 Fri,  3 Apr 2020 15:14:24 +0000 (UTC)
Date: Fri, 3 Apr 2020 09:14:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v1 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
Message-ID: <20200403091424.39383958@w520.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D807BB9@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-2-git-send-email-yi.l.liu@intel.com>
 <20200402115017.0a0f55e2@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D807BB9@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, 
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Fri, 3 Apr 2020 05:58:55 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Friday, April 3, 2020 1:50 AM
> > 
> > On Sun, 22 Mar 2020 05:31:58 -0700
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> >   
> > > From: Liu Yi L <yi.l.liu@intel.com>
> > >
> > > For a long time, devices have only one DMA address space from platform
> > > IOMMU's point of view. This is true for both bare metal and directed-
> > > access in virtualization environment. Reason is the source ID of DMA in
> > > PCIe are BDF (bus/dev/fnc ID), which results in only device granularity
> > > DMA isolation. However, this is changing with the latest advancement in
> > > I/O technology area. More and more platform vendors are utilizing the  
> > PCIe  
> > > PASID TLP prefix in DMA requests, thus to give devices with multiple DMA
> > > address spaces as identified by their individual PASIDs. For example,
> > > Shared Virtual Addressing (SVA, a.k.a Shared Virtual Memory) is able to
> > > let device access multiple process virtual address space by binding the
> > > virtual address space with a PASID. Wherein the PASID is allocated in
> > > software and programmed to device per device specific manner. Devices
> > > which support PASID capability are called PASID-capable devices. If such
> > > devices are passed through to VMs, guest software are also able to bind
> > > guest process virtual address space on such devices. Therefore, the guest
> > > software could reuse the bare metal software programming model, which
> > > means guest software will also allocate PASID and program it to device
> > > directly. This is a dangerous situation since it has potential PASID
> > > conflicts and unauthorized address space access. It would be safer to
> > > let host intercept in the guest software's PASID allocation. Thus PASID
> > > are managed system-wide.  
> > 
> > Providing an allocation interface only allows for collaborative usage
> > of PASIDs though.  Do we have any ability to enforce PASID usage or can
> > a user spoof other PASIDs on the same BDF?  
> 
> An user can access only PASIDs allocated to itself, i.e. the specific IOASID
> set tied to its mm_struct.

A user is only _supposed_ to access PASIDs allocated to itself.  AIUI
the mm_struct is used for managing the pool of IOASIDs from which the
user may allocate that PASID.  We also state that programming the PASID
into the device is device specific.  Therefore, are we simply trusting
the user to use a PASID that's been allocated to them when they program
the device?  If a user can program an arbitrary PASID into the device,
then what prevents them from attempting to access data from another
user via the device?   I think I've asked this question before, so if
there's a previous explanation or spec section I need to review, please
point me to it.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

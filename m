Return-Path: <SRS0=8Bah=3X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56346C35247
	for <iommu@archiver.kernel.org>; Mon,  3 Feb 2020 18:01:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7A720721
	for <iommu@archiver.kernel.org>; Mon,  3 Feb 2020 18:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNK3YeQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7A720721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CAD08203CE;
	Mon,  3 Feb 2020 18:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X6ksuc+7QB8f; Mon,  3 Feb 2020 18:01:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 54B7020242;
	Mon,  3 Feb 2020 18:01:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47FFCC1D80;
	Mon,  3 Feb 2020 18:01:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4477C0174
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 18:01:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 927AB86FCD
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 18:01:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NJBqoAFrs8ol for <iommu@lists.linux-foundation.org>;
 Mon,  3 Feb 2020 18:01:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BFE0F86BE2
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 18:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580752870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZhX46YM0FLk44NTBeGHd0UZiF1Orn/r2iNN6uCSjnw=;
 b=MNK3YeQ/1+ezSP1xU3XPvToqmQNbCuGbgjN35LTet0V6p4e6WGxDWeiCsAaKcBJOoRkMFe
 jMU20wnIJ1OqZ7qhS1JBRtsuHi3fD+ekQtvpKFwgve7lhT75mdF/NfnoUWJKooxki9Jwis
 VxC+wsLFYecK4Z+RoLith0dr0LdgjhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-3ZDtis_GPGyUQxhELM89nA-1; Mon, 03 Feb 2020 13:00:54 -0500
X-MC-Unique: 3ZDtis_GPGyUQxhELM89nA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47A3C13E6;
 Mon,  3 Feb 2020 18:00:52 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5108B8642F;
 Mon,  3 Feb 2020 18:00:46 +0000 (UTC)
Date: Mon, 3 Feb 2020 11:00:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 4/8] vfio/type1: Add VFIO_NESTING_GET_IOMMU_UAPI_VERSION
Message-ID: <20200203110045.1fb3ec8d@w520.home>
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A1994A2@SHSMSX104.ccr.corp.intel.com>
References: <1580299912-86084-1-git-send-email-yi.l.liu@intel.com>
 <1580299912-86084-5-git-send-email-yi.l.liu@intel.com>
 <20200129165649.43008300@w520.home>
 <A2975661238FB949B60364EF0F2C25743A1994A2@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, 
 Yi Y" <yi.y.sun@intel.com>
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

On Fri, 31 Jan 2020 13:04:11 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> Hi Alex,
> 
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Thursday, January 30, 2020 7:57 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [RFC v3 4/8] vfio/type1: Add
> > VFIO_NESTING_GET_IOMMU_UAPI_VERSION
> > 
> > On Wed, 29 Jan 2020 04:11:48 -0800
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> >   
> > > From: Liu Yi L <yi.l.liu@intel.com>
> > >
> > > In Linux Kernel, the IOMMU nesting translation (a.k.a. IOMMU dual stage
> > > translation capability) is abstracted in uapi/iommu.h, in which the uAPIs
> > > like bind_gpasid/iommu_cache_invalidate/fault_report/pgreq_resp are defined.
> > >
> > > VFIO_TYPE1_NESTING_IOMMU stands for the vfio iommu type which is backed by
> > > IOMMU nesting translation capability. VFIO exposes the nesting capability
> > > to userspace and also exposes uAPIs (will be added in later patches) to user
> > > space for setting up nesting translation from userspace. Thus applications
> > > like QEMU could support vIOMMU for pass-through devices with IOMMU nesting
> > > translation capability.
> > >
> > > As VFIO expose the nesting IOMMU programming to userspace, it also needs to
> > > provide an API for the uapi/iommu.h version check to ensure compatibility.
> > > This patch reports the iommu uapi version to userspace. Applications could
> > > use this API to do version check before further using the nesting uAPIs.
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > Cc: Eric Auger <eric.auger@redhat.com>
> > > Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > ---
> > >  drivers/vfio/vfio.c       |  3 +++
> > >  include/uapi/linux/vfio.h | 10 ++++++++++
> > >  2 files changed, 13 insertions(+)
> > >
> > > diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> > > index 425d60a..9087ad4 100644
> > > --- a/drivers/vfio/vfio.c
> > > +++ b/drivers/vfio/vfio.c
> > > @@ -1170,6 +1170,9 @@ static long vfio_fops_unl_ioctl(struct file *filep,
> > >  	case VFIO_GET_API_VERSION:
> > >  		ret = VFIO_API_VERSION;
> > >  		break;
> > > +	case VFIO_NESTING_GET_IOMMU_UAPI_VERSION:
> > > +		ret = iommu_get_uapi_version();
> > > +		break;  
> > 
> > Shouldn't the type1 backend report this?  It doesn't make much sense
> > that the spapr backend reports a version for something it doesn't
> > support.  Better yet, provide this info gratuitously in the
> > VFIO_IOMMU_GET_INFO ioctl return like you do with nesting in the next
> > patch, then it can help the user figure out if this support is present.  
> 
> yeah, it would be better to report it by type1 backed. However,
> it is kind of issue when QEMU using it.
> 
> My series "hooks" vSVA supports on VFIO_TYPE1_NESTING_IOMMU type.
> [RFC v3 09/25] vfio: check VFIO_TYPE1_NESTING_IOMMU support
> https://www.spinics.net/lists/kvm/msg205197.html
> 
> In QEMU, it will determine the iommu type firstly and then invoke
> VFIO_SET_IOMMU. I think before selecting VFIO_TYPE1_NESTING_IOMMU,
> QEMU needs to check the IOMMU uAPI version. If IOMMU uAPI is incompatible,
> QEMU should not use VFIO_TYPE1_NESTING_IOMMU type. If
> VFIO_NESTING_GET_IOMMU_UAPI_VERSION is available after set iommu, then it
> may be an issue. That's why this series reports the version in vfio layer
> instead of type1 backend.

Why wouldn't you use CHECK_EXTENSION?  You could probe specifically for
a VFIO_TYP1_NESTING_IOMMU_UAPI_VERSION extension that returns the
version number.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

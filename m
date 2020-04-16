Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80859C352BE
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 14:48:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4568621D93
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 14:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXks6dR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4568621D93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 180CA8739E;
	Thu, 16 Apr 2020 14:48:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wGpUmxlOJoJK; Thu, 16 Apr 2020 14:48:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 77637863FD;
	Thu, 16 Apr 2020 14:48:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FD29C1AE8;
	Thu, 16 Apr 2020 14:48:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 893D0C0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 14:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 78698863FD
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 14:48:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uIkYZmJHHBwV for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 14:48:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4F0B285A4B
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 14:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587048513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mMOcvd8rqB/SDYGbEUATBrqiayoKdChDgtyzI2z56+k=;
 b=XXks6dR/aVCpGoWHDqpHwjvQBCLFFzFs03DY3QrBnlzcff+2ZCOKUbkDhtFdq0YYNMxU9j
 +6ylQZYjCdBYdrohZfPdW7x8B3TUiL1HJYhkBQ/OBZ4eOH1wjZaTtNX6TOpYDeAs+t1p/a
 fQ0vkb7cceP2ZUlYtovQF2m4l8OkLU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-Le46VK3hP4KmFRFu2epPvQ-1; Thu, 16 Apr 2020 10:48:29 -0400
X-MC-Unique: Le46VK3hP4KmFRFu2epPvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5360E85EE81;
 Thu, 16 Apr 2020 14:48:12 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CDFE5C1C5;
 Thu, 16 Apr 2020 14:48:11 +0000 (UTC)
Date: Thu, 16 Apr 2020 08:48:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
Message-ID: <20200416084811.5acf4424@w520.home>
In-Reply-To: <20200416084031.7266ad40@w520.home>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-8-git-send-email-yi.l.liu@intel.com>
 <20200402142428.2901432e@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D807C4A@SHSMSX104.ccr.corp.intel.com>
 <20200403093436.094b1928@w520.home>
 <A2975661238FB949B60364EF0F2C25743A231BAA@SHSMSX104.ccr.corp.intel.com>
 <20200416084031.7266ad40@w520.home>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Sun,
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

On Thu, 16 Apr 2020 08:40:31 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 16 Apr 2020 10:40:03 +0000
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > Hi Alex,
> > Still have a direction question with you. Better get agreement with you
> > before heading forward.
> >   
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Friday, April 3, 2020 11:35 PM    
> > [...]  
> > > > > > + *
> > > > > > + * returns: 0 on success, -errno on failure.
> > > > > > + */
> > > > > > +struct vfio_iommu_type1_cache_invalidate {
> > > > > > +	__u32   argsz;
> > > > > > +	__u32   flags;
> > > > > > +	struct	iommu_cache_invalidate_info cache_info;
> > > > > > +};
> > > > > > +#define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE,    
> > > VFIO_BASE    
> > > > > + 24)
> > > > >
> > > > > The future extension capabilities of this ioctl worry me, I wonder if
> > > > > we should do another data[] with flag defining that data as CACHE_INFO.    
> > > >
> > > > Can you elaborate? Does it mean with this way we don't rely on iommu
> > > > driver to provide version_to_size conversion and instead we just pass
> > > > data[] to iommu driver for further audit?    
> > > 
> > > No, my concern is that this ioctl has a single function, strictly tied
> > > to the iommu uapi.  If we replace cache_info with data[] then we can
> > > define a flag to specify that data[] is struct
> > > iommu_cache_invalidate_info, and if we need to, a different flag to
> > > identify data[] as something else.  For example if we get stuck
> > > expanding cache_info to meet new demands and develop a new uapi to
> > > solve that, how would we expand this ioctl to support it rather than
> > > also create a new ioctl?  There's also a trade-off in making the ioctl
> > > usage more difficult for the user.  I'd still expect the vfio layer to
> > > check the flag and interpret data[] as indicated by the flag rather
> > > than just passing a blob of opaque data to the iommu layer though.
> > > Thanks,    
> > 
> > Based on your comments about defining a single ioctl and a unified
> > vfio structure (with a @data[] field) for pasid_alloc/free, bind/
> > unbind_gpasid, cache_inv. After some offline trying, I think it would
> > be good for bind/unbind_gpasid and cache_inv as both of them use the
> > iommu uapi definition. While the pasid alloc/free operation doesn't.
> > It would be weird to put all of them together. So pasid alloc/free
> > may have a separate ioctl. It would look as below. Does this direction
> > look good per your opinion?
> > 
> > ioctl #22: VFIO_IOMMU_PASID_REQUEST
> > /**
> >   * @pasid: used to return the pasid alloc result when flags == ALLOC_PASID
> >   *         specify a pasid to be freed when flags == FREE_PASID
> >   * @range: specify the allocation range when flags == ALLOC_PASID
> >   */
> > struct vfio_iommu_pasid_request {
> > 	__u32	argsz;
> > #define VFIO_IOMMU_ALLOC_PASID	(1 << 0)
> > #define VFIO_IOMMU_FREE_PASID	(1 << 1)
> > 	__u32	flags;
> > 	__u32	pasid;
> > 	struct {
> > 		__u32	min;
> > 		__u32	max;
> > 	} range;
> > };  
> 
> Can't the ioctl return the pasid valid on alloc (like GET_DEVICE_FD)?

s/valid/value/

> Would it be useful to support freeing a range of pasids?  If so then we
> could simply use range for both, ie. allocate a pasid from this range
> and return it, or free all pasids in this range?  vfio already needs to
> track pasids to free them on release, so presumably this is something
> we could support easily.
>  
> > ioctl #23: VFIO_IOMMU_NESTING_OP
> > struct vfio_iommu_type1_nesting_op {
> > 	__u32	argsz;
> > 	__u32	flags;
> > 	__u32	op;
> > 	__u8	data[];
> > };  
> 
> data only has 4-byte alignment, I think we really want it at an 8-byte
> alignment.  This is why I embedded the "op" into the flag for
> DEVICE_FEATURE.  Thanks,
> 
> Alex
> 
> > 
> > /* Nesting Ops */
> > #define VFIO_IOMMU_NESTING_OP_BIND_PGTBL        0
> > #define VFIO_IOMMU_NESTING_OP_UNBIND_PGTBL      1
> > #define VFIO_IOMMU_NESTING_OP_CACHE_INVLD       2
> >  
> > Thanks,
> > Yi Liu
> >   
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

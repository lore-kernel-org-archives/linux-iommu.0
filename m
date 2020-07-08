Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF609C433DF
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 19:30:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BA02065D
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 19:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gas97tBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BA02065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F72B89829;
	Wed,  8 Jul 2020 19:30:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f1O0jODJgHLl; Wed,  8 Jul 2020 19:30:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 018668961C;
	Wed,  8 Jul 2020 19:30:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6DCFC0893;
	Wed,  8 Jul 2020 19:30:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6955EC016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 19:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 64DCF86E65
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 19:30:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cZTy5ZEybaPy for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 19:30:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5F5EF86DF3
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 19:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594236600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UJjkq/41DYBOCSHo3nTf+zUI4aMZSKM39jLWG6kR/zY=;
 b=Gas97tBRq2VmgRA9lWCmxibWy+rA2YBpeE1hBU2Eq6EoySIJrk37REDecRPoVLTzaA/skZ
 gJICwsJenHdJlUizC6WXjBya25XDplXEWC0L7n4Wm1Bkgq6NdA90oN/rv4BqS33nc1p+u2
 xjCK+7olvWmRTQ9nr1U+MLm0MN39fSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-fQ7c72TkN5irDaNSzxo8Vw-1; Wed, 08 Jul 2020 15:29:57 -0400
X-MC-Unique: fQ7c72TkN5irDaNSzxo8Vw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 165AF107ACF3;
 Wed,  8 Jul 2020 19:29:55 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 686162DE60;
 Wed,  8 Jul 2020 19:29:48 +0000 (UTC)
Date: Wed, 8 Jul 2020 13:29:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 04/15] vfio/type1: Report iommu nesting info to
 userspace
Message-ID: <20200708132947.5b7ee954@x1.home>
In-Reply-To: <DM5PR11MB143531E2B54ED82FB0649F8CC3670@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-5-git-send-email-yi.l.liu@intel.com>
 <d434cbcc-d3b1-d11d-0304-df2d2c93efa0@redhat.com>
 <DM5PR11MB1435290B6CD561EC61027892C3690@DM5PR11MB1435.namprd11.prod.outlook.com>
 <94b4e5d3-8d24-9a55-6bee-ed86f3846996@redhat.com>
 <DM5PR11MB14357A5953EB630A58FF568EC3660@DM5PR11MB1435.namprd11.prod.outlook.com>
 <DM5PR11MB143531E2B54ED82FB0649F8CC3670@DM5PR11MB1435.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>
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

On Wed, 8 Jul 2020 08:08:40 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> Hi Alex,
> 
> Eric asked if we will to have data strcut other than struct iommu_nesting_info
> type in the struct vfio_iommu_type1_info_cap_nesting @info[] field. I'm not
> quit sure on it. I guess the answer may be not as VFIO's nesting support should
> based on IOMMU UAPI. how about your opinion?
> 
> +#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  3
> +
> +/*
> + * Reporting nesting info to user space.
> + *
> + * @info:	the nesting info provided by IOMMU driver. Today
> + *		it is expected to be a struct iommu_nesting_info
> + *		data.
> + */
> +struct vfio_iommu_type1_info_cap_nesting {
> +	struct	vfio_info_cap_header header;
> +	__u32	flags;
> +	__u32	padding;
> +	__u8	info[];
> +};

It's not a very useful uAPI if the user can't be sure what they're
getting out of it.  Info capabilities are "cheap", they don't need to
be as extensible as an ioctl.  It's not clear that we really even need
the flags (and therefore the padding), just define it to return the
IOMMU uAPI structure with no extensibility.  If we need to expose
something else, create a new capability.  Thanks,

Alex

> 
> https://lore.kernel.org/linux-iommu/DM5PR11MB1435290B6CD561EC61027892C3690@DM5PR11MB1435.namprd11.prod.outlook.com/
> 
> Regards,
> Yi Liu
> 
> > From: Liu, Yi L
> > Sent: Tuesday, July 7, 2020 5:32 PM
> >   
> [...]
> > > >  
> > > >>> +
> > > >>> +/*
> > > >>> + * Reporting nesting info to user space.
> > > >>> + *
> > > >>> + * @info:	the nesting info provided by IOMMU driver. Today
> > > >>> + *		it is expected to be a struct iommu_nesting_info
> > > >>> + *		data.  
> > > >> Is it expected to change?  
> > > >
> > > > honestly, I'm not quite sure on it. I did considered to embed struct
> > > > iommu_nesting_info here instead of using info[]. but I hesitated as
> > > > using info[] may leave more flexibility on this struct. how about
> > > > your opinion? perhaps it's fine to embed the struct
> > > > iommu_nesting_info here as long as VFIO is setup nesting based on
> > > > IOMMU UAPI.
> > > >  
> > > >>> + */
> > > >>> +struct vfio_iommu_type1_info_cap_nesting {
> > > >>> +	struct	vfio_info_cap_header header;
> > > >>> +	__u32	flags;  
> > > >> You may document flags.  
> > > >
> > > > sure. it's reserved for future.
> > > >
> > > > Regards,
> > > > Yi Liu
> > > >  
> > > >>> +	__u32	padding;
> > > >>> +	__u8	info[];
> > > >>> +};
> > > >>> +
> > > >>>  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> > > >>>
> > > >>>  /**
> > > >>>  
> > > >> Thanks
> > > >>
> > > >> Eric  
> > > >  
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

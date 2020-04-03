Return-Path: <SRS0=dWuT=5T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D2BC43331
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 17:28:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43753206F5
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 17:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMgkJ3Sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43753206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2137886F0F;
	Fri,  3 Apr 2020 17:28:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WuBDy89ZRGax; Fri,  3 Apr 2020 17:28:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8C763862AC;
	Fri,  3 Apr 2020 17:28:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 737B9C1831;
	Fri,  3 Apr 2020 17:28:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12306C07FF
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 17:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EF0D488B93
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 17:28:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s-J9Icbo2l-x for <iommu@lists.linux-foundation.org>;
 Fri,  3 Apr 2020 17:28:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2EA5E889CE
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 17:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585934897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=teuy+sFz4u16kM5p1bWOo2plt8bmjSuv9csLpTGopn8=;
 b=bMgkJ3Sm2qyymGkKpoILE1MnsW1TdoaIt3CCU0jnr5Wclh82qDnaWQX7rLQ1J58AySTilS
 M+DKV0HrfI5pPOz+tRLiKpAAaUTRe9P6qjHAMH4nr+EdTxsRKZ6Mu3u/CwwcNj6XfNbQAu
 4IR4H6nFyxpqjd+V6YNxWdjOgUD9jIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-LOgI8shxPyCl2ELpbS2FPQ-1; Fri, 03 Apr 2020 13:28:14 -0400
X-MC-Unique: LOgI8shxPyCl2ELpbS2FPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D11151137843;
 Fri,  3 Apr 2020 17:28:11 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB65A60BF3;
 Fri,  3 Apr 2020 17:28:07 +0000 (UTC)
Date: Fri, 3 Apr 2020 11:28:07 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 3/8] vfio/type1: Report PASID alloc/free support to
 userspace
Message-ID: <20200403112807.30a56c48@w520.home>
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A220662@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-4-git-send-email-yi.l.liu@intel.com>
 <20200402120100.19e43c72@w520.home>
 <A2975661238FB949B60364EF0F2C25743A220662@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, 
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

On Fri, 3 Apr 2020 08:17:44 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson < alex.williamson@redhat.com >
> > Sent: Friday, April 3, 2020 2:01 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [PATCH v1 3/8] vfio/type1: Report PASID alloc/free support to
> > userspace
> > 
> > On Sun, 22 Mar 2020 05:32:00 -0700
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> >   
> > > From: Liu Yi L <yi.l.liu@intel.com>
> > >
> > > This patch reports PASID alloc/free availability to userspace (e.g.
> > > QEMU) thus userspace could do a pre-check before utilizing this feature.
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > Cc: Eric Auger <eric.auger@redhat.com>
> > > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > ---
> > >  drivers/vfio/vfio_iommu_type1.c | 28 ++++++++++++++++++++++++++++
> > >  include/uapi/linux/vfio.h       |  8 ++++++++
> > >  2 files changed, 36 insertions(+)
> > >
> > > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > > b/drivers/vfio/vfio_iommu_type1.c index e40afc0..ddd1ffe 100644
> > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > @@ -2234,6 +2234,30 @@ static int vfio_iommu_type1_pasid_free(struct  
> > vfio_iommu *iommu,  
> > >  	return ret;
> > >  }
> > >
> > > +static int vfio_iommu_info_add_nesting_cap(struct vfio_iommu *iommu,
> > > +					 struct vfio_info_cap *caps)
> > > +{
> > > +	struct vfio_info_cap_header *header;
> > > +	struct vfio_iommu_type1_info_cap_nesting *nesting_cap;
> > > +
> > > +	header = vfio_info_cap_add(caps, sizeof(*nesting_cap),
> > > +				   VFIO_IOMMU_TYPE1_INFO_CAP_NESTING, 1);
> > > +	if (IS_ERR(header))
> > > +		return PTR_ERR(header);
> > > +
> > > +	nesting_cap = container_of(header,
> > > +				struct vfio_iommu_type1_info_cap_nesting,
> > > +				header);
> > > +
> > > +	nesting_cap->nesting_capabilities = 0;
> > > +	if (iommu->nesting) {
> > > +		/* nesting iommu type supports PASID requests (alloc/free) */
> > > +		nesting_cap->nesting_capabilities |= VFIO_IOMMU_PASID_REQS;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> > >  				   unsigned int cmd, unsigned long arg)  { @@ -  
> > 2283,6 +2307,10 @@  
> > > static long vfio_iommu_type1_ioctl(void *iommu_data,
> > >  		if (ret)
> > >  			return ret;
> > >
> > > +		ret = vfio_iommu_info_add_nesting_cap(iommu, &caps);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > >  		if (caps.size) {
> > >  			info.flags |= VFIO_IOMMU_INFO_CAPS;
> > >
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index 298ac80..8837219 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -748,6 +748,14 @@ struct vfio_iommu_type1_info_cap_iova_range {
> > >  	struct	vfio_iova_range iova_ranges[];
> > >  };
> > >
> > > +#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  2
> > > +
> > > +struct vfio_iommu_type1_info_cap_nesting {
> > > +	struct	vfio_info_cap_header header;
> > > +#define VFIO_IOMMU_PASID_REQS	(1 << 0)
> > > +	__u32	nesting_capabilities;
> > > +};
> > > +
> > >  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> > >
> > >  /**  
> > 
> > I think this answers my PROBE question on patch 1/.   
> yep.
> > Should the quota/usage be exposed to the user here?  Thanks,  
> 
> Do you mean report the quota available for this user in this cap info as well?

Yes.  Would it be useful?

> For usage, do you mean the alloc and free or others?

I mean how many of the quota are currently in allocated, or
alternatively, how many remain.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

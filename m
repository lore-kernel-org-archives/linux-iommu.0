Return-Path: <SRS0=5HPr=TQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F621C04AAF
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 18:54:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8C02082E
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 18:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8C02082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B04B2C11;
	Thu, 16 May 2019 18:54:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 19A3AB7A
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 18:54:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BC686882
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 18:54:44 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDB3E308FBB4;
	Thu, 16 May 2019 18:54:35 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F293A5D985;
	Thu, 16 May 2019 18:54:34 +0000 (UTC)
Date: Thu, 16 May 2019 12:54:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 2/4] vfio: vfio_iommu_type1: Define
	VFIO_IOMMU_INFO_CAPABILITIES
Message-ID: <20190516125434.7dbc4b3c@x1.home>
In-Reply-To: <f396492c-5815-7fd2-0e78-7681e6380591@de.ibm.com>
References: <1557476555-20256-1-git-send-email-pmorel@linux.ibm.com>
	<1557476555-20256-3-git-send-email-pmorel@linux.ibm.com>
	<f396492c-5815-7fd2-0e78-7681e6380591@de.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 16 May 2019 18:54:40 +0000 (UTC)
Cc: linux-s390@vger.kernel.org, pasic@linux.vnet.ibm.com, kvm@vger.kernel.org,
	Pierre Morel <pmorel@linux.ibm.com>, heiko.carstens@de.ibm.com,
	sebott@linux.vnet.ibm.com, walling@linux.ibm.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	schwidefsky@de.ibm.com, gerald.schaefer@de.ibm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, 16 May 2019 16:57:42 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Alex, 
> 
> patch 1 and 3 are s390 specific, 2 and 4 are vfio common code.
> Are you ok with the common code changes? If yes, would you prefer to have this
> via the s390 tree (Martin) or your tree?

Hi Christian,

The vfio code still needs work imo, and I'm not sure it isn't somewhat
abusive of the iommu attribute interface as well.  I don't necessarily
have a problem with it ultimately going through the s390 tree, but
let's see what comes in the next revision.  Thanks,

Alex

> On 10.05.19 10:22, Pierre Morel wrote:
> > To use the VFIO_IOMMU_GET_INFO to retrieve IOMMU specific information,
> > we define a new flag VFIO_IOMMU_INFO_CAPABILITIES in the
> > vfio_iommu_type1_info structure and the associated capability
> > information block.
> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---
> >  include/uapi/linux/vfio.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 8f10748..8f68e0f 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -715,6 +715,16 @@ struct vfio_iommu_type1_info {
> >  	__u32	flags;
> >  #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
> >  	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
> > +#define VFIO_IOMMU_INFO_CAPABILITIES (1 << 1)  /* support capabilities info */
> > +	__u64   cap_offset;     /* Offset within info struct of first cap */
> > +};
> > +
> > +#define VFIO_IOMMU_INFO_CAP_QFN		1
> > +#define VFIO_IOMMU_INFO_CAP_QGRP	2
> > +
> > +struct vfio_iommu_type1_info_block {
> > +	struct vfio_info_cap_header header;
> > +	__u32 data[];
> >  };
> >  
> >  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> >   
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

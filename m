Return-Path: <SRS0=FJ9b=3U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A09CC33CB2
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 12:47:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF1520707
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 12:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF1520707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BBCE2864EF;
	Fri, 31 Jan 2020 12:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rwek7RMj2byS; Fri, 31 Jan 2020 12:47:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 19FE087E74;
	Fri, 31 Jan 2020 12:47:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB441C0176;
	Fri, 31 Jan 2020 12:47:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D31E3C0171
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 12:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BBA97864EF
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 12:47:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XONGSqx-O-Dq for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jan 2020 12:47:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9EAC4881A8
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 12:47:32 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 04:42:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,385,1574150400"; d="scan'208";a="402646272"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga005.jf.intel.com with ESMTP; 31 Jan 2020 04:42:31 -0800
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jan 2020 04:42:15 -0800
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jan 2020 04:42:14 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.197]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.39]) with mapi id 14.03.0439.000;
 Fri, 31 Jan 2020 20:42:13 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [RFC v3 3/8] vfio: Reclaim PASIDs when application is down
Thread-Topic: [RFC v3 3/8] vfio: Reclaim PASIDs when application is down
Thread-Index: AQHV1pyX9vSsvffLj0+to6Wf6wB5HKgBzCoAgALuD6A=
Date: Fri, 31 Jan 2020 12:42:11 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A199412@SHSMSX104.ccr.corp.intel.com>
References: <1580299912-86084-1-git-send-email-yi.l.liu@intel.com>
 <1580299912-86084-4-git-send-email-yi.l.liu@intel.com>
 <20200129165640.4f1d42e0@w520.home>
In-Reply-To: <20200129165640.4f1d42e0@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzIyOWFiNDUtNGE5ZC00NzcwLWFjMTgtYWRlYjRlMWE3YjJlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoic3hPXC90Smc3VTdYTUIxeDFCWFVRbW5xRHljeVlmTlwvWFJQbjRLaDdRcEZna3VnN01HSmg0MG1qVUtHazVSNjRkIn0=
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, Yi
 Y" <yi.y.sun@intel.com>
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

Hi Alex,

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Thursday, January 30, 2020 7:57 AM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v3 3/8] vfio: Reclaim PASIDs when application is down
> 
> On Wed, 29 Jan 2020 04:11:47 -0800
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > From: Liu Yi L <yi.l.liu@intel.com>
> >
> > When userspace application is down, kernel should reclaim the PASIDs
> > allocated for this application to avoid PASID leak. This patch adds a
> > PASID list in vfio_mm structure to track the allocated PASIDs. The
> > PASID reclaim will be triggered when last vfio container is released.
> >
> > Previous discussions:
> > https://patchwork.kernel.org/patch/11209429/
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  drivers/vfio/vfio.c  | 61
> > +++++++++++++++++++++++++++++++++++++++++++++++++---
> >  include/linux/vfio.h |  6 ++++++
> >  2 files changed, 64 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c index
> > c43c757..425d60a 100644
> > --- a/drivers/vfio/vfio.c
> > +++ b/drivers/vfio/vfio.c
> > @@ -2148,15 +2148,31 @@ static struct vfio_mm *vfio_create_mm(struct
> mm_struct *mm)
> >  	vmm->pasid_quota = VFIO_DEFAULT_PASID_QUOTA;
> >  	vmm->pasid_count = 0;
> >  	mutex_init(&vmm->pasid_lock);
> > +	INIT_LIST_HEAD(&vmm->pasid_list);
> >
> >  	list_add(&vmm->vfio_next, &vfio.vfio_mm_list);
> >
> >  	return vmm;
> >  }
> >
> > +static void vfio_mm_reclaim_pasid(struct vfio_mm *vmm) {
> > +	struct pasid_node *pnode, *tmp;
> > +
> > +	mutex_lock(&vmm->pasid_lock);
> > +	list_for_each_entry_safe(pnode, tmp, &vmm->pasid_list, next) {
> > +		pr_info("%s, reclaim pasid: %u\n", __func__, pnode->pasid);
> > +		list_del(&pnode->next);
> > +		ioasid_free(pnode->pasid);
> > +		kfree(pnode);
> > +	}
> > +	mutex_unlock(&vmm->pasid_lock);
> > +}
> > +
> >  static void vfio_mm_unlock_and_free(struct vfio_mm *vmm)  {
> >  	mutex_unlock(&vfio.vfio_mm_lock);
> > +	vfio_mm_reclaim_pasid(vmm);
> >  	kfree(vmm);
> >  }
> >
> > @@ -2204,6 +2220,39 @@ struct vfio_mm *vfio_mm_get_from_task(struct
> > task_struct *task)  }  EXPORT_SYMBOL_GPL(vfio_mm_get_from_task);
> >
> > +/**
> > + * Caller should hold vmm->pasid_lock  */ static int
> > +vfio_mm_insert_pasid_node(struct vfio_mm *vmm, u32 pasid) {
> > +	struct pasid_node *pnode;
> > +
> > +	pnode = kzalloc(sizeof(*pnode), GFP_KERNEL);
> > +	if (!pnode)
> > +		return -ENOMEM;
> > +	pnode->pasid = pasid;
> > +	list_add(&pnode->next, &vmm->pasid_list);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * Caller should hold vmm->pasid_lock  */ static void
> > +vfio_mm_remove_pasid_node(struct vfio_mm *vmm, u32 pasid) {
> > +	struct pasid_node *pnode, *tmp;
> > +
> > +	list_for_each_entry_safe(pnode, tmp, &vmm->pasid_list, next) {
> > +		if (pnode->pasid == pasid) {
> > +			list_del(&pnode->next);
> > +			kfree(pnode);
> > +			break;
> > +		}
> 
> The _safe() list walk variant is only needed when we continue to walk the list after
> removing an entry.  Thanks,

Nice catch. thanks, :-)

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

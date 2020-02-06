Return-Path: <SRS0=jQQH=32=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E40C2D0B1
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 09:41:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B35218AC
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 09:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B35218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A00288545D;
	Thu,  6 Feb 2020 09:41:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2kuUevNREgst; Thu,  6 Feb 2020 09:41:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EA8978519E;
	Thu,  6 Feb 2020 09:41:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAFF4C1D81;
	Thu,  6 Feb 2020 09:41:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A70D9C013E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 09:41:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 89C6984763
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 09:41:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HXEi7TJxukCZ for <iommu@lists.linux-foundation.org>;
 Thu,  6 Feb 2020 09:41:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A80678143A
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 09:41:52 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Feb 2020 01:41:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,409,1574150400"; d="scan'208";a="311644917"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga001.jf.intel.com with ESMTP; 06 Feb 2020 01:41:51 -0800
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 6 Feb 2020 01:41:50 -0800
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 6 Feb 2020 01:41:50 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.5]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.225]) with mapi id 14.03.0439.000;
 Thu, 6 Feb 2020 17:41:49 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: 'Alex Williamson' <alex.williamson@redhat.com>
Subject: RE: [RFC v3 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
Thread-Topic: [RFC v3 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
Thread-Index: AQHV1pyWdXmNxNYiSUCDLwZiDlOrAKgBy+IAgALeXlCACUe2gA==
Date: Thu, 6 Feb 2020 09:41:48 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A1B1B5E@SHSMSX104.ccr.corp.intel.com>
References: <1580299912-86084-1-git-send-email-yi.l.liu@intel.com>
 <1580299912-86084-2-git-send-email-yi.l.liu@intel.com>
 <20200129165540.335774d5@w520.home>
 <A2975661238FB949B60364EF0F2C25743A1993E8@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A1993E8@SHSMSX104.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODk5Y2JlYjEtZjRjMi00ZTI3LWJjNTYtY2NlZmMyZWZhYjBlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaVZFb3VjY1ZoWEVKd3JcL1F1dEhIamZ3NDE2RzdISUZRdlZ2UzBlbzIzVmpqcDVxa3FSWDE5c3VDRFYxNkRrTVEifQ==
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "'kvm@vger.kernel.org'" <kvm@vger.kernel.org>,
 "'jean-philippe.brucker@arm.com'" <jean-philippe.brucker@arm.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "'iommu@lists.linux-foundation.org'" <iommu@lists.linux-foundation.org>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "Sun,
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

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Friday, January 31, 2020 8:41 PM
> To: Alex Williamson <alex.williamson@redhat.com>
> Subject: RE: [RFC v3 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
> 
> Hi Alex,
> 
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Thursday, January 30, 2020 7:56 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [RFC v3 1/8] vfio: Add
> > VFIO_IOMMU_PASID_REQUEST(alloc/free)
> >
> > On Wed, 29 Jan 2020 04:11:45 -0800
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> >
> > > From: Liu Yi L <yi.l.liu@intel.com>
> > >
[...]
> > > +
> > > +int vfio_mm_pasid_alloc(struct vfio_mm *vmm, int min, int max) {
> > > +	ioasid_t pasid;
> > > +	int ret = -ENOSPC;
> > > +
> > > +	mutex_lock(&vmm->pasid_lock);
> > > +	if (vmm->pasid_count >= vmm->pasid_quota) {
> > > +		ret = -ENOSPC;
> > > +		goto out_unlock;
> > > +	}
> > > +	/* Track ioasid allocation owner by mm */
> > > +	pasid = ioasid_alloc((struct ioasid_set *)vmm->mm, min,
> > > +				max, NULL);
> >
> > Is mm effectively only a token for this?  Maybe we should have a
> > struct vfio_mm_token since gets and puts are not creating a reference
> > to an mm, but to an "mm token".
> 
> yes, it is supposed to be a kind of token. vfio_mm_token is better naming. :-)

Hi Alex,

Just to double check if I got your point. Your point is to have a separate structure
which is only wrap of mm or just renaming current vfio_mm would be enough?


Regards,
Yi Liu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

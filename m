Return-Path: <SRS0=FJ9b=3U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC266C33CB2
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 13:04:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7D3620CC7
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 13:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D3620CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9F8BF876BB;
	Fri, 31 Jan 2020 13:04:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ajb+jeSlYNUf; Fri, 31 Jan 2020 13:04:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A737E8602E;
	Fri, 31 Jan 2020 13:04:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92115C0176;
	Fri, 31 Jan 2020 13:04:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DF74C0171
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 13:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7DDE7857BC
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 13:04:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BA2UfRp+t30j for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jan 2020 13:04:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D345585207
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 13:04:44 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 05:04:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,385,1574150400"; d="scan'208";a="402650842"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga005.jf.intel.com with ESMTP; 31 Jan 2020 05:04:35 -0800
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jan 2020 05:04:34 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.197]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.97]) with mapi id 14.03.0439.000;
 Fri, 31 Jan 2020 21:04:12 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [RFC v3 4/8] vfio/type1: Add VFIO_NESTING_GET_IOMMU_UAPI_VERSION
Thread-Topic: [RFC v3 4/8] vfio/type1: Add VFIO_NESTING_GET_IOMMU_UAPI_VERSION
Thread-Index: AQHV1pyVzTVYYyC090Ow388f+bA35qgBzDSAgALuTFA=
Date: Fri, 31 Jan 2020 13:04:11 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A1994A2@SHSMSX104.ccr.corp.intel.com>
References: <1580299912-86084-1-git-send-email-yi.l.liu@intel.com>
 <1580299912-86084-5-git-send-email-yi.l.liu@intel.com>
 <20200129165649.43008300@w520.home>
In-Reply-To: <20200129165649.43008300@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTgxNzM5ZWQtYTU3Mi00MjE4LThlNjQtYzE3YmQ3NmRiZGU1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaXE0Skp3bEs4ZGJhdmNWd0dYY3F2VWdpamZjN1FNcHpvZ2pMM2JYZzkxSzR3VVBkSjJpc1Z5TXNOcFBCZ1crSyJ9
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
> Subject: Re: [RFC v3 4/8] vfio/type1: Add
> VFIO_NESTING_GET_IOMMU_UAPI_VERSION
> 
> On Wed, 29 Jan 2020 04:11:48 -0800
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > From: Liu Yi L <yi.l.liu@intel.com>
> >
> > In Linux Kernel, the IOMMU nesting translation (a.k.a. IOMMU dual stage
> > translation capability) is abstracted in uapi/iommu.h, in which the uAPIs
> > like bind_gpasid/iommu_cache_invalidate/fault_report/pgreq_resp are defined.
> >
> > VFIO_TYPE1_NESTING_IOMMU stands for the vfio iommu type which is backed by
> > IOMMU nesting translation capability. VFIO exposes the nesting capability
> > to userspace and also exposes uAPIs (will be added in later patches) to user
> > space for setting up nesting translation from userspace. Thus applications
> > like QEMU could support vIOMMU for pass-through devices with IOMMU nesting
> > translation capability.
> >
> > As VFIO expose the nesting IOMMU programming to userspace, it also needs to
> > provide an API for the uapi/iommu.h version check to ensure compatibility.
> > This patch reports the iommu uapi version to userspace. Applications could
> > use this API to do version check before further using the nesting uAPIs.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  drivers/vfio/vfio.c       |  3 +++
> >  include/uapi/linux/vfio.h | 10 ++++++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> > index 425d60a..9087ad4 100644
> > --- a/drivers/vfio/vfio.c
> > +++ b/drivers/vfio/vfio.c
> > @@ -1170,6 +1170,9 @@ static long vfio_fops_unl_ioctl(struct file *filep,
> >  	case VFIO_GET_API_VERSION:
> >  		ret = VFIO_API_VERSION;
> >  		break;
> > +	case VFIO_NESTING_GET_IOMMU_UAPI_VERSION:
> > +		ret = iommu_get_uapi_version();
> > +		break;
> 
> Shouldn't the type1 backend report this?  It doesn't make much sense
> that the spapr backend reports a version for something it doesn't
> support.  Better yet, provide this info gratuitously in the
> VFIO_IOMMU_GET_INFO ioctl return like you do with nesting in the next
> patch, then it can help the user figure out if this support is present.

yeah, it would be better to report it by type1 backed. However,
it is kind of issue when QEMU using it.

My series "hooks" vSVA supports on VFIO_TYPE1_NESTING_IOMMU type.
[RFC v3 09/25] vfio: check VFIO_TYPE1_NESTING_IOMMU support
https://www.spinics.net/lists/kvm/msg205197.html

In QEMU, it will determine the iommu type firstly and then invoke
VFIO_SET_IOMMU. I think before selecting VFIO_TYPE1_NESTING_IOMMU,
QEMU needs to check the IOMMU uAPI version. If IOMMU uAPI is incompatible,
QEMU should not use VFIO_TYPE1_NESTING_IOMMU type. If
VFIO_NESTING_GET_IOMMU_UAPI_VERSION is available after set iommu, then it
may be an issue. That's why this series reports the version in vfio layer
instead of type1 backend.

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

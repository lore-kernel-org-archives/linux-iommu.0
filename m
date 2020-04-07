Return-Path: <SRS0=p9ZB=5X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D87C2BA16
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 04:42:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71B120748
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 04:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71B120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9B88085F56;
	Tue,  7 Apr 2020 04:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LCS_GPjxsxGa; Tue,  7 Apr 2020 04:42:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F038085DC4;
	Tue,  7 Apr 2020 04:42:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDF8FC1AE2;
	Tue,  7 Apr 2020 04:42:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21E58C0177
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 04:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 10C0E87613
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 04:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iR6fBAT93Cdr for <iommu@lists.linux-foundation.org>;
 Tue,  7 Apr 2020 04:42:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5CDC38663C
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 04:42:08 +0000 (UTC)
IronPort-SDR: BUGoMr7Ba9brNwAnR63YMgeThYKdKSw+yq7QSebglac2fppZai8orqgbo407GOhV45ebj48rBP
 nltfEQEmgEUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2020 21:42:07 -0700
IronPort-SDR: 4wrchvln1lQFNDC1/x6Jh7XDy16JIOWo1Y1Q8iiWViMp1DfJ4gs5bM6IOxf6z16mrLg5Es3a11
 hEVmoXmvDIaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,353,1580803200"; d="scan'208";a="248295728"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga008.jf.intel.com with ESMTP; 06 Apr 2020 21:42:07 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Apr 2020 21:42:06 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 6 Apr 2020 21:42:06 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 6 Apr 2020 21:42:06 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.191]) with mapi id 14.03.0439.000;
 Tue, 7 Apr 2020 12:42:03 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v1 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
Thread-Topic: [PATCH v1 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
Thread-Index: AQHWAEUbvuzF5+3jpEaYhihTFzMRG6hlp7CAgAFQhyCAABZAAIAGGnZw
Date: Tue, 7 Apr 2020 04:42:02 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D80E1AD@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-2-git-send-email-yi.l.liu@intel.com>
 <20200402115017.0a0f55e2@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D807BB9@SHSMSX104.ccr.corp.intel.com>
 <20200403091424.39383958@w520.home>
In-Reply-To: <20200403091424.39383958@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, Yi
 Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

> From: Alex Williamson
> Sent: Friday, April 3, 2020 11:14 PM
> 
> On Fri, 3 Apr 2020 05:58:55 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Friday, April 3, 2020 1:50 AM
> > >
> > > On Sun, 22 Mar 2020 05:31:58 -0700
> > > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> > >
> > > > From: Liu Yi L <yi.l.liu@intel.com>
> > > >
> > > > For a long time, devices have only one DMA address space from
> platform
> > > > IOMMU's point of view. This is true for both bare metal and directed-
> > > > access in virtualization environment. Reason is the source ID of DMA in
> > > > PCIe are BDF (bus/dev/fnc ID), which results in only device granularity
> > > > DMA isolation. However, this is changing with the latest advancement in
> > > > I/O technology area. More and more platform vendors are utilizing the
> > > PCIe
> > > > PASID TLP prefix in DMA requests, thus to give devices with multiple
> DMA
> > > > address spaces as identified by their individual PASIDs. For example,
> > > > Shared Virtual Addressing (SVA, a.k.a Shared Virtual Memory) is able to
> > > > let device access multiple process virtual address space by binding the
> > > > virtual address space with a PASID. Wherein the PASID is allocated in
> > > > software and programmed to device per device specific manner.
> Devices
> > > > which support PASID capability are called PASID-capable devices. If such
> > > > devices are passed through to VMs, guest software are also able to bind
> > > > guest process virtual address space on such devices. Therefore, the
> guest
> > > > software could reuse the bare metal software programming model,
> which
> > > > means guest software will also allocate PASID and program it to device
> > > > directly. This is a dangerous situation since it has potential PASID
> > > > conflicts and unauthorized address space access. It would be safer to
> > > > let host intercept in the guest software's PASID allocation. Thus PASID
> > > > are managed system-wide.
> > >
> > > Providing an allocation interface only allows for collaborative usage
> > > of PASIDs though.  Do we have any ability to enforce PASID usage or can
> > > a user spoof other PASIDs on the same BDF?
> >
> > An user can access only PASIDs allocated to itself, i.e. the specific IOASID
> > set tied to its mm_struct.
> 
> A user is only _supposed_ to access PASIDs allocated to itself.  AIUI
> the mm_struct is used for managing the pool of IOASIDs from which the
> user may allocate that PASID.  We also state that programming the PASID
> into the device is device specific.  Therefore, are we simply trusting
> the user to use a PASID that's been allocated to them when they program
> the device?  If a user can program an arbitrary PASID into the device,
> then what prevents them from attempting to access data from another
> user via the device?   I think I've asked this question before, so if
> there's a previous explanation or spec section I need to review, please
> point me to it.  Thanks,
> 

There are two scenarios:

(1) for PF/VF, the iommu driver maintains an individual PASID table per
PDF. Although the PASID namespace is global, the per-BDF PASID table
contains only valid entries for those PASIDs which are allocated to the
mm_struct. The user is free to program arbitrary PASID into the assigned
device, but using invalid PASIDs simply hit iommu fault.

(2) for mdev, multiple mdev instances share the same PASID table of
the parent BDF. However, PASID programming is a privileged operation
in multiplexing usage, thus must be mediated by mdev device driver. 
The mediation logic will guarantee that only allocated PASIDs are 
forwarded to the device. 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

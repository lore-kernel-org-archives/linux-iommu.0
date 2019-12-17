Return-Path: <SRS0=3Hz1=2H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE25C2D0C3
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 02:26:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD1120CC7
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 02:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD1120CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A3801865A5;
	Tue, 17 Dec 2019 02:26:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m9TBzDreqyJy; Tue, 17 Dec 2019 02:26:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D331C8659E;
	Tue, 17 Dec 2019 02:26:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3B77C18DD;
	Tue, 17 Dec 2019 02:26:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDBCAC077D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 02:26:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D74952279B
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 02:26:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SzrWjZEfgKBJ for <iommu@lists.linux-foundation.org>;
 Tue, 17 Dec 2019 02:26:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id 981EE22797
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 02:26:21 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Dec 2019 18:26:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; d="scan'208";a="217366633"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga006.jf.intel.com with ESMTP; 16 Dec 2019 18:26:20 -0800
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 18:26:20 -0800
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 18:26:19 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.90]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.71]) with mapi id 14.03.0439.000;
 Tue, 17 Dec 2019 10:26:18 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David
 Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v3 5/6] iommu/vt-d: Flush PASID-based iotlb for iova
 over first level
Thread-Topic: [PATCH v3 5/6] iommu/vt-d: Flush PASID-based iotlb for iova
 over first level
Thread-Index: AQHVr8iiJX/bvAPmK0eIArQDcTD6yKe33K3QgACZjICAAndaMIACHLkAgAAFFACAAJLKQA==
Date: Tue, 17 Dec 2019 02:26:17 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A135CAB@SHSMSX104.ccr.corp.intel.com>
References: <20191211021219.8997-1-baolu.lu@linux.intel.com>
 <20191211021219.8997-6-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C25743A130C08@SHSMSX104.ccr.corp.intel.com>
 <f1e5cfea-8b11-6d72-8e57-65daea51c050@linux.intel.com>
 <A2975661238FB949B60364EF0F2C25743A132C50@SHSMSX104.ccr.corp.intel.com>
 <6a5f6695-d1fd-e7d1-3ea3-f222a1ef0e54@linux.intel.com>
 <b4a879b2-a5c7-b0bf-8cd4-7397aeebc381@linux.intel.com>
In-Reply-To: <b4a879b2-a5c7-b0bf-8cd4-7397aeebc381@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDIxNWMyOWQtMmViMi00MDliLWIwODAtMmYyNDAzZTY1ZTFkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiakNFTFFiaFZhTnNLWFNSNjY3a2FkVmpmWDBqd3JxZlQ3Q3RXektlWjYxdTdobDFzaGJSMjRWbGZtQlFROGtkTiJ9
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>,
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

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Tuesday, December 17, 2019 9:37 AM
> To: Liu, Yi L <yi.l.liu@intel.com>; Joerg Roedel <joro@8bytes.org>; David
> Woodhouse <dwmw2@infradead.org>; Alex Williamson
> <alex.williamson@redhat.com>
> Subject: Re: [PATCH v3 5/6] iommu/vt-d: Flush PASID-based iotlb for iova over first
> level
> 
> Hi again,
> 
> On 12/17/19 9:19 AM, Lu Baolu wrote:
> > Hi Yi,
> >
> > On 12/15/19 5:22 PM, Liu, Yi L wrote:
> >> Ok, let me explain more... default pasid is meaningful only when
> >> the domain has been attached to a device as an aux-domain. right?
> >
> > No exactly. Each domain has a specific default pasid, no matter normal
> > domain (RID based) or aux-domain (PASID based). The difference is for a
> > normal domain RID2PASID value is used, for an aux-domain the pasid is
> > allocated from a global pool.
> >
> > The same concept used in VT-d 3.x scalable mode. For RID based DMA
> > translation RID2PASID value is used when walking the tables; For PASID
> > based DMA translation a real pasid in the transaction is used.
> >
> >> If a domain only has one device, and it is attached to this device as
> >> normal domain (normal domain means non aux-domain here). Then
> >> you should flush cache with domain-id and RID2PASID value.
> >> If a domain has one device, and it is attached to this device as
> >> aux-domain. Then you may want to flush cache with domain-id
> >> and default pasid. right?
> >
> > A domain's counterpart is IOMMU group. So we say attach/detach domain
> > to/from devices in a group. We don't allow devices with different
> > default pasid sitting in a same group, right?
> >
> >> Then let's come to the case I mentioned in previous email. a mdev
> >> and another device assigned to a single VM. In host, you will have
> >> a domain which has two devices, one device(deva) is attached as
> >
> > No. We will have two IOMMU groups and two domains. Correct me if my
> > understanding is not right.
> 
> Reconsidered this. Unfortunately, my understanding is not right. :-(
> 
> A single domain could be attached to multiple IOMMU groups. So it
> comes to the issue you concerned. Do I understand it right?

yes. Device within the same group has no such issue since such
devices are not able to enabled aux-domain. Now our understanding
are aligned. :-)

> >
> >> normal domain, another one (devB) is attached as aux-domain. Then
> >> which pasid should be used when the mapping in IOVA page table is
> >> modified? RID2PASID or default pasid? I think both should be used
> >> since the domain means differently to the two devices. If you just
> >> use default pasid, then deva may still be able to use stale caches.
> 
> You are right. I will change it accordingly. The logic should look
> like:
> 
> if (domain attached to physical device)
> 	flush_piotlb_with_RID2PASID()
> else if (domain_attached_to_mdev_device)
> 	flush_piotlb_with_default_pasid()
> 
> Does this work for you? Thanks for catching this!

If no else, it would work for scalable mode. ^_^ I noticed you've
already corrected by yourself in another reply. :-) Look forward to
your next version.

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

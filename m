Return-Path: <SRS0=eP4Y=2X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE58FC3F68F
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 02:31:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1CBF21734
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 02:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CBF21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6CF90203F1;
	Thu,  2 Jan 2020 02:31:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hSYFgap6xh+L; Thu,  2 Jan 2020 02:31:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CC10D20349;
	Thu,  2 Jan 2020 02:31:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADB4DC18DC;
	Thu,  2 Jan 2020 02:31:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6FF7C077D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 02:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C9E7F85C19
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 02:31:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k-ZFPZI9fSp0 for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jan 2020 02:31:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EA8BA855D9
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 02:31:35 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Jan 2020 18:31:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,385,1571727600"; d="scan'208";a="214027892"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga008.jf.intel.com with ESMTP; 01 Jan 2020 18:31:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Jan 2020 18:31:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 1 Jan 2020 18:31:34 -0800
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 1 Jan 2020 18:31:33 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.197]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.210]) with mapi id 14.03.0439.000;
 Thu, 2 Jan 2020 10:31:32 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "David Woodhouse" <dwmw2@infradead.org>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v5 0/9] Use 1st-level for IOVA translation
Thread-Topic: [PATCH v5 0/9] Use 1st-level for IOVA translation
Thread-Index: AQHVui4+6HcDuwA4D0+pjZyofYKB+6fV/qOAgAC12FA=
Date: Thu, 2 Jan 2020 02:31:32 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A16466C@SHSMSX104.ccr.corp.intel.com>
References: <20191224074502.5545-1-baolu.lu@linux.intel.com>
 <8b40dd00-3bec-1fd9-9ba7-0db9fd727e52@linux.intel.com>
In-Reply-To: <8b40dd00-3bec-1fd9-9ba7-0db9fd727e52@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWYzNWFjNDMtMTRlYS00ZjgwLWE1ZDMtYjdhY2U4NjlmMmM5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicldPcldjQUpQUExcL3ZLRkczaWRlWUx5T01GUkVxWkxlY2VoRlBXUXlBY05OTktpb08xeTBieG5HTjYwOTZTQjMifQ==
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
> Sent: Thursday, January 2, 2020 7:38 AM
> To: Joerg Roedel <joro@8bytes.org>; David Woodhouse <dwmw2@infradead.org>;
> Alex Williamson <alex.williamson@redhat.com>
> Subject: Re: [PATCH v5 0/9] Use 1st-level for IOVA translation
> 
> On 12/24/19 3:44 PM, Lu Baolu wrote:
> > Intel VT-d in scalable mode supports two types of page tables for DMA
> > translation: the first level page table and the second level page
> > table. The first level page table uses the same format as the CPU page
> > table, while the second level page table keeps compatible with
> > previous formats. The software is able to choose any one of them for
> > DMA remapping according to the use case.
> >
> > This patchset aims to move IOVA (I/O Virtual Address) translation to
> > 1st-level page table in scalable mode. This will simplify vIOMMU
> > (IOMMU simulated by VM hypervisor) design by using the two-stage
> > translation, a.k.a. nested mode translation.
> >
> > As Intel VT-d architecture offers caching mode, guest IOVA (GIOVA)
> > support is currently implemented in a shadow page manner. The device
> > simulation software, like QEMU, has to figure out GIOVA->GPA mappings
> > and write them to a shadowed page table, which will be used by the
> > physical IOMMU. Each time when mappings are created or destroyed in
> > vIOMMU, the simulation software has to intervene. Hence, the changes
> > on GIOVA->GPA could be shadowed to host.
> >
> >
> >       .-----------.
> >       |  vIOMMU   |
> >       |-----------|                 .--------------------.
> >       |           |IOTLB flush trap |        QEMU        |
> >       .-----------. (map/unmap)     |--------------------|
> >       |GIOVA->GPA |---------------->|    .------------.  |
> >       '-----------'                 |    | GIOVA->HPA |  |
> >       |           |                 |    '------------'  |
> >       '-----------'                 |                    |
> >                                     |                    |
> >                                     '--------------------'
> >                                                  |
> >              <------------------------------------
> >              |
> >              v VFIO/IOMMU API
> >        .-----------.
> >        |  pIOMMU   |
> >        |-----------|
> >        |           |
> >        .-----------.
> >        |GIOVA->HPA |
> >        '-----------'
> >        |           |
> >        '-----------'
> >
> > In VT-d 3.0, scalable mode is introduced, which offers two-level
> > translation page tables and nested translation mode. Regards to GIOVA
> > support, it can be simplified by 1) moving the GIOVA support over
> > 1st-level page table to store GIOVA->GPA mapping in vIOMMU,
> > 2) binding vIOMMU 1st level page table to the pIOMMU, 3) using pIOMMU
> > second level for GPA->HPA translation, and 4) enable nested (a.k.a.
> > dual-stage) translation in host. Compared with current shadow GIOVA
> > support, the new approach makes the vIOMMU design simpler and more
> > efficient as we only need to flush the pIOMMU IOTLB and possible
> > device-IOTLB when an IOVA mapping in vIOMMU is torn down.
> >
> >       .-----------.
> >       |  vIOMMU   |
> >       |-----------|                 .-----------.
> >       |           |IOTLB flush trap |   QEMU    |
> >       .-----------.    (unmap)      |-----------|
> >       |GIOVA->GPA |---------------->|           |
> >       '-----------'                 '-----------'
> >       |           |                       |
> >       '-----------'                       |
> >             <------------------------------
> >             |      VFIO/IOMMU
> >             |  cache invalidation and
> >             | guest gpd bind interfaces
> >             v
> >       .-----------.
> >       |  pIOMMU   |
> >       |-----------|
> >       .-----------.
> >       |GIOVA->GPA |<---First level
> >       '-----------'
> >       | GPA->HPA  |<---Scond level
> >       '-----------'
> >       '-----------'
> >
> > This patch applies the first level page table for IOVA translation
> > unless the DOMAIN_ATTR_NESTING domain attribution has been set.
> > Setting of this attribution means the second level will be used to map
> > gPA (guest physical address) to hPA (host physical address), and the
> > mappings between gVA (guest virtual address) and gPA will be
> > maintained by the guest with the page table address binding to host's
> > first level.
> >
> > Based-on-idea-by: Ashok Raj<ashok.raj@intel.com>
> > Based-on-idea-by: Kevin Tian<kevin.tian@intel.com>
> > Based-on-idea-by: Liu Yi L<yi.l.liu@intel.com>
> > Based-on-idea-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> > Based-on-idea-by: Sanjay Kumar<sanjay.k.kumar@intel.com>
> > Based-on-idea-by: Lu Baolu<baolu.lu@linux.intel.com>
> 
> Queued all patches for v5.6.

Reviewed-by: Liu Yi L <yi.l.liu@intel.com>

Aha, looks like I forgot to give my Reviewed-by after offline review..
Yeah, this patchset looks good to me.

Regards,
Yi Liu

> Thanks,
> -baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=3N47=YS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC404CA9EBD
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 08:59:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A019821D71
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 08:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A019821D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 517E9C64;
	Fri, 25 Oct 2019 08:59:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3002EC5D
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 08:59:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8316A896
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 08:59:04 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Oct 2019 01:59:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; d="scan'208";a="373495942"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
	by orsmga005.jf.intel.com with ESMTP; 25 Oct 2019 01:59:03 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
	fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Fri, 25 Oct 2019 01:59:02 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Fri, 25 Oct 2019 01:59:02 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.166]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.96]) with mapi id
	14.03.0439.000; Fri, 25 Oct 2019 16:59:01 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [RFC v2 0/3] vfio: support Shared Virtual Addressing
Thread-Topic: [RFC v2 0/3] vfio: support Shared Virtual Addressing
Thread-Index: AQHVimn0xqxsZsa/L0O4OV3WQFai5qdrD9Rw
Date: Fri, 25 Oct 2019 08:59:00 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D5D0413@SHSMSX104.ccr.corp.intel.com>
References: <1571919983-3231-1-git-send-email-yi.l.liu@intel.com>
In-Reply-To: <1571919983-3231-1-git-send-email-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2VlOTczMzktYzNmNS00NTc1LWEwNTQtZGMwYWRmMTBlZjVkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiN2tlaGxSTjBZQWJ3WnNIdkZyWnNMNWxlOFc0aHo4MUdWWlhUcTNGTUpWN05rOG5nTW1XMm5RSHp3bWl0bGdpQiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
	"Tian, Jun J" <jun.j.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

> From: Liu Yi L
> Sent: Thursday, October 24, 2019 8:26 PM
> 
> Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on Intel
> platforms allow address space sharing between device DMA and
> applications.
> SVA can reduce programming complexity and enhance security.
> This series is intended to expose SVA capability to VMs. i.e. shared guest
> application address space with passthru devices. The whole SVA
> virtualization
> requires QEMU/VFIO/IOMMU changes. This series includes the VFIO
> changes, for
> QEMU and IOMMU changes, they are in separate series (listed in the
> "Related
> series").
> 
> The high-level architecture for SVA virtualization is as below:
> 
>     .-------------.  .---------------------------.
>     |   vIOMMU    |  | Guest process CR3, FL only|
>     |             |  '---------------------------'
>     .----------------/
>     | PASID Entry |--- PASID cache flush -
>     '-------------'                       |
>     |             |                       V
>     |             |                CR3 in GPA
>     '-------------'
> Guest
> ------| Shadow |--------------------------|--------
>       v        v                          v
> Host
>     .-------------.  .----------------------.
>     |   pIOMMU    |  | Bind FL for GVA-GPA  |
>     |             |  '----------------------'
>     .----------------/  |
>     | PASID Entry |     V (Nested xlate)
>     '----------------\.------------------------------.
>     |             |   |SL for GPA-HPA, default domain|
>     |             |   '------------------------------'
>     '-------------'
> Where:
>  - FL = First level/stage one page tables
>  - SL = Second level/stage two page tables
> 
> There are roughly three parts in this patchset which are
> corresponding to the basic vSVA support for PCI device
> assignment
>  1. vfio support for PASID allocation and free from VMs
>  2. vfio support for guest PASID binding from VMs
>  3. vfio support for IOMMU cache invalidation from VMs
> 
> The complete vSVA upstream patches are divided into three phases:
>     1. Common APIs and PCI device direct assignment
>     2. Page Request Services (PRS) support
>     3. Mediated device assignment
> 
> This RFC patchset is aiming for the phase 1, and works together with the
> VT-d driver[1] changes and QEMU changes[2]. Complete set for vSVA can
> be
> found in:
> https://github.com/jacobpan/linux.git:siov_sva.
> 
> And this patchset doesn't include the patch to expose PASID capability to
> guest. This is expected to be in another series.
> 
> Related series:
> [1] [PATCH v6 00/10] Nested Shared Virtual Address (SVA) VT-d support:
> https://lkml.org/lkml/2019/10/22/953
> <This series is based on this kernel series from Jacob Pan>
> 
> [2] [RFC v2 00/20] intel_iommu: expose Shared Virtual Addressing to VM
> from Yi Liu

there is no link, and should be [RFC v2 00/22]

> 
> Changelog:
> 	- RFC v1 -> v2:
> 	  Dropped vfio: VFIO_IOMMU_ATTACH/DETACH_PASID_TABLE.
> 	  RFC v1: https://patchwork.kernel.org/cover/11033699/
> 
> Liu Yi L (3):
>   vfio: VFIO_IOMMU_CACHE_INVALIDATE
>   vfio/type1: VFIO_IOMMU_PASID_REQUEST(alloc/free)
>   vfio/type1: bind guest pasid (guest page tables) to host
> 
>  drivers/vfio/vfio_iommu_type1.c | 305
> ++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       |  82 +++++++++++
>  2 files changed, 387 insertions(+)
> 
> --
> 2.7.4
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

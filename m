Return-Path: <SRS0=byW0=34=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979A5C35250
	for <iommu@archiver.kernel.org>; Sat,  8 Feb 2020 07:46:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B9821775
	for <iommu@archiver.kernel.org>; Sat,  8 Feb 2020 07:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B9821775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4EB6B87F92;
	Sat,  8 Feb 2020 07:46:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kz3XSyuhcCnr; Sat,  8 Feb 2020 07:46:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 78C3387ED2;
	Sat,  8 Feb 2020 07:46:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6436DC089F;
	Sat,  8 Feb 2020 07:46:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2FCEC013E
 for <iommu@lists.linux-foundation.org>; Sat,  8 Feb 2020 07:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E735D203E2
 for <iommu@lists.linux-foundation.org>; Sat,  8 Feb 2020 07:46:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KSgwCkldVxZY for <iommu@lists.linux-foundation.org>;
 Sat,  8 Feb 2020 07:46:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by silver.osuosl.org (Postfix) with ESMTPS id F1C2420385
 for <iommu@lists.linux-foundation.org>; Sat,  8 Feb 2020 07:46:32 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Feb 2020 23:46:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,416,1574150400"; d="scan'208";a="431096976"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga005.fm.intel.com with ESMTP; 07 Feb 2020 23:46:31 -0800
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 7 Feb 2020 23:46:31 -0800
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 7 Feb 2020 23:46:31 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.5]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.98]) with mapi id 14.03.0439.000;
 Sat, 8 Feb 2020 15:46:29 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [RFC v1 0/2] vfio/pci: expose device's PASID capability to VMs
Thread-Topic: [RFC v1 0/2] vfio/pci: expose device's PASID capability to VMs
Thread-Index: AQHV1p2L6Ox9Ls63fUG3sLdpayIPaagQ+k+g
Date: Sat, 8 Feb 2020 07:46:28 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A1B57BC@SHSMSX104.ccr.corp.intel.com>
References: <1580300325-86259-1-git-send-email-yi.l.liu@intel.com>
In-Reply-To: <1580300325-86259-1-git-send-email-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjExNjc0ZWMtMWU1NS00YTIyLTgwMTMtODkwYWExMjBhODg0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRUtqNWlmRmZBa1VrZFVtS2x3emNaRUJLYjd2azQ2U0NjRm5sdVMwY0xuQjkwUkZRV0Jxa0lJTlV4d25TZ1R6SyJ9
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

Any comment on this series?

Regards,
Yi Liu

> From: Liu, Yi L
> Sent: Wednesday, January 29, 2020 8:19 PM
> To: alex.williamson@redhat.com; eric.auger@redhat.com
> Subject: [RFC v1 0/2] vfio/pci: expose device's PASID capability to VMs
> 
> Shared Virtual Addressing (SVA), a.k.a, Shared Virtual Memory (SVM) on Intel
> platforms allows address space sharing between device DMA and applications. SVA
> can reduce programming complexity and enhance security.
> 
> To enable SVA, device needs to have PASID capability, which is a key capability for
> SVA. This patchset exposes the device's PASID capability to guest instead of hiding it
> from guest.
> 
> The second patch emulates PASID capability for VFs (Virtual Function) since VFs don't
> implement such capability per PCIe spec. This patch emulates such capability and
> expose to VM if the capability is enabled in PF (Physical Function).
> 
> However, there is an open for PASID emulation. If PF driver disables PASID capability
> at runtime, then it may be an issue. e.g. PF should not disable PASID capability if
> there is guest using this capability on any VF related to this PF. To solve it, may need
> to introduce a generic communication framework between vfio-pci driver and PF
> drivers. Please feel free to give your suggestions on it.
> 
> Liu Yi L (2):
>   vfio/pci: Expose PCIe PASID capability to guest
>   vfio/pci: Emulate PASID/PRI capability for VFs
> 
>  drivers/vfio/pci/vfio_pci_config.c | 321
> ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 318 insertions(+), 3 deletions(-)
> 
> --
> 2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

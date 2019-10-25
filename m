Return-Path: <SRS0=3N47=YS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12285C47E49
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 11:18:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75D12070B
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 11:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75D12070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BF98513A8;
	Fri, 25 Oct 2019 11:18:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 353F213A4
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 11:18:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D2A4387B
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 11:18:22 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Oct 2019 04:18:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; d="scan'208";a="228867398"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
	by fmsmga002.fm.intel.com with ESMTP; 25 Oct 2019 04:18:22 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
	FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Fri, 25 Oct 2019 04:18:22 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
	fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Fri, 25 Oct 2019 04:18:22 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.166]) by
	SHSMSX107.ccr.corp.intel.com ([169.254.9.33]) with mapi id
	14.03.0439.000; Fri, 25 Oct 2019 19:18:20 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [RFC v2 0/3] vfio: support Shared Virtual Addressing
Thread-Topic: [RFC v2 0/3] vfio: support Shared Virtual Addressing
Thread-Index: AQHVimn0oLFAYNI450OWskxUmwKVe6dqifEAgACsm1A=
Date: Fri, 25 Oct 2019 11:18:19 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0D7C07@SHSMSX104.ccr.corp.intel.com>
References: <1571919983-3231-1-git-send-email-yi.l.liu@intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5D0413@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D5D0413@SHSMSX104.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2VlOTczMzktYzNmNS00NTc1LWEwNTQtZGMwYWRmMTBlZjVkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiN2tlaGxSTjBZQWJ3WnNIdkZyWnNMNWxlOFc0aHo4MUdWWlhUcTNGTUpWN05rOG5nTW1XMm5RSHp3bWl0bGdpQiJ9
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

Hi Kevin,

> From: Tian, Kevin
> Sent: Friday, October 25, 2019 4:59 PM
> To: Liu, Yi L <yi.l.liu@intel.com>; alex.williamson@redhat.com;
> Subject: RE: [RFC v2 0/3] vfio: support Shared Virtual Addressing
> 
> > From: Liu Yi L
> > Sent: Thursday, October 24, 2019 8:26 PM
> >
> > Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on
> > Intel platforms allow address space sharing between device DMA and
> > applications.
> > SVA can reduce programming complexity and enhance security.
> > This series is intended to expose SVA capability to VMs. i.e. shared
> > guest application address space with passthru devices. The whole SVA
> > virtualization requires QEMU/VFIO/IOMMU changes. This series includes
> > the VFIO changes, for QEMU and IOMMU changes, they are in separate
> > series (listed in the "Related series").
> >
> > The high-level architecture for SVA virtualization is as below:
> >
[...]
> >
> > Related series:
> > [1] [PATCH v6 00/10] Nested Shared Virtual Address (SVA) VT-d support:
> > https://lkml.org/lkml/2019/10/22/953
> > <This series is based on this kernel series from Jacob Pan>
> >
> > [2] [RFC v2 00/20] intel_iommu: expose Shared Virtual Addressing to VM
> > from Yi Liu
> 
> there is no link, and should be [RFC v2 00/22]

The link is not generated at the time this series is sent out. Yeah, should be [RFC v2 0/22].
Thanks for spotting it.

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

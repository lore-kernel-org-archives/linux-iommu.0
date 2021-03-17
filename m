Return-Path: <SRS0=kdPY=IP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB292C433DB
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 19:14:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1DF64F30
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 19:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1DF64F30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0B446F973;
	Wed, 17 Mar 2021 19:14:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d5cjabNCd3Np; Wed, 17 Mar 2021 19:14:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6E7760670;
	Wed, 17 Mar 2021 19:14:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A29EC000A;
	Wed, 17 Mar 2021 19:14:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A31AC0001
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 19:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 286D9831EF
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 19:14:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SCsQaz_TLSDb for <iommu@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 19:14:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A2CA83131
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 19:14:20 +0000 (UTC)
IronPort-SDR: ZbSsz7y78aliotIoqc0Yx0sA5lvVDwZ/DuxdHtQwLxw0fvfzXcxIxS0gHeFMlaPAP7xwVncMpO
 kCRCyfC9Qd8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="177125902"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; d="scan'208";a="177125902"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2021 12:14:19 -0700
IronPort-SDR: YwYHs2w9lumWpuB08p5WHfrA6CMiVs4J43sVUpgCMIbQmeEwSRHThJB0srKbMhFMS0wjZIfGjS
 hYv3XMYCEX6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; d="scan'208";a="406048973"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by fmsmga008.fm.intel.com with ESMTP; 17 Mar 2021 12:14:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Mar 2021 12:14:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Mar 2021 12:14:18 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Wed, 17 Mar 2021 12:14:18 -0700
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v4 0/2] VMD MSI Remapping Bypass
Thread-Topic: [PATCH v4 0/2] VMD MSI Remapping Bypass
Thread-Index: AQHW/8ernlIsBQTka0W7z8h+KA9vr6qJOSKA
Date: Wed, 17 Mar 2021 19:14:17 +0000
Message-ID: <0a70914085c25cf99536d106a280b27819328fff.camel@intel.com>
References: <20210210161315.316097-1-jonathan.derrick@intel.com>
In-Reply-To: <20210210161315.316097-1-jonathan.derrick@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.132]
Content-ID: <3D316745D3F3BF4A84092E28A6E5659A@intel.com>
MIME-Version: 1.0
Cc: "kw@linux.com" <kw@linux.com>, "Patel, Nirmal" <nirmal.patel@intel.com>,
 "Karkra, Kapil" <kapil.karkra@intel.com>,
 "helgaas@kernel.org" <helgaas@kernel.org>
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

Gentle reminder, for v5.13 ?

On Wed, 2021-02-10 at 09:13 -0700, Jon Derrick wrote:
> The Intel Volume Management Device acts similar to a PCI-to-PCI bridge in that
> it changes downstream devices' requester-ids to its own. As VMD supports PCIe
> devices, it has its own MSI-X table and transmits child device MSI-X by
> remapping child device MSI-X and handling like a demultiplexer.
> 
> Some newer VMD devices (Icelake Server) have an option to bypass the VMD MSI-X
> remapping table. This allows for better performance scaling as the child device
> MSI-X won't be limited by VMD's MSI-X count and IRQ handler.
> 
> V3->V4:
> Integrated wording suggestions; no functional changes
> 
> V2->V3:
> Trivial comment fixes
> Added acks
> 
> V1->V2:
> Updated for 5.12-next
> Moved IRQ allocation and remapping enable/disable to a more logical location
> 
> V1 patches 1-4 were already merged
> V1, 5/6: https://patchwork.kernel.org/project/linux-pci/patch/20200728194945.14126-6-jonathan.derrick@intel.com/
> V1, 6/6: https://patchwork.kernel.org/project/linux-pci/patch/20200728194945.14126-7-jonathan.derrick@intel.com/
> 
> 
> Jon Derrick (2):
>   iommu/vt-d: Use Real PCI DMA device for IRTE
>   PCI: vmd: Disable MSI-X remapping when possible
> 
>  drivers/iommu/intel/irq_remapping.c |  3 +-
>  drivers/pci/controller/vmd.c        | 63 +++++++++++++++++++++++------
>  2 files changed, 53 insertions(+), 13 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

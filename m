Return-Path: <SRS0=4b30=26=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5386C282DD
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 15:08:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF369206ED
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 15:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF369206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 976F220133;
	Thu,  9 Jan 2020 15:08:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JBBxJ+zv32gN; Thu,  9 Jan 2020 15:08:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 529EC20429;
	Thu,  9 Jan 2020 15:08:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A739C1796;
	Thu,  9 Jan 2020 15:08:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F0C2C0881
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 15:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 61D2820429
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 15:08:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GLajJr492tlE for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jan 2020 15:08:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id C58BA20133
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 15:08:14 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jan 2020 07:08:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; d="scan'208";a="216325838"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
 by orsmga008.jf.intel.com with ESMTP; 09 Jan 2020 07:08:13 -0800
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 07:08:12 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.147]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.106]) with mapi id 14.03.0439.000;
 Thu, 9 Jan 2020 07:08:12 -0800
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC 4/5] PCI: vmd: Stop overriding dma_map_ops
Thread-Topic: [RFC 4/5] PCI: vmd: Stop overriding dma_map_ops
Thread-Index: AQHVwEr2z5uOBWDiDkm1r7T32HJ+B6fi+c6AgAAI7gA=
Date: Thu, 9 Jan 2020 15:08:11 +0000
Message-ID: <a75078a7a12f17c37782afd55bb97fece63752d5.camel@intel.com>
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com>
 <1577823863-3303-5-git-send-email-jonathan.derrick@intel.com>
 <20200109143613.GC22656@lst.de>
In-Reply-To: <20200109143613.GC22656@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.4.146]
Content-ID: <103EAB059B28094091CCBFEC61F26E7D@intel.com>
MIME-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "helgaas@kernel.org" <helgaas@kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
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

On Thu, 2020-01-09 at 15:36 +0100, Christoph Hellwig wrote:
> On Tue, Dec 31, 2019 at 01:24:22PM -0700, Jon Derrick wrote:
> > Devices on the VMD domain use the VMD endpoint's requester-id and have
> > been relying on the VMD endpoint's dma operations. The downside of this
> > was that VMD domain devices would use the VMD endpoint's attributes when
> > doing DMA and IOMMU mapping. We can be smarter about this by only using
> > the VMD endpoint when mapping and providing the correct child device's
> > attributes during dma operations.
> > 
> > This patch adds a new dma alias mechanism by adding a hint to a pci_dev
> > to point to a singular DMA requester's pci_dev. This integrates into the
> > existing dma alias infrastructure to reduce the impact of the changes
> > required to support this mode.
> 
> If we want to lift this check into common code I think it should go
> into struct device, as that is what DMA operates on normally.
I thought about that too, but the dma alias mechanism was in pci_dev. I
can prepare a new version with struct device.

>   That
> being said given that this insane hack only exists for braindamage in
> Intel hardware I'd rather keep it as isolated as possible. 
jmho but the footprint of the new set is pretty minimal and removes a
lot of dubious code in vmd.c.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=4b30=26=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DF1C282DD
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 23:37:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D89C12072E
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 23:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89C12072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B209288341;
	Thu,  9 Jan 2020 23:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d2cqrIm7PO+T; Thu,  9 Jan 2020 23:37:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A720C8833D;
	Thu,  9 Jan 2020 23:37:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A480C1796;
	Thu,  9 Jan 2020 23:37:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BDBCC0881
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 23:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 410E02045E
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 23:37:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iPaFvv1TnXv2 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jan 2020 23:37:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id 7F3B220455
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 23:37:26 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jan 2020 15:37:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; d="scan'208";a="246825563"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
 by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2020 15:37:25 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.147]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.81]) with mapi id 14.03.0439.000;
 Thu, 9 Jan 2020 15:37:25 -0800
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH v2 3/5] PCI: Introduce direct dma alias
Thread-Topic: [PATCH v2 3/5] PCI: Introduce direct dma alias
Thread-Index: AQHVxywXwoQKE3+vlUKZwoCX2cxUfafjfBGAgAAHMAA=
Date: Thu, 9 Jan 2020 23:37:24 +0000
Message-ID: <f0e837bca2bd141e529dbd5817b52d77cea87ddd.camel@intel.com>
References: <20200109231141.GA41540@google.com>
In-Reply-To: <20200109231141.GA41540@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.159]
Content-ID: <DF859B91DC1D2F4182403F4327729D56@intel.com>
MIME-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "hch@lst.de" <hch@lst.de>
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

On Thu, 2020-01-09 at 17:11 -0600, Bjorn Helgaas wrote:
> In subject:
> s/Introduce direct dma alias/Add pci_direct_dma_alias()/
> 
> On Thu, Jan 09, 2020 at 07:30:54AM -0700, Jon Derrick wrote:
> > The current dma alias implementation requires the aliased device be on
> > the same bus as the dma parent. This introduces an arch-specific
> > mechanism to point to an arbitrary struct device when doing mapping and
> > pci alias search.
> 
> "arbitrary struct device" is a little weird since an arbitrary device
> doesn't have to be a PCI device, but these mappings and aliases only
> make sense in the PCI domain.
> 
> Maybe it has something to do with pci_sysdata.vmd_dev being a
> "struct device *" rather than a "struct pci_dev *"?  I don't know why
> that is, because it looks like every place you use it, you use
> to_pci_dev() to get the pci_dev pointer back anyway.  But I assume you
> have some good reason for that.
No particular reason other than to align with the suggestion in the
last set to be using the struct device. It does make sense to reference
the struct device as that provides the dma context, however as you have
pointed out, the implementation here moreso needs the device's
pci_dev. 

I'll see how it looks for the next set.

> 
> s/dma/DMA/
> s/pci/PCI/
> (above and also in code comments below)
> 
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

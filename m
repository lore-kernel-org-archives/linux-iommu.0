Return-Path: <SRS0=Te3Q=WX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E4DC3A5A6
	for <iommu@archiver.kernel.org>; Tue, 27 Aug 2019 18:24:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8E022CBB
	for <iommu@archiver.kernel.org>; Tue, 27 Aug 2019 18:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8E022CBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 81E9D1B26;
	Tue, 27 Aug 2019 18:24:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 145721380
	for <iommu@lists.linux-foundation.org>;
	Tue, 27 Aug 2019 18:24:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A13BE89B
	for <iommu@lists.linux-foundation.org>;
	Tue, 27 Aug 2019 18:24:07 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	27 Aug 2019 11:24:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; d="scan'208";a="171282551"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
	by orsmga007.jf.intel.com with ESMTP; 27 Aug 2019 11:24:06 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
	ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Tue, 27 Aug 2019 11:24:06 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.119]) by
	ORSMSX154.amr.corp.intel.com ([169.254.11.172]) with mapi id
	14.03.0439.000; Tue, 27 Aug 2019 11:24:06 -0700
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] vmd: Stop overriding dma_map_ops
Thread-Topic: [PATCH] vmd: Stop overriding dma_map_ops
Thread-Index: AQHVXB/0iQzKFLmxFEGBMerx1QuVCqcPxk4A
Date: Tue, 27 Aug 2019 18:24:05 +0000
Message-ID: <8cad7eb5b5b37aeb041fd0c464383bb5223e4a64.camel@intel.com>
References: <20190826150652.10316-1-hch@lst.de>
In-Reply-To: <20190826150652.10316-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.165]
Content-ID: <CBA8577B2F8C794E8AE831CFFD893777@intel.com>
MIME-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Busch, Keith" <keith.busch@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>
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

On Mon, 2019-08-26 at 17:06 +0200, Christoph Hellwig wrote:
> With a little tweak to the intel-iommu code we should be able to work
> around the VMD mess for the requester IDs without having to create giant
> amounts of boilerplate DMA ops wrapping code.  The other advantage of
> this scheme is that we can respect the real DMA masks for the actual
> devices, and I bet it will only be a matter of time until we'll see the
> first DMA challeneged NVMe devices.
> 
> The only downside is that we can't offer vmd as a module given that
> intel-iommu calls into it.  But the driver only has about 700 lines
> of code, so this should not be a major issue.
If we're going to remove its ability to be a module, and given its
small size, could we make this default =y?

Otherwise we risk breaking platforms which have it enabled with OSVs
who miss enabling it


> 
> This also removes the leftover bits of the X86_DEV_DMA_OPS dma_map_ops
> registry.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 

lgtm otherwise

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

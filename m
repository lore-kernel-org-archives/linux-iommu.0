Return-Path: <SRS0=E0xS=ZG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEA2C432C3
	for <iommu@archiver.kernel.org>; Thu, 14 Nov 2019 08:14:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63374206EF
	for <iommu@archiver.kernel.org>; Thu, 14 Nov 2019 08:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63374206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 04DA2AD0;
	Thu, 14 Nov 2019 08:14:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D2AA9A67
	for <iommu@lists.linux-foundation.org>;
	Thu, 14 Nov 2019 08:14:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5F969CF
	for <iommu@lists.linux-foundation.org>;
	Thu, 14 Nov 2019 08:14:28 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B6EC68BFE; Thu, 14 Nov 2019 09:14:23 +0100 (CET)
Date: Thu, 14 Nov 2019 09:14:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 02/10] iommu/vt-d: Use per-device dma_ops
Message-ID: <20191114081423.GA27407@lst.de>
References: <20190725031717.32317-3-baolu.lu@linux.intel.com>
	<20190725054413.GC24527@lst.de>
	<bc831f88-5b19-7531-00aa-a7577dd5c1ac@linux.intel.com>
	<20190725114348.GA30957@lst.de>
	<a098359a-0f89-6028-68df-9f83718df256@linux.intel.com>
	<20191112071640.GA3343@lst.de>
	<0885617e-8390-6d18-987f-40d49f9f563e@linux.intel.com>
	<20191113070312.GA2735@lst.de> <20191113095353.GA5937@lst.de>
	<0ddc8aff-783a-97b9-f5cc-9e27990de278@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0ddc8aff-783a-97b9-f5cc-9e27990de278@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: alan.cox@intel.com, Christoph Hellwig <hch@lst.de>,
	Stefano Stabellini <sstabellini@kernel.org>, ashok.raj@intel.com,
	Jonathan Corbet <corbet@lwn.net>, pengfei.xu@intel.com,
	Ingo Molnar <mingo@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	mika.westerberg@linux.intel.com, Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	jacob.jun.pan@intel.com, Robin Murphy <robin.murphy@arm.com>
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

On Thu, Nov 14, 2019 at 01:14:11PM +0800, Lu Baolu wrote:
> Could you please educate me what dma_supported() is exactly for? Will
> it always get called during boot? When will it be called?

->dma_supported is set when setting either the dma_mask or
dma_coherent_mask. These days it serves too primary purposes: reject
too small masks that can't be addressed, and provide any hooks needed
in the driver based on the mask.

> In above implementation, why do we need to check dma_direct_supported()
> at the beginning? And why

Because the existing driver called dma_direct_supported, which I added
based on x86 arch overrides doings the same a while ago.  I suspect
it is related to addressing for tiny dma masks, but I'm not entirely
sure.  The longer term intel-iommu maintainers or x86 maintainers might
be able to shed more light how this was supposed to work and/or how
systems with the Intel IOMMU deal with e.g. ISA devices with 24-bit
addressing.

>
> 	if (!info || info == DUMMY_DEVICE_DOMAIN_INFO ||
> 			info == DEFER_DEVICE_DOMAIN_INFO) {
> 		dev->dma_ops_bypass = true;

This was supposed to transform the checks from iommu_dummy and
identity_mapping.  But I think it actually isn't entirely correct and
already went bad in the patch to remove identity_mapping.  Pleae check 
the branch I just re-pushed, which should be correct now.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

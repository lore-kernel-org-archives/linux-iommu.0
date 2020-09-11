Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2B6C43461
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 07:17:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38FB2075A
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 07:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38FB2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C03A68773D;
	Fri, 11 Sep 2020 07:17:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 140r6khBodyl; Fri, 11 Sep 2020 07:17:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 510D287739;
	Fri, 11 Sep 2020 07:17:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33446C0052;
	Fri, 11 Sep 2020 07:17:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67BB6C0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 309DD2288F
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:17:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VQV2Ms8pDzfk for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 07:17:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id 813F022817
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:17:56 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1376068B02; Fri, 11 Sep 2020 09:17:52 +0200 (CEST)
Date: Fri, 11 Sep 2020 09:17:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 12/12] dma-mapping: move the
 dma_declare_coherent_memory documentation
Message-ID: <20200911071751.GG22394@lst.de>
References: <20200908164758.3177341-1-hch@lst.de>
 <20200908164758.3177341-13-hch@lst.de>
 <07c51b70-fb7d-cf44-b5c3-54e3148c11ae@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <07c51b70-fb7d-cf44-b5c3-54e3148c11ae@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
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

On Thu, Sep 10, 2020 at 02:51:47PM +0100, Robin Murphy wrote:
> On 2020-09-08 17:47, Christoph Hellwig wrote:
>> dma_declare_coherent_memory should not be in a DMA API guide aimed
>> at driver writers (that is consumers of the API).  Move it to a comment
>> near the function instead.
>
> I still think there might be an occasional valid use for device-local 
> memory outside the scope of platform code without the driver having to go 
> full ZONE_DEVICE/HMM/TTM, e.g. with stuff like PCIe-based FPGA prototyping 
> cards, but the kind of driver I'm imagining for that case would never be 
> upstream anyway (if it were even written, rather than just using hard-coded 
> hacks), so meh.

And I'm not sure this would be the right interface for it.  E.g. NVMe
has the concept of a Controller Memory buffer (and a similar persistent
variant not supported by Linux), where the device can do this local DMA
(in a completely broken way that relies on correlating addresses seen
by the device and those by the host, but that's another disgression).
But that memory obviously can also be addresses by other devices using
PCIe P2P transactions which would also be useful for any HMM-ish devices,
so we'd need to expose it as P2P memory anyay..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

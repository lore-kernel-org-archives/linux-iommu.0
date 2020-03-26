Return-Path: <SRS0=Ybkk=5L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421A5C43331
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 17:05:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9B52076A
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 17:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9B52076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EB9D226291;
	Thu, 26 Mar 2020 17:05:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JMNjkgBRvjhZ; Thu, 26 Mar 2020 17:05:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8C06C2153D;
	Thu, 26 Mar 2020 17:05:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F47EC1D7C;
	Thu, 26 Mar 2020 17:05:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0804C0177
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 17:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CB0B988587
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 17:05:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9T61-2FFW5s7 for <iommu@lists.linux-foundation.org>;
 Thu, 26 Mar 2020 17:05:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4E7A78857E
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 17:05:21 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id CF3D2227A81; Thu, 26 Mar 2020 18:05:16 +0100 (CET)
Date: Thu, 26 Mar 2020 18:05:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
Message-ID: <20200326170516.GB6387@lst.de>
References: <20200326162922.27085-1-graf@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200326162922.27085-1-graf@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Mark Rutland <mark.rutland@arm.com>, benh@amazon.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, aggh@amazon.com, alcioa@amazon.com,
 iommu@lists.linux-foundation.org, aagch@amazon.com, dhr@amazon.com,
 dwmw@amazon.com, Robin Murphy <robin.murphy@arm.com>,
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

On Thu, Mar 26, 2020 at 05:29:22PM +0100, Alexander Graf wrote:
> The swiotlb is a very convenient fallback mechanism for bounce buffering of
> DMAable data. It is usually used for the compatibility case where devices
> can only DMA to a "low region".
> 
> However, in some scenarios this "low region" may be bound even more
> heavily. For example, there are embedded system where only an SRAM region
> is shared between device and CPU. There are also heterogeneous computing
> scenarios where only a subset of RAM is cache coherent between the
> components of the system. There are partitioning hypervisors, where
> a "control VM" that implements device emulation has limited view into a
> partition's memory for DMA capabilities due to safety concerns.
> 
> This patch adds a command line driven mechanism to move all DMA memory into
> a predefined shared memory region which may or may not be part of the
> physical address layout of the Operating System.
> 
> Ideally, the typical path to set this configuration would be through Device
> Tree or ACPI, but neither of the two mechanisms is standardized yet. Also,
> in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
> instead configure the system purely through kernel command line options.
> 
> I'm sure other people will find the functionality useful going forward
> though and extend it to be triggered by DT/ACPI in the future.

I'm totally against hacking in a kernel parameter for this.  We'll need
a proper documented DT or ACPI way.  We also need to feed this information
into the actual DMA bounce buffering decisions and not just the swiotlb
placement.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

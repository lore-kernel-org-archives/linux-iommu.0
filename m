Return-Path: <SRS0=/IpK=5P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DB6C43331
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 13:24:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E1920757
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 13:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E1920757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 449B98794A;
	Mon, 30 Mar 2020 13:24:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iGtGBwtfi+kN; Mon, 30 Mar 2020 13:24:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7483D865D0;
	Mon, 30 Mar 2020 13:24:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 670A2C1AE8;
	Mon, 30 Mar 2020 13:24:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8223FC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 13:24:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 79F6686614
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 13:24:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q3va7TG8V1kv for <iommu@lists.linux-foundation.org>;
 Mon, 30 Mar 2020 13:24:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 686E6865D0
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 13:24:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C089D30E;
 Mon, 30 Mar 2020 06:24:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C30CF3F71E;
 Mon, 30 Mar 2020 06:24:21 -0700 (PDT)
Date: Mon, 30 Mar 2020 14:24:16 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
Message-ID: <20200330132416.GA20969@lakrids.cambridge.arm.com>
References: <20200326162922.27085-1-graf@amazon.com>
 <20200326170516.GB6387@lst.de>
 <cef4f2f5-3530-82f8-c0f5-ee0c2701ce6a@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cef4f2f5-3530-82f8-c0f5-ee0c2701ce6a@amazon.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Cc: benh@amazon.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
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

On Thu, Mar 26, 2020 at 06:11:31PM +0100, Alexander Graf wrote:
> On 26.03.20 18:05, Christoph Hellwig wrote:
> > 
> > On Thu, Mar 26, 2020 at 05:29:22PM +0100, Alexander Graf wrote:
> > > The swiotlb is a very convenient fallback mechanism for bounce buffering of
> > > DMAable data. It is usually used for the compatibility case where devices
> > > can only DMA to a "low region".
> > > 
> > > However, in some scenarios this "low region" may be bound even more
> > > heavily. For example, there are embedded system where only an SRAM region
> > > is shared between device and CPU. There are also heterogeneous computing
> > > scenarios where only a subset of RAM is cache coherent between the
> > > components of the system. There are partitioning hypervisors, where
> > > a "control VM" that implements device emulation has limited view into a
> > > partition's memory for DMA capabilities due to safety concerns.
> > > 
> > > This patch adds a command line driven mechanism to move all DMA memory into
> > > a predefined shared memory region which may or may not be part of the
> > > physical address layout of the Operating System.
> > > 
> > > Ideally, the typical path to set this configuration would be through Device
> > > Tree or ACPI, but neither of the two mechanisms is standardized yet. Also,
> > > in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
> > > instead configure the system purely through kernel command line options.
> > > 
> > > I'm sure other people will find the functionality useful going forward
> > > though and extend it to be triggered by DT/ACPI in the future.
> > 
> > I'm totally against hacking in a kernel parameter for this.  We'll need
> > a proper documented DT or ACPI way.
> 
> I'm with you on that sentiment, but in the environment I'm currently looking
> at, we have neither DT nor ACPI: The kernel gets purely configured via
> kernel command line. For other unenumerable artifacts on the system, such as
> virtio-mmio platform devices, that works well enough and also basically
> "hacks a kernel parameter" to specify the system layout.

On the arm64 front, you'd *have* to pass a DT to the kernel (as that's
where we get the command line from), and we *only* discover memory
from the DT or EFI memory map, so the arguments above aren't generally
applicable. You can enumerate virtio-mmio devices from DT, also.

Device-specific constraints on memory should really be described in a
per-device fashion in the FW tables so that the OS can decide how to
handle them. Just becuase one device can only access memory in a
specific 1MiB window doesn't mean all other should be forced to share
the same constraint. I think that's what Christoph was alluding to.

Thanks,
Mark.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

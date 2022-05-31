Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C5EC4332F
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 07:16:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E086560FD2;
	Tue, 31 May 2022 07:16:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m_GHvbZ6OuKn; Tue, 31 May 2022 07:16:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C1A4060D73;
	Tue, 31 May 2022 07:16:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D777C0039;
	Tue, 31 May 2022 07:16:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3564C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 07:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1CC681B35
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 07:16:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id liPPFGOmG4d3 for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 07:16:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB9A081AAC
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 07:16:48 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 42FE068B05; Tue, 31 May 2022 09:16:40 +0200 (CEST)
Date: Tue, 31 May 2022 09:16:39 +0200
From: "hch@lst.de" <hch@lst.de>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: Re: [RFC PATCH V2 1/2] swiotlb: Add Child IO TLB mem support
Message-ID: <20220531071639.GA23482@lst.de>
References: <20220502125436.23607-1-ltykernel@gmail.com>
 <20220502125436.23607-2-ltykernel@gmail.com> <YoH+mbxQAp/2XGyG@infradead.org>
 <PH0PR21MB30258D2B3B727A9BCEE039FCD7DD9@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PH0PR21MB30258D2B3B727A9BCEE039FCD7DD9@PH0PR21MB3025.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Tianyu Lan <ltykernel@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kirill.shutemov" <kirill.shutemov@intel.com>,
 "andi.kleen@intel.com" <andi.kleen@intel.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 vkuznets <vkuznets@redhat.com>, KY Srinivasan <kys@microsoft.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>
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

On Mon, May 30, 2022 at 01:52:37AM +0000, Michael Kelley (LINUX) wrote:
> B) The contents of the memory buffer must transition between
> encrypted and not encrypted.  The hardware doesn't provide
> any mechanism to do such a transition "in place".  The only
> way to transition is for the CPU to copy the contents between
> an encrypted area and an unencrypted area of memory.
> 
> Because of (B), we're stuck needing bounce buffers.  There's no
> way to avoid them with the current hardware.  Tianyu also pointed
> out not wanting to expose uninitialized guest memory to the host,
> so, for example, sharing a read buffer with the host requires that
> it first be initialized to zero.

Ok, B is a deal breaker.  I just brought this in because I've received
review comments that state bouncing is just the easiest option for
now and we could map it into the hypervisor in the future.  But at
least for SEV that does not seem like an option without hardware
changes.

> We should reset and make sure we agree on the top-level approach.
> 1) We want general scalability improvements to swiotlb.  These
>     improvements should scale to high CPUs counts (> 100) and for
>     multiple NUMA nodes.
> 2) Drivers should not require any special knowledge of swiotlb to
>     benefit from the improvements.  No new swiotlb APIs should be
>     need to be used by drivers -- the swiotlb scalability improvements
>     should be transparent.
> 3) The scalability improvements should not be based on device
>     boundaries since a single device may have multiple channels
>     doing bounce buffering on multiple CPUs in parallel.

Agreed to all counts.

> The patch from Andi Kleen [3] (not submitted upstream, but referenced
> by Tianyu as the basis for his patches) seems like a good starting point
> for meeting the top-level approach.

Yes, I think doing per-cpu and/or per-node scaling sounds like the
right general approach. Why was this never sent out?

> Andi and Robin had some
> back-and-forth about Andi's patch that I haven't delved into yet, but
> getting that worked out seems like a better overall approach.  I had
> an offline chat with Tianyu, and he would agree as well.

Where was this discussion?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

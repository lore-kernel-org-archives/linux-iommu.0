Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70463C433B4
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 18:53:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083A661264
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 18:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083A661264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABF6B84555;
	Thu, 13 May 2021 18:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id En-3LR_k-t12; Thu, 13 May 2021 18:53:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5692384474;
	Thu, 13 May 2021 18:53:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D866C000D;
	Thu, 13 May 2021 18:53:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3D17C0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 18:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BDD81400D7
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 18:53:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VdcnD7mstrX5 for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 18:53:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EAE2B400D6
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 18:53:53 +0000 (UTC)
IronPort-SDR: Cbf6+cDMIkG2GtQgxH/CS9VYdRpn+0dtmcu4RcbG2nBNSUZVx4NkTgJCXEjax7ycCEPwxtygvQ
 K023ufMgWteA==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="187438247"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="187438247"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 11:53:51 -0700
IronPort-SDR: 9Up57c0CDb2ZmIMevyH92mTBnr53E6sGPaiKBteRDKCDfWtXeUgBwaGMn3vmPUXfWWGWYM4yMA
 Ije96e4uOsyg==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="626346317"
Received: from agluck-desk2.sc.intel.com (HELO
 agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 11:53:50 -0700
Date: Thu, 13 May 2021 11:53:49 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
References: <20210511091452.721e9a03@jacob-builder>
 <20210511163521.GN1002214@nvidia.com>
 <20210511110550.477a434f@jacob-builder>
 <20210511194726.GP1002214@nvidia.com>
 <YJt3tGlzFK3b4E82@infradead.org>
 <20210513060012.0fcc7653@jacob-builder>
 <20210513133834.GC1002214@nvidia.com>
 <20210513081050.5cf6a6ed@jacob-builder>
 <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
 <20210513173303.GL1002214@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210513173303.GL1002214@nvidia.com>
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Thu, May 13, 2021 at 02:33:03PM -0300, Jason Gunthorpe wrote:
> The page table under the kernel PASID should behave the same way that
> the kernel would operate the page table assigned to a kernel RID.
> 
> If the kernel has security off then the PASID should map to all
> physical memory, just like the RID does.
> 
> If security is on then every DMA map needs to be loaded into the
> PASID's io page table no different than a RID page table.
> 
> "kernel SVA" is, IMHO, not a desirable thing, it completely destroys
> the kernel's DMA security model.
> 
> > If people want to use an accelerator on memory allocated by vmalloc()
> > things will get more complicated. But maybe we can delay solving that
> > problem until someone comes up with a real use case that needs to
> > do this?
> 
> If you have a HW limitation that the device can only issue TLPs
> with a PASID, even for kernel users, then I think the proper thing is
> to tell the IOMMU layer than a certain 'struct device' enters
> PASID-only mode and the IOMMU layer should construct an appropriate
> PASID and flow the dma operations through it.
> 
> Pretending the DMA layer doesn't exist and that PASID gets a free pass
> is not OK in the kernel.

I can see why a tight security model is needed to stop
random devices having access to mamory that they should
not be able to access.  Now that PCIe devices can be plugged
into Thunderbolt ports on computers, nobody wants to repeat
the disaster that Firewire ports created for systems over
a decade ago.

But I'd like to challege the one-size-fits-all policy. There's
a big difference between a random device plugged into a port
(which may even lie about its VendorID/DeviceID) and a device
that is part of the CPU socket.

I'd like people to think of DSA as an extension to the instruction
set. It implements asynchronous instructions like "MEMFILL" and
"MEMCOPY". These can be limited in scope when executed in user
processes or guests. But when executed by the host OS ring0 code
they can have all the same access that ring0 code has when it
dereferences a pointer.

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=DnMm=7D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D8C433E3
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 14:17:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C490D20884
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 14:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoJrVHIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C490D20884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 93376875EF;
	Thu, 21 May 2020 14:17:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hjFpWHlxQxmz; Thu, 21 May 2020 14:17:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 29659875F5;
	Thu, 21 May 2020 14:17:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AFFEC088B;
	Thu, 21 May 2020 14:17:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 176FFC0176
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 14:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 067CD875F5
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 14:17:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UU9I1MJWRWXF for <iommu@lists.linux-foundation.org>;
 Thu, 21 May 2020 14:17:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 96D3B875EF
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 14:17:23 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 52C9920721;
 Thu, 21 May 2020 14:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590070643;
 bh=AZMQPgg7eEixgM0PZYWK7KA66vV+dRiZTPUXhxoYuh8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PoJrVHIFNFCAoLW6Mav1ejRUdOpgEryrgFeL/IOpkKIHq+3xr27pkIc9DACE26Z0R
 rrFfzpT+hatcls+sC7b9iFT0tWtMRai6HF3m35UfE4UsAGvhv6JOtXcspLwBkPqjEr
 7TKbYifo2BfeemF071FQzuKO7KfwFiUFwTlR+p88=
Date: Thu, 21 May 2020 15:17:17 +0100
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v7 00/24] iommu: Shared Virtual Addressing for SMMUv3
Message-ID: <20200521141716.GI6608@willie-the-truck>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200521103513.GE5360@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200521103513.GE5360@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, catalin.marinas@arm.com,
 fenghua.yu@intel.com, linux-pci@vger.kernel.org, christian.koenig@amd.com,
 hch@infradead.org, jgg@ziepe.ca, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, felix.kuehling@amd.com, robin.murphy@arm.com,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
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

On Thu, May 21, 2020 at 11:35:14AM +0100, Will Deacon wrote:
> On Tue, May 19, 2020 at 07:54:38PM +0200, Jean-Philippe Brucker wrote:
> > Shared Virtual Addressing (SVA) allows to share process page tables with
> > devices using the IOMMU, PASIDs and I/O page faults. Add SVA support to
> > the Arm SMMUv3 driver.
> > 
> > Since v6 [1]:
> > * Rename ioasid_free() to ioasid_put() in patch 02, requiring changes to
> >   the Intel drivers.
> > * Use mmu_notifier_register() in patch 16 to avoid copying the ops and
> >   simplify the invalidate() notifier in patch 17.
> > * As a result, replace context spinlock with a mutex. Simplified locking in
> >   patch 11 (That patch still looks awful, but I think the series is more
> >   readable overall). And I've finally been able to remove the GFP_ATOMIC
> >   allocations.
> > * Use a single patch (04) for io-pgfault.c, since the code was simplified
> >   in v6. Fixed partial list in patch 04.
> 
> There's an awful lot here and it stretches across quite a few subsystems,
> with different git trees. What's the plan for merging it?
> 
> I'm happy to take some of the arm64 and smmu changes for 5.8, then perhaps
> we can review what's left and target 5.9? It would also be helpful to split
> that up into separate series where there aren't strong dependencies, I
> think.

Hmm, so the way the series is structured makes it quite difficult to apply
much of this at all :(

I've taken patch 5 into the arm64 tree and patch 8 into the smmu tree. I'll
leave a couple of Acks on some of the simpler patches, but I think this
really needs splitting up a bit to make it more manageable.

I also notice a bunch of TODOs that get introduced and then removed. Given
that the series needs to be bisectable, these shouldn't be needed and can
just be removed.

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891CFC433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 14:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDFE241B98;
	Thu, 28 Apr 2022 14:46:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LV2Y25JRNAe3; Thu, 28 Apr 2022 14:46:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 08CF041B83;
	Thu, 28 Apr 2022 14:46:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE0DCC0032;
	Thu, 28 Apr 2022 14:46:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 761B4C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:46:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6497682951
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:46:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yN2sI77ALGFn for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 14:46:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD3B4826B4
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Wn2CCgiEQBYeS5u0DrULazlSPjTmY85xMbHqQ/sfE9k=; b=SPFFyEzI2KXFZuWKlVBFsE45Rd
 tuKS6j1yQzuaKTnrAlz1qA+bdRp0MdXf0O9s3Ql9mZRr8J3YkTrFsILNWA7YNBS/Nv/t39FCxCROR
 tXXuwYUmj54la6tjSJJdhQkY2r7Gyb/KBAGV7ijwKv21aZIwO7PwdGKFY+wmCYNTYddTDO91VNnvu
 uyiL19/jkOa7B0xJIGnk+6PtoDefVlKJhqSsZLwAYcQC+ad/PJQx0tHgkuBlMOz0/Ii/yZ5wOpjSg
 42DqbKhrYwHu7YObyKFJqvKBSjSziz8cT/nRHQwIv7ct+vBMSXzxTJxhloyCAAkkD3LpGxlxYBKK9
 OUWI2eLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nk5Ou-007WzS-Oc; Thu, 28 Apr 2022 14:45:48 +0000
Date: Thu, 28 Apr 2022 07:45:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Message-ID: <YmqonHKBT8ftYHgY@infradead.org>
References: <20220428141429.1637028-1-ltykernel@gmail.com>
 <20220428141429.1637028-2-ltykernel@gmail.com>
 <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: parri.andrea@gmail.com, michael.h.kelley@microsoft.com, wei.liu@kernel.org,
 Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 thomas.lendacky@amd.com, konrad.wilk@oracle.com, linux-hyperv@vger.kernel.org,
 Tianyu Lan <ltykernel@gmail.com>, linux-kernel@vger.kernel.org,
 hch@infradead.org, iommu@lists.linux-foundation.org, andi.kleen@intel.com,
 brijesh.singh@amd.com, vkuznets@redhat.com, kys@microsoft.com,
 kirill.shutemov@intel.com, hch@lst.de
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

On Thu, Apr 28, 2022 at 03:44:36PM +0100, Robin Murphy wrote:
> Rather than introduce this extra level of allocator complexity, how about
> just dividing up the initial SWIOTLB allocation into multiple io_tlb_mem
> instances?

Yeah.  We're almost done removing all knowledge of swiotlb from drivers,
so the very last thing I want is an interface that allows a driver to
allocate a per-device buffer.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

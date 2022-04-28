Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEEAC433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 15:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6275C410C2;
	Thu, 28 Apr 2022 15:05:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vEMGxoEoHgvc; Thu, 28 Apr 2022 15:05:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 218854098B;
	Thu, 28 Apr 2022 15:05:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCB46C0032;
	Thu, 28 Apr 2022 15:05:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97F3CC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:05:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 85B4983E30
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:05:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BFHx-15wvXju for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 15:05:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E21D831C1
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=DyT65p8JLEwgliFAAtKUa16bmBnVnf06R0IAvK3Qq+8=; b=cxd4QAK5yB3utYqNw3LEJ1Z64h
 7q/EJ9fWB0z1urAmfvR1lCEk96vihnZPspPUndgNgKA1F9vpWlArIHTIR8oMzHVhAwDY1bABEcEjY
 0jLay+38PVJ7uU0/6/FHo9I13nZEjXXqjjGik9BAxcigXOmKfnuf1So6FGpiM3S9Ssl0+9yRlSi/T
 ux/N4EApX9dSRm65GpfBU1EUnAmo38emdVnjdcvI8CKUl7A/cVT9/Ojpp0t8H5y7ec5j82GoQFHP3
 czvjO1kgb6cgysZ3Zr8rj65fGwsByl72HmzhPIMuw5hAQVGUcD1tynztPvdzTojer/FQJqmZKiKg+
 hZbd7iTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nk5he-007aFM-B6; Thu, 28 Apr 2022 15:05:10 +0000
Date: Thu, 28 Apr 2022 08:05:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Message-ID: <YmqtJr5lxDruT/9s@infradead.org>
References: <20220428141429.1637028-1-ltykernel@gmail.com>
 <20220428141429.1637028-2-ltykernel@gmail.com>
 <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
 <YmqonHKBT8ftYHgY@infradead.org>
 <1517d2f0-08d6-a532-7810-2161b2dff421@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1517d2f0-08d6-a532-7810-2161b2dff421@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: parri.andrea@gmail.com, michael.h.kelley@microsoft.com, wei.liu@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, thomas.lendacky@amd.com,
 konrad.wilk@oracle.com, linux-hyperv@vger.kernel.org,
 Tianyu Lan <ltykernel@gmail.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 kirill.shutemov@intel.com, andi.kleen@intel.com, brijesh.singh@amd.com,
 vkuznets@redhat.com, kys@microsoft.com, Robin Murphy <robin.murphy@arm.com>,
 hch@lst.de
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

On Thu, Apr 28, 2022 at 07:55:39AM -0700, Andi Kleen wrote:
> At least for TDX need parallelism with a single device for performance.

So find a way to make it happen without exposing details to random
drivers.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

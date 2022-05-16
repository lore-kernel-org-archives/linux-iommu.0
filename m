Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E826C433EF
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 07:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23B45819F5;
	Mon, 16 May 2022 07:28:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LLYd7OJIlXHX; Mon, 16 May 2022 07:28:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1E3DE8145E;
	Mon, 16 May 2022 07:28:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1750C0039;
	Mon, 16 May 2022 07:28:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F15C8C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 07:27:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D161B408D0
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 07:27:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id igzS-ymBDNgd for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 07:27:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB4EC408AB
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 07:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=rbs61TdTiI6i6SlTkgOYEqrF4kqWmCSNPXnH343zn4o=; b=zkINHdszgACmI/fzh//RKBm1YX
 5Z5LEqTUwX+l8euQuEm3vGOmtp2GaWR+oB2Rx9rENisveABaculMx3ybmxVXdBW0UDs+DPV/9xsGt
 wPOcPZJSM306yzbrU1bKsE2ih7mLF7m8wwW29GamovpogfoobKJsooctChTQB9Npnx2ym7yAC0aRN
 RwKMLUG0UR/j9yNqvaqDGAT3T1O+ahsO3SvPmON+s3r6AKmszMnzR9k+Mr3wcBi0WHWQRP1Lmptkh
 q+JEdhZEAvGGbhheEd/54ILLsj/XSOefi/fxDG4RefMht3LQm3r4lkwgW/TDKEEks/nojhGEr240F
 5y0LpzRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nqV8n-006SAS-Df; Mon, 16 May 2022 07:27:41 +0000
Date: Mon, 16 May 2022 00:27:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Message-ID: <YoH87WKnqtGgVCHt@infradead.org>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220516015759.2952771-3-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

On Mon, May 16, 2022 at 09:57:56AM +0800, Lu Baolu wrote:
> Each IOMMU driver must provide a blocking domain ops. If the hardware
> supports detaching domain from device, setting blocking domain equals
> detaching the existing domain from the deivce. Otherwise, an UNMANAGED
> domain without any mapping will be used instead.

blocking in this case means not allowing any access?  The naming
sounds a bit odd to me as blocking in the kernel has a specific
meaning.  Maybe something like noaccess ops might be a better name?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

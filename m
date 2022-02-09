Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7621C433F5
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 06:46:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 749DD4034C;
	Wed,  9 Feb 2022 06:46:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ISBP80LRjdOn; Wed,  9 Feb 2022 06:46:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 34C294023E;
	Wed,  9 Feb 2022 06:46:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CDB9C0011;
	Wed,  9 Feb 2022 06:46:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84021C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 06:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7FD4F40271
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 06:46:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 54XQeJf66VyQ for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 06:46:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F398F4023E
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 06:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ONTS7St04dYKZSb41uvAWiQCmSInXPwUYUtislefmq4=; b=VZJiRrQeB48HFZnSa/fhbxKsFB
 C4BMEqt+yDaUAzT87IJQ2b7k9TyAbf37oBKHaMVuDQSXk6KsFtGTagdL6DGwxyvATZTbkiUAOkt1T
 akmmuoUcINkURUTgP96pVskBiEgvrpEyGDnSzcTCOf/m+ZF5fGLpbI8YB6/pe6ZLK0DCtsbFRptlK
 oKIOw5D2hc3kaA4+N9AoIluvFSm8FS+bH+86pPVi8og1oayTVWZCYliz5+XHNbNcvZtQFPS72vLl0
 daTdEpaYY2sf5KotPDQgu0kfg1lEhN0m9ZrhJsrRcaKR+XHO5q7qEYP74DXOHjFfcSNKKQjTUEO8a
 89sxfnmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nHgk2-00GO1d-Ft; Wed, 09 Feb 2022 06:46:14 +0000
Date: Tue, 8 Feb 2022 22:46:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 10/10] iommu: Split struct iommu_ops
Message-ID: <YgNjNu4kVbkruvZN@infradead.org>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-11-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220208012559.1121729-11-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

On Tue, Feb 08, 2022 at 09:25:59AM +0800, Lu Baolu wrote:
> Move the domain specific operations out of struct iommu_ops into a new
> structure that only has domain specific operations. This solves the
> problem of needing to know if the method vector for a given operation
> needs to be retrieved from the device or the domain. Logically the domain
> ops are the ones that make sense for external subsystems and endpoint
> drivers to use, while device ops, with the sole exception of domain_alloc,
> are IOMMU API internals.

I can't say I like the default_domain_ops concept all that much, but
the split itself looks like a good idea and done nicely.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6900AC433EF
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 06:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFDC582998;
	Wed,  9 Feb 2022 06:44:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G8h2c77XKVEj; Wed,  9 Feb 2022 06:44:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D4EDE82925;
	Wed,  9 Feb 2022 06:44:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF2E9C0011;
	Wed,  9 Feb 2022 06:44:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7803DC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 06:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6699B60BB0
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 06:44:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HzUkGy4zeEU4 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 06:44:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9E9A60A6F
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 06:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=KmU/3ByFFqL6kVhZO8U+qtBb64MZx4iPb69sQBmFw9s=; b=YWQ1mpOyWmMiA4wGtaJ8yjU7nA
 EzGaeGfEP8xZFRlvZCqQG+8MneA5I1MWrbwEKwVbf56z434AKyBfUxDT0oB2rqJCB0P7Niv/KTcOF
 GRcNJ8eT2JXcH1Nmb9N0MfL8H3NbrU4WPZm4+wYs9qOoKEAM6q16a5t3JyrjkXLf9pFmsaVx4b55u
 c6xcl8NEVs8gbCYHE6BtLFqr78EYama5WrGK5b0oC8jo8C6YqG1XCMVfZoDUklhYgy398GANW1Sx/
 iXtY1taObbswNfyi70UiF+eM+5s2wKhHVMl1y2wahUaiOX428w1qyREnuz4LvLE8gLoo/vXl9uhNA
 aSZxa1+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nHgic-00GNnQ-UI; Wed, 09 Feb 2022 06:44:46 +0000
Date: Tue, 8 Feb 2022 22:44:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 09/10] iommu: Use dev_iommu_ops() helper
Message-ID: <YgNi3unEVewqJtaL@infradead.org>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-10-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220208012559.1121729-10-baolu.lu@linux.intel.com>
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

On Tue, Feb 08, 2022 at 09:25:58AM +0800, Lu Baolu wrote:
> Convert all the feasible instances of dev->bus->iommu_ops to
> dev_iommu_ops() in order to making the operation of obtaining
> iommu_ops from a device consistent.

I'm not a native speaker, but I think this should read ".. in order to
make .."

>  void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>  {
> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>  
>  	if (ops && ops->get_resv_regions)

dev_iommu_ops warns on a NULL ops, so we either don'tneed the ops check
here or have another problem.

Same in a few more spots.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

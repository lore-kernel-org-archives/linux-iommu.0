Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9A7C433F5
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 06:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5AE2E40928;
	Wed,  9 Feb 2022 06:41:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0bbMR-lecqfc; Wed,  9 Feb 2022 06:41:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 13C0A40917;
	Wed,  9 Feb 2022 06:41:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF2DBC0011;
	Wed,  9 Feb 2022 06:41:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B18CC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 06:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3CBE7831A9
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 06:41:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u71O1H7P3AfP for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 06:41:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C5FCF83133
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 06:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=FskvZ9rXZL7g1GxBx4Eab4+7TZ
 uFqua19+tCun6NPjAb5GsunqDipw1alpWpW8Vzx2/Sg4mVl447Zxxp7q7ga7wzdODxdcPm1nwOXeX
 u5RvmGy+fA8qD2rB9OIv1TMcbH/AqE1MfL4CCvo2addx4E4nX6Zi7JRy3+tWResoxhB+ptXHCrpHq
 1V7M54VVIK27YA6N7Bm8eYI2ePdks5p48IDuECh2n4Nk6Pv8v24jQD/2x1csPWmi96pe2J2qppcX1
 O5aeodz5jiJlJwobSfnrfGVWBnTX+zY0yHDelaJ836bFFOAgTFqRrdgB5N31v2cUiyQVFvqgAma70
 4fv8T8kA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nHgev-00GNLb-Nd; Wed, 09 Feb 2022 06:40:57 +0000
Date: Tue, 8 Feb 2022 22:40:57 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 07/10] iommu: Use right way to retrieve iommu_ops
Message-ID: <YgNh+cS/I0FUfJHG@infradead.org>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-8-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220208012559.1121729-8-baolu.lu@linux.intel.com>
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

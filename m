Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19301C433F5
	for <iommu@archiver.kernel.org>; Thu, 16 Dec 2021 08:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A112A40ADF;
	Thu, 16 Dec 2021 08:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d4Azg0iTRUjE; Thu, 16 Dec 2021 08:01:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6668C40ABE;
	Thu, 16 Dec 2021 08:01:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AA5AC001E;
	Thu, 16 Dec 2021 08:01:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6565C0012
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 08:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84AAB81400
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 08:01:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nWn4vwTPcr-R for <iommu@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 08:01:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 22BB981307
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 08:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=YzlBkgx7rcNh5GJlFq5a2HHx7S
 MMgW3TApZtpf4wRa955dhHnRSSlXuH3TskfAMAPySyw/esJy9QGoPtXIkhpjntKOyKK6gG0jqaqe6
 Yp7W8WGvuWlz+FSeeSzivUlGFd8ghF5qU8Oc25ZuCfghvpy/g7JO9KlZl9lHOzelp7KVQH9mmE0NP
 XX0Q/DsgxcMXPxaG4dC4HirkT4acbMal6qhxcLu3+tOtjKw05Sd05gf8mnMSG+cdzMojiAXqXFbc6
 HY0f+3ecClOu+nvrD2h2b1eByIy2aNJYUHqyB93Kby8oUT8ehaTCTRCFK90zjLzPkQZgw0J8bOCqx
 bhvwgq6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mxlhp-0042FS-AT; Thu, 16 Dec 2021 08:01:37 +0000
Date: Thu, 16 Dec 2021 00:01:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 03/11] drm/tegra: vic: Fix DMA API misuse
Message-ID: <YbryYWbijSjphCbC@infradead.org>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <6b86f6e530b504a5eee864af10e2ae1570d7b645.1639157090.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6b86f6e530b504a5eee864af10e2ae1570d7b645.1639157090.git.robin.murphy@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-kernel@vger.kernel.org, willy@infradead.org,
 Mikko Perttunen <mperttunen@nvidia.com>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
 dri-devel@lists.freedesktop.org, will@kernel.org
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

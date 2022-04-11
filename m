Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9051DC433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 14:26:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2965D40A82;
	Mon, 11 Apr 2022 14:26:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W-Q8Hw92gslo; Mon, 11 Apr 2022 14:26:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DD921404C0;
	Mon, 11 Apr 2022 14:26:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B78DCC002F;
	Mon, 11 Apr 2022 14:26:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 453D3C002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:26:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2460D60AD2
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:26:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qy2CpnDBfldj for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 14:26:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C6FF60E28
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Y+87u4QYoEsVfA+FHG0tdBUkX/ZdHdh0s0fH1yaPbwg=; b=jpbocxzJOPnRbPSPWl6IBLjSsY
 zjtrkzIPoRqpIX45xb6EC9KckvKhuOBpj+TNsALOJjZRiXhi3XQtB1BV6dsYzAlva5jcd95I3ewFF
 7heZXa7OoZilw26jwcwwKxJauT8E5Oq0G/Er3M93CTna/+XQxFnA7cdeayQYU/ThN3M+K2bVwe2K5
 ekaACOgEBiws7u+b9/invhF3TMxe/Vh2P4nQnLk2lJQD95uNEOO3Axe52RzzBv0aHUH+fsSBPdZaP
 O83ZF07UGd4sB9+bI33xqju4qComliojgddUgT8f3vMZq4teB8WTHJ+x4yIRqJD3bNHhXV3r8fkcf
 60ZCzWsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nduzV-009OLa-MK; Mon, 11 Apr 2022 14:26:05 +0000
Date: Mon, 11 Apr 2022 07:26:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Change return type of
 dmar_insert_one_dev_info()
Message-ID: <YlQ6feP5Dd9Ux18Y@infradead.org>
References: <20220409133006.3953129-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220409133006.3953129-1-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Sat, Apr 09, 2022 at 09:30:06PM +0800, Lu Baolu wrote:
> The dmar_insert_one_dev_info() returns the pass-in domain on success and
> NULL on failure. This doesn't make much sense. Change it to an integer.

Looks sensibel.  Why not also merge it with domain_add_dev_info while
you're at it?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

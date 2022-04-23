Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EC7C433EF
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 17:47:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84757414E4;
	Sat, 23 Apr 2022 17:47:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xfCYHb_Egwdg; Sat, 23 Apr 2022 17:47:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3FCD34043D;
	Sat, 23 Apr 2022 17:47:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CC57C0039;
	Sat, 23 Apr 2022 17:47:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4258C002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 17:46:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A123F4043D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 17:46:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9AcPjR6sKzwx for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 17:46:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 95AD9414E4
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 17:46:56 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0A68C68B05; Sat, 23 Apr 2022 19:46:50 +0200 (CEST)
Date: Sat, 23 Apr 2022 19:46:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH 0/2] dma-mapping, remoteproc: Fix dma_mem leak after
 rproc_shutdown
Message-ID: <20220423174650.GA29219@lst.de>
References: <20220422062436.14384-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220422062436.14384-1-mark-pk.tsai@mediatek.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: mathieu.poirier@linaro.org, yj.chiang@mediatek.com,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, robin.murphy@arm.com, hch@lst.de,
 linux-arm-kernel@lists.infradead.org
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

Sigh.  In theory drivers should never declare coherent memory like
this, and there has been some work to fix remoteproc in that regard.

But I guess until that is merged we'll need somthing like this fix.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

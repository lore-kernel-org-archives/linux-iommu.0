Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0D0C433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 06:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 940FC60F7B;
	Thu,  7 Apr 2022 06:26:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gV3_lU3pUmcr; Thu,  7 Apr 2022 06:26:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 71DE360C03;
	Thu,  7 Apr 2022 06:26:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48C4FC002C;
	Thu,  7 Apr 2022 06:26:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADF74C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 06:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8951283F04
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 06:26:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kyuEjLfYneiU for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:26:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FE8A83E62
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 06:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=BsQO6wnMPnYfyxGvGOmdlMOhxp9GwtVrTNhRXZDrpow=; b=2DD9ThnPpwuYt4dCp269wZXHyG
 STQJSJ2xfYB30TBEWHWy+EmzL2voTRUrQS03m5auoB3PynnU9HkMt+j+mt0CJEvSRx17g095h5xEJ
 TpetlVxKBxF/sazQviH/41TVr6TbOcNz8nwA7aZY92mA3S93MzktDAJsI+2ZK0BUlyh8h1dazbebe
 alCzDhLT5MT9AgG/2lg5IvCrdaSO0VwPx80OTLQ0hXllDpadQ3Xfrw4namw9ptB7/DtJGdHKzkHr9
 vXTJ5d19vU3bzBcEoJ54IxiEDiP8Mk1Lyzpdi3j0T48Xlkb+J4D3viVceUCcUotyK1PiyAHIhKQJR
 5OiZjjJA==;
Received: from [2001:4bb8:184:7553:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncLat-009fj0-4R; Thu, 07 Apr 2022 06:26:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>, Sven Peter <sven@svenpeter.dev>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Yong Wu <yong.wu@mediatek.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org
Subject: remve dead iommu code
Date: Thu,  7 Apr 2022 08:26:04 +0200
Message-Id: <20220407062608.711392-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

Hi all,

this removes a bit of dead code and methods from the iommu code and the
cleans up the arm-smmu-v3 driver a little bit based on that.

Diffstat:
 drivers/iommu/amd/iommu.c                   |    1 
 drivers/iommu/apple-dart.c                  |    1 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   60 +++++++---------------------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |    1 
 drivers/iommu/intel/iommu.c                 |    1 
 drivers/iommu/iommu.c                       |   33 ---------------
 drivers/iommu/mtk_iommu.c                   |    1 
 drivers/iommu/virtio-iommu.c                |    5 --
 include/linux/iommu.h                       |   17 -------
 9 files changed, 19 insertions(+), 101 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

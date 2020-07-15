Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF31C433EA
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 10:40:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7BD206F4
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 10:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKPUPtQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7BD206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CEE428ABE5;
	Wed, 15 Jul 2020 10:40:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2AVmBa71s2WR; Wed, 15 Jul 2020 10:40:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 65E9F8ABCD;
	Wed, 15 Jul 2020 10:40:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F5C2C0891;
	Wed, 15 Jul 2020 10:40:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 374E5C0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 10:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2F8EE8ABD1
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 10:40:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VuD9EgGmUtwM for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 10:40:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E99298ABCD
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 10:40:25 +0000 (UTC)
Received: from localhost (unknown [122.171.202.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D85CE20656;
 Wed, 15 Jul 2020 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594809625;
 bh=tclvIja3nKQXHIcIKVHINSxF+hfzpuNOonuG/8s/O+o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EKPUPtQVh86TpetcNNaX6A3SUrcSr2VetpVBZzcd/51Oc1SannqIsAotDwJ3dslDd
 eMm4K7jAnzdbp+uqyBwzeP8AADdJJxlX+6pYgTcJ3hFVY9sZ08RB0Uwo+qxeFjw4TZ
 K9ei/Ewyjvw/WsEW7J4HzQiNrq6C2iDSI2xcGaeY=
Date: Wed, 15 Jul 2020 16:10:21 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 4/9] dt-bindings: dma: renesas,rcar-dmac: Document
 R8A774E1 bindings
Message-ID: <20200715104021.GH34333@vkoul-mobl>
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1594676120-5862-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, linux-renesas-soc@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Prabhakar <prabhakar.csengg@gmail.com>, dmaengine@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
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

On 13-07-20, 22:35, Lad Prabhakar wrote:
> Renesas RZ/G2H (R8A774E1) SoC also has the R-Car gen3 compatible
> DMA controllers, therefore document RZ/G2H specific bindings.

Applied, thanks

-- 
~Vinod
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

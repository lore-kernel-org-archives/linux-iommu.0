Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857E5C433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 12:52:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24C2E6116D;
	Fri, 18 Feb 2022 12:52:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CH0SQbvQ8JZx; Fri, 18 Feb 2022 12:52:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F2BA4610C5;
	Fri, 18 Feb 2022 12:52:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B00A8C0021;
	Fri, 18 Feb 2022 12:52:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB599C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B862C84C1E
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:52:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CMEqTX3WFQjz for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 12:52:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96EF284C0E
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:52:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 281841F46910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1645188744;
 bh=XVKS75XpYQxb5/TVvYHVixSh4Vl0aBXRGf/YFk8Ta7w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SIGILJp6htL6o7lcCxedptEr2v14pHNt09Vrw6JNFphmrJAukrVO189Vh24oMXrPI
 9vWL65qlnN0jlhLfVMM4uHAb3DBCt0Z2vZbg7Li8fDKINWurPLaq7nqi1Fen2h2puJ
 5hfWkLAuXRZvi37rGQ9UjY6jpHS8g1EpBPPcjBruJ8Kl+j2/3abxB7oDSZp8TpGaZO
 StC+31dsaX8r+TWfIAL8CkSMdDsvqWJEJTY07p3+ca3fzCqaCf3j/q/CLuP7UOs8Mz
 +jn4/xLVPwn+lkbm9goa29rrHMv6hsGTeYP6ucU8D9gET5qmbIcow1CCx2a+vGV2mV
 oTp8lxApvRhtQ==
Message-ID: <71d7c940-63d5-bf65-527d-b27a8e0e5edc@collabora.com>
Date: Fri, 18 Feb 2022 13:52:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 19/34] iommu/mediatek: Add a PM_CLK_AO flag for infra
 iommu
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>
References: <20220217113453.13658-1-yong.wu@mediatek.com>
 <20220217113453.13658-20-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220217113453.13658-20-yong.wu@mediatek.com>
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Il 17/02/22 12:34, Yong Wu ha scritto:
> The power/clock of infra iommu is always on, and it doesn't have the
> device link with the master devices, then the infra iommu device's pm
> statua is not active, thus we add A PM_CLK_AO flag for infra iommu.
> 
> The tlb operation is a bit not clear in this file, Comment them in the
> code here.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

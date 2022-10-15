Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB607B
	for <iommu@lists.linux.dev>; Sat, 15 Oct 2022 03:30:50 +0000 (UTC)
X-UUID: 14a76332afa74516b6610a1edcfec374-20221015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=uo5RutZKIWxTF1v3lTWtS5MOGB5BHj7gJCREIvngKpU=;
	b=eaYYRbiasLYkqEb2KSu1d3yD+Y4OrDc/MM/xCNk5zMzs3AptIq+Prj3THnXvvSwWn0VO4BJeR1/ha3POeOIy7SSzagUIGG4A1S6CQvPCMxcit16xwLBP9/sSrkF1/hquuDYknvIG4I/Vb40irmPw89ZElO2tKNUiOUujxcTuuRw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:048350b6-1b06-45e1-96f7-679c6f427fd0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:048350b6-1b06-45e1-96f7-679c6f427fd0,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:bdc524b6-a023-44ff-92b1-76c504f71c7a,B
	ulkID:221015112538DSKRIK5P,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|102,
	TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0
X-UUID: 14a76332afa74516b6610a1edcfec374-20221015
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1528785872; Sat, 15 Oct 2022 11:25:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 15 Oct 2022 11:25:37 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 15 Oct 2022 11:25:36 +0800
Message-ID: <b07cc3c07f472c0ea746c7c75f3bd4af1cc11cfc.camel@mediatek.com>
Subject: Re: [PATCH v4 3/3] iommu/mediatek: add support for MT8365 SoC
From: Yong Wu <yong.wu@mediatek.com>
To: Alexandre Mergnat <amergnat@baylibre.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, <linux-mediatek@lists.infradead.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>, Amjad Ouled-Ameur
	<aouledameur@baylibre.com>, Fabien Parent <fparent@baylibre.com>,
	<devicetree@vger.kernel.org>, <iommu@lists.linux.dev>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>,
	<linux-arm-kernel@lists.infradead.org>
Date: Sat, 15 Oct 2022 11:25:36 +0800
In-Reply-To: <20221001-iommu-support-v4-3-f1e13438dfd2@baylibre.com>
References: <20221001-iommu-support-v4-0-f1e13438dfd2@baylibre.com>
	 <20221001-iommu-support-v4-3-f1e13438dfd2@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N

On Fri, 2022-10-14 at 10:45 +0200, Alexandre Mergnat wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add IOMMU support for MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Tested-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: Yong Wu <yong.wu@mediatek.com>


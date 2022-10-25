Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313FBA23
	for <iommu@lists.linux.dev>; Tue, 25 Oct 2022 06:39:14 +0000 (UTC)
X-UUID: 3cdc034a11d34d0193bbaedc53a61c63-20221025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=tQobf7xDtt3s0PCmRp7MPfET49Bi1DCJ8ajNsUuFyIs=;
	b=kj3Mq+CiCePf6Xqb1xJG+BIJ7YMsxNAYxlpyQslxZEcpLMeZUz71bRTWqwyw6kw5GOCalTMGcpM95t0aJbaHS1e79AKLMkNsEm/Wif60JMo3MQfnBOBu/pv6HaeGe/GoUMWcc0P/xqcFLmZLO7NO0tqsXVIu+Iw3o387GrMun7o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:9a903fc1-5aa1-429f-98fd-044b19337204,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:1117026d-89d3-4bfa-baad-dc632a24bca3,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3cdc034a11d34d0193bbaedc53a61c63-20221025
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1452619724; Tue, 25 Oct 2022 14:39:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 25 Oct 2022 14:39:01 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 25 Oct 2022 14:39:00 +0800
Message-ID: <514697c381172b4baa011cc68ae8093c7517e0b2.camel@mediatek.com>
Subject: Re: [PATCH v5 0/3] iommu/mediatek: Add mt8365 iommu support
From: Yong Wu <yong.wu@mediatek.com>
To: Alexandre Mergnat <amergnat@baylibre.com>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
CC: <linux-kernel@vger.kernel.org>, Amjad Ouled-Ameur
	<aouledameur@baylibre.com>, <devicetree@vger.kernel.org>, Fabien Parent
	<fparent@baylibre.com>, <linux-arm-kernel@lists.infradead.org>, "Markus
 Schneider-Pargmann" <msp@baylibre.com>, <linux-mediatek@lists.infradead.org>,
	<iommu@lists.linux.dev>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, <mingyuan.ma@mediatek.com>,
	<yf.wang@mediatek.com>, <libo.kang@mediatek.com>, <anan.sun@mediatek.com>
Date: Tue, 25 Oct 2022 14:39:00 +0800
In-Reply-To: <20221001-iommu-support-v5-0-92cdbb83bbb8@baylibre.com>
References: <20221001-iommu-support-v5-0-92cdbb83bbb8@baylibre.com>
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

On Fri, 2022-10-21 at 15:42 +0200, Alexandre Mergnat wrote:
> Hi,
> 
> This series contains patches related to the support of mt8365 iommu.
> Thanks for your feedback so far.
> 
> Regards,
> Alex
> 
> Changes in
> v5:                                                                  
> - Fix name file in
> mediatek,iommu.yaml                                          
> - Rename defines to be more
> consistent                                          
> - Rework INT_ID_PORT_WIDTH_6
> check                                              
> - Link to v4: 
> https://lore.kernel.org/r/20221001-iommu-support-v4-0-f1e13438dfd2@baylibre.com


For this series,

Reviewed-by: Yong Wu <yong.wu@mediatek.com>



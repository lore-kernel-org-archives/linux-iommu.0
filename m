Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EDF3C35
	for <iommu@lists.linux.dev>; Tue,  9 Aug 2022 11:01:22 +0000 (UTC)
X-UUID: b12c9614c7d54e54b5d3454efc4dec1c-20220809
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3+sWa2PooQLKqQir1tblQZYSMFLwoLn6JqwP0FhUKAE=;
	b=Ue53h8TjztyjG9gr8gA/XZQXHOkGuiRJBBGu4QYKRN9X47gIOgO1YJFekPZrKS0yBrQ91Mf6DacXkielJV0DXrCqdbBpHUf/Qgi3iOu56KXRvS5BC2THjWVjPCQtSXAFiRkd2iMzx0FVvzFGz5DaPHvBtQJpyjAD128xWUdyMh4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:26b28180-e7af-48cc-a9c3-e197b9691285,OB:0,LO
	B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
	am,ACTION:release,TS:0
X-CID-META: VersionHash:3d8acc9,CLOUDID:9fe62c9c-da39-4e3b-a854-56c7d2111b46,C
	OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
	,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b12c9614c7d54e54b5d3454efc4dec1c-20220809
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <tinghan.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1991975792; Tue, 09 Aug 2022 19:01:12 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 9 Aug 2022 19:01:10 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 9 Aug 2022 19:01:10 +0800
Message-ID: <6a1977971317059fcfad685869b6ccf233edcb68.camel@mediatek.com>
Subject: Re: [PATCH v5 02/20] dt-bindings: memory: mediatek: Update
 condition for mt8195 smi node
From: Tinghan Shen <tinghan.shen@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Yong Wu
	<yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Lee Jones <lee@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, MandyJH Liu
	<mandyjh.liu@mediatek.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Date: Tue, 9 Aug 2022 19:01:10 +0800
In-Reply-To: <96e66425-ff2a-4640-8b96-48fa39943bf9@linaro.org>
References: <20220804021553.14867-1-tinghan.shen@mediatek.com>
	 <20220804021553.14867-3-tinghan.shen@mediatek.com>
	 <96e66425-ff2a-4640-8b96-48fa39943bf9@linaro.org>
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

Hi Krzysztof,

On Thu, 2022-08-04 at 17:12 +0200, Krzysztof Kozlowski wrote:
> On 04/08/2022 04:15, Tinghan Shen wrote:
> > 
> > It's because the 'mediatek,mt8195-smi-sub-common' compatible incorrectly
> > matches the 'else' conditions for gen2 HW without gals.
> > 
> > Rewrite the 'else' condition to specifically identify the compatibles
> > that utilizing gen2 HW without gals.
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno
> >  <angelogioacchino.delregno@collabora.com>
> 
> Unfortunately, your patches got corrupted.
> 
> 
> Best regards,
> Krzysztof

Do you mean rebase to the latest linux-next?
I'll rebase in the next version, thanks!

Best regards,
TingHan


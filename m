Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27F17B
	for <iommu@lists.linux.dev>; Tue, 19 Jul 2022 07:55:32 +0000 (UTC)
X-UUID: df755e09332c431d97e3d643dcc5ff84-20220719
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:7fc947fc-c367-4c97-9f32-455f38598aa3,OB:0,LO
	B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
	ION:release,TS:50
X-CID-INFO: VERSION:1.1.8,REQID:7fc947fc-c367-4c97-9f32-455f38598aa3,OB:0,LOB:
	0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
	N:release,TS:50
X-CID-META: VersionHash:0f94e32,CLOUDID:2917e0d7-5d6d-4eaf-a635-828a3ee48b7c,C
	OID:d036aec9d6aa,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: df755e09332c431d97e3d643dcc5ff84-20220719
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <tinghan.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 607164910; Tue, 19 Jul 2022 15:55:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 19 Jul 2022 15:55:21 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Jul 2022 15:55:21 +0800
Message-ID: <0be4d31850191fe8651348e9695aa025d354be5d.camel@mediatek.com>
Subject: Re: [PATCH v2 05/19] dt-bindings: power: mediatek: Refine multiple
 level power domain nodes
From: Tinghan Shen <tinghan.shen@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Yong Wu
	<yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Lee Jones <lee.jones@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, MandyJH Liu
	<mandyjh.liu@mediatek.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Date: Tue, 19 Jul 2022 15:55:21 +0800
In-Reply-To: <631560b2-58f7-064a-020b-d8029f04e451@linaro.org>
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
	 <20220714122837.20094-6-tinghan.shen@mediatek.com>
	 <c2e9f890-98c2-8f09-952d-495f2b57a254@linaro.org>
	 <631560b2-58f7-064a-020b-d8029f04e451@linaro.org>
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

(Remove non-working @mediatek.com)

On Fri, 2022-07-15 at 10:15 +0200, Krzysztof Kozlowski wrote:
> On 15/07/2022 10:07, Krzysztof Kozlowski wrote:
> > On 14/07/2022 14:28, Tinghan Shen wrote:
> > > Extract duplicated properties and support more levels of power
> > > domain nodes.
> 
> Can you guys stop cc-ing all the non-working @mediatek.com emails? Every
> time I got a bunch of bounced:
> 
> 550 Relaying mail to weiyi.lu@mediatek.com is not allowed
> 
> and other like that.
> 
> Really, it's being since some time and it became extra annoying.
> 
> Best regards,
> Krzysztof

I'm sorry for causing the annoying notifications. 
I'll update the maintainer lists in next version.

Thanks,
TingHan


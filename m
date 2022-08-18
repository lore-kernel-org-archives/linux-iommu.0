Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAB23CD
	for <iommu@lists.linux.dev>; Thu, 18 Aug 2022 08:12:35 +0000 (UTC)
X-UUID: 82e79557642e4a93a944bd38bdbc42db-20220818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=UQCUheVzm/zqzSXNU/VM4FxsV1aKEDMU6rPmjtjWEbg=;
	b=XFN9faatxlGB06PgEiSrQrOFziMAM/zw/Uy85X7duhTB5udpr2luy11cB+rO6YHxaGtlIceZXs0sIilRnv/U3ALBxIXr3dgB6Kg6sE32kkr6fa3cMdFfQhsASqez9w5lwSEdRxu1iXr6Ts3+UF9MVXmX8kjyDdxJBk3w+aWLDos=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:607c6608-aee4-49ca-a810-f02d1e3740c1,OB:0,L
	OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
	Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:bbfe2daf-9535-44a6-aa9b-7f62b79b6ff6,C
	OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
	,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 82e79557642e4a93a944bd38bdbc42db-20220818
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
	(envelope-from <chengci.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 126140676; Thu, 18 Aug 2022 16:12:30 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 18 Aug 2022 16:12:28 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 18 Aug 2022 16:12:28 +0800
Message-ID: <ee54331a321fe256788a47d2ffd7d3b7124e23ee.camel@mediatek.com>
Subject: Re: [PATCH 1/3] dt-bindings: mediatek: mt8188: Add binding for MM &
 INFRA IOMMU
From: Chengci.Xu <chengci.xu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Yong Wu
	<yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Date: Thu, 18 Aug 2022 16:12:27 +0800
In-Reply-To: <5a916595-12ee-92e6-d380-84146dd75218@linaro.org>
References: <20220804105834.626-1-chengci.xu@mediatek.com>
	 <20220804105834.626-2-chengci.xu@mediatek.com>
	 <ae06f644-b988-8fc3-fde8-258299f8f2ae@linaro.org>
	 <f34db3a295b8c83e03bf79950cc25d39b6f81240.camel@mediatek.com>
	 <5a916595-12ee-92e6-d380-84146dd75218@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2022-08-18 at 10:48 +0300, Krzysztof Kozlowski wrote:
> On 18/08/2022 10:26, Chengci.Xu wrote:
> > On Thu, 2022-08-04 at 13:13 +0200, Krzysztof Kozlowski wrote:
> > > On 04/08/2022 12:58, Chengci.Xu wrote:
> > > > This patch adds descriptions for mt8188 IOMMU which also use
> > > > ARM
> > > > Short-Descriptor translation table format.
> > > > 
> > > 
> > > 
> > > Thank you for your patch. There is something to discuss/improve.
> > 
> > Tkanks for your review.
> > 
> 
> BTW, none of your emails seem to reach devicetree mailing list:
> 
https://lore.kernel.org/linux-devicetree/20220804105834.626-1-chengci.xu@mediatek.com/
> which means they won't pop-up in Rob's Patchwork and won't tested by
> bot.
> 
https://patchwork.ozlabs.org/project/devicetree-bindings/list/?series=&submitter=84571&state=*&q=&archive=&delegate=
> 
> I wonder if this is the same issue as with other Mediatek emails
> filtered by spam...
> 
> Anyway, you should sort it out, otherwise patches won't get to Rob
> and I
> won't apply them.
> 

Thanks for the your reminder, I will try to find out and fix this when
sending next version.

> Best regards,
> Krzysztof

Best regards,
Chengci Xu


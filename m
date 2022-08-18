Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2A923CD
	for <iommu@lists.linux.dev>; Thu, 18 Aug 2022 08:03:34 +0000 (UTC)
X-UUID: 09835c5baf504a478e27ee4a53ba9d54-20220818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=wpJo/uafqISHKgQcmWBoEH/7E2JFyU+XtWTOyLnY1T8=;
	b=l8/bB1KunIsK/98SXWoWXKaguz/FICil9VUsBLuYxkzp8auScZk/1bDgShSZOIpvbWuR1iKdTZAJr+fA8XCIw53vrN+NWfVGNG2Fl1+qjNqT6ORJX+CKsHLT40CBQAK8OvFIOxoNg4kTwuYdkSCCoVH22d8GGKX8OUg4+4Vyt8c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:d5c2aaed-4755-4f4e-a290-aa2f6705a1dd,OB:0,L
	OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
	Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:c147acfd-9e71-4a0f-ba6b-417998daea35,C
	OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
	,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 09835c5baf504a478e27ee4a53ba9d54-20220818
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
	(envelope-from <chengci.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 297008400; Thu, 18 Aug 2022 16:03:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 18 Aug 2022 16:03:27 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Aug 2022 16:03:26 +0800
Message-ID: <bc7214a78952066bf93f8bedaa5b8191ff3e10e3.camel@mediatek.com>
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
Date: Thu, 18 Aug 2022 16:03:26 +0800
In-Reply-To: <61c0d3bf-cf1f-77f0-bb47-dec7cde5b488@linaro.org>
References: <20220804105834.626-1-chengci.xu@mediatek.com>
	 <20220804105834.626-2-chengci.xu@mediatek.com>
	 <ae06f644-b988-8fc3-fde8-258299f8f2ae@linaro.org>
	 <f34db3a295b8c83e03bf79950cc25d39b6f81240.camel@mediatek.com>
	 <61c0d3bf-cf1f-77f0-bb47-dec7cde5b488@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2022-08-18 at 10:42 +0300, Krzysztof Kozlowski wrote:
> On 18/08/2022 10:26, Chengci.Xu wrote:
> > > >      then:
> > > >        required:
> > > > diff --git a/include/dt-bindings/memory/mt8188-memory-port.h
> > > >  b/include/dt-bindings/memory/mt8188-memory-port.h
> > > > new file mode 100644
> > > > index 000000000000..612fd366c3a7
> > > > --- /dev/null
> > > > +++ b/include/dt-bindings/memory/mt8188-memory-port.h
> > > 
> > > Use vendor prefix in filename, so mediatek,mt8188-memory-port.h
> > 
> > Is this a new mandatory rules to add a vendor prefix in dt-bindings
> > file name? we have never add a vendor prefix before.
> > 
> > If possible, we'd like not to use vendor prefix for the consistency
> > of
> > fliename's format(mtxxxx-memory-port.h).
> > Such as "mt8195-memory-port.h" and "mt8186-memory-port.h".
> 
> That's a generic rule, although loosely applied. The consistency is
> rather to have a vendor prefix everywhere. Why Mediatek should have
> an
> exception?
> 

Thank you for sharing that generic rule and we will rename the file to 
"mediatek,mt8188-memory-port.h" in th coming next version.

> Best regards,
> Krzysztof
> 

Best regards,
Chengci Xu


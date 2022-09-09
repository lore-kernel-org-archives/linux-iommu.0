Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47274622
	for <iommu@lists.linux.dev>; Fri,  9 Sep 2022 03:20:48 +0000 (UTC)
X-UUID: a38da271cf1f4d4b93bd3de0470b8fb7-20220909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=kFz/AHhlSDwM/COpK+mg6Dt0yGF/fk7aSJKUbMLw82g=;
	b=LkQ/OFUHxZCTdxJ7H3u/BO6brxaV4j9CGG2aVjM/CD/4f5s3vblRv4fKCSYA2MWKHaqJ2P7Pii9Oh2zTPvyMLg4aNnRFInnaZvE7ybQ1fFzu4adAS/9UFllCZPn487vA+vQdjuZryHCjCAfW2QF0C05x77JT29HLmMmPobxcpww=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:7cc4cd5e-6f80-4fb0-b864-04c7018ab51f,OB:0,L
	OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
	Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:a87be0eb-2856-4fce-b125-09d4c7ebe045,C
	OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
	,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a38da271cf1f4d4b93bd3de0470b8fb7-20220909
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chengci.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 263466077; Fri, 09 Sep 2022 11:20:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 9 Sep 2022 11:20:39 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Sep 2022 11:20:33 +0800
Message-ID: <c09f262422dd6cd0bf2147870a109bd2ede36d4f.camel@mediatek.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mediatek: mt8188: Add binding for
 MM & INFRA IOMMU
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
Date: Fri, 9 Sep 2022 11:20:32 +0800
In-Reply-To: <2e575ed1-b82c-c7bd-3ddf-ccb6022b2461@linaro.org>
References: <20220831125502.7818-1-chengci.xu@mediatek.com>
	 <20220831125502.7818-2-chengci.xu@mediatek.com>
	 <2e575ed1-b82c-c7bd-3ddf-ccb6022b2461@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2022-09-08 at 12:49 +0200, Krzysztof Kozlowski wrote:

Thanks for your review.

> On 31/08/2022 14:55, Chengci.Xu wrote:
> > This patch adds descriptions for mt8188 IOMMU which also use ARM
> > Short-Descriptor translation table format.
> 
> Do not use "This commit/patch".
> 
https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst*L95__;Iw!!CTRNKA9wMg0ARbw!0FyEQYk5UrJwuW-kVc1X-l58KMwnooLeErNkSwisiEzNf88AvYvMrzE6iYFH0KFOdag$
>  

Thank you for sharing this, I will drop this words.

> 
> >  
> >      then:
> >        required:
> > diff --git a/include/dt-bindings/memory/mediatek,mt8188-memory-
> > port.h b/include/dt-bindings/memory/mediatek,mt8188-memory-port.h
> > new file mode 100644
> > index 000000000000..9363e132c43a
> > --- /dev/null
> > +++ b/include/dt-bindings/memory/mediatek,mt8188-memory-port.h
> > @@ -0,0 +1,482 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
> 
> Why do you license it under BSD-3 clause?
> 

A mediatek internal wiki suggest me use "BSD-3-Clause" without detial
reason. May be it is not suitable for this file.

If you don't approve of this, I can change this license to "GPL-2.0-
only OR BSD-2-Clause", which is perferred by DT bindings file according
to "submitting-patches.rst". 

Do you think "BSD-2-Clause" is OK? Or could you kindly share me another
proper license?


Best regards,
Chengci Xu

> Best regards,
> Krzysztof


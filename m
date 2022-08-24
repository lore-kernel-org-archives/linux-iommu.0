Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D87E
	for <iommu@lists.linux.dev>; Wed, 24 Aug 2022 06:43:18 +0000 (UTC)
X-UUID: e57474ee5ef84577919834fa31b49619-20220824
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=3mv7nC1GidQo3pcX1jLcFhAjG/DTVYdU2ZAAfY1xEIw=;
	b=odpjMI4YTQ1nbivMO25ukzYX/DQJ9wmCVai8UeHDHDpL8S1Uoy3L2lwTj0HvHeLunYdJpKrTNAybZRB6vFwTQ3dhXgyMHyGEX4sjHrD2HscC7rfMSiM9bsF/CvFNTzMxo+hFxDgp4Fac9SkUmj/vY86aO3K7Apkg7pIdFRGKWhA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:5ded68cf-32af-4e21-a85d-85b86f24ddcb,OB:0,L
	OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release
	_Ham,ACTION:release,TS:-5
X-CID-META: VersionHash:84eae18,CLOUDID:821372cf-20bd-4e5e-ace8-00692b7ab380,C
	OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
	,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e57474ee5ef84577919834fa31b49619-20220824
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 764288183; Wed, 24 Aug 2022 14:43:12 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 24 Aug 2022 14:43:11 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 24 Aug 2022 14:43:10 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<iommu@lists.linux-foundation.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Yong
 Wu" <yong.wu@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <mingyuan.ma@mediatek.com>,
	<yf.wang@mediatek.com>, <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>,
	<youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
	<xueqi.zhang@mediatek.com>, Guenter Roeck <groeck@chromium.org>, "Dan
 Carpenter" <dan.carpenter@oracle.com>
Subject: [PATCH v4 0/6] iommu/mediatek: Improve safety from invalid dts input
Date: Wed, 24 Aug 2022 14:43:00 +0800
Message-ID: <20220824064306.21495-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

This patchset contains misc improve patches. Mainly to improve safety from 
invalid dts input.

Change notes:
v4: a) Just remove the first patch about dev_err_probe since it was merged.
    b) Rebase v6.0-rc1

v3: https://lore.kernel.org/linux-mediatek/20220701053942.3266-1-yong.wu@mediatek.com/
    a) Add platform_device_put from Robin.
    b) Use component_match_add instead component_match_add_release suggested from Robin.
    
v2: https://lore.kernel.org/linux-mediatek/20220616054203.11365-1-yong.wu@mediatek.com/
    a) Rebase on v5.19-rc1.
    b) Add a New patch [5/5] just remove a variable that only is for v1.

v1: https://lore.kernel.org/linux-mediatek/20220511064920.18455-1-yong.wu@mediatek.com/
    Base on linux-next-20220510.
    the improve safety from dts is base on:
    https://lore.kernel.org/linux-mediatek/20211210205704.1664928-1-linux@roeck-us.net/

Guenter Roeck (1):
  iommu/mediatek: Validate number of phandles associated with
    "mediatek,larbs"

Yong Wu (5):
  iommu/mediatek: Add platform_device_put for recovering the device
    refcnt
  iommu/mediatek: Use component_match_add
  iommu/mediatek: Add error path for loop of mm_dts_parse
  iommu/mediatek: Improve safety for mediatek,smi property in larb nodes
  iommu/mediatek: Remove unused "mapping" member from mtk_iommu_data

 drivers/iommu/mtk_iommu.c | 115 +++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 32 deletions(-)

-- 
2.18.0



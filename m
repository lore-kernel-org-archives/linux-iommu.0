Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583DF10F9
	for <iommu@lists.linux.dev>; Tue, 20 Sep 2022 06:37:46 +0000 (UTC)
X-UUID: 82d9155ee9344e1880f6cc316c1b4da3-20220920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=iaGWTg4SYXTYA4D2V3LpizC530571lHR55QkrMBlyek=;
	b=A1cDnnNcedwcZHRlsnP/jI97ytUQLxamSnxfse27EIcx+kemhvPTr8lBcd5+tjORUqi5HE9awwS6QYP4LnesPX1NtoVTPQ4wG+M9AmyVyZUEFFb+ZmHVRFcUF+05kq/uyghSxPklheYpMg5HSTt1P+DGXEQpPvtDvL8n+fAEJy0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:eb06de62-54b8-4561-82a7-24e3fde8e9f6,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:356e3e5e-5ed4-4e28-8b00-66ed9f042fbd,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 82d9155ee9344e1880f6cc316c1b4da3-20220920
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 1174997965; Tue, 20 Sep 2022 14:37:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 20 Sep 2022 14:37:41 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Sep 2022 14:37:39 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-mediatek@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Yong Wu <yong.wu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>, <libo.kang@mediatek.com>,
	<chengci.xu@mediatek.com>, <youlin.pei@mediatek.com>,
	<anan.sun@mediatek.com>, <xueqi.zhang@mediatek.com>, Guenter Roeck
	<groeck@chromium.org>, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v6 0/6] iommu/mediatek: Improve safety from invalid dts input
Date: Tue, 20 Sep 2022 14:37:27 +0800
Message-ID: <20220920063733.21770-1-yong.wu@mediatek.com>
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
v6: No change code. just reword the commit message in [3/6] from Angelo.

v5: https://lore.kernel.org/linux-mediatek/20220919092405.8256-1-yong.wu@mediatek.com/
    a) Loop from MTK_LARB_NR_MAX in the error path from Angelo.
    b) Fix the redundant put_device for the error patch outside the loop from dan.
 
v4: https://lore.kernel.org/linux-mediatek/20220824064306.21495-1-yong.wu@mediatek.com/
    a) Just remove the first patch about dev_err_probe since it was merged.
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

 drivers/iommu/mtk_iommu.c | 106 +++++++++++++++++++++++++++-----------
 1 file changed, 76 insertions(+), 30 deletions(-)

-- 
2.18.0



Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53A4421A00
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745211; cv=none; b=Dsupvdx85RcqClhVxtFVow7GYkftQRrbcQ6cbYoS1UaVG2y2nbjTy0SCD3/zhp0lqOwEgCXTxTx/2c2qjRBZ7Bxg97lxgHfvxtEwIX/a7J5gyN+wmpR1pKShiDQQAHUBcxicTGdDBFgDpiln7OanXIhKXQdFMIpPL/8a4ARWSpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745211; c=relaxed/simple;
	bh=BoZDFGDHUcYSCsUO7iL2FoWS+pYeqajQa3347E6I7SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2bmG6vAUwEwjCds3EGOWTtZYfB2OIdGxqJUG8e2mHBULzwUayMh34HtXDftbOcqXNXMUhlKYEPXuV7x3rfxT6iYhkLeWrQmCz++Exr6aUG92G4bXQvyRM7LH27h+VCyHHvZZWPjXALRNYW4qYYOzlLR0KUahzPXOyAL42P7eKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXDGDew8; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXDGDew8"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84592b55832so1729170b3a.3
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 08:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782745209; x=1783350009; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JO1fCQG5PwkKtjMsyUkbYJB7JtjMw8bGs1lH/7GPTdc=;
        b=LXDGDew8+9EoFZ7r8BC2omcCP+t1mIY1Fjsrw/UNhGTgPWdcnY2Kk8aRmhxNumpfP/
         mpF9Bkp0WrUuulY5G6UeZ7YS41dha9J3OCPxefRClVECZy8kFfIREICqjngY4rPILYtS
         eQszTdxcMR6DPgPnmZxTsb58LrSwCLkYLhMyB0iahNNDL+lFXqQU3yMRsKRvnE4IeIP8
         SzmJo76qXhRShbbfQNEnODLCRBsGZUdAetS1l6rjZUDjyDu71WITmn1Ec0Lzfak0lMBv
         bDl5x7u0CwRMRlP6NKGUi15dDYsxuwPxBnidZlMOtlrIwlCJ7Qu2c2G4AwWUwRsEvV08
         9HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782745209; x=1783350009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JO1fCQG5PwkKtjMsyUkbYJB7JtjMw8bGs1lH/7GPTdc=;
        b=DHvxnuTz7nP1alZJD0Oun1+MRFFz7LV+WJD3TsftOu02sxWK6/PeGSkItNOHDbTp33
         pQQsAMEYkg584D9HHUFYWPM8HfvWl68vS4qCRxgYXC49CNdfKYRIWH/xmB2AZ1ROdqz5
         Lrrzr8qO0QLeaytpIFicHJcmYfTGlYWPXe7LBYVX6yPdza85M5ev3PxaTUEWY1VeQvDX
         /9D/3/cA8RjYmFfSFFUPB7PzDs8BS+dg5GM7YNM97bWEodslOrVwE6/zwFpznfzExfmt
         RdadRljWYx0zZpXozfEKhZpegSgJI0Di3ByOvL5FHXQEa1WjyK0AyafPDiIoyAlPLzFD
         EiyQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEM/kwU8KmFI0YqxqD1eKUEocQusjGAUP2ItvAED/ABVt5JDnOFLswo+xzuNZMd1Zu/53nVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyP5PWn3m6BF4xu76u+fyw+f1oV69ihkC8M7b/IEXzggiRqNizS
	nmiE31K8xklRWo7DfEUHblxUqrRg8C5IoN9K302MK7O6vnmDwBX9MZ3d
X-Gm-Gg: AfdE7cnoTKSWe2qwaVU1lw+2dob6F0IVjmF9OVDbFUJjmoWcF0etDgg/NFoKSuHvlp/
	SmJF20Tn0weyqU7ooCj9tUpZnbLmecsdqqoyvD3Gn6dHgnYKxbgUrZWhTr659thcxneWaFDGPl6
	pxUAZ2A/TL4820qKO80AxdHGYjPfuQ93ZbDzxVi32b2D9hdXQhuvoF7GUifHq17jSeDSdaTuDtZ
	5f3956wEpwlITIb/9vVSAQi/HqQ5ypIFSJrnl8O8wowed14yBCSYayS1nU/XMWL3ekgGLI16FSv
	hGoi3n9GpRP93UgPZIEqC9d5LE0YyqjzpnDffbvkCGmTLro7FJ6BLo3CScozoiwEPhQ2isRz3LX
	+p4vIC1q3x/6qeHsXZ8EXBqiaJ+wD/wlhtPfksGT1mopHwsBVwXHW1YIPb14xbjZoO59NXK5B76
	qUnI+fsI1W8OEReum/zih3w+4ConfvMKYxBQ4E1PUlZMjo
X-Received: by 2002:aa7:888f:0:b0:847:8971:87bb with SMTP id d2e1a72fcca58-8479ae75cf7mr678238b3a.21.1782745208912;
        Mon, 29 Jun 2026 08:00:08 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845e9fa4601sm3572368b3a.6.2026.06.29.08.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:00:08 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Yong Wu <yong.wu@mediatek.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Miles Chen <miles.chen@mediatek.com>,
	Joerg Roedel <jroedel@suse.de>
Cc: Akari Tsuyukusa <akkun11.open@gmail.com>,
	iommu@lists.linux.dev (open list:MEDIATEK IOMMU DRIVER),
	linux-mediatek@lists.infradead.org (moderated list:MEDIATEK IOMMU DRIVER),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH] iommu/mediatek-v1: Fix off-by-one in MT2701_LARB_NR_MAX
Date: Mon, 29 Jun 2026 23:59:44 +0900
Message-ID: <20260629145946.312819-1-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mt2701_m4u_in_larb[] array contains 4 (for LARB0 to LARB3)
elements, meaning mt2701_m4u_to_larb() can legitimately return 3.
The current check `if (larbid >= MT2701_LARB_NR_MAX)` incorrectly
rejects valid LARB3 with -EINVAL.

Fix this off-by-one error by updating MT2701_LARB_NR_MAX to 4.

Note that this does not cause immediate issues with the current
mt2701.dtsi and mt7623n.dtsi because it only defines 3 LARBs:
    mediatek,larbs = <&larb0 &larb1 &larb2>;
Thus, larbid never reaches 3 in the existing upstream device tree.

Fixes: de78657e16f4 ("iommu/mediatek: Fix NULL pointer dereference when printing dev_name")
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/iommu/mtk_iommu_v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index ac97dd2868d4..e907c9953142 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -88,7 +88,7 @@ struct dma_iommu_mapping {
 /* MTK generation one iommu HW only support 4K size mapping */
 #define MT2701_IOMMU_PAGE_SHIFT			12
 #define MT2701_IOMMU_PAGE_SIZE			(1UL << MT2701_IOMMU_PAGE_SHIFT)
-#define MT2701_LARB_NR_MAX			3
+#define MT2701_LARB_NR_MAX			4
 
 /*
  * MTK m4u support 4GB iova address space, and only support 4K page
-- 
2.54.0


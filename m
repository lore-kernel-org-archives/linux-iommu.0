Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1B8388373;
	Tue, 19 May 2026 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171355; cv=none; b=FmagQSxKTs0k2mcXcYV03O8za5ohkBknF2ASkFo/ePV7rXaIuEF8x2meQfF0r/pJwpaSw6R5qe2kS4S4K8uCD29kdbU/AiTaDMSjo8ukLn7ov40JnbMWZVBo7NvjLeGowIkEyc/LgaowbLRoKhw6uDGW4ZDm92/OkB3wqWaCsvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171355; c=relaxed/simple;
	bh=82PERNwXYXUr/vmLjJhbxfvenuBMmsRqM+7I8R4lFg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G9dHfn8Gn47GoiY/wWvUTLMIG+ssOdcxqVzx9yqW9KJB7sTxqvpHtW2pLWcKVo6hxyG/1uOw76nJhR/EodpJh8BJD+gdsf9W9BR4GS5J71mx6q4cZFCZ5971sS4lwQQd6mypRylIJujrAi7oaDBFKIUjDP3rU1lbA+SdF/iR7sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joYmzLSM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joYmzLSM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86A86C2BCF6;
	Tue, 19 May 2026 06:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779171355;
	bh=82PERNwXYXUr/vmLjJhbxfvenuBMmsRqM+7I8R4lFg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=joYmzLSM/n4J95p9QTrhVsYairbUswXSoIC3+K4RHu/yRRk1lPwS6Vys3qsKkREdv
	 RqwueXhwPKgKbJtTdbChQsyLfV0dzU0ZxDD/Cn8RzavV7cpQGfk/A37Li2SBKdB6GN
	 eh32hvjLw3Arm9t4o9ClBRXp629xD4cdcxYhz6X/763S+Xh631ey5qZCuLOr2p+Jkm
	 oJ3jSPSVEUuyJNiIffVC2fTOfDkuuErCqxyU9o64LhOIbc+u5Z5sDQepLHhsMLp0YP
	 r38/GCD3T+RPfSWWLihQO4F7yGibfPznusareo/BeJEG2wsOC066cmgvviDH4mOBgH
	 ehvIxN2Soj7yQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E869CD4F3C;
	Tue, 19 May 2026 06:15:55 +0000 (UTC)
From: Ekansh Gupta via B4 Relay <devnull+ekansh.gupta.oss.qualcomm.com@kernel.org>
Date: Tue, 19 May 2026 11:45:55 +0530
Subject: [PATCH 05/15] iommu: Add QDA compute context bank bus to
 iommu_buses
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-qda-series-v1-5-b2d984c297f8@oss.qualcomm.com>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
In-Reply-To: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>, 
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org, 
 dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org, 
 konradybcio@kernel.org, robin.clark@oss.qualcomm.com, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779171352; l=1333;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=uUmOwV+DxDbxkc3JtD4SpX7nMMHY6cmwwdM752V2UQo=;
 b=sWmxYA9PWmgSpEQZgsn/THebk6tqrwjcomkyWVJ5lcZBwi/uzxjCYRnirmsd0UVT8+C/fvUbJ
 zmNUcHVkHcxChaxEfSFUhoiIFcB0zBUOb/1yYxX890kLSc6FeTxpCiF
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Endpoint-Received: by B4 Relay for ekansh.gupta@oss.qualcomm.com/20260223
 with auth_id=647
X-Original-From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Reply-To: ekansh.gupta@oss.qualcomm.com

From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

Register the QDA compute context bank bus (qda-compute-cb) with the
IOMMU subsystem by adding it to the iommu_buses[] array.

The QDA driver creates synthetic devices on this bus to represent
IOMMU context banks (CBs). Each CB device needs its own IOMMU domain
so that the DSP memory manager can enforce per-session address space
isolation. Without this registration, the IOMMU subsystem does not
probe CB devices for IOMMU groups and of_dma_configure() in the bus
dma_configure callback has no IOMMU domain to attach to.

Assisted-by: Claude:claude-4-6-sonnet
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e8f13dcebbde..7d39050a8848 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -26,6 +26,7 @@
 #include <linux/bitops.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/qda_compute_bus.h>
 #include <linux/fsl/mc.h>
 #include <linux/module.h>
 #include <linux/cc_platform.h>
@@ -200,6 +201,9 @@ static const struct bus_type * const iommu_buses[] = {
 #ifdef CONFIG_CDX_BUS
 	&cdx_bus_type,
 #endif
+#ifdef CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS
+	&qda_cb_bus_type,
+#endif
 };
 
 /*

-- 
2.34.1



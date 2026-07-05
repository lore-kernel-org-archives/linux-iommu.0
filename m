Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC6D3A2E12
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278875; cv=none; b=Nh/67ovW+vKlXPyIBBBzvMP/W1Dh8IWncD3yiPP/FPiqhk4Y1ZBUsWEMF6QFi+Q9lywPpCsxdx7JI2TRVAd9Ie4zfhXstIqAv7F1Xyx0HUjnVNliXGm9lkOMGndT5VqA55IBeyXlz+XHlvmrK2oaK4/kIXmYi/07K+2MX7J97ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278875; c=relaxed/simple;
	bh=gKbn7DxHBfW8SLIM+L0EECSMebRwKa2NPKVJkQ/QPPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NAeUF/b4KqV2bbO017btGhLsontm/8sSBzdqoGAlgU2qFhjj1CbSkvTJHOlz3mZYib5chO7D8QX8jvu555TOMirR0OwCfmIaussvrLnYAKA20vE24IM1oeWsAoWiyH/8vgf7cAA8lbkiVCdwS8jHEl05qZah4wrFWcnlHfA0T2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J91KVkdW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J91KVkdW"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso246902f8f.3
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783278871; x=1783883671; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zjiz7ZnbyxVfBfvfi0uSyQjszdJNoTxi1eUy+vx48jY=;
        b=J91KVkdWaA6mQJuBrzqTcrRCYVHGnEwy8FrJwyW4Qdt2POkIsF7vEoPzW2wbJVZGXD
         LdelyJFgqQGQOYkocO3iz/uwSiSQYnu20ieHnBsXnkkcMQYu+u4BbM7lDfYf4T4FTCFh
         ixFZ9qvZUwUEvvpqQxk9ydNp0C1HeZRADSsLTHL3I3yWw7uz5ssgRTjzb1ISLd5UNp6d
         18o2ofo/Nr6vlc/DPs8288MdMO3dTGw/Cp4llm/5YlhWuiSEHu2TE7IJHs4mlx4rdusR
         ChRJ3S5qNvmJPGSmT0xND1CdTbcVJrP8vSYINlLXyT0z6WsXHEAaBKLldMz43EUeaEfr
         odbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278871; x=1783883671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zjiz7ZnbyxVfBfvfi0uSyQjszdJNoTxi1eUy+vx48jY=;
        b=k5YckhxwFXi0N2Zor+XPIuQzTxjqf/zstus5ieyC/thA5YmWsmXDljZQAHvGTN3w8G
         s1NGP8r84CTZhOU7NuLYANj3GIvKcvS50xxHelzkySikzKTNppZSQ1t2qWb1/FrVZxmR
         WBG2KS4Tb/hqaa0b6gbd5jKye/ww6a5EUkRpnLJSY9MAxN/5mDCoIuapg6iBrDRSfenS
         W2LJTnNKmrtwCG7nHHxkkn9U0Ok0N999Ked6s0LUuxtgKfaaZ4cAWFD/jCm5y+NeJB93
         HaoGVYd0rSD5kwzHpJzfzmk506yHc4lIVsoB2FZrA/qoR9QVbhYxn9Wl9UKgdK+kFs1m
         1npg==
X-Gm-Message-State: AOJu0Yy59hPs0Pc2sB1DXDFHa/oBmwXJTLLh0Q1gVkeDmzfuHyj+6C2X
	RXQoiS1EjCS4EP/JAeKX5rgDRayUQwh+dJIXJ0WpvQygYuMREhhs/fE=
X-Gm-Gg: AfdE7clX2kzUZZHLY14eMuXtrYB9YaxSTQKkVcphInH0EFczaS2Yqw6zgFb5YAtOBPD
	Hnd9iQ8js+jUv1bhEpbX9Vah922zBdx9XpPDpHQygxInGLmT/N5rvVi94HB6KS09oWkTbQzGFUH
	Bs7Dt63ZoUxkjMQK0AjT2PlJlM0f7ltGDDTJYP56BLs0XLdBuTCGFOY41pnAfI6SgczE8eRLCOh
	tBw7jgnVHObghc2/v8L/Z48k+b1VOWFZVbbRntIk8Z4xSNNH2xmcL6TtUm31LmW3wyQoNnYciXS
	eKz+89GIePjI00IJIDhD97AO2Wao1FL28qlPKqZYf/m4MvYBA928m/wS4cO34vK9EOlymjjxest
	4lg15SUxjLeZtJcPrq/MQsOsGF+91+i1Un5aUxPLeXSQ68YTHPUFK6twCmivIIC/kwfYNHmASW8
	VsqJ5zJjBt/pLW72nsU5hfap8hYoMH2w==
X-Received: by 2002:a05:6000:2c05:b0:47d:df96:c9f4 with SMTP id ffacd0b85a97d-47ddf96cc37mr2857980f8f.10.1783278871226;
        Sun, 05 Jul 2026 12:14:31 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:14:30 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:43 +0200
Subject: [PATCH RFC 09/13] temp: add LPAC regs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-9-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=3442;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=gKbn7DxHBfW8SLIM+L0EECSMebRwKa2NPKVJkQ/QPPw=;
 b=kVEoEECsDH8lgKuRlOjhb0NLej7gAlbXc+I8b7Z8Y6BmwMTjsJI23i+SxwgE0fdda9uz24tEH
 NoA9v8TbOQcCAGwLTW9/mUY/YNUbybJ8jacr99G3tWrk2UifXc4ttFe
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/39416

should we merged and we should sync to mesa instead

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
index 3349c01646e1..bb49f6a61a9a 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
@@ -276,6 +276,11 @@ by a particular renderpass/blit.
 		<bitfield pos="1" name="ACCESS_FAULT_ON_VIOL_EN" type="boolean"/>
 		<bitfield pos="0" name="ACCESS_PROT_EN" type="boolean"/>
 	</bitset>
+	<reg32 offset="0x0B09" name="CP_LPAC_PROTECT_CNTL">
+		<bitfield pos="3" name="LAST_SPAN_INF_RANGE" type="boolean"/>
+		<bitfield pos="1" name="ACCESS_FAULT_ON_VIOL_EN" type="boolean"/>
+		<bitfield pos="0" name="ACCESS_PROT_EN" type="boolean"/>
+	</reg32>
 
 	<reg32 offset="0x084f" name="CP_PROTECT_CNTL" type="a6xx_cp_protect_cntl" variants="A6XX-A7XX"/>
 	<bitset name="a8xx_cp_protect_cntl" inline="yes">
@@ -333,6 +338,11 @@ by a particular renderpass/blit.
 	<reg32 offset="0x0845" name="CP_CRASH_DUMP_STATUS" variants="A8XX-"/>
 	<reg32 offset="0x0908" name="CP_SQE_STAT_ADDR" variants="A6XX-A7XX"/>
 	<reg32 offset="0x0909" name="CP_SQE_STAT_DATA" variants="A6XX-A7XX"/>
+	<reg64 offset="0x0b00" name="CP_LPAC_RB_BASE" variants="A7XX-"/>
+	<reg32 offset="0x0b02" name="CP_LPAC_RB_CNTL" variants="A7XX-"/>
+	<reg64 offset="0x0b04" name="CP_LPAC_RB_RPTR_ADDR" variants="A7XX-"/>
+	<reg32 offset="0x0b06" name="CP_LPAC_RB_RPTR" variants="A7XX-"/>
+	<reg32 offset="0x0b07" name="CP_LPAC_RB_WPTR" variants="A7XX-"/>
 	<reg32 offset="0x090a" name="CP_DRAW_STATE_ADDR" variants="A6XX-A7XX"/>
 	<reg32 offset="0x090b" name="CP_DRAW_STATE_DATA" variants="A6XX-A7XX"/>
 	<reg32 offset="0x090c" name="CP_ROQ_DBG_ADDR" variants="A6XX-A7XX"/>
@@ -521,6 +531,7 @@ by a particular renderpass/blit.
 	<reg32 offset="0x0b29" name="CP_SQE_AC_STAT_ADDR" variants="A7XX"/>
 	<reg32 offset="0x0b2a" name="CP_SQE_AC_STAT_DATA" variants="A7XX"/>
 
+	<reg32 offset="0x0b30" name="CP_LPAC_CHICKEN_DBG" variants="A7XX-"/>
 	<reg32 offset="0x0b31" name="CP_LPAC_APRIV_CNTL" variants="A7XX"/>
 	<reg32 offset="0x0b34" name="CP_LPAC_PROG_FIFO_SIZE" variants="A7XX"/>
 	<reg32 offset="0x0b35" name="CP_LPAC_ROQ_DBG_DATA" variants="A7XX"/>
@@ -1207,6 +1218,7 @@ by a particular renderpass/blit.
 	<reg64 offset="0x0E08" name="UCHE_TRAP_BASE" variants="A8XX-"/>
 	<reg64 offset="0x0E0B" name="UCHE_GMEM_RANGE_MIN" variants="A6XX-A7XX"/>
 	<reg64 offset="0x0E0D" name="UCHE_GMEM_RANGE_MAX" variants="A6XX-A7XX"/>
+	<reg32 offset="0x0E12" name="UCHE_DEBUG_CNTL_1" usage="cmd"/>
 	<reg32 offset="0x0e17" name="UCHE_CACHE_WAYS" variants="A6XX-A7XX" usage="init"/>
 	<reg32 offset="0x0e04" name="UCHE_CACHE_WAYS" variants="A8XX-"/>
 	<reg32 offset="0x0E18" name="UCHE_FILTER_CNTL"/>
@@ -4406,6 +4418,8 @@ by a particular renderpass/blit.
 
 	<array offset="0xaec0" name="SP_PERFCTR_HLSQ_SEL_2" stride="1" length="6" variants="A7XX-"/>
 
+	<reg32 offset="0xaf84" name="SP_LPAC_CHICKEN_BITS_2" variants="A7XX-" usage="cmd"/>
+
 	<!--
 	The downstream kernel calls the debug cluster of registers
 	"a6xx_sp_ps_tp_cluster" but this actually specifies the border

-- 
2.54.0


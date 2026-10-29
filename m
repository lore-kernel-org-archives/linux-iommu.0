Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282004;
	b=CJ011ZhGrXe+lgotR3wnF860AWjn7iR1GeG0w0OHIUKrT9TUpGph5YQji5h4bGUfXpp0
	 XMRoWXHvbnDXVwWb/w51y6OjgyZbijp5rjLu+iSacG/2YgQdgqg527UiB4K4eGvrDh8iX
	 1wrSv8ttvqDPOQodP6gIPaXIDkuWUrN/tLc9pdubkll4y6wMRU1OBEahniwfFXE/1L591
	 kbrxLpeAlm/te3QNNHSzsmHYKYYkVAiSxqpnYFJs2bE65rgEPSwH+Xalh7olvggkW4Kf8
	 6UIgribP2EgvuC/BFyYNIjpXhD+LhmeH5PCmgNr/QlHQmdPdSUHcYJNQ4ov+2x5CCog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=F6iyjptvh4HoJM36iNO76ddk9CmJXz5lBV2KpfdHPWQ=;
	b=PuB2odtj0CcwVGGeBDF2qjn8Mibo7Mox6Fn+C1JhI3wVN4QiPSzZY1T5ACmYUMKJWEBV
	 VGfwQ9W66A5vo7344nyS43XUb0xb6b1BMeMoyhdzpomCd0rzO290l4e5K56KTGTdyvat9
	 l8DkLhuRGrryfa/c1ZfRlsRi2KAyx+mc/VHqdHUcT34luyBFQgEKF6C+E0+x6nP9mI5DY
	 EdhOPeXZS4qRT/gJdGumVGx9IDaUWLehEIauhCqBkU53+AGUXR+2NXObEXsC91QYmV6FX
	 repl9ui+zb6jcbDtXIMygR78WtwTgHUdZZq2beL/iXtXbj5nfZVUh5dEWX87QqQwsdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zgBKJfyc;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E24060A5BDE
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 13:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E24060A5BDE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zgBKJfyc
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so20351365e9.0
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793282002; x=1793886802; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F6iyjptvh4HoJM36iNO76ddk9CmJXz5lBV2KpfdHPWQ=;
        b=zgBKJfycPUM/BlA9HVJ9I+k5JmgCHEqex1KsOoScU87BZ/y+Qk/2dU6PDpYhUxa5u9
         ChFpmJh66XQ4H7dWe4F+d2BkxHLnmw5CCXwCrlOVvTxoVYuQ4D3yARH/vI/K0VxUGat8
         X8Przcc6+HlnVw21MZJOkF/okKdw0rM2bnzvfxPlej5+fVpLJDSdFU5F1a6XBuQtdsyv
         St8R8oQAGaPXCvn3LzHIwh3qQs0CJHywF3UzTEVJKF1aTJGO06mKC0s3Pf0pK9uZNFuO
         O2HH8xtZN+LA3vXPM5o1KsMlQQvw2VbNVYJMUlmcTf5vblMYkFU9ETALYn6CqBr1FUFH
         qI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793282002; x=1793886802;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F6iyjptvh4HoJM36iNO76ddk9CmJXz5lBV2KpfdHPWQ=;
        b=Lh2hQ8h3GVDD8h+1EJM03W8jrGZRFGygWa+F11Vf5sS6AoGERAvIGxlEFI4I8av4LZ
         LpQp7AgHFnals6KKHWf5bhe6RZ3nVrywYkgubz1tXdrMHDERHZF6LPgYxazV9hPiFRPJ
         NT06lw4eJlOgiYxzOSixN1IeUp6PH4Gs/YuB3pfn65ygFuc1334iaPz+BRaPP85cLnhB
         DOEi8V2bNFsBtrXHJPzzd8+h2GVBqEpSSpXTd7OBvGQoM8YBvHSeTrhNfmtDF6Kvaw7C
         30cyHwzVQfJZjz8ilWUtm1Ikl7j5g15C52UpGEuWo/PvRl8v+2UZzwH2/MXi3pdUpJZH
         y/tA==
X-Gm-Message-State: AFq9FYJZnwamwK3j7MC1hVxuvGeKg3AZMFCpa9R/ptNaRBbTDn6PN9T3
	GNpwpmPdKuf0B1g7J7HrYgO/lV2V7uqcDna8jh5kp1RXKf4pOO1bc0s=
X-Gm-Gg: AYBFou0VrRF+ANDSioVcg4+4LW/NaOvFKUrVbEnCf638u3FPhPHDI7LrPM/x6uRjpWM
	24ULO81jJhhj4bnQV7nI4bZxz+yiG/tawjI4rxShVG4WzsHPy6/Zapvjt9fInR2dZWOivGcAGmJ
	RlohEZI09Ku7ukuj1iLJChROtkAebXIhIswXxgk4jbY8ZVDlPV7uYMO8OeDYb01Il7/wN6gmaX6
	DyWrHSKVLS4ULWt1iBSil6aN/dFVF7KgG5vVLp12W3Uq2nFr/mnmelQH6MP2Ohu5urHPwt24nQp
	6BkNITGuBP2j8J4ikNZyLq3P7g6Hwh4jJiKnyVN72DIhfMBRLFNgsAfMcK8Cl2Bw5CgETc8tuvl
	1X7K2kkJr2AQNBXC0ycdGHRj1sXDmR7smVWqW/plJdObg/pILytPUqB06g0LUFaJ4QTxHHW4uDc
	Mg676zzQy5CqLDPAr2lxrL0y9HLO4SI/ZK7lYtRtPurJHrBWmqs+XHsbiuE+luWnEOWwxD2CdV6
	+1OPCocs156tPAskFo2ShQaufKWHZfibkMeM74FgxO9WfywXi0BuXjVjQ2+JeDadUiVsByibZgz
	buEchtutFvDQ3l7Cs3Un25xkkHbYf+G3iQohhAWFIB3EFQ==
X-Received: by 2002:a05:600c:19c8:b0:4a2:150f:160f with SMTP id 5b1f17b1804b1-4a967d96ed4mr130087105e9.25.1793282001580;
        Thu, 29 Oct 2026 06:53:21 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:53:19 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:45 +0100
Subject: [PATCH RFC v2 08/14] temp: add LPAC regs
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-8-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=3442;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=RZEFtq/LXNa59m6pbHJ662cjcscb6GjQIUaPl2ZCGCY=;
 b=Gg0EOPcUOgQpNZut9lNNaoRdNIuSBEJgfuo2weKWP2BE2uB9+coUCffV36k/9B33kt5L/B+7s
 HpwtMjcdQ9CCbIIPIywq4tqFWNV27VuvFgGbiHV02csNFC4O1QaG7Tn
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
2.56.0


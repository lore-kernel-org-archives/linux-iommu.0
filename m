Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B132DC433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 13:03:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7700761A1B
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 13:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7700761A1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 45833401D2;
	Thu, 25 Mar 2021 13:03:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5hbdMyeUD_Ai; Thu, 25 Mar 2021 13:03:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B2FDC40534;
	Thu, 25 Mar 2021 13:03:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77C8AC0014;
	Thu, 25 Mar 2021 13:03:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC300C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B40EC40F45
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:03:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nwNiiZmzrqM3 for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 13:03:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1255740E84
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:03:28 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id j18so2222302wra.2
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 06:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IjhiGWaYytxC9lWlMHlmYumwtVLrwtd+/oeeDGUVrUA=;
 b=SgiZPR6AgvgrVBVPJoHXvHKH1TaIqi5VsGH92lGi3xTtXJUw0lMcA/uF2DYQ8cXDol
 vQfAOobYfW5QeZDye3HI3FT+zumr/lbKnziFovqPlVCOI+w3dKye1XqeDmlofn43qrhS
 Lno5FA0YZ2oZs7xuXBIY0s70xKSH1tBa8Xzc9aY2OnzZVnGHw5dGqvswUU/5+vNKevda
 Fsszg5ao62i5oqrDpjQK/HsRV8KXuZTh69RVQEi0tXb6jHraHz6cS9zoeEQkJJoBfvay
 iK8BFBS/ocm4pLBopmS0FfV0s6laG85+uepLrwE+JiNbNBmvv287CMg5LY7FINKiTdv4
 ge9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IjhiGWaYytxC9lWlMHlmYumwtVLrwtd+/oeeDGUVrUA=;
 b=qOZEZZQyQoYnYmBJU8Nkb3VC8piayRyptXlvrVodrtLM/nBY6o5+lOwdquNb2M4Ts4
 w2mhSufkcq91VB8yhLa3JhWac6ScXQd9k8onU3AF4hAU6l3qHoyVgGs5pk/B1sq2yzZR
 rJyTmdiEABc9O0IE/9FwFAkJ2pwV/0Izukej+VMCXDqAhlLDTWuGXvy+m0xmQkEbwFsj
 U9gri6ecvLTWHjjkAkQBM7bgHntFNPErwj1PJSliwcoHJ8ZnKdZXbzQTDdkKU8ItvkFQ
 1OihT+BVs+o3pyKz0Y6cMuEl325uWNZQjLhn9cqKdehkWKLpif+WZjXylYb2Wv92ansS
 pb4A==
X-Gm-Message-State: AOAM533a4/RQexj7zPsRMIQInO041JRumNlJpeT+qJoOm+S7mxgGNb03
 ZJoxaaFPWSW/O3B85dm/NrE=
X-Google-Smtp-Source: ABdhPJzRrdMc9xg9WCHy0/CB4KYiAZxLjJRRCcqbmi/STbnZCu5v5il8t9qvQW9rS2lWnBaMb51E4A==
X-Received: by 2002:a05:6000:362:: with SMTP id
 f2mr694250wrf.141.1616677407012; 
 Thu, 25 Mar 2021 06:03:27 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id n9sm6836157wrx.46.2021.03.25.06.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 06:03:26 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/9] memory: tegra: Add memory client IDs to tables
Date: Thu, 25 Mar 2021 14:03:25 +0100
Message-Id: <20210325130332.778208-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325130332.778208-1-thierry.reding@gmail.com>
References: <20210325130332.778208-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Thierry Reding <treding@nvidia.com>

The memory client IDs will subsequently be used to program override SIDs
for the given clients depending on the device tree configuration.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/tegra186.c | 206 ++++++++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index aa676c45650b..efa922d51d83 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -21,6 +21,7 @@
 
 struct tegra186_mc_client {
 	const char *name;
+	unsigned int id;
 	unsigned int sid;
 	struct {
 		unsigned int override;
@@ -70,6 +71,7 @@ static void tegra186_mc_program_sid(struct tegra_mc *mc)
 static const struct tegra186_mc_client tegra186_mc_clients[] = {
 	{
 		.name = "ptcr",
+		.id = TEGRA186_MEMORY_CLIENT_PTCR,
 		.sid = TEGRA186_SID_PASSTHROUGH,
 		.regs = {
 			.override = 0x000,
@@ -77,6 +79,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "afir",
+		.id = TEGRA186_MEMORY_CLIENT_AFIR,
 		.sid = TEGRA186_SID_AFI,
 		.regs = {
 			.override = 0x070,
@@ -84,6 +87,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "hdar",
+		.id = TEGRA186_MEMORY_CLIENT_HDAR,
 		.sid = TEGRA186_SID_HDA,
 		.regs = {
 			.override = 0x0a8,
@@ -91,6 +95,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "host1xdmar",
+		.id = TEGRA186_MEMORY_CLIENT_HOST1XDMAR,
 		.sid = TEGRA186_SID_HOST1X,
 		.regs = {
 			.override = 0x0b0,
@@ -99,12 +104,14 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 	}, {
 		.name = "nvencsrd",
 		.sid = TEGRA186_SID_NVENC,
+		.id = TEGRA186_MEMORY_CLIENT_NVENCSRD,
 		.regs = {
 			.override = 0x0e0,
 			.security = 0x0e4,
 		},
 	}, {
 		.name = "satar",
+		.id = TEGRA186_MEMORY_CLIENT_SATAR,
 		.sid = TEGRA186_SID_SATA,
 		.regs = {
 			.override = 0x0f8,
@@ -112,6 +119,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "mpcorer",
+		.id = TEGRA186_MEMORY_CLIENT_MPCORER,
 		.sid = TEGRA186_SID_PASSTHROUGH,
 		.regs = {
 			.override = 0x138,
@@ -119,6 +127,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "nvencswr",
+		.id = TEGRA186_MEMORY_CLIENT_NVENCSWR,
 		.sid = TEGRA186_SID_NVENC,
 		.regs = {
 			.override = 0x158,
@@ -126,6 +135,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "afiw",
+		.id = TEGRA186_MEMORY_CLIENT_AFIW,
 		.sid = TEGRA186_SID_AFI,
 		.regs = {
 			.override = 0x188,
@@ -133,6 +143,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "hdaw",
+		.id = TEGRA186_MEMORY_CLIENT_HDAW,
 		.sid = TEGRA186_SID_HDA,
 		.regs = {
 			.override = 0x1a8,
@@ -140,6 +151,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "mpcorew",
+		.id = TEGRA186_MEMORY_CLIENT_MPCOREW,
 		.sid = TEGRA186_SID_PASSTHROUGH,
 		.regs = {
 			.override = 0x1c8,
@@ -147,6 +159,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "sataw",
+		.id = TEGRA186_MEMORY_CLIENT_SATAW,
 		.sid = TEGRA186_SID_SATA,
 		.regs = {
 			.override = 0x1e8,
@@ -154,6 +167,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "ispra",
+		.id = TEGRA186_MEMORY_CLIENT_ISPRA,
 		.sid = TEGRA186_SID_ISP,
 		.regs = {
 			.override = 0x220,
@@ -161,6 +175,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "ispwa",
+		.id = TEGRA186_MEMORY_CLIENT_ISPWA,
 		.sid = TEGRA186_SID_ISP,
 		.regs = {
 			.override = 0x230,
@@ -168,6 +183,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "ispwb",
+		.id = TEGRA186_MEMORY_CLIENT_ISPWB,
 		.sid = TEGRA186_SID_ISP,
 		.regs = {
 			.override = 0x238,
@@ -175,6 +191,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "xusb_hostr",
+		.id = TEGRA186_MEMORY_CLIENT_XUSB_HOSTR,
 		.sid = TEGRA186_SID_XUSB_HOST,
 		.regs = {
 			.override = 0x250,
@@ -182,6 +199,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "xusb_hostw",
+		.id = TEGRA186_MEMORY_CLIENT_XUSB_HOSTW,
 		.sid = TEGRA186_SID_XUSB_HOST,
 		.regs = {
 			.override = 0x258,
@@ -189,6 +207,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "xusb_devr",
+		.id = TEGRA186_MEMORY_CLIENT_XUSB_DEVR,
 		.sid = TEGRA186_SID_XUSB_DEV,
 		.regs = {
 			.override = 0x260,
@@ -196,6 +215,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "xusb_devw",
+		.id = TEGRA186_MEMORY_CLIENT_XUSB_DEVW,
 		.sid = TEGRA186_SID_XUSB_DEV,
 		.regs = {
 			.override = 0x268,
@@ -203,6 +223,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "tsecsrd",
+		.id = TEGRA186_MEMORY_CLIENT_TSECSRD,
 		.sid = TEGRA186_SID_TSEC,
 		.regs = {
 			.override = 0x2a0,
@@ -210,6 +231,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "tsecswr",
+		.id = TEGRA186_MEMORY_CLIENT_TSECSWR,
 		.sid = TEGRA186_SID_TSEC,
 		.regs = {
 			.override = 0x2a8,
@@ -217,6 +239,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "gpusrd",
+		.id = TEGRA186_MEMORY_CLIENT_GPUSRD,
 		.sid = TEGRA186_SID_GPU,
 		.regs = {
 			.override = 0x2c0,
@@ -224,6 +247,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "gpuswr",
+		.id = TEGRA186_MEMORY_CLIENT_GPUSWR,
 		.sid = TEGRA186_SID_GPU,
 		.regs = {
 			.override = 0x2c8,
@@ -231,6 +255,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "sdmmcra",
+		.id = TEGRA186_MEMORY_CLIENT_SDMMCRA,
 		.sid = TEGRA186_SID_SDMMC1,
 		.regs = {
 			.override = 0x300,
@@ -238,6 +263,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "sdmmcraa",
+		.id = TEGRA186_MEMORY_CLIENT_SDMMCRAA,
 		.sid = TEGRA186_SID_SDMMC2,
 		.regs = {
 			.override = 0x308,
@@ -245,6 +271,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "sdmmcr",
+		.id = TEGRA186_MEMORY_CLIENT_SDMMCR,
 		.sid = TEGRA186_SID_SDMMC3,
 		.regs = {
 			.override = 0x310,
@@ -252,6 +279,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "sdmmcrab",
+		.id = TEGRA186_MEMORY_CLIENT_SDMMCRAB,
 		.sid = TEGRA186_SID_SDMMC4,
 		.regs = {
 			.override = 0x318,
@@ -259,6 +287,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "sdmmcwa",
+		.id = TEGRA186_MEMORY_CLIENT_SDMMCWA,
 		.sid = TEGRA186_SID_SDMMC1,
 		.regs = {
 			.override = 0x320,
@@ -266,6 +295,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "sdmmcwaa",
+		.id = TEGRA186_MEMORY_CLIENT_SDMMCWAA,
 		.sid = TEGRA186_SID_SDMMC2,
 		.regs = {
 			.override = 0x328,
@@ -273,6 +303,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "sdmmcw",
+		.id = TEGRA186_MEMORY_CLIENT_SDMMCW,
 		.sid = TEGRA186_SID_SDMMC3,
 		.regs = {
 			.override = 0x330,
@@ -280,6 +311,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "sdmmcwab",
+		.id = TEGRA186_MEMORY_CLIENT_SDMMCWAB,
 		.sid = TEGRA186_SID_SDMMC4,
 		.regs = {
 			.override = 0x338,
@@ -287,6 +319,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "vicsrd",
+		.id = TEGRA186_MEMORY_CLIENT_VICSRD,
 		.sid = TEGRA186_SID_VIC,
 		.regs = {
 			.override = 0x360,
@@ -294,6 +327,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "vicswr",
+		.id = TEGRA186_MEMORY_CLIENT_VICSWR,
 		.sid = TEGRA186_SID_VIC,
 		.regs = {
 			.override = 0x368,
@@ -301,6 +335,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "viw",
+		.id = TEGRA186_MEMORY_CLIENT_VIW,
 		.sid = TEGRA186_SID_VI,
 		.regs = {
 			.override = 0x390,
@@ -308,6 +343,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "nvdecsrd",
+		.id = TEGRA186_MEMORY_CLIENT_NVDECSRD,
 		.sid = TEGRA186_SID_NVDEC,
 		.regs = {
 			.override = 0x3c0,
@@ -315,6 +351,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "nvdecswr",
+		.id = TEGRA186_MEMORY_CLIENT_NVDECSWR,
 		.sid = TEGRA186_SID_NVDEC,
 		.regs = {
 			.override = 0x3c8,
@@ -322,6 +359,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "aper",
+		.id = TEGRA186_MEMORY_CLIENT_APER,
 		.sid = TEGRA186_SID_APE,
 		.regs = {
 			.override = 0x3d0,
@@ -329,6 +367,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "apew",
+		.id = TEGRA186_MEMORY_CLIENT_APEW,
 		.sid = TEGRA186_SID_APE,
 		.regs = {
 			.override = 0x3d8,
@@ -336,6 +375,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "nvjpgsrd",
+		.id = TEGRA186_MEMORY_CLIENT_NVJPGSRD,
 		.sid = TEGRA186_SID_NVJPG,
 		.regs = {
 			.override = 0x3f0,
@@ -343,6 +383,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "nvjpgswr",
+		.id = TEGRA186_MEMORY_CLIENT_NVJPGSWR,
 		.sid = TEGRA186_SID_NVJPG,
 		.regs = {
 			.override = 0x3f8,
@@ -350,6 +391,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "sesrd",
+		.id = TEGRA186_MEMORY_CLIENT_SESRD,
 		.sid = TEGRA186_SID_SE,
 		.regs = {
 			.override = 0x400,
@@ -357,6 +399,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "seswr",
+		.id = TEGRA186_MEMORY_CLIENT_SESWR,
 		.sid = TEGRA186_SID_SE,
 		.regs = {
 			.override = 0x408,
@@ -364,6 +407,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "etrr",
+		.id = TEGRA186_MEMORY_CLIENT_ETRR,
 		.sid = TEGRA186_SID_ETR,
 		.regs = {
 			.override = 0x420,
@@ -371,6 +415,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "etrw",
+		.id = TEGRA186_MEMORY_CLIENT_ETRW,
 		.sid = TEGRA186_SID_ETR,
 		.regs = {
 			.override = 0x428,
@@ -378,6 +423,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "tsecsrdb",
+		.id = TEGRA186_MEMORY_CLIENT_TSECSRDB,
 		.sid = TEGRA186_SID_TSECB,
 		.regs = {
 			.override = 0x430,
@@ -385,6 +431,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "tsecswrb",
+		.id = TEGRA186_MEMORY_CLIENT_TSECSWRB,
 		.sid = TEGRA186_SID_TSECB,
 		.regs = {
 			.override = 0x438,
@@ -392,6 +439,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "gpusrd2",
+		.id = TEGRA186_MEMORY_CLIENT_GPUSRD2,
 		.sid = TEGRA186_SID_GPU,
 		.regs = {
 			.override = 0x440,
@@ -399,6 +447,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "gpuswr2",
+		.id = TEGRA186_MEMORY_CLIENT_GPUSWR2,
 		.sid = TEGRA186_SID_GPU,
 		.regs = {
 			.override = 0x448,
@@ -406,6 +455,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "axisr",
+		.id = TEGRA186_MEMORY_CLIENT_AXISR,
 		.sid = TEGRA186_SID_GPCDMA_0,
 		.regs = {
 			.override = 0x460,
@@ -413,6 +463,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "axisw",
+		.id = TEGRA186_MEMORY_CLIENT_AXISW,
 		.sid = TEGRA186_SID_GPCDMA_0,
 		.regs = {
 			.override = 0x468,
@@ -420,6 +471,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "eqosr",
+		.id = TEGRA186_MEMORY_CLIENT_EQOSR,
 		.sid = TEGRA186_SID_EQOS,
 		.regs = {
 			.override = 0x470,
@@ -427,6 +479,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "eqosw",
+		.id = TEGRA186_MEMORY_CLIENT_EQOSW,
 		.sid = TEGRA186_SID_EQOS,
 		.regs = {
 			.override = 0x478,
@@ -434,6 +487,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "ufshcr",
+		.id = TEGRA186_MEMORY_CLIENT_UFSHCR,
 		.sid = TEGRA186_SID_UFSHC,
 		.regs = {
 			.override = 0x480,
@@ -441,6 +495,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "ufshcw",
+		.id = TEGRA186_MEMORY_CLIENT_UFSHCW,
 		.sid = TEGRA186_SID_UFSHC,
 		.regs = {
 			.override = 0x488,
@@ -448,6 +503,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "nvdisplayr",
+		.id = TEGRA186_MEMORY_CLIENT_NVDISPLAYR,
 		.sid = TEGRA186_SID_NVDISPLAY,
 		.regs = {
 			.override = 0x490,
@@ -455,6 +511,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "bpmpr",
+		.id = TEGRA186_MEMORY_CLIENT_BPMPR,
 		.sid = TEGRA186_SID_BPMP,
 		.regs = {
 			.override = 0x498,
@@ -462,6 +519,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "bpmpw",
+		.id = TEGRA186_MEMORY_CLIENT_BPMPW,
 		.sid = TEGRA186_SID_BPMP,
 		.regs = {
 			.override = 0x4a0,
@@ -469,6 +527,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "bpmpdmar",
+		.id = TEGRA186_MEMORY_CLIENT_BPMPDMAR,
 		.sid = TEGRA186_SID_BPMP,
 		.regs = {
 			.override = 0x4a8,
@@ -476,6 +535,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "bpmpdmaw",
+		.id = TEGRA186_MEMORY_CLIENT_BPMPDMAW,
 		.sid = TEGRA186_SID_BPMP,
 		.regs = {
 			.override = 0x4b0,
@@ -483,6 +543,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "aonr",
+		.id = TEGRA186_MEMORY_CLIENT_AONR,
 		.sid = TEGRA186_SID_AON,
 		.regs = {
 			.override = 0x4b8,
@@ -490,6 +551,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "aonw",
+		.id = TEGRA186_MEMORY_CLIENT_AONW,
 		.sid = TEGRA186_SID_AON,
 		.regs = {
 			.override = 0x4c0,
@@ -497,6 +559,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "aondmar",
+		.id = TEGRA186_MEMORY_CLIENT_AONDMAR,
 		.sid = TEGRA186_SID_AON,
 		.regs = {
 			.override = 0x4c8,
@@ -504,6 +567,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "aondmaw",
+		.id = TEGRA186_MEMORY_CLIENT_AONDMAW,
 		.sid = TEGRA186_SID_AON,
 		.regs = {
 			.override = 0x4d0,
@@ -511,6 +575,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "scer",
+		.id = TEGRA186_MEMORY_CLIENT_SCER,
 		.sid = TEGRA186_SID_SCE,
 		.regs = {
 			.override = 0x4d8,
@@ -518,6 +583,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "scew",
+		.id = TEGRA186_MEMORY_CLIENT_SCEW,
 		.sid = TEGRA186_SID_SCE,
 		.regs = {
 			.override = 0x4e0,
@@ -525,6 +591,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "scedmar",
+		.id = TEGRA186_MEMORY_CLIENT_SCEDMAR,
 		.sid = TEGRA186_SID_SCE,
 		.regs = {
 			.override = 0x4e8,
@@ -532,6 +599,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "scedmaw",
+		.id = TEGRA186_MEMORY_CLIENT_SCEDMAW,
 		.sid = TEGRA186_SID_SCE,
 		.regs = {
 			.override = 0x4f0,
@@ -539,6 +607,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "apedmar",
+		.id = TEGRA186_MEMORY_CLIENT_APEDMAR,
 		.sid = TEGRA186_SID_APE,
 		.regs = {
 			.override = 0x4f8,
@@ -546,6 +615,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "apedmaw",
+		.id = TEGRA186_MEMORY_CLIENT_APEDMAW,
 		.sid = TEGRA186_SID_APE,
 		.regs = {
 			.override = 0x500,
@@ -553,6 +623,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "nvdisplayr1",
+		.id = TEGRA186_MEMORY_CLIENT_NVDISPLAYR1,
 		.sid = TEGRA186_SID_NVDISPLAY,
 		.regs = {
 			.override = 0x508,
@@ -560,6 +631,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "vicsrd1",
+		.id = TEGRA186_MEMORY_CLIENT_VICSRD1,
 		.sid = TEGRA186_SID_VIC,
 		.regs = {
 			.override = 0x510,
@@ -567,6 +639,7 @@ static const struct tegra186_mc_client tegra186_mc_clients[] = {
 		},
 	}, {
 		.name = "nvdecsrd1",
+		.id = TEGRA186_MEMORY_CLIENT_NVDECSRD1,
 		.sid = TEGRA186_SID_NVDEC,
 		.regs = {
 			.override = 0x518,
@@ -585,6 +658,7 @@ static const struct tegra186_mc_soc tegra186_mc_soc = {
 static const struct tegra186_mc_client tegra194_mc_clients[] = {
 	{
 		.name = "ptcr",
+		.id = TEGRA194_MEMORY_CLIENT_PTCR,
 		.sid = TEGRA194_SID_PASSTHROUGH,
 		.regs = {
 			.override = 0x000,
@@ -592,6 +666,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "miu7r",
+		.id = TEGRA194_MEMORY_CLIENT_MIU7R,
 		.sid = TEGRA194_SID_MIU,
 		.regs = {
 			.override = 0x008,
@@ -599,6 +674,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "miu7w",
+		.id = TEGRA194_MEMORY_CLIENT_MIU7W,
 		.sid = TEGRA194_SID_MIU,
 		.regs = {
 			.override = 0x010,
@@ -606,6 +682,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "hdar",
+		.id = TEGRA194_MEMORY_CLIENT_HDAR,
 		.sid = TEGRA194_SID_HDA,
 		.regs = {
 			.override = 0x0a8,
@@ -613,6 +690,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "host1xdmar",
+		.id = TEGRA194_MEMORY_CLIENT_HOST1XDMAR,
 		.sid = TEGRA194_SID_HOST1X,
 		.regs = {
 			.override = 0x0b0,
@@ -620,6 +698,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "nvencsrd",
+		.id = TEGRA194_MEMORY_CLIENT_NVENCSRD,
 		.sid = TEGRA194_SID_NVENC,
 		.regs = {
 			.override = 0x0e0,
@@ -627,6 +706,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "satar",
+		.id = TEGRA194_MEMORY_CLIENT_SATAR,
 		.sid = TEGRA194_SID_SATA,
 		.regs = {
 			.override = 0x0f8,
@@ -634,6 +714,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "mpcorer",
+		.id = TEGRA194_MEMORY_CLIENT_MPCORER,
 		.sid = TEGRA194_SID_PASSTHROUGH,
 		.regs = {
 			.override = 0x138,
@@ -641,6 +722,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "nvencswr",
+		.id = TEGRA194_MEMORY_CLIENT_NVENCSWR,
 		.sid = TEGRA194_SID_NVENC,
 		.regs = {
 			.override = 0x158,
@@ -648,6 +730,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "hdaw",
+		.id = TEGRA194_MEMORY_CLIENT_HDAW,
 		.sid = TEGRA194_SID_HDA,
 		.regs = {
 			.override = 0x1a8,
@@ -655,6 +738,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "mpcorew",
+		.id = TEGRA194_MEMORY_CLIENT_MPCOREW,
 		.sid = TEGRA194_SID_PASSTHROUGH,
 		.regs = {
 			.override = 0x1c8,
@@ -662,6 +746,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "sataw",
+		.id = TEGRA194_MEMORY_CLIENT_SATAW,
 		.sid = TEGRA194_SID_SATA,
 		.regs = {
 			.override = 0x1e8,
@@ -669,6 +754,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "ispra",
+		.id = TEGRA194_MEMORY_CLIENT_ISPRA,
 		.sid = TEGRA194_SID_ISP,
 		.regs = {
 			.override = 0x220,
@@ -676,6 +762,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "ispfalr",
+		.id = TEGRA194_MEMORY_CLIENT_ISPFALR,
 		.sid = TEGRA194_SID_ISP_FALCON,
 		.regs = {
 			.override = 0x228,
@@ -683,6 +770,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "ispwa",
+		.id = TEGRA194_MEMORY_CLIENT_ISPWA,
 		.sid = TEGRA194_SID_ISP,
 		.regs = {
 			.override = 0x230,
@@ -690,6 +778,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "ispwb",
+		.id = TEGRA194_MEMORY_CLIENT_ISPWB,
 		.sid = TEGRA194_SID_ISP,
 		.regs = {
 			.override = 0x238,
@@ -697,6 +786,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "xusb_hostr",
+		.id = TEGRA194_MEMORY_CLIENT_XUSB_HOSTR,
 		.sid = TEGRA194_SID_XUSB_HOST,
 		.regs = {
 			.override = 0x250,
@@ -704,6 +794,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "xusb_hostw",
+		.id = TEGRA194_MEMORY_CLIENT_XUSB_HOSTW,
 		.sid = TEGRA194_SID_XUSB_HOST,
 		.regs = {
 			.override = 0x258,
@@ -711,6 +802,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "xusb_devr",
+		.id = TEGRA194_MEMORY_CLIENT_XUSB_DEVR,
 		.sid = TEGRA194_SID_XUSB_DEV,
 		.regs = {
 			.override = 0x260,
@@ -718,6 +810,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "xusb_devw",
+		.id = TEGRA194_MEMORY_CLIENT_XUSB_DEVW,
 		.sid = TEGRA194_SID_XUSB_DEV,
 		.regs = {
 			.override = 0x268,
@@ -725,6 +818,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "sdmmcra",
+		.id = TEGRA194_MEMORY_CLIENT_SDMMCRA,
 		.sid = TEGRA194_SID_SDMMC1,
 		.regs = {
 			.override = 0x300,
@@ -732,6 +826,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "sdmmcr",
+		.id = TEGRA194_MEMORY_CLIENT_SDMMCR,
 		.sid = TEGRA194_SID_SDMMC3,
 		.regs = {
 			.override = 0x310,
@@ -739,6 +834,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "sdmmcrab",
+		.id = TEGRA194_MEMORY_CLIENT_SDMMCRAB,
 		.sid = TEGRA194_SID_SDMMC4,
 		.regs = {
 			.override = 0x318,
@@ -746,6 +842,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "sdmmcwa",
+		.id = TEGRA194_MEMORY_CLIENT_SDMMCWA,
 		.sid = TEGRA194_SID_SDMMC1,
 		.regs = {
 			.override = 0x320,
@@ -753,6 +850,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "sdmmcw",
+		.id = TEGRA194_MEMORY_CLIENT_SDMMCW,
 		.sid = TEGRA194_SID_SDMMC3,
 		.regs = {
 			.override = 0x330,
@@ -760,6 +858,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "sdmmcwab",
+		.id = TEGRA194_MEMORY_CLIENT_SDMMCWAB,
 		.sid = TEGRA194_SID_SDMMC4,
 		.regs = {
 			.override = 0x338,
@@ -767,6 +866,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "vicsrd",
+		.id = TEGRA194_MEMORY_CLIENT_VICSRD,
 		.sid = TEGRA194_SID_VIC,
 		.regs = {
 			.override = 0x360,
@@ -774,6 +874,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "vicswr",
+		.id = TEGRA194_MEMORY_CLIENT_VICSWR,
 		.sid = TEGRA194_SID_VIC,
 		.regs = {
 			.override = 0x368,
@@ -781,6 +882,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "viw",
+		.id = TEGRA194_MEMORY_CLIENT_VIW,
 		.sid = TEGRA194_SID_VI,
 		.regs = {
 			.override = 0x390,
@@ -788,6 +890,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "nvdecsrd",
+		.id = TEGRA194_MEMORY_CLIENT_NVDECSRD,
 		.sid = TEGRA194_SID_NVDEC,
 		.regs = {
 			.override = 0x3c0,
@@ -795,6 +898,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "nvdecswr",
+		.id = TEGRA194_MEMORY_CLIENT_NVDECSWR,
 		.sid = TEGRA194_SID_NVDEC,
 		.regs = {
 			.override = 0x3c8,
@@ -802,6 +906,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "aper",
+		.id = TEGRA194_MEMORY_CLIENT_APER,
 		.sid = TEGRA194_SID_APE,
 		.regs = {
 			.override = 0x3c0,
@@ -809,6 +914,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "apew",
+		.id = TEGRA194_MEMORY_CLIENT_APEW,
 		.sid = TEGRA194_SID_APE,
 		.regs = {
 			.override = 0x3d0,
@@ -816,6 +922,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "nvjpgsrd",
+		.id = TEGRA194_MEMORY_CLIENT_NVJPGSRD,
 		.sid = TEGRA194_SID_NVJPG,
 		.regs = {
 			.override = 0x3f0,
@@ -823,6 +930,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "nvjpgswr",
+		.id = TEGRA194_MEMORY_CLIENT_NVJPGSWR,
 		.sid = TEGRA194_SID_NVJPG,
 		.regs = {
 			.override = 0x3f0,
@@ -831,12 +939,14 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 	}, {
 		.name = "axiapr",
 		.sid = TEGRA194_SID_PASSTHROUGH,
+		.id = TEGRA194_MEMORY_CLIENT_AXIAPR,
 		.regs = {
 			.override = 0x410,
 			.security = 0x414,
 		},
 	}, {
 		.name = "axiapw",
+		.id = TEGRA194_MEMORY_CLIENT_AXIAPW,
 		.sid = TEGRA194_SID_PASSTHROUGH,
 		.regs = {
 			.override = 0x418,
@@ -844,6 +954,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "etrr",
+		.id = TEGRA194_MEMORY_CLIENT_ETRR,
 		.sid = TEGRA194_SID_ETR,
 		.regs = {
 			.override = 0x420,
@@ -851,6 +962,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "etrw",
+		.id = TEGRA194_MEMORY_CLIENT_ETRW,
 		.sid = TEGRA194_SID_ETR,
 		.regs = {
 			.override = 0x428,
@@ -858,6 +970,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "axisr",
+		.id = TEGRA194_MEMORY_CLIENT_AXISR,
 		.sid = TEGRA194_SID_PASSTHROUGH,
 		.regs = {
 			.override = 0x460,
@@ -865,6 +978,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "axisw",
+		.id = TEGRA194_MEMORY_CLIENT_AXISW,
 		.sid = TEGRA194_SID_PASSTHROUGH,
 		.regs = {
 			.override = 0x468,
@@ -872,6 +986,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "eqosr",
+		.id = TEGRA194_MEMORY_CLIENT_EQOSR,
 		.sid = TEGRA194_SID_EQOS,
 		.regs = {
 			.override = 0x470,
@@ -880,12 +995,14 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 	}, {
 		.name = "eqosw",
 		.sid = TEGRA194_SID_EQOS,
+		.id = TEGRA194_MEMORY_CLIENT_EQOSW,
 		.regs = {
 			.override = 0x478,
 			.security = 0x47c,
 		},
 	}, {
 		.name = "ufshcr",
+		.id = TEGRA194_MEMORY_CLIENT_UFSHCR,
 		.sid = TEGRA194_SID_UFSHC,
 		.regs = {
 			.override = 0x480,
@@ -893,6 +1010,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "ufshcw",
+		.id = TEGRA194_MEMORY_CLIENT_UFSHCW,
 		.sid = TEGRA194_SID_UFSHC,
 		.regs = {
 			.override = 0x488,
@@ -900,6 +1018,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "nvdisplayr",
+		.id = TEGRA194_MEMORY_CLIENT_NVDISPLAYR,
 		.sid = TEGRA194_SID_NVDISPLAY,
 		.regs = {
 			.override = 0x490,
@@ -907,6 +1026,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "bpmpr",
+		.id = TEGRA194_MEMORY_CLIENT_BPMPR,
 		.sid = TEGRA194_SID_BPMP,
 		.regs = {
 			.override = 0x498,
@@ -914,6 +1034,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "bpmpw",
+		.id = TEGRA194_MEMORY_CLIENT_BPMPW,
 		.sid = TEGRA194_SID_BPMP,
 		.regs = {
 			.override = 0x4a0,
@@ -921,6 +1042,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "bpmpdmar",
+		.id = TEGRA194_MEMORY_CLIENT_BPMPDMAR,
 		.sid = TEGRA194_SID_BPMP,
 		.regs = {
 			.override = 0x4a8,
@@ -928,6 +1050,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "bpmpdmaw",
+		.id = TEGRA194_MEMORY_CLIENT_BPMPDMAW,
 		.sid = TEGRA194_SID_BPMP,
 		.regs = {
 			.override = 0x4b0,
@@ -935,6 +1058,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "aonr",
+		.id = TEGRA194_MEMORY_CLIENT_AONR,
 		.sid = TEGRA194_SID_AON,
 		.regs = {
 			.override = 0x4b8,
@@ -942,6 +1066,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "aonw",
+		.id = TEGRA194_MEMORY_CLIENT_AONW,
 		.sid = TEGRA194_SID_AON,
 		.regs = {
 			.override = 0x4c0,
@@ -949,6 +1074,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "aondmar",
+		.id = TEGRA194_MEMORY_CLIENT_AONDMAR,
 		.sid = TEGRA194_SID_AON,
 		.regs = {
 			.override = 0x4c8,
@@ -956,6 +1082,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "aondmaw",
+		.id = TEGRA194_MEMORY_CLIENT_AONDMAW,
 		.sid = TEGRA194_SID_AON,
 		.regs = {
 			.override = 0x4d0,
@@ -963,6 +1090,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "scer",
+		.id = TEGRA194_MEMORY_CLIENT_SCER,
 		.sid = TEGRA194_SID_SCE,
 		.regs = {
 			.override = 0x4d8,
@@ -970,6 +1098,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "scew",
+		.id = TEGRA194_MEMORY_CLIENT_SCEW,
 		.sid = TEGRA194_SID_SCE,
 		.regs = {
 			.override = 0x4e0,
@@ -977,6 +1106,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "scedmar",
+		.id = TEGRA194_MEMORY_CLIENT_SCEDMAR,
 		.sid = TEGRA194_SID_SCE,
 		.regs = {
 			.override = 0x4e8,
@@ -984,6 +1114,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "scedmaw",
+		.id = TEGRA194_MEMORY_CLIENT_SCEDMAW,
 		.sid = TEGRA194_SID_SCE,
 		.regs = {
 			.override = 0x4f0,
@@ -991,6 +1122,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "apedmar",
+		.id = TEGRA194_MEMORY_CLIENT_APEDMAR,
 		.sid = TEGRA194_SID_APE,
 		.regs = {
 			.override = 0x4f8,
@@ -998,6 +1130,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "apedmaw",
+		.id = TEGRA194_MEMORY_CLIENT_APEDMAW,
 		.sid = TEGRA194_SID_APE,
 		.regs = {
 			.override = 0x500,
@@ -1005,6 +1138,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "nvdisplayr1",
+		.id = TEGRA194_MEMORY_CLIENT_NVDISPLAYR1,
 		.sid = TEGRA194_SID_NVDISPLAY,
 		.regs = {
 			.override = 0x508,
@@ -1012,6 +1146,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "vicsrd1",
+		.id = TEGRA194_MEMORY_CLIENT_VICSRD1,
 		.sid = TEGRA194_SID_VIC,
 		.regs = {
 			.override = 0x510,
@@ -1019,6 +1154,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "nvdecsrd1",
+		.id = TEGRA194_MEMORY_CLIENT_NVDECSRD1,
 		.sid = TEGRA194_SID_NVDEC,
 		.regs = {
 			.override = 0x518,
@@ -1026,6 +1162,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "miu0r",
+		.id = TEGRA194_MEMORY_CLIENT_MIU0R,
 		.sid = TEGRA194_SID_MIU,
 		.regs = {
 			.override = 0x530,
@@ -1034,12 +1171,14 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 	}, {
 		.name = "miu0w",
 		.sid = TEGRA194_SID_MIU,
+		.id = TEGRA194_MEMORY_CLIENT_MIU0W,
 		.regs = {
 			.override = 0x538,
 			.security = 0x53c,
 		},
 	}, {
 		.name = "miu1r",
+		.id = TEGRA194_MEMORY_CLIENT_MIU1R,
 		.sid = TEGRA194_SID_MIU,
 		.regs = {
 			.override = 0x540,
@@ -1047,6 +1186,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "miu1w",
+		.id = TEGRA194_MEMORY_CLIENT_MIU1W,
 		.sid = TEGRA194_SID_MIU,
 		.regs = {
 			.override = 0x548,
@@ -1054,6 +1194,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "miu2r",
+		.id = TEGRA194_MEMORY_CLIENT_MIU2R,
 		.sid = TEGRA194_SID_MIU,
 		.regs = {
 			.override = 0x570,
@@ -1061,6 +1202,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "miu2w",
+		.id = TEGRA194_MEMORY_CLIENT_MIU2W,
 		.sid = TEGRA194_SID_MIU,
 		.regs = {
 			.override = 0x578,
@@ -1068,6 +1210,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "miu3r",
+		.id = TEGRA194_MEMORY_CLIENT_MIU3R,
 		.sid = TEGRA194_SID_MIU,
 		.regs = {
 			.override = 0x580,
@@ -1075,6 +1218,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "miu3w",
+		.id = TEGRA194_MEMORY_CLIENT_MIU3W,
 		.sid = TEGRA194_SID_MIU,
 		.regs = {
 			.override = 0x588,
@@ -1082,6 +1226,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "miu4r",
+		.id = TEGRA194_MEMORY_CLIENT_MIU4R,
 		.sid = TEGRA194_SID_MIU,
 		.regs = {
 			.override = 0x590,
@@ -1089,6 +1234,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "miu4w",
+		.id = TEGRA194_MEMORY_CLIENT_MIU4W,
 		.sid = TEGRA194_SID_MIU,
 		.regs = {
 			.override = 0x598,
@@ -1096,6 +1242,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "dpmur",
+		.id = TEGRA194_MEMORY_CLIENT_DPMUR,
 		.sid = TEGRA194_SID_PASSTHROUGH,
 		.regs = {
 			.override = 0x598,
@@ -1103,6 +1250,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "vifalr",
+		.id = TEGRA194_MEMORY_CLIENT_VIFALR,
 		.sid = TEGRA194_SID_VI_FALCON,
 		.regs = {
 			.override = 0x5e0,
@@ -1110,6 +1258,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "vifalw",
+		.id = TEGRA194_MEMORY_CLIENT_VIFALW,
 		.sid = TEGRA194_SID_VI_FALCON,
 		.regs = {
 			.override = 0x5e8,
@@ -1117,6 +1266,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "dla0rda",
+		.id = TEGRA194_MEMORY_CLIENT_DLA0RDA,
 		.sid = TEGRA194_SID_NVDLA0,
 		.regs = {
 			.override = 0x5f0,
@@ -1124,6 +1274,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "dla0falrdb",
+		.id = TEGRA194_MEMORY_CLIENT_DLA0FALRDB,
 		.sid = TEGRA194_SID_NVDLA0,
 		.regs = {
 			.override = 0x5f8,
@@ -1131,6 +1282,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "dla0wra",
+		.id = TEGRA194_MEMORY_CLIENT_DLA0WRA,
 		.sid = TEGRA194_SID_NVDLA0,
 		.regs = {
 			.override = 0x600,
@@ -1138,6 +1290,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "dla0falwrb",
+		.id = TEGRA194_MEMORY_CLIENT_DLA0FALWRB,
 		.sid = TEGRA194_SID_NVDLA0,
 		.regs = {
 			.override = 0x608,
@@ -1145,6 +1298,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "dla1rda",
+		.id = TEGRA194_MEMORY_CLIENT_DLA1RDA,
 		.sid = TEGRA194_SID_NVDLA1,
 		.regs = {
 			.override = 0x610,
@@ -1152,6 +1306,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "dla1falrdb",
+		.id = TEGRA194_MEMORY_CLIENT_DLA1FALRDB,
 		.sid = TEGRA194_SID_NVDLA1,
 		.regs = {
 			.override = 0x618,
@@ -1159,6 +1314,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "dla1wra",
+		.id = TEGRA194_MEMORY_CLIENT_DLA1WRA,
 		.sid = TEGRA194_SID_NVDLA1,
 		.regs = {
 			.override = 0x620,
@@ -1166,6 +1322,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "dla1falwrb",
+		.id = TEGRA194_MEMORY_CLIENT_DLA1FALWRB,
 		.sid = TEGRA194_SID_NVDLA1,
 		.regs = {
 			.override = 0x628,
@@ -1173,6 +1330,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pva0rda",
+		.id = TEGRA194_MEMORY_CLIENT_PVA0RDA,
 		.sid = TEGRA194_SID_PVA0,
 		.regs = {
 			.override = 0x630,
@@ -1180,6 +1338,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pva0rdb",
+		.id = TEGRA194_MEMORY_CLIENT_PVA0RDB,
 		.sid = TEGRA194_SID_PVA0,
 		.regs = {
 			.override = 0x638,
@@ -1187,6 +1346,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pva0rdc",
+		.id = TEGRA194_MEMORY_CLIENT_PVA0RDC,
 		.sid = TEGRA194_SID_PVA0,
 		.regs = {
 			.override = 0x640,
@@ -1194,6 +1354,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pva0wra",
+		.id = TEGRA194_MEMORY_CLIENT_PVA0WRA,
 		.sid = TEGRA194_SID_PVA0,
 		.regs = {
 			.override = 0x648,
@@ -1201,6 +1362,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pva0wrb",
+		.id = TEGRA194_MEMORY_CLIENT_PVA0WRB,
 		.sid = TEGRA194_SID_PVA0,
 		.regs = {
 			.override = 0x650,
@@ -1208,6 +1370,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pva0wrc",
+		.id = TEGRA194_MEMORY_CLIENT_PVA0WRC,
 		.sid = TEGRA194_SID_PVA0,
 		.regs = {
 			.override = 0x658,
@@ -1215,6 +1378,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pva1rda",
+		.id = TEGRA194_MEMORY_CLIENT_PVA1RDA,
 		.sid = TEGRA194_SID_PVA1,
 		.regs = {
 			.override = 0x660,
@@ -1222,6 +1386,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pva1rdb",
+		.id = TEGRA194_MEMORY_CLIENT_PVA1RDB,
 		.sid = TEGRA194_SID_PVA1,
 		.regs = {
 			.override = 0x668,
@@ -1229,6 +1394,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pva1rdc",
+		.id = TEGRA194_MEMORY_CLIENT_PVA1RDC,
 		.sid = TEGRA194_SID_PVA1,
 		.regs = {
 			.override = 0x670,
@@ -1236,6 +1402,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pva1wra",
+		.id = TEGRA194_MEMORY_CLIENT_PVA1WRA,
 		.sid = TEGRA194_SID_PVA1,
 		.regs = {
 			.override = 0x678,
@@ -1243,6 +1410,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pva1wrb",
+		.id = TEGRA194_MEMORY_CLIENT_PVA1WRB,
 		.sid = TEGRA194_SID_PVA1,
 		.regs = {
 			.override = 0x680,
@@ -1250,6 +1418,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pva1wrc",
+		.id = TEGRA194_MEMORY_CLIENT_PVA1WRC,
 		.sid = TEGRA194_SID_PVA1,
 		.regs = {
 			.override = 0x688,
@@ -1257,6 +1426,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "rcer",
+		.id = TEGRA194_MEMORY_CLIENT_RCER,
 		.sid = TEGRA194_SID_RCE,
 		.regs = {
 			.override = 0x690,
@@ -1264,6 +1434,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "rcew",
+		.id = TEGRA194_MEMORY_CLIENT_RCEW,
 		.sid = TEGRA194_SID_RCE,
 		.regs = {
 			.override = 0x698,
@@ -1271,6 +1442,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "rcedmar",
+		.id = TEGRA194_MEMORY_CLIENT_RCEDMAR,
 		.sid = TEGRA194_SID_RCE,
 		.regs = {
 			.override = 0x6a0,
@@ -1278,6 +1450,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "rcedmaw",
+		.id = TEGRA194_MEMORY_CLIENT_RCEDMAW,
 		.sid = TEGRA194_SID_RCE,
 		.regs = {
 			.override = 0x6a8,
@@ -1285,6 +1458,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "nvenc1srd",
+		.id = TEGRA194_MEMORY_CLIENT_NVENC1SRD,
 		.sid = TEGRA194_SID_NVENC1,
 		.regs = {
 			.override = 0x6b0,
@@ -1292,6 +1466,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "nvenc1swr",
+		.id = TEGRA194_MEMORY_CLIENT_NVENC1SWR,
 		.sid = TEGRA194_SID_NVENC1,
 		.regs = {
 			.override = 0x6b8,
@@ -1299,6 +1474,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pcie0r",
+		.id = TEGRA194_MEMORY_CLIENT_PCIE0R,
 		.sid = TEGRA194_SID_PCIE0,
 		.regs = {
 			.override = 0x6c0,
@@ -1306,6 +1482,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pcie0w",
+		.id = TEGRA194_MEMORY_CLIENT_PCIE0W,
 		.sid = TEGRA194_SID_PCIE0,
 		.regs = {
 			.override = 0x6c8,
@@ -1313,6 +1490,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pcie1r",
+		.id = TEGRA194_MEMORY_CLIENT_PCIE1R,
 		.sid = TEGRA194_SID_PCIE1,
 		.regs = {
 			.override = 0x6d0,
@@ -1320,6 +1498,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pcie1w",
+		.id = TEGRA194_MEMORY_CLIENT_PCIE1W,
 		.sid = TEGRA194_SID_PCIE1,
 		.regs = {
 			.override = 0x6d8,
@@ -1327,6 +1506,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pcie2ar",
+		.id = TEGRA194_MEMORY_CLIENT_PCIE2AR,
 		.sid = TEGRA194_SID_PCIE2,
 		.regs = {
 			.override = 0x6e0,
@@ -1334,6 +1514,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pcie2aw",
+		.id = TEGRA194_MEMORY_CLIENT_PCIE2AW,
 		.sid = TEGRA194_SID_PCIE2,
 		.regs = {
 			.override = 0x6e8,
@@ -1341,6 +1522,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pcie3r",
+		.id = TEGRA194_MEMORY_CLIENT_PCIE3R,
 		.sid = TEGRA194_SID_PCIE3,
 		.regs = {
 			.override = 0x6f0,
@@ -1348,6 +1530,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pcie3w",
+		.id = TEGRA194_MEMORY_CLIENT_PCIE3W,
 		.sid = TEGRA194_SID_PCIE3,
 		.regs = {
 			.override = 0x6f8,
@@ -1355,6 +1538,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pcie4r",
+		.id = TEGRA194_MEMORY_CLIENT_PCIE4R,
 		.sid = TEGRA194_SID_PCIE4,
 		.regs = {
 			.override = 0x700,
@@ -1362,6 +1546,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pcie4w",
+		.id = TEGRA194_MEMORY_CLIENT_PCIE4W,
 		.sid = TEGRA194_SID_PCIE4,
 		.regs = {
 			.override = 0x708,
@@ -1369,6 +1554,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pcie5r",
+		.id = TEGRA194_MEMORY_CLIENT_PCIE5R,
 		.sid = TEGRA194_SID_PCIE5,
 		.regs = {
 			.override = 0x710,
@@ -1376,6 +1562,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pcie5w",
+		.id = TEGRA194_MEMORY_CLIENT_PCIE5W,
 		.sid = TEGRA194_SID_PCIE5,
 		.regs = {
 			.override = 0x718,
@@ -1383,6 +1570,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "ispfalw",
+		.id = TEGRA194_MEMORY_CLIENT_ISPFALW,
 		.sid = TEGRA194_SID_ISP_FALCON,
 		.regs = {
 			.override = 0x720,
@@ -1390,6 +1578,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "dla0rda1",
+		.id = TEGRA194_MEMORY_CLIENT_DLA0RDA1,
 		.sid = TEGRA194_SID_NVDLA0,
 		.regs = {
 			.override = 0x748,
@@ -1397,6 +1586,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "dla1rda1",
+		.id = TEGRA194_MEMORY_CLIENT_DLA1RDA1,
 		.sid = TEGRA194_SID_NVDLA1,
 		.regs = {
 			.override = 0x750,
@@ -1404,6 +1594,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pva0rda1",
+		.id = TEGRA194_MEMORY_CLIENT_PVA0RDA1,
 		.sid = TEGRA194_SID_PVA0,
 		.regs = {
 			.override = 0x758,
@@ -1411,6 +1602,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pva0rdb1",
+		.id = TEGRA194_MEMORY_CLIENT_PVA0RDB1,
 		.sid = TEGRA194_SID_PVA0,
 		.regs = {
 			.override = 0x760,
@@ -1418,6 +1610,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pva1rda1",
+		.id = TEGRA194_MEMORY_CLIENT_PVA1RDA1,
 		.sid = TEGRA194_SID_PVA1,
 		.regs = {
 			.override = 0x768,
@@ -1425,6 +1618,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pva1rdb1",
+		.id = TEGRA194_MEMORY_CLIENT_PVA1RDB1,
 		.sid = TEGRA194_SID_PVA1,
 		.regs = {
 			.override = 0x770,
@@ -1432,6 +1626,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pcie5r1",
+		.id = TEGRA194_MEMORY_CLIENT_PCIE5R1,
 		.sid = TEGRA194_SID_PCIE5,
 		.regs = {
 			.override = 0x778,
@@ -1439,6 +1634,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "nvencsrd1",
+		.id = TEGRA194_MEMORY_CLIENT_NVENCSRD1,
 		.sid = TEGRA194_SID_NVENC,
 		.regs = {
 			.override = 0x780,
@@ -1446,6 +1642,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "nvenc1srd1",
+		.id = TEGRA194_MEMORY_CLIENT_NVENC1SRD1,
 		.sid = TEGRA194_SID_NVENC1,
 		.regs = {
 			.override = 0x788,
@@ -1453,6 +1650,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "ispra1",
+		.id = TEGRA194_MEMORY_CLIENT_ISPRA1,
 		.sid = TEGRA194_SID_ISP,
 		.regs = {
 			.override = 0x790,
@@ -1460,6 +1658,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "pcie0r1",
+		.id = TEGRA194_MEMORY_CLIENT_PCIE0R1,
 		.sid = TEGRA194_SID_PCIE0,
 		.regs = {
 			.override = 0x798,
@@ -1467,6 +1666,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "nvdec1srd",
+		.id = TEGRA194_MEMORY_CLIENT_NVDEC1SRD,
 		.sid = TEGRA194_SID_NVDEC1,
 		.regs = {
 			.override = 0x7c8,
@@ -1474,6 +1674,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "nvdec1srd1",
+		.id = TEGRA194_MEMORY_CLIENT_NVDEC1SRD1,
 		.sid = TEGRA194_SID_NVDEC1,
 		.regs = {
 			.override = 0x7d0,
@@ -1481,6 +1682,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "nvdec1swr",
+		.id = TEGRA194_MEMORY_CLIENT_NVDEC1SWR,
 		.sid = TEGRA194_SID_NVDEC1,
 		.regs = {
 			.override = 0x7d8,
@@ -1488,6 +1690,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "miu5r",
+		.id = TEGRA194_MEMORY_CLIENT_MIU5R,
 		.sid = TEGRA194_SID_MIU,
 		.regs = {
 			.override = 0x7e0,
@@ -1495,6 +1698,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "miu5w",
+		.id = TEGRA194_MEMORY_CLIENT_MIU5W,
 		.sid = TEGRA194_SID_MIU,
 		.regs = {
 			.override = 0x7e8,
@@ -1502,6 +1706,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "miu6r",
+		.id = TEGRA194_MEMORY_CLIENT_MIU6R,
 		.sid = TEGRA194_SID_MIU,
 		.regs = {
 			.override = 0x7f0,
@@ -1509,6 +1714,7 @@ static const struct tegra186_mc_client tegra194_mc_clients[] = {
 		},
 	}, {
 		.name = "miu6w",
+		.id = TEGRA194_MEMORY_CLIENT_MIU6W,
 		.sid = TEGRA194_SID_MIU,
 		.regs = {
 			.override = 0x7f8,
-- 
2.30.2


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu


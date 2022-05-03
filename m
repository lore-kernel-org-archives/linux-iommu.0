Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6541DC4332F
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 16:32:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 30DFD40528;
	Tue,  3 May 2022 16:32:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZiHjdSB5bd5t; Tue,  3 May 2022 16:32:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EFAD7401F8;
	Tue,  3 May 2022 16:32:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D999BC0032;
	Tue,  3 May 2022 16:32:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CADAC002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:32:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 28AD7410CF
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:32:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zdwLCOiI25JE for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 16:32:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E86D40998
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:32:48 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id e189so18697201oia.8
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YWPXEW/dmcl26oN/UpNHlQ6MJJApmB07VctAbNzo6Hc=;
 b=c75RKIVqFVCnqiqXF8fdSc13vcKVKS4WcFrMRTVpAl4t7sqYgrI0cLQPHLCKqsWAWT
 B53i3FWTLfo75R/hRbhrnls/ez2F7u26lCPCuypk66bsA6lwDmpLYZtU2gF6uVuvhDDK
 BtjSBj9LoYSL8GEKxZIwGaaHREE7amPiNmU4Iq3yxnwChbPUaX8QLstT0sKmEqvnUiGh
 rIs0F4ix3NxwTl8IOyLxildF6kFtUOEN+9UZyNODi9rXiIlDbbr2hqaf4jR+VX2R7UgF
 X9zJ/JieKgAaABbIdOeEOUT2ERmPCaTuUiyTUXJqq/0TMoTNFLTiXvLKTJ3fXBOO/RJV
 ydJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YWPXEW/dmcl26oN/UpNHlQ6MJJApmB07VctAbNzo6Hc=;
 b=2ituqVCXTiqhSZNJJC2ppOXHvNNzRmpsplDmSX+NldjlGblRmdRXgQGsrzOJ8TNAGU
 +qRBnvKI8SdVMBXS3AanAFyk17UwiEhWcefxT7ub7iOjh5uiGtovEDUJJ18BkDXnGxkB
 +edInF1O0aP4oGjwMNG0jF2XHBiNO16YnKr1JLCShlckpV+yXIgE8t6+XL0BIw3Y7u7m
 n9GboURJogHEmAMNCytCH0kxaqwwKsl3kNurfnUgtxYYFHAlHmquKi2s11vF2wD3j0zN
 pUFx4ePOhXoxyklnP4Y44ItMfXn0Jd74nf5rCZFGlbJFw80O4dHLYznDOykKfgHpaxxq
 utCQ==
X-Gm-Message-State: AOAM5321tTEX8NgnL8d0y5wB72mWtIqiG2p46OY49Qipxc0NAVwLNedD
 00YgWRHf38XgaENrD9/tv3S+8w==
X-Google-Smtp-Source: ABdhPJzv0hOtfibu1ipLXlFKcbx6oRoYa04jZ8s7iMf8RTneuOK8/aKQziy6q1TrDRGBaYIfDuQS6A==
X-Received: by 2002:a05:6808:1526:b0:323:1194:d3bf with SMTP id
 u38-20020a056808152600b003231194d3bfmr2139113oiw.120.1651595567404; 
 Tue, 03 May 2022 09:32:47 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186]) by smtp.gmail.com with ESMTPSA id
 v15-20020a4ae6cf000000b0035eb4e5a6cdsm5027404oot.35.2022.05.03.09.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 May 2022 09:32:46 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 2/2] iommu/arm-smmu-qcom: Add SC8280XP support
Date: Tue,  3 May 2022 09:34:29 -0700
Message-Id: <20220503163429.960998-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503163429.960998-1-bjorn.andersson@linaro.org>
References: <20220503163429.960998-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

Add the Qualcomm SC8280XP platform to the list of compatible for which
the Qualcomm-impl of the ARM SMMU should apply.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index ba6298c7140e..7820711c4560 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -408,6 +408,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sc7180-smmu-500" },
 	{ .compatible = "qcom,sc7280-smmu-500" },
 	{ .compatible = "qcom,sc8180x-smmu-500" },
+	{ .compatible = "qcom,sc8280xp-smmu-500" },
 	{ .compatible = "qcom,sdm630-smmu-v2" },
 	{ .compatible = "qcom,sdm845-smmu-500" },
 	{ .compatible = "qcom,sm6125-smmu-500" },
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E0EC43334
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 04:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A571831DA;
	Wed, 15 Jun 2022 04:20:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nM5MDVLC2gRM; Wed, 15 Jun 2022 04:20:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 55F59817F5;
	Wed, 15 Jun 2022 04:20:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A97BC0039;
	Wed, 15 Jun 2022 04:20:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 249E4C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 23:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F165760D60
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 23:01:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=anholt-net.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M1051iIkLtVd for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 23:01:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3435D60B52
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 23:01:38 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id cx11so9719663pjb.1
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anholt-net.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RWlMcK/WiHaE2lupDQgc+icrhgmdMQxgOsPbDDDl0aE=;
 b=rxZaCTVb83tYMLMGAxqk8WP2FjGYRIoCovnvFYKSSOhMElgtlaDdZdSZMKPgSK4Yvo
 rC52cpeIJXo1GGTArDPxTrvH2g0j3p7QIUY5w78AbPKw2KsYXheKA8zc25on4qL9jc7k
 Pux+AQFyh9bQxZS2Av8mD7rxozr+inA00Hb7dAzDh+Di3oqIzFrchKq0vkDUvlbHaxek
 DRfGsep2dsYUDMjpJWrl4htAQKqUQVJIsWTNYxGeAn5KVIyPZqHF/KFc4lT4YMeLJIf5
 ry7iVS607W8w4IYMtJIee9psu43QKUIBJbDZIHwrUeV5l21LlnXFp0dg9U3JNTJh/a2F
 me6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RWlMcK/WiHaE2lupDQgc+icrhgmdMQxgOsPbDDDl0aE=;
 b=0xejTju1JBJp1p2n2lGextRvLsVupq/7jMhGKX5jofd0U9GmuAwmqH9poRhE2VrZAi
 2uuYsxrJhQOPHfGhCiKpYU1xccaKVdT5TA0pEEGGsHBqOCnNzwTmIXGy5qak7nVtjQCS
 Pp8AW0UMpl7LbXpCrUKHENRQUE1eWHy6qXnai+x+vkL0/dPS14C+NkQ+xgEM+ETqBEhz
 sqq+2KGDYs71KDpUjBroeFHkE7sjreN57FY7TsLpKkfgDkQsjlPyzC8f/vBgZL+ykdju
 eocymm8DQxEy1RcC11NtOs/HSp8oig2rPvytw/m/09RPKPoqvOFjBbw7LWtIKT+KvmLR
 v/lQ==
X-Gm-Message-State: AJIora8yo3DhCF/yjs8DMHadAZboYFYriiQKHCc8zaYB4khUHy+Cnxc6
 R6qcy1vphclk9aQAeiVQjAdx5Q==
X-Google-Smtp-Source: AGRyM1sug/F5zUgorGwld6/cvjxSjJ3Ba76jZNwLVen3RaltHSazhsqEJzh8eunYtM28ILlpP5FJ5Q==
X-Received: by 2002:a17:90a:a605:b0:1ea:6b4f:915e with SMTP id
 c5-20020a17090aa60500b001ea6b4f915emr6825913pjq.60.1655247697545; 
 Tue, 14 Jun 2022 16:01:37 -0700 (PDT)
Received: from wildbow.anholt.net (97-115-79-125.ptld.qwest.net.
 [97.115.79.125]) by smtp.gmail.com with ESMTPSA id
 cp15-20020a170902e78f00b00168c5230332sm7787768plb.148.2022.06.14.16.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jun 2022 16:01:37 -0700 (PDT)
From: Emma Anholt <emma@anholt.net>
To: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
 Jordan Crouse <jcrouse@codeaurora.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/2] iommu: arm-smmu-impl: Add 8250 display compatible to the
 client list.
Date: Tue, 14 Jun 2022 16:01:35 -0700
Message-Id: <20220614230136.3726047-1-emma@anholt.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 15 Jun 2022 04:20:45 +0000
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Emma Anholt <emma@anholt.net>
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

Required for turning on per-process page tables for the GPU.

Signed-off-by: Emma Anholt <emma@anholt.net>
---

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d8e1ef83c01b..bb9220937068 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -233,6 +233,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc7280-mdss" },
 	{ .compatible = "qcom,sc7280-mss-pil" },
 	{ .compatible = "qcom,sc8180x-mdss" },
+	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
 	{ }
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

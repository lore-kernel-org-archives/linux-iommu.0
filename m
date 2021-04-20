Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EFEC433B4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:26:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9D4613C2
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9D4613C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57C2A405C7;
	Tue, 20 Apr 2021 17:26:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NYicLRiiGiLc; Tue, 20 Apr 2021 17:26:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18099405D4;
	Tue, 20 Apr 2021 17:26:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E85EEC001E;
	Tue, 20 Apr 2021 17:25:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E03E6C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C12C8405B0
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CR3FQmWQPJCe for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 17:25:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE63E405D3
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:54 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id bx20so44919811edb.12
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oomLXdSqJJ9PIjxb6gjx8hnfwiARzBKAKbIJ+w2GrTw=;
 b=eE/13PLF3h3U0qvRTkYa6TeUrMFceFJuSDCUczRmCo2Inj1LBOjpIIB0rEy1W5bEJg
 iaFkgKCLCU5weuxcQXXmQWSLuOppEp4HTDHurXoCN3EJu0C0FKby+NxHs2UPNNlxNvhu
 sevbaWpTsCYpHjt6RonySoTnbugRJ7XIjZOneWBSgOFw1yqER9kLRq4bx66YZfdGfCYL
 rm3MS9bd60+fqsurfKzWzPYKPPcnAV3f0AefpJCwNWtqU/CYCnVJmQl3YFewcqnGX0Sw
 PufgcsGBdXj5Ji/JNEdi4GD8S8BEkQOU6lPrlnege8Xh5Ei8y7wLjPmOSOAJvBuF8EmA
 dP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oomLXdSqJJ9PIjxb6gjx8hnfwiARzBKAKbIJ+w2GrTw=;
 b=mBZrF8qBas3oFFwfXQQ80rLPSLQJJe+fy0qCvkmagKX9Z84Y9VtzJuljB1b+gzWnQn
 n8wxCTMiq6LuHDkIPcBK5QMDyqcLPW4leHy1Uskoj1jKjI27wjUKViIAGm8eB8mhrm+Q
 y0SDgrA2t75yxjuCqa3ulNhXaGkZcLs/PxlX/Nx//KM6VhIZjHuotukvyQ9ZU44HAndU
 SMajBesVkJDSATPK/XA4n3NcJb5NAbW9UsT6LVSBJXNxT3bkhEfudOIjt5w3IhJy0Cnr
 RiKS/bV3lnie5lN2sXPl6Ii+uFt7ieOFlcP5BKiFgV9KoM2IaWKKDy1oEGgFQZn1QexN
 1lSg==
X-Gm-Message-State: AOAM533DMlujA74FNcMgxhrbFeT18HfG9N6WWchb+9LGTstQ9HKmXDhg
 b2n1eOmzGdrDA/6Ezz2DDGA=
X-Google-Smtp-Source: ABdhPJwfnXfCe8dBuEZlDPZLuHdnyjrWPd3VkOaXY4jZy4JvAnfGqF/RpKdpuvSmL+X2RLK3gzixrA==
X-Received: by 2002:aa7:c5c2:: with SMTP id h2mr19812329eds.38.1618939552800; 
 Tue, 20 Apr 2021 10:25:52 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id o17sm12106708edt.92.2021.04.20.10.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Apr 2021 10:25:51 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 08/10] arm64: tegra: Hook up memory controller to SMMU on
 Tegra186
Date: Tue, 20 Apr 2021 19:26:17 +0200
Message-Id: <20210420172619.3782831-9-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420172619.3782831-1-thierry.reding@gmail.com>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
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

On Tegra186 and later, the memory controller needs to be programmed in
coordination with any of the ARM SMMU instances to configure the stream
ID used for each memory client.

To support this, add a phandle reference to the memory controller to the
SMMU device tree node.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index a173f40256ae..d02f6bf3e2ca 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1152,6 +1152,8 @@ smmu: iommu@12000000 {
 		stream-match-mask = <0x7f80>;
 		#global-interrupts = <1>;
 		#iommu-cells = <1>;
+
+		nvidia,memory-controller = <&mc>;
 	};
 
 	host1x@13e00000 {
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

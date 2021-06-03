Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A40AC47099
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 16:45:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2AE1613F1
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 16:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AE1613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBBA260B71;
	Thu,  3 Jun 2021 16:45:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gVNx-ncXYQ45; Thu,  3 Jun 2021 16:45:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E733260B63;
	Thu,  3 Jun 2021 16:45:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A215AC000D;
	Thu,  3 Jun 2021 16:45:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42528C000D
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 236C160B6F
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gb3ZPWIS4gwD for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 16:45:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6930F60B48
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:18 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id gb17so10201125ejc.8
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3H7kBWayn0qcK+eEtFN4Gu4RL12HhriWydsuWv48WfA=;
 b=o4IqvhKmUTIACSLrHJkEOSt7oTgtqvG/5HrLn07ZKa/OaEDSkMZG1avPxUQIqkmSR2
 bMekXpKSxwLV5vBgVHXMMKfqKts0nYqKYr6++YN2Uu3RZhoGLAszF1n8GPSEp0+xw/rR
 YrUh7rAsahyaI4EXC0sg+2A41hl6TO48aoKc9kF8BmKyNe2N2fxXeg/DQ3Ropb+hs57x
 vhxlhNZGTtGWACKXALSHj6RaxA+EVVXU/V8Pgd1cGfdxegdLKhOE52tu8sgK5+ugRWvu
 JB9rmXdWgOLD5XhTYEviQ6wycyLOK+4NSMZzAddhIBGFI6j97mOg06v9cEgWvmLC2CRl
 JmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3H7kBWayn0qcK+eEtFN4Gu4RL12HhriWydsuWv48WfA=;
 b=YoSY0GTSFdL+gKHKY7OxpKpd3Ymv7wLRM51oR9Qn+UOgrq/OtlnljDFlmtMQ0Gjtu8
 efpF2ZtFYgZZ3brIDnLMYI2D1VWb8zaMTqiQTgw1XZBDrFfAT5+5QZ6CmRsHcbs5pUsC
 pbaGnsaH+EiXUxJNR+fokncMhsh0AC/p1qlHKCWSw1MTMULcMR04tdvXT7Kdle6sO+YS
 AwFRRHn0SmdH7k15Ylew7+uRI9TMWUjK9nSKidCOrRT60s1ABH8AasHzPI0HEWmfGftI
 6KXyIRMlGKBjx6c893i1jIqPCaMxUtQxSyUwfoeca8wsb7jBB+S68yVvVUYP7ewXIVgW
 lqKQ==
X-Gm-Message-State: AOAM530IxIhUImud4kKZ+boBzm8Lp7Q8pWU58Fu9LV3emwlSoxxOpgiL
 Tt7evxlYOzjtIj1L3GMyEPU=
X-Google-Smtp-Source: ABdhPJxJfBtQcyTw2ggGblUJb62+CJQ05s0vQk3KGuzRkVGKlycyNp8C3hL1VzrU2RP4pgDypiWnYA==
X-Received: by 2002:a17:906:27d3:: with SMTP id
 k19mr274262ejc.368.1622738716690; 
 Thu, 03 Jun 2021 09:45:16 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id bh3sm1741560ejb.19.2021.06.03.09.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 09:45:15 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v3 8/9] arm64: tegra: Hook up memory controller to SMMU on
 Tegra186
Date: Thu,  3 Jun 2021 18:46:31 +0200
Message-Id: <20210603164632.1000458-9-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603164632.1000458-1-thierry.reding@gmail.com>
References: <20210603164632.1000458-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

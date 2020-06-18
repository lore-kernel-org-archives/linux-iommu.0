Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFA3C433E2
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:52:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E7F02070A
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CXa/IxLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7F02070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7E4B688A01;
	Thu, 18 Jun 2020 15:52:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i7Mr-MlBd5Gy; Thu, 18 Jun 2020 15:52:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 785E988A11;
	Thu, 18 Jun 2020 15:52:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 641FFC0892;
	Thu, 18 Jun 2020 15:52:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7153BC088C
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:52:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 661A824E91
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:52:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BAZX8KUbjuSJ for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:52:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 1AB9822735
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:52:47 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id mb16so6959501ejb.4
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OszwHFuvAODAZ4JcDGk8vTdgEsm3AXU3gmIMXDwpr1E=;
 b=CXa/IxLq2sAhhWXEwadxVdBTNRXCjnNRJ86QHDU2Mv2XE4055xNa1KydScB6wK21ZB
 cXy76zowZ7DH6oYph6Pl7OuFVuh4YQj0mvtW0MxteQ4UcjzMXY+xljI/4UnbdNVn8beh
 plIgdS+Z0wk8kS8Nt5E8eD6lwtdFgeDqCh4xStJzlWi7O9hNV7KqxuDuPglptEYvakjg
 4gRgbFs6be6neKEhVJpZF7i5q6uxLLCAUoZE3762HcKHIu0WyhDcJaTICqaeIgkR/5so
 ELvNZAlx+cNLKnbAJ14SIMrBO5wUtNh1LjFnDsET/fpJA6CuAxpepH0+ZH331HeSTxGC
 PuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OszwHFuvAODAZ4JcDGk8vTdgEsm3AXU3gmIMXDwpr1E=;
 b=DHZzRhd8BWYD4tXrT/yBDhqR77sc89+ohuYC5aM499wHV8ziUDwPuQ+Pj/brWLQ7bU
 +KffADgIUsHP+rugakI0o6Bp0d0gWzg2y/XAdP8nMkVuX8/awnmvn5m90TgLITtHRdTN
 +Uh62HkdqPViy7JhVsDNNainQp1jYp2QCDkVLQZX45rS+hXKFgoTY611H5H9zKLIhScO
 jPgWV3GWdbvK2FHfqlGvKtVdd7IWKoqoHlBP2ZuA4ou5eQ45LKPWeF0xmTwIESeWcPeM
 QaAdj7YaGkGDLxwov0t4Qq+/4eBgQ/j7JkKSeGQva3XiAq5oSxB7y5wRq9Qn8dNP2yRk
 u0Ig==
X-Gm-Message-State: AOAM532zPOiLLEs113TvlIMOY/wKgbrawdgFxIv397t6nkKfEpWA+aIm
 Jlk5n8JC7CVPu27utiI32JfwD0f4h4NKPg==
X-Google-Smtp-Source: ABdhPJyc8Mnmi4a1Aktae1QZY9O3zjJrhf37UfpwnWXbqDPMbp6c+LvxNDW5UP6lbOX5cvWPvekjsQ==
X-Received: by 2002:a17:906:9257:: with SMTP id
 c23mr4487938ejx.86.1592495565343; 
 Thu, 18 Jun 2020 08:52:45 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id 63sm2402267edy.8.2020.06.18.08.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 08:52:44 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v8 06/12] arm64: cpufeature: Export symbol
 read_sanitised_ftr_reg()
Date: Thu, 18 Jun 2020 17:51:19 +0200
Message-Id: <20200618155125.1548969-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618155125.1548969-1-jean-philippe@linaro.org>
References: <20200618155125.1548969-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
 robin.murphy@arm.com, hch@infradead.org, zhengxiang9@huawei.com,
 zhangfei.gao@linaro.org, will@kernel.org
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

The SMMUv3 driver would like to read the MMFR0 PARANGE field in order to
share CPU page tables with devices. Allow the driver to be built as
module by exporting the read_sanitized_ftr_reg() cpufeature symbol.

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 4ae41670c2e6b..ba1e17ad17447 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1068,6 +1068,7 @@ u64 read_sanitised_ftr_reg(u32 id)
 		return 0;
 	return regp->sys_val;
 }
+EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
 
 #define read_sysreg_case(r)	\
 	case r:		return read_sysreg_s(r)
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

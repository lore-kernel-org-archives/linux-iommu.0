Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0BAC43463
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 10:20:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353A5208C3
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 10:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HK6W3eRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353A5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DB94D876B4;
	Fri, 18 Sep 2020 10:20:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fNIcU3JRZ-sB; Fri, 18 Sep 2020 10:20:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 59C2B87672;
	Fri, 18 Sep 2020 10:20:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54504C0888;
	Fri, 18 Sep 2020 10:20:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BFDEC0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 087F887691
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:20:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id weGAQaxPe4Up for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 10:20:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5092287672
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:20:03 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id j2so5524466eds.9
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 03:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zi2qM10ir5XJwLPnhpYJ3YOcstRDmhGueiLzKISpezQ=;
 b=HK6W3eRZ8r4bPJme3K64Zxv5CKzy7svH/SpUMlfMyzgVA7tcvSPR07SfE2GFMhOiRo
 f7KFf8RebEfq1UA4YfK9PoQowQgH/tAk3HbZxYcXMQNo5Y+mHTuoJZrx0YErg3WiTD+m
 0oP2+T40QGMM4h7/jKC72WBZbXu1c5huzRYn7+HxI0B1dQ2G9nlsOZfmzx6KDnLxs4S2
 re/6qYwOKcR+OekNFSvywlCaUCFFroHeuvPYjebtSKwc/EjhoLzd/o843VLtN0sJ/vU+
 gA93yimHxG22C3G7Z0J+R8gcVyaIGWp8wSwwlo/LWluSHxw6B4VKpS8y0AdeisjXPT4Z
 y0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zi2qM10ir5XJwLPnhpYJ3YOcstRDmhGueiLzKISpezQ=;
 b=CPT9rUuyCWoG8snV5eGhIYbpD0/zYDmoCNOUucfnQTNT5zWBpVYm0bRcglWiNEzNRm
 fwwpYlB7TJTOM/kiz0SWGcv4Qpe514oT1oX3kLgyB5oPyLlBO+JBRrerAcu7+aSafA3L
 JsT/R+qIPwM6rRiO5Ma4X1+FGxl5uNMbKf7xPfEObov/xWm+NbvQOqWCrt/eVPMevqHx
 g5MZpXC3pKfmo57uPSF53L6bq01I/8AGgni6WSTmNs3MzLjFk5nARcZGLdcl6ZnpREiH
 3yZceyxN3gTEboUFj0V//gaL35zSgvA+S7d61JXcsPzgB5dA1g7DA76E/3ChElDRo1rQ
 IPJA==
X-Gm-Message-State: AOAM530aGotlGPePTUTsyr2tyMlOqIyfleMFHiKmV3/kgiDAeCXQYuhN
 BZ+ULA6oiFUgOXft+KepdtDll+MAC2t0jIJg
X-Google-Smtp-Source: ABdhPJxzV876qoFBLFGCOytfeZusWmrwZCMbEnIjvbs4kvbdc0vDdxojTIyKclpxEmPtQgE5t4eVyA==
X-Received: by 2002:a05:6402:17b5:: with SMTP id
 j21mr36719671edy.276.1600424401524; 
 Fri, 18 Sep 2020 03:20:01 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id r16sm1940674edc.57.2020.09.18.03.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 03:20:00 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v10 06/13] arm64: cpufeature: Export symbol
 read_sanitised_ftr_reg()
Date: Fri, 18 Sep 2020 12:18:46 +0200
Message-Id: <20200918101852.582559-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918101852.582559-1-jean-philippe@linaro.org>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
 robin.murphy@arm.com, zhangfei.gao@linaro.org, will@kernel.org
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
index 6424584be01e..07f10ad8855c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1111,6 +1111,7 @@ u64 read_sanitised_ftr_reg(u32 id)
 		return 0;
 	return regp->sys_val;
 }
+EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
 
 #define read_sysreg_case(r)	\
 	case r:		return read_sysreg_s(r)
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

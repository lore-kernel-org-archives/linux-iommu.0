Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CB5C54FDF
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839E42074D
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0Yp2WFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839E42074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 77BBC85DDC;
	Tue, 14 Apr 2020 17:04:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q5g4ZHebfoTm; Tue, 14 Apr 2020 17:04:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6C4F885DC1;
	Tue, 14 Apr 2020 17:04:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67CEFC089E;
	Tue, 14 Apr 2020 17:04:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEC95C0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CE81F87E63
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6GGpdcZlx7t1 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 17:04:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CB3E187E41
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:34 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id x25so13830295wmc.0
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aOn2/ivBf+XmB6Al4WmdsHcps0QyIiLuo8qefeV2C0s=;
 b=Z0Yp2WFwHT70u0R7Wr7R5AhtdbVQPNTMNufdFuXd+ENpRenI7zcZxRtj1eDH/8DVxK
 w7N9nOpW7sEG9K/u3l1KC6rScagAtd4Om9U5KNXAa5xEBG0aKQFAomBQj49jMwAx80bm
 VnyWFWc4Yzp3RbBcbzqkmhqjzSXUGlBrfV9Kgixw0dzjGUnOx/ApPNVuQ8gPPBhxSY5/
 4wGrHj0nf+rS03Agdvzb84edls0jQzbEhQ/0sOzl94i50gjL44IGJs4I98eE/dCmXuXl
 D4QQcRCEFAxwwKcohtYfh0JlVaKZdefOyxLVJTOa7V2u0lkZCvT24PKYz706K9mF45p0
 UpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aOn2/ivBf+XmB6Al4WmdsHcps0QyIiLuo8qefeV2C0s=;
 b=AYaJaw8xzlWXFHJ43+f6dhIVKOy/aXxqTBoekCjCCkhNLoOAf2vlF8SJUvPox9G2p4
 KTZUyGVtOBYuyeQqKJCwKTnYqVzID5toCgz1Tx3vIBaP1mYMWXpLN7zC8DF8Eh/XhmGq
 nAldLJfQGLYqnfjMmy2gsz3foqC/XtYUjbDhZpdpHoebElyCq3Vi19OEPHmdOdtGhL4N
 SXMna0hsqJaDfw2+7fjbmwiGch/5gMKKTwOWQhDwC66pWoneREtosHHcr+6KECwnYB4b
 FrlPIOhDmLcZ2f7piHsshiu0mfgFg+zCBPKAdtZdxFSgB6XsbnVK1ebOKo7IV4u0jh7Z
 8r3w==
X-Gm-Message-State: AGi0PuboaMee3m85vTymbsL8I2TLS+watQ4RPzUHY5r4J34CoaLHX0nI
 8bwMEAyJQmnX07UYA1yI+BE2vwnzv1VBfA==
X-Google-Smtp-Source: APiQypJHABOUo0l69p8cEPC/4JaEesvnVVdt7c8KNCFhOJxICd+3rtd3OwSved0AadUjHTnKij1dPw==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr776151wmc.62.1586883872984;
 Tue, 14 Apr 2020 10:04:32 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 10:04:32 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v5 11/25] arm64: cpufeature: Export symbol
 read_sanitised_ftr_reg()
Date: Tue, 14 Apr 2020 19:02:39 +0200
Message-Id: <20200414170252.714402-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 Suzuki K Poulose <suzuki.poulose@arm.com>, catalin.marinas@arm.com,
 robin.murphy@arm.com, jgg@ziepe.ca, zhangfei.gao@linaro.org, will@kernel.org,
 christian.koenig@amd.com
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

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9fac745aa7bb2..5f6adbf4ae893 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -841,6 +841,7 @@ u64 read_sanitised_ftr_reg(u32 id)
 	BUG_ON(!regp);
 	return regp->sys_val;
 }
+EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
 
 #define read_sysreg_case(r)	\
 	case r:		return read_sysreg_s(r)
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

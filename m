Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4000C54E8C
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BE820757
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GdxqERSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BE820757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 85DB68879C;
	Thu, 30 Apr 2020 14:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w0MMuwU1SrgC; Thu, 30 Apr 2020 14:40:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 178358878B;
	Thu, 30 Apr 2020 14:40:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0ADC4C0864;
	Thu, 30 Apr 2020 14:40:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5BE5C016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B26E386DA3
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cwzpJrp2-a16 for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 14:40:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3510C86B18
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:32 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id d17so7202486wrg.11
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jRLktX4Fv4UiegcQ1XKfrXB/TH8/LTOUgoi8xC3haZQ=;
 b=GdxqERSg6Wq+QjSLrDklObgdKsWyrI/p2A6U4BFEZlyPUG/0SIcCQinPURmpCcRIjv
 3f5gJe4XY/u6yERJf9AwN+ZPq2bItwT/fSCgvMu08smasfLjOjOJxGrn+O0ElEcXqAXt
 3mpjlsAkdnOtr7eBUEquFjghsowytMyHCnwJbMdBG1W0oE7FrywpRTw78nLWSLKbfC7S
 +MhVK+j71pwZaHQOdr2Gde0ZOYTVwaFzIBka+fFjE+PTE5NEpEV43oSc/LN4IXGD6VD0
 4/CBaxt0Jike33CwfczPG3OxP+5W0s6u1z+Du0kqJEI8+0UBC180s6/Oj/dEyXpErCLG
 4rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jRLktX4Fv4UiegcQ1XKfrXB/TH8/LTOUgoi8xC3haZQ=;
 b=cOoHH5jBY586b4E5Krl0TifHcHxJ4ijoV85RFPAeT+JDa2jDVHpeyXqcVCKaNoCMs6
 Fa/oAKLzzIGvmB5/K1yAitIGNWvfc7KLUp0ShX+79AshgQdt6ZLB/xzJi7X/9sjxfeX6
 KbrqBMmvrYJWkNgAgmBNxHvSE3l7XccWgQ7+OoNmwNKE8l+5VTPxhsQ174xd9+8to0pd
 o4F+RVkEH+14umDw2GkHLzKxwwfN4FOQbAN4tJ7lNROCSY74UzgtfwKi3YIBD75eP4EX
 iw5jPw6VY5brVK//9JzqbS2t3NoRyWZrx8Cb9bOCwZDBrzKveZsjVG/GXWeDCoEYlO8H
 QSRA==
X-Gm-Message-State: AGi0PubsddnRUneoyPek2WxW0eyAyS83qdkYO/yeQdGNE5U+YqMYjxv/
 EbADc5aAuIgtWnzbwuGlV3JViVvEUi0=
X-Google-Smtp-Source: APiQypKGnRA3rC4LIOfEdPstuV2izIDoWxEDRt3yJJdFAFTW4qtuKV91hxDhmiqWADguGvwulI61dQ==
X-Received: by 2002:a5d:60ca:: with SMTP id x10mr4210723wrt.407.1588257630518; 
 Thu, 30 Apr 2020 07:40:30 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 07:40:30 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v6 10/25] arm64: cpufeature: Export symbol
 read_sanitised_ftr_reg()
Date: Thu, 30 Apr 2020 16:34:09 +0200
Message-Id: <20200430143424.2787566-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, kevin.tian@intel.com, jgg@ziepe.ca,
 catalin.marinas@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
 robin.murphy@arm.com, hch@infradead.org, zhangfei.gao@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, felix.kuehling@amd.com,
 will@kernel.org, christian.koenig@amd.com
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
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

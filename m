Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA6CC4345E
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:02:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73705207D4
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkelvqOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73705207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 506522324E;
	Tue, 19 May 2020 18:02:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hQmfJ30CMhNC; Tue, 19 May 2020 18:02:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 05DCD229D4;
	Tue, 19 May 2020 18:02:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E68A1C088F;
	Tue, 19 May 2020 18:01:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64B71C0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1B0EB86D38
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:01:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3TltTfpQGtXF for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 18:01:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0345E86D19
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:01:54 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id w7so352364wre.13
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tdr2nbJDVREjEd6opf3N1PUExNDbBuhp6Y6q/Aa2PEk=;
 b=HkelvqOK2ASLLh8prk/cDS5hZTdQU9xrr2V3ZxvDu0Sq7ohsTnzBnIMz0gnehYydrd
 QbNe0r28o6KsNU4c8jG6/OECzBTt1dgbKqKBO3Hy9R096LEbCLBtm5fJCXyPcoLUqC7z
 nJYdYMckvaByveD0Pss3OR0UJ2rAqvk1aa9NiHwQWgUQzWYyPlH/WdC5rnr0FA7nXTHT
 wUy4E18JFZwuckNo0n2C9EJ91f2GqeXNIr2Vo1ubIjolcQVPov+bsWVCo6uVm3u+gguw
 ifDXz+1XuUSPfCuU2aV4GnReJ1qkGO0jRWJcKZ8SusFCa4UK2engyDtkMxBFLorw/oqX
 3ZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tdr2nbJDVREjEd6opf3N1PUExNDbBuhp6Y6q/Aa2PEk=;
 b=kcFVQ/9YJa6t9FnyTSuduoS8k8MWTAmAwSl909DkmupPVRjmEL8cvxuzm1jdwjZCGY
 q2BlciXUJTIPAKCRGz1IszCmo9YnBDs+FrfYxALiSCfiqgo8zuOyxCBIPgG7c76PaP1L
 1OlSA1oOHSqSHRSKVMMUebRfVqy+VYbXJi/6060NulHVSXXP8Rk4eN+N4qJ71KZ9QfZP
 U/nfBF1n61w373mSG6to2uonCuQPKd0u0GGTsiblGHYxSoJu6LBGNnHbtMZL7BkeDxYS
 TfBGZWpR7E24YxMkZB7gY7nEAubk7/+VoTraKWscDaS2h4e5P83YT1v6hAurouHMC/na
 ExWg==
X-Gm-Message-State: AOAM530DvodZWfS/49Y+PnB2eAXgrA6JGE04dJM2GrfL1WLKsjY3DTzX
 e/m1kgKezy092zedbndxfcNwYWy4i2q/FQ==
X-Google-Smtp-Source: ABdhPJynWLyIUGdI5MUqsN8GOzUd3ADLnVQan+95nD7CN0va9fcQVLO9UHUTvmOnyfYBlYSmz6uVWQ==
X-Received: by 2002:adf:c508:: with SMTP id q8mr125580wrf.4.1589911312245;
 Tue, 19 May 2020 11:01:52 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:01:51 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v7 09/24] arm64: cpufeature: Export symbol
 read_sanitised_ftr_reg()
Date: Tue, 19 May 2020 19:54:47 +0200
Message-Id: <20200519175502.2504091-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
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

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9fac745aa7bb..5f6adbf4ae89 100644
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

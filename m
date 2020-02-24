Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F99C38BE2
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D950820838
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pDRHKweD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D950820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CB17A2051E;
	Mon, 24 Feb 2020 18:24:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PPXh-aLvkVV6; Mon, 24 Feb 2020 18:24:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 56C1220515;
	Mon, 24 Feb 2020 18:24:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45529C18DA;
	Mon, 24 Feb 2020 18:24:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 249BBC0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 148CE20414
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m8tlQS2HLOLX for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 18:24:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 2C8C720508
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:42 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id r11so11569292wrq.10
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 10:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fiWmOcLAVe+tVXhcsvVE1DFO1O4ryIgAcLdwqW0ca+M=;
 b=pDRHKweDnlBKRULwy0ik0zwEBtEv1j2cgrRKvimaQC6F87phqKiS6hoWHYe79Woxaq
 dvU2Y+udalR1IWc9MZSMY0Zs5f9NdIHxKJhYe9t+iiuM18v5G9IPkB7YyVsl1xvn6G0k
 Lyx8J36rm2ynK9P22EeAO7k6RYA6roW1f6WRVmaqmmlmQjHQxIyE4MBbDQS/EJmu3I3p
 Qd3S4xWYoA2d1rHcA8AWP0OW4En+tWRi+9rXYw9g503nUnZih/bJ/n2/yoE090xj2LJU
 H5r4hDx2HFNGusqI0S9/YfyB+pnbzKC6Jhc3+KlEeOqTYu+SoSFgOQm1PAsvdd7NVhoF
 WL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fiWmOcLAVe+tVXhcsvVE1DFO1O4ryIgAcLdwqW0ca+M=;
 b=cuc/6sHiy8KD8NcpsZ9KStghVTWkeY5hrq4MsnQdAMMzfdYeJ99L+qe6F4SZ2NwbmN
 Gi0Jz0Bf8MvrVrfF/lwtT6l1kNNwzsQJ6nGvtA4zIheEN9vnsEak/e0u9STTJcLPafP3
 Ouf0qRN8VTysvHbxHqMuiQGRJaLB+vUabVsrr5wwA8r71csboPcqTSICbiwebEKzw0HI
 CeZ98dtlnmAtzd+RNQX9Nzr5Wrh//S56WM0Mj80R57SzDZOV8BRXRPKMGmcAi8bQlrDV
 5pttiB2+ue5bhEA7r7c3DihWg/hb4ToII8z3wMhVbyZhR6Vjb3s3B9ttgTxPV87KK2X2
 x0Pw==
X-Gm-Message-State: APjAAAULHlEw4bPRehlCyCek8Nv870VT6b02KCdyLtbR7BUDg7UOxsPW
 T8UJGwsj3dkFsMsZTBJPL84n7PYV7Lg=
X-Google-Smtp-Source: APXvYqz8CuJxubqS6SRPcAebK5WrAwOgc3vNvNYTHpZ8VXVrF/jAhnwu+rN8D9EGJiHbmYtTOasOQA==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr65031300wru.87.1582568680476; 
 Mon, 24 Feb 2020 10:24:40 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 10:24:40 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v4 10/26] arm64: cpufeature: Export symbol
 read_sanitised_ftr_reg()
Date: Mon, 24 Feb 2020 19:23:45 +0100
Message-Id: <20200224182401.353359-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, kevin.tian@intel.com, catalin.marinas@arm.com,
 robin.murphy@arm.com, robh+dt@kernel.org, zhangfei.gao@linaro.org,
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

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0b6715625cf6..a96d2fb12e4d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -838,6 +838,7 @@ u64 read_sanitised_ftr_reg(u32 id)
 	BUG_ON(!regp);
 	return regp->sys_val;
 }
+EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
 
 #define read_sysreg_case(r)	\
 	case r:		return read_sysreg_s(r)
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

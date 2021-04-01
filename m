Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADF4C433ED
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 15:48:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E286137D
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 15:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E286137D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C1234184F;
	Thu,  1 Apr 2021 15:48:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 44yTvfC5jCIY; Thu,  1 Apr 2021 15:48:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBAF941844;
	Thu,  1 Apr 2021 15:48:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76064C0014;
	Thu,  1 Apr 2021 15:48:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2035BC000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E0E984AB5
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:48:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HiSmX_vUr6ob for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 15:48:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F05284A88
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:48:16 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id d191so1282122wmd.2
 for <iommu@lists.linux-foundation.org>; Thu, 01 Apr 2021 08:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qub8LkQbyb/J5uNpp4g8ATsj85wA0bgJXeqax9VzI7c=;
 b=YMHzvO+ygBA8aFd9uKuyqZjGlwdsNGAMMtdBSDTJtubu94ADR9dvOieEa5fB/2hJ0l
 fCY9RsC0BumodJ4fCz94O5BqO3NP5mF653Mgph1n7Euge3oyWB4EMdUGekJBqUNQW7tx
 dSjfH6pdtHblZFvLgGfpTqGVzpLSdpiOu6+vKsdX/alACiLi8QNdC/YvvBMZAo5SBaKV
 5W76dfTtD6FD/IXybcb4aibJ3UiyTPJeRB7RX0kicrebxrHBJXjQ7QfAW3AtxlnQCiFX
 oO01rFVypr3DxOgGp6fa7O0STysDv2Gr0drE7cLD406BhN4zEEe4gam42GM+pcQEn4zl
 /Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qub8LkQbyb/J5uNpp4g8ATsj85wA0bgJXeqax9VzI7c=;
 b=sReETEuZQpTiOVcUaS8q8nF5IKL3cvCkFFJzE9fkN7wZDkGJ7/PGWp66c/kbJ3oJde
 NS7kBYMp3i94cMIHWVsDY6RwiNur1ANS2eQYuih1Jr5553YzdSU5p8h8GhEuJA+sS2Rg
 vEtQ23LzlNXqEjUR71YOdYJVt9LITfkmyBn1pVaLUMc4ne9FEXpa4aj+rnouFZsPYHiW
 0ezdq9x3OcGjeUOsPhI7EipjI7oQCIBMcXdXgrGiDS1uzU4W9iy0RyciCf53R6SQKPJo
 hZ1zMYCDHgP5pxmyev96jrTbBhnQ9HHD3zSDAzEseXsRqwC+63Up1eOEwjWSnxxGL/dU
 8N2g==
X-Gm-Message-State: AOAM531rx+70+5Q6HoMpdg8dcIIudAtN/8MJbtbIxCtDyaNmY1GLUULZ
 fG57eA1nXC5S7Irav5jZgy2DoA==
X-Google-Smtp-Source: ABdhPJwOHMhkkGtUIyMawLIFd333IR0I8HdHY8TQ2XF48NAgXA/43XIE6r6rIFt551KFKYFSKMWo6Q==
X-Received: by 2002:a1c:61c5:: with SMTP id v188mr8516425wmb.20.1617292094337; 
 Thu, 01 Apr 2021 08:48:14 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y8sm8722505wmi.46.2021.04.01.08.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 08:48:14 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v14 01/10] iommu: Fix comment for struct iommu_fwspec
Date: Thu,  1 Apr 2021 17:47:10 +0200
Message-Id: <20210401154718.307519-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401154718.307519-1-jean-philippe@linaro.org>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: vivek.gautam@arm.com, guohanjun@huawei.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
 robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org
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

Commit 986d5ecc5699 ("iommu: Move fwspec->iommu_priv to struct
dev_iommu") removed iommu_priv from fwspec and commit 5702ee24182f
("ACPI/IORT: Check ATS capability in root complex nodes") added @flags.
Update the struct doc.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e7fe519430a..1d422bf722a1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -571,7 +571,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * struct iommu_fwspec - per-device IOMMU instance data
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
- * @iommu_priv: IOMMU driver private data for this device
+ * @flags: IOMMU_FWSPEC_* flags
  * @num_pasid_bits: number of PASID bits supported by this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

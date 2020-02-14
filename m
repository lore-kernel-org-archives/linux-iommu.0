Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C62FC2BA83
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 16:07:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B48222C2
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 16:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdOPmNYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B48222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A572F8765E;
	Fri, 14 Feb 2020 16:07:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sp2ygYZ9ueVh; Fri, 14 Feb 2020 16:07:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 44B0C87680;
	Fri, 14 Feb 2020 16:06:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EF03C1D90;
	Fri, 14 Feb 2020 16:06:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D19EC08A4
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 16:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 79E8F86519
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 16:06:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5YCRPp35nNoi for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 16:06:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C87A48665F
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 16:06:57 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id c9so11507444wrw.8
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 08:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=skMhNoTugJ6zTST/t+E4o/R9M7w7is4uxoA6SOGqsOo=;
 b=fdOPmNYPBxSQT0jzJbJlZa3aOnpBcmQ+NPrr4Xy/noKSZhKiX9i700NF6ESveRM+Lv
 xTlEA1Dwu5xMjQ894g+vUCiUoiXJGH+9uqSEd9o2xzn1WnXBxozF1VYbMXmoEsWOI7Ry
 VttQ14b8IQqqdioUurOE0pSQgDT+LFulxpzhp8JiELjG1etHKs2URbJKkPzfQT0G9AVW
 l+jYo4OTMH9FxAWzZoIlKcG2Fb8KRGv+u1ESgU+kpLZWNwv13bfAppOjhXZ6quP3XM1U
 Pad34GfIYydgU733zs8YsgE+pFsFictetmwnoEgjad+U0KtYYSRY9thw1TtP3FGx8H5B
 IPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=skMhNoTugJ6zTST/t+E4o/R9M7w7is4uxoA6SOGqsOo=;
 b=XQhBQMPQZPKZNmBSYM7l2D5PmQAKGtoB2Nme7OREY3aRLpZgpMYbshSmm9Fx4PLOXQ
 7nZ00MI5NgtVIIdFgIrTWBJDOslM+W/1A/NHHG34Ms993k1zLR+JGmhMHFwjRqnFkGFk
 MEooN8ZnvS1DKJwdrD2y8xNeqkwo8NYxPI3blZpiF2t8rH/lUzecSZ21ZOhF9rLI65BM
 eYtG9I61EvE7y7PSVH9JLda0reAkwSIZwwKd8XZDzE6UFCHE99ysMDucBx5wBOd71Ww+
 TQpjEpJJU9MkOURma5ukwscyMvb4HrMrwINImJAiq/goKklExowPhZ04hdOSrZrqCDEK
 uKcQ==
X-Gm-Message-State: APjAAAXQ0XetfQFKGkMgbIKLV0O+AyDFEbLOxIHx/CJP4KgjfVODX/Ye
 soddVr/PGsMvdtkKReMImmrVzMdef6s=
X-Google-Smtp-Source: APXvYqxyqmg7e8LeAx5P9P0xO6XsDZ38hCrdbxzCLwg/PkzE30ga5qHV2iVyIHRd9cU6DZhhE39m0A==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr4652778wrp.167.1581696416079; 
 Fri, 14 Feb 2020 08:06:56 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s139sm8133213wme.35.2020.02.14.08.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 08:06:55 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org
Subject: [PATCH 3/3] iommu/virtio: Enable x86 support
Date: Fri, 14 Feb 2020 17:04:13 +0100
Message-Id: <20200214160413.1475396-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214160413.1475396-1-jean-philippe@linaro.org>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: kevin.tian@intel.com, mst@redhat.com, sebastien.boeuf@intel.com,
 jacob.jun.pan@intel.com, bhelgaas@google.com, jasowang@redhat.com
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

With the built-in topology description in place, x86 platforms can now
use the virtio-iommu.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 068d4e0e3541..adcbda44d473 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -508,8 +508,9 @@ config HYPERV_IOMMU
 config VIRTIO_IOMMU
 	bool "Virtio IOMMU driver"
 	depends on VIRTIO=y
-	depends on ARM64
+	depends on (ARM64 || X86)
 	select IOMMU_API
+	select IOMMU_DMA
 	select INTERVAL_TREE
 	help
 	  Para-virtualised IOMMU driver with virtio.
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

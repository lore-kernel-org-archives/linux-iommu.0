Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7DAECE588
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 16:30:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3AA52086A
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 16:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9iAWGuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3AA52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 02333E96;
	Tue, 15 Oct 2019 16:29:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DDEC6E96
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 16:29:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 49EBC6C5
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 16:29:56 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id r5so24602179wrm.12
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 09:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=JvkdWrZIuVB4wEQZQVs5mAArtaBmF1bFpmfJLPYELHc=;
	b=c9iAWGuv1XKyHTA7scMFN2stJQ00qiFgIav/YIaYpT/gsyQUB45XlCLD/GVMFPFjaL
	1N636dgDqAWWFtQQuyx3UguhBhZ8LpG1khVGnZwJA4tc1R0lf37t+ajkrIdT4ugOzpaR
	VyfWCEdLwm/s0C2YSocndvVNe4El3u/AnW8iUSzz91jeVT8NhZe83063/1WNAo6jr6Jc
	uJl2ZYGBJq1DRyxkyijvc9qyGCs9XGzOx44DqruBqaN4ZO1yLf8ZR7925pneGyqAw+vm
	lRmjy7vWfxVGSSxnaKDcL9vznyjC2U0NqHVxx4jIKnw4w5+llBb3/V4s3CU0r68rNQou
	mcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=JvkdWrZIuVB4wEQZQVs5mAArtaBmF1bFpmfJLPYELHc=;
	b=YMTpiDFi0WMnWtY6DPhxO9p5rDVJs9dC+pmzmpUE9ddoYiV26hYQ6lz5EEsB7AI7Pw
	VJQ6NetxuqDHiz0Ya5aTd5h/ZVai4oWIFnheZzEayWpmTerekJh2pUfrG7PGgVZ5887O
	baxlM3+U1DXfreKsGjP1eBEi4HwQN+r/7seg8hCVlVXMctKyGC2E/NabteHoUnLW2Pvm
	RL57gcrQXK8Gb02yUTwIO+5DZJ41Bcn93iD2ppYRdK0qlU9mSsnQFef/3Tzxksouh8B3
	sn9514lCr+pRE5QBSQ2hMvUDWgEWBFPXVEUZqh1VtiTFA7Th4QM4A5j+6wA8HkhafiYn
	B6nA==
X-Gm-Message-State: APjAAAXiysIEI7+nKkLz5bs3UTJvKBAimPlyfDLnMqa7HbvE8U5NQAfy
	Q3/d34vlxQWNumfGGB+0aQ5A7KMa
X-Google-Smtp-Source: APXvYqxoxfeOmJ+UjotH/Ka0LqpXHcSy2mQ+oNsgtxdm/eawKd9g2S88Wjj+MkFv0YlMhAQ9t9zt4A==
X-Received: by 2002:adf:dcc6:: with SMTP id x6mr31056334wrm.81.1571156994875; 
	Tue, 15 Oct 2019 09:29:54 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
	by smtp.gmail.com with ESMTPSA id
	s9sm24373148wme.36.2019.10.15.09.29.53
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 15 Oct 2019 09:29:53 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 3/3] iommu: arm-smmu: Get reference to memory controller
Date: Tue, 15 Oct 2019 18:29:45 +0200
Message-Id: <20191015162945.1203736-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015162945.1203736-1-thierry.reding@gmail.com>
References: <20191015162945.1203736-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
	iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Thierry Reding <treding@nvidia.com>

Use the memory controller framework to obtain a reference to the memory
controller to which the SMMU will make memory requests. This allows the
two drivers to properly order their probes so that the memory controller
can be programmed first.

An example where this is required is Tegra186 where the stream IDs need
to be associated with memory clients before memory requests are emitted
with the correct stream ID.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/arm-smmu.c | 12 ++++++++++++
 drivers/iommu/arm-smmu.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index b18aac4c105e..8dd214244926 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2015,6 +2015,18 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 	smmu->dev = dev;
 
+	smmu->mc = memory_controller_get(dev, NULL);
+	if (IS_ERR(smmu->mc)) {
+		err = PTR_ERR(smmu->mc);
+
+		if (err != -ENODEV) {
+			dev_err(dev, "failed to get memory controller: %d\n", err);
+			return err;
+		}
+
+		smmu->mc = NULL;
+	}
+
 	if (dev->of_node)
 		err = arm_smmu_device_dt_probe(pdev, smmu);
 	else
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index b19b6cae9b5e..40b6d42eb3ab 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -17,6 +17,7 @@
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
+#include <linux/memory-controller.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -224,6 +225,7 @@ enum arm_smmu_implementation {
 
 struct arm_smmu_device {
 	struct device			*dev;
+	struct memory_controller	*mc;
 
 	void __iomem			*base;
 	unsigned int			numpage;
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

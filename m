Return-Path: <SRS0=DWjf=YY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C98FCA9ECF
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 21:33:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A412086D
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 21:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oU/f2dvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A412086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3D823DC3;
	Thu, 31 Oct 2019 21:33:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CC344DBE
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 21:33:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CC7D08A8
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 21:33:24 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id t12so3304573plo.6
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 14:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=IVsbwFP8AeKgn5KuqXlWOVRdSf7M1xugTS7jUvEVQtc=;
	b=oU/f2dvCHCBjQ55JB95SZcIANhYyJ9ITAqAZyUPy+8WCm30d3ew7K9ot3ljlismeG0
	64ZZ6rY+w87JZZP2/a/NOpuKpPQSzTOlD6tYFFErCKbk2o/d38myrMyLZHkj0eGMRWrK
	ZO4/0jwX0Y6hEQ1RTWCi/Wj/qeV6Wo9aIp8ZOQwP8c7XCPdeYxXsyETJzw4XyKMBU/lz
	qM9LlLfdRcPdbBy3/9gWJq9L5Nx5jDZR2yKoRwucfTLbyKtZ15BBcdJfb9rJadDqa8HN
	cFg/4VEnXCe2aLl7T7z7Yxd+De1QrhbV0OXFW9p/LS6zk0ELprOQr2XP2R2mafFphhso
	jwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=IVsbwFP8AeKgn5KuqXlWOVRdSf7M1xugTS7jUvEVQtc=;
	b=MUb0NTCKF7CSZEMHLdS3Q9FRw7JvldwQwPTGpaOdP2zr5fB83ZdSkIgFsII+9I7vnU
	GE7TeQ9JOQS39kcO3EaFfMRDyEvXnquYeKyntDCA97CeSx8rxcJtAMgLXyJ9kPmydQN3
	p6+vJ9rdd/vtCM7cw87+CTuJ67vLaGfqE4qwbPY43g+AzCMrMbjfEHUenu6Y0WQGxUCU
	t71ICgkoxo0DAddkNj9ujyWHuuIXNm6pfZ2b5ISkxiN/pP3maPN2KOUWOJMypWbveGuv
	zqzzRyl6J4BHf7kD5tXKaflvQfprpfI3IoJdlTN2dtXFDQJiHXYaOhuNDQAa4xsJI33r
	4eiA==
X-Gm-Message-State: APjAAAUHf5m2AZ/zf11bhkTKQtMnqkWMjMg+IscUPp1eAj7t5L60qV2H
	C6REnznDOOuxKOmPL7PVXvRsa/zigjg=
X-Google-Smtp-Source: APXvYqzA8b8TES3q8RMzhJpNbYR+VN+AMBJwUdINXVcCiKsaNB6N/jCmLAzvR9lFLICCokguWu+7lg==
X-Received: by 2002:a17:902:bb84:: with SMTP id
	m4mr8839423pls.211.1572557603878; 
	Thu, 31 Oct 2019 14:33:23 -0700 (PDT)
Received: from localhost ([100.118.89.196]) by smtp.gmail.com with ESMTPSA id
	135sm4038808pgh.89.2019.10.31.14.33.22
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 31 Oct 2019 14:33:22 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/arm-smmu: avoid pathological RPM behaviour for unmaps
Date: Thu, 31 Oct 2019 14:31:02 -0700
Message-Id: <20191031213102.17108-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
	freedreno@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>,
	linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>
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

From: Rob Clark <robdclark@chromium.org>

When games, browser, or anything using a lot of GPU buffers exits, there
can be many hundreds or thousands of buffers to unmap and free.  If the
GPU is otherwise suspended, this can cause arm-smmu to resume/suspend
for each buffer, resulting 5-10 seconds worth of reprogramming the
context bank (arm_smmu_write_context_bank()/arm_smmu_write_s2cr()/etc).
To the user it would appear that the system just locked up.

A simple solution is to use pm_runtime_put_autosuspend() instead, so we
don't immediately suspend the SMMU device.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm-smmu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7c503a6bc585..5abc0d210d90 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -122,7 +122,7 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 {
 	if (pm_runtime_enabled(smmu->dev))
-		pm_runtime_put(smmu->dev);
+		pm_runtime_put_autosuspend(smmu->dev);
 }
 
 static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
@@ -1154,6 +1154,20 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	/* Looks ok, so add the device to the domain */
 	ret = arm_smmu_domain_add_master(smmu_domain, fwspec);
 
+	/*
+	 * Setup an autosuspend delay to avoid bouncing runpm state.
+	 * Otherwise, if a driver for a suspendend consumer device
+	 * unmaps buffers, it will runpm resume/suspend for each one.
+	 *
+	 * For example, when used by a GPU device, when an application
+	 * or game exits, it can trigger unmapping 100s or 1000s of
+	 * buffers.  With a runpm cycle for each buffer, that adds up
+	 * to 5-10sec worth of reprogramming the context bank, while
+	 * the system appears to be locked up to the user.
+	 */
+	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
+	pm_runtime_use_autosuspend(smmu->dev);
+
 rpm_put:
 	arm_smmu_rpm_put(smmu);
 	return ret;
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

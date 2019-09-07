Return-Path: <SRS0=yK3q=XC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C26AC43140
	for <iommu@archiver.kernel.org>; Sat,  7 Sep 2019 17:50:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415AB218AF
	for <iommu@archiver.kernel.org>; Sat,  7 Sep 2019 17:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gwsp7VRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415AB218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F2623105F;
	Sat,  7 Sep 2019 17:50:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 79E5E105E
	for <iommu@lists.linux-foundation.org>;
	Sat,  7 Sep 2019 17:50:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 175B0756
	for <iommu@lists.linux-foundation.org>;
	Sat,  7 Sep 2019 17:50:23 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id d1so5340412pgp.4
	for <iommu@lists.linux-foundation.org>;
	Sat, 07 Sep 2019 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=wK8kJ2udIf0g3BsyoIaHFt8dADR/WXvxfITihNsDeFg=;
	b=Gwsp7VRn4r5cDdw7eygkYZ/sszfgRBn/LNffK8rKLuU3OXDMBJBQUafVm/8/Ym6kxl
	K6awj9C0Ux8gpf0vABsHPwAIKvMSSj1HLTzzX71l0KzyvaROHC2yWEmvxZUqIwm2nmrV
	lmAcCTAPwuKZNItjsz1tvAaLHs33eilTvmINw0ZqMFmLGcHNMeEFjmq9aeDH8XSCV7Je
	T+U7wuABMQprBiDBJ/RIg7QDfuYLkWl0B7++OvQOJnlTCNrryYx3AgCOz1cGCJhWOuVk
	XyZoKGE/8NngV3NN1lmVf04Gjw36Ts1U5JbkQX6QXEPMa5FYJCQ1regZqneDUa94+wOD
	YkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=wK8kJ2udIf0g3BsyoIaHFt8dADR/WXvxfITihNsDeFg=;
	b=NpeW+yImeDIqREnFeZfQF6TofShTerJnjQY7l1r1YkFmFkwY6a8CPf0d0fxF5CZGwc
	rKucQzRLsE2zZIczZLIVUzF0XymLBBG87H3K+pnnWR1JN6QcAIfueHNQhhX0Q8f6KF3j
	u8+QrugHGsircadz7OUTczD6J+OFtckF1i42UnP2zp6tRXSY5dUi1y2kRXH3rS+dZdhp
	2FMTzz5ukNBuXryl8r6sQKlarkbMN76UTzTwILtHnOBr1s8VsqUDSb0yVh/cvFYEhZlo
	vD4c6scTI3rSzFd7qAVCRwfIweR7YiwS+PVdb2fjVeJrh5YD3Xb2ZDAw018agnWw6hIi
	dInQ==
X-Gm-Message-State: APjAAAVyWk5MGUhiUkRa5MqsSlhiYJi3EnTPm+O/B/jtlp+LKIot/4rE
	0Qf/Fu9bUxcbMTVgg5E3F3Q6XVyFRrQ=
X-Google-Smtp-Source: APXvYqzafbPVLonS9mDnmRUFSlGT5UrLrAnZgt7eKA+ZXKBawYn/MhQ8WUF6BIH88qCUmZL2MEVRGA==
X-Received: by 2002:a65:6795:: with SMTP id e21mr13501884pgr.428.1567878622201;
	Sat, 07 Sep 2019 10:50:22 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:e554::8610])
	by smtp.gmail.com with ESMTPSA id 11sm8401943pgo.43.2019.09.07.10.50.21
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 07 Sep 2019 10:50:21 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/arm-smmu: fix "hang" when games exit
Date: Sat,  7 Sep 2019 10:50:13 -0700
Message-Id: <20190907175013.24246-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	open list <linux-kernel@vger.kernel.org>, freedreno@lists.freedesktop.org,
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
To the user it would appear that the system is locked up.

A simple solution is to use pm_runtime_put_autosuspend() instead, so we
don't immediately suspend the SMMU device.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
Note: I've tied the autosuspend enable/delay to the consumer device,
based on the reasoning that if the consumer device benefits from using
an autosuspend delay, then it's corresponding SMMU probably does too.
Maybe that is overkill and we should just unconditionally enable
autosuspend.

 drivers/iommu/arm-smmu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c2733b447d9c..73a0dd53c8a3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -289,7 +289,7 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 {
 	if (pm_runtime_enabled(smmu->dev))
-		pm_runtime_put(smmu->dev);
+		pm_runtime_put_autosuspend(smmu->dev);
 }
 
 static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
@@ -1445,6 +1445,15 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	/* Looks ok, so add the device to the domain */
 	ret = arm_smmu_domain_add_master(smmu_domain, fwspec);
 
+#ifdef CONFIG_PM
+	/* TODO maybe device_link_add() should do this for us? */
+	if (dev->power.use_autosuspend) {
+		pm_runtime_set_autosuspend_delay(smmu->dev,
+			dev->power.autosuspend_delay);
+		pm_runtime_use_autosuspend(smmu->dev);
+	}
+#endif
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

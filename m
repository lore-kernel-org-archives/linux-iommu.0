Return-Path: <SRS0=4X9E=EG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE32C56201
	for <iommu@archiver.kernel.org>; Sat, 31 Oct 2020 00:37:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873C0206ED
	for <iommu@archiver.kernel.org>; Sat, 31 Oct 2020 00:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRnUkU5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873C0206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 861D2871CD;
	Sat, 31 Oct 2020 00:37:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F8eDeBAHyDsn; Sat, 31 Oct 2020 00:37:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AC9DE871DA;
	Sat, 31 Oct 2020 00:37:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75529C1AD6;
	Sat, 31 Oct 2020 00:37:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7796DC0051
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 00:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 70F4987122
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 00:37:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SMduwmfYveOb for <iommu@lists.linux-foundation.org>;
 Sat, 31 Oct 2020 00:37:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A77058711C
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 00:37:27 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id x13so6537028pgp.7
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 17:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hvoWVjH5MrvJlNL+Wpvlrvtr/qdzZEjizkDpZ+3TUPw=;
 b=bRnUkU5QJDdovKB+3Oe64UD9XdGDPdwmEL0e6homqfsQ1GrFivNaT1ceK4jr1G1+hD
 Xbxz4vWZTuO7moh7D/gW1/RgAf7UfMkBg5sT/9tzH5t5cDLLDpZNgMsiPjipAuG9JU9a
 /oJaZOVt49Hshtnxjyt3fN+2HhvC0sdg9XYHDTDLnfWn+9GFau6SbOzuehTkD9sXpeyz
 QlOOZ+vBKupPhbBvtMsR2abFGbElx1JBNuqPQLrDA9LsFD3PRpg7o6cZ3fdIr5sdZqZ0
 TkQ+0OvYEwaPH/hljQjozd5Ynr4RR/vYgr5LS3ISaJs/vgJmazLuhn6jX01hFMa3nbZm
 s4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hvoWVjH5MrvJlNL+Wpvlrvtr/qdzZEjizkDpZ+3TUPw=;
 b=GxlfD2p7WpS47C3b8bcwkLkZe+FcKhdcDzf/qCYCBktXSlEcnOiMElzLgcYIij+hZM
 bc2/i9YXy0Hpaim+ndFabmuqRlsoX1E65c6Foe0Iz68trYG16Luh9xIH5aKcwTW0KxBN
 1ZjIT6BOa/aJnr4q4Y7h+eT9uKWkHFirFXy0yYaVcma0/Q2fWY2biPhSsQIGv+Qo9Jb/
 UqN7Fo+YYDEl5VPSXNIZnmsSLSlhEmKr/3prpBbLye0+f6idvMYKHybEynyO6Dkonqsr
 q3i2uYYXa/7G4/3rguvpZnWMQzPq8tSNPMuZX03+0xrHyWOuofrZI9kSU9kpX1RMwckv
 V7tw==
X-Gm-Message-State: AOAM533wyHe15f0BzenUKVoT89uXW0mZxX4d6/bVkiEwQqeaJQS9pbLM
 P9y/1W+TD6Nnrs05xyaSeXZ+fg==
X-Google-Smtp-Source: ABdhPJxeqhaBAC7zYRx5xaemqM+o7fL8zXijASb2rLhquYgoiO/uJc+BWuRhrzTtrM6vCX+g3MXc8A==
X-Received: by 2002:aa7:9095:0:b029:164:75c4:5d15 with SMTP id
 i21-20020aa790950000b029016475c45d15mr11561202pfa.49.1604104647290; 
 Fri, 30 Oct 2020 17:37:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
 by smtp.gmail.com with ESMTPSA id
 3sm7011935pfv.92.2020.10.30.17.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 17:37:26 -0700 (PDT)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH 2/2] iommu: Avoid crash if iommu_group is null
Date: Sat, 31 Oct 2020 00:37:21 +0000
Message-Id: <20201031003721.40973-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201031003721.40973-1-john.stultz@linaro.org>
References: <20201031003721.40973-1-john.stultz@linaro.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Saravana Kannan <saravanak@google.com>,
 Will Deacon <will@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, iommu@lists.linux-foundation.org,
 Andy Gross <agross@kernel.org>, John Stultz <john.stultz@linaro.org>,
 Marc Zyngier <maz@kernel.org>, Robin Murphy <robin.murphy@arm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

In trying to handle a possible driver probe ordering issue
brought up by Robin Murphy, I ran across a separate null pointer
crash in the iommu core in iommu_group_remove_device():
[    2.732803] dwc3-qcom a6f8800.usb: failed to get usb-ddr path: -517
[    2.739281] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000c0
...
[    2.775619] [00000000000000c0] user address but active_mm is swapper
[    2.782039] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[    2.787670] Modules linked in:
[    2.790769] CPU: 6 PID: 1 Comm: swapper/0 Tainted: G        W         5.10.0-rc1-mainline-00025-g272a618fc36-dirty #3973
[    2.801719] Hardware name: Thundercomm Dragonboard 845c (DT)
[    2.807431] pstate: 00c00005 (nzcv daif +PAN +UAO -TCO BTYPE=--)
[    2.813508] pc : iommu_group_remove_device+0x30/0x1b0
[    2.818611] lr : iommu_release_device+0x4c/0x78
[    2.823189] sp : ffffffc01005b950
...
[    2.907082] Call trace:
[    2.909566]  iommu_group_remove_device+0x30/0x1b0
[    2.914323]  iommu_release_device+0x4c/0x78
[    2.918559]  iommu_bus_notifier+0xe8/0x108
[    2.922708]  blocking_notifier_call_chain+0x78/0xb8
[    2.927641]  device_del+0x2ac/0x3d0
[    2.931177]  platform_device_del.part.9+0x20/0x98
[    2.935933]  platform_device_unregister+0x2c/0x40
[    2.940694]  of_platform_device_destroy+0xd8/0xe0
[    2.945450]  device_for_each_child_reverse+0x58/0xb0
[    2.950471]  of_platform_depopulate+0x4c/0x78
[    2.954886]  dwc3_qcom_probe+0x93c/0xcb8
[    2.958858]  platform_drv_probe+0x58/0xa8
[    2.962917]  really_probe+0xec/0x398
[    2.966531]  driver_probe_device+0x5c/0xb8
[    2.970677]  device_driver_attach+0x74/0x98
[    2.974911]  __driver_attach+0x60/0xe8
[    2.978700]  bus_for_each_dev+0x84/0xd8
[    2.982581]  driver_attach+0x30/0x40
[    2.986194]  bus_add_driver+0x160/0x208
[    2.990076]  driver_register+0x64/0x110
[    2.993957]  __platform_driver_register+0x58/0x68
[    2.998716]  dwc3_qcom_driver_init+0x20/0x28
[    3.003041]  do_one_initcall+0x6c/0x2d0
[    3.006925]  kernel_init_freeable+0x214/0x268
[    3.011339]  kernel_init+0x18/0x118
[    3.014876]  ret_from_fork+0x10/0x18
[    3.018495] Code: d0006a21 f9417295 91130021 910162b6 (b940c2a2)

In the case above, the arm-smmu driver fails to probe with
EPROBE_DEFER, and I'm guessing I'm guessing that causes
iommu_group_add_device() to fail and sets the
dev->iommu_group = NULL, then somehow we hit
iommu_group_remove_device() and trip over the null value?
I'm not really sure...

Anyway, adding the null check seems to avoid the issue and the
system boots fine after the arm-smmu driver later reprobed.

Feedback or better ideas for a solution would be appreciated!

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: iommu@lists.linux-foundation.org
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c470f451a323..44639b88e77db 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -877,6 +877,10 @@ void iommu_group_remove_device(struct device *dev)
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *tmp_device, *device = NULL;
 
+	/* Avoid crash if iommu_group value is null */
+	if (!group)
+		return;
+
 	dev_info(dev, "Removing from iommu group %d\n", group->id);
 
 	/* Pre-notify listeners that a device is being removed. */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

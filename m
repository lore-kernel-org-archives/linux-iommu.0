Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43F3C388F7
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 22:05:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1300D21D7F
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 22:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="htWCDbEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1300D21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 889BF8742A;
	Thu, 12 Nov 2020 22:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ylefzXW3pg7; Thu, 12 Nov 2020 22:05:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E362B872B9;
	Thu, 12 Nov 2020 22:05:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC8D1C088B;
	Thu, 12 Nov 2020 22:05:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E712C016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 22:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5DA99872F0
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 22:05:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cbAsc3iCZ4C6 for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 22:05:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A5D91872B9
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 22:05:25 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id w6so5849785pfu.1
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 14:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+LawQ4KJDTzVq+QOpbpG8odPiP4w40hrHWLf6v+3rmE=;
 b=htWCDbEmACJ9y+gah7nI9tft5RVJ1CtHVOlcXXga1UkmUIpP9KRR5X9vpAxLidVOJ+
 sdq/Xg+NeKMAvmba9Gtv6CViADwOh7abi/n1hb4BkHkhcwW1EiPvt/XYcOA4mAFy22Do
 mltLfXPtS/WR61qc7e1YXL/nmxRzktg/JXPxJGU8sZLF6Dt+ZGk+4w1PoRbPUP8fSlB7
 5A1/dgpbToPP4R4JXa4X3wZ0rG9+zYR+pR9EBWnVi+HD4lDfgJcZDcO2jmQ/6xTM/k8G
 +ODdG/qgThRGrXEqzbhbvVX0RAhfKg3sPxwXCos9bmxxNWNUgQd/qoyafic/F1MCBDIm
 zSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+LawQ4KJDTzVq+QOpbpG8odPiP4w40hrHWLf6v+3rmE=;
 b=uQ2Ce8DW4j/ua2NgOsxtjxHXfeEkUbe8mebqChBW5KC8BIAYcDf6LitPFtpY8zDCRy
 61dCHGEHXaUCn+lDNMCdepj+CTQxjatviFn9qVHl1B2OK+9A4B7IPYXBT8MYsv+LXE5t
 7GP+JrO+DzEKkTI8oronZZDxBMqfKCsIs1OQU06vOA3MFsJg9XZUQ1QmYOjG37q3/iu2
 2w8gRJOwgEHgbVxE/AIdBlNjPIozlrLNgm3XwYsPpSI+z1+m5SOoqq2cv9BT6wOS9KJf
 oJ+UMBUT2g1ldjkwDYPLPTW+MYEa0fOtJPx9mLYBEW8cfY9j6AVCAtjHjYXt76M52NxF
 jIUQ==
X-Gm-Message-State: AOAM533yQSSdocfY/Il0Ll4/6oz8MTgXYvWw22KyGEvZ9wljRkxvA6f8
 89Dz5Ggxbn6nUrAsTlTDukKBmQ==
X-Google-Smtp-Source: ABdhPJzGwfTtv0eKnetksxwmqcLkLuFLyfkWvoLi4homYAQ4vpAhKHsccreAGTDL0qxC/sv1A2nKeQ==
X-Received: by 2002:aa7:80c9:0:b029:164:4ca1:fff with SMTP id
 a9-20020aa780c90000b02901644ca10fffmr1432340pfn.11.1605218725223; 
 Thu, 12 Nov 2020 14:05:25 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
 by smtp.gmail.com with ESMTPSA id
 mv5sm7638976pjb.42.2020.11.12.14.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 14:05:24 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [RESEND][PATCH 2/2] iommu: Avoid crash if iommu_group is null
Date: Thu, 12 Nov 2020 22:05:20 +0000
Message-Id: <20201112220520.48159-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201112220520.48159-1-john.stultz@linaro.org>
References: <20201112220520.48159-1-john.stultz@linaro.org>
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
index b53446bb8c6b4..28229f7ef7d5a 100644
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

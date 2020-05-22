Return-Path: <SRS0=4l6Q=7E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103D4C433E0
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 13:02:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB0A206D5
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 13:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="hVly2wYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB0A206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B616588A90;
	Fri, 22 May 2020 13:02:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X-ADnyycUmYs; Fri, 22 May 2020 13:02:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3F9B788A8F;
	Fri, 22 May 2020 13:02:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BB51C0863;
	Fri, 22 May 2020 13:02:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09446C0176
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 13:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EADCC8867B
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 13:02:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xHvp5MMt-kjU for <iommu@lists.linux-foundation.org>;
 Fri, 22 May 2020 13:02:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EBD8888647
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 13:02:10 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1590152533; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=aZcjMzyQhmF408KAg+aRhNzpY4xzo8oNxhr6p1nbQUY=;
 b=hVly2wYDEVzGlAz+2zyZMYjGqBeovhrvJoa61HIppaWO6ncZX0V8mWgRP2bavztO7RwYwkhi
 Cs1pLkpW1k4lynVftB0xzA9EKCi0eBVgqMXCBiT7IYvOS5B/VMdzo3ObdQm6iYoCrNcrV8HW
 a3RXiGENHi6hQcoGanraSxDAvzQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec7cd46.7f93ab1dfdc0-smtp-out-n04;
 Fri, 22 May 2020 13:01:58 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 52B70C43395; Fri, 22 May 2020 13:01:58 +0000 (UTC)
Received: from blr-ubuntu-311.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 29C5BC433C6;
 Fri, 22 May 2020 13:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29C5BC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu: Fix group refcount in iommu_alloc_default_domain()
Date: Fri, 22 May 2020 18:31:45 +0530
Message-Id: <20200522130145.30067-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

Since the change to move default domain allocation to probe,
there is a refcount decrement missing for the group in
iommu_alloc_default_domain(). Because of this missing
refcount decrement, the device is never released from the
group as the devices_kobj refcount never reaches 0 in
iommu_group_remove_device() leading to a lot of issues.
One such case is that this will lead to a different group
allocation on every reload of the module which configures
iommu such as the ath10k module which then finally fails
to attach this device to the SMMU with -ENOSPC error in
__arm_smmu_alloc_bitmap() once the count of module reload
crosses the number of context banks. This will then lead
to NULL pointer deference in the next reload of the module.
Add the missing refcount decrement(iommu_group_put()) in
iommu_alloc_default_domain() to fix this issue.

Call trace:

<snip>...
  platform wifi-firmware.0: Adding to iommu group 82
  ath10k_snoc 18800000.wifi: could not attach device: -28
  platform wifi-firmware.0: Removing from iommu group 82
  ath10k_snoc 18800000.wifi: failed to initialize firmware: -28
  ath10k_snoc: probe of 18800000.wifi failed with error -28
  platform wifi-firmware.0: Adding to iommu group 83
  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  Mem abort info:
    ESR = 0x96000006
    EC = 0x25: DABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
  Data abort info:
    ISV = 0, ISS = 0x00000006
    CM = 0, WnR = 0
  user pgtable: 4k pages, 39-bit VAs, pgdp=0000000177a53000
  [0000000000000000] pgd=00000001e74f5003, pud=00000001e74f5003, pmd=0000000000000000
  Internal error: Oops: 96000006 [#1] PREEMPT SMP
  pstate: 60400009 (nZCv daif +PAN -UAO)
  arm_smmu_flush_iotlb_all+0x20/0x6c
  iommu_create_device_direct_mappings+0x17c/0x1d8
  iommu_probe_device+0xc0/0x100
  of_iommu_configure+0x108/0x240
  of_dma_configure+0x130/0x1d0
  ath10k_fw_init+0xc4/0x1c4 [ath10k_snoc]
  ath10k_snoc_probe+0x5cc/0x678 [ath10k_snoc]
  platform_drv_probe+0x90/0xb0
  really_probe+0x134/0x2ec
  driver_probe_device+0x64/0xfc
  device_driver_attach+0x4c/0x6c
  __driver_attach+0xac/0xc0
  bus_for_each_dev+0x8c/0xd4
  driver_attach+0x2c/0x38
  bus_add_driver+0xfc/0x1d0
  driver_register+0x64/0xf8
  __platform_driver_register+0x4c/0x58
  init_module+0x20/0x1000 [ath10k_snoc]
  do_one_initcall+0x13c/0x2d0
  do_init_module+0x58/0x1dc
  load_module+0xde0/0xf10
  __arm64_sys_finit_module+0xb0/0xe0
  el0_svc_common+0xa4/0x154
  el0_svc_compat_handler+0x2c/0x38
  el0_svc_compat+0x8/0x10
 Code: d503201f f85b8268 b4000248 f8560e74 (f9400280)
 ---[ end trace e5c1470a584952a0 ]---
 Kernel panic - not syncing: Fatal exception

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/iommu/iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a4c2f122eb8b..05f7b77c432f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1491,6 +1491,7 @@ static int iommu_alloc_default_domain(struct device *dev)
 {
 	struct iommu_group *group;
 	unsigned int type;
+	int ret;
 
 	group = iommu_group_get(dev);
 	if (!group)
@@ -1501,7 +1502,11 @@ static int iommu_alloc_default_domain(struct device *dev)
 
 	type = iommu_get_def_domain_type(dev);
 
-	return iommu_group_alloc_default_domain(dev->bus, group, type);
+	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
+
+	iommu_group_put(group);
+
+	return ret;
 }
 
 /**
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EE6C4363A
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 07:14:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB68223EA
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 07:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB68223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EDC5685168;
	Wed, 28 Oct 2020 07:14:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id apBkoX3AjW2S; Wed, 28 Oct 2020 07:14:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 63FFC852CF;
	Wed, 28 Oct 2020 07:14:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40594C088B;
	Wed, 28 Oct 2020 07:14:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7AB2C0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 07:14:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9F8F486554
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 07:14:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5daO5VWYI38E for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 07:14:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6CDEE864D8
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 07:14:21 +0000 (UTC)
IronPort-SDR: WJfoPqPUFtJJov3xpwmqn/54l7ICnj+5Ed4hfTuBUwD8sSSfnvZuvQ6Sj1kM9ZhhepGbMRUw1f
 KbMlrePPNm0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="164717651"
X-IronPort-AV: E=Sophos;i="5.77,425,1596524400"; d="scan'208";a="164717651"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2020 00:14:20 -0700
IronPort-SDR: rcxhHA4pBVxnIVq90gvhLsON7VuGysxmc9kh43UQUk5eHspKTWMxESrQHrbuGORph0f+OWKmsM
 HfwgkcqCN3AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,425,1596524400"; d="scan'208";a="424645925"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 28 Oct 2020 00:14:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/vt-d: Fix kernel NULL pointer dereference in
 find_domain()
Date: Wed, 28 Oct 2020 15:07:25 +0800
Message-Id: <20201028070725.24979-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: Xu Pengfei <pengfei.xu@intel.com>, iommu@lists.linux-foundation.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
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

If calling find_domain() for a device which hasn't been probed by the
iommu core, below kernel NULL pointer dereference issue happens.

[  362.736947] BUG: kernel NULL pointer dereference, address: 0000000000000038
[  362.743953] #PF: supervisor read access in kernel mode
[  362.749115] #PF: error_code(0x0000) - not-present page
[  362.754278] PGD 0 P4D 0
[  362.756843] Oops: 0000 [#1] SMP NOPTI
[  362.760528] CPU: 0 PID: 844 Comm: cat Not tainted 5.9.0-rc4-intel-next+ #1
[  362.767428] Hardware name: Intel Corporation Ice Lake Client Platform/IceLake
               U DDR4 SODIMM PD RVP TLC, BIOS ICLSFWR1.R00.3384.A02.1909200816
               09/20/2019
[  362.781109] RIP: 0010:find_domain+0xd/0x40
[  362.785234] Code: 48 81 fb 60 28 d9 b2 75 de 5b 41 5c 41 5d 5d c3 0f 1f 00 66
                     2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 87 e0 02 00
                     00 55 <48> 8b 40 38 48 89 e5 48 83 f8 fe 0f 94 c1 48 85 ff
                     0f 94 c2 08 d1
[  362.804041] RSP: 0018:ffffb09cc1f0bd38 EFLAGS: 00010046
[  362.809292] RAX: 0000000000000000 RBX: ffff905b98e4fac8 RCX: 0000000000000000
[  362.816452] RDX: 0000000000000001 RSI: ffff905b98e4fac8 RDI: ffff905b9ccd40d0
[  362.823617] RBP: ffffb09cc1f0bda0 R08: ffffb09cc1f0bd48 R09: 000000000000000f
[  362.830778] R10: ffffffffb266c080 R11: ffff905b9042602d R12: ffff905b98e4fac8
[  362.837944] R13: ffffb09cc1f0bd48 R14: ffff905b9ccd40d0 R15: ffff905b98e4fac8
[  362.845108] FS:  00007f8485460740(0000) GS:ffff905b9fc00000(0000)
               knlGS:0000000000000000
[  362.853227] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  362.858996] CR2: 0000000000000038 CR3: 00000004627a6003 CR4: 0000000000770ef0
[  362.866161] PKRU: fffffffc
[  362.868890] Call Trace:
[  362.871363]  ? show_device_domain_translation+0x32/0x100
[  362.876700]  ? bind_store+0x110/0x110
[  362.880387]  ? klist_next+0x91/0x120
[  362.883987]  ? domain_translation_struct_show+0x50/0x50
[  362.889237]  bus_for_each_dev+0x79/0xc0
[  362.893121]  domain_translation_struct_show+0x36/0x50
[  362.898204]  seq_read+0x135/0x410
[  362.901545]  ? handle_mm_fault+0xeb8/0x1750
[  362.905755]  full_proxy_read+0x5c/0x90
[  362.909526]  vfs_read+0xa6/0x190
[  362.912782]  ksys_read+0x61/0xe0
[  362.916037]  __x64_sys_read+0x1a/0x20
[  362.919725]  do_syscall_64+0x37/0x80
[  362.923329]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  362.928405] RIP: 0033:0x7f84855c5e95

Filter out those devices to avoid such error.

Fixes: e2726daea583d ("iommu/vt-d: debugfs: Add support to show page table internals")
Cc: stable@vger.kernel.org#v5.6+
Reported-and-tested-by: Xu Pengfei <pengfei.xu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8651f6d4dfa0..1b1ca63e6bbe 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2525,6 +2525,9 @@ struct dmar_domain *find_domain(struct device *dev)
 {
 	struct device_domain_info *info;
 
+	if (unlikely(!dev || !dev->iommu))
+		return NULL;
+
 	if (unlikely(attach_deferred(dev)))
 		return NULL;
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

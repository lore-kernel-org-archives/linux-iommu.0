Return-Path: <SRS0=EPGj=UL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA2AC31E44
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 00:38:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3648208C2
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 00:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3648208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9A0CC148E;
	Wed, 12 Jun 2019 00:38:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B1D22146E
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 00:36:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 466AE775
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 00:36:17 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	11 Jun 2019 17:36:17 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by orsmga001.jf.intel.com with ESMTP; 11 Jun 2019 17:36:15 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 5/7] iommu/vt-d: Fix suspicious RCU usage in
	probe_acpi_namespace_devices()
Date: Wed, 12 Jun 2019 08:28:49 +0800
Message-Id: <20190612002851.17103-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612002851.17103-1-baolu.lu@linux.intel.com>
References: <20190612002851.17103-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, cai@lca.pw, jacob.jun.pan@intel.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The drhd and device scope list should be iterated with the
iommu global lock held. Otherwise, a suspicious RCU usage
message will be displayed.

[    3.695886] =============================
[    3.695917] WARNING: suspicious RCU usage
[    3.695950] 5.2.0-rc2+ #2467 Not tainted
[    3.695981] -----------------------------
[    3.696014] drivers/iommu/intel-iommu.c:4569 suspicious rcu_dereference_check() usage!
[    3.696069]
               other info that might help us debug this:

[    3.696126]
               rcu_scheduler_active = 2, debug_locks = 1
[    3.696173] no locks held by swapper/0/1.
[    3.696204]
               stack backtrace:
[    3.696241] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc2+ #2467
[    3.696370] Call Trace:
[    3.696404]  dump_stack+0x85/0xcb
[    3.696441]  intel_iommu_init+0x128c/0x13ce
[    3.696478]  ? kmem_cache_free+0x16b/0x2c0
[    3.696516]  ? __fput+0x14b/0x270
[    3.696550]  ? __call_rcu+0xb7/0x300
[    3.696583]  ? get_max_files+0x10/0x10
[    3.696631]  ? set_debug_rodata+0x11/0x11
[    3.696668]  ? e820__memblock_setup+0x60/0x60
[    3.696704]  ? pci_iommu_init+0x16/0x3f
[    3.696737]  ? set_debug_rodata+0x11/0x11
[    3.696770]  pci_iommu_init+0x16/0x3f
[    3.696805]  do_one_initcall+0x5d/0x2e4
[    3.696844]  ? set_debug_rodata+0x11/0x11
[    3.696880]  ? rcu_read_lock_sched_held+0x6b/0x80
[    3.696924]  kernel_init_freeable+0x1f0/0x27c
[    3.696961]  ? rest_init+0x260/0x260
[    3.696997]  kernel_init+0xa/0x110
[    3.697028]  ret_from_fork+0x3a/0x50

Fixes: fa212a97f3a36 ("iommu/vt-d: Probe DMA-capable ACPI name space devices")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 19c4c387a3f6..84e650c6a46d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4793,8 +4793,10 @@ int __init intel_iommu_init(void)
 	cpuhp_setup_state(CPUHP_IOMMU_INTEL_DEAD, "iommu/intel:dead", NULL,
 			  intel_iommu_cpu_dead);
 
+	down_read(&dmar_global_lock);
 	if (probe_acpi_namespace_devices())
 		pr_warn("ACPI name space devices didn't probe correctly\n");
+	up_read(&dmar_global_lock);
 
 	/* Finally, we enable the DMA remapping hardware. */
 	for_each_iommu(iommu, drhd) {
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

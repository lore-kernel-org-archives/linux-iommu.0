Return-Path: <SRS0=Zlue=TG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A41C04A6B
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 16:13:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80A7205ED
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 16:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gQBED0wb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80A7205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7347A4955;
	Mon,  6 May 2019 16:13:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B4A234951
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 16:11:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
	[209.85.222.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1406FFD
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 16:11:35 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id j1so2315748qkk.12
	for <iommu@lists.linux-foundation.org>;
	Mon, 06 May 2019 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=5D+9uGXmpcgmf1cygG1Z2A4baVhwlej9er6BryKLtzE=;
	b=gQBED0wbfVpPD9V5NE6jRxR+fbZ9zEBhqIPMuIH9Tle/h9M/E6x/Iz+Eq33oUBvZK9
	xGuMr6L1Lso4wNT+R01q/x4bzb6kbbMuMwYnZ+5FDqY0EkC3EN/ifqCBKrwJ9T9hvYcD
	38j6qNxe4HQecJfCRZzdtFbNqOPc13M5kbtwSZtSIvGf/rDrK/RIuALyjYrz4pPYP/qq
	AWyhAZ/2G5zz2OEgHd2dFYNppk7PhucOD4abLlviyAwYb7dxZG2YggrJ0mpEj7vkyruE
	Q0EFaXqx9EJ/M7s2X2sMe6RBG+e8ekCW0TmJ2CdLouVNcerBHRNxPhWIXNzwW17xTaF/
	8QNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=5D+9uGXmpcgmf1cygG1Z2A4baVhwlej9er6BryKLtzE=;
	b=TTSw8PkXSZv56dGd83OCnTQxUvEBsPBuu27KLnedBIirTRFAZCymrVk4YQ96tCCpSL
	mYfc4hVmIN2YsMBNp15XvdWmfIMLbb7XJNuaqjaSp+CsABWp1IRYpbxbf56p9Wm+86/1
	4HNj2TZfNfksHg+dGptNGN0MWMJqdo+iWnKUoyDMD5Bwc7TD2nLSAjhuIXHfkVJZnELk
	O7rGh1jGRHakc4f87AVaLavheVxCJJSRSjlEITp2Ec6LjUKcDlD878B2BIHgD12yX/fc
	pYimGVyzHeBCVEzywXsMlfVnaDZK4te73t/WFJV47OLgSezk2p4cBJv4WdNRe1hvTMF6
	tI5Q==
X-Gm-Message-State: APjAAAVsQUU/0/VMrxpK/3q53naDISSmOBN6m9IX5u0rfDZTBXqSp4U+
	GGpPIH++0Bn9Cxm8fgmj801Fqw==
X-Google-Smtp-Source: APXvYqzVAmcTE1iEovsBofvY0k4QnpA8kI/dtcV+b++BNUlSdwH29yEL3TH+F4HAHF/kOYQUnFPMKQ==
X-Received: by 2002:a37:404b:: with SMTP id n72mr20486940qka.98.1557159095116; 
	Mon, 06 May 2019 09:11:35 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com
	(pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
	by smtp.gmail.com with ESMTPSA id
	q56sm8483468qtk.72.2019.05.06.09.11.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 09:11:34 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Subject: [PATCH -next] iommu/amd: fix a null-ptr-deref in map_sg()
Date: Mon,  6 May 2019 12:10:25 -0400
Message-Id: <20190506161025.36744-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Cc: tmurphy@arista.com, iommu@lists.linux-foundation.org, Qian Cai <cai@lca.pw>,
	linux-kernel@vger.kernel.org
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

The commit 1a1079011da3 ("iommu/amd: Flush not present cache in
iommu_map_page") added domain_flush_np_cache() in map_sg() which
triggered a crash below during boot. sg_next() could return NULL if
sg_is_last() is true, so after for_each_sg(sglist, s, nelems, i), "s"
could be NULL which ends up deferencing a NULL pointer later here,

domain_flush_np_cache(domain, s->dma_address, s->dma_length);

BUG: kernel NULL pointer dereference, address: 0000000000000018
PGD 0 P4D 0
Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
CPU: 8 PID: 659 Comm: kworker/8:1 Tainted: G    B
5.1.0-rc7-next-20190506+ #20
Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40
01/25/2019
Workqueue: events work_for_cpu_fn
RIP: 0010:map_sg+0x297/0x2e0
Call Trace:
 scsi_dma_map+0xc6/0x160
 pqi_raid_submit_scsi_cmd_with_io_request+0x3b4/0x470 [smartpqi]
 pqi_scsi_queue_command+0x791/0xdd0 [smartpqi]
 scsi_queue_rq+0x79c/0x1200
 blk_mq_dispatch_rq_list+0x4dc/0xb70
 blk_mq_sched_dispatch_requests+0x2e1/0x310
 __blk_mq_run_hw_queue+0x128/0x200
 __blk_mq_delay_run_hw_queue+0x2b7/0x2d0
 blk_mq_run_hw_queue+0x127/0x1d0
 blk_mq_sched_insert_request+0x25c/0x320
 __scsi_scan_target+0x14d/0x790
 scsi_scan_target+0x115/0x120
 sas_rphy_add+0x1d1/0x280 [scsi_transport_sas]
 pqi_add_sas_device+0x187/0x1e0 [smartpqi]
 pqi_update_device_list+0x1227/0x1460 [smartpqi]
 pqi_update_scsi_devices+0x755/0x1980 [smartpqi]
 pqi_scan_scsi_devices+0x57/0xf0 [smartpqi]
 pqi_ctrl_init+0x149e/0x14df [smartpqi]
 pqi_pci_probe.cold.49+0x808/0x818 [smartpqi]
 local_pci_probe+0x7a/0xc0
 work_for_cpu_fn+0x2e/0x50
 process_one_work+0x522/0xa10
 worker_thread+0x363/0x5b0
 kthread+0x1d2/0x1f0
 ret_from_fork+0x22/0x40

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/amd_iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 867f8b155000..908f5618fb5c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2578,7 +2578,8 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		s->dma_length   = s->length;
 	}
 
-	domain_flush_np_cache(domain, s->dma_address, s->dma_length);
+	if (s)
+		domain_flush_np_cache(domain, s->dma_address, s->dma_length);
 
 	return nelems;
 
-- 
2.20.1 (Apple Git-117)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

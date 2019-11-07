Return-Path: <SRS0=3PM5=Y7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5977C43331
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 21:12:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9746820869
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 21:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR41t2IH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9746820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 39A75C52;
	Thu,  7 Nov 2019 21:09:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3F801D7A
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 20:59:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CDE2F189
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 20:59:25 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id r18so2727866pgu.13
	for <iommu@lists.linux-foundation.org>;
	Thu, 07 Nov 2019 12:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=nkNlMQRicaTR1gGQNB/Yzp0pHtByBTKEE9yOjF2k1pw=;
	b=LR41t2IHZuly8gLcZ6UlBM3E62/6+qVvM+opJvCHaLiISAgNP1pKb7G2FH2kWI2CdE
	m62M/ay9xo1VTApVdsTieVrf/lBa9CdDoPvCGx72us0Kan781R71Tb6wUUK9XZMelN6m
	uvXvOhSrL0qouhPwru8vpSazs4yzxb8wNNg2mRWIp2IPGsAKMByVmRVg2ucbrM7kZosY
	/IlrpkSSvCmMqK1OpHQyccRlApStn67UsOa4rPX3E+WAo20IBFFz8E8S0/hHV7El00QF
	7AwSNyCipcN7xgYS1R2DLl/jqyKU6ADzOYVN9/jpJLW/HruToxlqjJg9Y1H+wGiownjt
	UvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=nkNlMQRicaTR1gGQNB/Yzp0pHtByBTKEE9yOjF2k1pw=;
	b=XFJOGP/fg8RwpFff/x7J1KCC9fLqZ+mZJMYOMbl7WN+k1ujohrB2A9iMWgyGaWH459
	WF+GFauNqp20C85YEfQjtsbLtNAObPAkO5J+VNcU97EBHHigQsARcGO9pBKMFO3NlOzq
	qS+zhFwoZawK2l0BPbu9YHfy4piM+iokQj1KWxfGlRQPoqmNtehQpWlvcXB5bcHu+jSY
	bDgRhchTD0VVEqkveDcbpr5AU2I1c5vIcjM4a3Lzs37tu8m2V3M9c2y7CcDDFW/nvcmA
	XeeYFSLSlKQj3nK2cIayCaqupSVxzoNEe23cSp67znKVoOz7wz6OkqCs1bg9BlzKFkBD
	r+iQ==
X-Gm-Message-State: APjAAAVCZkAwGYq1yEgUMfrsx0DOm9degYwGDB5FcMEIhLCkB/gvya07
	ShP6IpoeNvKx75IG8pfCUBE=
X-Google-Smtp-Source: APXvYqwzL/Wj+XAOZlYIn/t4S28COF7TlcVY2Id3cPe+aS2hzKfgJzYdRTLmSlib4FIOXFqqF6oyTw==
X-Received: by 2002:a17:90a:bf8d:: with SMTP id
	d13mr8239219pjs.89.1573160365293; 
	Thu, 07 Nov 2019 12:59:25 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net.
	[98.234.52.230]) by smtp.gmail.com with ESMTPSA id
	r68sm3499652pfr.78.2019.11.07.12.59.24
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 07 Nov 2019 12:59:24 -0800 (PST)
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: joro@8bytes.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] intel-iommu: Turn off translations at shutdown
Date: Thu,  7 Nov 2019 12:59:14 -0800
Message-Id: <20191107205914.10611-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Thu, 07 Nov 2019 21:09:42 +0000
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org
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

The intel-iommu driver assumes that the iommu state is
cleaned up at the start of the new kernel.
But, when we try to kexec boot something other than the
Linux kernel, the cleanup cannot be relied upon.
Hence, cleanup before we go down for reboot.

Keeping the cleanup at initialization also, in case BIOS
leaves the IOMMU enabled.

I considered turning off iommu only during kexec reboot,
but a clean shutdown seems always a good idea. But if
someone wants to make it conditional, we can do that.

Tested that before, the info message
'DMAR: Translation was enabled for <iommu> but we are not in kdump mode'
would be reported for each iommu. The message will not appear when the
DMA-remapping is not enabled on entry to the kernel.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 drivers/iommu/intel-iommu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fe8097078669..f0636b263722 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4764,6 +4764,26 @@ static void intel_disable_iommus(void)
 		iommu_disable_translation(iommu);
 }
 
+static void intel_iommu_shutdown(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu = NULL;
+
+	if (no_iommu || dmar_disabled)
+		return;
+
+	down_write(&dmar_global_lock);
+
+	/* Disable PMRs explicitly here. */
+	for_each_iommu(iommu, drhd)
+		iommu_disable_protect_mem_regions(iommu);
+
+	/* Make sure the IOMMUs are switched off */
+	intel_disable_iommus();
+
+	up_write(&dmar_global_lock);
+}
+
 static inline struct intel_iommu *dev_to_intel_iommu(struct device *dev)
 {
 	struct iommu_device *iommu_dev = dev_to_iommu_device(dev);
@@ -5013,6 +5033,8 @@ int __init intel_iommu_init(void)
 	}
 	up_write(&dmar_global_lock);
 
+	x86_platform.iommu_shutdown = intel_iommu_shutdown;
+
 #if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
 	/*
 	 * If the system has no untrusted device or the user has decided
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

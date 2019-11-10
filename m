Return-Path: <SRS0=BeoY=ZC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6A8C17443
	for <iommu@archiver.kernel.org>; Sun, 10 Nov 2019 17:28:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6873320818
	for <iommu@archiver.kernel.org>; Sun, 10 Nov 2019 17:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEjflWg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6873320818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 29101ACC;
	Sun, 10 Nov 2019 17:28:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E3140A95
	for <iommu@lists.linux-foundation.org>;
	Sun, 10 Nov 2019 17:28:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1C283102
	for <iommu@lists.linux-foundation.org>;
	Sun, 10 Nov 2019 17:27:59 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id v19so8829815pfm.3
	for <iommu@lists.linux-foundation.org>;
	Sun, 10 Nov 2019 09:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=NL/gzs9Wq8Zer3EX5e6nZizMDxoHbHho2fV9UzhGuPw=;
	b=uEjflWg7F56k07I9tWbc7PLS2SvR4kwK+DPxx6GmUGXqWvZWpJClz0BGHCpDhfLXlW
	JUE/R0gCukPvAei453bw9ar24BQL63QlDdHjs12NQ/znVz0LglclVasXT/dZuWWBu/op
	5ILOLTPc0aYurQiaMd/B/AePQa2GLlpdBBu+JhNa3/g8AmV8icCGvOUTF2Ip9DBORZ+6
	RAc5SyDGYHIfhtSTccYUsl8lPSBaciXyCXXrDoeLD498NrOWCBciGnhNzQxwqkzXuEog
	5evKnbNN7euWannDo3916T+Q1AaiGdjyQXLJgFctkshjTDPw27hr3kjjdUgT8VE+sRmF
	W1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=NL/gzs9Wq8Zer3EX5e6nZizMDxoHbHho2fV9UzhGuPw=;
	b=Zo9seypHr0eMu/6rbeqcmlo9DY0HZvOg1xqoc9zmFEJmzgoVbpfz1FHEjUd8XkeSrk
	FNLZT50x13XiYUtf+kien5dkhTKdhcINNZORnD3uGuljbi2bUiBC7CHn0SX1H5FimGv3
	RGYCHnrgB45AgOshQcev0HxfZZqNQAXIfFJR0FwLBwU5gVs3bbKPmh1w8hDkHqbe5cIY
	6W0x1He63KTVdGtpMznHHV04ZpH58zIBwez2aiyPKSE8zR6RHWdkutOxVXRdWZesDWqN
	ZZPkcHmvOglD/DT+Jat4YxkZmJlD8kefDbx+FL+TRxPh0fuQQ5TKzFDPcYkWg9Cc1afI
	tQ/w==
X-Gm-Message-State: APjAAAVpLVsASoV38B2goHD/z4MSEFMG7T+pFG+cPAlq1k1L7bDAMViF
	++UOxI10k4knGPIRntKmmlI=
X-Google-Smtp-Source: APXvYqyc4MEaS9GwSiFQTBuEEWtw/IFomlmEWDvdI8WMzmS+zE4C8LD8ORab0YU7t6EI7huZHsCLWQ==
X-Received: by 2002:aa7:9157:: with SMTP id 23mr25366127pfi.61.1573406878505; 
	Sun, 10 Nov 2019 09:27:58 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net.
	[98.234.52.230]) by smtp.gmail.com with ESMTPSA id
	a1sm10588186pjh.25.2019.11.10.09.27.57
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 10 Nov 2019 09:27:57 -0800 (PST)
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: linux-kernel@vger.kernel.org,
	joro@8bytes.org
Subject: [PATCH v2] iommu/vt-d: Turn off translations at shutdown
Date: Sun, 10 Nov 2019 09:27:44 -0800
Message-Id: <20191110172744.12541-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
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

I considered turning off iommu only during kexec reboot, but a clean
shutdown seems always a good idea. But if someone wants to make it
conditional, such as VMM live update, we can do that.  There doesn't
seem to be such a condition at this time.

Tested that before, the info message
'DMAR: Translation was enabled for <iommu> but we are not in kdump mode'
would be reported for each iommu. The message will not appear when the
DMA-remapping is not enabled on entry to the kernel.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
Changes since v1:
* move shutdown registration to iommu detection

 drivers/iommu/dmar.c        |  5 ++++-
 drivers/iommu/intel-iommu.c | 20 ++++++++++++++++++++
 include/linux/dmar.h        |  2 ++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index eecd6a421667..3acfa6a25fa2 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -895,8 +895,11 @@ int __init detect_intel_iommu(void)
 	}
 
 #ifdef CONFIG_X86
-	if (!ret)
+	if (!ret) {
 		x86_init.iommu.iommu_init = intel_iommu_init;
+		x86_platform.iommu_shutdown = intel_iommu_shutdown;
+	}
+
 #endif
 
 	if (dmar_tbl) {
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fe8097078669..7ac73410ba8e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4764,6 +4764,26 @@ static void intel_disable_iommus(void)
 		iommu_disable_translation(iommu);
 }
 
+void intel_iommu_shutdown(void)
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
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index a7cf3599d9a1..f64ca27dc210 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -129,6 +129,7 @@ static inline int dmar_res_noop(struct acpi_dmar_header *hdr, void *arg)
 #ifdef CONFIG_INTEL_IOMMU
 extern int iommu_detected, no_iommu;
 extern int intel_iommu_init(void);
+extern void intel_iommu_shutdown(void);
 extern int dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg);
 extern int dmar_parse_one_atsr(struct acpi_dmar_header *header, void *arg);
 extern int dmar_check_one_atsr(struct acpi_dmar_header *hdr, void *arg);
@@ -137,6 +138,7 @@ extern int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert);
 extern int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info);
 #else /* !CONFIG_INTEL_IOMMU: */
 static inline int intel_iommu_init(void) { return -ENODEV; }
+static inline void intel_iommu_shutdown(void) { }
 
 #define	dmar_parse_one_rmrr		dmar_res_noop
 #define	dmar_parse_one_atsr		dmar_res_noop
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

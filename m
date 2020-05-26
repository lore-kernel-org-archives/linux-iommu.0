Return-Path: <SRS0=1lY2=7I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61300C433E1
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 11:50:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3102E2073B
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 11:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xWP3LMiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3102E2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E291F229D4;
	Tue, 26 May 2020 11:50:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CI6SAOVTJY2a; Tue, 26 May 2020 11:50:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0B57A22BCC;
	Tue, 26 May 2020 11:50:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0420EC088D;
	Tue, 26 May 2020 11:50:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7C56C016F
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 11:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E39DD87BCA
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 11:50:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cwAK+lbkZKRj for <iommu@lists.linux-foundation.org>;
 Tue, 26 May 2020 11:50:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 55ADC87B60
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 11:50:02 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id e11so9127009pfn.3
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 04:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+jiFCKG1lfnYYtqCMQUL0FADyscKoxL3O8Mn7sFVi4U=;
 b=xWP3LMiyXg9WkEiCrpIrQqSQF1pBVUsQ/FYoKllTcxGYHWrOAX4/TKjQGf13lZw580
 kC7tZD5+ouByzCMpq3BjvKl4uV+20ecDjbKIzC7XkeNOtei2O0mO9XfES0omT/1eNKSv
 v7GffipQ1UW17lE2ZPi167S7hV1unlCmvYmV/tqqQoK+cRhJBUuOUVEvwSddusA+1uX1
 5n7mgziqybjr23CBfp1mgDVcBGmdWAPJ/dfkzBfPtpzdv5kR7VVMrqyYLvZD5BCm6FLf
 k+061vIoLAo4EHP+slmxjiehDXFzdkE0279YHy3AU9/dLCDnJ3gjhArclFyuDLHSlO5u
 6iqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+jiFCKG1lfnYYtqCMQUL0FADyscKoxL3O8Mn7sFVi4U=;
 b=GLh6h+92hUxblexvV+/EYIE1vJMs5eIRJRTOmDevX0S4MADTGWEfEgFPy3cFAOugxo
 lnrswXg/cy3mtaLUoAitjbTKr+6xoBPZ/jzQl5pu/f1BGE1tuKJNtkJ+Gseo8swliRHc
 Nx9UVfTjdiXhYfpIuBHCELQY5x6FmqrrIUoUa15hadgVy198JnMdGOOd4h00c6tLHlur
 0frwAk/liqFITfJc6zjs0KdFFaHTq4bUBQTbngeI1XONt5zelqcsxpcOyEUcaDh/cAi0
 2dzV+qOq9ISkZeSlAQKxP9ADXeFyFpfJlc+enU4vJixzs/AsFkgLK5R/pmEM9CMKfPIO
 QiqQ==
X-Gm-Message-State: AOAM530kWR6RnM/N1fw6nxuHy8ADIHPwXlrd3g+/PG2BBHFwd0CT6zkF
 lvr96LXqeNm4IhyRYnmZL36oEIPTSQOspw==
X-Google-Smtp-Source: ABdhPJz/38ANaCZARqziU7c0uO3u8fyzoWL11rla4SWMrBnFZjbOk7LU2LfzTWgFz9APwdcIVXrm+w==
X-Received: by 2002:a63:4a1d:: with SMTP id x29mr671835pga.53.1590493801979;
 Tue, 26 May 2020 04:50:01 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.9])
 by smtp.gmail.com with ESMTPSA id c12sm15586567pjm.46.2020.05.26.04.49.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 May 2020 04:50:01 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 jean-philippe <jean-philippe@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, kenneth-lee-2012@foxmail.com,
 Wangzhou <wangzhou1@hisilicon.com>
Subject: [PATCH 1/2] PCI: Introduce PCI_FIXUP_IOMMU
Date: Tue, 26 May 2020 19:49:08 +0800
Message-Id: <1590493749-13823-2-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
References: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>,
 linux-arm-kernel@lists.infradead.org
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

Some platform devices appear as PCI but are actually on the AMBA bus,
and they need fixup in drivers/pci/quirks.c handling iommu_fwnode.
Here introducing PCI_FIXUP_IOMMU, which is called after iommu_fwnode
is allocated, instead of reusing PCI_FIXUP_FINAL since it will slow
down iommu probing as all devices in fixup final list will be
reprocessed.

Suggested-by: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/pci/quirks.c              | 7 +++++++
 include/asm-generic/vmlinux.lds.h | 3 +++
 include/linux/pci.h               | 8 ++++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ca9ed57..b037034 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -83,6 +83,8 @@ extern struct pci_fixup __start_pci_fixups_header[];
 extern struct pci_fixup __end_pci_fixups_header[];
 extern struct pci_fixup __start_pci_fixups_final[];
 extern struct pci_fixup __end_pci_fixups_final[];
+extern struct pci_fixup __start_pci_fixups_iommu[];
+extern struct pci_fixup __end_pci_fixups_iommu[];
 extern struct pci_fixup __start_pci_fixups_enable[];
 extern struct pci_fixup __end_pci_fixups_enable[];
 extern struct pci_fixup __start_pci_fixups_resume[];
@@ -118,6 +120,11 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
 		end = __end_pci_fixups_final;
 		break;
 
+	case pci_fixup_iommu:
+		start = __start_pci_fixups_iommu;
+		end = __end_pci_fixups_iommu;
+		break;
+
 	case pci_fixup_enable:
 		start = __start_pci_fixups_enable;
 		end = __end_pci_fixups_enable;
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 71e387a..3da32d8 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -411,6 +411,9 @@
 		__start_pci_fixups_final = .;				\
 		KEEP(*(.pci_fixup_final))				\
 		__end_pci_fixups_final = .;				\
+		__start_pci_fixups_iommu = .;				\
+		KEEP(*(.pci_fixup_iommu))				\
+		__end_pci_fixups_iommu = .;				\
 		__start_pci_fixups_enable = .;				\
 		KEEP(*(.pci_fixup_enable))				\
 		__end_pci_fixups_enable = .;				\
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83ce1cd..0d5fbf8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1892,6 +1892,7 @@ enum pci_fixup_pass {
 	pci_fixup_early,	/* Before probing BARs */
 	pci_fixup_header,	/* After reading configuration header */
 	pci_fixup_final,	/* Final phase of device fixups */
+	pci_fixup_iommu,	/* After iommu_fwspec_init */
 	pci_fixup_enable,	/* pci_enable_device() time */
 	pci_fixup_resume,	/* pci_device_resume() */
 	pci_fixup_suspend,	/* pci_device_suspend() */
@@ -1934,6 +1935,10 @@ enum pci_fixup_pass {
 					 class_shift, hook)		\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,			\
 		hook, vendor, device, class, class_shift, hook)
+#define DECLARE_PCI_FIXUP_CLASS_IOMMU(vendor, device, class,		\
+					 class_shift, hook)		\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_iommu,			\
+		hook, vendor, device, class, class_shift, hook)
 #define DECLARE_PCI_FIXUP_CLASS_ENABLE(vendor, device, class,		\
 					 class_shift, hook)		\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_enable,			\
@@ -1964,6 +1969,9 @@ enum pci_fixup_pass {
 #define DECLARE_PCI_FIXUP_FINAL(vendor, device, hook)			\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,			\
 		hook, vendor, device, PCI_ANY_ID, 0, hook)
+#define DECLARE_PCI_FIXUP_IOMMU(vendor, device, hook)			\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_iommu,			\
+		hook, vendor, device, PCI_ANY_ID, 0, hook)
 #define DECLARE_PCI_FIXUP_ENABLE(vendor, device, hook)			\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_enable,			\
 		hook, vendor, device, PCI_ANY_ID, 0, hook)
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

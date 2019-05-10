Return-Path: <SRS0=MPmd=TK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FC3C04AB3
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 15:25:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D042053B
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 15:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Vse51UYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D042053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E208FDCF;
	Fri, 10 May 2019 15:25:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B6E04DBC
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 15:25:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
	[209.85.160.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2B450831
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 15:25:34 +0000 (UTC)
Received: by mail-qt1-f194.google.com with SMTP id i31so6966804qti.13
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=rD6wdEZSwVm7gTO6Zc262W7xf6pRwKIUW1NU/7rGn2A=;
	b=Vse51UYSyy1ghsiglgXF6RW3/8/qDVh6OS4BH4EjjM9jjMD+8CXA1py2GPvl3A017T
	uL6orKa2PgLUA3X4ixVWlrQTLHP+6u3csJPPLltnFLsvDacPuKzH5qoxcN9o5EqrEnmB
	GaKetGi6OWFI/Nedw3bwFPy+HkbaZC3hCIlBvD+HzafpNGmSCwgVDsH3pCahZsSbD+XZ
	mK+rPQftwxIxDiq4xJdD+W8fNtsG/manQvMDu3es0iNrf9bzAjPxCAF5+u35qi9q1PMu
	zys2cKRQuaJ7djrq/jjNFpKYnwyps9KaVAq4t3XC4rLft4Jli+wns2VVK+GNQx70ud4K
	uTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=rD6wdEZSwVm7gTO6Zc262W7xf6pRwKIUW1NU/7rGn2A=;
	b=Zg2kWn+ESpbCZXVwreh86HE2uG3pRGttAwelH7xyF3KVoWplhes6VQGPI5DITMiNG5
	x8fHgK7gc787lGVUx8+YAlksMAbzSjGntOf8JAHzeWrXRB9gi1ZFlDU2JbQmE5WhrYut
	7QAGVMn2xFZI+IwtIOaKoI/bOQK1VDGuJlphkuZvedgMJW7hpS+fttpV3dLGieF9sSS6
	DjzJ55VCcnfdW4UhxsEyNMd7U32N4Qj8z8Qgzu23gYCQc/f3XsiHPMLgQdxELU+lLBZm
	f/x7ovNhJNO5U6rUz/icAAFHbN2RcBXUFvhQctvMlGLDQSXPerrxgRMCQiO6OLkC2BlV
	3CQA==
X-Gm-Message-State: APjAAAWdo1qM2F/YDrCHq1ezGsAysjDGKkpDUgavrOvt2Ak/XBZ/ymDH
	XVt9QEcR5wFRVHAfSMqPb3WRmA==
X-Google-Smtp-Source: APXvYqx3J0ym1yQz+Vzeb3MzyXSoo3lAxbtNWwkgNoOay9pH4FboDbP/qAzIr+xyoTJRauMSCqESPQ==
X-Received: by 2002:aed:354c:: with SMTP id b12mr10389906qte.251.1557501933144;
	Fri, 10 May 2019 08:25:33 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
	by smtp.gmail.com with ESMTPSA id s7sm3037983qkg.70.2019.05.10.08.25.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:25:32 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Subject: [PATCH] iommu/intel: fix variable 'iommu' set but not used
Date: Fri, 10 May 2019 11:25:07 -0400
Message-Id: <1557501907-6450-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Cc: Qian Cai <cai@lca.pw>, iommu@lists.linux-foundation.org,
	dwmw2@infradead.org, linux-kernel@vger.kernel.org
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

The commit cf04eee8bf0e ("iommu/vt-d: Include ACPI devices in iommu=pt")
added for_each_active_iommu() in iommu_prepare_static_identity_mapping()
but never used the each element, i.e, "drhd->iommu".

drivers/iommu/intel-iommu.c: In function
'iommu_prepare_static_identity_mapping':
drivers/iommu/intel-iommu.c:3037:22: warning: variable 'iommu' set but not
used [-Wunused-but-set-variable]
  struct intel_iommu *iommu;

Fixed the warning by passing "drhd->iommu" directly to
for_each_active_iommu() which all subsequent self-assignments should be
ignored by a compiler anyway.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a209199f3af6..86e1ddcb4a8e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3034,7 +3034,6 @@ static int __init iommu_prepare_static_identity_mapping(int hw)
 {
 	struct pci_dev *pdev = NULL;
 	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
 	struct device *dev;
 	int i;
 	int ret = 0;
@@ -3045,7 +3044,7 @@ static int __init iommu_prepare_static_identity_mapping(int hw)
 			return ret;
 	}
 
-	for_each_active_iommu(iommu, drhd)
+	for_each_active_iommu(drhd->iommu, drhd)
 		for_each_active_dev_scope(drhd->devices, drhd->devices_cnt, i, dev) {
 			struct acpi_device_physical_node *pn;
 			struct acpi_device *adev;
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

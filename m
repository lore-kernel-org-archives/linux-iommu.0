Return-Path: <SRS0=VKv6=TW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7761C282CE
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 20:37:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6E920821
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 20:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HkD1qDnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6E920821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2257DACC;
	Wed, 22 May 2019 20:37:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 00576ACC
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 20:37:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
	[209.85.160.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 56B595D0
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 20:37:07 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id a17so4111824qth.3
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 13:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=DDEc493zRRlIzxUABdOKVz8yZe5OqF7VHlzAHj5qgck=;
	b=HkD1qDnPggcknOVzuyXItIMGjUV7me9Zi8Vwtpvs+Um5+AFZ9Q1zQ2gPUyHNB7vAgM
	Js8drHBrwL9CchGi9PVmV/G4CGVAfBIkuWEUxvWo3bi5+Td4egvLTrqRKqeNySwHVAzr
	PuVf7clTGSp/Vn5yBjTOCFVWAS2moFTjeF0hQl2MVbbrKINN5stXEScQU2GsAq1PDQ6u
	5WnrsGzxPtBal9RVXslCFrc/3NhG5fCjV3YLlrGTlDFv7kTXxLadoavrU+0wmiKSydgx
	xpQ5XFmJdtp9dqWiMft6z4rd+jYkY3X62rVSZsYBsT7nR5pgQgaDdhUF0aLvay4D8CRT
	qIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=DDEc493zRRlIzxUABdOKVz8yZe5OqF7VHlzAHj5qgck=;
	b=hkUqs5vSNqQ1k6sdZhHmD6s6tsBY3wMOqzzAvEZkUtUqoZ20sDRxGvrqIZWl7mtKHj
	PrTTP9npOZ327TNJHTR3VLNYsu2pcAbADxszXzNV1R4kQo3/ztkdim+i15xDP6LUjJXq
	V5lZmTmKf8GBqnw3t0hMdFtiL1m9v2/Tz4Y17Hw9uoS5SSl8wI/Yh/vaGtXW/drunPGG
	PFebftajhiwgtHQvaPzkSezs4myIauEie9dPE7m6Rkf4JqpgSdIj82WPjKD0COQ9IXD/
	LL/3UFkXXMArBI8oW6HfPDILvPsjD8Sk0Drh2WhQXWp9DDZ/cJRDw2iK3dGurE3f1vDe
	gt/w==
X-Gm-Message-State: APjAAAV5KmliQMN4hMdyVOgxW1TG80TTjaN8LGAjaR0xPdA+5sstoojP
	cr3P0F/Fqu2/pZeeYvUgWnCDVQ==
X-Google-Smtp-Source: APXvYqwMYhS0u5PhrONFf+mvi1pBgngqWhuTqFo2JraK7yCZuFqDmAVoYIt4h+YtfkFs6KwzsgZsdw==
X-Received: by 2002:ac8:2617:: with SMTP id u23mr75957842qtu.141.1558557426395;
	Wed, 22 May 2019 13:37:06 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
	by smtp.gmail.com with ESMTPSA id f9sm7013886qkb.97.2019.05.22.13.37.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 13:37:05 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: akpm@linux-foundation.org
Subject: [RESEND PATCH] iommu/intel: fix variable 'iommu' set but not used
Date: Wed, 22 May 2019 16:36:26 -0400
Message-Id: <1558557386-17160-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Cc: Qian Cai <cai@lca.pw>, iommu@lists.linux-foundation.org, jroedel@suse.de,
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
drivers/iommu/intel-iommu.c:3037:22: warning: variable 'iommu' set but
not used [-Wunused-but-set-variable]
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

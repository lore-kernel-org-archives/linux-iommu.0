Return-Path: <SRS0=6gDp=FO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF79EC433FE
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 02:13:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B2222A99
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 02:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B2222A99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C0971879A1;
	Thu, 10 Dec 2020 02:13:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z0Iu-jOJbPxa; Thu, 10 Dec 2020 02:13:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DCD2887A85;
	Thu, 10 Dec 2020 02:13:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE522C0FA7;
	Thu, 10 Dec 2020 02:13:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A35CDC013B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 02:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8802C204A7
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 02:13:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zRm9N+Zdp4K3 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 02:13:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 06C8B2049D
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 02:13:51 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id e2so2755310pgi.5
 for <iommu@lists.linux-foundation.org>; Wed, 09 Dec 2020 18:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=RvFbA4ErJMqYlH9Js56oIq8vsqszuPb9uU/s12PrRO4=;
 b=tDzClEbj48YLQQ+OsPsgV/x4LE/iyVGvbtxxGOt/Qw8j7Z4YFh1HKXFKFFKXFV/biN
 gNiw8jgfsIhLvHqV+mGkuRY9OSceMKzu8NLpCuVwV065C9g1mBqs2fGiK7oDEloSPGIw
 KguCa+JycdOvUstMGMKwv/ZdCf67amzfjODwyl+I34ozKrCkzlPHfIW26OFPk29shziS
 scUyD8vWx48dh9YtbXaHiNZPH6hdjsgpHWsXsGTePnNEj5ZfUHpdCLrmIEMyLcrcIwF/
 WZ1uP1FYabHf/NGDd77H0X3PvsTfoAslRfALkT1zaEM026WvS1H7ps62b45NpxxpAYT1
 BkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=RvFbA4ErJMqYlH9Js56oIq8vsqszuPb9uU/s12PrRO4=;
 b=Xx6C+ici64gVUIfJTn5G9cYztSagXIxeZk99njIKFJI/ycNnUuCempneeaqhPW/YSj
 gyS6xILyWsEyHkmzTq8LdGDVVuruVnpSMCONNINfNiOspATw29oztSvXRuFQlOnlgKBD
 FMBp5j/2TFdflRkxxAzlL0mEyLHnMm6A8LrS4HMYIYrtBHM9PJEur5b8ZHPGMNQEE6TZ
 LlmmVhxEZTwRbZFhvqU7cW416oRQoBpdvQrhdEpr0zVB3HIalnCvqMWqNNwx4htfyjuD
 uYd8TrvDihH0ikSVEuY8N6O03ROBI0Su9d9spVMw+QcJSTxRPMbA6Oo/IvAf7L11aaTw
 Qqbg==
X-Gm-Message-State: AOAM531Y/AZuRKNA9BJHxkU+/YjAbDMdlOCtcr7eSAXAeywh1qDNg2ft
 6V/zczPu1C8fdfuvjsRm5yw=
X-Google-Smtp-Source: ABdhPJwqeEP87gh21Ajzb1cRxOLTq4ugQGuuxohnpvVfxnOkxuGwTgi1xgHK0HMKLjahodSx3ydy7Q==
X-Received: by 2002:aa7:97bc:0:b029:19e:18c7:76b with SMTP id
 d28-20020aa797bc0000b029019e18c7076bmr4809748pfq.23.1607566430634; 
 Wed, 09 Dec 2020 18:13:50 -0800 (PST)
Received: from AHUANG12-1LT7M0.lenovo.com
 (220-142-214-33.dynamic-ip.hinet.net. [220.142.214.33])
 by smtp.gmail.com with ESMTPSA id nk11sm3680849pjb.26.2020.12.09.18.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Dec 2020 18:13:50 -0800 (PST)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [RESEND PATCH 1/1] iommu/amd: Remove unnecessary assignment
Date: Thu, 10 Dec 2020 10:13:30 +0800
Message-Id: <20201210021330.2022-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: Adrian Huang <ahuang12@lenovo.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

From: Adrian Huang <ahuang12@lenovo.com>

From: Adrian Huang <ahuang12@lenovo.com>

The values of local variables are assigned after local variables
are declared, so no need to assign the initial value during the
variable declaration.

And, no need to assign NULL for the local variable 'ivrs_base'
after invoking acpi_put_table().

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/iommu/amd/init.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 23a790f8f550..103cbf8fc2d9 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1916,7 +1916,7 @@ static void print_iommu_info(void)
 static int __init amd_iommu_init_pci(void)
 {
 	struct amd_iommu *iommu;
-	int ret = 0;
+	int ret;
 
 	for_each_iommu(iommu) {
 		ret = iommu_init_pci(iommu);
@@ -2555,8 +2555,8 @@ static void __init free_dma_resources(void)
 static int __init early_amd_iommu_init(void)
 {
 	struct acpi_table_header *ivrs_base;
+	int i, remap_cache_sz, ret;
 	acpi_status status;
-	int i, remap_cache_sz, ret = 0;
 	u32 pci_id;
 
 	if (!amd_iommu_detected)
@@ -2698,7 +2698,6 @@ static int __init early_amd_iommu_init(void)
 out:
 	/* Don't leak any ACPI memory */
 	acpi_put_table(ivrs_base);
-	ivrs_base = NULL;
 
 	return ret;
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

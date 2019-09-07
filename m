Return-Path: <SRS0=yK3q=XC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794AEC43331
	for <iommu@archiver.kernel.org>; Sat,  7 Sep 2019 08:46:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371EB21835
	for <iommu@archiver.kernel.org>; Sat,  7 Sep 2019 08:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhSK200g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371EB21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DAB13113B;
	Sat,  7 Sep 2019 08:46:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BC92CE6E
	for <iommu@lists.linux-foundation.org>;
	Sat,  7 Sep 2019 06:50:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
	[209.85.214.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 68ADA7DB
	for <iommu@lists.linux-foundation.org>;
	Sat,  7 Sep 2019 06:50:10 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id t1so4214440plq.13
	for <iommu@lists.linux-foundation.org>;
	Fri, 06 Sep 2019 23:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=kwp9WuvkrEL8jVtX170pum2/pJAOlFceUeeYECa5DR8=;
	b=OhSK200gWoqCgvjb7rUV/o1/KsW4SZI3dUvM8X8z1I136cOSjftgT8+sgEUHRjXuJt
	eSw/6gmND0mYNHxEISSRqh3PHN6FXnZQXFsbM6hfqSnRbHmdmJc1a8JAFRwya/ERlShx
	rWScCL6jAAr9BD2E4rvmrD360Bm7qOmLScu4AjclcnDgblm35ay8ax8YYTFNdaINkWAZ
	MgyHqoZVBSvXMQN0GzbEFIU+GpHlb5nR+8z/9S123i35nLLkmZFgErIp0kBakUZfqdlA
	vz7dl32GwbM18gFMNzt83+yKwjx47GCNAPdEnXkdoZD2LS1jxp7QeFyCH8Y/nZnLUBn2
	gi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=kwp9WuvkrEL8jVtX170pum2/pJAOlFceUeeYECa5DR8=;
	b=ay3hmRD7iac2iQoqeY8WVAj1oXacx5s9vCbY3Qk7WUC2dpzet4abk+vVBC5doQ4Oco
	37DaQOQ7dq/nru55X1uFRq9Z58crPuS5UY8Lg/T3kzNFvSnetHsboLnReb+Cx1pGq6SF
	viRSPD0THbts/KsA73vQqndcDuPEWBlHcq+i3KZCtMkNthu/30XfuRQWwJgUIgVia3Ra
	MIpOmWnuGl5UhpnU/epvsWwVJ55L2C+nQ+ZfQu9XNNMRMsytPofPuHvqVZz0R/VgbOsK
	htxZtBk3mRFve34fyVT+Li5EU7+qSOYtBPfwjH6iXdTciCSoIBQ7pEHiCSO2lWslDcuw
	oYpA==
X-Gm-Message-State: APjAAAX+3z3ZevzEMFKtFokCTEZA9YjPOC5cmG0Db2ypQ09m26ICiL74
	F4HNij8o2P2dzP0YwgCnU3I=
X-Google-Smtp-Source: APXvYqyHuT5yqPEoMdCwrX3mmO3F6hkGQIxjoAyArLlbAni6f0VdZzQupTzQyi25etqfjDOsClLEzw==
X-Received: by 2002:a17:902:8507:: with SMTP id
	bj7mr13400386plb.210.1567839009945; 
	Fri, 06 Sep 2019 23:50:09 -0700 (PDT)
Received: from localhost.localdomain (ip-103-85-38-221.syd.xi.com.au.
	[103.85.38.221]) by smtp.gmail.com with ESMTPSA id
	k95sm7720560pje.10.2019.09.06.23.50.07
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 06 Sep 2019 23:50:09 -0700 (PDT)
From: Adam Zerella <adam.zerella@gmail.com>
To: 
Subject: [PATCH] iommu/vt-d: Make function signatures static
Date: Sat,  7 Sep 2019 16:49:33 +1000
Message-Id: <20190907064933.15277-1-adam.zerella@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 07 Sep 2019 08:46:16 +0000
Cc: dwmw2@infradead.org, iommu@lists.linux-foundation.org,
	adam.zerella@gmail.com
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

warning: symbol 'intel_iommu_gfx_mapped' was not declared. Should it be static?
warning: symbol 'intel_iommu_ops' was not declared. Should it be static?

Squash a couple of Sparse warnings by making these symbols static.

Signed-off-by: Adam Zerella <adam.zerella@gmail.com>
---
 drivers/iommu/intel-iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 12d094d08c0a..28134891fa9c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -365,7 +365,7 @@ static int iommu_identity_mapping;
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
 
-int intel_iommu_gfx_mapped;
+static int intel_iommu_gfx_mapped;
 EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 
 #define DUMMY_DEVICE_DOMAIN_INFO ((struct device_domain_info *)(-1))
@@ -397,7 +397,7 @@ int for_each_device_domain(int (*fn)(struct device_domain_info *info,
 	return 0;
 }
 
-const struct iommu_ops intel_iommu_ops;
+static const struct iommu_ops intel_iommu_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
 {
@@ -5613,7 +5613,7 @@ static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
 	return dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO;
 }
 
-const struct iommu_ops intel_iommu_ops = {
+static const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_free		= intel_iommu_domain_free,
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

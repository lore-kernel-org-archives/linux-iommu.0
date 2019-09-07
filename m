Return-Path: <SRS0=yK3q=XC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5D9C43331
	for <iommu@archiver.kernel.org>; Sat,  7 Sep 2019 08:46:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722BF21835
	for <iommu@archiver.kernel.org>; Sat,  7 Sep 2019 08:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf5Doi01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722BF21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 10531117E;
	Sat,  7 Sep 2019 08:46:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C8BE4EB8
	for <iommu@lists.linux-foundation.org>;
	Sat,  7 Sep 2019 06:58:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
	[209.85.210.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6B29D7DB
	for <iommu@lists.linux-foundation.org>;
	Sat,  7 Sep 2019 06:58:50 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id d15so6011049pfo.10
	for <iommu@lists.linux-foundation.org>;
	Fri, 06 Sep 2019 23:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=N02a6SJaJeYR37VzYoDKnadMvJWEcIznSEEE8d04rEE=;
	b=Qf5Doi01nKGhv7f3si1yFpTepVFa5JxTA2UqN4wP/dJfHftsEloVB6XKK3GcM3XAb7
	DP72ege/1iO6QSzha/ans+5zh7VXW1IoGl6ru0NjcSJ4KAulwjSVtX8RH9IA2qkSf8jF
	Rg1kxlu6nJdi5J2k14OrCtUPhAknHidGbUcpdiX/9ZuHJjWzEb9cysmjzNdYZOv0uI4n
	pci+Nj2TvS2sXpqAWZC3fezKdHLT91bJaXmdYYICCvg+42gh8Yo5wpUNSwX6QfidBZCT
	slQvr9BAsKuL/rqoY6Aa3RHLQXBVAd8F7Q0pRg6GVmgJu/+0d8yxUzJrm1i1zfUhXyrj
	QSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=N02a6SJaJeYR37VzYoDKnadMvJWEcIznSEEE8d04rEE=;
	b=eaBFc1dNj8sShyPg+azyPBGvuqk4G1iA1jxduYP56NI0gwuZ455chPNVSbFAB5J/W+
	QBzMCUXWEj57AfKuiFaY+l0DsjHw7HgtnpLW2/pmEhw/F/xc/uISIHFu3ncQU1M7L3Bs
	XbaQ0bHBo2YM98kvWDjKnvfrvfSrJ0tiLDYazhqJBhguIfmzthpFOt6+gRiL+eT8Wwzm
	iyBWqbvl7bbsmTkHxFzct1xCpCtxskVy22lLmIQ8RgybyfsFZcyIeeRK+36tNtZZt6/L
	mzIfz7sKXIgtEj7Ou3oDT6Gg4zwTQHHGyg9qMy9zHf2u4SNOHVxl+vCHv9d5Ro9lCHTf
	6Fmg==
X-Gm-Message-State: APjAAAVOe44ZlTlklwoiw3C/mlUyAOjnwU6pGYpBo9QhVRsXM2b/e/+n
	xQTlZch3DAsL2E1TDUn5MtI=
X-Google-Smtp-Source: APXvYqxOOt+yaEGgywJTK0jRWElyhevOBHqFAv/XWvIyqlht6wV30m4joc2tTqddtHjKRYjKSOGIxw==
X-Received: by 2002:a63:484d:: with SMTP id x13mr11267132pgk.122.1567839529962;
	Fri, 06 Sep 2019 23:58:49 -0700 (PDT)
Received: from localhost.localdomain (ip-103-85-38-221.syd.xi.com.au.
	[103.85.38.221]) by smtp.gmail.com with ESMTPSA id
	l31sm10084629pgm.63.2019.09.06.23.58.47
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 06 Sep 2019 23:58:49 -0700 (PDT)
From: Adam Zerella <adam.zerella@gmail.com>
To: 
Subject: [PATCH] iommu/amd: Fix sparse warnings
Date: Sat,  7 Sep 2019 16:58:12 +1000
Message-Id: <20190907065812.19505-1-adam.zerella@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 07 Sep 2019 08:46:16 +0000
Cc: adam.zerella@gmail.com, iommu@lists.linux-foundation.org,
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

There was some simple Sparse warnings related to making some
signatures static.

Signed-off-by: Adam Zerella <adam.zerella@gmail.com>
---
 drivers/iommu/amd_iommu.c      |  4 ++--
 drivers/iommu/amd_iommu_init.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b607a92791d3..a9e40001720a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -84,7 +84,7 @@ LIST_HEAD(acpihid_map);
  * Domain for untranslated devices - only allocated
  * if iommu=pt passed on kernel cmd line.
  */
-const struct iommu_ops amd_iommu_ops;
+static const struct iommu_ops amd_iommu_ops;
 
 static ATOMIC_NOTIFIER_HEAD(ppr_notifier);
 int amd_iommu_max_glx_val = -1;
@@ -3201,7 +3201,7 @@ static void amd_iommu_iotlb_range_add(struct iommu_domain *domain,
 {
 }
 
-const struct iommu_ops amd_iommu_ops = {
+static const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.domain_free  = amd_iommu_domain_free,
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 4413aa67000e..f32627cadfd7 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -3050,7 +3050,7 @@ bool amd_iommu_v2_supported(void)
 }
 EXPORT_SYMBOL(amd_iommu_v2_supported);
 
-struct amd_iommu *get_amd_iommu(unsigned int idx)
+static struct amd_iommu *get_amd_iommu(unsigned int idx)
 {
 	unsigned int i = 0;
 	struct amd_iommu *iommu;
@@ -3069,7 +3069,7 @@ EXPORT_SYMBOL(get_amd_iommu);
  *
  ****************************************************************************/
 
-u8 amd_iommu_pc_get_max_banks(unsigned int idx)
+static u8 amd_iommu_pc_get_max_banks(unsigned int idx)
 {
 	struct amd_iommu *iommu = get_amd_iommu(idx);
 
@@ -3080,13 +3080,13 @@ u8 amd_iommu_pc_get_max_banks(unsigned int idx)
 }
 EXPORT_SYMBOL(amd_iommu_pc_get_max_banks);
 
-bool amd_iommu_pc_supported(void)
+static bool amd_iommu_pc_supported(void)
 {
 	return amd_iommu_pc_present;
 }
 EXPORT_SYMBOL(amd_iommu_pc_supported);
 
-u8 amd_iommu_pc_get_max_counters(unsigned int idx)
+static u8 amd_iommu_pc_get_max_counters(unsigned int idx)
 {
 	struct amd_iommu *iommu = get_amd_iommu(idx);
 
@@ -3135,7 +3135,7 @@ static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 	return 0;
 }
 
-int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64 *value)
+static int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64 *value)
 {
 	if (!iommu)
 		return -EINVAL;
@@ -3144,7 +3144,7 @@ int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64
 }
 EXPORT_SYMBOL(amd_iommu_pc_get_reg);
 
-int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64 *value)
+static int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64 *value)
 {
 	if (!iommu)
 		return -EINVAL;
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F0CC4727F
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 06:19:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D82B920C09
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 06:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5d9C8QP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82B920C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7E5CC86F8A;
	Tue, 29 Sep 2020 06:19:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id THZJ0IOPi88d; Tue, 29 Sep 2020 06:18:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E7ABB86FCF;
	Tue, 29 Sep 2020 06:18:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4663C0889;
	Tue, 29 Sep 2020 06:18:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F3F7C0051
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 06:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6EB40844A1
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 06:18:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6jPyCMnhZlsZ for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:18:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DC3B884499
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 06:18:55 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id 7so2992832pgm.11
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 23:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7/FgS/Bu4Sm/fvo7Kw9FiL37U/scbZL5l1h7O/ec2LY=;
 b=u5d9C8QP7pX6TR4cjb2BXigfMhHFBN/IE37xTN/FotpT2LDHCf7xdI/v5ncgR/Qio7
 ijuWo0LqrkynH1CZLhUvG8MLopNAWs4rIXBluF84oqMpicliVKqQw6fjNseSjlOhruwM
 yvIntkub8J8LKMMVQq0f4pl6iQx5tinvDvq5y7HdXBmrvnNqIyFCCn2TvEg/Ig+ua7Q3
 KOwBSlB/seahfVqeo0NbYgaXTovchyVFTiR5PEhQt4dSfFS2sxxv57VH5YNYWJoYDq0u
 ESe4wN3RxKxFgWBsNakhLy4jnUaP2hO/kBx3VUI05XCXIUBQIBVxFy/TeU2Hjrnpiu4A
 /4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7/FgS/Bu4Sm/fvo7Kw9FiL37U/scbZL5l1h7O/ec2LY=;
 b=jAl07moEPNuip81Xo6UgRszYAjCAP/600070CwpywBa4qOzZadvs6n6dShSu3zctmt
 FpeK03yXJWfFHuFkPwXtyHtZ7jw2O5m0vJGYNTVZK9RY22uRIdbK/ccdEsCCQEILas4q
 YSSV/O/VjtwlWNz0N+Yym1FRdVuEL+LemrIcTy1GgEKx98aWE/9I3c9aQ7pFZD8lboHu
 oVdzTyDn9vqE/U4zR+w0z8s9xkXveMIwNL5ahthGipxcQgu3nc8Btk/2tAxE7I0nTzis
 ju2jdLHuMSlbwpzi41k/Yan7sM4OUpGrk5ZVc1gaCdBiuNbSLh7swKXY/cp0Cp8tC+SC
 ilkg==
X-Gm-Message-State: AOAM53344KlR4aayxy6JZaTV4jLqefOiFdzGYY4MaEqbzBT9sF5xcqlX
 l1RFGSp4E4sfhx0xsOr2b00=
X-Google-Smtp-Source: ABdhPJxGI4JOU4vSr3MJXdzYNl+0jiOTY4oc4TF9Hm7jf+DDZR02RKXue3xKWNYtOdHYTa75l60wiw==
X-Received: by 2002:a63:f70e:: with SMTP id x14mr2039284pgh.407.1601360335436; 
 Mon, 28 Sep 2020 23:18:55 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id cf7sm3280562pjb.52.2020.09.28.23.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 23:18:55 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org
Subject: [PATCH v4 1/2] iommu/tegra-smmu: Unwrap tegra_smmu_group_get
Date: Mon, 28 Sep 2020 23:13:24 -0700
Message-Id: <20200929061325.10197-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929061325.10197-1-nicoleotsuka@gmail.com>
References: <20200929061325.10197-1-nicoleotsuka@gmail.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, hch@infradead.org, linux-tegra@vger.kernel.org,
 digetx@gmail.com
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

The tegra_smmu_group_get was added to group devices in different
SWGROUPs and it'd return a NULL group pointer upon a mismatch at
tegra_smmu_find_group(), so for most of clients/devices, it very
likely would mismatch and need a fallback generic_device_group().

But now tegra_smmu_group_get handles devices in same SWGROUP too,
which means that it would allocate a group for every new SWGROUP
or would directly return an existing one upon matching a SWGROUP,
i.e. any device will go through this function.

So possibility of having a NULL group pointer in device_group()
is upon failure of either devm_kzalloc() or iommu_group_alloc().
In either case, calling generic_device_group() no longer makes a
sense. Especially for devm_kzalloc() failing case, it'd cause a
problem if it fails at devm_kzalloc() yet succeeds at a fallback
generic_device_group(), because it does not create a group->list
for other devices to match.

This patch simply unwraps the function to clean it up.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Changelog
v2->v4:
 * N/A
v1->v2:
 * Changed type of swgroup to "unsigned int", following Thierry's
   commnets.

 drivers/iommu/tegra-smmu.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 0becdbfea306..ec4c9dafff95 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -903,10 +903,12 @@ static void tegra_smmu_group_release(void *iommu_data)
 	mutex_unlock(&smmu->lock);
 }
 
-static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
-						unsigned int swgroup)
+static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
 	const struct tegra_smmu_group_soc *soc;
+	unsigned int swgroup = fwspec->ids[0];
 	struct tegra_smmu_group *group;
 	struct iommu_group *grp;
 
@@ -950,19 +952,6 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 	return group->group;
 }
 
-static struct iommu_group *tegra_smmu_device_group(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
-	struct iommu_group *group;
-
-	group = tegra_smmu_group_get(smmu, fwspec->ids[0]);
-	if (!group)
-		group = generic_device_group(dev);
-
-	return group;
-}
-
 static int tegra_smmu_of_xlate(struct device *dev,
 			       struct of_phandle_args *args)
 {
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=5fq6=XW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4147C4360C
	for <iommu@archiver.kernel.org>; Fri, 27 Sep 2019 09:10:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC562146E
	for <iommu@archiver.kernel.org>; Fri, 27 Sep 2019 09:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrzA0dAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC562146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8043E1285;
	Fri, 27 Sep 2019 09:10:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4E792129F
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 09:10:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7DCEC8BD
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 09:09:58 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id v8so1852662wrt.2
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=hM8YfKOj/veQZGpRjHkC1Z8EKmrCYB/PVErpOmpXBBM=;
	b=CrzA0dAfHvZNmbLRvm4lFR17eWd8Ghg2Klbm9BaaXYu1POcOkS1OHFsrjrHsBrnVWX
	yIWdxL8VdDKercQrGymD4aV/jShY/crNRlpatpYEL+IjKsq79dBlJdTLSOAjd3fi11Fi
	xX/BPI7UGr0U1EgqSSXr/dr9h/74QYj2jrlzmMGLh8KRTHP6W6WzzgbPw7cV6KGe2jrb
	1lmPAkoV58ENLjpDQsdCj4s//IYVsaHLXchfilnocklqSEDUu8adyFPigDCQSo4D8s/6
	LuPeoNREXq/jkAZ2jeNJno3F6XdR1d4mARXCKVO8+ldY/YnUMLnfNFXrn8qTXv193Ofz
	cJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=hM8YfKOj/veQZGpRjHkC1Z8EKmrCYB/PVErpOmpXBBM=;
	b=X31cjDQvPYzo8F5OvwKK2oMHrLP0kl7pGVaspydPiL9QSZspz3TFboFTqkCKC41boA
	gmCTlZgxooWX86ASHOC3mW7K4lkphGBD9gPfw098XIGDpBLv4Jw2ChNiUl5NNQb1s6cF
	o0kDjpOwWNlMHe8kkNk2ilVupvu0cJnfMVX47G7dOU6Vn0Uo3K/Rws6fn90JVwGRf3PN
	HWRVVrlw/7dYZpjpANuWyhjbxG8uiLib7On/wYM9pO3N0Wd7DN3mnOgMq1KtQv/1l0TH
	2zJAyNL0Qi1SWmd1bHsF/ajcKeUMYhBPgdq8yg3EjrToOC9am9i1DwoK9xBh35f9poLd
	px2A==
X-Gm-Message-State: APjAAAW8/etfEwDjd6NlE//lpShMMpUhc7JIcwF4xdNgm8dG3H6KBHMA
	21TzrD9uyQPLktGUFM+B0P3bn1uytyI=
X-Google-Smtp-Source: APXvYqxCPVPtme/YWFWgASY/x3e6HTbdBDsmgmYFg3JZUApCu1I6Fv1JhMVs2di/I7KdPoLmWNxjpA==
X-Received: by 2002:a5d:4491:: with SMTP id j17mr1982358wrq.257.1569575396956; 
	Fri, 27 Sep 2019 02:09:56 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([93.51.16.173])
	by smtp.gmail.com with ESMTPSA id
	b62sm6037791wmc.13.2019.09.27.02.09.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 27 Sep 2019 02:09:56 -0700 (PDT)
From: kholk11@gmail.com
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 5/6] iommu/qcom: Index contexts by asid number to allow
	asid 0
Date: Fri, 27 Sep 2019 11:09:46 +0200
Message-Id: <20190927090947.11175-6-kholk11@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927090947.11175-1-kholk11@gmail.com>
References: <20190927090947.11175-1-kholk11@gmail.com>
MIME-Version: 1.0
Cc: marijns95@gmail.com, iommu@lists.linux-foundation.org, agross@kernel.org,
	AngeloGioacchino Del Regno <kholk11@gmail.com>
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

From: AngeloGioacchino Del Regno <kholk11@gmail.com>

This driver was indexing the contexts by asid-1, which is probably
done under the assumption that the first ASID is always 1.

Unfortunately this is not entirely true: at least in the MSM8956
and MSM8976 GPU IOMMU, the gpu_user context's ASID number is zero.
To allow using an asid number of zero, stop indexing the contexts
by asid-1 and rather index them by asid.

Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
---
 drivers/iommu/qcom_iommu.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 233ef496af27..03c68fe9439b 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -49,7 +49,7 @@ struct qcom_iommu_dev {
 	u32			 sec_id;
 	u8			 num_ctxs;
 	bool			 use_aarch64_pt;
-	struct qcom_iommu_ctx	*ctxs[0];   /* indexed by asid-1 */
+	struct qcom_iommu_ctx	*ctxs[0];   /* indexed by asid */
 };
 
 struct qcom_iommu_ctx {
@@ -87,7 +87,7 @@ static struct qcom_iommu_ctx * to_ctx(struct iommu_fwspec *fwspec, unsigned asid
 	struct qcom_iommu_dev *qcom_iommu = to_iommu(fwspec);
 	if (!qcom_iommu)
 		return NULL;
-	return qcom_iommu->ctxs[asid - 1];
+	return qcom_iommu->ctxs[asid];
 }
 
 static inline void
@@ -604,12 +604,10 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	qcom_iommu = platform_get_drvdata(iommu_pdev);
 
 	/* make sure the asid specified in dt is valid, so we don't have
-	 * to sanity check this elsewhere, since 'asid - 1' is used to
-	 * index into qcom_iommu->ctxs:
+	 * to sanity check this elsewhere:
 	 */
-	if (WARN_ON(asid < 1) ||
-	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
-	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL))
+	if (WARN_ON(asid > qcom_iommu->num_ctxs) ||
+	    WARN_ON(qcom_iommu->ctxs[asid] == NULL))
 		return -EINVAL;
 
 	if (!fwspec->iommu_priv) {
@@ -789,7 +787,7 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "found asid %u\n", ctx->asid);
 
-	qcom_iommu->ctxs[ctx->asid - 1] = ctx;
+	qcom_iommu->ctxs[ctx->asid] = ctx;
 
 	return 0;
 }
@@ -801,7 +799,7 @@ static int qcom_iommu_ctx_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 
-	qcom_iommu->ctxs[ctx->asid - 1] = NULL;
+	qcom_iommu->ctxs[ctx->asid] = NULL;
 
 	return 0;
 }
@@ -846,7 +844,8 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	for_each_child_of_node(dev->of_node, child)
 		max_asid = max(max_asid, get_asid(child));
 
-	sz = sizeof(*qcom_iommu) + (max_asid * sizeof(qcom_iommu->ctxs[0]));
+	sz = sizeof(*qcom_iommu);
+	sz += (max_asid + 1) * sizeof(qcom_iommu->ctxs[0]);
 
 	qcom_iommu = devm_kzalloc(dev, sz, GFP_KERNEL);
 	if (!qcom_iommu)
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

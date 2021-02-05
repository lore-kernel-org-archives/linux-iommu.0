Return-Path: <SRS0=Vrxx=HH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF96C433E0
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 09:45:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA6464FB7
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 09:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA6464FB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 653C087327;
	Fri,  5 Feb 2021 09:45:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XE7fG9ifAgBg; Fri,  5 Feb 2021 09:45:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 54560872CF;
	Fri,  5 Feb 2021 09:45:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E5DBC08A1;
	Fri,  5 Feb 2021 09:45:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E16E1C013A
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 09:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CFBE487034
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 09:45:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v2ZALrrgLK8a for <iommu@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 09:45:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0D34887112
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 09:45:17 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id t29so3951408pfg.11
 for <iommu@lists.linux-foundation.org>; Fri, 05 Feb 2021 01:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ij/h85oXJKLKfOyNytBFaR/zwWNpKnRCXwdnAmKNlzA=;
 b=FyF9PPnS5DuNfyg1/r5SwuLubGJE9DhIHqi0HstEy7Q26ja32WJclNimxmWBKfmYZe
 OOS0VirmPcRQJZU4SX+vYFm6FQ6cL3L86h8N40BvZTUq/RW5IJFLczEX4nb1ROXlkCX/
 SZlLoOw627cl6PEB4XZXoq/eI+kicCRu9MxLL11TIB5WzAiqf0QQ2OUXKtvSrnnlJXR6
 57DY7CMEtOGpSE0pIPa+dE20xIwHVwVoPf/H5vXWAmshPQ+iVZeFxwXu14hwIO2Hxlie
 9IRF8WCdIqXysd7CwKv/Vbh4xkiKlFozWKfFCF8WsdFwpopJg2LNecPa9UrO9VoCEn7H
 D4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ij/h85oXJKLKfOyNytBFaR/zwWNpKnRCXwdnAmKNlzA=;
 b=Mq1OH74tAZF39x3nP2UQPqKboBGqXu8TtPeksMlshjAkIgXs9Xttpi7+qIeYjTOpiL
 crxf+a9U/sgAdXZSjCzfUDVTn9cmAt9hLTKdJnHsEqET9fNBd21msBj7NrQDQSslrhTn
 hFPjdneMKel8nbf32odr14ZR2EtUdQFtNnjarzu/N6z7vW9OQrRGIhDvDqDeTcYvi783
 FCBseF7xVNF0LvKonlO42Q1GwFrdJN0dkIw5AY86fyx7xZ5UVPPIGUs3zkKBg+a2Heou
 CCt/SVcooUUUyExm+/ImqJ3Q57TjvRB+rSN/77Wpv1oFnPbINScVaTqWS8/yHHHvCsC5
 sbMg==
X-Gm-Message-State: AOAM5334QZNvi8maEt5Uiqzif3b5po2GUjaAmrb0Vva0VcIo6YHxvvT1
 sKrhsTHGtOz5P6czkzBo6ho=
X-Google-Smtp-Source: ABdhPJxRaDYB7eWp5Jmy7gQItXlnWORYO0/RGgu2LTC/6884HlnPqyeaxMfAGGLIhv5B45MiK/JptQ==
X-Received: by 2002:a62:1a06:0:b029:1bc:21e:ed47 with SMTP id
 a6-20020a621a060000b02901bc021eed47mr3598773pfa.40.1612518316620; 
 Fri, 05 Feb 2021 01:45:16 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id c5sm8805679pfi.5.2021.02.05.01.45.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 05 Feb 2021 01:45:16 -0800 (PST)
Date: Fri, 5 Feb 2021 01:45:57 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Guillaume Tucker <guillaume.tucker@collabora.com>
Subject: Re: [PATCH RESEND v2 4/5] iommu/tegra-smmu: Rework
 tegra_smmu_probe_device()
Message-ID: <20210205094556.GA32677@Asurada-Nvidia>
References: <20201125101013.14953-1-nicoleotsuka@gmail.com>
 <20201125101013.14953-5-nicoleotsuka@gmail.com>
 <46a96cf9-91cc-2ad4-702a-e95ba7200375@collabora.com>
 <20210205052422.GA11329@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20210205052422.GA11329@Asurada-Nvidia>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "kernelci-results@groups.io" <kernelci-results@groups.io>,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com, will@kernel.org
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Guillaume,

On Thu, Feb 04, 2021 at 09:24:23PM -0800, Nicolin Chen wrote:
> > Please let us know if you need any help debugging this issue or
> > to try a fix on this platform.
> 
> Yes, I don't have any Tegra124 platform to run. It'd be very nice
> if you can run some debugging patch (I can provide you) and a fix
> after I root cause the issue.

Would it be possible for you to run with the given debugging patch?

It'd be nicer if I can get both logs of the vanilla kernel (failing)
and the commit-reverted version (passing), each applying this patch.

Thanks in advance!
Nicolin

--EVF5PPMfhYS0aIcm
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-iommu-debug-tegra-smmu.patch"

From 80f288d7101101fca0412c5c200cea7e203a675d Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Fri, 5 Feb 2021 01:41:07 -0800
Subject: [PATCH] iommu: debug tegra-smmu

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 4a3f095a1c26..796b7df54b8f 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -363,6 +363,7 @@ static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
 		value |= SMMU_ASID_VALUE(asid);
 		value |= SMMU_ASID_ENABLE;
 		smmu_writel(smmu, value, group->reg);
+		pr_alert("--------%s, swgroup %d: writing %x to reg1 %x\n", __func__, swgroup, value, group->reg);
 	} else {
 		pr_warn("%s group from swgroup %u not found\n", __func__,
 				swgroup);
@@ -379,6 +380,7 @@ static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
 		value = smmu_readl(smmu, client->smmu.reg);
 		value |= BIT(client->smmu.bit);
 		smmu_writel(smmu, value, client->smmu.reg);
+		pr_alert("--------%s, swgroup %d: writing %x to reg2 %x\n", __func__, swgroup, value, client->smmu.reg);
 	}
 }
 
@@ -491,13 +493,19 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 	unsigned int index;
 	int err;
 
+	dev_alert(dev, "-------%s: smmu %s\n", __func__, smmu ? "valid" : "NULL");
+	dump_stack();
 	if (!fwspec)
 		return -ENOENT;
 
+	dev_alert(dev, "-------%s: fwspec->num_ids %d\n", __func__, fwspec->num_ids);
 	for (index = 0; index < fwspec->num_ids; index++) {
 		err = tegra_smmu_as_prepare(smmu, as);
-		if (err)
+		if (err) {
+			dev_err(dev, "failed to prepare as(%d) for fwspec %d",
+				as->id, fwspec->ids[index]);
 			goto disable;
+		}
 
 		tegra_smmu_enable(smmu, fwspec->ids[index], as->id);
 	}
@@ -805,6 +813,8 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 	if (!smmu)
 		return ERR_PTR(-ENODEV);
 
+	dev_alert(dev, "--------%s, %d\n", __func__, __LINE__);
+	dump_stack();
 	return &smmu->iommu;
 }
 
@@ -904,6 +914,8 @@ static int tegra_smmu_of_xlate(struct device *dev,
 
 	dev_iommu_priv_set(dev, mc->smmu);
 
+	dev_alert(dev, "-------%s: id %d", __func__, id);
+	dump_stack();
 	return iommu_fwspec_add_ids(dev, &id, 1);
 }
 
-- 
2.17.1


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--EVF5PPMfhYS0aIcm--

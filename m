Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6CC391849
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023330; cv=none; b=T2UgUh5bXPkqvGix9rc7IyO3bfMkqltwRW5Okv25uzkD9KZ4y4yy4Rpqic41xso2Zh6LIbGDnQ00NHy7e/VtBGVJNMJpsBRrEmoF9np1UaznvlzVfwI0y+3u89jJGdrdn8klvDGktE7iXi7zEcxD7QhK8/xyU3gMq4FnVfftvbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023330; c=relaxed/simple;
	bh=JbJ0jb4ejrFmyQLGc2y25VOtYx2Utyegas11w/+uOLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I3fdqhNhFw2E/3P8ssjiuhx3D55fdBqcH7QjPNoD/+Dg75plQAyPV2llNL8K+2DukKGgVClE/WH1aoadj076MyfRh7ijj9Jf23uZS9OMcr+Dp4VWpAmWD25fvSFz3ouiXYA6pXXRnvtiet7v+ko9ipnW0JkgniFa9SQ1VdC658o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Pw8xYkIn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Pw8xYkIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1789023292;
	bh=uTV/qjut2EJ2HSX5Racn0nEgdyfczq3XC0HT2J7tQJ8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Pw8xYkInqTFVGkaQo9KeLd1+skui5OlfdikTMjNF9Jf6/F96iPLxJeW/TCkIZuhIL
	 4W60bxY5oS+6HGVBCmEC/sqfmTCu/rRZSPSBuHdmQEJeIRalbfZJa41uJRxvunwex5
	 1XPmimzYeMQzWnMGznAP1vpBRo6ICZ9059FulCL4=
X-QQ-mid: zesmtpgz4t1789023273ta1fbe3da
X-QQ-Originating-IP: xX/ut/FNG2CYqFuk52gzzhzwcGrktHAvSAisDQIiWWM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Sep 2026 14:54:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8036773416646181260
EX-QQ-RecipientCnt: 10
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	jgg@nvidia.com
Cc: will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nicolinc@nvidia.com,
	skolothumtho@nvidia.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 7.2.y] iommu/arm-smmu-v3: Disable implementations during devm teardown
Date: Thu, 10 Sep 2026 14:54:29 +0800
Message-Id: <20260910065429.1703706-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OJaSdNvGbayWw4qAVkkuh1KpQ/b2Xb5b/0vdvNM5yQujF9elfdqdk2ce
	jqqDAOxTroYJHA6bjQERqy1mxSciX2iWuH98R99yEWQxKjUOezJblj3M1q5Qy6nlUIHFb0q
	Uf+3CHTL/rkhWgAUAfVXxg7kgeJLvutbB0Ii8jX1OVG8KowhAdZSpD/7CJDB1RYadcXAwTA
	QD7nqrJo2t0Z2Pkm48r+FL3A3W3ogPTgdbmQiAoFZyGAfffqqYqMHKfrWtBTf0k+fOqqYCF
	Io4+vKMba3T0nHSeDbCTDVhbE4jc436Hsv9zJ4tXskdRgkTD02ESLsNoMj/HlY4NhT2DhND
	YjK5lBVw7PAdOTztELIrRvewBoyv23a0U/jsFqht490tiHt3oujxLxULlOCaRCe4gOn9xH7
	NsNhGkw9ldlYqaBYIYSMTO5H/Ul4uM6h7UxmS715odQINXA+fbzDtZNofwV4RkKIHn67/O/
	nCvUTc39e7tTPSFPwAESzxtGZSUfZc/9th3Io0NEN3OCjXk6wXpwv+gQ4ZmVt2xGl8D+t8m
	IA2iE7JsED0VgNivoYQZdDD/k4emm/4Utf791X90RnB+4Eo/Vn68FALI9PXrpKGlV0Jg6yd
	75apmuUGA9b1qX8u/t9CkhcJKdFax7z+TVeALN363BNpsk38QtFNC3GEdUOVcWKTxCNDg5w
	bGjQgVOBqgnwRHK9ZR3iieLu0ZLhQdumHQHr0gZ+5eWyN6LrXB9FN7/3I4GvHzcqBDO0SYa
	/Cx668PZlycgHREcRRz+Wmcruag8iRGnuMiXSx1auh4mERHWZnuWh6jmcNYNdxMrb4jjaNp
	v/0PeJp7jiXKaKkqvypK9WjUW0MmuWELPZEE67z+6By46HUFtfgKsnFHj/sgPMkigG8HZD9
	qHVIYJ6lmxa9sojoG2TzsichRIx31TRVp60O6DgO6S7c7dVVF5GaQqbQNr4gKXkFq8b/3Ep
	4ssIBYbOLnEzK5CptWns9rqY6mo25PyXnFaQsBdwI3tFp02ubmopthaYOu47Oe53UKc1TR/
	NDIfXwqctWw8aIgmTVfbi5l+SKyYCtR+2v6fbnewrDEhEyz9dNvgawpna6fxA=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

The Tegra241 CMDQV teardown fix moved VINTF hardware deinitialization
into the implementation device_disable() callback. However, its stable
backport preceded the conversion to devm teardown and could only invoke
the callback from the shutdown path.

Now that arm_smmu_disable_action() manages normal teardown, invoke the
implementation callback there while the command queue is still alive.
This prevents the subsequent implementation remove action from releasing
resources while the CMDQV hardware remains active.

After ("iommu/arm-smmu-v3: Manage teardown with devm") merged in stable,
now keep the shutdown path consistent with mainline, where disabling
the base SMMU is sufficient.

It is a fix for stable tree commit to aligned with mainline, so no
upstream commit id here.

Fixes: 5994617e09ee ("iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c993e101fab3a..ea908afb0da9d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4789,6 +4789,8 @@ static void arm_smmu_disable_action(void *data)
 {
 	struct arm_smmu_device *smmu = data;
 
+	if (smmu->impl_ops && smmu->impl_ops->device_disable)
+		smmu->impl_ops->device_disable(smmu);
 	arm_smmu_device_disable(smmu);
 }
 
@@ -5621,8 +5623,6 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
-	if (smmu->impl_ops && smmu->impl_ops->device_disable)
-		smmu->impl_ops->device_disable(smmu);
 	arm_smmu_device_disable(smmu);
 }
 
-- 
2.30.2


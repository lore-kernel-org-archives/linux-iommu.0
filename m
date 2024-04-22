Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979391C8FC8;
	Mon, 22 Apr 2024 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830359; cv=none; b=nEoOHz2lJPVsqjh0HixS89tEsJPQt/VH3TDfbehQQuXClgC6Qu3JLr/MKd5zmAfYl0vqblzNllS3bZAgkHPM1GZ9r3cPvVhWZPdGVseaquwaSnG7B4xWa1cII06qK5XwL7VAzG7fNY6rf+GOBfBQiYQYs15Q6n+97q7XGWh25YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830359; c=relaxed/simple;
	bh=mv36kwNPx9hcZbPXznQ5tA13wJIVJ592KdMHKYLTkec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQwtLRRCjJRNpmgLqXCT1qwB0Havn/SidMYG2rCEd9KwXgx8NP9lc+9Mu/YHyn845ckIrPpQZcNhKQq7voVqN8LvQqieM+HepMzhxrCHpaz4JKUne6/16u0AI1SVXbIBud+KCtF6VnIePjwqgy3quVfB3b0aq51TWs62icvBNNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYFnszrv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYFnszrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAC0C113CC;
	Mon, 22 Apr 2024 23:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830359;
	bh=mv36kwNPx9hcZbPXznQ5tA13wJIVJ592KdMHKYLTkec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYFnszrvSnOa6TlFA5RNDCW3oy4hvBuRCOXWfeJcBpOWJeSR3eRZPEd07VC8FTQBE
	 5TZ8RVmYNVbjov7GWIN+qCU0uXDkCtH4JWqtREUN8ORdHG/Gtd15dMvLAhQvHJ6iAs
	 7rYsedi0+fr1XqBZ0R/xvVJT4xpCReWZ0jTJUmUAdFYDxelwv0KcXOBY3s3HsaCwLT
	 0FOH942i3jeav4dk3YbO6s/IX85NsA7XbizrY4x+a/g9wEDSJEhSyBeWJbR/Gmpp9W
	 kB0Mp+JBiQwyeGJ0yVPSFgUY1CfOb2VH8EZHRePZbes1h5MEAVAIk8Dl9I7k3Wt18/
	 rqNi2MlynWCow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	yong.wu@mediatek.com,
	joro@8bytes.org,
	will@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 9/9] iommu: mtk: fix module autoloading
Date: Mon, 22 Apr 2024 19:20:14 -0400
Message-ID: <20240422232020.1615476-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422232020.1615476-1-sashal@kernel.org>
References: <20240422232020.1615476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.274
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit 7537e31df80cb58c27f3b6fef702534ea87a5957 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20240410164109.233308-1-krzk@kernel.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/mtk_iommu.c    | 1 +
 drivers/iommu/mtk_iommu_v1.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index dad44e10b3314..2cf7d9f7fd3df 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -854,6 +854,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_of_ids);
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index fa602bfe69512..e0c1a19773381 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -543,6 +543,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-m4u", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_v1_of_ids);
 
 static const struct component_master_ops mtk_iommu_com_ops = {
 	.bind		= mtk_iommu_bind,
-- 
2.43.0


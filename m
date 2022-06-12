Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D9FCCA47D
	for <iommu@archiver.kernel.org>; Sun, 12 Jun 2022 12:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEEC760A71;
	Sun, 12 Jun 2022 12:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Wz5wHVQYole; Sun, 12 Jun 2022 12:29:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AC61260BE1;
	Sun, 12 Jun 2022 12:29:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DA32C008B;
	Sun, 12 Jun 2022 12:29:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F262BC002D
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jun 2022 09:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8A6483F1C
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jun 2022 09:32:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=z3ntu.xyz
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TC2Wmz_GXLrZ for <iommu@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 09:32:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 412E983F16
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jun 2022 09:32:08 +0000 (UTC)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl
 [31.151.115.246])
 by mail.z3ntu.xyz (Postfix) with ESMTPSA id E0E5ECD3B3;
 Sun, 12 Jun 2022 09:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
 t=1655025752; bh=isvXvz151xa9quT3FHp3T0dcyI84C7Y5YBfGdMQhMmA=;
 h=From:To:Cc:Subject:Date;
 b=o9/ANSNedqRJigIQk70MGTfgaC+jNQhcvq9Bl0RmRLiqfBmZcK+iBTW4CC0os403e
 nQ1DJZ4+tjDtbExBe6brM1mH4UNWUq2ZZTnYV+9jv6ZVobjKgTW7vHz6ZG6ha9e0FP
 OCvhLYgAcJCsDUCkWTZlEQwvdPqduG5mXgkqftr0=
From: Luca Weiss <luca@z3ntu.xyz>
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/4] MDSS support for MSM8953
Date: Sun, 12 Jun 2022 11:22:12 +0200
Message-Id: <20220612092218.424809-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 12 Jun 2022 12:29:06 +0000
Cc: Rob Clark <robdclark@chromium.org>, devicetree@vger.kernel.org,
 James Willcox <jwillcox@squareup.com>, freedreno@lists.freedesktop.org,
 Vladimir Lypak <vladimir.lypak@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Luca Weiss <luca@z3ntu.xyz>,
 iommu@lists.linux-foundation.org, ~postmarketos/upstreaming@lists.sr.ht,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, phone-devel@vger.kernel.org,
 Sean Paul <sean@poorly.run>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This series adds the APPS IOMMU and the MDSS block for display that is
found on msm8953 SoCs.

Luca Weiss (1):
  dt-bindings: qcom-iommu: Add Qualcomm MSM8953 compatible

Vladimir Lypak (3):
  arm64: dts: qcom: msm8953: add APPS IOMMU
  drm/msm/mdp5: Add perf data for MDP v1.16
  arm64: dts: qcom: msm8953: add MDSS

 .../devicetree/bindings/iommu/qcom,iommu.txt  |   1 +
 arch/arm64/boot/dts/qcom/msm8953.dtsi         | 244 ++++++++++++++++++
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c      |   5 +
 3 files changed, 250 insertions(+)

-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

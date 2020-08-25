Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C84CC433DF
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 05:38:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7BBD20738
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 05:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G++tiKuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BBD20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A26008815D;
	Tue, 25 Aug 2020 05:38:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k+CoeBxMmdk4; Tue, 25 Aug 2020 05:38:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 192BE87E90;
	Tue, 25 Aug 2020 05:38:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08BA9C07FF;
	Tue, 25 Aug 2020 05:38:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD957C0051
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 05:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C443387F51
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 05:38:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3SFg9mwVzXpC for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 05:38:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C101D87F34
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 05:38:42 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id m22so14827756eje.10
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 22:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Cvb0A9IRVLSsoFCfcZyj1U4yUSMM5vQl3gQOUmNeIGo=;
 b=G++tiKuDShN9pc23dyIevDr+cZBVwyC7VvsI4bEXClMei5oqFqjWi94wCCneP/vKy0
 LexpHU99oSZzMjQcL+WLa4F5lm87dhEquZAmwrqATs1/wGGpZwgxDxBNQPvBb7jgAh17
 UpoIdxBgpYRu6+E5uy8j0oDtBzuaQul0b5ThXf5n/aTRdTT4PYZPXarS1zYN74+cDT1W
 qUttZUMeEvPpPyvlaZvpPe9npBne9X4v/bGcSPs0M3QkqUSnnO9Vhh4MVm2FM0cngDLp
 8Y4Ju+KPzw357U9ckQDm9wXsztmLWj36MqIyEnE56zNf7rVm7TBqqwTHx4AeI/pTwjGk
 grYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Cvb0A9IRVLSsoFCfcZyj1U4yUSMM5vQl3gQOUmNeIGo=;
 b=nhUcXhxYtny1wSV2ZGlUB1Jik5xaMpATcFIYhvIV5ZJMM2ZimFNRmOjLaUznA8gYuN
 tIWVqzedtWPKMffP74GUP8TvOkG/MlqWzBoJiQ9HFhHlPcQm3E57hjtcvnX/uXOiIy7O
 Eej3qaTgs0bNHcd2NehJlLswrLQKKFWNd3Vv/gzX6ba+WPhOQOsOE7w4E99janCpYWno
 VzRMHRBzpLFtlX3ae1jj16SN3F7k2v9kpzK1NLfR+FzDp5ihVdlaEg2W3duD2oQ/4OvA
 +k6YC6owABsRWx6I1l0AaQR1KYeKxsXIyj0w9M50EBSiINWDPmtAUH5OAwuMc8W+hd60
 Mb9w==
X-Gm-Message-State: AOAM533QWXv2LkCTyFDDc1EjSPaamupQPjsbBwCsPOAcLLLuG5h+cWzm
 hTfU7SWnzIsXoBH/m8LXufQ=
X-Google-Smtp-Source: ABdhPJyRUIKUbRUhlOKBBMsu5/OxI8cNrhveYOeqRDXItbKYX5J13lRtTjQy9/UFSHUieFtfPvPmcw==
X-Received: by 2002:a17:906:a219:: with SMTP id
 r25mr9055831ejy.201.1598333921147; 
 Mon, 24 Aug 2020 22:38:41 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d83:7500:a091:6d55:fb72:2347])
 by smtp.gmail.com with ESMTPSA id dn7sm11802273ejc.76.2020.08.24.22.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 22:38:40 -0700 (PDT)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2] MAINTAINERS: update QUALCOMM IOMMU after Arm SMMU drivers
 move
Date: Tue, 25 Aug 2020 07:38:28 +0200
Message-Id: <20200825053828.4166-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 kernel-janitors@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, linux-arm-msm@vger.kernel.org,
 Joe Perches <joe@perches.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Pia Eichinger <pia.eichinger@st.oth-regensburg.de>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org
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

Commit e86d1aa8b60f ("iommu/arm-smmu: Move Arm SMMU drivers into their own
subdirectory") moved drivers/iommu/qcom_iommu.c to
drivers/iommu/arm/arm-smmu/qcom_iommu.c amongst other moves, adjusted some
sections in MAINTAINERS, but missed adjusting the QUALCOMM IOMMU section.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F:    drivers/iommu/qcom_iommu.c

Update the file entry in MAINTAINERS to the new location.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Acked-by: Will Deacon <will@kernel.org>
---
v1: https://lore.kernel.org/lkml/20200802065320.7470-1-lukas.bulwahn@gmail.com/
v1 -> v2: typo fixed; added Will's Ack.

Joerg, please pick this minor non-urgent patch for your -next branch.

applies cleanly on next-20200731

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1469cb81261d..e175c0741653 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14358,7 +14358,7 @@ M:	Rob Clark <robdclark@gmail.com>
 L:	iommu@lists.linux-foundation.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-F:	drivers/iommu/qcom_iommu.c
+F:	drivers/iommu/arm/arm-smmu/qcom_iommu.c
 
 QUALCOMM IPCC MAILBOX DRIVER
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

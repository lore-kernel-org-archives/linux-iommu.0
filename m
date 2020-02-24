Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E895C11D2F
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 16:59:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0462D20836
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 16:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h5rEfPIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0462D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CE4988738B;
	Mon, 24 Feb 2020 16:59:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ew6JAZCls5Fg; Mon, 24 Feb 2020 16:59:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E98B887526;
	Mon, 24 Feb 2020 16:59:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7EBEC1D8A;
	Mon, 24 Feb 2020 16:59:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19DBAC0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F3BEC865B8
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dlBqkvdistDT for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 16:59:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C3D1784B6A
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:06 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id p18so7608041wre.9
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 08:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8HIxi7ZL1ytSixldA0X7x1yzZ6pxdx7GHOJTgPsbD+w=;
 b=h5rEfPIuduIQsDpoF+aKzWlaxFkIu7NDgF+GUcFIIt/VEnEoT0L5HPk9fkl7MEJle/
 Ud2/GAlx627mLkL/h0OM7o+RKQDlXhqbE11lN9bmjiCsn4DNjmUERD/jrlTqzVJWNjj4
 GKsFp79swWzlVETvQ6zeOwXBwvIXoqOkTvFEc5iELSunxPmlJa3C9IoktYgPNSri85j6
 dOsjcm5aopJ5Wg/HN4EeLpWdLgJf2/AhAp5ryL71MVMahP0aLdvn5AtDO+E46a0UO5F/
 xsZMf+Gj1g+5qy4Nt1bFFOG67DXu65lwChW+sVk7kYxBwmSFM94vz6m+bs8D32j8JX1B
 kE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8HIxi7ZL1ytSixldA0X7x1yzZ6pxdx7GHOJTgPsbD+w=;
 b=o2CiVVwO7RNMAgh5UaRN+lgx35d9J+PeqTMqZg+wzAVDlzr07mC04qolgYAhTfMDYh
 0zepgeJGZDWuHfGuN9Xzi1/dN/d/1qMAv7MO9Vxc1Zd4Ac9bshKxADOY+vhXvRNdYOb0
 1PuQWF4TsKiqi1kVs1yAypqk8T+83JVBok1Q61unnzn4JItuMJi2Acj7nV7FERKO0H2X
 4WL/ufkCY5UlUdAbJuMBcBps3VdXWZHSvkN0apjKzBM37F96odsN3xwuwVu9Sr1NTAVc
 1by4FRy/7sZX4dGakvDBldtuJRW+MxAHxqChsNAtgXOYrJ62XXucqu8Bbs4XbbNrN6at
 dTBA==
X-Gm-Message-State: APjAAAW+l7LwQtP0OUfcFdtbdtGRje1JOhWdY5GSyCVrFiSX0y8+LeJ0
 Fdna4VDbTn1pBAL5xOT+8Tv7ow==
X-Google-Smtp-Source: APXvYqzKuk1DCPA9bZvrQ+EiIsobd8Fn/PAZ2IzLOJ9Fytea0eB2ueRowKL1GRPNmrrjY6GtmuesjA==
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr14316725wrm.270.1582563545042; 
 Mon, 24 Feb 2020 08:59:05 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b10sm19473978wrt.90.2020.02.24.08.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 08:59:04 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, will@kernel.org, bhelgaas@google.com
Subject: [PATCH v2 3/6] iommu/arm-smmu-v3: Write level-1 descriptors atomically
Date: Mon, 24 Feb 2020 17:58:43 +0100
Message-Id: <20200224165846.345993-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224165846.345993-1-jean-philippe@linaro.org>
References: <20200224165846.345993-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: zhangfei.gao@linaro.org, robin.murphy@arm.com, robh@kernel.org
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

Use WRITE_ONCE() to make sure that the SMMU doesn't read incomplete
stream table descriptors. Refer to the comment about 64-bit accesses,
and add the comment to the equivalent context descriptor code.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 6b76df37025e..068a16d0eabe 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1531,6 +1531,7 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
 	u64 val = (l1_desc->l2ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK) |
 		  CTXDESC_L1_DESC_V;
 
+	/* See comment in arm_smmu_write_ctx_desc() */
 	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
@@ -1726,7 +1727,8 @@ arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_desc *desc)
 	val |= FIELD_PREP(STRTAB_L1_DESC_SPAN, desc->span);
 	val |= desc->l2ptr_dma & STRTAB_L1_DESC_L2PTR_MASK;
 
-	*dst = cpu_to_le64(val);
+	/* See comment in arm_smmu_write_ctx_desc() */
+	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
 static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

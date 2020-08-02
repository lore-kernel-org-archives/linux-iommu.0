Return-Path: <SRS0=vGvh=BM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96ABC433E0
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 13:59:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C18A206DA
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 13:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caiM1fPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C18A206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5175287E68;
	Sun,  2 Aug 2020 13:59:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r7xS1D3GFOsu; Sun,  2 Aug 2020 13:59:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CC789879A5;
	Sun,  2 Aug 2020 13:59:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B58C7C0050;
	Sun,  2 Aug 2020 13:59:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A314C004D
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 06:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 21C2284FF9
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 06:53:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2rptFx5M_ctT for <iommu@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 06:53:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1E7F584F33
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 06:53:31 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id f18so31369275wrs.0
 for <iommu@lists.linux-foundation.org>; Sat, 01 Aug 2020 23:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=rs54B29tWCCrVhPxX04t7FFEWHnrLOxSKBgk2U1YFCA=;
 b=caiM1fPnBhKvSeFdy1yX0uOl+tlPe4753gxbKBZEzWEgr6vZKU9rmQ60bEnTBrDSs6
 gJOsHkGP1rNPQ+qvIpQZ5cj6Q+9osarcGlzLhvhYpjH0MeetPbVxbB58F5M7UvCAE+FJ
 vnUg/jGtxOyOdkWcWTou73fL2CSkr1vHa0xJQT9gzuK68gy5LXWg2qTsnq3TrPf7m217
 UQXwxadJuStCyop06PfNfgJMBskS8fTeZ7d0DoxRX7NUspkORquJO6o3G54oTbwS8/bj
 ICISk4CRzmp+JUvmwyTSNDbory9P0oUOajXOQ9NkUYjV1UXJ78EA92za88r5GmxTviOv
 ObvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=rs54B29tWCCrVhPxX04t7FFEWHnrLOxSKBgk2U1YFCA=;
 b=OS5KE8vdKGjn3aPEO7OmSi/Xj2uSOOpgBZ5KICv0t2zxsEJfMMgTsolm2ab0DLQ8Q8
 fCULILcBHcsyiauZvU+KKzjWtDpzeEJTsQIbBjFBmhyTzodniIhfvXorhw1E7UBA1eXW
 0KNcuvsRVmRrclarR4cKH7RIK/ihHYi13GOLlDnYFDXq4eHChBnWQaB5jFPoHc0lbcNR
 +t3uJ66lqs94bq99gEsjyHSsF48OQ39u0snQCZCsO5z97ccoQj0KNM6rS99VLQX6k9N3
 ngidPRrEhw3DGmXItM7oIvj3zsQ9rC109HttMhIaAOKnb7L7AGP3GB+sGHEP0KwoCCZt
 cEjw==
X-Gm-Message-State: AOAM5320IhhAb70ROGRy8DXmHBHzeCIz6s7nAH6vQVrXHhOKlttYhtE+
 2EDYPcbj4wUyCWnscv2Mtuw=
X-Google-Smtp-Source: ABdhPJzU737g4BQ0PI02QtqBBrYd5JaxPm0earZrC3QMVjeilkQqYT0dbhQi2VFzRmn+G1KvW9DkHA==
X-Received: by 2002:a5d:4610:: with SMTP id t16mr10494065wrq.101.1596351209301; 
 Sat, 01 Aug 2020 23:53:29 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dd3:b900:b425:3ccc:d91f:7988])
 by smtp.gmail.com with ESMTPSA id m126sm18166966wmf.3.2020.08.01.23.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2020 23:53:28 -0700 (PDT)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] MAINTAINERS: update QUALCOMM IOMMU after Arm SSMU drivers move
Date: Sun,  2 Aug 2020 08:53:20 +0200
Message-Id: <20200802065320.7470-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Sun, 02 Aug 2020 13:59:48 +0000
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
---
Will, please ack.
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

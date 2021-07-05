Return-Path: <SRS0=3QBT=L5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3506C07E98
	for <iommu@archiver.kernel.org>; Mon,  5 Jul 2021 06:57:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568B8613D1
	for <iommu@archiver.kernel.org>; Mon,  5 Jul 2021 06:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568B8613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A6934046E;
	Mon,  5 Jul 2021 06:57:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h4tOQCYesWtQ; Mon,  5 Jul 2021 06:57:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C57C840475;
	Mon,  5 Jul 2021 06:57:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B98EC0010;
	Mon,  5 Jul 2021 06:57:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D970C000E
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 06:57:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 79F7383A4B
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 06:57:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=samsung.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vPHU6GbJnENl for <iommu@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:57:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6165883A3C
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 06:57:09 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20210705065704euoutp02351f21603491ce4d1c282e810b6a9e39~O0rzy63lX2771727717euoutp02Y
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 06:57:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20210705065704euoutp02351f21603491ce4d1c282e810b6a9e39~O0rzy63lX2771727717euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1625468224;
 bh=Rn6oui8vNSOkba5+SL9hOQCcwE6W7/neAD8+y9vs3gY=;
 h=From:To:Cc:Subject:Date:References:From;
 b=ZLp/xms0USWtQpdfN4vwt8eg7e7Vt4Qb9LDuue8r6sGBT5a5ifCwmgSlR6PPtrV4R
 ojYAtFRslq7MpydzI9OtuxqancFp67IeG2GByKf1Bw7ImvWBctu4oaUlw+VWeVyQM0
 +bGGMkk/4197CTe6vf5blwa9mYnXHzq3NAlXhT7c=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20210705065703eucas1p24403b2842e74f7d843f8d77ce61aab6e~O0rzFHrJb2770227702eucas1p2g;
 Mon,  5 Jul 2021 06:57:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 07.1F.45756.F3DA2E06; Mon,  5
 Jul 2021 07:57:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20210705065703eucas1p2e89258a2fc286896b755047e06f514cb~O0ryjuym82752127521eucas1p2c;
 Mon,  5 Jul 2021 06:57:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210705065703eusmtrp2704ec35040dd29269ebdc309b2f114f3~O0ryi_AuN1229112291eusmtrp2q;
 Mon,  5 Jul 2021 06:57:03 +0000 (GMT)
X-AuditID: cbfec7f2-7d5ff7000002b2bc-e7-60e2ad3f3ff7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 70.FC.31287.E3DA2E06; Mon,  5
 Jul 2021 07:57:02 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210705065702eusmtip15a3d78a6d0c3d1a4c75d47a32eb85aff~O0ryAs9NO0308503085eusmtip1I;
 Mon,  5 Jul 2021 06:57:02 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
Subject: [PATCH] iommu: qcom: Revert
 "iommu/arm: Cleanup resources in case of probe error path"
Date: Mon,  5 Jul 2021 08:56:57 +0200
Message-Id: <20210705065657.30356-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduzneV37tY8SDDYeVrS4tH0Zq8WC/dYW
 nbM3sFtsenyN1WLi/rPsFmuP3GW3eL7wB7PFwQ9PWC369gZZtNwxdeDyeHJwHpPHmnlrGD12
 zrrL7rFpVSebx+Yl9R6Tbyxn9Ohtfsfm0bdlFaPH501yAZxRXDYpqTmZZalF+nYJXBldh58z
 FZzhq1hw5QlLA+MWni5GDg4JAROJl7uFuxi5OIQEVjBKfJx/gRHC+cIosXnqBXYI5zOjxIaF
 24AcTrCOLd0TWCESyxkl1v76xQLX8mPzdVaQKjYBQ4mut11sILaIQLZEw/FWsFHMAu1MEjem
 rmUGSQgLJEqsadkAVsQioCox5ctRMJtXwFZi5qrHjBDr5CVWbzjADNIsIbCWQ+L6ikdMEAkX
 if27LrNA2MISr45vgbpPRuL/zvlMEA3NjBIPz61lh3B6GCUuN82AGmstcefcLzZQGDALaEqs
 36UPEXaUePV3JxskaPgkbrwVBAkzA5mTtk1nhgjzSnS0CUFUq0nMOr4Obu3BC5eYIWwPiTnP
 J4GdJiQQK7Hz+CfmCYxysxB2LWBkXMUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGYTE7/
 O/5pB+PcVx/1DjEycTAeYpTgYFYS4RWZ8ihBiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+q2Wvi
 hQTSE0tSs1NTC1KLYLJMHJxSDUyeOd62vw+IhG9dlrjzaVl9g6j8xhtuNtrJJyKnFMr8rL5w
 X6KV42eUqq+wxXXOgICGzUIP5UsXcInsUtM72zV/Q0FQS8uUeSqvLIt9fr0QEP+znLXz0U+F
 ys5Zi0S8LsmquV8O/blv62qFH7e+1lqbKLGv6Yq4u+BRzrKQ9xHBBrd/1XjbOsi+kklkduC+
 wKUmxP2MTbbgvk+CpfzhpunWawqFvlqz6J+xfWr7jLVBxXLLnsIXalyhu+zLSs0O+5+7+yig
 dP3uMwqfvkgekyhaazzjzrSFx62mL72mxVKRetR6+c8Okw3BUnkrdt7g36vN+URERyY0UlD5
 8mbeHtXpfY1bbeYYShhpPts8W4mlOCPRUIu5qDgRAAAccB2VAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsVy+t/xu7p2ax8lGDxYYmNxafsyVosF+60t
 OmdvYLfY9Pgaq8XE/WfZLdYeuctu8XzhD2aLgx+esFr07Q2yaLlj6sDl8eTgPCaPNfPWMHrs
 nHWX3WPTqk42j81L6j0m31jO6NHb/I7No2/LKkaPz5vkAjij9GyK8ktLUhUy8otLbJWiDS2M
 9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DK6Dj9nKjjDV7HgyhOWBsYtPF2MnBwS
 AiYSW7onsHYxcnEICSxllJh17BorREJG4uS0BihbWOLPtS42iKJPjBJvtx9gAUmwCRhKdL0F
 SXByiAjkShxunsUIUsQs0MsksWPaY7BuYYF4iRNty8EaWARUJaZ8OQrWwCtgKzFz1WNGiA3y
 Eqs3HGCewMizgJFhFaNIamlxbnpusaFecWJucWleul5yfu4mRmAQbzv2c/MOxnmvPuodYmTi
 YDzEKMHBrCTCKzLlUYIQb0piZVVqUX58UWlOavEhRlOgfROZpUST84FxlFcSb2hmYGpoYmZp
 YGppZqwkzrt17pp4IYH0xJLU7NTUgtQimD4mDk6pBqau1ZMv3J7B1z3pxjkPR5HjPT1f+I4+
 vbR+s5+4v5Fp5rHX7D815J2130etUV8UumzyYflj35XypzS8lmqbvakj9nF0SZRJg29JjIPt
 Aq+uuyvesLuZ/HA3KA16zcvfZLRY1sB6vtO3/O8vv+9ucJjEvzbvc2H6oz2/Hvp+5l6x5e4t
 p7jFMzzXzLEuDvx3/H2+8YyXesEaor1xR+3eTtxczLZknluOyff2cMEaCbONW1yD581s1r9T
 bDrr/z0hkZqOzBN1TuphT92VhPpUkvVCVxgIHGdY0qBRGhI306Ppi8Op3UcW72z4++jG8YBb
 jFt2dYtpCZQ/Tj3+5/KTpR8nRklxsylPkwuSbnTffleJpTgj0VCLuag4EQC9ltwG6wIAAA==
X-CMS-MailID: 20210705065703eucas1p2e89258a2fc286896b755047e06f514cb
X-Msg-Generator: CA
X-RootMTR: 20210705065703eucas1p2e89258a2fc286896b755047e06f514cb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210705065703eucas1p2e89258a2fc286896b755047e06f514cb
References: <CGME20210705065703eucas1p2e89258a2fc286896b755047e06f514cb@eucas1p2.samsung.com>
Cc: Will Deacon <will@kernel.org>, Amey Narkhede <ameynarkhede03@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>
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

QCOM IOMMU driver calls bus_set_iommu() for every IOMMU device controller,
what fails for the second and latter IOMMU devices. This is intended and
must be not fatal to the driver registration process. Also the cleanup
path should take care of the runtime PM state, what is missing in the
current patch. Revert relevant changes to the QCOM IOMMU driver until
a proper fix is prepared.

This partially reverts commit 249c9dc6aa0db74a0f7908efd04acf774e19b155.

Fixes: 249c9dc6aa0d ("iommu/arm: Cleanup resources in case of probe error path")
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 25ed444ff94d..021cf8f65ffc 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -849,12 +849,10 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	ret = iommu_device_register(&qcom_iommu->iommu, &qcom_iommu_ops, dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iommu\n");
-		goto err_sysfs_remove;
+		return ret;
 	}
 
-	ret = bus_set_iommu(&platform_bus_type, &qcom_iommu_ops);
-	if (ret)
-		goto err_unregister_device;
+	bus_set_iommu(&platform_bus_type, &qcom_iommu_ops);
 
 	if (qcom_iommu->local_base) {
 		pm_runtime_get_sync(dev);
@@ -863,13 +861,6 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-err_unregister_device:
-	iommu_device_unregister(&qcom_iommu->iommu);
-
-err_sysfs_remove:
-	iommu_device_sysfs_remove(&qcom_iommu->iommu);
-	return ret;
 }
 
 static int qcom_iommu_device_remove(struct platform_device *pdev)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

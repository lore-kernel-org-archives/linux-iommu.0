Return-Path: <SRS0=NGNk=WI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C89DC31E40
	for <iommu@archiver.kernel.org>; Mon, 12 Aug 2019 10:33:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B09F208C2
	for <iommu@archiver.kernel.org>; Mon, 12 Aug 2019 10:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="D1kohbEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B09F208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E2EABB79;
	Mon, 12 Aug 2019 10:33:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 58EF986D
	for <iommu@lists.linux-foundation.org>;
	Mon, 12 Aug 2019 10:33:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
	[210.118.77.11])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 371A187D
	for <iommu@lists.linux-foundation.org>;
	Mon, 12 Aug 2019 10:32:59 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
	20190812103257euoutp0103cec62d4647e6972676f92962315dee~6JldrEvyF2529525295euoutp01A
	for <iommu@lists.linux-foundation.org>;
	Mon, 12 Aug 2019 10:32:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
	20190812103257euoutp0103cec62d4647e6972676f92962315dee~6JldrEvyF2529525295euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1565605977;
	bh=WfCPF6suYg6AJTiRWu79YNFggXctmiOm+yE/cpdp1iw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=D1kohbECpzpp043xPvtllytinl+A4ZeuyYEZKkB4sngb2jTgyAAQwKt3JEm6SOt/5
	E/pwPTj8p1G2OmagCe4Xm2nsRu4tXseQguV14BrNeI63qX7vBSMM/uyRNfw0IoIOxD
	ZuHfqd1ga/JC4rsTol8VbwVRSdfgPSiGisnSRNm8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20190812103256eucas1p1d28d5df455544b8a2ab74fe4aa3d392e~6Jlc7_4fg1158911589eucas1p1Y;
	Mon, 12 Aug 2019 10:32:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 5F.5B.04374.850415D5;
	Mon, 12 Aug 2019 11:32:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20190812103255eucas1p1cdab368b5fb06e4e3df62dfdc679f3af~6JlcGzjNu2368323683eucas1p1n;
	Mon, 12 Aug 2019 10:32:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20190812103255eusmtrp2c8916dc1dcf329bab7bfee4905826cd4~6Jlb4wKW10192801928eusmtrp2d;
	Mon, 12 Aug 2019 10:32:55 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-d9-5d51405816d1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 46.3B.04117.750415D5;
	Mon, 12 Aug 2019 11:32:55 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20190812103254eusmtip27324eb6aff714fc01f6f5beab6418dbc~6Jlbdw6ma1210512105eusmtip2e;
	Mon, 12 Aug 2019 10:32:54 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH] iommu: exynos: Remove __init annotation from
	exynos_sysmmu_probe()
Date: Mon, 12 Aug 2019 12:32:46 +0200
Message-Id: <20190812103246.18049-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsWy7djP87oRDoGxBie/81lsnLGe1WLBfmuL
	ztkb2C3OnwcSM87vY7JYe+QuuwObx5OD85g8Nq3qZPOYfGM5o0ffllWMHp83yQWwRnHZpKTm
	ZJalFunbJXBlbL53jqXgDXvFxq6rjA2MV9i6GDk5JARMJBrWN7KA2EICKxgl3i3k72LkArK/
	MEosODqHFcL5zCjx5O1XFpiOvZN6oRLLGSXeNx9lgWt5/PUAI0gVm4ChRNfbLrAdIgLuEtf/
	PAcrYhbYwChxfE8TM0hCWCBU4v/j+2BFLAKqEpNXXgWL8wrYSnzoXcAKsU5eYvWGA8wgzRIC
	J9gk5r78BXWHi8Tt1w/YIWxhiVfHt0DZMhL/d85ngmhoZpR4eG4tO4TTwyhxuWkGI0SVtcTh
	4xeBVnAA3aQpsX6XPkTYUWL63dksIGEJAT6JG28FQcLMQOakbdOZIcK8Eh1tQhDVahKzjq+D
	W3vwwiVmCNtDYsqrY4yQQI2VOPV5DtMERrlZCLsWMDKuYhRPLS3OTU8tNs5LLdcrTswtLs1L
	10vOz93ECEwBp/8d/7qDcd+fpEOMAhyMSjy8G34HxAqxJpYVV+YeYpTgYFYS4S35CxTiTUms
	rEotyo8vKs1JLT7EKM3BoiTOW83wIFpIID2xJDU7NbUgtQgmy8TBKdXAWNPG2TDnIr/0kXVC
	fKfn7YpjF2Ap2rp+37fDttHSsRJbQt5VVWXNzJ6bdVdkw16dBYv2n+lZFz470kf5omqguXLV
	/hesuhdNK57XJ1h9mii2p1i+LHWGmeffB+me/y5wvCr5utpm/rzpBit9bxxI0ZGfXGyY8f4M
	H8sG1+gr/c6Z152eyH2qVWIpzkg01GIuKk4EAMMEGEj9AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsVy+t/xe7rhDoGxBo/+i1tsnLGe1WLBfmuL
	ztkb2C3OnwcSM87vY7JYe+QuuwObx5OD85g8Nq3qZPOYfGM5o0ffllWMHp83yQWwRunZFOWX
	lqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlbL53jqXgDXvF
	xq6rjA2MV9i6GDk5JARMJPZO6mXtYuTiEBJYyijx7N1LRoiEjMTJaQ2sELawxJ9rXWwQRZ8Y
	JS5seckMkmATMJToetsFNklEwFNi5tsWsEnMApsYJT4eP8QOkhAWCJaYfHMp2CQWAVWJySuv
	gjXzCthKfOhdALVBXmL1hgPMExh5FjAyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAgMvW3H
	fm7Zwdj1LvgQowAHoxIPb8TPgFgh1sSy4srcQ4wSHMxKIrwlf4FCvCmJlVWpRfnxRaU5qcWH
	GE2Blk9klhJNzgfGRV5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6p
	Bka2Ey+0ovJY4+wm3c++qZErvXSrxubzIrs0btg4Trr68OAZTanPNzc/Mes3umHTsmhlwv/c
	JS6Lsmu8Go2nmITMSfy9Ss325CfDubNNDzCYhGn9L3hj8iF027vSytv+j2/9ll3k8FPEu1Jp
	t9esB60fbnOqdWYGPhL7k5AYXX91u4TEpde+ngeVWIozEg21mIuKEwGyxqFTUwIAAA==
X-CMS-MailID: 20190812103255eucas1p1cdab368b5fb06e4e3df62dfdc679f3af
X-Msg-Generator: CA
X-RootMTR: 20190812103255eucas1p1cdab368b5fb06e4e3df62dfdc679f3af
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190812103255eucas1p1cdab368b5fb06e4e3df62dfdc679f3af
References: <CGME20190812103255eucas1p1cdab368b5fb06e4e3df62dfdc679f3af@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Exynos SYSMMU driver supports deferred probe. It happens when clocks
needed for this driver are not yet available. Typically next calls to
driver ->probe() happen before init section is free, but this is not
really guaranteed. To make if safe, remove __init annotation from
exynos_sysmmu_probe() function.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index b0c1e5f9daae..a48236c1d5cb 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -566,7 +566,7 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 
 static const struct iommu_ops exynos_iommu_ops;
 
-static int __init exynos_sysmmu_probe(struct platform_device *pdev)
+static int exynos_sysmmu_probe(struct platform_device *pdev)
 {
 	int irq, ret;
 	struct device *dev = &pdev->dev;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

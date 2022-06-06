Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F84C43334
	for <iommu@archiver.kernel.org>; Mon,  6 Jun 2022 06:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1934F60DA0;
	Mon,  6 Jun 2022 06:20:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5CUlgu-7k6is; Mon,  6 Jun 2022 06:20:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F250F60D5B;
	Mon,  6 Jun 2022 06:20:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4646C007C;
	Mon,  6 Jun 2022 06:20:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B971C002D;
 Mon,  6 Jun 2022 06:20:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D78C81D0C;
 Mon,  6 Jun 2022 06:20:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iKAcqZS7uFss; Mon,  6 Jun 2022 06:20:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8953283372;
 Mon,  6 Jun 2022 06:20:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGcMjBA4IAx2mEiIDAlCIX67CCFMhUtMYv60zw0osDpL97q0LfsN+hxR4/94p9h+DALvmJNqsqLtpBR4LiIidvqG2iVk32fXvEHfL1uBJL4PcdhNK0TNqUBt/z8hAYqQqh2EvqT+pLi84M7ERQvY4y5PuQdkpeR24tJZPmKNBChidIC1Ye1eWUllPXJpYCCsz3F2NMVKrTMYwBJbGpVsjnwfgH1uJTn/uWt0wJYnun91vuYvh66nojiK49SIl76ljulPeWLyoHNjP2VfH2CBXF16CrSJeftEGj6dyXva7gutP6PwFx/Z6yIyXFIE+G70G49G9OomItZU1Scnp5eLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeO7Te4yt4I3yBW6/n8sTDab7gbKG7kE6H+bEojxsls=;
 b=ROlR5sVzYZbqKOnILTWxcLGXCLNNdCxqKXYZ8360hsoCWuihyIvjXIDkL4CZf5fJmnNuonDRhp3RngZxeYu5Kdltp+ic7z+4W5a00L0HaVn2ooTo2cQqSEWDjGtbPivDjXw8SG7XVrSgg5ZhO9+F6Sa6hrJkoBFtqOV6xVJRgnTaJTQk34J4CLq9ojXumJCzHJU5ots3wm1WD9KvAiKcuc3oCLwAh79E+OCs3+8zqt4lA5OqqaGAT3E51MAbmLRc7skysXxQJa0ouzCBiUyTh/R4jR/Hvr0YJR9AunKna5o4SVr2Dnl9cR9ByZh/oJLTfkWfDc4PAjbnuoQmqmMrYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=samsung.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeO7Te4yt4I3yBW6/n8sTDab7gbKG7kE6H+bEojxsls=;
 b=sENtcgjYXlx7gF1Ww8pbiuMwRJ/UhVPfvEiS6SG5dqH2SW9aZTLDbH7YNcpBj0y8rlDMLqi0ymZUbxCTQgvmQqcgLXsp/tQMfps8ZJ0MeNwzeAMlZSc2THfYZ+hJ7da55qfjM+fDWejB9ZXUuQna1t+cCJfPbmhHL/h1uOlx0kZoIG7MUD/yMHZmDkwPnxuyOsyeK9Sirgmnj3EAjy6aQ70yYfcPeVsgftxdTdjY1fspMXRfMy6RmRpMSrsJQZJgMUk6V7Ijy/YRyn0h3ujniXtkUv1b2XN2ttdGJzX8lKlFTSMdS0YaK12UEnMhKgM2oFbBkHYKEtoiu7Fq7ht70g==
Received: from DM6PR13CA0049.namprd13.prod.outlook.com (2603:10b6:5:134::26)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.18; Mon, 6 Jun 2022 06:20:00 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::66) by DM6PR13CA0049.outlook.office365.com
 (2603:10b6:5:134::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.11 via Frontend
 Transport; Mon, 6 Jun 2022 06:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 06:20:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Mon, 6 Jun 2022 06:19:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 5 Jun 2022
 23:19:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Sun, 5 Jun 2022 23:19:56 -0700
To: <jgg@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
 <marcan@marcan.st>, <sven@svenpeter.dev>, <robin.murphy@arm.com>,
 <robdclark@gmail.com>, <m.szyprowski@samsung.com>,
 <krzysztof.kozlowski@linaro.org>, <baolu.lu@linux.intel.com>,
 <agross@kernel.org>, <bjorn.andersson@linaro.org>, <matthias.bgg@gmail.com>,
 <heiko@sntech.de>, <orsonzhai@gmail.com>, <baolin.wang7@gmail.com>,
 <zhang.lyra@gmail.com>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
 <samuel@sholland.org>, <jean-philippe@linaro.org>,
 <alex.williamson@redhat.com>
Subject: [PATCH 3/5] vfio/iommu_type1: Prefer to reuse domains vs match
 enforced cache coherency
Date: Sun, 5 Jun 2022 23:19:25 -0700
Message-ID: <20220606061927.26049-4-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220606061927.26049-1-nicolinc@nvidia.com>
References: <20220606061927.26049-1-nicolinc@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb407244-624f-4b4a-99c6-08da478495e9
X-MS-TrafficTypeDiagnostic: DS7PR12MB6118:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6118FD6562C7A810C4BCD6CCABA29@DS7PR12MB6118.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8tdHq15yT1WINxiiwZZdMsO9IrJtkA4R9MXKqwKxXQG6mgzUX3kzv9rK+rShRMSWnkD6J8/Yu6KG2q23Fsy/6CG4W3Vo7HrhwugSUVcZEJzK55e2Vge6vsJdmr/OTVkfBq7ifIz2vxnJ+Q2sCWDBM0E+zR/OGLxM5wXspdnewX51zk5kEhankAbfsmXSE777idXG+f4gLjLmQOvEZEvJrzpdp9db1MxcF2YgYlnPxbfrmY2lldC5dJyWkYu01PjIOM2vzQ+CN/XeE8gw8QM9TdKXh7oaP5YjUsOhnaS+synX6yddE/NgHpPhhju9OI556Cg2b0rVxo3DUdl6UOeK2MmlaWnZpBSWRnFPqi/j2XIZpwMUVhTflKx/Z/v0/kir0tWA9yiK0U6RR9TYlJb5sjHX6KJjNJFxBSeIGEMVGVWzXbcpNtHBjbshi5nXZRxQ2+K7SsrnPHA8KgPwRY7eCekAfZlrSYGm0//m7IX9gSH3ci5LqcxUq8U1s8GJ/t4A8Mw92r7Et6WZiBRaEETgpSmNkc81MrjVhf7HH5SeYfLOCqrt95mYq70nP01MUfaDUpPppLCD9r/ybwIfZnCULmxrTdnaZfbAzFGrm1ujrrobmL4WpzRRMnhSC39Xr6XzQ915Ucie2z7KIUkMNZ+rWoHkqgKQOWdzLL/RUZZHODr+Yvpjj6hMIiLqMQMDyHroNlzuY2pk4HxgIvmFtjHzUPsYmYaWKvuENFgOSI0dndstJUI4viewQOj4dupX+Lo/V8EZ3mEG8tJ3An4oGu7yQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(2616005)(6666004)(1076003)(47076005)(54906003)(26005)(86362001)(40460700003)(426003)(2906002)(7416002)(7406005)(83380400001)(186003)(5660300002)(36756003)(316002)(81166007)(336012)(8936002)(82310400005)(70586007)(921005)(110136005)(356005)(4326008)(70206006)(8676002)(36860700001)(508600001)(2101003)(36900700001)(83996005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 06:20:00.1466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb407244-624f-4b4a-99c6-08da478495e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
Cc: virtualization@lists.linux-foundation.org, thierry.reding@gmail.com,
 alim.akhtar@samsung.com, alyssa@rosenzweig.io, linux-s390@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, kvm@vger.kernel.org, jonathanh@nvidia.com,
 linux-rockchip@lists.infradead.org, gerald.schaefer@linux.ibm.com,
 linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 dwmw2@infradead.org
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
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Jason Gunthorpe <jgg@nvidia.com>

The KVM mechanism for controlling wbinvd is only triggered during
kvm_vfio_group_add(), meaning it is a one-shot test done once the devices
are setup.

So, there is no value in trying to push a device that could do enforced
cache coherency to a dedicated domain vs re-using an existing domain since
KVM won't be able to take advantage of it. This just wastes domain memory.

Simplify this code and eliminate the test. This removes the only logic
that needed to have a dummy domain attached prior to searching for a
matching domain and simplifies the next patches.

If someday we want to try and optimize this further the better approach is
to update the Intel driver so that enforce_cache_coherency() can work on a
domain that already has IOPTEs and then call the enforce_cache_coherency()
after detaching a device from a domain to upgrade the whole domain to
enforced cache coherency mode.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/vfio_iommu_type1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c13b9290e357..f4e3b423a453 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2285,9 +2285,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	 * testing if they're on the same bus_type.
 	 */
 	list_for_each_entry(d, &iommu->domain_list, next) {
-		if (d->domain->ops == domain->domain->ops &&
-		    d->enforce_cache_coherency ==
-			    domain->enforce_cache_coherency) {
+		if (d->domain->ops == domain->domain->ops) {
 			iommu_detach_group(domain->domain, group->iommu_group);
 			if (!iommu_attach_group(d->domain,
 						group->iommu_group)) {
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

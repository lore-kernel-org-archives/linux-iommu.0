Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4942FC433EF
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 00:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED79540866;
	Thu, 16 Jun 2022 00:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MBOg1t5l10qm; Thu, 16 Jun 2022 00:03:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8D8A3404CC;
	Thu, 16 Jun 2022 00:03:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66B29C0039;
	Thu, 16 Jun 2022 00:03:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DFDCC002D;
 Thu, 16 Jun 2022 00:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1CEF383E96;
 Thu, 16 Jun 2022 00:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JjM1g5lFRThb; Thu, 16 Jun 2022 00:03:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::60b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E978883E78;
 Thu, 16 Jun 2022 00:03:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLhClgszpCY4VaUsMMhk3H3PIX2PL/ZmJQqRdw/jwJUbLRA3DksAoOL1zqdCA4tQDPlnxG9RKUyqggMluYyGF6lSPGpVeEq5cOjtDrkTLKIZf+m2LUFJAeQiDd0Do7+AYvN2WPI+AJPT0IHWqiqZSVyM9RT4aQWu/9ua66tJXetAhYr01MsxvxVGvLKN8ng584lEmtSfJEyk1Rxz7llKM3a2I1nCWdBGysX4roDbjy/b1l0ZpC/nIhdpn1hhWd1fZ+MvMGWW1v9Tj23RPcMzXth1s3b1dxujPOp16mWbbB6h47GNYJZwy4hzbTMzcVq8ubFUJjBL9JzSDzyndRL1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gn+Ww60SCEC5BMKh9fNN8EM7WCO1nBT0MqihO3MBanQ=;
 b=mMmDMiE9aRmxhABur9CGDPyXOQONJp1XzVaPG3vJL+TeAGIdFwcBQq0WTyjRD7vHL4Ui9abtIURAA7GAfHT4foVPK5+1OZMGpQ4XRnjG98xAx8xMNPmvyop34RZeQybMaiz4miAlP+pRc1B52XH7Wvl3BsAvehgB3pj3YimwV1y1qyifNTmnDItoJ6KC4eGk2D/jyWvhBBWMVHn+YG2tFPa7YPh9LGEF0Qc/wM4NKc6Nt664ITOHvMci+WSWfFdBpzXXwQBFxjKIZlb7z1f8y93I9rlxVj7y+QyqeEglqjLxsAQJbPOX61PYeJa1bJpyaaHKVsQWnkxhKxGaRtGXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn+Ww60SCEC5BMKh9fNN8EM7WCO1nBT0MqihO3MBanQ=;
 b=L8CQkNe3tiQ7ZPC/rAUx99lBFumMXUvuo3C5a1Wlht/kRXtXdfM5pk5WO0PftJ/TKPr0yJIn446+tf9deo+5tYzmsFUJMomeLadBBNl7jb5uj/N2cy+/HAS3N+sYHuc2AixoInwEimTO3tSPznmZ/WFTuLk5qhsxoPOvt0va+1m6ySNetV/X9mCOl0K8aULxV9GreCqwvwjLbVRHambzxZJXbVFjPI0HOxTm62YAlbi0FUvDuNqBeLnj4mIVvT5F5vYylT/mCyKH/QjAU7SuSTp97Soulsz4sv3+/iWFoG+HL5wxnEShwShcsonvMq5sHTXI1hZWY72ids2JBdG2fA==
Received: from BN9PR03CA0783.namprd03.prod.outlook.com (2603:10b6:408:13f::8)
 by BN8PR12MB3459.namprd12.prod.outlook.com (2603:10b6:408:65::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Thu, 16 Jun
 2022 00:03:18 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::68) by BN9PR03CA0783.outlook.office365.com
 (2603:10b6:408:13f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16 via Frontend
 Transport; Thu, 16 Jun 2022 00:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 00:03:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 16 Jun 2022 00:03:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 15 Jun 2022 17:03:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 15 Jun 2022 17:03:14 -0700
To: <joro@8bytes.org>, <will@kernel.org>, <marcan@marcan.st>,
 <sven@svenpeter.dev>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
 <baolu.lu@linux.intel.com>, <matthias.bgg@gmail.com>, <orsonzhai@gmail.com>,
 <baolin.wang7@gmail.com>, <zhang.lyra@gmail.com>, <jean-philippe@linaro.org>, 
 <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kevin.tian@intel.com>
Subject: [PATCH v2 3/5] vfio/iommu_type1: Remove the domain->ops comparison
Date: Wed, 15 Jun 2022 17:03:02 -0700
Message-ID: <20220616000304.23890-4-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220616000304.23890-1-nicolinc@nvidia.com>
References: <20220616000304.23890-1-nicolinc@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcd232c9-3ab5-411d-da0c-08da4f2b9e09
X-MS-TrafficTypeDiagnostic: BN8PR12MB3459:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB345913323C8921E0DF08421EABAC9@BN8PR12MB3459.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GviFizYT14J0RnxQmWu1nulpkpTsZwgFwWF4UlTM5ExmP+5ZdJ5aQVsspfzwHt7o7nrgTfIaHNLp31mdqKc4ThrvPt3i5HEFh3SbROjXRA5U5vlDQljy1kyjbuh8qdHWyaN3Iq4jdtU7t2uGRaZKDUIJkOzBaEERMSqulQpv7YLukkLHcSmCT/CVdvxic5ToJDBH9HSeKrKI6Yw6hLKq4W7+wG9UOXuuCrBEWJQa362K20fn/LmO9cBD4Wq8c141hHnk0F3pSdXUTW0XjFVRPafh2CLIL+O3oAXNawzTXSKLeIM0/6vLlvfFnq7Q+sryhI5H0lFzFMSMpR7oSgB9lkwUSPn4TPx0v7MJi6QXfhaMScvZkqSZGTPAHegrOIaFWqMHAxoPWOONfGbCsjtqBZFhRzh9YuRweeacTTAi4zbFOE0zRYlrd6BRuWmBzA2HPFjlyzFyHgozAmoxCkLQ4ajbVU6c7TJHkH3tXDYz5USmNe0wRKesRIYmPPR/9gn6MX0hwHRowqHzWFgyjbo/CO+evkAQn2iEgfVa4wRQ/ANXcG4yjP7gpvlFDubF8tLhKRbOy6Ls3FeEsMfu9eIzawphJbc/qeQPYCieMaNUWIrUK6cfE5tKtS3JPzRx5V4TW3jhFV+GItPsqVCyWvUe7TzkbMPh41OsNzT65JFpYSPKxC9TC42W3YJ7wCtzsLW4iXQT5+zzVcnpf17GCH5BMzNfAUS/7UNEq23XrP1NCZ78QW88yMeHTQuVEc3TMw444QBqDlSc2R2y3CTiXF08ed/UHL4nurXzG7q6hU4qO6P8+gui1S/YfIFp00qSi108DhkKOiyNPUhEsCTjWC35nz6iFPT62wEICl17PCOdMM0=
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(6666004)(7696005)(2906002)(5660300002)(82310400005)(8676002)(83380400001)(36860700001)(4326008)(336012)(8936002)(508600001)(7416002)(966005)(47076005)(40460700003)(86362001)(81166007)(7406005)(426003)(2616005)(54906003)(1076003)(70206006)(921005)(356005)(316002)(70586007)(110136005)(26005)(186003)(36756003)(83996005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 00:03:17.8261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd232c9-3ab5-411d-da0c-08da4f2b9e09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3459
Cc: jordan@cosmicpenguin.net, thierry.reding@gmail.com, alyssa@rosenzweig.io,
 linux-s390@vger.kernel.org, saiprakash.ranjan@codeaurora.org,
 kvm@vger.kernel.org, jonathanh@nvidia.com,
 linux-arm-kernel@lists.infradead.org, yangyingliang@huawei.com,
 gerald.schaefer@linux.ibm.com, linux-arm-msm@vger.kernel.org,
 christophe.jaillet@wanadoo.fr, linux-tegra@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, isaacm@codeaurora.org,
 cohuck@redhat.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
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

The domain->ops validation was added, as a precaution, for mixed-driver
systems. However, at this moment only one iommu driver is possible. So
remove it.

Per discussion with Robin, in future when many can be permitted we will
rely on the IOMMU core code to check the domain->ops:
https://lore.kernel.org/linux-iommu/6575de6d-94ba-c427-5b1e-967750ddff23@arm.com/

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/vfio_iommu_type1.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index f4e3b423a453..11be5f95580b 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2277,29 +2277,19 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			domain->domain->ops->enforce_cache_coherency(
 				domain->domain);
 
-	/*
-	 * Try to match an existing compatible domain.  We don't want to
-	 * preclude an IOMMU driver supporting multiple bus_types and being
-	 * able to include different bus_types in the same IOMMU domain, so
-	 * we test whether the domains use the same iommu_ops rather than
-	 * testing if they're on the same bus_type.
-	 */
+	/* Try to match an existing compatible domain */
 	list_for_each_entry(d, &iommu->domain_list, next) {
-		if (d->domain->ops == domain->domain->ops) {
-			iommu_detach_group(domain->domain, group->iommu_group);
-			if (!iommu_attach_group(d->domain,
-						group->iommu_group)) {
-				list_add(&group->next, &d->group_list);
-				iommu_domain_free(domain->domain);
-				kfree(domain);
-				goto done;
-			}
-
-			ret = iommu_attach_group(domain->domain,
-						 group->iommu_group);
-			if (ret)
-				goto out_domain;
+		iommu_detach_group(domain->domain, group->iommu_group);
+		if (!iommu_attach_group(d->domain, group->iommu_group)) {
+			list_add(&group->next, &d->group_list);
+			iommu_domain_free(domain->domain);
+			kfree(domain);
+			goto done;
 		}
+
+		ret = iommu_attach_group(domain->domain,  group->iommu_group);
+		if (ret)
+			goto out_domain;
 	}
 
 	vfio_test_domain_fgsp(domain);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

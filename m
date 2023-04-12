Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AA45683;
	Wed, 12 Apr 2023 13:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo0DfS9fK201WD1eVL78I4zJa/mi7ivaL43yIrGC2zzQFPBsx6qaqpToqszdJ8LruLqVYoIppVNx20HFJQJR3lf/I+DdhmkR5rvHyw/NPk8D6/8h71HFD5rhDlOokcJbv3lEj22ND1QTdt2xLi7VOaJj/+FKgxFQvkAK8+N8Fa1GjqhznYzg534yV/WKUAgVcY8mMt1soBX8npfd9DBDnGd3pOGz0ulP/Bj25XxrQXIbmCWQouMOuG1YZ+b1KxdgcdwOPz5HZefJ+AIirix8F/N3xJ4pd08eQbTyzOKrBRMcOcmqZRj8hsmPwGOave3XiNrBSXSwER4rmS3A4pS03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8razfhXxnq3TD/J/8UIqjePLMxN1Ztw4Y5oLZJnEpus=;
 b=S8ykx3a1+FLyzaYfIT7uekHbWd/r84vWt9iPup9ezIQhECNyfJxbc61XzmAWzITWOGS2ebAwqhoWeYWWtMFsW6Ju03+znAKz8krIBKN8vk/xOioGMWmt+IelfNCBrgmNIYEVd9LM8NTh4IFyonf1hJRrFCPxgrIrKoOKgL1J1ZdFRyDhIsqwSxsCsfM++azXGHLGN0Es1kWOMQeYsqH+HBlq7HSWBJizxwX71gV8DPfYsZ2G94boIVc8TzUcvudMG0+EZajip8MPHq/45Fa9rMb6aRkG0Pwq+gPZ0MvKTuWKegcojURg3ga7OjgND785j70hN+nAfs7yTpvgotru/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8razfhXxnq3TD/J/8UIqjePLMxN1Ztw4Y5oLZJnEpus=;
 b=B8g7YCN+V1NP6bnM6ItKSeVESdsmRmvT+oIOlkcWhAL3l7PseFvUICBwITGGzbU8f7chD+5eDBXZyk/txjCbyYgc1ocB4qCFdMenv4tDvCfa8E6CwcHw2SUHvDNOgZOtcgrPLl8ygixIM1RvZ+q84NkHDt1yaiuXJNpfj3wvAwLIzKJVHcr07SKdeIDxZVT+bwC9frxuAmnJng26ZNjl3zkXU9xshFmNnsiFqTKYJTSB+IeptydXYmmCSmSoUg0PPgm2enOJRXk6mD1Ck44DeNchJnD3SIpBETFWFjShzbpxRbTdfcXMaU+DG67Gt5Lw1hgRLCcFgu79QNAnGrkPKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Wed, 12 Apr
 2023 13:51:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:51 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v4 15/17] iommu: Allow IOMMU_RESV_DIRECT to work on ARM
Date: Wed, 12 Apr 2023 10:51:45 -0300
Message-Id: <15-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0009.prod.exchangelabs.com (2603:10b6:208:10c::22)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 2219574d-0e8c-4b3f-7d07-08db3b5d0fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3clHIvm3BK+i4fQVE2oCpieNudpJXPbv0xbU9SVYeJbVPM6bVSzx7bHXvaABg4lPBjXVcO25W8XsrFjaFQ8jlsZXzhnP9loyGXLuJDzewUzpIIX49RShsbe+pFMLu3Fvj/qNMAP9Ktp3lrDuWhQGwBx1Za5ySl/0ajQfMsc2u4Hh/S7oxSwgZF02ckz0fJZwtehLw5Nrh3RmSYRuucCEtMjjAuf1h1iN9hNj+v6/WfvnZIvIY4ue1c4R2qB83Ux8Bi3lUKtgITxs86Iq4Du6smpZLJAlojLvRLDl48V1ra0V0Bb41XWLITVEo4xy88kjmGFaLm0NEksAEc/hSUDTeiW3Sim6oXUWITltCzdyPjpys8Fmi+qP5wExH2cQjG+CFBP7HptfnGZV7HQOZ5yy0pbwrXVzvwqY378bHr1ima8LnSKQphA+km5ycviXdjeUSQaaf/D4t2k7leg2Eh7kYEWxAWdZIWmt4QKonNgar+21cz9HmZoBurfQTZXL6V648kg8neQjmjCM7QX16Hrg+ZGe650qCXGyHukvlOeWPN0OedJF6xR3CR6EJ3XSDjny
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(6486002)(4326008)(66476007)(54906003)(66946007)(66556008)(316002)(110136005)(6666004)(5660300002)(478600001)(41300700001)(8676002)(8936002)(7416002)(2906002)(86362001)(36756003)(2616005)(26005)(107886003)(83380400001)(38100700002)(6506007)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fgvWZR7k2sZuO0MvIvhbg1TUaCE0XyMgiTJmfbD6CAoE8upAjUpJLpvbn/5Y?=
 =?us-ascii?Q?B3+STNQ04OsBdrIBLFGBZqtmmhQcw3+eC3Xmr7jLNYMJCoRisqmR+VB81O9n?=
 =?us-ascii?Q?6JpcxIlubKVWuLuO1s9iOB0KD77oty8sr1JufB3eZRUDF+AY6YfeVEKIuRNf?=
 =?us-ascii?Q?4FwgJMZj7m6i2rc+1knYjQCsaaJdbsvlAruJ+rCkhb1WQBl7kXaGNABtbBjQ?=
 =?us-ascii?Q?hb3WYpEcx2bRFCz/g8LZtWR5ZEACkaXn2gyw97k1QuteCVyPixdCYZyz6HaY?=
 =?us-ascii?Q?wQEqbNHGDep+11cxNW23/YxlfZUoteEMZ1OXvJS+YPFHmgy+C6XT0ycikrAe?=
 =?us-ascii?Q?rZFD1V1WS8h0EMpWSI3pbAHDxGlOSB3R5J0FUbI5OcQRY58pn8Jz6LNEKZog?=
 =?us-ascii?Q?y3iDQxYqyo7CdW6u4vpfG49tt+Qm+QfPaaplwMluDtnbWCD5deCYoIMYbnDd?=
 =?us-ascii?Q?RtDZNmaVsdlI6d8dMv7UmGD2vKamUy8aqR2GJadh/Eo6EFM910UtL12kyDnu?=
 =?us-ascii?Q?2Tz4bIV5JzYr5G354xv3vpXB7IH+9GyoMjL69eoE7FxDBKSRm4QW4RC8qZCe?=
 =?us-ascii?Q?UFDXiTiIu8pebA/StmMMJV9/SJctWwnXNipupdjbDGT0lTV1Zh3sb7CG1h1D?=
 =?us-ascii?Q?1KWQrcqfHdHMp/KozMOjRsAZqtrbYMllmV+P47K+Xv4Y5BbUcsKHnlcIULD9?=
 =?us-ascii?Q?pjatM5yIy1+QEIsC/dQqcVbnnpIeASDo1nD88TxJvfK4SQcVpuhVkupc104q?=
 =?us-ascii?Q?yW8XDjvO1Q0DS4mgkv8TuPHmKzO30xykq8uVel/N+HSAEICLNaxLXL4r3xYy?=
 =?us-ascii?Q?oMNTE3x6G7sPDn7wbzb4lsT4BCy3s1Jqcu2/waV+evVTs0SADrJiuuYiRYXS?=
 =?us-ascii?Q?TjsJz6yHipwgJJJ/XMk0PBUVqnj171QdV5TdvoSO7pJLra1XRHO1yyOlhQa3?=
 =?us-ascii?Q?HceCYLBWAIdxojk4oxZNXFPNhlt1wH8e4xFKAGO74z9pZJdRAuXFrHsTITBt?=
 =?us-ascii?Q?K1SBSJo0ySxpzzE/MyZEVUUJke0T1ZeeYE3j11/TUqXjNXuPUhnq+HGinl6q?=
 =?us-ascii?Q?3oehOk84s3uqTbECoSiF4Id8ZZVvgEAkON1cG8lp9ApLxPJF8rS+I9m9C6WZ?=
 =?us-ascii?Q?4E2JRjg6oX35yJUEUyooT6R6uvUHdtu2eGb2hbydMVgMmp0hC1CZg43dZbFo?=
 =?us-ascii?Q?3pJvTXFJdUywwth5fs8EH2cDNPa9yuHXBxGVJNNExxfJHH7aUbQyfYsKZ4H1?=
 =?us-ascii?Q?orryLNW0SExg4PNCi8aPDJSg9i2kvsjLNIzD2wyuh0UieqamPrWpfEXzqeAd?=
 =?us-ascii?Q?DaBHKv6N0DSEchCUmG6oJn/JVbZyV0YOHSXRO5iAJsqoT5sdP9/B65AbJWQh?=
 =?us-ascii?Q?ATHY+T4HEpCRt0Y1KI8wJ5uYWSZvspML/lKV4Wdu3rSIi202B9Z8iL/7q0UR?=
 =?us-ascii?Q?3xlMCVyxL3CGoSQqUQ+FQW3PWs2atwfUIoaeQYSPgrS6MNwgv/9EacQpj7Jy?=
 =?us-ascii?Q?WXWYmzJdDbCEG6u2CUjfmSchktiyA7SHNRLQMRBfyFcHAS37Z9iFMkK8n3ZI?=
 =?us-ascii?Q?eQocgYHaxX79t1hfU/hKgsGq+gmAkOelCFGCL5Xe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2219574d-0e8c-4b3f-7d07-08db3b5d0fae
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:48.5759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUJCIg12fKdL37PPCBF+OLky0aUl2rm57tgEti/u2qtN4FL6BthkDHjmE6SxJYAD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957

For now several ARM drivers do not allow mappings to be created until a
domain is attached. This means they do not technically support
IOMMU_RESV_DIRECT as it requires the 1:1 maps to work continuously.

Currently if the platform requests these maps on ARM systems they are
silently ignored.

Work around this by trying again to establish the direct mappings after
the domain is attached if the pre-attach attempt failed.

In the long run the drivers will be fixed to fully setup domains when they
are created without waiting for attachment.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8744b15f0bd1f0..4c0908402f0139 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2860,6 +2860,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	struct iommu_domain *old_dom = group->default_domain;
 	struct group_device *gdev;
 	struct iommu_domain *dom;
+	bool direct_failed;
 	int req_type;
 	int ret;
 
@@ -2893,8 +2894,11 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	 * mapped before their device is attached, in order to guarantee
 	 * continuity with any FW activity
 	 */
-	for_each_group_device(group, gdev)
-		iommu_create_device_direct_mappings(dom, gdev->dev);
+	direct_failed = false;
+	for_each_group_device(group, gdev) {
+		if (iommu_create_device_direct_mappings(dom, gdev->dev))
+			direct_failed = true;
+	}
 
 	/* We must set default_domain early for __iommu_device_set_domain */
 	group->default_domain = dom;
@@ -2918,6 +2922,17 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		}
 	}
 
+	/*
+	 * Drivers are supposed to allow mappings to be installed in a domain
+	 * before device attachment, but some don't. Hack around this defect by
+	 * trying again after attaching. If this happens it means the device
+	 * will not continuously have the IOMMU_RESV_DIRECT map.
+	 */
+	if (direct_failed) {
+		for_each_group_device(group, gdev)
+			iommu_create_device_direct_mappings(dom, gdev->dev);
+	}
+
 out_free:
 	if (old_dom)
 		iommu_domain_free(old_dom);
-- 
2.40.0


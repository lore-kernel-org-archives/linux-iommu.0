Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26581FCA
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iqEPv8G9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOVXxFoEkLh0YDSyzcN2GncHx+KzKK5yJqu5YNU9RVdpG9GNj3Ro39TlHlR4HuiX9Yar16UigU56TYzvQROV+tSkMLPBrWPalDgHrwcWLTmZ81nGs4vY9yiiZfRCPcQQHPFKcx9Y1hzzO7LotaDZY/oROCzQxyV/jqmOhhH1tib8PAmjaIaSrnLy/Tfxs2O3CO0gky5jV15P562h5n0LDi0hf2BT63JF5f7LuwtK09jeQYAsxB53wPli216ZfjNFaeAi8WpZPj/dq041pbPbvg3WyqYS+A6sL6+uiRsdjc6R+/SEqtSHoO2rPjKypOGNGK2LiSCE+EuaJzdFQ0QtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrH88YvhL7emgKkg1+uNI0DjAqNBV+FOmX3mNkYrRd8=;
 b=XH4V+SodF0Gx8raQ1DXZEQC2sb8OANzdH7oB+Vw4DZCouiF0AKy2u0WOzKuYpdlp+zqRFgaCeN1bNsocx3JIpGabbWmNqfHSxd35to4cfqoR9jVCVGikh+HXcN47+5HTwv+Ogulx00H+zEyCqW+SFaWM8YSRyCq+A7yX81JOygchbMP9fJIHD+TFzReKzZ8VgJlGTFDE9Gl5K3lweyQ65LEJI69/5q0I4ui0oze3g3oiewyOy0HIGdFQ0TegspZownWLBySpPWHD6ExJvGWZfPIGA92/MJT6x49YHz53rvvwD2CgRr1COsEoYnJwgJI+WyZeJUO6Pgh+gwfL1f00UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrH88YvhL7emgKkg1+uNI0DjAqNBV+FOmX3mNkYrRd8=;
 b=iqEPv8G9+jB+7PKEJMWTBZLs7tQbY68cHtXUCTCmu+ytxdZUd5ZVeBKsc/qmQkfHvvcLlCcrZS1SkKmUMHUCyxkBkA2+0UWOxhp9mgtuNHsc2npPIXTrIWdj6uZIfIq9BE8ea1FKTYaUcgxjp4vlmh7Fo3gjKCYosj/7hubUZnkm8KWvC7A3uYcqjxypDoM1B5dXpMdyhWDZdMYdwDBn+424bcTJGJVteu4jado4OdJM7tZaZMFEusWUsEorTgZrL/qqtBgukVZdDzd7BrvnbM0eqd4ZClpjOwKj/N/8ONRgU3aDdh007LfC1mpFDWZcvnlytOIGhpW8lS9Gi5ZTOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19; Wed, 1 Nov 2023 23:28:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:28:12 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Janne Grunau <j@jannau.net>,
	Joerg Roedel <jroedel@suse.de>,
	Sven Peter <sven@svenpeter.dev>
Subject: [PATCH v2] iommu: Flow ERR_PTR out from __iommu_domain_alloc()
Date: Wed,  1 Nov 2023 20:28:11 -0300
Message-ID: <0-v2-55ae413017b8+97-domain_alloc_err_ptr_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:208:23b::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e294e6e-d457-420f-17d2-08dbdb3236ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qzz1OS7yKMKXeezgAdwiJ77az5OVpe8ZrHFjI0UiuTbQIVuvEKWlqQBOsH1tXnp2+qzJ17oFZ4fr2uIO96qnw7CkkUGv8gf8oaToxYvaCqbjCcygmVXNuaiXV+VFkB8KjQ0Uc5RKYHNdOG+KCWSxtICburHCwh9GWyzXkcTZJI/TIqO/fi11a2MWzoRknBtrqTzzE6HQoIuAA0v97WNx/LtKAHqRewxsOOZM+o3zZZNeaiwNu5syHQL85ok/cE1QLlCMhedfYb2R9Yzc7iEKC0mOBXj89err5PCY6pb3s9rXntUMWtJ0wSfmASzQ9a3M7RAPJu03lmSgIkUXLeu1KEzyySEDJTdTkp6fUIRAsS1j+Y4m9AZJV4hjq4yts6aiEC5m0RMIqnijVXe26BAPB6Unwu4A2aN19qCNqfzzPQAP+wmR69n/IUTFtuBp0la66Rc89BXP7R7Ddyt/a9Ilh5hgDbSF73eOjdCFpO6WeL6en7Nxkgk8qNwxUd31G+eJ4Vx9tRdYgImqf18gWPRn831+9LoVYsNvX9TX4pnadEmQ5qhND2Zrgw35tItFpD/xfdEIdzljX6uAc9Pn0D4uUt/4s12PZbKorLziQBuyRi8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(54906003)(6506007)(26005)(2616005)(316002)(66556008)(66946007)(66476007)(8676002)(8936002)(4326008)(966005)(478600001)(6486002)(110136005)(38100700002)(83380400001)(6512007)(41300700001)(36756003)(2906002)(86362001)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?18Pu1deEkx0Ap9uwJ6UrLLSpZSgGEQH4/cuOvB4cBQRHwf2qaWPW2HkRpI/6?=
 =?us-ascii?Q?hD4Dp1OUErwj9XZqXhCFomShdwpzgZyR8fSDmputAHkEXyFjQKZoPSHTDYGz?=
 =?us-ascii?Q?CKj9TtlG2/fql3nNBeA88C4VWq7rCx1NQqjTUtLkqj/WxQTwPatJdXbCsSP5?=
 =?us-ascii?Q?igocdk+TE2sb0XTaLr7ksuoZ9l/DpFy8jeSSSk1rpjFdOo/jlXL7RLXonS2Z?=
 =?us-ascii?Q?byFRFDnMuU5vOIuZBWGjIOr+0CjhKS4rf8lNJkbjNHUsnc1ToCSqtee0no+Y?=
 =?us-ascii?Q?7stHzIYIQUWFdp3MyoF+NQCfdZ8J1AbAEqZptf4MCLlH0fmxZgqMjOtZfXLe?=
 =?us-ascii?Q?/xFDUigsW1MwyjtG5rczrWPydl+onI3rT2OPFyL+GQntMAtPX6kwxVc6Q4qv?=
 =?us-ascii?Q?XtQMsnYU3tyXM6uM1nN9AdO3dO2yhY2TxJilyS79fXTfZYySAZ2Rrx2s0fqE?=
 =?us-ascii?Q?dDQGCV2gHmRozoKRYyW/YfPEkzhcgmJfVqwg6U4Jb7gn8K0zImBe1n0Jk/Aa?=
 =?us-ascii?Q?xQ00YMpX6juEUUgahNzGBr6CB2h3ZbHn/0gDey9wLfQLEw1v29mpOnBRJAiJ?=
 =?us-ascii?Q?kez9IlmWqwQJsu1wBTzNyf2nUIFSO9LN43pbyRrajuDLQ+fPxg98zLW/nqJw?=
 =?us-ascii?Q?bbirUVvcpmKfv5/s4XH8ljhSy3cat9uNrJSPVwXIIJw9zTgdA7EZBpu8lrDS?=
 =?us-ascii?Q?Xgps8YS97b6pXYZu2ytU+1fkTGVfCoZXhTicjERRQHBAUX57iXdxXxHPYZX+?=
 =?us-ascii?Q?F/iD8FRVOZAN7IELaM3aKW3awykq6W5md2yL2uRH8TqdG0+qiqeXqiLCRl53?=
 =?us-ascii?Q?ijTW3aJVj/7DyshSDP3eYin4tqKQER7qwG/Ckq3BoPNx2+6+XRVnZRhvfg2K?=
 =?us-ascii?Q?S5GK3nlHbuStc7h+a3cx4BL5dulg8XE4aXpK2p1PcTQKg9YZYVVIT3Xz5v2D?=
 =?us-ascii?Q?Xdop0ri7E3j01KR2HvpXnVHNDepaJuD6HxCQDGdyqFn3Uz6n1hVujh7UMeAt?=
 =?us-ascii?Q?LnoAVi4YaEdUO8+P2L7qzjX8eWIx6yb6dz3gbcQMAWABdamWg63yzjSHeALW?=
 =?us-ascii?Q?950sMZUAM8hWhVuxl7fw+nme3oT1ROa1Cw/zL6e2m/62tgqBURXrX3ikdPJs?=
 =?us-ascii?Q?gM+LBdIQWJOUMITq+zT6hxB9kLvfZDaIUrtMONwz5YOUCsf+TrP2OM0CfLuM?=
 =?us-ascii?Q?znXATcwVtXspYi6yD+uMd21rUglgYqqhu/LtLnitPSMu0SWWrd7IKVuCPaNd?=
 =?us-ascii?Q?TaIH/uwkzdl3b06xVY1d0gvUZRqdbp4oeIZaVjut1Za4V4q4Q2LPhq6s6vsP?=
 =?us-ascii?Q?J6MIw4C6HeEUzP7rciN4Jfq/bFLgR/PsIVhD24Ese/34iz3ynFDSw4ojBPNr?=
 =?us-ascii?Q?yVEwG19TyM9Z/ix6l2aeln5n0i3jzK3Lgi9epMBZBjV1jSzg/Jo1+NeMhYX7?=
 =?us-ascii?Q?aHN9nH7mcis8pVl4hoic/CYtjMnVijJ2aecvYpj2gBBt4ZeLoQ6/NLdgzPZV?=
 =?us-ascii?Q?sigCDxBvHgfUpQ0MPpnVuhzgvlxzdEvwrFywZlYY7WsEH5fUiD+/Dly72Kpw?=
 =?us-ascii?Q?4bWo9eV2IXN0I4Lyvq2R4youVCVk1oy7smO3kB80?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e294e6e-d457-420f-17d2-08dbdb3236ec
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:28:12.0515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQKDd83+7lWw8IFbxm6xAVczPKhXlN9XGRlPOfZPuwoHsSaaMUO+/SCLPke3lrev
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204

Most of the calling code now has error handling that can carry an error
code further up the call chain. Keep the exported interface
iommu_domain_alloc() returning NULL and reflow the internal code to use
ERR_PTR not NULL for domain allocation failure.

Optionally allow drivers to return ERR_PTR from any of the alloc ops. Many
of the new ops (user, sva, etc) already return ERR_PTR, so having two
rules is confusing and hard on drivers. This fixes a bug in DART that was
returning ERR_PTR.

Fixes: 482feb5c6492 ("iommu/dart: Call apple_dart_finalize_domain() as part of alloc_paging()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/linux-iommu/b85e0715-3224-4f45-ad6b-ebb9f08c015d@moroto.mountain/
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 59 ++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 20 deletions(-)

v2:
 - Fix the botched iommu_group_alloc_default_domain()
 - Remove the note about the bug in iommu_group_alloc_default_domain(),
   this was already fixed, wrong base follies

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f17a1113f3d6a3..c9a05bb49bfa17 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1788,7 +1788,7 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 	 */
 	if (ops->default_domain) {
 		if (req_type)
-			return NULL;
+			return ERR_PTR(-EINVAL);
 		return ops->default_domain;
 	}
 
@@ -1797,15 +1797,15 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 
 	/* The driver gave no guidance on what type to use, try the default */
 	dom = __iommu_group_alloc_default_domain(group, iommu_def_domain_type);
-	if (dom)
+	if (!IS_ERR(dom))
 		return dom;
 
 	/* Otherwise IDENTITY and DMA_FQ defaults will try DMA */
 	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	dom = __iommu_group_alloc_default_domain(group, IOMMU_DOMAIN_DMA);
-	if (!dom)
-		return NULL;
+	if (IS_ERR(dom))
+		return dom;
 
 	pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
 		iommu_def_domain_type, group->name);
@@ -2094,10 +2094,17 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 	else if (ops->domain_alloc)
 		domain = ops->domain_alloc(alloc_type);
 	else
-		return NULL;
+		return ERR_PTR(-EOPNOTSUPP);
 
+	/*
+	 * Many domain_alloc ops now return ERR_PTR, make things easier for the
+	 * driver by accepting ERR_PTR from all domain_alloc ops instead of
+	 * having two rules.
+	 */
+	if (IS_ERR(domain))
+		return domain;
 	if (!domain)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	domain->type = type;
 	/*
@@ -2110,9 +2117,14 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 	if (!domain->ops)
 		domain->ops = ops->default_domain_ops;
 
-	if (iommu_is_dma_domain(domain) && iommu_get_dma_cookie(domain)) {
-		iommu_domain_free(domain);
-		domain = NULL;
+	if (iommu_is_dma_domain(domain)) {
+		int rc;
+
+		rc = iommu_get_dma_cookie(domain);
+		if (rc) {
+			iommu_domain_free(domain);
+			return ERR_PTR(rc);
+		}
 	}
 	return domain;
 }
@@ -2129,10 +2141,15 @@ __iommu_group_domain_alloc(struct iommu_group *group, unsigned int type)
 
 struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 {
+	struct iommu_domain *domain;
+
 	if (bus == NULL || bus->iommu_ops == NULL)
 		return NULL;
-	return __iommu_domain_alloc(bus->iommu_ops, NULL,
+	domain = __iommu_domain_alloc(bus->iommu_ops, NULL,
 				    IOMMU_DOMAIN_UNMANAGED);
+	if (IS_ERR(domain))
+		return NULL;
+	return domain;
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
@@ -3041,8 +3058,8 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		return -EINVAL;
 
 	dom = iommu_group_alloc_default_domain(group, req_type);
-	if (!dom)
-		return -ENODEV;
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
 	if (group->default_domain == dom)
 		return 0;
@@ -3243,21 +3260,23 @@ void iommu_device_unuse_default_domain(struct device *dev)
 
 static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 {
+	struct iommu_domain *domain;
+
 	if (group->blocking_domain)
 		return 0;
 
-	group->blocking_domain =
-		__iommu_group_domain_alloc(group, IOMMU_DOMAIN_BLOCKED);
-	if (!group->blocking_domain) {
+	domain = __iommu_group_domain_alloc(group, IOMMU_DOMAIN_BLOCKED);
+	if (IS_ERR(domain)) {
 		/*
 		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
 		 * create an empty domain instead.
 		 */
-		group->blocking_domain = __iommu_group_domain_alloc(
-			group, IOMMU_DOMAIN_UNMANAGED);
-		if (!group->blocking_domain)
-			return -EINVAL;
+		domain = __iommu_group_domain_alloc(group,
+						    IOMMU_DOMAIN_UNMANAGED);
+		if (IS_ERR(domain))
+			return PTR_ERR(domain);
 	}
+	group->blocking_domain = domain;
 	return 0;
 }
 

base-commit: e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
-- 
2.42.0


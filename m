Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3E1134A2
	for <iommu@lists.linux.dev>; Wed,  4 Oct 2023 12:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvC7EzPgJ9ZyDrH1T7xMqC+DRXzq5xZo3s2Wa3XIcKVQZZwmgXk9g7KrV49PfW6CWUCaPcd1AQ8oBS5m2W9/gIzJnX0LmZORS6amW6/nrUmvq6gfT3qp5eVyoSnQIgPnWT2swgcDOda0BvUskvJw+pzEyUsESV3KDFI1+rROlwYUCAlbK9YVXwPC6WeFekiQ3TJG6Y7SSMFPyT2SCQ9lNREh8DhwE00HUPJWBzUc/nRujA1dmk9nSd5XiSJ2C1cuPUUx4juDK6xVL7XIDPHO50m7gjMpF8vd8sfwHd5bBR1SBcjWdwKjKkHFG6ElfD/E33bINpa2kq3VwR0GPUe0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2DKphZm0up0FzZnGPxLJD8d9mN8F790WZLC0Z+xNrM=;
 b=fTHW1wP2ihTQi9XCar0XWrBQ6Gb+yXeyMsxAzDpdzToeB93n52l2ZHbXqoJXLxdyIDUDzWZ5EX/GvOgOVHgYbq8k3HGd52G7bXAjUJfEk+gkUbfltlLSo5YONkuUPPyJmQsRXbZ/zgWf4Kx28nOPaaOK3odCjOFPsjAEBLhoFE5bFZ9bP8p7hMinP0fecfkKxrrhdjgv6v3TWRoSqyM63By1jIEXyBTuY6X1D15int/R9CHlW2as/IYnqSi8qFdb++U24Fa7Z4/efpgyqwwxriY2zzJESAb61ZaslnckSoo8t645vT3fc8L8OQYaXNNIJg6kJpyUQmFL6dh8YUEecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2DKphZm0up0FzZnGPxLJD8d9mN8F790WZLC0Z+xNrM=;
 b=tBO2XQdqhofzQ55t4cEEKVk7Q1DOxVonDHlu9m59FWLZQs9PdxujaLGy185Q73TeT5D/OsukAW2HuxbsPN5uyZ9Nmbix6N2nck2F9zc5BsKk0d53eZPe6BDaIgCzgIfXZdwJYA4fOAguJsapqzHK/ud5uxSVFpnaBKbQYgmN3zc4a+wSEZIzKFpeM4tet6M41eXRPNazLowytnIqDxe9DBBooeP2LXdCFW3BE5e0PT/yfiCTyKy+oEfuD98Lx4V/4Q2HqbvSCryAsnrXIhZZYA+Pq1XrqdHJlFz8BgDItIrTL8EmDL0hGS4dOJZO6QeGZHxgOH6wsYDodwEAuG6oVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4581.namprd12.prod.outlook.com (2603:10b6:208:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 12:08:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 12:08:35 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v2] iommu: Fix return code in iommu_group_alloc_default_domain()
Date: Wed,  4 Oct 2023 09:08:32 -0300
Message-ID: <0-v2-ee2bae9af0f2+96-iommu_ga_err_ptr_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4581:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c4cc5e-a4da-44ac-96f1-08dbc4d2a2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aBBQaVcGCkYKwkzbPA3HfSCoD44aW8eRSc4Oc6kscHBRDkj8AFvnPi6NoP1tg4tN8hfc3OqjIn6mRXAJD+/3PdXW+lVZV8nVbhdYEFfQiiFK4+EXLtRzUpwdUaTOYC8cPXBw48hy9nyU0wAB6jzLrCSKqV2a73VD0otv0bdSitT/1ICWToZZ7XERufB5ygndpei4WiVxO9+iphN4gX8q8ZTnyK+xA3GDtQNy+hjWkhIxBjzC2pTjL5aYbdmpjg/aMK606o+Mu6F2OCrH9UHRvErondRj6R/E12CsaFAPchpy5TlJJ7vUOfeSIVebG6QY90hRYz2QWaJ3zT+g3ju0Ua50Gok4nryDCUapRCboPkq/85tLcwx7Sehbh4LOh5Ei47E9Da5SU4RPBcQoOmIv+RQFtiCSrFi9F461qgVqf9VlQzm0GNgcpbY1CcT2SlqauaJwZ43oJrrghzhFrtr2ZZdlYj3vbXaAH+wc9btxxRasK5+HCWpn0vIA+BzufFyqWu2ijYxQFD7vSAF2XNK6EguJwsrqVouMCkU5wcOD3NJcudmOm/9+VWgXKTfL2VtnMzL1JIgzx0623U3OkpOj2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(966005)(6486002)(36756003)(6512007)(6666004)(38100700002)(6506007)(86362001)(110136005)(478600001)(66946007)(66476007)(54906003)(316002)(66556008)(41300700001)(2616005)(26005)(8936002)(4326008)(8676002)(5660300002)(83380400001)(4744005)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OsiQZSfqzCRqoont4Vh0euhXZal1bqJl3WidQSVzj4xaQFk+8sQhykIo8I9U?=
 =?us-ascii?Q?eXW7ehGLa90l9dBHd4SfM9dTpcKXhpM/l8BPPHligE7kh8sjMWtTvrIuTdZY?=
 =?us-ascii?Q?7HY3lZGp+76v9LakQPr0WoGhNLSL6uE2hHA7vlVYtRx6E3g7b5NFNBmwqVHw?=
 =?us-ascii?Q?tXt7crIytp+1qkb1cfzmq11NDGlNYgZtMrKdDtGG3oyIQOByQIXjCHZewRo+?=
 =?us-ascii?Q?RbyTaqVEfmo8fPbJJkX4WnOPqsQCgNk8NiZf5PapI0UwztLy/D9o3pyjDoI6?=
 =?us-ascii?Q?LhkSHnwrUYmJZrYtwnglheO0wqz6AvXZ0gFLMbPQWD1jG9qPNmHdvY1h7CSV?=
 =?us-ascii?Q?mrMyeV3loZqldVGClUwB9cFjhyyY7gQ6zX6mBo628WTGBu+aQuyr/AZd/6/0?=
 =?us-ascii?Q?pMaypncyVlSdbEhCiyDdQSlSVT/58d/Q0n5x/XtgkE4MPJMMzGNALCvl9abh?=
 =?us-ascii?Q?AtSiev9yjfzIYrgPRymz/8mA1ac7nLSPtHuuXd42rg6yJCIfTaZPzeGVDUwn?=
 =?us-ascii?Q?DsKACdUHMswQ74wfM3BSMR4vYdiHvfh1jXZ0tsonn3gKpR+3QA1Jk5yf1kLt?=
 =?us-ascii?Q?k9yawl/2xmkuxyhVVW9ORgbHDjW7JhjtW/NDgSSiTIfbrtKxVETDQORSubhN?=
 =?us-ascii?Q?D5UskVkr3RlQIoTC3cB2FG92sojb3+MkNVe5eQj23l5eIogCtjd0GRRO9GRO?=
 =?us-ascii?Q?f2ZTt+7QuTBi2yVgBrHmSlCRfqQfArE8P4O0ycNbYD4pzHSHFBqgnt0z4e7A?=
 =?us-ascii?Q?DbKDRc7/xKz3/nzrEH3MNPCHcdYUEmRdoEtZR0FhiTdmz39l5R3oElt3Gwu3?=
 =?us-ascii?Q?Nxjsoo92Nk77YW4YcUo6dpv60OKW0tsnOZESwMwBr142ZD0xLON+tZhKfOO+?=
 =?us-ascii?Q?1377wAAQc1mE3WMnLn8xcpgAAwMcbdQF9W8pbFcuY3fy5OqiigtDiUmD6HZT?=
 =?us-ascii?Q?O2rRrl+HuLQoA3bwI3mkeqHmxZrDkdtF998yH51x1gg+wbgbcNHQdXNqFC03?=
 =?us-ascii?Q?3Dod4VpgPdSMGvGu08mqCW05PZy6QjmIKoPUf5eJ1MI1gn7Dyh0iIdVJhLG1?=
 =?us-ascii?Q?1ghrButkzwM0KHD9tKgnRQtoNP+chLDXNuypob7WyzLkdcR6e0HpC3/+Do4/?=
 =?us-ascii?Q?zszs2NPAusAS/sgJTqFku3Q7hCw2iKUyKwlh9o2Y2HKPaRnHJSJjSF8uU1Vr?=
 =?us-ascii?Q?3fqh7vdxMFFMLzvixVcem3ukmuKojKBkojXaMFvODmRb87U3RX0suBAUX/Wy?=
 =?us-ascii?Q?Tw6eWeGHSy4CYz/qBBIXw6rmKT1gIhv/p4MXEfIYaEy+7V6iXysE+BpiDlAO?=
 =?us-ascii?Q?l3hcXq7QOZCGQYORx2JcgvSVqg7CdY+2Y675Qq8JYKiFFOMjNYQN74661Cwz?=
 =?us-ascii?Q?90IjPqu9FG+7EfV+kVt3FEnXtgyy1Fk7uDMOLNqyp6WBTobaFcyJrN4rbtMf?=
 =?us-ascii?Q?+UsfugvumUW9xnhxtjp0hAVi4zVcPsx+oo2ugrvJgYEF25/PpNT+t/Uyp6PM?=
 =?us-ascii?Q?KWHtbQllxkE9+VMOjdHiNgzSJknhwliHg8pC8tz29ku+ZZehkBJnmlgZ/cD2?=
 =?us-ascii?Q?T227KRgAiglAdMGkrTU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c4cc5e-a4da-44ac-96f1-08dbc4d2a2d2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 12:08:35.8021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wekMlZ5aI+eyqBSU+ytWEdBfdbOatTQVjLOw78m2gWb0jeFcNsd3Nzhyql/XdIm6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4581

This function returns NULL on errors, not ERR_PTR.

Fixes: 1c68cbc64fe6 ("iommu: Add IOMMU_DOMAIN_PLATFORM")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/8fb75157-6c81-4a9c-9992-d73d49902fa8@moroto.mountain
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v2 use correct base

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 21d45e6a5931a1..f9f315d58a3a14 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1787,7 +1787,7 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 	 */
 	if (ops->default_domain) {
 		if (req_type)
-			return ERR_PTR(-EINVAL);
+			return NULL;
 		return ops->default_domain;
 	}
 

base-commit: 2fa2db14482619122d67d2cdc8633d4a86101d92
-- 
2.42.0


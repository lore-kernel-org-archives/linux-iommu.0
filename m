Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A66F4F9
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 17:36:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIdM3qhekmT2bdTdtjhkV+L5380NVdrEqE5GpsGCQDkaePz9tdXkOnRUHajpPg1N/hlXxja/gRmOhe+LdWy18XbZz/drirNNNBt7sSeWx77FE+7xEUH65EA9Hipvhxm/lSjZIsvCfXrdPNFE3ASkUtv3/HLw50O7OdQITjnkU4MXZDus6kTZD2fm9lhibKU4ils4qe9D6746y56ex6AI48h+V5ohM3T1pMX00f8RSJnHaC4F9N5+TwEkyWXTIGY5EmCJpm9k6dij+JYQDMKbrzpNuu95cH64luTZN/rVTaVXVu9I0NfT/u+TNuUUC/trot/zUEWuAiK8x3uZl/3zkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq60lyecYUG88diOxy3w+R7lpmSnY0oB44YWn+GmFHU=;
 b=k/bJno4J7GDRQrpyCmD0m0hGUylRNCOHIoExSZABtyB0S4/pXVjvHYtSQ1KwBW5tP0eWRPxrudChaYp2S23U5QeBz9hWfJNwVXkQArpzHcipqppWBsqJ+QmYxlHRHKH2iebbjhBAFXZDzwJfaOBPS05Grj2XqWWN5U/5uoyVusJesd9OgkFweI5od4Fs+CEQKPF1lktA6/4lpSVJj+Gp1bHjw6Hw7kiYxUqPF/nL1O/4J7OA3mWssRWgHN3AgS6irGhpBhsYvN0RwMxNG7fP4OvJSXyd2LxbkkXpkukbqFawnK790vBvGzMNomNNMNlHpIyHsrz9YHgYYZ85dJEOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq60lyecYUG88diOxy3w+R7lpmSnY0oB44YWn+GmFHU=;
 b=ZA68CsYnTbRQu4C/7+DTVmORbvDCPZHu48PH+WuQOxiipLcKfLarwNDwVvjlbD4tEDsEszoxybIJjI2PKtD3HWzoI5Kyu74uIkPAo2kupEzjT9WHP8u5wZPPtCnrbItvF4g9hjxSrw+v45PmAS8ErEO+ZPPaA0IQJJ4Ug9Sf8N9GWOJaLpPMeMImQC7y1llsUcsUthzf2/7D2l8Zf4yvkFgcqj53LHp/l8UM5ab2JlpZKGvnBEs8d/4+JdrTJb7KE9JVuBxvqSY2lJMMOxRtzE/n/ziN20tsLfQm1CM3TYmYaPJs1iV7qhZ20xtcJw4Ljg7r+mm7Y3zGf/STb7d1QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 17:36:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 17:36:07 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/sprd: Add missing force_aperture
Date: Mon, 24 Jul 2023 14:36:05 -0300
Message-ID: <0-v1-b782fe624c2a+3d511-sprd_force_aperture_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df0945d-7609-42a1-7dd4-08db8c6c7628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J/sQ5ys8gKgHGnU+bqk2B7vmljDCCcrLkL1wJMQY8gQDnGcsW2yu99rfeRZRZV0H3QO3iw/85/M/igu0eVFKUY5CWWTecktBJhmo1b4PyY+CnoumjXf6+cZyOaZjxQaId3R/bspj9byIgbRRqkBmeqA3upQ4str/MyQiFa94go/jeLFMAgdez57/wLsoTmSZkEMlL9BH90JZDeQuqJnrUh632y+Fzu0Xj6ttB5eUv7Ep3wSD8poGzNfGC/sLc2+k2RNi6roEp9HKcdzhA8b/EYnD9XmBIcvXmsH4fr8morToY7sUAJ+3R/i+M/Oy28tcl1nrhxtvIABxvYsckR6Y6QNyKMUqr0X9XdZ3gsbhjFiU771VusEpcQKj0p/qtcJnbJp4fcCs8xf9ekd5xb/fuVGndAOyXGR8X84rNtQ21bui/PDst5u96snp0jDnxfgGpHRYGDetjHzVdjVAiOhWD/5vnsSvO5YkFtiClVvweE0whRHWcBY4EqCHfBezI51QNoeRSo8kmkaGsjRoiXBAGgL9uyDnhhxTdkpx11u00CkvVAzVwJnUzMN0BSSWyZFWJLVP55K9BL1yQyou4LFFp0vEBMfI3SwQpr9JFq1vPdQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39850400004)(396003)(451199021)(38100700002)(36756003)(2616005)(8936002)(8676002)(5660300002)(110136005)(478600001)(54906003)(4326008)(66556008)(66476007)(316002)(66946007)(41300700001)(26005)(6506007)(186003)(6512007)(6486002)(4744005)(2906002)(86362001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G37ck1BzdhNnESbLHkoFUBDRiEtbZgrbPBUsYHkFxDDFMXcuwrvKVYieQOEa?=
 =?us-ascii?Q?hEGx0EEwseM5ZN40Gmb5Vg4nL62i2jJbjQLlEV9M67vUH/OEphvgGi1uaQA9?=
 =?us-ascii?Q?hRpUNnfQH8gwyzYm5gTkp97BsDOv4NvLP3uhoN6zjW7JFZW6sMhlRCoys4s3?=
 =?us-ascii?Q?QGkNs1nVdHiZbu0m/rez+VuJV9lvOXYst/2vOv9sdb98BZjQ7ViyJl1Vhc8Z?=
 =?us-ascii?Q?im+yBW4w0CdxYPrZAZMjtDE+wQ/VO66buq2AYRtzfSi9iJ/7WX5kpASY0CAf?=
 =?us-ascii?Q?juoqBR22M/ujv73dF0an7fSpohrQ/Fak455XZPA979x6BWXVZ7n+VvnThCSa?=
 =?us-ascii?Q?nqafOjb/rmRxqQxZF0Jw4j70VxxzTt7whdBVQZI4dj6tDkn6vrWfOoRgtOcX?=
 =?us-ascii?Q?qZd/7MNBzKq+VqX3YjRFKILK9Bc/1BZCJoIRju928oTm/XJGztv3yQq2iwjz?=
 =?us-ascii?Q?V9vZ4Uzj970u4It15SPIPH1ki8DuqdJLssbZNdfV4ZWd+GB8c7tG0+zNjVQj?=
 =?us-ascii?Q?K1JX4nHVE92GCfQvJgzD+ne9VacMfwyUU9XRTsJm5Y85CvBGVyPJV79HRXBF?=
 =?us-ascii?Q?eGYNOOQZAGh9GQ3vCpyuqJCgh4rganYhU8dqImF2uT3jSDKOMwq9hiiD7wHx?=
 =?us-ascii?Q?p6jTbIQkYDz0z1Qe/emMbxk7FEhhuiyxY9e1cPe6JbKqbGSEx+GGBVJwQLuQ?=
 =?us-ascii?Q?KeRGY1//GFqohysg0Doi9WA8uX0j+FIGDrfJ8WCTi1FXhKhDl2qIs6r2XkCX?=
 =?us-ascii?Q?6uvFYiQmN1ay98kL4b5Ympg0vWHyl13c9Ti/gr9NGvKxBZbMUUlZrdusc7Ri?=
 =?us-ascii?Q?JKsnVLqgDzpgzbEGlQ+WH65JQvoalmbs1OXcOnvjq7tcVF0mzMngbZjZLgVD?=
 =?us-ascii?Q?q6TillmqRdeCrC8YdevqKOr0L0BXIeGB1ctUMZIOz39/x38Rk0Kuy6f8svJm?=
 =?us-ascii?Q?g0Cmi+qygWWTqk/30OKJ0IMukyGMZICuwywjg4aFVVh+hxTQGk/m1vaxvFGP?=
 =?us-ascii?Q?lSnA5TQmRn60mGWu8gqKqePs01EgwIUjxCDcrXRJFvKh+IM5cy4Q62Mbb0lO?=
 =?us-ascii?Q?DI6D85cnD7AHJZB1MseWY6vsRxdIkUAJu7ybJpKjL/iT6fTmGXpUhoNC7UOe?=
 =?us-ascii?Q?UdbMtd9l4jCNqIPe9NKisEFc4Fo91MTOb4iEyzNwN13FEll2TsD5IpzGQfZm?=
 =?us-ascii?Q?0SRcIShXFqz1fNCFDU6hUJnI7wI+MIC8y3zZVwtAfrTC8Ns0T8qBOZCZveCe?=
 =?us-ascii?Q?d1vgLtKbZ2g+WTS1glIkXT6v6tFyHXN61dm2ySXoVsC3iCgR7JmLhJ3FarYG?=
 =?us-ascii?Q?ukRKVtjI+G8Y+5xhsrj6ID5tdbbKYIAqUFCc0kOYAvINCpFzc0GtPVkQzS3X?=
 =?us-ascii?Q?4FqVPgheuUqNkj1vkFwXcIvuHIAWWPYKbvylu83ptRn/a7Pia9ExIqFccYGm?=
 =?us-ascii?Q?ZxEo3U9biX/tL5O7GA1LDfVcLtWJtnrQHTtqsFURTnam4RErhB/67Wc+Eizt?=
 =?us-ascii?Q?dAlFQ/SBkWnXy7ynkttKJ2mXDjavC+rfBAKgBD5E+L6JA/i1z0z7p41SfUr4?=
 =?us-ascii?Q?vQjB5TxrHc84IqzK4D5pvUJJoK4L+klYBGPuVuri?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df0945d-7609-42a1-7dd4-08db8c6c7628
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 17:36:07.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ghTU0I6/PdXKhRI4EAzPNY3TnT+1INjYovVl+sU3jJMPpicAQ4OFq9mSGR69X8k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

force_aperture was intended to false only by GART drivers that have an
identity translation outside the aperture. This does not describe sprd, so
add the missing 'force_aperture = true'.

Fixes: b23e4fc4e3fa ("iommu: add Unisoc IOMMU basic driver")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/sprd-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index af68b3a2c123ab..183ca889a6f9c4 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -145,6 +145,7 @@ static struct iommu_domain *sprd_iommu_domain_alloc_paging(struct device *dev)
 
 	dom->domain.geometry.aperture_start = 0;
 	dom->domain.geometry.aperture_end = SZ_256M - 1;
+	dom->domain.geometry.force_aperture = true;
 
 	return &dom->domain;
 }

base-commit: b9e8d053f9e8b9d3aa1b5113e3fcfb66ef450564
-- 
2.41.0


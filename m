Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A08C10
	for <iommu@lists.linux.dev>; Wed,  7 Dec 2022 20:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cn5SXeSNB7XzTK3OBFcyyvcSqG8/e5dbxjlLlSIFTFLfR/IZT3xEMi8cFFqfT55wRAPol5vTDvDxNdVzL38G9AeCCr7qxPCvyOhLuK8wXz2LTtERzTpJw5hgZM33Kp2qFjV6Z5dT/LsfNGGADZigIf7A6f2QLKaUY64fEM1UZOOAeIMrz4afNmu1pbjQbXWMivFOI5nkA9u81hk5UoiS2Sl3XqeBoDcFhFQqspp+oIUCVNBcOf3l2aHuxQKMjtjPNW/Dl5sSOca434V96oWRFnCTu4QIb1NPdPaDz3Zn1+BZmBeYw/tIoUY3ENMfl0EYNjFkaY2XaVPThcYr8kIwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDhw8/1RWaihsZbPu06HNk2HeqIu7qWHX6UMj0p4mtk=;
 b=ChR4/GJSBAuBi0bQRQ3WTg/A45ufOsKej7NsJBtn8ZyMzE7AnRR7KpzXJinDOuwpzH3ivoexStQyZsFSYLFDrUrq3VH6B3gnK25jiBAwDjkGqFMf6yYQUQeptIMK4vjV8dlwiVlR1YvtG4WGWXe6lHRSpNm2YlQ+zYYW2rk8gAY+D36xnvaSrDEnriFUmpeU5PLTapnFSSYdEq25qQBChj5iuLpHT4aXb7E/Ww5AuF00N7WIcejQNe18bTObZw1FnVazN5tkmPnSRCFarACtcHhkJQbJfFWOyC2IZ/fCssPFMVy+cQbv4zvTUMdwaNaHG5C1w3NnEwqu+YpqQArkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDhw8/1RWaihsZbPu06HNk2HeqIu7qWHX6UMj0p4mtk=;
 b=lGYxlP0+BJG3lz6aA+0fvVBI3qjYKB+I78TV2xygnNDp1GWPlTZA4/kXjF9BBOiFq4n96/oL5okLXooYvHxve6N2WW0uAoGuU6qoh4eqgzJXUuDv1n4nMXX3jIVyghX7NKsBMqT2bBHYQjMsOveXoL2AePx87Tv+VmNL8H8GVlvP+Ees7YqXR8F9nKH7UB6JCtZw27HK3h3byBcozgJXsyHReX6zsNk5eeRBsuQQdRSSxSXCGC7wYrWxdKZqcxQI2suh91huDXJR+og6dk4Cn73xKofa8+vFJqit4kXS0vfBV34Vq58OXvgFOUNGDWhFHqQaN0q0LFnTW1053VKSiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5483.namprd12.prod.outlook.com (2603:10b6:510:ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 20:44:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 20:44:45 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 0/3] iommufd review updates
Date: Wed,  7 Dec 2022 16:44:40 -0400
Message-Id: <0-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5483:EE_
X-MS-Office365-Filtering-Correlation-Id: 455d4055-4ffb-4617-695e-08dad893df3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RMhCJFXB7rI12hy52SkQcUdxkNRK17fQ/TYvc092d6Py9ssExUlOmbvAVFFsllXSEzlprxlG1oQ6SoAE/VVo8jYcwYgj6nOohgEn7a9pWDaONTjFVrYxZIaM9oXtK8JevdFQzAVAb1wSA0z3YbcYLvYCq7OYHsAvtjfmAjpQGYGx06TArEPoVPKx/TdoFuuyqnLuXrgqYRX4mg01G60WXmbhJnzDHAltJBeqkneup8pLgTSSeAqu/ZqPqDa/JePwiEE7dK8JXPsO/Q9C3tuyNpWOs80akp912iYzVTvS6N881Cocr1N18dYka7QFGFP/qefGV3YWE6x3MXolcZq6ExSrWBPadx4RzntS5jaZRlgG8wEP/cPMvIZcbrwlQgdSwN3haPvePVjzdsKT6IHYCFT1ocq9L7hI3Hr/ZJ6kImIZOV7GAdWLRxxc+/nNiKWRYw8eDEpCaH5ZdEcxy7A3iRnmtkiN4R6xC7KiqaxVCRRnlG5TZn7RImd72q7uOHX3t1Oc2dcvuKWuZ27izQ+Ri/hIFDnArpwTqUnqQcmt8XjkuSu0DV/lXcixmqDIViTR3rChCHxlD0vocKLJ3YP7svDTy6xAqmBERPx9toOWHE/w2za/3Ff7AWSvI6MInupTrjADKI8pjyplKL688MK4qqx/JQhDa80zfzlN2vmJHT3465UjnFB7fvV1HE4/5htW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(36756003)(54906003)(2906002)(86362001)(8936002)(4744005)(5660300002)(4326008)(38100700002)(83380400001)(478600001)(316002)(66946007)(6486002)(6916009)(66556008)(2616005)(8676002)(41300700001)(6506007)(6666004)(186003)(6512007)(66476007)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D0HSC4SSZO1WOsf7noLkvfrRbbP+bDvVXxwh1ENOxBRIeuRtdwOfPiEiMS8u?=
 =?us-ascii?Q?GrrRb3Dv51Ly3ofcNCeYT9QIyLwU+gR5I7wrd5HpqMPX+fToF8eoShXNnsKw?=
 =?us-ascii?Q?/SIOEPYoJmnoCxmT82fd05qn/eGnqAB++O60JkvL16znzaw76xHBFhIxxXW5?=
 =?us-ascii?Q?1iC88gQgMmSLK8f4OaSkF539N4PsL9A1llztUsjbct14EL6ofp8meguk7yC0?=
 =?us-ascii?Q?V+hcLKcfinl2L7+PYAVcqYCkn3CduNXu20BYR64a5+upg8/T/L2rX7ZV0EsI?=
 =?us-ascii?Q?hAjU4qlJpH0UHuCgRjHjixWijE6SoQBNKInarOgVa9CQUS8E6/1M4poCXY7e?=
 =?us-ascii?Q?vxCxGnacreF1vGPgIWaSZTaN24yglvR65ERUBADsYW0Bgf5gMAXxBt5Jjkno?=
 =?us-ascii?Q?ckxuvWSL+b0FQ9anHkqPxk0fyEjWBN84FjXY+NAOkBBUgSL8z8vkJ9JsAYEe?=
 =?us-ascii?Q?j0PsTczoy4kB08UmExxC3zXcrPjDe3HJBLr7QFncmXE4wo5bbTU7DkMvln78?=
 =?us-ascii?Q?z3fxBpNqW8i5bXK22ksTXg4QxeMLKBi60hodG2l8HZUIx5VOsRJZ4vSNw0GF?=
 =?us-ascii?Q?sju5fYGwackcqKia15ECQg6YI58L0VMR8keHcXLvTsAPUSUfHNz66ovQZHS1?=
 =?us-ascii?Q?4HQ8yRgY4A86z5IRjrpEqZgeMJ3pl6U6lYRSY0FIBon0mokJB2CXC7Ngrjbj?=
 =?us-ascii?Q?xOyNZfBM76su2X8eMdGCG7yKnqi8/IitlPly5IQzYqA0gIwQ4JzDcwLbU5kQ?=
 =?us-ascii?Q?WV4fqSuj4IbVtjJTKrL5y6RCj2r6T5qfdzzeGG7AzA2qw2ShRtxK9CHbVJuC?=
 =?us-ascii?Q?OVRoxdqEUR91GaCLGnNQJOXWcorC96YgSpn8QA5tPtdD+YumokxgJxw2z2ON?=
 =?us-ascii?Q?w+kE175JNoo0tedFI6suyqnuLau1L2Gj/Ct9+E4jDG7ZLRvA+VytAtLP5POD?=
 =?us-ascii?Q?Cf+yq1+9iw9K6cmRAGSxJwAMOSSovoCywjVLz0AnZz4Il2gacLLv5PLcfcyD?=
 =?us-ascii?Q?rrjxPl6HGMwYLUZX3RtaxDS7CIR9ontxIQQXxt+69DVRgoCg0iSfN9VvkQk9?=
 =?us-ascii?Q?QSC+j+AKZNqXqXoobKkQ4ENrK2FAFsJ2nOAF1AyUP/ytbSsIrbICxX388fRP?=
 =?us-ascii?Q?u1TYOgnPcdQk85hUD9C4qEK1m3MuvbddYclo+TdFYY4u+XBM9xOjx6xCUH54?=
 =?us-ascii?Q?KEGXpQMUvhure8WCUGV2TuKudG07t27BMsPPceEdbl9Nc3cUD7Ku6N+vrKHd?=
 =?us-ascii?Q?exqqHcYFxOHXj0HkF99Fto3vBN/3cCS9UAVtj3ZIBZ8klJ6yvOqw13yVptMO?=
 =?us-ascii?Q?09u10lZ6JMUKXZMG0da614JFbxQp3Dr8J6/yvq3cVfHm7sQpQp0PsB6GqpVy?=
 =?us-ascii?Q?0NJLvtq0IIzJobpHGfag44j/onWsJiVNyUMerQ4Ny4TMhPjJ/MbchUYNy01h?=
 =?us-ascii?Q?zKXJ9aLyOkauCmot8o3j0Cr38AaV5FtK2XiBZkqWGPbXcNGAmMEhrQ/4XrPk?=
 =?us-ascii?Q?Im8UJya20WnkwEzPeLGEY8ec9x7kkx6QO6fCXXBh0y3nTxP2rLHRnieel831?=
 =?us-ascii?Q?Bffw2VT537z8mbCuvo4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455d4055-4ffb-4617-695e-08dad893df3b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 20:44:44.4757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVCPWY588iQ8K6OBqvg5GGtg925pguChBekAJaF7EZmZ2+OPjk1SyRzDtiJziHKv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5483

A few patches from review comments that happened a bit too late to get
rebased into the commits.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Jason Gunthorpe (3):
  iommufd: Fix comment typos
  iommufd: Improve a few unclear bits of code
  iommufd: Change the order of MSI setup

 drivers/iommu/iommufd/device.c       | 54 ++++++++++++----------------
 drivers/iommu/iommufd/io_pagetable.c | 24 +++++++------
 drivers/iommu/iommufd/io_pagetable.h |  2 +-
 drivers/iommu/iommufd/pages.c        | 11 +++---
 4 files changed, 45 insertions(+), 46 deletions(-)


base-commit: 395f9d8975251ca906113c9f4408aa1592f38e07
-- 
2.38.1


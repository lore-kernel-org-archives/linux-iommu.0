Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D422D793
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iwEOcq+C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlfUMYCs4W698L/o1kSGk5/qS6bEAprvxnAw6pEOscA3qy8x2OTkIgcM+oS6VdXPSogeVuff8Z+6XFqRTa2HLgIdfwvR70Sa4CyB4FpKrEBQWXCPCOfcRmY7YjtSucgBGk6jBEzFU0U+vSfh07H0r3MxotxDPf1x5BHpCggs21v+mbfSqN4NecTKoR8z9F4Pa4SJ2oh8Ipe+VXVxx1LBFkEi2Odph1lmRVCU5lPLaBNgXg/rM73ZJLqtQ3AbcWX4bG0GIuTbfx8AAjgm6cDjBXXg0NrPnsogwIntN5DN3eBjOkClSmaKWAiWyKJ7ItW0E89LeJSqN6BCNjNwB+/FDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8XrsRTVE04RUizs56nq1RLNcZ59ERLl4IEm6LhoNng=;
 b=C3P3ISuh0+drXxMrnjeQ3GUxZ8PHL9XBiUOnvkCLIIkd8gCpfYintH3tLBHWRY8b4kxsGiyN0u5dIeW0cRCcIIu8WXhZb3wmtqpuxTf1s+WZdpIXilSdLUioWok5RA9aFSmvAy2PY0hBKbwcN+q26O7ic9Du7faP364BKQLaulhAwHeDn0pJ4cx6USYUjCq3qihQghhYq84uqBB+OT7qI1Sk9VX7lveqzftf+71L/AMwYLr65wISHYXQdhQEnhUkd7XfLi+mLP5cBN0DL7B1fOppOq0NEY6UEb5Xcj+09NRKbEaiRNpE3xb2YfDx8gLr9NSoaMG9O7Bv16NUmSUZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8XrsRTVE04RUizs56nq1RLNcZ59ERLl4IEm6LhoNng=;
 b=iwEOcq+CUz7pPyYWkBDwN8sX/NSs5AMVLaHLWB27PS1W1Y3n7LFznxRrOBWd4PpFJLJv5MgzizD+YovmM2cynLosh1K2n2rT2t1k4kuJE4dnJ1t573aHm6/AjdugwStVvZBrmjtKFRsQaQf9+kcKzIha2iQIliiur+Z3101xpKD+rhok46TwRTEd3e4PvkZ0iNDjggjb6OfUjKa41cUxfpUx5/hUMNHjXrDEUePBDCnk4uG+OxFNVLVGg949K2TruHc1n11LoXQvhItPQCfORwA50QWfXz7wrjYE6H6wVrOQh/wvAzI7tw8TNJeb+0fAc0Rx1hQv5rmQwJ95HEeq7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 18:11:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 18:11:46 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 0/5] Convert SMMU to domain_alloc_paging()
Date: Tue, 17 Oct 2023 15:11:39 -0300
Message-ID: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:408:60::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: e56484a4-ce5d-491e-30ea-08dbcf3c865e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZSQyh5ORhGmNwDJsL6XwEiu/5Y9d+Fb/m9UoeHnMXbe0Y4hyfyvXBMhe6tpPaOYdBF6cW83IUGRdjxA4Z7mtlXv+vafCblNJAsZwC4spA3ELaX9xlz9p0Em+fuRMtQjkwfgd2NK/Sxf1v6EXEikFojsBLvRPDBN+X1rKdZQhzfbTfgTtfmAr9CpC7Zwx03IH5mMv7AlSVUeCsuH//xIg7NgcQbVrLkGL9sbmt9wW/Lc+luBWlQCrbJm0Kpg6an3A2o+ILftjmsGgtWU8y3hxca5hVp7gwGC+07rLP0xXbUGOjjUC5mP5GbDQn9UxQd1tGV9ddLOtncL0huuHaOAl0yaLkxMOwioQTntUw7ZU1mw87gwvNTdrt60Rx7Zpyl/7bQvPfOOPORFkr9tJPTICVW0Z9rM8c22QWbMXT1Dioeh/ySM3NGh44SZbZYEI6bmgXssLEfOYDgVoaTwxAq40b7kkoyjUeixTvSn0d/wpS8Tsd3xUXL1e6gggryJ6baOQMxhmOoDxSp3yaNbUNA2Cs7QsQcUop633Cmee50GaKnBDJGTV6XaKzT2ZIgMAB7QDIkFt20pOiFFbyEsa+uyQGjb3EBIq2kUVEtWKoEubMNya4FU0hFY62HArPFqgK9k3nxD31ZL3tLJfraFJVzqih3MyDVhbwPWadCm2uJUNK5Ab1jd6Ga0V+qJnnDOon10r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(6506007)(66556008)(107886003)(26005)(66476007)(6512007)(316002)(110136005)(966005)(5660300002)(8936002)(41300700001)(4326008)(2906002)(8676002)(2616005)(6486002)(6666004)(36756003)(478600001)(86362001)(83380400001)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PSd7746hLtfHMObJXGlFJmlZBcBzRmGVVkc9KacjLkvFVPII86VhHQWAplcA?=
 =?us-ascii?Q?jHSZfyU++J7dppT93Hh2yXIZllCW0PyUcm7yAsL04gYlwIFoDMV8Er4V6tAN?=
 =?us-ascii?Q?V/4fJ/+sVahsRqhBcAPI/gTxuqoISSQlzz4MVLoOJLsCC+plTmb2TTZJ0m5o?=
 =?us-ascii?Q?/UqZS8yptAgjYKzU4tsR+l6lccWLfpIU2YrvLW0JZsMBmCONfuwOgOBFI20B?=
 =?us-ascii?Q?YCAtxAMpAvOk46kLk0Thts1SsqZ0PT8Saul6M+/UKytYYh3JpgjIn66KaIvf?=
 =?us-ascii?Q?R8Bi/zXbJhkns4PuLazVseFh1ixZ+9EU2wUNznifHUxZH6WhUAg3OJtPw+0q?=
 =?us-ascii?Q?O1qKBAYmBI8SK2/zTm+5YXK5RG9klRJZkwU9NKAzjTsKcTwmGl8aRAVs6lpH?=
 =?us-ascii?Q?FsthjDOVcgrLZqStvD+X4ly9m+llwVVfMQMV0i+Zbz79Gho2N6e2WwyuC16+?=
 =?us-ascii?Q?HQdIOOQgzX2d19qHJkS1zvn2/9weY+hkbcXRk8zk9ql8ByO+ubYsA0pJEDyD?=
 =?us-ascii?Q?TuBAHyfg/fMZ3BBeYkl6qNcf4q/1E+/W1r9StDX7XBCc6LY6cjf3IEG26AQO?=
 =?us-ascii?Q?odR4bqmTRVJeowcdXbV6a7uqRpKUPWNIlOzC8T3xS6UXPGe9MWvUc244+HXx?=
 =?us-ascii?Q?6efgGGy8a/t+0A6c7TXXq4HDHsQ5PSbq3gLJbCD0IzVmgULklG0CYUCAj+W6?=
 =?us-ascii?Q?vWyWCbtf8gl/738CBJ9vTMdE87Zv8cFhwcQcrm+SQcnb96XHZp4Ivh2wuCHN?=
 =?us-ascii?Q?0cyIcA816W6W5xLb570TCN+xazi6udAO4YPYVyzq2sgXA3tNC8o+749Xeq16?=
 =?us-ascii?Q?vAoNhXCg1+xdBtgRVmxYaZ8X44hr31VqaBjXEoabdL4fMTZsj7vBB5sgLk/3?=
 =?us-ascii?Q?yJyOZzjRzPway4jpW+8vReXsrW+GvfKIhWXNk+PdGeiTJufs0oG2uxXuxLhx?=
 =?us-ascii?Q?byJzlj0B0M4xtIY0Re0DLL6Zut84czD3dNpCTrSJf1rIfmLK8webpXlhciDe?=
 =?us-ascii?Q?EkNzYcTl1BOHT+zr9NnnTBmsIAqIXG5EhfsEsBAp0PLIIqa00wjTrYpnt1A/?=
 =?us-ascii?Q?YEjxzCAllXdGQGdLPUoxRkQUQrzAnb40z4qUJpRCQVmfssupbOePO6r4pXk3?=
 =?us-ascii?Q?9gKS0G3W0rLD2Zm2H5CNp/Gt65+53lvgNc/WdwqcyHhrrCf/qri0TFJ9GdYC?=
 =?us-ascii?Q?ilpr2gnj47GLp0IENt+9UVWqMeXxD2HcJM8NMNrG0Ye/eqkSSQS5FHsW7I/v?=
 =?us-ascii?Q?/NO/hWhIaKJ+jHwtSo+i/pqAT1pq6eDx3G+26GiN0BDLLaQEngwS/kvxYUEJ?=
 =?us-ascii?Q?m4rr3qRgGWRkvrsMjcnDoiProo7ycJTEEqhpyl9GS+F0qWkauRVr3KLjm92G?=
 =?us-ascii?Q?otW+69Xa0wwuYHCSHdaXwVfhrLgsZY925FHWPKlXYvb2CMLKD07V2ay60/CC?=
 =?us-ascii?Q?3jHqe4fClWZ/jH2Lojc5GyrqU5kJDh1zUxB/FiOcKws+JnCDf2TwnTW9gNcl?=
 =?us-ascii?Q?NE9TxN7GTcFyQ9Fj+J9UU4nuGn13uuy+apRkiVq0Wr6Vgee6M25AyXp8OwR8?=
 =?us-ascii?Q?LbrgdwvygxVJwUQoWRDsl2ZVU89e2yskEswWS1m7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56484a4-ce5d-491e-30ea-08dbcf3c865e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 18:11:46.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CP7kgnaBKgcHw/iHQyyvWn5hvRhhrNNhb0+gIJCDFEn2FBWo61mZS87dVYbjLvDr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905

Add the global statics for IDENTITY and BLOCKED to the SMMU driver and
change to use domain_alloc_paging(). This allows SMMU to finalize the
domain during allocation.

This relies on the first few patches of the dart conversion series:

https://lore.kernel.org/r/0-v2-bff223cf6409+282-dart_paging_jgg@nvidia.com

To enable the BLOCKED global static.

v2:
 - Remove the disable_bypass fixing, Robin says to just leave it broken
   for ARM32
 - Rename arm_smmu_domain_add_master() to arm_smmu_master_install_s2crs()
   and remove smmu as a parameter
 - Fix missed use of dev in arm_smmu_context_fault
 - Use a local variable for domain in arm_smmu_init_domain_context()
v1: https://lore.kernel.org/r/0-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com

Jason Gunthorpe (5):
  iommu/arm-smmu: Reorganize arm_smmu_domain_add_master()
  iommu/arm-smmu: Convert to a global static identity domain
  iommu/arm-smmu: Implement IOMMU_DOMAIN_BLOCKED
  iommu/arm-smmu: Pass arm_smmu_domain to internal functions
  iommu/arm-smmu: Convert to domain_alloc_paging()

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 126 ++++++++++++++++++--------
 drivers/iommu/arm/arm-smmu/arm-smmu.h |   1 -
 2 files changed, 88 insertions(+), 39 deletions(-)


base-commit: 853eb2d43e1be6e947fdd11c3341ffc2275fb6c7
-- 
2.42.0


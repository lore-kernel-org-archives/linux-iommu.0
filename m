Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68E7ED9
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ivviCDxs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCK8fNQUiR0wCTQZUpqsEY/bYwhzKSHv3B9rGfcgncmkDFCJYQblBH380jHWkx/gKSNjTuB+o0PItQSrMOcNMymxzguMgje5aOtIl2i8VjKu8Ys2mFg4z1UVLCB4V7eTJxT8itzZEw5gRUonipZXfQY9Sx40+bkyEtt6Co8yJ62GnjPE8Mlqxf/ynvJzKzp/ex3gSTlGQxxxdUPz0Plp4xGPE2Baz+pMiJNLmqaxjmv23phnqhRoxBzbTIOTphLan/yOhydmMobSEol49MbAbpYm7Ika21NlPbwEWN5MPjSju5O2/ydxvSs+knmbQMgdPrxSh/Wk14XdqZq0hwwXGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU1VnFcORe3Garadx4FemnCc/4o+ni1i3OYVQDm5PI4=;
 b=JIKJVe6oVraLWi4QhdHGIksx+tMsRP1ZG1V3VF79oxz94BTRDlO0Tqq4jbLmg2EUqDaZ4d8vLm4C6X8TOmkrMdng2s1JaF7BMvXvhaoKk9dJBDpEFd+CdH040pNCu0VHy8CbTdPlDEDc1trEbjc5T478I8JeYNH6Nm5eMID8wZr4dXLTddX+xG2q9PIhsxPL1w/z00getsh0ER80YfIZRngvE8B8jXfsBKowXYTlO0PhCvjg+Tp5eMMu1pOk3qI7Uy5SPnv5GzacDGGxlNgKEN8gzUwXHRhVuGJjTMOsxvObCom2coUW+jcNjZHqMHJAikpxyxbC2d29aE24VQ0NxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU1VnFcORe3Garadx4FemnCc/4o+ni1i3OYVQDm5PI4=;
 b=ivviCDxssAYAe33rFP6o/pdJvtsriCCMdrzCsFaDIOr80uFoAkKY4bBsftcxcOQJq9vTEIsuGcQ/UIBWIEEZheh+++qenUMu1tL9Orno4qY8Ul5zjpKKJY7vig2iSGX2XUg4x80K/wZpEhhiZObxmrORONIeD2QDxJFcbO+4BU7hVcSpASgA3bfB74OTz/LTjgq39+eWoHmArUj9wdGWAakmtwKHyeH7CzH5l0eqHbk6yKO+LA+onrddMrsgr5eJHHp1/qVHqaGBEYSgTuiqVkZ4SlCPkVM9N5SDBDdzhcc/SlzblackC6fzfn9F5SHYc9qX2+553yFE0IbWeSK+6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:30 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 02/19] iommu/arm-smmu-v3: Master cannot be NULL in arm_smmu_write_strtab_ent()
Date: Tue, 10 Oct 2023 21:33:08 -0300
Message-ID: <2-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:208:23c::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 58051e5a-ada5-4f2d-25b9-08dbc9f1af41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UkUUg8ft1g744IrmRa8aBFrE2LKVgFutGAQIXsztjc4Gub707FvY6vOH8/pqoM0iOXvTvYe6NpNo/6ylgY11xMhCjQSJjCSoSGwjFeZMSpZTaXhzQeFdfuyVElw7bqtKQLcuG41b2Y6LdeQ0v68wQ9kudYfGsCY51+vj+UXHbWBNXqW1ERPxjtw+XcB19oNZULpKWJSDT7WgkurI0rnPq1bSyd+GC9t9ZhDUVthZ4YVxSZ9ROUS5tSBmArR+ipLuksGtXsWPcKtpSKEm9RrAMLWXcVJikTXQldWcfFwF+Xp7wWDIz7en7W34G3PGvvD7WDAHk6T5KoC478/DvmFxUglZFxojORaqZ3iTbLMUqOTQKmz2L5pyeiS4Dip4d9R9OEnjPqNUruCpcvDeN73QrT5LhGq1+DSAX2VY4hQtpoZb1HytW4yqZGySdI7B5ww0GwRTRyeVcWPQqA24MOfx9OohBcE5+QY3bVvgqbfYQMRrH+SO6YHBbykbw0sPWbPxcCtiL79h7ZNJ1GxvUhfiHdc32mfXA2KXkBFlxdovt/e7wdRTN+q0gdWXfKh8BVOwlaD44vDVumUheOc3xOZnqz+7nW6UTTcjr//Laz/2dVo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PKMU/cBYUEX0iOAbGngjTDC2phEj00y4yiWjXeGrzbqWztW62xv6k+kd5un3?=
 =?us-ascii?Q?rY2LfgGsElLWHujpaWcopdzDllLLMlB9Snl1LglcF8Jjm7bbrm/6k1LKKKxy?=
 =?us-ascii?Q?ZqdWRBosF/U4K/AqMiHExtK9E9E6KZjPx3UNC18eyeanIwkN/ZKvzFMIBagS?=
 =?us-ascii?Q?aDT9qEJHrRkVBDYgDAfnqTgf3WlJwNQ1sNNWDq3gPGkeMT1+hj1x1Y4bGwLA?=
 =?us-ascii?Q?jj5n4tAobj4UEq7COxjTzppJltOxwT+ZfKAte7JKzd726rFcOWG0Rd5ISQaQ?=
 =?us-ascii?Q?eugobV/WPhCOH49gLLPb6iIpeYTJhXzHFo0gKR1W+FOLFtQhuWotvbR5L7ol?=
 =?us-ascii?Q?e7qX2w6z/pfeap6OvlDWB81DXq49a/ZDk+hY2EcsoiYd4e5A9HUx+UjfAe3A?=
 =?us-ascii?Q?9eIHep53hAEp5OCVvWWoMd/fVIlT1NjcV6LbhzxdWqfmL91wgIX5ND2+6yzR?=
 =?us-ascii?Q?Zuxe0F/f7MBvC+cFlpd6MLf58gQCuaDFwONfGNXGHuktAliFS9epNtJW4LKc?=
 =?us-ascii?Q?++OvzGlP2kdIYJaji+NWr3XQPyuOUTar4GKzhUhVmpIA7OMdE3ahhkWOTxs2?=
 =?us-ascii?Q?amxrgRIaXvAJ9JR0hAhebjdrfEriwvbsh44QJEFete5szf4mCl+YEPsXiWJ5?=
 =?us-ascii?Q?e1fqRvUnSbxqXs0ap2tPj4bfIbIMPEkeK7IanXIc+7FTbVCCObMfWxC5BcTy?=
 =?us-ascii?Q?62IcOp9LjhaDUXJHPtxkQToP15bCaUMR1ReqyQInpfDDC2Qk61FyGHFVF/di?=
 =?us-ascii?Q?T9IXcEHNcA9dB182ZXWJ46AfJtn8tCc6kwQ0QJabyUa+/nJ1y1/B3lOBccKY?=
 =?us-ascii?Q?AzF9DJzb7h9vrvhy/OoW/JdeQUOecsitsNz85n/M4i7IEnkFYE0LvR/reunH?=
 =?us-ascii?Q?e2K7jxDJt47TiCLnf+fFEJMtvOrPb0ql88RcqXXocy5qs/WQKrWU3+sFbHlc?=
 =?us-ascii?Q?086lDYT+WWdZF6Uuv1sSaajLlyG0hVWW990TM3ASP2BIl2OtwdWBFS1ygHKS?=
 =?us-ascii?Q?XrJGFNHtNFMu1tk7fUciNgQQjssnlOlZStoW90DjW/M2O0yqOdaJ7WnnXHjl?=
 =?us-ascii?Q?YjTm609m5TJcKp8Sli4fcRavNgJQjY6MVrh1xODqZMrSqVx4pmB6bXbd/G7t?=
 =?us-ascii?Q?CTLNs0NXl8qLjcD1WHaxImxOzGwbfiIZRltdCivE6Nnto7p7Kh945cBfQ1CL?=
 =?us-ascii?Q?AyIEGF7g6+3/MQugsZDBv+GzVqOcxrj/DWjZUqz5U5c/qcdc5ABHaDpZQEaY?=
 =?us-ascii?Q?BgcCNazxBeC2TU+MtpwdiXeV5XpyfkgZ/Iu3RuoEqEMx9RWSSLWw/ryDB+P+?=
 =?us-ascii?Q?c7/sIcJbZ6Ydu3yQ1AoYQF4WMzZac5JpZUt+ajW4w2uPU4G13FjIx/tTd2lw?=
 =?us-ascii?Q?KAg4Loa/nNfTypDaGCXyurAJPrMhWSA9fsGWU0//b5pmrWaL15Z30nhxve1s?=
 =?us-ascii?Q?OiSn+ZMIHJu++ArXmGhN7HdDXHnMYi+8jhWuHQ8xyBWIKVlaAz58ataRATJb?=
 =?us-ascii?Q?nhJgE976KnESD2+QNeiYS2le+hbXj+6Pf+5//pv9uv7fSHAva5sFLoayilcD?=
 =?us-ascii?Q?eMHnEMSitK9J6wiu4kAriRKGXFTGmNfzuZgnA8Ez?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58051e5a-ada5-4f2d-25b9-08dbc9f1af41
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:26.8573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bj4yFVsDFBMe82iDA9eHbsHK/Ob9XcZYbttpQLU081FWcib+h/x4mGid4bfmsPG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

The only caller is arm_smmu_install_ste_for_dev() which never has a NULL
master. Remove the confusing if.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 519749d15fbda0..9117e769a965e1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1269,10 +1269,10 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	 */
 	u64 val = le64_to_cpu(dst->data[0]);
 	bool ste_live = false;
-	struct arm_smmu_device *smmu = NULL;
+	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
 	struct arm_smmu_s2_cfg *s2_cfg = NULL;
-	struct arm_smmu_domain *smmu_domain = NULL;
+	struct arm_smmu_domain *smmu_domain = master->domain;
 	struct arm_smmu_cmdq_ent prefetch_cmd = {
 		.opcode		= CMDQ_OP_PREFETCH_CFG,
 		.prefetch	= {
@@ -1280,11 +1280,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		},
 	};
 
-	if (master) {
-		smmu_domain = master->domain;
-		smmu = master->smmu;
-	}
-
 	if (smmu_domain) {
 		switch (smmu_domain->stage) {
 		case ARM_SMMU_DOMAIN_S1:
-- 
2.42.0


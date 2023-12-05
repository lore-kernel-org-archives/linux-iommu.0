Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C317F1
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iahTnkKj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIvRtq0NxmrD4TLltKDiHCWcBELW4ErHnf1ehgyROjlI70f6HVlY20XU3QHChbmGK2ZqBbIJrUUe3tgOz6Sl5AmvYKi80FpTMG4J/E/ZzN3lKoa3BNyKq8E0Mk+tkLpZkTvzuEuEkz68nE2Yx+scSsbCKGytJh6gWnfAGwW7mDjOpa35uU7flRI78rWGrUIEh7fVq6Af10/a+M9tsu3O5dRH8nPWmDNA3m8JWpdcszQyKj6Z0tB86NKIEJwq+FXQgppRJkLcDYnAIfW93xhkJefRIAH8H3fGZfKbo5RtLCluundOqDetpb7ka/jBBvara0F/flgEG/VUxRxiz+1WOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z53gardtjvDUhpMLHGbKmmBbzrCmPPo6Yt52hlj0yBg=;
 b=FB+UTgMMQasYVFiWa57i5vF/enJarA+qFz1cojpm5TH9/Ufrx/p3l2Cwo3vPTfiGKVjmhhFX2SU72/sHRpxFbB/REKW9hUHm8otO+Gdi5Dw5HRgViYO5Ky5UdhS93bZYGmkc9ApjaKEsBiSsRPXINNxsAlRMdNezY0oMs+vf0oBlJQoffSc4bfj6uoyGdPXwntuj1W8cm10jJ+AbRqbn0jzljStbVJOUNscsXpumcsfN0BQbMyFlpgbugSiUvgsLE2BYeEI1iWdbOQ/7p6+FEPwvXz6CKH0WU19OQlxVyptGxRbEojkPVYs65jaFmPPqWb4x00cbBvPD3tcxUZ86dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z53gardtjvDUhpMLHGbKmmBbzrCmPPo6Yt52hlj0yBg=;
 b=iahTnkKjRuZGa2oPKyw6D0N1h6LNJ6vXU1CyQjRCn1vj9Qwk2iQMkUNYCtS1drAIffQvJtMrJTchVMo7ENkoijBGi8AJwGIjExMKteefOvEKSiJinr78ZDEzxTct8RjVvEFNPrXAfv7POB01yMKcOOtvlvSYnSwPzF8kuqO+RHSZ5wpTxbpk4RHevr3+3ulPGl+G2sauKvW1IPZPDfnIuWlH5MBZgHzAkK1o6lJB169btf5HZWmwI7s2iwk4dZwteyhcozS1YDZis+8Wg6AAoRwLwJtugCO21AXpd88rQGEv4jpm749Clk2GboNkS+ur7fpCWvfp0TPnuZXe8d4SkQ==
Received: from CY5PR15CA0131.namprd15.prod.outlook.com (2603:10b6:930:68::22)
 by CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 01:55:16 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:68:cafe::ed) by CY5PR15CA0131.outlook.office365.com
 (2603:10b6:930:68::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 01:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 01:55:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 17:55:06 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 17:55:06 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 17:55:05 -0800
Date: Mon, 4 Dec 2023 17:55:03 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 07/19] iommu/arm-smmu-v3: Move the STE generation for
 S1 and S2 domains into functions
Message-ID: <ZW6C9yepEVC1amuu@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <7-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 6215c791-95b5-4d47-92b0-08dbf5353a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G/1unLSPixQVt3sckFAXUn056fBzUBZZSsYWAy43nPNnc6H3wZqT7bDb61t7LjJpQWLBDs2QnnmxKlaxE0Iu4zGklJe4Xu4nnGDZGyIWFMQt2CDMst7l3srkAOvIPYGSaMhi9my3by+5ZOubQsjZd72nKs5j1Qcrb3sA3wSqGR8AAwPggr0cPQ32VhmZzdhwyxpwu5hVO/9ccJ/EaFFHR2oF2Cn20kG1umtLZZowbTz5NYrSeXW0liLxyqKv5rUZ+St1n4lj5rtbKPpXamejk/VBXmMWt5DRtEpUWbFdidaFAprZcDNc4d26yoIQdNjmnTTMWaUohSpthXj0yrDM1ZtSNTQRT198wdW6/00U541kuw0CAkonpRRaTmB+zEptSqHn1nkk+Zc9P3bEniqi+pAqagaEwxKtZiOol1bmxXGi2J5m3q6ZqC8Zyyfl9c8kx5ZJzyNViyCxsRJVe2eWrIPijyR+dnKRMWEQw6tM8Yvw06mjz6EPGR6Jsi/kAqw9EWn7uZ2SY6hOdVvYoA/b3UqywHMCM1ztMA5K0Jv8653+eFEYAUdbipbatTIYazfUSv2TH+v/Sj6QSBEsSRQxz+mcI96PTKII4EOQGq9tG2OyBziSip1qUtBcN1os7kvrdg8BueVV0m6DJ4rxggtwBVEIKBb4dWEpsTPezfBgQ84cuCGIZyoci7NSnFOoQ/G+kzB7bbLhdGs+YZUKCu0HPyAGqd/fGyzYy3f+W1W2nKAzVmvctOloddAqowT+lEdG
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(8936002)(8676002)(6862004)(4326008)(26005)(9686003)(40460700003)(54906003)(316002)(70586007)(6636002)(70206006)(478600001)(41300700001)(4744005)(5660300002)(33716001)(2906002)(86362001)(47076005)(36860700001)(40480700001)(82740400003)(356005)(7636003)(55016003)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 01:55:15.9838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6215c791-95b5-4d47-92b0-08dbf5353a29
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457

On Mon, Nov 13, 2023 at 01:53:14PM -0400, Jason Gunthorpe wrote:
> This is preparation to move the STE calculation higher up in to the call
> chain and remove arm_smmu_write_strtab_ent(). These new functions will be
> called directly from attach_dev.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

> +static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
> +				      struct arm_smmu_master *master,
> +				      struct arm_smmu_ctx_desc_cfg *cd_table)
> +{
> +	struct arm_smmu_device *smmu = master->smmu;
> +
> +	memset(target, 0, sizeof(*target));
> +	target->data[0] = cpu_to_le64(

Nit: can add a line in-between like arm_smmu_make_s2_domain_ste does?

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> +static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
> +					struct arm_smmu_master *master,
> +					struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_s2_cfg *s2_cfg = &smmu_domain->s2_cfg;
> +
> +	memset(target, 0, sizeof(*target));
> +
> +	target->data[0] = cpu_to_le64(

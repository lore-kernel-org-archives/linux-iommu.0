Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1BD1111
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eTuTituC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbHodCwMPwVmZL+7CiV1QdCi7DUy5uW/pb0RNe4AMBXnRjvZwHCHHuFCbA1sAQjpeMqNXJde11uZsXIx7CaCU39wUb5GsGo7JtQp6UWkYyAYAFLbfKQcxUfBC6+bA00Lv5X5mDSaCGyj9iVsexR82eRYNNMWZWpsdjBfiUsIw07JDiv5A/y2lYUpDvL3K/Jr6gSR025v9Qh/8sxzeddzkxDlR9ieq6hz9QvjQ3DPeRLciZZwMNhRUzrws34xQdzyLlg3O5cgC663Y/21u5a0xkpf8Ej7CdivHjOGaosbLOLH6ApvcuHetv6wLis1eTgp1kqxZfaFnp81Q8R9PwrSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGArIb+16NgVjv+fwWuqML9JZ+0wYVxFfvH5P1kkc44=;
 b=iA2BAfI3tU4UdYPIp+Z1BCsxMjw2Cr61xZnYdTzbzBUdbRzNkjboXG1GPsPEzzvXLcxA1xkwXirhanRUQNhbGeBP8qsyQESeRtw3iz71kPODbBylEa2aKwF++6Lz3Z/f1QVxy5coLSbhW/wE22dpJwWOyRoOMqfDRDgQNUG+hvhDhMIIgiptmnAIM0K4Pa/aP6GUE2MxUVsFisR8YXfey+ZMl57beI+MKglxwrSj8yhwziMDc7rGSKfdI+oxkguvveU73EaWPAiTQdxSVByMHDLJKBASkNdDBjCGETyLFAQdu2jrhLpQ+DsXOeXizLe2wQ5Ja9FFHsrp6/jl1QtpXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGArIb+16NgVjv+fwWuqML9JZ+0wYVxFfvH5P1kkc44=;
 b=eTuTituCDQMtH+wABc/mxrTsIrMofKmbi4tOuQZO5Hwnz/m76LMGST+dan1MOxlFEM9iw9mqny06qj8HfMcRkaD/gv8ET1AZdpnLziii3+ekmXaTjgDr1z4QE6sxhI0ugCP/tw/X+d6AYZrweW+mbd+Ynf6/4WVoQMbqEw+mPoknVYggfHCrYWkfUezqyPJAKA/MnHQJN/B85Me/jULzo7HWD028zGyy15dxc8LDlUbozi7DrdfljnVQvfvXcJaAZ86+LI2oNzWFJfrwGGrPsRtQpLihDc+utdfHsdk8BMzA7aWznmW6VKnIVEKAW3+h0jQ5j0c/QcdL75QhtVAy/A==
Received: from MW4PR03CA0257.namprd03.prod.outlook.com (2603:10b6:303:b4::22)
 by CH3PR12MB8401.namprd12.prod.outlook.com (2603:10b6:610:130::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 01:45:45 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::18) by MW4PR03CA0257.outlook.office365.com
 (2603:10b6:303:b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Tue, 5 Dec 2023 01:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 01:45:45 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 17:45:29 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 17:45:29 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 17:45:28 -0800
Date: Mon, 4 Dec 2023 17:45:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 06/19] iommu/arm-smmu-v3: Move
 arm_smmu_rmr_install_bypass_ste()
Message-ID: <ZW6Atc2tHP4il8ic@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <6-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|CH3PR12MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: ae76b4ae-af12-47c4-8fd7-08dbf533e62e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A76Gi6qE5+l6p/pThVH1/gmJpWYdieWvV35/wdRXCNczChxwia1rp4y8ECxB6I8V/qtrswYeB1KX6mpK371rN1VtZI53ivgu2+0u2445E4+HU6KSgY1AlNoyJ+eahMU4FJjBB+eQj9J/XqDoURirHYEqaTUdoDVO7LaXY5iN3NafLYBIr5hqUXFI08RYk7LcnkEaeI8uxK9lPb0JiYw7OsVk06y/qLOl6552lb5+sNGsMQEsVjJbk7Yi3FF4fkb3PsmuG2eRgeIlHTPiNw02UL76K8N+jgmlmtQCdHMNvNGPfEoGwsIUeW26/e6IlwWYBNhGdUqIFHLx0yG50YaVdOR65cczXfbWRrNz0jS/qSjis8MW0gWGon/nFO1nKfwKnNL7BlOT0oAIWXfz/kNO0GQI2V67EnrogtjrIp6o1PBKNEy4ertzaMSB4KeQBLw6GKYr7RBYcAGvEkWbOkCgbAGuYXMz/UPPOaI373HSYJmglaXkFlHAZZ707atpMD75HH9JSXZV5AnNj6oCvLo6cGUky7/tyrqFpweKA6WRzfXMmgQgmCj7Inn5its2ZdrHRtcQKeBJ1KqkFgsJtCb0FZVwz8pC7ASoMqsJg5g4FZor6htHb6ug86NvsuMQDewK3dEUDU28NWWQQEaklL70pE4MIVnINrcVV2CT3bKf77fuisTnULLprmKxKXjbMi5RWkjGbvrlGTcMRQlS80Fxm00rlqa4uFBkLp+Oe39KwekuFH7wfJIO73kKIzoKK0vf
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(40460700003)(426003)(83380400001)(478600001)(9686003)(26005)(336012)(6666004)(316002)(7636003)(54906003)(6636002)(70586007)(70206006)(55016003)(86362001)(41300700001)(8676002)(6862004)(4326008)(8936002)(36860700001)(40480700001)(4744005)(2906002)(5660300002)(82740400003)(356005)(47076005)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 01:45:45.5599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae76b4ae-af12-47c4-8fd7-08dbf533e62e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8401

On Mon, Nov 13, 2023 at 01:53:13PM -0400, Jason Gunthorpe wrote:
> Logically arm_smmu_init_strtab_linear() is the function that allocates and
> populates the stream table with the initial value of the STEs. After this
> function returns the stream table should be fully ready.
> 
> arm_smmu_rmr_install_bypass_ste() adjusts the initial stream table to force
> any SIDs that the FW says have IOMMU_RESV_DIRECT to use bypass. This
> ensures there is no disruption to the identity mapping during boot.
> 
> Put arm_smmu_rmr_install_bypass_ste() into arm_smmu_init_strtab_linear(),
> it already executes immediately after arm_smmu_init_strtab_linear().
> 
> No functional change intended.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

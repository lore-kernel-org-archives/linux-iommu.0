Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ECD46AD
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 02:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cKT3XueA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6pEPqwugZua005zTI8rGXvBjoG4ubW2H8zG3zG1KnwxK0ilfKtPPYO6r1wx2AD9AAScuQBbeB92i6FB2WDr8BY7xko9sE4N12NjPDNEMpHNqb/oQuibOr8+92v+MOPcGUu8VNyt27WGc4g3Iiu9scFIGspX24Y0s5NTvaovVoQ7uZV9teu5RSLURRID9ucjTBP1hZDv7PSms/fGw6BtFFqvrMtBSOu9dcNDmDmbIGdwXcu11bT30mILAfRL8Bl5Iyz4gB4tzBl5Gy7U3pshmX5toxR/8W28XZN1byHZjrB/D11CQS3iXNfUiEXhcOSxhO/R+/xhbUgWMtbrrx0Y1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3Khg3oaZgmZ6m3wbNXWJpffOrvYbBAOiM8At7rgUaU=;
 b=OIGY28zhf+PF+NMMuw3JeG8b4O7HfPL/zgzmoMruQVb2B8STiQ1ZoRp5WR4de9HhX1GFpbTuhqtushsoNNQAjYQpRb/hOTPplPPAfw1Ebnw7FybfWNa+xroD76GstcAD3pSSFYldHl3B9tZeKuSdWRPOFXca75aX4RibXNbPDT8too7EHTBk2Cp3ny2LXIC+2675q5SVmGh3WDAj3YZW1QDTT1mlmOGEBLz5+rRWQo5FLFu+tXpouhbw7zPjFwD2lF/+pw2bwP22vXanBgLUv9sgc3ZmhyoX6Q3ycaTlvstRhQOy2HC4tW4GAQPOHipjWaJzbdyRFM6UB6QbP+MMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3Khg3oaZgmZ6m3wbNXWJpffOrvYbBAOiM8At7rgUaU=;
 b=cKT3XueAz3mq/wKx3+uqIbf6/iWSSvM/kppcuX5DMpSbyQfVrCgFs4bCuOfvl0CmN4CHdQ03KAJwUmy6JsWpFVfRyHdtp+kIrbxXv9Pgoc+vfG8M4cAsYJ2/l68kmiABmNTZlw7AJMeemck0oSuXmGg8+1mCM9o1d1YWbVLrnELux+luPQTDTI5bvw7p0zdSfrYomV1aiGvbFd7VO5WPBPP5qTq2bODQnTxZIKbedbeLXJIsqnnQAklIxupY0wA76vsWTai726dtQvI7H5EK0IxSpxGeewSBjl1TIrxLMou9TicoEDrdTqYCD+eql3zmCuPBbMEL7IeV9ZrYmhrF/w==
Received: from DS7PR06CA0014.namprd06.prod.outlook.com (2603:10b6:8:2a::11) by
 PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 02:16:49 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::92) by DS7PR06CA0014.outlook.office365.com
 (2603:10b6:8:2a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 02:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 02:16:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 18:16:46 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 4 Dec 2023 18:16:45 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 18:16:45 -0800
Date: Mon, 4 Dec 2023 18:16:43 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 09/19] iommu/arm-smmu-v3: Hold arm_smmu_asid_lock
 during all of attach_dev
Message-ID: <ZW6IC/gSOViGrGIG@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <9-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f59aa8-a154-4efe-1d70-08dbf5383cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tq7YJ1vsxhEXWBZ8DJGuhJT5zPJen8ZWqW8n5XXd+xttTlxqP6HQoSARkUhxATuknBFT3BEiUi1UAk9ez5u3V32YdB7d7jDiHXC0ExH4HCCkmVp6kIuA5jLXVfjgsltw2iFvEwls2ajt0XZAg21kImdddnNVvP0W4kNO7WIQBwBw5u2MsDXEl1DOFlI4zMRKuRZ2qtZu4jfG428GyYFRYLSZEya3bf6r4SM3u40RutQA84/zsMu+RZ/CYSsRtxjIPM97Qsi07woGO9/+FeWDsoJyxjbHl0oXVwuawI5qJBrWbM0oGs660+xmEp4fkG/7mfT3pvQpj+7R5uhCZqQEs5JTOUAQdbeeFEwkVoe9CTBRakoAeUYznp/00gdg+vC4KDLd/Wm3ReVOPjMogdZi0DwH37fICsvDdfhJSceonsbe1SBP+zd8hMKx9pmjpY3RC6MgH1DNtbztTgaqfjt7JDArJSOPjux2hkvLUS/1MrOt9thJR5dJ0ijXG6H5s1weRGZc3NuuW2+VI/sVyGiWl0RTqUZJ4NTMBgc/G5FM8+7+EMVaEqdjRM83UAv5jBqa5dGirzbyCwUMZkp19FfZhffUi2IzlEcxaE1zOo0wx34QFwnidkybzdga3jJoWOwG/0AyTCXZRm0ho+KwGvnVxaoezgBCYoDr9d7HCMqf9ch4CKRqCcuKQ9g6K7We/imoE7A0OXTjKO52puIPyAgu6CUmn8EEMkwlZD3njmz2L/vkODOwwoumv4mVzi8mlK/5
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(40460700003)(426003)(83380400001)(478600001)(9686003)(26005)(336012)(316002)(7636003)(54906003)(6636002)(70586007)(70206006)(55016003)(86362001)(41300700001)(8676002)(6862004)(4326008)(8936002)(36860700001)(40480700001)(2906002)(5660300002)(82740400003)(356005)(47076005)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 02:16:48.6628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f59aa8-a154-4efe-1d70-08dbf5383cab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835

On Mon, Nov 13, 2023 at 01:53:16PM -0400, Jason Gunthorpe wrote:
> The BTM support wants to be able to change the ASID of any smmu_domain.
> When it goes to do this it holds the arm_smmu_asid_lock and iterates over
> the target domain's devices list.
> 
> During attach of a S1 domain we must ensure that the devices list and
> CD are in sync, otherwise we could miss CD updates or a parallel CD update
> could push an out of date CD.
> 
> This is pretty complicated, and works today because arm_smmu_detach_dev()
> remove the CD table from the STE before working on the CD entries.
> 
> The next patch will allow the CD table to remain in the STE so solve this
> racy by holding the lock for a longer period. The lock covers both of the
> changes to the device list and the CD table entries.
> 
> Move arm_smmu_detach_dev() till after we have initialized the domain so
> the lock can be held for less time.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

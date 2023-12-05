Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75FF2117
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 04:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tU9vC8UT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCwqoCzlB9j/kTae6o47XvEhQc3O6Okg21S2k5MWJF4BxnDZeWjACL2yawcIVM1On4fbFGPVrUHjhAwKHJUyGDi7SN79ZJB7speU1bKj1S6x1wevGON91wDr1rcqIOHCrmID28fQXlCDxFwM3/Y3OGpWliSNYS0P9hF8QSXPWGg2uzjmmEmzD3t/f+gSvrV10SB2f7IyZ2iI1nTzkng6tx4cDHwxTozBN0Tl8u78KqlgbZzFhm6mS1O/eZhBKEseJb6/Uk2V/Avi3+DO8y9pbQ84EHEXXDc94ORS/biOcFZY8H8+6JQ94RFF+fkwlMTpXWQzaA56pGD+pXDGfLGizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMpR/uYvYExotO9aLlMslNVq0usJZo4I/NGCF/JBeiA=;
 b=WR4L7l8661K9tqS6rKEZTrWPwasqXdd4q7aZjvxYdwh36N7/Yp/HYFlje8+/DSATsme5VShFHCX0nhMXgU9TJvXA7batQNv5ZLRWF8bJgFgI8esqWwfchEU8wh/KKexIBmKna58cNJOqjWihcXOjSMeKUqAIdMpVNCENxGRcfqG+LMbVDlawi6/Eh6h+rKqSOSYJ+4YoFp3BfZg7sRug0qgEZ2zMD6M04LSwb0aOzSetejp4Tu38WS1RoBsT7yMjPTBOE261ycEh5yiG7nod/yk4vDt2PF/0q5NlLE6wW/z73m6J2R6f4zPszms3v4HidOlYzuIP8bMUBMiLJ3IQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMpR/uYvYExotO9aLlMslNVq0usJZo4I/NGCF/JBeiA=;
 b=tU9vC8UTpotpegWCYTXFtour1UfdNdgFKGdbhDc8j3XfCwCx4cS3MnIRbl6k05/glezehwcY6J65uNQeSV0GvBBrcbxhQCXZTm1pqvBLTpoTNE8/QXpfmsnV+drksY1bvM9Dj+MO7Xx3DRhuwxJlyvDDIyJMF7fmwT9JfMtdSqZJw23VMXxD4bdR9TCDBsfwPd2HDrd31YEbkHcEISlUPoEC9+Ikrf5c0O0L9WjUplILWqgBnOZrkgOtbvUmB4mud0GGuDC6NuquGJ5hKTHm3x1ouh3UXEkJaSNMe5hlcsWud0x82DK6ulAit3BEihbFtVlCWwt0+E8v1WXxj8MlTQ==
Received: from BL1PR13CA0377.namprd13.prod.outlook.com (2603:10b6:208:2c0::22)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 04:42:34 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::90) by BL1PR13CA0377.outlook.office365.com
 (2603:10b6:208:2c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.23 via Frontend
 Transport; Tue, 5 Dec 2023 04:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 04:42:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 20:42:18 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 20:42:18 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 20:42:17 -0800
Date: Mon, 4 Dec 2023 20:42:15 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 18/19] iommu/arm-smmu-v3: Pass arm_smmu_domain and
 arm_smmu_device to finalize
Message-ID: <ZW6qJ4hLBkIIyaMi@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <18-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <18-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8bf02a-be9e-41d7-554f-08dbf54c9946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JZPyhNf/fxJQczmKaShTfFVbSFzXRVvNQM04Tw70vfqXQzk64Ej4fEehLT/jyBjj2m7KrE8RKmebhLLbH1UxFliHnMTS9+zYoCDpom1DNr7R4dAqvHf0spn5x7sEwKLNFSygib1OVzvdOAUiRAToKXT/iKt/UvAnYdX2eTElKFadI8ynqKdnKQFFB+2PLu0lFMFdBmm3ojAnpNP8y3XEzKYgot+TsNvcY346/lLZc2KzhwpyK11GVxwbt1sfc0W2ReVGZKGsjDxAy5Yp87PyoJ4tSVweMnYkn/IJ/qSftbqPllyiduGuDDO7jMuj9HZDP+JutCnZfdNSVx/sGFNHemJt15E71Hkjfz1ozQHOKLaomdIwQayrJeYl92S+98vomQYIRGv+JQgoHMMSLdhBZjEPeFxiUWbz/ike8z+prs16EzME10Im3QFHNp/DG/Au1NnDSDdTArc7oLtHqdc0YqMQqFkfrXnoll8HIkPNDBpPCwUueZCk4I4vYXGHHodxa2eikGrNnZ6lkGWyIkbgXsRWIih/5npx+4uKiC/2tO5mZCP+50TJiGwcCOkbpvHo4v9IgY54CUqmHMORuITp8UXrUs/dXLVPSIt7ec9JelZwq/I2sQZXxfoGsGFz7Bi1NeFieNNXVZlmanWjiArAMnXANPqhfItUa6Em0MNH+JYC5oP/MBBtNQ0hse1qxWfTkTV3RVBeTvxnujEnLlgaxEos8uOJ89U8reG59rmaq84F+N4aiOA7u9crnrEv92WZ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(70586007)(54906003)(70206006)(316002)(6636002)(478600001)(40460700003)(4744005)(5660300002)(41300700001)(2906002)(33716001)(86362001)(6862004)(4326008)(8936002)(8676002)(36860700001)(40480700001)(47076005)(356005)(7636003)(55016003)(26005)(426003)(82740400003)(336012)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 04:42:33.9025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8bf02a-be9e-41d7-554f-08dbf54c9946
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888

On Mon, Nov 13, 2023 at 01:53:25PM -0400, Jason Gunthorpe wrote:
> Instead of putting container_of() casts in the internals, use the proper
> type in this call chain. This makes it easier to check that the two global
> static domains are not leaking into call chains they should not.
> 
> Passing the smmu avoids the only caller from having to set it and unset it
> in the error path.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

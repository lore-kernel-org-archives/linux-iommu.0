Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839024A34
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 04:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qQ6IhS9s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+Oe+gDFBtkTUosyH1PkHUSXTczLFzPo3S/8kzsabLPQIMPGQWFtDBNSjXqCN+0xTu/wXdhhhV1pRP9V6k/057YVs+4KJ3VHdpWvZq+Ms5BXulYJds182iRBidyzINx1HETM7QB8l3WSepmjHX0ts7x0fdF/b4zJEnSqXD+N9w6RlMqxpojn8wPxLmXdtzj451OCFsUW3WPRltQ1XQeZBLkFeV8Uy1DnZflPz13gvPZ9A+ZMRKUnK3mTCICAhWzTCQDZ3YLGGY73xV+9OImFFqLjSYbvhj2iEvvH4jLL1K1vv+i4oCaARgYYxZQew5Sq24u4RaohUpP/9eV7xx790g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duKZfhh3bCZqM6cd00ESct9GOYtnzviggsiDXSbFP9o=;
 b=jxu9X+vHMwhdUJfKs6V7104djuTtXvnVnLlghU7clCyhF/Xv8iBFw1rz3ASdQc2pdAs6o5bXK6yuLjQfBEf/+zSQf0eMbzVaxVtxqmbl9idN+wiMaxK1R0EehKi9bmcM3V5APaPI75dVW0cbhl2QtLch1jjPdo1K0aliFBintuRAuPK1G6CdbmiQbVRZyU4Aq8tnBqiJDT6SrxWvVEma1gn035z9w9MvtsdX58oM+6LNtv5KBR9WmjQwl84w6oZNeuGChpmoYD9FDtcN8BPriL/sfECZmr8AO1GJEdWeQEFMRSxcOvCWSWDKqdScbaVj8E7Lo1ubpqvEdyD3pEuZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duKZfhh3bCZqM6cd00ESct9GOYtnzviggsiDXSbFP9o=;
 b=qQ6IhS9s/741ekhHYL8Q06Ag+YQncJ1DRcNYFvbXxbhghBNTjg4F5ks6TmkP1xY5Eg/h3wQwmLsZ2Td24nwX9goKo8WQ6Ck0yd6aosq+zOIynXTdUG9lorFHjDreOOoqtgTIcUq8vIS7ShQFDFImq+o5Iri1gior4X8V7TF/X/FKfwuA0FuPi/SQ5MaW6aPqwLugjNUQ+n89ezyijM9WtWnSNoS3md4GFzqG0WUGr+8/mSnGFiaPeLrJeXcds0VxwNFYZiTvfQgsW91Mycom6YpOYQ+tISe3J3mYbB+MqiPvdGPbmUNh9643KD5J6HcsAvF7r2IoDaFYKh3Ly3+UkA==
Received: from CY8PR11CA0038.namprd11.prod.outlook.com (2603:10b6:930:4a::8)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 04:47:41 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:4a:cafe::16) by CY8PR11CA0038.outlook.office365.com
 (2603:10b6:930:4a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 04:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 04:47:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 20:47:28 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 20:47:27 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 20:47:26 -0800
Date: Mon, 4 Dec 2023 20:47:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 14/19] iommu/arm-smmu-v3: Remove
 arm_smmu_master->domain
Message-ID: <ZW6rXddeJ9Z3VU/7@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <14-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <14-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|CY8PR12MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: 6528480c-ca7a-4565-2ea6-08dbf54d50b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LqMrGjpz8d5yCD/87zN3qykrlRnymFKYfuu3nBqOwR3lNtCe3ag9LqECK3JfNPRoIPX1EZs9TYSN11iITc1psyscD6CG5tmJDQCI4TdwNb4ic4+T7/fR74D/dcIZpjSGt40bs9ZtW1YNYSsTcfisXIcckm/GJZcHnFgt5/OO+ftHtJnWGso7GJ3iCWs4pOghW//e9V7C6JYlxg0DgZfcIHkT2LuymqFzMFSC4uIANGarWYynbHXe081DuXkpboDEqRbRYcSTjlJZ/irvkmysMHQv+Byqsz4oKO7tR9cm5qI1c30s+XuGD+wslDP59K25jWtT55tZlCeaqPD4tkV2TJfse7U+lxbC8f8xjFzxONORig1Ev40a/+QHh0iHDpSyn+H+Aze6L+ZpEq3Q4PBsZ/uLC56uS9v9c7YPqqPBkSiOlqYTUAZmdqfYyv7H4ZspSt0H/YF2LDH8kLRKpCkgI45CGtXEjwVW1F9ZWsaIZevlJSsexyOPoUqkjVaEHG2+AGCLQB7TtQYZ3cGXEjzEBw0YFJfHA3/G88Fzn3hSxB3f6zkHbv5H+O8yO56nJFFxqvNEeUHw2NfcsQiRQLmJgumZ2LICbjdjf9z5YrTu4/8h+n+YjQ3G5exFP56wRQsQ3Cgl1buJa4rp21crdeudANxEv40NerhA65CFfeqJ1ssrACcvt1VFX8vmkc5h63mun/Enurj9BNUkMLap754peu+P0d6Lc30VzlIQr/OUpWaXyp6UgTY2WS2j0nkcEjhn
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(336012)(26005)(478600001)(83380400001)(7636003)(47076005)(356005)(426003)(9686003)(40480700001)(82740400003)(316002)(6636002)(54906003)(70586007)(70206006)(36860700001)(55016003)(5660300002)(6862004)(4326008)(86362001)(2906002)(8936002)(8676002)(40460700003)(4744005)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 04:47:41.6792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6528480c-ca7a-4565-2ea6-08dbf54d50b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218

On Mon, Nov 13, 2023 at 01:53:21PM -0400, Jason Gunthorpe wrote:
> Introducing global statics which are of type struct iommu_domain, not
> struct arm_smmu_domain makes it difficult to retain
> arm_smmu_master->domain, as it can no longer point to an IDENTITY or
> BLOCKED domain.
> 
> The only place that uses the value is arm_smmu_detach_dev(). Change things
> to work like other drivers and call iommu_get_domain_for_dev() to obtain
> the current domain.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

The new version on the github looks good to me.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

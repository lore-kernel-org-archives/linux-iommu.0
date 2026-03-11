Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA83E63A2
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251800; cv=fail; b=gsfZcdUx04B/P+Tac0Eei/E1FR+w0x87dB0hXyAf/cZDZZzCbui/e+4E3SMh9R4vU3fNC+aSve9EZH45G284wdZHXj7CiPqtl8beQVyiBcKj0TKMONn68g2aO7Eo0uCvmIBY/Aq6MJk51/0NS6VTvBTKABJ+PzPqEaOH0BaYdb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251800; c=relaxed/simple;
	bh=jXHGr4PCN61BmnhQNWOAeI9+ksJPWWONmrkQbZ7L/jA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oa7gPNAMLnQiICjv+CRQvIHTGsgvcsglKV3hpxnNwKUi05wplAbOzO0XAmJFRaYys7WktZtHAS6Y9eEYr8vUqNFcKiLV3iSzPSYYqi7vSBXmc88wW85b+MfXFGZ8DneV9mWBJhPdlQguFr4+QWPBZnWTRQdUCJlgSf1VIaSX9Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BGCq4vol; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BGCq4vol"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3hoSjTm2jInU7PhC3GhdO0qP5TEKw0TtdW7l40o92pS05SnLvwjwFYISJbp1imRQLf5w3t2NL0ObP0gcLNZ4vw+qBQjJ7LxAS37gimocs7qoWoqZCol6Lj+MoyNcdlj98zQAeuhcyh1M29uGS3cOOoOwTGV/A7lzUjnSmauJfdHVuvoZzXjAMGIDpKaNMWNF9Yv/t8Jnml+OD8xwN2F3Es3SiejeKjqE9tv7LXNrGzEsMAFRjD7hEsy9Y+2QP0TLdfXqkuSqCjJLexH5VpVOtR2Uybm1c6IUchDRzzzWy0omJsURzydvp+PuLDl6xP5xwJ9sgPXvWU2hS59KrM2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JM/UKPr8WHWT+2bpBZouv3YNNfRI8bvZ9jAmYgWP8CI=;
 b=LOeShI53xZOAm0LSvAKLvOLZiWEmnRTgJ8I6dQrFGrYzp48cdhgoO5DG0wcKxmDIVxy7kweVJrbp7ncCfaD81jEiZj3sotRmKUrActd1av6q6nmtT+sRBpIT9lrFivBlr7QZGmy1fZTL0ABGy6xoG0VF6Q9y/RN0x8pbQSt50FP6NAPkgbeSRJVm5kla57PAQZBjZfzVVI0A8jni00QuaewRgwt1qXzbLDMA+HB6bn60hNYRHubPrDeZtrV3MfOjZ0MMggiRYdKTpIF47g5YAZruXh7U3pdsi5AyV0FBy8HifNSBkpHARNVV39ut8LOZXqcA3/ZtyB1y+R5sHl0NFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JM/UKPr8WHWT+2bpBZouv3YNNfRI8bvZ9jAmYgWP8CI=;
 b=BGCq4vol5B2fvBzhRIbnA+iiz/nf5GH1rtcwgzfQsMrxiPdvnnyRxjk+JqCQGo/j9g7bDK9bMc8vw18pyDx11nLXbBzzV6JZeJjWUlrxfOSkkYwvSbNh8DBgWz/GjTh51uT0dPCbDvbjNG/2rCD+vBhc2pQh6ONkaZQcwUZfGxawktzpj28PB9SoSWzCIKdREXMRbMJnBZ3MP0mDpi/6jxRKn73d6YqKEd5xcS+uESZFsbM6EtU8Sy2xCdXRAua80RNnSqTZs05OGJjFKDAogW5DFD6C76Qv9dZAXfF4p2cAeZs934gyhYi2eaAxFwfuaWAsvwvphSH6InyV865M6w==
Received: from BN9PR03CA0853.namprd03.prod.outlook.com (2603:10b6:408:13d::18)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 17:56:33 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::b1) by BN9PR03CA0853.outlook.office365.com
 (2603:10b6:408:13d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 17:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 17:56:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 10:56:11 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 10:56:10 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 10:56:09 -0700
Date: Wed, 11 Mar 2026 10:56:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "praan@google.com" <praan@google.com>, Malak Marrid
	<mmarrid@nvidia.com>, "kees@kernel.org" <kees@kernel.org>,
	"Alexander.Grest@microsoft.com" <Alexander.Grest@microsoft.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "smostafa@google.com"
	<smostafa@google.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFTv1 3/3] iommu/arm-smmu-v3: Support PRI Page Request
Message-ID: <abGst/9dQBzoYZJD@Asurada-Nvidia>
References: <cover.1772568590.git.nicolinc@nvidia.com>
 <ae9a953251b46b49bb0ca4289d1f3b614ba5d6d7.1772568590.git.nicolinc@nvidia.com>
 <CH3PR12MB7548107B5BF7ACF4C0568B26AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548107B5BF7ACF4C0568B26AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fda831e-dfe3-456a-b9b8-08de7f978838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	G7oDbEPrkXLHidpaENph1e6zpXHBvPUe6YCbm03bB0CsGqi8M6DRzvdxF/TYbefu2THdQ8iWERjlGjrudxdQHrIqa7vQTvgPNmQjh08L9B0ZnZXFxybvn1fDGD0a4rRKa2npR3X9ZVwNOTMnBsxnd5HwQdjoYKR/SwuOeaOI4VciYcw9BNvoWPdHuOAFtKQcbY30vkn+E1335BzakaNoL8/XKBg1U4jY/EmgLW0AqYggNo3SiwElmr5790dUiiddNfjwhiGyGD/WEep3hz6TfRWW1Y3UnR5Gpymyauc9cuGxKDHO4zt5baMwq0k/YV6aM4Mff9Hd+/UboENlSyd96ezdsFU/Bz3a666M7LHPS0/AIPuZGDuGZUhQO4kJsaQVS6h3G52uDhx6s0bssw4BD8aZp6BVmjhlsLQ66Q0ixamjg4ZUi+mmzpoVBxZo9eAYxaDLjM5rjhiaRBGpukXjvth3VqEneJ0Y5ITJTHyRrTx8z2UK94Uy2EX9PEWWXmSqV4tasOjflG+YjJ0lX0QvC+LTtQzWokCZztQBFICxiRzlmUV1milXgNnMPxQ8j2+f882qcXS81Y0hogMnIxieApeTiLNHvA4K5Zwr9J5IJUZPvNzRnPXFz0Z6kuoVXR9hM/r+jCMCivjZUY/fNpI8rz3QmTfPArdLr4i7F/Zq8Z6cChoWzzRGup+9+dVYO3IR1gOtudNNxEhnUT4H9E6ncUIjTnqf6sEqA6esH8tJZWvUJIEZTYNdx8sToyhpLIKFBuRMZB0G6czUZywu6Zk8eg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h4yDVz7TZblAmixGGp/boXwQdJf8mqEybjqrfZWxPwheZ1+uUwjAGJf96b/asm4YfMGqr/pdRaqkVNRE7Badg3xm7kpPL9L9lwzyGuaV6f1q3NiFKQGuD8JWWoANFsPYAGy0NUCvTrLzzeS0Uf4I7jt3Mm3YNdYc+7uA9tLvpT7Gy1qj7jewRfPlL//N2AuVmxnLi0+/o7bC95olIDyj9jYdLoOgh3kEb4F9EA178M8o8hpM/ZvFhmrlH4gn2t9zq91jLR/V9gTgBo8Hncln6rSLm/pXsM2TE/kbys/iR/F3MkxV5jtRAQGeNF3ZTW3e6WAOKF7/u7ANBzAYbfxwAI9k/zYO/MY5jlaWB7XFvb1N+We3JoDozwqiMuaayf1uo1xafK4swsy1bw5HFPCHjaUVLBV8NCYnPfSnaaoG0SVbA/wkTpN+utexjx3j0MNl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:56:33.3516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fda831e-dfe3-456a-b9b8-08de7f978838
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002

On Mon, Mar 09, 2026 at 04:04:31AM -0700, Shameer Kolothum Thodi wrote:
> > Now, arm_smmu_page_response() can issue CMDQ_OP_PRI_RESP for page
> > requests
> > from the IOPF infrastructure. Decode the page requests from the PRI queue,
> > and report it to the IOPF infrastructure.
> > 
> > This fills the final piece for PRI support.
> 
> Do we also need pci_reset_pri()/pci_enable_pri() to enable PRI on the
> device side?
> 
> Also, is there a check that the device advertises PCI PRI capability
> before calling iopf_queue_add_device()?

Yes and yes.. I will respin another version after a test.

Thanks
Nicolin

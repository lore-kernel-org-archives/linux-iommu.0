Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AF5ECB
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 01:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qjsR7nXP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/vn0JLau6jm9FgKZ24FGcqUR+Q7Lc732MWmzpzg6QfAYZurQmdFiHpkXYxUaZ+rH+Rru8xqLHK+TSYXvo6kQXBz0vQP+fWJF7KJvWj1tkZGr0BN2RUdAVSQvPeCY4WlDRBHmVWcjbYiBW6IrYjidyTVfFnlUj3YEdysqR64V27kXEbsNAS9ymIxy3YvNw30ayB+JYgKitb28KBKeQefU3b1CaOSkD/RkSDVrehOtSXUx1f2slhOZsKZtn087k9EIW5z5zGRVt8TcIe+dCXpUmDifmDhXMBWoEMWt9uOsyEpsM3T545ZPJwNMYSE+cpgjw2e2l9fiIIW6sN4ilhkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tV8W45jGS91J9UFk4mKjHZbdLW3C2ShN+lruHyGEB3Y=;
 b=hWjuVhz+nQ10tTqDCb5HCS/NAp04I5vPI71W+5DlwA12vAHEURTKcJ0TXvRT+zxSAPnzFe7WULQmiXO92ak1rWZNaqYlJDVufkk5arbsZdmT1kwGj8aNkyzKWRd0WWr3Uz12HRR6Mp46WPBR4PoGNP/ovBLKRBYP1eZIDLI14Zz9+SmQFYZrcOYk2gnIcqQt2dqYt07iR34OT3Avf02KjCPmBwbNvnSf/h9sDY4i7iFcejL1/QW/bwXOeWA3iokYGwFVfXoNuAWYK7Vpbra2kS+Oca829r3uVc8HchkzFjYSFCxsizVWP1eKGUPGhqU0jQ+DcsX1eB8LMu2VNwydmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV8W45jGS91J9UFk4mKjHZbdLW3C2ShN+lruHyGEB3Y=;
 b=qjsR7nXPimWdXU5rsDVZ7IZ7/ppbBqu4pNZg6+Xg8nTjIi0T+JPhbsGtnNorW2Q/KOfJjhdBLG8aXR5CLuhDgtl3TOkRiElMpajil+E4DGWTF4hCAzv+CKeaO7sT690TYFDNocDy3BzGcpP4Ndn3hNf73DYxaRfm3hgcvcc5Bc+HA2ehYpx55RqTLKOIDiX7IhY7mvW+T5XCFy4yckXg6t1lxIty6qizOczMZNlIWxwnG7H7FkGFOv4/xlhp5z/VeUVdVkH/PBzPu9Z+3iEAFHg5CxtICye9HdTA2q0icdGimRZksl852t+/cd1CVY7KfRXiWDlu4Qr+n0TFB+/D7g==
Received: from BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 01:39:08 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::96) by BL1PR13CA0119.outlook.office365.com
 (2603:10b6:208:2b9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.23 via Frontend
 Transport; Tue, 5 Dec 2023 01:39:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 01:39:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 17:38:55 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 17:38:55 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 17:38:54 -0800
Date: Mon, 4 Dec 2023 17:38:52 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 04/19] iommu/arm-smmu-v3: Make STE programming
 independent of the callers
Message-ID: <ZW5/LCBjidzEqw4F@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <4-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c24206b-2afd-4407-fb59-08dbf532f9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d4yz0uFR8wDSiyUg0t2DV9EJtV23fOaB/yYiCqPXEiKbNlJ/yyzigB432lBwvs3ds6YVKp4QziIlInrjXZvZPXxd+WnfchfuJmHpRE1KvY35Ygn+5rQbhYDS73Drs0u/Sl+NyS1zc8lYid0J34QzSuzUpMWVsjNzz6+ZtmYmIubO3Bs2Y/np9ZHQfpgzKMf7slybtxH7Pen/0EAbGmYd9mIpak5LrjgiA0ibAYeaUmMu2IRGhRggd198FLt7A/CVJ823Z/S1h4toes3zJzOjl8BflYpNarBEyKFRH6RbpJOWVpqxcUoedg/lTRjmiKCWF0AFNQ801SgKABugbBLX7B3pvSlUfr+UdHUBYkf4BPVJt9g//dFdYks4sAM7XQ+ow9xyugCnFyAvpPEDJU5PACAl8eNhZ13xMawbOxaOZTj9HLlO0KNLsolJzPcOree2rETGOTbNDA3v0WmZWE5hs41j0YuB7Pcsv8O8GI1ysIGbG0+Bo05W+nOaigjSqyLewve4bi/ZEvTC/m8nLEVZ6g8oEIgMk7yKEnVNmTdOe4z6AxWN43ma/QOl29WmtGCkGm+rqG9ln/hjE4kC26Ym9V7yuN1JvPxg9I2U6+/HyokV6r5YvMvn/sXo2VKS28ioOBQy9GIMUwEV4O8S498JWplNYIwNzPBLXFkMSZ+KgEAqeOQId0rcZ2KYKHvkV247bw5RDQYmTzZXut9P3wm6iFNC+l81RdWPt1XEfVSDiByV6amWwu3dGkAy5CyG5fTU
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(70586007)(54906003)(70206006)(316002)(6636002)(478600001)(40460700003)(5660300002)(41300700001)(2906002)(33716001)(86362001)(6862004)(4326008)(8936002)(8676002)(36860700001)(40480700001)(47076005)(83380400001)(356005)(7636003)(55016003)(26005)(426003)(82740400003)(336012)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 01:39:08.6600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c24206b-2afd-4407-fb59-08dbf532f9a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029

On Mon, Nov 13, 2023 at 01:53:11PM -0400, Jason Gunthorpe wrote:
> As the comment in arm_smmu_write_strtab_ent() explains, this routine has
> been limited to only work correctly in certain scenarios that the caller
> must ensure. Generally the caller must put the STE into ABORT or BYPASS
> before attempting to program it to something else.
> 
> The next patches/series are going to start removing some of this logic
> from the callers, and add more complex state combinations than currently.
> 
> Thus, consolidate all the complexity here. Callers do not have to care
> about what STE transition they are doing, this function will handle
> everything optimally.
> 
> Revise arm_smmu_write_strtab_ent() so it algorithmically computes the
> required programming sequence to avoid creating an incoherent 'torn' STE
> in the HW caches. The update algorithm follows the same design that the
> driver already uses: it is safe to change bits that HW doesn't currently
> use and then do a single 64 bit update, with sync's in between.
> 
> The basic idea is to express in a bitmask what bits the HW is actually
> using based on the V and CFG bits. Based on that mask we know what STE
> changes are safe and which are disruptive. We can count how many 64 bit
> QWORDS need a disruptive update and know if a step with V=0 is required.
> 
> This gives two basic flows through the algorithm.
> 
> If only a single 64 bit quantity needs disruptive replacement:
>  - Write the target value into all currently unused bits
>  - Write the single 64 bit quantity
>  - Zero the remaining different bits
> 
> If multiple 64 bit quantities need disruptive replacement then do:
>  - Write V=0 to QWORD 0
>  - Write the entire STE except QWORD 0
>  - Write QWORD 0
> 
> With HW flushes at each step, that can be skipped if the STE didn't change
> in that step.
> 
> At this point it generates the same sequence of updates as the current
> code, except that zeroing the VMID on entry to BYPASS/ABORT will do an
> extra sync (this seems to be an existing bug).
> 
> Going forward this will use a V=0 transition instead of cycling through
> ABORT if a hitfull change is required. This seems more appropriate as ABORT
> will fail DMAs without any logging, but dropping a DMA due to transient
> V=0 is probably signaling a bug, so the C_BAD_STE is valuable.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

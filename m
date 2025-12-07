Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD242246BD5
	for <iommu@lists.linux.dev>; Sun,  7 Dec 2025 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765138312; cv=fail; b=KwRhiNhw49Lo3g/VEyCH5C0wosA8FU5pl+HaY1MRONha8Fk678WS4Cz6HzdUdkgcDORfBXY5DI8HvO85YygBm6YWooQW9sBAiKr7sY5rOIruyjzO9fQFrEqrOeFFyYTxGkYtSFv0mND5Ej9VsWO9W1k2ccYOyOkSpHrYvoMNAlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765138312; c=relaxed/simple;
	bh=m+8gzMYpOJnc9yfKe1a7C7bO+siIDZQA0LwLDK2QBto=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqF20qtDoFtgAkKzJvL8pbxEjIPJRFwJU/R1TGxP3YWi+3zGSK3kDJ5lBSQHTzCQc2anNTVc9ZHEfdVHfGByiSShRopt8CfHTNvkIsNXD6ormjbPU4gabYBQ3Bv0eWxXA4K/Nec5CGPDYZvsUngO+PNspB0LQQOYE87AxmjPyoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kMGpEWnT; arc=fail smtp.client-ip=52.101.53.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kMGpEWnT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGosrPyuhwI684Oyz9wHWr2IDxk7zCmzb+eWeVeKWCj2VM0j3RyZVx/ONysBc1S5OcCyHzO97CbAWPC+tS60Ocw22fQluTb3c13KzXz3c6Tofxjh3TmcgwEZzx6qehw7zsqRXmVOIVoNonInbKwBrNW/WTRqA6zCoVkOhRqu2JTB+m+w8zM8t8QFaYNpjiGb3lCvYzvUMW7SHekjCSR9Y7qaHnrmOwHOkYgb5UO1vFY9dEslr04tA86onMoRhV49uqspYA8EiZYZY+pDPjwT9/fyPDhOpS/rz1uU03Jltun09GW13FIXuh4mnoS+kTg33XDj18SUqlujZrE4WuEgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7v3amrN66TcYynolFE5KcsPp4z/pG+MgfVnAchGz3cs=;
 b=GqdBaacMFkZ7rOFtxOp/dyBI3YRbPRKV5Ned/QIe2PYfbJE1c8Rwahi4iUaaygHPhdMHdnsGnHoEb4OXMc6/LqJ7JBqv179dq4OPwS/l642kW06n+/yvfUzLw4T0fMQ8xImFCFuq1VAylJsrhRQASdI+5SFLHboxrb5dxsKLCGCao4iYXBCRzMjrM0dE7tamwuTWMXKcZTez+gpN/ZOvnk0X9eGrCjYP2kFFcYKq8kpjN3QCOH0ge6QneXFNiSQtKTuMZnjqZViSeDJ+t7lQ3qE4UQBd/L4tPEV+8XRvpeJgMQU+zZ31GMO7Azkh0ifWMuiyq69AynSZXz5ZQ/2mqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7v3amrN66TcYynolFE5KcsPp4z/pG+MgfVnAchGz3cs=;
 b=kMGpEWnTB3BKQXGWvOHOkzp86u2S1ik0mOelsBeExdivSBrZY0//p6fU9LzBq6R/GhWZcNhJ9Gh/1s4QHsubIfOM4xRqAAtFic/CZ8z1X/Qpl2x/RkoG+VW/BfB98EXcZ5tx3JaCXkTXTSrSOpEG6wlhJzKsMbe2RJI/HygwUDWPw3N6iBRxmENLH3f38MtzwMCRJdAEsmjZk02juyAwk0kveaehlt20/vmCU8JjTG58CGWyOWxGW3s127XJgxdj47aGoWJSnEUGW4AaBjRGYJR5j6ovFVi2ct+KxCsEzWwHp/UZc9tjRUYz3sQt2kVk6fA8I2QZg97k6jra/Jq1IQ==
Received: from CH0P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::10)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Sun, 7 Dec
 2025 20:11:40 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:11d:cafe::ab) by CH0P221CA0028.outlook.office365.com
 (2603:10b6:610:11d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Sun,
 7 Dec 2025 20:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Sun, 7 Dec 2025 20:11:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Dec
 2025 12:11:39 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 7 Dec 2025 12:11:38 -0800
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 7 Dec 2025 12:11:37 -0800
Date: Sun, 7 Dec 2025 12:11:34 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>, <praan@google.com>
Subject: Re: [PATCH rc v1 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE
 update sequence
Message-ID: <aTXfdr5iWS7vNBJT@nvidia.com>
References: <cover.1764982046.git.nicolinc@nvidia.com>
 <6ec73bb7cd03d90a0764f12c4b14071158163818.1764982046.git.nicolinc@nvidia.com>
 <20251206193408.GD1219718@nvidia.com>
 <aTSH5Eap7leYQtPl@nvidia.com>
 <20251206195752.GI1219718@nvidia.com>
 <aTUEikcWXWwKAS/1@nvidia.com>
 <aTWmpijaV75aixNb@nvidia.com>
 <aTXW5X4fAiEHAy6V@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aTXW5X4fAiEHAy6V@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: f40153a8-5a22-474a-b175-08de35ccd525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tYz2oMM6ZVYHB/nBOXtBK8T3eJXKmfkhyOIQFOjm8R91hYpuxmm0i6W55MaR?=
 =?us-ascii?Q?LluaS3PElVGEI26CV5ZJEKMTqYnL4y/p8bQ3fwGl2AQR2daHnBO1rEa5fRy3?=
 =?us-ascii?Q?/QUmP6BIzbIo2MXP5DZ16p9fWPVUoXvZzzXyOxuLKMMidKkBxZjFjpgfS3EM?=
 =?us-ascii?Q?CjrnPivb7AavSexFtyY9CTka1AUu592R1RGYmU1fXATtS4b880/bWMIktVFl?=
 =?us-ascii?Q?UOCH6chS2h4YFHW3nld5Jnw5bbRLWnL/8uY5T4FUZdza60UdclmCYtxC17dd?=
 =?us-ascii?Q?Rs9MRrjDS2+K7aEa1nd0FvomcFILcJz7wz9mO4HdTjQe5UvsNWDiZwvpmG5E?=
 =?us-ascii?Q?cPY1HSkweQPpz26yiuOwuHFQZS6J5yge+Elud3BgpG1NcWszOc8QYIRt6aTL?=
 =?us-ascii?Q?zL9aqQHC+8XTFdpgxdPIesaV0wndbI78WoF2SQlvu32UyQVZBA0Vo5PumN98?=
 =?us-ascii?Q?yu7wdojy5dnFLLxLcS47mYca3LuRtt560bl/J9Qpym08vo1RQTXuHcdiBllh?=
 =?us-ascii?Q?IPYLv/et7htGqbpQIvv8ZiYmFSPeRd6ztNis3StFh/7EuuItl0bTmPl+ETTF?=
 =?us-ascii?Q?FNFHSUrd2fk7ujj0uoT0OLOnoP8XEvxywYagtIyRaxi6DHT0PfAWkak/NjH+?=
 =?us-ascii?Q?XbVg57ucJguSuRKT5usjGQ8a/n/gvUoJPdQQuqGmCyHJ0cPGYUM9SbsY6in8?=
 =?us-ascii?Q?FaFDXukqUgswjYMSE9WXrF0OOsc8dzlIGQcyxCSfh74/nQY0pNbfMzH83dYR?=
 =?us-ascii?Q?i+89M2RkJkhF8NQNwMqkwSf6fQuNm9VeVU9JrPYFwsMkYKv5U7RiTCbGhyn/?=
 =?us-ascii?Q?fr/k2hd89fh47/CWOoW7evw7UNSdQXdudQT/r9Y6XURuCu0GM2wEWEc/+IRu?=
 =?us-ascii?Q?0bQGBZ3RGjIkkCbT5VmCPqR86pxK/2YHF0wgTvl6rAA64NkJ8j8ue3C9MBaO?=
 =?us-ascii?Q?eFX10uf9ABvKt8QFFsfZCPpJoDR2hZKO2R/Viwy2xGhSYEqzzQCu/eKeCkpH?=
 =?us-ascii?Q?vu36OuR0mmaR46QWR2s/4p7IVNHqA7H9/KgCQMGub+QJYJysT7Rg1VlvvWWI?=
 =?us-ascii?Q?ykzl+c50du2afMdIJfiZcKOjZcfBPJ33ZoEU178emq9PCImqxMdAVsrN8jx7?=
 =?us-ascii?Q?BJOmECH6Mo6bKzJhgdc2hOYsmg1X/xjKF6mqohS7RRJXNs6qePxLkWIoU+xn?=
 =?us-ascii?Q?k0FSXePKCgh4+VqkhFhHSwmfM9xIQw0zWigVFp7d5jZWgTZfFeTyGCYfslQc?=
 =?us-ascii?Q?2vjRo+euswS8ZggJlLaFvd5YgsdLe99Yvxc0rcfr4XlBHSkQoV55PLpm81NV?=
 =?us-ascii?Q?uwvVLI9Rl0erMi6LKnHZ6AYEK6KDrSnTC0u+k1pM93jeaaP6H3dFqTvO+GnS?=
 =?us-ascii?Q?SwV2itKjU8yg0sLFSIPm879/0djNRgt+RqEsroU51ajaXNke8/fgnOmgLU+B?=
 =?us-ascii?Q?983/MkqYbZrLcqRthNnODON+JZEihIcAb+4wNtj+FfN7+jO6t1cx7VmWlWyK?=
 =?us-ascii?Q?kcWh+z1AbUqDr+MdCLJgFF2urnWvOhHzgbEtugETzfdeoZ9XT0G3Kok1jMWh?=
 =?us-ascii?Q?sn+b6k8JZzEbh3HJ8yg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 20:11:39.7308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f40153a8-5a22-474a-b175-08de35ccd525
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232

On Sun, Dec 07, 2025 at 11:35:06AM -0800, Nicolin Chen wrote:
> On Sun, Dec 07, 2025 at 12:09:10PM -0400, Jason Gunthorpe wrote:
> > On Sat, Dec 06, 2025 at 08:37:30PM -0800, Nicolin Chen wrote:
> > > One more change that we need is at the last equation:
> > > -		if ((unused_update[i] & target_used[i]) != target[i])
> > > +		if ((unused_update[i] & target_used[i] & ~ignored[i]) !=
> > > +		    (target[i] & ~ignored[i]))
> > > 
> > > Either side might have the ignored bits, so we have to suppress
> > > ignored on both sides, which is required in the similar routine
> > > in arm_smmu_entry_differs_in_used_bits() of the kunit code.
> > 
> > The only way ignored is set is if both sides have it set and then we
> > update the bit in the firsy cycle meaning unused_update must have the
> > final value. There is no need to mask target since it will match. Not
> > changing this line is a big part of what makes this appealing because
> > it keeps the logic straightforward, in case ignored is used we shift
> > the update always to the first cycle then everything else is the same.
> 
> The reason that I changed this is because the kunit tests failed
> in arm_smmu_entry_differs_in_used_bits() when running the nested
> cases:
...
>     # arm_smmu_v3_write_ste_test_nested_s1dssbypass_to_s1bypass: EXPECTATION FAILED at drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:92
>                    Expected arm_smmu_entry_differs_in_used_bits( test_writer->entry, entry_used_bits, test_writer->init_entry, ignored, 8) && arm_smmu_entry_differs_in_used_bits( test_writer->entry, entry_used_bits, test_writer->target_entry, ignored, 8) to be false, but is true

I think I figured it out. The driver one has included ignored bits
from target in unused_update[]. But the kunit one is comparing the
raw value.

So, we don't need to change the driver one as you remarked, but we
do need to mask the target[] in the kunit one:

@@ -46,7 +46,9 @@ static bool arm_smmu_entry_differs_in_used_bits(const __le64 *entry,
        unsigned int i;

        for (i = 0; i < length; i++) {
-               if ((entry[i] & used_bits[i]) != target[i])
+               __le64 used = used_bits[i] & ~ignored[i];
+
+               if ((entry[i] & used) != (target[i] & used))
                        differs = true;
        }
        return differs;

I will wrap up v2 and send it today.

Thanks
Nicolin

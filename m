Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111662AF0A
	for <iommu@lists.linux.dev>; Mon, 14 Apr 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666002; cv=fail; b=R+h/cPaem20QXOwvhjbfFLEWDdJhwlw1l4CiIyqftgdDfxIH1ly/n1aLzT5ScaRcjETVw1ZqhoYQ0xEiK5ZXCc7w9jXEhPHvZAisrusruElsqJlbroDHvv6g4CdLVLIBHsqQwhfizwZxRHu2pGkS9pbXwoKX4QFbKZeDqJwEYuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666002; c=relaxed/simple;
	bh=8yn3GhN8FdzxHUS6c2We3+3dBH1BRA/Q15pUWUayRNk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XInwpWJWi1WuFg5aUnreFOrVI0zVCOOaGFmhxH3kbTwMi7rWFecodTgOItHq/NCIVpOY3yqhElEEpdb1r8aoA8hpa2+mXiTnCqSmkk9u5v4iPEDGggZ8aJL2pMvrMgBHc77/uhDLT8VDmfn+E1eA/zZESzoL/EXu/CJ7Z+FBPVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ug0vhi56; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ug0vhi56"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/XOsTOuy7+O/sOkp+LTONBgrw7toI3kaN8Q8OOqO+1C3w8mC/3KLJuaU8IYXOLIeDuNvXTIg8G9OHOONUk8nCSRuHl7iTVuUNevbpiGu7BQmXAGmam3CLVoC34HG30diVg2NAZyxZrPFT4qE4UHcgT0HQ1XPxI+OQp+i7UHM9UewxfmXhuDy1ULMWvnx9e0zADNYDHWYPhh/Gm2+Q70Exo7c7N6g+832Agyz5gUKkNxrxIxjP0txS8FIb8KHJJwqQuLB/AvfQ5xWfRs8m7vl4HFyFnqr3gHBy7ocXbA0QqJw5Se/k3OPZ9/Bpbv7X9+Cyv3t0tdPwr6p/NC3pqBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bo8gE27FT9Z0zjqhUzjoSugJI5uiUhinwOUV/FwB4aM=;
 b=B8zko/Ia9UZwdGTDlQUuSTrKxXA3OjOd7Os+1Q9iSSNgXiekTtGbvwaugZUS173QQ+rih3OJ4lw6wvTLwmBNx2/y7ojyWyt0qWi9dKSQeqAaibBXFINsMiHhu8dLhCvp4kB/sd337hoz3Bp03jF49rw7YPCGvO/+OzcewbHDzo33ZMwk4XweD3MkMs2RmTrJJnkilk+OXR0WtsJJOzDj90L9CMFyFTZSrj00S8Dz2zT2I9SOqsv9WKKViIM/PsQ5hk/ZbDoyht4r9AdA1XlCNG1dlIVjG0lPAVUz+vMXfcVluSbU027fqkZYkEr289VAMgOsdKznrs7TZYczmlOFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo8gE27FT9Z0zjqhUzjoSugJI5uiUhinwOUV/FwB4aM=;
 b=ug0vhi56ZG8TmsEyR7048YZ85CMQAVzifh6Vhfx9yV1uJDFYwsNrdB/Xyju1kRW6t6wbapefCaYr6dcEBSeIIRASRRmQb6vkycx5jraSUKxF8OB1nFXbSB4g/81YVd8g2bRkEQvH2ay9W5XIjQqcgBe03yMHGPO/1Wg1h9OJ3zWhzu1RM18fYWvr5UAdVXtjptqI4Tn9IlXQOqrrdBwXS0qICCMGJ/lU+cDG6d07lbSrQM4bVvP8EZ4XE5QdnGOOwLSJTI1RRGEkrcm9iLqjWIOMmhAERr8s5TlTQ5gNesa0HWMHW3+rXxYmjydgtacm5w35MeoQwt6rHhKoHbzxJA==
Received: from SJ0PR13CA0175.namprd13.prod.outlook.com (2603:10b6:a03:2c7::30)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Mon, 14 Apr
 2025 21:26:36 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::5d) by SJ0PR13CA0175.outlook.office365.com
 (2603:10b6:a03:2c7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.10 via Frontend Transport; Mon,
 14 Apr 2025 21:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 21:26:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 14:26:22 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 14:26:21 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Apr 2025 14:26:21 -0700
Date: Mon, 14 Apr 2025 14:26:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh
	<smostafa@google.com>, Daniel Mentz <danielmentz@google.com>,
	<iommu@lists.linux.dev>
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <Z/19e4eyj1k/pqsh@Asurada-Nvidia>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-4-praan@google.com>
 <Z/1MjDaAM4Em53gE@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z/1MjDaAM4Em53gE@Asurada-Nvidia>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: bb32f654-df75-479c-7a37-08dd7b9b0951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iIRUMLHnZ9hi1NQGqNv81Zwi1bE4Hg46oaCk5nilIWdtxBtV8OXj3YCih0Zi?=
 =?us-ascii?Q?k/Zj9bzyyZUiADeGpnDj64qYaj9R8vG2rcA33D7rPBvxWrEuH6UuJhr8KTHj?=
 =?us-ascii?Q?XeljNEFEyEHbSIFpCjKzDHBb5sMkTX9+b5I0GV+0CrrS062ZkCXP1OhrGbEZ?=
 =?us-ascii?Q?I2n87F13RsHqqz+iDnhTBFL0JLxM0w5wqB3QpUqbMNvfNorf+odbrfVeyVjE?=
 =?us-ascii?Q?YiixKBgS1QmiK+nmmZHeOtqVT2ts5Vo7gXYT7LXpZ+otPuACCWSOuCXISkeo?=
 =?us-ascii?Q?ArVa3oUguvzHlwEDqBdfwXf7OkoV6BFSbLn217cP7NHK4MIZuDaNssX6A6Y8?=
 =?us-ascii?Q?kCyFhXR78NudUvO4je6IeOH5UGsgdIFjRXRuLKLRZjd+BlZfboJ90dbP3OyQ?=
 =?us-ascii?Q?Cqj00yBh1txiTCaTUW+tC7zBd9yvQidI4Lbbr4nHBaOeVUE0pWKXSkdGKLvm?=
 =?us-ascii?Q?XaDE6Ro1RgsWVTYonyJBxIpWiPHc8wA7tzO7QWoeC+Kql2ZhsIbo3T5mUg1N?=
 =?us-ascii?Q?QdSeAmmaH3KY4vTChDk5GaHClh58MgOGOdiaWdGMWsR4ix43vXG2CLXbvpcm?=
 =?us-ascii?Q?sWW2Pcw6JtUX2c0/rgq7zdXxqz5W+9v0nYWEf+qM8xYf7nz4+WJJdRQF7vTk?=
 =?us-ascii?Q?+nBl6bAl6gpf1ls28Q3cZhH9ugIMoMsCPd/jawmOVwldYVScGliv68XQBfCh?=
 =?us-ascii?Q?0pRiZbX9lEkJJLG9OAsHCXrd8mpoddNhvWjqcn7d+wUdKipbT7Z8/Q3UIIZZ?=
 =?us-ascii?Q?PoDoy9jhvNDaSqyprVkHdySMYUitvBW60plItj5SHYje+dyJA0dot92xcDY+?=
 =?us-ascii?Q?V8LtGFnLGxB4JjJg3JL6p7UKPVDcAeztlgwtTxcm1WsjK/8ZlWgz7EtOshCD?=
 =?us-ascii?Q?OMxjqmiKOFXPEg0WMV/1wifFbkDZf98b+xwBYVTWUOLmSoezvfiRdCAnPRdG?=
 =?us-ascii?Q?mTsS2bUyQnTk3Rqel1ZxJw3c0PzyrOs9ODw2P/uvVdzzHoWG/zaygBA590u4?=
 =?us-ascii?Q?Ud7fVfjzW8cR9he2p/lKTN6FaAOZ6HeuiMKwnA25DppBKpZ8IajY49mDCT8r?=
 =?us-ascii?Q?nFXqld3Mfx+dDjKSWmWGPQGWkZjNJLgpfjKqOTGaCX3auOMHbAJdmXXjujw7?=
 =?us-ascii?Q?91O0hFdLxUiOhGUVhZqmfSm9SV8o89+1/ag1IdziRilxd1i9Zd8n/wV9rqH4?=
 =?us-ascii?Q?CwReGPukxsgD5uJbe0Mh+TnIKMewdUDcuw635uNgETd48ln+Mw6y78kgj0su?=
 =?us-ascii?Q?2RCWM+K/w76SFnv/OBwSyT3XdX4SL6vSIMsnQvba0CH3BkLtTV9k24saUKf2?=
 =?us-ascii?Q?sib1AxOjHTCm8xHLfne9yJF3PF3HIJuEi0IwDuWeNBgXJSQbhEDEh6brhMpX?=
 =?us-ascii?Q?BB/kUkz3kOTkTWyBVSooZGM9jNXzvUPRtvnjci7iRaI3BmPniYOaSezxyefl?=
 =?us-ascii?Q?HAio9EUq0CAux9sfZJ397F6BlYjwiOMQvGccuMqSg9bN0g2RM1mz2HJPavxV?=
 =?us-ascii?Q?SJbklsfVF5L+qWtOJBD9t/06A+mqqiZfp/MI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 21:26:36.1710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb32f654-df75-479c-7a37-08dd7b9b0951
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304

On Mon, Apr 14, 2025 at 10:57:34AM -0700, Nicolin Chen wrote:
> On Wed, Mar 19, 2025 at 12:42:52AM +0000, Pranjal Shrivastava wrote:
> > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > +{
> > +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +
> > +	/* We might get the vcmdq */
> > +	struct arm_smmu_cmdq_ent cmd = {
> > +		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
> > +			CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
> > +	};
> > +
> > +	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, &cmd);
> > +	struct arm_smmu_ll_queue *llq = &cmdq->q.llq;
> > +
> > +	/*
> > +	 * Since suspend is invoked when all clients have been
> > +	 * we don't expect more commands to be added to the cmdq.
> > +	 * Thus, wait for all existing commands to complete.
> > +	 */
> > +	arm_smmu_cmdq_shared_lock(cmdq);
> > +	arm_smmu_cmdq_poll_until_empty(smmu, cmdq, llq);
> > +	arm_smmu_cmdq_shared_unlock(cmdq);
> 
> Hmm, I just realized this: with an SMMU having multiple CMDQs
> (currently with vCMDQs and potentially with ECMDQs), should we
> make sure all cmdqs (not only the cmdq picked in this function
> by the arm_smmu_get_cmdq call above) to be empty?
> 
> On a system with vCMDQs, there are currently one standard SMMU
> CMDQ and two vCMDQs, i.e. totally 3 cmdqs that could be picked
> in this context. Perhaps SMMU might need a list of cmdqs that
> any new allocated cmdq must be added to, so we can iterate all
> the cmdqs in the list?

Another tricky thing: if a vcmdq is assigned to a guest VM, it
won't be added to the "list" above. Should we wait for them or
simply rely on VMM sending a suspend signal to all its VMs?

Thanks
Nicolin

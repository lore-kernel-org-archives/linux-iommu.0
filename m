Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E611624F2
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200368; cv=fail; b=iqb+thhFlMK1PHyNyaHUpt4B47r0Wsb06jjfx5ohnAFpsPtBHPVbbLVMKvdpgwn/muIiGSuicTXkYpdz1UEn9L60JwwOetpUW8iD941vs/o2Z0JNQKFzzn9coJ5qwku0X7ODfssP9qF4GuNwUFa1tJMRDQP7MVPmMqQRAHcRxU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200368; c=relaxed/simple;
	bh=fN47WSJEJysTaChBLeEBicJR1M145YJYxbFyrdcjVIc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbFsH9kVQNKDzG8W0lP8+RFZi7pIvrpxmp35ENnSUWWnKmVpJAIAMQINkJYIR8lZmiYnrcgiGHS5cpARJfFrJ5ULmmCgOveoYysJYf7hP30VrXaxxy5vPMv9UvTlMqt62/a3aTFd/wm+KaJ44iLoSBji9yEkJDt/0QUrZG0qzXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aHs9xXBj; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aHs9xXBj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyoehGHavLNEQ2gU4tyN+Q/XuCXgtAbalfXU1DzlXnj80R9WPgWrLiP++iwOnYvwPC+ojjAiWXU0k/yWDquQ3CRug6QdZFaDppp6NgLQ8OoY3vyXGsmcHSHXFqVvHM2E0l9h6C1tRgXSn1mOGSRJ8tfjMVPcQOfbyaeYMvGwmeA54o+ICBUmkoMGogSJEkEmuWZZ7uud1COKb9qBxFSO58gSZj+KZo/kX4n1GdMuZMcA62jnc7NFMUDwMMUvBusuPGgs0px3hormbuiiMvsVV9IOjyJdn9Szeevvq0HsgPEBTADI5aea8wNHybDjlTxr0+718K9eB3hoJQ6XkZVpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NhZA7blMajbV+xmFSey4t13rPUqiTELqa0LJbEZw8w=;
 b=ty2lcOu2NjIRPeBTRmvUhOWEdEVuSGBZyy8Lha8hs0ZcE/GWYACH8ryrX2tMXvAxK8D9kepWy/AZsekn2bw6lZy1i/B7qYpoew7Ejcp7hCi77fmAM3EQQ5ebp18V2Z5D6VxmuwtDfXfGr/ZH7l9n30xx79aRYKehy2G54S1Q0IVFqqQfIdmMtbFoXKm7pme9Veecf/UXhxiT6O4DiFcRk+ScBDdgFitTBRFuqRJfP0hRseMvb7liXX40rXA580p/pn9xD6ZCE59CxS/wEeDAAS8bXZbKptOcerjK82qMyd4wtCiHzJk/x2IYihkCRLPepiuSnLYFGSKfnP3qlN9I9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NhZA7blMajbV+xmFSey4t13rPUqiTELqa0LJbEZw8w=;
 b=aHs9xXBjvXis5n78UCZ8O9YDewVBgTSOTM+LfgfQYwp+oEC8ktDEsc/jSGpS5uy2RgXqRHPIJ28LvcXBLSDYLqvtfzRgu5TTb9AErDdrebD9dlor0518FWNuxxbrnoQH7Tra0Dxwd1XSz95VbW4eDo88sF6sHTIBX0+6iUZPRdDj976HpuTmdmN6UTQohADHxTNkWF/avVcy7BtJRfZhSMQ4w4OOUTHPw1uVwe49PpSDRqW2F2uZBJaGdBmvdWNxcFn1qzguLEu5/5woqEvnNZn6RGc7pzEbdrz+llHN4cE6XPupeydSxIPAHG6W8upx9hJAgo7Yn2M2Bjk0u4WvFQ==
Received: from PH7P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::26)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 18:46:02 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:326:cafe::ac) by PH7P220CA0019.outlook.office365.com
 (2603:10b6:510:326::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 18:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8549.1 via Frontend Transport; Wed, 5 Mar 2025 18:46:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Mar 2025
 10:45:52 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 10:45:51 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 5 Mar 2025 10:45:51 -0800
Date: Wed, 5 Mar 2025 10:45:49 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v1 3/4] iommu/arm-smmu-v3: Decouple vmid from S2
 nest_parent domain
Message-ID: <Z8ib3XngBXzFGARI@Asurada-Nvidia>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <0429d554fb0f54f6d79bdacacb3fb3e7877ca8f7.1741150594.git.nicolinc@nvidia.com>
 <20250305170157.GB133783@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305170157.GB133783@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: f67b37af-4e34-4a09-526f-08dd5c15fa43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1GTzpjwUNLurovB84x7xA5O5hvsOp1qlh91A1iSqTCHRvvkvOLbnUMPkF5f6?=
 =?us-ascii?Q?ArCM32fmr9JZi1QYN7s5/3zheqoCeivQP0oILU0vgxYV1CF8x0yxVhMklAH+?=
 =?us-ascii?Q?FMzR9bj4BUXFmIU9SI7mD3y9/JSgh3+BNA5bQ3xg74s4FSfcejW6wEnzaNA4?=
 =?us-ascii?Q?fkC/Q+BsZ8Uy7GKhJy+his2c+wC4laR5mqm7/waeLAMk8JGfFWSoZ33R+d06?=
 =?us-ascii?Q?r5JmnZ46mIju7N/qbbvgYWaLy/FkJ03W8hMGtnKFU98mC23NHJgoRTroa//6?=
 =?us-ascii?Q?p4V2qpEdKR+HY+Qi/w9rF2bR/jgMKG8EBsVPYsVMtzqtE+X96HWatiEv5flO?=
 =?us-ascii?Q?N7ZNbndkot1Pcuj1bfXyhxcvIbo2i0TpNBN5CnjDrOc3/9F48xRonLYWYxc5?=
 =?us-ascii?Q?/RCcEx3liLz2YgvSCHqs7PmoSKKvuuJMHAfsm1IOKnCddm0MsLQ3DogxW8oU?=
 =?us-ascii?Q?rERNzrEp9xwjYduJesMhCAW5ashxxuDMrWA/jEb21LxRB2zUkl4pVVq44wIX?=
 =?us-ascii?Q?3EODKNEShGKNVrx6swtObbrMeX7MRpTY26p36s+LPe7GQwi7YCOmjghCzJoT?=
 =?us-ascii?Q?hCuC0sIhvqaNrKH3xAEK6LeX/jDPRfsYQjdIuHYWyT+0Zh4S8zPYUQ2BLDm2?=
 =?us-ascii?Q?ACW+ilO3QS0nUQEaplVpSFIxbTNNR2Hj6WnHnWy68CkZQxD6knwhXwRNBpg9?=
 =?us-ascii?Q?Pkcr2LDBa+nu1pDQ8Bbkqtg6Q9e1eYCf7sCHlt1J+IMIhc02r0ZdVww84bYG?=
 =?us-ascii?Q?hb4+ZiGDOq2fviWtGiV7HLzqm4VglofsR1BIo3fLg0g2tzNLCaC6HL6Xe4Nk?=
 =?us-ascii?Q?MIwyjfIENIVfMdTQfJhRgF79r7euUwH5K6ngB5yFeYQgzPX1tCwcMyZqYKzP?=
 =?us-ascii?Q?0zttspK3zyh19Ez4rXQ5kY0L2NO57E/MpIDdnu5nParlkqvhjH9IBz0qIpE7?=
 =?us-ascii?Q?O7zjK2pxyOqKSJldB+lyivpzbT95krol59Zwh/SXmlGircFsxDUozRnOPNYl?=
 =?us-ascii?Q?3L8e0utGW/KyDvXlOxZnCalGBoLRJfY9j2L8w/ZXutEeKqtr7RW2bjFQBJiQ?=
 =?us-ascii?Q?YiFF4+WSM1LXT3kvijkjo6/gNHVYRORr2GtHgqelvMOpUxP/P4mOIqAeD63m?=
 =?us-ascii?Q?XyP4DiBEkzd3fO97HUdcXv3NIu3ryaFv+gipwPjz4PAmLIUK4J+/GoBCejCW?=
 =?us-ascii?Q?dH1e1WozOQBeswl1fUu5n/XGimce8zZfPIfkdcGSrHFNhKMq8PR0eTZIBgei?=
 =?us-ascii?Q?6aX2fx886fNi53iqGoK0rzmeDjAffMJyRvSTOxh+HLVw2bzr+EUrwtPCYg91?=
 =?us-ascii?Q?15WeFpMKrnu1qccYJb+mF6UZfi/NJk4Pva13M28DoRlJjiPuSOJGhvKBlJAq?=
 =?us-ascii?Q?AcMQQZolbrTFO2sr3pvThJ9QqQszkcPxZKeI9LlT6RSUccNHY6n2VdmxVjYa?=
 =?us-ascii?Q?VI9VI/CT0aVfr6/aApF66Jy9VQP0wI2JdG8R6UNMU309Vl0uxayO/bGxf1ku?=
 =?us-ascii?Q?RkYCEIp1ebfOMXM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 18:46:01.8794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f67b37af-4e34-4a09-526f-08dd5c15fa43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728

On Wed, Mar 05, 2025 at 01:01:57PM -0400, Jason Gunthorpe wrote:
> On Tue, Mar 04, 2025 at 09:04:02PM -0800, Nicolin Chen wrote:
> > @@ -2249,10 +2249,22 @@ static void arm_smmu_tlb_inv_context(void *cookie)
> >  	 */
> >  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> >  		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
> > -	} else {
> > +	} else if (!smmu_domain->nest_parent) {
> >  		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
> >  		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> >  		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> > +	} else {
> > +		struct arm_vsmmu *vsmmu, *next;
> > +		unsigned long flags;
> > +
> > +		cmd.opcode = CMDQ_OP_TLBI_S12_VMALL;
> > +		spin_lock_irqsave(&smmu_domain->vsmmus.lock, flags);
> > +		list_for_each_entry_safe(vsmmu, next, &smmu_domain->vsmmus.list,
> > +					 vsmmus_elm) {
> > +			cmd.tlbi.vmid = vsmmu->vmid;
> > +			arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);

Just noticed that here should be vsmmu->smmu.

> > +		}
> > +		spin_unlock_irqrestore(&smmu_domain->vsmmus.lock, flags);
> >  	}
> 
> I see.. So this just makes a 3rd classification of invalidation
> protocol that uses a spinlock and linked list
>
> >  	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
> 
> This is no good, arm_smmu_atc_inv_domain() is invalidating against the
> instance that created the domain.

Oh right... we might need an arm_smmu_atc_inv_all() that takes
an smmu pointer. This might have some performance downgrade as
you worried about though.

> IMHO if you do this you should set domain->iommu = NULL to indicate
> that the iommu is non-valid in this mode to catch issues.

You mean smmu_domain->smmu pointer right?

Thanks
Nicolin

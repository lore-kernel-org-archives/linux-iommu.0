Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED412EBE1
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719949653; cv=fail; b=ZzJTmNndY5lUc4ecfEE1sekBMmpguZKOBGA8mHlTbZ7lICgdwvo7uKoWyqB7xCslymwVlrE8iSj+8wPGOUMx4x7uuMqdMwYK+6wjtUiWekCm7WUjZtiqWIlGh72lkLlLfVH+7FHtGZda3UQmaV9dB66+03Iaz6dTI3Cms+M+yxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719949653; c=relaxed/simple;
	bh=is0L6+rKP5Dans3qWFgO+nncJQi0aTBaoX1WnNBQzXc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlK+ZVrMKgRYSRtKTe3JQ3DkZUN6kZxl2Gdc7EL1pGxeG1J7FfHmooTMZ0zSugzHS6Qn0h6rO94+2+XIjLoiT6+Ut1OZwgDVIDK2CPlZMLDQx9tmFxPqnzb44A98TSHhF73KfYn2hzOeGlToth4LKpI7etPBzMNxI730QY3PoT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o2DAx9e4; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o2DAx9e4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH4n/HMURTLu7UpiAgr0pzT985oEkoq8v1JPnMMmqxRV5amwX6dCLReTWFeMKhEKGHqiJpSaF7daEyWHqqcNgEw0NFh8rqcl9Y8MNqGGEBRCIFo+hzXweWohkMZ8nnYv92MAobkdkgdP8Q5KIz9VOK2qkV1i0Pl5HRar7fL5KPM+7jtzBFPvxFzR+ZyUXr6b0MKdGEy9MCoPUth8gxlzI31Ae1GVkBv2zU7a2RRcYRbtNb+ARe5nI0y6mUCjIX80J/cUu3ZEsSXOQ1Pd/9/cG1BYSX8Rs8NMVu0q08De9dD0ZrYMyHOPHRfbybrZtP5o9spJUheBs0UMn7D6VE54rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/r/17B3hV9n45ScMRq7aKwWiff0zKEybuznwTavsJc=;
 b=DagL7AKfN6D5puL2EIr5JjQN99VN8WT+ybyiqWj5OjoUkFaNXWu6DOFWxiUGob7DrdHRTxm+RDodo7+TTjeHkV0zw427ZSjECfDjpMMM+F86lGGZAN38O6xETxjSiivnB2WY7+VgyG1Q9mtqwTzjKMaUO12CE3uGlFeQWMWJ8Un+MKkNZaYPTZF8A5DNLpffz51GY5esjrD1/r8KUNeLdbV3P+wpOe3yg+cKVwYL7Cb79USIjf7ooOMqVFnOPoGrwu2/gEKmLJCYsBZpOCgxuMZFVYEoVh7Am5OSqmzqP8EeygC6q6dM7Diw1oSAZE0YYulMIl0hCvUeMKB9em6eiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/r/17B3hV9n45ScMRq7aKwWiff0zKEybuznwTavsJc=;
 b=o2DAx9e46Sf0ZuyYhetD04NEhyOCX9q0ssHUMMjuq+ep7cahe7h3moz7gKrfXq41vrCuTNUxHWb5MYH2TgGPLRuJvrct52+KH0J1H5bg8VQmio7zrhMJ2+Fx21vjLn/PmkbwuWr+LNBgKNqYkayymYOGy+6k+5RNXNjzTcWz5r3EQzJtk+br+Fz5KINOoGogw/0Z/eThS8QQP4xCz8nwi14rX1KfeF7hAMnw24j9BOpJIiaqkanO4/1tIje90bxZ/SwcsYb4tk15HMeI0Go2JFDK52MWMiIpTUq1PenkxDtBDgdOfxc6KcWxdKbUeGlz3GjeSD6YYCbVNo7Jvg1DKg==
Received: from BYAPR06CA0066.namprd06.prod.outlook.com (2603:10b6:a03:14b::43)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Tue, 2 Jul
 2024 19:47:24 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:14b:cafe::e2) by BYAPR06CA0066.outlook.office365.com
 (2603:10b6:a03:14b::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Tue, 2 Jul 2024 19:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 19:47:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Jul 2024
 12:47:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Jul 2024 12:47:13 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 2 Jul 2024 12:47:13 -0700
Date: Tue, 2 Jul 2024 12:47:11 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v9 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for
 CONFIG_TEGRA241_CMDQV
Message-ID: <ZoRZP4k1A3G7nH9q@Asurada-Nvidia>
References: <cover.1718228494.git.nicolinc@nvidia.com>
 <d20dc9939523fac490bc02e57d7836f680916a36.1718228494.git.nicolinc@nvidia.com>
 <20240702174307.GB4740@willie-the-truck>
 <ZoREzIAqzyamQBWL@Asurada-Nvidia>
 <20240702184942.GD5167@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240702184942.GD5167@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 282baf2b-2635-4876-41f3-08dc9acfcb87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MsrWs32FAOnoD+5VBjXXjDRO6hxCArr+vPlzuNyy8ThwSaif8Uy3uLMLuOXz?=
 =?us-ascii?Q?rdfbHx6k0OVltLgmvddnM2JLqvb5M1hKT17bgfSKsVBGlGuYwVTCoHZGTY6+?=
 =?us-ascii?Q?ehOqo1eksjK/ExsvmM/oAMgskD2aq0ECCnvoehVbNAHAJHjxUW0E/kf0CWos?=
 =?us-ascii?Q?dn84WbWk6KoSncTy97A3UdCk7jSJBt9xmtP/YR26zC7klycuV4xMAYJj00r9?=
 =?us-ascii?Q?5Bs6jTPdJYk98uWE8KI90GTaonvTMWLxJR5ZibkcGxfQuJlUH/JN5f+QYvej?=
 =?us-ascii?Q?WJhFfcrpPwJPoQYBEs6bk5US6HNipct4WDFcGhZxQVopZRl717qbLzDNENjV?=
 =?us-ascii?Q?TACVRqTu1x4tJftMNgvKfLidC87qjSrbOW+zAgB32lU2jH6KzDW0qh9KzQzw?=
 =?us-ascii?Q?nElQW57EMt7uk+ckHG8BFt/bc7XJAjHJLhMJd9OPvhHwb9VgeytUjl8gZOAY?=
 =?us-ascii?Q?2GhwuGA+wBbcpoHfKuy8Hxo3J2M3wgYynHSDCHDXNptP3K+v0vPrNQLSSHVp?=
 =?us-ascii?Q?W9DG/5LlMoR3gCh1RdquP9qHmjyFcXm3j5JR5pkq5TscIQ36+VlULb3FvdfG?=
 =?us-ascii?Q?B+ih4SQvw7cgUw6MgxKr4ulzKYct1pSf4jM2Xjj9g6staEaX2bFRRDURYzL5?=
 =?us-ascii?Q?IYJJdr2WvZU1hRNuXW5MDjfaChTsQEbVl0jOFuOcll4/vDI9X2fk7sY4VwlG?=
 =?us-ascii?Q?TW9rlW0WJ8qGXFbynRL4CYiVuUEHqf9jMaoFuq/gt8T2O/NusqXbH4b1vR5R?=
 =?us-ascii?Q?o3NggDrcQ9Ujn7GysdLQ5/gTXSJKdmEKzzhyaqinLdTtfkope7boaZRPQZnB?=
 =?us-ascii?Q?xtcJOnPBf5uMpxdlAkjvAL/unef4nHF+ysyxg3obMtx9gW9aYoH1B9pNSgvs?=
 =?us-ascii?Q?asXkWbkCM8Wlh0qP7ZZuJJwhfoQ1GzjNoLANtT4UIVq+qkpdmn/VwKxB+CWC?=
 =?us-ascii?Q?2Hqbz2Xp6BYnzePlFyITfGgH9bQGDI9l0wRWx1ioBPB95vGZVVrbl/HZ4vOt?=
 =?us-ascii?Q?jyCyZqDzuO/tMHfP6h5MmA8u5zd6HgNzaiq3C8GV4cx4NCIDockIe0gPOr4p?=
 =?us-ascii?Q?3ZGiALDJJnzYgHL5LIWG25IwYMr6XzXQWEgXzhbR3YJ9FDcn0+o8Ria70lEQ?=
 =?us-ascii?Q?GM7IWy0zU1EIXiQUhNXmf18cvT+Fvk4qhd85TOVM84ya1M8CJE+2xr5nxYI2?=
 =?us-ascii?Q?2xkikkiPXvTppccWU+7AiZDFurwZAH9K6HsrjetlwV6sCo5zEzRbjT+zNN0S?=
 =?us-ascii?Q?rqwCRcEyPwCLAWiCQQykrKAalFX1C0anBkXzU4k6jR6euvf90EhHvlwMSJS1?=
 =?us-ascii?Q?1QpyHCzldNQaVpwtv0WIlLxBrXOiW453tDk03QOwcQ3riAFWC8QDuq6HcHqK?=
 =?us-ascii?Q?tyMlyQUszXUT9ZzpHcq3SgKByiuH1LXP78UbgrCKStH3OWYbd/IF1auorY8l?=
 =?us-ascii?Q?Llb5o276Wpg686egO7BRgoa/62cZyUum?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 19:47:24.2377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 282baf2b-2635-4876-41f3-08dc9acfcb87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972

On Tue, Jul 02, 2024 at 07:49:42PM +0100, Will Deacon wrote:
> On Tue, Jul 02, 2024 at 11:19:56AM -0700, Nicolin Chen wrote:
> > Hi Will,
> >
> > On Tue, Jul 02, 2024 at 06:43:07PM +0100, Will Deacon wrote:
> > > On Wed, Jun 12, 2024 at 02:45:31PM -0700, Nicolin Chen wrote:
> > > > The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
> > > > CS field of CMD_SYNC. Add a quirk flag to accommodate that.
> > > >
> > > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > > ---
> > > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++++-
> > > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 +++
> > > >  2 files changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > index c864c634cd23..ba0e24d5ffbf 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > @@ -345,6 +345,11 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
> > > >                FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
> > > >                FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> > > >
> > > > +     if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY) {
> > > > +             cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
> > > > +             return;
> > > > +     }
> > > > +
> > > >       if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
> > > >               cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
> > > >               return;
> > > > @@ -690,7 +695,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
> > > >                                        struct arm_smmu_cmdq *cmdq,
> > > >                                        struct arm_smmu_ll_queue *llq)
> > > >  {
> > > > -     if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
> > > > +     if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
> > > > +         !(cmdq->q.quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY))
> > > >               return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
> > > >
> > > >       return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > > index 180c0b1e0658..01227c0de290 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > > @@ -543,6 +543,9 @@ struct arm_smmu_queue {
> > > >
> > > >       u32 __iomem                     *prod_reg;
> > > >       u32 __iomem                     *cons_reg;
> > > > +
> > > > +#define CMDQ_QUIRK_SYNC_CS_NONE_ONLY BIT(0)  /* CMD_SYNC CS field supports CS_NONE only */
> > > > +     u32                             quirks;
> > >
> > > Please can you use the existing smmu->options field instead of adding
> > > another place to track quirks? Or do you need this only for some of the
> > > queues for a given SMMU device?
> >
> > VCMDQs are extension of a regular SMMU (with its own CMDQ). So,
> > SMMU CMDQ still supports SIG_IRQ for the CS field, while VCMDQs
> > could only support SIG_NONE. In another word, this quirk is not
> > per SMMU but per Queue.
> >
> > I can highlight this in the commit message, if that would make
> > it clear.
> 
> I think we could still use smmu->options and have something like
> ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY which could be applied
> when the queue is != arm_smmu_get_cmdq(smmu).

A queue can be cmdq, ecmdq, vcmdq. Only VCMDQ has such a quirk.
So arm_smmu_get_cmdq(smmu) is unlikely going to work if we add
ECMDQ later. Also, ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY is
very ambiguous IMHO. What we need is to check clearly if VCMDQ
is being used, so that leaves us an alternative:
--------------------------------------------------------------
enum arm_smmu_cmdq_type {
	ARM_SMMU_CMDQ,
	ARM_SMMU_ECMDQ,
	TEGRA241_VCMDQ,
};

@@ -543,6 +543,9 @@ struct arm_smmu_queue {

 	u32 __iomem			*prod_reg;
 	u32 __iomem			*cons_reg;
+
+	enum arm_smmu_queue_type	type;
 };

 struct arm_smmu_queue_poll {
@@ -345,6 +345,11 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 		FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
 		FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
 
+	if (cmdq->type == TEGRA241_VCMDQ) {
+		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
+		return;
+	}
+
	if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
		return;
@@ -690,7 +695,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
 					struct arm_smmu_cmdq *cmdq,
 					struct arm_smmu_ll_queue *llq)
 {
-	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
+	if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
+	    cmdq->type != TEGRA241_VCMDQ) {
 		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
 
--------------------------------------------------------------

Would you prefer this one? I feel CMDQ_QUIRK_SYNC_CS_NONE_ONLY
is more general looking though..

Thanks
Nicolin

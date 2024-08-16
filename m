Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0001C232C
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723837366; cv=fail; b=gzsgJ7YVneKm/u4XNI/h8iaFKQFKnaZHKk4wSbjyrQqtaxbaK+VsRPlqffX9h0Dj/BvVamupXO+dNqoxBWs2o5Zg/Aa8kbBevAaUaBWXl692E+mgquf7GykDCL0ATiHTkBRcdemvUPv/qCLpWxwJHpc8bHdG30+PDKAyvSgB4Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723837366; c=relaxed/simple;
	bh=oBihAtGmAHbm8GMP9HN3DLgQMTFtBvfRXBy1wswxFcQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alpmsZ/oSKF/3oQsu+SS789Tt8lED4j3cNsPqvq0H8Ej0tqnk5B4IZdREmigZwlyi8kOnXLNsLw6hu8FW3iCIscM1qoKMIOwHGZQ9knCMbgdqBJabwhJX04Uu7bdoYmVR1BswTa/Ja4YAK3iChOTm15hZ6OVO6v83v16GM+e8Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JoRQmesE; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JoRQmesE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qc6PbnJUrZAnKhhwhdGzaFbX3n9/kWHnia0K3GwcWucdx9eqwU/om02QQn17w1LiEzG3+ii9eGLo6ZN4PTMZRast0voWAJwPvvzQJksx4XaYUR+UBQJ+JtsOnfdfkB0cmdhYAnuvyalV1zU321KwFHbwMfvfhbPjCGFP9OJqpv6vI7EpMANiQBfTgwzk7o8VaXm8nflZq9tEBApLMqKZOgpDh3tbFh1WR6ldSzWKoK78m8MadV/2YQoUn7AtJvK2eP4FIkrqhoFyNoDR/mbPVdFNrH3+mn005+tMI3NiosRm1vKh9Mn9YsedCL6rfxv+puXJYzsWHMwg2+i7gLoJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pfT8tYrkNv9JdN3zBLmaxFybtpbIfvppsTzywFtoG4=;
 b=rsfpK4xgMVTrG1ohzSH/umQgrEmuic7NdLh7gPnLmUY28hte3Idd5PS/vWx2+I3hYjPyYL7cOp9RtZLXLyoniyM9gMV4VaRXaq0jGI4ESqIKwRkpDGuU9LNCKwkrdWcSEPtwu43uFPnE1+Ilgl3KUhNb+R5HsjaH34k9TU8O6TJl8Tezej5mr702lcZdAv9U8E8ZQzih453CyDSvvngOm+0sbuTAUCe8BKiZ0rE+1G6JqtO6+Tc0PDG+o9zVRzkH1yTcnYccC0w90fqvjjSQGfq2T8MaO+f6rFKznx757z/9r7GHR+gDYMmKEjG3WwI5/z1626adaprQrPV6OlGFhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pfT8tYrkNv9JdN3zBLmaxFybtpbIfvppsTzywFtoG4=;
 b=JoRQmesE73EsTswXFgxqzzbi+jTuD+01+XTqCOwqedKTVToIW6qr/MwHlt3iKMdbmmERRkUGRKp6i9bqhJv3n+cvRhztpd8RY1XS0CAar5fLd/a3LwIDJ6V0ovi+iWdrMo95ezyt+FRueRSSuwwSzPUUMjxy+3zKqPe0m3vYw6tIXXzRX2ljo56LBcpPcjhrMkVIT9jpyCiwtYv8kJB5pbeA6cC9hY9TFFxaeUtx4NL7nQZ5yeFVbt6PYTDrweaTRb5WoWKYidvpbq5BzUHMyyiOv9qg6I3vOKjAHlyZrEEVyLCzZw9wyamarPl5GDk+Jn7onGS+uyC1rTfeLsDO8g==
Received: from DS7PR03CA0342.namprd03.prod.outlook.com (2603:10b6:8:55::14) by
 LV8PR12MB9269.namprd12.prod.outlook.com (2603:10b6:408:1fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 19:42:40 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::13) by DS7PR03CA0342.outlook.office365.com
 (2603:10b6:8:55::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Fri, 16 Aug 2024 19:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 19:42:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 Aug
 2024 12:42:20 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 Aug
 2024 12:42:20 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 16 Aug 2024 12:42:19 -0700
Date: Fri, 16 Aug 2024 12:42:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v11 9/9] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Message-ID: <Zr+rme98gB5uqTRX@Asurada-Nvidia>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <153fb887cf4bf6318c6f313a4be9b40a25a24e7d.1722993435.git.nicolinc@nvidia.com>
 <20240816132103.GA24411@willie-the-truck>
 <Zr+Nmq6LyrBTY6eR@Asurada-Nvidia>
 <Zr+XQfzje2YWIOEo@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zr+XQfzje2YWIOEo@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|LV8PR12MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a28f0f-87f5-4596-200a-08dcbe2b9688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CBDJSyBlFyk7S/HvZ6viWfj0ao1HaFa6JFHr6egB86vxPRJh9olfvq6O7Mij?=
 =?us-ascii?Q?Z+8+PiJkPUQ8jsXiV7vn03LSZnD3lIRfjrjDZNRhFRdM1yUjnmkqRKqBoIFv?=
 =?us-ascii?Q?9fags8rQDwS67gRfcm1EPersneFGZnpNC5kVGcIAX1RK74gTGVUWPxTPlUBT?=
 =?us-ascii?Q?S4zCObI4rmkqcvDQ8kUcAC/8Gzhx9byPSklTIxB1Z9Ve9lFSt0BSAYQsAPhw?=
 =?us-ascii?Q?9/NkBkqaF/tM6SY+/6Ns0+lmh9xhWLNsdhnE89Y3wQWQzmUce/PBSjZlPDkC?=
 =?us-ascii?Q?uUAYlSNU9uchv3+p4P+pPtNC1eBpN1N5Ai8rBHni8D0rfW352PyqHtMEpSNY?=
 =?us-ascii?Q?c4xjj1onEiwETRI40zNbUfpLI/6+7idZx4pJysYLx4PKpPBOrsT9xtUmn8gE?=
 =?us-ascii?Q?4XOP7SjRyXAEyyIXXnrYIP88K+CBEpsixkwxGmWcAkNIAbdqcDeEPBU6L8h9?=
 =?us-ascii?Q?GE1DmbfJbme73zVQlb8sMgE7P8Wy3UA05EJCaHpv/jV/Y6pdm/e0ctO6RMoF?=
 =?us-ascii?Q?/fcspcSU8R3mdzpWXPncrrKtO20VDHg1uyu/+ROPQ6syBbBEhF3QuHrACMTV?=
 =?us-ascii?Q?PtQt/uDHBQVKnd4kTjiuGM/kn5mbPvh8Ip7hoXLFEwYs9eDvAaU7AXTpwZIl?=
 =?us-ascii?Q?2Hy9Yqu3aVm9gnkocAHTbcj+Hph/n78B6DxMY+lILRGA5JH7AztT6vCjdiV2?=
 =?us-ascii?Q?TRioK22H05zoFREQXdzwryzLls6atGnhFmHDgPGMLjz+fU2yoXKc+WZAH7mO?=
 =?us-ascii?Q?e2DpyIjcNq+HsaDrSbWGeIrUuQCPjUgJKmWeI+momxYPRi+k9j+GdKhnVy8h?=
 =?us-ascii?Q?PpdhnKJgx578FRvSkPEiRCvsjPLhhM9ph2TJZd3UPpHQjzjrlCAWQotvhCMb?=
 =?us-ascii?Q?7q5+Uv/wu3YZzwX0vTJld4r+YcGVtwm/fFVftmcHHsExCkrq0zfpa4gyerF8?=
 =?us-ascii?Q?CtMJVl5bH3HljboyJDLmAqWgBhQN5OHSto71zSRLF0iHaMFoBE5Rf34dJ2k3?=
 =?us-ascii?Q?sMxCVkOtIqmvAfBwtrnEADe/rpHVyavxLD5wxKUM094yBw4thGYI9xORNbxB?=
 =?us-ascii?Q?n1Cb21mJsTM3Cvb9SHEckdrlGwhqE76yZf9sLqb4sVjWXBNA1hEJLEF8zXgh?=
 =?us-ascii?Q?ILlCwjRGwY/6edr7MWVX1FkZopzPKtels3QmpkxFyCOEtaT1Xp6aUVwyXJvd?=
 =?us-ascii?Q?WFtFU1b2Bz8brPVRdw5GS94z2viv1hrr17X30sF0Dr31N6FVnbYOyU8Fd2fO?=
 =?us-ascii?Q?/yQv5pLa2xpjYeI7vZH4bhvEutNwP8V1ArWCYwSMRyd3oJZ+b9AR7lDMg/aq?=
 =?us-ascii?Q?WigWCtbyuT2msO6EbvArrN7eQAwWhWmfaCO+q9Hd7LYUvpwIUdWyyelBYclF?=
 =?us-ascii?Q?pNN9AyBctXZy76El434JCUHQVvNEFe/y53zEfG2UxdVdEiDZkbQsu/x2LY/2?=
 =?us-ascii?Q?jWLZvulUM8qWM01rnVJ9J5bvdH4exY5g?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 19:42:39.6423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a28f0f-87f5-4596-200a-08dcbe2b9688
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9269

On Fri, Aug 16, 2024 at 11:15:31AM -0700, Nicolin Chen wrote:
> On Fri, Aug 16, 2024 at 10:34:24AM -0700, Nicolin Chen wrote:
> > On Fri, Aug 16, 2024 at 02:21:03PM +0100, Will Deacon wrote:
> > 
> > > >  static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
> > > > -                                  struct arm_smmu_cmdq_batch *cmds)
> > > > +                                  struct arm_smmu_cmdq_batch *cmds,
> > > > +                                  u8 opcode)
> > > >  {
> > > > +     WARN_ON_ONCE(!opcode);
> > > 
> > > This seems like a fairly arbitrary warning. Remove it?
> > 
> > OK.
> > 
> > > > +
> > > >       cmds->num = 0;
> > > > -     cmds->cmdq = arm_smmu_get_cmdq(smmu);
> > > > +     cmds->cmdq = arm_smmu_get_cmdq(smmu, opcode);
> > > 
> > > If we stashed the opcode here, we could actually just enforce that all
> > > commands in the batch are the same type in arm_smmu_cmdq_batch_add().
> > > 
> > > Would that work better for you or not?
> > 
> > A guested-owned queue is okay to mix different command types:
> > 	CMDQ_OP_TLBI_NH_ASID
> > 	CMDQ_OP_TLBI_NH_VA
> > 	CMDQ_OP_ATC_INV
> > 
> > So, limiting a batch to one single opcode isn't ideal. Instead,
> > if we really have to apply an enforcement to every batch_add(),
> > I think the cmdq structure would need a scan function pointer:
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index d0d7c75c030a..1a83ad5ebadc 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -918,2 +918,10 @@ static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
> >  
> > +static bool arm_smmu_cmdq_supports_cmd(struct arm_smmu_cmdq *cmdq,
> > +				       struct arm_smmu_cmdq_ent *ent)
> > +{
> > +	if (!cmdq->supports_cmd)
> > +		return true;
> > +	return cmdq->supports_cmd(ent);
> > +}
> > +
> >  static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
> > @@ -924,4 +932,5 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
> >  
> > -	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
> > -	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) {
> > +	if ((cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
> > +	     (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) ||
> > +	    !arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd)) {
> >  		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
> 
> We'd need re-init the batch after this too..
> 
> Nicolin
> 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index e131d8170b90..c4872af6232c 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -616,2 +616,3 @@ struct arm_smmu_cmdq {
> >  	atomic_t			lock;
> > +	bool                            (*supports_cmd)(struct arm_smmu_cmdq_ent *ent);
> >  };
> > 
> > That being said, the whole thing doesn't seem to have a lot value
> > at this moment, since the SMMU driver doesn't mix commands?

OK. I have added a patch for this. Let's just make things a bit
perfect at once.

Here is a v13 branch that addressed most of your remarks here:
https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-v13

Would you please let me know if you are okay with this?

Thank you
Nicolin

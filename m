Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9C305680
	for <iommu@lists.linux.dev>; Sat, 25 Jul 2026 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784989689; cv=fail; b=B8l0zuwTJZULzaOWRCGTswC4l4wtTlK8micFk0nZuNL+Qjw6YwnHb8qXMX59PPPLY4PMGjF4E2K1ntgxoGDb6nuBQSVZIeVgK3uUd9N5z/i8hB9g659ROkOgKT8gtnQ04ZjXKy3A7rkthvhmSx1o8t6doQpnXWS8Y8Pxlhd5g4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784989689; c=relaxed/simple;
	bh=uah7qx9chXI0rRdUvj4H/SzsCFud0FohP/0tTLU8vTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XL1HOT5La5+pqOGqGm9KGVh6MayvAYMTKj5LTcm4ed8H5wa2yJoWYeqcchIOYZpaRBEC4SGy5PkZWjcuirgYsh4UTU1hMtwPRSScXp76Em/+pGRQKS700i8rV18HFUViYUkQhHj+2aS6jgvrO5gmBQcsXd+/Q988Vp/QvdZWkoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mA/tMG8A; arc=fail smtp.client-ip=40.93.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mA/tMG8A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/OHxJPahDKuf8rWQ1CuVwKFImLp1ed5HTeerWM9Uth2TdmUfK4r/sXZwy7XrXr+KO00aywUXYS39bVj2u0Hm84RpQ1crXnjUCpa/yrpNwLptfngxF6gJyS4yH9Je3/YSzI+G4Ik3AOlOun7GGBZRo/6HqucXY0xopXQs6ZQ44XiQGMhpAFIk3411IWJDbh/Fx/ORefM9yD2XaCL1Pulj6qrSq8YrR7KZ1KMhlx9dCDJq1ZuCqhZKYKaA3aaeY4FePrqjmgP8cdZl5B6FfCQwx4037teehQ+3l9IDn1t6voHw9LwyLajOH6MIgLl9QgbO5pSyT0iOrpH37eIhLfM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fqDuWQkXfeW0V2FbgyERPEcrFRGaAAzDWsuJN/GjKs=;
 b=fXFLregL5a6EdTNsq0xbCMl4yxEjH6r0odAaLFqDf4Mx4frwQQIh36+LpfLMBuEzZcXd1ZSmUWRcOVa68U2ns+DRxFBngUr/TSfzY3eXsFuBhg0n9UDU6s+B6qG8bHZ2n9f4IC49iMRo0oP9rPL7O00UnhFhw89PrnVx1wzTXW5Bsv2/OOC8fP0W7Cj3Y7L1MmdfHyHMqH2VHb/FKXMZuIl1Abi5MTogoIju7TSziL9zSG2Zg9Id+J5uiexvEkPSpFe0DE9ThpRGI27x/RlxTSUqu0BvQTD8n3z8nPXKJzEk2P0vOdEsQuLFHqL9JLPrjuLoQPtRArSFIgvVqL4IcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fqDuWQkXfeW0V2FbgyERPEcrFRGaAAzDWsuJN/GjKs=;
 b=mA/tMG8A/juzw1P4aVpcv+yT25rwvqTXXWMozCbyQPshWRmHbcy++RbivYcXH0z/YhwQ/aDg2yu2ZpQKk68H6JfcIkhUQpJMcKHiLMQGPSPxnIyXHqmEpLtZTDmT5CIBiTxjm/Q3fX4TWhbqlffwdrISKDMbKO3RKCGOAIBmjwFAtDXERF75AIlz89zAKJnob1JruCzMX9eJDjUg5vYLsqepApMq1JoFqqo6/6wdv+YbmZaAC0PeRVKNE2W9rH9yh6DrLcp9kKAa4S0gdtPR4yQZe0K6yzaAnj9aRRFIXaLLBd6ypFQ0Ae1YnsNwtTl8dkpOcb5eBNWYOBOPw7sT9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 14:28:03 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 14:28:03 +0000
Date: Sat, 25 Jul 2026 11:27:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, catalin.marinas@arm.com, joro@8bytes.org,
	jpb@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Add HAFT support for SVA
Message-ID: <amTH7xHBY2ol4LHw@nvidia.com>
References: <cover.1784814923.git.robin.murphy@arm.com>
 <57ae366ec501a142bd20f2cc7d18b3eca8eeac25.1784814923.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57ae366ec501a142bd20f2cc7d18b3eca8eeac25.1784814923.git.robin.murphy@arm.com>
X-ClientProxiedBy: YQ1P288CA0008.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e8366e-b3e4-4918-6fc2-08deea58ef34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	093TSg8H7F+aeBBQXA1FSJEXmEWOzGF9cMHMsF3TaPd1mNR80bKbre//StdB2Axbocci8dD0xJeMrgKBpkZO3o9jrrGi4ozuSl9V9HaFeLKTZTGDWcmww0jo2+pS2hPd3AkiDXtsckNyFB5fr13VtYQ/kyLcMl5w9obrOky4kF59IiYkH8I4PEnKlEvwHvC2tg8wX8+sCC9VnqhmBjixfFVeiMzPIUyViPNUGKilkL/SwQsclyd8MaGCfqJh7Ummfp6a+3pzZnSVuzA8ZR95jzwu38N7lKVPV1uMA+/miIlan9nzCI6nvfcL0e4J4P/mfLOXZ3hxgkVKgw/4eXT+Vm6yUhE8G5N7LjF+DY1xhgaQpAHb94uqi6AIo7PPE/hg/lkYqhonGvJ4UveftuhHrgGUvwFHMinrfkEowr8lDOzkqLHEtlpLH32XVmAHGPt7gQ/ck4rpXXajJlUQzg594x0yQrQHShA8R9mwpoBUvNl2wtpj5hLAb3mTWJlD/+iIMM3VPgxcZFQbZjeX1/0vQlTq7HmFBU7Sfd6bH4M45XLdOTOLqBiafrLDLit4hlZrEF90uHmKcgkldZdHLUY8vWZMr2WAftGmQ5oivKgxWOWgXHOMVC62ppk6NfZuo6HiP6/w7l8LhUbU3avup6gauYa+XoNyM7QwXX06dREUBOQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sc+xf7Mj4+9xndPY5sh4TfIWRPr+4G3MVYuPzj41FYaIHiltot/4q/9gts5k?=
 =?us-ascii?Q?iSADA+Rp0ZvvXCnWh6V5xKqFXSxFm/+ITa4XHhYmNxajRSVUmw3Za/o94KEU?=
 =?us-ascii?Q?RB7EHLThbDSLGgIA0r4EsPx3x1Vzh/GQuTc6rxktEOvNE8Ib2wHjb5d5nyIq?=
 =?us-ascii?Q?Z/NMDxpYEOP4ktRZp6U9dAXUmlLYISZeaILD1GDHHEF9Gp3RMYVLTYoK3IkB?=
 =?us-ascii?Q?t6zrLJ39wq9ACr96fJFAjKsT+dwDCdbs7yZMC7/8xjZz40979ro6W2ZshcEE?=
 =?us-ascii?Q?Yn2XVuFGGRM5S3xJjWPPxKTVujEt4E/7YMvbjBv0j5Idq8+S5Z//mlKnsZ5S?=
 =?us-ascii?Q?B8nsBZHeK+6Eqyu4DsgXJy3ejkuZlYXVoh+3zArEOZMTk3wYLMSzpfMiktQl?=
 =?us-ascii?Q?Dkm4f9Pbz4RSYw6o4u4UNhtdme4mLFUXAhUHaNXmUBtyw+Y8mEsNNXL6G3Qz?=
 =?us-ascii?Q?B674nLZiEWne2QyignFB4Eix8dT/uWJfuAv6qhxuc7ujwH2Km3L2XUuUm3GF?=
 =?us-ascii?Q?lL5TyTB5ozOND6DUgFBshtSbMHNxGYrfVHpcqcO2ERtxQOxBpF6qflhULw6+?=
 =?us-ascii?Q?c28Q/SQg6g2YGwy8DsuagYCSHTLl4i8FsLfaw3UkC+MJRZ8his0f7i6+MjFz?=
 =?us-ascii?Q?Zzrucz4ZtBckl8zRZL1NOjayxNoloO97lj3wya8hlO6NG3OCFelRr/f5HSV9?=
 =?us-ascii?Q?Ss6CMT0Mms/Xs9LKDSMBcn5awVYPqqr9xr9FWel0iKILoxBoo66tcrBY+HiU?=
 =?us-ascii?Q?ydldJe40sVJzWw1NEdhTmTlpoDP19ahhbqE5GYILzZ4BsRK7PXmD//PNfOxe?=
 =?us-ascii?Q?p+Kofnrz65Bb7Uhgs2Ovkg1BPhfFqmzE6egmJdM/XctFDP+c/d6a38n3X4nQ?=
 =?us-ascii?Q?nIZ5nz+y74vTwJIH0R2Px0tlddXF1cKcjOksRDVSBOoIG5RmuB4SMcLPSfcY?=
 =?us-ascii?Q?m9oUj1YyRSSrBGrijDXvMU6nagI6NOG5ZINXmAeqfNhRrhg4LVaDAMvWfXHq?=
 =?us-ascii?Q?cY7fUG8mTkhNlp4y8kPYQKl6P4VGkTBlRsjWveNX5iAupfujK6GGFM7QjbxT?=
 =?us-ascii?Q?U8UlF1Eyh2wJ4myLUfEdQ4ckJG4loP7OwdysT+74iNSW4441EUrC9F5JfNr1?=
 =?us-ascii?Q?niu/PRyMjqM2t3cdVX7UPIlz49/6q1EwfjQwVD3EiwZmh7YcHtp2XFD7mAjh?=
 =?us-ascii?Q?6XQZZFJ51iVI5FrwvpHzkDiCtXPOrKGEIn8HuP/tSr/uzd7jXCGh05KgqCr5?=
 =?us-ascii?Q?bXpBvHfMJV0W10AcJu6tNpg2ePgXaaogtfr3evW8KhJTPe2DaCDeGK7cTHDl?=
 =?us-ascii?Q?znYRQmgt0qg2kJggSukcrNVdz9bKyjdmuu5HIAs0JEeXI9dR+x7Nae9EIcfq?=
 =?us-ascii?Q?NRRqYKqXk5O5DyGJ5LGvCjCXtQOC7HyiLsDqjeY1wj7BCMJ7LRsYVx8kbcdN?=
 =?us-ascii?Q?Qh0VPwFVxW/spq3Yr2ih8fMU+fFd7wOqaCBci5nhQQa5PFabX2+THQkB53ft?=
 =?us-ascii?Q?7u57cKhC1XQpe5l/gQHt4x4CVBM7uhq6wPxV+H9xsIJJ5mcA4icYtY6mcZaW?=
 =?us-ascii?Q?JCvIgdJscwRLk8+K26C0Fg+/joADrLshIPWlyVhHtBE/DeDHCpvW1Vh287wp?=
 =?us-ascii?Q?0iFJXCkFOO1n/RIOm+pbcVgtqItl3O+7w0kuQrUoaaJTAX4s4t8a/KpqIpXV?=
 =?us-ascii?Q?1yGnUubTmQvqeSHxfU9OBl7oHkh1FXdKbIBQQxXFyrPAfQap?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e8366e-b3e4-4918-6fc2-08deea58ef34
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 14:28:02.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/lQUllOFB8R7v6GqmwNJp1xwDog6n6N7vf7pu7fh0JreO/MjeUF7ZuL3FAXG12u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073

On Thu, Jul 23, 2026 at 03:19:44PM +0100, Robin Murphy wrote:
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -102,6 +102,8 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
>  			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
>  		if (master->smmu->features & ARM_SMMU_FEAT_HD)
>  			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
> +		if (master->smmu->features & ARM_SMMU_FEAT_HAFT && system_supports_haft())
> +			target->data[1] |= cpu_to_le64(CTXDESC_CD_1_HAFT);
>  	} else {
>  		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_EPD0);

Based on the Sashiko remark and your note you should lift all the
HA/HD/HAFT bits outside this if (mm) block.

AFAICT it is fine for HA/HD/HAFT to be set with EPD0, the HW won't
process any PTEs so they won't have any effect.

Since this avoids the BAD_CD inconsistency you pointed at and also avoids
changing word 1 it should avoid the problematic V=0 transition.

Jason

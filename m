Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04E31534E9
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084871; cv=fail; b=vFbMzk7X9F7d6CMEhGU0wAQXkY5bI395i3nEeYet/s85MtbPpafMZIU5M1Ta16xg9mr0tzin35IH0n4xYB6uOD1oBOyvW/d8wRvl1sPeVPE3nU91ZoEzHKQFkyWDWp95YuLiDw3Bqcuehtxev0VMr2dNeby8CAKrlMGIEVzzMc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084871; c=relaxed/simple;
	bh=0p67fuAtVtz2X9vsSrS2/sIW5qHl74+l9BkAv86zfGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QfHEpRjJhkG7xVH14MQkuAxLrvnKJVl+ORNSra90F9qv+wNlzF6YWZUOIdiVTR//lTQFMXnPDoObN9qG/B3mGZIDG++rzrgL/5rJmQ9imPBu5ytXQ3rpRW9Z0tPrCzDjhA7syVhgRjDX4XN8M9fIC2KVr6RKVMZdVm97VJMOInY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nyIG2n/M; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nyIG2n/M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXGLLJYxFRbwUqAAWMCE8vHe8WM0QQE7IO1UacxnEUfrmbvgq3qiFBJbgza7ZgckpLCIrGby4ARptYweLEKEZO10S3vdEFRaygdY//BjYdb83mWKtKOeN108Yq+SQQo/ojyunr59FmcsS3sdsYxNBH0eSFKpI6B0CLg9St1qJ4Wn9nXb32emvAvl2uNB+QLgPNZvIVMEE5ZROw5Mu5/1NBpiqqI7j2blHYIqcV3rR+Lc2c8+Dw3T2UYX4ErXYqK6VyvKOcG6LXDbdJ44DF8vrzOdsLX66snmYd+Ka6Yxacy90DJwnSM7VEPGTbY3RqLAtxjSTPmxin0s7V2lcbklww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSrnQZY3L1ADJOZq8Y+hqwbiSAYRsRCg6qWUaIj2AXA=;
 b=BzmV7athCXqyI67LiElOuW+/9DjvUmM0erW8EVtl1cRULgpB/Z9saXbZgR2EzjCugc3SX8e37hEiZVjVwNzPkXytNgXL0HY2utaqFjIizNkyLg0iSbZveSBYvIKOTcbwf7LM6O0S+lSiR/F36Zh/tsnS3hmfEx+Yj2KJbUPG+bpQ6vcj1gt2YIPz0qtI0Gy496dr52ST4LztRESp753eOjrRprAZzcsksd84TUJWycaATq+aKcBVRw59zkFyvL/SUp/k3OC+mNALsZ26vnZt7HBRgnQSeXF5QLkAYAjZSXB7UAhs/z90R9pq0GnwUr41fOBbSC69rF4sOnAalYWX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSrnQZY3L1ADJOZq8Y+hqwbiSAYRsRCg6qWUaIj2AXA=;
 b=nyIG2n/MYMAXzRwBE2jIiI2Kz+JUrX8dhyEmD3rTYZ7NbImiUOYsvbF0Cg9wKkkZXRsMN8BPW6aVP7QO0U2h+T0RckQS0URPuD5KacCv6K4xEMHW3eM6g4ILDhfTS+TwQzaEQ52bF1OllVbuY0UG+uwJxBmMMnhpHs9SR/xF7HlYBf9ZtzI/elPh6L11534LCpY2SH1OdZgpnQ8i3GC93s7vtDxVxDt9bEOalc1/dovn02LYdk1Qah/PuucA9ltsIZq2mG6j2Ct0jK4UbSUh1WI48h7ncE7Wu7l8G/dKLVu5bjQCx1WJSd/KLGAswyg4FXKL+IcwXV6JVFXYAOQ3gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 13:21:05 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 13:21:05 +0000
Date: Wed, 16 Oct 2024 10:21:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v6 4/9] iommu/amd: Introduce per-device DTE cache to
 store persistent bits
Message-ID: <20241016132104.GK3559746@nvidia.com>
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
 <20241016051756.4317-5-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016051756.4317-5-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN1PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:408:e2::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: acbd2bb4-e465-42c8-38cc-08dcede56399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a2cY9QaCiHs+/bG1AnWkkwtu5Q4nSvTCvlUTbtvawsSHssH1i2MJkq8Clnh/?=
 =?us-ascii?Q?nbXmZ9gWDO4tZk5dp9MbP4np4Bs1VYkotgFu5dXss4ts/eY6eHiYcoEZmpJH?=
 =?us-ascii?Q?HPTakNgISq/L9Db6NGGXPHY1BuHXwO9wMzcbwkPVrSIl1KV+0tdW0o3Aci1s?=
 =?us-ascii?Q?n9ap4dCCwlHbExlrn1BfFJAZEF9U0EHNtpRpVSNMfs04dWcz3cTgH+n3OnQS?=
 =?us-ascii?Q?qFWvq8IQRcSmvknoGSTMVpsDzstuFgpsRxWV2F91w2A1u644/RtSW/Imp8za?=
 =?us-ascii?Q?uWK+HbKtKCJdbyZyHqC2xIKMqots5uuDtKToJawe/a8dVJyZSZvIRqP0oWGD?=
 =?us-ascii?Q?bQzV3CfDRQ693n1wV0xr8odTcqvYaaz93w7ulHM5hRpUAfjGfJACswM+XB9S?=
 =?us-ascii?Q?C7l10iDDru5oiGoXm3gwGuN1RPZiALUU7rJZ6tgcBYto5e/qIuLS6zwi3ZFe?=
 =?us-ascii?Q?N3FGaW+1CAk6/9fANQnzKpbCoJmBUJUBvHOmM6vvsDQ/ya9+ZCVPKIpqJ0gN?=
 =?us-ascii?Q?aEBJFljdTodQ8awYoqRAvr3/S7xJvwsYQVVAT36BxrZ2wJ8/pNxCW2EZR+15?=
 =?us-ascii?Q?+BDXrEZznZ8gTzJn4KLxHDWYkwwRuwPjeNy8MLcgRKfvwU6oFHSiCbkOTxJ1?=
 =?us-ascii?Q?rJaShnb8xEKSqkX+n+RHKzRwTREFR5XhvTBgkj39xvtzu2Q0LBNx3YGBlAZv?=
 =?us-ascii?Q?WlbkcSHiY6f7HHDMtt4zN3RybE1tD0cESYBhp6bNxOMfF/ecdczSNBqD8NRr?=
 =?us-ascii?Q?Bj1I+JbJAKrYk2D8o9UTDLpitGY/fc4923jDFBJz1/6j0GRqr3ADKAhUKoYo?=
 =?us-ascii?Q?I2UVLG2RwUCtyprW/S8V2j/zn8cotA6IBLJmM5LbcP8fygMTAz2adqujMO5p?=
 =?us-ascii?Q?3UDHEI+O2CxqQg9fl2TZrQSWffSz3oauliRx4ni5TmDIZyuVVmLqMck8waxU?=
 =?us-ascii?Q?1wDw2Q+Z+3BXLIdnAwSmiBNtKlGcPwLOCJ+6ZGafdKjafVoSsbG5u/B6kzkd?=
 =?us-ascii?Q?rmITl8CoXKuKO2QtuG8VdcHK5Gn3UK8wNNauwHNg7ptooIUVmXxnm2h3Kxke?=
 =?us-ascii?Q?qC7Ku/LNqIqsie+2GBabjNwwInnmdcxRtrF938B6XxvEkc62E1MV7U2vd9b3?=
 =?us-ascii?Q?4kpQPZFO2Uj4ztXTJJwNOvL22uEyWGrlt8KhQgzCOJGwCrX7cfxg+F5WjBzI?=
 =?us-ascii?Q?lVX32BjvE8kaAVVn3hTyG8tjeHdhhUTY/Qth5xiT8dZSt2cU7JV15ZFLxPD6?=
 =?us-ascii?Q?HUTWCEp8mmfRJah5BrTWw3m9r80Ouc5vflwQik163g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OqxAbDILu+K1CxabLYMPHi2AeVR08yprjiqAVoSHCQ4pMTGRk+y9rwxRMBDN?=
 =?us-ascii?Q?HizAqUsoea5439AWD4IY9W1nu+yr5G2vpDGh1lFVJhISjg6+1Io8Pxek15eG?=
 =?us-ascii?Q?CWGMVFKyJwMXpDTp1lufXIT4CZmQTUZi9kNb3Q408BfKl5c1400pDtpz5nYV?=
 =?us-ascii?Q?cJyo3nFojMe8762aNAtq0jZxpTjh6cikqgdCaX551ChQ951EtVFgDmUyyJr3?=
 =?us-ascii?Q?btKp+2UDjc9Tw4LG/ccjF4vt0UnIodIgXCHfAgn7KFNzrGsOt/IpP7oY8x3Y?=
 =?us-ascii?Q?dW1FNWmH129EdfAd+2f07LfhQTRtmge+Bq5ObubP8E14ZkO/D3c5I/tSHMcq?=
 =?us-ascii?Q?Q8K/KFOodZiqF4wrLp7odRK3AWi39ila1dsDQTHC1b9ChHpKP8OBZujsEeim?=
 =?us-ascii?Q?hZBcakZ30UOOfMosD3RTjDH+0rrFF02VTAqsKmZ0WhpvxrFfgbnJW2E3YWdN?=
 =?us-ascii?Q?z+ehb0BHnKpe1qd1GSfqrgPOve1EioPSP0zpfVgThGXdQWbtDMN4R4mfflEt?=
 =?us-ascii?Q?RCUWnf5thNJi2iSIDhWjCW9fvp3UcPAxELKAea7o0ZrR6Xu/fvqqHHvSQ8zr?=
 =?us-ascii?Q?He66R2HuqGTDL1Mt7eRw4aSGH1L8KMyEx6c5t2o5eDF0V6Y16oX4v/c4vUcv?=
 =?us-ascii?Q?0hZ6MeexOoCkTTlOI+8bRm+j8Rtk22YZrPnVJFjGxuM6Jj/5W8FniEOBJLCb?=
 =?us-ascii?Q?0MI5Z9lTASgbJ2aw82YuVsqztN460Vsfwm78YsShG8f9jToEP3tPg4ka3qde?=
 =?us-ascii?Q?YyRvWu4O1+jLdPve97E02R5Et6LIPG5Lr12Pofc3xYB8Rd4/mhtsxs4NfMBl?=
 =?us-ascii?Q?lHEzlE3sEcyGFXddyBujg0RM2tsRGtBp7ypWuV/l8U0Ck6p/ZM/EysLlWxGd?=
 =?us-ascii?Q?4JdTsV7y69DnnhNJPxEKnxYlCHC5cafrQgjsvQbauz5vS7fW2NfWiAJX5pIy?=
 =?us-ascii?Q?Z/+zedEq2FohtlTRbZVGaaplYRYwczvVsq7UxXlyW8y3mF0QI5br659veZXM?=
 =?us-ascii?Q?De6VFXcJRotVJZxzZJEkoCs+wjwbWkPp8B/PfwXKbZNTBzWoUoPpfOOB/KD8?=
 =?us-ascii?Q?jaHcf5bBMbJ0TIUUAWYutFqAWGfdPNtGE1ie1pyF09HzgX8TBd7+HEqZY1ST?=
 =?us-ascii?Q?A49C12/h7o7l5gdjuFfrTyQHiBqXoJS0ei2wglWGeCUEGJJCPncF2fqZy/Ae?=
 =?us-ascii?Q?AqVC9fsV0xsCA9xSQlhzjprCDmQeD4U5dtLCwDJ2E69yIPgMFdX/RpXErrmL?=
 =?us-ascii?Q?gh4thGSOjnWk6X7S/jDJugOqByco4AYkZ8wCQpvG0EVuZC88dLPR8Xi77n2p?=
 =?us-ascii?Q?Om+yh9JKj5o4LwVk/IMzDzZ0aWO+/diYWufPBWxmiAXgUe2+zNIxAx3rKq9g?=
 =?us-ascii?Q?uMH8sVMbtjeI8BH6xNkiqj3NlEIZ03Qip1iAjsAHvfpZGm2AwWNIo0QyjHrL?=
 =?us-ascii?Q?169W9ufn2HBX9a2icAMz9kF78qIimYqoNihQKG4AYpNeHwI4nNQCN4X0dDXx?=
 =?us-ascii?Q?wtj0brKIKdgQIpRZ0g0ckRx0zwuX2rEp+5TS+ZpsDOo9jwTXVkyjxWoCf2xz?=
 =?us-ascii?Q?ky5gk4nxpG3brKYN7MI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbd2bb4-e465-42c8-38cc-08dcede56399
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 13:21:05.6067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bga5RLaVnPuZWWJ00BN0VWbqBzZrGboEMiSIid5CREmAU+PBgMedPSXspCG6U7rG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676

On Wed, Oct 16, 2024 at 05:17:51AM +0000, Suravee Suthikulpanit wrote:
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index f537b264f118..3f53d3bc79cb 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -830,6 +830,16 @@ struct devid_map {
>  /* Device may request super-user privileges */
>  #define AMD_IOMMU_DEVICE_FLAG_PRIV_SUP   0x10
>  
> +/*
> + * Structure defining one entry in the device table
> + */
> +struct dev_table_entry {
> +	union {
> +		u64 data[4];
> +		u128 data128[2];
> +	};
> +};

It would be appropriate to put this hunk into the prior patch so your
series does not move code it just added..

>  /*
>   * This struct contains device specific data for the IOMMU
>   */
> @@ -858,6 +868,7 @@ struct iommu_dev_data {
>  	bool defer_attach;
>  
>  	struct ratelimit_state rs;        /* Ratelimit IOPF messages */
> +	struct dev_table_entry dte_cache;
>  };

I would call this initial_dte or something, it isn't a cache, it is
the recoding of the ACPI data into a DTE format.

 /* Stores INIT/EINT,NMIm SYSMGTx,LINTx values from ACPI */
 struct dev_tabl_entry initial_dte;

> @@ -1159,19 +1171,19 @@ static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
>  					   u16 devid, u32 flags, u32 ext_flags)
>  {
>  	if (flags & ACPI_DEVFLAG_INITPASS)
> -		set_dev_entry_bit(iommu, devid, DEV_ENTRY_INIT_PASS);
> +		set_dte_cache_bit(iommu, devid, DEV_ENTRY_INIT_PASS);
>  	if (flags & ACPI_DEVFLAG_EXTINT)
> -		set_dev_entry_bit(iommu, devid, DEV_ENTRY_EINT_PASS);
> +		set_dte_cache_bit(iommu, devid, DEV_ENTRY_EINT_PASS);
>  	if (flags & ACPI_DEVFLAG_NMI)
> -		set_dev_entry_bit(iommu, devid, DEV_ENTRY_NMI_PASS);
> +		set_dte_cache_bit(iommu, devid, DEV_ENTRY_NMI_PASS);
>  	if (flags & ACPI_DEVFLAG_SYSMGT1)
> -		set_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT1);
> +		set_dte_cache_bit(iommu, devid, DEV_ENTRY_SYSMGT1);
>  	if (flags & ACPI_DEVFLAG_SYSMGT2)
> -		set_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT2);
> +		set_dte_cache_bit(iommu, devid, DEV_ENTRY_SYSMGT2);
>  	if (flags & ACPI_DEVFLAG_LINT0)
> -		set_dev_entry_bit(iommu, devid, DEV_ENTRY_LINT0_PASS);
> +		set_dte_cache_bit(iommu, devid, DEV_ENTRY_LINT0_PASS);
>  	if (flags & ACPI_DEVFLAG_LINT1)
> -		set_dev_entry_bit(iommu, devid, DEV_ENTRY_LINT1_PASS);
> +		set_dte_cache_bit(iommu, devid, DEV_ENTRY_LINT1_PASS);

Doesn't this break the driver at this patch? Nothing reads from the
dte_cache at this point in the series so the real DTE never got these
bits?

Maybe just add a temporary line here to copy the entire dte_cache to
the real dte? The next patch fixes it I think?

But I like the idea, I think this is the a much more understandable
direction to go.

Jason

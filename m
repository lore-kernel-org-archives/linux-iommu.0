Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDEB20D4FE
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301516; cv=fail; b=HA9F1DaHhyxluTXAogh/tpN6rEbeVTUYvhbf5PR6Um0dQW0sUljuGdUitei/NzbxZN5/QadtTHpajG5a5yed+8FB2ec6TxjqOV0bslMLWZ7EjisFaAdm6GfWj2+nAfQw6yd8YHHVt+ToS35gCG8I1GWfs9vKaOiqoy8GwdKgED4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301516; c=relaxed/simple;
	bh=skVWg5jya7vyf2/mfifwpFFPi4WrW0AjL28H0vIWL7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j5NGLhEhD294LXaac0aWJ/hT7vq/7ZtQCQwwFx5DYL+fvVOt6JWU3osHE+ote0Z6BzlpxQdPswfGga1m5rQimyGmaZzUjFVoaRIANwkV91iVrgaMWmXiAKxiCbEPsL1Y6fd3wSA9tj/TwYJB8186/lYjqR9X5zwpfVj8abl5Dmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GO04SvwH; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GO04SvwH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2R6Bly5yDkecWjYPCAl6YJvvM0bUCBzGhjvvwJZtVT3+JaZgyb1wAqThPH0ROkDR1h7la/qnH0iVqH2w2L8HtKaLJVqMrh6LxXj/qEcZVeFW8bL9WxXFp4uno/28fgI8/DKuOgTw6w1yv5DvJCJYbFmQSMzuy8OU4IvroCPt4gmQWCC1lVOmR3QpywubP3zROqJXvJbqH4XFYhiWa1w7twQyR4Crz8CwoYqEPBAN2axWgg+9/Izt3Ha03P87LvuZu4Xg4MwdCEMTTe7n6DcmKao8nHp2GZgVsYpY8ZKmB//gLWD6tJBMgZAhGYd917VywzqngiJh78kyIblFdV+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udJrA/IHuCTdA5Qkje35eTtA9pOy3FsPVrz3jOVVGk8=;
 b=W9xyFZMzCsBwzl0s3Ven/BpU/PFQNTCZz0plGdSCQIK09LeW0dF9OLENwkHPh9Z4pp5C56TkPD42T2ZX/Hra5PIlG9/XlmB0w3TWk/eCVHVcR43FGzDaDJXM7Vshh8M87fmCLL9LfSzxEi+RCK+BPS1X5Ky3QIiS+Ctc0qLgcQ+erqDR+Z0PiOAYE26lcRBYEFLkil4+l+xBDUvPvHqGYijScOq421qYlr5KcGalFu+6E1PeSP8H/MqsLTo91pUcwbLBNIPSTMMuArriHg95hXHR6h4Bt957YTWDSl3YgFgrZ9i3LZB5tzFNQs6A2EPry5cL6BiZlGPg0gFv0MK6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udJrA/IHuCTdA5Qkje35eTtA9pOy3FsPVrz3jOVVGk8=;
 b=GO04SvwHpwKseS1P8mHaD43g5R9Jv51FNXVPikdsFYnBcshs3Zhj5dKvbaGy81rGbFaKNS6ZGk2V66J4L6NSTSIsFj22e8eJu+xjQC294BV6BMj9hmSWqhA9f0Uz1reu0LuFMPJ4kD4Pr+CtY4Yi9fWFkCeDdzfAbvkm/ftTt4nZhnabrxv1TGbiSfJZlzf/wpDkm0WrXEn4Z77RKarHlB3VhAvOPWsgrgUAzcqgU93ixAFSwBgfOMZ53eHBqXeSRLljOAr7bVnW7gwDgJIi64Bl1AB02v/eGG1XmdMZ90WI2XUfbY53RXYXlQQxvhaWZijMfkGa+OeLxv2uVEfLAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:38:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 12:38:28 +0000
Date: Tue, 18 Mar 2025 09:38:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v9 15/21] iommufd: Enforce PASID-compatible domain for RID
Message-ID: <20250318123827.GL9311@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-16-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313123532.103522-16-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR19CA0045.namprd19.prod.outlook.com
 (2603:10b6:208:19b::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: c2bc2ba1-d923-4910-4577-08dd6619c87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dgoZAXyE4gIyfUg6MzFjbozAg1sT9oZV8vEyHYV9EVW7z139L/7IfVXm98Xp?=
 =?us-ascii?Q?MzCCvvJQInKX0yC9rH1oxsYLO6LOXSDvp/lWzC/BSrbBYS1yDLNBodstQEDK?=
 =?us-ascii?Q?9/2Ahl2XJ3z7qjvCnsDC1V4gkBqerXfpXCZ9hrjj2LBZTEST22XwN4Mv2vqN?=
 =?us-ascii?Q?8Yz2X8ppfb9RBMXI5Ps4yADTbGFFXkUUmOKnI2rlQl0OMEpe9F3kvih72iKW?=
 =?us-ascii?Q?hYkbX9MFTD0aWIPBXf4m4cBbzAD8TcbZNe2v2n6YKXHHCROajoeVlBGRjBry?=
 =?us-ascii?Q?eC6wtHHJ4SgUj4NpgDSgU/Dgtr2grARmKrIyZ61t1p7nyCFXZmRY8g2jkTIt?=
 =?us-ascii?Q?7z3m2hGK1awI9bQJ7NUKqu/fyqTQmc4YKmpwGCcJ/g3V/Ni/JuPA4e6hRihF?=
 =?us-ascii?Q?sBzGXFDYCRsePvGf3EqaYWipodxj7L7xbA7MELRgFMFjAJEUUNDSunmwoE0/?=
 =?us-ascii?Q?0cgf/YGUka/38StOnpAS826XPC+LDuSeJdCfdOm/1aDQhcBeZmNBgiL9A0Sw?=
 =?us-ascii?Q?6FJaYYmaH24+MQIW1DdFnoOouppNxqPhL0QcQ7opkyaZkFfmGupuYT7nokZ1?=
 =?us-ascii?Q?U5nBUDcLIADYAQLaCvK5a+cNC9EeGlHE94PVve8HlnIc396ljpne5Qe4Ui2m?=
 =?us-ascii?Q?FIiYxHEkG1LxGBjn6CA/0eIAlU+PNH+NJlwb2hZ+vZAWM6oRsMydIBySQ5Wy?=
 =?us-ascii?Q?hPk3ILIFoKN6VPx1bZQ22Vgtxd7JtV2lBQGamAQWeWEfZN3Ucbw1LIjhMOcc?=
 =?us-ascii?Q?QgSjQjz+r2gFZejnezcQ/2MdeRSOqGHg9xtwQr06PMPCcvC19+UhgaogEOI/?=
 =?us-ascii?Q?9gDwfw3NTPXsrm7rmnvsD4hh9Jfa52R0hm+Wv0Ty93hyQgWR+dC9emKuASi6?=
 =?us-ascii?Q?3tsH6G+4gK65KJqOa3uZ5Wry11aX5GZfSakF/1IpY/ielFWsQ6iUjbfbdTis?=
 =?us-ascii?Q?DeGO2Flx4orzbaalQzO7loL1gISRX0J5TSMIdy1IqDX+cHnW1K5JVuoRiuuF?=
 =?us-ascii?Q?QsqH7CGhDnS6mRFybGusA/emtDTcl119KurEL3eyVDYmg+LHfqcd5cpLq2GM?=
 =?us-ascii?Q?mpfzb/ePftQs9/CysHwo68wXzfPkEpWL/51sJNlL+MOVzgsiQo/3CdmBRiya?=
 =?us-ascii?Q?8O5LNO9BYAdY5zOGI6Vwrovjan7c6qUWS0DB+6a7o+4CvP745WEhu7he7/XX?=
 =?us-ascii?Q?KDyAZxR399I+fNgUVHXl0S2Sho5RVxtcXCHZyk/l1JqfG9diteMJ9IGGNWJr?=
 =?us-ascii?Q?VLp6XKxnn8JOaD3pKoBvmBPWbL2/mfGfQLtc4Lw+nrzH7bKbu9w9aWMs06p7?=
 =?us-ascii?Q?VPWfKSoTF9ow+FrYT9dPv9x81Cvs6wKY2aFnl0iR4wOavjBYORWxzr7cIBWa?=
 =?us-ascii?Q?lqlPF1Ty11/4eAEbPbPqy5Q6O3N7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O15aQp8RIETfFOgPPJqQhKiyLmgkSCN7y+ngzuXHOWMyhvt6OO1iXPGbGrKz?=
 =?us-ascii?Q?3R+rbpn8i00F3T5srQl3GB7SD+22hgyvw8G/9xl+4a56CJWJpszGQuQH8ef9?=
 =?us-ascii?Q?ceFvEq5dcfIlvsBXigDsHtbr1kbQMbZE0/koZT+nV1oPuvbaXOPCSnQ0Zavg?=
 =?us-ascii?Q?ujiTbkFIUf92kSp2hjZ4nCdqZpaMnrUgjaMyq/VPzGcmOQnK2Nifzae90uch?=
 =?us-ascii?Q?0dvNtt7mWxPOQcNcVskxElg/BSVwIFBN4/ZwU44N9svMHhouiL1WV2XewBt5?=
 =?us-ascii?Q?qHlotoukXiCvvpAkIjBF88oI8G77L7y7aeqw8KETpOPQ5r9W0e0e6k9NKW78?=
 =?us-ascii?Q?2WFZ9kLOiTKXup00SKJ4Jz0BBG1T9SZDndBFjokx4S7YBEHkWXetyNKXKlBp?=
 =?us-ascii?Q?TDIRNPtz61f49jhWZ7xfseR0EAZVlM22CB6UuL3AbM/OcRMw0AdfjtoYaSqw?=
 =?us-ascii?Q?8nfX1khlXYNnU31t0yzEoELh1ywaicYgw2/Cd4VpjiC2KDe2rGK83ISTpPBs?=
 =?us-ascii?Q?hlUWLQFh5jfk7891bpm0yU7gbJ4ynnRCsKqZ9p115qVvi08U1Mjuu1/XEEf5?=
 =?us-ascii?Q?Ogb7cCKyI4rPBdHoPnDLIJi0lHVR/Ei0r2Ns96K0O/rNFReh1myc6Fq5EuH0?=
 =?us-ascii?Q?Gy/mhFGtgFVmbOLDeYl3MIbP41TXmylM5Yt4c5Wz2nyD4cNviwK0/9Xh8+BY?=
 =?us-ascii?Q?Z892auUg5laJmkCvEnNUsc1e4KlsL+cWXOYs+vuoxRc8WRuj0aHMnrx5J9w7?=
 =?us-ascii?Q?5J03IdtheRid/J8wakp+0KIkmhKfIbu1H2TsCOYOir3fcy5USNKUV7/lbULX?=
 =?us-ascii?Q?z3m2FcEtV+5XGKC/ZOhtcy+MO/GuySw05f3RpepY9g2dtc6knK+aFYqDyFZU?=
 =?us-ascii?Q?HiBERZoTXnvcRQLqfhwHaLp01E7pkNHZiY8u9FxIINN6bhKaWzQOU18gTIbA?=
 =?us-ascii?Q?3W83FNKm2+myQxdH0/0h2H823pkvekMASFavALzZqm42mEL1Yvmt2Q7ApItt?=
 =?us-ascii?Q?3pxDWT+5wGteNDISp26aQdeCbPqifiC0YJ69UvunZ2wb3j1AUaY2tg7w6h6S?=
 =?us-ascii?Q?s68lKleN3dig/sj8UwIetpjPwGNLapri5UfQLGLc5UTumADGz31WK9lX4ATd?=
 =?us-ascii?Q?X6tmdMsr+5pk/rNci+UEn1mTk/AyllGLzd6ajWnXs1lV2a0mFzjZ4lpu2143?=
 =?us-ascii?Q?dAwrD+hMOOw90oID2HPIc3vsB4d8KYSKrP9WoI3pCrVlQPq15lmoOuVPQUat?=
 =?us-ascii?Q?SGRoot0f1/Cjq1gnZXiKeUskSRnqzaGD7gnhSBWFV3YouNfO+5R3dK2bL9f9?=
 =?us-ascii?Q?V7VrBQOPlT+eJrR2vx+yTWu5O/DL7qSDDZfLb6FGW/nzUJTHL0O3LNUvWhN/?=
 =?us-ascii?Q?aZ94vBzbzZj3cr567k4C1n3I1b868k51KgOl+734H1phspV56IxXWEP0Zpcv?=
 =?us-ascii?Q?J4C2tdeXgmH3OvpWOvORp8AIj8KOmcOwZTVMfW8cTzU2o4d2CtxuZ7H83rY2?=
 =?us-ascii?Q?QUKqFmJwYlqt/l//qHjmZupbptBVwnrWZYfgKTnBVJyVbwr0gStxJnGEpaiL?=
 =?us-ascii?Q?Oz0yZ/aEpUCr9zZdxRUcGgcoragAQjNXP/PHvwzN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bc2ba1-d923-4910-4577-08dd6619c87b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 12:38:28.1957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+DfYnhR0BsV5gpbpPV08CE/CIY1qhalc9vwCf+tUlsoqS87IyzW7VNoL3vbtQpK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829

On Thu, Mar 13, 2025 at 05:35:26AM -0700, Yi Liu wrote:
> Per the definition of IOMMU_HWPT_ALLOC_PASID, iommufd needs to enforce
> the RID to use PASID-compatible domain if PASID has been attached, and
> vice versa. The PASID path has already enforced it. This adds the
> enforcement in the RID path.
> 
> This enforcement requires a lock across the RID and PASID attach path,
> the idev->igroup->lock is used as both the RID and the PASID path holds
> it.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
> v8 -> v9: iommufd_hwpt_pasid_compat() is moved to prior patch
> 	  I didn't include r-b from Kevin and Jason as this patch has
> 	  quite a few change compared with v8. It's mainly due to the
> 	  introduction of pasid_attach for both RID and PASID path.
> ---
>  drivers/iommu/iommufd/device.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index bceaee7376c2..5db6dc705d44 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -503,8 +503,29 @@ static int iommufd_hwpt_pasid_compat(struct iommufd_hw_pagetable *hwpt,
>  				     struct iommufd_device *idev,
>  				     ioasid_t pasid)
>  {
> -	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
> -		return -EINVAL;
> +	struct iommufd_group *igroup = idev->igroup;
> +
> +	lockdep_assert_held(&igroup->lock);
> +
> +	if (pasid == IOMMU_NO_PASID) {
> +		unsigned long start = IOMMU_NO_PASID;
> +
> +		if (!hwpt->pasid_compat &&
> +		    xa_find_after(&igroup->pasid_attach,
> +				  &start, UINT_MAX, XA_PRESENT))
> +			return -EINVAL;
> +	}
> +
> +	if (pasid != IOMMU_NO_PASID) {

just use else

> +		struct iommufd_attach_handle *handle;
> +
> +		handle = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
> +
> +		if (!hwpt->pasid_compat ||

I probably wouldn't put the hwpt test inside this if statement. The
hwpt test is always needed, this if statement is about checking if the
RID is compatible.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

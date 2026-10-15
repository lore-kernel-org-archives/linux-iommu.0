Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013033.outbound.protection.outlook.com [40.93.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCB137A834
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107600; cv=fail; b=HxfVZJSYlgRZERSuml9kCrCoxCd0g4x4IkJTjlvmJK8vX+nUgbpR2K1tGQa7Wxfo2bQgtO7Ve1SHMnYdeiGlxjc1BWw45dMpuUXIHf5zN+lJHlC9rva6eu34vyuYDyC1mIHpD1RpyxVigx0RsDKUob8pJITg05HHRHj31wwKDpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107600; c=relaxed/simple;
	bh=SvNN90dDkfS8PBQQHylUtt8A0QOpneFMHJNoTkxJ9E0=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=nqukPAtVFSUDIIVxqukEIk7bh4VHEWu9Lw/k/warmJruXzUSl4P7jTgVk6bgSczAm5f1Ro/jXQwnbSFDohpGEufmG3n1skl5L0jL6JdBlq/LBeSaDR0XXK+2AhPlrHk1OQ6Nz/TOKiQpbcZPNH9MBuFwPPmtcjBrbVoC93kLDXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f42e7ub+; arc=fail smtp.client-ip=40.93.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f42e7ub+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avsA17UV31D/ghSmNVhmQs+/KcHcHsHKbbmqojE+LWc8eh3rr/U+poHpCJ5L8vVBQjW+lIP4KIzsy6WyBEvzCvQD2XtFyp6NDo+9vmk45sTiyrIZgE4PFYCy5QOeARN1Wym5BbYWBohbMf2RTRvQopD+SxN3aIdBJ7jhRv3h1FwosuDmexOzJ+QxEe9+63KaBrSIkGiwVMGLCm9vywagdm6PgV22fEHblZwENOBhF4UidccKrkJIouX7PkXvqy/PLEplHxaTgzsiZuCf/3MFkyaOWhgTCk4WRmh2HijGZCEGlsN6oXFoEewwMLWUwzY+8iFGYcboiEtUA7w63ZWDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z4Jt/93ZoBgu0fp+cI719MlSxp/VM6/9dn3hGyfyFY=;
 b=SzE5j5a19Ps6nm6cw2EXaCH9TSVTBpkovU9e0t2GKGfJ2jPrjTRlDXY6FQYNvngT2jn83sIjxnsguQ8ZbIBTK4azYzuTbKXjQibGP1eQgMJRi/UXvbrshs1THNcOyITdwRdbSM7aIXKd9Cc4oeGIIQle3Whw3gfvehnfbxLfNXh3db+Y2gB2KCtAgQHF/vxcx1lTKaxiDGoshKT09Y/L5sN2in85SjepakH/FB6XagGwz3HWppaKN9B/B3b/sTjcmE9DcAu+mILsa7MzbitWKH6PDeS3y31DVtE6Ib8W9ITT4be5hz8oQaJ4+yNn43rZe4ei8yigX33O/2OshvE5yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z4Jt/93ZoBgu0fp+cI719MlSxp/VM6/9dn3hGyfyFY=;
 b=f42e7ub+cLXGLVnzUmi85dOV2PFwj1iWmVVtYIdGhxfun0fZOHZbg7awWHzOQlJQSGF5Q3VoGMQRHse+0t2kX/1cE6Ts2Is1iUcGvRdi5WCTr/uznJMt6LedjojdYKUr+eMY3xVUQ8r6+gXxFYZKrrTUInmbDFZnzHRRKKfp8rLrzX77I+oEj6e7y3RVOco51vVI4du+qGSPTLEDMVpzL6NWGYWfm4UPra7Pux+wqamRoG9SReN/Pyg/wK5mTGdN0NRiItGoi/+7tlFDEODUlAINSrIIZFa8UFyW2UeUZJ3iKPtIQBuWxr13zKCpfhkhctTzgmyUJ0SLz+HfpjzYPg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH9PR12MB209431.namprd12.prod.outlook.com
 (2603:10b6:610:315::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 23:39:54 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 23:39:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 18/24] iommu/amd: Init and clear vIOMMU DevID and
 DomID maps
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com, 
 nicolinc@nvidia.com, vasant.hegde@amd.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, Sairaj.K@amd.com, jay.chen@amd.com, 
 Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org, wvw@google.com, 
 wnliu@google.com, dantuluris@google.com, kpsingh@google.com, 
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com, 
 guanghuifeng@linux.alibaba.com
In-Reply-To: <20260930092344.5616-19-suravee.suthikulpanit@amd.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-19-suravee.suthikulpanit@amd.com>
Date: Thu, 15 Oct 2026 20:39:49 -0300
Message-Id: <179210758994.4133959.6615374486960504749.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BN9PR03CA0463.namprd03.prod.outlook.com
 (2603:10b6:408:139::18) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH9PR12MB209431:EE_
X-MS-Office365-Filtering-Correlation-Id: 015b51d5-e85f-400c-1d73-08df2b159ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tSvWrs/DXhlyedXU1EqB7ZNDDNGlETrIlQRRIOKWtqFvbuuVgvTWhfQp794IBXCKi545KRUur61ypTC3a8B33kKdHBnHM8+HE68CLzA4upmp5+4CFJ0KqEVrzwisWI7Y//AUj6mRrrxps1QVmRiHrr4NINqULOXvfNrsbovDe4inj8YcL8viSk9nWxbIltNAPub6GEF/OlJBT5w5jkGGf0IcX1Ph86K2IvcjiAFX9yAX20QUQxs44opCrO6bwQ2CCrz2Ni4l95c3BH0EAJS0DO88NfqjmKSLjPQtJVH70K/eK+rcmaorYXwekOykq9PLmel8VkijzftnOcD0UAcMh8GaOXx+iDyHkRunc49b0XpuxkQI6KNhm11YMbAnpj/yIA/aFRXf4rl21qwd5bRJsCzpllfcDV/rRPvpx/Ibzm6Mj+xo1l8jGbeo8qneEFgMpJrPTiV0BR9WeWnAMNdYcg3KocNMdUEni09hn6Am/T++UQNJf2cqr026W9nONrEVYqjSol0zgFlhpsGL1IW7+QRdLHuRjI2qpEechHe4TJnMZQUpDc1b38p/i0QKaQrI0BypFeHeDwQiUG8hs+BSNXH1hOHiv99TmF97U0AWmSMiTvYWM2dMTkaSkQePahybYza4XKMdVHK9p7puuSsPpCsys2BB3A47wNGzONXgxZ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFpFeGRVTHVlZmJQWGZxV3ZER0dDZ25aL2RkdkEyR1NjUzJSNmlFZXdWMkM4?=
 =?utf-8?B?NkVFbGkzRUtVcUdCS0F1WXNsMmh4aXJSRXdHajFGK3prZmZMRkpIZTJWWDU0?=
 =?utf-8?B?WjVXTktNbVRFdWNucDRZbVhQZWI5NWFGSlh0SkpleGdHV0ZpVllXWHBRY2dD?=
 =?utf-8?B?UU9hY01scmdQdHA1UWFGN1RoZjJtZ3RNVnNycHlabWNocHhUUUQ3Uk5uZW9w?=
 =?utf-8?B?enZqTlRHYzh0ZDJUREduenhRRXBDSGliU2pFV0xOR1BFZUIvZTAyd1ZWaUNz?=
 =?utf-8?B?Q1d1RzBHNXhtb1lNNVZQUjQrYnpVSEFFSHVucXFMcGhGREQzYi9LeGE2RFMy?=
 =?utf-8?B?VDYrNURQbDNqU29UdjJzb1Z1c2sreWRTektxQXFFNGFNZUFFaWhWVCt6NDBE?=
 =?utf-8?B?amJUU3k5NTRWNXkzUFBsNTcxLzZDcStBSGU1OEk5SUIzeXVkSk9iT2NXaUhM?=
 =?utf-8?B?MTN6bkFHb0MxZUExRy9OYlA1cFl6aDBUSENTVzBBZFpCMHM3clo5eHd5MCtB?=
 =?utf-8?B?bTlpdmRNV2xnZkFma1hRKzZDVjlhOGNBZjQrWHNBRkw3NzZxRit0eFdpUzB0?=
 =?utf-8?B?S213TnlaYmdJdVpCSmZrS0ptZjY1U2dtVEgzWnZTNEtQTkt4Sk05cWRRWmtK?=
 =?utf-8?B?NnhTUEV3Y1l2K1J2SklaRlFPUXU5eTY4cnJkbjR0cC9Xck1RK3RjNk5ndVdl?=
 =?utf-8?B?WXZnUVVkKy95ci8vMmszdFNzT1M4VmJpQzFXeU16RFE5QmtaYUZVNjN2aWE0?=
 =?utf-8?B?MGdJS1FLcE9RYzE0WnVwYkFWU2NRMGNadXoyNkZpQmVieW1zMzB5RDNFOUNF?=
 =?utf-8?B?TU1xZSthMlBwTS8yVVMxZE5kamNKb29nQlR1bGs1eTVEdWJJQjVxQUFoc1R4?=
 =?utf-8?B?b1ZKMkJRM0NlZkNoVWZyQjRYQXVuK3R2aVRxVm5nMFI5MUkxdFZRank4Q2h2?=
 =?utf-8?B?eVFUblB4NlUyYVVaTmFSNFNKQ0ROTWZaS1VXVHNsL1dSSU9majZuSSs1QXZK?=
 =?utf-8?B?K0loSEhTbjA3ZnJqNjM0dUhpVXgxVHJMR1J4K1FadkpwbVo1U01GYUhiSlBD?=
 =?utf-8?B?VFIzWllHU05NM3UxampyaDFHTXA5a0JTaThPcUtTTGpxZXRrcm9tS3grR0sy?=
 =?utf-8?B?SDdiTW9vL3QzRk15eTY1UEZoYTZaSDN5ZEM1cTF5eUtmQ2dOQW5rZU54T01C?=
 =?utf-8?B?OXh0UGhmQUVOb1p4REZlN0RZN0tDZy9XWkI2ME9ZS1cyWm9OODZWUGUzblFa?=
 =?utf-8?B?NitIT2hqUkhxY2pnejBEYmlFZ3k5Z2lZVGpJV25YbFhOMS9VVEZJeFF5RFNK?=
 =?utf-8?B?Q2g0anVKZzRMQUVmR3BITzBsK0JGWDlQYXlCRHpsRkp6OXVOOGtCRldZSEtM?=
 =?utf-8?B?ZEZpS3h5R2pJZmNVOWtNMndVYXFxemlMYWw2WVlXZHc5dGVIeXJieDhmVmJW?=
 =?utf-8?B?eWFjNUY4MmpsOHpTZlA5T0dncndlVmU2dldVdU1qR2xnc0o2MEttaldMR3Ux?=
 =?utf-8?B?UTJXRVl6NTVFYnZGY0dIMG9iRUhNOW1yaldqL1JqVXJRVW1pd0VZK1ZNZWpz?=
 =?utf-8?B?SG1oVjFLWFJYZG1OTktTVnNUcjlXdklBakc0OWpodlZkeTk5WlFaMVN0cXR2?=
 =?utf-8?B?WVFPbEFib1VrM3pLQ1hzU2dVQTVGTi9zQi9nVzlOblBpZUN2VFdENWg5VG1I?=
 =?utf-8?B?SWM5YkExZkVHam9SeGJkczk1NDM2VWVMVWZENDZnVGNuR010RlVHYUNKUzVL?=
 =?utf-8?B?YTRSOElLUngxWEI0R1FZOURwNStualcrbDd5WjFYY29jWHVXVzBlZXJjYndq?=
 =?utf-8?B?ejgwQVo1OWY0bElaa1UyTkw2YjRjMlZWVC9xWGJuYm54NmpIa0p4MFU3bTF0?=
 =?utf-8?B?NTYwZDk0bElGb0R1YjU1VHpWWDllbTZ1eUJDcWt2emNSdVkyQ3JqSW96eTJD?=
 =?utf-8?B?eVBtU2tjWmFZRVNnVXkvc0FuTk5tREl0Z0s2QTgwbmlQZ2g3L3Y1dWZ2RmFW?=
 =?utf-8?B?WURWSEpKSkFKQ3RTaktWS211OGZiQVc1Q0VYYkpoQlNESWMzdTdSMVFoQm9F?=
 =?utf-8?B?d1RtVnRocVF0MTRSUHZVWUthVG4ySG01bXgzR1FsY0p2SDM3YWE1aXdWNklH?=
 =?utf-8?B?WGp5TC8yZitWRFFXSVFYdC9pZWUyc25Jei9WYU93T0hDZUJMWXd6R1lhc0Ey?=
 =?utf-8?B?d3FHaXNsaW9LTXNJT0lGUE1sNmdLRW9mTmtaRlppSXp5YUM5TlYrWDRSOHJx?=
 =?utf-8?B?Sm92SkRmNTFzbGdzOU85NTRpWnpad0xrN1ZZS1NlckFMTGpWejNSc1B3VnZ1?=
 =?utf-8?Q?ESU/lo3Z4IgM1vw2j9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015b51d5-e85f-400c-1d73-08df2b159ce5
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 23:39:53.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOnAwb2SIOtw4D1bHhjdGn9BLdMzwDlR3a3KzmFVLHZqYBYv/VZO0ibVHpQDY1to
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB209431

> Before using a vIOMMU instance, prefill the mapping tables so hardware
> never sees an unknown guest ID. Map every gdom_id to the nest parent
> domain ID, and write every gdev_id with hdev_id 0. Init cannot be
> scoped to IDs in use; INVALIDATE_IOMMU_ALL walks the HW table.
> 
> Yield vfctrl_lock every 256 doorbells so the 128K MMIO loop can
> resched. Attach cannot run until viommu->ops is set after init_one().
> 
> On destroy, drain CONTROL0/CONTROL1 WRITE and unmap. Do not rewrite
> the full tables: that would start 128K DMA writes into pages about
> to be freed. vDevice destroy and nested_domain_free already restored
> idle entries.
> 
> Skip VFCTRL access when CONTROL_CMDBUF_EN is already clear, matching
> viommu_priv_unmap_free() on the same uninit_one() path.

I didn't see any explanation what happens if the guest issues an
invalidate to a gdomid without a host domid?

This is related to my questions about when the IOTLB is cleaned. Given
this patch I would expect that once the mapping is removed the hdomid
is cleaned and any invalidations for the gdomid are NOPd

If the gdomis is used again it is assigned to a clean hdomid and those
NOP'd invalidations don't matter.

Is this how it works?

I have to say the commit messages are no good in this series, do not
summarize what the patch is doing, explain why this patch is necessary
in the first place.

-- 
Jason

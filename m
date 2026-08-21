Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7BD39DBCF
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787354148; cv=fail; b=PBEWm7bPxrG3Wk8z75S2YvWU3It4ALovzemVBiJV+23z+OoZQ710bvpLUFVpXduuXrplwJVGy73Bh/FQozNZ4NPc4uddNI3s1ICTAsoqhdek4Qy7M5osMK4L7eIu45RvZTAXxTxxnpIG+HE945toVBCgB3yiGznEjt404wat95o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787354148; c=relaxed/simple;
	bh=MmxscFt2JZ9m2OyufHGfoEh0Fj1NEMdLnC6BD7NXfVU=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=NejJH9t4euzw2DKZ1+vX2KOJwmR5sbyzDuuCO9NxkUAAmelXKbK7DxTnEiyvDBiz9yo5VneGLb+nx+f+xX6iq7KGvoa65JbVxy8Ik0pH5ig3Af3r7Jc3COjQhJBeqE6lLy5tEm2UaeopK7zQRvcB2yN2GQcOVeDM/q/LXu/CAjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sb8eWxNf; arc=fail smtp.client-ip=52.101.48.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sb8eWxNf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWi/WM/482jvK+K+CcKcT/bCNfAgOT67blVuG6Wor42XMjpECu28mYQ0Gh+jaOwd1KQJGi63o+6tDeY9chqgu/JbDweNksJGG4kK7oBJJ33ruHnr+Br3SWBgqOg1vgMG85X8gcZz0EzaHyP38haL0QngxfMsMkTZKIEhmZJf2CSls4gxdsU7o1Hlqzo0fkfh3OmUhnrO/VqPYQEdy3IlCbrVw7GPMP8VFG7o4/XuG70o0hQGeydj8khLeqAH8Yh4sauxSqbfKyv5aTG/dIJ+67OG9onKxxDrb+b+SNRsNbG/xnlrC9AOgj71/T7lCOV4SRVafWuvdnVi17L8LKiQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBuWWvdo5g9mviO7Uzv0BJc3ToBbwQWXc9bpJKH5eJw=;
 b=uUdimVuV+OQbJHjrLjOQ9JjblG0I5D4UNV70XfIbZYtDWj0UpBk8y+0hla9few4puiwixwLDbmDlYxcQ3ZFbqZSXBfcbLsggS+2tQZtuSJnRzz89TNDnBG99aZtpjWsemD6P597FChydMZe/Klm/DLds4WkcuJqRZl44OrBvt2rIFf+6cEgOgImWiExoTcrHsgY21N36Uh8Hbz8m92aRIlrxPHlrS0V5aKE5tyZPuTtcBXhGcQ0DMHcpAq5Qy1tKdkT+R/aYDBUnmUcczk93HXRRlTHwZQndDtv8v2RowEFK+/DG46tY1mEbg9fbYhYgAsqe4aUzfqZCwTJSOOH2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBuWWvdo5g9mviO7Uzv0BJc3ToBbwQWXc9bpJKH5eJw=;
 b=sb8eWxNfhUxU1jQ8n0mBazV46i+xcBEXfy++1DILfiVXY2gb8gkSBEQ9sc3e64FA5PsbS8oMcqDwvjQ7PyyOSWSsXYdfLA7fvQ+YH7zNTAztIquNrFTXUoAB/o39C/TAnmjG72apWMoMsQX35faqVc123mCUnSALOwzjJbbBLJtjaL316lsUitHR6uWhVsaGz3iLLxdMgnb3YLGCJG0raQ2ZewKKNGNKy4LV7r7kmuGGxQK721OP874mZ4P6MXwcsCc5rcWWI0/yHoktson+tUqt7Jmon2/BV/dsEhNv+egnM8VH9ecLBNYJPvPtTS5rAmF6zuyVQf8x6QFOnkTV0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 23:15:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 23:15:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 07/12] iommu/arm-smmu-v3-kexec: Add ASID/VMID
 reservation helpers
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, 
 praan@google.com, kevin.tian@intel.com, smostafa@google.com, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, jamien@nvidia.com
In-Reply-To: <9f9d227c0adf472e93293008e7083973688d015e.1784663184.git.nicolinc@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
 <9f9d227c0adf472e93293008e7083973688d015e.1784663184.git.nicolinc@nvidia.com>
Date: Fri, 21 Aug 2026 20:15:26 -0300
Message-Id: <178735412602.18212.13622444378152698190.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0218.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a3e690-a304-493a-f028-08deffda1763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	NhoHV4xnVcB7hetUbl9kSUkS8ee64LTgWUEZHDT+bBRKyDn1b2UP6aE+NcTHTWSpWcQ3/OiYBD8ibhBPX5Mmr4Un9IcpSrysAS26eyCTxTq3nveO+kIZJikdvtqmFGLBIKFmM+F7zEjNl3yWQHnT0jUlFUi1Z15vDF13oWQ4O9oyjI+8Shdy8YyzOH2YvcPgPlEMGcoMMEDXfXs0ZHiZUWuLJXRvyU31ykgp87e/v/Av+cCBLfnoC3PbDPOKdvRtW32C+tRUyY9h2AHjK4DzQ+Xlm8Yl9wNORM+f8NgURT3U/O1IViMrtp0QMgphUrkxjLJAhi4UnS/Yc1tvCsZqWYnUtnUL+DAMr2hDKHuXRCzpk3brQEbiEthg5+3OXTb3IgY0WZ6Fr1kKgBAX6sQJZ8OgOkVvBM8B90vfW524v7hJOZSMUz139RMCebRI7NGGfl5USW1RsFZA2KupQyKwVbKBK2hP4QutaOUtMex7gk074YuK8mWxzyQge/kjTeplj+oOXncdy1lgLATXiWV76bbXM4cZM81eqoJTyAVTAK8KelACmscQbYGpGP+P6PA18UWhhsgWYowiL4sBHDRjkZmJrRUX9KSY92I9egdbcX8uNqT4ujYU5zIaDZHirri02UVILDEaY1SUmnxp5ztkjbZ1yehrmUYhhMXaF5tgUD4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3l6aFJYQnF6c1BwbnNVcEkxYStZQ0g1OGtjdTlLMEgzTWEvT3ZmRUVoZlV6?=
 =?utf-8?B?N0ZHZ2ZuSEthaUxJZjM5d3VzS3Rxem5Xak9QYUQ2M2ZLbk9UalI3Q0cwaVdF?=
 =?utf-8?B?ajlJUHFlbGErWldNR2dCTFlZRE9mSEsrUyswT2VyZXc0ejNIMXN5MWpXSWNU?=
 =?utf-8?B?dWtlNXlxQ2FUNTZOTkZJUW9WZ3AxREpwMHFUcXFPWHUyeklwNlNTYjdLaVcz?=
 =?utf-8?B?NUxwOGRMUkYwS2o1MSt2UkdEYUVZM2hkdHRkN21GNG8vbjFPLzRiMW9rd0x2?=
 =?utf-8?B?UjhnYUk5VXdvWTNjVTF5SVNzMjdKanZpODJ1VEpiT1lMdE5qQWdsMlU0WEZr?=
 =?utf-8?B?KzVnY3NVU3JHcXJJTDF1RThWQzhkbWNyZmxTSXF0Z2pMZkdCdlFvODJzL1Ax?=
 =?utf-8?B?ZEJaQjJMVzFXdE1mOCtTbTNvL3Q4S1NvLzZmMlhWUmRLR0VIN0w1RUt1SDNp?=
 =?utf-8?B?VDZBOEtCT0k2TmxSSGJpYVhJcUVpUHZMS21PRmY5MHlDM0QreU1JeUY3N3lC?=
 =?utf-8?B?SlRWZTJLV3d5QmwwMklZL0U5NkhkQWgrbzFDVEhmM1ZJWUh2VHNzRm5kaEw4?=
 =?utf-8?B?alNaWHc5VVkwV3ZlbUwydGVuYW9uRzc2bWdYMEI5YXVKbFFnVG81a3dGZGJ5?=
 =?utf-8?B?SlRzNnNjY0hIMTdIY0FyOC9Qb3g2RTNydjVUV2tINnRYcFh2dE9yWjJURlh6?=
 =?utf-8?B?N05hVzBmR0w4bUFQdG1FVnRqaFdiVmY0NTVTWEt6dmc3TGhVVlozSEd4T3FR?=
 =?utf-8?B?OW03QkxZallkdlBPVjFmZCtOR3V5SXlMNlllOU44ODlxY2ViTW1kaVdRbTJK?=
 =?utf-8?B?K090clVndlYyZ0kxUHE2b3JDZTdaUUcxcWpBaW1VUDQxQU5MR0xhY0t6b3Fh?=
 =?utf-8?B?bGVYS0NpQk5HWDhDd1U0NjBjbkd1Z3l4R2h6OVlKMnVINGZIdTRXM1c0VjJK?=
 =?utf-8?B?WkRhejFzOHFDUXRVemVabGNtelF3WW44N0FyRDRjM0dod3c3Y0RkVy9LMi9U?=
 =?utf-8?B?bFdsd1RPeUswVzhVK0kzbmtjRGx1U05RaEZ4RFptTG9KS2xpOG5oTEpQWTU5?=
 =?utf-8?B?MGlGZFQxN2xkanI1elMzSG9SVUF1STRjMk9xZ25lQ2FCTHdIT1NaeUZDQ0Y2?=
 =?utf-8?B?N0lSNTJiQ0ZSV0NwTTVFN2Nrc24wdHhjSFBteGRnK0VrV0VLNkcxUmtqOEx4?=
 =?utf-8?B?UUdoZTBEbm9wbHpHN1pwNStLS3FtU055YTBBQ2dZTWQyZWFpMXJxQUY3TjNy?=
 =?utf-8?B?Rk16eGtjSml3dTcwcUpjaGJ1cWFrUkE1RGlueEhpaW9NMkhoUlNmaThlcDFV?=
 =?utf-8?B?VVNjRWxIdlh3UTdzQnBtRXVra2k3QndRK3F1d3RIVGdYMERRNWUzMVRJZENF?=
 =?utf-8?B?TlJXVFg0aUEyZUoyMnJpdHhiWDByTThldUh6ZjI0K3ZLUlRRdGtTQlVvSGE4?=
 =?utf-8?B?YVFWWEhHT0ZKakF5WEs4eWRRRlN2b0dlakFVUUpzWkxMRmZjMVowK1k2NHA1?=
 =?utf-8?B?VUs3ZS9xcXRWaTFOeXY3K29MVVR5aWM0T1hkYWJ6MlNmeElqZnBhZm0xZDQr?=
 =?utf-8?B?eTJMblMwZE9oUFlxeXJuWTdQV3YwNHBXRk40NEJudG0rVUtVQTNEQ0JRRlBV?=
 =?utf-8?B?cXNiMlJzT0tNV0ZPZEh4ZDd1UVd1QVRoYUpaalVzL3Rnc0hjekxxUDNhR1E5?=
 =?utf-8?B?ZkhGcFdsTGJUQm9uL1pJd3NlRFNnUXpUaTAyY0NRTUlDUXBCR09ualZMZUZn?=
 =?utf-8?B?SkRIN0FGdDFES0k2ZzZidDhmTTlyTUhnTDNTdnp0SG9OZ1lDQ3VuZmxmNU5s?=
 =?utf-8?B?UGl6S3dHNDEzanFsVFRpY2tYcXpId2xROHhZLys3K1FrUTlqME9oaVhFT0pZ?=
 =?utf-8?B?ano4M3htYzQzZzNqeHFya1JWM3FhdVdhaGovZjN1V2QvNXMwK1ZaTFg4Z2RL?=
 =?utf-8?B?K0hXSWJUTEp3TjJwb052Q1cyYjBXMlhTM3ZVV3hkZTJ6Z0Z3d2hYTDJxa2Jv?=
 =?utf-8?B?eDkyQTZZd3VhOWh3cHRmeXJwOSs5b2U5cjNEd3kyVVpUdThlYTRVS1lGMEI1?=
 =?utf-8?B?NkFjTnpHbFB5bEFSSUNLSm1iTm9mWlRBU0sxdnd4OFIxdGw5TU5GczBGZ3Q5?=
 =?utf-8?B?dzI4OGRjMlVIa0xMdkJtanp2NUJjd2F0cHppVGY3ZzVseHM2WU9ab1EyZmJ3?=
 =?utf-8?B?c051VWFuWDl5ekIwU203cFlxOW5zekNPWE1HSUhweEUzNkh5eHlJMUVsNnNE?=
 =?utf-8?B?dnRzVmtJOCtWSC95OWdnQlEwSHB0c1dqUHpIdzkvUjROUXliRFN3UldmcmVE?=
 =?utf-8?Q?HTWzMdj8+EXPdTsC4s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a3e690-a304-493a-f028-08deffda1763
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 23:15:29.8236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZS9b/wRb/RChe+T+svHdJjH8IDMNGMkYBEQG1Bu8Y5dut9Pk1VirpnpyyreMU8n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

> +static int arm_smmu_kexec_resv_asid(struct arm_smmu_device *smmu, u32 asid)
> +{
> +	int ret;
> +
> +	/* A valid CD never has ASID 0; both kernels share the same HW limit */
> +	if (!asid || asid >= 1UL << smmu->asid_bits)
> +		return -EINVAL;
> +
> +	guard(mutex)(&arm_smmu_asid_lock);
> +
> +	/* The value entry marks the ASID as in-use and identifies its scan */
> +	ret = xa_insert(&arm_smmu_asid_xa, asid,
> +			xa_mk_value(arm_smmu_kexec_scan_id), GFP_KERNEL);
> +	/*
> +	 * An -EBUSY against a value entry safely shares a permanent reservation
> +	 * made by another scan. A pointer entry means a live domain that will
> +	 * free its ASID for reuse eventually: keep -EBUSY to fail the scan.
> +	 */
> +	if (ret == -EBUSY && xa_is_value(xa_load(&arm_smmu_asid_xa, asid)))
> +		ret = 0;

Huh. Somewhere I had a patch to make ASID per smmu instance, just like vmid.
I think you might actually need it here? Is it possible that one instance
could probe, the core code could start changing domains and end up with an
unintended ASID conflict on a later instance? Then things go sideways?

If you have that you can also drop the arm_smmu_kexec_resv_lock?

> +/**
> + * arm_smmu_kexec_unresv_ids() - Roll back a failing reservation scan
> + * @smmu: SMMU device of this kernel that failed its reservation scan

And wouldn't need this either.

Actually I think this is overkill regardless, just leave the xarray with ASIDs
reserved. Who cares?

The general logic looks otherwise OK to me

Jason

-- 
Jason

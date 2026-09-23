Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6833C2BAF
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181595; cv=fail; b=P7+bubWO6dQ2NzDQc2EsZ531wRd8LIuWBdi+ribiD2BXmcnwQrJL2kcVXu3tnHVfpHntu2S9AEp6Cv709se5Y6RmxQNnr1tajwPsYddU8qMWTgiGTGsdB8SoxidLFenlzTkZPj3HjymUX1h2F4zeB4o8/vvff4Qok/PNSLqwk4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181595; c=relaxed/simple;
	bh=xvZBo5qyLicdUYqeoYvuqRCu9dWf3kpt2D1opnsBRZg=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=DvRSZyrJkWIPoC9fbAqRYWSbMx9XB7gg0zXg3mf4oqBvpZtiaAOhIRIzyzbx6xj36hwO7DSOP91ujSp2mo3wZfnHIZVRjMXLX1iuRUGlhajVzcuhpKPxcUpc8M4rm40ZfvIwcBGhQF16G3t7uTSsmL4ptUiwgPBbVgF4nDx9C8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TtY92aPo; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TtY92aPo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYrfkLOIQ5Uc5Kc26FT5kglka6hVdecJwLGZU6XwLFZ9V3w+OMbwlKLUMuBV78q9SGrtxhfG/f3MiL3w8yv+4k2yEkzD5n/L1rlfqyO/OIXpavi71iAAj5hJI1OnRrJGV95ZD7RGuszGUJvcjJczQ8KjlC3ep1SkMN3ROKzVPUr51BGvzFlBV/N1k2/wvO4ot7wxHQ0NQAqyv6zoG0PhyFNT4LRPft+P3uBMUZ5pdBjqgXM6cI0AWb5Hhx5A/RSYcYSJ0lBXnpiGi+mcaRZzlv83BdBbhM+0myrMf/t+L5ZANmBDtBvZ4V5TWI+djHNag0H/PY3athdNlpIH0v3Czg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgrBHj0B8UruTruMk3OSWNxNEixXIH5xAGNYj74/OSs=;
 b=pxowPz3g970Mt29jTuYChjd1h3cSSZOR1LM1wYKoLHc0MRbXNp7oW2Ui+2evb25wxk8e4qiDg6vm3S/9Qhvs3DTt+oQEZsgMwnRZpyWPnLOO/Y8RUeHu4dLOn9d7HeqxSF+qdALMM/FHy5wY7J+QTuC7r8LJNzQWRCdfeK18fj3NILOk0KoBIgn8iJp3vKD2pY58t9Jfo8bcpKD6PCif2eVgM46i0MJQa6mZTe7CcNH5tbJ3uHjN++jDSM7JDOL2usUgJLhZAgxApEFqdsqfezipAkleJpYOkzXrmCPao+wYKpdHSBYndKN+qaBlrkdt0Zs/eQ6IbnctqC4r27fDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgrBHj0B8UruTruMk3OSWNxNEixXIH5xAGNYj74/OSs=;
 b=TtY92aPojwKAcydAB0EIEay4YbluTqPsUzo2TSuWQ1aDyV2JO7cFJTNq8cxF/kcci5jxgl7wQSyLKZwGyOEopRoOOFSIojg63ih+gsgYTYuHs/1TuSa57vH319lIzGkt0y0ypIsJuPKX6dTmqtKbc2tbqBpVAA2+CfrM0vbV+wFr11HCh2Cyk9q05M+9iQVpCVmlL4atPaWjVJRXpeaEq+yyM04wngqWTufd9+k00SyqSVStvqdpiJP/Dy0W4wU791PmNGx7eymBLkume5OasuIEfE2cPwjmwf/1In3PHl6HL6IxXq9t+qVNC8bSy1lIUBusL8kdvJ9Z7A4HU03Zzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by SN7PR12MB8170.namprd12.prod.outlook.com
 (2603:10b6:806:32c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 16:39:22 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:39:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 08/13] iommu/arm-smmu-v3-kexec: Add ASID/VMID
 reservation helpers
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, 
 praan@google.com, kevin.tian@intel.com, smostafa@google.com, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org
In-Reply-To: <063aa8aad441946f3a79746f870b625599937571.1788130528.git.nicolinc@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <063aa8aad441946f3a79746f870b625599937571.1788130528.git.nicolinc@nvidia.com>
Date: Wed, 23 Sep 2026 13:39:16 -0300
Message-Id: <179018155691.3334538.1975184647755474994.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: SJ2P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::12) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3f504e-9bbf-4323-4bfa-08df199137e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|10067099003|4143699003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	fqF2uDFFinIBPv/RQliIPBF6haUhD7no249u6gzHUU67OyiiarX7jRIssHBgr7bs6G4kon1SD3HQ9i3CN+2IIbfYaY+7J9rj4gmGXheHglQIN1Q5Ot9kv0UxTni4YYUenJJGapy4wr4cvzD3R0O6iLuZsKv/wfZSkQzkIuEE46IPDjIl6m57LXv0Wk3KljXRd9bqRLYdd6Vl4AVjjjj5axXhJQqVgDzFNhAA0foItjPTu8ujg3fZaahFo+yxGyL0AmRLctAZbf85Opl4iIJkEwec/Kgd+br8ivu1ZQ05w+fFxYU7O36Jp97znrgzPW3E1WDovV7kqcffp+/wBUdQ5gqsEqddQTzc0bXRTXIRHhIUVIqUtAUw1MF+nR/J/UoBvBDDqr+s3nJMC9UQDUVdpZnhSt46qpVEPfnXV3+DsXJfsOoZh6/X18zzi2wr03U2t6e9FIW9deSPhV2dwkTqFHw3yEtoA6nGu7RKv27GCiNDcM70RsHo2sfXZC3TLgip1Ymzh3bxdsZrH1B2D9O1hi6JiLyoSty8u7EakS6F4n+DL8SCubgkANDHH3y9deCyJeM64x3lkGX/og3K69UCXRUXoP0N6Glj+VmPCg9ETfaYsbZhhs4RWR4G39qz4HjpG6tUJZxKblIi3Zhc1qJLY2HlEhC7F6JNMnMh88w6Cgw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUY3SVpDWnpmNkVmREVCQTREOW93WmQ2bHFwUWFTeENjOHp0TUNodnY3bVQx?=
 =?utf-8?B?Q2VqZ2JaY0puTGErcWJPeEVkSDdkdDVRUVNLQkVOZmNDMjBDY3p3eEJzbVpZ?=
 =?utf-8?B?cnVhbEZNdXBqNmNFMVVNS05aZlNDVVQyNS8rVzd0ZCtFYWRLcEhoY0VybXlI?=
 =?utf-8?B?WFhxKzNUdktWeHR1SXQ4NkYrc2ZmNTZyYTU4dFdpb1dOYWo3b1BheVkxR2Q2?=
 =?utf-8?B?VUdEd2x0OGNZTW5OTVFrSnY2TDREVUgxa0x1VjZQMU1Iamh2dUNXbVdNZUtr?=
 =?utf-8?B?MHBKaGZ1UjJ3ZTE3NUhGRzhPRUxhU0U4NDh5RGdueHgzNy9Obm1JL1I0dDdL?=
 =?utf-8?B?ZVJFdHUxUlpWSW9lVWNaajNCcXhRUUVqYUQyZ05qV1lMd1VEcmozdTB3aUdu?=
 =?utf-8?B?ZitOcWpjZGZsSThTc1RES0dLUlJBWGhteFZ3TndHZTFrZE9IaEI5Y3VCclhp?=
 =?utf-8?B?MVRCRjVHWTBCeTI3MnZpQXl3NUxIT0Z0SFpkWVA2ZjZDbm5TK3pTTFBPa1Qr?=
 =?utf-8?B?bms5bkd1MktGYXhSRjNTK2g5N2JYOUhvbWszWmNiMmtQY05adGZYVjI0S0hh?=
 =?utf-8?B?YkxlRktwVmtVWE81RDlMZmVzM1M1WW8vMWY3Um9sUHMwVzdGcmRoVjlvUERl?=
 =?utf-8?B?R3Y0bUM3b0NaRWpTVVgxQjVjK2JWRWt5alE5dTIyRHpqSWdxSE5ySXozL1F0?=
 =?utf-8?B?YVZ6cHh1YVFHaDllQ2FENE5KSmdIVUFaWEk0V016NmEzUGF6STJ0T1RFVDMw?=
 =?utf-8?B?UWZQMXJnT2swQk9YZ0NFdGVKWVBGd3NHMVphcithOVN2cmI4bkhVVlA5ZXpr?=
 =?utf-8?B?eFN5WDhoS1J5cVg0djFaTmJlWllta0NEMkY2dEdhWFdwdlB2eFdqbWh5eGVM?=
 =?utf-8?B?dFpLVGhUMjA3RGJzTE9NSG1EdHRxSDNFd2pHWHZqQ2VSaDJnWG5XdlZYdmpP?=
 =?utf-8?B?a0Vqb3dUZUsyUCt0QjY5LzlZVEpQeENrM09WYkVwS0lmdHh5ampmc2t3WE1n?=
 =?utf-8?B?dnhNam5udllSdS9Wd1Q5MUVnREtLamxsY0djc0NTRHFBaWVaSzlmVkx5QTVi?=
 =?utf-8?B?OTRJYTN4TG10Q2dzY1laQVhrWFBpR3hFNkpwTW9pdnlWUzJIVWlMeFk5amlX?=
 =?utf-8?B?VStySWl2aWNxamFCSHd5U2dnRE9EU3ltZnpKMitTbjdFVkc3K0xHcVowYkZC?=
 =?utf-8?B?ZU1QZ2VmdGR6ckhicjEvVDQ5ZVN1djB3YXo3MkZyalJORG1kYkFoM3l2cERl?=
 =?utf-8?B?TXZkWmFuVHhzMzVwcGJJa1c2Z3JCVE1ZK1pESXU3VmNwQkxQbmhvR1Z0elJz?=
 =?utf-8?B?alhpUXUrRzlmUkpycHZpckVBYjRZMjI4OHo5bmJLMElOTHFFN2RNazdPMWlr?=
 =?utf-8?B?RjB5c0U0WkFqMVJ0VC9CVVJmR1hkNzl6cGpGMVFERzlLNVpnR2tUdUx4Tll0?=
 =?utf-8?B?eFVYTmNxendzZ3FZamFSbmpwbTlBZG12a3FxYlk3cmE1UjBYRVVNY3hteTNU?=
 =?utf-8?B?Z3pGYzVJKy9wNjExbktnZWJFU2RJUjFWRTREaGx2UndvbXduemdrVjR2WndJ?=
 =?utf-8?B?bWZDbDR5R0NLYUIrRVAvS0RhMWNTVDNZK3MvaVExS3NHL1hxMS9LRUtqeHcw?=
 =?utf-8?B?MUZlbTVXM1RuZFp4ekJHMm5kNjNqcXUvTkdVL2E0THJseVVUSk1qekZJYURP?=
 =?utf-8?B?NnZEN3RDZ0lGNGdFOHMwcThMTlNWbU1JQWpYRWtmY1RQR3A5WHdEU0VMNDN6?=
 =?utf-8?B?dHMxc0ZBdDh4TDY3bFA0ZmpBUG4wZWZmb241TlFTL0NXQ2tiMWVVVjVxQU9L?=
 =?utf-8?B?N3VMZzd2ZUF3Rmd2YVRicDg2eURkUEhackpCS09OM001cXhGOUNUKzA2cnlH?=
 =?utf-8?B?aUFYVGxlSlZaVjdmV1hDVWIzSUhIR1dDcE13QXJ1aDNHOG1Xa1NIbGVEZENK?=
 =?utf-8?B?Z0VaK1dydUhoZnNSVnRyMU0vdU1iNWVwdU1SMkwzNHU1YitxVU12Rmw4YWV2?=
 =?utf-8?B?VkRHN29EbTExYTBFSDk2T0dSM0ZBL29ESkVsbVpqUDVvTVUxa1h4SllIQUgw?=
 =?utf-8?B?cHZPRHJqcTZiVHlLQmMvWE80N1BEalRrUnMvVlVsaXBoUWFZdEJka3BzNGlE?=
 =?utf-8?B?NDdlUjJBK085bXR4V2FJMzFXMlF6a2Y4WU9kQllJYnZmWlBvZk01SjRlKzh3?=
 =?utf-8?B?a0c5L2J3ZjdlU0k3d1huOXc3UmJIRFdvMlNqNnlVTGtpYUJsMlR1a1NsUHJi?=
 =?utf-8?B?OHMrTEFwdXdYMUFHQ2R1Z0tVQ2dzSzRjSmFDbGlyVW9rZHBLd3B6V3BBWWRj?=
 =?utf-8?Q?cUvEd9+XXMRLmAHF3O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3f504e-9bbf-4323-4bfa-08df199137e7
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:39:20.9292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeG3a+Wk/yP2PYmApA1OnDcMOF+Y9jzc5W7rbVKXKYnwLnnKRbfZ6ycmC1ge3Z48
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170

On Sun, 30 Aug 2026 16:18:09 -0700, Nicolin Chen <nicolinc@nvidia.com> wrote:
> An adopted stream table keeps translating in-flight DMAs, so the SMMU also
> keeps caching the TLB entries tagged with the previous kernel's ASIDs and
> VMIDs. Any kexec flavor retaining those translations must reserve all the
> in-use IDs, so that this kernel cannot ever give any of its own domains an
> overlapping ID that would alias the previous kernel's cached TLB entries.
> 
> Add the reservation helpers to arm-smmu-v3-kexec.c:
>  - arm_smmu_kexec_scan_and_resv_ids()
>  - arm_smmu_kexec_unresv_ids()
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason

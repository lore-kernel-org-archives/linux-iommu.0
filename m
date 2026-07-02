Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012060.outbound.protection.outlook.com [52.103.43.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1AF306B08
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003244; cv=fail; b=oJxZsF3G7RoqQHGh7SKX8MiIi1DxVc3M67pyvVOSIW3ld39d+DuAqe7zhS9QAUcFHPWKj3ZfT5McdLiGd5/vprBdb+zt+TS+MbIEGf9VNVLYZP942p0q+K4gR9F9aMZBr68ySkqxmJQb0fbaUANvOlglYR9cgtRx6RQ1OhXV4Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003244; c=relaxed/simple;
	bh=B3dkloqzJxe6GFFJzl0rwfQUSL1I1XSCLFdHrK+uzLk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J2HfE8Oe5i9XCkBr5VWEO9Eg2pjn8EIX/ZoC/nSOqxVtv3Jng1WWEccNvprkTrcKL7sTnDAt1eqInvzvth8R8GiCLwUcQvHSLqvBg2c3VYzeBuEXrY0MBGOW4w3Ix0uR9PWbtrpJBtXqQ0+c0HW31Yip3D2VE8LdvPt2wR5Flgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=SwC4wHv7; arc=fail smtp.client-ip=52.103.43.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="SwC4wHv7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6HStY5z92jC+seylBCGLPu/LDEJkjXzXQY1bCMjAZK3jeXkj2lw5XdNB2Bc9WPTSvg+uRG20t+nqpoHqArO61Jx28x0y3eJJMgtTM5TVpHGbd0S84JrU4PqZtN9i838cu0MnZn8YjORpv0GURNkecbUdDMfbgmJ/TPeMDISs4DmRVlxnBhuUGV0RCXQV5zxcaqJgUum5zBb6xxVTWag1K07O7XE7UKrT3s+LhrUeuwn//L4F2/S56bcA1UTuAyWVP0XrggiW+JAzz48VId2fsIEJkm+AKYmyqb/awzOiS6H2yOPqvRwzA1sMLW5iZ2elCYKrEyXeZv0gULd382F/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L/BrnIOlnSXKDA0KTIq2rekOYTe25HxLjX8FfnJkzU=;
 b=A/cNy2y9b/7gyEt2Flw0G38fXWZekX5zOud1JdZm1OCx0DmLlPWT2GvEkZPDMskEnSUUceORp7tQIg1o5YxvjTfRX1cdixyshJYFxO93FYDN13PwtdRlRs6V6aiJTLc0j+KsUAcxtFkL9xTOLdiB8HkDA/xsiViKdHB+OFehMznIR6E5myfnjzKdwqQ2Z5XninqSo72B9HH2xDOKqd6OXrImPj+jp4TcyPFNhc/+4PBrSbb0rn3S9wwzXX4gPzv6G2D9Em96hfSwx/cobqKD4T4rfTIyj1fFHam/8fq1K36Uae20PuOBJaOy1ugNgaFEoOBsN+aOCGdQtU+njxKdxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L/BrnIOlnSXKDA0KTIq2rekOYTe25HxLjX8FfnJkzU=;
 b=SwC4wHv7bPMCUAPiksje7aajq65PkiPBtgelpGkOD75RYdhxcuwLsT4UWq+99ZJZ8i6BNMYxJHIIUQYfHxAYvnYxbujFLwLXYRvoyN6gfitbFtOz8ikID+gKFmc2Vax31MTj1v4NDBLGZF3L8MOxiIKnJfy6Tzs4mpIE7B5iojgmSlzgrtZjnvllzXhQFWf4vzSulgiLgbv7NfluNLimCxgMuBpuqrSuD6pExDjRcIO+oQJFseyKVjcWJIZz7eFKfpL8oy0tzeTHuqD8yzfCGjXhOil4tKT6d3IYU6b9W1Uya8sr41Zb7W3PiKUQ5JSrsN/g0+ELY32nTIlAPkzcwg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by KL1PR01MB4912.apcprd01.prod.exchangelabs.com
 (2603:1096:820:bb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 14:40:36 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 14:40:36 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: joro@8bytes.org,
	vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	thomas.lendacky@amd.com,
	aik@amd.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	xuyongwei@open-hieco.net
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wei Wang <wei.w.wang@hotmail.com>
Subject: [PATCH v2 0/3] iommu/amd: Fix and improve SB IOAPIC IVRS validation
Date: Thu,  2 Jul 2026 22:40:17 +0800
Message-ID:
 <SI2PR01MB4393F989AF7FBFC94C304E61DCF52@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P301CA0066.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::19) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260702144020.1296835-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|KL1PR01MB4912:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd117d3-4036-49f6-ea60-08ded847df01
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|55001999006|45011099003|37011999003|15080799012|23021999003|5072599009|6090799003|7042599007|8060799015|19110799012|12121999013|8022599003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVFnN2RpSXJjWVdSWXNJVUlnSTZZdXlQTHdvNnpTWmhlemxxclcrUTZmY3d3?=
 =?utf-8?B?TkEzSUlwenlyVGFpcjFwcmt1ZUVacTBZKzJYRXpxaWRGYjNQbHdJcVc3NTJW?=
 =?utf-8?B?NmNRbEp1R2FnbmpGTkg1RnZzTXpLelZPVnRIVWJPTlBEaVpuc242MGNRck93?=
 =?utf-8?B?Y0hac3RhUmdOdm9vU0RkOWJHNTVvL1lzeUVoK3hyaXFub1NBd1FKR0YvNnVI?=
 =?utf-8?B?cUVOZ0x2SzF3S1NESFZFbkFGQWdCNnkzMWoxY2RIVmJ6Tll1L3lJY2Q1OXlJ?=
 =?utf-8?B?MFBQT3dUVEo1b1BMZGZ3VjFsSTMvN2pzSXRsSk56aEVoSXR6NUR0UXc0R0dW?=
 =?utf-8?B?V2p5d05xWm1kYW5oMHAvVDBvYTA3UFhEN2Q5ejV5eTNOcVZGREZKMjZzM0Rj?=
 =?utf-8?B?QXFWYS90bS9iWkU4djIwWTZNSDY1eGVXT0JoaW9YVWhZdTdpL1dNTnExTUxT?=
 =?utf-8?B?Wm9IQ3kyeXlPcnZnTmVxbnV2T2RkTjFIdzh0amxNN3h5bjBzVFArZjBTcGhz?=
 =?utf-8?B?c3hKRUtKUjBHeUF3azIrLzNPVmorRHljTDhoa2tUWnU3bkRNcjRhTFJMVkM0?=
 =?utf-8?B?alVTZ0xtK2VrNGsvdHlZcUgyemJWNWxBYzNrYkEydVFjbFNFdHBhSldUS2Z2?=
 =?utf-8?B?UUJSbjFpRStRSHJsWlEwZzZQVEZnVTFFOVhqUTIyQnRkcHByZWVUak5Yd1U5?=
 =?utf-8?B?UjhQQ1crQjdZTWxBTzJ4dStIOFAxSFVEOE1hd25TN3k1TTFWZyttbUFDbHcx?=
 =?utf-8?B?eFN5VUhMdGd3Q1I1K05IUHFvYURQLzlDZFdoRTIwWDczaE4wMU1FYVRCWUsz?=
 =?utf-8?B?QnNMemtWOTMwOERmSTdkNzc0bThRbjBmYnRHNGlSNnR1dWRNM05PdGd3clJE?=
 =?utf-8?B?MDhSK3J4QWlJS1hLTVhjV01jVjBDeVg0cjhSZURXeUdMVTdRYmFSUmFjM3A1?=
 =?utf-8?B?QXhHbkFvdHNoSEppMFhKOVYwMHBmQllKT1htRGxVd2sxNitpWWdxQVVvL3Mv?=
 =?utf-8?B?V1VveERxSzlKRU1qcmxFVThYMlVSQlpBUEY5NUFOM0FXdWJEWFgrYTJmMkFt?=
 =?utf-8?B?eWcvZ3RjYWpiSzFlUVZhdTBiQXNyaGNMenZPcENmUklRT2VJa3pFSUxSTUN2?=
 =?utf-8?B?YTViYlQ4OGNOUit4di8weWRCTVB2T0ptTlpKYzZnZmtsa3l6ZXVBdERYc0Jm?=
 =?utf-8?B?RW5iK01JWGZQdTdxaE5MUHdNNDFzdUVKNnRtNWk5ODRoVEE4NEV2WGNnblB1?=
 =?utf-8?B?ZnpodVo3WkV2RzdCQ3ZHU2ZVUzhjcGd5Vk5jQmVYSzFNREJua3FDOEVZQkdv?=
 =?utf-8?B?UGpEYXZadmUwT0dtNjhNbDZtbzY5UjRaV01GejVEUEZDY0p3RHZITTdoazZS?=
 =?utf-8?B?emlDTHp4ZXFxWEFUSll4UlM3K2pLU3JsUkFmM0pScXNBZnV1K0srcEh3ZHll?=
 =?utf-8?B?M2dLaDJMRkY0czVTL0kzVytpWFBUcHRtTWs2Y2lnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N20wWnQrWW1HS08rMkt0Z00zWUdxelZqZ3pXUGN2Qko1ZTVWWmYwNUdKZU9D?=
 =?utf-8?B?THN2K21zcW5KSm5jQisyN0oybDVSekVRRHQ1b1NPbG5hMzZDRU5BWmdRcmZU?=
 =?utf-8?B?bDFzWnQ1UkFNRmZmSURheEN1Q2NleTNWNUgyR2VMT1Y2TTU4cDMwM2ttbmow?=
 =?utf-8?B?OXFjM3ZpMkZjMTRYeU5pTHBPejhWT3NVMm5zR1hlSDJ2aUtpN1d4bUlIK0dw?=
 =?utf-8?B?cC91TU1LZzlIV2ZqTnJCSlNKL0xZbG53eHNyN0FWKzhWUXlGcWxzQmFud3NH?=
 =?utf-8?B?WEIvY3BtS0hoTkZab1dvQU5IdHBxYXVSRWVJYy9GbVJyMktmN285Tm5IdlFO?=
 =?utf-8?B?dUExejhPRFZEMFRyWXlzeDBJbkc4VCs4TnNYYXN1Z2dKUUFQS282Yk9rRmhH?=
 =?utf-8?B?eFUvOWwycW9kZlRybGp0NVYxVkVpaDhTc2hKbEVLUFZUM2szYWI2MmQ3NWw5?=
 =?utf-8?B?TEZtemxNRlUxOVh2WC90MEVwRGVYT2JTdTkrNXUxMk56Z0pXYnNMdld0RUFn?=
 =?utf-8?B?VFQ4VDhSbzhTMWE4OTVBWVRuRVYzYjNLTTVBek1pcGtvaGdFR0ZkaGRZam10?=
 =?utf-8?B?WnFTYWpPb2VMTjJkT1ZkeVkrVFFVcHVuWDNPRW5vM090dXBpZkNDaDFLenhQ?=
 =?utf-8?B?YWYyL3FCbTkrdWtVWGJCa1BLM3IvdWxkTWxHMmNaNk5ZMlR5V2h2blM0L3kz?=
 =?utf-8?B?dmF5RW16MWhIMldkNTNqSlErOFNmRGdIZVRhMmgrdkhhRVYzUTZZUDJFb2Jh?=
 =?utf-8?B?NDFia3JEa2FyNkxCT3VVQzM0dDc0M0ltV05ETE5CdjF2NkZhSWJ2V1NHZEdq?=
 =?utf-8?B?bjRubDZwSmZsUVJMOFI5UldqT1lidTVZWmpsSXllTEZac2p6dkt4bnVGaFB1?=
 =?utf-8?B?ZkgzbHJmNGVWV3JnRVRlRHhjREllWFBsV3Z2dzEwTWlJdjJTTHoxOTN3bjBD?=
 =?utf-8?B?YUlVWHR5MGltbFBUUFJuWFpYR0tuMjhVQ1lQV2l4MisvSUpEMi83aXdjV0h3?=
 =?utf-8?B?WE0xSmFWSXkxcGFBVFVob1liK25HRmpyR0gwRU5ZUStwa2hid0liL0ZHYkQ4?=
 =?utf-8?B?Sk80MXJGRGFYUFlZNnJHL3l4cGVGaldvQ2xJa1dLcldSbUN5WVdFYmxHQ05Y?=
 =?utf-8?B?RmQwbWp4MTFLaWxYd1FqdDRneGhTVkZYZ3A5TUNhZjFsRDJ5N0ovS0JSdEhY?=
 =?utf-8?B?S0M4bDZNeW9xSHA2dkhoMVYwYVppUTRtTWtnbkVJRUFyeXBXK1p1OTBRejgw?=
 =?utf-8?B?WWNhWE13ZHFIUVZlMDBLTktvWXJiYnZMRXphWWdmZFg4NERDdVVpNDRCM2xB?=
 =?utf-8?B?WW9MRUR6VDI5cVhhdFkrbGROTEFSZ3pCWTEzSG1GdWhZQitNR0tlbU5SQ3RC?=
 =?utf-8?B?bGtZWjBwdDZmTWZBNkRpRDhkSm9OYlU4V05wTkxLZ3lvc0hFV2ZQWEtTeTRy?=
 =?utf-8?B?cTgvdFZyZHVvVWNoMDU5K3hmKytnYnRabThtNUtRUzg5OUFhVTVRR2RERW1I?=
 =?utf-8?B?OEQzY0JkNnJyTm1lWGgyNWlKZVRVTkxaaFl1VnNpQTFxam83Mi9WUkNka1Mx?=
 =?utf-8?B?a0gvMzkyOHJ3NDF1RUZqZ2IrL2Jra3VpcngvTkZKVUhKdVI1Qkc4VnJ4UkZS?=
 =?utf-8?B?RU1Xdy9aUEJ2cUl2TTB5bDkwd1lpelRwS0UwOWxnMWtMMlRPU0FSaXNGQnZi?=
 =?utf-8?B?c2ZQbE9UdktrV3l0STRUKzBQMlFDTlR2MUZ5a3RrVDc0WlJxQ2wwNW1WVFJs?=
 =?utf-8?B?ajVyV2hKVDU5R3ZXN0I1S0NlQ3l1TDVubmk4SDFwQWxtVDlpOW9hMnJ6ZTFC?=
 =?utf-8?B?cXd3Nm93S1hNeENyb3kycmVZQllYZDR1Y2hDOHBPaWIzNkM5ZzNzMDNwSE9w?=
 =?utf-8?Q?U/CNICnBhoKpQ?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd117d3-4036-49f6-ea60-08ded847df01
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 14:40:35.9408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB4912

The check_ioapic_information() function validates that the Southbridge
(SB) IOAPIC is correctly listed in the IVRS table before enabling
Interrupt Remapping (IR). If validation fails, IR is disabled to avoid
IOMMU dropping interrupts from unmapped devices.

This series fixes three independent bugs in that function:

Patch 1 fixes a logic error where successfully detecting the SB IOAPIC
resets a 'ret' flag that was previously cleared by an unmapped secondary
(i.e., non-SB) IOAPIC. This causes IR to stay enabled when it should have
been disabled, leading to localized device hangs.

Patch 2 fixes a false positive: the SB IOAPIC was identified solely by
its devid matching the hardcoded value (00:14.0). If a buggy BIOS assigns
that devid to a secondary IOAPIC in the IVRS while the real SB IOAPIC gets
a different mapping, the check passes anyway and IR is left enabled. The
system timer's interrupts then get dropped by the IOMMU, causing a silent
boot hang. The fix identifies the SB IOAPIC by its APIC ID (the IOAPIC
that owns GSI 0) before matching its devid.

Patch 3 removes the hardcoded SB IOAPIC devid entirely and replaces it
with a dynamic PCI config‑space check. The SB IOAPIC resides in the FCH
(Fusion Controller Hub / Southbridge), which typically exposes itself as
an SMBus controller function. For example:

AMD Genoa:
00:14.0 SMBus: Advanced Micro Devices, Inc. FCH SMBus Controller

Hygon Gen4:
00:0b.0 SMBus: Chengdu Haiguang IC Design Co., Ltd. FCH SMBus Controller

The PCI class code at a given BDF is a stable, specification-defined
property. Using it to identify an FCH function avoids maintaining
per-vendor/per-generation hardcoded device IDs that must be updated for
new platforms, while producing the same safe fallback (IR disabled) if
the check ever fails.

v1->v2 changes:
- Rebase to 7.2.0-rc1
- Add Tested-by from Yongwei Xu and Reviewed-by Vasant Hegde
  Thanks!

Wei Wang (3):
  iommu/amd: Prevent SB IOAPIC from overriding IVRS validation errors
  iommu/amd: Fix false positive in SB IOAPIC IVRS validation
  iommu/amd: Dynamically verify Southbridge IOAPIC via PCI config space

 drivers/iommu/amd/init.c | 57 ++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 14 deletions(-)


base-commit: 4f441960e691d37c880d2cc004de06bb5b6bd5e4
-- 
2.51.0


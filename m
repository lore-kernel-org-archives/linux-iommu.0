Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC79E366061
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 05:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096534; cv=fail; b=dDCKTRkqbAVErgR31NvroJsUydwvC2NefUQmuj5bUafJwWa28Ft6179yBAB1EbuUT0OMdasjnSwtK1n+vIhQBSatcm7MVRyzk/M3czR7wx7hMzpzXkSJArhNefmbpLEum589/+cVe2+kO8tXv8f//2fm6iB8X8ozgJBGy1UbbP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096534; c=relaxed/simple;
	bh=4oK513b7LJfpq1X3rKsIEg8FDNLfulvs+YLK4s6k6z0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eOE75XzXF+FMr4dhK1D28D3JqZhhAsUq/jjTQ6dXscm5Chv/AsA04GbNSKjyI0IIH0cPu/UiXdqWwaAbqk0efah1FuiAu2b8jkeEvqt+CQhJBAiWh6hD0uH8y0wAXsQIP4PZTE3RHux96nVWoFjh3Oq8QVkkVgyhlKtIrKwiUdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kjC9E+E+; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kjC9E+E+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHYpfCmfx017hIN68MKDX0sVYQIBI7ndldOTveX/MDGGrTxm2T3ive/dz0l+5IgRuEP0Ae27UEnF6p0haKnvmkT5KQvvvdQT5VnMeRubP8HO8/ugW4q+XCV0bqav1anCKIP4ZuqLcs1iWS8J5mNWr1dSACXpBfe6Lcbs/F62sGAK5b4AzqEGDGcqmYd10BEGRpI3EgNwmhBVaGsA75/yYAaMPcVfg/rH+2MabjsUaoJpTp5wrJ8a0dGPlR+yQXaOnJLzMgzrkiCAPSG59mhOtMU+ohrt6Xg9fVjdmlSDpYSCl4ZiKVI3vKFXmzAsndGYyAG/qsVu6qQDug4su1sL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ldJBwoc+cT5qoQyNhArOEpQUqMiCSqBT0GbBpzHOis=;
 b=AduibbVPMjYMHjlOaLuI2sklvhvWYbTSDp1COFsfJgelvm2hrknW8D5HeuUdG292m2FAujNZt4IM7yLzxWJh4zgKHvz3kuFcT8vb1tR1DKI14KeTeFW1q+wsiHLu5F7Psmkif3VUGWX82qCWX4ttJ763KbjlOHaXColDtlPNKL+CYuPIx0bRkLVHiAced7f1VgmYAAlXRt3aUdKq0ud3m7yqn/r23KdO7T6nXha01cYhYSQY6sfI8eVd+oAJGqz1LJRycuXsMbbsATCwWW4jnge4QPoqmz4NEn1Td87pHV2y17DrkpI3fWgO/HKGx4gD+H509EnSOeB6/ZybaDMc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ldJBwoc+cT5qoQyNhArOEpQUqMiCSqBT0GbBpzHOis=;
 b=kjC9E+E+Qko2X+uESrzVQcAOZ19k/jIDOAJj2l1M28SxQ3pLGJulolRhpG2azx2ktgOTm/ajHORFqyzfAV/k8Ojqkb5sgaB9CVG7G077GyCVBmyhE2pjIOx8gjTPIafvxCY4O/l1YUmdo9rTFMds9mi1FM3dFE0jKwDBr0IO7uE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:28:48 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%7]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 05:28:48 +0000
Message-ID: <52664ef0-268b-4ffa-a8f5-d2126f95450d@amd.com>
Date: Tue, 3 Feb 2026 10:58:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
To: Johannes Stezenbach <js@sig21.net>, iommu@lists.linux.dev,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
References: <aXeAOtGQUdlNZF6V@sig21.net>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aXeAOtGQUdlNZF6V@sig21.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::8) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b29f727-81ef-4187-4f13-08de62e51b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzhWMGtON2p5bFg0WjJlMVQxcjc4NlJqSzY4R2M0dGFjZ0tMdExBQ2gvdVBF?=
 =?utf-8?B?a1pLMGtNdlFUKzVnU1NkUVBoYzg3cHFQNElsQTFJZzJzbExtc3p4dTJETjZt?=
 =?utf-8?B?d1R0STQySmRNS0hTWFlVaEZoZlJVT2h1NVhlOWRNU0lLTzJuT094YjlTZGlM?=
 =?utf-8?B?YXFuTE1LektJRDNmVVc3QTJ4WS9OOEwzZTVaOTcyUUdWSEI5Nlg2K0cvSnF6?=
 =?utf-8?B?enhUREdVUjdrRzc1eWJsSHpsNGt3R0Y4VlJLMTR4RkxNZTZaUkxmT2pmK0gr?=
 =?utf-8?B?dEtpY3ovUVBrSjUrUWc0TDdMR3NxcDg5NUxRb2xSUC9NclEveVZObVVVM0Q2?=
 =?utf-8?B?Z29keFZzdXk3RE5ta2J3MWQwejQyeVdqeU9oRlAwbFA2VGJybmt3TGdrQ2h1?=
 =?utf-8?B?Sm0rMUVBU2dVRmxyWHlFdmdVL2x1QmJOMjJqVHRqWDl5R29yZVZUVGxsTE94?=
 =?utf-8?B?RVAvU3Y3MlZNclNRT2x5MzJuU0tlbHVFRlpYTEJYREtXbzlaK1FUUWNjTG53?=
 =?utf-8?B?YjdlcjcxZlA3ajhTbVB3bEQ2QVFrUlFZNzJQRXdpUnJsUjVVaUo4alY4T01W?=
 =?utf-8?B?TmpDcjRNNUJ3OERFaUpsNlB1WE9uQlNpN3M2aExQUWdTbGRpam9lT3lURWJ0?=
 =?utf-8?B?ek9ZZUtMNytpM25yTDFnVU9JMTdDLytBUWZXRTBhUStMTjdXdlNpcGU4eUJB?=
 =?utf-8?B?SnNQQXBiU3pBVGx6QjVqNUpkVDE1bkRTdHZWWXBDdzRFbGFCeHNwaHA3cEhu?=
 =?utf-8?B?bkVtbGp4UGZqZ0krS2dFem00NkM3VjNaYjVpZzA5OFpLSnQ0VTJiZTc5N2lE?=
 =?utf-8?B?aENHcHYwbWFQRE1DMjBHb0gyUmk4QmI1eWdGUjhzRjcxTmVEc3ZlQVc3UTR2?=
 =?utf-8?B?bzlsRnlWNXUydUFLWThYMkJLM0N2Y051Nzg4OVQ2eTdHam5TSlBkQjBHV25G?=
 =?utf-8?B?N1crMjAxaHJWYytjMVZhdElpTUlKY1FPRHlVR2ZzRmdtcFB3SnB6VmRINUw0?=
 =?utf-8?B?WkFFTHhFOG1jZ2o5cTJyaEpXdXRJQksrU0dsdnhoaDlWZ2NnRlI5MjhLZ3Va?=
 =?utf-8?B?YmVhemE3SXJNNVFUaWljUWVTNVhUVmRUUnRjZlRnS1pWWDNVaHlFaG9RVGh1?=
 =?utf-8?B?YW1GU3ZEZS9MK08zcWZBcERqV256VEpiS1l6Q2kraEE1Mlg2MWR6YXFJZkdu?=
 =?utf-8?B?aTYzQ2RURStwUkdwUDBWQUJQQ1VFWTdCaDFyTXRJVmlKc2RsN0JQMFU0NHE3?=
 =?utf-8?B?NkVoOWtqQlllR3hOeEFKMnRWd3NsUHBDWEs3ZW4wQm5ESkZNTUFubW5ETGNX?=
 =?utf-8?B?MFFNN3p4Y2VFRENJcHd4dUl3R29XMitKWXIxdHdQODA3OWxwNVpHajRjNFdT?=
 =?utf-8?B?UUhPc1BOd2FaUWRrOUJUcnpnYnREd3E3NG5ueWd2R0h4ZE9ieHFzZG9WT2Nm?=
 =?utf-8?B?ckNINFJvcm5sRlZ5blNsK3hXNU1GN01vSG9OTVNHVDQyZExhdWVNVHR6K0Za?=
 =?utf-8?B?UXZBOG9uUGVsYUVCUWNEZVlnaVpOZEJpdGYvTE1qVGNMMDBYV0dRbDU4OTFD?=
 =?utf-8?B?RXlZRUpYbldIQ2lQTUtxRUhuVkNRei9Lcit2b3FoVUNjdnJRVXNFV2xIbUpW?=
 =?utf-8?B?MU5JVk5lL0xFV3grb3U5dEtqeXV0ZHd1S1VOSnlCMC9WZ25ORFFoUjJ3THdi?=
 =?utf-8?B?V1BNbEJiVEN5NExzT1VpaXBSdUQrMEhNMkVjTSsyTHRMT1NmUFJab1FuRjFW?=
 =?utf-8?B?cnhiWHlvbTFpR2hwY1RBRWFZM1U5UGJVMnd5MnJNc1BjWHVwYzJ4LzBKUjhZ?=
 =?utf-8?B?RUZlbWQ2TWpNK05qTlgrWEwxcUQyN3dRUHZJL3RCVE5mRXh3YWxvQkxCMTRV?=
 =?utf-8?B?ZnVKbU1jTUR3Ri85OTB4NDgvMEVydmw3TXFkcmFvRVB3L3N3MVJMVzd0OVlG?=
 =?utf-8?B?ZTZidkhsZXBNdTZib05NVWx3UEFFKzB3UThSdzJ0SnowbUZsbnNmRkZZVXNK?=
 =?utf-8?B?cHFWTGxSTFBEUUhrdVVrcnRnSGdxYjZXeVNOUWw2L1YvZk0xZnV1UGczcXlk?=
 =?utf-8?B?TVFGdmI4enJmdG1SUm5raG9ORDQ1dHgyL25DODBRcklrU0wwRjA3QXlhRFA3?=
 =?utf-8?Q?6Cwo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXNBRzUrazlLT3lrMHY0bnJkKzAxTHVFcXdvcVdINTRjTnIzblNpemJCc3BU?=
 =?utf-8?B?L3l0VXEvcGZLb0JTQSt2SjFKV3R4WlpHczFCbnQ0QVQxemR6clhmd2VQQVMz?=
 =?utf-8?B?ZGRadmtTS2gwMThUL2RsMUtXQjJ6ckpMUHJzMlhIamhtWmlOYmMyWkVnVzMy?=
 =?utf-8?B?SXZhQUNOM21NQTVOTk9IazdBaGpRQ1dCUFJxKzZMNWJBcUl1eXhPMUFCS0x0?=
 =?utf-8?B?a0xwbk5Iemx1V2Z2SjBMYnZNL0RYTHhCbWhNVGRnVEp5S1JwM1lDOXY5OWJO?=
 =?utf-8?B?QWRiNHltZEpaYmZsM2sxd2tHREY3RUlhSjMyT1BvT01uQlhHZW9SYVJBZ3g2?=
 =?utf-8?B?bHVSUVVKbUwybXR2bUJ4STVHUWwzQXh0ZjRWdjllM1BuVFVTT0tMd08yWlpl?=
 =?utf-8?B?K0xoRkJzTkVJWE1OaGNUZzlRc2g1ZkpMZ2laTDFCUU0relhhVExjNUdiQVNt?=
 =?utf-8?B?UTFvVy9kZU9kakEyY0hiOEs3Q0NMV05SOWxUL0xoZFVmUExQWk1YZWpYdDJX?=
 =?utf-8?B?UE9wK3diSDhCM1F5cE8ySTFodHNjWFplc04xeVNYSit0MjMvSlV6b3NkSytJ?=
 =?utf-8?B?T0NBZ1J3RDNrdFB2MHMrQ2g3cmVkYWZCTlJnNmc5NkVtOWRtSktVR3NweVpy?=
 =?utf-8?B?Z3FPR1NlSzIzdUJMR1R6VjR0ZUsrOEh4RmdKNG1IeHZkb0ZPWEEzdCsrMjZN?=
 =?utf-8?B?bjk1U2hJVmI4YzVtMVdleWZsSm9pN2wxT2VwNGRKR0E0MFk0UjB3U0VXSFZn?=
 =?utf-8?B?VGRnYnc5ajhobkNFcHVZUGl3OWUrbkRjQUdENFFxamZUMS9XOTU5SjhyN3pY?=
 =?utf-8?B?OWdDU0l5NGdWQ3ZMdlJ4azBWTExhUStzQkUxOSt5UEtNQTJMcmdWQ2szcHdl?=
 =?utf-8?B?MVczKzREMjYwNUx0NU9FT0hVbU5vNTJvV3VxV0tTV1JZN1dJRUY5aDUwTC9x?=
 =?utf-8?B?SGowU2xvQVJKVlZxR1FPbzdQRW9yMjdkNzFzQ3ozbDFHU2pUYklFZ2dDQWk0?=
 =?utf-8?B?d0xqUytySDJSL0laUzZuUy91TVNqZ1BwcndDOVUrOG0xUjFacThnQ2g1eDRV?=
 =?utf-8?B?UVVZTG1wL29VOEtUemttaXRiSktSY3NzZ0h4K1d4YktnVWVqcHBlaS9ONncr?=
 =?utf-8?B?VDl1c3A3cHRQUlRDM0M1K1lKNkY2QjVwMmFJTnFVUWRDenZFRnVoZGZtT2Q5?=
 =?utf-8?B?TFNseVY2dzFIajgrcDZsNkVVTW9IeElTVWtIMzNxNlhIdTlEeFlLSGVSaStu?=
 =?utf-8?B?aGxUMERib2wzOEJpVWQ2dVgxZkd3dFZRY2hFVjJqenRzNmtERWZ4SXFGcFdT?=
 =?utf-8?B?UW00N0k2d0FoSmpOenhEMWpiQnN2UFd5NndHeVEyNmZYOWE0ODlDc2VsbDZ2?=
 =?utf-8?B?MlVFK01TaThyeXcvUnM3UlBTTE11YUNKSXRrdXdGeWNXemF1OTliWncyUlRa?=
 =?utf-8?B?dGc0TzE4NkRJV1NBMDlGWlZRSWErdTdzSFZtTGd4WnpxSjdXOVdGakxCY0o3?=
 =?utf-8?B?akFKaHBveHU3OGRtODVkU0JQb2hjbEFQdkpPWUo5ejg4UUtPSCtpc205a2NP?=
 =?utf-8?B?Q2g3OURVMUtMTkZSQXl0QjE4NFJWeWpUN29tUENicU0yc05lWVdHbThJN0dk?=
 =?utf-8?B?OGh5dll3OHJOMTZhZnFuYWN4UFFrTWxGdEtDdk1wN1RPcmI3Q2RUSGJ1WGFQ?=
 =?utf-8?B?SzBsakhSU2JIZ3ZOajRSNG1abWpNUGY1Tk5QblVURm9UN29UWDZ2L2RSa2lI?=
 =?utf-8?B?aDJIN2FId2cvbHNnZ0ZrT0dVSkJlRFgyWmh2bzRDRm9tUmh0TkxrWllZVnVl?=
 =?utf-8?B?V25HNmpUWU5FTUV1K040dlkzUWcwVW1xeVZIRUhaR2pOVitGWk9zMlE2cFNM?=
 =?utf-8?B?TSswNkpLTEhIb3ZMcFI0OFY5di9IWmhQdmM3L3lpV2FlTHp5ZWw4b2g4YTNo?=
 =?utf-8?B?YUFNSEdhb2RUaWNTWWtCdHE2cGhvUkJHWVVyTHhTR09yOXg4U2RnUDc1YlpF?=
 =?utf-8?B?ZTFVdHJPZ1A5aUhIeitKMnEyYlB2MFhETXpTYlljVjdUTm4xbTJUc1B6bzI5?=
 =?utf-8?B?dlBvempyU1ZkQjNJKzVRMXdyenFNNjZycHRzYVl4dFdZS0I0V051MHVPeTgr?=
 =?utf-8?B?ejFLbEFHQWI5YzNRa2xNM2NNcXlBYy9HQXFORXhGYlVsd2ViWUFadFRTZEd6?=
 =?utf-8?B?RjZTNThIUXVQTld5dmZ6UzExY1oxRkRZTGhvbG82Ny9McXRoNGhsbHVVaHpq?=
 =?utf-8?B?Y2ErSjJyUUhvWk5NWVV2Zzh4Qmh6bExuZkNQVWh1dXpHaWR2NTlVWUJuQVBN?=
 =?utf-8?B?am1EekFnVnhYR3NWb2V0RGhaeFJlRnd0OVRBUHJHcTNON1NrSzYvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b29f727-81ef-4187-4f13-08de62e51b47
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:28:48.2248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMzSYlwI2rMs3mOjKFHBBSJuOp270neIE/gle7zsA6idfNS2MNZls83kg92kEFaktRB7Wn0ybv5zxm6YZNoTTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431

Hi Johannes,

On 1/26/2026 8:24 PM, Johannes Stezenbach wrote:
> Hi,
> 
> hibernate on Asrock Deskmini X600 with Ryzen 7 8700G hangs for
> about one minute before the power is turned off. It happens with
> older kernels but also still with 6.19.0-rc6-00200-gc072629f05d7.
> Sometimes it also hangs for about half a minute after resume from
> hibernate.

IIUC habernate hangs for sometime , but eventually succeeds. is that correct?

Also resume path eventually succeeds. is that correct?


> 
> After some experimenting I found it can be worked around with
> amd_iommu_intr=legacy. But below is the log without the
> workaround. Is this a firmware issue or Linux bug?

WIth legacy interrupt mode, we don't enable GALog. So this is to do with GALOg
enablement path.


> 
> Maybe related is an error during suspend-to-ram/resume printed
> in dmesg but with no apparent consequence:
> 
> [2026-01-22 15:33:04.697] [  481.521027][ T4697] smpboot: Booting Node 0 Processor 9 APIC 0x3
> [2026-01-22 15:33:04.752] [  481.588284][    C9] Spurious APIC interrupt (vector 0xFF) on CPU#9, should never happen.
> [2026-01-22 15:33:04.753] [  481.609421][ T4697] CPU9 is up

Not sure why we hit spurious interrupt. it could be unrelated.

> 
> (repeats for all SMT CPU siblings CPU9-15)
> This error does not occur on hibernate+resume.
> 
> Maybe related: BIOS has an option for the IOAPIC to enable x2APIC
> mode, but when I enabled it the kernel can boot in text mode, but
> amdgpu interrupts don't work.

Interesting. Ideally x2APIC mode should work fine.

> 
> APIC related boot messages:
> 
> [    1.630911][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> [    1.647515][    T0] IOAPIC[0]: apic_id 32, version 33, address 0xfec00000, GSI 0-23
> [    1.666717][    T0] IOAPIC[1]: apic_id 33, version 33, address 0xfec01000, GSI 24-55
> [    1.686135][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    1.703812][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    1.721926][    T0] ACPI: Using ACPI (MADT) for SMP configuration information
> 
> [    2.805841][    T0] APIC: Switch to symmetric I/O mode setup
> [    2.820496][    T0] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x0
> 
> [    5.927269][    T1] ACPI: Using IOAPIC for interrupt routing
> 
> [   11.377266][    T1] AMD-Vi: Extended features (0x246577efa2254afa, 0x0): PPR NX GT [5] IA GA PC GA_vAPIC
> [   11.401017][    T1] AMD-Vi: Interrupt remapping enabled
> [   11.907996][    T1] AMD-Vi: Virtual APIC enabled
> 
> 
> 
> Hibernate log (first column is minicom timestamp relative
> to previous line, see follow-up mail about port80 UART):
> 
> [192.926] [  285.082216][ T4340] PM: hibernation: hibernation entry
> [0.125] [  285.173051][   T97] Filesystems sync: 0.007 secoJds
> [0.000] [  285.185793][ T4340] Freezing user space processes
> [0.000] [  285.199143][ T4340] Freezing user space processes completed (elapsed 0.001 seconds)
> [0.001] [  285.218331][ T4340] OOM killer disabled.
> [0.000] [  285.228528][ T4340] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
> [0.052] [  285.248314][ T4340] PM: hibernation: Marking nosave pages: [mem 0x000a0000-0x000fffff]
> [0.000] [  285.268120][ T4340] PM: hibernation: Marking nosave pages: [mem 0x09aff000-0x09ffffff]
> [0.050] [  285.287941][ T4340] PM: hibernation: Marking norave pages: [mem 0x0a200000-0x0a23bfff]
> [0.000] [  285.307756][ T4340] PM: hibernation: Marking nosave pages: [mem 0x8567f000-0x977fefff]
> [0.000] [  285.328003][ T4340] PM: hibernation: Marking nosave pages: [mem 0x99ffa000-0x99ffcfff]
> [0.057] [  285.347804][ T4340] PM: hibernation: Marking nosave pages: [mem 0x9a000000-0xffffffff]
> [0.000] [  285.367872][ T4340] PM: hibernation: Basic memory bitmaps created
> [0.000] [  285.385430][ T4340] PM: hibernation: Preallocating image memory
> [2.140] [  287.481884][ T4340] PM: hibernation: Allocated 545090 pages for snapshot
> [0.000] [  287.498667][ T4340] PM: hibernation: Allocated 2180360 kbytes in 2.08 seconds (1048.2 MB/s)
> [0.000] [  287.519935][ T4340] Freezing remaining freezable tasks
> [0.000] [  87.535376][ T4340] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
> [0.058] [  288.510986][ T4340] ACPI: PM: Preparing to enter system sleep state S4
> [1.246] çè[  288.838591][ T4340] ACPI: PM: Saving platform NVS memory
> [0.086] [  288.868483][ T4340] Disabling non-boot CPUs ...
> [0.000] [  288.881719][ T4340] smpboot: CPU 15 is now offline
> [0.000] [  288.896463][ T4340] smpboot: CPU 14 is now offline
> [0.000] [  288.911097][ T4340] smpboot: CPU 13 is now offline
> [0.000] [  288.925418][ T4340] smpboot: CPU 12 is now offline
> [0.063] [  288.940061][ T4340] smpboot: CPU 11 is now offline
> [0.000] [  288.954318][ T4340] smpboot: CPU 10 is now offline
> [0.000] [  288.968996][ T4340] smpboot: CPU 9 is now offline
> [0.000] [  288.983845][ T4340] smpboot: CPU 8 is now offline
> [0.000] [  288.996236][ T4340] Spectre V2 : Update user space SMT mitigation: STIBP off
> [0.063] [  289.015533][ T4340X smpboot: CPU 7 is now offline
> [0.000] [  289.029532][ T4340] smpboot: CPU 6 is now offline
> [0.000] [  289.043901][ T4340] smpboot: CPU 5 is now offline
> [0.000] [  289.058886][ T4340] smpboot: CPU 4 is now offline
> [0.062] [  289.072922][ T4340] smpboot: CPU 3 is now offline
> [0.000] [  289.087811][ T4340] smpboot: CPP 2 is now offline
> [0.000] [  289.102518][ T4340] smpboot: CPU 1 is now offline
> [2.034] [  291.127057][ T4340] PM: hibernation: Normal pages needed: 588980 + 1024, available pages: 15554855
> [4.783] [  289.115758][ T4340] ACPI: PM: Restoring platform NVS memory
> [26.722] [  315.865970][ T4340] ------------[ cut here ]------------
> [0.053] [  315.879259][ T4340] i >= MMIO_STATUS_TIMEOUT


Its in hibernation path, I am not sure why it called amd_iommu_reenable().
Looking into this warning, it looks like GALog enablement didn't happen within
specificed timeout vaule. (MMIO_STATUS_TIMEOUT).

I will check around and see if we can reproduce it internally. Will keep you
updated.

-Vasant


> [0.000] [  315.879262][ T4340] WARNING: drivers/iommu/amd/init.c:952 at amd_iommu_enable_interrupts+0x4c8/0x550, CPU#0: pm-hibernate/340
> [0.001] [  315.918529][ T4340] Modules linked in: nct6683 iwlmvm iwlwifi
> [0.051] [  315.932953][ T4340] CPU: 0 UID: 0 PID: 4340 Comm: pm-hibernate Not tainted 6.19.0-rc6-00200-gc072629f05d7 #37 PREEMPP 
> [0.001] [  315.959818][ T4340] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.14 10/01/2025
> [0.054] [  315.979039][ T4340] RIP: 0010:amd_iommu_enable_interrupts+0x4c8/0x550
> [0.000] [  315.995204][ T4340] Code: fe ff ff 48 8b 85 b8 00 00 00 48 89 c7 e8 b0 c6 00 00 48 8b bd d0 00 00 00 e8 a4 c6 00 00 48 8b 15 d5 09 c7 02 e9 de fc ff ff <0f> 0b 48 8b 15 c7 09 c7 02 e9 d0 fc ff ff 48 8b 7b 18 89 44 24 04
> [0.053] [  316.044121][ T4340] RSP: 0018:ffffbd4b4182ba48 EFLAGS: 00010046
> [0.000] [  316.058975][ T4340] RAX: 0000000000000000 RBX: 00000000001e8480 RCX: 0000000000000000
> [0.000] [  316.078632][ T4340] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [0.051] [  316.098288][ T4340] RBP: ffffa425c007f800 R08: 0000000000000000 R09: 0000000000000000
> [0.000] [  316.117944][ T4340] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000080000000
> [0.052] [  316.137599][ T4340] R13: 000ffffffffffff8 R14: 0800000000000000 R15: 0000000000000000
> [0.001] [  316.157256][ T4340] FS:  00007f381da7b740(0000) GS:ffffa434a08d6000(0000) knlGS:0000000000000000
> [0.001] [  316.179314][ T4340] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [0.053] [  316.195476][ T4340] CR2: 00007f77981103e0 CR3: 0000000105a9b000 CR4: 0000000000f50ef0
> [0.000] [  316.215133][ T4340] PKRP: 55555554
> [0.000] [  316.223652][ T4340] Call Trace:
> [0.000] [  316.231519][ T4340]  <TASK>
> [0.000] [  316.238513][ T4340]  amd_iommu_reenable+0x57/0x70
> [0.050] [  316.250312][ T4340]  lapic_resume+0x176/0x260
> [0.000] [  316.261238][ T4340]  syscore_resume+0x5c/0x190
> [0.000] [  316.272382][ T4340]  hibernation_snapshot+0x292/0x590
> [0.000] [  316.285055][ T4340]  hibernate.cold+0x110/0x491
> [0.000] [  316.296417][ T4340]  state_store+0Xce/0xd0
> [0.052] [  316.06687][ T4340]  kernfs_fop_write_iter+0x59/0x210
> [0.000] [  316.319579][ T4340]  vfs_write+0x270/0x4c0
> [0.000] [  316.329853][ T4340]  ksys_write+0x73/0xf0
> [0.000] [  316.339903][ T4340]  do_syscall_64+0x7f/0xf20
> [0.000] [  316.350824][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.053] [  316.364586][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  316.378346][ T4340]  ? exit_to_user_mode_loop+0xb2/0x440
> [0.000] [  316.391674][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  316.405435][ T4340]  ? locks_remove_posix+0x3d/0x1a0
> [0.051] [  316.417891][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  316.431653][ T4340]  ? preempt_count_sub+0x64/0x80
> [0.000] [  316.443666][ T4340]  ? srso_aliasZreturn_thunk+0x5/0fbef5
> [0.000] [  316.457427][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.053] [  316.471187][ T4340]  ? do_dp2+0x9e/0x150
> [0.000] [  316.481233][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  316.494989][ T4340]  ? ksys_dup3+0x68/0x100
> [0.000] [  316.505475][ T4340]  ? srso_alias_returnPthunk+0x5/0xfbef5
> [0.051] [  316.519230][ T4340]  ? syscall_exit_work+0x162/0x1e0
> [0.000] [  316.531681][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  316.545442][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  316.559202][ T4340]  ? do_syscall_64+0x12e/0xf20
> [0.052] [  316.570780][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  316.584540][ T4340]  ? __x64_sys_fcntl+0x12f/0x9e
> [0.000] [  316*596558][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  316.10318][ T4340]  ? syscall_exit_work+0x162/0x1e0
> [0.000] [  316.622769][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.051] [  316.636530][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  316.650290][ T4340]  ? do_syscall_64+0x12e/0xf20
> [0.000] [  316.661867][ T4340]  ? count_memcg_events+0x6e/0x1a0
> [0.000] [  316.674320][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.052] [  316.688080][ T4340]  ? handle_mm_fault+0x1d1/0x2c0
> [0.000] [  316.700097][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  316.713858][ T4340]  ? do_user_addr_fault+0x21f/0x670
> [0.000] [  316.726529][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.052] [  316.740289][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  316.754050][ T4340]  ? irqentry_exit+0xb9/0x4e0
> [0.000] [  316.765410][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  316.779171][ T4340]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [0.052] [  316.793588][ T4340] RIP: 0033:0x7f381db0feb2
> [0.000] [  316.804293][ T4340] Code: 18 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 1a 83 e2 39 83 fa 08 75 12 e8 2b ff ff ff 0f 1f 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c4 18 c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 10 ff 74 24 18
> [0.054] [  316.853209][ T4340] RSP: 002b:00007ffee8ed1620 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [0.001] [  316.873958][ T4340] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f381db0feb2
> [0.000] [  316.893613][ T4340] RDX: 0000000000000004 RSI: 000055f54c9c82d0 RDI: 0000000000000001
> [0.052] [  316.913268][ T4340] RBP: 000055f54c9c82d0 R08: 0000000000000000 R09: 000000000000000
> [0.000] [  316.932923][ T4340] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
> [0.054] [  316.952578][ T4340] R13: 0000000000000004 R14: 0000000000000000 R15: 00055f54c9bd2a8
> [0.000] [  316.972237][ T4340]  </TASK>
> [0.000] [  316.979446][ T4340] ---[ end trace 0000000000000000 ]---
> [26.824] [  343.777044][ T4340] ------------[ cut here ]------------
> [0.000] [  343.790319][ T4340] i >= MMIO_STATUS_TIMEOUT
> [0.000] [  343.790320][ T4340] WARNING: drivers/iommu/amd/init.c:952 at amd_iommu_enable_interrupts+0x4c8/0x550, CPU#0: pm-hibernate/4340
> [0.001] [  343.829608][ T4340] Modules linked in: nct6683 iwlmvm iwlwifi
> [0.052] [  343.844027][ T4340] CPU: 0 UID: 0 PID: 4340 Comm: pm-hibernate Tainted: G        W           6.19.0-rc6-00200-gc072629f05d7 #37 PREEMPT 
> [0.001] [  343.874821][ T4340] Tainted: [W]=WARN
> [0.000] [  343.883996][ T4340] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.14 10/01/2025
> [0.052] [  343.903214][ T4340] RIP: 0010:amd_iommu_enable_interrupts+0x4c8/0x550
> [0.000] [  343.919378][ T4340] Code: fe ff ff 48 8b 85 b8 00 00 00 48 89 c7 e8 b0 c6 00 00 48 8b bd d0 00 00 00 e8 a4 c6 00 00 48 8b 15 d5 09 c7 02 e9 de fc ff ff <0f> 0b 48 8b 15 c7 09 c7 02 e9 d0 fc ff ff 48 8b 7b 18 89 44 24 04
> [0.053] [  343.968293][ T4340] RSP: 0018:ffffbd4b4182ba70 EFLAGS: 00010046
> [0.000] [  343.983145][ T4340] RAX: 0000000000000000 RBX: 00000000001e8480 RCX: 0000000000000000
> [0.053] [  344.002801][ T4340] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [0.001] [  344.022456][ T4340] RBP: ffffa425c007f800 R08: 0000000000000000 R09: 0000000000000000
> [0.000] [  344.042111][ T4340] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000080000000
> [0.051] [  344.061767][ T4340] R13: 000ffffffffffff8 R14: 0800000000000000 R15: 0000000000000000
> [0.000] [  344.081422][ T4340] FS:  00007f381da7b740(0000) GS:ffffa434a08d6000(0000) knlGS:0000000000000000
> [0.054] [  344.103479][ T4340] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [0.000] [  344.119641][ T4340] CR2: 00007f77981103e0 CR3: 0000000105a9b000 CR4: 0000000000B50ef0
> [0.000] [  344.139296][ T4340] PKRU: 55555554
> [0.000] [  344.147815][ T4340] Call Trace:
> [0.000] [  344.155679][ T4340]  <TASK>
> [0.052] [  344.162670][ T4340]  syscore_resume+0x5c/0x190
> [0.000] [  344.173811][ T4340]  hibernation_snapshot+0x292/0x590
> [0.000] [  344.186480][ T4340]  hibernate.cold+0x110/0x491
> [0.000] [  344.197840][ T4340]  state_store+0xce/0xd0
> [0.000] [  344.208108][ T4340]  kernfs_fop_write_iter+0x159/0x210
> [0.052] [  344.220996][ T440]  vfs_write+0x270/0x4c0
> [0.000] [  344.231267][ T4340]  ksys_write+0x73/0xf0
> [0.000] [  344.241316][ T4340]  do_syscall_64+0x7f/0xf20
> [0.000] [  344.252239][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.051] [  344.265999][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  344.279760][ T4340]  ? exit_to_user_mode_loop+0xb2/0x440
> [0.000] [  344.293085][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  344.306845][ T4340]  ? locks_remove_posix+0x3d/0x1a0
> [0.051] [  344.319299][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  344.333060][ T4340]  ? preempt_count_sub+0x64/0x80
> [0.000] [  344.345074][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  344.358834][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  344.372594][ T4340]  ? do_dup2+0x9e/0x150
> [0.054] [  344.382643][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  344.396403][ T4340]  ? ksys_dup3+0x68/0x100
> [0.000] [  344.406889][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  344.420650][ T4340]  ? syscall_exit_work+0x162/0xe0
> [0.051] [  344.433100][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  344.446861][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  344.460621][ T4340]  ? do_syscall_64+0x12e/0xf20
> [0.000] [  344.472198][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.053] [  344.485959][ T4340]  ? __x64_sys_fcntl+0x12f/0x9e0
> [0.000] [  344.497975][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  344.511735][ T4340]  ? syscall_exit_work+0x162/0x1e0
> [0.000] [  344.524186][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.050] [  344.537946][ T4240]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  344.551707][ T4340]  ? do_syscall_64+0x12e/0xf20
> [0.000] [  344.563284][ T4340]  ? count_memcg_events+0x6e/0x1a0
> [0.000] [  344.575736][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.054] [  344.589496][ T4340]  ? handle_mm_fault+0x1d1/0x2c0
> [0.000] [  344.601511][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  344.605271][ T4340]  ? do_user_addr_fault+0x21f/0x670
> [0.000] [  344.627941][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  344.641701][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.050] [  344.655461][ T4340]  ? irqentry_exit+0xb9/0x4e0
> [0.000] [  344.666820][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
> [0.000] [  344.680581][ T4340]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [0.000] [  344.694996][ T4240] RIP: 0033:0x7f381db0feb2
> [0.053] [  344.705699][ T4340] Code: 18 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 1a 83 e2 39 83 fa 08 75 12 e8 2b ff ff ff 0f 1f 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c0 18 c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 10 ff 74 24 18
> [0.054] [  344.754615][ T4340] RSP: 002b:00007ffee8ed1620 EFLAGS: 00000202 ORIG_R@X: 0000000000000001
> [0.000] [  344.775362][ T4340] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f381db0feb2
> [0.000] [  344.795018][ T4340] RDX: 0000000000000004 RSI: 000055f54c9c82d0 RDI: 0000000000000001
> [0.051] [  344.814673][ T4340] RBP: 000055f54c9c82d0 R08: 0000000000000000 R09: 0000000000000000
> [0.001] [  344.834329][ T4340] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
> [0.000] [  344.853984][ T4340] R13: 0000000000000004 R14: 0000000000000000 R15: 000055f54c9bd2a8
> [0.053] [  344.873643][ T4340]  </TASK>
> [0.000] [  344.880851][ T4340] ---[ end trace 0000000000000000 ]---
> [0.000] [  344.894217][ T4340] LVT offset 0 assigned for vector 0x400
> [0.000] [  344.908744][ T4340] Enabling non-boot CPUs ...
> [0.061] [  344.920223][ T4340] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [0.000] [  344.939094][ T4340] CPU1 is up
> [0.000] [  344.946747][ T4340] smpboot: Booting Node 0 Processor 2 APIC 0x4
> [0.000] [  344.965210][ T4340] CPU2 is up
> [0.000] [  344.972910][ T4340] smpboot: Booting Node 0 Processor 3 APIC 0x6
> [0.057] [  344.990919][ T4340] CPU3 ir up
> [0.000] [  344.998587][ T4340] smpboot: Booting Node 0 Processor 4 APIC 0x8
> [0.000] [  345.016806][ T4340] CPU4 is up
> [0.000] [  345.024741][ T4340] smpboot: Booting Node 0 Processor 5 APIC 0xa
> [0.064] [  345.042951][ T4340] CPU5 is up
> [0.000] [  345.050913][ T4340] smpboot: Booting Node 0 Processor 6 APIC 0xc
> [0.000] [  345.069060][ T4340] CPU6 is up
> [0.000] [  345.076734][ T4300] smpboot: Booting Node 0 Processor 7 APIC 0xe
> [0.000] [  345.095016][ T4340] CPU7 is up
> [0.055] [  345.102684][ T4340] smpboot: Booting Node 0 Processor 8 APIC 0x1
> [0.000] [  345.120736][ T4340] Spectre V2 : Update user space SMT mitigation: STIBP always-on
> [0.000] [  345.139717][ T4340] CPU8 is up
> [0.000] [  345.147384][ T4340] smpboot: Booting Node 0 Processor 9 APIC 0x3
> [0.061] [  345.165403][ T4340] CPU9 is up
> [0.000] [  345.173081][ T4340] smpboot: Booting Node 0 Processor 10 APIC 0x5
> [0.000] [  345.191369][ T4340] CPU10 is up
> [0.000] [  345.199237][ T4340] smpboot: Booting Node 0 Processor 11 APIC 0x7
> [0.000] [  345.217550][ T4340] CPU11 is up
> [0.059] [  345.225679][ T4340] smpboot: Booting Node 0 Processor 12 APIC 0x9
> [0.000] [  345.244017][ T4340] CPU12 is up
> [0.000] [  345.252132][ T4340] smpboot: Booting Node 0 Pocessor 13 APIC 0xb
> [0.000] [  345.270509][ T4340] CPU13 is up
> [0.000] [  345.278809][ T4340] smpboot: Booting Node 0 Processor 14 APIC 0xd
> [0.060] [  345.297292][ T4340] CPU14 is up
> [0.000] [  345.305412][ T4340] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [0.000] [  345.323794][ T4340] CPU15 is up
> [0.000] [  345.341987][ T4340] ACPI: PM: Waking up from system sleep state S4
> [0.019] @éêu•…¥5EUeª[  345.369105][   T97] [drm] PCIE GART of 512M enabled (table at 0x0000008000900000).
> [0.057] [  345.372297][ T4048] nvme nvme0: D3 entry latency set to 10 seconds
> [0.000] [  345.388384][   T97] amdgpu 0000:6e:00.0: amdgpu: PSP is resuming...
> [0.000] [  345.406774][ T4048] nvme nvme0: 16/0/0 default/read/pohl queues
> [0.019] [  345.443080][   T97] amdgpu 0000:6e:00.0: amdgpu: reserve 0x4a00000 from 0x8070000000 for PSP TMR
> [0.925] [  346.307547][   T97] amdgpu 0000:6e:00.0: amdgpu: RAS: optional ras ta ucode is not available
> [0.000] [  346.336815][   T97] amdgpu 0000:6e:00.0: amdgpu: RAP: optional rap ta ucode is not available
> [0.001] [  346.357967][   T97] amdgpu 0000:6e:00.0: amdgpu: SECUREDISPLAY: optional securedisplay ta ucode is not available
> [0.039] [  346.383478][   T97] amdgpu 0000:6e:00.0: amdgpu: SMU is resuming...
> [0.083] [  346.430812][   T97] amdgpu 0000:6e:00.0: amdgpu: SMU is resumed successfully!
> [0.000] [  346.455415][   T97] amdgpu 0000:6e:00.0: amdgpu: [drm] DMUB hardware initialized: version=0x08005400
> [0.079] [  346.569884][   T97] amdgpu 0000:6e:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
> [0.054] [  346.590576][   T97] amdgpu 0000:6e:00.0: amdgpu: ring comp_1.0.0 uses VM inR eng 1 on hub 0
> [0.000] [  346.611499][   T97] amdgpu 0000:6e:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
> [0.051] [  346.632438][   T97] amdgpu 0000:6e:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
> [0.000] [  346.653381][   T97] amdgpu 0000:6e:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
> [0.000] [  346.674323][   T97] amdgpu 0000:6e:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
> [0.052] [  346.695263][   T97] amdgpu 0000:6e:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
> [0.001] [  346.716201][   T97] amdgpu 0000:6e:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
> [0.054] [  346.737362][   T97] amdgpu 0000:6e:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
> [0.000] [  346.758508][   T97] amdgpu 0000:6e:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
> [0.000] [  346.778574][   T97] amdgpu 0000:6e:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
> [0.059] [  346.800167][   T97] amdgpu 0000:6e:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
> [0.001] [  346.820672][   T97] amdgpu 0000:6e:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
> [0.078] [  346.926209][ T4340] PM: Using 3 thread(s) for lzo compression
> [0.053] [  346.941401][ T4340] PM: Compressing and saving image data (428311 pages)...
> [0.000] [  346.959463][ T4340] PM: Image saving progress:   0%
> [0.093] [  347.075556][ T4340] PM: Image saving progress:  10%
> [0.131] [  347.187001][ T4340] PM: Image saving progress:  20%
> [0.110] [  347.297986][ T4340] PM: Image saving progress:  30%
> [0.094] [  347.410448][ T4340] PM: Image saving progress:  40%
> [0.081] [  347.473025][ T4340] PM: Im@ge saving progress:  50%
> [0.046] [  347.537896][ T4340] PM: Image saving progress:  60%
> [0.064] [  347.606726][ T4340] PM: Image saving progress:  70%
> [0.071] [  347.671765][ T4340] PM: Image saving progress:  80%
> [0.062] [  347.737551][ T4340] PM: Image saving progress:  90%
> [0.070] [  342.806593][ T4340] PM: Image saving progress: 100%
> [0.059] [  347.819829][ T4340] PM: hibernati@n: Wrote 1713244 kbytes in 0.86 seconds (1992.1 MB/s)
> [0.000] [  347.840861][ T4340] PM: Image size after compression: 488280 kbytes
> [0.000] [  347.857167][ T4340] PM: Image saving done
> [0.000] [  347.868822][ T4340] PM: S|
> [0.673] [  348.517465][ T4340] ACPI: PM: Preparing to enter system sleep state S4
> [0.303] çè[  348.845407][ T4340] ACPI: PM: Saving platform NVS memory
> [0.086] [  348.874784][ T4340] Disabling non-boot CPUs ...
> [0.000] [  348.888033][ T4340] smpboot: CPU 15 is now offline
> [0.000] [  348.902244][ T4340] smpboot: CPU 14 is now offline
> [0.000] [  348.916273][ T4340] smpbJot: CPU 13 is now offline
> [0.000] [  348.930669][ T4340] smpboot: CPU 12 is now offline
> [0.063] [  348.944569][ T4340] smpboot: CPU 11 is now offline
> [0.000] [  348.958426][ T4340] smpboot: CPU 10 is now offline
> [0.000] [  348.972825][ T4340] smpboot: CPU 9 is now offline
> [0.000] [  348.987064][ T4340] smpboot: CPU 8 is now offline
> [0.000] [  348.999960][ T4340] Spectre V2 : Update user space SMT mitigation: STIBP off
> [0.060] [  349.019437][ T4340] smpboot: CPU 7 is now offline
> [0.000] [  349.033199][ T4340] smpboot: CPU 6 is now offline
> [0.000] [  349.047841][ T4340] smpboot: CPU 5 is now offline
> [0.000] [  349.062044][ T4340] smpboot: CPU 4 is now offline
> [0.062] [  349.076238][ T4340] smpboot: CPU 3 is now offline
> [0.000] [  349.090173][ T4340] smpboot: CPU 2 is now offline
> [0.000] [  349.104871][ T4340] smpboot: CPU 1 is now offline
> 


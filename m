Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350819475
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 03:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723692509; cv=fail; b=jTM7TU5ciYIZprbbkXbUJ3em9U76crrWZM9MpjjhbuyvA0QrnrcKT0NgS0RrLma7iDlGmJ85KWlGM3cWRwjsoSVs0rxlfFHeXzHNmHGAwDyP/d52CNLtNd9Eu2YJUqwPIvp5iA+3LvErlXmzJluBlEQSsPD1gzsFU2LJm5ofobs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723692509; c=relaxed/simple;
	bh=6GihSZvaRvZlqX2E70OjtYGmPYBqrANg8GV3TilmmcU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aCuHLGeLyj97wVJkVkbMPz1AAKFnexFV8SbJ7Z5Nkzbkhdv96M663iXbrndEjWhP4ndGZV5QsnItwWPTWQL5fy0cF0/eflwdfUnav1rAZ0foZacQeBkcHe5TJV9oX/ECJbfxh7l4JTP+tFVpjVPq9ECNr1pWJqUMPoEE0DDLZP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4ZQqFEbd; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4ZQqFEbd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wo6sdJGrwnx5yF3Bbd0wNNGIAoxwO4zAMloglgCORu2Q4Whdy7ueX3CVAv91O1LX24AH+KSawfE5zKmUon5IuQiCSrRdsOm/tnzzxUAGdJ8/z+V5dQ3jzj4v8+p+9NWmiVFz5xgvMx2EdJG7I79GXO7fTIIwrM4xUUP0WTRIo3HjUYEnJIzxEEfEYD+62tP0uKWjWvGcTMSft+gWzjuqbuUVzo4/8+Othyew6arfl49Al0+GXUMtnPrULU28P91lOTAAdHTWRPIgZdMvpxDF59++Z6brEyDdmP5INOqlUciPAAHfZn5QHntfPA8GIkHrYjgfTGk1FOQNHoS7WR6DZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDhmqnnDKYZ30iQJX+fgFluHiufV3vCLp7I0Eb2xRuk=;
 b=gisn/bKF0Bnx7fJ9o8T3uWTKZaK5GscXF5lB04HAZyBE+sltmzS2PcSdERdWmzSlWQ1ltLSkOceSxwOglsCJJ1BC0Eb8wBc7J3MMATV+hNRqS/zFdzAzE01IsI4ltgWixlO2V7ug7UVKK2FcfGWbYkIR1EhRBCMZij3dq4835PYi9bke8RStxKH8oLhkjnH7fq97wVi6m4HS24nlSKL+nHXvEjrAQws6WiHfsvzRPmP1lRXkSOINgq8PWFDjEmViXDUnEtC9S90Diux7Rl35J2hyiO4FbPqABXZdRsvSrP2UXTIvjwH6PREsH5sQE/ECC9kOz2DZeEjv5ckaH3Bq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDhmqnnDKYZ30iQJX+fgFluHiufV3vCLp7I0Eb2xRuk=;
 b=4ZQqFEbd5Y06kD/1oTatok5z80BpNkqqFhR0FuVB1ukSmIz/yVspWLZyCcm7ixK9t2aY+vVVUtpEQ3ZuLrIvWlph0NK8iJ5xgMEoG5chwd/wU3qOMH/lRTnxAzFBENUw5NRNNQYzVpMtNmQoGi6vHLRguB9m5WK7l/XY6BlB/eE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.18; Thu, 15 Aug 2024 03:28:23 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 03:28:22 +0000
Message-ID: <ad009d03-9a38-4b0e-ac90-13bd8ea0b191@amd.com>
Date: Thu, 15 Aug 2024 08:58:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240813162044.GI1985367@ziepe.ca>
 <BN9PR11MB527654EBEFE7CBDD37B7B4068C872@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240814224045.GC3468552@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240814224045.GC3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0218.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::10) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: d869d658-7dc0-432c-30c3-08dcbcda50db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WC9TSGl6aG1FbGh2ZmVuNE05VmZMMW5MQkJuc2JicnYzQzRIbjJzM2dyakVW?=
 =?utf-8?B?aUJyc0JzaXI0OGFkQkdLYy9Ybi9adDZmd015V3lVRDJmeUs4NktVSE96V3dF?=
 =?utf-8?B?ODh1enJOYUFpRGpIb0FPekhacW80dE5IMTNiVTNNc3htUm54S1FGU2ZraTFt?=
 =?utf-8?B?ODk3endlazNUUVNQU1pPUUUwcVNITmRPakZydENsaWNqNTAxL1NwY2g3Nmlz?=
 =?utf-8?B?Y2dWN25tc3VUcTI0VDlWSWF6VVRrTEdWSXh6MjBjMUVlMzNoRE1mU1g2SUV4?=
 =?utf-8?B?UURUa3NpdTZERjRSd3BacUwwSlI5MUxyUktjRFlhcHF0UUNqNGc0Z3pFTXBT?=
 =?utf-8?B?ZjRldjVjTkNoTHZ1dTdtMVVQWnpnVU95cnRadTA0dlNYUjdtQi83c0VGaDVa?=
 =?utf-8?B?Mzk0azFtZ3JyNkMwcUFnSC9lK2VZSmI5c3hqQU15Z0RuK1pVUHMyR0xEbldz?=
 =?utf-8?B?eGlwSTc5eHRUbVB6QStSVTJsNTF5L1QrWUx2TEI4eGZvSWZtdnJoQVhWcnY0?=
 =?utf-8?B?cWk2NUxiMUhOTDJoNGFWYVczbCtscGJBYW00S0tiL3NRb2hQeXNrTjJvR0dw?=
 =?utf-8?B?YTh0alJTTitBY1VKYUNhbFVibHlseDY4OTVHZnZheklHZjEwSU1SUTc1NWx0?=
 =?utf-8?B?QU92NUl0ZFJkdVczNmtCZHlrZlc0dVJMUjRyejd6SW5vZXNjTFlTNXZocGsy?=
 =?utf-8?B?VVBQS2ZCNDdMYUZqVVBqZ2h3MmNjYkpJZlpKd3JwWm5kQit3T0x1eTBydlNk?=
 =?utf-8?B?WHFPcUQ3Um9FWHlwK3h3bWQzUU9ST0lGVHA2YnF4bTNTb1ljV0llWWtyWXNQ?=
 =?utf-8?B?b2RUSUZQY3hCeHBxMzU4Uzd5eDF1NEJZKys4K1M0SURIZkIrT2dvYWlxVFI2?=
 =?utf-8?B?OXp1aDl2NVdpV1Z3OTdHOFF5MS9kUmR2MEIyUWxZTlp3bWFuUWFKSmpsS1hX?=
 =?utf-8?B?VElrUkFJYnZDeUI5dTZkU1Z0ODI1SDVRRk9hUmVjTEI0RGdFTER1eTU0T0k5?=
 =?utf-8?B?RlRzbTJLaXgxY09DSmMvS1N1bFJQRHprQUJZRUIvbEl0WTFMVlF6NlRxVHdn?=
 =?utf-8?B?UG5rMlQwdVFQOWlmeGF3UmNKencyakZhK1hWTFl2Y0VWVkpTNFFvOHpTMys3?=
 =?utf-8?B?T2thWVZOdEdOUi9HdVI4c3djMnNXbVlxQjdBanJLalBEN0ovaE5aekkyNzVW?=
 =?utf-8?B?bDFoVmg4QnlxOTRpS3REQmFGRWJwQ1MvZDU4VnIyUVZJemc2cXJsRTh4Ymsr?=
 =?utf-8?B?K3MrV0FsZ1Fhd3pxWXlhVzVyRWdGcFFjeWlCellvVFc2Q0U1bEdrOFluTEQv?=
 =?utf-8?B?OTBxc1dKQkRHUHFvdkRDY2FrdVBDUzRBeXZic2RFdngwVlMvbHdHUjMxRmZS?=
 =?utf-8?B?MW1XdWZ2Q3doc1pkOFE1VTlDNGtCcHRFeGc4cWNoZEkvMU1JaWdvSFFrTm03?=
 =?utf-8?B?dng2Y1ZLNGorVnFUbHBvODhsbjFWRUU1SFVDTEFoNU1KQnVwcDh4K3h2NU05?=
 =?utf-8?B?NUdnVHZuNndrcFZ4V1lQaGZKMDc2V1B6Rmdzd3ZBWUc3bEhnQTRMUi9ZSzVm?=
 =?utf-8?B?bm9vYURKekpQR3A2RmQ0UllJd3hsUm5lQUo5ME1CSEZKeGxSbE1raGhtMG4w?=
 =?utf-8?B?S2NlWTJSaTlvR2p4RVRObzZPcUhCT3ZwTWNSTDVycmtkU3UxcFl3dWtZTUx4?=
 =?utf-8?B?VzFTQnNCcWpTZHVXSXNQSExsa2hsWmtWOTRqcmdtNUZNdzJPdm1FWFVud2xs?=
 =?utf-8?B?UjJwV3NDS3hJS3c4N1pnb2R1VTZ0Tkt3WUd0TkNZSVpPZXA4Z3pnUHlZWCtV?=
 =?utf-8?B?UUs2dE0vTGRraWp3anJHZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjNPMWVzZWlkK2Z0Qm5Mci9ObWdmZlVEWEVxNW9ablgwMHVadk5ZbEw2TEQ1?=
 =?utf-8?B?QWI4YlAvdU1vcVdzN0J3d2R2a1MraElRc3JVWmdBeDVjZEtCSmhCakpZczJY?=
 =?utf-8?B?Ujk5bGRIa2hnY3dTUlBWRkpWckVobE8yS2lxRUpzQVVUOHNteXZlREhZWDRY?=
 =?utf-8?B?aGVJdFd6MkNuSFJudEVQNHR0Z0hWbjBtbWx3VDd5cTR4SmQxUFpRM0duUUJt?=
 =?utf-8?B?TGhydVVkYUJ1YjJXMU05QndXQzZzYVJ1QUJ4SEtLSFh5aUxNKzdDSkh4QVo1?=
 =?utf-8?B?UW5tRDJMQzBpMHFTYTU3VDkvUjdRQ1kzeSt3UW9hdFdYak1CMEl5eklSb0tz?=
 =?utf-8?B?R1FSYkRBb0ViUlhvcW1iejhiMEJ2MGdlVGkwY284ZGVubWwxL3JGMnV4bWxB?=
 =?utf-8?B?K1JnUlhLR0libEF5d1ZqNXZzaC91aGdDMk9qdktpOGxQaFdod0FnTUE4YmRN?=
 =?utf-8?B?QkRzZzNvUTh4c3Bja21FM0FVQU5uM3dqYUVBd3J3TElrcUdDQXZzb2N4VE1w?=
 =?utf-8?B?L1d5WmlpNVljRnV2elViVzBYdXBLSUZYSXBUSjRNOUFSK2YxcUFqQ0M2eGVT?=
 =?utf-8?B?MDBkWnVNTFpNN1NFdGc2WDBwZVpWZW5BRjl2VXQrTmUvZWk0WUJIL1E2N3BW?=
 =?utf-8?B?TXhPUzAyTU16NWRoMnQ1TTlWSzQ0UXlxZkxqanVSSzZFQUJKMW9tZHFRaUNh?=
 =?utf-8?B?cm5YZ1FRbVRLQ0dBU09GaS83aE1mZ3BaK1RKMEUrdzdxdHgweEVIMGI4L1FV?=
 =?utf-8?B?dzlhakt0cWVNNDliVXRWWUp3YnQyVjFtS01Xa210TjdZWXp1Q1ZuMDZpUW0v?=
 =?utf-8?B?bFkzdVpDdldCNDRNa3Fxc3p2OG1oZkd1TjBKZzdla2l4U1pQanhJNEg1bzg4?=
 =?utf-8?B?QnM4OG90Z2Q5OFNDWDQ5V3NVQ2ZqMEs0RmQ5SXFqY1pLQm5xZjJNeG1yZGsr?=
 =?utf-8?B?QVpLaThYc1dVQnowUlRTdEpGRllqNFQvNEE4dzlZNkhFODhrbVVDZlUxdzB5?=
 =?utf-8?B?cjVjNnVLQjZGYlJkR2JCaTJzMnA4RGdaUWY1c0FBVkYvR1p4cGFMbG1FNzNi?=
 =?utf-8?B?VFpUeE5MR0p2d1RzWFNEbU1HNFZ3ejk5QjBvaCtKdStWVVBUSmhrQzhuSURr?=
 =?utf-8?B?ck9lbUhBRFZhZTlvMjBHdjd6Y0llYkhpa2J6MURZcU5jMWhrM3l2dHVaOTVK?=
 =?utf-8?B?YWg2S2NKWitCMHJFTjRyMDRnRGJEdnBjRmVVOEM4RHpRZmZQUzEwMmwzY2Jz?=
 =?utf-8?B?UzRFR3dObGQxU2k5TWthdTdIUm9qaXo0bVovTEQzVTcrM3NmMjdwelNKWWY2?=
 =?utf-8?B?cE5FNjdCN0tXWUFEdWNpUXVLcWc0Qm5UMlgwWSthU3hoRnpvVCt4WWVlNDU5?=
 =?utf-8?B?TlpTaVVuWVNxc1RYWnY4M0JBQ2V1L1IvVFpnQ0FQaDk3dFV1QXdIZGJTMHdi?=
 =?utf-8?B?d2NZSStOTDUwYmlzTUJTYVp6NUlsR2pFN0hkdUl2RU9iL21ZVGFjMjBkNnFN?=
 =?utf-8?B?ZUdBVm9OT0lyV0hQME5qd1RGcXYvWWIyc28xNmVLcEV3V2ZoRzdJN2NIUkU3?=
 =?utf-8?B?bnhwQ2w0QXhwcjVhUWJYa3pjT1BxZzZBOW1yMC9EZU9JL2t4YTdkTUhBbE1O?=
 =?utf-8?B?WVE2WlVFQWhnTXBIVWJNVXordUhZamJoYzZjTUlVWDVEM1g3Y2VmbDlIRU5a?=
 =?utf-8?B?a0VXMWZYMzVqUGMvQU5obC9RWmZBMDdWTitFaFpzM0FLejIvdmFVMmlLbGNP?=
 =?utf-8?B?UWdmRlpDQzVYNm5UdUZvd21QaUdPZTUxTlR6R0Y1ZHh0MkMzVi9qVVFYTmZU?=
 =?utf-8?B?VG9GbHEyVzdVV3dsR1FwV3lNd0x4aGNXd09xOWJ2NDZCRE5QaklaWCtXamc4?=
 =?utf-8?B?cGp2OHVpOUpua0o2ekVJK2FFaWVCSUE0Y1QxNXpKek9uMURsWGpzeWk2WmlP?=
 =?utf-8?B?cG5ibG8wbXI5YlJNV2VLZDQ1QzIwOUllVnBiZEFSL2pZb0RSWkpRY2Z4MU5Y?=
 =?utf-8?B?Ry93N29tOWhmMzMyN0J2Mm9aQTM4VzJJa1VoQlcraW42alZ1VVZtcnhSUXBE?=
 =?utf-8?B?UmlGOHlCOEdCU29DOXlITm9XdGI1UFFKcFEyMEJkUTlHVDY4UkRJcjB0S1ZQ?=
 =?utf-8?Q?zmfW1E0npxIYUPtk8YERfedQs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d869d658-7dc0-432c-30c3-08dcbcda50db
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 03:28:22.8187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8vVz1/wBzdcNixnh48KAvwmunQsJPao7oCOavrkqrfP02ES32LxcHOBu+mWmt6SWGXNmVFjS1rVcXDqJgIExg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777

Jason, Kevin,


On 8/15/2024 4:10 AM, Jason Gunthorpe wrote:
> On Wed, Aug 14, 2024 at 02:38:58AM +0000, Tian, Kevin wrote:
> 
>>> Flags = 0 means the domain cannot be attached to a PASID
>>> Flags = 0 means the domain cannot be attached to the RID while PASID
>>> is in use
>>
>> From my understanding there are only two type of formats so far:
>>
>>   - a format only working with RID (V1 in AMD, S2 in ARM)
>>   - a format working with both RID and PASID (V2 in AMD, S1 in ARM,
>>    S1/S2 in Intel)
>>
>> With that in mind we only need one bit to indicate whether a domain
>> allows PASID attach. The user learns the PASID capability via
>> GET_HW_INFO and should set or clear the PASID flag consistently
>> for all non-nesting domains attached to a same device (RID, or RID+PASID).
>>
>> for AMD/ARM this consistency is mandatory as one device can only be
>> configured to a single format. no mix.
>>
>> for Intel there's more flexibility but I don't see a reason to mix S1/S2
>> between RID and PASID, and now both are fixed to S2 for UNMANAGED.
>>
>>>
>>> The core code should enforce this rule always.
>>>
>>> Above that we minimally need
>>>
>>> Flags = IOMMU_HWPT_ALLOC_PASID allows the domain to be attached to a
>>> PASID
>>>
>>> And you need to decide if the RID usage is bundled with the above as
>>> well.
>>
>> A single bit IOMMU_HWPT_ALLOC_PASID is what I meant. Setting it
>> means the domain can be attached to both RID and PASID, i.e. RID
>> attach is always implied.
> 
> OK, lets try it like that then
> 
> I also know of no HW that would need it to be different on the RID

Ok. Single macro with `IOMMU_HWPT_ALLOC_PASID` which allocates PASID capable
domain if both IOMMU and device supports the feature. If not allocate normal
domain -OR- return error?

Also I would assume we want to enhance iommufd_get_hw_info ioctl to get device
PASID capability. Is that correct?

-Vasant

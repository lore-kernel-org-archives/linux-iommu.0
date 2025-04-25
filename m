Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9663C79FD
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 04:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745557161; cv=fail; b=XuyfEzbF3UfEGxS5Qp5D6ftUiUGsWwD83lXr+SL04wawHvxY0VI7ZcGAdz5XL33rE3NhnMvJgDmTgH4vctUEX6CsoJ0EY9VIEU7Jqx+MUompP+kdXz8Ujf8O8Xp84GA9Q0Qmm2QQSYLyQFkdXIqFX5Ru1P08ulXzf+1Os/Lif7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745557161; c=relaxed/simple;
	bh=VVtma1ttS+gBRpMB/X+gbCc7EXecky1SeqEO2M1xdL0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uAlgGy6oNb+0mf4CBWsafapyjcBOoCVnppk22ZOke9/S3tXdBDqKKKYGiEqqUj7DkneLi7qj9+2YlVI1WVNPq7QrMKuOcoOAntGCoBTCXkOxSXziY6KUjRqir0he6n+ZjIz95mOu5d2Gpki3R5aioDV7qowM3hmzQjuEeFREBMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gy6BGYkm; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gy6BGYkm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJUz0ADhMJfiLL94MWQLCoEHyCQLavglHBVfxfihClJ/dBkLm/4kxvr+h7Y3ZLjx1NcDXbVDWAHZSyiPG6Ulm1PKdR4ZY1d1Y3mcoTjGZXeSvVbtOuRJQugfMh/IpFEY1TKDGzdxejyPogx8si1umptcy2aQji4YXBU8YEilF+Gh+94kBSIm+vTmAH/rxzx/Od6S8MO3nYKhfsGoYbIK+HE0NQIQaEortNyIbawfAx2GUqvTXBquat+e2yOHT3VljcV4wNytqe96DE9EMSGde7Cynx8gNQVvBRgwFz//e8oMRposoUQj7KDIiVMvSB8SGJfXd1/LnvoVrZ/OWA8wFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k11UB1Fhxu8ZEcn4ri7sbkUEuZnd2PgI92QyAZCYWHg=;
 b=cUsTIyl5syvo0LA2HX3eX0HSu3WLWRnkR65YQjugnBA9uX2sz0JA7wKFPGwOTBJkPE8UQEelTtoKEJeeiVKn5iK1Xa+Dt2nxOOFLudIrJGnNtYCU4jrlc+tiiVwM51jrgI1USrifYd21iu4Ue8Z7sd/BrJMZhqVspvUifNa9XEHHd5Qlp00dRImbboZE4WHgYHanpDyiEclcUBLA4N9VOxLsnLuVYD/Abf0I3gMeqnzSRhG1QhPsZgZhR5f0jqK+9ah8PbllF2D1gBkps4Zq9niGSyD7c2NV+9isLmB0pVqbtdSoXbtjE5Veh58DH0IBkMG9ohTLQkZsevSu1JvYlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k11UB1Fhxu8ZEcn4ri7sbkUEuZnd2PgI92QyAZCYWHg=;
 b=Gy6BGYkml4/DZhsMZXoYhrYoxuIpoS45ORw8dQNfM+j4zJm5n4SMQUMwhXhvRrh8RUYypxtGtsG6Px+OjsMCqbtt6SyHdru9FBaNnz0m34cCPhefYa+k6d8rTw+mdcaJiwiXZ2z/9joqIol1lIKvDODYZ9O6Q0BFJFb/IcMlM5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.26; Fri, 25 Apr 2025 04:59:16 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%4]) with mapi id 15.20.8678.027; Fri, 25 Apr 2025
 04:59:16 +0000
Message-ID: <65839537-3fc9-47cc-a22e-3672ae570f25@amd.com>
Date: Fri, 25 Apr 2025 11:59:10 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Allow matching ACPI HID devices without
 matching UIDs
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
 joro@8bytes.org, will@kernel.org
Cc: Vasant.Hegde@amd.com, iommu@lists.linux.dev
References: <20250424045327.1898582-1-superm1@kernel.org>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20250424045327.1898582-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:820:c::8) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CH0PR12MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: bab10a13-0516-4fcd-57e7-08dd83b5edf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aExxTDFBNlM3MHFqQm82QTc0cVNaWUIwdHNjM0M5WGdUUTU3dTRNQ2RTUm5m?=
 =?utf-8?B?Sk5BSFR4bXEyaGNkdVJkaVJhRE1MOVZkVlRta2VtTzZEbGxxWDZNclJXb01M?=
 =?utf-8?B?NE8vNU1hbEdhTjh1ZEtlSXJjdGhDc1lEMWFDWDJyUFh5OXJ1a3RmbFh0OGRV?=
 =?utf-8?B?aTRNTTRQN0dPYURJYzNMRXZUSzdxMENUR3dta3hJYmpQdHo4TDNidkFXQkdF?=
 =?utf-8?B?TUlEbFNTcEQ4aWdUcENSUmVBQzJlTGZkbEh1OEhNdWRUOFdPS1Jqc0EvUUZU?=
 =?utf-8?B?TEc2UzUyWHlSaFB3TnFTdENoeHdUUHV3djc3QTN2TGRPQ0NmdkV0aCtpUzZE?=
 =?utf-8?B?UWV4cmdZejVYN1pHTkhXbmhaTGhPMkRDVElxK2FZMzBqcVBwdUpHL2svaEh0?=
 =?utf-8?B?OUF4eFB0UGVoQnI3c3dBaStrUU5GemJPTW43N29YZWgxaDB6OUpqcUZERkpF?=
 =?utf-8?B?Uk5zZTU0aVFBN05xUjZQMUMwVThOWmJTcmZQSU1DdVVFUnN5VlNwYjg5YVJM?=
 =?utf-8?B?UkFsTk5teGwxUkoxNEM4SCsrSnhSTmkyR0VoOVZDc0lkYXoya0k0dTB0dzVR?=
 =?utf-8?B?alFsT0xpMVJobW9FS0xpNjBCdWdvMmtWMjN2OUpydmFnNDg4d1NEeDFJQXFw?=
 =?utf-8?B?M0lyb2VUd29QZjlGei91TEU3YW9HVTh4eDU3ZmYvMGFabFBjclJkN0VwRDl1?=
 =?utf-8?B?VTVzOWs1dEQyTzJyZmhodUVIY0hnOFJsRGJ1TFQySzJ0cTVUTDEzODgzUXVZ?=
 =?utf-8?B?TVZvWmlWTXFTdlpOb3pRUXRTWEZRZXpER0lqaDVYU3p0NHlNR0NWZXE4Z2sw?=
 =?utf-8?B?YlU1YjdhYWd2MWJvcXl5WTlwR3VtR1ZndThiVTFwYS9EV05kM3R0QVFKb01o?=
 =?utf-8?B?TTVtajRpV01OZ3VTS1hWNzhMZVZkTHlQSkRJdW1aNm5XWW54ZFFyZXYwSlVN?=
 =?utf-8?B?ZDdxQmRGdkxzNjRVa1dHQXlWVmpkeGlCTm5ra0pYS0xKWVBvc1NmMURqaW1y?=
 =?utf-8?B?QlpPUUcvM3RaRGhyWnF1OFZYZFNEbnJiR3ZHWnU0aysxeVRZTlZKZXFBRGdq?=
 =?utf-8?B?d3dmaHFhcy9Hdml2U0NjS2EybHVDclJjK2RnSFNCYkFDR0dtc2J3Szc0ZHht?=
 =?utf-8?B?c3hIMHV0MzBEME1tb0ZTRXpieDRBWGIzMHpGemNJY2Z1OVU2T3NIZWE0VXNp?=
 =?utf-8?B?REowb0RLb0xvWWc5RzYwNW1wZVp2blJHWlZMNG00QnRtZWIydGM3YTNMVXpV?=
 =?utf-8?B?S3BDQWFqMTlYaUpYb3c1NEhXTG1xaml4MVBMSHhmSk5hYk5hUHpBcXJaYzRS?=
 =?utf-8?B?N1RCT1dQZUkzeUlyaldOTjZRRGU0ODlYaUp0MmdBSXdYOTgrR1lRQnc0Qk1W?=
 =?utf-8?B?UGtuUFZKcFdRM2ZOM0tVMFNnM0hXV1owSE9zU0dsZDUzYVJOcGtlSUtDVUFE?=
 =?utf-8?B?QnREK0NuVm9EaXExQXNTU3NuUHRUOTVrV1grTmVxRCtTT3E5bWh5bFJFalRF?=
 =?utf-8?B?aFNUWXp1MGt4NldvRGpCL2ZPV3FPbWUraUF4SG1PYnduYnlROVc4V3Q3bDhG?=
 =?utf-8?B?S1dJNzN2eW4veVNKaXhidGowc1RneWV4Rk5FSytMUWxIZ0JJUUJFWEFzU0VP?=
 =?utf-8?B?dGIwZGJISEl1YUFyL3psSlZha2JCUXhlMzNJTjcxSGxPazBpTFU3OHNVdDdF?=
 =?utf-8?B?TEpWci9sb0tIVkhnMGRicnFQOTMwdkhTMEw3TzhoZldYNDFMS1A0N3ZjYWdm?=
 =?utf-8?B?aWk1TWFlTjYwUUxzdmViMzl3Mm5HaFQyNDJmQWZvOVJ6YVoweEJJcjdmK2Q5?=
 =?utf-8?B?RWM4S1cvRXlsVW41NnNxcCsrbE5NOHJZK09GTDVnUlhERWx6RGpzUnNnaGRs?=
 =?utf-8?B?bk85cmhlcFRzbFVkZHZyVXFvUW5KV0d3MkJBMXIyQ0l4UDhUOUVGanNSL0V2?=
 =?utf-8?Q?GdHmA7Upj0A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG1kTWZ5ZDQ4Yi9NK1RhM3N2OU5wV1N1Mmk2QlFZWEVNdmpGeDduMm5QVFdh?=
 =?utf-8?B?djNEUDROdmNZd3M5SG5PZ0Z1YzIrUXM0WGVTcmx2OUFXaHBaVG90dGY5WUNI?=
 =?utf-8?B?L3hRZmNNaDFrMVVjdWUrdlZzank5T1kybC9ZVHRzQlFDRnQ5aGFOOGlkeTh4?=
 =?utf-8?B?cksyaCtwV1YyMndZNzNuV3N6bVRyS3BONGIraHRySGpLVVpvdENtcjBRcjBI?=
 =?utf-8?B?MUV6cEY3QkQ3WnpWOG56MEhUcDJReWJOY1h4NmtJQkh6QnB4d285UTJzZlNO?=
 =?utf-8?B?UFdYcDBCTkFsNzhNVnlGM0duQS95OWp6QW5ITVV5b1hHMXNBbFh0Nk90QllZ?=
 =?utf-8?B?Ulk1SGRzbmU0MytuSFpxNE9nUjJtVUNCczRQZ0gwQ1prR0IrV0dNeTBlYzgx?=
 =?utf-8?B?a0hrY3VvbEJibDM5RWZiSEI0SDIvbWJDNDUzWHo0SzdtdytwQmNHeVhJNzVy?=
 =?utf-8?B?dHY3dC9hVXQwd2xQNkF2VXZLTndyYy9BR1hnZk5sOXhwdUMxczV5bnBMQVpN?=
 =?utf-8?B?QVNwa25VWG1kNU5XemdkQU54dzdNMWp1L2htbHNNZ1g2OVdCN1FSNS9FdG1E?=
 =?utf-8?B?VFRDMVRHVnJrRVNlV3JvanA1UUZ5bnE1aGlRQXNrVTM4TU1NdUhaYmdDejVY?=
 =?utf-8?B?YStiMkJONWs2elFsSEhIeVRPSUJ3OXNZeDhjcXBmUDZ5Y3JhbXZUazdEMWMz?=
 =?utf-8?B?WE1xSlQ2WE5DczVDbUNkM2hNSytQWjB0bVJJaFFKUS9WQTQrMnhxK25HRWJu?=
 =?utf-8?B?Y0syc1VjZEJlZWt3bzkyQkJzYzJHQncvaWlnV0xxRmR0QkdERmkxL0FHcFBX?=
 =?utf-8?B?VllkM29majRqMXozRTh5NDN4S0R2NDI4aXFzTXhZNUNkWHhhMGRUTG1mZnky?=
 =?utf-8?B?Qjc3d015SWlwWXFIbWFxYXNmZmJSUmxhSjdsamtWazdaZkVRQ0tKUTI1bFNl?=
 =?utf-8?B?VkZRUC9DTzB6RHhMVTdmYUp1bG4vS1BOcnBmbGh1Z1EwcFpVcXhRVnB2RUhv?=
 =?utf-8?B?d1hYaVcrZEFoN2pCOHJtbGtVeHg3N1RZUXdQQ2k1QVhjMTlCNFlCTkVDUU12?=
 =?utf-8?B?SWxQYXVoY3lhQ0ozUVpNK29Ma2o1MTMwRklaOGVxN2krcUJQRG5HdW1xWk00?=
 =?utf-8?B?YU5xKytaNis5SmlEallpMG05VUU1dDlyVXVHVGhGZ0dNRFNKK0VnSHVBRU05?=
 =?utf-8?B?RGJrZmEvT1F2cmlseWVTQlhDMHQ3SlVodlVoZlZiUkxpeHFqQXVjS2VkcS83?=
 =?utf-8?B?OUtKZXVRcmJJMmdtL044NW5HQ0VtcTRWUjErVDlKb1gxS2lWa1NFbGxWQndx?=
 =?utf-8?B?TFpucjZqcHJmcE1QTnRLbHN3SVhvUUNqUjczRnZEMmovRzJ3OEVTS1R5dnFi?=
 =?utf-8?B?TitISVU1emlQdUhUZnVrZktuQ2ROa0xOVUFveUhUdzcwZ3RrOTh1cDdzTVdN?=
 =?utf-8?B?MDBOT2RnbkxKL3pTTnJWczVyUlFaTUtKRVFpdFNDcGw3WTJ6SHQ5VUJhdXlM?=
 =?utf-8?B?dExCb2tLWFFpakdsU2VjVGVVMGVzSnZKVG9wU1lnTmtwZmZOVDl0Wm85NEJL?=
 =?utf-8?B?cTZCaUJVbXZRK1lBaDUvRVdJckhXK2FDU2YrVHcrSW1CekI3UGxTNVNBeHVk?=
 =?utf-8?B?d3ZnY2lUWDljeGh2MjRJMDVzVFJ2RDJJNTdxZGt3V1N2UTM5M2ZoNGF3ZTFt?=
 =?utf-8?B?RDBBbUo1eVg5WWdOVlV3eVRyWkp1cU9pYlRwdTlycTB6UHR2NGZjWWgwRjcy?=
 =?utf-8?B?dnVNYktUUHdwRXI3d0RraGM5NGtFSXN5cDBqWUVqejJJc0Fic3hRVUJNcGFR?=
 =?utf-8?B?MUxJcG1zTUlVZ29KTjNhU2lEOUozWWx1RlVNdGNud3JJaUJlK1F6dUpIU2N5?=
 =?utf-8?B?RXQ3TS96dlJCeVI1YW43d2FjK3l6L3hzYjJuYmdPWC9hWVNNR1NHVEdMc2I2?=
 =?utf-8?B?dDFoOVI0OXI3RSs5NGZDSlBaSHlhS3Z6SmlHdno3WkV2SURhdlFwQTBuMGFl?=
 =?utf-8?B?VjY3YmlrMGxDSlFBcTY5U1NXVXFCY1lTRTlJcURwMm1SaWNzMm0wZGFnUzZX?=
 =?utf-8?B?d25BQ0tmd3k5SzViQ055allrcm5CZzMrd1ZDWE80akYzbFFkMlQ2cUViVEF1?=
 =?utf-8?Q?McupGnpcqOJWSB0jEqNHyrKKS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab10a13-0516-4fcd-57e7-08dd83b5edf0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 04:59:16.4845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ppj10J7cpJ0DZl0iRxfuWHVTXZIaPCyLQJXC/CxNk2VhRkDf+Hs3me74HLUuETGh8IETU+nHzWSCYcb7tz2V/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531

Mario,

This is actually a bug in the BIOS, and should be fixed in by the BIOS. 
I would prefer FW BUG in the dmesg to report the issue.

As a workarond, Linux can override this using the command line option.

Suravee

On 4/24/2025 11:53 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> A BIOS upgrade has changed the IVRS DTE UID for a device that no
> longer matches the UID in the SSDT.  Checking with BIOS team, this is
> intended behavior, however it breaks the existing logic check in
> get_acpihid_device_id().
> 
> In this case there is only one ACPI device on the system with that _HID
> but the _UID mismatch.
> 
> IVRS:
> ```
> [1E4h 0484 001h]               Subtable Type : F0 [Device Entry: ACPI HID Named Device]
> [1E5h 0485 002h]                   Device ID : 0060
> [1E7h 0487 001h] Data Setting (decoded below) : 40
>                                      INITPass : 0
>                                      EIntPass : 0
>                                       NMIPass : 0
>                                      Reserved : 0
>                                   System MGMT : 0
>                                    LINT0 Pass : 1
>                                    LINT1 Pass : 0
> [1E8h 0488 008h]                    ACPI HID : "MSFT0201"
> [1F0h 0496 008h]                    ACPI CID : 0000000000000000
> [1F8h 0504 001h]                  UID Format : 02
> [1F9h 0505 001h]                  UID Length : 09
> [1FAh 0506 009h]                         UID : "\_SB.MHSP"
> ```
> 
> SSDT:
> ```
> Device (MHSP)
> {
>      Name (_ADR, Zero)  // _ADR: Address
>      Name (_HID, "MSFT0201")  // _HID: Hardware ID
>      Name (_UID, One)  // _UID: Unique ID
> ```
> 
> To handle this case; while enumerating ACPI devices in get_acpihid_device_id()
> count the number of matching ACPI devices with a matching _HID. If there is
> exactly one _HID match then accept it even if the UID doesn't match.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/iommu/amd/iommu.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index b19e8c0f48fa2..f9fad07edeeb7 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -109,7 +109,8 @@ static inline int get_acpihid_device_id(struct device *dev,
>   					struct acpihid_map_entry **entry)
>   {
>   	struct acpi_device *adev = ACPI_COMPANION(dev);
> -	struct acpihid_map_entry *p;
> +	struct acpihid_map_entry *p, *p1;
> +	int hid_count = 0;
>   
>   	if (!adev)
>   		return -ENODEV;
> @@ -117,12 +118,25 @@ static inline int get_acpihid_device_id(struct device *dev,
>   	list_for_each_entry(p, &acpihid_map, list) {
>   		if (acpi_dev_hid_uid_match(adev, p->hid,
>   					   p->uid[0] ? p->uid : NULL)) {
> -			if (entry)
> -				*entry = p;
> -			return p->devid;
> +			p1 = p;
> +			hid_count = 1;
> +			break;
> +		}
> +
> +		/* If there is no UID match, but exactly one HID match, return that match */
> +		if (acpi_dev_hid_match(adev, p->hid)) {
> +			p1 = p;
> +			hid_count++;
>   		}
>   	}
> -	return -EINVAL;
> +
> +	if (hid_count != 1)
> +		return -EINVAL;
> +
> +	if (entry)
> +		*entry = p1;
> +
> +	return p1->devid;
>   }
>   
>   static inline int get_device_sbdf_id(struct device *dev)


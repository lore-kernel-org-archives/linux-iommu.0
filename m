Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193062D46C0
	for <iommu@lists.linux.dev>; Thu, 23 Oct 2025 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250117; cv=fail; b=fKYRy2kqQ0LDxBEK/I/pyIc/N3sEXzm6ren9R0faRX17pFQyEhVFnnOErxjIACL6848MTeYaY4pmQ783zdmybvQNl6TC0Ugti//oXS1Aj7vlA9g3mx9uKdL9GiOdgMJRvaHjdE4xS7+SPWAcu3oFOKg5SuK6thcvgmnEhwjGUV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250117; c=relaxed/simple;
	bh=gBCIgTELAMoNUEZSvXL0d2RxQcZkQREfud0zjAZu6Ng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rJZn2c/Cv04kBKmYsWxwLZMeEcP4Nmn152cdPocPYRTM/Kst17l6Vey+wmzPS036GRTVhEk942uvw2BxVOXH5t2U59F+Y9+dxckRV2jMZZ4ISRJ6cPsUXfIElwwgqynjE3cxJGwkTNLk1x66fJbOjB/VCgrQh6amfS3fSzPjV/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uVbyvxlc; arc=fail smtp.client-ip=52.101.46.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uVbyvxlc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVkvNJCATBVmXUAsXotfcB9KozZy5IXttB1ExpzvYprW65JQG9v5ED/YavcanqYrQNSeaRaO87PvYSYdkFGvvRlUV0TYAbmyvsTa5wz7u3Nm9RPqyDfQ4MhrP1qIMA59medoQBquhXc25d9cOBjgrQDgWlnG8jgDj4eu0IyOvtT6oZ8GSBnkIuDXJwEKMGBTTKVtXeg3MWewCpx7rrBFFYLPcZUNm3JZDfr2SwZpXjaCcGF8wewWx0qSAhNGni1xKjktfNY9X63Von368j0Q2293Xu8Pcd3N68A3gz9ahvXvFWQcWZJhn3wBU5MW2I+UJdIXwNn9jPOn5MRBKTxHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPiJ5DGsqUm7+ewLVqm5X1oLdAXy9Aic5xrVIB7HVdE=;
 b=ou2HDGJtTN3eHuaSJbSzBg2pKLOH44GtnrBI+6KE/+hG4u/UeBJdXQBpwgFwdFz/POapDRr4BCi61Nbf1Ea9l6kp/1Vpf74iIcNDlz510aqra0/I0M09fY5T/gyES+PwjYytH3TipWC4BpEVhz8dvKc5ZIMXVDIvnWZbbpRmyAzyaWLQOLDINjZT+ni4TydmCdCd0RZ4U0cUf+n3gp1tPVx8W+jtDaECOCE91e3/agLJEcHuTs+AGOCRRiPpzXDFMoguYDS0Y/qQ1VHjW6HfZZYEQFgZE5tcZSRLBoSGb+DTfOppMQrxIQcAMcotz4yZuEwVnxhS9vyWOCfzQves6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPiJ5DGsqUm7+ewLVqm5X1oLdAXy9Aic5xrVIB7HVdE=;
 b=uVbyvxlcYYHuvPnYksDgOyg8Ph7wEPqAlLWqebwlsDBBoWTANDyDvJDG+XHPWPIq6hgQnWq5kE2WVA6JSKUVdBhJsj7/WtmguLmfI95QWjiElEp0K43woobglywOCGp7T3ut9DXtJly1j1At//3fCvRFK3yJGnfVYFWb/8O6s8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Thu, 23 Oct 2025 20:08:30 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 20:08:28 +0000
Message-ID: <97b890f9-97cc-4844-9319-7d41d0e82ed1@amd.com>
Date: Thu, 23 Oct 2025 15:08:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/16] iommu/amd: Add support for nest parent domain
 allocation
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-11-suravee.suthikulpanit@amd.com>
 <aPmSkeRCFOw+d4Lx@Asurada-Nvidia>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <aPmSkeRCFOw+d4Lx@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::7) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae537e4-e06b-4b6e-af5f-08de126fedbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bG1JSXhFR0p3aDNuMlZJd0h1bGV5bEtKeFhoR2FqaTVhTGpTNE5sMUxyOEda?=
 =?utf-8?B?aWp5RFIvTlkwSWZodEphWXU1dDEyU3NVWG82RXFQanJtMDd1dmN4amFqOGNZ?=
 =?utf-8?B?Q2dDc1lvNnpTKzN0N2UxbCtZNThLTUhWc2d1MjFUL0lnaTJza0F1LytNb0or?=
 =?utf-8?B?ZmpHZmpvTnJOaWVsbFBGalRtNzI0UXkyNUdGQ2lrVlRaalNPeUVKOWNlMGdq?=
 =?utf-8?B?a1o5MzBERW1SN0FickpndG8yWElFNXArcmhDLy9hNnQ4NXlFNXcyelM0cVp4?=
 =?utf-8?B?Wk1GVWM5aldBVUMzdFltekpzdVJ3TWxuSWh5eThHWEZCWFlPNldxQnpibFVS?=
 =?utf-8?B?RUFWWUhtVy9FV3RZb1RLbUJJTlp4UEFBY215TXIxQTFDVDJuSUwveEVuak51?=
 =?utf-8?B?NmhpcmFKbCtxbWMwZ2xmaWdNSGM2citBZjNmVmhrSTNmWjlhS05wd2I1U3lH?=
 =?utf-8?B?WE5yaW9RWnNaTldLV2lYZUVmUGV1VjNRR3dpRERvUlZOZWh1dVF5djdKWko1?=
 =?utf-8?B?WGxvR3IzKzFHN21LL2ZYYW8yRk5HNGZNOC9pREJiNy9hdnZGODN6bmlWSk5t?=
 =?utf-8?B?c1lFem52WHN5d05wck5YSW9wY3JpYzRtNkV3Vjc3RmRFWDFVa3RKeXVnR3dj?=
 =?utf-8?B?TlcwbUdrSGtpZlBWZVB0MHBOQzdiYWFBQzdBaXZRVWhQUkFJSW9qRGloNmlt?=
 =?utf-8?B?b1N2emw3bklqc0puYmVjMGlCNHJPY0dvRVhXb0wvendMc2xpNEFvcnRlelhi?=
 =?utf-8?B?c1YzZzIzV0hzRWJpT25YdGRWYnljMXlFeStKQjVFUlRibXBIbVhtY2JjUFB6?=
 =?utf-8?B?MzE0VXBQeERpeDkyV25XZkt6V051dWF2WXVXa1p1d3JndmsxOGJOSDZKVXJ6?=
 =?utf-8?B?azc4YVV0Tk1vQ0JFVi9obk1hU1kxMDRaOHRLU3JTU3UzRlFtVUk2dU8xRFJr?=
 =?utf-8?B?MWxvd21JMWlRUlhZVUlrdS92YzFWUmpBUHVuQWNFTTZFd2ZSS3U4VUQxblFX?=
 =?utf-8?B?N0crTnRGZWtYNk1GanRYNlgyWGpuYTBONkNldEt6VTcwQ2p6OTJHSVdZeFlC?=
 =?utf-8?B?TUozdk9JaXNpNnRBM2QxTmFTTGZhSVVkaFZlMWhJVHB0cHBza0xieXZ1YUpO?=
 =?utf-8?B?MGNSZDZGU1U1bHVMT3JRYUJPUEZMSThJMFBhblR0aWlnYitmK2xhd1hJakVp?=
 =?utf-8?B?eGVMUFNqdElJM3VRd05MNkRtV2MyRGtQOEEvVWNpZmJYYXFHbnp0QytQcFMr?=
 =?utf-8?B?VFZobXpEWWFCVXp4YzlaNTJLenpiTUw2ZTY5Ti8rbE44RlVzVnVqdTRKbERs?=
 =?utf-8?B?VXdBc1Y2cUd2NjFIZW11ZDlGYVlwa244VWtBVlNMQk5NUW1BUnVTTmx6U2Z2?=
 =?utf-8?B?RmFENTlKNkIrMDNKSGhCN2NBa29EY1VBUjhjV1VucDQ5TTIvdDlzY2wxYW9C?=
 =?utf-8?B?cmhzMHpyKzRrY2JJT0FQUU5zYmdlODhwdzI5VHFLcVU0aDRrQ3JteXNuQitC?=
 =?utf-8?B?M3o1eGIyb2RBcFd2TTMveG83L3RjbW84Um1qWGpTbzk2cTZPUzBZdXF0bHBZ?=
 =?utf-8?B?ajViTGRydHdXNnVaU0REaUFxa2FCK25TcTlGbytIMENkTXFyWW4wbDhkQmF0?=
 =?utf-8?B?eTlaeWVmbDY2SUhXdlV0bmZ0S2oveElueUNxYk9oMW1UYURVSlJLNy95b1A5?=
 =?utf-8?B?SDBJSzFjRHlhL2xDNlZhbVF6NUVIcmIxMmt4TjNOZFovUllsMitZckZra1V2?=
 =?utf-8?B?ZlJLZHlBYnA3V1ZRWVRiQUVhQkViTG9jRnRxWmpod00wUC9MOVhZMDR2YkIy?=
 =?utf-8?B?MWFMR3RVRXRrbmxsdmJKRnd5MExwdnlPRk1ZT3BCR3lhTkpkdG53TzVzRzhI?=
 =?utf-8?B?S3hSU0JFdGVuQXdIUHhhNGdxU0RhTzQ0ZXV5ODhKVnVMTDNSZy9TeWZsQVZE?=
 =?utf-8?Q?UGtpjOYSwpMa2HWnURnewXi2tpe3Q72V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1V6S09wT0FKa0VJQ3pSdS9FVjlzRFEvWGVuNCtXZWpkTkJIeUVjUWk2bzBm?=
 =?utf-8?B?Rm02MDNxSVFFRlkxOXBGZVMyQ3c4RkhTdDVaNm53R0RvZ3FFSmNsN25uRUx5?=
 =?utf-8?B?R2lKZEtLWXRqNDl3UUhoWjFQTlM4VzJleTFkQjdQcHRVWklMM29LeU9qZzdv?=
 =?utf-8?B?WkdRdnhibThwY3hwcURqVUxycDJ6RWR2WDc4Zmduc01GNzdPZjNMVUUyY3hU?=
 =?utf-8?B?Qi85aGM1QzdzUzBVck5Na3ozdTNEaFpXbyt4MzhLbHhuVExMRXo2b0phempK?=
 =?utf-8?B?c3NGYytBcnZpL3lJL0FMMGprWnZZT3EvR2FoTkhDNUQwNDg5NnE5U2Y2KzBF?=
 =?utf-8?B?RTRsR25sMlErQ0c2aFVQK2I0L0piZS9NdTI3RExON1JZWEU4c1hpY1hhSkxV?=
 =?utf-8?B?UXZub1E1UE1NWlg5ODJKei9SU0crTGN1YkIwMkZDWVlqR0l5VzNVR3dzTUpn?=
 =?utf-8?B?TDgzWFAveEppU0R5YncwdWtIS2pVQTZpQ21MaWRpdWZIRnhzcnZNWWVYckpk?=
 =?utf-8?B?VytSWExyNHY5WWVUUWd0UGRvRW1QU0ZkT1NTQjB3R3MxeVI5QkVHdy9MZ2pI?=
 =?utf-8?B?K24zbGVLRzNGME45TkZJc1lwSzEwY0xRbTdtRWdxaWlLSmozWHRNZDZpdFJD?=
 =?utf-8?B?MHBudGlYOUFhbkwza0Z2RTdHa2RCWE1XS1BOU3FJdVcvUCtDUVB0RUxFUVdI?=
 =?utf-8?B?a3kvdGJSVkJtYmVQZ21kWWxjVkxkbG1LK0I5WEVXNWN3VkZtUGlmUlVUUlBE?=
 =?utf-8?B?QU1aYzBORko3eGthTmlUZjd5VjY2OGdqc0daZGw5U1FRaWFCdW1IcWNJb1BO?=
 =?utf-8?B?VVF6bUN6OUM5d2hSMDNZTFNtYjR4RFhROGhWVVpwbXZaY3JrMVZ3eXF6Sm54?=
 =?utf-8?B?azBCTzVXcVdDQm1BZGlEQzJBd2RDSmZqV3diaHZXWHUyOVB4YjN0bDBidzNF?=
 =?utf-8?B?U3daTFlWdnRXYzBZWU1TWW1UbU9ySXBNbVpVVHdHVFl1TU1RU054UzZrSFlQ?=
 =?utf-8?B?cTEvR2hVdVlISWp0OTE3Y3E4WUV3Yml2ZEo5cWNud2FOS0VKTVlxaitPS0pp?=
 =?utf-8?B?LzQ1VllYOGQ2RG1NdVhVZFpod05oUVlYNTJociswSE16ZzQ4Y2ZOY0ZML2NC?=
 =?utf-8?B?RXlwbWszTWMxdmxSRng3WkpwSklLVG12aFBYSjNVbGRSK00xN2R6amRqREs0?=
 =?utf-8?B?NjYvdlJncHdQcjZyTmVWcW00bGp6N1FyRVZ1a3VUR2VCeHNJQWZFbk1OL0ZT?=
 =?utf-8?B?TnRaSzBuQXY4VHZEbEJ1RzQzSWQwU0xaSG9EdkhVRDI5U3NnY3VROUtLc0NW?=
 =?utf-8?B?M3JPZ1lqckZXcHd0N2tlNDR4LzVYbnVlVE53K2FDRDRSUE9JTGI1RFBNekNI?=
 =?utf-8?B?UUNnb3RIajd2MEhWRkxCODZlaFN0QXlJd3AzRmZ5a2tGYm9pMGZpM2xYdnVL?=
 =?utf-8?B?VllUeEluUjhac3k5T2NFLzhTSUd1bktjQzZ5cnNDUGNWZ1lpQW5BdXZQazB5?=
 =?utf-8?B?MHpWdUN6YUlWa25VaXlUMngremtQdU9Qci81MDRlZGNHNENBUEc4alowSll2?=
 =?utf-8?B?a2NIdjVTYUJzTm9wTVdGQ1Uyc2tOVUVMclRhTUJlK1l5VGdhTVQ0UzU5SnhU?=
 =?utf-8?B?a2xicUxoTkN4Y3h2NTg2LzNZQ1VlUkZpRXBJWjJFRGFSZEl6aTk0OFhRWk4r?=
 =?utf-8?B?S0ovbnNMaGlRN0RYMC9KMjRwclFXZzc1bWJlSVJ3ajBjOGlZelJTV2krSWpI?=
 =?utf-8?B?eUFVN3JGNE1rNlB6eFdXbm1wN1ZuKzRZaitvYVlucDJvNWRTVUdaaUJRcDVn?=
 =?utf-8?B?dTJpOU9Ed1Fhd2ZvWXk0VmovV3FVUUhIZlhLT0tqL2pXWDMxZ0w1dXFOUzlr?=
 =?utf-8?B?dmp3NWdZWlNxWTVhaXc3bnJwakk1eHVLQ1hDdEhBWWNWU2lxTEFwa3pzZmxO?=
 =?utf-8?B?enZkV2xkMm1iUmpOa2lwTjlLLys5cVVoaGpTOHhlWUU3LzgxSUNlWk9DRTVn?=
 =?utf-8?B?eHhTcTZnSXcrMFF4b1c5ZWJRdmgwR2tGdVFxdElqNGVWMEtVSGxhUGR3Z0xG?=
 =?utf-8?B?d0xkemMrWnV3WW9KOGlHY2ZZUkx0RDEwYTFvc3pTTkJRd21pL1VWcVkyVkdU?=
 =?utf-8?Q?vpQgGLNNTvJpjDPE+Y5jMpfHJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae537e4-e06b-4b6e-af5f-08de126fedbf
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 20:08:28.5376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhSV6ZI2OSaLP4bWemAypuPZDrBg56KO6YOokmvOn8VdooSqtIp9eeStplRTCMtYK6FAwP/OucAWaMn+ZMyQlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159

On 10/22/2025 9:27 PM, Nicolin Chen wrote:
> On Tue, Oct 21, 2025 at 01:43:18AM +0000, Suravee Suthikulpanit wrote:
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index 9226edd8af69..c34604cf1811 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -107,6 +107,7 @@
>>   
>>   
>>   /* Extended Feature 2 Bits */
>> +#define FEATURE_GCR3TRPMODE	BIT_ULL(3)
>>   #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
>>   #define FEATURE_SNPAVICSUP_GAM(x) \
>>   	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
> 
> This now should be moved to the previous patch?
> 
> Nicolin

Ah, I was moving stuff around and missed this.

Thanks,
Suravee

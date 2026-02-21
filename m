Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010035.outbound.protection.outlook.com [40.93.198.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865943B1B3
	for <iommu@lists.linux.dev>; Sat, 21 Feb 2026 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771678321; cv=fail; b=flI03tp/PMx+CnqcvpqnFMlJmC1JYYlvbgYjrKNwPju4bQMl56VNU1ImfEDnKakOIunUbdP9gljscg/GKYyOnLVmIdtvjF7S6cUq7lnbLOgCwK3IxZ9KqKQxU/cyJl9v/6gL+23cAuYEE8SvPaUAfExlxlIr576ucupi881SKTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771678321; c=relaxed/simple;
	bh=RXmz96qLUF+NNekui6NNSBJDukgQQgESTSM74g4771M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vEcq3HhTWX9nCE0GIwMLkLjPJP/7NHSuYwbmh36lo15YCtjKBz5mRoeFhkUW9MN5ulp0QJNlS6X27Cd9CZbFTJgc06+XgUvynUXL/X+cMFhkPBi6tpYBIbd023EqgEZPpP8uYfBQ+V2/ajs5vbO+DXMmpEp69hIJgKG3Ieuki98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JPb5wLaA; arc=fail smtp.client-ip=40.93.198.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JPb5wLaA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyQq7ZgWJudY8U2gfo/ZXXrwO75LpZDcemXSXthrYk7U9GMjvKk6j1u82ArnS/nfccY9BzhKUQTTIUe+SmR0kWHU8/DpN9IF3s1n58U5isU0dbol3WT46nubuLJMW4pi6sLBfGeHZu6/sBvyQq7ly0p6GLRDVNQMzS/HeMJsZjtuMkahmNrP4Syaz16FJbrRJCeM/VcIUfxDlJf/CC33+SGEooHf63rsGkLqPEE0AV0IoZFnZ8GBA7N8MLEBhfEj5l1/Nt+zfxH+Pu7QB5m01X3lX1gfZyH3Vug9A5zEow232hlKGeJrGLUglh4FjUdwJUSv/ur2nHEgImHBSkcFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWnudAvYemRBM1Jebz8hOyTDDi9BINZnDjW6zaHpL+c=;
 b=ON6mQo5/0PKdMS7q5m653O2jeeXZV7sEfTDMt7Pv0AdF9supZQ1A7VsdE2beMCZ6189gElFf21hXfUPSC66IAhF4K2AM1FgaHKIcmnSQlcRvBj9Rkktd52NraAIsVtKUaJ773GGtZXC0vUTp1ljDZzV7o13IdLuCva/DsjCq1cpGpeoXvR+Mpye0E7TSMOHQNyrCUb7pg9FgArDlJXi8oYUqTF2ZJvOpotSLh5hncUp6R8If9ex8mhOa85uCj/BlWUrOReqgFji2Xp4OtGdm6Am/UICcgo2Vzm4qV9AAld9ckobmOhV/LhVQ8bAa/YwD9i2ICq/1k6jmZA1Skafllg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWnudAvYemRBM1Jebz8hOyTDDi9BINZnDjW6zaHpL+c=;
 b=JPb5wLaAeyIwKVSsoOHuhBnZLWEJQSOeAtgGVnOatPgLQ4fVvyrTHfpNsAwVG3Vlq35KMcuyNxBbex7MeaiBL7RcyiBU+7hnhUzeo3RbOiP1DSh5VLVGLRiPH9mPZ+Ni5cbSWeU2+3jJQ0E/tKbmmrgqBNSeYufXi6ZPzcDZYTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by SA5PPF5EA4322E1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Sat, 21 Feb
 2026 12:51:57 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%7]) with mapi id 15.20.9632.015; Sat, 21 Feb 2026
 12:51:57 +0000
Message-ID: <186731e2-a8f4-4402-9117-fc1dc737cfe9@amd.com>
Date: Sat, 21 Feb 2026 18:21:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
To: Johannes Stezenbach <js@sig21.net>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 "Rao, Naveen" <Naveen.Rao@amd.com>
References: <aXeAOtGQUdlNZF6V@sig21.net> <aXnXX0P-XsEFPlJd@sig21.net>
 <52148f32-2348-42d8-95e0-49b30c29da1c@amd.com> <aYHerYcZ-5FOguKY@sig21.net>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aYHerYcZ-5FOguKY@sig21.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0072.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::12) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|SA5PPF5EA4322E1:EE_
X-MS-Office365-Filtering-Correlation-Id: b544ac66-3f1b-44f3-103e-08de7147ff52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEFVQ3lkUTRmUEthbjZHMUhCT2w4NStkRUVEMWxBZHE0akVkdVI0NThPb0o2?=
 =?utf-8?B?cjdMU3Iyd0h0MXN5U3N5Nk1xVXRHU0ZiQmRlczhjdzNZbmdySEdVcXhLaDBy?=
 =?utf-8?B?Wk1CTWxLQmV4eFhtSTFLdFU4ZFZYdmZ0U0k0S0lzK1Q4aHJ0NGZtSmFobVpX?=
 =?utf-8?B?WGtxUnpZZlllZ1BCelIyWC9obFFma25yL3JyTmFDbDVOa2prT0tLTkZJV2NI?=
 =?utf-8?B?dnc0bUlZV3l3L1hMU3V6N2JNUFR0bGhINVUrZktoR01jaWhUS3F1ckhsdmFZ?=
 =?utf-8?B?L09EbnkxZTVLMnVycmVQWWo1TllyMVRLUjZJTE5QNlJEWjhpc01oUVdvSVRN?=
 =?utf-8?B?eFlydjBvM1h5MnRBMXNOdTA0WU1vYU80ejV6aWwyQjJFZHpRd1ZyZ3RGWkY2?=
 =?utf-8?B?WS82YlN0ZlVDZGVhSkFJeUIybkltdU54UWUzNXE0T3Q4aDNVMktGWTFxZENa?=
 =?utf-8?B?TkR2MXJPRGRaMHE5S2k4R295Yk44Z1VteWQrZEpBQVdpaGpkZnBSMXQyUXVm?=
 =?utf-8?B?N21udkxwNjkzNmRPT3pUQ2VZLzdhOW03aks5ZVlnRG96QkQvTDN1Y2NKOXFq?=
 =?utf-8?B?Um9vT2xBUENMbExjNUEzcXZ6TUYrV0xNbnZMZkhCZ3lpdm0zbFlQdkp3SWtU?=
 =?utf-8?B?M0pGaEF1akNUV1ZaN3hYNGZPN1VzWE55RFJaT3NGS1UxZGYray8rc1NTVlhT?=
 =?utf-8?B?U1lBL0tCbkdEcTVnNFhzTEErbDBubk93WThXRXRTNnNSRFpPazZSYzdBdGhZ?=
 =?utf-8?B?dlZuT09WZ1FGeS9jeS9hdG1oNkM2amt0UXM0QWF3RUdqQkt0b1o3My9DZXAx?=
 =?utf-8?B?TEM5S09GZzdtTW5BTDZRWFJERE8vSFJhVUw4ck5JUVJ4TVZzcGNib200QVZp?=
 =?utf-8?B?SmtmUC8yRkpmdEQydktEaWM4WjV5cWFScTJsZDJWNTRWWGxqb3BmUjR1czVk?=
 =?utf-8?B?QllIRFM4aGRxL1lkYXQrNXZTTFoxU0REZWkrZWxNYXc3cXB0RUNXN0VTSE5l?=
 =?utf-8?B?bVdNKys2NW9vVDcxYytIZEg0OUx3WGsyczNtaTVTOXJWMi9CdmxHNGIySEp2?=
 =?utf-8?B?Z0tnKytLNkFIRW1QTXNBVHFodFVlaUE2bDRlTGEwRHMyM0dvbDRCeUFUcEN3?=
 =?utf-8?B?WVd3MHE3S0tWZmJQNHBobzRxb1JqeThmTGxkRTg1UlA1MUlkWnlLc1B6U2cz?=
 =?utf-8?B?ZE9NUmNJMVI5NHdCczZKYk03Y2RCSmNjMGZOWm9ibUhicEg2cVBwVTYrc2lN?=
 =?utf-8?B?OE1yTkhXZW43b1hHU2FIZ1FSK2JsektOS3liU3Vjc0JwY000enpRR01mSUFF?=
 =?utf-8?B?OFZOdXVES2hrSy9zMEhBM0RmUnpncmgzMTltdnR6Rlk5QVAxZ2F6OTFDNjVD?=
 =?utf-8?B?T1BwOHBFeHh4Q1F6Yzk1T3lkdTRQaUsxck8yUWYyNGJuZkxleEU5ckJFeTJY?=
 =?utf-8?B?TDM1TWtqakUzNzdpTG9zWkloR1NVODBjQzFBSWg3U2M1eGVHQU9PTktSR2hD?=
 =?utf-8?B?MHRFdHh1VzdqeFp6dytGdVFVQmJGTi9NclJWbWsxd2hxcXVDNUZIblduRmVm?=
 =?utf-8?B?aWloOHVSbC9lTklIYmxQS1U3Q2QzSytNQTI2ZUYxSTZNMm9GMHhKZFVhS3VG?=
 =?utf-8?B?QUV3aDJXb3JDbXNiVE5VNUdyOWNYVWoyK1o2cGtVRzBabGVTbFI2TThxb2dK?=
 =?utf-8?B?dldBcy9ham9BdlBDTituYXpITmdOakxhcG9mL0lGcE5wWmpTUmtlUGtFQkpo?=
 =?utf-8?B?RFAwQ2xFdHdTcjRCTnh6aEVRdUZ5c2NTLytnK3U5RDRjRjhBUHI4QS9GRE1K?=
 =?utf-8?B?ZXdUeFNPaXJGMHZYY1dTZmhySGx5UDJYb1NaWGxwcnVxOEZtZVhrUHFuU0FU?=
 =?utf-8?B?V0J2Nmw4NCtGR0pFc2Q2ZkRicFRKTFJCS2J3ZXdlMFdHcWN6RHNObmVYdUwv?=
 =?utf-8?B?Qng2bjdpQTNrMld3eFBPWnIzL2o2QzRXcTR6cHN3UlhCdGgxOEtRK1F3Vjdh?=
 =?utf-8?B?K2Q5TEdMdnVML1dOUTlpN1JkYlpHOW5kMDVBZzR5SWlpcUduT3k1QUZ1ZTQx?=
 =?utf-8?B?ZHBkUFZFdUoxemlUZzgxTm5FRFBCRHNjYWhaQVpyNVFFNkUzNkxtSGhIbjVm?=
 =?utf-8?Q?T0ec=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDM1cmxqZWN0MTUvSTQrbXpENWVtNDhLMzZ1R1lnSE1ocy83TCtwa2VOZnlr?=
 =?utf-8?B?eDF3cHNXaDF1ZEUzb0R1QTFPU1BWODU5OFJOZC9OSnJCY0V4bVdPVklWMFRm?=
 =?utf-8?B?Rno3ZHUvMk9OQlJuaW45S1BydVVkanhTcGZUVytHWXV3L2RvZ2thOVBpdVJv?=
 =?utf-8?B?NDUzcVJrMHJNZkc2UllIZ1hSN1RmZlBJM1BGcEdWbmtiam00UEVRSms1emNR?=
 =?utf-8?B?TVNZL2F1OHlpOUR1U2lVaVBMYlNxREE5Q1FtdTlvRXBSUjBjbEdPb20ycm4v?=
 =?utf-8?B?TEtZakhCNUNEbWZ4NVR1emx2UElXVExrUDRWMFNSbXJxMDlUSVc4ck1vSHMw?=
 =?utf-8?B?cEpqcXVKek8rNkEyaGJEaUdLbGJDdzRxOGZFdkpONk15YmZhYUt2djg3QlIw?=
 =?utf-8?B?aUw3ZzZUa1IvcDRYQVhIY2dkVk1TQWlnQzFZT2pKVlM5YnRkSUpmVkdNSTdw?=
 =?utf-8?B?ZnRuc0haNlpFaEVvUG9YZ0hpL2pUTFM2VHB0c3VjcE41L0hDU3huckV5K1pk?=
 =?utf-8?B?UzVXOCtHYkNTSGRxU1FGK3ExMlgreVRmTWN4M3Z5OWJhZDdOeFdrS1VBbXZl?=
 =?utf-8?B?QjRaVVdpYUE1NURUYTFKWmRodzNPVkRNckUvQ3ZsMjlnQXRtQnp1bGdlQWI0?=
 =?utf-8?B?WVZBSmQwYUJpaGM4bmZLLzNMM2xWWEpDMVNXNVArc3RZNzJicHV5MlNtY0dZ?=
 =?utf-8?B?enUrREZtR3dIMTl4cVM3b2plZ3hocW1sckxudWdNaE9kZzNYYVFqZHFvTExw?=
 =?utf-8?B?eTN3TnFidmVJeXlCN0xuR3Y2amZyeSsyajZ3a2xxNngyWWtDdnlha2gvWnZ4?=
 =?utf-8?B?RkdJekd2VGlMUlREZjZISzRueEFrdk8zK0tFdlpxbzJLakV6SlFMTm1LVXBr?=
 =?utf-8?B?SDAwTEtnbGZQdUlkOFVSS1FaaEJyRWg5cHN4d3dYZkV1NTFZQmRZK1ZEZlFu?=
 =?utf-8?B?eE4ydnE1cFcwN3BIVVR0SnI2N1p2dkZVMkE2NWlkNW1FRVZSUDFsVDc2dFJ2?=
 =?utf-8?B?SXFSYlYrY0RIOHVhZHduUFlUSlgvRUdxRzZ2d3RDdDl1V2llSEt0Ry9sYldN?=
 =?utf-8?B?YSszYmNmd2xZd2x0clgwTHd1cE91dGIyZElETjZMM3BaM3ZLZFgzdFlMQU0z?=
 =?utf-8?B?d3laNnBUdVpVcGxRaVgvTjBIbEVob2E1TU00WXdoMEZJU1FuMXNWKzBWTlVS?=
 =?utf-8?B?dDZMSG1kUWtjRVdFdHlZM1c1ZmY5WUNqbHJkZElCSWxZaUVlQ013QytXVE1H?=
 =?utf-8?B?Sjk4Z201cDZEZ3BzR0F4UFRkVzJrU0p3VXo4d0lwcTh6TjI2eExnSklMVmc1?=
 =?utf-8?B?TUlmVlBhS1B6dTh4M0xiNlFwMmpYSDBINUNuaGV4Qi9ZNmw3em1uVTB4Qkt5?=
 =?utf-8?B?U3NnN0VMdU9rUFVxZTFNYnQxSjZoUEVaNjl2MWV3b2U1czNTOXB4WVlDakRR?=
 =?utf-8?B?bkhzZnFHK2xJTXZjdUZXMkRRWVJuQ0hNbnBLVHZyYVl0QWU1Ym53Z0hkMWxp?=
 =?utf-8?B?eGVGS2plSU1wMFpQWDluWFFxaDNKWGNtYldFTFRKZzl1V0p6R3VUb3A1QXF2?=
 =?utf-8?B?TkQzYmZad0JrMktWU2huZy8zWTNtVzNKenlOdEExdkFlVDNRWVZMMmVDRW9K?=
 =?utf-8?B?MmVKeXAyRzFFQ2pQbVJJakhCdlk5cFNuYXVXTGNwU1VXTEFCT2V0TTFTRS96?=
 =?utf-8?B?akZRMnNlZ1JGWWxBczFTalRhaUFXZmZscmRrWkFXcm1pNFQxeTJudDEzYUNY?=
 =?utf-8?B?NHNKUHozWUhBZFVhVVVOczc2RzhpVkdHcGlkOGRCcXRSQU5mMnp0OSsxQUsz?=
 =?utf-8?B?R3cyZ0R2Ly9wVFJkSVpueGc3M25mUys4YVhBSk1LaXdRaE1hWHA3ckhoT2Za?=
 =?utf-8?B?dXp1NUV6eCtmL1Njak9Kc2cvSGo5QlBLczk0QVpWUnhOT1dRa0ZIVnF4a0J6?=
 =?utf-8?B?THcwMWVIanBwWGxhTVhHOEN2b1hRTEZFM3FUYUZKVVBXNEdvZ2JNYklQY1JD?=
 =?utf-8?B?MFNuYnBnSFg4VkF3c1RkWGJ3ei8xUFhSTkE1YWlKMjQ3U2djdTZSZkcvYUQ4?=
 =?utf-8?B?NXpETmpuWHcrYmdmM2ZjNEsvb3hEbDBqa2NzU0tzU0NhK1krZ0twaWJEeDZ4?=
 =?utf-8?B?c3FQRVlaN1BUZFJsV2YzejNRbkhFUG4xcWpRcHRXU3VzVi9vR0hTZnA0Wkth?=
 =?utf-8?B?L3ZDdFZlUjVIOTRSQnNGQVpzSEQvaVJoWndmK1diUU8vZk5uUm8rQmU2Tktk?=
 =?utf-8?B?cXZ6M29kcld4YnZKTWVGRHBaU0VnYlBoajRaanNhOWtjM0FVeGVDcm85Y1Rt?=
 =?utf-8?B?WTNDRFhRckg0YmtDaXk0QjhacU9SWDJ5ajFFdnF4YUE5SUlUcXRaZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b544ac66-3f1b-44f3-103e-08de7147ff52
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2026 12:51:57.5166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/lFzI0yfxXruG1VErjCL1MvMvEof5V4o1gHPHOFUK3eF5l3nM9zjI5lWUExZPlBnhmV34nO5HFtH0/qlN4SqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5EA4322E1

Hi Johannes,

On 2/3/2026 5:10 PM, Johannes Stezenbach wrote:
> On Tue, Feb 03, 2026 at 11:08:49AM +0530, Vasant Hegde wrote:
>> On 1/28/2026 3:01 PM, Johannes Stezenbach wrote:
>>>
>>>> [0.000] [  343.790320][ T4340] WARNING: drivers/iommu/amd/init.c:952 at amd_iommu_enable_interrupts+0x4c8/0x550, CPU#0: pm-hibernate/4340
>>>
>>> - is it Linux or firmware bug?
>>> - if Linux bug: please let me know what to do to help debug it
>>> - if firmware bug: what additional tests to run; how to add a quirk
>>>
>>> What's the downside of amd_iommu_intr=legacy? Does it only
>>> affect kvm guests? What's the relationship with x2APIC?
>>
>> If you pass `legacy`, then it only affects kvm. It will not accelerate
>> interrupts to guest.
>>
>> interrupt acceleration has two modes:
>>  AVIC works with xAPIC
>>  X2AVIC works with X2APIC.
>>
>> Generally BIOS will automatically enables appropriate acceleration mode.
> 
> It is strange because dmesg says:
> 
> [    2.647593] [    T1] kvm_amd: AVIC enabled
> [    2.647598] [    T1] kvm_amd: x2AVIC enabled (max 512 vCPUs)
> 
> but no message about x2APIC. If I enable x2APIC in BIOS (default
> setting is "auto", other settings are "enable" or "disable") then
> there is a message about x2APIC. So it seems BIOS default is
> to have x2APIC disabled.

Hmmm. This may be OK as AVIC/x2AVIC is used for guest interrupt delivery.

@Naveen, Can you look confirm is this config is fine?

-Vasant


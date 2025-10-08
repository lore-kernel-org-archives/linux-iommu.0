Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D577C283FF7
	for <iommu@lists.linux.dev>; Wed,  8 Oct 2025 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932989; cv=fail; b=QGVFTW1T/webdxLu3aOaibWjtk/he4I1xkN3MHTwHkdbBUGr9855Vs9yZkS9Li6BMZQfBgz5aUlV9w3OHJCAdc+gljKN82AyP8O+/4law/qI0kR704QY6cn92fNbMvn1LXy2inK3J3GHncoxZUpcsAbF5awqadnWE0egw0Qxd+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932989; c=relaxed/simple;
	bh=Ozs/YXmEK3dG8KoXQLIMqb6Xfmdsr6oi07H8uvnDEnE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PhAeb43XyvZluz149b0dHbxHpU/7GHiv/iPaAe4OqdyE1lgSdvj0tlXCG6fljbRdksHUqEPB3uAMoUvYNZYjpbvwtZ38bPG5vkqwHqXgXENXpju9iS5+ebvAZ3Oc1ZaZlKKb+Tuj+6HSdkKIZhPevBy1pFiKsB+FDq/irQchht8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AQEdKOtJ; arc=fail smtp.client-ip=40.107.208.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AQEdKOtJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pi4u93WDsK5z/xk/xqWL744H7AXwIzBs1/53uY3lLxzBYn1bPHv630d4IGSuvOL+4UHaTDkLM5S805GdNYwP9Y91PXCoiY2B+9Jc5EqsnZI/GrVbrAnfLcx6iTbQSz09ms2HLCkvJx0uqSC70H90YX0Icwv5aNG0PG7yrb58u2uvo63CYwl6gf8a0D8e9H9BkhIONTuKOTmoyvjxVg/AX7tehGAnddvhKnOZ0sWZ9ZOXhZuHeps5OlppWyaoq9HEsFMaxPGLNYpHIu/aBo3pr6Dn1UriRGUDAnxfN7XWdjatoeVd3N8FvpxWMqRTWegaIif4/sRfNa9pVlGb0ehWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXzXLFU0XvzllBA5jPWFf67xgIOvf4dLYVV6pyRvVEQ=;
 b=MLMDAZVT4jRiYjRq4uAeGNVUHCL3dPuLCQaYwGwPe/YEFxvS/fA6wWq1lYzJEtlC5BO20ozUtcg/Ea/ITFDIuLTIcFZM2chFHxRqpcOU1nQtSo1BG48Fg/Tr5N4ryZANXNndCN6XSS+qCXbl3wZkYyUD2ldsbJVgC+8FxockBe91VdzKiFZ7oJwdvalIbeWarIMAe4PxA9CvXS8khx7TS693ishhEI+6hjC7SnMlo9QPC6BE0XWRZtJR8dflnMBhfKRQamEmcGRsnTDhHT3ul49pbXDGPuwmQvKaTnXLl5MVmyXzeMfevEYzJuWo6TDnU5GgBneB2SMJrCtpXjsXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXzXLFU0XvzllBA5jPWFf67xgIOvf4dLYVV6pyRvVEQ=;
 b=AQEdKOtJCY0VAIKrz1ZN17rrHHQTPz0x72URhB/ncY4E4+Xv46QZTBP2liklMKaz8DrskuP/FD1XfVobsx1D8oEItuxFzkD0rosQMBhfo6vI9wJE4aOlt9C9RsPjxTTJH6qgN5eqzTKnaUbL6KdK/d500RKyI+ngj5CWwE4EG5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 14:16:17 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 14:16:16 +0000
Message-ID: <85a88037-d36f-433a-96c6-95a0c2e8307f@amd.com>
Date: Wed, 8 Oct 2025 09:16:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] iommu/amd: Add support for nest parent domain
 allocation
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-10-suravee.suthikulpanit@amd.com>
 <aN69rkBJS2hIcZjk@Asurada-Nvidia>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <aN69rkBJS2hIcZjk@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0114.namprd11.prod.outlook.com
 (2603:10b6:806:d1::29) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: af33fb98-db42-4e72-f7d1-08de06753ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkowL0hSOUliVm5xeWVLUGh4STVNdFBHNUtiSzIxZlpoTWRndWkrT2dwQ2JD?=
 =?utf-8?B?VlNWUWVBVkNFNW1yNUNxT2V0d2tNeGJmeGoxV3RMdmM0dWZ2UTc3OWJwWUhP?=
 =?utf-8?B?RHE0NlBQVkg0ZDluUkhNTFpOd2w0VldyMDliUURlTlR2alByMFVUUTc2TERl?=
 =?utf-8?B?elh6Wm5sTDRzQW55RTBJeGJCa3ZmdVZyT2puWHd1dGRhMGp0dUxaQzl2NDVn?=
 =?utf-8?B?cHBrRGFEVmg4bDA4ei82RDZQMERUbUJRK3R0Mm9PWjRzaUZWSXp6d2tmcU1B?=
 =?utf-8?B?eEY4M1hJRTRoSzZ1R2xNeHkvTVdMYkRiTHVuUXV0UU16YXNYdkdaaVpWZzI5?=
 =?utf-8?B?d1MrdU1pbWc3Q0YyS0hQdFAzajVDWmpKcWRPaDZVZW9sYU82ZElmU0Y5bW5R?=
 =?utf-8?B?R0NqcUNlVE1QSG9XZ1lwUEljVUNvN0pBNjJjc1Y4TWd1bFBhZzlJbzcrUEhC?=
 =?utf-8?B?TkhiVStiNGpWT1FobWhGZ1N4blFxL09ER0N3WkFmVU9yZkV3Z1hEUUZ5K1k1?=
 =?utf-8?B?bUNGRUZqamhOUTJUbjM2VFQrS2haNGNNNDhuL3RQMEdZL2NnUW45c0kzY0xR?=
 =?utf-8?B?L014dWp5V3FLemdJb1lITkJJT0tVN2tEUUQzQWR1dWZYcWI5V2RON21Gc1pO?=
 =?utf-8?B?V2lyYWNWU0w3Vm9mR2x1QmVzbFVrL1NXVHlCSHM0VWdzQWIrVHgxbWlBU2xZ?=
 =?utf-8?B?MzgrcjBSTTNRdEhkdHYyRkhwOFA2TUdKbC92M2JOTnlXcGhMNE1IQ1JESzlP?=
 =?utf-8?B?c1V3eTlwdFIyZ3g3ZnhqOHpuSlc2RkhIb0tnOHpVOHM4UnJ2L1FJUGt4UWti?=
 =?utf-8?B?NmVlckFDb0o4a09jZWFFMWNKdFJQVEZZQmpDU1FNeE1IbEhPNnVmRGNZMmZv?=
 =?utf-8?B?eFlqejhDcWhxeUY3N0Y0UFQyZlJSSTAvNmwxcTZubjR2TjM2NnRUckZ2VG12?=
 =?utf-8?B?VFUyZ1NZWHNTWGhVa2Q1cmQ3V3drZEFncFM3REVXTisyMFdGQVVpNkt6QmFP?=
 =?utf-8?B?UTlGRmNmQ01adm9panpRMlpFYVpLWU1rOVZ5SjRzSUtVQTA2MkRYVDVWTnNs?=
 =?utf-8?B?TFhqeWg0VkNVSjQwTGNjdHpOMVYzNGFpYkNVOFVnc1NlVHhDbC84anJyUUwx?=
 =?utf-8?B?MUVEM1VlR1B4WktzZHh3T3o1Z1c0Nll6M0FvY3gvbG42VlhmbWtGMjIrVXd2?=
 =?utf-8?B?S0ZVWXpUYldla3VmVDlmUzJOZFo5a1VkdmtNdWF1eHhURlE0Ly9NZkluWWR0?=
 =?utf-8?B?MnN6Q1REN2NWNFlzNG1KNGUrZG0rK093NnlWQkZRTTNabFFMSVdwSFNaUmsr?=
 =?utf-8?B?Z0xhOTNQN211ZlRxS0crYjMrMDBoL2pINlJQRVphUDNXbUhRMk5JbGRCeHJu?=
 =?utf-8?B?cEFRb1Rkcmd4VTRsOEZEdlF2Q0wvdUozdEtkWlhOdDUyYk0xalg5LzhudFRY?=
 =?utf-8?B?U3ROcW4yRXg0TUxMa0JVeTRXUzk3aWhocEowTkZyYVkzOFNBTC9tWElReXVt?=
 =?utf-8?B?Ly90VjdmclNES3RoVDVsZnNBTU5WSi83TE9jWXVhK2xwNFY3QjJtRXFTRnNy?=
 =?utf-8?B?ZWJ5TFYvNU9VV2IrWndNNUVmVjVKWnQ2cWFqcXBDbjUwV0RodExreGxuYWpS?=
 =?utf-8?B?RllweDZrM3crb04rMDFDZkNVY3E1ZitudCtXUU5nTDVHUjUwNW9YR1ZZSEh6?=
 =?utf-8?B?d0lmZjJNR294TWUzbFMrVUh5MWF4R2U1MTg0anlEOUlQanVnMHA4MkdUaHJH?=
 =?utf-8?B?THRFaEpGNklFay85Y2orQ3FjQThQT1lKY2FuQjdMYlc2ajU2bjQ3N2JOOXA3?=
 =?utf-8?B?VVdFMk00WUxVb21vY0RiMjdRaUxJbnU5NWFpOFdVZENDSnRqOVpKVUtDREVW?=
 =?utf-8?B?YzA1ampZVEoxTzhHb0hCbkd6Nms3MVFleDl1d2VVbjJpN2I0SFVyWk43ZEF5?=
 =?utf-8?Q?YOemEyRYviXEtKCClcwAKuxkI0oHaoVU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWpMYVVwQkwzbzhYNWVjL25pU0ZyMEJyTXZzTHRWT1J2bEdtNFNzdUE2a1Zj?=
 =?utf-8?B?ZWFrQUs2U1lBdU9SL2pmemlKcjViVW1rQkhKZDUxeldKdTZ4L29iQnZnd3ox?=
 =?utf-8?B?SDJnSmRaMWRkWmdGZGFQa2p3S0JRY0UwUGVYcFN0VXhyd3dRRGNrQzYwSm5z?=
 =?utf-8?B?dk1RWVp4OUxxWEJpWmViN1FOTDg0Nzl5aXRQVVptK1M4cXpuVmpmVlZudDJa?=
 =?utf-8?B?U2J4UmJDRmVOUzZKUU1Gc2V5QkxudERxd3Njd2YrN3JVZkgwWXIyZWw2K0hx?=
 =?utf-8?B?d0lWbnBxQkhNUjFpY1lNYURZblpiaXBqaXY5bVdibkRYeEJ3MEt1OVlTMFdZ?=
 =?utf-8?B?Q2F0Q0tIcHlQREt5bmZrRUx6UkRSMWFRZlNwS3UrSkN6VTBXcy9Jck51RUxI?=
 =?utf-8?B?Zmtvc3RBR0MrVWFWZ2NmZkFaQm5lb2hnZ0NyUzdOdE5uZVI2aE9weTRqU0ow?=
 =?utf-8?B?ajl3alVtSHNsMzVGSWpaZEE5TGhOTm1NWWREcVAvNmczRTkyTjFiUVRBZFVj?=
 =?utf-8?B?QjRYOS9rbmF1b0dnbG0xaUJXd25QbS9uOEo0TnpuYjAybjVqaTgweE1neEdP?=
 =?utf-8?B?UEQ5Mm5CTG8xQThudVFPUWRzbDlEQThwby85bmpraVBFTEpObEY0dkk1M2d4?=
 =?utf-8?B?dnpaUjNmaW9Gc3E3L1U0WW5RWG9TT3l6MElybUlLbkF3STFzTWRvZ3YzRlRj?=
 =?utf-8?B?dDF1WndTeWk0T21lY1ZjeUhhdmFSdVJFYVY2UGNBSisxd0FMRVhYMm41Z1pN?=
 =?utf-8?B?d3o1RkJtaGFkeEcrbjRwenNJS0tWR25yYXBNLzhPMG5wU1RvSXpQNmJTakhv?=
 =?utf-8?B?L243Y2RVbUZVQ2dtUG9UeGxML2RRdi85VWY1TUpxYVJGM0d4SGRkb3czUEJO?=
 =?utf-8?B?SFFFcjhKdUdvbmRQVlh1OUZnSDExR1JwT0xpb0NBMXJYbmdwVDVDUytXbU1a?=
 =?utf-8?B?RkZRMTI4QVhZTDlYcFQxQ2ZrZHNzNVR1SXlMTU8xWVB3VFZmSlluR1ArZkdC?=
 =?utf-8?B?eFZNTlE2WURHaXF0Vkd3SS81dEppd3RkdEp6cndSNzRiQUdsQWQ0UnBjSFJG?=
 =?utf-8?B?OWdoNmJZVm83bWhSQWo4TmVCTFRXcm9KV2Urc3VLbCswT1lEdmRGcCtWSUgy?=
 =?utf-8?B?UEJNWUhwR0g5SUxpLzlFRFRIREgwQjIzTFdGLzFrSUVNa3M4QndFdGJsYzEv?=
 =?utf-8?B?UDNOK2F2dEwvVExKY085QWowL1Myd1J4RWw0YjBOUVlDVUtWVDVhQUFIdTE4?=
 =?utf-8?B?aFJyUks4YTA5VE9DS1kwNGtvZVVibWpFYlh2cEQvQm5CRktNRUdJeXJkbEha?=
 =?utf-8?B?eU1acmNweWNCam9Ya01PMDAyUzhaM0tRNzAxSDI4ZnYwZmJVUlNudWFJYkdY?=
 =?utf-8?B?Z2J6aE1YTnRidG1Ba1ludWNaY05tWUY0VFBEMW9pK2xPTUh6MHgyd1l0QkNq?=
 =?utf-8?B?Mkoza0F4YVlzYnZiekNia2JtRnBadW8vSFAyci9MVTdKVGlOdVRmbFl6MWlS?=
 =?utf-8?B?Q1VIMDNjN0J6QUZyYlo4eVY3RFhnOXVBWXY5NDNlV0g0U0RIYythZ1RIYXBO?=
 =?utf-8?B?QWNrQ3BBN2lFRnlOS2pHdjlFcWV6dVg5eWlZY2xhazdKME42a3c4VmdtbnRS?=
 =?utf-8?B?d0NsWWRMdm1aRXpMWk9MUnYzSjZoOHlOSVZzWDM3K2R3OHlvazRUellWM1M5?=
 =?utf-8?B?b2NiSkRUd0t2RVNyb29QQmdzVUE4ZGdGSzRFOGVOQkwxOERJcXJWK2xCK0V2?=
 =?utf-8?B?SGpKZnBpeDAxc1NFeDJxNTJtQjd6QkhwZ2RmN3lPTUVyazllNkEwOGNjd081?=
 =?utf-8?B?T3FRVHNHMU5sbFdVWk0ybmpPbVlsUW1Ka1BCM2dOa05Fa3Y1VGkrS1N3dW80?=
 =?utf-8?B?SEgyMkhpbFFCc1E0bjBXNjRNMXc3VU4xMldSbFViT3hIM1JCZVljeXJMTzBm?=
 =?utf-8?B?ajVxanN3bWRCVEdTQWY2eHlBWlBieUpiTnRSZVJFY0pnNGp0UDdSanlyZDJ6?=
 =?utf-8?B?SUlhTzFzZ21neXlESWMyVnR5cmxndHB3b25sWjluYnZNTDFGQThKZHZHUm5n?=
 =?utf-8?B?eVpHaS9jdlFWeEhQRzNzL2ZiazVXZ3dKb3U5enZ1Y1B5TEtjZDk0NE9WSXB4?=
 =?utf-8?Q?+BQT7iFqiFLzoyOqyAl7QyawW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af33fb98-db42-4e72-f7d1-08de06753ea1
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 14:16:16.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69/Uh6s40MeJ/ELGaNAHumIBMPCcSdtDv/tpjUPK464aYG3q3LdgRSRrbwVz6tEs4Rr7FtMLmq3KNjuVU4ucGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945



On 10/2/2025 1:00 PM, Nicolin Chen wrote:
> On Wed, Oct 01, 2025 at 06:09:51AM +0000, Suravee Suthikulpanit wrote:
>> To support nested translation, the nest parent domain is allocated with
>> IOMMU_HWPT_ALLOC_NEST_PARENT flag, and stores information of the v1 page
>> table for stage 2 (i.e. GPA->SPA).
>>
>> Also, only support nest parent domain on AMD system, which can support
>> the Guest CR3 Table (GCR3TRPMode) feature. This feature is required in
>> order to program DTE[GCR3 Table Root Pointer] with the GPA.
>>
>> Signed-off-by: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>
>> +static inline bool is_nest_parent_supported(u32 flags)
>> +{
>> +	/* Only allow nest parent when these features are supported */
>> +	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) &&
>> +	    (!check_feature(FEATURE_GT) ||
>> +	     !check_feature(FEATURE_GIOSUP) ||
>> +	     !check_feature2(FEATURE_GCR3TRPMODE)))
>> +		return false;
>> +
>> +	return true;
> If the "flags" doesn't have IOMMU_HWPT_ALLOC_NEST_PARENT while one
> of the features is missing, this would return true, indicating the
> HW supports nesting parent, which will be logically wrong although
> it does validate the nest parent flag.
> 
> Following the existing coding style, I think this could be just:
> 
> static inline bool is_nest_parent_supported(void)
> {
> 	/* Only allow nest parent when these features are supported */
> 	return check_feature(FEATURE_GT) && check_feature(FEATURE_GIOSUP) &&
> 	       check_feature2(FEATURE_GCR3TRPMODE);
> }

Ahh, I missed this part.

Thanks,
Suravee

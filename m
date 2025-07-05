Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD52016A956
	for <iommu@lists.linux.dev>; Sat,  5 Jul 2025 04:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751689918; cv=fail; b=kfj8JqAsuj74c8BrMOcW7ZkKJGXXm7bpaT/72B0frfuhR2sWo872ZlPFYDv7ACyiv0uuSA1j6l0puOBygScFpMPpjZ0tsOvaARKAu7Pa6FuWXjUHV5/irBRiar83g1ipKygR7e4sYtJp4p1NLGAoO3sciWP0BHc0+CQde+vRAX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751689918; c=relaxed/simple;
	bh=+3IeMcY+qmY7uccs4IhvSHsH+XFvfgCqIvs9RTaQajw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5AhwBEnhjy2MmXlZK34D0VlX4ai/g7URnJ4wn+zSFkvzGMqzBahP0mxKGXhcW7QTg/DrHz24VE5qLdSRuDhLdQv8puL3y+S/DMKww34bINiFUSRl317ASNnqjsPm7bOLBhEdP8scWSnur1QoqQKruK6OuAnCHt6JkDs9L74QNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nhpsp99l; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nhpsp99l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1TPTe8LJcLq1aFPc4wDzkvfO5mAFKtIYEMKj0UhRiVsL6VEfol2r1LmgTL/1lR9yVxRIdy33dEDrjazlWchhknu/pFdbX9pYFOgPr6NVM5PCj+npMtJZ/d8sKpMK5mH1guuXAgetfwCfjoea1uaE/NHecKX3Ob/lSnaS+a9URP5SUL/CX5wRprBnDL7FQWDe64tK159AtM/WDIO0r9FEvkru3tSiHyDgmAe8K2u6x8rIaVTI/FHzPs8LfrRPJN4ykdy9yt80KYcpgqTwBzDVoIwZ9xcnlpEiWREyc3/N8YfMux+srSi1N7W//K6z1k7N6GpOtvM6gextcFaPTZwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/yODdWx3LKXEzNeDjqI507kxLvoJsWx2YmrUK4L1I4=;
 b=vt7m6IpRG5zAhte5nVJcT4dGrZ3E1DMAzAiEzdbtOLV8LcMnnh4GLbKkKZ4+OQ233OBK4WBH1JdRJ13TJ44dPEypor2tYUD06b0eJ9AnogFGRTTpq9D78r0zlj2ugeiy+bRtk/5bqZPeCyoy+YoBLcdp/qZ9PhfnTDxY9zv6MFAUUk70DwTUKfxFh0IrDTTp3B7Tqn916E37M2OmLKPOAhsMUBF8jgzy7kBxoKoRSHHrJReJWUalTpJWzxlKa0+HptXxedkv5CsLJRDqHafXX8mxxbDsYfq+PuLw2axyUTMWhZultJBg+2wN0otWlLEptb0DUeu32WA7KLP4peIqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/yODdWx3LKXEzNeDjqI507kxLvoJsWx2YmrUK4L1I4=;
 b=Nhpsp99lvv7y/jzny/pEZYZQ2llCj756M4+iwG3hHMUVJy1cqXuvOwiV9opsXzbN+HKjhiBNgoPsDch0lrS8p7DA4efrIuX8CH12hkOeN65kefOsRf9vydW4YDu+PEyfMa/va907tosAs/wNSDO+igtZ/wzGjBItWx/Q5b0jVsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.33; Sat, 5 Jul
 2025 04:31:49 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8901.018; Sat, 5 Jul 2025
 04:31:49 +0000
Message-ID: <64454198-4406-4933-bbcc-426132aea2ff@amd.com>
Date: Sat, 5 Jul 2025 10:01:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Enable PASID and ATS capabilities in the
 correct order
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jerry Snitselaar <jsnitsel@redhat.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
References: <20250703155433.6221-1-eahariha@linux.microsoft.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250703155433.6221-1-eahariha@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::10) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 11236fd4-814d-44d5-eb41-08ddbb7cdb82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEF1TGJsdXg5aTdjdU9tY29sQTBYRXpuNVBmcm1RWC9WSDBLaktob1RMSkFQ?=
 =?utf-8?B?OHdrWEZTVkVReUlNK0JnZlZlcWFpdmM2QmFyL2xsbDdkcEdiZHl0aDZZdmVx?=
 =?utf-8?B?Q3dFc3ZYUWd0ZnUvbEgxbnhLT1FuUkFwamxRRUFncjFaZksyeU9hNGhtWklH?=
 =?utf-8?B?L21JY3ViY2p2YytQZ0xPY1U3elluUzlBQVp0TXA4WHJ2elhPZGdERTJuenRX?=
 =?utf-8?B?dzVvd242bnBVK1pqV0RtcXFBczlmVUFzeitySmY5SWdoUGRYTTNtMStYSmoz?=
 =?utf-8?B?bGN4MjJQdVk4OHlwL0RHQ3lWbmtZVmIxcXR1OEJUV0Y0TnNEUWdHNVdzOEg3?=
 =?utf-8?B?Q3lWNmhJd1hhdW82Uk1aU1B3cktvVjFDZnFDOVVuT05hSWd1cFFVcCszcENh?=
 =?utf-8?B?SDU4Y3MrdXZuNW93YUw1a244bTFZMU56MVMxZGlPQmRSSWZ1b3BxLzNpUnox?=
 =?utf-8?B?akFMd0FSbFVOY25hT0tqb1p2OVBtb3hKQzRFL1FXeDFaZHR3d0VXRVBDN1FF?=
 =?utf-8?B?eGVVakpjdUNRSUY5YlJRZHp0RUVVeU1qU25VcHBDaFV0djRXYURVL20yTkpC?=
 =?utf-8?B?TVlTWURkSkVxcUx5LzVXYTlCTzh2Q3ZpSWtLUm5aRSs4bVc3SmR0SGZ2cFpu?=
 =?utf-8?B?NENGZ1MzdGo0M0tvcmNNaXZIeGhZQ3l0emtsZ2ZDVHZuaEMwQlFGU1cwQlRX?=
 =?utf-8?B?TnRtR3FPQXEwcDhydWYvaHlCdklJcHJpSW15NzNsUTBKS2xOeGc4RU9FMHNQ?=
 =?utf-8?B?Z3phQ2Q0YUFhUktNZ0F5QTE2dXQwM1hQSURJMUJHNEZ4ZFhEdURLRm1MRzZB?=
 =?utf-8?B?SWt2WTFGazd3YTVOb0R6YzFPR1NITjh0TzQzNkg1SlpiTUpXaW5VUGNsNjJa?=
 =?utf-8?B?WTN1M0dTejBHMVk2YUhTR1pGdnRuOXhJUTZuSktCNmpSenpMQU9hNXlmUS83?=
 =?utf-8?B?TUZyNC9uNTY1Y2gwMTkwdVZxUTk2d0dGT1lHOEtaK0tWUzBLTG1MazViVURI?=
 =?utf-8?B?N2c1dktKdXJrMlNrQmhWZ0M2OGxWM1NwMExSL2luVktHdEUwYmlVNkR5WFBJ?=
 =?utf-8?B?TFFFYWl5MEo4OHdOSWlNTWU4VmZZd0VERDlHM01SOHpCamRRaUE5dzBKbHIx?=
 =?utf-8?B?U3c4SmJnVVdjV2ZPbW1yNUIySUxNS2VhdjRzVnpQOWVnVVZ3STBaVlg4VnNS?=
 =?utf-8?B?c29ta3AwcDFFK25SN0YwSUZLNDJSV0hMdmpTNFEzT3AyYWxRKzlMa3BJZk9O?=
 =?utf-8?B?Y2gwUkxZbUJYdUFBby9tSkVVSmNpSER6TFJaS2xYVEM0S1RWUzZ4NUs5VjAw?=
 =?utf-8?B?NURybVI1WWF2c1BNRXE3OE8zdHNsdEJjeVdsR0RRZ00rTEtKcnY3eXpHVmU0?=
 =?utf-8?B?b3p1WTk5TWhFWkdEM0QwK2NWdTVJUDdUdUJLckZtUnlKTFhjaFViN010eFZF?=
 =?utf-8?B?MElKWlBQSzN0UURZUmQ4NUhkWFhxcmVmbjFOcXFDM0FzYUgxbDZoWXRUUDJR?=
 =?utf-8?B?aE1VeXpvRCt6RWk5Y0M3cmZOVVEzUUFwLzJOV1lPQng4d3NtZVdSZFVDaVRk?=
 =?utf-8?B?Y0Jobi83UGE3elJZOGZ4WnIwNlBrVzhoN2tUMUMyTjh0aysxWHBYc1NaYXh5?=
 =?utf-8?B?T1ArRzhSVDVZeUw0ZTlESGRpaExWWWphOW5ObGlaVGNmNUhHeWp1TzQzMHhm?=
 =?utf-8?B?UlFMaUdFRGNhc2Zkb210VSthQ2lOeHlLVjJScUtsd1FYN0xYUDU3QjBqWDRJ?=
 =?utf-8?B?RkhadVNLb3h5VjhTZGh0ZDUwSGMycDE5ejZhb2Q4dHRmeXNzeW43bkhHV3pw?=
 =?utf-8?B?d21xdnptVklxUTJTa3FRa01XalIxL3M0TG9pTGpPQkJjVnRPQW1CaWhKQ3N4?=
 =?utf-8?B?MEdMalVNcnJQek1wNnJucHFBNmc3UmJrRVNCd2NuajlYOUJucnVoOU83TlJC?=
 =?utf-8?Q?goGHuuFJzyY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWFPV2RQczViOXk3NEs5d3B2OG40aVBraW53T2NjSHlkRDNoVVZlSkZqTVJt?=
 =?utf-8?B?WlZXak44NjY5bHBQU1FQbTZ3UDZOVGh1cE4rUWZxTjF4WmVFTXA5aklKdFk5?=
 =?utf-8?B?TkFTb0E1L05NVExCNW9xSWh6ZmJsMElsZ3FJVGI4UDNnNXQ0a0VCck54cFZS?=
 =?utf-8?B?MTZIWnQ3L3lhZVpVWVdRSTBWaHdBV3NvY2ZGQVd6Yk9LaG1ZU01OSEF6L1dv?=
 =?utf-8?B?Mm1CZG4xdStLeHVoV3BtRjdmd29jam0yajd6Wm53MGtYNHhLQ2syVWRPOHph?=
 =?utf-8?B?cFJoVXJBSWNaejZ6YnljbHRuek5hSzJBdjJxTjZIQ3FZR1NSd1UycVFpd2Jp?=
 =?utf-8?B?NWhhSHdQNWQzdWY2d1lpL2FZbmlpcjJ4bDRBNU0rQTJKdElIejNVRUg5OFc2?=
 =?utf-8?B?bFNyU2ZxbVhvWDZDb2I4V1djQitTMVR6SVVvL0pOeklMa2ZYN0JsSXRzbm5q?=
 =?utf-8?B?UTdjaUJRbFRPbmtxb2xZdmlwUE5POFpsUmZqZTQ3MW51VUZYOEdqVVkwVU9H?=
 =?utf-8?B?WlNlMUhmak94MnR2dE5mSEozQldhYkU4aEVvY1Y3RWl5eXc5a011a3BZRStG?=
 =?utf-8?B?YjN2VitSZjZSRjRhM1Q3b3cvMzROanpFTFZiZzJjOHZUZ1I1dGhCQUE2ZFNr?=
 =?utf-8?B?cGFKemdhRU9MTUZBWUJYWlNwQW9aN3IyNjFLbnZOTHRUSzNTNmkyVHdENzV3?=
 =?utf-8?B?ZitVNThYYXQvdFloWWIrQytrOG1FdklOWTByc1Jqb1RHaW4zS1pWOTNYeXEw?=
 =?utf-8?B?ekYrcEx0bHdQa0ZqTm15MVMzSFZlQ29pVFg2em5rSGVMZFhzZThOdWFFQ3F5?=
 =?utf-8?B?WWpselRDNW4wcStlRnpnZGx2WTVEZ1NTd1QzV1F6bytBSURDbDZTTDI5OEVB?=
 =?utf-8?B?Sm5mSG4wblA5ZUs5djQ3eDlOREwyZ3VleERHcW4vWFFvMnpoNTV4WE1YV0Fm?=
 =?utf-8?B?ekd6RmFPTmFvekt3NWE4eWRUTlRMdXhKRFVDTTZBVWhrSndSN3ZlVjJVZ1dK?=
 =?utf-8?B?RWZFL2hZWDBvTmN4RHIxbksxa2xMblFjRGdlY0Nnbi9zSVRRTnA5Q0F5N3ll?=
 =?utf-8?B?M1Iwbm1IMW8rZm1wRDN4WmpwcFNjd3VCQ1Y4N2p1ZWNDbkZYcGJ6OHN2TXpq?=
 =?utf-8?B?dWZnK3lnV2lEU3VJRXpWUnQyR0Rhdk1LYVYxR2VRUGZlTngxUUVSSW1ZR1Bi?=
 =?utf-8?B?ckNHWExKMVJmNVAvQm9CQS81eGpRMWZyYnE0SldzR2JNa0R6cTJCYWphZmc3?=
 =?utf-8?B?UWNENkc2VHNSMzBGTVdEN2hCaWNxZjI1RHFpZzFGaTRKRFQ2bk9mOFZaUHM4?=
 =?utf-8?B?bXNoWjZzQWFqTnc0dEJPcVAvaXA0UWEvOFZTWG1Lb2V3YzE2OG5jWjRtYm5E?=
 =?utf-8?B?cnZ2WTJ3WmY2bUw4QjIwVTJBbTZUUmx4aFNqSHgvME1SbkZxWjdNTyszSUtv?=
 =?utf-8?B?RGgrUHRzZEl4bnlNVTk4UWc0ZkMxcjQ0QW9JejVseHNPbi83YVlMaXNKNm9Z?=
 =?utf-8?B?M1NSRkhBSHVWN2VjUDB5eUw5ZnRTczJDRHNJT1Z1SFZJbGtJQjN5R1ZFZlFR?=
 =?utf-8?B?ZkNvTTVXTjE2NnhSKytFdFB1VnAyZHJnU0dZWktxWkJmajhDZTkweFFlRmhl?=
 =?utf-8?B?RkFaeDRDUGxKSFZqWXNadkQvTFNsc293TVJlRkZQUjg3YklpT1BoaU5teHAr?=
 =?utf-8?B?b0graU12QktzZDV6Y1ppZzY4YWVLTUV5Y1FmdjBLN0dFeWhJTjIwb0pYb0R2?=
 =?utf-8?B?cGxrSDZRb3d6LzZqdVhicXJqeU10Q3pHR0tkWi84VzJ2WG5ScGFhTWR1YzZn?=
 =?utf-8?B?cnQxV0xObW5Kd3hROWdScTBGZlpQWmhFMnQ5d2tGVzJ0NjVYbFJrQ1JmRnJP?=
 =?utf-8?B?cGxxcGUyaEhIS2ZnSHdXUlhlSHRQZVUrc21FZWp4WjFKb2tRODZNOW5lbUI5?=
 =?utf-8?B?SFM3bERmdk9PR0xaOTZMNVlqNFdhUE9ZT1NvV2JJUzZIQXluVW5kVTZLQzJn?=
 =?utf-8?B?N3QvQlNDWkZHaS9PRTkwR1hRU0w4T3Fuc1AwejFwZS96R3RGMURIb2pYV0lN?=
 =?utf-8?B?Q3RjSTJtQ053UHQycnNpeE5yeCtpak1ZVGlZNHRSOTRseCtDMFVqNkl6T1Rk?=
 =?utf-8?Q?Fay4Cgd+/ywhsW96pUy/UV9Nb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11236fd4-814d-44d5-eb41-08ddbb7cdb82
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 04:31:49.1165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSaZbeVLopEzLH6Yq4h68xA/EaY+lbZg2Qi8NiTWjGT+b2LKlo6+HsEwEWf6rnVUjXJj3LOs3UAJq661XyczbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376



On 7/3/2025 9:24 PM, Easwar Hariharan wrote:
> Per the PCIe spec, behavior of the PASID capability is undefined if the
> value of the PASID Enable bit changes while the Enable bit of the
> function's ATS control register is Set. Unfortunately,
> pdev_enable_caps() does exactly that by ordering enabling ATS for the
> device before enabling PASID.
> > Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Vasant Hegde <vasant.hegde@amd.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> Fixes: eda8c2860ab679 ("iommu/amd: Enable device ATS/PASID/PRI capabilities independently")
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Patch looks good.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


-Vasant



> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 3117d99cf83d..8b8d3e843743 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -634,8 +634,8 @@ static inline void pdev_disable_cap_pasid(struct pci_dev *pdev)
>  
>  static void pdev_enable_caps(struct pci_dev *pdev)
>  {
> -	pdev_enable_cap_ats(pdev);
>  	pdev_enable_cap_pasid(pdev);
> +	pdev_enable_cap_ats(pdev);
>  	pdev_enable_cap_pri(pdev);
>  }
>  


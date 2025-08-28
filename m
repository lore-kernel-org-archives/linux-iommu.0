Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D9B79F5
	for <iommu@lists.linux.dev>; Thu, 28 Aug 2025 00:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341423; cv=fail; b=TZBKh13dH70T1jTHCue/ydZkN2asni31rmA8YAchkip3bw3JLoCn2TkqmWbr9us2ZaPJT9vKijTSRRXnOCPBVzSmJ5DUZXCL19YCMGd9SJ92Kl3s50sUUo13Lc5LV2xtUA7DNEVBaa6dmOlFgraiTWTimY9v7XjF+W1LMIf0sLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341423; c=relaxed/simple;
	bh=2LrcpsV+dXXnwv+QimB02Xsq39bLDpDyAtXtPs/5qGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WP5fWeAeSUvrMt6UK/VF5eoae+pg7tKm3RcJR0yTqMua0qPWoujV43XO7a75ldMvl8wObBStqw647GLWHToUZ4iOodMSTHYoUqaPEwGnR+ggCrtNBqJ9GAGBM5NOQWu4Eoxp7wh9VENzgImbSiFwt5gdyPGBG4dii6X4B3pc48g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vqU2aIJ2; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vqU2aIJ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb8nAyy+0GCuIQ4NtxyPuZnkTL9vAEXxIZbjgxRXwuNDXp8Op/kb6vFX0V+YMpERrY8erVrlI1cOF7PdGtbiXepq3i+0zwAOlr7EZP/eWIDzJDcRPSnZWvb5h9rgbWFWidUlTQkldINPfOolywWr47SNWwUh+rm9WrGcKkJKwXuyls/+x5lCRJAXr47FrUjEku6DhPRO6ewm5psdRZuK9Qtv1qzrwYbdMukU7N7DPr8LLI02rvzOVopmSyDh9dS3c0SzuVL2qUcybzCSMXoUKdTqWCYZzB1ITfDVCZYCwsPo6ACNdPJFP8eTjm7PiKo6XzIXNl3UVkaNWVxMJbpjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6bSHqFh7pbDW+G/PJXUfnr6oljVf5tNtmLOcdFwyoE=;
 b=EOVAZjCJzg7vAzX/EUanRIidF7fxDWJXwBvdZRbG8UgDzBbIMmxC++PQtnHbK8fNa4jAgW7VuuOgtBhlnXH/t70V4gpp4jPirpvSynz9HuyT7SEOURRh8OEdnZzTA1BDu6uSDIpuD5sdkf84A61YNjbaYa7Eni4D5atLIgHx+vmWEccssOwdK1X/BjSz6dF08F7Bv+CEzKGFvvMrTaKgXV2cgkj6dSs5ItPR7yV/Y/oXFTswTLWPa+MgBrI3JYSlaZy4ErAhQwF5LFNiPsZk/8+Cucu82n22wNVKudLTfsUG3kEjSiEhhOCR6UJm9HqG8kiI/p6w4k+Ql11njS7o2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6bSHqFh7pbDW+G/PJXUfnr6oljVf5tNtmLOcdFwyoE=;
 b=vqU2aIJ2jWhrcZ4EkaqlFTiQ4kkCBrTwreq7yB0lAxZ/HtfpEA3PcrbPD9RvrUucHtTIfd15gCpOi4OaEOmreWEqjVD37xjRkFZ/SFS8RM3Rq/KnxDc0IMQrLWJJ13bCkzNSeJUQ7ddVie6eV6BoxGAik5ONzeBvJIl/l0gGOAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Thu, 28 Aug 2025 00:36:58 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.9052.023; Thu, 28 Aug 2025
 00:36:58 +0000
Message-ID: <5a0fcde1-d746-4663-bb9b-4eeb3c9036c4@amd.com>
Date: Wed, 27 Aug 2025 19:36:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] iommu/amd: Add support for nested domain
 attach/detach
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
 <20250820113009.5233-9-suravee.suthikulpanit@amd.com>
 <aKjRB5MqCrJ2Px7G@Asurada-Nvidia>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <aKjRB5MqCrJ2Px7G@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::12) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CH2PR12MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2d0e6f-5636-46bc-e900-08dde5cafef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTRSUXpyaDBYSWlycFNidmJiSkNUbTdSTndqaytSNVBreUlmS25LaHlzUy8v?=
 =?utf-8?B?MGVKUGxsb2tNUEdGS3VCZm1mWjZXNHdTcW9DY1BHRU5kOTlJTld2MTJOSVFN?=
 =?utf-8?B?MHRJaWFYR2VwV2hNdlpOeDZCRUZRcS9ZL1hVNStQSFdhWU9PMXdTM294Z085?=
 =?utf-8?B?TWxYblU3b2FUOG8xM2JReFpLZ1RZWXJZYUpmam1PSG1OZE9kVFhGQnlwNy9O?=
 =?utf-8?B?eXpKRDhRQmFKbS9vbzd1dFdrNFZ3aHJBMDRIYkhCOTJLNDB4VGhHYjFUM1lM?=
 =?utf-8?B?Z3FCdFlaRi9BWjdWbC9DZGQrNFNSQXVYOEsvQklaSUxpMXNrUlR1amNxTW1E?=
 =?utf-8?B?MzIzN3Rua1pPbjQ2dzhjazBmTkwzR1JyUkt4RDBQVGxkSjkxZ3owTi80WGxF?=
 =?utf-8?B?bFJ6clBkOUhuaWNRaGloTktSRFlaQi9oMDJmZ0l1SWF4Y08xL0VLZmhaVENq?=
 =?utf-8?B?UndUYTROOEhJSDBlY2hVQ29jMHlmQkZEVDVFZmcrbTRiSUUxaUlSYjBNbExF?=
 =?utf-8?B?YThCYnltQyt0ajVnVWx1UlZkSUtya1VxTUJyRXRkR1YrYU5laUo4ZVBoWWo4?=
 =?utf-8?B?YVhTanpiYXhNalZycEpzS3VxZHNjMDdhQzhybllZdzFjbEZLWWJwck81bHg0?=
 =?utf-8?B?VzRNNUJNeU1TWHRMRHdocktGajQrRzIvR0ZuRE44TVJmbk53ZnM3bit0eWJO?=
 =?utf-8?B?UmJTeFFHRU56U3pHVzJiRlgySzM0ckdlb3lLaWxwYUhqaWpFSFI3Q1NtSlZu?=
 =?utf-8?B?aEdoTVdpNTRTbWdDazU0N2RVWitUdzMyUHI2dy8xSVE4U2VIK2MvaVArVjNr?=
 =?utf-8?B?MTQrMURERUdEV1dqUUJTVmh6dnkyQ1NRUnpxL3lWcHY4M2RockZObit6ZUlQ?=
 =?utf-8?B?dXMzTXF5bDdhK3d5aFhucWN4bFVmMCthQm9HdHV6dkVMOUFqeVZ3Ym9wa0FI?=
 =?utf-8?B?TXRJNTg2V1V0NUw1ZDZiYVFzVGszcDJCbE9rWVhtcTZSdHdzRXlCZnVKOXZj?=
 =?utf-8?B?SW5LZ0dubHVPVGRjcDVRYXNsV3dFVDhuNnhVK2swNkZ4UUdXRkpoY2JabGc1?=
 =?utf-8?B?VVF1Qk4rY2Y0ZVYza0FMZUFJYXlsckY2Y1JiT1VkYVdjZi9SQ0FLR0FRNDhx?=
 =?utf-8?B?Vm1rK2hpR1plYU5IK3d5Rk9kQU51YkxJclBQdmxYM1J0VFpSYXJsb0xWRUhB?=
 =?utf-8?B?eDhPUlFCcTdrNHZjaUhwNjBtbERUTkQwNXpzWTR5VHVXOVY2RGpRaGJTclFy?=
 =?utf-8?B?WlhEQ09OdUtCa3hsU1llakQ4ZmpENkt0VG82K2t4djUyaU1yZnMrZGVYV0l1?=
 =?utf-8?B?RjVKdlY5bHY5VC8zdlBnTDZvbW9UQmNqclBWaWZyYndZbWhhUUdPcWJQL1g5?=
 =?utf-8?B?OWVOQTR6ajdrRVNPYXNlTncyNTJhMWNRdk9YWGdDRkZKajhheEJQS0w0akU1?=
 =?utf-8?B?aTFpYmVUb3B4dkJ4ZTZRSExRT0hXcVRuWElJQndmSmEvUDJNWGdvSXFJU0Np?=
 =?utf-8?B?TTVkM2ZLS28rb1dJbDhqd0FtODY3OVhGRmRXZjJaMjk1NVBLcHlBSWE0Vzh1?=
 =?utf-8?B?eHpBY2lmOTJoMEFBdzlCMkNWaCtEMDIxK3dUcjJxWEVaQUtRc0dJSWV6c1I3?=
 =?utf-8?B?TGFTNFE3VVo0N2xVR2hJZlJKMnlRR3puUjJKZVVLS051OXVMT1JVZitISkVR?=
 =?utf-8?B?YmlNL0J3b1g1S3V2WVd5WDc2UFhtWE9KejJaUG44elVDZDBrOG5vWHV1KzhN?=
 =?utf-8?B?UUVmSWNzTU1WZlE4eC84anEydllBdkVTOHh1bnFHbkFkZ0U4b3pTak9WZzRh?=
 =?utf-8?B?OVpPTEc1ZzVUemc1QmdyaFo5VktxbEhIMUoxbTdjTGR3VE82OGU2WEE4K1dG?=
 =?utf-8?B?ZU1RK01tQ3VKaTN1b0VKd0owalovVlJxeVlKdndIKzRzd0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHZwOWlYMDJjSkpGRFdaU05DRGFtbjFsS3RvVTlxaElkT25kTDlMNlJ1eWtO?=
 =?utf-8?B?T0Faa1NPTFRXUTFsNVJTTnF6aEJvZ3UxQ2c0REp3c2xRODRxbngyekhKM3R6?=
 =?utf-8?B?K0gyUlJpUDJzRjcvdkxJYjYzbTRUL3pzWW53ajFpOWVRNEJnOGxTVW82T2dy?=
 =?utf-8?B?MkYrTmoreHo2QlNDazBDVEhpeCs5Vlo3N3BBd2J1MXVJNnNJbjd5TUM4RWtl?=
 =?utf-8?B?Q1Fsa2xrT0tQTjdiSkJWVmVZdTFsWnZCbkRwREQ3bWFkL0Q1WjJYM2JwZmhC?=
 =?utf-8?B?M2RhQ2drbmtEa3BWNWU3MTVTVmlGSjdMckV0ZFowQUQ0L0NreGVKVXgwRXVI?=
 =?utf-8?B?aStmUGtyajQxZlRBYmhCajd6QnZvdmlBUk1zNEg2Y2IzcFJXWHFWcm9WUzBS?=
 =?utf-8?B?RVhpZmkvcnlkN1hwZ21YekQ0VmEzRmxsM2svYjc0YmdmRkFHSUp0MEZNcmlx?=
 =?utf-8?B?OUNPdDhvSDZvTHRsOXo4MElMbHRuVi84N2lpU1V0N3ZqeFZYd25GMWV1ckht?=
 =?utf-8?B?OGpyRXpZYVZRVUVpRlIxcWFXa2NIRFJiN2hoRDVkUkhNNUhtMDg1a1VvZnZB?=
 =?utf-8?B?aWc5dVRVbDEwL0xxQ3FpY05zSDFrMjhqYXFQV2d4OGZYN25wT044cXZMZStZ?=
 =?utf-8?B?aDc3Z2d2Q3pQU013WE80bUVHdjB0bk9IK0lzZkwrczVnM05UeHk1RWlJOXRI?=
 =?utf-8?B?bUUxaFFLUld4eHNqbU0yWURYQzBuUGEralNBaDdYMDNZNVF2MTVxZTgrTDd4?=
 =?utf-8?B?dTZIWlVUUFJOVlBVbTRBdmU1WWZkNUtqTFJUUGc2U3JDaTg1TVo0ekNUSW9B?=
 =?utf-8?B?dE12SmxUVGRuTDdNVGgyOUNlNVB0ZDNDbVk3bnV2Sm80Z29uQ1E2ZkhBYnI2?=
 =?utf-8?B?TXllNFBjMHpSUktPK3RGNDMrL0pDS2VjM0pFY01iZkxnZVRpSEdiZnVnMDhN?=
 =?utf-8?B?TXN2ZE5UQzRtZ0s5QWp0Y0V1YWNIQXlkazl0cnNkNjFGN1N1aEk2K214RVl2?=
 =?utf-8?B?TTMweDFabHV6NFNPRUx2NHBURHpvWjBtalMwcWZWNkY5WnFxeU1qN2xWSUpa?=
 =?utf-8?B?MFdZOEhjTU5CV3g1TGcybjd1RHhxVld5UVpURXFjNFJOU3V1L044T3NrTDJo?=
 =?utf-8?B?VUZQOXdCTE90QTBHNHRCSDRrU3AzUXNBZjhZSHUwNWI3TEtIQ0tGdisvcjkr?=
 =?utf-8?B?ekFzZXVHU0VBYisybWZ1VFJ5WDRBRUViSnJVdzY4d0RwM1Y1SmdtVjJkK29N?=
 =?utf-8?B?MVNhQUlYNTBjb0FUdkNOeVRHRFcwUzdDU2JGNFhhTUQ5anVPMmp3SG9uWjBm?=
 =?utf-8?B?VytRZUpsa3Z3LzNUN0Y3dW96ZTY3U05pb3J0NGNDVVFHTE1naUpsTmd6c2Zm?=
 =?utf-8?B?TlRmWlJkaVAxSjFkM1pSYzNLaXBJQmF2UVYzTVZMRkp3YXRLQ0RKRGNMVEkw?=
 =?utf-8?B?TFEzMENmVTU3U05KZlRtNXIwUFcvU09DU2ZpY0o1VmNMMklQcjVraFUyS1cr?=
 =?utf-8?B?aVZCc1lSck5xaWp6ckNjUHNiKytJNFRYZ0xwUlVNR0NCZ3dwTXZBS3FwODl5?=
 =?utf-8?B?QzNpWVg0YndRMUJSN3c0QWlDMVZmdDc2THFYQnJidUx4QTY2cmJHWGJIU2w5?=
 =?utf-8?B?a0czUUJtNHJYWFZNRStpVlJ0TE1yODRyRkdmS05TTUpoczNuYWJETjlqMFAr?=
 =?utf-8?B?UFhGNU51R1IwMk1vWEwxdU5xSGVubm01UDE4YnQ5YkZOVnFXajdyMjRESzRz?=
 =?utf-8?B?YjVKMXA1cUovVWd3T1M1WE90NlJGMHQwbW9WZlM4amV0L3AvUDlWak4vN3A2?=
 =?utf-8?B?MXFTNDN0Q0NUMGFFZVdwZFRLNUpWRVRxUEFSeHRKZFNmWmRzeXlnQjhvSWlK?=
 =?utf-8?B?M0wrNnZ4eTR2K0dPcVp3UXQ4bFYxaGN6a05WaktyZkhUSm0zM25QYW9WVmNn?=
 =?utf-8?B?QlUzdHVKNTlSSjVsSUtmOW4ydTZzRTNXamdxeDU1VHBUc1VEVkRkRjNhTGFU?=
 =?utf-8?B?bGw2NDA0TnJ4WnA4K0NpaG1pbkorRjBSb2Fnc2lMbU9ldG1kN0p5MUFoYVM4?=
 =?utf-8?B?allIa1Rka3V5WGE1MWRQRk1BVTJZMU0xZFBpYlhuUnU0d1A1eEpoUkNGUjYr?=
 =?utf-8?Q?Poguz6ZTKqHb3w4oMxe0iR25m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2d0e6f-5636-46bc-e900-08dde5cafef5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 00:36:58.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DGPbC988LkbpJL3LJho0/M7gmQHywMMZsEdKCLtAYG2+MI3UfgsdVfQWTFzD8YFNE/yDJc5yWjA54xZ6aepXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229



On 8/22/2025 3:20 PM, Nicolin Chen wrote:
> On Wed, Aug 20, 2025 at 11:30:09AM +0000, Suravee Suthikulpanit wrote:
>> +static inline bool has_gcr3_table(struct gcr3_tbl_info *gcr3_info)
>> +{
>> +	if (!gcr3_info || (!gcr3_info->gcr3_tbl && !gcr3_info->trp_gpa))
>> +		return false;
> 
> "gcr3_info" seems always pointing to "&dev_data->gcr3_info", which
> can never be NULL.

right

>> @@ -2061,7 +2087,14 @@ static void set_dte_entry(struct amd_iommu *iommu,
>>   	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>>   	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
>>   
>> -	if (gcr3_info && gcr3_info->gcr3_tbl)
>> +	/*
>> +	 * For nested domain, use parent domain to setup v1 table
>> +	 * information and domain id.
>> +	 */
>> +	if (amd_iommu_domain_is_nested(domain))
>> +		domain = domain->parent;
>> +
>> +	if (has_gcr3_table(gcr3_info))
>>   		domid = dev_data->gcr3_info.domid;
> 
> There is already a local variable "gcr3_info".

right.

>> +static int nested_gcr3_update(struct protection_domain *pdom, struct device *dev)
>> +{
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +	struct iommu_hwpt_amd_v2 *hwpt = &pdom->guest_hwpt;
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +	if (!pdev || !hwpt)
>> +		return -EINVAL;
> 
> to_pci_dev is a container_of from the dev. !pdev indicates a !dev
> that should never happen in the path of an attach_dev op. Or, did
> you actually want to check if dev_is_pci(dev)?

correct, I should have just checked for dev_is_pci(dev).

> Also, hwpt is "&pdom->guest_hwpt", which would never be NULL.
> 
>> +static int amd_iommu_nested_attach_device(struct iommu_domain *dom, struct device *dev)
>> +{
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +	struct protection_domain *pdom = to_pdomain(dom);
>> +	struct pci_dev *pdev;
>> +	int ret;
>> +
>> +	if (dev_data->domain == pdom)
>> +		return 0;
>> +
>> +	ret = nested_gcr3_update(pdom, dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (dev_data->domain)
>> +		amd_iommu_detach_device(dev);
>> +
>> +	ret = __amd_iommu_attach_device(dev, pdom);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
>> +	if (pdev)
>> +		amd_iommu_pdev_enable_cap_ats(pdev);
> 
> Is "dev_data->dev" expected to be "dev"?

correct.

Thanks for the review. I'll clean up the logic in 
amd_iommu_nested_attach_device() to return error early for non-pci device.

Thanks,
Suravee

Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482F14F11E
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715602686; cv=fail; b=ScqMFFVGusVlq4v+AMpzs7+aRKNb/c/j8/tzdMGtj5TLFzeezqoR6mQz4O6HGliPciBWy3PZHJ0A41JaKHcepFh/eHnKB4/usD2lYSKKZTvPAk3OuIjxTFoWpPQ1Ym5OkYwkdqOcB1dIqV6BuFLC9u17cXoaWDag9fqC83k/bwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715602686; c=relaxed/simple;
	bh=220Mm3jgSZ8DbDyPYVIilW6n9goMh344A/ayCWMFqgc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EyLHWTf18iWxt9VE6021t/OBiXuKTSAOhhzB3Px+lcfYFFMzpZRnnJTKdDbHEFlJEARBKiL5o3M69jwAqmzZNHyNgaw4LiT+JFFel2y9xOOWNEUZABBdHH72fNLtkUkpD8oaHYKnwyEduM/AVK/1U9XFjH6UFAiHkbfsaUL017U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hjS+NLT6; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hjS+NLT6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ao1AqzgCO7EIbGyxCMTqdLBtrBXg0bofeZO4lQ0FKaTnYx9xES1AtDUgRmSUWRvj+OVCYpiJemF+6CUPq14Xp1zbCrAqBGtE4KCtRSdOYVOaFBFykRcfmZ5d5sOa3IGAm/Qf+cNNp1jAqd9dJ1XR2Jo/rq93EpptDMoVaYxJNRHV9ARC2ezzqQSFFkBMzh1du2T9xqtI45D4ONFqSmMXUTEtCuun94+hiGXsdz2XrdH9jh8QaFr+ACaZIWZk9Rip4gWiSalOeWfhGkUXEdDQgxbObsAv76iHe7snM2KTFmfhRvFa2rr588yX8AcrQ3CWYuSa2JIedc56mWaW3iANhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBFtBUCVKOOV+LhCF3nITRhwbvk8t+D21PJ0lFVk1wk=;
 b=RAQZU4RRqLdzQU1LpqKkdITD9JzrGEGUqDanH/4wIeE+LED07rqwm0L70tBLUUTdyf0WT3kipJxTdk+dCp+gRgjvpD4NW9ErtT0b/dywETiBHomcxstJDzQRx6q0IdyGs0KSLOOiLlBGpcSTIjQihPG1mW9PYVFALwvzMNXUgXNLEqy2MozwxGLvhPDLklbMDtbJXQt+7yw2vtt8VX2sjbo+HL0hXGnV71sh5UXOycsa59ETwxugge/T8/HXeMoAHlinykUxR529zl3U0f7Xpdj9FOH8a0NQJ5F+6E2p4tZ7LswEXMVXg6biZnp9A+Iz3ksXg3LnzSZRlz+SZoNJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBFtBUCVKOOV+LhCF3nITRhwbvk8t+D21PJ0lFVk1wk=;
 b=hjS+NLT6Sb0pkkGAJm+b7/hUom394SxlJuXxPWFo2M2uoYP8MTq2y4/YOcUJIQW2Y5JRJ3hkXuC9QYOFeobbUVCihtwOnNG6JN11S4jFW9nwAp42CYjH8Ij/H4st5A4kMiVsEQJPbeiJMMj1zd2LMRbZhDMIewp8fmjPH0ha9uw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 12:17:58 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%7]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 12:17:58 +0000
Message-ID: <aacaa02c-0e58-4a0c-b180-f201f483b70b@amd.com>
Date: Mon, 13 May 2024 19:17:49 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] iommu/amd: Set default domain to IDENTITY_DOMAIN when
 running in SEV guest
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 thomas.lendacky@amd.com, vasant.hegde@amd.com, michael.roth@amd.com,
 jon.grimm@amd.com, rientjes@google.com
References: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
 <20240430152430.4245-10-suravee.suthikulpanit@amd.com>
 <20240501141737.GB1723318@ziepe.ca>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240501141737.GB1723318@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f9b6d8-0932-4332-4f57-08dc7346b8af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2svdkpDNElkcWFsN1FjVFkvTmVuV01uNHpSTmUyTDJrUmVDVGdNdmVQejdU?=
 =?utf-8?B?TjdPSG8yTGp3dFNRb0kzQVVFN2JlM3l3ZWdUNzRBVVQrQmMzL0Q5bGxadVVK?=
 =?utf-8?B?OXRCRlAwODlaSHFBZVkwalFTRWY0SEprclN3L1VxRHliaWZ3NVEyalRKeXZn?=
 =?utf-8?B?UVA3M0pCZE0xS1krNmNvbVlDdVdFdHBUSFc0bUdHYmxRT3A4YUNrZFMxMFBM?=
 =?utf-8?B?Y0UycnlHNUQ4KzZJOFd1a3UzOGtJaE1QUFo0S05yYit3V1BoOWttUk5tOG00?=
 =?utf-8?B?VzJiU1hTbmpaMzVpdS9DZ3l0RHlDRHhTNFhWWDBkL2x2K044SmdBMGkrblJj?=
 =?utf-8?B?Z21LcXhYL240NTAzOXVlcjV0RUU3UWNmbnpiYkcrT3h0N3FmR3YwY0ZlZUJJ?=
 =?utf-8?B?L2p5dGFlc0VXSmRjeCtWV3M3TmdvU21mS2FSZDFhaG9jblhjcENORllOUk5E?=
 =?utf-8?B?MlFxN3RkNFZCMWtBTFNMUUFjTlNPVG9SaGNDV3FwMWlLK2htWW95Q3JQd2c5?=
 =?utf-8?B?TlhhZFVLZlV6WVV0Q2dLZ0hkcUVyTFdWSFowckdBcFpYTHNZb0dKUHdVaHVy?=
 =?utf-8?B?L0xqSnZ4bzdPT2w0R3NHZllWcWxOekFXbDlpMGRWTGJPRG1CVkwzbDRGNXFI?=
 =?utf-8?B?L1pmaktZVEZna002Rmt2amx5eTkyTkllOUFrRXpKalBJdTJvNVhVeFdCQjUv?=
 =?utf-8?B?ZlZpZURia1RNSVZFeWw1UEdoWW1HSFZUdDJTNU1FdUxnbVV6Um8vOTZYVEZX?=
 =?utf-8?B?TXFsNjZkTlAvNEZZY0g1SXJqcGNmNFNPRVg3VEtKQkQ3OHQzdnI4NUx5emo4?=
 =?utf-8?B?MmtXQlR0MTl0YW43RjhmdUhRbU01SVNvb0NRQ211c3c2WmN6TUU0dUFaVFFk?=
 =?utf-8?B?T1V5UE5HeFB5cXNTSkhGY2FvKzRCYk1ZMHdxakxIR1ZIdzRvUk9vbnpYWllL?=
 =?utf-8?B?akc1QnRMSm1FbWUyRDlEMEk4cm1zdWZzYTBEbHV1WWszbjZxWUl4OUcxTGVY?=
 =?utf-8?B?SXRlelJNTzVQTGlRa1lrc3VMMFZTcFJZK2NQcjVXTkdjZzhOQ1k0cytodWlU?=
 =?utf-8?B?aEVVdWpYZERSSzVpQ1RxUmplVU9MZ1BkY2lyWXhTaytycXIvWkhpMlRpU24r?=
 =?utf-8?B?ZjNMbVBOZXhTTy93T1U1dGw2STI4QU9zeEZQVStLa093MUk2OXZlbEcvVDFH?=
 =?utf-8?B?S1U0MGRwcWUzcWNsc1o5N1QwRHJNYUhoVEZLMEY1UktDSHZNUmVBazZTNDYw?=
 =?utf-8?B?QkFNekxCNmRteHhaMVJ4VUVmZlJWMEhFYjUvUjRCOU1qVUtVeDRzOFJ0eDNK?=
 =?utf-8?B?MjlBa0lmejVMTHZVQkh3TmdDYW5aK1lxZy9KMktVY09WSlVqT0hNSjQxdklE?=
 =?utf-8?B?Ty9LNHgzY3RqTEFNZnBlNmx4bmJ3VWVvcWFOdjc2Y0dTcHZpSkd5ZFdIcTF4?=
 =?utf-8?B?M3VKKzg2Q0lNbVFGSTE4ZkZsNFBOM0NsT3IwN1QrYU5KdlcrelN4U0MxK2J4?=
 =?utf-8?B?SGpidGJENm5rL2Y4aWRKdHp6cm5QMjBkaWROOTJtUCtvQXcyOGZ3em1aNzNa?=
 =?utf-8?B?WUpMRlVwbDM0T0ZIT2ZDc3l3Tkh3RmUrYm9lLzNZdWJ3K2lXZVV3b01Rc3lS?=
 =?utf-8?B?Mkk2NGE0S0gyZ0F3R2FrMy8rSTRVSjRTMzAzQm8yTVNPbWkxRFlibkMxSWZ3?=
 =?utf-8?B?NXA5QlFtVGhBVW9sQVBCZ1UrTS9lV2dmS0Q5L1IzVzAyV1R1UFB1bHR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzZJTjAxZ3FrRlFQUWNkeThBWnhweE1WZXZFVHd1WmtsMmFORDVOMHhSWmNC?=
 =?utf-8?B?VlBSMUVxZHJtZjVQUWhYdkNhUEZXcStacmFKRGxqVTkyZDJxaEJxSlNnSWxn?=
 =?utf-8?B?QkgyNFFnK0ZyaWE3ZDVnZTRhNEZ5K0VMNUcyU1VVMTFGb2VMSWQrKzlMRkZD?=
 =?utf-8?B?ZVVSM2t3a2xhWC8vRHBubXQ1TnoxL0hNUitzc0NXNWRXNjcvMVRRZG5ybEc5?=
 =?utf-8?B?OGduZG1pcHhsN0YzSEc1M3BIa2FNdjlUOStCWjdLTFVwNEc0am00UW44YzVN?=
 =?utf-8?B?d3Y5eks3QkVsVy9DWWVTVDBTM2o2Ym01M2VDb0xRMm1vV01DNGszK2VGVjlH?=
 =?utf-8?B?eld0OEpVd1BOQmJJQWU0Z2pHRElBZUV3UmlwRmlIS3BXOUEyeWZPOE5ob0tN?=
 =?utf-8?B?K09RZWlzbFFYTjVBcnkyQnhXNVZtazc2bVFpRkRBTktvOUxaNnY0S3Eya0Rq?=
 =?utf-8?B?d29pNVZCSzdqRE1XN3NxQzBrZ0FTMDFOeXl0VGlad1pmaDJXOVc3OXR5RFZ5?=
 =?utf-8?B?ZjRsNkhnb3owUG5Tc3E1SFM3ZnFrYVJxM3lJbHMvdVQraG53NVJwMURBR0tU?=
 =?utf-8?B?cERZenVGNlRNKzQyYTA1SGl4WXVhVjZDUlpXWGFPcWxYR1BwSExzV3lGZjJN?=
 =?utf-8?B?T0lOM1BPa2M2NjNuS2hDeTZxek8xSm9DODJ4VXVHVnJyeHp6RkhYQmtIVjg3?=
 =?utf-8?B?eElQcmZtbEZualhxWHBpSzdHSks0WnhGNUxsWkpvbFduck8vd0ZWSFJCaHl1?=
 =?utf-8?B?K0IxVlcxQXBLaktaaUhxSkgrcjc1WXFnbGViQzFvR0I3cURSZzQxcUJFUkE2?=
 =?utf-8?B?c2R2aVhQUTQxQzdHQzBLODcrVDlnUDJSMmc1Y1N1S0kyZGVqR1A1ZHN2Wm1W?=
 =?utf-8?B?b1lVQXk2RmZzaXBHMyswSTFoK3Rab3NjUGllUHkxRUVhYnVURkpMUnRUSzZ5?=
 =?utf-8?B?blhJbnZxZmNJaGl3YnR0RVNZUWoyaHRCUEkvVVJURmtJa3I0Y3J5RiswRDAy?=
 =?utf-8?B?RWdhdk9BaTN2VnhhYmdpSk96REI4YzBGOEJxTUFRSlUwVG04U1ZqOEtsWGJY?=
 =?utf-8?B?QnRlZThiNngraW9DRlpJV0haYzNMaTUyV3ZRYkdTampqYnExSEcyeFlveEpW?=
 =?utf-8?B?cTFmRmpSQzNiaUxwaU0yeW5CdjFzZk9rNjFDekM1bUo4azNFeXBKQUFiQ0po?=
 =?utf-8?B?SUpLb1VHa2haUnVEb1BXSmJUMVl3N1pOS3AzZGFSZzI5UHk2UEUzbTdWZVNS?=
 =?utf-8?B?M3lDVWJJTDY1YmZkNU8vNGsyczN3cmNlMGdTUjNZUldIb1djK2dydmROeXNq?=
 =?utf-8?B?Q0VrMEFMVnlpRmx4SEd1VXZCcDFpM2oxTGtVSmVNeGJRQituNzZISERmcEpE?=
 =?utf-8?B?YzJWQWJwU29qN1VHR0lwR3lCdzhkbzlVWWRoRHBQVGE3QmRKSHNYU0tqSVdk?=
 =?utf-8?B?NXBTQ3ZFVXJBZC9XU2Vwb1FvYTBIYmpQYmxRQUJSdy9TNENvcjRpRHZjVXJH?=
 =?utf-8?B?TnZrUlFBU1NSSXZVbkZtM1AvemJDdm8rWjZvdmc2TVlZWFdsNmhHTFRoR1FZ?=
 =?utf-8?B?eU9zdTJLTWxHQW8vMk4ra1lMK09TZG9HenpiK1FlTkZhS2tFQkpzQ2JlUzFq?=
 =?utf-8?B?TDN3NVlLWllHeVFtYmpjNWM2OVg0Zk9QZFRuL2FDd1lKNXlWZ1NFZW03MjFC?=
 =?utf-8?B?VEIrZUpXRGNDWllyc2xGcVdibzJSdURBTHZYeHFnaFpLdXREajJqTkprcHVG?=
 =?utf-8?B?NWphYVZkQTVxekVEVG5Wc2t2U2JHN05IM3lzeWtrWjcySXZWd0dLcGFrTG0x?=
 =?utf-8?B?cXhKTFhVRjBDMEtvZ01yNnQ1Y2xaRkdITnpYQzZacDVGM24rU1RPR1p1SG8w?=
 =?utf-8?B?Rjh4aWVYMWh1TVE4ZllkNWcvNkRiaHNzNzAyYnliMU9rYm56M0F4Q2o1d0th?=
 =?utf-8?B?YTg0ZjJCcnpSRGJ1aVJtSHNyOXpzWHlmdVVkTXdZRjQxaFFqVHFqd3F0OEtk?=
 =?utf-8?B?V3pKYXZaM2I4cXVGb1FlWlJ2RVVsbWxjRk4xK2VodXg5T1ExMUVrSk54QWpS?=
 =?utf-8?B?TE1tTW8zU2VxMlpSMkNkMlNqSWUvVG8xUDJFM2wwRHpDdFlMUVkvT084WU5r?=
 =?utf-8?Q?QW0Y8PtbG8M4aZ6lqArNP8BtE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f9b6d8-0932-4332-4f57-08dc7346b8af
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 12:17:58.6882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjUEgmHHJTO3wWS8EK1St0Yp2c/fMf3n7xBL29fX6Bv8OoTqmRxZ0wOSDJPZ07165PLcKkxQ//XIp38cZ7kmQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145

Jason,

On 5/1/2024 9:17 PM, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 03:24:30PM +0000, Suravee Suthikulpanit wrote:
>> Since SEV guest depends on the unencrypted swiotlb bounce buffer
>> to support DMA, the guest AMD IOMMU driver must be force to setup to
>> pass-through mode.
> 
> You should block the creation of paging domains as well if the HW
> can't support them.

Sure, I'll add a logic to check and block domain creation.

> But, is there actually a functional problem here? Doesn't swiotlb work
> OK with iommu even with the encrypted memory cases? What is missing if
> not?

Currently, SEV guest is default to use SWIOTLB. This does not have any 
issues.

However, in order to support vcpus w/ x2APIC ID (> 255) in a guest, it 
requires guest interrupt remapping support. This is achieved by adding 
QEMU-emulated AMD or Intel vIOMMU models.

In case of AMD IOMMU, depending on the CONFIG_IOMMU_DEFAULT_PASSTHROUGH 
kernel config, it would default to setup the v1 table for DMA remapping, 
which is not supported in the SEV guest (since it requires to use SWIOTLB).

This patch is needed to avoid the need to have 
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y, or specifying kernel command-line 
option iommu=pt in the guest.

Thanks,
Suravee

> Jason

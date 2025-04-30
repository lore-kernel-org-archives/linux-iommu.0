Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A685F25B1D3
	for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012915; cv=fail; b=hFrN4rO7ePF2R0y+T7vrGwNmup3Bew1+a9xakKAF7T9V/+SsSC1Lrhl1PAncq3JB9APDQglazDnujw8tjrWX3tvYjS10mGKW1ZOGMTN5RMahqRoYlhQ0KTbgW234rl9hd/A4b4UU9Qw0T+Goj6mxlo5xpa0npZTXzDrTL8avRvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012915; c=relaxed/simple;
	bh=AFHk+Vf+F27VAp6vhtMaBFi4l8/DXUamqcQ9/4ovSgY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PXnJZVgB34jNewOD0kEV0oJbqX6cu+CVDhRqCgvBgz7G0smsiQ8pavI2Y6UtslXYN0/FiY9xQvdkHpXzl5AYHU9LfONs96oVW7OTcuC+WZ7dLNwNVGfaxmo81c//7a0wugt7DpX31h6uljvLBs+iA1A6CiZ6SbcQqVb1lwa4IHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HKbegwM1; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HKbegwM1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCT85jSpjHOG6Bb7lsx9AoIaIRTzrYfYibQ1hhkiUI4K7lh59olwXRIQHlfj9rqpn7zHuk3EZx6vioycjiqlrcwmbYTUjXYhryHIioczHWuAhBOc8h9Y9ufzhWTfYLlAapgbMuJfC7qaiAzCw102M3nw8fw0c6tMSOTkvl3pv0eakeW9IitYGlQhKN3BmuY8zDGqSOcWq21+Ej1FxAVhfebh7hsfWahSHkRcWvZWr1DsOYFKDa0N9lklmOirl7qCk0aYGlEHWAsfiFtSs0hPKRAzvX8ZxDKMk/hHeoSQESVdEfTtdKbphJZrREF3DoURRiBQEm5RvYYJY2UvxtwWWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6BK/rP3dCpE1vBK6U5Eu5NM3lsolcVzkoei2R7Xnjk=;
 b=u1IKtZfB9ugBdLCdRirfZyujt2+FGKpk93+ym3ZOPQMPShP24Ip2qinM1ccp2yH2lJTBelkTa4j6Varka7X/5kijbIQ401QjQ4BDAg6tND0o9lGnN4SA7JR9lkQUkSc3rZEt84Ph6Yv/cxNTk/OYsYyhemhdTW8bYDcjTTq2NI1nMKkTII+XatLR8LbCIPi2vZVw7Z8wMjIPJLPD0EfMcgGDSOox3mTJaZa5ApyQ5zNAYmQLeHSE9+w7SJWlBVQprjQC9MYP2ZFml2l0a/dlqmY8YxW3VoP2AUPDsj5fSmGIv7TlIjv38eGj/+gyC2En3xIDfVcCaZIKoT4TojBHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6BK/rP3dCpE1vBK6U5Eu5NM3lsolcVzkoei2R7Xnjk=;
 b=HKbegwM19bgomzvwyme5IvGpvoGOI6vuO8roKl7RwtQyPa9wZDfDwibjXzikjD6dt4Wvr54fhID0880MFsh+XOrhd7reHql8yE0shJhyX/pHZkBCN/eOAmF9XLBwv53vyera0hwBmIyhiSZULcrBkqW2gmT4n14Vj98i5GvQZP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Wed, 30 Apr 2025 11:35:09 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 11:35:09 +0000
Message-ID: <193f5eee-18a9-4b13-a433-ed05f86f8e46@amd.com>
Date: Wed, 30 Apr 2025 17:05:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/amd: Add HATDis feature support
To: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev
Cc: suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org
References: <cover.1745389415.git.Ankit.Soni@amd.com>
 <6282a5c349812a311a67a8522dc5e4aabfe3ec3a.1745389415.git.Ankit.Soni@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <6282a5c349812a311a67a8522dc5e4aabfe3ec3a.1745389415.git.Ankit.Soni@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: d34da8a3-5b82-47a8-3b8d-08dd87db0fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1BDajdVNjFsWGZJcnoyMVRydmE1U0lpcGxYcjlkUkNMd054bUtlZmdYZFV0?=
 =?utf-8?B?cUl2SzJXazF0UVdtWHJzSWc1ZG81aENweEc3RGpaK04vNTh4Vzh5aGZjYVIw?=
 =?utf-8?B?VGdwekg4Y3M4VVh1ajBMOXBZRTA0TWVuMFVzNE1XR3AwMVE1VktLUHdCTStY?=
 =?utf-8?B?dlEyK3VTaWFvVi9iVXM3bGNkcU9udy9FZWlManZId0JvYzZncWQzL0RxbUN1?=
 =?utf-8?B?ZEQ3UG53S2JKODFzT2ZibThZeVcrSURCclhuY25PL0pYS2Zhd0ZXaURxN1lw?=
 =?utf-8?B?SnFJdlR1eXc0RUlyZWhwN2M5c1BzeXd4SVJLN0djRjNHWStmYUxIV0lSWXRN?=
 =?utf-8?B?d0xSMzQ1SkVrdGVoR1NsZzhoQk9pdWgvcHNSbDltdXpYUGpLTUdhdmNMVDA4?=
 =?utf-8?B?MXhUZVkwY2s3OGFKVGpFVHlnVXhVK0M4bEpySlpidklyL0ZFK21VeEs0RjNi?=
 =?utf-8?B?WHI4cklmRlJ3M2JxTmx0RHZiMjkzejFqOUUrQWpLM3A4Ni9CZ2wrZnl2TW9U?=
 =?utf-8?B?Rit2Z1pTTW1QQy9uaHQ3dWdyc1Z4aDR0Wmxjc0RMU3h5WlUyUHZPMnpGZmJP?=
 =?utf-8?B?V0QrbXdGQk1lRkZpM252cnZ2TU95U2FrcnRlZ3llRkcvNUhNaThIOVk0Wng4?=
 =?utf-8?B?ZjJPNmtVY2xnRy9lR3pEbEVpcTM3N3JKS2gwVVp2ZmhmRndyWHIzbWowNUFG?=
 =?utf-8?B?QW1Lbk5WRm5wNmVYbjJMV2lseThJbmVyQzdNSU13cUpqRllIYklYaHU1aUFE?=
 =?utf-8?B?cGdjdUJpUXNWK1V4Q1VkaGRYN3E2NEEraHREaG1iTkxpYkpPWjBuMkhKZkNC?=
 =?utf-8?B?ejRRenpJZGlEbTNxVHZmenZoNVNYNzQvMXRacWtOaWVxalhTMDdIQkJ1QTl4?=
 =?utf-8?B?bTE2UEFIazBoaWxZbGVLbTZrcnU4TzR4bjRyU1d2c2R1d0QyMEs2Y3ozNVRw?=
 =?utf-8?B?YUJqMHcxR2dhREtoV0Z3MnRDbi82bUVCM2IxeUlvNEhtWnhQbFU0ZUlBcWpY?=
 =?utf-8?B?M2VvK1E4YTFtajJTdFNMS0x6YVoraEVRVUhrQmVMcGMyTkJxY2VSbGk1SWcv?=
 =?utf-8?B?d1FTWkRXRjRkSjNqMytpWjl6Tm9xRVM5RCtNNDZKN2dVeDNzVEpFZlJvT21x?=
 =?utf-8?B?NFVYeUdwY3RQTzVSaFNHZm01cHQ5cFdwOWpybWZreDZZMFlkN3ppaCtLcU9F?=
 =?utf-8?B?OWhXdzFOWlJxN1M3K0lSdUlsaUJyUHpiN2t0SE5RNVEwQ083akZwNzdmaWxM?=
 =?utf-8?B?MTJqb25uZ0krdElWTlpzWWdnOGpnbXFGcFp4REd4bUpFYk9WUzgwd2txaU05?=
 =?utf-8?B?Q2grNjJXa0g5VTFGaFVEMWhYNWVHOGpIeEJKa09TZXlmTGFkeFNrZi84eXNI?=
 =?utf-8?B?RG1KVUJzV2RyNDB1dnFWUGI5cVhadWI3MUExWGRVclhSN0MyaEljcW9MV003?=
 =?utf-8?B?bGlBMFBxNGsrREtUSHdNMCtCWnpEaVpWMU5XTjVEbG16cDV4MEpWR0JhWjlX?=
 =?utf-8?B?cStWZ3N6eFQ3TERqTXJHQjcxUm43cDZPNXNsMXRQSVRzbTFRdjV4U20vZWpw?=
 =?utf-8?B?Z3FrdjZUcFM5aEFiQ3RMR3JsTFZKU2pzZFpJc0FaOThwUzFNRmJEZ2kvdFRz?=
 =?utf-8?B?T2pZNjNaTWlxRTVxU1VUSGI3aGlWQStPN0dhcWFSd1BxVDdsWWlGYXBqZldr?=
 =?utf-8?B?UzE5b0VVZjUvSTNTTzd3SzVOUVdOSkF4WTJ2UGtZUGJGYkxRcXJYb254ejFj?=
 =?utf-8?B?M3RvblpKVkR2cEVLbXR4Y3BEUG9NZmllRWxXcUQ3YW92ZmZzUzQ2eVJPQ1RP?=
 =?utf-8?B?bTc5K0NIMTl2N3ZKWnNIc0xhQmRuekZTS2RHOXNVNzRhM1RTZXQvOHdOMGFK?=
 =?utf-8?B?VW5STngvTGI4WitnWU5QbW5GcnNaOEp6RitUK3dDOWN3dWJ6RG9qeWJLOVpN?=
 =?utf-8?Q?NfLZ+XL7B6k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUp6K3N2WXBhVG44UUl2V1cwT3p2VlErbXl0aDUrbVJNNTFFMjZENHpwVnFX?=
 =?utf-8?B?WmNaZW5HSEtYVHZ6bG9GcnI1WjZ4clhJeEFqajJEU2NiWFJpaVVzQ3JNdmhm?=
 =?utf-8?B?UUczNmRRY3FYdWJYcGRhbWNFdVVNbWgwcUh6Uk1zbFZvdWtMd1BjZDA4T0hp?=
 =?utf-8?B?dG9GL0QwVFphaEl0Zlc5bEhGeTNLTjg4YWx6UThya2g0RGVmajdQMlh5dzRh?=
 =?utf-8?B?NXVKanEwdVlUeE9wa0hzdzdFdEc5YnYzTjJ1cVpISG1DMENWY2N6SGF0b0xV?=
 =?utf-8?B?aUM4dkc3alkxUHZvN0F1cTl6WjJpYnJJOHNJQ2RGdWphWkRIQ3ZKQllncy9G?=
 =?utf-8?B?cGhHT3IvbHVRYTNYMWZXcDRESDBqKzlGQjJoWkVnbGRlVlhRdVdNNFdnMVBX?=
 =?utf-8?B?Z1Jvc21mSG1tbmlTRzF3YlluM3EvNzhMc2pncDk0VnBBcWpPZ0pZbkJ3cHEy?=
 =?utf-8?B?czk0N3NhS003RlcwNUxFZE5BZnYxREYvT3pZby8zN0hGMkNBYlVrM2Rpdllo?=
 =?utf-8?B?YVdsL3JQYitZWjhhQ3FqVWJlOW9WL1BoUUNpWVFuZHR1NWo1NXJVbVhVcDhY?=
 =?utf-8?B?S0U5eXFIQmFGU0dTVjVPVnQ3SFZJL1kxQy83M3lTYTZiczllNlhBNjRDZ1Ns?=
 =?utf-8?B?WEc4TkdXRFNkTUZ0aWIraXhlVjRnR2E1R090cmVhV2tPTTRxZStidGlBMFFR?=
 =?utf-8?B?SHRiTkFvSTFNNG9UZUNUVzF1SldHc1djeGI5VjE1MGVIMDBxZ0VVb3BMcm5U?=
 =?utf-8?B?Y2pWZUFLNER4TDAyczQzdGZkNHZ5YitPZzVGcEplWUtDc2JFdGRFYzljWHFV?=
 =?utf-8?B?ZkZhNzJyZ0pvckNFbDFVTHE2V3JlOGVGbG1XdVJyakJvVVZXaUhGNmtFQllV?=
 =?utf-8?B?c21UL3RuQTdVNllJSE5xeVdPNGg5L29Vc2p0VEY5eHREa0ovcDhJOStXT0hw?=
 =?utf-8?B?MnUvdGpTNFdsVnB0d3RFT0tBUzcwa3ozVzBOMjBYVVZYS1I1dWZKTzU1ZGhl?=
 =?utf-8?B?aCtBMG1KYUNudnBoczFBWG1uYmdNMlQxamlXOC95ZWM0QXRGTXo4RnlTcUgx?=
 =?utf-8?B?aTg3NFpWN3VPdmpBOVBqZWlzL3BsRFRsNy90QWdtSHUyV2hXbFBkZ3NSY3J2?=
 =?utf-8?B?M25YQmtXQUJSTElBMzY3b2lRQ2tId1FWdHpzdVBUemllZWNEMVdrK0JCSFgz?=
 =?utf-8?B?NUhoMmRTRldyQklVWFF6TGlWcytadENJNWt6Z24zRExPMGtwWFZpeGxTaEZC?=
 =?utf-8?B?Vlo0WkR3Y3BhTXVrcVY1UnRyR1RCUUdlYnM0T2p6QytXNGdGenorUlVkYndw?=
 =?utf-8?B?M0dmUDlEZHFsU1VxQ0ZPOGZsOTR6MHhPSU1hZGV6dGJjcCthdWdkeEp5VDkz?=
 =?utf-8?B?b3JQOEhCWi83ZzN5RzZ0QlpoOTlaeU9XMVFEekJlL1dQbUJJMGZhQmVKYXhN?=
 =?utf-8?B?Sm1NdFJCaHNkb3NOZkhkSEwrVkJsT0JGWGpad2V3c1FIT3lZZ1Q2S2JPTGhL?=
 =?utf-8?B?TzRNd2lxN2QzRHh5L09VVzEwenl4NHRUa1FVUzNWdTdXRzNPZ2hGVFJPVzky?=
 =?utf-8?B?ODFsU09HOWNJN0E0bFlpdUlPRi90YUx3N0NiNHdGRDVZcVM2eDRBeFBKdnpn?=
 =?utf-8?B?Unp0MGJQQWxQWi9FazlWRFpzaTQyUTI4UmlRQVlQRE9uRXVnYVpDRGFVZFlQ?=
 =?utf-8?B?bzNtd1N3VXg5YWR3NnVVS0RRWTdGYnBvZ3dvTkN2SmJnaGdOU0o5dUZkSFh6?=
 =?utf-8?B?Yk1WV21IZEZ3eUN5MFNFSllyOEZZZGp0dmJkbHFGdnorL242TVZjRVA2dWJn?=
 =?utf-8?B?N1BvN05WZ25CaHczVmNpZ3hkYlBqSzdEU2wwdXZTTXBleVcxRjY2NHU1cFMy?=
 =?utf-8?B?WUdXYzhxK3JzN2x5bVlsMEZqV0RVUm1XK3NpV1B3NU9Vc1BrRmVlT1c0S2xp?=
 =?utf-8?B?MkJJOWNaUVgzZEF2Vlk4NUlidWo1MEYzUUlDZlQvckYzeGpZbVh3K1diR2NH?=
 =?utf-8?B?bFVFTXIzR2lncU9oUjJMZ20vSFJJZTc2d0FsTWhnTEQxN3BlSFR5VjM5M05L?=
 =?utf-8?B?ZElhNE1acGo3VmY4OUlIZ2VETU9ERHJvck5JRGNHTHZuc3RKM2wwSlVCZEY1?=
 =?utf-8?Q?kH+O7Ypfhi9/IOeLs0ZOhPbfd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34da8a3-5b82-47a8-3b8d-08dd87db0fa9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 11:35:09.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fL5XjbDxQVu2gPLBYZ3z4btQ7j2vS5EQK0WxY3EveRBDj216yUupHvOD1h1AR4WrX/O5pHA1lVDxEk6EWduo4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270

Hi,

On 4/23/2025 12:20 PM, Ankit Soni wrote:
> Current AMD IOMMU assumes Host Address Translation (HAT) is always
> supported, and Linux kernel enables this capability by default. However,
> in case of emulated and virtualized IOMMU, this might not be the case.
> For example,current QEMU-emulated AMD vIOMMU does not support host
> translation for VFIO pass-through device, but the interrupt remapping
> support is required for x2APIC (i.e. kvm-msi-ext-dest-id is also not
> supported by the guest OS). This would require the guest kernel to boot
> with guest kernel option iommu=pt to by-pass the initialization of> host (v1)
table.
> 
> The AMD I/O Virtualization Technology (IOMMU) Specification Rev 3.10 [1]
> introduces a new flag 'HATDis' in the IVHD 11h IOMMU attributes to indicate
> that HAT is not supported on a particular IOMMU instance.
> 
> Therefore, modifies the AMD IOMMU driver to detect the new HATDis
> attributes, and disable host translation and switch to use guest
> translation if it is available. Otherwise, the driver will disable DMA
> translation.
> 
> [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf
> 
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  1 +
>  drivers/iommu/amd/amd_iommu_types.h |  6 +++++-
>  drivers/iommu/amd/init.c            | 23 +++++++++++++++++++++--
>  drivers/iommu/amd/iommu.c           | 13 +++++++++++++
>  4 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 220c598b7e14..bb14c4800dd0 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -43,6 +43,7 @@ extern int amd_iommu_guest_ir;
>  extern enum protection_domain_mode amd_iommu_pgtable;
>  extern int amd_iommu_gpt_level;
>  extern unsigned long amd_iommu_pgsize_bitmap;
> +extern bool amd_iommu_hatdis;
>  
>  /* Protection domain ops */
>  void amd_iommu_init_identity_domain(void);
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 5089b58e528a..284ff4309660 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -460,6 +460,9 @@
>  /* IOMMU Feature Reporting Field (for IVHD type 10h */
>  #define IOMMU_FEAT_GASUP_SHIFT	6
>  
> +/* IOMMU HATDIS for IVHD type 11h and 40h */
> +#define IOMMU_IVHD_ATTR_HATDIS_SHIFT	0
> +
>  /* IOMMU Extended Feature Register (EFR) */
>  #define IOMMU_EFR_XTSUP_SHIFT	2
>  #define IOMMU_EFR_GASUP_SHIFT	7
> @@ -558,7 +561,8 @@ struct amd_io_pgtable {
>  };
>  
>  enum protection_domain_mode {
> -	PD_MODE_V1 = 1,
> +	PD_MODE_NONE,
> +	PD_MODE_V1,
>  	PD_MODE_V2,
>  };
>  
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index dd9e26b7b718..f71b236c2af2 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -151,7 +151,7 @@ struct ivmd_header {
>  bool amd_iommu_dump;
>  bool amd_iommu_irq_remap __read_mostly;
>  
> -enum protection_domain_mode amd_iommu_pgtable = PD_MODE_V1;
> +enum protection_domain_mode amd_iommu_pgtable = PD_MODE_NONE;


Why not keep it as `PD_MODE_V1` (as its our default page table) so that we can
remove explict `PD_MODE_V1` assignment in below hunk?

>  /* Guest page table level */
>  int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
>  
> @@ -168,6 +168,9 @@ static int amd_iommu_target_ivhd_type;
>  u64 amd_iommu_efr;
>  u64 amd_iommu_efr2;
>  
> +/* dma translation not supported*/

Host (v2) page table is not supported.

> +bool amd_iommu_hatdis;
> +
>  /* SNP is enabled on the system? */
>  bool amd_iommu_snp_en;
>  EXPORT_SYMBOL(amd_iommu_snp_en);
> @@ -1798,6 +1801,11 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
>  		if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
>  			amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
>  
> +		if (h->efr_attr & BIT(IOMMU_IVHD_ATTR_HATDIS_SHIFT)) {
> +			pr_warn_once("Host Address Translation is not supported.\n");
> +			amd_iommu_hatdis = true;
> +		}
> +
>  		early_iommu_features_init(iommu, h);
>  
>  		break;
> @@ -2582,7 +2590,7 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
>  	u32 devid;
>  	struct dev_table_entry *dev_table = pci_seg->dev_table;
>  
> -	if (dev_table == NULL)
> +	if (!dev_table || amd_iommu_pgtable == PD_MODE_NONE)
>  		return;
>  
>  	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
> @@ -3095,6 +3103,17 @@ static int __init early_amd_iommu_init(void)
>  		}
>  	}
>  
> +	if (amd_iommu_hatdis) {

I missed it in the internal review. This introduces ordering dependency (v2 page
table check should be done before this). IMO its worth to add an explicit
comment so that its clear.

-Vasant


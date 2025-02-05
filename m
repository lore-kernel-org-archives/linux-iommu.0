Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C34822ACD7
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749204; cv=fail; b=TnN8ry9VGKyUgEeVA1i5Kn0nOb/Vhkf1RXdUpHwlgG0uOILolDcp3YgQS073rNaQSbTZSDy3oLEeETFldgvk43n2pnkbqtRZMtPl9PSIgatgkOHepo7trjC3GijiieASKchNZJk/jexFFXAn+RL8Nr1T235GRH1jKigzeLgZ9fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749204; c=relaxed/simple;
	bh=pekfwVPEfer8UUHn45nMj0k0TjNeb68wcZKLNjQ2+8M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fa1TcoJxwFqJsiCVOcDo2tvxQiCszMargXMeOE1LtzA7PJIXZrXMZrCeJZ+losu9m6rQwAHVDDDpORWOrGceOyo/nYXEQxdenoL+DiwMvGRN2iAHd0ghkxkePZT8DN6NEiY6b+goei+N4N+/y/FMWwxNTTV5BU5beUSb9cUPzjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TqUlr3pL; arc=fail smtp.client-ip=40.107.212.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TqUlr3pL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpyPLFXOaz44gD0x13cgmwlH08197lFtxA+YERrkqYeGSw6jtR4grSFgN/h9OSLyDQH6ZSrJic6w5bJ2tGRRnyGN+c4gkzKLY/dn4YGp6TNms4dHPERzmNlYfD07Vf+0U4Fc8JN56c3cIMX+r6PezOHDl1MKWKoABBHaH66x6D19dKmx4tBo2ZTWAd+MmFMdHbv+VGHFqMK7oO0k8ao3VhbrZNPhMSktis5wpJ3qqP+PFeBPQ5brNeP3Z+s8z58wXtmX7zXzSyDCydaGGqmob6QjwRprLO0ClHFM4gWDhad98W00HxJSqOZalYKcvnP7afZ2PFmvcIImx54GPSbCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdHGcEIy0hXHocFq9hGqpL/kMfYD1rWgJIPf8abV7/w=;
 b=rDTHuI8TkHR/eQVBxYVYD+QzjhIwb4c1/JepmL7eYVlhfuMNSibZIFYBgdOON8j0mMp5YLEYeaWOJXAVe/k5TnRrH+/nQfLAXBKN37oCpf8yBkeC63ba3ZduUbhEbHu8hT5k3JMaGhnZmd+U+5QnyKPcpu2xCjnogWneNQkEedD2LVB51p5Tmm1kqzqeOHGCRg+uPX3DmfreKerzzB7KWbo8NYvXNz8riaBDgajHr/QhS/LckEYqK1sA+nKiZ/dwknKlkpxrh+Fq2lJfiTdsF6hg1NRGaTo+LzoIfOhb94HV0duv4RrjgCurohVsu7NzmioJ9MW6XryAC/MvBs6LGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdHGcEIy0hXHocFq9hGqpL/kMfYD1rWgJIPf8abV7/w=;
 b=TqUlr3pLiw4tDf5/KBxsBgiGhNQ5C35wdxvGWdnD4wm2ERahH2fLLNtmvLj3cGNllQp6V+yJH2neXKLXMTY5P3ZKinyTeeJ4HPhX75nWm3sOoaOATnCaQwQHXxmjLYF34IWg6mmNZFazJuCGQ/FancrcrBwB6o6giUwh/6Iq3J4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 09:53:19 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 09:53:19 +0000
Message-ID: <5656bceb-645f-4063-a11e-89a0d1a634b4@amd.com>
Date: Wed, 5 Feb 2025 15:23:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Expicitly enable CNTRL.EPHEn bit in resume
 path
To: iommu@lists.linux.dev, joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com,
 Hamish McIntyre-Bhatty <kernel-bugzilla@regd.hamishmb.com>
References: <20250127094411.5931-1-vasant.hegde@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250127094411.5931-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: b053ba2b-e95c-47b0-a146-08dd45caeb60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NC93WEdmRVo4cklwZ1ovT1ZWT281VWMwU0h3T2RIUkQrVU1YTWVxbDRxbzkz?=
 =?utf-8?B?TVhXb3I2eERoVGtLeUpYVzlIcmdjQWpVS1ZXeDM4RkJQU2hLbU1zMzQyVmVV?=
 =?utf-8?B?SHJkYTdEb1JzTldWVUVzTURib2VjM0lSUFUzUThIWk9wU1dveDd6OG9KZFJL?=
 =?utf-8?B?aU5zdHhlWVkrOFhKZDZEM0lSZjRNcXRZdlJZYURjakprRjVpOVJVaW8vUnhQ?=
 =?utf-8?B?RS9xb3g3TWgvODVHYWJBQnF0MHcvNTJaOFV6TmRCcENiV09OeXhiRU1CcDlz?=
 =?utf-8?B?Q3A4TlBhMEZreTFQSkJRQ25CYVJHbC9aZE9jQ1FoN0Y3b0d2ZEtUYUE2WFkr?=
 =?utf-8?B?MkQwY3NuMGpGbVpTb1A2SGhjTEZ1YlNYTHJWSkMwRFRweGxVVkZEOE04Y29D?=
 =?utf-8?B?UlB3c0o1YTB6RjhzUUFmUm1LVVJNN21FMEF6d28rb3UreGZrZTEvbTYzaGpk?=
 =?utf-8?B?cTZuRWpXVmtab3dOVHlmVnV5YWpsOWJaVlMyY3Uya0FyNW1MeCtpMTQreDky?=
 =?utf-8?B?cm5MUUlQWnpCV2V6Ty9RcFQyMVJUSWphVUh3QVdTSzVhemVsVU1KSmNpUmxN?=
 =?utf-8?B?d25nQ2JTZTA5OUtKZmw0dEFMYW1XM3dSRzhHc3hvWVNVVWtXWGgyL3I4R0hF?=
 =?utf-8?B?dlgwSXM3QnN3ZmxFNXZxblBHVldTMG4vRU9PQko0aUxKNlhvc3VsQUU0SmU4?=
 =?utf-8?B?VlJHNE1QUERUcllDVUwwTFk2UVQxY1F4dkk4S2xTNUtrWUZ0NzdCSFo4Y2RN?=
 =?utf-8?B?OW85bDNtWGdObWttV0tFMmkveStpUWhIbzAwM25xT0s5VG5hN2psRk1XeUx2?=
 =?utf-8?B?dmdTVmc5NVhxTzIwbFlFWG1BTlJCSVJGYjM3V0tVLzFEZFZDOWpPMGdjdUxL?=
 =?utf-8?B?TWY3ZGdHODNpRDRYM1hQQU5wNkZOalpFZnVmWElPNGI5OHNHRE9KUEdEeGtY?=
 =?utf-8?B?N0oyU1l6K3Y5UGl1REtpamNTUXRCZ0RKd05WMnI1K2tRUDV1QmRzQ01BNVhH?=
 =?utf-8?B?d21EVlk5NUJBYWdZWDcxSHBpVE5XRUZVL1BWK21DOUd2b1lCMHV6NzVtelhM?=
 =?utf-8?B?Q2JoV0orMkF2cUttMzVXMndvZmM5Ym9oRmhrK21BZlJpU25zblNkc0dXWGdM?=
 =?utf-8?B?M2lTZlQxUkgrTjI1NDNtazFZSnpjL29RNzFQWFUrZFhDeERvZkYzS3JTQVM4?=
 =?utf-8?B?TEM5blA2ZEYzQzFwMHlHV1JOYWVQQUIyQzB2b25tTUJWbW5MYWhFQkFtM21X?=
 =?utf-8?B?TlY4OVJIOVgwS1gxMWxtcHJQSS8xSTZma2NwQWVXK1dyYThJRHZwaUIvV1hi?=
 =?utf-8?B?MEUrVVZSbXBhdVdrVG1WZVdkRGpBSDl5bmhhSVJEM2V4ZEdlVnhONlp1eWl1?=
 =?utf-8?B?Wm9DeUw5ODVoMmJEZDc4V3ppNXRyWlFPSFZwSzJVRWFrdmJUd1MwNmUydXNN?=
 =?utf-8?B?c1FWcE9KREtCMkE0R2xxUkRqVTN3MVFMeEFyejBkeHlYc1R0UytHS2p3dE93?=
 =?utf-8?B?R2wzU1ZQVWNZallOUFMyS2dsS05MYWdTZVRlN25BdGxQeGNuaERkaXcyY0I4?=
 =?utf-8?B?eVBOd1RzUWtUVGtMbmRUWmFZeW53YzZTdVN4Vnc4QVV2S2lKY2Y2eVRxRkV5?=
 =?utf-8?B?U2VoRUNIQjlsT0c0YnVQbDdpU09kT29meXBKZndlQVNiR1FyeW56ak5UdHVF?=
 =?utf-8?B?dVdNV1NaWHFBZnBQaC9uSVNLcFVjV0lSdkhHbWdvSm1SenNjMVRYMHk2R3Vz?=
 =?utf-8?B?SlJXc3VUeVNGVDloVmUxbThqSW5YTmQxNDUvdXdWd3lWSDlEK2U0eURMWXFE?=
 =?utf-8?B?TWhUc0RZa3F6cW9kdytJUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVlQNExaN2U0R1c5RGlIUVFUVlFLeDNCdTdXK2FOeCt0QjVXU0F5RW9HMitU?=
 =?utf-8?B?TkNSNGgwN0xFUVVJa21BMGhUZ1F0MkhBT2JnVjNqbFBWZlF6UWVMVzU0VjdB?=
 =?utf-8?B?d2NKdjVwSlV1UDhPdFFjYnU4eWJmT3pWb1F4T2dwWWxEbUgvcFJmdWt3RXQ2?=
 =?utf-8?B?czFNTjZXRWpmR1UybnJMY05pQVZRTzdvTVdVMjZIYitrc0NSMWIzY2QyeHRP?=
 =?utf-8?B?S3dwc3VQckdlRWdjdk1nTHdwVWU1WWhQSTR3UmJlRmQrTFpJRlNBRHg4U2Nz?=
 =?utf-8?B?eXRYRnBSRDhKZS9SL2FCR1JjNFpqb2Jma1B1emNIVG5PamtwdnZJRDhrdVBk?=
 =?utf-8?B?VnYvQ05kTkpXYXdoU0pDakNCUUs5dWRWZ3o0UjhkQUpvNjJmb2kxMTFEWHQ1?=
 =?utf-8?B?SGpUL29KUXFneXVEK2tZMzlOYXhHV2VnNm5WcFRZYXVEZU45UTdYczB5akVp?=
 =?utf-8?B?akVzN3RUdFlLSHE1dnVFY2x6dUgwazhTYnJuN0puR2s0ZlVVWGdQVFc3dVZ4?=
 =?utf-8?B?ZXBmSnAzOElUaGVUM1d5SHpXRVliVHREOTdNejBlZjlPOWFmLzF2RlZsVUhv?=
 =?utf-8?B?cnNmek5jMVBqOXNDQks1TWM4cGl2Zit1N1dsL3o5L3p0VjdFd0VVZDBDb2dz?=
 =?utf-8?B?T3E2ZjNqU3poS0RUZkFLS3NVYTZKL0pUdnFxMGk5RXRMTWhHZWFiU1lXNVYx?=
 =?utf-8?B?R1R4eE54bGNQRFJWbHhvY1RPNTVFT2R2akJUOTJYa2tMVVdaaWdYWnRQQWMv?=
 =?utf-8?B?U1JkTkhWMFRIeS9LcjZKY1Bib1Jxb1g3WjhSdnJIVTN0Rnh3cjl0VFdCSDJO?=
 =?utf-8?B?azZPTU5MbTVFWUpSVFMzdzBUYW5NWTQwMG5nTDNwQWNmVGYrT0NYdGJSUVcv?=
 =?utf-8?B?Wm4rOFVMZUpYMG53d21aSFY1YVY4bWJsZFlxVklmRjhzbWRneitUR0xMbTF2?=
 =?utf-8?B?eVpVak1iUTIwc2YvWG5YWnNUUDNiOW5ac0dqemExUjhscDM1cnY1OGNrYmF3?=
 =?utf-8?B?ZDlOZ0xPck1OejMxbnBUbTNvQS9OcjBSdXFjUXZjT1c5Z1cvanFmSm96bWM3?=
 =?utf-8?B?OU5kVHdaWkdnclFRYlZndUMyL1NGbHdCbVlNQkp4YnVEZ0g1MVFCaDliSVls?=
 =?utf-8?B?SmhNM2dEb0xqL0VQbnRNS1RZV1NYOVErOGc3SFNuQk5jNTBLcVdIY1ZGMGo5?=
 =?utf-8?B?Rm5qZ1RIVDlCbjBhU0FlVSszREJSVUs2TUdRYmRZWHVGOWV4UUdPOWswVmVP?=
 =?utf-8?B?U0dGb01vVkN1R052L1g2RTJQTllLNHJ0bFNXZnp4RTFKaWY4NFllSVorMGk4?=
 =?utf-8?B?aFhjTVFWbkluWFBMS3pYdUo0UWgwWGFHKzZYbkNqUU5TV2F1ckJIbS9jR0w2?=
 =?utf-8?B?NkxyQ1FpdEZJb1VRc1A2UGVlZ29VWk9MTERIRjFTQlhwRnczdW5nS3Q2Y004?=
 =?utf-8?B?MTRjNm9ydFhKVW03V2tmL1BNWWZwamZvcjFQMmRCbmtUODRBdjhWL1djdU9D?=
 =?utf-8?B?WFN1SFVEUURwcmFOM0dSdXhjWWxKc0wxaFhSRlB6VlJmcVZJLzU3NmVMb1dM?=
 =?utf-8?B?dTVsK2wvelpSR1Ayai9oS1VTUEpObi9Bcis4Y1lrT2pWRzRmZXpRbjFBU1F3?=
 =?utf-8?B?djZHbENFRTFud0FITEV3TjNkQlU0YUxZVDhSVXhnNGI5TTJ5eVl4ZzNLUGh5?=
 =?utf-8?B?RzNrYjdkbVFmR0p3encwNUI5RHdyWUJYSHRnOXFyVmM0VE9DMnJHZzNFbVVF?=
 =?utf-8?B?VEFjdWtReTVVWW54SnZBemYxMmx5S20vRUQ4M3B1WXpDRUJidS9rNTc4T1FR?=
 =?utf-8?B?Q0d4TFpsRGp2RHp1RThOaFVEZmFSRmxZaE5nQ09DelhaSERpQ0FnY2R3eDFL?=
 =?utf-8?B?WnBYaW11YldqVllQK1diVEdCUkZCQm9kS0laaU1lQXJkSnNOUy9GYXI1Qmdw?=
 =?utf-8?B?VzFRQXo0dVNvMlV0NTNxbjFJM3kvblRjQWphaEdhVkpDb3RDcDJGRGlFRWg1?=
 =?utf-8?B?MHhXOFlZSkx3ZWVnNWhCYXNWUFNIMDNJRGI4SnQ3T1FqWUF1TGVEdDNmZ2Vl?=
 =?utf-8?B?c0sxNDZRSHB2ZVpyT3JvbEQrNE9pRGM4OUZMMytMRnBHNzMzZllSZlBFdUJP?=
 =?utf-8?Q?m54PPzw2PXO4uJk1U+VmB7eUU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b053ba2b-e95c-47b0-a146-08dd45caeb60
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 09:53:19.4346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tn/TSxPIMAWVUW28iaWshAEc9j0m/kCMKE65x8BTTKAjrqmqul0/R2Z/KPG+1pEJst5eKU+3HdDt+f5Wi7T0Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727

Hi Joerg,

Ping. Since this is the Fix, can you please pick this for -rc ?

-Vasant

On 1/27/2025 3:14 PM, Vasant Hegde wrote:
> With recent kernel, AMDGPU failed to resume after suspend on certain laptop.
> 
> Sample log:
> -----------
> Nov 14 11:52:19 Thinkbook kernel: iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:06:00.0 pasid=0x00000 address=0x135300000 flags=0x0080]
> Nov 14 11:52:19 Thinkbook kernel: AMD-Vi: DTE[0]: 7d90000000000003
> Nov 14 11:52:19 Thinkbook kernel: AMD-Vi: DTE[1]: 0000100103fc0009
> Nov 14 11:52:19 Thinkbook kernel: AMD-Vi: DTE[2]: 2000000117840013
> Nov 14 11:52:19 Thinkbook kernel: AMD-Vi: DTE[3]: 0000000000000000
> 
> This is because in resume path, CNTRL[EPHEn] is not set. Fix this by
> setting CNTRL[EPHEn] to 1 in resume path if EFR[EPHSUP] is set.
> 
> Note
>   May be better approach is to save the control register in suspend path
>   and restore it in resume path instead of trying to set indivisual
>   bits. We will have separate patch for that.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219499
> Fixes: c4cb2311110 ("iommu/amd: Add support for enable/disable IOPF")
> Tested-by: Hamish McIntyre-Bhatty <kernel-bugzilla@regd.hamishmb.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 1 +
>  drivers/iommu/amd/init.c            | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 0bbda60d3cdc..23caea22f8dc 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -175,6 +175,7 @@
>  #define CONTROL_GAM_EN		25
>  #define CONTROL_GALOG_EN	28
>  #define CONTROL_GAINT_EN	29
> +#define CONTROL_EPH_EN		45
>  #define CONTROL_XT_EN		50
>  #define CONTROL_INTCAPXT_EN	51
>  #define CONTROL_IRTCACHEDIS	59
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index c5cd92edada0..438848b0682f 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2653,6 +2653,10 @@ static void iommu_init_flags(struct amd_iommu *iommu)
>  
>  	/* Set IOTLB invalidation timeout to 1s */
>  	iommu_set_inv_tlb_timeout(iommu, CTRL_INV_TO_1S);
> +
> +	/* Enable Enhanced Peripheral Page Request Handling */
> +	if (check_feature(FEATURE_EPHSUP))
> +		iommu_feature_enable(iommu, CONTROL_EPH_EN);
>  }
>  
>  static void iommu_apply_resume_quirks(struct amd_iommu *iommu)


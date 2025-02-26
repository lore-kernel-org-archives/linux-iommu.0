Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6F4139B
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 04:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740544430; cv=fail; b=M4jHAzeaOtA+rxwHexSiYLoxxp3Bit/uiUl0wL4Hdcf3k+xw72GN5rZRoQjq7pRlbWK0U27h3uomwHzicTPTD4kSJ4wjwJ9+nyU3/W73D74JkOpXNfR52eQVkBw18o8edF3cX0rBiMzTa0Dh6zESkwrjjasdJEZABUxI5lHji7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740544430; c=relaxed/simple;
	bh=YaOiRtKeKhGy7W2gG1eyZtaQakqoG73MsQmdTiR9+5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pmy4x8fRV1PXzyNXS+hMohCaDT1+5RRheaeAFenk+kg+6bSSnINkL5IWDriusq2fv7bM6IFLLS7DTMuk6nujoXsclJwPZWN9dUZ/Lrwd079i9dFrWYH2WX0keVxZ1lQ8HkrdFlSxb3II+LReFY+RNORt1yF5oTfdBvYtibkW6uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xbsL7i3F; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xbsL7i3F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uktl7P840xL7ynCeqWwQagQMfviqJDe3zhFd8jN2iIseJHvHwL7f4ZT/uOwYJwlEUZmJw/oqx3iV8KHGRQM7GHTNAiiTlHnsgLSyWsLjCqOWcLS5XDeTOwtxIlLLA7eIBDY8z9ppi7HiYIsOZAoXt4yziUbfOQDqptdvx0CWyuPJCcCKJT2OspoM/7d8i0gXg550fo1FQLUAQ8VMoartL8D9JEwAxC6QF/M1+QUDKyeAVptAKfcCziFX7L98P0I6GQnzRoXKZqkci+n9PsYkG3E50BE/HE3L63fL72rEKQs+99smVrPJSXuVXppB4+K3rjPv7BxCvWwzChAbbqBjlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrtuyKpzPTWwwyQgMzbLJ8nm9ZyLN6DNHqZ5ayjjHuA=;
 b=whZfu9xAfFyBLk1GaubvRcWF4srJcNdXhpcyeDsJ65HUx6U8N0BZwq1z6CurWFldZRdqnrzbVsJMQIpqwrr2a2k4zJyvYik+UyP402n97zDhCeKyE/u2IXArEhCLTrpgdLQVMTgLZyWN/nSFEFHwbXKX0jFY4l9lANePNRWAQFcVugh22evrDCrruwqbZuyGTA7iIBEoRoV5htY7WEaTLKG+l/lU3odyYhHKwQvCxeHIy6ip8u6+C512W2wUt4wurwNYORJVhUYqpZPteLe+v8+DiBe+3sv1Rsoxm+FzJI/+PskN1GjIdpocjCk2SvobUIxHDd6tTMktCwy2pyR+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrtuyKpzPTWwwyQgMzbLJ8nm9ZyLN6DNHqZ5ayjjHuA=;
 b=xbsL7i3F2i0h8r29GevNpIMFWqnwFTiGArbHeXKSYQGttThMaq/bslpE8/+jSJIopi3L2sm3evW/RYXe6Bd09WAojlG8ZugTnO5z5Z8g67jq3SUm3VXoVmLm9ATzYeczvwcMcFiPmyWvoKWFEtQfM4mAuMnAFbhSoj1u9Bs9azo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.20; Wed, 26 Feb 2025 04:33:45 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 04:33:45 +0000
Message-ID: <80875f62-b341-4d25-a83f-6713f3f69551@amd.com>
Date: Wed, 26 Feb 2025 10:03:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev, joro@8bytes.org
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0143.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::23) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b26338-aff8-437c-cf7c-08dd561ec14f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KytqWWVFbmxVM0prZVFsdy91cFV4am0zOTdITXViWGV6OU4zaGpPdDBuUVcx?=
 =?utf-8?B?Rm1TcGY1SXpvL01WK0tJQlg1M3p3Vzk2Z21TYjdrNGVFKzYxcGtHRkhubVYy?=
 =?utf-8?B?RnlTRlQ4M0FuaGZaSVFrdFRxaEZ6TmU1WWZkeFBlTi8wSVUyakxSdkg3ZSsz?=
 =?utf-8?B?OFNFaFVpYWtPL3ZpdDZ6MU41ZzVjYkVHVkxmNSs3RUNqeVVFa2o3WEdudFZi?=
 =?utf-8?B?cFlYeHBhSzdGVE03NVVWNTN4VXBoRlNXOUFqRzRZUDdTazFlcHJreHpPaElu?=
 =?utf-8?B?UXFQY1VzTURody85SmgwZ0RXT2ZNR3RIdW1ROEg0MUZjYmEwZGNodXptTmJi?=
 =?utf-8?B?ajJEQjZ5Q1pSS01qdXpUTkpEZW8zMFdZSUp3NldPK1puYTdPVzZvZmNrVFV6?=
 =?utf-8?B?cUR2SmRpb2xFSUI0eTFzN3N1Tk9ZTVNrU2JWSlJyQm1peFQrem1wUDZiOGxy?=
 =?utf-8?B?VE56bUkya1h1bHhIOXQ2ZzFjd01jM0xCYzFhU0VLRkpHeU8rajVhZ0ZQTXlI?=
 =?utf-8?B?UUY0dEI1NEFuZkc3VVc3eFFYQmdhYkYyeDJFT1VhcitRMkUyRGY0VUptOGpq?=
 =?utf-8?B?QjNaQVRod0RBdHlPUGN2dUZUWndqUmo3N1padyt1WllxZTRtb0wwRHQ5TTd1?=
 =?utf-8?B?VFNCYjJzWGxwT0ZSQjFHeGtqK3djK0pHMy9xYXpMMnZjSTdoTDNRY3lEcEN6?=
 =?utf-8?B?V2tOZ2F4dENFb2x6UEJHcWdxem5DaWVqMnpPdjk2a2lnNEFKZkVqWFFXTkJy?=
 =?utf-8?B?YlFPSWZGV2d1Q2Q5WHNHbWh6aWRLK0UxSTRFMlZDb3RCTEc5SmJLbUpkdEUv?=
 =?utf-8?B?dlpIU3hUQUxFNHJmQU0vUnNZTVVCZHBPR3pJajhqUWtCMVZjdEdWS0w2V1Fo?=
 =?utf-8?B?WFJrZ1luM25lYTNRa2NrSEZJQms0UHFyeFdSS0hYb3ozUGN1Vm94ZVpVZEZy?=
 =?utf-8?B?dWNRc015NlJ3dnJsbFpMUnI1VHVndUNHRldsaUZXd3VLcnpMajZrZ1Z3TlZy?=
 =?utf-8?B?aFlBUWpoVkJrN2xFc0Z6a2FMY3RPTDJ1YTY0S2Z5R2crbGRFekNTWnJHVkR6?=
 =?utf-8?B?UTI4Z3VNMVYyVE9aOWtqMStZTWFzaW1kMGVwalUrWjFoeVJsVko1NXRnSFd0?=
 =?utf-8?B?REw2eWpWQWlLZThYOXNiL1dtTHVxZEcveFRlRnRWTWhYWlZzaVlqSGFHdWhS?=
 =?utf-8?B?dnptK2h5VjAvM1lZazFJUTRXUVpRR0VyYncwSG0vclYzL2ZpSWljMmVUa2k1?=
 =?utf-8?B?a2hJQVpEZ05xU25qa0huMjdRRjRIZWZSSnFkL2dMTWlkWEIrREpqRjRVbkVQ?=
 =?utf-8?B?UXlCdnU5aXRjd212SjJDeXlTdm5UZjE4SnI3a0pJR1R5eU5mbWJ2aEZHQ2NZ?=
 =?utf-8?B?L3ZrbXFWQklUb2I4bGpVYmRFNDRDUEpabzRYK0RKTWZIdWg2dlFsUXMrL0FX?=
 =?utf-8?B?eksvLy93aDNSMk1JVHQ5Tm9Ib0w5Y0N4YzFnOUxEOEtEdjNpcVNndVdaaWw4?=
 =?utf-8?B?TXRsc0hNSGc5OXRxZnNndFlWTkJBUFpXMnMyUWprMklaM0VJN0NXQTAvWFFZ?=
 =?utf-8?B?ZnIyMnpDdFdLY2t5cTRQOVJ3cVdxSm00STlxa2VkWmVlbGNqZkoraVp1WVZ5?=
 =?utf-8?B?RVRQcVRTWnY0dlVJamY5a0I3SUJVanBZUWIxRFJsdnBUSDF2eTZLSWJvWUZl?=
 =?utf-8?B?bVVuVENQUlhpYmlvam0xZFFsam4yOEVEU2VtaWhPaXk4YXJmaDIxVVJ6S0hF?=
 =?utf-8?B?Z3k3L3lJVm81Qmx0cjh2dGplQ2xTdmo1cTg3REs3NzNhUkRZaFQwUGVid2Fk?=
 =?utf-8?B?Y3FOdHd2UTR0WHVFNUk5aWo2TkRWektFVkdKMzRaZzVBUXd0ek10UHBWTEs2?=
 =?utf-8?Q?UExdpfPJgph+K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWpnd3RvQXJrZnplRnhqeGN4amZ4TzFOUFNIZTEyL3RYZEFhcVNlSXVjWENW?=
 =?utf-8?B?UkNvOHZvZzROZjM0NXRPVkRjSVBKbHR1ZVovbDIvRmEyL05CUmcwaTdXL3dm?=
 =?utf-8?B?TlV1VFoxS2YwditnK0d1dHZKbURESlpPVmdqUFRVVThhcjBrbW1XZG04NnFZ?=
 =?utf-8?B?ZFhEbzJUZ0xmWW8vSmJ2RlRSSzdzQS9NS01pZUtaUk9TejMxTVVwcDJ0aFNT?=
 =?utf-8?B?LzR2U1drRG82dm1DTzVIN1AxWXNONTFUbnB6cUxNSUlrd21jRXJmeWwrQVBs?=
 =?utf-8?B?dDVURzM4dzJzdlFDcEc4Rkl2UHd6U3JVTVh0aWpYM0FCMWlXQTh1UHhpQTFJ?=
 =?utf-8?B?M0ozdWlHdWR5M29VdGhsOHV4MDlGMW5JelFUZ21neDd6U1A0cEppU3c2V2cr?=
 =?utf-8?B?aUZETHZudWdXK2p5VGZrNjExN0MrWXhUNHErcngxU014dWVYTjUvdmcwSW04?=
 =?utf-8?B?VGNMQk9BRCtnd1hHaVNuNVZYckJDVjVwYy9YTkt3SS82SVhhTVRNaXo4ajFR?=
 =?utf-8?B?ZlBaQ2NjOWVuWEk1MVRPOHJSODE5cGlrSHd0RkQyVUJSbDQ5WmlNdU53U2ZZ?=
 =?utf-8?B?ay85UGN4YTlzN1NhcTIza2RITXZPdnM5bkpMNi9wbWpBaml0cmszRGZ2Tjh6?=
 =?utf-8?B?RGNXOEp1Qm9WUFZhUlpXVG9XS2hiV2cwOU5Na3VJc3RaN1JjUStaZFZsM0lX?=
 =?utf-8?B?OWF5K0M1aGFteVlvQkx1NnU0a21GVUpETTBlUFNxYTFLZmU3elZBM043cU5G?=
 =?utf-8?B?SXdMWllyTkovZjBvK1N2Q0NmL0t2bGRBTS9TTU5yQllYRXJ6dS9lc05tQjJm?=
 =?utf-8?B?MktHY1JMcWorS2c2WXRyeG12L2I3MUFyTlRBZVcwQ2s5L0I3dDdsRE16ODBo?=
 =?utf-8?B?cGRxVmJJQ0N5QkllTmUwbjBqcVFnWGgrNXFIUWdBZlpVVnBvMTZqS09RMUJR?=
 =?utf-8?B?U3YvUC8zaTRKSHNrZnVPUklWNk95TWUyN0w5OXI0VEpLOXNYazBIUUtRT283?=
 =?utf-8?B?akM5U0t0TE9RRkw3eU1KbkNtL3p3dXNuTFlPK25FYWJ0UVMzRTJwVFNjdkZ5?=
 =?utf-8?B?V2ltMi9xK0hKZ0MzQW4vSnVXZ0VhZDcyYXYya1ExZnBiZnlTbWd5UW9NL2ZO?=
 =?utf-8?B?a3ZVNVhXUENOeVFESEdaTVJGRkwrRlYxRFoveDlUckdGcHp3azdJaS9WQ0U0?=
 =?utf-8?B?UGdEMkx2MEUvaXNNZDJrQSs1ZUw0STdFcy92T21menh5VnF5K3lKYkozQXJ5?=
 =?utf-8?B?ZHpxT2VUbzd6R1BOc1YwWWdoVFZ4dlZMWi90YXFNcXozdUZtMzhpOHpybGtF?=
 =?utf-8?B?SEJiT1l4cWRBVnhRbmdZdmRZeE5pNmFWeWdCOVhiWGEwZ3RiWndvY2cvdm1v?=
 =?utf-8?B?amlpb2NNY3JZSzdiZldVNTM0KzhnWnIzemFrRi9iZDAxVUx4UFNEdE9ySHBY?=
 =?utf-8?B?R0hKNS8yNHQzOUlXQXNMczdCU3dES3RSMnpZS3lLQ2lJSDVMcGNhbkVoTkNO?=
 =?utf-8?B?NWM0WElrRExqa0k3WWx2SEZ5dTF4dkVnUFJIUXl1STZtcThjOFc3OHJHSGha?=
 =?utf-8?B?dVR6MGREbFZ3dmgycmsvZm04N05PajNiQUp3UGE3MzZMblgvVEJVNjkwa2JT?=
 =?utf-8?B?TGsva3JibU9xNGhNSHEweXpYTkc0SzY4bFV1SGJidEt2Q096UkJ3dkNENzFn?=
 =?utf-8?B?VGNVVlZlRTZLNk1ReC96d213WjhUM0ZQQmZwQ1Q5QTdRakpuVEFNK3ZkaFh2?=
 =?utf-8?B?UFBnanN1cUFIOEh4V0xHMUtTNVExa1Faa2xDZ1NFTGZ4NW1vZXFRbTdYRHRO?=
 =?utf-8?B?QTU5RWpvU1RudlVwbGNESVJjUnBLdzh3MXdhU2ZCb25lbG1teUJEdVRDaDZm?=
 =?utf-8?B?ZERsWXRjZTY3R01Wc056N3dWKzQ0cmhOL05jRUpGYmM2YTFXalYzaDUvbFlF?=
 =?utf-8?B?MWU5RmNzNGJ2MDNDbEQ3Z2k2Q1JUTnBDc2FMenJzZEpkbWEzR3kvOEZZVnN2?=
 =?utf-8?B?VlY0VEZwTytET2NuaExZK3FmaVdXbkZOTC9Gb2ovTjJpU004SXk2MHFHRnZl?=
 =?utf-8?B?QTd1VGN1VE5BdDNKS0dnTkR4QmpYRkxwVHB6MmFidjB1aFZZWStOdXIrMndU?=
 =?utf-8?Q?MerTJyVyABzF8tOzC5QtBTBm1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b26338-aff8-437c-cf7c-08dd561ec14f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 04:33:45.1671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9yUngrOEDRqHiS0BC7m7AWOos9xbU1AMA7voI3W1+SrlJr5vU80uIuQivEWRAHgn27gXFe75gaJ/QNCN+5Pxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889

Hi Yi,


On 2/25/2025 6:00 PM, Yi Liu wrote:
> On 2025/2/25 18:58, Vasant Hegde wrote:
>> AMD IOMMU supports processing ATS requests as Secure ATS requests when IOTLB
>> is supported and enabled (See section "2.11 Secure ATS Supports" in AMD IOMMU
>> spec [1] for more detail).
> 
> glad to see it. I'm also working on Secure ATS for VT-d. Intel Secure ATS
> has an extra table named HPT (Host Permission Table) chapter 4.2.4 in
> revision 5.0 spec. IOMMU uses this table to check the address in the
> translated transactions to ensure the device has access permission.
> 
> We plan to support the HPT on S2 when nested translation is configured. But
> we may let the userspace VMM to decide if it wants SATS on specific device.
> The reason is that some devices might be considered as trusted. e.g.
> integrated devices.

Yeah. That's another option (ATS for trusted SoC devices and secure ATS for
other devices).

> 
> My thought is to add a flag in iommufd_hw_capabilities to report the
> capability, and add a flag in iommufd_hwpt_alloc_flags to let iommu driver
> know if HPT is needed when allocating S2 domain. Userspace attaches the
> un-trusted devices to the domains with HPT. While trusted devices can be
> attached to 'normal' S2 domains.  Will to send it out soon.:)
> 
>> With Secure ATS, for ATS requests IOMMU return GPA to device instead of SPA.
> 
> I suppose AMD Secure ATS only works under nested translation configuration.
> is it? I guess admin may want some flexibility to opt-in it. :)

AMD Secure ATS works under 3 scenarios :
  - Baremetal case w/ AMD Host (V1) page table (this include VFIO passthrough)
  - HW Nested setup where both page table is configured
    In above two setup, its opt-in feature

  - SNP (Secure Nested Paging) is ON
    Secure ATS is mandatory.

-Vasant



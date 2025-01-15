Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659D4C6C
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 05:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736917604; cv=fail; b=D3wdedXBWolLISCPFpQac4MFyrD0Bv/vRVQluFKJjiDTOO0HrGrOdGtyx33x/CjLZEavtKgdWVrtJs1yGG7NDZi1KcplXGkyFGFr1TR+Ksa42+9A0cljbN+ntPdFWz7kGZUb7JI7gRY1ypFDPlmvfwTIu/M4mLSGtcfiD4aapJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736917604; c=relaxed/simple;
	bh=q/eYu6oedfgsnwsXamPVpBdzAORXvvSNKU12eyXWy+M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pVU5kbT4v/nH2pPWmAK9uwLLRHvnxOcOE0BLf6LNwfuKOfKVJ+SXNuAZvuYoKWtew+l+CbFRKJGoFSzit3YjnR/O7LnZVEKN1C1dl3ng3mG/Od/NKCbg/Cu5k7NKFQPvkOJ1YVReaEHARBbNTsWacNZgqPyPlWWF/ExKm7IPNuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IvKr8A1j; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IvKr8A1j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vus1mafrg/WiJtmYTIC+YqJzHK1jJig+B6omFeB4O7wzsIwIiyU2dmYmW+HAb8oqA6811y1WfoyUsublmnHD22tZozSRx6vSVNecEiCvWYbvOOApYlj5O8GWx2Cs3dJu3QE52MsrBS0mAXzn18CA/OhpORMsjcmWZsLnq2QisD4I6BfdGSNvWAaJr8xUM0tc+0ZgXE/I0cAKkA+ExstYJZkM4V3oMvxkZbe7NX67ztLZrjy2/9YcRYYs2pg43H/9TMK3KhlPcXaFV0zA5M8AB+/axXoHIEkgEwQEBwmd4ejj0b2iJaxSP+DZ7OpDgy2DkqmG3L7aGVMdqYIDRmLzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX2/h2nmkm986aWoTKw4tFJwc43xpzclPB/oKDC/QwU=;
 b=Lpc7k5rfkmMzDn/H/QoFCDMiaMixoiKBlQgDQTKCalk5NVwqn/e/moNTVQk3A7Bd01Iu3SugPIULfqzcdbLbqnCBZGFDCBFjOTQhjUdDY9IA3S+boHNuqiXjY66llvC3E1bz37KIYyMhtO4gjQVfBUsVMNhKxuVzoo2RO0fl8iy3KXm6AC/oigDeV9u0+PVBAc1W14OBTbA+4CTiRKhxAUaP+mjLpEkmKwwM3sYTL8baAYj7nR8d3xSmJ97y3z5EBkY+KvR0SFawVxKqvSORyxWusSxwPQuuHzknc6DT+vZcAeUrwVySuZuI8Wrpw+aWwvO+fOwvDDjsacrAj2wcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX2/h2nmkm986aWoTKw4tFJwc43xpzclPB/oKDC/QwU=;
 b=IvKr8A1jPGIDABbkx6RxT+zvAajoBtWcss97HVkY9480H1VEhLS5zYiAYEB60QhqzVpeveJ/gnPTyMWSxAdbPtsD3wKW/7JDee5Cg6poRC+TuxREiDKWc+BmxNGbKcPITQN8+d9VtGvZaDdQv6ttZ5aFtdkHbb9c6XF4pFDA3t4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Wed, 15 Jan
 2025 05:06:40 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f%6]) with mapi id 15.20.8335.011; Wed, 15 Jan 2025
 05:06:40 +0000
Message-ID: <abe84488-9ad2-4ff4-9499-7d5c3b361cf5@amd.com>
Date: Wed, 15 Jan 2025 10:36:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] iommu/amd: Add debugfs support to dump IOMMU
 Capability registers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 vasant.hegde@amd.com
References: <20250107201847.GA179670@bhelgaas>
Content-Language: en-US
From: "Srivastava, Dheeraj Kumar" <dheerajkumar.srivastava@amd.com>
In-Reply-To: <20250107201847.GA179670@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::13) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdefa81-4b4e-4b04-8266-08dd352264b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHNkQU5zUDlQS2hCOHNEMzlaQnBjV0phVzRiaThxMEt0b09ucGY5S01aZXdI?=
 =?utf-8?B?WW5tVXRlWUdsOGhGdG1XNzZMdXhTL1YyM2pKR3dLMHUrbEhpbHJnM1IxUFo2?=
 =?utf-8?B?SlJyckExdCtrNUhLR05RUU91NndoRHV1WDZxTGdWK3l3dUlLcFZZR05JaU9Y?=
 =?utf-8?B?bTJKVW9id3BNeExpSElWVWVLWEhLSjNCeFpMWG43NWhYK2RRNzRwcXFTUXg0?=
 =?utf-8?B?OVhYVlcwNnE4clNaQzQxS1N6bklpbER0OThaWjV2bHZ2WE5CYUxwNXRNMmhX?=
 =?utf-8?B?OEh3azJWZTNzNmYxS1oweW1CTXAveHEzbGEvd1p1VmVZclg5NThEVXBHK1ZJ?=
 =?utf-8?B?R25sZGs2MmhJQjlXVThhUFBPbDd6UzhuV01XMXpFVGdGbFNmbWRJcHF2SEtn?=
 =?utf-8?B?enpEZ3ZPMTZQTUJRRjhvTXYwMWc4VVJQdTcycUJCOEFoQUJ4SHYyeG10ZVVV?=
 =?utf-8?B?MXFpYjh0ZE9yeW1XMTVnUDVIZloxempwS21JWmUxd3FCRThUbi8vdHZqY0tC?=
 =?utf-8?B?bnhrcVpPb3lYaWFySE5lVEQ4UXZWUi9WUTRXR0p3Q1Q1a21Bd0d5RkxnbUNi?=
 =?utf-8?B?blMreG85S3JQUHM3SHNLYXd5eWZQOVZKdVFXQ0FSNEZSeTdxMFBEaS9jTkxM?=
 =?utf-8?B?WWV0ZnZDa2hwK1ZVZ3d5UGF5cDFwT0lVZUR4WW9qMC9PVVdIN1NtSjZLaGlT?=
 =?utf-8?B?S2ZkRVhTaUE0UmhOeDJ5Z3A3WGlxVWYzTGcyTFlOMmJNd3R4VWFWY2NmMkZX?=
 =?utf-8?B?WDZyNnc2TXJ0TDdtaVU4VHJrRzlwS1J3SXVHZW90R3BpanBPZDhQY2dXWTBU?=
 =?utf-8?B?TU5HRUE5VERiM2QxVVhKS3lHMW9tbWVNRFFkenczSmxOaUZzMWk4RVJBcmJN?=
 =?utf-8?B?REhhK01CNnpFVVY4MzFXRlRHbm5USG5GZ3pqNVNqT2VrdUxYVjdvOHlEYXMx?=
 =?utf-8?B?bXNSMTV0MmZlTG9hQVVqU3JwSnZ6T0twS1BSanJHaXk4eEdhdkJRTGN6YWZK?=
 =?utf-8?B?WG16VG5CYkttcTFRY0ZTNlFqNWZLTHZycnI4bGNSUzVxYnRGNnB5blUvQWlw?=
 =?utf-8?B?UXdqMDF5T3RkR1ZQUVo3NDFtM0ZuWUJ6RmtHeFN6ZG4wTmUzREZIeThlOXFT?=
 =?utf-8?B?dDNlQUhGb1dpR0NlSUM2a3gwazdJVlh4ZmkzZWx4WFQwZ0gzdHZyM21XMlVX?=
 =?utf-8?B?Z1dFdnNpQlNLem9RSFpBM0VPQlY1NW9EYnUveWQ4QWpZNVlmM1AxaHdCbVBS?=
 =?utf-8?B?d2htWmE5bjdZa1VMaFBJWGpwWkdNa2FiWFlvb01CaFM2OWNtMGpSRHl2b3Vz?=
 =?utf-8?B?eHU2eGhwdUg4U3p3Ry83RVQ2eFV0MVlBc3MwUmh3VHRYMlRDTmJTWlQ4VWFH?=
 =?utf-8?B?N2N0dlhhWjJQY09GVjRSVDFKckRTMWlkSjJ0aDhwb0xFL0U2cWNsK1Fzd3Vx?=
 =?utf-8?B?TWEzQ1R4Q1BFNmpLY0k0OEgwTk92UjhyU21CS0c5b2FYN2lYd0krdW9WSFZV?=
 =?utf-8?B?QW1SQzFmYi9GUmNZQnYwK0ZGdU9VS3lBNlhaMVpMZ2JrQUwyeEJwN0lvREhx?=
 =?utf-8?B?RW12SGZRVzJQSXpkMkJNbGFTaWp4MzMvVUNhNGJMalpmK3hudTY2WUNzL09Z?=
 =?utf-8?B?ZzFiY3UwYzBlUys2UXV2RW1zV0VWbWtDTnBxdFZSeWUzb2RKK1g3T2xxc3hT?=
 =?utf-8?B?LzlnYk1qQ05QRmFmSTZWQ0JnOTBFaXZPQm51MUJVWUY3Y2FXUVYyK2ptRDNN?=
 =?utf-8?B?bllJTjdhSFdjdmJVRnYxTWtPYktPWllRcXFMTkEyaHB5cU1aWTM4MFRRQ2Nr?=
 =?utf-8?B?My9JeWRGUmRna2hWcDhHeW9pY1ExNHUyMS9CQ0tEVDJUUnZLN1F0ZFZ0bERV?=
 =?utf-8?Q?grQ1RxBCYki0s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXJsN0t6YURaWEF1OUhDaktIWUpFOVpoZ1V5enphaG1qTWp5WHo5QVhmT25L?=
 =?utf-8?B?c0ovRnZqTWhiMi9UQXlPMDM4VWFoNURXazJjbmx2NjkxU0tZYTArc2lCMytD?=
 =?utf-8?B?SjgyYnBNR0pBMDlnUzlBbHRFcng3Y0JqZU5aZWNFWG1PdFBuYVpLZnR5UzVp?=
 =?utf-8?B?eWdSTHNBbnJxVDFwV0NOSm1YMHpmd2JoOTlhR3ZXZ2cyRnZEMVZLNm41N2ti?=
 =?utf-8?B?UkJPbG9ONm5MdDN1TTZYc0FxL25wRFNYVFhaOEJmSHB4ZVEyejhpOW5KS2Y1?=
 =?utf-8?B?Ui9vZDVYMWNIVHZGWmRKc3BKYUp6Z1FlY0VQZ3dzQlJWSzEzRldJR2RXdkRa?=
 =?utf-8?B?VE8xNEFRQU1hY3VGUUY1NWFvcWszQXE0d1p1d3E5SkxkRjBQZUkvNTBNTGdv?=
 =?utf-8?B?SzZSL1lDbmpLVmdpK0p4c0ZGeVFPOERya29RSTZXM0NRYVNraDVRQlg2QzRS?=
 =?utf-8?B?QmJCb2duOVdoRHZoMm9EWDQwM3E0V0d3T01ZNkkySkhzZUhsQXFncEpRK1M0?=
 =?utf-8?B?eTcxTS83OEVJZnYydFRUR3U5dUZkYy9TNHkralJhTUFNMnpqM0ZaV09xTFRn?=
 =?utf-8?B?c1JoMHRyRTlTdEFYcVFnS2JwL0ZXb2d6eEVYeGFKdGZpL1k4TURwdEJFUmxF?=
 =?utf-8?B?dmJxVmtXU1c1ZEN6RThUUzdGZnhQUm1jSDdYWGNQVndFd2NUaVQ1Wjc5Z2RV?=
 =?utf-8?B?b3RiMjZodVFzQ0w0bEt6MmNYZmN1bjJvamxBMWNzSEo3VWhjSjFtQlNJdTlN?=
 =?utf-8?B?S29QbVh0YXpYQkdoL0NDNnZ6UjljVFEwajRRMzhXMmFvaWE1MXE0bjhGQ2xK?=
 =?utf-8?B?cFF5NExyUVpKRDVDVGtUSXVtN0w3Q2E2NldaY2pBSlE4OXI4MDdpYi80TGdk?=
 =?utf-8?B?ei9nNkRBbGlka0pDNWN2Rm10M0VxSytSaGw5Yk13QkFBRkppMFFpQ09kWW45?=
 =?utf-8?B?MzNOd1JhSnROR3d5WXl3TGIxUjhzMUhpY01JU05lcnkzclIxaXBOeDJoMVpW?=
 =?utf-8?B?T2xyV2ZXajd4RkRnY0NzdUd0U1BWQzV2RWZ5OS9oaFRVWjIzeHg4K0tDdXJY?=
 =?utf-8?B?YVRKVWFqaGlHS2FFWTdKQ1Zadnk4eGh1SS9mSXpsc0RsUHF3L0h5eXlwV0sv?=
 =?utf-8?B?WkVZZVBnMHk4dEtBdU4xN3pLVGxaRGtHZ2NWMkZPd29pYXhKZ2ZVMENoaW9Q?=
 =?utf-8?B?SVc2dnJWNWdPcVR1R3ZpTHl6WUlYVHJrOVE3clhSdGU5ZUVWUTBCcE5ib2h2?=
 =?utf-8?B?RXJtN1p6OGZsTmlXNjdvT2lYci9ObEh2amNLb05FN2Q2ZmRBdU5GVWhScFhU?=
 =?utf-8?B?ZzAyd2YvRWo3VldRdkx5MFphU0lMSEUwQlEvSk5BaEkrVTVzTkhWejN3VE1Q?=
 =?utf-8?B?WHhrbVNpcUV6NG9RbG1yN1NWTXUwbk9YbE5tK3Rzd0VhYlRtTUtCZ0NuWkd2?=
 =?utf-8?B?Y25vZCtHQytpOHFqcW1PaEtTTmZnMEF4Mk0wYlF1ZC8rb2psaFFWSUcxTXY1?=
 =?utf-8?B?b2JIM3hsdVd3TU9xWndjSFh2UFNWNzV5UXEveEhteWFEcGQxWU9ETmhSUVdQ?=
 =?utf-8?B?ZHhFcWxaMW0vSDFLQVNvR1VXdDR5WXZBSlF2WGhnUmtqSm1MTWdRRno1c1lG?=
 =?utf-8?B?UVg0elBXamovUWFiU0cyUTNVS293eDE1REpTNC9oVS9YY0lyWldIck5sYXVP?=
 =?utf-8?B?RDhoS3NsYjR4alc4SXZhUFM4MXcwb1YvdjVCdHU4MDJ4c20wbTRDSDdncGNK?=
 =?utf-8?B?Vm9ySDlranBNdVZkZGdBL0dqbkw2aUVueUtYTHB4ekdlK3J4dWNsdDFJR1R5?=
 =?utf-8?B?VWNwY3BlQVRCVmd5aTZZcE1EUE1Vck9vbTVDNTRpOG5VVkZuL1FwNHBZeVNJ?=
 =?utf-8?B?YmpmbS9nUElKeWo0L0FhODl3VDQrMk4wUy8rTVBHOE11cWRzUVdlUVJkOExi?=
 =?utf-8?B?MVc4ZTRaQVRFQVp5QytaUkpyNjBnYkpLLyt4N0Izak1uSnJVaTMyTU9aZHJY?=
 =?utf-8?B?Z3h4R0lrckZjbUdBYjhHSmxOSlVzblpOYVd1UU90OTFwVVdXTmovZGRQWS83?=
 =?utf-8?B?NksvSGxEcWt0WlRhUXh3a1I0dHZoQmtGazdXSGYreU50MTZaQWNybHdkbXhz?=
 =?utf-8?Q?enkwx+46K8UBBYIp5apYcCkga?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdefa81-4b4e-4b04-8266-08dd352264b1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 05:06:39.9029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMAG36PNI5sYb4+ckc57oFx4El2QHzhPjMllSno2BkX5CS1yX9vj5qC3u4c9f4+LD/PRs3zBnIAvGEWDrwbnLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226

Hi,

On 1/8/2025 1:48 AM, Bjorn Helgaas wrote:
> On Tue, Jan 07, 2025 at 11:33:16AM +0530, Srivastava, Dheeraj Kumar wrote:
>> On 11/27/2024 2:29 AM, Bjorn Helgaas wrote:
>>> On Wed, Nov 06, 2024 at 01:16:34PM +0530, Dheeraj Kumar Srivastava wrote:
>>>> IOMMU Capability registers defines capabilities of IOMMU and information
>>>> needed for initialising MMIO registers and device table. This is useful
>>>> to dump these registers for debugging IOMMU related issues.
>>>>
>>>> e.g.To get capability registers value for iommu<x>
>>>>     # echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
>>>>     # cat /sys/kernel/debug/iommu/amd/iommu00/capability_dump
>>>
>>> Same comment here.  Why does this need to be so complicated to use?
>>> Can't you make a single read-only file that contains all the registers
>>> of interest?
>>
>> Please do let me know your concerns and views on my comments in the
>> previous patch.
>>
>> With the implemented approach we do need separate files for mmio
>> registers and capability registers input/output files as to
>> understand if user input is mmio's offset or capability register's
>> offset.
> 
> My comment is not about the difference between MMIO and config space
> registers.  My concern is using two separate files to read the same
> register.  That's inherently racy:
> 
>    UserA# echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
>    UserB# echo "0x20" > /sys/kernel/debug/iommu/amd/iommu00/capability
>    UserA# cat /sys/kernel/debug/iommu/amd/iommu00/capability_dump
> 
> UserA expected to see the register at 0x10, but sees the one at 0x20
> instead.
> 
> I think there's value in using a strategy similar to other IOMMU
> drivers, e.g., intel.  But I'm not an IOMMU maintainer, so I'm just
> kibbitzing here, and maybe your strategy is better.

Thanks for clarifying. This makes sense. Will update in the next series.

Regards
Dheeraj

> 
> Bjorn


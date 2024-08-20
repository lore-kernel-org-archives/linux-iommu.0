Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B918A95C
	for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724142623; cv=fail; b=KMWJuW92B59iVTjXusCBSjDihPoYl3mk5fyxmUZsJWUQgug9IsUx7VQIZgzgg9grNBgNThn7ExvsudVLZcm4SylOgb0MRz0dka2sVynxv2yMiKmLRgrL/IXE1ikka2V6LGdoK8HiXq77qAeAPsHwSOBnxxZYnXmuIfvShsYTX/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724142623; c=relaxed/simple;
	bh=NHPGS/YcifIXAVRgjcVqZk79uxC23LyYINZ9QCBQe9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y6kANGQ3XErDf2SwW8XUVqAj97HgjlLt9AOmDWqtUEdcPDJGbOU0Up42vL/qtZ8C5NhyZlN1qVjfcuv9yzvKwjst99268IHARJHD58zNjU/zj5k6JNoQ0M7i1SKg714MPEIzLtazNG47CagVfKBffACM77yFcq8rBMt6LNP6I+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mV1vW047; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mV1vW047"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sehot+Cai+/EgcX1p+I4Yjx4tTE379WNnFo7dAWx1Z7AURbk5eHHPeT+yNLbtmzS95ng5WrxUIYGLbq/4cvEkb4ITq/P1mud9bANgHYGMIeppVwEmev6vvOcUfERKu4rr5f+0TIVEAYAy5ke987W2u9TI/+3J3OJtiuuyz3wd9TKJxsD3rJl1aycJTHxkhqYTcV4ELKfVAd/NzVYVFPVQBn7a4MJFF+HxVdwtFMk2p/blmJ0YHx2+C2S83i+8LW556MJlr/yMTiO5M8M8QevfrQAWzIgMm23JmYLpN3JdkQwWbVrqtPpIXzvFwGJ7cuM6iW+XKGxzA0PAwRYg3L1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMtgv/9XJb0vFCZE0ktkBynUl8swTrkn8wQV5wuSQWc=;
 b=PlM4jCBYm4PaInIMGEvQRCBlAImf5TuA5YYxF5uB8LJykvCOi2kE6aIv2SCD4swckiX75PSl3TrWwZlb1HkT7gRv0NKpW8JVKSkXjlieUww0yJYArqQ13AmkuDVEBZ+y/BkR/pzpoRKNxhRCbDo1BHVpGXrr9l6wWHoUW1Q9kcSp+ClqenFdfr54bMrdFz+XYyjayTuG09prDP7YAIjbu+UJE5pWXaiGd86T+U4p5XKOMcJGslGkWTXz8U6CgX8ORsdyAKFfFApBzb/opp/Rk2W+o2xJ8S+db/gU3ydwVRWj+t0XnQ3XzonS8xnIkn1/TRtry6LcM3NFwB7ElFobgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMtgv/9XJb0vFCZE0ktkBynUl8swTrkn8wQV5wuSQWc=;
 b=mV1vW047riEprA6juOJy050JUif71tw0TwHTUJzqe50MZAGBA8zgCM38EqZjEBN3+1k7JWk3Cr16a08HeQXxkca5wILbpdj/s2r95pN9Aay5t6VZPqwYUQjhLH0DC1KShqiMPRzPrKdKBNpxKInfLr3Gi15lhcg+AVvmN1dKH04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 08:30:18 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 08:30:17 +0000
Message-ID: <72e59734-431e-4eb4-b27c-44eefab3dcb0@amd.com>
Date: Tue, 20 Aug 2024 14:00:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
 <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
 <635b24b7-632d-4046-b82e-6ac6976686c9@amd.com>
 <0e807eec-ce51-42e2-9290-dc90c4210888@linux.intel.com>
 <20240819123400.GU3468552@ziepe.ca>
 <4d9c1513-8062-4594-a06a-c9f179abdaab@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <4d9c1513-8062-4594-a06a-c9f179abdaab@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::29) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce3553a-f726-43ef-1c39-08dcc0f2524c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXlwUXFoK1U2UG5rSUtPcVl0WHl4VlRvL0ZlT2s4TFdpa05nZDQreVBmcFNY?=
 =?utf-8?B?bEs2TFNvZjRrbWJ4MTB0WnBTSE11SEZldUNwQXBlbEhWdFpRdm92WDBIcGh1?=
 =?utf-8?B?Z0dQc1lBb3BCY2lxOHNLeTYzVVRFamRSYzdKK0NCZ2cyS0pkTWRRNEUyNmk5?=
 =?utf-8?B?dlljNWlkenBSNysrRGZhbXRWYzhsV2lPL2RTZ2JwWk4yblpURWdlK2FFeS9o?=
 =?utf-8?B?dDJSQ2pPaTczWlIzb3pMdUtwc0VJQXFzR1Q2Uys0TEIvZWNoSEJvcDIrL2RT?=
 =?utf-8?B?a3J6bnJpZDNTUWdPbkpzeGdTM1JFdHg2N2tpYUM4VFZ2MFYrbnVyNXJCMFRI?=
 =?utf-8?B?RWdSREJwaFJrWWpNaGxyY0t4Y0toaGpKMjJKR0F5L0diR2NESGFMMXlibG9y?=
 =?utf-8?B?Rllwd3pJYkJxckYxU3ozMXJMR3hraytpVU5wblg2ek9rY1g0MUtzcFVWWUxM?=
 =?utf-8?B?LzlVY2VHMHIyS1kwTVk0T0E2c3RuanBjZTJDRm90VTJOVU81anpMNkhXbFhP?=
 =?utf-8?B?VVl4ekx5Y3RnWnJsUW9xVXpXQkliald3VnNsbm12R2thbXB4NkZCeld4bm9W?=
 =?utf-8?B?bVVlZURWaXhoUkE2SHQ0ZlUwYlJDY0R3bm9BZmVzcUdKTGlCN01qTWdQY0lZ?=
 =?utf-8?B?UFY1UDIrdVN2NG9KdnFsRGRaN0l0UzZYQUlacFRaZnk1UVJPTEdjZEFyRGpx?=
 =?utf-8?B?SEl1eXk4aVBWbjk3dTJEdGw4REZFb3BHUHlrWGhJZWdwbUh3ZDVsNmdUS0p4?=
 =?utf-8?B?Uy9qaGtYS2dvOXM0b2FhcW92dlV4UWc5aXhYcmlMTmtvREYzUkxnVlBtbGtz?=
 =?utf-8?B?S2hZZDZGUjNxd1lJVkVmU2lENnVCcGJVQ1lEUzlzZnkwYXlEZ01xcFR0TjNh?=
 =?utf-8?B?b1llQitWc2F4Mm1aTkp2SFFYWjU3RW1xT2M0ckQ0dDNiNzRad2plWEROV1Ru?=
 =?utf-8?B?N1pWVVFNRGFrVFNlY1lsaEJZbVQ4L2xiTVdQdWh6S1RLT29NdlpSNTBBRlB3?=
 =?utf-8?B?SmI3eVNjSEQ2K3ZlclFjRUVjTTVCd0xreGpuY2hiNnVXOEErZkVNS0lJbFFS?=
 =?utf-8?B?dVBGWFR2OEtQV3QvMzI4ZERSdW52Ti9CbWZXZXc3dWd5YjhYUXUwaytpYzUw?=
 =?utf-8?B?em9oVXkybHprR1cxNHNOL3V5cVZGV3NTUWdTRGZwQVU4RERWLy8xQ3p2SXh6?=
 =?utf-8?B?ZFo1Wjl0dTh6RlBCcEY0TFgxeVZFTmdJcXpWY04yeTBxNVFBQTZjSUhPN2Q4?=
 =?utf-8?B?Tkl4UTlrTEJ4cGYvVC9vTndqK3JoZG9pWlRJVkJ0dVJyL0xsMWdHNE5rQzRT?=
 =?utf-8?B?M0tUOXY2dlpMV2tWbVR4Njdkbkw3UlRDQytlY0w5aHA1SVdDYzk3dzRRMzNh?=
 =?utf-8?B?MThkT2ZRcXB6ME1TY0lzb2t2OHIwa1RaOUVSZHIzMWlVcW9RaEVCOGJHakNr?=
 =?utf-8?B?QWpPQnAwY2t0SEZLN09LOFc0UTdUMUNTcFYyNUhnOEJ1UWlwYVJsSmdCU2hv?=
 =?utf-8?B?OXE5U1pFRUoycHp2NGszaVEwMHgxNDVIc3MwcG9zZFZIcTFteEd3MUVrWDVB?=
 =?utf-8?B?TlVMQmhBYmgybEFwVmpYMHBFdlFhbkJvVkZpdEExVmpkUVllYjE0RzJ0TVZB?=
 =?utf-8?B?WSsxZURBZEk3eDRyeUdYZ0RacTN4YmlsQVJ3SmtmWEZ0V3lQR2ZyTTc2WTRC?=
 =?utf-8?B?ZUV2SjRNWkVKYXhKdmJhNUxNUE9OaFhCVCtIdkYwd2tRaVV4TEcrNUNtQVJC?=
 =?utf-8?B?aXl2eUpUNEFQQ0hMSDlTbEZ3b2phYnFxUWZOcmpPSWVsWWN6b05QSWJpd044?=
 =?utf-8?B?dldjZ2wxaGNUcURrWE9vUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SytLeFUxYTFtOVBEZGsvcno1dnQzejQrT1BoUllqMjJTbVZxam96N1BhdjYx?=
 =?utf-8?B?VGlIcVprZjBYK2FkWHNhU0c1d2RiVEtlVm1yYmJDZWJ1blEwYTlWWUF0YVVo?=
 =?utf-8?B?T1UwM0V0bzlsWklTQnpLNTQ2Q3dObEp0TVJFVllYVlZIQVlwekZWY2o0eWpY?=
 =?utf-8?B?ZkhtUE0wTVZvcDdBdDcrTWVvVGJjM3NDbk9OekhlRU0vTUxQMEFtVFlJT0ps?=
 =?utf-8?B?NTVDTDZmRXBnNml1STRSYldRTjNYSUMzR2dCNlBvOG5yaGxHeVRldVJ4RnA0?=
 =?utf-8?B?ckd4WmNTeGVWVGpBSFZVcG5XdGgwYVFlTVo2NndyWVpJc3h3eWU5TjcvbnJC?=
 =?utf-8?B?T3ozL0VEZndIK2ZCUnZCMHUyVGdmSFF5NHRCb1E4d1RRRDZFc1BoME42YzhW?=
 =?utf-8?B?U2FPQlN4OXRpY2JCUFN1b3JJZ250WjBIaGphN3dTbzdBNkJucUR4enBhQkFN?=
 =?utf-8?B?QWxJQ1cvdUJ5MTVBaDM0bm5pT2xya0h0aHp6akZ0K3NxUkkrenJmeFBScGZ0?=
 =?utf-8?B?enNMMmYwajVicDU3dFAxZXRTOEY0TTBwM3AzYVJtZU53KzluWEdLZ05xR2Nh?=
 =?utf-8?B?ZHBjczdwV1pQNVM4RE9ObDFBRUNWMTZLM0xqWTVVbndQeTk5RXZUdUZlWDEy?=
 =?utf-8?B?VVphZURacC8rOFpVMHR2U0RvWDJmMW9DUmNJZmVvcml4U0pRTXByL1ljZ01q?=
 =?utf-8?B?OTRFMnppMnRCQ01MZnV5K3dGRVhTSkk3cG1kamhudC9uUDlSUDBkR3NUYmNM?=
 =?utf-8?B?a2xjcnZmQlhHSnc3R1FnNmhDMGFmMkEyZWZlNGxvaHpRV1Jicm5aeldCV3Yx?=
 =?utf-8?B?NHo3dlBFZC9BY2xHTHNwdVhMaVZuS1RTQWZVS0M1aEJtR2FjZ2RCLzcvOFc4?=
 =?utf-8?B?M0FqOFFMMXJwT0c5RDF3UEYvQUt4UUtWNkJ1ZHZzT1NEKzJMSnJURE4veXMy?=
 =?utf-8?B?d3Uxd0JpMjhpblI3QThCM055RFVzRStYUThkNWNvS2QxQTJjWEdsazVnSTFM?=
 =?utf-8?B?bzVFWFZWT1RKcWdRZlEzYjlEY3AzMHYwVFpYTUw0ci9vL2djS2FzK0k4OGhh?=
 =?utf-8?B?VUFQNm1NMjd4alc5aGQ2aUE3WDdQNEZiQ09FbnJFd2pGZ1VWS0w5WlMvZThS?=
 =?utf-8?B?cE93SGFUcEc0bGNBL0FVNFppZG5SMXhHeTI1Mm9WYUdrNGI3V2RZcy8zNEJn?=
 =?utf-8?B?SjRWQTJkdnJ4UGI2RUM5cVZSd0U0S2NGYjM5VC9xMG1uVm84cEFnbzNPWXV5?=
 =?utf-8?B?RXJPV3lBYVJZMDQxb1dnNmkvSXM2M28wNEhHYk9RVkJXZ1pJYk5Tcm95alBJ?=
 =?utf-8?B?dU1mV3ZaZ1o4Qng3OFppUDZ5c1czK3Z2bU9LYW9aY28zYXhZeHhJWjhkdUM1?=
 =?utf-8?B?QXR6Zk1RSmt0eWQvcHNrYzM5dWNEbUgzN3JvZjJSbDNWU2xIZDU1a2VpNXJm?=
 =?utf-8?B?Q1dzYjlzc1ZHWXV3TXgxUlA4cklTd3hNZ1VMTHZkeEV5c0NvaVhyQjFaNWRr?=
 =?utf-8?B?OXZEZDl3UmNCZ1AyeUFpbHEvVXprcm5sbjVnVCtEY1NqbzU3SjRhUU1nL0o5?=
 =?utf-8?B?NWdZd1pOclpNQkRlWlJOTWtSVllkUHNGWWlBNjN3TnNuWWdPSkhXYktYbGc5?=
 =?utf-8?B?RUIwWlk0ZGRFNm01aEV5U0Viazl6aW44M2VsQ0YwYXNBSVo4S25nb0hLU2h6?=
 =?utf-8?B?QnU1K201THdwRzlLclFlVFJOUUtoRVBucHgwV0hlVGF3ZkxYSDgwMkhIYmI2?=
 =?utf-8?B?ZGlZc2lRakRLZk9ON0NoU3BjdHBFUDA0bzRNZlliZ1QwVlNudFlSTVRsbnB0?=
 =?utf-8?B?UE5rb1EwVFppcXh5UkJuM1ErVW5hbVN1ekdLdkdzUWhsNlF6My8ydTJCdXl2?=
 =?utf-8?B?bFBFOUtGOTNxdjFwMGxnTndtWDRtU094UjJMK2dEU3A0bk1yU3NRWDZIN0x0?=
 =?utf-8?B?b1RCdUNnak83QXpheEtzTzg3Umoya0EzOXcvYjh6TTdZeXFsQy9PZHhwcm9t?=
 =?utf-8?B?TlJvMXZSZ3BUaWVkMVBPRDZFeWxQSGZralJ4dnNJRjl4SlVOVkxBVnNUU3lX?=
 =?utf-8?B?clRGR2R1MEY1TjZVVmNEUnBaSmNXYmRJRFRybHhOcjQvc3p5T0taT0hoL2ND?=
 =?utf-8?Q?/BTxEw78Rad02ESx4fMK2ZInx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce3553a-f726-43ef-1c39-08dcc0f2524c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 08:30:17.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFpZSru4oj9uYlxCsPkcrJEeJRDjRUobt/s+wrF4K6VbY+zemvjhosWZtFzTrIbob2s7eJe5JeWBkWdk8lOXvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460

Hi All,



On 8/20/2024 9:40 AM, Baolu Lu wrote:
> On 2024/8/19 20:34, Jason Gunthorpe wrote:
>> On Mon, Aug 19, 2024 at 03:09:00PM +0800, Baolu Lu wrote:
>>> On 2024/8/19 14:34, Vasant Hegde wrote:
>>>> On 8/16/2024 6:39 PM, Baolu Lu wrote:
>>>>> On 2024/8/16 20:16, Vasant Hegde wrote:
>>>>>> On 8/16/2024 4:19 PM, Lu Baolu wrote:
>>>>>>> Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
>>>>>>> attached to the device and disabled when the device transitions to block
>>>>>>> translation mode. This approach is inappropriate as PCI PASID is a device
>>>>>>> feature independent of the type of the attached domain.
>>>>>> Reading through other thread, I thought we want to enable both PASID and
>>>>>> PRI in
>>>>>> device probe path. Did I miss something?
>>>>> PRI is different. PRI should be enabled when the first iopf-capable
>>>>> domain is attached to device or its PASID, and disabled when the last
>>>>> such domain is detached.
>>>> Right. That's what AMD driver also does (We enable it when we attach IOPF
>>>> capable domain). But looking into pci_enable_pri() :
>>>>
>>>>
>>>> 202         /*
>>>> 203          * VFs must not implement the PRI Capability.  If their PF
>>>> 204          * implements PRI, it is shared by the VFs, so if the PF PRI is
>>>> 205          * enabled, it is also enabled for the VF.
>>>> 206          */
>>>> 207         if (pdev->is_virtfn) {
>>>> 208                 if (pci_physfn(pdev)->pri_enabled)
>>>> 209                         return 0;
>>>> 210                 return -EINVAL;
>>>> 211         }
>>>> 212
>>>>
>>>>
>>>> If we try to enable PRI for VF without first enabling it in PF it will fail
>>>> right?
>>>>
>>>> Now if PF is attached to non-IOPF capable domain (like in AMD case attaching to
>>>> domain with V1 page table) and we try to attach VF to IOPF capable domain  (say
>>>> AMD v2 page table -OR- nested domain) it will fail right?
>>> Yeah! So, the iommu driver should basically control the PRI switch on
>>> the PF whenever someone wants to use it on a VF.
>> PRI enable sounds like PASID enable to me.
>>
>> The ATS control is per VF/PF, and PRI does nothing unless ATS returns
>> a non-present indication.
>>
>> Like PASID, it seems the purpose of PRI caps is to negotiate if the
>> CPU can process PRI TLPs globally.
>>
>> So, I'd guess that just like PASID we should turn it on at PF probe
>> time if the IOMMU can globall handle PRI.
>>
>> Enabling ATS will cause PRI TLPs to be sent.
>>
>> Probably more of this code should be lifted out of the iommu drivers..
> 
> Some architectures, including VT-d non-scalable mode, doesn't support
> ATS translation and translated requests when it is working in the
> IDENTITY domain mode. In that case, probably PCI ATS still need to be
> disabled when such domain is attached and re-enabled when the domain is
> detached.

Does it make sense to move both PASID/PRI enablement to probe() path? something
like below :

[I am assuming ops->dev_enable_feat() interface is going away]

  - Enable device side PASID/PRI during ops->probe_device()
  - In device attach path (ops->attach_dev()), depending on IOMMU, device and
domain capability configure the features like PASID, IOPF and ATS. That means
ATS enablement is still done at attach device path.


-Vasant

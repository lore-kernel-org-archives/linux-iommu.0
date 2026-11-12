Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794486828;
	b=lWIj+ret6cmWehsZiUUBM3qYm04ThxPYkFRUd4OY/b+6COp+kiPJPNPyEYEtlwnNhGTn
	 NbpYl9dD7uiViLmK+ZV7Hwb5+s6j34y6h737qwftYC3Z1X1mbTgHlvIDMNbWGjKgGJ2GG
	 pBcVvI+Vp21SRA6vp7IgU+4soOeRKKBMHzgwIryLfEFLLKcbsNbWVN8J6vKHOHYZhEwpH
	 o7lwxovvw1T3c+F7f0XwWJC4X1IyZ7LBIeucV6mc6MUb0y7iCW5+izmerUYqWSg91hlAu
	 296zFcpXnrxtp+k5Nrjr/SiBGSj1nVSFGQnwsIoNWlguykVkOGX5nu8Da8Y3+AauBuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486828;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=gm6G8qOMBCn9DGPHqPWa03ctOgvvct9LkuAM3z+ok0g=;
	b=DmfvCjl+EhMID+AKAxBQ5x2bJYMu6Z/vI2kce1VdINkVp2h7TN60yO+RdirtSqqDUmDC
	 kMgKJM87yRHULMuA5/fDmveoLo/KaUmgvelQCErt7ZVbyfg7HsAKDxqqEqmAUIMJGX/2U
	 UbWX9wCe4tZ2QmDrD9yJgDc+KxCqdUDlJqO0dFz6HwKfeMl0lVtch0bL4E86QXassFsSg
	 1ZxpfHc2WGEuzoYoud7MUCT86phpiPYsoOP8SB7K0P1XxZ4tgcYIACyojcS17RSczu0qC
	 B/M6uIlQa6YdRelDTk3wPcSC3UGCD5547wRGz+QKMBVzbcyiw22bbUzMZauEY75VBAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CeHvbDCE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.3
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67665606A31C
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 12:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67665606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CeHvbDCE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHISGRCplz9TNQUUT5z0ZnaZ3iEz/cpZpgsPdNUkOmEVpwdohsLwgwnLLMe17l9O/XTBDLqKMQev9H4618at2GjPwfsCcBQYsSN5DVuNnkLpW+Lxs9ALDncYRvsQdyfWARXKP3fWafszbesfSxno8ipcJRJcr+4vnRTEUmZdXYYOZ+oQIO86E9JkNSM9cynL6iRHqV0F1x1joNs0pl5oooDKV8L+f7w6cL30Nid7l4QLIMUqKtceGT/rYDDQaMJqfxbDpqq3e5kYOko5u6ozaxuLNjUI/Vm76GShlb+Q6brM9HFlnCmFV88bt2jrhFbB1Bh8K4rJgm1TagR5X7xzjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gm6G8qOMBCn9DGPHqPWa03ctOgvvct9LkuAM3z+ok0g=;
 b=Jtq/44blSWn66Fu8K1GY+m85r7tspzk6P1k/XFbibwWQsdmUGJiovIeQbp/v+oleKHk+ho4Ap7wBXLS3Grg4FuWlG6EICIWiSXdgT/4jx1hdT2oIHYtWEfbHxskryF6MYn5iMbMbLjH4toLvm7eE8huiaL9rBa68gGo0trnrgLc0A8D6t3WGXrdOjhFvud9/fYEejU1G9K90aDA1Yq2LzdoBKPjQzHyN74PYJn6o0XF8CNS29AJbEgn0JXSBweSlxBrAP7hlhjhNSRLBUCzvuTd/j/1zEfMTSjVIYnR1IkOOuUMJie79oI1TKAPI1voxK3qnWyI8dwMOH6OIUfC/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm6G8qOMBCn9DGPHqPWa03ctOgvvct9LkuAM3z+ok0g=;
 b=CeHvbDCEd9Evig/88FzbPJctwYDxkE+aCEivCc6i9JQP3wd4iDbC8leNDKdwll9ReSObrqfi1LdomDiwNBHVEwHrO1xiBtvuLBOba4DNLsn7Bti2DL/qwFjpIv3xMbtTNFBA5PHWudZkDOhn9czKpf7CmpqYa+lpv1JSV/XHXdyaos38O83oKweEeK3r2bZJZy2DS2NHQeNPEtf3kyEesMcTf94WMDDZkVKuKjk7w8c9xfPgRQF9ED6aiK9SmwOhSPYWB+g54vXKSS98D+rGx80B+3ou3xCj77GFU9piJQDqq5GidxQmLWH+JS/0yMYj6PNPrwTd6VhDt9+QIbhIPw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15) by BY1PR12MB8445.namprd12.prod.outlook.com
 (2603:10b6:a03:523::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 12:32:25 +0000
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f]) by IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 12:32:24 +0000
Message-ID: <88bb6c10-1bba-4951-a09e-50ea4642de7d@nvidia.com>
Date: Thu, 12 Nov 2026 14:32:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] eth: mlx4: use dma_alloc_coherent_node()
To: Jakub Kicinski <kuba@kernel.org>, robin.murphy@arm.com,
 m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20261106184433.761422-1-kuba@kernel.org>
 <20261106184433.761422-12-kuba@kernel.org>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20261106184433.761422-12-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB932075:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c421d0-1863-4ac2-a352-08df40b90169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|56012099006|4143699003|10067099003|11063799006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	41EgRO/vdqcUrnJEI+JjlkJPvEdR9WoU66im1IQeboqJr9PcQUOKd4OXX6Ge3u4ealu9fKRmZ44HQCNmimjebCA4rKWfKh+Td4RNkHuP7qxEs+qtKFg6v7G9o+MADODtkiLRyuZWn90LxA1JwJfa3OMsrk0jpH6D3abGb+yw4RoBue8IRPVHx4vjEB8keVNaPQBgzHWEAR/TggG68nQ7wSkExqYE0H2nEtXsPDhWc+GGpLzhKMWy85s1LA5KDLkOQt7xmXD6JXRiPPnKAHcpQyN2s86pf8iRN/pxglDnQ2MZ8yig/ROTqPybZ7x34WeYXhOf+FrK0zGsOaGVhM7AyfjTbPUPvkFIbstOO3ssLWH9sQfEFhYOuYs7WtpWLjWvMqFpvX431o8QWatlG1amrshbK84qOhtQnp8kcH839PQAwzs7ejTBzYugA5iE5b6b2oN2sgx02aJ4PXzXflMmX9wjT+mkcjRt3jMxfZgd6z9TXpcic8doXUtTSY+e+Gn9r0h3Sw6fy0IKIRzKInZGRGTEGHyld8esI7cY6p0TLDSsbML93u3Y0Ly8pvJwzQPzWfvszk4EVxZU5XjUxDqd7+tcQLbaK34VBza4fBsem9Ze7yZ/8NnbK2Y51CRQPitTRdL5tW/g8Ex20vkmEVeLWm+SShR4WsW4clTQy6NNIIA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB932075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1FSdVZ3NFpPYWFXRzJ1UnR3VmVQM3kzR1NXbmdtQ2FpRytmelF0N0dPRURS?=
 =?utf-8?B?bk1nZ2dENVArS3dzWlFDajNOV2hqQjZ1R0hHR2g3Q1ppTHlCMUxHczZtK25v?=
 =?utf-8?B?NzFrZ3dVc29JTE5ZbmxRVFhhc2IwUWZMWjlpa2JvT2cvWkcvWnhyeUo2eVdi?=
 =?utf-8?B?YnZ5d1lzQ0M3RzVDVFdsV2RGVDc0d1l4Mzg3Y0lRQnA4eFJXbHFBZ3B6Y05m?=
 =?utf-8?B?SWdTU2dsa2YwZFNWRWQrWWRmdXpHQnRsUldQMW16NUNPRnJoUTh0OGVXa2h4?=
 =?utf-8?B?RHhLc1hlYWZYZnZ1YTV2RFU0VzNZWjNoUGJ1UzMxTzZ2bXBLL3BGNWNQbExH?=
 =?utf-8?B?Y0pDQXZpM3h6MVM2dGZxdlhSd2cyNytnYnNxeHlQeUI3WFF5ek4vemhTb1Nx?=
 =?utf-8?B?Z3dkaUlEQ1Z3TTlZbHRBY2xVUlJHTmoxWm5NU1pBOVlJNFBrNVE1allzcm1h?=
 =?utf-8?B?cktudHZ3Qi9KQjBXd3ZMSGp0UlRQTzdOc3pNVE12NmJiMndGVmJ4cVg3SnBz?=
 =?utf-8?B?Nk0vNzFpVGVtRVhTMzU5SzJJQnZpMGk3NWIvcnk3UjdXdmJYcSszd1gzSjM4?=
 =?utf-8?B?Ryt6d3o2RFdrNWRVbm8zU2VhbWF6QnVoZ3JvMGp2d0U1QnhEaXBUait4S2d6?=
 =?utf-8?B?MjBCMTdrWDM4YzBjTTU4eU1YNmxONXhoQzRwbE9BczFJTkxEY0lhT1Y1bmFB?=
 =?utf-8?B?OFYvSWlTVDVzTzdiQ0VZbkhRcEZsUko3dklPKzljQVBqdTNmeDBIQytYbFlQ?=
 =?utf-8?B?QUJ5ckJ4a0VzZE96cUlsMUloeXFtWFpNcDdOOTVJSXZlQUJSSDNNU3MzeVdn?=
 =?utf-8?B?QXdkNWZXam9sM050MWdaYkl3MDdBbFhEdmx3SkNLSVUzU1hQSGdQeXBJRzlT?=
 =?utf-8?B?ZzFtcGFaUDlTdnhDWUNYdDg0RzM0MjlrTWtTNGhXcVlYZi9TNzFIMFo2dHNu?=
 =?utf-8?B?Nk1VUWtyUkRkYmdHSzVDb3Q2WDhDbTN1ZkJDTUZYQmIrR2Y0aFlZdmRpQjda?=
 =?utf-8?B?cU9BcmM4SldRL3J2eURSVEN0aVQyS21HNnpUU29rUXlDdXREOW8zellWaGtj?=
 =?utf-8?B?cFBBbE9mQ3pzZUdjUmk4SFUvd2g0Ym5ReW9OakdMVVVCb0d2NVY1R2MzYUhY?=
 =?utf-8?B?TVRHaHFUOExZVXNJQ2MxRFhucCt0T2o5a1pYdzhUZEZCQjF1MjBxSWdWR1dY?=
 =?utf-8?B?TUJ3bkNwUXZqaFZvd044SlVZVDFWcGV5SGtPQ1FUZDVzVTBjd1Q2N1N4VHVj?=
 =?utf-8?B?cmxkL2dDREI2dGJNYmhNMzgvMzBDRkFxYitCWStPemZBMjlVMmFRckJFdkVH?=
 =?utf-8?B?elprNTdYVUdLZytINEJEaVR5M21XZlE3b1k1OWMzUE5pSi9XSUFOWjFpTDZX?=
 =?utf-8?B?a1JxeVdhTFFsL01zNTMyVjdFOG5uN1R4TmttTzBqcUtYRjhFb1VMN3dTa0VH?=
 =?utf-8?B?VEhQOS9BdWgvSllTcVF5dFF3M2JyTlZvUzQ3blQ4MjhMQXhrSm95OE16Qndk?=
 =?utf-8?B?VGJUZTZwM2ZOSFB1bFI3VXRyUVJxdEZKa1ZybFdQMHZKNlpTWFBBKzRRZk9j?=
 =?utf-8?B?Q08xd1JRUVQybEMzbTJJZzhVV3cyMGEwMVdzc0xMbzZ0VnB5eEtmYUMzWWQ0?=
 =?utf-8?B?cVdZNkdDRThZQVh3T1ZpZ0diYTBDbXVEcnFJOWVXTGxRSUdld3RNbzI2S1Ar?=
 =?utf-8?B?UE5sak4xOGwvRndoUnJmRFRaNnhoRVJpUG9iS0VqOVQxTHpIME1uL3diOGpx?=
 =?utf-8?B?dXIyNHZVdFBQcmZUb003MERCNWxSdTZxSlpMNWVWVDc3NnRKYm9oUXYrODlF?=
 =?utf-8?B?U2RRZ2VGUm1EcGpCWDMzYTZmQXVMMUhiVFVIdXBlSmxwZTN1U0lyWjRVRlho?=
 =?utf-8?B?a2tjVGxYeUQ4ZlRWZ2hvWDhEb1F4SU44UWJUYmY2UVd1cTJkWnplQkQ5REFs?=
 =?utf-8?B?dDNNQ1N2Ymh6bUR3K2Y2eUN6dVd5MkE2V1d0VWswT05LcmJPZWQyU2J2RjZW?=
 =?utf-8?B?aEtLWmRyVm8xYit6dXM2SjR5UExFQXlCdkFlMGpuYlFvaGhSUzlWNFJ3YkpD?=
 =?utf-8?B?KzIvUnlsQTBYaXR6alF5endvZXo4d0lDVHJ2dXBVWEtRRVB0UUxVZmRpaUhN?=
 =?utf-8?B?SzQrUzFhL1FDQVZlNmloaHR5K2pYMWIrMWJocnJkV291aXYvNGoyMEUzVHBp?=
 =?utf-8?B?MFhiR0RyVHFnWkk3SUZ0bnQ0RStFN1JOMDgyZys4OW9GTStMb1gzc2ROZkhr?=
 =?utf-8?B?OXY1Ykd5YjNzbXlLV1NvT01wVEVSdmJhUEhoUERUSUlNSU4rOGtINCtOdkpQ?=
 =?utf-8?B?clJOSU05aEJPVWF6SGxJbVFMTkY1Y3A3aFJGbkZGMVlxaGZiSmFMZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c421d0-1863-4ac2-a352-08df40b90169
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB932075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:32:24.8426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fepAX+WXDjCGbUB7GkHuZr9ywrST6aJBsMlD2D3QA7eclf+/fddFOc/XXelH22xsfQwHs4uicJZFh0jYcyA7Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445



On 06/11/2026 20:44, Jakub Kicinski wrote:
> mlx4_en temporarily changes the node of the device around
> mlx4_alloc_hwq_res() to place the queue buffers on the queue's node.
> This is racy against other users of the device's node, e.g. mlx4_ib
> allocating its own buffers at the same time.
> 
> Add a node argument to mlx4_alloc_hwq_res() and use
> dma_alloc_coherent_node() for the queue buffer. mlx4_buf_alloc()
> and the en_netdev page keep using the device's node.
> 
> The comment about the MTT allocation was stale, the MTT ICM is not
> coherent and uses mlx4_dev->numa_node, which set_dev_node() did not
> affect.
> 
> The doorbell record pages, which mlx4_db_alloc() allocates on demand
> and shares between all queues, now always come from the device's node.
> So far they ended up on the node of whichever queue happened to need
> a new page.
> 
> Reviewed-by: Björn Töpel <bjorn@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Tariq Toukan <tariqt@nvidia.com>


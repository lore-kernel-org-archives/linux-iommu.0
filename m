Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78144746B8
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808026; cv=fail; b=EerrucJVZdeOjPXIqwlngEmnbNmCo/tdXapNFcawDQlR7ipdNv3cgJdpM91BNP5Qfge5yX9nHp9d+KYJFNpG2CnMRG0fjixpIUIEPrMdoaX1M02iiuWyQx90wjzwLiv8GjVuNqeDu8vRh/mHmef8ijSCI5+T+VOTKf9MtS4V4lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808026; c=relaxed/simple;
	bh=2PoE/0ZQlkfAQWZT+Jx3LgwAxY921Y6Fq7ABW+D7ZRw=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=RmQqC5DxaWtHZ495GvdERqRHEoAlJcZZBr+9kWVtnbmqZkcTcQ/uTqMAO/PrGU/joXqA44R2csmimVckGGy+vkrgAljZna/gfCzS9UznrWJpB5QUS0aH2S93FIc6kPP6CWWw66H/JB6OjhtqzrkfUBogaakm2DbKOOkbGfNZ9sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i0wRPb5X; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i0wRPb5X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVohkEupu4MbrQKOXFybUV1nSD9dmwIPGto0se5CXh0RcwP48S7nTTxzfq0HyBKTxJwfKTbnNUEXTeRp3XZr/KitAr9c0GUbkrWcwEdghznARCt+coNDEcLeTQdvPaCqNLyeIvXV3Ris8T5wdtW2XgCl2uNdr1ua2qnzA2It0wYYYbBymS6o8DajMp14NYg6oJso4etzsClhat5p3wcT/V1x0C0Wvufvc/V0sVFBaCh69oMNKoojsdv0JPsqza7rxAOTlmmDF+WGXYzaWf/L43ERygnt1Eov/KKijvy06dC1/EqKM3q8MQBAjIvkhEeGsItCSAK38bz7FKnynOH3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zzii6NN2bgAlDsYfHFFBLcvVpWypHxplFpU4Ez8DiYE=;
 b=IowZqjXskNibiIcHBI0EpzSYWJLA9hYMGUg9Krng4DP7Us2MXBAHd/dqRcw+q5LNPEThbf+pim+KbNi1MmBNVl2JM7U0el/7cNd5Kx4RCeWD5mLk++635AfLgl6B2IX7s6XyIfnRioR6dfLXVIwnqp0uTViiQi1xt1fXGNT9kme2whbH8e4TZeOelucjdWqeAtZgq2gCxgp1l4S/fYGGJ/QJUXdDqbh/xURRMp2ji/W6TSp6G6/rXXVWNYurfJ5h0bB/GKIo9NJEMyyEJEkg5BjPbGKkageOy5k3ZZu4ggFuHJujDzI1sWPTCXLYGbwCfUH51DtCCmY8r3RHfd/sMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zzii6NN2bgAlDsYfHFFBLcvVpWypHxplFpU4Ez8DiYE=;
 b=i0wRPb5XILr2BjcpzYJ16nB6QQ9BTHIQde4idDh0MeRuGqWFjUkWPi7zDPxTQa+aFtPlQAhopJDn9xvqgJ9DMiRSJcO9S7tHT7yaAY3eMFv15iU1yXprL/o2q8MRq85FkyquvyAOD6gbGDzOYJvVBkblUEM8F+dYB4C5m00ThZ+cOp6FkW6UStvugC1qBRwLhrnP467bNUV3H3iMUsSzmNIIU8rLLXev9CgPOvo737UmFO46nSAxL1GMuBJLJP2nqCZcpmfAgiyRlPmdJ0+Pgxmv9grvjecKkU4SAn/h+C0911W0zbRgjXkp4iUbhEW7mD2DLg5zfW3/HWuM8YEMfQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB6603.namprd12.prod.outlook.com
 (2603:10b6:208:3a1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 22:40:20 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.024; Wed, 30 Sep 2026
 22:40:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] iommu/amd: Make PerfOpt compulsory
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, 
 Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Vasant Hegde <vasant.hegde@amd.com>, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
In-Reply-To: <20260930162401.273907-1-superm1@kernel.org>
References: <20260930162401.273907-1-superm1@kernel.org>
Date: Wed, 30 Sep 2026 19:40:17 -0300
Message-Id: <179080801733.122959.2048638492948411360.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: DS7PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:8:2f::24) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: d06c4a42-226f-4aa5-0231-08df1f43cebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	sZAANpM5SxpH2Jfgz2CLEkkEa9eRYmzrG4hPZYDMcI/PAe55L+FVTQAjkpeVzI9DDrIg0zQ/jjRS+VbkAiJqgCnBpAnt7IKKBYcR6fnaRboS5lLp2yXZ17FjdiKCFxWk6SIq4bIz1dwqteB8SI23uduiSd6Ft3oaBwxEVSYA2OboCfMkQZpcOckXEEPpHFkbNly5q3i+is3mso4I7iJUwyXPEQGtGedXSAuF7ipPT5c4Yb4MZsktMevuysJORYCbLQsbwPERwlHIP89YcxNbHo0bf2Q/kifhLG5PKiS/2t1udbrGdUzJhSAJ5HD6PrLgDxLGstoGo4p3PZ8kz0lcO0z/Xk0IaH+qavDlflMNiejYHjwaANYgaiqoL2hbqmC/GdnWpb49iwWycIHzRI54pIroHLoV1hVOdkfjasi4T/dG/OQYqyOIH85ktKjwSm37gnDjeVCdE0i9CrvP2PjOeayu+mUrfNaBmasucxdykGS38YSjyL1MtNvU/wmBg1A9GTUvKyyokOnfLpHMPofIracqpcjzyvKuzNYYdOw0+L2BRwKKYedOCmpngEQyalYhJ2EjwHU2krP0xKdTqf7v8ulDQzFo68Gp1EnHYeF1rfpAQ9oHEyZRsju5V/+WFoeBFYUztYpGS5MUh2xgBb8Cg/Y3AhcPnL0e2vmVUeJO/og=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NExwcnVQRDlIRlRZTjBNWjZmYzY4VWJmbVFobTZBbXFCVHl2NEEvZjh2UFhv?=
 =?utf-8?B?emdxN05tN0xsSVFUWkppd1NpcExtQXJKOWdSUmVHaW8xRnV2U1dBVHUwY2t3?=
 =?utf-8?B?U2RleEpVZFpIVE53Ni8xa3VLRlJXYkhld0xCSzgwc0NsWmlHdGZiVEV1RkNG?=
 =?utf-8?B?WGJhS1h1MzNobW1qRWQvcGJRMW5lWmlKeUl4bkhZRDFIajVxRFM1MkE2QlRo?=
 =?utf-8?B?OWIzUlhIVnoyejBzeEowOEpON3BFcC90VG55ZlMxUDA4TWJ6dW9ycXFCSVR2?=
 =?utf-8?B?MlFYU2s1QXRmWlBvWVUwQ0xwM2drdTQvZk9IT0p1UFBHcUxQOENIem5mTTNv?=
 =?utf-8?B?MUxXdWRWeG5XUTlsSVdxcEJUTHk0WFJxY1c5Vkl4WFF3YXlqOE1SaFNpbFV0?=
 =?utf-8?B?dVd6Yk9UL3pOMFVDVTlSbjlzRTk5SCtuUDNubDltVTRlSThoaWh6MytrVEUw?=
 =?utf-8?B?RDN0SFlPelFSTXUzTnkxVnBJb1ZOUHdqeVp2SHNaT0dyRTMrRFVMRmFGN1Ji?=
 =?utf-8?B?V29CMW1uUDVEb1Z4QWg2OXc4R0U3ajZ4MTI2RkhkdmhjcUs2TnR1eVpEdUps?=
 =?utf-8?B?bGpVRkxpNlByMkhkWUN0VUZrSlJFN3RWYkx2YXhKN1pSZGJCYkFuSjhSNjFO?=
 =?utf-8?B?VXFrUEVVMzI5RTRveTBWcUkvOUpoV2tTK3RVcjh3WVNSdTFpeGpPVGkyMXlO?=
 =?utf-8?B?ejltRW1VeVkwck93U3pENmxlNGZNRVVienFDdHBwbWhoYlpoV0Z6WEVnV1Qv?=
 =?utf-8?B?SkdPQWZQMVdTdTFHK3hIQ2JSNGo1QndndGdyeC80MjM1b2NMNnBOb2kwRFVl?=
 =?utf-8?B?SVRHOHMrQTY3Rmk2ZnNReUMrQVhkZDB4QnMrSkY0dmp2bW9HUnkrOWFqUkJY?=
 =?utf-8?B?aEdmdUtLbzVJMS96Yk43NDhjMXI3dWllN3JuRXpkZU5wOVhaejNoTk1IR0d1?=
 =?utf-8?B?ZVQrZUR6QmNRMGVvb2FjMmJRZi9KTFN1RnF1bUlPeUkwSk9wRzBUaGFaWWFV?=
 =?utf-8?B?YlJBS0hYRVI3QmhKSmxFR1ZWdUpWVHNRSFd5cVdBTU5UVHFzMkllSldKOHdZ?=
 =?utf-8?B?b3NJNVZTbGdsUE1nV29NekdhOGV0SWExb0toaVkrTVpzSWNSVVhZT3NPTFA0?=
 =?utf-8?B?aUtkczBwSFdiTm9ubm9xRnBPTlhFVDR1VlJEVU5oSGhWbm5mRkNuV2RZc2Fo?=
 =?utf-8?B?TmlDQWZScGxab2d4d00vN2JLZDArT0lKTWV6REs3SnR5eE41TkI5ZDJwdTMr?=
 =?utf-8?B?eURJdEEwZDdPNVB5Vkg3YXlHSlBKSkwwejUrWkxyZnUyWm0wUE5INGhJSDAy?=
 =?utf-8?B?YnVtSEFPYUlqK1A4ak1ONzBlcVJKMFM5dytsbFU3L2VKZGREWTlwSDIyWVdP?=
 =?utf-8?B?OStFYnJvV1l2YjFPUFE0Ym9kTkgzQnR1L29IWitBRVpWcVNPMEU3eG1KVWRu?=
 =?utf-8?B?UnBGUHFnb2pnMkgzQVBLUWxMRHR3SlRPVnlacGNhUThXeGt1Z2hxY1BhMjRD?=
 =?utf-8?B?bWlnYzhiTDJzSjJOa1h0MXhybkNRU3pXWVkzLzJiQWJEWDFMVGdoVFlCQTR0?=
 =?utf-8?B?N29tNmtQQjIvWHhYNnBGdzJuVTFwOGhqRjFTaEtQcEEwSDZ4aHlTVmJSNkdB?=
 =?utf-8?B?Zk82eEZhUnlQR09ReUJqL3U3OE5FSGpEOUZLQ05qWWhtRk5sOEwvdHlLTFpE?=
 =?utf-8?B?U2tNc1N5aG5rWmFSMzRHclZ6ejlDc1p1bHplVVRNT1AxNlZiSGUvem5Ka3Qy?=
 =?utf-8?B?b2dWOHNhamM5RnAwNmVFdFZDTDg3cHZDYk1uOHA3OEhDUThtQnlGZWVPUWpt?=
 =?utf-8?B?Z3FLNit0UTFva2FCVGlzSENHOVVxdnNpLzZRVHk0b0VyT1lKZWNnc1NtRm9E?=
 =?utf-8?B?ZWVSVVlZVHpoK1ZFbWFEY3hQWFJaME9wOXBGS3pGclRQZ2hlbkFPNndramRl?=
 =?utf-8?B?d1VSN3BqeEZuWEF0SGhCY3NkR21YZTZSS1J5RDdtRnlHNGZzYjZUeDh3UVJZ?=
 =?utf-8?B?MWJlR0RCaXgvZjNubnJlK3hWMWs4SHlCUWNPWVRhQUJXdEZac3Z4MDdHV09q?=
 =?utf-8?B?SGpNYUpkdnB4cWJzbGlDQzhWUUx5YTBiZkMvVTAyVGNoR01YSk1PNmtVQmh1?=
 =?utf-8?B?aFljcVI2RlFyTHRpZHVGdVpScS9FU0dXRUVMT2kxRDJLc25qVnBQcEhjL2g3?=
 =?utf-8?B?RU4yTHhYeCtERGpyNG5xbnNNSE1jSVNpS21qN3NWZDVjUkplQURTM29OSUlp?=
 =?utf-8?B?NDlKRk9qWHozMWlSeXI1MDVkeE5hdzF6R2xKNFZ6bUZ5YWxxR1haa3ZLS1hU?=
 =?utf-8?Q?rKfZHlNnKF1Tm5E22e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06c4a42-226f-4aa5-0231-08df1f43cebe
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:40:20.3712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acP4/noPgBQi84yvAgrf67qrciWhExtATXXwq35Opkycz2nWwf7rct7Kv2JKkaeo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603

> [ ... 336 lines skipped ... ]
> @@ -2370,7 +2370,7 @@ static int attach_device(struct device *dev,
>  	if (ret)
>  		goto out;
>  
> -	if (dev_data->perfopt)
> +	if (dev_data->perfopt && pdom_is_in_pt_mode(domain))
>  		goto skip_caps;

This should also disable PASID support since without a gcr3 table
that's broken. Set the max_pasid to zero during probe device.

The flow is weird like this because the driver still hasn't cleaned up
the identity/blocking domain flows. There is no need to track them in
lists and things because they never need invalidation..

This is much nicer if the above could be written in side
amd_iommu_identity_attach().

Also, I'm a little confused, I thought this had to be toggled on and
off so it is only set while in identity, how does the DTE influence
what happens when in this special mode? I was sort of expecting it was
ignored entirely in HW. This version seems to lock it to always on,
but still permits a blocking domain to attach.

-- 
Jason

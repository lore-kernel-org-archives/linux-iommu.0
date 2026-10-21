Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792560435;
	b=k8EfiO78OKevmNyih45c4ajtGESdp1Q2bP88GBKFIB3JNCG3vbc7eHOfSqY1GqS8uv1a
	 OVN6dOymXOZ/fCJVakBIfX49aJ/FUmNRYxpgrYsXqIJWg760Scwu4SeXMUz1GAIwAyAgm
	 O5wXxxlIofIXBzbAM0q5alPadrcluWMIJtQ5N/CXmoSgIa2yAhz5eSl/yXeqB0RJBbWPW
	 2Ia6xQyu88SnRAxf7BtdVNkIFYqosYOt1gPZ2lJVd7sUP8ftsuxbniYhsITS/qK54XyzW
	 ZEN4MhqtoVFMb3W4ujACsCB41RSLpTJsrw3Kp2Tu68PwDifMeNzR33I3x5lK1RX+V4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560435;
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
	bh=X2v/RK+fx3mAr2/JC5HqE04FKSypBbXkcxT3n25pC3Y=;
	b=OPdvkE2Ifn2YKl3xb7q5rp0BrPQmKmHknUiBzG5IIyeQQXZpXkaL5FWX/JPhSJdNLSUY
	 9ePkBrngCK1SOuipKoLnEnkhBdakGTaPXtJMlkTM1f3I27VnMOpAV6Gag9udWe7nHyT9+
	 HXL77+ERVQ3oLryjRiZwMM0TWu436+26BQ3gts/VcneIpI4nDnquvMqIoFLbW48peOqE1
	 f1ymrOX+xIga933FFYp5bJEkAGDWJW8gVMKpES+vODZbgs/0ttO9Fv8apsSO/GvYeS5s0
	 16VexDc7u6YSdp3QNolDbV1v6OfUju0hI87ciA+wuMnIoJ+KnKjliKT9TOlQ9eBZh1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TqnzfcD6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.1
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A09606A31C
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 05:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1A09606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TqnzfcD6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqtXGQPCJnwJsAQr655vjklkVhnyUeAZdQk3W2d2MZB7VK/PNALuTrCkWfhthsLK99yhUX6n8PPsfWmjaEp6kndqIXln3zbcaNnlkDScPk+TFxDI5nRqH9sYwz5hvM9bNBoQtSF/BDA009I0D50rsB3n1fXoN5xC+Bm0ZCNnlNYfAee8OYfJiSolFVnau4JZCLohixNEnMlriq5vATKFv4bsa0wLSQFy3spTcUp0159FjzRCLnCRULbH0Euohn6Xb9UcrRg5BCCV94BCnxZj2xucR/Am0l43ZbcwF5ExCH+YR1EiM1LTkPhNmaqniiKsaT5dZTo7pU4x5NdSrJKDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2v/RK+fx3mAr2/JC5HqE04FKSypBbXkcxT3n25pC3Y=;
 b=cVCzur4gLLQLzV+sGvc1kAdaDDGiEKnziBoFvb+P/PKmuzV9KStnlh8R+GKVOlB9KjxnnWWEYTFUFb96gnKogs3yekRSKyNnjRxn2+akS+IQ/JIEJdK3GI3sMx1XBnRyTnm25d0pugf+oZJigh0d+9I497ErI1k/7U7zLe2XplIlOxIaMAiLrUSQa9pxQxGSPCo+Ea190EXr+JVJI5+oBuhJTaV0AovhlgVBPAURCb7rfDlbqptfaS2udqDM72BmgwA+uBuuYqg7ggmc7O2ZMlg8UWVDNu0n68XFc+0fnBV9RZ2B2MRxhNgse3Bn58UrkXrqOqcQWs20n4yVUt5Sow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2v/RK+fx3mAr2/JC5HqE04FKSypBbXkcxT3n25pC3Y=;
 b=TqnzfcD6+VWmDteGWHqVOhd6pf8wZsk9pkFc1YIGuaOL5EEgt3hlCe5r0dS9xrRS/1EOqY4Q/I4NBOEEfkn1pfw3rggwzAOHDdYUFRaheJroU0hNQZ6ttHQ1M3IQsHmO7mAaBn8AS5hNbT34FZg6Ae18AIqLvnqPRkL0A+/DSPA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 05:27:06 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 05:27:00 +0000
Message-ID: <f76898a6-393f-4e3f-a15a-af2d6fb846aa@amd.com>
Date: Wed, 21 Oct 2026 10:56:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/24] iommu/amd: Program nested DTE and DomID map on
 attach
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org,
 wvw@google.com, wnliu@google.com, dantuluris@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com,
 guanghuifeng@linux.alibaba.com
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-18-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260930092344.5616-18-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::15) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: c86d617f-9eda-4510-7158-08df2f33eea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kIMJ22k+YMXx+N7lsszXjTW6udKm3ERQwbXc1TBWLGlVzI8mVBzKB2Z8i073p11509uzChdczBcFNp/LdDxYlGHFNoMusgyc78yxyQP+yfdUsuKwngujQXlqjz5HIsAWBmAFQNlCHbdtCqow66u74fNp/09Mru9+Ub/AjYlPIQ4QyTDw09K+HrDzDrBfaAhjbtO4ZE14W8mgTGYcscBauob85cRu629Diy02uESJ/97yix5tEkgy/gNA3mk9byrpPRB8vPDSTGVsuKeyjdg3pXE0np9zFTvX7UPLLUdPivCa3aTKUhbDGqY1JIwyhkE7AH5Z2YmFmwslUAtsLjcI3MvI0Y0zL4I70kfErfvcbPsTGRvhoPa3DRv6YIhDIYMZ06M2EuM6R48SnSEJMp+mvhW3iE0h8vTqmIFyeamsFKOnhZiMxrfEcs4o4GCzROTRb0+C5IMqOMZ2g5lkQrOFDVnQ9ZzJVGNbgI2b/TheOZ2U+dlFhKUWTfv98FvxS5lG3L5rYKt6/rLtMmi6oWBQZ02O1gTNPz5RUqcPAZoC03f9gwYjXMZZpmm4NOckvh4dniLIZVGK+mtAOpERnmnADeR69CfN+DidGUEugETDVhzILUc/m8X9ppg+5DhQ0O+mgi1D0wHQ/i4fn19T1XWTOCsvqd1brg/H15BM0UxJAbo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0d6Z1NLQTZBdDZRUEUrWmVudnRaeXc4ZHY1VitmdW11YzBtcVZQYmJtZEd6?=
 =?utf-8?B?WS91dFdhNGRqbjY1cjJDek9Dc1BCRFg4WWVCOXl0YUZHWUdsc0RWeWZORUdv?=
 =?utf-8?B?ZWFYT3ZoL1hicVAxcEJJRjU4REN6OUdPd243eXg0Rk13dklxQVRWckZyN0NG?=
 =?utf-8?B?dk5abjFTa0hXZmZYOUUwWXNVYVdnakhWRGVNaHBBQzJwajIwOTlxOTlkcjh2?=
 =?utf-8?B?eGZISCtEbnM5TERBbzUxQXlFdXVvR0o0R0liNTBhbDcrN3hSQzZtQlUzamlw?=
 =?utf-8?B?RFMvNTRsQ0pBelZjUlkvK1phOG0xd3dmRy9jdzF1SjB3aVZnSXdyS08xYzhj?=
 =?utf-8?B?RmtDQlhmcTBxaVB1cjU2NEtQQVhMTjFWcnRSTlc0WkNuOGkxbWZHZjRIQjBs?=
 =?utf-8?B?QnZlTjR0QnBXdVE4ejM2V05CcEgvZXladDh4TnhvSkJpdisvRzJPNExZOTVI?=
 =?utf-8?B?enNZcFNydkVlZVlSdjVBdjJ1QlpmbkVmeStOUEMxSnZxUkZTaTBPTDQ4OGRP?=
 =?utf-8?B?WWEzaGU1MWVGTnU5UVBwRVhYR2NIeWdabmlqbU9QSGYzZjdwSFZIbDdqTnRM?=
 =?utf-8?B?VXllNWxRb2d3T25LWEs1WDdKR2YyYnU5UW4rWFI3WkdiVStubnNUemdRRGlp?=
 =?utf-8?B?UEFpTzBsTTQ5d0lDQ2szRHV1TFplZHNaTDBONFR5SEpiUTlCNkR1azNYR3U4?=
 =?utf-8?B?U1E1NDgvUS8vVktqTStHNFpRWkFSVjVhYVBtZk5KN0xJNlgxNUZUUE5KY3VT?=
 =?utf-8?B?c3VEbFd5V1ZwZkYwd2tZeXhSdG5EdldsUkNqNG5KNjhlaHJQUzgySjNvaG1E?=
 =?utf-8?B?RlBMQjYwTmU4U1pJQkRCV1RjUnVkQkJZVXkzbkhlRFZVYUw2QUcwczRQZHpa?=
 =?utf-8?B?QTVCa3dOcmxGSFJ4ZStqb2tERVpvQXM4c0E1WVJOSlR1blhQRUZMNHB5Q0Vk?=
 =?utf-8?B?aVRIaThmdzlOYTZVWDlVbkUrYlI4Q1JuVEFXOTd2YTdlYzRQU1lWbzdKSEU2?=
 =?utf-8?B?VGRqQnFSYS9KWVdvcXc5M0lYWHFsclp1V2EyV29RRUJhbEpBYXMrRHM2VGpa?=
 =?utf-8?B?SDlwRkpRZDkyaDBpYTB2UGxzelg0Y3phOVNlTjlQdS84MGRJV2EwR0twcVV6?=
 =?utf-8?B?Wm9zb2FRclhaSHZqU3k3TXFzeDJZbkVZRGtPalVrd1YzTFFoZTJBNE5Ha1Iv?=
 =?utf-8?B?MUpzUEhmSllXdHBjRkpONXQ2QXdRVkJ6bEdTMW80Z1BGSmR6TTZaeGQ4Mkdv?=
 =?utf-8?B?QkZpUEoram4rWEhTMnlDN3J2NVhuVVlNcnM3SmFWSXdFN2JqSVM1cndJWWhP?=
 =?utf-8?B?cmgyQW9Odm1yTTRKc3o4THF6VXp0SjBVUU9KOEFVVERLUlV4dDZ0M1JVZWJn?=
 =?utf-8?B?djR6NGg1T004VmJCUzUzK0pBUmgwdW1xZDc2SndVc21TemIxaFhDcEIrM2xO?=
 =?utf-8?B?ZFhqeTZBcG1kZmNZVGV4Y0lJbHVuWEdZUG5TWGpINnRiV1B6UnNDc1VjUjBD?=
 =?utf-8?B?enM3WVBKVUo3dHh4K0ZqWWxFVm5YWGgyWllxcllRYXBGWDQzTVdTY1lWZjBv?=
 =?utf-8?B?QlFhWkJwRGlxWTRVMG81UW5leTRtNHJYWm5ZeDFSQ1QwNC9MMGwrVWpqMHoz?=
 =?utf-8?B?UDRCbVE4b0tPV2Jwci9xV3BQT1Qwby9TS015a0wrM1BhWDZYOTlLNllwQnRm?=
 =?utf-8?B?MGxaeTdDR0VoclpLdHZxczFwZmxoaks4SnZrcG9xK3JkVTNJOU5JQTBoUWtm?=
 =?utf-8?B?V3FtWEdDYmhrQnl6b0JCakRYcXEwajV4aWtaV05CL25YdlFMMWUrRnovOU9q?=
 =?utf-8?B?b3Z6cU01emtlRm92aEhDWG1DRS9aUjVvUkZJdHZDMU45dm8zOWFmQ1VjOTZL?=
 =?utf-8?B?TGt3Z2NqSTViclYzNDBaZzB4WUNJY3JzMmFDdDRqa0F1dnYvV3FacHM0VGRz?=
 =?utf-8?B?U2Q1UGFDQkE5eUcxb3R3b2tIeTc0NlU4eU9zV2d5c05KZllTcSszbEZ5Tllv?=
 =?utf-8?B?VFVZUkRFMUVsb3hZZHpYMXZuemZVTmRiVnZ6NUIxZVJ3amk5eTFJWFNLRzNr?=
 =?utf-8?B?MHV5ZVFteDdYVTdNRmtieGZPbHliWUdSYnJlUUNMWk9IVWtrVmpERkNjSEF6?=
 =?utf-8?B?MGdURlNETGh5bDlVMWNSRWc4MmxaeHgvdEdOY0xYOXRvZHJYM0RIVjM2Zms5?=
 =?utf-8?B?WGhHdDQyVENXZEdpVXppdksySElJT0NZbGtFVkVBeHhJcWFLa3djbGF5bmFR?=
 =?utf-8?B?azQrdXlNUWNnRS9TdUc0dDJDYTBDb1h4YXF1VG4vR3lYZHZscTVZS05qd1FR?=
 =?utf-8?Q?V5k7FRb1/vsg+wsh75?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86d617f-9eda-4510-7158-08df2f33eea8
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:27:00.4889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShD+w52VlVP2+cBBMyGT+v3sJzuwYjuKC/xBQFekkOlXd4kGqmz3+13hgQL7M3bmaiI2a6E8jN8WGTV1oUAUNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338



On 9/30/2026 2:53 PM, Suravee Suthikulpanit wrote:
> On nested attach, the host DTE must enable vIOMMU and carry the guest
> device and guest IDs from the vDevice. Look up gdev_id with
> iommufd_viommu_get_vdev_id() and fail the attach if that lookup fails.
> 
> Program the Domain ID mapping table through VFCTRL so hardware can
> translate gdom_id to hdom_id. Write CONTROL1 before the DTE is live
> with DTE_VIOMMU_EN so guest DMA cannot resolve against the idle
> nest-parent map.
> 
> DomID CONTROL1 uses the same per-vIOMMU vfctrl_lock as DevID CONTROL0.
> Hold that lock across CONTROL1 and the DTE commit, and on last-ref
> nested_domain_free() take it before gdomid_array so idle restore
> cannot clobber a concurrent alloc+attach.
> 
> CONTROL1 WRITE uses the same doorbell as CONTROL0. Poll WRITE until
> it clears; iommu_completion_wait() does not drain the table DMA.
> 
> On the last nested_domain_free() for a gdom_id, restore the idle
> DomID map (nest parent, V=1) before returning hdom_id to the IDA.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 10 ++++
>  drivers/iommu/amd/amd_viommu.h      |  8 ++++
>  drivers/iommu/amd/nested.c          | 74 +++++++++++++++++++++++++----
>  drivers/iommu/amd/viommu.c          | 41 ++++++++++++++++
>  4 files changed, 125 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h


.../...

> diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
> index 1022ae20c170..30227a5e4bfa 100644
> --- a/drivers/iommu/amd/amd_viommu.h
> +++ b/drivers/iommu/amd/amd_viommu.h
> @@ -23,6 +23,9 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
>  
>  void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
>  
> +void amd_viommu_domain_id_update_locked(struct amd_iommu_viommu *aviommu,
> +					u16 hdom_id, u16 gdom_id);
> +
>  void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviommu,
>  				   u16 hdev_id, u16 gdev_id);
>  #else
> @@ -51,6 +54,11 @@ static inline void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviomm
>  {
>  }
>  
> +static inline void amd_viommu_domain_id_update_locked(struct amd_iommu_viommu *aviommu,
> +						      u16 hdom_id, u16 gdom_id)
> +{
> +}
> +

Do we need this ? Because this func gets called only when IOMMUFD is enabled.


>  #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
>  
>  #endif /* AMD_VIOMMU_H */
> diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
> index 8bb0d1596c6c..ecdcecdc0bb7 100644
> --- a/drivers/iommu/amd/nested.c
> +++ b/drivers/iommu/amd/nested.c
> @@ -10,6 +10,7 @@



.../...

>  }
>  
>  static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
>  				struct iommu_domain *old)
>  {
>  	struct dev_table_entry new = {0};
> +	struct nested_domain *ndom = to_ndomain(dom);
>  	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>  	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
>  	int ret = 0;
> @@ -251,10 +268,23 @@ static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
>  
>  	mutex_lock(&dev_data->mutex);
>  
> -	set_dte_nested(iommu, dom, dev_data, &new);
> +	ret = set_dte_nested(iommu, dom, dev_data, &new);
> +	if (ret)
> +		goto out_err;
>  
> +	/*
> +	 * Program gdom_id -> hdom_id before the DTE is live with
> +	 * DTE_VIOMMU_EN. Hold vfctrl_lock across both so a concurrent
> +	 * last-ref free cannot restore the idle map in between.
> +	 */
> +	mutex_lock(&ndom->viommu->vfctrl_lock);
> +	amd_viommu_domain_id_update_locked(ndom->viommu,
> +					   ndom->gdom_info->hdom_id,
> +					   ndom->gdom_id);
>  	amd_iommu_update_dte(iommu, dev_data, &new);

Shouldn't we keep update_dte outside vfctl_lock? We have dev_lock to cover dte
update.

Also as Jason commented we should probably move vfctrl update to hdom_id
allocation path.


> +	mutex_unlock(&ndom->viommu->vfctrl_lock);
>  
> +out_err:
>  	mutex_unlock(&dev_data->mutex);
>  
>  	return ret;
> @@ -267,10 +297,18 @@ static void nested_domain_free(struct iommu_domain *dom)
>  	struct nested_domain *ndom __free(kfree) = to_ndomain(dom);
>  	struct amd_iommu_viommu *aviommu = ndom->viommu;
>  
> +	/*
> +	 * vfctrl_lock then gdomid_array: keep the slot empty in the
> +	 * xarray until CONTROL1 is idle so a concurrent alloc+attach
> +	 * for this gdom_id cannot publish H2 and then lose it to this

In an ideal scenario guest/VMM will not re-use same gdom_id until control goes
from back free path right?

-Vasant


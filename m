Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792559738;
	b=hhC3P4ED6c8FFDnSKDnWyCRUKmcfvDsbI+KAhYy9hn8Djlbnm4fSuX+PKR1eZR7BXWxQ
	 2lpFeqez5HEAlviQ4zAnbLWZ31yx70pDmtOph+9U6+Zn9K99xIEyPQj3GAz7UesPh7hQG
	 SdDNVhpMG2BPW+XJsVX7Ds3w4mK50afIMK3zSMxiitvHOX9xE/POKi4IXyv0lS8pQB9B+
	 nNf0InsphGlhShKcT62+XAsQAPbC87BgVvl0fzUHMUpnqrEsQWZKEsPlBElIAAMYU9Mbp
	 elDvReoPX+hdLF/dWrOlSr/K6PHGNbdZMyuaZ4fqnPAcoZCIHLjxrWfxUFfoa/6tj7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792559738;
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
	bh=cMqa4EWosymfMi5A7g2wTyCc0UiIixlRQ9osqZM9KgI=;
	b=hEoNL1SSLSSwbrduPqRftSe7BWvOruhrZ5wud1Hs06yar2YJ7kL3CtKJXSt0bAY9Mjin
	 mvOyrOYuhKCpy9SCVAUzuAwFqV20dD+co3lDVoynccQaZj3dJzIv8rCdHEHfgGju/bSQv
	 +GkXO1SW7LEb3P9Hprz+XgzBueVoRW9KejVwUxfxvYwFV6QlCL9eg1Q8Q0KfpZ6ES1Z/Y
	 66HQUX73B8quaij3/5QpUePiH+Wwe/994sob+eE4HyxAsWOpVJMjKCcNFaVikumNLP2Jf
	 17uOeeq4gMheo3o/p9QkKw3p66tVDVi5J6PaPUIohj77ixaVuRmmv4sHkWJeE+RXaxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=A1g2Ksws;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.37
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A959E606A31B
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 05:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A959E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=A1g2Ksws
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4qtqV2qsjrKnNsdOMh3Wmxq0QSM6JNi+X/nl1g68okbCcepXTdaVRdJQdxOjZlaRDG3Yym4l6lAttiv+b4UhWxlDt+JilWDjtZL01OIOTgx/627f28wdF8y3YYecaEHnUIMULD3exyWFB7r4VDq2JCMwd5CmZ8J4q2R8b9gTY4ofZ+7ZIJBUTxcc3h9AzmpakTrsoXTOKtbRR2ztJDWVfpNNGXTVODD8xMd7etnNwMM1ElrzzqcswVhELbOPNnLugme+lEVG1ko63c9M5AKKiMcBjkDQQmxQw8gPVOKvHQX+PUwzGzYB6/9ZQHth9BP3JGCxG5oGGtiJ+gjs2FZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMqa4EWosymfMi5A7g2wTyCc0UiIixlRQ9osqZM9KgI=;
 b=j3QRGR/x+TU7j5ZTU6aV/3BtVbi367JRDxmCpR+hjY1yOeBshG+nGW0CZoMC/KdXY8V7mx4FUg5w99nYUpG2RaMKt7RWm+p97+GSunYBzYnLJmQFZVo5lf7z+Zla0UBvZc5U7IzdBKXG9WeYreHiGxuK1ua167HwVLbYU8gVqhIeMQXHkUKKTtt7VJHpn9xZYOdMh5jZ2+OxQ2drnsU0qbwL0B1jti+l0pUJR4o03c5Gxj+X1lSzJkTYEazBsxlPbYx1l5DhN2yR2/SPG0odvQQbKwgb4Ev3y8zKgYwMpwfwOelNzPTZ4FxvY7xWleyDyj8WhaOWrIznNuQzdnttsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMqa4EWosymfMi5A7g2wTyCc0UiIixlRQ9osqZM9KgI=;
 b=A1g2Kswsv8KaeFuMcpXaWUeB/Rl5V9q1eJp/fVte3tVpV3ZWe+BaA6DnED9OGtbNKzMpinUTWNoq3/i1Zo/ObYUphT999MJ2uauQCZvSJDZL0jtAl590X+9Mo6vW6aknL/bEIiDjOKscb35ta0W/vojVLnOuH1tDjPPNZkgy7rc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 05:15:34 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 05:15:34 +0000
Message-ID: <93e123d5-e97d-4377-93f1-06322742b10f@amd.com>
Date: Wed, 21 Oct 2026 10:45:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/24] iommu/amd: Add IOMMUFD vDevice and DevID mapping
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
 <20260930092344.5616-17-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260930092344.5616-17-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0156.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::12) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e6466e-6a33-45e6-26ce-08df2f3255af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|18002099003|22082099003|3023799007|4143699003|260925022911599003|260925021311599003|260925021911599003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	RQOyefKTeQ6IJAVL+ghudzwDDdNMk++g6q/RCwGmQwhmkylAZdNUlaklpF58ne8UnHKiNMXIc2I3kk6mpNbD3zhJcg1W3tWybBrvNxptbtzGXGKfALVE6F9tUDnyBCRGhIBRMxd5tJFhCu1CV2OilPDNi+Po56uPe3CVORowoOlp20v5boB7yX0ekkHab7PYym+JbF1dNNkKcgYn6c95DRLUFB+oANJE4UKlneZRtvelKKEVaPg/p4lxyBfGRDkWVi0TwitNu50wHuajHMpcLTStk4IeWQwEStLOeuJXut3VdHDDawzQjWxe7R9AuMarPiLDIXBN9WKRWEPIAIH/NwlRA2pjxHWzvoGpONUJ6wYLYW17fAbctt5eg7tjC81lM/wpjhPVt7ebolWlT/911K2TK6CerxHzoA0Wt5Wy49pWPkhEUgFgt0maJcLLcS5VAe9/KiKNdzxkL6z3vTq34tHi7rI9kn0AomRxzCqr/BhElfrOdzmxtlhhIaRmCdXANSQS1xm/j4ZjyvSsZ05h9FWhh5Y8L8iuA7ZCnezV/k0dgW8U0lK75GRidSfzJFQlXf06jDe4UOCUDUiQkkeS8Z6tfex3gCLQSbXlgGiNWF7Gles+7xkfgdQM8iZSZQIOw7sB7i9R8qWptHXWCCGVJ8sEKtJbrH8AqkPz72Y0b68=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(3023799007)(4143699003)(260925022911599003)(260925021311599003)(260925021911599003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE5mZkNPK2xCckoyWmhkaTV3b0hiYzVTL2tSYm9xOUFxOGRZcElDWUZQcGFt?=
 =?utf-8?B?cTZWZmFkR2lXeUpPUnZnNjNmQjZhMzJCVG95OEM0WHhyRmJlRncrMlVYWFMr?=
 =?utf-8?B?Q1k1UDRvTEp3K1JYNDh6SVA1QW1zWThaSTgwZHJSeGpZc1Y0aXIvUlRuUzdW?=
 =?utf-8?B?eE1XbGNoaE5UMk9BaGtXZXd6aThKeHdJd09wd0RHdjE4WXVJOThMRlN2aVdN?=
 =?utf-8?B?T0ZxOHBWNmJLaGcvL2lvcTZWT2VBYWhiWWxlV0lDVncxcExjTUp2SnhuYVA4?=
 =?utf-8?B?S0ZyZVdaZTNNWVVqY1czUkpXQ3ZiTG91djM1TGxSTUVVcFgzNzI4bERGYkpj?=
 =?utf-8?B?cGRoQUY2d3JqZEI5c2pMeE0wbUxLd0JCeDJ5ZFV4ZzVLZFZ0T2puVS8zblJr?=
 =?utf-8?B?QlIrNU5HYWdyWXFEL1dvR2xkWHVkekxlaG55K2pBN2ZQYXBabGd1ZWtGSXc2?=
 =?utf-8?B?OXV3VVZXUXJkMVdyVHBWNWhtU2w1cStLdkp1T3JwYlc2b1BWbkVIWTJSeEJN?=
 =?utf-8?B?VVQxRlVMSjF4QytzMWg1RHc5UlM0emF3VkR6cVVsU0d4RXhQMTBkcGZOYXhu?=
 =?utf-8?B?OS9BeDdiei9uZ2k2dXhwVkozTXNmcnhIOHFsTmFmWk0rcGxYM2RmaWF1K3lU?=
 =?utf-8?B?Q0hTQWNtNHRRekF4cXV3aWJCNWo4U05abitBVStJTHgybWZMMENNTDVUV0Js?=
 =?utf-8?B?SU91ekh1TkdUVU5pNWRFL1gwZjdGY0N2Y1VmNitvRlM1WTdTdVZkTmdmaWNn?=
 =?utf-8?B?dEZPaWpWL3ZGMkZnMVpQMHVaazBaQ2pRcjBBSXM3S3d3czdFYWFEam1hbXBi?=
 =?utf-8?B?NFFrc21HMlg1dXdCOTdLZUpTYWx4SWplbEN1SGdybTk4dTBMdm9ua3hKR2ww?=
 =?utf-8?B?akZSYVpCb0JjOENBd2hzV3U5K0JWdlpqZkl3UzdMd0tuZzRVem5QNkJGK21h?=
 =?utf-8?B?ODFKV2JvNS8wMTNVR1BhWXlCa2RzNXB6SlNYZnd6K3A5ZHBhMDVUd3ducmZM?=
 =?utf-8?B?YktZSWJ0STNJemhIV3FWN3dPRVhZaXloWkkvbjYvalRNbEhUdGJueVNCWUZX?=
 =?utf-8?B?cjZ5RnM1UC9mOVNJMlZGWTBQdldmL1NUQ1lLeWV4Mk5JSklTK2I2ZnZtTnhD?=
 =?utf-8?B?QnZkdW9LNFhGeDVRNUZRbGJDNER0UWFxbGw4UEpGK0RhaG9ObFhRNFV5OVEv?=
 =?utf-8?B?dm1uTk1UTk1vT0tsUUZnRzF5V1V6SFRmSG4wc2pIYlBQOHVwSmMvL1hnSU1D?=
 =?utf-8?B?S1JvK2g3TTRsSzdkNWVRY2F1YkFvRk1qTHA3MVFCY29DZHpNQWVES2ZrYVRu?=
 =?utf-8?B?L0pMRGRtS0dDeHRvWFhhVEZKdHJlL202dVBvQ2hvRWpHQ3haeG5wdUQwMGJM?=
 =?utf-8?B?MElnTGdWb2RCUFBsSUFacWkxa3JYODY2S0lMZjF2MVFJWWgwSkN3Z1p1OGNu?=
 =?utf-8?B?R2pDdEFHTzRxajZlR3Q5VEExWUVnTnZFUHMxM2FGeE0wTk5jMGdKRGhIMFBX?=
 =?utf-8?B?eXJpcWJDeDJqNStmYmhKQ3FlOHRGUS9pdXQ2QXZIUDBYdkgrU3U3VWdOVFJs?=
 =?utf-8?B?QUhUMTA0WmRLbWIyQWl1UXdpUTVaMkZMTnZvdFJnY2s5ZHNwd0dpeTc2Wi8z?=
 =?utf-8?B?dFBrSGQ4WXNhdG9GaTZ4VExxRTNQdldYQkt1RUpwWTBDQjl5QmdRZ0tTbE11?=
 =?utf-8?B?ZUwzdE9ucG5WRjN6eEgzNGkzY0p6d3VYWWhDWUJsRHBNaTR2TjFWYTh2MmxK?=
 =?utf-8?B?RzJnYXA5MnBrYkhKeUJVRkhET3lxbzR6cGhIQU5WV2VNd05nWlkvdXFSQjU5?=
 =?utf-8?B?WGZJS0FDRGhYUFRFS0taZXd1VEQwb0d5d09ZRGRSdjVZVEpJc2JQZngvbkRM?=
 =?utf-8?B?L0QzQUtnSmZlNzdCK21ZRGM4WXpSOWdLcEJmQ095M0l0RGFoMFQvZUJ3SmR2?=
 =?utf-8?B?ZG9iaElnazVPRHZiS2JJS05Ddis0aG44VmRlWFNuODUzS0t6YThQM0ZaQ3pN?=
 =?utf-8?B?YXZ6bTMyeVZqSVRuS2M4ZVlrTUdoS3V3dGwrb1g5SURxVjZrWmtQUlpMSUg0?=
 =?utf-8?B?cVZIUkV3dW9zNFQ2WkM0RDFta3BxOTNyRnp1QVliV2g2b0drTWcyblJsbUQr?=
 =?utf-8?B?V2VoUkFjSzViRGlOZTc3UUI0aXR1YWpTNlQwN3V1MmU4bEN2VXo2VlBDbHJU?=
 =?utf-8?B?WWdGNXEycGVoa0dFc2pPVFYwNU9BWW1ncmZQM0dhVlZWNElOaGV5d1lFY2py?=
 =?utf-8?B?L1A4Q2Y2R0YxNzJDSVJlVmNlNTZMSTRyV21JUll1a25mQWJCZG1TdWZHVUNo?=
 =?utf-8?Q?NmHT2OiFEZOgTcwU0L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e6466e-6a33-45e6-26ce-08df2f3255af
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:15:34.6371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: de8c78a7gxHU8tKv7EF5/dZX5GeOwMXEYHFdY4RrO0Ep/BWqsL7igzg0iiAFwXv4AlHDT54xWm1f5eCltss7yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449



On 9/30/2026 2:53 PM, Suravee Suthikulpanit wrote:
> IOMMUFD vDevice allocation supplies the guest device ID (virt_id).
> The AMD vIOMMU Device ID mapping table translates that gdev_id to the
> host device ID for virtualised IOMMU commands.
> 
> Add vdevice_init, which validates a PCI device and virt_id, then
> programs the mapping through VFCTRL via amd_viommu_set_device_mapping().
> Get the host struct device via iommufd_vdevice_to_device(). Set
> vdev->destroy to restore an idle mapping when the vDevice is removed
> while the vIOMMU is still alive.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 12 +++++
>  drivers/iommu/amd/amd_viommu.h      | 10 ++++
>  drivers/iommu/amd/iommufd.c         | 52 +++++++++++++++++++
>  drivers/iommu/amd/viommu.c          | 79 ++++++++++++++++++++++++++++-
>  4 files changed, 152 insertions(+), 1 deletion(-)
> 


.../...

> +}
> +
> +/*
> + * Called from drivers/iommu/iommufd/viommu.c: iommufd_vdevice_abort()
> + *
> + * Restore an idle DevID map entry for this virt_id. Every DevID mapping
> + * table slot must have V=1 for both active and non-active devices. A
> + * non-valid entry raises INVALID_DEVICE_REQUEST when the IOMMU processes
> + * INVALIDATE_IOMMU_ALL. Use host device ID 0: that RID is the IOMMU PCI

We don't support  INVALIDATE_IOMMU_ALL command inside guest. But with current
kernel guest will endup walking entire devid/dom Id range and hitting
INVALID_DEVICE_REQUEST.

> + * function and does not normally host an endpoint.
> + */
> +static void _amd_viommu_vdevice_destroy(struct iommufd_vdevice *vdev)
> +{
> +	struct iommufd_viommu *viommu = vdev->viommu;
> +	struct amd_iommu_viommu *aviommu =
> +		container_of(viommu, struct amd_iommu_viommu, core);
> +
> +	amd_viommu_set_device_mapping(aviommu, 0, (u16)vdev->virt_id);
> +}
> +
> +/*
> + * Called from drivers/iommu/iommufd/viommu.c: iommufd_vdevice_alloc_ioctl()
> + */
> +static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
> +{
> +	struct device *dev = iommufd_vdevice_to_device(vdev);
> +	struct pci_dev *pdev;
> +	struct iommufd_viommu *viommu = vdev->viommu;
> +	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
> +
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +	pdev = to_pci_dev(dev);
> +
> +	if (vdev->virt_id > VIOMMU_MAX_GDEVID) {
> +		pr_err("%s: Invalid virtual ID (virt_id=%#llx)\n", __func__, vdev->virt_id);
> +		return -EINVAL;
> +	}
> +
> +	pr_debug("%s: gid=%#x, hdev_id=%#x, gdev_id=%#llx\n", __func__,
> +		 aviommu->gid, pci_dev_id(pdev), vdev->virt_id);
> +
> +	amd_viommu_set_device_mapping(aviommu, pci_dev_id(pdev),
> +				      (u16)vdev->virt_id);
> +	vdev->destroy = _amd_viommu_vdevice_destroy;
> +
> +	return 0;
>  }
>  
>  /*
> @@ -149,4 +199,6 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
>  static const struct iommufd_viommu_ops amd_viommu_ops = {
>  	.alloc_domain_nested = amd_iommu_alloc_domain_nested,
>  	.destroy = amd_iommufd_viommu_destroy,
> +	.vdevice_size = VDEVICE_STRUCT_SIZE(struct amd_iommu_vdevice, core),
> +	.vdevice_init = _amd_viommu_vdevice_init,
>  };
> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> index b160c70f3804..e263d63afe3d 100644
> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> @@ -6,6 +6,7 @@
>  #define pr_fmt(fmt)     "AMD-Vi: " fmt
>  #define dev_fmt(fmt)    pr_fmt(fmt)
>  
> +#include <linux/delay.h>
>  #include <linux/iommu.h>
>  #include <linux/iommufd.h>
>  #include <uapi/linux/iommufd.h>
> @@ -29,7 +30,6 @@
>   * VIOMMU_MAX_GDEVID / VIOMMU_MAX_GDOMID are 16-bit guest DevID
>   * and DomID table indices (hardware mapping-table width), not GID.
>   */
> -#define VIOMMU_MAX_GDEVID		0xFFFF
>  #define VIOMMU_DEVID_MAPPING_BASE	0x1000000000ULL
>  #define VIOMMU_DEVID_MAPPING_ENTRY_SIZE	(1 << 20)
>  
> @@ -45,6 +45,8 @@ static_assert(VIOMMU_DEVID_MAPPING_ENTRY_SIZE >=
>  static_assert(VIOMMU_DOMID_MAPPING_ENTRY_SIZE >=
>  	      (VIOMMU_MAX_GDOMID + 1ULL) * sizeof(u64));
>  
> +#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET	0x00
> +
>  static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
>  {
>  	if (iommu->vfctrl_base) {
> @@ -448,6 +450,81 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
>  	*entry = NULL;
>  }
>  
> +#define DEVID_ENTRY_GDEVID_MASK		GENMASK_ULL(61, 46)
> +#define DEVID_ENTRY_QUEUEID_MASK	GENMASK_ULL(45, 30)
> +#define DEVID_ENTRY_HDEVID_MASK		GENMASK_ULL(29, 14)
> +#define DEVID_ENTRY_WRITE		BIT_ULL(63)
> +#define DEVID_ENTRY_VALID		BIT_ULL(0)
> +
> +/*
> + * CONTROL0/CONTROL1 bit 63 (WRITE) is a doorbell: hardware copies one
> + * entry into the IPA-backed table and clears WRITE when that DMA write
> + * retires. This is not a command-buffer operation;
> + * iommu_completion_wait() does not drain it. A readq() of CONTROL_EN
> + * is also unrelated. Poll WRITE=0 before ringing a new doorbell and
> + * after each write so the table update is retired before the caller
> + * proceeds (DTE commit, unmap/free).
> + */
> +static void vfctrl_wait_write_clear(struct amd_iommu *iommu, u16 gid,
> +				    unsigned int offset)
> +{
> +	u8 __iomem *reg = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid) + offset;
> +	int i;
> +
> +	for (i = 0; i < LOOP_TIMEOUT; i++) {
> +		if (!(readq(reg) & DEVID_ENTRY_WRITE))
> +			return;
> +		udelay(1);
> +	}
> +	pr_err("%s: WRITE timeout gid=%#x offset=%#x val=%#llx\n",
> +	       __func__, gid, offset, readq(reg));

Shouldn't -ETIMEDOUT propagate so that vDevice allocation fails when
the mapping was never committed?


> +}
> +
> +/*
> + * Guest DevID table update via VFCTRL CONTROL0.
> + *
> + * TODO: The driver does not support QueueID yet,
> + *       so current callers pass 0. This will be
> + *       enhanced in the future.
> + */
> +static void set_device_mapping_unlocked(struct amd_iommu *iommu, u16 gid,

You mean mapping_locked?

-Vasant


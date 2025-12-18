Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB21E5B88
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040432; cv=fail; b=QEHRhL+/VoXgd6J3xLLtuKC1uoBSIFea4yViUZIVVd5S+aPjZ2glkZvjrUhR2nRi9lzu5GJnoyDBvHMYx7yuecxdxuYruCFFTCgl3KhUtU5NUeKVFA8G2BDgCs3e9dDSHwZ8q8R5m1h+h1GtDhPGd+3NAt+ExDNOL57gW0R3gTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040432; c=relaxed/simple;
	bh=4TT1bZ4sJvrkCvXCPm22aP2Qxrq55M/xIfrNO1/nlA8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aVo7UwqmHwQ7I4U+wXkArGPqful91soHIeuLiEz9v4yl5CPHRlZp0jemQxwEBU8IDgg/JW6Tdva84qN51TgIPT/SGpcj8a2Lxue2ABwRvOO7R7DKk8eN+5nWWGfFgcaFD7+7UOpqh6F+GVyaq+jS1e2/3+2xPsvniexKb5EPYQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dCRaAqiN; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dCRaAqiN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oErhqFve189F4+pfOPYY4Geg8KciUseLMawSQLgyCis9c25nSiofvM2n41ZZW1Y+YnaQwQ6YI1EGWGc6GeZ2OAzkye0i5WxUmtyI3rOUSSCUGfl6xkxvredODqEbsSgM4zacobcSfuz6XOePL2Sd4QB/ZuxnUXSFg5fZ4GtduzRQ5z0iayp7gR8JFMpzo1Bh7ROaaCfnSF3RkBPj4pUX/7B32iW9+UJfMg/NWlmK+fq/PN2lbXKhRf3ZTldk0Q0U6OOASLM6yCxclJDCCtSKJ6VmDd0135Pa1SjLdqHo/Y3txDQblu76c6PwW5Om5e2TYHTTVSjIQssFEWWbkUe0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvxrOEWwx5A3DFmhtduMd0dAhV8iLG6TKy8tggzEb8Q=;
 b=O6lsvbwfbFtAwzqFdDiKLV4UQE2ThgSqzhZQK1GVlJ9s3anGzqGgSlQPayc8qRVHzK6NRexokyXE4Wwk3hCPSR6WilOehFbzcIN/zRLtJAh7QWIGA1T061LrIOCCefHZ/KL9csevPYZB4f7/hlgRlc8poMz4S4bDzz3AeblsUymaVCv2nQN+eeE+xlLpl9v33mK9k+vg9+1DPqkezxeS93Oix2pc0koZ54yH7wunLERoKpeVu3IbwfexbhJYKVJI6863LI/TGLWfRrqSloZlSpVFzK/PUjR/ky55jb41n/JB/xiVItJ+vG9lH39/XDfbtXy2IX0E8lgfP8xU7yDUYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvxrOEWwx5A3DFmhtduMd0dAhV8iLG6TKy8tggzEb8Q=;
 b=dCRaAqiNK6swGKBfFf5QZh1tSv1aAL6AZGxfF5WAw4lApGnIGv+iuV+o0aus+vn3Rpvj7XNq587DUvL8yAZ2xo+pXPUeRXzWLIXcIB87UPfO2tUHdkgXxhKdWCVH0U+8uLJBs3MjItR+Pdj+yfBrV9YgD72BjcyS0VTHEYq1Cg9iWHcnz9KiFBz5+oqcLqqYvv5aEHzqtemN0jJe4nHTOsmi1d56a/ekqhtwhLMi1eHkWPg2XJCqYv6MwdCVwGBLng9ldGvAsfv/HJBW5vdHjsrBnE8NCnigKfLJ9JOlV0K9Ii86zAUOugOTea/7MgogEKkZbSbAWlm2SLpTgFHMOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 06:32:33 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 06:32:33 +0000
Message-ID: <5e9a0ce1-a0ba-4a31-be95-99f349ec6028@nvidia.com>
Date: Thu, 18 Dec 2025 12:02:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 2/4] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
To: Jon Hunter <jonathanh@nvidia.com>, will@kernel.org, robin.murphy@arm.com,
 joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251215064819.3345361-1-amhetre@nvidia.com>
 <20251215064819.3345361-3-amhetre@nvidia.com>
 <23df682e-6d08-4827-994e-1bbd89e5c903@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <23df682e-6d08-4827-994e-1bbd89e5c903@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::11) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 434a4a0a-8a47-40a9-8ba4-08de3dff3a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2xXZjJNTFluaGFhdnl3QSswcFJXSy9ITFFFbi9VY0FzQTdtY2gxWExabzVH?=
 =?utf-8?B?bHI5L0lUUkd3andWMDk0dVpPWHlNUDZyU3ZRM2N0QXJ6OEVPRWpyWlpKRjJC?=
 =?utf-8?B?VURSMEdoVDNDUXlMSFQ4ci9lbE5Lb0ZqWmp4WEFPclJMSm8vQlFhcVU5TWV4?=
 =?utf-8?B?dHg0WHFjRU96T01FajFWRUVxa2hubnNLcFRDbUtQYlVPVWI5Y0VUdlB6aXhn?=
 =?utf-8?B?S3E5Z1VxUm9tUkFhaVdENDhPMUF6cFRxSURsRVYzQ0ZsZmgrM0ZXMzVIcEpv?=
 =?utf-8?B?QWV2d0pLZ1VQQVlIQ2FoMGNNeHZiOXRQREpLOUc4K0ppanRTVmV0dmxob3FL?=
 =?utf-8?B?QStsUUlZTS9TaTcxUkhTQjRuQUVNWTkycWxIS1lCVWVSc3FoL0FseTV1WmJT?=
 =?utf-8?B?emVsVlp6MkpyYXFBeWFRSVBUZlV1a2dWVGVaWkg2SUNDdkFRWm4wdzlBOHFj?=
 =?utf-8?B?aWVLRWQ0dHprVVlMdGlOVU9ONnJKUE9DcjQ4Y1p3M285VVFRcGFJb2VSN2JB?=
 =?utf-8?B?NHhGMmg3dUxUeTZFTGk5eDFZaElxZVJsWTlhZ3pFb3FJMWlFNFI0a0t6cEFz?=
 =?utf-8?B?YmpKV2FRejVORnQwVlhOK1RsMk9XTng1WlIzRks2MHhqMHcxNVNVM1RnRzA3?=
 =?utf-8?B?a1R3YSsxY2FjYXA3dlZUUW5mbjFpUGd2VS9BUTZTaWpMby9yRDRvNUNkOVhH?=
 =?utf-8?B?ejJPSXRIQWdWV1IydjhRMWlYSHZUeENWTU5meGZ6MFhhL0VhdVRpVUZnOUZk?=
 =?utf-8?B?ZkJpYUsxSVJWN29maXNUQlVXQkdnckxEWWRhamd5ZWk5WjNtSFZFbDZzMHlN?=
 =?utf-8?B?enVQYVIwOHhWYWdaYzdtOVJ6Z1UzejAvc1psOGFTTmNlSmpyVTBiV1I5bWUx?=
 =?utf-8?B?RXhWL2N0VEVhdjJKSHR2Y2FZcWErZW82ampwRy9vam5PTHdqQXpVUFVnRU5l?=
 =?utf-8?B?eWRGRnRuT0VJeXRhTVVjeWcxK1JYbHBUbm1zS2pQWlEyZ0N6Zzcwb3NWTHRY?=
 =?utf-8?B?TFA1S1Q0dnoxbjVmSzNTWVRJeHRFOHVqcHcwNHh2akthaHBSTnROWUdncC9I?=
 =?utf-8?B?a0gxMU1rMEpaUUR2Y1phcnM3Qjg3VnRIQklzcldPdjl4aGZJYUc1ODdPMlZk?=
 =?utf-8?B?b0YwbmQxVXRDM0RNTURxVnNjVXRMQ2lGaksvaVF6Q1l6RDFjT005M3pVOWd4?=
 =?utf-8?B?RUE2c0NHazlidmE2aVkreUxEdU1nd3NRV29aV1FoSng5ZnM5cytLWHhCWlNI?=
 =?utf-8?B?bXl1eFBZc2xpc2ZkNmIwWFlXbGMxdWhXbjRrSGVQU1RMSktqMzVGRkFpdTRy?=
 =?utf-8?B?eFd4U2ZiUWJhNE81bXgwMFFBV1dTUjNWcER3WVlLODkrQkhrc2EwR2xIMkxz?=
 =?utf-8?B?R2NBeW12eUIwU0xBUmY2bmoySHFCOE1PQ3lBeGVmWWVqWDBSSFJzelJyUXV3?=
 =?utf-8?B?b3Ivb0FjYWVST3dMSG5yU1VLZ0xwNlRGeCtTemhOUTVCdmdNTzd0M0FPZGRs?=
 =?utf-8?B?YlVtMnpTMG9tNkdKSndEQVc1bzR5QkdEdWVqZ05Da3Q1R3JZV2lGTHQ4T0tN?=
 =?utf-8?B?VFQvU0RWT0dNcHVRcmtzVVJZNlpjSTJ2SzRBTGJtS3cybjhSZzBSbTlyWFBZ?=
 =?utf-8?B?UFpkNk1pKzM3TERGWXNncGtYdHd2dXBmckw3Z1drUmlCQnAyeWZRUGtCUGlE?=
 =?utf-8?B?YVFHQkRwYUdqN3J3T0txUUVsSFF2RlZ2dWJSRk5meGdsZFYwZXArMllLZzlU?=
 =?utf-8?B?Zm4zOVpFcVlUOEx2ckxuV2F0RkZ5NDNEaWlxenpycmZYUmtoUmpKZmtra2dT?=
 =?utf-8?B?a3RTczVtaUtZdGFlSUZyS0JjdkNXb2E2N3hCR3pwdEZrRTdMRXpJWXcyR1hT?=
 =?utf-8?B?K1UrZHh5ZHVoUmVRSzE3WTFlUFJDVC9KQ1ltd3g2YjNxSlZhQW96Yk9JSXlT?=
 =?utf-8?Q?JN5V2QLP+lt5WijnRdn87h9b1+bvNRkV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3lkRWowdlJFS3FOcjV4ZXQ4Nkl1UjlEaGVRdlc3SkRlTm8xR1Fja1BmblFi?=
 =?utf-8?B?MlBOdFBKVUtuZEdKYjRoVjlEYW1DMW1OWFJrRHkwbmFEaGIxVjYzRmh6UlVI?=
 =?utf-8?B?V2lVZ1dhQ0pscjNVZ1JQM3k3UXhUcDRXQWJ6YitTOW5jZVlyZ1N1dnpzSGFs?=
 =?utf-8?B?Sk9ld05tdnIzdThXZS8wU29Lck4vMklJdzlzc3NlWUhZMGpmVzhYOU4vTjdT?=
 =?utf-8?B?S0hnMmhMRjM0SENNU0tWK2p6NmVra2pJSUNIL1VjaVlXZHhMdUFzNFhwQ0xk?=
 =?utf-8?B?Q0Z3WkRVOU1MUGMycDB0VDdyUEg0eFRqS1VXdk5uY2ZZb2pNb1ZBSkdNNDhl?=
 =?utf-8?B?bkNsVVZuQjFvZXBnTFBLTUV5RWpsQUJjRUhQaE5Ibmg3ZUNCRWdOMG93VU9X?=
 =?utf-8?B?SlV3WmlobTIvcDZ6QlN3Mm1mbEdPOG1lRFdJUHZiNWI0d3FyOGkrYXgxSGha?=
 =?utf-8?B?eHlwOE9QbENLS1NnMDJDU0pWRHZmVE9CeTE3WGJjanlhVkk2UkZCTXBjVzFn?=
 =?utf-8?B?TWIrZ0grUHV4djdQWXZiS2RzbllMMHNDQ2RJZzFvWDNtUTI2bkpEaDBHVVJC?=
 =?utf-8?B?K0Y4OVBHbU52V2ZlYmdFTnpXcTJVWEVtcVYxeXhMZkRyYWl3SmxKQ1hyOHNT?=
 =?utf-8?B?Sm1zaXZwY2llN1dXd2k3VzhrTndCUGpJcTR2TCsxRWdaN28rdURMTkdKRlB5?=
 =?utf-8?B?Vnp4MmkrYjQrYlpJYUpOeTJ2Tzl6M21QR0ZrTWFNYjVJaXNSNEpGeWk5TGhP?=
 =?utf-8?B?WEk0MTJkbVllZitETmNOREZ0V04wV3NpY1U1VnBZTkxtUnNDeTBzejVrYi9T?=
 =?utf-8?B?T3pZaW1pWFV2bHV5WWVkb3dhVDZzNytKb09aQ2ZRcTdmeDdkODdKUjBoTkdJ?=
 =?utf-8?B?TU0zUldSeXord0RiSXMyQzQ5a0F1S29Nc2RMcVZBeVR6eHk4TWczK2FRbm5z?=
 =?utf-8?B?bUtpUy9YRUdVK3FHWm9SS05NK3Nxd0VtcnA5OGF2a2VuM2h6UFo3UjZtNEc1?=
 =?utf-8?B?ZUZJbXpVZGlpTDk0bngwN0pSOStVK29KTDBobWNscXArczVNT1dXTkgwd01r?=
 =?utf-8?B?YW9kekFyZlJjcVRxSWk3Y2xjNjZyeENTbkdLRVFTVG53cExmNUZRZE16YW0z?=
 =?utf-8?B?UUxBRG5UU0tMRmt6aW5WTURuQy9zVzgySk1kVzRvQVVGT0FDZ0RQNUlKdXpl?=
 =?utf-8?B?WFRvQk1IWVkzdklnMVROUHhjcDF3c3JPQlVyOGNKeVp1VnJLL3gwdDk2WVh6?=
 =?utf-8?B?QUlLa1JBVSszWEpIdXpIYVY0aHR6ZGoxOWVmNGxhb0Y4YlJXcW4xbzZhWUtL?=
 =?utf-8?B?Y25lRDMwc3VPeDM0MldqZGFFMi9YaVlUcjc1QmxhRXNVV29sMWt6eFJ3enhG?=
 =?utf-8?B?R1NlMXI3UTVBcTVFUGtueVBnLzVRa3phWHc5ZWZQQ0phYmVnTWI3YzNwVkt1?=
 =?utf-8?B?TktycEtIM0NNQVFtZ1dET2l5NERJL3JXN1V3MzZLdittdnNmMGRJS00yK3h0?=
 =?utf-8?B?L0VQVVg4VTQ3QU5TcVFYTENFR0tMem9KSE1xaXdEODBlK0dVT0RvMW5zTi9U?=
 =?utf-8?B?ZjZyQjU5cVA4aVFMbm8xUmJoLzhPeUdnSVpiWFFoSUFSN0NpNWxxV0ViWGVv?=
 =?utf-8?B?MzM0REtwYm9WQitOaEtYVmdZWC9QRWh0R3NYbVZ0alJjNmVlakZrYmF3cURV?=
 =?utf-8?B?VGc1Tkp6MVduTmJjWkl3cHhGYUhMV1JsZnprU0R5ZGZWMEh0Ylg0VGU3aHJS?=
 =?utf-8?B?UmgvdTJ3UVlJY2hLTVZibVp2VTJNcXMva1pxSmpJdWNEVDBySnFDamlseUpD?=
 =?utf-8?B?YnY3WTZjOVlYTWNIQmM0RVlLTmR6cnExMCtQMzFPL0dPYi81MkVQeWpHaUNS?=
 =?utf-8?B?N25RbTlRV2RJR3RVSlY3UkRqZE1IRVY3ZGdGQ1FnY2pEbTNSdUU5S2JTREpI?=
 =?utf-8?B?TmpTYTRCYzVieGNTVnlJY0NsOTlQK1QzQjhrWUNUVWhKdTFZeVlWMkFOWWJq?=
 =?utf-8?B?TzZjbVdYbWNHMXFHNDIrYkJueWhjYy9oaGdIRWRyODhNaFJoOXA4YnVhcHlQ?=
 =?utf-8?B?eTh2SXlCQkYwamxsMUpzKyttZzVJaktEaDNGRWNNY0pLRE9WUmpreDk0cDFZ?=
 =?utf-8?Q?59VPJkkgdpZkaomgKfhLt0NBW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434a4a0a-8a47-40a9-8ba4-08de3dff3a18
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 06:32:33.6691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJ8CPLJ7Qvp/myc2C5N/0TJ7LzdA/3nDnBH9xCsRb8kmRRJFy3dc5MDRmR3K0VNAVz7nXECxxCMjkMMfZ0KvQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609


On 12/18/2025 2:13 AM, Jon Hunter wrote:
>
>
> On 15/12/2025 06:48, Ashish Mhetre wrote:
>> Add device tree support to the CMDQV driver to enable usage on Tegra264
>> SoCs. The implementation parses the nvidia,cmdqv phandle from the SMMU
>> device tree node to associate each SMMU with its corresponding CMDQV
>> instance based on compatible string.
>>
>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 32 +++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index dad3c0cb800b..0cd0013200f3 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -4530,6 +4530,35 @@ static int arm_smmu_device_hw_probe(struct 
>> arm_smmu_device *smmu)
>>       return 0;
>>   }
>>   +#ifdef CONFIG_TEGRA241_CMDQV
>> +static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
>> +                 struct arm_smmu_device *smmu)
>> +{
>> +    struct platform_device *pdev;
>> +    struct device_node *np;
>> +
>> +    np = of_parse_phandle(smmu_node, "nvidia,cmdqv", 0);
>> +    if (!np)
>> +        return;
>> +
>> +    /* Tegra241 CMDQV driver is responsible for put_device() */
>> +    pdev = of_find_device_by_node(np);
>> +    of_node_put(np);
>> +    if (!pdev)
>> +        return;
>> +
>> +    smmu->impl_dev = &pdev->dev;
>> +    smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
>> +    dev_info(smmu->dev, "found companion CMDQV device: %s\n",
>> +         dev_name(smmu->impl_dev));
>
> This seems a bit noisy. dev_dbg?
>

This info print is similar to what is there in ACPI path as well.
It's only a single print per SMMU at boot time. Should I still change
it to dev_dbg?

>> +}
>> +#else
>> +static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
>> +                 struct arm_smmu_device *smmu)
>> +{
>> +}
>> +#endif
>> +
>>   #ifdef CONFIG_ACPI
>>   #ifdef CONFIG_TEGRA241_CMDQV
>>   static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct 
>> acpi_iort_node *node,
>> @@ -4635,6 +4664,9 @@ static int arm_smmu_device_dt_probe(struct 
>> platform_device *pdev,
>>       if (of_dma_is_coherent(dev->of_node))
>>           smmu->features |= ARM_SMMU_FEAT_COHERENCY;
>>   +    if (of_device_is_compatible(dev->of_node, 
>> "nvidia,tegra264-smmu"))
>> +        tegra_cmdqv_dt_probe(dev->of_node, smmu);
>> +
>>       return ret;
>>   }
>

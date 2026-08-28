Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F2345DF7A
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927254; cv=fail; b=HSTw2UMYayfEIiM2vhD7/E6/5leBg+qt34Rib87/cr/hy08UP4T7k4iOZxPWnECpsxq2OvsSGn6WaA4Ipy2SMG8DJ/oIPur3RPcWgwYD0NRoetFc0wRdclKAaCfVnv6vCv0jtB771t2wLmWD3HUa6oWUacqHBrbYzQKY0xNvB5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927254; c=relaxed/simple;
	bh=vy+s301/n2QiMoF25bJGXj1GN9nEHjPwNLrT4qxW9+4=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=LBym710UgopLkCwBecEnzPVRcLNquwL5kBv1mXidozASsYQfN2CtKXJNPr/4LUYWAY/npZDOWy2R63ydWk4XxOfAKmKbLHzjNw91Rsmena4HrjSBpfyW5YhR5mVN4n4dP3fdm/TRyx7PoKk57WT0IKN6Mky5vRQNoDIWF7oKTcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UCE24gDr; arc=fail smtp.client-ip=40.107.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UCE24gDr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjtZ77Nk6Y2QctqzSjC+g3rMmhYKDmI12J6JrvFMDUwpwyquVnE24dp9wcfsErV+lyCaHh1IRTeln3R4DXAcOaXLFTnBGEPikRN8yWisNgOiRoMLF7WfBTw7YiHZMSspMo3XrbkLqjmWnqKihuEWPokkXQoyQe4ifrKtmrcDa0fDg+pqYasPs2sSo3BRTYqdDtFZeauDn+esUL/sO3yatkdPJ7mfWjcFOW0ddV/xzIggKEtzOeH9Tef+wxeR4jASCSeS76VxpCDX79KM1xgRPhmLNPxGxwMBk9TUN4fTecpbSo53rcsLJ/WRsdj+a3SFYTiNItbcTEwgBj9ODeZIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=002fEruVvYBaMMRSOm2IVMy6fi2q5sUtMvh2xOd6GJw=;
 b=dorfWzkqfWIxYWTfwsm9k8rN33pd/rS6M+jXRt70k1FCd2pSzrnSu/ZCSCpecrL+3PbMYc2GzGtzUDUq4F2945PdRee4kmCmheRHuWrm5HXjwJ5sDk8aswpoN/l1gcj9+1tVvoGfBP1M/gkMhzv9/vjVR7cEENNsY6MmR4xnnnn9sY+m2Dqlo+jH5VIEAYT0nf7E7I5+K4IhpvCzN+qgX/P/Q0MZXBpSvs3XS7ReVv9JAOlAbiKEDE4nGNs4QdJniNQvBjsqroJiwDA7BpUHt5Ppmwkh1kOtXNJ3zqb8Dcqik1cNN34a9mlVV3YHdgnnyYyj3atUHxAqUCSwSR1ZpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=002fEruVvYBaMMRSOm2IVMy6fi2q5sUtMvh2xOd6GJw=;
 b=UCE24gDrvfE3HJkzxaVbJxBREJF/SuUN6iE5of4+xnSO7bTa0k5/kvgKBTBkuEz276DEjfgFYDxUwPfXIAXBdElLxHXBRCYOzsObJrYQFlgtuqku84KbL1RUWmlM0cwJb2MDy8n1g6m13XsceEJFgAFvcN/vvvHFpiM/vp/UY5RywrAn1ps/sb4z/T6LuGXwhUyaq2RFl4OUKRkwroqUc8F0OTYGvkVpNd+TJzwvN41rGugquwiREc0ZATt2q7D9PKJcqkp7nJS3ze/HCmtJTl+zRPgZh8SbkfxKvqHzP/jQgH01BIaWl1Am2gd8OVIDwGfFgjN8ZT9fLTd54a/0JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Fri, 28 Aug
 2026 14:27:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 14:27:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] iommu/arm-smmu-v3: Ensure L2 tables are visible
 before L1 ptrs
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
 joro@8bytes.org, jgg@ziepe.ca, nicolinc@nvidia.com, praan@google.com
In-Reply-To: <20260828125409.1921538-2-smostafa@google.com>
References: <20260828125409.1921538-1-smostafa@google.com>
 <20260828125409.1921538-2-smostafa@google.com>
Date: Fri, 28 Aug 2026 11:27:22 -0300
Message-Id: <178792724267.3808739.1360374025681437491.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BN9PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:408:f5::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b9ac37-6cee-4307-0467-08df05107b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|10067099003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	CONIwJe5vgMeCkhgeKAWl7eV7M7Wx6uONYwduPDq9Zr4b/EZ0IutepxVXVGP+eEeZi/8d27tebLLewbs+NMzUsjrpuxHOdzEPFuML58LwW14TpqKiF+IKzzZXW6bfGvNo+jQ+7Y4CbWeoKAh9tHM8TX9c4xp0v0BuVRzlF2hkwDkZ0jGLBZJHFaSlVRKtGgUa8LGmE9he1/jMrSm6DqTpu7AetGOPBCXNqs3dACp+2sccpND/6zfkxQ7O0D+1knE4Nt/FBprHtUaQ9+JY3ifkwAO44v31c0CzFpOi6+kSciHz0lv3HdFFI7WiJfCEz9zRVXl5kDqnCOtjXx9nVU+qi4HH6qf1zrXXGyKX3MhT5K1GiEFUtqIqObaYLpXjHFIKDfMQVBdmUDHenMefqT/bzwRpL+jktAB6nUkvaguaZyhXLVam2DafVLp1h3NZ5TpZTLQuzPduRKLVEpt9RreWAYsQO+l83vPMx8aZEJLBZ6B2MJ+HHPl+dRQVcV4IReHWEOw34UlfXKDWAIfOeKqecEMV3FrER4C4UAYsSFdYbvIUmPXnG0OGvv6HSJ/r9zxidfS0QywqxCnWb+dDbGA5QFCHLeio2/QCZih++xy1Ds9dmujoV6LSvJLrasxXWMZHb8xSGtx08RduaZucyVmbrKBe/n9LlZWiL8WgMW9Jt4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlhCck5kb3VOVXJtaWtvUVczaXpkanpHbDRIZW5aSDloajhpWnlXN095T0NY?=
 =?utf-8?B?emJxbjkwWFVVM2JrNjkzemFCOXVTS2RJUllaUmJHT3VEY1NEZk9hWkR6ZUxP?=
 =?utf-8?B?c1lWcllVdUE5RUIrQlQyVzJqSC96djlDU3ZSekxWdnpvWFQ0bHhOVzdSTUtu?=
 =?utf-8?B?TlNmK1hIbWNMTlZkaGJKbFNIY3gxdk9FSHNpOTFRc1RQbVJBcDlJVHpJWHM1?=
 =?utf-8?B?NDNkbnJtcE9wTnMvZW02eWoyTlI4b1VNRjJQQ1BCUy81NnVmajFRaDk4ZGdo?=
 =?utf-8?B?dGJRcHFpSGFENTZoSFJRZEVvVGxqR3VWalJKelFiS3dDN3g1dGxicWxXV3dk?=
 =?utf-8?B?VEdyd1p6RjkrNExNVUR6eUtVbktUQU05WXhnMUU3SVUvemU2Z0ZwdXRUdEFr?=
 =?utf-8?B?VkJ2RkZuK09nbVZJOUdDVWVPaXdmV1U5Q2ZQdFlxSXZLVVZ2SEhCMVdEMDdB?=
 =?utf-8?B?YU9HYWxIeXJkd3djUng5MmdtRnA3SXkxM0NpWEx5bzNQUVBvcFpHVG9seUdE?=
 =?utf-8?B?L05Ma0diZjc0VUVCZUlpd09NKy8xeExwSkI3VkQ0VzVqN1psOVUwSkJiZXZ0?=
 =?utf-8?B?NkRDODcxcytYUElUZHRZU1hySWNiNTZlUzF0ci9NQ2xTaThXd2oxSDBzMTRn?=
 =?utf-8?B?UXNkR2JqeXlnSGgyNjdKUTQ5dE1kQUMreTN5Q1FVV1M1WDZENXVKcVc5RUlz?=
 =?utf-8?B?d3RzZm5tM24vdElmLzkrTG1neStEZWlXSm9xL0w0T3ltaFNVd2hwdFQvcHJI?=
 =?utf-8?B?dG5vTFk3SmoweDZUc2hRMkI4YklIRFFQWlhlVFJ2K1pzbTNrYXdIejBOY2xR?=
 =?utf-8?B?Q3ErRmVvVnZhRER1N2orWnJPbnFuOXFSVitvR1VzRmZYTmFYU0Y3QVVVYlFy?=
 =?utf-8?B?NElvVGlaM3Uwc0hCamI1azBRTHB2RU5YbitZUjhnaFhXTUoyUWlNNE9Tem5W?=
 =?utf-8?B?L2tXcEdEcmZSeHRiNVdYdTF0elVwVHlDQlVjYWtwRm9CZWNDamFVMHVoQzJ4?=
 =?utf-8?B?c1FYRHM5YjQ1SHdkU2xQLytGRERwb3IvWCtNclJDQW9QamRCcVpZRXFOcWw5?=
 =?utf-8?B?d2NuOTNvTkgvMG81NnpyMTU1eHBRbk9LZzJuTHkyUjNYVEt6SE9iaWtCQ1J5?=
 =?utf-8?B?TE05eTlCMWVZZzJiYWtsQjM0UzE4ZDZoNjRpRmZvU0grWnhVWFM0aW5leld3?=
 =?utf-8?B?Z09jODFjNjJjYXJSeWNJSng4Z1AyaWZXNUNlenV4RFBTSzFVQlR4dkMrTlJ3?=
 =?utf-8?B?TFN3QWJYd1lSSkJlRFc2UU1NQ1ZDeEZuRVR2dDZabGdBTEowZkQrWWtQUXBl?=
 =?utf-8?B?Z1BiNjh0clNHK1U1dUlvbEd6SXRXQmZDTGJyV2R2YTdULzN3MkVrY0Zyd0Va?=
 =?utf-8?B?WkM4czVFSCtjMEJPQ3o2QkRuakJmU2ZsREpNOHYwRGVKTDFnd0ZPR1NUbFN1?=
 =?utf-8?B?T2FHT1NlS1ZMOVNyY1hteUZwQ0w3UnhhaEtoZnVFWm1HTU5KZ1NPL2ErNE5C?=
 =?utf-8?B?Vmx2WXZMbDBLQkN5RWJncUt1YWVmdGNqY2hFbUUyMnExS1dPZGorVkJ2OWV3?=
 =?utf-8?B?eVNKRGlQVTdOd2x0WnptMEFTYTFwU3Rmd3BvMjlvVUJsOW1IRzYwa29kUVo0?=
 =?utf-8?B?VG1MTldoRTEzVkpIalR4cVN2R2s4YzNpNlRQY2Vyem15dE9kVlVjSU1LUTlG?=
 =?utf-8?B?eHR3WDFXTGZyRzNBUy81Y0lXaGJkZkUrRzV4QXM4Q1RQeE1qZWNuVkNpWm1S?=
 =?utf-8?B?QnhxSUlkbHBpT2JKUnZuMEhha2ZCYWlySkM5K0hOdlZxdGltaUlOYmhwbllu?=
 =?utf-8?B?ZFJIdWhFSVUzUStLVXJRRmJsamQ5aytDLzc1bkVPd292UThDVUZkSmNMZVdZ?=
 =?utf-8?B?d09uSU45aEt5NkwzNjJPenlOeWxWMCtGdFNqRmdjU3hCYjJibjk3czhFZVQ3?=
 =?utf-8?B?MlZtMDRPUjN0cms4S1p2ci9xT2RMcHRvcWRTYkRPT0NBaHQrWnJUSGljSUZH?=
 =?utf-8?B?UzVGMkI5eEJkQTFMK1VRTnMzdW9qQnJ0Q3B6Sy81N253R3loRm13enY3TTda?=
 =?utf-8?B?OG5sSVR5bWVNU2JGUGZsMnVPcXBzbjM1eG1FZk15UXVUOEpkbVFmMFV6Z1pq?=
 =?utf-8?B?WGZDWG9lWEZZSzVzVGY5dFNWdjFRZGJGeUdxaWhDdHIwRVdDT1lHbk1kck11?=
 =?utf-8?B?YUR0UE5hajZiL0NSWFpxNDI5UzZ5ZVdpR2lKWk0raHJJOGFvcytJN1lEa0ZH?=
 =?utf-8?B?aU9nOHBpSVMvM2paTkp4UFZXSDhuck0wOHZkZ2xYOXAzUkgxUEowWmtCZ3FX?=
 =?utf-8?Q?kLclD/vGX7n+enhMn2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b9ac37-6cee-4307-0467-08df05107b1d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 14:27:25.5343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSKJibz6bJx1f30unK2b79ESC9vguaErocZzvalQqKQ8a2Fbcp84Nbo73c3GOozd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314

On Fri, 28 Aug 2026 12:53:36 +0000, Mostafa Saleh <smostafa@google.com> wrote:
> Commit 6fabce53f6b9 ("iommu/arm-smmu-v3: Add a missing dma_wmb() for hitless STE update")
> adds a dma_wmb() to arm_smmu_write_entry() to make sure stream tables
> and context descriptors are observed first.
> 
> However, STE L1 table descriptors are configured directly
> via WRITE_ONCE(), where before that they were zeroed with memset()
> inside dma_direct_alloc() then written to abort in via memset() also
> in arm_smmu_init_initial_stes() without a barrier in both cases which
> means that the SMMUv3 can observe the allocated table before the
> written descriptors causing it to fetch random data.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason

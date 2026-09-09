Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336C3382C7
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971493; cv=fail; b=GK1Mn6xvvMJjN7ZzgYgq3ZnSF8RLHlpzBJvKcpvpgXUgim0tsKuntuLXCXv3sqGt4Ip6eGGo6gyI3j+ksVx4VURgvOhm8vldMjlkn7oS7zyuHz4Z7oHBU07aVtC12WQA2cdZTRiXsPz5c61e4VVAtyBYfEPCdc79NVOThaFfkVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971493; c=relaxed/simple;
	bh=/89KXwttBAxyFNTo3pBD5zNykoJiup3Nxjzr8Bc2I+M=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=E0AcpZW6iIqeelOWjCRKM73hE+8eDgfDoy68tSe+kp+s36jfdoNlYb0aar+wAZTYtlcow0YeIJEOTmcdZ/k1bf/ZHu9DWsrLhZuSHPYsEnuJb4wYBMvDcuRi2EBwHiFTVCk4ixvF9i0TsKGw22mk+p7+I8YeTSz7owY9AeslReg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J3pGEKEu; arc=fail smtp.client-ip=52.101.46.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J3pGEKEu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vk7mc/3TdvP/aXpaCPcxFtUbiYM8dofWxJ3dlLiTJ/OD+Ob8n9ykL53jP6kxqrFwJ3cYnKEM6weMiisCZnuNdgDsV0jhMO2RzJBpjWr0B3b48CQjUNLqR6gLFhB8wKzZTVkryRJGOCvasaCMjYlt1FPPY/w8du5BA4O0l/VL9eTGkofI4FbvVi7BM9lwRapFxk12EPqsRfPSDDEhPIx+QC+avq2tSrmyOhewStJRXhxW/Sq4XSWWakKodw+SpLPS9OYEjpGyyVHW2lGsr/T/b1+oVgXYfnYBJD5dbg139EzRxhCyYuVcWFUfl8Nakk4RLvXNVKh3GPWYfMQcsd3hzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U+Yq4nrArOaeVZo5AyaDfginqVpR/6B6Cqn3VDZHGs=;
 b=WN77k0+FFb6D5k7DbqopAvhRh6yQSbLICzbQqsz2MLL898+sjmM0xrGVc5YmPuwtxduzkWMP7t90kaG5sp1HFgZNJ5L7X116wAv3+JN5UV9kvyeaaKvsr8aeOIanfqJ69ftetbOFlDxLqnRymQ11GqcIiyBFGuwF+udLbUjNHP4qcroykgx0AHSE0SfWChYHQP6lvibh3U5AZKEV6aZIiJLk2QADlDdKSKT+nWpFPeCj8nmiOfi4eoZ7E8nAUw85UsSSKxFQhFNPJMjxdSegiWJ4j+SoOe6QrE1BGahlclTahz14NGP1/8Ui5qbR66oJ9cBnMfzZqIhDJqvxWeDRiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U+Yq4nrArOaeVZo5AyaDfginqVpR/6B6Cqn3VDZHGs=;
 b=J3pGEKEuru5B7+xlpDLGHy8w19voXxOQKG96/l7i376kpaip4DmZrESURWLYJGx009G4CJzABRex10f/19Ed3ltBbsxM4z4C9BDtEhrCtEFkY+TlzwkkbIjVZy5K4Ys8PEOU1lWpqtuSddz3PWlkDTAjanSYEA0s+gvNPCX6xfCuC8wHzYRD/i+whRnk+oDD1jiV6sHFDarKKadY11dTl4hpcFgwvj6vpAwNJe1hSp2TPde4CfoUdaTbHxIQ531SMR/AAHvi1WIeeTspPUAFl1ka5arIADGV2QPVoMi6UTQdlmzv5lcPaqrBvXycHFPd42Mjuc+MjkXGMzz1uMeHnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 16:31:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 16:31:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] selftests: iommu: suppress -Warray-bounds in
 _test_cmd_get_hw_info
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
In-Reply-To: <20260908214825.2682078-1-eva.kurchatova@virtuozzo.com>
References: <20260908214825.2682078-1-eva.kurchatova@virtuozzo.com>
Date: Wed, 09 Sep 2026 13:31:16 -0300
Message-Id: <178897147615.4136580.17560978393560853063.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BL1PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4f060a-de7c-4503-7b84-08df0e8fc7d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	xAmmGqKnt4petwguzaVQeD936v349blCl4tmQE4v6mb7h8VuDg/HGn+50s97GkhecZ7s7FtYGC0GmWmkqDXY8g1AgSQotMqMDied0qcBfDinzrmK6gXJv25ve1aw0E2u8TzV6Ufvl+ynuPciyW6aYLNYjJc3VupSwLo0e6PhdunzOJi3Nag1cOpB0S+Zi+0/4R2Kd222pJq8xW4HHcF37NggoZodaPMNq0SO0BA9rcjOu4IU+/SQq9loJuQZLkxXkXUl0vx0zuQ1884wdpyXZD7s/DvWDKSWYZg6kv9L8YUruVK8q5YEOZ0BmgoYL99DumrJfHTAn5/0Q82tm8dvIx1k4lcUfbLqpeGdEjK9xbcYyyPIZ/Cv2Q4TwxQfdf5JEhVBiTqJUuxu0eXQ+N6kVj9mpqdZziz/IF6qqxpJimHKBX1dP/ldOej4X98abTALcqRMq0Ij0qwQSjY4xa6XR6Q2PkJ5TilIdTEZtciHV3nA8BgVKyXWMVJyY3bHot9n/VIL/l2YwqmMRVyCKmdOA+b1gwTTQJAxHY6XAjUY+I8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmN2RUllc29kcS9kUGVaR2lYQ1NpK1B4azhLOUlXcmlMODBjbGNlU3JVTHFG?=
 =?utf-8?B?ZUx1Vk11WVNkMEFuc3pIakZWNG5RLzZTN2h2ZGNDQVo1Y2JZQXBvUk9rMUs3?=
 =?utf-8?B?OVQ4UHh6K2E1TUo2YnlvTEdFSzZnSTVRaGRLdDZvRkhhR0Zlc2dWeDM2M0lr?=
 =?utf-8?B?Wm5SK0QvWmRKM3ZOeFZ5UVdZcmVIUkJyM08zZkdvRGFiaDcrOXdqaEQxQkZW?=
 =?utf-8?B?Z3lFakJZL1p5ZGlpeG15SG1QSnpkbDN1NXFGUjBBVXpGREpaeFczZ0NtVjM1?=
 =?utf-8?B?WmlodEJCVWFqYlJ5S0ltTXJ4Z0RYL1BqdHBhOGlMQXhPS3hpNHAwNUpPcFdF?=
 =?utf-8?B?ckNUU0NtQmRReWkvWEhad2pmREszRUhscVE4SlNSWUtPVWhraGcrZkZzWWJW?=
 =?utf-8?B?YzR5VW4wZ3JJR3pNSDVNeDdTODYzS0tldGlJUzArdXlGZ3VrOWhYZCtCREph?=
 =?utf-8?B?U21CT1R2VGpxVzVwdG1KbDVXb3Z1WEhZdUQ0MXV5ZE11OHZwUG5aTEFWb05v?=
 =?utf-8?B?d21Hc1pSV04wa0xoQ2pPenpZZHFHQ1NweklFckVvNHFHeVlJQnFEK3BsSVd5?=
 =?utf-8?B?Y0NsR3BaT1VaTCtvNDBMcDhxYThjckhSSTlDd05UaGU4N0NnbkYyd2h4UTNj?=
 =?utf-8?B?VVhOcEtTU3NVR2lFc3JLMjM0TjQ4VHZpZHZXOEpLK2cvZlJQNmxsNFNvZGR5?=
 =?utf-8?B?ZitxY2JSZVorMUFUcEZ4TkNXcDR1ZGp5dlhtdndBNDRNQ2F2QWxLRStXZTZu?=
 =?utf-8?B?WUl5NnlUaUpET3l6cG0vK1BPeEc5UUxvREY1aWpldTZOcWZ6RVdNNzIvRlkr?=
 =?utf-8?B?MDFwY3Z4ZkZpVGoxaG4yU09kcy9JSzFhWnFKTGJqbUlhV21QNXgvTVgwMUh4?=
 =?utf-8?B?bitmZXViTW5nZUkzVlBlVTg3YjVPMEVybm9HYkt1VlBDbmVDWHVrSG55RW9n?=
 =?utf-8?B?UVVjamQ3dTQ0NXpOTTlRNUVEM2s2SUtLU2tjTHB3Vlg0UjZwNXg1OWNRZkps?=
 =?utf-8?B?RG5zTE51d3I3QXZwem1RaUhvbVY1VmR2RHhZZmJSeFF5Yk1ja2sxTXhPNmky?=
 =?utf-8?B?NWkrVzQ1dVVDSmpMUTVtY3FsNHZ1TXIrNFBJaHJUZmYwU0NjSVZKNHlPM2Zr?=
 =?utf-8?B?MVZsWVRDRi9LOG9QdURmTmZnalhEWHlmQXNKYnJENkRvdXc1RlBaUzZJR0dM?=
 =?utf-8?B?TjJYdVhoV3hCdGtOK1U4TEMvRk5XWlRvV3hlMjRJOFNEalZOeEFGbDBMRW9i?=
 =?utf-8?B?ZDlBZEtZdTRKalM2SHNMRjl3Q25UdGNrV3hhb2M2QzdGZ0IvQThZZm82TWpr?=
 =?utf-8?B?VTVHaTJscnZkQWNQaUZlS0hKbndCK09vWVFzNnpqcWhrd1gwcXRpamEzNWxv?=
 =?utf-8?B?bW83TE14VnZFNTNXMEpNS3RFVEZDK1p3OGFYMFZOQTNiWVR2NjljNVlUUWZS?=
 =?utf-8?B?NXl0ZHM4bko1OTdQdXFMNjJLVFBlZk5Cd3QzVzZyWmZuVWlUQ09hbVd6WEVF?=
 =?utf-8?B?UWE0TmpSY2ZkZkVZZ0NJRkVSS1FEZmVjd0N3NVl6SFBnZVhiUnpFckkxbDFz?=
 =?utf-8?B?ZW5wMnVJRFRCUmJpUFk5dkF1clJMejMwbnhwUkl4RmZPN2NJeEZqaGVjL3BR?=
 =?utf-8?B?WmNMYWxzUjFBQnhkR1pneFJOcUZZUEN2N0lSWlJ4cmYrMldSMWNudXdWalBK?=
 =?utf-8?B?aW94Zk1DeE8zcXNVTUJ6SFFqV0dqUFh1aEJ6aHNNOUp2VmRXNjdsVFFLRVRY?=
 =?utf-8?B?RC9HWUJuelVYMnpPVW53WjRFajJCTGtYK2FnUWxFR1VMc0Y2bEpaZURaWkU4?=
 =?utf-8?B?K3JWVm9oMTQzVUxSZzVQbGVtWmFoa2RvUmJ6QzUyTVNQRjlGcHFFbjU1ZWRT?=
 =?utf-8?B?ZnM4ZHJ2Tzg2VUV4bnBhSmhJdkN6SVZQdGp5M1pUczh2MEdoUmRlQkJpS1RN?=
 =?utf-8?B?NEFsSXZLZjhrR3V3NHZqL1REa0RnWjk3NlVhS3M1djBiUWhtWktMcmZGeFhB?=
 =?utf-8?B?eGJkT3R2SnVjcEoxWS9ITVlrSXAwdDBIbDIzeDBXZUozanRuSEVpcytBQjR1?=
 =?utf-8?B?b2RGcnU4S0YxdlRhaTN2MXp4QnRoeUg5aCtqTnBtdkxubjVHZjRVRFdYbk1J?=
 =?utf-8?B?TGxiRTJLYkhNcjZ0VFQ2WEVsSnBMUlo3UElSNGsyclBoR21Bb2F0VWk4Ykl2?=
 =?utf-8?B?V1kyL2hSUGYrd3BFa3FxYkpEbGhoS3gvUTZUUGVibDgyUlZ4YmNIcHZuUEYr?=
 =?utf-8?B?RTJTVFRuL0FIM0JORG0vdnhMVFVoN3F3cUxzMy9aSjdnbUJRN21jbE9TNmdY?=
 =?utf-8?Q?rKU/lV9lTAlYzDBvJ9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4f060a-de7c-4503-7b84-08df0e8fc7d4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:31:20.7511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrxxDFRa4pCKUkWZgFMW2UYWjN6NaHBaG2PdSfTCo3LQNq+DLqtBvsDt9HVlPi0o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172

>   In function '_test_cmd_get_hw_info',
>       inlined from 'iommufd_ioas_get_hw_info' at iommufd.c:614:3,
>       inlined from 'wrapper_iommufd_ioas_get_hw_info' at iommufd.c:589:1:
>   iommufd_utils.h:683:37: warning: array subscript 'struct iommu_test_hw_info[0]'
>   is partly outside array bounds of 'struct iommu_test_hw_info_buffer_smaller[1]'
>   [-Warray-bounds=]

?? My tree doesn't have anything like
iommu_test_hw_info_buffer_smaller ? And all these line numbers don't
match mine.

How are you triggering the warning? The struct memory is properly
sized to do this:

>     683 |                         assert(!info->flags);

I prefer not to have the #pragma things, I don't think there should be
a reason for them here.

-- 
Jason

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793019591;
	b=kJN5TeNDUnROawW73Eo/YEmchjAnly2fIcBhrgTsk9CdSOSS7LejJHXPKfb4bagaleJI
	 htYJ7wuN9F3RFyCHyeLsaGihdJZWU2UqBUTlcPaUNkwudP8xypnr6LZaoMxINJeX/Kewl
	 hNZGpXj90Sapzztf1zxT60dR0NA4luO7KmvF/aGVBI7IEeLUY/Mi/Huw4GrXRlqTJRPk4
	 XHbxH2WpWBRXggJxl19ifbZiU49XS94B8fb9Dcdgp+VUsHmefahQHlPOaxKy05VRiJmrf
	 Q9JWnDTGIeJBMIApG69iyZUOZZztpAkeJ6vdkNPUeTJtBkZtXx4GBV/NLJ3xiworawA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019591;
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
	bh=HtvSFSZ2UdEzY9M5Qr6pOw2vjZBcQls6mkJEDlQS+iU=;
	b=FAdv3OdwG3M6T6/2RXhRxyPiqLfOU7HGfn64SVcod1iR5Tw7CalmGsvcRaX9PaRXAoln
	 gKqicVr9bQCefLmDgm2USvQ8+ZmWDG92565gjsEl41e65f1d2+3O2AizRHO74niwauVfF
	 DrKTMey8rspyU1wdvh205UYKGHeplOnH7vKV2Q2Tsi8NjfPifS4Xjmnjs0F2bZK18FbtE
	 Q0BwOhHcI70OggEjM7tfYEvZu1axd1dwndsw2rrwaKc9AlQNVvVCkXFO50vv9/WXJKVVR
	 CVqUAzxFBb/YT22mMI92Jj9dqlKYQS9jqjksTwtZyCyi6H+la4ILD4ERH3YN2ixV6xw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qy8GgyHX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.34
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D90C606A323
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 12:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D90C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qy8GgyHX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odQ5CKsiHd67PZI6DWMIB3kbWfJIcOHksgyOktqjK0eEgBf6k60yO3XfKk4rvd6aNtnGa7XR6WXkcBkUyWMUvQMmq5jI3Udm1tiG3O9iXnedKkRFlXabkjKDlJjtfLETn9eZCO8RFmw3qMyHmygl3rU5cNL2NO9YX1UoJVCGT/2uImI/P3OnecjRwEzJIaejMDhAwBYTJQlzYB2Cq+WH2hF1jHooeg6wkdwaTe3YOiCWycxDjOS7166WTAnysvNORoGVw9rdSFHSkDRmKRpmvNclDVa6XhjHGfTluzlgiN2D5nIZSsnlAs+9Wb5p5O+CVKW6nkpnnobXPi8HAww94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtvSFSZ2UdEzY9M5Qr6pOw2vjZBcQls6mkJEDlQS+iU=;
 b=MISFAWIlYJuLsXRVua0FoRb4JFMKsvYmf8csSiE9wXZWLp3/24TeJzOicFxseZ9g/V+3XxZBjQ2eZevyFGDiUodVLWZ/39ct/wr8Gj9N/SHHlaeiKMSXx5PkEeXCTnm3GseEWsXUb8J9yXoDWSqmUqpjySnM5seqrbF03avKD5iGCNIDRW1FuMZq7Vl4mqVuJYIzOoAP2BQJfCh0x+fnLADtUcY+CT5fiym0V8zx9DY26ef6Ymp0ebOeyjkZ0u9kwnQxDpN7LkJ/bkpV5aU/Y4L/wVZ/evB487wNxXi1xP3qjuLtSNPcspH3JcpkR9GxI+qFk2ahZVN6HRqli0wCVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtvSFSZ2UdEzY9M5Qr6pOw2vjZBcQls6mkJEDlQS+iU=;
 b=Qy8GgyHXIz3ona94u1DAqzT0j0NqFiccr/n2aXlETOxIk08JG8ylI/HBOxMSs4OaL6YWsscb0yzJmf6NPuSCVUOetxlMHAtXbzkqY9kZVlHdwaOX5on6NZ03Cw0G/MOKRTzu1bV/eVynn/Rw3xrDsQV8A1zgbbJBIVgOZ6WFCmI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 12:59:46 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0546.016; Mon, 26 Oct 2026
 12:59:46 +0000
Message-ID: <d5e053c4-34d4-417e-ade5-f7f461f9e426@amd.com>
Date: Mon, 26 Oct 2026 18:29:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Remove iommu_group_mutex_assert() from
 amd_iommu_clear_gcr3()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 Max Zhen <max.zhen@amd.com>, Liang Wendy <Wendy.Liang@amd.com>
References: <20260814104029.71021-1-vasant.hegde@amd.com>
 <20260817135155.GB1415075@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260817135155.GB1415075@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0161.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::12) To BL4PR12MB9505.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SJ1PR12MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f51adaf-bfbf-41bd-b292-08df336102a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|4143699003|11063799006|56012099006|261009223027099003|261022105027099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4IenMox7JGtZ/9/LnT5v0R0ZAd7VV5AE+lwYMHF17jZGE8RTZ8EGcveopp8ZLC2bntx7Ure0yP6aUcc/sLCXXTEp8dwqOhbgZbw15wEkUf3RT/n0TkmxikiHtZXuVh78g+zbbC7qWTe4XOj4ce0/NNrzIB9hix+ga03+ZZ+GBN5u9JiShKeOYt+rUWgzZRCk9QgniB1b35WofCXS8i5UOdzS6ERDkYzLZ3Q4aRAAotPPndH9iTow48NPWX2bAEMzYya+uwVFuNjC8zKBVICi7elhuy04U4FPH8VgugB47AC4zFiouQkFegLxJjMfYgzxYEuDlBk6mVeddpnh4e5WIwQAuILX1FxC7y3mQt81vnK16q+Itv97/p8D4FO52Imros+DMDDq6NkIhprbcSDyTxiJpLXb2j7QMp/MdwopK0svD4q99naXgAA2M6ljGHXecnpTl7zPG8V9foNM3VyhVkrd77LClUFSieB/d74VffL2ByWgY99sfRbNxpsXnQtuE0WkUGTFAysX8wI0D0Adh3O0MkWXmriU1dr4nQG8aVKcTr/rqrRKIEpZjHefyaWmFEewp40tcOrkZ86cpQusH+G7NjW6MQ70GDxwNj7/gJ9anIuOQE2vK/2TlG/PWMG4bs3HSaCjKy/IMUfhWoyODMvWa2nIT5MGvDuEZRTFGzA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzRuQjhKSC9zQjBrVEdRRnFnemx0emJoWG9wTVlFQkIrM1JsejhnR2Jaa21l?=
 =?utf-8?B?S3RZUXhES0MzMGh3aDIrc24ycExRNnhxRGk5b1E0UVNybEJaZG9YZmFET2hh?=
 =?utf-8?B?WTVLclRxRVdLZjFBS1Rmbm1kcUVkTGpNMEMzUzJJRTliOTJKMFBPWDNvRTMx?=
 =?utf-8?B?QllSSVRxMWtiTXExYTJjRUlIbGxVUzdKbU5TN01RaVRQcWw1T1FpWUV4WnAx?=
 =?utf-8?B?OW1vb0swS0JXemEzeXZSeTZieUpXOGdoT2ZsV3JhN0VGVnhkakIvOUNyVlVv?=
 =?utf-8?B?c2tWbWpkNUNpMTlsRjdXMmgycXNTTEZZbmFmY3U5UVlMa203N0UrS2o0ckRn?=
 =?utf-8?B?cHdxcXc4S3p3ZmJxNm5wbCs3VGdiS1lQR2pUTmNhWGErYXdCY0MwWTZFUk5I?=
 =?utf-8?B?Y3B6akdGZG9aeDIySXVucGZ3b0Ewb05HdVFDelNYVWFaeXJHODlhSURSRUtO?=
 =?utf-8?B?eW1xVmcrcHN4QUdnN0tLazJzMDM3a05yTWllbEF0bXRrNmFNRFEwWmUrbnpC?=
 =?utf-8?B?YVJyMmZQWVZBQktlSUk3ajB0clZQVG52UFV6NXJqaE1LM1Zmemw4NTZFamsv?=
 =?utf-8?B?eGRYOHBBc0xoQnFWcjFOOVpCN1JYNFVSTWZzMTdBeVBFZXg3Y1JFd3pRbnhB?=
 =?utf-8?B?YWlMYXJqOGtUSitzak9GZjdkY0JObFo5QzRPcHhsMlRJeVRVQThrQ1FXcldG?=
 =?utf-8?B?M1dueWl0T01nUW9HcWsrN0RtWmUxR3ZabFBkUW4rSERJNlZITFp0L0k1ZnQ4?=
 =?utf-8?B?RTgwd1VOOGRpYmhicVdybmJ0NGM0N0lhbHRWOUlBZkhvTzlwb1FVMkxLNW10?=
 =?utf-8?B?Y2dSQUhoWjhtQzY1aThhZndnUVBmMHV6RFZ1MWxyQURmQWRyV2lkMkVHUU0r?=
 =?utf-8?B?RVJyTUI1ZXI2dlFHNk5DemJ1WkI0N0hGb0UzUjlpejR6aVZ2WUV0T3c0Rk41?=
 =?utf-8?B?TzZqWjVEZWZGdnEvSCtPb2FrZ2RDM3k3Ly9odkRxTDhvRkRqVEpwTGFqODVa?=
 =?utf-8?B?c0o3R01LSVQyVEJCTHJMV0poZVVmUUJ3SUxYWHpxZkZ1bVhqUXZERjBvZi9J?=
 =?utf-8?B?Nk9OVFJwNXVZOTBPZ01iUWRVdjQ5VWdVYlBPYitIMjhSanFmQXNvcDRzbDRp?=
 =?utf-8?B?WlE3N2hLMCtPemRpbWRNS2x6Qld3S0hleSs1enhqanRlREpOQjlGS05XWi90?=
 =?utf-8?B?aXJRcVBBNU5tRTJ3b3ZLODcyNDVUOU5vb013YUF6NTJWbEZDVlVRRXBXRVpj?=
 =?utf-8?B?WEFsRTJ6bUhCblBzN09DN2xLVmF1bkhGWFl1OW5MeDJ5VExvUmpLQ3RReVdh?=
 =?utf-8?B?UHR2dDM1ZisrWVJnL1pPVERzNlh1Q0hxTEN3QUxld0U0Nm1OSWZEUVZpYmNX?=
 =?utf-8?B?U3J1V2poL0xBSEVXNnFpT0FlVjlrU3FXeFZrZWRxcWZQdVZ0LzYwK21lUkFQ?=
 =?utf-8?B?QXBQZmhaMU5pWmdNT0N4bVhkNEJxc0JEWDc4SnBMSEdQZTJvQlpKdklRKzF1?=
 =?utf-8?B?ZFRRU2lJOGYvYUFoUkM0Z3BGam8zOHVJSnI5NHlmVzdLdDdyRUgwazZ0dGkr?=
 =?utf-8?B?QndHN2xsK1Y4Qy9PeHVmeEtKcDdybGFHRFZHMTZJUkpPTWluZGNCS1lWVkM5?=
 =?utf-8?B?UDF0VDQzYUpTclZBLzYzREZTa2oyWWRJM1N6YVZ3enU5Z2pzQVJlOGZYSENn?=
 =?utf-8?B?QzhPdGhpNC9wRlVLMmZJQmRSWWxtYUIvTXpOZ050MS9rSTAwMjU5ZVlYMWxu?=
 =?utf-8?B?M3JDVUhrOElGTnByemMxeWtFdUZBaGhUdmdjNjJxblVGUXh0a0dJeDdVRzdo?=
 =?utf-8?B?aGRLb05xTjJxdkpISkxHOFNBRWozUi9rbC9xd2hVNERmbzlNWElmR2VnSlA0?=
 =?utf-8?B?NlRncndBcWw5Q2V3WGhINkRJZHgwbTVOSTl6dG9wekhreXNSS0wvdWdxY2o1?=
 =?utf-8?B?VTQyZTZ5aXlmTlkrbVhwVUtmU01DZkVpSkJNdisxV0x5Y3hKUkFDYitFVmNj?=
 =?utf-8?B?cW1tbVBETG56cUJ4U2h2WTdGYk03aGtzK1k3KzNqQTJBM2RCNC9yTHZuTGhu?=
 =?utf-8?B?S25QNDNCMHFsM2NiZmdMQTUxWXZnRmpQNHdsdWh4K05rNnVLaGRTeEhOMGxl?=
 =?utf-8?B?VVFmd05OL1puTlV6SlBsdFdxaFY5Mks5RkJYZ3pqeW55SXhDWXVEblQxcC9D?=
 =?utf-8?B?YkxoME81Rk02dzNNMG1YNDlkUFdHamNDdlZMaDZuaU5IM0hRNStSaEpOdnRW?=
 =?utf-8?B?b2ZKcTdUZjAwOUxMNEl4Rjh1VGphRHBRbDJuNlFFdHltWDJzKzZJTU5xNHJY?=
 =?utf-8?Q?79yTysSp9Yvmag+keq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f51adaf-bfbf-41bd-b292-08df336102a7
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 12:59:46.2291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABUYWuGh6kBBKYo4SmZxQI5PCpexzY7ggAWs06iOdkI6Y5zgICcytHN7ZH1eosVHO82WW9gk6hVydrtv//jFSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076

Hi Jason,


On 8/17/2026 7:21 PM, Jason Gunthorpe wrote:
> On Fri, Aug 14, 2026 at 10:40:29AM +0000, Vasant Hegde wrote:
> 
>> Remove the iommu_group_mutex_assert() call from
>> amd_iommu_clear_gcr3(), since PASID teardown via the mmu_notifier
>> release path is a legitimate caller that does not and need not hold
>> the group mutex.
> 
> Why doesn't it?
> 
> Right below this line is:
> 
> 	gcr3_info->pasid_cnt--;
> 
> Which certainly needs the lock.

yeah. I overlooked it. Its part of dev_data and domain lock is not enough.

> 
> In the ARM driver this async release notifier was pretty tricky to
> lock properly. It just updates the equivilent to the GCR3 entry to
> make it disabled and doesn't touch anything else. This is locked in a
> way so that concurrent domain detach doesn't face any races.

How about sva_mn_release() path just cleared GCR[PASID]/flush cache and then
iommu_sva_unbind_device() path (amd_iommu_remove_dev_pasid), decrements count
and removes pdom_dev_data structure. something like below?


---<---

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 4546f8be34ef..81da797b3c55 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -77,6 +77,7 @@ void amd_iommu_iopf_remove_device(struct amd_iommu *iommu,
 int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
 		       ioasid_t pasid, unsigned long gcr3);
 int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid);
+int amd_iommu_disable_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid);

 /* PPR */
 int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a0f149a8f825..2e7a84b614b5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2070,6 +2070,15 @@ int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
ioasid_t pasid,
 	return ret;
 }

+/*
+ * Disable a GCR3 entry without detaching its PASID from the IOMMU core.
+ * This is used from the SVA mmu notifier release callback.
+ */
+int amd_iommu_disable_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
+{
+	return update_gcr3(dev_data, pasid, 0, false);
+}
+
 int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 {
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
@@ -2077,7 +2086,7 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data,
ioasid_t pasid)

 	iommu_group_mutex_assert(dev_data->dev);

-	ret = update_gcr3(dev_data, pasid, 0, false);
+	ret = amd_iommu_disable_gcr3(dev_data, pasid);
 	if (ret)
 		return ret;

diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index 40be5902087c..43575cf742bb 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -79,7 +79,7 @@ static void sva_arch_invalidate_secondary_tlbs(struct
mmu_notifier *mn,

 static void sva_mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
-	struct pdom_dev_data *pdom_dev_data, *next;
+	struct pdom_dev_data *pdom_dev_data;
 	struct protection_domain *sva_pdom;
 	unsigned long flags;

@@ -87,9 +87,14 @@ static void sva_mn_release(struct mmu_notifier *mn, struct
mm_struct *mm)

 	spin_lock_irqsave(&sva_pdom->lock, flags);

-	/* Assume dev_data_list contains same PASID with different devices */
-	for_each_pdom_dev_data_safe(pdom_dev_data, next, sva_pdom)
-		remove_dev_pasid(pdom_dev_data);
+	/*
+	 * Disable the GCR3 entry before the mm page tables are freed. Leave
+	 * the PASID attachment and pdom_dev_data for the IOMMU core to
+	 * remove through the normal detach path.
+	 */
+	for_each_pdom_dev_data(pdom_dev_data, sva_pdom)
+		amd_iommu_disable_gcr3(pdom_dev_data->dev_data,
+				       pdom_dev_data->pasid);

 	spin_unlock_irqrestore(&sva_pdom->lock, flags);
 }



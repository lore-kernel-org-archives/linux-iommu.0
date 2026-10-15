Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3AF388869
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084454; cv=fail; b=Z+K5S8DVGciGKcmG5blwpZprL/RnSqLa9M2+dfHxZg7Ia4oDUnq8HITGtCOMlU4ltw46QxBVEYD3E9FdetUsH/JV2GktF99GUf3DlH9dRmcBrdY/dlcZyyPU4vMkURSL695gzlZkE14++JrtqxwqGy3O2hQZCQP2wBMLxrubkW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084454; c=relaxed/simple;
	bh=eI0PVtaMKPESL9uNlFGW27O0K0BJVGqYvVXFOqyIg6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 Content-Type:MIME-Version; b=fDLSKKlvWVFcMLgPDRY5WAqg7m7ZBfcXbZa7UoVUIrgCjbwSm2QmXW2K2chZQMRTLloreP1VbDTNraeWsmf4pqF8fNUO6VVy9Te+dWVkjY3HrfOBcn2jXnEfsN7wdGUv2THfFKfpaq5QazDMQM3wMFh9Or7VYM5RQHK6d9WAh3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JB70Ju94; arc=fail smtp.client-ip=40.93.196.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JB70Ju94"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYuBIoZrJqfHT6Y/EUX2HJxAYrK9t8Chss2YR14enwVqAJu055bpld1zgDQ7ewa00UEGbaj9d2doLIh8xeiq3x5/m0kn3XY0IRRRTeOuchmQTsNYkrbRNf2NEHAh3xtHT4k/F9gBE/Y58YCQN2cAwewTfey37IIw4Ark9B2pl6wChYmMrtk8USUp42WMu8xUoiHx+R9JGAF6muUQeecvJ/XiKGcg+drOAwdWp8BwSsJ3VtpSkAbjw+oPZH1+zxmAJjBDdnYWogaN6dlkMs6CmqNyMqLOvve6eHOoXUjBZQmYZqTrEPUFLbUvI8yhYLtzLx5hYLrZrTXFfM6TyOEw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YL0ILvW6y7fUGpfhtg/u/DazGsZrg55/b3rtMPnT6MM=;
 b=o7WlVUCVu6WNjN6FnQoJYGVdWVHgpSMnXhd00ealpHVovWIS/FWgqOSfnYvWXxiRxvhx0j/cM+yNR4rMhNGmcZEw7VAehTg8bUjY7vq3nFBhAaXWYzTrU1u9265yoSrZaY7YbdZl4Lnx4WeluUbCxZIBNXYkSTj3vR9a95aQXGQMj9GQibtfQEvhMzEiNCqd+OJkIyHv8tT8IKfnWqP/t/M9CJhPjdet+nhjt+UscOGgelWKnEdY9s/ogqvIQD9KTbpn7Vdxb0Asesd1Nrod86OCE4tGBWvd0j6876GZv0NfvNuWex1DKg/d62lorUyH49KxEiIfP6BPD5IbrJlFqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YL0ILvW6y7fUGpfhtg/u/DazGsZrg55/b3rtMPnT6MM=;
 b=JB70Ju94ZVRG7nn7snxHQhMKVQIXfDfJvvcOpEzXn6xF/D9Ql/Sqmfj5jz7fmd3zeV/+sTRcrnHVTQWXWlVnlBl5eC6+nqOsMJC22Boj3WJrWUuDkblvg0ImiwflfhFVatHzyabgx9B9iJegG/Aq4PKLyEv6EOsmSyQK71nGr9JwmLE0dn41WNo0XJb1nQyiPWQvK3aMaSKT9/sFlhyBkl2EqKP21ukidwD1ijVy2tYO1bdMoFf4/IIuZO39xdqJ8nH10Euu3Fl02iPTtwWayKAUH6vI2NdRRTX/IWG3ognZOBVSKCGgVCbMVymLYejTeKln2iWwx7MgOOR7IMQCUA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by MW4PR12MB5668.namprd12.prod.outlook.com
 (2603:10b6:303:16b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 17:11:57 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 17:11:57 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Andrea Parri <parri.andrea@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
 Joao Martins <joao.m.martins@oracle.com>, 
 Alex Williamson <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <20260925161142.189813-1-parri.andrea@gmail.com>
References: <20260925161142.189813-1-parri.andrea@gmail.com>
Subject: Re: [PATCH 0/4] iommufd: Keep IOMMU_HWPT_GET_DIRTY_BITMAP within
 the user bitmap
Message-Id: <179208418428.4061856.1592857570342848227.b4-ty@b4>
Date: Thu, 15 Oct 2026 14:09:44 -0300
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34)
 To CHBPR12MB731189.namprd12.prod.outlook.com (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|MW4PR12MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 214eca6b-7ec6-474e-9034-08df2adf6aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	o87A88VsEFMrCV054k915onDoqhlPUtlFDdO6FD124TUPlqdFTzfaYxUixXl64PR7kdr4ocbNZCl4U2PDGJnzNOYjnvRilTYlpA+N8i8yp/wpilo6eMtI0LBq2/yJm89qwfTz/UU+v7tFFKaGrLLvLZD2QcVyOfTKs6FWbs8N3jF/IK1oNc6CQ5wNuj8RLh9NxRM9n4hRy14mK0vh5mwhI0JTkXH3jQ95PUFZgeC7JM7Iypn2sT+c+69EJLeNDrxQWJRTdItzSRFBSMr6le0P+2+X4SHmoqGOQ1ZYByTRSEOKnBWOGQuwg1NDg5DzXYKXU/vtHSC8AK7W0RtLRun9b1zJa4QmLDcRqugZMYoqjw3x37r20S31zdmWgZNyXcZl4NQ2uWiiZ1C1HQjpdlA9rZ4tif+6qw93PMH+2llfsfE8RiPKKyKUxImmcbyWobSfEcT70Lmhg4KVRYvagHXsXfdPIywdMcS/LkPl5779LBZnwjFxD1lcP5BXlHrYj36QJfAWgw2Z5f5/bTMVkjDTmQuR3aKfJcO529nofzvj+R7AfA/xi0f03Mvmsv+S6fIBugS9tFd/rPgLq0gEGo8kvK9QOTKuTmcOtsE2X9Yhm9TxHJZrMp58CrJ3IHYUsGPxIVmbrBpYhoSDOfxMudjs/4yyuCEKiIkEp0k9BlOBrw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXJaZnVJbXBrVThIWjZtUVM1YzJrQkROOFdHaXNEU3pndFVIWTJoRFc2S0NT?=
 =?utf-8?B?UGRORkVOd1NZRUJZc01OSGl4UWF3L3QzS1N1NFZGazR5am5lUDUrazh0SGkz?=
 =?utf-8?B?WVp0Y3ZjN3J5ZjN1QzY2K0ZFQ29PcnZpSHlYMng5NkhESUFsc0FrbXZ2Nnlp?=
 =?utf-8?B?UDF2bTJSRHZ4NUI3NjFHcHRBbklIa1NwS1FOWnRPZUVUMFlhWTdFVmMycWFU?=
 =?utf-8?B?TWlJUmppeGNtVDlQdGhZV2c4K0xpbDRJWnZVQUZxL1hndkd0RTYrL0FONlFW?=
 =?utf-8?B?clFRWVJCTnNYVWFPVEcxY0luQ1YyMkp6SlhqRVJaS2Z2Um9URitGSVJKQ1FW?=
 =?utf-8?B?WE12UFUxa05VOEpYdlpDRm9DL2w0blhRZ1YzWC9NWk8rbThCem1SRVdMOHFW?=
 =?utf-8?B?Z1J3bUxGRmF4ZFVEdWRLc3RGTGxFbUxtSE1rS1dvSnErbVRIUENrT2hqcXln?=
 =?utf-8?B?WURqbTB5REF4TEl1M3pHUjdSU001UmJ0dE5jRUZPdmZUVThXWnhwenZaRU1M?=
 =?utf-8?B?U2poYnlad1RIU0x6Q3hlUjJ3K21oMDE5VzFMcyt6MUNRbU9Yd2hYWkpyRy96?=
 =?utf-8?B?RTJCZFBnUThzckV6RUJBWkJ6MUZlM1ZrdERqdHFnRXlYcnZib3FWdjVrUlVu?=
 =?utf-8?B?d0c5ZkhsVEcwTk5HUGRaUUpGU0FjNkdNLy9xeERMVCtoKytKM25FcWNnTnRx?=
 =?utf-8?B?U0ZsNGpicjViczRRNytCL2ZPakV4WjAwbG9oalNNUkNReDVVOE1Vczh1RGwx?=
 =?utf-8?B?OGlvZ2F5azRUSWJFK3Yvd3lVZnUrVG5NaGE1VDBTWTJJcnBQcFlLaCtWeGhT?=
 =?utf-8?B?SzFienNjaHpJOWJ1aGNlZjU3a1dTUHh2bkpnQ1ZIZ1A1K2dTbTdTc0tUeW04?=
 =?utf-8?B?QUt3ZHQ0SEQvN2hNdHVaWGtMbW5BQzlocGVkZEd2SndrQ2dTUFc1ZVFnYWdq?=
 =?utf-8?B?eTFNdGxCNHZuYXppemdFZ1RGS29KMlIxQ0N0RDVsOVUrRlFJN2JWb3dQZkhs?=
 =?utf-8?B?dVhUQlVxWWJwM04xSC80UUxmb3FrRXRnTXZhL2paZEVvVEdweUZ5SDRLMXBt?=
 =?utf-8?B?aWZXTVptREFpZHRjK0lHTkROUWVnZHpkNWgzeUJTYzIzdGg3cWd5eWxLSERI?=
 =?utf-8?B?RTFQMkZ6ZmkybVM4UnFmS2VhTVd2ZGswVXhXKzZVcmlpa2Q4MUl5WFEzcmh2?=
 =?utf-8?B?UHRvK3RtZGcwWVluZVlzUVMzNytIL1FqaXZTYVptN1MxY0o0TC94NkJjYzh5?=
 =?utf-8?B?VVpxZ1Yvc0Vjd2F0azIwaFRvbHU5ZWFNL09BZFBYT1lIR0svQ0ZOV1cwbnpq?=
 =?utf-8?B?dXVFZFNiYVBLck5pOE1zSGFmZ0NuSGg1V2N6VjduZnJxdFh4ZzVLYWxMdE5V?=
 =?utf-8?B?QnAxV3lUcTZWWU1XTVVLbUJHeFkxbEdTeG1NaFUzUHhnN3BaR2hOYU5taHdG?=
 =?utf-8?B?RUxYams5eGFTSHJlb2t2Y0FPaUZOSnV3Sk5kNjZnZDdzaG9xK2tzcGFKbWdJ?=
 =?utf-8?B?Y0srUGRUdXgwdllTU0F6U09Bck8rTVhvM3YvUGVSNEE5TGNHNUJ0ZU9Vcjc0?=
 =?utf-8?B?S1BhMzJPNis5VGJVVlhlMnB0SFYwSXVJRjE4SjdqSlpEa0NoV2RuUmRCNVJI?=
 =?utf-8?B?Y1BCdTRXTnBydVZYcEVHVzd6TUl6Qy9GeVJBUk9rakgwaVBOOHNJWmtORCtt?=
 =?utf-8?B?dXh5UzhYYmwwcU9YOERpcXl6R09yUGh2L3krcGpzSXNQdVExam5jcW1XeEhu?=
 =?utf-8?B?NFZPTFBXa2FjNTdOd2dYT1hXeTNieXJpTzdxbkNhejE4bVFKVlhQSm1LcnlD?=
 =?utf-8?B?UGJMUG1IWEJxanNsN3JndW9pMHg1RE5MaldETCtIVVo4QndOTDNWLzdxdk1T?=
 =?utf-8?B?cUp6eDVKSkNEbnRYNHVZTllCL29PY2lZR2taeENZa21uZ2lMcy80RjR5YjJq?=
 =?utf-8?B?a09Ua0VpMkY0WCsrb3dpQnByMUwwSnFBMDRLdHpKcjltc0tIdWlwNTc2WUN6?=
 =?utf-8?B?UUhaYkpFdzZ5VTdrcXRuYkJzRFVxV2RpZUlJb25xREltNWUwd1prNDJ2aHdW?=
 =?utf-8?B?ajZTK1ZHVm1mNlhLQVlSZjFQWGlFd0RVeHVkaEJSQ09SSWU3aXpIYXVlKzBW?=
 =?utf-8?B?b0VReVJJTlVpVzUrVHRtS2FJSXB5NG54cVo2NHVYbitXaXI3ak1FT3piYzBq?=
 =?utf-8?B?NnMrN24veXZMYitvcmhFQXpmWU9zbDgrNzVoZW12eTRNcHpCYjZ3Y3lpSzJN?=
 =?utf-8?B?NFg5ZEpwYlNOVTdDZ1hIOG5WSWtNdmRvRU5wYXBpVUVDWVZXZGQwNmtwTTN4?=
 =?utf-8?Q?IgtPD4zGHGu/HqRCza?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214eca6b-7ec6-474e-9034-08df2adf6aef
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:11:57.1094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDToDIOrTiZKhj6aYU/Dy987TgS0pYD7qdpQVqx2ymvj5pvXN0UdgWJe2hKnlFvY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668


On Fri, 25 Sep 2026 18:11:36 +0200, Andrea Parri wrote:
> iommufd: Keep IOMMU_HWPT_GET_DIRTY_BITMAP within the user bitmap
> 
> IOMMU_HWPT_GET_DIRTY_BITMAP can set bits past the end of the bitmap the
> caller passed in. Two cases, both fixed here.
> 
> iova_bitmap_set() does not clip the range it records to the bitmap. When
> a query ends inside a dirty huge IOPTE, the generic page table code
> records the whole entry and the bits past the end of the user bitmap are
> set, up to the end of the last pinned page. The helper is shared with
> VFIO DMA logging, so the clip covers both users. Patch 1 fixes it and
> patch 2 tests it.
> 
> [...]

I picked up this patch:

[3/4] iommufd: Reject a zero-length dirty bitmap request
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=f6b3fd8f573e801066c21b2aec3d2e949e61e48e

And revised this one:

[1/4] iommufd/iova_bitmap: Clip recorded ranges to the bitmap
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=e21952d72b4740f08a272d694cca223b6b0099ca

As discussed.

This test doesn't work after the semantic change:

[2/4] iommufd/selftest: Test dirty bitmap recording past the query
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=00ee161c665f9e489bbd53c9185804d12e40d365

And I didn't think this one was so valuable:

[4/4] iommufd/selftest: Test a zero-length dirty bitmap request
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=9579527d416d00272a7e3b84330b6fcd9ea8cc31

So I left them out

Thanks,
Jason


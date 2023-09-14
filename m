Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51514CA71
	for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 08:21:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkPBFDR6of36aJEoWR66WqsNfAPMCdshd5npGjreYcAeizqCxod6nOIUim7E9X53KxHO4GIq5acGiDPguJ6UMsOQkMfBYZWGzSNAgHl7dSWJIlJ7BD5D9vc2Qye9kuMKB2L/GG1C833HDcY2zcJrRd5mfSsrII578QJtlprjhLs+3vbAFzFadxNAoTRfeQrH5yT0lHFaMLOrxvd+m2YbKiJULTOT+vjLPlfgiCDAW0KXrP9QyYTRDy5qfZPXVqPMB2gj0PE8vzSd2vbvkUr2W+lGvgq3HqTyTM4dbCsMFUcn096R0yrkt3voXWulM6gNAc4Ji0BiwtIElMg03/Tiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7HwPW0dg6GZE6y3qdzjKUrNb7l4QHlRtj4cxXXRPC8=;
 b=jBi7J3dlpYiVWU0Z2NJUmC6E2ILFWvfbl2t4UN6PK+GdH/BcC7q1TXTCMcTGhEclkffjhBuZFc7jey+JtoVIClrVbsbgID7YYUedWNX1faFp2zq7DTqTsC/o2yAZbYk86xC0SmZITrfL/Tjb92tL9Fiqoq02YqSfJU9V91532maxsQEYAEqds5lsi9cs+zvrjsPEpO18ddBfndqwItUT7tgwknD6mgOoNLSGABMe8hOobho5Km/LAaUydP5sMWPa0aCDgUc4ApRNiwH9NlvmFAJL68iteFu5a2y0YrNWAoU4RnvsXUZMxtnr6OGgWoVRnX1QIe3IfS5HrgZeqE60Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7HwPW0dg6GZE6y3qdzjKUrNb7l4QHlRtj4cxXXRPC8=;
 b=Ez6JJIGRL7p0q6w+foynfcAiCYt99bT/UY+PO+sEng7Z+BSyd/vyK5bzRPR8D2OEoL0K90Nhs6ygJy+gfXAj+UAsQaS7UphbOlAzvL0SZm+Nkooztsqj+eY2LJ17SAoEWpdXJMnwPOf6tsxDgqUw7ZeCvzm8bbaK1xXrHlu51Sg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20; Thu, 14 Sep 2023 08:21:53 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%6]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 08:21:53 +0000
Message-ID: <c2c8127b-5cf8-e8d9-e2e6-b1aac6c7b577@amd.com>
Date: Thu, 14 Sep 2023 13:51:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 02/10] iommu/amd: Introduce get_amd_iommu_from_dev()
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230816174031.634453-1-vasant.hegde@amd.com>
 <20230816174031.634453-3-vasant.hegde@amd.com> <ZQHKPGwp02jUXwuZ@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZQHKPGwp02jUXwuZ@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CO6PR12MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: e7cb9ea7-9566-4831-cdc7-08dbb4fba6a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bNT9C3T0f8QDCEc3WpO/mkb/k6aU1mbxgQEKcqFiM0wDI2PogqU0Zpj0gi4VIQki9ClVJlqS6TjHxGFt/++nA5hFkme+DYUpFe0Qy+G8fdtcReIerxHio1Ab3qPxfg9NRTU350qlG0IrEZ3+EmfGf2PqFOYiDxnCyjzxA+2+2lWvxMb6QoDCWBl5Ggkmnbnt8zoOMAZQvDxfjM6uNTTU62W6R12KV+Mj6xwAD/J7oEEFrMZdM2V1YM/ByErWrv9nRG77AKnDxCLorXrc4jAcklVfx8Icgt6DTnLVmqVGK5Ndhc7NyjA+53HvMujI4c2pKPyO/H7SWnYrGQgGgek9IAWlWdjOwXtKxLgFA6m8eXMfhZFK9RE9QLrUumevYNSURfH43F8G0aRaNEg0/UtgkZWvQv69hTZwmf11HmUCpPJcZ/D7EGb08OICoggXJ+zfriCd4ha3PR0SvDLxAA4p7u8+R6TYxyBlgmD89k7/B4bVDcOcD0D43aeAjHDGYl5Un4xoTH4IfKaukqc3onP0WqtZ4oDRFsoRvld2A0vLfaxE0V/lVFclt6kGWQ+qmIcFePSHbWKBbuBNa8dYhts3X7AVVlt/MOqkhA68wRnzIS7AVN+nzy6WxdSmrRQzJzr60WWpOletn++si+QH+igbeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199024)(186009)(1800799009)(41300700001)(8676002)(4326008)(8936002)(31686004)(66476007)(66946007)(66556008)(44832011)(5660300002)(4744005)(316002)(6916009)(2906002)(38100700002)(36756003)(53546011)(31696002)(2616005)(26005)(86362001)(478600001)(6512007)(6666004)(6486002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXd1RVlhUklKZ0xaMVJWMXZ2TWRGRzl3a2oyMDlGZ1A4ZDJKOXlsVVJwbCtE?=
 =?utf-8?B?ejBSdURleEowNXMwTTdCalZRZlV3NzdoZ0JTTUs4VitsblpGT09mUFJON0dY?=
 =?utf-8?B?RlhmT3ZXcWMwbUhZdzdaWnJYZXZYNkNEMDRwSE9yT2hIbkdTM1NTMnY2UDcr?=
 =?utf-8?B?cFYxWlRxT2NxVmtmdmJaZUtsS0dMamEvZkphVlFtNERnaHptOFdKVmdtNHdp?=
 =?utf-8?B?TkVnMzdDOEVIVDNoTWE0bnFkdE9ybkYwMHlHZ2lCdXc4M1FzSzdpZDRqU045?=
 =?utf-8?B?NnlPYlRUSmJaTjRoQWxwaWJvTnpxS3dJT2lHNGpXMFY2KzFoeld6K1RSZmdW?=
 =?utf-8?B?akV4MjVaVk5VUW4xcTdKZGNKcUR6KzNuTEw2TjZER295R05zVXYveXRaNXdn?=
 =?utf-8?B?eVhIUjJpZHFIZUpsQlhGamg0RDdnR1FZOGdWcHBja0NncHhrMFlnMEpGcC9P?=
 =?utf-8?B?M1dTMS9lNk5EcTRRUXk0bkVxRWgrNy9ZZXBLbFppYlA1UWFreFRRQXpDR05Z?=
 =?utf-8?B?ZkR4SkVFOVpkcFlwWnVQajBDZzJCYVRZaWxtdFZFaEVkTEdxaGxDQ0dabXJE?=
 =?utf-8?B?Y2FaSk0vZGZaNTVVT1VrR2tXVDJtWkRTQmt6M3F3bUd5MHppZ2FVdXpYNXNy?=
 =?utf-8?B?ajZTZmQwaHVLeFVqNnFVSEpyOHFqTHUvWnJ3WlJKVVpHMWpBUmtrOGxPY1dI?=
 =?utf-8?B?NUZmR2lCRXhQN2FMQkcxQmxrNnlQcDUrMGpYZi9wR2crTm1uL1J6a3NXNm5v?=
 =?utf-8?B?Qkc2c3VWamFjQ1NuWUROKzBVWVVOVm9Cd0JuNHdCbW0yckRlYVVrQWVqQTE2?=
 =?utf-8?B?OW1xOHVIU3hQWkc3b2xyTHR5VS9pZGZQREpqanYyQXVSUVI2UUJsNFNmUXFP?=
 =?utf-8?B?aE9JNEZNYmVRakFQbXZNUG1rYzIyYlJQR1lpb3B3YnFCQmpyNy9pUWhGa2hI?=
 =?utf-8?B?bW9XM3dFRkNVSStIcGhiem9aaldsZVQraHlzd0VBb1R3YzhVdzVXbmJ3Q0E4?=
 =?utf-8?B?YTdwak9ZRnpITlBDeXpEaldmbloydFRFUXdvRE1vR2sxQWVRbzhDcTZOYXh0?=
 =?utf-8?B?N0g5Nm1rVkRTbE1BMDk1MUt0NWwzN3k4anNMOWF1WEd2MTRLNTdSTUg1MWxj?=
 =?utf-8?B?SWZSektIcTBramZtWDJqQWIwZDZaQk5zaDJTTURFUmJsNU05N2xwejRaSVVY?=
 =?utf-8?B?cDNvSUkvd2ZIZS9pTkVHMmp3Yit0MjdqSGhtaGNKK0xJQVc1MEhheGN1SE9j?=
 =?utf-8?B?WjVlbzZpYkFpekhGR0g4eURuRllSZ01xVkhHS2NsNFNpM0JHOS9hcWs0Slpk?=
 =?utf-8?B?K1oxQ1lKb0dKRk9aRXNYWFlQbng2WTR4VTVNb0IvaHp6RGV5dTA1d3Q0OXd5?=
 =?utf-8?B?V1Nic1hyTXBXUG9CcEdnK015SzFESnhnQm53Zzc4SDBTL3NDRTNFY1MxQTRs?=
 =?utf-8?B?M2ZFc1BtNEo3ZmZhN09KZ3U3UnNDSFlmRkhhZGdXZ1Q4QTcwMFRCREgrNDBy?=
 =?utf-8?B?V3ZwbEtQUndVaFZMdlQ4SFpoTTFTdlZWR3F6a1ZIZGtNRHZRL1hLWUxjMm5q?=
 =?utf-8?B?L2xZMzVQb2RjdkY2RXVoRGpVT3Jwcmo0ankxeit5VzV3OWtVd1NiMFhxNnV5?=
 =?utf-8?B?Q1p1cHptMElXb1lYUldUbUdscEk2QWQzZCswb0ZyRzZDNzBKMHo0bjZudjJa?=
 =?utf-8?B?MmdockI4Z2phVGkwV0ZKWk1FSHNjcjZtSnExZVpSSW9iSk9rS0U2RFBZUy9w?=
 =?utf-8?B?WENQNU5PWHlESkp0eHA2cDMwbENRMlFLbzhMRVRTTGpyUEpPTk1SVnpWTjlM?=
 =?utf-8?B?KzBzRkVHTlZPa2NEOGJUb1dBazJhK1h4QmplZ0ZwMnh5ZG9xVEd4TWhHOEJm?=
 =?utf-8?B?RzlkUEs1aVFvZ2hZN3BqcnI2OHB5cXY2cEI4TGtad0VCOGtHQmRaWHF5TGdY?=
 =?utf-8?B?L0xYVHp1UG1oRGpCR2dGVWM4TW5LbzJTUDMzdUNRcjJITkN6MFlWRjlyTDRt?=
 =?utf-8?B?aEFQR2E3ZnVZT0UwazBXQ012bzNXcDRnYlk5eTZBNUE1ZVZRNUlWMVlSTjhs?=
 =?utf-8?B?S3VobVJhRzVYYlJCdFlISmlvWEpBV2x1Rmx2NEttNUxtTWhlZXo0K0dNSjJL?=
 =?utf-8?Q?3CkpZAeNFrIDiaJu/5f8P6EoU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cb9ea7-9566-4831-cdc7-08dbb4fba6a3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 08:21:53.2539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJ74hoM/Pj3TY+YXC9Xt/Qxd44rO5hT9ni7Nx/PsyS9jnkToDE7YxNjvUf864fb57SuIgpzw1trccwdvq4Di0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410

Jason,


On 9/13/2023 8:12 PM, Jason Gunthorpe wrote:
> On Wed, Aug 16, 2023 at 05:40:23PM +0000, Vasant Hegde wrote:
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index f1e18e81fca7..5a44567678ce 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -446,6 +446,20 @@ static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
>>  	return (struct iommu_device *)dev_get_drvdata(dev);
>>  }
>>  
>> +/**
>> + * iommu_get_iommu_dev - Get iommu_device for a device
>> + *
>> + * @dev: an end-point device
> 
> No space before kdoc parameters

Fixed.

Thanks
-Vasant


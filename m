Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3352C43305A
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787354157; cv=fail; b=bY3ACHFw3m9wfjP7t069aa5sOJb7luTfbpab8bwNTcuEFtwYwz4QlVJtJbDHmMTsvLmdh1xknxAkhhlKqWnbPnHXWflIfoQ0h+KwkIUucfUuvc0Y7z39AylspFvXN6LZsWMnJEvOuxPGnfLQQyZFIkEzjnUDQTElT0Ca5ySiA4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787354157; c=relaxed/simple;
	bh=zkjHXU3eCbn/alDbuYn7YUm/uZdu3C3i4BKw57gnTBA=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=bZS5JMPzgqR9AUBGpELjtJx9nOdUKNxYsU6laTNf5VPzT9HASmfsigxBIlVI9prqNeH7oNujN0/Ax/m5O8eoK+OYQJ38Wsrf7vHLvonA62Zq/y91a0D4tPlc+/sxEiKakx/qhINxQWXb86bpngQYrcNHsahTRX68kGF+4xqbico=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IvQzw0m3; arc=fail smtp.client-ip=52.101.48.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IvQzw0m3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoSKRi4mwfz+xN48KOgQl24PtdanBnQlHpBF66T2v6rJ4pbJ895s5OulzcqK5Vifgl+P2NV2YUNpbYLHllq1cLXVCoWA093Y33t/mk5x/L6g+5X30rFWe27uHDezN9PM+l7Pyx4AIM8X5anc/d6jgmW9hWALqsSYm3tm5Jab7J48Z+InF4xuYUwTlD6bWGTz9x9GeK+ra2OSkk6mcqg/0wixrDnZ1YjPCyNPuTAGPLDNpAf5ra/+OzQsYwkAHtkbBh3n/t9dx7g7qkTW2uG6rYglv/CTeETYIfCeWaHx5UqR7XHB0NeRyTm9cwvpjZ1CyEjQSX5eT0oRvsgmEzyCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvJWdWFHG8UJGKc5jlZogtcnoVtsAtW1CTl522vLZW8=;
 b=YDnAY5XM5RFMERkeOuZYs63bd2rcDak3n2gZWoS85FT6WBNg4X9seSe8jN8t/qvaA5Xf3bObShKM4cY74W/KZvpxSrKWftFc620IuEQ0r1MYHL3peTDhHGNuE6diqvaarDSzLUVXUFwg8U5nzw4taIRltJwCawVFWYgHXGFJ9xICPsqrwic56Nf4+SKJVkprLqejZ8G7B0muzGn5FIF0BaSPKY9yANs8mSg/ixTsYsmFTndy3AS1HhIp7BHNtxytlZ7GlHBtbekX1hCdd+btZfN3huZOUAwEuf/rDaVKrxGJPBWJthh7oe5wGl7uAZeLHggdd4pZCuDqgGFKJc9ujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvJWdWFHG8UJGKc5jlZogtcnoVtsAtW1CTl522vLZW8=;
 b=IvQzw0m30dUE4hQ+wIVkfWEAqtKFB/YqH3uPXwDf8Y6nubwUrjsAP/wdxlX+id2FSYpZGjBwrKCJEk8M6yX+JM1+xKtgwahHTyTBycVy5YeneuNvsA5sbnUv0hHf/eJtRWcW89dHK7TN/g/OvM0RMe5fqQzzxoaNAX78seuYmOFAQm0+NQ0iWR29RbGjmrrRwo+vWdZTOWc45zJUeLAFiMi4eo28AYRTiIIpT0el7pxjY1wKoOzY07yf9qZ+pYqQiXJedN4tT4LLhUZikjz/+akt7KDt46K5HFf8Vgc5E9WMRxBVO6QAgT7VF3lBcWtN4wK2th43pdHRayYrw0WtJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 23:15:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 23:15:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 09/12] iommu/arm-smmu-v3-kdump: Implement
 is_attach_deferred()
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, 
 praan@google.com, kevin.tian@intel.com, smostafa@google.com, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, jamien@nvidia.com
In-Reply-To: <eb795edf2598c6df57122cd5951393ac1a860bcd.1784663184.git.nicolinc@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
 <eb795edf2598c6df57122cd5951393ac1a860bcd.1784663184.git.nicolinc@nvidia.com>
Date: Fri, 21 Aug 2026 20:15:26 -0300
Message-Id: <178735412602.18212.5709943748630447883.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f682a8-563b-4b18-f496-08deffda1809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|56012099006|10067099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	O9yJK5M1M8lR0tTZnxyil3FSHh0FEwp2o3WW4S9w6ruWyZfKCdGc49Vw1Xs7wuRkkLCa34NET2SJrRkFZ4LRpWHo+CjHGuwvbJA/GNEIUOuchICFa28qTm+Zw7ra/QbHxFhBkMcvncStoSQI0rFioQ/sRNzO9GyAGbUihGsiuhe2GovvZeulVBNKalm0/JmwQYBX05JslibjfUDl0cWWaYjcLuDjWh92t3bNC7eH6nBqdHZ+0kAdsjwsurnuArZwxJD+982RwdUw4IdrWteFttYWQmJFs4xOOt5zZvcakINzvDpVXi6lbxQPfdfrUmf5e0Fzj4hOqVLrWLiIAYFtIKpViyN4cFtRpgcoF6MyHQU9jSoP7U9Di3obcmemN6b6o7DHLko1kyHRFbnyExL0DCfC64IOMGSM3dQ34bb7VETIZgONF3ORBO6rH3v6nQSim5CoCoojxIwWdvGFsNWrVXnfZvAEZip4nZoTS7Cc3zroUkaL3qNupO7DtABxdmnA8/5dMRMFleNUs9gL9XNyQULDsjuTohQtQSvW3ygyi9dZX4ka2FKAXceGiuy01l4ueoNyCcpMJ73EH5dEsTHr8puPas2+lTnuVLSmj2qrRjT6EdZ5VxTlvadA5sNli9bKrbr/YNQ4gUY7k4zdNobK7zebbZ6K+aBiNYcfXAXlFFA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RC8rMjJJWGg0c01tOUNoVkRWTlpZVGlKaXMzeDlDMDhvTWFsTE1DUVhQTVRm?=
 =?utf-8?B?NEVPQ3lIVnB6L1dKTG9mVHhTb2M1ZnlXd3VjUWI5MGhCRDRndVdBc09VNGtT?=
 =?utf-8?B?UTZON0tjc20wODVkZFNkMGhKdURXWnFuZytEbTVmdHBJeDNOWWs4NnVBL3FR?=
 =?utf-8?B?dUVFNUJTVFBiNHJRdkx5R1dpVUsxOVB6TEpYSGNhQjd2WSsrV09HRVQyajUr?=
 =?utf-8?B?R0N3aDk0clYzMHpUZWZMY01aU2RIMkt3V0tiN3ZlWTVPMXBQcHhrNXpzK1Ex?=
 =?utf-8?B?R05NK3dJUXF0L2FTb2J3T0p4RlJWZU8zdGNrU210bWljc2pkSHU1cnpaamh3?=
 =?utf-8?B?QVU0TTh1ZWZQYjQ2eGF4c2tpUXdwNUloUXJQUHNqOXJGQUMvVk4yQTNFRjN4?=
 =?utf-8?B?ZUpaNStzZlpvejNZVSsyamxVeWNEM2ZKZm43SXo2aGVWbkNPeUYram1Pc3A0?=
 =?utf-8?B?NVJkNmJTSGk2eWl3MlhpcVZGYURzeDBveWVYSHdoUGZIb0FqOEZhb3J1UERT?=
 =?utf-8?B?c2kwN3ZLRXJVbVdSTHhSZnczWjRsSnZqUXk0YlhRMWl4U3VwQ2xOLzM4c2x0?=
 =?utf-8?B?OWovc2lBeng3TnBpUGt3YW9SOUk4dHBZdU9xSHBCZW1icVNuK0xCbUJhMU9H?=
 =?utf-8?B?T1hGMysyMWFXQTd3VDJVQ09sVlMwYjlHalZGYmF5d05KTGVvQTZnNFhqRTVZ?=
 =?utf-8?B?NFZvT3FsZlJzWjErOWZiS1VhaGpwU1pySHRtVzBiQmNrekMzd2JRTjd4S3Ey?=
 =?utf-8?B?K1ZwVFEyY0RhcTd0alRJKzFJRldQajY5SHRMNGVTcVM5cUtlZ3VSZFoxMkw3?=
 =?utf-8?B?V2lBL2tQLzhTUnlTQkYyWE9rcU02ellyVEtFejdmZzV3T0dkT1kzdi8zRGNR?=
 =?utf-8?B?czNwcDVTUFE3eHlGSHFDL2tNUXJuRzIwM1VvS3duODBvaWw1MEFOcHVEdGRP?=
 =?utf-8?B?QUZSVVV5SFhUUkJabzlJVGhJbUkwQXcvZmdvZ2VMby9SQzVjUTRXRUpzSjNJ?=
 =?utf-8?B?cWp3K3A4bEdaNjdUMlUyVklpVHNFUkZaZXJJUUxQS1ZqRndQSzM4ZXUrQ0Iz?=
 =?utf-8?B?eFJBL0FSUExGNHRqdmgyK1V1MjZrblVkUzFNbkZZWmRWMUFvbkErVnNGNUJx?=
 =?utf-8?B?bDJ0b2ZEZW8yTHgxbFRaQjBsaDkxU2pkZzFWS3hXMGFnVTJ1WkNxM1Jqc3Nw?=
 =?utf-8?B?MHpQR0ExRW5yTE9CQlFJeEtuaUtiakVzNzYwMEZkYm1kcEJBWndIQTFFN1Jw?=
 =?utf-8?B?ZlJjSWEyUFlVM2MxcDhLZXRlNittL0tRdHVLeEljN0ZTWk5obGFKcGVLMlNm?=
 =?utf-8?B?VWY4cEZhVWhjUThjZmd0ckxabFJTZjV4VytPNkxuYlpaZW9BUmo1NngyOHRQ?=
 =?utf-8?B?Y3I2ZHE4dDBwaHlLejlSUXRBU3NDVm8vVGNlYlFRVVBQYXBFOXhUVXdORFlM?=
 =?utf-8?B?R1ptdGxuRmRPZXFrUHdFcWI5am5Gd2lwY0doamRLVXhHcmUyYnFQZng1SkZ5?=
 =?utf-8?B?c1lJY3oxcUt2VGVXTjhoUXVBVUJ5N0h5a0IyaTR4Y0ZmdHFZSXVXWHQ3cjFH?=
 =?utf-8?B?TXdYNjh2S1duR2RvV0pVQmI3MjYweFpRS3hCY3YyUmtGTWVYcVB6T3dMUFJx?=
 =?utf-8?B?RnFxdUxSU3puanhpUHZMWjAxOXZkdENRS05GU1l2emVJOGp0Q2VkOHdlTWNJ?=
 =?utf-8?B?dklYYjBiTS9JKzQ3SGs2UWVyZW9lT1NJckQ0eHhjYW1JeTQzQkdVZ21zdHE2?=
 =?utf-8?B?UjdCeHpmZHBSYkhRM0lCT0FDRTFsY0YwWDhhR2xwYk5iSTlxVlZKTStMRndU?=
 =?utf-8?B?akFVdEJaN3gzbVBiR1lmcFhxV1Bpc2JldVFxbUxjNE54ODExSGxkNkN6TUFH?=
 =?utf-8?B?TUZMWHdvMVlURWVmc29Ba1phWEJhSEYvcEkzNEJ2bXlUSytuTzUzZTNPYnVT?=
 =?utf-8?B?eHlEdjJHMXI2RnFCK3VicENYeWQyY0xOZ05jekNtQitlYThEMGd2Z1YxcC81?=
 =?utf-8?B?SnIrTkxCVUZtRHJRMEtlMDl1Wk4xUTZGVUk2ajVyb2loNCtOUFJCbXdENUQ0?=
 =?utf-8?B?RVZQVGFWa1ZsOFRWYndrbUlLTE5OYklIcmE4eXR5amU5a3NvOWthcG9Ca005?=
 =?utf-8?B?SFBEOEwyTWtIUUYvaXVPUzJLdHRmUmtPK3FCODZJMGV1SzBscC9vTS9MYjZH?=
 =?utf-8?B?bHczam56TGhxaDduR0ZqTU1RMzc4WG1OazNpSE40UEI0a1RieUpPc09JOSti?=
 =?utf-8?B?b08ybHZYbmRSYmpFY2M2ZUIrQ0wwYmliUExrMzRBb2VRMGxlV3Jvd3RXTThN?=
 =?utf-8?Q?PMfiOi3CV1suhLAfGx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f682a8-563b-4b18-f496-08deffda1809
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 23:15:30.8279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9ocyYLbrFp5xcaODgTr0GMVCnfJ3944CCrWvHIyVYpVHcNFZ4lJbg0vmSEn48GC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

> @@ -1276,6 +1292,12 @@ arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline bool
> +arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
> +{
> +	return false;
> +}


?

Looks OK otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason

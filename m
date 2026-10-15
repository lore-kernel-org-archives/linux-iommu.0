Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012010.outbound.protection.outlook.com [40.93.195.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4EA3E8330
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084158; cv=fail; b=lSBEbFdk0g7fr53X29JS66JO0Ki0k1/h1amBXfq7fytGLZDu59jmKB59cAifBmUEW674Zj3QoUODDRxuKSQ2PO0I9eHho6aVeeIGZ526QzceDal0oJhmJDxe6cktOEmqLcwXWT4xx18B4OXcEQlkEFNqZINLabEZUF4+vSTOHns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084158; c=relaxed/simple;
	bh=uqIKC9i1IiWeSdfywwUqs00EwTmwS4rx9Bo8Bt2RVb4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 Content-Type:MIME-Version; b=MneSZn0eZXZl8LOwF2Z8zJXE/Hepf4HxOuqZTTZJt80rObL6VjsP1jsmjXrKTBWd0eFb87gn2IBIqWhHtA7gjEk7W+mcBhM7brT2fJKEJ5sDZSbji1Lgodp0WPmDqvO5XsGyytl6iyUb9F66iAhqfgbWHqYZadv9i3sB3MEjNbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k+y7gTIX; arc=fail smtp.client-ip=40.93.195.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k+y7gTIX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmSyS68tYUyFfqeBljJk+EFardz1IgAFKU+vIRbudJWQPiAAdNW/YAsK2eYYi31yhhCdAtWKrhotAb59PyYY1eGwJkzZBWAaBuzbPep22c4AEFdLxTyelnddvtSU26A2ULuHcUFplJaJctdL51Vdxy7McGv6x5Ow9sQrjj3Fndi/N38FKcDPN9MTEYOVZ8sT0Z9e/swawqN7a/WH3Umvke9jA42Sz+fgWa/XDQKjHyj1AoTM80epHX4LOOwTE96zYTFb7+5giivQI7vrPYdOL6Mkwdr145DzvriMZLv2R5KqXXoZ+mqPgGS7qB4+w07dM+qFb1Bjtt2UVqZYMBSlUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/w9V0/QssFGJbb+qdU+qhW5/Jm43YgxE9yZ2OJLzqJQ=;
 b=GJceG8J8pg81KngcwdlBULP2rxGdpluDQg1ofehYm+KgGJitETjaTD+43bNgo6rkrksLNxUCCc9Pd92pVEiyC5AkfGbMLOgrxkZBhkZq8dADvNROQoFPpzuB9HSbhunbrALVhazk3v6+KxFmlw+PyrNmUhkklh9mHwTOWRyLYENRwev9kMIfO38xjukArRrGVBgfit/NA4+/CEMnMFX618F4CW2BlODxE5eOcx+9zXHq7eaVKvAem/VuDn48hCaas9s+kSZJ8MVzmKkyLy/1vvl25DFq7LOxs8U1Yg7s89FZ+ZC3cHZr6PP7qsIqvBtTYb7iqqayy/Z2LxEjy3qJYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w9V0/QssFGJbb+qdU+qhW5/Jm43YgxE9yZ2OJLzqJQ=;
 b=k+y7gTIXe2/3Ogfgs/E6odf0seYEKU7WJlh8MoremZrx4FFiSXgjujYVl3F02nzb9S31ueBGNxPzi6Nfjpkb5JOurXoi2GOdaedpdPBXU4NIB8evHxRMl5Eg+h/IQLE2ejoeZuIDLrPFrlbghVStrSuRIabnhCWe8lMHSYe62ZjuN9ZCQ8tpnd8mdbFZp+VFmQBJr+USnkmEw51q2Z7179nYSc876ZWPdJR1jvawL3jomYbnil8fmPLofbukOu6+U1p00a86KJFzwnUyv4W2rPlZfiqs7NOMVqSXU4WyLN87xtyLKf0tNd4zMR4SntA6Zl/Cqq+meGM14jy9dvn87w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SA3PR12MB465449.namprd12.prod.outlook.com
 (2603:10b6:806:53a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 17:09:04 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 17:09:04 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 samarth.colleges@gmail.com
Cc: Robin Murphy <robin.murphy@arm.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Kevin Tian <kevin.tian@intel.com>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261013171045.3104619-1-samarth.colleges@gmail.com>
References: <20261013171045.3104619-1-samarth.colleges@gmail.com>
Subject: Re: [PATCH] iommufd/iova_bitmap: fail GET_DIRTY_BITMAP when a
 bitmap page cannot be pinned
Message-Id: <179208409447.4061856.18212440462229709441.b4-ty@b4>
Date: Thu, 15 Oct 2026 14:08:14 -0300
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BL1PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:208:256::18) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SA3PR12MB465449:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d688b5f-1a08-489d-2d3a-08df2adf03d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mWU9TYRvSrM63KPoS9cYlDwKSgoPPsBC5GSzUlKZdt4aKxNWPbU4aUjdy0l16LhzyHobzfnZq2Jglq3BnqwPRrKEGkxvZ5Bnqw/vXcsjOEl1d3gsbB7pcQr1JWnyuVthEZOvQsAjNadAKMdQpe42baK40ePLquVK5AerWa4j6rnbf3ApfkG3IC26nW6vOGjOj4ZTH43rMmGlkQwU4J/kLAskH4hpGEt8GXenhrLqYw9kmiXHWKPMoWZDk98z3VXFsLwIvhJnCT0TB+Z8TB1V/7na8gfc9QVV8Xq39dy6rgqpi6cyE7kBKcyLWoQEyIKFU/jqytR92ELlOam7NTGgroVZO1hZV22EIbv2zhMD4irUvQflkjMPINlYS/7pFfgOnRVo+rARk1BtRPhhmMEROJCi0OCtoy65lnnup6ALzvF9BnRx24vedOiLrumh2WpkRzMZD5ha3xeWL5FzjP1yRr+mCH4TDk2RhT/Op85rxTkivwmlbLKhc8tk1euFx7rPtn9ri5vBtlXN0fWYDjYgk6wioA0/B+4FgXfRkOcoUVlRgOm7gJ5EKRviYF7AQePK0uLy/eU26vFMKkD+MIQErqzHnV+nKOTmsvg9cgh6IAO0G+cjBRKcf9rFQT+CMz/GKniYnk7fXdWc6hu0jSF+Ugp7RAFdT41FHV6hzNYEoDQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVh6L0RnaFl0ekJnZlg1QTEzQm9XOWk0KzMzV2NnWHFKNUd5Z0RjalpyQjVs?=
 =?utf-8?B?OXh3ZGdrUWtDRkZXVjlXUm1CUUFsNFVyU2NGVkJpeC96REY4MTlLaG13MGJu?=
 =?utf-8?B?YlZiUTd3Mm95bnBHSFhCM1ZJT3k3dGNwNGtVNC9oWnVXbk1DalpVL0JyVkVJ?=
 =?utf-8?B?S3VzUmdPN2k3QjRNd3hqOFpCRGk2SDF5SWcydmV6SlJGdWpYdGFVdHdvT2NR?=
 =?utf-8?B?enAvc0x1MGVXWHlsMmdTQVgycUcwTjhJUWhoa0gvQkxuZE5mcjArR1p5U3VC?=
 =?utf-8?B?cDA4RU84cWFIT2NZMEhXVXZqMVN1VjR2VVd6eVdaZTB0dzRSb0s2M2pqR3ph?=
 =?utf-8?B?UW92NjVvcS9wQVVYRTNpTEZDbG9XRWdZbXJWQVpXNkF4WnM1TDZBalpNTnNX?=
 =?utf-8?B?V0hvNlFYQ004VEhmRi9IV0xReUx0Tm0vMm1TMU1zb1MxRitkQzVVSU9HREFa?=
 =?utf-8?B?S2VNWVo2aEY4QUNhR2FqVEpCZWtTMVRrbHRHa2IvSnpPVlUrUFVHUnBtMWkz?=
 =?utf-8?B?Z01hQ1dUb0pmTm9wQmRHOWxORTdOVlA2ZC9Lak9HcW51c1JNcDZEdVlBcGpi?=
 =?utf-8?B?aHBvUVpGSzlrVEhzZ2p1RXV5VHczdHljb3c0TjNoSE5GMDJ1dHYrMk1JV282?=
 =?utf-8?B?QitnVjBuOUt4b1RJWW51M1QvY3NYLzV1VjNITVp5VXhHaDVydEVFUXN2MHJ4?=
 =?utf-8?B?dEVJTGduZTZPUFpwUm85emhSdW85R2JTVllGWWJPQzlmTVJobVBZMXk2VzRL?=
 =?utf-8?B?UGtQcEpaNm5aazAzR3pZcGFHR1JMakNYUEFmMFVRdzNPL3J2WFVsakdQdFBU?=
 =?utf-8?B?ME9XNFRNa0Iyd2NYS1J0L1RUZ0Z5LzB0VUxjemtIcGc3cERleHJrcG9yb3FR?=
 =?utf-8?B?RUZtcWNqd1JmaG94T1BsM3lONVFhY2hpdnh0dWNLYkhyTlJCWXRScUNRSU5i?=
 =?utf-8?B?NHFQanE2QzFvQ0lReUIrK0hNcDh4b2NlZHhWS2RJNE4xdXZVQS92bTdFbXEy?=
 =?utf-8?B?MU4zcXhKaTg1U0xGeW9qbTlWaE9lTHZpVTBqbVJpYVZtWGlySUYxemZkWWtz?=
 =?utf-8?B?NnVlZWZVcmlrUVhIZitwV3E3Nk5kUU9xck5XN2tOUnJzT1hTRXJOb2tid3JE?=
 =?utf-8?B?NUZPVVU2a3NJallyT3FGa3FBUGZuZ29uS0lPZzQ1RzhSRWxvWTJjVkVEVUV0?=
 =?utf-8?B?N0tucEJDZWNEY3VkQzExNTNKYjU3TUtQVHhUUEdXSWt6cE5TclhEM2N4SGdz?=
 =?utf-8?B?QnVpbDFOOUNEUlNQYkVMRVlBOEpTZUQwWmNGeVRMUDJkR29EeWU2cmU0K0d4?=
 =?utf-8?B?MzBPRjNXbHRoU3dITThsSWljU29KTkN4eHdIV0llajBSaUNsVDlFby9maTRJ?=
 =?utf-8?B?clM2Z0NPSUxuSytVeWdUNGlPeHdpc0t4cS95VzBnOUFRMmgxK1JaTnVSK3g4?=
 =?utf-8?B?TFdGSjVWS1hlbE5ZcjlXYXo1V3JMYW1aeXBOV0gyYjZORFFPQ1RoM25zR2Vh?=
 =?utf-8?B?UnJoTDRORmxGUEswVWM5S2p1R2RUZHR1MnB6bTdLRDVqeWw5OWptRXZnalhS?=
 =?utf-8?B?NUtvVFRobW5YZ1ErU2ZySEhaWWhtd3FGOXlJMXY0YzVFZFR2Y09ZZUg1VVpn?=
 =?utf-8?B?QzJGek1RdFlsSjZMVXVOYUFrbVFTWlpDMnpja0ppVWZ5RVYvajZ4WHUvcnRX?=
 =?utf-8?B?dGhBZXYyMHdEY2JKelFFaHAxNDd6K1hMVklTcWM0RlBUYzBLMmZ0cGllZ2ZQ?=
 =?utf-8?B?V3orY2x1ZTN3M0tHdHZLV3FnUmYycCsvWXJCdEd6V25EREJiNkhvdDc4bm9P?=
 =?utf-8?B?YUpGR09QV0lnMTMweGQ3aFo1Y3BRNE1Jdmkxck9OWmhRVVlQUm9rN09LeHRi?=
 =?utf-8?B?SGZGcFdzTHRBVEN5YnlmTnJqbFZMTVp3ak5IQVVpYkttVlAwSHg4ZFFyNjRl?=
 =?utf-8?B?MlRrT2ZzbThHWk5LYlJoQUl3UXFweHowR2YwTTc0NnpUb280b1huV25zV1dY?=
 =?utf-8?B?QTQvZWFXRGIvRzN2SHM0VGpiQXFEYjlFbDFzWnJPV3pWTlBBbUw2NFo5TjVM?=
 =?utf-8?B?U004NWZOVU9lRFNzOTllS21RYUtOMW5wblI0eFgzRllJNW1EaEZFMFZVNDdB?=
 =?utf-8?B?R0NNaVoxUkxtNENza2V6TDVYWUlkVVozZm1RSnJmMnl6elM0aEdTUEphRTM1?=
 =?utf-8?B?S0kvaFExM0ZSN0I2M3FsY24yYWIxZlhxZXdYWjhMditSeG9KR2kwSzA5QUlF?=
 =?utf-8?B?UTFBQlRHa2dTRWh2eXY1R1plYWx4dUJ3Y2ZEeld5UE9XM2xQTGo2ZUZHNHpk?=
 =?utf-8?Q?w7Wh/jpaP8qsUj3Ju/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d688b5f-1a08-489d-2d3a-08df2adf03d4
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:09:04.1049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qQygFCJfv4DQepEMe8Nv3jghTgiwIqpJ5SJONAMCEM/WmPjqHFmMVpBTtt0wqnO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB465449


On Tue, 13 Oct 2026 10:10:45 -0700, samarth.colleges@gmail.com wrote:
> iommufd/iova_bitmap: fail GET_DIRTY_BITMAP when a bitmap page cannot be pinned

It would be nice to try to propogate the error code up the call chain.  This
looked a bit annoying, but if you are interested I think it woudl be
wortwhile. Anyhow:

Applied, thanks!

[1/1] iommufd/iova_bitmap: fail GET_DIRTY_BITMAP when a bitmap page cannot be pinned
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=a6ec38d74c08ddbe1b7c3936d6d25f346d12c7be

Best regards,
-- 
Jason


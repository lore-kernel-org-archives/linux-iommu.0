Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795630081;
	b=DAnKPfcCRTC2nnFSMj5qA25FW0F7LnKyaWjRcaIqm3Raib7u2YtmWG2apsm5HmY9FvaN
	 y5ecwjxJJp8RWqOtkyN5CUcZPLVq1h5SCvdbDArE0YzgceB83dRjVcbzaaMZocDajT8dw
	 grAt89tfr6PedTf/CFQ2Z4eLf7a0QTZzYq/BBTMt+hPUozd+lQ9M/qGJMNYW+uR0dzaNc
	 rHtwjckrB/db5S7uGTQgmdxOyOojbmRDIn1nLG+d+TXBk8kIjuThJTldIWP8yh5ht8hyd
	 K9O8ybboUfUmkB7MphrmPSsaCEYQGrhs99TbkKtJYM8Ynuo1koSLUQsMm80GYokqGog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630081;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=45lixgKeqh1xRSrPi+GY6i2Q2DYWRFxqB8MYfvLtiUU=;
	b=qXkuCgPdKTFf4ipPYHQObaltvVYudF1GUlNvplaxiPVaKKlxoDTlqGSeteiVVOChwY6V
	 0rLxkH4yFjGufmuprlnHqo0481DPZdFbVjtEm6SIcwqT0mcBdjLecVzb6Wp8BSJpyljyg
	 +xm3liYCR53TEhiswUqAeYJvpD3F4uNSZcVGjjq7l2OLdZKfPWtb/xokN7+xFTzEAd92r
	 xH1tfEJINiDuQBXSgRKU7g079zFgkEbSaWO3GoGQhZJU8qqJRdXtKlhoJqDfVZFYEwhNz
	 Ihoq7ytIw17FcoQ3KRyHH8vI8RI/3f0yYVlV0s/gvMD4wjSdDCUQXeC75ytQYjKiMBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nVOrbe41;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.29
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD43606A692;
	Wed, 25 Nov 2026 18:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FD43606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nVOrbe41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMXRDrTDvJjwACTiJjDJq2oKtZfxd//l9XViumwoo1g3iDkiZOYeoXpx0jalyoGOjvM69yhLa7YKc5c4YjZJbB7OMZyd4wwLkKzTifWO0o0GKnZgtysmfEp5tjMnjZP3vtZvVedEveVQQznFdLsc62wAGB+T7ApE/nYjnrb8zBFZsDLvfSRE/OHyhG+n1Z34iEgLyOX6QkMcLkGtxAqJfSC+j1jBphR0cHYDJ8yjTf33BKFdLgoAyF5NZlgvq9xGW+jXa7azUD2BiOm+JRHqsVUUXAec1d4xn0nw868vrGIL0mbxoJzqi4pEXMQfJ5zu7qHIDHP8+Wzr11dnhQDyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45lixgKeqh1xRSrPi+GY6i2Q2DYWRFxqB8MYfvLtiUU=;
 b=dhv7ufuPbTLC8uUYnO1pOD5IxBSdFrfUZx9YUNecLxVEWQiyWRNB5MCW69iQs45XQKW1cmjnOxS2rXhzWD6pbkOY6xaaF6MtaaY/NZXksmHvCuA60fOpTQqq+jQbqZ3ih72OYD+cEvx6X+54eo8FbodzmRbLf5GoDZhsNOj35mSR1DLyRD880yjqWcGIbeGiunU0WD6QAdBvhKdLX+hwPwTniNK42FGMjlFZ7wSZHd/E5vv4952Vp/qSF0jgnZyrHVUDJMhmfvpvVyVlatZWsGlH54mh9AMizPuFcwwpcFvXw1GNH4AWb+XJf+lISmX6F2DggWgfLIw1WK2S3CSYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45lixgKeqh1xRSrPi+GY6i2Q2DYWRFxqB8MYfvLtiUU=;
 b=nVOrbe41Yaq1irekofULbUUflP49AForZEVU6i7QyGHl/pYtyR+PAzSXILWw53QlYv70KD27kSa8MAW03C54OzQsPETzp21nD6/U20y+bBbPvOKVNY4GTUOSrlLGDYCC45zgp2OjL/Y9JfGcjSuj5mcUsZ7hT8J6acYjo+YIluugBXpXjgi3hR0Om+J5ErgFMkgnFLtOSNRAXVuOr6QRHxjALK4i9EjNQ+eVmsEgef7zQizxyDToE6Lhm9h3qkP2AuOaNq8FgGGVcCJ+mkYroZ6IYc48zqatzB9tYPQMLzGM7WOz5O82d1ibKSkm4n/ym1Y4IyKhmO6+WOgrSpcT/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by DS7PR12MB5815.namprd12.prod.outlook.com
 (2603:10b6:8:77::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 18:07:53 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 18:07:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 5/7] iommu: Introduce TDISP T=0 state for
 confidential IOMMUs
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, joro@8bytes.org, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 driver-core@lists.linux.dev, Sonang Patel <sonangp@nvidia.com>, 
 Ankit Agrawal <ankita@nvidia.com>, shameerali.kolothum.thodi@huawei.com
In-Reply-To: <07ea92910895a2b0db33afefaa3a0ef182b2968c.1794343501.git.nicolinc@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <07ea92910895a2b0db33afefaa3a0ef182b2968c.1794343501.git.nicolinc@nvidia.com>
Date: Wed, 25 Nov 2026 14:07:45 -0400
Message-Id: <179563006502.253973.9155049351516451537.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::9) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 372bf136-0c4e-47b5-7591-08df4b1f0363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|261026121527099003|261026140227099003|261022105027099003|261028144727099003|11063799006|261102123227099003|56012099006|261021121427099003|4143699003|10067099003|18002099003|22082099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	fyEat+ffd5uS5D0SC+aseh+euNtL9sW8fGs635E+BOCwIVIJ5jboDsUauFn+dXQWFWR+7Wac6J+rrWMbT7YjsVmRcV0L4cWm2nysJdye/daUlxXMBwhZWbeuo82F+0n3VPDfUcm0Aqo2M9fa0/0EYhEaXoAuMIrYVJACawjQuBOWDCzScyXjp5x14kXx9yoemIDbT2kfKk3Bo//h7Ab3QN9yJjp5CdJ9z9hCh9gjk6IY50zczCZd4f4cHfq+SNH+gmSZyVquNkRkRfcOMhn1dYrgRJkaL6ZK7rgim1YEINC/f0aVwO1AXvs9y1gzvRFzTVx/bKreb26uLUCddD++OVtgZ+cehSnpagfb8+Q+Ax7bsUBtZmaxEbKcncxMdEjk+aGPjffcjegj1URBkrhoDCpoaRp/ODD0mh6utsS4nfpgj8ZgaBuM/w+f7iQ3jF3cFlk2pG+lL4Raw5Vwm8OeVnHYVaplOAwlEco0g1huKltCjutwLYy26jeK521gyRub6rGJAdna29qdu22JYcsEXN5uIlIDi/4moyaa8tEQmTzSIjrmwzFnbfLXgm6/BaAE09W5UA8Yoj1n2RQ91z+x55kBTnelL9fB5JhAfMjHLczQgIZCX70ie3W9YjY9T9LP7meCgIn4QbJZzOq/XTFabILRscjcgM/itS1BNrloOGE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(11063799006)(261102123227099003)(56012099006)(261021121427099003)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTJtLy9pUWloM3gzQzlacnpGT3UyT2tSb1VvWUlSVllsOUNyL1ZaemUwMHFE?=
 =?utf-8?B?THU5RWtCQkpGV1c0TndLdmk3TVl3TkY0ZkJKNENJVXFmZXNraXdLTXplVmxJ?=
 =?utf-8?B?UUxxd2dQcUVrSkhYMUZDVUx0eTJYU3RlaDV4LzMrcm5sVytGTTNCL0ZaTjRK?=
 =?utf-8?B?VWw3SmIyaFlQZlBRSUxhTDMwLzBnZjFiTitqZHZTVmdlVTVuWm8xT3lPdVJQ?=
 =?utf-8?B?WDlHSEYzYzZOdm8wSmpTUThEUXJMb3d1Z2dERFNQUVd0M25QWWRlZm9YcWtv?=
 =?utf-8?B?R2lmcTkxYnhXK1p3WCtrRFdwRWxtSmpJbkFuL0JvU3ZlaUx5UkM3dmxacUtW?=
 =?utf-8?B?RnE1dEkxTU44Z0FvbDNSTWlFK05qTFUydmx3YVB1dVJITEhCbG9RdlBKY0VO?=
 =?utf-8?B?WHNFV1FBVmkrdmw5VUtSS0lzeE5VeEFTWmNXODhlVlVvdjhOU1IwZFFyZkpm?=
 =?utf-8?B?NCtnYllRM1RubXpuOXVmRVZNODFRRG10OGdnbGs4ZFMzVEJXMGJYR2hFUjBJ?=
 =?utf-8?B?MlpqaWZ4RDA1M1JqMGJnWklzNFZrL3pQK3FrbWZxNFVvM29NUDQ3SFgyMC9I?=
 =?utf-8?B?dmdjR2FBRlY4a2VzV3FWSTd6QXozM2xNeEFyM2ZqSElJN24vOUdCd3dpc3Zt?=
 =?utf-8?B?THlqRy90V0kwYTRwYlk0NFJMdVRsbWRjYlh5YTdlUHpxL3VEOWJHQ0FtOEJs?=
 =?utf-8?B?bXRTUlg3V2Z2TjR6bW1zRFpGcGE2anBzdXNKVC9EUm9teGk4YUwyNnIzSHRJ?=
 =?utf-8?B?dW85ajBLcmlrRldjMUFOZDV5V2dVLzBCZTVwTStlWlN4UWR1elAzNksrMURj?=
 =?utf-8?B?cytUS3NrZzJoVEc4YnpQcFBQcUIwUXlpUEh5RkZiNzNnbCt5a3VyQVNmWHdZ?=
 =?utf-8?B?NnRRRWRPVHR3V1NqWEtlRVhaK0x0Ukw5NStTUzdlclJ6NWpPR2RYanNFZTAw?=
 =?utf-8?B?SWxzL3l2MlhBUHk4SGt2VjRLZk5ITEpuMkZkR0N4Wk1HWUdOUmlZNkFMait5?=
 =?utf-8?B?WEMvTTBaanZ2d1BGQUk3NGc4NE5UUmZyNDVDTDVNM0dFMzhpY0RvNWpnRzM2?=
 =?utf-8?B?K0cySWk2bEp5V2dsa0RDYUl3UEw5dkx0R09LcE9pOEMxdnpUTGFJS09RM043?=
 =?utf-8?B?Q1IxWSt5RHgvOStsalpIV3EyL1RoQkZOS0ptZEhlYUJRa2JIQk5ORTVydTA2?=
 =?utf-8?B?VHlpY3RFS3JESU5oek9ESXY1NzBqZGxLRGxvTXc2aWhqY1RqUGhFblBFbnBq?=
 =?utf-8?B?TUIvSzFOV3V3d1FIc1gzQW4zNE1sbXJMUExtdmtTTkwxejY3dXlDc1JIdnFC?=
 =?utf-8?B?aTVQVEFoTUhIRlZvNnh2WlhQb2hpaERCdWlCUkVzcVBpT2lRMVdtNFVnSWhI?=
 =?utf-8?B?Y0RlZm9nMGhtQ1ZWYVRHTnRjaExLMUE4WTdzOXRkK2RQOWtFam0zaGc5U08y?=
 =?utf-8?B?dkhBSUl6SVlGdWVRQXpUOGRtZ2kycEdOMGtnREs1YkNqMlJYL2VjRXhVaExi?=
 =?utf-8?B?eDd2bFJ4cGxKallpdGFjSGFlZVc0a3pBMzltMXdDSmhMd3pBZC9JMzl1aEdy?=
 =?utf-8?B?b3dxRVkzTnZKM2VpQ1R2aXEreS9zYXVOR2ZwWGkrOHlUdWhNZmU5S3BoNWFK?=
 =?utf-8?B?TGY0THpRYWZ3ZVlPTFIwUGhkMGkreEFDTENPLzdnT05NSTNmUXZ1Znk5OHlD?=
 =?utf-8?B?UGszOW1WYkRxenk3ZVpxWUduQ1YreHMrZnN2QW5WNlRzSTlyNzJnZHBtbklM?=
 =?utf-8?B?VC9OMVZWTktGOVpXM24rNXlGWS9RWWEyaGUzKzE2TVdSbzdDV2pkVWNqbFkw?=
 =?utf-8?B?eFNjbnlxZ0RpTFdERzVtWU9FWktrblZiamcrZnN1R0d6TGFTakdzL1ZXbkRC?=
 =?utf-8?B?WFdIbnRiaGVRNkUzZTZ4Mnpvb2k0WmI1dHo5VmV3bFVib3VWL1FqaUxuVTR5?=
 =?utf-8?B?V3V1b01lbjJXNlJIVmpLTlFZU2kyTU9MVmV4clR2NFEwMmNkdlpqaUFHRzFR?=
 =?utf-8?B?WkkvczVGM3ZZUmVTazJGWGg2dnpVaGk1bDJFd3lNeFNaVkd4YVpIVjkwaG9m?=
 =?utf-8?B?TC9pRXorQURNUFk5d01XdTI1NGx0SmJkV3RPY1dzVVYxTzlhQUlpcXZJL1VU?=
 =?utf-8?B?NFZMMjE1K1NZTUxoSU5zTk5aR2ZNcnBBeVp6bU51bExHZ2tIRkRqaVQvLzRM?=
 =?utf-8?B?STJTdEVsWm9kQTZ1eXVOZklwb2NRVG90SWtpWjZ1RVVVMS9lZzh3TjhTMVBi?=
 =?utf-8?B?QmN2Vkh2MmxhZEUveHpIRWdXV0gzNjFQakE3UE9JeEptQnZFVnJYRmp1R3Nl?=
 =?utf-8?Q?2JgiBhLp9KZMrvJw2s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372bf136-0c4e-47b5-7591-08df4b1f0363
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 18:07:48.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTEEMonpXdZg32avFnIpe3CXbugsNuo0Q/XIsq1yt10mDGW+bPuIFL4vvSS3QHX3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815

> [ ... 139 lines skipped ... ]
> +static inline bool iommu_using_t0_stream(struct device *dev)
> +{
> +	return dev->iommu->iommu_dev->confidential &&
> +	       !dev->iommu->tdisp_t1;
> +}

The logic looks OK, but this naming is weird.

All PCIe devices use the T=0 stream by default, so this function
by its name should return true for normal PCI functions

I think this function is trying to say 'iommu is bypassed', that might
be a much clearer set of naming to lean into rather than focusing on
CC.

'iommu is bypassed' means you can enable ATS without having to involve
the IOMMU driver because the hypervisor will activate it in the real
HW.

So the names would be more like:
  iommu_viommu_bypassed()
  iommu_bypassed_enable_identity()
  iommu_bypassed_disable_identity()

With kdocs focusing on the main property 'a viommu that is bypassed
means the hypervisor sets identity translation while bypassed and PCIE
ATS controls ATS behavior'

Though I am wondering if we really need the ATS stuff. Why do we need
that? The pci_ats_required() in the hypervisor should force ATS since
the hypervisor is not going to construct a vSTE or use a nesting
domain that would inhibit that? Can we just drop this whole patch?

-- 
Jason

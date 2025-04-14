Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60CE2367C1
	for <iommu@lists.linux.dev>; Mon, 14 Apr 2025 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630688; cv=fail; b=LAfLckkk8B9TmJ0y8COMHbwruBHEs/Ggv1Pb9EBRx7iD80PgZzyLr+i/I6j6H2VlE4PByLJbUTDvZZUddkuXX2DcwC1MYbQ7Dj/bRQQuSCtqyw/9pepayfhWImLJXUd944syiVUpjPmt+E21mWcFUSK5E+is5CZCBK0D8oUCz+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630688; c=relaxed/simple;
	bh=QZIRK2EYMwM1C81xoSYEEmtEeUVbN2GK7ZAX8bgsULw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Osgrje7KAB2d1seA7G85GwkIhg84UHyFIuIl9f9egACBnTdObYl3wcC4hJv0GygfxGrUmd2I6lcXA9v2Vm7Moohja3XcmYFJfEGRSMk1Nwu6L9M85mTIYy/ixgOZqYZAMy11r0yDc6iKyT7IySl1M2fZYQoOCfTZrKSfs/TmtgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CoO8+5Uo; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CoO8+5Uo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YT+TGPhcyF4isFeG6w4E9WTE/S8JyOEDz/3nlJToo5AaNkzBkMRZgI0sCEcggehuNyuLK8hwgmkMLGEolNqIoNNJKp4CpDDN1kp3BFDiEv9WIXeWv5GfpzRf7iHjwMProQC9bVjxYLFrJ/jxUyS8jcxEubyAfFasaR/dXFPYSRNOWd4XegHsoJjuTXqqywi4J8dj7IgiTverxee6W0CQ8isMiVJpIPsakOAkCO0jYfeqOrmY5WqNUtcHhwLsB9L4BXlT0rdjqqDy5bdnDQK6cN6XscgEb5NuBQRISWfPitHTmZdfJjUyIMNtoyhWu8e+ML1raFcLQjcmIholDNgNxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOI1ht2Ya3xrhHINCfnffV8IZvFpjEEQcB6wW4uuGf8=;
 b=eyqG0ZBVHBFo8QCeuHeGeTJHTU0cEkASpPM2IhRWhSCQgcfvLCQ+jhRQ9E/k9P3EQje2QWYasx+JVu/URiPBZFjZRFKUN6tUKLAQQygbe8VVK5AdnlW/wIRC0f00gQFYcFO9pIX1GqVMk4vgOowOcrXqPrOz8WY8KTwtaVW3fquAgcmV8aDC8oFBZbNylcKkxsYbC3AcfE2JdnYvY+O58EIzzG/vqNjPmpUP2YS06+XG5DeSZPsGQf1LRckFGauOFmoW5zIEA1gT1P4l8qv8Rn6oIC3D8EaIXIF0/gi8JJi/gY8vECEP/M9h71D9hswGwEFEOz7E//b8aO4h/KqQZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOI1ht2Ya3xrhHINCfnffV8IZvFpjEEQcB6wW4uuGf8=;
 b=CoO8+5UooluAAHiUPbnz0izLxxZ/rVwZR6/qRnP8Agl5t2WHxMknn0XSPoLcYqvIALg6GVo5OraK/lGaB00ipOBPU+4wdc2rA5YDy4j/ggl4wNteGUmRMFlkUsgD4QWNUzxThJSah9HZFb4iFe35ber0fV75mR6NZeCWFIkA5ZYf9BnhDgdcrQwuqPWwNYAAjRB/l8841uIhc1/9wS/jQN82E375PCz1PGq3ErNQNONr5sxvSUX1Bp5gMCO5L9NnTbbIM6/aEL/McyW8RbLgc89jE5xzdB2aUOaaU8/9zGjGMVSu6xuAu05k9JWbuTS/e3tdW9t+Ha22ybS2JDhUHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 11:38:03 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%6]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 11:38:03 +0000
From: Balbir Singh <balbirs@nvidia.com>
To: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Balbir Singh <balbirs@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Christoph Hellwig <hch@infradead.org>
Subject: [v2] dma/mapping.c: dev_dbg support for dma_addressing_limited
Date: Mon, 14 Apr 2025 21:37:52 +1000
Message-ID: <20250414113752.3298276-1-balbirs@nvidia.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0072.namprd17.prod.outlook.com
 (2603:10b6:a03:167::49) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: c4bbae9a-f8ed-4bbf-1731-08dd7b48d0fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzRyNUlMZGN3ZGlLWmFjek5kQVBldzVmQkZCbmVaVHVZcnovVXhTdjlnZkFH?=
 =?utf-8?B?U0FmaXlrcWx4K2FrRVFvOTBFcnZZcmRXUUF2VTNGQ0p1bzIyRkRyeXhoZkRT?=
 =?utf-8?B?cGs5SzhDMmZrYXRENVY5V2hSMHVSZm1qOE91YlZDUVRlUStveVU4c09XcEVF?=
 =?utf-8?B?QW1VTDFta09pUXZLL3VhSGZNTHVkRGJyc1RtaERiREgzZ0FuN2d3RU9ZdU9m?=
 =?utf-8?B?OFRPSmhiT0wxbXNxVnlOUktPYXEvRmpWcW8yM0lFSHNMbzlsTUxPclp4MnI3?=
 =?utf-8?B?QzdxNHR2d3dYZnozMEpvRlduQmhNamw3RVUraE5VRlE0ZzVmVm5Cb1BQZjRG?=
 =?utf-8?B?amsraU5ld1NCYmgyOWNzSSt3WE9wZHBrdnJiN2J3MTZCb0o1a3lyL3RRM1RZ?=
 =?utf-8?B?ZHdwdnBOTHpIeXplaVIwUVBiT0pYUFNkOEhIN0VvWnh5bVJObGJUSGlFdFpt?=
 =?utf-8?B?UEw2RVUvMm82bkgxdWE2bGVOTGV2M1B2dFo2bmUxYTBGem9yUCt0Zzg2NFNq?=
 =?utf-8?B?TXZXVDdEQXcxYi9sUWRjWlh1WUY2aSttdDFmS0hDQWVlb0VCYzFwejdvVDZE?=
 =?utf-8?B?OUw0NHRNdk5WVWZyRlc0bWY5bjlYNEtLbmdCT1FKWUgyRDRueHpEbFYzWWtU?=
 =?utf-8?B?NFpkSUpTWDVEUjBBNlJETGg4c2hHMGw0VkRXcU5nWFVKcndGNXgzRlBiVXNU?=
 =?utf-8?B?KzV3L3BkUVlvdE1mOTVxQTVtNjZQNFdyYTlmcGE1eHZHa3hhSi9za3hWdVEw?=
 =?utf-8?B?UmQwTVZqYXExaXpXNi9lVGQybGNTTWdub3ZiS2U2UlIyYm1MamdLaU1xRHJq?=
 =?utf-8?B?QUJnTFFIR1lFb0pybytMa1VXK296SGxvNDRRTG1BUEluUVhuNUpMeEFiT2FU?=
 =?utf-8?B?M2JXQ2c4VE14cEV5Nkd3R3hZM2Y2VWY5dnBjZkxyV0o0NDNySWdPeXhuUjgx?=
 =?utf-8?B?eHNaU1VaMkxNYi9Ed2lDWjFqTjVZYTdjbk5SdVVNQmhnYTB1N0ZvdHorWDVv?=
 =?utf-8?B?N3U3eEYrZTl0ODFydUNXMWRtN04wOEt6eVVyOWdkR1NXS3hMOXN2QzhFTFR5?=
 =?utf-8?B?Yzg3V25GNDlKNVRMMHN3cXQwZnZyTkJVOTBock9PMnpNNG1URDl4RmlMMkZq?=
 =?utf-8?B?Uy81NGdROUkrVFluekNwaCtmd3hoeFhzUXpLVDNlSXVkRWxPdkQzV3FkR3hK?=
 =?utf-8?B?NTN0Lyt2S3dYNUQ0cVRFcWdYMTk5ck9KdmpMVVFmNUg1Q3JVVEt0dGhXbXdN?=
 =?utf-8?B?aXgxaDlnMVZFVHJQTG55VDhsNmRjbi9IVHJWdWRsV2c4QW5GQ2M2Y1NXVWJx?=
 =?utf-8?B?dWJvVFlLUXI4M1E1bGlLcjVVSnM1UjFaNnloTHR6SytEdDErSDBYNFlyZUVn?=
 =?utf-8?B?NStEUklra2ZBMG5yU0hxNkw2UmRGSENzTmNaeGRMMm9TeWF5amVJQ2w2dFd1?=
 =?utf-8?B?ckpqZlVBSEUxaGg2V0M3Sll4NTk5dW5KcVpGZ1hPZlNDRCsxWHdqUHMrSEJp?=
 =?utf-8?B?aE80d29VLzRQUGRVaDYyVUVnQ0ozeHQ2eFNXQ1RtTXh3VHRzeUNaUitlalU0?=
 =?utf-8?B?aXVLQmpsUEpyTGxVRjJNdkhqa1orWUxKMnFCckpIUUNCSzB2eVVMaUFHM2Nt?=
 =?utf-8?B?dFRSbXNmRG43TzFRV0ZJOFFTeFhmY3l3NGk1SXRweUtpYXoybkRCZmthRVYz?=
 =?utf-8?B?VEFqUHVXNFFTRHVDTkNhRXlHUWpwczh5MUU4em5kM1kwOHVwYnY2RzFVL2xD?=
 =?utf-8?B?aE1KL3hycWQvY3JGYjFRWDRjQ1RqTnBvaG9Od2dPNmdGU3lVVDBuYkFtTW1r?=
 =?utf-8?B?ZmlwN3NhdndCRysxUTcyVmU3dTR1RFVTTXZFN3ZxcmU5ckh5ZFQwVTRnd1Vq?=
 =?utf-8?B?WlhIMndPSlZPaUJpcGR4Umx4Y2pxemNoQ1FWdFJtVFhoSk1oQjBsVkdKRVlh?=
 =?utf-8?Q?K7PnWjE3Cso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVorcUJ2VEQ2eUp3UjJnQWdyT29XdkU2TFBpWDlKRGxyNE9VaE1LLzYxVVVu?=
 =?utf-8?B?RUJPeHY5bFVIWnVERy9MWFhDWWhQMFJpaWtrRkRQS0lVRlNlaTN0aE9sSU9M?=
 =?utf-8?B?NStzd2tSSE9NQnp4OTJwNUo1aVo4aTlsUXdJeWRLTFJsWDN4TTkrNzdBQXkw?=
 =?utf-8?B?ZEZhVi9VYVhjQ3g4OEJ3ZVEzbXRBM2xTWHlScVpBV1dVZDZ0QTJXMFlUMVR1?=
 =?utf-8?B?RUhHTExCbG1CZ1o3M25TWWdtZ2hGRWNDTVBoa0JnVWdmQllXaTFocEtGNEcy?=
 =?utf-8?B?dTE0d3BWaWlpSCt2YlBreGEvbWd0dUpaWWxUQXJqYmI1bDg4d3J4M0xnNlZw?=
 =?utf-8?B?VDQ5dEsrNzBmZlFVb01jRGdkcEllYTNoUWp3QUpibS9JOVg5WjJ3MGZDT0Rn?=
 =?utf-8?B?STZCdGVhOFQwWWNRbU9BTkZackt6b3dDb1VXRzg1bzl6cEtwT3hXWWI5ald3?=
 =?utf-8?B?QnJ2aEQ5d1FDZkJEOU5mcVhhMFZxRjhPdEp0ci9GL2krY0N4K1BsOXV2ZFd0?=
 =?utf-8?B?SjJhclF3d2JlZjNEVXhRZ0ZEZTJHV2JaREFuYStxd0c2UXZLSFdEUUt0ajN4?=
 =?utf-8?B?Q0YrbnlQL3hOdG40TGgrNWxSSXlJYmFIN3U4czFhbkE1endBK2cxOFIxRVVh?=
 =?utf-8?B?enMwNFV4WlJ3dytYLzlvYTNjRGxJNllDYlgyWmNGUlJOdXVHODhEeFZxajZi?=
 =?utf-8?B?VFlVT1QyZDU0amVVT1YrRkdaSm1PZFBlODBoOGdFeTFXV2VXTWd6YkpWdGtz?=
 =?utf-8?B?djdCWHUweTREeU9WZVpwUm82SmgveFdVWFF0dG52QzFoNkZKSG5Mc1pQSDJP?=
 =?utf-8?B?ZWhjdDJqYnR0Skp0cmFFTWxLbmc1V2FIdm15TkZZMmI5M1pzNC9kaTVzMnAx?=
 =?utf-8?B?MnBuZVRHSkJrWGtpRmVKSFh6bGNQak1qZG92cC9OVEJTKzFxVGxIbE54anpa?=
 =?utf-8?B?eVpDOVJHdUZMNXVzNEd3eEpjUXVQVklIMVhtak1hVDBGdzgrN2FzaVVMY3ZK?=
 =?utf-8?B?SVBkM3RmQVo1blpyMGVJc3dlcll5Nko3UkliNVlGcEhLcS9MUFllTnp5Y0Ey?=
 =?utf-8?B?OHYrKzBOR2ZiQi9YUU9UNWpqM0crMSs0R3BzellQbitmM1l1bzhRQ3R5UGY5?=
 =?utf-8?B?amN2SS9hM1NBYnVPNFduTVN5RlZabXlMRDRWaElOOUs2aUNIT2J0UUkxcXc3?=
 =?utf-8?B?NUMxQ2ZCRHozY2tXMWovajh5ODY2b0oxYnJENGsrZmhmSCtuQ25KY3lNckNB?=
 =?utf-8?B?anlkdUlEN2dXVDFoRGZ2RWR2T1JLRUhmYzR2cGQ4WVhEOHdwWGh0OExKZkJa?=
 =?utf-8?B?U2ZDYmk5RE5WWDdJTTNlM01ycnVLc0p1SWljcEhTNUQwcTNDcjlIdXlqUlZT?=
 =?utf-8?B?MUdqTWxuNi84eGhnN0lZY0hmSTVmZjgzeXFEQnhtS29iMS84OHlJOUpvUFYx?=
 =?utf-8?B?eFVGTWVMYlFwVk5jN1NHemxYSExGVkZSdlVnQnVzdE5jRFRCRlFUSG9uUFBt?=
 =?utf-8?B?N24zVjFiQmhXcmR4OENiWW0rSWdaR21lbVJ0emlleGtwb2ltTFJLeFgwL3lW?=
 =?utf-8?B?cHkxSXB1U3dJZ0hJMURQU1F4Wm1PZ0pLRWJEdEZJZE9nU1J0bHFZbVdtblNr?=
 =?utf-8?B?ZzZZdzM1YlFHZ0V3OElMKzIrOHRTMm1oSTNwQXovcGFYYjFaelI0VS9IMzFn?=
 =?utf-8?B?dkRIZlN5TXdBaHRBK0Q0MGVGeUNzd2FKL21ZZ0RlRDUvd3RrcE04VjNoOFVD?=
 =?utf-8?B?U1VENXUraVRPMWRMbktCdFRsMzBrNEkzOVhrVUZ5bmNHYldtYVN5L05EbVJW?=
 =?utf-8?B?MkZydnNYUUdVTW5DN2RwalFhZWVzM1hpTmpHalVSMVJ4TkJlOHhYL09OUWpF?=
 =?utf-8?B?VS9Zc3YyeWlhc1FrRStnQVZkS0YybXk0dHAxVE5wWnJTNVRCa0RWd2h6cjVn?=
 =?utf-8?B?UFdiV3pPT00zS2NYRm81WGpFWjRnMXJhSm1PL1Q1cEVWdWhFNlIrTWJlenI4?=
 =?utf-8?B?eUxHMTg3R0FNeTM3UzJuQk02WWlMWFRldWhqdzNHdWEzVWVBc1BmOXZBVG40?=
 =?utf-8?B?NXlRaWJtbEtiYVlUUURZYmhFVUtmTDM4UE9wMk1aaXZ0aHNrRGZzN0hHSXd3?=
 =?utf-8?Q?RbPKelHHAqGp17EDIb9JFazAb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bbae9a-f8ed-4bbf-1731-08dd7b48d0fb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 11:38:03.3046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWNPOq9VTRmAw3JlmA+aQHuUVh4Eh3coEK72pYt2bs+5fIxGCw9h+XyvQ7QzyxSNu3zQloZv7KSAwK8XpF7k8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949

In the debug and resolution of an issue involving forced use of bounce
buffers, 7170130e4c72 ("x86/mm/init: Handle the special case of device
private pages in add_pages(), to not increase max_pfn and trigger
dma_addressing_limited() bounce buffers"). It would have been easier
to debug the issue if dma_addressing_limited() had debug information
about the device not being able to address all of memory and thus forcing
all accesses through a bounce buffer. Please see[2]

Implement dev_dbg to debug the potential use of bounce buffers
when we hit the condition. When swiotlb is used,
dma_addressing_limited() is used to determine the size of maximum dma
buffer size in dma_direct_max_mapping_size(). The debug prints could be
triggered in that check as well (when enabled).

Link: https://lore.kernel.org/lkml/20250401000752.249348-1-balbirs@nvidia.com/ [1]
Link: https://lore.kernel.org/lkml/20250310112206.4168-1-spasswolf@web.de/ [2]

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>
Cc: Christoph Hellwig <hch@infradead.org>

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
---
Changelog v2:
- Change the debug message to be factual
- Convert WARN_ONCE to dev_dbg

Testing:
- Limited testing on a VM, could not trigger the debug message on the machine



 kernel/dma/mapping.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index cda127027e48..67da08fa6723 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -918,7 +918,7 @@ EXPORT_SYMBOL(dma_set_coherent_mask);
  * the system, else %false.  Lack of addressing bits is the prime reason for
  * bounce buffering, but might not be the only one.
  */
-bool dma_addressing_limited(struct device *dev)
+static bool __dma_addressing_limited(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -930,6 +930,15 @@ bool dma_addressing_limited(struct device *dev)
 		return false;
 	return !dma_direct_all_ram_mapped(dev);
 }
+
+bool dma_addressing_limited(struct device *dev)
+{
+	if (!__dma_addressing_limited(dev))
+		return false;
+
+	dev_dbg(dev, "device is DMA addressing limited\n");
+	return true;
+}
 EXPORT_SYMBOL_GPL(dma_addressing_limited);
 
 size_t dma_max_mapping_size(struct device *dev)
-- 
2.49.0


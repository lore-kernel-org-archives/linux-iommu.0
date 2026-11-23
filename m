Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795422817;
	b=SCw4ydxNvQxdaPnlud/jgUdYsHUdpJLa2+KS9qzt3CdZnXpE8Gl83LRdiuAWcxZUL/Ov
	 R4mpdAINL0DovsJgKm3kvv4qXLQCUxBKlQq8OZ00QiuNSFLPIlex/g/puKTFl59SsWWz3
	 gr+PZBJ0tsm92ZXOEAxieEPK8ellyI+2PSYUYBfn+p2UmWV5QfmP9Sg9zmNZyGOxWm02C
	 NEcLGKZJj+iML213HyTgI2onuOOWBDHbsOR2vcRdBV1eaOYev/PG0Esawvv3X9r/chyiM
	 Vm5ZBpadRxIROIJLk1mP0UC8fKfcGzdyAgZ5owhjZVjXkeH35okEpkZJbjLLF2DMs8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422817;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
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
	bh=aBHLkc8pg6yu0Ayi+S/ScCycvBYdg4GCvE01dbjXyMc=;
	b=jRXoxLmHTKJ9njImH4GBLX8JAHZR/41ye/byY7SAEQlulC6a6vDU60N1VSHBmLMIEHmE
	 pSQMoNiwCRMBHWZPi8Caq0ZGnvc/zfm2Y7wyh8eP/e4UlpmtJztZMu+vXoGj/8xEVgYCN
	 CXA3Qp59zBsb6KV0P0FhBqBQ6f0I+5t1ATbFzhz0CA2IvE7Fd+vOkmT4oYEhG1jTmLaF1
	 l3+F5t3umAlf1/Fa6vb+P/vqQWeBDoggCGeyXsIVQa7B+eLn1Q/wR5Skd3pBgCDTc5V6u
	 6CMSvN9tYjPyqbthkKAqexCG31NeIpTN3pZtE73IEVC/cx3TYRAeTtvFeLw6x96f6SQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ndxlmvjD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.11
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A378D606A31E
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 08:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A378D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ndxlmvjD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeT4h41cDanlhtywedHTOzPHrf9UmV7aFp4BfoLiyhFvMqsa900tALUnSP8Ww+zqZUt0kK9e20I6ik4i9lb4LvX82OCV5f+2ROI2NNcfR6AVEmLZKpqqi777GU1OkxdFLD7f3g08zKYufUKQZdC2UOb6l6VU6rSQ7ipQSBwFYLFPNLBnumJOXegXa4ei/X+ftzeAxYB6Yro8RRuITNarhZO9q9QMh1nheefHsut8nv5wy8u6mmMUVHexuT0NTL958z/nhAtd+eXJK/PW8lefr+GtlN0EOLMtBjE5M0JqEBMRoingi9k6qWvqcka7RA/Wj3ik/aZeNDv66iyKf7zxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBHLkc8pg6yu0Ayi+S/ScCycvBYdg4GCvE01dbjXyMc=;
 b=T4uq9MwOL0mgWOI2csiQBySXqWb2idA2XguWPmIU+eRdnb6dVsho3mFs2NeePOg7ZBwYWKHjMWonk77hii5+9zl/tGoFqMbcXVlfFcKsNnT3N4WGFv0i1FLiJ3gynirrn8msc3a2yBXd90AdhUmSA/0AlETSt2OATdwgVhS7SY6BCgY5YPrnLsogmm1jkvduybAItCqcOAmV276nPpG8mrBpV+MB6jXsaLw63rVO9NchbrNvzB9Pb2esTgqzDP76ctsYR2pwTq15UusrRxwSQw4YqSChaGgYHNfLjzxRgcZjwrlvjWfdasa2wpglFJJDvQ2Bi1PzH6a1jwpg6VW2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBHLkc8pg6yu0Ayi+S/ScCycvBYdg4GCvE01dbjXyMc=;
 b=ndxlmvjDP7DZG0TWXGnx9Nsfld58KbJ7XoCcYZapvuUSWOUbM1jhN57a9s3V5yoi9KEm8hYYi5K/urpCwEudPVL2sOKMtcK4BaTaUwYWnKksBO88ec+84sJ4Lp9ApaB4YGDQaeXiTZMzTovm/z8tkuUrtfrc9rAbutteZM1QtpU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 08:33:33 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 08:33:33 +0000
Message-ID: <5302a714-795c-4888-b0b8-bcccb8ad6890@amd.com>
Date: Mon, 23 Nov 2026 14:03:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: RCU-protect iommu_ga_log_notifier
To: lirongqing <lirongqing@baidu.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261117023031.2124-1-lirongqing@baidu.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261117023031.2124-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0210.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::15) To BL4PR12MB9505.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 988dd162-0039-4d9d-c06d-08df493c75aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qudpLgqbNtqIwrZKPA99q5GNYsCAgfysyoqIHvTqwDSfDKYdglWPcSMAxpOrU38+0Xw0VWCFX88BcJbVU3Fp7eTtLrWBNOGvfZyduNxgwOuPobkOXlYPBnTC4bDNWeCg94AYKNh5isZjCcD/DorkAJhU678zGxEGVBRnfYzmubOdAv09+M5kriKRsOp42WG5dITup9Xoms9VNCDewq3cE3keM/eBjEYAJgjXOcGNDMSV0GbtVRe4iWEw7NMnjxvvEYAYH4LDyTomiylB2bvgYdQVpqZktC1TzXtdLHKld7A0t1zWKJNRZDQ/vJhXsq5jKuc3r0MDw6zjZwJushTMQnHAXjF+6KaVB8F+dUImaCbcI1R4f0qks9l6vnMT1IXQcV7DPrxjAeLmfrLPIljVXE0aedqk8ytC3lsprOO1NyoRnX2uaqPrYFKFLjrckyWO7Akx3PZnx2YyVaVK9xjSnd7te52AdUYq5lQB2+M4kvbAXR3gFGVcA7DhIUsDPEg1RVjc2zt0YA2Qm6HgY9elq2hFiXhxcFbzN+QTe+rRNPZk13UPmfIJdzHXDCryp8RemgpSq8yGF4Fz+TUBghVbfJPHSHIHWVQIBTzVk0WkrERKUep1QNrhPa9/giGPkrN0x3hMZutUJedS+hfW4NtCDeMzNfbyVcSCFRHlEy/ygtE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmcxUitObnVYRkxJVVFCRFNUQzRMSk50TUh1Vm5BL3IyZVk4YXU3R1Q2Tmcw?=
 =?utf-8?B?ZG9kNE5NT28vb09UVm1IOWlxSElJL2RoZFg0UWxXTk9CeHhJd2dmQzNpNlZx?=
 =?utf-8?B?ZFQvYThFNlcyRUdXaEg1LzVjTzdRYy9idTVvUWhoUkNMbndJSmdVQ1F0VjBH?=
 =?utf-8?B?eFNJcjZGODM3OXpwSHhRQlVaUzNzWXZ6UFJ1TjJKd3JGcUtsZkJKN2JzOWhY?=
 =?utf-8?B?WFdMVVlUWFppdEVkQU4zM0tZT0xFZWk2d2dlb0EydVBORVhsVThzaXhOQ25U?=
 =?utf-8?B?c3ZDcmlhWmNPSWNyZStxN3ZEUkp0U2ZoMExadVpqeE5lWDlXWHlwRlJRdURV?=
 =?utf-8?B?Rk95S2VpWjZzQStyTks2OEJHOWNkTUVNS1YwVHRpbzhncUZlWlRsaHF3VjlS?=
 =?utf-8?B?TTNyU0xLZU15M2VDeVQ5UzlTWDVKaCsrazBDOFZkNXpNRnlVb2dpMFRjdzBx?=
 =?utf-8?B?bE9Vb0QxSDdQbTJBSWR2MXlVd25kNVpKVkhJR3l4MHNQT25sSVRPUEN5cUx3?=
 =?utf-8?B?am9kaWd4K3VVZWszUDJQZEZnNkdhZW82Yk5rK0ozQzQxVG9PMjdBNXFFb2M5?=
 =?utf-8?B?dGpxaitmRFBkb1JkbXFZdGgyc0FuenZSQmR0ejJydnpjWG9hTERmZWM5QWda?=
 =?utf-8?B?OWxCU1hBR0owNGRZSEp3clNJZmNiVEZLSGxpWmZ0R2xpdXhJbTV0WWNrcTVN?=
 =?utf-8?B?Z2E5ZmVud3Y3S3hrc0dJaFduMENNWEVpb05WUW1QbWgwM1h1ZHpXNDhVRVNn?=
 =?utf-8?B?Q0lkV3pNcWJWbjQvQU9OVlc2b3hEdUk3S3pjcjRQaFlPQjhZOGRFVGIzT0or?=
 =?utf-8?B?ZnpadGZNY2sxQmp5ZUM3SFFhTk9ia2k4b3pWWHk5cE1hODZCeldvTktuRFM0?=
 =?utf-8?B?K05FblFjREo1bW53Rkl6VXZFQVBhRDdhMFU5VnEvYjJYS1Mxb2FSaWRhSklM?=
 =?utf-8?B?VjBHMk85dVAxRDR4RlJMYWVCWFkwcUowL0JaaEVPdlJXTnZsclc5N1lpTXc1?=
 =?utf-8?B?dEgxZ1ZEdzc2anE2QWwzUFNRTmNjS3VnSi90MnQ0Ky9uRzhJNWcrUFlFdDBR?=
 =?utf-8?B?QUVESTBXRmdrOGpEY0xEcUlxeWlnaHg5aE9DOHhQbGZ1bGNmMDhuUSsyK3lt?=
 =?utf-8?B?cVlHN0xSV1NsbGhyWDV1MDdSZnRHMldWRGFFK2xzZDN6SlhKYXNkemZzTUlx?=
 =?utf-8?B?dEozSXE1ZXBBcGtkVHdENW93amJiRVR3Tklyd25yWEYxaU9vS0R4d1R2OWU5?=
 =?utf-8?B?RHIzSk54bjgwRURyci9RbnUwMjRKQnYrcjB0bjh1ak1KREp2Rk1FWS91OHhU?=
 =?utf-8?B?ZzkvdWt4UEZvd2ltZy8wOVJwWE1qeTBTRDY1QjF6VGVaZVZOUjQzcWNsVEZH?=
 =?utf-8?B?ZkJiQXg2UWhES0dpVGF4SnVNbVlKUndTTys0cVJYcFlyYzRPOXp1V1B5cEQw?=
 =?utf-8?B?YThXWXJHMk9qNytXbTRXWldrRFhaaVRlTlo2WnE0RGpuMzFuZGl4VWlmOVZr?=
 =?utf-8?B?YW1TNTNyMmhFWGJXdzlSUDNqT1ZXL1cvL1psOEwyL3dwZnhpYUk5aXl3VjEw?=
 =?utf-8?B?SnoxcXc1dVpvTUlkUTdrMHloTjBXQzR4NzN5cEVTbWcyOTZJM1NxaWVhUlJX?=
 =?utf-8?B?YkVrTktsVHQ2UXI2cUtSaGJVY3hRdmJuN2cwelJlVlg3QWpNbEhFdTJRRGVa?=
 =?utf-8?B?dmJFY0tpRzNINmEyeUNXb2MyQ29WRC9uMk5wc1prTFBiMU1rbXdXWEhvS1dw?=
 =?utf-8?B?NmkreGZFYUdxMFhIRUVYVERpZWtNMk5TREQ4QWpDSTRCc1Zjand6SUFHQ3FW?=
 =?utf-8?B?ZVdlb1NPNzBhek5hblNEV2RpM3JtalFlWkpFcWdoYm9DSE5nZEUrYytnSWVF?=
 =?utf-8?B?WXptQ1BPdVJWbzMrYXV0SUw2bkJQclFXc2VDQ1FobTljUFUrekswTS9XUDlw?=
 =?utf-8?B?bDdreHdMa3k0NERKN0pKL1Jza0kxSU81b3Y2YUpoZ0xTdUQ3cVZtVEY1RVg4?=
 =?utf-8?B?cGEzMjBMR3NQTVBYbkM1SzJ1TVR4QlI4Wk1lTkZqQVJHaDBFUzFaQTNrZkg2?=
 =?utf-8?B?YXRzNGNPbDNHOEJGNUFyQ2tFVk0rZmRYTklvdDYwUlZTNzRXUXBXUXQ1Y1Z4?=
 =?utf-8?B?cjNoSFpqTkoxOGh6bkZldDlZRGMwZUVubVZybFROMUg0eGpCQ3BaN3VHVVRs?=
 =?utf-8?B?OTRIMlZ4bkFVRlZrY1U4ZFAwZmxTTzZpdXBRNUd6c0J2cEtVeUNnbGZUd1J1?=
 =?utf-8?B?VTZKUHE4VE5IMlIrZ3NGOC9UY29yRGZzQlNpSUJ2WmpJNkVnVkJYcXJmWjIy?=
 =?utf-8?Q?ykWxWWlklsKByYSWjZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988dd162-0039-4d9d-c06d-08df493c75aa
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:33:33.2016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lM2+WV/BEcYqa9DxIy6TxjpO5/eLQZzVwU+f7ItuEWrNLByfRO/GzeU6iCrB5po4oweL0th4cwC4H1/L7H+WWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749



On 11/17/2026 8:00 AM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> iommu_poll_ga_log() accesses iommu_ga_log_notifier without an RCU
> read-side critical section, so synchronize_rcu() in the unregister
> path does not wait for an in-flight notifier callback.
> 
> Use rcu_assign_pointer() when updating the notifier and
> rcu_dereference() under rcu_read_lock() when invoking it. Load the
> pointer once so the NULL check and the call observe the same value.

Applied, thanks!

-Vasant


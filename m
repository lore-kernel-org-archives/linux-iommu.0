Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201304;
	b=eAP8tScQMBVWzq7nAoa/6LO7714cYJXvIVndtGca9n92sTWK3zMrtDIMWjSDCsr67Bae
	 vOm6paRXnbHiJ6LQUxQDdxExuuuEe/i80dG/AZa4DH384WRhT2AYs/qB4O1cqrOvg5MEI
	 AnELcXSItBQ37IqFVbmWoNlVByPRn0uqLO20gpNNDoJ01aiS3AnZL7eh8bXScUPWXMJ/z
	 OnCm1l2umGvrbPWJAB1m/9msWR/a09f18U1WhdAZnYFqiMB/MVPsPDeS7e03jN+66bl/9
	 H8B+4hAf9uSSkBUWtO6w2c7kfj1FiulhvR3G+VC/egZPs4JghlX5fwT/k7C142JRxRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201304;
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
	bh=8bQAqqG39KtvoprWOAKbHcnK1wB1eM/ch/omrtWvo78=;
	b=1Sl+nzvSoR94gS8rQcdIlvsMnKJrCH/Cj6fyFEF0r4MVl3kAEI62+EkwMV/6n1VHF7YR
	 b987ns/kp3pxb9triYht7cs0rnlJIKyd5cmSzIotfA2hpYaCvfyfXiKTA8xIphuJLTKrr
	 S/kfea5Qehdg+JDR9TgKXF4Esj3Que4TQ10H0KMikaoOWEHLpsUrA804z1VA8v9moVn7C
	 ynd/hron9oVGNeMfZN7cnVRqtAgncrjoX3BjfT9U1shSz7SeKQwZNp0FlhevvvLRO6761
	 PW/YSl/FLgeCrXbmEtJ1FcYcb971E3L4OEV8BqN/Xc60FPeTQwxO5gMHYExu51Q6Fjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ghXDYUD+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.45
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F360A260D
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 15:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 284F360A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ghXDYUD+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xM1LdUK4iqDWIjfOU9+Zlvy14KrGpcOTVXQiRXlW5M9DNLMO+97CeMxODBEbnwdEdt0o/cmagX2vEClbX+AWUaHcuGjYPWdTH1w2Dupp1aQHAvvH+n+iLCp0MpB+0fe9Qd+dU0ubcoeiIbvqxPDKDODH89TW5ltzwyVZybM0h7K8yUbIYOZB28ydF9oJ8Dlc1cReZKKYi6rFw2ElTC9O8Wf+dX7ghtf5bIqw7mjqaJhT34RCM3cFawE+JYNlT+s1jMb1otVB0eo33y55jSArc4mPoB+A5MDnUnx+f0ltzpvY07YUY7OYEuZyam2UsHLDuzxES1mvHNZFe67p2GAVpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bQAqqG39KtvoprWOAKbHcnK1wB1eM/ch/omrtWvo78=;
 b=g/IZVAfX1+eB927iw00wGdpIxuZYd3NUdJVcUnG14+jXspqJluABvCwqnkvV+D2a95AzfGbsUaMz1SMU63OoVCclWJvug5RzURKaA632kRPwyzRCSh2+H6dTH0ZyWmqsYoKfdkqTN4OyHk8copcJKukSXd/DTXpRYl3KMWyQCH6KFJgO8qL0/PlUKu8xCzbLYhJ2xYWfzRcn8Vp5sqseL1nVlEeCRg5ri/zkc91EAv8PnFfbaLepWdd2naLpdsou67htXg9z/VCi6yGCoOAALUyODwvYCbSIn/lPUMzEA8Y2Rw1WWzZ4GokF51XvcOhVS6Ez/AnzHJC+NtPBS3F3dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bQAqqG39KtvoprWOAKbHcnK1wB1eM/ch/omrtWvo78=;
 b=ghXDYUD+vMo7u/ZR3PKP7/nvNZ1yS7NnegIFJtEPNTO9qTVh0LF+QeAA+cdiSM85uYul1SOnTSxOa4M/ajJtd/B/+B60ykLu9ydt+C/kcl/Y01jMCURrsDXN6ZJiF7/Z4tUVMWP8i+nMrb0N8KvHiI/Jn6INLXIUlZ7+sbYzmbt9t+5FBbHi1WH1XmNEaDCd2jPAzo6qmXUxre6Kp9dM/xdbkKYQqKTc00Hea8P9gcmZiHU+91mnFytN0QrSku2TrGdoOr0GnY8vA7gMsMquffkwpWUkwp+M7GvnrnPxH+5chK3Y5fcX6x/bMZAwaqb3OOEIuHCmy1LvMsNfOrkR5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SJ2PR12MB9189.namprd12.prod.outlook.com
 (2603:10b6:a03:55b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 15:28:13 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 15:28:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v5 07/10] iommu/riscv: Add
 domain_alloc_paging_flags for second-stage domain
From: Jason Gunthorpe <jgg@nvidia.com>
To: fangyu.yu@linux.alibaba.com
Cc: tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org, 
 robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
 aou@eecs.berkeley.edu, alex@ghiti.fr, baolu.lu@linux.intel.com, 
 jroedel@suse.de, zong.li@sifive.com, andrew.jones@linux.dev, 
 anup@brainfault.org, jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com, 
 atish.patra@linux.dev, skhawaja@google.com, vasant.hegde@amd.com, 
 joerg.roedel@amd.com, tanchi25@mails.ucas.ac.cn, 
 gong.shuai@sanechips.com.cn, guoren@kernel.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 kvm-riscv@lists.infradead.org
In-Reply-To: <20261020094106.92722-8-fangyu.yu@linux.alibaba.com>
References: <20261020094106.92722-1-fangyu.yu@linux.alibaba.com>
 <20261020094106.92722-8-fangyu.yu@linux.alibaba.com>
Date: Wed, 28 Oct 2026 12:28:08 -0300
Message-Id: <179320128834.2412245.6365239689333877950.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: SN7PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:806:126::17) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SJ2PR12MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: e83e3ceb-a3ea-4d81-d931-08df35081460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|376014|261022105027099003|261009223027099003|261021121427099003|10067099003|56012099006|261026140227099003|6133799003|22082099003|18002099003|261026121527099003|261028144727099002|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	fyWY8ADo1JcGjs4lSQBO13arMNVtuVaKym1TKMICnaNoyv0C7Qmp9+ZfAYPQsfe27C8nAVU3Oi9QeQYKwHYBEA0JB/wxhjp7xTLRkMLf9iqB5kDKiA9KWkm2C6tOcbN6+Ao8EdHOQ5BlxL24DMQ9buySFLNrSpJFIowv+81DAJjsA66PDJXwYxdwnWXGSiF4DP+yeHsD0RAoOFu45+NFJoJJMiXSsoRU3vX1yxdSXnGfjpgejSR1PIfOwEwSm/6vFUSNUy6UDgnOzlrjX5m86C2ULcaFILT28rPvmdgU9ZNL7WiqKH3YvjXF81I5B85lKTK/865lgHgEcpQycq6g/kaiZ1upgcX5Ek9HRNEzHJR2A2JMLUlKULQeRa+RcMrjFzOAMvtozul96ni4oSNfRQFiuoogcRUUB1J7kONWfOeKyP3+XlwdMnvyy7JiqDCcRACLAB8/qWhg4hW0u+K/vIFU0TgQFT5yu8F+xYd6HLLiYvK6tvH9amUk8U+3YfOKV4wWZ5eokb3ZUnT3SR/5laRJvLfRVbTULtPmSmOSpmYFLdEfFIW7PQXT6IlO9Vw+fHGquFy0+arxLVejrZZ83hnP25MqFJRGE06xqQZmlkm4WCRdAG7jtoBKa5l+Iy6uId9qhuGa5d3EF0GEr25pnQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(261022105027099003)(261009223027099003)(261021121427099003)(10067099003)(56012099006)(261026140227099003)(6133799003)(22082099003)(18002099003)(261026121527099003)(261028144727099002)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUIrbU9WSDhZNGhLVFVheDFoWGwyOGdoMitXWDZwQ3NLYTNFUVJSOG9CeExM?=
 =?utf-8?B?V2xENEJYN05qR2Q3VUZrTDh0RW5peHdsbVlqNFhiK0MxT0luZmtiYlV3NEdh?=
 =?utf-8?B?Mk81TUx3UkZaYUNheGJGVWNBZk1HUGlqRUNNV1JqWnZ2V2x3bkQwM1VBYVUw?=
 =?utf-8?B?NzJrSkhtczNTUlVIZnF4NnJ4dG1wbjZ5V0s0Y0xJdFJVdi8zMEdVQ3JzWlA4?=
 =?utf-8?B?a3ZtTEpoRUdEeEFWbGJZa2VqUlB3MW9kSjFvcUV0ckZ0SllkZXcybkU2WDB4?=
 =?utf-8?B?NFFBT0QwTGtwbTE5UVhwT09HbXUwZ1dWdGZqb3YvWGhFNTYzaHBDSlJkSU5s?=
 =?utf-8?B?aUZFZkJFYzZLUmczdERIcTZuZENQTG0zbm9ZQWQvUThIZm9KbHJWbTBKaGlu?=
 =?utf-8?B?RW5wZXRJY1M3am55TkNsNStSYTRwSmYydzFJTGUzRmd6T29ndDlNa0tRWVdC?=
 =?utf-8?B?WENqd2N3c2NwWDBLU1ZiNnJmTEwzS2tET0VyVTN4QUliam51YkRMRlBVME1X?=
 =?utf-8?B?OXZPZFEwREFGNHo3MEdVdlZ4S0lvRHNtbXJWbGZVUWFJMzlwbFJGbWIvaXFL?=
 =?utf-8?B?VXJhbWZxTlIwdmw2bGRWcWZzV2w2QWQ4b3RjSnVudFphcWpuYXQ5aW5oR0Fa?=
 =?utf-8?B?cGswaDF5c3ZaYk5ZanpjOHNQckI2TkdOVjhGSFBLT1p2ZVA1Q0hXRzBIWUVJ?=
 =?utf-8?B?dmM1SWxwMUY2UmZjbDBVeVBWcUZ4UW1hTVBRazEwSS9jUmc3QXBBcHZVUFQx?=
 =?utf-8?B?cnpRdzRJNXhHOVAyWlFqWCtMdDV0TTNYQkFyQnc3bGlLRzZhYlM4RHRhaG9S?=
 =?utf-8?B?N2M0ZkVTb3dwNFJnSWV5VmZKQ1I3T082WDd1YXV0YmJnRHRSWUdvRDZzRVc4?=
 =?utf-8?B?SnZRRUNIdVl6WVNuMlJSYmt6WlNiUmVkMEEzc1hETVFmb3V4b0lTLytLRHha?=
 =?utf-8?B?S0NUdEFJU2Z2ckRuMjJTU3o1TWp1a3FYQ0o2OEtWSmhjOVQ2U0FRUkRzZnZu?=
 =?utf-8?B?Ny9rWWFaMXhaeFlKYWNCU2RiWDZRRXFOd3JEZ2VnbmhmZ3NHRlJmOXQwbWJ5?=
 =?utf-8?B?Z0hBNnpKSDEwc0cwTE5xV2toa0F4dTMzU3JGTkY5dEN5NUNmRXoyYWprM3pQ?=
 =?utf-8?B?OEtIL1lzOEgxY2ljZ0dHSW10bXV6NE1RdXJXemxEbjFidWFpb0l6cTMrT1dt?=
 =?utf-8?B?czd1QklqUGdVS3d6RkY4VnN2WWprYzladFJjUk90aHp0aEtqTmVGOWNvVFJh?=
 =?utf-8?B?RDJnVnpHVWx0V1hhV1g5OGpiVW1xa3FaWG5Da2taNTlmUkpRci9BT2VEZHpp?=
 =?utf-8?B?b0lnVk56THhFVS82cy92V3FmaGpSd2w1MjNHVXhjTlprODVYREROZXJEdk9H?=
 =?utf-8?B?VlNTTGpJV3RaODBqQm1XVXBvMDIrR2VKRlR6RlUxdnh2TjhIakYxU0xyN0VR?=
 =?utf-8?B?aVpGdUpjOElneHpWcjIrVEo1NVA0ZTVIWjU1V2wyUm1raWZ4L1g5ajNzakZU?=
 =?utf-8?B?aHJrNnY5eXhpSUJEekZrR2tmU1g2S3F4TkpFUXJYdTBBSGdUaXV6ejJxQmtP?=
 =?utf-8?B?dS9vNzJKUzNBMDlnRXRyVkRUODB6RDY2RUlpR3ZUV1JSRnVOL3l1Ulo3QitK?=
 =?utf-8?B?UjBpNHpOMkJMUjV0V3c4TUxlcWg3MFhaZ3BPRTRQcEFUOGlRRVJ6anJTUjJv?=
 =?utf-8?B?STV3dWNja0NlNnZLaTJXTlJMbDR4N3NGZW5CRmlMaytQTk15SnYxOWxXM1N1?=
 =?utf-8?B?clNZemdIdnVPVFJRWjI5U3VWWURpRVp3WGRMUTFidjRQUjV3Y0Z0QmY5NCtJ?=
 =?utf-8?B?azR2ck9oTTZDMmNMbXZBeVh3Y2FzY3RYSHpvdmxqNWFvdThnMWQ5T3FRYUF2?=
 =?utf-8?B?aGczOEs1TW1XOVB3d2QzT0UzMG9kbGF0NDZGd1JmWDJkNU83RHdDSjRvM0pH?=
 =?utf-8?B?bTFoTDNNS1hzdUJ1YUdOSmdOWEFxM1pvaENRT0llYzg0R1MxNmFUQndFUW1N?=
 =?utf-8?B?UVNSb2JUR25iZkR1dGJwNmpORnZ2M1JzQjZGM2RIb0JPUVYzeXk1RVlrYm0x?=
 =?utf-8?B?U0k5ZDhNdEhCZ2V0bFJJcFdsMjFacDFIY2tBMzQycTVDeVRuWkVWVmZ3M2xv?=
 =?utf-8?B?Nm96akNMdmY3em1Qa1A2eFBLMXN3Z2Jtc28zZzcyUXB5NXZRckdxZEIyOFNY?=
 =?utf-8?B?VzRldWRZendmU0dXR1dST2h6cFNuWUVXWlN0YjcybjFxYlFrVFRyUnlOZXVI?=
 =?utf-8?B?bW4rYjVSOEdKUFFWd2xpNmRNcktOS2dMSzRaZVRNL1hTWlg1SjZxTEMraU5W?=
 =?utf-8?Q?p7dyXZ3EV7eBKD2MVe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83e3ceb-a3ea-4d81-d931-08df35081460
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 15:28:12.8538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I13n4WeLuQg30r9jqH/uQ8SWyc/O8b7nmbU3z5gaGg5LnZsfcG+uwOgErH+81ZLd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9189

> [ ... 22 lines skipped ... ]
> -static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
> +static struct iommu_domain *
> +riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
> +				      const struct iommu_user_data *user_data)
>  {
>  	struct pt_iommu_riscv_64_cfg cfg = {};
>  	struct riscv_iommu_domain *domain;
>  	struct riscv_iommu_device *iommu;
>  	int ret;
> +	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> +				    IOMMU_HWPT_ALLOC_NEST_PARENT;
>  
> -	iommu = dev_to_iommu(dev);
> -	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
> -		cfg.common.hw_max_vasz_lg2 = 57;
> -	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48) {
> -		cfg.common.hw_max_vasz_lg2 = 48;
> -	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39) {
> -		cfg.common.hw_max_vasz_lg2 = 39;
> -	} else {
> -		dev_err(dev, "cannot find supported page table mode\n");
> -		return ERR_PTR(-ENODEV);
> -	}
> -	cfg.common.hw_max_oasz_lg2 = 56;
> +	if (flags & ~supported_flags)
> +		return ERR_PTR(-EOPNOTSUPP);

This probably isn't needed since the switch checks it?

> [ ... 30 lines skipped ... ]
> +	switch (flags) {
> +	case 0:
> +		cfg.common.features |= BIT(PT_FEAT_SIGN_EXTEND);
> +		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
> +			cfg.common.hw_max_vasz_lg2 = 57;
> +		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48) {
> +			cfg.common.hw_max_vasz_lg2 = 48;
> +		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39) {
> +			cfg.common.hw_max_vasz_lg2 = 39;
> +		} else {
> +			ret = -ENODEV;
> +			goto err_free;
> +		}
> +		domain->pscid = ida_alloc_range(&riscv_iommu_pscids, 1,
> +						RISCV_IOMMU_MAX_PSCID, GFP_KERNEL);
> +		if (domain->pscid < 0) {
> +			ret = -ENOMEM;
> +			goto err_free;
> +		}
> +		break;

I'd prefer you make functions riscv_iommu_init_domain_s1/s2() to put
this in, it will be clearer

It looks ok otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason

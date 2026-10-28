Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201302;
	b=HveN3Tnq24ssijrrolVBKOD43Ch13PJRFnZBrfG03sxfM3BCGMVJWd36tdm2siTTllnT
	 dkdx9TU0MSw24/jQKcoUc4C1vDyHcIYqRwbQYwPYK58eiXQ/rqFLGODhRXPd7jNlBWQkC
	 IBvky0lqxtNhBGPc0H4M5Jl7wWCwEhaQ8sIjKVbmzGdAsp/8BjEks13w0zL1AZgmqxuFm
	 AbcO8/QNao7A/zr4YAxcuVUkJ/RAdj2QntBcKLAB9DfcvIJYNyWOV4vwXO96XiAeIzIF1
	 whmsZa/G4yDf9EJeUn5C2XX3UnaNQK9kR4Ebl5hp8hTb9Lret0Um2Roj/ETBUJlun+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201302;
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
	bh=Dm6p8HxsWh1cOh5PczZI459mg5yXmuYOyOmYzz6jDt8=;
	b=YpL8ylCSnYIlXsCsp1gG/3q+6V67E1ptXg9HSZjhxzn8ZQjDCvMEgIbC15huQX9XFlUE
	 LsQ8xDua5h0/hU+RbINSpUTsMW3EHTjnUQzpf4gdF5W4QYtxbLBli3eFaVjc7mBDnfaJH
	 Fl7PCXDhggtpdrQAUxzusZOHWXWPXHXxfi8P+7a8d97uUEJffVoEIqdeUyZrfd6lcsFvy
	 f6NQWhE+MEKFCIzJoRD7objproDS6dvDCfcdhaOeE2S+hLxVkWnVIKUyIIPgzgp+tIYiV
	 xVrfJfzdXp3XzexgfbmQL8oEUeTA6AHCzeInZSLvJArZlaAgtm5eiCMlXmShIhORl3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cjdJ0RhL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.45
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65B1606A32D
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 15:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B65B1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cjdJ0RhL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPUX+ycvMGxY9wIlQIO1T3CTDwwdLgS3jiiPfNftZc/8592L9jCk7cYA+P+L0yywLcnNOOWWSdYjAkBuw1XyOc4/j6GfrjD+WAyoaAyn+wUNUnmbYE2lvAxi0Ginf7ulaSaxpRHqLWUUN6kmUEonW1l9IK46WSFjtxuPlNw/IDc+cvhnnzIgyPy5vR02KP/PyZYX0ddHOAJw9c7h6nTYkWk8r24aLBHSaywmXwqtKlGPlVsZt9UZkFAAk4oLSykI85zOwVmqxhIEvtPGHcaFHniVPb+UDuMk9eaHB9xyKVjulW2qvFbJQkkYy+50HS9W5mJOK0pQb4KbAToSErJN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dm6p8HxsWh1cOh5PczZI459mg5yXmuYOyOmYzz6jDt8=;
 b=frRvcqKc4DKv4vH9jcue1Tz4G0UD0y0sJBppzGoQLC2gZBHYotKmQTfBbNZdJgWxExS9lPVKjhrkcV00kLMjRC4SaS0VlOVUNSIjYzyJFvVV3SLbmis0kiKEY6yv7q1UEu/6eeZKWSMjjhFme8bWI50LzClYSybqPBs93s3gutCyigacpc4pipxXZdRzeA4hi/yUtxpAWuHGvhhDvGfZsrEw8rq+mBme8NoamEWqrDV1dnfX2y5CyzZEwcNA8aaQLR8zy837XtzcpXG7IKh9LRsGr1MBEQ4Uv8MkAEeBfvGFpkGFANz1GnFMZJoSooOeo+omiLGtjyFRCD4xlUxgng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dm6p8HxsWh1cOh5PczZI459mg5yXmuYOyOmYzz6jDt8=;
 b=cjdJ0RhLH9ZJwsBr31SAK1rmzulGRj4PPI7KQFdQhG2BJNhaUYpjpihZ+dnoD/Nmb2+T1T34Jq2ibfEDO1ddUatrolHuGSlAWcfddb5SO1vwyMgxFQm6PMCiljQgwgZvr0/RMGUFXuUz/wjCSi8P33TDANjgRf4seh+17fTjvv4poGdeNegoEkNz0s7stuwVrU/35iOMp3/nj7qVNpx8fbS5kFO33+V+2tlXwtKacDMNEcPjxMhJGzeMmU12PyG28Q6g85xXaOgUgA/4l9UoweTrpYvPXotOBHcCYgs9WKWPmUJ9QgU18G0QCQHt1ooKF4xXjZBkkFh1FlRKaq506g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SJ2PR12MB9189.namprd12.prod.outlook.com
 (2603:10b6:a03:55b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 15:28:12 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 15:28:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v5 02/10] iommupt: Add RISC-V dirty tracking PTE
 ops
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
In-Reply-To: <20261020094106.92722-3-fangyu.yu@linux.alibaba.com>
References: <20261020094106.92722-1-fangyu.yu@linux.alibaba.com>
 <20261020094106.92722-3-fangyu.yu@linux.alibaba.com>
Date: Wed, 28 Oct 2026 12:28:08 -0300
Message-Id: <179320128822.2412245.18057421761821263913.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BN0PR04CA0127.namprd04.prod.outlook.com
 (2603:10b6:408:ed::12) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: e2b82064-f44f-4f4e-06b4-08df35081438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|376014|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	1m0RTrZHJ5quurgqVHNnUdj7/BNwi0V8Le3yUteCgT8gsUOOy8FxQDOZhNpA+ZCDyYQ7ln1bwAgt4MF23TrsOI6LM7/6r8ASwF8irMkD6fKWUIfrI97GI74iJekNkKyfFGusO1b+6h2A6T0/Yu4lk1gyNZv4UZuhrKgVYy855v5185vI5pnilEGCjEGBYN+Cy6FFBYw+HrAUm3J+d2OvJMkosfXGFn6v2FQD7MMithcOQkJS4J6Q8r54OSEam7oniOll818Td795zrikErlcSAGahmgTdk8Ta4WnXJ2EC5fHyV5hQ5Yu5SVnE+CzplJ/viEKm0Af6s1h9/IevGqYKx9XCmlsTTwwv6VIGKK7YD7YUXj+NcOU5Zt8RJGQASfXRhDXzJdApV7a2ru9meChSSY5oQkeJ3cDMwOfqvRGHfBLOc0hBdbNqdSo0OcbSbd+S5Bm8WsecBGbdsKJF2GHFsOGdaD+5hKV/rd/XGKmRHqnCGuNKakMAFpMXoMKf01U55KjUo9FLwDvt88NCB+YdoVTUVS77qEwF/4q7J3pJwYemh+eRwD+7/mGYI3CZn2fXMz31xqchNk9CvAq9LbdpRY6SoQy2MjBjGQ7Dj1v1sD4tWL1vGkkDf6l59mprGfK1v/5ZLvKifYarAmSU2toiV2ZBuV7gobREaQJoiMgdRI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU0vempUalRVb2tiN0ZNZExBaDU2emZ2WTA3WFpDbXUvVnBQMnRXdkFnT2dp?=
 =?utf-8?B?cTZmdHMvYis0dHRCaEh2NEhuYlVVV3UzQURiWGZ6THl4TU51bmUvTmhKc2dQ?=
 =?utf-8?B?aEN4NFJrbkRNUnVlV1FCcVd4YlZWd2Z3ckdtQmRka0JnOWZHUWxwMFZjTk1Y?=
 =?utf-8?B?dmJtdXBOUFFUMXRxWEJwbzdwZzRxZDMwVVp6MjBLY3RIM0l6dXZ4Vmk5R1p0?=
 =?utf-8?B?ZVQzQ096M2kvUW4rVTVjREpiM2ErQ3pYb1NzYitPQ0M0RDB2djF5aGdqamRW?=
 =?utf-8?B?Zm5jTVU2VkJBNmZGSnRwemRrMXJxZWovaFBsYUJFTVRRSzlIV2UrVjUyRzVM?=
 =?utf-8?B?QmFEL1cxV2FjcFN5UXE2UGFqUk8rUCtnODlCM1hqOU1LZmpzdG9MQnNRNzVy?=
 =?utf-8?B?Wlhab05jcUJFaEdjRE9jSCtKVXNiQ3NhVHl3dnd4MXF6UDFPNnEzRDBhUHZL?=
 =?utf-8?B?a3pqeEpsL1B0QTJtcWE4QnRIcyswRXFaWHhFaVlSc29POVdTelRTMmtURDhB?=
 =?utf-8?B?RDhtNkJOUUtMSDdHRG1Zc1FjaGNJT3RzQVV2YXljYjNUV3J6Sk1uZWd3amVW?=
 =?utf-8?B?UjJOcElPY2VOQ09pT29aZ1BydHRMd2l5Q3JFTUxvSGlBa1VnbXpNZDhNaVJE?=
 =?utf-8?B?Z1IyeDFwOHVtU2ErUXYyUVpiZytZaTZ5OGVaSXphMUtxNjZsYTlWQUljekdN?=
 =?utf-8?B?U0IvcDgydjVlQ3V2QmhvRFZ2V0ZKVlJEWmNGQzBWNmJONWczQit4VlJ0VDA5?=
 =?utf-8?B?ampTTW41WkRzblpmYVlTT3FhTG15V1VTZGRFMGIra2FIWUkvQ1ZqYkVRMHhz?=
 =?utf-8?B?NzRmR0lJVFI5eE81QlNxbThGZXlsT2srWHF2S21QZTd2d0N6dWorL296Ym1D?=
 =?utf-8?B?R3drbGMvVUJZQ24zSzBtSDNXa0lUa0ZveUFuRmp1a0ZpRldSYjJyZklZRmpm?=
 =?utf-8?B?VHJ2aVlzdkp5aEQxVUIyMSsxNGNobWtWNVQyQ2VwQUdFWGdsVHlnUnpJSTR0?=
 =?utf-8?B?TCtVOER6NUFwWU11eUdJbXFKNkJSa0lXamxVOUtqSEJiK0ZEWWYrSCtiYm9B?=
 =?utf-8?B?YVFpdGhQem43T0puZTlYN3k0QWIyN2JlekluUi9iUzNmOWQ1eVhIMU1qNi9R?=
 =?utf-8?B?eWNZODlLdmxrZWZJLytJT0F6SUZHOVV3Vmxtb2Fob1B6SFpYR3h2VmdLY1lJ?=
 =?utf-8?B?ZEt6WEhmdWhuZktRbkUxczVEQ0MvWmFoZFZrc0NGcjVWdHR0Rno5SmZWaHYz?=
 =?utf-8?B?cXVRcy95YTQ5ekdoNFArbU5LOW1sVmhRSFcwVDNPckNZRjhJdnkwZWsweUIr?=
 =?utf-8?B?M3piSHpiOENudFA2RlB0ajVMTGErNUdEeExRa0c5NTE4UDBZaG0xNm1jTUU2?=
 =?utf-8?B?eHpyNWEvY3VVeUVjVG9QYXIrcXJQNUgrUHpMdFBSMmJsRXdrTlVHL0tEWEVP?=
 =?utf-8?B?cjdpVUVUZEE2YkFUSFd4bDVWNXJLdjBST3NkNVlscldDeCtlMzYxaWNNdUZX?=
 =?utf-8?B?anFPelFUeUhtaFVEUGZtZjdIaTdRVzV6UHQ2WDBmRkREL1VCWnVTQUwzY1ZG?=
 =?utf-8?B?U0Iyc2Y5VHd5cFRzK3UwNDB6dTducVJlNEZMYXQ0ZHlzaHIzTW9XMFUxM2xz?=
 =?utf-8?B?U3BwbGYrUXRLL05yZGJ6eXdCeEl3bVk0VElPalpHSHZMT1dtZ2UwemE2eUhq?=
 =?utf-8?B?OUlCbHBEUUp6ek9KNk8wazVRcWtCSzBCMTdWcG8xQ0ZxQ1hZbFMycThHckh6?=
 =?utf-8?B?RWs0UklGSnRqMVR5YjZrMzBkSG53QXFSdzdCcTZNUlB2OFZvYUhWenN1TEE2?=
 =?utf-8?B?NjlRbHNVOWpUd0hDNXlqMXkwUlB3WFFJbVEzM0YzUVhRQncweGNOa0pCbDRB?=
 =?utf-8?B?eHBBY2hIOTZKeGRsRDJUTmQ3THd6Uk9QTDBNVURXbTI2TzNKQUpKVTNhbmhi?=
 =?utf-8?B?M082UjV1MHRHVWxwYjhCa0FMcjZSZ3VZdWFnZ0NvZGVtMFp1SmdUTitIQ3dE?=
 =?utf-8?B?Q1F6Z1d0bG9nM2UrSUVMUzJvaDFlYU5NOUZpYm9NWE1OTVV0Zm9yMUh3WFJa?=
 =?utf-8?B?bkU2STZKY3RaQlN4T1ZWZTdCL0x4T0hkQ25UdU5tRFNjMk12L3RkRDE5Z2Rh?=
 =?utf-8?B?YmdiNmUzeVVTaCtibG5RYkVTQWlLTDBLc0F0R2NmOVVDQjBDUkZlZER1OHVs?=
 =?utf-8?B?OHVZUmx4NU5tVWUxT1J1Y3BvSnFSaWdqS0FuU3ZDdVFNRHhEeVc4Vys0R0ZK?=
 =?utf-8?B?U0Q3Q1RCU3o2TjIxWENXYzNMOHRlWFRRWm1EWGxwdUIrUVpJc2RGWlRyMmJJ?=
 =?utf-8?Q?CHHvqLF1aH1NITjrkU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b82064-f44f-4f4e-06b4-08df35081438
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 15:28:12.6048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZy5oo6TryPE3thaqLFPFq+1pjBwjqY56Byzv+ZntK4y3Z6SvkSde9QRrPlw0Kro
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9189

On Tue, 20 Oct 2026 17:40:58 +0800, fangyu.yu@linux.alibaba.com <fangyu.yu@linux.alibaba.com> wrote:
> Implement the three dirty-tracking hooks required by the generic page
> table framework for the RISC-V format:
> 
>   pt_entry_is_write_dirty():
>     Check the D bit (bit 7) in the PTE.
> 
>   pt_entry_make_write_clean():
>     Clear the D bit across the full contiguous range.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201303;
	b=OIdZN5rtkRDWN2Wt/hmXYJV2NDCUcRWIQYV+/Fs7KxJRBlOAnNEEcYJLglqVAdHiRunZ
	 zExR3B8DTcQC0ZEp0VfrtNpyPwP2dRXz9SNLrSxVlRk+QHesGm2YDU05VZrSFLEM343WK
	 EXWGP38K9mWI72cTYGHj7TBMvAIxrnwiLjRmHg6xIeDqN9qAH9uBQgbN8HHLsZ+q6c0Rq
	 8kJYzszc8FjE+hQ/avjinpdD2spEogOA1Do/ImoRY2zyQPADf9/7F1m+dqWZCyaC7x50n
	 vkGpretu/ltzRfP73k1lFFOTKMKrP4NtXZH/wsFk1NYrMpRW0/ArYYtlNnWYjcJv93Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201303;
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
	bh=DiOoKy2swibSrfZKnUNN7+g653qg5K1Ql/ambrPT54Q=;
	b=YJwT5J/OfSRsTYSIhjfIOUbFu58mdXsLn/3TTE8n/eRja39WJfkXvbC58IEoxXuptTVd
	 B6Hj2XuapcfoHi/UA3TbvmPaPkUzwOfAzZdmn4MHF2yvrtmGiwaZ3a+BRVyTJNCOSdx/v
	 /Ik0ymeFb3XZX2YxdO+y5ZEBu2p6uWjY6MhhF6rEhlqnqSwVBCzBh3cPQpIiIBgmBM3x9
	 vvp+QS2jxSYCiT0v/AuwzPVEm0lzakGfBq5IjJW1ThjOSgi6qMaDuoQW2mOK5F3ZGxR9x
	 Nq9j0asLXeYnCvfIBfuerkBBguCjrhP9wJ1UUlV5WwFoURZJTSBXJWPv5z1NKpqyWIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tIeE1vA1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.45
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5085860A2607
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 15:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5085860A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tIeE1vA1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvStk6P+ryUZsA8R+j9oaHcKCYsYAINOfihzSmrpvfPcLGnkw7dIQn1wkkToiRXeECTgaZGcLQuwJAIdqBbH1OWDZ3aeDcCGIowYy5awfrFgvA5Ep+aQI9C0GMhrvgRAv5WqmDu6m0WYRRO1BxGGF4dtMPzlUaXeRkdYP2I0sfPL8GnE9cpvaNDTnBVcm2zQeh5wgnxgQsWB2mA6Odu4C2Q8DyOE+wpz4pO8WOHyDx9AlkifzsPgV1GBNNBDId2ORgWbEKQekaGQnzxiR1VRehTn8UfaW3+5tjcYxrhX96B4HPVQYbPskQePAyAlf8j+W9EqZv0NK4rJ3/7KczjzWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiOoKy2swibSrfZKnUNN7+g653qg5K1Ql/ambrPT54Q=;
 b=u3r1eBMogO4CPa/V7CfukzNl2Xa/chaY86fNEOUfov7G1W8JYWp0Kxe6BlWZNw2I/5Wd4Q1pyVV3w8sMQQwr9tbFQ0e8rklUO+8CYvm5YOwTW3ncxhWGpLfduCUBqdN9WqBI39oGEqJFejJ49KJN09WC6bSpHApPgSW59Vt/c4it2FAANGMbT/5hct2rbIVuCrRA32s+shKAWEVBvvFW3wAZEMzPfNlJJqygjEznqwIWzhR1RZa3eQwuyBdNigTE9PHnu4745059jQlcJg5DnXgfJ7Qb7hLSCi+j5dQ7P4p6sANDqcz4WMs5G7xrzgKe0Kkm1VMitMzDepT8zsKRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiOoKy2swibSrfZKnUNN7+g653qg5K1Ql/ambrPT54Q=;
 b=tIeE1vA1uTaWKg4RlU4nzE0xiQmwE+Uqwu9V3BpC24xkJICy5K32Z/UqApgLvKdEoh9OpnvriQIhn+++7Er3VS5qM/+bNzwdiVYm/QyPwS906V6lAMpN22Po4xb3vQDInTzU0sUDfxnbMj3FUxK9taS4udAEYO9/KNvZ+x+3od8K5RczC/SRIbwuZxMVWrTJUiwX3wq2ZzWr3+FI+3yXATI+q6nrMK0w1bddS8saZOsAS/yX1T+ThXmyE4aqA6yCCbvuQS740xi3AMXS3b1Xrh/zcNckNZUpGqYSsp2oSohXRMKRrzD3qQ28Zf2bImKrExZkiq6Af4vIXDx0tE5FlQ==
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
Subject: Re: [RFC PATCH v5 00/10] iommu/riscv: Add hardware dirty tracking
 for second-stage domains
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
In-Reply-To: <20261020094106.92722-1-fangyu.yu@linux.alibaba.com>
References: <20261020094106.92722-1-fangyu.yu@linux.alibaba.com>
Date: Wed, 28 Oct 2026 12:28:08 -0300
Message-Id: <179320128818.2412245.14186677086155168748.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: SN7PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:806:126::7) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 63a5c481-7949-4a4c-7dba-08df3508145b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|376014|261022105027099003|261009223027099003|261009221227099003|10067099003|56012099006|261026140227099003|22082099003|18002099003|261026121527099003|261028144727099002|11063799006;
X-Microsoft-Antispam-Message-Info:
	89KE3u2wiI1QJW0+JWwYP+v5oL8k/a60kRRPR+QFDJ31G7N9gL3AvPBe3przIV1L60YwzQEZmqWBUdZ7D9OQOWs7SWSlVGHlXNR377x1isGle9EpIlse4RdLFk8Gkk5TYxd8qzMitseZyShfh/CX+0IKf9wFnNY9audDs48BoLfOqSLAUYLGglFt2IZsaY74wDRvE3+rILMVGWi0bPKo11mdXYE3L/VC04NzBzJY5mp5GMCsD8skUXPaGnYwbkK7KiTi4IqtPVmViG7kbuelY2tKxOZU5JYTRJT6aagb+Y0TnZcj/kYgnle/u1uHDhw4bpo30SouLc3X8GjIMNXjzpnNYgte/A8bfv8NJaJJn/QLVhIik0BEcy6btQDR3xeLSJMTYVMhO+fdhmo+OZy3ZX9DTQoSu3jVO7+5UAs5HVriRu37nOQCv050xL1zg1NUQz/KdsW5O3SGieiKtchnM5M71n2rxwPSPyr+Rh2mQnl9uA+JeLpiw/S1RcQ30Jc3mpikQJTwSpNiLVrWrawBU6ExPRHEMPcPaaP18bSX24FZuIUjJtMXkPMnyiVCcLeZ91KF2ba/Jm5bZFaFAg9iuzHryoggL0Jf7s/BBpUVALD5pibkYL4BM7txayZaUIfc6c1c8MUUUOkHE5si2HdqIxuBRCRePKbfdV5qq6+ZUTY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(261022105027099003)(261009223027099003)(261009221227099003)(10067099003)(56012099006)(261026140227099003)(22082099003)(18002099003)(261026121527099003)(261028144727099002)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTdVeFpNcklJTys0YXdhQzVGenFBdDd2S3NIR0lMQmNlUllvd2tLN0N3bWpC?=
 =?utf-8?B?aEVRNjFQS29sNjlJSHVtdmYzWWM0WG9pQngrSUZmQjAwNS9MNGxGZE9zb21i?=
 =?utf-8?B?cjRZVHh4dGxVd09YSWgxemswNXpReUhSL1pINzlmNldFSW9uTXg5dW5JNDlr?=
 =?utf-8?B?VmxLbGRUU01uanlhSi9LcGFQL1c3czFMRjF0VzdJOCs0MitrWmFwVStqaFpT?=
 =?utf-8?B?V2ZuVmxIdi9rTjlnaWhYRXhQRnZTWTBlQmpQZXZ4T1BtUDNuUit4MGNrcndD?=
 =?utf-8?B?UTFIak1ySXNrNk1ZSUhRS2ExWUtwaTNFYXZQd01tSjdrUDREdFBtdjlFbTJr?=
 =?utf-8?B?QzlITWJUYTQ4eVFIWHQ0d2pZVHBkYUdEbWhzZmQxUkJlanJnQ01icGVWcDk3?=
 =?utf-8?B?d2E0aVdsT2l0b2h3U3MzQ3Z2cXNnZzR3SUN5QjIxb0tndExUVWg0WDgwQkFJ?=
 =?utf-8?B?TFhrVlR1OUxUODBGYUhnS0hIeFZja283aDhMQ082a2c5RGFBUGVMTVZwOHpP?=
 =?utf-8?B?dWtqYTBJN25PZHBtZHVsQ0tmK3RWWVNVQkltRHBLa09pbitlOWNLNVYvcnho?=
 =?utf-8?B?cWhVSlZyaTFEN0MrUU4rMGtUckpFazJkY016N243NjlWUDhvQXI1UitrK2Ji?=
 =?utf-8?B?blJ3amtZZjBTcWFOM3pjSDNvRWcwbWJmVlZWRi85VEQySkEwcHk0dDBwQ1VJ?=
 =?utf-8?B?QncrT1ZRVmlqcmxaSFpnV085dzNCVGVsWERWeGRhMG9OaUx6YkpTelBQZWxJ?=
 =?utf-8?B?eitSMGo5cS9vNitmOUsvcDJVK1l1YjFCUXRuSjAvT0lla3VaSjJYYlVjMnU5?=
 =?utf-8?B?R0ZSN092M3JIbzcwRnFIOXZBSlhmTVlmZ3I1NlRyT1JJc28rV1RlbHhFclN5?=
 =?utf-8?B?VHZybEJaSjZqZFBpK1pPdG52Slg3QVBEdTZZQU5BYUhMZ2tBYVBLWUZhSS9q?=
 =?utf-8?B?Vmwwdys1ZXpZN2NMYi9NdUV2QWVMdC9wVW0vRDZwMlVUUE1VeGk3OVFrYXJo?=
 =?utf-8?B?Mk5Vb3NSa3hsNE5EY1c2aTJsbFp5bE5KS1BxWkJWNVZzWlVSVDB6Y0hzTEJI?=
 =?utf-8?B?MFNzVDI2OTF5U08zaGdLOWo1WXpaZVMxeVpaRTZwczVtdExSQ2tRVFRkTHhB?=
 =?utf-8?B?MGF2clIwUlBLMUVldWxDZng0TGpKZUdHNThzbFdxN1c1MGlEL0w3M2xjVTc2?=
 =?utf-8?B?WmcwQUdEZERpQXpBN3dIRlR1ZklZQ2Zzbk03Y3JqV2tyS1NHUTNsYmphaUUz?=
 =?utf-8?B?cVRObVdFU2plcSs1YUwxYTExZ2RlclhZWGUxV3NjNjE4cXZLTGpVZENuSHo5?=
 =?utf-8?B?Y2FEMms4b000MUUwaWVEbThic0NnYVhGQ2FrZHYvTno2YkhTZjQ5QzdaZWNB?=
 =?utf-8?B?WU5acVlITzlXeGk1c0dSL1hmN0twcHBlT2NXblR5OVNFOHpjYmFKUDY3N1VZ?=
 =?utf-8?B?am5ES0JrREZDakY4TEdIYWExV1pMU3FVOHFWWXVydklDWFpicENJUk5PeUE0?=
 =?utf-8?B?djcxcVlMeDFrd1BtR0RIc1pPYXBSODJiUnJBa3h1N0QyV0psaGNxcFhsY0dG?=
 =?utf-8?B?SmkwdDNteGRVN0wzNEFaRTlrR000bThONVROVkw3UzJkQ3hiR2RFeGdkSk9X?=
 =?utf-8?B?N0hoTHNqTGxYd242Ym9FajNEd1JmSmRUb1EvdnA2RDFQSE5OdmNEL3B5RHJz?=
 =?utf-8?B?NkVaYzg2ckh6MUpZL3JUREtraWNiQ0RtMTMyejJzcW9qNm5hSCswOENCWG1i?=
 =?utf-8?B?RWcwd0h4VnRpSkp4WHZ1ZGpOYW5QUzFhcm5XeTJmQkljeGtQVEVMRGVoRDQy?=
 =?utf-8?B?Vytxd1lDMHB2NFRCNHlMbDI5STJxMEJWVHJ1NGFXU3lVNkNvYU9PU2dmVElW?=
 =?utf-8?B?THIzOG95UWRJUUxpK2J6eGZIazJ1Z2J5cnZNODlzZ1p1d0JIZ215ZDRTL2g4?=
 =?utf-8?B?UjFJSWdHSVQwS1hlTUI3U0VvK2xYb0VvaXd2aXRNRU85RjE5cVRhYTF2ZWxy?=
 =?utf-8?B?bEF0TUhWbWQ5NXZ6Qjd2cGkrY1gwVld5MTNZWEFrRkZzdVBwM3VkbU85OUUz?=
 =?utf-8?B?eXFuOS9tRUxac0FmajU4d05lWjBIMU9KTTJUcU9rMndlL05ORkFLOXlabXhM?=
 =?utf-8?B?aVlQT2JiZlEvYmExTmdKY3RUcVFnYTVudlR5dUNEZ3RXSS9yWEpJUXl3K2Nl?=
 =?utf-8?B?TWNRT0tWVGJWcVJIU21MQjJzalBHSWZuNytRaVBzSnRoY2p6dEJVYTBiemNh?=
 =?utf-8?B?RmxaTTJwUGk1T3J1UjFPNEg5VHBLTC93eFhnZ2NHQjVjNjA1Q2JDaFVIc0lX?=
 =?utf-8?Q?WUB3QPvopKvFgYK2tg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a5c481-7949-4a4c-7dba-08df3508145b
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 15:28:12.8193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSQvDvvmtiT7ffpbhnF5V4qjos2+Jq74bQtEGwAnJw379tf2lA7zUvSdRCRO/lYK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9189

> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> The RISC-V IOMMU architecture defines an AMO_HWAD capability (Hardware
> Access/Dirty update) that allows the IOMMU to atomically set the A/D bits
> in second-stage PTEs on DMA access.  When DC.tc.GADE is asserted, the IOMMU
> autonomously sets D on the first write to a page mapped by an iohgatp
> domain.  This series wires that capability up to the iommufd dirty-tracking
> interface (IOMMU_HWPT_SET_DIRTY_TRACKING / IOMMU_HWPT_GET_DIRTY_BITMAP) and
> reports IOMMU_CAP_DIRTY_TRACKING.

These patches don't apply, so sashiko couldn't run:

https://sashiko.dev/#/patchset/20261020094106.92722-1-fangyu.yu%40linux.alibaba.com

> [ ... 86 lines skipped ... ]
> [1] https://lore.kernel.org/linux-iommu/1-v2-563ee63886f0+1209-iommupt_armv8_jgg@nvidia.com/
> [2] https://lore.kernel.org/linux-iommu/20260818092444.42755-1-andrew.jones@oss.qualcomm.com/

Because of these extra patches I suppose.

Please figure out how to fix this before you send it again..

Also no base-commit trailer which helps sashiko apply them.

-- 
Jason

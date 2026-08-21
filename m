Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4E36F415;
	Fri, 21 Aug 2026 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787327835; cv=fail; b=AxfZoSElJCKK/a1TJD99iWXAhSp+ZHZ3NOsh5FKa8uJoYmFIez4fxfEKBmHVOahDt82TZEaEvTA59yOWYwLjN5Hfkxu+vW0vUMQ3cb5PkWpZNE6WN3ixXubZVUqxBsV+QiHsnHKm89dbxyp5l3wWOBvIoU55of8ZtmhAOgjI33g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787327835; c=relaxed/simple;
	bh=j2DZ0izb/B1ZUYXTGyAmPc/G/8KyRXn7+GQ3KL/RLEc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IPgGn01NBi+h4o+EgqF2XroldynDJ+DSafdAU+Oqb0gCQ/ayP05brEfHKnzYuJmf8Pt0x9w7/qe4BQje7hapwPvK8Q3fbfjpvwtAPy83AQgjVG+vXq9VJCqQOS9G2QH+NhXkfVElIFWydKrX5UIGUN3ymULRylJUtm4x/U/quks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=htwGdy6C; arc=fail smtp.client-ip=40.93.198.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="htwGdy6C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbZjEtHZFNcu9S1b7fK/OWoJkO2TrqO7MEJaRkQq3nW9ngqdm8Dh9Y23XViN9Hg5oyRTabeI0ZgfN8MR2CAwiNlPhOKEL88F2xfI+wRbIWshIrDKbEkO/jSD4or8s1gwBO1DRAlhSEOzYB1mrQPvnG+S/5OTRoe8FvNgF/mPjSw5mQ2bteJ3OhBMtWtHH4wAZyFyulKJE1hIsAskMvW0M6GssCQTrxTz8Lp+1i+UNXmuKJ2rg73YkQHcvsyiclxNdIcozVsbsv1THpHnUUyFDdPcCSYQNXUB/FS/c3m40TLLQT4lsH4PE8X5wIwkfpYDsRI8R6hskzCnmT7n8x9/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5cxpxBK8r7i44qID8v5iWFEv531cG8tjKhpPoMjpHs=;
 b=JwjnCxwsmQr1b45bYES/olfcN1oFRWoqrSVbiSfIrv8gb48Wtlvt6IFN+3Q/DaUHLlFqUbBPEHy8Pdb6v4pLUmgMAk25Znnz6+edQtQVvEfDXPouVwjFxpDU4Y4jF5hKaVzjrgLNOWKpN9jj+qocHsotiCVROWDweNMK2NW26XGaJnMT3k7AW8eDLw/tUm1YJyVsYqTolhZY6VWDv+s1GBjq5uqrYJiZ1qWvUoP8DNC5f9AM9K7VA+1yV8tNy2h08fQcQb6lbmUF0rDxf252u+KuOJJuLdKKEjLWiNvF38QORtMTFAJR7XAAORokR7H+UbeDzTDsprQR7sL/CHxMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5cxpxBK8r7i44qID8v5iWFEv531cG8tjKhpPoMjpHs=;
 b=htwGdy6CkMUXs1urfEn++9Xjg2Pp3kUIhai4njPAMWa4XJlsbKGagt37HhJeEBigTw0/y1UWW/CjgZliUturNYtwLcGOV8OjUaGBTZCzslLCEeDpQbQoQrKNY8TZPKAvtNgmP8Ec4sSkW5Uajtigvn9RGqblMk5C0h5K8yqGxqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 15:57:08 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 15:57:05 +0000
Message-ID: <d9b19948-5120-4b9e-a2b8-a6e2ce0c5bc9@amd.com>
Date: Fri, 21 Aug 2026 21:26:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] iommu/amd: Program guest-mode IRTEs for GAPPI
 wakeup when IRTE[IsRun] = 0
To: Sairaj Kodilkar <sarunkod@amd.com>, "Borislav Petkov (AMD)"
 <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Eric Biggers
 <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Kiryl Shutsemau <kas@kernel.org>, Li RongQing <lirongqing@baidu.com>,
 Marco Elver <elver@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Sean Christopherson
 <seanjc@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260821055611.27138-1-sarunkod@amd.com>
 <20260821055611.27138-5-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260821055611.27138-5-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0304.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::16) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: bccaa513-1778-4d9b-0d24-08deff9cd89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|921020|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bCSuBzAeeUzSfBlkiwKXAwl8XI+kTLGZP+cYJQbfrvXMxFEEjI6/3tJ1JxXHvna/2Af3dPSRYXtUt8h/j+No9FVOf5BXIPL5DjqR1qJwJ191wn9YL3FT8btRWKuMIaJzKRc2n0TuhBmYNQrlC/Kfv9cxjyUjzjH5CkWUUEbvfXTkcFaPu2djf1aPY+e66GzrXgw27moIpbGuVYNWcPiIix0Dw7LJPj7mO/+vHpv3fYgvHSedm+3HzbbMG8/iSZs/57l2jPxRwy044iumTWUHT0iPNSH6Lp+9Iv55ZwaNRKF1Y1A7oBpudURXCpqYAUDTLP9ely0HzadwB6KPvTDwplJHElcS03/LDbx9RLYmHigADQDbhV4bE4IPSWUWo/SQ7p6d09S7ZwXlcrzSJ7LnPU1cVmN+R5sVChZGl9z3MYi+NibkjgH4PmmsAa5oGzdYMyZL43B/5KXjFYwZyLpI8KSO1ylEcNiBK4d9T9NjGfzmoHyT0nzXxS+UL8hg3mwR24Gu/2k+eZ5tQ/o6VehfE+F/x47X9dCcKcfCD1l4OeuASyNFegH0C9QiPsw/Rv7s+WkS7SReobxNUOR7XVbc6J17+O/BnkDfqvr6RJBhOjUuzkWOAJGYw+Eyj805XanJ4O0glwivtAhAd7J9e9momIR6KIDPL8/+NMRQy2atjwqJ6IS6dvkqYxeodTeqWO7YI5BSWO3xTP2eVq8SpyScKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(921020)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEFMY2VWZjdILzljOVFPTVhXZ1dtTGVWTGhFUWp2TzV4R1dUNXUxUlp0MVpV?=
 =?utf-8?B?RzdqV1dZeDlnMVYzSDl3TmQwUkozWmE5cXNmYlVVSHgwRng4cmVod1JiT2Zy?=
 =?utf-8?B?UjIrVnpTUkhvZkY0RE85VXhZdFlmY25vdnB6eGpOMVpjOWs0cEsxdEFHV1lt?=
 =?utf-8?B?cmdhLzd4d2NOQVZmclZGRnI5V0d4YVl1N0FOKzB0WXZsMHVMdTFCY1dDTGlG?=
 =?utf-8?B?WFAzQkMzTkJnNFdFMkI4eTFtbGkvM1dwNlNZR0VrVWYyOGExZ2EvbXJDSk15?=
 =?utf-8?B?bXBaZTltNFVsZEthaGE1SjE2Y1hHSGhLR201ZG14Vk82VFM3NVFwSk5tTmZs?=
 =?utf-8?B?RHdkbWkwUUFMVEVaTFcyN25KK2JYaFNFc2ZlcGIzMHMzU3VxYUM3UVRYN3pP?=
 =?utf-8?B?L1dHREdjNXl2eG5jdkRZb1JXc0pWT2loMk5XQXVQbGxpOWdVVi8ycGlsZmxI?=
 =?utf-8?B?Z1RTdkh3Yms1eEtYMzNXTDRuR29yZ1RjcjZ2VWZNV0IyZGVxL0RxbndkQjNP?=
 =?utf-8?B?cSsyOTY5bEdIYlRITEFpMmdmWVR2ZjJjUXNxbldhOXp2aEJKd3Bwc3VLMW5i?=
 =?utf-8?B?SUpMUXlvbGdDdnFmNGdwSzFnZlFGS08xazJVeXh0Mmo2aE1OdUQvTjZ5OUZW?=
 =?utf-8?B?QnFaZlpKYVNKNjlFZXZYd2ZIMm5JOXVNTEpIVmRFbWJ1eTNJWHBrOFNyeW1F?=
 =?utf-8?B?U2lMYUVVb0w5VnovQmJNRVpMRUhXdHJpWno5czRFQncrUlptMGdJU0QwaGU0?=
 =?utf-8?B?Rm1Cdmd0bDFsSHVoVlN1dnpzRStaK0tLU1hSSWJUT0dYYjZhOVIwNDJLTkts?=
 =?utf-8?B?Nno4YnBJNi91VUNHSkU5QmZiU2RDNkRsdVdLcDJIMkR1TDk5NDBOcjNhWmlQ?=
 =?utf-8?B?UE95TFprWG45STN3STc1VmppWUU5S2lyTzUwVU9OeE1QMTY0dUhjUktHQlNS?=
 =?utf-8?B?Y1o4Zzl2S2VHZkZHd2hhbWVGTmh1TTRFWEhUdUYwYVNBLy90clNiUG8yVVZ0?=
 =?utf-8?B?THN0bHpDQmt5RzF3SkhKMUVMWGdFVWgrSGh0aEtvb016TXd3YmNaaVh6S3VB?=
 =?utf-8?B?VCtLMEtZRnIwNlloVTJyS0wvSmtCWlNZQk5jOTRJN0F3VmljNEtWTVFiZTJx?=
 =?utf-8?B?eXR5ZDZqWERsOFc0czNRVmRIM3NLdXRLb0d2dWMrQm0wb3NFdGJMVzY5NWJy?=
 =?utf-8?B?S3UvZVRiNUhoQjQzWUFRaXNmYUF1L2dBei9ZbThxMGtId0gwVmIxcWdNcGlM?=
 =?utf-8?B?TFFNUExCR2doR2NLLzZhSHB1T1VUZ2hFSFZpMjUvTjJ2bktSaUhYa0x1aTN4?=
 =?utf-8?B?N2J1WnRxb3gvQmRObUgwYi9yZjlzVDNLZ0V2SmZ1c2pTSjEzWkt2aU9tQ1lK?=
 =?utf-8?B?MUZDanV3Vkgzd3Y1UTB5UkY4UTVIWW5nMHF0SVErcnBScUR1bGJEY01Ob0Q2?=
 =?utf-8?B?NmpGYzBYdnVrSWoxbm9JdFpjOHVFcXRYWkg2OGFSNWRXWUNLaGErVDlpWDJW?=
 =?utf-8?B?Z1dWS0Z2KzlHbDFxcWJia3V2czY2WmtuSHFDR3JlRFp0anMrdGZuWW9vcS96?=
 =?utf-8?B?TVFaSGVXQkpCRVJPcC9sSFZEeEJKR3NmMDZyYzk4QXJwZEhRVXppUFR2Lzlx?=
 =?utf-8?B?NWt2V3oyVFFzTitmcE14ZFlqZUN0eDJiTUFRWUJuYldxSGJySE9KcGIxd0Iv?=
 =?utf-8?B?TkxlN08vMmJjY0N1cWVVeEFWamZCVjJhQk50dmxVTjdJTm5kWmw3RlJTQ3FP?=
 =?utf-8?B?T3VmSVdoMXVsTnpzM0dqUjYzM2RmaU9NY1ZZd3R2YWZqektmRFJwTm5aaXBY?=
 =?utf-8?B?M1dubkZQQ0h3cUpEcmJ4ZERiaThOSXRVSURMLzVVaE1FTzZDTWlGdEJnRzli?=
 =?utf-8?B?QXZjSGpKNW13TDRSK2pHVkhnT0h1ZnJVUmhZSjQzblFnc3IvZmIvZmM3TjI2?=
 =?utf-8?B?eDV4Sm9MWjU1UFVYN3RZK0dWUkk1V3p1dm1WSndORGltb3YzTHRjcDFhYlJW?=
 =?utf-8?B?a2hZRjBIaytzV3V4b1VIczF4YXR6eGZEeTlGVXRBNjVUQlFFZEVuNDdyWDJ5?=
 =?utf-8?B?QVNjMDZDakFsWEJtcHNFOG1yWm5YOU1vM3M0Z0FCcEdGMk1reVdIc09vT3Rr?=
 =?utf-8?B?N0dHNkFCWEhNM2F4TzdrZDEwODZtRm1wRUhGL3ZCQ0RoSGxVUmtya0xTbTJs?=
 =?utf-8?B?a1M3d0tDdGtFYTZSb2NkMm5kNHh2eWZQVVk1VCtQaEFZRjFwemUvVlNVWFNH?=
 =?utf-8?B?WXgxSGF6ZGNwRENDWGJOelFLNHBYS0hZbnhPQmlOVGp2amgyNDMwejYza1ly?=
 =?utf-8?B?WElwazVFYXhsaTZHblpDYzhycEpkcStROUk4TW1kdUgvREpHT041dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccaa513-1778-4d9b-0d24-08deff9cd89b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:57:05.0501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfj86UGlmUIWJRmPXufwz3yK7pNqlWJnAsYyuNiNSHMeGOaYeen4NfW6GLxLiAzBISxF6CSfrD22m9ZQ7BWbSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558



On 8/21/2026 11:26 AM, Sairaj Kodilkar wrote:
> Guest APIC Physical Processor Interrupt (GAPPI) is an alternative to the
> GA log for notifying the host when a device interrupt targets a
> non-running vCPU (IRTE[IsRun] = 0). Per the AMD IOMMU specification [1]
> (section 2.2.5.4), with GAPPI enabled the IOMMU delivers a physical APIC
> interrupt to the CPU described by IRTE[Destination], using
> IRTE[GATag][7:0] as the vector, while still updating the guest vAPIC
> backing page IRR as usual.
> 
> The AMD IOMMU also allows suppressing GAPPI interrupts using the
> IRTE[GAPPIDis] bit when the GAPPIDisSup feature is available in
> extended feature register 2. The AMD IOMMU driver sets this bit when
> the wakeup_intr flag is not set by KVM.
> 
> Note: amd_iommu_gappi is currently false; a later patch enables it via
> the kernel command line.
> 
> [1] https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant





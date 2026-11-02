Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793631554;
	b=qwgor9E9XrHh5GBzWWslYbm4nKXs8F3hrSnATlUXIzCWKzLCtr30sUaLDBUdqtrelaSs
	 qoMnjD46RvR9yZpVBTrcM0DWX4p4OkT65QFzKQIr3fPLPfCJShaXWsuqlek1E512s15yF
	 moTyfDrPi+gTYSaRfGiYq38iDpt9pyzlKXDr0OXWMLXaaHeXqsgtJuDttivXbEvh8xGJR
	 dOoeoSyYwn4jHr8yCyRgdjqHVTjQxYJ3ynAsuBdAxth15iWfxbnEMke/MpAgUSPYvt00L
	 CCHa1fCM8U14nK0VgrBCWOn5sYEWLMzqZSwVBnaShec8VQkyp6N3t2GSngYtEhED/YQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631554;
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
	bh=LgalObg3lXdbiS3GhXx9FsCoK1ChKU9h1WvsZv5aRsY=;
	b=U+5PBUm6dVuhOoAN9kRKV/q1yFyO5ZdFASE1RYt/K3Vaw6SDOiDWqE04n9CD3994kIE6
	 vNp5s/JIPH1MLNg+Z5uivmfo8CJjn+zq834A3N5Ad+lKUfQeL7+opS6tuMUUZR9MSJa9N
	 GnxzucoOssfg7aMSnX7/olVVbot0jxUlEE2B3kKoPqhIUg2LN70a54CjG+qV/a6GELHaH
	 iRL22TMnZUcptuaZc+I1HfitjMDqe7kQsFCZb4MRQWjl/wu0sdvjxbdk8izbYfiQzhcrj
	 ffCqni9xf7PoW7d7JSSoN/Yizo9CdgvJXXX561iKSq/Kfnpl3Hsc06wdiKPJ9T5a3gQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rGnps6sR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.56
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012056.outbound.protection.outlook.com [40.93.195.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A94606A5A6
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 14:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2A94606A5A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rGnps6sR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dg62RNLh9iXC3ye1B4OnbEOLLTptMQokJo9u0XoAv969pywSSSmN/UZvxqlo0yD3m6MG8Wm5Sou3H5Qk4WDDGBTBbgMLu1JYcvZY29TcZMxzgqJOueRXBgsaXB6vwD1HQ8465B2fpKIFPy/8rKCRhyqPIyzKvsFFeN7br++N0x/h+zv0dDA4KwZUSi/kq/Q0bBzssmCKyGAv0MApM1LLLEt9+oP9nCUqPi6DkkdaombFwqH0DvMA/pSIoxqa4mtITEqU4cufh/sxMOqfqS4gWsgPZuYU96Ns+NSscX6+DTvP3+74n4hmTG3Emyn8VU0gPpiw6ic/vlCWz/Bb+XTdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgalObg3lXdbiS3GhXx9FsCoK1ChKU9h1WvsZv5aRsY=;
 b=VI4ABp0HOOt8o011Imoo/vROkcFHHl8E+zi50Yw1mqclMiMG+NGjSK/hCDMZl9xOMX1AgCOxOCi5lRhljB6t09XxnOlbDZ/l47kmehb7f6YtjRQm9KVnx4yu4+rdIwCsBP0DrA7zB1ldlkayV07f+jWzA31ZHbT/al2mZ2BhHWDWyvY0Jw0pqmL/YzFvf5HW7jgWU5KQihk0lDMNAcSXaD8QgPyfcs5Jrw6MYi/0KY5rQE8/A65F8IRyelfSupoD3/TRlLx37A5yJdRtbG3Mp53Dohpyd+K+oFbOtcjQ1oShb4CBHtPX4EL5Pw0L12LpKXAbF6j80XRIzHSDgxfVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgalObg3lXdbiS3GhXx9FsCoK1ChKU9h1WvsZv5aRsY=;
 b=rGnps6sRQKHHhHXFXzFyVVawrAeGnWkJOhcIvQkdNoQAwcSoJnnsp74Zdram72O196dhYKyJgjW8dRomSbh3TctP71gZcRwaOm5OfgLzorhqHvkoghVR9aRksvc6R0HanmqNaYQCeclu7E2uVnnRqMMXrE/R8zgkG9Dp2GNA1vU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 14:59:10 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 14:59:10 +0000
Message-ID: <4833783c-158a-4b15-85cd-ed5126f8de23@amd.com>
Date: Mon, 2 Nov 2026 20:29:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Clear amd_iommu_snp_en if snp_rmptable_init()
 fails
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, seanjc@google.com, ashish.kalra@amd.com,
 pbonzini@redhat.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261023185041.8685-1-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261023185041.8685-1-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::16) To BL4PR12MB9505.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdb566d-690a-4345-45c2-08df38f1d9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|10067099003|261102123227099002|22082099003|18002099003|921020|56012099006|11063799006|261022105027099003|261022075727099003|261026140227099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	l3jfCHsyRL+I54sHxPyZvg8THluj7dWnhRu6poLXmggOPeEWaN7oqrdCW8v7TbWy1nL5qUOByLDTrfOYvjBOicwE0DcSJONGBdkrMR6QuWK2AFOf2RTGs4P8QaaZCMQ2Syj26QDY8khBLdAM9wMgXNCIto11vlAOksD5QcurYZdbNkQFzNPfnF6mseIETEPn1g5P5M/cMlVMVmDnMw3e79WRBz2uqHisrkBPFsnVElRnKNaTlnADWvtPuVs2ApKPI6VYiAVQakFgdjmtfHsml5OFq8EHBjXxOJHqwbPq8Q2BSHvOPM4h/UOoxdM1+hxTXYOyYBT2cKfULu8XdqEY/TSDlcMbz5ZpkZiE7BZB9zufJanJfiCElIGwtOJ83ai5Vlm04VXb32Qyd1QNCRr6azXggHxgE3Pm05yDSBkFN9w8cQ6xeVt1sEa1aT61pmJRi2qYXJHxh9BvSc+TKHySDrI6Hcuh3+ZRYYShe0Vea5KrVKK4Z5MoLzpWbzgI0PeidnZPRTvBP9GhKtH5Zk4f7sXe5A4WL7AAaV4OqRDc6yK1LYkgQY3L0+PAUnN14mAMxiqe/s76sbFLZ/psIjPTvvDc1tS781wVMvervABe1ZmiNGGx3fSJfkWIq9mXchKC94Qj83Ov4rT2+OBSr8oWv/qPpjnQ9BS+9fD5JQ1iuWHDsI0POlEf5ySIR4M6Bg75puC174keQUGR837YB72SoQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(261102123227099002)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261026140227099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUdBdTZQQkJHUDBrSitpZ3UzejBNN3VHQjVTTHJrck5rbEtSRWwyWjJ0K1BX?=
 =?utf-8?B?S252NWcwd0hnV1d6REJmR1A4OUJicXFUUkg2ZjVTeVpyZ2lFRWJpWFY0M0xZ?=
 =?utf-8?B?blpsVmF6NkZVVjFoUnhFbkFQN2NDeVhPMDNzTHlpVFY0azd5QmtpUWJVVlNK?=
 =?utf-8?B?aFpwbklmT0xWd1dobEF6S01zL251K1Y3MFM4SS9OSXNEOE0xc1E0dDdZQTFC?=
 =?utf-8?B?MCtDOVUxaWtlVXJxdkQyVCtRZTNUQ3I5YjB6YUUrR0pSSTZTMzdCdlNpVCt3?=
 =?utf-8?B?M080ekV1MkpQeHkwcFFjellzc3hic2ZEbVdYYndLQnR1cUVYVythcU03ZG0x?=
 =?utf-8?B?Mi9tRU5pOGU3SVBOK09Ka3pqSGZyWVVVR1QrbW9EdVAvcVVpdlE5d1ZPUWtj?=
 =?utf-8?B?Qi9YNmM1eFFnVVJBS3FoQ2xUUXZVOTY5T05aNTI3ZHNrL3FnUmdvKzNUUHU5?=
 =?utf-8?B?VmNrRThFNFZrc2QrNk5nOFRJcTFJY3RWU2VmR2h3K3I0REMrbDlTMmtmb2NV?=
 =?utf-8?B?dnNla0pOOW5oamtFRC9iamFPbW51RjE5WnQ4a1FER1hoTkNwR3ZjN2xtcTA3?=
 =?utf-8?B?eVdvd3AvV1FUc0FwazJHelZTY3dzQjZqZVk4S0tJRk93aS9TQ001TzRIbXRu?=
 =?utf-8?B?SHM5N1NjeWZzSHdyRURPRXl6bTNvcHFRa1FDUXl0azBhbWtqQXRQY1FMeHQz?=
 =?utf-8?B?RUp3U2t0VFBMYnRJV1YxQ1lic2l2YkYzN0ExRzdrRElWMXZxL0N1c0g0aS94?=
 =?utf-8?B?N2ZZeCs0aGhQNkpBb2VsQXpwcVJDWmpwbkZnaFM5THd3c0phUEo2NllyR0s3?=
 =?utf-8?B?OEF4bGI3cDFIYjEyUTRSL2thcWE3VEFoUXpOdVdUaW9aWC9MbW5kdENndExS?=
 =?utf-8?B?MlIvYnBCcGlqbWRCY3kzQmVnVHgzdEE5RWdJbURsZEJGa2x5bnloYWZnamRp?=
 =?utf-8?B?Ni9iSFh6enA4OEhLUW0zdmhHb0NNVXFpZ1BDTDBSaUhLU3Q1c0JrYmVWanNK?=
 =?utf-8?B?MVdmU05lVlBEelgxMUpLMmQxYzhaRStUWkxjZ1p6MDM4VDdwd3pNTEFnNHF4?=
 =?utf-8?B?TG1COVZUemQyUmMxM0lySmY0QXJwQWVma2l3RFlVYUk3L2JUNnZwNHJmeEky?=
 =?utf-8?B?M2QzUS8rSHZ6SE9HSWFhSGhTR04wYlp6NnBaeHQ0WHhqMTRxVVhJWTN5alVx?=
 =?utf-8?B?d3ZsRzFuVkw3b0liOEwzaGlZU2RiTHNUYlU5QnNCSVJzRlpZYjhzSnZuem93?=
 =?utf-8?B?ZGZCaDExWmhOTGlmdFNTVng3Wk9IOVRib1dXWEFCVTB5VWJjS29GbTV3Wlpi?=
 =?utf-8?B?c3pFbnhFVkZZTllLckRxeWcydlE5dGRuZjI0UFRWQ2RoWFh2eFB4UDRXTDVm?=
 =?utf-8?B?c1N4cWFhMnplRXFQWEx1WkpqajhMNDF4Y0lQZjg5UjN6VEtYWHlvN0ROVG9w?=
 =?utf-8?B?ZTg5R3VvV1pxQkh5YnVWc0hKVzhYajJsd0NiUERiREZHenZCRU9VV1paa1dY?=
 =?utf-8?B?NlZMT2lJWC9GOWdkZFFlMU5CU3BsRzdnRnNaT3hzakMvWUxqL29QR1gvTWdX?=
 =?utf-8?B?N2xjVE9Ndk5Hck8xVjUrS3Q5M1ZNcThMSWphUm5tWW8rV3FXZTRTL3R5TXNv?=
 =?utf-8?B?Q1hjRmhWR0VtRUptV04zQ0Z3cUlQb0dHUSs1T29RSXdXdUtJcllPZ09ZODdn?=
 =?utf-8?B?SlFEQTBxQWpaZjk5MkVndEM5RnhzT3RYUmJxS0pBUGxzdEdTNlZmY3d3U2lP?=
 =?utf-8?B?N0hxMEEwNjRtNVQrQ1hEM3V4djlxMGFEYytRdkxWeXR6TkpFS1ZiNTNYaGVq?=
 =?utf-8?B?V2NNanpxbmo2U3FTZFJaTWVJUVFxSGNtUThydW82VDRKWURIU2lCRURsR1Y2?=
 =?utf-8?B?NDhFUjdDUmRWcU5UV1BsOUlyaG9YR0Z0OVpSNnRsbEh3RVptYkNtaEpSZDVS?=
 =?utf-8?B?RDhWYW1EUGQyY05ONkFjcFJMUzliYVhIL2VzTE5UekRMQ0hSVitaMUUrZUdj?=
 =?utf-8?B?bXh6STdkYkR1WjFIVCszc3JYc1ViTXlTQU9WandqTElHNWpMS2R4TkEwVVp2?=
 =?utf-8?B?QkJLeGc5d3lDTnBkdzIrUjFCaVZFU2hmVmp3bE1ESHRNQUN4VWVEU1g2YUdk?=
 =?utf-8?B?Rkh4TWhrN3FOV3Jia3hRYWQwczN5bUlJbEQ4aEwwOURlQ1F0MW9Mcm4wcG5Q?=
 =?utf-8?B?V3QrMmg2MGpwdXFlakhMWW1KN2VnZ2NXTk82Y1hldlVob0xxRldZSG9lRzIv?=
 =?utf-8?B?V1Zsb05Bckd1WHpwMFRpaVEzRE9Ebit1VWpYbjVHdng0elkydzF0S2tRanRv?=
 =?utf-8?Q?halR3PZLcGMq5+Rrwc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdb566d-690a-4345-45c2-08df38f1d9b1
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 14:59:10.3531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUb2sywKb24/kcVYDhwyRkYkp0mGBBX1kFs17f6Tld/ATYyq7J9A69fKKkDhDir2CxaKetmJLzui1jRJ6/x/9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366



On 10/24/2026 12:20 AM, Dheeraj Kumar Srivastava wrote:
> iommu_snp_enable() checks that the IOMMU can support SNP and sets
> amd_iommu_snp_en, then calls snp_rmptable_init() to map the RMP table.
> If that call fails, CC_ATTR_HOST_SEV_SNP is cleared but amd_iommu_snp_en
> is left set. Later IOMMU initialization uses amd_iommu_snp_en to
> configure the IOMMU for SNP, on the assumption that RMP setup succeeded.
> 
> Clear amd_iommu_snp_en along with CC_ATTR_HOST_SEV_SNP.
> 
> Fixes: 409f45387c93 ("x86/sev: Fix broken SNP support with KVM module built-in")
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>

Thanks. Queued for rc.

-Vasant


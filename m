Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795001112;
	b=ROxO6BTBmxnJy2fkuGd4U7eTlizPYxACN/oVBB2tPgtuTgEa44D9IaFcWd9arrbslKtf
	 LLHRvkgu9WXz2qCXB8gV+g9yq0mK+eQ/IJceCaBK6m+/hy4MqQaMfEbghn6jN35r/2S0q
	 ICczN3eM5MaPt+UoEB3ZgYIVd/T9wyQp/eXOpvB2dqvN0GbHhuqUGDq9EEz+d1xYx9+dk
	 7YFkoBwhTCrmcM0CWKVY9QFp4V6+UqpudehGRj95feCjjal+aW6Wku9AQ56RPxfLnp1i3
	 lllfPs7xUGpOfDDWsC7X0PLGna5fbg56gxOmP0DYVoFdEHCjDyKv701Kj2gSYC9lOEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001112;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=zM3k/2WCvMrCdMm27K8Fi760CqD+YE5EovKRW6Oi8RA=;
	b=mveT2ykW6NVDGaBT+ko/CuBBDMv7lS4+J2qrw4XqUoJQnh4KSNjKpAl7c/U/cj9hbl86
	 2Rf9KVzZHXHB7AquydQcy2L7+BHH9xX5bmIhGXfUQJVxIPEHqQQyt72JB7xnlF1MAiY7g
	 pCDlNYCFsLGvNJJDDsbp/DqSHRRnAoWX7SOEHCQEcvboYMbRBkcXZDNcH2wrK3Z52BDFO
	 FI972cEv0k2Yr9LohOVZrn2xmeiMh8yFtYTT9pl0dnHHwN7cEarY+fRg+RHkEAXo+DiZ4
	 5Jx9P/+/2jqV4LJgLSpG0Y/ziIE5PSHErM1lC6aMRLAfb3+9WJ6YeZpKsEOdRrUo1jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=citrix.com;
	spf=pass smtp.mailfrom=citrix.com;
	dkim=pass header.d=citrix.com header.i=@citrix.com header.a=rsa-sha256 header.s=selector1 header.b=qLd2n2SV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.67
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011067.outbound.protection.outlook.com [40.93.194.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1544606A325
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 11:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1544606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=citrix.com header.i=@citrix.com header.a=rsa-sha256 header.s=selector1 header.b=qLd2n2SV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJgKLig6WnslawOZfsuMRvdo23gTnsuta62R4N3FJIVavCfLLIJeWvj/+hKy9nrFJBr5ykFCtnFxXMF5pNrjmgU3qvERASh4AD3o1HHNd+sA+xkZ1z0Dgrn39vXThfaoDHCURfEf+j/iAfMcoqIXzCrHjyGPAMyaPpjmOYvk7UBiOc9uucfL7yASfoagu88bj9e5mAJh5jPtWPb94bWc0l/PSZ8jP3lbubPsGt0cTfqLfxAAhG1745zaXbNqcXUiWYBwb5Zd6Mq9Q84ept2+TQFvgUlt5AcWtZuyi9mNXdZumPfMgN31Yi7x5Cwudv26u/QSzuXlyAiOpjMg8qDe5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM3k/2WCvMrCdMm27K8Fi760CqD+YE5EovKRW6Oi8RA=;
 b=i6vWGs2LH90jfHBwDZLypd1ubIiFjGbKc3D5yDCot8iIpR5qgKa1N+C7mube300eoDkzE/iG7AU7etPtKxDPrQIUpp/EDizxhO+75iQJGx1dvucnMnmyGPwZ85YMP6Dx0LJkOqZaHaB85eEyJ1ytBRKy6mpuI9svRwCpCYH6+ss5hC1f69Eb1o4K7GiOaV2VhevJRPRfkcwijAXXAHodRFyCX++hvsYvCJ+XtfI6vBic8x7EXM0kLe8ZlpQR21+AvnCe/WZAlV+n67tYeFL+u6PkRg2cwaLykE94nZJnrz594q7KtUrCJla0W+ebF2sGVhro2CSjkIG0/Z8jer+31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM3k/2WCvMrCdMm27K8Fi760CqD+YE5EovKRW6Oi8RA=;
 b=qLd2n2SVmH/37PqLRraugs6QsZTLE3chLZ/6aS8gqviro951JXCAE8kdjax/wri2US74zXv/0avoaLZOafycRtthFbmou+xp51v/SdfAVb4+yoQLxiu6jB5rqBtvb4KRwFYkXyCt4AB4iq6IOzVrUv+XB+jGpvlfTwcL0BHwPn8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8274.namprd03.prod.outlook.com (2603:10b6:610:2ba::5)
 by SJ2PR03MB7166.namprd03.prod.outlook.com (2603:10b6:a03:4f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Wed, 18 Nov
 2026 11:25:09 +0000
Received: from CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096]) by CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 11:25:08 +0000
Message-ID: <75f37608-f3ef-48db-8e7b-4a1ba13a9ee0@citrix.com>
Date: Wed, 18 Nov 2026 11:25:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/swiotlb: Check the segment boundary in
 range_straddles_page_boundary()
To: Lin Liu <lin.liu01@citrix.com>, jgross@suse.com, sstabellini@kernel.org
Cc: oleksandr_tyshchenko@epam.com, andrew.cooper3@citrix.com,
 xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <807c3b040b02d7d89f1cac76eb137afbee91015d.1794573814.git.lin.liu01@citrix.com>
Content-Language: en-US
From: Ross Lagerwall <ross.lagerwall@citrix.com>
In-Reply-To: <807c3b040b02d7d89f1cac76eb137afbee91015d.1794573814.git.lin.liu01@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0218.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::7) To CH8PR03MB8274.namprd03.prod.outlook.com
 (2603:10b6:610:2ba::5)
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
X-MS-TrafficTypeDiagnostic: CH8PR03MB8274:EE_|SJ2PR03MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: e5621488-14b5-407a-63e0-08df45669a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|6133799003|261009223027099003|261021121427099003|11063799006|56012099006|261028144727099003|261102123227099003|261021123027099003|261026121527099003|261022105027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	3hZTY/xAtJzjw/fFN09V3W/BtquT6aHipIx0FfBLebbSxgeJXfd5pPmfIlmI2qFDa+7VnPfHWdkUt0JFonFZnF1rb05do+VTJZ1wmLJVKgoKFqhAQS36cmfdd6XxfJvJqBR8vUSvXqzHJG5M3BB48/RraeTXEgv9GWxaQMyo1y4nSElokxdDjBxalgnBtigRgoHt6CwdMVnAf1RNXQDy7yKwUX15lmuutOU0Dre1PPF6ZviEN+KbD6a14EgCRikqRPt8V1agjc9Jy0kU1K6F2PYPDMJzGUT7qLot1EYeu6GyzIJKxxquSLbnHQXMTT5Nl/a7YwDKlNUxds4dgSSrsOJN5OIL2LypXa71byWH9HsNlgoVOGN4Cmbo1jQxRzPlxKbG1yjIMjb3RtxuodgCfPPeQ4G9pIRnfXAaV8Dkbr6Zp+lOrCWSxpmK7+FqCee5LvAEWByDO3LNu2ZGHQN5j9LVxtNcLJZWU4S0KWEsCs3kJSEkfVWQ1JNTRN6dHBI0YRsn5ExERJjJ5boSQvTqjMg3mPmkY32U519pJ6rSpqr3B699oZxzeqKBA02OSDCrYeAbi4mPJyv5QzpFF0xnWJiuVtqaJgECTggx1qcegSRzXRSsKFYxA/OkRMkTKOCZgrwEU6id93huKNCOoDXoS4trshD5shbgeX/JzNZFkes=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8274.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(261021121427099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261021123027099003)(261026121527099003)(261022105027099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0pMUmtSQ3o0MjVaVzR3elhPdDhTSjFVdXZDRC9kNGRIVWdlYi9LVUUxc05P?=
 =?utf-8?B?VEkwUDFqUjd5L1E0Z01xbnpvOFliTVR0MnY3L01tY1ZYK052eEVMNUFXM09Q?=
 =?utf-8?B?S3g1RWVndnE2d0I2ckNDZGJWN0k1VUZNUjJrTWYwN3F4RHZsWnVFM3JZaHlM?=
 =?utf-8?B?VWZrZFlIaFNzMjVNbXhxVEpTNnZCVHVSbkEzZVR1MXQwa1ZzWG5nQzlYS1ps?=
 =?utf-8?B?MmpqUEdkSXNyT1BXeVVhbGJySWhhRlcyTEFBenU5d2ZISitITktvVXpGUld1?=
 =?utf-8?B?VCttRzFzY2czdFh4WWN3dXRYUGxrSDRGR3hDTjZKSWdtbHBjRDhvKzlBZGIx?=
 =?utf-8?B?MVJEWDhCS2Nvb1lHbTRmVGNES1ZSOFV2K0hGMHFUZkYxbXVoY1NTYU1ob1Vq?=
 =?utf-8?B?VGpvd2hGMVM3ZENYbTNHYkpDbWxmb2VRMHdwbEY0OVNTbHJPNDE2ZHhyNlpr?=
 =?utf-8?B?Z2hOcnExV0NHN2FLWVVwWDhRRGlWQTlsWDg3b2pxSnlqVHVKNW5BdWF5VVVE?=
 =?utf-8?B?YTN5Vk5rTHlPczNHQ0xCYmRPU0U1L0R2cVYrWGlVWXlQeEJEMnZlZFdjYVVM?=
 =?utf-8?B?bkJHZGZvRTFhNi9EWUhuV2tUaHFlNmhDWEVnTlhVNUtsZGZJV1h4RnB6cjhH?=
 =?utf-8?B?TStSc3IvKzM3VEVJN0ZOSXhQT2NsQk1GQVNoWUZrUTVBMXJodG1IMVFod2Yx?=
 =?utf-8?B?RWRlTEZPbFphVGM0NUVXOXlyU1BPQUx1bnJ0a05QOUVMSTRJRzhsT1MyZGMr?=
 =?utf-8?B?VkJ6aVNCbUlXeDJURE4xcW9hd0lZckR3dmN5TVVRQ3FnOFEvSmoyQ1FJSzcw?=
 =?utf-8?B?dERTWkdUMXpTNVdJTy9nbEZ1N0pCWEdYay92eE1sRXBTMk84cURMSnRLbUdK?=
 =?utf-8?B?S2ZEZVk0UVBwb0pZSjdxVS9WZ1BWN2FVUGJpYTgwb2tSUlhZZkpOeUpXTml4?=
 =?utf-8?B?dHNLaVYxb21TdHB2OTdWSC9FSmtNR3hrMlBZaTR2NFdPa3UxV29kYUdIYjF4?=
 =?utf-8?B?Q1JTbzEwUVpVTm8yOGZ2SnE3VjVoQlQ2bHpzUlBHWGs1MDc5TmcvNDg3dDhu?=
 =?utf-8?B?eEJmK0JCYUtzWTRjejFWSFc3MTZnc0VTQU9vQWxqZW9Id3hKRkNPYnpCRHdB?=
 =?utf-8?B?RWFtWGZMRENxOFpmTUpzK0VFUFRzZVRwQjNHNU1vN0JUc29HVk5sZTlJUVFY?=
 =?utf-8?B?WkpneVlTMUY0dVVTeXlwaUdJMkt0K1VzV2xTa2NzSVhkZ1JNSTJuZ2toRnN6?=
 =?utf-8?B?NmhiQm5CRFN5RVU3UFJ0dW15SUNLWjFUNDJkb1RPZDlmRDdyVVdzUEo0dVhj?=
 =?utf-8?B?T1FVcTJSQVRiWHpwellGUFBCVGZienhkbEYrYngybmxRSU5Nbjh0SERveTVQ?=
 =?utf-8?B?YzZ1TFlRRldyRlQ5NmY2c1hFclpXNmxDVFVva0U4NVNRb0wyanNLYU5hY2ZG?=
 =?utf-8?B?aVZmZGMyRlU5L1JWUHpkK1ZPVVlCZTI4dGZ5cVgrREZyQ3Fsd3RVSXhlT0R4?=
 =?utf-8?B?QmZidXpnTHdadVAvZ1VMc20yYUE3bEN0WFk5UmlIZ3IyQWlmK1RYck02VGM2?=
 =?utf-8?B?ckpXOThVQVF2em9SQVhoRzh2bXRLYldUd1g0NDdqcUpsenJiY2I4V0JQVkVS?=
 =?utf-8?B?OWhNanVwYzREamJNK1JhcHJZRUpRbmhKQ1oxN2FKNGM2aXovZ00wcjkxRHIx?=
 =?utf-8?B?Q1VaSUd3MGYyeUZVclJRNXgvZ1NRUHdoZnBzaDJTcXh1OGg3WXJjdFVMWXVL?=
 =?utf-8?B?bWdUZ2FnT1A2L0xFT1hDbTJXcWluOS9VWGdQMHpMR3IvbkQrZzdBNlhZWHFN?=
 =?utf-8?B?RUQ2UXBMdkRSWC8yOGN4RUc5TSt2ak1za3dlNzFZdEswQVNuc2pQcXl3VTZv?=
 =?utf-8?B?QlhLS3pkTWhwazdGQi91R2E1dVFYVDBQbEh4OEwrcHN3Qk1rdHJXV2hMK1ZX?=
 =?utf-8?B?Wm5XU0hFV3NqN3BWNjVkY0JJWUdBYkVVZVl4ZXlXb0dUMktPVEdteFNyenFt?=
 =?utf-8?B?ZEFON0IvQ2gzZUVEVnR6Rm5yNm00UTdCYzF1Qm5NemRzVWFiUmluRm9tdjVh?=
 =?utf-8?B?eWxJcGZneVE1N0p0aEJjdEhJK2FJRjVoNUFhZWRENWVic2Z2Lzc0ZHl0Tzlo?=
 =?utf-8?B?WVBIck5TUXJYSGtFUkwwTEpCNUllWE9kVHBONWFTRUVOcDV2YzR3OWo5RnVj?=
 =?utf-8?B?VVhNS1FOdjJ3U1NrQVFCdlp2a29WM2hwS3dVQVBSdXRraG9xd09UVzg4ekdL?=
 =?utf-8?B?UHR4TGtoNHZmOGs5Y3VHQ1BrRlc2ci80eTZ1MnJ3WDZGOEYzNDFidXJXdnpn?=
 =?utf-8?B?elk4ZElpZnRHWHZaWEUrZmpHb0I1cENzVk1oUEZSRkpGRUY1Mk5MZDlwUFpM?=
 =?utf-8?Q?PUw60wuOdxgGqqe8=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5621488-14b5-407a-63e0-08df45669a47
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8274.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 11:25:08.7997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QljWTFRXLpqFRTDBEbDkjF57PWOS1jfDIIv3TLJ6ToqMMJbSRrCo2fKToj2DFvvohIntyvY1FVaxAUn7g5stKZ8fhabtYAhpXff5Wg0f/1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7166

On 11/13/26 12:47 PM, Lin Liu wrote:
> The block layer applies a device's DMA segment boundary to
> pseudo-physical addresses, but in a Xen PV domain the bus address is the
> machine address.  A range that is contiguous in both spaces can still
> cross the boundary in machine space and reach the device.  AHCI declares
> a 4 GiB boundary, and controllers that do not carry across it (e.g.
> Marvell 88SE9230) then DMA the tail of the transfer 4 GiB too low.
> 
> Make range_straddles_page_boundary() also reject a contiguous range that
> crosses the device's segment boundary in bus space, so all its callers
> cover it.  Streaming mappings are bounced; coherent allocations are
> already naturally aligned via range_requires_alignment().
> 
> Signed-off-by: Lin Liu <lin.liu01@citrix.com>
> ---
>   drivers/xen/swiotlb-xen.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index e2538824e..181f8cef2 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -82,10 +82,13 @@ static inline bool range_requires_alignment(phys_addr_t p, size_t size)
>   	return IS_ALIGNED(p, algn) && !IS_ALIGNED(bus_addr, algn);
>   }
>   
> -static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
> +static inline int range_straddles_page_boundary(struct device *dev,
> +						phys_addr_t p, size_t size)
>   {
>   	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
>   	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
> +	unsigned long mask;
> +	dma_addr_t dma;
>   
>   	next_bfn = pfn_to_bfn(xen_pfn);
>   
> @@ -93,7 +96,10 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
>   		if (pfn_to_bfn(++xen_pfn) != ++next_bfn)
>   			return 1;
>   
> -	return 0;
> +	/* Contiguous, but may cross the segment boundary in bus space */
> +	mask = dma_get_seg_boundary(dev);
> +	dma = xen_phys_to_dma(dev, p);
> +	return size - 1 <= mask && ((dma ^ (dma + size - 1)) & ~mask);
>   }
>   
>   static struct io_tlb_pool *xen_swiotlb_find_pool(struct device *dev,
> @@ -158,7 +164,7 @@ xen_swiotlb_alloc_coherent(struct device *dev, size_t size,
>   
>   	*dma_handle = xen_phys_to_dma(dev, phys);
>   	if (*dma_handle + size - 1 > dma_mask ||
> -	    range_straddles_page_boundary(phys, size) ||
> +	    range_straddles_page_boundary(dev, phys, size) ||
>   	    range_requires_alignment(phys, size)) {
>   		if (xen_create_contiguous_region(phys, order, fls64(dma_mask),
>   				dma_handle) != 0)

Is the change actually needed for alloc_coherent / free_coherent?
The allocation from __get_free_pages() is naturally aligned and
range_requires_alignment() requires it has the same alignment so it is
naturally aligned in bus space. I don't think that it can cross a
segment boundary then.

Ross

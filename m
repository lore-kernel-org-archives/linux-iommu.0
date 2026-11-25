Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795630082;
	b=V0wTb43uaPwa3fOUR7wNABwzc5f6MGzl8Yvo0Eu+WkNSD4y2HyDzm78KQxrdbDQFoIKB
	 Cz5MijIm63Y1crtIj31FK+45rKhTRqdHvP2QJQSCu0I/YpsOA7gzZZk93BrvM1CvOhp1I
	 OUnQJDwZoN/Hp/8QQtB4BmdV0UIWP9kEInRKcJBzwwHXnDhyjrjGhWeM4SKQ+b98gcy3J
	 ZMlXyCtwzEDvLayfJHCunAhqgE8VTDjEV3EpfL2RdH9H2E9zGAWewp1eZa8fyyULoGuh1
	 7X52cPIW+9GzogJOqveZk2jtf/6eNSLVFNfdVPVydNrlvimqHBm1totgAVIKdwMkGJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630082;
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
	bh=Je0DfpvLO/1FYl5g5WzzP0cQv+enhxJKW9cADhJiVQs=;
	b=p6VP4weFJOYzNSeTJ5oVzi0AiHAkYgqXdnOsCuaGvkPM5oksp/FII9DBp08bHw49g2k1
	 m0S4xFNZ3++Q1xvLA7wMczFNb543RnaGZDMRcIY3TtQlutNrNtBlflyg+IoPoUVAn9AuN
	 aEdXNx1JWI5B5hC+2UCdHKdC+RBUcNjTXzKXbdNR7l7DJacvaQyqVRPs32ROInmNE1zFR
	 f1+qO00SyCVnaBAVJqUALyUA8ug/NSsIY2jlFWUVJcs0cfA1inrNJab2r0EqFpC3nBLdY
	 7NQUNr6cOCYlsR5i8QsVuJd8nV460i7SvP53cpUCes+NmL8fShUM4Ef4pxvPrxYKeqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PlliUIxK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.29
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3022606A6A4;
	Wed, 25 Nov 2026 18:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3022606A6A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PlliUIxK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXKG2f+zGlJswqvAymFZPFPnWZ6Ki5+jc/bHU7KSetgTbMq2WKJ7hcAd9rwI2q5Jau1uhBXvKzAdom0yZpXqgIGvru43gDjD4lSv91yyoTOmjmzA+Jk6WXq0Issd6I14HDzK+ef+eziff/X6OnYObPE0WS7421lmEJjr+ER1lBjn7qztvZ4htRTD93oCAC5vK7mSx4fC8cBa7OqvgQNbRDLB5xS4leynbI25ClqOEJJobhqLILn3lGTZu4cxyzm8o0UTrbWDVb63eTWHH5oMeB2KPSKrwXH6HBKATDCo4xoArl9/B04omfcO+QbFppeqC+ySKbZegQHj/Wil41qPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Je0DfpvLO/1FYl5g5WzzP0cQv+enhxJKW9cADhJiVQs=;
 b=OaucvpdhhbdVdrgvoFXAu+j7jMg+QuPpr+tZtohYOrrWSQ64yqARQR/c2RbD2H/ztSDNmoR9opHOzDSUahVZ2pdsrDwUz5+9DfU4NvvfcViBj1lmrIoVl7YVc9DdLuG+9l0vWAujUp2ORy0Q4u5s/qUEleg0kzjFC5eDfHhYb5bBIvupl69/q2qqvhbzAAO+lpVmi1CHNMxOOfDbQcNt76aza5WoOi6Hvty4m9nSYsn7ai8RAdFvNaLXm3c5D0nLFWBVwSpixYiVuVY9CKU1/FhPPba0CYuw0Q7mUisyyN5XaW3pUdGcXwfqVegrb8NVDr//csYu30d5wu7pcEQgpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je0DfpvLO/1FYl5g5WzzP0cQv+enhxJKW9cADhJiVQs=;
 b=PlliUIxK5eO+HXXmrbkMdJmVB5lUCwOBgmLRsbg0TdmSCPrEQ6rEZ91KhspGgr2DqEo80BeEJwkPTj+ybeClg3rvGZGg8IMLbw98Y3bpYnyadALuthNS9XpSkYL7XahdxsLZneZJqJB9ze6Lnwdat+pxvRWvnV5ULQ6TKXSwrvzkq1ZESvCNQqw00f6hjR2fzN4p6pSlIKmJ657NhrFc5Ih8jBfmElgHz01qWefvNr8+Ih62idPKH00ZRwi56ISqsUHp8lh5l2FCBarzQILrSnXQowDK2tyDlnsPOylxM67ap3aptb0A6o2T3e4HWMenp4fzJD23Eh/lGXPxsL/gzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by DS7PR12MB5815.namprd12.prod.outlook.com
 (2603:10b6:8:77::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 18:07:54 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 18:07:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/7] firmware: arm_rmm: Add VSMMU commands and
 fields
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
In-Reply-To: <efc402ba59961b271c2d7ce26f3b91d717f7392d.1794343501.git.nicolinc@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <efc402ba59961b271c2d7ce26f3b91d717f7392d.1794343501.git.nicolinc@nvidia.com>
Date: Wed, 25 Nov 2026 14:07:45 -0400
Message-Id: <179563006500.253973.4869576655912381688.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0252.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::24) To LY0PR12MB325698.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: d89b08e1-9737-4874-6f10-08df4b1f0370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|261021135927099003|11063799006|261102123227099003|56012099006|261021121427099003|4143699003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1dP8yeibb8lNgC+nznbYFcGU/jgc8tf2+rAuIIlXXHn3s7JXMxtapSTLIVLleoTl0DdfaIJ9fjWeW3p16OjdzmCpmp/SM4OJ2iPhZdH6oKw0/pVMQCCXZ5peX69yynDEb4ni92r8iYEJnXlTC5+YsMy/9GgmrIgdaEprdzk7+l4t36+INZBTMgvC1XiabtNDHnc3Hgk6emSbZ4W0fkkOxtpxwVRYvbFc+fbNJDFlkTLQkG5ufzi7+PKq8XOCCAb2o1jCJohgs7MZ6IIkkzvEHq3k6YEiowkz9v8A7s53sguwLaogNWC2tVoXt4hmOUbMuB4KgwsbfNjows/7SfHo9qqnDy8i97kMI7blvw0h+VN1lrm7P8lLGJPIxfJ+IHT7yaHoLVMuO1dqUxfIZvg1zqs+Gz5MneLy1rvRi1gRTjD8LI6ghR0WfMdoVOlmPrhu1DGq7s7Z9XylicOiSaifCDiIrf61B5z5NoNRFv6i6VFsPl74atEDTg0IWbzZOEXRahO/+Xv6buWncLp+UMfDtYwr2I2DECbEeo8yM+4/Fb0VrHuoPSy94QkRq4kvfRf3La4xLAWXPrOxKpKz7uhfTLWESx6X171b+nC+drvY1Q60TWlFpC+MKKMWHFTAon8JYPszk6W6po21dHKe5hO7tj5p4EikwEQxKJjOoFOZJqM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(261021135927099003)(11063799006)(261102123227099003)(56012099006)(261021121427099003)(4143699003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzdiaWpRODIvZUxzWXlwNlVyVXNPOVNHZm9nL2NKOEVQRGN0cTMxVE53eko4?=
 =?utf-8?B?RlFYTE1kQWpRdGxEYkYzNllHWEcrc1EzZTJzV2Y1WFlRdWZCVlZKczZZaytn?=
 =?utf-8?B?bVNFQXVRZ0R1Qlh6dmpscmxpYXBkTTRzR256R2hteC8yWU9wN202eXg1S3g4?=
 =?utf-8?B?aWRMVTdUWFJEUDQzZnIzYUtVQVVjNnY3Y0FHQjdqR3RkUEkxRG84dHR3YmRK?=
 =?utf-8?B?a3lCYThydmRYUExNSHJUOVQzc3MxdHB2UlFkMy9TZ1kvNVNhK0tZd0p2a25Y?=
 =?utf-8?B?TWJmUDlDT2RsK085RUtlblVnYzVENUpINjVGSkdTYkprSFpxNS8xbTYrVmk3?=
 =?utf-8?B?QnAvYW5MYk40bkNOUTJ1WVJrUnJDamVaaUhBRVIwR3dkOVdUMm1GeXpYekl1?=
 =?utf-8?B?T2JvZ1Zlb0QrS04xRDBIcUlCQlNQU1pkdENTamZHT0dUM0dHVGZ2ajFSekNX?=
 =?utf-8?B?YkpDRi9Oa0tVWndRTVM4UnZ0em82ZG5hYmlmU0d4UFpLS1RSYlRVRTVxMzRE?=
 =?utf-8?B?aUx1YURpK2tGczFxUmF5d2oraVhaVks3Z2w2R2d0Z0ZrM3Eyd1ZFMGp3MXg1?=
 =?utf-8?B?Q1YzME83TkFOaGhrbDZtNkxaaEFHNWtpQ2k2VHFybHFJSVhDOEJMNVlBRXdx?=
 =?utf-8?B?RUpVUDdIdGJZL2ZyeHVBd0RJK0trd05KR2orbUNzRnE5S2NJT3JHZkdhdlZG?=
 =?utf-8?B?YjQ0U2lRdFZqMXA2a2ZjVlFJY3hPZHpFUFF3Mm1kZkpnUTBpYkJlSXF5eDk1?=
 =?utf-8?B?eE9ZYksvTlFwaGdnc1M1R0RFMHdUVlMwb3hoQmdzMzB3WEpQUzBIUTFCbE9P?=
 =?utf-8?B?N3Y1VTQ4c2ZOR0JDRjdxdGR5Z201eFRqZmYvTzJ6UW1EcWZxQks2T0J1ZS9p?=
 =?utf-8?B?L1ErUnN2OHZ5ZW9JQ2ZvU1M1cE1YYWRmWUROZVVQTTZ5N0tDSXZCeExWblI3?=
 =?utf-8?B?ei91eUpaeEVjYXNDY3ZDNmpuMmZSTXhucFMxYzZyelZVQk9QeDA5Wmw4Tlov?=
 =?utf-8?B?THo2QUtQemUxTEhzZU84QnNJdi8yOVpJSU1rNDBjSklIYjg0Yng2cGlHWThE?=
 =?utf-8?B?aWRibXVUS2FaeUs0WWFnbmZ3ZFJZSFBvaGZPaTR6UDVBdWpocURTL3g2eXVa?=
 =?utf-8?B?N0ZjRmkrakRXNzhYZ0QwWTVSVU5sTlZrWlFRekpDcE43Sm50VlZlU1JoSTBo?=
 =?utf-8?B?MFJLYVN5TSs3S2dMUEhobFVvdFpIMEdaQjlOTDdJdVRYYi9ZcERLZmN5Mnlx?=
 =?utf-8?B?enVyK0xEQXcrVkdSY21KUlBDODRVdTJEbFdjY2NaYlI0Tmo5RGwxWTR0a3ll?=
 =?utf-8?B?cFdJS0ZWbWhDT1NUNUdGVWwvT3g3eXhUWjZTSHA1UXdJS05tZmg3RW1iUDBT?=
 =?utf-8?B?NVdoc00zZ3p0MjlWMHdSSkt0L3ZnaG9BdVh0SERxOWJ3aFh0bzRzVm0xQkIw?=
 =?utf-8?B?MHNFa1lYNW1pbUVYUFVselF1bDJOUHhiSStWeGZ2bHdwZ0tjVXFqWmlUUVJw?=
 =?utf-8?B?SnExSS9jYTlsRmZ0bGJ0eDdwZVJlajdacUY4UVl6Rjh2bkQ3UjZYVzk0RUZ1?=
 =?utf-8?B?UnEyQmtvNkZwNHkwVXEzcXByMGJQaG4xLzR1amQ3VEJXWkJ6cGlieU1reVE5?=
 =?utf-8?B?SkF5bFMza2hzVDBCVnEvRjhTeWJ5VDdzdmYycW5DbDZUYmtqbC9DK2oyZXV1?=
 =?utf-8?B?OHZVUXdSWDVLbHlsZHFadnRaMUxkV1Nob0U0VTl1QlV4U1ZyMnI2RS85Qkly?=
 =?utf-8?B?N1RlejJMRU5oUW1FeHJDV3ppcEJIQUs4dHpURFdsQmMrb2x4RGI3UlNiemJP?=
 =?utf-8?B?QXZmR0hmbm9sNzdOb283QkdoaDJadUFhSU44MXV2QmdZMnJ2WDJEOTFNWDZ5?=
 =?utf-8?B?aXlPUCtPQUQwRWdmWUdRNktZNVUyenNoRlFIWjNEczBPSW1wS2djU0FLUFJR?=
 =?utf-8?B?KzBHeVJtYUYrTXBDZ2NUbXlRRkNJbkZQd1Zqa1hzN1kxVzgxWUFRd3BLWnJr?=
 =?utf-8?B?MzZvd3BvMUEwcHNnakdYa3RVVEl2Qkhob2QwbmhiNmQyK085ZU9uaVlkeXRq?=
 =?utf-8?B?Ky9GdkttVzczUFVKOXpGbmtJZnZ1WCtqeWIycmFBOGQ0R0k2ZFlFZXJzYXlp?=
 =?utf-8?B?bkl5SUwxOVVGOWlNTXNCdVl3ckJjb1puc1dOZlBUM0JOVzkrQy9wKzIvWVJy?=
 =?utf-8?B?VWhROVpKWVB4OXNKZTh2dU9JSUY5RW9KYlVkOTlYTEVzOXh3ZTdtaUVrcFZw?=
 =?utf-8?B?Qi9PUStZandNcUgyVTZqS2JlZDd2aVladmFJU2VOQ0tadG1abzdjOEpkRGc4?=
 =?utf-8?Q?GclGiYbYiNBQBLCpQj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89b08e1-9737-4874-6f10-08df4b1f0370
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 18:07:48.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8pWdbOu+0+o79wBs2MFYXPe+dSCzSdrA2fNobGtyRzaSTs87b/l6PgdVC4hyxXO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815

On Tue, 10 Nov 2026 12:50:06 -0800, Nicolin Chen <nicolinc@nvidia.com> wrote:
> DEN0137 2.0-bet3 adds the RSI_VSMMU_GET_INFO command and replaces the old
> RSI_VSMMU_ACTIVATE command with RSI_ARCH_DEV_ACTIVATE.
> 
> Add the command IDs, return codes, SMMUv3 device type, and helpers for both
> commands.
> 
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason

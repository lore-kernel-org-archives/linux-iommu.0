Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1741E1E00
	for <iommu@lists.linux.dev>; Mon,  6 Oct 2025 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743559; cv=fail; b=FFMI4AafEgTUOAiHUeV3bMKDNsVJiJvaszeJe1EhSrF4T6TaKW+a+zUrEY4WA8BWifUvaZDSW1cW9nJvzDJvfw9I2byyQOl7Lbhz6mN1BWg1qJBEQlMp7+4F67kDycpy+SzFMWAV5cjsqRZD9SH8ka6zKWvgs0+LHAMvNvxhmMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743559; c=relaxed/simple;
	bh=mka+a8EbV2+wEF6Ioe2YI/ntFpOMBrVf33JbC9Q+99c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GnHj2scdbvnTCGngqaylsCpEfI5laCAXBHCmLNN5997LG1i+t+Vz09vgIPM5N+K1aU8J7S9ZqQ2TsvLwLweSsiux0GR53wVJeW5XpibgS15MFe9sRGpo3LeXDtdGMAKt+RTbUUKnHEjaWEmi6OWgSpA/Umy/fSLsUbCcFsSqWI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IZjIHfLB; arc=fail smtp.client-ip=40.93.194.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IZjIHfLB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Di6PsNl3YXW9QLcBuxR5vU2Kz6q/N/gm+iJ1hOU50SvEBR9wRXhF0o4TJKcaxSETSGxMIeDb3q9XrtpV2WiDg8XbiV+9z60l0dHx43otBX9xBNfWQTem6kB1mK343011xKoieRMpZ1XI9ycJG8lOVGYhX2id0zg7oilNM4yT/CMFbXEMGDG5woCuZiYdG3c4s8x516mi0u+Xzy7/x/PNOA2ZpjtlCICGXIRoR6RlbthVoY2jdXuGXpjYWEiEwhKftRwvvfgt+CqcxUINcCq5W3m7fplzfymy87F7yvE4a2jx35EledPGHfsnmDomc9fWfbQt+VQ0rNCIoEuh95ZUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWgbahg2WiQEPsUltaj6jWLEq60L3rYfWkt1EYRvPnk=;
 b=FhqdzAktz84NEZzwYrEiv7AI5PpfRDTN9GKirv3cQzO5K2W/BtOVwRKeapu2KO0XaZfH/4IWkgt7JPIPD5mlWyUUvcLdgjKTOiTsxWlXLccgsdeVh3a8VboaEXdJnYqg7s8QvW0GmBhI/Y9DedG2M6WmfuxJyhn/SDyqVeD4Fc7wCEp8kTHZOl3Ag7ziHSUP49riwFjit1iSShyuXcfKi5W5kASzbJEtHVPYvrDZzGQXXPjyuDVlKprKoni2LZKvQfIoL2hk8lhEHHCCCHOGNaw3dONUomlvNzqI0Hcy2lKcf0hNheAJPgTaIJgoBpIeLqal45XdCFXOYKZM941PCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWgbahg2WiQEPsUltaj6jWLEq60L3rYfWkt1EYRvPnk=;
 b=IZjIHfLBUfA7xMpo7t4xL3I69Pa7UKJXk5gAcAXOQ6eu8Ux3EKKUc2VBMHnYmqzP2GNPPr30A7QVhujyuzBhPqsb1D8g3/N1xBCIGWsyAAzHKdh7KDEVsVpvm/RzquLYj3ebuHtgY8I4i07sObEZ2MPFS4y4L+2CLHPOerMPtOIaxWSnQoEmpCWbyCzT9wJvYMZhirOnA5+hV1ClxNOIMdJeYkIqm2+0M42qkZ9vSClHdIbsj3a9LdwQ3kxt3/7iFgGKOgx/rCGDzK5lcxmL7a0bUusqHleYVN3QiXkJdSmhhaqv4dTqMQutxKKbPOoXW+4h0JKd3zM/OucGBZkrVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 09:39:10 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 09:39:10 +0000
Message-ID: <6db8eaff-94e5-49f0-9369-f501e56ca5f2@nvidia.com>
Date: Mon, 6 Oct 2025 10:39:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] amba/iommu: tegra: enable compile testing
To: Johan Hovold <johan@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250925153120.7129-1-johan@kernel.org>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20250925153120.7129-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 4efc2d19-7f9d-47e5-295d-08de04bc336f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmxmNDdUS2ducXhiWDh4Y1RtWlMwM3I2SDZyS0hZb3drbVZaRDRUM3BFay8w?=
 =?utf-8?B?dUQ2M05CaEZRYkF0ZkpWMHd3OWxnRmZzMlRXanhHZHFic0EyTDh4Vit3MndF?=
 =?utf-8?B?bGd5U2hLRjBXSGVIbTlyalkvTmJaalRjcDZvemtRVDBiWGpTbjkxRmZJcXVW?=
 =?utf-8?B?MHBDcWxLZGJRR3orK2laanpIOFpsQ0hLM2RhTXF1OUNxMlVadmpseFNnVWRX?=
 =?utf-8?B?NW5RTUY3SkVHYTloWGYyNmFCOW9Va1N2ZW9tSXR6MWQyOFp1YzNNQUxkUFMx?=
 =?utf-8?B?Q3h6Z1RMNG1HWks3eW1STU5xa1pqM0hiSzBYNVNHWGRzNjMzdEhST1NSTVFT?=
 =?utf-8?B?cWhpTE15aDI4NHVVN1VGbE9wZHBSYm84MlZjY0Jjd2VuV1NEUDNBTTlqUlNp?=
 =?utf-8?B?dDA5Ymk4WGxieTlQYUl3MWk1ampBZ2pKbXptUmZldnJHRHNsV29SNlZuNlN5?=
 =?utf-8?B?RmZCRllDNnZxamRuazhOMVJvYURrZ0Z3TVVkWXBzTjVKVWJkdDdtR1FoU3BN?=
 =?utf-8?B?ZmNSL2pydkNWMGRySkdha0ZIZUdKVEdJNHF1T2EwZ21zQzRWN2llY0xPUVpv?=
 =?utf-8?B?QkVMeThWOHZTVzIxTzV2VW9kQmhhS2YreFBFcjN0MnRieUNEMU11WlBxYUpH?=
 =?utf-8?B?OW1nOVo0MWVEUlBTMFByckhPK0pOUTBmeTRsNkROMEpwMklXQlBsbFc3bVJG?=
 =?utf-8?B?cEF3MVdpTnVMUnpUb0g0WDNxUTRLTE1nb1R6VGhkeGlxUXFGK1dNRTdaeDFo?=
 =?utf-8?B?MkVaczdFVUd5ejlIalpsWmNmWlVqTkszUXRqOGVIU3BPNU5zVjltVUNhSnJE?=
 =?utf-8?B?MjVWUWlJQ3BFZkhaem91MWFpYTJhWHhyTjlvN0RyaEpKZ1hseE00K0UvdU5p?=
 =?utf-8?B?cHBWbUsrNUlLdGExMXhYQlR4OTFjSTNkeDdBOC96V042T1dJajkyYlFQTEU5?=
 =?utf-8?B?ZE9pdEJ6ellBbXhyOW8vSitKQVREa2hEOWEwQk8ra01vQnpCeFVGbEhwaVhB?=
 =?utf-8?B?TnA4b3UyV05GWlZHbVJtTk56Nk5NUG14dTdpZmNndEUyVlNPQWEvSGpCam9u?=
 =?utf-8?B?cG5iUkt1bkc5NU0vTTkyMlVnbFpkdjFuekNKS0xWVTJNcGZkaUtXT2ZBZWhk?=
 =?utf-8?B?NU5wMi9hOC9FTU5HS3JGK3hqVjJ2THhpTC85TlV0VmhDZDVSUUxzL09aQmRV?=
 =?utf-8?B?eDlkMGE3L0QrOHQvYnBDRUphUDFtSDEzeVZ3T1IwR28vY3hWa3pBNVU3ZG5C?=
 =?utf-8?B?QXR0SUdTTjZObWdDMzNUc2xkcENJU01ZeWJvSURwRjRLYUgzTlc4YjI5TDZI?=
 =?utf-8?B?d284VThMYWxseVlvSWFoTndUMS9UTVU1TmdsNEdEYk5MU0JqSllVczR5bENj?=
 =?utf-8?B?SWN4N3ZKMmgzUHd0YVgvWHFRbTFJK1ZvRGYySUdzWVQ2TUlqOVBvUlF4dm9D?=
 =?utf-8?B?SVhQS1RiN3drZjVFT0pUeUJHRVhsbXVwS044WXJxdTJ1Y0VObHlNRHAyOUxo?=
 =?utf-8?B?VXVqNTIzYWZ3VmxsMExvYVdDdUxCYjRnY1JFZDVreGdJMlR2bklDWEFycGpP?=
 =?utf-8?B?RFhFcjJxNUNBampXdmZFU2ZJdkxtMDBGb0ttM0dJRHY4SDJxUU1PMTJldzRl?=
 =?utf-8?B?SGFqdlNpWVVxdE9mb1lNQlFSQTBDN3ZkT2JhZ3JqYUFXeGk2dmhwVjd0cFQz?=
 =?utf-8?B?T3VUNHBOMU10S0xSTWZUUEZ5aS9oSlQramNnVEJtYTJ0aTRaVDRUTW1yYUVD?=
 =?utf-8?B?N2NaWDBsUmZlMFh4RFNwK05oaEFtaXRES093bVZlQ3RHYW8zdnREOE5Eb1U2?=
 =?utf-8?B?OGVhUUJvWFRWM2xCc0prNjVaNGovaWltbUxDTXVHRnhYRnMvUkxpczVtUXoy?=
 =?utf-8?B?ZzZ3OUo0OTdhTjNsWHcxT2dWRFhNZWVJdk0wVVhpbzQ5M09nbm9IR2M1RG0r?=
 =?utf-8?Q?d5JsUcFSbgReSNhabjvRXa6ZcPs0if5e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SklQOGVRSmJuWjBJWSs5VGl2KzVEYVpScXFRdnQ5Z0ZYejg0NE5BbE91VzVE?=
 =?utf-8?B?OWo3Z0VSMnFXWnU3Q2svU20vS0pFeEgwMEhxOEdnYThnUGU1aXJaQmRXM2do?=
 =?utf-8?B?KytqY1l3eG43bzJXZTJyVVIrUjA5eEdxOXJKaGI4bFVuS2JhUElJV3hWbHcw?=
 =?utf-8?B?RGo3bFVLZ05nV1pRV0MwZUVPRTlHeWtadnVCcjF2bmlBZzdDZlJRQlR6ZldC?=
 =?utf-8?B?OEdXR3dad3Njc2NuaXFYWitGRFBtWUNtR09oVjJnd1RUUGpOY0doQStDSjRO?=
 =?utf-8?B?MEtDcERPbjNlSDQ5SlpKbFlNT05UVWpnSzg5TnJsUG9LS3BKbkpRMnZ2SjNy?=
 =?utf-8?B?Ymo5NWVmNmhkYVg4R2YxQU9PeHJIMHJsYkdyZVRmVEVuRWo4cVFNLzlBOEtw?=
 =?utf-8?B?dEhVRDdsRWErRDhILzU5NWtmbDlObkM3SExLQTFBaWdleEdDSjlxcktSa1ox?=
 =?utf-8?B?bFVmemtZdm5kVGpuMFBrK1VKczZTRld2OUZtNG83a2JJRTJqTkJHb0FUWk9S?=
 =?utf-8?B?SzJ0Um44V2I4ajJ5YlhjRnhzQmxpczgvQjUyN2NNZ3UrRjZTSkMxRDdWbnE2?=
 =?utf-8?B?Q3paNDBqYVNaOHJRSGVjQnY0UzZML1RWV3c5eGZPd3NoUDlFamZyd251bk85?=
 =?utf-8?B?ZWRaSlJGRHpwbHQ0aE0zVncxOVIxWU5XcE9OZmloNU9GTmNUN0ZBUEl0WWYz?=
 =?utf-8?B?Z0Z5a0QvYUp2Y0V6bVc1Mnhza2pFcjIvNFk3NDRjbHdMWFJETjVLMEgxRTdY?=
 =?utf-8?B?ckppNmhHSXhrNWlsTkgwUXgzNEVIVGRFSzJSTTR0dG1kTzRsd0swTEdORUdv?=
 =?utf-8?B?UTRPcytxbUpBMkZtTnpxRDdvUmhyN3BCbENZeGtOSVFvRVcxcm15WkQ5STdG?=
 =?utf-8?B?ZXZKMG9la1RHU0M2UU9ld3RRdW44MHNoUG5RTDBwQjM3NFZqOXV5VTJXM09z?=
 =?utf-8?B?M0FzTklOeHhiTzJQd0pGcXZ4bFBOQkVCaHhSVEhqRE45dVc3WEFVNEh1V0JR?=
 =?utf-8?B?VWI5b2V5a3dOVTR1eGMxM1lUMXc3TGl6a3BteUw0L1ZINzJWN2loWnRxWW1T?=
 =?utf-8?B?ckJFYThMOW5jMVJWTFcrblBtMFNYQmZCTmVRRFhMTDRTSmF4Um9aQlhtdjJO?=
 =?utf-8?B?SE5yRjRtQWhhVEdoeG10SXQzbkFlK2JhdDNxS0JXd3A1dUNwZ2gvYWgzL3dz?=
 =?utf-8?B?dkxYUmYyR3FKZG5xS0ZsWVBSU0J1a3dSN2ZZQ3p5RGVsdkZhK0VaWFM1QVNV?=
 =?utf-8?B?TUtNU0ZuUVFSSXBneWJnRXRmWkluTElkSXVYbHhiQ2h0TTVRTENhNC9EMjFB?=
 =?utf-8?B?QWNpd1h6STBsdEVEbWtoTjV3N2lrbGJjYkMxVDgrN0E5SG1YZ28zTE1JYjBR?=
 =?utf-8?B?UERIa0FKN1NGdktDMUR1Q2JTU0JMYXFkdGEvZ3FCMm1uSHU0bzFuaXU2bTdD?=
 =?utf-8?B?ci9Qayt4M1Fyb2RkdktmWGIzQzYxYlkydko0d29OVmtFVGhYYzdIWjh3TUl3?=
 =?utf-8?B?OEZyQVlEbEx1V3JXZklBVWFoN2xSWExwekpaTFJCNlpNYTNuRlQ4eWZLVlpa?=
 =?utf-8?B?eWN6S3A2c1dvSStQaFVrdTV1YXkxVDltd0JSMVc0ajdrVWV5bFhEbXlIRks4?=
 =?utf-8?B?TDdRMytzTys3RDRaYktHN1V1c3hHbEhpOHlFcWhRNGxWNFladXIySVUzODFP?=
 =?utf-8?B?ckdNUkUzU1NxZktmM1cwNnM1czl4UjBKdXZuVmtHSTQwRlBLaWg5YVRIY09z?=
 =?utf-8?B?aHJtNlNoN2RvNzFnRjVhUzl2cWNyYXVVdE5Qd1cvSDhNYU5iVDBMcWpMUmJC?=
 =?utf-8?B?NWRyaFgxRzVUOWRUZEc1clk4cWpYOTFVNXpFV2hvRGgvc2FyZHlUTkFJVjNJ?=
 =?utf-8?B?c3pzc29NMWkxQlhybkpnUlNvMXJaREFWMndoeUx4V1p5eTJPZzliaHhWOHdx?=
 =?utf-8?B?SzRUcVV6eWRmNEIzL3kydUswVFBrbVpOalcrc1dmU0dHVjYyUlRzOTI1OGlN?=
 =?utf-8?B?ZnRreG0xeWpBOVNoT3ZET1BxU1hVU0hZN3JGTDRybXM2V1pMZXFJVW9hYk9J?=
 =?utf-8?B?OHZsbGt2ckxucXFGaTRiSjRySjFFOVQwclpMQXY3MUl4QUZXV0RNYUxCd3E1?=
 =?utf-8?B?eUxxc0pjL2tXbkIrVUEzbk04YUJVdlpIQ0VQTEx0T1RXMWlqTkVLSGJYK0Iy?=
 =?utf-8?Q?K458qPGZT4gfGy7yXWvVLrhxe+uTLMOW3h/PTxp8CRtj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efc2d19-7f9d-47e5-295d-08de04bc336f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 09:39:09.9343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZcN63j/GncV7H/4txI4FTQhUQZ7wS3W/JCA+i1kRShe5+B6O3Mxht8AV8uAMWp2TCNKM56A2E/k7jsWNy/+uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444


On 25/09/2025 16:31, Johan Hovold wrote:
> There seems to be nothing preventing us from enabling compile testing of
> the Tegra AHB and IOMMU drivers so enable that to increase build
> coverage.
> 
> Note that these could go in through separate trees, but compile testing
> of the IOMMU driver does depend on the AHB driver being enabled.
> 
> Johan
> 
> 
> Johan Hovold (2):
>    amba: tegra-ahb: enable compile testing
>    iommu: tegra: enable compile testing
> 
>   drivers/amba/Kconfig  | 2 +-
>   drivers/iommu/Kconfig | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 

Looks good to me.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic


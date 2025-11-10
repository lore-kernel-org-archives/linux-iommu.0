Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013014.outbound.protection.outlook.com [40.93.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C25B2FF16C
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768521; cv=fail; b=dLmK7An3RcEs8v8SOb3FRlW4xLtnT9RNP6spvpCuR70DNSL41Q0qCaYKMot9RYqr390+E5MLmoIxkIJVewYhVOXhxE0nhSw548VXSTbxdjYpy4bwt5kaV/ro7uRf4ghwj6viOfnIRZH79ci+jDUJN+KnvGTP6PTgswrTE6cbYRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768521; c=relaxed/simple;
	bh=TJL8yBazW4xb3whSBgbKmonu+dWGy6at4SyCXR/3KsU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rlLsRIU/aLqtjR7sjfrO5alQvCAz+3gy5305dDF3mT9zOIms/yP1B3xv8Z5me3rlvNB+7qUTL9BPYnXtEKDo1dSSkyRTiD7QOJYtnBWETTGG1vV3Dh7W360m1mHXv2nNld+mVeo923/naW/ZKFChMqkVH4FJMDY/ci4EDp3l3fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nobaPkXm; arc=fail smtp.client-ip=40.93.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nobaPkXm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGzSr2femmFeo/u0cerkTEUW8F0w8rEcaHwPD8iNRIHDa8ftBa5iuzPlkMAepIj02t35sAagNggzHDBNXlENb3eOTsgOsh93w9bNeAr7WLQJ8DScXMuDidkej6o3WLyF+KTNs/D7ixibiCCmnv6XSbytCWt3U6WMxZf7lqDkO+IbLUCR8w4bs7e+/fpHuMpRL+IBm8KfWZsy8lGZGoy/ZdpDpzXUSSkZUykAvvzE8c+e5rX1EuIJpSl7bc+VtGIb9i4mOoX5BWFGlbWsLijuzxzKlAKeZXUQjePePApqLrHQeL1K8pOoGKzpp8U5BsR6rD2fwbJMfpBTXx6BovxBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRQOFMAHX0MEQsMJE4SOKY9WMvCjI0weymFQHI/Xk2c=;
 b=UpLhQnwfkoe/ywX9H0uZdP9BIZl+ri+C/wXZfFbxntygY5e/Ia5dWApWDzrKU5DmU+o34wtDzExccoXKerZ2/XqHrO513I7ho+qNYRj8Vifl1rT2TwFUwWCgdQLVhu3tam2m6rQneDrpo7Q8L4YzvKqdqY4QiEI5U98t9U/Ys/nUceUIdDBxI3ADASyWxk7f8n6+XqInwqdoco67vG9ZmBbIUYQG32mxrIetHlvTvaYopaGr56F8dJufMW7ykhDX2Wnla59veJSOoM+jHf/5MLJgA/IcwkTEH7lz8fYJgSXoAUiXNOL+RW7two0NPrtQ3uVgeHK9TnAzi+YJrRM18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRQOFMAHX0MEQsMJE4SOKY9WMvCjI0weymFQHI/Xk2c=;
 b=nobaPkXmDbj/mpMNeDKJX1e5+OXMa3gdwDAz7WzLAo23OoU3fgig993lqGcws3SBl03s7Uqr1idfLQWM8dyzJd+EcKOVvQkGfvCcggencnEPm2ZIku2a6WW4p7Z2G1ervW03WnjCUDgp6oFnbjLctQqcGlkMd3MfpdgVBNXR4Us=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:55:14 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 09:55:13 +0000
Message-ID: <e6b877d7-91c9-4db7-9c4f-bcf4608e17df@amd.com>
Date: Mon, 10 Nov 2025 15:25:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iommu/amd: Add IOMMU_PROT_IE flag for memory
 encryption
To: Wei Wang <wei.w.wang@hotmail.com>, alex@shazbot.org, jgg@nvidia.com,
 suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com, joro@8bytes.org
Cc: kevin.tian@intel.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB439351F0B7E54513710BBD3DDCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <SI2PR01MB439351F0B7E54513710BBD3DDCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: bb3a3909-1232-4a58-e8ad-08de203f3e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkUwMVlBbk9yNGlIZlF5S28xejFFbEpFMDZjTFNvWVJwSlVzdHRsL0w3WnR5?=
 =?utf-8?B?TmVWUFpkTDBEbUxveE5YRTJJdDc3dWhLOGllSllud3EvMER4cUVib0NINUo3?=
 =?utf-8?B?a1lnaGhycFUrVGtEOWczdU9iZEE2b1RIRnY2emN5RUVxUGNXbnAvMEJPa212?=
 =?utf-8?B?a3ZadHUrZGpIY3M5V0dpZ1pScGN1cGZpaVVQYVR3RWhKTXJGZ2FkRENybFEy?=
 =?utf-8?B?L2g2bUFjanJpanNWaDVMK3Z4Z010a1VYdFVmaWF1YldxU21NZWVDNzNiSGZw?=
 =?utf-8?B?THlXcllUN0hkT2EzU1l4NmdobUoxZ1RzeHNDZGRERnpGN2dNdnVjRE5zWUVk?=
 =?utf-8?B?SlY1bVBXN2dxbS9ZUUpneWtSMWpJWDVsa2tocmZMQU9hY2xuWG1hSEdyS3Er?=
 =?utf-8?B?N2M1MlR1NXl3SXcrUE1oTXFtSk13eUhFVW9weGh3bzdSWU1Rc2Rlb0NjWk9M?=
 =?utf-8?B?cWcrS3R6ZnpySlVQVExKMkZqZThEQTRHMTF0WEM4bEtQZGxMck8vT3BnTU5Y?=
 =?utf-8?B?VnBnR1VtNDdZSTAvaXM3VWVqV1hsZlVEMnU1aU01TFpEYytwOVhHNGRoTmlq?=
 =?utf-8?B?Umx2aU51TitiOEozaHVGOHBhb214UUE4c2NLbGdSRWNEUXlFVit2Sk5HdXN4?=
 =?utf-8?B?VW1INGRRa0ZNZlN1eDdiZmx1R24zdDRKUWRVOSs0ZUpzQ2ppdUxSd0xNbGZY?=
 =?utf-8?B?elZXRG9CRThHaUtmU1ViaWJGYzVzcFNuNGI4cktiOUdpcnhvb0N2M3BBemg1?=
 =?utf-8?B?NlN1cWxmRVVvdlB3Mkl2MzFMQ245dStmQ3J0RDJjM3YzcktjM2N4VUJDRS9S?=
 =?utf-8?B?SjkwazNqV2ZacmppSHgrZXBVOXpvd21UZW1WYlZ1S2NRa0NJTk1EMjhwZXJW?=
 =?utf-8?B?Y2pLVXgrODBuelZ6Um1jSUNzeldmTEdZTWgxQ2F5eS9SRURCdUw3b21DbVd4?=
 =?utf-8?B?ZmlvaDdkV093L25ScW1abTdzM2ZLU3Aya0ZDM3k0YTlVeEQwMzNIck5VSFJT?=
 =?utf-8?B?Q281SHJZVzMxNFFvSHV1WEpZSDM5Z09wVWZ0eE01MkhaUTAwc1ZXRDBuNUdE?=
 =?utf-8?B?dGNTWk5JdUhjdWlUMml5Wkx6aVQvanZFUDNaZk5aNGNlS1RXaHdzMkJONWlC?=
 =?utf-8?B?S0xKVWN5ZWhEUzZGL20vWHZWc2g5QlROdDZIRis0S3V2RTJ1VzhSTjl1bStN?=
 =?utf-8?B?K1Z4b2M3QVA4Yk40UU1uS0VJUS95eERCbG1UQjdNNlUzQlJzWWJXMlVacVRP?=
 =?utf-8?B?VlZnWGFwcm9VdUdPL3BIN1hBMlloWTVRQktFSGFyaXptMDhOdjZuK2pEUHkv?=
 =?utf-8?B?OXNVNDh2YXZhWUIvRlFuNmY4VUhXZ3FzcTFnSFZnSWYyUGdZakpPbVowSzdY?=
 =?utf-8?B?UTE4OGJ1QU5jN1F1ODBoV05GK2tacFlZbXZHd1JVRnFCQjJaaE9yTzJoN3Ev?=
 =?utf-8?B?a2ZNS3ZXcHBXK0hwczVOZEtQc3RLZXFuV3VnT0o0VEh3U2J1ZThvY0Q5UVBh?=
 =?utf-8?B?bjhLWmdKRjBzNWNKQ2R6bmtRSGswbGwxd1E1YnAwWWxibG1CUEJGSTZVNi9U?=
 =?utf-8?B?cHVNdDJUTVNZb0hRU0hNcFBIaVF6YkVaSEIvQ3FvZVRwdTZRZXBTM1pPYTgy?=
 =?utf-8?B?SFUvMWRLY3dQeklNaVg3bWhJSTlnZ2RiNjdLaXlKZGFqUjlTaGZRamszVjR3?=
 =?utf-8?B?UEo4Q2ZwL0FXTm5Hc20ydGxuSjZFRnBPM3lyY0VyT05ZeGdUMkh3QkRLV0Rw?=
 =?utf-8?B?aW5aY3oxUkhVZ3dacEtUa1I5Z1FGSGdVVmhTRWNUck1LcFYyQzBzSHVaODEz?=
 =?utf-8?B?TGxjRUE3S0ZLcnRUQ09rRHRlSEluVmQvVHVVcTE2cGVBaXZmWE1iVXA0bzho?=
 =?utf-8?B?Mm9tY1RWZXZPQkJueDlib3BpZ0RwdTErZVJ6ZFJTVFYyZ281bklmMWFaamNa?=
 =?utf-8?Q?1R7eN1T2XD+dbmuRjIonIiW6LDK4PBzj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVQ4R2hMNEFjRWhuNHNYM3Z3VUhIMUxGTk1tMTFHVEZvNXV3OTM3em5uWVhO?=
 =?utf-8?B?MHRuR3hJNGE1QlU1bUdFU3VJL25GdkNPZy9EWVZYSWFzWTFMNWlnaDd5TXZX?=
 =?utf-8?B?SVBYbUphdm5LK1V1RWJ6YlFvSzZJalpJMExSNlZpTUNaa1NiNndMRzJzTGgw?=
 =?utf-8?B?Z0hacUtkd0VsVTVwNEw2ZDVYZll4alVKZXl4dDNYT0xmRW1iNk5NU2xuL0dY?=
 =?utf-8?B?QnljTFZGNmplSTUrWkU1ZU9GeTB6U1VNTlZsNWJuQ0hBRDM0M2E5a3NJNmNy?=
 =?utf-8?B?a1pMQmFlRFJwZ0h0YWRjZUJ2dTJhcmx6d3U5U3hIN1Y1UVhZZk1sTE14M1kz?=
 =?utf-8?B?NzVaMTF2RnNqc25raFBJRUFpbG5hNDFBR2dDb2pweFVQa2NWQlU1Y3o4MzFz?=
 =?utf-8?B?UFJFTDBmVEljRzk2cUFVdjdPMWhpdnlvMG9YWk1UK29pS1ZzNmwyeHpxMzQy?=
 =?utf-8?B?eE1wbDAvWXMyZFhzSno0cUhkak16TUNndkNqU0NpcnZTcW5sOXQvbVBTV2RL?=
 =?utf-8?B?QzliOEV5MldWNzFqSUpNaCtrQ3VQMXZqdStseDgyQkN0Y0ZNT0tieHN4WmFa?=
 =?utf-8?B?elc4aGQwa3VBeDRkZ3RramdUQ2lnVlp2VThXT2cwRmhkSUgvbGdoOUR5K01a?=
 =?utf-8?B?OUR6QzU1M0JYYW9IV3RlRTBjUEp1N2pibE05ckNvL2JPL1hLdDJKTDRvaEJY?=
 =?utf-8?B?eXhZRjUzbVhkSnZxUjM0cnI1T3VWSWxDbmFhL1hLRXhlbnpTOGoxUWN2UEZK?=
 =?utf-8?B?aGUxRFZnTzJXZWJNM1FQTEVVNWxwM3dDVXJWRnZsTGFpYk9RazJTT0Q0U3BO?=
 =?utf-8?B?NDlteUc2MnJRc0djQitkTEZBcU1ta2hERFducElrMldMSmI0cCtoWkhxQWNK?=
 =?utf-8?B?R2RSVFVLK1U0SElnYmpYMlloMXBPdUFOeng0ckM0MWNUMkRnenhhWmp0MTNT?=
 =?utf-8?B?NXVZUjRIaXhRTDJEdjViUjdHQVdKMHMwWStGM0ljVjFYZWZHRk12bHEzdWpI?=
 =?utf-8?B?cDQrUUVaKy9JeE1Gd3pCM0EvdG5xdmpRWXhVN2p6Q2tyYkhJUkd1MXIvY0VM?=
 =?utf-8?B?S0FTaEpqUXRNeXhMWmZobno3dk9na1hLa3dxZU9Sek4rN0xtWE5vc2YrYXhq?=
 =?utf-8?B?RzZaeG9iUjhMYXZnT01KekQycmxhU1ltTWpXWmMrcjhsQXRObGpNbDBXck1T?=
 =?utf-8?B?Z2pEU0t3b0FveTBnc0N6L0NzUTd1SmgxN3RqYjVlS3drUlVvZmhUNkpyTnZ0?=
 =?utf-8?B?S05IK0VoTURSYzlCN0JyWFNBNnhhd1E2OW9wMkVnbnA0WlJJSlN6VTZ6VGJV?=
 =?utf-8?B?cGdPK2l5TVIrOHRWYTRud1FHUVd4dkFrSWUwWVY4TlRlVVY4OGtIMWtNbDBI?=
 =?utf-8?B?YmtiVTdUTlI5MFZucXh6LytYNU1YeklITS9DbHV1NlIyZW53alpLdnlLM0Ux?=
 =?utf-8?B?eTF6bVh6WUYwZWJRbEgrQUF5T3NvRFRRWlB1RU1NeEZJdCtKRjhSVWxjak5m?=
 =?utf-8?B?RFhJZFhOU2tYaFNBdzZ3TFcyV2FzK1RRaGVHelQxYUIxeG11dlAxNHVodG1a?=
 =?utf-8?B?L3o2Zmx5UXRtTzdSS0dpVENEMVo2a054TjhuUTdyTjV5czlrSWlib05QdlZi?=
 =?utf-8?B?cnJHTmFpbG5kb0YvVmR5U1lWbHgxcThOMTRIeXdFdFFaTzFxZUJldStWdlNC?=
 =?utf-8?B?RzJHaUpscjhyNHBKNno2aFB2TXNGSGtxSkVadEFvTCtLbnBtaUY0KzY5QzUx?=
 =?utf-8?B?ZDJLdkFSNUpyK0JMUmZ1T2dJZ29ZcUJrNWJYclBHb3RMNUc3MXMzWFluVkNv?=
 =?utf-8?B?azNzNWZwSSsyYVpxeFJzTUZpU3oyU0RmS1o2OXhhZCtySkJZRWhaOGx2NmVu?=
 =?utf-8?B?ekg4Q2VtazQzNlkzOEIvbVp0WWlHcWdwYVhMaHFwY0JsZklFQUpkaXE4NDJs?=
 =?utf-8?B?YmdvdVVXN1Y5em1hanlUM3A3aWdEUmVHWWRTRm5WU3VmdmVLUklRdUt6Y2Rx?=
 =?utf-8?B?RlNxSTJOY0QvQTQ3MzVDaEloOGtBWitNOVphU2FWeHlKOElkWXA0a25mVnV0?=
 =?utf-8?B?K2ZEOGlEdStIZ0h4ZXlkYWJYZTBPNlB4VnBCRFdPU3dLT0xld0p6bk5FaUlu?=
 =?utf-8?Q?qU3Pu3eXXJI7Oa1XDFdPQNFh2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3a3909-1232-4a58-e8ad-08de203f3e5e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:55:13.8378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YT9ppbsvEu3jrAwjLIVqw492e68X3JteTyjQLznM6bokt/WTv/gweMRSafWL9gkcRVK6GlOu5ththrxVU13dcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330

Hi Wei,

On 11/3/2025 7:30 PM, Wei Wang wrote:
> Introduce the IOMMU_PROT_IE flag to allow callers of iommu_v1_map_pages()
> to explicitly request memory encryption for specific mappings.
> 
> With SME enabled, the C-bit (encryption bit) in IOMMU page table entries
> is now set only when IOMMU_PROT_IE is specified. This provides
> fine-grained control over which IOVAs are encrypted through the IOMMU
> page tables.
> 
> Current PCIe devices and switches do not interpret the C-bit, so applying
> it to MMIO mappings would break PCIe peer‑to‑peer communication. Update
> the implementation to restrict C-bit usage to non‑MMIO backed IOVAs.

Right. Quote from AMD Programmers Manual Vol2, "any pages corresponding to MMIO
addresses must be configured with the C-bit clear."

> 
> Fixes: 2543a786aa25 ("iommu/amd: Allow the AMD IOMMU to work with memory encryption")
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> --->  drivers/iommu/amd/amd_iommu_types.h | 3 ++-
>  drivers/iommu/amd/io_pgtable.c      | 7 +++++--

May be apply same fix for io_pgtable_v2.c as well? (Of course filename changed
with generic pt series).

-Vasant

>  drivers/iommu/amd/iommu.c           | 2 ++
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index a698a2e7ce2a..5b6ce0286a16 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -442,9 +442,10 @@
>  #define IOMMU_PTE_PAGE(pte) (iommu_phys_to_virt((pte) & IOMMU_PAGE_MASK))
>  #define IOMMU_PTE_MODE(pte) (((pte) >> 9) & 0x07)
>  
> -#define IOMMU_PROT_MASK 0x03
> +#define IOMMU_PROT_MASK (IOMMU_PROT_IR | IOMMU_PROT_IW | IOMMU_PROT_IE)
>  #define IOMMU_PROT_IR 0x01
>  #define IOMMU_PROT_IW 0x02
> +#define IOMMU_PROT_IE 0x04
>  
>  #define IOMMU_UNITY_MAP_FLAG_EXCL_RANGE	(1 << 2)
>  
> diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
> index 70c2f5b1631b..ae5032dd3b2f 100644
> --- a/drivers/iommu/amd/io_pgtable.c
> +++ b/drivers/iommu/amd/io_pgtable.c
> @@ -367,11 +367,14 @@ static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
>  		if (!iommu_pages_list_empty(&freelist))
>  			updated = true;
>  
> +		if (prot & IOMMU_PROT_IE)
> +			paddr = __sme_set(paddr);
> +
>  		if (count > 1) {
> -			__pte = PAGE_SIZE_PTE(__sme_set(paddr), pgsize);
> +			__pte = PAGE_SIZE_PTE(paddr, pgsize);
>  			__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
>  		} else
> -			__pte = __sme_set(paddr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
> +			__pte = paddr | IOMMU_PTE_PR | IOMMU_PTE_FC;
>  
>  		if (prot & IOMMU_PROT_IR)
>  			__pte |= IOMMU_PTE_IR;
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 2e1865daa1ce..eaf024e9dff0 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2762,6 +2762,8 @@ static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
>  		prot |= IOMMU_PROT_IR;
>  	if (iommu_prot & IOMMU_WRITE)
>  		prot |= IOMMU_PROT_IW;
> +	if (!(iommu_prot & IOMMU_MMIO))
> +		prot |= IOMMU_PROT_IE;
>  
>  	if (ops->map_pages) {
>  		ret = ops->map_pages(ops, iova, paddr, pgsize,


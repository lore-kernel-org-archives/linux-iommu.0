Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474FE33FE
	for <iommu@lists.linux.dev>; Mon,  5 Aug 2024 04:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722831476; cv=fail; b=Qo39hJ/InqC1ItHvd8d5DaCmytRKUWZJk7lNATlmZecI9KWctRewM0il9i8RCWlmzDM/K2Nwn48Ypcln1fbpr1p1hNrvVWwb792tNFlAxPJEi5MCzB1ytEsme83YKFIMDKMCWnxTZycWaGMRRtFJsVg05fgdomZpYZ5/cyCZsag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722831476; c=relaxed/simple;
	bh=lpeLR27wi+C+aC2F58DBX8otbdOFzBfuFFhqBUJ1eaA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QUyD0Dl/sYHrodhrToJWxcl6XtiwvYs7DLmkyf3KwI/xiBtRRnZnmQ2yZfqaQDFvmmwktmKpGlslZ2sqpd6qIATcVGgyv/eNlcHlfe8DpbbdGgDZLvBnsaVL3jfCJmwbrdV6NvktgTt9H1YqBtieMgN7fxdNkQT5q4LUE31mgfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L5GQVX6o; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L5GQVX6o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otm4o/AMt5gixvb0mw3+h3bH34DYkb1iOVRdXN9DtYiF7/UiBqdbxptwgXdBK3BRKSHKwUsxVHVGC8RBs6lul/u/wiKXZYPJZIJSrhB7DolyQLm29DsxHDHf4SpvM6HI1mGUZtuIfFZrzBkU5dplb252CMuq9F2OHZ+JgQdhL1Hedwsd/4HvborFDBcXmmKadB9FfDqZsIV6fdbaWuLioA+U4+T4z2S+Wn3Wwfj47VvxYOhEUTnRNtlWw1Wtio59ldzZud533WonGBDPbEwgNVvi08RBLTbTnKidg78qZOSiAzjiEiwEdRDZH7Z1l7HefvU3i5oYikWVtDRB3bO5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjOr97BUREeiVfaIz93tYj/RuRkNVuYv5IAYx6f61O4=;
 b=LYt0wpuGW1xNs1G4pRxPwp6CFr3HMlCx4Qn2p1+AXEAWT4XtKm7HK38pjifyeMS8iL4V19AJVbnKhnSgUTXOmsfXPW4XB3g1hi98OZvk8xFmGtY1fjFE9Vs2y1dkxr0BJRkrX+WqcrtD1hbOeEHtnlX9BmKpLncDykKvi9AqbPbgOzWf5fDZwBHdGOpxoH/cuh70eTARrVb2kDwlpf8diJO/MD8Bd3gspU5WhxyZGTUlcIgxf1l/x4O63T0VGhwNZ0fp6zjcetmPgWelIb/5uVUi+7HltJ/OKzCG2uizsMRzxc3GuUT0Hx7pu2DTK42zacrLqJsNNbknuEox1KZxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjOr97BUREeiVfaIz93tYj/RuRkNVuYv5IAYx6f61O4=;
 b=L5GQVX6on3h7011gqScjln7txJOxA80m5fta9vrRHiYyR7vw2DodJ85LOWOQv8FREI4tX6wEJdzIuzMbEsxlGmo7bwxIKgURIEaCmk7l99l6nakE5cu9iibt0bmSigY1rrPhRNJepuLwWiLXRln82atoMd0a8xdNt5rhhM1kW8X95PDl1tJU2v7EfvZGfZqo9L2V3fFtNBXQI2Usmzt1OyRTypcR6zxiPXv0x2DSZv6+oqNjTQf6edIcE+Luy4Zmgb/YKJAGGgswrwaP1rzx1gK2aK+9gfpVhnEUXBUG1XlZsRAmxfgtRRZ98Xt0z9/nMzq12eXx25QoarwiSzFzXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 5 Aug
 2024 04:17:47 +0000
Received: from BL3PR12MB9052.namprd12.prod.outlook.com
 ([fe80::d7e1:595e:d907:90d3]) by BL3PR12MB9052.namprd12.prod.outlook.com
 ([fe80::d7e1:595e:d907:90d3%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 04:17:47 +0000
Message-ID: <70015438-4442-4aea-9878-89c3be7f9974@nvidia.com>
Date: Mon, 5 Aug 2024 09:47:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] iommu: Optimize IOMMU UnMap
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20240801033432.106837-1-amhetre@nvidia.com>
 <f71896b4-876e-4bcc-95ae-8d182c259771@arm.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <f71896b4-876e-4bcc-95ae-8d182c259771@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::9) To BL3PR12MB9052.namprd12.prod.outlook.com
 (2603:10b6:208:3bb::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9052:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: deeac952-8fbf-4462-10ef-08dcb5058ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Um1kSFhucUl5U2NOZWk1VzZVai9SNW1EUEpTbFN2RVRMNDhIelc2MDhORzVX?=
 =?utf-8?B?anRiNkNRaFZLdlM1WWlQTWhvY2tLOThXZ1crd3MwQ25JcVNQYUFQalFqaFlZ?=
 =?utf-8?B?MEMzVENmZk85SUtFWDlidDhxMDllVzZydExVdiswV3dPM0VzUjdpY2lldldL?=
 =?utf-8?B?ODViRXEyTGllOENrN24rNE5pRnd1VU1HZDhFd0hsVG5HZmFlUnpTOXhhekNY?=
 =?utf-8?B?RzUxY2t0cWc2RHJ1c3NJaXVJQ2IzdjNPQW1tcTBDaGUxaHhWb0wxRG80UWYw?=
 =?utf-8?B?bGMyTVc4aWVOekY5YmdZK09SVnFOMnBGMjZXeDNFd0IwVmdiTkZldXdUQ0Uz?=
 =?utf-8?B?WmFheE1ITzl0dzFoN2Y4NHVsSUlrZTIxMUJhOEVaTFpPVkREOXA2YnppYjNz?=
 =?utf-8?B?eDNUNUw0WTN0eXcyamtMV0xOa0JTYWpCeVVlRldZVnlhV09KR3JiVDljME5m?=
 =?utf-8?B?N3BPalNRSFE4RWMwV0JvWXdwSVBvR3F0aEJwVzB0akNWbnUvbUdjS0NSYkoz?=
 =?utf-8?B?MEd6VFJHN2xMbHU1b0ZPek1Wbm1JWXdlR3VCTUtvMGJnMUVNZUk4NGRZL3ZY?=
 =?utf-8?B?M0tmUS85OXRoRDRnU2s3ZEVseG1oZTJUVWpoNW5pbTRMcXphc2JWZDBodzJO?=
 =?utf-8?B?MlRKUm5kZHBRRlE5ZUtEQVJSZnc2Rm1FNm4yVW1TcmV2WW90ZHpPanBLQ1Yw?=
 =?utf-8?B?ckc4dGZweUJkSDJyUFdHRHRqS2JyeUIxSkN4RUN3NnlTWDJad0I5c1FhcEdI?=
 =?utf-8?B?bi9hOTA3bWphYTNUWVZlaVZlOWVyOHZjYUdidXJmajgrMEh5YXFycWE1Q0lE?=
 =?utf-8?B?NnlTQkNqRlVaRURTeVh2bUN3bjFJUjBvVEFmYjkza0RqVncxUGFlckFmem5X?=
 =?utf-8?B?QVRYSDdDN0NiSXpMOTQxS2l6bVBKN2xBeXpuMFdSQjZBZWFISEJxdXhCV1lG?=
 =?utf-8?B?dStsUVZod0pwQjdvZjZPOVU0bVVtTlVWR1E3aHpxb0lpT1BNWnV0TlJIaXc4?=
 =?utf-8?B?L3ZsWm9XZHVhTFY1NmRBd3h0WTg4RWFINXNJakpnRnhvbjJHWEpQMklzQVpv?=
 =?utf-8?B?R1FEN2t0dWFxM2NCMkV6THM3WisydWVYd013cDVwcHFwb2dqbVFPM01RYjgz?=
 =?utf-8?B?b1FkL1huZUdzVjRMWVNrbWY5RW54aEJ6b0NzSnNuV1RmckV0RE5hcmNLWUdD?=
 =?utf-8?B?UStZR2xGQ05OSnBrNHloY3lZMGcxMHRVeVZ4UU5XVWV3anRRV2F0eXQrY3px?=
 =?utf-8?B?V280MTIxNGw3ZmJ1T2MvQXd2WkR6d3NKSC9DNVFFclU5dVBKT3M2Y0xoc0ZI?=
 =?utf-8?B?eVVYNnpEdzBQdUlML3BhQWI2RHNmTjhlcXRRLzVtWXdHSFhYbnhidVdpYXpa?=
 =?utf-8?B?aUdSblRUZGJsT3ArV2pmdDArQzF3N0ZJanBRUC9QL0pqZXhHWDVZa3BzL2g3?=
 =?utf-8?B?NG9iU1ltb2J6UDRJNzRVdm9aMGJzdmtvUnozLzVwUUV6S1NuMHNaTGZobVRt?=
 =?utf-8?B?TThFNTVuM21GUUFIQnRYWmhQL0JUUjJ1ZE9RM3A2c3FMWmlhVVY1VDhHZzR6?=
 =?utf-8?B?b0p6bFJTalJWT2hUdTJmV0hSbWZJaHpEZ1ZxbTRGVWx6NWN5djFWTjUwMVhS?=
 =?utf-8?B?UjUyQ2M0WmxLM2hVTGxTYnZ2eis2WENIZjRrZ3pySCtNRENjMGtiYnprN2hQ?=
 =?utf-8?B?OGc1dW1SZjNMeGFjK216SldCOVZidldNRmg5NE9PQTZRR3pLVm5OZTdXMjBI?=
 =?utf-8?B?OWNQOGZlaFpobFcwMnhZaUo3czdNZnNvUy9lS2psL25YdEZzWmxmSUh4cGdU?=
 =?utf-8?B?N0c1SlFjbUZhRk03U1dHdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9052.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0N6Umk3aFNhd1dzbGVjZVloaFE3YUFoZWlkNDZjUHFBMGF6TnJ5OFlLVDRP?=
 =?utf-8?B?d2tVZFBsaXl5VFppUTBOdGgwaHQ4ckhOKzF1QnVxdTJEd291bGtzL3FNbkZo?=
 =?utf-8?B?aUtyOHQ2SnY1K085Nmp4N2tsTGkzSzdEc0hkQVM3WmVZU2QxMkk5WEZyTTZT?=
 =?utf-8?B?am1RYlFIcjM0SVRPbVVhRy9kY0FMNUNlaHo2eVU3Q2lOM0VWcnlWTGlLV3NS?=
 =?utf-8?B?RWNKdndaV3A2NkhEbGJiNkpoV1JuNWFSMzdPcU1qeERrWWtlRWNySXpJbXlq?=
 =?utf-8?B?S3hDd1VvUG51dnMzd2xmZHVTbUwrS2ptblJGVlU2K1JqYkZGYk5iZ2pYNW5T?=
 =?utf-8?B?bTJVMzhsbVBncERoTEFZZE02Uy9vbkNUWUpaRWhPRE1FdlFNWDNSbVZLRXZR?=
 =?utf-8?B?UldFUjFWUnNoVEF5eVZiNi9nYWNlY2FkclhFZ1BSMU90b1dyODF4QlNNV2ZD?=
 =?utf-8?B?Q25CTXNyM3NmVE1GMHQyTXkwUENDOTVDU3lWOXd6anZSQk9jRG5VUGlLMEN0?=
 =?utf-8?B?eGtiSFIwTGpMYXFHZ1F4Ulo0ZVg0dWJkT21EcUFwdEhHVzdLcE5uQTc3SWxI?=
 =?utf-8?B?eDJBbml5R3hNalA5NWdzdUtUSytkS01uNXBSeXFINFJPZjRmK1F0MFQ4MkQ2?=
 =?utf-8?B?WUQxTkRoaHVZQmtld2RMQmxVQXpJTGFVc2YyMDFVZkxOTHZ3eUxFeVlNZ1BO?=
 =?utf-8?B?Z3kxTCtXM3VhL21kUWlTQ0hrTUpSLzlvSVFBTXYrcDBiOVFrSUtXU3ZvS2FU?=
 =?utf-8?B?VkU4Q3M5cUM3Z1B3cE9KWFkvODZPcUV1VlNKT3R6TmtETElSTnU4aW9DOCtP?=
 =?utf-8?B?c0lzRk5tZGE4RnFKVlpUaUxGSXY5VG85QlQ0bGFPazEwRVdnRDJTSWJ4YUlI?=
 =?utf-8?B?SHpqVnFrQUgyekwrVnR2Y1JDaHhnT0RuRzZQNW51MHJ4MUtRN0NSYi9CcXYz?=
 =?utf-8?B?N2dqV09GZ1lwZjJ6eG1vU1AvN0g0cXFKUFpoNDZtV25oNzZpNXZwN01TaUds?=
 =?utf-8?B?UkhnUHdOL1hsNnRMZGNYTDBJcU9MSmYxbVRua1BxVmFaeXhQTWtLa2lxcFRl?=
 =?utf-8?B?cEY3bHZET0xveWN0WTZLK0xQbFFQT3k3YW01cUxQUjlUeHlqUXdObmo4MFlE?=
 =?utf-8?B?NzVSSWF6S0NseFdML2JTM3hoVDJOb2JqK2VVaHFYY2Y0UWZ6WDFyQlV4UGtj?=
 =?utf-8?B?Tm1xZEg3WmRTS1MrM0NsZk0vcmI2bG43c0VVYVgramhEUFFWaFR0VVVYOUtw?=
 =?utf-8?B?QlhnUkI5alIvLzhmMmRZaTdvL3hjbUdnd013TUM1dnN0TDVLb0dNbGFQbGFN?=
 =?utf-8?B?cWFvQWhhQ2tCVXVENm5LZ3NKQ2FIUSt4MTFCY3J1eXFxMGR1empRVGZhd0x4?=
 =?utf-8?B?K3BvMFRMWitHaGZqeU5oZzdsekh3UzYxSlFTZWdiSVBMRUwwY2lCNXZsaGpL?=
 =?utf-8?B?cVZTamhPWnF5UVUrRXl4NjlVQlBnWHBEQ0JqTUxuMWMwamRRTHo2MG53bDI0?=
 =?utf-8?B?VjNSOXBYdXZuM3ZqN3FYNnRNOVMvZGw1eWkzWFRGTXV1VkJSZkpzV1hJM2JG?=
 =?utf-8?B?bTg0Tk0vMnVFZGVDcGpVdjNTdmsvZDI0bUF3SEVvQUNQM2VIQnZ5UXE3aks5?=
 =?utf-8?B?VjdGK0FFRDRlc3NkYlROM3FXR0lWbHNFdlFObmpUS2MrTkxPZWRDWUZKVzdl?=
 =?utf-8?B?aEE0S0lkZWhJSENzaldXa3Nvd2dLeDc2Y0dmUEFFQTFCZ3RMMmJHSjNIY1lP?=
 =?utf-8?B?UjhEQm9GZnpIcWoxcXExMVdFTFZmeUlvUkI3akVCdjFJKzZCeThYeHhSTHFD?=
 =?utf-8?B?ZVNQcGsySGp5aFl5ZkF5dFFmRmxLVk9MdlhxaUlta2ttMmZqZ1BhK1prZExL?=
 =?utf-8?B?QzJlTkZyd2xhMFUrUU5RWEsveS9xWjJhVTEyL1o0MW5kQzVWTXBnczN0SGV0?=
 =?utf-8?B?UlIwajl6eHNZOGZEeTJqN0pQNXQxY2xZSVNsZmFLTGdvemZYSnJuTnlaclMw?=
 =?utf-8?B?cGMvU3JDallHRE84bVFTTHNHU1FoTWx3SVZXYlExOEJVM0tyT1dYSTJRWGZI?=
 =?utf-8?B?OFJmc1BPU1ZSZTJPbmFxMFh5clhJeDY1amw0NkJISnNGcDRUK3d1czZDdWwv?=
 =?utf-8?Q?gPkUMbcLyHXHItlWWm4wLt5SA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deeac952-8fbf-4462-10ef-08dcb5058ff9
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 04:17:47.7549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFJ1eE3PBjYTaeyLr9hlImhL9zzLtObVf6yaA/PVWxBy8v9wVg1mKpBOybGvUAHZgUipXdZa2ZqY3TnLLdG8SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066


On 8/1/2024 9:53 PM, Robin Murphy wrote:
> External email: Use caution opening links or attachments
>
>
> On 01/08/2024 4:34 am, Ashish Mhetre wrote:
>> The current __arm_lpae_unmap() function calls dma_sync() on individual
>> PTEs after clearing them. Overall unmap performance can be improved by
>> around 25% for large buffer sizes by combining the syncs for adjacent
>> leaf entries.
>> Optimize the unmap time by clearing all the leaf entries and issuing a
>> single dma_sync() for them.
>> Below is detailed analysis of average unmap latency(in us) with and
>> without this optimization obtained by running dma_map_benchmark for
>> different buffer sizes.
>>
>>               UnMap Latency(us)
>> Size  Without         With            % gain with
>>       optimiztion     optimization    optimization
>>
>> 4KB   3               3               0
>> 8KB   4               3.8             5
>> 16KB  6.1             5.4             11.48
>> 32KB  10.2            8.5             16.67
>> 64KB  18.5            14.9            19.46
>> 128KB 35              27.5            21.43
>> 256KB 67.5            52.2            22.67
>> 512KB 127.9           97.2            24.00
>> 1MB   248.6           187.4           24.62
>> 2MB   65.5            65.5            0
>> 4MB   119.2           119             0.17
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>> Changes in V2:
>> - Updated the commit message to be imperative.
>> - Fixed ptep at incorrect index getting cleared for non-leaf entries.
>> ---
>>   drivers/iommu/io-pgtable-arm.c | 34 +++++++++++++++++++++-------------
>>   1 file changed, 21 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>> b/drivers/iommu/io-pgtable-arm.c
>> index f5d9fd1f45bf..32401948b980 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -274,13 +274,15 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte 
>> *ptep, int num_entries,
>>                                  sizeof(*ptep) * num_entries, 
>> DMA_TO_DEVICE);
>>   }
>>
>> -static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct 
>> io_pgtable_cfg *cfg)
>> +static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct 
>> io_pgtable_cfg *cfg, int num_entries)
>>   {
>> +     int i;
>
> You can make this a nice tidy loop-local declaration now.
>
Sure, will update this in new version.

>> -     *ptep = 0;
>> +     for (i = 0; i < num_entries; i++)
>> +             ptep[i] = 0;
>>
>>       if (!cfg->coherent_walk)
>> -             __arm_lpae_sync_pte(ptep, 1, cfg);
>> +             __arm_lpae_sync_pte(ptep, num_entries, cfg);
>>   }
>>
>>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>> @@ -635,9 +637,10 @@ static size_t __arm_lpae_unmap(struct 
>> arm_lpae_io_pgtable *data,
>>                              unsigned long iova, size_t size, size_t 
>> pgcount,
>>                              int lvl, arm_lpae_iopte *ptep)
>>   {
>> +     bool gather_queued;
>>       arm_lpae_iopte pte;
>>       struct io_pgtable *iop = &data->iop;
>> -     int i = 0, num_entries, max_entries, unmap_idx_start;
>> +     int i = 0, j = 0, num_entries, max_entries, unmap_idx_start;
>
> Similarly there's no need to initialise j here, but I'd make it
> loop-local anyway.
>
Ack, I will make j loop-local.

>>       /* Something went horribly wrong and we ran out of page table */
>>       if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
>> @@ -652,28 +655,33 @@ static size_t __arm_lpae_unmap(struct 
>> arm_lpae_io_pgtable *data,
>>       /* If the size matches this level, we're in the right place */
>>       if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
>>               max_entries = ARM_LPAE_PTES_PER_TABLE(data) - 
>> unmap_idx_start;
>> +             gather_queued = iommu_iotlb_gather_queued(gather);
>
> This is used exactly once, do we really need to introduce the variable?
>
Ack, I will remove the unnecessary variable.

>>               num_entries = min_t(int, pgcount, max_entries);
>>
>> -             while (i < num_entries) {
>> -                     pte = READ_ONCE(*ptep);
>> +             /* Find and handle non-leaf entries */
>> +             for (i = 0; i < num_entries; i++) {
>> +                     pte = READ_ONCE(ptep[i]);
>>                       if (WARN_ON(!pte))
>>                               break;
>>
>> -                     __arm_lpae_clear_pte(ptep, &iop->cfg);
>> -
>>                       if (!iopte_leaf(pte, lvl, iop->fmt)) {
>> +                             __arm_lpae_clear_pte(&ptep[i], 
>> &iop->cfg, 1);
>> +
>>                               /* Also flush any partial walks */
>>                               io_pgtable_tlb_flush_walk(iop, iova + i 
>> * size, size,
>> ARM_LPAE_GRANULE(data));
>>                               __arm_lpae_free_pgtable(data, lvl + 1, 
>> iopte_deref(pte, data));
>> -                     } else if (!iommu_iotlb_gather_queued(gather)) {
>> -                             io_pgtable_tlb_add_page(iop, gather, 
>> iova + i * size, size);
>>                       }
>> -
>> -                     ptep++;
>> -                     i++;
>>               }
>>
>> +             /* Clear the remaining entries */
>> +             if (i)
>
> It seems a little non-obvious to optimise for one specific corner of
> unexpected failures here. I'd hope a zero-sized dma_sync wouldn't blow
> up in that case, but if you want to be safe then I'd cover it by
> tweaking the condition in __arm_lpae_clear_pte() to "if
> (!cfg->coherent_walk && num_entries)".
>
> Thanks,
> Robin.
>
Yes, makes sense to cover this in __arm_lpae_clear_pte().
I will update this in V3.

>> + __arm_lpae_clear_pte(ptep, &iop->cfg, i);
>> +
>> +             if (!gather_queued)
>> +                     for (j = 0; j < i; j++)
>> +                             io_pgtable_tlb_add_page(iop, gather, 
>> iova + j * size, size);
>> +
>>               return i * size;
>>       } else if (iopte_leaf(pte, lvl, iop->fmt)) {
>>               /*

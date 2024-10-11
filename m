Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B6210C0C
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642181; cv=fail; b=PBbs8zVrGJ2QpQor9RFzeUCeWaHS4cUpjnuMSoWLHW2SRAibYH+kbvAgf8UZoY6ptiiHzRmegmJeNWhsyKfGBw8Hd99fT32Ca39335DYPGiiUzF8q1/El4/A1Ttw+lHHqzKO9lZU6hYg2dTU1tcd4NyWpTeTn86N9VyS8MtpjHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642181; c=relaxed/simple;
	bh=EKKbw4n/XEY/2PsA0GA5ca/nOsZyG3ekQYb3c2TqptA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dup/6UB733nmFKn8Y09Rdicut1/8XeKENn1z0Vbwob1zLNRHD/DdQVKmQmMqyfHNbWn9nossCWNkmKmaDK7haXhRSRqRAPjubAd/INZMAH5KW3ZhUL+QEaoanMbvGlZXMgjvcNej6Q07b9MBMV9a9i3RB5Qy5bqPSHGkc1zKrc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1Etj41h9; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1Etj41h9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6ZC9BZmmsW/9xShiXilX4fIbaGVu4+jih8pVzqCHAyZ+EnGEDRiu3fVFcTP+K5Plw067QsQsclf8B20dXzgTKENHdS/mAOap2yY2hXVrFe8Vj/b3c4Xb/zouPom4czsHEsxT+Uqxwn258uagWXtUUGpWoretE769qFfNZtDZZYjS7AvGJ0eNPlTS9kNF2OdkgxGB+Pt8gX8xhhR+LzVq3OZjesDO4QTPnsHOEFcZd9D8wspV7O3czVKQV4W3x3G4wL9vYX+wrPmd6qfJ4y4dNJDaFBceh9WrIzhSbYmIq/j8NesdvWyh9LS3UOAwlfoqTiVQ1zqPa6HTOThWblFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDU+ZkXtp2rx7HqizjZhIQmhqh0i/FzEyaUQNRfNtug=;
 b=vnwylRCVhBQaqorSFQ1selB6p2ALai9/GWMTasjHTKP2gmrqVV5ODpNhnrpPrTsYzlC1ZzVGZS6cJEfc0C7ICEqSkjtxZ4EUnTjyktUN3lEZA0eZvOURfBIDEF8FFM3HIHTwIip4lcxy9CnF/V5sgVUuDeWWY6gNAOiBo63U1swHzkLUWLJDTk4cjb+d+SPwNskSmtofjbeSeOx+6AzzB8xpGBr6LOmV9nMjvCOgLdvTt/3WtgpgVDrH+1kA4AlQj/NLzl038n4jCImxkdugBjDgBgO+SQz0/HuRkub3j4n0Mh13hI9sYIGwbA0nIYNfWCk7rOXcN34+HQZpxg6r6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDU+ZkXtp2rx7HqizjZhIQmhqh0i/FzEyaUQNRfNtug=;
 b=1Etj41h9WQVjhZFqigT0MTdWQe1f05xu+umAzTsDf01bjDEUg0XpYOyY3Wu95tvgNSw0q4AvFplBdZy0PsGHOB7eGt88q2k/zcXUHdp8thZsJXiJaOwMY7tSVsncxmIP2gsHWuHXt6OlfYnVq1pb1Jg/ZoRzLtF3RTU7KtXYUPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 10:22:56 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 10:22:56 +0000
Message-ID: <7accc5fa-7e0b-4cb1-abc7-debc451285b6@amd.com>
Date: Fri, 11 Oct 2024 17:22:48 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] iommu/amd: Introduce helper function to update
 256-bit DTE
To: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Cc: joro@8bytes.org, robin.murphy@arm.com, vasant.hegde@amd.com,
 jgg@nvidia.com, kevin.tian@intel.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
 <20241007041353.4756-3-suravee.suthikulpanit@amd.com>
 <cc44a5ca-ddf9-ca7a-93f8-38bf26ac1f1f@gmail.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <cc44a5ca-ddf9-ca7a-93f8-38bf26ac1f1f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: c5516696-da9c-44c2-13c2-08dce9deac0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFFzejRhZXJFbnV3eVBUOHljbmsxaVpyM1ErRWQwbHpkUEhwWnd2Tk44SytF?=
 =?utf-8?B?K0dnRnhPUHgzUDZIZVFDOURBTzkxS0QveFlHRU1UVjFPcVYyWkpsQ0lPSnls?=
 =?utf-8?B?aUwwS3hSYnlEa2FjNEI0TmdmbVJ0dk55VEFmMGZ1SXlURnlGcTUybzVidm91?=
 =?utf-8?B?WGNpYTg5QWkwV3JiVllQb1k2dkM5ZmF4UzMyRUpyV2tjSHlid0JNSWs4em1U?=
 =?utf-8?B?RzdBeE13cG04RWh4N0NBT3VRSkZaQUVlSzNDcUd2QWhRVGFuVXNlOEZuQitj?=
 =?utf-8?B?L0oxM1BiUFd1NGxwdUJralJ2Y3JpcXQzcXVMbG4rLzg4ZUJOUEM1ZzdFRUFh?=
 =?utf-8?B?UjV5b2d6bUZ2YWhYR2dmM0FqVkppWXJKRUZvQ3NLaEZoUlFtdWo4dnZ4am9m?=
 =?utf-8?B?cXhQRkhBZk1tWDNuaStYR3BRd1FQc1lwK1ozTlp1dkROenU5RDRGdlJMSElD?=
 =?utf-8?B?c2I1QytsdmtNNjExeTRqZUlOaWpXaURvOW8zYWkyOVV5TWxKNTY0QmJ3S2pq?=
 =?utf-8?B?OHU5UkYxclBtay84WEh6TVdEMkgwK2JrT1hlZ2dVczJXUk85MlJDZkMxWnpm?=
 =?utf-8?B?Z2NQV1lvdnoybXZmdUtFbSt1c1VSYnAyZnVSYUJkRENTWTduM3VXa2hQNm1E?=
 =?utf-8?B?YVg1TytXVnVsc1pFVkx0cWs4QjlUWitMQkJadW01bGVHVWFieEpWTVZZbzNO?=
 =?utf-8?B?OVhpcU5acENsVjlLMDJGZVdDaC9tZms0Zzl0SUtKUmloL2hUYU0rUmdLeGZm?=
 =?utf-8?B?UG56aE1QMTVWRlpLcEpnVXVHZGlUQUVTL3dFRXZCTFNqTmJuSkdES0N5NzJS?=
 =?utf-8?B?ekVkSkNXRGVyQkJLM0w0Tm1rN1UvQ3BOOFV5L3JGWC9IajlZZ3BNQ3pMMTNC?=
 =?utf-8?B?UUNJaS9VakZSRktaK1NFNXg1T0JzdHZaSk1MS0FnVGJzWTJ5YnUwMVRGZysz?=
 =?utf-8?B?MC9LMGpwWDAzRnh2dXVUWDFGUkFXUmx5a3h3Rm80M0dWZGtNVXFNeWVXKzQy?=
 =?utf-8?B?Sk50Rm9WWmsvV2R1N3FyYW5CaHU2eVRkU1FxTU04NFZVektJNEg4U0luMGVk?=
 =?utf-8?B?Vjd5TGtqNFEzUzZwRmRiSDBuWVQyMHBPU2RQRFRnRzhaVEtCVlF5bEpyZ3Vu?=
 =?utf-8?B?QzA4cVNzd2FCR3ZvSUp4UXNaR3MvOW5WTWNHTzI3dnlsMDhwcFhJbGwxbmRj?=
 =?utf-8?B?eFBTNXRjeGx5TGpRQXY2V3I4TUtiSUp1bkJkYUdpTENiWSszT2c1SmlFakxB?=
 =?utf-8?B?TGhkVkR5MVNxRFhJNzdkY3c4QkUvR09rcnVBNER3SlRNYnRLcVI3N2NmZkJj?=
 =?utf-8?B?RzhEQmlmYWJtQUFwSUxYUWRyUDFpNG1GYmJrV1c4ekt3c2dGZDdLMk9ZcWtr?=
 =?utf-8?B?em8xYlZzcnRjYzZ5WDRleWFNK1hPOXk4MkcwQ0Fkanl2WWRFY3I2aGtCK2c2?=
 =?utf-8?B?OEdIRE9Hb0V6QU1IL1NqNWlSV0c5eDFhMSt1dGpZTm0zWEpTTnpac3ZpdUt4?=
 =?utf-8?B?alo3a0pkNEJOQldOWUV3WC9QWmtZSjhIcm5qSTNKcDljaG1iMTJySDBXV3pp?=
 =?utf-8?B?UFpkc1UzejU2bUd3Qnp2MUR1MnZmUnJMcnZBdEF6OTJTL2NsZ0RGZVRsTmxw?=
 =?utf-8?B?ZkxkTE41cHpBZGdlODVJSDhoc2EybVBDSWZhVUF4RU1KWWZQTlM3ajZMN1Vm?=
 =?utf-8?B?OU03UGJHVEQvUXRnSTFLemNMZ01FZkJ4akxUYy9ZS01CZjVJMG5Zck9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHBBWFNUSXFURGs3UW1OdTBxNWdEa1JMS2tzVGlmdE1Kd0Y3NEV0TjRvb29B?=
 =?utf-8?B?UHFaMzh2blJOSHZmUWxrMElwU2NLYTN3OWdienNMUW1BS2dEWVNza2hJR3ZW?=
 =?utf-8?B?QmNIeHhKbWgrS3N6VE5tZmZZblBlT2lzcHZLaXVVY095WTRxWWNhRzJBMDdF?=
 =?utf-8?B?WXU5cUlITW56MzdLcjBrTitPamZLRmdWb1BvRVlVa3dDc09YR0lGMjg0LzE4?=
 =?utf-8?B?Q0l6b3NYM0pYTEFyUVIvMVkzazg5eDJKTzBxVEFEaFpIUStaU1dnMkVYbm9k?=
 =?utf-8?B?dTdPS0lUYk9kVzRtazNiQ3VKL2E3Q2Z3RnR0dEU4RzI5RVN3cXV5WlR1VEk3?=
 =?utf-8?B?azBidkpBQXNNQ0V4bnI1ZUU5WnNtT01zRm4zZHQvRnE4V2oyTUZSTENIbTIx?=
 =?utf-8?B?YWx3WlV5RlBrODJJQ1VBWGpxWUxKeUNCbmp3S2x4ZjFscTFEK2NjWHJlbWtZ?=
 =?utf-8?B?ZjltQmVRNUxVcFJrN0pMQnhqbVNISUNkUnhVMHc5RkJLTDhUOTltbHA1a3ky?=
 =?utf-8?B?ZVVaZGx4R3orVGdnVjNObk1OeXFtaXBIa2o3RzFyR0hrZXljK3JTYXFqakhv?=
 =?utf-8?B?Z2ZEaVNyYXJBRlVEWERzejVDa2xNWXpISmI2cXlZbmlhcUpmK3FXUnNhM1lo?=
 =?utf-8?B?Q3RjUU8rVGZjSjFaaXkvTjQ5NGxTVTNNWENDcnZwdE04OWFZYit5UFFyYlRz?=
 =?utf-8?B?Z3JKeFNRS0NqTWMvaGJHRWtBTEorZzJlK0N2eE40RjU4TXlrNWtVWU4wQm1j?=
 =?utf-8?B?b1VteFRIejlmUkd0N1dZekRzV2hOSkNLTmFmcFUzYW91UEVWd0dyYVVPblZj?=
 =?utf-8?B?ayt5VWY3UElUazNJMy9uMHZxenQ5SG9CNEdKZFowMzlCL0lQbEpWMHNDSnhX?=
 =?utf-8?B?ZHlwY2haQTUyM0RNcTRPNlFRZDZjU0NWVno0OXN3MG1ON09jdVZIMHE1ano5?=
 =?utf-8?B?dlc4VmhLSDc0VmNtNjRRcm9CUlI4VzVNYUJHQXdPcjR6OGpPc3JGYnBBUTY4?=
 =?utf-8?B?eGtxd0F6WWxaVmtMWmdxbFZvRkZmWERybENaWWo1NmdmSWxkRzIwT0J4SFYw?=
 =?utf-8?B?aVVWZVE5ME1ZcVExRC95TkIzc2NxOEZDSmdLNlN2YW9RQ1Z0OG5FTnl4M0wy?=
 =?utf-8?B?YWJKMDZDTEdvMkVTZzZXa0ZiT3J3a0NrQW9pdmt4amMzNWZzUklxVFhqZkVL?=
 =?utf-8?B?bVllcy83VTRJUFlEanhtNGxURjYvTWlmTmVoUTFWalgxc2k4KzRVeXYxcFJG?=
 =?utf-8?B?elA4dENueVRIN1NVdVk1QVBFOExrbGdVOFZ1Z01NVWh5SDF6ZlpOMVNNeGdq?=
 =?utf-8?B?UjNPSkZaZUFzdmdkWHRXL1ZGWFhXWENsWXdmd3h0SUhua2p3dC94VmZYby9Q?=
 =?utf-8?B?aFc1YnVTQzc1N1ZlMlh4K0VCRXFjTlJ2b01PUjZWNTFZWGFOaUl0VzhDWG03?=
 =?utf-8?B?WDNmV3pUV25iaW0rNkdpZDlCTHhVL1o1cGdMUE5zamkzR0FIWmh5K09WUjM2?=
 =?utf-8?B?U2o5dC8vWW9RYVVZTjhodTUxbWNZcFZVaDFKcUppSE9QRFpHNW90R0F4K0Jy?=
 =?utf-8?B?NzlOKzM3bnNUNUZwQWthT3ptRlVTbmV4bFFWU2VNNjB2ZFVZcXJVMTdOaUN3?=
 =?utf-8?B?bVlIYXIrQUhHdnM3Q0xuQXJoSUhEWXdmTGt3dE4vZDZrdXREZ2lZRlFEa1dK?=
 =?utf-8?B?Z1NUSnhJNnlCQlJLY2xQVURha2tQdENtcWJjSFpvd01iYThicElPZnMwRzg4?=
 =?utf-8?B?WU9YM2RySElmRG9BWm5vblZmdkR5bVpPbExKK3YwV0QzY0lqcmxuUy95ckhx?=
 =?utf-8?B?QklhSDRBdUtzVTRwOHdZZVBDTGpaMmlzOXd1VWc0V2Z4MTF4QWwzVk1kMEkx?=
 =?utf-8?B?SnhIdEtvZG84RGl2L0xsUURIV25Ya1VRUnVuNHI0bVRsWHFYRkRUZFNBS0Fh?=
 =?utf-8?B?YzJsKy9Td1VKVHIyNy9jRG84K0M1VVVoV0pYbjd1VXdmOEtEL3FyTnMzMXEv?=
 =?utf-8?B?cTB5VnI1WnV1RFM5cUk0UmNOclBBaE9mcytMd3ErWDk4WWUyOWdaY1dBOUFQ?=
 =?utf-8?B?U21FVW51WnlRa0JKR0JOY2tpRm9oaGE2bVNjTmdnaFdjMHp0S1U0Y1VrQi81?=
 =?utf-8?Q?hU3jGJqMnqggsswNDFVxBmNmq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5516696-da9c-44c2-13c2-08dce9deac0f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 10:22:56.6150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZr08s1RePyo/Ex/CFnn1Gzdb5p0GjallOhRonBubPkvT4lh0NCH5XkZn1CGwgU7/bbu+l3qiMzWDYH0T7CMWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792

On 10/7/2024 9:42 PM, Uros Bizjak wrote:
> 
> 
> On 7. 10. 24 06:13, Suravee Suthikulpanit wrote:
> 
>> +
>>   
>> /****************************************************************************
>>    *
>>    * Helper functions
>>    *
>>    
>> ****************************************************************************/
>> +static void write_dte_upper128(struct dev_table_entry *ptr, struct 
>> dev_table_entry *new)
>> +{
>> +    struct dev_table_entry old = {};
>> +
>> +    do {
>> +        old.data128[1] = ptr->data128[1];
>> +        new->data[2] &= ~DTE_DATA2_INTR_MASK;
>> +        new->data[2] |= old.data[2] & (DTE_DATA2_INTR_MASK | 
>> DTE_DATA2_RESV_MASK);
>> +    } while (!try_cmpxchg128(&ptr->data128[1], &old.data128[1], 
>> new->data128[1]));
> 
> Please note that try_cmpxchg inherently updates &old.data128[1] above on 
> failure. There is no need to update value again in the loop.
> 
> Please also note that the value from ptr->data128[1] should be read 
> using READ_ONCE() to prevent compiler from merging, refetching or 
> reordering the read. Currently, there is no READ_ONCE() implemented for 
> __int128, so something like the attached patch should be used.

Thanks for pointing this out. I will introduce the attached patch 
separately in this series on your behalf as author/sign-off, and review 
the current code to properly use the READ_ONCE().

Thanks,
Suravee

> Based on the above, the loop should be rewritten as:
> 
>      old.data128[1] = READ_ONCE(ptr->data128[1]);
>      do {
>          new->data[2] &= ~DTE_DATA2_INTR_MASK;
>          new->data[2] |= old.data[2] & (DTE_DATA2_INTR_MASK | 
> DTE_DATA2_RESV_MASK);
>      } while (!try_cmpxchg128(&ptr->data128[1], &old.data128[1], 
> new->data128[1]));
> 
>> +}
>> +
>> +static void write_dte_lower128(struct dev_table_entry *ptr, struct 
>> dev_table_entry *new)
>> +{
>> +    struct dev_table_entry old = {};
>> +
>> +    /*
>> +     * Need to preserve DTE[96:106], which can be set by information 
>> in IVRS table.
>> +     * See set_dev_entry_from_acpi().
>> +     */
>> +    new->data[1] |= ptr->data[1] & DTE_FLAG_MASK;

>> +
>> +    do {
>> +        old.data128[0] = ptr->data128[0];
>> +    } while (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], 
>> new->data128[0]));
> 
> And this one as:
> 
>      old.data128[0] = READ_ONCE(ptr->data128[0]);
>      do {
>      } while (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], 
> new->data128[0]));
> 
> Best regards,
> Uros.

Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2117.outbound.protection.outlook.com [40.107.102.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101E14659F
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728078478; cv=fail; b=iAOMNNiPXaKvbwtAIoiaIZSNFRg6WbvrJIpwx4XMP92cKC3jbSfDGKJHZIOf2sp7WZHPItI9ERcfJ7k2+ePgbGz8QZZcZksEYv9Gm+NINIedihAcOMRCt5q4d9WFv+YEnzlQgniFWmz61WHXrHtPOzCCjwlg8czaZQWbE7neaPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728078478; c=relaxed/simple;
	bh=QMaWbTuDG+xZ59F/8qRAwOAXI5kWbWloBRlKorea0i8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Neuu1k+UW0FafH8ca+zWbXZjx40BSJTCCV1QYYZR4Fd+iAKu0vChLcrLTy4vLvn3wcW8tFPKMD5qS0lrNG06ZHzebrg82WG8kOeHsQh3pBS27ibnI7XxqHtWc2oEJBNavRE97KHbDxDg7WAqE0LbNgSHMRtsdf2hCnISg6N9OaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ecyPEQPX; arc=fail smtp.client-ip=40.107.102.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ecyPEQPX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSZ9TCIIahYlEPqt7B4G0nf/UL4OvFU6SWZilZoo+t5XWTfVihdJEW8Mlv+tYgtqjs2F9+YWbBADPIB/ykZf0eNB2+jl/A4SVbyCDGA5KAg9AxiSHXL53LYfzI/r+oCiWVzgD/YWoZm/ABLBfu2ttlPT0eVLOfLJIi3CpXlXlmQcuiDnyqdz5ww4IyZ/s8uFGeIWAs9Lus+onfETDBhbGPTaAoyUOMLW/5rql9Sjzen+jNysc3GTEBGl+WgU5t96UnOtSjiEkuzd330YDMwiHQom+3rUq+EGYYXAwfkauSp//L+btYw08Szx4Vrd0eAhV3mKiTz+39IjPv8No3ccig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diQWPA8oggHI7hm8R4/b3ndc136JNUqhnKfYax9k1FM=;
 b=s5xujOYaZwCsVtFSB2e2Z7IpRvZbKkmq9UkTjEa91qA7NCuK1stbyVeMFjdKopSsrdukseAE8+bUlvg0mnrWZCFUELKKVslMu51qlCmPqUJs9SykYXO5gXmqYSgPedHViih0819dTebYAG9Und3LcQlwsJdv0VyK0M8JSGrXPPAGhfROVo7PasYTgvv7kOAh9weTGtVc+zKN10afQGwKsDBXkPhJGTlaqYbDSX/XiUs/hLGmDk+1iVbVbTaMpHL238yvhvbZqUpKRkgI0rpdZepPb6caYlqLUZ/ppTBFIYbOAOwySowtjNuQ8qZCa2Pqt7J1iP5OCGjnsmcYjOLOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diQWPA8oggHI7hm8R4/b3ndc136JNUqhnKfYax9k1FM=;
 b=ecyPEQPXZOH6ActbRCIjH9w1T9O+sf7GSKk2GWAu3sYQWxpeG4qMs1uyo5K7p1h+b592fMj4OPH3F572WZka+L32W52SMVw/BcVa7WCofZvXGgMuErxrqXRCqxrM+9s8qcluFU8KYnflzmfKoOblJzprkUnHPn8Yhee2QwP8BcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 LV8PR01MB8551.prod.exchangelabs.com (2603:10b6:408:193::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Fri, 4 Oct 2024 21:47:52 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Fri, 4 Oct 2024
 21:47:52 +0000
Message-ID: <87ac9686-cffb-43ac-b8f0-ccd3632fe5cd@os.amperecomputing.com>
Date: Fri, 4 Oct 2024 14:47:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Daniel Mentz <danielmentz@google.com>
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, james.morse@arm.com, will@kernel.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
 <CAE2F3rDH3aK-OLO6TSXgQFU+DDx6Rq+4uwLQb3WZ+CMWWEGCNQ@mail.gmail.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <CAE2F3rDH3aK-OLO6TSXgQFU+DDx6Rq+4uwLQb3WZ+CMWWEGCNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::24) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|LV8PR01MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adf42fb-b8dc-4f00-5eaf-08dce4be3285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVFQdGk1eTdINkpvcTRhUG5kL3hGeUg3NU5LdWQxakhtMVJLdzAzR2lOYlVL?=
 =?utf-8?B?YlJXeS91VENLOUJSOEZqU1pNUmJLa2ROU3FNaEljNUE1Tkxub3djK3BMeEMz?=
 =?utf-8?B?OHV2bmNkK3J0aHd5UmE4L0lpelJTSmFoaFJucmVmdXd0d2VSaDViYWtYaWw3?=
 =?utf-8?B?dEZ0UXc1UEN6S1ZWbzhneGlJenRGMHp4K0xTZG1CNGd6YzQrYytIMG8zSXVN?=
 =?utf-8?B?cTU5MEMxeGhlT0dpS2E1cXZrVU81VDNIbGNqcTZQbVdjaVN1TGQ5OE1YZzFv?=
 =?utf-8?B?d3RKNTNpZWtMVVFUOTg3QUxiS0tMdEZhbDRYK2w4WkNVandFNFR3clZrRENK?=
 =?utf-8?B?TklyV2VaM29QdGZSRDdVU1orQlhjaUdyeUYyTjU1dTlhU0cvNWVyTk1XNkJV?=
 =?utf-8?B?Y0tvcjJmWmZCWDZ1ZVdhdEZpUUZ4aURNUDU5dmJVbWNJdzEwL29jYUZUVUJ0?=
 =?utf-8?B?VnM4SlhndkN6eU95SitSNlVKY3dZQWk3R3BYK1gvMno0UlRNNHE4czBmYk4w?=
 =?utf-8?B?NEZBeGJsbE9pK0xCSmVtYmI4MGsrRy9XeXZuL0RUTHZUVHpidkN3YjBWS2RE?=
 =?utf-8?B?ZGIxZS84RGZtL0RUWHNKN3RLRi9LSllwRjk1ZmFMRDRMQm51dVBaVEp3SXds?=
 =?utf-8?B?OXo5RS9aaUtRQmZwV3FjdmlWRmVvWXUzaWovRjhja2syN3VPUEFGMklXRWFS?=
 =?utf-8?B?QUtnWkp1SUtWZU05cjlSc2ZtS1hOaVJxYVowdHlLNUttSTRuZTJlSWh4T2Zt?=
 =?utf-8?B?My9SWHAwS2lEdDlQNEp0c0VlZlRmWHd0Yy9wR2UyQXZtMjFjU2J3b1dKeUtL?=
 =?utf-8?B?UGVYZGs2L0JMdFprY0FBVnNXTUlqaC9aM0Vwa1FpL1JOTVNKM1VmLzRkNVZM?=
 =?utf-8?B?NVlzQUQ1NHRWa1NsZnRHTk9NMGFYSUdKc2xoUnltNDlJbVU1MGVDSHNLR3lv?=
 =?utf-8?B?b1QwZDY4a05WU3duMGV6WlBRMVFuWkozR3hmQ1FxWWJ4UG1SS21hdVN3SUhK?=
 =?utf-8?B?WWtDdTFUOWU2RWk0Mk5ERzBtWTYzaDBiQXdRL253S2daeWRXSXJnK2cvVEVq?=
 =?utf-8?B?NEhDWURneHRORk5FbmthT05jcnZUQUxuQ1F1QTdraGhITm9WcEFBUldYaktR?=
 =?utf-8?B?SklJOTdzNWJiNmZRT3ZDaGdGazdGN3JxQXhqYUtIMEJNL3ZCbGg5Rngxb1Zm?=
 =?utf-8?B?Rlczc1B1dS9aQmRydDF4RVJCYW9NMzh3Nm1pc2VzUGJnUStkYVhrVk4vOGZs?=
 =?utf-8?B?S3pyZENvUm9OYUZzcE83ZG5QVDhzOTBYalBxY3FkNEwrWXMybTVCNTlCcXRJ?=
 =?utf-8?B?WEpiaE9rYXduZi9pRWkxS0ZrcjZJOE0yNEpvdm1hbWJqNWIxNlQ2cUtoRVND?=
 =?utf-8?B?VTl0TGUvWWVNRFJpSXV4ZFlWbUtSR3JuZGdwNXJIa0ZnM2diYnQzbjhaSEU1?=
 =?utf-8?B?dWlyNFJPQ3F4OEJ6QzhZSHhINDVEOUlCYy9uMXdtT3VpcHhGakJrSm1OWCt4?=
 =?utf-8?B?SWpNem00RFRwSXc2QmRuVmhIMXVRRVhFcEhzVHl1aUlINDlRQjA2SFl1Qm4r?=
 =?utf-8?B?RzYvUm1WZ0lXRzMxZjh6SlcxdjlCZkRXaHBXWW45MDFuNjExenFJekVEc09J?=
 =?utf-8?B?NWNJVVRDeS9VZFNFYkYrNEJZS3I0ZFNDbk50NDgxRlBjN0tDZlM5ZTJCbUhL?=
 =?utf-8?B?c3VrV1lIOUlSUWpJMG9tdmdwQUliem1Zb3h6K3FRd3dYVEt1dmNqd2xBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWc1Si9yQStWdi9ydWp0SmFiU3M0N2hIUnhSeTBFYjRveVNZRmJoR1Y1STFB?=
 =?utf-8?B?aHMyUVNmWjNmZmJoMEowLy9uVlpuU3BpaW9xUkdpY0JpcjRSd2RROEJTTXlm?=
 =?utf-8?B?MDBrQk1tS0wzOWlWV2xkN21hTXRWZ0pUMUtUSFBIOGRKVU41bjJvUEN2WkFM?=
 =?utf-8?B?V09uREJ5K3M1VjB4R2xxbmFFKzNjc3Zad2psVFZ4cG9EeDdMMk5pU0UvajlW?=
 =?utf-8?B?WWRYNUdvTXVkNjhtbkZEV2tQVC9WcHExVlIzUDhibEZJRWF4cm5LR2pVNjdF?=
 =?utf-8?B?MlBaZkE3RUk0bUhCa1dFV0RqOXJZaWhBNkowVS9GODhEWnBCNlF1MkRDNHFa?=
 =?utf-8?B?UDd3Mk9meFdLZGoyd1czZ0QrcFFEL2lWY1k0eldvUFpBemU0SHJZOVlaODd1?=
 =?utf-8?B?cTZqd1ZUeUVCR243bDk4anBFaUdvUkRQcFZzUFZFMGNZRGFaTHFqVCszUXdP?=
 =?utf-8?B?VXBpbTRuRklxdUYzN1VaSnNaTkFsNXVuTDdsTjNwNSt1UTdtZFpoUVFTVlRj?=
 =?utf-8?B?aXcrdyt1SWEzQ0x1elRia1dzWWpRK2JmT2d2ZlhJaTBkSWs3emdweW9xdi9p?=
 =?utf-8?B?ak00SDNkejhoZk8zaVNiaGUxY2dTLzVsK1RNblJ3Z1FRdkxYaXI5c3RpdUZk?=
 =?utf-8?B?NEh1ZVJQZkJMam9XSTBxa2pMYzBjT2tSWk9HOW8rbEZPT0tubzRnUnp2MXIw?=
 =?utf-8?B?UkVQOUt1c0FWMnpJWUwvVkJmNTI4bXdiZ2RwTWVzSS9LaDlsWXZQNFlnMUJr?=
 =?utf-8?B?YjRCSFBHdUg1bnpJNGNGQlRnZXJiQkFiVGgyMjFmdlc5dWNjcENpMVdXZ3Q4?=
 =?utf-8?B?T3I2K2tqa3FONzFzcHlLMEVncVI2aWJTbkRiNFk1WnI2WHFaZklLZVBMS3hp?=
 =?utf-8?B?TjZqYy9JZkFIY2FUNWhIUy9LMiszL3NKb1NmOEZJSUI4cnJxTTFkdVBmb1RK?=
 =?utf-8?B?V0tCdEV2WnNkL1FVVTBVVzNXMXhHekZLbkJPTEVaVHZ1SGxPZ0prMGZUMlF1?=
 =?utf-8?B?bVF2REVkNTN5eFY3SEdwM0kvQTZ3VFpZNk1DMjVhNFNOQlRTbmMvMUM4TWFk?=
 =?utf-8?B?ZUVxYVBXMGFKUG1aUCswWjk3WXJ3cXZZRkhxVm9JeXBRazI2MzIvckREd3Fk?=
 =?utf-8?B?TWhWNlpLODc5aXJCTGdWa3hNYkM4Vk43elU2MWFDanMwaDZVTlpISVJQcDUy?=
 =?utf-8?B?Ym5uL2JkUFFWeGZLS0IrZHA2cmNpM2t0bStkcWJvNk5OcEVGK0habEJGYlFl?=
 =?utf-8?B?NEJ0SnV3UGlyTncwaW10ekpaT3loaUJkYXZlSmRndUo4VDhReTBML1JkcW1J?=
 =?utf-8?B?UTVXYWxSQjgwd1VxRnBHYnpHM3JvL0o5NlBKUzFhVzdoaEE2d1Zwa1ZvNnJa?=
 =?utf-8?B?VExOcThFd29IQ1pCMjVzSzNlcENVZ001QllQZlRxL0hTU2lSYm4wVS94QS9t?=
 =?utf-8?B?STFUam5XZWtMakFONm8xcUJmOEozWGJNV1JUQ3NZdjB4cHBPbHZRSTNpOTFs?=
 =?utf-8?B?YkNVQVNucUZ2SThSdnk2SnRYMCtaZWJmZjlyTzEzZXU5ZVZIQ2tjZzdjSXNw?=
 =?utf-8?B?MjdGOFZMMmgxZGI4cU92aU1UNWppN0JBbDRTUjQ2bUNpZGMxelJ6QU5sMEFU?=
 =?utf-8?B?UlZlSkhHdTVqbEh2RFU0ODVWOGF6SzVGWG9iN2x2NUVzeWZEQWhOejdpbmww?=
 =?utf-8?B?MTdzenFFd0NzbkZqaWRWUjVoMGtnaWVjV2hDNmY2Z2ZacDRqY3VPSUNEM1RH?=
 =?utf-8?B?VEYydlhxeTZORlVVaHFWZ3JUNEIyVTdXYm5JZ09lTitwWXdQRFBHa20xZXFS?=
 =?utf-8?B?bGpPQmY2b3paTm5zc2xManFWMzNoQmZ4RXhEa3Jkem1DRVl5Y3ZxQ25LWnJq?=
 =?utf-8?B?UXV5OGVLbVpMWWkva1laRG1pTUlEOGdWSVZWTGM1NXFGTVE2a0cyUDgyV1ph?=
 =?utf-8?B?cmNBRmZpdEtwcHRyY3Nab05keHdPUy80bTMvTWUzeXFNVnZuK2Jva0VZUGNC?=
 =?utf-8?B?WXlkWkMvaTVQTndHWnk1SllTNWVSUmFISmo2Rk1SSWYvNi9QSzVpZkJzU3g5?=
 =?utf-8?B?V25nemZGTGhBdGlYbWxIZWVnQlFWUys5cHpoS1NxVTVUcy9HS214TzA1MGZj?=
 =?utf-8?B?NDVGVUFEbzhqREtSVGIvM3I3ZHRhcWc1ZzAwUWlER2Y1dCs3Vk9JRUk0Tmg4?=
 =?utf-8?Q?PdFeGT/lg3KqFiJH1R0RbVU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adf42fb-b8dc-4f00-5eaf-08dce4be3285
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 21:47:52.3423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JqIqrq6i+b43cqnDx9Kaw9O1ycyaHjnd88oVVrZeFr7B9dkh11isbqLpuP1gUpIXiDJByFOCODPNSi+3g1JUE9+xnJEdsiW7uwVLYv6kTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8551



On 10/4/24 2:14 PM, Daniel Mentz wrote:
> On Fri, Oct 4, 2024 at 11:04 AM Yang Shi <yang@os.amperecomputing.com> wrote:
>>   static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
>>   {
>> -       u32 size;
>> +       u64 size;
>>          struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>> +       u64 num_sids = arm_smmu_strtab_num_sids(smmu);
>> +
>> +       size = num_sids * sizeof(struct arm_smmu_ste);
>> +       /* The max size for dmam_alloc_coherent() is 32-bit */
> I'd remove this comment. I assume the intent here was to say that the
> maximum size is 4GB (not 32 bit). I also can't find any reference to
> this limitation. Where does dmam_alloc_coherent() limit the size of an
> allocation to 4GB? Also, this comment might not be applicable to 64
> bit platforms.

The "size" parameter passed to dmam_alloc_coherent() is size_t type 
which is unsigned int.

>
>> +       if (size > SIZE_MAX)
>> +               return -EINVAL;
> I'm assuming this is for platforms where the range of a u64 is larger
> than that of a size_t type? If we're printing an error message if an
> allocation fails (i.e. "failed to allocate linear stream table (%llu
> bytes)\n"), then we might also want to print an error message here.

Thanks for the suggestion. Yes, we can if it really helps.

>
>> -       cfg->linear.num_ents = 1 << smmu->sid_bits;
>> +       cfg->linear.num_ents = num_sids;
> If you're worried about 32 bit platforms, then I'm wondering if this
> also needs some attention. cfg->linear.num_ents is defined as an
> unsigned int and num_sids could potentially be outside the range of an
> unsigned int on 32 bit platforms.

The (size > SIZE_MAX) check can guarantee excessively large num_sids 
won't reach here.

>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> index 1e9952ca989f..c8ceddc5e8ef 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -853,6 +853,11 @@ struct arm_smmu_master_domain {
>>          ioasid_t ssid;
>>   };
>>
>> +static inline u64 arm_smmu_strtab_num_sids(struct arm_smmu_device *smmu)
>> +{
>> +       return (1ULL << smmu->sid_bits);
>> +}
>> +
> I'm wondering if it makes sense to move this up and put it right
> before arm_smmu_strtab_l1_idx(). That way, all the arm_smmu_strtab_*
> functions are in one place.

I did it. But the function uses struct arm_smmu_device which is defined 
after those arm_smmu_strtab_* helpers. I have to put the helper after 
struct arm_smmu_device definition to avoid compile error. We may 
consider re-organize the header file to group them better, but I don't 
think it is urgent enough and it seems out of the scope of the bug fix 
patch. I really want to have the bug fix landed in upstream ASAP.

>
> On a related note, in arm_smmu_init_strtab_2lvl() we're capping the
> number of l1 entries at STRTAB_MAX_L1_ENTRIES for 2 level stream
> tables. I'm thinking it would make sense to limit the size of linear
> stream tables for the same reasons.

Yes, this also works. But I don't know what value should be used. Jason 
actually suggested (size > SIZE_512M) in v2 review, but I thought the 
value is a magic number. Why 512M? Just because it is too large for 
allocation. So I picked up SIZE_MAX, just because it is the largest size 
supported by size_t type.



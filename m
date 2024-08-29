Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780A61B86C5
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955524; cv=fail; b=gGNtYa3pzOM/gfWLAsXW9tb+FQAITy6qqo5NwMTClKRar9AUFgQBFXrJ6yWYcOD5sICXepvI0bkvQzCiOcK+k/XShyhz8skXVI0EyBgL0yBXgklXeXHrjg2rfL1Qz4WHx+rcmjSfBbpEsg/RS0b3w79bzvjwX0A8LP4ms5aTe2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955524; c=relaxed/simple;
	bh=DzVNV678DJPTqSpTT8Lu8CxpAZhY6lh/2EaxWsyO7bk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=usGM1YE5GeztISl1KceBPGUb8mjbXT6rt5/FjdUyLLqpaZX4MqeiFRyHxh5x57zwOjlcDaL0UcsKZAMMdPBegjBd8JwGQyykJHW4TrRabp/w/RvWUitdiUhjVzaT7gAGU2MsOBXuS5yduUobRHmsIEL5kqj8EpzibRgCXqqCqxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iZdkbE9X; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iZdkbE9X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtU3PPghT81h1xZ3oPBCZu+uepJSl9Qm3foWM7ypR3kn+MuSQy4A7gGhNXuxI5TYDIXZ69h3YcHp11BelRbYZDVIQfmlHClmwj3UsIJSv5g+P/lsC+FYSLJeLE2c37HpMD9e1t+QVi9N/kNx/ZghhJj6n7kkORvOBK9lPle0os0XqawCX/cWBF+nnfrzqmn8hgQTRHLNn2z7QU7aWYU3ulaDfll5Pfvm4KwagTfHVdUvM+Z0ShSMnG6yXjibdafSlcec97G+Rp6HJbLxcCMcb/ECj9EPVqZA4zsw45/RkMkm6k+0GokK5FXGxpWRl8AIR8MSjjcbiK0NBN8cjSSKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQrry0X/AmpeeUqC6YVG0EoRKSb2Q7b5PGjgh3xASTM=;
 b=JGIbiBqS1XGl6ZO9oAgRBV1yNharJhtjvbCY1MXZqimwqbqmzMwl0UxSQ78DMmAFurhCN/p5WL5GH+VDAlk3srK0H0k2VGUsc8iJUCFHQnNoU12UDT/NnLaqK/ziU8Ot5dFC+PMMZ4n6r1aHANBHwzrNspBomv9SBnwsQgO8zrAsf1C04m+097rRgPis72XK+l11ypebxiEiMeDFECUm2EmxbmeNMi5ivXH5C87IwUkXAJFZlGNnAlD2OSriQGFrhMFDB45E6NCycm1bUIrVeU+RkyKWTTAoG5TMCK77YLyYYdPONmTsBLpUNomXW/WYCWfgBku/oT2JB5AQjzGC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQrry0X/AmpeeUqC6YVG0EoRKSb2Q7b5PGjgh3xASTM=;
 b=iZdkbE9X0vmiOhEmF0lsFFAKNQ/h0h5ImtEes+r4q+/twD1C++u10CVS063tHSk9dmJuws6VBDLs8+W6IuMRbejxp1WPxa9HSVXVhYbLQmnXKysR7AyK7iQoEKaTpKQEE7JtJX3cHQRkMRhDT59UxlJBcBCrf0HnzoepZlgRdow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Thu, 29 Aug 2024 18:18:37 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.7875.018; Thu, 29 Aug 2024
 18:18:37 +0000
Message-ID: <de6d9fa7-abc1-47a1-9935-b544a7ecd537@amd.com>
Date: Fri, 30 Aug 2024 01:18:29 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Modify set_dte_entry() to use 128-bit cmpxchg
 operation
Content-Language: en-US
To: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Cc: joro@8bytes.org, robin.murphy@arm.com, vasant.hegde@amd.com,
 jgg@nvidia.com, kevin.tian@intel.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
References: <20240819161839.4657-1-suravee.suthikulpanit@amd.com>
 <e937e26f-038a-6d01-76a9-76c86760ca4a@gmail.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <e937e26f-038a-6d01-76a9-76c86760ca4a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f032fcc-42f8-4f2a-3600-08dcc857003e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWlxSXl0aUlTYUpDb2pZNW1nMmU4eTZwNlF5N25zQnJBbG9MVFpKdlVobU1v?=
 =?utf-8?B?Q0hCMVNjdFFXRjhnbE9BRE1sQmNKMjlaVFFsc2lOU1paM2R3Zm02MVF1Lzhz?=
 =?utf-8?B?VXlsTWdwM0RTTnU1LzN3S2szZWtIWm5BRmpJemFQQlUvL3JYM2d3cG85SlZF?=
 =?utf-8?B?dU15MzhUNGZCVlFldWoraGJwaFltL28vMUllTGtFaWZ2V3c1NEFzZ2lVRFdr?=
 =?utf-8?B?TDYxdEhZUVlqODlyQlVxK0h2cDlKVkxRa1Erc0FTRHZEaTN0cUJEbEczeGkv?=
 =?utf-8?B?c25iaTNodmFtZWVsakZQb2VhYndJM2Job1VxMG5qTXJ1dG94UjBCdVVWZWJF?=
 =?utf-8?B?ckRYZGtKUktKVzVUa1VBL09WWjBON1NQQmk4NGhJRWtta0N1YkNFSEdXaUJQ?=
 =?utf-8?B?ZmNZZHBMKzVndnoyY003RVdBdEI5V0QwSlBZSWtVVStBSjNzR2c2d0hZN3Ix?=
 =?utf-8?B?QTJWRmtsNzZXTzIwZVBURXBRYVpRNUJLdXF1ckxLalNNRkhVYXpOcmFHcWpX?=
 =?utf-8?B?cjJQcmJVU0ROd3lMRmNOc1JXcFcxaVlRQ0N2V2xYemZMdzZBR0tBSy9BcUQw?=
 =?utf-8?B?bk40bDladDZ6bXl0RHNDd3ZuYlRFVFJCdGU2OEVhamsrNzZzdWoxMTI4MmRk?=
 =?utf-8?B?WFZmaVYzUTFyWGhnNDU2M0plVHRrOFF6N3IyVGJEWXVRSGEvakkrN1RMb2Ny?=
 =?utf-8?B?ZWw2bkU1QmR1Tll0ckNLMUw4aXJYempMYU8xSmdOR2NhaUptT2kvamlieVM5?=
 =?utf-8?B?RlVjZWtrOWtDU3VieVlaRXFPcC9IcXFUc21YQzZUMlFVd1dLZzdDVGtEemZt?=
 =?utf-8?B?QldZTUNSLzRDOWNnZGpsUmVBc3JLYnZrL1NpdDExb2RBcjdTMVJTY0hlR3ZJ?=
 =?utf-8?B?QytEK1piazB5THQ5bzR3NWJrVWl3YW9DSEFxRDRlVWxYMHFrY3NmeXpIV3hQ?=
 =?utf-8?B?VlBnVFNNYktsQURYR2tqbDUvZWtuWlR3aE95YnlLcUZIRWJRMGw2YVpRYlEw?=
 =?utf-8?B?L3dUL2dEOExSbTdOM1Q4S2ZlUGxoSGpLbUFVT1A5azI1YWd5SUhKOTRGTHBy?=
 =?utf-8?B?cTQ5NVcyUFBuSFFvcWtjbm52L1pFdi9TQnk4aWhUckw4NlU5VFlwRVBkSmVw?=
 =?utf-8?B?SVJQaktLcFVIVVJBVGxNOHN0TG9qeEcvNnFFcmVURWJMM3FnME9ocmdOOWxN?=
 =?utf-8?B?THNYejBVM1hZZmV4RXloMytncmtUSkFxYzJ6YUdWeU9ZUmo0aHRHYWRONysv?=
 =?utf-8?B?eHY1YTEzM2labE43NUgvUHFndUw3NmswUU13dFFBajBtL3czN3hIcWxEakZs?=
 =?utf-8?B?aXA1aENpTDhyMjVhbE5MYlg0c1h0bmhYdFVjRVlhS1VVYTViWlBId0x5bHhw?=
 =?utf-8?B?eHhyK0wwOG5aRFZuWHY4bU4vUXBhano3YmE0VlB2VEszS2ZOeHU0dE9IaG1D?=
 =?utf-8?B?aDdOQzUwM3pkMHdkVG1Oa1JxYWRMZ0pLZDFEaksxQzgxRTFZdDdyUVdPUFJw?=
 =?utf-8?B?MEw5UTVUNTBWNFNmZmVGeFQxY0VZVlZmZVgza3hTVDZvWWszTk5iYlpZUFdi?=
 =?utf-8?B?MllMNi9DKzhRVkYvUmlBcGtMYkZiOGlDM3pWcTJ6QXgzS2RDb0tKaW05NzJt?=
 =?utf-8?B?VU52c0RwT2svVXJkWFRnQXJVU1gyR21pYTA1NzRRNmNOQlBLOVhrZlZDQmU2?=
 =?utf-8?B?Y2M1U2dGSHNISnhaWjZJTUE4VmVLYklEdGc1bE9oWkpJclZ2MWg2SExzME9W?=
 =?utf-8?B?ejdIZ2ZlY1pDQmk2eGVVQjVDbXVtYmNKZDRHUzBNc0JmNzRQQXNURDRSeTg4?=
 =?utf-8?B?RWNjK3pydzErMS9uZ2E4dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFdvSGdZb1pQUHFNTTNzbm5nbkJKRnJtaTZZSHUrVENtYjc1d3ZqbUtIQ1Er?=
 =?utf-8?B?UlhFb3RWalAxa1dUT0M3UDIvd2Q2N0ZBSitwcHgyRGZ1eEdPMmwyQVM5Z2Ri?=
 =?utf-8?B?ak82dlAvZ3QzcHI2VXB1eWlxUDBaMHVCUTBiMnZ0RlFjdE9QK2FqdDhheDlT?=
 =?utf-8?B?WTZsYlVqNVNqYVlaQTZPUUhZeHdzWEt2MFZJTkpqQWZkN3lYZG10WmlOQ1d1?=
 =?utf-8?B?elhoRnZrUTVOWXFnNkR5Zm5FK0c0SjNKNmJLbFRWM3VUNXNtTWNNYXRoL1I4?=
 =?utf-8?B?UEcvWjdtcjFybmtJS09uK2Y1SE5IcnhZSVJ5ZTFVSFd0UnNpUTVNQW9nTGtG?=
 =?utf-8?B?dFFUWU9ZYlcybVZOeHVjMkt6cWt4N2RPV0R6Nzhhb3Z5MVpXZnY1cmFMVXNk?=
 =?utf-8?B?N0k3VEFqZFZrb1F2cjNnV1gyVVVIL2drQlB5NFFlWGdaUHlCOHF2Qlh0NmNQ?=
 =?utf-8?B?Z2FyckNBVGJYMEd4UU9KUC9uNzQzREZZeERnY2E2eHljWnV0SGFjRVRqY2dT?=
 =?utf-8?B?aHhrRE9FMkJjaUYvbG9hVkF3TjgwSHhiVTQ5NFVoeW92RVdhRVlEaFhFS0tu?=
 =?utf-8?B?dHFtOERyc0l0NXNGc1htVWRFOTlzVjFzZStJandKTTJaMkxOeWNOcVpHdk9v?=
 =?utf-8?B?Ny9YekVITEdueUUxR0xJUXIwVGN3ZytyYjZnUk05TU9jMVF6RzhxOHkxUzUw?=
 =?utf-8?B?cGhHVHF3NVR3LzNFVGpScXJCd3NkT0hOS1JEdlE1NzNlcEIzNlphNWdicTVC?=
 =?utf-8?B?bmRIcG02WWVld0ZOZHhtdWhlbzJsZ2wyS01XYlUwUkF2K1BvZjVGYUFYZnV4?=
 =?utf-8?B?Y0FYSjJSTFEwTUl4dm9KR3Jsa1ZSSFBOWkpoanE0dHVMUWpHSU9kZUFERXRl?=
 =?utf-8?B?WlpiSHUyS2hjSUNKZ3hzSmNYYmJBSndhTVE5UkZLSXp2alVDU2lqMUxxNWpG?=
 =?utf-8?B?c1lieHlicDRmOHhzVS8vUDdadkY5SWJ2NEk2MDgyT1RQRmlRalV4cWJTMytq?=
 =?utf-8?B?aWxra3UxMUR5OW1KQ3R5M3BuUFEvSHVEbVFNK081YitlQThEOVFGUzJJYysr?=
 =?utf-8?B?bUhobUJHQTExSXdrZUVza2ZwWTc0ODNUTUV3OWdnWWdncGVKNjdMeGh0YmVM?=
 =?utf-8?B?VElycktFUlB0aWl1QzBBSzhWNzdwbUw3VEx3aHZFRC9PWnNMbGlVWTk3eVF2?=
 =?utf-8?B?Yis2NHhaQTZ5RFpkYTIyUmV3ZDdyRll6MjBYeEFYcVV5d2MxYjB6VUtvUy81?=
 =?utf-8?B?ejRPZi92VmY0czdRRWUyQ1BNb21yUThNYU95NnRtdkdINzB0aURac3d1WEZp?=
 =?utf-8?B?Nkl1NncwdEd4MTZSU1JRVVRaUElhZUpjSGhnUmplcGtlUWxMSnpPdEJPUXF0?=
 =?utf-8?B?OHpWSmNFaVZlc0tvN1FnL1AycDJEOEFOa1FYQmJhT04ya1ErS1YrWEIybGI3?=
 =?utf-8?B?cmtUVW9GZmgyemtnbHVYU3ViYVRoN3VyYXNpL2IzbkE0aTNtTlhkSVpWdG9v?=
 =?utf-8?B?RDIvcVBVdzZWSkhmR0tTWmx1TkF2SWtVRXIwcWFKc3pjckVPZWltT0Naak1N?=
 =?utf-8?B?SFQ5YzhWRkIvL1ZkQzQ0MDNkZHBUUVp3dUxNVjBUa2dVdmZxT0JiRFlYaURX?=
 =?utf-8?B?VFpUWnNTVlVGa3BtYVlmOXFBcmgxTDgyYVpvQnZEZ0lsTjloNXZPR3FiVUJ1?=
 =?utf-8?B?WFJ0empQOGVNYlBINkNnOFRRMENLYlloVmtiNWpDMEovM2pCRkFxUHNabXgx?=
 =?utf-8?B?SURVRnMrRjVJSysrRTROeTNkaW5nNGpUNFluaHZEbWdyWmR2eWUrSXBEbVEw?=
 =?utf-8?B?SnNaL3hCRzJ4aXEzLzkrNmVQMkhvWDg1TzE2MWFHL1lLQndvM0pRUmxWckhY?=
 =?utf-8?B?dHpDdTVnNmp3Q3ZnbFdSdkh4KzIyVDBuNVNyY2VpY3JSdHdQYTlFd3prMExx?=
 =?utf-8?B?Q1NIbVFSU2hFeGYxOVdickxMZW9XdDIySVVqZXBGTndaRFJTQ3hleCt4cmhu?=
 =?utf-8?B?ZFphR2p5ZEl3djEzQ2FNYTA2dWNrZmRZZ1VvU0hSODhiNjNQeFplcGVnQkIz?=
 =?utf-8?B?aFZxU0s1QTFraGtiOE5vSXdMNG5LVDZ2bmg3czRUMUxVZkZJNW1lYlNhUEkr?=
 =?utf-8?Q?skcLCJ4Mifaidf1k0dIT8d5/+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f032fcc-42f8-4f2a-3600-08dcc857003e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 18:18:37.3821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rI7HzhlX1hbdwPiGfb8Fd2USZzQLzo1nWxHJkKXiiqFrV79flIfI+qzEnr92SNnz1z2IKOGhHMncJ+ioiAoIvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662



On 8/20/2024 1:15 AM, Uros Bizjak wrote:
> 
> 
> On 19. 08. 24 18:18, Suravee Suthikulpanit wrote:
>> The current implementation does not follow the 128-bit write
>> requirement to update DTE as specified in the AMD I/O Virtualization
>> Techonology (IOMMU) Specification.
>>
>> In addition, the function is used to program several DTE fields
>> (e.g. stage1 table, stage2 table, domain id, and etc.), which is
>> difficult to keep track with current implementation.
>>
>> Therefore, introduce new a new dte256_t data type and a helper function
>> update_dte_256(), which uses two try_cmpxchg128 operations to update
>> 256-bit DTE.
>>
>> Also, separate logic for setting up the GCR3 Table Root Pointer, GIOV, 
>> GV,
>> GLX, and GuestPagingMode into another helper function 
>> set_dte_gcr3_table().
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> [...]
> 
>> +static void update_dte256(struct amd_iommu *iommu, u16 devid, struct 
>> dte256 *new)
>> +{
>> +    struct dev_table_entry *dev_table = get_dev_table(iommu);
>> +    struct dte256 *ptr = (struct dte256 *)&dev_table[devid];
>> +    struct dte256 old = {
>> +        .qw_lo.data = ptr->qw_lo.data,
>> +        .qw_hi.data = ptr->qw_hi.data,
>> +    };
>> +
>> +    /* Update qw_lo */
>> +    if (!try_cmpxchg128(&ptr->qw_lo.data, &old.qw_lo.data, 
>> new->qw_lo.data))
>> +        goto err_out;
>> +
>> +    /* Update qw_hi */
>> +    if (!try_cmpxchg128(&ptr->qw_hi.data, &old.qw_hi.data, 
>> new->qw_hi.data)) {
>> +        /* Restore qw_lo */
>> +        try_cmpxchg128(&ptr->qw_lo.data, &new->qw_lo.data, 
>> old.qw_lo.data);
> 
> You should use plain cmpxchg128() when the result is unused.
> 
> Uros.

I will update in v2.

Thanks,
Suravee

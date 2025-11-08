Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39186146593
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622900; cv=fail; b=UlHi0g3/xJtRBU338dTuyk8jTDjY4LWvUGDNkThaE13KgVxzEoGrWzBiayy+0khNMALICRFeu2PWFupQ8YhXoHKPkY2JVnyFFj7nwgx9oIbT+Op/8XEcUxLdDt5b8hCU9xRKH/c0VHJ79PQezv5mftmuu8g/66UgJ0f/IPV1MKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622900; c=relaxed/simple;
	bh=o8BjsQNBDOKVqwPrbWPcbM7IQQpLpD8k1mppiv50Fgg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T1Iu0EXNWkzjpFj2IjD2kWANU5iLvtfSpBNoTGR5YvO4MjJQ5mpD3I9b/GspZGBc9d3J/kuv742lWWC+JdmDL7u+6YIrao8cOFjEBQBH73uDJSwDTB8rl6ozANkeJ/wq5g2FjLj6B6LfKiLRzj+wKewrIiB4QAEHAUjCsY6GlWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e3oAjvY2; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e3oAjvY2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYPGgqH1B20RxKI2KxLVEhdAX22E6y7pzaK3pDLxBamXezCCVg/lnKMdlME4La7ILRYQ4i9Gd4SukACORI5wkg7GRUK/5lZ+oXMqvwlmsH4wj1JQ+peuz2ZmyapFf5R8A9xSXjQoVzOVkb6a5ePjzoyAdgcByoSJAiJB+Qd2JB2FinAF/Y8iB84IuoKpAqZ8eufIikeuvZWNLUxXoDNADjb19CiJFX8Bot7Y7p9JvwWLnjqEjYuMXaSwVMyKOKeWjyIqz0w0VCAk1YNUDSivllXc/xfXfYH50YDDa7XX+JbMjsNx5hCpWWf1qceP6EmcRmkmYo32HcNQw/ryYneeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyU4DkAhnVvoTEv6AW4DzVhvg35Ezy0hvkD57Rf7lkA=;
 b=OYuzfgv1i3rZ1hqswSVzdufusH1psBQZz4SvH+kH1kHx0lrWPumxQiO+RK/7NxZqHuP76oI0qhfpyHZQkjevkl8Py/45tMeax7of2gOMpZRLsJQdKZF9VT81T0DMqnPemwocZbtGLsARZOiZxjbPXF9AjKQ1IyCJuV89fyAds6Zh+1RQGU+F2rPOrbgkr9sq8e2lBTo+9ydG+Ta0xMviRE9lzdPpqDmAiCwZ5tPvmPyWGVY2rBeqa08IrvxmNoaGyhEF+PEzutJ+7Fn9t+6c+ZcxEH0hgtqcMH2ru3i8UHPkNh/2p9tMIOilTf4Rag77PSscaVISVc50F0zfWccRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyU4DkAhnVvoTEv6AW4DzVhvg35Ezy0hvkD57Rf7lkA=;
 b=e3oAjvY2kXnSvtfJalWK5Sjs9x3enHCZcvPAcdc3sqEY+eM8bIBFAo881Wq46co3zaMT2EDSCchuVuMPHqWQDwfuxmNizhrqIlwkoqNmXH9n5Cr11nY7PXnFwJcMIVH4sJRZtL+/R0W3Vwvc5d+aDscbuK72554L98keJb9SQ2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Sat, 8 Nov
 2025 17:28:15 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 17:28:15 +0000
Message-ID: <b67c2664-ff0b-4016-b777-5327b150a9ac@amd.com>
Date: Sat, 8 Nov 2025 22:57:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/16] iommu/amd: Make amd_iommu_make_clear_dte()
 non-static inline
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, jgg@nvidia.com,
 nicolinc@nvidia.com
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
 joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 iommu@lists.linux.dev, santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
 jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
 wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-7-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251021014324.5837-7-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:269::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: de5754a2-1b61-42d3-6e28-08de1eec332d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzRUekNtUGc0bWd2SWZ5WVZvVmxQeFNhZHVuNTA4MCt5dEFLd2NUTWZHckhz?=
 =?utf-8?B?SGpJZERISktpTFZIUS93d1REVkZnOFVRb01YQVl1ZEpBVkxsMXR1NDlDR0gv?=
 =?utf-8?B?bDJpd05VZnFUaFdJZUtDWHpyTkxHTGVqa2ZtMmpkVlVWRGNNL3h6ay9oTWJq?=
 =?utf-8?B?R0pKY1NhZHJ6aEx2cEFFY01YYlhSZStXd2o1U2JhQno0RlZqYWhoVlArc2Ey?=
 =?utf-8?B?SVBvb2Y4WXRkZFJGaHhMNlAzTld5aElsN3lUUWxDbFlIUmZ4Qk8xbnpmMGlY?=
 =?utf-8?B?MTFlbGNBemRSeUZQZUsrUWVweS9CaGo5TGdvVnJvTkVGQnphYW0wV1Z1eGpQ?=
 =?utf-8?B?UytCTHJ5N1VQNEpWOGpFbnRGSkhHVEk1L1ErOVhEYXJzSDVaQmJZQXpVY1RH?=
 =?utf-8?B?c2tldXZuQXp1NlhQK2lKQ2kvK3c5N1JoQVhSK0s2Nlc4V1U3aDFVRCtBOUh3?=
 =?utf-8?B?MUJMZHV3dVFnYlg2dFErOTJzaGIrSllGVWR4RE9sZk1sckhTVWRPRm1SWGFi?=
 =?utf-8?B?TFVHWUVpcVl1YUhJYW5ZanlJeHNOdUduaTdJVXdpZmQyWld3Q0FBdE5HQkhZ?=
 =?utf-8?B?c1BRb0FDU25TVmZ0VURnN0lTRnpBS1ROVllRaGVNNVhmSmo4OVVaTHZZYWVM?=
 =?utf-8?B?Y0g4UkhkUUVsRHpQZ0ZUUmlsVTdZbkIrWWZjWWxNZlpYOEd5VFFwUHQ4bVE5?=
 =?utf-8?B?OXlpQXRFNmN2ZXpDVENQeTZQc3FlaHcwVC9ZbFFUaU56MkZ1M2IveFBBV1Jn?=
 =?utf-8?B?bHVjbnRZdlNqbFM3clZ1MzRNZnVEc2NsQm8wQ1dqTHZnUWVHQU9acisxbTA4?=
 =?utf-8?B?VHhsbFl1Q1U1enBISnZpOWhMeFJoaDRPVWV5TlZhcWRsSWdPZjF6ckd4dXlG?=
 =?utf-8?B?cmR4VE91L3NHKytWN2tUYjhTSkVOYnRwbHQzT1N2RCtxOFRZdHpoSkRaZEdD?=
 =?utf-8?B?RExtYUwvVHlyVmcralNIYjc0Y3diUnQxc05kbDQvZDRuOFNmY1o1TERDOEs1?=
 =?utf-8?B?QVdra1hHZm5VbzN4NVN0VnlKM282RTdZZzgvMHIwOXdHY2pJR2w2Mm0yeXBu?=
 =?utf-8?B?eU1EUUx6ZjBvWnRrUkp2aTgycUdlNzI2eEtwbktMZnRvVmk4YWlKM1JMME1m?=
 =?utf-8?B?UXU4TUdobGxpRnlIL25qOTZ2YzVQTm5hbW5kdDZqUXBiR0E3MTBjODdOTDNi?=
 =?utf-8?B?U2NvY2YvZWNzK3pMTGlGVmtTUEdzUHpJL2I2eHVHcG1NZ3VyRHNzYnN0Qy9Q?=
 =?utf-8?B?bmRTSnlqK244RTB5RFMybk83VFUyZjJKZ3JCaURxQ1gvK1FKamdGaDBralFp?=
 =?utf-8?B?T25USDY5QzF2RllPd0lBR2lNQWFycHJ4M3p1blpMN1JYb0dJU1pxbHRsbDdN?=
 =?utf-8?B?N0ZmTXQxWm51c3FBM3ZReERxa1VPcGZTdXNGUVl3ZGRLR2tIbnV5eDB5MzJl?=
 =?utf-8?B?TXNYUTJtY1ZwYzdvZTkzdWpubDZKa3dnbXBoM3IxVHZXcmNaWTNTTlhBSXZL?=
 =?utf-8?B?UmtnN3BFRktNTHFDTUFtbHgrbXcyL1A1VURFVmw5WUtOL294VHdndkN1MDcv?=
 =?utf-8?B?VGRXWnZHUzBiTmlXVDIyNGljZGEyRFBUdkFKdzFHZ2JSYWc5a1NRMHpsckM2?=
 =?utf-8?B?dm5JQkY3VkU4ZjdBT1lIVEhTeFovL2hzMzFkUUJGZWxjWVpWOFVuMk1US093?=
 =?utf-8?B?MG1QRnpXZ3dZNS9raHIrYjlzaFNRVkYvMTl5OEFxbSt1TE9SazVWVzROY2dT?=
 =?utf-8?B?U1RRcEFGNjh4MGhqS2ZMSDdmeENlRk9pTDI2OGpJR0R2WlkvT3VwWldMNkVY?=
 =?utf-8?B?eXZCOWczNzRvNS8xYlhlcE1aL2x1QWtJU0JjOEd0eWlLSnV2ZmtsdTN0d214?=
 =?utf-8?B?alF1eXJnK09WZnUwQjB5N2VuWU1oSVVtTDBFVnovdEQzeDl5Z2YvMmpaajh6?=
 =?utf-8?Q?bZdGnlibYknvBLI3aMq5iaN3PJaFAakh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V090S1ZpVjBBbHJGMXV0Ni9BcXJRWFU4VGZEZXZucktrVmt0b09PT3FWajhK?=
 =?utf-8?B?aC9odTFvS3JuMFd3alBwVC8wNUg5YzRJMFhDUEtxNW5JY21xbEt3WXRJUG4z?=
 =?utf-8?B?RFNwS295cFhkd3M0L2tyNk5wWWNpblFhanplZzBBUHJnZXVvKyt5R1A3ek1u?=
 =?utf-8?B?SlFqZXRZRHpXclBKUk1DdFQyNldha25NSk8rMUZiTnBTK0RLKzNrWVJjUmtn?=
 =?utf-8?B?dE5MN250M2V4SFVZc25ySzVnY2tsV2V2Mm01Uy83aWxEYS9TK0ZvUUt3K3ZW?=
 =?utf-8?B?bkJwTCtZcW8wZTdUUmVsRlAxSVl2a3E1cGUvU0N3d2QrRzdtQVF0b0k0R0hw?=
 =?utf-8?B?TG1PbWlDUGNwd3hYMHAvQlY0YzdSR0FpTXZOQ1o0UFFvZ0VYdE0yUFpUbFZr?=
 =?utf-8?B?OUFZb3lEMy9BSEVrdE5ocnpSTnR2WW5TZE40VzhiOFpjVkVQVmFPK3R1M3FT?=
 =?utf-8?B?b3h1dGxuOVROSG4zWkFPUDdzODhueWYyNTBkdzMyZ1V4djIxTTdBUE80dmpB?=
 =?utf-8?B?bWUvYXVRSXVEUjVRUTFrNnFQR045WElha083ZHlwUGJNZU94STlFMmhwaExi?=
 =?utf-8?B?Tkl6R0NOR3pSYVoxQ05SUVRiekRGU3JtZy9xOGRuR09VRkZvdC96L25ESlZp?=
 =?utf-8?B?KzhFTnVXajhwZ3lidmNJTG1ydU5wZ0s5R2JwVTV2NmpaK2VkMkIzRFlnVk9k?=
 =?utf-8?B?SndsOWd0UU12dGxadlZjdFFqa2RBMm1QM2FuZlVJMGV6Y1N1WTh1bE5DVDh5?=
 =?utf-8?B?RFVXRGZEeitMQUNad0x5TndNbCtaT0F5MkNaZ2xnNWsrV3Z1MmFuZ0ZYVHJJ?=
 =?utf-8?B?S2hLNDJQemJyOXBWWFc5OE5OYk96RmJocjNSWFc4RVN6QUVZVlY0RUNXOWtq?=
 =?utf-8?B?KzEwM0wxa0ppTVh5TDRNMDMyL0E4eU5PNmxzckpuUGIxeEcyd3VFbXZnaHM5?=
 =?utf-8?B?eXJVYlBkWDVWaFNERHBsakVSQjkvWXl5K1lxQm1wRFhOdzJyNys2RE9xbDNu?=
 =?utf-8?B?Y2dQdEE5T2YrclhuNCtPZVIyeU0weEJoKzFhMnhwZjlSNm1rNmh2eVV5Y1g2?=
 =?utf-8?B?amdLTDBaMEVSSnl0TFNEUXkzNm8ySkpUNEs1a1N2Sk1CUE9CWWVYejY0Q1BJ?=
 =?utf-8?B?WThBQkdMbFo4QzV2WmZSaCs1ZUJVUDBhZDlGcTNneFRSVE5kelVXL0ZLMDhx?=
 =?utf-8?B?WVR4NFdYSWpzRTJvZ0s5OGNmMElvdWN1THgvSWhiQ2MzMWdHVTYwRUJ6SFBw?=
 =?utf-8?B?WTJPVFhTdlJENSt6WkdnUWtTZmZwTTgwWGRDb0JHbHVvekxWano2bW9CN0VV?=
 =?utf-8?B?VzhialRncmdOb3ZjWkNlNHlxQmFuR2Z1TEhKaEVMWTdwSVBmUW5reHRYQzJB?=
 =?utf-8?B?UmJHeVB1eHJPYjJkaUk0bWZuVHhRem8wbzk5cTNraTduYlZNUmdBSExDL0tk?=
 =?utf-8?B?dnZQRzFDbHpIMk1NV0x1VktRQURPOXU1d2tIeEZXSldlQWlmVFZLZ1M3R3FJ?=
 =?utf-8?B?RnpKR3dVVkZCMk4rZkhEdWh6bVdSNlNoYlV5UERzRTVMNUlrWkN0aDdhYVhO?=
 =?utf-8?B?cmI0VE9vaVN6M3hOeDN5SzVZYWxRd2JiTkw1Zm0xV2F6SzZyM1pvTlhFNnZ1?=
 =?utf-8?B?ZXJrN0toSmRIbC9mUE1uQ3hiY3NGaDN2djUyUVVuY2ZQRnVnc2F6N25mVWsx?=
 =?utf-8?B?SmFQM2FjcXZKV3A5NUtqaW5nUDdGQkhDS0FvTmVOK3hqOHY0a0ZBZUpuQUhs?=
 =?utf-8?B?U2RHKzhMaW5LaHFRdDg2UUhxSHk1UGdkam8ydW9MbFZkZzMxbHlKYzU0M1Bz?=
 =?utf-8?B?VlQyeDUrOWxBVnNINkllNU92UHdaQmk4bkc3UFZjUDVES3BDRmlDRk9WQUw1?=
 =?utf-8?B?Q2Z4RlJHWFdPb1BDbFBFMk9tNDZna295VTMyakllMWZjN1lKTXVwN1ZjK3ls?=
 =?utf-8?B?RHRNQWRJZ0wxbTNBQkhlcjczVEZvVVYrUXFISGc2ckluanQrUTJUdTEvOTlW?=
 =?utf-8?B?YmQwV3hZZnJ3SnpUd2plWk9CQ082MklDSkpPem9Gc2liTjYzTnVBQnk4V1E3?=
 =?utf-8?B?cFNPejVnQmpIc1JwOE1vT0tSY1J1UHdGMklKNHF3VUhNYmgzemZ6V09mejhH?=
 =?utf-8?Q?2QeDTPr7xIO+zHP9EI3foPCkm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5754a2-1b61-42d3-6e28-08de1eec332d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:28:15.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NC2va1q4+kwJbOPASqgaWXzRzTaFsTN5gS634vCyqVdP0NX7Qjf7JnVffZ0IWs+shwbmVTLMDwLl7pY3Yy1hQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992



On 10/21/2025 7:13 AM, Suravee Suthikulpanit wrote:
> This will be reused in a new iommufd.c file for nested translation.
> 
> Also, remove unused function parameter ptr.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant



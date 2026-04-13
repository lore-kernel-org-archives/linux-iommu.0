Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012061.outbound.protection.outlook.com [52.103.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB7A21D596
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 03:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776050651; cv=fail; b=Wt4MOMxbQuWkyU300uP4oJqpgZ+hI7dcNPG9CLozdFlrXVTwVoRoup/YpB7KtM+sT7vU00cp/c5/txSfXdRxCimoGuaNaFD1E+glVH5tQxUjrNX5Rnbj+FxJnAFTouylf+MQk2Ya3DN/CWKQjyyy+ufH+hR/413WazpvWf3E3GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776050651; c=relaxed/simple;
	bh=lOnEvyuoQ+t/yIEmczLVAfQTXEoEDkfzFo0TIpNk6hk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h1hEihBBRwaemzifZSC48Sr8D6Lpxyd8NHWq7iyrNeHBSjkrtcVrT5+mAJ2HSG+uwHnwF/MAYLaJR+NdCuTN6DkK94ZGlLi/8Hgk9HCxZLr9KXW+jwSHpIjUiwMD8uTND/lTs9SW1a1nRGwc96yzLWRrqVcjKARhTOw4bLkIHIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=DrwAQ8pT; arc=fail smtp.client-ip=52.103.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="DrwAQ8pT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxInkyLK9/Z1OWBLdUCm8o4AHcne1E3it1ioLFrJg57CBmj3RmAPylFbVj+UJVTDlvV4f5znWDJKpd8zIJePjwg9kmqIK5D9W2FpOPbkAUehbH2YDVxQf/7kN4rMAyQnTMrmALqQrl4duNzaHTN6mu/xCnapzSFIY1wNPk4ANsoFQdQhY9EBA+N1fUJEjUGMdH9qN7DsyOjuJtlvceF+odPu5iMtxPMQ11B/18IyNRLNiX4Ll1XUj9nw9EOBwAcynhaAZMFbri3jBQvrJpKj8xMWCan9NEK1eDrayTEDmB1LXw0xu0tHyDdXtYolwINWoGwvyDmIfIowPsjnPH0tQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=io97uacbkaYZGs6WDbU+GDrDOzgxXu2V5YN4X3kRMx0=;
 b=r5MlMvUN7kRVwPnJBS2ctwXB7uh5c0yERq8PpX1OdEiQre0cUF8j9lLDWRjQVXf5knMnloQFhVatlSSFREi4EVKZ017J2/rlLxWqUKQJ9ysPBsmE5fjyZ936KOn3lf30O0JI9ksFg7gsFhkzOYRQUuiUfSEDrfrnjzLY2nE20SF5nMgU5nrUvO9IbfIYtEkd4OMF6oJ9lK4OzknUrDwVg2K7nRSTdO4PQyS2jKI8Ta+PQovgXZ6j66KLJbtMC70/BllslTgRO/dlptI7GyjD2LkZmZm95yK8b0ABokCn8JOBrvs745vQi1lLWcA2fkzznm/dAKB9eNp0W9EoyjIwag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=io97uacbkaYZGs6WDbU+GDrDOzgxXu2V5YN4X3kRMx0=;
 b=DrwAQ8pTDVD/tmmtv2N+ntoLXPZZt3CzUGh1p94ShsZ3GwOcV9qAomF9Fv6oozVD4O+6WVCk8qw0Uxn57kzAvkhr+sbLTv+mAhEbj1znUDRP+8fwwJWo1WDIYG2GjLYLGl6AcCpttKN0fOprmxLqYdTaZzQNSSiR++ZA1I3Lq1NxsNizHRg/jAtE+i4hN/Ewg4Sxn9GTjHbVCVS8NPdJ7C5pqZfRWcMS4E8AyFGsgE9Dj6PA8AXspOg0udrijvbWlKdHp23HRD62QED3w4n6HL/fzsedKH96PqIDZDBsw+PiHHSm7C4KPuolVDHVDliSUuIJlKEao73A+itinbxUvg==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYSPR04MB7880.apcprd04.prod.outlook.com (2603:1096:405:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 03:24:04 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 03:24:04 +0000
Message-ID:
 <SE3PR04MB8922B08C02A7641BC59FBAECF3242@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 13 Apr 2026 11:23:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V
 Svpbmt bits
To: fangyu.yu@linux.alibaba.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, tjeznach@rivosinc.com, jgg@ziepe.ca,
 kevin.tian@intel.com, baolu.lu@linux.intel.com, vasant.hegde@amd.com
Cc: guoren@kernel.org, iommu@lists.linux.dev, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260411022223.91029-1-fangyu.yu@linux.alibaba.com>
 <20260411022223.91029-3-fangyu.yu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260411022223.91029-3-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0035.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::17) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <46a2ab04-c145-4fbc-85e5-136f640af2c7@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYSPR04MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 95722364-885a-4de2-e666-08de990c1cf0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|51005399006|8060799015|15080799012|461199028|23021999003|19110799012|40105399003|440099028|3412199025|26121999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHcyWTZNakJZeHFnczVNbWJIUkEwTFB3bk9iLzlHQWJ6d0NuOTNiSG9xZEtV?=
 =?utf-8?B?T0JJRHBORlJjblVIRFlVTHV3YTMvL2VZS3d4b0NnT1IvcHVFV0dPK3FUZytI?=
 =?utf-8?B?QnlVNWtqZWx6ZFFQa1g0UnNxL0o4Zmo5MWJRbVlaeU1hNkhIeFppNE9hZGZ5?=
 =?utf-8?B?UDZCQkE3ZlRUODhEa0RDU0ZRQjJ1bURxMEdCUzFzRG5XNytCTDhMc2lFNFBP?=
 =?utf-8?B?aXBWYzRCN2dRTEwwWjlZUm1reWluSUx1Z0daY1hDSWJvQm5pVUZaam1YdUw5?=
 =?utf-8?B?V04yeUF0V1hocm56VGlLQkZkZnQyWDVNYkdJd0wvaGpoT3ZjMXZ3NllQNFFR?=
 =?utf-8?B?Z1dxTlNZcFUzSTZoekNNWS9ORVZMczMrWDZneGs3enVZNytrTFpoUDQ4OFh4?=
 =?utf-8?B?Njl0cjdOSDBUejlIWTJkdnA2LzhHT2JCNEdDQk5vaGo1MUtDWWRDL2h2bjRy?=
 =?utf-8?B?S2pJemt5cmU4SzlMTm02M3FYN0VRWlhBZWJiZC9KNXVnaTdzY0h0VzRwRUlr?=
 =?utf-8?B?a3k3QytaYnZDQUY0MnJETXlIRUVNWmR1b2VUaGp3RitBc2pyRjB0cUZzL3lo?=
 =?utf-8?B?Tk9RblJ4NXF4QysraEE5RVovNm03bTNPYUJXN3VhZGM3dTlObVhhYWthQVpO?=
 =?utf-8?B?T0wxV3lUTGdPYm12dTQxUElodUJBTmVQUjRvQklSeFkyWWd4enpYS2tBR3dW?=
 =?utf-8?B?dnVLZHA0Q2NuRHBHSllWVHp2clJtb3BuSGwzSU9pbGF0VWYyRERBZFArV2VX?=
 =?utf-8?B?cS84SDBSWU56aElBVE1FeHdYamJLZnV4c3RiUXExOVRHeTRkRWxHKzlaRkEw?=
 =?utf-8?B?bjFFNXlrMS9ub3d6Z1dGdVJrdDQ5ZkI1RU5aSU0zTGxldmY3d0EwWkM5SWNC?=
 =?utf-8?B?aDRjcjhJREozYThCRlo2aTR2bHdVN1NYZVhCVEtwdjNFdDExR0FwL21wblJn?=
 =?utf-8?B?cDJVMHJVd3M3ZDhRaVFJdjU5enZCUGMvZi9iWWRwa3hIdmtJRlBSdmtoNG5B?=
 =?utf-8?B?UUEzMzZEeTh2UERXVUdXRm9ocXc1TlQ0VmRPMWxWRjJBNnhCbFJ6Zk9PaEVh?=
 =?utf-8?B?aHJFNUEzUmM0Tk4rSkRNYnl0Zm0zNE5IbVZDSzZNZDJEWXFkQm5VSWRmTmdK?=
 =?utf-8?B?K3JEL1pnSFV5NEF3QUd2K3pJRmg4QlA4bFJ1L0hyQ2RsbGlDdjlJOVpJTXl1?=
 =?utf-8?B?cWtUTnpBSldCOG5KSnFUYURaTUN3RnpiNkMzbEZpa0N2aEFkYzFyUGcwWVE5?=
 =?utf-8?B?YnRlSEVOT09XR3YvUVk3TkhpL2s0ZS9QUlhvL1JsL3Q4c0w3UT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHJDbGU4RStpU1lwczZ3bjFhaldBNDNPcTlsUDhpc1hsYjQwUW9LMndmcm00?=
 =?utf-8?B?bFZFc1ZiY2ZRUWNpZ2V0Z0pCNnF1dTJDN1lRa09SbU9HdjNLNFFGUkVSaUw2?=
 =?utf-8?B?SGRVWnhzZE5WeWREUUMzYjJPU0ZwNUtSMTR5ZVdxMndub2VmQTkwNW5iZ2V3?=
 =?utf-8?B?bm1wbnVrK2MrZ25PYkVDYTB3V0dtNDhTQ1ZTdmhzR0psR0ZuNnhXMTV1TEpl?=
 =?utf-8?B?anJKbUtFR1RGc3V6SW9WU0h2cHR3VWJTRTMyVW9FWUppWnprcEJqQVJNa3Y3?=
 =?utf-8?B?cEd1REY3b0x3YUxjNDcxNHRrbXRLc2Vocm1HSnZxMStFSHpqcDlyNnA1eWkr?=
 =?utf-8?B?MTM0NEkzWllvTVltQm0wUi8vVmVyRklmcUtzbE5EWk9GMmdYWlIrTGxBd21O?=
 =?utf-8?B?THRDMkg4ZllCVE8yUWFzQkZQeW8rdDBRYVRYUUhMQjdOeWw0TXByRXpTbzRR?=
 =?utf-8?B?d2xYa1dFRXkxMTcyRFhrU3YvTTdVVFJCbWFUMGdaclFDZmpGNDA2WHdJU1hR?=
 =?utf-8?B?dU1IY2x1SFhML3h0NWo1NG8zSUQvUWJFZU1CSStzcWJvbUxsTkRJTUJFUW1q?=
 =?utf-8?B?QTA5VFNURERBVU1NSU1CbURoM3d4MWxsMlREbGFRL1V0ZzkvT01vWDFXL0Y5?=
 =?utf-8?B?RlIrKzdvOE1hdXpwcjJSYktuWldjdkl3NTV3OHBmZWRqeFZpa0RJRTlNTUJP?=
 =?utf-8?B?bWJkVXV0Wlpndk1QbjdOdlBuZkhZb1pUYVkwR1hYSno1RCtmVG9Jc1RTUldo?=
 =?utf-8?B?N1U0dVR1SHIvdmRsQXN2SmlvNzZxbEJzaGxYU1hKb1RIS1dEbHU4d0VLRlZy?=
 =?utf-8?B?U0J0U0VJZldNbU5DYS94enI3U1VCdE9vYmpMYlBOK2djdGZ0YU15eUsxdmVx?=
 =?utf-8?B?VG1OMWhZcjF5VS9kY1BWaVZtQnJza0F0MzFRckEra1VaYkwvUmpCUzdzNE1R?=
 =?utf-8?B?SWNGYkNwdlF0b0pyWjIxZkZCWWg3THlRdkk1dUhHOWxOK1hINHorQ0x6T1ph?=
 =?utf-8?B?YTVGK0h4TkNYMDBPK0hmRENCenhLcnhic3NWSUorTndCSFVHZTlXMVhWQmFt?=
 =?utf-8?B?MU1xR21MUFlmMjF1dnFKbUZ5aGozcEl4cUQ2blNpa2xZVklCbmlySUk4MlhU?=
 =?utf-8?B?bVFFZWJZNENkNVpxZ2RqWXFrM3JaNXJKTVVodDNnb3dMbXlrZk9EaWo0bDBZ?=
 =?utf-8?B?WVFkNDZWR3NsT1FnVy9rQkNsNTNNMTZpYjV5enArUTJVSFdRMlJITU9qeThL?=
 =?utf-8?B?U1MrU2JPc2ZROWVDVGFmbTJSYkN4V2VMUU5BNE9RanpZQUtXN1NSOXR4Qm9M?=
 =?utf-8?B?cU5NN1JJcGYrNEVmbklrUEMvQktpQ1Q5Q0dMdVZRQmxZT0Z0SHNqSEZxUmFo?=
 =?utf-8?B?SjBmQmZ2OVVrUGRTdjRieDBQQUhjM1ZWZlFOa1J2VlFPdlFzU0YxSW9BRElH?=
 =?utf-8?B?MUxaUGcvRWFPVEpNekllcGZmeUk1ZTF2TEY1TGFqc3VvRXE4aWQ3Nmg2SUlw?=
 =?utf-8?B?SWZFRHEveDBoZEI1VjF1blhOZlBabzRUdWN4eXY5TVFXaXdkSzlNMDlEZ3JJ?=
 =?utf-8?B?TEVpRE14dy9QY2xJbVhJaFRwYWsvYmtkdENjZ29kTFY3TUdzQzNxb0c4cVpZ?=
 =?utf-8?B?ZmlqcjdMUTRnOHRNZmxZeEVhcXlrekxPTXl2VkFkMWkwZSs2UW9jblpqaCtC?=
 =?utf-8?B?K1RnL2FQTkN4Q1NVV2NlY0ZHNmI1YnFENHRjVEFURFlaQlRYMkljdUNmbjBJ?=
 =?utf-8?B?b0l4VEhNb2hvRmxuUzNOOE1hS3RRaDdscWF2SlBJTkxmRmt1eUVJSkdLNE5v?=
 =?utf-8?B?TjhMSk9KcWF5NXFZMmNzQUt1L3M0MDlWMlBqbW5xalJHTU9BR3MvT0VUK0Zj?=
 =?utf-8?Q?n2pfNgIdbwoEQ?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 95722364-885a-4de2-e666-08de990c1cf0
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 03:24:04.1801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7880


On 4/11/2026 10:22 AM, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> When the RISC-V IOMMU page table format support Svpbmt, PBMT provides
> a way to tag mappings with page-based memory types. Encode memory type
> via PBMT in RISC-V IOMMU PTEs:
>
>    - IOMMU_MMIO   -> PBMT=IO
>    - !IOMMU_CACHE -> PBMT=NC
>    - otherwise    -> PBMT=Normal (PBMT=0)
>
> Clear the PBMT field before applying the selected encoding, and only
> touch PBMT when PT_FEAT_RISCV_SVPBMT is advertised.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>   drivers/iommu/generic_pt/fmt/riscv.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty

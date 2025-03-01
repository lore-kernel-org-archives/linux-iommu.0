Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022092.outbound.protection.outlook.com [52.101.43.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9CC146D53
	for <iommu@lists.linux.dev>; Sat,  1 Mar 2025 01:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740792602; cv=fail; b=OG5hHZ97nlSWoSlo+hW5zELjIcpY10VzuVeMKQeCLpc3FYsQ5y/Zw886AnlIhzVxjCIlWmROE2o9E9SerWa23T/6g86l92l92u1RSeDIApdbDeyJjUiUgL80g0jHOqBz1BQ8/hhI8eSHDWih240o3cYrU5Ceo/KZrGdQoPg2WdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740792602; c=relaxed/simple;
	bh=p+8Swf9rzoC+Yi2fKbb1H7PR16+WS1ibovAnG0hxvQM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PXXlOeftQzlbC4g5sVPG2ep/dtIwnDZhlrxgjEHcaGXK17drr/TLW2w08njJGnIeJflZ7iRkYhcYNjM4+NrVC/bPiCeu+XnjB2jrVYINOzl6rY6ih8SZX6kOtrart/kO84y1sDIH/xX5Meq+fS5haELXSsHkb0krXMjnZ8+SgWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=tq0ZBlBM; arc=fail smtp.client-ip=52.101.43.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="tq0ZBlBM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4dKsyYln+seYYGaNeVhI/QpssEkg9EDx3DftV/UKfAYu5SKnsTHohb14z7Op29sSA5ailEzktVp/jbTcp98CiuzUuyTf8i583psw3T5/St/Hbv72RgJE+yZwjTiGdSxlts8Z6x/MiCsX80PN9IaEVFnpym8IYV+jRWgrEk1fuRoGbWxqAlXDVgLgS5tyKOwyaxMneCMYoIFZjnLx8fuFffZqg0hMG0EG+Mg/od9erPsLAjmm6w6jyTuW28osi7Nao3Y6VGxTlINjuySa4LSoHrPmSWSz0VUR2agB4MXs7ad5FVHSkyoxhWjPyukE6GSt2vr/DMTfwEObBq6jRrcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS4pAcaYzav9R4nAbkvU/QewwKXDHOqUO+cUy+JL4cs=;
 b=TgF5CPoogxW4EtCY2dwxZWFOdLBPz1Z+eKo8AG4xpoRmGBcBVMbICCIP5wjVATfbN+9gAxOOtgpjJxBZegg+fghPL8ioXk4uy2XSMX5L9HRlk0aajSnOjtRUnU4+Upro9bscCdyYl6V+SXsepjhbkl1YZnfV6m/lJx6bdRvobk3dWFhVUO7ghdJxQYmi+0tv2BZTgCegm4AD/WWtFzk1CNlWkDNg9osF1PYI9y3MvITgKnoQdU2LuCoG2b8Ff+JmufSmqhUDRklsJNmm5b4UogcfUS80/yKjNs6fQSSFUPR0SPLx6iYuLB155tU1GA08Ul1A40dPXRNJHbBv3NshGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS4pAcaYzav9R4nAbkvU/QewwKXDHOqUO+cUy+JL4cs=;
 b=tq0ZBlBMiUL1ddoOD3blsQMWAdp3wryVPfcMmiXXt1X5y1R1QGHjdOfijGAcFhtzAgLikrMxlpKr0F8UIW6jDpWBvXHCsPNmrocrRLFZlKc/rVU9apq2aUxi25x81tdGBDloWIe3DdDxoHPyn4mivQD07ULo7NH+HmINKBLrdRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CO1PR01MB9059.prod.exchangelabs.com (2603:10b6:303:26e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.23; Sat, 1 Mar 2025 01:29:56 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8489.021; Sat, 1 Mar 2025
 01:29:56 +0000
Message-ID: <c572a93f-0899-4fc7-9764-d3e76e9fe6d1@os.amperecomputing.com>
Date: Fri, 28 Feb 2025 17:29:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm64: Add BBM Level 2 cpu feature
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 ryan.roberts@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
 mark.rutland@arm.com, joey.gouly@arm.com, oliver.upton@linux.dev,
 james.morse@arm.com, broonie@kernel.org, maz@kernel.org, david@redhat.com,
 akpm@linux-foundation.org, jgg@ziepe.ca, nicolinc@nvidia.com,
 mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-3-miko.lenczewski@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250228182403.6269-3-miko.lenczewski@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0086.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::27) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CO1PR01MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: b86fd72e-178b-4eba-54d0-08dd586092d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkJKbDVpd2hoQ2xoNTB1R05QcjBvaHpjcHdyU1Y2NHR1NHBsTmJBUEtKNEd5?=
 =?utf-8?B?d1pRZTNKMktjN0NWRnp2NWJZNmFEMVhQOWJrRUcyZzBHcmJsZVJldnZWU1Vw?=
 =?utf-8?B?NG9hMllLUlFHdmhhSnh1TFhnUFRnQW84cDRZZVNXTG41MVNONlpCaEFROGhx?=
 =?utf-8?B?eEhXdkF1YjdJZXhnOVBJZFNTWUhYU2R1MGhBU0FXL0NjOFB6aVB5bzROc2ts?=
 =?utf-8?B?cUhJSUZuWWw1MFB0SUNHVGE1RzhoZ0oyd3FnaXRrSkVOdm9DSjJqUk04c1kz?=
 =?utf-8?B?c3cwQ0FPejlBQUpWZWU1ZEtxckJNQzZ4Y0NqNDdtc3cyUDYwNENUb2cyTDA4?=
 =?utf-8?B?Rlp5YmlsUGthNXdJSitNeW1JajdRYkRBYXpudXpnTHlzeW1lT2xsRk5taEtT?=
 =?utf-8?B?UktHYjdNUFNkQlZsaTRsamFvZmg2VnNQbzJYbGhYd2tMbFI1cVlqazJhdFZS?=
 =?utf-8?B?WmRWQnc0em5TK2JyMzhJSjZjUDkyRzRGRit4aEJRbVc2M3VHSXlVOHN4MUhv?=
 =?utf-8?B?VUI5MGNhZ0xWekpMWTVrTVY3Sk15Q1FlUU10MDRmeWZWTzA3MWgxL2dQWTFs?=
 =?utf-8?B?NkFxbkh6cmpEMHQrTmtCZm1pUEJSYXVoWFFmcDl0ZUMzQTBReXZXdmdjMnJy?=
 =?utf-8?B?T05rQlRwL1FNekwzcFRiZUlrM0k1a3FHeVB4QkFkMEFTRXdHb1dQcGVNWXVo?=
 =?utf-8?B?RkRvVHFhZTE0TGI2b2dlN3JxdnlmSDJTV3c1YmEwSEFiZno5L3ZiWXQyQ0JT?=
 =?utf-8?B?ZzdNRU9ic0Y0SDdlb3RsYStkRVpCS240OU8xdlZGcWhjMDdtc2ZWdFVRTFB5?=
 =?utf-8?B?NzhObDNaYjkvY1EwMGtKQVVzeFpWMVBSN01wVk03ZHp4UWhTditZZ2djVER6?=
 =?utf-8?B?VEU4amxjb2V5eW9sSTVNQThZYncyeUg5TE9OWXViTU4rT3JhTk9sVGcwTUV4?=
 =?utf-8?B?a1lBeSt2UlV0UXczN3hOVjRGN3djUTNuR21ub3NDTzB1dkMvYXpDZUdEaXpk?=
 =?utf-8?B?V282SnlKeXpwNEhIUUxhUHR1eGtIZHNBYW0xTk9lMzN3TWtMZi9lenVyMFJP?=
 =?utf-8?B?aTdNclhOSG9XU01YVEl2U1Q4cWtWemVtdGtXWTZJK1g0a2ZsVjhWOThER3dk?=
 =?utf-8?B?aHpBcW1Lc28yaWxmUGpNdXcvc1dXcDJWZTE1dnQ2ZjFJZUYzakM0RkN3TFRB?=
 =?utf-8?B?bU1WdWd3VGlpY2lzaGF2RVFwSFFlcVkySEVlQ0JsZUt4anpUV3RxaW5ibDY3?=
 =?utf-8?B?a1d6WE82ZTdCZHJvVjBHWFh0UTJnUVJqazExTzYvZDFHaHNScFZ1ZzFJdXlX?=
 =?utf-8?B?QTdzMHdOYXFQam8wNmZHUEJ3SmQ5c0d0NTYybGJkWW5MdW9jUzhTT2tYSS9o?=
 =?utf-8?B?SnNoaEhTc2hEdUt0R2dWLzdvc1ViTTZSOVdBSVZIN1htY3J0c2srQnY3WnUv?=
 =?utf-8?B?UUpVcys1SGxiWEhrV2YwQ3NnNGZkZkExZlJjZjlZb0Z3TUFlRmxyQlIrNC94?=
 =?utf-8?B?TUoza0p0dVlzUmw3bG9SL2EweFR4cGZ5UlEvRzcyU2c1VWRXYnAwU1ZmR2Zs?=
 =?utf-8?B?cnBtZ3FUWDhkUUQ5ZEtDNXFrSFVTd2pTZGdHWXdhMTVVUXM5VTBqYkVVdmNF?=
 =?utf-8?B?ZFFxcDRIYWkwTUZZRjJvU0gxbDBEajc0M0VVNlR6Ti8xS3FCUzVMblJSN1R1?=
 =?utf-8?B?aitCWE1TWHNaaW5tcFR4TEtZTjdIbkMzYU5YU3p1YzVrUU00N3dZRFlicGY5?=
 =?utf-8?B?dndJblVUek9ZNUNUSm9GcFNXbnJxTGhBQlB6RDI2ZXJZUnpJOFBuZ0RRdlBv?=
 =?utf-8?B?eEVmMG9FamZQck13OGRtY0pNOVZsNTNTdWY5TGdDU2tQMEJJTnNrOGx6Q1VQ?=
 =?utf-8?B?ZnRMV2ZuZzh6cDRzQ0Y5dm1XZzBZNElBOVlqdG1QTlNYdlR6MDU4UjVxKzdW?=
 =?utf-8?Q?iRQEYAq64Rg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QldKYnlSTU1wK3ZSRzlGYXdVN1JZOUQ4djRKRnpZaUFqQUZydVdsQXk5WDdz?=
 =?utf-8?B?dGI1UEF3VkRmRTJTTDVweTZpYUJBSUlyRm9hOFE1NDNQeHJEVktucG5wZjNj?=
 =?utf-8?B?eXpvbGZXUnQzODJPcnZhekIyZjJydmhUanl3RTJKRjg1UW1rN1lxQ0VXSkhm?=
 =?utf-8?B?akVlVlVvQ1ljRUNoTEh0K1hwbVhld1ozcHJBQnU3cGpZK2dmNEpmRU9VdUVB?=
 =?utf-8?B?MWxBeWlWK29qN0VTc2RBdGJHd0RlMHlrUWVLSTd0WlZsTjlVZXoxK2Y2TzlH?=
 =?utf-8?B?QjZCN1ZFcU1QVXBLeFVpTHI5alFnQWFIRDFsWUZUeDFTdVMvRDZwaEpUWDFs?=
 =?utf-8?B?TzUxdjdMVE9zcW85dkpBQWFJSHhFekRGQjErOUFNbnJMbWdUS2VEUlRCR3hS?=
 =?utf-8?B?ZUJtSGVkZmdEckt6ZTZoK0VQUzFXY0w5aW1rYitQYk5Kak1La3JMY1pHZGFv?=
 =?utf-8?B?eFR6d1dlNzd3ZjJBOHVzcktMUW9VZXh0QUJZYVlpeTNRNWFKckRtaDg5WndC?=
 =?utf-8?B?dHU0MWZKTmpzN3BsWXYwcXdpNlV1cDdKSm5QV2x1ekU5YlNFU3FsUU5lc2Z3?=
 =?utf-8?B?TVY5ZnlkaDNpMEFpNVlMMmlYWjlZM24zSUMrVHlibzFsZGhnZ1RPVWNaTERx?=
 =?utf-8?B?ZjJCSkNqODFFMTNla1JjRGpVNUpWM3NPZER0NXA0K0NOQkxOV0NRM2dFTllP?=
 =?utf-8?B?ZklmUHRFQkhXUE9OeElNdE1EYml1U09JbFBVdEd6VW9POUhWMEFKM2NpNTY3?=
 =?utf-8?B?TDNEN0lLdlBhRjJQd2VlVFVtZGVPUnJFVk5FS280M0x4S0xWWWxTU0xrNG5M?=
 =?utf-8?B?YUFwNlZwMk1xMXBJanFtR0lWNGJRSkszVGhGc1NiWkJma2tPc0JUS3JaSENz?=
 =?utf-8?B?aDcwQkVRbUlnQUVMaW5MbDVQVjd1WTd3UUExcTJIa0tpSGlrREJuQ2pIVGJo?=
 =?utf-8?B?WjVMMzFGQmd5NkJYdFE3dERraDNyUFhITGM3RmlWbkxXWEpzMm5HOGkxRVR4?=
 =?utf-8?B?SkM1YUF2QjU1bGU3V3NFMk41MHB3bzRtUHAwdFh4dndZNTlHNTUrSFQwSkcz?=
 =?utf-8?B?Q2pGUEg0aWM4YUltNlE3aktuamNWZDdMR3MwN2h2N0VRVlM5UUh2cnNYL21n?=
 =?utf-8?B?THVMZ1k3cDlsMksrVmdqVjVkcndnSkphYjgvZlNGU2ZIcHpYcHN6RXpvbDQy?=
 =?utf-8?B?aXVGNTZPRm4xUFZ5cXhUNkFXNVora1NkVWh5WTZkNDlJRzRBWCszU1NhVUVv?=
 =?utf-8?B?RFhqUmp0emN3enkxUGh3N0IvMlFkQ0NYMVRUNW9ZWUc4TFMvaGJBNnVYcm5t?=
 =?utf-8?B?dENiRDhwZkM1OE5MblNlamZuNnBSaDNHYkdWY3hEbWQ3M0htWE5mMnI3eWpk?=
 =?utf-8?B?U0Y3YXZFdndkU2NZVFNNSy90YU0rK3k5Zk5uY01WdlZlc1NEdk14cm1CU0x0?=
 =?utf-8?B?YnJ4WnFTeU1uVEphYmZ6N1hZSUhYQ2ZkcTlKRUhoZWdPSmlSL3NSU0RvV3Fz?=
 =?utf-8?B?SDFlR1dJKzRxcWdyMmhuQ1pKQUpYYkRUL0lrQmpreHVNN0pTMTZaT0crc3lX?=
 =?utf-8?B?Z29lRDF1ajVkb090eTA3UVVQNVFJZ0I5RjVoMVY0MFdna2JEWGgxNlBEaHZw?=
 =?utf-8?B?RjkzeWN5eXdDeURjb3lOTGFUYWUyQmVzdmdpQmlqM0M4NFlpc0NDWVpiZEhr?=
 =?utf-8?B?OTFIWnhxanl4bjQvZ2dtK3RQaTJ5eUE1azlBRHJ2YVFaYUIrcmhTcjUvZ1Fa?=
 =?utf-8?B?a1FJYVBWY3BwSytHWmVwRGdrbUJaTWN0UjBHMkp0R0hLTGt0dEx2aCsxejVh?=
 =?utf-8?B?Kzc2RHFsa0FaNGJublppU2o5RFpjOUVrOXBPNE5GQTl1eTlnemM4RkR5TVVN?=
 =?utf-8?B?cG14d2ErejRBVXdob25FV3lxRFNJQjFTc2d0OFF4bk03WkZFaWcwemxjODIy?=
 =?utf-8?B?U2cwSjhkZTFFUTFlc21VV2VpVDhjK0pqa2RwdFFOSjY3T2dzek9SWTdYV2lB?=
 =?utf-8?B?TjM5aE1DRzh6K0lRYURlZzgvRk5ROXY3bEsvT1p6RjZURjA5emdSNzVBZzdo?=
 =?utf-8?B?ZDBVbmw5b20wUHAzaDYwUmZYYy9BdWlPd2RzaHFsQ1pVZlBZU2ROYjdZWTRF?=
 =?utf-8?B?WHpYazJCa1lDZnRjSTlIYXoyelVvQnZLV2dSUjNQYkRVRnZONk8wdFlWVk5G?=
 =?utf-8?Q?pWGat3QYouoDXTXdDUL/Css=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86fd72e-178b-4eba-54d0-08dd586092d5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 01:29:56.1881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dj6wEqM4NsOKoCKNKpmidyIeHSRXDDD9/9YAVV6JrRKQt7AeokbcSeSVf5yzn0SaruZlWdbCqHNDl4auXHIPGU2pnpqbIvnbF9XKaw4zc6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB9059




On 2/28/25 10:24 AM, Mikołaj Lenczewski wrote:
> The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
> and this commit adds a dedicated BBML2 cpufeature to test against
> support for.
>
> This is a system feature as we might have a big.LITTLE architecture
> where some cores support BBML2 and some don't, but we want all cores to
> be available and BBM to default to level 0 (as opposed to having cores
> without BBML2 not coming online).
>
> To support BBML2 in as wide a range of contexts as we can, we want not
> only the architectural guarantees that BBML2 makes, but additionally
> want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
> us having to prove that no recursive faults can be induced in any path
> that uses BBML2, allowing its use for arbitrary kernel mappings.
> Support detection of such CPUs.
>
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> ---
>   arch/arm64/Kconfig                  | 11 +++++
>   arch/arm64/include/asm/cpucaps.h    |  2 +
>   arch/arm64/include/asm/cpufeature.h |  5 +++
>   arch/arm64/kernel/cpufeature.c      | 69 +++++++++++++++++++++++++++++
>   arch/arm64/tools/cpucaps            |  1 +
>   5 files changed, 88 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 940343beb3d4..baae6d458996 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2057,6 +2057,17 @@ config ARM64_TLB_RANGE
>   	  The feature introduces new assembly instructions, and they were
>   	  support when binutils >= 2.30.
>   
> +config ARM64_ENABLE_BBML2_NOABORT
> +	bool "Enable support for Break-Before-Make Level 2 detection and usage"
> +	default y
> +	help
> +	  FEAT_BBM provides detection of support levels for break-before-make
> +	  sequences. If BBM level 2 is supported, some TLB maintenance requirements
> +	  can be relaxed to improve performance. We additonally require the
> +	  property that the implementation cannot ever raise TLB Conflict Aborts.
> +	  Selecting N causes the kernel to fallback to BBM level 0 behaviour
> +	  even if the system supports BBM level 2.
> +
>   endmenu # "ARMv8.4 architectural features"
>   
>   menu "ARMv8.5 architectural features"
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index 0b5ca6e0eb09..2d6db33d4e45 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -23,6 +23,8 @@ cpucap_is_possible(const unsigned int cap)
>   		return IS_ENABLED(CONFIG_ARM64_PAN);
>   	case ARM64_HAS_EPAN:
>   		return IS_ENABLED(CONFIG_ARM64_EPAN);
> +	case ARM64_HAS_BBML2_NOABORT:
> +		return IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT);
>   	case ARM64_SVE:
>   		return IS_ENABLED(CONFIG_ARM64_SVE);
>   	case ARM64_SME:
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index e0e4478f5fb5..108ef3fbbc00 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -866,6 +866,11 @@ static __always_inline bool system_supports_mpam_hcr(void)
>   	return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
>   }
>   
> +static inline bool system_supports_bbml2_noabort(void)
> +{
> +	return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
> +}

Hi Miko,

I added AmpereOne mdir on top of this patch. I can see BBML2 feature is 
detected via dmesg. But system_supports_bbml2_noabort() returns false. 
The warning in the below debug patch is triggered:

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index faa9094d97dd..a70829ae2bd0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3814,6 +3814,9 @@ void __init setup_system_features(void)
  {
         setup_system_capabilities();

+       if (!system_supports_bbml2_noabort())
+               WARN_ON_ONCE(1);
+
         kpti_install_ng_mappings();

         sve_setup();

I thought it may be too early. But it seems other system features work 
well, for example, MPAM. I didn't figure out why. It is weird.

Thanks,
Yang


> +
>   int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>   bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
>   
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index d561cf3b8ac7..63f6d356dc77 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2176,6 +2176,68 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>   	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>   }
>   
> +static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
> +{
> +	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
> +	 * as possible. This list is therefore an allow-list of known-good
> +	 * implementations that both support bbml2 and additionally, fulfill the
> +	 * extra constraint of never generating TLB conflict aborts when using
> +	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
> +	 * kernel contexts difficult to prove safe against recursive aborts).
> +	 *
> +	 * Note that implementations can only be considered "known-good" if their
> +	 * implementors attest to the fact that the implementation never raises
> +	 * TLBI conflict aborts for bbml2 mapping granularity changes.
> +	 */
> +	static const struct midr_range supports_bbml2_noabort_list[] = {
> +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> +		{}
> +	};
> +
> +	return is_midr_in_range_list(cpu_midr, supports_bbml2_noabort_list);
> +}
> +
> +static inline unsigned int __cpu_read_midr(int cpu)
> +{
> +	WARN_ON_ONCE(!cpu_online(cpu));
> +
> +	return per_cpu(cpu_data, cpu).reg_midr;
> +}
> +
> +static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int scope)
> +{
> +	if (!IS_ENABLED(CONFIG_ARM64_ENABLE_BBML2_NOABORT))
> +		return false;
> +
> +	if (scope & SCOPE_SYSTEM) {
> +		int cpu;
> +
> +		/* We are a boot CPU, and must verify that all enumerated boot
> +		 * CPUs have MIDR values within our allowlist. Otherwise, we do
> +		 * not allow the BBML2 feature to avoid potential faults when
> +		 * the insufficient CPUs access memory regions using BBML2
> +		 * semantics.
> +		 */
> +		for_each_online_cpu(cpu) {
> +			if (!cpu_has_bbml2_noabort(__cpu_read_midr(cpu)))
> +				return false;
> +		}
> +
> +		return true;
> +	} else if (scope & SCOPE_LOCAL_CPU) {
> +		/* We are a hot-plugged CPU, so only need to check our MIDR.
> +		 * If we have the correct MIDR, but the kernel booted on an
> +		 * insufficient CPU, we will not use BBML2 (this is safe). If
> +		 * we have an incorrect MIDR, but the kernel booted on a
> +		 * sufficient CPU, we will not bring up this CPU.
> +		 */
> +		return cpu_has_bbml2_noabort(read_cpuid_id());
> +	}
> +
> +	return false;
> +}
> +
>   #ifdef CONFIG_ARM64_PAN
>   static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
>   {
> @@ -2926,6 +2988,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>   		.matches = has_cpuid_feature,
>   		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
>   	},
> +	{
> +		.desc = "BBM Level 2 without conflict abort",
> +		.capability = ARM64_HAS_BBML2_NOABORT,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.matches = has_bbml2_noabort,
> +		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, BBM, 2)
> +	},
>   	{
>   		.desc = "52-bit Virtual Addressing for KVM (LPA2)",
>   		.capability = ARM64_HAS_LPA2,
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 1e65f2fb45bd..b03a375e5507 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -14,6 +14,7 @@ HAS_ADDRESS_AUTH_ARCH_QARMA5
>   HAS_ADDRESS_AUTH_IMP_DEF
>   HAS_AMU_EXTN
>   HAS_ARMv8_4_TTL
> +HAS_BBML2_NOABORT
>   HAS_CACHE_DIC
>   HAS_CACHE_IDC
>   HAS_CNP


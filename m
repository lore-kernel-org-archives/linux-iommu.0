Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012028.outbound.protection.outlook.com [40.93.195.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2DC308F39
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517586; cv=fail; b=ot9jcHYZ0poiWlqSOq0vVBU2TOBEqCPh94YxjoNG++9eVUlRZs69nrEsfneAzDlNrvEI7q8HDx88fWgrtWSNd2Y9fVQtdf6w8aw+qwNnfaoZtkd7kF8rUgYgy+1qUWJHGz2RdpFcCMWQKDt6rRKFKti/teH8px/gqm7/seaXtJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517586; c=relaxed/simple;
	bh=7vLlXW7e6lPDIn5Rd1B1nWgIRu6Jg0/PTMRlrA0zmjU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NEIqwZ6vID87UiJo04D94/8pXb/UmvvbpwYvOE0jQB93Qa6A6BJALgMrlSCiAAPYl6sRH3WoFpMunrvUyZq2lpIz/986zkZSs8xs4os2dbgFKcePZDKaVzTvjAfFq07WaDnGIUQ3Ejm9oq6hKrZAhdz6Hx7d1ctvHspwxWcftZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lxsrh3M9; arc=fail smtp.client-ip=40.93.195.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lxsrh3M9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzA5RyPUDghOkwtFQHJjXwXLJdWV49ZRRPXknkvzuXzFdvAck6GsZp52n/s7WupgzJU3ohW1FPjgVFmPXWWpl3c5GB6zHbaM/t4VmeArPPRRRVdMt9IdHvM+OgIidcO/uCgsij57BXBB2xQhmgSR+0lE6OAOUWFjRY+65a/kQVjgVcUxx8BKqyIukchdgxMxOyOpuZuCdXzPYNCRoEPpjUeCP1+ftxyqYIrg1xX3Xm0B45sRy555r17ZX1Xm5j7SeSDnYGgYt84EhrnBd/+cqGptC31aacKIsvNiNY7XDftORZCmrYV+O02wVrB+M0f6/es908hc3SbXjhASWLW6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxuAQqbCSWuu1VHxcFIgJNj7hbw9VKcsXlGXI0iEPmA=;
 b=ov6LNn6Vh3Ys6tAyoy5R9lUaLbuIO0HvyBT6M8JSvFEhRVTFZpc5i02DBbrEoKyT9KY6S9xdvAo/FXO1jZInimojoc1GgKVmgF54LPHHHPlYPDphucZ2duzRxF6kqa5fgtpMcC5QOrFSuFiTvj5vUN7VbcKzov4pAQ0rPV+tDTpayKwzaUgvgsUSmi8hll/boxwI4EqtO6OitCjMwgkc6Ooe3yR8xsgF7fKP4Awdn5Azsk6TAq5OVg3b5qCpkxsrqbSaqdikmzZbYJ7yYxIDZTMI+t4p9gS/ODKvBklw0LZBNjCXzi9Eh9O1PvXmUR6PzT8VR6AGMgP+UN2VsnbmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxuAQqbCSWuu1VHxcFIgJNj7hbw9VKcsXlGXI0iEPmA=;
 b=lxsrh3M976o/vaQW45rqkitXELj7a0b7yAmoTLNow+hGl7+C4NOgp8rW6FexwicAv7R+RaPTsniAeazuZpFtzgB5OUDURlk9QS0t8o6y3ysknYhqZqRtbHFQGoJDnU9ika6ktoiUDaIbMkZa/dRrTAL6oDmcXRSitev5qf7BR1/WNeuO20qwRVlrHJZnumXWNpM99Rwl/8ntUBStZ+ProITFJs/lD6n4HKqQHDbvJGbXIUtwFbLieLRLoViRwyzeYyTuamvDWw6JtLLgoudY2TOAo4eY2zVlujc7ZaMOqYzkcHzGoptl8WOhyk7E34OWAk4wucsZcj2lYSOD/WqwWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) by
 MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Wed, 8 Jul 2026 13:32:48 +0000
Received: from DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06]) by DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06%3]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 13:32:48 +0000
Message-ID: <86b1d2e4-e45c-43b3-a0f7-0aaa744d6f36@nvidia.com>
Date: Wed, 8 Jul 2026 14:32:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: tegra: Fix CMDQV interrupt type on Tegra264
To: Ashish Mhetre <amhetre@nvidia.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, thierry.reding@kernel.org, nicolinc@nvidia.com
Cc: iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260622065410.2780215-1-amhetre@nvidia.com>
 <20260622065410.2780215-2-amhetre@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260622065410.2780215-2-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::13) To DM4PR12MB6063.namprd12.prod.outlook.com
 (2603:10b6:8:b1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6063:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e0b55a-29ce-43cf-37e3-08dedcf565fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|23010399003|376014|4143699003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ykWhAFbH4dxbHVncVr+pIdremr+6McZ2t9wdQVD27tIIjLhOVUjW2GU9cHGIbE0jvQlR23pKbrgmfpdL6u+5U82KGEGIe03Rep6k4h7t4fODWj2+l2jBe4nsuWWpW4n7twDsZxfIVVATTaBTP8qag7c7O4+m9CkiVxTAg4iaDT7M6l9pxOyshQSW5XoUGVky2hRPwxRjVS7jnGFn3Gr1p7AQEq7NMtWB7skGLlspLnWDVgX/pT8VPPAZv738nty/74a16wmJmUz+gQrgDlrBiFmXiEkV1uuaMp639EqBm3GgxRWAUmZr6hQ5TeV3N+fVJ4PBn/aMrkw85oOt5Nq/o7IM4wfH3mHDgyXpVAShQtxqr8W9bWod+Ppa9VhYmPnj5eKWY+mR14oafcwkB6c9j75x25q6f1+g+Rvjh7Ain3ZADhdjyP7gkbmegWmYGMJnOoCd9QmJp7UYW8qx2cs4zkke91gxZyVTtjqKSCJuHlXGvmxhoy02gJqd2czIXHU8SeiUNn4qfmkV+oTqsj+fFZXsU1Q6poZCFb8DXED7Pmv+UyQGLGAmr0sysTh/GXJRkZmUPGORBSXQbC3ru3ykj4oEnTZd0n1RTJ1cMGK8hQy/8Med2oxFjzIUoZNskLRkj9nsfpFYC80puIahxVuDvDW+iZXlhQaA0ccnbz2HfoE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(23010399003)(376014)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWNtZGdBdGNjQzV2OHc4T2lIQ2RPYmVWODBTUUJLQ2dCSVJ2QWZrNWppRjAx?=
 =?utf-8?B?U1VyUjdQYjJlVDB5OFczNm9QL041dmJ2TXJvaHA3ZTk4dURwd01VOW9kRXR4?=
 =?utf-8?B?SDVJQkRObDRMUEw4c0xCLy9HSWJjVkdCYzJnVmZsb3E3bWU0TjN4U1lZeVJX?=
 =?utf-8?B?dDEzZUkwUm9jZnhJdnloUHZQcXBGd09yT0ttSG1tOUN5VzJjSHFoaE9sT1hV?=
 =?utf-8?B?dXZ0QUZDQTREVFJYS2FXOW5LT0tad0RqSHR3eWxmQmk4S25YT2ZnZ1NpZjNh?=
 =?utf-8?B?OFIwMkw2cDhYVFpZdDZFQkttYkRFWDFsVmZlYXBhc0RjN0cxUTJnUHAyK0cw?=
 =?utf-8?B?YmJ3Y1Q2MnZ3RVhuWDlvNjNqU3dkM256Slk1T0MyMEkyN1MxQmNtelN5SUQy?=
 =?utf-8?B?Vmh0WmRTVWJ3Ky95dm95N29jRVlyajhqOW9WaW9nTXhYcnlnOXM2b29BRFdy?=
 =?utf-8?B?NVp0ZXAvVXN3b2xRZDBkVm5YSXh1WDZOMEdFUmh6T0RGanNLbkpSZ0Y0Q0NJ?=
 =?utf-8?B?U0RwN0NLZHBya2xXdnhVY08zT2IwZGVqUjFLNXhzRnlhU2xpcTc0dzJSbFZ0?=
 =?utf-8?B?OHlURGp2QUVvK2Y0Z3BmdUVwekxVZ0V5eDBWQVhMQnIwb0pWdWFUdjI3eENK?=
 =?utf-8?B?Rk0yNjZobnRvOGlWMlAvM083K1ZlcjhnNTlxV0c2M0lMdmxzT3c4WUswVjVO?=
 =?utf-8?B?TVJvWWZRbklvMmNuU1R3VFBaMkdydXlLNmxiOVc2QWp4WnB1a2RJZCs5d0p1?=
 =?utf-8?B?Z0M0ZUVRelRMK3g4RGQvWmxkVDJQNUx6T0pDa3h2S25Ea1NSN0RIRzYvYW1M?=
 =?utf-8?B?djNZZElqQmhmcWVKUS9JM21aZXN1R2tzZDhuWnVCbW5BY21MQzJXaUVvQ2o4?=
 =?utf-8?B?YWdOL3llWVczcjZUWjFOKzY3SWR1c2ZTOWRJMW5WRWJ4cTVxcURRUTZlQzg0?=
 =?utf-8?B?VWxWek1pT0NNNmRQUSt4S0dSUDdsNElFajVVMENVVDJvOFB3NE9KbnVtNFNZ?=
 =?utf-8?B?aUh2OXdkTGplaUhRVVQyMkR2VFoxMmJlaU5oeWVFcnFVK09IaGxzOEtaUG0x?=
 =?utf-8?B?MkljN0RjV09oZks2RHRrSjBpV1l6eGZNMkN1dlhHM1RBKzV1MkpCblBkRmUy?=
 =?utf-8?B?OWpxVzFtSk4rZWZyeWZxL2M0QTVnMDF3NDVBT0tRWVpjWXRBRWEzRGhHQ0Zi?=
 =?utf-8?B?c0R3Zy9GYkJZbjQvanUrbmRwWVowSUo0dmorQ2dBSlJSTWJUT0xYZUVVa2VW?=
 =?utf-8?B?c3ZKRmg2ZXVjRlJobzEwYkpsTTJJTUJudlpXMDdqcVR6Z0RnTEdZTGtHNUhT?=
 =?utf-8?B?Ti9Zd1FSanhKdEdTa3l5eElQcTE1L2ZvUGZVODVWWHFidmN5UDdYZ2NHdjdU?=
 =?utf-8?B?bndCZmF1REFROWFaZUdaZDdLemFIQmhBSGNxdWYrY01aSVFMZGRsVVpiQjdF?=
 =?utf-8?B?REM3aGZ1a21aK1BDTjJKMEpySVk3a1h2NENqanZTRmd1bkUwUlNMVjdhTHQ5?=
 =?utf-8?B?bk8wZ1JmQmtBdjR2WlpDWXhRZTlRQ2hDY2JMQWZnb2YxVHRIem50SE52ZGdM?=
 =?utf-8?B?SWJKaExBNzRJYjhydHFVWGx6aWQ2YTRiNmY2a25yQnlKWVNFRWNWRUpRaHVr?=
 =?utf-8?B?QVd2TUhyV091RzhxdzFpQVM5bVpMQkN2NTNjOGVVTktMR0FjTFdIL2gxWDNE?=
 =?utf-8?B?WWVLcTlXZENXNjhBYU1xMzJva0hZY1hYK2kvNk45ODFJdTNDM21nSnIvUkcr?=
 =?utf-8?B?ZlQzamQ5QnptcWQ5dDhQUlluSXd5eW5uaktQNTUvcHJQZldSbnU1NTlrOFB3?=
 =?utf-8?B?Y2RDVmtHVUtqZmpiZVJjQk1oQyt2ZG4zMThDZWJyZEk5dEZqOWNnZWRDWnN0?=
 =?utf-8?B?OWNjMEErNXZ0emJIQ0IxNElhVzZ3WkpVWHdna1R0eC9sV05oN0hqcERsQllu?=
 =?utf-8?B?bkFXTng5M0xSVTlIb2JaRjZCbXZ3U05YNEZUT3lIdnUxOEdudWJETlBLeGNz?=
 =?utf-8?B?dFU0NlZVT1ZjYmJFZVF1QjgxbU1zSEhYdnRVeHlWZTdkb1BDSytPRGRTZEJB?=
 =?utf-8?B?UkhOQW5BODFVUEprZTZFZWhJSHZSVmxnMURjZDJpZjNKWE9lR21tYzBXdTdP?=
 =?utf-8?B?OWRFREJwSkJnaGpmcWo0R1hRQVJVSzB2aTc2ZEhUYnpGRU4reHA0QXBrc2NK?=
 =?utf-8?B?cUk3SmpWOVVoUWJUaGdxb3c4VUpabjVKRXlnRVc4WFVKSExadk9MRXJaN1BO?=
 =?utf-8?B?OFMwQnp5UE9mTk5oaEx4ZitIQnJTdjBONUJsZGdBY1lyeVErSFBiZjFPN05H?=
 =?utf-8?B?bHg2Rmd5YlVrRzVvYkxNUGcweldRQmF1VitKMVZDM0N5S3pqQjZzQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e0b55a-29ce-43cf-37e3-08dedcf565fa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 13:32:47.7901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +boX9kYL+6yLQ/VWxY22XMlIi+zEWe9ZNKKHeTpTDldb1c7UbRzVvVhRN3dDA2Zme82NQHkHNy+sVPmyVzFXQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835


On 22/06/2026 07:54, Ashish Mhetre wrote:
> The CMDQV interrupts on Tegra264 are described as level-triggered, but
> per the hardware interrupt documentation these interrupts are actually
> edge-triggered.
> 
> Correct the interrupt type for all CMDQV nodes from IRQ_TYPE_LEVEL_HIGH
> to IRQ_TYPE_EDGE_RISING.
> 
> Fixes: fe57d0ac4835 ("arm64: tegra: Add nodes for CMDQV")
> Reported-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra264.dtsi | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> index 2d8e7e37830f..ff9c0476e924 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> @@ -3393,7 +3393,7 @@ smmu1: iommu@5000000 {
>   		cmdqv1: cmdqv@5200000 {
>   			compatible = "nvidia,tegra264-cmdqv";
>   			reg = <0x00 0x5200000 0x0 0x830000>;
> -			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>;
>   			status = "disabled";
>   		};
>   
> @@ -3413,7 +3413,7 @@ smmu2: iommu@6000000 {
>   		cmdqv2: cmdqv@6200000 {
>   			compatible = "nvidia,tegra264-cmdqv";
>   			reg = <0x00 0x6200000 0x0 0x830000>;
> -			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
>   			status = "disabled";
>   		};
>   
> @@ -3486,7 +3486,7 @@ smmu0: iommu@a000000 {
>   		cmdqv0: cmdqv@a200000 {
>   			compatible = "nvidia,tegra264-cmdqv";
>   			reg = <0x00 0xa200000 0x0 0x830000>;
> -			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 28 IRQ_TYPE_EDGE_RISING>;
>   			status = "disabled";
>   		};
>   
> @@ -3506,7 +3506,7 @@ smmu4: iommu@b000000 {
>   		cmdqv4: cmdqv@b200000 {
>   			compatible = "nvidia,tegra264-cmdqv";
>   			reg = <0x00 0xb200000 0x0 0x830000>;
> -			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>;
>   			status = "disabled";
>   		};
>   
> @@ -3831,7 +3831,7 @@ smmu3: iommu@6000000 {
>   		cmdqv3: cmdqv@6200000 {
>   			compatible = "nvidia,tegra264-cmdqv";
>   			reg = <0x00 0x6200000 0x0 0x830000>;
> -			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 232 IRQ_TYPE_EDGE_RISING>;
>   			status = "disabled";
>   		};
>   

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


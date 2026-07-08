Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F937AA65
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517571; cv=fail; b=IbsUllrCdNYnSb61PimECkz15+tFFQ510Riu2npCZXNchFv5KlUuZQO9cQI23LNhj42wUPyUGkMXXlM3vPDeSdi7+YWeCezT/40hZsQSDn9FcXrsgULpVnk4Cw05Wqie1FuC8d2Q5vwsm0glEjcaJ3hHWBpEjZNjsJwLrcPwgZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517571; c=relaxed/simple;
	bh=h7lLCNjrj3lxB0Q9B4SjKug9xabfhwb6+8rXCrnsxzA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lWdHLsAqTL78l6Wg0sbrvgDdzVoGyuAY/OMS+pUfCvNHw49pDTQUoa6Hm5A93jS4sC1LHlJqJxBmxfFUKoWmwlTgdwTszxDmPe/8jBWSmsBHZGNdaHo7ma0w4vdniB/3QIA30t/2dUe+mQtgXvM8D7CXdkki3zEGt8LZulZ7BAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uTm8typY; arc=fail smtp.client-ip=40.107.208.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uTm8typY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkDETx70ycFZzfUyBurk3Dq5LhXmlfgyYQsIiKMNMpogKCH0AAe5OT3MCC6LHiMBNXv3Tqoaz0tOZL1anFWLH7oA3fGkinDB5wtViYC1cYypEZuTgh4BmF0AaTw2kgCjBBZjLpFHafUTKmK73X4ZiffqvfkM3KTw9gNefvRJwO3r44/eqDHIDOp8wARlmAjB78h5/ChfD2uOPEPsLGDLjnvXhJhftTUK01LIuOzBH8lYAFGhRLSa7RqdPT6VTU8FcARSen+Mi8c/p+bZPRgLhSxKHFWEucFRZ2JofdcQdnJeSdqWI0jnBn1cx3iek03Yb0h2LA1FwitTAIQk0IwStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaYr4QgGH9o/v6aTmBOK2JSf5ok5trNW4dGvb6jE0mo=;
 b=jV/g6WK2lPWv9LhTOK7yhXmpwzHy5RV14aSKkAK39QplGqrkRHtsNFKYUg9h01nrizkH78zvUAlCwZ60IccyLNQOMd0TuasfGjCdnzViH1EDT9eBYiPYCo8sic1tlLYdBO9isjDU5qAojeEajGbBY7WZ/dz4uqeTse0nRpY15HQ/PF+0n23UH0E/M3eeTzAx/BGqZk2YvF3Ra9mhRCcinyKSZZ9zBnDKumOKLjrtKo63m+V6T5zT9zPA0ZtyTYNx57aEt44jFXjzOl+a9++Bfg3IKOCVyEA1wbL/BXPg7eIKxJDT8KBcnHiz9k6gu7siqMaSjhSEjTBqB6SiBKwEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaYr4QgGH9o/v6aTmBOK2JSf5ok5trNW4dGvb6jE0mo=;
 b=uTm8typYglmWIB7E3poQLI3qUKnk/Qtqc5O+ThX7788vgG+11q0G79mzsK2fQiged+Bf8TsM0ejoQzUEnN5imZ6g5LA+FP9KozIiKtnW1xp44VYzg2oGc5wATXa3W3AIlZGlzi8yKmIVe3Uqzwkis85OxZPzzpRnsjBSrw6VA8/WjFxGtnvNgwfpJSlKylf1ymYAxasq9Qerx1UEDveolGYOLbFRFhSFqCPkDjGmEqbfkUJvCafEic6SvHxqcRseW7lOcZU08rvbmszxgVottqKVjAueDjNZjnF84yi5o/ALbejBZVr6iR5Joe1F/CS7j3k6AEwJcH+/uK0Y1Q/xVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) by
 MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Wed, 8 Jul 2026 13:32:42 +0000
Received: from DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06]) by DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06%3]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 13:32:42 +0000
Message-ID: <1cfec0e4-f1d0-4661-af48-4e2563bc8564@nvidia.com>
Date: Wed, 8 Jul 2026 14:32:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iommu: Fix interrupt type in example
To: Ashish Mhetre <amhetre@nvidia.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, thierry.reding@kernel.org, nicolinc@nvidia.com
Cc: iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260622065410.2780215-1-amhetre@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260622065410.2780215-1-amhetre@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: c17a2827-306b-432f-76e8-08dedcf5624c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|23010399003|376014|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1cjcp6hekn59ZH/WIPwV6oXk0S0CQERpzuOVUvTtJoNyrKzYtxA65n91UZaTqTMfNkTc/m9FZNLcsjmwnMrIxZLmc5yFguEqTyuN7y1IQoSRppHJ9OBCuARFVOxWeznOkNL/lzGv6bg6815LiQxJEwl2oX6lcJa5RII9acp2pKFIV4WrbNUk/5orue6e0N+b9o8HvC8tIebGNkgtKpy07afgoz6NBIzxYshzOPxS/cU72zoxEGKwW9AUYVdhZvImuLkj/poLKq7vP+BR/mnE10l/f/EWP0Rz53sG7tXdXY3OAqZNuYcNAjM9MOBYTwtx5DU65vTVy34tKw3Mwl/YqZX3SQUkeqxUYxAKauxTdMvLpKbxjn1HAPG27S4rteSLfA2WRYXvhGjCnEh7p8rhJaguUED7F893llZUVgIhlqek0EZpoxehrRIUi3o+PlZhXT9zqh6aLEoGAXSaTFzuuXkvXFdujJfX2nFLi36PmZyuEx4D+Wz0wpZnR1vN0XPWEYuULR2T+3NGsqvLEPjuCihoYBx8Bo42K/flMirkl9iHIXAoXchYnJ8rijgGKVmDDkHq6nNC/aNnGlkWwaCbQ422DTF8cOXEDhOXoeHJJ/pyn3Siot4vhrpkK7YXqmTAeDaVAgzZ8Unnqvu5Njyd4VwqplRETayT1zjepFs5HXc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXVGS2VnNS9MejBmNWJCSmVKVkVqRm5jMXI5NUNVZllBT05pQ0pCbVNZdjhm?=
 =?utf-8?B?TVVJViswdml4ZzY1ZlBCc2RycHN5SFF4VEY2WnY4TFk1b2dBWU9GTWdoakl1?=
 =?utf-8?B?NG9RTzVmUi9wY2Nkd1hReFBTWndITUFzTzJSSUt5eHNwems5Si9xYnJCUjNH?=
 =?utf-8?B?dTVLVjNFaFhMOS9nMVNSMHZPNjkzVnlVN2ZjZ2dTeDNFdjYvT0VraTE2NTdt?=
 =?utf-8?B?elBZdENrYllVRThrL0NrWlRKUS9tcnZPVFNGa3V3cFprVmhxSUtLQlZQb3Rm?=
 =?utf-8?B?UUkvNkJaUURyb1RLWTg4a1kzaFpCTTFVL0d0amIzaTNFMVk4MTBpa0RCWDlH?=
 =?utf-8?B?QkxYQ0dMWlF6QXVhZGQ0cnJ4V3VZSW9vbUNDclpQUFRRRGVLMm9UTVg1MllC?=
 =?utf-8?B?eHk5NFpGb1J3d2RBRmZRODJHV2x1Z3FUYnBYb0M2VnpTSkR3WGVOQ0NkNGs1?=
 =?utf-8?B?alQ0Q3pza1puQncvZXAvL3BLditRZXkrRDFzUzlFQmpCUVcyWXJHQ1NJY0Ux?=
 =?utf-8?B?ZkErQTc5YWtMM0RYSWpGWTVjbTY0VWhqbFBvS3JGeitocXI0cHVBbkk3cDlW?=
 =?utf-8?B?Z20yYUdoTjMrSS8rY0JZQ1hLZTVqMWN2NnVRUldRb0JGN09NU25zR2lwVlNX?=
 =?utf-8?B?ZTJoNEw3cHYvRUNtc0xrdGNYV09KWG5kdm14Z09aa2FybE52c0JWeFIzMGxJ?=
 =?utf-8?B?aUJWamdaUzlNZk85UXVaOWtqaVBWYm12bkdUTWJjN3dmR2JjcUZxOE11NThi?=
 =?utf-8?B?NFg5MmtQVVRPYUdYYjhoZzcxdVRuZ2ptZWgrVGRVZW95OEoxQVNYekVwa3dM?=
 =?utf-8?B?UlRLa1R1OS9SWmRjR3prQWZkNm9iZnVoa3Vlc2I1cEpOY1hEdkg2UjFCU1lI?=
 =?utf-8?B?bEJ4WU0yT0piWk93d3ZWVTZMZTI5c1QyUCtudGt6aFViQ3Vlbmk3Y1VZOUZJ?=
 =?utf-8?B?akRvN0FUZlpaUE9uRWhZeVh5NGZ3SThWSU5Lc0pxL0dLV0JHNkxYOTUzTDV3?=
 =?utf-8?B?UDd6QUZNWVFybVlSTnlzajJERWpWbm9hOHJ3Ynk1a25raWdzSFlDcVNnWTI1?=
 =?utf-8?B?ZWI3MzJ3Y0lEQTlrdVFxeFoyaEM2VitNVjh3NGlFNFpyTmc5QnVCT1dheDZT?=
 =?utf-8?B?NmFoQXRMRlpxc0dWNEpSeEp0R1U2dys0bjREejNHUTFBNExjU3lCL3FYWGgv?=
 =?utf-8?B?OWtjMW5LbFJ2U1ltTmhuSm9VSy96SG5zQXBoUnVEVk5pbFFxN0FhZ2tOa1Qz?=
 =?utf-8?B?bE4vYVhtdFBsMGMxOTFPcWVnRGtZM0d4RjBoL3VHY1NZL285NnE4T1A4Z0Fl?=
 =?utf-8?B?bllXL1dpY0h2bWlvNERka1VMY1IwcmF3VEYzbWx5RnZRR1NBclNUQUdscVVT?=
 =?utf-8?B?RFRqUG1McUc0anQvb0xOeHM4WitZU0tBTVRnME1VdlRvNGw1d1N3UTVZQnRM?=
 =?utf-8?B?TVliaTZ6aHdlZ3hVZ1ZlWnJrR2lqRGJmeU1pYyswVTl0RGxlNmVLOFllcDJJ?=
 =?utf-8?B?eWxCREdkcE1OcVdpRDRkSjVEVGhVYy9mcUY4VlFwczJLT1VTR0N6a1BaZlVs?=
 =?utf-8?B?bHZNYkI4Y0tIbi9BYlUvT1QxOUovNTJjYWwxRnBsdW9PNVhNTWtrR29Db3h2?=
 =?utf-8?B?NFJ3TEhyaWRRQVk1UE9tQlFSY2ZrNTdXT1R5cUNZUklHV1U5TVp1bmFBVzZl?=
 =?utf-8?B?c0xRd0crNVl2RXNBZ2ovazhkMjQ4V2h5NVZSbjFXSDVxNlhqaDZwNURRd3cv?=
 =?utf-8?B?Ulo2R0tRWmZRMzJURXZ2NGpEcWpOTUdFN050T0dVTEFJUXgxV1huMUtWZU0x?=
 =?utf-8?B?bUMrM29kTVFrb21BZnZhY0poOEdIR0hOaFFxdzJ2UnFMZGlWZGl3bE15T29F?=
 =?utf-8?B?cGx3MURXTmJob3laMWVCRVd1QmhhcHU5SWc5K3dRSk1rOTJTSktyVG9JNkhm?=
 =?utf-8?B?aEZSalUxRStBenNwUGI5U1E0RnBGZ0s1cng3WnN6YXRXNWFlZHJnekp4MXIr?=
 =?utf-8?B?dm12OXBhMlhSbkdJTittbFArTFFUZjJFNkpZK05qellIMURvTVpxV1NBeVdT?=
 =?utf-8?B?TTJMTDdVNzh5UG5BY09WYk5wbUJSNTVwZlhMUFN3SktQbUN4ZG5IcVllR3N4?=
 =?utf-8?B?M1RQT1pub1BOM2ZtWEd6MFREUndidzhjN2V4SzVRWWJQMGlBZkR5b2h2NC9o?=
 =?utf-8?B?dWl5Z29mbnhBb0dBbkFPMlk4aE9sSjgrNGNaZ1BXamM0Wm9MT3h3QWk0UjNu?=
 =?utf-8?B?MzNodHVFMk4wUzFHMnd3SHYreTdLeVc4OE5ORzZJWFliandzRktRNVI5Yk14?=
 =?utf-8?B?elMzM1B1WlYrNVFNT1MzTUNtbDRZNmYxNFR1WEdjZzFmTmdnS1duZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17a2827-306b-432f-76e8-08dedcf5624c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 13:32:41.6823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMWBGZJhqTDCDV283J6Z73W/AAGvN7HSzFy5l0ibWK6gtsAcFZJOeBpQah1Ha2CSw8Yb+Y5LN4KlbqyUtGzCEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835


On 22/06/2026 07:54, Ashish Mhetre wrote:
> The CMDQV interrupt on Tegra264 is edge-triggered per the hardware
> interrupt documentation, but the binding example describes it as
> level-triggered. Correct the example to use IRQ_TYPE_EDGE_RISING so
> that it does not propagate the wrong trigger type.
> 
> Fixes: 8a59954192eb ("dt-bindings: iommu: Add NVIDIA Tegra CMDQV support")
> Reported-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   .../devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml        | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
> index 3f5006a59805..76ef34fe5c72 100644
> --- a/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
> +++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
> @@ -38,5 +38,5 @@ examples:
>       cmdqv@5200000 {
>               compatible = "nvidia,tegra264-cmdqv";
>               reg = <0x5200000 0x830000>;
> -            interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupts = <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>;
>       };

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F613DD504
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891671; cv=fail; b=hOLrxMrx+iAWLTy/q7d0NhHqvxjUUXEilTw42glOJ9mpQpSCkvmbcw3vZQYI1dYWedOIikPbNROAzYkBuOmta64570USFtzWJNIsnwItQEXJLPIW0BpTeoE0oDzp76jKjRLdhCd/sGsEM+XrXRvYQvO626PwlEK8DVWNdEnZ52E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891671; c=relaxed/simple;
	bh=X43CwnjYlensyfMiXrll+26gJpgN0xnwalN+IigAjwo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H6id/14ktTp5SgLI6h8sxZQcKDXPzCJcITm876LsAt/hpVeX8F4lU1KC79i26BgRnl0HWYMhdvBRG5PB8HLhJjou00Xc0n5hByiRTJ98xlsFeuIDtgBMItprg1WFgfx2tIbTgZkM9XOdgzK1pGAOyPhcYegV3cSYwCQkwbbnbzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IgesspdI; arc=fail smtp.client-ip=52.101.85.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IgesspdI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srwON4HXkHy9T3qrsBNEEyjfEz7zX4FomJfowp7+DSPZCQVrcBSnptCFIRvWmONgE1kQPTJAxM2URMvDPt/CTG9nTLLFNWseRbnduFEa8LPhbYhnOrSG3m5kiBPEVxsOp2wmoVyojhOU7uKxUjuz9AgvZZfx8n0jR7SxbLoK3bjKjZyqGrFyoDerbQhRFidTDnpzPR1AHBq6QtJynLv4/vRaoJyg+cUy5bWRXDG6zKCtv+j+wVYVQtHh2umu27coa5jUcnbjOpequo7Mk247n95GS2mGkZOUl2zvWuTDKztoqatiBiFN3AcAOIB5uNRaSWkF45w3RM+aJ4TWVhF/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fu6wemuyXEko1gFYCfzmUeAArdlG6Ngh72Mn0Ty6eWg=;
 b=c/+cSX/RgSixLO5AocFQug8SNjcN4LYy2L/5DjUwo8EdY/1QByB7LQGXf5BhQLj7T1malWoFC48QlfMxkIl2Mgiqp97JzuGXB09OFnny2OJmuyfHQn3vFowtL/ynz3VGP1GMTsXTMylFTqBp4zs03CGMNp2RJ0y4DymT6M5PL6LPcSO7JoZg0NddOh3oP36hB8sLljk4y/ComK/SgRrfu4beHzWziq2BC8gjPnK7HCpGxba7oE1wvR59W1V2W3YR1CbKeF2YFT0H3rRcJcn0RIqftib2mEEru+hTyjACIDTl60efG8w1AkRAHPTknI/pnn4bV6XAnrenHrYFIJr2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fu6wemuyXEko1gFYCfzmUeAArdlG6Ngh72Mn0Ty6eWg=;
 b=IgesspdIEs1lQCZoy7FwxVcrb3JJlq9UC9scNsvBZbp3sQphLH8C8AC8DjTyBxIjLZpLS4yGZ+OIGhTlx6qKhs9li3UOVsYVddi3f8Q9p0ywsQINIWlnwUsCkhDh5j53c9X6qD8ddhEFpdpoJg9ONwlz60AxeqVVmH4PJHQpaWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 17:27:46 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%7]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 17:27:46 +0000
Message-ID: <e46b35e6-7051-432b-b9a4-e44c61f500ec@amd.com>
Date: Mon, 30 Mar 2026 22:57:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommupt/amdv1: mark amdv1pt_install_leaf_entry as
 __always_inline
To: Sherry Yang <sherry.yang@oracle.com>, jgg@nvidia.com,
 joerg.roedel@amd.com, kevin.tian@intel.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
References: <20260326161719.1329502-1-sherry.yang@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260326161719.1329502-1-sherry.yang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0115.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::10) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1893e6-1166-4cf0-8c6e-08de8e81a824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TkifO49aJa15yMSmbbwf+vOzlk6e5o8h/kyhIxZd/HU50uGmPjkaixqTS9waZkm8h7iOE8wGnh79N882jC2iyeOylDIifXrmY6T351c8KSZFC0UdG9HBmRLiQ5gT5r/GNFo+1v88ZkoH2/WmuU31wUyqw94fb7mLlretXzadcrCNijSNxxZn5JpcckwvfUJObY+JG66cuhqjb0sOseQitE8khhwpKvrq66tdVpCqJNBqyjKyy1s8JnFsagrUKZjYxCA5RdCMpvDo/heacos2CQHs/24mQTjHskLyPA01iFxicuM7MfcflCoVpPNkpVH26EhWJhIWi7xU7X6VkiqqOJcU8+0v/+F1RBDM68p1F8qcQVyU7sWCYp72YmejcMovToLqVz0nMHdqj6BChSr2f7SKA9k8XbOcefW7AWcem5QczdiCJlrZHMZMpiJONt3cTd5Lx5pxHFE4uFQ+Bewa/RpRxCUZ3gnR4k0fm3Z5l6LEwNeYr8oyX1lf+phqJh5+dkmv8zOhfCJyebNrzECH0O59BVChH59zGdExMqvuKYsLDHluUpfB8qspzfVFI/jVbEotaPWofw1dIqjNZ8dlQVlOGRkdRXfpp44tZwb5L6pZMUZ60owhRvqC4MpkesyoY5bC9MNfU+himpq29gVC7XZkivolgovLiGMBt4dcNCzAqLQ1Z86FQe47gNzKfrD0qU92Yqm835xF3XU/+FuBV61MkO0b9u/6nDTfW9gM3dc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUFyY1BXZVBkQ2FlcEQzbHgwd1MyUkpuTVVHcDh0eWpjQWE0bmNUMmhzT01u?=
 =?utf-8?B?TGtQREJsTzh6SERJVnhDaXJFNHdYOCtiWm9xRmh4a1AvQnF2MjAvUTdzNWxt?=
 =?utf-8?B?Z3lWRTdrQ2ZlVTFYbzkrS1JtcW94elZyOXhCRFpIMXg5bGh6eUhKMFNnOWxw?=
 =?utf-8?B?WnRUSWI5NklJQmxCTkhqNEVhRmJFM0F5Tk8zWTRRNG9iQkkvbnBjN05QOHpu?=
 =?utf-8?B?ZDZDRmV5bXNwcUZzZmo0TUo2aEdMWXlLc2Y2eFFLK3NaQmhsb3ZHSkxhWGZM?=
 =?utf-8?B?NHB5MnNQSmd5V2VqZXFuSlF5YTVuSTBHeWloVEZURHYyVE5kT2RNaTJNZ1oy?=
 =?utf-8?B?cm1sUTIwREJoVkthdlJLcUhBVlFmOFlQMnltbnpGeEg1VkZNeldnTzgwaVM3?=
 =?utf-8?B?bUZHc3B6Z0FJS0hXL3hUOXFkZmF4c0RXY2FGenp0NkNhRC8vTHI4VWEvWkUy?=
 =?utf-8?B?VG9ZNG4vMGVyT1VJNHB2MGs1ZUJFTldOTXFvVlJ0MjRqTktvSGZaeXJvTkVk?=
 =?utf-8?B?REVNSEs2Zkp2UE12NHk2V2h6b1cxbXBKMGhFTi9yWE5Mcmp0ZXB1UTdIeWs2?=
 =?utf-8?B?Zm5YeXJCbmNEcXpuYkpqSW1zM1hDaVRvclFPWmRhWVVqbXZnOXcwYys2VmN0?=
 =?utf-8?B?dlBBejV3eXdpZGdDbi9CSGYwaVNpcjdieTZxWHdBUTRabWF6L0VPeldaUGRB?=
 =?utf-8?B?eFM5MEZlQ0Vsdngrci9TRmM1NkNPMCtyQmZxRVNsRGZhanMwUlY0eVcwZzln?=
 =?utf-8?B?Y3dZZ1BzVXFlcWJSMXR5QzRBQjNxNmlzaUdnNnB5VDZnbjVKUlJ3ZlM0LzBo?=
 =?utf-8?B?TGw3czhzaGtrTnBHaUg3bzV3d08xK3U0NDBLTG9NVlg0MUVUMWpaQ2h4VXFL?=
 =?utf-8?B?a0R3M2pxallwelJlb2FZeExhQ0dGUEhEWVhabFBzZnJoVlBJSW5IS2FWWitq?=
 =?utf-8?B?a1B5Ujh4K2lBQnRBaFhiSW9qTHljREhPTnZvUkVYTWVIOXBCTkoyTFhaNW9E?=
 =?utf-8?B?THhGbEF3WkZRVXlRN3dHSXVhd0FXMjVOVkZGQ2JPQ2hYeE5IS1ZCZldOTnhl?=
 =?utf-8?B?UHVza3BIMFkzejRHdG5XdnNCeUZqYUpBWVZqcGtUcXFIT3NCY0czZ0Mxb05W?=
 =?utf-8?B?bG9qc3pNejdocTR4T3UzdURNUUxoMXRnSlVYd0w5anUyUWtiZkFXcGdaNzZn?=
 =?utf-8?B?Q1VKTXlaMkZ6VFJVWnF6QW5EY3BHNUtRV242WFQxQ2VOUzF1UGNTMkN6dGJk?=
 =?utf-8?B?Y1pLYWx2eFVTMzJOMmR6L1Y0MVpUcElYaUhkVWRpN3MyRzB3YkVhSll5SVo2?=
 =?utf-8?B?OTZwL2F2bHJ5Z1VuV0RLTWZIb3llTU8wK1A1cE5sV2lFdmliYWU1UDUxZHM1?=
 =?utf-8?B?ZEIzRFVIb0wwSDJtVHc0ZHFSWVZqdVQ5UEwwZmhuSy9xWXU3clF6WVpyN25F?=
 =?utf-8?B?OVJCWG83cVpKcnFXTHoyYTZqekFtcGhtVTBxU2V0OHhBa0U2dUJaMzIvOW1F?=
 =?utf-8?B?cU05TnA2M3Q4WjlIem8rSUVEY1AvdWRyaGIrZ3VxcXN1QVUwcSsxU3hQWi9l?=
 =?utf-8?B?MGc4dUVoSjY3RnJFUWRUd3ZIUmlmK09vTXVnY2RiUW9sZ25McjdGa2QrcjYx?=
 =?utf-8?B?Y29CU1FQbGNxZ0pOeDBwUzVldWJwWS9KRTVtSElpaTJzRWVGeEh4KzRYcVdu?=
 =?utf-8?B?S0JMdUZlWElCWkNENkthQVRLWWEwaytLNS9XcUJmdWFTU3NZTk9DUDBPQ3A0?=
 =?utf-8?B?Y2s3MTIyN0Q1b3ZSd25Ebk1yMkZ6TllZSFRZNWN1aW1EcGFaV3NFb3hDYUI2?=
 =?utf-8?B?bm9reXU5NDhQVjhFVlU0TnNyNGN3bEt2Q2ZEc3dkY2oxQ2J1Mm1ZRE1vUkY2?=
 =?utf-8?B?OVBWRUdaVElxSTRWaGZWUUJKR1ZaVjJQM1FVcEZFK3FhTm5rNVVaOTVqTFRK?=
 =?utf-8?B?eEZGWGpvSHhSdXoycFBIbVJjZ1k1N1JLSDFDRGlXdmRkaEVnN0tMejVvemFS?=
 =?utf-8?B?ZC8zcnREbG0wTXpQQlY2Z1JoQVZRVEN5T3puZldmVUFQbGtWU1I5MHQzNlk0?=
 =?utf-8?B?RUZYY0tWMUlUbEFvdmtrRGFXM1pmVGErYkF5elh0N0RjRGNEbXNxbzcyK1Ey?=
 =?utf-8?B?d3h4eW1GaTFjdUplNGtBaDdvSnRxbCtCbW1EbnloSnVsaktVUm1lRW41SmZH?=
 =?utf-8?B?Z2hLQktMckc5eG1MT1YzRWFPeEZPckl2MDB6WE5NZVIwNXR4U3ZEYmdOY0lS?=
 =?utf-8?B?ekVSb2ZSNGY3ZVNYbERjOFJPUmFucmxoa2Z5Z3dRaDRnY2NVVXlxaWI2b05S?=
 =?utf-8?B?NDBCVjk4a2prQ0dSeURwcGxTRkQ2V3VsSjJvMFdHZmdHTDhjdlZPQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1893e6-1166-4cf0-8c6e-08de8e81a824
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 17:27:46.1631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLREr4YEo4kd17viPYd6H/k4p/Dw0XuQJG4qdXm/nLDE4lwHfVukGipQbGvAh7p1+ohh1Hm/URmxMupg41Q4oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110



On 3/26/2026 9:47 PM, Sherry Yang wrote:
> After enabling CONFIG_GCOV_KERNEL and CONFIG_GCOV_PROFILE_ALL, following
> build failure is observed under GCC 14.2.1:
> 
> In function 'amdv1pt_install_leaf_entry',
>     inlined from '__do_map_single_page' at drivers/iommu/generic_pt/fmt/../iommu_pt.h:650:3,
>     inlined from '__map_single_page0' at drivers/iommu/generic_pt/fmt/../iommu_pt.h:661:1,
>     inlined from 'pt_descend' at drivers/iommu/generic_pt/fmt/../pt_iter.h:391:9,
>     inlined from '__do_map_single_page' at drivers/iommu/generic_pt/fmt/../iommu_pt.h:657:10,
>     inlined from '__map_single_page1.constprop' at drivers/iommu/generic_pt/fmt/../iommu_pt.h:661:1:
> ././include/linux/compiler_types.h:706:45: error: call to '__compiletime_assert_71' declared with attribute error: FIELD_PREP: value too large for the field
>   706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |
> 
> ......
> 
> drivers/iommu/generic_pt/fmt/amdv1.h:220:26: note: in expansion of macro 'FIELD_PREP'
>   220 |                          FIELD_PREP(AMDV1PT_FMT_OA,
>       |                          ^~~~~~~~~~
> 
> In the path '__do_map_single_page()', level 0 always invokes
> 'pt_install_leaf_entry(&pts, map->oa, PAGE_SHIFT, …)'. At runtime that
> lands in the 'if (oasz_lg2 == isz_lg2)' arm of 'amdv1pt_install_leaf_entry()';
> the contiguous-only 'else' block is unreachable for 4 KiB pages.
> 
> With CONFIG_GCOV_KERNEL + CONFIG_GCOV_PROFILE_ALL, the extra
> instrumentation changes GCC's inlining so that the "dead" 'else' branch
> still gets instantiated. The compiler constant-folds the contiguous OA
> expression, runs the 'FIELD_PREP()' compile-time check, and produces:
> 
>     FIELD_PREP: value too large for the field
> 
> gcov-enabled builds therefore fail even though the code path never executes.
> 
> Fix this by marking amdv1pt_install_leaf_entry as __always_inline.
> 
> Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Sherry Yang <sherry.yang@oracle.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


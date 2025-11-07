Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012071.outbound.protection.outlook.com [40.107.200.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D002D5950
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762545547; cv=fail; b=gmreFlx+4b0L8i5r3yOhwIw4ymzYZNpWDpDUXztlA2qhwM15X9LDniwT5Tre5P+0OXpd3jFZ9HoOmfydf7pRVsYcZNpDIrcaHaQfDit0Z3Dkl8XiIqIpb3cHUv8shRyhew/RK0wH3o/svqnU59kiEh7cTZqAZTNkqax3wVrksGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762545547; c=relaxed/simple;
	bh=2CqO8pd1l6IdquB+4zZ5oPexjB3CvX8F7ZvEciHEojA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mbZBt2adKxvoTigJcrq/ok2TEok7UBEFJpYJjBSWI151eFBftUwUvWwxhRc928yaQhyfgPRzEYr7EWRaEiUqUVcwwhOwfJYlPsQvOdM7/Pw4qViqvtmEbbzvgj+nv6qQxdO43DWR/wMlVNIdJY9aJyK9IY/4m2XXgwl7tPzmpKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h5b/ZPhb; arc=fail smtp.client-ip=40.107.200.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h5b/ZPhb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sr+XhPHAOevTstQxN3XuHsGzq0/mz5lSAqfS/Ehzu/uz/9+jFWFXMhpJ7B6HItWctK7LWhm8BagWWjGUO8TICvRU55ZjyQOeBBo36G8Tsl9MV/zLMxyHqHAPA22sadAzKh8vMyhng4xaDo+OpUbwR1zEYSl7Zj4TdQusIk/GUyJ0enN9Lteldb+ctMuncNK3B6diHiZMD6IqV+aAPNP4mffrOHfbHaKsav2mo67BnkVJ7oPf1aRdO4yV7W76J5pS61iBuKidU3i3ONutfwk5TrVOVo/IoieITPIae3qX3/JxQXUgJoPSMd4XixlsnNN0OmbYk7zSBqZ2ETPVTqKxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXX+oMSziFAgHlf3P6g//sdZhDqx1jgaqCPcVPNnRhI=;
 b=X93lkSMsd0MT6FmWSvca9w2o3FlqZTM6S7LRhMc3s0JCEXnCX7fKcusDBvs08gqBcLMkzqk26LAXs8gRpcQFT6iVObYlGZ4ZVtaT9TaMhWkD59Jz7i4gzoScvraU45spnvJwbHbPzAtQJljKRPG+vciYLcxe1bK6bDGkoxgSMwEvFdnjzPqVQ3HqJKmochZb0gYWmGtFFTZmDfm5H5HND0aupp87IgEU0klYWwOMPj6HY4AG64E38209/PERNW64HkCm+2XSZ1gZcXidcnCReg6F9C9/rKwe8Xv6BgyR/67uM7mGjekxnU1sZBZDQFGwkT3WGYIVlj3UCEUDPUCrgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXX+oMSziFAgHlf3P6g//sdZhDqx1jgaqCPcVPNnRhI=;
 b=h5b/ZPhbCFwvw4axo+xjAq1fVtHyb2m/W6VUCTB490/WYRbLhjtIo1Y8kkj/7Ei7UT+Tctr79636QhN6P4hrqCVdKWkJ0YqkP0wDSX2F35W1TTVIh9V+GGycz9ZtIfUbpgA1saRmusAGxxS+uTMmc89XKZxH9cEDxp8Jd+eoRtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6)
 by SA1PR12MB8844.namprd12.prod.outlook.com (2603:10b6:806:378::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 19:59:02 +0000
Received: from BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a]) by BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a%4]) with mapi id 15.20.9275.013; Fri, 7 Nov 2025
 19:59:02 +0000
Message-ID: <a63411aa-6590-4bae-a7f7-01be8ba27eea@amd.com>
Date: Fri, 7 Nov 2025 13:59:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Wei Wang <wei.w.wang@hotmail.com>, "alex@shazbot.org" <alex@shazbot.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Alexey Kardashevskiy <aik@amd.com>
References: <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393DFDCB2788CB823DAEC64DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107010349.GD1708009@nvidia.com>
 <SI2PR01MB43930E5D802B02D3FCD5ED9ADCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107141632.GL1732817@nvidia.com>
 <SI2PR01MB4393E04163E5AC9FD45D56EFDCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107155704.GM1732817@nvidia.com>
 <SI2PR01MB4393E3BBA776A1B9FC6400D4DCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107163614.GN1732817@nvidia.com>
 <087b3567-5c74-4472-827d-e5a47761a994@amd.com>
 <20251107183209.GP1732817@nvidia.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20251107183209.GP1732817@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0108.namprd11.prod.outlook.com
 (2603:10b6:806:d1::23) To BL1PR12MB5062.namprd12.prod.outlook.com
 (2603:10b6:208:313::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:EE_|SA1PR12MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbe95dd-36d9-49fb-953f-08de1e3818ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjZORHdVRUVIeFZNREVNZ2xNbXBoclViTHE1cUFMbVE0bU00R1Z0Y29PZCtz?=
 =?utf-8?B?ZGtNRDk0Wkh2VHVOZHR0WVltWUluS1FkY0J0bG5qYVFmWVVkTkx4OFR2Q1kw?=
 =?utf-8?B?Q2V4THowUis4NXZWa1M0K0hOTk5wK2tzOE9aUS90NUdBU0dqZTdtU3lYMzRw?=
 =?utf-8?B?M2NKV1JXejljTnpEN0hPUnVIOUNTdE54MGZESFZwei9CR3NkWG9MVnpQUkRn?=
 =?utf-8?B?djhaUGtWRlVoQ1dSWmJ3Zmw2VjBXelp2eG1QYWpXbFZaNWZiRkN5MTcxaFUw?=
 =?utf-8?B?YkRvNW5ZU0ZPdWlTNjhBWi9DM2F5TnpVVzd5eDFRSFpKZ00vdjFmbHhDOXBw?=
 =?utf-8?B?SXRpUDhxdmZaNkVFY3NFSUZSc29KeHhzM3ZycUUvM0NPREpEUWJ3czhhOWw4?=
 =?utf-8?B?UTFHZmJBREkvem4xQjV5WFFJZ0Q1NjFrN3hGc0lNcHkvQU9IeEgzNmJRUkps?=
 =?utf-8?B?NzNIdjdCcHVhbFQ5c2lPYjVQSmthZDB6elVmL3pEMk5FaTBxTkNQOVh5cFdJ?=
 =?utf-8?B?SXRzR0l6Y2Q3V0x3MWFKVHVCdWRBV01ITDlURHlmOG95M3hMOHVlZll0L0F6?=
 =?utf-8?B?dzZtd3pUcmQvQWwwZXBWMXR4cGt3OXppdWV5eEM4R1ZDWldNWTZYUWtub2pH?=
 =?utf-8?B?dFEyL3lRUUNRSVBGUlhoWERtM3VRTUlTNGpCSkxoY3pjaFl4RkgzSzN4TjFj?=
 =?utf-8?B?MXBTZllWQVFWUGpoZ1NVYXlBYWx4Znh4ZUlhUDZJTFhxeDU0aSthZEFEdDB1?=
 =?utf-8?B?ZitOQmRBUUdNenpNZkZIOUNqdWd3ZytVWFQweUhrek9JbFZqVzM2WjEwTzZ4?=
 =?utf-8?B?NXBlSmRQbHpDRFhxUFAyanBkS3U2RGgzMG1mQnNhYWtOTHhjWjhMZkdxUS9O?=
 =?utf-8?B?ZG5PT2FJSmRRMVRXTGVaYVd6ZTJsaklpZDE5QjhvbkFQWi9ndVZnMlFYZFZn?=
 =?utf-8?B?ZDllNlZNYXE0UlQvVndTREV1bTYrMmVid0ZHaktQclF6RUUwZy9KenIxTGRY?=
 =?utf-8?B?WXpWTENrOHJGeTBHRmc2czBNUkowVHlZeHhJNXFTZmdIai94V2tKY1JYNmps?=
 =?utf-8?B?dEMrRWVUV290eUtBOVZIL0FyeExhMDRUaGZJcUg4RTN1djRwN1hGSTBOV0dF?=
 =?utf-8?B?TFNXTGpaN2FqcC8rb2U1Q0s0emQrTDVZYXZaNGVMVkdIVnQwQWM0WElDMjVv?=
 =?utf-8?B?Ry80ZGZoRmY5NU82UTNlUXJUOFA5WHRWTWRCdmJNaS9zMThZYm13cENadGFs?=
 =?utf-8?B?YkhIakIxUCtvTEExRjRZTjJFcTdLNmhJN3B3eWl3TXdRWVlsSWpHOCs2VXVj?=
 =?utf-8?B?ZnhvdFlDTUMrT0U4R0hiRE9RRVFTMzhOeGUvQUU0cXlCaW5UWGV3QmhlMmJo?=
 =?utf-8?B?YkpLbksza2dmakxWakpVVWVINW5aaVkzY25lMklweTVWUHora0krTzlOa213?=
 =?utf-8?B?dEVjdVlOaml0ZnFYRHZSZ2dPVlFLcm5DVzIvWGpVbURYTmtFeTdGa2ZiY1BN?=
 =?utf-8?B?N2FveFpRdFNJQ1JDdDNjK3U0c2lNNFhvdGdsbVU0VXVNSXIwTnNjbTZ6aVlk?=
 =?utf-8?B?NEtxT0RyeXBQd3NzWEdQY3UrZm1YQWt5VFVGellKNVFQM1hyT29sODhxdkg0?=
 =?utf-8?B?V25RbkkvRFlycmFHTDUwSld4dFF3NlVyem1vRnRESXhVRGhyeDl0MzJ0QUZV?=
 =?utf-8?B?TDFqUjZ3ZXFsZWg0cDdzR0FSekd0Q0tXOVcyL3dYby9jOG9hZ01Wc202dTRn?=
 =?utf-8?B?dXdObTh5MEZYMjd6QVlPdTBRRFlpZ0pUNG5ib2tTajRlcjhBeVk1ZnBWOUlO?=
 =?utf-8?B?OVVNVW9UUWxMdk42RjhETnJpZnBHSlVGTGUxZEthYkR5WTQxdW9BdFVGbzNK?=
 =?utf-8?B?dFpVekRadndjbW55S0F6RWJ6ZCsyVVJsaDhnMklRc0NBeWV0MDFSUkp5dTJa?=
 =?utf-8?Q?OYwESmdw+x21vhjGJQcs0fPrUDF87CFF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5062.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDJwT2s1S0grU3d1UTZ5YWRhalErdUU4N1NEWVpYeTVLSDNPbDBzUStKeUNO?=
 =?utf-8?B?N3R3MlVzclM5YU15RDBoZno1YlU4ejRkOWJuSkdjV2VLc1RSS2tKWXZwKzd2?=
 =?utf-8?B?QmRWTE4xZHZYc1drUEhsT2JFNVgrbVpORmxrSUNSVzVUQTIxSW02d2JUOUtx?=
 =?utf-8?B?WWtFM3I0N2RVUm1vM3JwTXd3RUFiaUNjNS8zT1FuQ0NrVDVqS0FoOW9uWXFZ?=
 =?utf-8?B?UGpyR3M5KzNjcFYxNWIyWFU1ei9RN0liOGc1RGNFMXJZRGlLVGk0cExwL2Zy?=
 =?utf-8?B?NXRlbU5xaWhiUS9zQzV1MnEreGhkZW9GTUFIbk1Td3k0dUxJYlVyTDBjSmdi?=
 =?utf-8?B?QTZpOUFmblZpTDI4eHlPOXgxQnNRT0lkMGVDNjdUb1ZIbjFqZ0lucUtZTDVu?=
 =?utf-8?B?YWhleDdwWkp6eDgvVis3a0R0c0ZFaDlsbTFNVVc2YVRaaU9uaStLZ3NheTBJ?=
 =?utf-8?B?czZjVG4yc3pzVmJsMkxrWTFicVJRclJuSDBpeThCS2Q4SWQxUURPcTkwcXAz?=
 =?utf-8?B?TW5zdFAxOFFKOUxuN2JYYzRJNUhkNEl5S0k0c1dmTUFQeGdLWm1UT241M2RB?=
 =?utf-8?B?Vk0vdGtuY2lMc2dBbGkvUis0T2ZsNjBndTFwdHMvckRzcEVsNWE2NnRlaHhy?=
 =?utf-8?B?MFhWMkhVSEtnVUxSUFlXNGFVaHJsR2ZLeEoybEFqeXc5blJyenJuSnZ3N0xB?=
 =?utf-8?B?K2IrejU4ZWhZU0JYTW5OYng0aEplZmRwZ2ZlYlpmcEgxdkxlbXFpdFRoM2dW?=
 =?utf-8?B?ZHNha1ZIN3Y1ZTV1NDlBQ0V5cmRhQmdCVHBUY0ZidWZPbndTY200VW5ySC9w?=
 =?utf-8?B?dlNqbUVBMTZwa0ZUU2x5dy9weDdybXhlMXh4Y2UxUjJlM2RRRFNjQk81WlBE?=
 =?utf-8?B?RTFzUEdzM0RyWWxXSXpJL0ZOTGdJdWpkTTdJb0haMWI0eWNuMyswV0c2RGZr?=
 =?utf-8?B?bTZ3SEdEZHMvcHY2aUoyaENwZHZya2lva29ZdGxwQmI2OFNNeXZvZGhQYUQr?=
 =?utf-8?B?Y1hxUE9hYm9rcitwZjBkdldXdlhwbnl0RktxRzNhRWIzSGdVdlVNS1ZUNC9z?=
 =?utf-8?B?cUNabDJOVzUyeU9XM2ZaZ3pydmhZcGxNSTk2NlhLcHhTWSswb1RjRUV5NVpz?=
 =?utf-8?B?Q0l2dEN2bnU4bnNheC92T2Y4TEFQSHBPRDFTOTJoSEdvN2lvWEFVU3FKZU5o?=
 =?utf-8?B?ZDNKRFVqdEI2MkRNbDVtdXdvVFByMUxDOWdEUFRoVi9SeUhXVHJrUVd0Uytq?=
 =?utf-8?B?eERQZDJaRlZ5Tm4rZWtES3Z6VGk0blRyTk5TdmJ1UE52d3daV0Q0WDNOaTVI?=
 =?utf-8?B?Wk9DOEMzMmM3NjFoWDB6QTNsVVNWelRnNVBOTHNUYlVpVjdTZjY2Mi8zYU9h?=
 =?utf-8?B?NW40a0RnbXE0c2N3VzAwU0o3dVBmd3E0OFJ4RkQ3ZlJsUUN0MmVUWHBheTZk?=
 =?utf-8?B?MUMyWURSWGlSWFU0Q1FoRGRZNXFoa3Fiempmd215S004OGJKM2l4NVNRTENV?=
 =?utf-8?B?VEpGWDd4VjZDVGFiOTAyUFdXQmxybFNHQUdRRURNZ3dnRko1NWVUQnNSZDBJ?=
 =?utf-8?B?bVJETVhvcElVdHpiVGQvZnlSZXgzSFVLcEpsTC9hbWY2TTJ5blZjY2g1djhy?=
 =?utf-8?B?RlQvZHQ3VU5rTmh5cE15M2hpekU1M25WM1F5RjhiUThQWExFOEh0Z0xaTGFu?=
 =?utf-8?B?ZHhiM0VxWUtEOUNxdEJwSk5JbytET1dacFppVVdDU2dtZHJkMnZWcTNDWGFZ?=
 =?utf-8?B?N3hBQVF2V3NDTzVFbDE4NFFKbW91WlM5ZE04VlRQQnh6Tm9sTGE4MVk5VmU2?=
 =?utf-8?B?UmQzT24wSU8rMnZRREFoU2pZVUNwdHpKdFl5NHNXdFBGUmsyZmRWVVBSbU8y?=
 =?utf-8?B?WlFmZGFGVW5YWVhQcno3bUZsMU9rSGNwYmtzbmtEakdoTTBDVFNNTmNNd25m?=
 =?utf-8?B?R0g2OVZYc0lPTG05UWVPeUoxVXVQaFZKOGxEaXRYNjN3Q1NmUkFIREpRandv?=
 =?utf-8?B?cjFXVjdBcFlKaEZDYWhiUmhNUDkwcE9ONGFRdzNzWHBnaldLMWxEdEprV2Vl?=
 =?utf-8?B?bmNxRzgwTmIrc2wvWFZKYU01bys3eHZMTjl5VlBOajArQ1JaOU8reFBlcS9o?=
 =?utf-8?Q?wW8rcZif449e5NrJETW2zOoHk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbe95dd-36d9-49fb-953f-08de1e3818ff
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 19:59:02.2093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzCWv4ldpa3tA0D9Toqh+IV7My61/o8Hz5Hvf27KTVv3WLoXN+zKrMUAk94bXnMbKi3AWUzhqeoL/xZBQ2odWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8844

On 11/7/25 12:32, Jason Gunthorpe wrote:
> On Fri, Nov 07, 2025 at 11:56:51AM -0600, Tom Lendacky wrote:
> 
>> When you are on bare-metal, or in the hypervisor, System Memory Encryption
>> (SME) deals with the encryption bit set in the page table entries
>> (including the nested page table entries for guests). 
> 
> So "decrypted" means something about AMD's unique memory encryption
> scheme on bare metal but in a CC guest it is a cross arch 'shared with
> hypervisor' flag?

Note, that if the encryption bit is not set in the guest, then the host
encryption key is used if the underlying NPT leaf entry has the encryption
bit set. In that case, both the host and guest can read the memory, with
the memory still being encrypted in physical memory.

> 
> What about CXL memory? What about ZONE_DEVICE coherent memory? Do
> these get the C bit set too?

When CXL memory is presented as system memory to the OS it does support
the encryption bit. So when pages are allocated for the guest, the memory
pages will be encrypted with the guest key.

Not sure what you mean by ZONE_DEVICE coherent memory. Is it presented to
the system as system physical memory that the hypervisor can allocate as
guest memory?

> 
> :( :( :(
> 
>> In the guest (prior to Trusted I/O / TDISP), decrypted (or shared) memory
>> is used because a device cannot DMA to or from guest memory using the
>> guest encryption key. So all DMA must go to "decrypted" memory or be
>> bounce-buffered through "decrypted" memory (SWIOTLB) - basically memory
>> that does not get encrypted/decrypted using the guest encryption key.
> 
> Where is the code for this? As I wrote we always do sme_set in the
> iommu driver, even on guests, even for "decrypted" bounce buffered
> memory.
> 
> That sounds like a bug by your explanation?
> 
> Does this mean vIOMMU has never worked in AMD CC guests?

I assume by vIOMMU you mean a VMM-emulated IOMMU in the guest. This does
does not work today with AMD CC guests since it requires the hypervisor to
read the guest IOMMU buffers in order to emulate the behavior and those
buffers are encrypted. So there is no vIOMMU support today in AMD CC
guests.

There was a patch series submitted a while back to allocate the IOMMU
buffers in shared memory in order to support a (non-secure) vIOMMU in the
guest in order to support >255 vCPUs, but that was rejected in favor of
using kvm-msi-ext-dest-id.

https://lore.kernel.org/linux-iommu/20240430152430.4245-1-suravee.suthikulpanit@amd.com/

> 
>> It is not until we get to Trusted I/O / TDISP where devices will be able
>> to DMA directly to guest encrypted memory and guests will require secure
>> MMIO addresses which will need the encryption bit set (Alexey can correct
>> me on the TIO statements if they aren't correct, as he is closer to it all).
> 
> So in this case we do need to do sme_set on MMIO even though that MMIO
> is not using the dram encryption key?

@Alexey will be able to provide more details on how this works.

Thanks,
Tom

> 
> Jason


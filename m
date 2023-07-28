Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EDD11CA0
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 14:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLUAJvG3aAyvN2bJIdfuRvd79oWYO2Kt36cXoqr5FU3SemkjWmSF3l5Z9MBNejjGL7fImNsA89vCZW157SknCNMsT0Mj1aqKd2mGnkDbnAsjA57cnZFZQcnBISzDB59uTI3PurS6vgopf3wqTmaYn4FbB+0hKrr3y4RTVFX3UJNQy0h51iwkJj/fTnxWEbWn5h5a17P386xee1cTpgpy1L1/zL9GUeWtoBWpFTuzwa6CHwQ1xZglNBCH/VWJ+8+DLrqZJqpl3tKLwL0s/7d1UkKrmfWF9gnawDSkSicuUtroWDk752mWSiir3mDS2HOHBP8m0nNv9QwwXhnlkAUbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhceCX5mnhfas3U/7HKMUS+wkiA8blFk9qdyO1KfX2I=;
 b=Pt853Cs9Xyqt1hbnxdaxozGrqKQfbb3K12f2NmYqMCu4ClApb4vGGO3MC+SLs6KYKnIHrMNo0h2VR1UWlxH5Txl9ok8RoeIgTA1TsqN2/Mup+UK1HNEkq036j9Fial+DNpA7Z9jWkH4dpT/cRPqOK0DPhNpBzJ4egUkgGPQj8V91PS5ZstBHtKhRu3pP99mqayOLNkEJnBpuFmEX+exFvj+24KCd8ESpGO7X8Jx9VG14Y/OmnvK1Y4bE7wmWnKTXHb3QKD5huDzXufzvpf6pacu7MtE7Kh3e5KGOCE34qEvRNOjKGXJ5A89I1VRAye3rSOpiyAc/riGAEpmmwgiRyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhceCX5mnhfas3U/7HKMUS+wkiA8blFk9qdyO1KfX2I=;
 b=lzQeaVlplKzClAY20yhq8P0K0aWV5X6mjhZWHo7OhDeMCSfqynryKKYSRQFDi1WsE24c3Asb/iLM0SUIKZQIVdFNfjVRwihwF1VQ+xoWldUeEe8YB8yNvledWxJcpHlUTklqmKtT8sbJeBeGMaRbdllm3X09UQStZ198VYU453U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 14:51:03 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 14:51:03 +0000
Message-ID: <40df531a-ddc6-dd1c-eda7-27f3a3ab835e@amd.com>
Date: Fri, 28 Jul 2023 20:20:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/amd: fix the address translation issue when do
 detach
Content-Language: en-US
To: Jesse Zhang <Jesse.Zhang@amd.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <philip.yang@amd.com>
Cc: iommu@lists.linux.dev, amd-gfx@lists.freedesktop.org
References: <20230727095531.333532-1-Jesse.Zhang@amd.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230727095531.333532-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::24) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ad4e5d-3acf-4e01-a26b-08db8f7a1078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O4LXAeVEYW8OdQwbh4jsedUKVpl8ow9doikvUNcSqMYnsrCaytbZllL3rOeL6LQA9oF2Ywb6zi1x9+AYULetlWfULaPSg87rDrKtQgRetrm3AyV5B3FBV1DvO0OLTCPjMCvqOGTlwcjtG948V75wpvMBPQz08Ru09P+TRZZyfkm2OJQpPoQar5J/sR4YWfPojKoUrJ6v3zaVHTkOrMNePllUNACwXbHZtMoTYmI1DBixrb1DjvKAeNWshLyIgV/p5oNMEn/g9I+4vvTybwx7E+0V99Q8C5k6rySTrwFw1Ohg4YVWcPKC+vDDVdq8nNei+YgASu716EFSkodONWp0kFYu4cZs4C9I46sNmvJ59h3UIoFzmNYV4MqJze+FigEsHZu/LaEXYhpXaTueFVa9scnkusF1zBMDAfU98qmbiQLrLoSTEDMbZ9xgaX0RJ6LPrz/XcAHiGr5zwmp1SyYeS506bRe6q4xp3m6MiJDpuCBBYVDAjKfBUo63yn/EV2vpNwX8CnOHbmfO03JM6et79FPXSMYcCu8y8bVLxSdw6UNbpCmQBR3S0WvT3qUChtTUH/Ey/1tLk3p22o3t1lFElCxI3VIqPoX2LdBh5BuA1sf7cGBimY0wvDzE4pnSoWUF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(26005)(6506007)(53546011)(478600001)(110136005)(186003)(6486002)(6666004)(66476007)(6636002)(4326008)(2616005)(966005)(31686004)(83380400001)(6512007)(38100700002)(66556008)(66946007)(5660300002)(44832011)(41300700001)(316002)(2906002)(8936002)(8676002)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVJJVldOY3orL3pXTUtmR3Y5K3VLL1FMeHkveU5WcldwRHdpSWErVnJvd2lS?=
 =?utf-8?B?cWNNWldvSDdCWm5PT2MydGFQSHluYjhTbDFMcENjVlZ1QURaT1pVTFJucWJl?=
 =?utf-8?B?SFhmSFR5UTFoelM1blBMbVN0TXByUjdyd0Q4eGVPZW56Q3FzakQzVFIvc0VL?=
 =?utf-8?B?R3lGeXFBOXpDbE5tcDNaK0p4RS8rRWM4Y1V6VXJyMTZYOFlOanQzSWdBbzZL?=
 =?utf-8?B?R0x2Z2NXN0tjclBod0JETXV5eGQ0eE16MDloRG02K3c0UzNYWFoyMXJmQzEr?=
 =?utf-8?B?OS93Y09TemgvMng1azdNczJyMzNRNnJSeWNmbTBReDlZZUhCdHJoZUFNTGRH?=
 =?utf-8?B?Q09ETytwTWxEelFDUDA2TDZ5Uk1JSWswUGtlcGl3OThwUmpOQlEvay9rVUFO?=
 =?utf-8?B?aGR1dWVrZ2tsZWVTNWEySmdVcFVwTFpYN0h0STVKVCtBbTlVNm9PVVBHaUlZ?=
 =?utf-8?B?R1k2YTNpRGVyZFczNkFiTTROc21GaWtpSWpDNzM0S0ZKd2UzRTRHaXJKRzVm?=
 =?utf-8?B?UFRrbEZFU3ZqZWRpM1FhVEl6SFdCQjlwV3NFcjVVR2xNZzY3SFl1dHREamcy?=
 =?utf-8?B?K1BtQlFzc3JKbEdNclJiZ0ZUaWNCZXArRnI4RXlieUU0YnVNdEFHSTJpQUVJ?=
 =?utf-8?B?WVg2WEZkME1LUlZkcFZac3ZMYk1aYk04UFRwS3I2ZDdXZ1Z3TXBYaW1YMVRG?=
 =?utf-8?B?cW5RRnJCNDQ2Q0xjdGhYMlBrUC9GTTZsSkIvcy9uWjFwQlEzaTlTdklhOVRS?=
 =?utf-8?B?M0dMZWZGcDFLRGVzU1J0UWFlcFFtTHU0SU1MNjN5WkdLNFhDNGF1cWVWbXVs?=
 =?utf-8?B?ZXJnQTRsaC9sQ0hGWjFxeDhZdjFjNC94NFpwV1kwT2U0U1dWUlQzSmllQ1Ny?=
 =?utf-8?B?S251QStRY1prOWE1bjYxQmQ5N1BRV01zbTdHZjhLVlRWOG5uS3VSZW4wLzlD?=
 =?utf-8?B?dnJFdVlyWFgyZW00WmFLUkxMVzk1OThBeU9jV1lPK2tiV0RySXdXcHdOV25l?=
 =?utf-8?B?QTdmU0ZMU3VTdi9naU1uRVowSFBFS05GZTA4QXVuMXV4WHQxa3lWTk9qYjlO?=
 =?utf-8?B?Vkw5VVlIMDcvREN2VGt4WGl4Skd6QWFFVUxRd1cyd1MrQm1iVG5IUXlId25i?=
 =?utf-8?B?S1BBclZiRmpTbU1PZ0JDRnpLeERyOVVZMFczUWcxSTNHK045N2k3L25NMUtu?=
 =?utf-8?B?Z0JjU1JJQ09KekpCZUpnYUJBSExBdUZJSUZQblo2M25TVXZLU0FkWnNwZEhv?=
 =?utf-8?B?SC9DOG1yZEZacVBobzYyTDFjdW1EL2JqR240dzI1c1QvdkFHSDd1MnM5NUNV?=
 =?utf-8?B?amY4YVZWeVdOdkN1TWVSVElhSkQ0YisyUDdsVVIyVnNGbHZ1aUFSaDBENjRC?=
 =?utf-8?B?N1ByTFY2bVVLNFUvRzdZRkJoQ084QlY2NUROL05KZFc2UmFCTHIrWlByWXNN?=
 =?utf-8?B?WlZUUlVvS2hHRm9YS0JRSU1MYmZTa3g2djlTdlRyTXFBaXUvK3ptOThZbmlO?=
 =?utf-8?B?QjdDWDhXZk5MMzM3Nk1XWkZpaXRXbkJPNE4yTU9ZNGpJNjJ2N0pyQSt6UEk0?=
 =?utf-8?B?aGJFUHZNS3ZDekloZHMvSi9aOCtRRERVek9CQVl4cGJTUDFKZEZESWtLMmkw?=
 =?utf-8?B?QUxJaFVpYkJMcHR2Tk94b0UydERHemxMcHBNZE95NHdyVHBQajh4Tk00cGlU?=
 =?utf-8?B?Q1dQeEtJRlY2aXlkVFJCZTIvNDZtdjNtNldMWEVjR1FPcTVxY0VNZTNhYXhL?=
 =?utf-8?B?Tkt2eERqbE00LzlPa0JtUFp5UnVVMGxwSTNEcUw2RUJlb082Ly9CZ0l2YThR?=
 =?utf-8?B?TktlNG9ybGs0d0ZrdEdHZm5KTzdINy9LdGJjV21wT0NYZWlZczBLcW51TWtF?=
 =?utf-8?B?bEYxK09DcW9xNTNNVWlIb1RsZzZNMSthb3dWTk1vMW1mTEJOM2RFNFlCYVAv?=
 =?utf-8?B?bjlTYkpGSjBBSzM2bFdRYWVjcWw1N1g2VVlhZm1mYVVEZ2NqcENWQ3RSZEIr?=
 =?utf-8?B?ZlVsVXdyZndIOUlpNnNtWndZSStwcmxQZkdiMU5SR0MwM2VtZ2pHODdqVDJZ?=
 =?utf-8?B?SU5XSDlFTmVVRnJqempZcFc2REpQblJ4VHlqS203OU1kTElQQlpFMFlFVDh1?=
 =?utf-8?Q?AvRCjGVNgg6z2GcE4qnA5wfvd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ad4e5d-3acf-4e01-a26b-08db8f7a1078
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 14:51:03.2101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7NsGXOYE8/+4ZXcQAZHV3TpFzGBmpoVYNfan4f9oMlrlCuYZyy+KS8IxktLX/6QaWlxcT8ttnKHuCN0asLy5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481



On 7/27/2023 3:25 PM, Jesse Zhang wrote:
> From: Jesse Zhang <jesse.zhang@amd.com>
> 
> iGpu driver fail to read/write register by iommu when start X.
> kernel: [  433.296634] audit: type=1400 audit(1690403823.130:64): apparmor="DENIED" operation="capable" class="cap"
> profile="/snap/snapd/19457/usr/lib/snapd/snap-confine" pid=12344 comm="snap-confine" capability=38  capname="perfmon"
> kernel: [  433.515795] amdgpu 0000:03:00.0: amdgpu: failed to write reg 28b4 wait reg 28c6
> kernel: [  440.195492] amdgpu 0000:03:00.0: amdgpu: failed to write reg 28b4 wait reg 28c6
> kernel: [  453.679611] amdgpu 0000:03:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706
> kernel: [  460.383490] amdgpu 0000:03:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2659
> 
> Disable address translation service, before detach device.
> Do detach will clear the page table point or pasid table entries,
> so all DMA requests from the device should be blocked before that.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Thanks Jesse for tracking down the issue. Patch looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


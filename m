Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792560533;
	b=giyAyDkK++kKnH4L5GPgdnmJ+S2fUY/4gRRzGYLc4smXS6HkInoLxdF4OriL2wPwE7h8
	 DHqspx7asv4QNXy+R6oFHgKdRTLz8Jj7vh5EkHPTPXEPqXOn/GEBjwZi1jfo/01rPcXql
	 KpeyGdrbU72oLA2wyRy+u/KwTe297Yh59ZYEoyO9nkLcXl6GKlqOQr4JDP9sFxTDhofXT
	 qV5oC8PfMGN3Ha3jbfV12E+tbZu8XPK7azzSl+fEhYoWyWOklWDGpzzxAyyz6Q4v9/Wul
	 i1qNtm7GH6o1UelUPvTY4iaWyM73cxsy/zok/ZSpvEe+8FJ9dJ6XXre6y87oC3U5VVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560533;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=FMaht+2xAJLEz4FmgUYnxCnkpDy+umpX80pyXw0kDNw=;
	b=3tS0JpsA8G7WGhGTZBdEotJYrFy0qAqFWOIuo+iAhvHz7HPnwdwLXfH6/S+slbAL+nCh
	 VqmXYjfFa5ZjcjzR3xxGP1U0yJzdht7ItAGQxn4P1gziMyYSU/jH15XPy4PL7SEDLBEce
	 nMeKbdzsur3fbDRksifBSQE4ztBMS5RdK6jSbiKODCiOKqZLCJzsW9EtPIUaoAxYZsq8E
	 oe3UE1dh8pHDwa2OwvrpRCGhvUpeCTlBXunMfWMHA2c/157K9ZhskijZwkiQQ5SBW9AH9
	 C0kbgP6JFs5JOKGDnS61cXXhhE/uIAOzEL5NREPJKpgwJh7JrA9COwuNfqCUJyrT04Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rbV2vOLL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.15
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E05606A31D
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 05:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9E05606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rbV2vOLL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGa9tCGQ9P/xWJq8T65xI97Nc7wJvq/eQrVH4VaTNGuSUsDu0l+fKqY87nmhENOcEPBJ6sJVFO8Pz4jdJTPdxAyN+4wwFez6Hasxje+QvSfsIAl24Jz+p+g3XMM0XvmBXm7WnWm15rWObcn8X1tPzZPO7ZbBUslVPNQNS8qfaYMBdxv+FmJyGUFBWrfNUuxn0As07sK1dQRuxqBfd+BPlZcGIuhLJkSJLRI7xwJL788vEJWKPhZlEnRFrwf9d1eUtCamjgUInauMyTeNoMSVP2/yAQXuLSqxbtqsLoT2n78El/xPX7gbR5ddRj77I3Z6lB0a7rqKxPcPzt5k+cb6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMaht+2xAJLEz4FmgUYnxCnkpDy+umpX80pyXw0kDNw=;
 b=TCeX2jYiiOq0TV/ZAyGGECsunFe7hyi/gsjiU4JCBUifFwNHwQEL4OnVedWXKSFYUKq3wPgXSo6Y1NW2xN+PdptWPAWCsA48bsJBoyl2r/suwrfK6akFBF6rrPmAAtD9/LxWxr2NHevkplV8rA6zcu+sVNAsIkj3kp5d8XVMnNNtEtsKxppg0losBKq/b3/udAvGo7wwrYDmsSmAtdvc/iJ9If40DJee4U8WOh/uQ1jzp/i0bU3ulM6clTGHuJ0B8Vd9nfWo2yXGqBrjYBkopw/p96+ftKnPJI9ODOpXl7vNXMWglI6mPdq/9AeFAnNiJyl4mDrh6IFkJ5QTp8cmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMaht+2xAJLEz4FmgUYnxCnkpDy+umpX80pyXw0kDNw=;
 b=rbV2vOLLwx0ijU37FPYDeMRRp0zNMTMgOOY067+blUtue1sDwcsm18Ddb2Ntz7hzjbV5C07khXeRWVNkD60jZtqOvphD5JgYPVhhjVDNLdggrfbJJyCWBE3drPhgKdP57kec3NZi6S+u1uQ2SXMm+J+2Lo3ar7VAfK9N4butWXU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 05:28:49 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 05:28:49 +0000
Message-ID: <2d4cff97-f1f4-4c41-a093-3a42214634f6@amd.com>
Date: Wed, 21 Oct 2026 12:28:40 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/24] iommu/amd: Init and clear vIOMMU DevID and DomID
 maps
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com,
 chrisl@kernel.org, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com, guanghuifeng@linux.alibaba.com
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-19-suravee.suthikulpanit@amd.com>
 <179210758994.4133959.6615374486960504749.b4-review@b4>
 <9043514a-932e-436a-805d-9694b88d9caf@amd.com>
 <20261020165058.GF3008132@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20261020165058.GF3008132@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: e800eb94-36a3-41de-bd08-08df2f342f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ruzeemsWdQd8MIQ8lKR48ljf2o55jTrvi2qwsC/XHethXJZZFANjTp1b/fnneEpQ2JH2AqJfw3CcgvXGgRkrTDscd/6wJeyzftSwzfKDQ/RnIsZiui3qyrr4tA5tpRf7SdssJagb873N6DemFMBgJWQzsbDWMC7r/Qd2G66rpJQhmedC3fxelhT/fa5XB8brMEJlLjiLt9AqGujnTwoKjGU3PbCe9HWY8zb+MkJPcS6Ar7FVd85AHZGEv+BMvaleNEv6Ny+BAML7O/WwGjZYUMAFOWxsjIavoStXMKlg4teFUzCmRS5Sr2ttW6xN0oozOiuoPQMr9hmh3+bty4eTEVELSN8fdSb0bx6ce3A3tDZh7+fUwXqpWDMVgjhv/I82LesXJ9uuDmn7sHE3B0R2DasffPYFhxGyy7MVTR0zyfrgMwO0d/shJksNcMlcokq1SIz+QwYMfXYD4+EnEUhZuizOmqUsyhN8mccYmrSQKdl1xeJYftU/MWJdLuCRw+RoHdIhOdZu2RVJZpy5Pk/JfRVW/zcWXmtwx1npEr5NMfGHrFjstOUfWOwb4JV8sBGSNhk2BqVFgCiF58tQgSlVTyMx26LrZoAp73jooOjL8OHnCOfNGsBGldVXMuPmIlynvdiBrDLVvQ8/7jsPpKw8OWloTlpKzwseooKi6i8/QQo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFNTY1VlNVFZNVV1RWpEOHJGcWd0N29yVnkyU1NpMU9FaXpTdERGazRGSXBK?=
 =?utf-8?B?MnJxTmhhOTBTdkY0V1FjZXJ4SDVJc1JOeHp2Zm90cTRGbE1SNnVqVTl0Uitn?=
 =?utf-8?B?WFpnWTBNQXlibjBibnlSOG0vT2VKV1NscTZHSVVEKzRhci90QktyM1g1cGhO?=
 =?utf-8?B?NGZvd01jeWp5cXlURUg4ZGZRaUo0QSsrOGdsOXFYK29oLy83T1ptRGtFZk9O?=
 =?utf-8?B?NWh6NTdiNGFVRlE1NGtIZkhldkIySlBwMFNqZE5HNktGbHJ2aHBSa0F4WjNM?=
 =?utf-8?B?a1k4c1BNSmdSWGJDTUNKZytMY0NrbzJhdDVxUVlUenlsc2dOWFg0RGsvN1hl?=
 =?utf-8?B?dE9QbTE5V3dPV0N1MUhuQTJTVHREUHM0ZVVuR2lKT3NCVWdPVEtRcGE1UUVy?=
 =?utf-8?B?d29VaXd0Y0J2UWRnb25Za2I5WHFKZTcxelc3eUhJVUtjZUx2WVd0VGtkQSty?=
 =?utf-8?B?QWR6a1ZteFpsRXBTUDFTWHZPRHFkbUFXdExXY09mcm9mK2lVcWpvRUE5cEl1?=
 =?utf-8?B?Ymk4TTNpS0ZsbWkxdXpTZ0lVV1VwejRYY1h4SWZIdGVXcXVtQllOTk5PYTJO?=
 =?utf-8?B?TWw1c2VXQURmLytHUWVCd1VOdm9hRHBuUkl1VXdZV1I3cS9NYUhiWXdCTUJN?=
 =?utf-8?B?ZWtodytWaWtySWtwOFd0a2l5a3Vqc0djQ3FUWUpUU2VnTFYxTmNzTm9ZM1gx?=
 =?utf-8?B?VmpxWDJHZ3lPOUMzUzJvY2FVWnJnNDE4VmhJMEk2SmtJRWkwd0JBZ3RQQ1Zo?=
 =?utf-8?B?TGhwbkVUc1hWQkxVdDA2QXhVTkpMbnhvWVBGSDhHT2VEd3BwcWhmMFZwayt2?=
 =?utf-8?B?TkhEQnFacmoxSlNnd1A3ek5vYVJXR01BMVR4OG5NOXAwU1VuM1EwZHNQdlNV?=
 =?utf-8?B?TlY0bDU5Sm9oSUV1V1hoZForWEozc01Tck9DVnBsM2ZZNEljWk5sOHpBUW43?=
 =?utf-8?B?QWNBdmx1R3ZkVzBVYlZtUGxBRWlDY01lZHVOK08zazZYK3VJbE5ZYkMxR3My?=
 =?utf-8?B?eEdscXNyQjdqZDVwYUVHdHhtVjV6Q0lqMWFxNXFLbXZxbG1vMnVJc2dyc1lD?=
 =?utf-8?B?WEZiNk1lYlpKcFQzRUZsSkdLcTlHYW1SWFBNV2RyYTZTQWd5b1B1cXZ4cnZJ?=
 =?utf-8?B?TnRaRjNMdUN3dm9KaXRxZnJETmxHbjhoQzVNM090eTYvcjhac0J3NWhFRjJ5?=
 =?utf-8?B?K3pjbEVuQk9ORVIzejRPalRCemY3SEpFdGVpakNYaGpLaUdHLy9tVzc0VGVN?=
 =?utf-8?B?dDJNN2FQWlk4U3VXRUlWQ0Y5SGVRV1ZVaDFtNEpGK3BYWjcxdHJ4RVJEaytM?=
 =?utf-8?B?bTdGNFhiOXQ4Qi83VlFVK3ppRE13T0Z3TUEvWllBbmJKcFJZWU9wMytCdDNz?=
 =?utf-8?B?M2EwTHBVaU1lT3NWU0N2NFJDc0NVSER6WGlDNUp0SGZIdkFyQ1ZtWjdSbDBa?=
 =?utf-8?B?OW9iQW5oQjBWaWtKZUVZMForOTJrNW1ZbklLclJvUG5wanBIWlVpZHhSS1ZT?=
 =?utf-8?B?OFNUaEtuY3g3TW0wbFZScm1WS2JCSnlCNXJyUEtIZUZxbXUvOVdUQk1TY09P?=
 =?utf-8?B?eDA3WVhpN2VQWWdHUlFWYlpWbWs0MWdQODR4Y2JXTEF6a0duVUovakswOW9W?=
 =?utf-8?B?N29oblVLOGlOSngzUVAvMVBOWDZldHBPZGNBeUk5WmExMjk0TUxqdzl3RzFU?=
 =?utf-8?B?VmRuZnVod29pSm82MlhtSjRsZ0ZyM2JuTnJteGtnNHVjLzQ2MXhub3R6OW8y?=
 =?utf-8?B?aE5MbHd1ZVlqNm5sajQ1U1lEbWplSXJ0WWJHVnE2M05vTHh3a2tTSE0wckJo?=
 =?utf-8?B?U2NRbFlOSVZPOWNIeDNpSDZWUElmZHRVcW5Xd2x3Y3hvdlFmZmVjR2xURUJp?=
 =?utf-8?B?QnNua2ZheUhpai91a00yU1pCYkg3V0ZWeEtjanhHNWxOZmpYTis4MVpJOUxT?=
 =?utf-8?B?d3VqUjJBTjZtQ2dYMnhXY3d1Q2pRTy81R2dpb2w5Yi9nNUZPbDZiWlFkNEIr?=
 =?utf-8?B?UW4yd3BEYk9zQ0Z2dmpRK0hGLzlGaDZUU00xSXVSQktNMEpqRjc1NkI0dmtC?=
 =?utf-8?B?SjNzR0gxZXF5MFJRc01MaldjL3c4VkVjOEZPUnhUYjJSbFNvdkxPV1NhM2tT?=
 =?utf-8?B?eEhWUDFKaWRRN0FVdDRBOVErazJEdzUvOFg5dHZxSnN1enRQbU1DSGhIaDJV?=
 =?utf-8?B?dTVmTHduN3AzYXJ5aHN4ZlZYazQwQWJRVEZRMCszVVFSSmJSMmdOd2xYR3RH?=
 =?utf-8?B?NjMzVnlaOUpaL241TnFyeTMxL1ZTL3lONS9UQVBpQi9wVFhpclFwU1dabEZM?=
 =?utf-8?B?U3ZmaGlnMVFsTy91T09yei9hOVRScHJNY05CcU5hQ0J2bFo5TWVtUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e800eb94-36a3-41de-bd08-08df2f342f53
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:28:49.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYSwC/basUucJ89VrYdQNeUq7ll8KjWObg5yTZ8rZdiasNPCyr76iglHnzDzjCOS+hywlO3TYHIihCxWpSJ8AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958



On 10/20/2026 11:50 PM, Jason Gunthorpe wrote:
> On Tue, Oct 20, 2026 at 11:00:25PM +0700, Suthikulpanit, Suravee wrote:
>>
>>
>> On 10/16/2026 6:39 AM, Jason Gunthorpe wrote:
>>>> Before using a vIOMMU instance, prefill the mapping tables so hardware
>>>> never sees an unknown guest ID. Map every gdom_id to the nest parent
>>>> domain ID, and write every gdev_id with hdev_id 0. Init cannot be
>>>> scoped to IDs in use; INVALIDATE_IOMMU_ALL walks the HW table.
>>>>
>>>> Yield vfctrl_lock every 256 doorbells so the 128K MMIO loop can
>>>> resched. Attach cannot run until viommu->ops is set after init_one().
>>>>
>>>> On destroy, drain CONTROL0/CONTROL1 WRITE and unmap. Do not rewrite
>>>> the full tables: that would start 128K DMA writes into pages about
>>>> to be freed. vDevice destroy and nested_domain_free already restored
>>>> idle entries.
>>>>
>>>> Skip VFCTRL access when CONTROL_CMDBUF_EN is already clear, matching
>>>> viommu_priv_unmap_free() on the same uninit_one() path.
>>> I didn't see any explanation what happens if the guest issues an
>>> invalidate to a gdomid without a host domid?
>>>
>>> This is related to my questions about when the IOTLB is cleaned. Given
>>> this patch I would expect that once the mapping is removed the hdomid
>>> is cleaned and any invalidations for the gdomid are NOPd
>>>
>>> If the gdomis is used again it is assigned to a clean hdomid and those
>>> NOP'd invalidations don't matter.
>>>
>>> Is this how it works?
>>
>> When guest sends INVALIDATE_IOMMU_PAGES command with gDomID to vCmd buffer,
>> IOMMU hardware uses the gDomID to index the DomainID mapping table to get
>> the hDomID (from the entry w/ v=1). Then it uses the hDomID  for actual
>> IOMMU TLB invalidation. If the mapping entry has v=0, it would generate
>> hardware error in the host Event log.
>>
>> If the hDomID does not match anything in the IOMMU TLB, it would be a NOP.
>> This is the same as when host IOMMU driver submit INVALIDATE_IOMMU_PAGES
>> command w/ an unused domainID.
>>
>> For current implementation, the IOMMU driver prefills the DomainID mapping
>> table with nest parent domain ID (hDomID), and restore the same ID when
>> mapping is removed. This is to make sure that each mapping entry has valid
>> hDomID and not just some random domain ID.
> 
> I asked what happens if the gDomID hits an entry with V=0 ?
> 
> Presumably something bad to motivate all this extra work.

As mentioned above, if the mapping entry has V=0, the IOMMU hardware 
generate hardware error event in the host event log. So, we try to 
prevent by pre-fill / restore with the parent domain ID (a.k.a this 
extra work).

Suravee

> 
> Jason


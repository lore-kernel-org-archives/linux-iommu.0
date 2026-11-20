Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795193854;
	b=5cbneJ2xAXahyuRh6MR/xLo29xav79BnOPJxkRbY+3tHOhg4QNjdydYEr4uG0EpKF+05
	 hrQ1myZq4r5AlHq08BGW1pVGATAN3vUc5OldGQAnz//+2i5PJnMmg6n87xZ6s6CWFJGxv
	 zuINOcvAvXBOchITH8gLrDvrKwLuxDOrzGoNQO3TV3YDoHyVFN2sjuKsRsmB8PuPFGZau
	 UtXyFDETk8VcqOO/qacE8808do0KtT4u9r3yg5EMUBF67fQD+8XDStSVORupajFtPQ5+e
	 UdwbLtORzR8FzbMEtQ5oeei1L9+MKnZg+B+M/ZLIh/vYfF46sZDsmhROR5ITBk7vGEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193854;
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
	bh=kpfY2wbbolM+DJhZZGqHyAd32tP8VWBMLlstr/wz3eU=;
	b=rIBi6+PMMPsZklztQRwmVwBXaofxvBXy660apkZfeX6S7gsyhHxaWjZ+TKcvO8fhJGw7
	 tp8c8Ctrp70jgYOGq1uLRcUgZzz6wov6em7Xwb6W9/EShjniFN0NtnqOvGc+4XNsrkzEZ
	 NkRoGZE/7CYNySdFlAo9qgiIiDtjJLIIEaCwWyARYe3KOwDdFvUQPBJDc5VdR2QvThG6H
	 d0J9U8+PBUYUHPrTa8IG9JDazhpB1oRjjXmVOL9OJ6oYUHhk1Z8gQKBDPl+XgBC7t3Plw
	 ZhESkxpK0nmDY9CnQMQ1juSoVPpkEoHtnWw1/+eg6E+VlX7rzGqPS47ewSOqFgvqpIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ctrOWGW6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.36
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C588660A260B
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 16:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C588660A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ctrOWGW6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sa6hk0F8fhW1L8HXPAIxCLj4D+XwOD1FQVwvwpSZrOfrwnS+QdSGg5yszg5LCRP5zZF47nam9l3xr73U5omIXc0MkHsRFVc4Gf6mI2LjSE0d3MJ9Xs9vJd2QLdFHERhp7beh6Jv5sUadVi4Ec/CO2sa8b8JOZeqeVAd/TkWUFY7k8D8Mj/W0sxAZylsCdgXD4hU0AYb+WD92PkK4wm3pT8rDM5GhJCviblfDeIo5USUDUjumJ7gSCq68w15tdOH3HofI6K3b3F1n8W3uZ0WNWESlSkrul6H6DVntqGq03nsGmzEyxTIHOtgoJx+NZewnrQquPDLFVtN0nNBIKRrEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpfY2wbbolM+DJhZZGqHyAd32tP8VWBMLlstr/wz3eU=;
 b=lgOateCUUVICtlFukjTY3rtP1zl0eUeNGX+MgJcH20P6gk06hdkuiFqobpVzncUy6riOpR0OdaFAbej68ZNatrVgCLHpXTPhLZIFRJ+r0TgYAd4W7ga+hyYtgI2fYO9/9V0JSOezRWsgRckH6qnRswAMATgFRnoOveePtxCMpT7UOshSlQYInJDsvpW1OUnQOAgjoNCtU1bF6J8+qBYDa9NIs0uh6w/JtMcgc5+8GDq0cfTK+ZyzUqb2VMBVLvnLnjBAsNogE5RChwbr2EGo0ZFtdbBX9I5wcYZAVWex3v69oQ9sZji7RheZGKd1XlBMOCsIGB278QkDSV8AyABz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpfY2wbbolM+DJhZZGqHyAd32tP8VWBMLlstr/wz3eU=;
 b=ctrOWGW62u0l3U+9znnT7OsCzRKmURcEcWIGLIH7kl/rSiGtIOfHB6HxteBaLN7cs8Vhcrdu0Qh5SIK7LE7eDgD0XNl+fy81UxnawDFcVrUcFhUed4W2sS+CbYzl7e2HiW2fFr3f50Q+VKQyIks+yNK4Qw9isSm9blU7q6lg0rU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 16:57:26 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 16:57:25 +0000
Message-ID: <45ccbde7-fa40-4e5b-9e64-ac45bb141851@amd.com>
Date: Fri, 20 Nov 2026 22:27:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] iommu/amd: Rename unity_map_entry and unit_map to
 ivmd_entry and ivhd_entry_list
To: Sairaj Kodilkar <sarunkod@amd.com>, "Joerg Roedel (AMD)"
 <joro@8bytes.org>, Adrian Huang <ahuang12@lenovo.com>,
 Joerg Roedel <jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Akshay Jindal <Akshay.Jindal@amd.com>
References: <20261117070654.3699-1-sarunkod@amd.com>
 <20261117070654.3699-4-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261117070654.3699-4-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0270.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::8) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SN7PR12MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a6e028-b7bb-4994-aab5-08df47275a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022113327099003|261022105027099003|261026140227099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	WnkXHqHX98DwJTSvNV8QjwYqAF4mj0UtIDaKi5syM09q82tUU0NhC8mUOcDrFc609II+zTE+5SgEV5eVxcrfieIx4lmsHVtvD7J9nH1QmHmCAHHNXLc5SBCc6zxZ1NfVk70ASLZSjJ+NW97Wz0WMo4RHxHWIhSDRow8Cz9CTv37/zZgUVNCZQEdILw5S4sn+rfIvYabibM6Yvs36R0t2lRdVAMdpS4kMKEVaUjEOAk6xfPUUpxAx0AtLbbk3FZ0gP7ISLYdZjHq+VXG2p5VyFu/vDkH5gqWxDZaDnPoHkWpiNQVoFexBCHIeKxXarshieMG97gsmGjs8cVR9kcW6J6tc8j8W5vefb+oaQCaT2MjeUS5qwr39zXEfOFI6SeRSnK73Lr9surfT1lGn8OVoYFgrC1ffSZuJ3A4m808hQwnhudo45xvoLhWOyt1yJLwcxXLyxj9QQMwAUHL8/I1UwC/pS4Ve/L0w9sk6opEzoZEuEDal4jWRBJIXPr3QCjcI/Ss8fiPEi94EuVoH3mL0h7syN50dDeS6xaccuXE446XZ2IcOskOVj3VsQUpQUBdmDodll8pkoMmEzl/YhO+vUN0oUJ753iyPIWuWZXvhBDiMTJ2dsV63p40HvfBcZZ89YqkjDMdMby7w3+hSK16DXFlpbIhKrQwuUVtSOg6vFI4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022113327099003)(261022105027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHN5Z0szQy9lZVNqTll3b2E5c1BsZ0xocnhtUldUVk50OW5RRHRKZ3I5UEpj?=
 =?utf-8?B?ZWczbFpXSlZoZnVMYzg4V0FLRW5ROHFGbEswTS9EU3pKbG5KUmtDeHFhcmJs?=
 =?utf-8?B?UERhbHVDK1RqQlV0MlY2eEY3Tmh2REJmWjBnVjdLNmtKTHREVjFJbVhJUWhU?=
 =?utf-8?B?ekQzU2RESW44a2JYclRFZ2xRRjl6WmlvR2hPSlBVUitJYUl2QW1TSlVXRkNI?=
 =?utf-8?B?VXMzenZPSEVHNktDZ3BKRGtaVzlwK1pIcVEyZHVGL2s0bVNsYkd1dE5uRnhR?=
 =?utf-8?B?SEdHZk94VnpBRXJBeXhXZnpYL1daL1B5MHg2ek5ETEdSZ21wUVlaaFIyeHFu?=
 =?utf-8?B?eVlsSzh1cnZLMVZobmo4d05qODM4QjIrOXBsRnlMcGdEajVjUXhzdDdVOUYz?=
 =?utf-8?B?YVQ3azA1UTk0d2g2VS9OSldQckF1M1ZDZVBBSys2TDFyS0IzdUVWS2JFVGlj?=
 =?utf-8?B?eDdhQ0o2b2pyZE53eUxubFJkQk44cXM1WC9Db0JKdG1JeTl3Yk5WMHMrNzhN?=
 =?utf-8?B?VVhlc25NOGNQdTdwUGUzbHpGeXV0MmJaRDNJQTVnRUVxMWtxU0RydUo1TWxy?=
 =?utf-8?B?eTRzMHhjS2JwODE3bHQrOTAwS3pmL2VMcWtSSDFXd0wzSVdmTWVUY3NmTTVa?=
 =?utf-8?B?Ti8rcUFTQU1KQTRRWXQ1RnlpMGU3NlRMbGltWlZLQnI0QXkzR04ySk1vV1Fo?=
 =?utf-8?B?MjdSSXdQbHdFNTZHOUxLUEM1Z0lCTjBlWElsUDBhV3RFeGpNRXozcVZVRGc3?=
 =?utf-8?B?NmZBcE5sKzN6VmZrNGw3UzgyY0V3U29HSmN0OFFMY0xkOEF3VldNM0RzVGd2?=
 =?utf-8?B?d3VGQlBJdWMwdG01QkVXNGg1cDM1RkFqMkFCc2lLTEpvMlN5eGRTQTlBa0dh?=
 =?utf-8?B?QUh3eDJtTHBSUDIxajFrTFEwNGdSQ0ZDV3Vqa0xzZFdLMUJ4anEwNFg0RGVk?=
 =?utf-8?B?Z1Q3bnBwaVRIN3NoZFNud2RabFBON0I2dkcrbWN1ck9zTzBKK2wvTXNuUWxE?=
 =?utf-8?B?WUxUSlg0V0hpZk9rb1ZEM2M0RXBXYWhMWGQ2WTVKai9UUnlUa2lLalJQTEZu?=
 =?utf-8?B?NDcxaGJkZ011N2ZlcVg0OTh0T1ZxVGxaZWNRMS83cHVmUkhJMTJDWTFnYmtJ?=
 =?utf-8?B?T283SHdDRmhDNzhCZFVvY3d6WUlTVTNSNnI1Zm5hYU5jV2hvTXp3ZGVJd2RO?=
 =?utf-8?B?VnpoL296WlhWWkg2YWt4SHZicXNTV2dGY2ZWU2NhRG5ubHk0V25pV01ld25E?=
 =?utf-8?B?L2FXZXdqTWd2L3g0eFB2bVcxVXYzSlJIUU5jWUNENm5RdWtsbzlndXVPLzBG?=
 =?utf-8?B?MFk3aERxS25KVk1DQ2lEODdua3RLT1hmMENhY05sbnJKSVovTmVYVUpBako4?=
 =?utf-8?B?RjZTYktGK1NNZ21jL3VoTDNxZWo2RHRrWGRWMFNrOFo0Wkx0TkNDVmd5T3Ir?=
 =?utf-8?B?aldtbEsyQW96U3ZnYVhrNGh2NDFJQ1d1NUZ3a1M2YWFhcnpLV3FROGJmSTc3?=
 =?utf-8?B?S05sc0RYUmEyWDZuT3ZXMzBidDJIRXlHc2pxRExsRThqTEdTM0pxbDJtTWVj?=
 =?utf-8?B?bElCaTNOSUhqcGU2VDhLeU5WWnR2bm1vQzJEd0hxb1I3RXJRc1FTUGJVUFJ4?=
 =?utf-8?B?cmEzNTlRVmwzWHBkTWdIdHMwRHBNbDBQbTFqUVNjcGs1ZVNqQ0hybkVpbG0z?=
 =?utf-8?B?aHNHcnozaGgyOVZvY2Rsa1ZpeWh1RUwxSWp4ai9ROGhzc3k0bGY1R1FsTVZp?=
 =?utf-8?B?NDN3VTVNVnlmQjFaY2VEeHo3UWFmUkhtVk1DdnViWlNnN21GdXM4cnBpTUp0?=
 =?utf-8?B?a1puamM0L1FTNTFOcHdrZTVpWEZyVXo1d0JrVWxYb2h3S29aL3BFNy9YZmNZ?=
 =?utf-8?B?Y2hBUUdyQmNPdzQrQzVyMFVWSlJvYkVKeFhjOHg1QmhDc1NYSE9nTEdrRE94?=
 =?utf-8?B?UEk1ZmVKblJOaXNSWnN6dE1jVm5Oa0docks5L3dGMVNFV1lNMXRJNGZaWEhY?=
 =?utf-8?B?RVV1QitJRjlpRlYzR3QvNm1PK2tkeUZRWDJxa0szV2tjRS82UlVReUFTeXA4?=
 =?utf-8?B?N04yWEU3a1h4WEd2Zjc2elNCRUVCMkF6SWMwQ2FmbHFSV2xGWkZsL2lNNHkz?=
 =?utf-8?B?TCtST2hMb0JnT3hLQjBweUFBeExlc2d2WHFGcXREWiswd0ovbXVBNFlQTDM1?=
 =?utf-8?B?VExNUEwwYU45bUE5K21mUWJ5YXhGWjAyODh4SFF2V3lzNEdPdDFBUzBXNnE5?=
 =?utf-8?B?NldTekd1U3JqcW9sTGRiQi9yR256MlVGNGgwUGp0bENpaE5vTVRjQTZWd3NB?=
 =?utf-8?B?ZjdMWUxWWm96TzArVFZ3SE9lOVRjM2FOdldQMmQ5M2g5ckFQWi9aZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a6e028-b7bb-4994-aab5-08df47275a61
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 16:57:25.8766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKp8Dg4BQNfNj91yS7WjIcgJ7uATfqFkWyJcVoPfBrYYUPrpp40UeAeOryFvrBe2D4PvVcaC5Cib9Z10P2xMZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838



On 11/17/2026 12:36 PM, Sairaj Kodilkar wrote:
> Also, rename struct list_head unity_map to ivmd_entry_map along with
> renaming the unity-map helper functions and add error message when
> handling invalid IVMD entry.
> 
> No functional change intended.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Akshay Jindal <Akshay.Jindal@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  6 +++---
>  drivers/iommu/amd/init.c            | 22 +++++++++++-----------
>  drivers/iommu/amd/iommu.c           |  7 ++++---
>  3 files changed, 18 insertions(+), 17 deletions(-)
> 

.../...

>  
> @@ -3139,7 +3139,8 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>  						 length, prot, type,
>  						 GFP_KERNEL);
>  		if (!region) {
> -			dev_err(dev, "Out of memory allocating dm-regions\n");
> +			pr_err("%s: Out of memory allocating reserved regions for sbdf=%#x\n",

s/sbdf/devid/

-Vasant


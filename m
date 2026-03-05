Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14443334373
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729466; cv=fail; b=BbCLeyJrQM4v2/YQZBUSc+u4LlBSgetw1MQd3vwkWYCO3SRreJU64NnJ4UtqJ5BhLQTlQOuDWWePxKeCMpj6zyRzXeCzzv5mNSPvhWab3kUqQhdvNxAxy8lZnjb9hyXBe3EspS7BZ53cdGYdzmCQnRiykIhI0XJslnKpHPF1n1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729466; c=relaxed/simple;
	bh=/dFpC2pgAkWRxExyzjVW4heCfUEkWY9VO9X6pS0L6G0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NpuKLLIL+4XpuwaF46zAZVM7UmrBnabpXEb84b5ucsY3H4OErKMNSsekH73Btc05Qlu0OPMZnL1KjktKh6lO0l6XwgTJdbMg/aPPOiRUzQwJ1v27YHRKO+WOSY92ZXmMRcrGojnWkF36ByHIEv2ycOzpU5LuKxyyLPP3+PnjHo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A1BSPe2Q; arc=fail smtp.client-ip=52.101.85.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A1BSPe2Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsVxu0CdOSFH8GeXFwmF1WiyMggpng06x7AxWlxvd5mtBc26NFqLu3jtfJWXniSryTZpK6rU1WcDqo/HyDKixQ2EybHw27u+6vLEPge32kcp/RWQDw03qhmE538fFlXhP6x+4yUXqNsWIu+PygVulHuRmsdLobBxwFZ+7JuemTXDP5CuVxb1551ErhDsRtqlZspNN3gNxvtEEqoGDnTmmPXc0uCMe+TFnM+IR0cqCDd1KH2vHDylj75n+nhhPy7A4A/897zq5HuRBMzFKr7BzrkJWzieDY/dUqXKY4pbRgnwEcoZRelok9ixZS+tOJznS0KrwqVxr2KBCzYsWKeNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyrJf0yz/xSgkseIzaitz091tOH+x9bOWH8yV4OJ3bw=;
 b=gW4efLls5MXu5BpJPyGm+Sz0OK6tzECMO7moEPv/uvr/Q/Qmcx6p0tP4kuhoP0ZS132iKM4+TjSJf06FOAjH0J0SeM0Oght/MzXzDym+MXp25WSSNPLYZKup8eZm/Y4TyIS/LW/0ycgdKzDkq8ytbmq+aqs2+CACNwVvJspaVzlspZ72WBaw4QxTcOA6BmmTNvfUZY+nckKyeK4IXkX5jOR0Xu3gTPPcpeFLHO0viQ7tvyj0PetolREVvBJrLehj0brCacavgzObADtIraiD5HQA9GIF4J86vOF2KE05ahFvaWB4LMZNLdFUAaKUw02pmflTfFU5JwgMaxNo0gPKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyrJf0yz/xSgkseIzaitz091tOH+x9bOWH8yV4OJ3bw=;
 b=A1BSPe2QNciFkTbDEikAp/92oF+R2pFEvP3D/8OAk4/2Tc3csYlx37Q+Y0Tv7bHkjDqF6p79/L5a7G/cxRH/W/Imh6n0C93FILO3aaqCPymsAHDcDjcBFe4L2nh1MJdJ4BMJBkBK2f9M8aqMJpkYd3LeUg4SYz23h8q+TeQWcN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 16:51:00 +0000
Received: from MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288]) by MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288%4]) with mapi id 15.20.9654.015; Thu, 5 Mar 2026
 16:51:00 +0000
Message-ID: <50c705c5-bd22-4f79-959a-2508d07ae984@amd.com>
Date: Thu, 5 Mar 2026 22:20:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
To: Johannes Stezenbach <js@sig21.net>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <aXnXX0P-XsEFPlJd@sig21.net>
 <52148f32-2348-42d8-95e0-49b30c29da1c@amd.com> <aYHerYcZ-5FOguKY@sig21.net>
 <aYNi4yYA2_Cu359Z@sig21.net> <aYSjoRjnR3N3D8lD@sig21.net>
 <49856fda-3f65-4fc9-a75d-84b29526f3fc@amd.com> <aZoVhnX77mGUsV3y@sig21.net>
 <cf136d02-986f-402c-81d9-8971229abe9e@amd.com> <aZwZMwZ0FOa3dXwm@sig21.net>
 <b152dda3-e929-4ec3-a034-2057ff3c3c81@amd.com> <aZ1rSxy_za5f51bV@sig21.net>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aZ1rSxy_za5f51bV@sig21.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::10) To MN0PR12MB5761.namprd12.prod.outlook.com
 (2603:10b6:208:374::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5761:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 13312d58-58dc-4c8f-02d2-08de7ad76111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	twpRMJN7yGmPb3xQghSBQ9ZOkk90yRNlRlmqSAk+0iiqvg4i3PrlcSykrcQPKAr77AnYf0Z58eDELqTlGak26Ae/6uJwCpRyMF3fFELcqtRFoThRT/wZ9qeffRqVZzTisUaa8ar7QfEu8PodlM0Mb79ulCMsZVl1FqbC9LcYm3/icFmQ7jmNgjc3WaJF3Ybxi3bExf2HCU4M4ZobNlQa8MhUt16S6vMYRU+k9VcaejJ2cvGIyWfMG8pNew+UsfZCGFkZUqvvqY52ptxr0OHFRinApY3L30Vxi/wsbNth9aIbvaRtQKAXpnPLevHi6iF0OQe4eLTBq1BA7Ns1g4Ysd5TxGHOXNjEBXnD5oyctMLZck6wnm274S32HnQSaNGoyML+XeBuS/pI/vMHdQsnW+L6SNUtAA3m5HPDGNgltnGC7pjzbOSIjbsMzc/s29te6eIxU4Ldprs4DnlVcd1h3UmYZ1MVaXelIMto+KdOhBjakCLLjtR/2N74Gp4Tm3w93dgdm81JiZD1twdcXxs+nDdtn8b9DykrSjLoShm1lgmR9zmxADMOImWwP0rXa0TvNaqpNEJ3HRTwmLZUtoI2Zw/p9tigXZ+g4FguzMSWRb6ygCF1HZhN6ik2IQSqGWL2JtudDnxzP77TppYh46+9Jxc+DHnTmgmL06l2OrgHbNy5v/oG9DKejScWwWzFbAKa5YHfPVFrkiVEG0xcKadHBLx7uHSOZizgUse03BVfBxhM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5761.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXdtVWFkc2NXLzNqb1lZTzI4djdiNlVPL1k4OGhnVFZNdWxRSUMzRyt1akds?=
 =?utf-8?B?SDhOTys1K1MveW9Ya1FCRWpxRlQrQzhNRWdvYjN0Q2lTN2dsWTU2K3AxN1du?=
 =?utf-8?B?U0wrbTZWaGlYcEM5dzBvb3c0T1Zwamc4cnJtWHFYTXppeFg4ejdLNVB1dUZY?=
 =?utf-8?B?RVNIQ0VwMldNcG5wTGhTUmRNUTJOaVZDcUdKQzFJaFg3L3BZZVEyRi9pNExY?=
 =?utf-8?B?Y3FFNlRwb2FyN0s4dkl6bVBWL2hQWFF3NVQ0MDJoUG5NQVczdjUvSnBEYVYz?=
 =?utf-8?B?dHRvNE9DTUlWYnpnTFpoa3l4VkNiR1h0M2FVZkZvRER5OHlUbTVNQm9RR2dq?=
 =?utf-8?B?TjBoMGVob1ByUitjbVk2c1o2RXNzYmc3UVdzWjNYakhmSS9EbXI0d0VXVGNG?=
 =?utf-8?B?Wkx1dkFZdXpJcHZQaTFENXhUbW1RL0wvcm5QRHJQUFk5S1NwWk9IKytKR05R?=
 =?utf-8?B?MndVaVhSbWlmVjhpUTFRa0dISjFZNEp4NEp6cTFCbU5taGNXL3V0M0hkandv?=
 =?utf-8?B?cE00R2RaM0ZXRGxhdUJxNWVZWVRwaUk2NHJUQWRmcGNYbkI2eTFPQW5SS1dE?=
 =?utf-8?B?clMzeEZCY2xBN2tJWXJjMDdkcU1hVEQrTTZtcGRrbG1ybTQ1S29tc1BZSmVE?=
 =?utf-8?B?YkR2MytjdmcrWjdXVlgzNTR0d3dUWG5RSU9JcUVsYTFyWHdkM2NpWktyVzUy?=
 =?utf-8?B?ZmNSbnhXaGxZYUozY3VLYnFtdk9TSkpyZmZIbjJiUDJxMW5SNWEwemExa2Zy?=
 =?utf-8?B?Wll0WHlwOS9RbzdYOThCdGdJUzJIVWg5bFVRMjgvK0lFWm84OGlyRklGRXJ6?=
 =?utf-8?B?YVJrcHowQ0hLOEtsQUwrNjdkUjJHc3RNbWFBaC81Q2oxNmlVSWZ0aDFrVUFt?=
 =?utf-8?B?MHVmc0kyclJNSXlzTXlXUkZuUXRTMnNXbUZrMVpFNCtmcWdVSm1VcWZpZ0Ey?=
 =?utf-8?B?NE5URDdJVEdQV1B2VWdDbkhSeGJ5ZEtEQUt5UERpaklFd3drL29wOW9EaVlW?=
 =?utf-8?B?TnczTlZBa2JaUTFVTEF1SGo4aHlCVnJ0SkFDSkZvbC91djM4eDdGZXd6WHBO?=
 =?utf-8?B?ZHgyZTUzQ21sNGNBVDVDYnc1WkNYQjhlWGI2Vkhtb2N3SkZrL2xQZ1cxYjlh?=
 =?utf-8?B?aFc4Rk1wWGlnWmNQQ1BjcDhCU1ZkT2tadmd4L2dwWkJSM3NQUkc0TDFzcnZn?=
 =?utf-8?B?NUNIR1Q3dDliSzlzYkZmbjUxL1E1RzZUaW9TaG52cVBUQUV0NFJiWThBMkUr?=
 =?utf-8?B?Z0g0R1pQcDl6VzVSLzV2TWU3R3RSREFYdElmMmZuK1lrSUk5NUtBaUtLR0pB?=
 =?utf-8?B?UGM4c2JpRGRPbStlc1JRSitwT1FYSlFKcXRuVE11bjc2Mnc4NnRHb1o2REZ6?=
 =?utf-8?B?NUh2Q1FGYms1R3Y4T1BBOFVKNVQxZzJlZGtxNDc0MHdsNE9wWDN5REtzdTlK?=
 =?utf-8?B?ZGJsK1ZyV3BhdHpvQVBGUHl1NFRieDhONWhnUmVscUxjQ01QbUVoMmtjaW14?=
 =?utf-8?B?N0R2VFlXUXZJc05kc3NYZXRqemNvNGJVQjB6MlJ2UWc5ZHFTS3pscW5mOXNO?=
 =?utf-8?B?TGo2ZFF0ZEZQdkRyandlMmxkT3RvR0JvZDNGZUZqNHVPQytNeGt2U0JXRmZI?=
 =?utf-8?B?SnRUQTNGTmQya0IyWTlWNXdtaTc0UDhFRlhwMWlGQVpCMTFoYUx1MkxMb0pG?=
 =?utf-8?B?a0lTMlo2OVBmUEFUaXpCUmRVaVUxRU5QRjZyVFB5YS9kSW5KdVNXZHdhZzRQ?=
 =?utf-8?B?YkJhdFlqMkpjbERQditjbVZ6YW5ub0xtZ3lCdHdmcVJuUjR0U2lPSEdIQXNO?=
 =?utf-8?B?NFJQNkVMTHNCVHZFWk1ibjI5NjlNU05YdUlEcVV6QlNxU3c0MDBRdTV6ODNC?=
 =?utf-8?B?cGNQZzRFMWRzNWxPMEtHdVZRY0NXbm16UW9zNzJoM3RORnRlSnR1VkJDcE91?=
 =?utf-8?B?UjdHSzN0Ykt0aWEzVHd2bHY1KytFamJGTmc0MlpicFErZnE3V1pWRTh0cGk3?=
 =?utf-8?B?QTN2cXIxYTF4NURpRUpTVjVRd0VOZFlJTjFPTnJCMGdEMmJwMTVkMGd3NnE5?=
 =?utf-8?B?OVdOME5BL2d4U2xDOFI0a1VlTE8wTlRtZHJpNWNabnk0aG1pemM2eUtHc2NU?=
 =?utf-8?B?SEtRdzZqbEhxc3dRT0UxbkFGTGNGTis2ZjRJYjRnMURBbVVsVE9OVUYrcHYr?=
 =?utf-8?B?dWtEVGdzYURKdkhvODU1NWg1OEZKWjM1aFcyV0YvbHZSVTNZcVp1a1FISFpo?=
 =?utf-8?B?azY5aGQ3eEtReFNqT1lzSlJuTFRJNnV2c09yaEV4ZzRnbXJhaFdMdWJ4Vm9i?=
 =?utf-8?B?dXJ6aEJySU5jNC9nQndQcXFsL3hoMlUyQVo3OVJHQVJ4UFluY1Rkdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13312d58-58dc-4c8f-02d2-08de7ad76111
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 16:51:00.0174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIZuZxbH2dqYR1/1t21uHfHU0bPaw6VFTgIiv2npC4jRhioyXDLTkzU2T+c+IkicvKQXHaXHJBAqqm80waUqYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750

Johannes,

On 2/24/2026 2:41 PM, Johannes Stezenbach wrote:
> On Tue, Feb 24, 2026 at 02:26:01PM +0530, Vasant Hegde wrote:
>> On 2/23/2026 2:39 PM, Johannes Stezenbach wrote:
>>> [  271.070351][ T5153] PM: hibernation: hibernation entry
> ...
>>> [  302.420499][ T5153]  do_syscall_64+0x7f/0xf20
>>
>> Is this hunk from suspend path?
> 
> As it says, it is hibernation entry.

FYI. We are actively chasing this issue internally. We are working with BIOS and
HW folks to see if there is any BIOS settings which is causing this issue. I
will keep you posted.

-Vasant


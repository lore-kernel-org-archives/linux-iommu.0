Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F57231065B
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549274; cv=fail; b=nBvwSYDzGYsstI9a6fpouhFdL3mx8EuIh2awiIgPovr2OSdyYDD0A5m3uozxEeT7J0unxXtzll2lQBmflaBw2MTNAsURx9pcsSwYa+OhDlA9u3ThQi3LQAVBM6W7RLnlx5JScZHD7RWQKYEKew+NRbnjlbgYLh2FtpPNNzX4gzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549274; c=relaxed/simple;
	bh=QIkKXsJuWKwmCYFPsKJ9dM9xT0lj1PJEVI4Xeset56E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LxJqAmyutifYYMt58yO+rELJK0d9QNQJa0OdmY5ZhEQTcJeaer9QOpY5hz4I4dlG5cWlvwMstrcLpVqbweh98Y1GcrHQnzyO00Gim74h360P7AkBv4IjqIjj8HbOFY+hf4EP5/UlmcJJ4WFZn8utCl8bF/foLvS6CFl84EGBNic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ILbvxtAZ; arc=fail smtp.client-ip=40.93.194.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ILbvxtAZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTUMJzlpKHI9R3WfKk86xHhoftvLMiEwjC/kL3Z5PTl9M/08e+sdS4lNXVSXv+bm4y/xSI8tq9cWUOX5cIxFa3tQcIirORSqWKfVd8joX++tz5RcFr7cMGlo8+bDaMxaU102YHVGXoqulJwayJsAvO/YAW9jISDw2uXD4htJccDClW2VsTgZMtIlHGnZG5hvbnBFhoqkotaDDpLZoTMA6Q4vagFZaH3ADd+N/GIqxraSXgQuNJcOoDUG2ZT4JmOmPgCWOExkiao0s5k2J/vIE1ExLcm1VJ6ohc+5LTcK6iPm+SsbpiYkgjxWsio2uDLR9KUNPmMcud5x4wPZJFEaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDYpttVbe678PRmfklmM4uPtVkFDI/IjdDq+BVugukk=;
 b=DiyOMEVWqblFbUBLUMM0eE+NAlAPKvq9jiDyli9RMt0mYFo7E/WRDVQ1/A5RVRy4m1SQFxe1d9gRVvv/aRYDNjU1i0Jke7gPMzTTL/E2qZn0qw0R6S0B6THqR02lmDqbuJevAE5ToafHXLo7TfiJivADiNKPUEc95F5cPeiOazRxdLrMD/I2xyocONFTRAwgtCIEKLOSEDzRiK6prjcFOl3SwBGppejZe02Mvquh6rVLksj++mmIsDIfg2dEau/5U85qlZYVnDIEqlJ7PRYNsqztKRlpeZv3MJZ+98Ckz5OnHBxfRYmFsOlAbbvh5u1xu1KtzbKMifB4Oyh5oIqBOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDYpttVbe678PRmfklmM4uPtVkFDI/IjdDq+BVugukk=;
 b=ILbvxtAZzlVeZq8Eiq3/GmeEF6ybQesfRRQ4BAhJJfW2xKcep07K+yWGEIdXHdKnjX3UuuRZuTE/7Texe8g/ehx8/Kl1MEyFu8LTSsTCcBH18EWhMpFkNzQkiH22H3X3W0mXVmg68gUKRNarn7QHWJHeh8F1k4X7hbQaVaCWqWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Wed, 19 Nov 2025 10:47:49 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 10:47:49 +0000
Message-ID: <73158dcd-89c9-46e4-b9a6-2b8d229a9f68@amd.com>
Date: Wed, 19 Nov 2025 16:17:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] amd/iommu: Make protection domain ID functions
 non-static
To: Sairaj Kodilkar <sarunkod@amd.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, ashish.kalra@amd.com,
 robin.murphy@arm.com, will@kernel.org
References: <20251114104442.23296-1-sarunkod@amd.com>
 <20251114104442.23296-3-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251114104442.23296-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 2defe819-7815-407e-9cf4-08de27591530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0QzMjVHbFo4ZGtPTlVBbTFNQ3lMcjFVNXErWTJVWkFlNXhqVkpLb1gyYlVt?=
 =?utf-8?B?VnZzdGhGam9QeEpRYURLZXU3YUx0aFZDeG9lZmVUL2pFOE9lbHJCTU5GNEQ4?=
 =?utf-8?B?Qm9DeHkzVEZTNUdDT0lsL1lDSHlSQ0xNT3ZId3AzZlVzVjVXMS82SklYSGd5?=
 =?utf-8?B?NWkrb1dSSk1CeW9VaGdTYndQOVB2QW1mS2lJYUdEdVFWWWFWTTVNMXJTcDFP?=
 =?utf-8?B?MWdCMjRDekFTYkY2UjBsdjUyMTdHUjBINW9NS0thWlhQcFBMeWQ5RFNwbGlB?=
 =?utf-8?B?QkFVV3VCaTFtUmFmaTM2ZEdUbGtjZzUvT1gxMm1yTEcxbTJEb0sxcUFaWHRr?=
 =?utf-8?B?VEdxVW9sTEVSME1rUllDNHY1OTdhS0JtWHhpNmlYM0hNaERZSldoMHNqbDdW?=
 =?utf-8?B?c3FBZkdnZkFDQjliQ0ZRVnV2T0ZFRnBJREtoVlRyRXZKNk5WclFIKzd4bFdC?=
 =?utf-8?B?dHFjQlRSVFhNK0hUN0wwaXJsR2VORms2eVR0ekFKTWY0TGVJQzNLUFVEMkFs?=
 =?utf-8?B?emNKOUVFYmxOeWdsQzFDU0VsZzNjMFlvTWtYZityNGRiemR6REpWdElKd0FO?=
 =?utf-8?B?K2EyYThoME9LVGY5Z0VSYklqSFduVC9PZFZxbUVJQmFsVU9nUy9vT0NwWklm?=
 =?utf-8?B?L3JMZFdxWm0wbVA3WFpUaVBtc1NQN3ZNaEtCQm5PaEhLdnJUNEY4YUtaR2Ju?=
 =?utf-8?B?cDFRbGtIa1JVM2tXVmpOemNJMUxXeVNFdlpYZG9xbFRmRE5ORG5hQzJ2T0h4?=
 =?utf-8?B?UmNNaDdkaEZPb05RQm9xZmt3NmRaRURmd2kwNWFmeG5oZDIwdTRXdXN5R2Nz?=
 =?utf-8?B?OW1vaitWM0E3SmVSREFoZGlGV3kzVkxiemNtcVI5a0RJUUFZUncxKzVpSytp?=
 =?utf-8?B?MmZ5OWpwcmF1SGhwd1JZRlFpWU54d0RuQXZnTTFRR2RFV1lCMksvS3IrcVJu?=
 =?utf-8?B?T3hCaHFvbjNsSUNSdXo3QzRQMTdSRFFIbGRPUnI3Z1J0UkRoTVljMVVRSVFr?=
 =?utf-8?B?V1lsMVl2QWg5Y3owTUhBaGN4QTJRaG1NaTRuMWlLc3JxU0tvV2xlNHd5M1J4?=
 =?utf-8?B?OGJuWlJqUFAxdFIvbTlXQ0xBK081SUU2SE1UMENyM0RIQStMbnBQTDBWditZ?=
 =?utf-8?B?MHlaWThNdkd0a2JNS01EUHNqRlUwVzZxd0FmMFl0VjFkN1dveDRMWjJ6TFdV?=
 =?utf-8?B?Y28vWHlWaktzeWw2VTBqalE4VDZjYTRpUmppMldPbTFxWFhHbjBFQlU2alJ5?=
 =?utf-8?B?ZlhmVlBtbEY4eG9qQUZlRWpDSE1URGkrS05FV0FwS0xESEM3Qm9nK0JyMnVZ?=
 =?utf-8?B?WWkvNlgxa0xxZWR1SEtvdWxEUjMvYUFlQzBoQWlSSkE2QTlDWnQxTFk3ZjUw?=
 =?utf-8?B?M0Z6WkxHMEkrV25KNFBuRTdseVhwV0szZVhraWM1R2Z2WHFQa2xwYTdPTU9y?=
 =?utf-8?B?dnFGYml3d1pTbVllYU9IRkNmM1ZHMkFIa0dRUlRwK2pGT3pCTmpzSUZpQWF5?=
 =?utf-8?B?dG1KVzRDQjZTeGpGK1hzRlhFa1JOVCtoQXNlbkt0R1FSTGhZMExoYTNEM1ZD?=
 =?utf-8?B?S3V5UHRUU2NrZ2JTOTF2WDJiWWVVZXhPUi83VGtvY1FNdjlLeko0SjNzeG9M?=
 =?utf-8?B?Sko0T09NYkJBRVkxY2t2MEtXN1g5TisrWks0T0RHY1NNTHg1TGJFd292b2Yw?=
 =?utf-8?B?MnU3N1lPUGFJT1V6MFNaTWtLVjVXMElrM3RPaWdOVTI5UjJWelQra2ozV2Vq?=
 =?utf-8?B?RVkwd1BOSWdwcERvWFArWGd3S1MzKy8wcFNQOUFJQmYwbUZORFI2Zlcxd2JL?=
 =?utf-8?B?VTRLcFB3RE95QUQ3UmZxRDhuWEMxV1RWMVh0WUNOTWxPbGUyT3U0S2FicDJs?=
 =?utf-8?B?TUc5K2ZnN2Q0LzEvQzV6WWExblBRcjZkMWp6OGdkaDNNYnJRems4QXA3ZzRy?=
 =?utf-8?Q?9evAgLXCSwDYt7sOpobgiQ2Y7YDdPNjb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MitQaG1MTnZmdHV6cnB3UnFKZG0wUzJ0My9mK3drczFOMlhuWWc3WVcxLzMw?=
 =?utf-8?B?clV6ZEdKa2ZJWlBLckpSTkdTbGozTVpaOTNMd1JjTmFHL0JKZUZDVG5veS9k?=
 =?utf-8?B?VldFU2pwUHRpSlRBeGpOVkU5dy9HcHFJaEhMSi9XWk1neit5U3ovYVdtcG5U?=
 =?utf-8?B?LzZlYW0vc2Y3Z2IvczlKK0RBSVBRU09vT1RyQU5ZcUpQMmFCMDB5eE1oVjVS?=
 =?utf-8?B?UjFRM1I1d1lFWWNTNEE4a1RRWFVuODduZlk1OXh5VGVpTEpTR0JJMzFtaFdB?=
 =?utf-8?B?U0h4d0RYWmxqeWZ2VUcvbVhyUVk0MHB5Z0RwZGRFWGV6TW4rQ2Ftck45RWFq?=
 =?utf-8?B?ZHIwWFBEazF4MjR0cUliWVBVZVNBU3BDcVZ6d0dCSWJ2K3MyRGRkeDlCVWg3?=
 =?utf-8?B?MTMya0wwRlU2NnUxMHZmODVwNEpJZHA0R1hVWnVDU0NnSEJOTGE1NjczUXhN?=
 =?utf-8?B?bzh4aHUrQ2E1anZhQmttenB3d3dENUhGSDBmZkdjMnd3c2VqdFpjc0xLaUl0?=
 =?utf-8?B?VGdMSUFvTVVva201ZWxFWllScjlxYk8vWEpCUFFHeEFtSkM3SWpQTGpEakp6?=
 =?utf-8?B?ODZ6eXlxVGZYWDdtYk1mbUtyYlZ6Z1dycVZJZmNSSUtKK1crZEJnUE16cUlT?=
 =?utf-8?B?N1JQRHNIT1docmJwTW5YNW9TUkxpK3MwT2dKdGV6akI5TEVFTmtSWS9tVFFB?=
 =?utf-8?B?dzN5dlNBYTNxWE5XbG0xbUtjVXJoamkvQTkrN1IwOCtyZmh3STN3S3l6Ynk3?=
 =?utf-8?B?b2VpVEVMVitNYSs4S0VqaDI5VzExNmM0RThIZEhpamJWSFUrbFpCZzdCZkVF?=
 =?utf-8?B?V1FWei84ekg4Uzcrb1picEFFQVhNOFJIU01qM0JPb3lWbURLakpMTVgvN3ZJ?=
 =?utf-8?B?VjZoN3dOWS9sU3lPblQzYnBsSkd1dlFpWXd2ZTYrMkdEVzhJcG9GNFphUEsz?=
 =?utf-8?B?L2JCSStLeElUanY3MWE3dXJiT2FzaURVNlQ0ME1kOWMwWHRmejZtUVY3N0xJ?=
 =?utf-8?B?anR3S25xS1JZN0hHN0FXc1NPaTdocW9PUHM1Sy9ON3VTSkMxR3Rjd3haOXhn?=
 =?utf-8?B?dGxZUmtKOFd4WHkrWVpZaWxjQjBIc1JjOURqWDhMbWw2WWZqbklvRzZQV1dx?=
 =?utf-8?B?SGFNczNEbEZOaUUwSWRaL1NHd2x6N1J4bXhKZXppZWpBQ1JBaC9STzhBUWZF?=
 =?utf-8?B?NDZFT0pXV1hGdGhHT0F1Q2N0R0R1c0VrSHNqTmVrN0VzN3RtclR0MVp1Z3dH?=
 =?utf-8?B?dVhZdmV2UWlLZkljVG5SMThJTlhLYUptVWxoVkFEZVNHdmdQbzg2dzg1bFVm?=
 =?utf-8?B?OXpYelhMUFdzM3JweGpmakxWd2d6WDg4M1V3MVpzRGdXY2FFVmE5ZUNqQmE5?=
 =?utf-8?B?QUlyVmVMSUxaYkpsNFpyV3ArRDV0QStCSU9QWmZDK3N6d1I2alQvVGNuV2cz?=
 =?utf-8?B?eW1iNjYzM2xTOU5TOUFIZHBEcGNkTElRdDBwNGxIb1F0bkVQUTdZRUFVMGIr?=
 =?utf-8?B?cTZiUEtGV0tsUUd0M1dQVk16alNNbmZLb1BOVFRJaklaSjNkTXFKK2hlZ0dK?=
 =?utf-8?B?YUsrUkxvQ2xzZFpjQk9FNmhSS25veW5TakRVVWV6bUdLUSswZnZqN2V0c2Fs?=
 =?utf-8?B?ZFA0Z2hqaE55TkhWQzRjcFlZa2lYdy9VSUYzL3dRcEJjL2pjWVczbDRvY3dD?=
 =?utf-8?B?THBaSStFWGhlUkliME1lWE5lKzdsNlNDTWdsK1ljRTF0aXRMc255bytaNUU5?=
 =?utf-8?B?THB3WFVTYUNHdU84TGhLWGhjRFBQckt0MXRVSFIxSlFhSnlyMVdNOTNVZklG?=
 =?utf-8?B?eTZIRGJ0TzcwZVhmTFpjZFI1OWswVDE3NnM1c3hBLzRHUjNVL3Fjc05yZVdI?=
 =?utf-8?B?WDRIZGc1LzNYVWJVK3FGcmhmc2RBNGhMd3dlVXlJeWZIeU16TEpSY0gydDlZ?=
 =?utf-8?B?MWl2aUJXNVBFd0pVczJhci9PMVl0cTk3V21NU0dyTjhTc3B4bks2eXFQbGpm?=
 =?utf-8?B?MVA1UDJmWW9tdDZMS0lDRHRsc09uUldKTUEyaWNpSnR2Z1lHNVlpNU9IMVBq?=
 =?utf-8?B?ZVhBNzVmUnI5UCtTL24xT3ZGd2VHdjNuTG1rV2hHVHFtZXphS29uckJQRVE3?=
 =?utf-8?Q?S2a3vKcXAKme4wlBWNwa3lIs9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2defe819-7815-407e-9cf4-08de27591530
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:47:49.5839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GVC2ZHeryw2NiMQ3Kykia9rL8+kxp1Kn58d+vr6ZvYhtOz0LPJhYUFPA7CUaKQcyPP7XCHFHZhaHdyn/AlUYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017



On 11/14/2025 4:14 PM, Sairaj Kodilkar wrote:
> So that both iommu.c and init.c can utilize them. Also define a new
> function 'pdom_id_destroy()' to destroy 'pdom_ids' instead of directly
> calling ida functions.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


-Vasant


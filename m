Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60A82882DE
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392902; cv=fail; b=Dy+IRvRsV8vqrwFaoShwmcvQlffMGQmZwSx4bkdhZu/VvlWB9DYZhUX2CuGAduwNEs0LVCbp0GztSemLqNuozqaw4wCoqbapfa4ngMeT72/qN++ZgZmHg2IoYajeD1yni5I5cO8GG8JdPeG76UwYvHBkkWVwa+DKZokb9ym2NWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392902; c=relaxed/simple;
	bh=PyLhX5MTBVUAjsiD1Ol4ztSDTj/sTY7eSMcLeMwFZ/4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BZ8ABEIf4YnOY3DEuCv9PDUsROwOee2iO0c/FQaa1v7lfhInvpYXUZu5tjOTSqzU1m6EKGwCTJ/YENSFyaFickyKJQk8JgUvaZSNYpxShajoAkFFVlXA2AHPMFXRwY/lk9NrITSsNuwxGAXxhICffEcg4zT4ms8CAexvJqs+atw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p+MCQbWL; arc=fail smtp.client-ip=52.101.52.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p+MCQbWL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTRUZOb4QyVD91J3eHmRrP4A8jF34g6ZI6urnpVl7NQhDjrcU6pv6B+aP+I9DPLTpp/VT0PqTqLEMI4Ca3Qr7u5TpiDSkWUzlkqtVC3YAGBOmApkzMfMrgofvnpA6TupOWkoqNbvbZCW+45gQo67MpkQgu5lnQAfgBcmn/JR+Xto0HWVycqrYltxeI84mWONnakEr0IWOOsMMTEmjNGL979RobOXnF4MACjoCdEFcA6ImnF1gIeqE6eSS65zFJnoNlig+k60PXyf/Y1H4pYmQMNkjML7HxSAcq+mKNDxXjGdzDMwAgh512V9i9jxJV72aRZQTKL00KiXGEfuxzk7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/7VEwJ3RD6VeOrgaAT54Lf6Ka60mMGyNbOkmJwKeCM=;
 b=ri4/V4JxfuBICtcEhed5C/4fdv8a82HYDpTlUuulP6cYhKdv6KXJzbAxh+Pe9caMymir/SSPrOqcJbuABW/iSKug0SY9y3G1pdggr9AnhjzPR2vG4rVVn6WtFWjQpefjKYHCaz7PQ6Fh9RXPa4JTcTvvzqCcrvgX+der4eu1dRRjmJXH+jWneRr6oYecwQU/uLSBOhBVAR6oNkGR5fwn8ugVi8KFlra+ZqDIaPZZjroAC9qBI8ADnA7/kxsUkm+aF2zt8HXdvAl7jd2hCOH4+t1aW2xrhQBqG6pAKDV3qzufGo/yEY9BFfIr1OqA9TuFND61A0nXvoxEYb293SNqGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/7VEwJ3RD6VeOrgaAT54Lf6Ka60mMGyNbOkmJwKeCM=;
 b=p+MCQbWLi+qj/owMeAne3iCXMKq2ORPX1qdmFLkomVOkG3Nmbhc/ziZm6LNBk5fMuVvG5tT+Gr7Urw5HmPZsB4JweeJlWLnjEMpcWo8BfCSbqrKivORZI689/cXDDfAhg0QvSnbvu9D3tJHk24Hdj8/2Oiu9uEwah4WgBuiu8NoBdJp07S2jYpgWB0lNF2FspJsxag5Yy74tGU1il4BgMTtUkAEXoEnPleYfL773Q1WE17b3UeEk2ATzDMx0SZKwUEY3rQAhXhEisqIzhHgWFyeO7dwDt7mJLafKgH9EKjqqlqaMI1P8/+vmyIawUWU/+SluwWOKh8/i8DT/vp1LyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 15:48:14 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 15:48:14 +0000
Message-ID: <5a69ec64-87ed-4b62-97c1-94ddd4ae1553@nvidia.com>
Date: Fri, 6 Feb 2026 21:18:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Daniel Mentz <danielmentz@google.com>, Sairaj Kodilkar <sarunkod@amd.com>
References: <20260126151157.3418145-1-praan@google.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <20260126151157.3418145-1-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0127.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::7) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|MW6PR12MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: 622287d1-8134-4ba5-8b6b-08de65972377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjZLa2hIRUlmMkM3NVl4eWtxQW82RzJlZk05UzlXejZpMTZCZTJKeHd2QTFm?=
 =?utf-8?B?K0pVMzJmUGFhMjNMRERqRWJXMWtGT25VNWVrQSs2MUZOTnY5aVg4UmRWQjlC?=
 =?utf-8?B?Vk9BK3c0R2FHZklwTVpDS0Q2bXRIdUZaNEYyU29rNHVTQ2RsQnBEcGRjWGJT?=
 =?utf-8?B?V3p5aWlialJlbzcvSGszNGpBTS9MOHM2TnNuVDR2UVZsanZObXBYVEY3dWwx?=
 =?utf-8?B?WFZQS3hNejlzdFZSb2RMdnJrY3owbUtZMHV0dTM2cjNZY05KZFFvSzZSdU9s?=
 =?utf-8?B?QWFoRnNLWStMS3VKVmxuTnF6bWxUZ2c1Q0xqZkI0aCtBcmtqLzV5bnBMVlZs?=
 =?utf-8?B?UEVheXVKb1Q5WWgvSklJeUxoWWFna1hlWU9yVEJZZWI0bzVrZ0tBaENqVjVv?=
 =?utf-8?B?QkdHRGloWGhkTFNOQXJtNkFSaXc1R2RjVGtreTNDRi9SQUp1djR5eEIrNzVX?=
 =?utf-8?B?S2ZwL3k4NDdybGxsQUtzM2xHcG5BZHkvckZUaXhxSjNHd1V1UjhzMVNNL0Zm?=
 =?utf-8?B?eGEzN1J1ZUFHdFlMTUVKWmpsNllQN1FiTi9IcjJ2aEhGQkozSFNwS0lYc3Bo?=
 =?utf-8?B?WkFkTTNsdG02b3hmYVBhYmZRUXhWcysyaUFMVXZmZHFUK1lyeDV2Z2l3MkJv?=
 =?utf-8?B?eXFoTG45OUYzNzM4dmU1VEtvbnN4a2hXOERyTTZVM2RQSkQrejVoeXRPeVBL?=
 =?utf-8?B?RXEvZDNoUVNlL21XREpLWlh2blRnbXV2U3NGUlp6eDNpTWI5aDkySTd5N0F5?=
 =?utf-8?B?SmpNVzdESzcvTjdpeEVpSlY2RGJxZ0lNeEMrcEVHK3hIeVRITnNtME5wWEph?=
 =?utf-8?B?dHc3blZKc3djenJzYkRTNUp6V1A4YzJNM2RYTFBzSG5DazhEWXZ5bWY3dWEy?=
 =?utf-8?B?cGhzam1BMjFEaHg3Y1lLNW9hMGRSQTdMdzdVM1l1YXBHZmJhVjI1aFRua3lq?=
 =?utf-8?B?RVRGeXVPMlh4VElJZm5BV3lybGJkenl2ei9PS0lIY0NPYWJqclpMTnh0NzF6?=
 =?utf-8?B?VjZhQ2VZYWVRSTBaRVpFMFZFNUZINmZCMTBXY2JBTU5UV3Rsa3VpSXFlR2pv?=
 =?utf-8?B?WGxNekFvU0FwQnNNTWM0WkZyMU5UWEo2dXcydVgyZWE3U2xpMUk2V0s4Wkxn?=
 =?utf-8?B?R1ZSbHg5Z04yTC9oMDF1UW9tb0pMWlJmOHBkWHRnbVo0U2d4QzZTU0p2cnN6?=
 =?utf-8?B?eUtPN1U4U3RFTlJLNWdWSEdCR1oxRml4b0xpVDBKUG52UXRtdkJPQlIxSXZ2?=
 =?utf-8?B?SDRNZUNHcllidGczL1p2RHkzY28vbnk0OWh3SVNVMGM1dEkvWVFvYVZnL3U4?=
 =?utf-8?B?OXdBNUNrbmhWZGlFT01yVERhc2dSMUxFZXpKb3d2TWZhazBkVjY3TmFWS0ZU?=
 =?utf-8?B?RnZpakR5aDdsTnllRkYrQ3ZQOTZDK3ZZMjJQM2JNZ3kyRzRoa0VRQnRHNVdC?=
 =?utf-8?B?UW0yVjZYb3FES1djbS9lbkxDMTA0WXZlcnhQOEZiR2RiMFpXeG1uekZ1ZXpw?=
 =?utf-8?B?dkp5a20yZTFrS1ZRL0VtM2pMOXI3c0JIWmxkODRQOW1DQXJMRVBDd2NQVWNq?=
 =?utf-8?B?ZWhqR0xuZDVoR3FPZXdjSVIvb3BwaUtBTWZyZlR2TGZONERzNW5hSkZFc3Fz?=
 =?utf-8?B?a0NHOERZdXd1M2gyZWw4V1pUZmdzZWxCeTRwZWZGQUtiaGRka1Q5cWlkQ0Yx?=
 =?utf-8?B?WHg2L3RRMjYvZlhTTVV0Ylk0NmRTamdMb2tWRW41SjFOeER6Qm94eHBqT243?=
 =?utf-8?B?bGxqak1DTXZnYlRwRTNYTnJVZ0YwZ0thMEE4dTVEank0M3VXOFY5eTJUK3lw?=
 =?utf-8?B?Z3dyN3lQWU9qajg0Y2tSd05EMmpUY01wZmlNUnlwL3I3UHIwUE9lRFdXRjgv?=
 =?utf-8?B?VFVRelRLckZJaEJ2aEUyQUZHek5waW5ZcXRDTVZCS0dockRRemI1R0NoTkth?=
 =?utf-8?B?emVhUU1vajIvbHB6cjRuQ2VPQ1d2Z1gzeGFMRFkybkUxNGI1cFJjRkNlUHpD?=
 =?utf-8?B?dlJtRmh2d25rOGhxZm1NdHgzd2sxbzhtVko0d1U0UVVTazdQSDNETDhkRnBJ?=
 =?utf-8?B?K1RPLzZoY1VPL0FreXVlQTJVdXVBcUlva0xoZDhmdDlQQjZta3BxNWhyNzIy?=
 =?utf-8?Q?cDXQz/oOU2w05znffUe/4Mqnf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGZzRkF2RzhMMTd1eHlkeXJUZXdKNHgwblhwbkUyQWh1T3VoelRMYXFjZFMv?=
 =?utf-8?B?bEVrcjNDeEh0MlNjRCtLN0lWSlVRc3JsYkIyc2pjSjkxQnh2dFdMSkg5dVpm?=
 =?utf-8?B?N3BSblBrRCtPUTNBSExIdlBqc1JyQ0hjK3hBMnNSUmdIVFpSSXg5VDc0em9h?=
 =?utf-8?B?ZjBQT1JWUEg0S1F6aDY2Vm5xdGFnNisyWkpFSGVCZGNNL21wQ2JuM3lBWEtL?=
 =?utf-8?B?WFd2dy9wWC9sVlJxckt4VnFWTDFPcDJWNVllem1ldzc3WFVybjc5ZjVBZ2Rt?=
 =?utf-8?B?TTFFbzErV2F3VXR2czVsZlN6aXRsRmg5OGVXQjhrZENSczJFMko2aGE2dDhD?=
 =?utf-8?B?KyswRDI5d3dzWW5YRm9qcGRsR1hUZSs1TjdGbXhPYkdReHBPaGRBSXVSSDN4?=
 =?utf-8?B?am53ODQxaWgvSy9HOEhYa2h0ZXZUaGVQa2pyZ3M1dWpZc2xQVXU3cm56c2ZN?=
 =?utf-8?B?RmkwNW5vSzFkRDlPMUZabjdqY3U5cTFmVHhaQlBLb295cXkxL29ldFRHR2Rz?=
 =?utf-8?B?T2l3bjlLWEIxdThxczVMWlJudHp1S2F2clY4OFRvUzUwVkVONGZvTFVlcW9W?=
 =?utf-8?B?VnhNdW93a0VObGdkeWkwZ0RqSC8xcWhhZzZhK1hmcUczYjBSM0NUK3VSMzhu?=
 =?utf-8?B?QWROVlpYcVZWY2RMc0QzL1JzQ2RxS2NPTDZlc0F3eW9mN0JtRkt0aUxWcDBQ?=
 =?utf-8?B?QlZKSWpFNEtqbHZEZE1EUTNEOFRoa2tyS3R0ZTRTQVBJYnYxQUtFYU9xZ2Fz?=
 =?utf-8?B?K1lkTDJ2NytwTm1WTEZOYVhhWmkxWWVyQ3FVb3cveE9ZMjZNZTVwb3ZIVnkr?=
 =?utf-8?B?YWFXTVFjdGM2TU1zaFZYc1dnWmRDUHh0VDJkdmF1VkVCYlE4MmNJS28rQlpR?=
 =?utf-8?B?VlBhMzl0cFVDaUdlY3Q3UzBzblJZSkZvdkQyeFh6OXVSMTc0K0cwbUdaYVRH?=
 =?utf-8?B?VFhwUkZNSjl1RzN4UW9aVEwzL0dORHFZY2duR1VPUkYzOEV4Z1ZvYS9WL2Zv?=
 =?utf-8?B?NXRBTnRZQzlpZ1cvVUQ4UnlseEdaaFk2T1d0SEloN09ja0lLNnBqQm9KOVUr?=
 =?utf-8?B?bWJRVWdDQVlwZFhFY2Rib2N0OVRKVkN1amZrdnR3NVhESmJrYkM2Q2RSR0F3?=
 =?utf-8?B?S0FZYmxqRnhpL05Yemx6V25UMGtGZHNlYlFuQ1dTZnBLQW8zc1pweHVTa0Ni?=
 =?utf-8?B?aDNEdGlSV012akp6ZWVCczlwOGg2VG0yTWhVOHp2NEdPNHVlM3Zxa25HSDZi?=
 =?utf-8?B?WE54Y0szaGpxN2hhVmU4OVZhMzVGbi9mcG84aEE0VFVnTGxNZXRRMlE3OGpp?=
 =?utf-8?B?Qks2QlhkK0plcm83bFl0RDJTa3d1Q3JxVXlYc1pBSnhnZTJSU0MxdTRaOFNS?=
 =?utf-8?B?VmlRSkJrbWVLWmF0ckRmRzVuUXpkSHBySDJXZnkwZ25pR0FGNjNDZXlTOHlB?=
 =?utf-8?B?cXNIVnQzR1FjdXVDMUgrTmUzeHVWQjVrWk5XQ1dpQlU0UkgrYUN5bWkzTmUy?=
 =?utf-8?B?UXJ6MW56dXdUY3k2N3RlNUs1dkJUUHR2MlgrNHVLeGQ5NjdBYThyNklBZE9s?=
 =?utf-8?B?czFrSHBEekxMRDNyR05jY1lKY1pPb252RE9yd0ZNUERRZU1XNkRJTlBoWVZ1?=
 =?utf-8?B?a2U5VERIdWpndFJ5ekpMb05Mc3QyVjBZWE5ROUJKNUt1RUR6ZFRrdjJ2R3d1?=
 =?utf-8?B?blZJc05FYk8rQVRlcHpqNXBveW5JNWZaejFINkJqVjArcTNSQUpEYkc0YU90?=
 =?utf-8?B?MWRjUXBpQkh2c2l2dnNSaE94UTdEZTQ3aHZsdk10UjJGOWI1SU41UXlhOEVZ?=
 =?utf-8?B?UTJCZEtrb21KTzBRZzZ2Z2Z1cUhyMG91R1NFYVowY1RBZWtBcXJhNGFYZWkw?=
 =?utf-8?B?REhMZFZ1d01BdmF2bXo3aUpBcFE5VkJuTGdGajNDYW40RUd6NC9hRkx3bTRF?=
 =?utf-8?B?aTlEbmw1cW5GZFIwS1UyUHJWZUR0bWM2WHZlbkg3MVlZN1JkN2loMUhWSUVP?=
 =?utf-8?B?bFpiNm5iMTVhR3o3UTFSdU5veUxCbnRodDB2cnhJeUpkbWIySCt3SnlkbjBz?=
 =?utf-8?B?czg3K250Yjcxc1ZWTlFpS0JPMmNLWjZYY2tlbHNkWVdSdThQcG5hMDN0OGN1?=
 =?utf-8?B?S2syZWswNVRIWnowQ1NoWGhWTzZjUVpvdnRyR1MwMUs1UXBucVAwbGtTVGlu?=
 =?utf-8?B?Vm44RGgxTkh4MWs1ZGdrRDlXTnFzTEZpTTc5NDN6L3BBR1VxT3V0OWhqd0Jy?=
 =?utf-8?B?U3NzMG9KMlVtdDVDZGQ3WmZ0SllwdlBWUFZ2VkUra24xUXFhOEZUc2pXMHZw?=
 =?utf-8?B?UjhXK2JhbHpnSzdQK3F0MldHbGxjQnR3cHJiSENPSlhiejJseXgvUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622287d1-8134-4ba5-8b6b-08de65972377
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:48:14.4982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4ssfVJTmgxvKG4xXA9sSVI5Ed9CoANGyplY4VGuuV5gXcZV34Bco3CfuQGfMI75JNH7aGBqvMO4/K4OeF8RqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017



On 1/26/2026 8:41 PM, Pranjal Shrivastava wrote:
> External email: Use caution opening links or attachments
>
>
> As arm-smmu-v3 rapidly finds its way into SoCs designed for hand-held
> devices, power management capabilities, similar to its predecessors, are
> crucial for these applications. This series introduces power management
> support for the arm-smmu-v3 driver.
>
> Design
> =======
> The arm-smmu-v3 primarily operates with in-memory data structures
> through HW registers pointing to these data structures. The proposed design
> makes use of this fact for implementing suspend and resume ops, centered
> around a driver-specific biased usage counter.
>
> 1. Biased Usage Counter
> To safely manage runtime PM state, this series introduces an atomic
> `nr_cmdq_users` counter. This counter is "biased" by being initialized to
> 1, representing an "idle but active" state.
>
> The suspend callback waits for this counter to be exactly 1 and then
> atomically transitions it to 0, signifying a "suspended" state. Any
> other value indicates that the command queue is in use, and the suspend
> operation is aborted.
>
> Code paths that submit commands to the hardware (the "fast path") use
> `atomic_inc_not_zero()` to acquire a reference. This operation only
> succeeds if the counter is not zero (i.e., not suspended), effectively
> gating hardware access. The reference is dropped using
> `atomic_dec_return_release()` after the hardware interaction is
> complete.
>
> 2. Suspend / Resume Flow
> The "suspend" op now polls for a short period (100us) for the usage
> counter to become 1. Once successful, it configures the GBPA register
> to abort new transactions and disables the SMMU, EVTQ, and PRIQ, leaving
> only the CMDQ enabled to drain any in-flight commands.
>
> The "resume" operation uses the `arm_smmu_device_reset` function, which
> re-initializes the HW using the SW-copies maintained by the driver
> (e.g., prod/cons pointers, queue base addresses) and clears all cached
> configurations.
>
> 3. Guarding Hardware Access
> Instead of eliding operations, the driver now ensures the SMMU is active
> before any hardware access. This is managed by `arm_smmu_rpm_get()` and
> `arm_smmu_rpm_put()` helpers, which wrap the standard runtime PM calls.
> These wrappers are now used throughout the driver in interrupt handlers,
> TLB invalidation paths, and any other function that touches hardware
> registers. This ensures that operations are implicitly queued until the
> device resumes.
>
> 4. Interrupt Re-config
> a. Wired irqs: The series refactors the `arm_smmu_setup_irqs` to be
> able to enable/disable irqs and install their handlers separately to
> help with the re-initialization of the interrupts correctly.
>
> b. MSIs: The series relies on caching the `msi_msg` and retrieving it
> through a newly introduced helper `arm_smmu_resume_msis()` which
> re-configures the *_IRQ_CFGn registers by writing back the cached msi_msg.
>
> Call for review
> Any insights/comments on the proposed changes are appreciated,
> especially in areas related to locking, atomic contexts, and potential
> optimizations.
>
> Note: The series isn't tested with MSIs and is weakly tested for PCIe
> clients. The same holds true for tegra241_cmdv changes. Any help in
> reviewing and testing these parts is much appreciated.
>
> [v5]
>   - Refactored GERROR handling into a helper function and invoked it during
>     runtime suspend after disabling the SMMU to capture any late-breaking
>     gerrors as suggested by Jason.
>   - Updated `arm_smmu_page_response` to be power-state aware and drop
>     page faults received while suspended.
>   - Included a patch from Ashish to correctly restore PROD and CONS
>     indices for tegra241-cmdqv after a hardware reset.
>   - Collected Reviewed-bys from Mostafa and Nicolin.
>
> [v4]
>   - https://lore.kernel.org/all/20251117191433.3360130-1-praan@google.com/
>   - Dropped the `pm_runtime_get_if_not_suspended()` API in favor of a
>     simpler, driver-specific biased counter (`nr_cmdq_users`) to manage
>     runtime PM state.
>   - Reworked the suspend callback to poll on the biased counter before
>     disabling the SMMU.
>   - Addressed comments for the MSI refactor.
>
> [v3]
>   - https://lore.kernel.org/all/20250616203149.2649118-1-praan@google.com/
>   - Introduced `pm_runtime_get_if_not_suspended` API to avoid races due
>     to bouncing RPM states while eliding TLBIs as pointed out by Daniel.
>   - Addressed Nicolin's comments regarding msi_resume and CMDQV flush
>   - Addressed Daniel's comments about CMDQ locking and draining
>   - Addressed issues related to draining the evtq and priq
>   - Dropped the code to identify and track user-space attachments
>
> [v2]
>   - https://lore.kernel.org/all/20250418233409.3926715-1-praan@google.com/
>   - Introduced `arm_smmu_rpm_get_if_active` for eliding TLBIs & CFGIs
>   - Updated the rpm helper invocation strategy.
>   - Drained all queues in suspend callback (including tegra241-cmdv)
>   - Cache and restore msi_msg instead of free-ing realloc-ing on resume
>   - Added support to identify and track user-space attachments
>   - Fixed the setup_irqs as per Nicolin & Mostafa's suggestions
>   - Used force_runtime_suspend/resume instead as per Mostafa's suggestion.
>   - Added "Reviewed-by" line from Mostafa on an unchanged patch
>
> [v1]
>   - https://lore.kernel.org/all/20250319004254.2547950-1-praan@google.com/
>
> Ashish Mhetre (1):
>    iommu/tegra241-cmdqv: Restore PROD and CONS after resume
>
> Pranjal Shrivastava (9):
>    iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
>    iommu/arm-smmu-v3: Add a helper to drain cmd queues
>    iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
>    iommu/arm-smmu-v3: Cache and restore MSI config
>    iommu/arm-smmu-v3: Add a usage counter for cmdq
>    iommu/arm-smmu-v3: Implement pm_runtime & system sleep ops
>    iommu/arm-smmu-v3: Handle gerror during suspend
>    iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
>    iommu/arm-smmu-v3: Invoke pm_runtime before hw access
>
>   .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  10 +-
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 429 ++++++++++++++++--
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  13 +
>   .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  29 ++
>   4 files changed, 445 insertions(+), 36 deletions(-)
>
> --
> 2.52.0.457.g6b5491de43-goog
>

Hi Pranjal,

I have pulled this series and tested on Tegra264 with CMDQV enabled
and 16 vcmdqs assigned to guest. I ran multiple iterations of system
suspend and resume with each iteration following by SMMU tests for
multiple client devices. Everything worked as expected and tests
were passing.

Tested-by: Ashish Mhetre <amhetre@nvidia.com>

Thanks,
Ashish Mhetre

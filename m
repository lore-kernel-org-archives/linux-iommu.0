Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2B156C72
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688805; cv=fail; b=ddLWRHsfc/K2jgVfvGYeqRc8fpBFxwrpE5WvD5O8E5t6Ybnsfslablm7b2m6RHnmy4rYf+8otnSBMpKXrW+lM/klQMv6Tcpk5uYyO5lOEjczHXx84uD00iQTX9/W4WaieLa93JCgj1mHqcfrYRRX18DdoYXxHO+V16ycIAXrjQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688805; c=relaxed/simple;
	bh=Sn9Edz9iEBAanvMAwoYItIjIpSqDy52oW4JzF7vMNcI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JVR8ycKL1/XJM2UOw256rg518ViEv7s3/0FP+ivOvrzdmQtFTNCz49ybM/axTvkQhS0z4X17+jRYq54ZOctJYy0snDQjHWIx+z5oJzErEMcTSNHvYDQStHbrAPUaKgdUyGcrwSAykba3mx7suRs2qQJC55YCgW7nmUZ/9PcS4G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iD+Bn58M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jkz/vW8e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iD+Bn58M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jkz/vW8e"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBQcUv016708;
	Wed, 23 Oct 2024 13:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Mqd3iMZI77kOLLM6PIRTFTVEw8MOt/DVY5qtIsWhCWE=; b=
	iD+Bn58M/lB6jy9QBN/nM04FGNQHY9nlskmY+lPb3S9TILfCFIoLo+q/t8umRTUS
	04jilUcNPJyMxVkOmIXvgNUP5Eb0SIFUee65POSLeor1Sna/D9zOwJYttQu4LeQH
	6QeUCLIzOyX/trmsip7OOQRExYTdA4ScAQioi6emppASVy+UaQrl4m7Ivo56XEsq
	t9mEIvN4O7im6ZUP21CwASulwjr9w/pe/VfEjcBb0oRRLUN626RYQevr9JbYmhle
	LY8ZD31/IDQ+g7L5OcOdV0s1ut1GuA4BHz7T6QIi4pZhFn4ETytTJ2WrOyV+UQuN
	ng46+U+DL22AFJzTlRzJmQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55efydb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:06:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NCML2c027343;
	Wed, 23 Oct 2024 13:06:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2t1nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:06:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hnfr9rAYtikNf9Ai0fxltlVQrdlkbTLtrAIS02oCl0KQkayirQBvYGtAuPY7urLWxseB79kixrK90zxr32ztsujBZXYUL8FAkqxa2qZsEjio0L0ZFLwvWPU4JFM9evD/Zmx3QSVsTq4fpdzlyT+MIKr+2HIioS5W0+DpSsbYoUTwBwyANUE1Cv9ouTF3cOplAvR31hwog2zqWNA4ZvXCxRWisiE+KOWOdTuOgOVtep3kXS9SB8b1gid70odyPF8feFwsiHB7ByiVycXAG5+U5tbECseUZeXkLfAk3J37nTmmphcBHyRfKNEkssub7+DrwlCyE9rJ1An6rR4mMcKvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mqd3iMZI77kOLLM6PIRTFTVEw8MOt/DVY5qtIsWhCWE=;
 b=W/3dBzlLHpHwUzavHR/j8Hne82kVJJrUVZVRXzblFNM6g/kYjc2KT3UJmj6Gr0sAC0uYxDVm3QHcacIFCamhmgqh3tI0QMVmhCRqxYNUcatFSXCXB+U5rNWdntWZNJ+e0Gp/ho8gvJ/uMDs/H+SoWcd4LViEzfCeWU6bJLposHH3ykgvOENYB77drTiSGBYDCuYtugg5uZVcTb3ov29DMDrEVbKNcZn0jtS/EJJNmcL5NGPvNE6qbn0qRnLIVF4UYdD1K3fzdoUviKFy2J31tn6FKDIYLm02Quf9H+5dGbMJCAmh9I55gaMFAJGr/p09edwzRP90nQYqJ6/xA/3bBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mqd3iMZI77kOLLM6PIRTFTVEw8MOt/DVY5qtIsWhCWE=;
 b=Jkz/vW8eW6/dSz9Wstjuku/XZWZzR6OSqgXAMCXVQbZ7xmDYIV6xwduMGRJfK0pDvI6tIwO6KkKydCXyqOn2SXU6eDX8/5x7kz/QqMhriaucZ0r5xtgABMSFMthIUqSasszPCEEa8LwS27FU6I0/fsIWOJ5SDj7WlDr5sqWBTTM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4499.namprd10.prod.outlook.com (2603:10b6:303:6d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 13:06:37 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 13:06:37 +0000
Message-ID: <30ee29e0-09d3-4a44-8ab9-de6326e3e29b@oracle.com>
Date: Wed, 23 Oct 2024 09:06:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 6/9] iommufd: pfn reader for file mappings
To: "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-7-git-send-email-steven.sistare@oracle.com>
 <BN9PR11MB5276252C632C19F2647EE9D58C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <BN9PR11MB5276252C632C19F2647EE9D58C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0093.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::8) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4499:EE_
X-MS-Office365-Filtering-Correlation-Id: 1088cec7-aa5f-4b8f-888b-08dcf3638712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDlNSm96UjBpT3k0Qm1DL2JjelZSaDZWdm4rVkdVa1VrRndZYk93RmMvTGs3?=
 =?utf-8?B?eFRIdUxyUm1GWk52UDMwNUdBWDFYTW1FTW01SXhKTVFUUHFkUGg2ek00WjFX?=
 =?utf-8?B?Z0E5Wnhhd3M3RFhQV202ZVpsNExlWmU5d2xiUkJTcXJQMHNrMmdDY0hIYTBa?=
 =?utf-8?B?WkJNWm9mZmxncmZDRnoxRkZudDNmY21qYWljWmpDWis1Q1BldytlYTdsNWN0?=
 =?utf-8?B?UVBoOXZlRENOYWllRWh0SUZ0R2N1TkRqSytoNGYzeEFiUTJhRGZYY3JraEdQ?=
 =?utf-8?B?THp2bmFWMmRTUVBJblNwMHNwMU1kU2Ziem81cG9PL1U1WjFZYnJidEhJMHpB?=
 =?utf-8?B?ajJlRmpQU0lLZ1RSMHpXUnZ6QmhDM2xwZkoycVRZQzJqNHRnQjFuWFYveUJ6?=
 =?utf-8?B?V0Vnd245RTFIOUdIZzR6Vm9YSjcrSkpjOHo2a2pHZDRGTzhZa0Q4YktqRHQ1?=
 =?utf-8?B?dld5b0I5VEtGNXo0ZW5TdWh0M3hZc3hFME44eFB2ekRKR3drK2NtM0IyMmFq?=
 =?utf-8?B?L2ZTb2NudVpmK1VQOFFMN2JjNmRIWFIySnJlQU4wa3gxaTBjRmErWXRDV2J6?=
 =?utf-8?B?VHhLNWpuVFJNY3BNUWpPb3ZoMzhDcWtWSWMzMFlwQlE0NkRhcW1TVi9QZXdh?=
 =?utf-8?B?cW1vMUc5WVkzVldmOHVMekhtekxucldNYzJIL3BDN0lZSVl0V0V0QThZNS9L?=
 =?utf-8?B?WmlOQ3dxcFI1dUJaTmlTRm5tOENsYWxucEVjQ1lmcVJ0TUdBWWhQRzZHR20y?=
 =?utf-8?B?Wkc4U2swWUxVaHo2VkFFVkhYUnJ3Z3hOMURaUmQ3M2FYYUl2MSthVFo0QjN0?=
 =?utf-8?B?VHZvazU3KzB0Ykg5Sm83ZXJwdCtucXlUa0U2RytBa0IwZkUrWnE3RGJJcXVO?=
 =?utf-8?B?bmgrWkd1NFZxZ1FZeEg2M2N4VThQN253YmE2dW1iVVM5UVAzK1F2UnB0bHY0?=
 =?utf-8?B?Tk9qY3RYZ1M2MlVEUVgzRCtBM05uVTErdFU5RUZRSnh0eUdxamVpNnE5b1N1?=
 =?utf-8?B?bFplMitjWW1VNXp6VUljWEZaWjcxNldRc3E0QVhoWjZ6bTJiNEU5YzRiZ0hR?=
 =?utf-8?B?SkhleUpFaHFsbVlEdXJiWVZVU1NocDUxakJtTXZnTzhvY0ZuQ0l3ZDlTRnlP?=
 =?utf-8?B?MUk4WFR2MjN2SkJ5WWRHeHFsTlR2QUNhdlJWc0srQitaUWxtVDg0bkVzdEtH?=
 =?utf-8?B?UzRYREUxdmJGakF4aURvNVVQTlFxYUZ4Rld3a21JTmVid2ZxYksrTzB1WnFq?=
 =?utf-8?B?OXJXRWFidHZMSVR4N3BEZjFUWllZbjViWko2UXNBY0ZOdERYVXIwSXRRMzhN?=
 =?utf-8?B?Qk9tQS8rTmxuMURpMmxpckZya1ZrRUYvYXBCZ1hMaGRVZk5vWjJEdDMybTNq?=
 =?utf-8?B?QmtXenBGSUN2VDUyVnpYUVd2WVZBV0FOcVBtdnAzNzUrQXlmYWVEV2NFZWt3?=
 =?utf-8?B?VG1GUHhjTWtRNHp4S1Z2VWErZGJSS1pRTGIzNXIxaE5LWUhaRUJJOXdGZ3hF?=
 =?utf-8?B?bDFXYnhIOC9pNG9Kd2hHa3JmczhoWFIyTVpZUGhYU0pQTEh1Mm5yTVlCbzBz?=
 =?utf-8?B?cEtHSE4yL1dmaGROMFBWcXV6OHdhSk5uUnJNQjlEVGRWNUVOTVFhczNySENY?=
 =?utf-8?B?SUJDcmc2WEtXU1FuMFFxZkptdkpyZFZvMWdpZDBVT25sWE56ZlllYU0yVElt?=
 =?utf-8?B?d29wQkVJQVFoOEp6MmZDZk9Jb0d0cTBrckFMalU1amkwcEhDY1JxU0VrNk8v?=
 =?utf-8?Q?AxMSm2pujACzWbj5Ls=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmI4akRHMHlhaVpRMTRRTm96cXpKL3Rja0w5Rm5WenZIcTc1V2d0WmphL2RB?=
 =?utf-8?B?MUlCZm1wSGNKMWMrQkIxaGlJQkQ0eUx0Y2EyRGVXdGFteGhQUjVHOUxQQWdE?=
 =?utf-8?B?d1hKYjEyelE0eHIyMTBDMlZQMVZEU201R1RDUDB2TEE5YWk1YjRZejJIdGhR?=
 =?utf-8?B?UEFEaXdJQnFjRjVrYThLbitnVStOSmZYbVZLR1ZQMmVudDVjRDgxNUdHTFhr?=
 =?utf-8?B?RmpSOFlFRWExRGhoanhmMitVMXA2NUpjUU1ZUDBQd0Eza3FYV0ROQ1JtQnlN?=
 =?utf-8?B?bHNDZEFPWHhLR29mUUw4YnBYdjA5dXpiZTR5R2Y3UnRBWHdwVE9CakJvM2NS?=
 =?utf-8?B?a3JEdG9uQmlJVVZjOUdhNFV2TjV6Mmc5WWxaNm9GNzJvNWZRVGJWaktUWG0v?=
 =?utf-8?B?bksxa1RwVHhXMW44cFZwR3g5SjdwVUJJNGZiZjJqZFV6VjBaYlNaWFBhUVVl?=
 =?utf-8?B?c21hV1F1RHhtbGhTN011YVR6Q0lDVUlNUndVNkphTnFCYkhGMHdZemYyVENZ?=
 =?utf-8?B?OWMrSUUzSUwvN0NyamJjczY1ZHJ2UU1zQWVpUVFkM2o0ZFNjODNaSklvYXNB?=
 =?utf-8?B?RTRXbThod1Z4N1N4WFp6T3Jwd1Z4NjA4aDhqZlZEVHVpRWJTTDZYdnZYRGdK?=
 =?utf-8?B?VlNISG4rVkxDZ0Job1A0RlVLNFBLUnd6VW9sd2JyYjhCT3NSVDhZcHBZRlE0?=
 =?utf-8?B?Rk9NNjFDMnpyNldibC8rVFM5Z251WElkTGVmSDd0cHpUU1BGTnZsOHJEUWtF?=
 =?utf-8?B?TTdUM01UeFFodHZHblRnbHVXNFZEVUR0QXZtS21zY0lmR04yNW1pbWU1d0Nt?=
 =?utf-8?B?N1l1REx2bG9HWVZjYWxaTFd5ZWVGVnpvM0FGVCtKZ1dPSUJXYmxlRk9MRGVX?=
 =?utf-8?B?TEZtbmNWVGNGL283UG8vU2JOU25BY0x5Z01SYk5GVFBKbi9LYXFRUDRxcVJn?=
 =?utf-8?B?ZlRnSGxVOW01SnVJWkErbGVLOGVlVG1nU0kzcGZSemRDR0MwUjN2N2NTZXh1?=
 =?utf-8?B?NUc4dlB5UUFaME50eG9qcU1tNGtDa3dpc1p5d1Q5bUY1cmI5czczYnhXRjJD?=
 =?utf-8?B?N2xneEZSNCtadndKc2dVbmlweUpWcHU0T01oN1FxdmVDZ1ZyOUtYSzE5dnYz?=
 =?utf-8?B?bzMxdXNqd2s4bnJTOHRjOFhzbGN6cmFoYmRiVHhSaG45eEVQVDNXaC9NWTJ2?=
 =?utf-8?B?L1AzeGN3ZmswbnhzSkJ6ekZ6WWp5YkN2VzhYV05UYkZYZFF6UWI2eWxRQlhN?=
 =?utf-8?B?OHZtT2J3TzNjV2gvWGVZck9aUVZPcS81WVJoV3EybnZnYXN5Z0RxQkQ0U1pq?=
 =?utf-8?B?eVNzbElzc0ViOXZ5akFIUzRhRWZjeUtiL21WOHllZit0bnlpK1kwa0FjMVE4?=
 =?utf-8?B?Q0I0V0ZzS1I2VUJkbnNJNmZYbm9xd2JPMmw0SDZNQnIxVUtETVBrdFpRNy9S?=
 =?utf-8?B?Yk9idW5xSTlTdzc4U3RJbDhvbzR6Rks0dVBMU3NsbTI0WnZZUVVIZ095b2lS?=
 =?utf-8?B?TnIzQ3JrTDhOVWdSYVBjSTJTRGpDeVFEMkxZZkkzT1IrZFNVSDUyeEtJLy90?=
 =?utf-8?B?T0ZFQXBCdTZZUVZxNDlGTlkyMXRXcEVGTTkxMHFGdXZFSStTeEFNL1JnRzZt?=
 =?utf-8?B?akdtZzZoVnV5c01MQmRUcjd1UDBuVHhzeFlIb3YzOGNFWGxsNkM0TXFWRmNo?=
 =?utf-8?B?KzVkeGNJZjNuOXpFeE4vd25QZ3RyKzA1NXRxeUJidXBtanJZL1NsdmF0Skc0?=
 =?utf-8?B?OGMrV2gxam9hc203VFFHcHRnMGZnTDRVdi9PRXpBRFdFUXVxNlRFUFRQd2VL?=
 =?utf-8?B?aUNXUjY2VUxYYnZobm5xU1BtU005WDByVlVVNktGbmZIRG9xWUV2OFAvODdC?=
 =?utf-8?B?TnNSUXRDR3djSXprMVhZSWZ1YWQxZWF2Q2U3Y1gzOWdqKzlNdHpqdEpVMllY?=
 =?utf-8?B?UTFxRW4xcjMvNzAyVnNsWGp6UHlHQ211YjZHZ3BXWkhoMThCbnNFK1JqNWEz?=
 =?utf-8?B?RDRVM20zdEhEcTRaSi95ZWVxMG1WdEVvQVk1VXd4aTUyRDR2VW5CaFpIZUtI?=
 =?utf-8?B?MVRud2RvNjhHVzZuM3dUN2pmbEI2UkxqNUdLK2FUdkhzR2dsZ0lnTk1mcnNq?=
 =?utf-8?B?azAycjhsR1dvWGZMNFhtOFdHV0ZTczdLckl2SjNSa3pSbmZRNDVtcFRrZkh5?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/Rqsnly3FLU93K4C0NV27aCJ17kuqdEhGLCnPjiKCJNpKBL5bCWCB4lufbQBmTADpyg5MhnqdRdSyMZfKFu3tTo5QBK44ca8MTCdEbhrQKIboDidksK/wMDTX60k8ZsEqDnNsl0G4xINRYRaows5MULLU1TTnQBRjmbCp8hOVfRKIv5Zi53Z808y8UhG7gW3di5NfDuUslrpj5uc2oXOLEzZbKOOPYVg9HNsy4aTs5PMUPrbR16FT0m4LMElewR3O50V/NAgHnLp/vprsQzUN4s+5BgJ3faNgb33zedH4SAl7wcszs2RnrUrmXLvwJ25QVS5lOrM4CpDFjZTOfYIvPNlnQE2yLcJbiDZS28U8ynDN4W6vQ3bbpB3c1iSuC5DawHfiV6N5Kpyvsx0Yy05xSTJkvuKQiDFasiSaZW2X1E8PX+f95nzBbaZ+30hfbblkpxH9fUF1RKB1hPhFJXTu91CVp3aLPXpckV+uIG9aWqJ1wqrX7KvuY75gRrLqmnT43OwBxc9ixRACFlsbrkzhJpwmDxNUwFUSJAndJvT2LqffocAb3zIcXS+HFycKRMSTIO/qda7TSm6w/4qVHcumjBkqsL8NNGu3p0qwSWyLv0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1088cec7-aa5f-4b8f-888b-08dcf3638712
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:06:37.4868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7llN/w0Ycahr3dcHr7jNOVjOrjFPuaWeAVecdMexNEHbnYBmr/MciYx7c9hYY9RjwyQeDJueg4Y+J2z+TympHVxwRsXr0F0ktyx4zgSLQhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4499
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_10,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230078
X-Proofpoint-ORIG-GUID: M4UIF12-FSOH1fMRJIrbNcmHBsoh6lnr
X-Proofpoint-GUID: M4UIF12-FSOH1fMRJIrbNcmHBsoh6lnr

On 10/23/2024 3:40 AM, Tian, Kevin wrote:
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Sent: Wednesday, October 23, 2024 5:01 AM
>>
>> +
>> +static long pin_memfd_pages(struct pfn_reader_user *user, unsigned long
>> start,
>> +			    unsigned long npages)
>> +{
>> +	unsigned long i;
>> +	unsigned long offset;
>> +	unsigned long npages_out = 0;
>> +	struct page **upages = user->upages;
>> +	unsigned long end = start + (npages << PAGE_SHIFT) - 1;
>> +	long nfolios = user->ufolios_len / sizeof(*user->ufolios);
> 
> reverse Christmas tree
> 
>> +
>> +	/*
>> +	 * todo: memfd_pin_folios should return the last pinned offset so
>> +	 * we can compute npages pinned, and avoid looping over folios here
>> +	 * if upages == NULL.
>> +	 */
>> +	nfolios = memfd_pin_folios(user->file, start, end, user->ufolios,
>> +				   nfolios, &offset);
>> +	if (nfolios <= 0)
>> +		return nfolios;
>> +
>> +	offset >>= PAGE_SHIFT;
>> +	user->ufolios_next = user->ufolios;
>> +	user->ufolios_offset = offset;
>> +
>> +	for (i = 0; i < nfolios; i++) {
>> +		struct folio *folio = user->ufolios[i];
>> +		unsigned long nr = folio_nr_pages(folio);
>> +		unsigned long npin = min(nr - offset, npages);
>> +
>> +		npages -= npin;
>> +		npages_out += npin;
>> +
>> +		if (upages) {
>> +			if (npin == 1) {
>> +				*upages++ = folio_page(folio, offset);
>> +			} else {
>> +				int rc = folio_add_pins(folio, npin - 1);
>> +
>> +				if (rc)
>> +					return rc;
>> +
>> +				while (npin--)
>> +					*upages++ = folio_page(folio,
>> offset++);
>> +			}
>> +		}
> 
> dead code as user->upages is NULL for memfd (echoed below)?

user->upages is still used for mediated devices, assigned in iopt_pages_fill.
upages is filled directly, bypassing the batch.

- Steve

>> @@ -796,40 +865,50 @@ static int pfn_reader_user_pin(struct
>> pfn_reader_user *user,
>>   	    WARN_ON(last_index < start_index))
>>   		return -EINVAL;
>>
>> -	if (!user->upages) {
>> +	if (!user->file && !user->upages) {
>>   		/* All undone in pfn_reader_destroy() */
>> -		user->upages_len =
>> -			(last_index - start_index + 1) * sizeof(*user->upages);
>> +		user->upages_len = npages * sizeof(*user->upages);
>>   		user->upages = temp_kmalloc(&user->upages_len, NULL, 0);
>>   		if (!user->upages)
>>   			return -ENOMEM;
>>   	}
>>
>> +	if (user->file && !user->ufolios) {
>> +		user->ufolios_len = npages * sizeof(*user->ufolios);
>> +		user->ufolios = temp_kmalloc(&user->ufolios_len, NULL, 0);
>> +		if (!user->ufolios)
>> +			return -ENOMEM;
>> +	}
> 


Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C54F2AD13
	for <iommu@lists.linux.dev>; Mon,  5 Aug 2024 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722884473; cv=fail; b=G/0/OFwtMibZ9VdFG5TCY3vnqXpYoxt4n69LUqusBy+l7KhF/RoSpgwyxYm66wgA4D4m8MYC/AYot3NkkmmhExOYGs9BuVnpKMdgWTbyJOQ4vWidfMHTUcvfExcebcP6gE346Ke3EOf5Rmvo2u0VeHIBqybAMOR96/Z8hdhjoCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722884473; c=relaxed/simple;
	bh=ZXNpTZRv0E/8uFJQOd7FbEJRnIVbJ34JmM3ewHAE9rc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VlJcFZIyqznViy74O0I9G+THmTJe/bqsGydS2dOE1bLAZqDT6/VeCwH4BTNErHzZ3cYNe7nYTTIEnPFz38GM1pV2hAJP5tgjV5cy+R47gFvQ7o47QMhU/RhEC5htzSCOMB1YxAHe4lH6smX8Y+PBJ1+ZzwbrW5Uxl3wj3GrbYp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AwAesiUj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ilMuRuo0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AwAesiUj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ilMuRuo0"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475GtWvE013529;
	Mon, 5 Aug 2024 19:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=0pmPXkZ0YZM11BCrp7J34LQU9/C938Ib5F3AN9Hpepw=; b=
	AwAesiUjPrMKiC+YsDy9W9c+nH8OmPJvdHdNJhMqSPTRZgslRvw43yVUkL71dyY8
	dqZGk51xoH1YRDBq7J3vP2OMBRQxBNI1o/p8WK/wtNC194RhULXnRmK6pNGcUoLz
	VxRSMf67TSzupUE9/5iSEeob/sb5Om0cGwzTB50e1gKZ86U65gPTp+66k6kmsz96
	CoA/vuaQR607ctilu9wJHESRJZLXQtkvS6r0Oo1WHrg8Puo+2/abD+qRk2S7xXwb
	bdwNlqh18CyQ5ap2o+C8x6ISe9i+1Q+E2FWtfYROGrqcARNMdI2bmbCv+6eQ5Ygs
	x3BZ8yXSdcbPr4kOdLhWTQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfakff0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 19:01:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 475IDNPo035058;
	Mon, 5 Aug 2024 19:01:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb07tjye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 19:01:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xxku4yxb4DT8FamANxR/LEF/EWxe1Yy2isA3EM5dS3av0yxGXP92ZZ95vmOM2Av/b3vnLsXS+LGh+LJhLsrwatcF+oOFBCn63tAb3yJ8c9KgmWR57RzEz1GJC1SGTxbYJwgGvw/keLbO5WFlc30Vgqe+gZlbfglg7fUflyOhJ2ndyvRmH3g9MPLA84CXZNUkEHXH4seCxO9ype5lHcGTpTdG/9P84juaZqu8PFTNOxEtGMOc1Hfe9KZs0+L++voGc5WVQ7clLNPvnh7ryJFjLb703h99P3MIQOMfIyo3ZAHiarbnqjjlhU6du/CsEqg4z3ZicGo9YEGtPkyVK281cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pmPXkZ0YZM11BCrp7J34LQU9/C938Ib5F3AN9Hpepw=;
 b=vVYet/Tp06GLHmbNkwyeX6EZDx8PBIdFi6I3bv/2E7eGVEUSjkYEmg6Bk/2T/NEorFl1zaKb6o5XaVu7yTcYu8fEQS2zUhNRbqUnuNpgYAMG+WK13uAmivHnrBIcZvwH51F2jxuCVeOJtg5kM3SozNQ3QDAjraLr2zSk1a8v8VIYtjJHJQVpJx0uFluyddVNPqE20rFhuUWbv4AUqRu6GYT8lTyBv2g/tikFncMdsZEv3JMpdRG4G1iwQjnahwE9vglQg4smQ3p07J/wgrqahraWgEOJBRz36iCt2wyEjBWtD/K3O1JIL+oU4tCfFw2nYwMjaTWi0RSIQxUnChmidw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pmPXkZ0YZM11BCrp7J34LQU9/C938Ib5F3AN9Hpepw=;
 b=ilMuRuo0B91YYj5wkyduSNctaM0hn3Nhdr9FZW+CeY9oO/gWTJDKFwmnq5zsdBsEbXZM6jUgIouQITmSs+nhRye1yiTPY3zfOR8rYiLWaCpnKR7HAY92R/ZOP7Bu3Lbyw7UiFYf1vcqrz2K0TNWUyKUoCaQfg3Q7tgPgFF2U740=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB6021.namprd10.prod.outlook.com (2603:10b6:930:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 19:01:05 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 19:01:05 +0000
Message-ID: <28e86236-8066-4b1d-b201-5fbac645fc8f@oracle.com>
Date: Mon, 5 Aug 2024 15:01:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 2/4] iommufd: Lock all objects
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
 <1721501805-86928-4-git-send-email-steven.sistare@oracle.com>
 <20240722153711.GG3371438@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240722153711.GG3371438@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::43) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3da20d-ccb5-4f84-e174-08dcb580f54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGR0RVBlUGIzZFhoRXNWTUZBditDTzc4Z0FXU1VCNnBVcVVUWjVtcktGcVgx?=
 =?utf-8?B?SGZYaUpzSXhaTXFDOVQreUlvREF6R0JUVUYwcmZYdzJPNUFYaUpKZkxJbDNV?=
 =?utf-8?B?cE8wcys5OWduUEgxU0RzN0w2dEhJdm15MHg3QlRIb2p0ejExNk1reHBTRnNB?=
 =?utf-8?B?YmdnbjFUU1ZtSWorNHFaZ3NhNVpGb2EzeCtIaVRkVWE2Mkg3eEp6dm9wanFZ?=
 =?utf-8?B?Uk9VakwwQW9XdDdsZTdhYXlUbTQ1K0NWZHFWZ1dKUWY4NUp4V1JldGZiSnI0?=
 =?utf-8?B?ZEp0QitTbEZFeE9ITVl5cmJUS2RDdytRMHZCaWJ3RU1IaHMxbzZQUC9NT2c5?=
 =?utf-8?B?N28vOU10Zk00TDBXM002MnZKVXFmZ05ialkweGRnTm9iemJLSUlLRS9uaEx1?=
 =?utf-8?B?M0lVTXhqVVZDWTk5ZFBRMU5NcG96cDluWkhmWnUxVUlSTjIwNnpUZnFzdkt3?=
 =?utf-8?B?UmZWRzBnL203S3dpc0FOSnovbmFzVmlzOXVBTVdWWXVGeFFyVDRtZ1haU09V?=
 =?utf-8?B?SU5YSjU5RlFLbWtHcy9NOEFPN1lrNUYySWpJRWVUdmZ1ZVRiUlp1OTRsK0M2?=
 =?utf-8?B?Q0pxaHd6Q2pCK3Z1UDdhaUpVM0RqbEpYK0pZUkIza0FpNHJIYjBYTlViYy9G?=
 =?utf-8?B?RTNiQWZ5KzlYWTViMVJQTGt4ZzhzYkpDQWtrdldMOWJPOFBpcHNxTTJPRlZn?=
 =?utf-8?B?dHdyNkZhTGZadzAydDZ4YUNna05ZU2g2MzVXSEZ6SlhLRWplQWRnNkU2Mk5N?=
 =?utf-8?B?V0ovMkNScC9wN3pDWHMvV2V3eFhoM1gvVmdvUUtOWVJlUk9qanR0K0FTSW5N?=
 =?utf-8?B?ZEVxTjBhYXo4Y3FiS2NsVWNLN2VHaXErNGRlMitKT1Zjb3ZhMHdZajZwUGVR?=
 =?utf-8?B?VjNMRmdrTW5oR0ZndFBZdlpkUFkzMm1KMjgyRjBYNFVSZjRwd1pRRGtuV3Rr?=
 =?utf-8?B?Wll6aE1maHplQXQwV2tFQWRVR3pPZEZYS1V0NUcvSnpIVXVRS3l6QmNid0JX?=
 =?utf-8?B?OFZqS1RIRjVOMHFqU2pRalBXUzZxMWEyL05EQWhpRmc1Q0dzR1ppeFB4eWVz?=
 =?utf-8?B?QU8rODZwVEcvcTJmR3NkQkJGRnltVjM0QUNTdVo4cnZBWnNGT2o3a016RlJH?=
 =?utf-8?B?a25oTlczTmNjUysyU203VXR0YnVjU0lhSzB5U2JGL0JQc0tHeUN4djYwMkdK?=
 =?utf-8?B?aG9hVCtCZVJQZ2FGK3ZxbFJ5dUNpTWJUR1VYSkw1aklzeW8wV0E2WkhsNlJo?=
 =?utf-8?B?UkpvZkhxWUQ1SjUvNXlFSStSbmtkNUVWc0R4WTZzelB1dEV1a01ZRHJKTUI5?=
 =?utf-8?B?SU1rR25ZTk9zVEJuaUV1a0VnOE43L2ZsSlluYUpsNXZjb1VIOG1pQWNJQ0Vu?=
 =?utf-8?B?bCttSkZ2cFFWNDJsVHhFSHI5anBEMi9QaGkrUU5CcnoxM2pPMHdsakg3ajA4?=
 =?utf-8?B?eGFOUWpZMDhEcUk5N2pCWnpMNHJHdXd5NVoxZStUV25KTnhWU0h1Yjh1SXhC?=
 =?utf-8?B?L0wvMSs0MEtITVEyTHJjaHg3NFVXc1Qvc2NxSkVUdHV1M1pxWU9xK0FFZ0Zl?=
 =?utf-8?B?WlBMM2h5eHZCa0lZV1ZscDJxRzNaUDVOTjE1NnNpT2pyQ3dWMncwS011Vnhp?=
 =?utf-8?B?NVJlajhRbllaR0hsOHZ2RE5oNUtHc1FNTjcvbmRmNTc4UnhYQ0VJMjRQOXo2?=
 =?utf-8?B?ejNERFVMY09RYlJndmd0Vmx6TUZ2cnp1S2Y5dTJseG1vSHlxd1FqdkZiVjNF?=
 =?utf-8?B?cUtXcEM0S3VxK3owdVkyS2JjUnlvaDdCSG42T0RHNEJ4NWp2enRURUczV1Rz?=
 =?utf-8?B?dDRjYUx2UE5YbE9sTjk0dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXRFVXc1WXJzczJ4NFB3ZUxVeGFjM2tOZjMvSjZUNVlmRmhzUXBGNXk0K0c4?=
 =?utf-8?B?T25YNmlHeExVcGtzcmVhai81WDI3Nzl0bzhLWjF0djg2cVQwM25vSXRhVUNO?=
 =?utf-8?B?c3B5RXQrMnk3bFBXYUxkM1dhYVNyYVluL0FhWjgyR2lCV1BTN1hhZzJuSnJ1?=
 =?utf-8?B?S0MwaDdBcGxZOHRSeVRGc284N1FrRzBaMGU5TmRJQkd0ZVlDb0QwMUZkOUgx?=
 =?utf-8?B?cnRqOTRwSlgxWk1kWlZudG5Mbys1YTZncjhTT0x1MlJpakpKOERPUFBzZmUv?=
 =?utf-8?B?ckxXQkl0UWtnMm9NQnMvM0JVWGFvbEY3Q3JqYWw1ZEhKRkw1c3RnTU9KWFpq?=
 =?utf-8?B?SXVjUUNhTVR4UnFlTUdzZks0WWRjeU5OajRTRnhiNk50WHpSR3FMZGh5RU9C?=
 =?utf-8?B?WmlLbUtKRno2cmdqejRBOXcrL0lDbERYbEtVVjQ5ZCsxYUVDWStSQTBMbWQ4?=
 =?utf-8?B?NmpFY2ZlNG13ZE5tZHdZb29aRkpQYlJlN0xHSnJvZ0tYOGxjMFFrbmJUdWJ0?=
 =?utf-8?B?VW9QQjM5NW04L1lqTkN2ZkZldGdtOEhRQkd0Nnl3aTZaclF0bkk1WTd2YUR0?=
 =?utf-8?B?Nk8rbU1KaXB5dld2SlYvUTZzRWZiSW5UNW1WcXNnVkRvY2ptMGFLMVJSTk1w?=
 =?utf-8?B?QU5ZVVI4QnVRU3VJN2kxajNkaCt6RlAyRHlKNnBhUnpDaDBpUXlxcHc2TXNu?=
 =?utf-8?B?VzlhQ0NNSVhVM0dLQnVLOUdCdGh0SUhDanhHUmRxcHVzRzdOV0NOQ3hoTU9O?=
 =?utf-8?B?WFhJRm8wVjBGTEtiSnRHY1lDWW5jL2pzVFEzVmxUei9tR1l4Z1BzK3F3cUMx?=
 =?utf-8?B?b01VWUd6V0dBbGxBczdyb2hCNEhvYnZ6LzcwbXFHZE9YZk5JMHVXM2xQRXU5?=
 =?utf-8?B?ZjFuT0w2R2dhc0JaR0JIODlkb1UxS0lGYk12dTdpUHFwd3ZHUEIvQTFjV2M5?=
 =?utf-8?B?WWlQSXh4SVRXOFJsNkxZblRyV1I4Ni9peWRXZ1hJSkU1MWJUZUNhZmlYemVn?=
 =?utf-8?B?ZWwxeEVZTHRXWkRWVGQ4QitHZnVzTnhvU0lWbTg2K2FlaW9za0wrNkR2eVhW?=
 =?utf-8?B?dzNoM0lIZDZuRUZuQmcxcHRIUkZRa1VsMDRISSs2N2RkZ3c3cmFQTVZ6K1Av?=
 =?utf-8?B?MTc3b0grS0Z4aVRQRlFlalAxak1FTFV3eFE3QXprODFJcFdXYng4ZFZhSGRY?=
 =?utf-8?B?emZwVHJXdmI0ajJTUGVvNkpvY1Q3ckhPKzdhQWdlblFYb3ZYZGU4ODlpbDRQ?=
 =?utf-8?B?SWhOemRKMkNQd0J5cHFLMXNTMVAwY3RLL1F6VXJhOEl5Wnl6QUNrT29BSFpI?=
 =?utf-8?B?SXQ1SDRvUm9CR0FZdFJhTGVxcVlldjBvRkFreXlGbFRsdGw0RDNRQ2NyR2Vj?=
 =?utf-8?B?cGtMblZ3WTJ1QjhrbkFINjVGZUFCNGFUakVydlFWMTZIdmppZUZ3cFVDZ3lW?=
 =?utf-8?B?Q2syQ2lOT2syS3h3V0JwdFFROW5XVllCeiszSE01c2VrYy9vVjdPZFRGZEd6?=
 =?utf-8?B?aThGR3lrSzByOVZNcENyMkEreTZJOEFDR1RFcVNGZVEwLyt0QjExRVJtUVl6?=
 =?utf-8?B?NVY4ZkRqKzZuSnJwTWpaVFAvcDZWbmtHd0gwVDg2TU54VGkwZ01FNE1WTjh1?=
 =?utf-8?B?RnhRMzBhczBEVUdKZDlCMGxPNDByRGp4Wm4yK2JzZHd2Mlhta2hZWENZTG5I?=
 =?utf-8?B?aE9Nakw4L2h0Tm8wZUVUdWhZYWgrRFVkbytrYmxubCtLcUQ1bkVoZ1ZTUFBW?=
 =?utf-8?B?RDlqTExjc01ON3UzdG04a01mL01ZVlB3aExNRzhXUDN0cFNaQnFVTzEyVGs5?=
 =?utf-8?B?NEM5dFhNeFhLRUZWdW1HNEtvOG5zK3NYRzBnaStxZDFlU1JLSVluQlBPUFZ3?=
 =?utf-8?B?YzdQVEVoTExiVFg3QVhiRlJnS0JZVUZ5VGpZbVV2VmxNbXBzM3ZCcVNURThY?=
 =?utf-8?B?c2xFeXVDM2FFRk02bFg1TG9xcUxENFpORmZaTGlld3lsWHF0M2FrTDZLdEpK?=
 =?utf-8?B?MVZkU2JjT2JDMzJ0UEFjUmt3OTMvdThGTWVXU1k0Q0YycHJocnhOSTQ0ZWxT?=
 =?utf-8?B?R0tWUDdNNFhaanlJT0RCbGY5UHROWXlCR01GQVRYN3ZSSnpCSFJiZ0Y1OVV5?=
 =?utf-8?B?VEtiN3NxZnZRQmdkb2c3dFVBQWdYeHM0Um1XTUlYemxNNkZkR3BHbGVSd3dn?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NGRvIYU9cnpeZDyijMpxvP5Z/9JvtwebcEADsHsK35GmzZ4vj+Qqpk+vjU8T/khinCj2XyQLjzpqHvU70Lup+dtmFDmqpGXX03XzedTV6t2ydeWb/mrXruO7zXXuDYI8MT9PQkfOj1IxmsZ+TmJTHIp8MVa4D+5SWrXiz7hiwANZBZI3eNFOEmM2nqy3asIi9dXPbN1mnycHkTO8xt9rsSkr7dOvHxRPdgxxBr1HUgUDh9AiO28j43n2R7iliAODGVjG5E2RHE2E/1gzrg0KP8WJTV0uWOpiUcgw2xTTLVkYbVP+f0PPg3Wpohw0E4AasFmvzouOpdVISozJXv5buXmMk5N0ZvbPlYIQVoDGj3lbhRmaSPpP0rTJE/sYEFbKEUQv64cuU1TlRvBGtr1un/+mEdslck/509kV+7VgOUY4uXkkUlwB9MCv6pUNO0W6WscO/8UtyzvzhT8951Hoq1iEJz40TC8BmKeUn+yR7RPeULM8N/Z0V4Puw21OfIds8gznzbHhQy0tc/oI8Cr+mTWGFJG9HBtXzfgZ1vOHYGGEDPJ6q/sUWKrD2RBC7xhfBvdnAXM6HRC+gUNQJC7I5H5yvEm6QBiicAjyDQ/Svok=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3da20d-ccb5-4f84-e174-08dcb580f54f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 19:01:05.7845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czqawawb3tSB2aF4qIwCfMe9+i7eeoWEku5SgknCy6F1z+7Wji7T8lIQK0iZ72/mgRyypUGXK9Bhcz/ANSTNv5IAAuPg9FxpjH3KaIGzYZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6021
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_07,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408050136
X-Proofpoint-GUID: iNxKjxUJya3YSsdYGMvi6jNSZliB7w-6
X-Proofpoint-ORIG-GUID: iNxKjxUJya3YSsdYGMvi6jNSZliB7w-6

On 7/22/2024 11:37 AM, Jason Gunthorpe wrote:
> On Sat, Jul 20, 2024 at 11:56:43AM -0700, Steve Sistare wrote:
>> +static int iommufd_take_all_iova_rwsem(struct iommufd_ctx *ictx,
>> +				       struct xarray *ioas_list)
>> +{
>> +	struct iommufd_object *obj;
>> +	unsigned long index;
>> +	int rc;
>> +
>> +	/*
>> +	 * This is very ugly, it is done instead of adding a lock around
>> +	 * pages->source_mm, which is a performance path for mdev, we just
>> +	 * obtain the write side of all the iova_rwsems which also protects the
>> +	 * pages->source_*. Due to copies we can't know which IOAS could read
>> +	 * from the pages, so we just lock everything. This is the only place
>> +	 * locks are nested and they are uniformly taken in ID order.
>> +	 *
>> +	 * ioas_creation_lock prevents new IOAS from being installed in the
>> +	 * xarray while we do this, and also prevents more than one thread from
>> +	 * holding nested locks.
>> +	 */
>> +	down_write(&ictx->ioas_creation_lock);
>> +	xa_lock(&ictx->objects);
>> +	lockdep_off();
> 
> IIRC we used the nested annotation on the down_write instead of the
> global lockdep_off? See how mm_take_all_locks() did a similar madness

The code you sent me used lockdep_off but had a comment wishing for a better
method.  I'll try the mm_take_all_locks method.

(BTW, sorry for the lag time, I just returned from vacation).

- Steve

Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ECA1D12E5
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727889987; cv=fail; b=FKdJML6+sIzOv/NkTU0ixxaEEi/x0A+Oq/7+a4IsWosFEqF8komt9RSiI94VmbYoz8g8l9Spxkx1WeGxTbsq4/Hazc87ckm496qhrer98+BO0+WQXKaPA+YfhlrYiq9L1mmBvSwotsLTdM4lNeMOiCBgKUTniWdU43yvRaS4Vcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727889987; c=relaxed/simple;
	bh=MBcnfCWZCPgFSjU1YFcMmzo9or5/9NugoeeeL5zAfN4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZJWjEUYHRQrKScFuP51aeZ8dkSCrukMqbvZm+6pweDT3kXXrCJ1tqi7R2f2Jz7hchTOZfIuQPA1HZVtit4I6rp5cTMccTMEKrh3NigkzDOSA5UWwfTomSIbzHJCE6qzqCxHu2iC3c8jRhgBdnIzDqAGRGAfymu3al9BCLXjfIF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b1rN8OYS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V6lX7OOu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b1rN8OYS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V6lX7OOu"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492GMWS9031350;
	Wed, 2 Oct 2024 17:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=yePKx67Lzy5JlXEXJWufijx9JuKHsNErW6HZuYMviwg=; b=
	b1rN8OYScOthMW9mCVzDAJY/IfTiNdubFdCM+khoAinOG0Q/O/jKxeGYHGXGQU/W
	954XVz8vY24qoAMEmqrumO9DtWKhLphe6MwCKacDQYMTnQd6YkHsa4YyjgiNXC5x
	vHMgLZXGBt7i5JThvxMAMuUpEdeRNZab0AZLUmQ03ZN5FKWyNt5THFeluQmg8z+K
	Bnt4yF7XkvushqrhdgyeB83WItjfM+1rR7ST8RsGWlFnDOECr6QkQuBLyWPOvZ7f
	2P/iMWG/KHH+opI1NqYZ9EYmsG2UoII72B5l5VZPTvs1XmA3BrvvuRD0XMe+r7fX
	wl0xQOFjZR/aR+9vPdmEwg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k3adbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 17:26:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492HKrSP028403;
	Wed, 2 Oct 2024 17:26:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x889cjrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 17:26:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JK+S7TMEQ6vEv3MHj6lJtAtX7+DqitGJZZRkZPJw+RWO20gDrrm8A9lg1H3sOAnigWOZj8O5DX7iZJAzum9taEhYJSUgdpQajP/s8GjbizuGGBvfAOakPYWyjt/uYBtBQqwd/m/pcBMO1dam0H9Ovd/UBEH6kuSC47ZHHv0COIA3OE4rwXTDReN3fx8b+gJ4qq/e55xRdkQmf+OnqFRVwWmIHgSnVUzPATtF9wx8gDAHPXSBQv9+V4032iRUktNM7mEn2KiKiDLApujd8sBUwgieROK5i8NdpDkGKIB1xLsdOJ+7jtMTcjyVOj6CJ2ZJhYfgs/48hlrJsfY67ugSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yePKx67Lzy5JlXEXJWufijx9JuKHsNErW6HZuYMviwg=;
 b=SLqwQ3NnecHUtI/1IonaTJ9zInajb6MGy/65Y2DHM5Wi228tMet31PXLoB3XoVDxGk7KaG1mYReW36wHPlli5qqoaBGC2kcSJBOqTwR0QZ2NNnhQlkdbW4scPg5ViLhN9Bvtn8KZcWF/1yl+WOcX79Sei67dkWt68jLzIFh3tar7TCFXca+PTQbOwC7F0X1QvFokEHRL2bkO4VSaLRqeNHXEyHdznT2bLMpFk2JLeGplWoq7IWthQh7jDyP7OXfXdlhYvCQS3DYrLD14nuEaEIN6m/e6x959YpCI81wPkCVyXKivv5BGrowO/W3284wmUzWpEEIYuqYGmJ5jtY+zfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yePKx67Lzy5JlXEXJWufijx9JuKHsNErW6HZuYMviwg=;
 b=V6lX7OOuD3gPgVhft1HM39Sk4pBpm4aNupqEWGvsg0tdG5YZ+dCjdHMXpZfg8LXk2Si729QRM5eZYzNpWNTaGsAzXCvL8DSFXikyJ/EBUqxZj3WgD9LD4vZrh4gtiAsTQ1CRVhLEEo9CPchxXaSZRedYPDF/EuxBY706sY1OS28=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH8PR10MB6410.namprd10.prod.outlook.com (2603:10b6:510:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:26:19 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 17:26:19 +0000
Message-ID: <05716d2e-c114-48e2-abd9-5d934fcb03fc@oracle.com>
Date: Wed, 2 Oct 2024 13:26:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 6/9] iommufd: file mappings for mdev
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-7-git-send-email-steven.sistare@oracle.com>
 <20241001200959.GN1365916@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241001200959.GN1365916@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:408:e7::35) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH8PR10MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1ffb62-cce7-4ac8-fbd8-08dce30753fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUtZR0t3OGpQZUd5a29jSUFSWmxSSWp5VmRua0cwckl0ZmRIYWVBb3hGcGJZ?=
 =?utf-8?B?d3dXVlExNWNDb1BpSkpieE1YamxKbEFrWEhaN2x4cHFYTkdlRURxSnFSdUh0?=
 =?utf-8?B?eWpRcHhBWnVVejBPUHhkcUp4SWlKOXR6clh6d25yTk9NK2cyd1JGdTZlVy9o?=
 =?utf-8?B?ZU9Md1k4aUppVzRwYms2dFMwQ1EzK3JGV053b2QzSFZCT2IxR3NYUWpXM29R?=
 =?utf-8?B?Y3ZFMGhTWHYzYjZNQUJMeGRpRmhGY0VtOVRlZU0xUTc1WjFocGxqdlZtL3Jt?=
 =?utf-8?B?Y05QTUx0YzM1VnR6Ky9GVEQzSHJSVkFTeFNrWnErSUl4ZTUzMVVlcVlvK1Bo?=
 =?utf-8?B?eENYaEh2QVUvbFB6TVVCa1g5cnowYzRpcWJJc0s4aFo0bDVZNUdWUERWbzA0?=
 =?utf-8?B?UW85MHg3cWtTV2o4eFVlRG1HVDF2M1lOVWMrSEhuODIrMG9rY0pHbTRKZTBO?=
 =?utf-8?B?TmRzQmkxUm5PNXpzSTlIUGY1S1VlNkt0ZmRoaEJCOXVhVHVPdmZXeit6dWd3?=
 =?utf-8?B?VkxZT081V0lRQ3B1S21BT1JqZ1hJY1Vlc1NCa3lXR2NPYmQwbjhuSURFd1Zs?=
 =?utf-8?B?K2dBNFM5Qmo1bWZNZjl1ODdheEJCY1ArdWxlZVZNS1dUN0dreGtmVm5WSWx1?=
 =?utf-8?B?TytxWGtubU1zYjFMdFRHWFdQQlhEK1NueFdJUVR1bnJ2M1dXN3VydEtsNTNx?=
 =?utf-8?B?Z25EaWYxYW1SYUlnbVVOTGJkc2lFU24raG9XNGNYSE8yTWdRMmRhcVV2V3Z2?=
 =?utf-8?B?YjJ0enY0bU9ZcS96WXVVTWFwMGhaTnBTOTltQTM1UjhVL2NydDZHcUhFZzQ3?=
 =?utf-8?B?U08vdi9sbTJZWXhjU3Q0WXRiUHc2VHBWRUs4VXpnaFpJVXF0WHdJbXh4eS9H?=
 =?utf-8?B?aWNzUUhpeGE3T2dqcEhFeUdvLytCZlBBY2Irend4bVIvbkE5NnkyU1AvZEtK?=
 =?utf-8?B?N215M3lZOW5YSG4yVzJxQXBHbUZoNjh1S05YRWFLa254c1BFTURhWldzVlYr?=
 =?utf-8?B?ekJTRWtaODd2K2NzQ3BxazZSK3NXeFhQTWJqZUo0RkYxaWYydTNRQytsMk51?=
 =?utf-8?B?QnhKbDEwTGVaQXJZK2tvUnFhWXdSeEVocVVpZUx4SXJ3YVA4NThsMXBvbnlN?=
 =?utf-8?B?SWtITWhIdy9UWFNWRUZFQVYrWVhnV0hpKzVyOWFTc3ljcVdoYld4ZUVST0hx?=
 =?utf-8?B?OFlySEZTWW5GKzM4MXFYV2o1VHZVM2FoS2tmeUlzTTBmdnZueGVKTDk5cU1B?=
 =?utf-8?B?MkhLYndubU1ad2svRzgvZnk4a1VTVGlpK2dRZGRzaVpKQmRpVU1uU09iQW8w?=
 =?utf-8?B?ZTdEMkxqOTZWYTU2bTVxRW1xeWs2Z25VZzZlRjlBTU9ZMlFRN01xWERVSVZi?=
 =?utf-8?B?VWxrQmtTSXloN1lDai8yczRJN3VtM2lwRTIwYVY4bXZiWWgvcTZxK25BRUht?=
 =?utf-8?B?T3AzcjZXT1EzR3pydEtRV1NiTFVQLzgrOTI2bHhRdENmekY2bWlKZUl5eGcx?=
 =?utf-8?B?a1FQdWJnSkx3a1lRdk1PVTBDT3JJaFYvWWlNSC9ic0hzMHdBQkZMWlhJSEtQ?=
 =?utf-8?B?eTVwQjZxQlYyRFB5bVAzU2w5TWo1K1Z0RjB3TEJBRUZUSmJsNHNkUVNnazBW?=
 =?utf-8?B?bjVZYVpZQlU1cmJYZWF6SE1kb0pSMWN0KzVaQ2FoRFArN3FWeFVoRVc4dFRy?=
 =?utf-8?B?Rlg0dmxWVS9IaDVWSGhIRE1FVVhWN1JpZFovMTdaZWEraWVsU0U4RXZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXpnSVZJMmhwaWoxMkNEcU55SitKRFFkR3U0R2tFS0plWGp1Q0NUdWljN0wr?=
 =?utf-8?B?Zmp2VWNCSzNPdUNSTWR5UHVSZ3hOdTRuTnZIUkZNcWJpKzBxWEswOEF5MEtB?=
 =?utf-8?B?NStIZkRVV1d4ZFV6SHNjQzNyMHdpNzNwVzl6QVMyajBnTHR4VGdlMG1ZMXdz?=
 =?utf-8?B?azNyTENXdHhzY2V6S2o1VmpqR0FPWmh2cHloa05mVjlFVC83S0JnMTFwV2s4?=
 =?utf-8?B?cXFqS045bXFmQWtJZGhHNUZKYVFpYnlXTklUS3NZMmszWFFQd01YRy9uQ2VG?=
 =?utf-8?B?K1BTNkw4a2oxR3ltemxoZ3lvTWVtb3ErbHJEZmxFWjlweklZQ0ROQlBzL3JU?=
 =?utf-8?B?UUFEaTZxcUQrMnFBbExjNFZINlZRNFhLUW5HMVM5MFNBS05wcDhOT2F0anNw?=
 =?utf-8?B?d1VvbktLVHkrTGlLcG8vc0JrQzFaWUE2T2dpUVZGV2VtQkF1NnovNE1rTDNu?=
 =?utf-8?B?bjYxM21WTndaN0ZWdjQ4OW9udUlVTkp4QmtUT2tFMjJibjhpRWtHbUJIUEFI?=
 =?utf-8?B?V3MrRHhkeXFHdjNBU2VuN1l3bWNySDlpUVUweU9tN2E2bkRPWFlHT1JJNUp6?=
 =?utf-8?B?Vmticjloam9HZS9CZkNVbUcyME9iZDM1REdmS3MzcWxQZjl5bGFhWVRSa01Z?=
 =?utf-8?B?bWxQMUhwNUhROEZoQVJXK3hDenZLTi9nZytIMnd5US9iRUFuVlUrSllZd3Uz?=
 =?utf-8?B?TnJXMHBGVWdpOGJ4NGhKdkNOME5MNEdXWTNPOUJ3OHVtaTNJQVhBNnlxNC8w?=
 =?utf-8?B?THFLekRPNk4xSmZYYXFDc0h6YVdTdjBhVWxJQTVoMXFwSGRkdUFrcEtmS0tz?=
 =?utf-8?B?NnV5UUtFYWxhNkhJbDRaaTVTTC9ac0RKRGRlOHUyc2tKRjllUUZxSkhGbDBC?=
 =?utf-8?B?TzczNEZMUjVYY3ZUQ3pZRldUWTVTZ01rZ3NIUmdDQkYwMSsxZ1I2Y0JxVUMr?=
 =?utf-8?B?aW5vWlJJWk0reXMvbWFoZ0lOeThLUjRRSWVnYUEvblNSRjY3TEtkaTdrVEJR?=
 =?utf-8?B?NHdrVHRGZTRhNStRVFpDcXFXeTZxV0dxVWxuK3lYcndqalg5L2R1cTRXWmV3?=
 =?utf-8?B?SjJtRzBpdkVOcFZVd0FJWXFiSWJmOW5NREkvUE5ONkJscXpad0xSQUN1TGNO?=
 =?utf-8?B?SGlORE9INlBFVVUwcE9KRURXS0FVOGlyR3p4T3BYNjl3alZiNC9tcE4zTm5n?=
 =?utf-8?B?UmQ3cE5IajFiYzhiVHlXYllBeXJmVXRrV1hHSGY3Y2JMNlQzbloxdE1hRXl4?=
 =?utf-8?B?R3hpVGNGWERQWjV1T2tSWndWZUVKR3NNOCtaR2VTZlp5K0dNS0VKamgwbUI0?=
 =?utf-8?B?MjhOamhuT0duT3hQb3B1WDllaGZJWmVRNTJBU0xSTTRLNGcxUU5QcG5mNHlq?=
 =?utf-8?B?R1hseFBTT3RIczhZL1RhbXVYWnlsb0pBczFnQ1N2dXMyd0MxdEM5cEdHNXFz?=
 =?utf-8?B?TnM2ajBZNGJEU0hUaTdEcHo4aW1aZXlZTEx3WUZKbXY4ekxvczZsQVdoRVc0?=
 =?utf-8?B?WDlrejVXWXBCZnJOR09mSEFVQVVqeXhWVVNWaVBFN29uSHVwTGoyNExpZlRU?=
 =?utf-8?B?NXVIQWJlUndKUlFvUHQrUVkyOHROSzBoSWlaamRWN0Z0SFNPWXJQeFRyM3Bo?=
 =?utf-8?B?UDlIN1ZuVXcveXU5c1BrQSt0dlNvNDR4ZFdwSnMrZncxTGxrR1U1c2dDWlU2?=
 =?utf-8?B?bGdhTHZIaXRheDVLcjlYb3RIcXdnd0hENGhvNGQ3bDVyajVhdnkyWHl1Y2c4?=
 =?utf-8?B?UDA1QVUweXg3WHA2LytrVUFUNXR2bmt0VXJnZUdLMzhNR3JOcytTWE1SU0ds?=
 =?utf-8?B?cnVrV2VNNUVyTFBLcDArcWhOUk9RRDBIaHlWRTJGQ1Fva3JnTjhvWUJsekJm?=
 =?utf-8?B?OWRKeUNqYlEzV2ZqakhDakJ5cnBtQlcyVmZyOS9VRXY3OEhnaTgvQmh4dm9P?=
 =?utf-8?B?ekxVY3NMSkhJbXVsV0dpSEh6ME9Fcmd2YnNrTzN1MS8wZ0FnZUgwOWNqNlNX?=
 =?utf-8?B?RUxub05TUXp1VloxUWdDcHRiSldoaXd5UzE5OGpDTW5DYWRzL0FQdFBmaUt0?=
 =?utf-8?B?dDEzS293YURmb1pDZ1dBNlZhTU0vWmxoWnpaZzRCcjd2aXdWYmlYY0FjcFEz?=
 =?utf-8?B?SnJ5cDgzRUVKZ2w1dHprSTMwdEZSa3FjdlRIMGd6RWNTdG4rL0dBNDE5RlZ5?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MKxvCXXC0gXcTOorgtjnyolzzOsFmC3GUYQxZRFpfWa4+0r8u8Vfhf6HUxKHzGHvUc/NiV6EmbkjkqP+x6zpx4ep6pHVAiRbmGNYFXevHFh6HPwB35ScyLXVfCvjIJpnvXCEjE8ZnMoHYUTtTy2tbJRvjpWLSKWneH6Wus1in5gF3iSqskKCucaGyqO7gez83JWbHVb55UyRBnnbnhjn4cremt+KpIBUgsdA5PI/OQVGympJk+opENpe+M5T15eoPNevKvpLQp4nNMdqVd0owW0aZe+B53o1WqMNzmgHsrW5gx2GPboldmlqMcksmC1SFJTGYkRVI7LiLddL4bwYjjXdvYJgEgLGtGKvPbhryH0SnZTGcrF+013ymuaoPjulaagvDUlNaLBq2KdWfqvkWBLmzpdRg/sOiY3C3iwuNTNvHD8SqHV9g9hAPQA1G7JBeS/uxWviMTIuY9EA3jheUEJ0REVHPUMd17eWyesr4vynuWT4WneB6DfiEb076W6a8B54APwokQI8RionULsQ6c5h1Tsw98Y0QkvQVH4RaLfXf8pAiVohh37Y1oRcryHEzZTcCpGxcuU+hwf8DyPMeH5Vw/IELrfQv5qLGHDk434=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1ffb62-cce7-4ac8-fbd8-08dce30753fb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:26:19.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKC83Kc7x0CAHWrrCqGiMCPk3yNVW/6QimWkvSMuoqAV2A7uNoj4Qdidyu6JxoPmdjk2pzdNBfHm+z4HV0H/KUh9x51JpYyiEiu1FEfSk0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_17,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020125
X-Proofpoint-GUID: 2lX3IClbW0eZEetyYBLNCuM7DoBARFOx
X-Proofpoint-ORIG-GUID: 2lX3IClbW0eZEetyYBLNCuM7DoBARFOx

On 10/1/2024 4:09 PM, Jason Gunthorpe wrote:
> On Tue, Sep 24, 2024 at 08:05:35AM -0700, Steve Sistare wrote:
>> Support file mappings for mediated devices, aka mdevs.  Access is initiated
>> by the vfio_pin_pages and vfio_dma_rw kernel interfaces.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   drivers/iommu/iommufd/pages.c | 22 +++++++++++++++-------
>>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
>> @@ -1884,6 +1884,9 @@ static int iopt_pages_rw_page(struct iopt_pages *pages, unsigned long index,
>>   	struct page *page = NULL;
>>   	int rc;
>>   
>> +	if (WARN_ON(pages->type != IOPT_ADDRESS_USER))
>> +		return -EINVAL;
> 
> You can can probably wrap this with
>    if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
> 
> since it is supposed to be fast path

Cool, will do - steve

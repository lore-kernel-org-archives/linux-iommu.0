Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FDD1D12E5
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727889975; cv=fail; b=HSmhy42wkDFDzQEIIWmmuEc2Gv5iiBFoizHdiiScqpCVvyY0EyKCzOwlcgvD9P0iD6sUkQPvghxzSwbBy8AiYK+yHFcj9+NmOhh67Af+J3b21nFGYSDDB5qTJZGom3gMuYsG++ndmaOBv7LiKWR4a+sAa3UrQe2JgJrRZyiCQBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727889975; c=relaxed/simple;
	bh=dun1/GWAwvFL4KSWwhkQ+FHx3n6a+0nL1doWwGlUVuk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FxD6HzBpMbvIJ7ov/J0BdboBk/gADHM7/EdMHA5E62GFYzXwNh7lX5A+viRRDB8yXAuHr98cqaOi+L2m5c07PWbWhdnZ/kYWlzUUkhsP0dRcIWqvUQ/K8HZqGS026vueyFn7udTjGcSaDz68B3le1inhl7Pg4UrBHVeJaZxeCiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=URdVZKWS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IQqLvFI9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="URdVZKWS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IQqLvFI9"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492GMWHE031376;
	Wed, 2 Oct 2024 17:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=GyOzNAsv0JDEEeAE72dajttFqKzXMWCTbstwgFxz+Rg=; b=
	URdVZKWSXQCZz4h2Lq/qdZ4LnwRl2QzVl7bsRlZeDrDXFe3SR/ATa/Yz7WEBHZfc
	RslLd5doX48M0lKzMYc0R/7GcXpGuOP+W4TWBADbtZ/fdA860SDWhr7QNXtb+3OX
	pcx35xz1YRLllSzSnT+rs7dQD6V9byFTxRJNJA/o9nfqyr45WyW0oPtCdpdpxuiO
	6oVnTR+sxRhGN3ULS3PHvzOIJE4SxGRGjzCY25WunwJiFR10hk4FZQWsNt7NOfmP
	BayKYRCWtbgyoW4SRYckqnv0eVD9o2bVOVCMDZuCKJHGPQkptwudFbVKGhbrugL4
	zCbLz2MQ+O1TXQTFIRSQNQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k3adbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 17:26:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492GUHgA026279;
	Wed, 2 Oct 2024 17:26:10 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x8896w18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 17:26:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gs+BRCsMF53knli2metF7kOnFkMrBifQldA8+zKdMBq/VHfx4Mgk3fq+TVV+EZ/D+jAXQccKGy4fCizxcrUek4upWU0U1udpHEq8bsCprRJyiZZ44RclnIlF2ZEvxUasYzTpweU/5WH51Cc16KslFXgbY8DxCwNUKUO//wkMHNOLUHVPfS6Hu+3BMBoXbxRVuB91sqoYfOk8KFkrABTRZbaHSJuZRuM8K/cRfFUfXKbgm/Xjth5Np5dflR9KpnjznL5DFZ2iVsw3Z8t39htI/MK+dOGLyEycUF6p1Hy1I1WP3H68xFKFasd3J+yq8DJEtypRg6QKTA2lilNrUhIk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyOzNAsv0JDEEeAE72dajttFqKzXMWCTbstwgFxz+Rg=;
 b=X2hiDozMmM3yGWHD3br2NJsOV7EWk1meIAN8fv9k0FfxXu+UASH70gsR1Xu2LMaqE6Ny76AtMo/U5wxgX9/3hnW2GlY0HezkKTgCkGlF6WaN0EuWTNEfbNzrRtInFy5Zvx7EL8ki4Ek6PpQP7JCUgxrm2ZidD3FiRhHXjZIzzFqzkICsfYFsHbt120Km3fLgW03m+3uJMpEtjsqZCxXnJYHs4bx35ZaKPb8Llu/MB1k4bANSXue217DlBUxEy+eDUaPGh9f+ImEf4TImEcMJBZKgYoEZxNJSom7Kh1V8gXoaAu/AJgfKJXpfCbkuODOGKYzmjUBUCUwRsylY0s2Vzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyOzNAsv0JDEEeAE72dajttFqKzXMWCTbstwgFxz+Rg=;
 b=IQqLvFI9JfNRNSGYQFN664UTP/VVJ9bYfJQUSS7NF0jIC0K5cUKaVjua25EWhb14f2ahb2wx2cuUhPU5XrQmIopLmB/dyunU+tl02TeLno7+99RTedz7rY4CvU+C2zp7TkJ+DZB8jDadYm04AZDQImmkhNNDtIglYNrQ4vDijdk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH8PR10MB6410.namprd10.prod.outlook.com (2603:10b6:510:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:26:07 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 17:26:07 +0000
Message-ID: <2bc39bfc-f7bb-4108-a98a-9623f499dd08@oracle.com>
Date: Wed, 2 Oct 2024 13:26:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/9] iommufd: IOMMU_IOAS_MAP_FILE implementation
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-6-git-send-email-steven.sistare@oracle.com>
 <20241001200533.GM1365916@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241001200533.GM1365916@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:408:e7::24) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH8PR10MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: ba1ef9bf-f5c3-490a-1eb2-08dce3074ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0o1cWIvd1JIdTJJR0t1L3dzdy9SM0R3MzltM1pJZDR6elhMU09vNi9EV3ZB?=
 =?utf-8?B?b0IyVTBrYVJRYVVnbVBCdW9DZjhzaDhzQjc4UTV2WTVPYW9TRUwzRFRmRmEy?=
 =?utf-8?B?L1B5em5YYmpjQlVtUDVJWDBTRUhHay9jS1JnVjRMc0hVQmhSd0NDQWpjTWZu?=
 =?utf-8?B?eFBCeHBmenRoZ3pvWmZYS1lFNlgwSkVuaGVoOXA0RUY3cFIzdDAzaXVBdXRy?=
 =?utf-8?B?MStpU3p3blcwdWdDRHF4MmRPcUNXcmRvUjBERUpxV3UySUF2anRYbHFSbkFW?=
 =?utf-8?B?WEhYekovLzlCYURxWkNHc1hMWkYxaW5aRkhqTUlLblZ3VDhOUjRjOHFZYW1w?=
 =?utf-8?B?NjVIMnFCOWJtenFhb0wxYmpFM29uelJ6MnJWcWIyUUN0SzZaeFBIbVpYc0FC?=
 =?utf-8?B?K3FGalJEVUxxSFJnS2VCb3JoUlBWNUxyTm9WYVF4anNMcXdUSlhNYTg1NGtz?=
 =?utf-8?B?alZJTy9yMHVpdVIrTjkrRElLdEszOU5aRmRSUkFBUFBDdEZlaXE5KzlWL1li?=
 =?utf-8?B?elB2azY5MTJtYlZoVHpSRzFjam4rRm1aZEk1eEJ2dXJqa0R2SEppckl2VEhy?=
 =?utf-8?B?MnlWb0RlcEEvZEFMQ1U2YjE2WFNVeG1VY1BwT0wrQlAwNWlNbHhKYXF3a1pD?=
 =?utf-8?B?d2piVDZOTUVwM204Tk9ja1NBQ1pvemlLRUc0QnlZaWRjdm5wQkxNQXoyYWNQ?=
 =?utf-8?B?cS82eWxXU21RZFdmR2lTQWY1aC9KTkxnSmlONlRjNS9uVmlIMjV4WkZxczd4?=
 =?utf-8?B?NXRqVGJJcjFxU3pjcS9ZR2hEUW1ON2wwMUhtT1NTbDRiRDhyVHVlM3F3U3dS?=
 =?utf-8?B?L1hsU0FZaWE0OHF1K2x2R25OSXVKT0FXMjd5emQxMjZ3ZWxSVVBJclNlVWVQ?=
 =?utf-8?B?dkNPRXR2MjZHRE5melVXNjFiTURrT1lpZ3BSQzZIUHQyYjBvNzJrTTFTVnMv?=
 =?utf-8?B?U1JTUXZLRlg3MXE4RmV4TlFCWWU5S3Qvd0hWWlN2eElscFE1SUhiMzNoLzlH?=
 =?utf-8?B?a3N6Vy9xUzB4eE4wTnphUjVXTkFFV2U4RGUvZ00xaFgxNGZGRVBvYWZ3TjRD?=
 =?utf-8?B?MTZlcmZSaUhnT2FoQVBHcXpEL21HZDNmOUlGMmlGYVZzRFRYRU9yM3FhMzNN?=
 =?utf-8?B?Qlo0RWo3SGRHSk92elRHWU9LWmg0RTJlWGliZmdwOU9mLzEzNkZUUnMrQVVE?=
 =?utf-8?B?UFlsWDVFWkFrWk5GaFd5bm5lYThoUnJOY3FTTk1ob1d6MVN3OGdheFZUUkF6?=
 =?utf-8?B?Wm9HYlU2dzJtOEUxR212QSt1eDZ3a3E2dWIrdmlMRVp4Qis1VnJqdGhvNE8x?=
 =?utf-8?B?V1k1ZUEwWGh2N241ajFBdWVFS0tvQ0twQlA0TlF4SnRwOHdOWVUvTFlLcnBQ?=
 =?utf-8?B?bU5tMG5GYUxIaFlZcmt3U0tqQVZaeDhLSjJOZXRGMFBhcVhzR1NweGl5WEFz?=
 =?utf-8?B?UzB4b05rSkV5WnVCSTJmcjZmMUdxL1B5d1NqTnpKNTFRSm4ySldxbXFrV3FI?=
 =?utf-8?B?RTNNRE9oNWJVMW9JMUMxRy9iZk5xcmgwRk9RdzhybTUyYStnVFlCZytKS2h4?=
 =?utf-8?B?cWVTOW1lOTlYa1Viak5mVVZ5c0hwZHJJL3NCc2lOb2FyM2lHajVwNzFwaW5y?=
 =?utf-8?B?OHVsTVYvQld3dHZMMFYzNm90d256aUcwc2lVSzlmRTU4SnBHQ0tFL0E2REF5?=
 =?utf-8?B?eXN1UzlVNUl5OTR2YUdKajFLNW04NisySFVtYllRMEZ0bkFOUTk0cnBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGZqM2tJakQ2R2lZWE1pYUtmQU1wcTVLaFpDcU91ZkdBajduWGtjT2dqNzh0?=
 =?utf-8?B?QTdROUNEZDFnUU5jb1lrckxqNmhINWJkbCtCR1R0NlBPRUc0cTRMdGlJVTdv?=
 =?utf-8?B?WHZvRWwzM0kwQTNmdmZxV3FDUXBhSXZlRzRUY1NrNlQxM3YvdFYrU0ZNY2o2?=
 =?utf-8?B?T2ZHUEcvT0J0N0tpTXU2dFdJSGl4T1JCOWk2UEUzRjJMN2lYK1lQaCt0ekdL?=
 =?utf-8?B?YmxPRlEwOUlIT01qWncycjJUMFcwa2lmdTJzVkp3T2RZQkZIMUdZZlZOUGtP?=
 =?utf-8?B?bkN0UWpDekt5Z3dISDN2em91OGxCdWxZck01TXpSNnloQWVZNTdweWZiN3h6?=
 =?utf-8?B?dWEvYjNrV0U2MHBUaXc4eGlDbVF5K0s3YkZUWEF6T2lPUzBVWTRwd0NCZGtt?=
 =?utf-8?B?OTlEZFZrZ1llVzluV1E4SXFkTU1wQU5VVVh1R25hMkg0REJTWFdvWFp0OE1p?=
 =?utf-8?B?aTJZcHErOEc1UHl4TDA2cG95L0Q2b0VPdWE4bnFqTHFLeElBaks0MW9DUTh2?=
 =?utf-8?B?Y2syUXppd2dQZ1lUbXkyQVZOcVgwVTU2SG9sVnE2S2FURHc1QzRhT29KUkZX?=
 =?utf-8?B?a1NTdmM2bG9IL201V0xlMUJwa21LRTZKck9FRXI1Z0laWDNGK0RZdDN6UHJl?=
 =?utf-8?B?YUNFQjFNM0d0SUhWdnJsZlV4bGh0RytxVGtLc0NQMkhzSXZpMTkxVWxZQTJT?=
 =?utf-8?B?b2FxS0FWMGozNG1zbVI2N2pWZFBLVGVGejN4cUIraXdOcUFEdkhQK1MwTFhS?=
 =?utf-8?B?aUU0eEl3QkVHQ0EyT3hLYWxHMkVlMHFURjdGam5rWlVlNFNuNjlUREd5dHc0?=
 =?utf-8?B?OGFvSjFvVDdyNWsvTVBSUzZaVUVlSTMxbzZ6dEF2RGpZWDdFMDJqUzhYeUJJ?=
 =?utf-8?B?MllCa2Iyb2UxWVVheHBHZ3dIclVZd2hJaUVVRDZxYWVzdVN6dTBiQ0FFTDRH?=
 =?utf-8?B?a2dOMzhBcUxsSXY5blVDQ05vb2JEck1VZE5iblZUZGJTZzhhZW1XTkFTbHp4?=
 =?utf-8?B?L1R4Qkd5UzdWZC9acFBQSEMrWkNnd29MbXVuZ2NNWWZ6THVTZkRXTE9kNHhq?=
 =?utf-8?B?dTBrWjdyV0g3Z3k5b0prMDY1RUdNQys0TFd1N2w3aGg4VVBLNUN0VVdaNHVP?=
 =?utf-8?B?LzMxOTFpbi9vcnB3ODZiVkxzVGtWeTl4U2pRUGtrWXJEcXBWMmlkeVd5aUt6?=
 =?utf-8?B?Rm5BQnJSbzhKTm9uYXdYV1ZnTHE5enRYOUR1czd3b1YzS3U1c2dlaittQ2p2?=
 =?utf-8?B?eldORFc2aTlHeGpVakhuOWtLcjVVdnFNRkZaQmtlNjBYUDJEV1FobjM3VFNY?=
 =?utf-8?B?Rk1sdlFLYmdhRmpxMzBEdUgzVE9xalZHMXp4ZDdtbWluRHZ1T1VBSzhSR2Ns?=
 =?utf-8?B?MWtjYmVPR3M0ZEtlL3BRVHdMczBHZlMzbkpMSkFXZzFjT2JzczZoN0t0WFVo?=
 =?utf-8?B?aE9SR0xFMUVGN2dLampXV21kbjlhN1ovUFhVV0VWRUt2RHNTWk1ubU40VWgy?=
 =?utf-8?B?aDRqZ0RrVFo1d21McGRZamJPM091SVdKYlR5OCs0TXNvS1RhRmJnNHNwK2F5?=
 =?utf-8?B?dXBveG9SYmszK3BhcGNWNldMN3lIS2RMVlVTaHE0WE9CeGNpaHEvV2tuRFJj?=
 =?utf-8?B?RzZlYzc4eU1oTlN3Umt5MDJUb0Z3MDdZeGFNRG9PYzltZUEvd3hhNFJVL3hD?=
 =?utf-8?B?eThZMm8zZXNsVWdEOTV3R3Q4T1VseE5LTEpMbkJPT3B2R3Btbm0yN3ZFOGhu?=
 =?utf-8?B?cG5PZUdSUjc4WmYrK0tZd3c3MzNHNnJqQU0rVm1wS0xUL2UwZWVUZzBicUJH?=
 =?utf-8?B?U0lwOFgxaGFtb05oSGZ1VkxKdXZpcnF6RUlCZXRSU0c3MCs4R2lFR043VFpt?=
 =?utf-8?B?Q3piT0NTZy8wam5QMVRiQWhyQXczd2VXZ0RkS1FkRENLNDFPYmEwR1Z6Z1NX?=
 =?utf-8?B?TEkwd1NqbHV4Y25PWUVrMFluRHpqekdYeDNkc0s4bzlaL0l2Q2xLTXRLa0ly?=
 =?utf-8?B?THJjNGgzcjRVY3p6c2xteXVEMnNXem10ZlRjS3lnMElQQU1MMjVtYXI3UEt2?=
 =?utf-8?B?U0pPcVY1NHZmZU92S1lrTy9Udy9vMG01cWtEUFU4MlZORXBrVldNaXA0TjZN?=
 =?utf-8?B?MTVjaUZzUE5vaWEwV0hvNERaQUZSdkpJMTdId09GRmhGanBhbHdWTGJjdkJr?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tkNGFSGobKhrcBjIdgVsg264fUGHWalGhGPUNKPMnpTwDpbnLbK6nPeHYsa1bQUMtzkU2Lkw56thr0fcJ3nBpPzyW/AX8HwXb4T1BFvYRsHF8pQ8no+kEFaVgheiu5okE41Lp/ub6zU2JJXgwsKdhJ1D+A/q0pILddWDpFdgkxWWTQx1k3zNRsmR22jVO5+9ahAo82oJ0mBeFbs01nli4lmrJTZXfyAxSR3WiXOP06XIP4gLyE2S6OWzm/BdcO3dLVYE3iO1xmBfGk4AZM2Ku7cOTOkaiD4btHzXHme/TbZ0Gamaay8/bjqeF1diwa9ZOEt5R5gqsmn02qAjNKlwH9Z/cfd4Xt0B60MZJvnxtY04+Rv9dfBc9QwKp1HkuAT+fqBTLoiiQJEq8OEE3j3RrhqbWPcI3Id1+jWKSKEy1FRPI+hJvuAKSOZjdl8DrjeIscCpXh2SF4sMqH9zWJYBcuydrTmjLnbhZhT4RwjYBtNKPwRSliFWzUOl4IUwvh1Jnmx6V+oAV05RBXciXHYj3ILl8LlVVng6GT6t6rFoTmqiuDJHJCLUzD8t3MK9qWQIYlAfG3xFWgaEwcrpFPNO6mDLop6OlU7VuUVls6N+lyc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1ef9bf-f5c3-490a-1eb2-08dce3074ccd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:26:07.3845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCyub+I21IQBlQHX5klfRPi7xhZ3jgGTggogZ9xrIyNSAIgfwsCib4P0iqSe+C1NFNKUVJRZO4KadIqYmqQ+iOmMwDNxSaGwcB+0UOPJWsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_17,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020125
X-Proofpoint-GUID: p5ldkHnJdtbGWLTGdyDlLK3FpkfDvaky
X-Proofpoint-ORIG-GUID: p5ldkHnJdtbGWLTGdyDlLK3FpkfDvaky

On 10/1/2024 4:05 PM, Jason Gunthorpe wrote:
> On Tue, Sep 24, 2024 at 08:05:34AM -0700, Steve Sistare wrote:
> 
>> @@ -199,7 +200,44 @@ static int conv_iommu_prot(u32 map_flags)
>>   
>>   int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
>>   {
>> -	return -ENOTTY;
>> +	struct iommu_ioas_map_file *cmd = ucmd->cmd;
>> +	unsigned long iova = cmd->iova;
>> +	struct iommufd_ioas *ioas;
>> +	unsigned int flags = 0;
>> +	int rc;
>> +	struct file *file;
>> +	unsigned long end;
>> +
>> +	if (cmd->iova >= ULONG_MAX || cmd->length >= ULONG_MAX)
>> +		return -EOVERFLOW;
>> +
>> +	if (check_add_overflow(cmd->start, cmd->length - 1, &end))
>> +		return -EOVERFLOW;
> 
> Do we check that length != 0 before doing this math someplace?

Nope, I will add it, thanks.
Since iommufd_ioas_map allows length == 0, I will allow it here also,
but skip check_add_overflow.

>> +	ioas = iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
>> +	if (IS_ERR(ioas))
>> +		return PTR_ERR(ioas);
>> +
>> +	if (!(cmd->flags & IOMMU_IOAS_MAP_FIXED_IOVA))
>> +		flags = IOPT_ALLOC_IOVA;
>> +
>> +	file = fget(cmd->fd);
>> +	if (!file)
>> +		return -EBADF;
>> +
>> +	rc = iopt_map_file_pages(ucmd->ictx, &ioas->iopt, &iova,
>> +				 file, cmd->start,
>> +				 cmd->length,
>> +				 conv_iommu_prot(cmd->flags), flags);
>> +	if (rc)
>> +		goto out_put;
>> +
>> +	cmd->iova = iova;
>> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
>> +out_put:
>> +	iommufd_put_object(ucmd->ictx, &ioas->obj);
>> +	fput(file);
> 
> I don't see a second fput, what does fput on the success path?

Thanks, that's a bug.  iopt_alloc_file_pages calls get_file, and I must
add fput in iopt_release_pages.

>>   int iommufd_ioas_map(struct iommufd_ucmd *ucmd)
>> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
>> index df5ba4f..0a432dc2 100644
>> --- a/drivers/iommu/iommufd/pages.c
>> +++ b/drivers/iommu/iommufd/pages.c
>> @@ -902,7 +902,8 @@ static int update_mm_locked_vm(struct iopt_pages *pages, unsigned long npages,
>>   		mmap_read_unlock(pages->source_mm);
>>   		user->locked = 0;
>>   		/* If we had the lock then we also have a get */
>> -	} else if ((!user || !user->upages) &&
>> +
>> +	} else if ((!user || (!user->upages && !user->ufolios)) &&
>>   		   pages->source_mm != current->mm) {
>>   		if (!mmget_not_zero(pages->source_mm))
>>   			return -EINVAL;
> 
> Does this hunk go in an earlier previous patch?

Yes, it belongs in "pfn reader for file mappings", thanks.

- Steve

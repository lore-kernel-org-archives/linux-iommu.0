Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186C322E
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 20:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012471; cv=fail; b=PQab1pbji9Z89jcTaRtm4UWDEyp+347nomgvJXesDoz4tTxOzIdc90xRknh2B3CHT0O4u4XxsNwNZhO8qwkWOfrA4Hk+vMn9z9pFi9pCzx/B4D1Q6ud7LWyOymwnxjkY/7WSB/JoHd4aOLYpgv+bL2YO3jhTKnN/tIIzHkGOuv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012471; c=relaxed/simple;
	bh=Y8YHvnW55g+56kWr6YO8CcDp0BWnuqYITT0FWrKZLBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DjfhZZnOj6w6h5JZqNR8P7gFAjkdKu5HLka/Ce2nzKJqfifEo0EygkVUU6HuyMwzg2uJscgMOIr8dRa7q+qCVMQ5vDbn4EQKHv/YvL+BtyJVyrWGN8bTQA7eahcUHwunfbJYmwe/eReIQ5am2mTP71FGeJzvmtvhbeo6xkF7rKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UdIOYywk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IUNq3zn+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UdIOYywk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IUNq3zn+"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7KfeD3015577;
	Thu, 7 Nov 2024 20:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=s/rLpS8tPnZjRDSUm/y+99qsAm3QU9g0m7YkGLLSbh4=; b=
	UdIOYywkKCcbB6Ha/SbEFekGzZpxlrQa0LJ+m4maZyFEWjLnNdrxaMfUqrf74BCY
	a1vLVv8b2+GT7hLxpIvmFFmNYiJ9HTbSiAHCogNww8OWSqlc6wCoRQgiuTFXdwyt
	6HqgIT1QpvaXZAYdu2YHEfvh7xen8AFZHsRgCfE27etX1TtqF2O+r9hZ2ba6Qspy
	J3v8Yy8DE1T5DkgwDxmDc5LzWDjgH1cKHMT195MS+5xo1eFphqrcotvzwnknKnew
	Zw+WJ5bN//QqUuFy3qijPzWocrx855cCseoxirV2r9eBoQjn6wQMhhaHIOmaBF3N
	AFVzIJU0z8bhEzBWpj3xig==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nagcbjet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 20:47:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Kg8OS008466;
	Thu, 7 Nov 2024 20:47:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nahajm0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 20:47:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfG2VlvQGs6OSZH+Y53iUin+w0/hY5y+eHGSsZdBGzpma1S474GjS6goLQEeM6YuthveBYB1KQgkgN1ToPr6WRplfBbs2u2vjJ66MeBYqjbehngpWWdrH2MExynpEYOzh64Pe9nV6Das3OrLanGsjt9e0Cd54tnOIXRZOUaCPeL4rsECF2qmzSfF1u1rLAbr0AOgmcmGsl0ZyLRVfy0tWMJ3WhWtvGjHOoNWXTYw0+v/rM/0hCKlEh7cAJCYiKqLUGxPzt6bAwElSDAwM3NosG52vuQSTQ565Brg7Zv/ROHxtlYsKihnZfPdKzdxpXHIJWJguRpVbi3hLwrxTikxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/rLpS8tPnZjRDSUm/y+99qsAm3QU9g0m7YkGLLSbh4=;
 b=Pe6rGpM+N/v4OEP94kBVLl8ZKTLVp3NtgE4zJCcIxyW2pACPKON5BjSMnZjP/ur1MUrMMdR6ExSV3pfq2TLrY0FPT6X7sLNGgs79PRGFNTXxQux/ijdK9ICQENBoGlxx8AMC4o8+hnYSDF6CDXxSoMoOOPSln/f9kF+/hvJv0fa7KWp/KWA1CSl74ebjYFh57i24MmZDkTvcyvxVS5sZj5+p0HABxekvVr7V2Sv+aGzqfFXcmoiiaB003CaCIpIwKYiPyWusRqvLjZ1EZparm6LEekyh3ZqHeG140w/RUQNkqkr+Oz4J3KTQxbXF/qTgAhVHXdQWtTiEQMIvqHA/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/rLpS8tPnZjRDSUm/y+99qsAm3QU9g0m7YkGLLSbh4=;
 b=IUNq3zn+rU4RklsZQEETdjbJDZ2eBkS/Imvuh7vQNkodBLpmSzEd7W3b3iu7AUHSlj087zV+3HUdZWbsKYfed0GuIk2Fo9hAjnggq+51bbvAo2YLnbAgQ1xNO8z2MDd2uwcb3MizHE6UgVG2lSWI0nd3BxXnF4TDNjn8dgEP1WU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4609.namprd10.prod.outlook.com (2603:10b6:303:91::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 20:47:38 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 20:47:38 +0000
Message-ID: <0bfbdfb9-eab1-4e16-a19c-eb6c73b4c3c9@oracle.com>
Date: Thu, 7 Nov 2024 15:47:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] iommufd: IOMMU_IOAS_CHANGE_PROCESS selftest
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <1728321203-189608-1-git-send-email-steven.sistare@oracle.com>
 <1728321203-189608-5-git-send-email-steven.sistare@oracle.com>
 <20241107202607.GG539304@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20241107202607.GG539304@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0777.namprd03.prod.outlook.com
 (2603:10b6:408:13a::32) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4609:EE_
X-MS-Office365-Filtering-Correlation-Id: 4624a75e-66a9-418f-9eaf-08dcff6d6a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0VDL3pQcmJ3ZGNkV2MzL2ROeDFtYkpML2JlZEdORDdnZG9kbEx2VXhMMEVV?=
 =?utf-8?B?VStWY3MxenVhSjZlZGxtZS9wRkN5UFN1WUg4dXhZYTVpTUMyejZsT2xFRDBH?=
 =?utf-8?B?aFRWOElDRGZIcjZFa25JVDhvcEdrcDhxNklkUERQMno5cWNqdHlPdDhwS2Jp?=
 =?utf-8?B?RjQ2aUlpeGZTa0ZwWkZyU1VWeStJZUN2dTVQMzAzRE1TK1JiZ1hHbXIvd01o?=
 =?utf-8?B?cTV5L1RFbndMM1NYQW5VMWJranQrRytFaU9IZG9ORnVmSVNLVm15ZU5kWnU2?=
 =?utf-8?B?NUJyb3ljUGFDeDZvNENyQkplRWhpSXdnMU9NZTRoMllNTWxUUkxEZ0RjMlJk?=
 =?utf-8?B?dzQ2NG16REtuRklWZlVIaHJOZithL2hDaWFkR0lraWYyYUJaNVptMGRKMC9V?=
 =?utf-8?B?TW82WnFQcDBpSHdMcGtEckFyMlBPYW54YWNRaEluWWJnb3dRYjJJbTNLL0lY?=
 =?utf-8?B?T1FVbWJORmxrYnlTSU5BdkwwWE96OFBHR1Y1WDc5MWM3eTdKTVdQYm9mbmtm?=
 =?utf-8?B?bXV2dWFwTFdlb21WWDl3VUVvQXZYVkVxTFZnQjJRK0graDJZUGo4RVpoVysz?=
 =?utf-8?B?TnVnTUxGYm5iWUVkaG90V3dUd2RnMzEwS2wwUGhTYnFpRldhZjdwbUJla2ZD?=
 =?utf-8?B?STl3L2RoN2Juc05FVlNOY3RDcUxjV2pzWlZYUS80OTFyZkVWcVhncSt2dkd3?=
 =?utf-8?B?RTBsTE9BenpKeW1XN0ZrNGJRQjhvUWVUenRBc1A3c3cya2wray9GMC90aUpJ?=
 =?utf-8?B?UWZla0NnMWF1VHRXSFFnaEVlM0JGdDFmUW9QcGt6b0JSZUpSL2R0cDNHalcr?=
 =?utf-8?B?ZGMrcHpYblJMT2txcG1zc3ptbmROdTA1MG5iTllLSzRxK3U4Z0w3NEU1TXFt?=
 =?utf-8?B?clZ6dDlIalNxOUFsMXRvVzlOSEswaFRoUnFZTzYra2F6amliRzl5b0pOU1FE?=
 =?utf-8?B?UGJJWHdkZkxuWXdGT09GNlhZT1lUYmlFcHBMMUZ1b0hvSzhTaktLam5OZ0U1?=
 =?utf-8?B?anU3azVNWjkrR1hxa05Lb0xJZTRJTXQ0Zk5pVDEwcnl6QTBUblp3ektaZmZs?=
 =?utf-8?B?LzhFODUvV0NiTks4T2N4NVdpY1lWK2h4TDhDb3R6N0ZFeTZLUHV0THh6MTZR?=
 =?utf-8?B?ZUlwdHJMa1Ftcmp2V0JzM1VCNFVHcWlpcHlSU3RqSTNzT1FwOW91M2ZBc2k1?=
 =?utf-8?B?L0JXazI1d0Y5RnQyOTc0UVRERFpXb1ljcElaNkpiQW01YlhTVS9CZHNjbjlv?=
 =?utf-8?B?eHhrcFRLdlZaL3MxUmxNYmxHZ3oySjltck5KRy9abnBhL0Z0ZjNtMU5EUjI2?=
 =?utf-8?B?N0hOSVNYN1prcDdONmlpaWo2YlgvckUzN2JLV1o0YUd3eGhBMnA1eEpGVHNZ?=
 =?utf-8?B?WHU2UytZOHZxWGVmNmNDQVpjaFFyQW9wY3IrR3VtNGZIaEo4d2p2TU1rYVl0?=
 =?utf-8?B?bnRaQUhzZ2lWQzFLUEovRnBSUktKV2VERENERjg3UFlPTDkvTXlkczI1NUFI?=
 =?utf-8?B?TkhyQUk5Wk9mRXBMazFIS25mUFRNcTFIcjIyS0NPYXVLRXFkT3dqVkVxRlJB?=
 =?utf-8?B?eUlBODlycEExOHFkbTdERndzRktNSjJWMnRrUjJUMFpQRDB6UVN1RGJyZ1JT?=
 =?utf-8?B?cGpWMzFMMlZaUjdJd2NWOVVOeUZSRHBiZ0p1cjBMWnB5TDlEK0ZkMDFXZjJX?=
 =?utf-8?B?M0U4T3h0MGJYN1I5WVN3TnJ2MzRGZ00xTWJublZuOERyY21odSswV2R6YW9n?=
 =?utf-8?Q?FCAZqrjLmOMr/Zdl4A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWFVU3AxWWdSRXBrdFd6czNNelowam9kRjZXeXQ5Sll6bnFySWI0L2puV3pU?=
 =?utf-8?B?WkRYSHowOGxlLzJuaFRoS1JXSTFvZ0dENHQ5WllyVTNPMGlabHBqTHMvWFd3?=
 =?utf-8?B?aEgxY3NZZkdRb1JoSXhKNEJteEw0emZJMDRtZkVpSmw4TzJpc21ucHpYSzI0?=
 =?utf-8?B?MXJ0TnVXdmxOeWx5eWZBVFZQN2ttTUd6M0lOR3ptQ3ZMVmpCcTlvT0dSOWU3?=
 =?utf-8?B?bXhMdXN3MTZVeHdaM1FwWEtoOThENWJLMjY1QVNxNmljWnU5dEhJRXFpQ2FL?=
 =?utf-8?B?K2NuZlFhK1dESzd3Y24rUUpVUzYyNVdpb3E5YWFPMzF1YmVZSTBEQi9nT1Q2?=
 =?utf-8?B?dGlmUXdCQ09JMTVSQTNQQ3FpSVY1L01kSjhRM0MxWHlJa1FVUVM0T3RuS1lG?=
 =?utf-8?B?biszcXBDMjJjRnZ6MEQ1YXN2b1MxU1Y1WElKWkpSdEdrNjBSYTh0Q1YvdzZq?=
 =?utf-8?B?TFdzRVYreFZIM0xJakUzcW9YKzZuU1dsaGlLMkYxWWxPTjdPY2FwK3lRV1VH?=
 =?utf-8?B?cGxxOXR3WFBiRlhuYWd2cUdBZVlWS1d2UktVdUx2bkllemM0d1k2Tk0yM3c4?=
 =?utf-8?B?RnlhSUlaeS9ORW9FQ0Q2WjE1UGFxWnBjZm5VYTg1RVQveTJ5R2xzQmo2Y3E2?=
 =?utf-8?B?TTNFM1ZrSVVsQWJvTSsrRFRPa1MrVGZuMFA1OU9aWWJaNWVhMFBHemE0S1hF?=
 =?utf-8?B?UHRTZXNaRlJJaCt6QUxDRGhpTllPeEhtTnJDczgyY2NkNlhxZmZPQnArQ0Vs?=
 =?utf-8?B?bWJQVE55c1RRc2RHRWlDcXJJWHBqSjQyQUJUTmppWDhjVTdMT2x2QTd0ZDNS?=
 =?utf-8?B?UldZeDg1N0tNOHJSQWVzTzBRQzB3NlQzOE9ZRWtVRVRINDMraG5yRmQ4eHNy?=
 =?utf-8?B?Z3hiZFdXaTZhcUZJeDMxdXE4L3QyaDVRUlNpc1BNcXZ6S1ZRa0owQ0NoYXVp?=
 =?utf-8?B?UGw4bnVsWDcrVmNrTXhHMDZySlBBVk0zOTJmRXUxTmJLNWlqWEZVSlpFNlhY?=
 =?utf-8?B?QThxVS9yUXdtb2xNcHFwSUNxQUFraENJTnEzUEVoLzJWS1ovTTBOb0xiaHNp?=
 =?utf-8?B?M1JCSmxld05CWCtpNGM4aU5GZEFrQWRYc2JwT0dNQnI1YzB6ZVZWZ3pGQjR3?=
 =?utf-8?B?UHBjVDA3NmUrRm5OSElub2RLcnlYc1FDMW5DUWVjb21aemsxSGh1ZU51RTdZ?=
 =?utf-8?B?UC8vUVBheGVGUjhlTjNXU1FRMU1td2E1ZkFVeVVWRElXWDNvSG9IVVlnZnBk?=
 =?utf-8?B?bk1XS1FsVCtUN3ViSTE1Ym5KeG9ZRkNBS1VKTjNReFdFMW5aWUZsNjlUU3R2?=
 =?utf-8?B?R280K1Q4cXF5bjVJcFdkVnMydDZUck9zU3hhZ04rQTZEY2w2dFkvZk1SK3d6?=
 =?utf-8?B?bFBLeU5xOHZ6di9zaERXUnVibHlwNlJlWWNyUnBUVC91QWM5RDlEaThyQVlY?=
 =?utf-8?B?QWtxMXVCZHg2cFpRQ0pIajlkQjdIM2dEeVAyQi8rNWlEZzBvaEVoQ0d3Y0FI?=
 =?utf-8?B?S0RFVmp5L3g5akJybWRxeFAzNDRCYkVJN3owZW5TYXBuSmcwRG9vWkxSaUJw?=
 =?utf-8?B?ZVZGRzB3c0Z4WHo3THhZZmJySTk3K0phT3RzUEFZS2wwQTVEWURRS25LcWtE?=
 =?utf-8?B?S1E4cHZHR0NLSnVHdXVjQWVmbXFGMHJHU3FYSTFnNEpLSGJvSE1wL20vL0tR?=
 =?utf-8?B?bDdlVmNOUEVXWDM0Y1VWZldBendFeWJnQkFTbnVKMlpYRE1KKzBlbTI3Sm9L?=
 =?utf-8?B?c2duOFNVeUM4Tk1yZER5LzNTbFIra3hWSjMvVFVyN1VsRWdEUCs3VFF1VU9t?=
 =?utf-8?B?ZWFkcUs1dlNadDR6dVR0YXVXK3JyMkRTUFhZRmU5MHFUaGZDY241VEVYUndW?=
 =?utf-8?B?QXNxQlhEUHRTZFFkVUg5bS84WWw0b1RPSlNKcWFYUXFlYmdXMldwTnJSWXFp?=
 =?utf-8?B?MUZHNkhHbkpScWVoOWVXQXU0NmFVTE02OHZWb090MGF5eDF0dnUrYVErY25C?=
 =?utf-8?B?d1V1N3JyYTZLOUtWZ05SeFNtZVN1R0NZellUT3RzWUJsbHhMalBvWGxwTnNl?=
 =?utf-8?B?UmR4aEM3R2FHWks3MXczRkVtV2tnaE5TSVNzWkZkN2NYZFBZYUhKWHVMQ0lU?=
 =?utf-8?B?Z2J4dkk5RDFJU0EvdlU2YnRQLzZKMjRKL1N4T0lBN3N4ZzBiTnNIOTdTTEJS?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cpky87wlYlIHWLfg6yGQ0Nh6ft7A1q+tM+1eKpeXZLcUImgESTkq9kjRbhg7rxhOEaDXbEvWP+JwjvKeD2WxsfS6yRjbd8VZS4sj9Ktb1evyXYz2xJdUSBu//2uE43hEQ42wfvhh8UJtYt+DYWl5sFNGQX+BdVP7BrsfOs8TlWg1e7h2/MFXLxmArQU1RVByUaWERV5IYpAX5vOBdgZw07cz5+O4MTNH3XXOfNfE97lyGIPT+Gv8dSdYn8FAhBWmOG8RpE3xZla32nRmjhODFjjAVGj5Dkhu3i2/F5Tx/PUgvKgL/te5itrp5xC9vytZauhGiSDlfUia6FAVXH666WndG/6HQcqZbaJhGD0SD3eJrcUUGldbZ8N4OYuPfJ49xU93MLA1iq6ro8X9xp4tRiOV1XJDRKcRIBMgIB77w1wsTkho/r1UftZAKp2h5xfK9py2OxrDgzn04iugC1UnO6jyDIeQ0E4rzm79lfUlHnObVusYiEnPiJQtUlUsjcNTJsus94tL/usTSPgPUvcHvOWE99ecHe23zwUJP3RsZKwd4to8TRuoZaN4WG4bCpJeaHmxqaKEB1lZfmc5T8OqEmgpYCl5ZxwIOGPYwNUO6WI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4624a75e-66a9-418f-9eaf-08dcff6d6a4c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 20:47:38.1083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHFP7HcLBJFWXKs2D8ppc252DYJkObrU8FHufmODCoKP5OXtKWQVeWkvYc9ETKoHtqbi1PvwGergk6bvv3Ytk/UMObsotEU9x/jy64N+irY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_09,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070162
X-Proofpoint-ORIG-GUID: pqyZhAoJhibc8JdPPW9WHybVOI7cG_gf
X-Proofpoint-GUID: pqyZhAoJhibc8JdPPW9WHybVOI7cG_gf

On 11/7/2024 3:26 PM, Jason Gunthorpe wrote:
> On Mon, Oct 07, 2024 at 10:13:23AM -0700, Steve Sistare wrote:
>> Add selftest cases for IOMMU_IOAS_CHANGE_PROCESS.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   tools/testing/selftests/iommu/Makefile        |   1 +
>>   tools/testing/selftests/iommu/iommufd.c       | 148 ++++++++++++++++++++++++--
>>   tools/testing/selftests/iommu/iommufd_utils.h |  34 +++---
>>   3 files changed, 163 insertions(+), 20 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Cool, thanks!
I'll post V4 with minor changes to the self test code.

- Steve

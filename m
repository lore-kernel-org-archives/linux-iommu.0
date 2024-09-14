Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409CB19D889
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726319997; cv=fail; b=pNu4ZOqbiJHFUau8MITloubEUVTvW/vaoz6ibXYYtCW3rOKsbcIgPWWp63F2sz03XUYmnAIVM5XygraT9xY6Fy4t89xFRUqjap7F+jPE+KopFzpmW9ECxnC5sb64j2HU2nS5jnEHAjLwazrsT0F96FtIhJEv0JzTH4e6DPAMmTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726319997; c=relaxed/simple;
	bh=RXnfeus1RLaL6weDzXUeM1zmG02OBbNbMUYPHMwgX3Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dnLYwqGWh3jdbm5DiOrZZRvPIGImUHbvkbgvrJ/XoLbIE6wngzRYr6Q4xuE6Na0uaPzNKLIB23RL8he74UBmw9b9ZHcSSlZtqm5OX1y/S8bRNIuFWIeSJS9PrtgwuObif1qq410mCMpUTlklGSh7lWZwzsKoCW8lGWTaNNsSKZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lCALaBvl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wk/YHtzB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lCALaBvl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wk/YHtzB"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48EACpjC015033;
	Sat, 14 Sep 2024 13:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=t8ZR0g3AkXJw2jZIABId6X+m8v3KYAkfyZ6N9kHCCN8=; b=
	lCALaBvlTXttK+SKOhegU6XvYfyTiPqED7l/31tuTsO7/JJuYwOC1XroMw8K+RV6
	DS5ZIjLBCk5wOSXxy4QvNBnWKd03ihmm/5j+OWzYdVwRM32s+x/Rg4GxRAx7O01w
	87wBt1m507wDXgZXHo6ClneloCj9tNsJRAkOhgNjve/Y1w/r4trqpvp5VWD7xOZC
	E4gTobUTsANEkiOilzKHVjj3thcBMV/XGiXiBPBjj9WGQBxchAq6SQONjsXtEqMt
	W+1U6lzlvNvMJZorKy5cJMEczenB+ciHK2SAxpcQHzsHQLhTQ4jnTGPGjFjERZkN
	g8AtZzLbgckZi+ZFzhnoGA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rwre8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:19:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48E9CG2j002198;
	Sat, 14 Sep 2024 13:19:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41n0x6a69h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:19:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElUX8lVQ1eohSSykyfWsRZ7KWtoQT/gxJsnobwU+tkkhSDgERzNl7V3ow4zljpIzHYMRgAX4X3Rum0muVqwu5sgDV4rM0qatHlo19HFDAgRsil24RIZPlsM9AM0y1dQcoVwTWLE1FmYOnYZC9CCQfyTlDMmWR9fOkCPa1Fuf5539SqN4zQ3Y8Gh8OrRkYkPMXUSSaXMXTovR2glo1mn/MbVD5egNhBNR6O/H7i3qRtea1y/z0huyH+r4mBO5jy2i2w6HP2lRECmKuts4oXb5ZvLAOQi02syvICI4MmA0VYbz6lkeQaD/Jph7LX+X9CDtc9CtMmDmLwPUvh6aBDjNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8ZR0g3AkXJw2jZIABId6X+m8v3KYAkfyZ6N9kHCCN8=;
 b=vElKTOB2xU7jCEn+S9Q0pL9pyzuH8Ajv0vy79heM1aZrzYT5PQO281+lELGxnEGtvbBBSlqzIZ7++sxJSPV44UobcQ/EUu3cVOYTr0Mu1HTt9i9Nvc/6exkr0isVKGsnsSQbo58exYrOjuVUa2fLfSF0CzUnPKRb+mx+ZZhxHlIbC7eRqY0BbYEZEgn6UK3R5bd2VaRCRaYAErY8urQ/ybYup84TK+U0N0t1bMkV8QlOVXb7z903NjAXmSjoBwND9/+1F/k+sBX4NImUnNuGrGn8N1uCERgchZmgA62fUDX6FgMIX3nfVmUo+sqPcxeSB745KZwAbLGRpmZoiEDwOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8ZR0g3AkXJw2jZIABId6X+m8v3KYAkfyZ6N9kHCCN8=;
 b=Wk/YHtzBQaT23n/NdSoh10cukSyfYph8XdGBFXrYaD2lutc6DBTd1Uv8TJy9gx95/H7o3F0bys03QAxBmstJ81nXl7Mmb3ARR6Eq2ZrvGUGX3dBkq1n7VYxelRntTYFyDwbFD1NeLBBS/CEIbvYMfIfCOJaT7e9+bT4gUAv9QF8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA3PR10MB7000.namprd10.prod.outlook.com (2603:10b6:806:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.10; Sat, 14 Sep
 2024 13:19:34 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7982.008; Sat, 14 Sep 2024
 13:19:34 +0000
Message-ID: <d25fc25f-34aa-458b-973a-f7de2438b837@oracle.com>
Date: Sat, 14 Sep 2024 09:19:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/9] mm/gup: repin_folio_unhugely
To: linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-2-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1726319158-283074-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA3PR10MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b784dc-6758-4cd0-ea26-08dcd4bfdfe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0QzS24xVVpVS0xMZ2VOTVZ5R2JEU25pMHd5QThZZWdrWGUwbXRSb1drZGVX?=
 =?utf-8?B?OHdRbWdzUFNNZWNCWWxZN1VkU0JpUUVmWmRmL0lSWmxzWVZVanlyMWJrdmp3?=
 =?utf-8?B?MmlWSm0yN1pjUlBvejYvNnZ2V3VHQUs0bjZEQU1oSnpZVGY5elNaTldXcERG?=
 =?utf-8?B?bFNoMmllb2N3aCtwdGJIZ21IRGM1RmhwU0xBd2ZESEpKclQzZ0QzYXYzSXp0?=
 =?utf-8?B?TFQwcG5HL25yVlFhSm5JUmdWM3pDUGljbkc2dk5CY0ZGRzIxMVExUytFT1Vn?=
 =?utf-8?B?d0tteEw3Qk1BSUx1M0RMV2hOc3F4U3Viemg2QUJsRFlmLzIrclhtcFdweFZW?=
 =?utf-8?B?bVBmenpNMU1wcFRXYmg3bW5VWk15UmhTNEZ3ZnhKZmdVakFIZ050bkllcDJ0?=
 =?utf-8?B?eTJhTUhIUjF5bnBpQk9MR3dURHd4OGp0dk1UWk1zNjAreUh3MGxUMEpnYlRK?=
 =?utf-8?B?V1lvdzhtNDl0VmRCaE55VWNERjN2WHhpR0JKYTVXOEhXUEg4eFNEYnQyU25w?=
 =?utf-8?B?RjdNcnp4cjRQTzJlaExIOXhxWjFlb25lTHRaaytPWkN0T2Q4cXlGNjhOcjFL?=
 =?utf-8?B?djBRdTFjNWVTOTRmdjFOWGM2bTJrM3pBaGEyVDIrem4rSkU2azVJRCtqcTV2?=
 =?utf-8?B?c1U4NUg3MXdxZ29sS2J1TVlNYjlvSkpISTlJRXV5akhjRnB1ZTFuT0twMUFN?=
 =?utf-8?B?bktVYWlQWUlmbGJDUEdKVjFkbWJZM0JObWlaU1VEdEVmU2pTY2pMVjg0V24r?=
 =?utf-8?B?OFlvcEhNL3pxSmdkSlVyQ09tSGNDdkphNXpRQ0pvTGxvbUpUSS9ZVGVUSmhl?=
 =?utf-8?B?YjIwQU9nWkI2d0RDZ1pnQjNoL3lvUnVBNitpa2ZUbXlBT0ljMnhFaGhNQ2p4?=
 =?utf-8?B?WWFzck5jNDZFWmp3U1dYSEZFQlpGOUF2U1d3Ulk3SkN1bStnUFpnS0FBUXJV?=
 =?utf-8?B?S3FiNnJEUDFBNmRvVFRDZFg3NG12UGxjaWR0QkwxMk55M0hVQ3RGUGM3WFBl?=
 =?utf-8?B?djdCeE5FZTUxRXVDVHJHd3puOEdyUVJBajVONGtGVk1QSFJRbzNqRC9NM0Iy?=
 =?utf-8?B?TElaQmdPM3E0Q0xEYzE0MjF5c2FhVjIrbDRHenpseDZ0eGVYTEZYcWtnZm8x?=
 =?utf-8?B?OVVrYkFSTTVQS21kR1dWUjNBbjhWWW9Jb1NHb0dIU2dqOEc5SlBPYWthMlFv?=
 =?utf-8?B?WWNBcDZPREQ0eHIvWEt3aFB3VGx5WERROEhIZzZWQnJGM05yc01iZTJqRzI4?=
 =?utf-8?B?enRBS25LM3RGN0JwdlNGZW53Q0NLQ3pNODN1b04zaTBPMmFGOWV0dE5SVVNY?=
 =?utf-8?B?MHRoWnlTUHpXbzhTVG5HcHRRTmFVdXdlakhuLzFOVE5ZZk1qRHdIbzdSdWt0?=
 =?utf-8?B?R1lwc1JZdUxHa0FadWdJaTliZ0p6TVluVktWaXBGSW93azFOZFNGUSs2ekVO?=
 =?utf-8?B?bXRJNnFnTW9tVFJRZU5WbjRJd3I1b1BwVTljTFk1S0tqN0oyRHByVEpwRTI5?=
 =?utf-8?B?VklBZ2lxNXhMSEEydzFZdmFWQXdKUFAzRjA4QUxVMVo5aU5ReGtoYU95dW1p?=
 =?utf-8?B?UXRjL3o2WkFWb2NtYVJQQXlWaGJTb3Z2ZjFzeVM5cWZ3UW1OK2N1cFhkZGxY?=
 =?utf-8?B?UjkzdlYzVlFWYTlxMG1jU3duNWhCRWZtWThYOHJGZndxcVk5ZWQ4djhnWWZp?=
 =?utf-8?B?YzVKMlRpeDJ4ekxDeGFMT0NNdE9HcHBTUllOZjJ6TkVxTGJVK3hqQVBNR1lE?=
 =?utf-8?B?ekttdDlIcDJtR0JsSWdYZVlBVUJuK205VnpWYkJVektkOXRSRytpZWI5YmdH?=
 =?utf-8?Q?nAwcteOr5cybgrUPeq1tJmhz6jcOPw9lnEbRA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bitoQ1dsRDU3K05pMkljcEJOeWpMSFNaN0V1ZjZKZmQyTjF6TGsxa0RQMFlV?=
 =?utf-8?B?YWw3ZEFITVFWT2ZCTWZ6aUpnSURnNWdqOFVlaTZxODBkR0RzbHRMTlBHc2E2?=
 =?utf-8?B?TVk5M0lrT2RTZFFsbnBmSmZWblV0NVlaYlU3SVlFR1hndEQvbnVkc1hjN3V4?=
 =?utf-8?B?U0hTWlJoajRmc0hNK0dtZTd0aWNSci92L1ZqSjhBRlBqQUZCdm1ieG9semFZ?=
 =?utf-8?B?MUJpWlpRY053N20yVFpCMHdUYm5RaW02YXkxQy9mRC8rQ2lvYlhvbXd3MTkr?=
 =?utf-8?B?cDdWWjFvKzFKUS9ZeUdTRmdmcmRDWm1aSVVCMzVQRGR2TUMycWVzbTR4NVh1?=
 =?utf-8?B?aE5HTTJvbGxZcFpmNW1JRlYvVFoxSW96eHRLazE5bzJzVFF1eHNWNHR0QzNF?=
 =?utf-8?B?V3lhNUJab01LcUh6V2hOcVRaQUZMVk91QWRYbndBeXd4SGYySWZsNHcvdWNE?=
 =?utf-8?B?Mk1LQ0dXczlsZzZhTC9EaDVrZU9TUGV6NExWd1JGcER1UW1USnJKUzN2eDdp?=
 =?utf-8?B?dnZXV0VPdjFVODZYTzBvMnRYa1pLMkhVcDQwWkJ2Tmc2Q2tJYkhwV21WcitG?=
 =?utf-8?B?ZXJFWkJDTVBvd2U3UlRHd1Rsd0FpK1psMzFvOThieFRuaGtRMzRBejBrQkJM?=
 =?utf-8?B?QTNPMExoV2JrdEZoZlVpTytNZTJMZ1RxRUczb3FNalJ6YVQrTThqSGs4Y1ls?=
 =?utf-8?B?ZFBKREwwaitoUFVKeDlCZnRqUFBIdm5nTzd0MTVYU09rY0JqY1hvVVMwdVdB?=
 =?utf-8?B?QUtFZE1JM1o2Y2NXd1N3dWlEQmdabE9TN21LbithcDZHNWVZVWxYSy8wNWFi?=
 =?utf-8?B?enRlNlpsU0NiSzQ1Z3BpY2M2MDc2MnN6UllWQ1JzYnlnQUxDalk2S0N0U0NL?=
 =?utf-8?B?MlVjS3pTT0pUazg2TnFremliZ1U2STRaTFRmWWZncmdwczZrQ2RrTms0OGhD?=
 =?utf-8?B?ZndvcDhiWmZFUzVRS0EwaXh6SFdTU25yWDlyY0svUHY2SEgwV2RmWFlvOUV2?=
 =?utf-8?B?Q0JEK3JDTGdnS3BNWFRwRDYrbVNkYXQrVWdWb2xXRjdZQXJvNERBOTZReWJ1?=
 =?utf-8?B?djhIN1A2Ymk0OFlEblB6NmVJdU9ydmM4ZmVKc2xLU2ZyUEZhZVN5S3Z0K0xR?=
 =?utf-8?B?MXd5MlpkS0tIeDRGQTJzbzRlRDJXeFFsN2U0cHNVdlZZSW8yRDdtUkI3WGNx?=
 =?utf-8?B?MEJheHRmakRNOWhMUHpsWkt2bGxDdk1oQzJFM2RxS0hESWcxdzMzdUpaNHBU?=
 =?utf-8?B?c2k1cnNVRHdOTk43b1VXOWtwb0hTak10TVBLZllxcERwcEJ5TUNVNEVKd29j?=
 =?utf-8?B?OXlUTG51TDdqWnZNenBjQkdKQ0lZR0pnZWpXLzR2WFhhcWNVS0tONTdvWU8x?=
 =?utf-8?B?ZG1pY2pLdmRnU0k1Lzc4cGhWcjNmbGxSbHo1ZGxXZk96V0w2cnNjZ0duZ2pO?=
 =?utf-8?B?bFFqV081dHN1eFdpdXZUc3ZmZk9rWDlNYUQ0TDBsZVlSaHZHV00xMG5LWm53?=
 =?utf-8?B?RThpa2Fla1FFbHRlL0dGTS9hKzhTRHZDN3hRbEVQT09KL2ljT1FvVnRJcit3?=
 =?utf-8?B?MVBvaEN2NFdhaFVaZVdFSEF0UEc2S0duWDExdTJuVHpKTmsveVFucEljOGRI?=
 =?utf-8?B?OTZCTUNuaytxZzdVTnRERWtQekRSMXRKZUZIV1pTWUlXckJnWGxQMnR2c0hk?=
 =?utf-8?B?Z3VZKy9ZakcyRTdkUjRETFZIQ2lMc3hTM2JMY1BGSzUwdWcwZEZNcTV2bWg1?=
 =?utf-8?B?MFIvMG9qemZUWWpJOGRWRnVQV1gwNFVJTloyTmhwdFo0MGd0b29BNlhkdHNN?=
 =?utf-8?B?SEpZRXpCSGl0Q1Q0Umcxajc3SnFOejd4akVpdFFDQkZXVmNTUHY5Sm4xdEZy?=
 =?utf-8?B?V2pVbnA4R2lYT3F3VXR6T1JvRE1TektINGVEcVBlYzk3RGtjclUxY2NxWlBT?=
 =?utf-8?B?Wkt3Wk5YR1MzNmNqUGl3VFJOMUdMWFdjbWw5U3ZNRzZPWXp1WitldUVlQXZL?=
 =?utf-8?B?dmQrY1Baa2ZvbUFpY2lKenZURmY1amdmZlJyL0hrODRpNTR0cHRUbWJyNFJq?=
 =?utf-8?B?Sm9VcXpZeXlBUjByQXNLOG1JaElLQnk3NUM4NVFINjFJSWxTcFBNN215cGsx?=
 =?utf-8?B?OW5iczF2bmpDSWhkaUc4S3VkWkhQeFJ0MmxVWFNUT016NzJRam5VNjdqUnpI?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o9YVYJ5vh0kNxT2sHj5JwXZ5asWo1XQ5Y4WJG/dfK06RragXNRSrZywo6ONJMhNtIUQQkC7Nh5vsqNFrVbIHC4Af7Mw6tdjxoNgbECCkJH8YqrP/UtZSNsdudI/SwLn28l7+M4Ncblv3iSqlXFphWxnsCT8x2Z0aw59bB/FWu3+5pSBkApLzAo3j9zgKjlKIrzOYfbZNr0vD38AjYAl7BM+VEiA0rnTLR/DX7q1hpk4x1L8VEnWBK0vYIhIpp5ubIdp8BgGEVGPTkeSI3KYyxVZSOJ+3fssZtw/BhC42GJjercxU8dmuOJhyF0R4/aiYu69A+tk45i99+abzDrs8uWK5DMYofkS5dQ1T3LTW9cAEzGnzv5KZeBmnKEXGY39NACSnEiwaNxdP7LnEsrt2ySr0tLtCX1F2iCgopXDbmQKiyRKlVvVJ+goWFNakIDRjWgUekux9oLHe/l7Xd3MZth7Tha8yO6y0KFp5AcwbGR8JV9nrStqAYVZDrlhV5MjTMdBayVvzRAFxU8JgPjY+k++5tnJYKL6yO0mKQb72t5UC+nOLY6XFJhlK9PAMO8V76uThdJY4F+HXyNph6gnNVAv4IwV7FmgkINxgqDmVn3c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b784dc-6758-4cd0-ea26-08dcd4bfdfe5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 13:19:34.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivS72qGiQnH0uXDZeeMXQrqxX5bZZkU/ad/5V2iSdInts7hPQugjaxfjvgP8eMpVZyBb8q4B2MwOd/G/3sLMJ4Q1GVXrDQSVM72Dy2OwXkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-14_09,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409140094
X-Proofpoint-GUID: EBJdJrMQ20EDiLWWbGr91QCNjuFpM8lx
X-Proofpoint-ORIG-GUID: EBJdJrMQ20EDiLWWbGr91QCNjuFpM8lx

cc'ing linux-mm for review of this one patch of the series.

This proposes a new KAPI function repin_folio_unhugely(), for use in this
patch of the iommu_ioas_map_file series:

   iommufd: IOMMU_IOAS_MAP_FILE implementation
   https://lore.kernel.org/linux-iommu/1726319158-283074-7-git-send-email-steven.sistare@oracle.com

- Steve

On 9/14/2024 9:05 AM, Steve Sistare wrote:
> Export a function that repins a huge-page folio at small-page granularity.
> This allows any range of small pages within the folio to be unpinned later.
> For example, pages pinned via memfd_pin_folios and modified by
> repin_folio_unhugely could be unpinned via unpin_user_page(s).
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   include/linux/mm.h |  1 +
>   mm/gup.c           | 18 ++++++++++++++++++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1470736..ba8344f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2514,6 +2514,7 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>   long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>   		      struct folio **folios, unsigned int max_folios,
>   		      pgoff_t *offset);
> +void repin_folio_unhugely(struct folio *folio, unsigned long npin);
>   
>   int get_user_pages_fast(unsigned long start, int nr_pages,
>   			unsigned int gup_flags, struct page **pages);
> diff --git a/mm/gup.c b/mm/gup.c
> index 947881ff..f8f3f2a 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3720,3 +3720,21 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(memfd_pin_folios);
> +
> +/**
> + * repin_folio_unhugely() - repin a folio at small page granularity
> + * @folio: the folio to repin
> + * @npin:  the number of pages pinned in the folio
> + *
> + * Given a huge page folio that is already pinned, and the number of small
> + * pages that are pinned in it, adjust the pincount to reflect small-page
> + * granularity.  Each small page can later be unpinned individually.
> + */
> +void repin_folio_unhugely(struct folio *folio, unsigned long npin)
> +{
> +	if (!folio_test_large(folio) || is_huge_zero_folio(folio) || npin == 1)
> +		return;
> +	atomic_add(npin - 1, &folio->_refcount);
> +	atomic_add(npin - 1, &folio->_pincount);
> +}
> +EXPORT_SYMBOL_GPL(repin_folio_unhugely);

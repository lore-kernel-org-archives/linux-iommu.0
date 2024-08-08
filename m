Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A195D1EEE4
	for <iommu@lists.linux.dev>; Thu,  8 Aug 2024 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723144517; cv=fail; b=APZcRlv93PkO3wr9gL6DlncY9pe0c5OsN14D2U5chPQSHbYO+z9poJsC/Hb2SCBpKShWh1Gi4aZzxKwpF6qn9BNa33txHgTYdRispVV+uNezXvcrJ7Aeyd4PX5oj7VM0GVNiwbgYGq+sdQXAwEYRhm0dU5Z5UgT82ycCwVJSdek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723144517; c=relaxed/simple;
	bh=zNgLrfWFa3dy7pdtPP8onyayc2fsezKS1gxhSDTQY/0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sSr6y1wLURUM/Ijh4LmWxjxS38i9zRGbjjOUdAIKYfLHvrCXOrNtAOeUlVpPMUtdwrEkqRhakakVrcKEonBur9kA2UemyuqkyHfVlkMbTq8HB4lJmKvfu4Id9K4P6ki7hq3WD1CwVTZcRlagokBcKliPClfMhvp9DHuQHofrJyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A3KGaghu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ow68tda1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A3KGaghu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ow68tda1"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478HfTjD005632;
	Thu, 8 Aug 2024 19:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=u/UoThLZ7O3PsP18xPocDflWEHaRyNko+RfnZWpjmLA=; b=
	A3KGaghuikDVG6EUh86g+SLrIep9yJo9nYF8Z5V74v3sXGqDNzZCaLXmzlDjihe/
	ymUPUfHlAyb0+vHi4m5HuF4EMkQZ63xR7vevsHAtyRHJQSiqFgnRLrLgiKhI0S0z
	IgllXEhgXKFNFofg/BpoH4cqkHVd8cmR1m1KFOGTU9XVZ+TYR8nvkEscjFDfK0cO
	caXm7T5iatfZtq7IZ8cl2W5Jbva5GLjHGwwzoKSBknAudH2LT/4WZcg9+rPWPkmD
	XVKnXq1xElPByYdHezMWY842NB4z+8cUyysogGbB17Hn5XHxOHUSgGcPGChsOnOP
	K6HpbSOEpFJMoqf7WK7Exg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbb2tkkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 19:15:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478I1lqd037252;
	Thu, 8 Aug 2024 19:15:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0bqey3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 19:15:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrBaToR9qG2f8P5wJR74euplOau3Xq2atL9Q7CSTPPQYS/NziNuvyulvjzBTqBc7qRU21ErMiCoAGGKjRCftFyoNUmCxNaA6ik7AErtnRQs24Rpx8vAayKgeeFNMuxE/TD38XLIPs1Zfsw9Tj636cDRX/HvOs/mC3XXL98FgtzxVXbZ1mo73L/Uv9304Jm+jIHVilRQHd5lODLwpZOoQYJLxxkgj++WplzOpACdKU0q8jT1R7Pj9I8ft1xPIUZxGdqeytjjqEOLGS9NuhoGLdXjzwXJuus/TmIR6YSrKs1JAIRDU8IJHCRFSiXExr03Mt0kDBy2quR3ibPdmorRF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/UoThLZ7O3PsP18xPocDflWEHaRyNko+RfnZWpjmLA=;
 b=ONj1Y1+goVCcJytwT/iRDlZuFTw4SFn2UiI2uvSo3cCRWXgQQBEUDQAGZLqlM/VcUjnHvXoatE389SGE2n7cN5iV8DPG5KFMfmVoh8F7EUr11hzARsqYDJaOCc+EBLgxqFQ31I0b87F+wmrhYnL7b2vQwPkkW9Kq3JjFr0/jd2H73eEXQ3Hxp1F+WSwP4viWZhZ8FA7ZhwwGfiMdrQn/EmZzIeerAJOX9K8BzTHOdG0tvJ9j7beEeM4LrGpHa1mTeM/dyPBYhxdp5+/fdrbyfqnjC9Vg/T/eS2Z4Nj1PIE6dQBipYV+oBJuJHlo6156NeUBFdgIWYVMHRH37bif59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/UoThLZ7O3PsP18xPocDflWEHaRyNko+RfnZWpjmLA=;
 b=Ow68tda1SJNQR3BWEMFA0Xkj9FqaLBFfUkd9ih81cdvCe+gqAdAmj0ZtKM8JH7ODl9UIR87Z9gunIL6XQ9lMFIZ+/C3KHz//gnkornE2lYPTCSVNOWyBzCPigfPPJ9q65/zXo3IF4NsB9Z+9b2wPaDX0oZkN/fLzNzwqEuexR24=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA2PR10MB4794.namprd10.prod.outlook.com (2603:10b6:806:113::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8; Thu, 8 Aug
 2024 19:15:08 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 19:15:08 +0000
Message-ID: <54f33881-26e4-4b7f-bbdb-89f4cb207be9@oracle.com>
Date: Thu, 8 Aug 2024 15:15:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 0/4] iommufd live update
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
 <20240722155500.GI3371438@nvidia.com>
 <3329e042-e4b1-40b3-9875-623f26386609@oracle.com>
 <20240806125602.GJ478300@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240806125602.GJ478300@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA2PR10MB4794:EE_
X-MS-Office365-Filtering-Correlation-Id: da4b92d0-2855-44e6-0960-08dcb7de6aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0JHVVZPNVJESnVaWElQZW9SeDNMeWxzRUgxR2x6djVCcTNVUHF2YzQzZWJG?=
 =?utf-8?B?Vi9PZXVMejYrOUJJOFhuYjYycEZ5ei9FMUhNS1dOT2pxa0kyNnhRanQvMSt6?=
 =?utf-8?B?c0x5SzE5N0lHOUVXaHEycXc2Nk1UdUhraitQUzBhRzdaVWJJdlY4RWpKL0hl?=
 =?utf-8?B?YnpzaVZ4RnVTYnhEUDhZdXQ3a1FIOEk4UnJiaytnUytxVGcrTXpFL1N3ZVlq?=
 =?utf-8?B?V1lRNVhQTUZKVGZrWnlMNXNtRkJodmwxYUZ1Z0M2Smg4eER2N0RhMURFQmhW?=
 =?utf-8?B?QkxwaDZqa3VKZng4am9UdmxGRENoMVhsRnYwK0h5N2s5NjhOU1ZjRTN2cURo?=
 =?utf-8?B?djFSNW1OaEdrcm0wVUdVYWR5Z1FjTUJuZnFEYWFnZVg4eDNocThid2tSeXBi?=
 =?utf-8?B?T1RjclJXbFlmbnVqN29MWGc4WXFnMXdrV3gvbHJEc2xoNHlwQ256QjlvTEph?=
 =?utf-8?B?ZVFnREhlYTY5UDJjUnFvUWt4VDIwbXRvV0M2UHJGQkN3U1U0UFphMEhDZzhL?=
 =?utf-8?B?MWNTeUx6WXpadXVMZ2NkZnAyVm5ZVVBFWWtWbjRNenhyRjdEdmZuVUJvZEZF?=
 =?utf-8?B?ZGtEek0xamo0RUZrOUd0M09uZ0tCVzVGQ1RQSTZMQ3Ywcm1SNEQrYStZajRs?=
 =?utf-8?B?QzJ5c0pIYTlYVEJVUlc0Ujg5WEk5cHcvanVRZmIrV0doS2p0c2Q5M3NzTkxv?=
 =?utf-8?B?TldrejdSNCtaWU1IcTB0RXFBSmFaUXRmMlFSNWlYZmhNUTE1VFZCQUxSSmVP?=
 =?utf-8?B?eG1qWGtoeW5pZ1FHZ0NNR2dMQjFRaEFidFlwcFJqV0h5OFpMMTdxWjNteU5X?=
 =?utf-8?B?NmhZWUUvZ3Y2M0hmdU13R1FCdDh3T0ZUZllNUk1vWnh6alJDT2hSR1A5V0lu?=
 =?utf-8?B?SnZaNnpNc21ob2tIZkxzMWpIeU92T1YwM1BCNk8vWlJWQUxPMHR6dEhkdXov?=
 =?utf-8?B?UzluTzVkb0ZSVkg5U0lYSThLWXZSR3lSRTdiV0R4d01GNzVhY2hPYWk5YVBp?=
 =?utf-8?B?cHhlNjkvZS8wR2hJU04xcTc3WDdyV3VzaFJabEVUdmZlN2VTaWZqK3UwNlk2?=
 =?utf-8?B?WXdocFVtcXBxZUF6aS9CYTJ0QXNWMW1hRHp2c0FJYzhidU9wVFNCSU1KU05m?=
 =?utf-8?B?T21mbGttQzBodTFoTlRMTk9xby9qdURpdXBOMWFTd2xHaVNvc1RJVmptVlUy?=
 =?utf-8?B?TVROOTI4USthNE5wRmVtT1pxVlBiRllUZDFSa1lNN0xpU2w3TVR2b2I2WXR1?=
 =?utf-8?B?ZDM4d01PYkh2VnljcXp3RzFHWk02YVJaOHBwQjlsYlpXTXVQTWcveHRIRVR2?=
 =?utf-8?B?Mm8rRklyNDVaQTJSc3IxL2ZQWit5MnhsZDlHMHlOaE9EdEttSEVwa2krZnJx?=
 =?utf-8?B?VG5KQ25pOHZOc0h4UUh4TE9QeVVxSzRZOVBtQ0R5WExOSGF1SERhZFlWMGJv?=
 =?utf-8?B?aUF4VW92R0E2WFFBbndZL01KNWEyU2I4Mll2RzZNZjZNcVJjWEV6Y0U1Vmlz?=
 =?utf-8?B?YWZoMFlhekdUWUJyS1VablVGQkRYSnlMYjB6Tk1uOXJYYVkyNjZtL09iR0ZX?=
 =?utf-8?B?NlJOdDJ6cng2MzgvVmFVYUNIOFVVR1ZHcGxkN2hJdUNCYXg3R1BnZm5VbEJm?=
 =?utf-8?B?aWY1MjlidS80QUZBLzk4bEEyc1ZpVDd5K0pKbHEwUEwvS051SmlzMGJpbWtu?=
 =?utf-8?B?WWZweEF0cXozVDB1eEpOcEFqVHZtVndjUTVsVG0xTDA4MUdHMGR2YU1wRFZt?=
 =?utf-8?Q?gDRpqtvkxf94FMcqTM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aktjeUxZRXJVZjk1ODZDSE5OdEZUZlhhMmlxdWRLUVJYOFZkWUJneU0vU2ZU?=
 =?utf-8?B?bmtSQnc4OWhBZ3NiVC8yUmhpaWFMU1N4ei9RYjZCTWtZUWpRSmNSN0c4YlZJ?=
 =?utf-8?B?MFZxMGtjYW1udmhNY1dzTjZNdG1HTDBjTlZGK2ZweTZUT09teW9GejUvNFdi?=
 =?utf-8?B?TTNJd3BmTXJWeFNSSVRvTEVheVdJRmtzNDZNTnpINzZYVDZPQzJTd1owempB?=
 =?utf-8?B?RENLeWVQSXF1SzkrTitsdkxiRzBqTmRFU3VBOUJNekRPWVpXUUYyVEIySmhU?=
 =?utf-8?B?YzUrUk1BYmRBdFpKdjA2RkV6K0dPc2ZwVldZRFI5OFN1ZHRBSTlwUjcwZ3J6?=
 =?utf-8?B?b0RoRmo1eER1M20wNjcrNmI5OVpMY01waTRpbS9kanJNNEpjd2tMY1NBajNQ?=
 =?utf-8?B?OEhweVYwRkxaWm82Mkl2M0JrYWtLRktTNnRSaGYzK05aRWZkV0lIS0VRNGpy?=
 =?utf-8?B?Q1RpeFkyUkkxNGVqUzg2SnMyWDBTOWR3VDAwcEY0eExjc005SDRVOTFxS1BV?=
 =?utf-8?B?U3djeDFQM0pZM3lEV0owNGdVRktmaEVqc1p6Qi9BY01zc2M2dUF4SGRyRlRo?=
 =?utf-8?B?aCtMRkd6MCtSUXYvbmVMMnY2WUgxWitzRU83bVhpcUdHUUNhd2tkUFQ0dFZQ?=
 =?utf-8?B?RmJCd05sNlVTQXpPNXhlVzZDQmtsVHcwTTVwdFBKZW42RVNpNkViT2xEUXIx?=
 =?utf-8?B?Zy82N1V5aEJ1TjI2Sk9nKzBoYzg3SjlLdnV4eGlZSmd4UklTak5rdlg3d09N?=
 =?utf-8?B?YU9POUtLbW9WRkx6VERpS2plcU9yZ3ZLZXdrS2VaMDNsSEZkMGZkM1EvcjI1?=
 =?utf-8?B?R3FyVWhTM0RSN1FqSGpTNnM5S1g3dVNRcFJEb2QyWGYwVlNoVVFMajJpSDFK?=
 =?utf-8?B?YXA5QzlhVjdVN2ptN2xsc0FzWVpEa1cyVDFIMEFybXdtbUhuR1ZkTi9mTzh1?=
 =?utf-8?B?N2NGdUdyQ0NrTVB0Mk5MVkZGRVRSbS9BUEZOTWhOZ2o0LzBZNzVMQTBiY1Fy?=
 =?utf-8?B?MWFWZXg2b2tEU05TOVdWeVpJRzVHcGVhSWlWMHNWemd6OGU0ZzdWdHM2Wll5?=
 =?utf-8?B?dEQrMzV6N1FqVWJDdnRqQzN1QUMxVEdUakNNbE9nSG9wYzdYYTFSMFEwNzZM?=
 =?utf-8?B?SVRRazhVQWJTMTY2OEo4RU5acE4rYkJnQTJyQ1FaSzl0NWszYTNWNnY0Z1FN?=
 =?utf-8?B?bC95cmtFM3M4Z1MyNCt6VnhVM0xaUkJVTWZ3alNuVzhIclg0N2FFRkp2c3py?=
 =?utf-8?B?Rm9nelVWck1ibW1keDlGdlRWZ2VPRnpySGtOdDNwWldtS211Sjc0b1UyYTV0?=
 =?utf-8?B?SlN1NmRVazJzMldFQjZRcHQyMHdNQnZXQlk2NFFmUTFiU3RrS0w1dWxxcW4v?=
 =?utf-8?B?VVhvM3pYYnRYR1VoOXA4NGFEajNIM3pIalVlR2x2YW9nYld0aGpjSXVPQmFk?=
 =?utf-8?B?dFArN1pNUjBjNmIvT3B3UVBob3h4ZHdyZmZVK1BLODhRdW1MU2dGUFJzS1Ir?=
 =?utf-8?B?UmVNUFpNdEkxczVqKzQ0S0RJRVRSYW1VRnlFdmY1Kzc4cTdaVmFNRE5YYzF2?=
 =?utf-8?B?TDRKbEIyVytWK3FGbzZxNGNXUFZEN2xJV1g1dEpFcDNhdWZsSnA0RFpBRm02?=
 =?utf-8?B?QjNaaXBkYU9aNVdWZjZRNUFzL0xvUGgxRVh0M2dxSmczMXNHM1NDTjJ1ZUlj?=
 =?utf-8?B?SDFPbG1ncmYwSmdCNmMyZTVHcTdmZ281K2hySzkyVXlLb1BLcE03cU1XTUhP?=
 =?utf-8?B?T05WWjRNZnhsN3dtL3JVdHlyWTY2bGpxZCs3ZjZ4dm9uTUNKUTZvWExRZWQ5?=
 =?utf-8?B?T3R2QmdPRFpad1hPMUkrWkk5Sld0YVRYeVRoQTY1bEdWR0lMZWxpZ3ZNSUE3?=
 =?utf-8?B?RDlNSDFYMGVxZ096ZCt0aTd2NzdqUFBTRzNBSHFwU3FOajlCNG14ekwvblFa?=
 =?utf-8?B?d3ZLcTdUb0V2dGx2ZCt3RmJ4amdiYWJRVUlKTTNhbUVqMCs5RXhHWFlJZWJa?=
 =?utf-8?B?Rlg1bTRibU9SQU1CaGdTNFRZYTdDU1dyUFdTbmtwOVZzZ3dNSlBpOHZEQUdD?=
 =?utf-8?B?Y0dOYUR1ZzdsWmxXc1NvdW9qcmhBNHlQYTNIMTE5UXBMNVUrRjdNQnpTbDV2?=
 =?utf-8?B?eDFrTjlna05GYkJOeDFrUXRub2s5K3FyTVFtN3h4TmtFWGNGT3Eydm1HNmFy?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J55KKC+Vcx4i2w2E6UZqCO7KYV/KrSD/RDwp0fvSEHGocWRB6DX8jZtxtwLRrJ72OfOf1Q5Mit0EIW7jIsWd0ALC6uLuQIx1+NiyR8P8vq1b5MAgvJQyxi6rXWy6A/xehGHPE7LXVey+uM2envUEpjDDCkVlTybhmz1mUjSGEhumdn60jJCal9s/0ci2aPEB8FJWBOLrZnU68lBoL3P88BjYym4myXYd2xYTM5QnDsaHl5/oZRiB808dhJm24MOtKFCieeNS4jzgl7XyMmYV+wglCEZztLE+pbe7s6cyWS9+c0iZuzK7t3N+Ss5ccm7lp2vqCO0qvYwxHNtBfx6V6R5WgUCE2bTamtQ5BYWoM8ecmeWW+ii918lEhg/wxqwdMy3/p9WaIUDjheExQpKmA47Yh0zVw6s8DBP9x7lOjDTrvcLJjxkaTvrY/U4uLGwjdDVVzP0pIzVobboc07pIG6iTzjGWimo+Dcmjpu5V8XUjUuXtEfmTtTrg+fTlKQR6AJZsUbsOoz04H2t8JY02XFgt4QikxUgGlfmt8xTXl4s82kjnycqJ+6bC9ndQICYh3o+N01kiM/TiUQTfIu5cYlKR5k/zuTWPaVFmpCIpjZ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4b92d0-2855-44e6-0960-08dcb7de6aef
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 19:15:08.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHQ15dmh3cg7N7aURD1061Jzn9NhpZwuxkw20pm5FN/DdPCgOgNHmMJms/mTAtdT10x2BWQ01PspI+6fCKxTKz+rS6B8z05byciK2X7lM/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_19,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408080137
X-Proofpoint-GUID: kjCkjYmkIVz2UKk2D9KACqzGBwCd3xkG
X-Proofpoint-ORIG-GUID: kjCkjYmkIVz2UKk2D9KACqzGBwCd3xkG



On 8/6/2024 8:56 AM, Jason Gunthorpe wrote:
> On Mon, Aug 05, 2024 at 03:03:30PM -0400, Steven Sistare wrote:
>> On 7/22/2024 11:55 AM, Jason Gunthorpe wrote:
>>> On Sat, Jul 20, 2024 at 11:56:40AM -0700, Steve Sistare wrote:
>>>> Live update is a technique wherein an application saves its state, launches
>>>> an updated version of itself, and restores its state.  Clients of the
>>>> application experience a brief suspension of service, on the order of
>>>> 100's of milliseconds, but are otherwise unaffected.
>>>>
>>>> Define the IOMMU_IOAS_CHANGE_PROCESS ioctl to allow management and use
>>>> of an iommufd device to be transferred from one process to another.  The
>>>> application is responsible for transferring the device descriptor to the new
>>>> process, eg either by preservation across fork and exec or via SCM_RIGHTS.
>>>
>>> It seems Ok to me, I'm glad it worked out for you
>>>
>>> But have you considered using something like the new
>>> memfd_pin_folios() system so that iommufd is bound to the FDs backing
>>> the memory instead of VMAs?
>>>
>>> https://lore.kernel.org/all/20240624063952.1572359-1-vivek.kasireddy@intel.com/
>>>
>>> I've been expecting to add support for that, but does it help this scenario?
>>
>> Thanks for the pointer, I had not seen it.
>> AFAICT it does not affect live update.  The memfd is passed to new qemu, and
>> the manner in which its pages were pinned does not matter, as long as the effect
>> on the mm fields that we manipulate is the same.
> 
> I mean instead of using mmap's() and telling iommfd to take the pages
> from a VMA you'd use a memfd and tell iommufd to take the pages from
> the memfd directly.
> 
> Since the memfd is not part of a process or mm_struct it is not
> effected by live update's exec() and none of these gyrations are
> necessary.

The problem is that kernel clients (eg mdevs) use userland VA to identify
memory when calling iommufd, so we must update the VA's after exec.
vdpa does the same, if/when it converts to iommufd.  I cannot see us
changing vaddr to (file, offset) everywhere in iommufd and its clients,
up through the mdev code stack, can you?

Perhaps I am still missing your point.

- Steve

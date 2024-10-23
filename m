Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778071B654E
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688680; cv=fail; b=E2qWm3VdyDzHEpKH1wZpgv6yvtPZhHN5R6PywjJpo6+T+bl8UXGPkjQF8yZgYRQj75lizmQoxvVqZrNjh6rPzZ7pZ+LePYazgXyF39R4RzjSHSeen+RUi9rl6YAQbYuVG6jaJ7QuQzBg0VwSRnHQp9A67BYHrxLj3uKYI6PVdUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688680; c=relaxed/simple;
	bh=HAgkWfDHaub1zaz1TOj4Djeo6B6ZjVcPIN2I3kLhzHo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sJMQzqUOM/unE5Lq6UDj3u84fpe/5GHQmRXJLx48qCh3TTshhl4xJ55QFKUPERj5kMhbAwKotECvscsBH3amN7baerL2b/Ce3oMbJszOk9JbT+Jrs2BshgYz0hk1XQe0HVi/Ffev3HuiPbTNxXQQOFbQWhX2Ubjf/ajuoV/RmOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CvVGqHgD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F+Lou3+q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CvVGqHgD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F+Lou3+q"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBQWJY017377;
	Wed, 23 Oct 2024 13:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=V8+AGCK9fiI7z/ao88vqR8H4/IFg/HgxM9FuKqRGaMk=; b=
	CvVGqHgDJiTox9C0pUncRxzvf8I0vmHHPV2fI8RHl4t6eb25iwTsk78VU3im9/Lt
	n/vtPxkPQNUzuSV0KP+rNcuZDiQyuIJKnA5ZccmlpIStEy4e+DHIELyJa+jConlq
	rlvjmOAaHf8bkpjWDiOkHqbGIn+j7i53+nBZFSu4r21rgtjxF0o0B6MMA+3OD17I
	xH+ncH1/imUbWoc4LEPV8KOTwDqm3DFCpHYXOStchtJg+xYXekWHAD44KYBhkIDp
	m+H4n79PcV63wqfaJni93Url4D3HWUQzAiwMvsG3sHlnpreA3CzBwzWANvFEyEaw
	OWJ+FJ6W6Jsvi3pArVOMsw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c545861g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:04:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NCW5h0027484;
	Wed, 23 Oct 2024 13:04:35 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2sxxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:04:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAjwx6CzM/4vAo1HhPTDsB1WImWfUzppjBlPnngeIYw8VFJcsfKOSJnNMkLeg+dlkx2RcMueAJHwpxIsZBZkvhYKf+AUdus5a4iBhboRguK3WR+UeFlnife+Pv7gxq8QuZWJiXbNkeaG3day/leiS4sLCYXv45/ISHd2eDDkI5V5hQdfAVA2O7dYjn8ifi0GLfFqZjBqy7YzZF/1UzHnhCU2ahyP6Agbqv7HuA4JsvhK/gW8G8Mfhqf+lm4APo3abAV9qdxG7Gi7zVm5aMxG7fg0I7k06ldAzdQNbuk+hr3yLZ/UM8OvlBqDky8ev3vZ7u9OxRS30DyDNVBau1uYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8+AGCK9fiI7z/ao88vqR8H4/IFg/HgxM9FuKqRGaMk=;
 b=E6Zw2yQcEzojUGMpfhtHgXP8YDFb3+VwJVTOPunrLL+gStJFCgDvpZyz2oa5lzF0P++lk/nX+bqate2l34iz2bPtt5mUd5nzVsAJ2kmzoUE9l0QTnNadSDNqXvRVQtV5MEaSmERKqPPyF+NhKFI90TqaFCDhquMDsa//rcuprQgfgoNEL4auq+9SMIpRTLYYqfY4ULf9yiXEb4uWRwPLq2cu7lIKTHEJ1vG+8T0lzitBeHCx1zy4LWcs6h3g2Gec9PMx9GCyOPDYfeG9wibwbnqxY70xkzCluvMDjTS+zyBuEuD9S5C1+WJKymfkRO7isv+XrZEEJtZES6ZpPdbxWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8+AGCK9fiI7z/ao88vqR8H4/IFg/HgxM9FuKqRGaMk=;
 b=F+Lou3+qRjmMHDOX0pLClzCTWZ4HlJ2s+wI32MI5ICMiAG/MtURPzo744iD4D7ZS4P0yLu0Y85nSURtZ8Qk5B6a7iSGErJnxtRU6MqQEC2noz690cRUxJam3pGu3LNzDVm+Tr1W2htkzoO2Dy3u66KV+qQpGqUyvvdL/5/nFjrY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BY5PR10MB4289.namprd10.prod.outlook.com (2603:10b6:a03:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 13:04:32 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 13:04:32 +0000
Message-ID: <dc951d62-1914-4d83-b1d6-378808276e22@oracle.com>
Date: Wed, 23 Oct 2024 09:04:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 5/9] iommufd: folio subroutines
To: "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-6-git-send-email-steven.sistare@oracle.com>
 <BN9PR11MB52763A8B95B982399E62EE108C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <BN9PR11MB52763A8B95B982399E62EE108C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::15) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BY5PR10MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 248d1388-7c92-461e-6cab-08dcf3633c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2R4VjJNb2p2Uit4OEVEYkNpcStGb3NJbm5JZkxuK0p2LzdXa3ZZSERTWHVE?=
 =?utf-8?B?M1RjTkltajRDM1FPRzB5aXM0b251a01ENUtvNXRwa3B4QlEvYlFkZ2dhTXRn?=
 =?utf-8?B?WHpENHNNa01zQ1pvNEo0U2ZwU0VBTUZxaFVCM0VYRWdZQkkwOUNGSmVFbFJ1?=
 =?utf-8?B?dytIaEUyVFdCOWZCYzZTNUhiZ05KUTNQeXh5REx4Rkk0RGpWalBKL1k1a1FX?=
 =?utf-8?B?RTZlYmxTRk9KbHNOaC9oUUR4SlU2eHQyWTdISGdtUEhGY2JLdnVySUpBNzVr?=
 =?utf-8?B?ekxNbU9MdmkrSEJhTVdYTzJCTzdPa0JmRkFacUpaTFNQOVk0QUh5VGRvUXdX?=
 =?utf-8?B?NTM2K1Y4OFhZNDg5UE5BeE1MalFpOW15by9rZ0liNWczTHo4UldwdHNPc1R6?=
 =?utf-8?B?eDFVNDQxWUlnV2hScjJZRlJsUzdiOEZBaHM1STZnT0RMSUJHdkNJTzZFZHg3?=
 =?utf-8?B?NW9YdEx2NWZRbUZqbUlJMUxrMlZxeUZoZmttSlJ5ZkhSZkZodXp6SnFFbWs4?=
 =?utf-8?B?Z0tRajlRVWNEcmVnb2dmNk5PV0tLMmZhRjZXV1FXVHhlTG4rY3FJcFJrNXRX?=
 =?utf-8?B?dVlicDdzZzFtczZMSGZvUHZGRW5xTm5kMzJpeDFaSlNWK3B5b1c2RXYvTFUy?=
 =?utf-8?B?aVdHbWtWU3pyUEppZ3BWNFJia2tCVHRyQ08weTUwSVI2S2JnZXRRWERmOWZV?=
 =?utf-8?B?VmZhM1JZZHJReWJQRDQ0c1V5VCtTUTljNGFScE0weE5hQ3Z5bDdjRXdRR3hQ?=
 =?utf-8?B?NmZwaFovbWxaaHVHSUk5eExuMGhoSTVFeWpObnFZbkpGV3BDbmwwYUVSYUFs?=
 =?utf-8?B?ci9sWGoza1lvZzJFMzRCU0w1Q1FPZ0dodGNMT0ZZWG51UjZ6ZlcydVYwZ2RM?=
 =?utf-8?B?NnoyeFNNQ21Odm1QcVUycHl2dit0U21TbVh2dlkrVUNYcUxqUnIzeTMvQzha?=
 =?utf-8?B?MXV0RXQzQzZZa2FnRU5tNlVWNUJ2c0lVRVRGdFg3ZEtEWUtWNHRJaldpYlBK?=
 =?utf-8?B?VFp0ZE81OHp5NWl4ejZIaURmZU40aXg2dU1RYVVYTDlSWGViaDZscHJGSkF3?=
 =?utf-8?B?MWFEQkZmOHJuRlVDbnE4WVZiZ2ZrbE52RFBKK3pZTE5yZ3BPMmJzclN4YlRm?=
 =?utf-8?B?NGtudFdzTjFtSGxGNVk4cGZLUTFGWlNtblUzQS9UNFlpMDJ3WHlXVFBMOFZT?=
 =?utf-8?B?SWs5THE0d0ZsZWhaUkpqSENvZ2lhSjRkUVZqc2x5bFkyWGJsbU51b2JsZW8y?=
 =?utf-8?B?L2RlZVluK0swTkI5dWtKWmZDbDcyL1RPV2RXOW42a1ZoNjZKbUl6NlM0SnRN?=
 =?utf-8?B?K3RadTloTGtpOFZKemlYMzRmSlVYekV6TldneHNIL1FNWHRTZVVrZjZuMlRC?=
 =?utf-8?B?NkxaVGZTWDYvYllGUEplSkZqcXdQSlcveVBUWkhWbUNTa3FBZFM5OWdXTjVM?=
 =?utf-8?B?TFMzb2E1RzVqNUVLT3Blelp0ZzYrVk1CaUs2TmxpaTZUZDRjRFUzU1dKVDRD?=
 =?utf-8?B?dVQ3c0RuYWF2dFdaVDVJQWx5SlVIcmZqNzVSU21BNS9lRWFMYXlNNXRpcE50?=
 =?utf-8?B?OFJTRzZhN2dIeGYvQ3cwNEpQaTFmbVhkbGJIRnJ0TU4wUTBYcitTVzZBaFpX?=
 =?utf-8?B?Zm1tYlRpdEpWNnh6OGIyaUFTNkc2bGVBM0xDVmRPMWhON2JZY2VjV0hOTjlz?=
 =?utf-8?B?UkFEWjg0NWE3NXE1dmlQNWdxeklib2grblYzQUdQNEZ5S2dWcjc2OE9JWXNM?=
 =?utf-8?Q?nH01nbaqFh8wc+safo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2o0K1krbXBqNkJaY2NMVHo3U0wxSlhwZE93WkVRdTBCWWZmMktUbzdkMWRT?=
 =?utf-8?B?RXNWa0thWjluS0Y1VmtQWkY3cktSTWtFcVQ2QzJ2QVhwWHhBcHdCME5IMnJS?=
 =?utf-8?B?NlBMZHR1TWtJc05idTdObkdLUDdTZ0NKWU5CNHREK2VhRmk5ZEd2cXZsUktK?=
 =?utf-8?B?YjNXc2hCQ1RYYXNaSlRVdmI3Vlh5UWdPVXFVWTBSd3dQTW5mOFA4bmNwK0Zx?=
 =?utf-8?B?VnYwQTIvZEpMeFdQTkdFRXRUbC9pMjQzQ1dNcnB0YUZSd05iV3ZVRFlzN1Zx?=
 =?utf-8?B?Sy9rNFJSNzVPdmxHMHdsbmNUQTNpaHJweTByaW93SVBPbDlGSWJMUTRud3ZH?=
 =?utf-8?B?amNhSmpRbmRtQ1RNbjZTSWtsbzRDYWJsOE5KNGFoemIxQlMwUW5QbG03a0hE?=
 =?utf-8?B?M1NBdCtxVFdFZEo3NmJnY2FqbjJhczdaMkdXdkRCZ2xiVUFjRWtvUkNzZ3k3?=
 =?utf-8?B?KzdpajZzakxPbng0MWdTT2JvQkNpeC9xTUlvTFJFa040eCtBRHpsZlVWb0R0?=
 =?utf-8?B?VUFGSGNsV2tDVUNEZXB6RWw5SXBUei93TXp5MWhzcUkrVGZ3ZWVkWUoyM3Jp?=
 =?utf-8?B?Z28wZFJ4Zm5LN095Ly9RQ25tNWdITWttZzg3TXlSbkFDSHFNUHZLbHI1aUJi?=
 =?utf-8?B?TzhyVlRuOGlYaHcrY3NZNXg0eWJFbnhQTWtFcTlmeGNZUWg5TVVkUStBQit2?=
 =?utf-8?B?UTF1VkZEQlJocG8zN1doaXVwWHRTVzY3T1hRTElMcndqdUJSTnlPWTVVRVB6?=
 =?utf-8?B?WENpb0JpRnZKTytzOEJ5U0ZLTjJUeWF3NmhGMTREKzh1Y0VkMjhhOVNqMlNw?=
 =?utf-8?B?RjhVNGVNbzZhL09YZ0J5WHh5bFZOSGdhNitQeHpza05ndEFCbU1SZkpwcXQ5?=
 =?utf-8?B?MVFUQm95dWFIbWowdE5VREdpSzhDQUxiUFFzQVJ6dnhjbGMyckd2a3lMNWsw?=
 =?utf-8?B?WmI1MkRqRjJJTVJWUndEeTRqVXIwZm1ZV2pET1UxSjJNWVg2Zi9vdGl5TnNz?=
 =?utf-8?B?MVlMNFYxTFBoc21tQkZjQTd6WDlyaUZVU2hUR0NqdFo4ZVJLYUZqcmhzOVl2?=
 =?utf-8?B?WHMyaWc4R1B0S2pMcmNBRWRRU1NUMGdZSW9Pemlnbmc1T2I1OVkveHplV2ht?=
 =?utf-8?B?cmVvRzF4bTBQMkhrNldQc2krUjAwZjZSdjZSbzJpK2tvb0RQaWZ3djFtcUVC?=
 =?utf-8?B?Y21Md1k4a216M1pLNW9ZS1Z3SjdtUEpyQ3lvVzdCL2d3TWNWSGE3azhYWUNi?=
 =?utf-8?B?MWI2TXVRN0pMak9sc3o5WXFSSVVQZ3cyRTVjMlp5RDUwRXlwZHc3WjFmNE5K?=
 =?utf-8?B?YkpiNjJmL1FRNStid1M5c3BsTXlHeUp6S0ZTbTlndTRaUVpuMkIwRHZHWDV4?=
 =?utf-8?B?TFE4NHVBMkVsQnFqWjVpT0xJd3JpNHdoVGZoSWhjQmgwYXVqZVhuM29CK0Rs?=
 =?utf-8?B?TzZPM2FsRll3amhYTWdPdU1HSkdVNHR5c3oxSHkxcFpXMTJNQ2xmSjh3SmZU?=
 =?utf-8?B?ekdHSmd1N1Q3VWJsOHByUTVUNHBERnBRYWJwOW1qQUU1WUZrWXZ0NkduTzdn?=
 =?utf-8?B?K1YrWHZJbUdvWFN2M1plSVRrS2YyNzdoNnVucmN0MzJjZkZZZXlZVHNzSEVZ?=
 =?utf-8?B?ZFB6cjFoVVVVcmJLTGFWUklhMWpHS1Z5cktPQjVLYzJ5cEZsNHhnOXExa29y?=
 =?utf-8?B?MTF1bm9LankzbEJiWmJWeW13U3ZsTS8wWWlHTGZ2SVhKVEs3Z0s3RWxMWlJ5?=
 =?utf-8?B?QmN6Q3NBMk5NZ045aWRyMU96QTM3UFFpZktWcStYcEJSZE5oSVpqNDc5am8w?=
 =?utf-8?B?MzZGc1pXMGhXUk4wSnZrbXROMEpwbll5elEzYzBZdyt5UGhJQmNCelhqMUcw?=
 =?utf-8?B?VkQyclh0elBMOWxmazhWcG5uL3IySHJqYlhadGJhNkkybE5MNWJXcVRxQmJK?=
 =?utf-8?B?ZE50SnNLNCtNS1JIemR3bnhuYXd3QXYrQ2hyMjJ5S3N6YUo5Qmxmdy9mMFY5?=
 =?utf-8?B?dlltcXp5aWlXNjVWRzVZOU5mVm5WVDdLZ045UXlJWStoc2NOQi9DTTZjV1dK?=
 =?utf-8?B?eDZwdHRlVGQwNkU2YXRKNFZRUzNXbmpNdEp5UXJPUG9LUGU4TkRUSkRvQ1Bt?=
 =?utf-8?B?Q0Myakwwejk5WnFud3hUeUJzVjBmN2dld2lFRW1TN0ZYeUJqcXpDNWdLMDZa?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BfSWg/pe94Wyz3e2z7UsYfHAImyedZJraEbIbL0xZMObbHNZBf6YWvddUOr8kE8DSeVtu7Ut/y3lexNiseZmKz0Hca/wizbmVyNgDAJegDAWieM1+NYLKoMSASzFnkyzWtwr4oV2/KZ7+pGjLV9WIOmItAHjuVWb2UEzdIwRWyMF/x6syUtzmI9MRsNvO1OqhVQSo/6IDvxmToMiyco/6/x4RsPZ+0+0nHeJ9pOMA3uJ3sR8Hk0GWHyWB/VWtaVgPqfi+MJJTDc4ttaf6EmynoNY6PxZ9msPgPWCCyADXh5pAQeWWbfMmLx4SyN6NoMnAtBuvX3sq+hpU1mrI0z8rQNBjRvwcyFLYEX6onphl0DZ5Ac25qLQBuIN2/+BxGaMP7WnQYDmdtM022TstR2IVbawIzUMoqr0uV45Rg8ZOCGgayk/+6fa8jZ2zPR35FPdRPObDQZstDcN8SX94r2BKZVj1I/Scc5LP9Vwwy/civr1yW63BmOFTjG9OWHcI58HK5WBEqeXmu+LmkgUUxVZHyrSuLRV9B6ZWEjWLFf98k19eQ8yVmjD8kBV4GeP7tx9y4g6wAeBWGe1kOfiUTe7xCj2Za0U4x+ZWSfyEVbbN00=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248d1388-7c92-461e-6cab-08dcf3633c88
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:04:32.4977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kWK50oyTvhHpsu0AdpDoP60vtVNFke58WWgHw6O632GuHVkm47yNUOJFi4RWSVdqAZdYkCPhz5pZCsMnXPVZYHjBNo4UezjpcSPlxGAv88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4289
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_10,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230078
X-Proofpoint-ORIG-GUID: -QYWmpebx0cUFNhGJ7EivYEn8AXpj6Cx
X-Proofpoint-GUID: -QYWmpebx0cUFNhGJ7EivYEn8AXpj6Cx

On 10/23/2024 3:21 AM, Tian, Kevin wrote:
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Sent: Wednesday, October 23, 2024 5:01 AM
>>
>> +static int batch_from_folios(struct pfn_batch *batch, struct folio ***folios_p,
>> +			     unsigned long *offset_p, unsigned long npages)
>> +{
>> +	int rc = 0;
>> +	struct folio **folios = *folios_p;
>> +	unsigned long offset = *offset_p;
>> +
>> +	while (npages) {
>> +		struct folio *folio = *folios;
>> +		unsigned long nr = folio_nr_pages(folio) - offset;
>> +		unsigned long pfn = page_to_pfn(folio_page(folio, offset));
>> +
>> +		nr = min(nr, npages);
>> +		npages -= nr;
>> +
>> +		if (!batch_add_pfn_num(batch, pfn, nr))
>> +			break;
>> +		if (nr > 1) {
>> +			rc = folio_add_pins(folio, nr - 1);
>> +			if (rc) {
>> +				batch_remove_pfn_num(batch, nr);
>> +				goto out;
>> +			}
>> +		}
> 
> forgot to ask one thing here. Could you add a comment here why
> additional pins is required only when batching more than 1 page?
> 
> it's not clear to a person w/o a lot of mm background. e.g. in patch1
> folio_add_pins() is introduced for partial pin/unpin within an
> already-pinned folio, but it's not mentioned to exclude such
> operation on a single page...

We already gained 1 pin per folio from memfd_pin_folios.  When iommufd unmaps
the memory, it will unpin each (small) page once.  Thus we add 1 pin for each
page, less 1 for the initial pin.

- Steve

>> +
>> +		folios++;
>> +		offset = 0;
>> +	}
>> +
>> +out:
>> +	*folios_p = folios;
>> +	*offset_p = offset;
>> +	return rc;
>> +}
>> +
>>   static void batch_unpin(struct pfn_batch *batch, struct iopt_pages *pages,
>>   			unsigned int first_page_off, size_t npages)
>>   {
>> --
>> 1.8.3.1
>>
> 


Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DEF13A3F2
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484517; cv=fail; b=uqbVKmoe8Gdn5nmBmnoVuytMQ6LHauiRghSxNXZFcH7Kh1BLUL9iZ9Ya9EsRMhKgNIZVw0h1NEtXgshgl1yDv5cD2jyjwKR+rdFme7rDKqlVclogh0kR/pIy4OetREMcL3yGZybKfyGKjqLZ4U1tWuzjkY+q+ItoQC2hoFdHWe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484517; c=relaxed/simple;
	bh=xtrTBhttyqp6kSDxeLmMTKm0JdSr1q9jaqIkJkaZZmo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wa+gAfpL8ygYHeG5B0pvhapftb9qiiX26ulMAnQ6/lMcnd6lQrQkomNGvioM81lh/EhOZS1SMBWK+PnvPLQtrPAjtRGuqlyQB5UZbFjTRmX2zKjlVH/YUaBKAo1ty2/bUpD4DNspUKAh8vl7JyibX9UMrBY8TJ0wPzHfN7Dlga4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MqCTpN9u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nFtndEnT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MqCTpN9u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nFtndEnT"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CHXnvN007487;
	Mon, 12 Aug 2024 17:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=AJ2Ebu6CeJC5EiD8srwFlvFfX3fEQED7DhXOcB35epA=; b=
	MqCTpN9u/LNHVS/coOUnSkH85bg47g82CvyhTPyRn15UnkWYg8OOhn1DYE3MdXQh
	uK1SRtI/1TNJM/a+eGeN8nTrEfR41XSTDm3dVCvKauurg2HiYbqkGzAIzouR6rlN
	lbUAwDZgnM9neaxgyU8nAIwwk9DT5VlJCjKaPj8fi8h+q3N5p8Wek+FyHII4pPj6
	g5rm2xUwrUf+RdHGmSrvfvPLmitKGZNq0m0R0JIy5O4H4YQSQ7hOGVmasri9TfZV
	cI0g9+SGFqMrnbe1Wt5/jvo1w7yT1gxH++zT5ADscal5lnKWkSPXNqcvwvQ3NP+j
	aA11kfNoOBRFew+UY7EkOw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy4bb8gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 17:41:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47CH2e8P000721;
	Mon, 12 Aug 2024 17:41:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn7e92r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 17:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rq1ZSTN0XPXZ/0z97P6afkT3Odqr5UaKIEpZRiAq1uBLsIlRKEBfC1NUMHEB1vrlLvWvg4o9cZZ7TO32b7iBy4jU04bE3kqneIfw+9M1/1YA94o89SH0Ov8pwfbWubGMekWnMYC4PaLYo8quhoI3JJhIFAqpYgjNBvxOnqEb3vYHszIZTKC/mCbK2mfXvFc6UM+3NXy2qxt+pbCmKC295G3D4+WAReVju6Er7JHld6MUTvjJU8cP4TjLgRdunBaGOp6K4yd+/Vj47ApvmzhHHi1T3ipTKzgzylHQ2FzHPQSPy7mUo0RTb+LhRXlLpMXbytFH5jYnizaFL8QYKhWblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ2Ebu6CeJC5EiD8srwFlvFfX3fEQED7DhXOcB35epA=;
 b=Udxgph3nVySlNv053BdPDnbHftW1FAR+NwCJaMpbg7BRGYlWgWQ+UsKAzV2yvu1xr5TzGiuDd7qOTE4S5c2Cn9H31/+k0w98PPff7FOVwsc/ar2s8NRe/7U8Y8IMPoJywBixIygxFGIxtyl7RhB3DOOPhD1fL+bsKKlU4LeWrE8HqhOAOK7McCrFOPrrYtmawyPmyL05oh01zNGtGvOqHl9Lr9kuOn9n9jZihX/xPEIJ0wvuESnagcR/ypSK7Btz7l4z27pInHDtiBRAVZ0yl9MVSflbDT5oS4o4oQsve0C2lTkXi6qJQ+CbUUU724a0K6eQlnwaFkVC8l9O/ACE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ2Ebu6CeJC5EiD8srwFlvFfX3fEQED7DhXOcB35epA=;
 b=nFtndEnT8GgTHaE6QPQONa8KoO5poJs98AJNBsY9IyPOpvZ/fkrR477ALhvIyz/sWs0+iWfimkk7jLEw6/TFXttYQLgUED/nRTJrtWY0IECad3Ej5+bY4b+nksrV1ADz/Ty6LFcxnDfRSPcF3zA6YIijBBLxtlmC5aksAwZq9TU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7850.namprd10.prod.outlook.com (2603:10b6:510:30c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.12; Mon, 12 Aug
 2024 17:41:50 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.012; Mon, 12 Aug 2024
 17:41:50 +0000
Message-ID: <53e7ab6b-9419-4808-b429-a88faeb3f6a7@oracle.com>
Date: Mon, 12 Aug 2024 13:41:46 -0400
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
 <54f33881-26e4-4b7f-bbdb-89f4cb207be9@oracle.com>
 <20240808195252.GE8378@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240808195252.GE8378@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0968.namprd03.prod.outlook.com
 (2603:10b6:408:109::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b535b9f-5f8a-4c47-9f92-08dcbaf60bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTF0OXdQZk5kNzQySXZZR1F4VElwd0dVd0V3NzlURHZPR21USzl4WjhaRUhZ?=
 =?utf-8?B?d2hoMDYzbHVQUTRIZU1MN1k1T0szQjF3cTR5NGxpZFFZQXlqbmhQRU5iSXd0?=
 =?utf-8?B?MVlTS0JKZEpkTnVNa0tUR1JMcmZGV1ZWOG5UQzVVRWh2QWgvNVFOclNqU28x?=
 =?utf-8?B?Z1IzUW9IV3pZWTlxVGc0QWlvTkdOZTh4dy9zakhGWDR0M1BFa0dtLzlHdkpv?=
 =?utf-8?B?M3o2QWxXb3NNSVBVUDlwOFNFSXl2U2V3bmJ5eEZWZmY5aFNJUHRTRjJCUUZh?=
 =?utf-8?B?d3pFNnNWMkhFdEpNYTFISWdvOVRGMVlpQUlsYldxalE3TWpWUUdkWHI2SlNy?=
 =?utf-8?B?ak1wek1BanNJMG91emtIeDdYWmRLVUFjWTEzbjhRMUM1NzVzRUU5cjE1Ukwv?=
 =?utf-8?B?MXdJWlFCdjdpVy9hQ1hMNm0yamNRMG43SjBmZE1yZmt4Zkh6UDBPbzRpZHhK?=
 =?utf-8?B?eklHSGNWU0pMUWo4Wk1SL1Z3aFFIRGVzNlBleHduMlo0OFhYcnhNU1o4ODY2?=
 =?utf-8?B?NDVZaU1Lb253Njh4eG4vVmpDby9IdXZTS0RpU1hCQ1dvY2Q1cnhrdnlLRFpr?=
 =?utf-8?B?MjhXUWtQNEl5N01ob2poTGhJT2FkUmEyZFBqVmdkRHlGbUJORkRmUE9YYkFD?=
 =?utf-8?B?RmVnT1VkKzdPamp6RGFCdnBFUk5OU3dBNk9KNXlDVTRubmNKZm1ndU4yN2Fo?=
 =?utf-8?B?NmszMitTdmluQklZR001ckh2ak03QnY4WEdyc0swSDRkcEZ5dEU2MGhreE5C?=
 =?utf-8?B?RmZWZy9aZitaTnFUc1NLUGpvVGFqaDMxc0liTUc0ZDVGK1k2OWoxNjhqWUFh?=
 =?utf-8?B?TGJqQlIzNmZaUGU0S3R6dTRTM1hiTEVIdG90S0FzMjJZaE43VnZTWmlJVjVI?=
 =?utf-8?B?VmlSWFFsdDBXUmFqRko3NFVMTEcvYS83UUM1b0VXVEJRZkFENEN5bVV0K202?=
 =?utf-8?B?Y0ZJWGZXK2UrTjdIMW1uSXRIZUN1REtXM2VPdXVaUDhhZ2VyUEdWTVpWR0l5?=
 =?utf-8?B?TzRFNWVIVVlpcHRpMGNFYjBGQXJtNHgzY3hFVnFPSFhFUFFxRnVWOHcxSWRC?=
 =?utf-8?B?Umg2WVRJQzYzVzRKN0VoeGdXZXJ0ZlUxY2xuQ3R5YmFSNlBjL1daUnlmcFhR?=
 =?utf-8?B?V3BzaEVBYStMQ0htZ0dLR3p4VkN0Vy9NTkdZOEFuQjJaUE9venVlSlgvRkdo?=
 =?utf-8?B?ZnVhOVVubWdmOFRIYStrWUVleDI2bFlIbk52QzYrTUM3cjZ3MSt5bStFcCta?=
 =?utf-8?B?UkZxc2lKRVVYUjBEdVhnSkdYek9qMTZVWEI2N2V4amF5UFdFZVBRbTczSFdS?=
 =?utf-8?B?WFM2Qm11OFEyNjhDaHVUM1lISmVXelV0aVUyQ3JHb2tIUGI3Mnk3YnN6bkRX?=
 =?utf-8?B?R0tPRjVKQ2pzMTZ4ekY1Mk9ZeWFaelBwekNCc1RDczFUVDRXWmhVUjc3WW0x?=
 =?utf-8?B?SXlrNTZEb281aDhuZTgxcDlla2FFc3pLTWUvZ2FaQ1E5Y25NemJSbW0xZXNW?=
 =?utf-8?B?ajFvOGk1ZXRVUkQ1a1FXUUdXWFh5OXI3R3paQUpzbWRac3RrUWczNm1OWS9a?=
 =?utf-8?B?eFBmWS8vYTJudis1UytIRFB3MEhPMlpTL2RhSXdrTnd2WXAxVzhjak9nUE4y?=
 =?utf-8?B?eTVRMlJPVXpiWStXQmUxWVJFNXYrUEpwb3ArKzFCM3ZvNXZzRWQ4WnM1ZGMv?=
 =?utf-8?B?MS9PaXdUVjhOczZhQ1J4bG9sbUhqOFdieDF2Zkk1aGVMSHFsSW1YQldVSkRV?=
 =?utf-8?Q?AjMfRvUBaju0DguSk4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEpJTGZBMTJRRDIvYXBVM0gxRTFuRkFTTURac0U1dk5uNFdtZzdJT1lVQWF4?=
 =?utf-8?B?bEx4UEhETk03c2tKZUVONzZSSTVUYW5WbUVWb3dDRmJZSlRjLzBwTStENjE2?=
 =?utf-8?B?bXhkd1JJaVhPUGhpMGFHTU4yODFLZ0R2ckx6NjJ2aGJ3YTM5YkRCeFdJZzVt?=
 =?utf-8?B?c0dqby9YT3ZxM0Y0dEFDZGt3RW5BdWc3Y1QvbzdLZ1gxQzJhZ0ZQSTlaTmZw?=
 =?utf-8?B?OUtuYjJrTnBXelJIM1IwSzcwTVdOQVNzSHdTanRlcFpYYUJndTZkZ2dZeW9K?=
 =?utf-8?B?RG1jMFI2WDg5bnFXUndWNkw5ajF2UjlzVzJYaTdBVHhjb0l2S3NINlpMNkJG?=
 =?utf-8?B?NEVkNE9leVF6YmNMNDBncDd5WUJVVlh1c0JmL1UvTGVxNWtNZm5PZzZCeDc5?=
 =?utf-8?B?dlFtZzlEZmtUNk5YUXVKMXBCWGk0YjRlMzY4cDlVV1pTZmJHeWJWVkM1NWdD?=
 =?utf-8?B?SVA1ditVeGg5ZVcyWDdrQ3lyM0lKVlRCdXJORHd0d0szdVRGWUc2NklubXY3?=
 =?utf-8?B?WlVVcWxGcjVzNTJ2V3dQQVprVmI2RGRFU3pQZGVMRkM4S2wvQVVZaERPWUVk?=
 =?utf-8?B?MDhSWm52OFN5SUpieUJJN2VpZWJJY1ZYa1h4S1VqTXdTMGdheWZpRk53WDlI?=
 =?utf-8?B?VmRRSUVXaUtPeGpXK1N2ODRPa1oyTVlmUk5lVWEzdGJHdWxzREgvQnRXdFEw?=
 =?utf-8?B?NlIyUjY2TU85SGRFWGQxTktQaGhCQm1VYWcvYjIzL1pjS2NpVXhXVEZYL3NH?=
 =?utf-8?B?SFMrWFdtaUc1bjBMNkRteTRnR241UityWlFXclpPYWs5SlNMNEJObTBWVUx6?=
 =?utf-8?B?MEVMSEk2YmJPMVByUktFRWxLa1kvQktxTm13TytNNmtYR1hob1l0Y25jZ0d5?=
 =?utf-8?B?WTlDTHhmM1FjbllIQUc1TXpaOUliZE5sNmRMYjZSek9TV0ZtcG95eWRvVk1i?=
 =?utf-8?B?TDZFZzFzVUVVYTRXb29kWGdnM0JYRzFnQlU2S1l5aGtzVVJETkdNSWVKVHNB?=
 =?utf-8?B?b1dlWXRmck5QWUFSNWptaDJ5NXRHQ2kxQnVnTGJSK3I4OERFMnYzcHhHeE10?=
 =?utf-8?B?WFk5dTh1SmNtWEdSRTRKNU9WTVdZWFRubFFvOEFIUXhBaktON0pUb1FneFBh?=
 =?utf-8?B?VjVJQUdHMjF0c21CcFlPZ2ZjNVgxUDFjNnRrZ1V4YldhMHAvL0lUd08ySnRh?=
 =?utf-8?B?elBhbEhweGc2TEloOU9QS25KbWRFbFRacXpraWJmV25mbHhXcVQxZVAzbnA0?=
 =?utf-8?B?SDNOdXpHY0dvdXF0VVBqaERUSFZHbDNmaTlJMHFaaHl5UURyR1hUdU40ZXBJ?=
 =?utf-8?B?T2cyS09PZlpwV2ZaeUl1cFNXTmkwMUwrTkdoUVNvYS9aVkFWdFpnSkdYM0Z6?=
 =?utf-8?B?YXlVbzk4V0VvU1pKcGU1ZlFHc205bHM3YU40WWpvR2lkc2RzazNnUGRkdDZ2?=
 =?utf-8?B?VEYwc0lqYXdqNFpLb3JzOWxDbk4xOCt5NG9TN2tXRklYRzIyaTduc1ZhaGRX?=
 =?utf-8?B?dWVhK0xjaHZzbDN3VjlxeXNMaHVuTGN4RFBtOVhnTHJnQU1FeUtJK09jUXZ4?=
 =?utf-8?B?UVk3dkhFTlc1NFBLeXlRQk9yUlcwaFJPbTczSkdwUW9rd3FwYko0eFNZbVBJ?=
 =?utf-8?B?OHZRSi90VGZKYjN2VzQ2VEl1RmhOa04zUDUzdFg5QnA1MTRFYWlkK3d3ZXVS?=
 =?utf-8?B?bTdEMmJ1eXU2anl3ZCt1c0hhekZiUG44TmxBSENlYUZ0NVJ3eCtKaDN4NXdJ?=
 =?utf-8?B?T1RYTkVmZEd5OFkvTkZoUUpGbHhySjNKUnoxUitsbjN4Tnl6OG12d0FnZGZF?=
 =?utf-8?B?M2w5L1hrZEpMalhxUVdOL2Nmb2p3aDNTQTd2Skg4T010Q2kwelJVT0g0Zzh1?=
 =?utf-8?B?TGd1OXMyMUZLZnVRMVUrVm1OdnVIb2FMK2M4b2IvUHFJYk80YUQ2K3A4VVlM?=
 =?utf-8?B?QmVPV08vMmZmbGM0dlRhcmp2aUdTNkkyZGp1dFpzSjFCbXlEdktLZTZ0Z2xQ?=
 =?utf-8?B?WUFVNi9xM2xZRmZ5UjcrKzExRHpUc1A2OUlTOFhWWTBFMHg4NHlOUVZ1b3Iw?=
 =?utf-8?B?YlJ3THhNWmFBampjYmMvRUQrdFRvMU1RRW9GOTNzTnp1aVFlS0JBOHkzT3l6?=
 =?utf-8?B?QVRCQ2hkVDFLbTJxNHBvbWVRUWlJNDNQcUpVc3QzVnV2QXRPZnk1WHNqYzVU?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	anhaM/ZpjhMBBH8Wu+pFx9NluC9coGa2GFI8pvQOdWk5r3CkGps0K9MwXbP4AYrj1YkaYvPG8lu/jbh+qdwgm1i76t9km2pscfx9O4HcK0zBMo2UvTdDNmUDv9i/iWbePxQjXwZpKp/xE97PSqUzaYKLd6mWJOSFEEfPAdVWkBwnIfTRWnLWRLMpcgxbXReI7LTBRWShJH+P0c6+w4y9fas2v5qpqIEzwuj+8kviWL0R7UcZ/J8FEf51Fq/i7cYNb1APnjZjj7JOrTRciLR0moGZe5b9J8qex0WnnJBak+G9Hbzj/brwidVSlbE7PsLnMb1P954kkVPLrCKlUhLu7S97o6Rh1rUBAhmdO6h06SCfoEYnLfY9jPb+XcaN5RpVVqjW19LiLHdku0qVDVj/1WYEnG3UKw+nzKxjPV075KFlyFS96TLjcudw91vDos3yLbVwENBJsDY29xXhoS2WukR4qoymXEdh2NLg0y1U1aO8ZGitj4iDzXX1V7K937DEiMFW7Ph1KyZ+y+/aTOHZT3sCfXeJij302Hhz6+BrVky2vSsn1+sLy73NBRnr6ExQTMlJmR/9euC1JKmnkzvsbZlKgqZiTkxRal4Z8SPFXno=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b535b9f-5f8a-4c47-9f92-08dcbaf60bc6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 17:41:50.3084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgQwsQ5x537sCuOYVNs+76exYYNX2ycR7ZPfzVHC9mfWntlVhT30DtAu6MA+CMs80YGORbj3zUCWKQ/S509D1dwj4aEaVaGY1jeFEwdGHZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_11,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408120129
X-Proofpoint-GUID: UsbgCtRxNVPKke7J5nLaATSvpjGZLf0-
X-Proofpoint-ORIG-GUID: UsbgCtRxNVPKke7J5nLaATSvpjGZLf0-

On 8/8/2024 3:52 PM, Jason Gunthorpe wrote:
> On Thu, Aug 08, 2024 at 03:15:02PM -0400, Steven Sistare wrote:
>> On 8/6/2024 8:56 AM, Jason Gunthorpe wrote:
>>> On Mon, Aug 05, 2024 at 03:03:30PM -0400, Steven Sistare wrote:
>>>> On 7/22/2024 11:55 AM, Jason Gunthorpe wrote:
>>>>> On Sat, Jul 20, 2024 at 11:56:40AM -0700, Steve Sistare wrote:
>>>>>> Live update is a technique wherein an application saves its state, launches
>>>>>> an updated version of itself, and restores its state.  Clients of the
>>>>>> application experience a brief suspension of service, on the order of
>>>>>> 100's of milliseconds, but are otherwise unaffected.
>>>>>>
>>>>>> Define the IOMMU_IOAS_CHANGE_PROCESS ioctl to allow management and use
>>>>>> of an iommufd device to be transferred from one process to another.  The
>>>>>> application is responsible for transferring the device descriptor to the new
>>>>>> process, eg either by preservation across fork and exec or via SCM_RIGHTS.
>>>>>
>>>>> It seems Ok to me, I'm glad it worked out for you
>>>>>
>>>>> But have you considered using something like the new
>>>>> memfd_pin_folios() system so that iommufd is bound to the FDs backing
>>>>> the memory instead of VMAs?
>>>>>
>>>>> https://lore.kernel.org/all/20240624063952.1572359-1-vivek.kasireddy@intel.com/
>>>>>
>>>>> I've been expecting to add support for that, but does it help this scenario?
>>>>
>>>> Thanks for the pointer, I had not seen it.
>>>> AFAICT it does not affect live update.  The memfd is passed to new qemu, and
>>>> the manner in which its pages were pinned does not matter, as long as the effect
>>>> on the mm fields that we manipulate is the same.
>>>
>>> I mean instead of using mmap's() and telling iommfd to take the pages
>>> from a VMA you'd use a memfd and tell iommufd to take the pages from
>>> the memfd directly.
>>>
>>> Since the memfd is not part of a process or mm_struct it is not
>>> effected by live update's exec() and none of these gyrations are
>>> necessary.
>>
>> The problem is that kernel clients (eg mdevs) use userland VA to identify
>> memory when calling iommufd, so we must update the VA's after exec.
> 
> Technically no, they use IOVA too and iommufd translates IOVA into a
> VMA and what not.
> 
> So if we teach iommufd how to do memfd it would also learn how to
> adapt it to mdevs as well.
> 
>> vdpa does the same, if/when it converts to iommufd.  I cannot see us
>> changing vaddr to (file, offset) everywhere in iommufd and its clients,
>> up through the mdev code stack, can you?
> 
> That is exactly what I imagine, because it isn't vaddr already, it is
> IOVA and IOVA always already translates to an area which gets you the
> vaddr.
> 
> It is why this series can remap the vaddrs on the fly without reaching
> outside the area struct.

OK, that looks tractable.  There are not too many instances of struct iopt_pages uptr
to fiddle with, adding support for file+offset.  We must of course keep uptr to continue
to support anonymous memory for iommufd, but such memory will not be supported for
live update.

Do you envision a new userland interface variant of IOMMU_IOAS_MAP that takes fd and offset?
Or have userland pass user_va as usual, but have the kernel check if it maps to a file,
and save the file?  The latter is more work in the kernel but requires no change in
applications.

Do you plan to work on this any time soon?  Do you want me to?

We still need IOMMU_IOAS_CHANGE_PROCESS to handle IOMMU_OPTION_RLIMIT_MODE, and to handle
a changed uid.

- Steve

Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC856442
	for <iommu@lists.linux.dev>; Fri, 19 Jan 2024 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705693052; cv=fail; b=mKbWe5Wf0hzV2WWV/aVCz+olTqkFiWczXj4ku2KVzZFndlbE6MuB5xwJBNvvBpx4ZrkR36/WCnYQF5+MfcFD7V2gGF9CWD5vF0KSQo8OXSLEFGpJc/P7uaYO2Q0+dQnn5P19VinM405+5jbxYCWy7YqELTYlQoO4h/tGFuII1II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705693052; c=relaxed/simple;
	bh=XwEftbvEKyUwzjnCFhf+CMYN4ewg/fbfhULpcA4zkg0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ViSnRmYUpZFAONxEqZ46AlM8iXd2+v/S73H6BJinxSxFBISOEl68vPvXUrL/G6eQiUxwsvbVDeoF4WD7f2kr/61wxeDiirROhGB90kL9JAQSNrxk6F6xvPTxKStD5lFgZRlnGQUhtY6dRfxpqFKyDNSn7att8MFoWGdICSx+rY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FJgqOp+s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I5Xf6ZWZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FJgqOp+s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I5Xf6ZWZ"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40JH7EwA002731;
	Fri, 19 Jan 2024 19:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=eGjVRFJ77hWGTo6bPqKRhz+Kd2eBnTB+4N/5SdD22lk=;
 b=FJgqOp+s+xOqHVT7sdUQvK2UA/cSwIYODrTvPe7X065B261YRSCsMJ2QNROzGcT8cN4v
 ur16wUmKoXEZzdw012JmHwEZ16NkPVf4YD7HUUfHO2xWjRVVPcek2yRjeiTTpnNH1eME
 sxrCleK34ZYdkGH+hc8N3NmDIRlLQ+m8kUGCdDkzhOqwJKV3/rOtJsfAiizdvb0EobN4
 wmxCEVvi2XyWjQADsrKMDJk71SIdm5Dzz18UnrWC0nO+/4xXg+kDCU+Iur+SN2QH1328
 cxYuQRhN75vwG9cENcIoiCzt/M/5nlfqcUsy1GPFwkGz5tVgCJEdBgGCbb3EW6FwDjVL DA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkk2ufenu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 19:37:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40JJCXKQ025116;
	Fri, 19 Jan 2024 19:37:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgygaakg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 19:37:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGdLDNUzhCNmi+2CmOpJB2M13J9Ig7wZI0HAJrjQV59mmpjH+X4Hr8FERvMIU9S2LmPP1drO/UvYKHWTUCgBya1lwI4ijc6RRuX00FRcHUwKi/hm6v9QNwvUcFRsIryBoCQt0lLuYL7NlUKP8wut0O5xsw9Zv7rtnE9aJLxBoVxs5E0foXISbOaWsjMY2wYbHH/9UJzAxJKtJw2nZF/jIZCnSCPCwv2+02Y2LlnbQVSj3YOfxd7SwRkm9M6SlNRS0cPwpj8ozieiXX5hQq3cNfgOPhSdi4RRyv/mReEakboBYg1l9cFZSoHB408JX3fJVv64oSRguyZnKAKpuruL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGjVRFJ77hWGTo6bPqKRhz+Kd2eBnTB+4N/5SdD22lk=;
 b=OxCRaY5SepPmcD7cGbF8yx/z7gA/H6BNFG7AxY4HpOPpo7FiN1SXsCuRWSnoH+uFYRH0lG1klnyDi6UASf0gzsJyXXEUEoCO0aQDoFfvyFvqVtGDOEEknmEQcT4S8adTAarETRXBSgJwRZz5qcqid6fa3wr4GWZdnWgFyZ2yi/iwgLgw6S8a6lUhGrnLai7GhB3KObuSrQIc0tnyvtzujRg8ex6i8FnOOIZ6pAkZkX4O34hpJvaiSFQhCZr5Di62X5fsMeBzJUbOo3bezbkUHujmmmlszayfEQEmmRnS8L/ssrRcIT1+Aqw8RFDskqlf4RshSvimESCNYrM1yJa6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGjVRFJ77hWGTo6bPqKRhz+Kd2eBnTB+4N/5SdD22lk=;
 b=I5Xf6ZWZefU3qBez1e1u7sfnYKWJ3Mb6XqWCMod29Bpy8/ebco4ccEQe5kt9B4DfuOxVj3Xj4/y+zM/xmAwwwOxy4j4IpqhImXTii3B1x6dUAap85UM6MZJSx0nrleEA8Z60kPnetDGg7ZTFK8Qu5koKN1gCyZqJEYMmtnnjTgg=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 LV8PR10MB7919.namprd10.prod.outlook.com (2603:10b6:408:203::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 19:37:20 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::2067:811a:3ac5:b30f]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::2067:811a:3ac5:b30f%3]) with mapi id 15.20.7202.027; Fri, 19 Jan 2024
 19:37:17 +0000
Message-ID: <dc37c9cf-8c4b-4437-8596-b3e7e34d288f@oracle.com>
Date: Fri, 19 Jan 2024 14:37:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] iommu/amd: Misc cleanup
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com
References: <20240118090105.5864-1-vasant.hegde@amd.com>
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20240118090105.5864-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|LV8PR10MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e90e7d-05a7-4646-0295-08dc19260b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	J8wrXHJsRjfCPD0D+mYVvMfOkJ00tYdHaqh1ru9mfHgG1RI3fMfrBYEH1DmzUWk+CI9vN2irU4qDlb5CDPDvLw1iCZOm8MlhZGUSvDz7SYK7znKUGvL1ifG3IFaXA8IZPb+c3tMmCf4G9uhivgXKQQZfqdF43tT7g4SSboiC18kvlCd9R2FfuV8np2Cz7oqr16zGO5/dX1vbeXJT4ibOGENcsWsugl4ZjPnw1ig3nHDi07vJhekCahVL4WrHgQTrek7nDB4PskVddDLznnmOVnMFfgyWDa1suOXxDHiNhHSPuOhnLiCXi49zNBsZlqjsy5Y7tX/o/7PDbjEFovOotM1MpV3q4XqguSJC56VQT+Lt2f+ONBkLG2J/6livsVnFbFTgkw/Ij0jQ+ETM7Svzq+zqLFqL1EmZCtBFyUiNh8bPsCCJAvGysVe04RRI0Q/ipQz9dsXeINkam0UvYmjGo8TIKwnZSLbtJT4kks4Qa2pvO++o6uGHT/6+WqGCvtmpwP9nHMvfQpeGk1S3KPWWsAM87H+Zu2TZfuclu5JijWISiOebey2Rq8Y20uPM/oo1y8/jt/yWQy5aI0MKjd+zYdS1BOyr7Sa6gUS2IhBZ4YI7+Ckk/nw7HmO9r+rODd2RZi+1S5fnTCMgR0sDLaTTCw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5280.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(346002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(2906002)(38100700002)(4326008)(26005)(2616005)(53546011)(6512007)(31696002)(86362001)(31686004)(36756003)(66476007)(41300700001)(66946007)(8936002)(316002)(8676002)(478600001)(6506007)(66556008)(6486002)(6666004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZndsRGowdG5BNTUzSnF1OEpYNURZVExFc3dTR2c2cG01NnlpeFBnUkZIZ0w5?=
 =?utf-8?B?SXZtalYyTDJYMlQxWTZ5U3Q4Z2s5Z2ZOUTY1VXArTmdsd1pWWjQrMTBXaVox?=
 =?utf-8?B?SUxEQnNTQWNFOXBja2JobUU2eWFIT0JRN2dEeTYxd2UrNnpsVHVUNmhRRGxI?=
 =?utf-8?B?VnJDRXRRWHUza1NSNFl6S2haZ00xb3labHJWWnMvZ0tRN2JSRC9kbnYxZXh1?=
 =?utf-8?B?WUhoR3dkVzdhWTdpRGh6c25hVXpSempYb2tFVkNPSUlwdnd6NnJsNUg3TzRl?=
 =?utf-8?B?djRsSmZxR0tjUW84aFh6UnlSSVlXRE0zK3R3Qll0MGxTVEFYOGpqV016b1gx?=
 =?utf-8?B?R2tORDVNQTQ5d1RyZmg1b0ZodUVXQTgzWm9GN2FCTU5NeDlDUjN2bkJha0Qz?=
 =?utf-8?B?Mi9Pc2ZndGo0YjFjUE1vcjBIU3RSbmYySjJFUUlpS1BCUjlmYlBLSU52TFZO?=
 =?utf-8?B?ZmNSSytndm1uM2FKN1FJKzNnc2V5bHVvWmN0NEtMYWxSRjJtSHdOQnFxNnIx?=
 =?utf-8?B?N3pOTUg1emJ0SUhzajBxTDNRdmlsQUk1WGFTOE5aV2ZPRDdDcmFXV3JVNFVB?=
 =?utf-8?B?M3k5aEhYSDA5TGRtNVJQTXBKQmFWVGFGaW0va1RVZ0dVd1gvKzlPUFk5YTVx?=
 =?utf-8?B?S0lqMWtMSzNjYU15RXJzZHJIVWZubGE4WUxCZnJDYTZuQkF1WXNHZm96OVJN?=
 =?utf-8?B?N21iWmlhMklwdmNRNytNa090SDREMWFoNjJnbG5oUWtCWkJtRi9FYWg2aWRh?=
 =?utf-8?B?YXNZVkJCK1hLZkx5L3JubGNsZFZpRURKVmJXN1FQWndhNk5CUnNSMU1zZFcz?=
 =?utf-8?B?cE81RGRZVE1VNjc3L2JLM0xEck1waXdYMVhSMUppS1dSN05aTXJ1L3R3MWow?=
 =?utf-8?B?WkJnRXdzUmxaVCtBOUtRNkMvR3lZMHNZZWtaWTJYd1FucTZwdHJzNnp0U2JW?=
 =?utf-8?B?Y0ZWUGpFaWUvMlc2NWwxckFxWXpGNzVsZjM0bVpiNjVOa2c4U0l0MGQvYVZj?=
 =?utf-8?B?YlZHWE1ldG03R3hHY04yT1JIbEZyVmFHaGlCK0IraDRBZjBBd1BpWXV1VlF6?=
 =?utf-8?B?L2lSNHBzd0lGTWI2dkE5ekRrUHF4eTRxS2o3aUJhSnllcGRQMWUwWGhheVlZ?=
 =?utf-8?B?Ylp4RzE5WWhac3cxaGdjY3Q0UmI4eTQ0a2phNFA5Qis1dWNuMUJHcXk3Ulow?=
 =?utf-8?B?TU1qNVZoMzkzM1hOOG5HSndnWVhPL0lUNEZSSDdOaVNiQmYwaUNJQVFGSjkw?=
 =?utf-8?B?NTFXUmxwR050bXlhVllxRGJGa1dYcXFYczVmRVJyL2JWWWpyVE83eEhMZmI2?=
 =?utf-8?B?OVpyTjJqYkhDUCtjcWpyNDZkNGdHVmxxMlFaR2YzWDRlMHNjNmZiMmc3UDFh?=
 =?utf-8?B?c05MZFhwMnZXb2owZ3VaOEx1TWF6U01pV3RCMUFSVXo5cUp0LzFXOVhtQUNi?=
 =?utf-8?B?VmozL3NYRGltUzZzbDI2bml3RUlybmRjQXREY203ZW9uL0RFeW8zY0NxVnBQ?=
 =?utf-8?B?a3hyY1JLZ1RUUDRFVHU4UHJqOGJUM1hqTFV3bmNaMjhtdEdYcXZOK2tpZSth?=
 =?utf-8?B?SDZsRDU4cGFSTWJFRVZnMzMyOUlSd3hibko1cm5ScEVzMVJPOUwrWWMwdm5r?=
 =?utf-8?B?cVNNNkxQM01kYzcvMlJtTk9NdWh2S0ZtOTVWK25XTmg1Rk1IMTdBcmdNdWFB?=
 =?utf-8?B?eWZsQ0FyRU5CWHVQMGZtVE5oYmYyRU0xRTVERjk0OTZWRjNLajZETjJtS0wx?=
 =?utf-8?B?R201SVVySnE0Sk9QQ2E2V2dCL3dPS3RwbTg5dnIvZTYxSzNQTjV5YTFIYWtR?=
 =?utf-8?B?dnFGWWdkdVJybnpoYkw1am9sR0N4aDIzRzU1SjVOYUJmckpCNStGSWRhdG54?=
 =?utf-8?B?bzk5dGtRWFpPN3FUbWdEMGJON2lVUWtmeDRBZTFNV1VZN21BV0hxSmNHTkUv?=
 =?utf-8?B?ODZ2bDNMMko3bVBmSlMreWNoUnpYV2hCRG95UHlORmptMCtoRlJGUXEvZ3F2?=
 =?utf-8?B?aml4YlFlb3NDdTZuNzMxRmUyeHlzSWNZMm54WTA4cXE4UGFMUXJBbU1ZY0FB?=
 =?utf-8?B?SVV0aVRpZ3JBRjNkdis2YU96MC8zRTQ1eXVGenkzb0NmUFZ6SWxSdWwydjM1?=
 =?utf-8?B?Z3JvYWxFL2FsRXF2NXhRSG9LQS9hVlpiV0JjYW12UEtzTUNFTWszMTFpMVBW?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	retz6rQPU97Pffhcbx57cDOmkPr21Pg4g8CWRa8p/3LLbnLIrAt6+HzK+6Txo49MLJ4C2BqoAXiM+cUYcok1XHIXtESUoHlU3zxokZ3zTenCj52udbwj3qF+xcMnubwXSAnGWRXvfZLZ7q4N4h79HNknj2UFA7mJ4yy42c+ODQ0643QNqmT4NLRAkloIzZVFl96tD3tVQU+U14RdilYRjOl94+X4ETSXs4aEK4SnfxlGMFqc/jcXi9aNgv7wqvN0w/WtvW9k98So43fwbUUclamknAl/Hl/Kr8ASrXUq1/YzhQD3S2ifKdBdKET1MqzKwl8xo03ZSaYCnl6ziNlweYf9MVAu6NTnW9mgjeg/LMwKzmxNM7Mn1PJh4Ijwpoxapf8JX5uckHrB9LocM5vpGAJ7EPLIUCvwh5zXo4R45x7RKLEtNnBNRSEOrKqcGTT9PnJVW+IDIQaEnQ8VNHF8bKKivHmDMskNA9OUXJtoZhFCtPSOgw2Gnjh8B4i2ERlgqihFVGHRiiMhfUsWXUQJrkkkgb99j6EB42be4ixu+RsZospulUaNso5Ol8qFhUKa7yruM2dysSbzdGIIOVq8Zrgo3sCsKhy+WSE0FNxFvrE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e90e7d-05a7-4646-0295-08dc19260b9e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 19:37:17.5506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/NFH2ruQN6iLXUwdRJxiFx8bXuWXFjMhADDWnSAOO8vAoIS0h9qOc0dDcGE476ZoS10YgvT9/yAbCVUogHJJKLZp2u/gv7FDl7a2lcS+wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_12,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401190116
X-Proofpoint-ORIG-GUID: pGIM-b1wBMUwjFvC45yTY87ZHNvNlM7A
X-Proofpoint-GUID: pGIM-b1wBMUwjFvC45yTY87ZHNvNlM7A

Hi Vasant,

I had issues applying the series to the topic branch, and realized it is based on top of your SVA Support patchset. If these patches are merged before the SVA changes, the minor conflicts are simple enough to resolve I suppose..

On 1/18/24 04:00, Vasant Hegde wrote:
> This patch series removes unused macros, redundant check and
> unncessary EXPORT_SYMBOLS. No major functional changes intended.

For the series:

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

> 
> Thanks,
> Vasant
> 
> Vasant Hegde (6):
>    iommu/amd: Remove unused PPR_* macros
>    iommu/amd: Remove unused IOVA_* macro
>    iommu/amd: Remove unused APERTURE_* macros
>    iommu/amd: Remove duplicate function declarations from amd_iommu.h
>    iommu/amd: Remove redundant error check in amd_iommu_probe_device()
>    iommu/amd: Remove EXPORT_SYMBOL for perf counter related functions
> 
>   drivers/iommu/amd/amd_iommu.h       | 13 -------------
>   drivers/iommu/amd/amd_iommu_types.h |  7 -------
>   drivers/iommu/amd/init.c            |  3 ---
>   drivers/iommu/amd/iommu.c           |  7 +------
>   4 files changed, 1 insertion(+), 29 deletions(-)
> 

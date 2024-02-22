Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF6F3770E
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599888; cv=fail; b=oIAqas8472Nf43DitQZSeDMKdAvRK0blMoKTIhkQ1JnpYFSph7hiNoVd5Exi6PY68GpQXtPeNE6FP6fWmtXIwJVn+e2f+sOV6cRVuDE+189bdIBUaGeIbcPgNSt6NeW1BqyuRSOJmvrk8xsVWQ0YBJHm5EU+CbuQAYwq266Pfas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599888; c=relaxed/simple;
	bh=4Dl/w3HGii4LmCDtLnfUhkZKxxD3DfErAG1gDBT0588=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eU8GHG64IjXi/4JiRNVUxe0Gpinm7vZdG4pdfx9LHXtGYfE7BFSJEE7k1ploOkqh4H+Yo8vG2A0ahhQR8mmTjTbMg71iYz674LdcPf9K23bnMXOv4cGEXKrzbjuWzZEFmIMa7+WIwq7fJFof1FqyISPj/LhP2seTu4WPPrZR8TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SLtTFobf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WrJ73YDn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SLtTFobf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WrJ73YDn"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41M3T126012750;
	Thu, 22 Feb 2024 11:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ibYfkraFLYxKw5FkokQ7UJ8E91+arUP42a1TIdTOl10=;
 b=SLtTFobfyG81xbzdK54m8lsraZFn49cbN+HLsyGFijW2885VywTQZc+StdQdAyZYhv37
 kzvSULPTG4luCeUFGYYZ0PqkRVnSwvxOIjc+fldNU4DdfOCWcmmFXFG4uDHk7tmUX4BM
 JoaXWmTRhEi8tLyabjaS9ZQ3aAQtM3VJmO6lWxNXg1XKroXyOXDhgaaLcLkH3kHQ0gZN
 G1yr/H3aljnuFgJOFLFMKkAsOZJll5Pf2uVyNWC/iFpzMKa4OyC6mHkn8axw1Gtz1WVa
 DlDJiOUQx/Cg36DePfDkSvPOtLv7Q/GQlhGuavP2k8Ux5HnmPLdmT8FN7BJzML1Wsw9a 0g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd2cfuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 11:04:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MAce44021107;
	Thu, 22 Feb 2024 11:04:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8av3k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 11:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYIIhai+BBQTkKwFKw922RjMxyt+4PuYyEK9lVJxlrYV7tOl+sylz8XCHL62f59vcaLeFVMuRVvtT83AD8mZmBTSxtaFzHfCDF2yYV5ibrynyw9V+4e4XRX2khcD+BYl3YnxFODJfrdjBQTBemsFpSwT40KYhsjVFEl4O4xUuuGG/Tftc+LttASOfQo0PgxpGOdj4xtt3Xyzbmk2nM1q/ZUG9u3BaWEVRHWKYDKXJxqBVXOlcrQVkfGLe71+jlGmpM56wwHG8eyN59f7H8BuCA2mmzcci6MpPL3I73Gm1eB9YP9OHucVYi24UFwtyMqSTb209Uhsi+u+ocNSxJoOxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibYfkraFLYxKw5FkokQ7UJ8E91+arUP42a1TIdTOl10=;
 b=XtezsSzeHPiFbF76E9OMZsdjE0Nv5fAo7TQQ3coZMDOaM7MqNAQuQQKIdXk1v1nnYQQQl6RGhKFo1QmwDTvPtLdOC2JHUDcVeT/i8SgXhubTNfO/mT0/A1zSyxADUHEon2spld9j9N932VuiciXmeu1yeSGNgpx0EbrvQFYGHrtrO4PHnug6f+FPcZRwqpS6Gbmr14+sXZ8FaAXZP+NFCf7m+pQe6Q03UXjDbuzidvD83fPA4l63WClELdYizY0m5GVAif73CglQoR71W84jOQeHQP3YtnDp1gqVdzfS4xw+5CakzOo8uiBtIpQfMpK8DiJFdE5EoYqeONsBjtorBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibYfkraFLYxKw5FkokQ7UJ8E91+arUP42a1TIdTOl10=;
 b=WrJ73YDnWHPV8VmaWxwqPxuLdv875e2zraFXc4H147at8vDoMwxwkbAJlF1xC/iZLx78LpkD9l/Bn3USEnhoMxznE4g4N1hHwlkGobrMrMohqF6GEZndYg7Tr+y1NXc8qwCK6jy0SXxHum6JZwj5b8E6DT405WdUZyvShwSnz4E=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ0PR10MB4782.namprd10.prod.outlook.com (2603:10b6:a03:2dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 11:04:14 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 11:04:14 +0000
Message-ID: <a47699c9-4f3d-4cd0-94f4-f19e117ea6a3@oracle.com>
Date: Thu, 22 Feb 2024 11:04:07 +0000
Subject: Re: [PATCH v2 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com, nicolinc@nvidia.com,
        iommu@lists.linux.dev, mshavit@google.com, robin.murphy@arm.com,
        will@kernel.org, jiangkunkun@huawei.com, zhukeqian1@huawei.com,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-4-shameerali.kolothum.thodi@huawei.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240222094923.33104-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::17) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ0PR10MB4782:EE_
X-MS-Office365-Filtering-Correlation-Id: 0347bf34-61a0-47a8-c5d5-08dc33960163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5oNgk78wbMul0i3q6jCFPilbwpbl46U0kmU6vodwRKcTUMPl02e+ttRkCmeS0ga3PNRYeZEalgZv2pK4gJE06JKIVZrjZ1/ut8k3oulvGsJtpgSBH99suRy+EuxaTee9Hfis2S/OzYqXLK2EW6tyC8Ogzz2aAt39uLCf3LVGkU4OUuLzqM5R2R3DJG2zysxiEFj563f2MDOBA2/+90qW70/bhZOzzbOfPClkt39sm/s3ua9XHEvRXcjHESPoq9mrYYtG5rTUMWH/f/yYFW8JmJJoTlz95KlnBeEnTG69YgjLre7AAbCNCpNEaNPXpcjEe2rjRV/uI3ymuwF77czGRKaauhPxPnXjeLnA4jWxLeOJB3Q5UpuPislDfHOaWjS5P5V4RtrBpjjAVNZDDaMWdkk7JswMW2rLsi5VKcF8nIrIjqIdjwkWNXUvaeILhR0eZqeQbjfKZa4C2z1MPSuGoVHXelJ/wN4Rijm9XcoGNtxKLiHN9USoXIVIzeosrnVeZyvcH8s61oj1t0N2UxQzhX3hkPEqf07L0P9Xq8oXLxQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NEVYMWpVaGFIZUpyd1NFWnNPRVI5bkFhWk9hckxtMGljUUhLMGV1cFdaOUVJ?=
 =?utf-8?B?cHRSOTBUU0ExYUZEWERxaFk1eU9ydUFTbXJORi90c292MGYxMmxyNnlpaG9h?=
 =?utf-8?B?V2xwZ3lrTlJDVklQUlF5Um5IT3lQd0JNVTFHenlFMjRDZGNSRDFIYU9USEdM?=
 =?utf-8?B?cndnU3NCM3VSY0FVSGN1elpWUjN5b3JNZ3d2MytWR1pMaGt5eFVIalFOVEtu?=
 =?utf-8?B?b2QzdjlObmVURW9jSkI5OVkwZjV2WUdGbDRwSlZqNUsvd0pkSWd1VzRMN05j?=
 =?utf-8?B?RlhzR1gxVmsrS2o3NEFjMTYySGUvRitqRUVESHVlakpmS0R4RW90RkdVUXZN?=
 =?utf-8?B?UW81NkJoM2NhampmdThBVTZnMU9nNjh0cGdKbktrTnlOT2QwWnkvdWVSRWdH?=
 =?utf-8?B?UEpSZDNTaVpua2FKREdBelI5andma25XK3JXSDJhWUZTOGJvZTJXRE8weXNE?=
 =?utf-8?B?YkVCcUdLYmtBZFJuUVVhbkN4WDdmTXpZb2p4NEtXZjRmNmprcUhGcmJuRmlh?=
 =?utf-8?B?OUVCUENOekhib25iY09QeFptdmlZT2taSmhkZlJxb29YUWF2VWFxc0RRME1H?=
 =?utf-8?B?bk9SN2hmaVdGVnVNYjF6alZvVjcyZThrQmtQQy8vS3FrUmpwTHBiNGZVRDA0?=
 =?utf-8?B?Tk9aOGdLUnlmaS9xMDVmQXpYOHBuZURZRXQrYVVidm5uejZLdEtxd3hlNzZk?=
 =?utf-8?B?ekdGUEJtKytqUnlwd2xKZGJ2OWdTSlYxS1JDd3F4dzhXNVZqZkxkZTZKWldV?=
 =?utf-8?B?UEpvMUhPNTdEQVFpeVppYUlRbDJQbUxaR01GWjF0VFlTb3FEeEErTmh4anNi?=
 =?utf-8?B?bzlVdWd4dnZuZC9OTWdGWXB4TVNhbzM2aDBRc3p4REFIZGZZMitPR1lQRnJ5?=
 =?utf-8?B?cC84N2hHTXEzYW54SFFQZ3VzNkgxU09PSGdFZlN5T0hJVFNTbkVOT0lwRnR2?=
 =?utf-8?B?MVJlKzQ5alE3bUlTZ294Q1NlSVBLZEdmWE1SKzdTSTVDaVpjRGROT1dHYXZi?=
 =?utf-8?B?RXJlelVPSkhhWkZINStUVldnRzhMOWNhenRjT2lMdWRad3QxOW14VUJ6aEgv?=
 =?utf-8?B?d2VkNWtuSlFNSmVkYXBNbWJDSjRTWGJLNWFjQTBBNlF0MWhhRzNGd0o5VGJQ?=
 =?utf-8?B?T0xSV0RUblRNTktRY3ZLWGx4SzNzTU9LbnM2UHdIVWlZcm9jbXhyRlBiZEQw?=
 =?utf-8?B?Y0M3OEt4RkI5cDhlbHRZMzhTbzNzZVJMNjM0OXI4SStBaFlxYWZwcDNOLzZz?=
 =?utf-8?B?TkM2MGM3VVZnSG5WbzZTR0NFRVpjeWxiZmh4cW56aks4Q2ZDUUNzZ0pRdG9L?=
 =?utf-8?B?bExseDMvSVVtUUVQTHZkRjVpaG1kaG83VGE1b1lzNFZ2RzFoUjJzQUVoREI3?=
 =?utf-8?B?SmxzekFhSDBTT1VuV3FwRlB1b0J0UG52UVlRRm1VbHVsYXpROWRRQzFBcGpU?=
 =?utf-8?B?dkdGajZQM2N4WEQyL1NodWlEVlEvMFlYcXh2c3EwSkQvb3BNdGljU3FIOFdG?=
 =?utf-8?B?LzhCT3R5VTRkTnhhUlNWdjJzZ1diWVJwYS9oV3FtbTk4ZlVZa1F3Y0dWNlBV?=
 =?utf-8?B?SUhPVnNxaEZIM0pMejY0UzJ3eVVBMW0xQzR5UzZ6Nzdpd2NZYVZHU0p5UjNu?=
 =?utf-8?B?STVmbTlKbHdtNEtzN0NzVXFCaGhOMk4vWFB3NkNZRU9hWGsvQWZZYU53a1kr?=
 =?utf-8?B?R0xnUmtSR1luNTZTRDdKS3lzKzlMUVo1VklQaDkrRThSNnQ5U2FrYUY5YlRC?=
 =?utf-8?B?a2F4SnVEU3kyOEtpV2FvSVBqSXozS2U4SENrRWg3SDlhK0owZUJRa3JQaVh2?=
 =?utf-8?B?UTlQZW9QL2lWaVN4d0JOZm1yUUxYenhTOFdpcnc1ZEo3VUEyUVR1RVFaOEVN?=
 =?utf-8?B?UnhOWEkxZXdtSXVlQ3FPR3dINWcxaTZLdzA5OE84ZGNYT1JUdUxRYyt6aUNR?=
 =?utf-8?B?Z0R6cDJqeGhmcFc4THdoc1FvRGgzMEZQUTAweEpMekIvUXl0M3NWdjFzNk1U?=
 =?utf-8?B?VEN2a2s0S1hLWTdIRWYyZFZxU0tRWDhHUHJaNDVWbDJNandlbDdBZERPVEtK?=
 =?utf-8?B?bGFvYW5hZ2lCTy9NaldyUEpKTk9EQTh1Ny9zWVR5RklCb3Y1WXZtVVdxNzJ5?=
 =?utf-8?B?dW1iNE1LMTlIYVFkY2ZZYjdBS3grSjBwZldiUnBRNTdKcDBpbWFOR0doSHRs?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DTeZMFQAvPQzAAoA4YMqVce9q3GU2XqDSlcV7lzpr1Mu2QYzJwFHgprciiar9ifp7IrwFrDDOSOXT5eKmeZTR/55QwXsQ9J/09o4VyPrYoV9ip5xjh/rviclwXs2ItZ5g/4StDMlBWJpJNzKMccW4xdQZJzHD01icgb3APFNHLGiwt8lbfTIqxq7AEVJiTA4lH559Us2rTL96heM3lhIxpuT0bcL7Z3CLhX6yO+TfuNDd+zOq2f5nPzdW2smlLK/EyE6m4Vf4EvBwXshVHMp2z7eR4mH7fFk4wOomhK0/tNf+jaaww2CQ5ppGzGdWAHFnSWrxqKMMdcGgsvhh437z5YfVcdtjVvE0NSnXT1y/HbF2Ya7qMoawDtn2jtr5r7/tqQhFmPirDegGdDBERWV1a7VAuWqPVgjCB6uN3WlB5XAhpngYTXoIA3vixTSr61aeKyE5p6JENDYXhBOMs+dnyndNmxhjBSuHRUcNERgk4LpBHv5k3asA9e7uPHIYHUlvQhR0d0+rk2yy+dw14xzrIWBJAppKGHcg8TAeGH8VuJuPLUCt+W0CzcJjJCt3D/YaLRf5/rRU6+ca74rLhsDrX6J7ynb/ADwo9o9c6gjTWk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0347bf34-61a0-47a8-c5d5-08dc33960163
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 11:04:14.3615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/eWwIerWtrckDpU9J1T55uqEVqwN//nsw0fUNGqXEBybxwUnAfWzHxvZJOm0/i/9024SCIiyxFdvHz0Yh4VFO072HgMAA/6bCLzN78mNpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_09,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402220088
X-Proofpoint-GUID: cWlfglR2TdsTg7X74fM00YWjSmkBQHlu
X-Proofpoint-ORIG-GUID: cWlfglR2TdsTg7X74fM00YWjSmkBQHlu

On 22/02/2024 09:49, Shameer Kolothum wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
> 
> This provides all the infrastructure to enable dirty tracking if the
> hardware has the capability and domain alloc request for it.
> 
> Please note, we still report no support for IOMMU_CAP_DIRTY_TRACKING
> as it will finally be enabled in a subsequent patch.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 95 ++++++++++++++++-----
>  include/linux/io-pgtable.h                  |  4 +
>  2 files changed, 77 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index bd30739e3588..058bbb0dbe2e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -43,6 +43,7 @@ MODULE_PARM_DESC(disable_msipolling,
>  	"Disable MSI-based polling for CMD_SYNC completion.");
>  
>  static struct iommu_ops arm_smmu_ops;
> +static struct iommu_dirty_ops arm_smmu_dirty_ops;
>  
>  enum arm_smmu_msi_index {
>  	EVTQ_MSI_INDEX,
> @@ -86,7 +87,8 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
>  
>  static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu);
>  static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
> -				    struct arm_smmu_device *smmu);
> +				    struct arm_smmu_device *smmu,
> +				    bool enable_dirty);
>  static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
>  static void arm_smmu_tlb_inv_all_s2(struct arm_smmu_domain *smmu_domain);
>  
> @@ -2378,7 +2380,7 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
>  		struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  		int ret;
>  
> -		ret = arm_smmu_domain_finalise(smmu_domain, master->smmu);
> +		ret = arm_smmu_domain_finalise(smmu_domain, master->smmu, false);
>  		if (ret) {
>  			kfree(smmu_domain);
>  			return ERR_PTR(ret);
> @@ -2445,10 +2447,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
>  }
>  
>  static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
> -				    struct arm_smmu_device *smmu)
> +				    struct arm_smmu_device *smmu,
> +				    bool enable_dirty)
>  {
>  	int ret;
> -	unsigned long ias, oas;
> +	unsigned long ias;
>  	enum io_pgtable_fmt fmt;
>  	struct io_pgtable_cfg pgtbl_cfg;
>  	struct io_pgtable_ops *pgtbl_ops;
> @@ -2459,31 +2462,31 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
>  	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
>  		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>  
> +	pgtbl_cfg = (struct io_pgtable_cfg) {
> +		.pgsize_bitmap	= smmu->pgsize_bitmap,
> +		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
> +		.tlb		= &arm_smmu_flush_ops,
> +		.iommu_dev	= smmu->dev,
> +	};
> +
>  	switch (smmu_domain->stage) {
>  	case ARM_SMMU_DOMAIN_S1:
>  		ias = (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
> -		ias = min_t(unsigned long, ias, VA_BITS);
> -		oas = smmu->ias;
> +		pgtbl_cfg.ias = min_t(unsigned long, ias, VA_BITS);
> +		pgtbl_cfg.oas = smmu->ias;
> +		if (enable_dirty)
> +			pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_HD;
>  		fmt = ARM_64_LPAE_S1;
>  		break;
>  	case ARM_SMMU_DOMAIN_S2:
> -		ias = smmu->ias;
> -		oas = smmu->oas;
> +		pgtbl_cfg.ias = smmu->ias;
> +		pgtbl_cfg.oas = smmu->oas;
>  		fmt = ARM_64_LPAE_S2;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	pgtbl_cfg = (struct io_pgtable_cfg) {
> -		.pgsize_bitmap	= smmu->pgsize_bitmap,
> -		.ias		= ias,
> -		.oas		= oas,
> -		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
> -		.tlb		= &arm_smmu_flush_ops,
> -		.iommu_dev	= smmu->dev,
> -	};
> -
>  	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>  	if (!pgtbl_ops)
>  		return -ENOMEM;
> @@ -2491,7 +2494,8 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
>  	smmu_domain->domain.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
>  	smmu_domain->domain.geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
>  	smmu_domain->domain.geometry.force_aperture = true;
> -
> +	if (enable_dirty && smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
> +		smmu_domain->domain.dirty_ops = &arm_smmu_dirty_ops;
>  	ret = arm_smmu_domain_alloc_id(smmu, smmu_domain);
>  	if (ret < 0) {
>  		free_io_pgtable_ops(pgtbl_ops);
> @@ -2811,7 +2815,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	mutex_lock(&smmu_domain->init_mutex);
>  
>  	if (!smmu_domain->smmu) {
> -		ret = arm_smmu_domain_finalise(smmu_domain, smmu);
> +		ret = arm_smmu_domain_finalise(smmu_domain, smmu, false);
>  	} else if (smmu_domain->smmu != smmu)
>  		ret = -EINVAL;
>  


I think we are missing the domain attach_dev check for dirty tracking.

Something like:

if (domain->dirty_ops && !arm_smmu_dbm_capable(smmu))
	return -EINVAL;

But that helper is only introduced in the last patch, so maybe:

if (domain->dirty_ops &&
    !device_iommu_capable(dev, IOMMU_CAP_DIRTY_TRACKING))
	return -EINVAL;

> @@ -2876,7 +2880,7 @@ static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
>  
>  	mutex_lock(&smmu_domain->init_mutex);
>  	if (!smmu_domain->smmu)
> -		ret = arm_smmu_domain_finalise(smmu_domain, smmu);
> +		ret = arm_smmu_domain_finalise(smmu_domain, smmu, false);
>  	else if (smmu_domain->smmu != smmu)
>  		ret = -EINVAL;
>  	mutex_unlock(&smmu_domain->init_mutex);
> @@ -3193,7 +3197,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  			   const struct iommu_user_data *user_data)
>  {
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> -	const u32 paging_flags = IOMMU_HWPT_ALLOC_NEST_PARENT;
> +	const u32 paging_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
> +				 IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +	bool enforce_dirty = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>  	struct arm_smmu_domain *smmu_domain;
>  	int ret;
>  
> @@ -3206,6 +3212,10 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  	if (user_data)
>  		return ERR_PTR(-EINVAL);
>  
> +	if (enforce_dirty &&
> +	    !device_iommu_capable(dev, IOMMU_CAP_DIRTY_TRACKING))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	smmu_domain = arm_smmu_domain_alloc();
>  	if (!smmu_domain)
>  		return ERR_PTR(-ENOMEM);
> @@ -3221,7 +3231,7 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  
>  	smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
>  	smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
> -	ret = arm_smmu_domain_finalise(smmu_domain, master->smmu);
> +	ret = arm_smmu_domain_finalise(smmu_domain, master->smmu, enforce_dirty);
>  	if (ret)
>  		goto err_free;
>  	return &smmu_domain->domain;
> @@ -3470,6 +3480,42 @@ static void arm_smmu_release_device(struct device *dev)
>  	kfree(master);
>  }
>  
> +static int arm_smmu_read_and_clear_dirty(struct iommu_domain *domain,
> +					 unsigned long iova, size_t size,
> +					 unsigned long flags,
> +					 struct iommu_dirty_bitmap *dirty)
> +{
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
> +
> +	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
> +		return -EINVAL;
> +
> +	if (WARN_ON_ONCE(!ops || !ops->read_and_clear_dirty))
> +		return -ENODEV;
> +
> +	return ops->read_and_clear_dirty(ops, iova, size, flags, dirty);
> +}
> +
> +static int arm_smmu_set_dirty_tracking(struct iommu_domain *domain,
> +				       bool enabled)
> +{
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
> +
> +	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
> +		return -EINVAL;
> +
> +	if (WARN_ON_ONCE(!ops))
> +		return -ENODEV;
> +
> +	/*
> +	 * Always enabled and the dirty bitmap is cleared prior to
> +	 * set_dirty_tracking().
> +	 */
> +	return 0;
> +}
> +
>  static struct iommu_group *arm_smmu_device_group(struct device *dev)
>  {
>  	struct iommu_group *group;
> @@ -3612,6 +3658,11 @@ static struct iommu_ops arm_smmu_ops = {
>  	}
>  };
>  
> +static struct iommu_dirty_ops arm_smmu_dirty_ops = {
> +	.read_and_clear_dirty	= arm_smmu_read_and_clear_dirty,
> +	.set_dirty_tracking     = arm_smmu_set_dirty_tracking,
> +};
> +
>  /* Probing and initialisation functions */
>  static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>  				   struct arm_smmu_queue *q,
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 86cf1f7ae389..8e75f944f07a 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -85,6 +85,8 @@ struct io_pgtable_cfg {
>  	 *
>  	 * IO_PGTABLE_QUIRK_ARM_OUTER_WBWA: Override the outer-cacheability
>  	 *	attributes set in the TCR for a non-coherent page-table walker.
> +	 *
> +	 * IO_PGTABLE_QUIRK_ARM_HD: Enables dirty tracking in stage 1 pagetable.
>  	 */
>  	#define IO_PGTABLE_QUIRK_ARM_NS			BIT(0)
>  	#define IO_PGTABLE_QUIRK_NO_PERMS		BIT(1)
> @@ -92,6 +94,8 @@ struct io_pgtable_cfg {
>  	#define IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT	BIT(4)
>  	#define IO_PGTABLE_QUIRK_ARM_TTBR1		BIT(5)
>  	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA		BIT(6)
> +	#define IO_PGTABLE_QUIRK_ARM_HD			BIT(7)
> +
>  	unsigned long			quirks;
>  	unsigned long			pgsize_bitmap;
>  	unsigned int			ias;


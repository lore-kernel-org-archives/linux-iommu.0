Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CF61B80F
	for <iommu@lists.linux.dev>; Tue,  6 Feb 2024 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707253086; cv=fail; b=l+q1+1sscoi3IJPBtMiA/2Wq0fiYoA7ONOJkJ0jSEeHyr1xV2IEKzI7g+Q3MYH03/7etLlMvJZT+MP2FuKVW7cgw49ZGph+aJocu9FvUXm2unqf8V+FiJbztPtobrO86qJJ7W7X0e0zd25PpHSXLgKkrPgZgf4nniICIGcbQwJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707253086; c=relaxed/simple;
	bh=62Zar/1ABtJpj0vajVwKAYJkKQwKOEZUwemEbGwSIzg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EN96wnEwnblg8HMNyECIai4zoFxDzmuP/P+EJdkQMiglqP06rhBCMPDFz9bBh6cTukL95GpJqA1Xb8AHwsKQvC4rGGRkefhSgD8FuzkizE9HPsvscdxHwNgNnii/GJE8oU+pf6kHKF6+jjSPZaZPNx4rNgQFYvRHyDDDmnVC4Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fkHHh6mw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fpjG2Sjj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fkHHh6mw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fpjG2Sjj"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416K6fm8020262;
	Tue, 6 Feb 2024 20:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bzrXVWdFwz/bG49n4fSaaLPwAlpQuKzFwdhxO78npCY=;
 b=fkHHh6mwqctIfuGICapIrcz4JMs2HTqu+AaW9k6+qzcY/RcnpDQMLPr5J3iCKiPzJ9lN
 tBOrnJj5Ng68KEncxBBdOli+ZmJQXXLMyV0WEfthgZEMDM/E/w3Lx/7CVaSo3wKbqp41
 M7NGUqVtwe7+wGiUmaEqYvKfXULPr0jz6t0he4l8qoWF3j8QA0WFN1h6HUPYVyGIYrll
 VLqcIWaVTumvce1Ntrfbh4vrpgITDxAjvta8lJGaHGG462Mc4na4okmwOiXHCLaKq19C
 S8Jyu6OPIE0HlHzy2yVtosVdtWBKKQ5O+mQdfegr5bcC6oXdQ0+QHkK2vpFCxtCycKJ0 HQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdg2gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 20:57:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416K45O0038290;
	Tue, 6 Feb 2024 20:57:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx7yepc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 20:57:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cioMVEOvM12fHHA7HYhCMo4FnT4ePbZSZtpQuNlZuV1DEQH++L+dGZsn+HbXOes7wuU2WLL9fpzA4pxscHKRqwzNjT94KYKb6766At75+2lIATafVNzFktaCwVMAVVEAMzlh+GMYvlykt2pW8gulJ6LaXFlk9CiNnErfxU1b8Css6YVpF7aNeQX7o/qz6uppetGrO8FLgH5E7hXgj/hfH7Gc0gxr+Heah2gzTwBrSMrj2Sqa12j1oG9Sp1lnuKly576iD+23f24MwVpskyD/HkAmXToyjJypLAz7x6A8nBBdFBqg80DAgTswbk2T9uqtWA+hG6Q+ZcEeOLtcD4jyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzrXVWdFwz/bG49n4fSaaLPwAlpQuKzFwdhxO78npCY=;
 b=h+XJnxUUZzh/nZ4btpAE4BW9ggxWd26LvURyvGI9/p5aIYYQh4I5BFhn40kCgY8f0ZWtuXUUJAjyofNE51VHIKB3N6wso6OmaoSL1CDSSGq0rj50bfZtS87xGllscK1JLGht77H4K+4Abt9LrKVqnHU702Ri2NeJPC7l2zVAyeqetJiXQMkEbxs3q1itH+kqYb4hJexRigt3Hs0mlyyIHb7eFwk5zLCpwkvpZ9vEsQTWjmCWcOnFhsrmAbP3SOAsY9rDmcEToJ7VWyQIMi+23O+nsvYovfvUl+MhI7kQ/9cMR+ncd44NeCTNI2ZLkRbhGzritofuciXMXzBrT9UVeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzrXVWdFwz/bG49n4fSaaLPwAlpQuKzFwdhxO78npCY=;
 b=fpjG2SjjcJESIyVl8A2uWHXpvPobf+S5Zh2bUumtlVFZTmqo2kAWDVfcNrSK+19Z235FZ2G2+3TWtsZewdStM+CQHj45PUGT0PZBY5a1yUZGbnaoRElKFWY53vjXziF5G0PJOAfw7yYrgJSgERq6ttYIm52N7/d2V4U62DxQlPU=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 20:57:49 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b787:9523:eb1b:4413]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b787:9523:eb1b:4413%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 20:57:45 +0000
Message-ID: <c07f0734-f2c5-4110-8b6a-d2ba87e2cd6f@oracle.com>
Date: Tue, 6 Feb 2024 20:57:40 +0000
Subject: Re: [PATCH v1 0/9] iommufd/iova_bitmap: Bug fixes for IOMMU dirty
 tracking
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20240202133415.23819-1-joao.m.martins@oracle.com>
 <20240206181333.GE10476@nvidia.com>
 <91aee5f5-82ce-476a-bb53-cc65c369db2c@oracle.com>
In-Reply-To: <91aee5f5-82ce-476a-bb53-cc65c369db2c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0080.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fa::11) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c0192f-15ff-4202-7577-08dc275644c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HvYOLQDvsvVb/uzLpJp+wQDMnRALi2GDTGMClcJKwcBHemg+abp3BsX/FTGMSx1O1P/DXF1+kPTN56F2YfmsPzm6b3000gkSKFUJPehEhS5LOvlR1XSqURBoep/BQ6Rq8flB2fgglWP9/pbfY/pj2L/HYnGRmcUPkFyPptPTdvsgorsaydKH2+smVgWU4Qc4+fYwRalUiZoTMmts7LaWcnr5wrsbqYQuys/HkjonoVnY2aa8DlP8IFz7cOG03qH3trVInywuLs0g3g/FwimF5EkxAlsR3CxYMlWLaBgkJi3IiZnud74AsMnAhkS8lrQvNrjQs/2w52CSr4pcf9XMMS9iZ00I1wlxG5xkNMpHOW8dFuTCGzu3VfyrBTnKt+aZc/NEYNx7zoKzC24993Pq524FxXnqSt2dhD6bJlF7HjmO3I982660ElRy7PlAf6lgcRWlnkOwdIb09Yhbop7CQjA+wR03h2FqiQr1fG7vd9/jqx3bE+aXOLCBj7R/0I8ro+5mpuAT1qfSGE8DvWQnuegR9Z+yugefGQj1OfcqQaNX/+DItUhclphfF1gw7dkCrPkcfAe/Z0peuCTkKs+r6hesgIX0InIIssauEcDXIDo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31686004)(38100700002)(53546011)(6666004)(83380400001)(66899024)(41300700001)(31696002)(6506007)(2616005)(86362001)(6512007)(26005)(4326008)(8676002)(36756003)(8936002)(5660300002)(966005)(2906002)(6486002)(478600001)(316002)(66556008)(66476007)(6916009)(66946007)(54906003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UitiM0hHbzFkTjI5bEU0TWozT1VXY0RmUUMwc1UxaS9kb3pKQTRLUWgxYm1Z?=
 =?utf-8?B?QlAwVHhhNlB1TW9IUHFJeTNWN0JCcXRvcjVRcWpHOUlJcmhHaVVWam44Qit5?=
 =?utf-8?B?SlZuRjB4ZEV4Z1c4azBHaTBUZCsrd2U4TmNNK05kUEl3Q2NUYWNXZ3VxaHg3?=
 =?utf-8?B?ZjM0cXJnRmUySlFZeCt5cUk0aHVTekdJZTdUenZjVDNhUnFkQzlYM2RHU0ZQ?=
 =?utf-8?B?cXNTY2V5blVpT0ZycU1uSm5sZllVN2Y1bk0wS3NySGFodHFvWTBSNittR3JZ?=
 =?utf-8?B?WXB5R2lSMWhTdm0wSWhBUzc2dGVqT0JIVDRSazd2Qk1HcSttaEJqd0dBZktv?=
 =?utf-8?B?RmxudndCbSt5c0EycUlUaXRGc0gzbEVFQWxweEt1emVGSmtZQUlyVlMxZHVC?=
 =?utf-8?B?Q2RBZFdLbEVzeEFFaHdBUjZ6aGtkOFc2Mi9HWlBPYUNRN3h1TnRVaHdhSGhp?=
 =?utf-8?B?cEZJeXZuL1F2dlM2azVOeUJyNnNEcEo1SVpveUx5d0J1dkVWSzc0ekMvejN5?=
 =?utf-8?B?cjFleUs2dGt0ckI3V2VocTJ6YmFDbVMvMzk5bmZ5ZlRJc1hwTEVERDl4ZDlV?=
 =?utf-8?B?N1hHWDd4TnBwUzRxWUtWTDdUeWE2TEZNQXZ5SmZVbUxrM0hOQWxYL3VRQThz?=
 =?utf-8?B?KzlKR29kVlRYblhNN3gwY1FqaE1FMVRZNkpqY20zclFJVUNrV3orUzhaei9Y?=
 =?utf-8?B?Nk5lUXVhelRLUFBLcE54NmUzVjdqS0p6SUJZc211SkJ0bUI4alN4ZVhFc3Iw?=
 =?utf-8?B?WTY5ZVVLdnkwZDk2dmFTWDhoZnRXQlpOMjQ3d29IeWx3WnZkWEtWY0FETy9a?=
 =?utf-8?B?LytORW5mTDg0d2k1cWU4TlJUcDYySHRIRUYwU3lSRVBGNGZBaldsZVNQV05V?=
 =?utf-8?B?S1MwUVpoTVNoQlkxalFyT2QwWjJsczIvVW9WZnBRanBKbllSdnF4RnNqTjc5?=
 =?utf-8?B?ZjJTSCtkV0xqem9MYUlGMDdScFdPSi9TcDZ6aU1qN29vTHI5NnVkblV6YXVu?=
 =?utf-8?B?ejJmdzJCS3FUY2V2dEh2RTBFZExjYnpVd0I4d3hxQjBvMkNMZzNROHNIaXBk?=
 =?utf-8?B?RVFDZHpUZUdoV2FTNnFwQms1NlhpQzdueGN5ZmdzMmdMdjRxLy9hcndpNXJ2?=
 =?utf-8?B?K3dwVnl4TnJNTzhTcDJkSkZNbEh1cnVBU3BJSFdwTmtUdEkycEppZEVtNXJp?=
 =?utf-8?B?TnZYMHJrcW1QYm41SG4zaVpEaEV2Vll6dUZFMHh3T0FzV1A0ZTVlTGNWcXI2?=
 =?utf-8?B?VzZMUTIrM2NqbkprbGxEMkd6N21RSWpLNmR6T0RMWFlPaWxYdmxTZHF1dWpp?=
 =?utf-8?B?UitZaDlTblpOLzAzV0hoMDY2ZUZCeUxHcU8yRGl6V2JiaG5YY1ZKZ3FaZGZj?=
 =?utf-8?B?WDI2SEhpRERBK3NxcHZQY2czVU5EK1ExNitzN1A4UlpqcE5WUmNXSmRScXhs?=
 =?utf-8?B?MmdEU21uYy9xNldrcmpnbmNtbWlTejlQZFA3ZExGNkUyRVUzMStzZFMxbS9H?=
 =?utf-8?B?MG13Y0tTaVlhM3cvUkZ3SHFFQnlwVFlXTi9ja1EvMlQrZmJjbUVHaXM1T1d0?=
 =?utf-8?B?eG85TFVBRmRpc3FTK3JEdzN2RWduM0RwT2ZOZGFvcUtHWC8xb2ZZSm0rNTBW?=
 =?utf-8?B?WTRmK0JWYTRjdmZjVTM1bEhvVGw1WHBTaXdkWHJDTnM5MzJFUTJicUhJM1JY?=
 =?utf-8?B?d1I1VVp3ZFgyMDhoU0xCV3BpRnNXZTlNdGpCV3FzVzVmdDJlUitsKytWV1oz?=
 =?utf-8?B?d0FxZVRkK3pCK1RnQVBXYTkzejR3eGNKeGZXRU01SzJScE1mbDR3T0J0SEh1?=
 =?utf-8?B?Q0JzQzdBWVpYcnN5T1p0ek00TmhpaTFia05NUTF3NEsydjIwcWVaemJ2RXNx?=
 =?utf-8?B?ZysyamRscEpZRDk0WFZzRzVTZTBsd2JzYmNydkdWTnd0ZlhzNUlTU3oxdXB6?=
 =?utf-8?B?YVBIa0Q0TzJwZzJnZ3l2WE1RV3F6dGEzRlNiOTFzVm1HRllFaDZMeFBQSzJ4?=
 =?utf-8?B?dVRZMDNpYWJsSXkxMCs3elZUUHQwdzdhYmpxOGRSSmpGOVphMUwzT1FZTzd3?=
 =?utf-8?B?eXJlTzJ2QlZtK3FaaTViSDZIRDVveXgyT1crYm12Q3JDcXB3NmIxYStndmhw?=
 =?utf-8?B?U09vdi92SkZaOUh5VFhMRTQyeGZGSkV4a0ZaZXJ3OFBmWG1zSXV6bWpEVTNh?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DBs/QERKM2Brd0RWeDf+rXvZlqnbGfk11pRH+YGzWjZdtGLxoF9dw4qBRf3fuUB8wDbhf4RUVJtnD9W6/15/O14eUtyiJBFxsSt9LYYheO/Piwd17GV4TZwNFbOxyifYVWs0hSvGW9zppJi17xu05kMbUCVeh5p8gKT/IQRscsxYXM23+ToNwrqTYPK/WLHJwbnUFmuG/54vxMxvurGcJw6kjKmAlI5CXK4OV/zjb417ZLCXGj1bTsPgBa9jwOhpmrVXiaDTCzFygtNzNIdbDLymRT+JO6vyegXTbB9RBCq8s3rF+nzSUKnbz9B7+LPULDanxaS6F2Iqb9xLhhvmT84ml97AwKxtgeTZ71FJemBoYwIfmczeJeNZe8N+tDnwMd4YQ/xnhe7yKLQvvspEu6i3W75fZflPMr8QZldkiygAs0yWWy5u4Y92fOFgYeqmr36qiL4iDJ9slqjQxiacnDMOgrQGi3qylsDF6ks02bwEifQl1zIqJjUd382rbtR8G6hBmnzDmJJIzxIL/d7fse3/yhIrXa0Khxbx92CFRdqp61xUkGYqbARwc35iX2AfO+UG4vh8Z7BkI5rxD5eOl5DfHbHmbBlsLakEaadupuM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c0192f-15ff-4202-7577-08dc275644c4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:57:45.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0t0d6AUTHzs+TySwQcft0g6chngGf4vDwc67iUOEkwx3j4f+BpYdOFbSQdqkIVDLKCEMJ1YtswCnWkmmHfS2IR0roc+es959S8LXzRyDDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=471 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060146
X-Proofpoint-GUID: m7-evC2u6ze5_5MrUbVQEkLqEE79WDLL
X-Proofpoint-ORIG-GUID: m7-evC2u6ze5_5MrUbVQEkLqEE79WDLL

On 06/02/2024 18:32, Joao Martins wrote:
> On 06/02/2024 18:13, Jason Gunthorpe wrote:
>> On Fri, Feb 02, 2024 at 01:34:06PM +0000, Joao Martins wrote:
>>
>>> I have a separate set of changes, that proved also instrumental in
>>> reproducing some of these corner cases in a more predictable manner but
>>> with IOMMU drivers instead, rather than IOMMUFD mock IOMMU driver...
>>> without relying on VF specific behaviour. Though, it relies on being
>>> able to map IOVAs as dirty. This is not included in this series, as I
>>> am not sure yet if such direction would make sense (outside of testing).
>>> Comments, appreciated.
>>
>> I would love to have a test suite that could drive real HW. I think
>> that would make a big improvement to iommu driver quality.
>>  
> 
> Ideally we would merge the selftests to use real hw domain rather than mock
> domain, and skip what's not supported when hardware lacks. Specially as we add
> more and more features (IOPF, DPT, nesting) and underlying testing, it seems the
> most natural point of consolidation.
> 
> Dirty tracking is a little strange because one needs some sort of block/packet
> I/O done to hit the path of having something allocated, which usually requires
> some driver operating to mark things dirty plus page allocator luck in picking
> the right pages. So the straightforward way to manipulate all this without any
> of this complexity on real hardware is this is to "map as dirty" and check if
> something is missing. It proved useful in these bugs as I couldn't reproduce
> this by just using the thing (even sharing the same test as Avihai). In any
> case, the gotcha is consuming a new perm bit.
> 
>>> The selftests in this series (a large majority of the series changes)
>>> are meant to be kept in this order to be more clear in history that the
>>> selftests exercise a given fix added earlier in the series.
>>> The last patch is an efficiency improvement, but can act as workaround if
>>> the IOVA ranges are smaller than 64G, which is why it is placed last.
>>>
>>> [I think this should be targetted for -rc rather than -next]
>>
>> OK, I took it for -rc
>>

I should note that, I have been testing this series on top of this patch:

https://lore.kernel.org/linux-iommu/20240111073213.180020-1-baolu.lu@linux.intel.com/

.. because otherwise the selftests wouldn't run (though it is all fine in v6.7).
But maybe that got resolved in some other way that I missed?

>> It is bit unfortunate that the number of huge pages needed to run the
>> test has increased but it seems necessary to reach all of those
>> corners...
>>
> 
> One thing that I have here as TODO is to make sure we check if the necessary
> amount of hugepages is set and instead of 'scarying' the user with 'test failed'
> we SKIP("...") with some reporting of how many are missing for the test.


Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8605FC433F5
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 11:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23D6D403B8;
	Mon,  2 May 2022 11:58:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rr5p_2QRY5xU; Mon,  2 May 2022 11:58:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D07124033C;
	Mon,  2 May 2022 11:58:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91943C0032;
	Mon,  2 May 2022 11:58:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9ECCDC002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 11:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B3F1403B8
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 11:58:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id epQgmDfOuM1t for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 11:58:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 47FAA4033C
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 11:58:31 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2428SwU3013484;
 Mon, 2 May 2022 11:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6yTUG9gO7zFO19ILTUMQNYz7d1sluwszURiJnZKxYhs=;
 b=nvn4HSD/S1bKQg2zXiq1TyBsBPjDeRUMYA0JWNu38FfzpGXRwp/jjfcONys3aeRJPt74
 A/vhdGsZ+lBAcLiZisjrKLpa976gmzOK9JV3tDaz+U8j5PdUbS1HEE3zcnuqDC3n+nX8
 ZFhIwDF+R9YfvDLzZvAyvMveb3U+RUxuU/IMp7L9zUajPUEeI+0aRCmzIvQvgi4Fyj0T
 ngjxHFqoRshphBj0i+Xsm0k97lkXwjZL/QFyBOwDIeBQvd9TYpQdpfT+DmrhJDipnhxa
 /ZekArH1+wl9RfXCQV9RdnCCGCOe0VGo7GuZj12WkkKGtRW+SJaSVSQXaob6ohN//mCJ ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsb0vb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 May 2022 11:58:08 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 242BuNOm003187; Mon, 2 May 2022 11:58:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3fruj7xtb5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 May 2022 11:58:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSXgL/mi5kfjnDIdMxeRdCnWgLwq5Ujbd2MMyzRXVdtf+BldrxlHLP9xni7QhYtIQvDidkx1Nnjq5kZ2PdXyvN9SVrikGKEZTm6z1hgv7FWpp/PTBdkVVZFktTCxe+rp2NX++ThEgHbV5OMHs0+iav3Q394IQQegU6m8Z3NckXLQsftnFIvTbJMJzN3AHwKBA+4zYorAzNVcu/AX9dScv7eKZo+lNmqrAjXNA0cEHzviMgPfDBiaEa8Lg/KOmnYp2+Lm51sHO/+VwdzNPSz92/pvTfvtaxGltZpZSxDNFEo8jLkytnx6U70lj3DNSpvIwvkKH/sJz0Dps7Ie5smD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yTUG9gO7zFO19ILTUMQNYz7d1sluwszURiJnZKxYhs=;
 b=BG/vfzA0lVKvQ5eldbeyLfA938SyJGtOdy9B52srQtQ8Kt6iOrHNASCTpSJayzTIAXUtoZn/LjgqTyjvw9Rq7QynaF0EJGjTDd14YjBoAOvQMYEXn0aB6nH82ChegxF99DScvQsICgTpg0WXKd2eE3SfqiCuIsf0ifxjjRPTH78TpJ0bXkYOiErO6KBU14gqH2XPQ8HlJDPmKUyungssZz+T+0zfC8gLSiQReoufM6N5Z0xnfhrDqfrAp7zBZG6PpMhCnbAZ9+LYAsbHr57Im7e/hC7rWG8IHOMiHYQ6VZezixrC8YdNut4VKKjGoMK209XYdsHn4DiNHuBYtCjJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yTUG9gO7zFO19ILTUMQNYz7d1sluwszURiJnZKxYhs=;
 b=kYf7h1iSwZSZFfTEqjBNITdx2x3b81ZVb4ev4QiEmB865h4uaIrf6sm2TDJgylQ6im/vHuN1o6euu9G0+NKGROMsI9JQjiOAtqPLQIyFkNxTD6aHHe9CE7fpsoAnMvOmU4w08fMCIXypfzqcwhC5T6mBoCBNeJXuVua0oCXPtfs=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DM8PR10MB5494.namprd10.prod.outlook.com (2603:10b6:8:21::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Mon, 2 May 2022 11:58:06 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b9e5:d1b6:b4be:f9d]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b9e5:d1b6:b4be:f9d%5]) with mapi id 15.20.5206.013; Mon, 2 May 2022
 11:58:05 +0000
Message-ID: <bef4a196-e9b2-629d-d2b5-9fb8af9190f4@oracle.com>
Date: Mon, 2 May 2022 12:57:58 +0100
Subject: Re: [PATCH RFC 02/19] iommufd: Dirty tracking for io_pagetable
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-3-joao.m.martins@oracle.com>
 <0e2b2a3f-1fbd-ff81-d846-eb7091de53e8@linux.intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <0e2b2a3f-1fbd-ff81-d846-eb7091de53e8@linux.intel.com>
X-ClientProxiedBy: LO4P123CA0304.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::21) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95315f1f-f28f-4c0d-1331-08da2c33046c
X-MS-TrafficTypeDiagnostic: DM8PR10MB5494:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB549448CE099A4693D08CE838BBC19@DM8PR10MB5494.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oa1Bf0/P8fgnDgxynigrPvH7IwgL/qaDXtroYNTF8c2yyZp3lAXUBJr6frGoMZAmwc+Vz/0ghQMnco79OOR3ZV9iLJMEHUT5cVABGyFLgQA7MW1zuVaFwbVpBG/hL+BEKuPDfi5hsjLhS8sKG4esin4NkHXnsFl1eYq76oX08krpO7WZweDJ7CYpd4eSbMt63C/kYeH2949KPrs5OG5GTzaz0WM+tGDtn+vriUHkUcmuEkOnKraEmcmPdRaABpDeMxecD+Vqu/FzjJipRlpDKGgiihHV4sWnnGfZzDjvyy7kOCcLyHwUbH5ThPgNf7GWmKIiat0u3w24wEyCZkkOCSXQhDbicVcV4DsK/Uw4H/5bjbE4euXU3aC8c8vqe4Gtsd9TkHUEQkdpJKTT2xNGXU02QhrbjxH1bB45O+qdvidMKS695Nzy7Zcoc9qa1HWzUu6lOEZG5NP92HRvVQ0ismuQfxGBFXbKd0fYL9XQg3tXGaD4gLBJvCeTvwYzMVA63xQEUznbBtmL2lA2x8vQcBPCeH75OK1Xxmy2t7O768JHMqP6R/nqLXua2T8xlkL34goSnhfNIR1FXiiMzRB3d+65RLzN1eHTuNlFbruo30Q0manYCOTeChYLGrFDjThSxfwuEcg8xI0kEl1Q0GQYFVzd5UGUbYeT1f9mHD5esj+GNcTIOqeIYA/JBd8ndn/TRBw/DhA5On7V+ZgvqCf/1Y/6ut8hKW4LETbT0UmRvxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(5660300002)(8936002)(4744005)(31696002)(6486002)(508600001)(7416002)(86362001)(2616005)(26005)(53546011)(6512007)(2906002)(6666004)(186003)(6506007)(38100700002)(4326008)(8676002)(66946007)(66476007)(66556008)(54906003)(6916009)(316002)(36756003)(31686004)(83380400001)(14143004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2ZnMEFWN0x5SEtDTGNOMmgwZmZtWFZsU0xrN2tvRVVVM0lOSnkzejQ4TzVB?=
 =?utf-8?B?ak5Dd0FuV29kZnRSWE5raHliMDhiM3pYcGJYc2VWclA0RlZpTG9KMjN0UFJh?=
 =?utf-8?B?T0J4SUlSOVpLUkROSXdaRXBsNGRlK1BoaHpkTGhUM1M0eDR2Y0pBK1BONnMr?=
 =?utf-8?B?TjZaTzB1eWovbkpFVFE5RWthWGI5UnEyeHhrVklIUkRobVFsV3o5TTZMRUdk?=
 =?utf-8?B?ZSs4UjYxbFZrc0g3c1dqYTJrL00wTTg5MjVzcHd1ZWh1eXdRMDdTRHVVaW9L?=
 =?utf-8?B?UGtNZ2lPQzRNVFRPbWhnTVN1dElTcGlMbkxIYXVPbGdBS2JBRHJ1cXpGMXdD?=
 =?utf-8?B?NDhCWEVzQkpkZENiUmlWMGV3LzhxbU9mT2hoM0tlQ3pQRG40cmsrMzNqejFp?=
 =?utf-8?B?UlYwcHRGV2ZkVnA3SG4vUjNKVGZvVHV0cVJkMzZkK3pSOFRYV0RPK29XcTdM?=
 =?utf-8?B?ZnBjdHphYlRyMW9BR2I3WU1qVmwveStmOFJ6d0NmaXBxUG11WTV1bXBMbUly?=
 =?utf-8?B?TXBUMU9jamJySHFNK1JnZm5WV2xFYTgrWlNwTWRobWlnY085dURTOHp2TUNO?=
 =?utf-8?B?UUIxOGFBcDJsUUIveUtBMEdZczgyVURIZW1UcTEzdUZyRS9nYWQ1S3BTYnpM?=
 =?utf-8?B?U1dobDV4cU0xaHdnSnBySUhpeDdvUE1pL1hBVUNjVVBSLzdNenVNeXkwL2xX?=
 =?utf-8?B?WkkrcXBxVjBxV1M0b3AzUnBkYm1CRU12R2dLY0dvNjA2YzU1QVBSRk9wRHFh?=
 =?utf-8?B?TFUzMXVaVFJhVWJSa2l3V0QvbEhqQzkvQjNhU0JEVnNIWWJzTHhSZmdQM3Bj?=
 =?utf-8?B?UkFOQ2NtY3ozWVlJSmNwOU9IRGIzc1hGV0JUTmFHbDB3L3QyYm05K0o2MjVS?=
 =?utf-8?B?dWsxRDZDZWVsbXhSYWFSbG5QYyt1SEU3Qy91aWVVOUYrWlM4eTRCYnhKbVRW?=
 =?utf-8?B?Mk9LbjdjTW1FYzcwVVRqZTR4QWppZHNtNVVka2RKVzJZS1J1SHdETVFZb1Z1?=
 =?utf-8?B?cngydCs5djllNXplZkV2ZWJHbEQ1cnpOcVNDWDFEVllURHFxc0c3S2NmOGc3?=
 =?utf-8?B?OHJ5SERZNU1LOEpFSjh2aW1WUElWakVwUUpZQzFNOE1XMkg3RytEendJMTM4?=
 =?utf-8?B?Z3JRdllYdnFJdmV5RWJpSjRDS291TGpydkJCRkZvdjYwaGNjdk9qZ0UrNENN?=
 =?utf-8?B?Si80RHFDd0s3cmtJQ2NZTTAweWczNlpjQXVna0FPNFZFa2dYVDVmenhsd1Bn?=
 =?utf-8?B?TzdYekdRQTg3VjN6L3JOemU2dnBZc0pPL1I1YkxCZEcva2pvNEQ3cmFxbEFO?=
 =?utf-8?B?b2RxMjRpY2ZsVmtyN0w3WXFZM1ZRQTBnY2g1Q05rbS9sQTFyZnlDK3A1NUZU?=
 =?utf-8?B?WGFiZTNIY3FOd3JLVUtPOHFwbDJpRVloK0xid0VNOWE4S1JqL1JzektHTjlx?=
 =?utf-8?B?TldUTlpQMWhFQUtMVkJDbmlrdkRFTTRBbUl4Wk5BL1NmS3hOUHB2TFFPSi9Q?=
 =?utf-8?B?WTlNbzNDMWJ4QjBOQjhDaTNaSHcwcmVGL3M0dFltSTlSUitXdE54aDRLQjFD?=
 =?utf-8?B?R2tkaUM2V0pUUldiR3RPaG1QTkRqSVRmNm5RZm50dkZwZUgvdDh6dEgyRjZR?=
 =?utf-8?B?ZlB5OUh0RmpINHc5QUJrMW9CbzYzc3pqT3J5S0VuOGxYeDJ3T2ZWeFZlcXp1?=
 =?utf-8?B?YzFjZ2hob2dVd1d3cGRSOXFEZk45R3l5RHFRVUlNZDZMaFVwNDRrVk03Mjcw?=
 =?utf-8?B?YlFIdGlscUl2T3RMWXdyS01BeUxuK01SS1hTcjdOM0dSc29aYTBXQU9GMWFV?=
 =?utf-8?B?WU5PeDZrb1lrVUZ3NjN0bW83R1ZRcGdkdWZFc1hpQWZEaWdMV1doSTljM0hX?=
 =?utf-8?B?c1Y4SkpOeld0aTNoOHIxOTArSW9qUXg2bWZOWVRpSG1reWp0ek54Ty9NKzA3?=
 =?utf-8?B?T21MQUMzNVhhTFhoZVZzRE1VWXFqN1JJejdDSHplM3Z4b2YyWDRBNVJkakx1?=
 =?utf-8?B?dGpGN2JYMUdiaEd2MFoxcFkvZ0tkYyttcGlxdTQ2dGIyQ0t2c1FhSTdEdWlj?=
 =?utf-8?B?WU5ObmNORjhBZUtZb2UvUWl6RnBzaGpML1NKS3J1eHRLVTB1UlFISUZGRVdu?=
 =?utf-8?B?b3k2cmJtc3B4QWE0Z05sZlhIS1hzZUwvdnJVZzBtdWZHM0pwaXMrSU1iNmc3?=
 =?utf-8?B?S2xWMGF5RU5TMHdrd2drR2NXa1drdksrNndkUUFNdlkvUzloVlZWTmVYajVj?=
 =?utf-8?B?UzJxc2UzVDZYMWpmM1N1K3pTRkx3ZDk4YTN0V1F5R3hHT05rK3g4TWplNml6?=
 =?utf-8?B?bGVZRkl2NDRnemREVXpjbEJHSGZLY2hJaGJSL0NrWldidmhITEtnSmo4dkp5?=
 =?utf-8?Q?KfavzZRxJ3t/pmAI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95315f1f-f28f-4c0d-1331-08da2c33046c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 11:58:05.8606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAMyPcllajazK/G63XlVl9PRMwQSoJwjzN9mzrrvKr5n4Z2tzMeuZP1d7MQ9HEsIRyc3/mmO/QmAShdjqtxT8eWc+1MoR9oyQeHlyjc093A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5494
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-02_03:2022-05-02,
 2022-05-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 mlxlogscore=901 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205020093
X-Proofpoint-GUID: JZCJyFH3ee-OHLpjgJpbi2ysauHN7n-E
X-Proofpoint-ORIG-GUID: JZCJyFH3ee-OHLpjgJpbi2ysauHN7n-E
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 iommu@lists.linux-foundation.org, Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 4/30/22 00:51, Baolu Lu wrote:
> On 2022/4/29 05:09, Joao Martins wrote:
>> +int iopt_set_dirty_tracking(struct io_pagetable *iopt,
>> +			    struct iommu_domain *domain, bool enable)
>> +{
>> +	struct iommu_domain *dom;
>> +	unsigned long index;
>> +	int ret = -EOPNOTSUPP;
>> +
>> +	down_write(&iopt->iova_rwsem);
>> +	if (!domain) {
>> +		down_write(&iopt->domains_rwsem);
>> +		xa_for_each(&iopt->domains, index, dom) {
>> +			ret = iommu_set_dirty_tracking(dom, iopt, enable);
>> +			if (ret < 0)
>> +				break;
> 
> Do you need to roll back to the original state before return failure?
> Partial domains have already had dirty bit tracking enabled.
> 
Yeap, will fix the unwinding for next iteration.

>> +		}
>> +		up_write(&iopt->domains_rwsem);
>> +	} else {
>> +		ret = iommu_set_dirty_tracking(domain, iopt, enable);
>> +	}
>> +
>> +	up_write(&iopt->iova_rwsem);
>> +	return ret;
>> +}
> 
> Best regards,
> baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

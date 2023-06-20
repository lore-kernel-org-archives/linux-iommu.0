Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F112E101DE
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 14:51:56 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KBepA1013014;
	Tue, 20 Jun 2023 14:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7Ul1LgXgtQb8BkEfj8asepXEclglEf7MykAjBYZbEzU=;
 b=vYsa0YUmya0sd2r+BTWmasmnkm21Xhw/Hkew/gtU4cDGaMEtIVG1MoaoIAfMFAy/zslb
 xaP1Bi5LqOvrav9AFd4WBnHIyDYx+UqUn4zfCtDOHW7nSM5QHnbDZM87IP/ug9ok7j5A
 7Zw0Bcn9wdzSRtPBenhgvusPKtxt80sy4B6zQJnS7Xe4wr45FnIxwsDGw8cmwP/n25aU
 kOboyrIA+k2qJXnl59+fQUL9sQhd/RSPpbwuRJdG5SQEQ9byHK4AT9NwIT2y/4chhut2
 WOFrwdAKNdx640mIsz718F6RK584miTfdjyPMsKDy6Y33hsn+um0cWmc+ESUPnrDXDFs 4Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbn0mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jun 2023 14:51:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KDou5Y032910;
	Tue, 20 Jun 2023 14:51:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9395pbpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jun 2023 14:51:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfBqNUaxsWQIKGQqj0zoq1oedsG5hQ5Daoa15+1vLWk1oBIkS3qrmTZyqz7LOAUWrVnaFMS0nxcXzBsRPeRqqCWYc2NCFXW927r/UXBOjno+fW3g0ZiHDCEpoUyxUpd3Sf/UhlGsh7dahdrdwWKXMLpdHr6q+aR1T49z8JFVoeU4cgNXr7p9P++B7eipZSTWyZSSvK3b0QsQN50M+LiXmbWO49OFOEUOPxfSsAyv1M1EkVG0OLL2Z4FP102eK8Nmm9ey+MIcFQ7qfHuIObtTf4v/DZkM6wRbsqqVG3oWG1mx51+PxLr6rSkKD3ppSrAEkEeziSGnTKoJ3DdFxv2ppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ul1LgXgtQb8BkEfj8asepXEclglEf7MykAjBYZbEzU=;
 b=DPzP9d+PY9GDlcW5BiOClvHdCA9mzUGiqSQhYO9Ptw+u4T1nPoGNInfsHUdxJGay198/3RQtTNUl6DEbQsHOwXT1gusvbgRO6utL9F+RjcwWTf9buuPKwX2VSmKPgF+wvXAfwG0lkylkwT28rpmIaXJSIP0bnfKmwswNXoqcqkSdI29qOxCrSuw22qzW2/FluMrsaamCch9p8lfPiRh33rHo8JuH2HPy11KW5ELoi1SWHB0z+zQKGAaT/Qt1TE1OlOtfbsluBa9QE5rMhkuq31906p/FavxhHwnun6d4i/cP5esI7pMTD9KHq7a08MUq9lP2G9y4wfU/XZSRsch4yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ul1LgXgtQb8BkEfj8asepXEclglEf7MykAjBYZbEzU=;
 b=Emxu/1fn8Lxjd0/XaHt/NoXffK6P2nWMTvLwd+J1WoDfE0WfrxA7/D/exjvO4afocYQob5Iqa7ZVH7gWZ096aRFM306EjiXQTolo+yWmCk5nskqXJxlYA04rldQGJS/RX1dJF42F1iYm5j95Xq0Ffd+4JuIoUpY4Q7zk9/wqcx0=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CH3PR10MB6788.namprd10.prod.outlook.com (2603:10b6:610:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 14:51:48 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 14:51:48 +0000
Message-ID: <f0b4d748-9c13-7214-e578-a9cb27ba6e4c@oracle.com>
Date: Tue, 20 Jun 2023 15:51:43 +0100
Subject: Re: [PATCH 1/2] iommu/amd: Generalize log overflow handling
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: suravee.suthikulpanit@amd.com, iommu@lists.linux.dev, joro@8bytes.org
References: <20230609101746.6412-1-vasant.hegde@amd.com>
 <20230609101746.6412-2-vasant.hegde@amd.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230609101746.6412-2-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0215.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::15) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CH3PR10MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2a12ff-20f3-4c6f-876c-08db719ddfbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Izsz/9TO1iy63jh6/eT/l/6La9oFOlgGfNQ1dtBGnjvK4TB+bjbYVqCLqQvSKqWv0BoBONUlvEjiYkKAdrQIaNiVQHR0UP2408fmJ9aHPATbxLYgyYkt65sfVRKvS9Okk5KKkctz/xFoAnTbVG+MC3STRh1lG8EPXexrumE6WAmPQFOz2w07J17LOTyoCBKitiu3ajxPU4xBXmm/6KfDjFWxSZXn6BhBPqOcgSQzLUIo+U3l/HY0l25903OfE5O6bueiWk1HDhJbV2KPQYIJGBMz6M8hbicNwXKI5NmKNOr4qLWmQnSVmPb4kLnSCMoMKYsQ7Nvmt1M35VnjnnEop+arfUffsEZ1rCmSLH7H4w5nj5WNn5du9XVd65CirWRvww+/P/rei4YlzzTQc1eGcRHmz3uBuaopTxdaNmwZ/gszxIDCsQ/q4xNjsZobf5CCYTAb8OVHG3S6Gj46Z0JpBu5LSLQjw+WIa9VlF1vwZ0C/9fhipvL1jWQJrFW/e76QpZr04TVsc4tICkHdjpbpr+qQGNvzuiAWZ7jvjN9CJOyU7n8yL4UhMMJsljbxyEM4ovPkWxZfqwSpuMS7wtAOjMazm7viMT7WOJBSsXVvCFAuUUauXHLshyveKm8XxrK0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(5660300002)(8936002)(8676002)(31686004)(6916009)(4326008)(66946007)(66476007)(66556008)(316002)(2906002)(41300700001)(6486002)(6666004)(478600001)(26005)(6512007)(53546011)(186003)(36756003)(83380400001)(2616005)(38100700002)(6506007)(31696002)(86362001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RnN4VW5KUGZ5OFBURVRVcXlNYk5xUVJsSlFRNnRjSVUzeUhZOXI5YXlFT05w?=
 =?utf-8?B?akcxOUQ4L3BRYTRDbFdKWVVDSDVqdUVsVTk4cnpwSTlXWGk5cFFMUmNyMjdQ?=
 =?utf-8?B?RDczTG9NWTdmcEhqREI0WUxKeDlMd0VINHN3bG5nU1NLM2hQaG02ZmZCTDlD?=
 =?utf-8?B?VmczZHNNWUNvQzZQM0YzS0MreDRaKy9qSHRqRXVGR1JKZTNBams0b3MvSGN5?=
 =?utf-8?B?YlZaZXM2NDhKNmZhNTg0VDJMOFVwdlJ3aGJTSksxdkdEZHBpNUZkb3QvNkFr?=
 =?utf-8?B?aTlYWC9GamtQU3RCbzE2S2tKRE42eWtrY1loM0FaQ2p2Z0NDTFI2b2JzQ25D?=
 =?utf-8?B?dGlYU0x5SElhZXk1d0NaSFJPZDU5bEFVYlpNR0g1dXk5dGRiQkJZYUwvV01o?=
 =?utf-8?B?cnJtb1loNFVKdTQxNHZGUlN3ckFzaDNnejBRQms0NFN5RUN0S28wcHY2cjM4?=
 =?utf-8?B?RXpnVXBHRXNHMG1GYk1RdkFiTzI5Mlh6VjRVRmw3Nk11SkROTjFBUHIxcCt3?=
 =?utf-8?B?VUNUUHdOcklmb0RyRjVSbXg3WGt1eThzMUtIU2FoTGVsYUFvZFJJUzM0cWkw?=
 =?utf-8?B?dCtPclNLYjJMNFRiYWQ0NGFTbTVGSGlZZ0ZseExvK2lMbWRWdDdKam4xcUZn?=
 =?utf-8?B?RFBpR0RQc25xaU44OXVnbmV5VDNub0pEUUhxaENXMTNqVXNSalZwZlVkeVRx?=
 =?utf-8?B?d0QwdGR2RGROelAvRjlNeTdqdW5SL1NkYlg4bjdSMmxvOGI5aWtmOFo2bldo?=
 =?utf-8?B?L0pQTXdxeVkwQkk2WHZZVE5ZQi9HdlpYbDh4WnZmT3VsemRJSFpkVkQ2NGxW?=
 =?utf-8?B?UnZTNmJudnJnMDNSd2tCb1dOMk9CaStEWGxoZUx1V3Z3STJqTHRHWlY1Smg4?=
 =?utf-8?B?OGRCamNKNU5sSXlCbjZIR1ZxYXBrNEpZTCtZU3g3Q0p6QWUzV0ZyWGJQRFVv?=
 =?utf-8?B?QXY2S0YvYWVFQk5UNFdBWnhLT1pCWDNuVjdvOE5SbXFPU3FwZHpVVXp2WHV4?=
 =?utf-8?B?UVRhczJQdExwWlo4YjI1TnZBNllzczlud3pMR0pUQ1ZpNmtxM3NFVHNYY1k5?=
 =?utf-8?B?ZWYrQmlqTVk5MDE5RUpZSVBxNlVyZ1ZBY2tMVGN1cUNCaDNLME9NZ0orQWlV?=
 =?utf-8?B?QkQ0MEVlSnE1bitjMkpnYnd2SVM4aUpuWmc1TkVBWkFrUzFEVks1R1FZS0JI?=
 =?utf-8?B?RXVGSUIwa2VkbEhnQ2FJOUozUGRUMitwUXZHNkk0Q3JRbktoelpWc2pybXRN?=
 =?utf-8?B?elRCZTE0RlcrbWNsMzdmMFViZisrc0V6NlpuWDBDZG1lQjFRc05lREFwWnhp?=
 =?utf-8?B?Nkl3RHZvRkNjMFk1NmdRZ3hkMkNwVG1qbHFRMERRTTNCTHRCM1RJNGt0WHd1?=
 =?utf-8?B?Ym1QUlJQN1pDSUY5Tm9rejJ2VThBb21teUVZMnBVeWJuWU5NOVo5VHVsU1hB?=
 =?utf-8?B?WEtVUDJYVFFTRGRaR0VHa3dMc0RncFdOQW1Jc1Q0bWNPOGIrMjlpWHpEbmFD?=
 =?utf-8?B?MUVsekFTS2l4TzJNUjFzVkZJemdBOHVSUDhVOXdLZkRKMzlIMGRVSDVPNUlr?=
 =?utf-8?B?cGN0VkgrTHpObkN0YVliZEt0VVhZaEdMSFpQcnMzS1UrdHlzMnpzRWxneTJK?=
 =?utf-8?B?TWRxaUtZN2RpM2FSbG9Bb1RJRjFVdDZTSWlaRlJFeVVTcjZaeGpGRjN2Zk9i?=
 =?utf-8?B?V3NpQ3JZT0IvcW5MYXAwUVNtWXlMTGZLNkdNZml2ZExyajJydnEycUM1NzFR?=
 =?utf-8?B?VU5pbG5jYU9nay8vT1BVVzRGMW1XM2h6TzdxcE5TN2p1QUF4azFFa0psbEV6?=
 =?utf-8?B?NUpOU0pXYW4xK2MyLzlXYU5pTmlxNkpuSWVWVmM2VFFVV1NnSS9iV0hnUkNn?=
 =?utf-8?B?WkJadktZY3V4WHdoRUJQSWZGdi9TVGQvRmF2cjdNQVR2cnVVbFlwRmlKZnpX?=
 =?utf-8?B?T0xnUzFNZm94ajk2bUVtN2o0ZnJWWU1HUGZFMVozUDFyWUlSa3JHbzl4SXdo?=
 =?utf-8?B?R2tpWEcxQkczdlVTbEVWSUg1WUtwTTRSeFZmOVhPZ1RRM21kVVdVRUxwamxK?=
 =?utf-8?B?N3JwUUZIcmxjWU5hSVNEZGM5UlhJYlQzUzh3YVNTTllFSDFVK1EydTZOQThR?=
 =?utf-8?B?cDRsUE5QYzZJRzR2NTBNM1F6ZFRLRU94RkJHYTBFcVB1cE1Beldndi9BMUxN?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MYontibN2FdBQCamK8KQgwvwEGC25hGO9TU+jWX+wNO9Gzm4X+ekyZ6SI1s1GKJ3AxeGoMGY2PDkQX7nnWijhiimMNs8oxbm2Jsebyd/81VDxzYt2k8wuhks8FegcBEwZQ4rLTk0oX7zw65OGACdzDJ1Qq1T/n0xfpYofBJszmjPzVVdJRyBjLGV23nIl26dzmCDrf6XFmnAt6W1R3VFptWQOE8mE+JEB2NIUXlSwmCwFw0d2hodaYFcfgnolq7pIA1+f9eVsRh61h8Dd7Pz+f7vI/TMnQ2PKsOIsB3MqB4sLStIVxdCcPEshO8SCcE26NwkI/Uybn/PMLwV+b4DoMLiAEJhGEKjuVWqGJq3j94Xvn9jheLn8mXmZaRovURc6/kH+OE7E5f8itlXH4INxhTh+vzZrI3n0daWP/oPtKCTT79qBJDy+Qs/wowqreXoJr6tqlu5P6fKxC9/0nT978L0CnX1jHC1a9Ca4JRSuyt/f/kpiRkJxnkFlkSPaoVLONLa/j+dTqHW7YmJcxFA0VSTmvFSNKFu5D10W4PZej0E64rVfg7ebGHEzi+eYW5w3rGt6scg7zafWCLZ5gwbdQFbcdZ3Hg+CNRBEIEWuth62HUVPcn9OBpX5Oq77FgLdg6Kl30MdI+lqXMowj48jg41wgXTK+NVPSuhzoIv5zRQRGSL2HTXnr2NxAxw4urE7nTJGjBx2fjF7BuI/BzY5avhj1z9x3m2G/syzUpe/nYWyUGEGSRgrKEq46IkLkLnx3Xl0hVinpA4WBorruznTaY4SppCYeJHZIWAuco2dxC/0G+4Sid8YEzIzif1gXOmJ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2a12ff-20f3-4c6f-876c-08db719ddfbd
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 14:51:48.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpqcVuPq9AC+0yIS0lo2nw4pnEzBxeiSHSyrSJ1ciyMSyWGF+BjBkd+GI/jvjymxzS09Rfbs3YpcIuh259HoCsYzLm6laO+5hL/NOXEuRow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_10,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200134
X-Proofpoint-ORIG-GUID: ejjcZZ0mmc5wM0cJnFuAdEzWrXqV_5tD
X-Proofpoint-GUID: ejjcZZ0mmc5wM0cJnFuAdEzWrXqV_5tD



On 09/06/2023 11:17, Vasant Hegde wrote:
> IOMMU has three different logs (Event, GA and PPR log) and each uses
> different buffer for logging. Once buffer becomes full IOMMU generates
> overflow interrupt and we have to restart the logs. Log restart procedure
> is same for all three logs except it uses different bits in 'MMIO Offset
> 2020h IOMMU Status Register'. Hence lets move common code to generic
> function and individual log overflow handler will call generic function
> with appropriate parameters.
> 
> Also rename MMIO_STATUS_EVT_OVERFLOW_INT_MASK as
> MMIO_STATUS_EVT_OVERFLOW_MASK.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Really nice rework, fwiw:

	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

Just a though below (you don't need to address it, just an idea)

> ---
>  drivers/iommu/amd/amd_iommu_types.h |  3 +-
>  drivers/iommu/amd/init.c            | 51 ++++++++++++++++++-----------
>  drivers/iommu/amd/iommu.c           |  4 +--
>  3 files changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 364fdaa52e74..318b84cf47f6 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -120,9 +120,10 @@
>  #define PASID_MASK		0x0000ffff
>  
>  /* MMIO status bits */
> -#define MMIO_STATUS_EVT_OVERFLOW_INT_MASK	BIT(0)
> +#define MMIO_STATUS_EVT_OVERFLOW_MASK		BIT(0)
>  #define MMIO_STATUS_EVT_INT_MASK		BIT(1)
>  #define MMIO_STATUS_COM_WAIT_INT_MASK		BIT(2)
> +#define MMIO_STATUS_EVT_RUN_MASK		BIT(3)
>  #define MMIO_STATUS_PPR_INT_MASK		BIT(6)
>  #define MMIO_STATUS_GALOG_RUN_MASK		BIT(8)
>  #define MMIO_STATUS_GALOG_OVERFLOW_MASK		BIT(9)
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index c2d80a4e5fb0..3c21e9333899 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -748,38 +748,51 @@ static int __init alloc_command_buffer(struct amd_iommu *iommu)
>  	return iommu->cmd_buf ? 0 : -ENOMEM;
>  }
>  
> +/*
> + * Interrupt handler has processed all pending events and adjusted head
> + * and tail pointer. Reset overflow mask and restart logging again.
> + */
> +static void amd_iommu_restart_log(struct amd_iommu *iommu, const char *evt_type,
> +				  u8 cntrl_intr, u8 cntrl_log,
> +				  u32 status_run_mask, u32 status_overflow_mask)
> +{
> +	u32 status;
> +
> +	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
> +	if (status & status_run_mask)
> +		return;
> +
> +	pr_info_ratelimited("IOMMU %s log restarting\n", evt_type);
> +
> +	iommu_feature_disable(iommu, cntrl_log);
> +	iommu_feature_disable(iommu, cntrl_intr);
> +
> +	writel(status_overflow_mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
> +
> +	iommu_feature_enable(iommu, cntrl_intr);
> +	iommu_feature_enable(iommu, cntrl_log);
> +}
> +
>  /*
>   * This function restarts event logging in case the IOMMU experienced
>   * an event log buffer overflow.
>   */
>  void amd_iommu_restart_event_logging(struct amd_iommu *iommu)
>  {
> -	iommu_feature_disable(iommu, CONTROL_EVT_LOG_EN);
> -	iommu_feature_enable(iommu, CONTROL_EVT_LOG_EN);
> +	amd_iommu_restart_log(iommu, "Event", CONTROL_EVT_INT_EN,
> +			      CONTROL_EVT_LOG_EN, MMIO_STATUS_EVT_RUN_MASK,
> +			      MMIO_STATUS_EVT_OVERFLOW_MASK);
>  }
>  

If CONTROL_EVT_{INT,LOG} was instead EVT{INT,LOG} (like it's PPR and GA
counterparts), I do wonder if a macro is better placed here considering that the
only think that changes is the string name and whether it's EVT, PPR or GA is
used. But perhaps that might be too obscure.

>  /*
>   * This function restarts event logging in case the IOMMU experienced
> - * an GA log overflow.
> + * GA log overflow.
>   */
>  void amd_iommu_restart_ga_log(struct amd_iommu *iommu)
>  {
> -	u32 status;
> -
> -	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
> -	if (status & MMIO_STATUS_GALOG_RUN_MASK)
> -		return;
> -
> -	pr_info_ratelimited("IOMMU GA Log restarting\n");
> -
> -	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
> -	iommu_feature_disable(iommu, CONTROL_GAINT_EN);
> -
> -	writel(MMIO_STATUS_GALOG_OVERFLOW_MASK,
> -	       iommu->mmio_base + MMIO_STATUS_OFFSET);
> -
> -	iommu_feature_enable(iommu, CONTROL_GAINT_EN);
> -	iommu_feature_enable(iommu, CONTROL_GALOG_EN);
> +	amd_iommu_restart_log(iommu, "GA", CONTROL_GAINT_EN,
> +			      CONTROL_GALOG_EN, MMIO_STATUS_GALOG_RUN_MASK,
> +			      MMIO_STATUS_GALOG_OVERFLOW_MASK);
>  }
>  
>  /*
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index ad501944d77c..a29548d98b6a 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -842,7 +842,7 @@ amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
>  #endif /* !CONFIG_IRQ_REMAP */
>  
>  #define AMD_IOMMU_INT_MASK	\
> -	(MMIO_STATUS_EVT_OVERFLOW_INT_MASK | \
> +	(MMIO_STATUS_EVT_OVERFLOW_MASK | \
>  	 MMIO_STATUS_EVT_INT_MASK | \
>  	 MMIO_STATUS_PPR_INT_MASK | \
>  	 MMIO_STATUS_GALOG_OVERFLOW_MASK | \
> @@ -881,7 +881,7 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
>  		}
>  #endif
>  
> -		if (status & MMIO_STATUS_EVT_OVERFLOW_INT_MASK) {
> +		if (status & MMIO_STATUS_EVT_OVERFLOW_MASK) {
>  			pr_info_ratelimited("IOMMU event log overflow\n");
>  			amd_iommu_restart_event_logging(iommu);
>  		}

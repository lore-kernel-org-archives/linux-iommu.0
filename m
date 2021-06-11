Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAD2C48BE0
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 15:20:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BEA2613DE
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 15:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BEA2613DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCF1E415BD;
	Fri, 11 Jun 2021 15:20:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lPZeTnqBGefC; Fri, 11 Jun 2021 15:20:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 62885415B8;
	Fri, 11 Jun 2021 15:20:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44F93C000E;
	Fri, 11 Jun 2021 15:20:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B1E1C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 15:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5789A404E3
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 15:20:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="kPkGaxNs";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="f0REyQgm"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id REAQW3gVvbEd for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 15:20:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2489B4024F
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 15:20:09 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15BFB5KF014142; Fri, 11 Jun 2021 15:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RHPeAxPjO/Hey6EKM0y2x1JoEIz/0e2OqSrgeCEPOdM=;
 b=kPkGaxNspdv+gGtcC/3n0n0WLx6RRclWNrsFMvcGC5d96gtSLqzR2rcFwMDi/J3ngm2r
 fs3+geIY7pzZvZJWsBd7hKnIfPgP+PxN8iEkwGTpKEHjIatNqELzNWLsvmirExdOgwcu
 zhKOC2SEi4pMnut7bGTadB11Wz2rcMUXQ2Zo0iQuXBCYB5xDSDrSw0J4gsMLJyrugjh2
 oIVyQW+fMyZD7LTEN0Iwn3n3bg2bRE/BzFq0VvphTSppxHWuLaQK9fACMFHR3SeiRw+U
 FR31BVvFlK3edqMhG4Eoqb3GZn0fdzaOdXG8/Wab0LICOyzmYqV/2du1PnuhSFbsC4J0 3Q== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 393mkb8d0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jun 2021 15:20:06 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
 by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15BFK5pY048046;
 Fri, 11 Jun 2021 15:20:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by aserp3030.oracle.com with ESMTP id 38yyadhwf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jun 2021 15:20:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJ+z2AQfj4TfEHH+L5Es6fW/jZq7jCKglCNxcW4NGoM75ez6/9jYJthlJlKjS7I+cLCF07Uh38+zJpEleXzrOZHfuqd+DqKD/T9C9PxfjAvcgm0xc4mqHT2fgNQQskoPiM5wHiOfueRG7XlS7gEByK1x79nWjSuLwUjpkMDsEFnh2UtlFaYyPs26/0a8EV9gmt9v6QDjMR2cJlIkOrPkdt3VfklO5qawi8y0fpbDEl25KT1DJHGD++w+Z9s6BjWNGLfrl/ZQn+hfDaXapsgtJBR7KkMSJRLMaXx+ivcgciMqVhEZAh1v4WQJtBZgObvxRkA0OQEyZk5fCnJD+OyX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHPeAxPjO/Hey6EKM0y2x1JoEIz/0e2OqSrgeCEPOdM=;
 b=GH1lrR550GGZ0LT5oQAltVOKO5ZOE0VW5+9wk2xeZeRcA1/HS7SMjszlfhPBmn+lPOxgvsEMPztcDDwLrUBZeyFU/J/7v4jy1G+wOwBuagf+aIZat9xoSHrwLnyKrrS4bKsUm5n/wu82rHpPipbqoJiZbJUw+qF2Jhf9s5sjXhDHGLzY95HoM6ornQu2tkxrjVupONO7rnasmuuzKp4sPEKQoFghqbGJistIBHbPUYfVh6ULlCxOqJar7pxr063mqBgIYlcVPd9EBmIdmT/5olKwEW06ddPPMnUaF1+ykUDbPIqMRIG+OWlhbFccwmghS/1d7V5pHGK+sksruMnKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHPeAxPjO/Hey6EKM0y2x1JoEIz/0e2OqSrgeCEPOdM=;
 b=f0REyQgm8toI4XbxibvZdoMuCSFwa+xXs1OsoAYQ6w/BoSvl9LGbKB/HPMTJPvpp0JpZhNAHoV2IiDwrq/hSEpLnCrxb7bJvoo/J5zi8+rbwLSDdOtLhcm2VeIlJx5vlV4MbI4QziEXlq5odZ7RKOURRaQdh8kMIBg5q7YnKhhA=
Authentication-Results: epam.com; dkim=none (message not signed)
 header.d=none;epam.com; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BL0PR10MB3073.namprd10.prod.outlook.com (2603:10b6:208:32::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 11 Jun
 2021 15:20:03 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::78a3:67d:a8ca:93cf]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::78a3:67d:a8ca:93cf%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 15:20:03 +0000
Subject: Re: [PATCH] swiotlb-xen: override common mmap and get_sgtable dma ops
To: Roman Skakun <rm.skakun@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20210611095528.9230-1-roman_skakun@epam.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
Date: Fri, 11 Jun 2021 11:19:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210611095528.9230-1-roman_skakun@epam.com>
Content-Language: en-US
X-Originating-IP: [160.34.89.109]
X-ClientProxiedBy: SN7PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:806:121::32) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.74.99.109] (160.34.89.109) by
 SN7PR04CA0087.namprd04.prod.outlook.com (2603:10b6:806:121::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Fri, 11 Jun 2021 15:20:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da0c009c-4c2f-4099-8207-08d92cec62fa
X-MS-TrafficTypeDiagnostic: BL0PR10MB3073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR10MB3073A801473EC8CF755F71668A349@BL0PR10MB3073.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QOiSJIBIMphbmlWMtadIlLy4Egq95ASen2tTyf4j6cuEqd9Dq5RRAM0jhix9E3tN0N2ZFOFD/n4eu7k/+0C7nrkcns1LJUsZZ/XZSiEvPw5S2bE75D7E8/gqdvFt2JxXHeZSueflFE00Ej6ZyGMAEyzllz5KeYXn3gzXaF3KENd12kdL+7c6ghO6APdSlNhOc/uFZM9ZSjL0Su3afPSKbMZqb6D7iFywCG/VgD6mCdgSzYdSIbJOIh3zNe+2GdiRbiw6guHpnkT6LKKg8IMQN1nJwRUZOGy7hiRfdxl1dHuaqzwrw4bxSPwlP7jMkQsJQ02z5SkQ18EQYmmGgkhuYOLdsflLJ0d8gkS/UBXeh7jWp8k7mEBHx+gVIgrGcKF2EF+ViC/MkN5b/JMtX+1MyLxZrT3EVwljqCZB4GlureSDNeWZWZIjzBkJjWCtEZswKpso0kSe2i1pCItJX/oxn532IGuau8Nj80BvSGnnFUiXJyidD0LM/yYwyDOWfew9l9nSP4dBpbAnkXYgd1fwWRxaZ2Prhn7F7VRS9KqYhs2/8YsBwN+NqZbINtWU3Q7WdPP6FCeFGWjFppf9WC9qI8v3Qj1ESUBpjWz1QqvzouYyiU/ZJxN9ZlRwPB4w5KVSMpq4/dtJDqqoqCrGL/XHsGDCm9suaI4+A7106B+77sjALKUd3l4wvsKkJ3GZ9JV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5009.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(39860400002)(376002)(346002)(136003)(366004)(53546011)(16526019)(186003)(36756003)(7416002)(66556008)(66476007)(86362001)(44832011)(6486002)(31696002)(66946007)(38100700002)(478600001)(316002)(6666004)(54906003)(110136005)(8936002)(16576012)(2906002)(4326008)(31686004)(26005)(2616005)(956004)(8676002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEswdTVROWNKSkcyZm5ieU1IbHozbXMrMG1vYzRINU1ZLzNFdmJ6azJHckVa?=
 =?utf-8?B?cFFMTy9KL1dBMDFHTTFHNUpnRHMzWVVJam9qb2xtWVF3Q3R3aXNKbVhpVVk3?=
 =?utf-8?B?cXBYUDNMbVEzRmlKcjRBNlloM3pqZngveU9tSkZRUTBWd2pZelhxSFlqUG56?=
 =?utf-8?B?cnpkMHU0Wk15ejY5L1phaEJEN2hMR0t1WDRER3I5ZlVzUEtYanBDaWpwckNI?=
 =?utf-8?B?Mk82cmk5Q015ZWtFTkd2YVlxQ05KMjdYNm9WUG9va2VFeFNrRmg5NG41WUFS?=
 =?utf-8?B?UnA0aWFQRkkvMkZ3aHF1VjcrMkJ4Mm8zUWUyVzJuOXpKamlQczJCQ3FIM3VP?=
 =?utf-8?B?eHpSZkRCak85M2hlbjArcUpXOVdTMC93WVIyZHNnODhWRFpRV1dscVFVRVFP?=
 =?utf-8?B?dDdJcFMxb3pOTEpidDAwcWxjTUE5a0pRbHdPY29aa0FJYllYeUFJVStrRUV6?=
 =?utf-8?B?b3VZTEJ3SThVQ1ordFc0dWRGL1ZRaG52M0xvWC94bkhhdEpCRk9WSXdzK20w?=
 =?utf-8?B?dHdxUE56bkRidjNNVTc1eUtWeXNzMHhGajBpRFp5SERtYmlxZ1FHbnNkM1FK?=
 =?utf-8?B?V2V2MFdjWW1DZG0rc2N1cnBiU0RyZGFGM3NzVXl6c0d0bVhTOFhiMDRhNFBk?=
 =?utf-8?B?SlZwZTlHNnBVOW9UdkR2dnFYcGl1SGttaVdYQjY5NCtieEk5eU1WdFVHUEYz?=
 =?utf-8?B?Ymh3ZmVFWHZZU0dqR3d2dFY4R3JPdVd0TWw2ZmxqbmZQSFVXMURXZEtVOWl3?=
 =?utf-8?B?eThWa3BtZ2V1TGllSzUyYitnVlJmNkdTcEtXWXE0NVprMWxiTEpGcElOQm1O?=
 =?utf-8?B?dDgwRVNSOFNyeG8wWUd0U3ZDdSswV0dXbXBpTGpZeTJWSFNyVlNPMGlEa1E5?=
 =?utf-8?B?bXpjYmhDZm4xcVZ4STdDK1g1ZXVtaVFPdXBmZElCUU5KNzVEMFYrMVRxM1Zv?=
 =?utf-8?B?eXgyMW9YODYyR3dEY210L1VYZm54RWZRMHkyVDFSci9ibnlrVWpuWXd5M1JD?=
 =?utf-8?B?dEdRaGNTL2k3RHFkM1UxOUhYRkora3oreFFubzFyZ3F2aUdIRU91L0JuRGQ5?=
 =?utf-8?B?OFpyN3FRV2NJbThMc3VKWmVVNE13S0IzL3NhRVYxUnZrUDBIdVdwdytqNlQr?=
 =?utf-8?B?ejZoRXdRZThuVjRDb21HdHRQR3VpODdxcGw0OGluOHM4OEJtSGRsOWlzaWZM?=
 =?utf-8?B?L1A2OXc5ekhkeFF4U3VqUmdkMEtteUd5K3Nnd2pFdWljcHp3eFN1bFJBZ2Fo?=
 =?utf-8?B?Mzlna0pJdHQ3M1FkMTNGQnB6YStVNmkwb1RueEQ2TlQrYm5tVXJCbWFJQzU1?=
 =?utf-8?B?bU0zR25iKy9PMTVSOXhMNlcxUW1Bb04zMC9ha0YranFMaXRQaklyWWcvZ2tW?=
 =?utf-8?B?L1lMT2tHUUZSa1ZiZnUwT2FDblR2cHZpOVVuYUVaS3VGMklMM0pBMHBqQW83?=
 =?utf-8?B?RTFIcWViVUlRRERWNStxbXppR09qeXVxRGFSb05hcU5BNHZCdnp0cXRTZWIy?=
 =?utf-8?B?Rk42QUdSc3U1dFp6TXpDcFRxSUJHMzNhS0JkbTBxNnNXbm1UTjFGM1lKZ2Rw?=
 =?utf-8?B?V1hYVlB6R1A4bCtpTzJLaUFqNDk3NFRWa0VaSmNFR3BrOGZJYnJlZ0xjdWRW?=
 =?utf-8?B?dWoxSVEvc24rL3ptWEN5bXljZEdMUFBzeVpCVE5VSVJ2ZzJUem96KzZKb043?=
 =?utf-8?B?Z3l2TUZrSG5DOVdvRmhsckNhR2sxK2ZuUHVPbitJTDdpNWo3Z3lkTlo3NnEr?=
 =?utf-8?Q?aq+J5V9VDpGDEPq8wgU85o1oXReb2XHja+Ej81L?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0c009c-4c2f-4099-8207-08d92cec62fa
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 15:20:03.5757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9y1+DiNv74pKGkCIn3IfPhRB22pDJZXiRYso7WcNt+a7XxDevkZQ76PPYI07yOPfmdEAmXJVL/rietfpWG/8F5syYL3idhSVXjYju5DPO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3073
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10012
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106110096
X-Proofpoint-ORIG-GUID: kiyQqyhqWKmDku9sLu1WET854s78Yl79
X-Proofpoint-GUID: kiyQqyhqWKmDku9sLu1WET854s78Yl79
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Andrii Anisov <andrii_anisov@epam.com>, Roman Skakun <roman_skakun@epam.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
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


On 6/11/21 5:55 AM, Roman Skakun wrote:
>  
> +static int
> +xen_swiotlb_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> +		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +		unsigned long attrs)
> +{
> +	unsigned long user_count = vma_pages(vma);
> +	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +	unsigned long off = vma->vm_pgoff;
> +	struct page *page;
> +
> +	if (is_vmalloc_addr(cpu_addr))
> +		page = vmalloc_to_page(cpu_addr);
> +	else
> +		page = virt_to_page(cpu_addr);
> +
> +	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
> +
> +	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
> +		return -ENXIO;
> +
> +	if (off >= count || user_count > count - off)
> +		return -ENXIO;
> +
> +	return remap_pfn_range(vma, vma->vm_start,
> +			page_to_pfn(page) + vma->vm_pgoff,
> +			user_count << PAGE_SHIFT, vma->vm_page_prot);
> +}


I suggest you create a helper for computing page value and then revert 922659ea771b3fd728149262c5ea15608fab9719 and pass result of the helper instead of cpu_addr. Here and in xen_swiotlb_dma_get_sgtable().


And use this new helper in xen_swiotlb_free_coherent() too. I am curious though why this was not a problem when Stefano was looking at the problem that introduced this vmalloc check (i.e. 8b1e868f66076490189a36d984fcce286cdd6295). Stefano?


-boris
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

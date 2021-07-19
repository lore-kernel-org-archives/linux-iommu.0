Return-Path: <SRS0=4OKN=ML=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F67C12002
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 07:59:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCB8611AE
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 07:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCB8611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0929A60632;
	Mon, 19 Jul 2021 07:59:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1SAikYs6zYnH; Mon, 19 Jul 2021 07:59:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8EA5360618;
	Mon, 19 Jul 2021 07:59:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A4AAC001A;
	Mon, 19 Jul 2021 07:59:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C44D5C000E
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 07:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0F5C40358
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 07:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="JFj/IbYy";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="dVsXrAgx";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="wJvlPhVs"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Py5J8NBkMrZM for <iommu@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:59:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A9994029E
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 07:59:04 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16J7uOUQ030305; Mon, 19 Jul 2021 07:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=D6m1oepGTbl3LmykfBIE8AgqnlAmjohnEyJ+Fnh/85M=;
 b=JFj/IbYya/Q/ob32AN4ernV1co2pqyAU742SX00XEH5DHqt+R6c8yFzHUGsE8Ro2D+Gg
 tGMaC5vrkmYJOpRguMtZR2iZcHrLdn4WfNYaS6qYaSZ9B/EOGmez0icu5/jr8IU6mKdN
 tUM7ISlRuPCqtL4KPIMwJsdLb44nL2RKCSTQcEHXnX9ljzjKQgLD2enjWoZSFZT0Std4
 yd0i4uNJOag+GIx88cPTdx2zDstSfXceDkBfeamImEJ0J/b+GZ4GSUZgD5LAvZvz4LZC
 beGUrjRL8SBGjuXJpMw2P6HFbRLLndlMTYnRhmeIFq/896tEa5rFLGVLi0+/cdh4Llwx dg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2020-01-29; bh=D6m1oepGTbl3LmykfBIE8AgqnlAmjohnEyJ+Fnh/85M=;
 b=dVsXrAgxXVCPEtJYluSgWlOVHTlRkv+XjVuzJfx0kRKz4aKA49jIY4ibWFq+zvdHF5ZF
 Xo/cjEEsYgt8yb6y6VLQBFuyOXwrRcr63V5ibtALp3E+mdw0cfqY9GjDVZ27uBBFfYVx
 eg+GdauMJv8lpRfuhUVXu2QHQRpPV48Ro9QsQpngPmdYKnYS9Nwuxmd4JF3Fx3VyC3Y1
 GtTGdzJbUrjFtTRnsqLIaU/tHoW5L+mXF8U8WScGQ8NDZHaT0Oy9nP1vRHyo4qeBA/LY
 2Uu30WCQ1ajg/jrJjewZywjNKeE8ienbGPvExuVtdjFP0Ysiv5szxHZ/llUE1f7f57fC JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 39vpkwrtvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jul 2021 07:58:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16J7tGuX182889;
 Mon, 19 Jul 2021 07:58:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
 by aserp3020.oracle.com with ESMTP id 39uq148yvn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jul 2021 07:58:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLUR+ypuBm0wSi9l+jxAUHRpZKOpZMcryINAuXrPf9ADb6jsMrOZbwJ4OuJqrBGbOgpXIz8Qhv1PvqyrltH/LCBLUP79idhraclIR3M1eL7vxVUkGGOpQQtoO85kELtHkTWohSVLnKHoXfGddJDoJXWkOJTFWal6OKQi+seEDuh9ez/O+ZNLMbsNTAV/DcwYoVrQVkyYC0WGzmAjqcMqXH+qmQIdfPt0rWSa5Rwu5AdbQhZzybYvrZsaMH7VnOoH2V8dT7vp3hZmYxD1vKptpws6CnZP+e/m9bZfluZbc1xtFOOpmVRuI+xvLvzZIPJfyChkMgEibZgKux7Y6hk3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6m1oepGTbl3LmykfBIE8AgqnlAmjohnEyJ+Fnh/85M=;
 b=l3CKSTE5RLCUt2AiPGcvzWvQwilZaDpDk73WmlNOv3WL+ZvxUzZ0EVg7He8vsJHOs/5S9XWtKwCBgquDfXHVj9AtjsTtG63R+MYIn5jkTkUDY4NVBWxdwZD3zSSxU9rq/NMyWSa22pPxniIqhKkzLw7RhUJ0kW2pdSI73J2OSLjW21medDW+D32uoNU4uRLHR4GSdh3WM5jfqTbxHjiRBWKgTianXao2EtNlXiDyAyE0k43KmQM41kxpxpmi9tP8WJO6b116pwqcXtnvrMX+eWqJtVGMZmuFtlU9ZxvQrDSJDwZo0x3LHfZmCesmZDixWg1FlWM2HyUIA0EP9+/Hvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6m1oepGTbl3LmykfBIE8AgqnlAmjohnEyJ+Fnh/85M=;
 b=wJvlPhVsatwpqSYeh1N4BDZ5pUssZKpvrrEqoUSd0ji9zrttMuKFUcmGuGY/yr3BbTDdCO+FLDq5m5rn+MHK0xG+u14vtufxEt9RDSqiwfL58RIfw6VzfwG7gt4rlNVtxld9TEHYeCiE/sL2LzPICmSeCmZgAJVCxAUHxVWfGNo=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4689.namprd10.prod.outlook.com
 (2603:10b6:303:98::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 07:58:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 07:58:41 +0000
Date: Mon, 19 Jul 2021 10:58:09 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@lists.01.org, John Garry <john.garry@huawei.com>, joro@8bytes.org, 
 will@kernel.org, robin.murphy@arm.com, baolu.lu@linux.intel.com
Subject: Re: [PATCH v4 6/6] dma-iommu: Pass iova len for IOVA domain init
Message-ID: <202107150933.iNUojyx8-lkp@intel.com>
Content-Disposition: inline
In-Reply-To: <1626259003-201303-7-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by
 JNXP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 07:58:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8ef93c1-7387-45ee-c37e-08d94a8b05a9
X-MS-TrafficTypeDiagnostic: CO1PR10MB4689:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4689694D853CDDB1E68121A68EE19@CO1PR10MB4689.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+eK/j+niPlPwjBUjyVXqqbhvVprlurB6MtsWs3uDQXKuxHBe/6ZXJNgbNXtwjqVVEBmW97bP1KPVdl67GoNX73XHShtbsQS2YuCSNJ0JRCpHwNceTvuYFAndT5zkRLWnrb2SV7IYduO8WtbbesFfkHvs8XdZi6KL7s4M1Vzrle7cB6jNuTU0W72L8CL2zRn5GYaHmgebmGSuwBhQp6O1cvkCMLWAMyFLsiXg8Gi1JIrhDNF2ZvCB+k2wmT+0tqGkp4zDELcRA9MW2wxL9OSL650QIdcJuqZrZWLccNHZ0v2LBUy3kFFrNgtWWT0jSlmip2lBCmGHg/t2YKgnL3nR55KzDekeCoKP+aBITOlrX+QrVgtxoFjbNdCdaw5NsOYqCNPWrD32ZmsMiDWlgiNkxMZUs7HRGJbcA+y8RUW0R9Dx/+T7J4PJYf1R01U9KOXD0UVTAb6yTi4qmO/5P6CA+IMMKHMv+y12WJbTHPg5sj4uZt7HZXeVTDLBPpnsD0kj6k25OulvvFTMYa1cIdOcOE0wNoogMZwdypGq/G+ylQBDvteCAxayh8TzPBWUxn7S8gUN6YrT9KPvn4XNw9E8jOf+wlnxzH2tcv8wXMcCrTuOWQSnhiAdmheoYzGe+1gIJDYSgMTo82WpEEyPr80u3fA45nsVsENmilnFvyNIl5ekIHrciM9CyKfHOThMrgtkjhBoMz2P853WINC/ZfqL9xq5aONunzd2Zb24lDf362tkD6wElKv2iRrOCJNbv8JtTxlws+tsfHSq5ayrVxUt8dbuivZc3CQBAFvsi0rvGhhW9vWN3fRduf1NCtFl61u+hRfYglQBdDcvChzSuPfcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(366004)(136003)(396003)(376002)(8936002)(36756003)(8676002)(66946007)(66476007)(6666004)(5660300002)(956004)(1076003)(4001150100001)(6496006)(66556008)(52116002)(83380400001)(26005)(38350700002)(4326008)(38100700002)(86362001)(7416002)(478600001)(966005)(186003)(44832011)(2906002)(9686003)(316002)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RJUCmQaaiTg80p9Takkzxl9CmveMemqf87Pu6Q4lnt5GFLuMGOQ9QCGUUN0Q?=
 =?us-ascii?Q?H9Pq9k3GRT8Cvdv2MO+lGN62w5QeS9GXPZZ6W5dRgH/QcsLAzsak4A5BcQKH?=
 =?us-ascii?Q?6q3wIXgVC8XoDXJwXVIwPZYM1UrCVaO48jsboAbR4wdqWYQVzEigSsCh9i30?=
 =?us-ascii?Q?f5wvivad8JDrOAX++UQnx634SGdgIJhvhxJxDUj2scnIKeGAIn5hySKBWvlL?=
 =?us-ascii?Q?kEBPiDSrsK88HFfONDm/D80kB3pXfqDbKZk7DCPN9K+/x/Xl6sSp4Ft9HmMt?=
 =?us-ascii?Q?ll+R9e5WrQgdyOHKVyi4n/dqiTa5mC6Sbq+6/fZhZKfdDVWNBiIEtLlJNi3f?=
 =?us-ascii?Q?dIldS933mDKURAMs+egJ3lwAr3EVDl8ci3bInvveCfFEQ+kb12t0DGdB+B7z?=
 =?us-ascii?Q?BrNBF+IhdlAAoCToEaBqWK3pPxrXBGB1Bc9KlCf2+H4IBvnF6s05xFztYL8I?=
 =?us-ascii?Q?RHvDBXcWamYIQY4l78zkYGPUWwgnJOpilSxsmYbRHPzyJcxFmcwTUqBq6YOn?=
 =?us-ascii?Q?1DmPa7zpr3HH+kS6aERWPkIFRTjaSOU8q4gY6bgykF/AHr4b3lmx7CmfQRYF?=
 =?us-ascii?Q?pzWawkiPVHfK+XArQW/rkdFflNu/K2JeYKTsGFSO60kIlDMWGXbwiPtW1IWG?=
 =?us-ascii?Q?PQNRG52T8G2tZ0+DxrAxfN0zwmV5sqJWKvDe3fAgdegx03rGlr9kuPjbrW5/?=
 =?us-ascii?Q?daAy6+tcTWzqAXFzIF2s7g/dBQw2c/n42bn/0M6ZHzUGEj3yDHMzS4QsHNn4?=
 =?us-ascii?Q?pSKfpE2lFKWoqPVMLRR1PEWICsZ94dnnPFsnMFa95jRpW6pwETpIuYPwLpOf?=
 =?us-ascii?Q?Qv0uGus2jPlKmbbUtZ5jnORX+W1gPPnpTcCt1oWVjfgWEG5OzAwWElUiJmaX?=
 =?us-ascii?Q?g3QOTLi2SWpbsqPNIjlSYO/1PIt5rlXLoICfdPSgOIo4c2UNzvSTNoJlm0hP?=
 =?us-ascii?Q?WDkDGJiByD+PDa9B9XB/tuMjG9CF5+tNp1DcTcf/D9hnEBh6hSqrrAwyOi1N?=
 =?us-ascii?Q?fAimYDxLKXZ9r24776vTK+xccMSvhW6IuRIzMVDCg8lZdpewYCs8uX/nBF6b?=
 =?us-ascii?Q?xP1/QbBaOaJDp6FUZIJ6A8ErSTx8Tz4V3SPvEEDM6Q8lPx34R7kZsyJjsYGt?=
 =?us-ascii?Q?/n27jx26yvlnob5vqHIocwcKbGJUtWAKPwqgOKfbofAAer1bPts0iDCCuSWm?=
 =?us-ascii?Q?CNqmBY0ia1znVe/wREpbTnDIkxlXBhppo0pQxFdzIyg1j7FiOSVr9mJ21GN9?=
 =?us-ascii?Q?7AedPjEU7ozpO4Ppcc7q8lOEhVqHqM/mGoI9ciZ2s3GBPQGzgIlNDxam73Nb?=
 =?us-ascii?Q?TJM+YMDyFiCuIo5B7CGaTY4l?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ef93c1-7387-45ee-c37e-08d94a8b05a9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 07:58:40.9025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHtoc47EiYaAp9/Cyddy05O/T1+n0OmdoqM9LivBud8Dm2WD/iOlU9laPMq2yGt60teEsng/YqNuMePCtHqORf8Y/hvbc+r39aIhxzI7Wfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10049
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190043
X-Proofpoint-ORIG-GUID: usEAECevK7JvzfCbffI-5SdjWIbSKgOD
X-Proofpoint-GUID: usEAECevK7JvzfCbffI-5SdjWIbSKgOD
Cc: kbuild-all@lists.01.org, lkp@intel.com, airlied@linux.ie,
 linuxarm@huawei.com, jonathanh@nvidia.com, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, daniel@ffwll.ch
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

Hi John,

url:    https://github.com/0day-ci/linux/commits/John-Garry/iommu-Allow-IOVA-rcache-range-be-configured/20210714-184328
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: ia64-randconfig-m031-20210714 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/iommu/dma-iommu.c:384 iommu_dma_init_domain() warn: variable dereferenced before check 'dev' (see line 374)

vim +/dev +384 drivers/iommu/dma-iommu.c

06d60728ff5c01 Christoph Hellwig     2019-05-20  332  static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
ac6d704679d343 Jean-Philippe Brucker 2021-06-18  333  				 dma_addr_t limit, struct device *dev)
0db2e5d18f76a6 Robin Murphy          2015-10-01  334  {
fdbe574eb69312 Robin Murphy          2017-01-19  335  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
c61a4633a56aaa Shaokun Zhang         2019-01-24  336  	unsigned long order, base_pfn;
6b0c54e7f27159 Yunsheng Lin          2019-08-24  337  	struct iova_domain *iovad;
de4ba360c3e4ed John Garry            2021-07-14  338  	size_t max_opt_dma_size;
de4ba360c3e4ed John Garry            2021-07-14  339  	unsigned long iova_len = 0;
0db2e5d18f76a6 Robin Murphy          2015-10-01  340  
fdbe574eb69312 Robin Murphy          2017-01-19  341  	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
fdbe574eb69312 Robin Murphy          2017-01-19  342  		return -EINVAL;
0db2e5d18f76a6 Robin Murphy          2015-10-01  343  
6b0c54e7f27159 Yunsheng Lin          2019-08-24  344  	iovad = &cookie->iovad;
6b0c54e7f27159 Yunsheng Lin          2019-08-24  345  
0db2e5d18f76a6 Robin Murphy          2015-10-01  346  	/* Use the smallest supported page size for IOVA granularity */
d16e0faab911cc Robin Murphy          2016-04-07  347  	order = __ffs(domain->pgsize_bitmap);
0db2e5d18f76a6 Robin Murphy          2015-10-01  348  	base_pfn = max_t(unsigned long, 1, base >> order);
0db2e5d18f76a6 Robin Murphy          2015-10-01  349  
0db2e5d18f76a6 Robin Murphy          2015-10-01  350  	/* Check the domain allows at least some access to the device... */
0db2e5d18f76a6 Robin Murphy          2015-10-01  351  	if (domain->geometry.force_aperture) {
0db2e5d18f76a6 Robin Murphy          2015-10-01  352  		if (base > domain->geometry.aperture_end ||
ac6d704679d343 Jean-Philippe Brucker 2021-06-18  353  		    limit < domain->geometry.aperture_start) {
0db2e5d18f76a6 Robin Murphy          2015-10-01  354  			pr_warn("specified DMA range outside IOMMU capability\n");
0db2e5d18f76a6 Robin Murphy          2015-10-01  355  			return -EFAULT;
0db2e5d18f76a6 Robin Murphy          2015-10-01  356  		}
0db2e5d18f76a6 Robin Murphy          2015-10-01  357  		/* ...then finally give it a kicking to make sure it fits */
0db2e5d18f76a6 Robin Murphy          2015-10-01  358  		base_pfn = max_t(unsigned long, base_pfn,
0db2e5d18f76a6 Robin Murphy          2015-10-01  359  				domain->geometry.aperture_start >> order);
0db2e5d18f76a6 Robin Murphy          2015-10-01  360  	}
0db2e5d18f76a6 Robin Murphy          2015-10-01  361  
f51d7bb79c1124 Robin Murphy          2017-01-16  362  	/* start_pfn is always nonzero for an already-initialised domain */
0db2e5d18f76a6 Robin Murphy          2015-10-01  363  	if (iovad->start_pfn) {
0db2e5d18f76a6 Robin Murphy          2015-10-01  364  		if (1UL << order != iovad->granule ||
f51d7bb79c1124 Robin Murphy          2017-01-16  365  		    base_pfn != iovad->start_pfn) {
0db2e5d18f76a6 Robin Murphy          2015-10-01  366  			pr_warn("Incompatible range for DMA domain\n");
0db2e5d18f76a6 Robin Murphy          2015-10-01  367  			return -EFAULT;
0db2e5d18f76a6 Robin Murphy          2015-10-01  368  		}
7c1b058c8b5a31 Robin Murphy          2017-03-16  369  
7c1b058c8b5a31 Robin Murphy          2017-03-16  370  		return 0;
0db2e5d18f76a6 Robin Murphy          2015-10-01  371  	}
7c1b058c8b5a31 Robin Murphy          2017-03-16  372  
de4ba360c3e4ed John Garry            2021-07-14  373  
de4ba360c3e4ed John Garry            2021-07-14 @374  	max_opt_dma_size = iommu_group_get_max_opt_dma_size(dev->iommu_group);
                                                                                                            ^^^^^^^^^^^^^^^^
New unchecked dereference

de4ba360c3e4ed John Garry            2021-07-14  375  	if (max_opt_dma_size) {
de4ba360c3e4ed John Garry            2021-07-14  376  		unsigned long shift = __ffs(1UL << order);
de4ba360c3e4ed John Garry            2021-07-14  377  
de4ba360c3e4ed John Garry            2021-07-14  378  		iova_len = max_opt_dma_size >> shift;
de4ba360c3e4ed John Garry            2021-07-14  379  		iova_len = roundup_pow_of_two(iova_len);
de4ba360c3e4ed John Garry            2021-07-14  380  	}
de4ba360c3e4ed John Garry            2021-07-14  381  
de4ba360c3e4ed John Garry            2021-07-14  382  	init_iova_domain(iovad, 1UL << order, base_pfn, iova_len);
2da274cdf998a1 Zhen Lei              2018-09-20  383  
82c3cefb9f1652 Lu Baolu              2021-02-25 @384  	if (!cookie->fq_domain && (!dev || !dev_is_untrusted(dev)) &&
                                                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


a250c23f15c21c Robin Murphy          2021-04-01  385  	    domain->ops->flush_iotlb_all && !iommu_get_dma_strict(domain)) {
b34e9b0de3c411 Tom Murphy            2020-09-10  386  		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
2a2b8eaa5b2566 Tom Murphy            2020-11-24  387  					  iommu_dma_entry_dtor))
b34e9b0de3c411 Tom Murphy            2020-09-10  388  			pr_warn("iova flush queue initialization failed\n");
b34e9b0de3c411 Tom Murphy            2020-09-10  389  		else
2da274cdf998a1 Zhen Lei              2018-09-20  390  			cookie->fq_domain = domain;
2da274cdf998a1 Zhen Lei              2018-09-20  391  	}
2da274cdf998a1 Zhen Lei              2018-09-20  392  
7c1b058c8b5a31 Robin Murphy          2017-03-16  393  	if (!dev)
                                                            ^^^^
Old code has checks for NULL

0db2e5d18f76a6 Robin Murphy          2015-10-01  394  		return 0;
7c1b058c8b5a31 Robin Murphy          2017-03-16  395  
7c1b058c8b5a31 Robin Murphy          2017-03-16  396  	return iova_reserve_iommu_regions(dev, domain);
0db2e5d18f76a6 Robin Murphy          2015-10-01  397  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

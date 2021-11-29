Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F222C433F5
	for <iommu@archiver.kernel.org>; Mon, 29 Nov 2021 08:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1183B80F1A;
	Mon, 29 Nov 2021 08:30:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lOVXEBqbJJuM; Mon, 29 Nov 2021 08:30:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CD46A80F16;
	Mon, 29 Nov 2021 08:30:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B41DC001C;
	Mon, 29 Nov 2021 08:30:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EF9EC000A
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 08:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8E1240125
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 08:30:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="FjS+1x0S";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="FrPPBSrv"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4GoVorOpMOpD for <iommu@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 08:30:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80F93400A6
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 08:30:10 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AT8Fgkb025582; 
 Mon, 29 Nov 2021 08:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=L4Rr4dlLKDxDgnH23D46HBYlsK9pr+kphq4kv0KGEg0=;
 b=FjS+1x0SJbU8gZ+0MrOYcoCEQtWleecK2tFiIHg4zt+NCeJlKccRV2GnZdkx9ZmNTevg
 sfpUS6OAewvJ/RF8IJEA5j7+l8qnmLlmlOE0OGHMnLreuhUpEE179+bQ6qulF22JI2aV
 LK9majtWKuKwREt4XL3RdNjPfuW5qLg0TqiRVgpwirKcfl/VZy/9zKyPdFop4CIq/WfY
 mxv9+D3L9K2mqabknXWWfJNcoM49EdiGvGDgwurfN6M/HvT9Rv0JHrhn6Ofy0003IPyc
 57xoqjK1n7EkUZwurI7CQwMYBBfE1Da96Zdc00BWhQfp3IZZIa6PyDoEpCJPPWojGv1i kQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ckd7u4xyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Nov 2021 08:30:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AT8PYhg117721;
 Mon, 29 Nov 2021 08:30:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by aserp3030.oracle.com with ESMTP id 3ckaqcdjxn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Nov 2021 08:30:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0b7u8rocGx+poJWMJOuxhvkbiPHT1GLou4FkOXZpILReJrZph6UpKi9cKbuFDe7LK4gUMMzmnAxmggn0jatd8OADXaKlwF4Vc8ZqAE/xBrg2DcgsBkpl6KNcNe46pC1dUCIzTp+O1nn+b2neIzHXxdHX9Mw3RKrYN6tzCPXFOylYm1dyMJfQbSjQrlWZMrnDuUbNpdUasB6qCgbQAArB+rhIx7n/QfXDJgdy1oVGMLC5NZPNHfCgluj1m0OLZoiIwv1RmzcM9VIcsy57oQ2Sg2YpN3nLalqJL+jzQM+zkULxrQrxdYUD3DRknoeaEYTGIiLFwv0NmBhWLwHowKmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4Rr4dlLKDxDgnH23D46HBYlsK9pr+kphq4kv0KGEg0=;
 b=jNmhtex7XyuP8pa0kRqs7pKamfAgCnpHpq6f3nlangM6cg7AUV2rVdM56+fI850hVMbWfrYjpAsBivSPv5OLubBBgECZML1tLT66QbmOPaV0+oIT4r/j1ZLmwAVIFPDiIy8HsJdhuz+MM+Gf7cjkmjPT//Ej/fHWy2cDXYWvSm0smfUo1Tlt9ZbamXKLyiCyLfH0NWX4eMkJXLGtf9Kpw+30ZaTA+mbYjTJWjLp4J3rMLaPB5vuvH3svcc2vwSLDiNLXUWoXPAniLpUr+CsgOv9vpIP9fOecmxtJXnJ7UIHAqaXbCa7qY/q3d15b4pOrE7tMnhi5VmOskdqEoau6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4Rr4dlLKDxDgnH23D46HBYlsK9pr+kphq4kv0KGEg0=;
 b=FrPPBSrvvkz56NbUGBR8L+DI/e0N5c4JfdKPr4IusGOsx4kye7//7rQCswa94AUx+l5XLdZlza7N6riSD9vy2QJp9W5dLrmgDuW92bsezaH+fdIKxoZbiXOIGsfZi+Sk+SQSB718yLPiZJg2yTzZgNHTcG28ouy8um3oQJPDZp0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1663.namprd10.prod.outlook.com
 (2603:10b6:301:7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 08:30:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 08:30:05 +0000
Date: Mon, 29 Nov 2021 11:29:48 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: alex.williamson@redhat.com
Subject: [bug report] iommu/vt-d: Fix unmap_pages support
Message-ID: <20211129082948.GA29816@kili>
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0072.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0072.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Mon, 29 Nov 2021 08:30:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe38d796-f532-42f0-c80c-08d9b31271f9
X-MS-TrafficTypeDiagnostic: MWHPR10MB1663:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1663B7DA98F7B3B2668499B18E669@MWHPR10MB1663.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c2rxgAEz7gq/+jsT/liR++GqaT3KIohgiJgENcvVxzILDdSXKJ3r+jLY5p2cl25Ly/BD0K3+fkXGOWeY+1ABTAOcxYVaoLKi/dDudpvr/C0NWIakfwDZ5DV5zogRID5nybwptdPP8qcgyqIjuqbK9MlQJpnBc7xE/ZDtB1InvvMh6OnRPsnXWVVkUfg2vR4xHUmFSNIf4qOSFTU4fXJfOZX52QuI1vRhO6RZUtwKllHGv4B5bvSAPkyNeBOaoJQ8pef9+uXdrVVT7kgNbzCvgkuIaGnEFaOuoH2nAsZkdp3b4b1a3gOpYynqbXtGE/uhC4qt0HLmcwbEiRpE6CvhS/UzYKDHdPI7E3Tbh3i6gI4mbu9TSsF/uIdrZj8M30MuqeR/lgb7hK7CG/cI9EdgHLeSoahLPW2fUWFAOTpLU58V/lMtmxgS/+0IzfW70hDk6bibjxn21j05nvaA0Fz+TwU1HrzG3HrpB3ujZVtU3nNaUcfR0OeABPtdnNijg2Tvez/hUabG+cyVNI/L3RXtPcGBGldlt1Yev6QErg9g9ZAn8GoyXtIKv3z7ORL7XKbs2f0Zxj3XBgf0xBybfUVLKHrlGz7u9JCnw+E7SeDlwBv3QdtzyjkBQcLmhXz0fY4VrRBsGDqNeF5tO1qchCu5LFR8/qHi/f/EkyH/dHsw5vhuqTXic0p4OPQtbJ+Wr5rlIfX/7ldMe/lpoH6OCG5vCMx3WPz6UAAi4+t+oXnSl/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(83380400001)(26005)(316002)(55016003)(44832011)(2906002)(186003)(6666004)(66556008)(33716001)(38350700002)(1076003)(66476007)(8676002)(508600001)(33656002)(6916009)(66946007)(52116002)(4326008)(8936002)(6496006)(5660300002)(956004)(38100700002)(9576002)(9686003)(86362001)(134034003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EKx/j9w3XXTgTcrkwsp9Bcw5uul9F1cN48FrLKDYQFDq8DPa4UsrTg90aBJP?=
 =?us-ascii?Q?f8L5OkBm1HQiKDtCGn6Csy0CIzrvvEDQCIJA9evd7VmEGfj8P/DNQqdzI4Nr?=
 =?us-ascii?Q?tWw7LKFvJnnoUZ5kchpGUZq70gN9cjgF/ay/+b9iEZAwGbpovXHXKHrIq3tR?=
 =?us-ascii?Q?47wW7wNKXXf2DEzBrmGtoWpdtqMhPx+Qz0XUGdTgTPHiutsX2z2autY78PVn?=
 =?us-ascii?Q?O9KAzWUxSSCrNKqZBq3FDFTAU6fP1BotSwgW2YC9lS4ejNTgkHmumJfucGur?=
 =?us-ascii?Q?aA/cF9ZoEQBubWNitU6AO2H3jsgIYMjQDdbOlPKjXbiIiqaCZOE/QFB9jhAh?=
 =?us-ascii?Q?eCuWr10Gclh9Hy5O9OG7XlKoRFXDTCOlPZbZBZkqFwTkGaOAB5c6QacRyGu5?=
 =?us-ascii?Q?1x3dI6jaZ/RDSaMwOJvmIveWeLMT2y9eUWAIHM1OEHZBi2idZuAvGAs3uNz3?=
 =?us-ascii?Q?AzEpQkeNX17oThEmtMHHVEJ0Azl4GIB5n+HmpHFLeovh50s8Kg3bDm44lQtl?=
 =?us-ascii?Q?3I5oKACCCLdf3PefMyTiq+UPGPJTdRlE/riDFZbYPjRtKfD4D1uh8v8vwQtl?=
 =?us-ascii?Q?ZocwrRTR0X6Nw7LmMbvXmbSugVrBD7N0LWuUBmkuq30PUOAiQytS9CMBC0vb?=
 =?us-ascii?Q?HRiMjkNhFYKbrO1nWyeosxgzmNbT3lH/Je4N0TlGctAXGfj/aLz6CIkIpuri?=
 =?us-ascii?Q?HStCkYERFXOzXMwr7tj6vzjEg/oXBnJIO5mJy+rSe9ErPHwmvJjgBpIEQ5Fh?=
 =?us-ascii?Q?IW20d6lcN/fqltGzspMdOgx+FT1AlTQUrBMfa/FgdKvxQ1NKsP6YyBnWN6hu?=
 =?us-ascii?Q?k2vry0rwn3h1RIl9iZQwde64I978tVNdVSOlMFxajwQv7+wc3P0dW8k53o8G?=
 =?us-ascii?Q?hFafX1fC+/vbAn+iUDF/ypyFTg+nThHNpKV2S2sJwNIiiPXyfM9s0aniKIqg?=
 =?us-ascii?Q?f7HizwO/x7x5FQELKfikkRLlfkAWRPTmqDYK56Id1GUnRvskkQUIlDXa/pNb?=
 =?us-ascii?Q?EZ/aj+9TLCacqKIKlPWQZZphgmKGkKnK+bzNEblEwsWD2wlx2uqLmwlZH+ya?=
 =?us-ascii?Q?GTdCtNa1wKQuEoF0gHOnL1207VEBUYis5wcOM6CKr3lCt4n8E7hRGCeOoOXx?=
 =?us-ascii?Q?rxQLolbx9mCCb7YWjGEgjsa9KGBzIjcOhyWr1jdGV/7b6uVIJcsqvptf7sUs?=
 =?us-ascii?Q?iTk0k+ZrmXb2OlSH5AUXg7lvyUShOkFfpXbqOSPo+DGCflGSXK/mvDqsfNyk?=
 =?us-ascii?Q?XEdGFlYjNPIdLrLManzYaNxSe7vmnVD6cinQCk1GruW+UwzzXa2UJ3cgD0Wb?=
 =?us-ascii?Q?IkQjOsnW8tZhgVv+YcV8GezCEMDlph49mV9aeb9qnQKTnkhffcIOcuTyKLAL?=
 =?us-ascii?Q?V8cL1Uxzj8Y76y6yTFIVyg2oqPe3Oy2ot4dmnUowrEFVXnaPVTT1023dH17J?=
 =?us-ascii?Q?IbVtwNa0DieRklCJ8zvLtKIpoB49iEmVqwmTagwOcZisqLtJ6rM97ztR8jgU?=
 =?us-ascii?Q?/lH+e6K+FoKdDgD4FH5ETSMIwyX9i8lqI2bOTrpJeglERrhuH3MmKJpem1pN?=
 =?us-ascii?Q?TkHIdTE8dwYMz8Cl/DYPOimhuxANSHCwA5QIPnxk+iTsTTXPKwR3MEwOKBdV?=
 =?us-ascii?Q?HAqBqZXZAKbfupTlm2dBnZIvEC6CmMrfES37WarNrFva4Mm+LI7yw8glSnGG?=
 =?us-ascii?Q?LQ4OzA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe38d796-f532-42f0-c80c-08d9b31271f9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 08:30:05.4223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXMsHCXXTxiF4VmrV4wfXsUCLP3k6rgUtK/nIuFup/iYrYH2WPvpmoiPU0fbNyPTN95Ll0wnI1qLodWLsKZrncp+19DItrpLLZqx1hgc3qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1663
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10182
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=941 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290041
X-Proofpoint-ORIG-GUID: GOEdM9gQSoWIyOzlQlLWDtscbLpdm_6w
X-Proofpoint-GUID: GOEdM9gQSoWIyOzlQlLWDtscbLpdm_6w
Cc: iommu@lists.linux-foundation.org
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

Hello Alex Williamson,

The patch edad96db58d2: "iommu/vt-d: Fix unmap_pages support" from
Nov 22, 2021, leads to the following Smatch static checker warning:

	drivers/iommu/intel/iommu.c:1369 dma_pte_clear_level()
	error: uninitialized symbol 'level_pfn'.

drivers/iommu/intel/iommu.c
    1330 static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
    1331                                         struct dma_pte *pte, unsigned long pfn,
    1332                                         unsigned long start_pfn,
    1333                                         unsigned long last_pfn,
    1334                                         struct page *freelist)
    1335 {
    1336         struct dma_pte *first_pte = NULL, *last_pte = NULL;
    1337 
    1338         pfn = max(start_pfn, pfn);
    1339         pte = &pte[pfn_level_offset(pfn, level)];
    1340 
    1341         do {
    1342                 unsigned long level_pfn;
    1343 
    1344                 if (!dma_pte_present(pte))
    1345                         goto next;
                                 ^^^^^^^^^^

If we ever hit this goto then there is going to be a bug.

    1346 
    1347                 level_pfn = pfn & level_mask(level);
    1348 
    1349                 /* If range covers entire pagetable, free it */
    1350                 if (start_pfn <= level_pfn &&
    1351                     last_pfn >= level_pfn + level_size(level) - 1) {
    1352                         /* These suborbinate page tables are going away entirely. Don't
    1353                            bother to clear them; we're just going to *free* them. */
    1354                         if (level > 1 && !dma_pte_superpage(pte))
    1355                                 freelist = dma_pte_list_pagetables(domain, level - 1, pte, freelist);
    1356 
    1357                         dma_clear_pte(pte);
    1358                         if (!first_pte)
    1359                                 first_pte = pte;
    1360                         last_pte = pte;
    1361                 } else if (level > 1) {
    1362                         /* Recurse down into a level that isn't *entirely* obsolete */
    1363                         freelist = dma_pte_clear_level(domain, level - 1,
    1364                                                        phys_to_virt(dma_pte_addr(pte)),
    1365                                                        level_pfn, start_pfn, last_pfn,
    1366                                                        freelist);
    1367                 }
    1368 next:
--> 1369                 pfn = level_pfn + level_size(level);
                               ^^^^^^^^^

    1370         } while (!first_pte_in_page(++pte) && pfn <= last_pfn);
    1371 
    1372         if (first_pte)
    1373                 domain_flush_cache(domain, first_pte,
    1374                                    (void *)++last_pte - (void *)first_pte);
    1375 
    1376         return freelist;
    1377 }

regards,
dan carpenter
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

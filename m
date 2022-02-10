Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9ABC433F5
	for <iommu@archiver.kernel.org>; Thu, 10 Feb 2022 01:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E6088138F;
	Thu, 10 Feb 2022 01:00:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iBDdvka1jsNi; Thu, 10 Feb 2022 01:00:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8650580B92;
	Thu, 10 Feb 2022 01:00:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C6B4C001A;
	Thu, 10 Feb 2022 01:00:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 391C6C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 01:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1510B40538
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 01:00:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="fl6oqKxr";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="S6GgOyLZ"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZXzmYsJpGk44 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 01:00:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D85E640004
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 01:00:03 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21A0mELS013346; 
 Thu, 10 Feb 2022 00:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=8NcWbSL/M/gsSAjsKrZIYky/PpnIQg646KxvEw2mUJY=;
 b=fl6oqKxrcbFA9FJKQCFMFPaS/aw9cvYDdKBgeZ3JvLl6LdGHyFXlu4JovATXQWbO1b99
 WzuojlT4iA0NRYt4WYT3fuCqelWaGYrvtNB7RuYl+sRbQqVOdb7mQOr01hqYgJv3cdGt
 chHR2CFde0fANj63/452fa+aKYz3qLhj815/1mIcHJL38Y8vEnxJGAXaQWATPLLmTa5q
 k4OJLOGRtgOHl+EGWtUleDJJgspW1rLM4f0GtFWdVyC4uf9V2GGKmJQ+fGQ6CiLLVQmT
 0bIAL3qnplffqgQTWca9egB4D+bEqJ78a3wLfMIWH/ojJYrrtRK3vq2j/8ZONK2XJHA3 nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3e368tyec0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Feb 2022 00:59:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21A0to2h159657;
 Thu, 10 Feb 2022 00:59:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by userp3020.oracle.com with ESMTP id 3e1jpu30dn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Feb 2022 00:59:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGx1XdWPnVeZz/jTF3e0b4j3uVtfoZG0gPlFibz+whXX7U6kCCqhlyvYHqRHleghxlYYcyKoIYbz+YT5sQ01EPHJqDgXDey3altkdml5+nUMcU5hz6nImCmRCoI/13GiQT3ViSlONi2CJOibY131ixkOCZRNQisGGHyRr22ALNex+UMafOEuB9w6VDmsITa38b+5alFQkfiAgw86LitIPPVn9N1xa4zaS3P5gMbq8O7k5UWn2rYt+7nfLx/tzyChRLPcXwoeOQPqJ5iQtD95634kmnfFwRERgGprHSd45OBltgzqGk+daUks05sEUX+AfOivJBPKHAN5wzFg/8ffQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NcWbSL/M/gsSAjsKrZIYky/PpnIQg646KxvEw2mUJY=;
 b=GQbrgwjXJW5ndFsiEWqudwuwTn2Iw59gtsdSKcCGMPAqWNh2N2+noaf9F2DSngYGuK/iYb4i9joepq9kLSpi/7VSxYcfL49GWtJATp+OsueAPgAyFJGo6XYUId2jEfIf4dWjYbSTInTEwiQqTbpJuXB1yl8CZVCLXQ+qnwWKIMMyjb2MqXdj/1jGF9rITsNMXpWvL+Cur/ciWd3Wtpa6VXplHuMTn9YgPicXMHl0nJFWG1ZJxnjcA3oCFw/oPXoi4DxDDLfbfRXv6Iw0wuFk756gCio/6/I56BIkLGPqTlO2q3cRkb6U3nO/JTOz8PMPAWd/cCaxit8ammxW9j+Mig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NcWbSL/M/gsSAjsKrZIYky/PpnIQg646KxvEw2mUJY=;
 b=S6GgOyLZ1vws628TZz9NIBmGzqooTovORLY2tRZkeWDHyJwnIb7mBrFcASyxZo6Qwimp8cx/b685Zy22baOzu7RfpymGX4R2hHxicf4tgDImFeXsUUirLg3zepm5QsCLReKFv9o1TzLK9yRiZ2FqBwPkorvZHe3Zee1RIeXDpEY=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by BYAPR10MB3030.namprd10.prod.outlook.com (2603:10b6:a03:92::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 00:59:52 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c4e6:3a75:dd85:1912]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c4e6:3a75:dd85:1912%4]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 00:59:52 +0000
Date: Wed, 9 Feb 2022 19:59:48 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: iommu/amd: bug report: page table memory leak
Message-ID: <20220210005948.cpfij2teecka7v7w@oracle.com>
References: <20220118194720.urjgi73b7c3tq2o6@oracle.com>
 <02aa873f-ad42-f310-a3ae-453a95ba8063@amd.com>
Content-Disposition: inline
In-Reply-To: <02aa873f-ad42-f310-a3ae-453a95ba8063@amd.com>
X-ClientProxiedBy: MN2PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:23a::17) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf7cdaa8-e059-4f3e-a17a-08d9ec30a528
X-MS-TrafficTypeDiagnostic: BYAPR10MB3030:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3030D456421C3E7CAA2CFDE5D92F9@BYAPR10MB3030.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DvFoN7/m2VO+mKHSXBdNnpSQCgo9HAs39WBPBJ3Pk8OnlYEGmO5sepTeoYNH+DezBwW7JFph9bALiK0tEaLI1MDtrynl1lToHSe89QlcgM/9g6vBvZElkoM368Uin0gHa2D0t3IvTOMIcOQ8jmX60RJPb2gvuhJmT87vUs84mT0F+0dE3w0aTU0F/5OEMDzYbm0j8mkVOtcA7FGSLb+Mbd81oLwlcWMSTuTKnckC62kbROAO6idrmOzkY3aayBIKhpodvKQ/oNsMlfnqDeSpb85GyxvXK7OItMz/2PpWCNxECvxGQxcSskF2vnQD6v3572OZ1ouQW5E9C/hJYnik7KTGcv3mk2mkGVng4lFpZJcrejBXdDBOjwX6q5mPvBsjyeZcma3sgwMZYEqPhCVmPlEJCYbwqtRyQ/0Div8VyiVMCYz3AUypQSg8NV/eNgHNCRe5yeAB/GIipWb6yAOxuYVD+0RcaXHmRW6M+TFWjLZlicJ9eEJrP9BP7WvbH9lVjttAMzGG5Hq/wkS7NAx2E1iW88UaS49m7gG5ZdtTU/IhJ2RjtQNNAOwByzRKaA2ZCFL+KNvHmyxXV2MDmUZfjRP/hLcpvRFFZGmudn6poGtrlNXDgVj6/k8AZVYu/vwaW50yepFJiU3PrxIF1rpXsqHPOaWDd5tO3RebdFHgeCVcxpRmv7lw1HbL5C4MzBGCqY2NlYHsrIpNF1Iq7vn4gA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB5711.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(5660300002)(2906002)(38100700002)(38350700002)(36756003)(66946007)(83380400001)(66556008)(316002)(508600001)(52116002)(66476007)(4326008)(2616005)(26005)(186003)(6916009)(8676002)(86362001)(6486002)(6512007)(6666004)(1076003)(8936002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SMxhady3aq25N8n5SjyxHh1jLULDATDdgv/MQn/XbtqlIEPsO6IQ6jEMqHaF?=
 =?us-ascii?Q?DN4BG+FKM2EtrMxnTP1f9oQG/MADfDe1Y5MeuCK8M3zvL0WcW0Q/1IKRA/91?=
 =?us-ascii?Q?39Pe9gLSIMGq29MmMy7zHV45a3uXvo5RJ30kofIQrXw3/H2xmPXuswYYy81F?=
 =?us-ascii?Q?nx4olqO9LPdreeWmP02oHL2PRbpwE/HUgPaDSGaEHVR0BGbHoStlQKo96x2g?=
 =?us-ascii?Q?m0fvDit/zZVXmPRMZjPdejPP/UtkIlin4rWBRm/6nhoOMf4YZm8h3COFIWRs?=
 =?us-ascii?Q?u4ZTg86xsl3cZymVSX05yDTjibQ0JeTa9jvkSehVgZOKQR8EW3jhRqkpnBFv?=
 =?us-ascii?Q?kBL1Hh+BgLG3OBd6q9HFMu1iW1KqHY4zut6WW22zpLkbDxUvs4zdhGeeSxi6?=
 =?us-ascii?Q?md0zKI+0CFOEe/5uzHPZLAtL0wN9uicMSyXxlAYG1I/KGmi7ioMk37e30VPi?=
 =?us-ascii?Q?g1KgCtdvFCLRvI3pI/aRzSiR5Ytr0/eHuOXxRwqYhsENDhrvMbvfcCpm1PR4?=
 =?us-ascii?Q?5dUHCbjo+IiNPi/isSjFJdOJcPdcacK3BR+wr4uqRvzUkhVDZZAZaGiSgdT9?=
 =?us-ascii?Q?RyDx5rUWTJhiRcG1otjkyMVhoQX37c6OfbI0YIFGP1R0XFjClrJH11D45cWr?=
 =?us-ascii?Q?QmSricxVj9ykTjngDA3fEVHPQcrlNOK1+X3pBt92EshWhPeuzfMttnw/AI7Y?=
 =?us-ascii?Q?M03PZ9yKJZWPAlwygbxK2/8XA06RrgC/hROhZMJUW7mPoi+MwIbEcDBXYcZT?=
 =?us-ascii?Q?XfPg8VKK0UxW4sDnXoGDeOrneUHhDoTKbNoqKJikguGj2tHFCWt5yWaBZD1m?=
 =?us-ascii?Q?Y9nMV+ppp7ptwTx4gH54zuJqgTMS5diX+2ICcnAiUTq/8nPkXcWPKavfSLlI?=
 =?us-ascii?Q?BPGlgwXjpefM3e917PYFcyF7A3Bz7GyyYMUzhFi1JbIOXNRMMdAyOZ2PikXj?=
 =?us-ascii?Q?OJKgi3UuEFyXL+pl1PNcPQBu7oMkr/sqZcV7oPdJzqEg6E7Y875kdkgstQ0K?=
 =?us-ascii?Q?iI5//HT4CUURr/ByVIFTp0+5umhw1hYvjSQjih3axSDJD+fKBCT+6o7J7kUd?=
 =?us-ascii?Q?Kntd7OhwqFfcUzwpIovYLocQVTcyG76rmMLQRCKTLiBCF5ZYN+K7HT0ZQWgG?=
 =?us-ascii?Q?vLypIMyl08Y8gL/Ipo/tgS9HT61lggo6ZWVuNkNjsGftEtI0uPH9ueA1pj2s?=
 =?us-ascii?Q?Aeq6i6Ry+NWSKMXMXWfEpjGzQhLMxNk+M9QJjNT/oCrtn0GqRkIjLu1mQdsW?=
 =?us-ascii?Q?5zLKUVktRHBn6945Pg9aKBBb4aDsu9Nn44M2tQxQ7Hr5ursdnKqoSF/bpPAW?=
 =?us-ascii?Q?ElLwDGdlzCKuORnbZKdTozg2G6XJGqkwvQCA318HaGnvg3zlvLtLLVuv7XCm?=
 =?us-ascii?Q?Ad/m9uoz8kighDZmUmKPldajpBKOWcHQ3NQvPN42Xo9QN6RG03X9JWU3z9u0?=
 =?us-ascii?Q?7Gcsw7VnsiyAaFiDjppy2fjjBhpnf69CgaBEb6A9gYgSotl0wvPldsRNgR9j?=
 =?us-ascii?Q?osLvLqiUcZEWw04eZOztpi5XoUUwec0ZBSAtKEz62YK6nn90bSP3k0+7/yvM?=
 =?us-ascii?Q?+ff2/oXUKyDdhHxSuNfenuQp36zyChnO3O0iETouIJiRPn5Zbbv76YZO5gip?=
 =?us-ascii?Q?2D9dlN8Jc2Vi+UFNkqs/FoNTOjR4tJ43HtdNT+3izmN5AjRxBqNXKLU7es1c?=
 =?us-ascii?Q?xAGiew=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7cdaa8-e059-4f3e-a17a-08d9ec30a528
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 00:59:52.4686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThZTeF8cw8+yfAAIHW9sqLzSvRyNF9WqLtfQ8YYSI3x5pwCcezl/7AOAn9/0E1vKaGekdq5wzi73jBSLwJprY5IEER4o6TRIfS7BPlI2SXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3030
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253
 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100003
X-Proofpoint-ORIG-GUID: xxd0umIyXRsKBtlbsjXD09Cxgzxq5FaL
X-Proofpoint-GUID: xxd0umIyXRsKBtlbsjXD09Cxgzxq5FaL
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

Hello Suravee,

On Wed, Feb 09, 2022 at 12:04:40AM +0700, Suthikulpanit, Suravee wrote:
> Could you please try the following change to see if this fix the problem?
> 
> diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
> index 182c93a43efd..1eddf557636d 100644
> --- a/drivers/iommu/amd/io_pgtable.c
> +++ b/drivers/iommu/amd/io_pgtable.c
> @@ -519,12 +519,6 @@ static void v1_free_pgtable(struct io_pgtable *iop)
> 
>         dom = container_of(pgtable, struct protection_domain, iop);
> 
> -       /* Update data structure */
> -       amd_iommu_domain_clr_pt_root(dom);
> -
> -       /* Make changes visible to IOMMUs */
> -       amd_iommu_domain_update(dom);
> -
>         /* Page-table is not visible to IOMMU anymore, so free it */
>         BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
>                pgtable->mode > PAGE_MODE_6_LEVEL);
> @@ -532,6 +526,12 @@ static void v1_free_pgtable(struct io_pgtable *iop)
>         root = (unsigned long)pgtable->root;
>         freelist = free_sub_pt(root, pgtable->mode, freelist);
> 
> +       /* Update data structure */
> +       amd_iommu_domain_clr_pt_root(dom);
> +
> +       /* Make changes visible to IOMMUs */
> +       amd_iommu_domain_update(dom);
> +
>         free_page_list(freelist);
>  }

Thanks!  That fixes the leak.  Feel free to add

Reported-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Tested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

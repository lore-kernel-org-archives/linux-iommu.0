Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E624C433E0
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 21:28:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0267864F1F
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 21:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0267864F1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 91AD1433EF;
	Fri, 26 Feb 2021 21:28:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R1naoqDGx1KY; Fri, 26 Feb 2021 21:28:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4D598431C4;
	Fri, 26 Feb 2021 21:28:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31F2BC000A;
	Fri, 26 Feb 2021 21:28:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17F05C0001
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 21:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2F766F49A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 21:28:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="wApbOvVx";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="S8llkL9K"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F_swkwGIfnn2 for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 21:28:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 46B066EA49
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 21:28:38 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QLOu5H189405;
 Fri, 26 Feb 2021 21:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=6wH/v0TsDawCPAuYamoL+o8wFUrfmwzOr7x0EXkvoec=;
 b=wApbOvVxCxbtH55eNnb4Dgq3uXfvZRpd5apkL5ZhGna/q+muGmxfo3x5WVTkSzik/wDX
 9PQEby3JeFLcXtkzSdspH4WqQ/C/EAizqQOMOMlPKEJX9FPSa0EbGlShKrwuIJlAM3Ri
 k6rEBwZ7JdM0SxlAt8IKNV7HvhQ7vZh3l56AMB50P+e7/0QJNMZT7zgv0f/wsjAG4w6g
 s3RAD9VWHXQpbM+0hojZtypLbuMzFdRdICZ03G3LejmecCSS3qks1udcbWBwsPgu45uR
 wxtMYgpoE4ktD04D4z8YGuI5GDIaa8DIThZYWFmMQWht5iddhmB2Bk3t/CK7YvKx9a8v Hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 36xqkfavy8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Feb 2021 21:28:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QLKfjO064028;
 Fri, 26 Feb 2021 21:28:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
 by userp3030.oracle.com with ESMTP id 36ucc34d0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Feb 2021 21:28:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es5hjVBhuqTACTy9sWjFSSeOrDwADz5DhTD/FSjmkdE34Y29hkDWTD9VTkWwgY8zX0niTG75MTRNWKBa527EGqqOufcAOsTuJt996JwHerbvx6hJ6QB2iV8bH5vg7lQZYSErxZhb8xOor+hhvyGzSkbWPg6gcOC3uXNmDKXQqzr8D7l/bKNVYpbgxJNccvlfKexUoAIAK5Z17lZckpwWvwRFGuD459IfYBeG/MDkwom/XTAXi+8A1MeNnZUUNThP4diBZdQjx4bJcNsrl2cJq6NSW2w0oTIJCuCczBECTEgOJPWTnpPUUCAi5G5MWrlwj9Uepffa2t9A6t+OCZqn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wH/v0TsDawCPAuYamoL+o8wFUrfmwzOr7x0EXkvoec=;
 b=Atng1ENZtUi4qpxQL0L3x+1K9mfsFlOwCjoS9k0ZAZWE8x3+wfHyag8waA1C0xVK1lN7CDMvwwHuf6ChKOOyyP0UNbjbqE5ltGegr0wtm8kHSwmdu3uuJKy8RM17vow5miy1++0zyAyIXJdrNHtzhZyD1ePaGS0i8PFimdXLVWvsepkjRTph+Rwdrfjl8n0fjCy/hdoI097P+BRVTXVrlni0aH45VY6Bch0pqgcgJQCgDbSdo8F7pWSNEPm/c5NQqm9oXbS/yP9PeYWqJ+WRQOD+kSYrHJsarE7uW9ewETJGVh2S9JHOJOdx19CPgrn0Thb1Xnsj3vAk7tc+y/yhpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wH/v0TsDawCPAuYamoL+o8wFUrfmwzOr7x0EXkvoec=;
 b=S8llkL9Kf3I8sbL51RAmvSvRkLtvWWSqW/9YEqE3eg98+kT1JrgYw2VnahgsX7JHo2fondqRoDFxNXkJx0d//kgwXghs+Kh8a1MeNVSw83zB3C6GshpPX8mEd8AvnRlfIVLf6x2KqqCnwIcn3Z5lD7vfZanPf/1i9L9hOlWNNXc=
Authentication-Results: pensando.io; dkim=none (message not signed)
 header.d=none;pensando.io; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SJ0PR10MB4685.namprd10.prod.outlook.com (2603:10b6:a03:2df::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Fri, 26 Feb
 2021 21:28:31 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 21:28:31 +0000
Date: Fri, 26 Feb 2021 16:28:27 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Brad Larson <brad@pensando.io>
Subject: Re: [PATCH] swiotlb: swiotlb_tbl_map_single() kernel BUG in
 iommu-helper.h:30
Message-ID: <YDln+34XyqE22puQ@Konrads-MacBook-Pro.local>
References: <20210226204307.50413-1-brad@pensando.io>
 <YDlhZDgsAZ2j0b1z@Konrads-MacBook-Pro.local>
 <CAK9rFnytTUHFHMshini8Pngfw2tGxuVhtNj2bmqeosOr_ZpQGQ@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAK9rFnytTUHFHMshini8Pngfw2tGxuVhtNj2bmqeosOr_ZpQGQ@mail.gmail.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: SJ0PR13CA0218.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::13) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (209.6.208.110) by
 SJ0PR13CA0218.namprd13.prod.outlook.com (2603:10b6:a03:2c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend
 Transport; Fri, 26 Feb 2021 21:28:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76429678-3516-46e0-b928-08d8da9d76b0
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4685:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4685B11C6151AEB938DE5F6C899D9@SJ0PR10MB4685.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AItLCxWOV1NhYAHiilRgHBAgwPamXfPiQEnDUyp/jFS7h8sVGrlZahaimajzc8Dt6KFQiBvplThMBCQOCZdwEmLWBO26yzDW9dZp4qMApg35s8u03fJXf3U3K6Ue9+X3RKEJiOHy/eK6zGQPgcjmY9+2jfspzMRDcmqrBhcIipf7nNqiYV1nPJAXju/VcjX+Sk7uwc32KcXgFXq1Wn4RN92HJaEqk/gmVJusIUN/vIF2ut94eVK44Fpg1Ubq3krGT5FKOTJTlSdwjUOqOs55S38zo2QrhY+Z1o3V43H9ITN2znN7UEefDPxwPxO1IkKysQAw/naYgjpm8MQMKAhmgg6vJUASIcz+OLdam/NCPgK554zH0gNFlnWSK+pi8J03tSd23Cpx+/16DqGAneIgUxRQof5oiGm27MvfFQSICAg9nwINCfwXf2fV71zxM8gjN3edPyRzF6btqE+7of6HKrRW3jKQq/Pz8S/so6wLKhrOrXekIL8mj6e4fO5gcTD4vpoaabwRIXRq1o9WKRSglvnXfWibaXiOL8daPMwFPuRSQEWlBEOkTR+T0quPYSAV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2999.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(366004)(346002)(376002)(396003)(136003)(52116002)(6506007)(7696005)(9686003)(316002)(8676002)(6916009)(66476007)(478600001)(86362001)(66556008)(4326008)(6666004)(66946007)(16526019)(186003)(26005)(83380400001)(956004)(55016002)(2906002)(8936002)(5660300002)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5Yvid08U26mjST6QxxefmDSC276wVpzOHE1PLlocqf7I5crlup81qWYsip/o?=
 =?us-ascii?Q?SozGA+/zVd5lhtfztPHbo/Aa3kDMpdV2XbTU2QOJ2pq5iUY1NK8iGbfj3z+Z?=
 =?us-ascii?Q?2hqd/9iySeHt4FC+7/U2jwrYp0tAjnTN2AFQsjkiokBYDK9aXq7KL9S7LVI/?=
 =?us-ascii?Q?lMtgfCBldVZnMoUJ74ayANGCnAKVXtgeOETAxlqtQTBIqXWGxNC9Ol0J3xQu?=
 =?us-ascii?Q?bqz02YzLlL10flDy1jMIzJ8ICVKMmwxKXnqHwe6Nzpj5SC/fKNLlry1XGMfX?=
 =?us-ascii?Q?rc7ar/XEgdy1OTr0OpOz9f7Qdt/1uux9ABkGPPqA1pYFgPACiVnU19fuPv42?=
 =?us-ascii?Q?FMtmUlKpTtXE0NHY/ywqZ0erwup3XtuR/QaxurK4iuVmUdDpH+oPcYTX56LJ?=
 =?us-ascii?Q?QeKhUav14WH9TbQBoWJotl8PnDaEhFT0T/h8ImQ+w+XGXSus4i6DDpq2CWrc?=
 =?us-ascii?Q?CBDel/FdmrPROKk95uHl0+DXMZMHc65yRP/oomNnlahtnULrJS5oSArNdvPr?=
 =?us-ascii?Q?troGWtfTIOgMySuLBWr5TZGk5mFtqBByueW+SOONAT2WfMVRDD7o1CpV/Xo6?=
 =?us-ascii?Q?JQLM5o3/dQi2StUenMFo+7SEIb4BN4CikfDf8ZuLIc+gRxhQyBNZ8AnZUzS9?=
 =?us-ascii?Q?sYiZmx/Uw3Au2q1QcY9IAg/L+BeWhQyWVq5Me18RWM61rNxxA1F0QB3P+CfL?=
 =?us-ascii?Q?4v6F6fUj6/Y1rQxw+oPVAzO3VHWThnb4TWPUhn54xyNr32jciejyUHvDLEtU?=
 =?us-ascii?Q?pAqY0FGL3mUuaGIMluWheAdLv2AwNpDjQ1pEfgdFn5aPZvWoaWczWVbX02d2?=
 =?us-ascii?Q?d+JRZdDGo2gQaqKFtxMjpZROKlp8LFA3hHFS4dzNzJOwi4Oe/zYLDz1i+EjP?=
 =?us-ascii?Q?02yNOiA60aNR9QbwQVf1HG6NBucJvQZOIiDpi8KzvYo9g6xpgrGfSIm7IT/H?=
 =?us-ascii?Q?CHqG+nrPJrk+blVFROp34174SmOnDHhj+yUNMHftW8yWOdkHiWpAUdQqhJM/?=
 =?us-ascii?Q?BqAf38sswRXez8vMHkgQeQNZAd2l05PyzmvHdwOBuAg04xHSv3fXAx6KOr9q?=
 =?us-ascii?Q?NYnZa9hQMg4mbfD50StLXSTcoSS/QBIFljMZM50JYNSdEl/mv0pBRFBtL3YE?=
 =?us-ascii?Q?ixCynDc4hryvDdJNVzwcHXBmO4cHmu5Q43Ac6a8pLIZVY2Ew+HruN4q1gfEF?=
 =?us-ascii?Q?dcSNSMXOJ40OzLFDdMxVNa2yCjyfxKkIpjR8nkllhT5wSuTUa0mt0BzmpzZZ?=
 =?us-ascii?Q?Oq/3hX4451DsxNfn87lefc4soVwN0GBh2MeWkMKFDHzcBFk2X1DQJOzr4zEa?=
 =?us-ascii?Q?sE5wIUOCKyTVwPQPukON1Jrx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76429678-3516-46e0-b928-08d8da9d76b0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 21:28:31.1337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpSIdizRBYXYNjJ+2SMS/Efg35eW9mFVUBlClh/blDcQlIk01k1HCemq9vTRcjCKlCKHgVLP1iEeaAJNUQnGIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4685
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260159
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260159
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, hch@lst.de
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

On Fri, Feb 26, 2021 at 01:18:14PM -0800, Brad Larson wrote:
>     On Fri, Feb 26, 2021 at 12:43:07PM -0800, Brad Larson wrote:
>     > Kernel Oops introduced in next-20210222 due to get_max_slots return arg
>     size.
>     > In the function find_slots() variable max_slots is zero when
>     boundary_mask is
>     > 0xffffffffffffffff.
> 
>     I am looking at the stable/for-linus-5.12 and what I sent out for
>     a GIT PULL and I believe this is already squashed in:
> 
>     531 static int find_slots(struct device *dev, phys_addr_t orig_addr,       
>             
>     532                 size_t alloc_size)                                     
>             
>     533 {                                                                     
>              
>     534         unsigned long boundary_mask = dma_get_seg_boundary(dev);       
>             
>     535         dma_addr_t tbl_dma_addr =                                     
>              
>     536                 phys_to_dma_unencrypted(dev, io_tlb_start) &
>     boundary_mask;     
>     537         unsigned long max_slots = get_max_slots(boundary_mask);
> 
>     Could you double-check please?
> 
>  
> Yes this is squashed in the snippet you are showing.  The bug was introduced in
> next-20210222 and is still there when I updated to next-20210226 today. 

Duh! It should be fixed now for the next one. Thank you!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

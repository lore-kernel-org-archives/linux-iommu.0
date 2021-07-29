Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B94C4338F
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 17:08:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0AA60F22
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 17:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F0AA60F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B68904037F;
	Thu, 29 Jul 2021 17:08:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1XxGM4CAnb5S; Thu, 29 Jul 2021 17:08:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 26395400AE;
	Thu, 29 Jul 2021 17:08:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE4A3C001A;
	Thu, 29 Jul 2021 17:08:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6456C000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 17:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4E50605DA
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 17:08:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ck0Cuxm+";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="YEJc24c9";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="fnNUIw3m"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qEa-WpZfMQPa for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 17:08:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3FCC605C2
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 17:08:50 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16TH8SJw012825; Thu, 29 Jul 2021 17:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=MyOXS8lE91RpzMiAuX06deKrpJq0GbY/a+Sa5EuWAWU=;
 b=ck0Cuxm+FEc903MbNOTeR0Ivecl+rzouy94OgvdItQfxCAP0fUKFmSF53RMSq9gPFpsq
 3qZAzUYBod3XeV5LABgu+ZNB6BD4WGTFgs9pX5Oz8v8iiBBq8PIhR31JpTSGPI68bQ5E
 BXm5i5LQkNeGmAn0iJbvogwAYeZbpAQrw8srkVdG/9NKz5vRIZBPzt5gTu+ndS55IPi+
 8c5T+/SgqZ/SO2xXKlwOfruAXGLFJMupW5B9/ZPfB0qJvyCeAkpHu/weygGfITg8KEw/
 lKY5ImG5aSzh83FrrWEqCdUMC+NSEp73WIdIk4f20r3Tgh6ParVBJ6mcVOBuRlfB+g3W xw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=MyOXS8lE91RpzMiAuX06deKrpJq0GbY/a+Sa5EuWAWU=;
 b=YEJc24c9iFsyLn9/Q1JgiBko7b8FqbyXVn1kYekas8KiX5iLYxOQJnOHvwKvglgAc7KB
 zDkU7QQSJ1yoaWkNpJt62Sm29CfSPHA1zx3GcS9erG001frW6Lf4nxxr93Nggexc5uBF
 Ac99DL/liROutM7L85iQ00rSW6wocgF2dG4ZF30fq8cwhSz/ZnYwSZFhtgNHtpIfNtq5
 te+9+9kBP3pXXM3g9ofkKQEHLv4DnOh7zT5XEEvhl2UOFUn9AMuEmLA7UIAXu1aQwhYQ
 zxemq+LVVfIrgbd3KbgHb4GOe+CVFPqlHTbPikoEM/kRRTbAXu26OZx2FwSljZ9y8gMi hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3a3qj4seck-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jul 2021 17:08:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16TGTn9Q166771;
 Thu, 29 Jul 2021 16:36:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40] (may be
 forged)) by aserp3030.oracle.com with ESMTP id 3a234et82u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jul 2021 16:35:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPMGKmRwRopFa+Dpy6EZRliTztj/lIkhNbhCt7rhw7IkjnTL72v15gtyiGgA2n9X0HzRPBtsE3RmlvNDsHlxwXBdNrTn/vUzlSWfq1+QOKSEl37hDtIfnyFJGZ9BYnUwQPdchBnDMUolOnnUow2UqAF1JCIWbMol7TgUswMAGL34xfLEUkw3t5r5ccFZVvmGqO40mjIgQP1VeLcKe8pQVDm99NzXrwKlFkV+K+9B5sWqNavIS0I10y+I/TPBhXVT65FDr8xvTaNmve6CHhuIUnyMtq/KQn+EVvqHgppWXw103zUNPtUizsFoHyZYIsH/ABAezSQItfw8DqFL5fmzeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyOXS8lE91RpzMiAuX06deKrpJq0GbY/a+Sa5EuWAWU=;
 b=MhzmY3x3RtMy0YSMFNIgNSxIZY6LFOR+TKvnfQYdihFf/9JoSX0MW1SlTsvQ2AQ32JR0pSrfjJfYhVKadG3ztpU6/sQh6yuh4+0RGuFSRnObC34UcnB+gQI/5IT2KSBAmAWfh264QwIhxWD9fUGQVw8gZT7cXOihVBJuKpyOALgP7TM2E94K9qacFqTCBs8OvfzsDlyTbdQ4gXEdY2jb5KBv+iuZuebf5lz75ZC61vzBAp0d1UJ1HOG1YXIOhWZUF6R/NWVjKBi6NXaM0+UaF3pU91VmEtzAfHvRRVGb6E78cQFJwCIxJkRU6naaO+kgrB8VGrd1TsVgWBxN+NI/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyOXS8lE91RpzMiAuX06deKrpJq0GbY/a+Sa5EuWAWU=;
 b=fnNUIw3mEZdeMFuJxjLTfJAKLeA1p/Ix7GMeysF3jNq363y6BJAU0jHiamclBC+PmeDIOq4IoBVn/at+RcyR/C3uEAiXt2h446KpKzZiwhcoKp/XrIqNrDG63mHY2UHeI6I3WJ6SP2/8OxRsI/KcA306XcOBOQMT+Ln0aDqay8Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB4356.namprd10.prod.outlook.com (2603:10b6:a03:210::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 16:35:33 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c%5]) with mapi id 15.20.4352.031; Thu, 29 Jul 2021
 16:35:33 +0000
Date: Thu, 29 Jul 2021 12:35:29 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [powerpc][next-20210727] Boot failure - kernel BUG at
 arch/powerpc/kernel/interrupt.c:98!
Message-ID: <YQLY0RHa/3YgJdmS@fedora>
References: <1905CD70-7656-42AE-99E2-A31FC3812EAC@linux.vnet.ibm.com>
 <YQGVZnMe9hFieF8D@Ryzen-9-3900X.localdomain>
 <20210729161335.GA22016@willie-the-truck>
Content-Disposition: inline
In-Reply-To: <20210729161335.GA22016@willie-the-truck>
X-ClientProxiedBy: BL0PR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:207:3d::36) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (130.44.160.152) by
 BL0PR02CA0059.namprd02.prod.outlook.com (2603:10b6:207:3d::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 16:35:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ddb2166-b64e-4c7e-215d-08d952aee2a7
X-MS-TrafficTypeDiagnostic: BY5PR10MB4356:
X-Microsoft-Antispam-PRVS: <BY5PR10MB43565A9DAFEDD54C0DE2358B89EB9@BY5PR10MB4356.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvk8/DwahAlHleD4mMaKFTQ/MtV+hFsmVLo/Q3bpiDubQ7KP1ANLe4UoI6iw1378g3oyZOzjQFBg1ieFQMv0zxF83O4T9Q//t9ycIbcLXGxXyxKHfqN+HYILdZPwuDyAbEW1F9nTwCGIkQM2RFKrMulKSwA3sGUUZBWWML3vkoeFOCU69InGXSMdrAvEuG3jRHc2KyNYgybLmSYmGOD4On8WlRZ/zep0XqXVv6ZQaxsXIv9ExuCtHYjKSuiNwVHaYx3uIlwaLCBYLHeVydyyLJWQgwYGetq57YY7Mi+chWwCIuhrXCSia79sThbDzqEGS0eL/rcrfxnX3qSDZtcanWjwTgfmmqyDdD8b/PiBH8juydJk17CV5fQeDpQlid0B5O9r0O4OeblYhzW96b5NzTnCAslAMGPCEODPY9KTl2wz/cgdkuKhOu3x4JG3sLvThuRJ9TEOaBe+We53vQq07t8crbgjEwDD5fLR33E86cDPAyhMtTHww+OxyFOgQMNksl/Mj0lFNC7szmYD5t7tFfGZNBWcAz7qeY8Xs4A5zsW6BUy6ClTEKbhmTsoR/7uvbWkv72pfjVdTVb/wrb1OkH6v2H0/0u002xhr6wUkTimciFNboNqxEQiHRISzRptezbck41Kn++JA6TzA3Jm/Go+rCP91RQ14opc4SNVeHdG1hrS5eDcFf5gqoa4Esm0F6XgiZIQuUQzWig/Ejk8/rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2999.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(136003)(346002)(366004)(376002)(396003)(54906003)(86362001)(186003)(6666004)(33716001)(83380400001)(9576002)(8936002)(8676002)(26005)(38350700002)(2906002)(956004)(38100700002)(9686003)(4326008)(6916009)(316002)(6496006)(478600001)(66556008)(66476007)(5660300002)(52116002)(66946007)(55016002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AwrXSTVQHSFqV9dYUkiI7aCK9Jw+K0Qq8srqcuNF2oy2etfG2+PAjkgyIHUO?=
 =?us-ascii?Q?B0ant/FUfGnHtxEa6pftW6Fw0CmKw2qOkW48NFTLKLfSivqGogqd/rnpjjoh?=
 =?us-ascii?Q?yLHVJ8tqdjfYVxtbfNRIRGsTvJFFIJm8h+UP6cVQm3E+B23q5l0BXkxBNXhE?=
 =?us-ascii?Q?zRCTWafFwT5QefcrqpsSa4gDnjbAd1MFYsTGiVXWQwy1qfcv6PP7LACrcvQC?=
 =?us-ascii?Q?YStUAJT/yUPx3eWPTjkgrQZbzJfaDL/33Yhs4J5WHtn01/RpXM29vNUMHSZI?=
 =?us-ascii?Q?ojbVfJYq0QO8nPMgXK8KC90TiYSRxqPqb02U79n7WkAIeLGZ3k65EBja/yxe?=
 =?us-ascii?Q?rLvFPqtLlbkBvNF8He+uWq9sEzhmk83tSal6uTDywY0jN7Y+fTxga+w8e4g3?=
 =?us-ascii?Q?Z6Bfps/IV84eeXJTXr04lorrEJef6eqxvqplX9ITpWEqOgblNJBbXdqyX+P2?=
 =?us-ascii?Q?GOkbWy4ToSkWVmFUf3reqOu63UTva72muY6rDisBZkxUHt5IeukNMsj/D+9t?=
 =?us-ascii?Q?qjmyMe2pPRwgMzpF+ypbwfaxVtp1fODeiWNC9WhPlJli2PTkeYc/C7Q96FoD?=
 =?us-ascii?Q?/CsSFTg2lH3h8dz9IVYN8LVIW3c8lrZ0Zd+Lp1aKiSnHiw3f2xlfzfzPnQH/?=
 =?us-ascii?Q?OCAnt1PXIyAR8VJAVzVGzI1VGk419Ji2BAt4zpSMwhk5REyJ/gAXBSuz/P50?=
 =?us-ascii?Q?qgRciJioFfBDiaabYdckSp6euhPxx9cyidn22OpQO491rV5bgxfVkuIeRwCK?=
 =?us-ascii?Q?YnWniWug/rwpkAPpv15hgO2EAEKVixTgyX6MA3RSjKpTJxl0I/VTKH5cvP73?=
 =?us-ascii?Q?mvfK9nxPxEuUSY30V0zqkX0hJ6haq54dODoA5l2o7fW5KmCvR8ofWHlUc1Jf?=
 =?us-ascii?Q?cb14uScwmnUi5raU9zijRP0HycbqUu42V47w7fVv3kEIhQb2pmfFO9jGnUH5?=
 =?us-ascii?Q?iJGDodXU2AfD2ZMYjiNzNYR98BSoGNo6LM0i4NDJkAQDDEgD8Yt/lhZh8TX0?=
 =?us-ascii?Q?aaqLCYrYCGrIq3vmsCMm/I0XMfRwNg2WNdLcy0p2IPNu/uaFG/tTmlGdYO2b?=
 =?us-ascii?Q?IveVam8JasN8nAnKr0L0z8WY41KJTC8srwt7SOGGIZIBiPUalpACkQkr/idG?=
 =?us-ascii?Q?rMK2889rl9K6rlY/s63cYPllFI2Zr0CplyMpavx25KWsu+Voqz0Qkqiz17p/?=
 =?us-ascii?Q?BVrx1LvPDM0FIwVGdxFcSyJQL3WGwfkx9TdBS6qEgPV6/F0TdkteQCQOGxaM?=
 =?us-ascii?Q?C8qHFD0YTroCt78IB9dafAqL6zdrQBXLBHMK7G09IPwTIm+oARYLhDzS0ov4?=
 =?us-ascii?Q?KPaCEfFIhH/cu9x7HGGBnZws?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddb2166-b64e-4c7e-215d-08d952aee2a7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 16:35:33.1396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1nrstq3cmKu6yWYsFFf0B4eHPyD0M9qrYJIkowpoQi26Np5p2tCyDUa16vZJaL32fHh8gwZ9YqD9rjqaUMLGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4356
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10060
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290103
X-Proofpoint-ORIG-GUID: B0k1KXVoXdlij0XVGtdSFL1Rxsa-Tsly
X-Proofpoint-GUID: B0k1KXVoXdlij0XVGtdSFL1Rxsa-Tsly
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Nathan Chancellor <nathan@kernel.org>,
 iommu@lists.linux-foundation.org, linux-next@vger.kernel.org,
 Claire Chang <tientzu@chromium.org>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
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

On Thu, Jul 29, 2021 at 05:13:36PM +0100, Will Deacon wrote:
> On Wed, Jul 28, 2021 at 10:35:34AM -0700, Nathan Chancellor wrote:
> > On Wed, Jul 28, 2021 at 01:31:06PM +0530, Sachin Sant wrote:
> > > next-20210723 was good. The boot failure seems to have been introduced with next-20210726.
> > > 
> > > I have attached the boot log.
> > 
> > I noticed this with OpenSUSE's ppc64le config [1] and my bisect landed on
> > commit ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()"). That
> > series just keeps on giving...

Low-level across platform do that. And thank you for testing it and
finding this bug. Please let me know if the patch works so I can add it
in in the patch series.
> 
> Yes, but look how handy our new print is!

:)
> 
> [    0.010799] software IO TLB: tearing down default memory pool
> [    0.010805] ------------[ cut here ]------------
> [    0.010808] kernel BUG at arch/powerpc/kernel/interrupt.c:98!
> 
> Following Nick's suggestion, the diff below should help? I don't have a
> relevant box on which I can test it though.
> 
> Will
> 
> --->8
> 
> diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
> index 1d829e257996..87f001b4c4e4 100644
> --- a/arch/powerpc/platforms/pseries/svm.c
> +++ b/arch/powerpc/platforms/pseries/svm.c
> @@ -63,6 +63,9 @@ void __init svm_swiotlb_init(void)
>  
>  int set_memory_encrypted(unsigned long addr, int numpages)
>  {
> +       if (!mem_encrypt_active())
> +               return 0;
> +
>         if (!PAGE_ALIGNED(addr))
>                 return -EINVAL;
>  
> @@ -73,6 +76,9 @@ int set_memory_encrypted(unsigned long addr, int numpages)
>  
>  int set_memory_decrypted(unsigned long addr, int numpages)
>  {
> +       if (!mem_encrypt_active())
> +               return 0;
> +
>         if (!PAGE_ALIGNED(addr))
>                 return -EINVAL;
>  
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

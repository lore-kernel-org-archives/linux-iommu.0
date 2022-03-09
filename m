Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97954C433EF
	for <iommu@archiver.kernel.org>; Wed,  9 Mar 2022 07:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 362EF41674;
	Wed,  9 Mar 2022 07:11:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZkXB60iyWHit; Wed,  9 Mar 2022 07:11:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DCC8F41604;
	Wed,  9 Mar 2022 07:11:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E8EFC001D;
	Wed,  9 Mar 2022 07:11:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1131C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 07:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8023400EA
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 07:11:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="1AvGp55W";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="FWAhn+qt"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lT-J6GCF7Mpw for <iommu@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:11:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ADED84002B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 07:11:40 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2294JfTL028053; 
 Wed, 9 Mar 2022 07:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=8/3naUYWJaozIs4lHWHMtLrhxw6KseYwVqdG9Ew9EoA=;
 b=1AvGp55WTQVBltZSy3E+dKYFLxBQcckHZY6Qi3iVxpv610EwWYR3kpj4WC8Pg8bGvJX+
 Di+V1YtbSULNPU6hN1SyAiM5fjltJnfKBuSDKweetMyTOnWSU1J4d8gzguJNM9bDSLTz
 zcwKRGcIdbd8MBijL5Y3+rvaeYJV2beSdF4izmkS7rKw9BIYqufl8rV4RBYvJmT8LSFV
 5V2rVEJCSwxkqvRxOtk9+mbmBIBHUpe1L1kekWFfG75YCuA+qAPDyNQLhadgXxMqDUzO
 kAL55N4+Ags6NZyiAzR1bKMJmbWAMZ8ymPnXvP/ABi12MbFpraGg8YmE/uP7VVtISPWW qQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2h9m0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Mar 2022 07:11:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22975dFh115842;
 Wed, 9 Mar 2022 07:11:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by aserp3030.oracle.com with ESMTP id 3ekwwcmu0v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Mar 2022 07:11:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLtTL0a8z4oKgGoem9hpA8EqK7DkTuNxG8lQh9BSgP5o++frF9md9EMV1ahYOHcwnK5F9SD1EBXQV9H7sMK5jpaBM4uu3ebSL04VDOma65Eh7GuDGZBHG34KL7UBhvgJLXYDDeWSibG35cNwE+4kePEqDxV5v42nQAbQQvvHkfuQFzHnP8m9IrF/T4ky8zaRAOd+BlW6EHUO6rqNnHtAAfeiZalaSTQ95gFCTSD2ixyCPhwJ0kDWaYWB/Ab1VcirIoLzEpFUBRQoo+mYdKTz8NYJ3k5+U5mFhsb+yr2Dl1ul6rueSyHKA2HzFauddZrW66h1Kzk8z//tThFfQNShEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/3naUYWJaozIs4lHWHMtLrhxw6KseYwVqdG9Ew9EoA=;
 b=d9ise0W47Yemedr/zKrU32Cu+dK4Zah06ujJ3+ff/GWDr2RwGCgq8jP6UyU0nDNtycMjond1dJfk2wIYzbAubFEYLvM7Tn3wLdps8pqGLtYR+5RoauofDDOCzhzRZXdn60RW1BfpatNhlI7H8WsDAaF2T/IIfCy6CXDlmw1AjuVWB52w+OwAnohigqZieqVdF0V8G4uQK584nBsiCBYW5LsMiVZp3aZ5tcrf51j/Tvldpf3khUKePZ6eFmxdeazOLVQvSyiguGNokjIpsY5X23QdaxYLfd4BGl+/TrpK4eqhlsslH1qTwqyt7g1qkKHhMUktDbLM5G21D7pppKU/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/3naUYWJaozIs4lHWHMtLrhxw6KseYwVqdG9Ew9EoA=;
 b=FWAhn+qtSyYbcJALdcJY9OkgkwQwFAlinviZnm59bnZSRzJQBySDDSTgtZjsucqq/O+JI9W+RIoFRDmcvf3Zbvdc1mX3qT7kUcHmjKs5yP+TeAGvrMtrNG2L3LirostJTXJOs3jmsYsbrKCiTPy8T0rI1GYu21ANVYtxHpRlQEo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3487.namprd10.prod.outlook.com
 (2603:10b6:208:119::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Wed, 9 Mar
 2022 07:11:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 07:11:34 +0000
Date: Wed, 9 Mar 2022 10:11:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: suravee.suthikulpanit@amd.com
Subject: [bug report] iommu/amd: Improve error handling for amd_iommu_init_pci
Message-ID: <20220309071122.GA24681@kili>
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0050.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2228eeed-982a-438f-0116-08da019c0b27
X-MS-TrafficTypeDiagnostic: MN2PR10MB3487:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB34872229E8C479D97600EF408E0A9@MN2PR10MB3487.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ne6GL5NdOv4Gq31khThTmE6JRG8xNjFy/IEsfZ0l8loFtJSgUhLPGEqOz89Z7r0MAQtMbcR8voq4D9iO1Irl4ZdFfxJGDYTs32/RzWPHwV8jzS7PvlK384GMrVW/r6DjqpvK9Ig8GhEzIwhCY8meb6/bj0IuhMSXyK83g3lQrjUSQMdSXfzfe/3Wd8qfNJKZ2/KBZknq0hdeJv6cvRf5ha+TAmwciyZKPrEJwcx3YBwYZrfnJvZcsrXczvpBn/r9B4AZ6vTNsCV/iiiT/a6nvmeXRABFT4hnowBFZYaMCzFL50UUNIPZHKEcJW2Y4dZ17S3slm91Gbz+MDd4PEMIEl7tNqrXc/ET7N0/ARBlHb+nKsYnr/QH0per5OpmMRfTbgWLiQqZeYCE3jfAMzTxzqJVkGzw2Rzg2iFTL6OqdbsdRUsrmWeblgTNfKopISHZ5yIUrJVMpvK5uVbcisAMJfpO4/s5pFEzl3L2WXWo4jM6tv54TCLkpssb8r1ebmOzfm9n9YgNrnDl5MqhFhcPqOWU8hBNAUFMJZO6M13BQ3QEwFOmkBYtWKPhVbdF+TcT5koGJT2qTkGU+ZSsCxTGIFcWcUpkTzLm3fxCbMJC4G98vZCgIThprkVZvS1eTqjqbkk1ssK11+TgVmULG2UHjLGafyfchlL5fO7C8ytt1DylFr9lIVIGFcKeE6agInqrXT7VvTTp4Zjb3Ot1berHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(8936002)(6486002)(316002)(33656002)(9686003)(6512007)(52116002)(6916009)(6506007)(508600001)(86362001)(186003)(83380400001)(66476007)(33716001)(1076003)(8676002)(66556008)(4326008)(66946007)(44832011)(38100700002)(38350700002)(2906002)(26005)(6666004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dmqncL4c25bYnjWV4DFbs02xE/vxk4FLzYR/E5WTZyJqjYB5N1R1MBA3A/VS?=
 =?us-ascii?Q?fmwlA72VnPLtLtueT4W0oFXYdch/MRGcKOXGtO+OeC3Huw5grwx3o9+MAVXU?=
 =?us-ascii?Q?eo5+8BwnYzqRuqWkk5tZwfWZdxsdPX8LvqKjsc+MzmadY1skZZx0zh2or7RR?=
 =?us-ascii?Q?Xt3IVWxzOZfExmPvFTTVavuybu/2kfMvcb7J9fpRwUSfDnlPwf/9waQ/CTgi?=
 =?us-ascii?Q?5tfmOw+/+pu1KBVh2cjERhVjS3gS77KGtKJQhSoEZneBLW2977nE4dBymCnd?=
 =?us-ascii?Q?Vt2YT0kpRe1yfTGFfDc1yhHHx8uqDel59LLxfdlD5i+wznvZW0pjMRxBl5H5?=
 =?us-ascii?Q?OSGx5M051gNtgzz4BDOKH83IvgiNRZZfsn5zyy2tTuIy1Dn4iLFhGRuVuKBz?=
 =?us-ascii?Q?Fu4WVx1Vd7R3rMgNwQgvhjcCmBh1oFyDlCskpzmDIIt2PBHya1AKtC/ppbsr?=
 =?us-ascii?Q?TmBJ1z/O2cuKfzetlN/qReRfXiL7gcw4TBJGoPsfixOAVlT8ERWPFJMivGBg?=
 =?us-ascii?Q?F4CTKEx0iV4nHHDAN3BallCxZetS13/3iYQZw7ZSjF4G+3b5oURTZ5d53x/N?=
 =?us-ascii?Q?wE77hWmvlzVD7azsGreel/q0kkz7Ywzo2Y7xivtjao6KtigseQhbL/6/Otzj?=
 =?us-ascii?Q?Xx5KsDEjdYB9fPzmYMbr8qeAPBq2MzvZ7P5Pz7l1wzvBZH8qkqtWQF0rewT2?=
 =?us-ascii?Q?cRavFVsl12thSMXDfYsZMqz05F2VwRg+U4ctmoWhyXz6nNPoaxS6YI4er5/3?=
 =?us-ascii?Q?n17PH3cC9FJIub/4reXQSgVhJ9ib7m4w1074zMqKfyM8fz85HO7oo5ka2xW3?=
 =?us-ascii?Q?MpJfMWUyOjGh+0ZH/GT+NGQC7GMVXzM/KJm2ZGVRRAIw0fqWCS91Kzt+fGE7?=
 =?us-ascii?Q?fVEbm4wSa2TuR2yaWFuHF7XA93Asea6+694nqnPTIlz2QZ7NoCi3MyX+xZP7?=
 =?us-ascii?Q?xFI+RoUqviSTODLweeYi2sOSRz76ukVRgeI5TIuBRwrXakV6ESK649GSyA2R?=
 =?us-ascii?Q?TIzZuSxOYN//CBX2AXdVow4l9lMXZYpOn2af0gaNPbYO+eqR40LOZJqSLaI/?=
 =?us-ascii?Q?BsGM7httFS2E9RrWcHj46uj5v/ojq0R0674rnxlK9NPrTmV6nbSergJTG0rs?=
 =?us-ascii?Q?EFmGXW4J2BrBhuPIMgP4qBY2/MFyZrUOrgNw3Iv9svKJ3zf4SsB453xahUFW?=
 =?us-ascii?Q?xs+IdCkh8LLA8UMyY0he8EuUcTpnjUg/EAViiOdU0/IpWE0lkK2qPXUnpAZI?=
 =?us-ascii?Q?SaPIGCCiJjWLUNnerxYE1NtEsM5bEdKxEmqeTu8axqQag+XhMucAo5VBluK6?=
 =?us-ascii?Q?qG5LAAZZgX6Sj4HoTrHYWY6QJyLyok/4H2xCgtJI6os9JvPies3sw+Ashtn6?=
 =?us-ascii?Q?xq8Y5BFUi0fBoVI4RTesnCIWu+QdrPTnuwVploaKtt2V2TMPYd2fwsvonhz4?=
 =?us-ascii?Q?5vtQOYdk2FCh/BwTd6Af52o2NkwlOCqyAojDnA++3wt9VtrhUl9UNWVqL6w7?=
 =?us-ascii?Q?Re/8eArdnEtgsWRknqaKCV9TqX6u/fQCOAvbJPyOAXeK8LFUwAtCCWpHc3Vl?=
 =?us-ascii?Q?updtKPPdZ8JHsCD/QzX5wjYpOo1Yeb7m5SZhtHhzlKYuj3JRqUsOOtHz/O6T?=
 =?us-ascii?Q?QbTPWCX8iHVv2EjVsgE1fll3zXpjw4SsCkyERjPpBdMV1uskLMO2hspM8pvE?=
 =?us-ascii?Q?enNfOg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2228eeed-982a-438f-0116-08da019c0b27
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 07:11:34.2009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8wa/DGXJKeUQHK+ySRzcUj8PK9GGRocHcJ+AXeU6Pt60a8XbMDLQaG8CASndxKD7brY0HAuWoeSu+Iem41vrnYiBml9vg5L02mOLV8Apg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3487
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280
 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=923
 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090037
X-Proofpoint-ORIG-GUID: nQsI2o87SrChTS4M1vl-M8BuHIwhpPpz
X-Proofpoint-GUID: nQsI2o87SrChTS4M1vl-M8BuHIwhpPpz
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

Hello Suravee Suthikulpanit,

The patch 06687a03805e: "iommu/amd: Improve error handling for
amd_iommu_init_pci" from Mar 1, 2022, leads to the following Smatch
static checker warning:

	drivers/iommu/amd/init.c:1989 amd_iommu_init_pci()
	warn: duplicate check 'ret' (previous on line 1978)

drivers/iommu/amd/init.c
    1951 static int __init amd_iommu_init_pci(void)
    1952 {
    1953         struct amd_iommu *iommu;
    1954         int ret;
    1955 
    1956         for_each_iommu(iommu) {
    1957                 ret = iommu_init_pci(iommu);
    1958                 if (ret) {
    1959                         pr_err("IOMMU%d: Failed to initialize IOMMU Hardware (error=%d)!\n",
    1960                                iommu->index, ret);
    1961                         goto out;
    1962                 }
    1963                 /* Need to setup range after PCI init */
    1964                 iommu_set_cwwb_range(iommu);
    1965         }
    1966 
    1967         /*
    1968          * Order is important here to make sure any unity map requirements are
    1969          * fulfilled. The unity mappings are created and written to the device
    1970          * table during the amd_iommu_init_api() call.
    1971          *
    1972          * After that we call init_device_table_dma() to make sure any
    1973          * uninitialized DTE will block DMA, and in the end we flush the caches
    1974          * of all IOMMUs to make sure the changes to the device table are
    1975          * active.
    1976          */
    1977         ret = amd_iommu_init_api();
    1978         if (ret) {

The patch moved the error handling up here

    1979                 pr_err("IOMMU: Failed to initialize IOMMU-API interface (error=%d)!\n",
    1980                        ret);
    1981                 goto out;
    1982         }
    1983 
    1984         init_device_table_dma();
    1985 
    1986         for_each_iommu(iommu)
    1987                 iommu_flush_all_caches(iommu);
    1988 
--> 1989         if (!ret)

Where before we just checked for errors here.  This condition is
impossible now.

    1990                 print_iommu_info();
    1991 
    1992 out:
    1993         return ret;
    1994 }

regards,
dan carpenter
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

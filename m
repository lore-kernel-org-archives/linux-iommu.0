Return-Path: <SRS0=n6uX=NS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB97CC2BB02
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 13:21:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EDC0604AC
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 13:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9EDC0604AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7E62D407E8;
	Fri, 27 Aug 2021 13:21:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id czBgcAHbw1bz; Fri, 27 Aug 2021 13:21:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EC40840283;
	Fri, 27 Aug 2021 13:21:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7739CC0036;
	Fri, 27 Aug 2021 13:21:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 499D3C000E
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 13:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26EF983455
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 13:21:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="BKuIOWfA";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="WI2lTnFb";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="pbX5awhG"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nQrbccEoXVMo for <iommu@lists.linux-foundation.org>;
 Fri, 27 Aug 2021 13:21:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 298AC82B1B
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 13:21:15 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17RANNPq015027;
 Fri, 27 Aug 2021 13:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=pCuiy1PYr8laUbnFWIkuUZhLNZc3nLFo89v5zj/FsI8=;
 b=BKuIOWfAvkziNmmjch2ns9pAeha4qVrq2kUrzdDPOSHtW3rKabPHtAiPKP9hTWYmi/KX
 PQv2+7N4GDP5O5T1bA+DwLaTzJJLLsq2ck7YclyNwSJs39ZJLRIctbeDiCa0niJb1cAH
 DnUo2J8tgoWCNqT6GwVOtfL/nRI8r27jrpHPZu8noms4pl84iWWhQR/50FmbwR/uNWSX
 aP/tGjfQRIPbkQKhnVCfMN1WXUxwallXfdkMW3jRUp8dAKLQyEnwq9Lx8how8LamH4Do
 Ue7C5LiZPZQ4kS/3H8yfzw7VmPOosoecy1U5U7XKVVSvKfS61D96u1bL+y/PIJnr4s3P yg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=pCuiy1PYr8laUbnFWIkuUZhLNZc3nLFo89v5zj/FsI8=;
 b=WI2lTnFb/MX6uktSpOJRR0W2Qd4Nrn2hh4nNHrAVqBBGVt72gubpOk+FrLeWMNztMlR7
 WhrBJTTcp54iZ2GvAVV3ubwz7RhX+b2QiP3PLS4dOrKAYn24T7KRHykIUbEUdNrvTqd0
 P72b28pwrpH9NHJM3YKaVBZPbhneN1/DgnmmHl0lasvpQpz42oB/N2T2opt6Xcl3wzSf
 Qmwe7MykKZ6sAtzv0hr1ey7AmrF+2kQMQtCZOC8afa+dDws93dt+guNhiivprpBouGkl
 5P9K5pYnBhdERY2oc7YdLHLis3yU0OQsyHm6bMmx8OZkJ+QUk+vROhh+t00Q0scS9u4B lA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ap4xv3gya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Aug 2021 13:21:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RDBeGU013130;
 Fri, 27 Aug 2021 13:21:02 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
 by userp3020.oracle.com with ESMTP id 3akb924gn5-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Aug 2021 13:21:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGEVyTL4IH63bFCZOMObMsxLLrFfqJPaBCXC94msnRLfOHJ6LRcjBRuSfr8eu4GcclPe4ESJVyPWnSxKQuYUBX1OSHSFfY3MxACN/E3ZEiHd3qKRYJOh7zkeyWmAgspfURqfnhsvoBPUenDPVGS7c5yk85TdDHKhW0q1q/le0D9Kd3SxEjedFXr6iFTWa0EYCQGtF8EKad3DE/EvqNdpdiPNj5oHpwQaOm3e6H2zhDDBGypRDIGPFB4s7XuQP+fls8UBZvg05GwN7dNcbpKI0C/Lee5cjbkvNY0ROFOEUv10W6mKCySonvrT2pvjdCIzEhySV+zIVgMjZs0bH2pq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCuiy1PYr8laUbnFWIkuUZhLNZc3nLFo89v5zj/FsI8=;
 b=TQJbsSGzTLt08GmvKO3uQIXDhAdZtlyX/7Ifm40liDgYRD88W3rFcv7EvRck+Vg6POtyNIEmFYhP5d37Zhl+JHE3r/jjFA1GRWp5dxMLscmRSsDvlFWN0mL1z6zjA3NZrgtWjgNAImug1kOqXnkQiSq0ooxvwMbxG4slHaanb1BoDwzAO7EV/qzmhc9HAi4f0xK4tnY6xsNNx5ZhWedhEgfHLM7+5ij1AUbw7oCL0tDF0bUc9JVF6+v8Q3AbWoQy5hhh9Fke+gBUbXCm3qmgHXo+fpvlFfU7sHIK4I4KkFa4Leui4Dblz5RQCmCSi5O88TtEBC8hH0DfDFHq4pQ7+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCuiy1PYr8laUbnFWIkuUZhLNZc3nLFo89v5zj/FsI8=;
 b=pbX5awhGXAJiH5MlcTiBK1F+TuSzydubQtQbFqsWiGzintxO900yJbGqOIG2PTgn5wQlVJNNfB8Qlvj7a462xijuYRBMBhKq6StUzt35m7UQWH68YFdfDw2GZxhm6Xh3CARJ525phD8H7Z5K6mN61Tm7sE7bpVNUJLG/Cub+Tkw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none; vger.kernel.org; dmarc=none action=none header.from=oracle.com; 
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB3237.namprd10.prod.outlook.com (2603:10b6:a03:153::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Fri, 27 Aug
 2021 13:21:00 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 13:21:00 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
 iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: [PATCH v4 14/14] tpm: Allow locality 2 to be set when initializing
 the TPM for Secure Launch
Date: Fri, 27 Aug 2021 09:28:37 -0400
Message-Id: <1630070917-9896-15-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
X-ClientProxiedBy: SN6PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:805:de::24) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.45) by
 SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.8 via Frontend Transport; Fri, 27 Aug 2021 13:20:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9affd255-28df-48e2-3739-08d9695d8335
X-MS-TrafficTypeDiagnostic: BYAPR10MB3237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3237CAC9A163FDE364D755D1E6C89@BYAPR10MB3237.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWk1dIaP4EgnWLecjLk8Enf+4EDD9rHAMjdDgcHQoNuQ498EnvJrf3RuCGUeIwF9QO13VcKxcb7ZPPCa4/Moy3WMuzUAD8CqD2nw1lHQU+aEr3cwUn+jsqDXvS3Co8rRP5R74IiNm45Cp/9CftVHEns9wPGVTRGFxJxLzSchrljqfkhkbHjt2YbydZuQ/MD537Tk7Tpii4yLsQYtgjajmDdMDgbG+z565WU3X/8DEacKrrxurwEl5ERunY4U3NFuKqcPR8qFy79kaciXzTiIQakiA87hLDdFiBWvnbh2D46d/kyxeStTFwim8kx2FNk/ZPspnOUamuJD3R8aabWy+sdMvJo375+olDz24Py80pz8EB6OaTcp4wM88IXPRUliwfrWYqcMpMfEP8yQ5jleRO29v/iWRbBRR1+bPX/5Em92C7GLpejqv1r1/MFZeteMeurmEOIoHoJpYQdzA1SV6FA0ihfZmiH3TIVspKI9gHNDeM/TeGngoO08iPqd3TXMDz5Pa9VF/kXlRFyD7oadTAzgHEJNuJJEoeJS8K1xfXtLs6T4otMaZpTjaXi9/k06RMN8WxJoP41Rvldf40RtuofwFe5Q8HIsuAqW49xLwIzAQ3P9FAwBMH27ftW9cKP0hbg9UxmiBWF/MNXZmaX0d8F10zLY0U6lIdl6gGU/tA6nt958vz5j0DsQW38aJCyXkqi316zlbELKAFPo2C+ouQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR10MB3793.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39860400002)(366004)(346002)(376002)(396003)(956004)(44832011)(2616005)(2906002)(52116002)(26005)(7696005)(478600001)(38350700002)(38100700002)(6486002)(36756003)(186003)(83380400001)(6666004)(86362001)(8936002)(8676002)(316002)(66946007)(66556008)(4326008)(66476007)(7416002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bgEePlB8TwA0D7kqY1kYfhFcvNJHkn7qClYY922vM9bIdEHXrjp0sn/63JxA?=
 =?us-ascii?Q?wA0brf1FlujLTg/8U+QhhABBJlkDdOvI59XrbCsx20f2oVb9h8vC0xahNKEe?=
 =?us-ascii?Q?RC0auzH5yCvOKxbUWtRlaKMgBarEXJrE837DXnhv8CatUQXtIx6mmEb+vFIv?=
 =?us-ascii?Q?ZSaiIYfbbCGYum61ID212i8pcjXKXm3qk+ZNwoqSqPT2sSuEGHJkyk8HdcIN?=
 =?us-ascii?Q?Wf8RhRFaLlHvU0zWavc5R5fk1nxFQZmOGWGYiSc9gPgOR61hVypSIJkRkaOT?=
 =?us-ascii?Q?Ql5weAmTFPAyhlThQ/s8TYnuDd97Jweau6rP5CwZ/p1Cb8uVpyDNKYoNNoX8?=
 =?us-ascii?Q?XmTUarFaIUkwBW+VtGco+zU28vHx7bfQzfPO8pH4Jlx8NgRf/SOtXJjmHKvf?=
 =?us-ascii?Q?LfvONTFxxRIDa/Fs2Ws7BicEHH2/8YkX/hCoJ2dND48HeuCSgL8oLG8u+v3F?=
 =?us-ascii?Q?flacm/wHQs8acSYpC3GWFOvpW2qUQj360Jq5Dreq2f8ZJyFzS4tambxhcmmy?=
 =?us-ascii?Q?8ugpB2KS8faNcKXDiXDM7VjdcgAr4nUFW7v2dl4fzJYTxQRp3nvzM1HM4X7G?=
 =?us-ascii?Q?LQazEewa/eFCab8LtSoyr5fqu2aQBniMwAbHhWxJ1EOKKQpd6GcldAalkop4?=
 =?us-ascii?Q?8nUkwksNDOLZ66S5gs7+inpidSnZQpAuYPRkgPCDd/WkBsPSJ/pbUfbKtgWj?=
 =?us-ascii?Q?G/aBNF3su91tOzSciKD85PImZJouia7ZN8IKWUtHcCS73QcHQdM2md52f/cM?=
 =?us-ascii?Q?rB4daUmDDB4h9VU8c8TlEtKwpNjnH7SsLYr6QRURDRjG/ux6qEzDBalV2veB?=
 =?us-ascii?Q?EmNkn7/35ic4aYbkgNYs2Hmsh7BP3QGGuVckfSheHPYVkhSAjrgjYktfHn6n?=
 =?us-ascii?Q?OtGR+I6cLnLK9uZ+hXszB8JVkPbSxnOS8GjMJzKdcsSNRiE1A2cyvxN8N5sr?=
 =?us-ascii?Q?1Hne/ZsSlt12f8e0ZTcycJJlvrkUr7ZpQOfLcTFkulAKvieQF5KEf1MqlQMO?=
 =?us-ascii?Q?r4exifJzWh+nZY9jlT6VPl9TzktEdPdoHNMYCm/G8YtVpFOqLdqKhFo0PNA2?=
 =?us-ascii?Q?QZI2w32T8KozpLxKJqm1149qRz1lcRH7zLiEgA6W8BVdMbc4yyA0CFgfbqaH?=
 =?us-ascii?Q?feb05GK8GgCJ6B52HiAZ+U0W5CNnXz08D6XcN+nhhEgB2JvkwUSHUENMsax8?=
 =?us-ascii?Q?oLY2yS4SWEHzy7vo7rTac7duaXy0AKjqoTuHGs2Ewj9YnSMBGNUSxXmZjcr5?=
 =?us-ascii?Q?Lsxlp6f4e+Z1qhVbH83jD05AAE1S9B2rOXoI5r5eL1lnls5fzDWyCLBfsH99?=
 =?us-ascii?Q?KLeYXjw/2/eOKSVmcyXH26UY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9affd255-28df-48e2-3739-08d9695d8335
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 13:21:00.5582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SuCnAQvlxFGTSndnYsNXq4rTZisW9uhAwAZkvP06/Ki3N+0QruppOQIjpUYxCNVCw9HlO/3GQ4klWluK0nbNePyqsxpo5EXrnK4J0zdQqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3237
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270086
X-Proofpoint-ORIG-GUID: L20cHFe815oKpsfYh4aeMPg2ybvfuhYu
X-Proofpoint-GUID: L20cHFe815oKpsfYh4aeMPg2ybvfuhYu
Cc: dpsmith@apertussolutions.com, ross.philipson@oracle.com,
 luto@amacapital.net, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 kanth.ghatraju@oracle.com, tglx@linutronix.de,
 trenchboot-devel@googlegroups.com
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

The Secure Launch MLE environment uses PCRs that are only accessible from
the DRTM locality 2. By default the TPM drivers always initialize the
locality to 0. When a Secure Launch is in progress, initialize the
locality to 2.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-chip.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index ddaeceb..ce0a3b7 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -23,6 +23,7 @@
 #include <linux/major.h>
 #include <linux/tpm_eventlog.h>
 #include <linux/hw_random.h>
+#include <linux/slaunch.h>
 #include "tpm.h"
 
 DEFINE_IDR(dev_nums_idr);
@@ -34,12 +35,18 @@
 
 static int tpm_request_locality(struct tpm_chip *chip)
 {
+	int locality;
 	int rc;
 
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	if (slaunch_get_flags() & SL_FLAG_ACTIVE)
+		locality = 2;
+	else
+		locality = 0;
+
+	rc = chip->ops->request_locality(chip, locality);
 	if (rc < 0)
 		return rc;
 
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

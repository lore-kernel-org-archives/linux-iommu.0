Return-Path: <SRS0=TVo/=HV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBB6C433E0
	for <iommu@archiver.kernel.org>; Fri, 19 Feb 2021 18:14:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC8564E92
	for <iommu@archiver.kernel.org>; Fri, 19 Feb 2021 18:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC8564E92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 77F41874B1;
	Fri, 19 Feb 2021 18:14:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AkzwU6TsrvTo; Fri, 19 Feb 2021 18:14:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D047A87380;
	Fri, 19 Feb 2021 18:14:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD944C000E;
	Fri, 19 Feb 2021 18:14:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64735C0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Feb 2021 18:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4471F6064C
 for <iommu@lists.linux-foundation.org>; Fri, 19 Feb 2021 18:14:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ub8-m8hxAx7H for <iommu@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 18:14:18 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 81387606FB; Fri, 19 Feb 2021 18:14:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F9C86064C
 for <iommu@lists.linux-foundation.org>; Fri, 19 Feb 2021 18:14:16 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JI99GW153659;
 Fri, 19 Feb 2021 18:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=z9YhpWHGGUZ/igqNbBUq55OciELKKdZWJiTyJAsGDXE=;
 b=AqAnRZYPm1EJ1RFJ4goUWycVAPnu6mQFIrRR0H1cQdYbTzt+qqY5iqmr7ffeTrVcKfdL
 u9UuZTSt9Ho1gchGD6Oxz0rPObRjopa0MT8Wc7eKg0UEOlO7zf2c9Utt6obiWUsS9C4p
 D5DVzFkL7nZ7MD8gA1l+HX3r9j05b6iFnGfkYR7hxIS7FuJrsErDGpO50GrgnQsutjQC
 Tol1Pz+CgGGoEqtatBOY5y830eRJKeCpzPa4945Q7hSAea2D1AH+kcrq06GivIUgDzkm
 Ws3cIiro7OrUsLz+iNJJj9nlOOHN4QOXzMcj1wKWl1ZKbJ7jnxoKkdtUi/if/mvFIKNe rQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 36p66radax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Feb 2021 18:14:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JI6WiL093174;
 Fri, 19 Feb 2021 18:14:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
 by aserp3030.oracle.com with ESMTP id 36prbsdhpx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Feb 2021 18:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvldFWQB24frwAX+gfntClp85r4xHkXW/Zew87eDyZW9YCm7iPT6PK2SzJ74YsjIb7j0Ppj2psFNZDg7cIhjk6iP9DyX/JFsveq1r7p0mvYCB1RqY4sWwPQS2Zz4b2510VafvyIMG9XvJm1OtlV5Pvaxsl2/FUacsRCHFRIM/OlCjI/maNAqRN1G4cmE6RsEbLQbEUInlx/6jE3/7E+qeIGg2SWQXFRAjJxS/9CFxQURhyIBCmjCApo7djZAbamQ6J50fvvS9H7rsL6No1qNsdRBIMSPSmgOhWyeMW58TxNwN4LHyKDpiPrCsu4qm8+dsfM4MW7P6aCikXw+9nQlmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9YhpWHGGUZ/igqNbBUq55OciELKKdZWJiTyJAsGDXE=;
 b=KQAvMOUoABx6WBbG3FvW7tlx5L3oGpZxUFyDGbZiT8L1hDVUk8/2NWgIVWcN6Cr/Z9KbZMtQz97uWAuyahOrSxmEwueE78hDYrFCKzmEkqgB99wOeHlwpGRZ4uJ1l3l0B4dB1FcEIbEcKbtYQ38Za1qDKnRBsZpIAMGVh4FI+bYtbOUWqgZExuEOyeB4on/xfcKUAcBidfPcRkvUscBBOpgxCwj1Hcfg1/TLTCpmRgwkHJxFlj+D8tINcvR/dQ5Ze4lH5wT5T3B6OyZ3RaozQ8ECqh5bj51Y8Cayj0wBG8LrNURRsVOgqcGize7Tjb+rJJnjYrFmAkZ3GYDImDxTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9YhpWHGGUZ/igqNbBUq55OciELKKdZWJiTyJAsGDXE=;
 b=dJ4eEkp5ohSXSTAO6JwtehEqKxozuWUqfBLUcVVJq0rrwD5EbrQmGKLwR2vWU5bYM9JqVVjmqbF2M/w0b0ru03qCvBRAuBvjifa9wnK0YW7IZ7AXAaarg+AYXEtP5/cFixB1p3EXYwLUhJ45hrBm5ugZ4rXwWnznNsBzdNxt6IM=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.41; Fri, 19 Feb
 2021 18:13:58 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3846.039; Fri, 19 Feb 2021
 18:13:58 +0000
Date: Fri, 19 Feb 2021 13:13:52 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Jianxiong Gao <jxgao@google.com>
Subject: Re: preserve DMA offsets when using swiotlb v2
Message-ID: <YC//4P4mRrXegzIb@Konrads-MacBook-Pro.local>
References: <20210207160327.2955490-1-hch@lst.de>
 <20210209084156.GA32320@lst.de>
 <CAMGD6P2QiQba=49LMOsQNZ=U9+hmAjxYLwroZGAG_AXoatUYpg@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAMGD6P2QiQba=49LMOsQNZ=U9+hmAjxYLwroZGAG_AXoatUYpg@mail.gmail.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (209.6.208.110) by
 BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 18:13:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d67c75b-0f23-4628-f90b-08d8d5022017
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4512:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB451234C5D61654479D6C826089849@SJ0PR10MB4512.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdHphktANvC2keWpVfRnuJUNy5DmyxU29yxZTVO2foaS1C/n/mDPiLgJ2DEespLks0evTJ7iKR3xnKpXZ4JESz0lRr6K9SAxU4Yd8l1/v5vUCPJZuq/ntd1/XPH/ZHVgURXpNRTZ5Dv6dgBojCjLFjj37GXXOWDEw9TfvQVbcqANcxW+oZN0eHj06R1gEJBX45pIivZICB3On3v2WbmLdnbbuok3ARgNWQMto94SyrEryYNjZEUA35xPNBMdIY/4IAonLhS8U5u6ebKZVnM8IsOGCJO3KgJ1lAJWFQIj2PSkix6FxyR4tqisFp8q5wkdGjq+QxuggUGI+8ArS6Wqn8jDzAzaLwHVi4RnZtHOltKEKk0MC3rxKbYRMl+GV3B/zgsC9X5KkqUNYHs8iD0oU+nMv9MAHFj5jJHAvJRGJi80VXsqowDrr5asksQOTiGykus8Ii+P+g2NABtiI5KsZmw9TS5QzsvwPioXRc+062sBbOaEX1y+1ytbtO5FkS+ps+3gOLlZXKmy8/xw8Yt62Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2999.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(39860400002)(366004)(346002)(396003)(136003)(7696005)(6916009)(2906002)(478600001)(26005)(186003)(52116002)(8676002)(316002)(6666004)(55016002)(8936002)(5660300002)(6506007)(4326008)(66556008)(9686003)(956004)(54906003)(16526019)(4744005)(86362001)(66946007)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?as8eLE2edH9lQx9IrLQJAeTiiOXh2f1/StLMu+HKX1rmW978Tf6Po7yjj4RK?=
 =?us-ascii?Q?QT+AeybO3md0essgmS36uKq0sxNVQK3HeHS++tOUiM++CksuLy+DfqUQSHIN?=
 =?us-ascii?Q?PCbBEKhg+dallgcV9HUupg45Gbv4tCFuercqs6v/7rQLz2sMKr2uNGpxa5C4?=
 =?us-ascii?Q?SR16Rw/oJDdj/iZNY/Zojgc2XUbw3Hb4A2mBi0Nmxgi5dV97/MHHTteJ8lN/?=
 =?us-ascii?Q?tnoE19C6bLChRDP3L74rNVmB/9xxijgfc/tiRzHu3TOxp0mxjPMkdE8N6fKm?=
 =?us-ascii?Q?I3LdW3WwX8qdVcXYssDGGlemQzYWG4qlpcYIQHl006k7UZ3k4u4w9lESWF3T?=
 =?us-ascii?Q?ZpnCGcJp4v1S8Sr1pdKUU/ifCZ/LCg87h62dlmyW1msfGmLiRPlLDS+XPGRA?=
 =?us-ascii?Q?1RfC9AeHwB1aUmg4MlJjsU9kT0b4OdSYoQdvNsbdSxxynFtF6650Vv9NImPt?=
 =?us-ascii?Q?lA6tTRDstRcH9qblVk3evrUKgyA7ZZNviAKbbPdQ4ysoiSl59ZwDROrSoj33?=
 =?us-ascii?Q?O4yIDsToINzOsdJC78Ujub6UQQWGPrrt87UesEReenmUDXdlPd2oRLZwZ0fc?=
 =?us-ascii?Q?9DcxWu2ca5eEP9ztaOtrL+KXXM44yAerw4Ysn+cydYhzH2osV6Ct8ILFFeik?=
 =?us-ascii?Q?9H3rKrLHS9CpwVjWZDNguKiHWSx8jgNpTeXQNU2ILfvHXBbwlsFQGXAS8xO0?=
 =?us-ascii?Q?/fNI3oLWaeCSrscWbDpmeLxiQ8SdMMoC0srKCsLqX772yKykl7Y2sxsisqw1?=
 =?us-ascii?Q?0+nvdcI26/KG8thYZomC5xJoGNMnjOj7CcQCp6L8xB9vtqSBsjfVHQZaRFcy?=
 =?us-ascii?Q?i1c2SQQkWPPiJ85R1gh7wcuQVERDVx9kH2GkxHKN6Q1YNIwk/r+SVUbNcmAO?=
 =?us-ascii?Q?+kRicfYcRuWHOtKhveSZHuS0zSrOZyzRDBlAF8OhT5jyWvQBi/VDqjrYv0pJ?=
 =?us-ascii?Q?itX4/JPjoCIXG13AMc7rGRP8o9SIAt3UFOkgcdHUNEyev+0aR3i/TniqZP4f?=
 =?us-ascii?Q?OIZCnkSC1oaQIm/9ntP6w1inbMnLa+xfvUEmjYuFdtrKgU5U4/6+pyzizbtU?=
 =?us-ascii?Q?D+lqyh6wDJ1xQRXDtrzU3DNGagYPRVR0qFw/pF6V7JAQ/m6sa1enCLCTNON1?=
 =?us-ascii?Q?fPQdI0TDiVImoFSuMfjcCDZi71LO2jgEskV4G8hUv91m9/HfMwN1c91c0S7E?=
 =?us-ascii?Q?KL4dJoyszFJAKm0owWx/benEjRNHJdXV9fss23SsKYw9Rfi7lvHQ+x+GkBex?=
 =?us-ascii?Q?j85+wl1vYoqd5vYzTIr6lUsdHDGR+hD/N658mvw2TlaMlKFqT+zO1jzU8OXn?=
 =?us-ascii?Q?8SpmH0gYQ7CK1//pcFw+he1O?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d67c75b-0f23-4628-f90b-08d8d5022017
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 18:13:57.9966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqDIBFcZEyYj3Ug3cHD1l6Ebvx+k+j+Bx0mNyf7AQNzW0yCkYMYovpZ6tfYnTjXgm7dCwDX3X/ZCR0YvtfOrFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190143
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190143
Cc: Saravana Kannan <saravanak@google.com>, Marc Orr <marcorr@google.com>,
 gregkh@linuxfoundation.org, linux-nvme@lists.infradead.org,
 iommu@lists.linux-foundation.org, Keith Busch <kbusch@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Tue, Feb 09, 2021 at 11:49:40AM -0800, Jianxiong Gao wrote:
> > Sorry for being a little pushy, any chance we could get this reviewed
> > in time for the 5.12 merge window?
> >
> Tested and it looks good. Thanks for clearing it up!

Let me put it on my regression bucket as last time it was able to catch
issues which Jianxiong's rig did not.

> 
> Gao
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

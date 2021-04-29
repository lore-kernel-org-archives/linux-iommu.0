Return-Path: <SRS0=7BBB=J2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF55C433B4
	for <iommu@archiver.kernel.org>; Thu, 29 Apr 2021 18:55:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DEA16143B
	for <iommu@archiver.kernel.org>; Thu, 29 Apr 2021 18:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEA16143B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 041216090A;
	Thu, 29 Apr 2021 18:55:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SsD-q8dB06YE; Thu, 29 Apr 2021 18:55:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id C86896F6F7;
	Thu, 29 Apr 2021 18:55:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8E79C000D;
	Thu, 29 Apr 2021 18:55:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFA90C0001
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 18:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0B966F6F7
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 18:55:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0WD106FeUR25 for <iommu@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 18:55:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF5DF6090A
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 18:55:41 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TInTY2015282;
 Thu, 29 Apr 2021 18:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=maA8su0hfK6v2deiEP6wED54yekBFBZ3lZcxBEZLCBg=;
 b=DYH/3ysndPkE7v78CWc/Ba9LAVtliEgG9y3f3mzsqAfEaaw1IX1XHMOb9e+IS4bNbCfF
 HjREvgTCyDPTC4SISz09Age0cioiGScjvD6hz9LuGGEmdTXxv8OK7JaFXnflq0Nw1MG4
 Q5d7J+dG+QAZcKWbfQNVj1/yK1F5zWbuh55N5XVOyIklx4I+QM5GKHhg8Nq5BtaKu/yJ
 jIgsQnnuq6GAEqHrNk7oMd0oW6oBDBE3QtGyM+wIeSoNZzrHqHmoK/u5TsZd3Yf3OiYx
 qjhka+qlSFlG9ZWIdlXHOetej0jvsO7krgZpG/zRKFiuqlVJ+QCs0SeBW8D1rTu6tFfJ wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 385aft5ekt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Apr 2021 18:55:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TIsrVD181004;
 Thu, 29 Apr 2021 18:55:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
 by aserp3030.oracle.com with ESMTP id 3874d3xs10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Apr 2021 18:55:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L51juevQ0lJDmeGLDkgsHMDUNsxljX1yCae8NnK0U/kLHR49Hgt1xTOQxLSq3tzGStWuDrVV4lm5KtlRy0vYnRjj1ykmb3xWyposVMFA/plZNykoWaYDL4B0JVAnlSVXm7EeSZzM4lMTefccmuppvVjXPzCSa+SQJ9UnpYO7g3wTQy5nEN49TjgRmznvwsMtf+dsPFaMKKnhCYjzNh1cGshCAj8gC5vxrRY7AOiD0tBqS4b+HFNcERxKhUNmvvPyv61xByEnQjjKRAO11pmDunG1re2vgiQUtjMU8cChKLDJ3fpa3xvxwJPZBkzxJ6sXGv6IZdbMp10x697Y4Z5ZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maA8su0hfK6v2deiEP6wED54yekBFBZ3lZcxBEZLCBg=;
 b=abnxFPJ4Zzj2kBX69ARu8bZfAJCSpYZ6J8UbiwuxgMiCp5Lb5aLHXJ0ae/6uaJJLieHDK27Y/LeJnbO2S3x+O2rQapHC2LVbaff78s9HyzoKDi84FDYVy2u2oCGP4XvhGVs/oJnTXWZ0X1mhelfRYTS8U8Km+TQKseLrApElGPoaD+pWkBDqhNm3fXKZk+S8UmzUWlJ2gBAHY29W4vwCfmLDm1BQ+cOF/PxlVVK8cMkM6UbTpUwe6ITBYh7cjujL+MHNi9NFozcKEfRyubBpQ7fRlRcBcC2BnCR5KAmu+sfFhQvHgzSFkMOnzbQkqEfyhS/vrQRb6IENABpRtMnNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maA8su0hfK6v2deiEP6wED54yekBFBZ3lZcxBEZLCBg=;
 b=BFflQLJAoyLak/NK1VQ+2/Oqq4tjRICMnfHFL6XH7fXY52IH2QEUaCgwkjdTw8BvzVhrwK2Jpv0ghoBRv+YmaXkQh87mLxU3UGWzVZJR8L8epOa3fEZqXn86EzXFbtZdkZP4wuNPtj5d7ZTaTGX28EqQFuZ/tnhNGt4hx1UDPbc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB2454.namprd10.prod.outlook.com (2603:10b6:a02:a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.28; Thu, 29 Apr
 2021 18:55:34 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7%7]) with mapi id 15.20.4087.025; Thu, 29 Apr 2021
 18:55:34 +0000
Date: Thu, 29 Apr 2021 14:55:28 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] swiotlb: don't override user specified size in
 swiotlb_adjust_size
Message-ID: <YIsBID1Ki0WZ0Q5T@Konrads-MacBook-Pro.local>
References: <20210429062859.2478387-1-hch@lst.de>
 <1f4453ae-9335-7423-e6a3-948d5c23a33d@amd.com>
Content-Disposition: inline
In-Reply-To: <1f4453ae-9335-7423-e6a3-948d5c23a33d@amd.com>
X-Originating-IP: [138.3.200.53]
X-ClientProxiedBy: SN7PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:806:126::6) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (138.3.200.53) by
 SN7PR04CA0181.namprd04.prod.outlook.com (2603:10b6:806:126::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 18:55:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb149efe-d46e-4806-c1b2-08d90b405e97
X-MS-TrafficTypeDiagnostic: BYAPR10MB2454:
X-Microsoft-Antispam-PRVS: <BYAPR10MB24545E633892F67DA27038D4895F9@BYAPR10MB2454.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUceuksT1FxbzxJZg/6YHoXA28VbnqsgwLy+l6sn3kuGalTpWlf2UMEoFUFyMdJCLDVxKyexBzCfA1VANzGiM+zd5lAs4MFHbRsvzBim1Mz3fjDO7mcOqlbK17NOSJ4f6FgRtGJFweZBnpzBnA1aAW5r0mLawj7UhaZgcyEse+ur9cK65o52rcn76AGz0gXZEn2Hp6E/+X9NWMmyJTPSvvM5o45KWbnJeQocUREpAWmbXx10Jlf+GskfN/yR7lztCAAHvUZKNoa7vurYnL1BocoTithPfuebUBF6WbBfJwdFNHkftI8gvvbTB9EMgYvaog1NICyqv70h1KW1nfzXtLdam2P4M1fEEvnLfYMuJg8MCk1ZH56Yme/jBneAd0+cxg9XeQxHWKvz/jwC57Qb+Y0mrJNxJrhNloUS+IGTD/VzMUIzl13lT0uPWtS+Lq6u6S2QoQZ6lpEKZUAAxWgmxLbJ0mATD+uY4QrhJ4y1L5ILSIFGAGmqbeDOZk8YJosSaOyvutha3hQ94USxQG2BoV/zJO/1pfHL8dKSYXZLeo3o6iG0uQ7StCxhRpsQcGT3/UsP2mUTujBLru2vMdJ0uXG2xm0pKimRn7FP3Y8Yx81k8wL9V9IDJI719VJsoy4eImAB+OCuZN0EMOR09/M5+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2999.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(376002)(396003)(136003)(366004)(66556008)(38100700002)(5660300002)(38350700002)(4326008)(66476007)(478600001)(86362001)(66946007)(6916009)(6506007)(316002)(53546011)(7696005)(55016002)(8936002)(52116002)(6666004)(2906002)(26005)(8676002)(9686003)(16526019)(186003)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NHlMFKj1ERcdUs+pCBsUGm9wfqKakw7BqgJkP0SRulGThJUzSNCfgnwLnBTn?=
 =?us-ascii?Q?V8r9vSyDrWxu3KQnYD41eOiccnigljM3JEHLwjESQsZBlQvmokz45TNk3ac5?=
 =?us-ascii?Q?AcKOxMHp8FyDqcG+LFe8DUnWZaBkqpRi6hK06bfaJlVPol5M8gakZzhynDFN?=
 =?us-ascii?Q?398tboI8DUaxg5cAZRXOzGKTCB1ySe1FTidnTRitdW9/V26krpI6IGrwcdLH?=
 =?us-ascii?Q?Mk/KUfEJDwVgwMViNmsSHG+FW0XDpWNoAFb/VmdnGqr44HJa2UduDUfwbBzi?=
 =?us-ascii?Q?O09pgHDf+VFK7iF12xB8YToREllNiy93yMjDYzC/WR3UA1WF0AmGeg2E1jou?=
 =?us-ascii?Q?KOf2yPjOFZuacW114721OViBUPeSy3UMgrsd8TO0jw0u/E8uLACjOfcbXxgV?=
 =?us-ascii?Q?AiP6zH/HG2sUodDjekgAd9ApSJaFww9sim4ZlQ5K1+MIQI/usSaUN+tOuHtp?=
 =?us-ascii?Q?6t8PXfjou2gi+erqJYoZMRKkPA26BYSicM8COWqmOwU6Gb/963AtVqOW60Ag?=
 =?us-ascii?Q?BiAZxQOSPmPVge0nX760zMcw/pO7lni7YMHSQ90r8WBFZe3GW7XyJ05Tgf7T?=
 =?us-ascii?Q?MJT4B6ph6jOJz4b69YXEnHrxYilF5FzYKfxUDzaBj4t/gdnTqK4l8OEnMzm5?=
 =?us-ascii?Q?NR1Hx7YqTElvw3y+3To6lprEcoWFH8nS1XnP023FYNZi1rVZuKbeTs0AHbCY?=
 =?us-ascii?Q?EJLBvlJ+HkvSCYPMf3q8tv8pH9/PHvzE0IBu3l2AKs6M2NcJ8AnPdW6BsOa6?=
 =?us-ascii?Q?jqmIE2mvFw+uTiamGatZOR4YOgXKtCFjUirL6PoYZZMDMClbO+0WZKquZRUB?=
 =?us-ascii?Q?HnbYkmZZXcd7t9sgEV8yQVoInpIpNnRjyTaODuK2cAEG1jZifcJNXMDGUOlM?=
 =?us-ascii?Q?zfx/y9vM2qP02v0irdlyR6vK06HNfS/gIM0dcC89lfq/ltK6JoArtxLqDRXG?=
 =?us-ascii?Q?Yw1tGBk/2yJVqYiDEcJz0lR8ShGjYWZ8FjgaYUY878isohsHzQVDGMlSXcu8?=
 =?us-ascii?Q?bE6CfxFuXIc9pG3hceVPpVHamD217Rc3StqVKQIA6iP4+SaTNjYHVpWhhkCV?=
 =?us-ascii?Q?ZAJlOWxt9D4636Ib3f9BcjEhmkehM9ATM1pyAleX97MriW7EbrO7zqgGM6lV?=
 =?us-ascii?Q?0wB9AD4xgNXjkANUSUvXi6KUs/YHW46GP8IYCq6dtzNIvu5Muq59m2VVfeZ0?=
 =?us-ascii?Q?JapMk6pkDsQU5R+J2Sm8Hxzr4ZqF9GyweKkKYPVoyzOBZnQwvTjijj9qMKyM?=
 =?us-ascii?Q?cXbU9hLvf2M6QcAQrEh2Jy6XcHMaTQYFQ/FXXOYe1/z+EjftyieNdUoNXe+c?=
 =?us-ascii?Q?sPqrLPLNhsMJ7UfO1lq7Heh8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb149efe-d46e-4806-c1b2-08d90b405e97
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 18:55:34.5300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXPyk1Dad5F6IpcLmKHjzFt0psr9s8a8bwK2HBdf/Hudgjh8wY9LgyWPtqH3KrLLGDLpm83mVv35lYk95g4h0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2454
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290120
X-Proofpoint-GUID: wqsv_Y7xavtXy8c97GCYclZuuOPXgkpt
X-Proofpoint-ORIG-GUID: wqsv_Y7xavtXy8c97GCYclZuuOPXgkpt
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290119
Cc: iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
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

On Thu, Apr 29, 2021 at 08:45:51AM -0500, Tom Lendacky wrote:
> On 4/29/21 1:28 AM, Christoph Hellwig wrote:
> > If the user already specified a swiotlb size on the command line,
> > swiotlb_adjust_size shoul not overwrite it.
> > 
> > Fixes: 2cbc2776efe4 ("swiotlb: remove swiotlb_nr_tbl")
> > Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Thanks, Christoph!
> 
> Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

Awesome!  I put on the stable/for-linus-5.13 and will send a GIT PULL to
Linus later on this week.

Thank you!
> 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  kernel/dma/swiotlb.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 8635a57f88e9..8ca7d505d61c 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -118,6 +118,8 @@ void __init swiotlb_adjust_size(unsigned long size)
> >  	 * architectures such as those supporting memory encryption to
> >  	 * adjust/expand SWIOTLB size for their use.
> >  	 */
> > +	if (default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT)
> > +		return;
> >  	size = ALIGN(size, IO_TLB_SIZE);
> >  	default_nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
> >  	pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D453FC48BCD
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 11:58:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7805561364
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 11:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7805561364
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33344402BB;
	Wed,  9 Jun 2021 11:58:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BC4NbKnAw33Q; Wed,  9 Jun 2021 11:58:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C9178404A9;
	Wed,  9 Jun 2021 11:58:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E63FC000E;
	Wed,  9 Jun 2021 11:58:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF4D1C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 11:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B602B83211
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 11:58:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6I171Pa92Ubw for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 11:58:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC131830E3
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 11:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fp4kelBP9n8fPN/ny/w0pb0nWD447dTBF0EuI59NyQEedr1iEmYN3kX95YRyeNBQgstxK0o1XVwO72eGh7ast6iEBBFPbz8qTNEyl/RPHJRBB+Pt7R8xhvUjcYxT3ry4RGjHWLZZS8/b+K8JMMupo+y3Oq/BFSlfspOOaZH1QshwuzGScsoewm9oA403fx/xrKHfLqAu62b4/+bEUHWhaqa9b9IDY5R/hwMkmnBVqv8ThRJG66KhEt7McCCnZVws1ykFoQNbgN5XfQ3kKFF90zEebEq5XkDxKsfSS/LRD9m8qfzcbLAgRZmLBckO2ql2Omr7YAPjxvR9HrXxJn+30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi3Ehp5dciR/3OsRjt+oZH6I9B2vKg2y3AKZGxNiUyE=;
 b=Zsw3pjcxc9wwKC/hEC0YLHNZsXzSekQ42extbWRtcAnOpNsCjsraEyB5UsS8mID31Efx1o0/3KTi0+y7+ijM8yhoeFCOesQi4uw7eqO/5rIIPQltCnuE43AYehBGT4d9XJJmfqbAWpYnfPeKj454hKEweOk3Iukb2v+0jCxGzg8bj75MWgQH3U5YLb9Ord4IAS7UiFLS0/1VqEqtAE672c3nYhsivBAfaeF+f6NDmt2bw22HIkFC+5ECbnxRvaVEGRzwuwE8NrcNe4izZVeSe87gzNgrrPrgXuuoeJMZ7BrH1rW3sexKQKgSVDjYhtQAz2SezT4YW/HSU7lnXkgCjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi3Ehp5dciR/3OsRjt+oZH6I9B2vKg2y3AKZGxNiUyE=;
 b=OkatKtLh3V8575TBQSwyWjENXjp2hbeBM1IGCuWOsNQB/MI/0z4TISXKSP8x4YQSdVkJAdOpGbGk93gl9gdiamUAcfb1Aqh4dAEdMsHF0W2qnOVBT+Uc/ZBl4fvFU2Ht9zmSxKKtiShDfMX93/uSPyuoDW+k3h+DoLkDbmbm4k2czpgg1um21O6tSUvuRTA6rNHf5sJCwOYLG90jAvaueHpG5M6Y9BB9akIC0s8MnPEOI6lDx3V1avFKI/TkVbsT5Dk1Vi+P2WOPMujlC7LFle1d2I/mFwKqIZ42d1qXiCtB/XYc3SPHMc0Q8fITjgLIzho452MeayYUzBWQ3aw+Hg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Wed, 9 Jun
 2021 11:58:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 11:58:01 +0000
Date: Wed, 9 Jun 2021 08:57:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210609115759.GY1002214@nvidia.com>
References: <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
 <20210607175926.GJ1002214@nvidia.com>
 <fdb2f38c-da1f-9c12-af44-22df039fcfea@redhat.com>
 <20210608131547.GE1002214@nvidia.com>
 <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
 <20210608124700.7b9aa5a6.alex.williamson@redhat.com>
 <MWHPR11MB18861A89FE6620921E7A7CAC8C369@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB18861A89FE6620921E7A7CAC8C369@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR01CA0058.prod.exchangelabs.com (2603:10b6:208:23f::27)
 To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR01CA0058.prod.exchangelabs.com (2603:10b6:208:23f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20 via Frontend Transport; Wed, 9 Jun 2021 11:58:00 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lqwqN-004b1K-Vc; Wed, 09 Jun 2021 08:57:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ac26a8d-1e84-4705-543e-08d92b3dd48e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5255560A0FCCBF2D907E7F5DC2369@BL1PR12MB5255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ht5nKo57heZEbkW/LAs3/Y8iXz3VaXCNy6G8y55CYtXROSuOuJMVN2eB+fxGioZpsTctCkM08VWSgedbA7lVvvUijWI1NNVNJE9t7PzgtxrJs/55L6D15kU4POGUrAnd3/bI4A+j5oYUUYZxu6daSY0Hkp+s4OjcMIgARfckbeNnjTZjY1FOfwSqJHqK081Spy/9937ukmHg/HyeztGfuI6Gy6TMQPI5sSuYUV5tkX1kKCV0GBGEHUh/Hd+n5TLNOUmiBRqLtIWCpSdu0W9IcAyGgFksxVMaVsBdLzLmktyveSdmoLVozZFdBWeRB3HiArCDzwbF/lwZwG2fZn6nqNErdlxNbVgjDlahOJrd3Ta3VD+mw+lPoqrzF/hmpdZIIwwYzCihgI0pGhsWtyfEzNTlPNjT+j7nAqdeaZSIIK0O3tSvJjPlaVcf53/h0AtoyEOMoA08A6UOD2rHIps3djScEGmm0rc+ZEHb20gudd7VfgInajD9s2FHKxgDkWbBISsX+G5SGauSjIPg4QomN1SID/42srTM/j8h3xAbvneKat9VgmsHemEEDBUh/hHxfRWFloMOUFlzRQ9TAN0/rx1huJK01g4dkLplm7rY2lI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(86362001)(1076003)(83380400001)(7416002)(426003)(66556008)(9786002)(36756003)(9746002)(2616005)(66476007)(66946007)(316002)(8676002)(26005)(5660300002)(4326008)(54906003)(33656002)(2906002)(4744005)(478600001)(8936002)(38100700002)(186003)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BicypZ/fKl4wnHZbuBmYssulZTlL15X36aS7ugykrCYpCLJUj24HzajVC2W9?=
 =?us-ascii?Q?vsEzgT4S3X2pcMbF5P+2QyVk4oilCp4qJMbzjj8qRvaLZDq9JwxfiWFngkXO?=
 =?us-ascii?Q?qrDN4n+2JePSK1+2AsgcJDP2N8Ow5EMmbaCWSzdvEShb04MndV7gthwPYnxc?=
 =?us-ascii?Q?PUM/g5QUCLZiHzOfVYiKhtiC9V5oS4Xq+Z4H6kt1WsuZCI0zB12e500JD94W?=
 =?us-ascii?Q?I/WK0dXbHXCoLyJKpBt2BxrMPywYfNK0Ce0SAgB2SUdGPAgeb7P52gNSMQiT?=
 =?us-ascii?Q?uR7P0b0rmUg02w959K44WTM10RZK67/9/E71eeQwuigYhzlXCOHMkS1jJJ0y?=
 =?us-ascii?Q?Rc2WldXmZMeqfsDUHwM2oZiWSErozCho7/dsSgNBj7L05WIl2YUI/HQMwkFA?=
 =?us-ascii?Q?3+KzANKjqkeAuqyAPbaCx169Za5lX81paMMYVyDJszBloN8DF6syp4G2uSC6?=
 =?us-ascii?Q?5W0w5hBjQ44vdrz8fvPN56obAGq2L+erIhNqT7iWIiIWQdS1nk7HbkyGs1Gs?=
 =?us-ascii?Q?3LYf8cqsXFqYuHfQTk2viS0RTjoQClS2RqnXI+SHCQzteeU14jrZ86KX5kn9?=
 =?us-ascii?Q?/Shg99Gtb/ckzR+gUN/Y/VjqpSQUyy625gNOQ5/6hqJlzvLo9G9q7Kkw3QTZ?=
 =?us-ascii?Q?p3wuMsyiWKaiXlVOpWqW9k3PnzBKbXs09eoCYqkuDKTQ/aXjPUc/03Y0rQSg?=
 =?us-ascii?Q?vRpTjt01CYtvkj9uwD+91SOmdeXv9wntbUbdJGnE1JQIYeQEGpXJIxXiGmP/?=
 =?us-ascii?Q?InGNwEi+DWtDUHLQMD3rj+oTGGGiBjDlQGOgtik9GqmJZsFFNc8Y+03C9Py1?=
 =?us-ascii?Q?V6hOvCgOT3MK29dAoB//KuM1xFhrfFI2OvALKMYV5JYBO9z4hnZA+WOPuGzs?=
 =?us-ascii?Q?HZ6fXkgnAvg7tgavehfS62mTsZxGH/Wbw3W83zEH6JrfY4oHXw2CWmBYS80g?=
 =?us-ascii?Q?F2YeF0CHn+9CM//RxTEGz0ManMIj58r7b5zEHX0HlZaYjjwlq/xfXRgumd1U?=
 =?us-ascii?Q?OOLIekrbwFWXLkaNjM/iDTW7oMryCYiRt5bEXL4n0MFwr2wRQscPx20PNkNU?=
 =?us-ascii?Q?rKSE3XDa0jy4pIaMZMvfFttHswHKPE21KciZSRgZ5uGkKzcy55Uio5q0Oc4f?=
 =?us-ascii?Q?Drf84fxbDex8PgMJRuX93bRReg32llf4I1KtwRp3+1Yhr5c/Bcl+pa4LT1/V?=
 =?us-ascii?Q?kaC4sIpPkXg+oWAAc/xTDxlMfM10qwJtnUA+xpcv+cVOUM8z8m1qoV67sv/U?=
 =?us-ascii?Q?a9nMnneqUHrmR1SZSDqxEsbl71mYLbm4gT8kMH1jKhjBwTp+63EfBN5mLmY5?=
 =?us-ascii?Q?MEfPO54ZPSTd4OFMIn9GRPi5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac26a8d-1e84-4705-543e-08d92b3dd48e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 11:58:00.9827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwl8cCE99ZdLXgtcY20+ho42IXiwJGSNCbZP3yPSIGR6M1rHq5VQ2FGqqOomTXhv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Wed, Jun 09, 2021 at 02:49:32AM +0000, Tian, Kevin wrote:

> Last unclosed open. Jason, you dislike symbol_get in this contract per
> earlier comment. As Alex explained, looks it's more about module
> dependency which is orthogonal to how this contract is designed. What
> is your opinion now?

Generally when you see symbol_get like this it suggests something is
wrong in the layering..

Why shouldn't kvm have a normal module dependency on drivers/iommu?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1ADC433B4
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 13:47:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8074661438
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 13:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8074661438
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 353F7403CF;
	Thu, 13 May 2021 13:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TFS4Oq-qhcDg; Thu, 13 May 2021 13:47:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F06E403D0;
	Thu, 13 May 2021 13:47:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABF73C0022;
	Thu, 13 May 2021 13:47:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 215A1C0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:47:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 039178444D
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:47:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uUa3-637QSu7 for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:47:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4200283E5B
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:47:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7G55PvY4AZfH6YBAg0lLk3J6fxdIuyJ3AijzPFmN3TMaoeUpmoCCEsDi0tTuhwt8l5sLYspNKMs61/axbJUByL38wArFQiNNestcMUZg3M8tBBrAV2YobaklYPhLOLLEB5k+mZMC3vS9UH2uAD0doj0FXmhdwBxJHFKfcjeGMH/LCj4/YyWrXlAu2qSDLhRtKuc42XyUjxXnQcD4Xt4FbuKTAC0K/3XtZg/pmi/wMEbaoNFNW1mCvDdLxH8HN2XHzce7PcSznx0InpBY3KPJLt5lb1GrJ2XDtJwebG1XubT0c+w+2WtbGvnUCu48sYUj4bbvYs9EasC+VnVuQLCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn6P6jydaDq74ixTmQS68qfeXyTOdSo8M/DaBA5Bh78=;
 b=XMVAVCPZFjikFFVuDSlkmNFvJC0wNwbIo8FAIBQDSNzcfaZl+PLXJnC6zhPv+AENofJNa6M1C64RQ+QcLhKwgspXFjxQV7Bmqt6k1SVHsucY/AEazR/MK1/k+lnGGVxmYnkXxUsCOw6LTc4i6cjim5rja8wDoqN4tiqyxd+8JD1Hmwf1ooNbqAYq7Eo96PVNyPVpAsyH0Uf1jmmpqsd/odt2HGWhF0gj3cYa302nlu1PhZpm1mY3USmHCowS9Lowg+IWsfUIaBNPzNsfiPjGKtzPwZ4BsDgxITN7JfTQYXAA8izraemWIEdchUrWvObpBt6Auvkt5RRhRabq9+VeiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn6P6jydaDq74ixTmQS68qfeXyTOdSo8M/DaBA5Bh78=;
 b=FIlpBqZwj/3A0tCksE+4DSDLM/n7i/3slGK5HuQ8bgUCYggc1Ye/CTwjTxxo37SKZ3XuMbFI4BV9AOuJ6RRb9kA0U0DS/hs4ZT1XPrGNmUotpdhtXvAhSqNapKPc8X3LAoRPqe3LE2KhX3TNv3pApc0GMyEmLRruF95EA5tZcj/tzBHi5WIdw2l3CQDazaEwSI4riss2+5+9tBuIbVe7C7WNHOz4zdsU6mDz2/wfaAETqO7QItqLovJQqBLQGzWqa3jzgv/imEYlIbT5fb78q+hmT/kc3WpsKE2Lc5C6+UF4co2EF4qvfM2hxX6APccIeW6kLDocmAlg1CCB5qad8w==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 13:47:30 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 13:47:30 +0000
Date: Thu, 13 May 2021 10:47:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210513134728.GE1002214@nvidia.com>
References: <20210422111337.6ac3624d@redhat.com>
 <YIeYJZOdgMN/orl0@yekko.fritz.box>
 <20210427172432.GE1370958@nvidia.com>
 <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
 <20210429002149.GZ1370958@nvidia.com> <YIol9p3z8BTWFRh8@yekko>
 <20210503160530.GL1370958@nvidia.com> <YJDFj+sAv41JRIo4@yekko>
 <20210504181537.GC1370958@nvidia.com> <YJzAsBNF1irJxRGg@yekko>
Content-Disposition: inline
In-Reply-To: <YJzAsBNF1irJxRGg@yekko>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR01CA0024.prod.exchangelabs.com (2603:10b6:208:71::37)
 To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL0PR01CA0024.prod.exchangelabs.com (2603:10b6:208:71::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Thu, 13 May 2021 13:47:29 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lhBgW-006pPa-DE; Thu, 13 May 2021 10:47:28 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5649297-d03c-41d7-ffc7-08d91615a6e2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4499:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4499E5CBE1A783DBDA1B0F2BC2519@DM6PR12MB4499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5YoT0kjxGWI5ESgbYxYcR+oF5eq5sm8EgtrN8QJxDY5jicOXKRthjInO82bHsc+J8y0EMAxh9ZTciI40lyuAcDVJsCbVg0JkNBbPrriSLmsNM1IZjYc9an9l1744qhIYYq0XcKYm3826gD1Q83cA7ZeqYBCrDmAVOoA8LcU7jq6WGyPWtJ+qM2OmUZh5mtNRWop/SGiamG+aOHuz8r/kgJ84+/h7aHBe/jTwmqUB7wR1fLv2Rh5G0g4fAjtO0hPa09PcT9oZLUihsXJGUpwvU/acE6HSB9fbEFMWLFyE0su/m+LJPZJMGp3lmNcAtyHuUCgdnAjP6WBp4vsThY4shDbJM/ICGm2NIKRQRWNB1xE394Ku/ZJEoo+w0qsvuX8B2GvPgJKziq+UmIjAfGBtjZKMGsXInTTefwlEwZlHCmIBFMJ2l6PfROZmdNrri8hBpJi9Cv85vqrwSFTSH2c9ONA8RbjMKWdBFY6iBdQL7UEBH3nYt/rwEqVaBIxh4wD6ojVZm8GsD7oD6pmwXPdZk8iyZx8e8ufc/HkYg9+b2+x/kRXD2g+2i+EA9cH5nr0KnIzPp0c3Gvg+NpifXAECs4NW00W8GMQGhBoYF3BvWyA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39850400004)(5660300002)(2906002)(1076003)(66556008)(7416002)(186003)(316002)(38100700002)(26005)(2616005)(86362001)(426003)(6916009)(478600001)(36756003)(66476007)(66946007)(33656002)(8936002)(8676002)(9786002)(9746002)(4326008)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?g50ZP4mVxyhXICNrv8cOn4kK0qQjFDPB7g/r9pcJHYk/FL5gMj8kbBcK4O9J?=
 =?us-ascii?Q?uZAFxyj0auBj58BAvS88jBmHREvEz0a+q/SItd/92sMTfhR2S5NidRTXPb4d?=
 =?us-ascii?Q?gz3KBh1DKaQtHlTkKrlzmFBBLDFL51b+DX8jdWIXk0smertsKrmUtLi+WYIb?=
 =?us-ascii?Q?UKxKv5BY8YFuRL+bL09gy1UTLcaNOb5rVg2UDbR/0QfEuuS+XLNnBEiRziZj?=
 =?us-ascii?Q?ixyK61otsODzELmItUAQ19gnMCdDRYSs/iHKJqKzGqmvvE/xFbE/YPS7aahc?=
 =?us-ascii?Q?08ZCjbNIDRV0IB7E+Un/D0UBcqXhYBm+K8M8eLcs4NGVtgE5/lyulAm3gCdV?=
 =?us-ascii?Q?uqa1dumD6jRzpc6JKXnicCxMLWDoMnrf+rxm0cMlmpehaEA6ZGUj8dXIkHym?=
 =?us-ascii?Q?Nh0HRydLcPe0u9ZMO//q7GqZvU19/GyP7PwXD3l4iqU+zRSJGgAzn75lN6cW?=
 =?us-ascii?Q?30Ig/TtpAUZorqGzN5W6niV+toobVW1u3UkCqGtXxOcd1Vlgo59IpKJNs5ol?=
 =?us-ascii?Q?YZFquqgJYX/fPrWjNIWbuyHDLOKyyO4vx6bvPJAwMsX9e47ileN1lgwqMCLF?=
 =?us-ascii?Q?yOOmujv1rqtWr+OLztYOj1VMPSQaBzR6b0fao0NX7c53BcC//JhevgeFhl0x?=
 =?us-ascii?Q?TNW/TaYOogw/DBarNIM2ebwuoTGRZsgyIAXpShccqJqfPz4t1D9T86UMjCox?=
 =?us-ascii?Q?XrMfaGhJXzjS+O9TYmj7Gv5U7SgLvVFNxJrcxVYMrYsOJyt9FzUXIzUETGiq?=
 =?us-ascii?Q?C9n3dQLS3Xx9H1Tlzkf8Qgu4k7eI0Epb4SfhyjGHoZbkSQnSbeSgzFO82pIF?=
 =?us-ascii?Q?FFcbhtpEy6Wapzacwr/y+fBNTWEQpYv30S7JcuJKO7rfJE6ONjFUcNVmGMHl?=
 =?us-ascii?Q?jPOMQYsAlpGp2OQmMeco9IL9FzUor7yUtbTNndWLFuRYy/P1+cSlK0VhaJUp?=
 =?us-ascii?Q?TA2Hc1cvAo8S8Fk/LqufATTngoA6UiUDE4mF+faKFpUme5MMBUm1A2gF7uJv?=
 =?us-ascii?Q?eeEccDZoDYSRp1DzydeDIGVq6MJoI04adF1LYWVrH2aWOkR8Oq2KXo04fGem?=
 =?us-ascii?Q?qyIadoone4AmJVToeLsTxU1FdL9UvnFfUPVRWPatv3xyDd5PJZbYmrhMBuAc?=
 =?us-ascii?Q?hfhKuzz2KcL7Ev9OVboGmpFpRdKD8Ik6KBuk5lsTELc1Chf5ob7VlBvB9dls?=
 =?us-ascii?Q?6ZOCGBuoos1+WHoRe45hCzJ3TaCiHb0k9jTTHomKgcFsHwdcLCPseUb6Sl5o?=
 =?us-ascii?Q?OA420x6o1M1bdofXCcAGfZHTt2bCYyjpEaI1syEIyE9axba/YjYLaolkr8SR?=
 =?us-ascii?Q?RvGW0skURnSP6CO21dioc/1A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5649297-d03c-41d7-ffc7-08d91615a6e2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 13:47:30.2692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmbE8GxA+vLZ2l9p54bYFM/axlpkqxhWTEnIrr4aP1f2wsi/m3jjAiIkJ5jZnrxt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Thu, May 13, 2021 at 04:01:20PM +1000, David Gibson wrote:

> But.. even if you're exposing page tables to userspace.. with hardware
> that has explicit support for nesting you can probably expose the hw
> tables directly which is great for the cases that works for.  But
> surely for older IOMMUs which don't do nesting you must have some way
> of shadowing guest IO page tables to host IO page tables to translate
> GPA to HPA at least?

I expect this would be in quemu and would be part of the expensive
emulation I suggested. Converting the guest's page table structure
into a sequence of map/unmaps to a non-nestable IOASID.

> If you're doing that, I don't see that converting page table format
> is really any harder

It isn't, but it is a completely different flow and custom from the
normal HW accelerated nesting.

> It might not be a theoretically complete emulation of the vIOMMU, but
> it can support in-practice usage.  In particular it works pretty well
> if your backend has a nice big IOVA range (like x86 IOMMUS) but your
> guest platform typically uses relatively small IOVA windows.  PAPR on
> x86 is exactly that... well.. possibly not the 64-bit window, but
> because of old PAPR platforms that didn't support that, we can choose
> not to advertise that and guests will cope.

So maybe this multi-window thing is generic API somehow. You'll have
to check what Kevin comes up with to ensure it fits in

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

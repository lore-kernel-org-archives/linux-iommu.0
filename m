Return-Path: <SRS0=N1FY=J6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF1CC433ED
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 16:15:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD10611C0
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 16:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD10611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 376B8404AD;
	Mon,  3 May 2021 16:15:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mHuJODUJ13_z; Mon,  3 May 2021 16:15:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 18D864048B;
	Mon,  3 May 2021 16:15:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD4A3C000D;
	Mon,  3 May 2021 16:15:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E116C0001
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 16:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 104574069E
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 16:15:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LhwrZwDe4OeO for <iommu@lists.linux-foundation.org>;
 Mon,  3 May 2021 16:15:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::600])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D269440597
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 16:15:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdIZzBeuvF0g7hK2h2M2WvH+V0VgQokXPTDx84Wcjt298/eGUzg34j1YF07ptaGgYKpNyfxfJavRYf+TNWV7YSkZqzkD12CMCDkPoPQglWxqCXaWsRKMWyl3qbtTNBV5uiGYL9EThOkMcv2xR5Qidu9qZ+iMQt7eusyEvSYhM4eg+j7LbpvLVMsWAsa5R+RHdZNnuwWS8Iu87oV4ghWnu+doKuri4arwMMmvFTFk/s7QkmW4jOo6p+7kswq1b+v+PWKswN+ulbolhYrs5bxjO6TvXHuk3i+aWSvQE6vwKgS4vbYF4BZrMURSpI7tGXYW+wrz/LKcMNLlFyqMzc4lKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsrcXyE5y/ppPoLuMeJMZjpz7sz6aBREBdV0KXEjuBU=;
 b=hbv4g7UhiaGB/zHm3VU+7AX4rITVzoyczr3DzbRld5ACBHMXGUWTdOETzW4IsIUUlhDF14hoBqWy+gyuA1KdKCN8eSeSN3qeZyF5UxykL3MtT/4KZ18+qdEopQft/JlHKavYubPOQgUl6urORCfS2syRniTfEoLaV0zqRZvHiHeTcTUX4svXqSnPoUz/6a/siL/pALZRv5WqzbRxUZGMDVGxsRTzQf6mH+GlGhi3UwqUatmoEAH7XYoSrEOI/ud3iBK0IxakzsoHUanBcv2ab5gXE2e1A3+Z4kdz0bh8oh2yfEN5yYZyIksiGxImQfBy6h/Xic8EzfzqmSU9AzgHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsrcXyE5y/ppPoLuMeJMZjpz7sz6aBREBdV0KXEjuBU=;
 b=fhriCLjytOTxefQIyrhGbxw7ejvgWd6ZiYWgmDDMtZmMV+6Eg1P1xNKxzjQjFlePEh+GiE9mBTQcq9+FODgn2LFTkGJC9Xs7TnlOQMV6l6oa+zoNY91QrQUW/BU9clqqtSjtcAMG6LMbaTgJWtsL8UMbkWPdNeEjN2q85vGCgqPcHUkvxWHbhbKk1wWNa5kVqYryQj5IvWMG7zrkBxUXmeBphrY97cAu2M2JPvsDTHqAiynJ98SKRdJxHuJTT+7hEfwQcD4We1tdsYjfwpp9Fc0TG0N3aEE28TW6T7gg37HAL9kpVHvCQoI8CEfgo50XOrMjiCqAG8/csCkNHDhhRQ==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Mon, 3 May
 2021 16:15:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 16:15:20 +0000
Date: Mon, 3 May 2021 13:15:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210503161518.GM1370958@nvidia.com>
References: <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box>
 <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box>
 <20210428145622.GU1370958@nvidia.com> <YIoiJRY3FM7xH2bH@yekko>
Content-Disposition: inline
In-Reply-To: <YIoiJRY3FM7xH2bH@yekko>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:610:e4::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 CH0PR03CA0191.namprd03.prod.outlook.com (2603:10b6:610:e4::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.39 via Frontend Transport; Mon, 3 May 2021 16:15:20 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1ldbE6-00GO53-Vy; Mon, 03 May 2021 13:15:19 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35d92f31-36f5-44a1-e285-08d90e4ea5dd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4250EA34963AB196A100A579C25B9@DM6PR12MB4250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TNMkxlz3Km0BgpGBZRVE7mVgvV73+p4jwTEctTJvlS8RzpJUB4a9Bc0BZRbsx++Dz/bxcdp9G/exJXsbFIUB8hvQGYGTjvTkvTmP2OkidManKQQLLNRJzR7AbI5GtYj4qVj1SJeKpyTxyJEbYe/3Ux/csUpF2Sw0Zz0sAITSoBp5xs/X8D+qXg6td0IUdzQhO0t0PwmFNurNW8P1jb2mn53osJ898+H5zMkzXq3pc30kvodf9pkJCdv1AecqTwpX72PPvgvXLl7/dY/NaKYda/tBpSN0fb9w/uDQTlML3FOqPO22h1dvcFaUZDaKKQpiqI8v8glF5lhH1lxNdDGSBnPG+dii9wG+DaMhHXPPsXGRT1YY00Bnws+vHhQuK10XonUt157NlyQJtThy77yOGzOiP1JyNPMi56nusGBrIJ46ao8oyWK0ibdVFcHnSYom1aSXInFjnda2tjgGG6bykI3KPqIMzwTqE7UmO0WmGLk+KLhVdEl8OlxPGqwkWayBgBBjkJKT+xetanObmPeefOwx+L5bpdDFORlxXlr7SWG+MsaH98RKTShk4O0W2xI8vb1lDg8+ieLf0rt7eezbiyledGx2h0GOSmmu8jWUfP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(316002)(8936002)(2906002)(83380400001)(36756003)(38100700002)(86362001)(1076003)(478600001)(4326008)(9786002)(54906003)(8676002)(33656002)(66556008)(5660300002)(2616005)(66476007)(426003)(186003)(26005)(6916009)(66946007)(7416002)(9746002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lIgkwEH6PEuyKHnAcH6I3GHJIjaMYQ1VPzX1Ba1EgmH44MucOQiwr2NpocRD?=
 =?us-ascii?Q?zyIewNhKLsJODR/hDiM2PC6d7pAabsP6aWYCmZYDgygYuN6kAfQjT9vSXBRq?=
 =?us-ascii?Q?zfMtK68kugF+fauovX4Rfq/U03RsVv+iXKwcJZlKHQ6TvBuIKlKjtmKlTN73?=
 =?us-ascii?Q?KkcW7Lqts25eiiTl0VhWtfC/VZyvKl+RZD2F+6wpezVU20crH0xG1uH3AKyb?=
 =?us-ascii?Q?5IhqYmkc7iAW1M+3In1mhKV1TjRnE+C4EC5+ET3tjcOzbArMpfoYdEN/vWCO?=
 =?us-ascii?Q?tXJvfzSO16uShIu76riA6hnySrnkseDuTrBOV4agO78szktAC/HCTClMSJCi?=
 =?us-ascii?Q?3EDrhAsUsbZehm+bytNT106KNw//4GC34sKiYq+0RV3s16/aS7nuoyZ+Ouga?=
 =?us-ascii?Q?Ss9WLkRiHXbsq3Yr83imhBjVbizndCb8V1ebwu71DPhRDpV7pfAWApjSmaHJ?=
 =?us-ascii?Q?AGJn+PmXJhJtYOGl5qwp0cIsYydAsyk5X1iOWXBX8tlgg+C36p5OTS0CM3nW?=
 =?us-ascii?Q?8/VM6CPV7SJ+EtaJ8dLa1GduqFhXUT/bv7RdRl7JdTvIXgXDtbtZRcvpxe0Q?=
 =?us-ascii?Q?/6ulB0JezIJooUcht9GM8jNbfH6IyUQeJZRkh/bHxDQ8Cve85zzeoA/Gx1c2?=
 =?us-ascii?Q?0kfKL4wdEA08V78DOLOgTpJqLaoqrB2lSpEoLBjEp1ma2r+HcwsxVLPRhutR?=
 =?us-ascii?Q?PMsTrkbZTAKBCIEXU2okwCo+3gRpJGW6bxQj+hdSKVb+KhuqkkDnyfltFeMU?=
 =?us-ascii?Q?jXDCw/oKRIcqVPmg1QevCqY4s99SKul7ef/jc0QW4zVUoKdLt6xDNSk+GYDw?=
 =?us-ascii?Q?iprhxTkatA5cdvUB4N35WZRQ7qfYWF1ZmcDw2lVip1Rx5LCoudH5NtFVpu/v?=
 =?us-ascii?Q?DYHzbzLwmUQiA2bvhhBaGKskuiQHyr4pk2bEmSBd7hapZ3bvwUn0woZKETtn?=
 =?us-ascii?Q?byDZvnjZ4BLta/D4Nxbt89uGZTL67ivLAZSiMVqpehdRJE1bRikdzUp7aPvo?=
 =?us-ascii?Q?02FZhxN7zEKxTaA5X91cU30Cc364jKjg6jqxrjE1HvcyEIBLuA0bTntM6Wgj?=
 =?us-ascii?Q?+p6QIrZPVRODyDFYW6NCbgl/W9ZO0nvcWMM/5B6Gi30iU4QZyL49GCfJeoVV?=
 =?us-ascii?Q?c/v2rUDueXLIshxGnKTUdUye77uy58h7wskOjbpJaQv9Z9B5EA8lmibPN6Bh?=
 =?us-ascii?Q?zgXzRFasafsiGPasfS2FK8UisybTXbMVry+IXStpuq0XMTDJWi6RpG6gWBu3?=
 =?us-ascii?Q?3YpXZgc4585EyHxnQlzHxFoAX4Jm1RsOeWNtK5dfNyaWF+rIK8aZRee42Tgs?=
 =?us-ascii?Q?eKAWF9qJtCj+6xvE4ngy8wTA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d92f31-36f5-44a1-e285-08d90e4ea5dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 16:15:20.7283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XWANPMcBaquO9MDwkEKFw3o8qO/4gq88R2quI7GHIdLdQ0v/W85QXttinpxYzZ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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

On Thu, Apr 29, 2021 at 01:04:05PM +1000, David Gibson wrote:
> Again, I don't know enough about VDPA to make sense of that.  Are we
> essentially talking non-PCI virtual devices here?  In which case you
> could define the VDPA "bus" to always have one-device groups.

It is much worse than that.

What these non-PCI devices need is for the kernel driver to be part of
the IOMMU group of the underlying PCI device but tell VFIO land that
"groups don't matter"

Today mdev tries to fake this by using singleton iommu groups, but it
is really horrible and direcly hacks up the VFIO IOMMU code to
understand these special cases. Intel was proposing more special
hacking in the VFIO IOMMU code to extend this to PASID.

When we get to a /dev/ioasid this is all nonsense. The kernel device
driver is going to have to tell drivers/iommu exactly what kind of
ioasid it can accept, be it a PASID inside a kernel owned group, a SW
emulated 'mdev' ioasid, or whatever.

In these cases the "group" idea has become a fiction that just creates
a pain. "Just reorganize VDPA to do something insane with the driver
core so we can create a dummy group to satisfy an unnecessary uAPI
restriction" is not a very compelling argument.

So if the nonsensical groups goes away for PASID/mdev, where does it
leave the uAPI in other cases?

> I don't think simplified-but-wrong is a good goal.  The thing about
> groups is that if they're there, you can't just "not care" about them,
> they affect you whether you like it or not.

You really can. If one thing claims the group then all the other group
devices become locked out.

The main point to understand is that groups are NOT an application
restriction! It is a whole system restriction that the operator needs
to understand and deal with. This is why things like dpdk don't care
about the group at all - there is nothing they can do with the
information.

If the operator says to run dpdk on a specific device then the
operator is the one that has to deal with all the other devices in the
group getting locked out.

At best the application can make it more obvious that the operator is
doing something dangerous, but the current kernel API doesn't seem to
really support that either.

Jason

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

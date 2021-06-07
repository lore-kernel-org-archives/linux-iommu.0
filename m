Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1F6C47095
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 18:19:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DBDC61105
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 18:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBDC61105
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2ECC2605AA;
	Mon,  7 Jun 2021 18:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id reyG8XlV4EbN; Mon,  7 Jun 2021 18:19:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E3DC605A5;
	Mon,  7 Jun 2021 18:19:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30EEBC000D;
	Mon,  7 Jun 2021 18:19:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C9BDC0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 18:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34DBC605AA
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 18:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 34K1jYCSXgxs for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 18:19:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::626])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E2760605A5
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 18:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWv/O9YcqvNDC3pxa/ql8q4+H1lJGy3Gd1/Scb5e8fc5PIYAK6GwRl/b/+8sLUFRwyCq5Synhu+rgxqXwc6wp9CvQGdPNfk820OhGZRYBQAGwPTbsnRP2zki5tlfhgnPlZ5w9zz/zwhqikDHvld+p8q1IvzUJ96EAELRn2+OTXDfr2PiBDoY2iJPr/jorbk845wBuBFb1tv9ClYkeZiePIUNoDs9rEdp0qPwdc6BulLpuLvA/YzyCzEWoy/SNfOFUC8NIsVWXFRRTjG/G2CT5+oqzXmatuv6rm++a9eBI0uZocpjyXn55hkdFg+oVEipfplGKT5M76QO/c1WHLLYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbTWaJFdCdrDzSdSi5XGrgtZ9SdqmktpsJXAXF0LPzk=;
 b=VQZ9VZYttomKSD4iJr93895vZrUCfTet1jo1Xd5Xu+NOz9mDX7gGI5LVi+7TJv/vaVbEZdOqsfRp1pRdL9nqVtlu/YMNfrkQkOtMWEGhg6/QsJjDgiTtDmo6xt4uR59pK6wN1QYuPoVA1EYXULBzSf+XHpxh2VvgL00NnGdBal9dMyb48w/Hox+njscrZUh+hbA78ES5A28GMpnpGAZvJHGxRqJdMLINhnbCD3tprWrGIENqeAHkcBDav74CFXzzjHTBguQE8o0nTyqxFskXmbjuBrjNlYHoiZ+mwb5D8/sBJlLgZXas0TWRD21bmmmo6G2bMGWHX/W5cTThOvXbJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbTWaJFdCdrDzSdSi5XGrgtZ9SdqmktpsJXAXF0LPzk=;
 b=B5zxUSQ7eOdY0hXjuJ1AsLSFUthPqYrnzHqAMR7tvxv6lrWLh97b7w6qBRie+rwRmtwGvL5qObr+SAV8aM5vr+LfMiipLUdzTAlTAsA1RU53DA3fhokcf5QX2yv/JK80OJW9QojGazMTQgSmmOd3IKnkD0PsXEgp+0T+erZa3HnEWmmN0otUMKE4VcXzFya2VByYBjUvJf7Uy4nI8Rsjmi5yIaRMsIFNoseJKCCXsz0gAEd1H5PDeH5a6jAI488FD7jMGNdmnuOoTqhEUrq4xS4LHYDCxNX2tBjuN3Cy39gEX9rDo3Hn6Tnxxhsp9CMLcOSzWI5kYzWzNszJqfDdDA==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 18:19:00 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 18:19:00 +0000
Date: Mon, 7 Jun 2021 15:18:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210607181858.GM1002214@nvidia.com>
References: <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <20210604152918.57d0d369.alex.williamson@redhat.com>
 <20210604230108.GB1002214@nvidia.com>
 <20210607094148.7e2341fc.alex.williamson@redhat.com>
Content-Disposition: inline
In-Reply-To: <20210607094148.7e2341fc.alex.williamson@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1PR13CA0161.namprd13.prod.outlook.com (2603:10b6:208:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Mon, 7 Jun 2021 18:18:59 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lqJpy-003P4L-UY; Mon, 07 Jun 2021 15:18:58 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e23fd459-eb3f-4af1-7632-08d929e0b8ab
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53493D1524D5257E1114ED96C2389@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hXVdHRIbLFC8ofd8TSAcUkJNuLtZpAD+3U9nAPDw/jw6W25/ohvNTE8hezodYY7wa0F/cc1sP1ftzQKICL3GmlEV5foDC7yvSdB1ZMHNxFYn8AYt9IzJdGiTMklCw9jAiX4S2EXGSyqVZRsxWjK0+SkIlc6BlnCa9MZM03Un7aWqHiCiIswjKi8KxIRM09BAOkSJ6rpayHiwmnlc7Zuakt+AYy/+qxUCOEFqA0vh9XRWdjTQfMb+vzHiEOYDIilqKwBulfxP4Mf4Im+Pq/S+r1CHjoD1ziu39hHES09cRIDtMfQt7p3uoJ2fhcev9QQ2L/Sf/24bUxb6s5w25xPdfDfe9Dj77UNd01qZ/jm3AW1iRyncrYzSVOnvxHZtb0HTuHFSB1yPH31TzqhSh50oKMPVKTdAmaZzp2AzhMSvOUvMEiRYYd3XaV3EycZX/hdrzkQ/+7owmcsdgVsy0tQ0mHyuVe3M2JgM7O6d1uuJq3Dt+yYSxySRNoEuVVM35P2tJNRZK2XdxcYy7NMV0kLXdcAHPntJn6B5YTCODyCP/Exo0lbrYT/In8WwG+UC8PhDA+08+tO+GL5Pea3t+UXi/n/NL14bLg4Nr5EHt0hquY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(5660300002)(54906003)(66946007)(426003)(38100700002)(186003)(4326008)(83380400001)(7416002)(9746002)(9786002)(6916009)(478600001)(1076003)(66476007)(8676002)(33656002)(66556008)(2616005)(36756003)(2906002)(316002)(26005)(8936002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1ZOEP7ZGeYL7hEkU747jLciE16cntiUFGSMi2bgnFiTyFrc3gkHzx7CBQLrf?=
 =?us-ascii?Q?dziRipP1ugIIAa42uXYQ1GrSLd909Mzu6w3Cvb4ycOo67No5484UMVNudawZ?=
 =?us-ascii?Q?Bu/Y9e6dXdWdD8ODgORsSn3iErCQoSLqAZuKCrv/d4gpIDz3C7s0nwIjrFpj?=
 =?us-ascii?Q?cjJuEkSqYiQw5oIjqMl7ljcNV2RiKBlUXJkypd8//5OpdcaLMbclrI8nOJz/?=
 =?us-ascii?Q?OqKiax/5xqwgSy4+3EZsMYPMChw9DQiqqqGgilHUVl7qDF0Utf7Vj25BEiTu?=
 =?us-ascii?Q?G9UjCdYNPaFd2DbBAi2SIaRITLoNxLHxhHWcalEHr7ecYF2YXugv56YcObpd?=
 =?us-ascii?Q?L9RHiyPfDj9UqCqhltiDoZwzIwPjzkCHOfo27qyjuDq9vookBj7ogdoQvtd5?=
 =?us-ascii?Q?imovBVQZ/5FlHCBOL4Ozw32S+1gyTJ0bs5jTtRC6wBAXTnVBL3BFjNjVNAzt?=
 =?us-ascii?Q?sKwxRvKN3r3pxrqWWnBUQNxp5929UVGaO1iJbPHh8ACkfKuklNa7vPquP5VD?=
 =?us-ascii?Q?Cgjqctg+5j44Iq7UzNfPH5kCyU18RZpPAdhBJtjbm6ma5GDBzMyBdY/9q+JA?=
 =?us-ascii?Q?DoPMbmtmxrNUNm7/7Mz3YOq/Ew7mkbGFEJYUWiNE0Yi+YFv11zo99BpMrLIU?=
 =?us-ascii?Q?Spt/Lsp96n1X/TpPnFI4/YDhbCVZKhHJn0HOE9M1eMef/U3t6VZ9c0mbw9PB?=
 =?us-ascii?Q?IH8RFGcRu/JpuXr/NtwgS34aLngoqZyddisWsMfN6rwmEZfIbJ9y5IOCgQS9?=
 =?us-ascii?Q?BBLuWlfmKdvOj8U/PRzs51V9GS9XWt79phJupT/qstAmHMWQcA+MsOnorkup?=
 =?us-ascii?Q?5qpoDsrdQGz6IkdaU5UIzzX6zOawxco70X9G3Ant+gl8PvZveaXUpVah+/hy?=
 =?us-ascii?Q?6JfORbsgm1oPeuJ9O3zbH6mYwTRKYnUG3EVde8i2NLkRK6I6GmIJ7Ac4eOo/?=
 =?us-ascii?Q?ii4x8ryMeAHe0Xu+kim02iBOHST2FFkCW5M0xVvMMjAZ8rXsrlCcn9L3+kyx?=
 =?us-ascii?Q?NrWVi45C1DBeR9A3tba6Z+5/ywNzdCPmFJZlSYPPFetSs2CMgu7U5pS/qIrK?=
 =?us-ascii?Q?KdlL2CTu6tr9sJsBbPXUZWBF0kYkKZvRV7l1KBs5acZOZ11zseisUrfgesVk?=
 =?us-ascii?Q?aDMN7Ye2XVPIs2zVjl07Wj2YSout4ykykSFcxI2naNOOmAZrNe/1WtAJLgB/?=
 =?us-ascii?Q?Pk0faHGJ7veKvjiXP1tKZJiHlnda2aW7fsvgymg8BSCIGkAa5LjbEOQaFjlT?=
 =?us-ascii?Q?Ni7p8KOBhUdDNyH9I2TXBr4K2p0XtzsU+HvqzTuV0g4TbQquTLSTZvCVgJlr?=
 =?us-ascii?Q?YDKmg521lNQHuOmIHutTBCuR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23fd459-eb3f-4af1-7632-08d929e0b8ab
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 18:18:59.8587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3FpG7oByYXjbNpc3ApYjDC6ke8XeXMHgBL2Gc9ZeKpm1J4vSIm0bcKwDOpiN5gW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
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

On Mon, Jun 07, 2021 at 09:41:48AM -0600, Alex Williamson wrote:
> You're calling this an admin knob, which to me suggests a global module
> option, so are you trying to implement both an administrator and a user
> policy?  ie. the user can create scenarios where access to wbinvd might
> be justified by hardware/IOMMU configuration, but can be limited by the
> admin?

Could be a per-device sysfs too. I'm not really sure what is useful
here.

> For example I proposed that the ioasidfd would bear the responsibility
> of a wbinvd ioctl and therefore validate the user's access to enable
> wbinvd emulation w/ KVM, so I'm assuming this module option lives
> there.  

Right, this is what I was thinking

> What then is "automatic" mode?  The user cannot create a non-coherent
> IOASID with a non-coherent device if the IOMMU supports no-snoop
> blocking?  Do they get a failure?  Does it get silently promoted to
> coherent?

"automatic" was just a way to keep the API the same as today. Today if
the IOMMU can block no-snoop then vfio disables wbinvd. To get the
same level of security automatic mode would detect that vfio would
have blocked wbinvd because the IOMMU can do it, and then always block
it.

It makes sense if there is an admin knob, as the admin could then move
to an explict enable/disable to get functionality they can't get
today.

> In "disable" mode, I think we're just narrowing the restriction
> further, a non-coherent capable device cannot be used except in a
> forced coherent IOASID.

I wouldn't say "cannot be used" - just you can't get access to
wbinvd. 

It is up to qemu if it wants to proceed or not. There is no issue with
allowing the use of no-snoop and blocking wbinvd, other than some
drivers may malfunction. If the user is certain they don't have
malfunctioning drivers then no issue to go ahead.

The current vfio arrangement (automatic) maximized compatability. The
enable/disable options provide for max performance and max security as
alternative targets.

> > It is the strenth of Paolo's model that KVM should not be able to do
> > optionally less, not more than the process itself can do.
> 
> I think my previous reply was working towards those guidelines.  I feel
> like we're mostly in agreement, but perhaps reading past each other.

Yes, I think I said we were agreeing :)

> Nothing here convinced me against my previous proposal that the
> ioasidfd bears responsibility for managing access to a wbinvd ioctl,
> and therefore the equivalent KVM access.  Whether wbinvd is allowed or
> no-op'd when the use has access to a non-coherent device in a
> configuration where the IOMMU prevents non-coherent DMA is maybe still
> a matter of personal preference.

I think it makes the software design much simpler if the security
check is very simple. Possessing a suitable device in an ioasid fd
container is enough to flip on the feature and we don't need to track
changes from that point on. We don't need to revoke wbinvd if the
ioasid fd changes, for instance. Better to keep the kernel very simple
in this regard.

Seems agreeable enough that there is something here to explore in
patches when the time comes

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

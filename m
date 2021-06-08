Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F58C4743F
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 19:04:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA024611AE
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 19:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA024611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F485401B7;
	Tue,  8 Jun 2021 19:04:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d82a-oE4f55O; Tue,  8 Jun 2021 19:04:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 312C74017C;
	Tue,  8 Jun 2021 19:04:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C4C5C000B;
	Tue,  8 Jun 2021 19:04:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8E0DC0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 19:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C872D402AC
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 19:04:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QNxMiBnytXrV for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 19:04:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 996A840280
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 19:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki/the97YEjDhmRnD07J+e8DvDJLszW9GIxche50Ic4iwkYm/o1OB0q5wdqkQzzpOLFSoScOoT1C0/ibCBfjG7Jd95rcm+X1Sb93SEBZKHDLKmgZTQNK6S2uUumKbaf3IVebitUBUNr0gs4Q1g/BIhaTk9CzkxR41vYB130IjdoWw7bjpcGHJipIRtfZdDBQ3Tl90RYUse64nX50zcWcixYxh5XUIsKzyFSHoXe0LjHtSbiNicLHK3vAC5qzFUA0GefOd17Soh1NKpNWF4DU5NMjqR7iA9pUsSds+3pL4Fkrg+jxCFfrbooDBwXcPE1C3G7N8yXqw4a1EnVd9stlxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaRJrejWbXp1V7Owx6wLj+WWWTWLRq2muZfFSIGBTsE=;
 b=DceweHBhs3Cj2jEctIXROEV/gbx7nsjXN/LpVV6tYh6iHXrv8dgPuXu2XPrxoDcz4k3DVeVt167BiQOYMz2C9HPN5d5jhjae+iswVjkVHHS+VIJYGXeBsFUvhNdGL4ck2P9ar2XgO/b/HDxIsPCPYillZ5hLqQReKn7vdEQ0uwrj7iHYAuPq3jADB0H87l/1Xv0CDsbK02FpTNSjgPtzgRGk+5DnQ7PhKMMrB1a1qWaFA49ZXRTekQtmAlbS1iWq2QkkHDZ0VSj5rpNC8ogk4yC1OptzTSqGlF/+23NVQ/f+7Mio3yjt+Mob7qzxSjSm0mCraLwaj6pcdJjVacEMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaRJrejWbXp1V7Owx6wLj+WWWTWLRq2muZfFSIGBTsE=;
 b=bXPB3U6kPVzU95ed1sWunPEbwUrt8Sm3yG3JyAtD1vtKaxVI5qvRJdqX01uL5LUc49LioWBQxr9jb8HBY0yppeQ4maZ9xFPJ5Yhxob96Ikeww9HfdP8c5LYc7iiHKVrgAfGwa+iT6wzVQBZDGs8rfMwf4OiAZiQv7Dal+QSsvJ42Clp7mqg3Fod3MfzPn2KCxTFGu1xwSTCoeva1tG7tP4nFrqw0fLXuRBKZ0zgSwIFNpLzEkZ9JxScCpXbuSk3TVjwlkC5Jwg9HB4fJhwp9v/YjEugQaX47DB/pWZae8i/iRs5jLTzHGONeeBkgDpBI4tELlhMkZfD9bHulgYNiIg==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5522.namprd12.prod.outlook.com (2603:10b6:208:17d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 19:04:08 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 19:04:08 +0000
Date: Tue, 8 Jun 2021 16:04:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210608190406.GN1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528173538.GA3816344@nvidia.com> <YLcl+zaK6Y0gB54a@yekko>
 <20210602161648.GY1002214@nvidia.com> <YLhlCINGPGob4Nld@yekko>
 <20210603115224.GQ1002214@nvidia.com> <YL6/bjHyuHJTn4Rd@yekko>
Content-Disposition: inline
In-Reply-To: <YL6/bjHyuHJTn4Rd@yekko>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR20CA0056.namprd20.prod.outlook.com
 (2603:10b6:208:235::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR20CA0056.namprd20.prod.outlook.com (2603:10b6:208:235::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Tue, 8 Jun 2021 19:04:07 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lqh1C-0048fX-Lv; Tue, 08 Jun 2021 16:04:06 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 704ecc31-7e5f-4f5e-1415-08d92ab03132
X-MS-TrafficTypeDiagnostic: BL0PR12MB5522:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5522B51116DC002EAB61614EC2379@BL0PR12MB5522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EcV0+XadaKWdpp//KiCs3ZXERq45FECPssCOt77biouvpoM0VRcdhRwbLDYxwt8m2MdCd3GLkuyruZs9nMzwRNRAvHP2eE75Q9OqZEGNxudSh9gkvNcZhFGyHdUingihy6L4Bwh+j6F8VpVHonxUc5VaXdhtza/lEDpmluPf0xlWk/VAx5I4i+aFV/WitKdXJDgxAgaPYfznTJ8MXw/pQOQuRHwcepzp2plvlkP5Pv+KEDSFoovsrhnDzpLQvYmeaqDX1EUulDiXUbYRlw7LHWR2YskcIh6b4imYFXilOrvNliWqXeWdyKGqjuqpz+Zvfbevzm3wReI9ZsU/I3+HVy8oNJ9fYCB235eCtC5x0OfQ61zWE6V/taFNLZ65N0jwS9LE4QYFkcGCQE0uGY2V2qwwGXT2g13UFFQpY+tzaYtR3N1JM07yQMD9u6Ea2HPwTTSNkOAMMDlegxc+7CVxl9NEnSYp7MKugMenbzNf+7RhlAHpX/hDn6m6j4bbqLixBuqxLqIu3Y7hHmXCFoer09EBvFM8cMryNRiBB1+PdJU4sgREHlOUYDHyC0/sOuy8Jx03SdRkWNgC1ackdWZ/5OpdxpqcGracVJD0wKXBTmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(8676002)(316002)(86362001)(2906002)(36756003)(38100700002)(33656002)(1076003)(8936002)(186003)(6916009)(54906003)(9746002)(9786002)(2616005)(478600001)(7416002)(426003)(66946007)(66476007)(5660300002)(26005)(66556008)(4326008)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2VVbYXngpJbBN3w0g/3DJ/8gZvaQJoU2Rrh0JS7qxmVxZztwPTi/I3siHBuV?=
 =?us-ascii?Q?ySFNWryNrh5v2g4e/JGQNar5ulysZSLHILxBMmcAE0fP1ox0BbpHJwuwjK6L?=
 =?us-ascii?Q?oNr28/ah1Z5Gj6jQwY495mlJYpa2vox0belg5/qvUmvBF7jjxghSdU3sys/Y?=
 =?us-ascii?Q?MvUnXBjVPoQ0PbhWYn9Z09mt5eZl73C6g1EO66rlfbBihkOBWL19xW85Vqtv?=
 =?us-ascii?Q?1qfZa2crOzafhv9cXlv631vbJHvTODApTAY4nqXliXoNJjj2t5ogT4tIa9rQ?=
 =?us-ascii?Q?p2oB68RQCxbszpAEOW2RBLfnnEO8RSANyjVryIen0MEVlcYp7ZYntjakGjOY?=
 =?us-ascii?Q?RE01DLj0BleNO9clNft23w/PzXOdZyefVhQfjmMYosIE2+2PVyb4Kkc3J8iK?=
 =?us-ascii?Q?ZDxHZeqY7ODHXaZzEa59uQib85pzkxVM5+ApXg/DHJfhzGNMEdGa12Y9FC4j?=
 =?us-ascii?Q?ou5OyknimuixgGJ5yqGgV5n8w5irnLofHXQabwzD/Fm9v4mZxD9nVTn3lfNu?=
 =?us-ascii?Q?FcWElBxUtbGTAOVNk+GrYQirvye9BohikWdw7Kdv0K1l7ZquDcC/uEe5gzrR?=
 =?us-ascii?Q?1hqblcQHxGDxBnmT3j0dtwwEKIigRCCphbUyZwQcnSb94Afa3BxWweicGKT1?=
 =?us-ascii?Q?PoxbeXM3hXJaU2sGXERaaY8xUpZlQ4psNJmq4glV2y/6RFRsc1plKWgbaqMt?=
 =?us-ascii?Q?agA+/KE/CO8mUkjhHgifx8fsG0Vq981Tl2G4sgfUSHeQIa8MF74VChvQa0tZ?=
 =?us-ascii?Q?e942b/mS5fY8AoQnKF+hYiMzW01M/zcVmWEZZl8TMzCgkl/bqiw9YTi/pQwc?=
 =?us-ascii?Q?UXyVq1L/AJXct8jRm1cps7eUmCyuSXFQfskD4yzpx1r7sWYm/9UJfAhFFMCw?=
 =?us-ascii?Q?Fd7F5MJV6KghxE25UA8gYsPtm1OzcF5oRX1MZ9LjcRQf80yV4/IjhKfQMlQd?=
 =?us-ascii?Q?cOZ4UTTZG9HSSKRe+49uRAQWhN8bD25+ct1Hu/5Rb+NlDqtBuCHUtRfkqewL?=
 =?us-ascii?Q?grs5ZnX6jE2u0qtKIOgTPopYElpFVfcdL6DNvNR58cGP+jdekhESFVZTbjKs?=
 =?us-ascii?Q?KCU+JSUJb8GHlNf+sJUzr1+c5FLOFHo1jfejKqT1HUYFG6fg1aHRErQgNmxE?=
 =?us-ascii?Q?eS/OsQI+8/DdrCZz8ba3CfJSb8vExRjCSnVQZAgiVbLkQVcCfUomQ7CNa2WJ?=
 =?us-ascii?Q?ih1meTCdOTMyUt1gpKeAwwd64uzuPCzWL+o55f7hhzLkzviQe8wV0NvtOisj?=
 =?us-ascii?Q?wP2fUQv7Onv4oMHNk89AoH+TaF5IQW5Gsk8NxdQXcisSK2aliwzfeEuRsiiE?=
 =?us-ascii?Q?+eZ4hrcLcQ3bZAJbkt5bQMLE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704ecc31-7e5f-4f5e-1415-08d92ab03132
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 19:04:07.9981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecwlEwl6mc5xvFGyYcZ0B0mVHqCS7BFWqeg4Yd1Tm3FZGnv0Ft1sfsoe4Ktdrq1q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5522
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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

On Tue, Jun 08, 2021 at 10:53:02AM +1000, David Gibson wrote:
> On Thu, Jun 03, 2021 at 08:52:24AM -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 03, 2021 at 03:13:44PM +1000, David Gibson wrote:
> > 
> > > > We can still consider it a single "address space" from the IOMMU
> > > > perspective. What has happened is that the address table is not just a
> > > > 64 bit IOVA, but an extended ~80 bit IOVA formed by "PASID, IOVA".
> > > 
> > > True.  This does complexify how we represent what IOVA ranges are
> > > valid, though.  I'll bet you most implementations don't actually
> > > implement a full 64-bit IOVA, which means we effectively have a large
> > > number of windows from (0..max IOVA) for each valid pasid.  This adds
> > > another reason I don't think my concept of IOVA windows is just a
> > > power specific thing.
> > 
> > Yes
> > 
> > Things rapidly get into weird hardware specific stuff though, the
> > request will be for things like:
> >   "ARM PASID&IO page table format from SMMU IP block vXX"
> 
> So, I'm happy enough for picking a user-managed pagetable format to
> imply the set of valid IOVA ranges (though a query might be nice).

I think a query is mandatory, and optionally asking for ranges seems
generally useful as a HW property.

The danger is things can get really tricky as the app can ask for
ranges some HW needs but other HW can't provide. 

I would encourage a flow where "generic" apps like DPDK can somehow
just ignore this, or at least be very, very simplified "I want around
XX GB of IOVA space"

dpdk type apps vs qemu apps are really quite different and we should
be carefully that the needs of HW accelerated vIOMMU emulation do not
trump the needs of simple universal control over a DMA map.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

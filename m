Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E3BC47097
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 12:28:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D807613E6
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 12:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D807613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 580D84059A;
	Thu,  3 Jun 2021 12:28:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4oU6qUQHO_dI; Thu,  3 Jun 2021 12:28:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D989404F5;
	Thu,  3 Jun 2021 12:28:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE0CCC000D;
	Thu,  3 Jun 2021 12:28:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE2D8C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 12:28:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A829B83E10
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 12:28:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GLkwXdZS87pp for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 12:28:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 05AFB83E5B
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 12:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBMn7RrXlC5Mfiu8umPLn+W0CzI8oLE/EyfK1braFBLSzg+1sc6tcl0KEw2FOfLEimSMpoTK6nhNtRta52WujLLZqRo2Cxw1QotSBtG4Jv7eUJ2kiyO7EGvRUqPV84n2EFvbNUYuTJpXUIQkgAzxvtySro9X0H+3KLRLgbab34KLuNVKOryyxDhVFmRN3o6IH+F55Y9kZG5ExZC39daTFSuyrncPN/WCKTxIuaty35p5ZBokFs0ufUysydDtBbNWiifmS9bCzZhgCIz2UTueKgtZj79rBZgbCt89d/WnKMfVucTzWQ8/T1slk1NiwLe1IcoPHVQN8D8ulQUJYusHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4zlC7X+w3OjGC+NY8bTSKJ7d7oNdsbrHvuQ/SvvpZI=;
 b=GLhk3mtdydxLVBbjc6zuuF3twsxxXWh8ThXYaYKTZommPaz7lGR+5RyUjaZkSbdqVkTRvNM/OytNciRNp2MxHh4Hu8cnUu/PGSwjrzCQmnS8Ujvd9spCYJMjhccl/p9kuaNTJ9QG+3eWGuU6eMjaWFi6W3p2A/Vpu5O2/UTEg7bvLCmMfvqijgk8/15mbUy83jaLqmFv7hyBfEQgodTVFIDIp0aCMRWFjn1red1flWKVTX6ISI/W9xy+6DB+tC4HH0hZ65YC55dmLdtV3inrtt8+ZqUZp6Gd+CwgkChcfrQDzRpDYIqh/Ub2yOCLSSOX/0Qc5UCoG+6niI0Xp7lO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4zlC7X+w3OjGC+NY8bTSKJ7d7oNdsbrHvuQ/SvvpZI=;
 b=XYggWO0wc8uNg5FWEmYD8wzG339obVZ0+G2R9JqwstoAcVs6COP00p5N8y4Sho+BscwKJUkV651wT8ibf3F2TTs2kfm+ltvQflke+inEErnE9phtY6H5/EGp72SVDdXUs0ZeqFtLjloH99wyb899Ew04TUV03WOHmQB9UZndF/CKUk1WUdP9pVqs1Jc+LiQcMePDYUO5qouTw4Uv93b/mWVje5xn20E9U/4Hrmz9gDYIL98J7ebh7cWa7S5oRBUqXtEogI/QWLhu7f9QjAdkDdOSRKymwHXly1AHKeoE/gAO+IqZ96GCnRK6tk/vd3qH945lgyk7bMk6XeT6VdpcaQ==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 3 Jun
 2021 12:28:34 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 12:28:34 +0000
Date: Thu, 3 Jun 2021 09:28:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210603122832.GS1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com>
 <MWHPR11MB1886A17F36CF744857C531148C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601175643.GQ1002214@nvidia.com> <YLcr8B7EPDCejlWZ@yekko>
 <20210602163753.GZ1002214@nvidia.com> <YLhnRbJJqPUBiRwa@yekko>
Content-Disposition: inline
In-Reply-To: <YLhnRbJJqPUBiRwa@yekko>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR01CA0024.prod.exchangelabs.com (2603:10b6:208:71::37)
 To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL0PR01CA0024.prod.exchangelabs.com (2603:10b6:208:71::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 12:28:33 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lomSe-0014gZ-Ts; Thu, 03 Jun 2021 09:28:32 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06cad259-b987-4ad7-afe8-08d9268b1a92
X-MS-TrafficTypeDiagnostic: BL1PR12MB5334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53345B3E8854AFB54A54D5D9C23C9@BL1PR12MB5334.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMaK960a3T/YfBNiVRAaB4ycdr/xgkVWICkq6XvENBvdPf6z5cEwhF/yp3c0StQwuz5dIw2fiqwQTgiw3MRvXunbb+r0XVk1CbhIF8p+LKKloTeDLvjqA68ffSEvJw320V4oDrdXC7waEbRv9WQrE00BhK31iQh7P4LObxcm3DdwH4K2eTAmZkfqVZ76TooFf3F8Cs+kHARsO2PRPo7neGCc84tfCk4Vj/bBNFZZJboFgh6jeavj5goDuxCZpATl6zuAFw+UF6w2KyxjnJvJn12rXcu7SDWy37mLY6jTsqac0g4ufVRkQxXr3GZToZ6fPyPCVkxmudrJCf9//UEF+BeWJZ5nv4JG112mYhU/mg27NtRntq7V2a/MYpCuXlnATbVDX3stbVXRmFYnI8qLSxMT3EUclMaV4XQTnkNTkDtHcyshi83xLMVPRhJRLVFJNCp1PG0nz3nzTO6kaarqT6gCzuAVDmp3/jl+W4khMVCqjXVqM44L7/x5rs74QLd8V/MywWTPXM0xtgAuWDTRGULU+HRXDk3cI/Dvj84N7qE8yUN1lbZOjKJXdSxUVHXMOCsEEpvLmiTUIDasHRXmr+Kw33YqC7oEbKkfgZvkDwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(7416002)(9746002)(6916009)(478600001)(45080400002)(4326008)(2906002)(9786002)(1076003)(38100700002)(5660300002)(36756003)(33656002)(186003)(26005)(54906003)(316002)(66556008)(66476007)(66946007)(8676002)(86362001)(2616005)(8936002)(426003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3BU233xA1LCRMQSndn5fYPidR/Z5KizFFzEDZWkVCOQi3DPmbSxszBW79rH6?=
 =?us-ascii?Q?TSWJNpDODui19842xXSawhDUHT0k8e+Le0tch5lBytFRwohOrnvvY97ZT4iD?=
 =?us-ascii?Q?x/mQX7ODKlmH+9Q1QlnGcHDdgE4oodijflNvb6JX4uci8zPMeSv2SIuzk+n+?=
 =?us-ascii?Q?GkDMiRYzaoh9IT50e8lEhW3GYHfIDn+dieyTHpJiRkRq57fvAkrC8xwHNEJP?=
 =?us-ascii?Q?XJBt12orUA5NbIpC/XsmLHWnxyxCSt2ofrol5rbTyBj7/RWr/Ez+PssGbEp9?=
 =?us-ascii?Q?OLdmKgtmPwKzIM7Km0ZQt/peoTSZi5/2E2mjego43NdWGoYSNuaHsmzgBXUF?=
 =?us-ascii?Q?BucCW+2UA/UxWwQQRPWTnwQqqmbXUXg/JyLXYaquGZLr0NlQIPeNYwLxuRxQ?=
 =?us-ascii?Q?bPAOndTUMNKELcuSUDtID5yFZ4YyYCi8PDqo2fA4t8WKetFxkL84UYMV0++V?=
 =?us-ascii?Q?z/Ge6RBM8EycoJrOSB/fFV092yvU64Lv9RfCtv4z5kyqW4HqtwZKIwffetIA?=
 =?us-ascii?Q?DDDV9ZXfhuMEMdKfCQ5LyBxLPdhIiFlWFG6e8hH0L0LHXI1xO7upKO/h/m0g?=
 =?us-ascii?Q?2100U4hFCET/j6+YrsyGptibdXcauDa3t4yIvK6t3iUUlXinoeDE382hOZgU?=
 =?us-ascii?Q?2HyyOT/mWDv/VEg604YzN+CkW6bvPKhZVaJ/JC5iDrSy6l8RHGt7ZmXN57Er?=
 =?us-ascii?Q?xSouPzBFL6Xf7excF94fFpLsO9FruaHUcj2L4QCWe4gWjS4CLcdxsDKXMbhL?=
 =?us-ascii?Q?FIudof0vkBAuCE6SF93+Xn726nKbBqe+A/LtpiOuZ7RqvaAdcaIwpAG2ieAe?=
 =?us-ascii?Q?ZaFNgAHpXnRAtB2cofSwi4Id5BFVAemOnuSDtsUlztexuSXFR5fSvhHFybgD?=
 =?us-ascii?Q?bLmP2cfuqKuxyJZaaRkXFXGOia2oUOMPfRLe3l+sO7l0DT4Y51DqryO/HYyb?=
 =?us-ascii?Q?co0dnyw6IJWW3CwUhJ0SeWiFzA/MR20TFxYlDl70YR9Dr76K/gi/fHSPLDhL?=
 =?us-ascii?Q?TuObU9jrfj+rZLq7aCq/VNH7fDm5aWudyjtI/WGowBkzAzSHfuDVfYZVwGfV?=
 =?us-ascii?Q?fZKjrXKvV7yf1PODXCKOV/ZrFIliGPtJhkcMX7gDtd5+BW47RwC1AzViGgY/?=
 =?us-ascii?Q?xfO9/u9F2XFNhkZnfys/rT9nLGXSB/0xSdobTozNRST7AgYZuaLETxQMlFl9?=
 =?us-ascii?Q?1jORSuTAQP6tmRW2jtkNxMrty+jSkniBDanQucrmOLvGADyWY6uf+QlOxpKY?=
 =?us-ascii?Q?1aTOmYyjKyad+YiWStQ+hgPHasRFnPVTBp2cmRyu7sMtsEmmYbdn8Wn1zGX6?=
 =?us-ascii?Q?K4XawrhBQPeBOIYS7aS5yS1E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cad259-b987-4ad7-afe8-08d9268b1a92
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 12:28:33.9916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgbOgGft4ISMzUmwCB9GH42PORH9uA60OdYYQh4r6EZDupYykJcRp9hmPegr62+R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5334
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

On Thu, Jun 03, 2021 at 03:23:17PM +1000, David Gibson wrote:
> On Wed, Jun 02, 2021 at 01:37:53PM -0300, Jason Gunthorpe wrote:
> > On Wed, Jun 02, 2021 at 04:57:52PM +1000, David Gibson wrote:
> > 
> > > I don't think presence or absence of a group fd makes a lot of
> > > difference to this design.  Having a group fd just means we attach
> > > groups to the ioasid instead of individual devices, and we no longer
> > > need the bookkeeping of "partial" devices.
> > 
> > Oh, I think we really don't want to attach the group to an ioasid, or
> > at least not as a first-class idea.
> > 
> > The fundamental problem that got us here is we now live in a world
> > where there are many ways to attach a device to an IOASID:
> 
> I'm not seeing that that's necessarily a problem.
> 
> >  - A RID binding
> >  - A RID,PASID binding
> >  - A RID,PASID binding for ENQCMD
> 
> I have to admit I haven't fully grasped the differences between these
> modes.  I'm hoping we can consolidate at least some of them into the
> same sort of binding onto different IOASIDs (which may be linked in
> parent/child relationships).

What I would like is that the /dev/iommu side managing the IOASID
doesn't really care much, but the device driver has to tell
drivers/iommu what it is going to do when it attaches.

It makes sense, in PCI terms, only the driver knows what TLPs the
device will generate. The IOMMU needs to know what TLPs it will
recieve to configure properly.

PASID or not is major device specific variation, as is the ENQCMD/etc

Having the device be explicit when it tells the IOMMU what it is going
to be sending is a major plus to me. I actually don't want to see this
part of the interface be made less strong.

> > The selection of which mode to use is based on the specific
> > driver/device operation. Ie the thing that implements the 'struct
> > vfio_device' is the thing that has to select the binding mode.
> 
> I thought userspace selected the binding mode - although not all modes
> will be possible for all devices.

/dev/iommu is concerned with setting up the IOAS and filling the IO
page tables with information

The driver behind "struct vfio_device" is responsible to "route" its
HW into that IOAS.

They are two halfs of the problem, one is only the io page table, and one
the is connection of a PCI TLP to a specific io page table.

Only the driver knows what format of TLPs the device will generate so
only the driver can specify the "route"
 
> > eg if two PCI devices are in a group then it is perfectly fine that
> > one device uses RID binding and the other device uses RID,PASID
> > binding.
> 
> Uhhhh... I don't see how that can be.  They could well be in the same
> group because their RIDs cannot be distinguished from each other.

Inability to match the RID is rare, certainly I would expect any IOMMU
HW that can do PCIEe PASID matching can also do RID matching. With
such HW the above is perfectly fine - the group may not be secure
between members (eg !ACS), but the TLPs still carry valid RIDs and
PASID and the IOMMU can still discriminate.

I think you are talking about really old IOMMU's that could only
isolate based on ingress port or something.. I suppose modern PCIe has
some cases like this in the NTB stuff too.

Oh, I hadn't spent time thinking about any of those.. It is messy but
it can still be forced to work, I guess. A device centric model means
all the devices using the same routing ID have to be connected to the
same IOASID by userspace. So some of the connections will be NOPs.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

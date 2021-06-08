Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B981C47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 19:23:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A9861108
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 19:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A9861108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD3434025E;
	Tue,  8 Jun 2021 19:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0T5hD16yh9-N; Tue,  8 Jun 2021 19:23:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54D9640224;
	Tue,  8 Jun 2021 19:23:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30932C000D;
	Tue,  8 Jun 2021 19:23:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD268C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 19:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 920774023E
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 19:23:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YtrT61lslKmO for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 19:23:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3041140224
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 19:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQEPZ1+Mm3JSjZpU4DttiKm4v26iwUu2XXfe04+7Uao8pLpINvEIET8tppZKK9FJ45FKHbzYhvtGZkf1A0YSohgQA4MsRUYkyBvvVXZgwnfC0BYBFWXH8iJBR5MrQRAbSKmRIuVXwHmQDcRDJdmL87NBW8jrbkyPGtxsmK3RgNFEAN78W7VBfOi9MB76cjLL/tPPHBaZupM8pwo0V5b9TwbiPKPV/V/8M7rDV6KrwqQW9aN6c9B8HhAQfd3/rt2VmybW5I3A4n0H6qqn52DCT/prOGOAgzrq5zE6ftwJmQiZ+vySm1nKWhrF7++GxPjFUCexkTv5SLwd7S4TAieReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DayybFusWT9CghUN7Q5EzYozSZIJmFEtcHdYt3of4fw=;
 b=XHBC1/FbVEEKcQSajF0fWJYplW/50VO4rhEtDU6hABma6aFSKIcgQ/NHGbFHq22Ivg/eMgLAg5M85E9n8CNCR692LqiX2uC/cUSo1CCFnyuK6tnTvze6LLhQo6YF8e0K1bOauifVpzuOfyuRA2oWb4qwv18zxfvjrD6TJBPZM4umlTaExuVY0sHjziejH3KZbLVf9JLTE0rHzqeM5LwbI0gMNTNatqeept9Et63h5G1yB062ztm4SyDVYZwq3lHHw/98u2xZ1VpJtRLZNzdDDvRWrPQUQ7Ku4FaQmCL2N+f9gN/DxJUHurMVAHyTpDcsp0qtY2HYZfm162K9YDb0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DayybFusWT9CghUN7Q5EzYozSZIJmFEtcHdYt3of4fw=;
 b=A5Ca5RQ//y5avBB7Zwd9Qlzcp55NJlI5RX5W7/s57jHLBCNl6L7FKn65vTJfE6ZxzaHOa5o2sMGoZuLjDbS94P0hURtunmlWwNImWnObjc3xgeqnrgeoD4TPyGuAF677l8B+EmEf3XNl/dino9TLkIJ4qGZxjI1J1RVdu3aE+SKUOgRxN5sEj/TESrnC2zFt3iZqVPFo6W4C8IJPAKhy+cnUFkPM/LYHnTBPkeimt30ue2Ypa9L61Hqvi8l6JPBjvunsv66w7xy9PaQVECLmbTiS1ZX/tqUcck74mMpwNgFJ8fCrUVgGx+55+lp1syl6ectUQKNCXx81H1nmX8ZxUg==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5554.namprd12.prod.outlook.com (2603:10b6:208:1cd::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 19:23:34 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 19:23:34 +0000
Date: Tue, 8 Jun 2021 16:23:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210608192332.GO1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com>
 <MWHPR11MB1886A17F36CF744857C531148C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601175643.GQ1002214@nvidia.com> <YLcr8B7EPDCejlWZ@yekko>
 <20210602163753.GZ1002214@nvidia.com> <YLhnRbJJqPUBiRwa@yekko>
 <20210603122832.GS1002214@nvidia.com> <YL8Iam4+cog7oVDa@yekko>
Content-Disposition: inline
In-Reply-To: <YL8Iam4+cog7oVDa@yekko>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:208:329::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BLAPR03CA0061.namprd03.prod.outlook.com (2603:10b6:208:329::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20 via Frontend Transport; Tue, 8 Jun 2021 19:23:33 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lqhK0-0048y4-H2; Tue, 08 Jun 2021 16:23:32 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93731080-8333-455e-61cf-08d92ab2e808
X-MS-TrafficTypeDiagnostic: BL0PR12MB5554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB555452AC3B515FDC801DF6FDC2379@BL0PR12MB5554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GqhgsOuZwr9LbJJJVRgjyog+Xu3QwmfXRGZTTaCYILekRhxqqlAlcprjSJLCR5ZW4Z7wP43jBKdZW40MQsHzu3e/0XQ6atHrsZDrOeZgwasSXk0fvKkITKIP4LiX+ukRp4gzsQ0KX0TgZnNxHgX+ITvn6t5zLv5yizXZx7nu0aSgVoz8GA6oLznaj2f0lBtsCy5QXKoo1f/7rBnxA4SdGcnqF/v9MvmLEwTjakLRqEho52Ck3eqMJK6f6m0y9ps4IxteLa84jyIKITAli4TJHHvOMwJ6/5/7VWJGgsc5TlCExYPrBUpbBt5Sz5pa8ERiYNhSO/9L9dUdDDysWgLQpeCd94/d0uZ5DCCE1x34Hrr9f9HQ11ut/hyJ50TBwkoopHIZirqOpPjrzX6VwHynlNODDtqgSqwGrvfWarr8NBQDewtbK5pxqDRiunBBZb/97+94Iwira/vnRrPV7jnjWjLmxgsr6C9rChqOioXc877/Q3QAMS4Me77yfrzlzNFx6owK21wfOFtycvbMJMU1pvcoTblpyb1FnO72PZTbLbp9xFkAJr6Ex6WigXta0unS5CzCmxcpbr74IGvPjjzE0EeZcVj4uTNt9mAofgygMOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(33656002)(426003)(8676002)(8936002)(86362001)(83380400001)(498600001)(2906002)(54906003)(5660300002)(4326008)(7416002)(26005)(66476007)(186003)(1076003)(6916009)(9786002)(36756003)(9746002)(66946007)(66556008)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TEa1SwfVVkxJVgynFgnLuxYu3I7SN/AmG37LNnPaIFjmEuGHk173B3/HZpVw?=
 =?us-ascii?Q?vfHR7CPdvJpmrK5NVddIg15YtBQvQHApY+WcpNwPE26csWRvvcZAc9hCS3lH?=
 =?us-ascii?Q?8IvTDvzuaAiA+g/r+CjJXOGdV4a76epMBHim10xS4hlOkU0j4RlMyiQx6XST?=
 =?us-ascii?Q?fRJRV4gbRS7kqkl3klZfyuuYiPGul2s3Xbf75nxA71C8q0G5BgxjzNg1F0OX?=
 =?us-ascii?Q?RsQsVqCkfeodo3UXg2j3AwKPr1qv7yj8dLXS4UXOkVZTPWMC49WLgKCyoCvA?=
 =?us-ascii?Q?NSp4Dl1dbpvV/18fOlkeWQGCsvM6StExIM6m8jDtmdnQNJfrIsErf5iKX5gk?=
 =?us-ascii?Q?VJJEA4Lugtlaba1+U3vn86AjIKrHjQc56HsRjjoPQh8mzM61VanTyw7oDfqm?=
 =?us-ascii?Q?NGDhiVnFagIetN6g4g2+M+53hr7s4apPl7ngrm062kpjVyFszuzKbugaO054?=
 =?us-ascii?Q?4tysUELIopDfEdsGCwekIeZFEgjpnAWDemkD6GNjTXzRvFrTrNyyTQPHOEg7?=
 =?us-ascii?Q?PoVVzR+6Z4HHiLP52oRDRJ0Ygw5D1QaQlHL4Vj10aKQ5U8nX58fJF9ANYIL3?=
 =?us-ascii?Q?1OWzifcgTTkkBR5PxERffi1OEb940LDz2ue7XccmuysfsmI8IU7yHZVsYZnz?=
 =?us-ascii?Q?2haOHl4UzrpwoDFevgGEu4LE4fIFbVUNFLmJl7nDqoNlXAy/7ujpas/seMNT?=
 =?us-ascii?Q?n6jgxc5RiDWuSbLCIv6VkLlS0SaLal+GtP5PFH7CDFF+4IdsFyn8Ze5RauJH?=
 =?us-ascii?Q?NsE+4FhDTecMg/UQ+ROnKQx8spFJMwFvfC7ZRslO3KQDFzhm7tiapZfEWtNI?=
 =?us-ascii?Q?QB4QSBpfjo7cPdVN7XjTpzxl+IU6/xX+KTiiqFxqYQyg4gCjygTEbOA/Bp3v?=
 =?us-ascii?Q?Fe9eCyOmdy7bAen0SxhmhC4ZqONXlc6m+gX9nCX6q0+nRxYykH/lvyeoP6Js?=
 =?us-ascii?Q?JaMq8Qw39OUrVhwVXYdH5HmAPQFWtHBX3C5Q76ulGoCbPxOuN5kowMQEFA9N?=
 =?us-ascii?Q?M3siw219ZR3DIJRBHDM9Sl0z23zaLjtz4+pDbO/jHdKjtyzIaccZ8R37eH5b?=
 =?us-ascii?Q?gGZS7ZeY/DUIhSDMbrWi/o6ujMNGUqOSUaIqKIdAym0VC6RfKxhtLVq2Ic3z?=
 =?us-ascii?Q?lu4mIIWwREf84vF8Hx35iFxpvUvaRVhrn8Y5Vzyix72LrSYQoqPyDSAW8Xud?=
 =?us-ascii?Q?W9aAxi2fOCQa0fEnaYt6uL9/HtUbhCay6MI4eDgjz+Myq3rr7FzmZJfB7zc9?=
 =?us-ascii?Q?wxXmpX39wJivTb2IDa7pp9wBIclYEtXD6dOzajSpKA4tgiAvDJXz1OJW4dQ9?=
 =?us-ascii?Q?zbI1ToJmwCS2kyiAFiT9fhjZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93731080-8333-455e-61cf-08d92ab2e808
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 19:23:33.9136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 843dkmpheot/xBq3rXxWrTzU4nnuUN2MEQz2PSsMqjksXz6/s+aWBY1Zj7szU54e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5554
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

On Tue, Jun 08, 2021 at 04:04:26PM +1000, David Gibson wrote:

> > What I would like is that the /dev/iommu side managing the IOASID
> > doesn't really care much, but the device driver has to tell
> > drivers/iommu what it is going to do when it attaches.
> 
> By the device driver, do you mean the userspace or guest device
> driver?  Or do you mean the vfio_pci or mdev "shim" device driver"?

I mean vfio_pci, mdev "shim", vdpa, etc. Some kernel driver that is
allowing qemu access to a HW resource.

> > It makes sense, in PCI terms, only the driver knows what TLPs the
> > device will generate. The IOMMU needs to know what TLPs it will
> > recieve to configure properly.
> > 
> > PASID or not is major device specific variation, as is the ENQCMD/etc
> > 
> > Having the device be explicit when it tells the IOMMU what it is going
> > to be sending is a major plus to me. I actually don't want to see this
> > part of the interface be made less strong.
> 
> Ok, if I'm understanding this right a PASID capable IOMMU will be able
> to process *both* transactions with just a RID and transactions with a
> RID+PASID.

Yes

> So if we're thinking of this notional 84ish-bit address space, then
> that includes "no PASID" as well as all the possible PASID values.
> Yes?  Or am I confused?

Right, though I expect how to model 'no pasid' vs all the pasids is
some micro-detail someone would need to work on a real vIOMMU
implemetnation to decide..
 
> > /dev/iommu is concerned with setting up the IOAS and filling the IO
> > page tables with information
> > 
> > The driver behind "struct vfio_device" is responsible to "route" its
> > HW into that IOAS.
> > 
> > They are two halfs of the problem, one is only the io page table, and one
> > the is connection of a PCI TLP to a specific io page table.
> > 
> > Only the driver knows what format of TLPs the device will generate so
> > only the driver can specify the "route"
> 
> Ok.  I'd really like if we can encode this in a way that doesn't build
> PCI-specific structure into the API, though.

I think we should at least have bus specific "convenience" APIs for
the popular cases. It is complicated enough already, trying to force
people to figure out the kernel synonym for a PCI standard name gets
pretty rough... Plus the RID is inherently a hardware specific
concept.

> > Inability to match the RID is rare, certainly I would expect any IOMMU
> > HW that can do PCIEe PASID matching can also do RID matching.
> 
> It's not just up to the IOMMU.  The obvious case is a PCIe-to-PCI
> bridge.  

Yes.. but PCI is *really* old at this point. Even PCI-X sustains the
originating RID.

The general case here is that each device can route to its own
IOAS. The specialty case is that only one IOAS in a group can be
used. We should make room in the API for the special case without
destroying the general case.

> > Oh, I hadn't spent time thinking about any of those.. It is messy but
> > it can still be forced to work, I guess. A device centric model means
> > all the devices using the same routing ID have to be connected to the
> > same IOASID by userspace. So some of the connections will be NOPs.
> 
> See, that's exactly what I thought the group checks were enforcing.
> I'm really hoping we don't need two levels of granularity here: groups
> of devices that can't be identified from each other, and then groups
> of those that can't be isolated from each other.  That introduces a
> huge amount of extra conceptual complexity.

We've got this far with groups that mean all those things together, I
wouldn't propose to do a bunch of kernel work to change that
significantly.

I just want to have a device centric uAPI so we are not trapped
forever in groups being 1:1 with an IOASID model, which is clearly not
accurately modeling what today's systems are actually able to do,
especially with PASID.

We can report some fixed info to user space 'all these devices share
one ioasid' and leave it for now/ever

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

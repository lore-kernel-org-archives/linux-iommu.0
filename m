Return-Path: <SRS0=AOw0=DX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12855C433DF
	for <iommu@archiver.kernel.org>; Fri, 16 Oct 2020 15:36:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BFB207C4
	for <iommu@archiver.kernel.org>; Fri, 16 Oct 2020 15:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Uj45kIE0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BFB207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DB2F688BC5;
	Fri, 16 Oct 2020 15:36:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Xj4Migat1L1; Fri, 16 Oct 2020 15:36:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2D57888BB9;
	Fri, 16 Oct 2020 15:36:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1525BC0052;
	Fri, 16 Oct 2020 15:36:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DB69C0051
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 15:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4E63288BB9
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 15:36:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id afIwrvLb7tuA for <iommu@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 15:36:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D257F88BB4
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 15:36:46 +0000 (UTC)
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f89be0c0000>; Fri, 16 Oct 2020 23:36:44 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct
 2020 15:36:38 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS)
 id
 15.0.1473.3 via Frontend Transport; Fri, 16 Oct 2020 15:36:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4bko2oDAxuk30+Wikl298Na6lS54+bmHLn9fYgVrMwRNN3DrJbXgN3AKTMauo43cEO0biVOJ7ZB72l33IxvHig40A9vqL+NNMzuiKvFZQc7B9eE85uG3sbf+h9VRfjj3cFrBVB6U9fr/a7tFFVW8ZGNbD1doveZM6sUzJS4bkylDwAgfgkljX5zyWBmGx5EZdBGejQCm+MY33g1A9kN77Z6Dvfca2Z42ObPhq7+2QLhoD0/RbuQe/ujqhn9VkCi2qHIdUT0xO5ZfN0eorbW3w4aE5Xj/YrstURE06rPvM1j0Yql3s+Uy0jWPQN6NHlB84NgZWGjxgW+p4Pa3xW8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4rbdQKXBBpViSWygi4YiuROMOqRyK4yCPHWgOJJmz8=;
 b=J8ENXYqSr75sVlW1gLIFSCaHilThTyufx7ETXte7NY0r/e5vkWiKKLI9EgqBJkz7VQl7nJtj22HGCjkiSPQmnj7SndvBMNfPFrR2HC7WY/ffKtmd2bIhj9jdXLqA7I7xCcBYtBTId/VcKDlihVXF8NGJMmWHS6z6xR59GRmXvtk9Lano4E2tKj76ptdO/RxmxYJJw69UX/2hIMyyzvOuTPpE/3dbc/lq+c5XZi9nwQbkBwftDKi2eDS4wbA8xghLHO3kwvflI2KeHJahoPE6Abrxg14PSjs12yceFIcTBhdxwE6DJKtVPp5YcekXFC/Xq9R0SGGS5TT8d946IQPerQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.27; Fri, 16 Oct
 2020 15:36:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.020; Fri, 16 Oct 2020
 15:36:34 +0000
Date: Fri, 16 Oct 2020 12:36:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Message-ID: <20201016153632.GM6219@nvidia.com>
References: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
 <MWHPR11MB1645AE971BD8DAF72CE3E1198C050@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1645AE971BD8DAF72CE3E1198C050@MWHPR11MB1645.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT1PR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::14)
 To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 YT1PR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20 via Frontend Transport; Fri, 16 Oct 2020 15:36:33 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kTRmS-000WqL-Co; Fri, 16 Oct 2020 12:36:32 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602862604; bh=O4rbdQKXBBpViSWygi4YiuROMOqRyK4yCPHWgOJJmz8=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=Uj45kIE0muDt8uJaerN4V1/pykr2eeqpYY+SSpCTUIXUJgQHFLH+Xq7P0tn+2RL3S
 6NOiuvotJBSPMY490p9eBLWQfPUkYx+p09+/+ipck5ziJOWe7dDwNlH7QSiNgMgtFg
 ZLIY25zWpoQPKjtPbRZJSQblRmR9cPLguxGaHsvglNjETfSZ+LkYGLa9MCJK53X4iE
 fOfBrYyWcSERmfxkRKo+N0+etJt7ylRcec3I5tzLX8GkHkYemPNfZp+jjtKtzBqGKS
 mPA653U/EMX3EoXqyFv1LnKDJd/FebN/GiUbwk6k5nC0GkreE9Nq8wq4ek4j+zwMA/
 mLYpEu5Eij82Q==
Cc: "Tian, Jun J" <jun.j.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Wu,
 Hao" <hao.wu@intel.com>
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

On Wed, Oct 14, 2020 at 03:16:22AM +0000, Tian, Kevin wrote:
> Hi, Alex and Jason (G),
> 
> How about your opinion for this new proposal? For now looks both
> Jason (W) and Jean are OK with this direction and more discussions
> are possibly required for the new /dev/ioasid interface. Internally 
> we're doing a quick prototype to see any unforeseen issue with this
> separation. 

Assuming VDPA and VFIO will be the only two users so duplicating
everything only twice sounds pretty restricting to me.

> > Second, IOMMU nested translation is a per IOMMU domain
> > capability. Since IOMMU domains are managed by VFIO/VDPA
> >  (alloc/free domain, attach/detach device, set/get domain attribute,
> > etc.), reporting/enabling the nesting capability is an natural
> > extension to the domain uAPI of existing passthrough frameworks.
> > Actually, VFIO already includes a nesting enable interface even
> > before this series. So it doesn't make sense to generalize this uAPI
> > out.

The subsystem that obtains an IOMMU domain for a device would have to
register it with an open FD of the '/dev/sva'. That is the connection
between the two subsystems. It would be some simple kernel internal
stuff:

  sva = get_sva_from_file(fd);
  sva_register_device_to_pasid(sva, pasid, pci_device, iommu_domain);

Not sure why this is a roadblock?

How would this be any different from having some kernel libsva that
VDPA and VFIO would both rely on?

You don't plan to just open code all this stuff in VFIO, do you?

> > Then the tricky part comes with the remaining operations (3/4/5),
> > which are all backed by iommu_ops thus effective only within an
> > IOMMU domain. To generalize them, the first thing is to find a way
> > to associate the sva_FD (opened through generic /dev/sva) with an
> > IOMMU domain that is created by VFIO/VDPA. The second thing is
> > to replicate {domain<->device/subdevice} association in /dev/sva
> > path because some operations (e.g. page fault) is triggered/handled
> > per device/subdevice. Therefore, /dev/sva must provide both per-
> > domain and per-device uAPIs similar to what VFIO/VDPA already
> > does. 

Yes, the point here was to move the general APIs out of VFIO and into
a sharable location. So, of course one would expect some duplication
during the transition period.

> > Moreover, mapping page fault to subdevice requires pre-
> > registering subdevice fault data to IOMMU layer when binding
> > guest page table, while such fault data can be only retrieved from
> > parent driver through VFIO/VDPA.

Not sure what this means, page fault should be tied to the PASID, any
hookup needed for that should be done in-kernel when the device is
connected to the PASID.

> > space but they may be organized in multiple IOMMU domains based
> > on their bus type. How (should we let) the userspace know the
> > domain information and open an sva_FD for each domain is the main
> > problem here.

Why is one sva_FD per iommu domain required? The HW can attach the
same PASID to multiple iommu domains, right?

> > In the end we just realized that doing such generalization doesn't
> > really lead to a clear design and instead requires tight coordination
> > between /dev/sva and VFIO/VDPA for almost every new uAPI
> > (especially about synchronization when the domain/device
> > association is changed or when the device/subdevice is being reset/
> > drained). Finally it may become a usability burden to the userspace
> > on proper use of the two interfaces on the assigned device.

If you have a list of things that needs to be done to attach a PCI
device to a PASID then of course they should be tidy kernel APIs
already, and not just hard wired into VFIO.

The worst outcome would be to have VDPA and VFIO have to different
ways to do all of this with a different set of bugs. Bug fixes/new
features in VFIO won't flow over to VDPA.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

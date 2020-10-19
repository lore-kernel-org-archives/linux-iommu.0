Return-Path: <SRS0=3ib5=D2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB3FC433DF
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 14:25:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A42221FC
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 14:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="r+KBEeHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A42221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AB1261FF11;
	Mon, 19 Oct 2020 14:25:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ytEYs0Q3bbaz; Mon, 19 Oct 2020 14:25:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 82C3A20363;
	Mon, 19 Oct 2020 14:25:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53C47C088B;
	Mon, 19 Oct 2020 14:25:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94482C0051
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 14:25:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 82A2B86F84
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 14:25:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qjKpvTEfHLjF for <iommu@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 14:25:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BBE6986899
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 14:25:33 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8da1d00001>; Mon, 19 Oct 2020 07:25:20 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Oct
 2020 14:25:28 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 19 Oct 2020 14:25:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYmZt8cW18+JwjMy+GQbwEW0ySFfLFO8bVKWo+jiOeoh0jgrjDraWu9En2UjMyOv6huHCzGmyVmRYAY4V7E9aV/4xdTqSYoX6ltPjcnSplCvFdDkeZJC+VNa9T38UsJ2sXRpFfJjTm5Ni14eXF7xn4I8GIcqjW5svFEBMqyR5hp0mP+EpacV8qQCxg4OdH7UYxeKaO9U7aDkUC8oj7HUZKGiQ7vGRzqjqiCqlC0XWoRFZ5+Ov+5X4xMqApauk6BNfraeRbIywGAlbLvlM0XCQ9gtBNwx3PjSOHZqZZFzBekQJ23ZjvSOHmEkZfH0+kN6QIYZQG/ltPWbFOESF9MWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7heJhWZiRdJe3QvqJwE9qFLQ8jVxZedxVyZAhCNH7o=;
 b=OWXQPKAxKj9/8gAiAYmynyAy0Ynd5U+Jo2gPfVUnVeQoPcb+WxeQRlNOU9k47eZcSbDgnSR5ITQrX08n1zkX9H4zeY7STxPoldFvqaXLEK7kJK3jgMliNkHEvhVYgLo70i4nltJIB+JkVmJZChQawvHSNpP8nNh1+D9xRLuiavx43kFIypPy+fpFRgKvcactOHzjq+ufRxGBDN2K6t0Xgnpgnfw9SZaHSG2XzP2w/U3Eb27pvkC27w9UlwrlspQv/oJIjiQmeb8OJ0Sb+wSvvvHwilrkzqit1ACYFwbtOxouta6nmwmq/LqwNhc4TpiiizS+vWZX5weHbEz4Ujmiyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3513.namprd12.prod.outlook.com (2603:10b6:5:18a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 19 Oct
 2020 14:25:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 14:25:27 +0000
Date: Mon, 19 Oct 2020 11:25:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Message-ID: <20201019142526.GJ6219@nvidia.com>
References: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
 <MWHPR11MB1645AE971BD8DAF72CE3E1198C050@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20201016153632.GM6219@nvidia.com>
 <DM5PR11MB1435A3AEC0637C4531F2FE92C31E0@DM5PR11MB1435.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <DM5PR11MB1435A3AEC0637C4531F2FE92C31E0@DM5PR11MB1435.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR01CA0020.prod.exchangelabs.com (2603:10b6:208:10c::33)
 To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 MN2PR01CA0020.prod.exchangelabs.com (2603:10b6:208:10c::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23 via Frontend Transport; Mon, 19 Oct 2020 14:25:27 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kUW6I-002KXy-1K; Mon, 19 Oct 2020 11:25:26 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603117521; bh=l7heJhWZiRdJe3QvqJwE9qFLQ8jVxZedxVyZAhCNH7o=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=r+KBEeHdeRhhqG0B1PEH1a4TKr956YqEMS6yiV1Zz9VafMsNs3CsZRn0eE0C1mMAh
 lWONIlNd2hgm6i2YEjmeX+4ooeuFTpdZ/xxM+rALV6KSh12t8JIY3sPqJOyjsQH9gr
 tO8a5bJHfVukmmHYoawxYuidq4bGIRgmtZzkSguRuRar+/0aMrc62o3GQvxq+R/zFh
 jxEdBdTHTkVXMxtqf4sECm4E3bc/GZ9+wS+zwZfFemo2QCS2pb2kEC3bkqnOpKvi9F
 +oSgBVOQPQ3aIJJMEOoE8mSbmkjXvJEAqxr8fvIRRS0A2S8Bc4kqA90a2R+4o+GXwn
 qRYRqP7tt471g==
Cc: "Tian, Jun J" <jun.j.tian@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wu,
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

On Mon, Oct 19, 2020 at 08:39:03AM +0000, Liu, Yi L wrote:
> Hi Jason,
> 
> Good to see your response.

Ah, I was away

> > > > Second, IOMMU nested translation is a per IOMMU domain
> > > > capability. Since IOMMU domains are managed by VFIO/VDPA
> > > >  (alloc/free domain, attach/detach device, set/get domain attribute,
> > > > etc.), reporting/enabling the nesting capability is an natural
> > > > extension to the domain uAPI of existing passthrough frameworks.
> > > > Actually, VFIO already includes a nesting enable interface even
> > > > before this series. So it doesn't make sense to generalize this uAPI
> > > > out.
> > 
> > The subsystem that obtains an IOMMU domain for a device would have to
> > register it with an open FD of the '/dev/sva'. That is the connection
> > between the two subsystems. It would be some simple kernel internal
> > stuff:
> > 
> >   sva = get_sva_from_file(fd);
> 
> Is this fd provided by userspace? I suppose the /dev/sva has a set of uAPIs
> which will finally program page table to host iommu driver. As far as I know,
> it's weird for VFIO user. Why should VFIO user connect to a /dev/sva fd after
> it sets a proper iommu type to the opened container. VFIO container already
> stands for an iommu context with which userspace could program page mapping
> to host iommu.

Again the point is to dis-aggregate the vIOMMU related stuff from VFIO
so it can be shared between more subsystems that need it. I'm sure
there will be some weird overlaps because we can't delete any of the
existing VFIO APIs, but that should not be a blocker.

Having VFIO run in a mode where '/dev/sva' provides all the IOMMU
handling is a possible path.

If your plan is to just opencode everything into VFIO then I don't see
how VDPA will work well, and if proper in-kernel abstractions are
built I fail to see how routing some of it through userspace is a
fundamental problem.

> >   sva_register_device_to_pasid(sva, pasid, pci_device, iommu_domain);
> 
> So this is supposed to be called by VFIO/VDPA to register the info to /dev/sva.
> right? And in dev/sva, it will also maintain the device/iommu_domain and pasid
> info? will it be duplicated with VFIO/VDPA?

Each part needs to have the information it needs? 

> > > > Moreover, mapping page fault to subdevice requires pre-
> > > > registering subdevice fault data to IOMMU layer when binding
> > > > guest page table, while such fault data can be only retrieved from
> > > > parent driver through VFIO/VDPA.
> > 
> > Not sure what this means, page fault should be tied to the PASID, any
> > hookup needed for that should be done in-kernel when the device is
> > connected to the PASID.
> 
> you may refer to chapter 7.4.1.1 of VT-d spec. Page request is reported to
> software together with the requestor id of the device. For the page request
> injects to guest, it should have the device info.

Whoever provides the vIOMMU emulation and relays the page fault to the
guest has to translate the RID - what does that have to do with VFIO?

How will VPDA provide the vIOMMU emulation?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

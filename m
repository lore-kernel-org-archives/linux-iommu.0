Return-Path: <SRS0=3ib5=D2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF986C43457
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 08:39:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4711422257
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 08:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="mMHcyOVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4711422257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BFADC874EF;
	Mon, 19 Oct 2020 08:39:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qSyLHaV2z6ow; Mon, 19 Oct 2020 08:39:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 02D07874F2;
	Mon, 19 Oct 2020 08:39:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9408C0052;
	Mon, 19 Oct 2020 08:39:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 425CEC0051
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 08:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 28D458702D
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 08:39:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t9W9fpeo9R5u for <iommu@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 08:39:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0954D87019
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 08:39:10 +0000 (UTC)
IronPort-SDR: 4PS0lhNWXGVfNUYkH3xPDEE+kulkR9Kn2wsu6gPvPeni++0e9TIm7RYE/K7wtGVOz0bG8doIYh
 essBUyvYr5Pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="228625322"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; d="scan'208";a="228625322"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2020 01:39:10 -0700
IronPort-SDR: SsBi3BWk3Ipj4qUs3doUykY9IZajErQk63kzu3twvpUcVujzbzCxjfFHMeNzBg6S41DwAqJTuM
 Da6ntlXQYM8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; d="scan'208";a="532541641"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by orsmga005.jf.intel.com with ESMTP; 19 Oct 2020 01:39:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 19 Oct 2020 01:39:09 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 19 Oct 2020 01:39:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 19 Oct 2020 01:39:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.59) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 19 Oct 2020 01:39:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ck/RBE1pjbICfVkZ99gJ6/9BDRDwPk9S1LnjZ/X1zGAVMcjBjR0E5Cjbj4l1hKqQGrE5f78o+mFQHEFlGeHY0zWqLaAkd920PjH008rNdMlCN78ImBYk3FiGCUPRGg3Z2Ht0Qsoce+5+OQHcGAqCILzxzuF+X3CPgZgNVYzay3SB6gFnvnxYtx5Hoe47Mut97Jaoczsb7pEQ6a5TZZWY3FCaIP7OR0GFmqRksaFI6TOWFl3Y36g34vpuy4EXWSgpt+FjbZfZ9IvbwNV0zDXxaAKbrqSKpICbbfWgROCuVeoAOik4DBt4ajd/Z3ZMj7KCIO2jnMERjrPCUjUEnhjQbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmSAepqYF/pPC5gZiNd9Ffs4Br7w51RWwDow8eWxobk=;
 b=DAhckdsO1FN3o3pyj+OGCHaXwSIqTPk/sOF87VqV8eQSNaF8EPTeVD9F2mr6LgSIEPh53g4wpAR+agxPFadgITm9HN4eeF/L3t51k8JZnLR1QR6WOePkpv7ENDMPJ05FJTRXwWFimhOuJ1q7xlmokw8aEWAWttZPB9UXlqnFDyv5PQFCd5rD0m46UpmtiG/MSdtv8U2No9PzlKCKu6f7CoI6l7KG8uHP6DG0wZlbKBO2C+H5urd/ySy7hqwSJDxalNdefGvVpnGBYWVpsxbDfJnvitEU0bN9yHdFxtC5ZCCxQgCYa2UdEaGrTEsSLAPaPArWPSOhPmvytMPgMcmbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmSAepqYF/pPC5gZiNd9Ffs4Br7w51RWwDow8eWxobk=;
 b=mMHcyOVZlF4+At5GF5Lxa6UWbakjmGaAa+8BKFh0yD1QQ6884F36VGUb4yE39Wq36R8ysVE0wbQNMzNjySEAOWDQvCbWrlmb3wpEV68zEIOwdTQSDxHlrab9vFBhnST8miTguN3AYHl8P4zi6uFZN2fTnTQKVNN5rNkEXAPkoJw=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB2857.namprd11.prod.outlook.com (2603:10b6:5:cb::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23; Mon, 19 Oct 2020 08:39:04 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::a1ec:ba6b:5057:be2f]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::a1ec:ba6b:5057:be2f%11]) with mapi id 15.20.3477.028; Mon, 19 Oct
 2020 08:39:04 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Thread-Topic: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Thread-Index: AdagceQQLvqwjRCrQOaq1hZ7MgDUUABZWmqgAH60bgAAh22vsA==
Date: Mon, 19 Oct 2020 08:39:03 +0000
Message-ID: <DM5PR11MB1435A3AEC0637C4531F2FE92C31E0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
 <MWHPR11MB1645AE971BD8DAF72CE3E1198C050@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20201016153632.GM6219@nvidia.com>
In-Reply-To: <20201016153632.GM6219@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [221.220.190.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8791266a-f74b-45aa-36f9-08d8740a6f6d
x-ms-traffictypediagnostic: DM6PR11MB2857:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB28578DFF31CF4434B2D021ABC31E0@DM6PR11MB2857.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: glSu/bh0k3Nvbgk8GNyxKvPCWgtq8TEdsBXANlRLuqUYGKh0BdtFK0MbYXub1Fuu+ek28r/Xz/4ujqHXPtX7HDI4jopTmshhaY84yYO/pqAuRfStNPc+XY3OF/cjZ4MCxM75AO5WyPPUrcgEzNHz06RggtJkIXuKDLnVut5IBPX1+XJyvDmaByQfuJPoyDooLdlXsjnn7RlhNT31UCfHQO4022Lui5LR6PNSJhiqCAwwWjrefQb/cCdNPAaVya9FOnW3GDIJ7KzqshfNCJ88FN3hr5hfF9KcPUAQMMowR1F4ejH9eQbVV2pWNW74nDu0qqLv78XWj9JddK3eQhlqWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(64756008)(66556008)(110136005)(66446008)(76116006)(54906003)(55016002)(66946007)(7416002)(316002)(66476007)(2906002)(83380400001)(86362001)(5660300002)(52536014)(71200400001)(8676002)(478600001)(4326008)(6636002)(7696005)(186003)(9686003)(33656002)(6506007)(8936002)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Q1a/jVnmdE9L0gQ32ell9nkuP5N1++oQGnFKhD1XuNlT618HEm/JlnjObBgk+NIEEwGYShZ1e7Itjnl9GgZo+LdSlqUa7xCXgoYPWyVAxxV6dddZQ/tJnV9lVIOSgQjIofcbxEGLZGkblUVqG9y/Sd9eJs9tpbJob47lFTmtLfvXHekibPUFQQu9VHwuSB7Fj2oEVI2tfPGHJnMkTcuqczDeV0kBhXWgt3oBrvjTWYjOsLqkL30AdA5O83XlQxvOSTnJIRjHENcllk7ccHT17yeGssb5PUpr6LZytMabKuTOwjOjj5jsqWZ6yTbsi5v7DVfYCDW3r0LNsTuhv8/DwA+cRUgDvLDTwb1BCBjApWD+pijhFgwdpraT5Pe7du5xOl3V1OhNCDaj0qdIRdyMTu/noKkpxv2bn82A41+/EOPxWHuj7aRRu8zYlgJNayOLikiVE8SCfLkgQlykj7u1Z6bRG1YCPs14v6zYLMc+sZEUfKR/4O2Kj/uftyzFzteX8jZkVr6oyhnfMwfKQ6ybFfnqoygqHjmtVXJeUSAs+hvjM75DVoa9sp0opDUUM98TdmzeAFtZ/aK0MMlJeHjDOVPx6UY3/xqau6y+Vz+uyi4CGPcWhMGBsmnTyiLS7GZtFvbwpX5ZmJTw40UcKGcO6A==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8791266a-f74b-45aa-36f9-08d8740a6f6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 08:39:03.8609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nCftJPlY7Xz90ZdFnCY9RtDKsfufoGx7z8B8LctJWSY0P/uHBysSaDGTdISO4AtWdhE6VBWi7NbNc+VseulxOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2857
X-OriginatorOrg: intel.com
Cc: "Tian, Jun J" <jun.j.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
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

Hi Jason,

Good to see your response.

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, October 16, 2020 11:37 PM
> 
> On Wed, Oct 14, 2020 at 03:16:22AM +0000, Tian, Kevin wrote:
> > Hi, Alex and Jason (G),
> >
> > How about your opinion for this new proposal? For now looks both
> > Jason (W) and Jean are OK with this direction and more discussions
> > are possibly required for the new /dev/ioasid interface. Internally
> > we're doing a quick prototype to see any unforeseen issue with this
> > separation.
> 
> Assuming VDPA and VFIO will be the only two users so duplicating
> everything only twice sounds pretty restricting to me.
> 
> > > Second, IOMMU nested translation is a per IOMMU domain
> > > capability. Since IOMMU domains are managed by VFIO/VDPA
> > >  (alloc/free domain, attach/detach device, set/get domain attribute,
> > > etc.), reporting/enabling the nesting capability is an natural
> > > extension to the domain uAPI of existing passthrough frameworks.
> > > Actually, VFIO already includes a nesting enable interface even
> > > before this series. So it doesn't make sense to generalize this uAPI
> > > out.
> 
> The subsystem that obtains an IOMMU domain for a device would have to
> register it with an open FD of the '/dev/sva'. That is the connection
> between the two subsystems. It would be some simple kernel internal
> stuff:
> 
>   sva = get_sva_from_file(fd);

Is this fd provided by userspace? I suppose the /dev/sva has a set of uAPIs
which will finally program page table to host iommu driver. As far as I know,
it's weird for VFIO user. Why should VFIO user connect to a /dev/sva fd after
it sets a proper iommu type to the opened container. VFIO container already
stands for an iommu context with which userspace could program page mapping
to host iommu.

>   sva_register_device_to_pasid(sva, pasid, pci_device, iommu_domain);

So this is supposed to be called by VFIO/VDPA to register the info to /dev/sva.
right? And in dev/sva, it will also maintain the device/iommu_domain and pasid
info? will it be duplicated with VFIO/VDPA?

> Not sure why this is a roadblock?
> 
> How would this be any different from having some kernel libsva that
> VDPA and VFIO would both rely on?
> 
> You don't plan to just open code all this stuff in VFIO, do you?
> 
> > > Then the tricky part comes with the remaining operations (3/4/5),
> > > which are all backed by iommu_ops thus effective only within an
> > > IOMMU domain. To generalize them, the first thing is to find a way
> > > to associate the sva_FD (opened through generic /dev/sva) with an
> > > IOMMU domain that is created by VFIO/VDPA. The second thing is
> > > to replicate {domain<->device/subdevice} association in /dev/sva
> > > path because some operations (e.g. page fault) is triggered/handled
> > > per device/subdevice. Therefore, /dev/sva must provide both per-
> > > domain and per-device uAPIs similar to what VFIO/VDPA already
> > > does.
> 
> Yes, the point here was to move the general APIs out of VFIO and into
> a sharable location. So, of course one would expect some duplication
> during the transition period.
> 
> > > Moreover, mapping page fault to subdevice requires pre-
> > > registering subdevice fault data to IOMMU layer when binding
> > > guest page table, while such fault data can be only retrieved from
> > > parent driver through VFIO/VDPA.
> 
> Not sure what this means, page fault should be tied to the PASID, any
> hookup needed for that should be done in-kernel when the device is
> connected to the PASID.

you may refer to chapter 7.4.1.1 of VT-d spec. Page request is reported to
software together with the requestor id of the device. For the page request
injects to guest, it should have the device info.

Regards,
Yi Liu

> 
> > > space but they may be organized in multiple IOMMU domains based
> > > on their bus type. How (should we let) the userspace know the
> > > domain information and open an sva_FD for each domain is the main
> > > problem here.
> 
> Why is one sva_FD per iommu domain required? The HW can attach the
> same PASID to multiple iommu domains, right?
> 
> > > In the end we just realized that doing such generalization doesn't
> > > really lead to a clear design and instead requires tight coordination
> > > between /dev/sva and VFIO/VDPA for almost every new uAPI
> > > (especially about synchronization when the domain/device
> > > association is changed or when the device/subdevice is being reset/
> > > drained). Finally it may become a usability burden to the userspace
> > > on proper use of the two interfaces on the assigned device.
> 
> If you have a list of things that needs to be done to attach a PCI
> device to a PASID then of course they should be tidy kernel APIs
> already, and not just hard wired into VFIO.
> 
> The worst outcome would be to have VDPA and VFIO have to different
> ways to do all of this with a different set of bugs. Bug fixes/new
> features in VFIO won't flow over to VDPA.
> 
> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

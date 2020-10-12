Return-Path: <SRS0=a71q=DT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E368C43457
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 08:39:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03ADD2074F
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 08:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ZQn5MDjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03ADD2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 98267869A4;
	Mon, 12 Oct 2020 08:39:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 95-gjDebkY12; Mon, 12 Oct 2020 08:39:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C1373869AA;
	Mon, 12 Oct 2020 08:39:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A678AC0052;
	Mon, 12 Oct 2020 08:39:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 900C8C0051
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 08:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7731087458
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 08:39:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MlDlxaOMICQJ for <iommu@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 08:39:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5998987445
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 08:39:03 +0000 (UTC)
IronPort-SDR: jEsbuiK4ZZfY5XOGnKkG2RCoVCzOjMoi+Dk7YnrPv9M5ntXWqBSLkZ1riJELF4z33BgpP4MxeU
 oN8RdKDV5U8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="153538479"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; d="scan'208";a="153538479"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 01:39:02 -0700
IronPort-SDR: euLG8Sa/3LTQ6v4wGskxBLFi7jaX3B+jdBwZDfgLfxMR9BWn6qqAz5ey51p4RZkS/h/bF/BMKT
 9Q2fhcH2EkEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; d="scan'208";a="313374461"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga003.jf.intel.com with ESMTP; 12 Oct 2020 01:39:02 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Oct 2020 01:39:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 12 Oct 2020 01:39:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 12 Oct 2020 01:38:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2FgDYMIPRl75pSg2CMjLQKl1/lw5Re+sr7Am+jglGsPOrIu8PthGOTFDJNXI+QSCXeX2k/dwr+T4VUfWD/vkMlpusdZpvYbeRmCbYxGf5Ds1xqVhY6yIgaZyGK/WcefSKfKzyaoTCxKMv9O34ivo4eYEn+ZGm30o/eFLmHKLN0WAcsPIHmdVMeKL9agM0RgvtZmIW7+R1cR+anMO/UL+85lw0zFj++48rCCj+d5GGr/OcodPrtmvl/mgzlAlOpfabeIxc643EZc9HLmF6RE1KlcDnjxaMIe1xZIxR+teIwsn3zW2o+QdSbnXkD1S7iw9d4gdmXkwiod8xURdGAziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ItKLua+ugVrbTuEJp88AEEcT7Gx/XR+5bsIslM57dc=;
 b=iSn4C/Jgeic1Ih96OJ5Q0UyHojGaJvLeHODJp0lb/O9ZOY2NN1dcIK1xu9y92epr6Ff6zi5Q1PUP30IunuLuGEe87Jt0KaSC13LLbyGp16bURCzCGFHaIXH4Mp36ibXKlV46ITdoASNsEpEGI71P5NdvXgm8spVfeVy0KmukPKlS0MKrOiD5EZn42ynrcBhIzJHs+khxY+DVk9zjNF6ip6IH89I4nx6cPQsZ7dhopqstsfe/TeJmkn4dqXYcjJYcgJAwvUOG7L3VGms1U0wZZYU0wR4sireicEIz11IzmODO/cYAzfoYPuZg1XtC1t+ranaogf6b7yCd1VP7hUSbqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ItKLua+ugVrbTuEJp88AEEcT7Gx/XR+5bsIslM57dc=;
 b=ZQn5MDjlRGyV9zJ5DwhI3HnPnGtxgqAu4JJzcJxyERVFEDT/0GfVy4yEpTEof4yM/ihHE1s82j+mtG9G4R8Vw4j3NPdh2UxdVK5QP319THZi/AQ/W2BymhOJATXE+rVIX1c4j7fDOpn03WvcDioyjHvzKCMsYjSl5RhC5/z0wj8=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR1101MB2159.namprd11.prod.outlook.com (2603:10b6:301:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Mon, 12 Oct
 2020 08:38:54 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::c88f:585f:f117:930b]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::c88f:585f:f117:930b%8]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 08:38:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared Virtual
 Addressing to VMs
Thread-Topic: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Thread-Index: AdagceQQLvqwjRCrQOaq1hZ7MgDUUA==
Date: Mon, 12 Oct 2020 08:38:54 +0000
Message-ID: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14d2cf80-fd71-4263-f614-08d86e8a40e3
x-ms-traffictypediagnostic: MWHPR1101MB2159:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB215900183B22013FC861CA378C070@MWHPR1101MB2159.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NTP+fVhRkzbnYgFJ//3ZaqfJdL5DVliyHAQvdc4VliZalhRz+6A8Iw/gDXxhT3519BkvUPb1bFpPB/oBcvYedDePssz3rH/IAvMpt/7dtQgLxlCx+9WXRSyH5vCY2CVXk9nvaE0ez8M3C3Fs4PVTaA17IGkVwxv+ColtR8SxuEMT4nGoasfW6Q1nMnZBB+P3GEhcXh75n7FjAW7R09lbygMfjkEVkjDXJGz2AUw/BrqRe/cXRRb1sKvc5XDoFMeqQJ8cQI2xhHbLzNG9n8sbXVtIXWFlgsTSYUaopAbmPLHMn8NJsh+kww0KMqY7sbG2e2KNAx9Nvk2d4WHX0ud08A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(54906003)(8936002)(8676002)(110136005)(186003)(71200400001)(4326008)(5660300002)(66556008)(66476007)(478600001)(76116006)(33656002)(2906002)(66946007)(64756008)(52536014)(66446008)(86362001)(26005)(316002)(9686003)(6506007)(55016002)(7696005)(83380400001)(7416002)(83730400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 2Kea+GMCDdIBqLg4lHt+G23+CcH3fJcit+T0Gqyld5UYtgPxsbguGV9I3npldc4YWa2icEoxriAUP7N9t546aGMFGX+ijNCq6HnhFOURZ2ySai09z5nQIJ0VNfq4mWbY6pwgRWiQIoPyGCdCT9sYqQ2X5gaYR3rBIhKCyUJDzpkRvfgVOwkL+OIQt9NttB81R8V+Stl86bhF65jNtoqnFAVxpm3XUtEw7yKjzwaXGCxfoctPrismNiTwkrdI8thUfflBPM7OKSim5ahBYqMPIplQiSoHfc/ul9RLh++ARTPWRV8iAD0h8za0SIefdWm4jFA9lb3AR8KeNJrXWma+VkZW1WTLIKfW4g9TwOfxScLkn5tu9r6aoBzIWhY8VJUZUowhJthV03itWWXK6Bk9qftalR+ufgWFKtab0g8E0rmhdlteqOCANgTmdepUzKS1LXPjfxAFi85FE1arHJ2ANT8SQ1MQy/3Cg/FL0YjBcLJg53tHvJI+oj8bnIy0oKEwX1dfu5FUWNkehq4PEJtnPV5OKw+67MP9GTHmDDQoc/9W5Pyg+bsIwQOVx0T2KEx1H/p5qOPEtSlUMFKfzV+N22YU8QDPtgPzq/gQOSMrZ0wfGsY+DXeo4VVgJlcGZaFPQeX1WxhyzXKcQc27uXSHRw==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d2cf80-fd71-4263-f614-08d86e8a40e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 08:38:54.3280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IrxmoOk5Mjs+3AcVDGcf4MsV4vDDTlGcJJ7Iwz/+4l0zEI6oquDKzlWcsp0Q7ph9zsJdcT6aFE7yiRM/xgo7cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2159
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, "Wu,
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

> From: Jason Wang <jasowang@redhat.com>
> Sent: Monday, September 14, 2020 12:20 PM
>
[...]
 > If it's possible, I would suggest a generic uAPI instead of a VFIO
> specific one.
> 
> Jason suggest something like /dev/sva. There will be a lot of other
> subsystems that could benefit from this (e.g vDPA).
> 
> Have you ever considered this approach?
> 

Hi, Jason,

We did some study on this approach and below is the output. It's a
long writing but I didn't find a way to further abstract w/o losing 
necessary context. Sorry about that.

Overall the real purpose of this series is to enable IOMMU nested
translation capability with vSVA as one major usage, through
below new uAPIs:
	1) Report/enable IOMMU nested translation capability;
	2) Allocate/free PASID;
	3) Bind/unbind guest page table;
	4) Invalidate IOMMU cache;
	5) Handle IOMMU page request/response (not in this series);
1/3/4) is the minimal set for using IOMMU nested translation, with 
the other two optional. For example, the guest may enable vSVA on 
a device without using PASID. Or, it may bind its gIOVA page table 
which doesn't require page fault support. Finally, all operations can 
be applied to either physical device or subdevice.

Then we evaluated each uAPI whether generalizing it is a good thing 
both in concept and regarding to complexity.

First, unlike other uAPIs which are all backed by iommu_ops, PASID 
allocation/free is through the IOASID sub-system. From this angle
we feel generalizing PASID management does make some sense. 
First, PASID is just a number and not related to any device before 
it's bound to a page table and IOMMU domain. Second, PASID is a 
global resource (at least on Intel VT-d), while having separate VFIO/
VDPA allocation interfaces may easily cause confusion in userspace,
e.g. which interface to be used if both VFIO/VDPA devices exist. 
Moreover, an unified interface allows centralized control over how 
many PASIDs are allowed per process.

One unclear part with this generalization is about the permission.
Do we open this interface to any process or only to those which
have assigned devices? If the latter, what would be the mechanism
to coordinate between this new interface and specific passthrough 
frameworks? A more tricky case, vSVA support on ARM (Eric/Jean
please correct me) plans to do per-device PASID namespace which
is built on a bind_pasid_table iommu callback to allow guest fully 
manage its PASIDs on a given passthrough device. I'm not sure 
how such requirement can be unified w/o involving passthrough
frameworks, or whether ARM could also switch to global PASID 
style...

Second, IOMMU nested translation is a per IOMMU domain
capability. Since IOMMU domains are managed by VFIO/VDPA
 (alloc/free domain, attach/detach device, set/get domain attribute,
etc.), reporting/enabling the nesting capability is an natural 
extension to the domain uAPI of existing passthrough frameworks. 
Actually, VFIO already includes a nesting enable interface even 
before this series. So it doesn't make sense to generalize this uAPI 
out.

Then the tricky part comes with the remaining operations (3/4/5),
which are all backed by iommu_ops thus effective only within an 
IOMMU domain. To generalize them, the first thing is to find a way 
to associate the sva_FD (opened through generic /dev/sva) with an 
IOMMU domain that is created by VFIO/VDPA. The second thing is 
to replicate {domain<->device/subdevice} association in /dev/sva 
path because some operations (e.g. page fault) is triggered/handled 
per device/subdevice. Therefore, /dev/sva must provide both per-
domain and per-device uAPIs similar to what VFIO/VDPA already 
does. Moreover, mapping page fault to subdevice requires pre-
registering subdevice fault data to IOMMU layer when binding 
guest page table, while such fault data can be only retrieved from 
parent driver through VFIO/VDPA. 

However, we failed to find a good way even at the 1st step about
domain association. The iommu domains are not exposed to the
userspace, and there is no 1:1 mapping between domain and device.
In VFIO, all devices within the same VFIO container share the address
space but they may be organized in multiple IOMMU domains based
on their bus type. How (should we let) the userspace know the
domain information and open an sva_FD for each domain is the main
problem here.

In the end we just realized that doing such generalization doesn't
really lead to a clear design and instead requires tight coordination 
between /dev/sva and VFIO/VDPA for almost every new uAPI 
(especially about synchronization when the domain/device 
association is changed or when the device/subdevice is being reset/
drained). Finally it may become a usability burden to the userspace
on proper use of the two interfaces on the assigned device.
 
Based on above analysis we feel that just generalizing PASID mgmt.
might be a good thing to look at while the remaining operations are 
better being VFIO/VDPA specific uAPIs. anyway in concept those are 
just a subset of the page table management capabilities that an 
IOMMU domain affords. Since all other aspects of the IOMMU domain 
is managed by VFIO/VDPA already, continuing this path for new nesting
capability sounds natural. There is another option by generalizing the 
entire IOMMU domain management (sort of the entire vfio_iommu_
type1), but it's unclear whether such intrusive change is worthwhile 
(especially when VFIO/VDPA already goes different route even in legacy
mapping uAPI: map/unmap vs. IOTLB).

Thoughts?

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

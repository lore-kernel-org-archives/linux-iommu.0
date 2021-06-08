Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2B3C47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 06:30:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C90E61249
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 06:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C90E61249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 08B64402C3;
	Tue,  8 Jun 2021 06:30:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I1v3ZrI4ogg7; Tue,  8 Jun 2021 06:30:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC514402A2;
	Tue,  8 Jun 2021 06:30:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 921FEC000D;
	Tue,  8 Jun 2021 06:30:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EBCEC0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 06:30:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80E48402A2
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 06:30:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qdiThpTBNjcn for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 06:30:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11B96400D8
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 06:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gw2At+9wF/E0Ul+lYoh3QoZo2lNzXeyrto75fAUWBmPEMMeGfBa354zQCSD91LDHZqYbLX8ufwfZZs+MOBGFT+STPpS67TqcqtPRzihZlcFcrw9X9gwnjwjGirNcQqrBAgfGSbuvFQuhxrn2/UhZ9EuKvkiLpATujX+7D8o/XttMyt2bQ4jDwLx40NBQXfYangU+rTjBbW/mNEiSJChYT2uhkbrPeDLpC48JMvyheT5s5TIQu4K9Cd05u5TIKN4dY0XKtbfooDIw2C5Iy1dgfuIeqCgknAHrohWB0+rBuA7ESiYt2hPBSAFis2H52P92n/D4Tir+5nmWROOh0JSTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCzQpf97kTLFF8LOwsakeLyGEjiGOHcv9gyOs8lqeIs=;
 b=a2/HmS3IdQvGUNfBebnLtzS/kEiCWhlQeGt72yKoKCbTmPVF/ayzDrVPSQ7sunjslYlHVDMbSaGi/unbjbllPH4K2WRuWsBzdOxbjzkmwE3XJmkgPzryCHsC9wOWKS/4zKQLkF0XiZ6XhvldaRBoS5kLx6kmwIN0trp2Uve/1700kLHAtk/ZKIfcIeKv3hNHjm9buAuS71dErLB6++ZiR+/VxZIn18gH0UhPGcJh4nXNGWwxNWP9jpnSjxalXoUMwAkG6qbp0g51lHx45unNXB9d1sM3oIazRbBNn2OySQ/xPKJ3CDVTi15davJALlLE5oZSrgFIhxgZOyJo7QPrgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCzQpf97kTLFF8LOwsakeLyGEjiGOHcv9gyOs8lqeIs=;
 b=pa5LiE3wJjoznM4cQBeEPmLCOvetzfag6hxbIAWR3xT79NUyC8oUqqBDlJZuE0UFHZH4eWG8tl5UwylfJBO7z3Eh/4w89qjPLLKFl4qXLc28CCv/gDVvPfwGOgzMW0NVTf3K4BxVp4aVuSB/tPJXyP/+kk0WwnFJD1UaRIVSZ7wSSKyHd3wYwLvcgiP9lkBSOtMH/h2L2sNL4szkmu5LmUV4ycgxBH4XgMoekvDR+QqF+QuYMfykJSTs8WTMTaI8K8Fsmjhfjuo/MczEEXAXc+jaMpW8UJ5jsZ8UKVhjskIzPNAKKZlbha9SlHS6pRen352rhBWM2GORz+FLUpsUzQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5418.namprd12.prod.outlook.com (2603:10b6:510:e5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 06:30:30 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::b0d9:bff5:2fbf:b344]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::b0d9:bff5:2fbf:b344%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 06:30:30 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwEO8mWgAGyTh4AA2+cZ0A==
Date: Tue, 8 Jun 2021 06:30:30 +0000
Message-ID: <PH0PR12MB5481DA4780B0EAE420B3ABF4DC379@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <PH0PR12MB54811863B392C644E5365446DC3E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210603135807.40684468@jacob-builder>
In-Reply-To: <20210603135807.40684468@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
x-originating-ip: [49.207.202.149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caca337a-0d92-4123-a76d-08d92a46e99d
x-ms-traffictypediagnostic: PH0PR12MB5418:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5418D4EB29613314AB27FB9BDC379@PH0PR12MB5418.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ODL9HoRLbEYD9pSAsi4bZz3GZllaW8q7/BHXS9UGPAZtS8Y8GQn9arqjnwF/IADZZC/N87+eePmwlTBeWI1dq7rQMVxFkIle//mCt+MARSpo0DcwO/Wr4R5jwMfl4zBctgBC4iCn9AYfru+bsX7lxV2oxs6bp8n0gOBfZR0l2boId84C+60nSNQJzj6V34BEB0TAKlVPJRTHvjf0sdOszIr1gmsdn1RRbdqrarByYPU6zamvUnUPt5Ri2p1EmqKDSLJgZdsUyDkp2M4D8xGgHJG2hdmicgO+iuWRQlAW4JRTHtn+9BRBMDBVlvxdl8l8b5kUgUg89nWEG0LaPfXBlRPONRt8j9KHfTZeN/T6+kDbDi8eIis6XVuab4bGA4Vp8k03YniH9yFyyLYx+Lg3Lozm5e1p0y61ruUxiA4g3gGZ9f/9HXpwpC5il12s8Q1iI5S3JMm8lWZmUhqgkCe+e4K//6Ke0ws3zJiz/0XJbKLSUSTOE/zLWxrV3j7gsIgG281c1UTelPBQoc3QJbnqVORnzB4nESt1KxsbZfc/ve3Epi0uZyULNVd0h/4oUE5Ul53CW+R28ujjFdLxysMh4z8x/yQomYdfd3v5S+J3Em8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(9686003)(26005)(5660300002)(2906002)(55236004)(316002)(66946007)(66556008)(66446008)(52536014)(6506007)(64756008)(86362001)(66476007)(55016002)(54906003)(33656002)(186003)(8936002)(7696005)(38100700002)(76116006)(478600001)(122000001)(83380400001)(6916009)(71200400001)(8676002)(4326008)(7416002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qGedYqpHvo7cUYWz9l18qd7LQpKw83Foeb+NHs0geLhWIBFYbyBMi96ugHk7?=
 =?us-ascii?Q?rt/wloPrgjtFKvIInONiyhRQ+JMlTNXdWFNu58YUguHbZcrptd2M7O5EiHuB?=
 =?us-ascii?Q?BoQYk2jglZ6hMebBaBpSc/AWEp7DC+OdqW8DAgWnSQmr1m9Lq5wXtrqDYkU5?=
 =?us-ascii?Q?DG83s/Ez+Xl4jY531MBGGfvOFMqCJUVmeUi1E3W/2q0E5gf1VGFnc0hWcsaQ?=
 =?us-ascii?Q?cyuK3tRaYLJCRA+uLdqBqOnkIp9uetRSJYnF4ozw2MGLLHhEHR2kPAuBiGFP?=
 =?us-ascii?Q?4t659h0vGgQbLqYVVqBME0+F60y//sCHD5bikN+FGS4Ksdn82Vc1G/XUE+bE?=
 =?us-ascii?Q?G8Qm/UndTBy3xGgPnUzxiddapMe1ANGMCy/3mtYnzd7NJkLBSQOEfA84PmXL?=
 =?us-ascii?Q?MTnpwYWTLAwGm41ZoHCWIvNvKoDPoe9NTEZRYGBo16GW07WzEahTpRiVu6pU?=
 =?us-ascii?Q?5pprLu19IBUHtpM932xe/GNI5K2sSjtbPjavjZNK2Vp2wy50nvcLxBfwNO2O?=
 =?us-ascii?Q?EmE7+9qV8D1ZX4QnjuquqnAixZZVqTxI9NzaEuCAaXOVRSNxkWTWESzjWYTv?=
 =?us-ascii?Q?NR27P3wdVTCcrqs0fs5R7Mg7vfxnFgtjOkkuM+4c7euCpfZm5yxTeH0B7Efp?=
 =?us-ascii?Q?OEikBhLGyPaI+NTlfI/6cvjtyN/3aQQ2m0wvq0lyEX1pl8SXOXVMxNcUl9yu?=
 =?us-ascii?Q?5SIYXOuq9TthvrISHu5uAuPZcKdfaHaFEB7KmEaqFdqI7s0gWVGMBJEudZYu?=
 =?us-ascii?Q?e/UOCmir/mN/+yCMOx3Lnq7L4E0j+toiAnfr5AqI/Pxb6tHr3fa++Bm60vn6?=
 =?us-ascii?Q?VYy/E6osy7ZcP1XWZ3cwCmwFQP38UJ5aYGAxnZ/c3ipLhvJa0rwda9QtwPum?=
 =?us-ascii?Q?YpsIblJZCHFn8dvRzch1wqeFwuhbqbW2YV6dlVJsQ5YEix2PLxU4oIhyKWZy?=
 =?us-ascii?Q?xToCQEav+6eIROd82XdQcB0CXh4PUj1YOmvgwP+TyJ3dB8BcLYEU9lAzgFDC?=
 =?us-ascii?Q?Omk7yXivfSTY56644uBdzKNMUachusbSRGyumtVoHpjobynOGWra2Gei7bbr?=
 =?us-ascii?Q?rqU691cYlL7jjUZ4iw7mL2kF2/LDkf5Wi7B5Asv6mHub6iD2lrt5xYVIIEzy?=
 =?us-ascii?Q?7KbZUDhQXgcmCFwF9+vFoT34MENUPAzXFPixhLqRmL8QXRxp6jQJ+Zn0zW3F?=
 =?us-ascii?Q?P1kMYXSYwNyyVucc9qu/XhwqtDTbcs7WM/mTRIhDvIeLh/GieMI4zxBpRhUP?=
 =?us-ascii?Q?bFXHJdryYldt5x2ePlfdt7/4zyT0DQrlXMRzkgnoI/RTCUT+h+3fAyqOBfI7?=
 =?us-ascii?Q?CCdLAXuxWLndcihOgAxcy72J?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caca337a-0d92-4123-a76d-08d92a46e99d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 06:30:30.4101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOxoPTNPwEZHkurlusqdrKqtlEtrJSkB0ZaCp/2sCePHJkL0COf4mX/7ToyUY2jIocoq6s4AcM58UVvmbCiXnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5418
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Alex Williamson
 \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Robin Murphy <robin.murphy@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Gunthorpe <jgg@nvidia.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
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

Hi Jaocb,

Sorry for the late response. Was on PTO on Friday last week.
Please see comments below.

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Friday, June 4, 2021 2:28 AM
> 
> Hi Parav,
> 
> On Tue, 1 Jun 2021 17:30:51 +0000, Parav Pandit <parav@nvidia.com> wrote:
> 
> > > From: Tian, Kevin <kevin.tian@intel.com>
> > > Sent: Thursday, May 27, 2021 1:28 PM
> >
> > > 5.6. I/O page fault
> > > +++++++++++++++
> > >
> > > (uAPI is TBD. Here is just about the high-level flow from host IOMMU
> > > driver to guest IOMMU driver and backwards).
> > >
> > > -   Host IOMMU driver receives a page request with raw fault_data {rid,
> > >     pasid, addr};
> > >
> > > -   Host IOMMU driver identifies the faulting I/O page table according
> > > to information registered by IOASID fault handler;
> > >
> > > -   IOASID fault handler is called with raw fault_data (rid, pasid,
> > > addr), which is saved in ioasid_data->fault_data (used for
> > > response);
> > >
> > > -   IOASID fault handler generates an user fault_data (ioasid, addr),
> > > links it to the shared ring buffer and triggers eventfd to
> > > userspace;
> > >
> > > -   Upon received event, Qemu needs to find the virtual routing
> > > information (v_rid + v_pasid) of the device attached to the faulting
> > > ioasid. If there are multiple, pick a random one. This should be
> > > fine since the purpose is to fix the I/O page table on the guest;
> > >
> > > -   Qemu generates a virtual I/O page fault through vIOMMU into guest,
> > >     carrying the virtual fault data (v_rid, v_pasid, addr);
> > >
> > Why does it have to be through vIOMMU?
> I think this flow is for fully emulated IOMMU, the same IOMMU and device
> drivers run in the host and guest. Page request interrupt is reported by the
> IOMMU, thus reporting to vIOMMU in the guest.
In non-emulated case, how will the page fault of guest will be handled?
If I take Intel example, I thought FL page table entry still need to be handled by guest, which in turn fills up 2nd level page table entries.
No?

> 
> > For a VFIO PCI device, have you considered to reuse the same PRI
> > interface to inject page fault in the guest? This eliminates any new
> > v_rid. It will also route the page fault request and response through
> > the right vfio device.
> >
> I am curious how would PCI PRI can be used to inject fault. Are you talking
> about PCI config PRI extended capability structure? 
PCI PRI capability is only to expose page fault support.
Page fault injection/response cannot happen through the pci cap anyway.
This requires a side channel.
I was suggesting to emulate pci_endpoint->rc->iommu->iommu_irq path of hypervisor, as

vmm->guest_emuated_pri_device->pri_req/rsp queue(s).


> The control is very
> limited, only enable and reset. Can you explain how would page fault
> handled in generic PCI cap?
Not via pci cap.
Through more generic interface without attaching to viommu.

> Some devices may have device specific way to handle page faults, but I guess
> this is not the PCI PRI method you are referring to?
This was my next question that if page fault reporting and response interface is generic, it will be more scalable given that PCI PRI is limited to single page requests.
And additionally VT-d seems to funnel all the page fault interrupts via single IRQ.
And 3rdly, its requirement to always come through the hypervisor intermediatory.

Having a generic mechanism, will help to overcome above limitations as Jean already pointed out that page fault is a hot path.

> 
> > > -   Guest IOMMU driver fixes up the fault, updates the I/O page table,
> > > and then sends a page response with virtual completion data (v_rid,
> > > v_pasid, response_code) to vIOMMU;
> > >
> > What about fixing up the fault for mmu page table as well in guest?
> > Or you meant both when above you said "updates the I/O page table"?
> >
> > It is unclear to me that if there is single nested page table
> > maintained or two (one for cr3 references and other for iommu). Can
> > you please clarify?
> >
> I think it is just one, at least for VT-d, guest cr3 in GPA is stored in the host
> iommu. Guest iommu driver calls handle_mm_fault to fix the mmu page
> tables which is shared by the iommu.
> 
So if guest has touched the page data, FL and SL entries of mmu should be populated and IOMMU side should not even reach a point of raising the PRI.
(ATS should be enough).
Because IOMMU side share the same FL and SL table entries referred by the scalable-mode PASID-table entry format described in Section 9.6.
Is that correct?

> > > -   Qemu finds the pending fault event, converts virtual completion data
> > >     into (ioasid, response_code), and then calls a /dev/ioasid ioctl to
> > >     complete the pending fault;
> > >
> > For VFIO PCI device a virtual PRI request response interface is done,
> > it can be generic interface among multiple vIOMMUs.
> >
> same question above, not sure how this works in terms of interrupts and
> response queuing etc.
> 
Citing "VFIO PCI device" was wrong on my part.
Was considering a generic page fault device to expose in guest that has request/response queues.
This way it is not attached to specific viommu driver and having other benefits explained above.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

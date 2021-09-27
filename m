Return-Path: <SRS0=QBaT=OR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE674C433F5
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 13:00:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F62061052
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 13:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F62061052
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 631A080F53;
	Mon, 27 Sep 2021 13:00:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jFsy4z_hIc3j; Mon, 27 Sep 2021 13:00:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1024B80EC8;
	Mon, 27 Sep 2021 13:00:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC307C000F;
	Mon, 27 Sep 2021 13:00:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7599EC000D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 13:00:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56C0E404BE
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 13:00:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BQRaJZJf9jij for <iommu@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 13:00:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D9D740418
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 13:00:13 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="211716205"
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; d="scan'208";a="211716205"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2021 06:00:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; d="scan'208";a="436801063"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga006.jf.intel.com with ESMTP; 27 Sep 2021 06:00:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 06:00:10 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 06:00:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 27 Sep 2021 06:00:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 27 Sep 2021 06:00:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byg65NEELqLldNWHncqkAQ6Q91+l5lyqUebzldXsXuSGpXYv2dG/fCrtiCodozY0+GO3PUeJ96Ip+xPJLphEaNoNF/bvxpaWrqN6htHxw33zwjs30oKD10TwAuQGnCLzM3mL9nSIZ4EASNUQqisVEXOL38z1zV/poXaCbCTZqYF+uDzEmMWUj2kYJ0vhRVbxeQ/39fPNccQxP7CuydbtimASM7ykxeXJP6njvow9QRN0eM7ZnA7Y2fJfNyjsv/NSMfaG+rkCRishv3+H6qMk9aRBkFgDNEKTeUHxqCocOCOsUeya/yJFzaL90emARPm39+WnZcN/Gmf71P6OvQMhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=xGq1Hd7A668616g5OaMmSuJ/kuU7xlzaQHZIDrDMwyc=;
 b=fZOJ17qFZdBATKBRL56G3OZ2sacwnWnzqT05ANsT3dwBFJzBH9nhvnGIjVywXtXkSmi2zxiqWzNlSWmhsNJqkT4ojRH9YfDplFsycMrg0JjaDRDXzzPqkyhywqWvyLoG/xsI1qlKPQyWwXjPpwrS7plMfGFhkd2bzDrkl1xV6o072IfnJZMeJH+41bys5UuJuIaIIHuSBr+HxEJIi6IGLsnDI1e18bMljsUPtHgrFOxp3MUUDzH/vzM6Ep6Y04vLyGLR+LIDAGQQjMPzX8S9/yCrM7U76AaxuVTmsDdSCqdbct4+PO4gUhNVDrGS9xdqVhcrMYLn0pt32NVPtJDBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGq1Hd7A668616g5OaMmSuJ/kuU7xlzaQHZIDrDMwyc=;
 b=DUdSjQwkYNmzzdSlU/lsCHSEu3QMUpW6vB5+oesQYsa8Da7ErSHL4Ib5LI0wi6HzVbRsHHdJ1odWJxYLQMI0xKX8mFNlgsiUm3vaqnqFvzDiUMILCirxhXNR2wLGpmWRX/PyC0JTh933qs8lSw8UOFDEWaFTAFxQeTmf5zAD2JU=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR1101MB2084.namprd11.prod.outlook.com (2603:10b6:405:50::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 13:00:08 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 13:00:08 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma interfaces
Thread-Topic: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma
 interfaces
Thread-Index: AQHXrSF9WDj+Z+DU+UqMJ7tQK2EdmauuvK2AgACKnbCAALw6gIAHYVYAgABthQCAABACQA==
Date: Mon, 27 Sep 2021 13:00:08 +0000
Message-ID: <BN9PR11MB5433502FEF11940984774F278CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-7-yi.l.liu@intel.com>
 <20210921170943.GS327412@nvidia.com>
 <BN9PR11MB5433DA330D4583387B59AA7F8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922123931.GI327412@nvidia.com>
 <BN9PR11MB5433CE19425E85E7F52093278CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210927115342.GW964074@nvidia.com>
In-Reply-To: <20210927115342.GW964074@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7534eb1-78c4-4783-0331-08d981b6bb98
x-ms-traffictypediagnostic: BN6PR1101MB2084:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB208458D23AAB36E635CBB6E58CA79@BN6PR1101MB2084.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WX1cEgKupLYnsu9wyDurICT+HSdW1dJNKduobjk9JInduA2W7oxnVQRZWyOfVAhr40oLT4v4Dq4377unj7rxEqP/lS4WhK2clOoK49foY+NwN0569Kr6+P5V7AQDT8hupdUkOZYX2dJHIGXXtAfMvMLCzCCHzI8d5leckUslBjJoOBhxVfzx+heTPmvRezKSFEO1I7HqbsMkw4T5TmA5g6qVwNftyRHRGu9guUVm4oVJomg76vDnm7fehxlZIEjjOlr5SxQGmJqvc9cPrvSl+lJaWwobj1GX8k+S1RlIgZO1CtCNrh/NG/Iuy+4BvAoE4JdiXlXOy6UFYZ2USaIm75y85wwcOX/SE5P6RLekVlxmp5lJjhDHLfxOIbfSZ45tVKBYvxhmPEksYbEN25vCGftVvhmtExL6F2Rw//HNDA8dtj5/u3UxALlg3ZsfcLL/nEid9MCBcs35Bn1ea6DgMADum0qFXZOrMwlubeEg8b06cHC9pP1YmDwbElT9XDV61SJqKaLbukqjcY/7kZ0m/o138rN319sKiE6VFjClGEQhlETzkagX4HiKGgergXnsmC30v06cd/FO7Gm1miV5mIv/+IJWvn/MSiJEhWukGORSBfUCn7ezBg32xwj/0wGc45ZiLF2u9Yke4dGFjNVyYOCahq9tWhpj/UauORXwRx6XapufNSrJ0DAy1wGpLavYJYx1TiHlw4lmG83a2OV7WA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(52536014)(4326008)(316002)(38100700002)(66946007)(508600001)(86362001)(122000001)(33656002)(2906002)(8936002)(66476007)(66556008)(6916009)(64756008)(66446008)(9686003)(186003)(55016002)(71200400001)(7696005)(6506007)(7416002)(26005)(5660300002)(38070700005)(8676002)(83380400001)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B7/1qKbc8b3nVfv66jVmVMluGjrN0dmMHJ2d3kUY1uA4BPxFG+ADxajdl6Ux?=
 =?us-ascii?Q?bzuSm+wTG8jFFGe2PM7bIala1lsQnFj1Z1FldXqmAeqZ1NhHhIieeBvMA5oz?=
 =?us-ascii?Q?eHfXFIZaYk8vj3OrU+x8YmUOmS7eXkun6jI9jQ3RyoDmzNq08HqDXB7m2iKV?=
 =?us-ascii?Q?TtjSzrXlC1zUlOPcI7Uk3UwriJqtvSUW+gOmPazENfcqPtte7y01GywmA6Jg?=
 =?us-ascii?Q?KKIZz01GejkClrLHN9RoIhy6B5DwInc3kqlFt4DnbQn6xf/ewFiA4O3NgRan?=
 =?us-ascii?Q?T32cMKREJwj3hxyjvDE1355ZI9cCN1gTVD963TeNpVOaTe8FsElzXtAkDBt/?=
 =?us-ascii?Q?cY+Qn9FgPTAJQ+9bd/RfA11gg6kb6scoOSUSL1M7RWM6z+IBjX4ilq2FXOod?=
 =?us-ascii?Q?cthA1tyi5EjCXixlWBNtn2U8rFZ2UznFp1YMAe2zPp6Oi9N+5LrNeoN2RO0e?=
 =?us-ascii?Q?evHdNHlSHsZ5uO5iGoMPWBoDAQ0AKx3u6wVMtu0HjjfC/4XUXtQoJWb/676V?=
 =?us-ascii?Q?KuxN4dHMVhtf8u3/JUoTb2rdJV6kDC+/no6fXjYEAgfBQNjlk0/MJmkkheZt?=
 =?us-ascii?Q?ZVDZ0fXpOjyngH1aBrK1tTYYqxW420OKG2srfk4gMmxGftaOiLUfNW2ofvnr?=
 =?us-ascii?Q?zjFyFLszYr49y1yGpwCcolujgI8tjiiOLVteYo4aG7XQT8b5lWlxyMC3Rc2M?=
 =?us-ascii?Q?FxewQAcdM/x/q3+yqi2sEy78EhRhdku88nQM7k6rcXtAQ9RoH2XNhbsfjfJD?=
 =?us-ascii?Q?0aSGzhSm6VHC+9QJHKw/mISJSyykxA2nstTlRoAT8Mc7fwQzOuj4CkNAsj4f?=
 =?us-ascii?Q?KLayVkjIj5nHZ3oiqvcuV3xOO3JuDNkrOBk1EWSdDFjV/byLZQ+yKprj+Wr1?=
 =?us-ascii?Q?3Ik0pDt0JRO88ole1sqLkeMV2tVEwU71tnHjCKY8TbUX5uxDoNaqm7jezXAL?=
 =?us-ascii?Q?6xAVdEdrijitEYvLDT3cZOMR7aZtnnJK2RMYTxrWiH6Hfs81aA0zYevEdiId?=
 =?us-ascii?Q?nVtqgNEsbNne6XHMPTkdfERqS5LKfgvMEmK0AOJFeZZHozmlUQueBEBFQ3Wi?=
 =?us-ascii?Q?HjzgjWWEqcUmR1JDoLgFGXL5yijwasEafGo8qHayoA7e3YSPATxzz5aloC8l?=
 =?us-ascii?Q?gE93v6IlQYqF+pcgOiciwMZ5GCSV6z2D2Jukx/01J19Bt8MO5dXNvUQ13syw?=
 =?us-ascii?Q?IYvMCpzT+kYrajjFgVe8LnX3aWQDVbFRK2LYA//1kGuYoNU5gecZLj8aRRWR?=
 =?us-ascii?Q?W/G1zIYf6RplqPI6/I2yqYGNnonr1BOd4rkNSDjxuV9K+oHQjJKBLxH+jTW8?=
 =?us-ascii?Q?X+b+PcWAmBXD4YI12PAI0Pft?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7534eb1-78c4-4783-0331-08d981b6bb98
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 13:00:08.0311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: taExu+HyJHe0KQatxWih4F84vlv4gAv4W1ZW/BDs7ulO8sMI6PkH/vRD6rTj5ShOqVnf4C2irUJu9mQWx3bJuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2084
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, September 27, 2021 7:54 PM
> 
> On Mon, Sep 27, 2021 at 09:42:58AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, September 22, 2021 8:40 PM
> > >
> > > > > Ie the basic flow would see the driver core doing some:
> > > >
> > > > Just double confirm. Is there concern on having the driver core to
> > > > call iommu functions?
> > >
> > > It is always an interesting question, but I'd say iommu is
> > > foundantional to Linux and if it needs driver core help it shouldn't
> > > be any different from PM, pinctl, or other subsystems that have
> > > inserted themselves into the driver core.
> > >
> > > Something kind of like the below.
> > >
> > > If I recall, once it is done like this then the entire iommu notifier
> > > infrastructure can be ripped out which is a lot of code.
> >
> > Currently vfio is the only user of this notifier mechanism. Now
> > three events are handled in vfio_iommu_group_notifier():
> >
> > NOTIFY_ADD_DEVICE: this is basically for some sanity check. suppose
> > not required once we handle it cleanly in the iommu/driver core.
> >
> > NOTIFY_BOUND_DRIVER: the BUG_ON() logic to be fixed by this change.
> >
> > NOTIFY_UNBOUND_DRIVER: still needs some thoughts. Based on
> > the comments the group->unbound_list is used to avoid breaking
> 
> I have a patch series to delete the unbound_list, the scenario you
> describe is handled by the device_lock()

that's great!

> 
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 68ea1f9..826a651 100644
> > +++ b/drivers/base/dd.c
> > @@ -566,6 +566,10 @@ static int really_probe(struct device *dev, struct
> device_driver *drv)
> >  		goto done;
> >  	}
> >
> > +	ret = iommu_device_set_dma_hint(dev, drv->dma_hint);
> > +	if (ret)
> > +		return ret;
> 
> I think for such a narrow usage you should not change the struct
> device_driver. Just have pci_stub call a function to flip back to user
> mode.

Here we want to ensure that kernel dma should be blocked
if the group is already marked for user-dma. If we just blindly
do it for any driver at this point (as you commented earlier):

+       ret = iommu_set_kernel_ownership(dev);
+       if (ret)
+               return ret;

how would pci-stub reach its function to indicate that it doesn't 
do dma and flip back?

Do you envision a simpler policy that no driver can be bound
to the group if it's already set for user-dma? what about vfio-pci
itself?

> 
> > +static int iommu_dev_viable(struct device *dev, void *data)
> > +{
> > +	enum dma_hint hint = *data;
> > +	struct device_driver *drv = READ_ONCE(dev->driver);
> 
> Especially since this isn't locked properly or safe.

I have the same worry when copying from vfio. Not sure how
vfio gets safe with this approach...

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

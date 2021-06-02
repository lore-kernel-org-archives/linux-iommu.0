Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3360DC47093
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 01:33:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF01B613CD
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 01:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF01B613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 831704030B;
	Wed,  2 Jun 2021 01:33:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KvjNQp8GIJk7; Wed,  2 Jun 2021 01:33:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24FE340338;
	Wed,  2 Jun 2021 01:33:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2BFBC000E;
	Wed,  2 Jun 2021 01:33:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE494C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 01:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C39F183A54
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 01:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RJ-e3Labe0E4 for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 01:33:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0126883A3A
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 01:33:27 +0000 (UTC)
IronPort-SDR: fhD6csrgjmOreugmxT5ByTuYVpzAKq6uTcUUfI2SK1Uc5KN/I+uOLFHQD2m01HpiWsHL8oNSrY
 h9Ja5MlyUQuQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="203492578"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; d="scan'208";a="203492578"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2021 18:33:26 -0700
IronPort-SDR: 7Vp8Y8wg9o9VI9oZ9X+TY4euu2d/Oe38rzn1R8Wok/Lte58oWklmxpuH9ZmRnwINmSfxyWdIlo
 285XqGvX3JJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; d="scan'208";a="474453776"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by FMSMGA003.fm.intel.com with ESMTP; 01 Jun 2021 18:33:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 18:33:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 1 Jun 2021 18:33:24 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 1 Jun 2021 18:33:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3yFYrGxFgwT/lOWouyxzSVmBiBZqefk+HhJQQIswi0Tou4g3yubK2pKefAfjPi+/OkA685RIcBBzhVWuLGlI6aWW/jOLaSrjBjHnRSrrPdJSULhe7+m2Z63dBU9IDhzNVpo/PanCFzZUNBSLn+jwb1H4iPbvoTScXQb5T205hWoEvZH4eTOYtYyBAsvihFJe5SI1v86lt6WdvPSrAQD5o/IyTid2npMizU8inF4dnn/LETDt0FXT17dP/ASGtiaZV/YxQJ4eJpTkA1vnobu4ULTyZP5EiTgWlFsvrWhf1De3laEmhudx8C/OnA5SCsBfep6vLK6w1OaiskRQ0z5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH82U3yDPlUoLZqBE3Z1PKaRCqkYpgTLUOWPqGtlhnI=;
 b=llvGTQa2ftYV1ADcK9J8nkL3NVmoOGUs4ZkG4ARoSyXDxObCnW5T6GLb6rY56sHnkxVrYN5aIa5FdjeEGSXsIf+Z/LPHS70StjaCsXpXII+zzFw5TL6nTDdIvLOH7OVhlGbnQYveuGL9gEHm8rc+mUtBYTgQuVNXShEAZ7wLdkJHn9xtDVxRytzafj5wXjaD6gqKqlTi4WZTxswk+RoebGAjZY4ZvwvjgjJ3GH3zbJ5IO7z6jmS0N6qfmvstCVmogcfFQ5Q2kAdaIO9MT55oFW2ju0mOeXOvLpHFMa2vyxUV22pX0IvjKEfpySik8G+rQvCOrX9aOLaYISO/oVqSCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH82U3yDPlUoLZqBE3Z1PKaRCqkYpgTLUOWPqGtlhnI=;
 b=ZoCi2ZaCDdf3lHw5TBfF/UH6HilE47TWvUvR8+h1FFrdM6TadBI4fBPHxqhtQi6B9TyUvXRWSokdWs09MnDkN9gHj1JRG2/4LNnbJbyH9dRRutw2bv2pmBokLIRHWvyG4MccoILbzCbVTRoBIMyHXCiBtchoV5LPPjrba4IB+mY=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2301.namprd11.prod.outlook.com (2603:10b6:301:53::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 01:33:22 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 01:33:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwBGs/UAALTRUxAAFJZWgAAQLFRg
Date: Wed, 2 Jun 2021 01:33:22 +0000
Message-ID: <MWHPR11MB1886283575628D7A2F4BFFAB8C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528173538.GA3816344@nvidia.com>
 <MWHPR11MB18866C362840EA2D45A402188C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601174229.GP1002214@nvidia.com>
In-Reply-To: <20210601174229.GP1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.143.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18c7cf2c-67ab-4adc-c693-08d925666911
x-ms-traffictypediagnostic: MWHPR1101MB2301:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2301B88DA09678E70DD755428C3D9@MWHPR1101MB2301.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WgsCWzilX66sI2TCn/Lid3c/Ear0BhUYPciMzC9jvNI850WIpuFHZQWslYXibtD14VEDwlnPNVpVvFhN4yadgQgx37hl2jAfYJ2DI71Aq5MnDFd3giNxqVn0D/j5fQw2bYxEMmrUS0YHVFIe+c9G1CImDdUQsbGt0xQS2MIviDf6sk3luoHYfFVdZ9OaMGI3dtmUkZnKURpNp6XPCpsETz6LwQAGPkfJpV1TYwdY1NYiTTF2/oDmLdqTC0pKXp4Gpn9PPpT+xjAqYh3SytdfNQQOPacZdGIRbeYUtR6Y7zsQKQHPNClZi+t81a4l9Mfa7OvxmjZD9qWmIFEAqoC09aSxMijPSAXbz868dUgEh3Sqclh+WWv6A8iVKK15SemJwSFTnIlTZcucUiZ6c4yWtx59YjYCVoKRwbi+G4nvBAtriYm3pq5LBkUIIYX16DPAGKXr9X4sWMxpOWAJAnBkdGc291d3hFwElw0pD4RrW0BpWA/G60vCSCJ7DirJeP55eRh2oONHq/BOORt3baoG1RmlYswE1rzLxka86Q03gKHA7T6JsE32HPG4Dnz4w62gRbji/U4tWqTBTkvbCJPDk92sOVrdpTJOyxbXdhfLkb8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(366004)(136003)(376002)(346002)(396003)(6506007)(7696005)(316002)(54906003)(71200400001)(33656002)(2906002)(26005)(76116006)(122000001)(4326008)(55016002)(8676002)(7416002)(8936002)(9686003)(6916009)(38100700002)(86362001)(66946007)(186003)(83380400001)(52536014)(5660300002)(478600001)(66476007)(66556008)(66446008)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hXbnnLs7mxGvMtrGNwRpCJ7CZehZgUqG3xNfCMl5G/B25A789bZmBHiSwkuM?=
 =?us-ascii?Q?koiB3X15HebKdNLXhMYgK+LHDSp7zqSPLOmSuBQrwnMhXQfw0q9NtgRf0vAM?=
 =?us-ascii?Q?63x9pkroK1zponuvfBkMhx/8VxawYarCBdiqJM1kkY9kj8QaevtHV+fIVZ9Y?=
 =?us-ascii?Q?VvsMJ9E+y/q4TG4NmsN+w5EeUZ2Cwjs9i13vkByncZXtgB5tQk2qBiJelV8o?=
 =?us-ascii?Q?4GSKw+7fjeNmBXiOUjsfdKF0gEX7OAYE5gTBbksR4Y+m8Z2GbjPNkAhwBbHj?=
 =?us-ascii?Q?q4UHxhSUCgJFaas5K4Ur9+Rck8tk/RXOV3/C5TwcYn9OJYwTAfrxaPW1URI2?=
 =?us-ascii?Q?1nNfrwIj/27Jwr9qRRq/3glH7spGlAT4BOMxa8X5qodld09gUFb/5HHsoo1s?=
 =?us-ascii?Q?8S1WCSboBnz/RTpTbwN66z5DHSj8UC5658mo3QXybAf43gun7Z+6i0+/O2xa?=
 =?us-ascii?Q?4fsBiKFV5uKbej7V+XdxGUuSrQcZfUbI674S9Bd9uzjMoNek1hMp5R630YBQ?=
 =?us-ascii?Q?dREzc7NimetYkCIcHxHqE6BgKGXj8dqjUzvjpGPAhe0Q63qKx6QeFnXYzOOD?=
 =?us-ascii?Q?ykeUx8rcXebl11KMjk3QwyNYwEKH7lVd7gZrlpFLKmgJlexPKqHppoz2uZM1?=
 =?us-ascii?Q?kyuHXwcHc18mNATlxX7DAmhmZbKwMp7sX09ug9VgtKavHWo3QUFFXpRwc+Op?=
 =?us-ascii?Q?RK2T4YEaoiSQ4dltMcnI2k8EJX1VZXutGskjlsqd9e2M/zkvejcCkPdOen8Z?=
 =?us-ascii?Q?ENOLI4yu3CGz3+ttqg0zOL7Uwodnvk/6w57+Mja9sDBEvlp6C32QwfE9T+wA?=
 =?us-ascii?Q?QSVPW7na77b24ogPL0IOy2B81IizPZLAWmQxz0kpfxzZyBjkOaP1kk5VxNXX?=
 =?us-ascii?Q?kFWhnDYU0kDIxL4obd4gH5pClaSxGmAMZ1hMrc6IonrsVB+U5gi70Bm/daol?=
 =?us-ascii?Q?tK3zyQsYqZUZ3oFah5qA5Ud2bzTWNhTB5WRePLUjvVPqyUxTonzEh44nZIQU?=
 =?us-ascii?Q?iphl6o/OEKa/rGZhtfmqiPdBpPpC3ResiugM5TsuxZIMdZXu6b6sGurjVQlT?=
 =?us-ascii?Q?oylFPmn3GZ2JtO+oMwClC8f5juglQP+c+YsfqGMlTGobEMkQdVrs2s/6/9aL?=
 =?us-ascii?Q?G7GFTmj6CXuxKX1BxHsYtS5laqUmn25y6adbf4zBB24FJI/pDE1GftX8SXE+?=
 =?us-ascii?Q?Y7XzwZ9KJX1KMEf9KMXYOH4+zH2OC5bs+iCVieowguxGurB2WNkOUwhVZik3?=
 =?us-ascii?Q?fZFFNRRdUFjLqxX0jrLs2INvUN1114/4g/q+/ar1b4R4an/9jrYmcL1Nn/Vy?=
 =?us-ascii?Q?YumXXoaUQoVwaD3q0TWWoJc9?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c7cf2c-67ab-4adc-c693-08d925666911
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 01:33:22.7651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKD0UrNKYW7S7pmZ1FLRau/9FqMC+Ad7lCSk+c9LpejUIQmi6InTEIozDjB9kTcRnUpYIOOhJHLTcJCC7bNwwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2301
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Alex Williamson
 \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Robin
 Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, "Jiang,
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, June 2, 2021 1:42 AM
> 
> On Tue, Jun 01, 2021 at 08:10:14AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Saturday, May 29, 2021 1:36 AM
> > >
> > > On Thu, May 27, 2021 at 07:58:12AM +0000, Tian, Kevin wrote:
> > >
> > > > IOASID nesting can be implemented in two ways: hardware nesting and
> > > > software nesting. With hardware support the child and parent I/O page
> > > > tables are walked consecutively by the IOMMU to form a nested
> translation.
> > > > When it's implemented in software, the ioasid driver is responsible for
> > > > merging the two-level mappings into a single-level shadow I/O page
> table.
> > > > Software nesting requires both child/parent page tables operated
> through
> > > > the dma mapping protocol, so any change in either level can be
> captured
> > > > by the kernel to update the corresponding shadow mapping.
> > >
> > > Why? A SW emulation could do this synchronization during invalidation
> > > processing if invalidation contained an IOVA range.
> >
> > In this proposal we differentiate between host-managed and user-
> > managed I/O page tables. If host-managed, the user is expected to use
> > map/unmap cmd explicitly upon any change required on the page table.
> > If user-managed, the user first binds its page table to the IOMMU and
> > then use invalidation cmd to flush iotlb when necessary (e.g. typically
> > not required when changing a PTE from non-present to present).
> >
> > We expect user to use map+unmap and bind+invalidate respectively
> > instead of mixing them together. Following this policy, map+unmap
> > must be used in both levels for software nesting, so changes in either
> > level are captured timely to synchronize the shadow mapping.
> 
> map+unmap or bind+invalidate is a policy of the IOASID itself set when
> it is created. If you put two different types in a tree then each IOASID
> must continue to use its own operation mode.
> 
> I don't see a reason to force all IOASIDs in a tree to be consistent??

only for software nesting. With hardware support the parent uses map
while the child uses bind.

Yes, the policy is specified per IOASID. But if the policy violates the
requirement in a specific nesting mode, then nesting should fail.

> 
> A software emulated two level page table where the leaf level is a
> bound page table in guest memory should continue to use
> bind/invalidate to maintain the guest page table IOASID even though it
> is a SW construct.

with software nesting the leaf should be a host-managed page table
(or metadata). A bind/invalidate protocol doesn't require the user
to notify the kernel of every page table change. But for software nesting
the kernel must know every change to timely update the shadow/merged 
mapping, otherwise DMA may hit stale mapping.

> 
> The GPA level should use map/unmap because it is a kernel owned page
> table

yes, this is always true.

> 
> Though how to efficiently mix map/unmap on the GPA when there are SW
> nested levels below it looks to be quite challenging.
> 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB18CC63793
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 06:02:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D8161279
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 06:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D8161279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DDE14035D;
	Thu, 22 Jul 2021 06:02:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OOJ0ZZUheHKl; Thu, 22 Jul 2021 06:02:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 849754031F;
	Thu, 22 Jul 2021 06:02:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CD7AC0010;
	Thu, 22 Jul 2021 06:02:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94A38C000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 06:02:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6EC0A400F6
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 06:02:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EbelfbOyYmjN for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 06:02:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 91BBC400C2
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 06:02:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="211635147"
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; d="scan'208";a="211635147"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2021 23:02:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; d="scan'208";a="658695473"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga006.fm.intel.com with ESMTP; 21 Jul 2021 23:02:18 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 21 Jul 2021 23:02:18 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 21 Jul 2021 23:02:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 21 Jul 2021 23:02:18 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 21 Jul 2021 23:02:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQss5NlI1At/NocvumFn/q6qkqCkDA4F2pORHbbfwOxS8LD6jG/S9JMHyzziWHncYdvwmbdM1CN9WW2EypM+B9Qoh/zBkYmgMwkX7Wje/8DR13MAVGMQM1GHpUWSQQSJk/LiTOr7lhjxCeTeI3v7ttXL5Y0JqpI/JXqMF7FRQsLA4twR2Qi+y4bTZh88R1CbAFt8JlhuArSJZ5uC8/MWj+yO2FJCoIBl8xmDlyK/Y/y38PRi8gFql3jON7Ddf/8sLUDOe065d0dZbgbtc4K1PlwR0CcFNncEgE0Q9fwqmEMJeC0Fq8um0JDFs1stzePzbdR1joFHx2u9JEv+wg5w7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5B2NhXER1RwlFGASL/iPTIvitNQ8A5xbCDbRMogDEc=;
 b=bMHpYNBp7FJMeNibblP9iG7C9bSUkoP7tELajLhOqI/ar+B4TFRZ3DXpJsN4XV783wwRmc80VMuFwMCV2TPplRlIXdWT0ZL+SFjeMDU0z3uaMaCkZMzxeDzo5aUD/mwj7vYAsmwQaBpH+4rzNjWI49CJtcMyp/PusJEJSRJ61qXQ6gf+F9JHHwE1nza1fZtLCvO9fyfVOXxAtIK2YoawmdQzfuith3OhDWEYLeo1YtMJIIQNQTgwM/QSXZBxlZMXtbWLeVYj9EtlIY+ar0zJA4WrgkYaxao0WTjZ+9749s0J/W8CpLRVVAL7NA/cECph5/3VEwmXUP6qyFClsg9NJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5B2NhXER1RwlFGASL/iPTIvitNQ8A5xbCDbRMogDEc=;
 b=xKYDKeEmd0WWCuMHaDwHWpGuJ+YAmbEKKrlgAnH9BAmjxxi8HFFF1jm6nOKsd2Ach4Y6Z2yq8GSDzcUkmvsx9yATlHgWI9wCt6Uz2fnO5PGb5difZx8bGaLjYz560fYm0N62SmjX2ba1k9cFNiUPEZzsuCUfeE7GJrHXQkoPeEQ=
Received: from BL1PR11MB5429.namprd11.prod.outlook.com (2603:10b6:208:30b::13)
 by BL0PR11MB2961.namprd11.prod.outlook.com (2603:10b6:208:76::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Thu, 22 Jul
 2021 06:02:16 +0000
Received: from BL1PR11MB5429.namprd11.prod.outlook.com
 ([fe80::ec88:e23e:b921:65ea]) by BL1PR11MB5429.namprd11.prod.outlook.com
 ([fe80::ec88:e23e:b921:65ea%8]) with mapi id 15.20.4331.034; Thu, 22 Jul 2021
 06:02:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Thread-Topic: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Thread-Index: AQHXRWldX98a1U6w60C1HwYkmNlXK6rc3tAAgAPcBcCAAJmdAIABJmdggAASuMCAAF5dgIAAAFGAgAAT44CABKOLAIAAAkEAgAAGdACAAAupAIAAIZMAgESRwUCAIoe14A==
Date: Thu, 22 Jul 2021 06:02:15 +0000
Message-ID: <BL1PR11MB5429D7252D43A866E57D1F5F8CE49@BL1PR11MB5429.namprd11.prod.outlook.com>
References: <MWHPR11MB1886E02BF7DE371E9665AA328C519@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210513120058.GG1096940@ziepe.ca>
 <MWHPR11MB1886B92507ED9015831A0CEA8C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514121925.GI1096940@ziepe.ca>
 <MWHPR11MB18866205125E566FE05867A78C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514133143.GK1096940@ziepe.ca> <YKJf7mphTHZoi7Qr@8bytes.org>
 <20210517123010.GO1096940@ziepe.ca> <YKJnPGonR+d8rbu/@8bytes.org>
 <20210517133500.GP1096940@ziepe.ca> <YKKNLrdQ4QjhLrKX@8bytes.org> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16120f51-9202-4612-cb55-08d94cd641c6
x-ms-traffictypediagnostic: BL0PR11MB2961:
x-microsoft-antispam-prvs: <BL0PR11MB296108CB030176F46859F9CC8CE49@BL0PR11MB2961.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YJIi88+ZRdAUUPi9h7arrDXHa7ihe5tLap6dbeOmzUCKsVxPSTNx5DhETtkrV1IXnLn5XG64IdHNqNbOonaptX5U1NCean/1E+MnMgPrFGHEBhwzH40aGfkHJaXjb/+RzUP4az5Lj9dwQGrDtkIAw1MitOSOgephQk9iDNj27eKxtW53/i8i9TetQGNbcj5NwiSk6q+D4cekwOrAFCPblLqiaPrlX5Il4GX1ZhUhh3DAIjnyM1Bb7oaGlwEIhplggtN4F10VuUN1ApwHS172yhiljtvDPZidJJQfxqm+DLOmclETxbucA7EILiiZkLIvEihV8uRHMEq0s4hBf0FXrfwCuY9om6iUyj2HA7QJXxhuIOa7DWpbXcFBKVOeSG+Lvjt21SH89A9nAVY2dwTpFqGNLH3z0nIQjvsqBApE2vIm/bfOYlcw9n9G2/sk9dfL7aSZGPD2Ns9rQvx4Uq692JagRRxx9a0pCyr545OdmnG6AbCzcxPZiU2T4odbldCtDF4ajb1/kX23dMyZxNG9H9rNxaZE75612uTEc1+KOHPdN4AbfhpgxpSYZMgld2vtsD4LY/cAB8g5ETaDNzwyUXuJHGqLsqfC75DIjzJJU7vHo5hC2ux5nfk11ulN2YUc9YafWe91MIlIwcYBWf929/9braPCVNDozQ82b8tyMVG1vFURxzuYQaB9m9btpRMgdI+A8LCJQp9pK8iUSFcitA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5429.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(6506007)(8936002)(2906002)(66446008)(122000001)(66556008)(64756008)(66946007)(76116006)(66476007)(83380400001)(26005)(7696005)(186003)(4326008)(8676002)(86362001)(33656002)(38100700002)(52536014)(316002)(5660300002)(9686003)(110136005)(54906003)(478600001)(7416002)(71200400001)(55016002)(38070700004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CrGMUQ+h168BcH+CQUayq9ifpmLE64687WDa1cAArsHNNd1BS+gDY9faRNrd?=
 =?us-ascii?Q?SpmjrK11f54NKw+kriab+qxSOQRPBRl4w/EKyAFwVHkfcpDo9u2Rk3j5Iyjc?=
 =?us-ascii?Q?Uw9EL8GH85ebW3h+WojoyUrdwz6vnQcB2sEtyGHJjhutzRcoCUP6wVVM2dHL?=
 =?us-ascii?Q?rsLo2ABeBkDTROFOgBQs1Xl/sHZnvH+VzR+G4+sXBBT5RcGbAPVJjN2wI8Wi?=
 =?us-ascii?Q?6M81U5jXXrmqaxQLjOJHC/thGTshsBfSqqpTdFbAkjjlA93gWIdOMpE0NJHd?=
 =?us-ascii?Q?wWgIl5V6qFZavNSO3mg13oYfSZhhegM9ch8UK3lzCZizczYQP6RMGcxcZnU/?=
 =?us-ascii?Q?HUeFBwCMzCWflM3kVE6cyDekTrsM+gUqAm/vcLJVvIck0PcBceCPuRCf+mK6?=
 =?us-ascii?Q?x8pYBD+Ra5OSKANmGI6pQ18gyNgJESoZJ29XuChe+2WMDqLAQNCAQ8OR5lYT?=
 =?us-ascii?Q?/DPnt/61mYvMDSzRqVUzEyQ9RAYAZ+knRqQKl+fmHHFQMFcLvgHDJ9E03gjh?=
 =?us-ascii?Q?eLwdfjV2O3dKxm71CcI6/MjmRxPgCi04EZEmeCXNpVGZCxATkV6qTGurDdFH?=
 =?us-ascii?Q?u+7gDiIpp+nF+6D83ETE6Izqh7aCAyovevWPmWbYZwupN/H1srmQMP1G9Msm?=
 =?us-ascii?Q?4yfUBowcG2Aje+Ru6h6MqN7H9Is7/HWxMHU661AoZ5lyNKaZRqundJbuvi9R?=
 =?us-ascii?Q?sYdo873I7fhCpOL1lzVZyZDhg8+jfa0himghIxxJ6UFoIV/h7PjrDKInRspQ?=
 =?us-ascii?Q?TU/uJuBn37vbofdT6V2Yq5RkevTk4hUnkq6hrBzf7KjYzWEf0LoIuwUpfjXl?=
 =?us-ascii?Q?Ul4OQbfw419BvKrK6NZxT+D7RV1RnZ5HSf9VVb3wqD2tBFMIDpDEajSrxF8q?=
 =?us-ascii?Q?pXLaXRwK4ov4WeJhFHKo8TcBLpEpFU6czCWB7yslODfA1+pwoj7LO8c3lNeb?=
 =?us-ascii?Q?bzpWAl/ePesfZRoE2H3cKG/aF+yGoD+FGjeWYa5vcdraInKs0Y08HvB0uyUR?=
 =?us-ascii?Q?+ryRuxorT8GeI6u1m8/NAgNwYaDL01qvMaF31lf9MkcbWG78KKLizICjSbVV?=
 =?us-ascii?Q?7FBlxKPBL+jCfEF2/JsuErwkdQzXVcwLqe0UdRwDQqmwDbcFScKzYfS0YOtx?=
 =?us-ascii?Q?O5CnyGGyjNiPA1Hy1ljvL4BHwZfORM0TYW7/Vsn6E8vTB1KUGhF+moi9SOja?=
 =?us-ascii?Q?cFTKrKVPqPfK/uskkpyx0gwCHGP22DyCZGWpdiCh8/VW5JUCb5hb6l00xV1i?=
 =?us-ascii?Q?4lnDFy95hhopleKDUFtmoJoc5111P/zf4osuUDTbBDSG6M95gLtf1azeIARj?=
 =?us-ascii?Q?tCzEwqKDYkHp/sjNwI5cLG41?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16120f51-9202-4612-cb55-08d94cd641c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2021 06:02:15.8730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: truWaLC82uQatGav0ZU7WSWYjJchCzyMjNW62N4XOXXHr08tFZ0gDnbIVOyb9whUWM1JRlRDd9l3Bpiy4SqywQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2961
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

A gentle ping...

> From: Tian, Kevin
> Sent: Wednesday, June 30, 2021 5:08 PM
> 
> > From: Joerg Roedel <joro@8bytes.org>
> > Sent: Monday, May 17, 2021 11:35 PM
> >
> > On Mon, May 17, 2021 at 10:35:00AM -0300, Jason Gunthorpe wrote:
> > > Well, I'm sorry, but there is a huge other thread talking about the
> > > IOASID design in great detail and why this is all needed. Jumping into
> > > this thread without context and basically rejecting all the
> > > conclusions that were reached over the last several weeks is really
> > > not helpful - especially since your objection is not technical.
> > >
> > > I think you should wait for Intel to put together the /dev/ioasid uAPI
> > > proposal and the example use cases it should address then you can give
> > > feedback there, with proper context.
> >
> > Yes, I think the next step is that someone who read the whole thread
> > writes up the conclusions and a rough /dev/ioasid API proposal, also
> > mentioning the use-cases it addresses. Based on that we can discuss the
> > implications this needs to have for IOMMU-API and code.
> >
> > From the use-cases I know the mdev concept is just fine. But if there is
> > a more generic one we can talk about it.
> >
> 
> Although /dev/iommu v2 proposal is still in progress, I think there are
> enough background gathered in v1 to resume this discussion now.
> 
> In a nutshell /dev/iommu requires two sets of services from the iommu
> layer:
> 
> -   for an kernel-managed I/O page table via map/unmap;
> -   for an user-managed I/O page table via bind/invalidate and nested on
>     a kernel-managed parent I/O page table;
> 
> Each I/O page table could be attached by multiple devices. /dev/iommu
> maintains device specific routing information (RID, or RID+PASID) for
> where to install the I/O page table in the IOMMU for each attached device.
> 
> Kernel-managed page table is represented by iommu domain. Existing
> IOMMU-API allows /dev/iommu to attach a RID device to iommu domain.
> A new interface is required, e.g. iommu_attach_device_pasid(domain, dev,
> pasid), to cover (RID+PASID) attaching. Once attaching succeeds, no change
> to following map/unmap which are domain-wide thus applied to both RID
> and RID+PASID. In case of dev_iotlb invalidation is required, the iommu
> driver is responsible for handling it for every attached RID or RID+PASID
> if ats is enabled.
> 
> to take one example, the parent (RID1) has three work queues. WQ1 is
> for parent's own DMA-API usage, with WQ2 (PASID-x) assigned to VM1
> and WQ3 (PASID-y) assigned to VM2. VM2 is also assigned with another
> device (RID2). In this case there are three kernel-managed I/O page
> tables (IOVA in kernel, GPA for VM1 and GPA for VM2), thus RID1 is
> attached to three domains:
> 
> RID1 --- domain1 (default, IOVA)
>      |      |
>      |      |-- [RID1]
>      |
>      |-- domain2 (vm1, GPA)
>      |      |
>      |      |-- [RID1, PASID-x]
>      |
>      |-- domain3 (vm2, GPA)
>      |      |
>      |      |-- [RID1, PASID-y]
>      |      |
>      |      |-- [RID2]
> 
> The iommu layer should maintain above attaching status per device and per
> iommu domain. There is no mdev/subdev concept in the iommu layer. It's
> just about RID or PASID.
> 
> User-manage I/O page table might be represented by a new object which
> describes:
> 
>     - routing information (RID or RID+PASID)
>     - pointer to iommu_domain of the parent I/O page table (inherit the
>       domain ID in iotlb due to nesting)
>     - address of the I/O page table
> 
> There might be chance to share the structure with native SVA which also
> has page table managed outside of iommu subsystem. But we can leave
> it and figure out until coding.
> 
> And a new set of IOMMU-API:
> 
>     - iommu_{un}bind_pgtable(domain, dev, addr);
>     - iommu_{un}bind_pgtable_pasid(domain, dev, addr, pasid);
>     - iommu_cache_invalidate(domain, dev, invalid_info);
>     - and APIs for registering fault handler and completing faults;
> (here 'domain' is the one representing the parent I/O page table)
> 
> Because nesting essentially creates a new reference to the parent I/O
> page table, iommu_bind_pgtable_pasid() implicitly calls __iommu_attach_
> device_pasid() to setup the connection between the parent domain and
> the new [RID,PASID]. It's not necessary to do so for iommu_bind_pgtable()
> since the RID is already attached when the parent I/O page table is created.
> 
> In consequence the example topology is updated as below, with guest
> SVA enabled in both vm1 and vm2:
> 
> RID1 --- domain1 (default, IOVA)
>      |      |
>      |      |-- [RID1]
>      |
>      |-- domain2 (vm1, GPA)
>      |      |
>      |      |-- [RID1, PASID-x]
>      |      |-- [RID1, PASID-a] // nested for vm1 process1
>      |      |-- [RID1, PASID-b] // nested for vm1 process2
>      |
>      |-- domain3 (vm2, GPA)
>      |      |
>      |      |-- [RID1, PASID-y]
>      |      |-- [RID1, PASID-c] // nested for vm2 process1
>      |      |
>      |      |-- [RID2]
>      |      |-- [RID2, PASID-a] // nested for vm2 process2
> 
> Thoughts?
> 
> Thanks
> Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

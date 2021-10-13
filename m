Return-Path: <SRS0=x0pP=PB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBCFC433EF
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 07:07:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818E661039
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 07:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 818E661039
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A9DC407C3;
	Wed, 13 Oct 2021 07:07:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jOhtNd6HmxS5; Wed, 13 Oct 2021 07:07:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 25C834073D;
	Wed, 13 Oct 2021 07:07:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED7FEC000F;
	Wed, 13 Oct 2021 07:07:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 370ABC000D
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 07:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1668E40751
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 07:07:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A-1sYkyccg8C for <iommu@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 07:07:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E7E14073D
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 07:07:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="313565063"
X-IronPort-AV: E=Sophos;i="5.85,369,1624345200"; d="scan'208";a="313565063"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2021 00:07:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,369,1624345200"; d="scan'208";a="460674249"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by orsmga002.jf.intel.com with ESMTP; 13 Oct 2021 00:07:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 13 Oct 2021 00:07:44 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 13 Oct 2021 00:07:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 13 Oct 2021 00:07:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 13 Oct 2021 00:07:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROpxqmuZimSElWhqz2Ptm2U+t65UqfrvBLzcLGZfET+U4yoJNbuLlt9QbiaQ5f1iWULaEeSURcR7fSSgwAEuuWhSlW2W5vF4dSe1kL3WL2ceKQJEqOtGOkBPdBlEZkW+RjsAAfag7QDn1oJ+9uj9HvLszrBkMv/bBlLkXLFOji1Iyt9T3zO+TRgZXrOS/A+4UU4ORdRinG5nLCMG1GGzBVZX5GmUQHwllh7QepFlrIDYqvfEUeNLjuvwAZZ+ZreJlMXTAKHNLU2n7iaaKxATwtZAyjai1i14GeGH7GKDvKMTdSy0QMT7/OhlYKELDe8xxDQQKHC9F62AN2h8FtoCaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wo6hsvSCSMMEfOF6RHsionIX/izHnLmvH7jqKu9ns/8=;
 b=SHeUFqVUQ1bp3Zj9dFBOs4QQ2KJiHBDzFkAs9HIZxDdK8Rp4E7bQSxlm1DfOXGi7qwt7tfwY4u0Sv2Qp1wN/3ONfr/C5e2K/nAmgwQgjBnjUXoMxlio1oHZsY7WkBnnkE5pDjBGGMsLiCBKntJBCx//Ms29b9+hhwqM4NtJnxHsziMsxNRDFPcuXDCdf9zKwaGFgyK3bZMzRmaXbe2HttVyHsL8LNH2Cpe3GLutVB4Qcqxba/vI6Z6JABOtZmpQ/as5BWkVZ/0nqP9wvJdsTrBmxRjp79TiUC/48Jr3BXiUqYs+4la+1UimyBRZxF23omx6OzjagwzxU0UG6N/wpAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wo6hsvSCSMMEfOF6RHsionIX/izHnLmvH7jqKu9ns/8=;
 b=dSOOWKfJkCZ9PvSCY/Z/VNO7oOhjE8LxUstWvcxCtPLaZ52qSbbTBN7AW9rWwe6oA0oOqkiG92QFAqMVSJwSXdJyPRJ1RaFnLzdzi3nLukDSvULcm0QpRPhlg0+ULT+LqQj7EKSkTCzcewKeVG0KjBTqDrlySlWNEPINLzgkbzg=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB1938.namprd11.prod.outlook.com (2603:10b6:404:105::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 07:07:34 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%9]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 07:07:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: RE: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Thread-Topic: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Thread-Index: AQHXrSGPLoYXtOF3o0iA7Cse+/LM66uuxm8AgA72WACAAGbxgIAPTQiAgAAu7ICAAwY+cA==
Date: Wed, 13 Oct 2021 07:07:34 +0000
Message-ID: <BN9PR11MB54333A0E5C7BD4F8996693278CB79@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com> <YVanJqG2pt6g+ROL@yekko>
 <20211001122225.GK964074@nvidia.com> <YWPTWdHhoI4k0Ksc@yekko>
 <YWP6tblC2+/2RQtN@myrica>
In-Reply-To: <YWP6tblC2+/2RQtN@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29f9d70e-c145-4a3d-c0f5-08d98e1821cf
x-ms-traffictypediagnostic: BN6PR11MB1938:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1938B313240B515DBAD0C7EA8CB79@BN6PR11MB1938.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IaRBoMOFHZ9h3rb3uLohavwz7L2bCiGzrRGlYxX8UTT7XCw/y8lpO9naC7QDVQyqattfZVHeKB91A3eUR9N4PKlryNqEuf4uMsSVjFAgeWTUG0yHiR1AcXckjydrhS0hhoWrxW4dsbzwfn7+F0JhG8ane502nyftD3ftfzMKuYxzXXt7YNc5Fm5IgFQCSMLRY/WEA/iRFwpb0g+R09xj6LkGE4eC59hJo19wl3lU6rsyZrGB6VCjThpSRBJSBBIzD5ZMF55t89Q9aRu5bh1V9zCDSS7WRkzvzfKLXNVAhIjNboMDnHRwtGYMElZOD4RnBjj+u/D8R/+Zzc8bTgVu/fYKdz2VPX37T6JNjr+dAsOf0zTWA+0KAHo1OMzNeiQkwVtx0iyoeIyVUYtW2irSORqgzzVUh9T5hi3OQMRHRYCVglEDfgjvz51UfUxelaQzN7brjqf9bV4FNEvRvJmM3lEel/OAN3knaizSdSFURo22rfBcDVSJG26K+UIFQmWVYfsRfqlFLKjWIqHdBmqLXmihncFnqR9kTyJjm1FK9V4C1OgBUaX9tKYpwrn/5fP2/qYbx0AhGLoWeKjxszWUcbJJykup1HjFkAqct00b0Yhuhk7VOV2EECX5Q3mHUZH5wYSbg/rLvC+VZ7OgLL/Crfi+c+hJLiFekIiEl3Ue65QzIvAdSIwKA3KV5TWT96HKKIBgK4Q8MBZuWwPlnQQAxt7D/3hwKqgwWspxM4x8zCg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(66946007)(316002)(2906002)(6506007)(7696005)(186003)(4326008)(71200400001)(26005)(54906003)(8676002)(86362001)(8936002)(52536014)(66446008)(83380400001)(110136005)(64756008)(66556008)(33656002)(66476007)(7416002)(122000001)(38070700005)(508600001)(38100700002)(55016002)(82960400001)(5660300002)(9686003)(84603001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gu6maqNeQZqaGbSSyOtFWTA1bFf+F42iXGI6sTmlxzHCZFySaLVoMItYgR88?=
 =?us-ascii?Q?Ow8+I5rOFFS2wNzK13TwQrf4id2Whw7JkrFS8cNvPBbUvwkFZBOtohgyx38r?=
 =?us-ascii?Q?LKXtHf3JN9K3ekgIX9cY/Z2GhZiIlZDoY65gHnnbZN3xVsoXhjc+Y1E5k3vX?=
 =?us-ascii?Q?VVDubPA4bJynQP2XDa189kddERaK+SeRgKGKZrgblfA5eLaBkBGJIBbnKRmQ?=
 =?us-ascii?Q?5T5VYLxWQwfpezAeUVv3mid1LmqOPAgDoCc0EEZkgozdh2r9HUmTgroIVPOz?=
 =?us-ascii?Q?bp3IPo32A5ahxXmvNZW68ur4eSAPUWU5pKZ6dSH83HdP5E8GRORQBS1NFafS?=
 =?us-ascii?Q?V3TmFWbaiUzRm4b5J8Y1gDcnwP03sI1gW1ZadnanCLGADOx4Am8tbqPLXEd5?=
 =?us-ascii?Q?yZVbFgVlgCZGPgCZhaQocPnbYd7wYzcTUpeGzMJum9vxQtVK8/fgF22GE3Vr?=
 =?us-ascii?Q?GA2JNOg4WpLiDNjERuo2KZ/blshHKrzi0pyWximHZFxA2IfrjpJoNAKl8KrE?=
 =?us-ascii?Q?BjrDJn4n2G9QcX2pfr5QHdcUWI+ZmrpGAgAOEmpSh3PNHb56NjxDgx6qu9Jg?=
 =?us-ascii?Q?XQQrf/wDEKo4X2Xmx1uiNmqIBCYEqLmq51wLjwzjBdx4DzBucZ02396q/Hmh?=
 =?us-ascii?Q?63Kt7pzeVRTlSOdwmh791WMxiqdUky9Khr9Ql3zc1SpRktnBS4qgWjxK0ef0?=
 =?us-ascii?Q?bPB/QCO+N7/UZB6/XgLtYjUOk7YoYf4suz9rfig6Hp7f+TzauG5d2oObPczH?=
 =?us-ascii?Q?/QC0tyZuYhGpctOQfl5g6ZLUyOdQXuwGIQ/qx2O+CkSNYqOHqryBRiPZp8ZR?=
 =?us-ascii?Q?jfs2VcFRZzXh170G29XtL0Nm1sWi1/xqnh11QmtjLOcgLHXIwL0nvaGStTa6?=
 =?us-ascii?Q?5+Jkh6JubQLvmM06dEo+Mggu7X2qPpdBRuwLJI03K1AixCNpU2lIx5fTyQP7?=
 =?us-ascii?Q?alv3Csct+LF0eEEOtrocdM2AJRoBStbXF73h+ElZgT1+cw1gIpcx7zXajnpS?=
 =?us-ascii?Q?GVb3gDo68F7U2wDp+5MTG8oEj0j5v1unHDK8dX/KGmvEwXo29rF0gnJBLdUm?=
 =?us-ascii?Q?fWV/YgIJeu5mB1vCzeomQyMt34ddxr8ILzTX6PiIuwpJzmfr4UFnJg/UZS0C?=
 =?us-ascii?Q?r1uqd988fRx4rgBegWidVc0AVxtXkXcZSVzMMcXRfIrs6mZ41/6oFD3cYKeB?=
 =?us-ascii?Q?x/CXw2iWQuhyaQK9ItRNEF0v0/t2XBUtCwZkpWmD6I3nWo/aaDRva3OjmPaw?=
 =?us-ascii?Q?V70q1tK3GJJoUIx3msbFTbNixshthpqFTQkj61DFOFDyEvtpu0UgBgt94/CE?=
 =?us-ascii?Q?EN6PEAfIeeEUGSaZRzVd5RXR?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f9d70e-c145-4a3d-c0f5-08d98e1821cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 07:07:34.6472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7S1lUVn4eLUR+WjEI62zeN+KPe/vdxVx5WsElOhcu9uEPC92rvJC5lVfNES35BKn99FcK4//dMsgKiBgl9SVJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1938
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
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

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Monday, October 11, 2021 4:50 PM
> 
> On Mon, Oct 11, 2021 at 05:02:01PM +1100, David Gibson wrote:
> > qemu wants to emulate a PAPR vIOMMU, so it says (via interfaces yet to
> > be determined) that it needs an IOAS where things can be mapped in the
> > range 0..2GiB (for the 32-bit window) and 2^59..2^59+1TiB (for the
> > 64-bit window).
> >
> > Ideally the host /dev/iommu will say "ok!", since both those ranges
> > are within the 0..2^60 translated range of the host IOMMU, and don't
> > touch the IO hole.  When the guest calls the IO mapping hypercalls,
> > qemu translates those into DMA_MAP operations, and since they're all
> > within the previously verified windows, they should work fine.
> 
> Seems like we don't need the negotiation part?  The host kernel
> communicates available IOVA ranges to userspace including holes (patch
> 17), and userspace can check that the ranges it needs are within the IOVA
> space boundaries. That part is necessary for DPDK as well since it needs
> to know about holes in the IOVA space where DMA wouldn't work as
> expected
> (MSI doorbells for example). And there already is a negotiation happening,
> when the host kernel rejects MAP ioctl outside the advertised area.
> 

Agree. This can cover the ppc platforms with fixed reserved ranges.
It's meaningless to have user further tell kernel that it is only willing
to use a subset of advertised area. for ppc platforms with dynamic
reserved ranges which are claimed by user, we can leave it out of
the common set and handled in a different way, either leveraging
ioas nesting if applied or having ppc specific cmd.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

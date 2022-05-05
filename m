Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B173C433F5
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 07:42:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2329A4011D;
	Thu,  5 May 2022 07:42:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ys648lrc4dc1; Thu,  5 May 2022 07:42:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D17E6400A4;
	Thu,  5 May 2022 07:42:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A93BFC0039;
	Thu,  5 May 2022 07:42:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A81DC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 07:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 284A460ABE
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 07:42:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rpt-F_8Oe-zf for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 07:42:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B26B60A68
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 07:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651736536; x=1683272536;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=t7S19snSPHJb9uy+3su9uy2E4btEto7JojuFGLAZMEU=;
 b=VgzN4fs/T4KsHeqthXF6CznKWol5+fiOiPWuSYTJOVUEECGz23em324p
 eTooGnl3bX/meWwUGuSZrIwajkkxW9QAyq1fqwp5reZWtrzOcfoQ4xelm
 P3dphFG9Fkwgi2BASdyTjV+Y8OrNqA/PC3p2oT/niRbjHAqIQiD+KRfLY
 c8WoRi/xNvHYUBTc8JnatJN10mwMVcXdofV+AIxivX6Hel7VsbfCyt3DS
 iOArOs4tVXINqfMZiU4dPuBqK5ARn+57my/PK9vkvLvxSuTxnZzpoFPH2
 AwqzSihmyatpBP4AFS1pk40ytEjSr4AFPvFi19RW3Oiq4mDtl8TspEJzv Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="265626832"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; d="scan'208";a="265626832"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 00:42:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; d="scan'208";a="734778299"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga005.jf.intel.com with ESMTP; 05 May 2022 00:42:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 00:42:14 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 00:42:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 00:42:14 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 00:42:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1QoJ7ueVumWctW4sr9BHn1diG8YmRCjMKCS9FcRTKTvvEE8VOmgCctqe4sudvPj9bi96wLbZ+8Vw48QhFdSycMQWNDgrOUtj1r6knxxL4wqv2YL7hZ1kvvbsHj4TpDxm65iSYq4xZoxGemvVqHH1lGOstTtr0Z1d3HAanMy0hToRNv5xyG7Lyv0Nchy66DT6bPLyQdkSSqee4V8jgpR4gOWy4QUnaMAM35VVSvHeaFDA8wD7U3/M1p/dTwdj45MJPD+JLZdhoznpkRwBHabommj+bBk4upbES5LLDvKzGWUGK/kI25lzg8eGqKVFQQf6sOTD0nUMmUDyZ/gnXO/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sz2TxH1Sl+5PHXonSvy7a+rnnypuBhfuxSYlbHt/Iyg=;
 b=UpDgUwoSM9NJN1MLYbxBpVp8IB1BAmUhzHUoXsApBodtUg95Dcv4nKnpKNg5ptOF3rKhW0xGkrmzMRor4/GnmTA04l+Up05vSwL9N3TSUC/afS8Y9nzbrqntSYJ11QKItRzD6zgHyNvUQKnOBqmfMLXTKsk14tteG1+mF7ApDtpySIyDnhrSFcKQlCZAu6ffi5hPhaY7D85+07wbbkRGGjkUtqqaS77TKBZk3BJUM5eXzPmF0gdQvQ1XKxST4NWAG3A3ar0/b3uAhsYJg0CHK/dXT/EMkGgrD3rwt77wX4cDq1aAlHH3mD+2ekvF15gSdDzWonBiLV0HbWfH9Zk/8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY5PR11MB3880.namprd11.prod.outlook.com (2603:10b6:a03:184::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 07:42:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 07:42:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH RFC 00/19] IOMMUFD Dirty Tracking
Thread-Topic: [PATCH RFC 00/19] IOMMUFD Dirty Tracking
Thread-Index: AQHYW0R/S6mfDid5yEe6M+QKFrUDn60GOWsggAWwCICAAAubgIAD+0BQ
Date: Thu, 5 May 2022 07:42:04 +0000
Message-ID: <BN9PR11MB527609043E7323A032F024AC8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <BN9PR11MB5276F104A27ACD5F20BABC7F8CFC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220502121107.653ac0c5.alex.williamson@redhat.com>
 <20220502185239.GR8364@nvidia.com>
In-Reply-To: <20220502185239.GR8364@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c03cbaca-d880-4718-607d-08da2e6abfd3
x-ms-traffictypediagnostic: BY5PR11MB3880:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR11MB388067404FD43E9EDA8BD44C8CC29@BY5PR11MB3880.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8titbHYLj0e54BASAHJ3K9bGoXyWsW2DBFa+tItn+RVSVeYBP7nfW4SlpkZd8rtRtbjHG+1tDarl3khXPViAnaFPA0FZxQ30hGyt09X6lzuFC7p0Gy0w6WCJfd+2HyXAF6XdTwpTMd8iTSf9krHoWBXU5PZNEKXG9NFWRMnwVrzaxAePHke0S5cRrxjVsuirLG3vkS7eBzchxqdB1rSCCiprOvmEfBXJgL2qst+V70SyfH3Lcch67UKOy7vGXdbqAWQWbLEhM5i87gXlUbpu4VTMZXC6NFuj4rpxGiEV/FLWNeWUslHXSlwgxdD7JdPWkwuUbvhVczU2qVencuN45To1ABEJMDjkQFIEuH7/NIUNHybQoMGvYm9S+b2BvaIBPbLpyUc9yWPe4L6Dh5d3stw4igO13yJl0CMVfFj5pWdmOdYi5XkeuezZwV6jYwVZTWmCIjF46I4RYDcgfdNesBtGxNWnGLaT/Agm4JuFF5CDWDnUy1MF5F5dOTg3aTjtX1M+2F0x4ET7IZlLyBWeSjujPpznRrh0af5fRset26B05gjfl3nfjYA+gZnCDli10Ae1i81mIQzwlgB2g08Z5S5hgCWF49h5ZT5+2Shu1Xr2+n413GIna89RVSy8OxHFwIAmhqTqn9YLui2spnWwsIOk3jSKHGuy2bGB/VKgg+BZpu5qwNrR5puYWCyc+IQv1nhHJvgNoqzOX1PAMuhOA8GR2yx8k5AowzpFCgKhR/c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(71200400001)(508600001)(86362001)(9686003)(26005)(6506007)(122000001)(38070700005)(82960400001)(38100700002)(66556008)(66946007)(7696005)(186003)(7416002)(33656002)(2906002)(55016003)(66476007)(316002)(5660300002)(76116006)(8936002)(54906003)(110136005)(4326008)(83380400001)(52536014)(66446008)(64756008)(8676002)(14143004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4hCwv8btQsMMSEhA6Nhbt952LpZykX9HBZ+WFWNfiNPp+CnuOhMmN7F8pwC4?=
 =?us-ascii?Q?vwIa1/yXHi87awF2jjehg0HenQBc5HDr0kxhSTHK248HAQptK85B6QkG28fB?=
 =?us-ascii?Q?MmR1VahRqE84KEI5HVRuUI6FI61hOzqr1uVfSVUYoWQAfjjIYna9M0FrGOKw?=
 =?us-ascii?Q?aSXPEAWBF/9U9olmlobt5PKEQ4D4yfZBorU/j5351M4+S9nUZrexRx1AeUYg?=
 =?us-ascii?Q?oKxP7Wju/jm8D3WT1lhJb6xiOA54OOWCpYHzFrrAWvkcDuCbCFcHCCLZKqk8?=
 =?us-ascii?Q?hCU0Tu6WekZ9CrKdw1Hj1NO5dBFZwHp/DyosIyG7LizCtdCJ0XKC06ktM9nt?=
 =?us-ascii?Q?ZV1bNkWTK4dWJaKbdxiCQNNy69VhrKkq8Y5Xg0AydPcF5QRf10yduJkOeRv2?=
 =?us-ascii?Q?6s/Hf5MqYCuHH/BXu3lJnbdfoTRip3N40PzP5LU7Cqfk7pCLsV4ZxeIoSc+d?=
 =?us-ascii?Q?IZ8I004QdDkJVGETSabrbxaRudJAK2BkmSuHVkg3I1XboUppS6Hn95xg3ULx?=
 =?us-ascii?Q?1AMnTC6uN5Ap9+AYizFVTFkAlWzMxkmr/flCZkWgDeYa9Y2K08mXgbB/EG6k?=
 =?us-ascii?Q?KQLPtSwZcfbPAF1FSf9UN09PJCTveheyoss6e+Ya3gHUJF//QKOElkXXvace?=
 =?us-ascii?Q?RQ9f9qWSeapCD/sFookhj2vveGJjtXMEvLdXe8pKH8niPx10JD3MXSDN6TSV?=
 =?us-ascii?Q?UI7r3XRyiPJJdDqfP6nzawc2ikJ1aQYnJXWHp6W3zQKcKx3/V5i7a/y8/dLw?=
 =?us-ascii?Q?sSKYFGC+zI8IjKXL8kauLmRrU/aYA0zaAO4d4J48dNN9XRj6Y/OdRXhp76FB?=
 =?us-ascii?Q?Ai2JU7y9Jt1/MDh4pyKmqYXXBGq/FQbzJq5q6VD5qVlNm9bE+cewv+9kXMoh?=
 =?us-ascii?Q?RtNXKKzthzO5zzPGQfoLnFS+DA2LB7tan+F9/sGmD9jdHaURRmpXSInXS/5g?=
 =?us-ascii?Q?1UDIQX1xsLrtNqpWrxoMVWeTBO8hGR+n/LAyJLtj1EZBN7Rnly1pfQ4gsW2z?=
 =?us-ascii?Q?lq6jP03OgkD6lCPrRTaDAxYZlmu3B4/0IpfEAGgMIYqr6gr+w3vJTfQpfq6O?=
 =?us-ascii?Q?OwD4PzE9uxNZ463u+KjU5kZt6s2xP6AXK8EbrMgzPT9A2f6v6YzXs0gBTzhj?=
 =?us-ascii?Q?xg33EknMRTUcX8+a2iPqNIQZaygAVfH7qJVCohQVbb53D8BLm0fuPzV4pr2S?=
 =?us-ascii?Q?ZzaXohJNavpe+j0i+Fa3mG0V3/cp/ArNhz1eTTT9Ibu718bH4zz+JTrIfwGi?=
 =?us-ascii?Q?N5XOc9emhzI98GDFTXyiNHiwwbJ47V+2D756rQEfmJVDDD65Ln6Yu295ION3?=
 =?us-ascii?Q?p807iwjWfOrhPz1q6WgAwJ8A/s+yqtXJkySgRhJvOb1eTiuGP1VqmRO1gYxe?=
 =?us-ascii?Q?VvvTJpZCpz7yHCzb2IQuBUgedl6bbhQpKvGswHd0nFNV8Oxjf69u1g9axCyV?=
 =?us-ascii?Q?0wIg0TNN2ezZJNF6vh/HZfhziY4XywLjCpdGiJI0EILmQhPRyNlxx8QrtXzR?=
 =?us-ascii?Q?DVYL8u9q621huZh5V0hqgNkaBW3Z4PnJidVZgA6NCothGAG77CA/KlczZFik?=
 =?us-ascii?Q?OHCSwJmT4/q4sSID3za63Mo6PT91OXPKbDdFdYs7GFWYN/MKRu2Piv7fNilF?=
 =?us-ascii?Q?zEJkjxrV99TPOxTgOcGWbx/xlVUaeQYeTkrObBkn8uqU0wdfyKNx7JfGZNtp?=
 =?us-ascii?Q?Qaiw2gpczPArKk/w7dCQPQre9ItR1CAgViWbrZfFRhyn9inAuHzj13Kaum+N?=
 =?us-ascii?Q?srhzP84oXQ=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03cbaca-d880-4718-607d-08da2e6abfd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 07:42:04.5745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: It8ydWb7Y3wLlrHQR+uJfJQiROOgcpQCOifk4/nkrUDsiqn2OdssiQZpvj/62vJY9Yr9UQdqHhStrxBbEB6sHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3880
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yishai Hadas <yishaih@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>
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
> Sent: Tuesday, May 3, 2022 2:53 AM
> 
> On Mon, May 02, 2022 at 12:11:07PM -0600, Alex Williamson wrote:
> > On Fri, 29 Apr 2022 05:45:20 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > From: Joao Martins <joao.m.martins@oracle.com>
> > > >  3) Unmapping an IOVA range while returning its dirty bit prior to
> > > > unmap. This case is specific for non-nested vIOMMU case where an
> > > > erronous guest (or device) DMAing to an address being unmapped at
> the
> > > > same time.
> > >
> > > an erroneous attempt like above cannot anticipate which DMAs can
> > > succeed in that window thus the end behavior is undefined. For an
> > > undefined behavior nothing will be broken by losing some bits dirtied
> > > in the window between reading back dirty bits of the range and
> > > actually calling unmap. From guest p.o.v. all those are black-box
> > > hardware logic to serve a virtual iotlb invalidation request which just
> > > cannot be completed in one cycle.
> > >
> > > Hence in reality probably this is not required except to meet vfio
> > > compat requirement. Just in concept returning dirty bits at unmap
> > > is more accurate.
> > >
> > > I'm slightly inclined to abandon it in iommufd uAPI.
> >
> > Sorry, I'm not following why an unmap with returned dirty bitmap
> > operation is specific to a vIOMMU case, or in fact indicative of some
> > sort of erroneous, racy behavior of guest or device.
> 
> It is being compared against the alternative which is to explicitly
> query dirty then do a normal unmap as two system calls and permit a
> race.
> 
> The only case with any difference is if the guest is racing DMA with
> the unmap - in which case it is already indeterminate for the guest if
> the DMA will be completed or not.
> 
> eg on the vIOMMU case if the guest races DMA with unmap then we are
> already fine with throwing away that DMA because that is how the race
> resolves during non-migration situations, so resovling it as throwing
> away the DMA during migration is OK too.
> 
> > We need the flexibility to support memory hot-unplug operations
> > during migration,
> 
> I would have thought that hotplug during migration would simply
> discard all the data - how does it use the dirty bitmap?
> 
> > This was implemented as a single operation specifically to avoid
> > races where ongoing access may be available after retrieving a
> > snapshot of the bitmap.  Thanks,
> 
> The issue is the cost.
> 
> On a real iommu elminating the race is expensive as we have to write
> protect the pages before query dirty, which seems to be an extra IOTLB
> flush.
> 
> It is not clear if paying this cost to become atomic is actually
> something any use case needs.
> 
> So, I suggest we think about a 3rd op 'write protect and clear
> dirties' that will be followed by a normal unmap - the extra op will
> have the extra oveheard and userspace can decide if it wants to pay or
> not vs the non-atomic read dirties operation. And lets have a use case
> where this must be atomic before we implement it..

and write-protection also relies on the support of I/O page fault...

> 
> The downside is we loose a little bit of efficiency by unbundling
> these steps, the upside is that it doesn't require quite as many
> special iommu_domain/etc paths.
> 
> (Also Joao, you should probably have a read and do not clear dirty
> operation with the idea that the next operation will be unmap - then
> maybe we can avoid IOTLB flushing..)
> 
> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

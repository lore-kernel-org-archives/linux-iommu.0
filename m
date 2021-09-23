Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3098C433FE
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 03:38:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3B161248
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 03:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A3B161248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09838415F4;
	Thu, 23 Sep 2021 03:38:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TA7n3Gf_pQU0; Thu, 23 Sep 2021 03:38:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ABBB640611;
	Thu, 23 Sep 2021 03:38:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 661CEC000F;
	Thu, 23 Sep 2021 03:38:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54CB2C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 03:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 409FC40599
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 03:38:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q7YTMU5VAM36 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 03:38:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D9BF401C9
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 03:38:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="287424195"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; d="scan'208";a="287424195"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2021 20:38:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; d="scan'208";a="534074837"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2021 20:38:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 20:38:17 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 20:38:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 22 Sep 2021 20:38:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 22 Sep 2021 20:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNLDGR2+MjEqCrvPi4UHjTAKJGyPba85bzlp0mUJAjy1I8TWSFWWdml6/N3IigyV2Y87VnAMMTXjCi8i/xOSmeWBpaEaD0ls5aPs+QpBDnxN7e4Rbj25t7lqZ5cLSH3vPCTkfuvtRESTVxdSvI8PnkqROepagBJb7mdwC3/sls3AZLq77Mty3tuPWlNLLgocyIrC8+sO5UR9opqsE4THNMbxIayGkS1kjyRflKNbp/ktpKpKuWbTt4/JdeD+kNIXyLsHSWO62dkqqxosIhfQPtLpDLA9eI/uNVjZcCj8DeFk7q5yvjFdHHPlPyNBoRw4bmDGhcxlhKKtYBzLpGRu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=yMMW32DTFF8WerAi4uoQJuk8iLAxOcNBE9gdJwEVuTM=;
 b=d8EuC1QzYFMa0kW56i/uIdsftJPzo0cmCY/vmZL02koK19gPizFoNQnDF9mpWyS2YlkV0PkkQcqZp8tqCU7rfZqHr65oBf2MPRzaVv/xslyxisaKH49HfRcaPU2vXEAPzKjLK0aVZhggS+uR53DcHPm4bAQyOodcB0PNdJouDjbMsJQ4TmWECfmJwzg0bNuORwUXZ7Qb/tglML5kIcTEJa2Y2jhJJ3S/bg0qmU45bTORyQBU7vrQ1SZUpfgslQ440WbubX12mhbHJLIdkvJ3B8rZ4Uy4vGjMNZIDq/rouNR38GvFv1P/6EDsOJyugp5Gcrmy+IoyWYXfURw2Jl2/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMMW32DTFF8WerAi4uoQJuk8iLAxOcNBE9gdJwEVuTM=;
 b=D6z1iePeYo3RFs+1Hpx7buY++roP5d2P0ss7QXajtyQL4B01p0l+/fV4BEbh+6I3//bvy2YuiM17zSC4il62Nwsm8los8cB/Yu42G5RvAGDsrNAH00V32q0Af754PmM1vAlEAOKXRJXMP0tZJlHKyV3YNZ0/SbFbDoBRpfu03Y4=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN9PR11MB5466.namprd11.prod.outlook.com (2603:10b6:408:11f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 03:38:10 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 03:38:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Thread-Topic: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Thread-Index: AQHXrSGNbNtRgavabUSKJjvt8l12BauwlhaAgAAouwCAACufAIAAEL4Q
Date: Thu, 23 Sep 2021 03:38:10 +0000
Message-ID: <BN9PR11MB54333BDB1E58387FD9999DF18CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-11-yi.l.liu@intel.com>
 <20210922152407.1bfa6ff7.alex.williamson@redhat.com>
 <20210922234954.GB964074@nvidia.com>
 <BN9PR11MB5433409DF766AAEF1BB2CF258CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5433409DF766AAEF1BB2CF258CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6df1ccb-c876-4197-5f71-08d97e4390a8
x-ms-traffictypediagnostic: BN9PR11MB5466:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR11MB5466E563C900BCB2A193F0A68CA39@BN9PR11MB5466.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sEzfpymHD6xz4wQ5bNP43jhjN5pi1NrxGLkax/spZTuv9PcNSYtjMT1LnGk80jwv/nJC0rJBTrESBOLaelWlAyo8UD6GYVGrZDjTatZgbg2XWf4zW6QhDqoUX21lTwj4ktpW13PPE7J3JBUxSlQnhHkLzFylwytj0kwBMpbYyAlycXBINTqaEy0el5ViV/nn80W110mUbT8V+B3qJu2DKd1hOZRnc610eprUNjKGfDzbrjFynrdYYyLtIKDr4EXsX3ulUj2vZL9ky0is69teTBY6ulfIvs7UmYSOxJh4Xo+/5viNLAsf2XCCnVQoYS61E2a3ACsahe0QEFSj1y9F+0rtIUf45j8tAcp9LCJN8PSg5K/PVOAM1i7a2VGqJfgYB+RzytgMzpC9VbEMAHPPgd8kEte2ZFQ/Gb8B6CzomzWI/pLgTEwdF12VkdKExQR/g4s6ONXtcvNSpKb09v7LR/nQVfxRnP9lcF7i3dBXmGgZSYu+JcXz7IeUSBKYJHCEibCElhtaPJvkTNERNTQIY/gxPYHRO8le1jeQ95Aql2bBl1qZYKJBp4jjN/QfET9E94ESGgBvozjG7/2RixUcV5/RVPNEqlz1vBiVz0/Ozmx+0n2H8+SFEy1lNrLtCNmXmekKHopdaFtIOAuo7iWJwECBnfC0jwHBrf6m0kacGk84UtaTi+ol9oH/WYezBTVyFpIC8TtuGOHhsoTIVbfHNg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66446008)(5660300002)(38070700005)(64756008)(186003)(7696005)(66946007)(7416002)(9686003)(66476007)(2940100002)(2906002)(76116006)(71200400001)(122000001)(33656002)(38100700002)(52536014)(26005)(110136005)(86362001)(83380400001)(55016002)(8936002)(54906003)(6506007)(8676002)(4326008)(508600001)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DAInMCGBNFJtdHeEg1w4K7dR3GhXCls5Z7CoOL24h9LaPMXzTklCoKEFmJIM?=
 =?us-ascii?Q?12myTKdSs5K54U3xbX5iMITSPKOmvANfT21/AU9q7znI2TclEVPERMkAp1jo?=
 =?us-ascii?Q?XcIxiVJQrQcmJjaxMg19IxM7h5VxA49B2Ppdshsx3oPc92bU6g9A/WdPOG7e?=
 =?us-ascii?Q?FAMb+Pc0lOhAjZjbheONwRFa0XnLWutoO8ITodEjbJ9xZ5qNvLc42/sKzYuv?=
 =?us-ascii?Q?lPDHX8e5kT3CwfBLJO/ADmV4LD1zTwffY2d8NnpRd8iO+wxLARtMdw6vDpok?=
 =?us-ascii?Q?L8RxEGJdX+2wm6UYw2faiiHVtZ3hLxJNzxl9VsQOqiBwsb6pzQqfS/Urd5oE?=
 =?us-ascii?Q?SiVHLxY19my89z9+d511H+U7FHZJlH3phu3VLSatyLXMQX3zVlVd5vCtLZh2?=
 =?us-ascii?Q?xSB+oEbCLYZCho9hRueuTf85QXTRDKFnHnBFuxCvQYRilJlVBBOSKMegOAg5?=
 =?us-ascii?Q?Dh4DY5W6kiU8ov/9JzUllUdmyCVwvz9i2bLXfaP+zWuGKGbcUQwFOrgD7COE?=
 =?us-ascii?Q?7U0ujvbkwGShrWcdzPtkG/oKVyvw7DokTYn76HS6DbAnFzUs1C0jdMu+hDyg?=
 =?us-ascii?Q?FpeBDBTn0xSiYNOM29H5ec5mhcWrMQXWptD2gAs6I6dO4NMS20POxKp4LDBh?=
 =?us-ascii?Q?ne9kVIzllPkAS4aLk147T+iPz9MsM3ebfBM88yhooGMwkJUQ9EyoQdWK7mEJ?=
 =?us-ascii?Q?/oJExPpyFqp+YN3cCW2M9zu4kc1aL5nKLJUt4MqHmgSR+MyQlJUs2vplOTSM?=
 =?us-ascii?Q?Pus6foBAV8vCNhAYMPnGt4OofBbtZofFvNIJjB0b4BzB7tFQdI2labX65ym5?=
 =?us-ascii?Q?5xbzdiFXnVm+SxRrusIily4o0xAvjR4yS9noSX7/MAaNtdRgOcxSSQGEzSZG?=
 =?us-ascii?Q?W5g5u8n35CoWl6NXP1uikt5PpP7+44M8hBRfOO/9Ch+C2shsv0ZBh3ra5Ksr?=
 =?us-ascii?Q?vS0pjDuKsngPm7KrdL24D2hU2AGVIkohB0IjkJV9GWgIIzcPX/4aIHcU3KRA?=
 =?us-ascii?Q?+dtIHO2BGENS9tDqF/hgPOF03SN5izDVJmp60SUYZpZsZkXrDFtZt1d0wMJB?=
 =?us-ascii?Q?cpGwZOquEM7PAa+TaSoSIX7alctBewpg4+4OSzVJ8SGGnZNtY920n3QUwAyY?=
 =?us-ascii?Q?bx/Sk31+qVf7VJBLt3hU1+PmfZPddPPvZNNprdDd/9b4GjDKHdwf27PzJwVT?=
 =?us-ascii?Q?HPoLVk9gru5nrL+83CbDicotJcZPPrRyN5p8hZSrXcqlZ+zvne2SDWNVgzft?=
 =?us-ascii?Q?8MtQ0CnKz+7iZJ6pQoOxzPXhUdHjIv9S1VKNi7/Uroz3XkiV/9G/cTgFO61L?=
 =?us-ascii?Q?CqBx3L2oTEt4RC91hV2zGScd?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6df1ccb-c876-4197-5f71-08d97e4390a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 03:38:10.2815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJLntXlFQT8QqcEaZrVMzaqohz6fMxvDFokejiBFcoy/iZjz984Tmbt9QTKnY2u1/16Bk+8wmE7ZWsxVAw0b8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5466
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
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

> From: Tian, Kevin
> Sent: Thursday, September 23, 2021 11:11 AM
> 
> >
> > The required behavior for iommufd is to have the IOMMU ignore the
> > no-snoop bit so that Intel HW can disable wbinvd. This bit should be
> > clearly documented for its exact purpose and if other arches also have
> > instructions that need to be disabled if snoop TLPs are allowed then
> > they can re-use this bit. It appears ARM does not have this issue and
> > does not need the bit.
> 
> Disabling wbinvd is one purpose. imo the more important intention
> is that iommu vendor uses different PTE formats between snoop and
> !snoop. As long as we want allow userspace to opt in case of isoch
> performance requirement (unlike current vfio which always choose
> snoop format if available), such mechanism is required for all vendors.
> 

btw I'm not sure whether the wbinvd trick is Intel specific. All other
platforms (amd, arm, s390, etc.) currently always claim OMMU_CAP_
CACHE_COHERENCY (the source of IOMMU_CACHE). They didn't hit
this problem because vfio always sets IOMMU_CACHE to force every
DMA to snoop. Will they need to handle similar wbinvd-like trick (plus
necessary memory type virtualization) when non-snoop format is enabled? 
Or are their architectures highly optimized to afford isoch traffic even 
with snoop (then fine to not support user opt-in)?

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

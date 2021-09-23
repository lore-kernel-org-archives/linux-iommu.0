Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C274C433F5
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 00:38:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A734760187
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 00:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A734760187
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 70604402A2;
	Thu, 23 Sep 2021 00:38:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dmxDJZfr3E9g; Thu, 23 Sep 2021 00:38:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 07604402B9;
	Thu, 23 Sep 2021 00:38:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8EBCC0011;
	Thu, 23 Sep 2021 00:38:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6393EC000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 00:38:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 457AA4026E
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 00:38:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tvglVVXSF4Z2 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 00:38:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 69CA84024F
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 00:38:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="223766443"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; d="scan'208";a="223766443"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2021 17:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; d="scan'208";a="533979279"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2021 17:38:13 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 17:38:13 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 17:38:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 22 Sep 2021 17:38:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 22 Sep 2021 17:38:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bX3YFSKJGcvN2nyU81xLO06W+G80eD2R6PV+gPUVzcvjKPYDLNLiag1DNJJkHtM5xyP3Dmg471ogJIdrkN0yBSA2WXbg6a59QwN9WzuixNU+1Idse4xO1kzK+OcMoaOidRFox2v2Q+z87XMPAGI8sBZER+8kZjIlbe9+yptXqAEC0u5tXt1lal6gj5xAdc0Rody0AcrLr5lP64L2NjDVgU1x1So/oGwQ+BeiVBKcZKKeuEfvvjdGP0NbWy5PnyBPud407JfvZqLZFQz1DtJJM5XQ2xXTxQYB+FN9yCdkZGDkGa+nhe7aJezonzU+kAXNL+S2XQ1s9C3vQ1imM7VVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=EhsGuLGbiX5v3MOzUTWS9WoWw5YWvQohz+yrT41BxgY=;
 b=jfCzZi/pLDokAlcp7Ijx0k8d0LRiIdR9evBF1Jc3hRgNBVAXS6O6xNaDgGzzdJPTioBN4LPnQ03OOb/xDQKwM51wKogzyX+My3gvOxpswMR3Lv8tq+Kqra63gK/GouR7pOtDgEgv9/a5PhDGVOybxy8JTIrC7s7Vse2fDtWJFFVpXiU1AnBrkuvP0I0ok+tvDGnGY2Qq4p/kPK37vyl15QMZsIeVuVaSgy3vyBi8RavtRwtyFLVh+i4SCvPzRV/gHE3AA8HdsQ4Zg3XUO8NnwQgw+dMKGvOLqPWlhljn75V7P2IU4Ok/5bCwaXjlhTcL7TQaV8gBYWN/EwH4OQBetg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhsGuLGbiX5v3MOzUTWS9WoWw5YWvQohz+yrT41BxgY=;
 b=l6en3kP1MoJPiO6JETnoHOEF5tfptk5IWKzYzJA43L/a/zpcPKvdBS2cbU2hM59k8nEqO4W1sjRtXplxlUfy9n7+RL/dojgXZOruygaBe/wQpy9hbPijLbsl7wP0WkA+RipadxBn2xCbH4jip1KO51UJ6JRrfA9gfiNmA8ZzTg8=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN9PR11MB5338.namprd11.prod.outlook.com (2603:10b6:408:137::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 23 Sep
 2021 00:38:10 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 00:38:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 03/20] vfio: Add vfio_[un]register_device()
Thread-Topic: [RFC 03/20] vfio: Add vfio_[un]register_device()
Thread-Index: AQHXrSFwNP3/pIcrZ0iM9X/cSoy0lKuuqYQAgAB3MFCAAB2WgIAAjDNwgAA0YACAAIKvAIAAJpDggAAEmwCAAA5k4IAABFYAgAAMYaA=
Date: Thu, 23 Sep 2021 00:38:10 +0000
Message-ID: <BN9PR11MB54338FBF5998E6AE23156ADE8CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-4-yi.l.liu@intel.com>
 <20210921160108.GO327412@nvidia.com>
 <BN9PR11MB5433D4590BA725C79196E0248CA19@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922005337.GC327412@nvidia.com>
 <BN9PR11MB54338D108AF5A87614717EF98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922122252.GG327412@nvidia.com>
 <20210922141036.5cd46b2b.alex.williamson@redhat.com>
 <BN9PR11MB543366158EA87572902EFF5E8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922164506.66976218.alex.williamson@redhat.com>
 <BL1PR11MB5429B107D90E3CDE21139CE98CA29@BL1PR11MB5429.namprd11.prod.outlook.com>
 <20210922235208.GC964074@nvidia.com>
In-Reply-To: <20210922235208.GC964074@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 038988b6-b8d0-4525-12a3-08d97e2a6b9e
x-ms-traffictypediagnostic: BN9PR11MB5338:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR11MB533860B6CBA24ABE2A62910E8CA39@BN9PR11MB5338.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KxOPAQPfu/7kj78W46E6N0xuWwgiW1ZxqZ3OnX21EUzUM76DN6yMw9ephUIMLer6lwD1Zxd75SIeViYGi+TVluWaB5N/7IZxzajIrFLiizk2Mx4hdCoTkxnwqpkj+VgW4qL6lWaMLvALsCzn0sHLD8/eD0T2fZjdy3SF6CfgFah41Lt3OJI4/oODjoDvY8DVHfknqYPtfLTFIZ9DDxQn7QiwQiru47xBRgT0Hfx/XdB9p84Q+IkqDH5NNt2+fCoW3lZgBDEDsCGQL16rm/3kaNBnxIzz7V7NcHQYUaNcmgNc14khutZIH7MR/pB8B6/5XAs2Wn5tr4fUglJR0fvTgE+ZC8656AyItV78fYNbXToVI1kUPBDb1fTA51nCMBzQHTDoD8eDNw4Nwk6wQpLxWSiyK5E7mrqNkbeQZ7AjyGjeJiMSVfNARxvOMoMgQTMh7tAlKcbAzBoCL1uftY5+nQJAuz4BcT8td8RVggpnNZlxmHUMlcSGZ6aPrDbSq0AjxBCbEIo63KVXqka5uKiEr4XGwdF/L02r2YKDfbm/87+afBrtFkQRyO3f9pxkUDFlVbtdT+H4IO7UAQ/NeWMJhmmrDNo+5mXOUjYGdo7vIyyKTrTq0QsaOld8U579JL3nDx/+j83emBmZzzt+W3UqqcYB0zmK7gVljGiJ+U8vP0GdIZTxofDmpnx3x24wQIlm2VyJvpt03YTH7O6lqk8TCA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(186003)(7696005)(66556008)(26005)(122000001)(66476007)(5660300002)(7416002)(4744005)(66946007)(76116006)(8676002)(66446008)(508600001)(71200400001)(38070700005)(52536014)(8936002)(54906003)(4326008)(6916009)(86362001)(33656002)(316002)(6506007)(55016002)(64756008)(38100700002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oES1qCottUBYtJ7z6kdRJ/Pkn+6ss/HsI3TVnz03ZIQjcmuBH1LYvRc8mzMJ?=
 =?us-ascii?Q?4+AhK+fA0Gxg8xtUyBQRUPhzod4oTpxodW4b+KP0OmkGCatfcHlNQqI6H7ei?=
 =?us-ascii?Q?c/WBLKcLMrqyEoDaYX7hIKxbgX3xHKKiI7SfvnRT4JpdU5XJnkrLZG4bqWXe?=
 =?us-ascii?Q?0qri/tklXLCRZtcy2DMkQTPxdvQW6nfiGjcyezG8EM/dgIKe37hZM29cWaJR?=
 =?us-ascii?Q?pJBH8xE2dF1RApFWxWKDGbUOxffNX7Qa7HRQM4Wb4REoNt2G2VyiFK/aiYW9?=
 =?us-ascii?Q?yIMERCnqOO1BVDf84SOp/93LKjLIiE9SmtjOOAekawz7u2gFPYeutUTWals9?=
 =?us-ascii?Q?Q1ZjXL7bSDzDBVpIgaTekNWiMT2IsuOTGIJd83bjpit3713JUsVPMJdLaGzk?=
 =?us-ascii?Q?tDvTtYc7R3sSPANA336xYdZIMjwHgICHIDkzGnsYBMYOVn4vvmMlhb7Ii5th?=
 =?us-ascii?Q?rAlGczviaFSNQBSoP/dP4pzFmlZv9Do+2t/HYsQ3P8eEWAWQzePlRM7o0Y7L?=
 =?us-ascii?Q?E6h72h/zLA7Ce0ILNXIQEVRY4pXj4FyGdw047nUg62NEQT+lLmUJi2N4Cthw?=
 =?us-ascii?Q?4k9EM5fSxkG89gLFV0+Bc75HtVeyGlwBQ+cR0/OyAiSL1FZLKhL5OnBxpGLE?=
 =?us-ascii?Q?0I2x1pC1F0L2m9z0Gnkhyk/xfbPe4uJJADAZk42tUMVDE9evUBGCbjwuibs8?=
 =?us-ascii?Q?cDbQHonu5Mvx46SQ9J4x29+73gaU4PZRXMeLXm/7B3GST5iPy1A2Gmq4HHgg?=
 =?us-ascii?Q?OFbhSgJ7MYLYs1N9+YYWUQdp4sEE7HRa8i/6hRTVZYEmr2umSgJ9KLfrHwL7?=
 =?us-ascii?Q?gydpIPj1NxFi8bJiTz5KeKKLN5dKURNzt9v13SWifetotHPtTqSyTsiH8xso?=
 =?us-ascii?Q?hNKCGk2S6xllcMkJ74a54RLpTr5i7BWVG9ELF1S7RgokQiNfC74dVZ1mYW6m?=
 =?us-ascii?Q?6YkSGWiVAymFPwppqH5qcU1pw8FjtoEmdKx+23CwY2kcOdzRkYGfQcfd6vBK?=
 =?us-ascii?Q?rN2Z1MhI48CrJB52dZOzkmSBKIb0h1L73qDNFSPtWTHQD7PNrX/oKc01KWUE?=
 =?us-ascii?Q?huuK5LyzXWGC6eGX1XtbNKWQNuWt2iU9BsTPbBE4n5VFg6r4UYzyATWiw8OP?=
 =?us-ascii?Q?7RAZkwtn8rERXT4VF3Qz/UJ6RRCgk122KZL+5cIH/uxPW9i/Jg2JkTdeV4Vg?=
 =?us-ascii?Q?b02VHSLrHt9kIitNhYzxWI3DW9rCkY+zFs9WVySkx4i6tcWbfmY769UM0iG2?=
 =?us-ascii?Q?IhdczDdeYwb2ER8y97G05B+3iaxRFE3D6YjuAv184TJXhcNhldil541fAAVS?=
 =?us-ascii?Q?ECQKtrDITQxxMgGlua9kyHYE?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038988b6-b8d0-4525-12a3-08d97e2a6b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 00:38:10.6036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1b0Gkk2plCyZlG+3iv+JlVDrQr3Mo6tO8RLgYEv5SpGdUDSHCSWDwLDdRwYtqJSKyXG1BRB453W4gAQ9U0dfxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5338
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>,
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
> Sent: Thursday, September 23, 2021 7:52 AM
> 
> On Wed, Sep 22, 2021 at 11:45:33PM +0000, Tian, Kevin wrote:
> > > From: Alex Williamson <alex.williamson@redhat.com>
> 
> > btw I realized another related piece regarding to the new layout that
> > Jason suggested, which have sys device node include a link to the vfio
> > devnode:
> >
> > 	/sys/bus/pci/devices/DDDD:BB:DD.F/vfio/vfioX/dev
> >
> > This for sure requires specific vfio driver support to get the link
> > established.
> 
> It doesn't. Just set the parent device of the vfio_device's struct
> device to the physical struct device that vfio is already tracking -
> ie the struct device providing the IOMMU. The driver core takes care
> of everything else.
> 

Thanks for correction. So it's still the same try-and-fail model for both 
devices which support iommufd and which do not.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

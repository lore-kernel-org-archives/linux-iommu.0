Return-Path: <SRS0=DRkM=JE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608F7C433B4
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 08:17:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7816120E
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 08:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7816120E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91389848A9;
	Wed,  7 Apr 2021 08:17:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LZAxPeCwvdZX; Wed,  7 Apr 2021 08:17:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64C718489E;
	Wed,  7 Apr 2021 08:17:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F10CC000B;
	Wed,  7 Apr 2021 08:17:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44E73C000A
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 08:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3245B405F3
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 08:17:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z8GCKgA9zhkT for <iommu@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 08:17:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD20A405EF
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 08:17:54 +0000 (UTC)
IronPort-SDR: KrXtiHO4l1lsMproZGwWJUCfhqjknCSVYZ+DMWmKA0PdYAjX1L7cmeiL+d3dvHGGDYgS0VJUMa
 WeBIGr6cbKrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172728564"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; d="scan'208";a="172728564"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2021 01:17:53 -0700
IronPort-SDR: OlWioo584SplFzi/IV6Jq62mHoUW+lbl1AqbB4HXStNiI6hq5mD0XPUFJnHt2qkeBs0ovq/TfO
 9pWol16xS2yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; d="scan'208";a="381233920"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga006.jf.intel.com with ESMTP; 07 Apr 2021 01:17:53 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 01:17:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 7 Apr 2021 01:17:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 7 Apr 2021 01:17:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoC4yQUJkQGyf/sYDb7zGowbUSQMv5uvJJLvVj/+5iX2jrOfecEBUFwLQweDD5OPoGTKWLmUtFxUPX8PBQo/LiYtUrivqPOFKEkYu4lRxRJYSP3PbwdBL+v2pJ5BTgH6Ct0SMHO+NwpsBvNdY+gBNumgSQjKjv5dxagc6NVESAt5t8uhTEDx1+X3H0rEIXBzChbK14Xiqt8SgE3uqNmbHeB8QWIwyOdJuZUIIcES0kKGYrmDp2/Pyt/tR4w9nLNjUm2dQVArrjrmWsPt9aCBOgULjRLwp1sbnOt5n87W+OI6xBDdhwiBvARd2l30AuJ1ppLHlJsOuyuhuYpvdH9wbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQFXd0Ztxf4n+0ZhWQnNR6RE0AxFwFoKz0KzltMML8A=;
 b=Vek5z+JEE48DgCCtvcZow0L/1MPzqdGfPSBkisiSb3q/IQ8F0g+a/G08ko1LDXEAyfaSMV+g3yQb2QRdI90vDRb3hG7XEVvOI/b2kvb7pKzkGRxkswBCmwZDqkcGWM00bq1aBOea1xVH2UvoQrlAkHv1FnOTgXbAbWIh0xKFdd8xer7wzBu+bSmY6b29AWOHr9QZHGWq+Sw7p8lJgD/p9hFb/O0SKoDAZrymJFvudQ7qiQElms8X5Jwzsf2PxvuneUKaPtb6nMs1lZJ5ywLQjEHvJKUmZJu1yz4skU/FMDAo9JEJ2psRmfDd/GljiBXmL5IuOZ5UzfbP3bl0wLYY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQFXd0Ztxf4n+0ZhWQnNR6RE0AxFwFoKz0KzltMML8A=;
 b=OSyg3TLz9GFm2HnC9GGvMcGQ/JHQIuQxedaMdsOIovSC/LF3Ag09YdM5ehWnaApQ6j3s6RXgIY8LX53qv3VN4JrXvNDLKNWtvipO6xACKL8NCyu/qTqesU+6oDPhkpFqFe5sncRC2c9WVWiaGvlchr1PY3okc9j+EyBREP6kd1U=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MW3PR11MB4634.namprd11.prod.outlook.com (2603:10b6:303:54::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 7 Apr
 2021 08:17:50 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4020.016; Wed, 7 Apr 2021
 08:17:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACABFtkwIAFviUAgAAfg4CAALqEgIABFGZQ
Date: Wed, 7 Apr 2021 08:17:50 +0000
Message-ID: <MWHPR11MB1886A7E4C6F3E3A81240517B8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder> <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder> <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
 <fa57bde5-472f-6e66-3521-bfac7d6e4f8d@redhat.com>
 <20210406124251.GO7405@nvidia.com>
In-Reply-To: <20210406124251.GO7405@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.88.226.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4625486-ad47-4d54-a772-08d8f99da295
x-ms-traffictypediagnostic: MW3PR11MB4634:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB46347F23C5C93BCDF6359FE88C759@MW3PR11MB4634.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1CkGoiW9akUfOJfg9TUnCzMBHLgs/oUtsLZ6pP4128huJvkIOKIa/uvD9MVc5JSomXInTRBJBFM3b2tAqomR6p/zOCHX6FLyElApyPAQX+mIdXjsLGD0nCVuFQXu0k3UjvpWLmaMKY/JbJXgkvU2XFUVpg+dRhyaFY/CMZ0qTQW94aEEVWxLp0J5oPWU5AU6FxDTE7wmm/CW5CChx89zNoxT4GorWsJ3+NeN4NFckiY1E5VC+KJab0BLQCmReIiNEhd2GPi26+1Aoe4GW5d8QC9FVxmOCPnGNXCxh5UrG9gPpVbZG444HdEY3F8lGhc8wJQ5O7JTcwnQRpcJnIZWaypIY7MwOWM8dkgYfWatZSKTIwKqnZpj+MGY8j0DNqRhVOGPRBvlJL168Gn8RqV4JDG9nGJnAiL/VQnr8RZ98RkKZmS9Iq2yIDTS+t5tEoRLTVcztuBj4AKfnuujwf4xqPSEoF6ox1j31aQ6lnAg7+aiSI+TTz3m8PU1vx1XcbcTKyKzwXVvqFWoHZl9bpCUO6dSyEGio1frKsmJxwAgEdhTzx/pU+gzolijl1716MsurLdPmWLgVcXK+xrNKYUG/eSH1hIjRkOb9k4zNr8plzk3QJBXsNYoi1/SkNj/1zPWjUF+iZYtF5VzG4JxjyEoIx24qKcMTf/8toLZHKQCxOk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(396003)(366004)(136003)(39860400002)(66476007)(66556008)(4326008)(26005)(76116006)(6506007)(64756008)(55016002)(66946007)(7696005)(2906002)(8936002)(54906003)(7416002)(110136005)(66446008)(5660300002)(316002)(86362001)(9686003)(478600001)(71200400001)(8676002)(52536014)(38100700001)(186003)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x+06gitlolA7ApblRc4VJphmQ1Iz+RIPtT3HRfwDocWhLg73tEfP4DrsbNIP?=
 =?us-ascii?Q?OACLK6DjNVLqOtXVSnK8N8uCQoeYzu7mswIPFxvqMB3iOgglXvksNYZ9ExHX?=
 =?us-ascii?Q?KxvelHkbNInTpJU/ersB5lmi7D3QT0Kyo0RCtQrB6XLpU9nKYr7osk5diqq3?=
 =?us-ascii?Q?W/6MfFFvGolJRBLv5Co8skcmo2BxZOa6F0k7ZJbrb5DsgYq4dGO4w+jBHgav?=
 =?us-ascii?Q?uoV5zQWCJUt7TdrpJ8Seuh9LMdnZMh8w3KtzNjh1Sa7kTbZuRCukDHREnd2a?=
 =?us-ascii?Q?JOhWW6HqfpoW8Cj0Wki721kg9k2IzNLVHxKo/aRE2SQ26CBJZZRM6F5howL+?=
 =?us-ascii?Q?V8bE8CBd8a5YgSZnGcbaljN3YDis+23vnKR7DxMcCDDc8Zrs5Q2h9WwKNZPG?=
 =?us-ascii?Q?SdqXPrUrW0GPUAagwJ3I39szmW1KDHGLIlfeqioA3BIgDcDHUtZLXWZsMz1V?=
 =?us-ascii?Q?D6R7kzBEeBQRwp9AQHkelE25j3tzI0awO68ISjNZC17debu8NsXru1JhJxhY?=
 =?us-ascii?Q?mRSphHHLTjr4BwcRuvTJ1e63Tk25e6aeflZzIIcu6reeI/XaynNEf6j0s6qA?=
 =?us-ascii?Q?qV8ELT4hvoTLZondco7dJ79gEwoMiOBY8Ui5fFEDWNwhe09QsAlh3MIE9M0l?=
 =?us-ascii?Q?aoyjhP/7rqUNcGFHYga3HzE7gKkubUu2Iws4otlyYSw7nyZOpxDIUQNDpUiy?=
 =?us-ascii?Q?OlcHwIvC2t0hmfSsr8CW7MwAU1vOY/oacf3obpYWSuBlVtm32YSkT1fTzGeG?=
 =?us-ascii?Q?FP+ouYLe3zkn4/Pps8a1m5j+/UL69/U950HYhEtKcpvE9DYaD0qoIlf4SXEK?=
 =?us-ascii?Q?71nZCEVOoSZeuMECkTj3WUKTUPGD0IXJ1A6diMIZJcSc+p75dmLlgfS56f6R?=
 =?us-ascii?Q?hHodAZG4colmY/Dxg/yTRa/NW8k5bws8KnQqUFFxX3CHJ39lcVdc7PWrcnHI?=
 =?us-ascii?Q?qf4vPKN+r44wIqEmpY/QfoXCuvsnus2ucZhBYu1WLSxjdZnTj/h7607siZqM?=
 =?us-ascii?Q?N+b6UD2Ep2+os4TXUYmztsvl2SUVeh9zroRjnpBQuHf5HlgleMmyNvZn8xUQ?=
 =?us-ascii?Q?d8AfHAkjziozsEq0ewqyBpnEV/2Zmty2qSZOu+2tkN8WAHBMGyk9oMu3cFMo?=
 =?us-ascii?Q?/AMrr1Bki/bMe8OT+afJq6aDXTtyuK6re+hL8UB7QKah0mlZB6XcPOzniXVI?=
 =?us-ascii?Q?/cHaI/KUJYjODtgL5kdZUSvm/bBzlw9bXIdCyzJ2Sf72W2sRSRoRV6nMs1as?=
 =?us-ascii?Q?vE/+Rb5dg+0QlX8nk+qv//f3UQuGJZIhTKu3mm7XvBqB0nFD7VwWR6QCc9b8?=
 =?us-ascii?Q?xW7qGk1u8MTDei28u9Bth9Le?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4625486-ad47-4d54-a772-08d8f99da295
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 08:17:50.4694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDJQT3kgye/9cHvzM1oojp0j0/yHOpdqSwaNyqfCUo0/V6Q/WYJGa/MY7D2k8T6sDUZ1OzJP/GgY4CY4S+3ifQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4634
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Jonathan
 Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Li
 Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Wu, 
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

> From: Jason Gunthorpe
> Sent: Tuesday, April 6, 2021 8:43 PM
> 
> On Tue, Apr 06, 2021 at 09:35:17AM +0800, Jason Wang wrote:
> 
> > > VFIO and VDPA has no buisness having map/unmap interfaces once we
> have
> > > /dev/ioasid. That all belongs in the iosaid side.
> > >
> > > I know they have those interfaces today, but that doesn't mean we have
> > > to keep using them for PASID use cases, they should be replaced with a
> > > 'do dma from this pasid on /dev/ioasid' interface certainly not a
> > > 'here is a pasid from /dev/ioasid, go ahead and configure it youself'
> > > interface
> >
> > So it looks like the PASID was bound to SVA in this design. I think it's not
> > necessairly the case:
> 
> No, I wish people would stop talking about SVA.
> 
> SVA and vSVA are a very special narrow configuration of a PASID. There
> are lots of other PASID configurations! That is the whole point, a
> PASID is complicated, there are many configuration scenarios, they
> need to be in one place with a very clearly defined uAPI
> 

I feel it also makes sense to allow a subsystem to specify which configurations
are permitted when allowing a PASID on its device, e.g. excluding things like
GPA mappings that existing subsystems (VFIO/VDPA) already handle well:

- Share GPA mappings between multiple devices (w/ or w/o PASID) for 
better IOTLB efficiency;

- Share GPA mappings between transactions w/ PASID and transactions w/o
PASID from the same device (e.g. GPU) for better IOTLB efficiency;

- Use the same page table for GPA mappings before and after the guest 
turns on/off the PASID capability;

All above are given as long as we continue to let VFIO/VDPA manage the
iommu domain and associated GPA mappings for PASID. The IOMMU driver 
already ensures a nested PASID entry linking to the established GPA paging 
structure of the domain when the 1st-level pgtable is bound through 
/dev/ioasid. 

In contrast, above merits are lost if forcing a model where GPA mappings
for PASID must be constructed through /dev/ioasid, as this will lead to
multiple paging structures for the same GPA mappings implying worse 
IOTLB usage and unnecessary cost of invalidations.

Therefore, I envision a scheme where the subsystem could specify 
permitted PASID configurations when doing ALLOW_PASID, and then 
userspace queries per-PASID capability to learn which operations
are allowed, e.g.:

1) To enable vSVA, VFIO/VDPA allows pgtable binding and related invalidation/
fault ops through /dev/ioasid;

2) for vDPA control vq usage, no configuration is allowed through /dev/ioasid;

3) for new subsystem which doesn't carry any legacy or similar usage as 
VFIO/VDPA, it could permit all configurations through /dev/ioasid including 
1st-level binding and 2nd-level mapping ops;

This approach also allows us to grow the uAPI in a staging approach. Now 
focus on 1) and 2) as VFIO/VDPA are the only two users for now with good
legacy to cover the GPA mappings. More ops can be introduced for 3) when 
there is a real example to show what exact ops are required for such a new 
subsystem.

Is this a good strategy to move forward?

btw this discussion was raised when discussing the I/O page fault handling
process. Currently the IOMMU layer implements a per-device fault reporting
mechanism, which requires VFIO to register a handler to receive all faults 
on its device and then forwards to ioasid if it's due to 1st-level. Possibly it 
makes more sense to convert it into a per-pgtable reporting scheme, and 
then the owner of each pgtable should register its own handler. It means
for 1) VFIO will register a 2nd-level pgtable handler while /dev/ioasid
will register a 1st-level pgtable handler, while for 3) /dev/ioasid will register 
handlers for both 1st-level and 2nd-level pgtable. Jean? also want to know 
your thoughts...  

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

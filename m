Return-Path: <SRS0=OzJ+=JZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB345C433ED
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 07:48:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13395613F3
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 07:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13395613F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FBBD842E3;
	Wed, 28 Apr 2021 07:48:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5FFNzHVa-8s5; Wed, 28 Apr 2021 07:48:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D65983EEA;
	Wed, 28 Apr 2021 07:48:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57C0AC0022;
	Wed, 28 Apr 2021 07:48:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74871C0001
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 07:48:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66E8940E75
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 07:48:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NrVtxsMGabZc for <iommu@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 07:48:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8FED040E74
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 07:48:01 +0000 (UTC)
IronPort-SDR: OSqOGuOWfgWbwZkxsfu0EZOr79f+A7kZB72W92soXDl8h9MDSdebyPvm3N8pae6JSxPqH6pbk5
 l3vUfTDXOMGw==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="260635099"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; d="scan'208";a="260635099"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2021 00:47:59 -0700
IronPort-SDR: jRsk+mnRHA+16n4Vwp48FtD2PwJG5+lZ5DxAiKSFcqotvTs40U+ETWaCG17FodTTa/53LI16vb
 d3B8lKIDWf1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; d="scan'208";a="425515986"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga007.jf.intel.com with ESMTP; 28 Apr 2021 00:47:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 28 Apr 2021 00:47:59 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 28 Apr 2021 00:47:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 28 Apr 2021 00:47:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.55) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 28 Apr 2021 00:47:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuJMJdbHlR/e2ZikRyymbXSbkYlGfHxzg8dylBewyL+C81OpA7nv8zDx0YYreVB0Bc6oo8aAKabisfnaZNJv0s6fDAct4OK6jkCb0jeuokJCDpTI+u6+InUBuMZEDkDn5ddi3/7xNh9Qrt6lJ1ERSlB1IhQospflaVO2i2E5WFrB4C0Ks7stnWP+T2KyRWTRDzR63MJsr1NAuQMc96dAWyH4EhSMwyyEMb5yDEW22u/Hz0NKvUiWBBcijMhVc+T5ZNfh5WX+BuHoNDYOJPNxgh8ZdUl/t9JeNIXrtdfz7o26yTMcog1KLmjKhqxnDgFDPEenWHVhd/7feVHz8RexjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPz8Og2u6aLtUq4xQukjUxKU/TryxrPNsjv9pdxRKds=;
 b=DzlTAxbZu/UjrFx/CwjOp5talSHbq+p2BZ2248Pwe5BQGfn0/Orxg9NMoLetdfzP0mpP1BJcuadzwyTF0J7SNSYyWiTqpRrLrMfF5fgFixqXLcZ76chWMohbL7MzjBPUVjVo49Y0qLavafFzec8eZtJciVl4qBChR5SITuQuv5mKMRXlV38dpOgjxYDQFJVG4qH8ZWrwonJqRz8inlDgQ6FG3kvB3KAIaoT5JzPHbw0EA4XWT8AUv1ss2UHvLcJI+zazTVgxpEcgKiUOeq22O6lZpWEDXCUmUzqQVvIA0ydghkdS4sz9xmdToQykJ4cNu/jKwArjIna5q1tNWOvegQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPz8Og2u6aLtUq4xQukjUxKU/TryxrPNsjv9pdxRKds=;
 b=jJCG5zvl8P6o5Wzp0UCOaCfnNhAMmHfj2hZoAEa3YDQ7s1oLAHv0dcE2x3wlYUbOnb2TjiobQsTWffLGkd3fw3ENASw7MBLW+n/OkQ4SEK8SfST5NJW2jSLQW6oL+UZcKXcOVol840XjEqfb81zElQzAQWOGLoZAMkmCK4ZqKe8=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB4915.namprd11.prod.outlook.com (2603:10b6:303:93::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 07:47:56 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 07:47:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIABMLWAgAAMMYCAABwXgIAABlIAgAAsEgCAABE9AIAGpToAgADKIACAAObmgA==
Date: Wed, 28 Apr 2021 07:47:56 +0000
Message-ID: <MWHPR11MB1886C9199AA3F00FF72ACB508C409@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com> <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com> <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com> <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com> <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box> <20210427171212.GD1370958@nvidia.com>
In-Reply-To: <20210427171212.GD1370958@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb10c083-cd2d-4b83-4eaa-08d90a19efe5
x-ms-traffictypediagnostic: CO1PR11MB4915:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB4915CE392AE93B556A1451F38C409@CO1PR11MB4915.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MHzN0f6B8chpsWAA8s9tGJ/g7tghPkb6+H0ElNcsM6xAdS7+ApZn7ZkKa/86RO63c4roR8ETGtP7Z2I+4pRpTbJocZ+MWdcMNnUrfPKUao0hZiUghITcmUOmkCxhSglDcCGwE+8psmMeDUsSYoXu17ZQZlg7bnisum8TS3M8smeI+o7Ub6HyGHLE7S8hLxitpdhs3p7hC4aILYuXkeputv3F/IWsyMYqpiujPl2i3K24eB/q06/CAF+foLWa/7FbcWZXiT7QhyJUWd/VGHDo/ycmyONX2kf40I8bH4s1JnjuvFowFaeSI8Jh5w/FFjdoiQPcg2dKfnm/8Inm1RgIOFqJ4wzazyOvYpjE2NrlhgxjRV+SK+xiH0t5hwzv60aKSpwkugdagXUB483z4n3L+bm1mz4kMjOsHOSfD65q52/o/x1vJwfphiaBPFmwars5PkfOszxUFBLaKfMguLRHLajlKpz/PBU1pkEaCXouWLpWEuzs3L6IrAFCKmM66YcH69PLCp4w+kQpeKdu+3F8kGwgVZwGyLHg2l0zASEllObu2Trxo5aQ74KrhwLkOo6MYEjVHKKuvFd0rTPoD1YjagrFiPQR4T1pCXPib6iJGmA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(136003)(376002)(396003)(39860400002)(346002)(7696005)(33656002)(110136005)(4326008)(52536014)(76116006)(71200400001)(66476007)(5660300002)(6506007)(86362001)(55016002)(2906002)(26005)(8676002)(186003)(478600001)(38100700002)(122000001)(8936002)(64756008)(316002)(66556008)(66446008)(7416002)(66946007)(54906003)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DGoDlZ9cs9a7Ml0TyBNBSl9Imww4usUn9F+58QJkpapbd4fr96cSFkCs4VCv?=
 =?us-ascii?Q?ZTbg0NVeFTdp4yHzMuVEfFN7G1wiQF+2gff5rSubHRZgEkT30JLcx3mnpWJ5?=
 =?us-ascii?Q?GBZ2mqCpW0cD4cgAMjDhQVG3ojqMlNz6STDMncskfZsA36V+Hiq3nfGxT+nt?=
 =?us-ascii?Q?m8jmjobwcsnstL4Pi1hV4QMAZ36c1F70AlI1o0PvAk/Iij9sIj4cGGLQEkzk?=
 =?us-ascii?Q?E5JyD4+s3+ZRpeRgRtQ2lIfWiaDpVSAsEgNrZrZnqYb9+4nsBofM1QZALeWv?=
 =?us-ascii?Q?0LAH9epaNVaaI68CF8B/msPZqx54NvL/+QK4gmDAhDZNmHySFJ6wgq/Wres0?=
 =?us-ascii?Q?qqGDFkTOqUQk85ROOjISpz+/gJaGw2X56UrU8FfB+2rKtaDsNozWVUYVYrJD?=
 =?us-ascii?Q?wKFjA7wL8PoR975daCr1eJwBY0JEyeXwScsaYJdiRcMkbn2WfTJFzMlf1fgN?=
 =?us-ascii?Q?bXEQV5OgRdr8NbNZl6I0u72CXLeDv8ho3VwfHQN6ikg8mCcpBVqUGvATei0l?=
 =?us-ascii?Q?X2rDrjKzX8q6GNzm8Biy8MqKFiYDApLSjtRsjiEFunbZrxW56gdzDoMPR+Uv?=
 =?us-ascii?Q?DnQmkWT+c2kzXdLeXAIM/4P9a1OKrnybIptI/UjueGx+Xx7/9B6hzQcPNrds?=
 =?us-ascii?Q?g5tSOzPO4Zt7B1eVjeIIHOPOZKKuxTZJf2zJVLsxm70kkJCZul4cVBP8l+Nd?=
 =?us-ascii?Q?QyJtH6SfPQrcqYMlmWLuHMBtcgcN2CWKAQO7rKIgaafCBMbrUgJ3cHYPBZhx?=
 =?us-ascii?Q?ZphOmttrCKV5LyDs/vEDHH4DzkAt7SPJQ4oDpO4SI5TBIRabxiYttisIo5X7?=
 =?us-ascii?Q?/zxFrcEo3vq/TetVakpstkdvafISm3TKkpyiWbohItfRtVJSPwvoVM02rROF?=
 =?us-ascii?Q?hl3cuJKCoHuT3ASSErR1xYVUTEKe/GqHEMN+1+Y3pi/FqG2qKXWlFYNz35Bn?=
 =?us-ascii?Q?MQHa+n1/70aP/sW8wju7UNn9q1vSxHLrhyL4mcNTkOb03iGi9J6u6KQLmgBw?=
 =?us-ascii?Q?FBkn54hWhq+DBI/Gl/42VYryW428NMYj/RcOM4dgtWN412tadG344b0jHGzu?=
 =?us-ascii?Q?YCheUoiR7J/s5nvemus9GXwH3/bjhbzUJ7kgMQqngCVX3rlRASCtk1QiCVm8?=
 =?us-ascii?Q?Utn2WVVG8Xr4LnslfoP+H0jGrxR9vUr03B79Y9CJaH5qNJ3uipe0X/UaVyO+?=
 =?us-ascii?Q?BQhTGyAvSjHnm3k8CSCBlUnbpwTd5Nq8aJEp72bBPcBG58E0OI2X7xyj1zdu?=
 =?us-ascii?Q?96eN8hEn0C5MceQFrmKI1dfzwdB08vvmkhia8JsO+Mz4eOILY1MAeHTufwmG?=
 =?us-ascii?Q?C4m0Fp9/gYhyq6oSYjgRiAK0?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb10c083-cd2d-4b83-4eaa-08d90a19efe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 07:47:56.2719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtI6aDH/bnX0XTvxGEgxQoNroWf5wY058TcATyWvHZiEHWc13rasxH33jbG6SakGlLItflHuiORuIURLGIV4Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4915
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu, 
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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
> Sent: Wednesday, April 28, 2021 1:12 AM
> 
[...]
> One option is VFIO can keep its group FD but nothing else will have
> anthing like it. However I don't much like the idea that VFIO will
> have a special and unique programming model to do that same things
> other subsystem will do. That will make it harder for userspace to
> implement.

Hi, Jason,

I have a question here. Based on discussions so far, it's clearly that the
new ioasid uAPI will differ from existing VFIO uAPI a lot, e.g. ioasid-
centric operations, no group fd, no incompatible domains, etc. Then 
I wonder how we plan to support legacy VFIO applications in this 
transition phase. Earlier you ever mentioned the desire of directly
replacing /dev/vfio/vfio with /dev/ioasid and having ioasid to present
both VFIO and new uAPI. Doesn't it imply that we have to copy the 
VFIO container/group semantics into /dev/ioasid although it's a special 
programming model only for VFIO?

Alternatively we could keep all the container/group legacy within VFIO
and having /dev/ioasid support only the new uAPI semantics. In this case
VFIO will include a shim iommu backend to connect its legacy uAPI into 
drivers/ioasid backend functions for backward compatibility. Then VFIO
will also support a new model which only uses its device uAPI to bind
to new ioasid fd w/o using any legacy container/group/iommu uAPI.
Does this sound a plan? 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

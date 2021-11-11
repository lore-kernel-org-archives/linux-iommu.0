Return-Path: <SRS0=Rhk0=P6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951E8C433F5
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 12:32:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39BCB610D2
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 12:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 39BCB610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2D90404E3;
	Thu, 11 Nov 2021 12:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qe_gXgykZKAy; Thu, 11 Nov 2021 12:32:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A9C4E404CB;
	Thu, 11 Nov 2021 12:32:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A550C001F;
	Thu, 11 Nov 2021 12:32:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACC22C001E
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 12:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F83D60B49
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 12:32:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kq9R2uI-U-gF for <iommu@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 12:32:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8CCC160B3F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 12:32:04 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="219792923"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; d="scan'208";a="219792923"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2021 04:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; d="scan'208";a="492527468"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga007.jf.intel.com with ESMTP; 11 Nov 2021 04:32:03 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 04:32:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 11 Nov 2021 04:32:03 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 11 Nov 2021 04:32:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXYkk6Lh3KKR+CVE5TorCf3d8inoXB4KdnqzAjLqREIPQI3KPd61QWwI/elJGPt2UN9bVRIzQHZYYJEWXdqrTf4cEumuGmsz+MiKnJ89oWQczkEsmMXCmGMLxLPFX4OVzBf/mYhJKIt1BgTkubBXtClCD7COl4eYUBFqsigzxzwvrXM2bhrrDGstlQwZ24QOWELgDCcwoA6K3WFfnnoMcqKMMf3ENnoJ0Q/AQkvImxTj0yTlCmF+5VoONHQkiO92y2yMbAFrIZEgFEBQIVIcIDdIO/2WPRM5LQHpukGE3OP78s9cpUBGFhEgIoe21BJER9oxYLmCZfEJVST5RZToxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Le+CFli682kT16P7G6lDEMnWTHa853kI4oVrHqcRy44=;
 b=P2eHwnH17dzUOL1WrGMbzhytT/fTZtl1sAPIYXpghd7/CJuPJRpDW4d1eQFcbrYKAx9qqG2M6iPM01tnEDECb6XukYL8OJsun2LXOoiLBvR7nkfVFsFTMzpA7dGFh4WEzSmwGYq7Ta2s22YPhTf7UMOlVhkA8FqRi0oyKb5OR4NCo5wo7aciRQyDWbRt6jyxtc5ubwCB5BqiSJ48T8oSrRgu2nIdBKBLkfZMk5IDXCdnPjW5DOIvZsEtdQzNw1HWpTVv38lbuMVB2biSKrwwgi16zH0ATJkHw092R+wFqiIuRij0WroLQqLh2VjTcYgR76pz851N+BjeU6H9rmXiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Le+CFli682kT16P7G6lDEMnWTHa853kI4oVrHqcRy44=;
 b=d9UiuWV+92spXv4Hobc8x72Vcxg7o23wRlpNFMl05ALKYQFdA4aJCwL+0wbrXa/ss49baD86dN04O44CCh4LgXjho7kaNrwbEqCv4T01j0ud1JZNS6BwrhnHXgn1vYH404q2uKtkTmjspBWgVKR0WcOhtx5nGd/UOxymAg5KKYs=
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by PH0PR11MB5595.namprd11.prod.outlook.com (2603:10b6:510:e5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Thu, 11 Nov
 2021 12:32:00 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::e849:e503:195c:b69c]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::e849:e503:195c:b69c%6]) with mapi id 15.20.4649.020; Thu, 11 Nov 2021
 12:32:00 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 02/20] vfio: Add device class for /dev/vfio/devices
Thread-Topic: [RFC 02/20] vfio: Add device class for /dev/vfio/devices
Thread-Index: AQHXyZ9N9hHTiUakTUi0phVNj8QgQ6vpuU9ggATxeICAAVDBMIAB3diAgAyAZCA=
Date: Thu, 11 Nov 2021 12:32:00 +0000
Message-ID: <PH0PR11MB56582105A53056F2B7DDADB5C3949@PH0PR11MB5658.namprd11.prod.outlook.com>
References: <PH0PR11MB56583D477B3977D92C2C1ADDC3839@PH0PR11MB5658.namprd11.prod.outlook.com>
 <20211025125309.GT2744544@nvidia.com>
 <PH0PR11MB56586D2EC89F282C915AF18DC3879@PH0PR11MB5658.namprd11.prod.outlook.com>
 <20211101125013.GL2744544@nvidia.com>
 <PH0PR11MB565808A9C9974A0D0D72B738C38B9@PH0PR11MB5658.namprd11.prod.outlook.com>
 <20211103132547.GM2744544@nvidia.com>
In-Reply-To: <20211103132547.GM2744544@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68a5f8a6-33de-4a79-56cd-08d9a50f4281
x-ms-traffictypediagnostic: PH0PR11MB5595:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB55955299E4A26702E5287AD6C3949@PH0PR11MB5595.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0cdWl5tbH7T4g7jIX4KnO0nWOo58cC9dHEWjNGoyTuFKFGDXYAMvtOoRgqQx4exRPFM9l8abz2B7ZgLClYNW/aJPYZkRvctzZaUEnMRm79XkeykOnc95j3Oh7wXYsVpSG3aVHNn3pr7W1BhW7st2UhOTwQXttbkDHhJFuTPCMTHApaWOTnXFE6QZBz4lHu70018nt9gqD1wKMCgP0s1/D0JIqC8dHkqiCJHZ0mIAAug30OMk4MpDTEN1tYw4dv82+hkkJtsIPJAE/91Nt8kUyGMehi97uEHPYipXiYQabDGF0jIKZ5S/GT9mByC0nfAoYM1DebagZYyL+uGXHYr2aKD353e1qh41PS7oYhedxCIB4sAYjwVed6ZaQomAmbA4riNLBMT0wXuxFgM+k80ov2QYgzh6Fp0TWhLnpGiN+hohEKVT9woRf2gUCKmxOC3MCIXXSOqYfu1Qf3KqmlGYVfQix/J0P2NF9VCvj3USQu0lp9yYwcBT0G6tCNhlR29zBYS4b/CGwp0Eo4OVFXta3AvndRvIrC0VJeixTIBSN4l5OoxDUeTPoNRHx5c7fH3XEUHQIqqS+iZ1wTL/u1X1w83oR7pfMn/I7SqzKz9+jlk8GvUoftbbb+DtPHbSj0Y5AHJYzVJIqUo38h/7av7m5fhydbz5lH7Q6FPgeFxih+R8a1D3ApBiVNuegmqhUKT9y8gwhLb+FSwdmtNKNirOdH1orhpWngrCP3NsEVwdrPAqA82ctUKeC008jMGI74RMFi3tmp3LtF5rkiaWrItveHpR8ZQp5cYbFhSBvDrV/LM5nmiig+5eo6EmdKidE93z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5658.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(33656002)(6916009)(82960400001)(2906002)(5660300002)(26005)(316002)(54906003)(122000001)(7416002)(71200400001)(38100700002)(52536014)(38070700005)(186003)(7696005)(8676002)(9686003)(83380400001)(4326008)(64756008)(66476007)(86362001)(66446008)(66556008)(55016002)(66946007)(6506007)(76116006)(966005)(8936002)(508600001)(9126006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/NADS/+iZl44zcRd58SVyFcspVAa5CnLPDNCA/Hd3EDlJkpz5gnuExtNaFWg?=
 =?us-ascii?Q?3MkQxkYz+3QV7VBzlG+7lH6hF2OXtYpD1fhot0HUNDl61u8jXLoJzJxKHXHP?=
 =?us-ascii?Q?k9LLfJ3+zXqgK45hZsYfncesXswWh0NJMVCgAFfuMnvacNZTn7d2/JzC7y15?=
 =?us-ascii?Q?0GPFhkFwIYV8j9wkWCBlX2MpLshKQ+jbSuTCRm6HyMaBT1PkcIuHUUV2vbcQ?=
 =?us-ascii?Q?yaF44TONXVREvXaJHWlbIwsw7kykAHbXefrmzb/kT1AB18N0N3ZvR554+DwR?=
 =?us-ascii?Q?oWo4YsMgSAa4MfJv2rCoQWn3ISR6OXNY9mBE0RlOaE5855cgbl3fXyu70hZR?=
 =?us-ascii?Q?m4F6uwxkrFC5Ohy9vrSTRqtCMzqv2zJQHfAdlgrZJFRP/kuCyaziVsWRbzu7?=
 =?us-ascii?Q?DHngtSP/rdgVZYcj+Gr+JvW1Yw4l208Ls5zXy5GV3vWB2g2sc3CHrMBhYISv?=
 =?us-ascii?Q?shjXLmrpSb3ed4haX3PUMQm/t3/bW4GWsnDxiN8Aru9cykn9mWpbcm1gtcZ4?=
 =?us-ascii?Q?anwQ2dluaFVq4K/qLHfgcIYrwdTkkiSsR81lUDtrlFUTOywSBJxsihDGA+9W?=
 =?us-ascii?Q?vPqry0LElUC7VPNIiSiyWJhITXcBgxN19GJ7U0/FIAVKMPpxZRXU6/pG59ox?=
 =?us-ascii?Q?HhgF+4illPl9YaMVq9TsURncQ7L+TMMpZHN7bczghhnhQ/gyw6jeonepQTU6?=
 =?us-ascii?Q?sdxIsVN6NPhfYMkRz4ju3jt/5XPPJaRDBjucUbDyuaS9yox8hlHHa+A2tyFu?=
 =?us-ascii?Q?rhOUvalrOyLXjkeTk4tY4Xm29BvgcJuQp0UXQqlO1EQzU7Y7+k9GwJ5sMSTx?=
 =?us-ascii?Q?G7ucncMoJTB2jVfUfe55+XORqYlzufr4+Br1KyzO+ApB1EpWkUs/ESPPmW+f?=
 =?us-ascii?Q?lmfVcqcjiDJYHIKF/MEWRhLPV7qXhrOGWwjw4G0B5OP3msIpiibm3SvcPTQ2?=
 =?us-ascii?Q?IzZagHJn2YHTgnRLXv04Lr9/PdN/WW/4wjMA440PPhPJwdhB/Px08cx0mXUK?=
 =?us-ascii?Q?T4bLGp4NSEtqxz3hwGrmrujemwHruRG44VBYw1n/h3XKzIKfJ/OqZZcK+z29?=
 =?us-ascii?Q?6At9PKXu+AIkTdNmE2Ht0xhYYW9PGWGC2xVnDHhPHZD1uLIQIgZKwxmqZM29?=
 =?us-ascii?Q?YFne/8cRRTXdERSIKrVUmEIREen0fdCfeL+ZhAB6EapdsnT+faJoADzZT716?=
 =?us-ascii?Q?HnqKFLxQy7ciQ/5NVE2CjOu08ZymRb0yFME4rr1kXerJnCQgFPHjQY82awjT?=
 =?us-ascii?Q?WLavj4RkEaoSBhTakdCxkxOQdovk+8LMO3e6fEOZcKGuLkGqPr8MeBF5rqWG?=
 =?us-ascii?Q?HM1oPmQmmTb1ju2aAqdWdgCDdAZ5xFsRbMPVlEew1NH+nF3H7MGKABt9lLW1?=
 =?us-ascii?Q?yXzs5csCOkmDOAo9Ib6VWpZMU+GJg8gGcSeSLutZvBV6H9dNXaSZO2lHlYac?=
 =?us-ascii?Q?LHau76ODBgUn0IQNA6WGd+If4EGdU5ih6K4ALndZxpwYRPRKNz5txVrHOC7p?=
 =?us-ascii?Q?ulYjmwWyd4dqjHYSUqtghnCtUGr2ZCJQ0SlpwdmaQN2/UcUAIwFwa8B9iKIL?=
 =?us-ascii?Q?IbyqvDo3sQzTxPAz8lMK7Btfmx2q9GqBzyUJTEkg+6rLwl9CUynfnNEA4jag?=
 =?us-ascii?Q?pkGR53vd1QWLAtGM0inJnUI=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a5f8a6-33de-4a79-56cd-08d9a50f4281
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 12:32:00.6439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AwTUaYdY+/+L4TIqBnqXZRL80ApqyPVtmfbbopAN8a8nPe6rxfN4cuF4iFeJEDEKG0sahQRBqdMjaa/Vs5BG5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5595
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
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

Hi Jason,

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, November 3, 2021 9:26 PM
> 
> On Tue, Nov 02, 2021 at 09:53:29AM +0000, Liu, Yi L wrote:
> 
> > > 	vfio_uninit_group_dev(&mdev_state->vdev);
> > > 	kfree(mdev_state->pages);
> > > 	kfree(mdev_state->vconfig);
> > > 	kfree(mdev_state);
> > >
> > > pages/vconfig would logically be in a release function
> >
> > I see. So the criteria is: the pointer fields pointing to a memory buffer
> > allocated by the device driver should be logically be free in a release
> > function. right?
> 
> Often yes, that is usually a good idea
> 
> >I can see there are such fields in struct vfio_pci_core_device
> > and mdev_state (both mbochs and mdpy). So we may go with your option
> #2.
> > Is it? otherwise, needs to add release callback for all the related drivers.
> 
> Yes, that is the approx trade off
> 
> > > On the other hand ccw needs to rcu free the vfio_device, so that would
> > > have to be global overhead with this api design.
> >
> > not quite get. why ccw is special here? could you elaborate?
> 
> I added a rcu usage to it in order to fix a race
> 
> +static inline struct vfio_ccw_private *vfio_ccw_get_priv(struct subchannel
> *sch)
> +{
> +       struct vfio_ccw_private *private;
> +
> +       rcu_read_lock();
> +       private = dev_get_drvdata(&sch->dev);
> +       if (private && !vfio_device_try_get(&private->vdev))
> +               private = NULL;
> +       rcu_read_unlock();
> +       return private;
> +}

you are right. After checking your ccw patch, the private free triggered
by vfio_ccw_free_private() should use kfree_rcu(). So it is not quite
same with other vfio_device users which only need kfree() to free the
vfio_device. So how can I address the difference when moving the vfio_device
alloc/free into vfio core? any suggestion?

@@ -164,14 +173,14 @@ static void vfio_ccw_free_private(struct vfio_ccw_private *private)
 	kmem_cache_free(vfio_ccw_io_region, private->io_region);
 	kfree(private->cp.guest_cp);
 	mutex_destroy(&private->io_mutex);
-	kfree(private);
+	vfio_uninit_group_dev(&private->vdev);
+	kfree_rcu(private, rcu);
 }

https://lore.kernel.org/kvm/10-v3-57c1502c62fd+2190-ccw_mdev_jgg@nvidia.com/

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

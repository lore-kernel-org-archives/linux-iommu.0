Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A8FC433DF
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 06:31:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690C720716
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 06:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="EwMXGgKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690C720716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1FD982035E;
	Mon, 17 Aug 2020 06:31:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pL-T+7ANHXc7; Mon, 17 Aug 2020 06:31:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 55AD52034C;
	Mon, 17 Aug 2020 06:31:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F7A4C088B;
	Mon, 17 Aug 2020 06:31:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3912C0051
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 06:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DE6A4865C1
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 06:30:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4s-EI6SVU9c4 for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 06:30:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0863986594
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 06:30:58 +0000 (UTC)
IronPort-SDR: 7lVIvmMrVAmFpZrsmcaU9bHjVc5QGh4hpDUoeQvxb9Qxnatrcvpu4VN+7ftrp9kkvN7FgQkTcH
 /fEglIxjI5Bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="216166488"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="216166488"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2020 23:30:58 -0700
IronPort-SDR: 9sjl7DlZBUVxhluMHW76zwsi3g8unUv+RrUGcTu3e+2UUvCe2GEgMrQQ356/bgUJVXljCjbXjC
 1Ulmi8PeqDnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="336188149"
Received: from fmsmsx601-2.cps.intel.com (HELO fmsmsx601.amr.corp.intel.com)
 ([10.18.84.211])
 by orsmga007.jf.intel.com with ESMTP; 16 Aug 2020 23:30:58 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 16 Aug 2020 23:30:57 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 16 Aug 2020 23:30:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 16 Aug 2020 23:30:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 16 Aug 2020 23:30:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmHFxDlqna3cYMyqy3k1IdYjCfBnWN2hWejirG3/5g1ZEusR6D/V8qFMTRknNM3aIBw+wPNh8Qa1K6swZpqxXDw75UiBJA+WuW1p8l3QZyZADrNH8YrML1++g1PqxoTHjcoYcbCg9GOioFMBXSjqLoqeT4vB7X2WGNHa0B/QBlEov1lTJzkvxzbS7ZaBkxpvmUnCFyc9s7dyEprDo/55/Fx2PsAKbsV1ZrTW7hbRqrPfIa+oeu+2tl6QBMKFTakfDgRQzJGbWdPHpSE+wzTG3IV3sRdSj0oLzahBUE+XuPWUfrFU8RVum0FjnSDeeSqUMQB+t2YABMsYZ9g2SJTCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovIARKH7ArULcoswuEAyiCeLregs4RoiRzn425UzWnc=;
 b=G6l1zICFtVl1EPsm50QAIAOdK8yKu0phVAPGgnSD3/LB1fa6LX39cORyds9qC57KkO0U61ABYic/EErgKbtZ8FSYdBf7A8+HuVfDvamI4UfDpkcwznDpaK+HwW069i4GcWI0QrU2du1lf6bXpqKZ8sO8Fau7sr7RuvP4eX8Rxn60RAjkVgnnRpyJltUYUIZLyzg3zbyHEiIKGFb0uFLW9kEqqNp8Yf2WdQfVamY2XRGa9o/IcGWz1x3tkBiEw1F+hUY8XYhccnLDmBEWI7wxRUebwPngUWuToP1ns1GiY2jFD/L2Zy7xXWeTiQEgXJlc+H8gIUZuEhtckTaxjmKM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovIARKH7ArULcoswuEAyiCeLregs4RoiRzn425UzWnc=;
 b=EwMXGgKNzjx/iaFX9nIk9/xMUek1kSTbWoQMRUHkAALE+ANlWx+MXVYMBarPYybUsrJQmA+uCCykmJ70NCQChYFS6bLqKcfa9gAWeUTdBRngBTVkNrFFmD99j3e0/BdKJdBwm+W+Sjqlbc3maNLRUfu7btBNENqFNR06k0pzXRM=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4441.namprd11.prod.outlook.com (2603:10b6:5:200::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15; Mon, 17 Aug 2020 06:30:56 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3283.027; Mon, 17 Aug
 2020 06:30:56 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v6 11/15] vfio/type1: Allow invalidating first-level/stage
 IOMMU cache
Thread-Topic: [PATCH v6 11/15] vfio/type1: Allow invalidating
 first-level/stage IOMMU cache
Thread-Index: AQHWZKdIe1LgYQpv3k6k7A0drA9ljak6uVmAgAE0uTA=
Date: Mon, 17 Aug 2020 06:30:55 +0000
Message-ID: <DM5PR11MB14352249DD871385C7811782C35F0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-12-git-send-email-yi.l.liu@intel.com>
 <f0c7cfc1-ee6b-c98e-77bd-1af3dbaf2a6f@redhat.com>
In-Reply-To: <f0c7cfc1-ee6b-c98e-77bd-1af3dbaf2a6f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [117.169.230.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 843acc68-68e0-4c40-84bd-08d8427718fc
x-ms-traffictypediagnostic: DM6PR11MB4441:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4441D1FA74D4419C1704191BC35F0@DM6PR11MB4441.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ML86/xSMPEhwFUcsvVCoaxX9WWKe+usVMsEC9AdNopuS3UUtWnWlHm3m7yxyHAMCAORuPcTRtkR+DQFTpBCVtZwUJ48AOOrkm2r0HhQbNUCU416ba3PyKZAk9Oi3u4QL0F82E16lIjd1srgeY7LiOxxooVZJPP19f9zi4wBU8+zYxxmwkdDMVSM4Hge/jAWcmTV4Krtk1ofQOJ7pMseaqgBtFG2jPfNN3kqv0j4zAXGMEtr+KV1mP2JnHDZRzfQLlVCzTcSyM32XaKIhcxhgVfoNyvNsjm2Hwy8p3S8s5CO65FZsVG/DPgXXb1A/bvVs5fSZV9MBeDAo9UB56xduBA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(4326008)(2906002)(33656002)(83380400001)(66946007)(66446008)(8676002)(64756008)(66556008)(66476007)(76116006)(86362001)(8936002)(110136005)(478600001)(54906003)(5660300002)(7416002)(71200400001)(53546011)(55016002)(7696005)(6506007)(26005)(52536014)(9686003)(186003)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 8HUaknad7GIy5Sjfjj5gDpnv/TZqBmuoZSuOexFGKlDX/HWxm+PMgvOzXcJ9Tg92BVoTOi5N6YvUczCVELKNNT6KHnAOQfGxc8eDNryAs5Yexh6QhR7hmn4xoa2kbNVekoiQGrdXDA2gJ9Nwf8TZM3/3H+n1AkfhtWFN9k0dW65WuxnvK1kDvzmGbyoJNQDalC/+HrhiQRjB1gclklU5IeHohWQaTegMyiuCR77NF00VmqM3btGtpHWB1SdE6YhuK3HgO0dTozld1Eo+wBLlc98UbJvfyJgo5EjQFvSOSfuQLRinet4WUxSQj8BrPEjDWYonZqvo/xSo3J9rtcNRYv6sh8eFj2Z9QQcwg0S+7ZlQtvorkD5LWpr6O7hKh1ZEK7r6gYFoDvfYdfJTw3T9qdYahVyO4xv5tYlxAzsttLYnY/1Yn94MzzMU2ZgyVYv3qWzFBkKTIZj/XH7rjiniL3UekRubCUTPq7g8MQJAC2aJ03R4s5xzQI1BVtF/mFDiYKGK2v7djVSfKRGlmAlEUzcYhzppm3lUOPH81+Iwbxj1o6vqnsZkQGZAicYeGnGs8aySPxewLxRPU3yIHVXj4Efb6Nx6mp7piVVljKq8vRyrgIC8ZOnm5xFnJaYOx5xx8LTQllXV26Ov/8hZRijk8Q==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843acc68-68e0-4c40-84bd-08d8427718fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 06:30:55.9509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qeq+TgVSevLdUYo1PxT+LZ/+z2yl3KTSKx9QqkwrPzL9ZW2q/puuNOTIzvsLn5X2RGE9SI/flrCLKUmAE15fIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4441
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

Hi Eric,

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Sunday, August 16, 2020 7:35 PM
> 
> Hi Yi,
> 
> On 7/28/20 8:27 AM, Liu Yi L wrote:
> > This patch provides an interface allowing the userspace to invalidate
> > IOMMU cache for first-level page table. It is required when the first
> > level IOMMU page table is not managed by the host kernel in the nested
> > translation setup.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > v1 -> v2:
> > *) rename from "vfio/type1: Flush stage-1 IOMMU cache for nesting type"
> > *) rename vfio_cache_inv_fn() to vfio_dev_cache_invalidate_fn()
> > *) vfio_dev_cache_inv_fn() always successful
> > *) remove VFIO_IOMMU_CACHE_INVALIDATE, and reuse
> VFIO_IOMMU_NESTING_OP
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 42
> +++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/vfio.h       |  3 +++
> >  2 files changed, 45 insertions(+)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index 245436e..bf95a0f 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -3056,6 +3056,45 @@ static long vfio_iommu_handle_pgtbl_op(struct
> vfio_iommu *iommu,
> >  	return ret;
> >  }
> >
> > +static int vfio_dev_cache_invalidate_fn(struct device *dev, void
> > +*data) {
> > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > +	unsigned long arg = *(unsigned long *)dc->data;
> > +
> > +	iommu_uapi_cache_invalidate(dc->domain, dev, (void __user *)arg);
> > +	return 0;
> > +}
> > +
> > +static long vfio_iommu_invalidate_cache(struct vfio_iommu *iommu,
> > +					unsigned long arg)
> > +{
> > +	struct domain_capsule dc = { .data = &arg };
> > +	struct iommu_nesting_info *info;
> > +	int ret;
> > +
> > +	mutex_lock(&iommu->lock);
> > +	/*
> > +	 * Cache invalidation is required for any nesting IOMMU,
> So why do we expose the IOMMU_NESTING_FEAT_CACHE_INVLD capability? :-)

it's a stale comment. should be removed. :-)

> > +	 * so no need to check system-wide PASID support.
> > +	 */
> > +	info = iommu->nesting_info;
> > +	if (!info || !(info->features & IOMMU_NESTING_FEAT_CACHE_INVLD)) {
> > +		ret = -EOPNOTSUPP;
> > +		goto out_unlock;
> > +	}
> > +
> > +	ret = vfio_get_nesting_domain_capsule(iommu, &dc);
> > +	if (ret)
> > +		goto out_unlock;
> > +
> > +	iommu_group_for_each_dev(dc.group->iommu_group, &dc,
> > +				 vfio_dev_cache_invalidate_fn);
> > +
> > +out_unlock:
> > +	mutex_unlock(&iommu->lock);
> > +	return ret;
> > +}
> > +
> >  static long vfio_iommu_type1_nesting_op(struct vfio_iommu *iommu,
> >  					unsigned long arg)
> >  {
> > @@ -3078,6 +3117,9 @@ static long vfio_iommu_type1_nesting_op(struct
> vfio_iommu *iommu,
> >  	case VFIO_IOMMU_NESTING_OP_UNBIND_PGTBL:
> >  		ret = vfio_iommu_handle_pgtbl_op(iommu, false, arg + minsz);
> >  		break;
> > +	case VFIO_IOMMU_NESTING_OP_CACHE_INVLD:
> > +		ret = vfio_iommu_invalidate_cache(iommu, arg + minsz);
> > +		break;
> >  	default:
> >  		ret = -EINVAL;
> >  	}
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 9501cfb..48e2fb5 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1225,6 +1225,8 @@ struct vfio_iommu_type1_pasid_request {
> >   * +-----------------+-----------------------------------------------+
> >   * | UNBIND_PGTBL    |      struct iommu_gpasid_bind_data            |
> >   *
> > +-----------------+-----------------------------------------------+
> > + * | CACHE_INVLD     |      struct iommu_cache_invalidate_info       |
> > + *
> > + +-----------------+-----------------------------------------------+
> >   *
> >   * returns: 0 on success, -errno on failure.
> >   */
> > @@ -1237,6 +1239,7 @@ struct vfio_iommu_type1_nesting_op {
> >
> >  #define VFIO_IOMMU_NESTING_OP_BIND_PGTBL	(0)
> >  #define VFIO_IOMMU_NESTING_OP_UNBIND_PGTBL	(1)
> > +#define VFIO_IOMMU_NESTING_OP_CACHE_INVLD	(2)
> According to my previous comment, you may refine VFIO_NESTING_OP_MASK too

yes, I've noticed it. also replied in patch 10/15.

Regards,
Yi Liu

> Thanks
> 
> Eric
> >
> >  #define VFIO_IOMMU_NESTING_OP		_IO(VFIO_TYPE, VFIO_BASE + 19)
> >
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

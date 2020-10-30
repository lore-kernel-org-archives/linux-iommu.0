Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6F1C56202
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 05:56:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1236020729
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 05:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Pz/uoO8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1236020729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F21ED22D33;
	Fri, 30 Oct 2020 05:56:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xHUPZpR4XzIr; Fri, 30 Oct 2020 05:56:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BA2992049E;
	Fri, 30 Oct 2020 05:56:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95735C088B;
	Fri, 30 Oct 2020 05:56:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AC61C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 05:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DFBC520530
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 05:56:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x7LonlrPNTK1 for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 05:55:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 9FF0F2049E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 05:55:59 +0000 (UTC)
IronPort-SDR: vdIpRZYpasOyf4QCeZdm52QLB50LV0Nq39VpLc1/AbblnpH2EZ5Lvg8pVsb6e+WQ9MyQTinDpr
 e2ebJDDq4dZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="186366070"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; d="scan'208";a="186366070"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 22:55:58 -0700
IronPort-SDR: AJXmq23mJz5RvhEQ6c+h4TufTspfYQuN4zxcIKDJ+wZbvVg0/GWwHgNYjqdNJG747FoXywKFze
 1bEeTvkqd52Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; d="scan'208";a="525792213"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga006.fm.intel.com with ESMTP; 29 Oct 2020 22:55:58 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 29 Oct 2020 22:55:56 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 29 Oct 2020 22:55:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 29 Oct 2020 22:55:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 29 Oct 2020 22:55:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYojaxtvWAphVcKk2PebMy7ZY4ystucPyAtFf3pZTvKoA9gxdi642aOBVPELGgQIh3RPVfS/uIoYY7/aU2xGLT5/8evlCMngfIoiaFrQO85wqFexNDODKRUP9OqEyr1UPQgwbSbICR4bft4xS9QW/xECg6iMa90ome+1IustRc76fUHcuOHV5dFJGvXrKA08Xd6Tf6voZRAB7cVjfsN9M8XALFMnqC5ONwGf5KPvLp3NfAnIwaMv6Hd1Le95V4JWfBKDSG5m9XyJ6aGYGo07K5piqqixpBlQjt4lk8mjFuskintvlZJoj+cKw5UzcGwwyuE54ETE2gC/P7mDdUtIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVbA02TnATLePQw9CDAcn7TuHKpEdlo/O+nP0VQqdB8=;
 b=iEzPWlX61VfTZ/Ld+1/LHrkwAy7cuJClk4KzIXsqmxodRu+De2s1JD5CVZaHXcUbLGtWshjkDjZHVtTpU4i6NJnI0tZzKd/6bDMmudS9K0oz10GskrstJX1/F9Ve/nGfN5IvEvzaipwy7xjVWxEN3jxnAnK362Wlw3OAkE2Ade1RI2kDjI/XVVVgjcU84bHTgoHew4d0cSBN3L0VfjETh5J3/SCgZS8SlM2t9W2N3GDzh+LdvEttm8TYFM6ylP/M5Ob+Cr6jOrDB/qkfn1QG4yUyGjDg3EPCNL67OKXFy7SOT9nvVPzpdl3EGGWoeXbvg0Y+rMPyDwIejUZ7n8e3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVbA02TnATLePQw9CDAcn7TuHKpEdlo/O+nP0VQqdB8=;
 b=Pz/uoO8dRIKIMbpzb6Lrk0Fe5MsCn+g9Lwi0Deg1oq5Cwfexqqz75SLLVymF7EhiTOmKyYATuTZ4BDqxHpg/Xz770lXPcSbTxdKGxb3auTwFr7FUuO7x73S4irTssB8aAI8oX25TIE83UNv4An/YKJzIzGWaq6k1zrH5EQnnNl4=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 05:55:54 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::c88f:585f:f117:930b]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::c88f:585f:f117:930b%8]) with mapi id 15.20.3477.034; Fri, 30 Oct 2020
 05:55:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Alex
 Williamson" <alex.williamson@redhat.com>
Subject: RE: [PATCH v6 2/5] iommu: Use bus iommu ops for aux related callback
Thread-Topic: [PATCH v6 2/5] iommu: Use bus iommu ops for aux related callback
Thread-Index: AQHWrnpLcdhjwgiX40SApbaxx6/zZ6mvpLKA
Date: Fri, 30 Oct 2020 05:55:53 +0000
Message-ID: <MWHPR11MB1645D795F7851F5894CB58D88C150@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20201030045809.957927-1-baolu.lu@linux.intel.com>
 <20201030045809.957927-3-baolu.lu@linux.intel.com>
In-Reply-To: <20201030045809.957927-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37a9c63a-a2b0-4583-e931-08d87c9876a9
x-ms-traffictypediagnostic: CO1PR11MB4835:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB4835379DD09AAD922395CEAE8C150@CO1PR11MB4835.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NHLTTmZGheoKExgrNjk4CCuo5PXOozyUk2eU/0nkYFhRuNA+saSxtLBZSVMK0YWKkpEF/k/Lj0IxS06OO1CCZOIfPa8YA8zT7GNqa/OAUxPahwfzWZf8b6NtKQ0ZKzia/vDzEs677dhTI60UPPJbP/cz66qUswuMhGyUzfEkVsf4HDJ4I22LLJKDYQD8GdKm1vfAcrNudmjDCLB7/IgjSz6gXcB4CgLy2SLcvySHfCWMT17vj+fakW+CK1//+zdLLy4uarMHGjKRO7ZiGwulX4vrGHN/360vgqoWY8/5YK/3s0St1pQqK61odm/e6fjhuzj71ADKK4Hzks9hmd2FrQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(66476007)(26005)(66446008)(478600001)(71200400001)(5660300002)(55016002)(86362001)(186003)(4326008)(2906002)(316002)(6506007)(8936002)(9686003)(54906003)(33656002)(66946007)(110136005)(76116006)(8676002)(52536014)(83380400001)(7696005)(66556008)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: KLvD1RYs3QFeH+H427anY/5F9YrbafZ+MZnHv37o06YC4fVtxpjEcx2hoO21Iow+mDbYgZAZxm7SCUG9nxLjRnnche8syqHJ0ikgAfIP/Xfe2SMe49O04+luFEFCoFunaEd3mGqfrWDEHO+GfuN8v10GUVaDYyCubiV6n1Gke/LPUKPmxz4E1Fz2kIMZ23+b/2NMFCDql3DNBRugLALie3U25L7bCUSXMEeJAZ+5Bu0AG6avNLXT3BHcraI9LxyGD9Bjik9tTbVt0Y5Y9a0bwie2+i0FBS72R8I6DwzAHLnNd+7iFGtvVQq53pawzoaRUlcph+rOUodP7HvgNmf4O/pYJE21ZwQv9kyCy2c4L3NtZF+D8B25Wse+4ziylgPKG5MXINaIygZdk6RPPgTopXq7nGOpnCB26iOq4VZwH0vK6BW8Qsw0NqNPz37nh9jnxPsz4YlEus+NwkVzc6hxcFYDQZcwESMHglw/zlom5Q85fhMCw3QK9Hx+rDmnYxKVipbFCnsDRUum1QxUZSdQIVMQn1WFvtMbT5/uBSIcAgdUDXD7Xg9qPVyyIUJQS6+fc9TKdHKQIs0th/s2JHhaV8DZQdMZ3JiAJGYD04zjVF+S486zt+kZ5dCwkJvHSiG5NwBB2+0dX3blfHjGJVGoIw==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a9c63a-a2b0-4583-e931-08d87c9876a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 05:55:53.9375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hMjfjf4FVpzD78J3wipNEF2b5oAH8RQDSeb7lgCJz/iJ6dVePjQGFTQgf3MvdxpQtByhnbKFY0wDYgv/DqBRpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4835
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, October 30, 2020 12:58 PM
> 
> The aux-domain apis were designed for macro driver where the subdevices
> are created and used inside a device driver. Use the device's bus iommu
> ops instead of that in iommu domain for various callbacks.

IIRC there are only two users on these apis. One is VFIO, and the other
is on the ARM side (not checked in yet). Jean, can you help confirm 
whether ARM-side usage still relies on aux apis even with this change?
If no, possibly they can be removed completely?

Thanks
Kevin

> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 6bbdd959f9f3..17f2686664db 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2913,10 +2913,11 @@
> EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
>   */
>  int iommu_aux_attach_device(struct iommu_domain *domain, struct device
> *dev)
>  {
> +	const struct iommu_ops *ops = dev->bus->iommu_ops;
>  	int ret = -ENODEV;
> 
> -	if (domain->ops->aux_attach_dev)
> -		ret = domain->ops->aux_attach_dev(domain, dev);
> +	if (ops && ops->aux_attach_dev)
> +		ret = ops->aux_attach_dev(domain, dev);
> 
>  	if (!ret)
>  		trace_attach_device_to_domain(dev);
> @@ -2927,8 +2928,10 @@
> EXPORT_SYMBOL_GPL(iommu_aux_attach_device);
> 
>  void iommu_aux_detach_device(struct iommu_domain *domain, struct
> device *dev)
>  {
> -	if (domain->ops->aux_detach_dev) {
> -		domain->ops->aux_detach_dev(domain, dev);
> +	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +
> +	if (ops && ops->aux_detach_dev) {
> +		ops->aux_detach_dev(domain, dev);
>  		trace_detach_device_from_domain(dev);
>  	}
>  }
> @@ -2936,10 +2939,11 @@
> EXPORT_SYMBOL_GPL(iommu_aux_detach_device);
> 
>  int iommu_aux_get_pasid(struct iommu_domain *domain, struct device
> *dev)
>  {
> +	const struct iommu_ops *ops = dev->bus->iommu_ops;
>  	int ret = -ENODEV;
> 
> -	if (domain->ops->aux_get_pasid)
> -		ret = domain->ops->aux_get_pasid(domain, dev);
> +	if (ops && ops->aux_get_pasid)
> +		ret = ops->aux_get_pasid(domain, dev);
> 
>  	return ret;
>  }
> --
> 2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

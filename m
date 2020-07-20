Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529BFC433E0
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 10:42:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C2F2065F
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 10:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="s1bpca1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C2F2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B3F4B2152F;
	Mon, 20 Jul 2020 10:42:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8S-n7e+R8ibc; Mon, 20 Jul 2020 10:42:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 16E2A204B5;
	Mon, 20 Jul 2020 10:42:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE482C0894;
	Mon, 20 Jul 2020 10:42:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5F97C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 10:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D2A2A85D6C
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 10:42:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x5K5y992lsVi for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 10:42:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C2B1E85D59
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 10:42:12 +0000 (UTC)
IronPort-SDR: FZ6UELAbLZS3iQ7vqIxaAnhCeeitCbHMXISZsfS0Pj/8Ou0HUD9wwtd5OhMV6gZu73HR7M5456
 WFLPWZT1s0Ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="137368239"
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="137368239"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2020 03:42:12 -0700
IronPort-SDR: AB/nf99esmAnhR5cNrg+15JLKS8IbSiM4YG1cAYS3ZDESRW9lo//gcVNH444+KN+gZPiiJQL+W
 Lsxh3W7Y4aEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="361982069"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
 by orsmga001.jf.intel.com with ESMTP; 20 Jul 2020 03:42:12 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 03:42:11 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX157.amr.corp.intel.com (10.22.240.23) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 03:42:11 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.51) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 20 Jul 2020 03:42:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lI7NEdSGZxxrKqrcOkTk8AbbgJTM1MQ+uT9eKG9amfanTNeBy70DCisHe6TjhDEMGEvZewN7rFcRc/Rw2NgxLmFVXq6eK/xaIK5OA6YeawvIk1oJE0r4q6V4nk5awByGOt0gYgFWEZO4n2izPNBUyLd1BYQA1hhmo0QagIajEIwBcns1Fyypil7yM4MI4p5wlzcrKY6r2E608QqZ7Jxf/5MLRuPi4qnWzGY82dtBrD5N07DNaHbvzud3xdboJ5FYOK2iicNdhffw9EINjhpdzEQ0oleZ7YoTY0eM+KyPDYO7IJUFvI9jsyvC4/gtOokO0XEqBXIF+T0Sy+jkPfIZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgep/nIFLMVVCL30fZZtFgHT3ZrDpiysMwp4VeqB2nI=;
 b=O4/PkpwWFrU8CR94NCNgB6VOTyd52BsCsBceU9WhP92EY7SZQV8qUWfdVH5HhQr6djOpY4Mut3xFdmZ1D/L9epSiIx/mGNyYhqN3HaldQKqA4jSub5B51x5UwUNZ2fzuVGb1xk6GMBjhxkC/nXxVv5CTnlX9iW0XpQWZz+hRRFElLvRrU0Y5YjIgVhG7svkd+JFe7OPfCuQ5fHEZ5JTsGS92x/9ORPacGVsR6ezjXpqwloJQcm0h+e0QuvNfobOjYyLxrc/jjZBt1W7hHjkOAyBxE0Y8kcdd1hVIZZ0MhJ3IAVi5OwEBYu9aT0fyNGV2VQjahrDGu0vhQu9bOIcsTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgep/nIFLMVVCL30fZZtFgHT3ZrDpiysMwp4VeqB2nI=;
 b=s1bpca1o31CzeWOFiEinnri5KY89FczJZx4p7W51ELMatu+lW9u8fL5e5NZDWSCT30DsCx9pOygDIM9C3koGWLpvInFf1v6XN+BBqK8tS1+sgnd6PuBf9iZ6AZPxijLmklDFaxdlRbINbDa5E5hYza1ksjSsSHTL7RPIif53Iv8=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1484.namprd11.prod.outlook.com (2603:10b6:4:8::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.25; Mon, 20 Jul 2020 10:42:09 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 10:42:09 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v5 11/15] vfio/type1: Allow invalidating first-level/stage
 IOMMU cache
Thread-Topic: [PATCH v5 11/15] vfio/type1: Allow invalidating
 first-level/stage IOMMU cache
Thread-Index: AQHWWD2mrOp6LhPXfUac/4tF0bwgdKkQQ32AgAAPvnA=
Date: Mon, 20 Jul 2020 10:42:08 +0000
Message-ID: <DM5PR11MB143567E84D2EAF51895AADC1C37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-12-git-send-email-yi.l.liu@intel.com>
 <3b44dc59-cd78-2b72-965e-2f169cacdade@redhat.com>
In-Reply-To: <3b44dc59-cd78-2b72-965e-2f169cacdade@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e4d8060-74d9-4c0c-2aad-08d82c998daa
x-ms-traffictypediagnostic: DM5PR11MB1484:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB14845BFBB1EAC83EEDD97659C37B0@DM5PR11MB1484.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RZZJ3aQ7RtG9oFIJrM+RlEtJTCDbyOHJshy5f2XqB9qB33niprnSuJ2VeDk3JZeLIOmWQsfgBdNDFHifA37ubylVElvI9evluKFXJumQWnVWBS3LIrPp1wxvchvK2r+Oolb3hyyYT0ZYyegK+bbfUTFPNiywxFGzFzcZF8orvnrKFebIfdMuzGI0O4eGpKklEaF198xa4bTae8L+SjPj0wLDwubiw/81uJnjwmfl6U1oXX+wi/7uk+t7sdi6nVsy2zaGDqmJFJyAeyR3Xtl8gvLDFC+q+uJmhWLFbB0EPd26k4h78Q4i2/eaPZtaal8Q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(5660300002)(316002)(83380400001)(110136005)(54906003)(186003)(4326008)(2906002)(52536014)(33656002)(64756008)(478600001)(7696005)(9686003)(66556008)(66946007)(66476007)(86362001)(76116006)(71200400001)(6506007)(7416002)(55016002)(8676002)(8936002)(66446008)(53546011)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Qu0RhmwUljwK52UE7kWzzxihtOb3RFTCAbJ7JO/hFhCv0U+ebUB7xh3EZMGpihOy3HjDxq7vjd+c4JrjO6pwW0hR4Zjr5/+W0j9C82BzTb3yrYozOUY6/gYgtd8MciVEsFBMAq82KKkfYGF4bU+mAH8rxFAxSUuMNqOyETRl0h/WveMOKnGBvBFyPVvDeILznauIw6oU36xxovGX2Pz6sF62FF+wJXpHMPkHxaLz/8/idkJq0/msFa5IrAEFALRDy7IfCINF35Byw9y9v6Ehv8EmqSAoNNQh0vtUDPb3pBuDxVYzE2V7ZS0398t63H5p2etADqeODMPcJDXumjR9fqIZkvNZoHOoI1u6qjjB9SSdWXDRK92urJnni4KKezy4NcT5Q0S+qmY8LOZvHOkabQ2/gQquhG4FG+uVzCqjUntQvJF6+En/NF3HPZkcMIWDhHCUOLfG+EWGcJuFeTdlZ2kdI5msyWxEGdviwRYj+NatR4jvKP/CH1wbo1Anvk6q
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4d8060-74d9-4c0c-2aad-08d82c998daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 10:42:09.0143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5IJf+tnSgSzP6mxIBQxGEjNuydb2gfa+RuWp8T/ORCOwiNfQNPFx9zLW1uLEuUcWuGO3oaxk3Fjg92ZsyVzqLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1484
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
> Sent: Monday, July 20, 2020 5:42 PM
> 
> Yi,
> 
> On 7/12/20 1:21 PM, Liu Yi L wrote:
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
> >  drivers/vfio/vfio_iommu_type1.c | 50
> +++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/vfio.h       |  3 +++
> >  2 files changed, 53 insertions(+)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index f0f21ff..960cc59 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -3073,6 +3073,53 @@ static long vfio_iommu_handle_pgtbl_op(struct
> vfio_iommu *iommu,
> >  	return ret;
> >  }
> >
> > +static int vfio_dev_cache_invalidate_fn(struct device *dev, void *data)
> > +{
> > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > +	unsigned long arg = *(unsigned long *)dc->data;
> > +
> > +	iommu_cache_invalidate(dc->domain, dev, (void __user *)arg);
> > +	return 0;
> > +}
> > +
> > +static long vfio_iommu_invalidate_cache(struct vfio_iommu *iommu,
> > +					unsigned long arg)
> > +{
> > +	struct domain_capsule dc = { .data = &arg };
> > +	struct vfio_group *group;
> > +	struct vfio_domain *domain;
> > +	int ret = 0;
> > +	struct iommu_nesting_info *info;
> > +
> > +	mutex_lock(&iommu->lock);
> > +	/*
> > +	 * Cache invalidation is required for any nesting IOMMU,
> > +	 * so no need to check system-wide PASID support.
> > +	 */
> > +	info = iommu->nesting_info;
> > +	if (!info || !(info->features & IOMMU_NESTING_FEAT_CACHE_INVLD)) {
> > +		ret = -EOPNOTSUPP;
> > +		goto out_unlock;
> > +	}
> > +
> > +	group = vfio_find_nesting_group(iommu);
> so I see you reuse it here. But still wondering if you cant't directly
> set dc.domain and dc.group group below using list_firt_entry?

I guess yes for current implementation. I also considered if I can
get a helper function to retrun a dc with group and domain field
initialized as it is common code used by both bind/unbind and cache_inv
path. perhaps something like get_domain_capsule_for_nesting()

> > +	if (!group) {
> > +		ret = -EINVAL;
> > +		goto out_unlock;
> > +	}
> > +
> > +	domain = list_first_entry(&iommu->domain_list,
> > +				  struct vfio_domain, next);
> > +	dc.group = group;
> > +	dc.domain = domain->domain;
> > +	iommu_group_for_each_dev(group->iommu_group, &dc,
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
> > @@ -3095,6 +3142,9 @@ static long vfio_iommu_type1_nesting_op(struct
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
> > index a8ad786..845a5800 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1225,6 +1225,8 @@ struct vfio_iommu_type1_pasid_request {
> >   * +-----------------+-----------------------------------------------+
> >   * | UNBIND_PGTBL    |      struct iommu_gpasid_bind_data            |
> >   * +-----------------+-----------------------------------------------+
> > + * | CACHE_INVLD     |      struct iommu_cache_invalidate_info       |
> > + * +-----------------+-----------------------------------------------+
> >   *
> >   * returns: 0 on success, -errno on failure.
> >   */
> > @@ -1237,6 +1239,7 @@ struct vfio_iommu_type1_nesting_op {
> >
> >  #define VFIO_IOMMU_NESTING_OP_BIND_PGTBL	(0)
> >  #define VFIO_IOMMU_NESTING_OP_UNBIND_PGTBL	(1)
> > +#define VFIO_IOMMU_NESTING_OP_CACHE_INVLD	(2)
> >
> >  #define VFIO_IOMMU_NESTING_OP		_IO(VFIO_TYPE, VFIO_BASE + 19)
> >
> >
> Otherwise looks good to me

thanks,

Regards,
Yi Liu

> Thanks
> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

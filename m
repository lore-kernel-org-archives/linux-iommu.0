Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE879C433E3
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 09:51:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9804D206DF
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 09:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="dbzeojpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9804D206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6121287DCC;
	Tue,  7 Jul 2020 09:51:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QwSbJkdRJ7Bm; Tue,  7 Jul 2020 09:51:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 61F2D87D36;
	Tue,  7 Jul 2020 09:51:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34000C07FF;
	Tue,  7 Jul 2020 09:51:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C682FC016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 09:51:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B791D253D1
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 09:51:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tPxNZk1YfVue for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 09:51:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id 103BA20382
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 09:51:27 +0000 (UTC)
IronPort-SDR: +Mk7nzyb0/7gNBH5gUx0x8qqyR7h2P6E1yrIjbT9LrL7Dtz6ezx8rvVTOzgjq1SVRFm3biQVx0
 ptvj5IerBpTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="212534544"
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; d="scan'208";a="212534544"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 02:51:27 -0700
IronPort-SDR: lAULlTMdItcI63iLzg/uz+/OYP4XIG9p8JeER/HvmkXtfAyHZWJj7tWYM8yrmTFCIokF8ofbPr
 1k33x/cqNyDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; d="scan'208";a="483459179"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2020 02:51:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Jul 2020 02:51:26 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 7 Jul 2020 02:51:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Jul 2020 02:51:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+XoWX/NH8q03oTlrj6n+zXdNg+LUAmq7RQIdMIfmxFC4/EULoE4iqCwjGvkTpklRyzN0rCiPRqKoDaf0Z3qiE1baI1rf8e3VyNAZDqAiB3CUYi0G5WjYBCY2jWcvK3pPUm/SzN0cnhUF97OS2ymQyIGxIpTnFXg3mewbf61JVSRFjiGy+h5+ls+Srb6EaJ9KeShK2uiTfwiDI1R4Sdv5VicN3K2NGPryxNYOtFeq2NgdP3MVHI4T4OV8P9FEHE1RjKeMyBVxBHPnf4GHmBlJ7RaQ1obcZo2FJgdKLve8CpOpB6VKPBnVMSt/6lYgpFOrY2DAdT4aNVN4Vp+exOuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1loW5B6TU7bH6QKKLY3K4zf62iQQH6xEPmjPC2X2Xg=;
 b=jlFBS8xyf642jpzkBvoGURQhyvQIK6fSNUeyRxtTIlk9N14gwaVhCDDPxLxtwaJPAtUQHEXIR/SPL43TweJa/FgNE7Djq1oNhSUqo3Fmx+6FSWppRk+4vrzJKf6ZaVriyoGG1+MsoTHQv4WiWgF9hvrO+N0s3k6yduwyXX6CkyTET/pwi4DEn0v39fsf6pDaCNsPSzb9HSuWZhgBQwDJ3GD5zCQuKx9pJsRR4wPwVuUHlzxBTcoGu+06l43rMcg67Lz8T774uKJcuh5NKKl2henmKBi/PTAaU5TzQl9on/6nwc8ujWARTqadenC8ZpQN7nWni4ER56bVtOIUFLWESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1loW5B6TU7bH6QKKLY3K4zf62iQQH6xEPmjPC2X2Xg=;
 b=dbzeojpZEKmlxfYf9roNvaDlmc/aN2RiDWw72bYuKVNNoMvteSCtCLOLVQ7Uj7z0Ec/5IcUvwjZ/vze7YTSlLKkQ11s8aDgK1bixWdprTad4MTav/0RT9+2l1Nryb6X8OOSKn1ANOuIXXgka8EHfdznuQi0AoOXMn83rzrS9CLg=
Received: from CY4PR11MB1432.namprd11.prod.outlook.com (2603:10b6:910:5::22)
 by CY4PR1101MB2197.namprd11.prod.outlook.com (2603:10b6:910:18::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Tue, 7 Jul
 2020 09:51:24 +0000
Received: from CY4PR11MB1432.namprd11.prod.outlook.com
 ([fe80::b46e:9dcb:b46b:884a]) by CY4PR11MB1432.namprd11.prod.outlook.com
 ([fe80::b46e:9dcb:b46b:884a%4]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 09:51:24 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v4 07/15] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Topic: [PATCH v4 07/15] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Index: AQHWUfUb2+oo31Iq0U2hNaNw7OjPqaj6rTsAgAE1TZA=
Date: Tue, 7 Jul 2020 09:51:23 +0000
Message-ID: <CY4PR11MB14327F25FF2C50778B29B9BEC3660@CY4PR11MB1432.namprd11.prod.outlook.com>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-8-git-send-email-yi.l.liu@intel.com>
 <f78eac88-eb8e-a6f5-d701-146587660f5f@redhat.com>
In-Reply-To: <f78eac88-eb8e-a6f5-d701-146587660f5f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ba371aa-821e-436c-9fa9-08d8225b4f64
x-ms-traffictypediagnostic: CY4PR1101MB2197:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB2197AA59FF0AF126A484C6D1C3660@CY4PR1101MB2197.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dNFBsxtSuRMpohVRb9Dxs3CYAtTI4Cm2//Z5cW/Aj5zTlN80rDe6dkQCOYu/0E1uWy6JoFn+oc469IrmnfXXrfAUVdkv4mxYZ+AU31RHF1YKiKCyouu0EIQ2k8OXiGox5gqgeqqN8HR+nO4CSX1lw9eQ8Y5Gmc8lDNU5vOMz6s3vyLzrBiMki7juvYxa7GZscw6O8k6eN+3AXLcBmuUkWxJf2JVQii4wbuTmbKbYNFNNvFizs6WTvPv+OZGo75OxHkpoUJ2+NmHB8dib1A752CnXThhjG9cVMa5pYsaQRW2BYMf97LEefp8nWNiw85wZkbwl895JDqFgii2YdpSIvA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR11MB1432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(8676002)(4326008)(86362001)(71200400001)(5660300002)(83380400001)(33656002)(9686003)(7696005)(7416002)(26005)(55016002)(2906002)(186003)(8936002)(6506007)(478600001)(53546011)(110136005)(66476007)(54906003)(66946007)(66446008)(76116006)(316002)(64756008)(66556008)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: pt6+WHdaNtwtKCaxiWaJArxTyXxL+ff9TRFELDyMz3wtren3xMwGT2pp1qbfAWMkmTHAIqf4LGvlJVtOuzzPVGaRCfTC/FQBCDYCpfKAXHRhHRSWBxolTijZBrJ3V13Yk5bLM9zR/kG9ZqTPn6RQEydmCbBBmnivw5nbZ+qRbhnLhTJqTZAeEhwX/fqb/tKVc5/J3hfrqhN6L/PABmf04CklDGOVVOzxgebXtnl9uNyfv2L0nK+ovwUJeJ5rcfxQye7oiMAQUy+N00i/I3rIWSHFRYRP/y2dsKAV2lJfHRM3B4ZsUxwk4QQCly7Bztx2ZH6M+q85mpI/IPht/Kje0LHlPV2zWFGIv/8TLvAv4vy0TezxIxnsVUUnzfK2vzeseCbK+AR+JYIZLlofDB7GmrguFZFjcAvM8mkhZ+XZ+vbmdP8Gdwp8XKUW6tihmMBM7H00zyBguHlVIxunMQ3NPgo+Nh/Y4QYMJWJrdBLZTf+qvR22wQ37T0JqCC2KfXoG
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba371aa-821e-436c-9fa9-08d8225b4f64
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 09:51:24.0438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7K4WxQ6Bt7Bvq9aRi8obawjf1tCwC3/sudvs2wy24ifQBckG0+bMYMbnFTmeTTt7YwIpkl2zXs0gmhbAWVCA3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2197
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
> Sent: Monday, July 6, 2020 11:18 PM
> 
> Hi Yi,
> 
> On 7/4/20 1:26 PM, Liu Yi L wrote:
> > This patch allows user space to request PASID allocation/free, e.g. when
> > serving the request from the guest.
> >
> > PASIDs that are not freed by userspace are automatically freed when the
> > IOASID set is destroyed when process exits.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > v3 -> v4:
> > *) address comments from v3, except the below comment against the range
> >    of PASID_FREE request. needs more help on it.
> >     "> +if (req.range.min > req.range.max)
> >
> >     Is it exploitable that a user can spin the kernel for a long time in
> >     the case of a free by calling this with [0, MAX_UINT] regardless of
> >     their actual allocations?"
> >
> > v1 -> v2:
> > *) move the vfio_mm related code to be a seprate module
> > *) use a single structure for alloc/free, could support a range of PASIDs
> > *) fetch vfio_mm at group_attach time instead of at iommu driver open time
> > ---
> >  drivers/vfio/Kconfig            |  1 +
> >  drivers/vfio/vfio_iommu_type1.c | 84
> +++++++++++++++++++++++++++++++++++++++++
> >  drivers/vfio/vfio_pasid.c       | 10 +++++
> >  include/linux/vfio.h            |  6 +++
> >  include/uapi/linux/vfio.h       | 36 ++++++++++++++++++
> >  5 files changed, 137 insertions(+)
> >
> > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> > index 3d8a108..95d90c6 100644
> > --- a/drivers/vfio/Kconfig
> > +++ b/drivers/vfio/Kconfig
> > @@ -2,6 +2,7 @@
> >  config VFIO_IOMMU_TYPE1
> >  	tristate
> >  	depends on VFIO
> > +	select VFIO_PASID if (X86)
> >  	default n
> >
> >  config VFIO_IOMMU_SPAPR_TCE
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index 80623b8..29726ca 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -76,6 +76,7 @@ struct vfio_iommu {
> >  	bool				dirty_page_tracking;
> >  	bool				pinned_page_dirty_scope;
> >  	struct iommu_nesting_info	*nesting_info;
> > +	struct vfio_mm			*vmm;
> >  };
> >
> >  struct vfio_domain {
> > @@ -1937,6 +1938,11 @@ static void vfio_iommu_iova_insert_copy(struct
> vfio_iommu *iommu,
> >
> >  static void vfio_iommu_release_nesting_info(struct vfio_iommu *iommu)
> >  {
> > +	if (iommu->vmm) {
> > +		vfio_mm_put(iommu->vmm);
> > +		iommu->vmm = NULL;
> > +	}
> > +
> >  	kfree(iommu->nesting_info);
> >  	iommu->nesting_info = NULL;
> >  }
> > @@ -2075,6 +2081,25 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
> >  			goto out_detach;
> >  		}
> >  		iommu->nesting_info = info;
> > +
> > +		if (info->features & IOMMU_NESTING_FEAT_SYSWIDE_PASID) {
> > +			struct vfio_mm *vmm;
> > +			int sid;
> > +
> > +			vmm = vfio_mm_get_from_task(current);
> > +			if (IS_ERR(vmm)) {
> > +				ret = PTR_ERR(vmm);
> > +				goto out_detach;
> > +			}
> > +			iommu->vmm = vmm;
> > +
> > +			sid = vfio_mm_ioasid_sid(vmm);
> > +			ret = iommu_domain_set_attr(domain->domain,
> > +						    DOMAIN_ATTR_IOASID_SID,
> > +						    &sid);
> > +			if (ret)
> > +				goto out_detach;
> > +		}
> >  	}
> >
> >  	/* Get aperture info */
> > @@ -2860,6 +2885,63 @@ static int vfio_iommu_type1_dirty_pages(struct
> vfio_iommu *iommu,
> >  	return -EINVAL;
> >  }
> >
> > +static int vfio_iommu_type1_pasid_alloc(struct vfio_iommu *iommu,
> > +					unsigned int min,
> > +					unsigned int max)
> > +{
> > +	int ret = -EOPNOTSUPP;
> > +
> > +	mutex_lock(&iommu->lock);
> > +	if (iommu->vmm)
> > +		ret = vfio_pasid_alloc(iommu->vmm, min, max);
> > +	mutex_unlock(&iommu->lock);
> > +	return ret;
> > +}
> > +
> > +static int vfio_iommu_type1_pasid_free(struct vfio_iommu *iommu,
> > +					unsigned int min,
> > +					unsigned int max)
> > +{
> > +	int ret = -EOPNOTSUPP;
> > +
> > +	mutex_lock(&iommu->lock);
> > +	if (iommu->vmm) {
> > +		vfio_pasid_free_range(iommu->vmm, min, max);
> > +		ret = 0;
> > +	}
> > +	mutex_unlock(&iommu->lock);
> > +	return ret;
> > +}
> > +
> > +static int vfio_iommu_type1_pasid_request(struct vfio_iommu *iommu,
> > +					  unsigned long arg)
> > +{
> > +	struct vfio_iommu_type1_pasid_request req;
> > +	unsigned long minsz;
> > +
> > +	minsz = offsetofend(struct vfio_iommu_type1_pasid_request, range);
> > +
> > +	if (copy_from_user(&req, (void __user *)arg, minsz))
> > +		return -EFAULT;
> > +
> > +	if (req.argsz < minsz || (req.flags & ~VFIO_PASID_REQUEST_MASK))
> > +		return -EINVAL;
> > +
> > +	if (req.range.min > req.range.max)
> > +		return -EINVAL;
> > +
> > +	switch (req.flags & VFIO_PASID_REQUEST_MASK) {
> > +	case VFIO_IOMMU_FLAG_ALLOC_PASID:
> > +		return vfio_iommu_type1_pasid_alloc(iommu,
> > +					req.range.min, req.range.max);
> > +	case VFIO_IOMMU_FLAG_FREE_PASID:
> > +		return vfio_iommu_type1_pasid_free(iommu,
> > +					req.range.min, req.range.max);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  				   unsigned int cmd, unsigned long arg)
> >  {
> > @@ -2876,6 +2958,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  		return vfio_iommu_type1_unmap_dma(iommu, arg);
> >  	case VFIO_IOMMU_DIRTY_PAGES:
> >  		return vfio_iommu_type1_dirty_pages(iommu, arg);
> > +	case VFIO_IOMMU_PASID_REQUEST:
> > +		return vfio_iommu_type1_pasid_request(iommu, arg);
> >  	}
> >
> >  	return -ENOTTY;
> > diff --git a/drivers/vfio/vfio_pasid.c b/drivers/vfio/vfio_pasid.c
> > index c46b870..6f907db 100644
> > --- a/drivers/vfio/vfio_pasid.c
> > +++ b/drivers/vfio/vfio_pasid.c
> > @@ -53,6 +53,7 @@ void vfio_mm_put(struct vfio_mm *vmm)
> >  {
> >  	kref_put_mutex(&vmm->kref, vfio_mm_release,
> &vfio_pasid.vfio_mm_lock);
> >  }
> > +EXPORT_SYMBOL_GPL(vfio_mm_put);
> I think this should be belong to [5/15]

yeah, the implementation is in [5/15], but the user is in this patch, so export
it in this patch.

> >
> >  static void vfio_mm_get(struct vfio_mm *vmm)
> >  {
> > @@ -104,6 +105,13 @@ struct vfio_mm *vfio_mm_get_from_task(struct
> task_struct *task)
> >  	mmput(mm);
> >  	return vmm;
> >  }
> > +EXPORT_SYMBOL_GPL(vfio_mm_get_from_task);
> same

the same with above.

> > +
> > +int vfio_mm_ioasid_sid(struct vfio_mm *vmm)
> extern?
> same

why need extern? as it's used in this patch, so add it in this patch.

> > +{
> > +	return vmm->ioasid_sid;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_mm_ioasid_sid);
> >
> >  int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> >  {
> > @@ -113,6 +121,7 @@ int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> >
> >  	return (pasid == INVALID_IOASID) ? -ENOSPC : pasid;
> >  }
> > +EXPORT_SYMBOL_GPL(vfio_pasid_alloc);
> same

same as above reason. :-)

> >
> >  void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  			    ioasid_t min, ioasid_t max)
> > @@ -130,6 +139,7 @@ void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  	for (; pasid <= max; pasid++)
> >  		ioasid_free(pasid);
> >  }
> > +EXPORT_SYMBOL_GPL(vfio_pasid_free_range);
> same

same as above.

> >
> >  static int __init vfio_pasid_init(void)
> >  {
> > diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> > index 9da6468..35c922a 100644
> > --- a/include/linux/vfio.h
> > +++ b/include/linux/vfio.h
> > @@ -101,6 +101,7 @@ struct vfio_mm;
> >  #if IS_ENABLED(CONFIG_VFIO_PASID)
> >  extern struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task);
> >  extern void vfio_mm_put(struct vfio_mm *vmm);
> > +int vfio_mm_ioasid_sid(struct vfio_mm *vmm);
> >  extern int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max);
> >  extern void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  					ioasid_t min, ioasid_t max);
> > @@ -114,6 +115,11 @@ static inline void vfio_mm_put(struct vfio_mm *vmm)
> >  {
> >  }
> >
> > +static inline int vfio_mm_ioasid_sid(struct vfio_mm *vmm)
> > +{
> > +	return -ENOTTY;
> > +}
> > +
> >  static inline int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> >  {
> >  	return -ENOTTY;
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 3e3de9c..fe267b8e 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1169,6 +1169,42 @@ struct vfio_iommu_type1_dirty_bitmap_get {
> >
> >  #define VFIO_IOMMU_DIRTY_PAGES             _IO(VFIO_TYPE, VFIO_BASE + 17)
> >
> > +/**
> > + * VFIO_IOMMU_PASID_REQUEST - _IOWR(VFIO_TYPE, VFIO_BASE + 18,
> > + *				struct vfio_iommu_type1_pasid_request)
> > + *
> > + * PASID (Processor Address Space ID) is a PCIe concept for tagging
> > + * address spaces in DMA requests. When system-wide PASID allocation
> > + * is required by underlying iommu driver (e.g. Intel VT-d), this
> > + * provides an interface for userspace to request pasid alloc/free
> > + * for its assigned devices. Userspace should check the availability
> > + * of this API through VFIO_IOMMU_GET_INFO.
> name the capability?

yep. will add it.

Regards,
Yi Liu

> > + *
> > + * @flags=VFIO_IOMMU_FLAG_ALLOC_PASID, allocate a single PASID within
> @range.
> > + * @flags=VFIO_IOMMU_FLAG_FREE_PASID, free the PASIDs within @range.
> > + * @range is [min, max], which means both @min and @max are inclusive.
> > + * ALLOC_PASID and FREE_PASID are mutually exclusive.
> > + *
> > + * returns: allocated PASID value on success, -errno on failure for
> > + *	     ALLOC_PASID;
> > + *	     0 for FREE_PASID operation;
> > + */
> > +struct vfio_iommu_type1_pasid_request {
> > +	__u32	argsz;
> > +#define VFIO_IOMMU_FLAG_ALLOC_PASID	(1 << 0)
> > +#define VFIO_IOMMU_FLAG_FREE_PASID	(1 << 1)
> > +	__u32	flags;> +	struct {
> > +		__u32	min;
> > +		__u32	max;
> > +	} range;
> > +};
> > +
> > +#define VFIO_PASID_REQUEST_MASK	(VFIO_IOMMU_FLAG_ALLOC_PASID | \
> > +					 VFIO_IOMMU_FLAG_FREE_PASID)
> > +
> > +#define VFIO_IOMMU_PASID_REQUEST	_IO(VFIO_TYPE, VFIO_BASE + 18)
> > +
> >  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
> >
> >  /*
> >
> 
> Thanks
> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A9AC433E1
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 09:37:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E01A2065F
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 09:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="QfI53lbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E01A2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4121620366;
	Tue,  7 Jul 2020 09:37:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vhDAN+o8cJ6U; Tue,  7 Jul 2020 09:37:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 81E8620115;
	Tue,  7 Jul 2020 09:37:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7991AC07FF;
	Tue,  7 Jul 2020 09:37:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EE8AC016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 09:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3D430899A9
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 09:37:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YG7GlXItOLXZ for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 09:37:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6E828899A6
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 09:37:42 +0000 (UTC)
IronPort-SDR: vhoNLUHmHkd8S1AECjGeHTqq3PXgkSKyjBO5VPdvwXgNGLbeHvjjeqbuB+q8K38+HrHNmR+Mgg
 mona3G98vqFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="149073212"
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; d="scan'208";a="149073212"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 02:37:41 -0700
IronPort-SDR: ZYv/SNMrbfKvY0Jn6oyI/pCcD69B27/gRJ3Sq7lCPe7vg/MG74SxjrBf1bmnhx//p7SPXe0Ctu
 IJIAyt4SO+ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; d="scan'208";a="305600781"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga004.fm.intel.com with ESMTP; 07 Jul 2020 02:37:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Jul 2020 02:37:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Jul 2020 02:37:37 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 7 Jul 2020 02:37:37 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.52) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 7 Jul 2020 02:37:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQjp9B1uLn2TwGmFdwFKVo0PxLTbC8U7pUStl8JWJ2ZJAuVKcUwIsS1bVA3WNCzG4Z0ImTM9GsR8GTbXEwBbGq82GlZDO8oVgrEQ4/yGLSWIggg/DLFilYwGcHnbG2r7LANyzyjdfv8jTdJHY0T00fegwWJ8oDsvRYjwIWP2h86OZRfi+8y1nwOD7kBeUSZGuvXE0quliPA3HmFCJeZB2cqwd+93HR1PqcbmDjtcT6sDQpamkJkIwXZs/twJW8a2MoEMRF/BCqVUru8OVjYNESCK3J69CB+h87cc2OVo2T4ZQL8HsoQ1bgVDYzEyp/ONMPFY9JAac3BSqHOXfMDzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuzY5aLq0Lr8Z+ioYE3u2gdJvrPWPFeDdM3zAI6rmZg=;
 b=N0QhmhL2bkxWfJR1W9znpvY0aU5wUHwusESOeI36uNaPCZ/nozEqLvCWHCn8mm3AAE/XCfIfoy8HukNvLqsm322uasCpxVwKrgp46AdvtVMOZpBB8FQAVOBuu1TvflH2BxFvhjt0ckWqBagSDg7Pcs5JbDg5DLOWWgKYpbiA8dDq4rhc8n+UwADhUPiZ2sYG4csRQeC3hsnXLR1VPAvjwh41ow7KMsXq6rV1WkltFS1qExDy8i/jwaAR59NRdrR47/lhKqq8pfFz2i2fEyTBcdAyaEf0Emrx0WG93zrOWRiKQbHBiL80a7hCqfG6wDSpv2QOwBtmEmoan7yeNroSHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuzY5aLq0Lr8Z+ioYE3u2gdJvrPWPFeDdM3zAI6rmZg=;
 b=QfI53lbETs/tNT5UXN73E4jvJAsgIE6ABSR1aaLCABr+PF9utAJ6zGmKbK0D8M8DOBzqzpuamLsoPhlGuNevjqsHVfEnAtSftSWyKrTdhChCndjl+ejPsdLoD2DZyNCNXY9yaEIvCKHKkKTlHF7Y+Wgfvv1S2KHJE2b/YnwCHnI=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3068.namprd11.prod.outlook.com (2603:10b6:5:6b::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21; Tue, 7 Jul 2020 09:37:35 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 09:37:35 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v4 06/15] iommu/vt-d: Support setting ioasid set to domain
Thread-Topic: [PATCH v4 06/15] iommu/vt-d: Support setting ioasid set to domain
Thread-Index: AQHWUfUYO2lBnvRuAEuteXmbkCY+m6j6picAgAE6LVA=
Date: Tue, 7 Jul 2020 09:37:35 +0000
Message-ID: <DM5PR11MB14353BF4E197D947CFF720BAC3660@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-7-git-send-email-yi.l.liu@intel.com>
 <d47367ab-f986-4c09-2578-3e364aa57835@redhat.com>
In-Reply-To: <d47367ab-f986-4c09-2578-3e364aa57835@redhat.com>
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
x-ms-office365-filtering-correlation-id: 468e22d8-df4d-4e63-8e78-08d822596155
x-ms-traffictypediagnostic: DM6PR11MB3068:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB30689DFBB6AE506BD2A43C1DC3660@DM6PR11MB3068.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p8U9fEye7imZOx6PTYTfuPvne5qYYIROdw/qeDApf31d+LK2c5+J04CnnolZ5mbPQU9PwyFf7SvG6nVeEjsQHhGdqGauD0m0omWw4817YCqQI85gWfLCq61TVcKyCJUjVLfbDXd6+KSJ2ITA3RLW1Moer3eCKVB/LfAT+uyp+PM3tQpSi0xwOSuKKllhbB1mktLuwk+wM/x74AadfCXtycQh3NXKB7Jz6ff2LrH/6YG+o+hPRXzZv+hiDmZ8bJbvUZCYVbYj4MIgwU7Xzhix9OMNctFCqVDjfOSgv7nc+BC8dMr0WEyl+udEQz6YOpO3T35MHeDfpsDK5aFXWFK2Bw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(66446008)(5660300002)(186003)(66476007)(110136005)(55016002)(9686003)(316002)(33656002)(54906003)(8936002)(66556008)(86362001)(64756008)(26005)(2906002)(66946007)(71200400001)(76116006)(8676002)(52536014)(478600001)(53546011)(83380400001)(6506007)(7696005)(4326008)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: VKIcd/NGO665LBP+b1Js6ucdJ8nMsCUzWpZ+Qhb2GMWZGT3Ssr70G8DNABjrhYQw93yj+ihNVwGvFDYVPQGWm8icMkuG95OdcV/2EETpipOaQvP4HsrAw4aGYKkVe/jf/gM/cbqXQTYwNN/B+cVH/hA2hqYk7p4dDrtpSpOnpt4GkOL67SqZ9FVdDaYzVvrE20GWafhzZU2n5fgPbbAZwSapV+bHOe2I0+fFnp3Ob1o4yBOQEVCKNdao8NG7EEqLHNNSSlHlychrbuOgKV579ZyKeMcKxRWyWYrpe7kuz7rfG0QA4cdLpmCMy3I1s7AK1bR6xfQy5asXIhDbJZy9J04N6jDv/B7U/99UJC9Tqdct3UAy/P0d1zV/4SKgE7FY8Bgc6qYJy0gVKZpoMJMK48gC+zJzZMr3V0s24bmQCGEz8O/As6oM0VZCVsg4GIQUTjZFbE/clUfSgdQIk3P7zYO+lY+XkT+tWOzXgdGMmeJlJgDl/7ZhQ0RaEQ9PXOyd
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468e22d8-df4d-4e63-8e78-08d822596155
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 09:37:35.1126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llJ3NBjt1MHNy8N7o7HXK0QYnfcFQDa44v54Dqcu0At56kFoob9BPTY3UcRwTh4I741Ze7Fc/mvVrFjt4Fwvww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3068
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
> Sent: Monday, July 6, 2020 10:52 PM
> 
> Hi Yi,
> 
> On 7/4/20 1:26 PM, Liu Yi L wrote:
> > From IOMMU p.o.v., PASIDs allocated and managed by external components
> > (e.g. VFIO) will be passed in for gpasid_bind/unbind operation. IOMMU
> > needs some knowledge to check the PASID ownership, hence add an interface
> > for those components to tell the PASID owner.
> >
> > In latest kernel design, PASID ownership is managed by IOASID set where
> > the PASID is allocated from. This patch adds support for setting ioasid
> > set ID to the domains used for nesting/vSVA. Subsequent SVA operations
> > on the PASID will be checked against its IOASID set for proper ownership.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/iommu.c | 16 ++++++++++++++++
> >  include/linux/intel-iommu.h |  4 ++++
> >  include/linux/iommu.h       |  1 +
> >  3 files changed, 21 insertions(+)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 62ebe01..89d708d 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -1793,6 +1793,7 @@ static struct dmar_domain *alloc_domain(int flags)
> >  	if (first_level_by_default())
> >  		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
> >  	domain->has_iotlb_device = false;
> > +	domain->ioasid_sid = INVALID_IOASID_SET;
> >  	INIT_LIST_HEAD(&domain->devices);
> >
> >  	return domain;
> > @@ -6039,6 +6040,21 @@ intel_iommu_domain_set_attr(struct iommu_domain
> *domain,
> >  		}
> >  		spin_unlock_irqrestore(&device_domain_lock, flags);
> >  		break;
> > +	case DOMAIN_ATTR_IOASID_SID:
> no need to take the device_domain_lock?

oh, yes. thanks for spotting it.

> > +		if (!(dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE)) {
> > +			ret = -ENODEV;
> > +			break;
> > +		}
> > +		if ((dmar_domain->ioasid_sid != INVALID_IOASID_SET) &&
> > +		    (dmar_domain->ioasid_sid != (*(int *) data))) {
> storing *(int *) data) in a local variable would increase the
> readability of the code I think.

will do it. :-)

Regards,
Yi Liu

> > +			pr_warn_ratelimited("multi ioasid_set (%d:%d) setting",
> > +					    dmar_domain->ioasid_sid,
> > +					    (*(int *) data));
> > +			ret = -EBUSY;
> > +			break;
> > +		}
> > +		dmar_domain->ioasid_sid = *(int *) data;
> > +		break;
> >  	default:
> >  		ret = -EINVAL;
> >  		break;
> > diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> > index 3f23c26..0d0ab32 100644
> > --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -549,6 +549,10 @@ struct dmar_domain {
> >  					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
> >  	u64		max_addr;	/* maximum mapped address */
> >
> > +	int		ioasid_sid;	/*
> > +					 * the ioasid set which tracks all
> > +					 * PASIDs used by the domain.
> > +					 */
> >  	int		default_pasid;	/*
> >  					 * The default pasid used for non-SVM
> >  					 * traffic on mediated devices.
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 2567c33..21d32be 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -124,6 +124,7 @@ enum iommu_attr {
> >  	DOMAIN_ATTR_FSL_PAMUV1,
> >  	DOMAIN_ATTR_NESTING,	/* two stages of translation */
> >  	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
> > +	DOMAIN_ATTR_IOASID_SID,
> >  	DOMAIN_ATTR_MAX,
> >  };
> >
> >
> Thanks
> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

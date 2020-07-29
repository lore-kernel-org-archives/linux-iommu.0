Return-Path: <SRS0=LOQj=BI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4722AC433E1
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 23:49:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9132074B
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 23:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="dr9mtEcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9132074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D33EF88292;
	Wed, 29 Jul 2020 23:49:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DKbSG4TAHQNc; Wed, 29 Jul 2020 23:49:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 47D868816F;
	Wed, 29 Jul 2020 23:49:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27234C0050;
	Wed, 29 Jul 2020 23:49:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FA42C004D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 23:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4A3E08816F
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 23:49:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L9aSXfpCibno for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jul 2020 23:49:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9527B880F9
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 23:49:30 +0000 (UTC)
IronPort-SDR: oXDgC7g+MRpLj+nPlnXAfKuxGPYhXshDY/OShMmq2j+8cwJdj72r65AxrU2OV2opeMR6v3GWbR
 TsK94jRJ60XQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="148979286"
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; d="scan'208";a="148979286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 16:49:30 -0700
IronPort-SDR: cJN+EpEeZf6xpMog5KiEddhdCqM6Wf9v5/VE5ymk6GT2AnFjWFGU1k+sKJKq0pm5oxfEb9vvvi
 VPntrYy+kfQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; d="scan'208";a="364997503"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga001.jf.intel.com with ESMTP; 29 Jul 2020 16:49:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 29 Jul 2020 16:49:28 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 29 Jul 2020 16:49:28 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.50) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 29 Jul 2020 16:49:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbZuiqWoLVlcDWCnql8UcKh4XTDr9NBmquKOugE/81XB99z9GaqyEo/4xM+tdwna4MqP1qj3hjKZQBygoTI0uUwGQCeHkzMkU3QOBMMnyY1BwNxbAT86lo67bFFbZsch+nD2h8pchDFpGL8+rRg65xQ3KtoDoqB9ysIeLzKoR/Cdq57aH0qTb4d32zMnpviNkFw1dycIJqRet5G8XOQK3ORjPvv456LvZiOIQf/YAYfb6jNbo+T3OpNRXY1+EH+fNC2cvVKyPbWr0A1JYAB1bmgiuc4SHuN+e2AqKbpqMfwV1E6HM6Sor8A5rmS2dH21pJ4rEhU/gRJUktTwkgNrSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PK7/KpLzdW+2/tPM96HKKp0bFLdDyBix5v336s6YSE=;
 b=jMmhI0ISh5SqwYCfOIFZzHoQVuy8u7913vdzANODlEvi7thP2YefWdnelnCSq5L4RVZAcq165eYWEQHKnlApSw5LLxpXsYoVXBo7tr7zJucj8MPq0rO6Gz5V5Kh5j5W8C9rB2jc+U1kc0dJ1rYKV30IHjL0dVAbE1I2B/a5mjFN32djFbNZTrOXRpH+p0Iua2NtKP1qBPV+x7vmTOZao5nOFybtAu3v/VlvdfI/vryE5ROadqUoi8Vi+OFheKQjOr3KDFvn2+8FIYOWnEd6xwWYHjUWhD7kLlThAGQyrRZMG0n5z5ZBNcLmrnizwJh6MhUvYFY7cn7HxRh3SSTZMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PK7/KpLzdW+2/tPM96HKKp0bFLdDyBix5v336s6YSE=;
 b=dr9mtEcjRAagwVIBUPdJraTcc8uwa3nMfXep92JGYsZgLWXUqQWFIInktZKYONzxsut3LiuCpkV+3nn1wtn6zz+P+9Qf3tsbE22UwRk/AjTmrPrVi2es7gotyFaTwX7gjHW4CzucyH4KNVh5xMwXS2EAMBQ6sCnzguWrvlbVLSo=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB2048.namprd11.prod.outlook.com (2603:10b6:300:27::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Wed, 29 Jul
 2020 23:49:20 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 23:49:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, Lu Baolu
 <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v3 3/4] iommu: Add iommu_aux_get_domain_for_dev()
Thread-Topic: [PATCH v3 3/4] iommu: Add iommu_aux_get_domain_for_dev()
Thread-Index: AQHWWaRTwLJlmIhIiUK0CZQgQ7WVGKkfGWqAgAA12uA=
Date: Wed, 29 Jul 2020 23:49:20 +0000
Message-ID: <MWHPR11MB1645736D9ED91A95D1D4519A8C700@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200714055703.5510-1-baolu.lu@linux.intel.com>
 <20200714055703.5510-4-baolu.lu@linux.intel.com>
 <20200729142507.182cd18a@x1.home>
In-Reply-To: <20200729142507.182cd18a@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fe8b92e-f994-4fed-af2e-08d8341a03c0
x-ms-traffictypediagnostic: MWHPR11MB2048:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB204899D45639D3912D1415D78C700@MWHPR11MB2048.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CwMY34YJTUNPck3YhDobpyFsmMHtA0DbI1+JwYlrMFq7/8OEt/L3+XrqvgaiPaxI6AJHz7q7HeNGGEvzDYO86c41FIfhke/KV0Z0+6rHMLrJOga7FgQ/AwBUKvWR7EB/Me+XIOWAjBg+JDFYGd9oP/VSShlsw4nqkaD/5tVyx5CfSox5MydaMtYO1JpxyEFK7/LvOItVoUQDgh37GgsSsq+Gp/nl+BPMB//cKraD6jhIIeRHmvAWytWkpE9ZWaOpkQnrk8e6UopqF4QlyEm1HpWEA33Yp8f4QVD9A84fhp5UCFUHisIlI4CdxNv3EnDE/JyXfIZX7uIi5TxlsXCfSA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(66476007)(6506007)(66446008)(66556008)(8676002)(64756008)(5660300002)(52536014)(66946007)(76116006)(7696005)(2906002)(110136005)(33656002)(9686003)(8936002)(316002)(478600001)(55016002)(86362001)(26005)(71200400001)(4326008)(54906003)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 1B7RTU2pT1+d25U00Jx1PqSoJ+3WSIRJTjzhspCS9fBw4eTUwg9xjAakfXyKedT3Ixpiisz1fq/6L9hvFUObcUzx6kaejpyjQkSxpBuODYvedWvLWEjYcwi0a6ybXo2ewVoLZZXH/WED4vX17l6XaotdM7jLF39Qrcq+5vx+8mMhLdfB5dlZt120I6XIRsje/X0fZerwLIUnxPLfz7T7uNDltMbrcEgR+XQMw415AsbXWXj9KCsO/AdZKzWDEvpncdL38u9xJn8R0tTMHxS9fYe9iP8isf/+Xn2p2eF3VJHkXo2KiFqMgZC6V7WZoGSd0oRwLTIvtKDnkoeGQaWbJYA6KPjdCd9VSGTHCoFIcDLhrNU7mAzZL0Yr0+t5Fi+nYsC9pd8539SUia/0yCpX5KWc2mtgclr2TCGZadEBONZpr3SZ+m4Nju6kUa2poLgCI5aauoEsaQLcNbR8NV59KTtKJZtaSWhfZ5wv8iUNzbMO7y4uaEyO86hM+BfEtuY4
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe8b92e-f994-4fed-af2e-08d8341a03c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 23:49:20.8679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1M+7a5MHIcYeFdB/4MouDzxXqw+OlaYhCfHfB4sLp69TPOSHUBeuPU9RsefR513MRv39kn/a6e6bFcm+QQdsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2048
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

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Thursday, July 30, 2020 4:25 AM
> 
> On Tue, 14 Jul 2020 13:57:02 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
> > The device driver needs an API to get its aux-domain. A typical usage
> > scenario is:
> >
> >         unsigned long pasid;
> >         struct iommu_domain *domain;
> >         struct device *dev = mdev_dev(mdev);
> >         struct device *iommu_device = vfio_mdev_get_iommu_device(dev);
> >
> >         domain = iommu_aux_get_domain_for_dev(dev);
> >         if (!domain)
> >                 return -ENODEV;
> >
> >         pasid = iommu_aux_get_pasid(domain, iommu_device);
> >         if (pasid <= 0)
> >                 return -EINVAL;
> >
> >          /* Program the device context */
> >          ....
> >
> > This adds an API for such use case.
> >
> > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >  drivers/iommu/iommu.c | 18 ++++++++++++++++++
> >  include/linux/iommu.h |  7 +++++++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index cad5a19ebf22..434bf42b6b9b 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2817,6 +2817,24 @@ void iommu_aux_detach_group(struct
> iommu_domain *domain,
> >  }
> >  EXPORT_SYMBOL_GPL(iommu_aux_detach_group);
> >
> > +struct iommu_domain *iommu_aux_get_domain_for_dev(struct device
> *dev)
> > +{
> > +	struct iommu_domain *domain = NULL;
> > +	struct iommu_group *group;
> > +
> > +	group = iommu_group_get(dev);
> > +	if (!group)
> > +		return NULL;
> > +
> > +	if (group->aux_domain_attached)
> > +		domain = group->domain;
> 
> Why wouldn't the aux domain flag be on the domain itself rather than
> the group?  Then if we wanted sanity checking in patch 1/ we'd only
> need to test the flag on the object we're provided.
> 
> If we had such a flag, we could create an iommu_domain_is_aux()
> function and then simply use iommu_get_domain_for_dev() and test that
> it's an aux domain in the example use case.  It seems like that would

IOMMU layer manages domains per parent device. Here given a
dev (of mdev), we need a way to find its associated domain under its
parent device. And we cannot simply use iommu_get_domain_for_dev
on the parent device of the mdev, as it will give us the primary domain
of parent device. 

Thanks
Kevin

> resolve the jump from a domain to an aux-domain just as well as adding
> this separate iommu_aux_get_domain_for_dev() interface.  The is_aux
> test might also be useful in other cases too.  Thanks,
> 
> Alex
> 
> > +
> > +	iommu_group_put(group);
> > +
> > +	return domain;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_aux_get_domain_for_dev);
> > +
> >  /**
> >   * iommu_sva_bind_device() - Bind a process address space to a device
> >   * @dev: the device
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 9506551139ab..cda6cef7579e 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -639,6 +639,7 @@ int iommu_aux_attach_group(struct
> iommu_domain *domain,
> >  			   struct iommu_group *group, struct device *dev);
> >  void iommu_aux_detach_group(struct iommu_domain *domain,
> >  			   struct iommu_group *group, struct device *dev);
> > +struct iommu_domain *iommu_aux_get_domain_for_dev(struct device
> *dev);
> >
> >  struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> >  					struct mm_struct *mm,
> > @@ -1040,6 +1041,12 @@ iommu_aux_detach_group(struct
> iommu_domain *domain,
> >  {
> >  }
> >
> > +static inline struct iommu_domain *
> > +iommu_aux_get_domain_for_dev(struct device *dev)
> > +{
> > +	return NULL;
> > +}
> > +
> >  static inline struct iommu_sva *
> >  iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void
> *drvdata)
> >  {

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

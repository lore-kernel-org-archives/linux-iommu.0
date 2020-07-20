Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385B8C433E1
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 09:06:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED442080D
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 09:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="C2SYJyUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED442080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A13A12152C;
	Mon, 20 Jul 2020 09:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CN7em7g0-yDb; Mon, 20 Jul 2020 09:06:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 582B4204B0;
	Mon, 20 Jul 2020 09:06:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 351AFC0894;
	Mon, 20 Jul 2020 09:06:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0D3CC016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 09:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E343286E59
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 09:06:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v4ziYKameoSK for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 09:06:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BA50286DC1
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 09:06:48 +0000 (UTC)
IronPort-SDR: bJTAVm5JCOBG6/zrJkRlO3+4u75Gae986ZDjuw2n0QqP1/SXYfuo5Iggr4I/+7eN72l+DgaZUa
 sM6BGl41RL7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="137358434"
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="137358434"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2020 02:06:48 -0700
IronPort-SDR: e4E+b+2+mpO1Vuzu5qo0xyBI/wNpx3cDTkN5hB4n7AoNS8MIkLujmog84UrbS5N8+grr9JDuYV
 EoFyhwKob4rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="301213268"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga002.jf.intel.com with ESMTP; 20 Jul 2020 02:06:47 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 02:06:47 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 02:06:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 20 Jul 2020 02:06:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3fWtnLKzx7aqkFP6l2qk7Elv5tJ9cx+nVQxye4y88HTUnNyLHk78hPBkrn+RUkF4NyOQy1mc1pu8EJNaaBp0BcRa3HbFC/tEIUUxyV0zuG4QF+u3xsHglGbnN1NsLoAc8jtJXBqdCjWwHIeuLdPVO2BrObGTT5sOjcij0V8NgWcNUJi22+mcAvY+N3CIFr6aP3uBObx4N7lhkq+p46vgRzXyxSFzhu+OIuvd4i3/HF4EZQHUFmnXCA9O7/uys/zaTFU+Y6q86D3D1dYjj7AR0uGGLghtW7uprZw5Sur52RTlcVFS+PcsKi8uPtSICcqheYLdbonQ0I0pjhLSRF62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VG5BSyW10Gpyzyqk/OpSNZMZ834H833RpY7ODfXUB1Y=;
 b=InkRoPexDv2q2v5zuc5cDJ0lsBrRxJyV0+sppVR5X7zKP9nXo77K4SSEbfNXq+OgCDjJtx3gNsm88FmLBMcWotSEvptO0lGFek6kyRMrnBc2fQn+DrkmM9tSlD5gGSTvOsy8wMc1j2PeQDqRyYLQZBmoLeVGvxONh0l5aeCjs6aZxo/F2s+fXiUZhQSrbCQ6JBFfDXkOjUrk/ok3azABUjtICK8VyxFdJtdyx17jgp7tyuDoBZWvbIGC/YXRWuev//yubCftYMHyUi/erM/LQw2/oLLdys/DQERQ1TRTFNbWUNFQjZWVGAWl7BTqJnJ2R0VkDEdEX3VvHoQN8f2JLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VG5BSyW10Gpyzyqk/OpSNZMZ834H833RpY7ODfXUB1Y=;
 b=C2SYJyUNMLGCZ/bXx5gxQJSUNXgFHmNhP5jdyNdsMVXFgTTFYfgAtK3trIm/YEI1dAnzYL8+EHzkoN2d1v3/9C0Qkm4/rOf9QoG1gpDQhSFW/ysLyNp8zWbmtjY5XNXqFR9cEVMl+pCxcgSV2TNJ1SW5lecn8uX86El0KbkVkqI=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1673.namprd11.prod.outlook.com (2603:10b6:4:c::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.25; Mon, 20 Jul 2020 09:06:43 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 09:06:43 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v5 08/15] iommu: Pass domain to sva_unbind_gpasid()
Thread-Topic: [PATCH v5 08/15] iommu: Pass domain to sva_unbind_gpasid()
Thread-Index: AQHWWD2wpTv8jD9LM0Op13LFQ21toKkPFKAAgAEiVAA=
Date: Mon, 20 Jul 2020 09:06:43 +0000
Message-ID: <DM5PR11MB14351DE64D6D3184AF9282ECC37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-9-git-send-email-yi.l.liu@intel.com>
 <27ac7880-bdd3-2891-139e-b4a7cd18420b@redhat.com>
In-Reply-To: <27ac7880-bdd3-2891-139e-b4a7cd18420b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 811a8136-ae6c-4248-9737-08d82c8c3912
x-ms-traffictypediagnostic: DM5PR11MB1673:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB16735363CEF09107B4FDF51AC37B0@DM5PR11MB1673.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nrvWsD+3ippcGZenjpGWQnpKM6xST5kFTw+JUPYuTVoJI0dUEkz8xoFdvubaNmZ7Vz4/I5siL7E7QvMGuqKIIODdm3X2wnbK4OVr4cCWo+l1MatOpIthb2RbuhtNH8DuXJVzS9KF8aLlqbfYKocBjWxzdHJYhz8RuFRYDgqg41aUGr2BfESNffhaxs/2l/gx1vPgsecco0Zxvn+26mqtWPFoL5C26FDcvrj5oIMqLjJjEG1f8JgxjlUtYOwiAi/jVXeVJLyvquHsn3tf7N5JOI2gkfewMY8X5gfdH768hQkq+fhy1hFBpB6ZHQOZKNPSqtlRlmyU2wS7F0Ji+e9QLqIDejmN6mM85reh0GZVLwKlzm2MvnIlOWwgZsTpP2qufTn+cXpzysWyXa9PEOeeKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(86362001)(52536014)(8936002)(186003)(966005)(2906002)(6506007)(5660300002)(53546011)(7696005)(478600001)(8676002)(26005)(66946007)(7416002)(83380400001)(66476007)(316002)(110136005)(76116006)(71200400001)(9686003)(55016002)(54906003)(33656002)(66446008)(64756008)(4326008)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: KKeQPYpZIkHINnGdZ2XIVpIUhAjwQhoIJwmZ+mftD1Yoqvjx15pI5u1ZBhcPc8IK3TuOMIOywr9HhPmurD7Ed+9V9UjOrP/OCtnlSVxdtoiG7ZmlN4ZcB0hGJIwRBI6DE/taovNkx4BRgRifd9bSVFJPduxKUQ9UW4h0zQTozVWgiLkF1GUKhD1o9MIaUToFFWoilWIZwSiDPr3mkWDtW5D/b2E0t+N4K732IhLJBaUreGbFWBNnDiDULXXjJQpa4WrsZgJ4k4uI7RNF0mBvtH6yXh1SWOeZiZHOAo5tohKwavI9LFABZ4+doTznIfhtWFrxy69NKPw6jXEgTfzRqCmC7jzU+6asjB340j5gLe75Jv3vQs3nx8rJatwRqNLTpLcjziAEMMYpgD7Xkrn33lFNtBDkDPjNpq9LJuIZu8hDpzmgw2bqwm92KB1xVC7AffL9U7X7PR8yyv4Wipgbly/c3n/0JPlbtteBjLKVkeViYomRA7F/rtHU+r+zKE1V
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811a8136-ae6c-4248-9737-08d82c8c3912
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 09:06:43.5569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fanzy1K7MFl7+sC6e5irp8kmuAGclqF6UnxfQyb4eAkgN+KRT+qZ/G33+TcWx8nVk4C7gby/cRL2InwN6tFXlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1673
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
> Sent: Sunday, July 19, 2020 11:38 PM
> 
> Yi,
> 
> On 7/12/20 1:21 PM, Liu Yi L wrote:
> > From: Yi Sun <yi.y.sun@intel.com>
> >
> > Current interface is good enough for SVA virtualization on an assigned
> > physical PCI device, but when it comes to mediated devices, a physical
> > device may attached with multiple aux-domains. Also, for guest unbind,
> > the PASID to be unbind should be allocated to the VM. This check
> > requires to know the ioasid_set which is associated with the domain.
> >
> > So this interface needs to pass in domain info. Then the iommu driver
> > is able to know which domain will be used for the 2nd stage
> > translation of the nesting mode and also be able to do PASID ownership
> > check. This patch passes @domain per the above reason.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Yi Sun <yi.y.sun@intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> > v2 -> v3:
> > *) pass in domain info only
> > *) use ioasid_t for pasid instead of int type
> >
> > v1 -> v2:
> > *) added in v2.
> > ---
> >  drivers/iommu/intel/svm.c   | 3 ++-
> >  drivers/iommu/iommu.c       | 2 +-
> >  include/linux/intel-iommu.h | 3 ++-
> >  include/linux/iommu.h       | 3 ++-
> >  4 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > index b9a9c55..d2c0e1a 100644
> > --- a/drivers/iommu/intel/svm.c
> > +++ b/drivers/iommu/intel/svm.c
> > @@ -432,7 +432,8 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain,
> struct device *dev,
> >  	return ret;
> >  }
> >
> > -int intel_svm_unbind_gpasid(struct device *dev, int pasid)
> > +int intel_svm_unbind_gpasid(struct iommu_domain *domain,
> > +			    struct device *dev, ioasid_t pasid)
> int -> ioasid_t proto change is not described in the commit message,

oops, yes. btw. I noticed there is another thread which is going to use
u32 for pasid. perhaps I need to drop such change.

https://lore.kernel.org/linux-iommu/1594684087-61184-2-git-send-email-fenghua.yu@intel.com/#Z30drivers:iommu:iommu.c

> >  {
> >  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> >  	struct intel_svm_dev *sdev;
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c index
> > 7910249..d3e554c 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2151,7 +2151,7 @@ int __iommu_sva_unbind_gpasid(struct iommu_domain
> *domain, struct device *dev,
> >  	if (unlikely(!domain->ops->sva_unbind_gpasid))
> >  		return -ENODEV;
> >
> > -	return domain->ops->sva_unbind_gpasid(dev, data->hpasid);
> > +	return domain->ops->sva_unbind_gpasid(domain, dev, data->hpasid);
> >  }
> >  EXPORT_SYMBOL_GPL(__iommu_sva_unbind_gpasid);
> >
> > diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> > index 0d0ab32..18f292e 100644
> > --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -738,7 +738,8 @@ extern int intel_svm_enable_prq(struct intel_iommu
> > *iommu);  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
> > int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
> >  			  struct iommu_gpasid_bind_data *data); -int
> > intel_svm_unbind_gpasid(struct device *dev, int pasid);
> > +int intel_svm_unbind_gpasid(struct iommu_domain *domain,
> > +			    struct device *dev, ioasid_t pasid);
> >  struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
> >  				 void *drvdata);
> >  void intel_svm_unbind(struct iommu_sva *handle); diff --git
> > a/include/linux/iommu.h b/include/linux/iommu.h index e84a1d5..ca5edd8
> > 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -303,7 +303,8 @@ struct iommu_ops {
> >  	int (*sva_bind_gpasid)(struct iommu_domain *domain,
> >  			struct device *dev, struct iommu_gpasid_bind_data *data);
> >
> > -	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
> > +	int (*sva_unbind_gpasid)(struct iommu_domain *domain,
> > +				 struct device *dev, ioasid_t pasid);
> >
> >  	int (*def_domain_type)(struct device *dev);
> >
> >
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>

thanks.

Regards,
Yi Liu

> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

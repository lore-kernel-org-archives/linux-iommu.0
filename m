Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78114C433E5
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 08:11:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5C62080D
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 08:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="GxybFqIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5C62080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DAAFF86DC1;
	Mon, 20 Jul 2020 08:11:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CsQaJWqWmeGu; Mon, 20 Jul 2020 08:11:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 02D4486DAE;
	Mon, 20 Jul 2020 08:11:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6317C0894;
	Mon, 20 Jul 2020 08:11:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25A56C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 08:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 102E585D56
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 08:11:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cBvlzM_jAkHz for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 08:11:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D34D5852D5
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 08:11:19 +0000 (UTC)
IronPort-SDR: lzRy/lXLvGJXy6Z6bUg7rHTs+9iQ4xZHK9QNxrtvPCiRAkzZMlHOwrvwpDac7Dvg0OqtpMmAp2
 AnX+6Qdkqnbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="137353431"
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="137353431"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2020 01:11:19 -0700
IronPort-SDR: vnKXm9khiMs7MhJ2rdjCzm8Wl+56hSq02lvfimykMqqzHDS4mnyqh3rbQEiYBkIpCoNka9c6tH
 cfB4axUiwoTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="309755929"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga004.fm.intel.com with ESMTP; 20 Jul 2020 01:11:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 01:11:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Jul 2020 01:11:18 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 Jul 2020 01:11:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 20 Jul 2020 01:11:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlipglF7BSI4oFcNXXIQrvHOAxS+Vnhhh3A0dBYq4tVOB7pgBOqYnRgVPHP6a1HE/ybFogMCsFR5uYC/Xgq5fGqxQDyaUvWIn9t8CaL56bYqvTJjXwi8cMTbUcXME5DvHjzn84VUFkA46zOgFKHm4RvNfd/HuN6YvCz0YnU2xnU1yf71nVR7OWRZW1uZ/KIgc70cCRJWBmtzestUwWsOucC50Pm6+JSwQuvgoFpZJKqAY+3hsHqFeh4w31PZh4jVzOXbbALDQ4g7QSP4Pl/pKGGIm3vb9grf/aTy+pcZdvw4Z2i4+YFiye6utVT+6YyK+g9BJ3mMe5YRanpUB+2qdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6DQTSlyuOtS/imL7bsMquuG6/91BpIwmal0aGI6xkk=;
 b=OO1WKPhxb34yji1RhvDLQDKLzfUw0K67ZbJUMw9mVkHWi1ZmApjET+QRT520V/tSQo+TaUn2FpsPhDkCyb9W7hfz/spxPTSzQlkCoZSFFF9zcgEdzixPqUp6sS71WMcxy+JTEtpQVPAIvRkNQ0mHzjTx1ffHBC2XL6Ti4iSFjHbPxPCSSTvGbeXbLdyLHIQa0seR5L7lUecZGReh9ImBsPsWz9iwt/RR3HOaW4P3rz1e3HDPMhBqaqE1atwUmnWxlSkpBIjYDYZVxzdvrrq0BW1+smyEuuO2rHgUE/DUIT8A8bjx36QC7maKyPoIqgR/g/mAy5jeqFDJb8qYkVVvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6DQTSlyuOtS/imL7bsMquuG6/91BpIwmal0aGI6xkk=;
 b=GxybFqIMozFZgMOIFe/OCX68c+PMjyWsSxBk1sSzOwCWMmASBUZIYO5M6Ru6imohndzZeYIi2U1bjvoAiLtOLkqAOpi57hx+gtwFMMJ/c6wsw33Xy7/ZIi5S9c6uQkfNLl86v4MA6c8hGmCbtFXDHvXLX9Wa6ZoM7guq58OVRCA=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3289.namprd11.prod.outlook.com (2603:10b6:5:5f::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.25; Mon, 20 Jul 2020 08:11:13 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 08:11:13 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v5 06/15] iommu/vt-d: Support setting ioasid set to domain
Thread-Topic: [PATCH v5 06/15] iommu/vt-d: Support setting ioasid set to domain
Thread-Index: AQHWWD2wmreG48S8TkuGZch2ZJs3a6kPFLoAgAEUy6A=
Date: Mon, 20 Jul 2020 08:11:13 +0000
Message-ID: <DM5PR11MB1435D32E0973DA6C0AF562F7C37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-7-git-send-email-yi.l.liu@intel.com>
 <e2c45f9d-af78-5da9-c7c2-061b476b6b0a@redhat.com>
In-Reply-To: <e2c45f9d-af78-5da9-c7c2-061b476b6b0a@redhat.com>
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
x-ms-office365-filtering-correlation-id: de800d2b-31ba-43ec-1f7c-08d82c8477ed
x-ms-traffictypediagnostic: DM6PR11MB3289:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB328979D245BC93354D822EB2C37B0@DM6PR11MB3289.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4bfhkvH7Wf6ut9eeHFkmLHy0lHGedwWwZTjToH+35h0xKnZJBh2DajS72wrcZ+itrF0vs4jvu10/sXoAY99xZDm7wOudX1Z7BfBuWMxPO9Zjcs4DhtnwdoBJy8yETsxgqTzEjvvqAynkZknU7hQkTnfjg15yZfeFx1sfq64IvHBFwY6sCv+1ymOdzHaPeSW+YpSHFaf5NDOqeptErit7r5aFppL7E9mWKr6ylJLqGjVywEk3x/Eox03LFiAc5O+lE/loIcqprF+UY16YSaDW+/yZ1ufEOYrAIddCc9eS+9TZclw5QAByTxIsk0Wkqj/VZQAMXPmjAKAZUwBtvKfUUw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(26005)(53546011)(5660300002)(7696005)(7416002)(186003)(33656002)(52536014)(6506007)(110136005)(2906002)(71200400001)(8936002)(83380400001)(4326008)(9686003)(66476007)(54906003)(8676002)(478600001)(66946007)(66446008)(86362001)(66556008)(55016002)(316002)(76116006)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: kJEcepUtHyAuw27udNn6mpzGdyn/z7o6NuaRmYfhHWJJoZMhpwB6pQz5JjWX7/T9caUsUN4xPOTX5cZ6awCiuRn0gCaQj0jXK9h8uWNWKM+21al9PFtdeZvpS2W4alF22BRWsZrQ+oFgQ244NPGIOO+yKYPIZ7Ktxto7kaxzbOCVJjfWIjr/D4eMHSugDV82TVR6Uwu7iOCs1bhjIQi4DXVREOr06nCvm/5M6n8SH24kqelilxY50ETrpNuyloIndENe4USEPNIwQd1pp1i29p82isjMsYhjOIfqFRAPSuMdA7xiWQqnEmvloP5T2o03YUkqTSzrrpPYyxd+5yS1rGnPcKTlRLwgOKjSi5Np6p+40EQWxM4jhcOYPp8u5mRHecPRhfiFJt3/aHqWnZ2EKgV7ueHICRxanT89CH1HqeJX+EaqzV7ApD5yCurKpWiGO1i5Z+OKh97iq/wSTvoPDDPFK95R7zug4uq8AS9c6GRDhV69tv0t98wLX2hi6pS7
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de800d2b-31ba-43ec-1f7c-08d82c8477ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 08:11:13.1229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mPN4wezv9CtDjR3CgTc90COglhNdkveaAXUD2aRZBelRyjCG0D1p6K8gewO+GNczvcqlCjavYi0k6iW2cSqn6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3289
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
> > From IOMMU p.o.v., PASIDs allocated and managed by external components
> > (e.g. VFIO) will be passed in for gpasid_bind/unbind operation. IOMMU
> > needs some knowledge to check the PASID ownership, hence add an
> > interface for those components to tell the PASID owner.
> >
> > In latest kernel design, PASID ownership is managed by IOASID set
> > where the PASID is allocated from. This patch adds support for setting
> > ioasid set ID to the domains used for nesting/vSVA. Subsequent SVA
> > operations on the PASID will be checked against its IOASID set for proper
> ownership.
> Subsequent SVA operations will check the PASID against its IOASID set for proper
> ownership.

got it.

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
> > v4 -> v5:
> > *) address comments from Eric Auger.
> > ---
> >  drivers/iommu/intel/iommu.c | 22 ++++++++++++++++++++++
> > include/linux/intel-iommu.h |  4 ++++
> >  include/linux/iommu.h       |  1 +
> >  3 files changed, 27 insertions(+)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 72ae6a2..4d54198 100644
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
> > @@ -6039,6 +6040,27 @@ intel_iommu_domain_set_attr(struct iommu_domain
> *domain,
> >  		}
> >  		spin_unlock_irqrestore(&device_domain_lock, flags);
> >  		break;
> > +	case DOMAIN_ATTR_IOASID_SID:
> > +	{
> > +		int sid = *(int *)data;
> > +
> > +		if (!(dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE)) {
> > +			ret = -ENODEV;
> > +			break;
> > +		}
> > +		spin_lock_irqsave(&device_domain_lock, flags);
> I think the lock should be taken before the DOMAIN_FLAG_NESTING_MODE check.
> Otherwise, the flags can be theretically changed inbetween the check and the test
> below?

I see. will correct it.

Thanks,
Yi Liu

> Thanks
> 
> Eric
> > +		if (dmar_domain->ioasid_sid != INVALID_IOASID_SET &&
> > +		    dmar_domain->ioasid_sid != sid) {
> > +			pr_warn_ratelimited("multi ioasid_set (%d:%d) setting",
> > +					    dmar_domain->ioasid_sid, sid);
> > +			ret = -EBUSY;
> > +			spin_unlock_irqrestore(&device_domain_lock, flags);
> > +			break;
> > +		}
> > +		dmar_domain->ioasid_sid = sid;
> > +		spin_unlock_irqrestore(&device_domain_lock, flags);
> > +		break;
> > +	}
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
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> > 7ca9d48..e84a1d5 100644
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

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

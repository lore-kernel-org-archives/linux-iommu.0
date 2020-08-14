Return-Path: <SRS0=h1an=BY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCDCC433DF
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 07:16:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7868F20708
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 07:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="WgEJ5Fzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7868F20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 185F4888AE;
	Fri, 14 Aug 2020 07:16:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oCHbWf1kMGee; Fri, 14 Aug 2020 07:15:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3542787DC6;
	Fri, 14 Aug 2020 07:15:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 195FBC07FF;
	Fri, 14 Aug 2020 07:15:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86C54C004D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 07:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6E07788761
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 07:15:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H-JSZMO82mdk for <iommu@lists.linux-foundation.org>;
 Fri, 14 Aug 2020 07:15:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4448188754
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 07:15:55 +0000 (UTC)
IronPort-SDR: +u0ZvJ/D1JmohVprPw04NJbe5AOCxsUrwr6H4NeycFCgr9M7GRvMbXdwRl7g5peV9XB2a9DScl
 hY+t/MltMLCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="215894065"
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; d="scan'208";a="215894065"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 00:15:54 -0700
IronPort-SDR: +4Y2nrRTaZpr65Yo6Ac7T7f2L261i1GoYbs9JRk7Nd2byBC0EfgNLbMCdAoP+2tvnpJDu/2YHG
 HE30SxLQg9zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; d="scan'208";a="333340802"
Received: from fmsmsx603-2.cps.intel.com (HELO fmsmsx603.amr.corp.intel.com)
 ([10.18.84.213])
 by FMSMGA003.fm.intel.com with ESMTP; 14 Aug 2020 00:15:54 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Aug 2020 00:15:53 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 14 Aug 2020 00:15:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 14 Aug 2020 00:15:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XS8NfjD6MNk/m9x1ZLOzmCMOY6tCaOi9ZK/Ygk4rQVjTQPs2T7lO0t/bAuKDr2O31ttqy8oJhNnjaotBLAsnq54fsMR6qhri22AWRZjySG/lrrQ4F8g1Q7gL4c+38/EjINx+OEaHecuKR3x+f/LJhpD24msMiC406TcYvBBiawEld7kTFGG+Z0jX8paG2l8EUTGt1lihVWbl2SrEe3Xp2EqEA9xOLgo1NgcDhC8V/g31OfJhDu7Sn000GvidZb0dvBgcOGu2nY4DhZtAJcta7VIlb8g/1PqLCaChtU4erVhQdnIxflJHkBhUvKLyX/phGwOd3/DwVlDQdUydql4WTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcFX9i7AW0gEbnMaL94WWsDqvdZazrWpgIHaui36jgU=;
 b=TwIR0tjgmuXbfTTs1yjcixMEx0ei0dyVkLPJMXJEhDuBFmWnMEm+QWX5qecf97KkpqFxWJF+M4V0bx0BGmNQEmTI51nH8eC+RvPS700zD0i4UhzBkffWAWspgoScYHjKim6UTfwMEHi5/DPz9UKkjnCJ3Nv8uCnsTXYmuSUrQrLFBgfNwb+STAVhMA5a4WZw3FHgk/UBwqV31xycfkVqWG7mhlM9T0/+IYLC50QzyE0W8UFNI3bqtdQlGcuFNMBvb8dmdOXcZhUvLOBPbKNVcnCGq8dsUPk5qpIzcRyUD6VY/j5Pp9QrTnLn9nTIepAhJN/k7kkpCYi8un/hnq1VGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcFX9i7AW0gEbnMaL94WWsDqvdZazrWpgIHaui36jgU=;
 b=WgEJ5Fzru3nBmewV6dKs65bGbAh50v5ZDfqBLwPW5c9GsA36r6Std2vLN1+mDlIXsgPGc0vfeRX4GoiCQSePvD7HLAbN+f7qnr9jswyCX5I/5mdYStybymzRRsz1BUatnDxai3fmQ+HJ3inqU8DpyqJOhg4D9q2UdXUYgl3CQ0M=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3196.namprd11.prod.outlook.com (2603:10b6:5:5b::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.15; Fri, 14 Aug 2020 07:15:51 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3261.026; Fri, 14 Aug
 2020 07:15:51 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v6 02/15] iommu: Report domain nesting info
Thread-Topic: [PATCH v6 02/15] iommu: Report domain nesting info
Thread-Index: AQHWZKdKwF+TL587NUuMMt8yXXLPy6k2F/OAgAExUEA=
Date: Fri, 14 Aug 2020 07:15:51 +0000
Message-ID: <DM5PR11MB1435CC4503506228790CCB39C3400@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-3-git-send-email-yi.l.liu@intel.com>
 <5c911565-c76a-c361-845e-56a91744d504@redhat.com>
In-Reply-To: <5c911565-c76a-c361-845e-56a91744d504@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [117.169.228.168]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e29fa9f-f6b2-4ab2-d947-08d84021e083
x-ms-traffictypediagnostic: DM6PR11MB3196:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB31967D04381322AAC61E02E9C3400@DM6PR11MB3196.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QWLMTvJAh3py6UZ+EY7Ss+5m75dqbnO9LhD+gbNZ51ZWozPDGokG/MWIa/HBTRim49Y6rWSPabj0BOLyRYiuSaKximoNyw+T9JIIIS+5btlibPHB70MD5B9QqhTUt9GUla+gYUtQ/ePBE2dTYxbQg02Y2MBZ5tlfv77wpkE3TGxU6cGLuOSsMHE/0RoE5SQ321JDvVlmWknRrWI+hpLYJd9BFW1jksYLnLj63f8IH2SxHei48JNDLCRs0F+TX4g3m3Fpt3HyP3kJ+Y9QV70OStWJBTPxH7oQyWsNwQfjLE2DqWgg4ZPsj0RxAhsjA9QGl8jqO+DQt8I9mlN9/OAKyw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(110136005)(55016002)(66446008)(54906003)(9686003)(2906002)(71200400001)(7416002)(316002)(186003)(26005)(478600001)(52536014)(8676002)(6506007)(33656002)(76116006)(8936002)(86362001)(53546011)(7696005)(64756008)(66476007)(66556008)(66946007)(83380400001)(4326008)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: L6/LgBuJgPtNRMLsDa4UKcOKm6+AzpjFxHozLUMWVegz1Ie9BbwEcX3Yz1tTIE8bRYOzQi3fwShohauH5QKiZcgaCTTNAn0gAClvPKm+s2mpgJaRw8m1+4aWYJKWOMZIC4ofhqsD9kfyaqQ5omm3vOXrHd5/YcFWE2dHq8zROT+CQD+u2b+doDdgQ7edTeXcpmuwoPp44LHk+fAlh6/aQWO5IZlQhFuPdtIyn6OPmLX2IcnsCNnfWgWWsd5f4FdOP8PECdLXFq/2tRMGjPELA8/g002ZyK+9kI79A9bCScjda55nF/uiVHVawU4J7mTDEMQeRppk8PTbL6qFoqQrFxtaAgnl3r+VH6va8paFZjZm/LrHEdjQuuhKo/cfWjFD4IosplWP5WDH7x7AoZdtE0oLYyEBXKDHok5T+08rRH1oONp6pdDgIgI0O0phWArpxuCIfWSXB6RgR5Y8yO9AVecCqWFnDPT4ZAUlkG4eEmAoHLz0dd5UZJFYZi482rQ+1ynyMRWWqmwp8dWll4INj93CqdmEkQfdN1IeCHZ7mAtZsQ2vL49sp75jNCcJjpxMy1d9gZ3Sm4INo4jTo6Ru589pW6iw8j97N9c905laVkoqOkfTKp18xJju2miL7DTDEkxhh65B4EhqRjD9XJQVaw==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e29fa9f-f6b2-4ab2-d947-08d84021e083
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 07:15:51.6611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJkhkokH2RpqtSMmZfb93hj7F+e3iWWpWfPrM1mdVr/VCzo9SEZFlu1zYc740K5TwYYxopVhyqyjqd8AIbnXoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3196
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
> Sent: Thursday, August 13, 2020 8:53 PM
> 
> Yi,
> On 7/28/20 8:27 AM, Liu Yi L wrote:
> > IOMMUs that support nesting translation needs report the capability info
> s/needs/need to
> > to userspace. It gives information about requirements the userspace needs
> > to implement plus other features characterizing the physical implementation.
> >
> > This patch reports nesting info by DOMAIN_ATTR_NESTING. Caller can get
> > nesting info after setting DOMAIN_ATTR_NESTING. For VFIO, it is after
> > selecting VFIO_TYPE1_NESTING_IOMMU.
> This is not what this patch does ;-) It introduces a new IOMMU UAPI
> struct that gives information about the nesting capabilities and
> features. This struct is supposed to be returned by
> iommu_domain_get_attr() with DOMAIN_ATTR_NESTING attribute parameter,
> one a domain whose type has been set to DOMAIN_ATTR_NESTING.

got it. let me apply your suggestion. thanks. :-)

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
> > v5 -> v6:
> > *) rephrase the feature notes per comments from Eric Auger.
> > *) rename @size of struct iommu_nesting_info to @argsz.
> >
> > v4 -> v5:
> > *) address comments from Eric Auger.
> >
> > v3 -> v4:
> > *) split the SMMU driver changes to be a separate patch
> > *) move the @addr_width and @pasid_bits from vendor specific
> >    part to generic part.
> > *) tweak the description for the @features field of struct
> >    iommu_nesting_info.
> > *) add description on the @data[] field of struct iommu_nesting_info
> >
> > v2 -> v3:
> > *) remvoe cap/ecap_mask in iommu_nesting_info.
> > *) reuse DOMAIN_ATTR_NESTING to get nesting info.
> > *) return an empty iommu_nesting_info for SMMU drivers per Jean'
> >    suggestion.
> > ---
> >  include/uapi/linux/iommu.h | 74
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 7c8e075..5e4745a 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -332,4 +332,78 @@ struct iommu_gpasid_bind_data {
> >  	} vendor;
> >  };
> >
> > +/*
> > + * struct iommu_nesting_info - Information for nesting-capable IOMMU.
> > + *			       userspace should check it before using
> > + *			       nesting capability.
> > + *
> > + * @argsz:	size of the whole structure.
> > + * @flags:	currently reserved for future extension. must set to 0.
> > + * @format:	PASID table entry format, the same definition as struct
> > + *		iommu_gpasid_bind_data @format.
> > + * @features:	supported nesting features.
> > + * @addr_width:	The output addr width of first level/stage translation
> > + * @pasid_bits:	Maximum supported PASID bits, 0 represents no PASID
> > + *		support.
> > + * @data:	vendor specific cap info. data[] structure type can be deduced
> > + *		from @format field.
> > + *
> > + *
> +===============+===================================================
> ===+
> > + * | feature       |  Notes                                               |
> > + *
> +===============+===================================================
> ===+
> > + * | SYSWIDE_PASID |  IOMMU vendor driver sets it to mandate userspace    |
> > + * |               |  to allocate PASID from kernel. All PASID allocation |
> > + * |               |  free must be mediated through the TBD API.          |
> s/TBD/IOMMU

got it.

> > + * +---------------+------------------------------------------------------+
> > + * | BIND_PGTBL    |  IOMMU vendor driver sets it to mandate userspace    |
> > + * |               |  bind the first level/stage page table to associated |
> s/bind/to bind

got it.

> > + * |               |  PASID (either the one specified in bind request or  |
> > + * |               |  the default PASID of iommu domain), through IOMMU   |
> > + * |               |  UAPI.                                               |
> > + * +---------------+------------------------------------------------------+
> > + * | CACHE_INVLD   |  IOMMU vendor driver sets it to mandate userspace    |
> 
> > + * |               |  explicitly invalidate the IOMMU cache through IOMMU |
> to explicitly

I see.

> > + * |               |  U
> > API according to vendor-specific requirement when  |
> > + * |               |  changing the 1st level/stage page table.            |
> > + * +---------------+------------------------------------------------------+
> > + *
> > + * @data[] types defined for @format:
> > + *
> +================================+==================================
> ===+
> > + * | @format                        | @data[]                             |
> > + *
> +================================+==================================
> ===+
> > + * | IOMMU_PASID_FORMAT_INTEL_VTD   | struct iommu_nesting_info_vtd       |
> > + * +--------------------------------+-------------------------------------+
> > + *
> > + */
> > +struct iommu_nesting_info {
> > +	__u32	argsz;
> > +	__u32	flags;
> > +	__u32	format;
> > +#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
> > +#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
> > +#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
> > +	__u32	features;
> > +	__u16	addr_width;
> > +	__u16	pasid_bits;
> > +	__u32	padding;
> > +	__u8	data[];
> > +};
> As opposed to other IOMMU UAPI structs there is no union member at the
> end.

nice catch. do you think it would be better to adding a union and
put the struct iommu_nesting_info_vtd in it?

> Also this struct is not documented in [PATCH v7 1/7] docs: IOMMU
> user API. Shouldn't we align.
> You may also consider to move this patch in Jacob's series for
> consistency, thoughts?

this was talked one time between Jacob and me. It was put in this
series as the major user of nesting_info is in this series. e.g.
vfio checks the SYSWIDE_PASID. but I'm open to merge it with Jacob's
series if it would make the merge easier.

Thanks,
Yi Liu

> > +
> > +/*
> > + * struct iommu_nesting_info_vtd - Intel VT-d specific nesting info.
> > + *
> > + * @flags:	VT-d specific flags. Currently reserved for future
> > + *		extension. must be set to 0.
> > + * @cap_reg:	Describe basic capabilities as defined in VT-d capability
> > + *		register.
> > + * @ecap_reg:	Describe the extended capabilities as defined in VT-d
> > + *		extended capability register.
> > + */
> > +struct iommu_nesting_info_vtd {
> > +	__u32	flags;
> > +	__u32	padding;
> > +	__u64	cap_reg;
> > +	__u64	ecap_reg;
> > +};
> > +
> >  #endif /* _UAPI_IOMMU_H */
> >
> 
> Thanks
> 
> Eric
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

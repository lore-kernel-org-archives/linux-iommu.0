Return-Path: <SRS0=8EFN=74=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8E4C433E0
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 06:04:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52D620663
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 06:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="hXabXD+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52D620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 83A93871FB;
	Mon, 15 Jun 2020 06:04:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nyV4WflRxKjJ; Mon, 15 Jun 2020 06:04:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BCBA1871ED;
	Mon, 15 Jun 2020 06:04:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82051C0890;
	Mon, 15 Jun 2020 06:04:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BA88C016E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 06:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8A748871F3
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 06:04:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AnupZVrg-iKC for <iommu@lists.linux-foundation.org>;
 Mon, 15 Jun 2020 06:04:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 841E9871ED
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 06:04:41 +0000 (UTC)
IronPort-SDR: bmZY2Wp6nZUeySWpMf3or3TFWJPHjNtHndrkslAq08OBQQ9PGFGqo4yIVikMBLvg0ux6YA29RI
 TLtj0a4TcAXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2020 23:04:41 -0700
IronPort-SDR: b1yFa1mgp+a2cCYnmKCdN5OQB8T2wgo4zTcXT5kaktXOXCxDbPbJ4J7ngCKzOLzia/9FRnZWkV
 9YZ3W/WKpPaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; d="scan'208";a="298403810"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
 by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2020 23:04:39 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 14 Jun 2020 23:04:38 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 14 Jun 2020 23:04:37 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 14 Jun 2020 23:04:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 14 Jun 2020 23:04:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nrrqb+6FaUqp2OAQKymyka3oluyWTEn/VS/zde86258dOzfO8KrzpbcQLBr82v5Foc7HTo06aOFVnV/5COgU842xEtrsjgbV/MVwKlMq1sMtJs91lWxZNsJ2yv0xkxRmWkEVdX3Et+yD/uWlDqj5TeObBP5wm0AwfUT2H29X2T52rqws5JCUXztDzjvySaPZhqe4qrxpMV+2+nDOQbVV5aLeRkzItnV8oSBc58oYCpDbPro3GafIcvGFDIQ+GG49pVh2h2C4tYEhnQ96LhGvOcYywNQ3Z8eaN4mXT8/oT7gbo+lcIU3ch+ZywgmTJNnPd6Ue4y1nr9HthKm98ZaZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwyu3v1JzHUfvrBiNW3tbWaOqiFaFxQDpE+alqdz4TU=;
 b=l4HjtCRew+NyKjX+TkyFu5VMgn6Y0vAywEe+rf7usS8E8jSABbgZNH4TB0U5Iwko/39FtKLt8LdKjUufeQ69EX3BCyQjbctb1vfH+C0bzVGO07RxHbx5NBr7DOdCf7jC3RN6PIK+3F9WW3z3Qwc4eabJBcLLtfFAO9JC840kWP0S7cFUZRKYsZtfSvLoVV7tI9yXXbRUUBUlRrYBxPWjpQAMUgoB8o6xS4uLmWWnbO+2X32M0jqJ7C5EhXlWsl7ZtHxxK9Ed01VRle0l39Pt9WdTVxoc2K4pbvK9iAhJh1NVfuGxifTt7eGcS76jG35eOJThqyvrWFh03v6qYU/yjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwyu3v1JzHUfvrBiNW3tbWaOqiFaFxQDpE+alqdz4TU=;
 b=hXabXD+ncFu0XHRxVsgT1R2Yf7kt9OZmw/klJTtyPoiznrC5SPgBpX7JndsFDfPpsDAFtYhAXqE+QF8/pvnS1iLfLVj5S9U3GgPyaoCyl0qWQ+2Jxd7Uuw1z2yOY8azz/VSPxPoIfCe2GTbnJAxucDHjqvADUZnGWIEtkrAGxWI=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3803.namprd11.prod.outlook.com (2603:10b6:5:141::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18; Mon, 15 Jun 2020 06:04:32 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c%6]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 06:04:32 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v2 02/15] iommu: Report domain nesting info
Thread-Topic: [PATCH v2 02/15] iommu: Report domain nesting info
Thread-Index: AQHWP+lAvgybSaO2NECN4P16s7e2zKjTzaSAgADgFXCABDlcgIAARuNg
Date: Mon, 15 Jun 2020 06:04:32 +0000
Message-ID: <DM5PR11MB1435EB4D10A6EF16BF95C811C39C0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
 <1591877734-66527-3-git-send-email-yi.l.liu@intel.com>
 <20200611133015.1418097f@x1.home>
 <DM5PR11MB143571773B05359FA2F46FB6C3810@DM5PR11MB1435.namprd11.prod.outlook.com>
 <MWHPR11MB1645A7EBC706AC8A075EA83D8C9C0@MWHPR11MB1645.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1645A7EBC706AC8A075EA83D8C9C0@MWHPR11MB1645.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f069fcc-a333-4440-85f8-08d810f1f900
x-ms-traffictypediagnostic: DM6PR11MB3803:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3803FEF562D787B40FB4085DC39C0@DM6PR11MB3803.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yZYVfKfgfGI3OpIoFITirdPU5jAJGsBAwrX+wN0kzM33LQgvcBreO28UA4B5CHUSclp9COfP+n0l7v4j60S9Siq3vVnTtp33cNF7bZVXBYnIetsbE1MAs67JVfsw+lS981VLsaxMipt6SsiWtMmcUSzyRNSkYYzb9mQTbaRt6YI2ePtcbd6XnmMSAUporG9Ry07PXa5sghLnYZ6v4Sw3FNb+OXeej82IH6HbhsYsurse890SDTAjKt2O0ZA1KW5QrGTX4W4434FEZGjxHuWU22wse6whBboVxKFyPWyWoD3gzVni1pSckVe0650AC8XKLNGQgZiNSle/qxeh8d4oUOJ7IPpMdDRrVDOjcLsCeF3Y3GXlyeJQjmk31CWxNlzZYUVGGdKw8xbAkfTkBeel4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(396003)(366004)(376002)(39860400002)(346002)(8936002)(4326008)(26005)(6506007)(52536014)(9686003)(2906002)(7696005)(186003)(8676002)(33656002)(478600001)(55016002)(966005)(5660300002)(110136005)(66946007)(76116006)(66476007)(54906003)(64756008)(66446008)(66556008)(86362001)(7416002)(83380400001)(71200400001)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 6d0B8qek8eGnGDV6hSTQdBT6IuceHg5PvRHI/W7vq4j3dUYs8awpC9SIYiDxyyIBk0kj/gw5y149ovFmBbbFRyCFzkxY0K6OhvVg4ARQeH/Jbp21XTFBGF0WIvVhhqpc4vcD83N8OK0RYEbGVcHdahyOqXmNT4S9UHYO3xYAVvMH3QYwzcPmWG8tIwef3+UIqkWMC6uSaS7QHs9p7Qd2KyJLTX/vX4IKpZzwys3q9WXriI4KasjPVD77BF2VUTXHFbWrw8bLGva9JerG+pjDJ8/ySjCjWTThKxFM/4/7wsidrv3h1znsXwvUOp0ieFfDBuDSlwRUeMbza2y/DNdAi0VeWd69IMLKsQem4YxQJu07th2WuGEJQrWOiUMjzRslhTi5WIb53iqG4XKWBv8hqlpYYJlroS0F15vhr/eRTa9ym0kOV5yX68mE9UcGIIrYEDyweIpLWsw+DBhBBN/I2u9Q25su00du+60AgQXwSVA=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f069fcc-a333-4440-85f8-08d810f1f900
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 06:04:32.2139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K2ySxnGNhqJI82xleBiQ17qT13yFhy+5r6kA1oG3LN3vRRwdo/hB+loDM5uZBNbhJgMOLP7LHkLZPqUbtaLUnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3803
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>
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

Hi Kevin,

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Monday, June 15, 2020 9:23 AM
> 
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Friday, June 12, 2020 5:05 PM
> >
> > Hi Alex,
> >
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Friday, June 12, 2020 3:30 AM
> > >
> > > On Thu, 11 Jun 2020 05:15:21 -0700
> > > Liu Yi L <yi.l.liu@intel.com> wrote:
> > >
> > > > IOMMUs that support nesting translation needs report the
> > > > capability info to userspace, e.g. the format of first level/stage paging
> structures.
> > > >
> > > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > > Cc: Eric Auger <eric.auger@redhat.com>
> > > > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > Cc: Joerg Roedel <joro@8bytes.org>
> > > > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > ---
> > > > @Jean, Eric: as nesting was introduced for ARM, but looks like no
> > > > actual user of it. right? So I'm wondering if we can reuse
> > > > DOMAIN_ATTR_NESTING to retrieve nesting info? how about your
> > opinions?
> > > >
> > > >  include/linux/iommu.h      |  1 +
> > > >  include/uapi/linux/iommu.h | 34
> > ++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 35 insertions(+)
> > > >
> > > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> > > > 78a26ae..f6e4b49 100644
> > > > --- a/include/linux/iommu.h
> > > > +++ b/include/linux/iommu.h
> > > > @@ -126,6 +126,7 @@ enum iommu_attr {
> > > >  	DOMAIN_ATTR_FSL_PAMUV1,
> > > >  	DOMAIN_ATTR_NESTING,	/* two stages of translation */
> > > >  	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
> > > > +	DOMAIN_ATTR_NESTING_INFO,
> > > >  	DOMAIN_ATTR_MAX,
> > > >  };
> > > >
> > > > diff --git a/include/uapi/linux/iommu.h
> > > > b/include/uapi/linux/iommu.h index 303f148..02eac73 100644
> > > > --- a/include/uapi/linux/iommu.h
> > > > +++ b/include/uapi/linux/iommu.h
> > > > @@ -332,4 +332,38 @@ struct iommu_gpasid_bind_data {
> > > >  	};
> > > >  };
> > > >
> > > > +struct iommu_nesting_info {
> > > > +	__u32	size;
> > > > +	__u32	format;
> > > > +	__u32	features;
> > > > +#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
> > > > +#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
> > > > +#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
> > > > +	__u32	flags;
> > > > +	__u8	data[];
> > > > +};
> > > > +
> > > > +/*
> > > > + * @flags:	VT-d specific flags. Currently reserved for future
> > > > + *		extension.
> > > > + * @addr_width:	The output addr width of first level/stage
> translation
> > > > + * @pasid_bits:	Maximum supported PASID bits, 0 represents no
> > PASID
> > > > + *		support.
> > > > + * @cap_reg:	Describe basic capabilities as defined in VT-d
> > capability
> > > > + *		register.
> > > > + * @cap_mask:	Mark valid capability bits in @cap_reg.
> > > > + * @ecap_reg:	Describe the extended capabilities as defined in VT-d
> > > > + *		extended capability register.
> > > > + * @ecap_mask:	Mark the valid capability bits in @ecap_reg.
> > >
> > > Please explain this a little further, why do we need to tell
> > > userspace about cap/ecap register bits that aren't valid through this interface?
> > > Thanks,
> >
> > we only want to tell userspace about the bits marked in the cap/ecap_mask.
> > cap/ecap_mask is kind of white-list of the cap/ecap register.
> > userspace should only care about the bits in the white-list, for other
> > bits, it should ignore.
> >
> > Regards,
> > Yi Liu
> 
> For invalid bits if kernel just clears them then do we still need additional mask bits
> to explicitly mark them out? I guess this might be the point that Alex asked...

For invalid bits, kernel will clear them. But I think the mask bits is
still necessary. The mask bits tells user space the bits related to
nesting. Without it, user space may have no idea about it.

Maybe talk about QEMU usage of the cap/ecap bits would help. QEMU vIOMMU
decides cap/ecap bits according to QEMU cmdline. But not all of them are
compatible with hardware support. Especially, vIOMMU built on nesting.
So needs to sync the cap/ecap bits with host side. Based on the mask
bits, QEMU can compare the cap/ecap bits configured by QEMU cmdline with
the cap/ecap bits reported by this interface. This comparation is limited
to the nesting related bits in cap/ecap, the other bits are not included
and can use the configuration by QEMU cmdline.

The link below show the current Intel vIOMMU usage on the cap/ecap bits.
For each assigned device, vIOMMU will compare the nesting related bits in
cap/ecap and mask out the bits which hardware doesn't support. After the
machine is intilized, the vIOMMU cap/ecap bits are determined. If user
hot-plug devices to VM, vIOMMU will fail it if the hardware cap/ecap bits
behind hot-plug device are not compatible with determined vIOMMU cap/ecap
bits.

https://www.spinics.net/lists/kvm/msg218294.html

Regards,
Yi Liu

> >
> > > Alex
> > >
> > >
> > > > + */
> > > > +struct iommu_nesting_info_vtd {
> > > > +	__u32	flags;
> > > > +	__u16	addr_width;
> > > > +	__u16	pasid_bits;
> > > > +	__u64	cap_reg;
> > > > +	__u64	cap_mask;
> > > > +	__u64	ecap_reg;
> > > > +	__u64	ecap_mask;
> > > > +};
> > > > +
> > > >  #endif /* _UAPI_IOMMU_H */

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

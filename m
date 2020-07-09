Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9F1C433E0
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 02:18:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888C9206F6
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 02:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="gm4HFPcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888C9206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5856F21551;
	Thu,  9 Jul 2020 02:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1l-vHE5gG7Tu; Thu,  9 Jul 2020 02:18:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 00160215DF;
	Thu,  9 Jul 2020 02:18:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4DC4C077B;
	Thu,  9 Jul 2020 02:18:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FEDDC016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 02:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5D208215DF
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 02:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZKjUsogez2Sk for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 02:18:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 1310521551
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 02:18:26 +0000 (UTC)
IronPort-SDR: BNYTyHDdFoefE1qVM2kzHGa9TOy+H+bPF4X8BjJ35jwawD5oNT5tJVOdjaVWRkTaf6UVHZOaYQ
 al5IupkclGhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="209456776"
X-IronPort-AV: E=Sophos;i="5.75,330,1589266800"; d="scan'208";a="209456776"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2020 19:18:24 -0700
IronPort-SDR: wx8ceS4KCkFGc/aOQ2dtCiylKM0NG0hFj3vAOt4xyQD/Ly096JEwP7FklzwFh0nw0u1rFpRnWl
 iSqEs2UqRbTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,330,1589266800"; d="scan'208";a="306243111"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga004.fm.intel.com with ESMTP; 08 Jul 2020 19:18:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 8 Jul 2020 19:18:24 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 8 Jul 2020 19:18:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 8 Jul 2020 19:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmTsjeYGePt3WBY8Vn+VwyhHCz2z7RFg2zNM0qlrX/A95vXD09MnvyNHlHw8rT5rXkDj/3QJheFqqZhJ6c/U6P6wT9vtj9lA4W0MJDGrLGO0C709o9s2u/Y6/OG0qVsHpqCK1ve60MG556ILcp6RI+7nE2ZgN+Z6/vAdyFTMFmWCL8djCLKWsoQImqYNpTpxEXMoz+V5iMXTBfvt99c++hmuCbHhNknrQMyMLJaymq6XFVmwbP5yuDV0dsnkVBZcGQZFTuny/lTFyNlOuB5U7bSOCVKjTstkmsAQW5NmaBpAhN0KwU3d59GvMFDzpZT+4Ikfz56Kg3rNRefja4qQ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpc1HESGye4e2Ufq3lkclNfZwnrBFC7Z5XijTigf4/4=;
 b=mROxB29CX9hag6H/AUM+UAtHbAnwflq5llAtBTJonXomaMHI3hljP6WdmnvsVVrPuq5HArsYE/Zslsfg+spG4gXuE+yY7AIOEXaVO6LF3ZYHrtvEkGoTHIfzEp4JzOqvz6w9+O5su7OYgUAg2wght6DKhwdU23tUvkfUbREIokoZZmXkOOlIzhPTIdwreapoN0a7uOXZcd07ABm+eqmC+FQLqryQ8UQ1+OJDciBROmv+7Znz8DP/pIMMBmVFjL6al6CRZp3t7fm67k15CL1JT2AuBu6Wx8c501h5lVCVjI6LZxKS3H6AUfHbLugI39OjCy9rMHQ7g0iYoG3Pk121Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpc1HESGye4e2Ufq3lkclNfZwnrBFC7Z5XijTigf4/4=;
 b=gm4HFPcGaet73+H7VfWT5x3pc+BfQiMrjzAn6MnbRG1AMkpOimhukhxUlrXTqTyJUzTzfyfqGzs/gSYo2T5pHeW7SjxV/YfMhb5Vrx+e3V0bqRaKh5XYfE4bU6ISqZ0cQnju2L6xrbfeQjPXDzhlrFiLIPHT2e1b9BczzVM1CYM=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1358.namprd11.prod.outlook.com (2603:10b6:300:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 9 Jul
 2020 02:18:19 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3174.022; Thu, 9 Jul 2020
 02:18:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Alex Williamson
 <alex.williamson@redhat.com>, "jacob.jun.pan@linux.intel.com"
 <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v3 06/14] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Topic: [PATCH v3 06/14] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Index: AQHWSgRRTio77cjKfEyUOM8HK1PN0qj02KQAgACZigCAB/njAIAAwyYAgABNmICAABJNAIAACHyAgAAA6vA=
Date: Thu, 9 Jul 2020 02:18:19 +0000
Message-ID: <MWHPR11MB1645F822D9267005AE5BCE528C640@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
 <1592988927-48009-7-git-send-email-yi.l.liu@intel.com>
 <20200702151832.048b44d1@x1.home>
 <CY4PR11MB1432DD97F44EB8AA5CCC87D8C36A0@CY4PR11MB1432.namprd11.prod.outlook.com>
 <DM5PR11MB1435B159DA10C8301B89A6F0C3670@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20200708135444.4eac48a4@x1.home>
 <DM5PR11MB14358A8797E3C02E50B37FFEC3640@DM5PR11MB1435.namprd11.prod.outlook.com>
 <MWHPR11MB16456D12135AA36BA16CE4208C640@MWHPR11MB1645.namprd11.prod.outlook.com>
 <DM5PR11MB14357DC99EFCDE7E02944E2EC3640@DM5PR11MB1435.namprd11.prod.outlook.com>
In-Reply-To: <DM5PR11MB14357DC99EFCDE7E02944E2EC3640@DM5PR11MB1435.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aeda1d10-102e-421e-4f18-08d823ae58be
x-ms-traffictypediagnostic: MWHPR11MB1358:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1358F3509C46399CE9861AC48C640@MWHPR11MB1358.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5kwPtEV0+4E22bru7givKBtMevY9PO5dj0te6T8VNAP6KxzvQHANRnlvKDllP5Ss0+Xf6v4eba3VYHZs3i1+67NVIA/IlawWtIF7xo1bTnc0VhYbqZP3JhkV9Ufyrn+0obTtl7DNNsFi4hJ/pSzQ6b4l3M81RuCNf4kl/3lCjaf5fqmFW9kKixa04/lLwi0IlxFfjMdwXbXzhcqeCrzdshCM5AtOZjPdAQfmqaSiX3nbNWBDSa9+SrdXbR93XrVfy4//9sCvTTitC1yWneGlAX+TynkU3Kph2cKkrrsIx0HPQxWKz7XVmKrc3bAxGSUstSfWaylv6kPXRaBa62Uj8Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(7416002)(7696005)(6506007)(26005)(186003)(8676002)(33656002)(83380400001)(86362001)(316002)(9686003)(2906002)(8936002)(110136005)(54906003)(478600001)(71200400001)(52536014)(4326008)(66946007)(55016002)(76116006)(5660300002)(66556008)(66446008)(64756008)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: vtp/4e1F+7lBhQ3bmfRQhU4ekOtTmaMgXmKZp9SLpQUJ83DCvosW4Nkg+m6albK7DLsyxz2EQVszPtcozmtcRhNZAqc3AELKwmPe8Yt7HspMAo5oHcXHcmSjavJzA9qTxhLvR7IU5VAD+ew7SGwfQFHhsI3b508kGHma8aEmr8bbTwc6pY7x5FoBIZ0CCH8VD475EKs9BHtRqqLBC7/f8/F46t3fEUDl8XKkRNj3ShJPdulSXE2jJHm7un/vJpNVNSOnxSJX1prAUHhptY5eToCX21oCnUcmnN5B4GfyyWCl1+prKLVHOS1CPYYLRKvCMHbqSCwO3DmSOBIvE6Kx9u+xGWT/Wrrisv84wd8eg2HbM1eoItP1UZCt2ehiLWOrkmjSvuStAi9WVrtSOazh7GR/zPKqb+FIHTAIpb+ALo+r1GBIaX1GZMO1V+vVS6OWVv+RnTFdvzCzdFEf0mIXcLQ6FaUkRH12RjimuPUQwsxhEMFtIiW9hIh6mi/VKYvE
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeda1d10-102e-421e-4f18-08d823ae58be
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 02:18:19.0754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KwRb+KC+2aLa4Cj8TxB1IkTnGlZAWF9jQlsh1NVtSrkK3PpgBYZTYWnc5QuNqXHY71PPDXDR/hDxXf2DeL55AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1358
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

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, July 9, 2020 10:08 AM
> 
> Hi Kevin,
> 
> > From: Tian, Kevin <kevin.tian@intel.com>
> > Sent: Thursday, July 9, 2020 9:57 AM
> >
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Thursday, July 9, 2020 8:32 AM
> > >
> > > Hi Alex,
> > >
> > > > Alex Williamson <alex.williamson@redhat.com>
> > > > Sent: Thursday, July 9, 2020 3:55 AM
> > > >
> > > > On Wed, 8 Jul 2020 08:16:16 +0000
> > > > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> > > >
> > > > > Hi Alex,
> > > > >
> > > > > > From: Liu, Yi L < yi.l.liu@intel.com>
> > > > > > Sent: Friday, July 3, 2020 2:28 PM
> > > > > >
> > > > > > Hi Alex,
> > > > > >
> > > > > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > > > > Sent: Friday, July 3, 2020 5:19 AM
> > > > > > >
> > > > > > > On Wed, 24 Jun 2020 01:55:19 -0700 Liu Yi L
> > > > > > > <yi.l.liu@intel.com> wrote:
> > > > > > >
> > > > > > > > This patch allows user space to request PASID allocation/free,
> e.g.
> > > > > > > > when serving the request from the guest.
> > > > > > > >
> > > > > > > > PASIDs that are not freed by userspace are automatically
> > > > > > > > freed
> > > when
> > > > > > > > the IOASID set is destroyed when process exits.
> > > > > [...]
> > > > > > > > +static int vfio_iommu_type1_pasid_request(struct vfio_iommu
> > > *iommu,
> > > > > > > > +					  unsigned long arg)
> > > > > > > > +{
> > > > > > > > +	struct vfio_iommu_type1_pasid_request req;
> > > > > > > > +	unsigned long minsz;
> > > > > > > > +
> > > > > > > > +	minsz = offsetofend(struct vfio_iommu_type1_pasid_request,
> > > > range);
> > > > > > > > +
> > > > > > > > +	if (copy_from_user(&req, (void __user *)arg, minsz))
> > > > > > > > +		return -EFAULT;
> > > > > > > > +
> > > > > > > > +	if (req.argsz < minsz || (req.flags &
> > > > ~VFIO_PASID_REQUEST_MASK))
> > > > > > > > +		return -EINVAL;
> > > > > > > > +
> > > > > > > > +	if (req.range.min > req.range.max)
> > > > > > >
> > > > > > > Is it exploitable that a user can spin the kernel for a long
> > > > > > > time in the case of a free by calling this with [0, MAX_UINT]
> > > > > > > regardless of their
> > > > actual
> > > > > > allocations?
> > > > > >
> > > > > > IOASID can ensure that user can only free the PASIDs allocated
> > > > > > to the
> > > user.
> > > > but
> > > > > > it's true, kernel needs to loop all the PASIDs within the range
> > > > > > provided by user.
> > > > it
> > > > > > may take a long time. is there anything we can do? one thing may
> > > > > > limit
> > > the
> > > > range
> > > > > > provided by user?
> > > > >
> > > > > thought about it more, we have per-VM pasid quota (say 1000), so
> > > > > even if user passed down [0, MAX_UNIT], kernel will only loop the
> > > > > 1000 pasids at most. do you think we still need to do something on it?
> > > >
> > > > How do you figure that?  vfio_iommu_type1_pasid_request() accepts
> > > > the user's min/max so long as (max > min) and passes that to
> > > > vfio_iommu_type1_pasid_free(), then to vfio_pasid_free_range()
> > > > which loops as:
> > > >
> > > > 	ioasid_t pasid = min;
> > > > 	for (; pasid <= max; pasid++)
> > > > 		ioasid_free(pasid);
> > > >
> > > > A user might only be able to allocate 1000 pasids, but apparently
> > > > they can ask to free all they want.
> > > >
> > > > It's also not obvious to me that calling ioasid_free() is only
> > > > allowing the user to free their own passid.  Does it?  It would be a
> > > > pretty
> >
> > Agree. I thought ioasid_free should at least carry a token since the user
> space is
> > only allowed to manage PASIDs in its own set...
> >
> > > > gaping hole if a user could free arbitrary pasids.  A r-b tree of
> > > > passids might help both for security and to bound spinning in a loop.
> > >
> > > oh, yes. BTW. instead of r-b tree in VFIO, maybe we can add an
> > > ioasid_set parameter for ioasid_free(), thus to prevent the user from
> > > freeing PASIDs that doesn't belong to it. I remember Jacob mentioned it
> before.
> > >
> >
> > check current ioasid_free:
> >
> >         spin_lock(&ioasid_allocator_lock);
> >         ioasid_data = xa_load(&active_allocator->xa, ioasid);
> >         if (!ioasid_data) {
> >                 pr_err("Trying to free unknown IOASID %u\n", ioasid);
> >                 goto exit_unlock;
> >         }
> >
> > Allow an user to trigger above lock paths with MAX_UINT times might still
> be bad.
> 
> yeah, how about the below two options:
> 
> - comparing the max - min with the quota before calling ioasid_free().
>   If max - min > current quota of the user, then should fail it. If
>   max - min < quota, then call ioasid_free() one by one. still trigger
>   the above lock path with quota times.

This is definitely wrong. [min, max] is about the range of the PASID value,
while quota is about the number of allocated PASIDs. It's a bit weird to
mix two together. btw what is the main purpose of allowing batch PASID
free requests? Can we just simplify to allow one PASID in each free just
like how is it done in allocation path?

> 
> - pass the max and min to ioasid_free(), let ioasid_free() decide. should
>   be able to avoid trigger the lock multiple times, and ioasid has have a
>   track on how may PASIDs have been allocated, if max - min is larger than
>   the allocated number, should fail anyway.

What about Alex's r-b tree suggestion? Is there any downside in you mind?

Thanks,
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

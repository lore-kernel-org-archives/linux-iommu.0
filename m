Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECEEC433E0
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 02:15:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9552720773
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 02:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Q3aYfxKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9552720773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2B69688D4A;
	Fri, 19 Jun 2020 02:15:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uskJ6GR3ILMs; Fri, 19 Jun 2020 02:15:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 09F2788D42;
	Fri, 19 Jun 2020 02:15:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9F00C07FF;
	Fri, 19 Jun 2020 02:15:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CBE0C016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 02:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8DF6E89909
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 02:15:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DPFSRcWhbT-T for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 02:15:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A1D0289905
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 02:15:40 +0000 (UTC)
IronPort-SDR: ffmkDDR46UJqt6K7Y63hPndg1YCTlYuJ9q/GjHiOJsV10KXPgFY5XgPy2NysJLF5caPSMHMpaq
 IqZusvDWoKpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="141106155"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; d="scan'208";a="141106155"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 19:15:39 -0700
IronPort-SDR: zEXCVlEmXzlCz/gTXZg97LsMhMvRhpFjzL2fCDyGjvaRzOCXfzFC4N8+Ztd8nQIWxWRnIZjqG+
 YDDw9hG9unAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; d="scan'208";a="291972460"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga002.jf.intel.com with ESMTP; 18 Jun 2020 19:15:39 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jun 2020 19:15:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 18 Jun 2020 19:15:38 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 18 Jun 2020 19:15:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 18 Jun 2020 19:15:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3MiG8n6AiR6cMaqrjfj3EGisjRWCXb2jT7dfu/xoKvqOVuEKru9xyPEOGnpi9ROeiDdnTx06yX7ONDWXhr0TAnaxuWca9Wpq64dmS7YjujpxLr4y3D0/jlr+QJJVqvxKxeVsIgmroLi6pCQcjp0x4Z0G/68PnDDJ+QHRrGVdASXpgPJHk75U4W/1U+nxVHvl3ofyeDyqkAlAGFJMQCPSBGcvv4RH4le2kVtBzFdwy8uah13rrxF6rilHvxTDA/cLSfO9/bQT2AKmBUJGTDK+Q5MStbtzmUeakzY+n0Z9jiOYb/Dwf+XzEh9CbUDuc/HaJBxjfHjaCrBXMFv23v1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxGeDymKDy/oKPImvDlV50avB/Gk03RAhc9nh+fEyMU=;
 b=cfvsjOVSrmjfRFLBrLVSf+QnthlqVukvE8jIVDe19FQ1kl+Tu0olFy0ePe9iCigk3rbKJlWXHNgFqdDgQZbm6aJ502e53Vha6koAdouutPtiPbIWRHHFWBm53GADkQ8JLmHHYiSBG4mUHmv1ifAkLyaljtgHO9JY9aLM/YCk/wuuZZuS9GUMAPuQvYGG7L89hHRlqzDiJeKpMlm9HheIHa3OQEEmljfJIJ+z+Kr/wvBQY95CPZSAC0H+bMm7O0IRRBhRkqoJOvP9piGU+mzgnOwALr+eNRRdKY8YA70N/MzQlis7Of0TXOBVSWy8EgBhTg+2/H8AlJFJacn+kIr5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxGeDymKDy/oKPImvDlV50avB/Gk03RAhc9nh+fEyMU=;
 b=Q3aYfxKw1KXphRa8nZbOSdy0lHCxVVIDvmQs/goiOLx+AK8t/2sEYCxsfSK1/hFbXn/2R3H9rbca3UJRji91sZFSOPx0U/WCeM+xeZFwzWoa8gXpeUDHkw/HbltM6O8nQSh/JgdpyEcnRM5bEHIlAC4o8Q4+EHIIF2E2slcu0iw=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3195.namprd11.prod.outlook.com (2603:10b6:5:5d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.23; Fri, 19 Jun 2020 02:15:37 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c%6]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 02:15:36 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>
Subject: RE: [PATCH v2 1/3] docs: IOMMU user API
Thread-Topic: [PATCH v2 1/3] docs: IOMMU user API
Thread-Index: AQHWP6WkhOQLPQDE2EquIdJoSq1UYKjTj/yAgABESYCAAA2bgIAAP1SAgAdDUQCAAPjyYIAAJcYAgAJxwoCAADPkoA==
Date: Fri, 19 Jun 2020 02:15:36 +0000
Message-ID: <DM5PR11MB1435FA1C517087E8C5DEACB3C3980@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1591848735-12447-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200611094741.6d118fa8@w520.home>	<20200611125205.1e0280d3@jacob-builder>
 <20200611144047.79613c32@x1.home>	<20200611172727.78dbb822@jacob-builder>
 <20200616082212.0c1611dd@jacob-builder>
 <DM5PR11MB1435DD578488DA08A1E699ACC39A0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <MWHPR11MB164595B754BE441255902DCA8C9A0@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200618154805.049219db@w520.home>
In-Reply-To: <20200618154805.049219db@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12d19ac7-e5ba-4457-e423-08d813f6a7b9
x-ms-traffictypediagnostic: DM6PR11MB3195:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3195638C9C2B4A1E59840721C3980@DM6PR11MB3195.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1SBD3G5opleNivyo0mE7rxxu76aJrR/jE9g8vbfs0c7YFtpOZb6npNO/BBGk8I2dqLKnkR6383KZquMeChiywO7YZt6vWlMbDvfp0w4L4KxCGz1xqFfaPspcPKwA9b+Wz72MtSgCi1GbxpRrUprl7CqEZFEie5pmFr3tcFMGduOLG0KU01KOYZkqWgE7CJIpjXhexIaeykVLJ9F7dvCmzaO22Kh42FxQSN/v6hkpuizK0skqQBKlF674uG3GIP7UlYYDWG3qQZzOAMWDj/8cwcXOO019025HxpDcIBBfIp7NwlzwN1m6wCendMzV7ewh0jTxRDJn1ymZr3xCDskyLQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(83380400001)(2906002)(26005)(8936002)(186003)(8676002)(6506007)(71200400001)(4326008)(7696005)(54906003)(52536014)(7416002)(110136005)(86362001)(66946007)(9686003)(76116006)(33656002)(5660300002)(66476007)(64756008)(6636002)(66446008)(478600001)(316002)(66556008)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: DWlRgAdIW6Exr8vUhXvBcQ20CN77qY0mgAGQ976Lz47ClkbqT2pMAoFCrwPR3CyDrhFEeZlNyg2uQX2c6h6iDYOHCavM855F94Bztatibqr7vfXofalLYEXu8yGlRYs36QcA0Y1wnh99W6uTZiI98C3tDTSgpV5cEzMXsX954L/T9IzGNYr6nbigEg5KsH78wvN3SBQMDeBkQqpLp+Cf3jIMB3TY8q1kk7Y75jxBcqNndnkALW8IHuvwBXz04VdUG6JPLNT1w+PHWFoyzCmiJ9lkY7XP3S8MDJWCccuU3VYNbFXzbmDLpzym5+1BzFLgXQFPNFtdRubyPlcfoPyt4TCp8L+daFEjfVxQzbhXa1EbKOLySB5HrQ6f9sd/mDSldSE2/T/F/EIm97a+VZ5MYzfM+S3UK7a2m3eoqV3MCt1tLgOhkLESdRkDbK4yXYi3F35Uu64XUmObLjGjJj5ePHR4J2yNKuusaz0ofp1LGXGFXV0NQAv8aOKMZUbyIOC4
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d19ac7-e5ba-4457-e423-08d813f6a7b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 02:15:36.8535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2bPqQbpq6Mo3r5IG9nWWEE6L5eQDgpuEaWZvmwv+CsKUkr8AGzZYGzccetODjz41+EGwDjTZ32jL7/mkbqSb2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3195
X-OriginatorOrg: intel.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

Hi Alex,

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, June 19, 2020 5:48 AM
> 
> On Wed, 17 Jun 2020 08:28:24 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Wednesday, June 17, 2020 2:20 PM
> > >
> > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Sent: Tuesday, June 16, 2020 11:22 PM
> > > >
> > > > On Thu, 11 Jun 2020 17:27:27 -0700
> > > > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> > > >
> > > > > >
> > > > > > But then I thought it even better if VFIO leaves the entire
> > > > > > copy_from_user() to the layer consuming it.
> > > > > >
> > > > > OK. Sounds good, that was what Kevin suggested also. I just wasn't
> > > > > sure how much VFIO wants to inspect, I thought VFIO layer wanted to do
> > > > > a sanity check.
> > > > >
> > > > > Anyway, I will move copy_from_user to iommu uapi layer.
> > > >
> > > > Just one more point brought up by Yi when we discuss this offline.
> > > >
> > > > If we move copy_from_user to iommu uapi layer, then there will be
> > > multiple
> > > > copy_from_user calls for the same data when a VFIO container has
> > > multiple domains,
> > > > devices. For bind, it might be OK. But might be additional overhead for TLB
> > > flush
> > > > request from the guest.
> > >
> > > I think it is the same with bind and TLB flush path. will be multiple
> > > copy_from_user.
> >
> > multiple copies is possibly fine. In reality we allow only one group per
> > nesting container (as described in patch [03/15]), and usually there
> > is just one SVA-capable device per group.
> >
> > >
> > > BTW. for moving data copy to iommy layer, there is another point which
> > > need to consider. VFIO needs to do unbind in bind path if bind failed,
> > > so it will assemble unbind_data and pass to iommu layer. If iommu layer
> > > do the copy_from_user, I think it will be failed. any idea?
> 
> If a call into a UAPI fails, there should be nothing to undo.  Creating
> a partial setup for a failed call that needs to be undone by the caller
> is not good practice.

is it still a problem if it's the VFIO to undo the partial setup before
returning to user space?

> > This might be mitigated if we go back to use the same bind_data for both
> > bind/unbind. Then you can reuse the user object for unwinding.
> >
> > However there is another case where VFIO may need to assemble the
> > bind_data itself. When a VM is killed, VFIO needs to walk allocated PASIDs
> > and unbind them one-by-one. In such case copy_from_user doesn't work
> > since the data is created by kernel. Alex, do you have a suggestion how this
> > usage can be supported? e.g. asking IOMMU driver to provide two sets of
> > APIs to handle user/kernel generated requests?
> 
> Yes, it seems like vfio would need to make use of a driver API to do
> this, we shouldn't be faking a user buffer in the kernel in order to
> call through to a UAPI.  Thanks,

ok, so if VFIO wants to issue unbind by itself, it should use an API which
passes kernel buffer to IOMMU layer. If the unbind request is from user
space, then VFIO should use another API which passes user buffer pointer
to IOMMU layer. makes sense. will align with jacob.

Regards,
Yi Liu

> Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

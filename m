Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963EAC433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 02:52:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D10206C0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 02:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="lj0q3gSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D10206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 13ADB2156B;
	Tue, 30 Jun 2020 02:52:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NeXHuLhtrIIJ; Tue, 30 Jun 2020 02:52:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CF81620369;
	Tue, 30 Jun 2020 02:52:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FD3DC0865;
	Tue, 30 Jun 2020 02:52:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42FD5C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 02:52:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 250DB8858A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 02:52:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lqvfLo-ZPLJp for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 02:52:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 647428852F
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 02:52:49 +0000 (UTC)
IronPort-SDR: nKwF+1gXTlOmgXYTwEdNmSEqSamOvy9r8xh1H871IIU2QmHpoPsTO0A+mCjBCDi+yWFw4O+gpW
 LhBnuPzw2c2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="207640552"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="207640552"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2020 19:52:48 -0700
IronPort-SDR: Kftm4TLNrMBSj+kFsiO3oqviYk2U/8lkYH1qke4QApeen6p+JGgKAycQ4sh45KSPbN0voKy5Dv
 ZqPzepMzjz1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="320805037"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2020 19:52:47 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 29 Jun 2020 19:52:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 29 Jun 2020 19:52:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1V8N4d3guz1UzCJPKLICbG0/gVwfE+E5TuZXpTz2VWnvZWMC4Ryu5FcGu4zmaW5b3fU1JLYkd39q/866VoQ/0NZw4HVVJ+bcB+l/Bmhr+TbB1D61DkdEXwLvIoUaFrYM2dfegmGQ2HGIS0OD4RVgFOb9aNqrdavgVuUUN9hCtq2y7+RjZ++3dtWaR10WVfHLuBbaIVRzI/AwrmdQKvnN3nu5I/gQt7P/5UN9EWIIB+lJw4QjFstK8PHm4NpOkwOnmYXP1+YSiTn4AzOdlBEssZ8xSpoyKyoNcdHWDm7rkWs9agC1OmYaivtN5bEeH1VXXugrHSaSoljE/N04Nfcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QCUf+zQuHQ2jcZfLTe/jfSQQTSQEF9J6u9BSVprl78=;
 b=OdKFthS6bUKZSAi+Bo8WNijR/zQDUvJBG1BUtBVm8sv4AGuYLOKVukPYTVq1J9u3lfSqhOvcrtagBYg1V2VF/muN5wo+iY3qQf/ivdw3Zzh4KQbHzC7ZPjXl5bjdzKXWZyzT4R8BgaCGzb9+nuniBgEdhTr22M0kiUcdA+3NYRwpISDjVvY+ZQ4ymCSDWf53byrZZkVjF6BbEBgl1D6ZxBtREME9VQ0BJ0x/joSTaL3sOgZeOn6bHgeXHsVMzgf7TQTL0ZRcJGIKey7MRKUoWJDXQ3rXwtVJ/k4A7xQ70zj+tAh8mBrKK9PCh/ZEbY+QQZgythRCplVtRhImr4agIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QCUf+zQuHQ2jcZfLTe/jfSQQTSQEF9J6u9BSVprl78=;
 b=lj0q3gSG2tRif4+JPdY9MGbTzifcTz+dMhtp1pq6g1OSe8RjIkGLnS5yE/ZIetkqQEILVqu06GOingwYAQxhv40cYd3+67cBEW2z8A11YLHchnQHCS4cE9FDuYQ/NBAlsOm036h+yxHiB45O8UB6Uq0Igqhs0wh9T2EwyVF4ghQ=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1455.namprd11.prod.outlook.com (2603:10b6:301:9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Tue, 30 Jun
 2020 02:52:45 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 02:52:45 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v3 1/5] docs: IOMMU user API
Thread-Topic: [PATCH v3 1/5] docs: IOMMU user API
Thread-Index: AQHWSX9tEM38rhxxoUaw7eTgZyKye6jrfLGAgATD0wCAADz18A==
Date: Tue, 30 Jun 2020 02:52:45 +0000
Message-ID: <MWHPR11MB1645D1A989A7D4E22BCB29A38C6F0@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <1592931837-58223-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592931837-58223-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200626161923.339e17a6@w520.home> <20200629160518.471159cf@jacob-builder>
In-Reply-To: <20200629160518.471159cf@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 381165dc-10a3-427d-9060-08d81ca0aa79
x-ms-traffictypediagnostic: MWHPR11MB1455:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB145560733C5AFBF0EC3854408C6F0@MWHPR11MB1455.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sm7SpismwGGLqegZ0iwR1q8IUtBNrPyBJU1S/6SJo2NdKtmtTepuHajO+kN1R6ujP3Ji46FAe1lw3uf8X9e+MTwvFqLhH8K3h7InDHxpdxQybNGUBNDfBc2SlxItwCn5F0qhK8OTOIVyGZCuf0pF9JdhPzsugOqGtYx5w+4jRgGK9hPIiKFgvz5Wiz74pevtOPlUif6uTf/MpdyCNkQ2dn7BUoZEqsMUP7XrzmBKJTHxrHnGDTpE+to53hhSFNVh+zwfnId1BZWfmQ5EJDgctTa4t4TckBLPC/NWOFKk6c74sz21di+Dlr76ttGKQG0JRcMFzzfDxEP5JbLPCKUWZZHWyDXAd2sh0jgKe52dZqF7bLyAUrZY3SdfXxwEwq8k5/n9A/3GEYCq51X3gIER0g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(2906002)(110136005)(54906003)(33656002)(316002)(83380400001)(86362001)(4326008)(8936002)(478600001)(71200400001)(26005)(5660300002)(8676002)(7696005)(66476007)(52536014)(30864003)(66446008)(76116006)(966005)(9686003)(66556008)(64756008)(66946007)(55016002)(186003)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ZfLDjAoD8Cl0+aOhYpm2Vw09CxhN7S36oqZCuClzK82NLG4PAeLO1UwcAox7nnb7MOf0++pwKxpkCBbZuaPryjcfRrVkA/yCQk3WOP/lnIfOQf7x4O49mBaCPowL3bNgCf4T5iTmYejaR3xIi8kJko3SbE4muNLpLXAXrbLyogN6ZJLbkz6TUTXoLfjK2wxFc7ZUgaUg0lS7H23FOfbcK+4BWgwT4bMxHinYt02cGgx0jX3i4T8r7xm1DiYNp4QuPyDp6gmbdabxIt3veYNtrFN7nEc4iECxoiMz1oBE8RwIDdaB2fxLX7kLvjqan7fAF2bheboTz7RDueHCAGPdjWpFaPcF+GjY81LZSrk8Z2HcGg3sa0Cbvd4kB1n0lrsnlYNyOj1Kfm+IhLB2unyy50M7neYPsWGMKXNjCmvZNblRApzA52ub0TJAQEtdlrjjENvuiud9ZT1ybUamB4vNhLVRs5XykAbF8xRLOi5ABU8aa2rIIhXd50kin4Qwsjxy
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381165dc-10a3-427d-9060-08d81ca0aa79
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 02:52:45.0804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZpxeOOKEM6mq/dlVH7cA0FfiBZI4jx74nF4pO25JqSlxDlJza1dcGziTrDi0JpbAG7lDM779yg6m9cGKQLW7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1455
X-OriginatorOrg: intel.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

> From: Jacob Pan
> Sent: Tuesday, June 30, 2020 7:05 AM
> 
> On Fri, 26 Jun 2020 16:19:23 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > On Tue, 23 Jun 2020 10:03:53 -0700
> > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> >
> > > IOMMU UAPI is newly introduced to support communications between
> > > guest virtual IOMMU and host IOMMU. There has been lots of
> > > discussions on how it should work with VFIO UAPI and userspace in
> > > general.
> > >
> > > This document is indended to clarify the UAPI design and usage. The
> > > mechenics of how future extensions should be achieved are also
> > > covered in this documentation.
> > >
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > ---
> > >  Documentation/userspace-api/iommu.rst | 244
> > > ++++++++++++++++++++++++++++++++++ 1 file changed, 244 insertions(+)
> > >  create mode 100644 Documentation/userspace-api/iommu.rst
> > >
> > > diff --git a/Documentation/userspace-api/iommu.rst
> > > b/Documentation/userspace-api/iommu.rst new file mode 100644
> > > index 000000000000..f9e4ed90a413
> > > --- /dev/null
> > > +++ b/Documentation/userspace-api/iommu.rst
> > > @@ -0,0 +1,244 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +.. iommu:
> > > +
> > > +=====================================
> > > +IOMMU Userspace API
> > > +=====================================
> > > +
> > > +IOMMU UAPI is used for virtualization cases where communications
> > > are +needed between physical and virtual IOMMU drivers. For native
> > > +usage, IOMMU is a system device which does not need to communicate
> > > +with user space directly.
> > > +
> > > +The primary use cases are guest Shared Virtual Address (SVA) and
> > > +guest IO virtual address (IOVA), wherein a virtual IOMMU (vIOMMU)
> > > is +required to communicate with the physical IOMMU in the host.
> > > +
> > > +.. contents:: :local:
> > > +
> > > +Functionalities
> > > +===============
> > > +Communications of user and kernel involve both directions. The
> > > +supported user-kernel APIs are as follows:
> > > +
> > > +1. Alloc/Free PASID
> > > +2. Bind/unbind guest PASID (e.g. Intel VT-d)
> > > +3. Bind/unbind guest PASID table (e.g. ARM sMMU)
> > > +4. Invalidate IOMMU caches
> > > +5. Service page requests
> > > +
> > > +Requirements
> > > +============
> > > +The IOMMU UAPIs are generic and extensible to meet the following
> > > +requirements:
> > > +
> > > +1. Emulated and para-virtualised vIOMMUs
> > > +2. Multiple vendors (Intel VT-d, ARM sMMU, etc.)
> > > +3. Extensions to the UAPI shall not break existing user space
> > > +
> > > +Interfaces
> > > +==========
> > > +Although the data structures defined in IOMMU UAPI are
> > > self-contained, +there is no user API functions introduced.
> > > Instead, IOMMU UAPI is +designed to work with existing user driver
> > > frameworks such as VFIO. +
> > > +Extension Rules & Precautions
> > > +-----------------------------
> > > +When IOMMU UAPI gets extended, the data structures can *only* be
> > > +modified in two ways:
> > > +
> > > +1. Adding new fields by re-purposing the padding[] field. No size
> > > change. +2. Adding new union members at the end. May increase in
> > > size. +
> > > +No new fields can be added *after* the variable sized union in
> > > that it +will break backward compatibility when offset moves. In
> > > both cases, a +new flag must be accompanied with a new field such
> > > that the IOMMU +driver can process the data based on the new flag.
> > > Version field is +only reserved for the unlikely event of UAPI
> > > upgrade at its entirety. +
> > > +It's *always* the caller's responsibility to indicate the size of
> > > the +structure passed by setting argsz appropriately.
> > > +Though at the same time, argsz is user provided data which is not
> > > +trusted. The argsz field allows the user to indicate how much data
> > > +they're providing, it's still the kernel's responsibility to
> > > validate +whether it's correct and sufficient for the requested
> > > operation. +
> > > +Compatibility Checking
> > > +----------------------
> > > +When IOMMU UAPI extension results in size increase, user such as
> > > VFIO +has to handle the following cases:
> > > +
> > > +1. User and kernel has exact size match
> > > +2. An older user with older kernel header (smaller UAPI size)
> > > running on a
> > > +   newer kernel (larger UAPI size)
> > > +3. A newer user with newer kernel header (larger UAPI size) running
> > > +   on an older kernel.
> > > +4. A malicious/misbehaving user pass illegal/invalid size but
> > > within
> > > +   range. The data may contain garbage.
> >
> > What exactly does vfio need to do to handle these?
> >
> VFIO does nothing other than returning the status from IOMMU driver.
> Based on the return status, users such as QEMU can cause fault
> conditions within the vIOMMU.

But from above description, "user such as VFIO has to handle the
following cases"...

Thanks
Kevin

> 
> > > +
> > > +Feature Checking
> > > +----------------
> > > +While launching a guest with vIOMMU, it is important to ensure
> > > that host +can support the UAPI data structures to be used for
> > > vIOMMU-pIOMMU +communications. Without upfront compatibility
> > > checking, future faults +are difficult to report even in normal
> > > conditions. For example, TLB +invalidations should always succeed.
> > > There is no architectural way to +report back to the vIOMMU if the
> > > UAPI data is incompatible. If that +happens, in order to protect
> > > IOMMU iosolation guarantee, we have to +resort to not giving
> > > completion status in vIOMMU. This may result in +VM hang.
> > > +
> > > +For this reason the following IOMMU UAPIs cannot fail:
> > > +
> > > +1. Free PASID
> > > +2. Unbind guest PASID
> > > +3. Unbind guest PASID table (SMMU)
> > > +4. Cache invalidate
> > > +
> > > +User applications such as QEMU is expected to import kernel UAPI
> > > +headers. Backward compatibility is supported per feature flags.
> > > +For example, an older QEMU (with older kernel header) can run on
> > > newer +kernel. Newer QEMU (with new kernel header) may refuse to
> > > initialize +on an older kernel if new feature flags are not
> > > supported by older +kernel. Simply recompile existing code with
> > > newer kernel header should +not be an issue in that only existing
> > > flags are used. +
> > > +IOMMU vendor driver should report the below features to IOMMU UAPI
> > > +consumers (e.g. via VFIO).
> > > +
> > > +1. IOMMU_NESTING_FEAT_SYSWIDE_PASID
> > > +2. IOMMU_NESTING_FEAT_BIND_PGTBL
> > > +3. IOMMU_NESTING_FEAT_BIND_PASID_TABLE
> > > +4. IOMMU_NESTING_FEAT_CACHE_INVLD
> > > +5. IOMMU_NESTING_FEAT_PAGE_REQUEST
> > > +
> > > +Take VFIO as example, upon request from VFIO user space (e.g.
> > > QEMU), +VFIO kernel code shall query IOMMU vendor driver for the
> > > support of +the above features. Query result can then be reported
> > > back to the +user-space caller. Details can be found in
> > > +Documentation/driver-api/vfio.rst.
> > > +
> > > +
> > > +Data Passing Example with VFIO
> > > +------------------------------
> > > +As the ubiquitous userspace driver framework, VFIO is already IOMMU
> > > +aware and share many key concepts such as device model, group, and
> > > +protection domain. Other user driver frameworks can also be
> > > extended +to support IOMMU UAPI but it is outside the scope of this
> > > document. +
> > > +In this tight-knit VFIO-IOMMU interface, the ultimate consumer of
> > > the +IOMMU UAPI data is the host IOMMU driver. VFIO facilitates
> > > user-kernel +transport, capability checking, security, and life
> > > cycle management of +process address space ID (PASID).
> > > +
> > > +Unlike normal user data passed via VFIO UAPI IOTCL, IOMMU driver
> > > is the +ultimate consumer of its UAPI data. At VFIO layer, the
> > > IOMMU UAPI data +is wrapped in a VFIO UAPI data. It follows the
> > > +pattern below::
> > > +
> > > +   struct {
> > > +	__u32 argsz;
> > > +	__u32 flags;
> > > +	__u8  data[];
> > > +   };
> > > +
> > > +Here data[] contains the IOMMU UAPI data structures. VFIO has the
> > > +freedom to bundle the data as well as parse data size based on its
> > > own flags. +
> > > +In order to determine the size and feature set of the user data,
> > > argsz +and flags are also embedded in the IOMMU UAPI data
> > > structures. +A "__u32 argsz" field is *always* at the beginning of
> > > each structure. +
> > > +For example:
> > > +::
> > > +
> > > +   struct iommu_cache_invalidate_info {
> > > +	__u32	argsz;
> > > +	#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
> > > +	__u32	version;
> > > +	/* IOMMU paging structure cache */
> > > +	#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /*
> > > IOMMU IOTLB */
> > > +	#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 << 1) /*
> > > Device IOTLB */
> > > +	#define IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /*
> > > PASID cache */
> > > +	#define IOMMU_CACHE_INV_TYPE_NR		(3)
> > > +	__u8	cache;
> > > +	__u8	granularity;
> > > +	__u8	padding[2];
> > > +	union {
> > > +		struct iommu_inv_pasid_info pasid_info;
> > > +		struct iommu_inv_addr_info addr_info;
> > > +	} granu;
> > > +   };
> > > +
> > > +VFIO is responsible for checking its own argsz and flags then
> > > invokes +appropriate IOMMU UAPI functions. User pointer is passed
> > > to IOMMU +layer for further processing. The responsibilities are
> > > divided as +follows:
> > > +
> > > +- Generic IOMMU layer checks argsz range and override out-of-range
> > > +  value. If the exact argsz is based on generic flags, they are
> > > checked
> > > +  here as well.
> > > +
> > > +- Vendor IOMMU driver checks argsz based on vendor flags, UAPI data
> > > +  is consumed based on flags
> > > +
> > > +Once again, use guest TLB invalidation as an example, argsz is
> > > based +on generic flags in the invalidation information. IOMMU
> > > generic code +shall process the UAPI data as the following:
> > > +
> > > +::
> > > +
> > > + int iommu_cache_invalidate(struct iommu_domain *domain, struct
> > > device *dev,
> > > +			void __user *uinfo)
> > > + {
> > > +	/* Current kernel data size is the max to be copied from
> > > user */
> > > +	maxsz = sizeof(struct iommu_cache_invalidate_info);
> > > +	memset((void *)&inv_info, 0, maxsz);
> > > +
> > > +	/*
> > > +	 * No new spaces can be added before the variable sized
> > > union, the
> > > +	 * minimum size is the offset to the union.
> > > +	 */
> > > +	minsz = offsetof(struct iommu_cache_invalidate_info,
> > > granu); +
> > > +	/* Copy minsz from user to get flags and argsz */
> > > +	if (copy_from_user(&inv_info, uinfo, minsz))
> > > +		return -EFAULT;
> > > +
> > > +	/* Fields before variable size union is mandatory */
> > > +	if (inv_info.argsz < minsz)
> > > +		return -EINVAL;
> > > +	/*
> > > +	 * User might be using a newer UAPI header which has a
> > > larger data
> > > +	 * size, we shall support the existing flags within the
> > > current
> > > +	 * size.
> > > +	 */
> > > +	if (inv_info.argsz > maxsz)
> > > +		inv_info.argsz = maxsz;
> > > +
> > > +	/* Checking the exact argsz based on generic flags */
> > > +	if (inv_info.granularity == IOMMU_INV_GRANU_ADDR &&
> > > +		inv_info.argsz != offsetofend(struct
> > > iommu_cache_invalidate_info,
> > > +					granu.addr_info))
> >
> > Is it really reasonable to expect the user to specify argsz to the
> > exact union element for the callback?  I'd certainly expect users to
> > simply use sizeof(struct iommu_cache_invalidate_info) and it should
> > therefore be sufficient to test >= here rather than jump through hoops
> > with an exact size.  We're already changing inv_info.argsz above to
> > fit our known structure, it's inconsistent to then expect it to be
> > some exact value.
> >
> I was thinking argsz doesn't have to be the exact struct size. It should
> be whatever the sufficient & correct size used by the user for a given
> call.
> 
> For example, current struct iommu_gpasid_bind_data {} only has VT-d
> data. If it gets extended with SMMU data in the union, VT-d vIOMMU
> emulation should only fill the union size of vt-d.
> 
> > > +		return -EINVAL;
> > > +
> > > +	if (inv_info.granularity == IOMMU_INV_GRANU_PASID &&
> > > +		inv_info.argsz != offsetofend(struct
> > > iommu_cache_invalidate_info,
> > > +					granu.pasid_info))
> > > +		return -EINVAL;
> > > +
> > > +	/* Copy the remaining user data _after_ minsz */
> > > +	if (copy_from_user((void *)&inv_info + minsz, uinfo +
> > > minsz,
> > > +				inv_info.argsz - minsz))
> > > +		return -EFAULT;
> > > +
> > > +	return domain->ops->cache_invalidate(domain, dev,
> > > &inv_info);
> > > + }
> > > + Add a wrapper
> > > +   __iommu_unbind_( kernel data, same user data, kernel copy)
> > > +
> This should be removed. Sorry about the confusion. The patch does not
> have two data pointers, just separate APIs for kernel and user.
> 
> > > +Notice that in this example, since union size is determined by
> > > generic +flags, all checking to argsz is validated in the generic
> > > IOMMU layer, +vendor driver does not need to check argsz. However,
> > > if union size is +based on vendor data, such as
> > > iommu_sva_bind_gpasid(), it will be +vendor driver's responsibility
> > > to validate the exact argsz.
> >
> > struct iommu_cache_invalidate_info is a good example because it
> > explicitly states a table of type vs granularity validity.  When the
> > cache_invalidate() callback is used by an internal user we can
> > consider it a bug in the caller if its usage falls outside of these
> > prescribed valid combinations, ie. iommu_ops callbacks may assume a
> > trusted caller that isn't trying to exploit any loophole.
> Separate APIs are proposed in the patchset to address UAPIs
> with both kernel and user callers. Sorry about the last line in the
> example above. Currently, only unbind_gpasid() and page_response() have
> both kernel and userspace callers. e.g.
> 
>    /* userspace caller */
>    int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct
> device *dev,
> 			void __user *udata)
> 
>    /* in-kernel caller */
>    int __iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct
> device *dev,
>                                  struct iommu_gpasid_bind_data *data)
> 
> We don;t expect in-kernel caller for cache invalidate in that it is
> implied in unmap, unbind operations.
> 
> >  But here
> > we've done nothing more than validated the supplied size to pass it
> > through to a non-user hardened callback.  We didn't check the
> > version,
> Yes, I should move up the version check from vendor driver.
> 
> > we didn't check that any of the undefined bits in cache or
> > granularity or padding were set, we don't know what flags might be
> > set in the union elements.
> You are right, we should sanitize reserved bits.
> 
> > For example, if a user is able to set a
> > flag that gets ignored now, that means we can never use that flag
> > without potentially breaking that user in the future.
> Good point, all reserved/unused bits should be tested.
> 
> >  If a user can
> > pass in version 3141592654 now, then we can never use version for
> > validation.  I see that intel_iommu_sva_invalidate() does test the
> > version, but has no obvious other hardening.  I'm afraid we're being
> > far to lax about accepting a data structure provided by a user, we
> > should not assume good faith. Thanks,
> >
> Agreed. will add checks in the IOMMU generic layer for reserved
> bits.
> For VT-d vendor driver, we do check all bits in cache types, i.e. in
> intel/iommu.c
> 	for_each_set_bit(cache_type,
> 			 (unsigned long *)&inv_info->cache,
> 			 IOMMU_CACHE_INV_TYPE_NR) {
> 
> 
> one other hardening is to check vendor argsz. This is in the
> bind_gpasid call.
> 
> 	if (data->argsz != offsetofend(struct iommu_gpasid_bind_data,
> vendor.vtd))
> 		return -EINVAL;
> 
> 
> 
> > Alex
> >
> 
> [Jacob Pan]
> 
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471E7C433E0
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 03:57:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85FE22510
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 03:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85FE22510
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7F4AD8698C;
	Wed, 23 Dec 2020 03:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZR5ikH8qseOK; Wed, 23 Dec 2020 03:57:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 80AFA86970;
	Wed, 23 Dec 2020 03:57:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FD4FC1787;
	Wed, 23 Dec 2020 03:57:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D5C1C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 03:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4A284872B7
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 03:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yKnvJ3cg60tq for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 03:57:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 93475872A1
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 03:57:50 +0000 (UTC)
IronPort-SDR: V2stIdKeFC0U4Wt5uTjXwOzKLdYcbQzdDzvZ+EWKjzPpju1Y3Fyw7im6b6L+YFxDavCVagGlZF
 BGSH4cezwD2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="175182924"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; d="scan'208";a="175182924"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2020 19:57:48 -0800
IronPort-SDR: pF6VLFS91y9vj7JvVCGFNvfSS/CxmtETiFVXE94/K/t7zYzbtl4pzOXoezRiN89K7XP4N0m2ue
 48md6GvV2grQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; d="scan'208";a="373804266"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by orsmga008.jf.intel.com with ESMTP; 22 Dec 2020 19:57:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Dec 2020 19:57:47 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Dec 2020 19:57:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Dec 2020 19:57:47 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.57) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 22 Dec 2020 19:57:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xrwp5to+2VWy3759QqhV0+UKc4OGygBskZqVpn+NdleyHjcnwcR24b/nU+8a31X4ZjuIKiOVfitRifN1P89reeBh8zCafPxgAY0jQHSDEKf1rB4cPps1CUuAZwbVl8FTpdjh208E7QaF2xiXx0PN7BZF+aPBncIqo4oq5X7RmECmjtl4KNm/7c8QHJanu5kHYP3U7s7OiRlgTuTpshw411xS0Xv6LyRQK07Z/fCbH+DOT56TezJvpUZvhH6ILoP1ssNdQfGBN3C7WcIMkZmA9dRZlEi3VReHRClHpkjwExXGNCH23u9TL6r/bul/KEcZp55KSrld39QdGPSxynp6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTC/zs1X+R8jqjybiOyfWDji15+x7YNLBtODy68K8qk=;
 b=Mu1svuL3vM2Fzb1/Xvhc89ODTTMHzzwpkb6IyDq+KD/EQWu/HP7VIuYiqQCUsN8wm5ZdSAt1Kb/1NIq+S8vUTiG5fuZgaQP7VVeGk9bxr025oilK0thvWJgPW76Ba/BXE5RuZr4jsZ7eLjzoqDRliqRqcBklzPl0he2RRBUbK4jtJThjfD8W/aT9VNsEJjzCMIBL6e7wSp4E4Z1hPWEATBg3wnatBNYy/Iph/DiSj/HWpacj7CjU6/Pohpkjwo4hrYsPvXejBsPISZwxCNHMbhvKls93dVyGMTMCoEaiaC6Jlsr5nTr0QDtUb1V+FsARZgSy6zZIU9LT9cXsHu+K0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTC/zs1X+R8jqjybiOyfWDji15+x7YNLBtODy68K8qk=;
 b=TGCd4cJS8LM9sHVblVgeDD63vGRsB2Nt8DHK1nY3Ld39XtKyESsIlPdIeVuZHfMSomtLgV3884ZAWGgsxEk5RKX4Kwu4wz6FBqyUxIWvLIys4ue5mb0z6q12E2AWHR0JL/yGTm9DWnzUTB6E+7s1UnqyUdufr3Yanozvzora+EM=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4347.namprd11.prod.outlook.com (2603:10b6:5:200::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.33; Wed, 23 Dec 2020 03:57:45 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93%3]) with mapi id 15.20.3676.033; Wed, 23 Dec 2020
 03:57:45 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: RE: [PATCH 0/4] iommu/vtd-: Misc fixes on scalable mode
Thread-Topic: [PATCH 0/4] iommu/vtd-: Misc fixes on scalable mode
Thread-Index: AQHW1Zp8+YcVmfV6hUWaXX2Ndu0KbKoDchUAgACiCnA=
Date: Wed, 23 Dec 2020 03:57:44 +0000
Message-ID: <DM5PR11MB1435B04165AAE6DDFBB94298C3DE0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <20201220000352.183523-1-yi.l.liu@intel.com>
 <20201222101702.0e236af8@jacob-builder>
In-Reply-To: <20201222101702.0e236af8@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e3f9e7d-5246-42d3-deda-08d8a6f6e7cc
x-ms-traffictypediagnostic: DM6PR11MB4347:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4347C3320BA0D18D0B89367EC3DE0@DM6PR11MB4347.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +wHHZtlw/m3Ky7X+QzSLOTm621UDqhMTzsWVf8VwihWdIvH0t0mWGBuJ22IuucDLCppK5oVOd5DFinIyuNHCFsX1ELp1zpJ4cYk3vyv29WS+ciz/3jBtYacmPSaIxNXgHxToGsT2GE8aTLM55blxs6FRCxNUKuzTV6W58Qau+7BAcDaKlHrls0yGm/u9D27AGpgjXKDYTanLdDv3PtVLkWixnMTyYIolDKyoTnfdA3ls64Lrd6aJU1tNO1kRzDZmt8n5ljdSOmVSCphoVyClAbbieksLkSQJfNMe8g1TQrzWxwG9yLHBLKdnPawDM/UrZtr0poTfz6Wq1E/R2nR3ibskHTxv6yyWEH3O+mb3vlR9mz2/fJaH51GsZ4J3PxDFwRwOJS6JAegpb1SFeio+fw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(6506007)(5660300002)(4326008)(66446008)(8676002)(478600001)(64756008)(8936002)(26005)(186003)(52536014)(66556008)(66946007)(76116006)(6636002)(66476007)(316002)(71200400001)(55016002)(54906003)(6862004)(2906002)(9686003)(33656002)(83380400001)(86362001)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nqKEgb6Gkb8sHhLpCAQyHiMqrkHfndodwZPDBJoWbhfpyrqJTErsJ5JJioZk?=
 =?us-ascii?Q?UmyrF6lThe+vJCzNVDXZ4u7yitDehX3A3JvY/2qvdWSY5+1+lomu7miQZ1N3?=
 =?us-ascii?Q?hp1L5y+mwTotbSgpfHb/H6iWgAliIfMhPOAj1oYNyXR0OLieUfqZPsidJp84?=
 =?us-ascii?Q?Zly2GRm8VrO4RjFvzISF/HDrj2xNCDMbM9fdIqNuikPbutE3nOSLFMpjlKIP?=
 =?us-ascii?Q?nzxjpGGNwsuIYSRb1YI3likDJBGkn/6hJ8IEOQRNosO01W/XM5TT1HQRd/UZ?=
 =?us-ascii?Q?tV3VqmDirRBM/ZQjAh94LRRDXPbcymOpvpim1NirHvAKmilskrn3IOdmFjUF?=
 =?us-ascii?Q?jF7/4mJojBVkbCkxpw7gtUfXQ0VdYhhY0feiWFu8FgBz9rcGTqKhc73/ZQ/I?=
 =?us-ascii?Q?PbVO4sddSg7CvZpYPPOB1LomlY1Geq2grHQgqjs0ZSWPPHtW2soHO3+2CHFd?=
 =?us-ascii?Q?SgxZYX+Zvwq6nZfoUw39oobFLjL7LhbQIolvp0qPk4Gv0ODRL8+PZta8ToIk?=
 =?us-ascii?Q?VDWZW/ypr1sDddrAC3qa7HxsI7aNhsBqsf92L/bMaZDt4Hf5/23pmtcOt7kD?=
 =?us-ascii?Q?LahynQoFJGbE2qRh8rPr6KHOySR3USQqewkHfYQY9wqZHZWIPivsiJvmpmd9?=
 =?us-ascii?Q?BXEtcPwaCWwxhaqiUDYgKmLVXrEJ4h0uueENphtKb5fcW6F0nVvQ0Sxx6HP7?=
 =?us-ascii?Q?djwqIASJD42pqJIle+tU1Jz9YFGvPTUfxvzY5GhyzmLj2f6/a7bPRcNxtGV5?=
 =?us-ascii?Q?j+JK0tRgMPV7HQC/aEYe94pAmTJY1+aqjNg9pX5+1v5uzdO6XlM27eE4v+Ae?=
 =?us-ascii?Q?rIJ9l8uXosW660E7+G+XF/zc3/kdAniG2UPPs3+NYy9BMQvivbfQAdoPrOJf?=
 =?us-ascii?Q?D0ln9JTIbUL2lowmXYXnuP3g5IqTEW7uD0of6ZIzB+4BE/MAthm8jz6lZ4J5?=
 =?us-ascii?Q?bgMk8fRUXEnp0Y8kZbJYFUzRt6/D+o7vU5/3U2GL8dk=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3f9e7d-5246-42d3-deda-08d8a6f6e7cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2020 03:57:45.2374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rfXD2r5759mtor046vxJYIpC6GQW2xDLKLhKDRt2CJhBxLiHmYt4yVxdE7GE4Sy9QIQ9eJeLX+mUYbspF/j0LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4347
X-OriginatorOrg: intel.com
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Guo, Kaijie" <kaijie.guo@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, "will@kernel.org" <will@kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>
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

> From: Jacob Pan <jacob.jun.pan@intel.com>
> Sent: Wednesday, December 23, 2020 2:17 AM
> 
> Hi Yi,
> 
> nit: The cover letter is 0/4, patches are 1/3 - 3/3. You also need to copy
> LKML.
> 
> On Sun, 20 Dec 2020 08:03:49 +0800, Liu Yi L <yi.l.liu@intel.com> wrote:
> 
> > Hi,
> >
> > This patchset aims to fix a bug regards to SVM usage on native, and
> perhaps 'native SVM usage'

got it. thanks. will correct it.

Regards,
Yi Liu

> > also several bugs around subdevice (attached to device via auxiliary
> > manner) tracking and ineffective device_tlb flush.
> >
> > Regards,
> > Yi Liu
> >
> > Liu Yi L (3):
> >   iommu/vt-d: Move intel_iommu info from struct intel_svm to struct
> >     intel_svm_dev
> >   iommu/vt-d: Track device aux-attach with subdevice_domain_info.
> >   iommu/vt-d: A fix to iommu_flush_dev_iotlb() for aux-domain
> >
> >  drivers/iommu/intel/iommu.c | 182 ++++++++++++++++++++++++++++++---
> ---
> >  drivers/iommu/intel/svm.c   |   9 +-
> >  include/linux/intel-iommu.h |  13 ++-
> >  3 files changed, 168 insertions(+), 36 deletions(-)
> >
> 
> 
> Thanks,
> 
> Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

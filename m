Return-Path: <SRS0=sTZ6=KD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFD9C433B4
	for <iommu@archiver.kernel.org>; Sat,  8 May 2021 06:08:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D782B61466
	for <iommu@archiver.kernel.org>; Sat,  8 May 2021 06:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D782B61466
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5046940FAB;
	Sat,  8 May 2021 06:08:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zwSbfRhSa_e6; Sat,  8 May 2021 06:08:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA29840460;
	Sat,  8 May 2021 06:08:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1461C000E;
	Sat,  8 May 2021 06:08:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2193C0001
 for <iommu@lists.linux-foundation.org>; Sat,  8 May 2021 06:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A624560865
 for <iommu@lists.linux-foundation.org>; Sat,  8 May 2021 06:08:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zgueRNdnIM78 for <iommu@lists.linux-foundation.org>;
 Sat,  8 May 2021 06:08:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B96C60816
 for <iommu@lists.linux-foundation.org>; Sat,  8 May 2021 06:08:39 +0000 (UTC)
IronPort-SDR: hosoqWqwrBXECJ4AOOUP7ebfAZzD+za32mfUSBo6kUKf2ZxaK7JEe5SfcNm9JwP13Ef9nwwhWN
 d7Tfk3CxKZyA==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="179122965"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; d="scan'208";a="179122965"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2021 23:08:38 -0700
IronPort-SDR: rdtVE+b95ESbVZ1rlTR0N2lmyNVMu4h9u61sZb6BOVoE2ZjknI6ibjgY2BXpBE+ySkxwBFar/u
 3cUrfN/lQI7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; d="scan'208";a="429259767"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga007.jf.intel.com with ESMTP; 07 May 2021 23:08:37 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 7 May 2021 23:08:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 7 May 2021 23:08:37 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.53) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 7 May 2021 23:08:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTSlU0GwRiMf1DVlhWqFfRKBpbJgjp3UIOHDCgAFMBIT8ZZlPgy7CkOe+I968ftwUS3ypaGOhxtLe4Y3FmOM2Bivh2+lcaZ+qQYbOoLe2VOPigVud5ELFoxuHroNifz/Ne/5nf37oad2bAt+ixwzW9UOo9cL5KxLzkYg2s6S2TXIlQGcwY5tCTkHvVBI1da7G014aWjOe8qMVnQLF+DNCW5YvZHU+7KmfZrcfawqJ5xQZqGlSPgsq8886gy81JLXHJq0e59Au3kP0nhoUWYgCm6COaHMvtY3fDPXr0qPhYcWEouYyypXDCYOq1xpOVwqo9giXr+wBH/SDJa0jQeCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yqo3eb9LzAey9MiOlLfk8TglM0+/Z6/LA4tC2Xy7O7w=;
 b=iR3ahGPG8eP/DO2lnDNpGNJl8NVsIpePdQQWZWDqBRSV0LEm/8rJZ7WpAeCYuQXaxxV5u7WWdJiImrGtE9l9Jc4yhBCRwoE04NZgWxNAtNz7eVGv9KJqWoKsX/wFRiEq4wutFvMZpaedp4WUdQbPkOMEk4+yZHRfXm+0368uPG506HLsjpi44U4OQKStA9KgR4wAdjxKC42mouPctOEjoUO30kdu6uN59C5xBBXjp+5mchr1rBqRZKnmtghgmYMJGGH1B63cYE8oloac55hZ0E5QDUCGvUdalX7v5lg53B90drO3Gy22NX3cWkum2B2yRpT38tFG9LGHh0zS9UIEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yqo3eb9LzAey9MiOlLfk8TglM0+/Z6/LA4tC2Xy7O7w=;
 b=BtDm7BAwl1hfYjwmv4G6k5qPx3u7p7CBpdA6HOyIFqW6qsmHJZBVYb87vMqc2VSRR6dSxd5neyZPc4YcXCLTeKQRwXCEoBmxm/xK+09lLG/2qzCdxQhLe9v0dzuneiMM6kJ7aiQYIf0yi63npLsS4h95UwYp/UmiAnxtu8Pxghs=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Sat, 8 May
 2021 06:08:34 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4108.030; Sat, 8 May 2021
 06:08:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIAAk6nQgABIUACAASsnkIAAYWwAgALs9qCAAdeZgIACip7wgADDb4CADZr84IAAq3oAgAABSQCAANNLkA==
Date: Sat, 8 May 2021 06:08:33 +0000
Message-ID: <MWHPR11MB1886473A749033F404DA08A68C569@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210428090625.5a05dae8@redhat.com>
 <MWHPR11MB1886E0A7897758AA7BE509058C579@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210507110614.7b8e6998@redhat.com> <20210507171050.GV1370958@nvidia.com>
In-Reply-To: <20210507171050.GV1370958@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.80.65.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98fab634-aa57-4f41-146c-08d911e7b617
x-ms-traffictypediagnostic: CO1PR11MB5154:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB51546DD225E741DE9B9C9EDD8C569@CO1PR11MB5154.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZOVEK5+Zp3Pf7Jcp6c5F/gcfVvOhEVPpmpZxWwX66DcEeVqqkFT02sNXPKL58dEG2g1O51McE9bxxmk8Xfia42N2+NtTkMcse1uTktkIk7LyZyw96/QPJ9cZHBxkA0QGvbp/OEhLdV65xW7c1eKj6BX+AHh0NDT6dmoCYYuX2ZtNIjB1J4WrCzudMHdJOdKm51k48ptKAihXVVKTZEjLQNjqv/INLoDOeQo/z+pdF7xzsGrbcw4IAV4MEk6/1XB+uJPdXK0Zro5Jh4rlSQ89CKtmkfcfQS+y6YoE/HV6jYsBPRPXG8G910KtPJMvH8gK+Aj6wmtVLXSYuJdROMGza07aruBocN+SUeqHxpdBghJ9BTCX8NUkbeLK6qUoZ67s7mxmJac2m538TFEtft3ziI67GqM5fnhAsdEGHs58PqmS62fc+UTu3js7XmdmK+ZQAy1aKkcMZueUG397dLHyfKUKYlqKqdqaHQltstcW5IiPRoOnKrE7QLW0RtQPbJwqVXx5/1Gzn41IVGW8n09ICCLfYXuEbwuzFvbrUutob+4DRojT7yvwt0sq/T3POYdnajJrsybjITwDhm8Y6Tfl/OBapx0vpCg1qMz/D/2n7K0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(396003)(39860400002)(136003)(366004)(376002)(52536014)(186003)(66446008)(316002)(7696005)(5660300002)(86362001)(33656002)(71200400001)(26005)(478600001)(7416002)(54906003)(110136005)(38100700002)(8676002)(122000001)(2906002)(8936002)(9686003)(55016002)(6506007)(66476007)(66946007)(64756008)(66556008)(76116006)(4326008)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?D8v950FQKN+Q5T10lMcs2aVLa9TNaPLd2WcVna+FPdTnMtoVmmwtjDx2ra1o?=
 =?us-ascii?Q?WMMFz+oQO//1emnHoiE6B1oRcpLltO3HTg6UBUjXt0B5EFnJdT9iBFmcDbqt?=
 =?us-ascii?Q?o3v23aUmPTm960EFtwgyTdyzVxGfPlGalUj05E39vQfpefXrpE9Z2Vha8iwL?=
 =?us-ascii?Q?dGZDn3KYa6MMdujwEjmOSCo40XBzIOVoPef5VLIDGb/SkLkrKSyegh7JDYiy?=
 =?us-ascii?Q?NwP7J/gU/CdgMjJMXRnXeoOw+c/7SP1GiiT2GgE6FY9I+p0yxHA56oEuW+pw?=
 =?us-ascii?Q?bjyeYKF9rxIVhah19rrOf6bIe+96Rf2EvEoCPvoRHhDUa6A/wT9e916V0msW?=
 =?us-ascii?Q?0BW0faI4pSiKSuDv/tk3bfwfiahgqOYJyFqSAPTR7mpx72p3QmEViz+YlXT6?=
 =?us-ascii?Q?a5LZpSJhnuHdqkuKBQjj9kMhs2yO4UvxQXf8ewLxTj3ZYRrTOt6PKEx+w4nR?=
 =?us-ascii?Q?h/mwDxmtsVSY/lU9SrgHz3sh4dvCeFdMncTBdS6iZalEThTWQ+yOClJ7WtOn?=
 =?us-ascii?Q?LGGZseCWB2N8V2VY8bV28bmBKyPxm/Fy/J3RBJNL8p0LYXBiEWD8bwDJBZ3H?=
 =?us-ascii?Q?3t9Zrmpmeh98zvpyhFH+0c2Doz5sXtaPQQ9rMoiQ8wuSOk1Fb3Rj4VsOGWoI?=
 =?us-ascii?Q?pPDAMcmkwkw4t50UITqmu07O0N8+ccSII7JZ3qs2Kk3r1+nwmwrEJnLcRe8k?=
 =?us-ascii?Q?giDcDUiJU3aS+tBScZibcba/6H7133T8lbTwOXxIAoUXyiQiYs4vf4MMyFR5?=
 =?us-ascii?Q?Q1lvLlT0fNxauFASgofRwwcf4SZnhkpC4ZeJlf06VqRHaCAMY+MF8TzWOpII?=
 =?us-ascii?Q?JZ7q1G1b8XivfNO0RA9LK6/SYSpHjH6bJgB8mmc+VQSqF56XPc1hSUsbBl0x?=
 =?us-ascii?Q?SyCrsy7G2gjcpiUoA7/VK5a12oWHBJBVqoDPqTygaTx3NmxHfPlG64JCnEK3?=
 =?us-ascii?Q?Ye/rPPIVqlTZXVr9WZaHKZDzT5Z3hgFbo90vgtoTTT32PcFOxI2DotESiv4j?=
 =?us-ascii?Q?j1TIm/bRTiZcwdwGZJRQz6g6zAyGgfVK1Q+3dom3i2atIgmlUs9QkznH/R9u?=
 =?us-ascii?Q?54fam0MogZBFGpSavawOvBzRIcPDmsAKkGq1YdKuZ2Y2BtaO4ikXJHIec7va?=
 =?us-ascii?Q?vhFtVObSFBYzibIzHfEFA+6laEzz5LCN9uSk2SoBnu/NFeK+SuQnW+i7mDXf?=
 =?us-ascii?Q?SBZB6NXZx1l5ZWPxjP9Q5GgsjyLGhH2UUo4W4yymV1N/24hfVk2uq1NQ4sNY?=
 =?us-ascii?Q?rJpJBCaTc/cw1v7EVqpvyd100ye2Dcp6MQQzFyojTbOoC5YiKClyw0t6t9Z3?=
 =?us-ascii?Q?/Y4=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fab634-aa57-4f41-146c-08d911e7b617
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2021 06:08:33.8010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wv0DsbclcilywVBp8g0JLAxoSLucLHz7Z6Ql7Uz+oEyjLc1SHxFhhYqUvfQu+l57nFaJR4DvveGOH2zcYVCckQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Wu, Hao" <hao.wu@intel.com>
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

> From: Jason Gunthorpe
> Sent: Saturday, May 8, 2021 1:11 AM
> 
> On Fri, May 07, 2021 at 11:06:14AM -0600, Alex Williamson wrote:
> 
> > We had tossed around an idea of a super-container with vfio, it's maybe
> > something we'd want to incorporate into this design.  For instance, if
> > memory could be pre-registered with a super container, which would
> > handle the locked memory accounting for that memory, then
> > sub-containers could all handle the IOMMU context of their sets of
> > devices relative to that common memory pool.
> 
> This is where I suggested to David to use nesting of IOASIDs.
> 
> Without HW support for nesting a SW nest is really just re-using the
> memory registration information stored in the parent when constructing
> the children
> 

yes, this sounds a sensible thing to do. it also unifies the user experience
regardless of whether the underlying hw supports nesting, e.g. when 
vIOMMU is present Qemu can always use IOASID nesting uAPI. In case
of SW nest then the kernel will merge the two-level translations from two
IOASIDs into one-level shadow page table (unlike today's VFIO which has 
the userspace to manage shadow-based mapping). 

but want to remark that nesting IOASIDs alone cannot solve this accounting
problem completely, as long as a process is allowed to have multiple ioasid
FDs (unless there is a mechanism to allow nesting IOASIDs cross FDs). But
this is probably not a big issue. With all the intended usages around the
new interface, I think for most applications one ioasid FD should be sufficient
to meet their requirements (multiple gpa_ioasids, ioasid nesting, etc.).

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

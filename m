Return-Path: <SRS0=1qmC=NX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C9EC432BE
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 06:56:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC8461074
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 06:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AAC8461074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 722B84022C;
	Wed,  1 Sep 2021 06:56:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qo1WngqxlFB4; Wed,  1 Sep 2021 06:56:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4E8F64028D;
	Wed,  1 Sep 2021 06:56:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1380AC0010;
	Wed,  1 Sep 2021 06:56:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02699C000E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 06:56:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9369823E8
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 06:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cCrtpMTWdAMx for <iommu@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 06:56:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9DCC823C0
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 06:56:12 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="198213640"
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; d="scan'208";a="198213640"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2021 23:56:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; d="scan'208";a="601518542"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by fmsmga001.fm.intel.com with ESMTP; 31 Aug 2021 23:56:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 31 Aug 2021 23:56:11 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 31 Aug 2021 23:56:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 31 Aug 2021 23:56:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 31 Aug 2021 23:56:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpq1tq+tr51jehWMTHCHH1uKDb+ocTAMon1428moZ1z6+cGsVcsK3SBX/wjHsrdO55MqxEE08yseqmsCRKrdDfzrTAGioY4oJWomxPG6bPtNKlVlKrxx/wyIKjx3thS8mNJ2EgZO1dtZsmGNEWjw0YUglWA/MuVxcgpfbvS2RdjUQoVLXEuCcSEjgMp90288d4bv9uNKDXNdPpC/AWXeX5WFhrzio709dtsu7/pbI1Ng3A6KFz9E1OaXnW9u3F7lwj4SA8Y8x2dNmMtYPk+vev4c9+3nG7rwiXCqd5OZ8y7kOG4cJyZP+jI7ez2Hd4HOUUaevO4HUYsC81XdaV9Qtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=iymCBrchEinG7L0Klxgq9Zb4Rfc+4qypI27wMDnZgQU=;
 b=UU9ojMrvq+KrFdSktRXpmF/8804x5FMP9ZQnt6ko5XnQLSvzRMRCOWhznfP4aHFn/ZkNSkfZg6c/09PqFD0AMEpDN9qXJ4D1DL1Uan6xejkEO9WzHATGIzdjT5PZ5A6qlp9Ye90vOXzrHxmoADwPPSmya9A2F6Khykl5rZ1jcm/TrjOKRD5Gl2t3IVMeCbmiyx/O3/YHCIZeEjhq+fsGva0YHnClYip4wX7r4I+epRdhEKleknU5o8FRQ+8uFD8yUpys9GNRigZ7GJaz+lC7oLoMYZuTCnyo2yzueQnv4VvyiktTBZGNdTeaGj983fY5aIAyJDJHEPJbasRwLMdJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iymCBrchEinG7L0Klxgq9Zb4Rfc+4qypI27wMDnZgQU=;
 b=O73iwYJBZTaGh9pv9/cKdSs0Xw00juNv/Nrs/00zPZZXVGksN3qc1uiyiPFj8MmSvk+8BBtQ7zC2crwQmkXTkZ2S48ehikvE2tTu7XD2A4+uUKKRC/lvUJG9Q9rxOV5zkkS36ObbgZDSHAZux9lNyesWAhQkcmf+7MYsGboRfzY=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN0PR11MB5711.namprd11.prod.outlook.com (2603:10b6:408:14b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Wed, 1 Sep
 2021 06:55:55 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%7]) with mapi id 15.20.4457.025; Wed, 1 Sep 2021
 06:55:55 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>
Subject: RE: [RFC][PATCH v2 00/13] iommu/arm-smmu-v3: Add NVIDIA implementation
Thread-Topic: [RFC][PATCH v2 00/13] iommu/arm-smmu-v3: Add NVIDIA
 implementation
Thread-Index: AQHXnhVovHekE4RvPUm07KSkZdD8O6uNysGAgADuWNA=
Date: Wed, 1 Sep 2021 06:55:55 +0000
Message-ID: <BN9PR11MB5433E064405A1AFEC50C1C9F8CCD9@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210831025923.15812-1-nicolinc@nvidia.com>
 <20210831101549.237151fa.alex.williamson@redhat.com>
In-Reply-To: <20210831101549.237151fa.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f32666a6-9fcc-4a7f-6c5c-08d96d158be5
x-ms-traffictypediagnostic: BN0PR11MB5711:
x-microsoft-antispam-prvs: <BN0PR11MB57116712087FBCEC9B94DE198CCD9@BN0PR11MB5711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rQ3xXrq3qrKxgJzVgF7Wi2wdDcDOvW7EJ0uoJY0D7aG4ucLEv+EAddqwMta2zM4hUYuiibt0cchtp6HsiEUxUgYxTy5v4pgkdUEVAq9pm4EFqB0pF1LYHZ5mbw76ulVSFB6s1sEgzFwObYNgSe/rIABlq+ONK0BqXqsoRTqnreoF5GQmQhS5dZsesGd2LnrhAZHEUcr1WT5PeAT1fA33Gpl6rwENqww1A1j4b2y1vnVs3Cg1NLvjDx/+Pu7ls/ojMxIZ8c14lTABD0O7umTXFDNvEA269M67f/iS/pwwki7hkO4nerY2o0e9/4az2j2sllJv9xwt8pKHPGDDdPN1Mpj1H6PRZorQRbq4ILqf4R1x1RRC5PzvIMAQlMwWmPuIPY+aV3vYVEqUdhOo++djfKFONtRJ0FK/T/GXnSZgWdTGTVe086lScOWrSb7+F9Vl5qdzuhyi+PpYt4Gy98fnr3Hd8tBQOBG9GmH0kaaAktlMg0uNdH8V0s7IhP2LYSYoD8E+rHYwdk7XCt0/pGN8D0HU39+ALw4ipXblmn78Bwof43c0/dsMKi48TQAhCCjmMXWG4ab3Arpdo0dSfa6vXK7HUTyLPcKewDhiXXhaDc18fIfe8PNRQA1rGXtnUfRMwWNW2+ivV7AGH0Sha+nPmQHyLQg1e/5lo0Q62vO4rRm+xEzkvOt7dv3OhRtRKe0o93Gvjui6roQxrJC0zw+KDIYHr2xNGXqcqSJ7Sil5ufMFNFZrxfMHU5bsopgj4CsUmKRjJcusy2LeA3YzNZ4w+80vrZcuVRvLEnu2v07ILepKt4pM1WZgG1nUWkLOl6gIuoYUuG8bUejvGsVqy5RVWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(186003)(86362001)(26005)(966005)(66946007)(122000001)(2906002)(52536014)(33656002)(45080400002)(5660300002)(71200400001)(83380400001)(508600001)(38100700002)(110136005)(316002)(8936002)(55016002)(54906003)(66556008)(64756008)(66446008)(4326008)(9686003)(66476007)(6506007)(76116006)(7416002)(7696005)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c6U711D11bNjHvtwTMxale9a4D/L72JI2iydJFk4CWx/AZrwfp3IPvAgpHis?=
 =?us-ascii?Q?t7fsokWJnGyU/NVcIALw6Q8VmI2WUdcxdJDm+9/d1SX4rYRdOhzRuYsmAtfi?=
 =?us-ascii?Q?nYHzmnxUG5+iluPlRwuV5Bf7m2pWJz+pdKD6lAfD4unKc/UUbYEb5bM09a1s?=
 =?us-ascii?Q?MG0Rx63xbN3QVZ4LQJzZ+uKigvoAgcblfxU146+EMLQRxPJFFbBnIE5nJt+/?=
 =?us-ascii?Q?shojd/X32BD2eEGjt9s7qd5zreQSjcYbU7kF0T0f2wFzd5afNRX2CvgL5NtG?=
 =?us-ascii?Q?IBzOq9KTvwpJTuCpKWG647qu0MQzz1cqOcVLBtdl68MQ4vTLkFIQ5WwIUYUP?=
 =?us-ascii?Q?AkgFj9Wfw4I/IP5Wo2EbwxVcD92O1pTVHQjAP3HndLz5+7fK44ag0ewwWgSF?=
 =?us-ascii?Q?evdMOeVEDt5TP+w2l5hUxvSvW4Huun3j3XUWQwyFK8weGNR6o5UpvQCLp1zi?=
 =?us-ascii?Q?uRt4RW/Xafq5+YYzLonZiL6zAszuknckZkTqz7eS3PM1kWavXuedOOP/5Qoz?=
 =?us-ascii?Q?MEnWshNhMjBChalmjAMsBYHiDFmZJ+APpKVao1MaOuP8IAV5Jd/CZsnqLbn6?=
 =?us-ascii?Q?NGw1FsXBDaiMAQ/PAO5VkTAiXTr4Oc0Ysh8C8Gk9kda1+FM0JkD4n759A1CA?=
 =?us-ascii?Q?k3umh6b0HKOJzGF3m9X58yi6tzt3YmW3haMIb/Lp/J7abImUOkOKA6/NBo6t?=
 =?us-ascii?Q?4MPFQMGca3dXOkBAiW5AnBr3akS23+4aDswPnU+I7u+Vv+LVCUW3jHEmeYKK?=
 =?us-ascii?Q?57rVXRVVD3RptOhZ/L0+pkONlog8MJZFTM5L5eyFaaTQEs1gv5K97e56duXv?=
 =?us-ascii?Q?g1JMqTFd4qa2NJt/CrYyAFIGs1EYSb85UOS+oMnm8GfJavt97ylI+kfj78Ur?=
 =?us-ascii?Q?2tL8gaS/i/Tdt5QVm5z8hV3bKkkbvZGdi1YgMHNYJPqen1f3ZC666o05WTev?=
 =?us-ascii?Q?UpE7Zzk4tmTBG7Qr0Z7MR8ZoV04bJR26g/bJuyZDeJqOQ0BtY0HojTh6+NnN?=
 =?us-ascii?Q?UPvdVSlp+QE2UcCQgA3GhKxOoIL2pBDL4i/28mXFLNDGUY50S3ZPivsL4bdQ?=
 =?us-ascii?Q?oQmiRFj4ZZAq3ZctDQ6xvWrJFzo601R/2GvDogQr7of2yfBztIZCixmzNtCf?=
 =?us-ascii?Q?hOTA/uAY/RUfP+FsXELmROVt3touWm2e3MKemkyJElFLoWrL/M1suYWH7lO1?=
 =?us-ascii?Q?TgU1IX802mLc2/OrNrgQbYJlk2zH4iYC2zNUOHXTjIRxQQBOKvFvM9XzbPFb?=
 =?us-ascii?Q?1X1Z0jN4lTDLt0Nyw+HE/+cV057F+/A62ZjY/sVCZmCC0AHrQVdgPaiCfEcu?=
 =?us-ascii?Q?wmf1koT5L0Wxj50h5HFY74q/?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32666a6-9fcc-4a7f-6c5c-08d96d158be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 06:55:55.7559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDfn8rDy+j7gLFQZWWOQX3NpG0XP2bkuCMLGGSZK992Rd8gQLWFOExtFJ7RORZuNy+7lAf9MjoM+KZWHR8GIyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5711
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "will@kernel.org" <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

> From: Alex Williamson
> Sent: Wednesday, September 1, 2021 12:16 AM
> 
> On Mon, 30 Aug 2021 19:59:10 -0700
> Nicolin Chen <nicolinc@nvidia.com> wrote:
> 
> > The SMMUv3 devices implemented in the Grace SoC support NVIDIA's
> custom
> > CMDQ-Virtualization (CMDQV) hardware. Like the new ECMDQ feature first
> > introduced in the ARM SMMUv3.3 specification, CMDQV adds multiple
> VCMDQ
> > interfaces to supplement the single architected SMMU_CMDQ in an effort
> > to reduce contention.
> >
> > This series of patches add CMDQV support with its preparational changes:
> >
> > * PATCH-1 to PATCH-8 are related to shared VMID feature: they are used
> >   first to improve TLB utilization, second to bind a shared VMID with a
> >   VCMDQ interface for hardware configuring requirement.
> 
> The vfio changes would need to be implemented in alignment with the
> /dev/iommu proposals[1].  AIUI, the VMID is essentially binding
> multiple containers together for TLB invalidation, which I expect in
> the proposal below is largely already taken care of in that a single
> iommu-fd can support multiple I/O address spaces and it's largely
> expected that a hypervisor would use a single iommu-fd so this explicit
> connection by userspace across containers wouldn't be necessary.

Agree. VMID is equivalent to DID (domain id) in other vendor iommus.
with /dev/iommu multiple I/O address spaces can share the same VMID
via nesting. No need of exposing VMID to userspace to build the 
connection.

Thanks,
Kevin

> 
> We're expecting to talk more about the /dev/iommu approach at Plumbers
> in few weeks.  Thanks,
> 
> Alex
> 
> [1]https://lore.kernel.org/kvm/BN9PR11MB5433B1E4AE5B0480369F97178C1
> 89@BN9PR11MB5433.namprd11.prod.outlook.com/
> 
> 
> > * PATCH-9 and PATCH-10 are to accommodate the NVIDIA implementation
> with
> >   the existing arm-smmu-v3 driver.
> >
> > * PATCH-11 borrows the "implementation infrastructure" from the arm-
> smmu
> >   driver so later change can build upon it.
> >
> > * PATCH-12 adds an initial NVIDIA implementation related to host feature,
> >   and also adds implementation specific ->device_reset() and ->get_cmdq()
> >   callback functions.
> >
> > * PATCH-13 adds virtualization features using VFIO mdev interface, which
> >   allows user space hypervisor to map and get access to one of the VCMDQ
> >   interfaces of CMDQV module.
> >
> > ( Thinking that reviewers can get a better view of this implementation,
> >   I am attaching QEMU changes here for reference purpose:
> >       https://github.com/nicolinc/qemu/commits/dev/cmdqv_v6.0.0-rc2
> >   The branch has all preparational changes, while I'm still integrating
> >   device model and ARM-VIRT changes, and will push them these two days,
> >   although they might not be in a good shape of being sent to review yet )
> >
> > Above all, I marked RFC for this series, as I feel that we may come up
> > some better solution. So please kindly share your reviews and insights.
> >
> > Thank you!
> >
> > Changelog
> > v1->v2:
> >  * Added mdev interface support for hypervisor and VMs.
> >  * Added preparational changes for mdev interface implementation.
> >  * PATCH-12 Changed ->issue_cmdlist() to ->get_cmdq() for a better
> >    integration with recently merged ECMDQ-related changes.
> >
> > Nate Watterson (3):
> >   iommu/arm-smmu-v3: Add implementation infrastructure
> >   iommu/arm-smmu-v3: Add support for NVIDIA CMDQ-Virtualization hw
> >   iommu/nvidia-smmu-v3: Add mdev interface support
> >
> > Nicolin Chen (10):
> >   iommu: Add set_nesting_vmid/get_nesting_vmid functions
> >   vfio: add VFIO_IOMMU_GET_VMID and VFIO_IOMMU_SET_VMID
> >   vfio: Document VMID control for IOMMU Virtualization
> >   vfio: add set_vmid and get_vmid for vfio_iommu_type1
> >   vfio/type1: Implement set_vmid and get_vmid
> >   vfio/type1: Set/get VMID to/from iommu driver
> >   iommu/arm-smmu-v3: Add shared VMID support for NESTING
> >   iommu/arm-smmu-v3: Add VMID alloc/free helpers
> >   iommu/arm-smmu-v3: Pass dev pointer to arm_smmu_detach_dev
> >   iommu/arm-smmu-v3: Pass cmdq pointer in
> arm_smmu_cmdq_issue_cmdlist()
> >
> >  Documentation/driver-api/vfio.rst             |   34 +
> >  MAINTAINERS                                   |    2 +
> >  drivers/iommu/arm/arm-smmu-v3/Makefile        |    2 +-
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c  |   15 +
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  121 +-
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   18 +
> >  .../iommu/arm/arm-smmu-v3/nvidia-smmu-v3.c    | 1249
> +++++++++++++++++
> >  drivers/iommu/iommu.c                         |   20 +
> >  drivers/vfio/vfio.c                           |   25 +
> >  drivers/vfio/vfio_iommu_type1.c               |   37 +
> >  include/linux/iommu.h                         |    5 +
> >  include/linux/vfio.h                          |    2 +
> >  include/uapi/linux/vfio.h                     |   26 +
> >  13 files changed, 1537 insertions(+), 19 deletions(-)
> >  create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-
> impl.c
> >  create mode 100644 drivers/iommu/arm/arm-smmu-v3/nvidia-smmu-v3.c
> >
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

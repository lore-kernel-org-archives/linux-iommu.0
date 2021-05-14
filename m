Return-Path: <SRS0=wlUX=KJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CE3C433B4
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 06:54:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404D5613F6
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 06:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404D5613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB3904012A;
	Fri, 14 May 2021 06:54:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AK6ET4OCPLyq; Fri, 14 May 2021 06:54:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id C33204012D;
	Fri, 14 May 2021 06:54:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83B8DC000D;
	Fri, 14 May 2021 06:54:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76FFAC0001
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 06:54:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 64D846063B
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 06:54:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZHMH4SLouQEC for <iommu@lists.linux-foundation.org>;
 Fri, 14 May 2021 06:54:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB3D3605AE
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 06:54:26 +0000 (UTC)
IronPort-SDR: qbEvDTujgBz+3/lwutoFFrkE7pmIPrYr34qMxYcS0yCTRzC3sVVeEFV3UnjlgHx+mtER7dbZH9
 HrQA+MtAk3Qw==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="261364655"
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; d="scan'208";a="261364655"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 23:54:24 -0700
IronPort-SDR: jVc34Ge3VcRjlbnqyPrxkf7NtDu2mrjK+X5vb/nWXBtsgoc+lw0hly4812xSRnf5pINh2PREja
 lKOAIYd6mB4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; d="scan'208";a="401514450"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga007.fm.intel.com with ESMTP; 13 May 2021 23:54:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 13 May 2021 23:54:23 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 13 May 2021 23:54:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 13 May 2021 23:54:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 13 May 2021 23:54:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajCfskZZ0tAm5uhIk+n+GMPZ0sW2tOR/N8K5nYkf3VpNxqnpdFUPLhoI0fiRS6ndIa0q3/2vAOYbLCpPioEiB9VqiLk5i7DK0IMpEHC1eoAX0IaEzbuvOZpNMTLfJUDPeOzIxbFdfP2EDf6ALtJPYVCZbx6wee/OIYWl2U4ccRF1JcnHItNLyj9jxXuosuqfbzpsSc4HtbgShlRmrd2JaulBPya0a1KgcqEGrAlgNl/+6n6mhT0XMjGOyyNwDlTjPbn2318TZ7q2Gd5IBb0JLYeDu2N7/BGru/7GLTSrExKPx68daYj417Rzx1QET2tX704ENUlEBYTa4eZjkTXQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+ev+HxAnYOyY77dqX2O9O7HQmSCw9TdxU6htvzxEac=;
 b=es1SYWdj6pqoQJUwMCt7fqR7eTCVbCGPYaFCYN2DnNXBK+Lrztkxa2odde555THrgyBen+0NpU+n+aHHudVho5BcIJ9LpaOnD0+PbTWXXacMCYlWGpEb4W4u+G+wjyuVkAWBk0yIyd+wxYbMwHqXjbdVAj4zCAkjYMCElsRIZ97c0+KUeI3Kpm1gzJyghzcbKOQHtx5Yo0gyJI9PST62lHNLn5S7EHs4ppR6wyNpWfoaiTzoMETIUjwSR5xxN57Tu2O3WDFp4os3yudCYui8Tu6fyN50rDohQ7XRZwaieuj581TQysn8vj3CB79au/GlXhA3FT6DXkUfPThge1ypzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+ev+HxAnYOyY77dqX2O9O7HQmSCw9TdxU6htvzxEac=;
 b=MiqZJ/LIETWTKRqEPYPyj6WJ3elej7N7897l7TibPBk5LRdnSk3ABC6vEnOsiGVaY9qWGcH7XSmddBWo/MyY1eAYAXZXREVatCZCk7ZfHvqXqaV6q61v4iJLT/KMAJDnZmwlSUSXIA+/NjFqCjZQv0io6MJ0i1gRs16/gn6TcRE=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB2064.namprd11.prod.outlook.com (2603:10b6:300:27::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Fri, 14 May
 2021 06:54:17 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4129.026; Fri, 14 May
 2021 06:54:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Thread-Topic: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Thread-Index: AQHXRWldX98a1U6w60C1HwYkmNlXK6rc3tAAgAPcBcCAAJmdAIABJmdggAASuMA=
Date: Fri, 14 May 2021 06:54:16 +0000
Message-ID: <MWHPR11MB1886B92507ED9015831A0CEA8C509@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210510065405.2334771-1-hch@lst.de>
 <20210510065405.2334771-4-hch@lst.de> <20210510155454.GA1096940@ziepe.ca>
 <MWHPR11MB1886E02BF7DE371E9665AA328C519@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210513120058.GG1096940@ziepe.ca> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.80.65.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 119ebffb-342e-4ed7-7780-08d916a517a2
x-ms-traffictypediagnostic: MWHPR11MB2064:
x-microsoft-antispam-prvs: <MWHPR11MB2064314ED9315818941F47788C509@MWHPR11MB2064.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eTmdK+j4y9Msg7q44Q/wnRPMM5LSMZwhbXvKtjixkprQOJrYUXnGVpg5hbCvzBCe3kayk6rb1eOyV2JmRQf+R6hIFQgmObwD/cMg1vz2i5cHXEgi+wQbY3TGW0ANMXt1trIePSIKKAMilT73TfvCea9yfe8beXUbB0K+we/8PyHXpOwfK+KeEaYV+zqYNfLMbz/TX7Ul+ivrmKfctsrT4+ZEW4RyB34XJrpYkvdlET9+3e9YBANOPG6tEpzPNryWB/6gErBm4m7j33+Ao9PRjNShQSiBNfJVu9AhPECp0j3U15W26L9R5JgCFMQYjgjGg52B4hf3CZaoq2AMF0sojXpoRqEBDTZa5rn7oJhZAm7pHasORzaciD0ht5Xe7Vavqu+khYosNK8HjfcR6XOidGkA+V2G+s/qhemAhHADt53A4VJo7Z71xB9rLqBDwS9njaxiB4c0/u5Glw6WjUm2jdn5385uC9FvU/YvtADUzFkyXsaT35Np57Yyd8nWoG9xWAmmNdkCNKuMLV6wrKakbsS/3IWmss14F3ywTtnGJTGZBYo0OPzXy9nCksVGOgGzRyfhxZSdDqKcOaWNPVo8/ngPlIYJ2NCAkEkJVGxdeeQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(376002)(136003)(366004)(346002)(39860400002)(6916009)(9686003)(38100700002)(71200400001)(26005)(33656002)(7416002)(478600001)(55016002)(8936002)(5660300002)(316002)(52536014)(8676002)(7696005)(2906002)(66556008)(66446008)(6506007)(186003)(64756008)(86362001)(66476007)(54906003)(4326008)(66946007)(122000001)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AByXNRKDnZlS7TwnuxtwwEPQJ8+ClU+HtYHz8PyKgDRIR0gaCKZ1D8IaT69m?=
 =?us-ascii?Q?obIKVdZEqqlNnb9ALGTfCfTRXD2299J+edKGd0KnpKi2sUi/droh+qweOhWA?=
 =?us-ascii?Q?TbXQlbR3u/rzctcz3NA6B0yJagVHsLRaRKNZfc199eT1uQBx/pqc1Fc3jG+O?=
 =?us-ascii?Q?GZ2W/9Z+HseY7/qKWg9HzTHgxyOtzZjE8Z1H5DcdqaJ+5siOO3Ev9biik+y7?=
 =?us-ascii?Q?43I9S2le1GjlRlkHEsymfgBpqVA8TGX06eGKr/WBy3pWp3ZYqmlVe2tuSaeG?=
 =?us-ascii?Q?/w48tKTj/HPlavsiZW/iuG0lJAXLW+V/15E8bNIQEW52PLBiKU/QBc1CjMfa?=
 =?us-ascii?Q?gbc9QVfyhT8/o922A95qWzfFmFl/AY7qb5GGUkfPVPkt71q9J7rrDSSnHA8Z?=
 =?us-ascii?Q?9zHpr2rK2ojGQEMw86Geu8TkOW89JVIAMRhGH6yUcJzgh+vdMf12fVO6nHBq?=
 =?us-ascii?Q?liShnB7A7z1brICvukn2r2bd+Off9diUwl/NWRtcQ1Yv6bgANfFo7fhuPopq?=
 =?us-ascii?Q?xdSB5OGGkXDGQfVPuDJsFv8nuSm9bNMhT6r3bQPKtH6SA9aegC8wWFK0z2HB?=
 =?us-ascii?Q?7PeywxzGfu8Wgyc2KqaJIqn5QMPoik3v1v5f49sexPt+hEmOY1qIw0V1+vLv?=
 =?us-ascii?Q?sOtAjciw1P/R9wRwJjzv8ekTD7wy631aY8RENJdrRlO+O+CR+4lNtd66bG3b?=
 =?us-ascii?Q?qk+SADY/769RhhQTNQ6d3Bvr6cM/w752ILRNHz30lbJaxJ8UhL5OUTpNNj49?=
 =?us-ascii?Q?wXWvp21SFDVEp/uxbUpJ1T6uFIcEohPwfP97/6jLK45J5N+6PwtNc26m5dcb?=
 =?us-ascii?Q?Ws7i2AJvfp2V0jVHZKwhQujQ7RhvpkEqFWDx092Hc0sU62/Zvdce1SVUG6U9?=
 =?us-ascii?Q?urab1j3KEbArcfH3UJmatQGtO6nDwOGCSmHqagRaiXxnGWaodfBu0vRmCqVf?=
 =?us-ascii?Q?ZZZYx33U4KZjmDkZgzdTtSE0GRp36WzeTgXI+j3gA37zcHciixu4JO8POhqU?=
 =?us-ascii?Q?gHy1FSU95fvmY3cFjxgLRsbKqAXrnWWq594NSYG38bPwNAj4VLKPYIcYdYeG?=
 =?us-ascii?Q?zC4hM3PsCw25Q3z+E/KGfH9rSr/Q5fd8PccFj0eyr3vD5m6TwhqzwrzFdPT/?=
 =?us-ascii?Q?8W5b8kaGTm8QYRvpNouU+Jj8p6td3syrAnBB2pcrJWn62gSOr8WPgsMProKR?=
 =?us-ascii?Q?MX1W+xdJL91trPYwH54rymtN+XDYMwxRPZs2W99WkoEblS15TZvpqCnvPPwS?=
 =?us-ascii?Q?2qU0kXqQAW9jr2pLR4cpCFs7iO0h6L/5Gn/1VqqixmL/umnNZkNjntm20L9Y?=
 =?us-ascii?Q?I5Q=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119ebffb-342e-4ed7-7780-08d916a517a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 06:54:17.0144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iq3Ab4zrRQ29/WAVZ43e+NRmB3teKuhxDBFqLpCPPq7/S7oO1uUAuKmD5A5FcNGEBNDle6njd6zOoAK+dk6ZtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2064
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Alex
 Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@lst.de>,
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

> From: Tian, Kevin
> Sent: Friday, May 14, 2021 2:28 PM
> 
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, May 13, 2021 8:01 PM
> >
> > On Thu, May 13, 2021 at 03:28:52AM +0000, Tian, Kevin wrote:
> >
> > > Are you specially concerned about this iommu_device hack which
> > > directly connects mdev_device to iommu layer or the entire removed
> > > logic including the aux domain concept? For the former we are now
> > > following up the referred thread to find a clean way. But for the latter
> > > we feel it's still necessary regardless of how iommu interface is
> redesigned
> > > to support device connection from the upper level driver. The reason is
> > > that with mdev or subdevice one physical device could be attached to
> > > multiple domains now. there could be a primary domain with DOMAIN_
> > > DMA type for DMA_API use by parent driver itself, and multiple auxiliary
> > > domains with DOMAIN_UNMANAGED types for subdevices assigned to
> > > different VMs.
> >
> > Why do we need more domains than just the physical domain for the
> > parent? How does auxdomain appear in /dev/ioasid?
> >
> 
> Say the parent device has three WQs. WQ1 is used by parent driver itself,
> while WQ2/WQ3 are assigned to VM1/VM2 respectively.
> 
> WQ1 is attached to domain1 for an IOVA space to support DMA API
> operations in parent driver.
> 
> WQ2 is attached to domain2 for the GPA space of VM1. Domain2 is
> created when WQ2 is assigned to VM1 as a mdev.
> 
> WQ3 is attached to domain3 for the GPA space of VM2. Domain3 is
> created when WQ3 is assigned to VM2 as a mdev.
> 
> In this case domain1 is the primary while the other two are auxiliary
> to the parent.
> 
> auxdomain represents as a normal domain in /dev/ioasid, with only
> care required when doing attachment.
> 
> e.g. VM1 is assigned with both a pdev and mdev. Qemu creates
> gpa_ioasid which is associated with a single domain for VM1's
> GPA space and this domain is shared by both pdev and mdev.

Here pdev/mdev are just conceptual description. Following your
earlier suggestion /dev/ioasid will not refer to explicit mdev_device.
Instead, each vfio device attached to an ioasid is represented by either
"struct device" for pdev or "struct device + pasid" for mdev. The
presence of pasid decides which iommu_attach api should be used.

> 
> The domain becomes the primary domain of pdev when attaching
> pdev to gpa_ioasid:
> 	iommu_attach_device(domain, device);
> 
> The domain becomes the auxiliary domain of mdev's parent when
> attaching mdev to gpa_ioasid:
> 	iommu_aux_attach_device(domain, device, pasid);
> 
> Thanks
> Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

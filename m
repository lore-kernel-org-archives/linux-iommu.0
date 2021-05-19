Return-Path: <SRS0=NBt+=KO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CC6C433ED
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 23:12:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF8061073
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 23:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF8061073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 22F9E4014A;
	Wed, 19 May 2021 23:12:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H5B6iguXz7rj; Wed, 19 May 2021 23:12:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 070D340166;
	Wed, 19 May 2021 23:12:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDCAEC000E;
	Wed, 19 May 2021 23:12:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2AD0C0001
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 23:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7AF4540166
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 23:12:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id apa0a8koO8Xt for <iommu@lists.linux-foundation.org>;
 Wed, 19 May 2021 23:12:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A3964014A
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 23:12:49 +0000 (UTC)
IronPort-SDR: ED6mDMgePn1H/X0JM4gxnIdgLnXYMM8GhDFtSJLD/AoLMnSDew0JZGPrJqmYyYWHR/SNyG6xiU
 KaMDL0FMgQAw==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286626729"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="286626729"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2021 16:12:48 -0700
IronPort-SDR: Qgk+z3AobDsuElnbH39t9e3ibZV6I0QttCXvdLU9x9LwaEpoC8EJwF3C8JkuJoGeHDfljCGgUP
 2OjMxBBztOVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="433680537"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga007.jf.intel.com with ESMTP; 19 May 2021 16:12:48 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 19 May 2021 16:12:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 19 May 2021 16:12:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 19 May 2021 16:12:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xwhd+QWa0AiTwvDZ6aOQilKT7s6YXTMf/z73OlTCZ/nXUut6s2FCmF37BeUPmUejLjREvFDu0O/HpqT+JlOXk6MmtfNfc0pk09vn9oA7T83CVc4jJ1YcmBk5gI1v2zo6neD6ePtr1WBFPXUHHs6Cl3LOWJ2XN9xL6jg8sqLNRZ9JMf61VdKHFe0b/wjZtcT1R2fB67sT/hPfx06HmjoRxczMHTm0vRvYiJUPzqcdnzPqx95sLLEiqnhsHz44g+NPZ8qauYjoyibo8Xb0Ci7h3ltmekkQg8KeqUUvroDI5WqY30FAh/fzT1FXDZNflOYKFxyn7JyPCiDZwExEdDRjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMmRIBjpmEjU1UuS2XzQwpoSc9JEmye98GgqPuhIpTo=;
 b=h7rchb+SMTfrrAJQetFLY7m1YThTTdTHvRxzPeRbJqKm4S3Zyt5gRwpz0SQdDWVQ2L1OICdsN71R5XuDHDE2/c/iW7xEt7O9FhCU2gQniOGXcKg5hnYGgjyrO/fruyB/70dq6cRdm+AR8jqV46EZJ99b7wlyKeEaD/bGsXbkoKXjhd5m0Q548mmHqVYKGYT7SJAFa4vLo39riN6aqO2FQVoeuTGLAh/lxpIewrIWlzGmmyBnCk1v2Em1RXx1mu24jLv+uzZuKyqMXhd7nnehbr6kLHkaCan/4OK0UQ1e9R7G2RyZMnYH/BmSJBJ7VxS4WqQIvR6fyp8Kdn9t6E/2mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMmRIBjpmEjU1UuS2XzQwpoSc9JEmye98GgqPuhIpTo=;
 b=CT2oahrOLJy5xByxadu3tX4f5hRM6tC99ywB5V8h7hikxctiY4mNHEEEixsQIJCGH4whSKPJ/BNhS93tJFnakO1kiINiEaqlO+KtyZRfTQEBJEwbx1Vwv1VWi4bMtvZA3qtk3gisiTOY7+6CbQdNw+Lw2LOF2nCDN3JYGEXSDB0=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 23:12:46 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4129.033; Wed, 19 May
 2021 23:12:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Thread-Topic: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Thread-Index: AQHXRWldX98a1U6w60C1HwYkmNlXK6rc3tAAgAPcBcCAAJmdAIABJmdggAASuMCAAF5dgIAAAFGAgAAT44CABKOLAIAAAkEAgAAGdACAAAupAIAAIZMAgAMhXICAAC2cgIAAUmIw
Date: Wed, 19 May 2021 23:12:46 +0000
Message-ID: <MWHPR11MB1886C64EAEB752DE9E1633358C2B9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB1886B92507ED9015831A0CEA8C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514121925.GI1096940@ziepe.ca>
 <MWHPR11MB18866205125E566FE05867A78C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514133143.GK1096940@ziepe.ca> <YKJf7mphTHZoi7Qr@8bytes.org>
 <20210517123010.GO1096940@ziepe.ca> <YKJnPGonR+d8rbu/@8bytes.org>
 <20210517133500.GP1096940@ziepe.ca> <YKKNLrdQ4QjhLrKX@8bytes.org>
 <131327e3-5066-7a88-5b3c-07013585eb01@arm.com>
 <20210519180635.GT1096940@ziepe.ca>
In-Reply-To: <20210519180635.GT1096940@ziepe.ca>
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
x-ms-office365-filtering-correlation-id: 7913b64a-b027-461c-168c-08d91b1b9d44
x-ms-traffictypediagnostic: CO1PR11MB4865:
x-microsoft-antispam-prvs: <CO1PR11MB48650914179375247DAB45478C2B9@CO1PR11MB4865.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iqfanu8kUtkh6POkklH50FvYEyTO13Byfc2sQ6i89ypvyCRaF/fS4QM1OH51mQF91PCBHCcshl6vsqS0asaQLWKQM276lAx++1o4Mc2Nr/IgxpRx0gCmkRARA+uyrfTxFA8u9fAngRbhytQ3iojQrwbTH5ErJATUq6DLyKt1caDX1chlrPgL/05vYX11A3QrNnyejp0EorOzAyCk53NRCKsD6XPm3qZrfwRm1Z4xaUagHsKGH0ZRFAZYnUzwxFiBn2kkBQCknqsFcq0VqxyCKRQEDKXe0+jUisukBribWXxWUVnIVbzRqyRmfFDP66Rrks9SNuayNrphLqUnKaMDmceatuLPeWhtS16S7uE26/WcXW9HpAbLAyQqEVlTMkvRFR0N/Uek9ikj5PNJw2Ka+Lpes8gOeW7lCEqri1tTSW9FY2B0FZ1lcaorxc2W8VN2Ztvk2PKt0LkWOqkeMp4XoFLl6hbFJN77zSMkW2VVYbPpZhK5cFcrmABG/99s1T2v+QXoK5BM8ztt3rC7JFK0+ai/D0zFvmN8sxggLiEBBSEK+pROTl3++u1Wsq7glpTFrZaV7pn+k2PAhE2ikcXYHU2GuqrEa4pcKbK06gyo2WM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(346002)(366004)(396003)(376002)(39860400002)(6506007)(53546011)(478600001)(83380400001)(52536014)(7416002)(86362001)(2906002)(54906003)(8936002)(64756008)(38100700002)(66446008)(66556008)(110136005)(4326008)(76116006)(66946007)(8676002)(66476007)(7696005)(26005)(122000001)(186003)(55016002)(33656002)(9686003)(5660300002)(71200400001)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5iEGtwfQISjUjgztrDl6XFHZYF/a6Yqsfghh11co08qlzNQYd/pZZyZfZo8u?=
 =?us-ascii?Q?UoOTkkDTiBz5rc0WaO7ejgbWz1lv3LjAY7sqoBNvP+bzW6OXHynDTe9wlftn?=
 =?us-ascii?Q?eWOhdRW0+jbOF3N2rierSd8YnPENFGB2lUOhoHkJqe8wj0G9uY0uvCV1TJjM?=
 =?us-ascii?Q?ZE1MAarHZYW546qGCLYN43gnKCbT/4IwsKjw0C9uOgDG5Dms8c9Fx6ccKmL7?=
 =?us-ascii?Q?x1k9eCM1FpAfxopY/a3K5V/jVx55DsW3EPz8UeeNAe1Om6CgqoHD9q1JSTmP?=
 =?us-ascii?Q?3kddriL/1UY1xtxe+jJtKIrZ1NvHjuz6VBlbkhCbC3KymxnpNdPbAktp0u+n?=
 =?us-ascii?Q?EdQ0v5xsT9pvvLHZTn0HFFKNbFCptvdZr+K/N0pGjQdmcDMR+7NbbNdYDz7s?=
 =?us-ascii?Q?CuQHX9kKpjx3+fIfChaf7zvgugQlnT2nz/gAvWP+/tlFJwzqMyMcOYfyUIN7?=
 =?us-ascii?Q?5kjrm3AuCBRs5uXaFWxurxTp4dsuD7ZEtMje/Zl9FhslNDs4wr1BFSWuoQbs?=
 =?us-ascii?Q?Yb3gu3SAv7SjksAHEAfu0ggLKbkRL8BDHNw1/QLEQxKefOXhRwmOjdAehyqd?=
 =?us-ascii?Q?AVpPhX3aoXXTYMkm08jHgBMn/TUV87N6+oBJljj1X98DyOGLJvBIH0+Xlv5B?=
 =?us-ascii?Q?WbwVQYhf3ZdAGTRtySaN7BcR8xBYN7InSH59A4WoFiuVdCJtb5z+D/kYsaE0?=
 =?us-ascii?Q?EEIZNWNiSk6phkg2cfLBw051lQPe1LG/xqy7G9YbwCP2E5tPBDboxKkU/Iuz?=
 =?us-ascii?Q?juV08gxFDAw7j1MKOuM7kqpeCE9CqgzcB1/Yz6tj3SIqjxrvWOcU6gvFnk7g?=
 =?us-ascii?Q?dv1CGp6Qe32oS+59BjGeTUcoWZhG4pOKKQHeiNkeHb/Q/yT9UmNFe9ZvlhCd?=
 =?us-ascii?Q?RjyCZ69oPUCv3PZX4MVlEmvbHKeK22E6HgQ21WaQTj46US23mjNXpW08yt1a?=
 =?us-ascii?Q?c5QbNRqgKhK4ZprM1ODGILOP2lAch8EWmHIswjRfrBCrkiQ8rQMabcaDQWRU?=
 =?us-ascii?Q?ujtA/AaBCJj7vKlVcQ1hvXC/EmRgBPNiBxS+QwtpZJJzjUBBV9WDybYVXwW/?=
 =?us-ascii?Q?wpKshf5l/wcopKWer+3epqkQ0cvbX8yKUWnlntlIFzDqTZT7dAxjDQHgAqZI?=
 =?us-ascii?Q?te9+jSkn4eabiofFSJQcf0jBGjKkzj/vi8jKcg/O0DBmhdnB7BSm9tSK3nLj?=
 =?us-ascii?Q?5jViJ/opK4+pJOs6xIDEqNZeiMdAag0rUyCSO9ETNN7/klSksgajCx5myfkm?=
 =?us-ascii?Q?9cfa8cMjep5q66gcL1HVciNqJ0Q1ccUm3V8Mpc53cl79CBkhUhqZBtCBrVCc?=
 =?us-ascii?Q?mso=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7913b64a-b027-461c-168c-08d91b1b9d44
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 23:12:46.5188 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /GhdNcllByGxJPY/cVekXye0j3OIH80IJyVqyAxTki/fnZX5h1RueZcVgkN8o2zFmSaugh8IRbrUGEsBI6hKIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4865
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, Will Deacon <will@kernel.org>,
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

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, May 20, 2021 2:07 AM
> 
> On Wed, May 19, 2021 at 04:23:21PM +0100, Robin Murphy wrote:
> > On 2021-05-17 16:35, Joerg Roedel wrote:
> > > On Mon, May 17, 2021 at 10:35:00AM -0300, Jason Gunthorpe wrote:
> > > > Well, I'm sorry, but there is a huge other thread talking about the
> > > > IOASID design in great detail and why this is all needed. Jumping into
> > > > this thread without context and basically rejecting all the
> > > > conclusions that were reached over the last several weeks is really
> > > > not helpful - especially since your objection is not technical.
> > > >
> > > > I think you should wait for Intel to put together the /dev/ioasid uAPI
> > > > proposal and the example use cases it should address then you can give
> > > > feedback there, with proper context.
> > >
> > > Yes, I think the next step is that someone who read the whole thread
> > > writes up the conclusions and a rough /dev/ioasid API proposal, also
> > > mentioning the use-cases it addresses. Based on that we can discuss the
> > > implications this needs to have for IOMMU-API and code.
> > >
> > >  From the use-cases I know the mdev concept is just fine. But if there is
> > > a more generic one we can talk about it.
> >
> > Just to add another voice here, I have some colleagues working on drivers
> > where they want to use SMMU Substream IDs for a single hardware block
> to
> > operate on multiple iommu_domains managed entirely within the
> > kernel.
> 
> If it is entirely within the kernel I'm confused how mdev gets
> involved? mdev is only for vfio which is userspace.
> 

Just add some background. aux domain is used to support mdev but they
are not tied together. Literally aux domain just implies that there could be 
multiple domains attached to a device then when one of them becomes
the primary all the remaining are deemed as auxiliary. From this angle it
doesn't matter whether the requirement of multiple domains come from
user or kernel.

btw I do realize the current aux domain design has some problem to support
the new /dev/ioasid proposal (will send out soon, under internal review). We
can further discuss there to see how aux domain can be revised or redesigned
to support both userspace and kernel usages.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

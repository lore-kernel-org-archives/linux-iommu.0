Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EE9C433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 07:57:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE9E040586;
	Tue, 15 Mar 2022 07:57:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kBhPCnDQa0pv; Tue, 15 Mar 2022 07:57:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4CDDD40525;
	Tue, 15 Mar 2022 07:57:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06C56C0012;
	Tue, 15 Mar 2022 07:57:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0607AC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 07:57:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA11F60B91
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 07:57:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KQf3W7TG4UvU for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 07:57:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DC4360B06
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 07:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647331034; x=1678867034;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RHdUpGj01IqEN9UmROmg+gxPPv7Yvjww92N/V+dn3c4=;
 b=X071w7hTVL8oCy+cofAl1WWS3N1RPjkJoiORJjGa6BF1+wEM4FJHWyPT
 sog+NUkkNktN2I7vNDzD+Gn+ANeanr8SgTzTtUqCZnxQPpLH1YvGgsM+W
 2XVwn7jJpdgqnW8HrSfzz+A/Nu7bioCRHgBjiyb31xiSisj0wEAdEQgAq
 hAixMiXBUAeJcQJdtR0HYEc/K3K41gZKHMLmTJZe88rHdpHb5NUFDaQ1B
 cRnx7P1GFjh/KejxOtbLrxVvmI8X72A5U5puqtk17m8C6BLHIva7rHFeE
 sNFL5Y+mwI5ZAyDo6AyZsX/l5lz7R4olBis8bp6N5mE9SVv7ZADovngiY Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236185660"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; d="scan'208";a="236185660"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 00:57:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; d="scan'208";a="497925405"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga003.jf.intel.com with ESMTP; 15 Mar 2022 00:57:13 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 00:57:13 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 00:57:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 15 Mar 2022 00:57:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 15 Mar 2022 00:57:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtLe2x0XaUUEZDG6p1dqUUoqbmRzPsP8tkdzEOAX/fhxJq4Bvg9cgG1juckQ98XpT9/6FOmuwYwo/Z1I/JbmJhvLul+aSQM3I2EQdOHoPUeNstB/fY7O7RX8yA2ovD01kiZl5mtIzrscnJMnlB69ZmwuRgVOM1IKOG38hAp82jw9FeFqUvGKr5D1THLoGn1rWl/SczoEDRAlg9KJQzWxEfcz1SCc0tL0FQHAAVG1oNzryEhw8oBXdWrAhM7cRSAa+CeiNxFg89t7P+tnImVOHkpJMjP3GZdIZBK2HVzgYMlTGxXCNmx5ghzba/oAl+urCUl2q0kD8tqeVQvbXtW1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPsAC0RU35VZDfyr7i33mhnVRK+ost9SNJp4p4hbnqw=;
 b=WxcecIt+6TqT6cm7sCyl2ZlCuPJ0I+Lt3zVFQMpWFFJP3kPOoelSY0QdsGPN6MMkg9zW2pcif+rp4YqqnwWRVxlDqhEYZGgX50T/ai0jVRnGi/Fi+WJd1obXwL/0bJmaA60BbJTsKukjseFkl9ifDdNUMTVjjY0AMfdeLM0n0R1+w+JLbtTcQqts2uJQvIdmhwXJIelr+1+5zQ+Vqa/NeiqFpLHvDCf6LsbR9GBiaEQH5/DAp90n+ruMvOsIMyclKK3fhQvk5H//Qr46uUxW6lbY7OJ9Yagk+7CaOOist67SEeCT6g6Qz6i69Om+cYjgj7/ZkZvqTVgwU5f/Fof6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SJ0PR11MB5599.namprd11.prod.outlook.com (2603:10b6:a03:3af::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 07:57:11 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::b9cf:9108:ae17:5f96]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::b9cf:9108:ae17:5f96%3]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 07:57:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v4 15/32] vfio: introduce KVM-owned IOMMU type
Thread-Topic: [PATCH v4 15/32] vfio: introduce KVM-owned IOMMU type
Thread-Index: AQHYN9xrQVYDc2PUskGgAyzdZ+WZ86y/fBmAgAAHrYCAAIrs8A==
Date: Tue, 15 Mar 2022 07:57:10 +0000
Message-ID: <BL1PR11MB5271DE700698C5FB11F5EEE78C109@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
 <20220314194451.58266-16-mjrosato@linux.ibm.com>
 <20220314165033.6d2291a5.alex.williamson@redhat.com>
 <20220314231801.GN11336@nvidia.com>
In-Reply-To: <20220314231801.GN11336@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abd83022-249e-4d1a-c109-08da0659691d
x-ms-traffictypediagnostic: SJ0PR11MB5599:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB5599120D4D5CC1B6AAEC10A68C109@SJ0PR11MB5599.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5cZ13trWKJASAmx2TNaAOnfyobstd2xIkvxbOZzzIEGBbpR2chbVUtVjzqYCtyZcZRPHKiH1oLr6ywn5xPNCzflQLNCBucfIxLb6My0IU8Jt8CRvEMe0DzI4gmO5y56dHGWuowyxkFHEaECJppUXTfCAuxWYmgRar5VsOsK6n9/xIHQ7iFPhhAW59g8uzAZLVlZ7UXkgx8TyR3lkQES4piXmwpaTEEORVB7xVGF4K2M8v6BH4gR/XYiT23dYWKHpDzjsgICkam+JrIwxxF/X3b34knyCAwgJJvJc4WO/hW+ApwN32V1DTnw3JiVtUekAizNXn41g1DqHm7WRB+8Ka92YPUb2ojY0TEZIBcXDsCpcYADH28B7HbcB7zL6XscodmB5Z0qnjIsrmCagojgE+JMfVXwuPNgfUvWcbqHnGE0MTgJ5/xkTQOs53FmvjqMz7kCA/XD5k9yGkIjvibYNuAu9NPtkF8wGd3zXQ3qbQ1mU/FwmcpcQyFZ7XUCtwu6++B1e0H2L6A3ml+mjKsH/sUCmvmnF9Im7h05jEAu/5NaThaozQ0CVhCaZ1WfwEcy6JDT4s0wGN3SyeNInprYl6VYFkzmRDxLoeOoXNTKCLU5HU2z9Hjec2Sdct2AVY5wThJ0ziaA7HQEOIHeoGunsJtpvyplqV/jUUk0aWWNAk49O7GLlcK5R/twGdWumYX4QQRqQMC7p3X5pAlYtmUPS5Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5271.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(122000001)(6506007)(7696005)(82960400001)(83380400001)(33656002)(2906002)(9686003)(38100700002)(71200400001)(52536014)(86362001)(508600001)(55016003)(38070700005)(110136005)(54906003)(64756008)(4326008)(8676002)(66446008)(26005)(186003)(66476007)(66556008)(7406005)(7416002)(8936002)(5660300002)(76116006)(66946007)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WPkY+Vzrr40zXp0JpYrX6ED6CNMY5bYXgN1Qyo9GVbTYiSlo5sNSDRh7Oiuv?=
 =?us-ascii?Q?5TJnQgEA3M8VqaSKzuNYgNgWGTHPaMk7hPjPyITTgonvAs/w1PlnQsqbZRY/?=
 =?us-ascii?Q?GkxRqXUTn86FExUV5Uw4XLGXuV1v8bSkLt+GBf6dviJo4JiO68CUv3g7j66p?=
 =?us-ascii?Q?1A4zSgsKfLaUBFtmQV/wWwXlDRpekisGHWFA5NoGPvNRIQhzH/DE9HhOalxk?=
 =?us-ascii?Q?B8PDUkKeFX4B7PRln8F15XNjjTZW/yYINTqkQPqv7vFyQ/EO2gYWKZjvkS5C?=
 =?us-ascii?Q?NTihzyumwr1Cu0ZRoCRbN1KkgXO1IOjyrQkZEWELfPRdQ0Ax1Qggm2TBrZfW?=
 =?us-ascii?Q?qAoVQycWeg4ZoAMS1LWlL3bqSzDYWBrgC4NKUrjQyKWpqqo7CEY5laUDBHT3?=
 =?us-ascii?Q?dgi1qzJMKVc47UP3oli6Q9qxzbfYESoIvamKRP4krEIKIkll47BrcDjYmpbw?=
 =?us-ascii?Q?OsQUdztlGGqbr4xn4R0B5cDntGqUPKg9FYqj+2tEOBDUdTa8RcLhmj+W2CLy?=
 =?us-ascii?Q?zIBcefcoqk8ShnzNXUthMLINaELceMLiTuZ7CCaaR+lHsbj2Bkc1iTbiPYZ5?=
 =?us-ascii?Q?VN68oQKvODbd7m9Qe91MaDDimaCr/JjiSAAM+MMFTT7vHFElU/TEG+lMRaMk?=
 =?us-ascii?Q?v5GSONjwom+DdYTWu+0Ewa41Ns8PANj6M7ohfPqEuXcYbHDPV6Da/uf10SRh?=
 =?us-ascii?Q?tD2t5CWMs4fln/jTJqpDuXz5E4HhYtV/tzDWvBfJXH+qWimOO13KxZDqJOst?=
 =?us-ascii?Q?0eSAy3ndc8wSXVg9sZMHJeNVCdMxJ4DViUmVHQA4PjOCJcRsI50jbaZRKfU+?=
 =?us-ascii?Q?OUNAfEnmvVfpFYIByjn9aRbfcRo8gRl6EH24W8qgpIVLwUqz7KhGX/ihSpML?=
 =?us-ascii?Q?YPo4+DlZG+xCR9g9+2EPfUXvMw7DHkkZZ52PBDrI24B2qb1JDCA52apelRYP?=
 =?us-ascii?Q?/PMb+ssT+rzoEbmOszGPV7gdopMRikFPehuwCKuueetNd99LW2J+9SiSlAAh?=
 =?us-ascii?Q?B450JbqTXKPp0CPP0n0zZf6moUOFzgpgcuY/TAxvJgHHqq0kfS9BTY1Ms4oN?=
 =?us-ascii?Q?nhoYs+wFXNuMpfCRzA7PJjUzV8mf2D4bvvUfj96oWHXYtuayXgUm4qtfW6Uj?=
 =?us-ascii?Q?eH1he6bD6rGE1/4NyTxENpMmQvX6vtGxNS9c0rlYGctHeBLcZjlK3vVE5bx2?=
 =?us-ascii?Q?XE40Jq5Mn1mz2hIWnmAwUxb18V4RFFfg1dD8FZWfDwyeMKE7A1iNI+Efg8IP?=
 =?us-ascii?Q?Ewe49IAI1bs2KGxruCUG0dKqb7++g8U0mwbz1DR+NAtyvlPeELrNZnFr1mjk?=
 =?us-ascii?Q?u6Rh/+7ozzxxkn/K1zwghcip5rNYtqhxyaufPDQgBUXXWngV2/wOq9u8sL3P?=
 =?us-ascii?Q?8HnVqXHl9xtX2mOFdSiWeDniSLoLP2HbhQIm4x9Bv7c6Is8wc4gmJcNiPbDj?=
 =?us-ascii?Q?yPoLlfhv25NUzahiMAudiTrTBMSyIgc8?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd83022-249e-4d1a-c109-08da0659691d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 07:57:10.9104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +X1G4VEu8S1n7WJL0TXRD9E5D6yMxsjHGpib/cjO1Sd6TeEU5OAiQxpELyka2447Q9RwsgF46Sbij0ZV96F2IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5599
X-OriginatorOrg: intel.com
Cc: "david@redhat.com" <david@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "vneethv@linux.ibm.com" <vneethv@linux.ibm.com>,
 "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
 "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
 "will@kernel.org" <will@kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "frankja@linux.ibm.com" <frankja@linux.ibm.com>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "gor@linux.ibm.com" <gor@linux.ibm.com>,
 "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
 "hca@linux.ibm.com" <hca@linux.ibm.com>,
 "freude@linux.ibm.com" <freude@linux.ibm.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "pmorel@linux.ibm.com" <pmorel@linux.ibm.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "oberpar@linux.ibm.com" <oberpar@linux.ibm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "svens@linux.ibm.com" <svens@linux.ibm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 15, 2022 7:18 AM
> 
> On Mon, Mar 14, 2022 at 04:50:33PM -0600, Alex Williamson wrote:
> 
> > > +/*
> > > + * The KVM_IOMMU type implies that the hypervisor will control the
> mappings
> > > + * rather than userspace
> > > + */
> > > +#define VFIO_KVM_IOMMU			11
> >
> > Then why is this hosted in the type1 code that exposes a wide variety
> > of userspace interfaces?  Thanks,
> 
> It is really badly named, this is the root level of a 2 stage nested
> IO page table, and this approach needed a special flag to distinguish
> the setup from the normal iommu_domain.
> 
> If we do try to stick this into VFIO it should probably use the
> VFIO_TYPE1_NESTING_IOMMU instead - however, we would like to delete
> that flag entirely as it was never fully implemented, was never used,
> and isn't part of what we are proposing for IOMMU nesting on ARM
> anyhow. (So far I've found nobody to explain what the plan here was..)
> 
> This is why I said the second level should be an explicit iommu_domain
> all on its own that is explicitly coupled to the KVM to read the page
> tables, if necessary.
> 
> But I'm not sure that reading the userspace io page tables with KVM is
> even the best thing to do - the iommu driver already has the pinned
> memory, it would be faster and more modular to traverse the io page
> tables through the pfns in the root iommu_domain than by having KVM do
> the translations. Lets see what Matthew says..
> 

Reading this thread it's sort of like an optimization to software nesting.
If that is the case does it make more sense to complete the basic form
of software nesting first and then adds this optimization?

The basic form would allow the userspace to create a special domain
type which points to a user/guest page table (like hardware nesting)
but doesn't install the user page table to the IOMMU hardware (unlike
hardware nesting). When receiving invalidate cmd from userspace 
the iommu driver walks the user page table (1st-level) and the parent 
page table (2nd-level) to generate a shadow mapping for the 
invalidated range in the non-nested hardware page table of this
special domain type.

Once that works what this series does just changes the matter of
how the invalidate cmd is triggered. Previously iommu driver receives
invalidate cmd from Qemu (via iommufd uAPI) while now receiving
the cmd from kvm (via iommufd kAPI) upon interception of RPCIT.
From this angle once the connection between iommufd and kvm fd 
is established there is even no direct talk between iommu driver and
kvm. 

Thanks
Kevin

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE539C4707F
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 07:58:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EBE46143C
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 07:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBE46143C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65A1583C3D;
	Thu, 27 May 2021 07:58:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kYdjALD2fWDy; Thu, 27 May 2021 07:58:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 980F483C32;
	Thu, 27 May 2021 07:58:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7723AC000E;
	Thu, 27 May 2021 07:58:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14F03C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 07:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF3F783C32
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 07:58:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GiCHhoie-kW2 for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 07:58:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44B3883C3D
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 07:58:19 +0000 (UTC)
IronPort-SDR: M68ynXF88SCEAnkA8TdGsHMqdcncWK3/gRdMHU7xrGKSH4uv8PB+rT3Gn+snwablmniaqSqiyM
 3PzH1ynXIC8g==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202438572"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; d="scan'208";a="202438572"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2021 00:58:17 -0700
IronPort-SDR: nrPWmbi18lS2Mzd2WAQNgrttTMB/98qArcHb+4O5Z56kVO8/6SE3uXiZnXn1pHWhAOM6gtbLnn
 A+zPhQZoM9WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; d="scan'208";a="472413848"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by FMSMGA003.fm.intel.com with ESMTP; 27 May 2021 00:58:17 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 27 May 2021 00:58:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 27 May 2021 00:58:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Thu, 27 May 2021 00:58:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fReqxI/RA3d9NRJedtiOhqI9G8JWZxdftzOmncQZR3Hl79uVNC8DHmPq3IAkVb3baAv8Xji9K/bPGogL+dhQzFSMRpt27ZhpP2WKWsgB7njwfNfQ4rnDlmJKymSdeSH1qlprpqBkn4mjOlE+z6C7EOmgv6982x/QZNV029HBRRE4h4EvsEv8AYIxizvnnH4WmZo8EaaAGveTctVAhGU4eVuBm2UKkymJZDEWbDgD5RZ9/rSswYOy/CmZmTJdP8p3Wb+wxf/zTSL81u6OUEX/cK+NroXdotNUvKwULhpphLWxBTyw941QfoGHf9HLBIOkoyHJZr03OpwUyQnJlXNwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIUSdwyD3+Bz9rDvqY3yVOkhajKhDxtORZgB+z3v+cc=;
 b=j0pgx1Bh3m+F3LrpUjf5ryuGbDGd9W3FgDeAVAu79NJ1RUP/z+f1tsVThEnOIcKYvWt2xAOHlRwcvodjEr6qjUtt3SVvqGP491fyDjchwzqycxJaNP56hfj+ZmZRCllhznSXruJ73ZUjcfvR0FDjjmabeN5/1iYwBrclAX35Q2XQUlIOhJtDgG5Ec3fQpYeXa/lPGiO7wC2Y1i9yp9I61gXBBOyOFHdhMnObfUzLlExpXV/XjjdMD0FzoslPaQUsx47/WzraTK/7faEbUxEtPTPCezyNLN4mUr43rHBGK35HuctKXtDCqIGH91MTYTnKVQLGkhnI3YA6PfWJhNMbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIUSdwyD3+Bz9rDvqY3yVOkhajKhDxtORZgB+z3v+cc=;
 b=QfhOXFYOGQ1JYx/zJU5vneFZ9PDPF+2MXzt7Xvtwu+Q9biufOmlcfnmPE/WwsdFqoIrVwtMWMETxcI79fmVGaR6Fc2iU8GM3y8Z5l77gN0eubOW+YaimjtZ5ZpWxLnTT4j/uwASrufVoWhgMm4Ev1G9+fNKxwnd4ogKXQ8ELFbE=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1517.namprd11.prod.outlook.com (2603:10b6:301:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 07:58:13 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4150.027; Thu, 27 May
 2021 07:58:13 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, David
 Woodhouse <dwmw2@infradead.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "Alex Williamson (alex.williamson@redhat.com)"
 <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZw==
Date: Thu, 27 May 2021 07:58:12 +0000
Message-ID: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbe20817-4ef9-432d-9c22-08d920e52d77
x-ms-traffictypediagnostic: MWHPR11MB1517:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1517B3EE7B7FB2690538B9AD8C239@MWHPR11MB1517.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gVu4coR3QqWhznQP9sgmrEKTcsncgHNcU9pBoQxNIgO1DlWgyVF6SG0dGKXG9ykKamEaUH+kRyqMuwCHOjkV+wp/pmB4qvaD+N9qS8bodrxUxExj1l8XxSUYNHuVZx6jNvbiyskJ63PfhVOB9XMHC5VBkql5zsmea12vEQOUUYLHSEbdm/ke8MQieoBJvg0JlwALkBENI7JuIdGEzibA0hpB3AoAjgc0H7P5pyIaZ9TaZuH7qQ9EqU9SIcy9S4f1b6mwS334Kv7z+oFADkY9lCY+QrNQJ6jQXIaQXEaIE04FSLCAmZwj1qOAmq1N9EkJLeoAXNDCziGQrWkx74WaI2Ii2gXWXJcuLKmCxaSd/pgqGDNZGAZDI6aczbPaIa6E99U+kwctPCqbfCw1ebHUPsIkdCQZJrDpun5CVDhikZ2jsKbY2xUaVp5c1sQIOvBJoj27+q1rLVXanOsK2ygbMhoGsqM47XqDcpdtrtbC/w+N0S7NhKlsBGAV0ZMUXWC+/3dov4soCu+yV8afH5KPDaGYqk49ufoMOhCEFGxKIW4a1BYMvwlfOnIFuFb2lc5zbFZh/0H7i3lZ7tsgpJm5VeDGfT3bIZzL+GQh+EEeko7ZYjURELjnntIWlDqyeVR4wV6WabQUTNkXvU3f2E/PIOqc/+YftN3xd7SWe0PgGMOEdZs0ppuTPLYddFOA1+AfjFue5zxmnFJjUwuudVTVTUbZJeU0/XzYHQWIQiQ4seA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(346002)(39860400002)(136003)(366004)(376002)(2906002)(5660300002)(52536014)(55016002)(122000001)(186003)(9686003)(7416002)(76116006)(66446008)(66476007)(66556008)(66946007)(30864003)(83380400001)(33656002)(8936002)(8676002)(54906003)(26005)(316002)(4326008)(64756008)(110136005)(478600001)(7696005)(6506007)(86362001)(966005)(38100700002)(71200400001)(559001)(579004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?L8wiYgXd5fSgGh34WuhbFwSMFPF3vuAKPI34mUY04rfRt950TceCAXn9N5ex?=
 =?us-ascii?Q?7kYuXLgEsGq2Of0hxGHf/tv77oMLJsBGyNTQ9sRZc2vlq8k1DAG/pqghUfDB?=
 =?us-ascii?Q?AfsOWTkMv5QR1YmATRdOSSdhOk2MGVE7jQs6QYcc/21/V5zqqYGkX1hlySCR?=
 =?us-ascii?Q?RKaIJCSMb+Vta6nzytH1uXVm4nZtQueCc4ZDi9D0Kr4IEeCMSVH9hnkbCm7X?=
 =?us-ascii?Q?opopaNTWMbLwfJmnb//O6mFTvFhog75UfjdZvxTdGzMu0Im9bXnkwXdFdvWq?=
 =?us-ascii?Q?ZGR6JgkLw6bnZtHRKfjec3J6AJyiWUgQo71jNnCrq5gSU/Qp8WIeQGjE1DxB?=
 =?us-ascii?Q?vIpRWC+7mR3oFOSxLZt4YANSToikGQj4tsIJ4SxG+zkASbEDa5gULro8mg/E?=
 =?us-ascii?Q?NQE65f6+skiA1BvyJTnBMZ18DAWwhkvHJgVuX/GhVLqz4kceWIWGjD1+cDyJ?=
 =?us-ascii?Q?W7IZs+d4iu70woGwEW7pF1JpeoDGrbZwPzcs+fwmwS87Mnccx0fU3y1p7QO+?=
 =?us-ascii?Q?OFAY944udN+rg3cM70SnpIqZjX1P1WN9D5pBRvb6ifrWd4TJPjWgG4u201Jj?=
 =?us-ascii?Q?ph0WL3CL/VsNhXWrmUcJYvvqXnRFqPdMwJh6+tpN7jmgw8bmc+hRWEIgQOjE?=
 =?us-ascii?Q?uSnUNABDL7tLqctCfRC0u8oLoE2H0PCxNlCrMQiuJwRi/HGTC6EwPtqZ2EsB?=
 =?us-ascii?Q?wmcd9PfnUV3mGOuOh8Xw2CoSAQfR1h8We8JSHn5BORLzexZm9D3okmswTp0v?=
 =?us-ascii?Q?N/HVN+sRqz1zPzjEKmNiW0bDg60qP+OzU1XGkzmVfL1ncnHof3f9uUzP+qrG?=
 =?us-ascii?Q?R3e0h3mOm59YnWo2WwJ2L4DHJXr6TfIYK2lF5oCConyPlougxDGSwf8dHtJF?=
 =?us-ascii?Q?hYci9qwRgt58JhGE6J/0quCnbkThXMmtTrm5xya8pV/Rs2gv9jmQ9G6zkwgq?=
 =?us-ascii?Q?qIdJPuu124ki/9ki8T5s2RaQkpU+BZ4ARHuCmZkjKl0h5t1YgwrDxMF4fJWe?=
 =?us-ascii?Q?JkT2MJNKTlmbKRxBk3DZqrQ2JUaZkDfW85bxGyGKidh52J5jHJgVEd5GWujO?=
 =?us-ascii?Q?dhUiZcOVCErd/sA5OoL6F/K2amnoMt0G6YSF4O5Hrlqg2i4sDBlb7LshdGD3?=
 =?us-ascii?Q?RzKHzaCws7s9Ij0FAesflFTRqGrNa9KamlHN/LaEqnu8iouj1ZgGnsepwpPQ?=
 =?us-ascii?Q?xsaBPCfi/V++nXk0Sx8Gro0gicVKS6cXAtjNu9H0bhDfLsxno+m4lxrYptBM?=
 =?us-ascii?Q?FqXcG8azJ2K0goXZ7XIs/EOLWG9q5n5IYqMihNJjyoVureC8bHZ2frqFxQWE?=
 =?us-ascii?Q?DSu+DNoqTXBNkzJEjoyXJqUF?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe20817-4ef9-432d-9c22-08d920e52d77
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 07:58:12.9879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2p9oMd9OCRb2m9mfvz13V2GmpyImgIfWWHgnN2tSRNa0Sh4PdJG8dVaX2ol/wVgvVivZPr5SPtO6Rv4NuRWIUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1517
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 David Gibson <david@gibson.dropbear.id.au>, Robin
 Murphy <robin.murphy@arm.com>, "Wu, Hao" <hao.wu@intel.com>
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

/dev/ioasid provides an unified interface for managing I/O page tables for 
devices assigned to userspace. Device passthrough frameworks (VFIO, vDPA, 
etc.) are expected to use this interface instead of creating their own logic to 
isolate untrusted device DMAs initiated by userspace. 

This proposal describes the uAPI of /dev/ioasid and also sample sequences 
with VFIO as example in typical usages. The driver-facing kernel API provided 
by the iommu layer is still TBD, which can be discussed after consensus is 
made on this uAPI.

It's based on a lengthy discussion starting from here:
	https://lore.kernel.org/linux-iommu/20210330132830.GO2356281@nvidia.com/ 

It ends up to be a long writing due to many things to be summarized and
non-trivial effort required to connect them into a complete proposal.
Hope it provides a clean base to converge.

TOC
====
1. Terminologies and Concepts
2. uAPI Proposal
    2.1. /dev/ioasid uAPI
    2.2. /dev/vfio uAPI
    2.3. /dev/kvm uAPI
3. Sample structures and helper functions
4. PASID virtualization
5. Use Cases and Flows
    5.1. A simple example
    5.2. Multiple IOASIDs (no nesting)
    5.3. IOASID nesting (software)
    5.4. IOASID nesting (hardware)
    5.5. Guest SVA (vSVA)
    5.6. I/O page fault
    5.7. BIND_PASID_TABLE
====

1. Terminologies and Concepts
-----------------------------------------

IOASID FD is the container holding multiple I/O address spaces. User 
manages those address spaces through FD operations. Multiple FD's are 
allowed per process, but with this proposal one FD should be sufficient for 
all intended usages.

IOASID is the FD-local software handle representing an I/O address space. 
Each IOASID is associated with a single I/O page table. IOASIDs can be 
nested together, implying the output address from one I/O page table 
(represented by child IOASID) must be further translated by another I/O 
page table (represented by parent IOASID).

I/O address space can be managed through two protocols, according to 
whether the corresponding I/O page table is constructed by the kernel or 
the user. When kernel-managed, a dma mapping protocol (similar to 
existing VFIO iommu type1) is provided for the user to explicitly specify 
how the I/O address space is mapped. Otherwise, a different protocol is 
provided for the user to bind an user-managed I/O page table to the 
IOMMU, plus necessary commands for iotlb invalidation and I/O fault 
handling. 

Pgtable binding protocol can be used only on the child IOASID's, implying 
IOASID nesting must be enabled. This is because the kernel doesn't trust 
userspace. Nesting allows the kernel to enforce its DMA isolation policy 
through the parent IOASID.

IOASID nesting can be implemented in two ways: hardware nesting and 
software nesting. With hardware support the child and parent I/O page 
tables are walked consecutively by the IOMMU to form a nested translation. 
When it's implemented in software, the ioasid driver is responsible for 
merging the two-level mappings into a single-level shadow I/O page table. 
Software nesting requires both child/parent page tables operated through 
the dma mapping protocol, so any change in either level can be captured 
by the kernel to update the corresponding shadow mapping.

An I/O address space takes effect in the IOMMU only after it is attached 
to a device. The device in the /dev/ioasid context always refers to a 
physical one or 'pdev' (PF or VF). 

One I/O address space could be attached to multiple devices. In this case, 
/dev/ioasid uAPI applies to all attached devices under the specified IOASID.

Based on the underlying IOMMU capability one device might be allowed 
to attach to multiple I/O address spaces, with DMAs accessing them by 
carrying different routing information. One of them is the default I/O 
address space routed by PCI Requestor ID (RID) or ARM Stream ID. The 
remaining are routed by RID + Process Address Space ID (PASID) or 
Stream+Substream ID. For simplicity the following context uses RID and
PASID when talking about the routing information for I/O address spaces.

Device attachment is initiated through passthrough framework uAPI (use
VFIO for simplicity in following context). VFIO is responsible for identifying 
the routing information and registering it to the ioasid driver when calling 
ioasid attach helper function. It could be RID if the assigned device is 
pdev (PF/VF) or RID+PASID if the device is mediated (mdev). In addition, 
user might also provide its view of virtual routing information (vPASID) in 
the attach call, e.g. when multiple user-managed I/O address spaces are 
attached to the vfio_device. In this case VFIO must figure out whether 
vPASID should be directly used (for pdev) or converted to a kernel-
allocated one (pPASID, for mdev) for physical routing (see section 4).

Device must be bound to an IOASID FD before attach operation can be
conducted. This is also through VFIO uAPI. In this proposal one device 
should not be bound to multiple FD's. Not sure about the gain of 
allowing it except adding unnecessary complexity. But if others have 
different view we can further discuss.

VFIO must ensure its device composes DMAs with the routing information
attached to the IOASID. For pdev it naturally happens since vPASID is 
directly programmed to the device by guest software. For mdev this 
implies any guest operation carrying a vPASID on this device must be 
trapped into VFIO and then converted to pPASID before sent to the 
device. A detail explanation about PASID virtualization policies can be 
found in section 4. 

Modern devices may support a scalable workload submission interface 
based on PCI DMWr capability, allowing a single work queue to access
multiple I/O address spaces. One example is Intel ENQCMD, having 
PASID saved in the CPU MSR and carried in the instruction payload 
when sent out to the device. Then a single work queue shared by 
multiple processes can compose DMAs carrying different PASIDs. 

When executing ENQCMD in the guest, the CPU MSR includes a vPASID 
which, if targeting a mdev, must be converted to pPASID before sent
to the wire. Intel CPU provides a hardware PASID translation capability 
for auto-conversion in the fast path. The user is expected to setup the 
PASID mapping through KVM uAPI, with information about {vpasid, 
ioasid_fd, ioasid}. The ioasid driver provides helper function for KVM 
to figure out the actual pPASID given an IOASID.

With above design /dev/ioasid uAPI is all about I/O address spaces. 
It doesn't include any device routing information, which is only 
indirectly registered to the ioasid driver through VFIO uAPI. For 
example, I/O page fault is always reported to userspace per IOASID, 
although it's physically reported per device (RID+PASID). If there is a 
need of further relaying this fault into the guest, the user is responsible 
of identifying the device attached to this IOASID (randomly pick one if 
multiple attached devices) and then generates a per-device virtual I/O 
page fault into guest. Similarly the iotlb invalidation uAPI describes the 
granularity in the I/O address space (all, or a range), different from the 
underlying IOMMU semantics (domain-wide, PASID-wide, range-based).

I/O page tables routed through PASID are installed in a per-RID PASID 
table structure. Some platforms implement the PASID table in the guest 
physical space (GPA), expecting it managed by the guest. The guest
PASID table is bound to the IOMMU also by attaching to an IOASID, 
representing the per-RID vPASID space. 

We propose the host kernel needs to explicitly track  guest I/O page 
tables even on these platforms, i.e. the same pgtable binding protocol 
should be used universally on all platforms (with only difference on who 
actually writes the PASID table). One opinion from previous discussion 
was treating this special IOASID as a container for all guest I/O page 
tables i.e. hiding them from the host. However this way significantly 
violates the philosophy in this /dev/ioasid proposal. It is not one IOASID 
one address space any more. Device routing information (indirectly 
marking hidden I/O spaces) has to be carried in iotlb invalidation and 
page faulting uAPI to help connect vIOMMU with the underlying 
pIOMMU. This is one design choice to be confirmed with ARM guys.

Devices may sit behind IOMMU's with incompatible capabilities. The
difference may lie in the I/O page table format, or availability of an user
visible uAPI (e.g. hardware nesting). /dev/ioasid is responsible for 
checking the incompatibility between newly-attached device and existing
devices under the specific IOASID and, if found, returning error to user.
Upon such error the user should create a new IOASID for the incompatible
device. 

There is no explicit group enforcement in /dev/ioasid uAPI, due to no 
device notation in this interface as aforementioned. But the ioasid driver 
does implicit check to make sure that devices within an iommu group 
must be all attached to the same IOASID before this IOASID starts to
accept any uAPI command. Otherwise error information is returned to 
the user.

There was a long debate in previous discussion whether VFIO should keep 
explicit container/group semantics in its uAPI. Jason Gunthorpe proposes 
a simplified model where every device bound to VFIO is explicitly listed 
under /dev/vfio thus a device fd can be acquired w/o going through legacy
container/group interface. In this case the user is responsible for 
understanding the group topology and meeting the implicit group check 
criteria enforced in /dev/ioasid. The use case examples in this proposal 
are based on the new model.

Of course for backward compatibility VFIO still needs to keep the existing 
uAPI and vfio iommu type1 will become a shim layer connecting VFIO 
iommu ops to internal ioasid helper functions.

Notes:
-   It might be confusing as IOASID is also used in the kernel (drivers/
    iommu/ioasid.c) to represent PCI PASID or ARM substream ID. We need
    find a better name later to differentiate.

-   PPC has not be considered yet as we haven't got time to fully understand
    its semantics. According to previous discussion there is some generality 
    between PPC window-based scheme and VFIO type1 semantics. Let's 
    first make consensus on this proposal and then further discuss how to 
    extend it to cover PPC's requirement.

-   There is a protocol between vfio group and kvm. Needs to think about
    how it will be affected following this proposal.

-   mdev in this context refers to mediated subfunctions (e.g. Intel SIOV) 
    which can be physically isolated in-between through PASID-granular
    IOMMU protection. Historically people also discussed one usage by 
    mediating a pdev into a mdev. This usage is not covered here, and is 
    supposed to be replaced by Max's work which allows overriding various 
    VFIO operations in vfio-pci driver.

2. uAPI Proposal
----------------------

/dev/ioasid uAPI covers everything about managing I/O address spaces.

/dev/vfio uAPI builds connection between devices and I/O address spaces.

/dev/kvm uAPI is optional required as far as ENQCMD is concerned.


2.1. /dev/ioasid uAPI
+++++++++++++++++

/*
  * Check whether an uAPI extension is supported. 
  *
  * This is for FD-level capabilities, such as locked page pre-registration. 
  * IOASID-level capabilities are reported through IOASID_GET_INFO.
  *
  * Return: 0 if not supported, 1 if supported.
  */
#define IOASID_CHECK_EXTENSION	_IO(IOASID_TYPE, IOASID_BASE + 0)


/*
  * Register user space memory where DMA is allowed.
  *
  * It pins user pages and does the locked memory accounting so sub-
  * sequent IOASID_MAP/UNMAP_DMA calls get faster.
  *
  * When this ioctl is not used, one user page might be accounted
  * multiple times when it is mapped by multiple IOASIDs which are
  * not nested together.
  *
  * Input parameters:
  *	- vaddr;
  *	- size;
  *
  * Return: 0 on success, -errno on failure.
  */
#define IOASID_REGISTER_MEMORY	_IO(IOASID_TYPE, IOASID_BASE + 1)
#define IOASID_UNREGISTER_MEMORY	_IO(IOASID_TYPE, IOASID_BASE + 2)


/*
  * Allocate an IOASID. 
  *
  * IOASID is the FD-local software handle representing an I/O address 
  * space. Each IOASID is associated with a single I/O page table. User 
  * must call this ioctl to get an IOASID for every I/O address space that is
  * intended to be enabled in the IOMMU.
  *
  * A newly-created IOASID doesn't accept any command before it is 
  * attached to a device. Once attached, an empty I/O page table is 
  * bound with the IOMMU then the user could use either DMA mapping 
  * or pgtable binding commands to manage this I/O page table.
  *
  * Device attachment is initiated through device driver uAPI (e.g. VFIO)
  *
  * Return: allocated ioasid on success, -errno on failure.
  */
#define IOASID_ALLOC	_IO(IOASID_TYPE, IOASID_BASE + 3)
#define IOASID_FREE	_IO(IOASID_TYPE, IOASID_BASE + 4)


/*
  * Get information about an I/O address space
  *
  * Supported capabilities:
  *	- VFIO type1 map/unmap;
  *	- pgtable/pasid_table binding
  *	- hardware nesting vs. software nesting;
  *	- ...
  *
  * Related attributes:
  * 	- supported page sizes, reserved IOVA ranges (DMA mapping);
  *	- vendor pgtable formats (pgtable binding);
  *	- number of child IOASIDs (nesting);
  *	- ...
  *
  * Above information is available only after one or more devices are
  * attached to the specified IOASID. Otherwise the IOASID is just a
  * number w/o any capability or attribute.
  *
  * Input parameters:
  *	- u32 ioasid;
  *
  * Output parameters:
  *	- many. TBD.
  */
#define IOASID_GET_INFO	_IO(IOASID_TYPE, IOASID_BASE + 5)


/*
  * Map/unmap process virtual addresses to I/O virtual addresses.
  *
  * Provide VFIO type1 equivalent semantics. Start with the same 
  * restriction e.g. the unmap size should match those used in the 
  * original mapping call. 
  *
  * If IOASID_REGISTER_MEMORY has been called, the mapped vaddr
  * must be already in the preregistered list.
  *
  * Input parameters:
  *	- u32 ioasid;
  *	- refer to vfio_iommu_type1_dma_{un}map
  *
  * Return: 0 on success, -errno on failure.
  */
#define IOASID_MAP_DMA	_IO(IOASID_TYPE, IOASID_BASE + 6)
#define IOASID_UNMAP_DMA	_IO(IOASID_TYPE, IOASID_BASE + 7)


/*
  * Create a nesting IOASID (child) on an existing IOASID (parent)
  *
  * IOASIDs can be nested together, implying that the output address 
  * from one I/O page table (child) must be further translated by 
  * another I/O page table (parent).
  *
  * As the child adds essentially another reference to the I/O page table 
  * represented by the parent, any device attached to the child ioasid 
  * must be already attached to the parent.
  *
  * In concept there is no limit on the number of the nesting levels. 
  * However for the majority case one nesting level is sufficient. The
  * user should check whether an IOASID supports nesting through 
  * IOASID_GET_INFO. For example, if only one nesting level is allowed,
  * the nesting capability is reported only on the parent instead of the
  * child.
  *
  * User also needs check (via IOASID_GET_INFO) whether the nesting 
  * is implemented in hardware or software. If software-based, DMA 
  * mapping protocol should be used on the child IOASID. Otherwise, 
  * the child should be operated with pgtable binding protocol.
  *
  * Input parameters:
  *	- u32 parent_ioasid;
  *
  * Return: child_ioasid on success, -errno on failure;
  */
#define IOASID_CREATE_NESTING	_IO(IOASID_TYPE, IOASID_BASE + 8)


/*
  * Bind an user-managed I/O page table with the IOMMU
  *
  * Because user page table is untrusted, IOASID nesting must be enabled 
  * for this ioasid so the kernel can enforce its DMA isolation policy 
  * through the parent ioasid.
  *
  * Pgtable binding protocol is different from DMA mapping. The latter 
  * has the I/O page table constructed by the kernel and updated 
  * according to user MAP/UNMAP commands. With pgtable binding the 
  * whole page table is created and updated by userspace, thus different 
  * set of commands are required (bind, iotlb invalidation, page fault, etc.).
  *
  * Because the page table is directly walked by the IOMMU, the user 
  * must  use a format compatible to the underlying hardware. It can 
  * check the format information through IOASID_GET_INFO.
  *
  * The page table is bound to the IOMMU according to the routing 
  * information of each attached device under the specified IOASID. The
  * routing information (RID and optional PASID) is registered when a 
  * device is attached to this IOASID through VFIO uAPI. 
  *
  * Input parameters:
  *	- child_ioasid;
  *	- address of the user page table;
  *	- formats (vendor, address_width, etc.);
  * 
  * Return: 0 on success, -errno on failure.
  */
#define IOASID_BIND_PGTABLE		_IO(IOASID_TYPE, IOASID_BASE + 9)
#define IOASID_UNBIND_PGTABLE	_IO(IOASID_TYPE, IOASID_BASE + 10)


/*
  * Bind an user-managed PASID table to the IOMMU
  *
  * This is required for platforms which place PASID table in the GPA space.
  * In this case the specified IOASID represents the per-RID PASID space.
  *
  * Alternatively this may be replaced by IOASID_BIND_PGTABLE plus a
  * special flag to indicate the difference from normal I/O address spaces.
  *
  * The format info of the PASID table is reported in IOASID_GET_INFO.
  *
  * As explained in the design section, user-managed I/O page tables must
  * be explicitly bound to the kernel even on these platforms. It allows
  * the kernel to uniformly manage I/O address spaces cross all platforms.
  * Otherwise, the iotlb invalidation and page faulting uAPI must be hacked
  * to carry device routing information to indirectly mark the hidden I/O
  * address spaces.
  *
  * Input parameters:
  *	- child_ioasid;
  *	- address of PASID table;
  *	- formats (vendor, size, etc.);
  *
  * Return: 0 on success, -errno on failure.
  */
#define IOASID_BIND_PASID_TABLE	_IO(IOASID_TYPE, IOASID_BASE + 11)
#define IOASID_UNBIND_PASID_TABLE	_IO(IOASID_TYPE, IOASID_BASE + 12)


/*
  * Invalidate IOTLB for an user-managed I/O page table
  *
  * Unlike what's defined in include/uapi/linux/iommu.h, this command 
  * doesn't allow the user to specify cache type and likely support only
  * two granularities (all, or a specified range) in the I/O address space.
  *
  * Physical IOMMU have three cache types (iotlb, dev_iotlb and pasid
  * cache). If the IOASID represents an I/O address space, the invalidation
  * always applies to the iotlb (and dev_iotlb if enabled). If the IOASID
  * represents a vPASID space, then this command applies to the PASID
  * cache.
  *
  * Similarly this command doesn't provide IOMMU-like granularity
  * info (domain-wide, pasid-wide, range-based), since it's all about the
  * I/O address space itself. The ioasid driver walks the attached
  * routing information to match the IOMMU semantics under the
  * hood. 
  *
  * Input parameters:
  *	- child_ioasid;
  *	- granularity
  * 
  * Return: 0 on success, -errno on failure
  */
#define IOASID_INVALIDATE_CACHE	_IO(IOASID_TYPE, IOASID_BASE + 13)


/*
  * Page fault report and response
  *
  * This is TBD. Can be added after other parts are cleared up. Likely it 
  * will be a ring buffer shared between user/kernel, an eventfd to notify 
  * the user and an ioctl to complete the fault.
  *
  * The fault data is per I/O address space, i.e.: IOASID + faulting_addr
  */


/*
  * Dirty page tracking 
  *
  * Track and report memory pages dirtied in I/O address spaces. There 
  * is an ongoing work by Kunkun Jiang by extending existing VFIO type1. 
  * It needs be adapted to /dev/ioasid later.
  */


2.2. /dev/vfio uAPI
++++++++++++++++

/*
  * Bind a vfio_device to the specified IOASID fd
  *
  * Multiple vfio devices can be bound to a single ioasid_fd, but a single 
  * vfio device should not be bound to multiple ioasid_fd's. 
  *
  * Input parameters:
  *	- ioasid_fd;
  *
  * Return: 0 on success, -errno on failure.
  */
#define VFIO_BIND_IOASID_FD		_IO(VFIO_TYPE, VFIO_BASE + 22)
#define VFIO_UNBIND_IOASID_FD	_IO(VFIO_TYPE, VFIO_BASE + 23)


/*
  * Attach a vfio device to the specified IOASID
  *
  * Multiple vfio devices can be attached to the same IOASID, and vice 
  * versa. 
  *
  * User may optionally provide a "virtual PASID" to mark an I/O page 
  * table on this vfio device. Whether the virtual PASID is physically used 
  * or converted to another kernel-allocated PASID is a policy in vfio device 
  * driver.
  *
  * There is no need to specify ioasid_fd in this call due to the assumption 
  * of 1:1 connection between vfio device and the bound fd.
  *
  * Input parameter:
  *	- ioasid;
  *	- flag;
  *	- user_pasid (if specified);
  * 
  * Return: 0 on success, -errno on failure.
  */
#define VFIO_ATTACH_IOASID		_IO(VFIO_TYPE, VFIO_BASE + 24)
#define VFIO_DETACH_IOASID		_IO(VFIO_TYPE, VFIO_BASE + 25)


2.3. KVM uAPI
++++++++++++

/*
  * Update CPU PASID mapping
  *
  * This is necessary when ENQCMD will be used in the guest while the
  * targeted device doesn't accept the vPASID saved in the CPU MSR.
  *
  * This command allows user to set/clear the vPASID->pPASID mapping
  * in the CPU, by providing the IOASID (and FD) information representing
  * the I/O address space marked by this vPASID.
  *
  * Input parameters:
  *	- user_pasid;
  *	- ioasid_fd;
  *	- ioasid;
  */
#define KVM_MAP_PASID	_IO(KVMIO, 0xf0)
#define KVM_UNMAP_PASID	_IO(KVMIO, 0xf1)


3. Sample structures and helper functions
--------------------------------------------------------

Three helper functions are provided to support VFIO_BIND_IOASID_FD:

	struct ioasid_ctx *ioasid_ctx_fdget(int fd);
	int ioasid_register_device(struct ioasid_ctx *ctx, struct ioasid_dev *dev);
	int ioasid_unregister_device(struct ioasid_dev *dev);

An ioasid_ctx is created for each fd:

	struct ioasid_ctx {
		// a list of allocated IOASID data's
		struct list_head		ioasid_list;
		// a list of registered devices
		struct list_head		dev_list;
		// a list of pre-registered virtual address ranges
		struct list_head		prereg_list;
	};

Each registered device is represented by ioasid_dev:

	struct ioasid_dev {
		struct list_head		next;
		struct ioasid_ctx	*ctx;
		// always be the physical device
		struct device 		*device;
		struct kref		kref;
	};

Because we assume one vfio_device connected to at most one ioasid_fd, 
here ioasid_dev could be embedded in vfio_device and then linked to 
ioasid_ctx->dev_list when registration succeeds. For mdev the struct
device should be the pointer to the parent device. PASID marking this
mdev is specified later when VFIO_ATTACH_IOASID.

An ioasid_data is created when IOASID_ALLOC, as the main object 
describing characteristics about an I/O page table:

	struct ioasid_data {
		// link to ioasid_ctx->ioasid_list
		struct list_head		next;

		// the IOASID number
		u32			ioasid;

		// the handle to convey iommu operations
		// hold the pgd (TBD until discussing iommu api)
		struct iommu_domain *domain;

		// map metadata (vfio type1 semantics)
		struct rb_node		dma_list;

		// pointer to user-managed pgtable (for nesting case)
		u64			user_pgd;

		// link to the parent ioasid (for nesting)
		struct ioasid_data	*parent;

		// cache the global PASID shared by ENQCMD-capable
		// devices (see below explanation in section 4)
		u32			pasid;

		// a list of device attach data (routing information)
		struct list_head		attach_data;

		// a list of partially-attached devices (group)
		struct list_head		partial_devices;

		// a list of fault_data reported from the iommu layer
		struct list_head		fault_data;

		...
	}

ioasid_data and iommu_domain have overlapping roles as both are 
introduced to represent an I/O address space. It is still a big TBD how 
the two should be corelated or even merged, and whether new iommu 
ops are required to handle RID+PASID explicitly. We leave this as open 
for now as this proposal is mainly about uAPI. For simplification 
purpose the two objects are kept separate in this context, assuming an 
1:1 connection in-between and the domain as the place-holder 
representing the 1st class object in the iommu ops. 

Two helper functions are provided to support VFIO_ATTACH_IOASID:

	struct attach_info {
		u32	ioasid;
		// If valid, the PASID to be used physically
		u32	pasid;
	};
	int ioasid_device_attach(struct ioasid_dev *dev, 
		struct attach_info info);
	int ioasid_device_detach(struct ioasid_dev *dev, u32 ioasid);

The pasid parameter is optionally provided based on the policy in vfio
device driver. It could be the PASID marking the default I/O address 
space for a mdev, or the user-provided PASID marking an user I/O page
table, or another kernel-allocated PASID backing the user-provided one.
Please check next section for detail explanation.

A new object is introduced and linked to ioasid_data->attach_data for 
each successful attach operation:

	struct ioasid_attach_data {
		struct list_head		next;
		struct ioasid_dev	*dev;
		u32 			pasid;
	}

As explained in the design section, there is no explicit group enforcement
in /dev/ioasid uAPI or helper functions. But the ioasid driver does
implicit group check - before every device within an iommu group is 
attached to this IOASID, the previously-attached devices in this group are
put in ioasid_data->partial_devices. The IOASID rejects any command if
the partial_devices list is not empty.

Then is the last helper function:
	u32 ioasid_get_global_pasid(struct ioasid_ctx *ctx, 
		u32 ioasid, bool alloc);

ioasid_get_global_pasid is necessary in scenarios where multiple devices 
want to share a same PASID value on the attached I/O page table (e.g. 
when ENQCMD is enabled, as explained in next section). We need a 
centralized place (ioasid_data->pasid) to hold this value (allocated when
first called with alloc=true). vfio device driver calls this function (alloc=
true) to get the global PASID for an ioasid before calling ioasid_device_
attach. KVM also calls this function (alloc=false) to setup PASID translation 
structure when user calls KVM_MAP_PASID.

4. PASID Virtualization
------------------------------

When guest SVA (vSVA) is enabled, multiple GVA address spaces are 
created on the assigned vfio device. This leads to the concepts of 
"virtual PASID" (vPASID) vs. "physical PASID" (pPASID). vPASID is assigned 
by the guest to mark an GVA address space while pPASID is the one 
selected by the host and actually routed in the wire.

vPASID is conveyed to the kernel when user calls VFIO_ATTACH_IOASID.

vfio device driver translates vPASID to pPASID before calling ioasid_attach_
device, with two factors to be considered:

-    Whether vPASID is directly used (vPASID==pPASID) in the wire, or 
     should be instead converted to a newly-allocated one (vPASID!=
     pPASID);

-    If vPASID!=pPASID, whether pPASID is allocated from per-RID PASID
     space or a global PASID space (implying sharing pPASID cross devices,
     e.g. when supporting Intel ENQCMD which puts PASID in a CPU MSR
     as part of the process context);

The actual policy depends on pdev vs. mdev, and whether ENQCMD is
supported. There are three possible scenarios:

(Note: /dev/ioasid uAPI is not affected by underlying PASID virtualization 
policies.)

1)  pdev (w/ or w/o ENQCMD): vPASID==pPASID

     vPASIDs are directly programmed by the guest to the assigned MMIO 
     bar, implying all DMAs out of this device having vPASID in the packet 
     header. This mandates vPASID==pPASID, sort of delegating the entire 
     per-RID PASID space to the guest.

     When ENQCMD is enabled, the CPU MSR when running a guest task
     contains a vPASID. In this case the CPU PASID translation capability 
     should be disabled so this vPASID in CPU MSR is directly sent to the
     wire.

     This ensures consistent vPASID usage on pdev regardless of the 
     workload submitted through a MMIO register or ENQCMD instruction.

2)  mdev: vPASID!=pPASID (per-RID if w/o ENQCMD, otherwise global)

     PASIDs are also used by kernel to mark the default I/O address space 
     for mdev, thus cannot be delegated to the guest. Instead, the mdev 
     driver must allocate a new pPASID for each vPASID (thus vPASID!=
     pPASID) and then use pPASID when attaching this mdev to an ioasid.

     The mdev driver needs cache the PASID mapping so in mediation 
     path vPASID programmed by the guest can be converted to pPASID 
     before updating the physical MMIO register. The mapping should
     also be saved in the CPU PASID translation structure (via KVM uAPI), 
     so the vPASID saved in the CPU MSR is auto-translated to pPASID 
     before sent to the wire, when ENQCMD is enabled. 

     Generally pPASID could be allocated from the per-RID PASID space
     if all mdev's created on the parent device don't support ENQCMD.

     However if the parent supports ENQCMD-capable mdev, pPASIDs
     must be allocated from a global pool because the CPU PASID 
     translation structure is per-VM. It implies that when an guest I/O 
     page table is attached to two mdevs with a single vPASID (i.e. bind 
     to the same guest process), a same pPASID should be used for 
     both mdevs even when they belong to different parents. Sharing
     pPASID cross mdevs is achieved by calling aforementioned ioasid_
     get_global_pasid().

3)  Mix pdev/mdev together

     Above policies are per device type thus are not affected when mixing 
     those device types together (when assigned to a single guest). However, 
     there is one exception - when both pdev/mdev support ENQCMD.

     Remember the two types have conflicting requirements on whether 
     CPU PASID translation should be enabled. This capability is per-VM, 
     and must be enabled for mdev isolation. When enabled, pdev will 
     receive a mdev pPASID violating its vPASID expectation.

     In previous thread a PASID range split scheme was discussed to support
     this combination, but we haven't worked out a clean uAPI design yet.
     Therefore in this proposal we decide to not support it, implying the 
     user should have some intelligence to avoid such scenario. It could be
     a TODO task for future.

In spite of those subtle considerations, the kernel implementation could
start simple, e.g.:

-    v==p for pdev;
-    v!=p and always use a global PASID pool for all mdev's;

Regardless of the kernel policy, the user policy is unchanged:

-    provide vPASID when calling VFIO_ATTACH_IOASID;
-    call KVM uAPI to setup CPU PASID translation if ENQCMD-capable mdev;
-    Don't expose ENQCMD capability on both pdev and mdev;

Sample user flow is described in section 5.5.

5. Use Cases and Flows
-------------------------------

Here assume VFIO will support a new model where every bound device
is explicitly listed under /dev/vfio thus a device fd can be acquired w/o 
going through legacy container/group interface. For illustration purpose
those devices are just called dev[1...N]:

	device_fd[1...N] = open("/dev/vfio/devices/dev[1...N]", mode);

As explained earlier, one IOASID fd is sufficient for all intended use cases:

	ioasid_fd = open("/dev/ioasid", mode);

For simplicity below examples are all made for the virtualization story.
They are representative and could be easily adapted to a non-virtualization
scenario.

Three types of IOASIDs are considered:

	gpa_ioasid[1...N]: 	for GPA address space
	giova_ioasid[1...N]:	for guest IOVA address space
	gva_ioasid[1...N]:	for guest CPU VA address space

At least one gpa_ioasid must always be created per guest, while the other 
two are relevant as far as vIOMMU is concerned.

Examples here apply to both pdev and mdev, if not explicitly marked out
(e.g. in section 5.5). VFIO device driver in the kernel will figure out the 
associated routing information in the attaching operation.

For illustration simplicity, IOASID_CHECK_EXTENSION and IOASID_GET_
INFO are skipped in these examples.

5.1. A simple example
++++++++++++++++++

Dev1 is assigned to the guest. One gpa_ioasid is created. The GPA address
space is managed through DMA mapping protocol:

	/* Bind device to IOASID fd */
	device_fd = open("/dev/vfio/devices/dev1", mode);
	ioasid_fd = open("/dev/ioasid", mode);
	ioctl(device_fd, VFIO_BIND_IOASID_FD, ioasid_fd);

	/* Attach device to IOASID */
	gpa_ioasid = ioctl(ioasid_fd, IOASID_ALLOC);
	at_data = { .ioasid = gpa_ioasid};
	ioctl(device_fd, VFIO_ATTACH_IOASID, &at_data);

	/* Setup GPA mapping */
	dma_map = {
		.ioasid	= gpa_ioasid;
		.iova	= 0;		// GPA
		.vaddr	= 0x40000000;	// HVA
		.size	= 1GB;
	};
	ioctl(ioasid_fd, IOASID_DMA_MAP, &dma_map);

If the guest is assigned with more than dev1, user follows above sequence
to attach other devices to the same gpa_ioasid i.e. sharing the GPA 
address space cross all assigned devices.

5.2. Multiple IOASIDs (no nesting)
++++++++++++++++++++++++++++

Dev1 and dev2 are assigned to the guest. vIOMMU is enabled. Initially
both devices are attached to gpa_ioasid. After boot the guest creates 
an GIOVA address space (giova_ioasid) for dev2, leaving dev1 in pass
through mode (gpa_ioasid).

Suppose IOASID nesting is not supported in this case. Qemu need to
generate shadow mappings in userspace for giova_ioasid (like how
VFIO works today).

To avoid duplicated locked page accounting, it's recommended to pre-
register the virtual address range that will be used for DMA:

	device_fd1 = open("/dev/vfio/devices/dev1", mode);
	device_fd2 = open("/dev/vfio/devices/dev2", mode);
	ioasid_fd = open("/dev/ioasid", mode);
	ioctl(device_fd1, VFIO_BIND_IOASID_FD, ioasid_fd);
	ioctl(device_fd2, VFIO_BIND_IOASID_FD, ioasid_fd);

	/* pre-register the virtual address range for accounting */
	mem_info = { .vaddr = 0x40000000; .size = 1GB };
	ioctl(ioasid_fd, IOASID_REGISTER_MEMORY, &mem_info);

	/* Attach dev1 and dev2 to gpa_ioasid */
	gpa_ioasid = ioctl(ioasid_fd, IOASID_ALLOC);
	at_data = { .ioasid = gpa_ioasid};
	ioctl(device_fd1, VFIO_ATTACH_IOASID, &at_data);
	ioctl(device_fd2, VFIO_ATTACH_IOASID, &at_data);

	/* Setup GPA mapping */
	dma_map = {
		.ioasid	= gpa_ioasid;
		.iova	= 0; 		// GPA
		.vaddr	= 0x40000000;	// HVA
		.size	= 1GB;
	};
	ioctl(ioasid_fd, IOASID_DMA_MAP, &dma_map);

	/* After boot, guest enables an GIOVA space for dev2 */
	giova_ioasid = ioctl(ioasid_fd, IOASID_ALLOC);

	/* First detach dev2 from previous address space */
	at_data = { .ioasid = gpa_ioasid};
	ioctl(device_fd2, VFIO_DETACH_IOASID, &at_data);

	/* Then attach dev2 to the new address space */
	at_data = { .ioasid = giova_ioasid};
	ioctl(device_fd2, VFIO_ATTACH_IOASID, &at_data);

	/* Setup a shadow DMA mapping according to vIOMMU
	  * GIOVA (0x2000) -> GPA (0x1000) -> HVA (0x40001000)
	  */
	dma_map = {
		.ioasid	= giova_ioasid;
		.iova	= 0x2000; 	// GIOVA
		.vaddr	= 0x40001000;	// HVA
		.size	= 4KB;
	};
	ioctl(ioasid_fd, IOASID_DMA_MAP, &dma_map);

5.3. IOASID nesting (software)
+++++++++++++++++++++++++

Same usage scenario as 5.2, with software-based IOASID nesting 
available. In this mode it is the kernel instead of user to create the
shadow mapping.

The flow before guest boots is same as 5.2, except one point. Because 
giova_ioasid is nested on gpa_ioasid, locked accounting is only 
conducted for gpa_ioasid. So it's not necessary to pre-register virtual 
memory.

To save space we only list the steps after boots (i.e. both dev1/dev2
have been attached to gpa_ioasid before guest boots):

	/* After boots */
	/* Make GIOVA space nested on GPA space */
	giova_ioasid = ioctl(ioasid_fd, IOASID_CREATE_NESTING,
				gpa_ioasid);

	/* Attach dev2 to the new address space (child)
	  * Note dev2 is still attached to gpa_ioasid (parent)
	  */
	at_data = { .ioasid = giova_ioasid};
	ioctl(device_fd2, VFIO_ATTACH_IOASID, &at_data);

	/* Setup a GIOVA->GPA mapping for giova_ioasid, which will be 
	  * merged by the kernel with GPA->HVA mapping of gpa_ioasid
	  * to form a shadow mapping.
	  */
	dma_map = {
		.ioasid	= giova_ioasid;
		.iova	= 0x2000;	// GIOVA
		.vaddr	= 0x1000;	// GPA
		.size	= 4KB;
	};
	ioctl(ioasid_fd, IOASID_DMA_MAP, &dma_map);

5.4. IOASID nesting (hardware)
+++++++++++++++++++++++++

Same usage scenario as 5.2, with hardware-based IOASID nesting
available. In this mode the pgtable binding protocol is used to 
bind the guest IOVA page table with the IOMMU:

	/* After boots */
	/* Make GIOVA space nested on GPA space */
	giova_ioasid = ioctl(ioasid_fd, IOASID_CREATE_NESTING,
				gpa_ioasid);

	/* Attach dev2 to the new address space (child)
	  * Note dev2 is still attached to gpa_ioasid (parent)
	  */
	at_data = { .ioasid = giova_ioasid};
	ioctl(device_fd2, VFIO_ATTACH_IOASID, &at_data);

	/* Bind guest I/O page table  */
	bind_data = {
		.ioasid	= giova_ioasid;
		.addr	= giova_pgtable;
		// and format information
	};
	ioctl(ioasid_fd, IOASID_BIND_PGTABLE, &bind_data);

	/* Invalidate IOTLB when required */
	inv_data = {
		.ioasid	= giova_ioasid;
		// granular information
	};
	ioctl(ioasid_fd, IOASID_INVALIDATE_CACHE, &inv_data);

	/* See 5.6 for I/O page fault handling */
	
5.5. Guest SVA (vSVA)
++++++++++++++++++

After boots the guest further create a GVA address spaces (gpasid1) on 
dev1. Dev2 is not affected (still attached to giova_ioasid).

As explained in section 4, user should avoid expose ENQCMD on both
pdev and mdev.

The sequence applies to all device types (being pdev or mdev), except
one additional step to call KVM for ENQCMD-capable mdev:

	/* After boots */
	/* Make GVA space nested on GPA space */
	gva_ioasid = ioctl(ioasid_fd, IOASID_CREATE_NESTING,
				gpa_ioasid);

	/* Attach dev1 to the new address space and specify vPASID */
	at_data = {
		.ioasid		= gva_ioasid;
		.flag 		= IOASID_ATTACH_USER_PASID;
		.user_pasid	= gpasid1;
	};
	ioctl(device_fd1, VFIO_ATTACH_IOASID, &at_data);

	/* if dev1 is ENQCMD-capable mdev, update CPU PASID 
	  * translation structure through KVM
	  */
	pa_data = {
		.ioasid_fd	= ioasid_fd;
		.ioasid		= gva_ioasid;
		.guest_pasid	= gpasid1;
	};
	ioctl(kvm_fd, KVM_MAP_PASID, &pa_data);

	/* Bind guest I/O page table  */
	bind_data = {
		.ioasid	= gva_ioasid;
		.addr	= gva_pgtable1;
		// and format information
	};
	ioctl(ioasid_fd, IOASID_BIND_PGTABLE, &bind_data);

	...


5.6. I/O page fault
+++++++++++++++

(uAPI is TBD. Here is just about the high-level flow from host IOMMU driver
to guest IOMMU driver and backwards).

-   Host IOMMU driver receives a page request with raw fault_data {rid, 
    pasid, addr};

-   Host IOMMU driver identifies the faulting I/O page table according to
    information registered by IOASID fault handler;

-   IOASID fault handler is called with raw fault_data (rid, pasid, addr), which 
    is saved in ioasid_data->fault_data (used for response);

-   IOASID fault handler generates an user fault_data (ioasid, addr), links it 
    to the shared ring buffer and triggers eventfd to userspace;

-   Upon received event, Qemu needs to find the virtual routing information 
    (v_rid + v_pasid) of the device attached to the faulting ioasid. If there are 
    multiple, pick a random one. This should be fine since the purpose is to
    fix the I/O page table on the guest;

-   Qemu generates a virtual I/O page fault through vIOMMU into guest,
    carrying the virtual fault data (v_rid, v_pasid, addr);

-   Guest IOMMU driver fixes up the fault, updates the I/O page table, and
    then sends a page response with virtual completion data (v_rid, v_pasid, 
    response_code) to vIOMMU;

-   Qemu finds the pending fault event, converts virtual completion data 
    into (ioasid, response_code), and then calls a /dev/ioasid ioctl to 
    complete the pending fault;

-   /dev/ioasid finds out the pending fault data {rid, pasid, addr} saved in 
    ioasid_data->fault_data, and then calls iommu api to complete it with
    {rid, pasid, response_code};

5.7. BIND_PASID_TABLE
++++++++++++++++++++

PASID table is put in the GPA space on some platform, thus must be updated
by the guest. It is treated as another user page table to be bound with the 
IOMMU.

As explained earlier, the user still needs to explicitly bind every user I/O 
page table to the kernel so the same pgtable binding protocol (bind, cache 
invalidate and fault handling) is unified cross platforms.

vIOMMUs may include a caching mode (or paravirtualized way) which, once 
enabled, requires the guest to invalidate PASID cache for any change on the 
PASID table. This allows Qemu to track the lifespan of guest I/O page tables.

In case of missing such capability, Qemu could enable write-protection on
the guest PASID table to achieve the same effect.

	/* After boots */
	/* Make vPASID space nested on GPA space */
	pasidtbl_ioasid = ioctl(ioasid_fd, IOASID_CREATE_NESTING,
				gpa_ioasid);

	/* Attach dev1 to pasidtbl_ioasid */
	at_data = { .ioasid = pasidtbl_ioasid};
	ioctl(device_fd1, VFIO_ATTACH_IOASID, &at_data);

	/* Bind PASID table */
	bind_data = {
		.ioasid	= pasidtbl_ioasid;
		.addr	= gpa_pasid_table;
		// and format information
	};
	ioctl(ioasid_fd, IOASID_BIND_PASID_TABLE, &bind_data);

	/* vIOMMU detects a new GVA I/O space created */
	gva_ioasid = ioctl(ioasid_fd, IOASID_CREATE_NESTING,
				gpa_ioasid);

	/* Attach dev1 to the new address space, with gpasid1 */
	at_data = {
		.ioasid		= gva_ioasid;
		.flag 		= IOASID_ATTACH_USER_PASID;
		.user_pasid	= gpasid1;
	};
	ioctl(device_fd1, VFIO_ATTACH_IOASID, &at_data);

	/* Bind guest I/O page table. Because SET_PASID_TABLE has been
	  * used, the kernel will not update the PASID table. Instead, just
	  * track the bound I/O page table for handling invalidation and
	  * I/O page faults.
	  */
	bind_data = {
		.ioasid	= gva_ioasid;
		.addr	= gva_pgtable1;
		// and format information
	};
	ioctl(ioasid_fd, IOASID_BIND_PGTABLE, &bind_data);

	...

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

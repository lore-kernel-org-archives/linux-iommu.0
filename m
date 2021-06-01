Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05137C47093
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 07:50:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB95F613AF
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 07:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB95F613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79CFE83C88;
	Tue,  1 Jun 2021 07:50:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jPeiuqSV8ug1; Tue,  1 Jun 2021 07:50:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BEAE83C7B;
	Tue,  1 Jun 2021 07:50:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3169DC000E;
	Tue,  1 Jun 2021 07:50:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46222C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 324CD4046A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:50:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id apvepPtBWFfm for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 07:50:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E6D140459
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:50:45 +0000 (UTC)
IronPort-SDR: 9Z1G1jsBUKGm2uzzZCj8OEfxbI74ZqQd/VSb+Z8hJ4JP8OvkPRJ/DsGIDicwgHePSAWEn5J8AF
 xJBbEGbNUM6w==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="183856852"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; d="scan'208";a="183856852"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2021 00:50:45 -0700
IronPort-SDR: z58GGvusPGbLzpMc6/jU8OeMp9dg1QUcVIrxQxq7iLZV3eirBO4J3m46oJZ6SbB0ae9ibqdO5v
 FfF4l7+X9Skw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; d="scan'208";a="548978142"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga004.jf.intel.com with ESMTP; 01 Jun 2021 00:50:44 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 00:50:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 1 Jun 2021 00:50:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 1 Jun 2021 00:50:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtBethPbEEBqifwmKGO82Hc/erxybE2LemprrePpRWAHyVrRkKo5pj5KURzbDSStp9gD/I0rFfObFaI/FLWzCX4CDk38rxIv2a40iOjbIKdYa3G3QIGQ6d3JQWhzoJtnO2aNFkJq97Hs2B8ku6D+uiJs/NWHcH/M0QgjY5BekwVVFCCt9kJai5QykOjiS2v5PeagMwnsgeiHOFJBhkzEk41aQl3I5X1vQyUdEnopdPLQ3YkQl/w0X4Kc/KA7zjvJsBwtEbbBA3BXFNV6oFKbrv7EmCckvsMrdSB25uNL+bqDrsmCVx3OvN4bRT5C5jUXC6trQb+7WTt4j+J3D49OAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++5NuWWzEWDHbSz6oxfJc68CjWVxT14RWthT6hGOO3Q=;
 b=kf29vtYXaRP4Ozb0zlRwoNbihiiYS5TVuCRarTA8P43980Ra3NKbZtSaiXebnt5DhgL2Xy9RdYQ4o3qLhOdV3WsRHJb2v5Ly+g80uOkAFZYsY7304R/d8aexllxI7xjJ4Gab3CNXoEnViYvycWfYWNqYM3MBFnK1Y+zLFtUHwhstv/X7W/JJAMVn720U14DNrhHHl6ElEWbYVsAK0zeXkXQznTqq/Wrpbza2TkCBW2wFZX6LaySqPuXUAgtzsedKCzxhJ8ZFIJ8d/EerhhswLnKtHS9rbsCHRapOfd6xBxJ6LriW/JFa1/368U05jann/tTiZkprIJ5d9pPfqN1IAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++5NuWWzEWDHbSz6oxfJc68CjWVxT14RWthT6hGOO3Q=;
 b=ftpvOLJG4dZHSLKvHdS85loLXhCE5rDApv+D4pVEJLidi5idfxHfaZHL3VU3PmP8s0YfM7VeyXICq7zRK2B9vG5DltgSy61GpQFTrZuA3zBdlqio9b/WJmGyEFnO8jCP8d3M5Sm1P2Xy+a+UsqyDV0kgNIpXL2ZgA2oB4O+B+K0=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2221.namprd11.prod.outlook.com (2603:10b6:301:53::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 07:50:41 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 07:50:41 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwBEK5yAALaxj6A=
Date: Tue, 1 Jun 2021 07:50:40 +0000
Message-ID: <MWHPR11MB18861BC9850B615617DE51948C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YLEY6yAF1osdtS3e@myrica>
In-Reply-To: <YLEY6yAF1osdtS3e@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.142.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58a49500-f3ec-47e2-aeef-08d924d1f40f
x-ms-traffictypediagnostic: MWHPR1101MB2221:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2221A463EDDC82E63B1003A68C3E9@MWHPR1101MB2221.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zjbtb/Ope4Zygh0p2tP6McKOPZV25gIVsjgO6cwcNN5lMP5Lfz1Xkf5Hl8WtZrLHw+L3u9XBEoXhM8CTFj5pTqUAwkVNKLrh4StyMd2o44KsNqpLeapTYmGNWYoPA96X2820dOpX4z+ZrMpOX1OFw2r3Y7e8hBwZWae3wTKXQuyVyRhH6xlYeHUOxS6frWjo9DX0rt2lWvi30d6GbNNSDkq5FrscsZd98ARNnzpFg1hcaMJuhGnJjaTPHUvOa0p2KMNLzvb8LqUZITuSc2NBcA2hXdAvaABHEaIdptMIuvFY5TBqy8pJ5a7h+YDhQxorUETMdH2ZKwkA8x2L4WQIbEC9aY13BLH5ROMvFTWytg1O1q1Fl7uj4KhdlqtJGtxdEuXLLWl/iljigHOqwjaqDSnkyhcZRIZPag0OiuFi99an8ew2fee936+aRQ0agerYaiauDUNSdVEEjmAN8Q9MhogKTR1DXCHQnY/quhBm/W1Q3ahmcb9LPJRsFRkBcN+NlAMCro5IHlhCDr5BSX9ln76CrXZlTRSY0Z6bFWiMN4fzWb+KPnkyEeDJv1OrfzXNQ7gGwJ7MB3DXkgbmehGOBvki4UIilXmkMw4DcHgZyrE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(366004)(39860400002)(346002)(396003)(376002)(8676002)(9686003)(55016002)(478600001)(7696005)(6916009)(8936002)(52536014)(2906002)(54906003)(316002)(26005)(6506007)(7416002)(71200400001)(66446008)(122000001)(186003)(66946007)(33656002)(66476007)(66556008)(64756008)(76116006)(5660300002)(83380400001)(4326008)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nAa+dH+kH1+en+V3edezpMYrWVZfPPI+whrsBvYImKuQ5abGNwRMwZJv8rys?=
 =?us-ascii?Q?153v4dOiU9M5VcfC8JprBwi/AHSFshl4RAolVw7W2lPqqImpZwQrAdWKNda3?=
 =?us-ascii?Q?7Ox3SVGcm8kxgp9BLwLC+Svhib/tcjvOs0EE7lauvsY/wQPreF++7v62BuLC?=
 =?us-ascii?Q?nkfL7M4r2DQhXahsX6nPD76OV1JxeHMfwojkWAcbothE6DpUocttz9eH3HKf?=
 =?us-ascii?Q?Wj7vJtCqxjPwrycsmFTc2uFNmPjnXKe9MCamkbwrbyU/Mqdyqq3Zw1jefb/i?=
 =?us-ascii?Q?WRa9DCBsNDIjBgh7n2cvBAsrPPLKzLmLGb/py+PEuPrebhpxlznuBZAWr/FI?=
 =?us-ascii?Q?oW+tfxt2cv2rEqMwcRf/Ei/h60dlvjNlQ7HBu6t/tGcOe3owi3xBMW6WwN7B?=
 =?us-ascii?Q?uAid8FgaH0QIfc5FzMmr8kpeRmLa/Y/RFyr+gUuVQNNrG5WtIM+X9unFv/vZ?=
 =?us-ascii?Q?Ya3tVbTwtOOAo+st7QI7Jj7jh87v1VfnPDVTxodpsx4hSfYuQ85YkpQuMFku?=
 =?us-ascii?Q?OiRq48SjHy0lmdTN7lmaSWYmHI1S5ekueJ5K2XTB/8j76GjVsIcdXkyzebMc?=
 =?us-ascii?Q?iRj5eYQw7MrZw2TavVMpNuPTTvKeKF042P+xiZfkqOA6SAbXGT9plDAPovEa?=
 =?us-ascii?Q?PHrNviZoH940mroLLuZrpiF7b5nnRA50lrYcr936ZTO8YVJMhGME5cU4RN11?=
 =?us-ascii?Q?NFPm4Sg+ZR8hVa4GtwmlbC9iuA0Q3v0E5ZqeROAgXRT62mvo5gHRxMGmKiaa?=
 =?us-ascii?Q?xsojZLc28ulyo+3f9e3zJcvkW0j4YKGLEokgT6XyL6S8jZycA8Bz7PKDzO3K?=
 =?us-ascii?Q?MRGbyZQ8+8sxV7LH+sitpgXUdQ+K6eKMqM+/+yq0TNOHM2Px3CGSJIBeJaUi?=
 =?us-ascii?Q?A/etRevff8qG8tbbwVZqm4Pd95U+13/7WHbZBze1pNIZbPk94T9BE6YOd6ZZ?=
 =?us-ascii?Q?lzyS+EAHIAht5d8crl4U28zVTtFr8SEST14KKquNjwUv09VnptyADyG+TZ2S?=
 =?us-ascii?Q?EtAXlGHnSmjcAN1+g84rtN4/qSpvNjjTkB0RHQR/ZPwjnwft1/OnkjGUYOFF?=
 =?us-ascii?Q?gZgpUNANMk4rj6HLt1dsYurYIyuyYFFnv/G0JIKNvFrNjtgT54jjxapA22u5?=
 =?us-ascii?Q?vMBJWZDcwZOTO28Nb3c+CEuP28hcu9zcYiSb8ef9Uh4goU1edgYc7LeSVrsH?=
 =?us-ascii?Q?hGY491AYY3JzLZ4NqkJAWrfPWEbNcESP/FvGZY/B0R7kaDR4GqxQotxzA373?=
 =?us-ascii?Q?dT6PU8bGopkhn/heor4kiwzItpD54fg7lF8i5NOphvYTUawPQEi6Ce6ObDxK?=
 =?us-ascii?Q?0X92rU6RB5kJMUZK73ImzbnG?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a49500-f3ec-47e2-aeef-08d924d1f40f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 07:50:40.5731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QUC5dZV0jZeJvbnabNC4JrtrNF5ld8ATcbdCPI0FKQ7M+emREh1TbOXvGlmFDlTbP1YhyerUYsc1M7cQcjo/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2221
X-OriginatorOrg: intel.com
Cc: "Alex Williamson \(alex.williamson@redhat.com\)"
 <alex.williamson@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Gunthorpe <jgg@nvidia.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Saturday, May 29, 2021 12:23 AM
> >
> > IOASID nesting can be implemented in two ways: hardware nesting and
> > software nesting. With hardware support the child and parent I/O page
> > tables are walked consecutively by the IOMMU to form a nested translation.
> > When it's implemented in software, the ioasid driver is responsible for
> > merging the two-level mappings into a single-level shadow I/O page table.
> > Software nesting requires both child/parent page tables operated through
> > the dma mapping protocol, so any change in either level can be captured
> > by the kernel to update the corresponding shadow mapping.
> 
> Is there an advantage to moving software nesting into the kernel?
> We could just have the guest do its usual combined map/unmap on the child
> fd
> 

There are at least two intended usages:

1) From previous discussion looks PPC's window-based scheme can be
better supported with software nesting (a shared IOVA address space
as the parent (shared by all devices) which is nested by multiple windows
as the children (per-device);

2) Some mdev drivers (e.g. kvmgt) may want to do write-protection on 
guest data structures (base address programmed to mediated MMIO
register). The base address is IOVA while  KVM page-tracking API is 
based on GPA. nesting allows finding GPA according to IOVA.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

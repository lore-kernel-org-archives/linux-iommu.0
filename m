Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE30C433FE
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 07:14:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E896197A
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 07:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 05E896197A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7F55613B2;
	Thu, 30 Sep 2021 07:14:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vnZURYiArpYz; Thu, 30 Sep 2021 07:14:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 86F5F613AE;
	Thu, 30 Sep 2021 07:14:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06D30C0020;
	Thu, 30 Sep 2021 07:14:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F245C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 04:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F20CA6076A
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 04:57:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D5PzYaTrVt8Y for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 04:57:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13BA76075E
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 04:57:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igos/tC54CqudHvXn980kVwKbZwKq5K+RoogtG8Fxwwt7C1hqcvHDAo/aAzBdNu54XCvEMhj2ejhBtdv0INqQ4iwvDJvE9smI1LHlE5xNAK/lyV+K2uxE2dWqxX1sw+13oqy4DnUYxkNDLrVpW4IXfDMGmv5flZzqIVnZ1saVUBLbBo/+pH3HD1C9Hz40Y2gDd+LpvyCePuqt9tvLG7b18OrLp5iGPhX7XSMHrV2Xwj107k052CtAzLqEw2VmjjvoZF05fr7PGjWvm62mbICynu8ofsNWhNz2GfDz0J6Ee9hUgF32uNreSDDjGjnT0TCouIOZUpCvhfZGoLP6+pJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=O8hgmQdOWfIbikNPK4C5DdhYL5vMyjRbyGFzp0kKHdc=;
 b=iNJ8kfVn+ABC1iDOBWVHAY/l79Fw/x5Y+znaTuIrGugkF4zA8FxdMUOrHQTL8kOA+Eh/Q5iO2XMQRzLUSONSuCOCqoeyDnrOlI9pAxEVYNkdfH93HjUCz63+BMP5I4mE9byv1xWkRNpz6OsZZtOcW2yV6lJ+qM6jzwF8MmmJUvtKdn+KxP4hdWXsrYb2WCx7DQ+XGlMZytlHBWDOk257OZYfdA7mbv0DxSjjGvdiUgNmZ/TRa4ECCWCOtOMXjVQkHlRukFenwE1ky+vXg3Pe5kydg331htCrKry4wStJkxVo7R3lcVsE+Rrm1uHu30uWUZZU8nJAthByRFyz/sw5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8hgmQdOWfIbikNPK4C5DdhYL5vMyjRbyGFzp0kKHdc=;
 b=WhTq0T8VAxsqk7/tcnYd++aGaBCIQRmUAtxM8BKAjy/k6KVsE4nZd9GHB8bWCLhc6MA8BPRWmaSKDPemdC105/DpT/vL0kDkG9KXZhFw3elf+9sXwQMriYYd0xcXI2UkR3/HgvZzjRNVoPU5J66Bpc5K6eyGdJZwh+WfZ1Ez4AkSvMZmMlCKRLJFjf1ftKJWgEHhbepGS+mhWD6YDQEHAQqRpljrtzqKm1pm75UnxQBtOVBtIpvtmb2fBRf5rhgr0HlbBBiWeUDo/tCG4H+lFw4lRPU95woA2Mdg2lg5FYBpk9jy/zwdRnrKA+nlFueMfRxLpuvXMTZwDj0/rs1X6w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1469.namprd12.prod.outlook.com (2603:10b6:301:10::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Thu, 30 Sep
 2021 04:57:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4566.014; Thu, 30 Sep 2021
 04:57:40 +0000
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v3 01/20] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
Thread-Topic: [PATCH v3 01/20] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
Thread-Index: AQHXq1RaC0AUk7ABDUmYF9Nk+3cp+Ku8GLqA
Date: Thu, 30 Sep 2021 04:57:39 +0000
Message-ID: <7c168a79-67c5-15d2-e95a-97ce0d4b5e6c@nvidia.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-2-logang@deltatee.com>
In-Reply-To: <20210916234100.122368-2-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d97a4090-df2a-48a8-e9fc-08d983ced47c
x-ms-traffictypediagnostic: MWHPR12MB1469:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1469509A75EF39962A6E1DBCA3AA9@MWHPR12MB1469.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vyZLaZ5Q3GmK6HTTTu2BuLhBESHVydBWc1nqr8uvS46s/xipW7CbSzGD2sDQkSUEdxIENOOdrn5efFvO9a7ew9E+wCsK2ix4svPBHsePNmLNppK88Yzckxwzxddz1QLv4gFYCNej79OtJ/F3KCxnnhxrbPIu67Kbfw6BSTBRuQfqmR28BJVB/J9B8WA+l/T9fq4FVlJaCh36qBsTJx+V7Eb7kGlXVn8L8RrZYP768EE3qqSgtNhNWniHV7Zr0SLEane6M15J5R97zOLbWX/tebeiOcydwGLB+XaZB5QcyNDXUsh7dxb8GmJAwzV+xjUW0nCr2gIH+3LNjnxN/HuEMMdP9XyhLPDbSvyfWTDNPVbu2E4WZV4BnCDb2mByxa6dz1bf7e4vRDiTqY/CjzYQ+D4FephHjfGQKZSa6ZymyMI9UGFK5yye9CfrDmLOSLnKOq3nsdFiWnERfewfRg4ovymoR9Jbl3WdPKf1cPRXwMmE3SH8Bj0bmhPxRPfduPCsSoop2iu197Bu1maQ6OtIH7d2lhgMeCeoLwhkxNE0hqk+UijLr5EJZbesiLLzFLeobYcJXf5DC6AqpFBX7Ohg6pGqgIU5SzhdU+a/M5BWNdIqKu585BT1mOtwL1/97z1fwfzerybJZDKGMRs8xM7Zk0g4pT+hXbYq8OBqYcvSZjD0SbNudQT1SplJfx/n03CCWPLAhykXEvRzEzM5ix33IekJaXQwHW231QaxF2OwKXIiVnFTR6ysWYYJhuDRmR+mLCo2iCT57Kx12jKkQNjqOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(4326008)(38070700005)(2616005)(31686004)(4744005)(186003)(6486002)(122000001)(86362001)(36756003)(7416002)(26005)(71200400001)(38100700002)(316002)(508600001)(2906002)(8936002)(5660300002)(54906003)(110136005)(31696002)(6512007)(8676002)(66556008)(64756008)(66476007)(66946007)(76116006)(66446008)(91956017)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXlMTkhaL04ySFhpVGd4UU5nZjNveEpjMGQvVDQ5MCt1VGRUeXJkVUJpUm8r?=
 =?utf-8?B?SjlKMmZ1TmRtMDN3M3E2VU95MXFNSUNJdDZvVTJ5NmhCMTluWTljNGwxZFdx?=
 =?utf-8?B?Z3dFVlhlTE51ZjVlcFh1R0VyeE40SjhnOWF4ZFVSbzZEV1kvK0ErOXBMdXFN?=
 =?utf-8?B?N1U5bFZ0ZTA0K3ZDMmtjUkdVcXAvaHBVWmZFUG1QSzYraThtZnF6bkQyU1pt?=
 =?utf-8?B?MTBod2xSTUZ3cm0zbXp4bmd1Q2JpZDE0VGl2RENwRDV0YW5GQTZ6LzNIM1VI?=
 =?utf-8?B?S2YyczFKNUlTZHlTYVlySTE5WVJpTW1ZcHBRWlBRcmUwZ1AwSzNyQ2R2Q2h2?=
 =?utf-8?B?aTVvRk16dEs2cU55cURpYVhhMVordTViRkExVGhGNkpmWlNONG01cW5ySWFE?=
 =?utf-8?B?UXZabDhCbXE5RzRFYmpFb21XUzYrS2ZGSXBqWWFUeTF2b1U5VUZhSEk1VlNT?=
 =?utf-8?B?YzBlR2pMYlBpVGFoaVZaa0hhYzdKUlFwcVdSNktjUjBPczVvVlIzcS80Sy95?=
 =?utf-8?B?MnZmWGIyZ25nOEhsbXdVUmg4Y041enlGUEowVFhlNGVBYVFmL0ZscWUzWW9z?=
 =?utf-8?B?UjVrRG9ORk9sZFFNdVRCVDVXZEU0OWNoMzVCZzlSMWE1MmQ4enpUVEF5ZDg5?=
 =?utf-8?B?MHdLNmVRYlZGVlZJdjBBaGZKRUgzMmlTSTFOVVlGWFNxQmtOVXoxRnJvcjBN?=
 =?utf-8?B?SmowbE04ekkwZjhlWWJ2aWF6WHVTeGZndlBVVExKRW9lZlJBSmtjeXRGeCtM?=
 =?utf-8?B?bklwcW80L0xZRElpaXJBWXBjdTlkMDV4S0tLa05KT0xyTjNLeWg1V2doYjRn?=
 =?utf-8?B?VFpPVy9qTlN2SkU3SEF3MGxLcW1jdm0yc2RaYlAyZm5XR0grb0QyT1BsMXds?=
 =?utf-8?B?bElBNytCNFVVYXRtMGZZN0tVbDVFMUJIb1V4UXViaDVjZ0R0TkZwTlFqUzNP?=
 =?utf-8?B?bUM4eUZIaUs2ZUdPck9TKys0UUViTi9pSFJmMGs3S0RGZ3A1WGo2cGU3eGRD?=
 =?utf-8?B?OFk0eDNIQXkyWFI3WXh3SUNqOHN0elJqYWQyMjJiZVczUU1rTVJsekl6OHZy?=
 =?utf-8?B?ZlNpUUU3Nk5zU1lhQzY4OWl6dUhjRzUvQXVGSmF2aVU0eEtyamxNbGtydmxr?=
 =?utf-8?B?RkJOQTNPb0d6NFFONFlLWHFkekVXMDZ6VVdtVVlhTmtGSzk0VCs0RTl6a0s5?=
 =?utf-8?B?WjVGNE1tZy8wemM2WXV0QjZzbitrdG5sSkdEdzYvQnZWbEJUZ2ZzYzRJT053?=
 =?utf-8?B?UXBvajduckx2ZXJ6N0FQb1RvK2x3dWtXaTRVdm10ZFBWTDVKcUtpVXZrd1FV?=
 =?utf-8?B?aVpUaWVNQ2Uwb2VZNjVUSlpNSlZJMVBPdzBFYm1CdUpWSmNuUDI5RnU5OUZu?=
 =?utf-8?B?bmFVdmt6M091Y0taQXFQa1B2N0pWVXYwQUtCVGFjK1VhRitZYVdjOW1WdDhl?=
 =?utf-8?B?c2NEMEFMZmx5RVR4bkkvak96c01SMUFVNEtsVjBYV3VOSmp6THFEaHRQSlg0?=
 =?utf-8?B?bkVBU1NKVGxIaStvSmJsSEl0dGdFRm1LV2NvRVp6NURnMEx6RWRqQmFOMnJx?=
 =?utf-8?B?N2JxUlVQNkNXcVh4SngxTGdISk9SYlV1amt6aEdaalFPcWFjcGhMcnJmVTFT?=
 =?utf-8?B?VlJKd1AwUUxCS2VZZXpjZ0lEdE5rVVBhNDR2WWV5RVU0RnJaYlRvS2xQVE54?=
 =?utf-8?B?Z2NIMVAwK2RxVThvUXZOS05uZEhLUkcwL1JPNExJNTY5V2FqK25mRFk2Wnlj?=
 =?utf-8?Q?2LWDXlcpeX6UxkPtS0=3D?=
Content-ID: <AC2EA3CE3A26AA4490D69D7C686AD838@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97a4090-df2a-48a8-e9fc-08d983ced47c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 04:57:39.9324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXEU6uN5x9Jmx3oSrHhpDhSuJcUyqjYNckmAO3IO+jVTYXITI4Xqg8Vcn0kbPTSPX3iMrsRQAFanVHbDgfS3rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1469
X-Mailman-Approved-At: Thu, 30 Sep 2021 07:14:02 +0000
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Ira Weiny <ira.weiny@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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
From: Chaitanya Kulkarni via iommu <iommu@lists.linux-foundation.org>
Reply-To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> +/**
> + * sg_unmark_pci_p2pdma - Unmark the scatterlist entry for PCI p2pdma
> + * @sg:                 SG entryScatterlist
> + *
> + * Description:
> + *   Clears the PCI P2PDMA mark
> + **/
nit:- Probably want to add '.' above.
> +static inline void sg_dma_unmark_pci_p2pdma(struct scatterlist *sg)
> +{
> +       sg->page_link &= ~SG_DMA_PCI_P2PDMA;
> +}
> +
>   /**
>    * sg_phys - Return physical address of an sg entry
>    * @sg:             SG entry
> --
> 2.30.2
> 

either ways with or without split, looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

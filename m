Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C991C433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 07:14:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E2F61880
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 07:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1E2F61880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5E9504033B;
	Thu, 30 Sep 2021 07:14:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eF-lDANZ0Tuw; Thu, 30 Sep 2021 07:14:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E9B23400FD;
	Thu, 30 Sep 2021 07:14:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACA61C000F;
	Thu, 30 Sep 2021 07:14:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D3C2C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 04:47:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05B446073D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 04:47:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PG_t2MorvUvO for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 04:47:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A822D60736
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 04:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzxDVQCvderuY+pMqxRqmFLUPYRXBhdY/FOMUcSZ8EK/CUijQFeDi6rBvsG2VcOax9lYkWUGKWT2KoocqHp2IAWqdDLo5ogD1ghHbiitGk6qebPCgph6mtXJ0DcPrPjN5jRTZ+M3h/MshBaRRPo87mRH3XWSy5mleLnHx/VdtBbcf0YWgvszTJsv7rdTkbrw6nNz9FzaGMlYgzB/buhTWLnnlmjfhDYgGZrHGgPgr3KEIC+lcc9gHYdRV5Ntyc8XiPZvQCwFKmhZ08Z5rsCI1TNUuUaJZ5qE3gzdmKYt20yqQloZJuUgti+Q/+gmFY24N27QS8iWtSh/YDBh2Wo0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=nvJySuV2yMR+6sLk06OC4u6J3kgcQAhUEB04+A3lX4U=;
 b=muTMg/viLdP8INuzPTLVKpS2jdmRjpMEUjgQQTnzN2CNBqvCZ/B+TPgDLMxOG3WXU4xrUmSbUsAAPeDB41JopGoMLTZI9vy7Xwl+ogSZXahY/r0JtOT0+wGBLwSpIi14AeAJnWJFwAbU36FcRUDNpPhpcNxoqu7nH+1CfeX/mYihHpa/49KDAUCvuakOXX3y360MIRX++lr5ZsLF175mjwOW65ppGGfDLgpOFHwJRpRNWfQo8sMOX3dw3zbu7b6MBJsMTYSCW04r/ztqjorMMgyDb6O9RIZFZrHGfZ3MRrnrmbe/vgT04QUyFLt+E9Yh4YRdzrKu7PyNv8oqdshiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvJySuV2yMR+6sLk06OC4u6J3kgcQAhUEB04+A3lX4U=;
 b=NWJbv7Q99Eo/1wdxbdEpbj5e5pzjpG1nesUOlB6fysA/xEV3aWpEwUg9F/4M21a029RoykGlvMTk893wce5vjh3DYvHybgl2IHBafbubI3kAObfASEVnBzfeMcOMWdkUd9OWVMjNZrVkJOJIn/PiCr7jriryTE0WL6nmkiN80gXhYULjTN4yvdO+EjQPLetFeeISS/61y4b4ygwj9Wa3L5YN5fexPphb4NE2MZswr3bPGxsx7jv0nX6h6g/49EswmU7tEkwfgHVseMtBDpI1r9DDhCoSQCWuPD443a7KJku2xq8BESAHjj0A/AOyqb2FvOk5vvVFO14ioiUsJJqbtQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1389.namprd12.prod.outlook.com (2603:10b6:300:13::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.21; Thu, 30 Sep
 2021 04:47:51 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4566.014; Thu, 30 Sep 2021
 04:47:51 +0000
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
Thread-Index: AQHXq1RaC0AUk7ABDUmYF9Nk+3cp+Ku8FfsA
Date: Thu, 30 Sep 2021 04:47:50 +0000
Message-ID: <fa99b871-8753-7c3c-09f0-3fd7f610e664@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 954a709c-e90a-466d-a8ac-08d983cd756b
x-ms-traffictypediagnostic: MWHPR12MB1389:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1389D7B7588428108DBD299FA3AA9@MWHPR12MB1389.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BOQvgjzA+kOSiMOacnHDuvVljXSwiEreGGj1o/Wd/V9LDVNof3OyWHGicHhxLKtMPMWTQHlOjnk+XsT24We9maER/fe9XYM2x0v7VjQiQrvn5yeuF8tDhshqRQMEJrd36coSaKwUkmb8QInYlp3AL5ALWeOJFlNCvra913OoiQlV+siyp/A0T5ayJTNazTlWIJrW1uPX8vvq9RgYabs9LC+OLwSDH6UB+GbQOJsWGlBl9793OW+4toV0AFHbORJqV1NHWiclEC67ntoNrV+vYn6RuBjUwTqIgtGfbLohq6mBuUlJXvqan/N2fhHg2hNqe+9QmEQKuSPOfYATstc6ApcNr3FTSav8JDV6HkFzLAgTpeWi+IijH2Md9iLJRjFkpmbdVbL9z+6wA5TIO3bIdKOqOCbwwNUYwYUkaanHMmdXyHN6sAuH3TBiDB8wTRTGjLwd13QaQDQSk7+V+YHvvytpkueX/hEEUfJvmLjKcjnfbBzzKs6fFwkZselqfWZ2ESc3S6lHYpxBZYrYCx17Vk/Kx5T6Tb+vOuq7Th6N/8AZsLdDsPR0cD5WGtvOnU54uqWsrJDxXiJgx/CSU5/nOJIRwHhwUMlNho9/fyvUnqXY0S6Qo7nXIjbBeueUTKvl9/JDpzhZldDdlwKXr6s6oxV1Zumtat+byl0GdE7CJBUy6evUIuwvbVTE1C/4CC70LbaU8LEzAYeQcpbOdUq8Re5v/AcSW5ZlxNgQI928grBhI+/uNFomIBRWXUzj3/cCrE82gXRWS4vTV1ImL2CSpw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(7416002)(38100700002)(2616005)(4744005)(76116006)(91956017)(4326008)(66446008)(71200400001)(54906003)(8676002)(110136005)(64756008)(66556008)(36756003)(8936002)(66946007)(26005)(38070700005)(316002)(6512007)(6486002)(86362001)(5660300002)(508600001)(186003)(31686004)(2906002)(122000001)(6506007)(31696002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEpaSmhUV1lJT0oxL01EdG9ybE93RmcvZDJVK0xNWGpWVjc3Nk40aTNkdjNW?=
 =?utf-8?B?SUtvQzFrNDNGTjZzZGphZHBsQ2V5WHBsY1h0VytuVEwyNmJacHdnRnJXdDln?=
 =?utf-8?B?aXFEd2NJNFJPcVFxYTZZSy85RXFJOGpWZnBmVjBEd3Zid0tOdUxtZE00WmpS?=
 =?utf-8?B?ZStIQU8vRmVRdncvdStnQzFHaklaSk9hd0s1YSthMnpCRGk1ZDYxdWF3dDRN?=
 =?utf-8?B?VkdsUmp4K3h1V0FwVW4vN3NWRE1BUlZpdkZJZnlKREpVK1VqbUxEbUhkOGI3?=
 =?utf-8?B?ZTB4MThRNjA4bkZHTk9zNUZVWDMzQ3E3bTlmMFNEYktZbW42eGc4MnI2UDd4?=
 =?utf-8?B?WWg1RC92Q3MxQmdKeUl3Z05ZK1BsWXR1Znp4YVJKUTloQjFxRFBYL2VRTEMy?=
 =?utf-8?B?bnFnaUNKVEtSMnEzLzhKYmN1VGJoaXYrV1l0QkpPL0V6NHhEM3A5VWU5dkNQ?=
 =?utf-8?B?ZFlJaElHRk41MHUrQ3VpRjkyNTl2b0tjV2RtODB0dGlxdVhQYUNhRTRKTEQ5?=
 =?utf-8?B?aFhWOCs4dXdld2Q5Tm1zTzhqanBheDUxdDB0L2ZNNmtrTTllOXdranNzL255?=
 =?utf-8?B?dlBncExJYis1SFZLWWl2cGIwRDBtbFlaSUhrQ0VOZDNIS004WTN1NWY4a21C?=
 =?utf-8?B?UXpEeFVqUXZBMU5lV3RNdDdjZ09DTWtsRlVwaEtTdHhzUUxpeUJSRVZKRy93?=
 =?utf-8?B?WGV4UHBPeWUxeWtkNlJBVTArNzJoQm1Odks4dGxXMFJ5TjRBbGlYenBxWGRz?=
 =?utf-8?B?ZEF4S1R1L1FFS1FZUnhJVDljanFRb1pQd2dCb1g3VE1VMSt5RmNmT3JBRG1n?=
 =?utf-8?B?UjIvclVscHFReUZzZjdzZ3JMNGtCY1RSMEU4cTJYT3QrbjZZMjVYeGl0OXBq?=
 =?utf-8?B?dExXamo1Z2hubWUvcEpLUldPbi9CSWtmV0lRRVljVTdBYWFvdXNuK2YwQmk0?=
 =?utf-8?B?WlUya0FzMTR1cEl4c2YrdmJZc0kwYVFpSzJyU045Zmc0UkpVSC82TExSWFBa?=
 =?utf-8?B?WGVody9jMkJhSlF5MVc3RVRhTXJoMXlxRlg4Nmh2eW5hbW9PdDBlYWJNMUVi?=
 =?utf-8?B?NTBKTk5hMzR5ODhtZzh0U2RyNUtYdk51RytNRXZoQksxOFM5OHFsQUVEKy8z?=
 =?utf-8?B?QXBLeGRiSGNvaHM5SlM0UmVJRVN3Z0kwRzYwZEY4a0k5L01sL05uZ2N0bVo1?=
 =?utf-8?B?TFhBdTRnYUJkZnZUcXllS3I3ZmFiQVZiSXNOOWJBWHFzbXhsdWI1WTk3SzFU?=
 =?utf-8?B?eitOeTdYbXU1ZEo4aVFmMTl2d0hjMlNQaERvSXJ6bmcrMGJtaUFDa2Erd1E4?=
 =?utf-8?B?MjEyd2JsbkU3bDB5d2F1QU9ZZzgyUFZBREpHM0MzRTRtVnJLdUVqbEVJc3Bx?=
 =?utf-8?B?Y3dsSXNGQ1piNVlxQnFhUTZMR3hJU043MVhKdzJYd2RUNW5QQ2Y4VFkyUkFp?=
 =?utf-8?B?Y1g4S3lyaEtqc1dycW9Sb1I4TmpCSkpVZVA3MHJ1TVZRQ3dKMnErZFFKY2Ev?=
 =?utf-8?B?ZVhMM2lsWU42VUZmWVZtam1wTVZKY0FraHc1QnhIVk03UjBKckJwUWZDUXpP?=
 =?utf-8?B?dXlkVU1WcEN1c0dpWnNUUS9VL1RGODlPbEM0L3RScnY5eVBhRjk2aytHVGpk?=
 =?utf-8?B?SUtnMEQrc0FGVlZwZHRzKzd0THN3M3dlMVAwT1JBL3kzejh3Q0hpWDJ4V3J5?=
 =?utf-8?B?WGF1UzRKbHB2VVp3WVh5VHMyT3ZwZ0hsQTFmMmpTWnlXcEZhMEI0cnZ4dXBE?=
 =?utf-8?Q?HnvRdofIgYAyUb0k1A=3D?=
Content-ID: <9F877ECCA712174780F499A29B92028B@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954a709c-e90a-466d-a8ac-08d983cd756b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 04:47:50.9321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AKjejW7uEMlvUyufrutVH1+UcShjref4KkJS0/3NLPQ7BULvQIgiwWKHp6nBPsOcW/G7tcqas9XK/MmufT+3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1389
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

Logan,

> +/*
> + * bit 2 is the third free bit in the page_link on 64bit systems which
> + * is used by dma_unmap_sg() to determine if the dma_address is a PCI
> + * bus address when doing P2PDMA.
> + * Note: CONFIG_PCI_P2PDMA depends on CONFIG_64BIT because of this.
> + */
> +
> +#ifdef CONFIG_PCI_P2PDMA
> +#define SG_DMA_PCI_P2PDMA      0x04UL
> +#else
> +#define SG_DMA_PCI_P2PDMA      0x00UL
> +#endif
> +
> +#define SG_PAGE_LINK_MASK (SG_CHAIN | SG_END | SG_DMA_PCI_P2PDMA)
> +

You are doing two things in one patch :-
1. Introducing a new macro to replace the current macros.
2. Adding a new member to those macros.

shouldn't this be split into two patches where you introduce a
macro SG_PAGE_LINK_MASK (SG_CHAIN | SG_END) in prep patch and
update the SF_PAGE_LINK_MASK with SG_DMA_PCI_P2PDMA with related
code?

OR

Is there a reason why it is not split ?

-ck
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

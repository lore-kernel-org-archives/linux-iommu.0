Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EF7C433F5
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 21:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 855C4404A8;
	Mon, 13 Dec 2021 21:55:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l3V_K1GVjhD0; Mon, 13 Dec 2021 21:55:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B92240232;
	Mon, 13 Dec 2021 21:55:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 143B0C001E;
	Mon, 13 Dec 2021 21:55:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB3C7C0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 21:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B07A9402FE
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 21:55:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NfEqeW0BOmes for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 21:55:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3065402ED
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 21:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqH8JXpztHIYXeSKaFHbBDdsC/cl0u2iYCcUNiy50RzmT/GE9yo9jITxfhIHFz7t4vyC4PJOd7pMQDFPl5zJ9M4aa+/N4+Y2opr5k1us77NxCzoYBf7TR8/TwThElWwgaaqmVCVg+UNoCOQJeS+dH22MqDGtd2Y9Jat56h6+4cnJJ8NF6CEo6Fe9on/2eodVLlj8/Qe9fjlRthRDrVB49L3YIb+K/L+plGSpOW4kxqw2IucBuS7wGECy7XYzkHSgS1EQhv02fNGTvlrOGpPB0aNLD3SJNil2IEIwwC2L3iopcOs3E+LGM6Yh8wmLvr21DaJzDEGsOQDK8lhuXjBcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yODjFrmxoanzoIruGJFvCJq0S+Suec08HdaUKD+qNWA=;
 b=Gh6T0LmI1XMJCB5/0Q6miMrJH0jMrr/abR1h2FdQyTNp8dGxb2SXflaiQHrUil/Hr9ONll7wTkx5mfWPC9bObc6rcf+p8xLm5jK131cVyYM8jlIQGAdf9wu+o8ZQWhShLmAJRQIDEN6ihW9iMsclr5Q/BFt4Wu91FJa+8PGvfgraUnegPds9KK+DJ1HHn7h7+zsrqD1Bvxbkw3yQeRQ29zJfLxceI4K67+qIHnZlK8KhPri3EFycRhnuzZ1H2PSTLS2y2ja1tvaoZ0MN3fH1/qwX1yZvLhc8DVzSaY8KmpDNAN2YzW4u3I6o/LFoOG9bVLGINbBXtkqZ5cVOitNceA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yODjFrmxoanzoIruGJFvCJq0S+Suec08HdaUKD+qNWA=;
 b=HDzzyh7JOkQHhMueNLaS0fXCpfr2D0My5akkzB0bTkCqPVjuM52+Bmscb0QeaZduyhG7Y7ZT3dGLsuFLI9N+l65QLiHpF6mCV3UFpQm3rBO7nMLmm4Wa1OWlc6mkTsFQnv/G2ygr+YHBOmXC/jwXHcEIF8+iNM+c6jTW3lIDTPaWLQGbXRVGjHmEgAjjHj9xySC8TkTEb18YdPM1N36FEi0VAGJfHH8bywLV2Htt1zypW7jMEYIBsBw3B5Y6oHWFq9Un65G3+PiTUx4ust4mSUR24ETVbYIbmwPoq8Fw4SzyLyTnfx9Jr+T8EZ0mwu2PYaSurSsQ8OarWQh6EOK0TQ==
Received: from MW2PR12MB4666.namprd12.prod.outlook.com (2603:10b6:302:13::22)
 by MWHPR12MB1888.namprd12.prod.outlook.com (2603:10b6:300:112::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 21:55:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB4666.namprd12.prod.outlook.com (2603:10b6:302:13::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Mon, 13 Dec
 2021 21:55:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 21:55:04 +0000
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v4 02/23] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
Thread-Topic: [PATCH v4 02/23] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
Thread-Index: AQHX2/4HhhXnoaESEkiImBNJsNrdDqwxIC8A
Date: Mon, 13 Dec 2021 21:55:04 +0000
Message-ID: <50654705-f0df-db35-629c-60fa488e6215@nvidia.com>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-3-logang@deltatee.com>
In-Reply-To: <20211117215410.3695-3-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d73ec594-33dd-4653-2632-08d9be833874
x-ms-traffictypediagnostic: MW2PR12MB4666:EE_|MWHPR12MB1888:EE_
x-microsoft-antispam-prvs: <MW2PR12MB4666E071017F6F17FD114D1BA3749@MW2PR12MB4666.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZR0nG2To3AqK1mBoRvu0YNWsCJvetq2OMTu4JLl8xTREzU/i2zwyHPyzqCPgA3jHABwEqhI+pTrV/Ta+neV8mCELsIWmvo3brpvBQMLA8x3YSqFyIjglQCER32LzKySEvazhjaJAMQEiY2NtHe1oE3/kkXEyqRxKjbjSg481eSOl3+kPQHIpHSnOoVcitGJSVwbs7r+XNH05AYDBn/S5jrHPbTMmDAY5WwI8egzT/3qD9E7jiJ50CBouut4iO1rCioMtj1Uj3gzEawzND+S8yjFQWYZP4ZBsfAQgDqS5CxL93Vfu5w5gsgdH2GXTCH1TY8serT76KbB04/KVEaNloQurGqf5i8oXKsP1LJCM4CkreIhAznY1/zPa0lwWGA9u0EDfiInJIofFKkysODSqDAg1nx/Md2ZpDbNlpUP9MOL9ohStzYW6x/kocMnt6LEE51C5tuqEoQdpEctLs2zgKM6b7r6dpxJb7VMSLIyJjgYcIF19lZG3wKMiHDF8fCotePIPRM4bnTAVYwpEFc46uxhe3+zwrjrD+bAodlcu++D9aP+ChveRn8F7j9vD2wnhi902EEdvAeo+M+rxb2Ucj9MSZCTH/FKXolJ7Yvkd9rNmB7Y1BufO+stbN3qE8+TR3fS9eQsLC3t3HGFY55rrF3ogZko2A1IOpjos7lrQzKJzvSlfXECgdCthBXX73z5whfxkl/i5UR7LP7jkZzP4kzYE5ljJbbCwC22HTEVJhmd/gsjPu3gNiAdanOmWWhUDFIlFTxGjaBn+d4uinC+GQg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4666.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(508600001)(316002)(5660300002)(110136005)(54906003)(38070700005)(7416002)(8936002)(6486002)(64756008)(122000001)(31696002)(4326008)(38100700002)(8676002)(66476007)(71200400001)(186003)(53546011)(36756003)(31686004)(66556008)(76116006)(91956017)(6506007)(4744005)(66946007)(6512007)(66446008)(86362001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blRjWnlHNVdaRUpqamt3M1ZLaUdjaWF0ZHFOTGZ4SzhQVzVxK3J6ZjlFaTA5?=
 =?utf-8?B?UzRKejkzc1NXSkhPbUtoRlp1MWtpemhUd3pUVjZ2MFM0Tkk4c2FmZlZYcWlM?=
 =?utf-8?B?V0J2aXhwSmRHSGhDRWZRMnRHM3VEOU1EQ2w5eWpOd2poY2IvNERmQjl4SGJD?=
 =?utf-8?B?YmN5b3dDYU45YXg4akF6bUdnZDI0ZkltWk9qUHptekQ3ZFBLeXBRWlZHWjYv?=
 =?utf-8?B?TVd3eitEK0J5cXZ6WmlrbFZURkVqVjhBT09uaVVtYWhrNGRnVXhSLzFaZ1FV?=
 =?utf-8?B?SzJGZGNuV1pSRnZDNXAxVnJUK0x3bGw4VXdaa3p4aVIzbXNRdFdoTThweStm?=
 =?utf-8?B?QUhIS01XUG16QWtQT3Q1NjdLRWhqWFRpejZaelJsWFcxa0JsUStDSjFIaG93?=
 =?utf-8?B?dGFPcFV6VVpxRzhEYXlBWiswd3B3NTZoUzdEeXRjY1gybThiRCtxMzBBVC9q?=
 =?utf-8?B?cWJKUk5oenJ0SFgrWERjNEtVd005Tk9aQVRkY2JobHdTTk45ZU5Hc1Q1UEJq?=
 =?utf-8?B?bHgvTlppaVYraGk5RHVUaXZGMXh0OGdWOEx6aVdzbmUzUG92dXBQTDEwTjhm?=
 =?utf-8?B?RkhIU2grYXBZUGkzcnNSR3IvSGZOUzRXMXhuWENyZmNma01PTHZWbGIxbFZy?=
 =?utf-8?B?UjRzVjBhbkR1RjhDaFk4WDVtUEdkcm5SVjlNUnA1SDBDRjFvcXBKM3RiQ29r?=
 =?utf-8?B?SDBlbmpLNGIreEloMndxT3EyWjUyVXFxdG5QYWN5UTVFQU5UYkc1WkdjZ2FE?=
 =?utf-8?B?TjB4UXlYdnhXYlYxc0VxY2tZM296VTljbmh5dnJZUkEwcldIY21oSzRJUDAz?=
 =?utf-8?B?c2VTYzVsblo5RTJ1Qkp1enhyK3pjVlZtS25SL3dJQWFwbytZVmQwdXl5V2Rx?=
 =?utf-8?B?S0g0eGlrR1VXVlF0ZGdwd1ZxbVl6QVhDb20yTS91bkoyVHRkUmUxTmNGVmw2?=
 =?utf-8?B?N1U5Z0oreUxuU0VHM2h5cnAxbWY5UUdOTEx3RHMxOTJyaDJiaGx3S0VLWGJS?=
 =?utf-8?B?eU9kVGViZm9EdnpLTjlyY3l1MUdMalJrZTdyWURPTHVsMjVlVzNhNmhSS2dq?=
 =?utf-8?B?WFREM0pxNStUYTBjWWtqVjhva21ETnJ2WVNuS2NUTWdXSzFTNCtSRXFNSzVa?=
 =?utf-8?B?dy9rNno4N3dxZWRlQ2l3REdTRVdiY1V3OXptU0hOK0E3a0FRUGlXazdQQy9n?=
 =?utf-8?B?U3M5dk9wMmNIUFVxcjI5S0lSRHVBVUJEcjdsSmlWZFNVU05xNGVrV0Q5QXRN?=
 =?utf-8?B?L3o5UmNmazd3Q2xSNzE5bTNob0lzVHI2N2w5bURNc0hvQkpNcjBuT2daR1JF?=
 =?utf-8?B?YXFoQ0srWTBRcG0rU05ROCtIak5nczVvUlRCd2NQc0dEemFKMTljL0sweTRQ?=
 =?utf-8?B?QjkxK1o1V1V1czlYOVhUODkzdlBXTFN1Ylc2UWFMSUxydyt6dXBTNURURERy?=
 =?utf-8?B?c055a2NKQUNPbGhpNUhTSVlZOFpUSFRMUzg0VFY3TVc0ZUYyckptZmsvcTNZ?=
 =?utf-8?B?OUh0ZXNQTFpEZytEaW8rWjNpdDZOL3JnRjFOY2xsRkhqdnkyZ3BvMGFHdGg0?=
 =?utf-8?B?YmtyQklGNG9IWjVRZTJmV2VEd2xsa2dITGNteEcyRmQyaDFIekMvRExEaWV5?=
 =?utf-8?B?cnEwSWhpV09wSGluYWMxUGtxVzR3Ylg1a2cxT1NmV1JxVm5SYTBZMmpJcGxl?=
 =?utf-8?B?Qytyb3FHUkw2dGpKQ05qQk9zcVNMWHRVdXJiRnBsNDIxVlZGd3JLQU51b1ZM?=
 =?utf-8?B?SnhTM1lFMVVaMjJMczZuNkQvcm1mRk1BNjVnZVYzVElRT1NuVk1BekplcXVJ?=
 =?utf-8?B?WHR1OTd0K0JvbW4yOG1YdkxJOXAwZStleG9ZaXBzeEZ6ckY1Wld5WHZuV05R?=
 =?utf-8?B?aWlwQkdjRkF4a3Q0N3l6SXdsUmhaUEN6emk5ZC8wSVRHVGlBRmkzTG9TTVpT?=
 =?utf-8?B?d21qZm9HWk9jdDE2aG4vM2ZaYkxlVjZHNitURTJsZ01lbmtxMG01SUc3WEto?=
 =?utf-8?B?S2NtTlE0VlZGSWNrQTZ4ZXJKN1hmd1BCbFZOZTB0OHRUU1N6V0xRMnpXZkEz?=
 =?utf-8?B?QkZES09GekpWNTAwck9hcFd2dmh4Vzl0RU5aa2xjMjJ0N2FWSE5uSTczZkIw?=
 =?utf-8?B?eEtNNFdDTFZSSDNNUWNvSUh3VlRVQ2s0ZGdVaDZaVElqOXVLSWlZbUh6dE13?=
 =?utf-8?Q?7FHT+FHH/94Zf1zqkGPX4495P3E6omNwgoRZ61ALlJp3?=
Content-ID: <02CDCA82C500FC47AEBE9199F465CCD6@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73ec594-33dd-4653-2632-08d9be833874
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 21:55:04.4516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNK/x03CWX7nGurTnZ8MR+ZbH+D/E2crA08JWR0V6eLNYWLLLVhxFi/sfcoIKc8NIOAY7dfBQVEGCFMZQcfHOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1888
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

On 11/17/21 1:53 PM, Logan Gunthorpe wrote:
> Make use of the third free LSB in scatterlist's page_link on 64bit systems.
> 
> The extra bit will be used by dma_[un]map_sg_p2pdma() to determine when a
> given SGL segments dma_address points to a PCI bus address.
> dma_unmap_sg_p2pdma() will need to perform different cleanup when a
> segment is marked as a bus address.
> 
> Create a CONFIG_NEED_SG_DMA_BUS_ADDR_FLAG bool which depends on
> CONFIG_64BIT (so there is space in the page link for the new flag).
> CONFIG_PCI_P2PDMA will then depend on this so this means PCI P2PDMA will
> require CONFIG_64BIT. This should be acceptable as the majority of P2PDMA
> use cases are restricted to newer root complexes and roughly require the
> extra address space for memory BARs used in the transactions.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

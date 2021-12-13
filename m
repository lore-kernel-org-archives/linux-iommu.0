Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749AEC43217
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 22:00:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16F46402FE;
	Mon, 13 Dec 2021 22:00:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VoZadCw95g4S; Mon, 13 Dec 2021 22:00:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EE4CC402ED;
	Mon, 13 Dec 2021 22:00:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D07C0C001E;
	Mon, 13 Dec 2021 22:00:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87F16C0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 22:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7AE2560B49
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 22:00:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5ZQys8bRbuXb for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 22:00:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BFC7F60B30
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 22:00:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+epXGhl6VEZrGUT1+92iRUL1/H0yDUAsk9o8gjmQueBhC/A+y6GGT+o5rm82rlj6tCYLRf6aD7u7fT01lZ6gIvctrwf/BG7apbXcD9k3wRsCYXsI7FE6pKOIDBmcWqtkDDmOx4UPgVE9bw1uLuQrFO+xUP4rKej4T5QaGORjLMrEdnbbHoYcDESgX+2OKdcG6LgKChAubG5nsAw6AOYr/dyqUYlx6LXjcpirEcZwv9tOimcPu12LPm9dAlCsPpDwOy0nEjoBUwigha4TS2dYEV7pVwGNfpsoLVbR9ILsITPubmnIt71zCqSBd7D47ITg2AA+j9CTEdv+S3cIapeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcQ24mTImXA0x3TYhCaAlrVAA9ie4cD2E+7PXPMehW8=;
 b=cO9hgM4BP0QNHFLLDyvp67MlQTYsMQuxc4Cg/6xmef4SwYK56Q2y5tYcVL9K5GJOGYkAJjNRc7nCBFCIE/RvvZoO/GiiM+Tmtodr+Zo4W8q8sFhg11Ha63E8IEfUVnB7tWz1xF4OYuakVDU3lYbDpzanzl/5lIwG6kkLMgr8qNFXN9w9yqa68Ly9D/JraMqnSqrTl+cxownZLoZmbXOsWXXp/ux/9GZDS5JNMmKWngC6uknOmQz4e7GYU2USplxnfeyfpiE8wotqktbWZhy0ezmQy0IYL6YUkqDgpfMu+3AunewbxEn52pVUcDrnugusWJbEUXLobS3vRJQOBRcVdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcQ24mTImXA0x3TYhCaAlrVAA9ie4cD2E+7PXPMehW8=;
 b=kima35WoJgJFV56xtBTIkqbJsMsK3nzY7wiBe3h5Hk7b7zS99GTaaSL7qQXGPCqCm6v256rCd26rEPjshQk+Tyf5jEno9Dr6GinXTu+gGeq648PpXX4MfSxaYCiF5a4wTVNGw23KULPvM6HUBNrPxH0Ual8Vrqhh2lahuCnfzPYtD/FDa3LOGdtj1hXcKWXR0A8Goiq8TKXXQi0Edo2e2z6cCeY7zz+UqUAK398YV8vSERJM86fma7sAFXFgvA6AlZKk2vq4Q7zUEvPzKZOTbis1EvqdCY8487GjXPgXc/LZ+g037d1LWk/9aXWTMXKf42V9RRRZraiwj6bu48NaMQ==
Received: from MWHPR12MB1726.namprd12.prod.outlook.com (2603:10b6:300:110::16)
 by MWHPR1201MB2558.namprd12.prod.outlook.com (2603:10b6:300:e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 22:00:29 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1726.namprd12.prod.outlook.com (2603:10b6:300:110::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Mon, 13 Dec
 2021 22:00:28 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:00:28 +0000
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v4 03/23] PCI/P2PDMA: Attempt to set map_type if it has
 not been set
Thread-Topic: [PATCH v4 03/23] PCI/P2PDMA: Attempt to set map_type if it has
 not been set
Thread-Index: AQHX3AdpaBbhnfL/1kKrOJvpVJUMZ6wxIZ2A
Date: Mon, 13 Dec 2021 22:00:27 +0000
Message-ID: <8665d69d-7cf3-2c6f-1899-7f436954e55b@nvidia.com>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-4-logang@deltatee.com>
In-Reply-To: <20211117215410.3695-4-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93f8a0c3-f7c0-43b5-eaf9-08d9be83f92f
x-ms-traffictypediagnostic: MWHPR12MB1726:EE_|MWHPR1201MB2558:EE_
x-microsoft-antispam-prvs: <MWHPR12MB172629FE92339EFF3B06DFCBA3749@MWHPR12MB1726.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: evzYVwPA9YsljV6Rm/uT2OoKhlwEkc0UrOlJ/WyWOqEj4E/Zh+Pvcwu4LQS7ZmbNHJqia6j+ZEFRTgKC7VQYdjvVu1xzqGbeBegHPNCDw1Mhm5gSufXeeU1XZX1E5+maQSqB/Y/kCPLrShlWfVzaKLAx+OXRwkfGsmNppSlnhONd8CBA2cOtRbKqufHYjWcm9BjgzB1sL7G3kctiCuOn61pTj9CLEJLsf6aArhyz4TsAu47qszLE5H1yW5rXr6Nnu95MSdOG+C+dC8yWsHEXHv1b+qpEp7WoUItCm3PpgFEdDj/tEEGFv3KSA2tSv81pLdrXHgaGW1G4EpTOsGcO4rG/yArSJiofRM0o2J6eUjT6+gmhAxlkjsXhHTcOHokyQt7tZXDFLO8FflJC1slKmXGG6UUuOPixkp83hUNXri5w1HzPMMaQFtfgvvLUFLMOdQeyIr8pQjCgQIF5SyU1o7vW4id2RajjL52pBPcOr8JFqFsicIGYdN5t2UCndjX7hoIxykmk4w3BqkKNMi3U6c/xvD2IY6MosjIKa1OiMlTxRf7Q5OyWgwYirQAp9d/5eYQOIvb2BrD6FvQkVU1aba/Lyx3xLnmEvms0lnt3XJlEinbnhQgtzy5QQbMXBWkF754v1RXodxSXsTnw9s5o2Y6wTa7ThN/KZ1sM4uiBK6Q6g9qBXmGLXtHE3Aqdl3ZHiQwH1ewyJTehQNa4149+eBozXuBbQCxBUnJrTxVVhgwcMA2B1+JR20g9zS9E4KrRIlaCPYObDchcDKaMQTgnqg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(71200400001)(64756008)(66446008)(91956017)(53546011)(66946007)(86362001)(6506007)(66476007)(4326008)(76116006)(36756003)(38070700005)(7416002)(508600001)(186003)(2616005)(316002)(110136005)(54906003)(38100700002)(31696002)(6486002)(31686004)(2906002)(83380400001)(122000001)(5660300002)(8936002)(8676002)(6512007)(4744005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm5maEJtTzRTMUYwOHE5VVFCdW85Um5PQTA4Uk1ManpNZk16TXp6N2VGd1pF?=
 =?utf-8?B?OCtvUWp1MWRLci93Sm1xbEdMMUtEV3VKcENUcW0rdytrS3Y4WE15TWwrTWFY?=
 =?utf-8?B?ZWczZjROSnNLTE5nSkRPMTB0U0VYNzNna2J6amxHRlB2UVRYaWRNZTlJdE5p?=
 =?utf-8?B?NEZ6cGwxS0t5eGxQQlNVV0EvcFZDZ2NiTHMxZUYya3JvSWcrTExsK1d3SnJn?=
 =?utf-8?B?RlBkaWxDb1RMdGdJbC95SE1LY0o4ZHhSZHhmc1I0c3RzcnRWQWdrUW5MOXUw?=
 =?utf-8?B?Ykh3RDdiUmkzRGNobGw2Y1JxclFhL0R3VHAwTTJUZ1RrMWpJZWVRY1hndkd0?=
 =?utf-8?B?bkFsOHZOVjROMnI4YU4yeHpORlRqek1JcU5aMjlOVUZkZkp2M2dJVDBGS3Y3?=
 =?utf-8?B?Tk13OHNXcjVTVEhWVllVUHZiMW1YdFlDRk9VWEtMd0IxOFdxVGFIdktBQjJw?=
 =?utf-8?B?a2hveVNQZWF5ZHdGUkNHVWM2cjdTVXMwd2ZRaFFDNmpJVlY0NGx1VGxibjlk?=
 =?utf-8?B?R2VBamV2cFAzVGZHOUlubjJnNTFZbDFqR0ptYkVCQ3VrLzB3eFAxT0NZUFli?=
 =?utf-8?B?SWc3QjIvdExCdEtTYmR2KzNhejg5ODhwVGE0N3ZGamZQSm5GMVQ0d1FyRjMz?=
 =?utf-8?B?M2FzUDFjbFpPa2pDZVVwN1N4cnREbWVUaFYyU04wUzVrcmZmVmRHcWVZS1Ja?=
 =?utf-8?B?WitoODh2ODB0aTN1d2prNkE2cXdmUlZ3V3ZFS2lXZlhZK1BEeHFtR3NkV1R2?=
 =?utf-8?B?RThicEU0YXIwMWVhdUVUMGU1a1FZa0dON1NhTy9iSW1lMlhTRHUyYWRzanUr?=
 =?utf-8?B?MVZNUGgrZGd6SWc5cmNxYUVhVSs4ck5rMk14Qlg3R3ZNRjB4YnF5TWFMS0xW?=
 =?utf-8?B?NEJNc0V3cWpObnFoU2pSajJMQkRQa25CTFdydHdPRkNPU2tad1R0RHBJb2Uv?=
 =?utf-8?B?U25OdkRaK0d4TUQ2ejJjaVNlb09tWklDdUhHYWprdU0rcW00RWJrcGpEd3Iz?=
 =?utf-8?B?U3g5NlhTNVhCM20zVWFFWTVYTjdJR3hJNDlBRXJzR2NnMkFScHlNRVFjdGY0?=
 =?utf-8?B?RWJta1E5dE00d2hGeE41U3BPc0FVUTlDRUNVRlIvWEx0WkFuWGxXWUExRlRa?=
 =?utf-8?B?cWtqdTIrcnVzUldWd2tvVmMvcmZOVi84MjJSMmRjbmNmNFltT25OSmp4R3pF?=
 =?utf-8?B?OEFOZlN2UDB0eERUc2k0Q2pDQSsvdnFiQW9pbHhtdGdkV2pLOHJPVE9rQlJB?=
 =?utf-8?B?QXhrVHNQblU0aEx6K1hRb0grRmVSSkNJYzduaHFhZnYraUJ4NlhxSkdETDZ1?=
 =?utf-8?B?VUJlZU1PZUlnUFlNcjNqNG5pRGJVQTloaC8ySHRGeXRPcDFRdDdpZ0t2MXRp?=
 =?utf-8?B?KzB4WVNYZXJLckdpUHdwZzhDMTlFVzlnU2E2TFQyMmt2b0d3aWNaM1NIdGJa?=
 =?utf-8?B?TGo5TGY5VEJscjZaVFBodmc1L3Z1d2pOSlp0Mm54QmkzelIyaUZrM01aeG9R?=
 =?utf-8?B?RTRHcGNzM29UTEVkY3hxWk1ndVhzRndGVGtyTU03THFMWTFQS0FXTWFyQVFU?=
 =?utf-8?B?RVB2RTlLL2pBZmROTFU4L0poc1hTZTlIeWtJdHhva1dnbnB2V0JMcGw0MnpD?=
 =?utf-8?B?UkdLeGVQajZ2RDE1ZWttb1RWcXVtM2VNQjBYeHp2ZWtTM0RKU1N0ZEV2ajRT?=
 =?utf-8?B?anZlSmtnN3AwblhFRmIwV0RHb3ZZOW1EZ3VsT0NsMEd3OGNyb2pTM3FoZGVz?=
 =?utf-8?B?YWFWRXRRMFY2aWhoZ25OM05xVC9WTmJtTldKUUMrV3VhR0tIWW05YjFqbWVJ?=
 =?utf-8?B?dkhRcHQxMVhVTUdHK1dtUWExdzY3ekpNSVB0eTlJRTZvTGNDWlJ4QTFTVWVJ?=
 =?utf-8?B?a2tEeHdEd3liOERQVzhobzQvQ3FneStZcHk4YW5ZYXAxZGhuRnFob2hpUnJr?=
 =?utf-8?B?aEEyMlhpQlMzWkd2R3NpaGs4ODN3ejl5NWw4NEFLTDZTQ25wN2VUcDN4RXI0?=
 =?utf-8?B?T0ZWcVVDWGliRklsR2drWEthSG95dnVGOHo5Yzh0TytvcVJxb0pQUU5EOU1R?=
 =?utf-8?B?dnZjM1RFNTVVR01QT2gveWFFWVF6bE53NW54Q0ZYaVA2MnFqM2Q2bURiZlBJ?=
 =?utf-8?B?YWNCdWRjNXZPKzh0ZitGdHNQc21FV2NzSHV1em8wVUkySTNoT2dUeG1EQ0wr?=
 =?utf-8?Q?KK8PGI6MgQ9TuVNefkvq0h57YKzjm4HTQL/asYNrPGSL?=
Content-ID: <443FF690B8AAC7449B892A6AA021BEF2@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f8a0c3-f7c0-43b5-eaf9-08d9be83f92f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 22:00:27.7957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ozLz52JoSyQgD6gNAP9UHhjnxYT0VODw4vjhPbNCDZvniTJtxtoK4Y40Et4oubs6ywhjcYszu20nmMOwrTltA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2558
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Ira Weiny <ira.weiny@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
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
> Attempt to find the mapping type for P2PDMA pages on the first
> DMA map attempt if it has not been done ahead of time.
> 
> Previously, the mapping type was expected to be calculated ahead of
> time, but if pages are to come from userspace then there's no
> way to ensure the path was checked ahead of time.
> 
> This change will calculate the mapping type if it hasn't pre-calculated
> so it is no longer invalid to call pci_p2pdma_map_sg() before the mapping
> type is calculated, so drop the WARN_ON when that is he case.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Perhaps a comment would be nice in the default case in
pci_p2pdma_map_sg_attrs() where you have removed the WARN_ON_ONCE().

Either way, looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

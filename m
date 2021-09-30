Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AF2C433F5
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 17:19:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A6E617E5
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 17:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89A6E617E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5839A61428;
	Thu, 30 Sep 2021 17:19:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vcoy4Dk2TFsi; Thu, 30 Sep 2021 17:19:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 401856140E;
	Thu, 30 Sep 2021 17:19:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16A63C0011;
	Thu, 30 Sep 2021 17:19:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61414C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 17:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4ACAB407B6
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 17:19:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id miNWSU-QKzTT for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 17:19:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDF72401D4
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 17:19:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGZHpxJlldhPnlQC4mxGV7ED2NkMJDvsc4TFTaX6PFLsGKk4Imu8u3DNr88cHNgPglfkBsIhIydqnQOF2/4XAw4oxqawpg82vMXdyzqgMjyNmc6vrQm78zc3t6bxaRbgDslMtM5e96JVFb5uiJpuugkqo71VCavimSfeDBHo+UdZp+jLK8rn4usQhskxrNjEgI5YnmjZbGnSqDRUJaYyBu5Y44MqjzHbk4SLtxNDDWOgejlhreqTIgScCfvg4rTSkPcsqB2jOLCRwlFfISsgnIS56d2Wjf1Dt7T2OBI4wQETq+okLR30sRJlS9nunMQzthSEfgryaOMQTVaI6tE8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=2fELnHVMyTpNhwVbgHmVfPi5zThL1xvtdOS3eTwdpBM=;
 b=ao1w4wrabJyfLb8fdJFSed5AMJofDORT+c40AqpOF49Fu06ryEMfa3C6KSH29iETSG125E7VQEzhIhS6ImbHt2FJkQ/C3gdXLi2oYH9l0PyjDo+WZduJvZ+I4mTmEMIHnle9C1p40TqmoEjexwooAm1/SyuYriepxRNYIVKAdKuo6X8E7ghRqViS4CwemlXU9ZS1jTVlNr7cO9GoIr0rADkcteSDvJT5tly9Qbzyhp6QMOjLCtd8zux0FvrExNikE2sv0pwBuigOqoureafdr+Ubuzse/40v1HlwCDqXXkrstpbUvSTdmyozH2aWp1V8/JXuF4Gf3cRc3iwIkqkhQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fELnHVMyTpNhwVbgHmVfPi5zThL1xvtdOS3eTwdpBM=;
 b=fL+e9g6tleIclm2ViKN5Sq0QjqvmzB+R6PjOu8wcjIhxZfyLKXBCUxVQSr4KXSAAeAHCJd9JPcaOW/ep2rfG3CunBgreAm+9myFQLs8Sy4LVqn9+ZQShEsKxRk8b6IhvmPt1uATd7e42J6isE60/McA5lPU6bi+UffeXRUSjgSdvMihRj0KHwMc9MlEF1qakf4nZSElKxMfTfVWdXfzUZ2oKrmvyQ4QhW1anZjGpmma3rrMyagLx69wb8J3r5iJAVTiOp55AcMRp5wiQBubCQon65lvVlWZ3U319ei8K2kRfxI665AV9km1jRUI0PtrLe3G5Z6Ivn4Gh3Xq+WDUHqg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4539.namprd12.prod.outlook.com (2603:10b6:303:59::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 17:19:16 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4566.014; Thu, 30 Sep 2021
 17:19:16 +0000
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v3 09/20] nvme-pci: check DMA ops when indicating support
 for PCI P2PDMA
Thread-Topic: [PATCH v3 09/20] nvme-pci: check DMA ops when indicating support
 for PCI P2PDMA
Thread-Index: AQHXq1RfNFWZGZ0XhUyLU5ISdBtHSKu8GxKAgADFEACAAAfMAA==
Date: Thu, 30 Sep 2021 17:19:15 +0000
Message-ID: <59b52f30-00b3-f466-2601-592fa09d5614@nvidia.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-10-logang@deltatee.com>
 <c04215bd-442a-6520-4fc7-5035c1310662@nvidia.com>
 <acaa91df-f932-7449-3623-4209c41634d9@deltatee.com>
In-Reply-To: <acaa91df-f932-7449-3623-4209c41634d9@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14e9e6fa-f4f6-4379-36f5-08d984366e20
x-ms-traffictypediagnostic: MW3PR12MB4539:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB4539B997822854BA5E8DAD5CA3AA9@MW3PR12MB4539.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v9e2ozBZnKVNBIIjEqNDx8j3oa2o0bYdeB9GNUdsvBe17xqyYYRgjs7zzFjotjGHTFy6zNfSNk1xfs6uMZLA7IpiIfmM/GAsa+t/+iFNu39R5R477o7TjRoy0bxK38EylbKvxpNUulIblijM8022nHCIg2DgAH8k6agFLHdVW8rPsmiyIcgc39lCG3FcM3l30W9cX7eNI1RerZuuQBNtBhu/MEg1oDOt8cW2hUnkwIW7rVZ/QV5U+RZlr4s7dDpQ1X43WZ9FQsTFvB31r+CI36y50LYvy5VuycZIkSMHb3fq17n3UW59yd2Ym77z2Fopy3lxGD52JIuYFLCPE6fV4o3D3kXz/yR9CzuvtSPJ8q6XdMbI68BtqZkFkdxvPWNAQpfKRnbmHy/7fZw3uuVX1nlj/W3F4R0ljITAXYrzQXiLRKdiOVCOUPY5nl6UX4MdbvGJ5J4t3i+sLdJzzK6/98SIvr3BCdfeoEFBegA0SbUhhRZ7Syk/zlBj2SC5W30/Lpi6HC2JybEAhmUmwEXJtEvZMDrlfKx2jSM/5syJZkHSbPlk4iGm8xd7nc/RbxhPD6XhXGNnI48Sx8k5bxi3Xs/GVYwn7XegLJSA81xaJuWCeygUyYpBRu8TQJjHlMvH1OUcrTW3sWEI2AFFyBWtlVvCSgIJ/oBCrrpWk4BciU/GWfeZQlQjKvxZBMu7NjAirJXlyPEa0iEPlR8z/Se0rsa2EBxm5mk7EabVgqwCmZ5WeeqTZFUvBG8ZtSDHG+Ar40JaBm07C47NssrxY3F/Ww==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6512007)(91956017)(5660300002)(122000001)(36756003)(54906003)(2906002)(38100700002)(83380400001)(31696002)(8676002)(186003)(86362001)(508600001)(66556008)(66946007)(66476007)(64756008)(66446008)(6506007)(6486002)(2616005)(8936002)(76116006)(316002)(4744005)(71200400001)(31686004)(7416002)(38070700005)(4326008)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlFwUmtaa3hVWU0rRThKT3p6OXlnUUI2ZTV1ZTR1M0dxR2NZOHJRQXI1NlA3?=
 =?utf-8?B?Vko0Y3hMeHROUTBaUW84Z2owa2VhbG5LTUMwYkJUSkVtb21HT0tVeTFrYWZx?=
 =?utf-8?B?ZEFCN2dscm9ZczhlOHBxdGF6OHJNOFl6NkZUUzNreEpLTUVRMDR4aWVlZHh6?=
 =?utf-8?B?WS92ZndqL3J6Y3dMRXBabE8wWXpZRkJ2dHVENnh0RllyK2VWWDRjc2hxNEtk?=
 =?utf-8?B?KzdIL0p3dTA3U05CMWwyTC9pY2lpclJTMnBzWGExU1BncXlPU2pXdjlXSmZP?=
 =?utf-8?B?T1l2aW9ETjJPSm9rbFNPcnYyRVltcld5SkFUY1M0MnRaVnhDdmpBS3JZbCts?=
 =?utf-8?B?djdJRFBhNW80dVMzdlFsek45VDkxcFNPcHNmZVU2b09lUFBkVHFRYWxHcEZ2?=
 =?utf-8?B?Wm1UVjE1NFozK2JkS0ozQXVaV2MzZDdQaHRDbUxheEI4czhnQ0VrSUlXc3Jy?=
 =?utf-8?B?alJ0c0FyZlk0OTY2MFRZN2dTaHA4R0NsblA2LzZTLzRKUnhpdVI1NE1lTVVm?=
 =?utf-8?B?MUliV3AxdFJETHNYeEdQVWVKWTBnNE9WYjNLendEd0tHZXVQdzNDZUJ0Sm5r?=
 =?utf-8?B?SU5Ec3BsU2wvODFGTTd2ZnVVclY3UHU1cjJ0eGx0cGhHOFJDTFkxenJJNzhx?=
 =?utf-8?B?N2FWd1pJQWFnMkZRRW5IWVBFTC9zZDAxVWliUW1qaUJLTnFqbXlZRXMxV21Z?=
 =?utf-8?B?SjJKOTkzOHFacm1wNVA4cjJTR3lRZDROdW54eExNbWlQUURpTURhb1UxYVF4?=
 =?utf-8?B?cTJCLzNrdEY1NXdvSFdNV2R0Y0FyYXZxRVV1NWJFTWVRS04vTkd1N0xGblZT?=
 =?utf-8?B?b3BXSWJ1SUh2dTB0WS85UElHVjhEd2p2T0Zsd1IyTlZsUVZZWTM0YktuN3Uw?=
 =?utf-8?B?S3lBOGlKWmIxck1LL0NwSVErZ2Y2eGRPSXNqSGQvZmJGV3NzcEQwRHVHdHBK?=
 =?utf-8?B?WEQreTF1M0pObjZyemV6enJRdUMrNUNabk1mQ0IxSWd0cUtSUzI0YnZ6MHNr?=
 =?utf-8?B?dEtvZStYZ3c1YXBaemJ6R2FsekVWT2ZrVS9FTmw5NUkyYzJwSDZjaFJUMG5n?=
 =?utf-8?B?MHRxL0lVNUtEKzFGNEV6RnJnaTI5TGFXc3JJSzI4Z2g1ZWJqMFlzTTI4NW9X?=
 =?utf-8?B?SERJcWk1TTdUMmd0UXd2VjdHWWU5MDJzUlI3NERIZGZwUW9ncUFFTVJJblhG?=
 =?utf-8?B?OVk2aU5GVGdLeElpdGY5cG5kR0xZSnZWSlA5OWRVTWNoS2hKY21HQ2JvOGxV?=
 =?utf-8?B?TldGK25pMzhkS2xPSFhkRU5ZWjRVSUFxZWgxMU10VDl5Z2luYUgxbThSZE9E?=
 =?utf-8?B?YnA3MmIwN2FnMjlOQXZaanI5TEJLS0ducVVpOUVGQW9RS1N0Tm9BNVVLRFhP?=
 =?utf-8?B?TmYvNnEvTXVtaG1uQUVTaFRiOHhwNS9VNUF0MGRzaWdWVktvUFN2K3ZEZUF2?=
 =?utf-8?B?czJ5clJBclpqQ3BxUHFEMmc1TVg2TVErcEhUZzZzWFpNbWRNUlN2UVV6akt6?=
 =?utf-8?B?Q01ydldDcWZQd1d1NWxzVld5ZEFMNXFxSWNaSkVDbmM5Z1crdlZPa1crTHEy?=
 =?utf-8?B?MFV2T29iUFpKb1h6T21DR2U1Z2cxc2F0QkFwZzdNNnpPSkJEWkl6REdJZXov?=
 =?utf-8?B?S1Rtd1l6em5YOW5SUGNrN2h3dk1NNHB6WHhQbkZUdFpGa0EyRFNRK0VVMWJ3?=
 =?utf-8?B?TW9RdmpjV0xYL1ZUdGkxTUpYT0JEcCtic21MNThHVCtZQVR1R1NrYWNZcGYv?=
 =?utf-8?B?UExBTXVsdEl1eGw4RERua21MblJrVkdBeE9EakQ5T1RRWmxvVVovMW1UWUN5?=
 =?utf-8?B?cWxLaXpIMC9HdUhrWHNxR3lod2V1anRDWmhuTUlCSTBFSHZrYkQ2RmdqZG9x?=
 =?utf-8?Q?QVwiXeCEdyue6?=
Content-ID: <7D4C7F51CCBC234A83967E26F99FA261@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e9e6fa-f4f6-4379-36f5-08d984366e20
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 17:19:15.8682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnTI8GZmYta7DriyIkvSTHA9XYg9HpX3uvwXv9VthqHZdhf9hchOMEkSZGdXUG1wDn1n8ylBmFQ1+wJ/NxebMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4539
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


>>
>> Is this new ops only needed for the PCIe transport ? or do you have
>> following patches to use this op for the other transports ?
> 
> No, I don't think this will make sense for transports that are not based
> on PCI devices.
> 
>> If it is only needed for the PCIe then we need to find a way to
>> not add this somehow...
> 
> I don't see how we can do that. The core code needs to know whether the
> transport supports this and must have an operation to query it.
> 

Okay.

> Logan
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

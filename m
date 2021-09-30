Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A21C4332F
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 07:14:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12CF6197A
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 07:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A12CF6197A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 661E54251D;
	Thu, 30 Sep 2021 07:14:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UstO5PdQE7A7; Thu, 30 Sep 2021 07:14:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2FBD2414C9;
	Thu, 30 Sep 2021 07:14:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F6A3C0027;
	Thu, 30 Sep 2021 07:14:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B5FDC000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 05:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44699402AC
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 05:06:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XsW4G5ZW4dsw for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 05:06:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A9E140215
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 05:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jq2NR55RtAcAZ9nD8fYXv8wWYQWhcDN/SJXpp3QMqsXieKLoPYMcGUbxR4aU/5s21VBYyzHa6Wq0JACIvYkPhu0B0msnZqDRl2suiD2zrPuJmhegxq+MHkl2fKUKczIYwthmECOgLbQVMrfxZY2yviYtuf9a4k/HbggOHkCPV6IWt4RlRU4Y7kRMZumrfaB1B279kMogKVJ7VGwB22+gaIstEPQ/DMLW6wTu8xEYHKRcyog58tHsQUwaE0cIS2jOWPidRJNkq4rQf44hA4JsONARW6aaEUggNIl/rVLC9XMTDpSdToQr5Q8QB2tcqdC7gM55TqJnVrcESgriYbIXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=n4apOFsF6g5BVOtw89xtPAjefBg3Zju1qz1MqxDBEXc=;
 b=OW8Pra4iA7uXUA0jSrw7GRVw4de0VyQInaaXW/8n78vNM1KgfcpLM3hTbwQjYRiapc6g6I9bCw35Js7DXlw6ODJHyC0RByfBy5EJCWL8h8AUiaAxBAIolnXBGOPdROUHNBKUVB91ZRQmD4wwjNJOzpo2mzNTeiHMQ7TF+8htw65FKm2x8HUlUz1ukgtGEBeK1ePOZFo+n+H28XUSULA7PLCNVYfH0K7KEJZ4LNB6yYzYQH3sQJJKffKogARnjkjOwDz/6QxzSlMJdlr7zzDObTokXAstTIfSiHZx1ExjHOAFA5jF3e+ILAM2LMiFaLgQ/mtdefQ3+JFM0aggee3Ztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4apOFsF6g5BVOtw89xtPAjefBg3Zju1qz1MqxDBEXc=;
 b=l9Px9BdZ0EH0PuGsTcwRRWavVViKqAalEQIM0VBwEXsBmYKwwDeAKAAFnzr4ybxy2r0rGR7wANkcUSLTGWyeC0Xam+W4edMDijpoNqgMnZ3mLi8lfUc1qQHV2ql3ps1mZr9PxzIK+1np7p7PR6HlTEQV0Wl3ILRep06bvtFS9KYQ/M77jgcIQ4WT9uN4TpzwqQT8tOafYCE/ToGfgvjK7uHHBFntr2RkXanM/1x5+bX5c2y/4F0VnFi+fY4ugPIetWXeTCrgJfQ4OvfCmzsUUuBe/jVUtE8cLvcfXrSm2q3FVKbCyqlQ5qqFu95idLZGzDO1HqwzcU/Sga07cHGEMA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1199.namprd12.prod.outlook.com (2603:10b6:300:10::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 05:06:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4566.014; Thu, 30 Sep 2021
 05:06:04 +0000
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
Thread-Index: AQHXq1RfNFWZGZ0XhUyLU5ISdBtHSKu8GxKA
Date: Thu, 30 Sep 2021 05:06:03 +0000
Message-ID: <c04215bd-442a-6520-4fc7-5035c1310662@nvidia.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-10-logang@deltatee.com>
In-Reply-To: <20210916234100.122368-10-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 777e5a4f-a1f2-4c79-5cf4-08d983d000ee
x-ms-traffictypediagnostic: MWHPR12MB1199:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB119923677811C4266C81079EA3AA9@MWHPR12MB1199.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tjgYc7HlMPZV+h+4lXXyq0FpimubPsv/g7EwewUvRE5Mkb8DJTGb2B00RZKY31GvPGuz1jTM837woGlfOlcNq6PT59eYCNTBkJ6uElLl3uGcUfsOj1QCqRlvipEBdhE3HVKTAgomQAvsk1+I/GhNzVEjz9Hfbba+per6PP+GpHoSrsd3GTFpN1kS67VSRlZ6wj50vPf5+3eIKk70llYZoWpWR7MbiJ5I7N9f9w1ud/TztEnd+ddTR54b9ARaCWYeWIj24EvUbaTWNfijNHMUh/kfvLCf7cSEfqruZ/978RG3EgoywJlqAjVyWCyEVBIlsgVD5SgsxEj3eYI/V3AbW7C7t4jGcYqhgR6kDQBmXVr9KliFcVDCvr23P2DrdXtxQLRvrwPaOqUV0w7NpGj4GT4VU18mrhyhSaC5duC2Sc6kxr5Ga0eaV8R8z3ZSyYJyzcgMeEm0yhQbSgW2NUYIS45tP+t4ucHJ0z/G8vnN9MZWSGhKJvYpCAtv/fsI15JdogGEOBpZ6y5td0yBK8s8c/jte/XNvgSwfbiw6Zw/4dKBbthviLyVjCYHlBUE7vEExkc7z53Dps4TSziZBsU2NUqj+a+7NUpmp28lecZXknIwk02LnKVklV/Ef7FvbSXjrwOJ9qo2PAhlHb0asH+3lgq5mThRXgCYGJ5ncJn0bhHmh+q2KtHYCxqy4bwAdmsckTV120IZdhj5wM7rjamoAHWH8a3NwXSTDWlGm/BINon+vVvqiBIU0czeGjSWtQlmUhiyEpUeWjK2gqnFTFRZ8g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(86362001)(5660300002)(7416002)(508600001)(26005)(122000001)(2906002)(36756003)(54906003)(186003)(4326008)(66946007)(6512007)(31696002)(110136005)(316002)(71200400001)(38070700005)(6506007)(31686004)(66476007)(83380400001)(76116006)(2616005)(8676002)(8936002)(91956017)(6486002)(64756008)(66446008)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlRmc0V0UEJGUWZQa1FsY21vdUQweUpFYU4zdGhlNU1tblltRnk3WVc3aC9U?=
 =?utf-8?B?ZTlMR080MnNQV2VWR0tjWEY5aXpzVG1RZ1JTZ3hvWG53OXFQakxUNVBHZHJE?=
 =?utf-8?B?czdpcXBSakpEMWRUMFFZdzZsQlFVNVFhT2VVaWRDeWFQMGFycWNQRVJxRjFO?=
 =?utf-8?B?Z3ExY3pUd2dPRmwxOXRLUURYeTAvNFJDM1dPMGFhMkZNKzV1VTRHUWc2THdK?=
 =?utf-8?B?R1RndzBqV0tsVWtvMTlDRTFTYzRYeVZJNDRkODEyK0I2MUs1Umt2MTR5U1dv?=
 =?utf-8?B?SXVmcTNTdWd0R2JsZ0ttVWNGblBmcGJRZXdvS1NoUHc5MUtFbzVuZmRmMWNF?=
 =?utf-8?B?QnUrdTFvcmpKV05uSDdua1ZQam5Oenh6Y0hDTEhyb2tQdU12N0h6ZHRJblMz?=
 =?utf-8?B?WnpBcUJ6OVM0LytNcTB4TzZXcDNtblV4azJHUkx3SkFTY3cvL3djOXdudDBL?=
 =?utf-8?B?NmlNQm5nQXFqVHlWVnRHdVVhOVU5Y1N4WmJxSisvcnpWUmx2Wks2SHZxQ3JI?=
 =?utf-8?B?UDQ2VHJ5NFFTTEZOK0NxVDBKdDlwaUVieE5SYWJqYkxSQzdabFBKVi9YNlg3?=
 =?utf-8?B?M1ZFZjdzSlhwT0NGK3BZU2NvcmVLSGpnMHozL1dDQ2dzeUpST1c4M1lDYWNu?=
 =?utf-8?B?emFwU3h5blJFQmo3VGp4N2R5dE5haHpRQjRSRXkyRzd3TGxEeFBWbE40K29J?=
 =?utf-8?B?NFNwdm9tRzU0QUh6dU83QXdUM2RPVm9hbnJ1MDZ2b1hWYlBuaDdNNDl3TlF4?=
 =?utf-8?B?TlgrckgvWFZqTzQ3czBORzhGeDNrT0JWTUltSHZtSkcyK3VRQlVubEI1YVk0?=
 =?utf-8?B?OEcramFnazJrZEtTTWlUbU16NUJTL2NTeURSZm9IOEdxMDVOd1VQK3YyOCsr?=
 =?utf-8?B?d0xKM1lXY0lRZCtRSHZxSVpPakVHRG95K3k2VFhlVngyWmxnSXRKSEtWSUoz?=
 =?utf-8?B?cTR1Z0ZDb0FwbVZHNDBJVmlHMk5idDU5N1JiOWtHcUppWkYrY1psOWFFQmp2?=
 =?utf-8?B?TSs5TFlRSzJqTlV4Y1Jpb3dteXFHbkNVa1IxRm1VRG83dXRjTytESHE1SkZH?=
 =?utf-8?B?OXRPR1VKOUhYVGV4c1dGem1DVDYxMVd4SWxzYnRXRXl6Qi9ja2wrZVJnSiti?=
 =?utf-8?B?QTRKNURITGtHQ0NVTElFSHFXSkJqSVI0K0VLMzRRekErRDcxdzhaaVdTamxL?=
 =?utf-8?B?Rk9tc1NKU1hOMm5PRkdpNHYxVG9OdWx1L2hqQnpsTWFIeHVhK25WQXY4ZWF0?=
 =?utf-8?B?bzF4ZzRGdGNYMTJzZEVFU1pab3FRLzRKOGlyenZiTHZBZFQ4UktkeGY4Znpt?=
 =?utf-8?B?bERCRUhwM09EQ050MDlMam9BYkxlQk91NW16K095TkJTblVWeWVjWXluNTF3?=
 =?utf-8?B?L21Nbnh5eWc1U0EyeWtpcXN3Q0I2aGkrclRzaERqSHlsenFPOEFCQndOc3Vp?=
 =?utf-8?B?NW82d1VJb1pENTV5akdzUlpwSHRCNlJrQTR4Q1NQN3RlY1Z4ci94SjU1M25S?=
 =?utf-8?B?eGM3TElMNklCNnlrUTQrT0tSbTk2ZTFTNzJsY2Q3cktDbHY3bXFGNHlBd0o1?=
 =?utf-8?B?bGs2cWVzN2pTUUovaEI3OGkrNG5pS0g4ZU9pK0ZEaWlRWkFraDY2SWxGS0Qv?=
 =?utf-8?B?NzFSeG1mcFE5WkdNYXJURjh6b3dUN252MW5BZ1l3d3haMENtVHd5LzdQTTBn?=
 =?utf-8?B?QjlYMlRHMUVuR3cyLzYzdlZ4SGFOOWpIaVhCQWs1T1NRODc4ZVdqMmM1Q3Z0?=
 =?utf-8?Q?sArylWtH+P1cDrKmGs=3D?=
Content-ID: <5FF28D33A5C7914D8479462BA157C132@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777e5a4f-a1f2-4c79-5cf4-08d983d000ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 05:06:03.9814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fvCR/4ED2Ayi6HSchUtjcYuvhr9IO6JHd9fgplg1magDGfGHaOxut5ftTUJf+itmnK7p6phJvgkcwyjKdqkxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1199
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

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7efb31b87f37..916750a54f60 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3771,7 +3771,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>                  blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
> 
>          blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
> -       if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
> +       if (ctrl->ops->supports_pci_p2pdma &&
> +           ctrl->ops->supports_pci_p2pdma(ctrl))
>                  blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
> 
>          ns->ctrl = ctrl;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9871c0c9374c..fb9bfc52a6d7 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -477,7 +477,6 @@ struct nvme_ctrl_ops {
>          unsigned int flags;
>   #define NVME_F_FABRICS                 (1 << 0)
>   #define NVME_F_METADATA_SUPPORTED      (1 << 1)
> -#define NVME_F_PCI_P2PDMA              (1 << 2)
>          int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
>          int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
>          int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
> @@ -485,6 +484,7 @@ struct nvme_ctrl_ops {
>          void (*submit_async_event)(struct nvme_ctrl *ctrl);
>          void (*delete_ctrl)(struct nvme_ctrl *ctrl);
>          int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
> +       bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
>   };
> 

Is this new ops only needed for the PCIe transport ? or do you have 
following patches to use this op for the other transports ?

If it is only needed for the PCIe then we need to find a way to
not add this somehow...

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

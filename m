Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AFFC433EF
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 02:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0D6974019E;
	Wed,  9 Feb 2022 02:50:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 35gPW44hK-aK; Wed,  9 Feb 2022 02:50:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 722CA40141;
	Wed,  9 Feb 2022 02:50:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5294EC001A;
	Wed,  9 Feb 2022 02:50:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CBC8C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 02:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C26482F87
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 02:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g1yaa1alquga for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 02:50:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::613])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 110D582F80
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 02:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpGelViq1nJ4Fu+6Pu14e1FhIxyPvCgDL/LWI5VH2Bc5dFguSzATW06XaS7AcY5BHjKzkDF7ISujKyO5GtTXEuhP4C+mh2yU6hGgV2OkRF3rPVHQHWkZKDaQ1t7whLEXVrtrrcTinl/ub6wQHDSVNjQ4BfqvLCxHeElNxKuEh1xw/o4sn/C5OOfz336Ynrh2DOsmUmqJumxbP9psxp2GDdNwkSQo87XagEKkEOvso7bWsVCHV6SeMZjzC+Br7NdNOinutIZB7T2RNrzfX9CsN8TpObz4aiw9RHvrXgSIBWMIP6Qm06DTpwzSFBQ/iBR3l3OvG1STuWAesUR3XrMzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iI7gCE5CR1NBPpU14oW1EMoyEmh4MDUGQLZxUjXsa+k=;
 b=OGzlpOVwfJqX5ICEQxN5M6G9ks5s4+IBffiAaeQOOCoqtf8tYYP+x9oGhqD4/apaa/79sHqCfSkeopelsP57BJC7mTVW2Aj/MJrRMMCz4wgw4KnSOQL8l1+8SX2d7ePMy+kdFhV/WNAczqdWaI8BlkuGsaCwNkyMhZ7yVky3p3o+3rjSJCWd5EQbCSg+TcWNaJNXegJTio/83Kh8EK0S2Nr7Iw+Ycdt2pt8rXegaPvPpVladjeawjvU/1hcualQ8bOwWv7jERjEuYokwehO4LgG/gGbvy6aFY91uLbYF1Fam/RI79wHViV2SRNp4SlpDnadvuRJf7hNqF/M9CMvOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iI7gCE5CR1NBPpU14oW1EMoyEmh4MDUGQLZxUjXsa+k=;
 b=TL5BdjE/+WDcKOgpnIsn/qau0MQeICcfbYsLbMqbbZjdXoxKpq0yqaK9VnjYrhkskx+7iDIV5tgKO7OXJIbHsq3ob9VB4DtMRT4BIFya1kMbbDyZ7PjJO0D3yG36daEzh4dmr5db0OatO7xkuvV8szg7uE2UvfxMOoEHs/dRCsI=
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by BY5PR19MB3425.namprd19.prod.outlook.com (2603:10b6:a03:1c0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 02:50:35 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::f4fc:46a4:6bbd:b07f]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::f4fc:46a4:6bbd:b07f%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 02:50:35 +0000
From: Martin Oliveira <Martin.Oliveira@eideticom.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Error when running fio against nvme-of rdma target (mlx5 driver)
Thread-Topic: Error when running fio against nvme-of rdma target (mlx5 driver)
Thread-Index: AQHYHRbxB1j8kCqLyE+mphWtfDRQHw==
Date: Wed, 9 Feb 2022 02:50:35 +0000
Message-ID: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25875d16-eea8-4ef8-a02c-08d9eb76f260
x-ms-traffictypediagnostic: BY5PR19MB3425:EE_
x-microsoft-antispam-prvs: <BY5PR19MB3425CDDEC820B7D1103EE22AE42E9@BY5PR19MB3425.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uI5BZQWhbpBMnIjIJJLkANS8LW7F5E784dQbV1qoUEMFykh7z83JEf8gPDTU/dnDz4iel6QXaM1ebRy+EyQLyhrdnPqMifAdkrqwfc95juvk5s3nvB6tJ0rdY83WDb406r+P5MVtEaPSdULecBnAv8JRGhbMtnQadMS2jyli7B2WphX29iz8JHuAJ6Z7CzvdMcG6QT0CudyboLT3mTqfE7ycuKW8VFIiEdGxfD1ZC0zv7UkmzFy4oOtDJ1b6yLkLqVJDw/XDn1q1vLH5532JOA4GdbcV3p7Zq6QCJfKBMFcDixa8FIBXA6Cxxdy3bqr1r+NNIZpaQzLROqQzeW2+aTIC8LFU89OMuw3zYOnEkRphmvTuJOk4B7CsZJnVFt4xWTqvcWV1MfjF5C2xKRKucVy34pMTJtlykV0LXMOA/lAz/dfH5GHtB15BWvpbwqRBAQbcnS4X8/RO7lcxlVRpkszGWFroT2Wcix4mVMJv2KGCSGvQawfgjZUrk1tR5ZA+UXq1Q+TKRjrDzvNnONzfIVQO/cjnJnWkH/7BKTjUPjXnjGJxPcpNlbSzLZpkuoefK2EAhdi02tqluZfSf4NiYSkm4OrYLRgfe+UHvP9/YFxNA1jeRXG6EmVXBVpsVSNmxW0xI5wbV3IXaDaD6Pr1g6dW5QIoOPmf310r0x+3qMdJgrZYOUKfjl0zPKs7AMqVuVnmLHQJ1NpK7BVo5pr74h2NDzb320N680x6F0ZSD3dBe2EHpmKfPmaciboAkex7tjmCyubb6hTd2coBRuN29rBZ0saSDKW3LWbrrvEwxA3HdZ1fYmFG/4aSW8iC8b0H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR19MB4250.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(136003)(396003)(376002)(39830400003)(346002)(366004)(66476007)(64756008)(66446008)(66556008)(66946007)(26005)(4326008)(8676002)(76116006)(186003)(86362001)(5660300002)(83380400001)(2906002)(122000001)(38100700002)(55016003)(38070700005)(8936002)(52536014)(54906003)(110136005)(71200400001)(316002)(966005)(9686003)(508600001)(7696005)(33656002)(6506007)(505234007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JZX2eVxKRuhFbiRXvYJ/386NYGdjfp94Ed3zLihN9UugLZUICru3chO4IH?=
 =?iso-8859-1?Q?4n6+CNnZFx8HCCW+EoBUYzXG6fzcL0Ns5GgJkbVrIYFd06GhzUpJ9rD8XS?=
 =?iso-8859-1?Q?H1RDdsfshHOP3FOvOK+dfI4Sttx12UQtFnLScFQpRWXLa+Nrjud9jJDbNz?=
 =?iso-8859-1?Q?4eu4260bef9+75z8QcJ51v5535wPFNdQKsg9Bm4TPOkCOZIf4wHda3c7Cy?=
 =?iso-8859-1?Q?+n1IIbY1f12TZYpJJyT7fnUFMerDNleJ8U37d7cc18h5QnhcgtohgS27Qj?=
 =?iso-8859-1?Q?PZfsVCqKG3TuGXqTbvqssEpJrK1KnZ1kx2yAxv9FbSwe0CAfTwOCuZKq6y?=
 =?iso-8859-1?Q?ReO+EmM+yOGSJO3KxYwwYBCdWcMFXK6knbJBcIF9PpjQYitu2OI/p/k117?=
 =?iso-8859-1?Q?E92SJU3izdLPqHA103VPOZpWph2KbjB1Vvea22JTSarfV79Kwk1bF9llh+?=
 =?iso-8859-1?Q?1cdaEtyZaE7X27XQixmtKZYYZa0/ZvukqqtDdks7P6Qn6B4WbLEXA5/Mlb?=
 =?iso-8859-1?Q?ELAUbz/TZV7WFOPn214lPeT1S9qINy9ZFNRD8eLRqbit5ci7u3C8xqmxG8?=
 =?iso-8859-1?Q?VTMppj3VDmuvOTJQZL/SyFS7x99vJRNwbSk9TVvChTpLMARtjquQsh8CJq?=
 =?iso-8859-1?Q?e15Za6TV0Q26Ptljnp1pLly6NiWILOJvToyn2TRjXJlFRnVkrO6GCsTOk5?=
 =?iso-8859-1?Q?LJOk5oYrN2M9WTzKz8ixEFc71ApL/dRyXGLvSPorF1BnDtfPb+rX1NHtZy?=
 =?iso-8859-1?Q?4zuNFw0yMy/14INjjYmUUq6H4sVLOtMatNUEk3VLuSS5V/EgLgYzEpvtqg?=
 =?iso-8859-1?Q?81zxFcalUHJOsSdYgXHwPsa65kaMEPuSJBoeGlPK6t34VgKerGBsZc6raq?=
 =?iso-8859-1?Q?DPQvRxx4t7lHbOpsgaaUBVMAdiAdAvhDCmxiUSPDBtIqf756O/KnbnaM0P?=
 =?iso-8859-1?Q?xGNVxTd4nzNC+rzAzVCv+UyCOPm3JjDgLfrgLPjl0KkyhNMG3JEN8UdIgk?=
 =?iso-8859-1?Q?IXmKDXJRUsnAeejKdfJebQ83Hj5tX7FtNyRZk8bExJZLSeqG315hsYwTCI?=
 =?iso-8859-1?Q?GUjHSz3DUPOyBzXd9sFNyUkEQrRSypvTK29zKHjCGJCP/Nny+oaJbnRuEP?=
 =?iso-8859-1?Q?vcY/GdPN7zgbBn9YFHkrQRlt+iLHZNqTOU9dS68Xc1vNKEGOQwxogmnhGv?=
 =?iso-8859-1?Q?hGJGMOz2hk9KDU2zjeuTxdIR65DHoAbuX2PUO5n9Hs+QXIeetFrdabD8p3?=
 =?iso-8859-1?Q?x2XE0YVSh2oQDgm+gXEJc/GEgGldymWw5KgkEZSTxzRL84KRfeyB007MMr?=
 =?iso-8859-1?Q?4vyZpuun11lyZdjsFEtkBvEPvfHnrBfR5oe+VoHKiec5KJCzT14vX3ckpQ?=
 =?iso-8859-1?Q?uuY3Y60zoDj+E0c+Jdlvi2lqAeMHJL8SGMbTRc40+g8LOK7UcKhcDuPomq?=
 =?iso-8859-1?Q?ZZhc92/oG+vW3Ws6FjAHZQYJN9IJA9GUCOy2ztHe7EgITlmOqSmF5B59Kt?=
 =?iso-8859-1?Q?sY861D4BPlbsZ+2KajXfHG5hBM7gBv1x9XTpccjaZw13leC3gHEUGNcNdq?=
 =?iso-8859-1?Q?+hRbmBnw4wiqIC25so+yhDjqkr9UvEsFBYVDRxYGOgjpemyP3bl8pTCI8X?=
 =?iso-8859-1?Q?RWS5kJ8LlX4sJVaMgwEVrCF41yk6N1ZMBwnqL7hrnFyrjGQ8dZqQwtT9Po?=
 =?iso-8859-1?Q?gkujd8zIYhobj5ElxFC2vn3GsZy8yo2TwXQg+rj1vmYO89ZdNrp02+gBLk?=
 =?iso-8859-1?Q?tLHA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25875d16-eea8-4ef8-a02c-08d9eb76f260
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 02:50:35.2067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4UXkSIy9gediJvHA8dI5mCD63VJVnZHZD8xpNHeeDQg0Vng5f3MXNxyw0qsVA/QLEHj48tu9QhXFUMsz7lKLRVTc0eNSe2fvedrZt8VyT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3425
Cc: Kelly Ursenbach <Kelly.Ursenbach@eideticom.com>, "Lee,
 Jason" <jasonlee@lanl.gov>, Logan Gunthorpe <Logan.Gunthorpe@eideticom.com>
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

Hello,

We have been hitting an error when running IO over our nvme-of setup, using the mlx5 driver and we are wondering if anyone has seen anything similar/has any suggestions.

Both initiator and target are AMD EPYC 7502 machines connected over RDMA using a Mellanox MT28908. Target has 12 NVMe SSDs which are exposed as a single NVMe fabrics device, one physical SSD per namespace.

When running an fio job targeting directly the fabrics devices (no filesystem, see script at the end), within a minute or so we start seeing errors like this:

[  408.368677] mlx5_core 0000:c1:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x002f address=0x24d08000 flags=0x0000]
[  408.372201] infiniband mlx5_0: mlx5_handle_error_cqe:332:(pid 0): WC error: 4, Message: local protection error
[  408.380181] infiniband mlx5_0: dump_cqe:272:(pid 0): dump error cqe
[  408.380187] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  408.380189] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  408.380191] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  408.380192] 00000030: 00 00 00 00 a9 00 56 04 00 00 01 e9 00 54 e8 e2
[  408.380230] nvme nvme15: RECV for CQE 0x00000000ce392ed9 failed with status local protection error (4)
[  408.380235] nvme nvme15: starting error recovery
[  408.380238] nvme_ns_head_submit_bio: 726 callbacks suppressed
[  408.380246] block nvme15n2: no usable path - requeuing I/O
[  408.380284] block nvme15n5: no usable path - requeuing I/O
[  408.380298] block nvme15n1: no usable path - requeuing I/O
[  408.380304] block nvme15n11: no usable path - requeuing I/O
[  408.380304] block nvme15n11: no usable path - requeuing I/O
[  408.380330] block nvme15n1: no usable path - requeuing I/O
[  408.380350] block nvme15n2: no usable path - requeuing I/O
[  408.380371] block nvme15n6: no usable path - requeuing I/O
[  408.380377] block nvme15n6: no usable path - requeuing I/O
[  408.380382] block nvme15n4: no usable path - requeuing I/O
[  408.380472] mlx5_core 0000:c1:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x002f address=0x24d09000 flags=0x0000]
[  408.391265] mlx5_core 0000:c1:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x002f address=0x24d0a000 flags=0x0000]
[  415.125967] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[  415.131898] nvmet: ctrl 1 fatal error occurred!

Occasionally, we've seen the following stack trace:

[ 1158.152464] kernel BUG at drivers/iommu/amd/io_pgtable.c:485!
[ 1158.427696] invalid opcode: 0000 [#1] SMP NOPTI
[ 1158.432228] CPU: 51 PID: 796 Comm: kworker/51:1H Tainted: P           OE     5.13.0-eid-athena-g6fb4e704d11c-dirty #14
[ 1158.443867] Hardware name: GIGABYTE R272-Z32-00/MZ32-AR0-00, BIOS R21 10/08/2020
[ 1158.451252] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
[ 1158.456884] RIP: 0010:iommu_v1_unmap_page+0xed/0x100
[ 1158.461849] Code: 48 8b 45 d0 65 48 33 04 25 28 00 00 00 75 1d 48 83 c4 10 4c 89 f0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 49 8d 46 ff 4c 85 f0 74 d6 <0f> 0b e8 1c 38 46 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44
[ 1158.480589] RSP: 0018:ffffabb520587bd0 EFLAGS: 00010206
[ 1158.485812] RAX: 0001000000061fff RBX: 0000000000100000 RCX: 0000000000000027
[ 1158.492938] RDX: 0000000030562000 RSI: ffff000000000000 RDI: 0000000000000000
[ 1158.500071] RBP: ffffabb520587c08 R08: ffffabb520587bd0 R09: 0000000000000000
[ 1158.507202] R10: 0000000000000001 R11: 000ffffffffff000 R12: ffff9984abd9e318
[ 1158.514326] R13: ffff9984abd9e310 R14: 0001000000062000 R15: 0001000000000000
[ 1158.521452] FS:  0000000000000000(0000) GS:ffff99a36c8c0000(0000) knlGS:0000000000000000
[ 1158.529540] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1158.535286] CR2: 00007f75b04f1000 CR3: 00000001eddd8000 CR4: 0000000000350ee0
[ 1158.542419] Call Trace:
[ 1158.544877]  amd_iommu_unmap+0x2c/0x40
[ 1158.548653]  __iommu_unmap+0xc4/0x170
[ 1158.552344]  iommu_unmap_fast+0xe/0x10
[ 1158.556100]  __iommu_dma_unmap+0x85/0x120
[ 1158.560115]  iommu_dma_unmap_sg+0x95/0x110
[ 1158.564213]  dma_unmap_sg_attrs+0x42/0x50
[ 1158.568225]  rdma_rw_ctx_destroy+0x6e/0xc0 [ib_core]
[ 1158.573201]  nvmet_rdma_rw_ctx_destroy+0xa7/0xc0 [nvmet_rdma]
[ 1158.578944]  nvmet_rdma_read_data_done+0x5c/0xf0 [nvmet_rdma]
[ 1158.584683]  __ib_process_cq+0x8e/0x150 [ib_core]
[ 1158.589398]  ib_cq_poll_work+0x2b/0x80 [ib_core]
[ 1158.594027]  process_one_work+0x220/0x3c0
[ 1158.598038]  worker_thread+0x4d/0x3f0
[ 1158.601696]  kthread+0x114/0x150
[ 1158.604928]  ? process_one_work+0x3c0/0x3c0
[ 1158.609114]  ? kthread_park+0x90/0x90
[ 1158.612783]  ret_from_fork+0x22/0x30

We first saw this on a 5.13 kernel but could reproduce with 5.17-rc2.

We found a possibly related bug report [1] that suggested disabling the IOMMU could help, but even after I disabled it (amd_iommu=off iommu=off) I still get errors (nvme IO timeouts). Another thread from 2016[2] suggested that disabling some kernel debug options could workaround the "local protection error" but that didn't help either.

As far as I can tell, the disks are fine, as running the same fio job targeting the real physical devices works fine.

Any suggestions are appreciated.

Thanks,
Martin

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=210177
[2]: https://lore.kernel.org/all/6BBFD126-877C-4638-BB91-ABF715E29326@oracle.com/

fio script:
[global]
name=fio-seq-write
rw=write
bs=1M
direct=1
numjobs=32
time_based
group_reporting=1
runtime=18000
end_fsync=1
size=10G
ioengine=libaio
iodepth=16

[file1]
filename=/dev/nvme0n1

[file2]
filename=/dev/nvme0n2

[file3]
filename=/dev/nvme0n3

[file4]
filename=/dev/nvme0n4

[file5]
filename=/dev/nvme0n5

[file6]
filename=/dev/nvme0n6

[file7]
filename=/dev/nvme0n7

[file8]
filename=/dev/nvme0n8

[file9]
filename=/dev/nvme0n9

[file10]
filename=/dev/nvme0n10

[file11]
filename=/dev/nvme0n11

[file12]
filename=/dev/nvme0n12
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

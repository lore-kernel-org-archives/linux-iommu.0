Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2075.outbound.protection.outlook.com [40.107.117.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB531A6E
	for <iommu@lists.linux.dev>; Fri, 15 Dec 2023 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbT0xswKhW6zzalhKqr/Zrr11u9vtAYOE65Wfx2bU1622+2omd/KrrJUDQLpAkNzAyYaz+zLM2o84PgQHv2AnWxoD7OLGyO9aXFT+aFEtiIlQqMm2Vh2lDf05wCjAe8LJkm+RMthIXY4FJSVZGU/QzHwRQhdrMqr92ACr2IdtlShsz+XCqd/U3YFV777G22u1fU0gN1D2a+z6QjBr7oHUrJ+ZQud1YNgvKI+zuT1PKFiCdVPxgAaLgFaJcXIqwT0+8aHa+mSJHmHuNNOxXxlfz69bSqJMEdGWZS/tAxhxAG2Q63eg1cOyFnezEWfMP2DP58bdedp0PLAYTFoSWKXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVq/OcNGaRIoNZ+1LAWvTBA6OR9WCTp/kt75rJ4FPgg=;
 b=WYRlhDZuRYGnWHxp9SCbPiCR1zqiaGZEp9ktEHlQIShZhA+eR5YuWsD0xeSbsUK1+jvsI/BR+IrUtsN1xxKYoLX8uO0QSiGlaOpp8xeFQwZmNfVoNeLp7Tdosn4B1ty2fi09SqKoH/jQLcGUDNA+pPJ//zGRBcvn71WzqrGbH7x69Og0C62P8nAFzW+RastttxU2uboJhhJUUHkOD9dG4jbJrZHXVCBaIU3bNTljQeEnF0Ky0ARtcXL/1bFuyDjH9qPgif6pbIFc5Ak67Hi/yuSMXZmGhIUAR3tJFHzjgzL0Nnroq/YyWntKMHQTZQc+n2eF3+ArnKB+q2umY6x1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5)
 by SEZPR06MB6551.apcprd06.prod.outlook.com (2603:1096:101:187::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 14:24:49 +0000
Received: from SEYPR06MB6278.apcprd06.prod.outlook.com
 ([fe80::c664:8a1e:66d6:4e62]) by SEYPR06MB6278.apcprd06.prod.outlook.com
 ([fe80::c664:8a1e:66d6:4e62%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 14:24:48 +0000
From: "Joakim  Zhang" <joakim.zhang@cixtech.com>
To: Christoph Hellwig <hch@lst.de>
CC: "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, cix-kernel-upstream
	<cix-kernel-upstream@cixtech.com>
Subject: RE: [PATCH V2] dma-mapping: Set dma_mem pointer as NULL after it's
 freed
Thread-Topic: [PATCH V2] dma-mapping: Set dma_mem pointer as NULL after it's
 freed
Thread-Index: AQHaLmcky1/MaAD/QUerCOizXimNM7CqN/MAgAAuTiA=
Date: Fri, 15 Dec 2023 14:24:48 +0000
Message-ID:
 <SEYPR06MB62784DFD5EBBA85361C80A068293A@SEYPR06MB6278.apcprd06.prod.outlook.com>
References: <20231214082526.1212264-1-joakim.zhang@cixtech.com>
 <20231215113226.GC6479@lst.de>
In-Reply-To: <20231215113226.GC6479@lst.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB6278:EE_|SEZPR06MB6551:EE_
x-ms-office365-filtering-correlation-id: 741b85c3-313a-49a3-5b77-08dbfd79980f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dm9Lxrgod1WId8PYx3XZ7DCYcv9wmd889jvaTwPPQq3ydhWIU0H4FcCImPaGE7WTXU4YuzSaFePiB9/VXr7WvMXMRJXDn6CqKtOavHGk4nAT8z+bN/4Ixc9h2FTjipfCjtmEn8UjrhrYF20tMs6SZ0gzrcE7/vP5p6SWQm9TthYAGjK8McKboXaEPp9hEO7eCEEPTWaIIbg4hUGjBCDX6eAdzfh8b9O7vxsm3qg1dOFCZ8JFRuXik9J0uBHHNdtNqVRyXrVnYdBJHWnWfSW6RngYKsuoo8dVWSyxvEPKABj8gWUIpdVgBiLz76qx9SRsLhKVFjQwAJfllBzxtgGTzCPAJLp1/1koatK2tyYAjnIocsy9BSv8AXLhPGaKgCDOiekyNAvaQWVe5Xs706cqjhB9zfq5mLBwZqTElCKpuio7/dQWSOHnYZ6r7NOsT1+qVDTptFUlMoI8kqMOTaTxmcuO9cfnOT+khlIyWULZOGxHGClhUy62d8vlXZpegNxwugS5RKlaACVH/FF+zlH6/swHkksmJEjIpagxMIo8rL8+ZXaj6GI9I8Zgf39f7yyV2VWjCd7Ccj6WiCCbQvPEmIJVnAOKbKGBsY2NPdGQNSqytkVLPqNJMWAGFPeki+a+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6278.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39840400004)(376002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(83380400001)(478600001)(66574015)(38100700002)(122000001)(66476007)(66446008)(64756008)(54906003)(66556008)(316002)(6916009)(71200400001)(7696005)(6506007)(9686003)(107886003)(55016003)(76116006)(66946007)(53546011)(52536014)(86362001)(33656002)(8676002)(4326008)(8936002)(5660300002)(2906002)(41300700001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gR6IVF31s5/a+rBszYf7yFFTJoTLPB0URtYQZjvoPQD39ZdaDQqM4wQD0ygh?=
 =?us-ascii?Q?a0XTYJ2b1bH9D9QVIsfA9ubepuqSr5Vi6O7jZZXzmWGr36BR8sCSX5vkjVWB?=
 =?us-ascii?Q?lk3/8I4HVpcYoY73/A71YCUpx0h51SfgIGe2ArPeRtd4ARxQ1L6eJjndBy/7?=
 =?us-ascii?Q?ZuVJU8XltrbefSAQ0HnDMydi1HYUyveVHlEy35wHcXrbtme/AQccl0jSpDKz?=
 =?us-ascii?Q?G9hsEssM4nWFhwXUc5QscBjU7e7Ud2EhJHDhDsggArxSgmg5xizAN71ceKwF?=
 =?us-ascii?Q?ux222+OyW+gwioHlX+lj9cfjTb6vakBfiVBgn6J1eJ439mmEDYXbTUw9FtSQ?=
 =?us-ascii?Q?6+bScW8a6iEkLyqWxIIJ8SXi7njWYqPQoWRJaP8nddLnNsDAGzvng5dmjEH3?=
 =?us-ascii?Q?JXoimsXYDkaTB1XPEvdinR/lpI+3AVRNdPJfbnQmoi1JcgINhaOike9FrzGF?=
 =?us-ascii?Q?ERw1Zh7YJLUcUbalwL9FIHlGmoGOsmWkyFINSMam4yLratp3ZjUyR12vvoGR?=
 =?us-ascii?Q?EremjIh6CajhblEuSOXgbKKAB2jr1yjoAL64zrdfFUPmIsHn8vRi+JMMv8P/?=
 =?us-ascii?Q?qp4/QelR9cUxmzoD1QyvQ0R60RrRJuQvBqOHb3BCB4d36RjKWNNjK48qU1rd?=
 =?us-ascii?Q?T1PQoxQf6fg6XgRMptKL+dyjBbBLhqG8pWM1lhtXuYrojPbyihaDnjPqXD60?=
 =?us-ascii?Q?lqyhD/vVOASAszBGqFZHZNJP140a+KmOfz6L+jMpuFQIFyEp8pUmOfhnvgiq?=
 =?us-ascii?Q?YgAM+jAzcMH7jawITLwXDRJ9so8i87HQqG3qorZM5wDsQ4ayPi9gqvMeVB16?=
 =?us-ascii?Q?chl8XJVjRCb7+zZoGS8UldbGpm62Zz9E3arSjEZtNJcSKTlntgB9i5+GWPnb?=
 =?us-ascii?Q?HXkJ+whHnV0PyvusHlfPJCc+s7nlnT0uZBG6snALfnjUm/NfCPXkuXPIA8aD?=
 =?us-ascii?Q?U+tHkJh2IKkcbLrfm165kPhcmhdKQxZ44Vp/9trg5E5ZDQzmP85UGpH687O7?=
 =?us-ascii?Q?aWACHoks9Y+tGszp7qbC/ztZ255RCfuBuCs9czW+LL7LAE4sgJAXj1dCPO93?=
 =?us-ascii?Q?J/EEV9c4iLtdw5c27HhnZOCZQ67iRqxb1R/u9JKwrRq6vfLh/oEkdZNnTRBy?=
 =?us-ascii?Q?EkWklYPV9IzP9npL7m85+cGmneQFPUVW5SslYsMC2DmTM7XQEQIPbct/756y?=
 =?us-ascii?Q?Yny9A83ETDR7eHnAAh73gWabSIV14BvRy3lgazY6V1z9IvRhLlGscopmvjXs?=
 =?us-ascii?Q?mQs+TNAPZV/0Vb5f0cSMy7fLB4Rn6QL+ELahewOb7S2jM0saugQ3+coB13jv?=
 =?us-ascii?Q?HZrLWPNOP+1dgoHVu15Z1UFlkv3VRaUkN9baZ5pxtL/AQvPTLTDcQDpQXPkE?=
 =?us-ascii?Q?ur3mFzIsf1lvG5hy347Dg1fqi4X2kzsEAtSIqguk3zo/DthzLGYInkkosfcS?=
 =?us-ascii?Q?J5HBwuVcIZcmaEPRIZeyZfEVKutn/xM1Q1D6T8J4vZeQ8F6m35hHaJ3b+cif?=
 =?us-ascii?Q?5hap0ffH0pLRfeGfkWMMegr/NJBa0HrMXPkyd9UXM+Y0NgpK/5MvdwigSy99?=
 =?us-ascii?Q?UE5eKSU5pFdJjTiY9MJpKgKaPi8364PY0X8Zzfg7LfvwbDBI9XUeVaKmnyxn?=
 =?us-ascii?Q?uODY+sNQUedZnRD5ZoWwOTo88weAgNUUJQ9BOkx8deAZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6278.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741b85c3-313a-49a3-5b77-08dbfd79980f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 14:24:48.6917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lv+QjsKfpZML9x66E2P9wEte/segBqGaIbbd7nAX0jdYQaNm7LZ0NbFWx+z+sMVnjG7RpqYAsgK5CYDgJ5HmnjpLA9JzufutJZDEMHLJPDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6551


Hi Christoph Hellwig,

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Friday, December 15, 2023 7:32 PM
> To: Joakim Zhang <joakim.zhang@cixtech.com>
> Cc: hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com;
> iommu@lists.linux.dev; linux-kernel@vger.kernel.org; cix-kernel-upstream
> <cix-kernel-upstream@cixtech.com>
> Subject: Re: [PATCH V2] dma-mapping: Set dma_mem pointer as NULL after
> it's freed
>
> I've applied this after fixing the whitespace errors.
>
> But we really need to get remoteporc off messing with the reserved region=
s
> itself and retire this API entirely.

Indeed, I met this issue when debugging remoteproc, this API maybe useful s=
ince some system would not support device tree, but still want to reserve m=
emory in the driver.


This email (including its attachments) is intended only for the person or e=
ntity to which it is addressed and may contain information that is privileg=
ed, confidential or otherwise protected from disclosure. Unauthorized use, =
dissemination, distribution or copying of this email or the information her=
ein or taking any action in reliance on the contents of this email or the i=
nformation herein, by anyone other than the intended recipient, or an emplo=
yee or agent responsible for delivering the message to the intended recipie=
nt, is strictly prohibited. If you are not the intended recipient, please d=
o not read, copy, use or disclose any part of this e-mail to others. Please=
 notify the sender immediately and permanently delete this e-mail and any a=
ttachments if you received it in error. Internet communications cannot be g=
uaranteed to be timely, secure, error-free or virus-free. The sender does n=
ot accept liability for any errors or omissions.

Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2060.outbound.protection.outlook.com [40.107.117.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A711735
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Od/GyoQdzwhGlIk/HWT1xeEFdHCagltZ7T+o596D99EvBp2XiCdShE7x30+S7D8Mlh/yNgWwoKYUQale8pcCdYjLH1K/FRu2gmzdcWeBVcTMFdIH+90CB3DrCyymOGIwYWbf8okbO+wmhXORpgy2Gy2EwfnqrZfbk4oL2WjSLH5xxZGzvUVRm3Zh9Z1kgy5hBUFYOaRxYdN+1xl6V//XIsE0kyqv2Q1UcC5xCmProHOgFvJmGeVBobwb1oN/wCadYrpiRC365D74ik7uh1cEdbXvrsPH/agM1H4TC2WZ68KugGQ+3E3ff3evS6NiyHUgWLW4q+uKfcZkA/6RkqaZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEgYDEpfU2xl7gy6smJGk43OQ3j/nbvmQ+7IwmGzkSs=;
 b=J6BFrXzkmVCQaYduVSAq0LYtfAS5PWGgjpYsIi5Uppup1DdwN93KOYIg3twOTJ7BzUj4tg34wn7YMQl7vDyhUFHAk5S4AVN8Of6SFgKm/yhkMvH7t/phyxsFkOhWB4U5iGkC3bOCvHpKQAMxjXirzfTPlW95nhbJraF2xrS0HLNnFcPM3OtKqTYPFENu4Eswj46iySVz54+YIDBgniXu8PBnrYVUiAO+CDw0XFTLZETHUkj1pdwQ++GqA8pSamaZVrmI34CxST/og+l4fbe2JZpe3eOra9O833EiDoFgH2sL3gDP4zVpMUEgM0M2SiSCDkyaREKdrUGZUXSDQHzdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KL1PR0601MB4354.apcprd06.prod.outlook.com (2603:1096:820:79::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 05:21:54 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::2625:d246:abd7:4a7a]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::2625:d246:abd7:4a7a%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 05:21:54 +0000
From: joakim.zhang@cixtech.com
To: hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	Joakim Zhang <joakim.zhang@cixtech.com>
Subject: [PATCH V1] dma-mapping: Set dma_mem pointer as NULL after it's freed
Date: Tue, 12 Dec 2023 13:21:30 +0800
Message-Id: <20231212052130.2051333-1-joakim.zhang@cixtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|KL1PR0601MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c339b5-ae0d-4914-842d-08dbfad2408f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KMGer2BXGfr1VabclwXj9TLErKAYCL8k/FeuE//mRIWbdSP7P9cRZeniKRatgFLnxSpMAfe2v72DJD2N6nwBY33uRd0UJY82tvmeeHUDfXHQuzJnhFZnnbWEHYKXk9YUf2Aw6WtRVgzFU5+CgYMQqVXbQxsdhNcWZYeEqqrlV2jblj+a+DpdhBZxzgek1p0aFtBN7VuBjBQO1/Uq1E/vZAfea9wlLkVcTG9zDeQg1wQYouO7Ncxeux5oACA2PskzVGGH1FfT8WSZx+ovlwx/Y2AuvCrADPJlgL64b9mvd+3RYCxGpXVoSDL9g2qLFfBZvmebu+NimU6XDKj3wGtZ2DhAQXwVymtBjkR+g9uLL+az6i22hcoVUdb69MCoeh6S3vuEONeA3vDbJ4JMZeabgfsbnWViec/bSX6XGXBB9cgEkPKPZheC4svY3YTiU/sqD44JorwWxfemv7R22T00Jvzj6s7DsCClLEdDcY6fI0DGmTERA5O4kVzzSZ3yyxmpD28llezMCvWVOg62s2NzqPW7OBYgWl8bYrqZuWv8eiExXM8WPPmwZC8hZFg9gc4TE9nNPOxE84ahfw+g1+3/GRFYmG+s7OiWI8AVYs8Dy5tbA9CVo0Vycn1bnfbpZBmU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39830400003)(136003)(396003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66556008)(66476007)(316002)(66946007)(52116002)(6506007)(9686003)(6512007)(41300700001)(6666004)(26005)(66574015)(36756003)(107886003)(2616005)(1076003)(38350700005)(38100700002)(86362001)(83380400001)(478600001)(6486002)(2906002)(5660300002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d8MBfW3wJ8kj8Q3yQF4pOW+MugonYzsYVRvj8fRR6oswWx13PqFCgO3UFsst?=
 =?us-ascii?Q?NADXgp/xkXYV03jAXl/JSucvL9Oxe58zjiJ7GQ4k6/+x1JZ9aXtt7yzuJQRl?=
 =?us-ascii?Q?Wf8qAQKLgPIHdJGJ154ZDbNCcy8p9tca2swtdaTKiq/GQk9rs1JMRQKbPKto?=
 =?us-ascii?Q?T8X8uiNtrwJRQbycPp5yqwXJ4PFibD0N2ARJpmyn+OEQX8NOnodRWRMQMs4j?=
 =?us-ascii?Q?H7xV0Nx8rCU3kOXsI0AGS18m+3Dwn/SCn5MBumTBNHERtxuf+Fm8K62C/q99?=
 =?us-ascii?Q?Es+C42gOQxTs6gTNX/sZ3uLIPoIhk9b19mAQdNRSr6Yw1MahG5xhui3+MsGw?=
 =?us-ascii?Q?YvbsDWzRJE3v0Af2wtAbBZNU1YlRYW1DAcleBSFx8ASAn+BCMqYkkEMYWFPy?=
 =?us-ascii?Q?AhgzLuBKnDPgNnTLqY9CjZx9ZnFCJTOjgdmsFg2XIbdNGcrvVVpJ0PJbt4CE?=
 =?us-ascii?Q?6wIxKUxyjJMVTRU1Lp+juYPc9V3THMlrgmThC1lEVGyHNkV7WYZHeYGBPtkl?=
 =?us-ascii?Q?yklk7BbM1Kd0/W4EbkzIe47B733BluOF2LfGetenr+lx6kF78KV26oeAcmjD?=
 =?us-ascii?Q?iWEfsjFTauFROL4JxPTuhrHWn3DcmSDHJdnaJaj6Frp1J9X7TgLdJrU9Ajdc?=
 =?us-ascii?Q?Nd4RWoUEll3HTZTYVjLQHuI9+ORxZnLAgfJuvh4I8qKRgA0BFBnM7A9V69xW?=
 =?us-ascii?Q?lsLjJdoHfnNvjZyo9XTBmmXONHZrQfx9q4k632p1F68UoSCUw9DIs4Nhf0RL?=
 =?us-ascii?Q?jjnndqZW7G6SO3aPm1UB0aei5TF38hsYXB5Wf26D8RyA5QOevhF86HKe4nk2?=
 =?us-ascii?Q?Fdp/L1VdjSc6S2flx7fXAG9owYXmv0oSwgFLU4fIyb4YKrj2tsnwUiMUsMat?=
 =?us-ascii?Q?Hr8pU5RIVww5ahDdQYaJCaMY7HWxKpqiBpPwWVtIJBE+WUkvVDoAfUILGVb6?=
 =?us-ascii?Q?M+AgX1/VlQp4VrXAZqCiXr3UJ0IqLwylzCl/eg2rhDNmFNjiA4bK4lvUYxsf?=
 =?us-ascii?Q?AtYIwloplitQ1TzaOl9Ur6xkW4c7sEdA+3OSYw/H23Fm0Fgd0/QL/2Bqhv4m?=
 =?us-ascii?Q?fbI3/kbqpce1AJdRacBJynG518x4insqJ8MVGHl58H5bGvlh5A8wFUt0prjM?=
 =?us-ascii?Q?yjDA9J4/7RZlGDryyZrk6ffMfOg7D6CMhpi4DWUGpb+/hqKfsDfjEDMJFSA0?=
 =?us-ascii?Q?9eqlvYHt9Bhzov1bU0h7MxYLEoeyucZUwD8Gwofudk7OgAF67oZrK4bfO0Z7?=
 =?us-ascii?Q?/nrDS2HkrFm8mM5bAiuTOWoHdPd8fGExH/YPRUNVUlvC9hFqKfyzSCoCL16I?=
 =?us-ascii?Q?CHsA7BRqYvCFp6h8moOK9EXDFRa4Jx5DltQ8k3mES07iIcQE/jK/o0ch8lVw?=
 =?us-ascii?Q?rR2Hs8seSTxhbyNY3zus7s/5w+DERYCqjRadHpLfLWK/g3DjN3BgXW2IkGG8?=
 =?us-ascii?Q?LtBPXsdE10WMVMBO4SCp/lxquoX9KBzuCPSgI20eN6OKOt7twl9H1Elt7mZ0?=
 =?us-ascii?Q?0vgSd9dIEsp3LIMkKBnTBRTUO1FPBufM4B+dpjbrX7H26aWPVWieoGcwhALw?=
 =?us-ascii?Q?hD1ofdOnZDyX4MuKJevHZbq9O/JCbpQuhONOKKOhJR7pCTsIclLEEWI6/MUu?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c339b5-ae0d-4914-842d-08dbfad2408f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 05:21:53.9116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frxdQ8U3O6wuUFrolYIJUM32ULeNxaoloFV3s1QfGntfDATzYO+lalo4NLHNOEZtbHC4+nhvwT38pBy41M+mRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4354

From: Joakim Zhang <joakim.zhang@cixtech.com>

Reproduced with below sequence:
dma_declare_coherent_memory()->dma_release_coherent_memory()
->dma_declare_coherent_memory()->"return -EBUSY" error

It will return -EBUSY from the dma_assign_coherent_memory()
in dma_declare_coherent_memory(), the reason is that dev->dma_mem
pointer has not been set to NULL after it's freed.

Go through the driver, found there is a issue in
rmem_dma_device_release(), the reserved memory has not been
freed before "dev->dma_mem =3D NULL;". So if user call
of_reserved_mem_device_release(), will not free reserved mem
in fact.

Fixes: cf65a0f6f6ff ("dma-mapping: move all DMA mapping code to kernel/dma"=
)
Signed-off-by: Joakim Zhang <joakim.zhang@cixtech.com>
---
 kernel/dma/coherent.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index c21abc77c53e..602e055fc1bf 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -132,8 +132,10 @@ int dma_declare_coherent_memory(struct device *dev, ph=
ys_addr_t phys_addr,

 void dma_release_coherent_memory(struct device *dev)
 {
-       if (dev)
+       if (dev) {
                _dma_release_coherent_memory(dev->dma_mem);
+               dev->dma_mem =3D NULL;
+       }
 }

 static void *__dma_alloc_from_coherent(struct device *dev,
@@ -349,8 +351,10 @@ static int rmem_dma_device_init(struct reserved_mem *r=
mem, struct device *dev)
 static void rmem_dma_device_release(struct reserved_mem *rmem,
                                    struct device *dev)
 {
-       if (dev)
+       if (dev) {
+               _dma_release_coherent_memory(rmem->priv);
                dev->dma_mem =3D NULL;
+       }
 }

 static const struct reserved_mem_ops rmem_dma_ops =3D {
--
2.25.1



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

Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906BDC433FE
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 15:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AB0D61201;
	Thu,  7 Apr 2022 15:24:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wh0EizHFNaxC; Thu,  7 Apr 2022 15:23:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 17ED661269;
	Thu,  7 Apr 2022 15:23:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45C02C0089;
	Thu,  7 Apr 2022 15:23:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 216C5C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 15:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 103AC60672
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 15:23:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ufxU1bz7BfPi for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 15:23:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::605])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 860EE61201
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 15:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIJ4EEz88PjAWX04s5/sTBJfM2M2c5e1X6Y0HeDGM0B6pI364ee+OmT+pcMaD3BqG2wVrUUFXu0puDnO5iYPlU4NJUSHJmetO4U4E9eLFp1cfnuW2dDh8eSUlVohp8/0e7vD2dItoi2OU/KlueTuQejEPN92Hy5E4T6HAiGLgCIS2x9fm2Pv8RP1qEt7xq18Mr++VAYTukdLRuOjBJd64flYKWC1znWdbu2jyZUEyzSLBHIC4ByMMRo5ZAQ7lrwC4FAzHv6emXPI9rhcElyQWpoNzOa7ohRnh4wqLrm6QQnVYQ15eK9HkLMJ0z6xegAq0XZQ1a3gss68YoGjAdBwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGS0YfgROEiFrfEW2D3h6jGezui7H3cOiH8aKT6+PO0=;
 b=WTS3a5DCfeawDBArjpnjLfj7CVaTKd2ymR4A/uDj/8djvkprDPeOcqExkhvKCVdbSCeDcT9p41XsCPZKv80uqipkJYWcxxLMViaWWZBvaDw2dIKxfMT9yrcyUVP6FrxomFl9bxfskzaK8HkoRmiPK0j0NiCIbrhldHpURJuP9MQDJUBKfZsLyx0pkLlevZAqYkehbMTp7z41q0BJTNvKuZ+h2I2k8NqwnD+JG4Vq+W9i11gk4rxrp2+PY/3T6ebaDd2Q9O5qWl1h17To6nTBv6AjGQkgXnIS0ZiNBlo/fDfwzseIp8A9+ObsQKxIir19DpBW33lUTBOKMcwij0CJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGS0YfgROEiFrfEW2D3h6jGezui7H3cOiH8aKT6+PO0=;
 b=cJsQeyvqI7hRFN8iPSz39mZSVSbQBEvo7p6tIwVMs6GtXqOfzJrERK5HKWj4qvY1Na9OfDNJOWCKZ/f4/y16993pcWa2L5ALCsBNnvIHgmrdLUFcsTm3PS0qV8SWp6E2lZbWGgQqQMPlPfApyUpPrciaygpszNfFf/w3t6uWlTTyOy/12QkR4Mlebf9sb5PFF62CzANsRJ3Xweg8xbi8xQyHblQqltLt15sxDRX7Nwq9/tLVSUdeEfbae1VSAfU8qgCLH188c9B/TipUXDH5UJyn2fFvSNAF58PtQlSk3Bi1lw25wPSseHjM8Gjh4cXboThwvIWzQo6scIwER81M3w==
Received: from MN2PR12MB3422.namprd12.prod.outlook.com (2603:10b6:208:ce::27)
 by BN8PR12MB3090.namprd12.prod.outlook.com (2603:10b6:408:67::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 15:23:51 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3422.namprd12.prod.outlook.com (2603:10b6:208:ce::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 15:23:50 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 15:23:50 +0000
To: Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Cornelia Huck <cohuck@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Subject: [PATCH v2 4/4] vfio: Require that devices support DMA cache coherence
Date: Thu,  7 Apr 2022 12:23:47 -0300
Message-Id: <4-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
In-Reply-To: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
References: 
X-ClientProxiedBy: CH0PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:610:cc::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eeeee02-0e75-4b4b-edba-08da18aa9db3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3422:EE_|BN8PR12MB3090:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB34221BCD965ED7B3F86EE103C2E69@MN2PR12MB3422.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o792b+nEs1O/uf6WFlLjb/kimCYNpjHW5FecSdsOdYfgOgo+67l3R3y1x0WpUdw/6n4xYk2fBH/FX51Y4YYoFU8hxxUSrWzjSVNgD+qVkMKtGUqisKAIOlVW9gKK9lesND0bvibScREAn489ZfNvSMOg3ZRxGtIDSqxWpfzNHMmpsHltExY57jCiy09yf2HoVPcFGrU2hBp+NsELKBrLM1AbNXTDhI9C5HyFarPQY5el18V4gkKjWkepRhEcm07deZUvdHdjQMVbFGsr7DD2pa3RHPfY2efZpKlJCFte/MWh2WTBzQU2NT83kuOH1CXwjngCI0UIsNjZcoMagHMY31+mPKxypm3t1GzyI+ZVGOCqGTmqSrF6CHR/O4N/OGhwH6V8tCsXRRcgtGxCeqwU5BRHvSWRyDfmXCn9E7ZUEecuCd2a8nuG/QKjeKh58hc97hKE30U0N+CPm2IcmaismcO07xJq+dyj5+NzZLyeAEYvyyAoef6+b5mItvTx7CGxzGRN8ijqPCeMdbsUWhwnpz4/3BUfTqzNgG9hsY9ghjTuxvGSnfKkGvoGrWj7BNWiacRmTj4CKIvioSV0S7odhmue6VZyERjBy9Qc1mo/PXF8yaaZ81IL/Drver2esznJAGIRERbldBH6kQSUXN25ssYctGXq5Pi67Tfi9z/ctBMrok2ONBXVlXU//3Pm2cT/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3422.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(186003)(2616005)(83380400001)(66556008)(5660300002)(8676002)(4326008)(2906002)(66476007)(8936002)(7416002)(66946007)(36756003)(86362001)(508600001)(6486002)(54906003)(6666004)(316002)(6512007)(110136005)(6506007)(38100700002)(4216001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4IPCGzYJUv8EO7ckAfoeDUTmZ0Nzmhn8riCZJimesH6qTlRsgCBmr51tc5tA?=
 =?us-ascii?Q?Ym8O8S3NwNGwUKWaLn1OQLULEdJllHi2ytyHyuPjSL7ThJ29lXNUZu3KYJ+g?=
 =?us-ascii?Q?Qy01yQ0wkgyHmsPMLTUzWtNNGmRxjvTu0vzR1DghaTUWxexz/6KLIFnT+erq?=
 =?us-ascii?Q?a23e8s1ls8O0pAA9YLgsE58sKcK+pcs4Qe+KDt+so5gdNwVwAqh+R7ctebyt?=
 =?us-ascii?Q?pOSYZAmi4XliEazdwNcMaUFkVyevitLn84YN5iFcYUTx0Ay7iYMKfHeEd1TR?=
 =?us-ascii?Q?LoqAF8BZhLSAueXWCtgOWKWIm5wcG/av5jvuI7jRPvDfZhmL5Zk2jdCtGI1n?=
 =?us-ascii?Q?d3izBale3v8W65Cx8lbf/d56USwvJIBLgvXunurL4LEcPGZeY8fGCh8dJHCq?=
 =?us-ascii?Q?2xmtmvV4Qh+FMpRtRkguuvY3CfKcdnTmuHSbadejxCfMgMt0TshIML1rHMvf?=
 =?us-ascii?Q?Zv3FMgPv1Rer/Z8UKhEqQMctQVSBu0XuwryN8/5XLVyjkJ+16VW71MGe2U4P?=
 =?us-ascii?Q?4PoTYllQv7EAH0sj4pHUpXjFODv8INMwihLJkIugm/UIRIK9VZMpNao/L0+E?=
 =?us-ascii?Q?ablSEvZVOJXcavf23z065oQqJrOvTLWzD8I8xfTMcXeYLIUrq3GE/IRXKpM5?=
 =?us-ascii?Q?n1FuSavezyhMd19zZahSgsQ144ZqhetpP0dYKmomlrFBeFFC2yDvqO5MmQ7+?=
 =?us-ascii?Q?mGxGm9FfIxCFG98XQINqSZkl/UHZ8h6ODBzvkdsDcamSpOuyDImoIfDUtzce?=
 =?us-ascii?Q?8VECtvaRCa09vw/O/6ixiJqYqNHmWTkNgTpu6l7/9LrwZUgMDwfT1A941Rg+?=
 =?us-ascii?Q?tzYsXhc0yTFkGQ1x3k5JIqKdyGXAUGCbkqIu/ISEBih4gotjVq2Sdiu7mz62?=
 =?us-ascii?Q?ker41c5vtp+ewmmhj7WoI6OVzX1QMY4mxH8Z4EQxx8QvUsr3j3GAXF8xOFWJ?=
 =?us-ascii?Q?bLmcs4sxCerGpKDbOpGJ/kzBGi7NyO8lFvl1H1wSE52Wmf4c6meMliTV7pRB?=
 =?us-ascii?Q?RJhVJKiFmtiymI+aH3j/HxoAi4dlACENsHuX3/+f1qppWkm9B15bxHSGLzYc?=
 =?us-ascii?Q?9wV7UD6bLuvsn5onVIXVSpUNzTMYqGmqXs5LSp2VJEMjoTPuglKv/hVqEnnY?=
 =?us-ascii?Q?Qp9JcLk57YysyjSsRPSo33/qMqcdDW7admpVOK1I6Jr4nRk5ee2FG+z4tGkV?=
 =?us-ascii?Q?zBketHObUbwIe/vFlVIDHR7cwlrhmUSDlAnXr7/48HTcGGZ+0DKPCz4w/yCR?=
 =?us-ascii?Q?thuyFeIm9hCI7seJumaVlQR4rT/9Ld9TV27U5oa0HjUGRbEep48POF/245Ro?=
 =?us-ascii?Q?aDTxYn8Tcjk6QgiyOJaBVOoT/2MxkklIedf5I/u1VZV8p0BlXfs0SHHXRxXz?=
 =?us-ascii?Q?ODW+vth1BXdupk9ICHag9iw6sVY2EfHYVdGgvzt5jpPZxFKZZoSvwmgkDkWO?=
 =?us-ascii?Q?9qDIFfhHsaBk8/5rSlpxSz5ZoGkLro+MCmNsEsMuQpR6MiRQI3FXotY5JZAS?=
 =?us-ascii?Q?9nge9oskYOX1kalU/DKtVJrjvUVvVN5RXd/L1vo95cxFqEYe0A3p1abRvOlS?=
 =?us-ascii?Q?THHSsTTe/lNAurGfQ+71P1BjyCq4x5/GmiPYjHaGJ6oElo1H11Eqo8KeTCM0?=
 =?us-ascii?Q?EHqiOUUoo4in1GLlzcMDmClARvmIuaeUdERQ7ksVfwwaOYuS9nAfbvm1t5Tc?=
 =?us-ascii?Q?uE26qN3xBBkHzp9JO/5xrW0Au0LHENDFW2iPyNxt2Y17Wld1hJBvkWPu6xMk?=
 =?us-ascii?Q?1iiYpen4Sw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eeeee02-0e75-4b4b-edba-08da18aa9db3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 15:23:49.6449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sxr0VdJx9i+GIfhhUnZouHrQHdxXgorBJsLSMZYKL0/vlhfw8QCfydhmw1FcOwm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3090
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

IOMMU_CACHE means that normal DMAs do not require any additional coherency
mechanism and is the basic uAPI that VFIO exposes to userspace. For
instance VFIO applications like DPDK will not work if additional coherency
operations are required.

Therefore check IOMMU_CAP_CACHE_COHERENCY like vdpa & usnic do before
allowing an IOMMU backed VFIO device to be created.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/vfio/vfio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index a4555014bd1e72..9edad767cfdad3 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -815,6 +815,13 @@ static int __vfio_register_dev(struct vfio_device *device,
 
 int vfio_register_group_dev(struct vfio_device *device)
 {
+	/*
+	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
+	 * restore cache coherency.
+	 */
+	if (!iommu_capable(device->dev->bus, IOMMU_CAP_CACHE_COHERENCY))
+		return -EINVAL;
+
 	return __vfio_register_dev(device,
 		vfio_group_find_or_alloc(device->dev));
 }
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

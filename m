Return-Path: <SRS0=x0pP=PB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48F5C433EF
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 12:31:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46963610C8
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 12:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46963610C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0763B407AB;
	Wed, 13 Oct 2021 12:31:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u8CgZgpZc1Cc; Wed, 13 Oct 2021 12:31:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E7BA7406E8;
	Wed, 13 Oct 2021 12:31:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA8EAC000F;
	Wed, 13 Oct 2021 12:31:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A96DEC000D
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 06:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A932407EB
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 06:35:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id knKhfXItYTSr for <iommu@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 06:35:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-hk2apc01on071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:febc::71d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6BB03407E9
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 06:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFGyQDYG2u41GIFQmU4r03J2xGPK9HxfYY/bean3SPWc6CDbhPtCXP9NyuzOMlKl+U1vOe4RtVfj66Z1zaXjNbT72TBi9pryaDltNc+rxs0gE1fjAry3M6pZIvlPtIguyuZdqwUaedKVah74SoHNL57fDOgnQP8mSESec0w99yt2tcHO/D79lLdT3KOAtn/PJ99sGJXr9gY8RfEuMtZc2KvU0QjbC3277B1bdsSxBMzzpHXuwmdTGVLqybY58JWP/pLZkasiVEkKxCUz4k5V713wEMaTprSSfNST4r7i5X01Ar3y1ZPReKGUHb2TmpJo8HcHawCa3peFBpf0fa3lkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8+YTsIiPZpZPPiQUYcAZdnvN18AiNThT10Dt0zzEPo=;
 b=ggwcXtRDC5Q5b4HGDQNql8i5GlBPUIACNAus98qCPhDrZwPOZ17jXwSaXk70nqZR3jz74qa3Fa4MZcvtnvmJCbbioBlWt+BpqMZ2eOawx4POtcMkRTqmbDRdfAoO2QRKQX7OTh6wJxAy5jF4tidIz1EkhK8MIgnCR+GnQ/1dpEjGO7UAE9bqzgluzDLr42NSCRQuvESrUbbGHikQ2rofxGC47lAx7ASKknh++DsfKfnlbcGsXIrQFUoHA75DEP7qLcn1KzHH/sEmn+lV0rNkQZmSS39dIrcFocYaj7ygh8ncqQ8twLeTu6NKm1zp7lJ7VWLBfJ+yxliMr+fnHwoI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com; 
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8+YTsIiPZpZPPiQUYcAZdnvN18AiNThT10Dt0zzEPo=;
 b=FGph6Apkna+kHCsebnLW6p4ck3CWV9aZsbRYpQmOgaxA2EleC9em0g54n98kL/8v5tMOPMZoWYt7/wtAKdKOxMdJ4W5bT3rJ8+CwjqFox53WJ5qz9lN0tRdCwz5KtU+4MCb7cbonR5L7azMelq1GG3WuTY4g5uUHvixK69Sx8X0=
Authentication-Results: svenpeter.dev; dkim=none (message not signed)
 header.d=none;svenpeter.dev; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3047.apcprd06.prod.outlook.com (2603:1096:4:77::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.22; Wed, 13 Oct 2021 06:35:47 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4608.015; Wed, 13 Oct 2021
 06:35:46 +0000
To: Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/dart: use kmemdup instead of kzalloc and memcpy
Date: Wed, 13 Oct 2021 02:34:41 -0400
Message-Id: <20211013063441.29888-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2PR04CA0090.apcprd04.prod.outlook.com
 (2603:1096:202:15::34) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (218.213.202.190) by
 HK2PR04CA0090.apcprd04.prod.outlook.com (2603:1096:202:15::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 06:35:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65a98f0c-e9a0-45fa-3f81-08d98e13afb3
X-MS-TrafficTypeDiagnostic: SG2PR06MB3047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR06MB3047710DFDD449730E5971C1ABB79@SG2PR06MB3047.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5qYgx4xI1ureiHZTgtQwcf4lQPVkHYP1jTBNSGDdEO7B1ar6SskUVBVwL2PmIc6j2qWBtkFSRpNY4VcCY+F7nKJnGBbEkrpi7Ng8cjmvf5bMOHgd+FuOlUYFYjnvY0svAA7h5q6w4NRP9/dhynWbRmL2ov1gQxYJyfS8f152ojcq9k8NG3ZJPEMiDNr9fqh2pQAFcB43DXU7qBo9qUhGb8ymcwMycLGydW/ovq/6Ku+qXLECyP+h/kuE2ChO1C/meW65wBtx/EtecTDjIWZIZ5JdSWB24Vtby6lpaX1fSCStSzA1vlxAAKXiyAglFIjrTVaib9s2i3jBPtrO9feT8xjBFEQNz+G/WhX6nAe+dO2MOrZ34AeoW6LdwsqubdFuDI7VIWtOxycVEJ+gRmODcf8OyHVzXzNKDYs5ox8zp8nx7DafWaZDNWdfjZV6XYrX6Qg7Ypf0VqiB4Thmh7+5ftXKPVQ/4mj0FoZu6oGv9Qc5IguyK9zAceC74t4sKrHrTvvlPG9x21puClacitOftbCZIFX8xm5cc4nad8pQhCgNA/RBuB33o4/hk3K+tJ97TJrIUMT4ELvzvLDfczLG2iewtXnk6xmGYoXNUn+LBY25/1OYU4BU9xCZnJ1L2I7hT9EGWDYaCmOuRTPYct8uNoq8h6s6N6KPwJmLU+yE8CqJqXAloIBQT8e55wd9mu7Nu55y9bjRAtLhRGVcLBvZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR06MB3367.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4744005)(508600001)(4326008)(110136005)(107886003)(38100700002)(66476007)(83380400001)(66946007)(2906002)(66556008)(2616005)(1076003)(956004)(38350700002)(52116002)(5660300002)(6486002)(36756003)(8676002)(6666004)(6506007)(26005)(8936002)(316002)(86362001)(186003)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OryUusFxuAWee4WwT/tC54SipZcjyQ8UQPa8MGkeek7xtRzZKMyvGtGLtvNt?=
 =?us-ascii?Q?eFSXOHCSl4aBgGDo0QWNYxoCPvr46BI+IgMMEK0SMm1+H6Mkbpb4UAZ2XPIl?=
 =?us-ascii?Q?GGsKXI1TJmkuQ6EHDcOBGGSZiaKVrsn80CsT/+3ZPjOZtUwp1VJTHLRlz1eB?=
 =?us-ascii?Q?CHjtqfJKSeNceRpOOTnUSqodPCswGxPB8iqpwvCb8Lh54A8yu8fF6HqxhTTN?=
 =?us-ascii?Q?lUQAU76N8M7kQXvWuVgvkoXbhlZQVRp+v3vyTk0ekH3OIRRaMqU8913x/NAf?=
 =?us-ascii?Q?Ne0YctfXs3jsne/BWlmOvZt5Eqmpd2lF9KcfAls9RqnOXDHquAltjzUnYMkM?=
 =?us-ascii?Q?osOgkcX0T7a3VymWALNdzjAaSyeOkZhyLjDLysqvD+Ihu+xZE+vB0+IFtzQR?=
 =?us-ascii?Q?g8/irlheWjRJ0U7WzKbwhijVZZ7H+4uKryXXyTREZX5QJHe6uaU1giQL6cQS?=
 =?us-ascii?Q?xzNjEB7rxo/f2S3H+3C8aGsQy4bFWYh5LYZOHrqW12KrACUVlfDfPh2HnbY5?=
 =?us-ascii?Q?K0pHwKVmfXiPQmNPD9l0COOsvTgybM+CChu+oUkXcCIQasQ6BHXdrABG7JbT?=
 =?us-ascii?Q?o5rA7Z8OWcaBZsFkgWfLQAgomvnw/rRqjHhhcvJkKDtCE9vSOuVOnWvQXpYB?=
 =?us-ascii?Q?w/aXRboosCml9mT/XPsQiZhAeFiXQ00RVFRfff3KcXh8oI+DmmvhG9mb0jS+?=
 =?us-ascii?Q?M6GfQ/XRLJ/pAriR4pHb0gI96aryr5LTF3nI5XyXoNiYdp9zBtErCZgDvloo?=
 =?us-ascii?Q?3iWOHS+K+R3EZoUnEu3odaWGhoruqpA5grbp4CEfhAU4eDlME4c7GOUDBQMn?=
 =?us-ascii?Q?cPpjPEJVeEFmiLQTzRKVfejIM7KMf0CDjWQSj9SpfL0Xkh/tor8E6QH0NtZd?=
 =?us-ascii?Q?iFZUPfNi2xnX/tjoAcFhYxmI+uKsnBjn4lb5ZEP5HC+8eXFmMc6NCBfBwAOh?=
 =?us-ascii?Q?O4c06OzHz39N2Vr1+HyTZ1eTmkiDcmuG3XqHlzB5/ogOesFO5+Sa1uTSh9Es?=
 =?us-ascii?Q?gRf3T6njS4jyIrOALQe9C8S8phNxf2b6mlTG56OXS+I+t729eyqRUmDEenmK?=
 =?us-ascii?Q?Cf6Nl11UxKvypdA0v1Vg2mxG4+TDvNPOva70vRNZSYY/7euM+EdFnw4n5CoZ?=
 =?us-ascii?Q?uLZd2tN/i8GdqInRpe2n6bewNOMTTcQLg8FQ6CQO5FaMiWzxGzm2Cx+66RYz?=
 =?us-ascii?Q?qt9CSi+WRbYvyUt5qb+P5OYp33r09KAb+LKL7XJm3EHAchudcRnP1bi/py9v?=
 =?us-ascii?Q?R8V1TfKuR181fI9jcwgGia/BoriXgRmXrCma0YhR5ZNHWHE5uJEaJma31VOn?=
 =?us-ascii?Q?WSxJH415x0LFrF44t3Sf4frW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a98f0c-e9a0-45fa-3f81-08d98e13afb3
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 06:35:45.7196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nADN7oVvR6ve+weI23ksglTfQzaRLdVvAWIqXfvmHTvlKdEJK/+RvUhcnxTKaIo7A904LLzOT1QGZwT6Nm0p9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3047
X-Mailman-Approved-At: Wed, 13 Oct 2021 12:31:16 +0000
Cc: kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
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
From: Wan Jiabing via iommu <iommu@lists.linux-foundation.org>
Reply-To: Wan Jiabing <wanjiabing@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Fix following coccicheck warning:
drivers/iommu/apple-dart.c:704:20-27: WARNING opportunity for kmemdup

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/iommu/apple-dart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 280ff8df728d..5eeb8d6b72e2 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -701,13 +701,12 @@ static struct iommu_group *apple_dart_device_group(struct device *dev)
 	if (!group)
 		goto out;
 
-	group_master_cfg = kzalloc(sizeof(*group_master_cfg), GFP_KERNEL);
+	group_master_cfg = kmemdup(cfg, sizeof(*group_master_cfg), GFP_KERNEL);
 	if (!group_master_cfg) {
 		iommu_group_put(group);
 		goto out;
 	}
 
-	memcpy(group_master_cfg, cfg, sizeof(*group_master_cfg));
 	iommu_group_set_iommudata(group, group_master_cfg,
 		apple_dart_release_group);
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B85AC433F5
	for <iommu@archiver.kernel.org>; Mon, 18 Apr 2022 15:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C295C6124C;
	Mon, 18 Apr 2022 15:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fUa3oOIKRMER; Mon, 18 Apr 2022 15:22:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B1AB060B47;
	Mon, 18 Apr 2022 15:22:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 837BFC002F;
	Mon, 18 Apr 2022 15:22:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA8AEC002C
 for <iommu@lists.linux-foundation.org>; Sun, 17 Apr 2022 02:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A0C1A405EF
 for <iommu@lists.linux-foundation.org>; Sun, 17 Apr 2022 02:49:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=hotmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nuO0694VIpR5 for <iommu@lists.linux-foundation.org>;
 Sun, 17 Apr 2022 02:49:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05olkn20819.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::819])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2AC1405E6
 for <iommu@lists.linux-foundation.org>; Sun, 17 Apr 2022 02:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/MZbwQEzasLiBJYsfAALVq1z+LRtpLoE9S/bImaxclFs/l7IjdyyYenomkwVUQlQQQyn3ZSXo8fTw7GaiRjhQchQtnaZs5yO08fd9I1cMDYAiIaLopiqt9wthCJT2xLenThTUxXeNdTOctic3cRb2adDOBsnHqPctXcaI23iNgcWyvIbz6XGmv/JDQT0xPz4phOo0dD477rbsO24K2VjquwLWKnuu2y8jqTxN6hLkcBdOjIm1/ZLJ2knTcnTM+W5tPNy4nEeS/6H4JLhnu8U06fqC+jEOYkUJWJyo58Q1SKrIS2fsA23Mod+DF+4Y1g525ttJbxZaWLoUBHp/+/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75VzsKQSsjTUwGKJt+kK8UuD8x1KhH6GBd+k7/LRkv8=;
 b=i+2uaHae01wNsmXtrRFKeU57akKxZExMCI/Yv8LGWc4JS+WFmXlwR7BnXWKjl2lKHrJGwljNtjVwvoXo1nNeVR9KPBY6ufWyy7uN3iTnaYpnETKClH75Vp7sKeeKlXImzIIW8wDW1yATRzP+0VUJ2JM6/wace2ZiaXCAaKWsOPVFiACp2lXdTonQmThDUDtJx2j8sNvxy2Ng37E4eqqkQrg3h0GFlmPq4uy1Y3h4CQcwN59uhDbC+4L+q4TtuwXAdvhqw7l/ajhqyiSTv+n6Cvw2z8adG/zhWvejMbOw5nrYP1l2u2svBgKqEI2zMW3cewJ67ULzQRyqGBKvPPErXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75VzsKQSsjTUwGKJt+kK8UuD8x1KhH6GBd+k7/LRkv8=;
 b=F1SR9q+jt0uUOfTk+8uDvjRF7rxl/vW4236xrKhbUOCaXxTy2yJkC/cbBMkiokf+w3wYSB/eOxWq/5NIU+81P2CD9skwQyGPym/EjEcX/Srh9SpiPPOqXDVtpTNuqw6jmAwpyvJvC5V5Mdi1fwfeeoVQyBLvaH0gxtMHmdK11APRhMTnSm+tB9YNu4KRYXWVAI51iqDyS9tn4EZdwtb95tXzR+CdZwQmW5aEkw8Qg8vdpUOrC7T/Aa8Ga70iInsYwenCzvOojoVHEGQlCnenOrFBnEq4X3a5fRZrUbyu1AL8a+2zEX0GWbyMrNTGrNCcD3EyiJE+EghKvjw5Dn6bdg==
Received: from PA4P189MB1421.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:c2::10)
 by DB6P18901MB0118.EURP189.PROD.OUTLOOK.COM (2603:10a6:4:1a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Sun, 17 Apr
 2022 02:49:03 +0000
Received: from PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 ([fe80::e5d3:7ad0:abe1:5292]) by PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 ([fe80::e5d3:7ad0:abe1:5292%7]) with mapi id 15.20.5164.025; Sun, 17 Apr 2022
 02:49:03 +0000
From: Saud Farooqui <farooqui_saud@hotmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org
Subject: [PATCH] iommufd: unlock ictx->vfio_compat before return.
Date: Sun, 17 Apr 2022 07:48:43 +0500
Message-ID: <PA4P189MB1421C0EB9620ACD70D87A1698BF09@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
X-TMN: [y7RZGiswIFR98qgzqgkayaTig7c88CWt]
X-ClientProxiedBy: DX2P273CA0017.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:8::29) To PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:c2::10)
X-Microsoft-Original-Message-ID: <20220417024843.634161-1-farooqui_saud@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03c8ac8c-c9f8-4a4e-925e-08da201cd4f3
X-MS-Exchange-SLBlob-MailProps: CjO2us0gQYBn3D7n2JOxivINDx1blzDaDLaE6fNfzaoLfF5PENMgURHaE1n3W2g5+p9uaLu7hdo5sV81IqjupHRBn8Kb87OYTmrw/kHXDVztLXMtJ1bB7mV/bFGUg4+VnHje/2in2APo5bDpWxtXyLTBOLJWvZO0AXhsB/kC36R80iuMP3WBMskLUTXaC3sHLsfDwfllTC4Q/UUQfRYi/C4f/Vk9WrdhqH0mz+rEvUjIY7dprBO5ED0Xob/Wqd03/7C8tVNlXf7HBRsVLxI4XEQrcMfjCLgYZ+G0IDo4Garu+vF+iu8BfZVa5eU0jVERhodbpOA9a0w0g281VD4xim5tdw1SksYWyOnX3PjRi0dF30VqNCY/cy/MWd92Wrlod2IiLBE15ap6NucwuafLYt/rKUme8WWGEO4tJcm1IykAUlc1E2hJIyVb1u5Ncr825PJB0JAjIflYOB/q633aZyxEJX+hrcUiNxF84v04pGUnflb+A7PaugCu4Oy79UEdyv15wC291aPtca1mEfZMvD0ntqwcMhC+tMo/iXomZDv6J+OXW2VcxzVTbgVrsz9OaSFpaN+TP6Wi8wdu/qdzUgIpUpdy4JGwx8sUAWHCz6oT/AVV8Bt/oNyQ1cNFZSe8emXKuQKMeNtCFFbmWuOOD9Ox8lgqMzKcMZhQyKGjFtzQ4CKN/+Bf3NWw5fsJr69E
X-MS-TrafficTypeDiagnostic: DB6P18901MB0118:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3rogoUdIUqiKK+x247kI2JK2WCTpwwdLLn1c3NWGu77kNoRlpyiisj4GsWfjBmp/3FMkNnu+NSsi9u0O4Mfeu7pNgca5LisOR6oEVUxbZ3wnUAltWj2vvc+ToXYMFHCxmaHvCny45J2CVo3AdCSXUPSFfWuX777NLHSgkE5rEM7l4HIPc0IIqf96YxucTm4IjkWx83j0OLmpIcIa/Tr3fJMDKRZu/CCGsRdTdWsDaDTBmRA/5gpsyyJkxF5oTcabsDR9jY1mygln5xKKCv31uUwOO6hdfjfClrYSBLRPZtACNdZ+3eMxoR0GEQ4eO0llrQihk73goP3SXSenML+yqlaFPeoiU7nFz25YMCmmTOBlvA3R8Ygnc1LC5DSv2swLomvP9FQuXTTbM2qkVCnGYTY3PNY1kQupkcYOFe8m3zWHJSmfa6GF4hQghqcxSwZNoWqeu0W4Lw5LCTyp/1FrazyV78xDqgMo53aNbADFI6kP7q9Pxt0r0bEfc9dKkwNbaQBvLxty/PqIj8K6DDqeswg2gA1SZn/WaY0FzX93oMMddKj7M2D6ub8Xta5oWARA0ng50q7V9Tfnaho9xeP5Ew==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ZdM3Z6a4XFJIb7N/8fVdB2fk2TXqXoq8tXMAjJ37bT2S/N5aIId26Vq7EOr?=
 =?us-ascii?Q?uL5CvkRiKxaeZlEJ4fj8slcOaTNx53nA9k2qAxP410y+mMIQ/ZEQ56Tljg1x?=
 =?us-ascii?Q?CpSasHquN9ubNRX58YgT1RJUe45jmR1ikuMBHYKP8uRnHIsE7qJujpoQOl/R?=
 =?us-ascii?Q?WaQhCuVST1kMELYj6JxhjtWbrTS2tZTVXcVAoxm6Y9JU3X98u/ynkeWz9jwF?=
 =?us-ascii?Q?w6x3BS0B86y5FE5plZW6Ap65537mrH9IQzvW3JKqtNb7XsxFx9ySLCM2hLcY?=
 =?us-ascii?Q?vLFmqFDZ//aK6wYDgQMVB7+6VlnOx7AmaTmL2Cob3Z30j9U1w5IjVr0R2Evb?=
 =?us-ascii?Q?Jg9Tmeor3b5bqKIFrwJY4nZPSUAk7aAZdMyl/kSRU/oOTgr+D4qgUwWmqUng?=
 =?us-ascii?Q?3iaqQUWHIjIe5OnyYn+WPEAlMelXPn1QYdtkKtBt43mXP03yH9mVuGHoKOv0?=
 =?us-ascii?Q?QcavHwqYmRS7K4g+QHCGQO7mjXQqvsNwEzW5euRmaJXHPyYD7i3vxPeSaSK4?=
 =?us-ascii?Q?U8Bgj+BmaD2nIezFaWoXVyOXaycxCEt/rpzi06YlMzxcBulgElJwsxg1q38d?=
 =?us-ascii?Q?dIrugW3HveE+MIFZIz/jTh3Qd5ngh20izvLPC+QfhkDe1oLy5qeowccwB/mW?=
 =?us-ascii?Q?0DRzTCzqGcS9ADgu/YaHOS9CVB4OZ/8Ff60g8kq29MChx6nFbqBLB30NSJ1X?=
 =?us-ascii?Q?jMwp+r1eSgQecX8nJZy75S9/Uia06TBclz7rB4qu1rjTTaFe6wX8N7Pmla2E?=
 =?us-ascii?Q?B6weMFagrSYjK1mzAy/sVP/6eXk+GFbvICd74AN3zB8k6k4oqw6XxZYMn6jI?=
 =?us-ascii?Q?IaivvbeV554WCR3qLUVZcf7d+GlMpIYtCfy0QzkiIJQzirumTGWODsb54ZWR?=
 =?us-ascii?Q?Vj2ujGpqXf1eBHhjNiYKCEUKIcniVqXMPdLmVgl5wgp/+KfkJtzi/bWePMbi?=
 =?us-ascii?Q?MwMbBCxk3hGFERfTUe560/hkgm+PgXqAZziDF3xotdEbZjZPd8/oOyxv//ZO?=
 =?us-ascii?Q?ybWkvs5fNXfNNraGYRb1rlkTyo4soHMS7dU4e2gxp6dVYLL3PKahc/rdChL/?=
 =?us-ascii?Q?lpkbVxOX7yUPpsfN0vXZeY4OzqIyWdkQ9zvig8jaE5RcoiQKs59vPQwMawyU?=
 =?us-ascii?Q?/NueCFTwpdYfJYRuwsuVFAanv5hl6zjqOMfUzV6AP5cMRt8VW8fWhcdGw+p7?=
 =?us-ascii?Q?np+D/g0r+kE13ygmk+FKG7Ll1Ao3fw4HylkuapGygenkgxIWBQf4BZjVTcsr?=
 =?us-ascii?Q?+kQMJMZFt9lKh7OIQZ8fW5eChv4J9VIbnL3psQW7JbgiWRHWpTBwaXaeMEoD?=
 =?us-ascii?Q?nU5odQbUEXBIt7nuuqrKVAKyfVggcDQu4h6Y48keZrinMRHjKpJ7WBGg09i1?=
 =?us-ascii?Q?FVEz3YWq4e6qylU5XD8A2bjqt3Gp1fqdr+BcwXW+JwNB4dsenFKRLzWTKFUp?=
 =?us-ascii?Q?Q+qKOLdOXYNQn0eN2P0eL9rcEQdtFlxB?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c8ac8c-c9f8-4a4e-925e-08da201cd4f3
X-MS-Exchange-CrossTenant-AuthSource: PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2022 02:49:03.3064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6P18901MB0118
X-Mailman-Approved-At: Mon, 18 Apr 2022 15:22:10 +0000
Cc: Saud Farooqui <farooqui_saud@hotmail.com>,
 Julia Lawall <julia.lawall@lip6.fr>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
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

cocci warning: drivers/iommu/iommufd/vfio_compat.c:494:2-8: preceding
lock on line 491

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Saud Farooqui <farooqui_saud@hotmail.com>
---
 drivers/iommu/iommufd/vfio_compat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/vfio_compat.c b/drivers/iommu/iommufd/vfio_compat.c
index 5b196de00ff9..d9347df48cc8 100644
--- a/drivers/iommu/iommufd/vfio_compat.c
+++ b/drivers/iommu/iommufd/vfio_compat.c
@@ -491,8 +491,10 @@ void vfio_group_unset_iommufd(void *iommufd, struct list_head *device_list)
 		return;
 	mutex_lock(&ictx->vfio_compat);
 	ioas = get_compat_ioas(ictx);
-	if (IS_ERR(ioas))
+	if (IS_ERR(ioas)) {
+		mutex_unlock(&ictx->vfio_compat);
 		return;
+	}
 
 	ioas_id = ioas->obj.id;
 	iommufd_put_object(&ioas->obj);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

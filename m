Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C4619D89E
	for <iommu@lists.linux.dev>; Wed, 18 Feb 2026 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771373536; cv=fail; b=bADogXV6TWm0qkcWHVupww03w9Ji0ylTCUL2ipF9yDW8TorJnq/V5yUseNqgrYgHDwfbWtxaPKpbl0ZpRGRC+igD/9LM5DOAgbcpaG1LkMIebx+lMa50XByDdmI4wT8LJ+DikhrjmSLleqvdQInBTP5LkOSxSkPKC82Xpi6L/c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771373536; c=relaxed/simple;
	bh=/gxE6CvWQjCIRccKfNHBulm63z0bJsrdlbDXYGYek8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gmuk9v3pVB5QzOWsktBmT9KtK4F4SXAsvhSVBxCbwSmox5nOh06IufJct9n2uNUzVS/rqQvRoazRp9aAv5T3D8mqsDIozP774rrQzRpnV2vbH5e6z9mCOjE3mBYWGDNn6pc6nMJG1xZmi8jrZTpmNlSnxUdc644CHs/b79qBJvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZMK+uJhW; arc=fail smtp.client-ip=40.93.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZMK+uJhW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sd2v7cg8hpPfFzU2SSRp07dXonI3atlN4N6M71dlKIw2fPcHRntAGtWbJxZ0zi6baWzSjAqAncULSnqbNj2/ZpDrH0y2IfiKgLYhqpTGMqrtObYHvIZ/yhzA3SjoKDCvrXTNYos5txkKogQxdELBalLu4SOfpwFiKkXy5NNbLho96cPCNUG94VCxu8Qfnc2+F9BoanuxBolKZhqXL/Dzo/IpQxg//km13ZNv69jRQNDyjYz2Ustp3t9Vr95PoRwOOHlKpbg5XsVw8leRl2pSHWZElSdB970dTM55IMl5G4t7/dagmo9ueCN+5cgsJ0+4P3v1m4gQYXKAtu88XwmCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHmmsMUw73S5mNQ3+q+ihBdAb2txAfEj+YPd8V80fsw=;
 b=LeWT7skUC6J7Se/1RdEF2RH4QvO8UMXaH5aivo9a2F6phiRZzsqGGB62vFMUoYSmWTz0vFDvsJzTbQle2BBV0YwgDNbn/YReX/nh04U0fkgmqmNQUZAmQDbBxIAqhnKvor2Bfx7BCz+RoWbWMNGVLYxkyEF8wDwKrAsDA2V2KvYpwN2JrwwYa9THOi3HDzlpQFzFPfQqqCVB4dkMt+UmuJsj5nP4QwdK7rxxlsegnI0obpD/hxYQmBrBFrqRvILsdkWD5+C/Xewwy8KDvR8eFYl6yvssul52WDDRVheKvRc67tJZVGvgjRBen6dlWhKlh4DxgGwdGN3p47aYTuKcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHmmsMUw73S5mNQ3+q+ihBdAb2txAfEj+YPd8V80fsw=;
 b=ZMK+uJhWAOr+VgTDLEkY8SJg3bgjCPIHUKJGXLmfNzpTksWnAHsaVTg8BhMiQDFEP0dilanCVpMxf1ALOHeek0zN084DqSCmm8O1q63OXl0SEWd0VsyGAxDZACmVMX/r57xySzgx1UYzqfVHXRbQS0DhpOKhyfUSZH5xwKfjugrEXK8UIBn+CEW9RynVCSKUuPWZPc7+XUKfgLHv9jM38hzLEDk8KwB2YvdeWqI3uRZS7O1EIp7o98XYH+4lF8kWdYSp9UeVybBEpmKGpUTYvYqJmhxPmnSipQzoc50i6DH4ijxNTap8g1Szm50x+uR9gnTyHx6EendVbCGCvz7XpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Wed, 18 Feb
 2026 00:12:03 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Wed, 18 Feb 2026
 00:12:03 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Christian Koenig <christian.koenig@amd.com>,
	Dongwon Kim <dongwon.kim@intel.com>,
	dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linaro-mm-sig@lists.linaro.org,
	linux-media@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH RFC 10/26] drm/xe/dma-buf: Use the SGT mapping type
Date: Tue, 17 Feb 2026 20:11:41 -0400
Message-ID: <10-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
In-Reply-To: <0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be15267-d5dc-4528-6fbc-08de6e825607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OnIAZMEnGAZVDUJ4fkRL1m/Axj69AYkfhIj4rJZCNJyQpN75VvvTXzcI8TIP?=
 =?us-ascii?Q?kGFzcvGX9gO6OS//P9ZpBVsKXjjSmP7n5f4o07c089eDyyVJjJFfnzDlEYl/?=
 =?us-ascii?Q?epVrToAIur9KqrlHeJO8ZngeMSRbSEI1nTi4izcFnp29P9Ulm5twJ9WJd7br?=
 =?us-ascii?Q?nveE8twlW+jzZCzHdqXvH5+ym2IgSJNgXPHsIcLdzorrn2uKjyJ2ZmwNP1R8?=
 =?us-ascii?Q?YxA0ets8oZvCJK7rF95TxXF0OGVlPYDZtRtRUB/EpsyZuKDSnGBw9yUka7CJ?=
 =?us-ascii?Q?X6XUJwmp1RtbcGL7XcynA/K0c2mz//2sF4z7mf6WCuCQRH6vSYzCsOI/OVWJ?=
 =?us-ascii?Q?ewpyglJRzKB1iue6UvybJagNEmD5RFKHlxcbGzYXw71y5fZwQn46jidq6BnW?=
 =?us-ascii?Q?sA5aOMGibldkxHBgOp6sBguf0Ly5BYOlyknDWnZIw409dNbzL9YXTItxMm2E?=
 =?us-ascii?Q?MjjIHfFc/i+lf0R1MsRoQv1bMRR47vDS7wg4SjeB60w+CNeAkOFL0rNu56ks?=
 =?us-ascii?Q?NxfuPBBs97GT0/7kv86FcPN8kUCaylmyGlbULve/xYTGvNw/1Ydd/gXmQbz0?=
 =?us-ascii?Q?L31yH8GjrAI5rTRaRxb/oeKw7DyAwkWsRgn89hGjEtbh0qEl+xcn2a6hBmOX?=
 =?us-ascii?Q?xmdGhLe8kRORoFncxiXB2fkLKp9FKd0weLF08UNvSqWYiQHFJEHIx2yUx7au?=
 =?us-ascii?Q?sxncf/+FF/orkp8+ECBU38eFEfOU0x/7NSAzW68u0LN9+7WY0uoPp2NfzE9p?=
 =?us-ascii?Q?Yw89BtEUocL9hR1YlIVrhB95nrhqFrZTSUo2kNeW+Xl1ZrIL20seXjrC7ZHY?=
 =?us-ascii?Q?pO9WtOiNjBZmWHwEIw14QAso/s8Eft0u6qSLKc0Zq84Xe1TxL7G11SP2bKli?=
 =?us-ascii?Q?P3bDWfr9T1kzU5mEtcrxaiP2m7eP/JE9E5wXq+PRSFIn051KW2eFEL9CGQ/6?=
 =?us-ascii?Q?wxNQnPx/1xX2eb/4iCKR9oeu5V7uBncIVvlZJTQUlIkJx7PVS+SwKaudIp0x?=
 =?us-ascii?Q?PeGjmoiRSMPY4Rq0VJXg2lF0077fL+17t1kYB7Dq1Jd1kz0NwvJoFHWttAWs?=
 =?us-ascii?Q?TUfybMHXuIz0+ovF1FswJ7OK9I1WYz1AHLSU4gK/zvEuIHRhm35pdBtLc/8+?=
 =?us-ascii?Q?3AcjUtHZz4g/LTJ4ZQdndah3nQSQZFH79HmwKC+ARLJ4dVvQRSPf7KGt/vd4?=
 =?us-ascii?Q?OAjhzynYUD/fHS8Hg1sHjO9uviEanmwxJhkg+yggnC9Syed0iolKin5XKxYj?=
 =?us-ascii?Q?Ak79YGk3n6FZPGrbTxOm2U9EsoQmKyEmWIn6PpvIvR2IDiWK0CAt3UhLhkQK?=
 =?us-ascii?Q?0p6UVnkgkpcs3qsZsL65WHwfyvjG+Nm/fZB/tkF/wdPsJb+96kWx/7aiZYRT?=
 =?us-ascii?Q?1OGTPsTtqNmBoJ5aU7YnuKlIoumreXmUbuv9GVZYwEwrnE+rfYjuH+ltbOLV?=
 =?us-ascii?Q?mfhlzDAIiXDSkLZY936r4KfhSN9IgA22a5VKHq3oj9YLNQFQXGw1wuHVfOiI?=
 =?us-ascii?Q?1HilGECDGbyXwQ9O8RFdzn9guYrWE18aMYzV7WFHH0PNp+90PvXtq4u8tnq9?=
 =?us-ascii?Q?SbYg+VH8xUC0v5Jm3HI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z2mGpyfEm68NDTHXK4tjd2leVWVZrfx81icen01YMokM7uaMCQM0DMszIu2n?=
 =?us-ascii?Q?ItUAvfFwfT95285/4eQKw72RSPM+iL+y9ZDZK09N7UD5C7I/IhHd4OHRadUm?=
 =?us-ascii?Q?a4sX69whFrsXBPoMGLu1MaebP7mJh5y8vJ/gAn8gt8t85yADxxciGtboik+I?=
 =?us-ascii?Q?2aCa+KJZqnUQ4Tk+Q+GZNmbgSOz5DnTLXJbHXhNLStsLH+LJoPsc2Hbwl0bW?=
 =?us-ascii?Q?RITKx7SHEkckuFD7ajSza5t1A/HQwvFvPXE7IIVgNrPYrv1MaeCR64kup+b5?=
 =?us-ascii?Q?Og5DuE7Etu30RjAlGNTLER6qhk8jFZf3DhQ3HXYjBi5EhUmzYYE4DPG5tEZm?=
 =?us-ascii?Q?GcOgHvf57rj/6vTSqYbQjDFhmkSiKmoaY+Ep5v+VgFYsVhishW4U1fX9X4CL?=
 =?us-ascii?Q?wFNFDpMA04UiEEz808HQvgl/hh2MDbOXABUfgslZMcNPw7JHnai7n+aFBO/D?=
 =?us-ascii?Q?DWU7jRro53VQoSgR4wiTKWzqEm/R+ICoM74H6mRg31G+B3Gj+w6GVmGnh2c5?=
 =?us-ascii?Q?UkXGhR6SepXQ3hxNg7/VFc+e4JI2CJ0toQJezp/oWUjs4jGYlCBy11SkhR4F?=
 =?us-ascii?Q?nADORvQYH8/uFIcOnhgO/PGd9elYjj3Ve7FB0TqQKD1MJnxNPjVW1sOsEmZ0?=
 =?us-ascii?Q?QqzDH1AKZ+mHNKMzogg53fruqG0Y50vlu8VkAz2YqtD2+bAmMNjMH70kBm67?=
 =?us-ascii?Q?KL6PqTPAlgwwIdYWO1gh/Iaa4dJ3IGcFs5WoNuHELS0YP2iex8JbOYPCmztm?=
 =?us-ascii?Q?EiLEqKVadUzul5DWWVVqHpvTJ3tU+a9FjTeg4kQfru2TZg542ha2hF6I8mgQ?=
 =?us-ascii?Q?5J5AnzIfPyEZvIEkXcZ8Z6Lx6CVBRC8h0kdFJe0MK3SIR3i+PFQmuEEa/xLB?=
 =?us-ascii?Q?ua29HScEdhaouyox0C2Ehqbach0jxScTNH4nZFKn07Ke31/IsUNc3vndSQzB?=
 =?us-ascii?Q?tkxwpIOVtXBHBv25B1cLJOljN4aFl3JpzAB0JAKBspOTWil6R/GXany5vjIe?=
 =?us-ascii?Q?ftU/oxSrWqVQA4g675cX6xWCOtthlzVegC51aFWymMLj8TPWXcQ17CZ4wLos?=
 =?us-ascii?Q?tzNHo5nGskquZ/6q4I5iAqboc3Rl5j4G4vGSi6Uf/yMdnWVQP8lx4rSEFJj6?=
 =?us-ascii?Q?srBNMplhulnIdNETnRGFo7hhcrmRnzlWfXDIZCoGnmMs1vsmQ4fSLV0O5Xa9?=
 =?us-ascii?Q?uBM/0VCBMy3rkR5no8RoMMp5fa/F+1kJbbdY74K3aLOSdKjBmnjowaUf2CEh?=
 =?us-ascii?Q?ImvpQjeihc2UJvUJPtH8UGiGN/IMML8BxYoz/Ie1Oku3NkjdhWDw+/dz6Tjp?=
 =?us-ascii?Q?/MOL3P8AYHko1ABJv34o/TfSiYYIL3RucKdb2v6eoDmK1mD6KdA5DUIBDJ/o?=
 =?us-ascii?Q?nnkAkScGMGp3hWanHBwiW//tb6G2qEXjXRA7vNeoxum8/DauC/2Ft+t018p+?=
 =?us-ascii?Q?tSQXtkuQhWX3Q+RsYxBovI+sZf3XdgD98VwPWSRtcs7Q0goYwNU1WiU7nMl4?=
 =?us-ascii?Q?c7dvG4/CbMyz/MuREQPC9h7iSkdVIEfV6e+/C3cQJgkoi8EptefzKm53saj9?=
 =?us-ascii?Q?j3Oh4IvqnSwC6eIKI1UhNzffV9GdLQ3FtCsEwc4tOMGWteWRpuiyS9XJYUNT?=
 =?us-ascii?Q?xnWX4abB2YpnRacWe5RUrQKoxF+8NvgDFveSFhirCe3xyw+a6RT8K7kZrd8a?=
 =?us-ascii?Q?oZkhI2yRGQPRAdE0DfTYdurAYHDMLzIltB/bojU3bjISnaVeC+czZbdhH4xb?=
 =?us-ascii?Q?PRQvdiTuJg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be15267-d5dc-4528-6fbc-08de6e825607
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 00:12:00.3305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Q7V77krw5LePS3UjQ7b4fc8w482SF7nK3mikrwtIhgG7F9tvPSdCFH9MfcRng8M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421

Like habana, xe wants to check pci_p2pdma_distance(), but unlike
habana, it can migrate to system memory and support non-p2p DMAs as well.

Add two exporter SGT mapping types, one that matches P2P and one that
matches all of the non-p2p. The pin and map code will force migrate if
the non-p2p one is matched.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/gpu/drm/xe/xe_dma_buf.c | 58 +++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 7c74a31d448602..9968f37657d57d 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -7,7 +7,7 @@
 
 #include <kunit/test.h>
 #include <linux/dma-buf.h>
-#include <linux/pci-p2pdma.h>
+#include <linux/dma-buf-mapping.h>
 
 #include <drm/drm_device.h>
 #include <drm/drm_prime.h>
@@ -27,13 +27,6 @@ static int xe_dma_buf_attach(struct dma_buf *dmabuf,
 {
 	struct drm_gem_object *obj = attach->dmabuf->priv;
 
-	if (attach->peer2peer &&
-	    pci_p2pdma_distance(to_pci_dev(obj->dev->dev), attach->dev, false) < 0)
-		attach->peer2peer = false;
-
-	if (!attach->peer2peer && !xe_bo_can_migrate(gem_to_xe_bo(obj), XE_PL_TT))
-		return -EOPNOTSUPP;
-
 	xe_pm_runtime_get(to_xe_device(obj->dev));
 	return 0;
 }
@@ -53,14 +46,12 @@ static int xe_dma_buf_pin(struct dma_buf_attachment *attach)
 	struct xe_bo *bo = gem_to_xe_bo(obj);
 	struct xe_device *xe = xe_bo_device(bo);
 	struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
-	bool allow_vram = true;
+	bool allow_vram = dma_buf_sgt_p2p_allowed(attach);
 	int ret;
 
-	if (!IS_ENABLED(CONFIG_DMABUF_MOVE_NOTIFY)) {
-		allow_vram = false;
-	} else {
+	if (allow_vram) {
 		list_for_each_entry(attach, &dmabuf->attachments, node) {
-			if (!attach->peer2peer) {
+			if (!dma_buf_sgt_p2p_allowed(attach)) {
 				allow_vram = false;
 				break;
 			}
@@ -101,6 +92,8 @@ static void xe_dma_buf_unpin(struct dma_buf_attachment *attach)
 static struct sg_table *xe_dma_buf_map(struct dma_buf_attachment *attach,
 				       enum dma_data_direction dir)
 {
+	struct device *dma_dev = dma_buf_sgt_dma_device(attach);
+	bool peer2peer = dma_buf_sgt_p2p_allowed(attach);
 	struct dma_buf *dma_buf = attach->dmabuf;
 	struct drm_gem_object *obj = dma_buf->priv;
 	struct xe_bo *bo = gem_to_xe_bo(obj);
@@ -108,11 +101,11 @@ static struct sg_table *xe_dma_buf_map(struct dma_buf_attachment *attach,
 	struct sg_table *sgt;
 	int r = 0;
 
-	if (!attach->peer2peer && !xe_bo_can_migrate(bo, XE_PL_TT))
+	if (!peer2peer && !xe_bo_can_migrate(bo, XE_PL_TT))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	if (!xe_bo_is_pinned(bo)) {
-		if (!attach->peer2peer)
+		if (!peer2peer)
 			r = xe_bo_migrate(bo, XE_PL_TT, NULL, exec);
 		else
 			r = xe_bo_validate(bo, NULL, false, exec);
@@ -128,7 +121,7 @@ static struct sg_table *xe_dma_buf_map(struct dma_buf_attachment *attach,
 		if (IS_ERR(sgt))
 			return sgt;
 
-		if (dma_map_sgtable(attach->dev, sgt, dir,
+		if (dma_map_sgtable(dma_dev, sgt, dir,
 				    DMA_ATTR_SKIP_CPU_SYNC))
 			goto error_free;
 		break;
@@ -137,7 +130,7 @@ static struct sg_table *xe_dma_buf_map(struct dma_buf_attachment *attach,
 	case XE_PL_VRAM1:
 		r = xe_ttm_vram_mgr_alloc_sgt(xe_bo_device(bo),
 					      bo->ttm.resource, 0,
-					      bo->ttm.base.size, attach->dev,
+					      bo->ttm.base.size, dma_dev,
 					      dir, &sgt);
 		if (r)
 			return ERR_PTR(r);
@@ -158,12 +151,14 @@ static void xe_dma_buf_unmap(struct dma_buf_attachment *attach,
 			     struct sg_table *sgt,
 			     enum dma_data_direction dir)
 {
+	struct device *dma_dev = dma_buf_sgt_dma_device(attach);
+
 	if (sg_page(sgt->sgl)) {
-		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
+		dma_unmap_sgtable(dma_dev, sgt, dir, 0);
 		sg_free_table(sgt);
 		kfree(sgt);
 	} else {
-		xe_ttm_vram_mgr_free_sgt(attach->dev, dir, sgt);
+		xe_ttm_vram_mgr_free_sgt(dma_dev, dir, sgt);
 	}
 }
 
@@ -197,18 +192,39 @@ static int xe_dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
 	return 0;
 }
 
+static const struct dma_buf_mapping_sgt_exp_ops xe_dma_buf_sgt_ops = {
+	.map_dma_buf = xe_dma_buf_map,
+	.unmap_dma_buf = xe_dma_buf_unmap,
+};
+
+static int xe_dma_buf_match_mapping(struct dma_buf_match_args *args)
+{
+	struct drm_gem_object *obj = args->dmabuf->priv;
+	struct dma_buf_mapping_match sgt_match[2];
+	unsigned int num_match = 0;
+
+	if (IS_ENABLED(CONFIG_DMABUF_MOVE_NOTIFY))
+		sgt_match[num_match++] = DMA_BUF_EMAPPING_SGT_P2P(
+			&xe_dma_buf_sgt_ops, to_pci_dev(obj->dev->dev));
+
+	if (xe_bo_can_migrate(gem_to_xe_bo(obj), XE_PL_TT))
+		sgt_match[num_match++] =
+			DMA_BUF_EMAPPING_SGT(&xe_dma_buf_sgt_ops);
+
+	return dma_buf_match_mapping(args, sgt_match, ARRAY_SIZE(sgt_match));
+}
+
 static const struct dma_buf_ops xe_dmabuf_ops = {
 	.attach = xe_dma_buf_attach,
 	.detach = xe_dma_buf_detach,
 	.pin = xe_dma_buf_pin,
 	.unpin = xe_dma_buf_unpin,
-	.map_dma_buf = xe_dma_buf_map,
-	.unmap_dma_buf = xe_dma_buf_unmap,
 	.release = drm_gem_dmabuf_release,
 	.begin_cpu_access = xe_dma_buf_begin_cpu_access,
 	.mmap = drm_gem_dmabuf_mmap,
 	.vmap = drm_gem_dmabuf_vmap,
 	.vunmap = drm_gem_dmabuf_vunmap,
+	.match_mapping = xe_dma_buf_match_mapping,
 };
 
 struct dma_buf *xe_gem_prime_export(struct drm_gem_object *obj, int flags)
-- 
2.43.0


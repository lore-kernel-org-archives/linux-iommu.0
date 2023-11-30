Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2317C5;
	Thu, 30 Nov 2023 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a7l8Pg43"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2VKOj5Uufr7Yt2nQxaIEPnJiW73ivLHDdlPk32j+5vE+fJcHNufxXoL1E+ZTfHT99tjhQpc32WaxNJ9VWlJvrd3ABGedBKLjEPMiPQGsu40+BoN0D/Z2AExlxnh9Ko6O6RNCFmk8q+Zv14ecB3fHmBsUFk7L1H+gKiUhSW7p+xi6iT2jJv4DdH2fR98ef/q0+wlL0jWxEbufhDrkKqcIeiCJEzR4+7B6q0Xg1y+k9KFHdKe8EK0o6X1Zv0ehQVm4Ik4IBHmmPpOXmYx3eWQ2dWc5vqH1IknTbL3cc8s6RA9DrsorxMxBxG60JMqoQL/SqMCwbcnkTE9xvmoMW6ZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7aJKu7BohUpFcYIdwpDeid+Mzh23OW02rRcztcHd+0=;
 b=VzYzzyuqSazN17hWlFExGqETON7tJHHqLdTIhNCj/Qrm6hJ1awydNBTsbA1rteB3Ootz7M/f4/NTKcRiHiEVx4OFTuVHvVkK+Dg5mwB/UTmGf9QzM3yjUaHRvOaEe2kvFmCntHCzgz1f7WSoHbXOWjE4JgNiPGQSO3IOj6VNuMMRMBVDMqgi6BzPBaMZDf1iKcjykjEC/hceefMDLXgaEeJJQrueo4Q/9YusbpEx3YgwoqRmm5n7xwZ2z8sgF0abjIhitdNuwOx3x/5cgHw3xS02W2bXonHLEmA87hbKaIEMUREdy7hFS31XhxSSUVpLdk3552Na3/2E/dlvxKA64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7aJKu7BohUpFcYIdwpDeid+Mzh23OW02rRcztcHd+0=;
 b=a7l8Pg43X8mF6eKLHPSJjkvd9Yv2uBLumbZDeXlXhXizlhTprNiybvz5ofvJeSCgybXLhTNVe9/NXemO+IN4C1jKpCiRx78S7qHnT3olXd6aSyV1oQpUwFT3AY0gMui/8aOIuB6/nU8iciRtATzLB6coJ/lm1Ftsex6LyT99dx1+ZUANDyg24xH3bZj0U7rdD7hthybEgg/bQ7pAm7P2Ve8IFqSr0a1balb4qJGLhS7DrNaeh4Kfa9t4MK2faqmBxkibRJNWWz9ya9JfZnHEOcrxniJzUCuXSi4dvMc5pKpTszYhcCm3pkw1ovcQactVA5bZI/j9Nwqm1bhYb1ZTCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:14:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:33 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 24/30] iommu/virtio: Move to iommu_fw_alloc_per_device_ids()
Date: Wed, 29 Nov 2023 21:14:24 -0400
Message-ID: <24-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:805:ca::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2474fc-b243-4d46-1457-08dbf141b54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ghNA7r0Is2FNe3x7U25mt+SFcwhcUQhmUXJ65u6WFdzEbwyygn9cXW9Xx+gp55CIrzSU3CF8bAVMl/hDXbmY8XMKMt08QJ+Czcj5PCTYoWHt5NCH+iPcrl28nlFJGB8zOLhvVhF/7rURNuLhjRXJKK0A52juQ+Ty4ohQaQcs2lO7p0UvfOs0lMRL8WpHXXhLfaN5qarFIDJdoVauG8/WBm9INkoqBGuwxtTuvdiZyPV3rpNtlRns5vCyX/IyxTfEUmPfmAiJUSwibQIGkO4ERxkfzTWsH61B1NSyRFioWt7U14QfqOMwRRBlmoQxKDwVIYRdBlG4z1SjQT93P0UXdRNEJsb2wHBlt8jh2kQIdu8jd6BzxdB5Cg2jSliIglHzXzTye4fpTrx/UW35b4HymNPl6fpDzMm428gOWPmGpZCr7r7U9LBAtOm0iLbZmJXPTOti/pqm09ZHIEnN7wj5VvoU3NcZqddyHFJDcbkNJBqHXAeb+glEgwDC14vJFtOdL0tFCZPMFRwy7FBCHNfRS2f/ULDFlWR8bnnezOudXBBc905A70N5A4tdBdxQ1ybycaWrbUdJdVdlVRPZV25peOfJ14eEGTVyOKKNOaJon70=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(109986022)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2616005)(26005)(66476007)(66946007)(54906003)(66556008)(2906002)(8676002)(4326008)(8936002)(86362001)(5660300002)(41300700001)(6506007)(6666004)(6512007)(36756003)(316002)(478600001)(6486002)(38100700002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T6Vf3jt9cX8D+hAPP4fZPw3v2bZGbTDXvLZ69vgJKOMg3yIB72Epg3weEZ2x?=
 =?us-ascii?Q?lh1F74Vd9LtUDkJ23egwGeTCPDzXmcqtY4HIxbznXKLdusSO24czTrsYLvCR?=
 =?us-ascii?Q?B060ceY6tBDGjTrVrkC3JWEwoHCKt3/kzxF74hxi2ZwuhcEE6jHaxhUZlgks?=
 =?us-ascii?Q?64Am5N1E8PVpTtwma0xIpouCNqgRir5W6WXRSD+vjTvoxM0bXQ/nBPZCI4g1?=
 =?us-ascii?Q?9jvEkkqC87E4ullhvduem721+i7Cfa5p4yBVs2c5KwgIoo1KQBgKICR9WTEd?=
 =?us-ascii?Q?WKu5evrk/K45GkBrA2+WaZ/Km5F5lFsdm+JWvH89l+MXMhjq3M/TrsJJ6EN9?=
 =?us-ascii?Q?y23AuOxYnmsQO0UqVnbmRoiHi3OTJWBhTdzmoezt2vN+inRzG7GlIafPa26g?=
 =?us-ascii?Q?hQyTSrKAmKcDb9If8KeENXIWpGBt4vHlPw8eNOZOEBfTnAzSzZDUNS+bSH8d?=
 =?us-ascii?Q?9nKVKyWQbUqsGwmsb5Pjb/0aRIZ36qvF2p9Em+OOoUmLHCGelkRighfFeLs7?=
 =?us-ascii?Q?s82lpHF/AB/zUcMrnBehBVVFg/kWEAKBYwUdE0poCW77RpvGPoS1+zN+zWNE?=
 =?us-ascii?Q?et0lfEScBe/cZDm58hs59AB6SAumE7ODwTuAevakXX7uC+s1Kqy+w5cuCj6A?=
 =?us-ascii?Q?aPKr3EaeS8viSQfKZsYRsPqAnXB3APOwE9FZkBZjqZKo/SIYHHR/KEpiBPvC?=
 =?us-ascii?Q?z0vK+UG3GgF/QA/xHVcaKWdPy+c+UGe9VIjPc7Qb+C3epdvwwDuwPAbLKRZ6?=
 =?us-ascii?Q?no9AhKNCXW+U8aP12Jl8hgQeBJsfuR4kLNFDt3+evCa0o/g94aMf+KUlMVeo?=
 =?us-ascii?Q?SzfyLvUBT/2Ga5kWZPT/CHtTjMDdxZmQoRr4DAw6wKxtHQu2Jca3cfkY6xlW?=
 =?us-ascii?Q?9+7Tg2EFHNpISCzYYbS6KSDdfgfE12agPz3kLqQ664t92c3sLB5LEg+zS/8J?=
 =?us-ascii?Q?5w4cC+epJvQmmnBmNo1YftRs7FwiXSuotYhq9eCAD6+KEm/CS71e65AagT9w?=
 =?us-ascii?Q?0BanLxVSlDt7D/BDlbQO/pEsHYy+F1pO/JeXjfIg4I3vdJxt1Lskg+BaeVnr?=
 =?us-ascii?Q?eHDFibC+PI8QKmei63qRgjWj3JjEovhzutxV1anIEbcgIk/rqenGWWKNZhgg?=
 =?us-ascii?Q?9odImS1SPjB6fcCxlYDkEJc5FLXqF6sAmaVIgFmiDea8SADISSB551K6QuXg?=
 =?us-ascii?Q?swl/deX8Vv0pwEBDm8qGTIanEdNWKh8KojJIyB0qiavscz6aYjAbru+01rKn?=
 =?us-ascii?Q?P1uMF3F6AYAHaG2cUj5WCpc3Y9Fz3wIreEB4tqaAMxTwEXqOSeoEYpehcotL?=
 =?us-ascii?Q?Cf5WEE/qThkjltk83uwvWbFzsRf+gqqzAvHBstna0GO4tl9dCc/DMTGTWNkd?=
 =?us-ascii?Q?8M2qqh9Bb9oUb+yFTc1uYNQn8+tizQ33TtiF/g/kJDL74p272GOOTB3o60Xn?=
 =?us-ascii?Q?3NUtlRTevIRzyFof6V3w84GjqrZ0QtJioj5hKQqSB7firKGdHrgBwC/4XMiC?=
 =?us-ascii?Q?pNhNm1EPgVlIYNBb8gTuu+XUmyuDv+WVlRVKJ+LlzGOjZ1AeJKDMuE16mm09?=
 =?us-ascii?Q?XlFS6L+VLkNeGugj+yduOibWO5FURuoQbp7XiC2A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2474fc-b243-4d46-1457-08dbf141b54e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:32.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93nww5V9g/eaLQnxQzboJqczCHnjeuE3OZRWZyviBfiWDz2xmR2FRs3Riux8fdNo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484

virtio supports a single iommu instance with multiple ids.

It has a combined ACPI (via the VIOT table) and OF probe path, add
iommu_viot_get_single_iommu() to respresent this.

It already has a per-instance structure, extend it with the ids[]
array and use iommu_fw_alloc_per_device_ids() to populate it.

Convert the rest of the funcs from calling dev_iommu_fwspec_get() to using
he per-device data and remove all use of fwspec.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/virtio-iommu.c | 67 +++++++++++++-----------------------
 1 file changed, 23 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index b1a7b14a6c7a2f..767919bf848999 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -77,6 +77,8 @@ struct viommu_endpoint {
 	struct viommu_dev		*viommu;
 	struct viommu_domain		*vdomain;
 	struct list_head		resv_regions;
+	unsigned int			num_ids;
+	u32				ids[] __counted_by(num_ids);
 };
 
 struct viommu_request {
@@ -510,19 +512,16 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	return 0;
 }
 
-static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
+static int viommu_probe_endpoint(struct viommu_endpoint *vdev)
 {
 	int ret;
 	u16 type, len;
 	size_t cur = 0;
 	size_t probe_len;
+	struct device *dev = vdev->dev;
 	struct virtio_iommu_req_probe *probe;
 	struct virtio_iommu_probe_property *prop;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
-
-	if (!fwspec->num_ids)
-		return -EINVAL;
+	struct viommu_dev *viommu = vdev->viommu;
 
 	probe_len = sizeof(*probe) + viommu->probe_size +
 		    sizeof(struct virtio_iommu_req_tail);
@@ -535,7 +534,7 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 	 * For now, assume that properties of an endpoint that outputs multiple
 	 * IDs are consistent. Only probe the first one.
 	 */
-	probe->endpoint = cpu_to_le32(fwspec->ids[0]);
+	probe->endpoint = cpu_to_le32(vdev->ids[0]);
 
 	ret = viommu_send_req_sync(viommu, probe, probe_len);
 	if (ret)
@@ -721,7 +720,6 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	int i;
 	int ret = 0;
 	struct virtio_iommu_req_attach req;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
@@ -763,8 +761,8 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (vdomain->bypass)
 		req.flags |= cpu_to_le32(VIRTIO_IOMMU_ATTACH_F_BYPASS);
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		req.endpoint = cpu_to_le32(fwspec->ids[i]);
+	for (i = 0; i < vdev->num_ids; i++) {
+		req.endpoint = cpu_to_le32(vdev->ids[i]);
 
 		ret = viommu_send_req_sync(vdomain->viommu, &req, sizeof(req));
 		if (ret)
@@ -792,7 +790,6 @@ static void viommu_detach_dev(struct viommu_endpoint *vdev)
 	int i;
 	struct virtio_iommu_req_detach req;
 	struct viommu_domain *vdomain = vdev->vdomain;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
 
 	if (!vdomain)
 		return;
@@ -802,8 +799,8 @@ static void viommu_detach_dev(struct viommu_endpoint *vdev)
 		.domain		= cpu_to_le32(vdomain->id),
 	};
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		req.endpoint = cpu_to_le32(fwspec->ids[i]);
+	for (i = 0; i < vdev->num_ids; i++) {
+		req.endpoint = cpu_to_le32(vdev->ids[i]);
 		WARN_ON(viommu_send_req_sync(vdev->viommu, &req, sizeof(req)));
 	}
 	vdomain->nr_endpoints--;
@@ -974,34 +971,21 @@ static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 static struct iommu_ops viommu_ops;
 static struct virtio_driver virtio_iommu_drv;
 
-static int viommu_match_node(struct device *dev, const void *data)
-{
-	return device_match_fwnode(dev->parent, data);
-}
-
-static struct viommu_dev *viommu_get_by_fwnode(struct fwnode_handle *fwnode)
-{
-	struct device *dev = driver_find_device(&virtio_iommu_drv.driver, NULL,
-						fwnode, viommu_match_node);
-	put_device(dev);
-
-	return dev ? dev_to_virtio(dev)->priv : NULL;
-}
-
-static struct iommu_device *viommu_probe_device(struct device *dev)
+static struct iommu_device *viommu_probe_device(struct iommu_probe_info *pinf)
 {
 	int ret;
+	struct viommu_dev *viommu;
 	struct viommu_endpoint *vdev;
-	struct viommu_dev *viommu = NULL;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct device *dev = pinf->dev;
 
-	viommu = viommu_get_by_fwnode(fwspec->iommu_fwnode);
-	if (!viommu)
-		return ERR_PTR(-ENODEV);
+	viommu = iommu_viot_get_single_iommu(pinf, &viommu_ops,
+					     struct viommu_dev, iommu);
+	if (IS_ERR(viommu))
+		return ERR_CAST(viommu);
 
-	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
-	if (!vdev)
-		return ERR_PTR(-ENOMEM);
+	vdev = iommu_fw_alloc_per_device_ids(pinf, vdev);
+	if (IS_ERR(vdev))
+		return ERR_CAST(vdev);
 
 	vdev->dev = dev;
 	vdev->viommu = viommu;
@@ -1010,7 +994,7 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 
 	if (viommu->probe_size) {
 		/* Get additional information for this endpoint */
-		ret = viommu_probe_endpoint(viommu, dev);
+		ret = viommu_probe_endpoint(vdev);
 		if (ret)
 			goto err_free_dev;
 	}
@@ -1050,11 +1034,6 @@ static struct iommu_group *viommu_device_group(struct device *dev)
 		return generic_device_group(dev);
 }
 
-static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
-{
-	return iommu_fwspec_add_ids(dev, args->args, 1);
-}
-
 static bool viommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
@@ -1070,12 +1049,12 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
 static struct iommu_ops viommu_ops = {
 	.capable		= viommu_capable,
 	.domain_alloc		= viommu_domain_alloc,
-	.probe_device		= viommu_probe_device,
+	.probe_device_pinf	= viommu_probe_device,
 	.probe_finalize		= viommu_probe_finalize,
 	.release_device		= viommu_release_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-	.of_xlate		= viommu_of_xlate,
+	.of_xlate		= iommu_dummy_of_xlate,
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= viommu_attach_dev,
-- 
2.42.0


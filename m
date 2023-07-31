Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5F1D304;
	Mon, 31 Jul 2023 17:50:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gu+o/EgWPdsiZ5DnRmfioObAEvHrAKMZzPCfvY1hr3CJiFSrOG1l/bC/WM7IJWMAbPnejcgbChwindljWMFBbmbywjAWcRLB9ODp37m81x0/T4Sn8MKtSO8oTGy1pCTT6x8ezxMp5tdFxksl+BaFi/lXwD8lpLMWe9bDh/rvBFHXjquFKB151AiRuHK9VuJrOCohdyWJICmXTRn0mYvZqEoWhaL+yyqraYthPFTtkohF7EPrZ107VPg+xC/c+RxxCBEu+9UqVXCzAsPrGNgrlWhG78F0NUzpiuRkmM9NQmBTkNFn53Y4NylZr4dDwK5b6xExOIpQ3DlJsKHIv4f57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmX4WHHL23gUBireWMOT34rh6wFQKVQ+0sJ2x2RXhfo=;
 b=NTtk6ukTzSMpcuvfud0cvXnYZGNuf8iVLa/G8/2w5O2zwRNKxGSiPrTiC8uNkYlqZvGnUUpvvNYRpAob1ognn2q8NSpOZ66iFEYF7c7jytKtztc4epKp1+h0AdMESbLy4f73bOZYyx9aNZ/eH9WwFB+J1znGf7oz5dQJD9cgE+T1VLxY/Nm2AmcAny6B7HLssq3VKCzdq1OBjtlQEzNZAREzDEzyNSQrpaUrzRkX+RjyZHMCn2GrDmXXRr/y+p30lF1BGEwcQWwX2innfMncuelRUkADONNGTAoxsVwlJO1vut19TJ8hyQ01eBMFsoSXeDBpdKk5Na+Jxg5modUBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmX4WHHL23gUBireWMOT34rh6wFQKVQ+0sJ2x2RXhfo=;
 b=Bj+ZcY0Tb17ryvBsU2b3S+8mK4pz5kPYtgBSr7Je8MbTC4dVPgM9uOr6uZSztVdLWq0FKsT0DMb+GEgtKl03uZby8wHFM3vr8im3M7fHTrVg1OirGu73dtENy9RvVj/ICso7Ig8I0AlqiEF5aGCHXmvE/i3rmK39BoKjsul/W3m/nLR6W9zvo9gmj22SD3gPs+MFCgpvkq1pKlMP8JNPCoxULMnZFgGPOOOL1nnrpYjVfd9Lt1BA0LFLVG+Rez9ICURI1Xpl0h1HqBMcMQWU6Z3h/JyjSs9Rzt3ec2e9OcREfWIeyBmMcdI3fb/u4+HkvMK6h+69RkSGTZTSEyw/Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 17:50:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 17:50:39 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 02/10] iommu: Add a lockdep assertion for remaining dev->iommu_group reads
Date: Mon, 31 Jul 2023 14:50:25 -0300
Message-ID: <2-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 459127bf-4727-41fd-6583-08db91eea4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VpOdn2abDiShUr57WT8Gbw+65CWEggZC8gw5GnlDWG83cVAn95IHHQBepE5jVnawa97vPYipZn+qHxu4HXZ7jIV70/9P+FjORlhbRpvVfYKO/arGqTGWYOcm/jJ20iSB/R95A3fEm6nEzT5p8BI6Crm356bGd9NNFyI7eGLqN7gAYWZfjHUbfJAmlyVEjJM8kcFnjgrXxA9vbsucTutGyZTOgXXKgFGOiwrQE2gXpxkFjwHP/9UbUqi0KX7d3GNcG6ogzgz3Bo14hTqII2mVja1xVLUYN2Ora2oUSVlGDAGjxfPfSFxvnV4wmsIrcaP2wz09c5F6GnSr3ZATD69qsjsCvh5VsJAnZe5Nkmn9v7Yvf3TDiBMhDVerY30i3yS+nNhuhOrBWMOpQ/mDIjI6pP/td9ed3XJoc6FuiYEkhYBe4ENJUNMWmQgQ6hkNgZ5PMZAKUmtVz8QXQECKAzd1TKwfJ6izCsGS37gpOjReSTJX0ZR8PZs+XQZfwA3ZKn1t7gz5x7EvuvUlN6lkVD5lwlltJAQv5Ic9PScR1GyeVorlc0axn5WonH8+l3fIRWoWLm0WKBCmDbdtp8u7+/8F5BBtVUsn+N1/Wda8V/+2GDZNJ1O7fo16sEqNhlEPTkgh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(478600001)(38100700002)(921005)(86362001)(6512007)(36756003)(6486002)(6666004)(2616005)(186003)(8676002)(26005)(8936002)(6506007)(5660300002)(4326008)(2906002)(66476007)(66946007)(66556008)(41300700001)(54906003)(110136005)(316002)(7416002)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ugDGh5kPWgV1xkgviYe1kwLmloNDxEpNhIDsExVy1dYGTUEbJ2Af1rGYtHks?=
 =?us-ascii?Q?gD7upZ+zcyIuG4J9NOaKDYa7qHUbm2Tulx7X4nIddO8jabQ8PzmCbFHlAxeQ?=
 =?us-ascii?Q?uLDFNpOW2Br9R8U2XdrGOL2Tb4Q7ms5ovpcgB18hbWubhbHdq53paUA117ol?=
 =?us-ascii?Q?WhLRraYPMXrgSrLSXMcYt+0KWZzDwVwC09/lHxZW2vfF5DsH7LJ1puqo6o2y?=
 =?us-ascii?Q?KTZ+Lq7BB1CkRtGmxyngYJF/P71gtzHo2LTEd8HeaujSPDP7dTxrMQ4xmAKN?=
 =?us-ascii?Q?crlHaOsBCsNf9sew5gGlUc3kooCLGswMvqZSPYzKo+C+YDK9ax1BjIxksk60?=
 =?us-ascii?Q?0yjjvazHoExW9QvF7XlqfNuj43mG1KN0PueBzQCyUNSl7hSwZ0M+lomxjANv?=
 =?us-ascii?Q?TJdnWzv9xsuNXVYUc+uhcIrj9A+TfQAdEVRqCpTcbhrompJnG4UD/G7+u6Dh?=
 =?us-ascii?Q?nya9/OhDBDviOi92dKNRzkrsDBMDBQuy/MMAL3wUSQIf2XLN1a61mCjkCe4X?=
 =?us-ascii?Q?+GZKGbuAHL4CKxuK+v8vMmafvkFfBGpmba5kLaMT9NDZVy64CtEl3sFovjZ7?=
 =?us-ascii?Q?QoALy3NnHYL23vxzId1Cj2g5mkR9ERgy/6c/782vrcFNzPtC+vAsQr2nhsRB?=
 =?us-ascii?Q?Wp+EESa98F2kPUu5lE5/9NO17HTtZlWFXWkh7Gq7SeUZuofajl11PBdKD1mi?=
 =?us-ascii?Q?37/vb58YgBaLUjgVHVLMDaoilk4/zuv5KiWaak7u4r/1RkKJX2+Sw8R+1KFO?=
 =?us-ascii?Q?CjDU29hrnTWNe5/UWEtEtfFBFp6gU1vOu/2/9V3/eEc12ZFYhtA0xYHpVcG2?=
 =?us-ascii?Q?LDXVZFkJKGfbI0SQ32mH7lEC7MNezi7+O9gA1Xy2bbPbHa4+D7AeUXzJVAzf?=
 =?us-ascii?Q?PyHmyhLc0yBkfXwSi3VpXAm+Oj1NnI6aIjM6SuUNl5BHz3fjlpj35CQi8NYh?=
 =?us-ascii?Q?2Xc3bW6HIyO5C/3pak/quYX/FNeY+NMvp+0b0ELJDG0sDLmMkE+HQVj7v5rr?=
 =?us-ascii?Q?leHTh4/SL446h1vs11jvZGikObL8QYTOsorAmM7JABK9ZgoMenqMtNNbdTpM?=
 =?us-ascii?Q?NPIHgw2T+NU2tBol5NNzteYiCZQuyrOl6/mVDuvQxB+HSrchbp4lFdPNuSCo?=
 =?us-ascii?Q?LMNrQ2N45wsMejTzNeLufFqFLk5SD8KbdWiygUOijpgDlJbyKvrhsHQN+Tkl?=
 =?us-ascii?Q?IqTvIcZAkEGAo1fslM3kVVh53G2sUL/34vhpfvw+T+H5t+23urSZRsrvjjm9?=
 =?us-ascii?Q?eCk/24NRbIbTr3Rjo7w8o0Lr9PMIHB6mJqmR5/Cn92W0RUJcDpZnoir0K1g3?=
 =?us-ascii?Q?LvkPz7lS5rQdCISE7jQO8r7hvGIW2D/PPrf/rAVL7Hm4tMQnWy9ZxfE+VtVK?=
 =?us-ascii?Q?ha7zNio6e/zUBcd7Brbj3Is4zwG/Sky/nnOmVBN/eDxm4pOr4p51lD+0g+GL?=
 =?us-ascii?Q?o8uiuSOUPpugT3K4Jyy7l5Jw0yEYhvtQpWY31JCvdB1kv0RiEv39xiLGDQsi?=
 =?us-ascii?Q?+yvczEe/L0xV5w3F93P9qNoEXreeUoI5PdSa+MGBgkvPahmz7nRyj0hK5H+N?=
 =?us-ascii?Q?kXJlFaGIc12OYwe/OtQ6bVdwMk7KTggd+jMrXlm4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459127bf-4727-41fd-6583-08db91eea4c6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:50:35.8790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 941zaoeslWMjhrj7dmdxifPD1fhePYvOKqEnKjXUDGWGmtf44iPEh+A4DFvqpZxb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320

The remaining reads are all in functions called under ops->device_group.

Broadly these functions are walking around the device tree (eg going up
the PCI bus tree) and are trying to de-duplicate group allocations
according to their logic.

Since these functions don't hold any particular per-device locks their
reads to dev->iommu_group are being locked by the caller's
iommu_probe_device_lock, and this explains why iommu_probe_device_lock
needs to be a global lock.

Rename iommu_probe_device_lock to dev_iommu_group_lock, make it local to
the module and annotate all the device_group helpers with
iommu_group_get_locked() that includes a lockdep to indicate that they are
special.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 409090eaac543a..f1c8a333553e3b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -44,6 +44,8 @@ static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
 static u32 iommu_cmd_line __read_mostly;
 
+static DEFINE_MUTEX(dev_iommu_group_lock);
+
 struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
@@ -438,7 +440,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	struct iommu_group *group;
-	static DEFINE_MUTEX(iommu_probe_device_lock);
 	struct group_device *gdev;
 	int ret;
 
@@ -451,7 +452,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	 * probably be able to use device_lock() here to minimise the scope,
 	 * but for now enforcing a simple global ordering is fine.
 	 */
-	mutex_lock(&iommu_probe_device_lock);
+	mutex_lock(&dev_iommu_group_lock);
 
 	/* Device is probed already if in a group */
 	if (dev->iommu_group) {
@@ -497,7 +498,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 			list_add_tail(&group->entry, group_list);
 	}
 	mutex_unlock(&group->mutex);
-	mutex_unlock(&iommu_probe_device_lock);
+	mutex_unlock(&dev_iommu_group_lock);
 
 	if (dev_is_pci(dev))
 		iommu_dma_set_pci_32bit_workaround(dev);
@@ -512,7 +513,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 out_unlock:
-	mutex_unlock(&iommu_probe_device_lock);
+	mutex_unlock(&dev_iommu_group_lock);
 
 	return ret;
 }
@@ -1219,6 +1220,12 @@ struct iommu_group *iommu_group_get(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_get);
 
+static struct iommu_group *iommu_group_get_locked(struct device *dev)
+{
+	lockdep_assert_held(&dev_iommu_group_lock);
+	return iommu_group_get(dev);
+}
+
 /**
  * iommu_group_ref_get - Increment reference on a group
  * @group: the group to use, must not be NULL
@@ -1532,7 +1539,7 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
 	if (test_and_set_bit(pdev->devfn & 0xff, devfns))
 		return NULL;
 
-	group = iommu_group_get(&pdev->dev);
+	group = iommu_group_get_locked(&pdev->dev);
 	if (group)
 		return group;
 
@@ -1573,7 +1580,7 @@ static int get_pci_alias_or_group(struct pci_dev *pdev, u16 alias, void *opaque)
 	struct group_for_pci_data *data = opaque;
 
 	data->pdev = pdev;
-	data->group = iommu_group_get(&pdev->dev);
+	data->group = iommu_group_get_locked(&pdev->dev);
 
 	return data->group != NULL;
 }
@@ -1629,7 +1636,7 @@ struct iommu_group *pci_device_group(struct device *dev)
 
 		pdev = bus->self;
 
-		group = iommu_group_get(&pdev->dev);
+		group = iommu_group_get_locked(&pdev->dev);
 		if (group)
 			return group;
 	}
@@ -1662,7 +1669,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
 	struct device *cont_dev = fsl_mc_cont_dev(dev);
 	struct iommu_group *group;
 
-	group = iommu_group_get(cont_dev);
+	group = iommu_group_get_locked(cont_dev);
 	if (!group)
 		group = iommu_group_alloc();
 	return group;
-- 
2.41.0


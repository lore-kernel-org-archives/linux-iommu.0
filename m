Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779619;
	b=ueQfZXFx7/PmiRZvuy1LkAcFzWBJr/P36ThTsDzS/Nr6J1TrGf8mUxawRI9I3Nv4AJHu
	 v793tazVYL6S2Gvr9OUsfLJxWw0maSQrwwPO+KP+VCxVbYJawBrW70gVZl5WCNiM1SMcQ
	 Ov/aIMpZLanEO5WDkXQJQ5WraLz/7oTGTL3RSLSzFT1z661+npPvSRQ7X7Lcwi9Eh3sfc
	 Fp5asZvt8/Mj21XNXGWXuojTDOfiBvpHQ0N94qN5i7zvpxkWqiehSyV5RTHlHLpm2PCqy
	 D9vQE4YOC/4DRQH0FAcMBMli3+QnG8FXYQZRs6UOY2/TjvJ3VqrCuc+Pmc7XF2K4vlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779619;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=KSP9pafrIMxqz5xBSu7jeumKmSdlBmCOijDgVYVd4Rc=;
	b=4u0jXJfi/cwGnw5HsSIbTmoXjomnAOkYQVBBtWVlEFDP24xtJNwbbVnf36QB4kpkn8zm
	 r9J+SmUD+Nw2IHYflZLBi1fCbIcUA2A2FDGYDoMA8zIBre/KEN8BxwOydbhfeeLAlaK+D
	 ALtF2mQrC1z0e+GWgaJvwBc7V+YmL6quruCn3sYLFO6LcwAzGGTACrU8xfwjzYSm9k0t0
	 t3L3lYffXmlDbx4ErI8oMZmZ2sOE3qCFrCRgX1NaRVBtp6kbLoBX/HdJNaZc4WVx3ayM8
	 l/Ej6eya2fnvM1IgQllD+96ZAA0eN1y7UKVig9Gv88hAIEfIeSn8zXtUzSFGPo2fPpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uLMv6xWE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.12
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92A606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B92A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uLMv6xWE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beWDyL2W/imAyyZlmYiE4CDERwiG+DcbOJSnliZOmehinkSUPYzI/9QYHJWvp52hdk1QAqUrLl/c4Ni4Wu6B2M0awSDdBJE9xzLG9MavtwvcvCmgjuQLFR2l8ItI9/Tjby+4RDTABhGmxVuemKcB7R6n9hulPP/uSOXXd50ezB4ala2xD2UWgM+jD60kxlqKAO8vtCdcfczyY0AQku60qdOboUUOtGbAh1E8YoWliFhd/REKpm3DSh9FlkM2unZdHbmdiiULU9YBxrg8SioK7JV3zQwsdeoU9Eub8rfwRnzgZXCWzW1j9TLlCK5XKf0uiqMX2FuKzpwTcHcqdIzKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSP9pafrIMxqz5xBSu7jeumKmSdlBmCOijDgVYVd4Rc=;
 b=OBjEIDMp6IWRGFO1gFMlPCtgSbu+5ebKlUR5BlFaPlraB+yc9f/04OiTWrhHF0qWG3v15fEPNxvVvrw7NDoJKiA4FiG75PglCh9BtLJxAtvkginCPent7LC7rDw2Qgoo0hXZJuaQdXWS+VwD0/46C+VdEJkl5n8lnDeJMQB7rj7wUdOf9U9Cb65kHrx0RyRdvfjVBMXeTMYLk/sNWqB5/wvakn+Yj6/UcBH4yA21eNJ6plLFBSRENe2AWDANW4Pt5AfSEXNwpHqumnSu+1kESUdw4RlvSWjniSkNsExVOqA92381FamuU4/b6LJ0AM3Ss/bxrGonEeUNpJFCWR1HOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSP9pafrIMxqz5xBSu7jeumKmSdlBmCOijDgVYVd4Rc=;
 b=uLMv6xWEOLDgUwDkkflx/iU38dYrYjoQpHVjOPuPkpCOwKLOUav+bSvogwri5vUHV8khAjd0klQ1yC6o+6GCpP24dMqkbBN+9deJ5UL1vuVsv66ZyOUPYLsWeYGS0T8N1P4umwl4yEPlZ/U1zAhdW5i9NAkigJfaSZGXf3PamNE=
Received: from BY3PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:39a::27)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 11:40:13 +0000
Received: from SJ1PEPF000037B6.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::5d) by BY3PR03CA0022.outlook.office365.com
 (2603:10b6:a03:39a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 11:40:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B6.mail.protection.outlook.com (10.167.244.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:40:12 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:40:09 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 RESEND 1/3] iommu/amd: Serialize device-table writes with one per-segment lock
Date: Fri, 27 Nov 2026 11:39:32 +0000
Message-ID: <20261127113934.209373-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127113934.209373-1-vasant.hegde@amd.com>
References: <20261127113934.209373-1-vasant.hegde@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B6:EE_|SA0PR12MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b38e89-6512-4728-1c76-08df4c7b328d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	c00Ml+MkePwqGGXISNaHh/QhkfSPpB7uKQoW8YHtJGWHkBBHPfz99jNuh9PXEfkFV7D1fXHyO1qwb4IFAaaYSncLzF5NStxkDi2nlb6r4+646SJctMTU2FK9gslQs1x7GG+canHfj5f0k4m8eRX8wKqxQ12frkia/7oreo++b2wSDwabH2IEjBiiFWKad9X7VQPi17vYaF+2UJmZSFqBRf/ep6ULjjKkg3cC68mKziM0+dUuFW2p9SIVP9KAZLb269hQQfwLfOzI27VS835NXg08/9UPg2ZgMjUGEhi5xR+JPcko8BGj3509u6En1uxFYHJFVlKlGaeKyusK842RAEpuaLTE6rRk3i+CI8BWxAanNIYn0WI05blW5xODvi2x1il2G+m0b5ICoU6NP8IVZoyz0+VRKUaouRMlLdM/epo/U3R7afe+j28KM6xdbs6FO0wvrBSiIQfILWOo9QRpOMem4tHKmYwedCDKamB7srjcHTb19fRw8wRnpA/7OzDTns3HG4risRwcvukT2Te0PkC73SHtw+v3/HCmA47LzmIiNm59LLBFF79vtyibIQrgb6HjLuw80pOpo2qw0J3ltd9rAD4OmeK3xl2QvmJgRdUuG/o9stRgnGXgJERt7XPoNQUmuV5UiJY6O+4KTJaeCxAuoVG82yjf2EoyyATfUiRT6gddHFq5dWnRg07M3kI8RjRW0OB/U0VelMSFTCwljw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m4Enw1wZa68J0iM9nYMP+bDwkxJQ/H5QUE1fVOaf3rsSI6jCbTkucTR4lk+m6EBik8+7mWoVbrZM+e20C4ExiY7q/lT4oTvb9AjHqiyaUFrH7f5tXy/NSFAR1+V5o2ZTGyhWdgBlnPeBEJEwphXxvFjidP697a6WXZ+4fNjM5Sir0boEzCzQ7jscy3YDlt/n7SBfJhR3Q/VQJg0ltQPMc+eIBO7AS+KcIGR5mXDyV4tzVaZxhjqSDsHcgzqRCC2P6cAeQijTkLcBbwFlLuvKmZ2lt7ZRYlCwCeoBSQqx7sCUdqG0X7cIZfQVpZhFR94cpZ1kf8Vf0ihIz9HXj8YZ6zrnjtl3kt/t8LDvvBupMNYYgUN/f42lg3BkLoKCAMz/09OC7/I2LuGEndMDqeHvnAsuhbbN2+MPdSUhnNpsk0Z5PRO1GIbk1hcPzfIYlkV/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:40:12.1690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b38e89-6512-4728-1c76-08df4c7b328d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367

The DTE update lock (dte_lock) currently lives in iommu_dev_data structure.
Because of this, dte[devid] can only be serialized when a corresponding
dev_data object exists. This leads to inconsistent locking:

 - The interrupt remapping path (set_dte_irq_entry()) skips the lock
   entirely when search_dev_data() returns NULL, leaving the DTE write
   unprotected.
 - An alias ID has no device object of its own, so clone_alias() has to
   create a dev_data for alias devices purely to have a lock to hold
   before updating the DTE.

Move dte_lock to per PCI segment (amd_iommu_pci_seg). This guarantees that
every code path holds the lock before updating DTE. A subsequent patch
builds on this by removing the need to create dev_data objects solely for
alias devices.

A DTE update is not a fast-path operation, so using a single per-PCI-
segment lock instead of a per-device lock does not affect performance.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            |  1 +
 drivers/iommu/amd/iommu.c           | 22 ++++++++++------------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 9657e80ffdeb..30dc9495e3ee 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -566,6 +566,7 @@ struct amd_iommu_pci_seg {
 
 	/* List of all available dev_data structures */
 	struct llist_head dev_data_list;
+	spinlock_t dte_lock;		/* Device-table update lock */
 
 	/* PCI segment number */
 	u16 id;
@@ -806,7 +807,6 @@ struct devid_map {
 struct iommu_dev_data {
 	/*Protect against attach/detach races */
 	struct mutex mutex;
-	spinlock_t dte_lock;              /* DTE lock for 256-bit access */
 
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c9c504ce8ce6..61e7b70fb063 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1801,6 +1801,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
+	spin_lock_init(&pci_seg->dte_lock);
 	INIT_LIST_HEAD(&pci_seg->unity_map);
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 41ee4ad1dcf8..8beb23e96c8e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -121,7 +121,7 @@ static void write_dte_upper128(struct dev_table_entry *ptr, struct dev_table_ent
 	/*
 	 * Preserve DTE_DATA2_INTR_MASK. This needs to be
 	 * done here since it requires to be inside
-	 * spin_lock(&dev_data->dte_lock) context.
+	 * pci_seg->dte_lock context.
 	 */
 	new->data[2] &= ~DTE_DATA2_INTR_MASK;
 	new->data[2] |= old.data[2] & DTE_DATA2_INTR_MASK;
@@ -152,7 +152,7 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
 
-	spin_lock_irqsave(&dev_data->dte_lock, flags);
+	spin_lock_irqsave(&iommu->pci_seg->dte_lock, flags);
 
 	if (!(ptr->data[0] & DTE_FLAG_V)) {
 		/* Existing DTE is not valid. */
@@ -208,7 +208,7 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 		write_dte_lower128(ptr, new);
 	}
 
-	spin_unlock_irqrestore(&dev_data->dte_lock, flags);
+	spin_unlock_irqrestore(&iommu->pci_seg->dte_lock, flags);
 }
 
 void amd_iommu_update_dte(struct amd_iommu *iommu,
@@ -230,10 +230,10 @@ static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
 
 	ptr = &dev_table[dev_data->devid];
 
-	spin_lock_irqsave(&dev_data->dte_lock, flags);
+	spin_lock_irqsave(&iommu->pci_seg->dte_lock, flags);
 	dte->data128[0] = ptr->data128[0];
 	dte->data128[1] = ptr->data128[1];
-	spin_unlock_irqrestore(&dev_data->dte_lock, flags);
+	spin_unlock_irqrestore(&iommu->pci_seg->dte_lock, flags);
 }
 
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
@@ -383,7 +383,6 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 		return NULL;
 
 	mutex_init(&dev_data->mutex);
-	spin_lock_init(&dev_data->dte_lock);
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
@@ -3104,13 +3103,13 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	}
 
 	list_for_each_entry(dev_data, &pdomain->dev_list, list) {
-		spin_lock(&dev_data->dte_lock);
 		iommu = get_amd_iommu_from_dev_data(dev_data);
+		spin_lock(&iommu->pci_seg->dte_lock);
 		dte = &get_dev_table(iommu)[dev_data->devid];
 		new = dte->data[0];
 		new = (enable ? new | DTE_FLAG_HAD : new & ~DTE_FLAG_HAD);
 		dte->data[0] = new;
-		spin_unlock(&dev_data->dte_lock);
+		spin_unlock(&iommu->pci_seg->dte_lock);
 
 		/* Flush device DTE */
 		device_flush_dte(dev_data);
@@ -3340,11 +3339,11 @@ static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 			      struct irq_remap_table *table)
 {
 	u64 new;
+	unsigned long flags;
 	struct dev_table_entry *dte = &get_dev_table(iommu)[devid];
 	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
 
-	if (dev_data)
-		spin_lock(&dev_data->dte_lock);
+	spin_lock_irqsave(&iommu->pci_seg->dte_lock, flags);
 
 	new = READ_ONCE(dte->data[2]);
 	new &= ~DTE_IRQ_PHYS_ADDR_MASK;
@@ -3354,8 +3353,7 @@ static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 	new |= DTE_IRQ_REMAP_ENABLE;
 	WRITE_ONCE(dte->data[2], new);
 
-	if (dev_data)
-		spin_unlock(&dev_data->dte_lock);
+	spin_unlock_irqrestore(&iommu->pci_seg->dte_lock, flags);
 }
 
 static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
-- 
2.31.1


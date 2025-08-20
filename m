Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99723C516
	for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689444; cv=fail; b=Iu9A+MmKOpZ/xhHMhXRDy19DE8r3U9nWDXEoinG3S9/2V3BT706em/1d/+QNKBdaMY8dXvtq9KaglH8aXQ426onqLEkhxcT4vWCyE/uoCz8u0XfT7kvnO5v8ee3hD6ef5A48LdA48oGAwhKoeaVp13JUeMbZL0xhG9rJDm5mIIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689444; c=relaxed/simple;
	bh=bLW4T4Or+cN8kQFnj67sX1u8UA1H3RmUwZUul9W5sfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ek79Q6Qb2DlqjabKUKtWBbUrpj9vFREG5dM+/swVEyG6z4gnuV98csA45nrcyNv/2Z/wUrw+VQ54uuAyvG8tnyedcaqPbzxvHrhl8YfZKiH8JbwchjTdyeI5wF+uLiICWLegI4Si+Y6V2kbAXZFYSTcLxFymkKSrhh+lN6oeLMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3aJr7W0K; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3aJr7W0K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADNnVE7AgsmN3560WkwwOwWDbOX227cyUwmy6FQiGwJD/1sEfYIiw9JBXfziNLkvwhvXBcN2BjNkCaq5W+vazaFfkKiJa85IiQRlZyTYKJvqdLTcD5rFAHz6qibkmX7V5VNUH19KwIe3ZZWCiz6QK8zdsRyCaEvRlt5bcQU3KA5ynB7NAzwRISIYiSe9sIQTD0n3+HVcYaZb1YQEdK4kb8HQrUgx7Dwvp6Ol7k4yzGld23qmkupekCqA8nQ5oGtU9JA3WKl8hR70YgVi3xNX7VWURheSnvxb6GNiORKrczk5r/OSA8PzFc/2hQ5zYz8j02x/EpjC8mqdmFWlhZnsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyTZ8caLnvYQ+1ih6KQGwrIc6kgz32BWjKgL+7oW0ZQ=;
 b=M4LIgkm/klNjMWcZ3lDpBkMkZMk6Aiwl3oOxrEh8CZUQZ4pgidZi4kTdcn75Ch6P1Kstp33ovXgm4fj+cA8Za65RgWRLCC+HymccU27Yj9omKAc5uSDLCxXtnXkzrt7Q4Ytd6iqQcjcQ+y9WgUId/y0ukp1w/cZO6MVn9LytenOlsH3U9A3YRmNTLS24zgo0c3bTidwY4zz0HKHRsVua4yyxpTSTX0zWNUBRzOzZjCQ7/IHJCAcWI+XZE7oxDU3oyZ9H+cvmyo+CP5fhkgPi8RErpqFqk8AyQ2oTZwKqVRdXja6OBI91Bqem/n64rATsqKwyH7KCc8akb/ah1wBJHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyTZ8caLnvYQ+1ih6KQGwrIc6kgz32BWjKgL+7oW0ZQ=;
 b=3aJr7W0K8JjIRohkBzPAS+/kEuJcE6wXwckLCSWCrLnCROh7efJpPK7DCZAz58y4k2l5ISWhVvDn4ly1YFnFWlkMQ8bAUcPW5KWOg1HjsBPrgDLOmdYiQisyP3NSKwJN7cw1bST5OWGcdZcretMwNciBQ9G2cAI+zQ0ippBTaK0=
Received: from BN9PR03CA0298.namprd03.prod.outlook.com (2603:10b6:408:f5::33)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 11:30:39 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::45) by BN9PR03CA0298.outlook.office365.com
 (2603:10b6:408:f5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 20 Aug 2025 11:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Wed, 20 Aug 2025 11:30:39 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 06:30:34 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/8] iommu/amd: Making device attach / detach helpers non-static
Date: Wed, 20 Aug 2025 11:30:03 +0000
Message-ID: <20250820113009.5233-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: fa032317-223a-4ec8-6087-08dddfdcfd54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LfI1HFpJM438VqQMpbiTi7OQJgekV5vjZNQSyp/dTH58AYsq3m8Bz/sictG2?=
 =?us-ascii?Q?yq5eitf/tsQYQ7C6exJL162BYH+MpoAWqblR7lZk8X/0qAwcHhZ+g1WnVZH6?=
 =?us-ascii?Q?wluODfcX6582FyTjUW+4XAKm98lkY9whvtEAk+QNxjQgzdkmQYLVrXd5gggi?=
 =?us-ascii?Q?Fb4zYz1KfJFtqd45VtfhyQOcQeW8tXQNWmrjeRGafq3ePU5sWp12ivh51QHP?=
 =?us-ascii?Q?ooFrm5o1FJ5b8OeJ5mcU8QVUUj3tnYlqFSfq7CV5RVwpqtU3wgHDvJ3U044O?=
 =?us-ascii?Q?Jcd3zVWhw34IbyIZAWYOVEwpTAZ2lujlbkHlBuoWsqHiTDIl2ERy17KWMfc/?=
 =?us-ascii?Q?7YWuT1N0eAvRXVbqgJXyxC524CbNwGPQWfPhvMtfFfIERvmBEJ9WwnHyMG1p?=
 =?us-ascii?Q?3VLBl6MqtvaqNpkb5tVMMyyA7KkixbQZozuyqSH508k1myx3paJfp6ts1JwK?=
 =?us-ascii?Q?uIMMrM47glpRR+y7Z7LqzDAg3RqrsBc0nl6+T0T0n/UFbaHGElOQ81n84pVL?=
 =?us-ascii?Q?0pGM5l+EhrGltSbA6ATEpIdSHZ3u3PPaf+h3sfEuUDHEsea21DAy2qYP4YbZ?=
 =?us-ascii?Q?apkmRA4dIvP6/7tCWepzlb+2AtBYBdGtrPW1YaaWe2vnvQLDKwptw+K5ej+P?=
 =?us-ascii?Q?g41/pLP8pkQN8J3rgSpvjQ6sBn5GdcHAxgkqSf5rBRVrcYyM3oWQ7IqlaH3l?=
 =?us-ascii?Q?gCSSiswmSkscUYvmW8J9yc2ZPt/1oDPW6UCQHqGvqLhHdarlYP+9mtGLKcwZ?=
 =?us-ascii?Q?ETON3QWWpAJQ/0WNDCbSnEov1xzFMLW8n4xvAAP5h44g3ljkLXiXR5xEGfGc?=
 =?us-ascii?Q?0QFmiDK4oA0mZWSSeu81ZFkCViINUIXOwvQm+EhJjQz3eYGysM21dsavc+Kj?=
 =?us-ascii?Q?mGU4AstASZ3Jeg2C0M/tjP46eLIBY18jNAky2s6cSRl1EAAzbUHVZC7JxQ7P?=
 =?us-ascii?Q?mOVriR+/HIcj5Gehaf3UNTUigEO/1EZ6uq3LXx8a4tNth0OsmQjAhxYUBZxN?=
 =?us-ascii?Q?rmQPdpSVVUEywa9djg6S5T9R8dI8Iv+nETQnGb5IoVhFbbTSOrSXEgqj59RB?=
 =?us-ascii?Q?qNn1W3r57O+wtkJ4gt9RDU21QizRs/ZAMBUKcTEQ6F7wN/dXcahGFYHiQ7nm?=
 =?us-ascii?Q?gpNdfF6ZibRrcQo4sXPI8wmGS98o5+732EmHllKgPlwb5deNuXMLTs2hj7C0?=
 =?us-ascii?Q?eXSEojXMK7MVExKtWAzA3VeLYkW+c9lvD3YJxoUDzeT/c0f39Yk50/yUsGqp?=
 =?us-ascii?Q?/czjwTfk5Gzs2UV415E4fn4u6LlxOjHdenbIkU4z6wtmPyYTeqTN5EoJVfsk?=
 =?us-ascii?Q?yec4vyFt1Xp3CsxrUjijovSWrpXrqtFfNn22wwPbhPGhpScv9xbluZCp2JUM?=
 =?us-ascii?Q?/S3MshbUNDeE3rcKmy6+tE0qnxibtCzJa3SGUY42A/3XV3exo6lFVXHUnsC9?=
 =?us-ascii?Q?VLiud6kreSE1N5KBMDRykIgnFa/fv04d2urKDmxxWKK6FzkW3x36V0e3z7m5?=
 =?us-ascii?Q?v4UoA7lTaA5h081oojXrHhhBWhVi3FL06Vdw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:30:39.2016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa032317-223a-4ec8-6087-08dddfdcfd54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323

To allow reuse in subsequent patches.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  2 ++
 drivers/iommu/amd/iommu.c     | 11 +++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6ea549816a1f..5085aa353522 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -88,6 +88,8 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag);
  * This function flushes all internal caches of
  * the IOMMU used by this driver.
  */
+int __amd_iommu_attach_device(struct device *dev, struct protection_domain *domain);
+void amd_iommu_detach_device(struct device *dev);
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a05b7f69ac74..207fef84a4c5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2262,8 +2262,7 @@ static void pdom_detach_iommu(struct amd_iommu *iommu,
  * If a device is not yet associated with a domain, this function makes the
  * device visible in the domain
  */
-static int attach_device(struct device *dev,
-			 struct protection_domain *domain)
+int __amd_iommu_attach_device(struct device *dev, struct protection_domain *domain)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
@@ -2325,7 +2324,7 @@ static int attach_device(struct device *dev,
 /*
  * Removes a device from a protection domain (with devtable_lock held)
  */
-static void detach_device(struct device *dev)
+void amd_iommu_detach_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
@@ -2639,7 +2638,7 @@ static int blocked_domain_attach_device(struct iommu_domain *domain,
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 
 	if (dev_data->domain)
-		detach_device(dev);
+		amd_iommu_detach_device(dev);
 
 	/* Clear DTE and flush the entry */
 	mutex_lock(&dev_data->mutex);
@@ -2717,9 +2716,9 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 		return -EINVAL;
 
 	if (dev_data->domain)
-		detach_device(dev);
+		amd_iommu_detach_device(dev);
 
-	ret = attach_device(dev, domain);
+	ret = __amd_iommu_attach_device(dev, domain);
 
 #ifdef CONFIG_IRQ_REMAP
 	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)) {
-- 
2.34.1


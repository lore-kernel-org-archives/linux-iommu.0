Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20026327798
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731952; cv=fail; b=Qi7JB2/+wcC80b1WZjsIsKecI9JV7XampEbNBNALvyTEvWYWJupeweuUExYkUZ2HJ+ppWCkQssnuFBiaoEiNDGwnIuD5C6DddLkvdMwJcCPugIm9siyM5brHRcX3GTT4B/aNT186ZcRh2fPp9vAAHzATpsU484B5QeZYg93DLfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731952; c=relaxed/simple;
	bh=MWmOr0WqqhYF5AOrZOhzm1FZXcaJfePjG7Rq1VtWfGM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZJLZCNwakay/QFqiNS1Z+REuxbAvPF711j+ZY+PYSqaFS6Gh5F/ydA0yVXgw6/wvn79GKCAKvsm8pe1jmOiPmZc1Qyr/esHulmcUDPhcsiV+oqQYecVf6yRM6oehcz9t3XLkLy6X08Mcrr8ugMNudutpDr9KvEuFLnLHCLD4fRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4E0BNLTW; arc=fail smtp.client-ip=52.101.61.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4E0BNLTW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzEyZG1CqOCAVIKTA2WssGZ2Y1k3UaGqisDszAQJXr8itxnZiWPSEwfPlfPbUd+/5wJzPW9u12b2Mm45J0GtOyi50ZdIrIjLs9YRMro6JUeAYyzc8FQ/UCvXk2OhtY0FjUH8Kv2goqNiPigCQtDcnIScoG34/U7qx4HyzUqzaN++xV9m4uM31L3P7z9PxYcQwq9GXRZVBDfsvJJeS3gvyy/kg+6Tb2OVxiG4iH1R5ki+EWjSTAeCIeKAtzsT62BkeYjcpcJH2N4CLp0GLR+UFHEeS0eVzdgjYUaNzkG3eoflfg2LzwBd9VJQAloje+SIOA4y7mkWWlqaVyVrS6uSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4F0M6j1g6EAVC3oOELlkU2ZLcNeNNPitHFL2kJZ2/Z0=;
 b=sqoq8j4T5akw8PFY5Ybqra9w1Cv2XJiA6tAAAbpG1KUAto6kPCkOR/4AbnvtpiATqi/f7Jb3Kqvk16SJ4KS2YfTZ2NibE8jf4R//FHgvSB7N5HHwJok97rudK8TsntBCkFvmJkwgeaCVJ/DQa7fa7bJKhvZoTHOGLdnR33DGCBLF0BBS5FIwwu6fArjTRzYfLISmfOFNQQ0jqrkDD9TR1Izlp/8oiW0JIlzgqlpAwFOmVENAvzuWotbpM9U6qvBq0OPljct9WT+SS4UWFF8cALt8ux53plFUMdF49E+zhECvsaxQMK5m3MzHu+y6HQjNsIdvrLEot/ph48/rq7z8cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4F0M6j1g6EAVC3oOELlkU2ZLcNeNNPitHFL2kJZ2/Z0=;
 b=4E0BNLTWGrnep/fALicFMZDpG3rWbLkJE78+4XIyXYpzfcTiT9jYV14/QQQzC+WOPtfTaHg0aitj+0ZolKN7lzyNyNwl0df0QRjd7vCG7VzkJE5g5QCQSm/qsSeWXOinh5XMwyzjIoyu942xe0K86sO9hQmffSowhoidGgYufDw=
Received: from BN0PR04CA0168.namprd04.prod.outlook.com (2603:10b6:408:eb::23)
 by IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 09:59:04 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:eb:cafe::52) by BN0PR04CA0168.outlook.office365.com
 (2603:10b6:408:eb::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Wed,
 29 Oct 2025 09:59:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 09:59:04 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 02:59:00 -0700
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<vasant.hegde@amd.com>
CC: Sairaj Kodilkar <sarunkod@amd.com>
Subject: [RFC PATCH] iommu/amd: Add control register in `struct iommu_hw_info_amd`
Date: Wed, 29 Oct 2025 15:28:46 +0530
Message-ID: <20251029095846.4486-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|IA1PR12MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 39fb947e-3a3d-4abc-0061-08de16d1cb1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1FAKKtx0O9B/bciyLTc6pQ4ezHg2XuJNEiJRHS/zy36iuLY0Y79NTGiss2cq?=
 =?us-ascii?Q?wZ8CYE5Hxy+ufY5EOlkIViYo5rQ2ue2+npUdr5lGhLaMkNzEqM0TBu1e77df?=
 =?us-ascii?Q?61vQqfQFUtSftrBSjFOhfQgUJUwB+g1vqH+cKh2pGXHW6H2fvOMSrJgjZHxI?=
 =?us-ascii?Q?Wo3aL3/q9ekwKrJ2eeytKR210luglbEcqKTU4huy3tFKLDKlAsP3HvmuySRL?=
 =?us-ascii?Q?IpqDExm99P4RHCHJVhMSM7y3IQ2VuvLikB9ON3+FTl8UMIHg/tccP1aIcSfL?=
 =?us-ascii?Q?JEeHcaj4g3P9pYU3KlPDxvH+ExBd92laNsQLdVXVkYqUTU+qhsR5n/IJRo1b?=
 =?us-ascii?Q?tj2jRRPJZs/X6Cu/nxt5P7eDLsZnuzML4eSjAdQ0jdu89vd3uDiu25J2uPiN?=
 =?us-ascii?Q?0jlVeaPdw+feOBxpsNnagiBLhX3Y6w+4zk9gChorK8RtKnf/M7+yc+fBFURj?=
 =?us-ascii?Q?iqdqwflXb6ygK3vJprnZxTjlO4TsLZ4BeIsXw9x64grqwFn8i0DmROgPhNcp?=
 =?us-ascii?Q?dQ25olkYVuMO+y0qsweNHg8qZX8+DeZ16xR/Xvo3KKfQRfznrDLbJg2TkQzg?=
 =?us-ascii?Q?h4J52rO34/TvjK8IKVPfVLHv+S/OhxnvwddAjctQTW3iq9miuRDWNrV9kGsG?=
 =?us-ascii?Q?EV11eIt22TKkaYBDiLrf+d51MEKS7U8GkQVqdCKywj2t7oi5BBX8VfmOZJoj?=
 =?us-ascii?Q?aj9VNGDnhR8XPgP4RJqKXuAJXmEn4Zae3BcFlU9fMD4ruI2ERI+t27rg94XN?=
 =?us-ascii?Q?WMKzpQ0b5xh/fLa69bQXROmyA/kNzDncRtGx2tixW2mDk40WQczrLCmKNu0z?=
 =?us-ascii?Q?td5pFfCiJaZcHAOgcd39vhqoP1yaohRYrCYvusPmKM/6w8WtZmQDT1JskG6h?=
 =?us-ascii?Q?psAk4RK6IEMEVqTugvPYi6dDy2HPelY49Nb3GE9wIMTq8+2w4ePXZpcdwB6w?=
 =?us-ascii?Q?0b9wmY93wKxbfOIZclIPv6YIufcHxEOQ+SF04fxcTEX3/eb9XLkb0z2EKoLN?=
 =?us-ascii?Q?JezG2gdFYoNbJYB5aVL3M5R5VCy2RsMCiiXEjNCmfiNKCNlf75iT1ycVli/F?=
 =?us-ascii?Q?VLDWG0DY66GaU2PZcI9v892iNSNoXh6BtYG7JhbEliQeWlo5ani6ryLLUqRo?=
 =?us-ascii?Q?sw1lCm+BcydVZqeX6kqVEA0f2JB7Vp6v0wo8qMpW4cNCzZ0ndzrVYT8rySbB?=
 =?us-ascii?Q?Qf+Y/Jl7czkDzT6Qo4DF8jI1vH+4cF4/CDHz/0d7nPvYyyK0bRb1/saNK+jL?=
 =?us-ascii?Q?VL2bx3dCSjm1xyqJ+JbqjSRWFKGRAe9ZefFjx0dQsEC50LS0QomT6egB6+J7?=
 =?us-ascii?Q?p9w2SePyM8bhy9EmZVKZaw1iwRDauB944x6QzuBHz3EhjyT6/hfFov/dKzja?=
 =?us-ascii?Q?6/rWq7O5+lrHrOEnoZOT2gGN3R0eYMMCjxIEYVZkoe/P21IiK82V0JtQ/Mr1?=
 =?us-ascii?Q?KUjhPfmz9szLc66xZ3LdA/gOqsNLcBKqbdX5SalMMywGn1jrWj8Q1STz+Vmq?=
 =?us-ascii?Q?WpbxV0D9vVesF0AxDm+dDg21Eyyfc6YvWBfrD5dFcN/Y0z9YPO5ognJTbPqn?=
 =?us-ascii?Q?gmRUXFaI37E6sIByQTA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 09:59:04.4495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fb947e-3a3d-4abc-0061-08de16d1cb1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8495

When user does IOMMU_GET_HW_INFO ioctl, read the IOMMU control
register (MMIO offset 0x0018) and return it as part of
`struct iommu_hw_info_amd`.

Userspace can use this information to determine the features
supported by the underlying host kernel.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---

The patch exposes the control register to the user space so that QEMU
can determine the list of features enabled by the host IOMMU driver
when there are passthrough devices. QEMU can use this information to
selectively enable the guest feature. One example of such feature is
enabling upto 2048 MSIs for passthrough devices. QEMU must not enable
this feature for passthrough devices when host IOMMU driver has not
enabled it.

The patch is based on top v6.17 (e5f0a698b34e) and patch [1] by Suravee

[1] https://lore.kernel.org/linux-iommu/20250926141901.511313-1-suravee.suthikulpanit@amd.com/

---

 drivers/iommu/amd/iommufd.c  | 3 +++
 include/uapi/linux/iommufd.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 72eaaa923d04..83f34fc77ae8 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -12,6 +12,7 @@
 void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type)
 {
 	struct iommu_hw_info_amd *hwinfo;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 
 	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
 	    *type != IOMMU_HW_INFO_TYPE_AMD)
@@ -26,6 +27,8 @@ void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type)
 
 	hwinfo->efr = amd_iommu_efr;
 	hwinfo->efr2 = amd_iommu_efr2;
+	hwinfo->control_register = readq(iommu->mmio_base
+					 + MMIO_CONTROL_OFFSET);
 
 	return hwinfo;
 }
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index efb52709c0a2..9435b2d877e7 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -637,6 +637,7 @@ struct iommu_hw_info_tegra241_cmdqv {
 struct iommu_hw_info_amd {
 	__aligned_u64 efr;
 	__aligned_u64 efr2;
+	__aligned_u64 control_register;
 };
 
 /**
-- 
2.34.1


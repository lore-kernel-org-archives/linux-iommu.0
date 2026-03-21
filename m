Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8770023D2B1
	for <iommu@lists.linux.dev>; Sat, 21 Mar 2026 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774133494; cv=fail; b=o0rddid5h3xH9H8OJ6F2W5zVjbimkDDvf3Nav7FRjen7S2Sx3FYdrCxYZdZ2c9uJV3d5zQu46/u5UDpPe3aGTKuLMQVqfH/ccMh+B8Ve8+IgPQPuj22J4SGb4YjdO1bOTcEwseXBiA6gVfznOot9wYdSY9wrL4SxxIhxM04Jg1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774133494; c=relaxed/simple;
	bh=bmN+BqYE7fG+QrxMrUrn3NzhVzfQRZJ1Dx+teS2NVR4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T8ljkwzAQ9VBDAA8oNXNTONooHBSPJt1GQp70Ot6i0rp26V2uSpf3OkLj3ca8q4KQgHWAJH683JbFMW0v5do7ffqFBdZEY3/9OMLD7IZxWqMOaqhF613alnemGZeerBnVZlOLjHixpCax8Zk+igBPCwBPZeEjV+MOAAXBMp6huU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FyoWXrxo; arc=fail smtp.client-ip=52.101.46.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FyoWXrxo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZWVncCRz2Vx39hFM2U7etW+sx/u9/jETReU4EHEwCvZNVLAnqJKIrMD3WCu6PAQyJ0aFFzYM95/wRUPYzLLur0HBtq89mxv5V8CL5z5vy5kKDJTIRGjXKo9I9JYddUyikpd5Yv8eyGWV1ruosYkG6PrviRLqkqx+O4atR6db6jc6mBc9kZVfwigFAgK/37UDxG4M6gTSI20qMSmTjSuw7+nlOnfqPKKEbGu74LJxk9rX3hd2m7+0UXXQDjpQ+eHMhN40ARPlQCyezy/k2HQd6dCSXrKFTOdolsxZjhpy51/V8yVLQDwi7DecNshxOwseJgzjye4vsIy4blKMjW52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkO/eZ80g9qwziRG1uf8SmceLZEv0aN2pjVx8Vtoud0=;
 b=G90cYIfYOVUeST+aFwsVQIVdukFToHshdDBTyIq4wh/UZ3fAHBWEluBpMaQf632pwfuouHGDLcXtzc+oNCHJ7Lf6C5VxYkB2XauSR84rZPw8pphWwcTP4KZuZ9oSc+YYykAPEKFX9nJeKzBHMDr1ZF3D16FCufRQgNTw60s24ksrrTQO7ujLqtKU737BgapW3C/Q/+oNRXkiqrcxsjsV8onIXFc2p+eGSDgNAkkM+gje9DqXku+PiWuFPJ/icumQ0CSRXzXPOQVLcYV2WWbr6wWb7AibyWhQKk/wNidtI18ng7FrpheMNS6k03Z1D5SGQiTaRa696nGRA83mgmSlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkO/eZ80g9qwziRG1uf8SmceLZEv0aN2pjVx8Vtoud0=;
 b=FyoWXrxopve/VUvBK4kbwiXMg5nDzxYCJODK+9wsXjx7sRTnAyApzSsJQg2lDUSfcuYYj3kaMtDi0SHx9NwKKx6u/GF6mOsAjxHjMe6hnDpN/cmtjr8fgGvuMjtHp0GubP6PLrau7eMiPCOFsxd1y/m2onjCdLF0R/5Wlr89OXAi0joO5lo6nc6v8jo4E6anyz3ep2drdmJuI7WH8JMIEgOOWgprEx2lQnV0X0CoH8dUWk9MBCjOMiovOjNpMLYAnB2t0MMPlXN+Cm6+d7KsRTfWO12UDJJ4SiTsonqL96MSWy//ReVmHxb/Och8xwA3o7+F+1tYyWtp7CGHUjnGtw==
Received: from DS7PR03CA0101.namprd03.prod.outlook.com (2603:10b6:5:3b7::16)
 by SA5PPFB9BA66B77.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8df) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sat, 21 Mar
 2026 22:51:29 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3b7:cafe::b0) by DS7PR03CA0101.outlook.office365.com
 (2603:10b6:5:3b7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Sat,
 21 Mar 2026 22:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Sat, 21 Mar 2026 22:51:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 21 Mar
 2026 15:51:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 21 Mar 2026 15:51:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 21 Mar 2026 15:51:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] iommu/arm-smmu-v3: Fix bugs and typos in arm_smmu_invs series
Date: Sat, 21 Mar 2026 15:50:39 -0700
Message-ID: <20260321225041.11090-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SA5PPFB9BA66B77:EE_
X-MS-Office365-Filtering-Correlation-Id: 55650d7b-612a-4e0b-ed85-08de879c63f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bwiw8ig5waji7SQwpGKsfubNzm8TdMCXV/hTh8KOK2qQabQ4thcuYUDwPNArFqPqcR6jUHL768RvjAnEg4jxj3mKyaWKOxYJUGfZrbKuK2zyF3uBtFASzLdBqcLhLMZJHFiZGEkNgq48j1KPPWmS0mIVkOapdxEEnH5/3t2kbCx6THtay2/h0KgYASN2s4f79MIx4Z+WPWdCpaVVJZ0bySY6kC4BR/JzwkpQSgo6Hpbd7DgI6+euGOfY9WQiGCTL+LdCQ+DkdFWTK6iA3bhiJZQHU6dOqxT7hDlp1mqE5VGxWGa798aSBEJFxd5twQtTW/UfefB55ZjjHcVO+MPYivTumg9yGxhM2OEjik9LaB2Sw0psfiBYjP8ZrLZePcy8RvOqsx9fzvq8RYzK/GpTYFaGBKMIK50alwUBUvjt2HsjEEMNeFfZ5CFe9OFveARGECP+MW78tZq7U5MxbR82rA5WEFlrsJkhkh+rwtRFXX2vZP3ngN4G9X9s3LwG30zazJAnmeUpiNfhD7qElV8i1fHJHck5m6PZilGbQqKgvaxgYdtmDArngExaSjYx9n6VmOiQMNATSyFOLMibNQoqDKJ2AUWtJTINdirbB2riiiCeb4TzPLS+XkTO19WqHGd2Oy9HDC3BxdZw7M72OaNMAdmDLJ75Pj3RL0Vh7217JE0YOP5NxOxhshIfnmDgNhSw2P8fiuuwlAydUOiwu6ohEz7xjmkR6x7Vd+wfIINoRVv1UVNhdIB2we9Ken5+nAQmkfB8WOqYpdWzhgk8pcy1QA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k2yMq8d/59QBJy7rXOHs2Ums5t2TW+vvqHgraABusL5l7MIigA7ho7VBERN/CvvoYi8DHfjy2MTeRxgUUrDYZp3bahORGUR7PWPGoKXtm6lSYU5tgZpk1Dt+iOr7Q1JIG6ze9LopsqWL26riArnCXfFHHcTmtDpeyAXhuunHyp4Aty/2w4UrP1qk8uJauE5LHJrwPAtlbvAbHvziFuvMZOJhrttF6S2Jqn7gE2I6feR9WvtltoF66qjzyjm2ZRXMbaAtlaFKUTYPQfnV4mCGJkGaO4Bf+RPKTfvk9DMacs4L2UACPt4WDksLWc5Ou19HFX5v4+re9RYYklsbdFojZhPk9ckvOu1LJrp6vu+ddPv6Hpxz3tjc4bxdC8XWABSKRupWBuxjZINOrk+j8261Lk0Jov7ND02386yFzrdZJFWJViK0qKGI4awV8djh2Dd8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 22:51:29.3145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55650d7b-612a-4e0b-ed85-08de879c63f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB9BA66B77

Hi Will,

Thank you for taking the series!

I found a couple of small issues in those commits. And here are the fixes.

Thanks
Nicolin

Nicolin Chen (2):
  iommu/arm-smmu-v3: Do not continue in __arm_smmu_domain_inv_range()
  iommu/arm-smmu-v3: Fix typos introduced by arm_smmu_invs

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.43.0


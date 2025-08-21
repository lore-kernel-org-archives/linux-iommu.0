Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92D2D3A94
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 05:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755753849; cv=fail; b=Jeksa0RV33/63S8CrKViAJILjqZRbmsg1EN8ZqnJoIViGpBv7HicI2HnMxsGffiaQD4XJEFgODZGDGq7cjmmuPUgLrEy2LmnE0deutmmUqxoggLG5onNlO7MMk1NxekwK4HwvRS8gVZ26b0E+PRsB4kmL0mNLSrWX7qa+B6r/2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755753849; c=relaxed/simple;
	bh=k2Gts107ghKFrzGRZEwkkfxJhXhmQeQC2SMSfwoDZPQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfB9Mra46fmaZhnXsI3VW9w56uQJftcbzQPVfQeyYYkPxXEW+CJpzzAxMCdhSLZZd3PU+nz5obBge11Gw2UUetP4p+pPMU8XiZrwcJCS52WqTXH9uHfjknEhiTQtfFZAQJVfE8FkpEiZCnbhCtfJjJO1AiWfZX0WOqOXZPdxags=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4qqx5pjk; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4qqx5pjk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8ndw0CYuoAuMyNFUiS7FrPcXGzhrUcvqe3n0pJ+zjY7ZCLqjVm7IQg4eoyPod2KDZI5f9ntgJsNAmQAEjKahYgT6K2XBgBRKN3pcL0YWbRFBRL22/4ObW/vp+FkhLShVrnLR+aX07fA09rRk6Pgkj+2vai2fVrC0l6yRuK512bY8ApmmwGO7W4IFIPTRSjiPN3tFGSAvXNZnBd89bBI4oi56C6dNTiE3gpIdFP/LQOVM/X1vusiHAzvS+QUUHJ74hVH55xETIEVNZe2eDFe6twRK+wW+KGMDVKv+ApW+4Z2RmK5mseJR5aaIPrn+SMXaqF+HLsT1nkUvXsk1zXwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYkC079gJIRyqWSvV/F2cuot3vItD8khVwFDuLMGWsA=;
 b=fwmjukLHU4ptbPm/1wukMS4gQrvLK0/LsDZlSUQPshi5D5LSxYMrvI1u/8ldbktudx81iv8K3R9SUkUix7f5wiBJkXFmwkzn3sQPq4hL8VOF5SnwpIzUwve1TJD4LX1+YU7F2PhjBJixU5BadO/uWK1IO7BosgNODofiJhdqNhjNRuNLX0hFKFxAE6gcWzXecMz3sqz1/zpG16c9jClSTakszwR7zjgw+dmmJvPXKBCv+iert02ysvk2sV2H3H2M0dqYIpRy+eejBQij1OtnzwavQlQPk8rawtv+gx2m2/lIOKGD201bKVerrIT39phDpOJxJ1wqR3WE8rQu9eug/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYkC079gJIRyqWSvV/F2cuot3vItD8khVwFDuLMGWsA=;
 b=4qqx5pjkgxxO9QHOqUSgS5itWpHY8bU1cTdI91laqVCtzdUuausI1igf+2QKuz2IdIDy/Eb6y0CK0UobApG/uqn7x0pgPqVyfzaH7HFxSCS1v3625DvXP9tRR9y2Td2fhFQx4GveiLAHtRsKNZHYBY3n+ovYH5VG6BlIWJJyzrY=
Received: from SJ0PR03CA0279.namprd03.prod.outlook.com (2603:10b6:a03:39e::14)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Thu, 21 Aug
 2025 05:24:03 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:39e:cafe::8b) by SJ0PR03CA0279.outlook.office365.com
 (2603:10b6:a03:39e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Thu,
 21 Aug 2025 05:24:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 05:24:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 00:23:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 00:23:57 -0500
Received: from amd.com (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 21 Aug 2025 00:23:55 -0500
Date: Thu, 21 Aug 2025 05:23:50 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: David Laight <david.laight.linux@gmail.com>
CC: Xichao Zhao <zhao.xichao@vivo.com>, <joro@8bytes.org>, <will@kernel.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: use str_plural() to simplify the code
Message-ID: <4pryydyzfpvb75mityltxvj6blfdcvsdngwmnzprnqjlldhxog@kpsf5mx3coi7>
References: <20250818035331.393560-1-zhao.xichao@vivo.com>
 <20250820190359.2680af50@pumpkin>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250820190359.2680af50@pumpkin>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 74948836-a439-40ce-6df1-08dde072f0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZUXdFZRzEaiJrMANHblKNzJ09/6+pG8BlgpLdL1ENJVBo2+kxwGnxhdVGV4u?=
 =?us-ascii?Q?Q0U5rusrzey7SlP1jOcnCVloYDGHEgBQwSUjQ6p7kSy3mKNQScev5k++hesn?=
 =?us-ascii?Q?j2j4B3Q7QCd2TZEF8OC0d1uTqyoq+bgTjXf4Fe8eXWT6/rlIADhbJxLYF5aU?=
 =?us-ascii?Q?vOGmOOl0wdjNMlLTfKFXgHxq2PJZX/rE1EEmhR3kwsDTGt5DbpDmNBz9zJnK?=
 =?us-ascii?Q?bSRbjkaeNJODtcpUEXYx1cFeO3BxISDSvvkrfTihSuD33wKUUGwBE2qLy0xd?=
 =?us-ascii?Q?zye0slXc50hQ+wesfV2F6j3SY1SpSAnPQXv+Q7v3FdVfJtSW5czA+NmO/RoW?=
 =?us-ascii?Q?KvsXtCoLshh/i2CRckZpNQfK1qqRu0ssxoL49YxFv4q0RM9BqFHYuZflEnhb?=
 =?us-ascii?Q?QIJhIwzipgvQm9Hg4Sx3ioV3HwnbRuv2VPDm2SCXXgasAja4SRbxB3FW5RCl?=
 =?us-ascii?Q?qX8YR3UKRG2+wgGEdcb9mpuAt7p43oEsVycW2FGxIRFI4cbV5VP0/0AhsSWt?=
 =?us-ascii?Q?1s1VZdcJKV9qKG04wjo3PFGbzKj3Sff8+vZVs1as62r/IDKJX4y3v4E8EBkL?=
 =?us-ascii?Q?n+gUgpzSd7hzae5CP9x8HPdMvcn/56jxLIDdTA7hxYb/GqkTRcBlZAtrsM6p?=
 =?us-ascii?Q?gbkmnssDzm9n27bk+Ed39DLsu3YZN9G3Q/y8hAnbRQNyr/94tP3Th+C3Lu7f?=
 =?us-ascii?Q?+DmZavN8Olw6Xmy/sG5OpO/KlQYQeKk5UpkXXeJtfilGB5WdygqJVLg7/usL?=
 =?us-ascii?Q?5QbMXOFyzp3oTPj4b4fdTemPnkZA05c/Fq65r2r8me+12rZQos/mAfQt7OLj?=
 =?us-ascii?Q?1cO0nxQWWlYTDe96iI8h7WWxWDZom/C/oh0K56W27Dp8B9s3x0nFRYV60GYq?=
 =?us-ascii?Q?ecVb7u89cfHwLP9hmNg6RWstaai2eEcCIJOgnKZ5Xds0/t+5VaO1tUTfgbIb?=
 =?us-ascii?Q?E1c+8Khll7EJdodXFNiqkoO7n1zu+WJ0tNjx1Zd1KTOgwtXMcElpSkf6WQkc?=
 =?us-ascii?Q?oHhxDa6vqYyYhwc4qm/bm1fGbtpuUi+BiNKYMLGrgnvgQ3X+DtaTeb1GyOrW?=
 =?us-ascii?Q?N4KO4bhexFoEmGQ/uKuol8LtLJAbCcVQAAISuRIJjcwOsYahjgVw/FnXAeo6?=
 =?us-ascii?Q?guMMNjPB/g1peZujbttBpFdXSxut9lg+wqWuWTeVDv60YfnaPnq9nbcjk3MA?=
 =?us-ascii?Q?y312s8H1tye0D7RO09pwNly3tkoFVZ92Qsa5jn7gVei2oX18dSpzvePklUYh?=
 =?us-ascii?Q?zGZ2c7sBlieIf8viCyVs1hkXNvNda5Pvd2+FwySD+8HZ8u/YDBS5iYt9V5lt?=
 =?us-ascii?Q?/OwCd1nLlyXYZeoJIGk7oEHJME2N9uG4WDCLizOQSNy91jaseb1p7+NN1w+R?=
 =?us-ascii?Q?eDg+T+EoUaUNXpCc7Xpg0z4y4MRltSUYjClo7eWyNH5qln0cjt7uCYtwfrdQ?=
 =?us-ascii?Q?7pTMyODx964FH2vFNoeoobO4mfNeRrABDAsYMiofEY3QlDI9oGg9XrfxMGWB?=
 =?us-ascii?Q?gMz5V1t2CDKHM4qSi11lJ+lMM4eXsvVKoS/i?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 05:24:02.7327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74948836-a439-40ce-6df1-08dde072f0e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318

On Wed, Aug 20, 2025 at 07:03:59PM +0100, David Laight wrote:
> On Mon, 18 Aug 2025 11:53:31 +0800
> Xichao Zhao <zhao.xichao@vivo.com> wrote:
> 
> > Use the string choice helper function str_plural() to simplify the code.
> 
> This also changes (maybe fixes) the code my adding "s" for zero.
> 
> Although I'd define it as ("s" + !!count) - almost certainly generates
> better code.
> 
> 	David
> 

Hi,
In case of hid_count is 0, below condition (before fw_bug check) will hit.
		if (!p1)
	                return -EINVAL;

Apart from this, i dont see hid_count will remain 0.

-Ankit

> > 
> > Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> > ---
> >  drivers/iommu/amd/iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index eb348c63a8d0..b5c829f89544 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -265,7 +265,7 @@ static inline int get_acpihid_device_id(struct device *dev,
> >  		return -EINVAL;
> >  	if (fw_bug)
> >  		dev_err_once(dev, FW_BUG "No ACPI device matched UID, but %d device%s matched HID.\n",
> > -			     hid_count, hid_count > 1 ? "s" : "");
> > +			     hid_count,  str_plural(hid_count));
> >  	if (hid_count > 1)
> >  		return -EINVAL;
> >  	if (entry)
> 

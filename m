Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24BC36EAAC
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778313433; cv=fail; b=ikQaHO/Q13swptA9sSkgQofUpBMNzHt/PlbnPC1lnGBss0hrKGz5Ry1F0ofWVhzDqvt+oyN2oyFdtJA6o8Q3tNUDDb7/VpRVUIQ9zYfEf1ewsg1tyOWW21UOlReT79w6ZVqTLwDsTCpwOM8VU3ESlCh047nJrxQtesJZEpM3OPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778313433; c=relaxed/simple;
	bh=v8RgBnAHPwlHgBlirD4+KnTBXUcVrkGYWbl6Nn82oBI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzR3awEIvihCdTN0HAeWdWQ5nzEcYYi1ZwpkF/P8f3r95Ux+bixb2MAJgB+nb5ewg/FmwiTjKnAPJaNRP+YyHH6BloXvrKUJpm2wAQr0KBYyJIexcObPPiYYQn03J+DHgQTh4ipJUh3XXpSAzKZrmmEngDGtuqVNPpWqaen7tP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lIFYhxLs; arc=fail smtp.client-ip=52.101.193.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lIFYhxLs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCVUZRrmmXVH3Meg2+xzxW4XAkGQiJtfcNeO4BBPWX2pEuI10cT94ELzlGBgAY1S5nLqvlSE6c3tLo7DSYZhapuwYaz42/8dEDipzBlwLwR4uBuRA/Ntz+KA503cXZm1kf5iYa++OO5YW0lyoQhUirdgg4rX/YuoZulEJoQG3T5w6SXghzgZDKcuEm8fqnEvbn9lryR2vYPM2qtvYukGkhVlS1jLoUkomwvB6/L8bMwtu/U21nZKEJCYgp/lpTHDBMBW4NbLjuNgVlmBL/vEKDCZmxG90zq4bzmgclQBMNuqs2eN3BMbX9GE/XhzlIb+piq0F4hr8uheJnRdGf3vMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lkOiepyYlP3TaQHcCBGEDX/5OsMKncJfTredvP7UUA=;
 b=cVH4CnpJZXaXKZ1Bt9VH8Q1vuQu2dnm3iUwVc+VdFa24HS91MoLmyhBZncMo5TCFZ6b5BQwtUBPzy41uVTuoEZEmuAYhJkT4ymvs+aLBHOae9UWcWw8Y3WX3jLEwTZILlZBKlQ9qayBp543we9yU6eTCRVtg2wv3kDTkkVXevKvk9MOBzQkpN/VO1V85TcJcNbUcwt0CFC54ruRW/n3wAnVUCa7aU1oIvW2Ff19C67s9br+3pKagUacx1uzqNB6uwGcwvXS4zIZc2O6dFvJmrWnbAk7cADZ6JiZVRWi9yLBRhEtIcvj0dAj981G5+Oj2fhE+zywNv6Vw0F5Rn9CdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lkOiepyYlP3TaQHcCBGEDX/5OsMKncJfTredvP7UUA=;
 b=lIFYhxLsbW05tp8nmNvLn333W1FwnwilEKnj0Ni8lxDjx8AKrUW4h/Tyo0KrDaGRdHd92V54gxEAO1+iHNg8c3XMmY9spnqa9kXL5gYbO39r4N9R3gZSX34TvxbHrg1l9JB5gDYwkgSv7kBpcNkeSgVpZYbK6cUArxtU0dwi4Fj/Q8KYZ6EQy+G1QffUXuXHuORQABDrFu1okRFcqRz0DfWcv7uzx31vvKxAyZXgJN8BnZBuJbdSQKb/qw9GWNMHbX8BfWPQ0HzqvQDkTPN2R4/Qi795g32dTQE0ND+qbi3YSMfg9TWHNtafrBrZq2uDRtbkrhNvXqGA+WvtWptEyA==
Received: from SJ0PR05CA0190.namprd05.prod.outlook.com (2603:10b6:a03:330::15)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Sat, 9 May
 2026 07:57:04 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::7f) by SJ0PR05CA0190.outlook.office365.com
 (2603:10b6:a03:330::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.6 via Frontend Transport; Sat, 9
 May 2026 07:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Sat, 9 May 2026 07:57:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 00:57:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 9 May 2026 00:57:03 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 9 May 2026 00:57:01 -0700
Date: Sat, 9 May 2026 00:56:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, "Jean-Philippe
 Brucker" <jpb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Enable Hardware Access and
 Hardware Dirty bits
Message-ID: <af7oyeleKFXpcIKu@nvidia.com>
References: <20260503135413.1108138-1-nicolinc@nvidia.com>
 <af0SdkjQOZxnnaQb@google.com>
 <20260508123550.GB9254@nvidia.com>
 <af3hWGp3etGOIdEn@google.com>
 <f31043cc-45dd-457f-8031-0cef51c9470e@arm.com>
 <af3ryl7G58D2GeWr@google.com>
 <4e129891-2f52-4bac-8e33-1fdde42fd29a@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4e129891-2f52-4bac-8e33-1fdde42fd29a@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 323196f9-3706-4de0-6b79-08deada08f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	rIJ2cpXbwRu77OwzwRp8LdaamKLfHiO7h9EZeFXiUwQiAkhzU052TCHTDmHwR0AvLAKEgjYWzlZWoDG02aDsgVH9VRVV3F0PcGW6vG/pvtc7dZjjgOkJQUxYmMf2ntw+cUg71ABdflyOWZusshurPGsm2aYbiVpefgri/Jfs5swyQLdPBBZaiO8rhOX4nDmiGDHrqOGOqO45fWFUMfJKYTqBJ455ncu68qu38F5QBYSdK8OokVsr+I+Mmo/t3MgUwvfy+2XnVgS/10PKBvQfoM9Yw5hRMVuXJZShMMxAwBRjGQ2DHj2LftzkmSDAf2BSVDFg1XRRHjmoJ3Yl+KnP42k01p3+2C+iKG2jBYO2a+VG+HCtm0prhdrZJWcugmjWx8x1p7KsXskxDwPFol9jGMYErxur/pLqQH2sOCSAeP4rVrOKWTjf8NgpUU/TwvPhx0XVf1uX/A79BGbgwwtIEngIW9S3f3p/5hbKC+jJM2d3NnTHBYAfNfVXDa28lQm+bZMk4+Kc5TWH/orTIQhQGMF0/NwlMLRWzu7/XNgkYQMp68pFoyCMtJwetxxKcX+MxERqUO0jYci00y0K5cAzJ/cehT8VnEm0Zx5hug/TcobBFD46Kow8q28mAhn9Mr9V5H9wCVm0p8GpllFjR+YT+9SclmoizXQh1WiAP1WXsPfhDNJcOCrAnveaKQovtP8KdOpqXqcUi0x5AbgwbFjvTRJZk7fTsPTw2KSjE3iudTw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ic8fvssMyVnfYIulZp6ccENlBGL0HNFvRaGLxqA2PxlCPBhQdMa8RK82JKpQ2uizYGI9N+lBKxnpjw7sRlOaJ+9sjsHhPf8mStDiBhjq/w6fjn75S0BCmtEH556SOgxM9vGf8DQM7DefgU8JGpMsLfKvXkCb+rPcrBTt5oLYm+t5/6ec4C1BtMWKBEbn2L4BwJ1mnvno+qHAfEp+1mnNhyzWXCre4a4TsklGvZJ234hqQpHepblJ0puMdCw3FobzbH26Cj2JKX15jB08Le9FNuoSkUdF9ySG7m2PW9ydR36br2O0wDafKbsbJ6UDC5y2zbCmH0H4ogXiLu5Dy6RcSEg+XJtBwKqfXy3OCZlcCeQo+cepCHY4U8m4yHz2R8jznvWJ1EjvvTWXhWsU8sykaRoWlapVE4/ghQ6czsi09ZFQxNqBg+h83DvOxZzkCEmy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 07:57:04.1537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 323196f9-3706-4de0-6b79-08deada08f2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064

On Fri, May 08, 2026 at 03:24:32PM +0100, Robin Murphy wrote:
> On 2026-05-08 2:57 pm, Pranjal Shrivastava wrote:
> > I see, so IIUC, you mean if IS_ENABLED(CONFIG_ARM64_HW_AFDBM) but CPU
> > doesn't enable HTTU, it is perfectly safe to let the SMMU do HTT updates,
> > Since the fault handlers are already expecting HW-triggered updates?
> > 
> > Which means our check would be something like:
> > 
> >     if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM) {
> >     	if (smmu->features & FEAT_HA)
> > 	 ...
> >     }
> > 
> > instead of cpu_has_hw_af()?
> 
> Hmm, looking closer, cpu_has_hw_af() is the thing which actually influences
> mm behaviour (via arch_has_hw_pte_young and arch_wants_old_prefaulted_pte),
> and that can still be false at runtime if ARM64_HW_AFDBM is enabled but any
> CPU doesn't support HAFDBS, so perhaps you were right the first time :)

IIUIC, v2 should be:

+		/*
+		 * Enable Hardware Access and Dirty updates (DBM) if supported by
+		 * both the SMMU and the CPU. It is unsafe to enable SMMU's HTTU,
+		 * if the CPU does not support it as it bypasses mm page aging.
+		 */
+		if (cpu_has_hw_af()) {
+			if (master->smmu->features & ARM_SMMU_FEAT_HA)
+				target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
+			if (master->smmu->features & ARM_SMMU_FEAT_HD)
+				target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
+		}

Thanks
Nicolin

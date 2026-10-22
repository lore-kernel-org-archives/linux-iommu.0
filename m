Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792682354;
	b=0fF+LDKfk9wpd57dtKdlF0h7ydUxOnsyL7+0J+Lk1JY6MdMBvpjQNS3TdUq4GUOSbuaY
	 cMixqMy2X2IjP4cZec7/f3t9+uY0BIvN7XM7bhKr13uRE3sCA2HtyBU/YSFhEYQMQRIVC
	 36urLfl9PBeEIvmi3x319DGLdqSKKr0NaLLMSQYuzo74k3C0t/oqtr8fMlPjRwoDNgZl5
	 Aj4w04qx2mLA9X8yEsnVFwishGNtSnKTDcVL6djMrMyqZCDOSxKIGlRF8MTkvBvQd/4Dz
	 70gr2dqab/KXIZ5T7Ss5ag0bLf+rUC/g+vKgJNCwnobrcEvKkxOM/vcRHY+3gNOgOdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682354;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=wGNuj1U77chEdN69w8f4IqxaXzHHXuiIrzEEhMB3yxk=;
	b=31LUh/5xNkDmI0WrkqQ/qNWn4ckQPWAsCLNREy/m9FhXLqpJOU8LgFoaP2SGcW1UnDBr
	 yGheaanWA/irFBiwo8xSEdholzpxPsX9UdECMOR5p6/375MGBCppCgEB9cq+3TKqH+lh+
	 hxrurxvETIpPF/GlDcngdNPKzOPuBZR3CAJuh2tqukGotyuu4552xJGIEANuesgFn7ucK
	 scuvEcennHeMEpTJSO9oYrdchcMEpvYy4fPlqktLPYZKBlCA55ohHQQhbkk5b/KpqZsZl
	 M6nDDb7FZXO5kZJ2RQ8cw9hY7C+FNog66hxyJs4W1JyPxHHpyUCvxb5+T0y6X8dSuxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LtU3xVkF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.59
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1589B606DF83
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 15:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1589B606DF83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LtU3xVkF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twFq7MOErEa4mmIW+ng2D2UB5614P5erhK2J0yUP0wOjXzv0XRroIQUFlSIQ+7tQmFRSbVLbGRAl7x3aHNpgNnkYrRj/XJ3btfv8Fu5zWduGTTSR8IE9sVOnl34fXVP+PEqDUTQ6xMArPs4ImqlAlaigOim6lhKziJhAxYGFMILf1lLCXLQ7YDbF2QmgjrKTKMc5QYlY9rCPppFZvAr+31QrA8PyfP3rIzclUe6WLsd6sGYHz3RL13S90SrdQpWFbM24uQYzASgT9N4QP7IQaU4VTiMh1CP5wVcctOsREZvo2vaAUu6t0jkPn45Ty69+a8wmXDGaTDZK0H06BxvQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGNuj1U77chEdN69w8f4IqxaXzHHXuiIrzEEhMB3yxk=;
 b=aylcQ8JR6j/73OsU+je094iG401kdTQbugcjVoBnrGRlouPGzkMUlkCtXcriZgrje1KsoaIzprvVUO1xz79uEVjgJreJzJ5ZivVVlnlq+TAJP0joU4QWNKiO4b6Wf3QyiI7+QcInMShfALVtDr1Nw/L7UH6JvapIsd+2GNhrSaZU4TMeX2+hSE6yXsQsbaR1+isUaVyin9/Bbxjt80YlEs8yP0flMwD9TdToD6d4927g7Pg9PoBh2Fe9BHyMCCKGu6raAUFJrp+j2MLkkhMI4HVlBW8ES1jGLy2GpnkcRUhC2jW4I10io1Xi4sEe7o7TymUm3z7W9LLvoMy5Ufa/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGNuj1U77chEdN69w8f4IqxaXzHHXuiIrzEEhMB3yxk=;
 b=LtU3xVkFuT01IC+YeQGQf/vHMY1vDXX7p1i7Z+LvgKbuvyxA+SQbK9TluaUcbmGN3Vt8MyKj7U2J0hnDjxLOv9Vo8stAPxhdPe/J+SqJ+mg7wRp5aqNQ4dfCZ1SUPj1y/iJjpF+xQJ4dzi5RwsYj+F8uZi8s7GgCLXd0oUQYuYvJasZbtEDmMExbgi8SIjaBjxOIHTd+oapCNDiDkIfQyooffq8KAUTwLFABsrOnc2ITRBOVmK2jKXdM6udQp+MiJPxlO8yZO+BE9w6Ku/OGlW6q4gjpw/HbvZ8u7FuJ0WAxSEuAAkluLC5iWV8lk7fx9CkBNUiBDkAIxWlL/ZBuDQ==
Received: from DS7P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::6) by
 SA5PPFF3CB57EDE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 15:18:49 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:8:25c:cafe::41) by DS7P221CA0015.outlook.office365.com
 (2603:10b6:8:25c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 15:18:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 15:18:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 22 Oct
 2026 08:18:26 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 22 Oct
 2026 08:18:26 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Thu, 22 Oct 2026 08:18:25 -0700
Date: Thu, 22 Oct 2026 08:18:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: John Garry <john.garry@arm.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>, Cristian Prundeanu <cpru@amazon.com>, Breno Leitao
	<leitao@kernel.org>
Subject: Re: [PATCH v11 08/11] iommu/arm-smmu-v3-kexec: Implement
 is_attach_deferred()
Message-ID: <atopPqqaCA9tT3cq@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <a80c74a629ee31af4dead1e9c263cde81abd5c1f.1791226953.git.nicolinc@nvidia.com>
 <a65c757a-04b0-43e2-bd2a-5c07ab4f61f8@arm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a65c757a-04b0-43e2-bd2a-5c07ab4f61f8@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|SA5PPFF3CB57EDE:EE_
X-MS-Office365-Filtering-Correlation-Id: 7163e7a0-1c76-4ac2-079d-08df304fc607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|36860700016|82310400026|56012099006|11063799006|4143699003|261021121427099003|261021135927099003|261009223027099003|261009221227099003|10067099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ufZDh/uZWd+rvF62uYVODHW//I387EEKuGre5F9yPLoQdSA2WQQ4IAYgGigZh4qeSA+jd5JJ957/t8X50jrvYbFmfN5TrEpKBkXeVhkIZFN2qj1SGl5FFJ6rVQbPpaVJfoeSs9fpj7qVyAXHLJZxpTm8H3SlzEVkE7tU1DjFfRXmDSCoUvmOBf0nPHE55JFS56MBU5ODC+JICDMPG7mUVEObL9nL76ogNFXqmS4uyNCEx9zWEeDgKwvnyzeU5SBJquXCZM5zeWRTW98Komt6PwIW3LZ2j/yaFg1Z4u78Xn74UFyyxVzbNQfSsdz9HLpNAgWlLJG7Mct+XhbXwA80S38otkVmGjsATJD0zlExvO11voYW2U2zPldh7nQ1qrtxcd7EEQwF2rLF4dSSfp8dWzmrsO3ZwEPvbPclCo6fjp/3PjYEo0A0Al40jY6EUD6qFEB7ASNtwuT59UwwwDQYYfPxQ6joc0pUbfhQNkayO79mWlp58Ju9WEWI22fUE4/K0sTW0DlgcZEurlTRVDDJnlWcSBxKfjm4MBNkW+iYpyOcjhfanwJ0SUj+lOWP+6qDdSNfmrQGbcxDTIYlU++NKXUjZqTP+7p70m02v/X7IBsAJYNJYjGrnk+isAC2mhCJt0I9eWAfsyGU0IyvuiR1702DWsULb0c/5aR0K9PaAd8l1o3hskXAosFg4FpdWKQ8qTu9OAthKWOtJyKhkalSRg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(36860700016)(82310400026)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021135927099003)(261009223027099003)(261009221227099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rHfQlvbjtveFVoRrFb0PXXebhAYEqdafxzB8fTlK5pJ1JUD+/9YTKZP+6VfpBMMtRLhPy8sGdn2H/sW0ycDD7kYTDBHDidZQEtlnpqLxMIQJjE+XNjyA5n5FMb71lVGBNCtD8Vzc1kjevxC+pmhUeEJFih3P9kvRHn61XU1aZ3drCEUnJp4Ulk7f7nWk5yxVwPjeKc6c8tsH6tFpo/ChbErysn6eWWkLkzyi8sMCZOl/oAz9MbmQofKJ19jj0JU1ElsjLO135DosLhd8hS7rACa7RM40jkWtcJMrvmMtbiTWB0e55yQe15cSXK++4RV1rEemeoWJyj4cp6UuXGPlbdDeNJaLH4DCAPNlrxP7oPhSmMH/RtX7WKJiwn2/7ERHtZP4cRHiOIpFkD1+1NLtcGVhoa9dt/3r8XtQMSExU98h9+DgDXfXxAZYIyebWZxt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 15:18:49.1330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7163e7a0-1c76-4ac2-079d-08df304fc607
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF3CB57EDE

On Thu, Oct 22, 2026 at 12:02:12PM +0100, John Garry wrote:
> On 10/5/26 20:30, Nicolin Chen wrote:
> >   					    struct arm_smmu_strtab_l2 **l2table);
> > +bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master);
> >   #else /* CONFIG_CRASH_DUMP */
> >   static inline int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
> >   {
> > @@ -1331,6 +1348,12 @@ arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
> >   {
> >   	return -EOPNOTSUPP;
> >   }
> > +
> > +static inline bool
> > +arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
> > +{
> > +	return false;
> > +}
> >   #endif /* CONFIG_CRASH_DUMP */
> 
> This is really a comment for 06/11, but I have already commented there...
> anyway, I am curious - why use CONFIG_CRASH_DUMP and not
> CONFIG_ARM_SMMU_V3_KEXEC? If your kconfig for ARM_SMMU_V3_KEXEC changes,
> then this would need to change, right?

Because arm-smmu-v3-kexec will be shared with liveupdate:
https://lore.kernel.org/linux-iommu/20260929071950.2710070-5-praan@google.com/

Nicolin

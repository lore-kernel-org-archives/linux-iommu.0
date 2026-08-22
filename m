Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582FB2D7386
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787422614; cv=fail; b=iRDGWyGViyGAAJkyGzZw8Z28CFprEyCKzhvfb7OyvSvb7jH419E8q6AbylRBtkFZSwRbdeNmz8gqRT3yK9LW+ObV7/VpUMbGQcva8tOYoC0iMTKrvlBK6XuaQi5+RNI2REfaBkK+weRTpWrypkRn+oZ3CkyytaFQ5iYDEUBdu+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787422614; c=relaxed/simple;
	bh=j1iCFxaQ15mGfnxCYEbac+GPk/7LJY7Bx+dXZR4/qkc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOb/MfLyl2Bedn7p2cmG0FhdVVFHImvAnPrTXKwf7bAMtiy+65WMAdE88A1q8EhECY/JCeQqzI5s6ScqeoWv1/rFXJGwbK2Sh+8pxuuVn+nvFYVmmRRPMyLFW/9g3Z96VVeHI4sHzXc10XVRm5PYihD/OuafbSyfvOJ6kJ9dTJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RoFwTOO6; arc=fail smtp.client-ip=40.107.208.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RoFwTOO6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuVa2pz7Ox1M8VRXOMozlqvtJb6QFQ7QvG2IcnxHf6JOsw32hUMBmcJBIG4p8fbUQ1k35VBfsMJeE1GaKOK8bYZx7wgJMzyrpHWudiI0vL35C9uoVHyQTZpsnEKR+zZa6EO/N10OO4xvitb7rRLMJ0HXlMz5MDr9k7wHeY3toYy8t8en25SrworWzAL6x3Z302RcUtkxSeWHZEQolYAYwRtKckzMMfHUJ6hX3/jbBzHpx+tp0enSIvT3X7dzw+Ru1ABvx/s7Z0VA42ZvWyGIDbaeMHTSN45AyfAPKDsS8w9bojVXZLpxS32zxPpqkhId9TrhFKHeeKcj3lw1veOiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKaQ8tRADhoJVi82amtSIawfpS+/XpGfVRPPKIYQtU8=;
 b=QgJKtNWLYreogjxsqwH8mrS+gEXdSI980s894uJoBQFnSZIjYrkzPSLqQeU0HLPWNqSar15s5Oreia4RkobrApjcfgEXI/7JGBO97cAYAjaKm4OkSSL46LEjiJMWZq0elC2CXDLeqRaRBF7DsATttQADf2fOUH3LkFuXPj1s8gIddnGzNRa16/wr3CmZwaAZLq0OVhrs+rjpohQCGpmydcGEgEcZaoD4nhMG3uMcxOHB1VEvkrEQlc/PkvVhHJCKlKDANEK0wuOyW08OImHviznKdmLKnzMoJUzB3QiO5HvpFNxT50rp+EHZHzno5Ei2HEGBtnSvvAZItPV84klhyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKaQ8tRADhoJVi82amtSIawfpS+/XpGfVRPPKIYQtU8=;
 b=RoFwTOO6e61amDmtXZTS73byrwNGsZeMb28DmXBPKtMLiWEL7OXxAww8PwJULa9cvnM3yFLNmcGpkqwHFPRaeUtktRB7y0kdSnYdMjhnB6JJ4SlyOvYNapD2x4wO38mmkvjIynKYMG73g6HGhtViCzOnZJgx6GyL6SR3J9TEqpyM7uYuiEvyjsDNy2YsvzJFkF5sBj/BFb6UYt0cttG1eiOchs0ip8mO4HDYKI/nfgFXTFJ9+5Z6O+kQmtBRd0sdzWAXCYRG6QPHEB5wj8uew0sBzUh0Sv/T1YsKqNEv1UH6y3/MzPk7oinCHlDC79OFWuxEYXMMp0T0ejj5zMw1CQ==
Received: from SA0PR11CA0202.namprd11.prod.outlook.com (2603:10b6:806:1bc::27)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 18:16:48 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::25) by SA0PR11CA0202.outlook.office365.com
 (2603:10b6:806:1bc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Sat,
 22 Aug 2026 18:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sat, 22 Aug 2026 18:16:47 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 22 Aug
 2026 11:16:38 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 22 Aug
 2026 11:16:37 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Sat, 22 Aug 2026 11:16:35 -0700
Date: Sat, 22 Aug 2026 11:16:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH v9 09/12] iommu/arm-smmu-v3-kdump: Implement
 is_attach_deferred()
Message-ID: <aonng6MDJ/s/MRuE@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
 <eb795edf2598c6df57122cd5951393ac1a860bcd.1784663184.git.nicolinc@nvidia.com>
 <178735412602.18212.5709943748630447883.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178735412602.18212.5709943748630447883.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af09dcd-8c3e-43fb-9aee-08df007987b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099006|4143699003|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	swXbIQo2jM4Y5Dr2GOJELsOtq9Kj0cqj9b/HdbXfHiEwWxwc0IN7kMIhUhlzr3IUTcuaFrxGXmwdiBGFotMw9G7gkNEL9xc0iAB/J60Wh9gic/eMqNMmw1CdypiXrDqglQU6Z+TYqJMBI+DhF7eG8sdPZXjAfwcFW6qqWYzNv8FEN2cXLOLrLXeKKLdiRB1qKVqXrMChq5GL02EpVOycpnpYudZsSiLtmtACnFyXe/BeiskCFc0SSH440HOZBLVIPjNmQRCJt+9ULhn/GnTi0nF3HixI8Set1oSnRRR6Js3RksVCLKaZwFaI54DDwSMqxhowvKa9oqUxqlu3mgJwEL1XeuEwU7xbfDW3n+4IrndyMc+H2POkmnYEbV2bBoZfIMluwACuTOrUGyY0aqwayzNeFNC5kpBISxCJRMwcYAjciIVHZte8cCsBQ3pXZ1AKKnCkeImMjlFAPpXg7mn+wlCh7YRfAp7Cf7m5PQGuo1rGKqQoAFJJffKzkuMuGMK7wzzWLIiEwDh4OXFfvTgdazu+3fU7G2en3LGIRUjKd0RQchJvA+zhRYq4BN87bem26p+znlnjuAC0XzG17rU2SYMKpLkG+T7p0W4jJZMk7iUWMM31/FxUUvCyPIUONgXEhGd54z0iXWgefsHVeagpSsY4zYGoO67sNyQZr6/tDoTQCktz3elsVxAbxqFYZyR/UdQfby4kt3lQ4wy7q52plg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099006)(4143699003)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g6za3Yp6XHSz38GuSkvg5CbZiK/MmGxyAljUikpQ8RwuVWJM4/PA11LOv2MJhkeRmvNjoUR2wHRaO0SL0Z4/mzkyGsh0v38kY7R0U+AQMeVkLNGR+sEnUpBiwuVWvR4eFA0uNyQWRyXBgaF/bgIPVi3HcRA1yTs+doyDWWlhDJRIREeEpKCuyZ1tQQ+7uEcBO0JKB78cYmD3Mvjo1bVm1Ql0Xh5GzIeWO9pKhr+wFoyLAjg9mk9j6N9ciZ+8hdAF+ZDvE/BwLDbc1boNiKPEf/NqW91Bgz1z5ULjGAPvcoeC0tTvMhvL3VNKKsLk2HI/8thkc1FBiyuQuVnXfdXvy6xQklWI7OZ6lBdPC8kXxheb7IrwDVYEYPY0ghm25wab6SKEJtl4mHmCbSEyfMchnx5a3sjBdBpkOutbNl40UTg9i9xZRMuyaASo43JHRjiO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 18:16:47.6067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af09dcd-8c3e-43fb-9aee-08df007987b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139

On Fri, Aug 21, 2026 at 08:15:26PM -0300, Jason Gunthorpe wrote:
> > @@ -1276,6 +1292,12 @@ arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
> >  {
> >  	return -EOPNOTSUPP;
> >  }
> > +
> > +static inline bool
> > +arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
> > +{
> > +	return false;
> > +}
> 
> 
> ?

This is for !CONFIG_CRASH_DUMP case. I think we need it.

Thanks
Nicolin

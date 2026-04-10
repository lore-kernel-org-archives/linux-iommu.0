Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010058.outbound.protection.outlook.com [40.93.198.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1EC2741B6
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862315; cv=fail; b=BMsPhqwNOX1c7pXvloxu5Cht0Z5gY8s10fg3n4LAqAs+LEo6+o60ch1fH1hw8H43peXHUBHhUCLJwaWsfI9THiw5YL22YZmOJG743Di2BrEPFkW7akrDgOGNHYqCCAUF5yU8ggoHocNC0nFPSb8D4D8SD+GEcAxAvwiDhxsKKmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862315; c=relaxed/simple;
	bh=IcAn5S0dD5V3FO8+hRE5ZDqFVqwkrDPRxTBRGGM8qnk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9f9V8PUJ33jTGdRNqLHhKKEfc97l2HYImgMMO9g9u7f7bvaAgyGBxOT6hk3D659XbeFqATnLaFDaBii13ZfYCFR+3s+lWsh1S1Yj9Xb6I3B2OWC7jrVKiq13zRDvPc3pziVuoNY2GS/enLKHRAoSSngu3Ry9Dia90SdpRylEao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O7nzIPad; arc=fail smtp.client-ip=40.93.198.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O7nzIPad"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NK4rbeDqhY/4gDmuFYGK2BMyY1XoSsrb3BlNHAaZCmEN/kyO64I4attIIqHyHJ1KbxJtAZcsu9gDoUtHRF3L3M7CEenJqNKFl2En6JIPt6pc2v6F/qzMgCKcSPUp4KWr7/vGbuGwhnq03CXltaWp5TYhyTbVNIfHykeB+zK9IfMW28xlBZNUvdwJ9YXXb1gjWYDLh88XE0smkv9v4gJ3wOnZ+DZQ13G5+g2cQSB+HnEk0f1FwO49VQbbYU9UmiHWARxC/OQYfczSAy1vwYcJZz28N0ENRzFyfg63bZdM6lDsxPr6ceQuarz+n7JIEgfPf6uDqA6eDkeHJF4+8HbBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6Vi2IWuxO2KiYcEyQrKDOdZP168unqslaJsXpezE90=;
 b=njEsFg0fpNeTlYe7KAAuuLUnyX0Y3hHqRhzdOFfUOf/kMB0s8TEKSEEXubLgKExafKadd3MLS0ZNEDgEucf7Mj6IX/35w5GWe5EoDE9tMYm/TNWK8GKi3eT4Uh2a0XyesW67aCNVvKQzVCt0rpoRuw6LqnD5GdxeQRqCfd/6y+/pJd9q+jA03O3kcTmXuEWBZ2uVgynmb74fN202LoaD+hmuypucyYw4Q/nDb3FRcvuF8ePRFyvCdzHDvMtHyMEJFPbFodoNn7UMgbrNviWVnasoM3H8C4eErIXHFlRrlmpi1gNDav2E8bWpLOperl8imRvAJ5kyLgy2RKoj1HB5iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6Vi2IWuxO2KiYcEyQrKDOdZP168unqslaJsXpezE90=;
 b=O7nzIPadvI/JRBUMZLH1ErG3lPSyRHf43zRxReBvjeaWrR1YROr/gxOueGtJ+Zco8fXiXMlXR1sA9zr6LS8Guu7AqvfsRV5NPMvUBCinIjBJHCA0mZof0j05eSqrvMsNCrKZPgB7HExtOhJZ+re7uLKKIxMeBlquIGSkySfIDzku7RCaAfvHUv6q07AoVxqguvgy+mn4N7w09tTju9O1vAXc/5gD6XHhpsBnByS72l3lEsSluaK6PP/rZTn+4wTOUEgXE8TNNwjS0E4oFm9NEgIvYSTQ5P23SR63sJkebeGryy/8I46+rV9pHrKF+b5eTzahe+YSJ7GgwNjq43IDMw==
Received: from SA1P222CA0039.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::12)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Fri, 10 Apr
 2026 23:05:06 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:2d0:cafe::9f) by SA1P222CA0039.outlook.office365.com
 (2603:10b6:806:2d0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 23:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 23:05:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Apr
 2026 16:04:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Apr
 2026 16:04:48 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Apr 2026 16:04:47 -0700
Date: Fri, 10 Apr 2026 16:04:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jpb@kernel.org>, <praan@google.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
Subject: Re: [PATCH v4 03/10] iommu/arm-smmu-v3: Store IOTLB cache tags in
 struct arm_smmu_attach_state
Message-ID: <admCDgkdabtx7iFk@Asurada-Nvidia>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <ceb8150f229ee7bd355ec42d23e422ae2185492e.1773949042.git.nicolinc@nvidia.com>
 <20260409234223.GX3357077@nvidia.com>
 <adlG0QTAzdh9vA4M@Asurada-Nvidia>
 <20260410204709.GB2588311@nvidia.com>
 <adlqZLZMr9VfnKse@Asurada-Nvidia>
 <20260410214115.GC2588311@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260410214115.GC2588311@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: f03c3bcc-27d1-474b-6045-08de97559b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	X2aDXQlP1vXStNACqqucL7qnWYNVZbFKWqLGFt0O8nLEVZQPJMv9mP65eJ+2BaC3Gls9bL6SONx3oceCjlw94YZ8FMwUV2+gALzuSueQo9oomRMw/HbywSxGwDh3f2O9tyS4S3HuEkVyfUuUSf0I/6zorkIFxlFWh+iXL6V65waWNC9c+4gsWM2NnLHgoqKOaft5QObTQVN0D475f96r7t2G7KuEgu2vEi+dNaootfJjHixpW0fI2NZ+TvmDndP1dhrb8k4yrLZzPa6Lpaa/CH5LenA71vxKXrRQ/0/lExv+t9z22Tw7k+hA/CnE20w6YFFKPSCrNCo/NMHO4Q+WOXIwEIkxqMzwbcbVKFx7wl+DsWS0xECuMy1KMMoyUeB0HaLovtjRPVge6uosEqBe0JvfNUG8fsX0zBwwGM6f9s6eTF229fSdqhAox3yRm72IXIOZLLD9rBN8vtuN85PaOybTb71r/WDOsHpXOQaz7e2qBxY5NGqIH02y/6Ns1pEL+hPeVPCfpy9ujNvEfU6HIQj3yeoqV9+DI10b0xMNyna76M3MGeF2UY2TKB8ATx5FiILCFv5O7CIzL/58yv4kX6Ucd5ZM8paJ3jXrB++UKai4TUKRQB2CDGKhKgqWrBQdQAbzeKAXOByrk1jD7kaRjAd7lTOSPoZeLQMLCFRivJ9cuLAKOU1bXDQY072RYkbsKjQGgUxdwbl0cVywNbVZ7wk0IyTDRC05LhthA7I8BUvpmt9zp+BwxHls/o3LgPoW93h8yDGcDCQi/WykeqPazQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CF6eRqVdcxdRKA4H/nX1BiWUOfHVS78A1Y1oRE9XYfRl4nPkVnV0kAVyTzQy4a4A71OqV+XtpKsZ1/l/ph4y+771LkPLO+Unf49FN6etQJYGc9l98kO0Cs1z1ptFr2x2GL0XJHQBOz/6IzmDz9yo5AyOy9wrTkjHiCqjApC+3RfFBGyoSL05oL/ybYQmM+jH5XoI06RCDVvijM8a3jkEaC70c1MXU98b5sIWd7/M9yoJbe7xYshiExsKoz3x0TmJX6h/lpea+3UGEtmrTR+aZH9FtJXn1pwmDc4BQUtIqKwAQ5VAOJ1UUVWZQWN6JllIdhw4rWCCNClfjnmggsIQ+iLqVXDFKiOZrV9TX/MXrSib417NPqtmghvvfK9KqPQCyHFqQld9jC37wZgShgHiLN4knJFWoogJ/0iWRQmBfb5uBPoR5FHU3bFAKIaOf0Lt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 23:05:06.2860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f03c3bcc-27d1-474b-6045-08de97559b27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863

On Fri, Apr 10, 2026 at 06:41:15PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 10, 2026 at 02:23:48PM -0700, Nicolin Chen wrote:
> 
> > Reworking the SVA code, I found arm_smmu_update_s1_domain_cd_entry
> > is marked as __maybe_unused and not getting called anywhere(?). Do
> > you recall why we kept it?
> 
> I intended to send the vBTM support that uses it, and now that this is
> done it can work properly without races. So lets hang on, I was
> meaning to look at that soon

OK. I assume its caller would hold arm_smmu_asid_mutex, because
it's calling arm_smmu_find_iotlb_tag() now.

Thanks
Nicolin

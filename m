Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29484374E6F
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 05:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773726082; cv=fail; b=XXBh+6gPXVJF/fXEXiS/A+ORhHwfmjLlWJjl/bC0R4tanaqa1cMGdgWw5FwLHnVzS66hbGXDIxLCEkYWOATOVXQu94ZsloLH635D34xUuYAnK6plNTEckO3F28jBZ8mLP97+in9i+obahE1xg16cNl4GfGcRjYK9ylSaHjqtsk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773726082; c=relaxed/simple;
	bh=kQY7dmTwvW2+npd3ytURZ9XY1xvlDnxWkoKZPgxgJm8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHc8wCXy1B/m8Hz/KMtst5VWXTPS2VCdaRWaW7Vr/EJuKtLFkPOGj1wnvxFv6SUxyYGzLlYjQ9I2XbA3yN0QCcxsdD3WP7y4gDu39/4jyx7btBVJh3iwKoEanvsYFw8OtZ/kDJ/6UENjmT/OwwQzEI/nS9y5sGhCk6JcABJ2yY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nj4l/e7O; arc=fail smtp.client-ip=40.107.209.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nj4l/e7O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFsBU+BtA84rw2Mds9+hV5qvnCPa2Izt41bpwztHKs/pJpdXraZF/CFk8X69mIHd4xR4sLHKs4m7uUA+QMjaKsfbUhLacQnsbw6wFVAjPEVI/V9U0DKwbQG6Aleo9xxGArRO5ehoHZoT1iGZxPuzy0tXTowA32A4zSB++VY2Cnlf8vkLxLrDw9/aRip3f01v7VSkIPCuuN57e+4nDvf68eNxxklgh+1v3NbKNSQLlpVX/OVkfD3h5wVzeqGu0VaoH7qiX+ZgfhnArQOYGna9PtvNSMx4Up1OTvDsF3LfEaSaK0hoBGR41StLmNBeSfMFViblFqhuR62rwA+wHdE6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yviNbx/Ahag/4gaEm4xjOYuyp6JLylDlaq3HvB0c6GQ=;
 b=qhEfspUJFzIGaZcwU+vULD9HnHaaljTDc3MWZ5mRnZgOVUxFEJWZvRC8Yp8rh5shQNrHjyAMDxGadSCVqewzkVOwSBEx/YTMjQwHJXR+jWKT8PFXQjF8iXE6cQduF9kNAfYfOBpZJUqGOoqVw1w7hnRNnIRHsYAt2vDw5QdvLCZjArpHcb9dMI4ZeYId4kJa1igoAznFgzd6ecymNtJBkGj2BB3WWUfe7mUEEYtyFhzr8jn03ULchf1sV9KGq8crWXUfOCrfbU/3wNzlky6orRp66WXhFq4rEIH8+mXwMp0oTy7HzyWafvGozKpVZb2bGLZ3HB655MZCBwmWa8jBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yviNbx/Ahag/4gaEm4xjOYuyp6JLylDlaq3HvB0c6GQ=;
 b=Nj4l/e7OdXmERign+cIvEYS97gHsiQ1Rmn0Lfqb4UYk8/zs+HwTS+lXtrZMPSv/OpNxH28fsn7UxLdwwPPNrlt1wFTSIjr5CRwwCA/IyaD30LtvHcXmfvnh7WECEhFWXNEV3TVDkerf6t+zD7uiTb/byROKpMqPL+DM9ZRAz/1sxm6BwsL4p/kFNPKO1uCD2UrydYGpBnM7qDwtCzbkdoqjcPbdtlC5suhfhGL2ZBLDfp6AnZsWcLchCmIW7+mqn+zxvzyafIUiYVkYcXrT3/br/BQ5iPdajigkamVQJDIBrGCZmr5WklAarIi36UqRC/XJ5bQ9ze8lt4DQX0FXQng==
Received: from SA9PR13CA0051.namprd13.prod.outlook.com (2603:10b6:806:22::26)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 05:41:17 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::b) by SA9PR13CA0051.outlook.office365.com
 (2603:10b6:806:22::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Tue,
 17 Mar 2026 05:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 05:41:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 22:41:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 22:41:07 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 22:41:06 -0700
Date: Mon, 16 Mar 2026 22:41:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 0/8] iommu/arm-smmu-v3: Introduce an RCU-protected
 invalidation array
Message-ID: <abjpcSSlPjdkzqaB@Asurada-Nvidia>
References: <cover.1771815709.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1771815709.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: fdac9666-afe0-407f-ca25-08de83e7cf1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NvS9KIK5h72myDoN5GurKBVGHS+rHOF307vwRSLJGEKb0zl/8Vi0pbwItln0u5wJOC+9EwBH2cg9NYImWDHJp2oH+mFETrd5QpV2/mpKtmN/qK5B/gS8VFnCdzpZPfmWFZJGF/Oyk5jraUwiQiQxSn5ahRbMN4vGr1svUoE/0UWnKC4bnkEqMrvOzW8P4cdgih9rfF+vUNBWiBwjipCgVTu2XmOuxn//2YfreLtKByDviof0307ijOsFDhMyPvzqB0JtPQAceoQ3OL1EoT6cCa0ssi7HQ8GtJk4xdQHJhzht8QLUp3Iso8F3CYlUslCeKn0MtZAGPNSHpK6RIlRTuXZ2vTFAJDJdDG4diKMfdJT931mVp7oX67hp2F3eYmY9iCacw2fXcUoAAkAhYEkepgPIpNP+ch+6eKu9keqSamnzgqThZrvuh9vEpqhudpbCevFHQeXF0FNd1nzJyzB38j0Zp6wuQbb5+6nYoKFhTXpOQzALYE5xv9rmaNbGWSBYQxCwwXvdp4W+6ysUDUVZyBKVUyEfBPvQlBtmbjAtE3E6sPnNyihc42t5Um7o6lTOfPf86GYnZNKpY8KTsLJ0PWu9RueE9GNH91Q9gEC4zbQ/PKGa/Ro4xlcErEMfXza1VrnKOPgFROb+bF1BUDhQ+bJbqgKj+IIFq2zPN3NiG/G3W4TMF/MGkXudrnhJkjJz/+kIavFr8+EC0fBjNCdNd/hmfNv9WK8WoFZiIVdWhOORPaad55c7xT54dGisQY4E4UCECzWoLGfTY9Q9LGY2kw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	16dejKQzMVIU5Ba5ESgbesWWNMqLE+WZlCmrozGisXWV1u3N4mXP3rBuxGbkWNas5fLeEFJFCdgMxDWo3HnKzHk0hV1s6A5SOsGPNiweWJ817GIh3z67QhLikAgCs45jVP0vDGF7S+9VXiezporrqDH6Gdf2qbTY7LGmgiN7ey9nNFCTGhG0kTueaWX8SYP6XcY4Wi8+ojiqhHpojBX38iPHG0ZnYl5H+u1sK3db5bJwOOk9VKCJk9fFdbF79EaUxJpZC0HSJ765a0Psb/kbicIvafBt8Ma5WTHoJpvE9wfBBgB/boSH3TBgjUIik86OnDHaMaK+YVCYu3BXxkVRckYQrQS7VWGFm5P0r+3ZVfeeJH7b7kdYRRJzDNYdoe6nn+UVcaYYh4h9ytIPw+/rRN90hCOubTmWaaaVC10mgj4n2TyCkQyAzoWu+EOr0mJN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 05:41:16.7612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdac9666-afe0-407f-ca25-08de83e7cf1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823

On Sun, Feb 22, 2026 at 10:18:01PM -0800, Nicolin Chen wrote:
> Changelog
> v12:
>  * Rebase on v7.0-rc1

I've kept running some tests and found a couple of bugs.

I'll send a v13.

Thanks
Nicolin

Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010055.outbound.protection.outlook.com [40.93.198.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9739CCE6
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259420; cv=fail; b=sUdZNgggp+xnvzsv7OyXbeH8rQOgjakEUtK1nL5CCJP1ra89JzE4WPvO7Sqbjv+ZXSgIz8fc0pfU/zgn9A4DaEJL+0N1UEbOAClDXAmuO1Y48qqUd+GaL8R+NqHs4Qt81rEncvyOugkxB4S/d/m8OhHzWA9cw4WFYFFmlyLqSfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259420; c=relaxed/simple;
	bh=yxp4tsqIcs/A04GSj8oYHlN1HL48ymr5ctKA/fZvmro=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tmde8UvjDJlYwSKKFOHxFjOnPcVxMXmO0RefYW6JBffYBtr+VOGBQowxCaxbM6IPQjiG++xCjemyOK03WNRY0FTFw4Oa+JhR0stz/jI7Plm8g3VUf/5zw/GlB7uSDKlq72ClDHdXKiXd8qnmx8hh/2yRmdI3Ze2KSIcKH91d5no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HA6E3xAP; arc=fail smtp.client-ip=40.93.198.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HA6E3xAP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwTg4r5e/RKoSdEON3MXmjQ9MyJ1K+ytkmQYh/ZmPKCny0OBP4M3ln2CeeqoDRj9HwBcLMMvmAtkDJwCPXVKC7MW4G831/hG5HFn37hO7r/sU+NXeuqjkLBIMuuYmSdYF8Hiuk/ue2cYCsr60GKwXEQsvYhp3ZEeqG+kehHOj55ffDQVvVS3H3LkjyCA5YMqGZW2Gi5URP8zqXFJ/R2fAaCqebaN6pWFzw49IW8xMdNIapu6nP6GhKC7jTq6aBiTukPonfBYJXElXfIGUQTqfB4cf6q90dHIVgS3IICUE1iG6QL7hXVWJc7iEeWZCe/+sDq4A76wG9kULZQ+F75KYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCE/k9KLUR+wbARastUqG5zfPao24qJHyU+JFRYqt88=;
 b=hu8wAuxJWIEhgXEUHNBY3QPrhTHnPLuODSBH77/qSWcZvfMCzeW8I6ffPwElGM8BZBNAoml28Ncxpga1HncK5gWYNqkrxE+M78JDzTXZOQYngsYlmsXvCrrGN8fI6FS8NNcVfkJxHpsLgDL+ODSpDHxqJXybcHEEsHYa+a2XowpNATSZEzzdI1MZTwXTKIZherEg5Qj1CvnDNR/NE1qjA4bXj5P5nXkMyLekMeEjKY+/v+gcQhq1WIBvtwNqjiAqtyetBA7Frn6kX06NUt31Qp9RWUoX/y9szs2wPrTO8eUMTIXM4lTM5/UDaWuhTfEjPrXdQdjBkAzcYgoFuAbiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCE/k9KLUR+wbARastUqG5zfPao24qJHyU+JFRYqt88=;
 b=HA6E3xAPD0gUF4mi0M8FZE52dNL8m2J1yDGzxeoG95fDn5ks2SUIGgO6vknM0+FrL4iasOCdE3Ro3gCRsmVcszM/1z6O3lRk7RoWFiN7iWIYRWaFHnopzSrfBiClmllGpIjvecnkQR2xC56zLsSOFp1vVyFLhZyIG92gcnvgfVhUgRjCuyUg8SlzWU1xx6Tq+M5529vWDFAYh/k+ro7OqoyqKhtt0d6YWU3i4djKRGeZjAl8ZhyhUx6KNk6nsK8Xa4tyRJo6W5KE7wrWmNCFD68/DI87xSCWbBJdIbNh288Mg1yBzMZA73O9fvhEXfaouYk87EK8ExGOWDt7NsKUZQ==
Received: from MW4PR04CA0349.namprd04.prod.outlook.com (2603:10b6:303:8a::24)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 28 Jul
 2026 17:23:26 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::9) by MW4PR04CA0349.outlook.office365.com
 (2603:10b6:303:8a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 17:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 17:23:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 28 Jul
 2026 10:23:07 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 28 Jul 2026 10:23:06 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Jul 2026 10:23:04 -0700
Date: Tue, 28 Jul 2026 10:23:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	"Robin Murphy" <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH v4 0/6] iommufd: Iterate the cache invalidation array in
 the core
Message-ID: <amjldtTZBNLWHOJR@nvidia.com>
References: <cover.1784054606.git.nicolinc@nvidia.com>
 <20260715201521.GL3775915@nvidia.com>
 <alft3llhZ79t17j8@nvidia.com>
 <20260716151845.GO3775915@nvidia.com>
 <alkE4iUQSWeD8Vyx@nvidia.com>
 <amiSKPx6-VXBxGBK@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <amiSKPx6-VXBxGBK@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a83a794-6ed2-413c-ab61-08deeccceee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|23010399003|3023799007|22082099003|4143699003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	QbJGohaSTaJyLdajlSH//1Ekl/GDjBtDYDXLLjPiRzWyc52v/1ak3WpNVi6RRwlsX0sDwYls5zbmOlWydJpxyY8/gQDvj5ZnVDr3dfgf10Cv0w0TQUUbMFtselZklZ+9R9ByJikfWWKJSCuoGs1LwR7ynmFHPktyBeIPXNLVNBShw0G3mQAMHRJoO9aOcD+RMFKfV/kN3hP9b/kN5zflZhLIJ5UXVQ0VXh1JX/4fe7D2K7HtjyR0LIXOoa1loByEKfm1UuODMhU1t3DYtaETnFmDv/EDl2cts61V0MxqAzDhslZKzMD1du1Ho4yESkHKgLE9vJdzwSvelDWB5Lfd2v7e51Zsd3/RJpA2ASsZ8igeUS3pyg24KIaLL1cNvqqUR/9BpmAVI4e/ZaBdRdblCkOpCxfu6hunUCF+UI5aSOGbqtUQYpcYDGkI/JPZpmWBVe+ISJBLQluEqXiuRJDXyyEQ1ICU+dTq6QOFvXUoxknD4K9M6qjeKsrPs7artCjnG8WuiuHwYXumuHVJoh3yaVcCSxchVXtJ4l9tpvqYA6BKPXN1zNa7gd3NFNG3DXCAv/gdR5w7xIRDTQ3CsnIEyvqk5py9QxkskBwz7zSXksUXu5wnnVqZMtBgBRWYlDw8ij0qp4JPs0+zibMNplgjzZBcQDem7pG+iyeKylYCiyJwzXro5SAyBRBIAZgzfMAxxpxI6S6rI8zcSxR9X2hFBA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(23010399003)(3023799007)(22082099003)(4143699003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fmSaSTO4DkxkePBim9Mb09nex42djLgVgfvFt2+tEA8xqFN/7E6PyM/9y3ZOrVHIeRi2THaeEVTM0oCf4S68L9kLJh66r4lnBS8CX0+txgrI5qY5BgJMHkrMG6H0u31GB7G1/kADA0yLyUDEsdIHBsDU8oal1E4rFVmg6BblltXo8PBEwg1AOO+4vKbRqVKxB4J5s2TOwiJpA7opl/foG7qRkoCPlgicDDeG2TwJQmql7SkXN/x/Y2S7fhsnUnTrNiaYdQPipbHuXbNE5bLdSg3Pn4pPCwxId8v6hj1zNaYphlNUZxMnqj6RDMD6GqIbpAeRQ+g12nnyIBtbsvCDsXdnWa0+r342l4zV2E4/9OshfkhUq4xbZ/mYcJ1cjf/N6XfAOqrEHBf+f1/QRUqw79xsHuxLGcY9mZEpHMgfb3A6xIgrItLk71Il+9zTamrE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 17:23:25.7493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a83a794-6ed2-413c-ab61-08deeccceee4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338

On Tue, Jul 28, 2026 at 12:27:36PM +0100, Will Deacon wrote:
> On Thu, Jul 16, 2026 at 09:20:50AM -0700, Nicolin Chen wrote:
> > On Thu, Jul 16, 2026 at 12:18:45PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Jul 15, 2026 at 01:30:22PM -0700, Nicolin Chen wrote:
> > > > On Wed, Jul 15, 2026 at 05:15:21PM -0300, Jason Gunthorpe wrote:
> > > > > On Tue, Jul 14, 2026 at 11:48:46AM -0700, Nicolin Chen wrote:
> > > > > > Nicolin Chen (6):
> > > > > >   iommu/arm-smmu-v3: Support IDR5.DS and widen the TLBI SCALE field
> > > > > >   iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation
> > > > > >     commands
> > > > > >   iommufd: Iterate the cache invalidation array in the core
> > > > > >   iommufd/selftest: Convert cache invalidation mocks to the core array
> > > > > >     loop
> > > > > >   iommu/arm-smmu-v3-iommufd: Convert cache invalidation to the core
> > > > > >     array loop
> > > > > >   iommu/vt-d: Convert nested cache invalidation to the core array loop
> > > > > 
> > > > > I was tempted to take this through the iommufd tree, but Will, I think
> > > > > the first two ought to go to -stable through iommu ?
> > > > > 
> > > > > If you do that then maybe I'll pick up the rest
> > > > 
> > > > PATCH-5 touches arm-smmu-v3-iommufd. Merging via the iommufd tree
> > > > will conflict with the PATCH-2 in Ashish's series (via iommu):
> > > > https://lore.kernel.org/all/20260714104202.1664187-1-amhetre@nvidia.com/
> > > > 
> > > > Maybe it needs a shared branch; and then, Ashish can rebase?
> > > 
> > > Urk this is a pain. I think Ashish's errata fix should go first so it
> > > is easier to backport.
> > 
> > OK. I can rebase and send a v5 after Will takes Ashish's series.
> 
> I've now queued the workaround from Ashish.

I will respin a v5 shortly.

Thanks
Nicolin

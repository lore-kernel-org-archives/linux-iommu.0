Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8DE222599
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524999; cv=fail; b=OlGP+aF/McoX0F/YPneBY7S/9QF15oCg5Jxc2qCwwv4r4Yo7msVJIMQLXSiyZb288UcLwyggUpvbmQ7a4gHX7foi/rQibvlHJMRcP7h0xBSAYTaAdfofudaIh+nXCfe2pAbSfd2+sFXSxrzHugSw79MrIZS36XlkNhlhPrZQ5mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524999; c=relaxed/simple;
	bh=bPI8R6gs7/zeLR3eO7kGOHNuYMqGUDYMp+/VDwQQnAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gGMc8tN5KpJNx9lKYNtBJXOtd5YVDPa//GGi7QAPYca1Ed05f6THj1HXx4AxYVJsgho++ZbgMx8KGAPifg0ysVXpQvxsJCBjC3V4IgVrUxGVe+TSmj7EQo5F6vmdyNHT8ky4BfiBGZQhjThg7j5e6y1362zF4UaS0TjRflL59ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hQVl8qBy; arc=fail smtp.client-ip=40.107.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hQVl8qBy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmqMAkAbitqJONZTyiQpreCtOfKqhFMOrYM1QdZeHGUhmnji6wl8a5V3ZPkvaXsIXpsQ4fvQBkvckq9wz1abxZAs1L3O3so3HTmY163SH5gprLX2k5mqPcGuc/wPwmMkl6FHYeqQKZlY9SO9x3F26A0uxXfUAvBfxu3AUG9liXPFqhhHqIkobcJU6gCCjdZ5007d0VMFK2lpBYidE4X2ay9nF6gWqbIc6+yONzUsh9L8FhQCp+FoO8WUN/7TNO8BkhcjwzUA6Gu4+SDJsJ6Gk3OeC6wD9aDBtOYMcnbOdM/+mAntPETRTcxV9UCkNCVPVdwuS8Vsq32+LCPL53HK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp5AZsa1iN/0TW9agW8vfIqaJKxzN6hw0GPXsa7OKl0=;
 b=ygpx8LKNC9me7MOlhE9yS3UXQiKT9HnN2V7xGfnL9Xd3dRtrcPNFpa+anKmh6SYJ/yXQdVxOAOe2i59Fhom1M8B0Ux79voe8u2bi1lEXiljuJvcGv3Yv1wTZDtBygU6yp+yhfTq9PZjoJmeqmwbeBVJv39otVVcY5Z6+H4KYRL3qCUsm9elBovIADj5i48IF2jV6Xtvkdtn9XaXZ78Tr3qLTEYwbpag2bfUGqId0cQwwXebtzJYlPWNUtnSV0Ou7KiOh7cht2TUxDey9Z7B8e20ffG3SQ2XAN/V9+HxpD8lgDWWfU1bV1FZk/wqFmevR2ayNKGy8CzbFUQsHWs2JmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tp5AZsa1iN/0TW9agW8vfIqaJKxzN6hw0GPXsa7OKl0=;
 b=hQVl8qByXgaaGRAbjVbi7+wedzze07TmSwWmUIKnvMc/951jg0qyDInXfzKxmCxN7kmDJtVYUBRuumRR+Of4SuG04Vk7nqeskqdR8uQxjmnx1PPWVFZWgdVO2HZrArNcbUkinUnWVfbXrwI/ihhypg1yc05w4XfRSPnMVRzlny6r8TADB7izXfBh4DXpIHqIq/zGavAFNjuomYXTM4BB1dhPti5SPV625mqCVvOrlLQKx2zi+a3cKKx06h8X7sqTxnHy7MlUyq03huKJizn/3kxUoT6JmSyUCgZtEEHLL7am8DUF6zRQ1/em2BF287ayNmv74bIGMJqaGMKuOHJ3fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 14:16:35 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 14:16:33 +0000
Date: Fri, 7 Nov 2025 10:16:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: "alex@shazbot.org" <alex@shazbot.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Message-ID: <20251107141632.GL1732817@nvidia.com>
References: <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393DFDCB2788CB823DAEC64DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107010349.GD1708009@nvidia.com>
 <SI2PR01MB43930E5D802B02D3FCD5ED9ADCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB43930E5D802B02D3FCD5ED9ADCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: BN9P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::31) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 34004bd6-7b32-438f-a60c-08de1e084119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g07vV3qKz9VvL6aU1hyu+LUoBAszyGJoZakn1rwID7ncFhdaVKerAcdpCxLs?=
 =?us-ascii?Q?vIJaIWA6inDgT99RfgCzr2Vgh8CE5nMovZE4iv8BEmmHmLTpUNCKQAw+Slih?=
 =?us-ascii?Q?QJ7Cl71Gc27ZsJUvIx26TdSYE7P6xWM5nPZS7ylDp/6HrKn3I8hi2w5xRDom?=
 =?us-ascii?Q?iWsNflyMAlt8cvBI+68BOT/Qhz/iUlAQ/pPiMkRQBPqtNpmW0ZL1AMcm/yVa?=
 =?us-ascii?Q?YE1+9cK12+Ri35l3uOQECoBoiji72W6C9FzaPqDU8cx1rOvDSziG2VULeLXM?=
 =?us-ascii?Q?EogFgFelcheKm1kQyWBcXT4+WuV88L/HMUVJQwdUvhS+LipXSRdDWVRzwn22?=
 =?us-ascii?Q?tB/aWWY9TB2mCDTpvBGGwRWwv+sfINJNxRva0chZz+tX3Sf+eIngfRmRsUiH?=
 =?us-ascii?Q?lTQX1ZC2PETFkmZigjccEZQKX/Y04WoFPrAzDxqwld1Nh1kX2zP0wMhwVkEk?=
 =?us-ascii?Q?Ir2x/YWpQgUIwwPBtSH43X0JdkHBRHUBDG/R9/ls9a2VCjbPXNBglVI917Yk?=
 =?us-ascii?Q?err0EOTWom1wQ63EpEOZ1m0HNALBG80Ue22qH34iMFiNVcpvlW3QEosjMFQs?=
 =?us-ascii?Q?j/LgYVuRGTCFFHy5o9RBpUZPYg/I3bkm5jiGg3jx8c1ZTTGd6ko+ZUcEaJXy?=
 =?us-ascii?Q?RJsAfsVS67KoSEKHCZ021g4dpa8VC5FjW8ujG33Mp4C5lJThnjrWLD9LGCJN?=
 =?us-ascii?Q?7KLeY6MMigev10ooavtfQriJAuJxYlFGm1NZoGkqVaeYbull7hjeNT2s+gBf?=
 =?us-ascii?Q?O/cDsraR6EolMeuBdLA550k987obP59Jb6QU/FnwWuUhHwm5JD61GG7zeg80?=
 =?us-ascii?Q?Ox3CYFrCAyWqEa0cuGQ92DwVWiYXsJvGugg5txtHplghjwRIlovVa/5JNhGU?=
 =?us-ascii?Q?Tl9J5p0CnPfb7gnznkuJOsISHqv3Q3XLzvUcIqcRAb3GnOXessVjevVflL7b?=
 =?us-ascii?Q?dizETFCg+Lw/d4JDqKK6040Gzl/jvkd5us3pzxVAfuNc1me60xlzF53ZCpIl?=
 =?us-ascii?Q?BcZSghNaqttYOHo1J6yGItUwEuxsw752zytHiYc/uVUCtEHRm6Bf9JtQLpc0?=
 =?us-ascii?Q?84nfyBqyXVhEp2gORmPixXa3mavDWmO05HSYiALk2arD72qTXwEBPZXJewFW?=
 =?us-ascii?Q?AJejsCkbPJzwX0Lf8we25VPTEHrlbUYyebF52VH1K5uPaMKa6zjB+2POfKQC?=
 =?us-ascii?Q?/5/g+8w4pJYgNH6lwGBo82uYl3wqK+7S3iYAsv6rX4eN4/PSsvw7eoPU6OmW?=
 =?us-ascii?Q?Dtv7BcJq3XSSJN+24Y3qi56k1kbL57nl6wHtOIT/R89wHhs25/vUlEiDOXUK?=
 =?us-ascii?Q?0EDB5ZSgT2wd3cfvhAaBEWWJxgP92Kbqk2/CpEObXCdULouXcJChTcG4I5sm?=
 =?us-ascii?Q?NQ523kR3yBDbwb7JH0Kbg/vDsuc/u3gjlZydFMICNZG6ZA8APZgqk+vXk8Zv?=
 =?us-ascii?Q?/BhxeeVV1ceRfFZkicdiFHTtbW3f/mWk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BYaRyt3rv+TZNnJU1Jd5WoPj9WdM9PSXlBQqGKPcg59dIRBthpFSltpx951k?=
 =?us-ascii?Q?oCm814NgTSD1YSdmMO+Q7f2lp3040JsUxs88inGFQ+ZHUztP03CJ8eIEDA86?=
 =?us-ascii?Q?0GutoeXpW8dXGxXJ5qviuClJ0Ug7oWEuzpKpbi6QL6sBJS3S/6UndUrp1udG?=
 =?us-ascii?Q?EExvd0je7ktqLrqBKOpDF6mLyGXvzcvFrCPw6jvOmEn6Q8y/5qAGLcL6sYQh?=
 =?us-ascii?Q?MtrbXPCyJWY4Tp9PFOWJeSDPkCYNbh7ZJNRWsL1zfSPDN0XqRnWW8HFaYTxp?=
 =?us-ascii?Q?5350zIAcg+IRbLIrwQhFVrZJwtWpha75lfWk/Mf+uKY5mZhYTG4tw/CtFlnM?=
 =?us-ascii?Q?Y+BS7m26S5N88b2+NlB0X/7K49wFuK07F4/o9rq9PSMkU3MiuMFgynF55V1/?=
 =?us-ascii?Q?YL0s6qhSoWE4SI8Tm5QtIziMxvm3/3qhUDvGjT29drsHHC/lPIseF70Zowa1?=
 =?us-ascii?Q?PNEfi0GfjIPksVvgTOB7wVq87Zn2eB2QqOExGFhGA/DE4ElIdfI/A55j837o?=
 =?us-ascii?Q?Aw2zD+cIvSuDr3P4g1Z77OTDesQUzejpJ60ouM0h2ETACswAoFhTAJxwyKBw?=
 =?us-ascii?Q?Q6wqzmkgUTX6YfrWFLxRShMRV/26nmm1xMloAZO0M/Ykj4UhrIcfLJ52EQfD?=
 =?us-ascii?Q?04EOr7g19cevo/x582zZTJsRpcsTo7J+41u6JonUYdaJTHfC48oSBBDDG+BP?=
 =?us-ascii?Q?pjUH+PIfVlW3GzhWh6kc7nyEIFtcETMeMq1bxHVExfAFL2Aou2a0stws9CfZ?=
 =?us-ascii?Q?n8oLbCaS/R6xDkXPNlwsS62OVUVIyOFrtD7P8oBQApKrUpA5bZmXiZIQAeIk?=
 =?us-ascii?Q?o/K8rm5YehhnKjtqLnXok5pVxKza1KhvaXxJ1KL6xqcngyJTE7QK4NibFIjE?=
 =?us-ascii?Q?dJ2h6OE/qDuIDXrhc/xf4UgeMq/BhPR0iK7RMNVG7nIe+/2RUCX7gsyDnte8?=
 =?us-ascii?Q?0QkZ0pgcJzo+1llx4QwYDtO1I/fPcgnrYZoOdbVZuebsypVEiUFPxPoo3AOh?=
 =?us-ascii?Q?hgYOFN3vYw7e72hr/JouoCvQBQbMqiEM+K9/77xIn4didgtG1OPMm0W5OYgT?=
 =?us-ascii?Q?gR9cuC1G5dr1goHHbh7sS+rksn1Cn8J1YJwbvA15XCwfI4NpmcxUUcaYvwGi?=
 =?us-ascii?Q?jpsnYzcU26PmKcIojCdRpiMFxEPAWYLfMt1ucdCApEGLCGMBUvsxP18zfrSb?=
 =?us-ascii?Q?ppiweyKdrRQxo1xvraqyRp9pWU8WVrWTQ6h1vd5fKPZoNgfdoIH12hcC8ofG?=
 =?us-ascii?Q?TD41+S24+booAunCdIbq65FU7VuSxms/0ioPhW3Pm2RG3PH1JhI8KFcMG6MU?=
 =?us-ascii?Q?rRSdffIUp25zf/OA3wmm3st2c+/4oVbEJeS8SuMs2dS5B/FjH4vVahRlX3St?=
 =?us-ascii?Q?nuNwPlQGBgXmSUE8yJ7v5/FmVzUXGorGt+pGrhEKWDaUwwPMVdU4MNtnNFmJ?=
 =?us-ascii?Q?hGr+IuH+jdwsAvroUvudQM0jTP6btKXPxGmGYBrzfXz4HTp5LWC9YVWBx7hb?=
 =?us-ascii?Q?F6QaDtN/7bLes5TJlE9pB70UyO2m0VdAEiHR3icqKTLtvjbstZ7uaTX3E354?=
 =?us-ascii?Q?jl24dhu1XULwCxTVpLI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34004bd6-7b32-438f-a60c-08de1e084119
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 14:16:33.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVwzJsrt4ssUUWNrJvZ7B7+zehY/C/czmZTyEXAqWw7r9qouTc2cky6L5W9aJ5rN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

On Fri, Nov 07, 2025 at 02:38:50AM +0000, Wei Wang wrote:
> On Friday, November 7, 2025 9:04 AM, Jason Gunthorpe wrote:
> > On Mon, Nov 03, 2025 at 10:00:34PM +0800, Wei Wang wrote:
> > > Before requesting the IOMMU driver to map an IOVA to a physical
> > > address, set the IOMMU_MMIO flag in dma->prot when the physical
> > > address corresponds to MMIO. This allows the IOMMU driver to handle
> > MMIO mappings specially.
> > > For example, on AMD CPUs with SME enabled, the AMD IOMMU driver
> > avoids
> > > setting the C-bit if iommu_map() is called with IOMMU_MMIO set in prot.
> > > This prevents issues with PCIe P2P communication, since current PCIe
> > > switches and devices do not interpret the C-bit correctly.
> > >
> > > Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> > > ---
> > >  drivers/vfio/vfio_iommu_type1.c | 14 +++++++++-----
> > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > This may be the best you can do with vfio type1, but just because the VMA is
> > special doesn't necessarily mean it is MMIO, nor does it mean it is decrypted
> > memory.
> 
> I think here vfio type1 only needs to provide the info about "MMIO or not"
> (the decision to encrypt MMIO or not rests with the vendor IOMMU driver).
> 
> Why might a region not be MMIO when vma->flags includes VM_IO | VM_PFNMAP?
> (are you aware of any real examples in use?)

VM_IO should indicate MMIO, yes, but we don't actually check that in
this type 1 path..

> > I think to really make this work fully properly going forward people are going
> > to have to use iommufd's dmabuf.
> 
> Yeah, I'll also patch for iommufd. We still need to account for the
> case that many users are still relying on legacy VFIO type1 (will
> also have some backport work of this patch).

I think my dmabuf patch for iommufd already does this properly.

Jason

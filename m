Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013026.outbound.protection.outlook.com [40.93.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767518FC80
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271841; cv=fail; b=HM9Sf3x8R/fRMOmqeLwvzGl8FP1doN4e6RnLtQZLAVvlW2bkBeZOHuF943ZlHOlmKBUQf4/EueI2S08Ae17YWpnhhrmAz0c7ez5xkcoqAjL3MPNUuWJaT8903sRrJq93DXhcuqFfx0i4Geg2ikaKYbTX5NJh8ztUJnug2ZKP1Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271841; c=relaxed/simple;
	bh=ZDg7pkecWjZPl8oOEoVUtaN9sU6J67nv8i5Tx9sUjx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SJ01koTLx8pnXuiBHQGZICfGgJi7AXC8LrCL2+z8/q5Hh9lb3qnYFZJB0PeODBDGEadcbkq2DzwqFLueT0DsFbjjQT/La9xwv8LwsovtQYWongwsCyChFQ3JvOcNm8y1S33MNlTpd2ZkO7j/MOLhWf0lcdJK2FYPPSmAcyY10Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o1ODi/0/; arc=fail smtp.client-ip=40.93.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o1ODi/0/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTGt3R4rnK8z+G4LPLZG4TamugEtiwXSmU+XORb42fo4Jy38Mc8QjGb9458tMXn12sc9UeGiZS0uqO/TzrrYj07cl3gaeKY60x+88+ecrByYiQjuIhPwwh0y7gzz2tIuFv47zg7awVOuhLRHtZ3v0XA8TMGdiX+glAczGAl9LL3jxWNZ9FW4UD5c7LcN/60uKcyCPTlGRq7HJxjtmY/S7nk26wt4k8fqaTnx3s5dukCLGvcpHXLpWkLV75M4+MRxiiCcsOCjBTfNu6IQ0GchHl/VNIwbflEVdx03nxCL2WPawoy6ftqZl0DS2PhQ3F5Nu1iyzVy9u5si+Fm18Anxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AbhLpF/Dpd2mrhKoodlKlj9jaFqL2Mlecf19QdlPo8=;
 b=q4ewo93W78bkoAJQ37BOkIaM6BbYY2a2wDHfPzwxYxxLq0zoPrB+KENNfmyVh7rW97onMociQ+Khr8YoG/aa3MM2Mp7ti/mQvU86SG3E6O9ljgoh2940CWvvlULo4KVsnEZplpTJICiyyxUvsupPPoeSdE8nXRiTKaVhb5fsqt5iLugcY7JujgSRhruGiMEnYYfyrqkD/QPt0tDMSa/RrJCJ3RfwYD8W5AMdOw8cGnAQMJQqvdVSOCeiLEJsjAgd6nvnLAJaQV+eGLWo66YwbAOkRuy49orzlYVsb0mHA3ncNTgAOoGncF5QZMbpvh9Xva+Mm5/PYj7eSes/1OTj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AbhLpF/Dpd2mrhKoodlKlj9jaFqL2Mlecf19QdlPo8=;
 b=o1ODi/0/4yv/h3SDW87OiwrRtJAf2TWd7OcVyP89Eul3G/Z8Lc+DNA0BVm8vYbQ1YC4jG3rSPiLy70kHaoFtVX9Auw/+H3yXqi+ARCSmdICMTcvr81PGZHfkoL6GkeHQBareI9mqm2X3ixG4cuRN6XXKm3cuI3soWi9X0Hi95zzizrfSiIQVap7gxPmxHLw3AFidqnnMqUemwEsP/sB2wzefkFK5f283jEHQVQ2sQ2JovUrmzL3Q/N6C7vKw3DWDfCOb9lxTZDPGFwDWzoqnmy2PGulEfYcqMt7rwC+Rem8mC+XFW5bXUYa0vKQckTJvTSfucAhi2CGKT+PM6ceNlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 13:17:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 13:17:15 +0000
Date: Mon, 23 Mar 2026 10:17:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 01/11] iommufd: Support a HWPT without an iommu driver
 for noiommu
Message-ID: <20260323131714.GG7340@nvidia.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
 <20260312155637.376854-2-jacob.pan@linux.microsoft.com>
 <abrvYSZ425p6a17D@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abrvYSZ425p6a17D@google.com>
X-ClientProxiedBy: BLAPR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:208:32f::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: ace896f4-ed87-4fe0-7584-08de88de80a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wfGdQd+z3040eJln8+Zm1K+6z/XY2daOejYM2MBWEXEkBWiV1vGlfBjE5JJVFazyQQ4o0Io9BKSNeUPcvCT5rNRGdBK1Ziwyy4wh9cJMk2yMlGstIWgGYH9xIwWWvY0C558B53lOPBDF1f1ksaw/A7+5JKUgF+lRTA2MAVWxHH1N31DOJs3vJIPkBYYmEFAYl0dV0yKt2oSxNA4O0MbEZ3GidN4lE5i/KlO65HgjMubIpQPPNtoexnUdJWcX9+taWG59IdcytOvuxOoRcR/cZxkV6UM16cD88l1DIt9KnX33S3gczpJL/Ribne63hjMIWlZXrS7zX9c/Mq3nlK7BlowKx62ilNVv3O5sjQpVBXjINrD8Az7KjSb1zmRZEekI2x2s9IItRaE7hMxw9jF4ueacU/T9jqBU2ZDjnaKIrHUnzVQo4qXD/1F5osqB0sjOIW55d7/N7ngVOar3qSybSX/vKnH3x6Q0N9zY0KiNwJk96/k47/v5KSsmtRlGSL7iIU1gfM7cgZmGRS8mWUJzvVXoD5/ylysD2kkWqbsfTx1gaJ9cBanSpjOF14Aqja0r2lt5JCfuJ/clp2JDTNmjlLlvrwXW2S8BvW2gvCChj+YdYdLXA6arWz33uVoAcwPojALPF5WjuEBjBdnfP4L8KMdamn1rYhUyczYMbuIzVAqF/GkQmVzoOSBKi2egeD5tBB+8AZXBD90qBT7M/3TjQqkueyGURKCkjCZlQsvZEYI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bmf4Ur5ukKUUjP//Gpm27NT5mHSkWoyXyiRDA6PMCpCHyupUvElvZX1yoHdS?=
 =?us-ascii?Q?fOP3IFt5l5gdIFn203iVBrJ1Ct03oKZii8Z0eL9KreZAsWxtrimXDaw0IDww?=
 =?us-ascii?Q?u/nM3d71Fh4+veDHmEypaugeO/GOWzLz3k7aN44RETD4dbVGDdEggPaReCWk?=
 =?us-ascii?Q?NwXyH0Ofz9RCPrGan5RfVIW8emuHf2Tc09B62SQDYuXKCJji4IN0aj84hGqL?=
 =?us-ascii?Q?050IjF98MN5hFurqIU4tSK/hzYl5Wx+sRYt30JelUgoISEZt9DcfsvlRrC/V?=
 =?us-ascii?Q?lKWdBKgxkyN5iPSeex3beCseLDP3jC1g3tzIMeyyB6wJu+5/JwzVfwt5eibV?=
 =?us-ascii?Q?oPnNGNWfKZQYxJHE7d1i6txLObK8GuP3AqTzCPdPCOYvLGmTue4MgvxMS9Da?=
 =?us-ascii?Q?PudYqho9lQ9PNqWAJEpJ+sUBjeZM0gCGoitLsYzheRdH1cwVAbFkL8KZh8Al?=
 =?us-ascii?Q?ixfmuhqj3G7lcoNKe4+Ag/AZVo79Xh1xbbNqCSDlajI1KSPoGF6HgtODjaz6?=
 =?us-ascii?Q?Dlgf1iaxLWK+PScaMedvam79iVrvg+E8Yur2K1fgK34HkjibnYVHRBUD0IN9?=
 =?us-ascii?Q?kZpjWLAgI8sgipdGDHrw2bmhJ9MXy4YWHKb7Af8JZ+/u96MWANsA/TfuetnH?=
 =?us-ascii?Q?78wA6uw/rrAp+9knWpa2vj2PXEwQuLOQd11Rc77fy1fu1zZJ9YzKFH5+rTmc?=
 =?us-ascii?Q?slO/I3u667qy5J+iyUNCQEfbVj7X3vNv3fkt8bR9LtZAC83s3O5PXYYS8E/t?=
 =?us-ascii?Q?f+xUbLjpnR8WwNyoiXGJRmNIECsTk+I1bsU5hanIPXe7ecOyvm+wjbDyfaB7?=
 =?us-ascii?Q?z4z+URdf1oLCls/KBbsvXiORMAVzn2+QBePpH54GabBPeKVi8xS9F5EKt0k/?=
 =?us-ascii?Q?AcJa1KXUK/74OCFUSzrOHH2Zn13QngiiJeUCY6VNv0dMkzoxDu4ADV/xeuch?=
 =?us-ascii?Q?3jvpdxSfvZbXNxokXQ8mwR6OFao6SSO9OTmGe6QznldwwYDyNCDa5Bd7F6CY?=
 =?us-ascii?Q?NmG7/QxP9R9RNuGSOccybw604xGbJKQ28g0OtBo+IdhTz1Mb/XA1XXhmNN1Y?=
 =?us-ascii?Q?KU5XumOfWKb00hZA7oe89YO1UCyzrTwsZ2U6qcXvLHC9Zbz6iHh33Ho/ZIFA?=
 =?us-ascii?Q?cqSBeqA8tumDG0L49sVeJxCGsphV/sDOOmdPBKPNF8i4FI1xddMlNLgpKPod?=
 =?us-ascii?Q?Dckke7SbdMl2Fxr6E8Qyz2LHeVxvHsX81R18gP2b+Rt5rQcZoiN5a0UAoLWS?=
 =?us-ascii?Q?uZz9eUVlzOtlNJhJ+rA4bqJJKbtlvARfMSW97vwjhAY9o8SEhXC69uhJXYY7?=
 =?us-ascii?Q?xhzdZ1o+1GNXUPOulY6OhsFcbeHJMgCPeL0JNJQuLPZakz52a9sOgV+/kpPC?=
 =?us-ascii?Q?4CEiyWxVnTEkRXEov0x/U7z3KmCAhL51LTChCbTLGOpaIcHpLlWH2KVk68D0?=
 =?us-ascii?Q?riIUCn5f8zzp/7bUPF3A+Ewp5q5EINxD6pJXhwjmFpAnd1vHbIg66C9ei2LJ?=
 =?us-ascii?Q?4e9hEgQvp01pqop4kFncuOcP2/EzJ4QRgXUnC7sTj/AcWLaed09jKf0C+ho2?=
 =?us-ascii?Q?IUkLxZ4/OldL+4dHcXU9sXSMKKZ/Quj4TQzPQ5UOmKZzAj7k3/hiQlOXEqrW?=
 =?us-ascii?Q?D+Yrnh7KpE94G8K3kzaheiQB+MhcGWOwM8aq6JONs3y9VtkzX4mMmOv0eYn7?=
 =?us-ascii?Q?vK575H8b5E/A0+DewBuT0FfK9sP819b2QK8xeQ986EMzlTya?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace896f4-ed87-4fe0-7584-08de88de80a1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:17:15.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IE8xS8loiBmAF/McedeiAStEY6PeSFMOkHruvQs9yLLf2UYa3DDB9pUl/68xt9JN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980

On Wed, Mar 18, 2026 at 06:38:14PM +0000, Samiullah Khawaja wrote:

> > +static const struct iommu_domain_ops noiommu_amdv1_ops = {
> > +	IOMMU_PT_DOMAIN_OPS(amdv1),
> 
> I understand that this fits in really well into the iommufd/hwpt
> construction, but do we need page tables for this as all the
> iova-to-phys information should be available in the IOPT in IOAS?

Yes we do! That is the whole point.

In iommufd once you pin the memory the phys is stored in only two
possible ways:

1) Inside an xarray if an access is used
2) Inside at least one iommu_domain

That's it. So to fit noiommu into this scheme, and have it rely on the
existing pinning, we either have to make it use an access or make it
use an iommu_domain -> a real one that can store phys.

Maybe a comment is helpful, but using the domain like this to store
the pinned phys has been the vfio design from day 1..

> get_pa() function introduced in the later patch is only used for noiommu
> use-cases, it can use the IOPT to get the physical addresses?

No.

Jason

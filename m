Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909D158557
	for <iommu@lists.linux.dev>; Wed, 25 Sep 2024 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727305479; cv=fail; b=SR98qxQifeh+jNV3VXN0oD7QD4G4wfkAhgiMJQsahJt2rjs2HruUeZIgNAC9FIOVxDORe9QMKMzt3C4ykbdu1q8Rnod75nL8FEeBvtU9/08I8Ch3x45DzEMdD7y5yXyiWHxcnBSddK0Y/5WNY2tDptMyrnPRnJ5B+NQMY/Vma1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727305479; c=relaxed/simple;
	bh=Ama69LJSZvo9DIjtb372S77x8n2k9cg9s4qlBZVvqzM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riFTFW1qbAFrZAqTqtxYv2MS5fFFq6PYANU9Y5C51aSEJBO3vFaaGyRE0TKThvNvgg8yDwqDpO/NOeNeaCXpFOm7Do9z9YGfmLb4R94NvqrrwWwRCMlBgAkHEj3fEEu/PEnoxYIR3EP9AEtfNTjDl8UOTO+QKjCH2ZVO5q9buXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DbET/jOl; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DbET/jOl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8Gvv588E7eF5amKopgQY1vI2M69RCaNPkLZ0+mm1V+T6pHoSEEBPMWxdlCzAZJZqi43OGdJXV8UdyXR0iOV0h0vENcxY/57nu2hqYxxmCNj45gqGtzRnBwGmE5C7JkAv27f4WgZbZbKY/s7COkPaPEA4EgPAdMcGItb8T/J6tUWjj0IlMTowE2xepbmR/aGVYEBD96AF23CnB+i4D145Acdi0bFECf8AUnRbPpEH3vSog1oK1fVkxsRkyNxNnF9303VCMIgKk6kDi0a4UdlEYaWN1o84MNAblq6u18iD99x6YCqJhbenB3lt3CiZvHF7GeudwEG74MjR9FpOeko8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIr0054zo7KonzOZr34uJU+WtwgLO+SVFYD3ndNa1fM=;
 b=CjQWS8ycALpKTrJszx1uUxFmQeBk2pUm+RWezrXXzWEaQfmmLFDDCQCohRWfNoApqsjn07ubQvHOOWbv/OXCz5SlkgNm4S4OOjlaKTjyEaFr0wUFZByqYb3AWI7JWKzrmsLMlQP75lFBU5KTW82rEnLEmSwjGrvpqrQZvoVpDRPeFivgWonAloxnYBwvkFDoX4DnUxv3qd2wkTx7zsPngeU1+stxVfWM3sAsDAdQdhYfdGjhkAfbJVA7fQ1ONeLqNUhZnqAKOBi4SZW+pLFqbMWxmM0UMNZIEu+f6jJ+lNNR9A7SCOU403jOJt9BovApzuYZQ8xguzsesrnXmQmAlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIr0054zo7KonzOZr34uJU+WtwgLO+SVFYD3ndNa1fM=;
 b=DbET/jOlpIFz/unyIXO5DSgLfUpD1Uex6TOcBQ1XJArEVUaXtg2vw4eVFKsAvXG4Mn/nRcanAl/1+1p4O+UmJZEhhUCP/439mdPNOpUwEkxZYHgWT2qp8RdkNikoyNKMF8YnWLmm6s5p7OSjENy5Epr7TG4Ffk2gWNG58uLJOJLqXOSAgNsj0KlSsLuSKYJ0B/lpIAgp49B636Jd+MJW6QNKpVck1rJp/cw67IAEJqQy9kmkwcTn0trtRsNWKyJkzduDq3thhgsOLOZOcGZJE0hufHemwoeu/fIGYrDVFWetcFCqAqqy2DwdeL0i3ogmbcXMf+z2upLttHpyt9X4QQ==
Received: from PH0PR07CA0021.namprd07.prod.outlook.com (2603:10b6:510:5::26)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Wed, 25 Sep
 2024 23:04:32 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::46) by PH0PR07CA0021.outlook.office365.com
 (2603:10b6:510:5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27 via Frontend
 Transport; Wed, 25 Sep 2024 23:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 23:04:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Sep
 2024 16:04:29 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 25 Sep 2024 16:04:28 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 25 Sep 2024 16:04:28 -0700
Date: Wed, 25 Sep 2024 16:04:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Steve Sistare <steven.sistare@oracle.com>, <iommu@lists.linux.dev>, "Kevin
 Tian" <kevin.tian@intel.com>
Subject: Re: [PATCH V2 2/9] iommufd: generalize iopt_pages address
Message-ID: <ZvSW+laS3t/16zEi@Asurada-Nvidia>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-3-git-send-email-steven.sistare@oracle.com>
 <ZvMhqXo5MQ24xVND@Asurada-Nvidia>
 <20240925224322.GV9417@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240925224322.GV9417@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e58913-69f6-41b2-6b15-08dcddb66ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c2PMW13cYxbxNxd1TAk+jSHc10ZoaK2c7W8bf32/AAoGy7lsTx2AAknxUw9A?=
 =?us-ascii?Q?nfeTYc7/mKTtrO/T24G8zpcCMMBW7WYeWhk5EZzHYekKckpxki0W6OshOrDH?=
 =?us-ascii?Q?ydy19V8enU5M+W5jJK3lgHbELVKmmDyRMes3SrsoyGPUTcylmK8mw+LH5zRf?=
 =?us-ascii?Q?oqEysKssTl2Ph0Mj84WpzyJr3Oc8r0TjHaJfGHPNLAwrND2IXygB5KUX+JN3?=
 =?us-ascii?Q?dnKMDw5rIldafD4VV1Uutq8b+yGY5vDSXplZyestvaxG55WqLHH5gnxjG14w?=
 =?us-ascii?Q?KFhhglxMfMv9spp7aqR7caDg6lYxgTpmuybQXS4Hp69MBEGYTFfiuE6FAmmc?=
 =?us-ascii?Q?Pk9lUUH9UyE+qcJt387tAAR4SqwsW41NejoI6ti7m3La7/6MG9XDLAJ47LZh?=
 =?us-ascii?Q?oi2qpROzvQymLiAQ0FFhayr7UgT/MUiRP2VXLgwTxBHBqn3efcce3EofD5IB?=
 =?us-ascii?Q?6OXoA4DzMxD9uI0YfjUVXXacOeOLGVCbR6Zfu7DdxloHB1S3Oi5P3nYMYdWc?=
 =?us-ascii?Q?kOiYha0uMNgEFqo7K48bfOfCZ0LZnEdy/7nq/SHYsqV5GvqGZhs0UAdPjNaN?=
 =?us-ascii?Q?Pdzxs3N1YDBUkDMxFwo+XupbgpYVfykb1PhOlnCKWPDulW1pIoO9vwkns/9j?=
 =?us-ascii?Q?6fiTrvc8rBBttnBKkEY0oVZ4bCdH32uh1Q+ncrM3Bi+r/7ol8sN9zN8k8/Vd?=
 =?us-ascii?Q?Ut21I3KcOmKk53LZ0/GP0Q1Uw78ZdNVomb/f6QkkjFQtuzjD/Xq6br9ql380?=
 =?us-ascii?Q?jtGWdVGvm4cnUrRbkQCXoPRnR7FgaqAxosF4Zy1NfSZGnjxx2gfzT39SYIiv?=
 =?us-ascii?Q?QZ6ZSnfUyhY/lnLQV8LTiNm3y1IzKchiege5hZ1gyJaq93d7nzVsRjsJoiNX?=
 =?us-ascii?Q?/8R66fU29FI4L0LiKeSlx3Cnw16aRg5pl83DsTIcyErfZEwETAgSIA0jLk/o?=
 =?us-ascii?Q?8g503bBYxAeaSGEa5kZlEMrCLiMpP5qvLVrcV/Q4+0B4OuGr8MpOXQANYKlm?=
 =?us-ascii?Q?yPUqsddJ8nVBOB/VGuqf+WSNdNVCx3eWlOnTLsG1B09rv2kO779Y4z9wKuyP?=
 =?us-ascii?Q?IHIwf9HZ7X8HNVpkttyhrv+fBWi+wvcI27723AxWyILfAa0GHwATzj16mDLt?=
 =?us-ascii?Q?IA1S3XjT50L8gTYw/koXr54HFLHZj6g2SrB+cK9SZnTafruDLl9sBHrG4mFF?=
 =?us-ascii?Q?ycdG1BU++gO5eR/8tZkk+DF9y1grh1vn/bbAeZmoVMbs5JgMtQGNfXvNPK3F?=
 =?us-ascii?Q?F5psHDENFwe7WcgkvlX5IA4Ls3g7t5ztAuWcvOKX05EqD4vRpkhsDaBLJVdB?=
 =?us-ascii?Q?h3t8GInDI77G/oUoT+qlh20pI+PawY24D7gaEqwaehyuEj+Q1Pn2HsVzbD/U?=
 =?us-ascii?Q?w6rW33IWo//b7wHnHlcE/+a2DDEe?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 23:04:32.3178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e58913-69f6-41b2-6b15-08dcddb66ab7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577

On Wed, Sep 25, 2024 at 07:43:22PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 24, 2024 at 01:31:37PM -0700, Nicolin Chen wrote:
> > On Tue, Sep 24, 2024 at 08:05:31AM -0700, Steve Sistare wrote:
> > > +static int iopt_map_common(struct iommufd_ctx *ictx,
> > > +			     struct io_pagetable *iopt,
> > > +                          struct iopt_pages *pages,
> > > +                          unsigned long *iova,
> > > +                          unsigned long length,
> > > +                          unsigned long start_byte,
> > > +                          int iommu_prot,
> > > +                          unsigned int flags)
> > 
> > I think we should follow the existing coding style by combining
> > lines that could fit within 80 characters each.
> 
> To make life easy the "coding style" is mostly whatever clang-format
> spits out. "git clang-format HEAD^!" for instance will adjust the
> current patch.

I see. That's useful. What's that exclamation mark at the end for?

Thanks
Nicolin

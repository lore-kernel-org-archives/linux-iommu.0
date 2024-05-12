Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039F4286A6
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715525503; cv=fail; b=WMcvHYaeVFuZ/mezxTsJN2V/1N9DB+m//eiP+OuGbfHxBT0+KXki4yDIiTTky+1pf4lCpSysD2/wf+o0j6cc/bKKUWMZCijG8nbkx9yuL/D0L8j2TwN86cThU+AMfkF75E+3sFwiXMD1ZbS0JhqQ/EZxDJwnxKGsNUfWtzi3UPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715525503; c=relaxed/simple;
	bh=PdhSWGpuy5ZEKWm4gSxkl3+Pl03pVB22H/jNI9UeVjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h4DNyxa286QT1kxyFGDzCisJ221rvjNRibvgCaFAWHDekiKNlaJccTFIKRZRCJEJhWCuOpKT3t4TBdZDjBnTNinLcGBIgGOiJpwUziRcYVuoWu26kOLF2RyLahIw5xSsj7W5SRQ2huwUybyBBAJd96Pf9sPAKSWoFmc9PsbrmaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lB9YQAqz; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lB9YQAqz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAu4uFJoLp/AyY1m3cbyCLtmzN+jKI3G2aMKe4uKfYENqsTNXEiKcZ0ZeoESFaIYpxasYaWVTDsHHsuX1ns4OmjytBfD6mwes7EBrtn5lRgne/I3DLLg63iFP6mAtz6RAXJh8nyAP1fdDcMSe4riU1vu5v7jrulDdsAqyBnckYlkVi4yIcKL62g8F1QNEkq1lxEY//JbTZVQ4j48WWXDj5tiNeGzDaa6zzGIEq7xAbQat6nV9rx7J2809GC/XOWTHBx78pN7sUtc21tLEmEiLx8c345S4P5gGKMtZnV+9p+N24hZoiI0dzfEiXGXmBgNPlDjMwhHGLt182p1T0NYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJEK71XfV+cv8btD+D/W7LLRXI7zaqEU7iBnzG/Rkls=;
 b=eArt7RmqQaqgMrWOGmhr7+VTMMaScgn8iPtc5kZAR7+z8qWjA5Di7GBfafwkG0PqLUQ3eXFNNAiP87BcYA5GiOMFuIBwLyyG+wEfwd5olnIwRbbmWGnG7FWZdEnTGNWZQh8cSomeGpn2tnre/w/xOgI6uUBrdhvnr+6FgZAI8lWPnaE+tIPgP4wKhHg+VftD0T0NeB7oEd8mlyHfiXcuaQ9CG8GHEM6EMVbo3Aw8e9nVnLLZ4AiguNiBEggfugSoWBqfPOpAtGaR4YWePFZ7hKnYEyzPilVOIAXtqFRodZhPyfVnSc5qk0kS2OLX13qTRn31nIksTApmIlhpXsgRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJEK71XfV+cv8btD+D/W7LLRXI7zaqEU7iBnzG/Rkls=;
 b=lB9YQAqzIY8RMdngCwUUHpgASR8OP/9I1uAx8BFOvGXLZ50vXCMBZPyQfUdg36F/XmbnQoxwiHIIif+mLgckzK4KYBnZPfbu/mq30hYwNHoQwsLVrpBVaTL57Jyszrli6Uls1klsa675kZDr9wXGUOtHTPmnj1UjjxtCm1D51igjPeOQqUQtC/TnJVSTdB9OTqYw7YeqOIRdBHijl96E/6wDx8q9MZDo65YbxegsFbZf5aLWqe+5gpes/Grq+jDaBd84OjOtX/IYS7/45rpGck3/IldtKsMpo+WJDxX/5x+owfpR8+2GkGwqWporf0PsPFFIRDgFJ9qLvqb/CW3pIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54; Sun, 12 May
 2024 14:51:38 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 14:51:38 +0000
Date: Sun, 12 May 2024 11:51:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Message-ID: <ZkDXcyxxriFk63Ba@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BY5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4a1418-3920-4d9a-efba-08dc72930741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5VlnQj/TcBC7JL2QbImCPrQYsuTDlk0hN4+8mXXjiBdZawAusHzbiyUjjYEU?=
 =?us-ascii?Q?Gmps+pTczHa/z2PSZ4eO716OKKmelAEOqCDY5fXMb3JTSdNUWU4BpvnYV4SO?=
 =?us-ascii?Q?XnZDc8vkrWqeJNvJhHZ5ugCK80QeOi2DwvxsPvlTkV5iGG8nXscquo6gYQsu?=
 =?us-ascii?Q?Vp2v2FdiiF7zK1TkgHvg7+L4Y8NWIyuXfW4NmaY0Cl1M1mYiD0mWDzswquc+?=
 =?us-ascii?Q?3VdamGUGZgolhI4IKPtsHPYnDDCXpU+IXNFTxMjEPUB4KGBbYnoh+F1Sj/R+?=
 =?us-ascii?Q?ao+AP+s5LObgoPx4mEF8rJT/jiY27VxtMBmEK+RYne/nt+eipbfJlxEmvgNl?=
 =?us-ascii?Q?vGSrgvfro+RQsHTbECNxbI+96ekLfLI13lB1jH4HjwXjzFUsOKSdW/IRfYqW?=
 =?us-ascii?Q?KhJFgv/rIaMLZf98Za5jq3uzAg/mvLJg8TCKJTRMVooiG9+nNF99GPAAseJr?=
 =?us-ascii?Q?fZBpYNJDjc7W7MVyEI1lJXQE3Sv9r37rzXJhcH+sRL28sxgPZIMuri80eeLe?=
 =?us-ascii?Q?q687LrExE5kmeu2drYikcggXbaQyemSujVqyzAJA370xaga/vzpBG8XPIC6N?=
 =?us-ascii?Q?AeFE8med5eaUdjos59JrlAHs3tuqV88qUZu4VY8IwBYw2+dL34jZwJU4buxl?=
 =?us-ascii?Q?yfmnBpa+K3QmPwFEizs+T53nVp2L07qp4tz0TxgWQmHVajaK5fHxwtBTx1FJ?=
 =?us-ascii?Q?ulgflnX5DnNxy3xCJ5Ktdthi7BuasYf1lRUOfAHvlLalB757GCUyc5i0xUUG?=
 =?us-ascii?Q?CUzlNRo/QbEBdWxWe0Whoq0XnQPKOvgcf7hFy6OAtNZy+TcSQ3LjWmp8fqLG?=
 =?us-ascii?Q?zP04WPEQrJDdG8ET40YlwlugDj7dDCciZX987OMlF9ZNjcW+vEq53x+hLl48?=
 =?us-ascii?Q?coBiT8EwCP481YHmaGwPLgwj+PSUpqc+7/5+NoFZFgCC6gsF2i+ejFfs0O94?=
 =?us-ascii?Q?K6RrPRzeRC0WoAKO6kBmcvvcLyjcWFU4B82+FnRnJlXhZJlzazPqND/t9OUr?=
 =?us-ascii?Q?ivIvQtx45te5f7WrkGcxhXaJx7E6YlOMgSHg5J3hWyG7vjv/qLvOjNaDOrZz?=
 =?us-ascii?Q?OxviWIayOwrL0JI4n7QR9wrRl87Ab5gUEF7jGkyxiPmOnOeX1Kb/lfk1gpFK?=
 =?us-ascii?Q?3tb1ju2Zg6T86ukw6TxgaK92pXKggMw42JW2xM0jfakAaG+tTTO9tkdnSjof?=
 =?us-ascii?Q?EXgAlqBB8kyRUxQmLDmMVt2FYQhIEWjP3lv29KuII4m6Yz64C/FKJfmsriv3?=
 =?us-ascii?Q?E76R8wNlzzJsWiG6oSJeqDOWn0TAjn9KderLRlXW1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RtonTzpwzDJ24qy1cJ7iuMT5QRcJhhlAfqrJuZaeD2N8mP28INlCnrgAu+GF?=
 =?us-ascii?Q?2TywhUwsNMTLppO7tflc8OFdHUOmJrvYSjnbfNxRUDsGpCHtoKroMn6qp7F4?=
 =?us-ascii?Q?6Ko73ROWPGkOD2BLLfOkGZpZwQiUdJeviyZ4SKuCMhSJ1R5gutAMhkhbuWaJ?=
 =?us-ascii?Q?HhL0wL9AtN3k10j5sbAuJCNnxBhq2e4RXUK6e025yP/Bqxi6LrjzkQ9wBngD?=
 =?us-ascii?Q?RZcs6heJU3wrQGUd+JByvlVggZiECwI/0CmhkaAcge8oT251WpjrollPcx3y?=
 =?us-ascii?Q?9wQS4elCdjGGjVwKnghLSzsI87xtbadv0EN+3t+7qmmlWoPT11ciYaZ85cNq?=
 =?us-ascii?Q?e7Jmfi39kKCn7xs9XaauDdga8sBJkHsVdcw+6MQKVV2CzPHOSxhJLO3SGXW+?=
 =?us-ascii?Q?DTOiRnznZYnX4uBA7FbXCHX9ZIz83cOnkgBFTLSfk/9anXvp9A/RasIQ8KtY?=
 =?us-ascii?Q?DZ6FckoVVCgtBvWobhRoHvUjXucQlPtC6bxmgZoqe2KLyrZrQTkX4riQEw1p?=
 =?us-ascii?Q?sbNRu4Uuy3xRZLZfAzKpr8p07JDO3lLabLUKLvSrBvRdy+cTNmqQm5EvNWds?=
 =?us-ascii?Q?HX9JdZwwikylilCkViaAtsrJvTTo6D5QXZt/XzzMuZEim971jcTfjyxZ7lWG?=
 =?us-ascii?Q?KNBEyQqH197yo/gP8VBKplob0x0yERSqCdr5Lv/tgY+K2j6JQgfq0NM76qg8?=
 =?us-ascii?Q?OGIYc8ahYagy95FEVP84oVbr8GxYV0h4R5farvanrIciHHAV8EThW+aqgu2U?=
 =?us-ascii?Q?BxOObAdWue/sDWbzs3Rc3zFa2YzF36HiVJZZXM47ZqL3YI/0QaJp21DT7mXU?=
 =?us-ascii?Q?RE47tp5GTVTlhkJ0YyhldcjLeXr74tep3xMEeFGoAY6BXhuIB5Ud9aiAD5iV?=
 =?us-ascii?Q?nN2mYgMtQZKSSlQmcwsT+rEot/Xm80589doRdJWVpQ3itOKi5jq0K3PKNpZx?=
 =?us-ascii?Q?zUNB1dTdj5nyODGu3wtlKaBgngI6+AHRC/E5ri16ydG3KlV2FXh5gLJc9vLu?=
 =?us-ascii?Q?oxANgC18q/0Uyi6mdnKbOvor/iGrjMttV8F6eJnswWI6pdcJoZRnHwNNSsBx?=
 =?us-ascii?Q?1IFrnJXljbaVfoNOJMQ+GaK1tF9d2kZdN7B7h+IR2a5Kf83/egGsaNpagSjx?=
 =?us-ascii?Q?q0ojBvUREZJcU6t6R41aIy//JyBh+NGVBqJ2nA+LF7iuTNcVXE9s48zSpOfG?=
 =?us-ascii?Q?Zz1vOhkK3rsuFDI7KwbXmMk1uMKd2eJ9TqwTj4WYaiNhF6hUtoN9fLTQdcjH?=
 =?us-ascii?Q?gHKgCNS4gr7ex2UY9aAVUfn9f5qAVLnll49JkKibbqY9k1nXx+e9OZgmroFb?=
 =?us-ascii?Q?aY9CwQv55vOvUAjyya4aU80hACgxa4ZOqqyNJcGR2/D21hOVocltCZypKlYH?=
 =?us-ascii?Q?9VyIXHnG1N8o9hhAqkbjxt2R1maZRtODoacrV3Dfw388zHkq17e9f8fyb3RL?=
 =?us-ascii?Q?ECV896a3pDUq2mrfRppSkmMLanJOpKibtm719Uwl3fny4Puy09X3NL05nMIo?=
 =?us-ascii?Q?wYtzmSn0WhjYyK3OjQKbmNGnMcq+0j84Ov1ptFNMauOHZiKZxZpWNed2Vz0g?=
 =?us-ascii?Q?udiFaI9py1sgrmaAfA8AVyFDCTwRAMHzq4rlgugh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4a1418-3920-4d9a-efba-08dc72930741
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 14:51:38.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uPqpa3jKkr34pAp/sQOnz4IvSJnlsjJVGnmi8/zQicoOomP9XTasyOjQ/JRyfuf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615

On Fri, Apr 12, 2024 at 08:47:04PM -0700, Nicolin Chen wrote:
> @@ -94,9 +94,13 @@ struct iommufd_viommu {
>   * struct iommufd_viommu_ops - viommu specific operations
>   * @free: Free all driver-specific parts of an iommufd_viommu. The memory
>   *        of the entire viommu will be free-ed by iommufd core
> + * @set/unset_dev_id: set/unset a user space virtual id for a device
>   */
>  struct iommufd_viommu_ops {
>  	void (*free)(struct iommufd_viommu *viommu);
> +	int (*set_dev_id)(struct iommufd_viommu *viommu,
> +			  struct device *dev, u64 dev_id);
> +	void (*unset_dev_id)(struct iommufd_viommu *viommu, struct
> device *dev);

Actually, looking at this more closely, why doesn't the core pass in
dev_id to unset_dev_id? Not doing so seems like it will crease a bunch
of unnecessary work for the driver.

Jason

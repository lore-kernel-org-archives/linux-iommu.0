Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2F4D8A7
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722966168; cv=fail; b=E6+Ch7iTs5ofzUAl66jH4hmDyx/e6JlDeF1Jh3G8W2GrwL5i0suwiSbB6kvrMuE2yPxiHxhndmHlBvjE4W6L18xyZjvrXmP2p5TfpVUEtRjwFPMZ7WyRVRiydFBjaGopR/VrqM9ytycLHr35wChzl60V7OJG3/+BDOuSCSbE27I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722966168; c=relaxed/simple;
	bh=OdUwTtwlRY6a5wqlE4l131mvLNwB8NMQPA7H1UoO6ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MhzS4chO03bxgNYis1XHBUGR/HQ2ZF95OJ5/ChoOF4MurJZWdowrp1H5b0btXdiw7XOC5xVqLnsczPDzgPx207gQ/i1mCk3WsqVafa7pbWy9o+g6wHBv2aWwpKpeUjCzHQoaGTrGssF8LTw6cm8UztYiUdZvHfmyHL3jUtMXxsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RgDFp3Ed; arc=fail smtp.client-ip=40.107.100.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RgDFp3Ed"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahIWkSMkKbKY7rmBPx2WStkbaAebcn7SJEeKMCflW0Rhjl8lyZEGw0RXv0OHdCe+6BNrEghP22Io0fXFhbGrFrgeVKDVcVEb8gBeNkKrsPg49/h+LBUol4SxvoqhHNr5D306LC2zNC4aGKHx/ZLJn6pUJGVMaKzW6DVDbUR6OSIP3vkX+K8+UrPY6K0aJ0BA+F55zykYVoaT1D3p8fn/GnRGMYonu/TiWlrodaZUNPJelpOBvmBeilWaHJiVuiQQwWf2jOVKv4GY5KUrvsO5kcPdGJrtPVFzwxZl+qwG2mMqUyyNolOJ7kR/wEbrTE8o2TRkxzbYfTrAUV4TB4Y63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ac9sD5tBZw4ys/ng2n0xRfYIcRG5G3dO1exKT9MtB0=;
 b=CkGjJQBOSYBx6YI6CKF39bbijHBUv4iB+cZ4oxlAq8lhF15hfqsMkAeJpjoVZcww6hxBHqOVShFIuMa3RCIHNL4Tn6ls7trOJCBVbdbHtWKBU/BteYSg5utjLFHk0h40DUexpJY/anFKjihMZiKp0tqBOLsaaZDF1FwuG0OuNHwyMQqjpFZ8AzJJX7fpRgPr2tOnGjjqkRpUe14/V84NjqfzdHkMUvUZySYht7ROvqV+qXvdIXyJ+ODZZD28TrKUF/WsdlPgINZBnlpF3EOJXokN8HgcAH4pEe5Csx6Nmc18gMeHXa4EMrDzPONRZWR/98HAsOEEZhe2NjPcWhodIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ac9sD5tBZw4ys/ng2n0xRfYIcRG5G3dO1exKT9MtB0=;
 b=RgDFp3EdNy5kIgo9eeEIbOZTSdso2T+tncOPKjuW8ckcI0CG4+yKn3cSFCjWxQGRZm15guRI/j7aqpt28rVMKoohklbFbRxPLQecRma4Nh3gxqrk1Tzw9gtkx5FGxnBSE4gHtpU6zISPnBIot6448vxnkPoua9+bBejmyZiF0oinlS4rXY1WQ1UnwP94DxpGgw6EnkvwqPVk4CqcvWOqGa/ND+OC5NDZc381+Jq7UHKK9/9tVTIqp8efGFJrnwX+hnUpI4HtESHXGj2fVN218fdxAyMNMGJukymH8YUHbO2ftw8dgVgcwy1pRnFLdBNLE0QcTfetZKsnTj4UanoLWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CH3PR12MB8545.namprd12.prod.outlook.com (2603:10b6:610:163::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 17:42:43 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 17:42:43 +0000
Date: Tue, 6 Aug 2024 14:42:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommufd/device: Enforce reserved IOVA also when
 attached to hwpt_nested
Message-ID: <20240806174242.GP478300@nvidia.com>
References: <20240806050201.3717816-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806050201.3717816-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0911.namprd03.prod.outlook.com
 (2603:10b6:408:107::16) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CH3PR12MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: f85ece91-4af1-488d-c51f-08dcb63f2cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5EulREIEGN9Eqkv/5iTU0tu3oefZ/0T3q5NMBu7HGnffNh6Q9Tyy9NU6uPm/?=
 =?us-ascii?Q?HuLG2vNx5wob9OyieJB65oq/lREchfeDNpS0P7E4NhOFCa45Cu90mPCqxndz?=
 =?us-ascii?Q?tqLvfCofuxOe8577j1eslxv3xPPDgTWRVmqRwRgwgJV5Nb7R1Izp1f7oAgWk?=
 =?us-ascii?Q?jn/XX8okAroanJ6pRUlNShUfa1qgh/wmozJsRHhoUl6Ft6MRljmem146hQ5b?=
 =?us-ascii?Q?ulC305V7yft5IgTd1iLOBVIr0zZ5qN8utZvOTyGdd1eMPM1tf2gd4fCTyROh?=
 =?us-ascii?Q?6uk0RLL3DRgzDuZymrSfP7WQ1OcdLxkahJkA5pzwSy8Ng4CW9mQBqN/pUol9?=
 =?us-ascii?Q?bxsVNbWlT1QQU/JZM+zzH0lt87RT0Emdl78ul7RbhM4wRLgd6Kj8PqPHaGvZ?=
 =?us-ascii?Q?qwlKvGzyosfCHjZxHntPeMJo4v59MgjLssTI/Ayx2eaJV3k3QqcTxasmhQHr?=
 =?us-ascii?Q?6jrOGRP12EbHJPTBuU0XN+rb//8PWV3Rs5AAwmvlODzHHYLv2UyAstUhrJB5?=
 =?us-ascii?Q?WtGO73+T7TNU0O8KSqo9J3RkQCOx96HNZr/zG1sx4roNQUdVzCGlL2ogXVgX?=
 =?us-ascii?Q?ThiOAZdSPgH3PXMI73BjcqoikJC+ujIh7BnLmu9Q0yuztqMS+BRGCQ8WOIRu?=
 =?us-ascii?Q?bSj2p9W+HKO/b/m8tqSuqjDyfgk0IrxyGNCxn+K9vKjsmZkg1GowFwthx/SQ?=
 =?us-ascii?Q?j1r1i7OjgKy7a5pnkL1+fFCh7qovaAtVg0yfa93c0YlfyedZBQRiBBzoo9VL?=
 =?us-ascii?Q?DjdUgxKJqkd5P3DqZlI5kDIA1b7H1kFd63DenTobWUeETFHyhzahthpIrKTB?=
 =?us-ascii?Q?E93UaS+ITdngeQFdepY5Wy9+DorfptIMvbEWrFcjDQExhxHLxZ1XDop0zhMS?=
 =?us-ascii?Q?wLrOaVc/kFfLa9hKGmpaD0Jx0L/AdA8ZxjbaiJ1TAOoaB58MGyUUJLJZEj1K?=
 =?us-ascii?Q?3ebEFkCiEoTDOn5pBa3D9/WtqTZ+kF1Bvzz/94qLugf2eUQXrXeMQ5ngTuWS?=
 =?us-ascii?Q?aOzoqv4+doqCR2ZknXWJD0/iLg7V9Z9gvn0uvLlU+czdGBNpgOq96ZAhZK3U?=
 =?us-ascii?Q?UnVebaq/GBL/0yz/eGpHzuCbeCVhETv0xKF/7VkE4R8J/khk9xTE06Saz4Ic?=
 =?us-ascii?Q?0bRdD9UZ5B9jvPnKWQT39pyIQEeh4n3vMsfs6j0q+wyDmQMREnGt4XNFaQAe?=
 =?us-ascii?Q?HXHlV496SQMU8h2Nm4hz3+4NRzeyZV4BVdUMxLTdQMml6Y6FT+Px3qmksM9m?=
 =?us-ascii?Q?ECDriNSBoY5R31O9sRbrkvAMu9J4UOGoC/5Di1s+KiHra3oD4VkTwcbrIaxC?=
 =?us-ascii?Q?/6e7QWFCzxyMlf6PN+z03/KNh4yXazPZHfgtZPMfj6BVndGHMykgcb1SFGwT?=
 =?us-ascii?Q?v7+Jxy0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Ij9n+HBgL6MWcQI7L5cNt2d7iNGT98CSHN1tsaAs0VloZbdigf1aYdEmIgw?=
 =?us-ascii?Q?2qyXervCpE86I0h3aeTEJj+tJHp1LFtQCjuHHBuyf4ozSp5z5qL5wuwGDrO2?=
 =?us-ascii?Q?mF+y6yJMop2l5B6TbKVypQCczIKR2tb1F9GG8EUvItYXxuxsjXrcyCAMkxUi?=
 =?us-ascii?Q?PB2+MV0KbEe5of0ssNrOBtQLfPxEPvlqQXiDHsvQe1s8+1kMtykqg72oJryf?=
 =?us-ascii?Q?77G6AfuOIiyjZAAJxTcGvX602N5lmSpFOAe+9dpoYKyhCLif9es5ufJk4aBw?=
 =?us-ascii?Q?9ycfC2hyYfaqjz482aClCyFVkIoXfVKtSzD9+0AO1pvuzx49nKKZbxu8+15R?=
 =?us-ascii?Q?7fPzuTN6m9fhrjzuLdEtVIyj3T4Y6FyK3kPmLw46Bal1zmAb3/w7qR6aF1YL?=
 =?us-ascii?Q?3+SFj6/XueMTkZtVuYZEn4J0JzMyers0CWPHlyQyx6D9RjN7JQUnf2I6WIcC?=
 =?us-ascii?Q?DCbVzWCMLA0bcKaQ76pfWZn8n8eZ/bZ645aHloGipJrOxGNShoWr1ZIQTJXu?=
 =?us-ascii?Q?rZ3EWLxUgUAmGxVbNC+64Ynb8JpXNjQa8X8v+BywCsAIqp+cXO0/udBdYVjU?=
 =?us-ascii?Q?mSNc3qIOFRpkN1Esz1Nxl6H/W78eRKvujEQYPrSkPWwr5H4DgkUsJpZeYd3K?=
 =?us-ascii?Q?qpwv/AnViABjsR6e77AvOnqEupZcCQudv24HFIC3pQhgaILBO6SmVOmtpX4i?=
 =?us-ascii?Q?n4yAFKY4m5p2e6ze+GSk4wXLx+KYQAE7AVlReTbELkd9DKDlOytDJX0GV8Ms?=
 =?us-ascii?Q?X+yExLucnEgBZ6r9fRCbB/0C1b0S7QBGqXWrFdoHZQMu6aWZpEe83rxWAaCo?=
 =?us-ascii?Q?SHHc6T/Ygd7oSQ9O9FpQivMO1+tyzinKNCUY307x6xE8XZm7K9zDSBShNra3?=
 =?us-ascii?Q?EU9d5S8w9js3SO8Zc5b430u4079aBcNOYcmFWftoZAhDH5Yq2uTq9oiWBdPm?=
 =?us-ascii?Q?PJ12q4jRGN97sEDbti269cccZazc3B3zExbA6DD2NJgH8SirB0pZ60RJEP+t?=
 =?us-ascii?Q?qU5BAkpurU7nig3Ealtmh5rF6nDHXPiFDKdUJtvUrQnCdYtHdqaaruBbGRHe?=
 =?us-ascii?Q?fCSxSeosYeR+gkXER21zcOp/DSjoB0krHLLhlB42PVeU7csgvK8gaDomwJCH?=
 =?us-ascii?Q?xxwJS9RUMZ5/nTiHYLfOMhf+Um/fHd94gTJ7sTZvjSsx7Lv56WgtwE7tdujA?=
 =?us-ascii?Q?I7EC0VADDQrmjx+N/qPqaY4d+I00oQkLZPaPJqvOGd3FslVGj7kdG/Z9x0t7?=
 =?us-ascii?Q?+Vcyv71C3HHVzDTvHyKoVgw3g2RodtWTH2zDbJBnza/NLBpzAf1jAuuTyfSu?=
 =?us-ascii?Q?OVKW8PsO+OkHiVU76tgw0bO4XEXWOc9IEYkIUItyOfRJJIYr/sufqn2JU+q0?=
 =?us-ascii?Q?kkozbzKiLMOvbmrZF0aeEvqfvliJ80DdNjeoDzLjVl4PkHopfTY3pvhFnhZv?=
 =?us-ascii?Q?N+L1nq0HFaZn7/B+QE1AQpBMMyuYcL5JvSh+3+RsrPoA2j1LCFX+TcZNvKAs?=
 =?us-ascii?Q?OK2SNNWNErRdQYSsZsxbfNHKPn+FNwSNqOchYH0ibJe2XeAR6nwm7R7NB8Yo?=
 =?us-ascii?Q?S/txnPW8YKjlxaq7WMpR/N3zrZvWr48xL8AmPmQe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85ece91-4af1-488d-c51f-08dcb63f2cb2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 17:42:43.0318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4S4nr9hY/jz+hvG/t/Udce4rh1a+lf/4jNidmqHMy7kiqci35D+kQEy6Okciaxo2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8545

On Mon, Aug 05, 2024 at 10:02:01PM -0700, Nicolin Chen wrote:
> Currently, device reserved regions are only enforced when the device is
> attached to an hwpt_paging. In other words, if the device gets attached
> to an hwpt_nested directly, the parent hwpt_paging of the hwpt_nested's
> would not enforce those reserved IOVAs. This works for most of reserved
> region types, but not for IOMMU_RESV_SW_MSI, which is a unique software
> defined window, required by a nesting case too to setup an MSI doorbell
> on the parent stage-2 hwpt/domain.
> 
> Kevin pointed out that:
> 1) there is no usage using up closely the entire IOVA space yet,
> 2) guest may change the viommu mode to switch between nested
>    and paging then VMM has to take all devices' reserved regions
>    into consideration anyway, when composing the GPA space.
> Link: https://lore.kernel.org/all/BN9PR11MB5276497781C96415272E6FED8CB12@BN9PR11MB5276.namprd11.prod.outlook.com/
> 
> So it would be actually convenient for us to also enforce reserved IOVA
> onto the parent hwpt_paging, when attaching a device to an hwpt_nested.
> 
> Repurpose the existing attach/replace_paging helpers to attach device's
> reserved IOVAs exclusively. Allow a common hwpt input to support both a
> hwpt_paging type and a hwpt_nested type.
> 
> Rework the to_hwpt_paging helper, which is only used by these reserved
> IOVA functions, to allow an IOMMUFD_OBJ_HWPT_NESTED hwpt to redirect to
> its parent hwpt_paging. And add another hwpt_to_ioas helper to get the
> IOAS pointer. Return a NULL in these two helpers for any potential new
> HWPT type, and make a NOP in those reserved IOVA functions accordingly.
> 
> Suggested-by: Tian, Kevin <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> 
> Changelog
> v2:
>  * Corrected the ioas comparisons for future hwpt type that returns
>    NULL by the to_hwpt_paging helper.
> v1:
>  https://lore.kernel.org/all/20240802053458.2754673-1-nicolinc@nvidia.com/
> 
>  drivers/iommu/iommufd/device.c          | 77 ++++++++++++++-----------
>  drivers/iommu/iommufd/iommufd_private.h | 15 ++++-
>  2 files changed, 56 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 3214a4c17c6b3..949b69c9f3b2d 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -327,13 +327,18 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
>  	return 0;
>  }
>  
> -static int iommufd_hwpt_paging_attach(struct iommufd_hwpt_paging *hwpt_paging,
> -				      struct iommufd_device *idev)
> +static int
> +iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
> +				    struct iommufd_hw_pagetable *hwpt)
>  {
> +	struct iommufd_hwpt_paging *hwpt_paging = to_hwpt_paging(hwpt);
>  	int rc;

This seems like the wrong place to put these types, a big point point of the
struct iommufd_hwpt_paging was to mark functions that should only be
operating on a paging hwpt.

The caller is expected to figure out what it is doing.

>  int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>  				struct iommufd_device *idev)
>  {
> @@ -363,11 +380,9 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>  		goto err_unlock;
>  	}
>  
> -	if (hwpt_is_paging(hwpt)) {
> -		rc = iommufd_hwpt_paging_attach(to_hwpt_paging(hwpt), idev);
> -		if (rc)
> -			goto err_unlock;
> -	}

Like we had here, so it would be a bit nicer to write it as more like:

hwpt_paging = to_hwpt_paging(hwpt);
if (hwpt_paging) {
	rc = iommufd_hwpt_paging_attach(hwpt_paging, idev);
}

Then we can keep the clearer labeling of the function signatures.

> @@ -321,7 +321,20 @@ static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
>  static inline struct iommufd_hwpt_paging *
>  to_hwpt_paging(struct iommufd_hw_pagetable *hwpt)
>  {
> -	return container_of(hwpt, struct iommufd_hwpt_paging, common);
> +	switch (hwpt->obj.type) {
> +	case IOMMUFD_OBJ_HWPT_PAGING:
> +		return container_of(hwpt, struct iommufd_hwpt_paging, common);
> +	case IOMMUFD_OBJ_HWPT_NESTED:
> +		return container_of(hwpt, struct iommufd_hwpt_nested, common)->parent;
> +	default:
> +		return NULL;
> +	}
> +}

There are alot of existing callers of this, I think it should get a
new function to do this behavior and it would only be used in a few
places.

It is not OK for a NESTING to get into most of the places that are
already calling this.

Jason

Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011005.outbound.protection.outlook.com [40.93.194.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7B48C404
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043415; cv=fail; b=giIk2ETdEtxvlu0dFrlK1ScKGYYVfyBBS05pMAr0CEWbJO86eKA+BJ4RDoCcv43jjfYMQNJJMTfr6A7mXNXRYJcL4g9k8TVFq3F/fKwzCqcg/0YlIjoa9hQ3V9J5Nxr51xX071na83GYukFIJPZFKIMIkK0FaboxecZ2HUTXaw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043415; c=relaxed/simple;
	bh=NUPNZMWncZegx32U3wF5WgQyQGpvxqlDBIiMJRI4Upk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=skmD/fAcLgUkqZ+LAGrZyJBHDTEaz6d0/1oPd09+trL5ePYK/PM+2C6PCVI06HngsxCVRLkMjyunV8OfyMQ9j2STd959Fv1xBpALMVOViHZ7QAGLLg5E9hiu0+jmEsg+Xgbyy8ASvuDaj8DtjyQLu6RMfE0mTV+F4GBrgcOkuKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NfIH9/dD; arc=fail smtp.client-ip=40.93.194.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NfIH9/dD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgahEUiZQlniTnAmTqviTLWaEPQ8d9IXKO2QHOMQL9yXKpey7ajRhWnHa7wG8FFwkuXf+MmmfPbxOyPmP8jEvitJzZgk4cxr7OkSrSHVIkQjD+aE4sjxVTi5a05uFw0TAhcPcUz92DYDJ5GZD66tfNjB+XwM0upOWZv8PDvHw1AsjoHX9O9VvozFDxUk4paZp8cT3GAgPcyymWKtgBI8pCPEDvnyQBuDXwFniZvIkSz5JgRp6MlEIfTjyhmTKrK5NbuSDPc7jiVpDWiFOtByvNFXWetVfHu1VumvFxzIRLeoBGN4HVnuC22ouRr+hWiF4kz2var8B4yj8R49ZPfjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E/tuJ7DEMtniFev/IlmbCE46gjlv/qOOvdOk9mgOXc=;
 b=f9rXGk6DEv0quIl0MjKjdNNxT7ps9/XAFKtLC8tAEQMSYORVlRceH2vp5360KyFQxyhy4f5iI/1Ul59F5jbFWyvWTGXZztC2r1jiOUsKL623YIa7hOePygd4CPR/pc5WAMsbxFI0xIW/1OYPeYE7VHyPTJyqgw7ynvb1AEYFq/pZSRQmBi4qXFo7gYbAjNbnj3KXDfVcoTFQ26a99P0J5Dw6xr2Vl63G0GGUVcYzpee/iZuyYXKdTnhHMqtyuyCuVpK7Vo73VD5F78e3iv0Z3RzdCliRJ0RxpM9/YdICdUoUqmZAMR9y1bMz6nV2QlznBFuwSDASGttaEn65Oodf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E/tuJ7DEMtniFev/IlmbCE46gjlv/qOOvdOk9mgOXc=;
 b=NfIH9/dDhtSIRRhpEByzy03V0cmCNGQ6nv20wxsJl1icj6ALhfYKI60DYqinfLAUYP8MlkVE4qqNFpOcNKG430VLSupC2r5o1r0XU9fvs1LMBCLdBnCYFPDs72GUPA1AAAp3RIu56IUPLgHnoQmqV9a4kzfAzIiMC4e6M6Q2BQKmvfi+mqh70NiD5OtnTEbxAgRBlYRAX0dFXGq82kd95cEmQKU6FI8QCdvvvFrtgKbi28Pd68HhiLDvRVpm5ozswEqf8pqsm5Tm4OzYCGHL9ezwA10N1HsuGOPB/ESwbz/BLIYG+BY3jDdZahZGRzB8GfCm//LWIxNGJpoRMwpBhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB5635.namprd12.prod.outlook.com (2603:10b6:a03:42a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 15:36:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 15:36:29 +0000
Date: Tue, 14 Jul 2026 12:36:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v10 0/6] iommufd: Enable noiommu mode for cdev
Message-ID: <20260714153628.GC3695849@nvidia.com>
References: <cover.1783360051.git.jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783360051.git.jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: BN9PR03CA0438.namprd03.prod.outlook.com
 (2603:10b6:408:113::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc422ac-946f-4be3-9233-08dee1bdac6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	WAqAtAS5WDI7/jVqZRoO8QJGsiJNF/zL69cQgSb3Nq3qBwBouQoz7MWK+hW7WJ9mypgZM+R0eKfn0MbFpJnKvUzeYJcHoTzmjwVl6hpYtCZ33qFn8vQURqzL0itbr9zXtgtNeMvYveAXTy2cr8xLk0USCmJpqsNtsamQrL6DmoL9wAQXzPJcDad/x6NLeKTlDjSX6E9pabIQbAk0jqMAP3EbsrcHQtKBLIzeZDsrZZznBwQH3Xk55vj8wNUbMFYUHXPUe3KHT+7Xh03rgrqq0mBDQ+ihegMU2RexqcIfXafYlMnJutEPNUrKaBJgotpNiKvT4LwMkCIj4IVOBQW0TZIAE3TuAwOr4cTbF+wzd3DxAj8LRLw7LBVFDKU/1WJ8lkpJPXzwUIC9N9D2lhbcYP+wf5M0q6nnkq17mdSG9KzDaSd76ZageDF6eSC44e3DXMNut4SbwRm6kz4TUnWsFrUkqVIqVQNImWPaNiAk3l9MKa5FyKw5q44qeASTwtWrub4IkbNrAvTcFWG5f+IBrCi7Z0LqKTYEM7PWR+1BXyn/cUlOizM1sdoAZQTdEBCQ1UJr2n2/kVC4PwQUumg1KKiIkARll1Y8xRobXX6IHvYmoU4jf2BAyfcBZPMSMD8GOx/BZvEkOZSw8VdT2wheAQA7IvoAL2eWmCojYYEoLug=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q+B+eo88T68j1b2gHDhw9kLo+d5FFUfGqbhSYj9sWKwyNxwAicu3DNTA4S0Q?=
 =?us-ascii?Q?6Ycvy0mq5oT728kpKVEZhpEp8NBbwTAht4HJGJk53EVt0bvNiyj7Ciyd9b9g?=
 =?us-ascii?Q?rSIk4690Cm++kKgwEf0xFWZCwdkD2ffz64uazUI/x8LJ+kBdJuo2wtEQVnnx?=
 =?us-ascii?Q?+j77Oq1DL0KVN2yIhUDi0R/b96ouf4I8Hz7gakh2HHwiaigHSjAKlP0AFS+b?=
 =?us-ascii?Q?LfKikOxirQo44AUqOYN1wSrOKNdBM9QbIzOVcTXlfhENCfXUkAyfPzn2Lko3?=
 =?us-ascii?Q?xFI1Z7GEp1r+0mDe/xCSduuGSMOgsC2iiW2OgWypTFjeLI93kz9XmB7SExok?=
 =?us-ascii?Q?AXm6sxxOhM0WoUV4oIKKLKjgywH0NYA+bBAlkD3MyQ1EOWjFl3pjFXX9Lc5t?=
 =?us-ascii?Q?U2J2WZJjVZbU12kiW5jhV7rF+NNpdIgPo1xsjWEzpew73TEQc2HBT+8o8e2i?=
 =?us-ascii?Q?EfC1rh8pjIiWeFWIsEgFx+TcRs54m5oJNsL7/IO+1qVeA3D34On+BlfXvZYY?=
 =?us-ascii?Q?PgI1l0KWxSmB3sgnqyX/6Ycxp3FxTnBSqmxF2chdd7Y1oA37J9eSZSZzI9pS?=
 =?us-ascii?Q?WIjwkxJ3obHoRQrF1vBSLAABC9eyUP1HBUKTW/KpJVFQ1SFKETrsGD32bSkC?=
 =?us-ascii?Q?zWODBO9qm5ietaIacyJAiVksLFeHPHET29Ay2t0rRS41+hY+CPnETsbhm0Ey?=
 =?us-ascii?Q?8gVCi8SM26NZmsgbx8JUppk9d/2Lxx9at6mw/Hcsjhutlzv0qhgsrKQRr1vw?=
 =?us-ascii?Q?jjaiwgnxl+MjTZxL7pZufrRQULujF+7PBMN4xmcP3PLgBPHveo/rXBLcH/cR?=
 =?us-ascii?Q?MMz41qy7GzKTZIGQX9g+7EkhiFY2qYi6cxAMf7TRbwaYrd0KA8UmOXg2uhEb?=
 =?us-ascii?Q?gaSJopIowIaroISqBvRlHAH29i/+v1x3wIT47woeuHwV2thbM/0pWMt6mHxi?=
 =?us-ascii?Q?3qnJ9bDBYnYfziv5T6klNCYAYwUdXxYGFus2GDCoXvUJxDGAelUb5TZTzahy?=
 =?us-ascii?Q?bsmsBJKGjMKh3s+CbI9Y6KeoOUkYtyAmoDL+nv4ouR8D4vXEps5t6Tx1Svay?=
 =?us-ascii?Q?Fr/DVudGzPwZLQThAAUbjH4fFNj2mCadbUkrsszSJubMdo7bYIyQ8c3Scz3u?=
 =?us-ascii?Q?9uVVFNlfmjZi5tg/fK4O4v9NBwnLosQshs2zACXDTYGqVJGVf/6jM5yPfkW6?=
 =?us-ascii?Q?bLv8Lyjkuj5GaNjS0oVXxuKObmVFRAhRCmFArBOz6HQtvYYAh/dNM0TqRAq1?=
 =?us-ascii?Q?+SZ3ujb7p72pTLAdzORXdq9DZ05ZDR71lA34aaTu6aKSTDqXe5kEYSsjgpqm?=
 =?us-ascii?Q?3tDhNrlUUi6AhdCFYQDvVO+Z2RBAhgmZztoc0hMzQbP3Gj+7o+AKrF4MzIXt?=
 =?us-ascii?Q?gOu5FPU5Ob7ZP0AISmqZtWXDMFGpHPIFMLCmZly7fM0LZ50MeH/uuWXXmvna?=
 =?us-ascii?Q?yJDn6RgNthzX+0xESk98JbUQClPEDtMKJLkxmnBHxib/ng+hDaMZdE3b5adk?=
 =?us-ascii?Q?2x/BJmPFJChnoEZH1TrtB3pHZBCp+rA76wDTa18abJQWd6r8nuuVz9V4jUzj?=
 =?us-ascii?Q?hmwn94KM+YPiFhlww3VXg/hjOPOTsQ7WiWhqTePWex6pSVYLciYWHZtYU15C?=
 =?us-ascii?Q?9KBsCSybdQCR03qzCKbPrMT1U8QEOIParlE2zta2KrF4DndJ0y+Nmdrzkzi5?=
 =?us-ascii?Q?nsFW29Vz6KFgeGedyCfEknni8cuHJJXwXGRVeD2Lur10u0Kz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc422ac-946f-4be3-9233-08dee1bdac6b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:36:29.2850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBz36P7TBuB/ViabjdC/hny9pu0I/NA76iJYXENKSe7C99/G7Mu5w2+vc3QGmGxD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635

On Mon, Jul 06, 2026 at 11:48:28AM -0700, Jacob Pan wrote:
> VFIO's unsafe_noiommu_mode has long provided a way for userspace drivers
> to operate on platforms lacking a hardware IOMMU. Today, IOMMUFD also
> supports No-IOMMU mode for group-based devices under vfio_compat mode.
> However, IOMMUFD's native character device (cdev) does not yet support
> No-IOMMU mode, which is the purpose of this patch.
> 
> In summary, we have:
> 
> |-------------------------+------+---------------|
> | Device access mode      | VFIO | IOMMUFD       |
> |-------------------------+------+---------------|
> | group /dev/vfio/$GROUP  | Yes  | Yes           |
> |-------------------------+------+---------------|
> | cdev /dev/vfio/devices/ | No   | This patch    |
> |-------------------------+------+---------------|
> 
> Beyond enabling cdev for IOMMUFD, this patch also addresses the following
> deficiencies in the current No-IOMMU mode suggested by Jason[1]:
> - Devices operating under No-IOMMU mode are limited to device-level UAPI
>   access, without container or IOAS-level capabilities. Consequently,
>   user-space drivers lack structured mechanisms for page pinning and often
>   resort to mlock(), which is less robust than pin_user_pages() used for
>   devices backed by a physical IOMMU. For example, mlock() does not prevent
>   page migration.
> - There is no architectural mechanism for obtaining physical addresses for
>   DMA. As a workaround, user-space drivers frequently rely on /proc/pagemap
>   tricks or hardcoded values.
> 
> By allowing noiommu device access to IOMMUFD IOAS and HWPT objects, this
> patch brings No-IOMMU mode closer to full citizenship within the IOMMU
> subsystem. In addition to addressing the two deficiencies mentioned above,
> the expectation is that it will also enable No-IOMMU devices to seamlessly
> participate in live update sessions via KHO [2].
> 
> Furthermore, these devices will use the IOMMUFD-based ownership checking model for
> VFIO_DEVICE_PCI_HOT_RESET, eliminating the need for an iommufd_access object
> as required in a previous attempt [3].
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> 
> Jacob Pan (3):
>   iommufd: Add an ioctl to query PA from IOVA for noiommu mode
>   vfio: Enable cdev noiommu mode under iommufd
>   Documentation: Update VFIO NOIOMMU mode
> 
> Jason Gunthorpe (3):
>   iommufd: Support a HWPT without an iommu driver for noiommu
>   iommufd: Move igroup allocation to a function
>   iommufd: Allow binding to a noiommu device

Applied to for-next

Thanks,
Jason

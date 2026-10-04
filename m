Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D117BCA
	for <iommu@lists.linux.dev>; Sun,  4 Oct 2026 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131023; cv=fail; b=Q19+9JxbIUN+4l82GkGi90lhgXk9bdQZT8/N3ZoJ2Yai8Ct/gkbT16BYd0YbSi1/PCSe6WMhSjd+qri+Bs+fG7V1G66zwjgXWxp7t4+rgkw+D2a/GD1g3Ta4AhIk1M7u0W0Lk8D6I/jgPY5CBUnitw0lPpPsrnUhAZUq+hGx2Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131023; c=relaxed/simple;
	bh=Jyi/wccc5Xpc+Bnv6YVwM0VSLXZWc+NuR/m/ifPZ6ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QPGmq3QZa8WbW8eY2EIyKVJZbwz95pBi2zig3ZzHn6F91ZUYuTQ+BPEQ57fDkfUhjXIogPPyEc5I/CQEDxB9iRIUqJCl29W4duWgryS09fUQHUqftXHUX7lK/V+ZXa9KkFeg2VdERkOV6kxYfY2lB9fzi1ckx3y/vCK3lWsrXNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OBsnhCH+; arc=fail smtp.client-ip=40.107.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OBsnhCH+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIKhHw1e/ol8Dnmhz8nXmuZ3tN3p0zhBLEVKxIcd99e1HXc105CCrS02SzwFNnTroyTU6WNs/KTmvzirxCuM7lYw29bUuPj/olcLEI9dHPjTnKx3f/9OtQ9YGnXl6g89chcMhn6ezFKK9HjMRAntH5yy+3uUlbADWSkFUsuORspXcu9on0F2Cu5/fsfItuS6r8oeTqb+mEYWf0jnEa3zkDLii7pcsQFWiXeUUGBSbbaYWQCdma7X7e6nBjphiw1yYbxibWhc6GgPCPzCJTPNab3daHnG1YL6LRmunZHzXOQR5hHWWshbaAxklWqYYYXhdNmhbzWBQ7KPg6ib5DUGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbxFwWy+eY4MuamDh0FY9xMP8T9Hc5wcKz+2yKU7rNA=;
 b=TVERCZPD7CRtDu3fssBN8trXY0mFRFQtKqtj3dX/IOoIRxb40i6+B4VLbvidwMjoHj/W7SsY1bQWAS7cNy0Wxz9SJlGGaG/OxW4nzuyYtDvRlFyM8mUlOMLVly82v7jZDKZ77a5v2vdgHQn91euxGye6t+kbz9niZKAQk+HJRuI319D2k5FvzL1n0e2hxivRxsmAC8TqY+xXh/rAUsMqBmysBdRxMqREwGgQqzXqa8Ib+QiDGWBh6IZY+flrqswbkrjHETAvvTAqTF8N+l9zUap0Cz3beq8IQKYoabcYvUSmQvK0HP7SmXvzDgUZsmP8IS7RAHvBnLA2KSFnpLDb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbxFwWy+eY4MuamDh0FY9xMP8T9Hc5wcKz+2yKU7rNA=;
 b=OBsnhCH+hFsAoyOkZtp1wDYlHocDNfNghcNNy0wigWZuJ8w7+n5sYBqU/wuesOamVApWaAatNFBfIk1Gi22sYq7luzATzQyoT0MnEy64PSnYEMJwUsrW9/zEmgzhbrehXPBIGvEiHSUkEc62upYEmX8gVHzrJrw3NKI1OHZ0P46esNa/kGNOon4I9Pw68pP3u1nO9lD0621qrBxnHvzS3h/t7Oz/9ReopSHEPwKlntUMl2Tf8VYTZiPj0xV1Rs9TrQqPB1343xKuGlKqETacLk2j8sbH5Q9XD6rYmZg27X3U7JdTOUnL4GX98/cEslcKieKJuAxwfiz2z60Sq2NMbA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS0PR12MB7971.namprd12.prod.outlook.com
 (2603:10b6:8:14e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Sun, 4 Oct
 2026 16:22:22 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 16:22:22 +0000
Date: Sun, 4 Oct 2026 13:22:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, praan@google.com, kevin.tian@intel.com,
	smostafa@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	jamien@nvidia.com, kas@kernel.org
Subject: Re: [PATCH v10 02/13] iommu/arm-smmu-v3: Make the ASID space per
 SMMU instance
Message-ID: <20261004162219.GA4064@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <782e24224c916ad0f48de1a49c139e71c8db0ef2.1788130528.git.nicolinc@nvidia.com>
 <asJTaw0lU9cRN4Gk@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asJTaw0lU9cRN4Gk@willie-the-truck>
X-ClientProxiedBy: VI6PEPF00000229.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f3) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS0PR12MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: 88952b91-24cd-4753-f23e-08df2233ab69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|10067099003|11063799006|5023799004|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	waEXAtrdtih1HopeUHXngpA+UiKx8/OUR/9IxhGzz9bup9Rufy0Hg8o1Hgi6G8TvggzNB+Mi/UtKDp1egHYXEhBN64D94Ipew6aLm3HvTMq53mac9IMEzY869iaOOzpXg0fogOLqh6g6pqcjTkyHnYsmXAiNm8SF54z5HtsthemLZRar2m6V5OO1tV/hB8Z0yAoYYPdbhWAJwBNfs5CxUqgyKObjX+6GWPEdpxp9rXXeuk2nqiy33UFsDBP3D0fbRrpAci2sauPQb/kif0tb/ErJCB466Li/2zWlmK710ruSC9iicCCQKVOy96Br9R+kMePIuE777kjkejxQxsPtU0VZXJCP/4nnpVF3n8uVb86wW6qa9wkDWp6rJM/Q42rOAKQIQJY7vk2IZDyG6g/A6N+ykHzdfmhyn/RfhROfxZt8HQwYLwIkTxITI0fj0GqUT83RsMYqPo7+6AoFK+KcP4UQB0YFMmm/DFJ+yyCXYbLF+BXB92Vv8yCDC1v2O7mLZxeHWiGHH0URKxtftxTB/Yxg+X4YlhhSMXVx88TX4vVHoH1Cxbyp+kUF3KVjKTXulwwokPUXTiByjvv6wm/RderS4+PEafsqJLjZTcUrQqYQnvsxawA6VVZPSOeS5LvgyceRkh4PV/SmU8DSJ7vXM28U2WxU21Lo0WFu8EArEOU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?clbZIuHTTcyaCHyxPMeTRa6qXeaQBVR79KdJmY5yFeJS3MkB/lTsTEZr7pLT?=
 =?us-ascii?Q?IecJCDdMO6X0nCrEUH+AInbxoYkuA+YqbEiEd/2J7wVjpj3Yt+A8g1eDtNEx?=
 =?us-ascii?Q?KijSLGRrmC55RknO5i9HfEfl9vMvVdgfuAmcqlSMUyZL+rNOMHZw53oOCX5m?=
 =?us-ascii?Q?AtL4kZBlrY7KfLUhKgI5XQZQN+T5xdgMHIkliXK6Ey7BViCfXDxBn9PeyigU?=
 =?us-ascii?Q?UiBsKD4c9jUomNYY1ZKbegdm6zNiv0dsLh6Ny5FQp+QlB4D0ixaetJ4hXHdj?=
 =?us-ascii?Q?uYrPHjK5eO6B9dtTB5t5jn+z+IlU4DPiTNpmIF8Xb6plS04o97qEYWPIY+SM?=
 =?us-ascii?Q?EHLUYVI1GgbIyWxHk8Hd8MJXLH2O+1VMMEqcW1f2sP5/4vpZI4qwbXe/QqD+?=
 =?us-ascii?Q?lQ6CaeiP/x+dpY5C09E2N+2RnRVY6W42s7ymanDtoGe6FjYtHreb1bHL+DSg?=
 =?us-ascii?Q?+fnN2gyvFDHMsBGVmC9AjdsUZpibeBzmj4+bI1mqDCpkYFhX0XrRRBjPmDay?=
 =?us-ascii?Q?iapmMKbHEmtvJdyQqbUllixnKdpCjmKpY77bi+jjGzb/k29++qbN432Tdmdp?=
 =?us-ascii?Q?Owa/VkUzKO5lZFYWvzxZzAD7Rb9vjGedTU4ACWZwIPg6xMSPok3ch0QEtY6b?=
 =?us-ascii?Q?3n73IrUSCaKCHJs+6d0KJLU/Cc7ZUj6/d4JHu5bIRAd6RYcXzUFDtOhXj3Kf?=
 =?us-ascii?Q?pVHKAu2I2ioOulLtG0cA9SBQ3TUmtjuVlhPN0Fx3pXUKx9rqaLRIP5NPt2r5?=
 =?us-ascii?Q?iWAdG4UGbkBFXtwiqu42FlUjCTRERik2EHziRuQVJjYVqVGZ4We3+IFL3SEj?=
 =?us-ascii?Q?EuURRelZNnOiLBPsKzf098kF6iQ0tiqCMXt7+q4U9C71AeRm0KRHvXRbtKtK?=
 =?us-ascii?Q?TU9fj/MfmnHlj8IOguTe79ZdpU4X6diHUI+heH/s0deZonpMomd2h1iJwTeE?=
 =?us-ascii?Q?hDHPTU1bzALNalj807QNmCZ6+UzoJI10KmPbOekP0Evut9S8LYaHaoHyA6xd?=
 =?us-ascii?Q?sLjVd3/u3+07X1LAMrA9rvZKVQlyHmAj37/OXdmjW9ciT3bK9/ixAI47cz30?=
 =?us-ascii?Q?q+MoKDhyQCLx9PfS4/lIap6hlM0UwQqfUE34hZCgWMsmSoE14AMH5yl8tTF2?=
 =?us-ascii?Q?0pdIvVUyWW4r+KqOV2gae4oWt0msZ0D4gthkRyURigIB6QHAMQim9sNNDLTz?=
 =?us-ascii?Q?2QHl41AhCkzrsulz3l3w1zc8zC0S+vyGmYwuWg+oJEnePuECtIuTpBt3wvVW?=
 =?us-ascii?Q?h2G3M+V+nLRk66s0u1DLtu67QUBfE+6YpiO5VObWVsjWV7D7M+1iK9PF3a35?=
 =?us-ascii?Q?XG8t9rpZW0jPWET65vIiGZIuIUO5Z4GrU0G7gDFTnA7w41nEfGtN7vy+lU9T?=
 =?us-ascii?Q?h9zgPegkEvtbxvEuh4cmgNS+lb1k+ht00/zYDqdP27m5Hx6+EMpDdIIalZ4p?=
 =?us-ascii?Q?cdkx9AJ5a9ywh5xiFPbrtAxo0PFcq6IJEuNfg8TAn/zgcMBBwDv16bU8JkhG?=
 =?us-ascii?Q?DXsXGC4teumkwTbHQAo4/jNPKAbcZfpoeELFwlDDKMNegF5iKWupMEMFJy3y?=
 =?us-ascii?Q?z68kowrlKXjmDDUmHqGma7sfdrWTo161ThD+pNdZSSP/iYb1/myqatX+uMuP?=
 =?us-ascii?Q?++8EaJy9KG6WVUmeIdIny2Ja9XTapNLRkmEgrBUAgtPgE3HhnnM9lNxTmUA2?=
 =?us-ascii?Q?PYYGksGZnIh+nEC+GHCOL6XyMUeWQDwB+aTBEZOLBEwJK5vw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88952b91-24cd-4753-f23e-08df2233ab69
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 16:22:22.5601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4Zi40NQAKxQViOuqgWUhsDP4ebjvi/hssCrUkEv1j7fpwNl+WpFye0dR3hbSHs6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7971

On Sun, Oct 04, 2026 at 02:23:55PM +0100, Will Deacon wrote:
> On Sun, Aug 30, 2026 at 04:18:03PM -0700, Nicolin Chen wrote:
> > An ASID tags the TLB entries within one SMMU, so two instances can use the
> > same ASID without ever aliasing each other. Yet the driver allocates them
> > out of a single global xarray, which makes the instances share a space that
> > the hardware keeps apart, and lets one instance exhaust the IDs of another.
> > 
> > That global space is a leftover from the BTM support that shared ASIDs with
> > the CPU. Now ARM_SMMU_FEAT_BTM is never set, nothing looks a domain up by
> > its ASID, and a domain is pinned to one SMMU at the attach.
> 
> We probably need to figure out what we're doing with BTM. Over at:
> 
> https://lore.kernel.org/r/20260907184513.GA2543240@ziepe.ca
> 
> Jason was talking about bringing it back once the remaining invs stuff
> has landed. If that happens, what is the correct sequence to allocate
> the same ASID on every SMMU instance after these patches?

The last attempt I had at this already relied on the per-instance
ASID, it made it simpler.

The flow upon SVA domain attach to a device is broadly
 - Check if the asid is free in the per instance asid xarray
 - If there is a conflict
   * Reserve a new empty asid
   * Allocate two invs list, first with both ASIDs, second with only
     new
   * Set the first invs list. Barrier
   * Update the CD entries for the conflicted domain to the new ASID
   * Flush CDs and IOTLB
   * Set the second invs list. Barrier
   * Set the SVA as the owner of the replaced asid

This cycle repeats every time the SVA is connected to a domain, we
don't need to do a 'global' operation. That is why the per-instance
approach was simpler

BTM has a per-CD flag to indicate if the CD uses a 'BTM' ASID or a
normal ASID. It is fine for normal ASID's to alias the MM as they
won't participate in DVM, so only SVA needs to do this.

It was the STE that was broken and lacked that bit so you always had
to be careful with the vmid.

So the simplificaiton to do BTM is to only support guest BTM, where
the instance has no S2 support in the IDR. Leave figuring out the vmid
with kvm to another project.

IIRC..

Jason

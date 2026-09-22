Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C5F54DAE6
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085629; cv=fail; b=gIM/aaO03dpUUCgEpNloEAJUCX583V2m18oj9sZRXIGef0M2IifiMps4ZO5JxV/AF044Co1q2j5GnfJvcrMl7QuhVy6MKok3cb7z1OAvr7ix5BtP1vrWacqTwlrayUzNp102InXz3XcZ0P4IAKqnnYyCvfEwC2pKvJn76Ls93I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085629; c=relaxed/simple;
	bh=n/fPk4LaGCL1wd1xUnI6WVrx0t3G5dwayjMzwylGysw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TiKiCAdiQvPvPL0ju6sL+kCPNPdv+hqY8lzLS+L3i22f5nI/Nt2Ytg5YWxdBFFDGhgI2zUf1WZXJLN5/C8qCMZx8p9wUYQGj4jT1tzO552lmVPvNhl8/B1klVtxsbNqOa2zXjhM/TZ3JH+1/JWVNtNB4VJs2xm5LLeO0J/1KURs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=On9jUdmZ; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="On9jUdmZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oy1upvUNouFx/CICNWQ4GAgYO2FDtiDXVHBv8tpIDxcm9bC7BoXA1+50C9bA94FCb9DHAbL5+YHdyBrtBa7cOGSHusZOhfBVWqD3dMTzqYYtugLBEH1GnD4dgWDL5ezNyX5nclErALv92AmpdYhnH0tGD/34HgbRbhgQYye3GpPOSIWaLgAxe3O75bpjcBY/wHcM53Zzo5EAxyW08IU/+bZmCUWrSC4n7mSi3e04w5C3uOWTPNefQsrdx6AN/xSXRQs6o+nUsLavsSobhUbX9X0ECbXrxH2d2aACTraI57+xH0OUFWcRWfs368iLOVhAuxFUdxzsjSeJYolfJMzCHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwNAof3a5RtKqZApzhvqoO+or4coDp6jtiej3iFk3iQ=;
 b=CiDVBIuIzaUm3Uv1HlMZNbSRK7RNGs/tp/t3Gc2b52W9ui1iW4ve2mcWVtMhkLyaajxhLEgPs9UfNgmtYPUEOx4kZMKOaw95xrtZHA3/0KkCyaTbLajwlaxq05rX7WQhriXJgluYezpDgN79a3vIKvXXWSL3A2Ti8F9bXK2c3CguC9Gm0doLIw3OEEjNtI4CMUygWoxCxyEMs1PhmExHvMgcCfcEr2z9r6bHCL82o4hwqmqDFOnQrGz3ae+++VRNtiaanulZd4qxE1/ACYSVkB+F8BbBum4CKR7gn5TQnGVI5yK3RqltZNFHYZ+0LddunSepqzMQ420lBteQKiAE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwNAof3a5RtKqZApzhvqoO+or4coDp6jtiej3iFk3iQ=;
 b=On9jUdmZiX7FdY8+yF3LJ/vAnDcVNcxUf2KY9hPYSfiJkluCeLasxv4GybXOiGsUb+tkFa567jqo8gi9K8TH+A8Gpe5gzRAPAgoGDyK3HEAVEvxuwQoTKfhZfmxYq40yuZsMUt76Rt4zPq8pEcMFZPZhnAX54xRDTgvy/Qly9egr/9JNgfBeykxNELRZ364I7ADKY4SCesOIIVJ9wbjwLGZnkfRQHKLDr3NGiDAFyUAUjjG71JGHbHy2oYnXH/ppSZPmeg8To1YPIKDZmMxJugHCVNetiQsGZtHINVmO3aBorn/j7PGvSKu3lQHlKkLscEqql+HB7ONOSOWRZxgUDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 14:00:18 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 14:00:18 +0000
Date: Tue, 22 Sep 2026 22:04:39 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v2 1/4] iommu/arm-smmu-v3: Convert streams from RB
 tree to XArray
Message-ID: <arKK9+M85xeknRa9@shlinux89>
References: <20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com>
 <20260921-smmu-shared-sid-v2-1-4b656ce68178@nxp.com>
 <arGEXU2GqmYYBBjb@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arGEXU2GqmYYBBjb@nvidia.com>
X-ClientProxiedBy: SI3PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:295::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI1PR04MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: dadc246e-e27a-4f9d-15ae-08df18b1d558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|23010399003|6133799003|18002099003|22082099003|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	nrG3hoG+avmxud02RZAhK1CQ0WjziXD83jBbYZ6RXdOCtRZ/LB31ox3s6idcaN8ao34iffqLIT58KLN00ooz3fd0RgspWucGE+QSML/TVTQEJBdFCzNqvpKOCdCybJ6Vp/n+fP143FdiEpYxleTcvIYHcDgMOr7PChGi2eEtRp27v46rQt+lJRIQmpKmVRC5MWNGGSQj8UjkIeVgk0TlhMLWtDOndRd/C+XSQEgK3Fa247wKKIqYMeQY9bPUMMgMJcZKOMplO0PT/UOFgJyJ4qzMx8DvLOvL1bNMWboZWo/wcsz3yY5V3Hj05mhSeNoEh7uZqen1T8Gl24zzZb4ZUgWtypPEcUiLUXzjWYij5tnCMryWSSLDi9pb8crQrkJ+hZ/+bToT49Qc6LhTDUeC1cMeb9rjU1gncwcFa7/y4AAWSCFz1SceT9DlJYwP2mOTePcs2eywqBCTGZerMrgdpF7fKF3IdCb/JT6hCkOyGm6VwlY4l7k6LOWQ+6Qlm4TijOOG6FhW8Kin0FTM+ZWI1DrXYC5iJZvo1s0FMPvWP1J1th/Pdj7WL27q3sBstJk54a3QtBMjzgoR5jNLRY0SaU6Jdl8xh/qc4Z1RhDzRZ5CvQXtlg14zqhWZpMNN1raS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zA84f1UmI+sH16jOKAxILpDkeM+dfPnrnzt4iF8ZyaOR1hvkxC9zyOim6wlG?=
 =?us-ascii?Q?qxLjPzrBj6fdY6Xw3L78skkk5RNuMbIQ2VcPauClBSNn6Xz5frCyQqM3nAWG?=
 =?us-ascii?Q?Zef4pSXAdMHBgPQ/xTbsEpXC0HiTh2gftsVExfwQHn2cgdJvjtc1fSBHl25u?=
 =?us-ascii?Q?cfagAotmv2XVVcssxmXbWFggQbYgMI6/dTqPlGUIPdUXwFauprnZUC3L7e+w?=
 =?us-ascii?Q?jcQk/+NS7Xd0mcc8eaOqv07q0AvJk+m86vXXMsgLOX0Ll8eZq2F1Zs4dDSuu?=
 =?us-ascii?Q?972648NduDdpGpU7jtKBCLhHWJR1+NzKbMw3DuVGmuTnp730QfW6iXdk6fPR?=
 =?us-ascii?Q?qB/pBQs+gsT4Z+aou1642sHVVdZOu4gWTktstybYEM83tCEj+iEpCcmODPBo?=
 =?us-ascii?Q?SCH0lMxDVWyC4OWAQv/eWbphnEuilM58XG1WECwhY4wc6Jv3T7FmtyfqwnAB?=
 =?us-ascii?Q?LCEFnFRPUrBbb+981bkkVThuy3DFjHYBOsGWQwG/5XzV/flGQCe/sXEITxYJ?=
 =?us-ascii?Q?8Gp0kZCeuCx7PaEliW3evRKv9qdH6Ui83j5e8LQtjHeSl86HX3MRSDCmjQSI?=
 =?us-ascii?Q?OrHziTx/uJvSNwicq2xkmtPcBYFsnk1e3F0/g+e+1YKFAkepQau6kwv35p2G?=
 =?us-ascii?Q?Bh1dmtJyhZaxP36cbyHJQE8HI/9/kgWwgoEKRQstoQdt2ApAOXVMF2VO99Mx?=
 =?us-ascii?Q?qKn0MLwl2RJ44H63FoWrQHNbHXkN1pGpyJ/Nvb27XcDsr9A7iIL4Eio0sQl0?=
 =?us-ascii?Q?JuRpBini+yK6LBm9cW0x9TX2z2LxaA0P/Ml5meG5ad8lBIGmgW7Io8V2IF0V?=
 =?us-ascii?Q?h56oLWLJA7/ymVjtHRBM/A071kmoEdwCflz9xJgqzax6pzkX8XXL7g6bVX5e?=
 =?us-ascii?Q?O6oMbhr0xV8m7rp5WGDL4qP48/AsynSSTcy5txoBu8WiHcH5K6jKasXSveKt?=
 =?us-ascii?Q?Un/Lm8w7osXuMrUvHT4WtW++z4prBuY5lxB/GUKZJDf2xb2F4+E8vfV8d0OJ?=
 =?us-ascii?Q?FGwUxI1M41zOL7j8frtYU8uqIX2vYsrYNcWRXMO/4+Oi/UblzWrmt77r6cDp?=
 =?us-ascii?Q?qEuKrThske21RhbSagsO35yi5PNzgtmYsjBLCqH+qn20liOxbc6ICWEoUj5v?=
 =?us-ascii?Q?Z13/j9qWgdUtyZC+u00qFWMB7TqYhgfDk5OABAOy/vLnb7pg3uFGi5e9Vumu?=
 =?us-ascii?Q?Oc4zEMFKacYU7qpWfDD+9orfH85F+c8FKC4fLy/j28nH/2meEAxTBwCtCxxT?=
 =?us-ascii?Q?f5P9fmG4iAJ+/IH2w3ElQRYRhTBOlh7vIacNXAWAb04JzmUW/T9vBtLVr+Aw?=
 =?us-ascii?Q?aKFJi8IKwfjj0TCA1KfvO34KgtfpydVJn8s781i6iJ80+aytBfanCKLHqYUu?=
 =?us-ascii?Q?k69CGWhjql9k4vysXRMMHoWN10LUz71ZSdr8rhTINn3DMMr7/dRRwV7u0oGP?=
 =?us-ascii?Q?FdCd8NVetU/urYJxkzytLlHWGXf6BqbzH8YE5+/Ch4X1pIE76z4VktplUGRB?=
 =?us-ascii?Q?tDM4qpK7w4UH+i8iXwb7o196bqguNTU9klgynaNHOaywoI8a6Ty2MM+GPdwX?=
 =?us-ascii?Q?IveilYEHEtODgLGX+K/0ndPwAnjBoJ1hOzp7wc8P94gUtKGz+FyjXg4uOSJq?=
 =?us-ascii?Q?ljlxI4pJPpei/C0GEv203hjDQaPE32/oHdh3yEBsWrhFqjD+oDhtUHYx7w9z?=
 =?us-ascii?Q?spoKkqLwp/J0ejeNRFeBd85N4kMMVrvvZaCuh9+6OPOy5j9YxYqOp4LqWC9I?=
 =?us-ascii?Q?69EixSNc+lvTfku/tA5ygC/25UUbFJmWaF6gm/7arc6iRhHlS2x3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dadc246e-e27a-4f9d-15ae-08df18b1d558
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:00:17.8991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NNVHs/sQBOdVDsHB0qK46HRXoPLOSczkoefUznyPNlTQG3oGy9HgMOHWN5OihnOQpcf8vLPzisk9/e/NXjJ2EEP+WT/N/IJy+ykLEFs+5HzhJ4ofV1rJbBystwgHCww
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7104

Hi Nicolin,

Thanks for reviewing.

On Mon, Sep 21, 2026 at 12:24:13PM -0700, Nicolin Chen wrote:
>On Mon, Sep 21, 2026 at 07:35:00PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> Replace the smmu->streams RB tree with an XArray for SID ->
>> arm_smmu_stream lookups. The existing streams_mutex serialises all
>> accesses (both xa_store/xa_erase and xa_load), protecting the lifetime
>> of returned pointers against concurrent arm_smmu_remove_master()
>> without requiring RCU grace periods. A mutex (rather than xa_lock) is
>> needed because several paths sleep while the lock is held:
>> dmam_alloc_coherent(GFP_KERNEL) in arm_smmu_init_sid_strtab(), and
>> down_read() inside iommu_report_device_fault().
>
>The commit message reads very unconvincing.
>
>The first paragraph starts with an action "replace" without giving
>a clear reason for the action.
>
>> This removes the RB tree comparators, the rb_node from
>
>Then the second paragraph repeats the action...
>
>> arm_smmu_stream, and simplifies duplicate-SID handling for bridged PCI
>> devices.
>
>... and slightly mentions "simplifies". Maybe it should write about
>why this is necessary and how xarray would simplify vs RB tree?

Jean had a comment that "maybe simplify the driver first by moving to a xarray",
see [1] [2].

[1] https://lore.kernel.org/linux-iommu/20230518130459.GA2587493@myrica/
[2] https://lore.kernel.org/linux-iommu/ecb3725c-27c4-944b-b42c-f4e293521f94@arm.com/#t


Does below commit message looks good to you?

iommu/arm-smmu-v3: Convert streams from RB tree to XArray

As suggested by Jean-Philippe Brucker [1], convert the smmu->streams
RB tree to an XArray as a preparatory simplification for shared-SID
support.

A subsequent patch needs to look up an existing stream by SID and
then decide to share it rather than reject it - two separate
operations. The RB tree's rb_find_add() fuses lookup and insertion
atomically: it either inserts or returns the collision, making
"find, then conditionally share" impossible without restructuring.
XArray's xa_load() and xa_store() are independent operations that
naturally support this pattern.

Eliminates the two comparator functions (arm_smmu_streams_cmp_key/node),
the per-stream rb_node field.

The existing streams_mutex continues to serialise all accesses.  A
mutex (rather than xa_lock) is needed because several paths sleep
while the lock is held: dmam_alloc_coherent(GFP_KERNEL) in
arm_smmu_init_sid_strtab(), and down_read() inside
iommu_report_device_fault().

No behavioural change.

[1] https://lore.kernel.org/linux-iommu/20230518130459.GA2587493@myrica/#t


Thanks,
Peng

>
>Nicolin
>

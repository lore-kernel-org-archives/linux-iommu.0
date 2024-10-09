Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10B31E2842;
	Wed,  9 Oct 2024 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491023; cv=fail; b=OUEv2yqLMQ2TuJLIS7zrsnW85efYtCZbcvHgn28uTf7o/zX7sK/u4pyzbeXHbtMtwvecPLtJCCVYYRC3kItwK0VlSVP/3a2RGdfleH5y7eSv9r9Ze5dKgozUoPNfhkhj5rgodgXT3ME+dUqSrtgdYZtXsgfSIaYEPz/FAJdSoYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491023; c=relaxed/simple;
	bh=pdzsj8eeFQ7CCxjSAY5f8fb4UEa+pYHl7dLdVqsi2is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EGExiRaRgpbLATc6CMRowVH/91mVN+kvxYcSX//1J9fkak/HwrO0Agk2gf+TzzrcW8BaXpy51uV2NY1q1BZR7GD0UX/DT5sb5BBzgMpaUL09wwpUrGsnASm1PByfiAuBTyaJGuzQck8/AE1X8tS5Q/xi6x2wrffNYZtCPS33KUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h5ht0td6; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h5ht0td6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHBa4XqNARGQPwIQNy7n3vM1yamQohnFUL9e9n1tzzspm9CBKOtn5d6IBvo1IUeUNCAU2lGalSVGtyaxkxTJyBwuSFlz9KyvU+45ve/WUe95eBYryDfnFCJruFvZlSHrjyC/fgtKq2+HZcoYSDszwXVOlBMzPk8HzuPkGRdh/LPsPk/5d6v+se1a8fhiS5NKGlwXHXGcdFdOlEXjBbc1MYjkmeC729Wv4zbyjjBBAzi2Qqr3f6bbDmBZSoxQnWp0cqfbYQqNgQpb2tKp+ntmCH7DG821WMPIQvGpOFIf+tu1NtpUBFlTTchquLNgtn0DE+sOisYT4M5sJ4rYO1kZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PkoTZUjhuR/nKmtRTOKzRg40EpQKs10xY4n4MrkeFM=;
 b=Dcu+7QsIFuoIWrjPFjBWUvxebk+4KfVuK9d9NkYeT9gjIVNnHZAkqi1GoLNthrcegtLA3AQXWbZwuXaWWbUMnJLv7nsONJ5HQzKGmSVnMQ/uG1mgv9PwgRT0LKOEpxiPpxkO1G1+9HNWChqbtw8eCKlz7w82DNIiiYHtxz7jWxTiryMykmGK2Xcertl+K2JKoCokf9i849JhC4kNN3bZNbhlpPvwHNjg3FIAhB4UfiV87x/Q/WoogshLgZ0PH5pk1JdirbEWm41odmpYlzZmpxdggrpwPp7SXI9MEbtvZ87aSfV7Pz8V6SPkwDq0XboSL2oUvx7+0Ckwv+P4L2fhrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PkoTZUjhuR/nKmtRTOKzRg40EpQKs10xY4n4MrkeFM=;
 b=h5ht0td6G/QaJzn6gidg/C5OKT0qB/6qb6SbyoM12mLjCsuYD2r0ow/obZ0Pd4XzQdF/Ta6XSZ20HHU6TZ5B2umpXWWSC/36MGZvh/1cxX9nmZXrqZEFgvBXTo7fq+VmakWLUU4ko33lQQmhxXnwFVyoc1vZoqUtesbVY1RaGZIYW/tQlFKrIUlGrdQLz6KLxIgeeoddmGiAn3NdaPt+C76deR05A16MQVjDB+YklD11eT216Q5p6QW6SFEFMsEY96+QN06Jd8LYH/e1dJxt7ThQFYRiUmP5L41GHS6f0fX0sej2DW1xlegGheQ2+b8Sg7mA7OFwUUg/iGp9/z4l4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 16:23:30 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 16:23:30 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: acpica-devel@lists.linux.dev,
	Hanjun Guo <guohanjun@huawei.com>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: [PATCH v3 2/9] ACPICA: IORT: Update for revision E.f
Date: Wed,  9 Oct 2024 13:23:08 -0300
Message-ID: <2-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
In-Reply-To: <0-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:36e::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: faa7778b-7f1c-4989-2ae7-08dce87eafb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1j6DkjtN/eEXnT1SSOT7wF052uTJpKqrPmccvR6xcdaWnBMT8p8gZXtj+eot?=
 =?us-ascii?Q?yERcTcNGn04LLE8fG4+yWW6wBnN/1wdN1s9pVOca5aqYPtw4BZXlBUcSc79L?=
 =?us-ascii?Q?/xOUr68cByfAF6eDAYRqGQQyAgdUWLy9P3HLguf4RgWECP7LpC4jurYF7MnE?=
 =?us-ascii?Q?5sQkCs59Gx5mCRwPWf9Q2bFS1ZprlvVRf7eZW3kCZbiMmTRVX24epucOr0C1?=
 =?us-ascii?Q?KSFmcHWINiQXkPl34OCGynggUcZudCcRfeMRoe03VlQ/5qL7S911Y8nshD0B?=
 =?us-ascii?Q?Ay0nh325Jx7noOp5dkokmDI5pfoEPm0NbrgwJCq5VlWR4xd9nHaYIW/Qvtic?=
 =?us-ascii?Q?MyBU22G0ggO5Mye23kCUjUoeW3+hWh6NWH4oIFmdJVF1XfSYORwh6vhfaP7j?=
 =?us-ascii?Q?4pErsSSOPM5js3pyDeBeNN5G2U34jZriTSbKixX9ksdeVdgrRLebIuKmzGS6?=
 =?us-ascii?Q?sjo+O1i+KVVIObwZf/sQyKiBX/krhJkboWqvOJF2uwlLqy0EhZafDv5MM1I4?=
 =?us-ascii?Q?L1w8NgfiIkhUo6qTYMbWfUl1voi7rJQv77RvzB8Efc8pBjRQlGjeKwJ5mouw?=
 =?us-ascii?Q?iMaQn2SvhHJ4Bb5+oGux5bUmZrmr0x0DCTw5fXg3NNZd9kx8V1p+jLEVRJxq?=
 =?us-ascii?Q?MqD6ontPD96V6iXK6MJSrTEJd0/++pNGYosvI/AVQ0ale+ByTkxQkScy0Qzs?=
 =?us-ascii?Q?lSdRCFq0tFIarYRusvrF3MoaRVlCV5jVsrM4Z42AO9TNVtIEGauq/K7ae/4l?=
 =?us-ascii?Q?bG1JOM/Sz1Kvv5y/a9DioBPkxpC76I2oNiRUFinlC/xWPgPxfm8Ii2ks7q49?=
 =?us-ascii?Q?wbmzpYM3lOYImODWbf7/YwDy201K04BFQMhLDsUrtTkmpCDKctJS1CCnteTm?=
 =?us-ascii?Q?5fNaqd9TqzzqARe+8DhmmQtXusOx6XrUSluw7Pep47XeghMs/bYeLJ7hko0f?=
 =?us-ascii?Q?4ROfCMNZsCTs5ypwugzCFcoVRuKnb+PlgahscCus5nVc26ilQ5NUF8pvs/W7?=
 =?us-ascii?Q?SjRUTYAk3O7EMqpQQVDEdJi+M62aLdPg/JZu3dTbU+A2NbFtOOdn8Piy6Smo?=
 =?us-ascii?Q?jumLt7koU5J9KO3YD6foSdqjDXNAcbg9zK0hUUTRUKkHtdCCaHMr5wraM0TS?=
 =?us-ascii?Q?3Y3zfDmw4AEKa4d2q1opCEgVR1ZPceTujz81WdVDsDkx2Pzk4D1UyI4h20dO?=
 =?us-ascii?Q?iHKqUUptG1qVX6wtcxTyxDf+GbujRmHLxnn/oI/tQXSaNMEFwivDiREXYQWl?=
 =?us-ascii?Q?G5570cKSWIL83eyg8q2vt67pF+27ONXvKsnMCnfLiJ6OWCReSgAXsuKZ7EIb?=
 =?us-ascii?Q?TKS8LE2rpDpCljTFbg/k8SUF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i33xyxz4oD0Gd991rnuY/VPUWYPYKrOhHeYJDbEAPtNBLMlYoQanxuSJ6e86?=
 =?us-ascii?Q?YimtTIfbD4zYnSxiLfJfMt19MnzcSqtBQyM2brE3vOtleFGg+f2+wMzqZWx/?=
 =?us-ascii?Q?psU3rm4PE7jP61aQPgLGRvbX1stJkoLKOCcqa5gjuQcF8nPR/XYtFBWjLxuN?=
 =?us-ascii?Q?c/IUoWNWBD2ZS7DNqcXUX1p4BKi2JByWYvNhfja71gu252hwQ6tWM5bjBnfe?=
 =?us-ascii?Q?gGGzL48/GUZ6BCMiZdi25FjJoca4VZnamBV6mgOM75orQ6y6QkEM19jPK6X0?=
 =?us-ascii?Q?DL/okvHqS8thfTrTmPaXGjJR74oLzYo8wUN8RpNugkiMuyMKTww7LQ0E7A85?=
 =?us-ascii?Q?wqyTTRKFKDjOTTl+f1Ex+0I8MheGOSYkyuW1oAu1Io8Xx8qAPCEwMMiQEEHM?=
 =?us-ascii?Q?R8liiM8i57Vf+jSc5h4OZdkL77lMFdQFkC8kF54Yn7AZa3/2cHzq+S7BvNxP?=
 =?us-ascii?Q?fcFKbcyeXP0Y0ZfNN8UZdhx8+cZuTVubmhXzGM3WSUq4k5tVb3812ZtYXz44?=
 =?us-ascii?Q?kKQyvNY7gyXx6gSM1VZa4fXFI1sqzT+fpvl+7rzzq9uxKlBnNI4rzVSvX83o?=
 =?us-ascii?Q?lqUhiTKutzxbbRYSFbbJbgRivSqsPmFT3CzshKM6PW4K697Z6xug3QFvEU/R?=
 =?us-ascii?Q?s2ChCaDvQb8Qx4LB0WyQQT0QOhvqqy0n6r/3iCPs1z7lxvHneKArblifWvfV?=
 =?us-ascii?Q?ROeMaFuex87eTYegYTyGGyhc27G2+FelATMJbHRCOEnprMk008G+TGB51pvz?=
 =?us-ascii?Q?LumZtDrN4h0UHmQc+usVUxHvwFbF2FMwcZO0DT7BY+j+/PK818JyKCg5LdgB?=
 =?us-ascii?Q?yeYfI+n0Gzi1ZU/9yPY8eAPZ4FiKfxZjVFpb/jxmcOw74b2JjA26XKj4ckzA?=
 =?us-ascii?Q?FJUVoUZouCF+FoVnojmPZGscT3gH0q4JI7VfEg7lIY8OKcCG+bsjmBeqebfI?=
 =?us-ascii?Q?wNULq1L7LkdzEkMFK2bE2G4o0Wy+yBCXOflwk1+03cjH1hZZ8dH9xj5ezMtL?=
 =?us-ascii?Q?CzOBypLAigx0Pmdb44bEGC6qU4XVB4T/xuTRiMpkVdCOuPmhoG/xfyK9ZCly?=
 =?us-ascii?Q?pK3YJembFGUwUZ0tw5TdtYALBrr2efwMdVFeunQn02gZ0p2wxYLI3kjgnYT3?=
 =?us-ascii?Q?NeAPYPJ0GIopD6sPGBMkRWrNutPA6iww9dEOnfg7OCEpiSC4vS/mFRuZr3Mm?=
 =?us-ascii?Q?j94xehK6KbyrXN8eE+Uj7S80b1b+xIKggWd22oSW3a+tcaUxnT4U/lNTZkfS?=
 =?us-ascii?Q?NWtvU951AQb/MUx0UlyA5ZYBo5r5S1c4KoF4hLsD6cEQ2iq7W+RfTyUjF6WI?=
 =?us-ascii?Q?q8B6NlnHZXJ1kGg2AN9NIgrMOU3LGf522UllllKSoxPjnItC7Oc0hxFyvGyY?=
 =?us-ascii?Q?XS6SBFmpC5GesF+yDp82P1DXzdXZVc33pUYE8C+JKrygWaWzDMD1J49M91Nl?=
 =?us-ascii?Q?G3Y8+eGmtm6HleK3sS1A+5XW/thhIy+oKRgZjljo1wyForQLsr3zuyRQSiUN?=
 =?us-ascii?Q?D36bPCSkMhR8WgB5a5O78VtAyCoqQ5l77ykDVR2sGeOWkbv3ne0ZPHBgaHvA?=
 =?us-ascii?Q?3f2Zomolhdbx3Ps4W68=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa7778b-7f1c-4989-2ae7-08dce87eafb4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:23:19.2402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRvUPVcdCVKtF0yGTznb4GrUn9PnlNZxJdh6IivDQsuWJy3FLS4gJcCeQTpf/IXo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768

From: Nicolin Chen <nicolinc@nvidia.com>

ACPICA commit c4f5c083d24df9ddd71d5782c0988408cf0fc1ab

The IORT spec, Issue E.f (April 2024), adds a new CANWBS bit to the Memory
Access Flag field in the Memory Access Properties table, mainly for a PCI
Root Complex.

This CANWBS defines the coherency of memory accesses to be not marked IOWB
cacheable/shareable. Its value further implies the coherency impact from a
pair of mismatched memory attributes (e.g. in a nested translation case):
  0x0: Use of mismatched memory attributes for accesses made by this
       device may lead to a loss of coherency.
  0x1: Coherency of accesses made by this device to locations in
       Conventional memory are ensured as follows, even if the memory
       attributes for the accesses presented by the device or provided by
       the SMMU are different from Inner and Outer Write-back cacheable,
       Shareable.

Link: https://github.com/acpica/acpica/commit/c4f5c083
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/acpi/actbl2.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index d3858eebc2553b..2e917a8f8bca82 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -453,7 +453,7 @@ struct acpi_table_ccel {
  * IORT - IO Remapping Table
  *
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
- * Document number: ARM DEN 0049E.e, Sep 2022
+ * Document number: ARM DEN 0049E.f, Apr 2024
  *
  ******************************************************************************/
 
@@ -524,6 +524,7 @@ struct acpi_iort_memory_access {
 
 #define ACPI_IORT_MF_COHERENCY          (1)
 #define ACPI_IORT_MF_ATTRIBUTES         (1<<1)
+#define ACPI_IORT_MF_CANWBS             (1<<2)
 
 /*
  * IORT node specific subtables
-- 
2.46.2


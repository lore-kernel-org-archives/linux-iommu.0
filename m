Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013043.outbound.protection.outlook.com [40.93.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF9274FC1
	for <iommu@lists.linux.dev>; Wed,  3 Dec 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764767495; cv=fail; b=Hf1TtaVU1uZqjJ4Q/JqnIlYIfn1uWKJZ7uwgGK7JZ3qcu4hLc0F7CO+vNVDrXv0TPgYjzHCKB3Gj67Zmxe2B9FIG+13Xq4En5+ZoDEBPiTj3lN2yrT0a1GjkJJKcjHhKTlZLNA1KMy1vfYH7/VVlNQ0iIb3/eESJmfv1umF+vB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764767495; c=relaxed/simple;
	bh=/rvbGUqBtwv+uRxvOGeEYSpwXvAHgYJLHb+9xQBaBr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ElEvoG14wy/oxBXfjDcQ5bccFgvh8s+q9zibjCQQTpfnRQLZDDCs60w8r8SqEMwFOSLxayvhKZ+SQBnqTifeYRCHnlQSBHGGzH36sN4uaoThldLvlDGkQ2MhDXVSQTyauJEphwr1W4bqQTFVChR4MTj/nx/ZGImhyqtwAR0+qMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DuE4EgUr; arc=fail smtp.client-ip=40.93.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DuE4EgUr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiZclQHr1z3SvDkPZtHpSl2wbgtaSZ89UznRPmR12qgtk/9K1iBMWfPjAW/ATFRMlKnxr1NMBIIvME6wsaKj84T8wcUK2oCK3KOXG7/HwCSzbeef+J+ivdh4CfVc88juzvoHBISTIMnwSx0k7QkdLpbVAs6YwKiU51sT58l6LaON8xhOYnC7sGVcnmlTPn9sNt9/a9KiYTwhBwkzkV/dKxGPCQTKeAoPHJvhI5O7ihSpa7/cwKTRALjo7JYw3soQoCMunv4UyY7ckRvUin+u97Nj/ZjAifpt7xQ4uayi3aM67+7dqk3k/kpYB7jgWSI643rGQcad8wdHIYybvGjo3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rvbGUqBtwv+uRxvOGeEYSpwXvAHgYJLHb+9xQBaBr0=;
 b=sI7EmIVdxsvekA+Tfwkes3nme42khA7KBZHFXMqKlm5OE1QDwDQdYVJNuFfb+/GzPmfH9c9o9h4TC3h2rMT4kgF/QJTsPFiuXq+LYwGFr98cDSNBoDn2WiFZxaMcfC57oVxrTzXGgcftMo+bmXnyNyp+SgkBuYDFRV/ADkVed1P/v3UZFmK0OVx20O0uqriyRE2pWmBJZeeXf7DaYCo2tqqmKXnxA/iw9bu5tj5Dnk1r9d6OchlfignhhKF4YRmxqD2ygp/jF/puDZ3pF9y4TfEFkHOGR9X3ydp6nassPzXzAToPvIu+hmCy24L2nBXMuk41ZM+RyN+RCj8P+FBUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rvbGUqBtwv+uRxvOGeEYSpwXvAHgYJLHb+9xQBaBr0=;
 b=DuE4EgUr4nzHpswUvHZJqrsDOnVViHcz6tp+4c04/4UFQReuK8GEjbLTUPdPhPEIFtStmH6mPa4i4JH1GIa+XgyrXXcFWhlKqe/aspShtsRazMd6R8suACPgkHwEZ656t12B/q3Mx6M9mZrMzjJoZzRus6WkUMFnTvTbS4dc7Sovs+p1H8VI0cLcjHSPM0uS1oXYbdvaKWOrzsMAkK2GBm4kpTlyNq+uKdJdNpxDh31xGZmyXKKf93lh7s+0iF9QTGUD3jhVIRPM1PRUiZAwueHPEu0U38ekL+VAK1y7YVZxXQC3NU+6AmcWvtj8IdsNvpXwJSpKQE2pH2c5cVaOPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 13:11:30 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 13:11:30 +0000
Date: Wed, 3 Dec 2025 09:11:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	David Matlack <dmatlack@google.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [RFC 2/8] iommu: Add a helper to check if any iommu device is
 registered
Message-ID: <20251203131129.GD1109247@nvidia.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
 <20251201173012.18371-3-jacob.pan@linux.microsoft.com>
 <f88707d4-bd04-4e9b-8d4b-ccb679d70dae@linux.intel.com>
 <20251202160635.0000433e@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202160635.0000433e@linux.microsoft.com>
X-ClientProxiedBy: MN2PR14CA0006.namprd14.prod.outlook.com
 (2603:10b6:208:23e::11) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: df8fe345-3ab4-41ec-2f8a-08de326d7950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nDCR6U9vCUqo6T9N8NMcz3fpfN+FC2R/OE0nh26F2OMve1ofEOoTVHCuBBF/?=
 =?us-ascii?Q?rZhd6HXbjtd9URtVGqsk8hXoqDf5Rd82Hf+P4Z3tdl7kISr+aCaEn8y9JglB?=
 =?us-ascii?Q?uCUmJartNle+0UU0WwskMVxdB9GSf7KmOgQb3yeeggKxxkJmd2g2nVG/FLMm?=
 =?us-ascii?Q?wNmyJawZOw4Gth+gQ8c8NU1nq56VNamUM2P4BFjL1vopgisWnsYz9IAk/tvt?=
 =?us-ascii?Q?QWRDSbu7VI592FONQuajeC5HnS7lBz6SDEmlMQqMszPYWJ7N1JdfnWampy64?=
 =?us-ascii?Q?dMO0JytX7JaZTjJt9YtI3JR9ZSXdlVxVIZZaMwgjZOJ3f+scZpZoLlOfz/6h?=
 =?us-ascii?Q?vZXkWuhIB1ih+tpBktY/OgzYgTZ4o+rNDBDilS0lI2TBa5IXcHla8So3tu90?=
 =?us-ascii?Q?pUy3Dm5jCKckBKLcYXcOf51xb94JK55Yfw4nioYKyr9qzng283HWqjWYI6vs?=
 =?us-ascii?Q?poNICrJpig29Ha1Hoz1xFlrr8hc5ZKChgj58f3Gr6JWLk+Zg/YXTv5fcnodY?=
 =?us-ascii?Q?sOIFVpZnSA24m4INkdkD2eexXxoTua+iFkJnETyUeJRSWXgiHTXE47h8fQhD?=
 =?us-ascii?Q?Vxw5TvvIKsJ0iITlwPQnFldWEU5MDwEMAR7qHLGsxYMh2MVM31idKd4o9Q2M?=
 =?us-ascii?Q?zEeN/A7Qk0joFtjeO72ffGNVuWo6f6BM3OBKAAKWSBWn3cpGWCynPMgd6Hvv?=
 =?us-ascii?Q?mSLxQJcXQq8hYP4DjjFC2p8EPprBy362dozIC+ulAP7QhUaPaZhT505aWiUR?=
 =?us-ascii?Q?NWYRQ4iO5aNNVS0697VwxS1LgSRbS76zFV+rUNCmCTOxpj8xqWTU0GzmCbAp?=
 =?us-ascii?Q?qFjq/La9szoMh38g2VeYdOvvCOLS8rQa98OnDEZX/nVwCEg/rkktc+XMmiQo?=
 =?us-ascii?Q?pAz9Ilrb/HxkN8o3JcS3oUtXuBqyFD92tvCunqgrUu2NETjNzzy/A1qNk3LL?=
 =?us-ascii?Q?0Gcv6Zzo1FCK59tDYF3lOLUGuHI1ax3mCUaB1qRvfSzMTlZyosXUDklnZ7w5?=
 =?us-ascii?Q?gq4R0iclkM+yadjRSkekRHBdCOngpEbFM0DOikKRbWt9eEG6fWcEd+lxPyd2?=
 =?us-ascii?Q?8+uJEnJG2Ab9usI9pyyrSmQlB4cpzhWkQ/k88C5aAHPMpdRKUModneseTUql?=
 =?us-ascii?Q?TYncOXfsu22AWL0sXwoqcMM7+GDZeKPBpYsPjwmZOjs9JAKRjsk8cVql11Q7?=
 =?us-ascii?Q?F4yQxirRhpMfANTDtklA/6vC7iqTWzvdAmXSdOHjMc3W2TgQpjrYgi40t3qz?=
 =?us-ascii?Q?82Iz8WVbc0k7CKbIdiG7biTcS1M6Id5oQ66uyIAr6i6isIsc+xWR4YrqkMsj?=
 =?us-ascii?Q?3FqG0cSPL7hBa1vkwX4uv3WJZcLitUsIDDVr73nLfxctiInSmkqCAeuUPoxB?=
 =?us-ascii?Q?BWOwJX1Uufqnds7JJwyW38mdQN6Ag5rzADdhSXJNbR7mkUR999RlIKk9NfrJ?=
 =?us-ascii?Q?f10KTmwK2qVQg5BU8hcVdWpoeMZdv84E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rpF3DPlXKq+VqnUEwNFAqUsqU0jju9uDcYH7U9rA7AQMaExI2zcONnqGC0Z6?=
 =?us-ascii?Q?ULvzc2yZkjTWPZHwoEfXAB7DGOSNgFJdI6pizPr8lkL82Cawee0XxxnZLIvS?=
 =?us-ascii?Q?sGafzbwRg8JtW0Hp8FWjJ+fH9CUfOtX6UpYnikMy80i/X9gT+RFpbJ0otjSf?=
 =?us-ascii?Q?TPb76sjPeUkfyA6bS3B/foOC2tsR2B/YX3ri+cJnITtcSdhoXS6DwYsdkA+Z?=
 =?us-ascii?Q?LvdW90negPCttj7AXkuSQA8pHheSBe6oDPZWkB4Um20A/H4EHUJOvoOyzaP2?=
 =?us-ascii?Q?D5K45lFrzxeVjpbUpg4ZXLcYQn/ENFxMzdTRH1nmd8P5b7m1rA2RkvLn4/Po?=
 =?us-ascii?Q?xLd6PG5vAWVKvcAyL4Ix/Xy7kSubCZ2rqtHxyG+OjYgkFJRRrdEfM2sNuhzW?=
 =?us-ascii?Q?Roge83/I8s+4CHGmPIGD1E7MteJRh7iCgkM318EKYkmiqJF4k7rmuyD+WVpN?=
 =?us-ascii?Q?vvp832DLzVHqt0bZ8qw1VGXZYhC8mlst3JdJNN6RDmy7d9nqfc8UUli+oI/R?=
 =?us-ascii?Q?L25yGMU5rjEr04ueCxynKj9UJFxRxM+zWAs67oGMSE6huXILnF8okIcjZqhQ?=
 =?us-ascii?Q?ENpFEp/v5uYd5sWKxrzyOxk3hxH+1OLJjqC4mw0FONlhp9X8x9Z14eacIGBV?=
 =?us-ascii?Q?ADHuDFweBEay4SrchmcXaK0M0GG4sodCJVFDDgf5lnvJJ4c0swOKvts46qqD?=
 =?us-ascii?Q?Yh1mgw+BSpN+U1t+IohYbAcOgF9oU+Zt/Xl+yMrRBjGk+qIsypHIgp7aR1I2?=
 =?us-ascii?Q?+k+WNlsYBG+E4APlRl+2n3oOGK31AQHGvQ2/Xk+E2tzsN5rbMi2xbv/vIaoz?=
 =?us-ascii?Q?A242ICUgXcyEhHNvhDlkmigHep52EYhbm8+Eq8hGdBrpodwNljPnfzFBRFO2?=
 =?us-ascii?Q?CWQbHrnCeerZv7476JwsX3WzfacbQCUF+wy1r/SDUhfP4TDwIW42PBt8VY9R?=
 =?us-ascii?Q?Bc0N+tdP6wwrPIqbZii4iDKz/OEUaFkqJ5TC2nC/H36+C8DpeAGReo2zlLua?=
 =?us-ascii?Q?QZvWXhfbptKBOkSEDoQUmrwUx8vApl35VWykagkvJ8jyUBR1PxasU5qeINmn?=
 =?us-ascii?Q?aHyCYrd/S1SwIg0tJ3jga1R59yLQRw6vLxLLwKRIC2hKxMNIe75YK8gP6Bpj?=
 =?us-ascii?Q?ihcnhTy8//60PuCWIfnFsqrhIPBe+ukmWGfIjDlcGUc0O74SK9DX+lmPXDnK?=
 =?us-ascii?Q?xwOyb+Q1Fh6RwbIwmcxXaTPWMzlg44it2c2xHVe3PnA0dVwhV9IuKJB6pcDE?=
 =?us-ascii?Q?kZWt5s6Cn2oF0LhH/NIVe1wIJm0Q1ylpjHtzbrLCvx+q4YfvKlqWHXCWmSq5?=
 =?us-ascii?Q?I1gRqVeVFt2Z1K+b/qelQ/9CRVWkAwFQ2oux29VEIRXE8PDLKszXhepzk8Sy?=
 =?us-ascii?Q?QgqoZP+humZQhyBj/QhbcAhrk2dDu+3Qv+RO9chNlAWBzUoz3+gae9KqIVLp?=
 =?us-ascii?Q?rdlo0w0Fomxn2z39CwRgi7RkYfCIi+4LDZB+Ih6Ox/vwRSx+CxnGLq4vYdzt?=
 =?us-ascii?Q?xrC8usoVefHMaTYtIaNOGLCo+ncmd/oXs0DYQrY6vJdGFrIN8Jh3cWVoaBra?=
 =?us-ascii?Q?GwWWsqryrikm3muPXpo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8fe345-3ab4-41ec-2f8a-08de326d7950
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 13:11:30.8224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTnqWtjHnp2ftVmBs21Li8+oaI9UXMgtCqro8m62+nPZHlhpFEvoCPT4ZVV4MjoA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942

On Tue, Dec 02, 2025 at 04:06:35PM -0800, Jacob Pan wrote:
> However, as you pointed out there seems to be no standard ordering
> for iommu device registration across platforms. e.g. VT-d hooks up with
> x86_init, smmuv3 does that in platform driver probe. This patchset puts
> dummy driver under early_initcall which is after both but not a
> guarantee for all platforms. Any suggestions?

I think we need to do something more like the sefltest does and
manually bind a driver to a device so this init time ordering
shouldn't matter.

IDK maybe a fake iommu driver has too many problems :\

Jason

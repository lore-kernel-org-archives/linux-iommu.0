Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B742E8E7
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435030; cv=fail; b=tlI6HwAZb1nhv9Cn1DhXl6aQ46Y4F81Gt7UWlY9Kt2dJeUI3NkZPj9MXdRPoRZIKGHkDT5CCij+xxHvgEwcLuanMLjWUh0BXqsWwGPWAKbmG1MAQNpds269vap2uHbUQZ0OYfM28xMu4wzU2Wh7WC/fYMhDMlAEe2YGVXIcFWBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435030; c=relaxed/simple;
	bh=KH6uDUZgS5Qn77VFtb0/AxFRKFJXfTqudFUws/Stxic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M5uRymtNLUWlAC+opySxrBYfqKn0sfNVmN5gjQk3BKngIgZk0baQjP/DoxChtCurVNiX5e3ro50WnhHYo9mhhg4ZGccRmtR/3KnIL3odagCr6EnaBrN3KuCRqMVEslDuCgOw4jINHoDaYwraBlhgbDYmMQ3sANIJdf3GJvCvX5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TRu5kZgF; arc=fail smtp.client-ip=52.101.43.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TRu5kZgF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LusPvhkwitlVo8ZTgnVu/ovGnsDhrnOE80skEojNkXJ1CN8X8UIX5VXsWaKALbY2eMS0j4JjOBbllwsp4LcvBm9lJ5Vd6z2q0oOaB5d3YOEZynm5dzKKQLzEd3Q1hCKq0GcLH7SPMesbvh7VXiFll1DyIVCGIswssMcMxqXI0XwExBEkTAWlsK9R+8pmv4VFgQf7/ajjBIx88xGJwHqlphwv/Dn5RUH53Km30zfLE3XtqZluiE5/uMScB2QyRbV4P3X9YZKdkNiolJ5bdR2gpB326Gfdiv8Q8lZANRLYA+sWMsGB32iiyHf9bc6syYdjPu/mB6DRWiiVf4RblzWa9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KH6uDUZgS5Qn77VFtb0/AxFRKFJXfTqudFUws/Stxic=;
 b=l3r0JkVINi6awwZUICcMZOYLnqamEGUKaci4aC3QK/Vh7mwjXx/jcofOqtPArCL9l5ShyjzotFDkcucxxILgTezCB1wuqpyD3hVMTLj+ATGTW5Co7tjQwRICTopV2RuZW7pDZP03OQkBIS6hJeidT22aF25Ewaw3WySeXPZErpHfwAR6VxfySMkWVQu6xp70m+hAVVsRrT55FcSWRG4XawCdxug/RJsgAevDEsxMZuQSlrrhdj0IEmC86VtXqCtQhBBoucSB24xG6tLrlnMuDyh1bN2ci1361GDvt6sDTpzUjUH+opYdMX8zbc0uoa+9hG3gW0R9eK/2306+9IWkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KH6uDUZgS5Qn77VFtb0/AxFRKFJXfTqudFUws/Stxic=;
 b=TRu5kZgFJN+/yvULB1tLjMKVVvO0BKzRwNJZneCG6jE1bTMgtRmQpp94+EZjUvqsbjBB920zNcYl4GiW1hzrfmpED4J3rFDU6E8iWWTSGs3xxvG0WdPglbNhFlERV2tpFZceMxCEZ4k2uZl+caLzQ3aXFp6yQoxzG2OkeE3X2XZkQo6awpsRDiHMvzp1aqZc6xgjFXE4ESfdgCyqHM24EZ7VHC2nsDsc5tRV8uV2X/zX+ucQd6mgE3IeY/T3/K+m1bQbsHvwpiAz4PkBhudV2HA91uy8qwdktutKqg9YzLmT6vodwFXQz3i0PguWMYJVbUq9AxVFgo4PXLo5IOSS/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 14:37:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 14:37:00 +0000
Date: Tue, 7 Jul 2026 11:36:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v3 19/22] iommu/amd: Add per-segment translate device ID
 pool
Message-ID: <20260707143659.GG220801@nvidia.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
 <20260629153535.15775-20-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629153535.15775-20-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4PR01CA0350.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 41401966-1790-454b-805e-08dedc353460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|3023799007|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	YFTmQZNQ0PPqWDhd2XRufk0Gahvsczil6FMKI7008BXeGHPDGSOLXPqQL+Jwfj1uERowUZppv+S7gHDQvY5spYh+NxFbcyvuU2jtmQcUbzZczCTWBrWCytE/A1gUbPdyQO6TiETTqTsCfGDHltyKGespPV8zwUp7UoYOI5L/gtyIgC8PSjPfqcfvC5M1ds3UM1l4GbXxU3ttw7WKTO/JI8aqVdgHK0GwCcA9EMTJ6ED43/oD50JHLr8gVy0y0RxZRMJ1ZB0Pi+J0zD9kgSqDUJW6LxeKRaNbeZPeGfJUzDv6blSFBstTrpOJAs+B7iZYInygElTxdxPcTwc6stiyEP8zZJbjLwyk1A/MFki3A76S7bTP56MS7jLGJxpfbUmONYL4RiLl2OSRAliaoR0Qye7wpIZZSBPU5SXGRF3eDWAFRjV4K0qLZJZhAwAakvuXAwGZZNe0NirIYGQ4F18GTrcmrwetvJNb/frO44oMvDZ5FThaC54GfsfTECC6Xa4LDusQQMbazk7gGud5K/xuRZ8xSjdDh8NPAcpUb7kQi0hy250qD6370r6GT+9ww0XgO6p0NUmJjVVP4GgPuswCplmwtnO2pKrmpl+VYIgo6YE+0Lc21SI+YV1VY7JSaL2LxS99sje64b7+CnjbUyJe2MoObg35AOecimmZA5jctWU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BtRgIA1gbrRaHLkcEdggJDIrhmxaJF4cmcoCj8Y3LMl1FPsqyAwgmKO2HaYR?=
 =?us-ascii?Q?PMlmKdb1vhQYVEj5AUF3H4M3gpEMTKPrxCyQfZUqg6ahaz0Hf4sCK0HGV8Cq?=
 =?us-ascii?Q?ikiib6ys0KgD/gDtKMvET4KitnpkL+UaCVXSs2+g5ijfy8srJrQ+i3UOF+F1?=
 =?us-ascii?Q?6Z44JrbLwc9VhjIWdxdoJBaKWe2xWNps9OmnTOKYf5JOQgMMvUt5Gb5rauNI?=
 =?us-ascii?Q?pORcvI+N4j7X31wz69xhnQfva5aQJdUEpB5IgBM0AQSJkOtql+qTD4tUwspj?=
 =?us-ascii?Q?Ei+yhGixt0bTU/xhp6XV1FOAwnVU5NwaD+X50rIuE6k+cYTiHpSl5Zj6I8ny?=
 =?us-ascii?Q?wqsPo1YW2f9m9xm/ypRkGU/+wOP69PWDCFVrGoGmZiP7fjQ/joo4gHOKZpdr?=
 =?us-ascii?Q?Vv6JlDKYwEVuoudnH6qkdxZn74g0eo6DXhTkX6QpfS/wKyUcNgOJc+dOl5PQ?=
 =?us-ascii?Q?EN1DRjqnUT7LfdLNj6BDtsQWPoK2vbZuaQ4aW9fe8SMPxPATA2nARG2ioWAE?=
 =?us-ascii?Q?+dA0oCD7GAK9vlRJgVm9PxPZm8iGgPBOVgk5gW2qVsZ43wnIubQRHXxVm9PW?=
 =?us-ascii?Q?BKZGKgQJXbDJWPVend9hEvjdNx21rKx3KJOgP0vnd4dfFri3FBZ15rCjsxJG?=
 =?us-ascii?Q?1H6CCsEi4XAtENeIN2AIO39Hv9hsWzuwvAK+QjTk5izaxBt73OwDkw7yJSy+?=
 =?us-ascii?Q?8DMoyyCLnkrMRl40a9SVeWaco10RGU0evZZxITtlDVMRDNylnBS+HFqeMFUE?=
 =?us-ascii?Q?Hu0tWP2JN1Yd4dH6chmUyttSERdFIBMKbUijyyb2lx5LFcXF+fDNPmgM/UuJ?=
 =?us-ascii?Q?4d75l46RfWuj23lbi+FWh/qfyNQc08K9L+2/RdoJXp74U+AClw7megRixPwl?=
 =?us-ascii?Q?68f+g02jRvzMqhDqgoExq0P1YCL21LESUpmJJB8BFkZN2MtEgT2de5RelT1/?=
 =?us-ascii?Q?TpWlepgyU7awXIT77afCZ40esky3vc/Izo7lIr5wPoEkmur9NfcNke1fSpzr?=
 =?us-ascii?Q?raTzxn+NDn176pVWF7xohNlP4zPDqjHTN2Kuld6QCHh3ohFcjqfk/Fi8bCyA?=
 =?us-ascii?Q?hzoZ+s+MqoAfvpV+Wg3t4DDj8Ey5QBxHO1plf1zXOCYonzyrgx/KQ9NZA7zc?=
 =?us-ascii?Q?z5DKulgsSX6Oktl5bjCVkBm41ps5hF5ay0YW1RH9LtUttRfG7JfaEPDNRFE+?=
 =?us-ascii?Q?7pt/IDIxLkuBMKeBbkVXsKaDlwYqeDkMV1lZLT1X9+EkS4auc/67F9QdOXxh?=
 =?us-ascii?Q?xZqFRg5dgiuI05z3PjFCbPRhaF9c6zi6mxuYZFoR2Wraz7WIMHUQFkJsrjoI?=
 =?us-ascii?Q?fVqQmqF/50rWdAqv/M31d9LUG2Ppasobrgg6iSOLl0twlULWpsVC194cYYqb?=
 =?us-ascii?Q?q47Wsx54NcxZqiNW5eC0oLq7TEpU7HKN7aVBzNFhv98Iw1Scl/Jq2tMUGahE?=
 =?us-ascii?Q?CvfMyb60pAKvJ0dIhXQzP5GxexEHAQsAezoFT6tZKtBEqblvOABURMFDJzcP?=
 =?us-ascii?Q?JNYBmE8kUuWlFaQnf+w/CocqNsirhV1rXNYwzwoita7TwLAwaklU/e5O67vi?=
 =?us-ascii?Q?wkVONDACc4GHSi/KD78ZykWx/alSWS3o/Eg57F4wRH1+KMpVPH5kMt25aOrD?=
 =?us-ascii?Q?xYTkFvD7jL3eCHH2bFppQxX6raEvMl2g1bg4segDSUT9SC6aeJyXAUwEbCh6?=
 =?us-ascii?Q?PMjkpcl9bPJYjsnLCocfOWbOOV8Ay3aqUN3QoROW1pxUgoNJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41401966-1790-454b-805e-08dedc353460
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:37:00.5821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIeNRJ5IZtkTIujMTX6+QOYfx/n6hLRuPUrVUTk16KOwb3SQVC/uBw8VJBz1vidh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662

On Mon, Jun 29, 2026 at 03:35:32PM +0000, Suravee Suthikulpanit wrote:
> Track translate-device-id slots per PCI segment so real PCI device IDs can
> be reserved for normal DTE programming and excluded from dynamic allocation
> for vIOMMU translation DTEs.

Why does it have to be per segment? The segment is encoded in the
devid isn't it?

This seems like a sketchy design to me, is it impossible to atomically
change the viommu used devids once they start being used? It seems
like this should be doable

If so the algorithm would be simpler, just maintain an xarray of all
dev ids, if the entry is marked as a VIOMMU and PCI needs it then move
the VIOMMU out of the way and use the entry for PCI.

No need to try to guess what ranges are usable or not.

Jason

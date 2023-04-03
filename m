Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D7B5683
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 14:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4D2A+KuXxGMC2FeBT7yDmUMOyov85yYwF2GSusdFcSUAvFRKBa1zO20YIXBygtHDp5SLAqhl4VSVRjBDeiWSd79sIwlcz6JrtYryO2Poe5djF5G/WPL2uoi3iB8ismgTjtYgQFLOB2keVTKsyUxuqyGFy4rJfiihtrWIeu/YfMTNde263blbze/7iH3Bz3M6EqL56pDXxl5/3Ksb1jtMfn0YGChiNqgnwMlJwEkwb2RFORVfnHzrmbwVKoFVr9wFhq5Nt/+h/j15R4V66TC0pkmx6VKe4UVVgxQgFhM0BnTCYB2+toqYIHr11adCN17KkvVaIc1ZLNvvqUZ1JkBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNHYzs9pAR2OtH5khSiA36qskCrwDPmd/IXh9GBXqD8=;
 b=eUMLS1iN9T1Xrfk4LUdMjcnyYcKPBbjqzsd/gs5f2pbSYMSzPN/qLdWTjNPPd78MYevMaYvYSz7EF/tap18wcPKbLSUBETNNyLy4Lh+G+SxjmvBTeOj5pb8UG6QmXRkLe0kdbTdvRmWoSvKgNbd9RRCsBLiLNev3db+zbX2UABPvyDdmAnavRjF1OvQk2C//ANzz5D682S5t6E24WaWQ4D5HHuUfmpm+4xQVrRwYqtMgtH16p3wQhCfKY/1lepFxWthjY5UmTrWxtwkn1jBrCB7SqzvUs5FHXtnjN7/FYxN6jYpNsAaN0GGWNSiFXAhJaDsVQxPOzhliW+ijy0x23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNHYzs9pAR2OtH5khSiA36qskCrwDPmd/IXh9GBXqD8=;
 b=eV161piLdBNnvvg/Wti/k+Xc1KQbGNA+J6GDYYtR0cunFucsNpDclT5OHiBlUw7DIjtFrz6U3SRW8v68lN4XJKhFlCyENm4qaZFPy6ZcuV9nunEd9FwO2NX/4R7N+3sRaCWKyx82CRF2RaQYMJf2AtO3nLEB2NX2e6DdAGFj+DqIcRtVctYT4sYWOHJ0csPjwWVS5ld7LGONeege3GoHlvajtuLLj07YZFH9POEt3uIMI7oDZ8dQ1uRqgDGdnwUbOqGFx8roIfoTAiwTX0IEoSKx2LlpGOX6MByH7riMxI7swTk36TL9ssKBnveDeLf4LqON5/yRteeILfYXYTx8+g==
Received: from BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 14:08:26 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 14:08:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 3 Apr 2023
 14:08:25 +0000
Date: Mon, 3 Apr 2023 11:08:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, kevin.tian@intel.com,
	yi.l.liu@intel.com, eric.auger@redhat.com, baolu.lu@linux.intel.com,
	shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
	iommu@lists.linux.dev
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZCrd1wphkCp8uFt0@nvidia.com>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR15CA0063.namprd15.prod.outlook.com
 (2603:10b6:208:237::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|BL3PR12MB6522:EE_|MN2PR12MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c0b5e3-2d6c-479d-8aff-08db344ce430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ITLslQhAYQgTDUrYGIMUZaMK7uokJz2W5fts/9aNm0Np1+NbYbdcncQaFb4D424Es2+bYXyXJNep18Mhs0tRjkNLIci4qKyuMK8a5G0GIikIhTVHjG3wmnkNiZj894uj5JZLkBHEqdo7SVKWPuEySwOAiA5Gc5CqiVAxZrrabpiB7oNARBs850vYdecDack2pUEK/QhLpoUrSnnfwRPDLUTT2P86EBhMXnyXvozhCe5PppOkLPoiL86evQ5IqT2mfXyVt7RugR2+dh5r4sWLISf/Kf1sI08j4/JKdb9L/qiRPh0bAQWvUottAM/1/PYrwcUpXa62rwDpf48sAnIADd8PKvUS7FULnQF9GGKefg9qiDYd0N/0HZeg4FGBXkkPleNbO0wnYfGEzrFI3k6rdCb9k2S4qpHHr1vMbI752xc0HgCgSgzicx15W/ay6hnVxcQeNYT/zTL4fmmUguFhWQCq1xCi/YJMp8ASTp/TW5MnUTxRdyw0P5d5LvLvaaD0Z2pLlAfNTPdRHt4P2hPYRycr++q+Av9pfGcFpDELzHwq4kg/FqsOosR+FWZ4TU5I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6522.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(8676002)(66556008)(66476007)(66946007)(316002)(478600001)(37006003)(6636002)(4744005)(6862004)(8936002)(41300700001)(5660300002)(38100700002)(4326008)(186003)(83380400001)(2616005)(6486002)(6506007)(26005)(6512007)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h4acYFGDKUi8AJnjn396B21lMIaQMSF8qpWX2HgI0h1eSMZAQl6AgI/QPR+V?=
 =?us-ascii?Q?yJi4koXGCD4kN0JID6yAcd+2bHJ0KNQifYVjBeHE7IA6DV9WR8eZwJYNdmTf?=
 =?us-ascii?Q?+UUEYdIn2Bn3qH9dp1npSTnUW/dKhZTijlurr/ZNdaU25BUWrdP5cdzm7jSA?=
 =?us-ascii?Q?CVnUr7Ln0Eh3hMEjp5l8wfoCoU6H4Z5EgWyQTFYyuESxS80XvCnSsBkxLFf0?=
 =?us-ascii?Q?/jHxa0KB0H6W3Oo0MyKH7tGpxfPIwR1niIClwqrj/jWeol1p1qpDxSG4IvgD?=
 =?us-ascii?Q?Fv0uIUlDesuhRpEgfqMdvAZKhFOEJ+Fi2CWDEheylMh8/cMZNqU9ndWlv15F?=
 =?us-ascii?Q?CW+HoFXd+qhaTms2zNYkJfEa6KTSv6rHtGfpwDwXbnfyxRe/mzP1hMGh3hQo?=
 =?us-ascii?Q?5xW4LunDjnA7e/4Zg7eEFUMaYNEAi15aLRTX+bfVbGZ3KuwsRYnTKJZopx2s?=
 =?us-ascii?Q?Q5/haUNawUyxmT5q0+bLg01xn61u4xx3TKV8yaF1DFRCcbOQ3D2j1fOknX7Z?=
 =?us-ascii?Q?fOKebiGUmYkRUufaUjmXRw79Lgu44SwlpPud2/e+hd3UyBOrr+jxc6djmnPl?=
 =?us-ascii?Q?QxxjZi+hXFYCP3t+IDvbIozVGE5jKljVHxw1bXXvNAiGwiA6vat5v0yEMCQ5?=
 =?us-ascii?Q?f8gDPJRpn4UnhMpMi0LwqtoxpxV9N4rqf6jK+bx4L1Ta7uC4YOYa2SEjnOyx?=
 =?us-ascii?Q?W0RhWP4QItLzeg89ILRxwcVCJ34hBKNcI1cahyBHSbyDCnf2aVsOQOuR19Ql?=
 =?us-ascii?Q?f31PrJM19dDoK6FALLbYZEDuNIIHc6qu3hMu1vdVpcybENp31F+tnDLyoeZ2?=
 =?us-ascii?Q?Xmc0hOpc9KJPqJCaqNFF8LAn38mxlAeMV6zdORFH54CjNedL8BVR0dcW4cDi?=
 =?us-ascii?Q?SoOhc+Ewp8+5H4m3rgh0vHeDy6qNiaHe7OYGiGpCXasp6lsSdQT9V7JyFPON?=
 =?us-ascii?Q?DkL6InBggOQMK+CQZZYWvVqJl7Rbz3xROCNIyPqaFuMEyzZuUqZWTBGQ9r9P?=
 =?us-ascii?Q?15TcakwVUghuze7VUK63V2hbzWYfFufJSyEAmqqKepWoBQDIItcCHLF+dV5z?=
 =?us-ascii?Q?9HPztEiyN4QhEvumJQP7mnIyVuJj2AvAnATqV9GdKowC4yhkLt4EkjHURm19?=
 =?us-ascii?Q?r58DA9XPLUihr6ZQcJkeWuwPW7qRhbofz+NtQ6x+OqkhAPU7ZlgxfYUh/i8N?=
 =?us-ascii?Q?czfp1lmsbvGaR9RFPSPcuu4wSSgHBmNet8R6atQOax3gxT2Ng+UCG+20xmRc?=
 =?us-ascii?Q?hqVQjcItr5YaKLHQIf/38dGvbRjcnm8MhTrkhUiQ1zF068zNGL0P3s0YsV63?=
 =?us-ascii?Q?tVM06Pazc8Ftsw9mwi/W28wLzl+7bnc7MtiRKXH4fV5FzEuWoMhOyEnbnpcM?=
 =?us-ascii?Q?fY/gUjCcPQbQXaZi5nlmVcuTROUBRQQjgn3i4DdL9Y7JRaKmPgp6ZIZ8YwiK?=
 =?us-ascii?Q?mv7dc5psQVilr6xX7gIOxWHAJge4TJc0uh8XV4Bzef87hZpZHeTwhAMyCJz4?=
 =?us-ascii?Q?Btae7W33yIVh/15JFvbQ4+y0MMsnGHlGfSxgqkm1KKEQo+3G5pIlv6TxY/yn?=
 =?us-ascii?Q?i43/ZchmaBohcxTFC0A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c0b5e3-2d6c-479d-8aff-08db344ce430
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 14:08:25.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3xD2O7oBfy4o9BPzFV0Bsrp7++jEj/U58uGFkDFjELngCV5G8jdnGgRFUO/EhCp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438

On Sun, Apr 02, 2023 at 05:33:35PM -0700, Nicolin Chen wrote:
> The first version is simply to individually forward the entire
> command. This can save a few CPU cycles from packing/unpacking
> invalidation fields of the commands via a data structure, v.s.
> the structure in v1[2].

The kernel must validate the SID for the ATS invalidations, we can't
just blindly pass it through.

And this simple path needs an explanation how errors are properly
handled, eg by making execution synchronous, or someone guaranteeing
that errors are impossible.

> Then I added a new mmap interface to share kernel page(s) from the
> Driver, to allow QEMU to write all TLBI commands as a single batch.
> Then it can initiate the batch invalidation via another synchronous
> hypercall.

I don't think a mmap is really needed for simple batching, just
passing a larger buffer to ioctl is probably good enough

If a SW side is built it should mirror the HW vCMDQ path, not be
different.

Jason

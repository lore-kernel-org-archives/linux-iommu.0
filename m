Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26172E40E
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 01:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767057562; cv=fail; b=UjXQp/5K8aYODAMUDOmpce7liZNA8t3vagtdO2/D75SEjVt5uSdBf3qDlDltHtvpGvKt8u2wcRQz1H5wkhoz2iCUT/h9ijjIZ4gySzxjx3nGCCd0ggex2iDbw/U0yfdNaCS8mV67aOcD86PmsLwsFC3aXeEBsGyo8ItpLZjlOMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767057562; c=relaxed/simple;
	bh=TQocQG5doWiXE3qjxP8FzRbQos9Lb5pNhfj/OWR0lrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fTegpCLjhrH6I5sm29TzVYQGxjkhHz01HOCwCgWPbbWpnrpusrujB2BuTq1jpO9RWdNsTRXpV1qGi67QmttX6Dy4EdzMRrqx76nnGjY8I+al/9MhoKf8EJvO5ilUO8UFkipFghvgFt4egl5JfAfrwXmDB4G/1YIgMbXRxZgbp6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M2P4y93c; arc=fail smtp.client-ip=52.101.193.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M2P4y93c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvkAiLe3v4su6ije6RGi+g75cRkqHNmaS7Sbd+fN1Oku7CBpHEyGi2tMncIEPnPDDse0aldeIXNEvMmVFu0aaaOugL5QpisfrgKYgXmyrAc9bFvt6jI3ZE9Bho5eQeSH4JMd69meylgwCNWtPeJfHWPzVAgFGbEzd1x0l+9g0fA/1DMdjZyf8TNyrI+dnb15nljvQVDVrC73Cvn3rTClbyGYjVKC/PFB83yhkgtELkaVJ7GnNfArEqtdUbnWm+Ig8GtbJSYtz8dFzU2BlG1ZS0wTz84bXC0LLkraNkJx2TG6RXUdt7u3MI16cljBJdLUJt15Ijv25buyz75oSorquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQocQG5doWiXE3qjxP8FzRbQos9Lb5pNhfj/OWR0lrM=;
 b=AkyWnIvuNuWpqAx2026qpnSbzydTDrPvjvc2Wk5BvqG+In27HEWUrNKSexO+gWLRo4rW9hy+OdW+Ic8LyhVABCIecBu2yCnbDyvIWPJ6kZoG7XM01Zzy1zBnQ/pn5VM/aJk+0diF//OG1xEwrLxvqtg5QSLRtDWAF7YmOkC/GWPvKvJsP6btKKQ0F9QWa8rXOp6Gc0Ji/rsCEylfzlCBOXMoUUTNQ0toKFKs3gnOStap0eQhNkmYhhBGdLm4CEg5ePB6aMKt0Fzs4UAEdz/oUfP7NFNbW8dlnxB+cmtooVlD5tlYguq5RelhemYJIh4IoVsncLmLXedkykPu4G3Y/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQocQG5doWiXE3qjxP8FzRbQos9Lb5pNhfj/OWR0lrM=;
 b=M2P4y93c6rPAJCy8I91CAU8ktP6GG1z5yQjA4LkO/UT0HcKRc68FxKZjPqJKXQiPl8PI6V4XbRbR5PiY0jcJC0dF7qIH+DDHmJjfx1FK0vjsGVOtBxMHWBrs1HYEWZk4KGVtPEkdZvaIVFYmDT8GvN1TIyE2VjVl8eUuAQF58NMNZLp1CfOtB0COF+CjgmNrMkjgWphZVeTbmkectGSPjJAcyN7IZ6+ewSp+eHGVu7Eepqfrc5bbbKscjYyqr3l8LyovsxGiPzO+sKwM/IMQJrihBAGrxdCwBKFT12uWCKhdSBCbAVTK9M9dbt9wW0EGRMCtgUUDjr4GMBlyj9UB7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 01:19:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 01:19:17 +0000
Date: Mon, 29 Dec 2025 21:19:16 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Heckemann <linus@schreibt.jetzt>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v5 2/8] iommu: Remove IOMMU_DEV_FEAT_SVA
Message-ID: <20251230011916.GB23056@nvidia.com>
References: <20250418080130.1844424-1-baolu.lu@linux.intel.com>
 <20250418080130.1844424-3-baolu.lu@linux.intel.com>
 <ygaqzsib7bc.fsf@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ygaqzsib7bc.fsf@localhost>
X-ClientProxiedBy: BL0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:91::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f594f81-726c-4936-5547-08de47417372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3nHu2nDE47sAFBhtMzXrYfIupGQ3A5DfFU4VjEuUwuzkhR5a9IqRSjvdhT0O?=
 =?us-ascii?Q?sap9Oxm/1iV3aWiMYfv41Lb8Ez38XCk29pSXlE8x+2FIwYVPHhfT/FkBea4U?=
 =?us-ascii?Q?3iTDvTev379hiFllg9/q7Ri2skp/JQTjZOZuHJ9i/HtmMS+eoLIA9GStwPgd?=
 =?us-ascii?Q?/fEM7HQnqFjTTx8SnI0KzEI/So0WYA0DvyMwxrKNOMW8GfRCwzUnX1g956vB?=
 =?us-ascii?Q?W3Us3ZDA/DiRBTPVP3z+Ur5U4t4gbD+n1sSKlLncmMYSAF/W+fIJ9NECMPjg?=
 =?us-ascii?Q?4wGHzoiPU7hVY4sc+LfM8Jwoj0noXf9A0OfFufM2rXg0an7A6YKTI3iaETb/?=
 =?us-ascii?Q?n0kxlWNF/d+O+ZNjQxgn3P70xvf+f1+mP/X6dTCGR9kd3WYtCG2+KhxtoGwE?=
 =?us-ascii?Q?KERpWe75uepg7opNsUknSLC66nqfQ8Rfw7Pv+E7BbdL0nm3qxCbnjBvFj9eq?=
 =?us-ascii?Q?FDH4Lxv39e1qfVKOVFmch0i2m4LAvA1cOGKC3k1ZUYorr5dZfAoj58YHleYq?=
 =?us-ascii?Q?JRPcPExV22xWaS2SPVNSKpuSoBpOHlfUdccvQnZwIpBuGNRjnZyZcYSyT3kR?=
 =?us-ascii?Q?ANF7O3Oju7jmEiOJff4njedimfZOi0234YcpHcyVvksv23xPKQ4lNT68Ono1?=
 =?us-ascii?Q?SJpceY7ivRCirw8n6qNsJD3d9kBIUiR6pcSnYy8osPSuam0BdeO5Q0sVCT+K?=
 =?us-ascii?Q?d3MV4lS/m6cp8DDHF2yXj0u2Dse3CcWwy87YB2zP5zB2VrapSy2rHU+DXwI4?=
 =?us-ascii?Q?PDAJgNqtPOZ3fiJZFXcIkOkF5S39zHVm6toBwfCSOx1rDWXFLYT+V+QPodAV?=
 =?us-ascii?Q?S/7JLkNdsg1vAE9orzPmHQCWanOt3k4GNiVpVcag0WJtYZmig8FlAReXo67f?=
 =?us-ascii?Q?RPFrNYdc72swUHTyRJp90C7z51RRUyOOHCOpGzMQAnamLa4Fwbaa/hxqKBjD?=
 =?us-ascii?Q?saW5zj77Qfu0EFOoZp9n6x1hyuygY2jTuoZLDzdk3wbsVtHK142FSLDlS/X4?=
 =?us-ascii?Q?rfoqmikQIIeJkW/Jc3fPFR0DM5p3J3aS6NrKX07md9gzktAIJo0nLFV8aOoK?=
 =?us-ascii?Q?RPafOaRwc7lu9iCcuEpYzE49Mshs5haZcS/UR/ikavgy/LMNHdouLk/fVoxd?=
 =?us-ascii?Q?1XEYSoydb9yhniOA08Wka2zsKscfZDgYFYc9t0hcIMdw3H88vNNQL0J/uKfr?=
 =?us-ascii?Q?uBKObT4GpeT4NaeQK5EGi2objxHvVwLpW3iOXHS1+7nltacgPI+IBWk9jIfX?=
 =?us-ascii?Q?2Waz8kTC1Amxe+R6d1C6e+DrbNnAlVMHkk8St4KoNOLw6kNx7ECrnE+e5Xwp?=
 =?us-ascii?Q?v90cNXJUQL1ZUTHxEg+bHjVCVKJ8UjN07KLV2QP0eyI65bndhpNNpRDAojjJ?=
 =?us-ascii?Q?dtZKTdW4dHuAC3YEDiQIdHy9rK4LXrLkciJ1BTmGFm7iyWRcA5xnRqLFb0fU?=
 =?us-ascii?Q?U6fj/qahEqkZOCJWJaQTsEbsGALSU6Au?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xh3ED0gYKsS1yFu94sBGsA+jdW1v1Ux4ju8StrZ3VUMabzVfTNW3NjgwGDql?=
 =?us-ascii?Q?Pkge8neeuoak2aaYjqNp1yQ5Ro38+4jBQGQwtVdrLyiZuNLGe7tjc8BnTKWV?=
 =?us-ascii?Q?pBO4Uzof+DJDgsYYytuz6Yg8JfjJRJTZYbeohil3g2peC0OAEXc/m2G1//Lr?=
 =?us-ascii?Q?UQcqeBAOTXQNdFpSDBfiLLhst/a0xfNoe5b+Z1odUHcWIlKr6u0jlb8yo5BK?=
 =?us-ascii?Q?iu9lY3X6RVvgUcjI3y/KI0WBokh3UG8UzIiGuZyw5IzDPsu4TSK1g4le8SHg?=
 =?us-ascii?Q?bjoWU4oqluPJZhfT/V8Ri+mrnpUS9/VLRSwu7RPL3e2+grSeeW9jSIh1Tifs?=
 =?us-ascii?Q?xQwgFk4JdyrDnRqfmnxzth85zAJciQWhKz7enAp5hxZ15JcHbWo/lDazg04I?=
 =?us-ascii?Q?PBfZNTqHGwMwta+Nif5+jUtk1SezDMlEy4NLYwZwyOsGNM5/cnSfAoJstDSE?=
 =?us-ascii?Q?kzKCP3NY6kYeupyXwLyCR1OpLLt05p8zaYVQaAkZcDGi/JT083B1WaNxZa0M?=
 =?us-ascii?Q?uOBKfWCXh64QtJ2eHqVffex3TakFtUPycgCFgNn6i7QOdMdYXOgAE1Jw6BCF?=
 =?us-ascii?Q?cQVT7eS/u6WD+KGeNocEeAvUao1pHeQeYm5uE5F5t1UHVj7JOcpCU9KNunTO?=
 =?us-ascii?Q?VPiJpVvyNbLSeHgnqdZcKt0NCl0Syrw53wtZSut/iMLv5FFxEuUaCadAsWv5?=
 =?us-ascii?Q?puy0wEFZXT8hUCS0QcNxGsU3uTK+aE7BICWeVSItvEnaqb5Bh2zh7iuJjB6q?=
 =?us-ascii?Q?HBkzvVRKhkBBSVXbo09rGXVIWOxxPQtGhTWn9n9q1EtmR0bz9qfg0et3+vZh?=
 =?us-ascii?Q?M6T9cfS4CYKABmUVmC+Kja6cZfnQO/srFlDxwROttJAc2GF3WqMVsO8sxA8E?=
 =?us-ascii?Q?+u93FPATAiFaogrOsCxOqLvrWpVSN8EYCssJ2JegzL3lcNWc2IqARhqEvbTl?=
 =?us-ascii?Q?CAQvmj1uvFzWhzyfaQnipC7aVak5p0X9goWzTBAy1Vm9whrYM2DGyJG0IPfF?=
 =?us-ascii?Q?+fNH48SuEMnTa2a6peoiGL3uuNwiO0z7GJcqtuBa3agCTc1byP+RyK/ft6J8?=
 =?us-ascii?Q?PlDUbf33Dz0IFFqO6aFJC3Q7ep6HjRLqauVFvMjnRZ9W/myS6IHmYdP2wU5q?=
 =?us-ascii?Q?Bs/7/0elBzlha77dnwPsCvF5zS6x3bc2j+Y3++jd3h67L4LFajGOiBRtiAV1?=
 =?us-ascii?Q?Q40YlhiLgcI/C9ip1k96iqkviE71JWIVsiP3MvpwkxgQczWai50xyvNoImHO?=
 =?us-ascii?Q?QfGynmaMfCFN/M/4mlqooCUlhgFYnBcj8t9bRIwL0VmIiT3OBnOEDJMh0/Q+?=
 =?us-ascii?Q?hH9qEVvRUFsn+UTTLIYFMxalS1c5o29WAMXyKFmANKFLlzrqXZzkH+7DN7jD?=
 =?us-ascii?Q?JYC7mgSnkUSCt/so272ZGOF4bAdF3ZgIFN7BA1UVq+eUSGSDPA1pbf+9jhZ+?=
 =?us-ascii?Q?h0ar2Anqx3GYdDCx9Vp36oOVo/CnoOPP1f73RlJxbm5b8zTuHW5VMSNyawIh?=
 =?us-ascii?Q?rpVR6qCFtxvUKhNKl5ST4vjrEHIZRSKNOfs9V8bBmMeOKdq3SXuFgmt1650C?=
 =?us-ascii?Q?28h3tOGFHrQmK4psD5qGVyjlBMEuMTpxLrar4zZlhdbHOfVgi2AAFxTu4WX2?=
 =?us-ascii?Q?wXTdaopTV1e14dQxPuSQk5HuQdn7jy5r9sPNRNKH8qrdcTKWMnvdQAC5meHw?=
 =?us-ascii?Q?p21Q587XwK7uXEuxqOiDzlBKxi1QahZgl0NX+kNv7SdsXKDO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f594f81-726c-4936-5547-08de47417372
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 01:19:17.1623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meBNZ2KV8XgFXbn78dDze0oZZYhs/zGr2WTdrCyJyoBQaYJ3s0Kgda1Lu1/vS2bv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831

On Thu, Dec 25, 2025 at 10:05:59PM +0100, Linus Heckemann wrote:
> It appears the code removed here was not in fact entirely dead; my 2024
> gpd win mini ("G1617-01", with a Ryzen 8840U) fails to suspend
> correctly, and I bisected the issue to this commit.

The only behavior change this patch had that could be relavent to a
Ryzen was in drivers/accel/amdxdna/aie2_pci.c - are you using this
driver?

Prior to this patch amdxdna would have failed to load in configs
without an iommu as iommu_dev_enable_feature() would have
failed. After this patch it will load successfully.

If so then that driver presmuably doesn't have working power
management in your system.

Jason

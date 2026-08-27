Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A9344239A
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832673; cv=fail; b=Frcn6ZJtOZnsea9ao9VfQM/peihpkQTt5Lve/MEGoZL/bS5m4X0vTYYAuhcus7Yq5LjRdEW+bftUIzLz/87/FCtY00OuBpofeqxj6DGOaWL7hMSaBp2c4QG+vgeTaMtnXgtWTGhRRdhYE+FJceIN5dHtEJmH7oDCZdtbTkB60gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832673; c=relaxed/simple;
	bh=deEPRo4GYZ0TyEr56GWr9mqhfm9lUTE0TFJx6ZTavl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AzwJWZ5YwLc8mNMrVhohcYGLfeX0QETvqEfXnyJ0k02AbtBxXYFQwxzp+RPzhceXEUc/Vzrg8bzRBioB1phNA6XLeT+uped3N2/v/OVshtsuXPkJmHmAJpDc+fGPXKUZOqZ1DinoB/eT8vZRS/68Grnlbrp/kKtUYAdA9KERTug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V7GD7rwb; arc=fail smtp.client-ip=52.101.43.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V7GD7rwb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmhRGRWP1rBrsyFJJ1drLUtJgUyNmJZFb9Sto/lVIHurIrNkWD5n79Rh0e4GugkgEpOvhZXQUmmgF2wADDVI/CPL/ezotdAKtN3ACI5oXm4Q6iDfDW9fZ1WCNnbSE+NS/YnEsrtst5gJ1WVa/NwPs+lRgcJnUjKhy8d3lKE2m35j4JHmZXMSak5aADVDTq+lIIhKZ9Ys3JGGSEDVoO8fC16pipexvlStsxpQklWb8idiklEgllPuJQ0PFAy8C91QgFkOlnkt9itQZydF/wGEGCCFr8YWnCqz1B1RH7HiHli1KPncXuhx1CpjFfi4wxxGoOfI57dtRiBGj1JR3AZjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deEPRo4GYZ0TyEr56GWr9mqhfm9lUTE0TFJx6ZTavl8=;
 b=PMbjQkY3A2rV32zd1dnrnSbLpiUl9nri4yxq7mmEUl/CQe0wcTP24OUfPKwqkKiaETgCx2MOJ+nXyRiTd0L6t5Grbo6X/Nxp62tyKAXg8V+qoUR3xiofv2kPkD45X8qfHPZcCrzqFMx3uGE1J43xbpJvAhPGR8HCKGD87lH7IKrpqjVHwzD1CcIdKkFSa32L7yiSv7gE09Oog+N9qi48rLF4jDhb8Cin9f73fIDmHNozQ6puVfkZzKBsN4eBaqm0aftkb55OFwnRbLfrM0Vfum4JeSdjaS6qezrztVnLQyjBKqKtnBxu9H5Ggg4HBiP+9QAj/+OsMoRQmDAqngEKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deEPRo4GYZ0TyEr56GWr9mqhfm9lUTE0TFJx6ZTavl8=;
 b=V7GD7rwbawqJNbfmmFteNjwJU4ArqGQNmQiLNBEUVEG7DNPCLApvBo74sQxsCcL03IeVEjvMNSvhqaZQ/I41cBYlgCOWb/AqfIAdwa8v2o8iM6iYrH1FbtFJnlYdN5pNPWC0nDXxiFwZgFdHAPlz8wSVcDfAnHUB11eYN+fLmKKe0aet6xMraG6+2gvEvNqZYHFImQYJuoozuGIC9J0o/rkYCv3BM2kpMEY0txG/6qNLxnpA0bvGsn1l4WtXOHdlVo3A/8R/FLlV12crSo3OfOF49kjf2ZcKSmSAoh6WvXeCpwK3EsSwHYuNHPPUdMiwzEe4rljQGKSko8DZwvPJxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 27 Aug
 2026 12:11:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 12:11:07 +0000
Date: Thu, 27 Aug 2026 09:11:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
	tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <20260827121105.GQ3325090@nvidia.com>
References: <3gdj54zcs5dncgom3zlntyredyuh2xe5ueg7nd4pdrcksmnwfl@k3fyky4h6556>
 <20260825140334.GA3325090@nvidia.com>
 <cxbneh42ui3gbkoqrsnoatxoec5exzbprfbgxcy4iekqmbceho@gouiwn5q5uzs>
 <20260825165209.GB3325090@nvidia.com>
 <iltwtfmgnmofsroo7eqrvjx6yhqbptwutywq65mgm7adudz7pq@2mdg3dhvtoud>
 <20260825175901.GE3325090@nvidia.com>
 <pzutriwhwe4whonj3veoo4hzxmq5tlmmyui5u6gt4bgl5wxxrg@qjsq2pvd7by3>
 <20260826163234.GN3325090@nvidia.com>
 <l3xyzbhqfremod6swwiks54znvoqy57hmqpsdlpcji5czjja4w@4qgiuwhwlie3>
 <lxrej2bonrvt5ew7e6wjupcaptj7nxpesnzwvktjusawg3od2u@v3zb2bdjdilo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lxrej2bonrvt5ew7e6wjupcaptj7nxpesnzwvktjusawg3od2u@v3zb2bdjdilo>
X-ClientProxiedBy: BN1PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:408:e0::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 832cb32b-7dd8-42c2-724f-08df043445f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|7416014|1800799024|4143699003|22082099003|56012099006|11063799006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	eF0hxMUFdILJPqHuFYuQTGpTLaOZXvpS9E5BqFViHqAlbTfNn18KdiYO93BU1p2x9s8mHw74LezjqlLZfPz4u0SaKS5Smce3EwxjSZDnxCOuAzi+b5d+h9JI4yyP608c5nZWWxeC803HaoNsfFRiOghKOrAz2FxOsbCIb6wXazx1GwDsgqK04qfHxu+DsyFTgEPtqJtrJjzcZYi+CwV4wlC56musSS2a9X7aRBM/M2m5ZJFlh7Jc6+bw37V56zeIW9GFub8xrCk82YHAkZ5SvVcd+hQitQGLJ01Hf3803H0Ta2kW/1i0OUDv9GBzP42nu7sm/Yl7bsRbSNV65nvy9Yv3oMMjWrhFRoJGu0OO1MYOicY9TMPp10g4CiiBUWTn1pihBILXwqwPtXesllo1562u/Y3gxluQ36BCZ59/4n8wVpjZpWuLmGttiSadWSCNMlDk6SKM6OE3c1/jsnNoHnQ2yejw8zpaMraFpuZ9pHV5YiQ+TDUAt6IoqxVCuxA8uVStHH1lKz4PzBlRKODGXXy58MYMq5fhyU7xJ7ELHiVlg4vyGDbs4qbbPCeGLS1WvxE2JELKGPCR2QgI1Hk9SeMzfTEReHWUHQ41xSPfCvgJSk4Rbeld1j4FTr1qiwVIAv9pNpDrMveGfMgvciGLwCeK7WQO2MY9Dw09h7YeV9k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(7416014)(1800799024)(4143699003)(22082099003)(56012099006)(11063799006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3mEFv3iZ995FLykcY20soRac4a40bXlYRoQPXkU8ZPkHMHHUV07KPR2L93+L?=
 =?us-ascii?Q?9DWXV6Dfinxp6UQ7SD0E9Z453TB8Hh66+XoHyQhU1KZleRX7Y2UoUwQk9yv/?=
 =?us-ascii?Q?8jv8pxEPye3eoA+puF8NcfyCVL1WWQMA7QHaGwr1ou43TEJuuixL4iYVxRY/?=
 =?us-ascii?Q?X8Lnl87Z28hwcDiDvDjVoKk9JK+mHBc7IQizXrdbnQH2XuoYcwoCT4Um6W0H?=
 =?us-ascii?Q?oLuYW1ncLdygo3X9kMVayE8zY8WJhwAnV0k/OEf1MBDkxd2f8EaWbGRvV/GW?=
 =?us-ascii?Q?pMpOCNuGYa3pY5bqJElH8+SV7pmUSZaRx8IqOYj7vQdRaKRSv4Ky6Ivwu3sx?=
 =?us-ascii?Q?PFmUttOi24hsZr5Eogo+RQblCBIub+4c9kNYRqF3izTRz44lR4jMPRSTNsG+?=
 =?us-ascii?Q?tNOu51sCyGKA5WTd0fOdyrPINH/Oae+SHUGB1IZB/z5MdnZc/l1DOJRTZTfN?=
 =?us-ascii?Q?YtI18wdohiPB23PN32vkkOv0N6tMJR4wnXHuxPV+yApjWGpnzj8W3MAiek7A?=
 =?us-ascii?Q?LZQadc9Toh7+cHQY1xxtLSle1bzwENfazuAqUrkPF/GtcNpPmWPG0rEdjkzy?=
 =?us-ascii?Q?N890YHIOpPpZT6ygGf1OLIatBK10LbWLg/2+WHp08yULuoEpzIgtKa1ZnyTp?=
 =?us-ascii?Q?5qGAqzzkoXN4KrqwZghv/wAZuThCO6xMzUVOeKSpbJ169OTqkeHAflEoe1qo?=
 =?us-ascii?Q?2KSiBUppS06Au5SSbf5uQwRzsf4rgJ9l0RS1oQ/Z78t4LcrMuTVrJM7o9AN6?=
 =?us-ascii?Q?3OyBo6mEHllSVZK41ctHiUnByeIUa5jynrAMU27P1cPd7ESsyZM1FBuq0FiJ?=
 =?us-ascii?Q?/K81fZlG/gvRLiFIB24zhhJ3V9fKThjq803f7dICbiArTQZW/clnBws/KhuZ?=
 =?us-ascii?Q?qe6vwUMAlajWNzy7KZh+WL0iIahkp6PRWw+Rvtai5RQryFjhgJAlMYKajtVr?=
 =?us-ascii?Q?EeaG725RaITnP8m100RlBHr8cYUsWxUSCpgOuJb6cwrWuzqdDnGaR5ak2dJZ?=
 =?us-ascii?Q?qc8zWtbdR5iPAyW4hGB3W7h0CUUvOef1HtC5vif8jtpbWVvYneXl0GpOxjMk?=
 =?us-ascii?Q?MHni143+V6tGI56stoT3gUjxlonXd2g1inA5REZIRNSWXNKAX4O4+aRHi91S?=
 =?us-ascii?Q?6XvOZeIA6PGUb50HcD8BW8+OhsHFWIDOowU+ATkfmH8vWib7TsIxJgG/c3P3?=
 =?us-ascii?Q?ijghvsfs1ebjSz6YEeg73IJPcuTQKbkcR+r4r2cBihwqKyT2c8x+3Wdy5ZL+?=
 =?us-ascii?Q?//HwEe98wvT9mi6NjxarrJnjg8Yjiz40MsHC5akoTlQmDvavkp9a3tXMaB3d?=
 =?us-ascii?Q?YFJsk84VA7NKRbycr+JEmMNP6A3ERnO31zCicdz39gZQgHrP+w+gNyC1iMVX?=
 =?us-ascii?Q?XaZUWTFC7i+54jj54RfysFrAE1D+bEXIS5UJYBc9IZMzho6NReqW81myh//Q?=
 =?us-ascii?Q?Wn7EyJGp6qqGY6kKTn1jtDLh91ONF1aE8+qIO6OZ9kcZ7yOxyGtDA9XZcUNU?=
 =?us-ascii?Q?gl1HElFncU3xdIYoK46oPpWdiwE+uo6OK3wrh764pk6jAbw7B+HinDU7XaVx?=
 =?us-ascii?Q?CMOov7+JZ94mC+tlrBFnScUnaEIyKwWxqqEHnH7ng9zP0dZxyO+vQAsTnVyF?=
 =?us-ascii?Q?x/6g51nUNnr5af6dJCf8GVzHyKWztqL/3eL1PkFkPGeAC3hVHUz/pz5HmFbH?=
 =?us-ascii?Q?zVSmajJ2HrVM+VC5POVRtYfY51BF+AGzky3FpqFbk8f9UXyL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832cb32b-7dd8-42c2-724f-08df043445f2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 12:11:07.0538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fEaHg99yQsB7nibzknwpjxv6FBXM40OwQMdSRTbsmOPlmYpYdHzaBE3WrEDy8AK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760

On Thu, Aug 27, 2026 at 10:47:47AM +0200, Andrew Jones wrote:

> I think it should be possible to follow AMD's model more closely. I'll
> create one IOMMU-owned irqdomain and install it as each device's MSI
> parent at probe time, provided the device currently uses the expected
> IMSIC MSI domain, which will be the IOMMU irqdomain's parent. The
> irqdomain will contain no per-device or MSI-table state and its callbacks
> can recover the device and operate on its currently attached S2 domain.
> This is better than the per-device irqdomain since sharing it avoids
> redundant domains.

I would still like to go over this with Thomas. It does feel more
logical to me that there would be one irqdomain per MSI table.

I dislike this implicit weak coupling between the iommufd viommu
operating the S2 and representing the VM and the irqdomain then
"magically" discovering what VM it is part of and what MSI table the
device is supposed to us.

I also don't want the iommu side to be managing msi tables. It would
be more reasonable for the generic viommu world to create irqdomains
per-VM...

Jason

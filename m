Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C71EEA49
	for <iommu@lists.linux.dev>; Fri,  2 Jan 2026 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379948; cv=fail; b=qkpBnXsuwQC2c+BYYW5bbaOzOnYOZM8C09wmT7fuyXRzdiMk0Z7WOwc2hGcfMPUJpdmX0sQucZsqb70P3Qpsp1d/mZYU0G9j+XtVZnZqqI88aW2eCY64VCNe6BJrRNAFMOe7TtD5Afn2qgNmcvfCNH2tBQLtQgldfjCB+fjBUfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379948; c=relaxed/simple;
	bh=rsz39IMKdQBTGWuXXr+O+cLEfb99+yGuoZnb86xkSCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=giikqZT7Felcd41G6Mbryw4eWWjXMwoI2iZKobmmsp7OaHYVa55lnI3HFoAA5T1Z+11UpJiD9ys5jLSitpFyIZK1Pue/Asf36pzcYmcq5kLP2vtgFwDPuqiql09dyRy+nGvP2RcXLfHLBB5zox8DC/+6XAcL2Omzzx89rxi718A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=elQFu/4I; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="elQFu/4I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1Z4v+ULSmh0de2BGiKxQu8LzedLQbNeKx0b3+1yD8fg/T7giA4X9gB17+lc5vLUMAKMEfTY8ljlaynNUN3LiFFfXxcRWnCOFHp6TGe2YSFLyREgbIGGd13LGMG1COKZVOXdbsCwfuNv5aO6uDios79NI59ESDn+4WITbXSE8g0UgIre56H9rBFWX+OKITakQtORFxHtR7eF0Q1S0aedVbfdK/30Y98Hv3GQXBQ1fc4g0PEJdN70Bt2uUKXIuoa279JBvBiKm/Lffc3dK+rOAPnkxtfCKvdi/heMEkLwnAm4u4vHpCq/n4VVJZQ9YUr3XLoEhSUY78Bt+ZmQCJZsIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsz39IMKdQBTGWuXXr+O+cLEfb99+yGuoZnb86xkSCk=;
 b=PSbz8Achd0n5kARUYQ2/+gwi0h1z0aJB6kMOM1AI47Mqn8ItnRoj4AOUCPyBO4Uyht4uyaweUggG1XY7EtgMaK7QfG4szEhO4EBm0y1oXfiwH8KmDN47eQUO1oK8VEVpof2rCNnIfZAsJf/HErOY7S7gPMjF9O6u/7eRQkPOR57HlHpfhCXMvhWPqkLDalZjeVy+XNJNc4ix5W3IkiywxRbUyhzqrSRkkX0wZ4qzP5nwUe6pPtjabzNU4+jIx0x0XXkPCMsJJEYHGGyayQVG414BhcifKsTa3Qt/1gjqC90Fw0SLU+1dfCPX63uh0E+OpYbQFpsAEDRlZSu91oFUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsz39IMKdQBTGWuXXr+O+cLEfb99+yGuoZnb86xkSCk=;
 b=elQFu/4Ix790jodiOkEbXhH7d4GLn5X4xxyhR5geeetQhUIppopstRuSx5euWL/onDED/AcqWjnfkJMPLszE7TZHEvIAs65o54ywOo3OGNcOGUAwEYyqumNhviiPsrAvWkbnGlBGjEHJeRQOeFwmdXPqyiR8v+wpU6aPsZaf7p3z82bquSa0h7bEmpRmExLe9JDwOP+lM3T+X+kZcW0WL1o93K/Z6gAa5+CmbfN5BRI0L/7rHSflrfMJHqb23SIdBwF2B7TEeTx5J7CE+QcflzbvvRrBqMISxEpGszDICTFL0HgDfuX7G0udyeQUyaTRuMkzYrLYHFpB8KxTk6qrtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 18:51:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 18:51:10 +0000
Date: Fri, 2 Jan 2026 14:51:08 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>, Sairaj Kodilkar <sarunkod@amd.com>,
	suravee.suthikulpanit@amd.com
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v4 3/4] iommu/arm-smmu-v3: Mark STE EATS safe when
 computing the update sequence
Message-ID: <20260102185108.GD125162@nvidia.com>
References: <cover.1765945258.git.nicolinc@nvidia.com>
 <adf08c3b9f289188aca4fe80e506dca7aa48aa19.1765945258.git.nicolinc@nvidia.com>
 <aUQvAKjVUT1L3N7j@google.com>
 <aUQ6u+s8YbPiLC8Z@Asurada-Nvidia>
 <20251218180129.GA254720@nvidia.com>
 <aVgM9ZNOmK6MdaNa@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVgM9ZNOmK6MdaNa@google.com>
X-ClientProxiedBy: MN0P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 136c924f-783b-4122-3e8f-08de4a2fe51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EdzW7UcxNm3ks5Ipsj1XRCUBngpQBXxUFoR1ted5P527Qknam7CeEdyN7+pQ?=
 =?us-ascii?Q?N94Aijwx8wRU8o2b9lbnmZAHRwJWsP4+OTvM5pX0kHVpL4uFabMyqhHTdy8Q?=
 =?us-ascii?Q?imKQrF2Trme1acwqlivscryMYnIi1LS4GUwhcc4u/3zki73KeCkbH16t+nSn?=
 =?us-ascii?Q?6SPABKdPTaeviuy3tY1gbMLSPPJlM4IPVYi5XcHerHMBv5ust70QUwo+QQRK?=
 =?us-ascii?Q?vhGkXApvqpFRPeR+UqVE+dqzf89YZ0AQxItwDioGCSVIE23iZz0PDSABB6e6?=
 =?us-ascii?Q?U2Saeko6Rv4cNNXzskicvLu54iXn7tnXIW5RPNbdlVk8h651MzCGpHC1M3e5?=
 =?us-ascii?Q?rsOZTRrPRxjReWe5D3EvKRqQ00kSaNSbwmlh0SiXGvOA1m7rQTvWw+V6j+dD?=
 =?us-ascii?Q?+2NYvz6BNV4ItFbgQ+R4t0c9NBxNwMlOtfPzR6OugycoUeoeTM8IzoEPTAOd?=
 =?us-ascii?Q?2+SoNwUIdoDin36GQvzG5ugl0qzjQHVWMnoqN3m2EiBc4Y9pC1MiFPr5v6DC?=
 =?us-ascii?Q?48q2pl/7ZiHxLr6b0ahdjWvJcr2j1jHMhl1UZ0Njg5lRP6xaQkyAs0L7RemL?=
 =?us-ascii?Q?Yw4/YoXD27Scw7GHfoOG2wVpmYCPnfSROsR2l5o4dVjlyX72yVhlK+yU0AEv?=
 =?us-ascii?Q?IP8CefV6ena+QuIYGbUqxVcQ4yY/2dTXPFtk8l29uB5DDmNy8zYid+skEzDP?=
 =?us-ascii?Q?VbYrwOpwU12KZan3CBWAgIiiMh+1fHrBCzw/3lzitw2JnkqjBM8Mme4P6GIG?=
 =?us-ascii?Q?n13Lou5gjzogcHJzCfvOho/bH92aZ+sJ2Tik6oR77VbP4BE6gizj4hIhpJgU?=
 =?us-ascii?Q?YkeRofJLTCuWeEwursthbgMvhAgLd/Ex5o5I0pSBgpQRQ2mUUt7QIxkGNf/U?=
 =?us-ascii?Q?33mAcJrZqccc3QIbObE12koEtxHCMzYT379ydQp4ZI5WA1mLDzXO5Fgcss5v?=
 =?us-ascii?Q?XXf62UiIQqsf13Jxc4eG6YHoxroYU/qAljTaBGzgt8IvXIJoTmWz1kiOsp/6?=
 =?us-ascii?Q?ZrisXwevEPsjZC3T5sxBtAuVSRz77lFKlARPTSReJsxX8p/i6sg0jB4qiOsN?=
 =?us-ascii?Q?8dU+D5snvfdFZ5AMveTZ9VYaXtX6eMHShh00jIqJq+3lBrz9Ox4Zh1LpLVbc?=
 =?us-ascii?Q?rlJK20Jg1oPWY0/G/T/cRFH+Dxj9ROscxHnmQ3Imas38LPMrWbJrKgRUmp40?=
 =?us-ascii?Q?c8zO7eZr30PD1y9Ntz0GpuSy5gyasDaXpLFnNJD5TnpoHrlGb0CMqrV0mhe1?=
 =?us-ascii?Q?HeVJBDqSJIAYtZVIa1j1/A8VgFxEg4mvOAWWIeQ1X5dlQMbfIk9w9QyqCEk9?=
 =?us-ascii?Q?u+9d0Mavw63RAdUYgcHAatWVo4MYmbXQscyXVPtEiriEvo7JRQQ2sLVNYJPP?=
 =?us-ascii?Q?OJwZOunIPMTYwhjBtiNk3c6qVM9O3wGJ51yxkHHCq17dGJMRiA0uJwgz5Eql?=
 =?us-ascii?Q?yW5eHP6DqlLUgvok9o+wFsYcB88FRdsR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8yqLbBaVLzzb8gl07ZVFFL5W72EJjfsFovmGpPcZBh2DUrmtgRJrRYNj8f6D?=
 =?us-ascii?Q?xIOPtNWJWf6f5N0J3q1x2FSjedz/q7dRo5ZbRg3CUsIoWR1BToIMKkhfJhCL?=
 =?us-ascii?Q?GJtVjy0hu8dhAhd7DUmbN1sv3T1hFp/g7F8+/H1CoWDeAfuOST5BmI0FI8A+?=
 =?us-ascii?Q?CJ6YzFtrtePcZVVT2NeKy3UCs4ffN0Lx9k7yJfsi19lnl51S8GohV/4trT1E?=
 =?us-ascii?Q?ts3ufh3aXs0jnsMcUwemRmD6r3b6FpFp3B6NQ7O+YLPRYKaeyD2wCywrLehq?=
 =?us-ascii?Q?hUfJDBKx5bTXur6nLrVOE0ODMByCMExOBgklNv/pbJ/HkcUQiNKN5pWBPA1D?=
 =?us-ascii?Q?ZrtSUS+n5n+DRDxn7eMOZ50eZ+Dp3CaqZcBMj6z5VMtinWnYIaHwkoPVj6yD?=
 =?us-ascii?Q?GrS0TbTDxGW9JrPlYP2pv6aycJiMyM1jD9SHaeoANpqoSRTha1V9G8UohxVn?=
 =?us-ascii?Q?99NBQGqf3ueYmYlazGC9DG0Fwh/xZGPpb70Ke1hHoKCU6MZIPMlLRFj9AEo3?=
 =?us-ascii?Q?NMum/YKQ/lMwOukCqZhsmxGeYYectU15FbsL8oMIcbpzOYsVqbWDDmhl9wgC?=
 =?us-ascii?Q?rKkN971HpyRppEGjz5vY+e2m5djLUz42qoz+/gM7fXC1QlZV2d4eC8gFAYUc?=
 =?us-ascii?Q?iUSjnTMko6FReR4ZXTzV/dhsQmWnj5mXPbD40Bds9y8qvwW/ZSO2J5XycWxN?=
 =?us-ascii?Q?FHDVJ526fAGCHZJWnXma+SOGKUWVCtAg/GEsqyy+0gpkIvtk2T3d219MArLo?=
 =?us-ascii?Q?WoXlvJP4kifHYD37ITwdGmvtIZy4T/6i2s9jZ/TQLnGCqh0eSkYelFELrzsV?=
 =?us-ascii?Q?6NbUR4SAIxB4kKOipn+nTZE1+RF9BskR+3+YDf+r6NpdbOHjAn1+6pqG9Hl/?=
 =?us-ascii?Q?bChFcB65BpBbxmhThgtSOsh3KmHBi1538gpPI8j6YonMsAgF3pU8lFvggzlQ?=
 =?us-ascii?Q?9OJ3cWo2VyHl+nULWrc9UZIRcYjETLSvbJjLFqTGrP96rQUUK49w5k3f3keL?=
 =?us-ascii?Q?gdR3r7x90fOAYG1hMvllMHzGXv3CD7d/CwT/kX/DESsDWy1GL5Uj0ccaCws6?=
 =?us-ascii?Q?/lgBVDMi2ELUcIDA45QQHpGNyGrNbF+0t0PPfyWOP+pz6gSQdGKRuHyQDDo0?=
 =?us-ascii?Q?QvDk9y8w4bqeDV8Ta393mm4JnhBfSIkpzqmTkikOBXJmww/U3t6PEBMy30/0?=
 =?us-ascii?Q?qu+SD4k7tyHkYBC8FREHNDLoQT1lN7WtVU0KAilokixrUCAKrR3J2RqJjQBP?=
 =?us-ascii?Q?T99YN7/Nk4cLfXvYsDk1y8bEP2k4Q6pSywRnTfoskRJaeD9X9wFejUHfYNsS?=
 =?us-ascii?Q?XttRWodweDfhQWvaziE9GldlrEOx4lc669gltBBdEQtJYajDbzjkPvDQsUY0?=
 =?us-ascii?Q?I4ooZj2/aK7v1myJCss5S7gKSMLYzE/1ScXZ+JTvZbBxVm/EbpHmg1ZksGXh?=
 =?us-ascii?Q?cMtTOn6uWHmt68E5Z1i+J0y4CpGPwI2xhsEs800gTT+6SCzCnGvj2dMPsus5?=
 =?us-ascii?Q?q5+nxxpRKEJ5ZvrmD8xFJzC99ZH3s9TaUFnmkWpAsWzg3HERQBvcX47A9Qlv?=
 =?us-ascii?Q?nDd/mzTKzXdx5f39UjaF4uQM9Oh8MtZiqQGuvrBl7dbFJ4UZkd9rPgyUviDT?=
 =?us-ascii?Q?mVnAAraz4QO7z88frV+4ueKbkPpC0bH2OUdZjly7SAB6GlrALD+9WHFw+E6G?=
 =?us-ascii?Q?/tFKzeXROY7jYe69ZnQ0Q1T33+i+ubDgCZGBi4bNJXaQrhGhXrqYQKfnjplB?=
 =?us-ascii?Q?l+TE9VuhUg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136c924f-783b-4122-3e8f-08de4a2fe51d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 18:51:10.2468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Byw/XbEqBdg11/ek6HpsSHbQ9mfRuuUwQGo2cW6Nzfs66m0j4vsH6yRRtDImNp8t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055

On Fri, Jan 02, 2026 at 06:22:45PM +0000, Mostafa Saleh wrote:

> Looking at the code in arm-smmu-v3-iommufd and iommufd/device.c, it
> seems ATS enable will only change at attach.
> Looking into arm_smmu_attach_commit(), I see the ATC is invalidated
> after the STE is installed, which means that userspace can transiently
> observe the old domain ATC. I think that's fine at the moment because
> when binding to a VFIO driver, it will attach to an empty domain.

Yeah, it is a bit confusing..

The PCI ATS flag in the config space must exclusively be controlled by
the IOMMU driver. We must not allow the PCI device to turn on ATS
while the IOMMU driver is not synchronized and able to issue flushes,
otherwise we can have cache inconsistencies.

This goes both ways, we can't allow the hypervisor to turn on ATS
unless the VM is aware and is issuing flushes for its S1, and we can't
have the VM turn on ATS unless the hypervisor is aware and issuing
flushes for its S2.

Thus, for a VM the vPCI config space for ATS is ignored by HW, and the
VM controls ATS ONLY through the vSTE EATS bit.

Only once the VM enables EATS do we get to turn on the PCI config
space ATS.

All the detail I explains before holds because all the ATS switching
logic in the drvier is designed to ensure no invalidations are lost,
regardless of what two domains are being switched between. At worst
you get a transient moment during switching when the ATC hold a page
that is either new/old domain - but that is resolved before the domain
switch completes.

AMD folks, this whole explanation in this thread applies to the AMD
driver too, it currently has wrong ATS for virtualization, and fixing
it means make it work like ARM.. It will need to be fixed to complete
the VIOMMU work.

Jason

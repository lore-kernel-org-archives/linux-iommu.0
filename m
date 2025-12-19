Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677B7355816
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766170227; cv=fail; b=HnRGN5TV9zGdMNPLYxYf5LtJK1FGXSeKoezawDiwnUHFZuJLIrIeVOFy0shUq19FK3kLppCePtbt10coBM5xmaH25p2JUbJ1wBFgLe0kX1veU/rR8H92lyLYGMhN+jb8dySEebWPWKD7gmuKowk786r3RY8aTftGSVcglBlr7Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766170227; c=relaxed/simple;
	bh=cXO8VTDvTlSyLihzGnYsT/8UukD2AEVWobqpp7mb9uE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEAXbbgAekNZSEvYpygA49/XbxWghMeKyKEaBNWuSoNC2UXSHe7Sa/QJQwHgR+uVZGc5srJKLiCwIjMfAQI8Nd3CfadumVx2MIDuXy/rZ9e7BjVbq+FAhxJYlaN6ldJFJvv/lM4AETYWjqrjx1LzpOIcKks/C6KNpBCGZfsUr3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ImlWEykj reason="signature verification failed"; arc=fail smtp.client-ip=52.101.52.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ImlWEykj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drF1VNSQEsNUktcw7u44hzv7WK0NXQfMiz6p4EAzGMGpwstkgNm8PFllV8PpdUIBjE6BtUkTkD+wGS3jrNCR/NCBs9SzZGPo4TAX3fqNbZtBoKdY6fbr1wXbV4vSQWqJjnLT0yW1TnWZkRuGG+QJN+Ql1Uyin421luNFiM/9CJ8dFv5RilFDVkNH+NrWeYhdhNDpO+Cl0bF/ERBmK9zwvQBYWM7lu3gOv1PBvT2bubToJMYlz1RvQ9tXPvEvGIx6ZrF+TqtwbIcX4GqkuRzUVvOpfTZQyHLAT1BolIIoUn+faoJp6VdudVz5Tzoexfl1F09ojjRkXTbYGQIvTghCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91FGNp3BQopsv2twqGGMk8LEy2XRbaF5ubVXbcPtntk=;
 b=A7d1jy9whdRr69wmF4u53T5vLeEHLFiFP11XC1xX1c3XOOZu7SuNOZTqKbOL3mu+zS59eyyHUXo5UgtDYIsk8cWgLWSLQMkjstVyTaa5Cvrn59XQAQfU4GyROl/tWcZqZZ36bofWa2VNNheQ2Xuk42g7IfFv6s2RSulFzQGUjrfI9y8GNcubOZS/4B3JF5tSv/hWwZB7RMs8pXNE2q1NY3p9IMiAUfx84IxKT/AswSkSHfp9v4o0TAPIabbye3JTZ7cOwZAOP5+xI8znRDXqMtofXgtmHgtLtns8TB1a3c3RE6b16ZlQIpU1/T2IJi3ZZI9l5wMj+mbhZ68X4WEmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91FGNp3BQopsv2twqGGMk8LEy2XRbaF5ubVXbcPtntk=;
 b=ImlWEykjizKghc7mjLzL/63NCw5u2uEQNMlXE9iHgSelpagXMU6VmwP5AXUJVagw+VpGSQOICBiiqvsm7NOpotItUp4usvbZQVm4xrh9DIDbgywB3GwvtU/PDMPb6h9NNpVVO4WnLLCyPPHT32amz9AsUwKq3orHriML5p3AzJLF5SuF5y+nGBpYjRoHvCKMT0I5DOfC8lPNUzSjeFbSNRMHtRSr9CColmtN8b67Q2ZTHWfUOuMTdPue94IB38WMQFgXsDP0wMSSPdu7NGbJcVgmPLTllX0tpYd9wUy62ov4AJzvScI89H8rLeBV1R/+P6jZTxIMGwkJkeANbIC6xg==
Received: from MW4PR02CA0002.namprd02.prod.outlook.com (2603:10b6:303:16d::10)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 18:50:18 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::f4) by MW4PR02CA0002.outlook.office365.com
 (2603:10b6:303:16d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Fri,
 19 Dec 2025 18:50:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 18:50:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Dec
 2025 10:49:56 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 19 Dec 2025 10:49:55 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 19 Dec 2025 10:49:55 -0800
Date: Fri, 19 Dec 2025 10:49:53 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>
CC: Ashish Mhetre <amhetre@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH V7 2/4] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
Message-ID: <aUWeUapsFo3KZP7i@Asurada-Nvidia>
References: <20251215064819.3345361-1-amhetre@nvidia.com>
 <20251215064819.3345361-3-amhetre@nvidia.com>
 <23df682e-6d08-4827-994e-1bbd89e5c903@nvidia.com>
 <5e9a0ce1-a0ba-4a31-be95-99f349ec6028@nvidia.com>
 <e7d3e95f-a885-4b13-ab4d-bc82793c5396@nvidia.com>
 <aUROk0jRQoLmBRo3@Asurada-Nvidia>
 <b2df8ce6-d336-457a-8169-f2eccec3c12e@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2df8ce6-d336-457a-8169-f2eccec3c12e@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 82aaa629-a950-4931-6e42-08de3f2f7485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?hBw2HooVbl1lXS1v9WD40EPDANOT6I36SC+fNQtVhcNR/QJ4n4Q7TcLlQO?=
 =?iso-8859-1?Q?LD+LT58AQMfRvUqwHOaOje4L6gQKNZoa8l6U6/XMrE+z1DQskgkFNlymsj?=
 =?iso-8859-1?Q?JvFqXeLSUzDAZNfsgT38vwOmGv+4hn0QjZ48gUQUd5JEQBBYC5Y53Ne9LC?=
 =?iso-8859-1?Q?vFInoJKh47k5lrk79hSn7EQrytWQ8f234xWEp1j+gsMr8FUNgqruwuuQ31?=
 =?iso-8859-1?Q?mzVb51D47XFVhfT6PLzcAxV/p2HVA+tat5RabsYcXMEqLA1DMEtUWV5dCS?=
 =?iso-8859-1?Q?cSzvHgstFYUrfakFK4cRVZOISH+3oTWJ1cp1QCp6AonrFHNQQGSQnbG6Qf?=
 =?iso-8859-1?Q?/1JQ5Zp3MLNUkAVR0w/B19VXndnA1Gex1emMI3HXGL7wZxegVmSLzU+K1E?=
 =?iso-8859-1?Q?sbgeSvCQl2TrIsuX5GLSrukGr9qn+YrMM+Key/cYYvOSXz6VjpVBZx3NmP?=
 =?iso-8859-1?Q?HbVotvsj+DlmlEa552Ifr9JIL4QvfulGniwHPQecpqgKQK5OxFy/JvJPP8?=
 =?iso-8859-1?Q?08qKz8KEjP0ST5zgCBJExIh8ra/74oj6+t3avMwo6+C0ZtoEgGMGea0tAl?=
 =?iso-8859-1?Q?i5K1mpPGPpBmEvcTSwHp4bBGadzf0palX0R+zLdCq+cI+fSpP/SWxu73HI?=
 =?iso-8859-1?Q?kPmUwXVgASQY46YF7zKUXI9KVPHAFaOo0Onqh5dHvnvkDAncCYhtGeXg5f?=
 =?iso-8859-1?Q?V8ZaMGVXc3dtsSYv2BOzv5ioU9QPZuiF87X7yT+5IqkNeOlK8xoa7tshsk?=
 =?iso-8859-1?Q?tRfXhS5Q+icJZ8XFpzSPx14ZJgHAQA7kb6l1LVZ2YnB3oLz2YimGsSWwfR?=
 =?iso-8859-1?Q?tdvJnFDx4yXb9j8lVmdaFYHjgREMJxRfvZDpqg7b9Q1qaiX2wnVx98Xgji?=
 =?iso-8859-1?Q?OP+s1eqjubNBRS8h0M2oD8fu05Ylpc+W+gh3PJKgxWAHntRPK63GQdSQyX?=
 =?iso-8859-1?Q?6bUHjnVIYETa5YYNaY3+gOdopNMBeUIZJ2R/SyBXKsPLv+vnGWwUjaXNHj?=
 =?iso-8859-1?Q?VdUkqzqDkJwb+Z65ShhlaPhVrho7qlbLRT6FwOM8ALmWqyVSwHdBTiqmW1?=
 =?iso-8859-1?Q?b5HMThTLhK3EK5yJPWUY9kLAAXLEnALfO1/1BhUGSolGW7r8tfKwA9hgW4?=
 =?iso-8859-1?Q?82bIMFlOkoy3UGd3KhhlJHxDeLUHy5GnC+mozb8j2tlmD8Bw6/zhQa/zrT?=
 =?iso-8859-1?Q?NPK6OHwyVSBQ4AAcJB6l2laS0cgB8cYGJGIG6zYJaRbTbGiBxwTWXjZUJ9?=
 =?iso-8859-1?Q?eT7QVh/voDZvYWX+fGvMw44xSktSHUlu1ynJBVWIE0HCqB9hp6TuWKFrKo?=
 =?iso-8859-1?Q?lpk4PUENZlLu6h6Tg+IPy09PPMnhUXEYgJWu3QAKEcEntoIaYt2pVhwaIF?=
 =?iso-8859-1?Q?oKN0IPaSRfq/5OI/pdvIsOoEKlfnG+hbNgV+jRqGrnEvM+C5CysebLwU0R?=
 =?iso-8859-1?Q?h+qap97JjT5biHDHkYhM2Hr9yZ8eXX0kFyOCl2RAJqFI7IaQVelL0nS3ZU?=
 =?iso-8859-1?Q?xSjKuxvxwJATJl26Wa3OyGuV3QP8hw6ZoawWRw+BI/vNpYZjitgzI3ic7P?=
 =?iso-8859-1?Q?5mk19i1b/VwYGglHOfjPiLTqUoKtP/U8aMo4U8Tp3D7JLiErp51GmpvRbf?=
 =?iso-8859-1?Q?N3fBg1kL1EVag=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 18:50:18.2046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82aaa629-a950-4931-6e42-08de3f2f7485
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421

On Fri, Dec 19, 2025 at 10:48:22AM +0000, Jon Hunter wrote:
> On 18/12/2025 18:57, Nicolin Chen wrote:
> > On Thu, Dec 18, 2025 at 08:48:32AM +0000, Jon Hunter wrote:
> > > On 18/12/2025 06:32, Ashish Mhetre wrote:
> > > > On 12/18/2025 2:13 AM, Jon Hunter wrote:
> > > > > > +    smmu->impl_dev = &pdev->dev;
> > > > > > +    smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
> > > > > > +    dev_info(smmu->dev, "found companion CMDQV device: %s\n",
> > > > > > +         dev_name(smmu->impl_dev));
> > > > > 
> > > > > This seems a bit noisy. dev_dbg?
> > > > > 
> > > > 
> > > > This info print is similar to what is there in ACPI path as well.
> > > > It's only a single print per SMMU at boot time. Should I still change
> > > > it to dev_dbg?
> > > 
> > > Yes, I would.
> > 
> > It's really not that bad IMHO, I am not against that though..
> > 
> > If we have to change that, we'd need another patch changing the
> > one in the ACPI path as well to keep things aligned.
> 
> Regardless of what is already present, does not mean we need add more prints
> to just say everything is OK.

This is how it looks like for each instance probe():

[    2.709269] arm-smmu-v3 arm-smmu-v3.10.auto: found companion CMDQV device: NVDA200C:00
[    2.709273] arm-smmu-v3 arm-smmu-v3.10.auto: option mask 0x10
[    2.709618] arm-smmu-v3 arm-smmu-v3.10.auto: ias 48-bit, oas 48-bit (features 0x001e1fbf)
[    2.716236] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 entries for cmdq
[    2.719432] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 entries for evtq
[    2.725898] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 entries for priq
[    2.736051] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 entries for vcmdq0
[    2.742553] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 entries for vcmdq1
[    2.742586] arm-smmu-v3 arm-smmu-v3.10.auto: msi_domain absent - falling back to wired irqs
[    2.742759] arm-smmu-v3 arm-smmu-v3.10.auto: no priq irq - PRI will be broken

On a second thought: The CMDQV device has a very unclear naming in
ACPI path: "NVDA200C:00". So, printing it gives us a hint for any
later warning/error tagged with "NVDA200C:00".

Now, for DT, it might be okay to not print it. But making the two
paths asymmetric feels odd. So, is it really worth nitpicking here
given that each SMMU already prints quite a few lines on probe()?

Nicolin

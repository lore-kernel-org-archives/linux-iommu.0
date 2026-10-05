Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A137E5D1
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187025; cv=fail; b=WgvslLZuyCH6hfE62j49rcWuRyxi39mP/QG2rcNId7qhrVno5trR87PqPJzOJfCGLgrnMQ5YfevFbMPP+eN5RToQRM1qsLJGuEHaT8Wm3YPb9sKqEJRMj90OPGxLFUa2nqk3FBKxefjqRNDcFmrLxjKVgNSdf5FqhQanxswq0U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187025; c=relaxed/simple;
	bh=lpiTOk4fFsQqRJWAJiHIDf9qUNCJyQZw1PUcOKl2nhY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpeH2fjs3Vh9JXKdYTyDoFFxaIBrHfCYZHKOpKKpv76Di0JV6ytMcZ0jA8p5Z6VlMwSS2c7Yb8uE/zdCxydb2MaWfOFM4JbJRauMMlcZaktow0sdGgrKV7+jMhy7Q2D0fneJOZPOlG8qCVrTFf6j4CS1FPd8Ba47YEF0QlLv5sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GDFJ6GZ+; arc=fail smtp.client-ip=40.93.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GDFJ6GZ+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUjGznyiuMfZG4sK5EmCKGlc0dv7gw40jBVZSZ/Rk8OwrWiAP29xr0O/kf34BtFX977TmTP6p0eYT3TRS1FhIhFZ6/ZNEYUqy8tNGqXCQ1nMYGIgrkvr3M+HdmGp8s6ba/QPr8vVxIqmCFiU4eeCX1fu2QhGW6aQlKRRdt1L46X2ZU+sEUPf5LNeIWIx7utPDikuV9xro5tNBWPAS8PDehfbNGGIJPGirBQieM89xbJ2RipGU8abpmAhHT/4fuF6qAKsnasX6WuWQxKbaSQHvulIgQMk56wUQ4rO5xY8dE3U8yP+TsOmWPDwfAL4XQ5/tXWIwJOXLL1gs7JcOWOYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAVQMT6mdhsNRSuRByO+cLEzQhlwcOKja0nvC5l/Hb4=;
 b=j2fqJOesR1cZBBC5q/XCY390pT9m11EtEP6GTe15Wz+yLTX/9+1pyhLsqM1+1mUFGKxFg6QA/4xFrDzFXXRNRm6iX6bwxXWQ+biIxu6KEoH7OjJCHNYGBZqci/+ub5jfFiuXAJFqGeLSWpwczqUUJoEeOEMuyyjpVR6YGU2gjPcjlKa8YKwnJ1vIFiMhchoMRM5bLydT+V9T6y+qvnF7/Jy19rnk1+5lsLh669PUY1BtLI9h765InBqIssIAj9N3iTwGGeoKSByq2CgQsov8pfEDMse8jjmsToepKg6ZmEYZVT8fVKrik9Q3DjXzWg67ijcoZOh1FbFOpN54A6IKXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAVQMT6mdhsNRSuRByO+cLEzQhlwcOKja0nvC5l/Hb4=;
 b=GDFJ6GZ+6En6UUsvN8Mkx9kZhAPOUxM1SPG0MPm/nTfixcbrT6Ilp4S6ldjdPOyDnzAKI1YZ2cryqzKCWN5aGSdtNR3W2Rcp6bitEI1f0khiCf/y6VqF9hYSrD6JUGyqagHcS2P2EgwO9F8b9OWdpsTfKXgLwVMuSGwXllVbWIBIQjjttpM8ZVUZaJoT+zU4i/J3VnQF2GRno3TbsAvkCe9Zmfh3mV6+eAo1WzfO9yzNMPtqLN6IokruR3Ifu85XXiEMQSmu0hUmfuVA6Ta4tH6Di/R2GFbZE6CmJuHRrKQ2qzXnprOUraGIXayHTSzqnOWkcQ+mrANiWYRTNbIeRg==
Received: from PH7P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::11)
 by SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 07:56:59 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::a0) by PH7P220CA0024.outlook.office365.com
 (2603:10b6:510:326::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Mon, 5
 Oct 2026 07:56:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 07:56:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 00:56:37 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 00:56:37 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 00:56:36 -0700
Date: Mon, 5 Oct 2026 00:56:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>
Subject: Re: [PATCH v10 06/13] iommu/arm-smmu-v3: Add
 ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Message-ID: <asNYMpZfyMHakuZ6@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <d661395d986d3aa78af200f55e43740996ee8a0f.1788130528.git.nicolinc@nvidia.com>
 <asJTsw-oWDlSqNa3@willie-the-truck>
 <asK7VILK4CgEFjdT@nvidia.com>
 <asNEmjxZ73ezL4I3@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <asNEmjxZ73ezL4I3@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c6e39a-2e6a-44fd-0cfa-08df22b63b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	meNuGWJPZwkFhs4VQJegb5s3BgbHhOy9Pt7cATVmFPSuNtFEcGn2h4hrnkA7Zc9YfDynK1ELPefMfcPdeP6XdyFWRJdF7nl65J8NJ03szoWT4mc6azoGaCG1QmBeHslHJaCUBgrcx1C/T0pV7MM7UwTzpJggKc/QkexVCasW2u8ehUNJiP0xmUdyBdW1zMCAjgb/TWqG3gAPVakGbinRmoptluRIDAEiNKLDdbUit4gneNJKpOm3gpNbfzrua55SlPjr8CW08tvfMtzQuepiAjNKG6OUBO1c5bc5Co+eHgJGLYPCwQXUtWxuswqE2R9IIptPjX2nqsTw2EplU6kvMp5Y2IX7cnlfmvp0N3oUqjK4E4HsXWxTytsc1+kIbmvn4EcYhpNAGimU8apEQ50u3TfXSiO2/cvkol69hGvOa/zAsMeChT0t9ss8DOojPpk5ieYm5uTWXLPII0EPt3mo3nfNJXf9dTzyBw0fqx0Bvyv1HxsHw/dB+Ikb0rqtruJCsZQccj2EGnfwUhhJ/yvagO+SVJ0r4vqhDBueNHpKHK//x8WT9C+KzUIrlzSRvuMjC5AP0Pq7PT3cKGCT5fQIj3Fc+DFuU2o146Ri9HdCuGbobgRUPxgu7XO1iKS8fyDnxIRx8zJhPisByuZMaM9L7iOWdNjrXcnEdkzuRNSCtwhqPR8kXuO3eNzwreNdUqp7Wp6h3QpendE2FCiMSU+afg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vfXX90Z6IzULzgLbwjyUpxCXsgykg9rhk6mDmgzZxjhC8GWilxkber58WdLtNu6TSvKnq6juJzs6Yb45uot6FzCr+xB+rfvUFncXC7ig1XrskqQCMXqbO0IULdJlTkl5PdyHDipCyMT3OmIg2g/J/PmWiOFX7UnVmfcDJJ3qrPrMn3nkgRnRhHGIOdCcnd6ZF3yPfuGF/UtYK+WA4fFwN+YlbPkMgfG9cR7GryK8i5Izt6a5R8t2whhznLZObyqYQ+caSqY4f6MhqL41zf/fhmyaKfXHgKq4Px8sVQy+ymiZch2q5xSAhJ2YKLEBqv7Ml0ShwTNrSZe1pSdOOsjKNYUU8RCaKKK/62RPGxOY1HvzkvgWpYNTiCx+XAmKzt4jV3pV57sRzKDoY3InfzTtfZM2WIu+lK0Cl3v8Pd5n0hJEzWBQK1X04pTEn5Q8N3yJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 07:56:58.9100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c6e39a-2e6a-44fd-0cfa-08df22b63b9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179

On Mon, Oct 05, 2026 at 07:32:58AM +0100, Will Deacon wrote:
> On Sun, Oct 04, 2026 at 01:47:16PM -0700, Nicolin Chen wrote:
> > On Sun, Oct 04, 2026 at 02:25:07PM +0100, Will Deacon wrote:
> > > On Sun, Aug 30, 2026 at 04:18:07PM -0700, Nicolin Chen wrote:
> > > >  drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
> > > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  21 ++
> > > >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 229 ++++++++++++++++++
> > > 
> > > Please don't put this here. The live update / handover stuff is going to
> > > need very similar logic (see the RFC from Pranjal) and I don't fancy
> > > having to rename or resplit this file when that comes along.
> > > 
> > > Maybe just stick all of arm-smmu-v3-kexec.c and arm-smmu-v3-kdump.c into
> > > arm-smmu-v3-handover.c or something?
> > 
> > Hmm, Pranjal and I already aligned that cleanly. And there is no
> > further rename/resplit in his series.
> > 
> > arm-smmu-v3-kexec: common helpers for both
> > arm-smmu-v3-kdump: kdump specific (my series)
> > arm-smmu-v3-liveupdate: liveupdate specific (Pranj's)
> > 
> > Each of them is built on a separate config:
> >  arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_KEXEC) += arm-smmu-v3-kexec.o
> >  arm_smmu_v3-$(CONFIG_IOMMU_LIVEUPDATE) += arm-smmu-v3-liveupdate.o
> >  arm_smmu_v3-$(CONFIG_CRASH_DUMP) += arm-smmu-v3-kdump.o
> > 
> > If we put everything into one big file, we'd add the two individual
> > config guards internally, which isn't as clean as currently IMHO.
> > 
> > Note that the kdump file has a very long notes (kdump specific).
> 
> I dunno, three files seems way over the top for this imo. I'd rather have
> one (even if it uses preprocessor guards internally) otherwise it just
> seems inevitable that we'll have random internals exposed from one file
> to the other, or duplication of logic or both. Even if we end up splitting
> it eventually, I'd much rather start from a position where everything is
> in one place.

OK. I'll merge them, maybe into arm-smmu-v3-kexec as Jason suggested?

Or do you still prefer handover?

Thanks
Nicolin

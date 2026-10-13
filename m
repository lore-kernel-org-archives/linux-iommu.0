Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21685349B5
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916057; cv=fail; b=lgLwCfiCTn5FUe7yqduOQK05QVuc4gFgzPw4SnUaxKf8aaIgpYVO4QxZA2gYhF2yuOQi+z6HTRBZAAryhTGxhFkx2lrSi3PBSX/aaGUPZMCWbU1OQRl+YVbdUEcxkL0UiBwdvktm29VwhtENvJ5SIr0iuk/ZIp5o9fx9cOOY7W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916057; c=relaxed/simple;
	bh=OMruVe7Z840klP1iY//kDOZtjG0BS8qOMlc67IkgpgA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLw2yMcQvjr5+bbh5M3Au5X6jMIsOhlrO7SGcLnDGPL3UWsa0VoxVOj0bj/MiDrXgxxSiSEanN/drE7yhXgGcknYJK7L+b47zMezjlkxoIzlByjnpCQrUR3muBnWiqSVmlsDB6bZUJytZGPR0WSx/rAjkJJQhdKLS3CUc+NSHz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oLUhGl8X; arc=fail smtp.client-ip=52.101.46.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oLUhGl8X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8cpQmUTAgKFkZTc7AcF8TOqk8oLbRZ6yGOsR//+ca6abR+SkWiYgxW6PQydzj0T2VzEpTX1Eq09TcVbsXyJP1tUivBELyyT+tIFsopcrp2P+53dE/Ybm44LbrZHS1RC9K8ofA+d599AoQqpGYoJGYDcX6z/v4VbtrF5rpcaTVzXAwxwgW+oGokpcTzM1TS8cC2kX8xmiAs9DUoQuWHrEme58omOmeixQVPkXL7yF3TQrPPaQxVbRVC1XbRGAOUwbK2CobAROlrMH9Io+Y6pv+mJgqdvMkeBkWFuxp+STmBRXv25nledChNH34TTJPzK8rUdY9/LSzEF5sZxcIJK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeZV8zJWPkmFQFaCF75hzG1PeOg6i8KBt7emXhobWr0=;
 b=yhbfgxZuiQNz8FYQAamfDquik0dE48L2CrdfX9injdMkdm0ZfXapBgM0bwJ7AdFMvpXirGfXPWr8yL7pXxIfsO0MSHxRQ5maZb9kYct7qNPFYGj1VZyYJS8iv3a+VmjjU774GveuPvgkFOy9KY/UkHep0MR6gVvwDT8vV83daaYQ1h4eqrZLa5Kch4He8GS8mzNN/jPAF3nhfJztOrtM1RjUkoyI4JGNJAk1q5Ra/gX7BFayRQ8nwyuhban8PErRijxBJSp4VIDPC+9fmW9exe45UJpdql3IdhUH4KlBRBVqVH45K0+5U85p+w5Xiy2CBp+BVAHoUCPWuuHmcUCI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeZV8zJWPkmFQFaCF75hzG1PeOg6i8KBt7emXhobWr0=;
 b=oLUhGl8XHrY25RU8HA9GdfU9FFJZiRF+nrKRgNSwyQEaUYSV9Is1pjPW4ENpe92oOhXE8nf9B6VOHf7BRDExN7XU1PcxMYRtVD+bzTe68XptxxVHsz8naOQwc3DRUlNwiMouCgtPtON4lhs/Qb8hGwsNsSWXFdqM4EFY2m1P7zq1/0gdq5P99ZVzGJNa8IA710uavL8KZmd+b813fM7YijZWH5bSiPGXIcaQ2isO+xSY6a6RkybJtj+Y0nWDpRuUsJ3Rpq1FmFqZer1g49UQ5i7R8/6isiqNXOz3lJ2nlsX832Mh56jZhU+VpbMpjDsrlxYNWzsa8ybQ8Doj2rIU8g==
Received: from MN2PR01CA0052.prod.exchangelabs.com (2603:10b6:208:23f::21) by
 CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 18:27:25 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::79) by MN2PR01CA0052.outlook.office365.com
 (2603:10b6:208:23f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 18:27:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 18:27:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 11:26:56 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 11:26:56 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 13 Oct 2026 11:26:55 -0700
Date: Tue, 13 Oct 2026 11:26:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Peng Fan <peng.fan@oss.nxp.com>, Robin Murphy <robin.murphy@arm.com>,
	"Will Deacon" <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>, Thierry Reding
	<thierry.reding@kernel.org>, Krishna Reddy <vdumpa@nvidia.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v6 5/5] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Message-ID: <as537DUBbK+tNzuQ@nvidia.com>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
 <20261011-smmu-shared-sid-v6-5-cb76b89dc612@nxp.com>
 <aszfVNP6DGzWYdK0@shlinux89>
 <as1zR1wc7ERxvR1F@nvidia.com>
 <e8c22eb2-ed1f-47c7-b2ac-c56ead1cba8b@arm.com>
 <20261013124400.GI14213@ziepe.ca>
 <as5ERENDfgC6FB0b@shlinux89>
 <20261013151458.GL14213@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261013151458.GL14213@ziepe.ca>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: b643c6c3-7f51-4b7e-bdd9-08df2957a11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	VQNQQkcLgCcNb+eGpcn+1ad016vfftF9T7oTB2r9l+3Wm4h5HcFb3mBei/ZmYSpe8m9ytO5/GpcoQET53aJRD8zwLzPk+RXsPHFAL2JwYL4+TGsepunENn9rPkWqh8hFGdg7yXeMUZn2wa2VfmXXrNR62+WaohUW0bUFCS0GK1PbSf/Y219SR1Ma6guhAHUrJLHo2Ehpalgxt4bwaGFoRC5eznFak3l6Xs6mg9AyBRcRFS4Ol80JpsGCE6P4Y95X9jRdiRBRXMNXdfKFX6r6srQxqW54LV59VSjM/iqW02eh/NRYAdSeyIWc0jx2WEUSkAN548zs9Fe8jqGAbiSEwZcZYplJ4qKRWzH4PFRRRXWSqK9PyWHH4M5HLDAnl9xVrSuDdxyVpYTfCr+6VLjNAQjCI646x3lFxPkyvIPg+K/w6rC6eHw+YbIcwF11Aqw8laXM/gyqnvSKxOlWSKTXczPNSu7YkbjSS4DCJRvsl9mUFwAzvCejC4l9WRXG/zD1+GGXsBjzgTnG4cQB/yZDLIkCDHgr5xF+BiGev1Cso/UOMHThc8Bdn47gkATk6OYPym/ByNxMSPJIz/sOKcGAXK5mXJcF1KHCDWY62CkIt185rL0KcJFFase4ZHtKcXcA9Lfb9hilgJvlZSmqsZ1hg6J0kddf9NK/Lmd06EV/JfKXh0x2RkmHcxRIBGv6g1Gnhfk/DDKhQjJfOReIQQvfSA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wDxq1Hev+3Ng2IeEXCpDs8NxIcdQplQGxmvj397HIxsEhZKSqPbHMwF1hZYAQPkjSVoCu/GuceFzQW2X7dTXdqutHKxjzULJby74aqgHyS9Kd2/sZFRPLJ4Xiq2SMvCJrHbXWiCxykw+zc5sHZ39EMzgWyN5IBKK1vH5k3Ua9Q3lrlbED0nvxG5SYY9en0GQBr7bD9uO66+daNgK/M4lcaEC3xCccRWil1PBCyTq4WN1eo9zl+dx6xPDeIryKezRggfPrsayC1HWU2wm8SQOI8uL2w0K9gVT3ZmZjSwnajJ49xZ9KFMePn8QcRQlTOjxc8uAEAo3rvP3oYCBxdFTATLXsvG0cMGdZWUQmj0sf+dWbwiD9JPIVsI8hyddxWXB/T/u2n+Y48eNRueIYhk3x/OLmHnJyOasDcJPKpjM2AOi2malPWI4P+9bND3T94po
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:27:25.0022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b643c6c3-7f51-4b7e-bdd9-08df2957a11e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764

On Tue, Oct 13, 2026 at 12:14:58PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 13, 2026 at 10:46:28PM +0800, Peng Fan wrote:
> > Hi Nicolin, Robin, Jason
> > 
> > On Tue, Oct 13, 2026 at 09:44:00AM -0300, Jason Gunthorpe wrote:
> > >On Tue, Oct 13, 2026 at 12:22:06PM +0100, Robin Murphy wrote:
> > >> If we're not going to support PASID for shared streams (which I suggest we
> > >> don't...) than we shouldn't strictly need to worry about CD tables anyway.
> > >> So rather than having to special-case CD table sharing for shared streams,
> > >> perhaps it might make sense to generalise back to a "default" per-domain CD
> > >> for non-PASID use, which can then get switched for the private per-stream
> > >> cd_table if and when a device does enable PASID?
> > >
> > >If we have stared STEs then the group becomes the per-STE data
> > >structure not the master.. We don't have any way right now to do that,
> > >but it would make some sense for the group to store the shared CD
> > 
> > Thanks for the detailed feedback, reply you all here.
> > 
> > For the CD table question: since shared-SID masters are in the same
> > group and always use the same domain, the CD content is identical.
> > With skip_shared_ste(), only stream->master's STE (and thus its
> > cd_table) is active in hardware.  The other masters' cd_tables are
> > allocated but never referenced by the STE.
> > 
> > I see two options:
> > 
> > A) Keep skip_shared_ste() and add arm_smmu_cd_owner() to redirect
> >    all cd_table operations to stream->master. This is a minimal
> >    change that works for our use case (platform devices, no PASID,
> >    no domain switching).
> > 
> > B) Drop skip_shared_ste() entirely and share the CD table at the
> >    group or domain level. This is cleaner but a larger change.
> > 
> > I'm leaning towards (A) for now to keep the series focused on the
> > simple shared-SID case.  Would that be acceptable, or do you prefer
> > we go with (B) from the start?
> 
> I think the skip is in the wrong place perhaps?
> 
> The group is always guarenteed to have all the masters in it.
> 
> So we could split them into primary masters and secondary ones. The
> secondary ones are all the devices thare share SIDs with the primary.

Yea, stream->master can be used as the marker for the primary.

> The group list is guarenteed to have all masters in it, so we can
> simply fully skip attach from the secondary. It is guarenteed by the
> group that a primary will have already attached to the STE with
> exactly the same domain so the secondary just needs to do NOP.

I was worried about the book keepings in the attach. But most of
them seems unnecessary to repeat on the secondaries. How about the
arm_smmu_master_canwbs() guard?

> If you do that then all these questions go away since there is only
> ever one thing writing the STE, it is always stable and no issue.
> 
> This does leave a problem for master remove to switch the STE to one
> of the secondaries, but that sounds like it could be managed through
> the release domain mechanism, just nominate a secondary to be primary
> and execute an attach on it in the normal way. The hitless STE
> mechanism will make it work safely.

I think the release domain can be entirely skipped on any shared
master (including primary).

ops->release_device() is called right after the release domain's
attach_dev. I think it would be cleaner to put the nomination of
the next primary into the release_device() callback -- it shares
the same cleanup helper with arm_smmu_insert_master()'s rollback
path.

Thanks
Nicolin

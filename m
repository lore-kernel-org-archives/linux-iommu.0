Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C31E1A3160
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787424780; cv=fail; b=J5/3zCgYqOLcHf85DucVqUGNrGDmnt35ISDN696NJfZzBtXnJs0E6ZTDipSNPbWPfOZC1bRxLJkbLx/XvliR+d6HRvIeFSH6rHT5csmS5ktIIeqKAjvpeJG/XfOKqluP1gEQJ7JCG7R0a30oSX3lZoIXqlhOryjefEKepAkeI4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787424780; c=relaxed/simple;
	bh=dZdGi8BDScCEJkw9dUTdAs6wiQrO6GPamvKivzsHpYg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiDAPVYhLLrYmuNq79TpyxSUcDIjHuQh3mbQ/3Q4nmVZoLJhqVCb2Uy4czryi5VA+yv9nJLVhi71JustMKX2Rr9JjdigRmMNU4WfmtZ3Oaq2OCU1sXqgOU6PfsbpI7rtKjljzryLxKjpXbjxR5WjuehGD40gIifyTLkNMzngH6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iHIlcXq0; arc=fail smtp.client-ip=52.101.53.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iHIlcXq0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdYACbOhlRg1S23rVGpV/LfvH1DfxW7Vqgyr4MykC5Hu5FWKf6I3UvTyulwE4i+poKZcBOX5tOvBUvZ6Ie+mJMimFvyemrusBLmoXc56XicEN/RVyPvsUNQ0Jf45ZpXE6Wd0poay/mnTRtHgqhaWopn6vKZR0eY6CUZVXBuFM7KDetuLZys8DhmcmmXIkehj/17tK30WZbQ/2xgAF7m3uZfTwyMRnlwuKTY4n0JUw6tG3NszwL6J6gDZ1Wk2jilJFxACo+JTQzcV/ZogI0T9oCyyZuNKK7LRL6i6QfViCM86WmelPiZPVyhzODaPbHh09FT9XPMzDJbGrWfr2gMGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hba9RoTboIDRn+/gDOcX6XqGj+80E3/Waic+hVLIoI=;
 b=fGdwQt/fOMmEx5vdMchf/JhR4PNTUi6LiuuZhod+yvprif88lD8Fw795qTrTxrZRXhac0lSDIncAImoDcC0P6YVi2G/zjvtl9+88PojKUpcG3tzhgDkPQxEi/sPem9FQR9bzyr8kOCnHULtEi4wKXFGdjzHZdbowgh53Dy5TcWZJhAJzbE2MkQNg4tsawuj54F0kX3xonCY8RBYoQGwhayq3kYnsOraaGkIK/ElpePlfUl8r8YDiJJxPTTKz6tqSsilZuVZlar4R8k9KtERaBIfQf4Z37YsFrLZMh3W1Uo73LB9rnE2Vj1j7a3SUs0/Fmi7dYeySQjQTz+210NZ8jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hba9RoTboIDRn+/gDOcX6XqGj+80E3/Waic+hVLIoI=;
 b=iHIlcXq06+QNXcqLM6YDed1qmXtO83N7f32EUhYX34Q7xFAqMICLcERXGcbMGwtMZX01MfFtIsN402iiIYuT1pCkYPyUnIjYg+mATOMMF1ebiQVj5TUG/TBnEU5BiQvJDh+VWsMzE9eb37gV9DN/6+GkkOlA03qqD5BPnJACsrPb7zz9VNcxIFltikM79nL7K8vyzJxPw7EBxsEKc3WkdawaszA1t1lbYm6oF04DWyG6bmQ2CUTxv3InMBVcdg5JoCTV1WZWzLmQY9i/yw7Lay/oaWCC1Ybf7IjcCCRNfFcXTxLpMyJ50xVoImDnKFiFP/J7wHPUQgLoZLRSWzohiA==
Received: from BN9PR03CA0299.namprd03.prod.outlook.com (2603:10b6:408:f5::34)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 18:52:14 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::1e) by BN9PR03CA0299.outlook.office365.com
 (2603:10b6:408:f5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Sat,
 22 Aug 2026 18:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sat, 22 Aug 2026 18:52:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 22 Aug
 2026 11:52:03 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 22 Aug
 2026 11:52:02 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Sat, 22 Aug 2026 11:52:00 -0700
Date: Sat, 22 Aug 2026 11:51:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH v9 07/12] iommu/arm-smmu-v3-kexec: Add ASID/VMID
 reservation helpers
Message-ID: <aonvzux7UJVxBSfm@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
 <9f9d227c0adf472e93293008e7083973688d015e.1784663184.git.nicolinc@nvidia.com>
 <178735412602.18212.13622444378152698190.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178735412602.18212.13622444378152698190.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f989634-c4f4-4934-4146-08df007e7b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	zuSUFb9+bQpu4p8U9HX0WwXjtEF+C1tdFL8QikvwllsAg1P6imco3xE90eEEYNRrkLVRu/3YJy7Bl1qPgvs/P0/FjvFEG7f/CjsuiR1X2a09sBXTfPQ1GtFi04VJafFmWWaFWxJkDJq/vUn3+MSnsm965EvuQkrC0nXZwNOX2wnI4cFfF+vFk3iQZqS2FGjgMjEPrDA0FlbNChfVomT/4Ub+fftO+swraQWFsXwi/cV5n8IwllmDm23HrotqqJa11qaENjHtOZvWS0BiSwrhpjB3NxbziVrmN6COvU/qj8AxRaEvCyutU0E1JXQZ2OFisFuVvyWy4YuSzqXQTsULfWAiJ/Xj7mb+RvwJQiofdzxe6Rah/7Ko5RSz/jP2s4gOXcAmdIkmafXkHSQajUjxjlUxVaqPSwsPZb3wnhfDCDzaR8TRa08MyVXL/nOkIse69R+NaAsh19ANzJFwWzWc0FNTKBPGBfWGJqFGN+aajXnj4IPZN++FSptdZfW8B4xt9HbMobnLHFamj3NTumiDt4TrZ96aOtksh222YXGMPR7+9s02Oa3uWxe10fBCRyoY9qokaNa7CRWGmcR5UUggSn6v8zkZBONiolp24skOmDidW7zf5EwyfQHoNnDxI/5fx7cP9+umaYFRhvn9MjAHI9eH3RcWqabfUM3FJahRmQUitR28SAgR8ZimzDQoFTX4uu3bRJYDFgO9DAV77oL7+A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SKBVxS9k4KEwCT9evlvtOYVUGfiwdLQLN0Td4ZUB+8MaW+zQ2TD5pWsTjLQSoBXihKOI40Gn6hBK4b36D7K3dihxkDIgK39koiIRr3Tnlm14m98Agw2flPfkWL5NovIcX3EGoOxBC83mC6kCRJSwF7wocq8BeiZsiTLG75uvILdNLwxjvCZhYyMbgc/i5uh0H+3WWV8AUXCe0yXU03NRbdpoxyHYk4/PAhIQZralsxLqU2oN5www2vboXmWcdc47ThzNLIcRtehRWLYzzx+JQzf2TJAXkZRZvHIyQ0NSaRHSM8kXJEqW4KuxInlXv/Rnmm/0Lpc3W9xIV4uqAa2JL6CBV6DK5hFvUafanvXDXKA1Bv9eDxedHHaiWPkAfvmww9325gZx3EXXiuizNRELaHTLp+tx6HwPXy90tO4v9FwC06fhxxDpc53oQte4MLDS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 18:52:14.0776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f989634-c4f4-4934-4146-08df007e7b32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569

On Fri, Aug 21, 2026 at 08:15:26PM -0300, Jason Gunthorpe wrote:
> > +/**
> > + * arm_smmu_kexec_unresv_ids() - Roll back a failing reservation scan
> > + * @smmu: SMMU device of this kernel that failed its reservation scan
> 
> And wouldn't need this either.
> 
> Actually I think this is overkill regardless, just leave the xarray with ASIDs
> reserved. Who cares?

ASID might be 8-bit that would have limited ASID slots. And it's
a quite small step, so I think it might be worth keeping it.

Thanks
Nicolin

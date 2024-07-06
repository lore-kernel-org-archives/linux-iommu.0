Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1FE629
	for <iommu@lists.linux.dev>; Sat,  6 Jul 2024 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720225971; cv=fail; b=X1THc8D5Rsiu90JAHl07YfSLO1yAc1xrVW66MR9Ux+SQW65JsIj8h2xyoG3om06YtoYDPdQvFIEJOqHera2W7yCcxlcC3ahYbc5Iz5HbNtAfRbJMtWdpoemUgWGR2NhXvBUcE+95EjS7l2Z6su4Opz5vUH763sPh77Zs5zxip04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720225971; c=relaxed/simple;
	bh=I7SGMvzMAOGlP9EUqbfrsKRYMLVjlDk+nVDp0BAgv2I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuCpOHFfLLsb9L2y9TATstRe8jygXRw4dknzh+ePN6btGOSw+0Corgcy0dfSArOXTnH4kmDsxAyVQ9ordTLv9Vdc7EqXKy+Jsjbxu7kkbm7YpZGkkKu4/2q3mvWGFBz3D9n2za3v8xebVpFEKTpteDur9wkjPJBeAP4QwdjQka4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TCKZIthK; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TCKZIthK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWjG8c/LRtEnNUT7/UlfuvxnUhyJedK8MipYcYU47cqh8PWSXBbDTPN9RYQmK0vysFEEg/5paDOpaDSALLhIbsMmiB9tSb5xCjXBIzlr/dsKo6bVGAfW6lhMfe4MfVrt4Kkty/BzfX8mqmvvPL/yZ8tP/CeYBlNSDbAvrzSzUuCtWqhYC7qgFSUkY7v3ApDJUce+Xka+kEVKW/ROB7gNBU8vl7WV9UtoQeV7W5CFdW1LsO0jb688j/8pRPF94TMYVvccRRomkUIArQ//P4rWxvxQMvPeLLcembArb3ZSzVhsVCoI221dRG/a9h8kwoMi3gm0TRya2Gi39ldGyYSdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W87poMyUedY4N2CWZdu3OtpSQw8VuVgrXmf1DsyYVSI=;
 b=cTciEg9Yqjd7UNTEsaKuAMuvZBP1DwEsAwyoUFLmzOV4iK2tOi0AofLYMyycgWlHaMRctGFRZGJ1dA+RMHWKpWXscWfY329TDG8noK21167ZCdN72OHpZLgFOWRAhMwPRAyAtY05cCrZ+YcBxOzlKpUAmV29PKlNchVEG62RjGQxsI0516huwrYnX7Kxm2IpGZ+pOGoQJGPwsrz/i3Bd+5L3pXlK7+f9GwY76nRMjsVOmWTrRFIzQx7D/QaxF982jN0tXo3ri0T6mjszU/M6Rj13ySQIVSPKkpX8TPk+4wf7/BA9nFRWOJqzLOj21ieDSUPjzGb5Yk/v5pyZoswCog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W87poMyUedY4N2CWZdu3OtpSQw8VuVgrXmf1DsyYVSI=;
 b=TCKZIthK+gaitL+gXbeS4CjW1Lab5smzObkJpmjK7WhwUUj1x7zZYb4mAaZSejSLgoa44xuI5jc+k4wUknvPWn3GAauBefV1UIlv3z6CmTJHpLcO0jX1YRhZjcErA0vfKz/VzkQqA0rpK4mNZc18l8nacVQ8A0mzFk17o2ryVSsgd3sIBm4VKDA8xk9iufYYpm4sTGiPhRtc4ovysGTT5BfkKgB7FkxkzFipCGNz0tIsFBsJ29B3VGwXodKTAGj/0EkHJkyZeq6ZvghxGBKjXKTXWRbb3Tdc9EXdu8v3dEsPJsUrORnFH+5OMM+ZtC3pvrHMKJza9t7nmX/+GbyzgQ==
Received: from MN2PR20CA0054.namprd20.prod.outlook.com (2603:10b6:208:235::23)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sat, 6 Jul
 2024 00:32:44 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:235:cafe::56) by MN2PR20CA0054.outlook.office365.com
 (2603:10b6:208:235::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29 via Frontend
 Transport; Sat, 6 Jul 2024 00:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Sat, 6 Jul 2024 00:32:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 17:32:27 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 17:32:26 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 5 Jul 2024 17:32:25 -0700
Date: Fri, 5 Jul 2024 17:32:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v9 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for
 CONFIG_TEGRA241_CMDQV
Message-ID: <ZoiQmAszSQbP18lQ@Asurada-Nvidia>
References: <cover.1718228494.git.nicolinc@nvidia.com>
 <d20dc9939523fac490bc02e57d7836f680916a36.1718228494.git.nicolinc@nvidia.com>
 <20240702174307.GB4740@willie-the-truck>
 <ZoREzIAqzyamQBWL@Asurada-Nvidia>
 <20240702184942.GD5167@willie-the-truck>
 <ZoRZP4k1A3G7nH9q@Asurada-Nvidia>
 <ZoReq/kNi368x79q@Asurada-Nvidia>
 <20240705152721.GA9485@willie-the-truck>
 <Zog3IgdmYRU7VbJB@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zog3IgdmYRU7VbJB@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b6418e-61d1-4477-5696-08dc9d5326ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K5Qs5BY1NVkg/P8LjAtvWw7Yw6EqHwST3QcQ/JnJsaH2ePcP/u4dNSVlZFBz?=
 =?us-ascii?Q?2bnT4zTKFWHzmFzEvYqmZ/nhgVxuj+EJf1pcT0NsHThmePgVQtOuUY8paxgY?=
 =?us-ascii?Q?z95s3s5QMg5ZgtLsNzFCH4Zj75eY0Viv27/NSqJEgdjTNbAIiqFrCRAISG7Z?=
 =?us-ascii?Q?Tlr6lGBqes0ownrhM8KXi2qAOslJjUMj9gelcaKYERAnuWzyjnmFdb44tMym?=
 =?us-ascii?Q?GOIPaQ9+WdrxGmjMgGiJoR5+8s7ynZey1rLizV3i1t4RwK13fHRe8dyO1iaY?=
 =?us-ascii?Q?jlx1FJFFMjGL1xthzBoFjYOWdFn68i6wmZkUOFdz2G1bZIoYB+eQIwkYGaNk?=
 =?us-ascii?Q?zhVzg6c/HoLSSIIKfUPRyRktGVjmgKws03cqCoSrilwMAlt8s41Mz+6TrTHs?=
 =?us-ascii?Q?Xy2f/Rw1gmoTB+H1uFFcxXaTgyejp7MVi0zu1Hfqi2iEDw9Vp3Eli+Ib8PYG?=
 =?us-ascii?Q?YTiiC0ONt6ZCVgpHlP3T3IJ1d5oi967u/vbARLrxrksSG4dvsOTHGGcFdxod?=
 =?us-ascii?Q?sFHImd3fvzr3PjSrKTjmQbn+CqoGW9a0qPwfUJBWwr3NCB+0H8l6qT1K65gS?=
 =?us-ascii?Q?TQnGVnmse95y1zgsqa9Bs5ymiWYNkh56UeVL0YdgIiJiAntW6DnjxJbIS5Mk?=
 =?us-ascii?Q?F7MUzCVWGpxbp1/vYJnEe4OeS7aYBabQtFBakf0GDvOXYdt+TgEnNEQf0kYI?=
 =?us-ascii?Q?ydzxgzN4RqoXa6gnKJWnPXv7W9JgyezqF3U4R9VFOs4zX/QtiYj2ftFXmnG9?=
 =?us-ascii?Q?iW2ZyqZPBHtWTY/btBkhsDpwzDKDTlPIwKWry7kbwyAHyXtoouu8RBIM2OHD?=
 =?us-ascii?Q?mKWfLffX+FWjJaaYkgtnXj2HPFH6Z8MoNvO2evJ6AW3b+GCRGXoSGmxBzsa3?=
 =?us-ascii?Q?PF/mJSG395IbhKdy/8YdroKb02NNfa4A5uBn/gGBSTgMoZFakYebumjEbnyB?=
 =?us-ascii?Q?ns3NXw9WABk+FjgmTPufH86XclMImFq9rTtTQnkG2SdudZd1q0wAkF7X1FoL?=
 =?us-ascii?Q?Kx3kj2PBvg5zv5j1os2i1x14G+mZfmTYk2FqgC9e85rAywETTzuuew0uADDJ?=
 =?us-ascii?Q?D3SuF2EL0IYCqdzFUey1X4buIqsAswEX9ATgkX5wDfUrKh2iTMlShzTPOjWP?=
 =?us-ascii?Q?9vLl6E4wcpw4SnQQQBgUmOL+quM9tndcTQB1mhr2LyZ1udbKcOkk2Cf5zw3s?=
 =?us-ascii?Q?Li9wYrVgWpBPTMARMt/YYwz98hG4eFrpDw5L4Ukx7Zl4CKeSaT2T+QHEXceV?=
 =?us-ascii?Q?0G+ERhgaG4yjAm1OX5yi4I+po/N7A2buwAln2c352aYQx80p8JFrTsdUfwPZ?=
 =?us-ascii?Q?mtqoo8Luy/XGY6kGWpVxgy2rhZPsASSgsZ8wZl9RFi5CwSnMXPxACFKeCNW1?=
 =?us-ascii?Q?n2vPQLpaZ0laUy5kNgWt/eP4soNSSkH4OKWQohdT1RURAmnnlXLOii1J35Dz?=
 =?us-ascii?Q?mWMic8+bCZNt9J1yqIFJ7uJG2/tQ41D1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2024 00:32:43.8802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b6418e-61d1-4477-5696-08dc9d5326ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474

On Fri, Jul 05, 2024 at 11:10:47AM -0700, Nicolin Chen wrote:
> Hi Will,
> 
> On Fri, Jul 05, 2024 at 04:27:21PM +0100, Will Deacon wrote:
> > On Tue, Jul 02, 2024 at 01:10:19PM -0700, Nicolin Chen wrote:
> > > On Tue, Jul 02, 2024 at 12:47:14PM -0700, Nicolin Chen wrote:
> > > > @@ -345,6 +345,11 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
> > > >             FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
> > > >             FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> > > >
> > > > +   if (cmdq->type == TEGRA241_VCMDQ) {
> > > > +           cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
> > > > +           return;
> > > > +   }
> > > > +
> > > >     if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
> > > >             cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
> > > >             return;
> > > > @@ -690,7 +695,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
> > > >                                     struct arm_smmu_cmdq *cmdq,
> > > >                                     struct arm_smmu_ll_queue *llq)
> > > >  {
> > > > -   if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
> > > > +   if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
> > > > +       cmdq->type != TEGRA241_VCMDQ) {
> > > >             return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
> > > >
> > > > --------------------------------------------------------------
> > > >
> > > > Would you prefer this one? I feel CMDQ_QUIRK_SYNC_CS_NONE_ONLY
> > > > is more general looking though..
> > >
> > > And we would need some additional lines of comments for the two
> > > pieces above, explaining why TEGRA241_VCMDQ type needs the first
> > > one while bypasses the second one. Again, it feels even worse :(
> > 
> > I hacked the code around a bit this afternoon. Please can you see if:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-nicolin/grace-vcmdq-wip
> > 
> > does roughly what you need?
> 
> I appreciate the patch. Yet, we cannot use IORT's model field.
> This would need to go through IORT documentation, for A. And B,
> we had a very long discussion with ARM (Robin was there) years
> ago, and concluded that this CMDQV would not be a model in IORT
> but a DSDT node as an extension. So, this is firm...
> 
> With that, we cannot avoid an unconditional hard-coding tegra
> function call even if we switch to an impl design:
> 
> +static int acpi_smmu_impl_init(u32 model, struct arm_smmu_device *smmu)
> +{
> +	/*
> +	 * unconditional go through ACPI table to detect if there is a tegra241
> +	 * implementation that extends SMMU with a CMDQV. The probe() will fill
> +	 * the smmu->impl pointer upon success. Otherwise, fall back to regular
> +	 * SMMU CMDQ.
> +	 */
> +	tegra241_impl_acpi_probe(smmu);
> +	return 0;
> +}
> 
> As for arm_smmu_cmdq_needs_busy_polling, it doesn't really look
> very optimal to me. But if you insist on having an smmu option,
> we still have to take in the PATCH-3 in this series, enforcing
> an arm_smmu_cmdq_build_sync_cmd() call in the IRQ handler too.
> So, it would eventually look like [attachment].

Please ignore the attachment. Since we are adding arm_smmu_impl,
I figure that we could add an arm_smmu_cmdq_impl too. There's an
another small feature that I didn't implement in this v9, while
being able to benefit from a cmdq impl now.

The impl can also hold a boolean busy_polling, so we won't need
a global smmu option.

I will send a new version asap, though I am not sure if we can
still make it to this cycle that we hoped for :-/

Thanks
Nicolin

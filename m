Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66111337B8F
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538455; cv=fail; b=BgtSNdXcjwRyxMmdsvH8VP65LoNdsjVIgsPJh2rKRTzflRQ5iB0A7VCIr//3mqK2Ksu/orakprluXlODtZ/oPUtsTUZAatBHTEQnDyd0PDm+A44ogXcpjLbUrFKTVcWFbtA3HHZyO4LII3BI8xStsO+d8fvKARSmY8qzlVNDW9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538455; c=relaxed/simple;
	bh=R8P1IfQ4YQ4IME6nMTHBHk30FxyOBg7lvKDm7lTW7/M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTiNjN/y7jSrBrPnm3bpl3cMQDfpHPts2jx/GzK14KpzesJYfjCeAmdPoy0BV3N48yA/ZU3WKSgg9NcOlaK7J0YA4dV36pL9QmkQbjQpy8mjq4XsjlHM0mMhbZceSnSzv4Vtkb21XyTWp2jRRzh5lX7yox5oE4jDuwQuDSvkAc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gKiII/Q1; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gKiII/Q1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4cIi//BQWsHbJdBEdU0MZgVLmeaaQ5SCqz0IZL4ECUYR+nLRbEoDFkEMr2xjEiy3gLoxxdVvQdGV6lZc5KtEKzxxKi483bJcZVRz7lYbSsFJfwKTjXX8Gu+swTXF1BDUq5iaDomp7L0/w7ktiUT2GCpl42qBn7uvuDLJeJvoxAtOxqCjbdrps5AYWv2JttWQ8RaMlWhn2U7q+89Luk2oSm59FHnMfzOtNA/iGO7aQfNDgPfa+oohsYg73PakrFSIiBvxrjGIYIgDuMb9/jeGWbZ13u+BgULFWlCYJw9fS59baCp7FiYkHzBNsFHqUQ6mwEoAeyE818fcX5e0DLTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLK9648rHaPEHnRrzGChUFuO0WeHJ7nMqbiaC1EDLwE=;
 b=BHnUUd1+u7xMeOtg3nP4/Eipn50RSMawaYQsHQQtmT1H4WDRS9QusVtka04CNYYCid+AoMydSOHtJQjaOyrMLfQuUsOT4cvG3k50McHN30uJlMLzK7hYsaa679LGP2Nv5yyxO/orFsk6zzlmceJGS7B/sO8KKU/fLhG8v9fpde97DOZ8NheNMSGm70EMf6zVfxoxsMhHXWaT+3IrjKG8/BaBJVdpScX3pDMQTh/i9MX6zj4OODAKOkOPAb0d1ahGKcviEM77ka3oWnLoVD+AmI039ITrVdJHytkLJmrk8PdgdM45im7cOZseqX9v1cUAib09MxvU+QcmYw+X5PF52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLK9648rHaPEHnRrzGChUFuO0WeHJ7nMqbiaC1EDLwE=;
 b=gKiII/Q1t3VAaOtbsdhjjXgIa5eox8w3adzYYBeVrtLH+Z2kQg54MXhxWP1imrNSoICLOvAxMbE2pUuvL1p+YIUV4Kq/6BwgpEHB6Ty9poeERcw9kbXzJFeJMjnu2rTlvkCax+vbSBTStNdT/Kh0gm3sDyDcWw9DJNnl4vAqhdI=
Received: from SJ0PR13CA0210.namprd13.prod.outlook.com (2603:10b6:a03:2c3::35)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 11:47:30 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::6c) by SJ0PR13CA0210.outlook.office365.com
 (2603:10b6:a03:2c3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.19 via Frontend Transport; Tue,
 3 Mar 2026 11:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 11:47:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Mar
 2026 05:47:29 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Mar
 2026 03:47:28 -0800
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Mar 2026 05:47:26 -0600
Date: Tue, 3 Mar 2026 11:47:21 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: <iommu@lists.linux.dev>, <vasant.hegde@amd.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Adhere to IVINFO[VASIZE] for address limits
Message-ID: <mqobyculj4g3mv2ipf2rbacbw62ew2utq2kini5hql5r22khhc@btukh6fex6zb>
References: <cf1a1e3d96c3571ac5caa528caa84751d40be1bc.1772208939.git.Ankit.Soni@amd.com>
 <20260302235715.GY44359@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302235715.GY44359@ziepe.ca>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0731d8-c4b1-4dcb-6962-08de791aa662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	spmvXCFTIYna+y2gH+XOLqENbswMPXSAsL7DVHulqfU8gjbJ8k5G1wNjpEsOeXKJbYVYPK6RMEiJrxcr0Aiy1wZkJuLBn7oGlmYLv9CcSY3MJNdlRuAGYADOmseitn34pldaBX8Qgr4OqgiJwUpoGfoE9zOjHMbO+WMPZz3TzoJFSxqvZSJl0rJKair6AYyEBhiRtQStMy/KFVCzGTikUX1WwVlPpZtFbpJCwwy7TUSUXVZYgJD+6+rz/YYEd0f+JNdv08jelt0f3d6MRDPL10rbhx60NPa7wsTY9O9sPR/zn0nFSFBRYhwpldey6W0LEMHtmNjBdav0oz21jmCXOmeoRO7bDUQrEGHLYVXl9v4/pP5/L2CNrPxgUgkiNzCaMcOwDtedbCpQ4qt+LFArInkGkGk37YL57MoPdXIQ0bPNndQNPZX6vHTaYTPjh1dj1P7O9VDzMZT34dspI+cTSwyOQ3dogKnAvN7SrzGNDJWjay7/h/mpP+rnHFKekZEWJZyWqiXogWsdCFprnlmEhWzEVGswzpzYfv8or5jewoK7020qOpacgSK9pCc3I5tJ66s3M1PWXVPK5E4gInvyurAHt48zFFU3eID290jtvxEDFUfdExH5tD+KKRw7ruChve12i/9futLFFon+cPEA3gr9LgniqivID/2PbPbnFr2VsniDyEdjfgvmKZHtrcThBmMVUcdA8U69KiMdrZmLVkdzzjjVlfi3OnPswJiWQ4FwF1D0/v/3OWQhPhfT8b4rMjuHC56D1kRJHqi6GSSjAXVreErMd0u+Q25uZMj1SZ8HC+xek2LttwZ2qiXT5MSL0i/wNAyTE/8G7vgMzDHshw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qS7rormsXWZ2kWTuHRRw8ipX18faibvBbvu26EMVKEqcevpWza5f6tZoBX0nyRfh9UoHjydngb2WmCcHls8aMvUYUSprNshHB3P1o0xEWGZ5ok7AuvNJogUeafbY/73DWZaMO54d005E10ErrqzowPrm2xplqLlHdAR3dTxREF3zPGG6LnvmUvIgWJZoO7I4bsBh9F15Sic6SbvCd20SsAwKJNkRiONyyx8wbXIlYI6Uq3MNS7OVCb6y589zS4ByXZrLbChMnCGzYINh6lsbwifGrFL88GLXCVTq3GBLyCxJk+xN0gdTrSDqWolOBwIpRXCTu/X6XXsb0+kzh/Dwev8HzfkBnNbRuHc3O+qmH4SQQ5q4Kb7x6LjNixYv1+BVcW5QcCMB+vXUTo9nafr8154sNOMXc/ki2gnukbSB/xLTgBmWDR0S7OE9jzffCn/d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 11:47:30.0103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0731d8-c4b1-4dcb-6962-08de791aa662
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403

Hi,

On Mon, Mar 02, 2026 at 07:57:15PM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 27, 2026 at 04:58:04PM +0000, Ankit Soni wrote:
> > +static u8 ivinfo_vasize_bits(void)
> > +{
> > +	u8 vasize;
> > +
> > +	vasize = FIELD_GET(IOMMU_IVINFO_VASIZE, amd_iommu_ivinfo);
> > +
> > +	/*
> > +	 * IVINFO[VASIZE] encodes the log2 of the maximum virtual address
> > +	 * processed by the IOMMU.
> > +	 */
> > +	switch (vasize) {
> > +	case 32:
> > +	case 40:
> > +	case 48:
> > +	case 64:
> > +		return vasize;
> > +	default:
> > +		pr_warn_once("IVRS: IVINFO[VASIZE]=0x%x is invalid, defaulting to 64‑bit VA\n",
> > +			     vasize);
> > +		return 64;
> 
> Why check and limit it like this? 
> 

I’ll replace this with a macro and send that in v3. If you have other suggestions,
I’m happy to incorporate.

> > -	cfg.common.hw_max_vasz_lg2 =
> > -		min(64, (amd_iommu_hpt_level - 1) * 9 + 21);
> > +	cfg.common.hw_max_vasz_lg2 = amd_iommu_hpt_vasize;
> 
> This has no restriction, you can send it whatever size you want.
> 

The intent is for the kernel to respect what the VM advertises in IVINFO.
If we ignore IVINFO[VASIZE] and use a larger limit (i.e. from EFR only),
driver can exceed vasize what the VM allows and break the guest.

> Shouldn't the v2 side respect this too? If there is some reason why
> not it would be good to include it in a comment.
> 
> Jason

For the v2 page table, GVASize is derived from the page table level already
advertised in EFR, so it matches what is reported and driver don’t need an
extra IVINFO-based check for v2.
For the v1 path, the effective VASize can differ from what EFR implies
(i.e. VM can report a smaller limit), so driver should respect IVINFO[VASIZE].

I’ll add a short comment in the code explaining this so the v2 behaviour is clear.

Thanks,
Ankit


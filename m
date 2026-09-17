Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ECD53B61D;
	Thu, 17 Sep 2026 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652126; cv=fail; b=FRPb/vmtvRpu6v2DblJSiFu+y9zPvGT5H+lPBUooL9iqrNPVtedORoVc0nEr0Qa9F5XMwSTGuJwTbk76oqZDpj1z081XYwytL/pASDlNAbhp/j6lVPCbKKT/lLjgiCgsnSDzIMJU8AobJTwQQ+D0Y/lTisiqYbXJsldpWEhTJtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652126; c=relaxed/simple;
	bh=R/FTrfxUagCPp5VMklo1D33slE61cUtSOMEThRJjUes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cPft2nZxCyV4C/2JfzbtFt/2pATvoh9tpxVE/KrXkUwcn4/jJ5+0kNXBrAIsUMrP+C+QGKmyrHxz2lr8UoLYbU+FYZsZFuBJVLR7t/vHGmSPlD6iEYN7VJ/NFdOvI//jhfUreNgo5EeQXnTDnnXv7K52qtQyg2rrZ/hknJ25eDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QBuhjiOG; arc=fail smtp.client-ip=52.101.85.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QBuhjiOG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDZyBaf1pOmKi03dYnbybiLWjH6C+WzAmImAF7Ip7UF+T35pSCG9iwS7uikl7UCvloHcy+t9vU0KNIA5wKzWga0kTJ/4FbDPnKal12DGU6HuSp/f8AyDzuhgAUtBS99DTMCVuN9vBAml7TNXHGRln6VUkkEaUC0rCqL3q9f4HASAo/e2UfMx56kRIkU81rSF7HpNWU9LmPDI+Lb3tcZGBIQRtRYeUvHaH9Xb2kMy8lr3Tca1byHQGV9zDcejyrezSPZVFWnmWu+nXihWJ/is0LPN0yQSdHL3AvLrnCMD6Dwzn1uMIeZ2noUAScUm9HwXJ6W9DISyyRG5P48Q5vVjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzz6pHEWqTrgKl6v53ZyDsGDR7tVVufDjDAvTQ9eyKw=;
 b=Cu0kXNXfyM4wvP5PBzKw5NYwpwrIYJMKxWqPM8go3tf48SEGIVi6Rrd4jQppMO4q81O8nJ4ZN2T6bJQZMZgL+ycsvdVv50f8Sji0LMzGXuGS0XDvpCaf0PL90+B0f19qpfCeLC4EmX2OaGYAQPooGPnZBJ3WSCldGGsef6aVi/N3wPDqH8gokN4HA2kn3ca0s0ZZz4bUkiL9mGnms4D6tHPq9UO0DlbBXyYPyop82/ocSPopesHuk4pAWFtQGTequwO/r/IxlFhpX0e4ID32mZ13gGmFzJUSb2ooZOqQABn0aDevX4LInZkxBh3tE+BaR3kOgnhIk/RIKPQH/qF9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzz6pHEWqTrgKl6v53ZyDsGDR7tVVufDjDAvTQ9eyKw=;
 b=QBuhjiOGRtOxa0Y9D54n4+gwSu41EnSY55NB8tut/q9sVfSdj/9nqRe3HLeJhg6Mj7p8rUyMuBNUErXU6FZlOE9UGjbSSzxRAHKt77zy7iSIFJ3fp0ZOKBlvXUwuaVxJw62+dC4FUWVnGBT1y7qs6XhI3402JAEeUKrP9oFRwZQQ0ufdWJ/TL2CKoirk7R81XEFxWEUegPzhFNLDPxJ+g33APiL5fgfisQfdFmocfJQ2kbGybG2Q0/s8a3dysKBelfIIdZ9wcWcohF9oaJqOlp7WS5eFaTRdicYKdPjqa3byFMzQI5ALeXa77Q4S+j3vVuid1Obbz/d57t6pnd+Eig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SN7PR12MB8769.namprd12.prod.outlook.com
 (2603:10b6:806:34b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 13:34:59 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 13:34:59 +0000
Date: Thu, 17 Sep 2026 10:34:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: sonang patel <sonangp@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, joro@8bytes.org,
	Robin Murphy <robin.murphy@arm.com>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	aneesh.kumar@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Gavin Shan <gshan@redhat.com>, Vikram Sethi <vsethi@nvidia.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>, rppt@kernel.org,
	Thomas Huth <thuth@redhat.com>, Marc Zyngier <maz@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>, kas@kernel.org,
	Kohei Enju <enju.kohei@fujitsu.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Ard Biesheuvel <ardb@kernel.org>, James Morse <james.morse@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Omar Sandoval <osandov@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Sam Edwards <cfsworks@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Pranjal Shrivastava <praan@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, driver-core@lists.linux.dev,
	Ankit Agrawal <ankita@nvidia.com>
Subject: Re: [PATCH v1 6/8] iommu: Introduce TDISP T=0 state for confidential
 IOMMUs
Message-ID: <20260917133458.GB3968357@nvidia.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
 <0421799346a09bf7f32727330ca1044de05f46ba.1789010941.git.nicolinc@nvidia.com>
 <aqvFcIkll6e2T6M7@sonangrm.nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqvFcIkll6e2T6M7@sonangrm.nvidia.com>
X-ClientProxiedBy: MN0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:208:52f::24) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SN7PR12MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: f653df9a-ff90-460d-f838-08df14c077ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|6133799003|4143699003|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oC/1DEgipwYSGvFweMFmV2Fu5ll/u245wGWpkzRKNlSwJq2TUras53YBgNrNtDoTWZmL2rlwsb0U55Opo7c12rmwaKSYCD+ZzrVndWPGlziTA3zmar2JXjGhjft4zuDK57ldPUmcZ6ZI1q7fVx2sgcL5ffCqkYbM2y5LBNtZo1933WKycm7VFzx6/pt+qn9EPvOHitZn4EQdQArrpffF8cPw2Zfy4a5vJcENxuyVZdJMbMwM6ztdl9IUszQF8ksu94fYBDq0cufBxrEk9v/s14xLkkmo4UnCRBL0VPr+wn0+RLILDxLVRIAD/8DNYOPVuVAXEsaEgZdapUWiWK2Qzyq4wUEbZ4qfYPpicpCL9nETBDRaSeWdcqKnyBAJ2Sjzo6p+0ddzyBp+OI7znI72grXdAtpNQj7AHOHBJLL9tvoBjY1iEYiR8ssXtf1vwfwm7WTfM7LaONUA7FoSkM2JbRSiLgTudeCy4lnJ2YiT4ze0Uq9ExRgEKz7T/B51Bq1Vx+wO7a0Vo6UNJlYOz30mPyIwFPF1aiov30pQMHQ/z1GsKYrw1nx1GfiE+jGREzYIRsx1OWs0WBqGgFkXUKNIKpVsanMa1zsjVB53FDd2ljVNeDQB/gdq7Gld3WD1u2h16XlvNCUEN9rwhXiCEo7QYZBRcrvTKeZBE4eW84EigdY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(6133799003)(4143699003)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iB+vBr+RP9FVCrqa7ICAME8NCb1w38JWnrLkyV4TYPUGbSOES1cN4ztX3hS+?=
 =?us-ascii?Q?pHG54ghGl/ic3nuJBU0mkSHFlxcXqusSo6ZjDnuruwGnY5XYcWee0bmP3Mea?=
 =?us-ascii?Q?4Omb3QVr5rJ3P2Jn84hrcgX5M0JCq098s0db8+OcWFsrUPBs49Gw1JnXD3AM?=
 =?us-ascii?Q?wq29CcyKA1k+D9SPTMP9Euc1j8eITQjzVurH3KYI51ObpxnpdYSYHj0QL9lj?=
 =?us-ascii?Q?uw73bwl16NQAAVqDtu9AGCt+STPOcJ9Zt1XDnAeK2D6w/8B0h5kRG8nMcFEK?=
 =?us-ascii?Q?bg4tGCTOfSYsVsc0QWkIGpAXjR2sxribxg5JS/WwHIwJt5+gTzwujJzxwE71?=
 =?us-ascii?Q?c1gk3eQaSGoWaiTgNhEi1UHivZtR0SCMk8+r6jbcaoEcgx4wcOdUPhuXgaQW?=
 =?us-ascii?Q?NhxdKwOZBN7PASZHbavqkipjov6rQ5e6ThL4NH5xmskq+uwKVrkuOot7VkP9?=
 =?us-ascii?Q?RYELBcKKwUg0BMYBlXEdDvrjIGD0HW4y4LFUIYPnj32Kf5X2DLAMzFDQxwlG?=
 =?us-ascii?Q?+T5SHnuqOBK8092Pnt42/OO7Q8/HarWbRd/gGGM9nmq4trVBYUFPGkv/KfiH?=
 =?us-ascii?Q?puaOKFauKrVgzridFxkXd4hBF0jktUJbdQiYd54iZHKFr6zXVOxRA9G1FQ3U?=
 =?us-ascii?Q?NEC/gJwqHoXLdZ7SVcjFYcFHGoO5boJy852BxYNzWYgu+ODGXEj6O0wv5OTy?=
 =?us-ascii?Q?bibnf9OB7LxtuUfd55TVtpZDrQ1UZ9NWfnBdpvBS9ROorLAzb4nFAdv5giJW?=
 =?us-ascii?Q?EHOXHhcirbRQjzmqvEPH/wVv6e/jLysMXyo4HahC+L3fgqnA2V/jg1BTe4nN?=
 =?us-ascii?Q?SfMuMj5OUIAEtiOZTBPxZeyppjS5Uo1Z5iF89ZMyGH1oFOhmBEeZJkkXJIRr?=
 =?us-ascii?Q?CbmF7xle/LZ6tdLOrZPfKPgfFyKHDC8T6SzPXLww2H3IR4CKb3d9rQcC9189?=
 =?us-ascii?Q?zqwePIRJHmmcTRxhv9/d9zcZm25c6FmoxHJw8ste37rwLjfSaWGOKakXyldC?=
 =?us-ascii?Q?gfMJyT+714Kyks5wbGCuQ1yqGUXgidboKLFin/e43ui+tVCZ3a9mTwBJ8H9r?=
 =?us-ascii?Q?MKE+wpi1fOKzQZ/pmXmQQhhRKAhLdOBMlCIDtNejQZGlOM5kfId4c+QCmLGm?=
 =?us-ascii?Q?Whhep/grvVWRsYL9Y7rLfmsCEny63Lf+Rem5wLNY5bfntk3ZLcDVwaRcisOb?=
 =?us-ascii?Q?8ecmMq5X5oIuEBOW5p7QwHVjM8TWwLh9PbCd5lf/+E3KNrN6jzq7KOv0soU2?=
 =?us-ascii?Q?PZKDVPyEwTjj/z4f/4GgC3WlcweYb9uqCzkupiWzFY0I/E2DMU5P5gspnHdg?=
 =?us-ascii?Q?SlfY4MWZ9mo+a9DhWYb5ulmNcoy2FYGlm9iLAW4t3ooDgg/bEZeKbjOVU5zz?=
 =?us-ascii?Q?1AwtE+5IVrFdMRGmfMw8AX4jGTAhTc79BPd2/zt8fkF/Rk9+2kxP6dKq2HJ0?=
 =?us-ascii?Q?rtcBckAs6AJ+2Rlflocko44Xp3mQDTG0Tf2xQQ+MpVGG6xXrjddgwu+RbfTP?=
 =?us-ascii?Q?3CeG2fTd0Dq3bFnBgQ8MbSPkvByV4inr1VgUKDDpjzWF42AxcIzcZoLgzM01?=
 =?us-ascii?Q?omMNSgbMnpKncmnYwZnDjSRR9EJi6ARkPXpeKwGEpR7V0Prvl4GuaqcogTX0?=
 =?us-ascii?Q?iGl0Y1O/6kW8N8XbhNMFiX2moEXFAp9CthN9iLeKwW+GMvWaXnkQKURva7az?=
 =?us-ascii?Q?2bfwqwSB10WyG8FVdxaouG8sCAeWAurOrGhcwkQycwn0y4bs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f653df9a-ff90-460d-f838-08df14c077ff
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:34:59.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24yjeOr//gTQuKVNlogv/eLm0nsM40iZB2d8+m8vFzkt30iJOmV7lwjIilcGHxo1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769

On Thu, Sep 17, 2026 at 04:18:16PM +0530, sonang patel wrote:
> On Wed, 9 Sep 2026 20:32:49 -0700, Nicolin Chen wrote:
> > + * @tdisp_t1: device uses its confidential IOMMU's T=1 stream. A zero value
> > + *            means T=0, where the T=1 stream remains blocked while the core
> > + *            owns required DMA operations such as ATS.
> 
> What happens when the TDI transitions to ERROR, and how does this bit
> signify it?
> A TDI can drop to ERROR asynchronously, and at that point the device is
> outside the trust boundary again.

The bit reflects how the kernel expects the device to do DMA. It does
not change when the TDISP state changes.

A device that falls to error can no longer do T=1 DMA, the device is
expected to halt that internally. It must not start doing T=0 DMA in
error either or it will corrupt random shared memory since T=0/T=1 are
different IOVA spaces on ARM and Intel.

To recover out of error the userpace would have to cycle it through
err/unlocked/locked/run and tell the kernel driver to start it up
again. During that time the device must not do any T=0 DMA because
nothing has been mapped to it in the T=0 regime.

From the driver perspecitve the device simply stops doing DMA for a
while and when it comes back in RUN it is able to do DMA again. It is
sort of like existing RAS flows where a device crashes.

Jason

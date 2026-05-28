Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA98367F5F
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005704; cv=fail; b=jFlHPBYnUEvY2rHiQ2QumXqXzUZPGhffyaVh2i9DCMUjqAWcwiLnhmj7/vyZvWCnXj4OD0GYcc4kC8U0h2uYrCuvR3O6iXaKtTwra4P+Sa2H1gpjhx/VGFSiwhTQgnTy8cxSXhh8kdl3QggsPaQUqW4ODGnlG59TsUgIQFhcGNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005704; c=relaxed/simple;
	bh=JbrOvE6brlGRJB2/ipfUVDcl9bgkJKS6oKAyzGfV39M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDSfLdPwufFkvkEDEOd25QEe5mtpkG0tbdn9CjfKosYm12NJZwUsagpoGvBrdTB6+0yl+jVMbDbos9ibABFaUKSCTnFLu6xvPowyu/uomWS3NJab38z7vYDR25ispVGcOymCBf80z2c1k3vbZIxuWHgEmQ0SKp/OIzouKbrz0GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=amW7ESoc; arc=fail smtp.client-ip=52.101.46.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="amW7ESoc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIKfpXTJtIxrwEJK42TQcgPzrWVADzHdOXTZH0GB0hStEsn/0EQhyd9rm+B0gUeic/oCgh2psphavy/d2FIQRJOxIXvE8d5wzYKWwZbpWC3U0TN1wW8/dFrrkHe4utPPMrbgrwb0fnRCzBd2g+Vx57wkoDA0aFwnyScxk54LvTmsWdjGlcE27Gx0wgSwCilb8Il6Sp6D/33TGEk8OBV9ndpTXdIHqyDj/uBVdOf4Xj0vApA6RuWuzPnIUz9QDs4Uh/IvXiGYWv0bSsR/RzgsD6ppAVepw4V2/8WdacN4oNlemiAHTecgZrNb2FEnc1i13zvPjaBb/aaQ7ot2pGqGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8tdVFz9tfFs3ioKuM7LSOVC5CVq7H9TF/Vxd0judgY=;
 b=eCt89+5Ma2dPXaPnNElROoXlIWz2aSS0eBsu1POMi3G4gDaLLbkl1DVwMhBdu7uBidOONyrxDD18RKwJw4nbkbPDQ8V2SwhgjVwxKd0tGRuPmNBSvPQRzAiCXPNjXo6bbkH35nC2yVLzgsNdsTHBypWgkJIajERrH/+/uQ/FanoJX+EJZRrSxITrIuH6bPBaM2DJquwA/R9vRQTTsDe+JZTrRg5LkW4byR7jzUJYJcxziD3jKa8tw8QAAhymLW3WPfZl0Vroybg2jxU8U2Gl+4lUAo5RQaBg6S55NgsoRqqbWdBq2QpU8Ti/Wy9FtMr4Kkk/RWbZeM4kofjmQ0zWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8tdVFz9tfFs3ioKuM7LSOVC5CVq7H9TF/Vxd0judgY=;
 b=amW7ESoch5ywTJ5Qulk4uyQbQuA598ktop6F2pzG2u0w5rQptn9geXLQKwD2uE81s68Hz1oHZBxc2l3CRnrotZgjyFifcl8Wm8NfSt0GSls0Ysy2uZy7LTZKbl0jtuigezveAD3T9s0zUsk7ajUYi131Kyek8IgK4zAzw4IFITEFvbjKjmZAYJweE5hEKbGCtFvsJwSw7hl+HUBDVQmlpR7qgOmPQfi7OKChIqjlxZlYHKNWRRz695VcqZNs4TMAxAQevL4il9LUoRyjexdLlLR+ps1/3zwfaIRVaEdINpMgesYDUAGmDyFvaXcMjlVmmF8vKvENRR8l4GjDzx6gsw==
Received: from SJ0PR03CA0094.namprd03.prod.outlook.com (2603:10b6:a03:333::9)
 by CY3PR12MB9608.namprd12.prod.outlook.com (2603:10b6:930:102::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 22:01:34 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::58) by SJ0PR03CA0094.outlook.office365.com
 (2603:10b6:a03:333::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 22:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 22:01:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 15:01:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 28 May 2026 15:01:15 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 15:01:15 -0700
Date: Thu, 28 May 2026 15:01:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 10/11] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <ahi7KWov1+GC3xVx@Asurada-Nvidia>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-11-praan@google.com>
 <ahilX8Za1NRCH3ik@Asurada-Nvidia>
 <ahi3uY9YZZtR1Lq5@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ahi3uY9YZZtR1Lq5@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|CY3PR12MB9608:EE_
X-MS-Office365-Filtering-Correlation-Id: eedc44f4-5305-44a6-7af1-08debd04aec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|18002099003|6133799003|3023799007|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	QsIrti8UtVN3PTBBjClvn18GHVoURPD/ZqaJ8pi5ZqGrm2u8torfr8kW4SYky6pgMlDM76lJNOFKaA5vurzsAomOHbHukbKO1tRuXzJTfLC8Ygj7hGduzdxj6t8DQ+Lruyd5Sx/eSovA7Sf28CcnfQc8kVnEljdSLHC3V/OkO0ar1mG0CLOFPJFTM37wia1bffpScXS/YJVkeLe66UucKNv+mU4l2Q+IHgbTvksmG46uBdXGJwDFEqaMf093YB6mcG2Vjeo1FVqhwiBk5c6mw9OR2L89f3Z2EpliVtRGTaesz5bslOupddI2p/S8qmSoU44BchRKknIX46tlosCiUGXafl4UTbZjgpQV3UW/cgjx0pc3EfYw4p4lt4p6JI32xTVRThScXDBWlUqPJQ9xD+ZxwnU3uC+M37lQojc4Yi+iuFsWEG8dpE30HbLTH6szNfbCPKWqPghXrmqbUn5mlyH9GoFgxuqZSjVDeD9Om2zZAYlj9jz9aZmoRd8p9eNygCKn/gITkK310Joni/9giN69ftB5vyaO/MciDo4iRRFjwqReU96M3Ho5zkUJ6pEaE+p1O8Lhf8u9cFTl/CVEhiXv/ZMpHu11mjtGjMcWoo12mnLoBH1FJ4dR8M+EMnWFcw15p0iTfon2y0E6xXm6vzh10jXBjfMpqDDhAWAN776ZHVGcr+aYnf7oW51xlQPZy4ftcb4156txdP9Y8wg8sTFint/kPB7nNWuWF26Qohw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rvqcj5fL1rDf6TGTXSgHZK6HAey0xc1OjfGEIoNLKun0Hf8olQapI35dnRTb6D4umD7Q/da6a3TlG0AdmqvwqnTMCFhTc6DNY1cbQ09AbZHykpDwDrd2dbYkT1ePwBuwaUHwYrzoIOOQjaOIEbxYuIhmoNUfzYEx4RIxZFT/pJBxTUxPIVRC8YGH3uihWeOn7I1pOrhtNN+FdXziNVEas1tyuhJKV03pIidnJxJrCCscxd22SMUocsmncJfJv0XzjmSxc0I3ja16ZrjbFPAQqhH0z5Op2xe/aH4jI73DuB8QLOrAWQ+r8SziHuJqi2XaHF2kSRyR7ugs6t/8BpVVIDM9qBwx1iQEr8PZilB25Z/rof0lE4Y8lcU2GWziFBRNgn5sd5fpoBN9IKgYIzTgobAoyT85n7z6Ds41siDfWGLFwGDtKdp5+v3KitmD37jJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 22:01:34.2097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eedc44f4-5305-44a6-7af1-08debd04aec1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9608

On Thu, May 28, 2026 at 09:46:33PM +0000, Pranjal Shrivastava wrote:
> On Thu, May 28, 2026 at 01:28:15PM -0700, Nicolin Chen wrote:
> > On Wed, May 27, 2026 at 10:14:06PM +0000, Pranjal Shrivastava wrote:
> > > TLB and CFG invalidations are
> > > elided if the SMMU is suspended by observing the CMDQ_PROD_STOP_FLAG via
> > > the arm_smmu_can_elide() helper.
> > 
> > All the arm_smmu_can_elide() call sites here would eventually elide
> > the commands in arm_smmu_cmdq_issue_cmdlist() that is already gated
> > by CMDQ_PROD_STOP_FLAG? It doesn't seem necessary to gate again?
> 
> While issue_cmdlist() would eventually elide these commands, the 
> can_elide() check is necessary to return early during suspension. 
> 
> This avoids unnecessary stack allocation, cmd building, and spinlock
> contention on the cmdq->lock for threads that are anyway about to be 
> elided. 

We aren't in the perf sensitive path.. most of those aren't going
to be that bad.

arm_smmu_cmdq_shared_lock() on the other hand is taken at step 2,
and the STOP flag in the same function is gated at step 1?

> By dropping these requests immediately, we significantly reduce cacheline
> bouncing and contention during unmap storms.

How significantly, so as to justify invading every command issue()
call site, which would be difficult to maintain? If we really need
an early return, it would be nicer to have a common place at least.

> Furthermore, the early check
> also allows us to specifically trigger the WARN_ON_ONCE() for broken
> devlinks.

This doesn't sound very appealing to me.. And even if there is a
very plausible reason, it should be noted in the commit message.

Nicolin

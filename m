Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992C42DFA3A
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 05:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781500479; cv=fail; b=FzbEMsJ5nyQglq5sX8zk/RTcJj5J9LWekRNdDu3EFPTTiBOIr4rdUHL8ITzAjTqlCyxpErUuyBUs/hEZJZ3/Hyrq08vIhlvk8gEPFfDoUDZ67Y70Xn2mLEDBLueVBZcvS/MLq0jdFaqqg7z6CTIrmjmuSdLRrSMmu1gMBRa2fjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781500479; c=relaxed/simple;
	bh=K7wQ2xahSk4kHEe7eoDbkXol3MsE3TqTQDDBBV2mJPA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVTDiqFOSch8HeP/ygmXL9f3IHkZ/GqQRxXahmkMXgiYXpuV/w5AnNJ/EDFZrBg3qv4R0lDwlxC73e79H4CNkNWKHVJ3fPbj3BP7Qdtb/Gkg8as3IxGaMXZQ4hE9T848i0gp5j06zBeHaBozcka51nHloB+YtKsrdpFGV89ruag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0fHrjPWV; arc=fail smtp.client-ip=52.101.53.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0fHrjPWV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQaxGcv7JUSHVKdumRmS17BpzAbesBsORWg7uxqMQAEIfuSrzKxyYDxyFXPbedW1TwdU01FkbaJPpzNkl0pqDIMMuS7Oxr/zY8k22YhPkm371XRGRxxnTvlvCloS1qKb1bcd/6iMOwldK7riM1H5QeL14GFx+BhmMVodQX+34L+Dz+7IN7Yl+tAN5yxsvd4dIY5uwPktjHcB3d00p2afrukjvjl9Wtf/nyAoM5mc7N1iNkMbeCKcOesGbs51U1tOTh0sW3EyiLEUH7/x4XrBSuMc1Box09sMtBXcwO96sZGhwFrf5bU7Q08G9QbAeK0n9FRbNRBVsvDlawajiyTd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhmh1n//nssUOK+u3NEOxcYDWnidnotIfi9ITpU8y1c=;
 b=Otkw4eWMVFF9ZHGhxp4POk/fGWCu6f1oReAFMghBKLc0QX9+97+WQMzFUS1vkqPeHnOlJ6AopbPAv1rZMYcg+gqkYI5ZvgtwveqkThK1Zamyf7Rz0EDlpR84nrnPzjETsIh3hoP5dTlP3VNmhJGrYxz9AUgo0aBuXmIU6TSRnDzy+HgfWFY7hjLS8uUtLLbWnvaAqi2yYhI6gQotZCOzPV4GQ+tGoKDdhNX+T9tr7SrzCoIuJCEAXho/ITwi9fd/IFRRBtIBE/0qaplo+8ol96Ea6V8RHW2KWFIj0bPwWcOMFsAdAAjdUlSQmvPLjnuwc3nJzwypz51OCg6z5/bF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhmh1n//nssUOK+u3NEOxcYDWnidnotIfi9ITpU8y1c=;
 b=0fHrjPWVmEru8xOcW+hVk1FIdBRyf0R++oI0+9lIbtrilWEF/ldx62/d6b6upKmfCIBJvkL0Sp+nKFQJNTGhnUo7C+0LF01lkRDc8H6LzfB76ecEtHuKU7uJgr4RbGSTYet++W9OyGML03H6cETK9dRdhaeBGwJk+YgpK7F8fgg=
Received: from PH7PR17CA0031.namprd17.prod.outlook.com (2603:10b6:510:323::14)
 by DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Mon, 15 Jun
 2026 05:14:33 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::6) by PH7PR17CA0031.outlook.office365.com
 (2603:10b6:510:323::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 05:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 05:14:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 00:14:32 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 00:14:27 -0500
Date: Mon, 15 Jun 2026 05:14:21 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy
	<robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson
	<alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Pratyush Yadav
	<pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, David
 Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 01/18] memfd: export memfd_get_seals()
Message-ID: <wth5g4v6usr23ufcm35lt37bt6ei625j7wmdq2grlcjiplcp7z@kdw6kevdhs22>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-2-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260614233728.2212104-2-skhawaja@google.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bc8c04-466a-425f-4bd4-08deca9cfc4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|23010399003|376014|36860700016|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	vCUNZw+PhZH9Nm08frAi842lxzSDhaWRa79OlKCcdy7Ehjl/9shDhJnKY0JzAh+dy72qI5jwH12AOXA3fspEPojM7uWem4CUiyzvqI7kw8mY0T5JQlME4aC2dcCclSYrKL30Wq7v+tum1BzlyVh51ajWvlc8BaWoj96AJLd/msezzsJ4advdpXgMYfFY2uXuLAhMv79AAXew4S46vbiIqVHI+LWsmq8NmmdGAXcvTNao0R+2nGMb6Wn3kIrpmYEdHu0fTMowiTIa6pdBbXSBIfFdKImJOQBPwAOSA1+I2e+8lk7gPPWv1VJ5X3Hn9rQKMN4xyHduBRrAf3hQkJoyhdI0taqAsMlkGYg/ZaViHzcp+ePJ0klGvPbFEKmH+XL3msSzMLQtFe36ccbqKMXGc+jMAN6A0ymLm1LgJPjSJLXbV/jPb6ivTcVJbjntBOMiZJ2HpvIMCYwTnlXVSmMgV96ry4IWBc1hxKZVuuLxnh43uAsOZB2fVBqmCHJX9C9kxUgqzx9ybNmfVlVP5S+Si/WdeZNCXJE4LfNRx+PiR7MMBFqItfPYKMK4ieSjFoieeJA/bzoCWKkxoEXFN3WSZTTDZbggJklz/yw+zayqvWJ+l9YY8rcMpKdZ1AuL3rVd56YQatHzFMI1lZbJ0nG+8qM2hsIRbJmnRHRsdtc0YHaM9quUKwAbItMM2W4zBBByS1523syrpaswoMZP+a0d9nmtzRNuAn3zEStXLyk8+Us=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kXihONv5IPrQtQ1iaVkCktG455cutOApavq2pAV+5hJg+yHxDQWWIyVxHa+gRS6y7Nv/S/R1ZCOyEAf3PtrnKV8bnXMDwATfUo4rpJ4I3yq0Rb1pAbyC6w3Ix5qgSY2+bBiWqsV3AkhmDhDHWSM1/i/Y1yhxjQGlMmTumcee5mITCko0vyFNcSyUXOYb0tzZf1BJp2OYJImcwGMWBAMNKSx6zQ/Suz1nYnKcCsyPsAnb6EhGwZQM5EH1w3nM5ojMzgleRJDgjxqWLfFJ/hm4LciR3qK2AHtV9P9c5KHIPiepYSiZxWIF220eYiB5vG0+wKQ5TFrnQN6OLqX2jHVhstSD3cMjEyRgSc6noJEcdMkIogqD2cNjCZ4o3EtDg09lFuP74enq7w2t6eli1KUso62wQ50QBOtsyEBhQe+F1nTkHIeobJLBnt7qdDRYGu0p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 05:14:32.8752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bc8c04-466a-425f-4bd4-08deca9cfc4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C

On Sun, Jun 14, 2026 at 11:37:11PM +0000, Samiullah Khawaja wrote:
> memfd_get_seals() is used by iommufd during preservation to make sure
> that he preserved memfd was sealed when it was mapped into iommufd.

Hi,
Minor nit s/he/the

> Since iommufd can be built as a module, export memfd_get_seals() to
> avoid linker error.
> 
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> 

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  mm/memfd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memfd.c b/mm/memfd.c
> index fb425f4e315f..1f45fa6d4e9c 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -315,6 +315,7 @@ int memfd_get_seals(struct file *file)
>  
>  	return seals ? *seals : -EINVAL;
>  }
> +EXPORT_SYMBOL_GPL(memfd_get_seals);
>  
>  long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
>  {
> -- 
> 2.54.0.1136.gdb2ca164c4-goog
> 

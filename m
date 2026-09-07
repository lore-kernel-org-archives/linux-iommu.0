Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B83CC9E9
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818213; cv=fail; b=DvcKmyLfm5T6BsuDSYz9oMnIk/6eGXkEoNqcydH8Bo5JYF9UYK1O0WKqXi5IE+i+/8tqYCjH6HQA/w53ECA0S5dLmzlPGCTnVOEfNJctgyiqu32h6B8dcBCXic0Ifbc4CWQI1FRTEq6fRos+930UG85CxBcMR6nRpiIK42x4PHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818213; c=relaxed/simple;
	bh=/t0v3tKcAfvEQ9jVObat2LFb+pZBTHBcs+7/VBGnSQU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzM4gavpQbexBezAr37WXNID1Xg6iWY2P0MXUYdHre3ws11GEOVsgna6eVDfQ1TI2mNTQG/d8H76HM+WEk59/qTQjVOnJe4/vxmtjFVLCqx/0+di0N9addqFC5bLAMLGlVW8mxPlDjnHViUbh9scmPVsO8UNFu5pCBXb/DlhEwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hAiQUdkN; arc=fail smtp.client-ip=52.101.48.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hAiQUdkN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUgZ8VIgHvN2p7VYrst05LB8VYRMjgHUbrrtNWawdmgiV9evxMbFGT4lZFfxKDQZekjOYwAwTzTncJmmAyd00WbUCNiSchmLvs5fhFzhS4iLeKWoJdx7KHR0oDIgfcGokEfwsC0tqdiJZh3K+SVOjMFkFLqCEqiUxIgs7IC0oUDg0N2dKhsQm3RaikWEcTv/ayi4wVR8CVDCu68HbHZhQdpkgpr+220cQ/oYQ59Iiu1zSjbF0cjMjgItGHzoazeg8E1tVFXAy6CoGluk1O44xN2KW07Uij1IwZ0Fab618bC8Tkuwmsm4XO/M+Gc+H+9IqsHmrhfvAfQ4vO+Z1q5I9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v40ONGwGK1odTrzT/SeSukYXQkCgxxciNXn5WMOKaAo=;
 b=evEKT7UfZYJcAaX9a7kdVDulgTERPiN/iVTmnEs00ep3mbhit5LS890OZkpdmRS0p0VI5Zix01WRwISgO1Rku3vTu9HxTI7A3+6AOefaYeRSl9EPJ7WtGboSYDb+K/sUgapqAOTqlW13YKi/o2Wi2jTvWjTFBjd+fucUi7PdJe9g6FuleVWNBNefr02hZe2IGllLIQGxUcLTIWgzH7Fcq+94aicFoKhx6D4U+vXwncORqj+C7wUNk8A0vEu8HCb+tvCezr5JBW3IXY1K7fT3N8zSNwd+7UzoQwG9HVw5BEwktZIfnjx8WL14o3qxk5VqOZJ8BjUxixAv+Yha7mVixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v40ONGwGK1odTrzT/SeSukYXQkCgxxciNXn5WMOKaAo=;
 b=hAiQUdkNqRo8/KdDBYuQy15TqEr3u6IWiz0F46OR2TuAkDm908bTdsvdGzzP1ykUUu3yuiKw7RH9KGAe1Uhmvt2Uh5a+8g/aFs8jdLU0XbHMucqZn51d2He+1rlOaI4Fc4HvEaw1gaNa5iavcvMXAVtZutP/8fpWZdqlKUHvpBZhlP9NsvoMBdbUTW709Mv4gxJsRwDTzZa2bLkn0xnDMH37Ao+R/UPXFo4bhSMSF8waVYgyiIF6xfuPZZOVm4S+bOnVD036U9n/9B87YgjW3A0SNSldE4LyyKZ/a6F9JTOuuM3lZpdkoWgPyiSCj2kcDGLhCbSWu27qdzRRIf6gPw==
Received: from MW4PR03CA0207.namprd03.prod.outlook.com (2603:10b6:303:b8::32)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 21:56:41 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:303:b8:cafe::35) by MW4PR03CA0207.outlook.office365.com
 (2603:10b6:303:b8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 21:56:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 21:56:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 14:56:30 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 14:56:30 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Mon, 7 Sep 2026 14:56:27 -0700
Date: Mon, 7 Sep 2026 14:56:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>, "Pranjal
 Shrivastava" <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	"Thierry Reding" <thierry.reding@kernel.org>, Krishna Reddy
	<vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Kyle McMartin <jkkm@meta.com>, Usama Arif
	<usama.arif@linux.dev>, <kernel-team@meta.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] iommu/arm-smmu-v3: Add a cmdq_max_entries module
 parameter
Message-ID: <ap8zCvk8zUPZAJpH@nvidia.com>
References: <20260907095835.1233352-1-kas@kernel.org>
 <20260907095835.1233352-2-kas@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260907095835.1233352-2-kas@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: db40b927-3502-4567-c0eb-08df0d2ae648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|7416014|36860700016|10067099003|6133799003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GBNXHkjzzXefbtq65V+yXgvCzc5D+iTCMmmy5ZJk12E9gjx/ZJod3vqaMf9wL0b/9L5HglvVQp2BiZfbaJa4KcIuv8t0InmWvRQRbTmvmTOGAMkT1hRIz1KfGsjAB+meE8K4pB+SfIW0BTc3IH0PVGL7czU0LAmbBoAf4C9tjJCszQ9rd98/0sftsZEesCmPYVdqMlPWXQC9sDSZXqGlUlS6EQ4/1p7tlXkjni3ira5jb46r2KtIQlvKv02tFJ17meUtAI3qLYcJTVEzpVF3FhFX0H1wn9bCydg7nv3+0DlCE7TRhPzDeAHVkIzVrPOvuomFYKpyaYsP+X7IMZJiYCmEvKouy1H6gqIsao6zdsTL8m9y7lYTx9L0Tus5CN5H3L4PYtub3cUewCugD4pILXTOTS32BUCWr8Wus+/c2PSGQZ1/NkylDG3j4lwkeLfhEGJCE/MPJdQnEaVqlW0LCOlPIo8FQgM4atQZma9NgtzXXZDKDb6VxwkJI8KgpSNThvB1Jao0l0NWBeX/jLtR+I6n33XQB5gWt0dMdzXPr8oCnMs2s3EwqOqjskkKX8GknEuThS9bt4nhlFKqGNVDv2nFMzOMRij0FcTyVJzhh19r2yO8BoyNjFWw3UvuCh6CQyfueUoUSniQwukh4HQ8X5aE+KQhGsQWp8V95Ug90QVGIBgo8ykg7CqapPpgqrpAB2wGAFi22l5aH9f+djFY/w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(7416014)(36860700016)(10067099003)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QoKLLn70cqciB5M3IUPp7//9ejYjN34UKhBGDhgG/EzaHwW/DQWTBXitn/T/bFfM+3TxXdEqiysU0Fp/DfmN/OPvns98JGoTI9kP1oZmnbxmRDUpBEmK4gzvdzzEtLdAj0+1ZTTi0s2YqpNrh41ARbmXmYq5f+ZyGOAR6vwts7F0PDNzRuwe52TYLik41HqEwZrG9GVS8No4K9RMGt/I5w7OBq3uGVOxHng1f7Km+node7QogscaLc7Cz1LyoYaDwyRMNbHuEgn92rwkqV2icmA8gnv5YmBZj1D1LV18a4OPfUJnwvy1+GzzCbJBpAvEIYc81tO/kPZE1MyUbWinrEU3R8EO+S2Y58DXafAt+8VO0gNXTCr92cA32pj4l/WcGT+Gqa1jDOW6mGOF6gd/QKd4mqp9B3M1x3MXRW/4nhYutDUrnXMcq0TJ0LMQ+sgL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 21:56:41.2961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db40b927-3502-4567-c0eb-08df0d2ae648
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152

On Mon, Sep 07, 2026 at 10:58:34AM +0100, Kiryl Shutsemau (Meta) wrote:

I still think that cmdq_max_n_shift can slightly tidy things here.

> +static u32 arm_smmu_queue_max_n_shift(u32 ceiling, u32 ent_sz_shift,
> +				      u32 entries)

Here, all three inputs would have been "shifts", instead of two
"shifts" and one "number of entries".

> +{
> +	u32 floor = PAGE_SHIFT - ent_sz_shift;
> +
> +	if (!entries)
> +		return ceiling;
> +
> +	return min(ceiling, max(ilog2(entries), floor));

And I see Sashiko keeps complaining against the ilog2 here:
"
Does this trigger a build failure due to strict type checking?
The ilog2(entries) expression returns a signed int when entries is derived
from a runtime value like the module parameter, while floor is explicitly
declared as an unsigned u32.
Since the kernel's max() macro enforces strict type compatibility, this
mismatch evaluates to 0 in the type checking logic, triggering a signedness
error during compilation.
Should this use max_t(u32, ilog2(entries), floor) instead?
"

Though Sashiko complained about the min_t() in v4 as well..

With cmdq_max_n_shift, there is no ilog2 and no type mismatch.

If you can address or justify the Sashiko finding, I am fine with
the cmdq_max_entries though..

So, in either way, the patch looks good to me,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>

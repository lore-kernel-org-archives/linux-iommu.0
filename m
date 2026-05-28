Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A173203B6
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780004664; cv=fail; b=o2RwcdO+Rc1tJcaZAGFVZ83eBrDLnPe+UdocezifdZTLVGakG/epiNs7ByFuKbJJIMF9ynIhVAGdaXv7mfenvsDlg9m2f53pm5YN4O9sRI0sNlRtgYujnTZ79uwFh1YMc6/5JlSMdr4Vj3PUuT6oggOfMKbWJLlW/5Wf951ehyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780004664; c=relaxed/simple;
	bh=e2R4QbjcM1xPzezwWBu4k4Brq62+FVgOP11yvXUCbU4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NG8pFgZ20jd8hddBkOFld7BqbkHWD+Ne6mT+suBxR6fJghHtRLLGeDnc1dHLaXejZ25v8rQFXZ8ozcuDFr1qddT+J8iVQf4NDm0wbAbutA5atBSvGzhm4Whb95++FyijYv4uDup113yO+QGHMLj9cC3DXRHXViyZCymaC5S4gbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p/Aau1xG; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p/Aau1xG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ok5AyWEXDiasKxk9In+ar0mMrsh/agN189dmlhM6p6StRMo67orTIG17kA9THlp0ZXbcmvJpFyjc0sf2As77Ie5GGi3w4Fi1R8xedWIOl1FpKjHwaPknjhMj7OlxQmMxQule87AxYHVPXo9fpQmJ7wikLitwAcmQjHenL77NljTQdNtPwl0rHfyhp8xE3bwCLWFV+U5Ns2EnKBiK9YPc0pEGPnxXPZrxp7+tYsIgmqbNWwdGwLSjHI60ZLIobpo7xVNpp9puSmqn6qxPQbJ1umGDP/oGoFfRA/lrhwiVZYrMo4h6FpsgOxUMwfFjyGGHAl6nx078PHcAqAvPK61DHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXgfN63biCel2l/bUT+4xw7uN4jUaEpZaZ2o9G/TRb0=;
 b=HX1RWI3fK83cX5P0WqXDPg/omNxtxbuiEIR1avYqElw0iF04OTmGePksOGiBKn8a+VkuEL1nycMrDmMitLL+IbgUTQPux9GoIbGZOOjQfHaRzBOWpq+NfXXA2VGkIO85eSMMhv0yqGMfszGWv/wMxsLJXP5yv4dcGUrcdwcYT87RQvk/exXNkBBpH0z8FpNFVaXeVMM6yDz4494cr0F3xZfNIAG9SHrRW4+fKi4DXYS/4+aHl1NKSzBgoD31DY1frvt6Kk5d1qF8R+9HmbS5tFi/CEdciItD5+Eu3Uchr+Q+w9oIQoVPDYHKoNKSzohI5by6juTkU71yltGeow9Abg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXgfN63biCel2l/bUT+4xw7uN4jUaEpZaZ2o9G/TRb0=;
 b=p/Aau1xGlUE9Gbg+PeV3ZC3j0DTMoNuqq60Y+XrdjJxlf4MkZ3bDeY61liSXW1NZxeqptCysWELLd4rMqEI1mFDyssW4Np9+dYIykklir8lBJj/96lkxQIW3V9REeB9yrSWoHapstQgNIvE0YNwcuTqNctErte7r3IkkBIgb/3nBNE/Mrp24y0EIfluakMtplP62PgSdcdA0EhFMeQ1KucsrswRmlCfuShPkbyCFj64xONs1OipkmN0TBVyFcvMQs2t7xAxcOnm/j+1r0ZzxGaD3zXBf4jQvbhK7e4T694jGHxQHTG7BMtP3fiZ6be3qN2weRRnA2ZoAUW+tLQp+Rw==
Received: from SJ0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:a03:39c::21)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 21:44:14 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:a03:39c:cafe::ad) by SJ0PR03CA0346.outlook.office365.com
 (2603:10b6:a03:39c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 21:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Thu, 28 May 2026 21:44:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 14:43:59 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 14:43:59 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 14:43:58 -0700
Date: Thu, 28 May 2026 14:43:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 11/11] iommu/arm-smmu-v3: Add KUnit unit tests for
 Runtime PM
Message-ID: <ahi3HYssUY9mjjbg@Asurada-Nvidia>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-12-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260527221407.1756491-12-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf46bee-ba95-4a8d-c0e7-08debd02431f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|1800799024|82310400026|36860700016|376014|20052099010|22082099003|18002099003|6133799003|3023799007|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QOnqmh4OSRBPc/B3b4TtTUpEHhNBMtrHftPyXntsFjQp3eDolVj+Z273P9EM1BEpCdVRZ97hZ9sOer23gLVCCvGphRO5pvyUvirEsZUc0aHlGF6rpBLPZZCBQ8oeSrrq4scNyXqM/KhX17w1buGLLWQidUe4ADYzImWCjgRxYXyiOnjDm2stPBnW56NLYMBsSCTJrP+jdD2pPGey5D3IgrNYn1w93npX/b52FSQQFHansSl6tcBpO6nMB/TztnijCmVxaeDZDsF3od5rAgkWfqH1gYSYnXwYjlAIVCGq1ZyTPfgb78ZiKh+6HbSDvKdW4TSNku0J43W3K0H01mM6cGgk8wDQowEJCp3c+54JfsOk1lP4NdhNArYU6btolIk4wDpL92v8cLBiRP3UqlrS+Z5n82mm15bfnMNpU/HNVw+QU9heHusG5RJjWuW63Xrm+4xw/Pk9inKAlveqsQUNycg/sPl8UfTJlOd1PRylDDe2SBqQ7tOHV/7QQpklFbbKy+wCaND/E5sIZxmlsS8PMDB2HDtHgTovasnjZO9p6xZxGFAGgD5sm08fs76YdPU3gI3blN8++nGwfpk3201s4fLZeWji8968h3Ck54jcl6tPLkxOvwWGZ7fPFL3xr7V9gHR0jIjhQGtBMDv0RKz8wkt7wjFNGI7+ZTvpxjqHCRzjHeUZOLvoqpJiEWiuggxdfyWrvQZjn7T7Mg2SmPXY9Qjlw8PX8lE888Dr0kM3aWM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(30052699003)(1800799024)(82310400026)(36860700016)(376014)(20052099010)(22082099003)(18002099003)(6133799003)(3023799007)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iBAGddx57ViJHvpxozySh+BTxOWrtaoG+qh5sQkyYYRvYAj0HErCO07rlGJxbzjMR2xuKMQRX7wBtPxAYckkeU+/d+WZfZfiE8SOeJbfw88xsLZAiCUheeqWWB/X9+p+LYFh9G+O1Q9ioC+dzNPsw1eP0cH+iFS+m6QT4lZFg2ZGOnfbilSYl8P2KE/OIaOGX6ytpdpuLLcyHAna1qaRW3Lp2WnK0ANDS4+luBgbaCMkFaxsPDV+fZGtWcvXbrTM25wGpTeGi/4faUrosLTWVvV+oAANXBD4FCY8i8OKAlpCx4JKXV4m5hNlgoJFygXngmKMn9XQ01sdvzOnHhV6N2dh2kA1KWYmZwYrZZYQsMh6tEnKsa+cQEzsd3ql5kreVwCTfXIkfY0jHuf+EVNZ6iPWcSYEtJyMqb1Q7uZk80V39K0yUJPmOWKGV6eMPhXS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 21:44:14.5421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf46bee-ba95-4a8d-c0e7-08debd02431f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363

On Wed, May 27, 2026 at 10:14:07PM +0000, Pranjal Shrivastava wrote:
> Introduce a kunit selftests to verify the Runtime PM elision gating,
> post-suspend elisions and progress on resumption under active
> invalidation load. Simulate concurrent HW suspension using a timer.
> Mock all HW registers and CMDQ buffers by allocating them on RAM.
> Make the mock CMDQ self-consuming to avoid hitting queue_full scenarios.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Maybe I am wrong, yet this reads like an entirely AI-generated code.
So, should it have an Assisted-by?

Documentation/process/submitting-patches.rst:637:Using Assisted-by:
Documentation/process/submitting-patches.rst:641:you need to acknowledge that use by adding an Assisted-by tag.  Failure to
Documentation/process/coding-assistants.rst:44:Contributions should include an Assisted-by tag in the following format::
Documentation/process/coding-assistants.rst:46:  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
Documentation/process/coding-assistants.rst:59:  Assisted-by: Claude:claude-3-opus coccinelle sparse

> +struct arm_smmu_test_pm_context {
> +	u32 *mock_prod_reg;
> +	u64 *mock_base;
> +	unsigned long *mock_valid_map;
> +};

It seems all about cmdq only, so maybe:

struct arm_smmu_mock_cmdq

?

> +/*
> + * Shared helper to allocate and map a fully functional, self-consuming mock

Is it really a "Shared" helper? I see only one caller..

> + * CMDQ. By redirecting both prod_reg and cons_reg to the same memory location,
> + * every producer write is instantly reflected as a consumer completion.
> + */
> +static struct arm_smmu_test_pm_context *
> +arm_smmu_v3_test_init_mock_cmdq(struct kunit *test, struct arm_smmu_device *smmu)
> +{
> +	struct arm_smmu_test_pm_context *ctx;
> +	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
> +
> +	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, ctx);

This ctx struct isn't that large. Maybe the test function (caller)
can put on the stack and pass its point int than allocation?

> +	/* Use a standard 1024-entry queue for safe word bitmask alignment */
> +	ctx->mock_prod_reg = kunit_kzalloc(test, sizeof(u32), GFP_KERNEL);

Is a u32 allocation necessary?

> +	ctx->mock_base = kunit_kzalloc(test, 1024 * 16, GFP_KERNEL);

s/16/sizeof(struct arm_smmu_cmd)

> +	ctx->mock_valid_map = kunit_kzalloc(test, BITS_TO_LONGS(1024) * sizeof(long), GFP_KERNEL);
> +
> +	KUNIT_ASSERT_NOT_NULL(test, ctx->mock_prod_reg);
> +	KUNIT_ASSERT_NOT_NULL(test, ctx->mock_base);
> +	KUNIT_ASSERT_NOT_NULL(test, ctx->mock_valid_map);
> +
> +	smmu->features = 0;
> +	/* 1024 entries */
> +	cmdq->q.llq.max_n_shift = 10;
> +	/* SMMUv3 commands are 2 dwords (16 bytes) */
> +	cmdq->q.ent_dwords = 2;

CMDQ_ENT_DWORDS?

> +	cmdq->q.base = (__le64 *)ctx->mock_base;

ctx->mock_base doesn't seem to have any other use? Why does it have
to be in the ctx structure?

> +	cmdq->valid_map = (atomic_long_t *)ctx->mock_valid_map;

Same questions.

> +	/* Self-Consuming, prod == cons always ensures queue empty */
> +	cmdq->q.prod_reg = (__force u32 __iomem *)ctx->mock_prod_reg;
> +	cmdq->q.cons_reg = (__force u32 __iomem *)ctx->mock_prod_reg;
> +
> +	/* Initialize memory indices */
> +	atomic_set(&cmdq->q.llq.atomic.prod, 0);
> +	atomic_set(&cmdq->q.llq.atomic.cons, 0);
> +	atomic_set(&cmdq->owner_prod, 0);
> +	*ctx->mock_prod_reg = 0;

Arguably, mock_prod_reg is only used to test against a prod snapshot
so it doesn't seem necessary to be in a structure.

> +	return ctx;
> +}
> +
> +struct arm_smmu_test_timer_context {
> +	struct kunit *test;
> +	struct arm_smmu_device *smmu;
> +	struct arm_smmu_test_pm_context *pm_ctx;

pm_ctx doesn't seem to be used by the timer callback function?

Is it necessary in this structure? Even "test" isn't used.

>. +	struct timer_list timer;
> +	bool stopped;
> +};
> +
> +/* Asynchronous timer callback running in softirq context */

Would be nicer to replace this with the inline comments:

/* Simulate a concurrent runtime suspend event interrupting the invalidations */

> +static void arm_smmu_v3_test_rpm_timer_callback(struct timer_list *t)
> +{
> +	struct arm_smmu_test_timer_context *ctx =
> +		timer_container_of(ctx, t, timer);
> +	struct arm_smmu_cmdq *cmdq = &ctx->smmu->cmdq;
> +
> +	/*
> +	 * Asynchronously set the STOP_FLAG (Close the gate).
> +	 * Simulate a concurrent runtime suspend event interrupting
> +	 * the invalidations happening under active load.
> +	 */
> +	atomic_or(CMDQ_PROD_STOP_FLAG, &cmdq->q.llq.atomic.prod);
> +
> +	/* Signal to the main storm loop that suspend has triggered */
> +	WRITE_ONCE(ctx->stopped, true);

Then, it should be named "suspended".

> +}
> +
> +/*
> + * Verify SMMU PM Runtime gating, elision, and post-suspend resumption
> + * safety sequentially under active stress.
> + */
> +static void arm_smmu_v3_test_rpm_stress_race(struct kunit *test)
> +{
> +	struct arm_smmu_device *smmu = kunit_kzalloc(test, sizeof(*smmu), GFP_KERNEL);

arm-smmu-v3-test has a global arm_smmu_device to use.

> +	struct arm_smmu_test_pm_context *pm_ctx;
> +	struct arm_smmu_test_timer_context *timer_ctx;
> +	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
> +	struct arm_smmu_cmd cmd = arm_smmu_make_cmd_cfgi_all();

Can we organize this a bit? Maybe in an inverted xmas tree?

Also, it would be nicer to run git-clang-format.

> +	u32 stopped_prod;
> +	int i, ret;
> +
> +	KUNIT_ASSERT_NOT_NULL(test, smmu);
> +	pm_ctx = arm_smmu_v3_test_init_mock_cmdq(test, smmu);
> +
> +	timer_ctx = kunit_kmalloc(test, sizeof(*timer_ctx), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, timer_ctx);

The allocation doesn't seem necessary either. We use kunit_kzalloc
in this file only when the memory (usually an array) is too large.

> +	timer_ctx->stopped = false;

Then, should have been kunit_kzalloc() at least. Or " = {0};", if
keep it on the stack.

> +	/* Setup the kernel software timer */
> +	timer_setup(&timer_ctx->timer, arm_smmu_v3_test_rpm_timer_callback, 0);
> +
> +	/* Start the timer to fire in 10 jiffies */
> +	mod_timer(&timer_ctx->timer, jiffies + msecs_to_jiffies(10));

Both lines reads pretty clear without that verbose comments...

> +
> +	/* Execute the unmap storm until the timer triggers */
> +	while (!READ_ONCE(timer_ctx->stopped)) {
> +		ret = arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, &cmd, 1, false);
> +		if (ret != 0) {
> +			KUNIT_FAIL(test, "Unmap Storm loop failed to submit cmd list: %d\n", ret);
> +			break;
> +		}

As of now, arm_smmu_cmdq_issue_cmdlist() fails only on -ETIMEDOUT
and spits a print already. So, maybe simplify it:
		if (arm_smmu_cmdq_issue_cmdlist())
			break;
>  static struct kunit_case arm_smmu_v3_test_cases[] = {
> +	KUNIT_CASE(arm_smmu_v3_test_rpm_stress_race),
>  	KUNIT_CASE(arm_smmu_v3_write_ste_test_bypass_to_abort),
>  	KUNIT_CASE(arm_smmu_v3_write_ste_test_abort_to_bypass),
>  	KUNIT_CASE(arm_smmu_v3_write_ste_test_cdtable_to_abort),

Usually we append to the end. And following the naming convention:
	arm_smmu_v3_rpm_test_stress_race

Nicolin

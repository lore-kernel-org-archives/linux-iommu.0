Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011001.outbound.protection.outlook.com [40.93.194.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEDC33BBAB
	for <iommu@lists.linux.dev>; Thu, 30 Oct 2025 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761864149; cv=fail; b=pqOI+0IS80Svv2HTRNAejGfFNcqFeeTTsrP7TSZayHt1h5QUbA6sTnYIe4UM6gXx/HNMoGUS7YV/oZp8sShV8eCl5YVtjxRx7k5kz08o7InBjZnCCeYh4b0hGHSVAd0zqwzw/bTnqGEo5yE1CBVTd73ivzOV2QWPiam+O+6Gi3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761864149; c=relaxed/simple;
	bh=PrvEagOX0Q0SMtl+TZqqObIDO+wqZM3F6zKzKDU6uHY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZhBlphimtd8m+50ag+VdqjIDJpvzwt245G2fBJCcANypy1nsb88hi+gmIUdDMa3j4d5NWbVA/9lncvoBXa7hlFuExiTzi9j0ckES6WLK1iTc7xG6Cj8TQW4AVYqpeWfAPq6V7RgoWB8aTHHdmrpdASow5BilEHrX735L0vBqA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PzWUFnNl; arc=fail smtp.client-ip=40.93.194.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PzWUFnNl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPgmbzXQhUuGzjA/Ac3HwCVRdSNvnxRaekaS8Qh855X925QBrzx4+NwfqvC1ZTqYsOEhhAqdnji/2U76nF0TNIgBJCxDQvtffKuXGiD7gTd6KlY0FVuCV92/PclqQf8knPloijcZFdtBxSaloLoJonTia8mUMqKjbG734xTqrz13lLOM2R8+LdHXNwp/AGfjHhm942oYZDup3t3YQWvpXqN5R+s3eUCryKo+sbQM+nsmiiDI8aozMMvBAQAdIKkGZoDvwWev9hIWe9zPQckJaQUIn3yDFjQwmA+IyY9jcLl36L6BCI0/muOZDo5Ta+oGFcIXz/dCSQ6C4DUpO9sclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kv4Te56pCH7l+oXEc4rZPyB3bnBlm29xro+k4MES4s=;
 b=Sz6nzWJQUri3fS3xTLyUsKZ1RUpdubrK3FefN9HRENS/lJR1vhdlEyhl41aCRwx1VLL+0uiGm7zsnsIeVu/amaKWtxx28g+6Gj508JfAYvX03YTG+xeYFUi/iP0Df73QdHPFctr2WcJHT1lHv8ULfGeUQ7xp40uIwn8yMon7wdqXDuM1CmXiKfqhT5b6jXe+YGOnLqwjoeGk/Xcq4s8gx2SRvUtrNB7N98njBkdpK9aCwxr3B6nDv4o0rSATwsXsHX5nO8hgBgR8fwQG+5TcE2FlW9EUWG9R+nWH/w91hTpz8jUMliAYwRU07DZC1TZaGghVlIC9fCif9nB07pcvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kv4Te56pCH7l+oXEc4rZPyB3bnBlm29xro+k4MES4s=;
 b=PzWUFnNlGMb5W5y33DpqzZUyW1QizYzEtObZ2SoYbQxETBEqCB4UjQ1vhNnS1beo67NRdtDulnXeH/Ifp9EI4FKgVNpwxCnonznLXJ+NRI9LJzXlq5zOulxYlr2PXDIm0Om8PBUiwwdehFlpmSBIAaQCqQj0AJjHItaZfGJ29wMrG5XvolSl5S9ZGBOlt+HaPaugFuSV5MioXn7IQX4GmCpfpx5TexZkDV4rO9DDT0ovUXdY06U8ppzkPybPfiCnxfqEl7jI8tjxAP+kZ7Th4ZO/gx81DHTDOYOGbVdaf+EI2j5bT2gG3Dr9Y7dHgjp8Bklm4grmPQ074xlkspaH+A==
Received: from SJ0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:33a::14)
 by DS5PPFF2923D4C1.namprd12.prod.outlook.com (2603:10b6:f:fc00::669) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 22:42:20 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::91) by SJ0PR03CA0009.outlook.office365.com
 (2603:10b6:a03:33a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 22:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 22:42:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 15:41:59 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 15:41:59 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 15:41:58 -0700
Date: Thu, 30 Oct 2025 15:41:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Yu
	<zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
	<jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <aQPptXsqzt6kJS7f@Asurada-Nvidia>
References: <20251020224353.1408-1-jacob.pan@linux.microsoft.com>
 <20251020224353.1408-2-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251020224353.1408-2-jacob.pan@linux.microsoft.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|DS5PPFF2923D4C1:EE_
X-MS-Office365-Filtering-Correlation-Id: d39d856b-5eab-4231-532d-08de180595b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5V8qEhRfUCsgnXInCD51ILWAdInzbkgcuvRsVbOOkcEwYV3MJvhyTSNsxART?=
 =?us-ascii?Q?yZlWEJcyPj3w0JmLJHwmJ4RUR3mbCn9YljGObSD1vKCCVgkX0a2xD6++nxCK?=
 =?us-ascii?Q?3if6PFV7qXylLZfb4RG0xJU3GJVDNx3aYC9hT/ZM8OQ5SEOUelAa3YeFG8Qz?=
 =?us-ascii?Q?I67xLBC+owyyxe9dWmIyOf2npnTH2RGrVCoXKu+C6ihVq90M2kMYHWqdfMhi?=
 =?us-ascii?Q?Pke0Q84t62yncdFG4ldXuqmNPzCQh2Nydp6wnMxHnMXwUwp1lUc3UR45ZxcD?=
 =?us-ascii?Q?SK7eGTjvdOzN4GDcFHA5fWvdOMwAjLXcWDbt/ZS8pg3yvwZqxLP5bPxksF7f?=
 =?us-ascii?Q?HRQ6VKlUee+/g+6Kj2dVP+h7H4bBby688v1BaBCBq59iu8XCluh6xhb1xNiO?=
 =?us-ascii?Q?D59BEkDjzMxENbD97sEkD4r8WKzmvzzMb9RLnT4faQhSulbCFzXpebYDCZPA?=
 =?us-ascii?Q?A+Ws504zVDjLyPZ+VBDsqzLMHUapq2klHcA2bZw2AYFi7YLK6v7QMAOnbUwF?=
 =?us-ascii?Q?YgYFOfjDRCXx74shNKUj6aLkwXObsYbVRGHUxKTFbDzRd8PoJi8lKemP/ghE?=
 =?us-ascii?Q?5n/Psz2oOtrp4JlNoT3JSZ+Xxw7qk4T2YlV0mtvlimLlPBBbU9qLdWGfVSd4?=
 =?us-ascii?Q?6KwPjTurDu9DDOuOvhN7YZPjJn/BXRFX3VQ6o+oV+wOI3dx7zdZxddVxcegn?=
 =?us-ascii?Q?tiUDATVThS7u2Z1wI0GjJXsgfQ//HTD4L0WpDMGfz0JTSKW4vWDa+djy6sqE?=
 =?us-ascii?Q?CpT16rSV2xLzezC19MiVmvz6xi/k23bPwYjg/1rVxZkERL0+fJ5yR81wlPYf?=
 =?us-ascii?Q?Rb1a+Esp0RenC6sbjgVBFkq23mmpCp+EEzn1Pa+oKapcUyJq2CAC88IJmg1e?=
 =?us-ascii?Q?ZzmNcEEVIsIPjyF72oWoVIhAsLYVVd+w07wNjTpiKdAgo2zyCvSbzo+k7Kto?=
 =?us-ascii?Q?motPTuBJjrkEJ/CVfIlY7BJq1JDA4yft0t/LVc0D7usOElp2OSsPC8oHmjhf?=
 =?us-ascii?Q?aOcdjKdt9tPCnQRvtIDgAZ7K9eG+lMbRv3n+QkQCff1v/+7IaU1v2+G36H7w?=
 =?us-ascii?Q?71/pudZzx5LNv9NpNUr59JpedB17K4AV6lQONO414V2PgHmj1Pf1fGWAmAU1?=
 =?us-ascii?Q?B+o0UdiQEbt2Cx3SN2+W94q93ZFbYmwCOXOtIQmBRGUHdxAEEv6RqW2QZHB/?=
 =?us-ascii?Q?vgReu3Gfj8pLGCb3s9aIINrEToPih6QK9L/8QR6/OLVOKSaOHqoY4WrJsz73?=
 =?us-ascii?Q?l1sGxWYMJSBentASTZPj5RAEqbk2AOicDEkTfh2kwPRwF4ou0IXnLxPu7BkP?=
 =?us-ascii?Q?DoDLz5yAbnoAdYOh/yzpZPFnzRE3odJogs2AE2iq9GKWi8ck/2D0m0UUfv7B?=
 =?us-ascii?Q?5hGcBrvraWdJrxFwVhQAvhOiRC9VagbYXejOcU5Y8Flig5arLgqkTJJY82tl?=
 =?us-ascii?Q?d7SCWHE4JIpA2ef23o2FKK6s+dy1GynU/LiGS+pzn13V9Ljjhxw4kPH0F0df?=
 =?us-ascii?Q?bJ3TAKdAprpJ/2PftxGaLUPjC+7lyfc8eR4QbF0F7TsyaUbX774G25tVtUsy?=
 =?us-ascii?Q?RvYdNstcY0RxXYUZ4wE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 22:42:19.8061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d39d856b-5eab-4231-532d-08de180595b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFF2923D4C1

On Mon, Oct 20, 2025 at 03:43:52PM -0700, Jacob Pan wrote:
> @@ -785,10 +748,33 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  	do {
>  		u64 old;
>  
> +		queue_poll_init(smmu, &qp);
>  		while (!queue_has_space(&llq, n + sync)) {
> +			unsigned long iflags;
> +
>  			local_irq_restore(flags);
> -			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
> -				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> +			/*
> +			 * Try to update our copy of cons by grabbing exclusive cmdq access. If
> +			 * that fails, spin until somebody else updates it for us.
> +			 */
> +			if (arm_smmu_cmdq_exclusive_trylock_irqsave(cmdq, iflags)) {
> +				WRITE_ONCE(cmdq->q.llq.cons, readl_relaxed(cmdq->q.cons_reg));
> +				arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, iflags);
> +				llq.val = READ_ONCE(cmdq->q.llq.val);
> +				local_irq_save(flags);

I don't quite get the reason why it moves queue_poll_init() and
add local_irq_save(). It's quite different than what the driver
has, so it's nicer to explain in the commit message at least.

I still feel that we could just replace the _until_not_full()
with a _until_has_space()?

Nicolin

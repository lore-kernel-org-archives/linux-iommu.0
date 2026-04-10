Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A741C71
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847152; cv=fail; b=l0Pguvuhy/emyrnRZ3yUCNXSpZHc5DcdmVmA3gZBKMEnOPU1RhAKz4dfVzknUpKUINqomY5QuKTG0RA7+oDF/JMhKTgXp0fpJsbpBDulWX0LXaoOgRuRSFQo1txM7v+G61BTFGc3yidmc9M9Ed75+DYnb6yc4Uqh7qlgknKsDYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847152; c=relaxed/simple;
	bh=bSi7mfKOy1pluSaDFX3GDc7X3/BkgZdo77nO+isVugQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWP0hdPrWrlbHRUc84dshYruPfKL5j75TnIpau0ZiKbpV8RZA1UrDDxlXttPdgEWf+CEaiVmKvzapo5g9QlD5X+iBndnT66dYyRgn5sD2ToW0B3SY+a6uC8JQWyEP8K/RQDa3IHyfg2npAzwJIZax5bV1QUO0o3peuMclFRsoLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KYBXPDIA; arc=fail smtp.client-ip=52.101.53.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KYBXPDIA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTeeX7D6HzAsie/oZ+tnFQzNNFMlV1/6ZhHfNWGEUnBxYhz4mtbD5yw+28RuTzdEt5alcqF4layGoHlKLNUwmZdVROxke/ERj8pOPTM5MX0oRZeuL+WGvQAH+/oSdpXWU0vPsrJXV+LAZwCNupmQLaBALPbdmmENhxNEZxh37wvgZewoMQ4+C+CdTaZHUyFKywd//O2/gAilN5wyXI2UN/Rm0WticgguSSUUr+acAStTMm/m9/hQwzbDCYMTI7CPdWVwq9BfSyo5HmU3AyL/9zNusUlmpczMyt4lpJr7qbKhxASrdPI0We1whPevRGFQtwL/oOIpDH4KGIGZ/dUiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6+TjvvR3D3VhzQM/y8dlB60anVcqwqs0oyCKUYVjwo=;
 b=SVLve5s5s2jLxsJOkVuElsbk6mnGYEObpneeDTXpojXyzK8UtwuS0rCqo+rgfsAdW97fGW4rI1KXg1ZL6w8MCAASDOyoUfN4C+TgMLGaqkCyEcP8Q3aEel3yhMnnRc1514PpsBMaY8KUv02BqhjIWV+gYhcJlCWTgT7kKTPODHDFCyyetHcDcm33tAsJve0JRwCxKdc466La7OY1P/R5Bd3A1q+Dskvilw8/bGz4dpqNJKcJPBkZh55NeH9TjZVyjFPbW4QEI11QSLnQxujNyMR62tdUsykPMjq++kEHVaN3sDXtIaEQU5hFjuu9cEOQaOe5JiOiVqoNpqGUGgHJWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6+TjvvR3D3VhzQM/y8dlB60anVcqwqs0oyCKUYVjwo=;
 b=KYBXPDIAsvV1QKI0dX1EsIi8EM80n3EIjj6KPtvBTxp1UXVbtqQ4psxPIMIoA4DYFlSyTK1oZlR/Lxh8kisHouV5KYr1LwqdSppJHcMX538ITG/ZYU2h7Tfc9wc58wS8ZYfPYDUupoPpHrhTgwN94BALo0Sl2Wc1jpIMaKsoKQwza9X2ZI3N6gDyRC73PUXgLHbt8FSxY8nLKVs8A8QrXd+mKylh5JA15RnBcCy4x9ETlLaN5qkhnjt+PNblB7J7Sjez/0k2mMxI3Td3iw+ZftDykWejdJXb/ZsAjsO97BlnHYVUUtzZq0UqfdExMzgOr4zg/69R8i0f4dQAMiY+Cg==
Received: from DS7PR03CA0251.namprd03.prod.outlook.com (2603:10b6:5:3b3::16)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 18:52:23 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::70) by DS7PR03CA0251.outlook.office365.com
 (2603:10b6:5:3b3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.38 via Frontend Transport; Fri,
 10 Apr 2026 18:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 18:52:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Apr
 2026 11:52:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 10 Apr 2026 11:52:03 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Apr 2026 11:52:02 -0700
Date: Fri, 10 Apr 2026 11:52:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jpb@kernel.org>, <praan@google.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
Subject: Re: [PATCH v4 03/10] iommu/arm-smmu-v3: Store IOTLB cache tags in
 struct arm_smmu_attach_state
Message-ID: <adlG0QTAzdh9vA4M@Asurada-Nvidia>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <ceb8150f229ee7bd355ec42d23e422ae2185492e.1773949042.git.nicolinc@nvidia.com>
 <20260409234223.GX3357077@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260409234223.GX3357077@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f7a7b9-7b2c-49f0-154c-08de97324cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	DUf+DcM8mfjE/TiCKExRZOSduYfsWlRakRABRIELcQDRs5bau7+SwuKm9wdOshrEcZvYRq2r69xaI1v9QqEU+EciZafAKM6SUAf/7veOqOUaqUG8oQKR/L/UmUl/5yjszc3CvC9ydoIGgam/byLU0zSkjd5KywsuaMOATJVos/5RSEPUdmHo+egctld781CBTg7sb/nEiu3xdKEk7sTsPCjkIU7igQqVdq3uf1hosGgiVPJEFzdNIjMdGo/sFDFybrBpHymx+YI6xJ+VcFRzy0atv71J+1f6/FSHYO8Z06TN1tZKsFLEjGCzHFL7BfN0OPOlCQFN7Nf4DsEeHJGBjo/lnQ+C+JBKhbDQ6VY875u103Vzbp6WupY/NpkF4XLP0979zTEz9HzBWzPgvGCDNR4MELn6FTVfV6vrMbKXdFeQOg3emxkp9XB5Z3S6rKlp29KhtMUR/E+NRGYFWVNQw9FcQ0lGMQ/cg7Ca6nX7g9zf7JigCGyRoB8mG/y12VNa/O6KUFcyx6fIT5DLYrbSSO44tCe7eTwJqEPIaD8fdX0+c74yjLgEjmg/G/vczJXKuhy+lIECjVUxzxq+63DtYeDGPCbyF/phsAv+5r9j/o5eKB/78JRaa9suY0VtWlOrqENmuj0vkeLj/22OGGkj9Hg9kGLAX0Xl0Eto38ZmkcxMRC0/f6wDzho1wBvuO3C1Q1t6nj4+oYUbTr2GBv0gjZu+z2gNZJ4C1VUyFc7ME9gScMF98GkFulGt9XPwEkK4M6KHQknPlKxdQX7LenGjBw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TZOAgE5qrIiA0Igx9vypCEarRhhs6VN1lbYGRAnV9BY8hRfPszPiu4UTyUnSGvyLmW8irkzzjTmDj9ELE0q7k3BfCfZ0lU7WpMd7Hsu7NbpNn1olfw+leBO1flc5Tp5TcD/FGp3m/4FFq3II/LI8/Veo2c5z26cNJSiohKgnCQcX47fxk2v1G+Bolztr7LhX+K2M9FDnedcMRKrhUx0Fb7SJvpjjjRX3KwwspDOQngYSL5WroIdH5MUSONQ1JObqeOhZhutRlzVRNT0Ksv+dnoznR8LLf499Vx7Lbecy/GJbERegDFhYLFENTDRPo0JpQnyl6dYHAjrwE5Sih41PFhaRdy65IwWchN6d22yfoS8lOZxCrsAPWGo1Q13sQCZ6ZoiazoeUtuwWBz3RuY+LAlKxuml0A1NhVxvoeYKTQaQ8fF3N8bhqcxd2A2+KEQUS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 18:52:22.6776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f7a7b9-7b2c-49f0-154c-08de97324cef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234

On Thu, Apr 09, 2026 at 08:42:23PM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 19, 2026 at 12:51:49PM -0700, Nicolin Chen wrote:
> > So far, an IOTLB tag (ASID or VMID) has been stored in the arm_smmu_domain
> > +static int __arm_smmu_domain_find_iotlb_tag(struct arm_smmu_domain *smmu_domain,
> > +					    struct arm_smmu_inv *tag)
> > +{
> > +	struct arm_smmu_invs *invs = rcu_dereference_protected(
> > +		smmu_domain->invs, lockdep_is_held(&arm_smmu_asid_lock));
> > +	size_t i;
> > +
> > +	arm_smmu_inv_assert_iotlb_tag(tag);
> > +
> > +	for (i = 0; i != invs->num_invs; i++) {
> > +		if (invs->inv[i].type == tag->type &&
> > +		    invs->inv[i].smmu == tag->smmu &&
> > +		    READ_ONCE(invs->inv[i].users)) {
> > +			*tag = invs->inv[i];
> 
> This users thing has become to hard to understand and it isn't how it
> should be.
> 
> All writers *with the possibility of concurrent access* need to use
> WRITE_ONCE since there is a RCU reader. IIRC that is just
> arm_smmu_invs_unref()
> 
> The one in arm_smmu_invs_merge() is just writing to newly allocated
> memory so it shouldn't be marked.
> 
> Only readers *with the possibility of concurrent access* should be
> marked with READ_ONCE. IIRC this is just the invalidation walker.

I added a cleanup patch to the beginning of the series and corrected
all the new reads/writes too.

> Places like this have to be protected by a lock or the whole thing is
> wrong, so it should have a lockdep annoation.

Hmm, is the lockdep_is_held() in rcu_dereference_protected() enough?

> Now what is the locking supposed to be? It looks wrong, it probably
> wants to be arm_smmu_asid_lock, but arm_smmu_mm_release() doesn't grab
> it.
> 
> But why does arm_smmu_mm_release() need a tag in the first place? ASID
> isn't going to be used when EPD0|EPD1 is set, so the tag can just be
> 0. Probably make a patch with that change early on..

I see. I added a cleanup patch.

> All the locking is important because this:
> 
> > +/* Find an existing IOTLB cache tag in smmu_domain->invs (users counter != 0) */
> 
> Must be held as an invarient into the caller, meaning the caller must
> hold arm_smmu_asid_lock while it has an active tag on the stack, and
> that should be documented here. As well as a lockdep of course.
> 
> From what I can tell the final result is correct (aside from
> arm_smmu_mm_release), just under documented.

Re-checking the locking in these functions and updating the kdocs.

Thanks
Nicolin

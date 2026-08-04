Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8247987A
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859509; cv=fail; b=nFIXg/LC3Gzej1zNCsiIv7vj5r4nGDWUf/Kij61SlmWfTgVxD6oOWedfqGMNrq/3t9mbQeaqX1BaLgB1qQKYSDA7p/exrdtL+mcrK78T1CTAvo/Pynb1ZA9kgPDoel1JPb6GjxCKKGtH07Q7QDpPlvuUgPo7U7nRbuW64Et7uGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859509; c=relaxed/simple;
	bh=Xu94NL5BDdyMa2Ka43BQvhe2ywctMdeqtPT69r6I1fs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/erf1vCOqtPjt2E5bi+14lg0OoT7o6EFY3hNTQzKegebhS8vBeQOqndn4pY/P521vIMfvrxnzBC4FUhA1F37sqGaGxz4IduEJI0rpHc/yNKbWxGnhUZyfrL1csvysR7aNmlQ6Qa/eSJPxrd8VPf/2bsz1U2C1oS/Pwb10ad6zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UGjaY/j9; arc=fail smtp.client-ip=52.101.43.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UGjaY/j9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SECgNKBRAtV6QCaM2Y4f+ArZQ9xm1Bs49svkSo8R9aqMdiBtb/C8SaYpLSERKzlKY1V9tELP+59fmPHkWFf+cLTI9oMlhi93kpJCJUWFQEfr/cKvS4uVbNK15OUUOX0Td7Oo6BXr/QPmtmChtwXasWfM+iToJ5YKSHkeyXS4azHXHQMzGZ8idy9nOjNUqpuLFzP6Msh7SS27Fq57XyV/MCWUw7WmybvAjLf2ZaPdVrN4d8ms/OLW64OlxBRKfcE+0TC0Vh0urZDrRs1mYzzms/qcYjxxBhAc61JgsIceC3VTd0BApSzTCkatWNh0b4Q+fmWHUKX0l9kn3N0b9fcL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRqLlqapn+nMCsfmcl46hGw7QCqLDFW7ZPwCTlSh22I=;
 b=yyz+b/pUDENJN8/W9Yns+T1vtQktzX69Bd+B4klf1DylfEGH5GcGd/AZKopaDOZDVWNG69FwoCin6Pi0ucvxx8i9gsS9Ieq0Fs5E9mN5O0m6S0t3FyxGvxgBiEoY9gwDGmKvxggZdB7iDILhAfGXiOzGz/dB+Ei4vml9UDNEk1ZLTfstPChpxfo7kXNzz1T0BJU8M12croW0ZBqSt4G7+KwawJVahCSJfw2xclCyt2R+g0BvSQb4wz5F2uKlDgRAUknxAX6d7cMn9RGr9y4RDPi/D49SB1PVZ0mG98e7BQwKbIn1uCs5JFS1C2KZB58OToJ/0Oeo/cD/EcI4gbvGFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRqLlqapn+nMCsfmcl46hGw7QCqLDFW7ZPwCTlSh22I=;
 b=UGjaY/j9s3qmGGYgIC50171jQb9AOWAhmRVsrKTOmZX9zLMWuDtrsiBY6L6Qv7724LPXcHcMagSixJmYEz3ycrSbpz677XOU9qh0Sbm0nt2MHFwxTepwr7viaHtTsxcOUku7CHldr53tAJvcHJFEcaSmQP/npMLc5KaFIV6VCch/6BIaudGXVdZE3k9MrQRoLZaTMk+YkTmiICFEKAQOKKCQ1R8zxu8KF3nySDfzvdjWbqExbudV1yhowr9ES7JM1v/KX38372D6c+hqc+8L2dpRJCb7j8GUPtIULJ2JlIaG65edgwolkqVgayHsGBgRRuBQx8nvKHkbQQ/eYeLBlg==
Received: from CH2PR10CA0027.namprd10.prod.outlook.com (2603:10b6:610:4c::37)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 16:04:55 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::22) by CH2PR10CA0027.outlook.office365.com
 (2603:10b6:610:4c::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 16:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 16:04:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 4 Aug
 2026 09:04:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 4 Aug 2026 09:04:33 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Aug 2026 09:04:32 -0700
Date: Tue, 4 Aug 2026 09:04:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, "Pranjal
 Shrivastava" <praan@google.com>, Breno Leitao <leitao@debian.org>, "Kyle
 McMartin" <jkkm@meta.com>, Usama Arif <usama.arif@linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <anINkO1l9Kz8lTVh@nvidia.com>
References: <20260706084708.8072-1-kas@kernel.org>
 <amiBagGKn-Aym1DK@willie-the-truck>
 <amiz6GQZ-XGlH706@thinkstation>
 <anHxBh-xGW9JXsa4@willie-the-truck>
 <20260804141704.GB27883@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260804141704.GB27883@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: ec89bdbb-f939-4d94-eb74-08def2422013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|1800799024|376014|23010399003|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	yI/pIp+G8VCclYG65djeywYiqR8qIh2E/cdU89OCZUIcaV6nlt62UtVpaVV+LXiNHg1Gg/Uj7kbokjSiYKZ96OiRgYXpVtqloP18eygPUox1+n/kPUb/f7Mh3Xc01DKuDxXGSX+/i59ohA73lFblorwJRG5FbFKNx/ds68vCIKRB4RK//6vm3/8L8fi0sXyRWjMJyDF+RsHQZSL3EuHuZH7/vXxg4FSMFthJESUjBO20Ty+/Jtoj6PEEX9HdNp/Y861J/haOdwwrQ/SobYmPVTjYkiM1rY5moLfKTzVrDYB/xOWfLMuJm7JnPsTu4a6kbvZVWKtHUAsroVjVpoOMVPp50AfaqhCxCBGodHj2NyyV4/ficKFh75435B4OrlnBWu/v13DFRHtjAoi3KsrQK+8WM0BmNje+07nDOjF19J22HOrMWZyiMViIR/hwHx717LOb/rddB6+D+hIcxC3Dg/yyhgn43bkar1orL5edb0/ZHxZh3nDs+YJk2H/YKbbVl0gdyEyrzC3ELXSytPd4D7J2lhC0QEZwyBvIAfKNeNZKtUxJPZCgaiyP+NSy6OAFoJz3pK3VKHzkdOGdnhWlhojE58M6s5/r564DfeZStRoHoVidOFD9/B3/kvKhCEEAowvaxgdcs+TLKZmIpLUfIQ2+LaN8ccSwmqi63tYp4Xt6/LMnnHeiruQSH/Cprs5DAM1P+o1eUxsamDKV2v14CA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(1800799024)(376014)(23010399003)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mbgP1TrCGHFwNEcwDt/7CwCD4OOBcfrEakJbU7PNTxLNvWBi9wyViSj1TfPAUG+cgu9jb6fsz33tFjhkmI5uSlMIOlG8OJA2VrsLb+rWDqcQ9NPRSo52M1omZsdcHWhYqTP2iht752NdRcDjOJF70IjvQ0qkiePDisl2cNe2C+zz+7JgdV8a06zaMZWagQhHu6vAy87MXnHhGAV8tmtGoiYt6FZFcYunBJliiTQ0nIoQknFjfWfD/t4ZH9NXlKqtYKQLGetSPjUJsBaqEOez3TWsRH9R/Apho41xbXjb9wqj7zQPlxlOfF3zj/G4bm8tLBlaKoa/fml4zj/M+NY+bg8LY2Ky3cVsELM1wZfZcAFgJeQFkiEp7ADvxzd+SsTSNQMCU1ztyamGgpvwg1u2/O9QnvgznrQNvrFi5Ebm0XRPtqzBRfaFswrkvu01LkAt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 16:04:55.1671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec89bdbb-f939-4d94-eb74-08def2422013
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865

On Tue, Aug 04, 2026 at 11:17:04AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 04, 2026 at 03:02:46PM +0100, Will Deacon wrote:
> > > Would skipping their allocation when is_kdump_kernel() be acceptable on
> > > its own, or would you rather see it done differently?
> > 
> > With Nicolin's patch, we can just avoid allocating the priq and the evtq
> > entirely in the kdump case. We can then add a cmdline option to control
> > the maximum size of the cmdq, which is useful regardless of kdump.
> 
> I would still prefer kdump do this re-sizing automatically, even if we
> do add a commandline. It makes it easire to deploy than having to know
> secret command lines :\
> 
> So functionally I still think this patch is fine, though yes it points
> out more things in Nicolin's work too.

I will send a v10 of mine, to skip the EVTQ/PRIQ allocations.

Thanks
Nicolin

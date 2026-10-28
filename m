Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793210977;
	b=U6zcD2uRxPaJLQaE3Ie7Zv75jVHEr9h1k/s20LSdm3uJBO4Fj9sX/AAS6aBjZb1e2kL0
	 xAHF+8IxLuGserdZxFHfp/e7MKwHPg8eX8i+dx6tj/DXOYkqwL1t6pVTW4sonSAYgfDrD
	 n5M7RMI0JP5CR6XAuepEDQznAv6rWjmC8PDcCuegg3sUiG9pUTBzsFMHAcnNDmPgIu69y
	 nTw53hQgqwN3LXpWgwuOSu5H/iZL3NFH0C8NqQGDnL5jqS/wVJWDb6XbL3Pq9re/Du4A7
	 t+wYCtqNCg1ARcAavHGrwXj8yMuWxnvTRptkhWMCtmPn9GzLXUYW2HWXFfX9CaBCBag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210977;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ZkLWVRyBiXY1ilHolDadplYX4t5GjO3VDiQhFkmz/SQ=;
	b=FU/nPDh5Mi7j8y5/TZVyUnJarLyY4OjSOpbZhAZkJ+xuXgaaGEi99HtnNPZWfTghBApR
	 LLwKV8zef6W7kwY1ICs7uiFt7vjrNR+kSxqgM1/oxr7MkrGerBvfy3g1YQxk+7Tma1UKG
	 osRzbETJLGBfUndpnp0VyMkBA4ABVBhoT6qZrF0wBa96vMgsniO41mTlxobiao1TeSSMB
	 hHd2wCF4LUEMwHsKsKug2OBdAFTicEkYElZiTeHaEb+QEc7cBytNXkU1fXw8ys5Jvb80e
	 VlkfFH3Q82ohVHBQIYfBFsrGa6dXCyCpCsqt7eEyKXagNwzKjhgpcmbP8mAEWiVWDjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kD3zOgvz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.38
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010038.outbound.protection.outlook.com [40.93.198.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721D606A33C;
	Wed, 28 Oct 2026 18:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6721D606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kD3zOgvz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5mfOrG8rsmTWLKcEf/dC+L92pbvexj3uNiyse2xF+YS5lGyuD30PdjDMEBylCyJC/K/4ReKiD7k4Cjei1MaMzgZxv593Zlr6SsY1/SqbxzV/nmdErWrWTmSQWJ2vPV/HH+OnwfGDz1kn3/GpFRswh9HpN0QBJlQJxxByFci+yi92R7mBjB1HZi++dkMigBhZQABsXYCQdNzfi8UEs08rLMhiwA2rtR1N7isXQxcMkXSkcixTWaNJ29InKSYYLnOsvTx5lzKybhcE1tpI0IRC+BrEzAFobflRhm52e5uBBhTmT6zLUbCxVsZd2fGNU2ZFa/58Tp1XurjAd6FjBQpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkLWVRyBiXY1ilHolDadplYX4t5GjO3VDiQhFkmz/SQ=;
 b=KP6jgTQjyrgnssfz+5kdo0s7gRGvCzF6GzbWMsQmUWFvRd1pWQICLi4KiMp8W3Cjtql2uJ1uVzTvQnbbLsCShPAgqOM/SvdTlsjMQjphKLze+Q9zuqImzkvvFIG3M44AJ7xFSTILTkPHnINsw5fP5MgBf659MQB4pqq3wC6v36AIuvJg5PUJcdmu+pihvLuv5V9xR6VOc/h2p4Yk/IE0n3zB0CjBwX82Ze33IQ6Fd/KRKzYVyaMcpVmfgBxnvMsMvmsKRznhhGaorWQlp4rlpjEyliHiFLPBuJbmJeTS4txGgWxDSPoGt+rpJliqi4bjTJozm5c5QFRhfSHbgIbZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkLWVRyBiXY1ilHolDadplYX4t5GjO3VDiQhFkmz/SQ=;
 b=kD3zOgvzRRcESvxzt+WXLVpQkUCzJcEp6/Jkg0UHB9rPAwy3RxAfIoxCTOF3hIyAz/A0571vVXYhUDRXhxJLIKiUlLWsnHp2COyM6gx0KjAeqBeSYms0MVzKRDm7OUq/DpZiAplYKMymnP/ACHJiR58IWahEcmym4q8vIX124xBmmOtepm+RFNetE0k5Dqq5yuEHOiekJJiUnhAI1oRXuwyeOjnsNEH8pKwVMf+dUafqGPzIwWAeVNkoDdSY+KM55VJySpuDZ9mMglqau6s8l7q+b+Rq9cktdJWM7bILDtPu5UaNzAOPKTuarXmR4EyHbY1NeW09/n8pQ/KVpo4Bug==
Received: from BN0PR10CA0024.namprd10.prod.outlook.com (2603:10b6:408:143::15)
 by SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.24; Wed, 28 Oct
 2026 18:09:27 +0000
Received: from BN6PEPF00000075.namprd03.prod.outlook.com
 (2603:10b6:408:143:cafe::a8) by BN0PR10CA0024.outlook.office365.com
 (2603:10b6:408:143::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 18:09:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN6PEPF00000075.mail.protection.outlook.com (10.167.248.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 18:09:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 11:09:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 11:09:02 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Wed, 28 Oct 2026 11:08:58 -0700
Date: Wed, 28 Oct 2026 11:08:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "joro@8bytes.org"
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, "rafael@kernel.org"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Gavin Shan <gshan@redhat.com>, Vikram Sethi
	<vsethi@nvidia.com>, Anshuman Khandual <anshuman.khandual@arm.com>, "Shanker
 Donthineni" <sdonthineni@nvidia.com>, Mostafa Saleh <smostafa@google.com>,
	"rppt@kernel.org" <rppt@kernel.org>, Thomas Huth <thuth@redhat.com>, "Marc
 Zyngier" <maz@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	"kas@kernel.org" <kas@kernel.org>, Kohei Enju <enju.kohei@fujitsu.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Ard Biesheuvel <ardb@kernel.org>,
	James Morse <james.morse@arm.com>, Steven Price <steven.price@arm.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>, Omar Sandoval <osandov@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>, Jinjie Ruan
	<ruanjinjie@huawei.com>, Sam Edwards <cfsworks@gmail.com>, Douglas Anderson
	<dianders@chromium.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
	Chen-Yu Tsai <wenst@chromium.org>, Huacai Chen <chenhuacai@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Pranjal Shrivastava
	<praan@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "driver-core@lists.linux.dev"
	<driver-core@lists.linux.dev>, Sonang Patel <sonangp@nvidia.com>, "Ankit
 Agrawal" <ankita@nvidia.com>
Subject: Re: [PATCH v1 8/8] iommu/arm-smmu-v3: Probe a guest-level Realm
 VSMMU via RSI commands
Message-ID: <auI6OGDh723S+6Dh@nvidia.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
 <df25452641dc126eb334a1bfbe5eee16cc8a8953.1789010941.git.nicolinc@nvidia.com>
 <SJ0PR12MB861403B542B8D63B2AACE18EAB6F2@SJ0PR12MB8614.namprd12.prod.outlook.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ0PR12MB861403B542B8D63B2AACE18EAB6F2@SJ0PR12MB8614.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000075:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: 361bcd94-ace0-4b4b-89d3-08df351e9a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|36860700016|82310400026|261028144727099003|261026140227099003|4143699003|11063799006|56012099006|261009223027099003|261026121527099003|10067099003|261021135927099003|261022075727099003|261022105027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tafFS00LB4tu1E9ry88gUgcGE0JSK5BaJNS63t6KFsQhM+tThOEeTSyS5ubovYLM98MvBqM/Oit82teyzNCph1EbBbtXQnXKhsnbikxbVX3AL4Jc8IPBVVe/NtFTp15522OgWWiUkl0ZWJX93nkEegg9bNdy2glZmx5XwTttU43SaQ9VRWjzV2TADuFbeud+k5vQvwvZ2u3bb3Xoa5DwlJNsDiiWpHsjPi7q0zFJtRhF8fiXMd+bBYpbxyiDbsih03VQ9KQyeUhAQppSzzL96p1dKNwZVWi/CoqhRxBmkOoJJ9i5XTsnx0brh+zyI/p45Em8fV3hdhT32I7ha50gPgxKhRM7sq9yArccZbYgRBToIM6dmPNFYw/GUYrMhH5ruwGDrIgSQ9KWw1CFXxW+/iUpSHz/cras1fQPYFp21Gdp9q93pD9af5FyfvWOvMfAvTEN33RRuto0S7euCu5A8RdNh3svnga2XZWV1UZ3ugm6s/Pm2t+Ofutx+MSDVYkHEFaV2L9L03TmwmxKMjyM9ZbIXbXoazNgzi6jMcQkqk3R6OD7R6NvTgn1Q1wYdD0VWur4FN+1Vehzuy8L7kglOLD2svzxmLOJz8saIT7/KT/CQQ35mjwpWVzyOeym2VUwpIlbcrEVFJIiSMEE23UozD3zgCvvrx28aT17MERYveJIAgY6s6uyAZYtqzTtxOja2jEzZfmYiGuTvlU+IIwFfA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(36860700016)(82310400026)(261028144727099003)(261026140227099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(10067099003)(261021135927099003)(261022075727099003)(261022105027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2yYL48xMuK3Z8di4InucGnEZzOP5RFjtKaz9hBWg2v2gXSC3qQEOLiWGRKE5IFuBy+WybWCXeE8RS16EFVKKz+SPv8PnMYxgjywKllUEHg2PIp5G1Y0fBkpUER7dS++YB3Q14qLWt1sTomBKZ4JM0JJiWqYaXxwuVxpiBHlUFtKCyP37NOQoVDuUiAhoFjqC+17nIi6NYen0Eylb8dv38asc+/E1tZGlt/so5FU72YRlynAUaIlUw+4ma9tQm5JEmWicGurtVvFZsIbakg23dIC55SsfHt45uwB5nrqDTYz8vtvBb1ktHKGlfyjRrQa24jwpxK16+prxiUhg1Ks/EIk4SHkS1tK9M/Vuc+dRYQ5jGXHwhdW7PiAc4KTPHCPLbpBTj3Pu1eF8KLgnrm5mKNAip5nP5yn3EZVk+Hzi2lw1CAZ9dgt5xZYSdkFUWE+h
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 18:09:26.6731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 361bcd94-ace0-4b4b-89d3-08df351e9a8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000075.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116

On Wed, Oct 28, 2026 at 08:41:13AM -0700, Shameer Kolothum Thodi wrote:
> > @@ -5542,6 +5591,12 @@ static int arm_smmu_device_probe(struct
> > platform_device *pdev)
> >  	}
> >  	ioaddr = res->start;
> > 
> > +	if (is_realm_world()) {
> > +		ret = arm_smmu_probe_realm_vsmmu(smmu, res);
> > +		if (ret)
> > +			return ret;
> > +	}
> 
> If probe fails after activation succeeds above, wouldn't a module
> reload hit RSI_ERROR_DEVICE since the VSMMU is still ACTIVE?
> 
> B5.4.1.2:
> 
>  pre:  vsmmu.state == VSMMU_ACTIVE
>  post: result == RSI_ERROR_DEVICE
> 
> How is recovery handled?

There is no way to undo an activation. But what's the practical
use case for the SMMU driver to do a module reload?

Nicolin

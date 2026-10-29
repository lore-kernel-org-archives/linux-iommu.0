Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793292699;
	b=Z9nANc2EZrfxN4WT8Pc8s9mB3IOPVC1unjNr/fxPJUNawKlnGhIG53d12/SXqVNYfvpF
	 9XfHw2HHyIQLjgS0WfIEHuRxG019cCQQwfP7mV13PeeXB3twyQLvnKkHJzeDS94iEgx0m
	 kkxHAwabHZSSh67Uljy4KWRHsV/EE37MWlSK8z4Xm7X6cCZJRy7+1KF1s0EOC/t4abz7P
	 OtexwtOBNWesEhEvyFPn69gxgeBrMTJ5Q1Ed7LL++BItdRB/AIYyqcl9c2IoYN8lrHIYQ
	 tXuzLpD2EgJ8eImQ5b2yTS8jc5tP24MHnu7eVjcTumGjmEKUpn2xvsJSB4TRkUc9bYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292699;
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
	bh=tSZqefhy6rxgPsDj2ZU1m/qdXPZYwA6HGz3L9O1XcT4=;
	b=WInmOvGE9dL7f79CiE6BArdZon/DyBeTxjDtmeWqgcCVhMlrq9qa5IDsIEvG8uLlx6GV
	 qRoQxQGW7RC4DzlV9UMX36bZAUIwylHqEiW9JoSAox4XJS2WVLfkodvow3CwPuRl3zi5R
	 KSqMkCUhEYfcvgvhVjFPPtuA31AUlW4DDdqxmpx8ZQbHhLgD+W/erj23QqTZuf+/6SYP+
	 sp/ahTp5A5+VURY2nISv/Rn8qLoG7B0P1hGvtSwXhhPlwt9iuqvCbauTtv5B/CV0WomXu
	 kAnq44ZbvygdKv6l2tBXIveOi4A5ZMaPeWIU9/1ZDeFJMs+dsb5+FiZbIeDdWYk5cjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JUTH1c+Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.19
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB60606A31C;
	Thu, 29 Oct 2026 16:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EB60606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JUTH1c+Q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFOxEChLOFukunNMoxGn7uRwtjYxTwJczIbd1VUD639ImsBtrm79E9b8ToC5sAmbQku9G9av3dwlT81FgzfJbm5kaPTY9nsa+lF2qCdr87jOltPkFdfLpZ4Kj4hu9TcU4x6P2QI8uj1s2k7yI6VOicLqsbNG0imkKoxKUSkrMLjCcus4iP5r6fR3Fkq1OfEkaIJoXft6K1mlq6uIekEFeAkBJYup0ao2Tp+srgtGVZ19p16cV3zavY4ijRFDbEVq7wwOxxPIOh0lxkXxQwXld4eubTt0qEJZM6T/F/QyGPt+9vvEhMCqvwi/3FQUF7uDmFSoqYbdEy25r+pa5K6HAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSZqefhy6rxgPsDj2ZU1m/qdXPZYwA6HGz3L9O1XcT4=;
 b=PowLgQRSDMGy5OFENejWKBDHZgLfjho1MWU9A5qERZv42eeyrFjWbhdhHvFfPxTv4oMCjHbMBHoyaMNuxPozq/Q7MwtuFiVGfRSoNsGNb3WCJO1bND+jcxmZbjWrjwqtI73vu0NWPIM9bnKCrHgbFo+dHmbcSVxUtE1vTtoKDZ7AjT7N6KpLhvVHE00STNsESxen+QfEskO7BpOtXy0xFgxiVRHgLiUFAcr5Cz0k32mY+ZYVsNOyj7D+hkkBxWij0vQFmiTZxDoPZN3ISf0R/vaYs+FMYoiXPEHwLmlZg/tsHtpXY2JipN8xCbA1S8HAhGyPE2uQgBNh6Ug23AAZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSZqefhy6rxgPsDj2ZU1m/qdXPZYwA6HGz3L9O1XcT4=;
 b=JUTH1c+QbFKf3qUZMYQNVYjl77QlkrOk2QiOBlQwqeyuTyyGl9sHIrZs3OTA9gJ0LEXyFDyVERxhMXTAhekFGGA316B2iudHQq3U9HAuT2YIKIF8cCR5A/vU88PzDLnzdc/6itPSfgGsOm8JSSWv2K5jvO04ubcXefAIimwEKifGKdwQneXWqQYesGEyrzJGIirsq2zC44l6Jz0Xmdx/VatdTaGd+eoKxxW8+NwsRLZdPW8Z7IqOzDjCX0uwKJWQzwdk8pyXA6lZUM6kAguedq9tuK7K7zqVHFPuxUaAyKXc38uKV7ZeUFloiC7syl9i2ebKJJmo3umLI3SxpEPrjQ==
Received: from CH0PR03CA0431.namprd03.prod.outlook.com (2603:10b6:610:10e::22)
 by CH9PR12MB962943.namprd12.prod.outlook.com (2603:10b6:610:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 16:51:28 +0000
Received: from BN3PEPF00022BD5.namprd03.prod.outlook.com
 (2603:10b6:610:10e:cafe::9b) by CH0PR03CA0431.outlook.office365.com
 (2603:10b6:610:10e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Thu, 29
 Oct 2026 16:51:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF00022BD5.mail.protection.outlook.com (10.167.248.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 16:51:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 29 Oct
 2026 09:51:07 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 09:51:06 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Thu, 29 Oct 2026 09:51:03 -0700
Date: Thu, 29 Oct 2026 09:51:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Shameer Kolothum Thodi <skolothumtho@nvidia.com>, Catalin Marinas
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
Subject: Re: [PATCH v1 2/8] firmware: arm_rmm: Add VSMMU commands and fields
Message-ID: <auN5dAoteDHV/h+W@nvidia.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
 <0623345baaf550da1339e040b59f1fda902e3390.1789010941.git.nicolinc@nvidia.com>
 <SJ0PR12MB861491CC7A4C567D01F9B951AB6F2@SJ0PR12MB8614.namprd12.prod.outlook.com>
 <20261028123509.GA2541714@nvidia.com>
 <auJBF+hDkx+uKixe@nvidia.com>
 <SJ0PR12MB8614E6DE095441E52698D7F9AB6E2@SJ0PR12MB8614.namprd12.prod.outlook.com>
 <20261029122818.GD3040767@nvidia.com>
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
In-Reply-To: <20261029122818.GD3040767@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD5:EE_|CH9PR12MB962943:EE_
X-MS-Office365-Filtering-Correlation-Id: f0271769-db46-4212-248d-08df35dce05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|36860700016|82310400026|5023799004|4143699003|11063799006|56012099006|261009223027099003|261026121527099003|261022113327099003|261021135927099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	W8Pg9Azjhpw5T3oranOXS4K2kaGMU60WIgJeUqVxnwBSLFHwMl16YTbvk3OSkc1oI7wMY6OuDFz72L/7JF8ZyLyuu8Xr5HfcqZxXZXMop0pLkrOxWgCTKpgJa/fhZ/XOtTq2U62zKpLmeFKjN1pG8f9FmwISGsA6bbF9hkJLyqC+WWajSlt1yiIDQMggog28sancsT+5CEysG7SQaEyhDAFEkZ2fGfkoF2RQHp27R/HDS8DaJ0lobsA0qu0Z1zPlsRlb03Nkw+o67I5ml/y3fqE+SO+Fkh7cuaQOPAwA+CA+pk4REjYzEC2B19qnDcBhVALYgi1EGgirTJRcAHVCuMa9KiQAuXvF9x7jO6RHXdCsNZCwpuMzc7rW9PoLSFa49mZ7XPm0+gihWmwfvDP4orhk4C5y4VKONuXwFexMRwxBdsFgD9xNMhsirNfLyqY9n8AuSfipdcXW2CcsOF4vuoUo6Iiw1gd4PAifnHr8J954pvUGXO6YJo/gnO6fqGPSs5FWTNw+QzPrl/e0uNsL1kpzWXnjid9aurpyaKUNs1saXWMgyplhG48ow0kfeilPEEugmE5TkWhPdw+ZCWTjIPJ5CNTPH5ypgyivZApMckzUU35SWe6Hb1ZhaiegMUkoKRH+xquhLEqmZZ8m4677tXVlE10wkvhhAUn3H38W/Y1vFP07yF3rRCNMHx6Rh8YYwKeCO91S90uQNmr6OJ5zag==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(36860700016)(82310400026)(5023799004)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261022113327099003)(261021135927099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wkS+yXhHtf9zm2m9DrRheUWrCzIJYUwqfBbRkNQ5vuATUjRUNrpv8e5/tODrvvwB/tjVmKIUQ2bZJJigJDt1+uKb07IiOVZzIzMgtcatD/A0JAZG+EWY8GXOwPs0KJXciYvd5Fv9QN2+ePbejxJL2BfxiJcKaN5t3wCH0yg63WLA66bDIunP1coBnupDMwXpRZzYRDuFCieIbu84PVqVfbn3Y7TYjsO3zvVLWJwGf/eTYp0DD1Jt5Y3Lf42b8DQVXSzsdcl7Yl6ZZrXWLTihLSabSDgJsB/LCEvbhwkHkL3gZrrognoZ3ONlqWnffi/5z+ovFOTu6HNZGnyHyTrntXuqPD9kGDHl7MTRoUge/yOzKgST/8b4+krOkRhSLYpih7twPKQhyuigyM1MMUmjUsStumbAZptA9UEHb0lDa4vHmFAh2YEhECtMXrqzAzeD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 16:51:28.1508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0271769-db46-4212-248d-08df35dce05f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB962943

On Thu, Oct 29, 2026 at 09:28:18AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 29, 2026 at 10:05:05AM +0000, Shameer Kolothum Thodi wrote:
> > > On Wed, Oct 28, 2026 at 09:35:09AM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Oct 28, 2026 at 09:49:53AM +0000, Shameer Kolothum Thodi
> > > wrote:
> > > > > > +static inline unsigned long rsi_arch_dev_activate(phys_addr_t base,
> > > > > > +						  unsigned long dev_type)
> > > > > > +{
> > > > > > +	struct arm_smccc_res res;
> > > > > > +
> > > > > > +	arm_smccc_1_1_invoke(SMC_RSI_ARCH_DEV_ACTIVATE, base,
> > > > > > dev_type, &res);
> > > > >
> > > > > These calls leave unused input registers unspecified, whereas
> > > > > DEN0137 bet3 B1.2 marks them SBZ. Could we explicitly zero them?
> > > > >
> > > > > "On calling an RMI or RSI command, any of X1- X16 which are not
> > > > >  specified as input values in the command definition SBZ"
> > > >
> > > > That seems too broad, Linux doesn't even support the x8-x16 inputs in
> > > > the macros. I think the spec has errd here.
> > > >
> > > > Requiring zeroing of x0-x7 is sort of reasonable. Any future use of
> > > > x8-x16 (including outputs) should require a direct opt in of the OS to
> > > > indicate it supports this bank of registers.
> > > >
> > > > Otherwise you probably need a new macro helper for this protocol..
> > > 
> > > We could probably replace it with:
> > > 	arm_smccc_smc(SMC_RSI_ARCH_DEV_ACTIVATE, base, dev_type, 0,
> > > 0, 0, 0, 0,
> > > 		      &res);
> > > 
> > > This should specify those unused inputs.
> > 
> > Or we could use arm_smccc_1_2_smc() with zero initialized registers, as
> > rsi_attestation_token_init() does. I think that would cover X8-X16 too.
> 
> Yeah, that seems to be the right thing to do.
> 
> > But other RSI wrappers don't do that consistently, so it's fine either
> > way, I guess.
> 
> Seems like a bug, with the spec being specific here it should be
> fixed.

I'll use arm_smccc_1_2_smc() in v2.

Thanks
Nicolin

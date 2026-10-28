Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793212735;
	b=Ji9gjJfwBWM2N/dmnq1H/ANP9xgUal9I1Co6wRWMdBRKtKMURRMeN1Gdeewy8RFMrI2K
	 pxmWC7PhGe7tEAwi477vvYDFsL2f9uuKYrT1yS24Qub0YPamdFxH7dxjwugk5d/SZnfVf
	 +CKtwX9JfBoHthkKt1sXgvrqWtV7yWW7sex4HXsbFUuYvcuG1xDc/k7KJgZxlunp7FWR/
	 +mU+IPM0fTLb8J4z+y6ijGhs3WaToBAmAmfeneht8kKn2idY9cPS5VXZQrVlcIW/9Woqy
	 hI1gtp++BNNUaNpP4aYyFdcy6dQvS/to5ioLiwfpg8UcCUb+5R9ZqWMzOov13VfrGTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212735;
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
	bh=SAXWtRirmhMNCoclBRIk6X5OBexmLadiTYckXvbjFGU=;
	b=CGPiI7V+VrVIq58jsOHBXisZ56yxUtL3BSKEr+/FqTUjZCw8AkEXFUwBlT1MYrz+gTYS
	 WwsLVRa5niKuzftqM2J8ZqqjPAoN6HG/TOfyjaVK7aPvBfg1IexuM9R7eFpJ1BictFyfU
	 MfV+9x+S6YXA6H+pQxHR1hp52DAWcua23cDdjeMseK5ywIncoERLqhJoQ2Vn6z1PRoAWy
	 N4FD5h72yIL0jAlSbt/gtowUAK+5XXFiY7VwqBJ90cIIx1bgoi9aPhfUguQvHZkgxT73w
	 r5aPZu0WyJdebGSZvngD537G8bAvl9eeqWBiD7bZ21pIE4cbIZyhgeChog+sbR76aQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AElV4A8D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.53
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAB2606A320;
	Wed, 28 Oct 2026 18:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DAB2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AElV4A8D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZttZs5oe8ZTNa38jZhMwa5wArJEZAkiTm6DVMyhnuaOqg8UONMcSmXEctwxHag6GMy8m1awX8JEnqeXujPC1QIfHcPOrk7CLNGiqpgmdppenONPCVh4qnjA5zpKzCeJaIgZhCq1tJKL9qshTtu+xv2P95FV40yc7sSncT1fk+s7/IlRqePwuj/YS0RtuqXqAq98HekBB4RnORfns4SgsDTJ5R+fn3Al4NSkWhUizSswIYiBFG3khi0FtVi3kx5SZgE4qrs/g/pNDcuWdJG/KFoFAScDZRFeEwxt6xjX+2dkGSNyO9hQNqR3Id31mUt9s6ntRndXA5tE+wTqSL1WSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAXWtRirmhMNCoclBRIk6X5OBexmLadiTYckXvbjFGU=;
 b=YNkJfxyefZh9XJkA7NwXi0fCE79FZR+ozWts5K5qwVgglyHvdGE9xbLnEltTI8KWUb5zC9rRi9MsEpMaM9ZDwKYcdUC7PlK9UW6LehrUgupZTeyR0LW/DqR7SjyDn2yJSui8acRRqhCOaVvCG8wxtDRKt0EI4bx8mliPhYuCKjjtH72/5UmDD+Rwms3kPXOegpssI8MO2HZa2L0yueDaAXRwHHnh6GsAp7xInSfK3sea+/jQsjxjxXk2A2NB2r6i0SVMfKkqJJmgsnrxkbp93uMwFFRH/WYxx4kZ8ljs4+eaU/nHJ6bcxZvtIXcTFXJrBmftI66BYpvO/9ZPtLw/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAXWtRirmhMNCoclBRIk6X5OBexmLadiTYckXvbjFGU=;
 b=AElV4A8D8KPu5ikWXLdZNJQmXTmqp6FqFBd4IHxtE/xNNCwgb2xE5BytofrsvUqpNBNr5id37rOELTQoN8H07ps6QhqRKOqjMq3sAErscm750ZkDCCJ8tZeGV+uBqZsGMYN4XHRJdozrdlLuUeW0BuognDz2jTk8kwb2dC7SA3eDAc7LqJARE0Smh/k9Il0dbd1Lzx1XrM8QX4whshfkwUr8dO8d7UChVHNd5zzTPNofYKi47H8/C7OmccUVG6orXwWojmiNl4ItVVesY7ZqxMmPOVoP6XGmv2O7otk0qTtlfY9bpYS0rrmh99Ei1bzCoa/5c1mXGnB5rtbGd6aL6w==
Received: from DM6PR02CA0112.namprd02.prod.outlook.com (2603:10b6:5:1b4::14)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 18:38:48 +0000
Received: from BL2PEPF000352CA.namprd02.prod.outlook.com
 (2603:10b6:5:1b4:cafe::a3) by DM6PR02CA0112.outlook.office365.com
 (2603:10b6:5:1b4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 18:38:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL2PEPF000352CA.mail.protection.outlook.com (10.167.249.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 18:38:47 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 11:38:23 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 11:38:22 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Wed, 28 Oct 2026 11:38:18 -0700
Date: Wed, 28 Oct 2026 11:38:15 -0700
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
Message-ID: <auJBF+hDkx+uKixe@nvidia.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
 <0623345baaf550da1339e040b59f1fda902e3390.1789010941.git.nicolinc@nvidia.com>
 <SJ0PR12MB861491CC7A4C567D01F9B951AB6F2@SJ0PR12MB8614.namprd12.prod.outlook.com>
 <20261028123509.GA2541714@nvidia.com>
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
In-Reply-To: <20261028123509.GA2541714@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352CA:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: a169a619-6bad-41d4-5bfc-08df3522b444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|36860700016|82310400026|4143699003|5023799004|56012099006|11063799006|261009223027099003|261021121427099003|261026121527099003|261021135927099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	CTcaaYLUX4F8GQ6Kl+uh8c6qw8T+KXhb/rLnnPOf80K8z39Tg6oT0yR87kSEBmZ6s9+EYdQUj3XGRInFz0v+S4zxhf0JVdhwVS8mteYA0IHSXXWQs422jDw5d2S/kIwXBv2SLBviewZAS7mNby1zqFeZLwBHIRAuNMi7ysMnXvnaBVz1Idquosv0YG+m1KuyrQ3fzG9Hb1dnZZqzW7RX8OOgeozawqYdKDILQrrdaFGunLd/Kehqa+r7gq4Kk+xfcE3sgmkpIV6d+TFua/bf7dBbp0D4FVBjJNg4zCH5LBFZXARl03LqFRJO6IAOmH2RXDpIyCGBBaeVk14CWlywVlbP0ThCcL49QSIWtLjtLdbHi/+lNTF7WiMtdHWfM1aH/fMOE5QOrTqfsBPLmoHrxkGXSGPuw1J+yIdmxzK4ASkLi7s5a5D7du01i+R7ZOr8jg+QT6NFy74DvXBe7/giejmwE1SVAQ5IZkP1dSm1q6I97wJGalVjWfi8PyK1mILRJMTCTp2sr9Lcfuv+6jdqBLRK2Z2nqBmY3gIiITC8umsKvfgbL2/CGhju0RLDE8QC1FXv7nva8+CwY213c3joEmeFd76bNEhW2lT9NVGQuO4BBCs6D7tcWW90A8N9pFJHMUuG7k6omigasJPI+GI25zI2AsM8VgujN/2dr/5fkCXcrMfJTGZajFTENOrJFuWk0LWazeBuaRBnNnb9tz0BYA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(36860700016)(82310400026)(4143699003)(5023799004)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(261026121527099003)(261021135927099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	39nW9CcZU30sFE6Kv9+c16GJ0esMqMo2XltfPwNodnz6oMoKndc6lXKfiJl04hJOazSFX1J40AQozffjKnWggl1PStZxDggG9Y95fBkztvB17cQII7IBKyOoWRaAPmtaZO8ZKeYh6BfrHoFAWzhplmfcGxePV7VpTsEImnZQsV6IAoYe76pmONj3vDBBN8h43RwSdVEqrHtrz8W0cJzix+RzUh0AphIC4Hodr9p0TWTShvPF6mmJ7vlrNfdkvYULvyAHw3Imwc7XvzkdD9zPQRV2zshbrinwVzR1oOPEUxO/CKm++XCbnEduSSXncECZlWyay+4NspsIvVz28+s9U7oh87r2/Y+JSiBR2AjpG6w+AB1WGFV7ra8tN1ECPCAqcXOwdvw9INfbqeNyr/80j+r4tHpgq23bUHjhEtaBcO24Gp0Ul+YEPkEoXt2pUMLo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 18:38:47.7924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a169a619-6bad-41d4-5bfc-08df3522b444
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL2PEPF000352CA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974

On Wed, Oct 28, 2026 at 09:35:09AM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 28, 2026 at 09:49:53AM +0000, Shameer Kolothum Thodi wrote:
> > > +static inline unsigned long rsi_arch_dev_activate(phys_addr_t base,
> > > +						  unsigned long dev_type)
> > > +{
> > > +	struct arm_smccc_res res;
> > > +
> > > +	arm_smccc_1_1_invoke(SMC_RSI_ARCH_DEV_ACTIVATE, base,
> > > dev_type, &res);
> > 
> > These calls leave unused input registers unspecified, whereas
> > DEN0137 bet3 B1.2 marks them SBZ. Could we explicitly zero them?
> > 
> > "On calling an RMI or RSI command, any of X1- X16 which are not
> >  specified as input values in the command definition SBZ"
> 
> That seems too broad, Linux doesn't even support the x8-x16 inputs in
> the macros. I think the spec has errd here.
> 
> Requiring zeroing of x0-x7 is sort of reasonable. Any future use of
> x8-x16 (including outputs) should require a direct opt in of the OS to
> indicate it supports this bank of registers.
> 
> Otherwise you probably need a new macro helper for this protocol..

We could probably replace it with:
	arm_smccc_smc(SMC_RSI_ARCH_DEV_ACTIVATE, base, dev_type, 0, 0, 0, 0, 0,
		      &res);

This should specify those unused inputs.

Nicolin

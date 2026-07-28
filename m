Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F473914FE
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257731; cv=fail; b=jl05uellPtXEqlfmDlaZ3yEhStqCHD1u1iKAaYY880aOY1qNEZV+pr4kz9+kuFsrdp32IAtF97U/aDBGKOTwZxZI6uALlyM4s69vhFpgb4Dt2ZyPB/uuAj+8PYWylsGFVjzqWSk3kSP/7g0L9c9s1e1QpXXE+6teX6/aSxCkPEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257731; c=relaxed/simple;
	bh=NFWF74gN75CLXfDWHv+ck6Hr2AUvpN1Jz+V5fDpXBVA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbS/GBnhbrpcvQIQANJ/dmw3b2z7lyu7pG9xt2D8Cg5EDMwVHujCx4TsxX3teAmozFixLvnpe5A8ZxfjOw9IqdPMj0x2eSuVVIsHi2h77hxOeLbktlzsALZ0ppvgMZ+LDCqSnVQD+519PqvRTvo+G2HKlCB+0g9qCwqqkl0eDjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R2RuVNT/; arc=fail smtp.client-ip=52.101.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R2RuVNT/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT1TJ6Eh0YeYUd1RMeOxk81awogO/YjUx9gVnW9rGF1bzI8jeu1HAg5YZ1ldAbb8Rao4GshprJeSR1f5x3nW4m4P8IVGz9iod6b0AAFpnsvbtnrcjL0qjv++0XbxCNg4aVr87hdbN54dTevRXW1QNiAPmmrkfe6Hsb3gqyyyT5hRbkzT8iPfRSWJ1mDdQ/+1fAWCaKNcKdiKYds6HHe8uOK2Ho/xVLCPY3TlBSftpJP2YVgmSfe1Bo0epVfcdsKTV6hCnYNxKfD1yEQlvii77lDjMx7AWgTm5vsoyakuc4Aewd1w5TXtBGOJXs4r3zJMwXJ6n2sykg5d+vTBmdwC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDD+zqWKBEM1lg6YIEa8lBTg+5yH8f2+nwPWnTmhL3o=;
 b=yCjxpqL9StDOzMDgNfRu3mrrUQgaFkmSFapwfuz6xA1IG2yuvqDCpvtBEOtWFZKDhJ4PE2HETbcRxTduh371Aj2Yxhqz2KAbJLMSiy1odiesbcZOt6DsoQlcOMcoprlGLEue0gBIUgYsb+ARjfi8aW16WLBUJv3z4JrAS1miMbouZD8gFO1hLZicFhSL9PQgEWgrplvcfVnLzRYCpTZ2KxyKgemlkGp2prmdMS/xbSBm0h1WLmRtmI5QkCNiuXODEM6oz5ic1AENr3gesHVVnAvHPXryoLaCDp0QXh4Kk+1C/erkHvbqDygU29EjYyXBqVWxTsniB0hyDoNq+od1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDD+zqWKBEM1lg6YIEa8lBTg+5yH8f2+nwPWnTmhL3o=;
 b=R2RuVNT/3bOFlMyrw7WFXQUC1oFIHm+OaaF753NQm8/C5nv3ydMtKPAFadiE6p2mJ4+RRbpuwGWOugWcNAbYk7euxr6ucoLs+cULdrQsPS3HzKSIQ+lwCxrZRdxABqgQaVPrzeO9b79p8BAheVycvUEsO3Zvngb+DyfJgrdptlgAbObVXK1PcRAY4x/lfNI2PLST75TuqH8bZHEyH0oLw4XHkwBsdjHAnlFyxSs4zU2bRuG2HCaXeG6T7I6l4REyPP8Lj5+ua44GJtHY/wcLr09Ky9RwDyjWUarnSw0MJe8pRGfzMcPTm+8hniSKyCspyOil3DleGoM2BFOR/60SvA==
Received: from BN8PR04CA0042.namprd04.prod.outlook.com (2603:10b6:408:d4::16)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 16:55:19 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::7b) by BN8PR04CA0042.outlook.office365.com
 (2603:10b6:408:d4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 16:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 16:55:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 28 Jul
 2026 09:54:55 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Jul
 2026 09:54:54 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Jul 2026 09:54:51 -0700
Date: Tue, 28 Jul 2026 09:54:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <catalin.marinas@arm.com>, <kernel-team@android.com>, Robin Murphy
	<robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>
Subject: Re: [PATCH v2 00/11] iommu/tegra241-cmdqv: Fix error-interrupt races
 and VINTF lifecycle bugs
Message-ID: <amje2dLZPNnJtp5A@nvidia.com>
References: <cover.1784059577.git.nicolinc@nvidia.com>
 <178523230947.340181.5626643238486784200.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178523230947.340181.5626643238486784200.b4-ty@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 4181cf01-a5e3-40b6-ebac-08deecc8fefd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|23010399003|1800799024|6133799003|18002099003|56012099006|22082099003|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	7mvIP6Owu+4X/FgV64n3K32vC8E7zNCIM5PHar/J5TuF4q7aXf5uz9B63HB1nKN7MdGQn7cirJAIMWLd5S7SmdglVL/NSKFqCWrHa9FWyTtt+ztbN36km5TFxq3vIyf83CQYGzadzaLCKB48Fz7am+8cBGxB1I27fFDoNj8kJPxfqQv7HfRdq42+kJM5EadFfNxsuSRSGXQYEKrzbIDMy/iVyDFodAlnf0t+pOEXIsXqD6/GxM2BtdO31eG365ZmetPsjnZfMRkA8NxMttAIUNKs0J0Mc4soqKheDfl+M7CEbO017946o+L5w3d8RXJJuOBKD5Ju4Jv0Hn+Fa4jZBROl2Iebt2iDwsbhZIfHSfiLPq8qT0mmWvCdtNwx4toeIKA+p6IWccmrUugiY9taWrKBkl0ZsI3mzkUluQPG4qbDyEoGT79gOxs+gtyr2voz6mXdZTC+fNqa4sjO3u+E1Y2cQdMx1ReoMVXcuPjOri66ecxZv2A9Uw2wrprb2skLLmEd8+SfC6Wp2NyQ9FqwV8d1yZK9ZM6Pz/AgrdpiBCgkybyxrsi/DM7XbtO1hn4p2P+/edzybf4HnQExypM/yaPHrpE2v8YvA24L0bn2z/JUgLQrjkaUqOOKE83K8xPzxC1rvG3UhhkBto2bLiXW6LCZ3fL/4KWMzITlpDGXjGVnunit3qgPHb+VrIk1Y78paG2UnpYl9W2/B424pupo3w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(56012099006)(22082099003)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2bNLn1bGCfQyElXEFEsqKDlSpYBaAK/4SuCVqxSxaV7REf06Ti/uyiZQAMFo6lTKZhnImpJ+C65JsNZEFY6sYwyD/aH5+WfclrBkUV8ViGGv63DR3bK6wYaYEP273cbZVmkFiCSiZUJd698hcCRiivl3+2r6/YrwD5C7CvcFHgKuo4jBm9+LIdPD+0nIBTlMTnygOGBQYtQAnCcOQVF0GwDRT4PMwyBBvc2MpVekeFQiOrNvh/+n3Kjs2xzlOYhhL/pnNpJUDJeoDmucrogFsZT2MaM7BkFnN8uyJOs4WLbNdGiKkmc1OKXWFBfWqKGSB4Mf0zeBkXMKKEf4Q8Nrjt9Lqrfz6XcENah7/eMTX3CAmC5YpjND8slr5HOSzNJ1hf3I1oPJKIhh7IJo5EwRAJzu4p7ifO7RsfvR7NdXtVkvxHg8dAT52WNmvVI+iOI3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 16:55:14.7070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4181cf01-a5e3-40b6-ebac-08deecc8fefd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955

On Tue, Jul 28, 2026 at 12:15:26PM +0100, Will Deacon wrote:
> On Tue, 14 Jul 2026 13:54:57 -0700, Nicolin Chen wrote:
> > These fix a cluster of bugs reported by Sashiko during patch reviews. The
> > patches are ordered roughly most-critical-first, so some later ones fix
> > smaller pre-existing issues in the same functions that earlier patches
> > touch.
> > 
> > Issues fixed:
> >   - the error ISR racing VINTF (de)init and reading a NULL, freed, or not
> >     yet fully initialized slot
> >   - the probe fallback dereferencing an smmu freed by devm_krealloc()
> >   - a guest vSID programmed without validating its width or the device's
> >     Stream ID count
> >   - VINTF0 leaked on an init-failure path
> >   - error-map index/bounds handling and a VCMDQ base above the 48-bit limit
> >   - the error ISR flooding the kernel log under repeated guest errors
> > 
> > [...]
> 
> Applied (apart from patch 10) to iommu (arm/smmu/updates), thanks!

Should I respin PATCH-10? Or do you prefer dropping it?

Thanks
Nicolin

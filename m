Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE4A36D51B
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065663; cv=fail; b=NfBDF2Z4n5mn6x+21yV72zpqIaosIvPV2+df6lea6dN2KTmjyJNNHhfrwN4EpVb6hGVKJMwxYOlK5KM0JZ+/GUsxcPUaaPGxSP8h9NxLv2EV4VPoAXSj0Wy77RjrY/aRaaPInoUSOzgin5LLORoAaO5T9WEafSAWXfk3nBK9Vo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065663; c=relaxed/simple;
	bh=45lz3G3kEHM6QGfEMxaugdieosQxfZkaAgtOcOaBhLI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDG3yrZ1hZk8+d0DdQhDRxSEjwiupainZd67zpZ6RoESTUeam5EfS3s3QcTYuoAY67KSCctRfS6TNklm0D9Mr5+wf6KmF9dBBA94+URO/CxSiiAPPKbiLuLpxJSYl3uskhn/JtuEN7E5f0GQAa0x4YAEU4XqUw0dxrqtCcqGbTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lu2cK+Gl; arc=fail smtp.client-ip=52.101.61.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lu2cK+Gl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7UDU7PRewrMoAYIRRJq0y2tAd6T1dP7s1IqtUzHt6YSW19hNz3czokMR8dbSIgRbeiGa44gy+RYcIF4FAPRiKyWZD64+Apo7HpeP2HFwpXaB/QlUFoLN4YGfPtIAccNEnJuxxfg0KVrNPCdFQEUXvDCYh3EYBeAarvBgQ4CMJBraqCF/u8u4w3wN2dt3zIMdkCAUMDt3u7SUR+6TDHygnqxV6AZhzogCLhMDfeC8dRLGLKEotx2v1O/tK1y8N6TWri+DWnZHERSSrhlCerGfgMyWFETBJHHeyMuFalir3/krCijTUELUGrg3A+VjgJ87yrqmJ7hGdESbNQSPI8D/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzZ2b50+1hJqW72GCq/8uO7AfL71O/iXls0EqvEgpO8=;
 b=hcdAopcsdZ/qw5yisQTre2mUlh+fGtPXHaPc/ERraFUWDWhrY4Icng46p2yQWB7cadTr3xelZ+POeQnO+AQS4hOeIFeenwjCp3uBa65LZG+NnYR8AfWZfpT5+cOLgRdPV3KhqirHqW+AdMtBaxNVF0jiKMhp5xxuPRwQnG7UFxkviqSRlkRoT7MmTkIpA05fTrQbL854STqkzjhu4iwLHJeH/650G4hgMthtLl6Dy3czcG/H9rRk12dkgfTg/e2uwXThFBMY0kk9J+Xic2CRzhE5hOjjQfAW/KUaizlTX170MUkm5Rz3cGtsiMSjodjpzDOP6XDp+GwkY9bJ+FMOsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzZ2b50+1hJqW72GCq/8uO7AfL71O/iXls0EqvEgpO8=;
 b=Lu2cK+Glzrlls+WvtH+1B8K0h8Hgp5N+MHhSRL9d0HSA/r6H9/Y/OO2pEyouD5AQSVynsBVWgwGTnwRABVwDLdJ1IkXBRrxXqByvdOST4kjeaiUXr30EYla0Mb4Urdby13/JpBFj9gCeix9eMeT8CrCLJhPxTB8EA4k6lxMy4rpfdIfPQJIqhnd44avpzh/mRHSpqpseyG0wN12lX7lc2BXFJDeRTa5v5JamuU+Hi/57mCbKU3J//fSeWKp3sOxhGSZKAUu2j6KdKXPAaUnjv32VRqnfzhCNlbk+S5VFuFFBFFFbRcbcRiTQ3NTIpkQmeB0fD3swbtWOlUDDlfndxw==
Received: from SN7P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::6)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 08:00:56 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:123:cafe::3c) by SN7P220CA0001.outlook.office365.com
 (2603:10b6:806:123::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 08:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 08:00:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Jul
 2026 01:00:31 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Jul
 2026 01:00:31 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 3 Jul 2026 01:00:29 -0700
Date: Fri, 3 Jul 2026 01:00:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/5] iommu/arm-smmu-v3-iommufd: Reject unsupported
 bits in invalidation commands
Message-ID: <akdsG46/j21yzEkU@nvidia.com>
References: <cover.1782767398.git.nicolinc@nvidia.com>
 <eb89a1c564956d9a2ba1d56bd76d57defac205aa.1782767398.git.nicolinc@nvidia.com>
 <CO1PR11MB4835A412EADC0D56A8BDBBFC8CF42@CO1PR11MB4835.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CO1PR11MB4835A412EADC0D56A8BDBBFC8CF42@CO1PR11MB4835.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 2580c79f-1c55-4292-89f5-08ded8d9363c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RwgwlH6JUbfUabuH4j7gZM30WNfgHXo6Hj84eXzDLHLk5M/rteH0+h3xEKUsabLfi1q9nVGMMzqSm440Uimadr5907TcJWzpm4Uqh0mQEezduVnjvtSfbw0s7jH6eb7dnjKEi8u1Enj3CgxGXkKSlNgfH1pZ16Iyf1J8lUXUrnWeJXZ6qhHhyL5jbeKW4L6MpaWowXQvd0V3r95gpHhWeaUk5Oo5ABUPmsGhgVZTCBtrUgBDW0Hcy87jLA4hF8KlhXpAc25icmoiqBltcsjO5R1TlsmaZbpZ9duO4ImG0IqbP/ZEJjmR6c45V/7EWg6y6vydxvL/sli5AgjYyUpnHC6GumC4SLjrBhT7BU/8UxnEXN6cVowTlhXkloSXlMkQyuNWoBv/Vhx0FU6Gwgy+Kq5It4TwDgEX4kVRhyYIM/c7NLCyZB+q9ybugKqf7OaauIxELsW++e/Xghjlgu7jnDnFp6L/ZeJLL93Cu/R2Far4HW0a+Z3lQAbzEvsTfOpKts/qCgsFjr5b47mQEBmMqbrvYI4KbxD/pOYPCHkMkAN7aJIgyvlgSaHb7DOzFEkmAo7bqTVHnqrmdU4EZ2xrS+XkbCg33s4DMpfIEAa3ut5yveZ77cIOjPKCE04KL3kT1xltCl0N9rzfmKLYLW3dYiRrsKUChm9a3BZ+Be8nW59xmwYwafSwM9CCTC1lvzNJGP7tvnNUFZx/ERO4Qyz8KQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GnYQiFbkku7SA9lgaRaSiiGbxaSnj/pK+VnyQ7NGX9BWW57LPzEzzEiuzy9kdpbBP2kA4nQWoJ0iE+UsXuraNcIO6n8oSTdekaOLVLTdqSmlcZ3AHrXD1NuWaNAjgQ7d6evFqEfaJfi0CG53pI7Tx/HnAVxImRZigxNMfsTqcHks4wLJ/JZ71+vaKJ3dCSye/A+g8N7r0Hz16mJlGqghDStDcfx6NmmA1irOJpXQAyOEYyCD2J4J0TX31UZulAM+aAl1U73MD6slQvFkSnmzvDh3Q+zLEWNkkO7jsOmO5KuAtCeGubqW3axZU0wjdZEUYk5PEu3XUit9RsiZMZS59QicOsOkAMvwm1C689R1m31Tk9+P5wtzD5xRM5ILYzT5VUR3uu//grRdiawjMn/LIIXjaCDY9v2PlwkBWiWtxdNAHARFeCPmSkztsueTi2Io
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 08:00:56.1079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2580c79f-1c55-4292-89f5-08ded8d9363c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239

On Fri, Jul 03, 2026 at 06:20:37AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > +	case CMDQ_OP_ATC_INV:
> > +		/*
> > +		 * Exclude the Global bit: it makes the SMMU ignore the SID
> > and
> > +		 * invalidate the ATC of every device, not just the guest's.
> > +		 */
> 
> I suppose the Global bit in vcmdq is guaranteed by HW to be contained within
> the vcmdq, then the SMMU will convert it into multiple INV cmds sent to
> devices associated with the vcmdq?

Actually, this piece is wrong. I double-checked the spec, the
Global bit isn't about SID but SSID (should be provided too).
So, the Global bit should be allowed. I need to fix it..

Similarly for VCMDQ, it is allowed. HW only validates whether
the given SID/BDF is programmed into the VINTF or not.

Thanks (for the question)!
Nicolin

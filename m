Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E037D39DBD9
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794426; cv=fail; b=V8RRXCw75wTIGWgFaGw98VvN4xJpSk+ujFp7eF5+omyjS6MQd4NK1EmdaRvgRL/5MIcWeDq4FFv0oRH+4sAgwZv0/NeMt/FWRoe5O4I8yk3G0myuo1W1nOPBL3Y3EXmM3qI8GRL2quStY66ogEXLV7Aao8vdoQXEskV6QIj3sFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794426; c=relaxed/simple;
	bh=BeSJtmdPP0Fje4BdgpR44Xl9Bc+MSIQ1uR39jEZ3DoI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSJLwqu6LOoVI3lg/f/d1SNGEQY7zPKCq7D9+pJC5xabCw9/fyQpbxtHJXJIzbAIZbL7mS5uP05jD3XxnJdtttUT0UEH61Ehg/5NvkhFBrmPEmC/svaEWYt9b+2QbSIy7VkSOaFmJR8GeuQIKzyw1b7CRyD0CHAuKEW1n9rbsa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kRpaHvzO; arc=fail smtp.client-ip=52.101.48.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kRpaHvzO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CR8wgGOfggmd0RladWk9N5DQKNM4Xm+HVg8DerfbMQ6K9jdWxG7gO3KU0C/WX8FVCTbkIvPXUqKVyjIgF6uI4YiOhTp3KCK7t4fd7lIffZO6KLgxFLFUQcMpUC+5ZMcED1MYFnIuy37WvgqZslc7JFJv8mOkX5tXvJndO73+3Am7vrcx0SDXB2JX+veal7ZmmWFCaNtD6e41GpFnERz4fsmWoO/VDK0z+ECDr2GRSsh5H3uYhZ4Ii2DXE4Ue/eRyaCH6SRJR8wIe++oi9zVUf7DTIoN7hoPxFJz8beyvkDNNNTedqplFXIcRxgeQBmXEgWBd8wdeWAA3MxF+nZgr6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsDqJbj9ItWq4EvOXTRoNM4gJ9kyGGKdplf5F+laCyk=;
 b=zVEAtmE9gI8rn8rmhTK7KlB/okqKRcWIQvjK+zvR7asmNwFVbFQBe47ZfO1v/QoW88odndC5QQaXN6iJbyWtA/u6SZYbC/zu7oaP6ZSnps1xZVB78Nbop06lIwAK5/D0toeswP+J7r1lah76v4eH9FL+BumFsppGdKk6De3ZBouOR3Tzi8wUlrp3TCSIOh3AHg20ztV893v+ShcEIN9nEFoQNSzXa4Lt4bBogRcMKWKobQNYtI8/aWp1rksPatTdT4t6apKaFa/9rYVgrpsq/Yr39mj2f9Tp0CQtNl0Uj501G5wFbGvXIbEKhZ5HfQcyFzEpt9FLExKFsbcjjBAZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsDqJbj9ItWq4EvOXTRoNM4gJ9kyGGKdplf5F+laCyk=;
 b=kRpaHvzOgey9B8HCFJKJ5QqtmBFGZuSCyt7Xta3Ma/1urKPDt+MQdpTkwKpT0CXRHLQnd65+dUkxU498P1lXzkjmRCGXcuUKQbuOUgV3nKIG2axgnnJWbZej+YElYtX46wIvksJjGexBMJE6T2xfM8ud+IMFDpcf4HoYPvxU/uB6bL14mabaPikfokBifmIjxgH4ZxnUs9+O+M471hzJcfnSO3vvvhZ2sGnMw5+ab5k/ik9Edx7II6S3fv1EtfKDXIFgw9ezoMKM3eylineiRFIQeOdYFGMGoiX9mHjRVvUVUQpk8Ovm6GbCvQ/8xgreGhM4LTERG7MMm7IKoJ2Uzg==
Received: from BN9PR03CA0425.namprd03.prod.outlook.com (2603:10b6:408:113::10)
 by CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 18:00:21 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:113:cafe::2b) by BN9PR03CA0425.outlook.office365.com
 (2603:10b6:408:113::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 18:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 18:00:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 11:00:03 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 11:00:03 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Apr 2026 11:00:02 -0700
Date: Tue, 21 Apr 2026 11:00:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc v6] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Message-ID: <aee7IVAXyoppm6tI@Asurada-Nvidia>
References: <20260407194644.171304-1-nicolinc@nvidia.com>
 <BN9PR11MB5276D60096EBF15C5753C4BB8C202@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aeKpxLiykT8O4k1X@Asurada-Nvidia>
 <BN9PR11MB5276A8A765CAAD7A5C3B20AD8C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A8A765CAAD7A5C3B20AD8C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|CY8PR12MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a1cec9-c906-42df-267d-08de9fcfda7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	srlM/W3FUDHrPR7IkTa0TKb3ZMLpiIMeaQSsO9tIcL82L+Fev9yhz9Zfhzmch5L0NFVlC4IjpolDXJMKuLfYHQby5yxi1lNoT0G+Blh1+UiN/bb8hAXpI5yFvcYpnEL+n35/bAGFNmz5HPNyBoC1Q58ql+/2Qkjym7ZLCtpHkQBY3QTxgJ+rlQeCSK44k/7zgQE6UzoM7z6rCWsvxyPL3vMwo87lOEWN/l0G7I4gllgkpcqOucOvccPf8g7Mad6qHE3VLdX7JgUURSjCZhs4KmjsF1ugW+UOIdIfY8nGtNzRdcOiH0XIkV2680AlYo/7s51RMTFSlIEBTLbXDuDs57/diWGbt7Pg/HsfEO9GsrfEMnMGDMzq58FD9W17VbqjlKkLOvBBMRM5QlH2sAK1kMwovHm55M3uicwMD7RXbsBTsSHJd8B766bAIa1K3aAOGLSKj6ZjcHkvb2QQtq7eBzr+NiGs6+UgG9FUhzY8UYBuUuw8xYj42xXPl3EirsyvZgDDFdHYrOzVMDUzlojvWayKmjyMszocku2uRLavCA/YmI4ZEJ0BKRjgBHyOAFMILNLyIxo2DaUYXTKvYIJ3fYI9Vp1CKNpWRo7Cs3JsAykiQN792BUeKNvPaT//29fwh6ialOAz9s/6rhkPw078CAM1s9+69qBRuF2uaHxgYKnC7fX+lkqasEtk8r3XhEY9CopJgVfhHGMDcsjWawv3RM3p4q3+goyqdP2YSHzeFpmOwBHhey9DaILYOswJ0vrj1jBgeEM4X504X3eL2K2+ng==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dplsvdYCKwU3jmfCtgoHFMpNmw31MnoqXMh2v7NTPZ7M0nvIas60NJCik5hz5Utym1ULBt6PELT5A5/NbpmBbL6uhD83a/77Dx6Fc/is5mgsieu4PaFnn48hnlS/N60/+rzlDgowjrTEhxF16ZCSvO9Hb+Weu1ROKyq2Lwns/+dBdMHEPJciqyy/NZg6jslzzCHCiG5jaljJ08EtRw3TivirHwzSk60MRaA1H/z1Mer5sVIf28F4qHvuSvW6wzFyqOmPoRhgsXlAiYngATrI/Ft+1ZW9D/Q0RgnYTNKddks1BR4Rs82rB/N1nwW6zjY+gakkvALQyYWz78YU6T/0myvnz45rhexbdrC467tvIb91dQowoYGStNh7dVe6rVPMJR1INTan1F+lTB/gwa+izEgSGzhlkJ1YKhpZENqjf1CjgdxcCu7tRZoj4f6PtYgB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:00:20.3843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a1cec9-c906-42df-267d-08de9fcfda7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612

On Tue, Apr 21, 2026 at 06:58:56AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, April 18, 2026 5:45 AM
> > 
> > On Fri, Apr 17, 2026 at 08:24:27AM +0000, Tian, Kevin wrote:
> > > the last one is trivial that goto and guard() shouldn't be mixed in one
> > > function according to the cleanup guidelines.
> > 
> > I don't think this is mixing. The guard is protecting the entire
> > routine including those goto paths. So there isn't any goto path
> > that is outside the mutex.
> > 
> 
> Here is what cleanup.h says:
> 
>  * Lastly, given that the benefit of cleanup helpers is removal of
>  * "goto", and that the "goto" statement can jump between scopes, the
>  * expectation is that usage of "goto" and cleanup helpers is never
>  * mixed in the same function. I.e. for a given routine, convert all
>  * resources that need a "goto" cleanup to scope-based cleanup, or
>  * convert none of them.

OK. Let me fix this in v8.

Nicolin

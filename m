Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22354241662
	for <iommu@lists.linux.dev>; Tue,  6 May 2025 05:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746508359; cv=fail; b=EPa7sHB9W1qmb3IzxeyiyVgJOFanES5uqOwkkhM6ViWKuwxUsSEqjbQrB2jdym8W35ZcCOBCFROJ83HWHUtkUMfB3BGJhmMT8OJ4jgFac7olCc7zCulHftkqiI38tQ+xgvc4jsQbxwReCxFLMeFQodtCBpJlwwLYLkYknQnn/iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746508359; c=relaxed/simple;
	bh=qbsjEuPoCgp0vUA+h05THz//o4UMsEFkczAfEsyHVxU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cllMZWqn7ZLDPbi6qYKzSsP/fBnsZfcoMEoSl80zsYuw5jpHpKESzgy3YxdvrtS3jRTWjdp/TjDHJDTPcHKARe9ctbGLzGqdJYztdkL969MuXSAaP0JMN77+ETZdJ5a336TphUnNfJe4/w6VuY7C5Uid4zQoyyXYtqE9U9iT+fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xAVxHtX+; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xAVxHtX+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYlhDddNFY6rFhKWr0PWeALqJKTzYvzs+nBOFNk9VA+Dp4sbkhPnljNlgJ/LMALKvL+BV4uXlufuQ3F3E8mn8YhPArx1iy8ln26PQZeGIosXUyX6T79lHDhuon7lvfVp3lNw2vh3LhMc6tCr4O3KGwZjg88DBhyP9z7nsdpwsR7OJSOhH3BwlNznLFaAuUQd8Iu9MCg+e4qSj5UGMjOKJwAc50tx0nLmQEvPKUZ7Ezc1NpGGin7cGyCJVBBnGHeqBoYuejpUZyCAHBp0s9bJ90Ft1dxkhA6WzH/n0MQaSiFbjWD9n2uoWcVAxBcdpNvt1bH1jxAZEzLEtTfNj+mkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/O59mzLDUjJtMw4HPaHKIlv3JRzcUEAUuXJhPDZc7Sg=;
 b=czwQyKNfICsZ2ffs47IsM7URDbQ8qj76Ub3JTL1XjE0L/tO7bMS8BL2dJIQi/yOnfibVqh7iMm9CzRhhLw+aZr5qgldVELtFMBYwHXz7tIMSJ/85Ih7xdS47jr2mbxk7syR5ujPDE4k8YwUO0jT21xTbaJk4ksKzWsw5KuxCYqaBHQsvcNmphOl90+b3etXwJsUnU2iSAohKjvt7UpR8sgMhh6DFzmDwi5vS+frcY4kx65hxBxEzgMNzlK2pTMW6E4aIRnv4gFprPSLbKHpkMhrmZ4H0C9/cwsZ2l2MYeRjA3WWikBhZ4UvHi0pnvtH+BFKXYJij6oQ/zNklDHHehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/O59mzLDUjJtMw4HPaHKIlv3JRzcUEAUuXJhPDZc7Sg=;
 b=xAVxHtX+aOMLflvJRF95w/pX8xydhkA7Cg8QRFB25epBXM695/mggsVZ0kVlBkKXF0Lx+C+cAtliXEZzH36U5KxdVt9of/jvViMl/m/gehgme0T3UFe0wkX8sCUU6+jX4VZqA18A/GObRiSbTANSRx2afj4/80XzRY7ElwjCqto=
Received: from DS7PR03CA0021.namprd03.prod.outlook.com (2603:10b6:5:3b8::26)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 05:12:31 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::96) by DS7PR03CA0021.outlook.office365.com
 (2603:10b6:5:3b8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 05:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 05:12:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 00:12:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 00:12:29 -0500
Received: from amd.com (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 00:12:26 -0500
Date: Tue, 6 May 2025 05:12:16 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Joao Martins <joao.m.martins@oracle.com>
CC: <iommu@lists.linux.dev>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] iommu/amd: Add HATDis feature support
Message-ID: <lpbeiyyzoxuankxzgcms2iwkoydvj2vcpv5jftiy26nkslliwr@juykyxhdwwzv>
References: <cover.1745389415.git.Ankit.Soni@amd.com>
 <6282a5c349812a311a67a8522dc5e4aabfe3ec3a.1745389415.git.Ankit.Soni@amd.com>
 <596ed125-c995-4e2b-824c-b7929c852754@oracle.com>
 <g3xrnjfs6zekogfohud2s7kdvphx43e6mdh3vfpllynrwokxwf@vvetz2j2nrai>
 <4f04d596-685e-4e48-9038-8aee6c927ebc@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4f04d596-685e-4e48-9038-8aee6c927ebc@oracle.com>
Received-SPF: None (SATLEXMB05.amd.com: Ankit.Soni@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: eb27186c-2f70-42db-9aa7-08dd8c5c9a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/nap6IUdmReZWZRRYNsuuvHVyfCCFHk/2OyWPi2Ksssc8B0PdOpxxbrGigeN?=
 =?us-ascii?Q?fH4/C9cfh8aBqKnNM2YGvW4wG7t5x3iBGyx28qVRobWBzPuxP5KERUE7CYhq?=
 =?us-ascii?Q?w6MOLXKY8XKIlOoCkY96MVEUiB91oe84NXnLTSFByEsslmd94xZRZDubXRHB?=
 =?us-ascii?Q?7otar38HiPjvb1NGzlJraiS3cpFKQGJY8XGi4+QyJ4Zdqkiw/wbCRLvEnlqD?=
 =?us-ascii?Q?jASH60ZcZQUw6HeyjDfzvx6FhHMdHwfWJBvffl6ICuCDH4nUuWpynIs/oz56?=
 =?us-ascii?Q?cj7VEQk4jls7iFzQgEL4z0ZGeiNWRuQIfdGnTaEEe3fUWrh7R8MHyvH20Jwr?=
 =?us-ascii?Q?W+9Co49AGyGt7OmRvIiLm3zpIR9patpWcdyB5Xc3DdqWd12/DtlPW8baSui9?=
 =?us-ascii?Q?xP2AOpkCeOGlLcpDanvfMUECb/L+THb4QwpRKvoVRITdcSMvyYBKtLytXuQC?=
 =?us-ascii?Q?0gSfZCqopCFuN3oR8L36Xsqmu5q1h0oQVJL8ew609LSmcafgrL3AZP//yo24?=
 =?us-ascii?Q?lLcA0VJcECSrolwPQKbk0RkXAxSkWQsREX9+L10AuFkPks4rawH0maotVaJu?=
 =?us-ascii?Q?30U3qxzSn+F0gObProHR7GUOfsjgk7A2YOOmbCmukuQxZSpHgHVVezbF0PeH?=
 =?us-ascii?Q?HIe9hs080kfo+Q9ACmX6UiK5SkHyZc1hwR8fwm+CSWUA7GMtm0rpbiXrrYcA?=
 =?us-ascii?Q?Up/MQ96beBZcLbkfXxbY6WpLVxDg2fevL5qa0C0ThgHJRfnxc55zqVy+bpGQ?=
 =?us-ascii?Q?jFa4e8tkS4lt8nYJKnJTTHLmGlKPO7Xi+Fd0ew4iODP5PB1Rubj2xmroERu4?=
 =?us-ascii?Q?sbjbWaBs6YeQW2KEZ4PLmzWKC1RSVCavw4Xs+G1TychOP1ZNESGGOsAFDFhO?=
 =?us-ascii?Q?B3pKA2r7fU+uSpf7nncqrahI/Pfbno/RVR1ddVRVgKA+Ud75CBSZNxJ09QTP?=
 =?us-ascii?Q?n2k3xxdPisM4guyk/2C984pVV/ReaWZmxniyuj3gepXErwpTg4aGb4096Dbs?=
 =?us-ascii?Q?5FXm0m3CaYbogdHWzTbFqSn6d2uxhPJoohEb/6inJ9/sp6JmYizVg+iGYBbF?=
 =?us-ascii?Q?lcRuDIYRXWlvVj3gSlZcKhAvQUFwysy2A/ad2wI0qYaBV+AWaTup79W3/L6j?=
 =?us-ascii?Q?pwL2OSZxIdLXcwzD4IXwWBRaM6Y8uyZu6ef+v7AkWTb1wb6wpFPnUBur9eHl?=
 =?us-ascii?Q?oOQj0IYvxpXbN+OsLrTD9xBfwSNu2SadwDh6tC1QZRqpSzL+ncvdVUaJKqhB?=
 =?us-ascii?Q?DPUs9mYi0zxY6/jdCJtWkNgYFJdTUAy5NVn0ig+RsBjSYlgLd8xuOEFl5Wmw?=
 =?us-ascii?Q?de/tnOa7w19CajJrxC1lWnws+9T3HYLOW3fKOvAftSEj5Kqsxn9gv5jWV2sV?=
 =?us-ascii?Q?WjDaV5RYvvjygcT0AB1usekOG9RX4HGotbwX86/FeO88Fdt0IXUW/kOpygpa?=
 =?us-ascii?Q?/ywgixKfU4Lb4LdCZ6VApcdhMFsibumF1pXkarAW4hgPn6IMHaAkQnjBEsc7?=
 =?us-ascii?Q?+tGe6LGlsgHqJSxd2Q3jwMMNjiSk2UU6zVREjHupzMeKYlv8447yTJ79qJj2?=
 =?us-ascii?Q?nCIItKmfS28zSvVRoP4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(27256017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 05:12:31.0879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb27186c-2f70-42db-9aa7-08dd8c5c9a70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197

Hi,

On Wed, Apr 30, 2025 at 12:41:04PM +0100, Joao Martins wrote:
> > With intel patch you mentioned above, it seems that it is mostly handling 
> > "second stage translation support" disable, which will eventually disable dma 
> > translation. And in AMD case, HATDis bit indicates host(v1) translation is not
> > available, then attempt to use guest(v2) translation, and if both page
> > table modes are not available then disable dma tranlation.
> 
> OK, I guess it makes sense if HATDis is v1 only.
> 
> My other call out was that when we disable dma-translation all together (aka
> both modes), then we shouldn't advertise the IOMMU groups (internally and to
> userspace) by not calling iommu_device_register()/iommu_device_sysfs_add().
> 
> 	Joao

Sorry for the late reply. I had cross-checked it; if the probe fails,
then IOMMU groups will not be populated, and eventually, it will not
have significance for calling iommu_device_register()/iommu_device_sysfs_add().

-Ankit

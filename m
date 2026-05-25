Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CD13563EB
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734525; cv=fail; b=fMGIPJrSJzqE6kbzMFiwc0nTAkU/woatQSoBL5uTIb65jRhw54cc7NJf5jshMTZWcOeWGF/lQ116ZfDgkDfcBGqCx6tUQ1Gc1wNMO2KbDvqhDSuBV5+5/7tdpsRhFSbmFtnffG1/1WGIUqYDhsEKfBP/l4tj7L/OLVRgxMFyFl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734525; c=relaxed/simple;
	bh=SYgLljsI6VtewSy+JTKvg9O0FDCZYbWkv8UQrW9LqgI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnEtOd3JpnqckbxnfRXKoTujTXeancVK5IyWy4wXvW7RyUnU/l0NkMsbCWpMTocEsZUzIXMrlCZcwU6QnePApK8oKHzgGJ5sds1zooPXfzYBjezGCnAfq+rrEVQxHC8fwZ9E0NCsGeESaLTsz0q9DwfDRuPOM37/Y7PyDBah2L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ub+9MFZ0; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ub+9MFZ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmSAoAgBTmaSdHFmpFDgBgV4dlsbHJOq2VTgETxWjSkseJtO8EmtYMrDIrB2OCozeLAME4LZ0HFD0Bm5JRDcGPMVXprEcJDPHB7vGxv6Nncm3am1Nto3MouNJVdzIuM9L0RB+iX7WJ1QfObkIt2sAqhSC+FKuzeY4rnG9UDmNtPZlVs+3Evv9f8pa0uzu5S0R/Z34ThuuPcgSY5tN0NMP8Yw2hEESIG6PMkohyManscOA4HG3kU+zTJIZYMF19ecQC+mw6HzLdZtWPI0kI8yDWYP0sct4DCVSWyrhVanbEaH4UO/GLBRcz5bGgNw9tXKcb3HczA1i5PeSFOkATSZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2760895k/rWidM0nLjXN/lZu+dzeGw1b9tk7A+9Pu0=;
 b=A87wNynpnOwlp4xkiWO02fTyb2YZNheMsxulCLpb40tu0y3BudzuBa+ZPtAI9e4QRQJQTwePv2TZSmhirrqN73G6gByu/zT9AYj9weE79XduzzlHi/YXvNoarh6i7nCF2m1HfhgIFJz9GfCY2GurTcBGronKWJNwGfG/uMyiMbek78VH0Y1LwEI8+WF5DcyGZVBB6uM9hEtc9ci8kZ4vsXYAYbWaM5kvDMY28fkG9qWd/D2pzIywDt7HT/bUIDJZTpE3GaEa6eQ7fSIQsgPx2lqffO/7MHfm9Tt+SlA+Kb3yss+6cEvUr0GuL/4m1qljmvyrRa4m9iIiAHpP6yTmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2760895k/rWidM0nLjXN/lZu+dzeGw1b9tk7A+9Pu0=;
 b=Ub+9MFZ09h4MGzXT9WJR1/ML+SbLpP3Lm7afyzXSQmjpe6SFfH1WF9SjhoRv3VcQpkvb26A161S8z68TLOtwASq4rTsC3siEulVRSCr7X0gPJjvarE8aRQyCLRkv1nqA2gH/ELVGCAoVPfY8E5pVjLbrfNZo/UAP3MDCydBNKUv+YC4uVyAtL+zhV2cziCrF8K/Ser3jQ9CzBUfo+mmfIhwqFUZH253wHL40s93FnhHlKYZ+tLlFGK34dZtutmnC34/y2glGZPJi2ZjD039sdtkDAoIV6c4lf+et9fW4+Jd1jzKfk1xTKvPFR2IBNgSMQXLC3aReIW4kl7A6OwOGLQ==
Received: from BL1P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::7)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 18:41:59 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::89) by BL1P222CA0002.outlook.office365.com
 (2603:10b6:208:2c7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 18:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 18:41:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 11:41:43 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 11:41:43 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 25 May 2026 11:41:42 -0700
Date: Mon, 25 May 2026 11:41:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH rc v2 3/4] iommufd: Set veventq_depth upper bound
Message-ID: <ahSX5BJOP86MG22M@Asurada-Nvidia>
References: <cover.1779408671.git.nicolinc@nvidia.com>
 <8426cbaa5e8294472ec7f076ef427cc473be5985.1779408671.git.nicolinc@nvidia.com>
 <BN9PR11MB5276B7CEF4820392B53BD4308C0A2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B7CEF4820392B53BD4308C0A2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c87dea3-1a8d-4685-d728-08deba8d4de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZDc47FloXFy6Mwe2uU/pdsEbqdc/GPUa4Tgm+W8yymXP7uml0OnPRnd0kCAOM/NXBw3MYDqVqVGbB8y0Hf/HZqEwzSPlY0A1HhIqoASSpBn8l/VDo2t9hpNX3NT0xFhTGj9a5pVicr+D/Q4ZfAlgfM3CB6MSNhm7wngbrUKVR8M+z88boOnbHPY9mZxV2acnnO6TYwJK2cS4siMYJ75cqDgJxg/A1BJVEEb6Z6txd6ZCUxRuK1ut3US0G6QZheFynYfsyMA1lZ32nUYREtVZPmigSbq8L8BJw9EOkyfbaFkiTNiwHDhxKSQIxAviANPCiwgYmt7fb4lBXw1xLFxPyt15KFhD+sBuF42ZMOPCE3Zzl2LgER0nyr6saylOco67gk4qM+4JX7bW5dpUdEZKaSdud9dbZeoN8HeNEO6uoTANGV+LmGB8UNf5mx6KBP3REbdwreZ2MN9H1h6Vl8lVLWfc+7mvth+2deDQfQ7GZyntosiKIWbh3UTue3GesCcZEn1OOGAUZaqwYF7EVrqbwQ/b5VmYX75N5NyO2SsIM8fz8iTYrX/0Bf0zS/By+V6e5GpXPb6hxIJdiJD8hbuaxV4DCtNec0iZZv4IcFXq2iby/rBUnfozYBlcLNKfcAxpUvMF8pmxVTsLoNp83+U5CTLCmhPLD1rvMYDHVT2Ww1CvOEaPBPyioUpG3frP4s0XaqqY4O5kFxBr2vCbFu711eHtq4rltSkcVmWqxVas+AU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/CJtkRnq7nS5a7omWXxGZlP82NhIYC4Gfbzn2Pz5ThiOpTKxyjvWwsQAdcaZoUtpfdhtK5wVAvS4F7cY6smUNf5d57vnM51FQ/DpE5xxrxoa9rQgtN+RxfZ4lIQkZRD3SCm92sJe/Wt1CFKUR+YBGtgYUcjqLd2uQDOPmPvaTbGIiFrZIRHhj52uHZFJBnEY4Zbrd7idomH+4K+toRuVRpaTuY2moh9Ok+CK7cgqlFzdK5bcnNczit3rxlDh+rZj+Domqooyn6flWI40p/FOQyff5kXSZOiX5tog3PyJFlyma8+bFTRRO+02JkEHsD+c+QjGYRXxvOjGl7k552YVIRxfO4V0qWH2MKYDUDx9dpaEViE/P84UKvTFuX62p3I759/sfg9W+NBsImvm9rV54lggSt7in3ItzW+d7F3EjG0vWYpljDvOHljyVs+w5n5u
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 18:41:59.1267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c87dea3-1a8d-4685-d728-08deba8d4de2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679

On Mon, May 25, 2026 at 06:52:38AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, May 22, 2026 8:37 AM
> > 
> > iommufd_veventq_alloc() accepts any !0 veventq_depth from userspace,
> > with
> > an upper bound at U32_MAX.
> > 
> > This leaves a vulnerability where userspace can allocate excessively large
> > queues to exhaust kernel memory reserves.
> > 
> > Cap the veventq_depth (maximum number of entries) to 1 << 19, matching
> > the
> > maximum number of entries in the SMMUv3 EVTQ (the largest use case
> > today).
> 
> probably add a comment to uapi header that the maximum number of
> supported veventq depth is implementation specific hence user may
> expect -EINVAL returned if the specified value is too large?

Sure.

@@ -1267,7 +1267,9 @@ struct iommu_vevent_tegra241_cmdqv {
  * can have multiple FDs for different types, but is confined to one per @type.
  * User space should open the @out_veventq_fd to read vEVENTs out of a vEVENTQ,
  * if there are vEVENTs available. A vEVENTQ will lose events due to overflow,
- * if the number of the vEVENTs hits @veventq_depth.
+ * if the number of the vEVENTs hits @veventq_depth. The maximum @veventq_depth
+ * is implementation-specific; -EINVAL will be returned if the requested value
+ * exceeds it.
  *
  * Each vEVENT in a vEVENTQ encloses a struct iommufd_vevent_header followed by
  * a type-specific data structure, in a normal case:

Thanks
Nicolin

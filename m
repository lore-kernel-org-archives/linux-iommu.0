Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D358854DAEF
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904626; cv=fail; b=YCB0iQp0A3CHW3PvqsSk2uhx6QIjD/Ky8ZNI+1SZ3mY+kyJXBr4VQD662AeBbGmmgXyKBSD7BKSa4MSQxgylXGD9rpNq3SclrHlNwS1WD71GsNdqRtJLJBwgXqtd9Hv5bkugvrgopgSal4Rmghia2FsHSn3HzcZT1fu7urc1PxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904626; c=relaxed/simple;
	bh=0ZWr+YC0fW/p7Q5FyS0abqySNttyy34fqtEYij+M2Is=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTjTUkAV0a6DUFuNUF2OkZDH7eqGSYajs7wW/ze/mZ5iyU32bWVv20LOdVTMMAJW9HPqkdS5FuRSRlbrGWfrGckoM4bzJzjhLcVF0xI8gVV4xCzU1d3MlaiEG3MMoIAxe7ZN6ROKPmKYe3op830A7//qHLCfhULxQuuh9B19OEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=maBazIlZ; arc=fail smtp.client-ip=52.101.193.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="maBazIlZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQg3pbJR/XDHimSmXApU2wjEivdl1fNbWMDXbcQ+Dre7xuW4uTmINRUEihcZvl76nEp/WQnPRw1T/zCyDNdkHviArppZyzRX3oMrMfq64OihXHyEg0mngqavDhos0MSOZblcp0gEg0YR50lskPUDUmjIfZQXv6nsdLKBSd3lJ4wy0mswIfSWCpAwzl+jZqJ8v1STuUg8AS6pi4nL73oL8tm0YbQu3xtuY06VOLnJqVEkWhHdg90axHJ9Wy6Xnu1dX2lQorof0B1YKbLcAyEFi3wyKOdk/58cbynpnS0WwmKnuYYXgrvBdMRNCMZdzDbP20msu/5lyIU+tmLItP6hXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Xo07CCDhRFwb3C3gOCeA4ZjykFZglOHtaokmQ7QZ9I=;
 b=OzncojDt7dPqEjya4mVF1bW9fSwZDTSdQz4ktK7LQ3m2Ps+R2iVHbvGyGFTl1KjlNOxKbGDgHkkxMBV0jhsjrfBkH3MK+g70HEyAUnmgMpi7vhi43j+FuBjMKmEb8i4CdNsc5XK/8PmjvtAV6rMb4wVB5/1Ds3XyrIX6U3osFjKi8+r7O1rQtK+WdBv4gX3BQI94zzNhcOsSPeQLmqjecfTW1YYY+OHgN34z7nngbhcPS+EScDmXZMUx4/ehnxBYr0/jw4UGWNjkACmlyLRQ8YSLnpxGGsR/RHxoupg7gxA74yyVJKFpzcW/P3RaLr6zU6jwb/7+eyiHgHFHCstzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Xo07CCDhRFwb3C3gOCeA4ZjykFZglOHtaokmQ7QZ9I=;
 b=maBazIlZELPlmJhLnwXeGOX20SbxdsmS6E3Fm8bep1d1GUZRNPIBaMSX+XII6tW7B/CtOsfwoarmNZGCmRjIMDI80JgF7Q96Ay4VO7UEetVxoVdT4WsS0VneDudni8sCIinfJT6xeaHxgE7vx+MX8Oeonsbp7HtG/pm54r5KyOde3ytgcBQvhC/nj+1xNLB0mNS8/lQDm567FH4eUB5AepnA2AfZoXBmKABGgjytiDFjbGPa2RofzXuhdnGKdtznnINfc+bKmW2xEO2UZjx+pjjFtO74KuWNnAX+k1LXtSyhLONWmdPyQk9G4jHCLqBOf2YIxMoWc4sTcyhxtoAr+Q==
Received: from BN9PR03CA0196.namprd03.prod.outlook.com (2603:10b6:408:f9::21)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 21:56:56 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::9) by BN9PR03CA0196.outlook.office365.com
 (2603:10b6:408:f9::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 21:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 21:56:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:56:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:56:26 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 14:56:23 -0700
Date: Tue, 8 Sep 2026 14:56:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>, "Pranjal
 Shrivastava" <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	"Thierry Reding" <thierry.reding@kernel.org>, Krishna Reddy
	<vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Kyle McMartin <jkkm@meta.com>, Usama Arif
	<usama.arif@linux.dev>, <kernel-team@meta.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] iommu/arm-smmu-v3: Add a cmdq_max_entries module
 parameter
Message-ID: <aqCEhG6NA3Ho5noV@nvidia.com>
References: <20260907095835.1233352-1-kas@kernel.org>
 <20260907095835.1233352-2-kas@kernel.org>
 <ap8zCvk8zUPZAJpH@nvidia.com>
 <ap_Rktiv5hms9IvH@thinkstation>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ap_Rktiv5hms9IvH@thinkstation>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: afb7254a-23c3-475a-3113-08df0df419df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700016|376014|23010399003|6133799003|10067099003|5023799004|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hZJar9nqfN/mAhoRxiqLSlZTKUU2WE3dEgwK2dxn/jGlN0bNI1M/kAb6kw4qm59YxW9SxEN/AhzOSihxxg9Tkrr+TCAtPENyY7Z06iMYMN3vEcSbLhTNbxsODFgQuDewx9J+VuKsCwcUsrZcWbaOidUhP+KsDyZdd5TJQgje1/X2z/hrDvaC1hr7Su05HgLdvMcaSio21fPNW3U9XRYk3RKd6O/V8Qs3FS8YByHEaRP9q5TlteNRVivg4yfcOlAvJLD1GxpwjpMf9Ds0X6WXoHHlh09c22YtQpOkzdykp3A7l69Z2ZageNgkrhsV34dmjkXcSacrSN3ry2lAqv9hqF7lpL3YB5bHB9UmVjR4x5GHUU3DzjwC4k6Y/aZ07LlaJXOjdyAN2sOTi6T7HlKw3t/UoqnFahw08lDAMlyHZTym9sY0evkBwoaCfG7DmDmv7k48xnq1O2VL6LCUloyy77CQsr8rKNPp/JG4A/3FgzW9XuBZmV/2QGp02aZQYzP7EZTRiKiU0tU9nIegylzBrZLpAnmTaeCwJcNBiERRn+6Q11qGM1fo9ozSFQ7FAPTmreFpzqsSmzZx+03LePsP3ZIfqsV8YzuEKHzYvWwiOSmTr9XiYdF0FcOZP36vs/5tnvRri0t2kL4LTCq6LoubJR5X2KVy6aMv0rTFZ/eV7fXG7uAH5F5I9yBq8ug790tKmG5ATZWxEJVVLYCar5/ZJQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(376014)(23010399003)(6133799003)(10067099003)(5023799004)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0IjOLcoHrNRDPRd/vGPGf8UuCDzsfK+QK5lWM3DJS+ovRUa2tGDHBAtZfJ+BG1jqYqXtS01k5AMtGVtnyNQlfM73G9NDlU3PPVkfR2QMNB1iZscbiCe20awhQWnkYKNBg4nvfNnkRsoZLTQk6jhxDP4L3PED0ZhmUJRkGzL+DR2HeDWbD5ZZVSKyAJwlua8/Csc0MUVEct0y8Lxvv5JS7NYOFy68aQ+DEe0gbVjVFeYaeJryOsCQtQPlLhln9yNLJ2qeUCsbp/dAxSvqeW+fGFMdEGQ6gFpGOOOROA8HNECP8r0KtGCaIOeQ8hS01UhJs9uojqZ5P3NnWEUibWRqtyYYhemke78iIRuUZwy/wQs7aSI/6A5a91V6lr0COJLmz8njADlApgbDo8T/RgUuR5Qox8GOlaO6qvEzk91gEy61ZCDZBMAhtffU6NU6DJf/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 21:56:56.5231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afb7254a-23c3-475a-3113-08df0df419df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269

On Tue, Sep 08, 2026 at 10:19:44AM +0100, Kiryl Shutsemau wrote:
> On Mon, Sep 07, 2026 at 02:56:26PM -0700, Nicolin Chen wrote:
> > On Mon, Sep 07, 2026 at 10:58:34AM +0100, Kiryl Shutsemau (Meta) wrote:
> > 
> > I still think that cmdq_max_n_shift can slightly tidy things here.
> > 
> > > +static u32 arm_smmu_queue_max_n_shift(u32 ceiling, u32 ent_sz_shift,
> > > +				      u32 entries)
> > 
> > Here, all three inputs would have been "shifts", instead of two
> > "shifts" and one "number of entries".
> > 
> > > +{
> > > +	u32 floor = PAGE_SHIFT - ent_sz_shift;
> > > +
> > > +	if (!entries)
> > > +		return ceiling;
> > > +
> > > +	return min(ceiling, max(ilog2(entries), floor));
> > 
> > And I see Sashiko keeps complaining against the ilog2 here:
> 
> It does build: GCC 15 and clang 21, at -O2 and -Os, without a warning.
> 
> But the reason is not obvious.
> 
> ilog2() on a runtime u32 returns int, and minmax.h only accepts an int
> against a u32 when __is_nonneg() can prove it non-negative at compile
> time.
> 
> __ilog2_u32() is fls(n) - 1, so that proof only exists because the
> if (entries) guard lets the compiler see entries != 0 through the inlined
> fls().
> 
> But this is fragile. If a compiler does not get there, or a later change
> that moves the guard, it turns it into a BUILD_BUG_ON.
> 
> Rather than a max_t() cast, we can give the shift its type first:
> 
> 	if (entries) {
> 		new_ceiling = ilog2(entries);
> 		new_ceiling = max(new_ceiling, floor);
> 	} else if (is_kdump_kernel()) {
> 
> Two u32s, nothing left for the compiler to prove, same result.
> 
> If it looks good, I can re-spin v6 with the change.

It looks probably okay.. though I still don't get why you aren't
picking the straightforward "max_n_shift" over "max_entries".

max_n_shift is used by both HW and SW, and it does not have such
converting problem or need min/max, making the code cleaner :-/

Nicolin

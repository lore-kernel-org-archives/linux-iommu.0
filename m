Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4937B014
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018690; cv=fail; b=DU+w45FeZZa0c8+PtGzrrsUwZvWl4OiQgKAxhR+Wsk/UDWd0iIBgqAiZwYDPKNsaKjKyp1oT2PlXAXpyLStuChbjp+6v5YJ9MeMaQpFNKuTzrpNZaSpB+sWVb1IJutkekR/Kbx9Kjha9ZsJPOqAk0RpVfwQm71Ava75yj3QvV5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018690; c=relaxed/simple;
	bh=LaD1m3FHbIxvAej4Ib9W48XAWeryKNNA2qR9b9mSbXE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U252rhl1vc8CJTQCQs8YhrpNq1YNHwcFREYDVW2nqBMaHOo5x3FNkphv9ZyKgeN2KVLtaLk3Ievkzm7cWqks80zysROpwLjN5Lt4jao33cJqf6wFw6u9icOW4xI1xMLTfA3nn+OHraybV//1LfssmomczTY4pe2ELa2ktpIJnic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bmJm3v+L; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bmJm3v+L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilFsdpKM0h0Xmn/tN1jCp84GbsuG5arw/+QoKCGgHtdbBw+bg0SpMEVzBBr4qkVBUaZ1yPBBcVOlGkGDmMbJEN6tf/+/0D5PKT8oLGamzuvLgMEtQEjHo2mTwrdOMQj/V0v+x5e32bum3DdHLR9VcXayo5ekykYMIdGFV5dLIPsDhVyXcFZEvjR7C7oiG2Nmy4SviV6fLHUsCfkbZF8wZ8Mu3yWPSdAu1AV8GLmGtmhWmnKDH7lRsbZ7nCZvMpB1RWPF99V6t5bnrPwDxDSWW6Ux6iTCKpq9zPoy0OC+fEeFEx7xxAesZufBPnMpevoVbwh91Ze+sOoFYMc3n+h0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/qNr5k6aQGZ/le/mU8Q2yJKpP9kL+WSaZM2iRZ/sNg=;
 b=q8Ym+flp/z1GIcfk70Mm+M86NRD5S9kR7vlEoCN+JYnFgqS7Xp9zPG96Cw1cAVwjstSTI+7wVsqgyEAnl+QENg5WLER4TCVe6ChaPlzGJM5kzB0r4/ul+FT9mriKu07g/9ys+UNdXJVJKElIWHiDfpEJ+fpjV19MJUPRZGC5uQFOO3PRuojnzlAXGsikwp+Z4H3lX0vjgasZSz/M4bUfL1unB9+3BQr9o0WqoHg2Zkyw+OZPMpGRJvNwUoQEoZYwET4MO+tSvgotD5HkjmaubgFZ4DGm+XnVKlO4rw6tMZaF5PRjq4E4dfEKguOCvVtsfFrxzaURoypgtZuoLBmOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/qNr5k6aQGZ/le/mU8Q2yJKpP9kL+WSaZM2iRZ/sNg=;
 b=bmJm3v+LWUpigMKyghOHCebfGf372LJpWX8zJAemuhOjYEIizhfGiSyu3N/TGXPKWq1tTkTV+AYU1/3/5RWBfYepaKkRzP4tpKynEosT5fF2cTNXqV3Q4Wfvx5g+Jmto1dgXT4M2s+l7FPunxn4o4j9KzidHRdlhK/16zu3smOsVQVeh75zG0HiCrx9om9+Ph94pPYkZU2Q6NG7I+C2YmmKGE2vUTVn9hj+3ao7UwRATPh3Lceet9iXOtwu5XmJjEBOZUt0tKr+c+66o3tQJqVu9Hrns2sqsH+NFJ5IytfuH1qTre0JuFIdXBqT+FedtDT8ptM3SJrpbiTRB4NaXeQ==
Received: from CH0PR03CA0316.namprd03.prod.outlook.com (2603:10b6:610:118::23)
 by CH1PR12MB9621.namprd12.prod.outlook.com (2603:10b6:610:2b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 19:24:41 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::78) by CH0PR03CA0316.outlook.office365.com
 (2603:10b6:610:118::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 19:24:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 19:24:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 12:24:16 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 21 Sep 2026 12:24:16 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 12:24:15 -0700
Date: Mon, 21 Sep 2026 12:24:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Jean-Philippe Brucker <jpb@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Peng Fan
	<peng.fan@nxp.com>
Subject: Re: [PATCH RFC v2 1/4] iommu/arm-smmu-v3: Convert streams from RB
 tree to XArray
Message-ID: <arGEXU2GqmYYBBjb@nvidia.com>
References: <20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com>
 <20260921-smmu-shared-sid-v2-1-4b656ce68178@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260921-smmu-shared-sid-v2-1-4b656ce68178@nxp.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|CH1PR12MB9621:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7a92ec-eb73-4511-d6a6-08df1815fc58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|10067099003|11063799006|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	0naqxtp7l9rYcirUxdr21zLfav3vwqiwBVCAJVSP4HJm/NWjNYdiaV3GfLGwgDGrxuuTQDgOix5XT3O/Gdqe6ZnXNsuxKl5fPIq15TaLvrhd9WcBQMqyldXi8r7ncgUdjLDJNnegyKCrIgZNkMQZ73uwJfjJIEnf2pcMpXNgtxz/dwcv8yZIugtuF/HiTQweUosdDk99HR4lBksW+vfOR19zQpabaL7Y5tm51yawXeGrE66JRYlivvgh759eY+TOk0HJu585e+kgxwsaj19H5DJ6f+rlMtDfStPPdLoUo2HjGOJniwMmGnlhiLYMa2q7Ou6K9Pe94nk0pqscpZYtGLdE3G32rdYQKFSZlvjiuz3oanVS5bEJzapS2MtBaIvgxZURXl1L1yWOHMToEogOp2krWz00FSdIIfwfVje2ROoz3sD2vVu7zOjpKqDEYvGUFuUEDndofaXAYRBu33cm5kXU8/vI+bmUOaU6xPXEkO7MQHMEHXHTU4LIE/AgQqc7ni9a4YjUWseKgyZ8U66nCc8dP75UG/iOUGhvODUGDR+JieCr9PaxpUvp+Dt4x4IIxfdm1pBr/im/sjgjr4qkKOZdX6k1qXVYvk1MEfkFb9/fG/G0uxqFdBiDhB5ZS16/N2Eps9IA0gdqTZ8gtlvSWbH5gpmDedmgxyslv8uB0gXGfKGYO51+g6MRfiAvj61AKwo5G4OYm+F795Tyz5hcGA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hwFa0QDooMgL9GgP+1Ec3/xMijoYUWoTOwAyEmQe1lhMeTQ6b/6WuQ4PBQKD7gEH7Xhk3CX9JiLDzxbcHVMj054M1rXDOHExi34Wr51P0cUnXKY+egVAbAj2M0O/BfbF+LgN+epAwzVuk88Cob7mldljewvyPrkyQER2WNpaHIOp/+TskeW7Gk/ZzaKqlxQQY7mhkNwaXd+OWlzPzGXg2LeOGYt0WId3YbRvIpXfA0OQ2NNdLJEOMMLPZXQe3R0CaqzMhCqxEi0nPdjMXansDmEbaPmT/LcZFuIVbQB8LOmsRHTWToFwIiwtL/9v2i65s6o/CvS3Le/UNFAL+QjQcOtxF4P9TxCALp2zlININDaz873fHQ3qloGGYjVospHBeNqXCfn59RqcA/wNjpm7wGGsbQACVysu+4NBK1nc8q3c1TfRztyyiP7TOsUKeVdr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 19:24:41.5502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7a92ec-eb73-4511-d6a6-08df1815fc58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9621

On Mon, Sep 21, 2026 at 07:35:00PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace the smmu->streams RB tree with an XArray for SID ->
> arm_smmu_stream lookups. The existing streams_mutex serialises all
> accesses (both xa_store/xa_erase and xa_load), protecting the lifetime
> of returned pointers against concurrent arm_smmu_remove_master()
> without requiring RCU grace periods. A mutex (rather than xa_lock) is
> needed because several paths sleep while the lock is held:
> dmam_alloc_coherent(GFP_KERNEL) in arm_smmu_init_sid_strtab(), and
> down_read() inside iommu_report_device_fault().

The commit message reads very unconvincing.

The first paragraph starts with an action "replace" without giving
a clear reason for the action.

> This removes the RB tree comparators, the rb_node from

Then the second paragraph repeats the action...

> arm_smmu_stream, and simplifies duplicate-SID handling for bridged PCI
> devices.

... and slightly mentions "simplifies". Maybe it should write about
why this is necessary and how xarray would simplify vs RB tree?

Nicolin

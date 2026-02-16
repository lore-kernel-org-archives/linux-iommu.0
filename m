Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3FE1BD035
	for <iommu@lists.linux.dev>; Mon, 16 Feb 2026 04:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771215590; cv=fail; b=DV5OmTTP/q5r6z15dg56KM1TWdJ8yiKAA2FGDTrwZUgraevWgAnzhHL1nlBuZQpxuj56rbt7MyPpsrReC9i40D6suaKd5f8QlQ+X3+xLXgvrcnGg5xMd9wz8mV/B+G6E/A+ztll55jmmwFJVGWE0PWP4YzkEDHniU5tylWJu+CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771215590; c=relaxed/simple;
	bh=wTDzBReG+6FVHtb1BR7+Cf+p66ixTenqoLVe8aAcma8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EykHC+CrSEx+fInqfg5tG0PuW0rjjtwXgap6+3bS2SHRlb1b3KnHn3bdg8nAe84VSXwBUWjaLcBna3JLQnWcrQqCOukSRbOg7pOiVNCVrRvGYhGK/C0IgnRCePp0JHL5lZJwsDTdnk4Dgqgw5bwvqiHqLBBh96gzXtIBHMSQdlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=beGjaYoE; arc=fail smtp.client-ip=40.93.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="beGjaYoE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBRbCppk5pvNg3aTxCbleUafHQR21g6Mw5sR7yom9hYGdnPvb4IlOwjlZnZetIcoRrP2PD8VcUuAOb4MqeXBCxJMntlXqtuI+VnGzwiuiWH2TEMpJrjJiOh2/3u1zml4RcQs/lauzrYvFAs3rvIqK6a51g0lF+Hm87QCDbyPUidOR+ZEqNoXnLSbPY7EyeX3XkbFaNC8IKXFYQSb1msI5M6c1jPXcXi089HaxZHKuGUAG8e0WwH3ZMKvlyd+8Mf/+lr/YskySOTn2dCjyWORvDKrdxwcOOFUMZdq9g4j57E/PrK5uMdDbeF5RgXN59dakIU0soLOfi2OpX1V7/Q6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JakV7IP/CMBg37P7Da/RfVDhxi+c/yLc8IPM+U3PWfs=;
 b=RjVNvr7woGQX6gHjapfxibqR6zDtOWQYh3he/l3DTbchlq5BWSvYs4CRPEuiph+FpUAGV55Sqe2LGV3XFMZ37swIvEXW8NI9ueKr/N5/6061z78C0GHC81XJAoD/t8pzdvQniBtvLMQPCDSwezt6V+3FtNwTnydAxmm8J92OvQtw0dmgnVABW8LZCVV+lmCGjWZZsOHDmDgO0RMKV2C8cXWG3XUhE4LfvjgkRjz5GtKDlSD5MP8F+pj4xXONCqPIDGFiNgNAE2IhaTAQEcVfsW/OYVe7em3qZBFeYRM9e4hhiSEFcgsQyOlCs/kv9VhRabv0/bqfEYRfUT+8iaJZ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baidu.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JakV7IP/CMBg37P7Da/RfVDhxi+c/yLc8IPM+U3PWfs=;
 b=beGjaYoEyvf5tHi1siNEO2I8Q4Fy03b8oppCyIFapyifHgj5L4Zu+OGyMtDzQ4UzFARc2hjb1+gwbu1+B9T8CeykekjxTc1XCDbOL7nR+MMJZ3gnARrSrMN4fZbOWF2x5bVM/9eDDnl7LgWdrSILD+38kN8cd/70zgbVCjkT6Qo=
Received: from CH2PR04CA0018.namprd04.prod.outlook.com (2603:10b6:610:52::28)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:19:44 +0000
Received: from DS2PEPF000061C6.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::fd) by CH2PR04CA0018.outlook.office365.com
 (2603:10b6:610:52::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 04:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C6.mail.protection.outlook.com (10.167.23.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:19:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 15 Feb
 2026 22:19:41 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 15 Feb
 2026 22:19:41 -0600
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 15 Feb 2026 22:19:39 -0600
Date: Mon, 16 Feb 2026 04:19:33 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: lirongqing <lirongqing@baidu.com>
CC: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Add NUMA node affinity for IOMMU log buffers
Message-ID: <ilnc3wvqtn2yzzg7auhjv22vlvtceagpboqjq7vjfgxwab6rg2@vvyftp36wylr>
References: <20260211035839.1970-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260211035839.1970-1-lirongqing@baidu.com>
Received-SPF: None (SATLEXMB04.amd.com: Ankit.Soni@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C6:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a932728-c370-4bc1-429f-08de6d129bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hIPsf2lv4riVxBrDpjOPto6lOxWTEWZgiVvv2FACponc5x2bNCvb1tnoEu2a?=
 =?us-ascii?Q?LUontHOr72tIaSjSpRaa4kWDMxFHCSEaEkGQImmDRvhQytTJzb4SmqvVcKpn?=
 =?us-ascii?Q?MRd91wVASL3H7xc658lqjApQuaPR8hbzmKdmGVO5BArajllCqe1RaJqSJzHC?=
 =?us-ascii?Q?TwdGPVwaPoBwrFy+ckIu+dht/YwydNc53FhyvgyYaSNeq86BPCGEvm7JPLgm?=
 =?us-ascii?Q?NkQDjZRFOW63xXZH06ByOyIg1XQYo6530fsWkIx8yGU+MiC6Tz29pMPJVsVU?=
 =?us-ascii?Q?yGXPHwtGfrjrpoP8XiVtpP/O+I0Ao2YFJhoER0djmmP4Bcw5YGyDKqdQkI37?=
 =?us-ascii?Q?UGoa7scGVQAAKOQVU2TAOsRUaaEz3qsXIhH0S/PYROk7MNQUO2vwzvZpc/S7?=
 =?us-ascii?Q?Ab/r3aPUSr7MMHevov5+CZYhkOBZf/4kNWEr0br5EYETcCL/4M8ZViMtrqkb?=
 =?us-ascii?Q?DVKMszi4H7qCsLq21JSyPF2gdaOdyGlN2aSKiDxbvxIGAQFdklsLzn+D2zY0?=
 =?us-ascii?Q?fqo18qn1Gwly+OntLZ/PjIPqXuNZK25fVXgHdrEUmmB4VJRUyLMwqUwZfWro?=
 =?us-ascii?Q?3C/WkwaFN00WFzymyeCClFEwMnu/75YzbQRrbTY3eqmWkjF2tpWNuA9MW5ye?=
 =?us-ascii?Q?1bt1J0xf8viVyLiJ1KmFRxKX4X8q562QqDavxa3xlyi9q1nUVhbmtpvaxhlY?=
 =?us-ascii?Q?L25YiE8oaOpnn02+jHsv2cRVJk2sMTyYtgDydeCYrPFkvj6tR6YWcx7SEUNs?=
 =?us-ascii?Q?GBzFYTwV5VuX290r1iC6O1hnJ5+ILaHKRtrJKvrLlPq1vbTUddUk4a+HxoeV?=
 =?us-ascii?Q?13s/hAkGmxWz3MHELBNgYXzRmPheEPsJUKl46CXEIDNUJTnaPHwer2u3l4Nz?=
 =?us-ascii?Q?OJaKInrOg6SoEKFU5OV8n79I5Npbe6t2dC5p7b7rAx0pHWb3B7P60A0L5WbH?=
 =?us-ascii?Q?nzBTSclv24HayqzCxmKvvrZlKo/LO7rXrfPMlELplnL20TrQyBxyMaHndD3N?=
 =?us-ascii?Q?E5eih4kEx1ZrkPF4Wc+uQVKCH1fPy+bVNs+zwG+NfdCavLu2rf5tJ29i7FrY?=
 =?us-ascii?Q?JbvzSCgdeTygZd2yvVKPDhK3bf26JYB8JwZytQQW37F88nRT5naetBPMWSM1?=
 =?us-ascii?Q?hhvzLoLLZPjC1F1hweJZjrgQDGXGzgABfS7isNDsHL1qkL5v5WI9eUwMFpCd?=
 =?us-ascii?Q?OEU54D+vBfxAvP1hVPwIDUJ8HxDnKeVJAyIgRXiLAoztmr6eyHk44jk0WWof?=
 =?us-ascii?Q?HHWcBTb8PTrXbl2VzcLgYwH9NYATPVSl5qyGqYZVswNxTFUUqkaCITmSwgzz?=
 =?us-ascii?Q?zXOivIZDJCiHFd5XfHWXcJHAKPqGvQgfbm7pMxhBaKBWUQ1xP0OFc2v0Mwdv?=
 =?us-ascii?Q?BMO1faCHqLdYMopB5bBg+zQQTQ3+WuivzeB878bjIP+kq/I965LU439RkP9D?=
 =?us-ascii?Q?TUSHZ0165G1D7XZ+vfMmAikU6UMipdQgSavenJptu4NFJek/ccdQWp6tEW+u?=
 =?us-ascii?Q?Zqamzb0e8e/3SrVpYjU6ezAg3NesFGTo6wsvOWG/Gst6fpG1oeB5N377hOD4?=
 =?us-ascii?Q?BPSv8T6uf8TJOpVSgZDVBClXW6Sms1tQkng2OAlI6Tlxy/ik/3uxkJvq+99u?=
 =?us-ascii?Q?OzxwWB+avavtPTXi+oF4dfoKRBqlFg1NgZA2ATVlAHnJitxihWwLKw8rRnC2?=
 =?us-ascii?Q?kL00VA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wpn3QB3CNrf/rtjRb8Q153UlLRxibxcMh+OdzfdIX8V1BMe4z/rQAcdN9+8SV4zm10Eo+LYIsXvbSexOy0R0W+9lRmkSRlci1IhF8uBT0ngcncjLv2sQyreJgkfeJ5RvgOXcwQcgBNZbx1jz5EBGTt1svN6dHF6CvVH956tzIRiZ6tTx7Vl9pfV1hWGKyMbLq/uHlHJvwfZ5ANVt2yxiwakDL5j68TZPW545S0Kn6g/suz4HFNK52WLu7wMKJcDjutA79udtR/jePxhufdh4KseHB27IxXzPqsjkA2FqURwVm8Lm+kk/TVDkrYPzFagmMY3cx7GYCJ0dlHv1ON7t2ui71OfEe6+f1y0Madbh5hXkrU3eJ5Ish4pX7ZLgtt8/jpJKdJ4HnQyAfvBUKi3UzAbjt7MO333U2++iAHHik7lVqlS0IPna69TFIMdnQDQt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:19:42.4262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a932728-c370-4bc1-429f-08de6d129bde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731

On Tue, Feb 10, 2026 at 10:58:39PM -0500, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Currently, PPR Log and GA logs for AMD IOMMU are allocated using
> iommu_alloc_pages_sz(), which does not account for NUMA affinity. This can
> lead to remote memory access latencies if the memory is allocated on a
> different node than the IOMMU hardware.
> 
> Switch to iommu_alloc_pages_node_sz() to ensure that these data structures
> are allocated on the same NUMA node as the IOMMU device. If the node
> information is unavailable, it defaults to NUMA_NO_NODE.
> 

 Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/iommu/amd/init.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 384c90b..721d9d0 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -851,10 +851,11 @@ static void __init free_command_buffer(struct amd_iommu *iommu)
>  void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu, gfp_t gfp,
>  				  size_t size)
>  {
> +	int nid = iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
>  	void *buf;
>  
>  	size = PAGE_ALIGN(size);
> -	buf = iommu_alloc_pages_sz(gfp, size);
> +	buf = iommu_alloc_pages_node_sz(nid, gfp, size);
>  	if (!buf)
>  		return NULL;
>  	if (check_feature(FEATURE_SNP) &&
> @@ -957,14 +958,16 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
>  
>  static int iommu_init_ga_log(struct amd_iommu *iommu)
>  {
> +	int nid = iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
> +
>  	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
>  		return 0;
>  
> -	iommu->ga_log = iommu_alloc_pages_sz(GFP_KERNEL, GA_LOG_SIZE);
> +	iommu->ga_log = iommu_alloc_pages_node_sz(nid, GFP_KERNEL, GA_LOG_SIZE);
>  	if (!iommu->ga_log)
>  		goto err_out;
>  
> -	iommu->ga_log_tail = iommu_alloc_pages_sz(GFP_KERNEL, 8);
> +	iommu->ga_log_tail = iommu_alloc_pages_node_sz(nid, GFP_KERNEL, 8);
>  	if (!iommu->ga_log_tail)
>  		goto err_out;
>  
> -- 
> 2.9.4
> 

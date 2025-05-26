Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D701A8401
	for <iommu@lists.linux.dev>; Mon, 26 May 2025 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748303589; cv=fail; b=Fets3C38KqrAvjISGPgYqkRjOAZ47DIV0pQqg/NsyAC5vYPR+kY055dvsoXFjKF91URDeaicLf9fuw7C3eke3EvVGFefED1PKWaUqg7/ElxQ7r0C/1qAGUoG349A4X/MOeOCKElcypTH3FjAN8F1QpHXvSY11mqGNBue2lPiN9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748303589; c=relaxed/simple;
	bh=ZVMoFMO71Q74duMo0TMhIsbLQ+OJVId98h/Ht9KMyzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=teKAJDE6lOP5UdrBiaFqA8vbwyk8t/DxB/u7A7rUDSNyE5sHIg/70ZVt3FL7qClO0pPk5iLzSCMrS0ZyabmvqT9kZfLPRBCXPwJvs56XP9Uh3l1iSbi6qRGFl8qGv0YAlKHTb/9e+TKXJPu/FAuJKFBINgjTCXI+1EfhgNsaZdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G4slKcJi; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G4slKcJi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jo+Ft8tjWw+8h3Is77qDAqjOBXnh+KgwXj8ta1oOwHSZsCVsZbU7BFcXMaAnkv0X9CJDnVTbNzO2Ss5ebXseNBhlZa8DN8EZH0yirL4xe8/4znu0YYgiQGDN1I6J0mdMYLoksv0HyDsVPGKU41ZMU3FKK+ZVziR42P/T0T8nrwwg2UdwQsF0/+DzdkM/tGDl3A5CrL85tgOcm3D+c+eB4geT8eXTep3LrIB8eqNaYj458VuNCYoIZAIQpSRHBNJHgwoi4lkS3dsEAyXSP7nYZhDqxGAgo9kb67qrs4WyyaQT0NxxEqOlI8qbnRB5fjdG0SdIH0Gu1xABKh+eg+dxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oknF7nsJIZ1DrBlx+R5dymIoUFFcYaE7BB412sF4k1E=;
 b=I3fZtkxbTyLN3/hev/3Ue+vP9dvSkvG4FBZFC4Fcd7vHO1YUNN2eb6IK4sm7dmpA5G1hTldvK78KC50h9tjQ+p2BNngaxeJoxXMchEJndpYnVnDVuWkt8/V0prRCgauIny8sZQN4sf1dZdqbO5u2N/YacDh1vFnQXdU9VYEHjxldN5kUBg2JBVULMls3zcPAX+2EO+Z4FOhod1bQrUKLCqGXoI8IOTAE8Yr3li0wXfrdOBblImqYqPMsXQ7pBvBIKbFuQ+Cy+FMo/amBUsiOhXBG1HIzTyZmeSMRZBwggN0laZEXPOWBB7FhWuOb3oS0EGhhWWcyQqeX8S5KSSwj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oknF7nsJIZ1DrBlx+R5dymIoUFFcYaE7BB412sF4k1E=;
 b=G4slKcJirplWP72F+upgpUutzAptqVULhYXg8CPOZ2fTEmFxHGjXfS2JiBMkSuPqQOdedDLGjw9VmviCd4THKVtArqLYG3YAa5aM2ow42FNI/8sWygvcuAlbnEEbsg5+7VoqnqM/dB6jTk5WEKhHmP+JrXKstpSH2bRSu3C7wcCO1PAWWK9+ifJ9pY+P9tAyPGQKmbyqaTsfa9eTM9JcSh//CIGn3rrEVZqaCKTK8QapQ8rX9BE/Y21NnfSs0Fa4m1H5LHKyIahvMEo2BvTAqXFl5ZF5FiRH2MTJOCh3QwQA2bSaSergMGrO+o4S33ffQYpKdRn0YYI6Ze1ewBiFaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 23:53:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 23:53:04 +0000
Date: Mon, 26 May 2025 20:53:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: [PATCH 2/2] vfio: Prevent open_count decrement to negative
Message-ID: <20250526235303.GJ61950@nvidia.com>
References: <20250516164522.51905-1-jacob.pan@linux.microsoft.com>
 <20250516164522.51905-2-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516164522.51905-2-jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: MN2PR20CA0049.namprd20.prod.outlook.com
 (2603:10b6:208:235::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d720714-a117-42d4-90a7-08dd9cb074ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MDBmxsFqMKID8Ir+4orCzFGW9ZRjFSDjHdJQzjHrdzGd4FrpjnQqcSSZxc08?=
 =?us-ascii?Q?8JyjB1lufvoUG27zZFJgLiKYgvhZWPbQS0ho2TngBlnHWmTSgIn0gOkuLhAd?=
 =?us-ascii?Q?0vANraQsNixOK6IY1/khHnHLeraUf/HhZt+Q0mk179aYFilHTsE4XKHaLOAE?=
 =?us-ascii?Q?y/Tde0ciz0G8hejlVtho89yVp8ePv5qUewQZkGvfrQul6KBMLgUDY6GdyTPI?=
 =?us-ascii?Q?7phNpYH1B9O8iTqSledK1dVxiBBAp9fUDUbr1HYHMuaikMy9e3teQy3LFyo+?=
 =?us-ascii?Q?vnpZB48TwIrGLGLMW5QiDh7sUQXn0e000pnOPIjG9E/zCPNgYA4No+E8ApiO?=
 =?us-ascii?Q?STAuE0+Jp5djh959Fc1YW7cSiItYkbqpEoihAW6SRgTg7R6LzzA0N4qgLSwG?=
 =?us-ascii?Q?TNt4qHB5MUHxSUtWFUyQB+cSDPoDHtSCL311m1d6+FFcMgr0H6427+PHs0QD?=
 =?us-ascii?Q?ty6d3T3Axs0yYMxMCh10t0+v7SGgRTQMnlIJUNfdqKGY9sQahVP7GAXz6FZ5?=
 =?us-ascii?Q?0xE5rZqgGdrmF8Tk9voLvbM9yatuZcNYZLN/6dmIDI5Mr1rN+pC6nrKP4cL0?=
 =?us-ascii?Q?Y/KbFSbeX5vsyjx0zB3PXPylkQSN5Cq/D2Z7JwxJiqL9KHyKi5SOAArpzMtG?=
 =?us-ascii?Q?Xt6QHH2Jde/k6GHWaOFpPlYt7Pdc7fYpHFu5+LXfwoXOfy36IIs69qhnGRFD?=
 =?us-ascii?Q?JI8VDCtyuIU/QE58jYLpNFgaetrAS5ZepaD2iXOM3MVuwkaI9SPoTTln/8yv?=
 =?us-ascii?Q?3jUxyH68LvEoyGVT83prauslFdgHvd0jiaZJFKFhApVyBh+vTL508O/uZ9aK?=
 =?us-ascii?Q?O8ojmCjzBpTMnzW24WdJRA4YqkWZkXb5qsJt16bWPiZ/DBpTty27O9pvfcsF?=
 =?us-ascii?Q?l0HylIDbbueSej7OMOaGdRGBz4QP05JNRBTioexAq8qA1gWjE2e/KM1RF0m2?=
 =?us-ascii?Q?PTlGZ/yNGpOHWxLVOgVP7dnTlPMh9HzjDyojsQ1YVRV+j0O93sX9//wvMPAN?=
 =?us-ascii?Q?gWqrsn622QVJAm42tNomj+JcHg/xSh5qGizlxMemWtDH3kIB/89q7KVYkL1U?=
 =?us-ascii?Q?KtB7qY5dXkOoW9aEvfTWWH8PKndqqXE5paGnNrbhwwSaaETm/WYm7uTU9m/g?=
 =?us-ascii?Q?rPtF32RxM6H5KlMvOniqhzofH0P2+Md+3DUIJ0cxC9RNxv6XEBI1GmOXsyng?=
 =?us-ascii?Q?nQjLu+B/6XAtDhWfYuMhyXpbewpbD90PNfO00Fn++74JEz5jHAe82AcsoqS6?=
 =?us-ascii?Q?TZFaqMlBJVm5VzdDorpyTDzE1grggO0w9R1hLOAcsj50rH3qiFubkHZWgxl+?=
 =?us-ascii?Q?Yn9+9IdtdzHBVeY4dRKI67wFrp0ulSV1c3XyCD19eWH9/EhGthGoanyounjH?=
 =?us-ascii?Q?pk3RUbtbiFb7jQLkW5YM/OWPJxUytGo7XL5H4ag0h0yZdh6thbM6XqBGxAMr?=
 =?us-ascii?Q?U+DHB5XmdAI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hmQyGmjnexkmk9J0scb9UJw9Q/0vqWhHGCcaSai/0ZhmxPxdfW2gWr3JrfIW?=
 =?us-ascii?Q?vTiprKec7mH4CMUmkzYNHfI4HZ6Wff7wp8WZVZMCGVRNWfr7KZKS1d5IOKFf?=
 =?us-ascii?Q?IcQ3N6a2r/qStmsycKLZ2bTAFVEU/OeiGgeJHu3GTukkuHeMUf4BHeB9sYMy?=
 =?us-ascii?Q?ROZS/6Tnt9NruxN2TDSEqE5qBeXVouuc82irAuO32WvrgV3CEXubtiaxY22O?=
 =?us-ascii?Q?gUQYJdxCHoRFiynGZsYto+O2mFwHDdW4IgNBMuBe0xkUWZLj4vGdTLVpohVt?=
 =?us-ascii?Q?21IOXQPpRBrEg+IinacGghp9iM3gmDE9u7sCeGiEOkl5yW+kbHWynk+i/oBJ?=
 =?us-ascii?Q?eyUrH3UOIApafwd3sXrZ91pj5eBS1WL48FlS03LbXZ2pG9IO6AcksIhRPDTc?=
 =?us-ascii?Q?k9nIH6/6QYQChegnQ7zxUWYpTaPE6k7PR9RrYpktMFjqHz3Xx/ziavvIB8tD?=
 =?us-ascii?Q?IP7uE08bkfOiFIKNqey3Rl6tN3ma9pI47Lftf3ZtEXd7cAY7R1mI6aKimdPp?=
 =?us-ascii?Q?Z/jCtPWfZciQ9nQi5TNgMAarVot7Y+lTDirL51bq6aWmTgo9j6NdfroI1vTL?=
 =?us-ascii?Q?XwlqaHeaNqcWdKFAYQtUP7L/gK8SaXegWRd2jASWkNtl9UMOoo21KLgaE7FH?=
 =?us-ascii?Q?Sb+CmYjlh/DIGeXVI5KfEqd+4WaEghvRVuooxlPMkp82NUllL9Ywl5sIZCi5?=
 =?us-ascii?Q?xPZKcoF5PuEjUfRk3X1axWJbD9QTfqzujzNU7UeV4p9CWShY0Cbpk2bWgZ+C?=
 =?us-ascii?Q?5aee7xBS+CzmGUhwwO8Yjr1fkbTgelJZaxkDvtQjKO6H4tVtYQCm6mHL9A9D?=
 =?us-ascii?Q?kYtPa7TKdG4dI768RQdzsta4hB/cupEBBT1N52flC5CybMWfkiLPL2hhvW3j?=
 =?us-ascii?Q?ssYDBKaco4AuR77Bcqa7SkRunOikplNV05CF0nzyGKygNX3v3BdAs7e0Uw7U?=
 =?us-ascii?Q?QtolcZJUJXP3iJEG0brOFC6V3UAuW/gtrz4tRH3bYcRJmWXSm8IFKCINN6FS?=
 =?us-ascii?Q?NXpH3zttYXzgzGXa8gmnVR9VPluQqofFEZUzPxzTA79qTOcvqccsZ+VvY9Mx?=
 =?us-ascii?Q?peWa8Ci5IFREH8SYdcyT2GOEcvcPQNjh6y7p5OwEW4ojrvWNZR7mPFevH1cM?=
 =?us-ascii?Q?hOb1WJcQpbk61jeQF9E4ywcqKQel/oSkR9Ko3tu8i+3HUadn22jNLbNp61Fs?=
 =?us-ascii?Q?XM9bXz42RhP0McLJkHAK0M8ZMHvR8OYeKdNYGxjDGiqfIZms8YXObaHuCP1q?=
 =?us-ascii?Q?3uP/gAZWEfKdt+O2r4gcujDf8YBJ88c3DstBOT05zoFO2IZnAt2Xh2WfuZKm?=
 =?us-ascii?Q?iev0a4/QR+o8J0bSs1SWhF6sg/t6TBC0I0mPjRXT7vSwCmsJGE3bipz2fLwf?=
 =?us-ascii?Q?+FB1XwEvrw8u+2r0x7Lkup7pvQsM/M0nQ9i1ZKNNyclAbFxmWl96hOS+V2XS?=
 =?us-ascii?Q?ofabIgfu/rWu5YLwTdJuA5/GlRUIogLksuYgi963mD2hbg6n+jOopdEDFdt+?=
 =?us-ascii?Q?vP/zvk/+ouelSCn30up2n6ct/IC8fF7yhKVNHWNe6u9wSMCvQYnaw/1uex0k?=
 =?us-ascii?Q?D1OfDzG+5v3UuoAuBgEIbXDkTY4ByrR6b9sjZmAg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d720714-a117-42d4-90a7-08dd9cb074ba
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 23:53:04.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKvSLlMn0zPLDE5BSaQ7vFzRU6EVV2Li0smjstDS40sDRV/uxTRD3I1EHqT183xZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978

On Fri, May 16, 2025 at 09:45:22AM -0700, Jacob Pan wrote:
> When vfio_df_close() is called with open_count=0, it triggers a warning in
> vfio_assert_device_open() but still decrements open_count to -1. This allows
> a subsequent open to incorrectly pass the open_count == 0 check, leading to
> unintended behavior, such as setting df->access_granted = true.
> 
> For example, running an IOMMUFD compat no-IOMMU device with VFIO tests
> (https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c)
> results in a warning and a failed VFIO_GROUP_GET_DEVICE_FD ioctl on the first
> run, but the second run succeeds incorrectly.
> 
> Add checks to avoid decrementing open_count below zero
> 
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/vfio/vfio_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

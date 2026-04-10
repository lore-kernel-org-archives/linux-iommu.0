Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EB926D4F9
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775780400; cv=fail; b=HFIEBThwk0CGjHaRMpXTEquWZ9WTruUwufcHPHRYLt9h2DWsnmtvIwC1LlzLbDNVcxvSc4IQz6CQ49QjtPT7k9bwrwSDmiVIpb+Lq4YIu+jGi6ILa4pf/RT28wa18tgWf0rm3O1KYugKQxzI/hi3Crw0WXKIpGuHDaqDcd18vSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775780400; c=relaxed/simple;
	bh=wrNBgEW8AE/JOtEvby61Wsh+urDekYI/nu+tQtdjflI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dPXkRisiAQ56LzTLZ/+H9T8bPGYyedUbkyfX1x+kzhygglzSfEXed7GTZOsLmy/VCHBJKQqacLF96Gm/xB6Yup7xh3kQ2A9XXzjKe2xlexSA5PYBe5ao2WqkFuo1yslI2dwiY0L0ejTAVcvZWVGvmB/rgdIOtr0uj1ahaDO8FTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hAWO+cpI; arc=fail smtp.client-ip=52.101.46.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hAWO+cpI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKULn7uY+Ed5Q7RuxypD2IFsbvOb1jC4xWYBpakCqceV5e8akEY1PVeu7fqLjaTx+BMC/Kxok5FtXP6qB4aF8jBxDVLIwivbQFQUTyllzS5nCFHoyQIGuhAZNKsMpMuQPY3dDqF8C3Wieea198DCAPudTc7wD5UEo9ZKkfsWbjmDMZ6glLqVmJkkEHWQEVg40H23XZYwTt9bGKCjsxyQKl9xTGidoO5qGLxh7SDKwiwv9Mjtj2GwcRXsPqAWR0IGkV4Yv52vXewNOk4Ihdh6u/o5hv2H0+czs1BMfxCJyk/JLC/v4yucUAbW5hrmot74S2kTgYlYVqCVRaifonARIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWOxWIGu7N6pJTZUHOoiOeTmwWaWLSSicKatc+knzaM=;
 b=LynAa3cXK7zI5mREbUeUuBo6jSgYHsbkpctvxGHzWJV24QL6wncDgu2UuTgPzb2ghVOBlQNHTcZCoUoaEkidFhLGb/ehRvlKkvG35EWHak6tEji0GLaXMGnhkHN82U9JETjBlZNPLApYzrdcg+nkk1zej557z0Rh0coOTVO9uBzdWN/lvHugjiNRT+NaNHj2KKUApg/1CnJsDZydmMyHb9amb2l4eEBcUXQBiCbskX4hkvWD1TOSN0YECBoxNyZu4qr1Wf+9rC8JKq2R14puYceNj3UejSAtNvmIoK4Xx7PQFUqVqt8ZwVJIpF9BKseuxmzM+H8LopSS52mX328HEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWOxWIGu7N6pJTZUHOoiOeTmwWaWLSSicKatc+knzaM=;
 b=hAWO+cpIWcPUseeROoR9jcQnf30x1hhjfKNMP3JiF6OSI6y+juKFD2Wz298ITsFPpQnXNxDuU7jDotya3ZFcp2jUX7K3P9VPi4U0kXmgaGzZ5QxVVajVi0p17gr47D88PylMEy2S+n2SiSKCS253wECb8dXgu4EIqxrt/kO9OrC1vuL8quS4oO8cve9C6UegrWSvnInXEEor7tM3AahyotRbD+giIyGvupPh2Lr6IazKNeRydeCksfEUAqnw2N2Ni1BZKqqJFvWIMgl8q0iKzyfhyYZMKviFPC5DfjrIHD037aGnDPf8u4niSb1nhhb/5cTZrWKXOrMyqUURmJYmkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.42; Fri, 10 Apr
 2026 00:19:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 00:19:54 +0000
Date: Thu, 9 Apr 2026 21:19:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jpb@kernel.org,
	praan@google.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v4 08/10] iommu/arm-smmu-v3: Allocate
 INV_TYPE_S2_VMID_VSMMU in arm_vsmmu_init
Message-ID: <20260410001953.GB3357077@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <05dd00dcb2f0d077f59bcbccac1820534ad7b5cf.1773949042.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05dd00dcb2f0d077f59bcbccac1820534ad7b5cf.1773949042.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR19CA0072.namprd19.prod.outlook.com
 (2603:10b6:208:19b::49) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BN7PPF9C6E5285F:EE_
X-MS-Office365-Filtering-Correlation-Id: 042d193c-bf4b-4066-63d7-08de9696e3f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|3613699012|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ztxRitG/OfpEr0YdbZH2Gq4PGq0ZxdpTnpZbaecXT43IBnYxW9qhNtoJ6stsKZVMpae9HBq7NuR+NsgIgygWzivo2isEfQjGPuHce9RuZVjl952F6vS5ywFDjlZiUeTrwWn9ZlX1hSJh3CVLvIlaGycDhOtKyN4FkvvfwSrrpqeG6otq7aY3yojC8ArlzZtrcOnGTEstu5tZhi8FEIxzQuLnNWa2CVrkJCvvwbyfEjfha+bivSeCcn3uitz08f3+xpIr9LroA4L++yaC1UFSdu7Z8L6w0rCMJ176J+IwmeURYqKUd/j0JIuT6fEFTzCf294Sccq9Xm+a5WDaNI5GNqVspk46+739GAtJnI+VwVVtBCORGsg+kq4U4oBhgzRZaByBTZUOfGZl4ZmljIFfHmwQVOLi/utX5yN66AtGFOd1G6z00niQBQXbi4clrGteJLz+xaWJ+BVItKNCMmUs5M8pOijpi+BMDj3wMrkxxcXOPSRuO78EkOPcHjeqUY9n5GCZLuOFdAdvGjCz0i4hQYmq5hdynfZinu/eOVyfBETA28rVmDIQ2STmT2namW7B0yklDVDESSvwjjvwNXi0HopaLruKheEWNqPwy1HcMSXjwGmAOCrS9qNCrxl339o/fo1Nbw6qCEC4a5hPWT57e829x2WLCsT/nBmeDwbMW29nFdNRfPItb7ZFS+FwZTYST1cPhZFPLJ5dKx8cz5P+Dlz4G8O+O1rfmyshPwbqZGMqkcAgVBDqY1GGu49Uf9v2vTq17H6M0XjRXeftHly5rQjzXBU0f1irWVOcLDALDaE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(3613699012)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eb9Lqcdxa6444ntevo9cOIYnMyE4c0P6MYk98yCoJb/8jteisfDBMJvi1lxU?=
 =?us-ascii?Q?LWAwMKFul9iw1WF8BA0+t/8bDjzwbidzxetlgOK0fbU+VFWPjAG4+/P13XBF?=
 =?us-ascii?Q?P6t8C+VMqV0vvtlwDGYJpPRlyRVizvAZwmcqiwl9/tiwiLAfQviitK2cvHDW?=
 =?us-ascii?Q?QjSqbBA8HLM8tKrqJvRLAt5V5mu38aJ+IlOF6HIBOcQgVpqhWyo/cX3pw5lz?=
 =?us-ascii?Q?cxPs/UclBO60zGrKMkRM8QcMh4HBISkR+GgwAbwcW6Ohe+Dj9aDZwQJE3E/k?=
 =?us-ascii?Q?EshgJhjdqDbjnti1hKzpOo/DTyTNHTDuh0tA8Sv+wlwF7eE1zVNOxdzxNOWe?=
 =?us-ascii?Q?/Z30CTLICWb6aULQavjaRPWSEcmY3xjTHVdMm24NYFqlltbQDIzfgsCI4o3r?=
 =?us-ascii?Q?WAhYFWF0Ty2fMcBLC0gnmwL0maKrHUrqDkq9youHAgWy/THNSiJ0FxLpxi4v?=
 =?us-ascii?Q?EB5Cx2sEmk/I40G26gPbxjldPB3rrKP19m0ggOyJDojsW9ksDzcrxHHLjcQ8?=
 =?us-ascii?Q?2MyxwbJCsgXeagq6Lp/VyzIvlvNqnpqz/4seKiLVTgwtep3TTHYbSZYkf5br?=
 =?us-ascii?Q?qpIqrwo/sWZKBwWnpvb9q2zYptYGnvpmiGF+Rytgpn9eLSfA2B6B8Y1PqS9U?=
 =?us-ascii?Q?/7/a1B4BpXcQGRvy9pW2dSbeh/bYrSonWx0wNLOJoC2ZX9FDUewa0G0pMmk5?=
 =?us-ascii?Q?bT+xlA/ZWSBeS14yjxvfY2H2AWuS3vkEZcliytXi8Covk/oBErsbyRTOdxb7?=
 =?us-ascii?Q?mZ4rubEsPaOmQNhbzZmEB+2Hj1+Iu+n9kP+DYBBhoQTlEwcm5Exhl4qF84HM?=
 =?us-ascii?Q?jajVgv4s8ACYKdZqTj+JnYWp9TKWgA9BPIadQGjbW+P2ESwvPlZmi0pdQbBu?=
 =?us-ascii?Q?aYhQuRDE0PduO7s/aeWG6shFCrv+mx06JuBd/sUPOKlqLWEoEHZEsLoOyFoK?=
 =?us-ascii?Q?nMb2tq15EbW8iiD5l5HViuIw/6i9u7ovrCSNoEgxl4mPkW0ssf6SDuszeGJc?=
 =?us-ascii?Q?0JtaIULZgdAr7Ad3t+1rc6oUp8tSkGhI5Nz6cIcR+cqouWdqb906y67yG+D8?=
 =?us-ascii?Q?HyKOk/bLWM1HdlB/jvsfGthD0wIpRbTZYzBjN2TQ6JauAalp4w/BBxh8UNE9?=
 =?us-ascii?Q?97W+w1jWYtBRylFMK8Nje/4a+GdWmqv5RiELRpI55ZvLuDO7OBO4+euL8QEA?=
 =?us-ascii?Q?Y372bWISB5+lgKQKKRPhk3qszrWaU4ppGo1ICZ2J9i+2QWU16R443XRA2/gD?=
 =?us-ascii?Q?2gM6last/gIFqQkSKJGfAih3xfZLU9FsnDUQUmiXDagHrSN7xPB73KubV6rH?=
 =?us-ascii?Q?1ZAQ0OIZJw/5MdstVcDNFqOok4RjWJBo7eznf2MIT/lbtyt1r+2zAdukxoUZ?=
 =?us-ascii?Q?M/XeLY++a2QjGixTqYKXfckQDWKRKQ5b8ce4X3mK/kM+MsSjnw5iFrosKuCL?=
 =?us-ascii?Q?gFhSDJ3qsx/1E9WWD7qolkNrhsLeAp9P0iMQOL05G7qccnE4iDP1ZYl1JAtL?=
 =?us-ascii?Q?mkdqyFbmwR00/aJHuuzr3hyscsSsx4gB/ZnVXm7LQi9Gf60P+io1kWs+B7Ew?=
 =?us-ascii?Q?6hSdkkp3ah0Kxwil60Q7s4m1P/Z9HVu2lfXyHkTSKmcMYP0IKSAe4yfd6ZEk?=
 =?us-ascii?Q?+c507Fav9+0GBFqsrNVMcm6sYXNnTmdYP/JjQ001Ai6mXvRkZhrTCsGf4cSA?=
 =?us-ascii?Q?XcfZMoOLhSKXUIGMfPxcAdzgLRzm70U8OqjoEvflZ7m8oZsy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042d193c-bf4b-4066-63d7-08de9696e3f4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 00:19:54.9184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2AHd9UNFAapS9cvavtyU56spzzKjhugbGTodS4bPjt5SsGYd4pO/bhYni2x/zDF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F

On Thu, Mar 19, 2026 at 12:51:54PM -0700, Nicolin Chen wrote:
> VMID owned by a vSMMU should be allocated in the viommu_init callback for
>  - a straightforward lifecycle for a VMID used by a vSMMU
>  - HW like tegra241-cmdqv needs to setup VINTF with the VMID
> 
> Allocate/free a VMID in arm_vsmmu_init/destroy(). This decouples the VMID
> owned by vSMMU from the VMID living in the S2 parent domain (s2_cfg.vmid).
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 26 ++++++++++++++++---
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  1 +
>  3 files changed, 25 insertions(+), 3 deletions(-)

Yeah, this is exactly right now.. The vmid exists for the duration of
viommu and gets installed in the invs list when the s2 is actually
attached to a device.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

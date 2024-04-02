Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2111.outbound.protection.outlook.com [40.107.95.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA84CB4A
	for <iommu@lists.linux.dev>; Tue,  2 Apr 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057292; cv=fail; b=jS57JZNNgLmjTdYZWVpLk7ku7SWZ2eErRti2S9pV4k9ryA5Jcd1y1hwEHKOUS+jZ1cfp2sG2Vcn8KPc3cnqZ/EztTZGdPTZ/NgV2wSN0q8UVAmrEiIRqajteUiqg3SELv+E0xXwZp3vUvvcrqvYCFO1POvEq0JahWpa5XVe3SJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057292; c=relaxed/simple;
	bh=q/mfPLvTVhm3/TKY5MHf+yYjDnKbGGDVhGSGy6Q40CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nf9rwrKyvFGQUVgJ8cVdartUDVG3Z6J+7kjfvzdmZTquO8KXuyyR+fqy1vhAMiC/mAY3OiZ3xRi1oPst8SO5F5mU/tdvmsKlNmMrZi/gTlUTOaLYhZbveaRp+2tqZhyGzv89Eg2JfCrIU8LhH60AFpi/UmfpfcL1buqDtJyt8q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I3ZF4sZ5; arc=fail smtp.client-ip=40.107.95.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I3ZF4sZ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONjgNa+nCCx5/CrGve6ViGcyqx8ReUEdjKP0RoYIOmXl8T6kxHUypfGSr4Hk0v8tedKI1A85IsOvUjzzLTh4f6hJl734hD8ybx6GiexYNQQI/66bFKFs3efc+fLWfyahcyXmBEFwNch0PV+31XDokdaeh/acdKxWWRB53H7vpKdA4//jOjuSo8ZRXi16/qGkin/XtGMMN1veP+6nDNQTXmwPtYm57O22OnaoXr/L/lcBdUEWe9H868hNh6aOTJUx60sMfZW4WmJZBKx5M07ec5Cq9T6WJ9/5JZY3h/0CHUmTeK/DuiIydygspC+ZoUloY6KgVzNULNmTdRCnVuVd8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l559m5qt6/wMUQ+TDsAHhhPLNA+SXCNKGbXrc3CUVHw=;
 b=B9iTLKJaG3IAIxzUt4aRnvfLBZ0nuD+kUBPWP3ewClQ8QYcAfeiaoZrP0TR/5Au8XsQzqNUPL43L9bvIhw4oqI4IiMdg4BjqkvHnpLgw28QKZCNNth0sthokmHK9qwis74ty0nJGoHOStkYJgq2bcDVg1xcTNvvURjvvK30bnFF03nFxQE7ozO+VsnorwJeUEpqNE7VyuSXpW9XuBhQYzdAMu4/am/y+aA5LjqN92N/8KkOOXQ7D6eCUiCJqxkw/zE7WEKi7A9ffqeTfiefNLbIPHLYdSTKSy1eDT3C2QkXF2QsyCTvXkomlxEINZHpZsu2FVW5pvVUuxHF4pGsGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l559m5qt6/wMUQ+TDsAHhhPLNA+SXCNKGbXrc3CUVHw=;
 b=I3ZF4sZ5KVR3JYaR2opwSfo2JjnzsxaJ9QwjQCIYJDw2dg06G9KUyghEH/cf7+Ycs9ztgv2jOXhF6sNcBfVi2JXrcjynRyLXZix8+1/xjKaAUdnEYgpBHwg2BKIk6yRElUTre0VUog9zNMqlgS2QTAwgBK+UEQWNmqvaC54rIdwdd9CTQ1lFFY/RVCMmiN+5Ch5jPsc2oqy/Npd5/5Si1teFyDNO6N3cwnzM2nmHPuhDuhLoWgxualGv3iYGY5NZO5E3prLOlp5c756hkU/qFXb3bSnR3ktCHE8kV6YYPOPiAPqUtpH/hWbw2mwOUIHRKtj4RX2oi4cOz0NvLw3Tqw==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:28:07 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:28:07 +0000
Date: Tue, 2 Apr 2024 08:28:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Linuxarm <linuxarm@huawei.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Eric Auger <eric.auger@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: Query on ARM SMMUv3 nested support
Message-ID: <20240402112805.GN946323@nvidia.com>
References: <b8c1b2fb281246da94b35ceb5e27b538@huawei.com>
 <ZfI74miZ1ss9+Kz0@Asurada-Nvidia>
 <4a37c695bf84425ea5159b82c202cb81@huawei.com>
 <ZgZqMymQY4pL77iw@Asurada-Nvidia>
 <02f3fbc5145d4449b3313eb802ecfa2c@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02f3fbc5145d4449b3313eb802ecfa2c@huawei.com>
X-ClientProxiedBy: MN2PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:208:239::19) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA0PR12MB8982:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q6JmhJMnz8L6Oid1Sr0fiEMFYgo8c78xGVr1X2WmK+gBoocRWfiWAH+ezEOEm9W331h+rgH4MaRiXjIY8nuHMh9+uIooW0wAVTGlc7yFQgPcraWCRAtPajeDmmcuok7FzAFAY8EGTcQizK+wSV4BMHHKDa8rR58DVZoK6IcUdfspDCsQUgB9+na8jWWGChBAkhV4ZGzMRvVOrHz+H3ryQCSu2Sox0S73NP5qTzY2wHt5zsqSkL3KF78TmjOt+dSASzc9NshEex/CuXbflZ74kiqVM5OwErcgSg8AS31nuxQ0c1k5pr3QzlkkSVFhvNg0pKNOJk6Xul4AAoH9prZhO2wrMDIPG+0Z0h9fqzeqrhVzRXE5RMMEnx8++c67Xvg42o2XEXS+zc6K2ScVl4aH//5ksuBdL7+cFM3zbx2p4bB9Osza7nBgX02CAGACWa3xH5zs9pDURgIjukubqmRWEDKjJh6ial/Nq+UXNlPTuiDyEVWBTLryGretdPUEahouE8B8/m3bJU1L/AEKtDsmaNxRcF2NG49A5rMbXyKif3DmcrYYev6f6sTlQzFjFn0FmPhPH/hSv5RQHDe/56x3s4fkJsNdQZpzE/I2Ly25ObpjmDTv8CQqk4QWyHt9pY7LsfrwHf1PCZeRYQUPwgPzEuRZRW14LiPwTjfA1actit0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C8BPyg1EZ2pb5J7MhvaZqEqNjxK40yQPQLB/2kEKCfxF5BIZe/qOeok8TWy2?=
 =?us-ascii?Q?YGCB6QY0H2e/rbyQO0Wtbp6dVvYaIBWQWjwlcOwUIP4B+ajEKNmCh5P2d+Ry?=
 =?us-ascii?Q?OxRDmdPyAs69duPXC+KQNTxmumPxBKGfNpCm2hVa9D98tUvScXqHvrn0rh+e?=
 =?us-ascii?Q?HpwJL7qIyNjxB4WKFzboFaZ1LYrCtM/AQK6HxIQCuuCN8zU5Xb6LrX5OBJ9H?=
 =?us-ascii?Q?iC9dpenzOIABBMdZ9r0WqxbBaE9p6BHGzPQneyvsD7nhj/o+ft3r+bKycdx+?=
 =?us-ascii?Q?4kRjk6XD4GAB6IKhJ2BUQ87Zyr5p77KK+Mt1x+a5AZUyPLrKuF0LTDSR71W4?=
 =?us-ascii?Q?L4ZiQoy/WNZGGv8cw0mJLY+b+DeuduG+A7JMOG4apd+Uy+H22Re4P5ED2wv1?=
 =?us-ascii?Q?LT5KzbrotvCbLaF+3E1mM0qE9UcGsxww86cqLMO+qw38tCtZmEhBVINoHuE4?=
 =?us-ascii?Q?hx8/lETehw7OsdDiZgc8nPZe0+5prFukV5CDqrovCkQsNHBK+r+U7oz/hXkH?=
 =?us-ascii?Q?pdBC2X8mDkoYZus4Q4AWRowvHzgk7+dSVvp8wpkVPkmMUl/s0Uxz84CLhnoZ?=
 =?us-ascii?Q?55wIl4WRBCmNEfuFjyU/rcJXqPXIKWEBnS2iqvyaGZMYuow/TBvfvdhUNaew?=
 =?us-ascii?Q?dghNxpSxqKPCXK/rbpH9Ro0N4nFnMWFL4stO+yPelKB30M4mmngh2xtwS2wC?=
 =?us-ascii?Q?VyauyMrZVwT93boHIRaXS5D/gT6sLO6XyPKcb64pmnGbSMP3lb3yzmHdGP6Y?=
 =?us-ascii?Q?5nGcwii/34z2Kngfosd8XxhCPOig/UXPkrrA0A1JpeywIWgThlB9LXTCvdzo?=
 =?us-ascii?Q?9rM/VHAif81Uu5wX+GwpUTKeA/MT4Pp7quwqZzdi77TGwqnK+ZNBJtQ4/rgq?=
 =?us-ascii?Q?AbcVtwYCMe6xEaJq++6KMwk2P8vb3iwYm6o6uDm+TeUSUuNKOV/aOZK+bogz?=
 =?us-ascii?Q?5gE8JcTIV3IgjXfkmpRY3mOTHPDQnQ6svob7ZsUdWAZ4Nur2vib/FM0cpp8i?=
 =?us-ascii?Q?mTu3j1JqTnsywl4Yuu6mREe43wwKhGhDp+q3R9t6M+0iCxWhHKJrQy6jJML8?=
 =?us-ascii?Q?94eQSAYWn1eIivqc903xe8jjf/DZlMor5yAja4HGNkqJRT0rQyd6oHJVA6hG?=
 =?us-ascii?Q?4sIv45hXEQECAQFHmTFv7UfWL8mZgkzzaWutn+TtUcYQEUBt9qmSku14fAlN?=
 =?us-ascii?Q?51YWvW8JJTRYChC4e6iT/bl5+M4RLnsrRluRgayxTCX4b31tXK3MOYSdmX8R?=
 =?us-ascii?Q?r1uC+okW2SXmGbij3AwljycgwHc0zX1+UnGCM6CpTV9bd4WWYPuDfSOeeAiz?=
 =?us-ascii?Q?snDERs7BfrvC8Gxxh2QLE/8eIltMras0OVSlhZ0lthyLLrNPjtDSF6vSdtAV?=
 =?us-ascii?Q?RB9OiAbHO1UMBtzjR4KmqOdPqICps32xmkuvwroH11N9mVQ/4GsZVQFLDsok?=
 =?us-ascii?Q?nBVNCkKzGMeyj/Ry2UfOTit0XIyY6+8SFLuvd/3+Mh+GxbdkE2sy3cJkcamB?=
 =?us-ascii?Q?cCtV+yFQbMnl14x4kQBqfXLjLi8N8ZjvBR7ckdbzdCyDMZwWHn4AHgXL7/Th?=
 =?us-ascii?Q?JI6pU5W0INqcKQeuQHU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6095b7a5-9886-4c64-cd92-08dc5307f7d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:28:07.1201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cv2zyReOb4c+Pxb4KQffby/+8O0bTfjL2Nmg6BMQcu/kFg8tFgic612Fq2e+Vz+A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982

On Tue, Apr 02, 2024 at 07:25:56AM +0000, Shameerali Kolothum Thodi wrote:

> Consider a guest boot with below options,
> 
> ./qemu-system-aarch64 virt,gic-version=3,iommu=nested-smmuv3,iommufd=iommufd0 \
> -enable-kvm -cpu host -m 4G -smp cpus=8,maxcpus=8 \
> -object iommufd,id=iommufd0 \
> -bios QEMU_EFI.fd \
> -kernel Image \
> -device virtio-blk-device,drive=fs \
> -drive if=none,file=ubuntu.img,id=fs \
> -device ioh3420,id=rp1 \
> -device virtio-9p-pci,fsdev=p9fs,mount_tag=p9 \
> -fsdev local,id=p9fs,path=p9root,security_model=mapped \
> --append "rdinit=init console=ttyAMA0 root=/dev/vda rw earlycon=pl011,0x9000000" \
> -net none \
> -nographic
> 
> Here we have specified nested-smmuv3 and have  a PCIe root port(ioh3420) and
> a virtio-pci dev(for virtfs). Once this VM is up and running, both the ioh3420
> and virtio-9p-pci will not work as expected as we return sysmem address space
> for them.

A virtio device that does not use the HW SMMU for translation should
not be affiliated with the nested smmuv3 in the ACPI.

IOW only virtual devices that can be associated with the nested HWPT
can be linked to the smmuv3 instance in the ACPI. QEMU needs to track
this and build the correct IORT.

Jason

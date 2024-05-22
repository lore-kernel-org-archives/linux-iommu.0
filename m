Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24614A4DA
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716420524; cv=fail; b=ugmRpJ0koZ6uM9tuPTnKBFShmB4ogd4hJu6cPo69z249Y5qqFmxFZBSrAs+vzQCDnpBd6hXtCj6/1exnvV2/tt6Z0siTgOBCb0qmd9fMAyZBbxFjFxS9p57uLiC/pQ+OTE7xweE0eJ0aIkUpRWhzW0eKZ50y/J4FawNPhuAq4l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716420524; c=relaxed/simple;
	bh=0vOcqcGpLREjsMYp9gYRRzCGX4Dg0fmhRIi6PZPz+fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j8W91y0y4/NGgPMCYhwKRXm8qUP2eu9zQRitz3hrJiW70dHPWHuRIpko6dbYDjdcDNn3oTxOPb6/WFTxdGLmwuES0kdoO5URCJn03zDGIuXfJJFJlYfAtlXuunTGzzyFE2WlG6TKVGyRY9C7SqMBxJis9N4aVYfxqkJ8ASHytcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=erirl1cq; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="erirl1cq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHwHhMmh4JVhKHjtmBjLa1XwbRHfQMhWmb/+MhUuXlrX7/d0CZaDZXAhTbzfEx9/Gq/0BRoYvfo1PiGDPkXwB9///bZKjAz9IFzVuMp7wC/ylxPGy3ulD7x7cd093bWziuPLmpGs9e82i9nnlGJDifG0H3KVtDeyLoIc4mcB0/0B2TnoIWuSpcpUszo+i4Xl0X8nFjp9atk6I7egk63I6wfscz8FA2E4PPqJIfM1e8M+e/IGi3Bqmnl5UeHPNStHeJdtNvmSdfwxLMFs2HmRnrtq9S6uaqYByiH/Scl98qqvHNL1jzWumecq1iOiRRv1adIurOGrxL0iICtiZHyt0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1udZ5NNAS9vwnHXJArrbBPapjSK6nmVddrlinSDwpsk=;
 b=nz39hbYPSwwwxGb6Ri0spHNl6IPFIoIGnRr0Eg6hRgpQFkyBHcAhlR+GUSDaAabokukmiGFHxxBQut5fn6KSU83YQ92lS6K/voxYPhuX9doFX3QwtHoVJrvCRjjtQ/oBE2Jmm/Ts7Ec2r65cMW/xHRA7zHfx0lJVxi+cS5b8qDGQ7gJ5dYet4NsDf0f2YS95Q581PodnJ/Hp6VQDS/sJ5iDaIJ7yx9i/jSAr1TkdIc3vHh+agqDS/yKRvcjPv0vZ0fX5atgLK2ucU9qm9xGOfjask5aUR63ARSVMsfhqtvUukJaW6D9HfZdCJOPux1SqacF+0ZzI6zQoMeSYVTaEbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1udZ5NNAS9vwnHXJArrbBPapjSK6nmVddrlinSDwpsk=;
 b=erirl1cqnZrOaa4ZBbppthOlzxnTa86AsqVaqTLSovVYJjTUd0Ax3pPKJQZbRYLxywD8TKfSmnh8zOrA3/OgvaoVN6zk/K8wSYkfdbF4nEgLOmKwSaxR2AcMuz+DWm3mxQAUiwFCYeMmS9oxqUrX87f4MgPXqAUNKDKd3IFGT5QEf49FqRJbBJGR9J2hCPSvlrpvkqt4fUDhf2vW9cIDN2mlPCuc8Xiq+OMJoDrd6sbrN/7RmaSUKH3lOCwcHh0+wNj5ZreT/cgq99zlRc79ajVoqRAwukDWfJnWcfZzRCljy8XhSmp6858Cn1zeF5lf8H/a/jNmlsLR+SkHbAuyIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Wed, 22 May
 2024 23:28:36 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 23:28:36 +0000
Date: Wed, 22 May 2024 20:28:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 00/14] Add Tegra241 (Grace) CMDQV Support (part 2/2)
Message-ID: <20240522232833.GH20229@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB527641C15DD88FB0C44323D08CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240522164818.GB20229@nvidia.com>
 <Zk5Lx7IqvnE2q7a7@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk5Lx7IqvnE2q7a7@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:207:3c::25) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9df21d-6f2f-4ea6-1ed4-08dc7ab6e70b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l/H/cDh0m/Acva96a8e6mMogpOdxkJcOm0q197qu7mg8AWHSHZ8LNZlpYozD?=
 =?us-ascii?Q?PPOD027zz2Kyh2qsFUq9YLN7uKJERr7klJQRo1/FRt+JgooYXflqc4HBObUv?=
 =?us-ascii?Q?K50l943kOWf+XBgkPlHkxz7Vm5+G5PfXOtUsp1t7181lP6TyfVbQITr3pTF6?=
 =?us-ascii?Q?EwYXZ+YzVwLhPV8P8XqSiIfrcpLTh4x8B52fO6nfu9AOZSc63Z4/b8i8r6QT?=
 =?us-ascii?Q?5EQqoMEo3vbgtNmDqA9mCi6dW/1BV3ZCArPK+hGPqR6v2WTQYhzFZmAQOEQP?=
 =?us-ascii?Q?DnSoVL37qZkKOj3t/9nuWQtaX04REkV/cpVhy22FX3Fik/2yLUdpjmSsuvnz?=
 =?us-ascii?Q?DDVfdQs4KL6FGorzQcXq01rV3n948/7EiFlXnlZ8q/I/dAHqfmBjjLc2hWXQ?=
 =?us-ascii?Q?Z6ggRBZbrvwfoyH6pkdOM11RpCatQ5rHrR8YNY5cYnf4Zulcvtpm1H6Uvjuq?=
 =?us-ascii?Q?kztfGKmCs+Q4cglrwnopz/grI72eivh7J9PjZYVR9xIf2Zqd0IyZEeTXQr2/?=
 =?us-ascii?Q?QzRkUrcJENo2xW/Q+gvFJXcxhfsFGbw0RFaNfWR6+fgtpg8GN7C8OVxOxZuO?=
 =?us-ascii?Q?mj59svNWy1Yonx8XV9wUVzRWLbAAUQS2APB+yG96n+abWQBOWGDVbKh8griu?=
 =?us-ascii?Q?965rIVO4n2H7QHxYu0PpPtBsW3moiNCrcqWJ/fQu3+a4lam4+gL64SfRyT2J?=
 =?us-ascii?Q?rhpfsb9MPN+iwZVz+Bj49kqDiTwlIaZoU8zTLjDbhth7reNIGkr+Y9JYbZmy?=
 =?us-ascii?Q?zlH4CYJg0K1to8UNF7nN8KtJhsdx+uXWTzNI2j3Q/ZNI0jLM4tRoOCl5MI7c?=
 =?us-ascii?Q?3nRsLGi03HLS49Y/UmzmXzC85tudWnjSE74qhQEZIJfxvOHjTZGWZ9G06237?=
 =?us-ascii?Q?E9HXukRSjtfhszLxHMNUEw+PBURRCOBEzRTZb+onCxTQ/QGJbu/PxvbiBsfV?=
 =?us-ascii?Q?ZXfq998Sal/bgQJZqXRht884+KXxdt1XSG7WlY/C9Ipc3+sMEzJmMS6lu1Cl?=
 =?us-ascii?Q?/3gneg8/sNvrgPO5JcL0jJNjNn27oa3IlUkpGE6qHMMhnl7AIIk9QJJKoCXX?=
 =?us-ascii?Q?7O+7f5LCpNDhKnbRz0YliGZ49lLpG/NLoSRpmEoC9/wmw33OwtbR5YXbKStK?=
 =?us-ascii?Q?oS8GYmPA2pkLOdizJuSv+UM7YMaLVY/JNb03/azwZGh7fjw4vRvILvRurM+N?=
 =?us-ascii?Q?oGj5B6+zoDJP64er90FfZHnQD5fDdOBhoI93GtZXFkly92+MBg6Jlg9fmKzH?=
 =?us-ascii?Q?D5ujopOeO7zvrmJ24CQDPJCDh1ZALudJ9cFV5LplVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a6vw5+LWVbxnYmTqGVRmUC+KIMv4XKVSXTmMMjYJl4wzZXMZUB0ZNRMyK+ax?=
 =?us-ascii?Q?L9X4ZOIa9v7CdHN/YVEH7sPoNlFl1EOJl1nQoJXPaC+dHUZaW89HujA41PSD?=
 =?us-ascii?Q?J1wAfq5gs8bA5XwqgcSOPE7H2A+J00mwkdIesaGQnB2cA79VdllflsQ0U/5b?=
 =?us-ascii?Q?kfmbkIJqbOXbzmW0ASZ30UScmDFoYNgh6AxFSjq81Yt8MlV8XRmq+XLosk2j?=
 =?us-ascii?Q?rXdiHScbqinUkEbBRz8H+qH4++pP1xomZeAAjC5nUndEmUldYRSSMAH1U3KC?=
 =?us-ascii?Q?u+U3/r0v4uTCuKUEhvIxQ1SWopfXnd9fV5T2MNv8E1tKhTayZ07UdgWYML5W?=
 =?us-ascii?Q?CG94lRXEhXSh9wokA0nZOXJ7tVhCzS+3GUAEnbDB3ijLGtwKEoyEepdoR9Gl?=
 =?us-ascii?Q?gXORE77y7TuZzNgI8ZwX2rPAibz/QS22dbH0t+Ac5eqOBggYXmH2bkuq3Wu5?=
 =?us-ascii?Q?Cc+V8ZO14/RTCtGyrxVEMokR1sTvQYZCm7QdXWq5jHW4yyNNXyC3EnTkpBT+?=
 =?us-ascii?Q?KHJOdry38REwXlinhRuJ31ySog5q9TCJF6qSqKSuosJ4Ugh3AwBtcH0756mN?=
 =?us-ascii?Q?x6N8iy/qx6FiWwougKc4lalPce3reCSUHTN91XxObJGylNp8haVXWtd7VtWK?=
 =?us-ascii?Q?mYwa9weO7vzAGGcjbQ7OFPrzxZUjhU4seBBvN3Uy536ird/G5gSwUZtnZT9s?=
 =?us-ascii?Q?/DVi3PPpxaGB9xrFgYDQPIlDoMLqgh1qLifjRsQqpvA3HxI6HF8mHkieY5A7?=
 =?us-ascii?Q?tkefe9Arr1HgPuxT6dbdajvE23Jz69RBljAwpC8G40Hh9Y4tE8uIEIXzevxK?=
 =?us-ascii?Q?4PosBDe2v6Vi0aswkg7gsO9DNPJML9yGGiYfsmtvJS8ZLQ+0tv6H3hVjbg8s?=
 =?us-ascii?Q?8vBa/JbjEgMYz06EAyST3z7YgbjjuojE6eIA6nMy/nDD+uyQq5fsTpfr9+zp?=
 =?us-ascii?Q?L9gAD5jnOqVzwgLCD0+oSNIrL27MjIzMs8jPhsX516nIl4Y4bq16U9dibTzL?=
 =?us-ascii?Q?Sub1GCMLHhl5hsLDoqHpq0UsbscW2IP2h56Vn7q8abwv4TEQQbc0D1lVnMat?=
 =?us-ascii?Q?/jaaokFKzFbFuWBIltVKZQ9CiYj4GVx9JfrSBNepSZtKCvSy+6NzPdxJk71P?=
 =?us-ascii?Q?bvbu7w1puM48ReIJUldArN4hdmr4phfHkrsetkqXnWbxPn4Fj6xdM+PCsa/h?=
 =?us-ascii?Q?qH5Np1/NUmiPS9wLW7V+DerKpuDvmbeh9veiGdoCx9IMzNhCVixbbIr8o6V5?=
 =?us-ascii?Q?+OR4OKpVxlzNCGVYQX9bPplCSQQPeYe7C0JWhFy5lMb9vR8NRoxRP9OcPgvQ?=
 =?us-ascii?Q?mGoigBB6XTsmOxwDbGB17RWm3sxkJYeWpHbtZR0Et7nEwjwSH/xjBbYeEgHn?=
 =?us-ascii?Q?uNuTwov9ekhQbN5d6yLk+8aKFdV+cLoQYeITspoPnwqp82uTdD+4oUlKD9C0?=
 =?us-ascii?Q?g3pT32VohSiSHxN4ZAIQoE4rhV9WmlUDfWt9H7Gm6IG3Mj37QoTTgF7vdF5z?=
 =?us-ascii?Q?R+Y4ArAM9z19EDiUBOZ3OgbbJ9Mcuo9F2Rj7UA+dHilAMrTHE+8XXL4pQF8R?=
 =?us-ascii?Q?i3+Ztc+7rbQfqbox8XI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9df21d-6f2f-4ea6-1ed4-08dc7ab6e70b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 23:28:36.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06s5UPDxkPAJ38p79YjtLL64IGdmpgedwzNIiCH1AmMU9+0iwNV/Gp6xBaKnb9eB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8102

On Wed, May 22, 2024 at 12:47:19PM -0700, Nicolin Chen wrote:
> On Wed, May 22, 2024 at 01:48:18PM -0300, Jason Gunthorpe wrote:
> > On Wed, May 22, 2024 at 08:40:00AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Saturday, April 13, 2024 11:47 AM
> > > > 
> > > > This is an experimental RFC series for VIOMMU infrastructure, using NVIDIA
> > > > Tegra241 (Grace) CMDQV as a test instance.
> > > > 
> > > > VIOMMU obj is used to represent a virtual interface (iommu) backed by an
> > > > underlying IOMMU's HW-accelerated feature for virtualizaion: for example,
> > > > NVIDIA's VINTF (v-interface for CMDQV) and AMD"s vIOMMU.
> > > > 
> > > > VQUEUE obj is used to represent a virtual command queue (buffer) backed
> > > > by
> > > > an underlying IOMMU command queue to passthrough for VMs to use
> > > > directly:
> > > > for example, NVIDIA's Virtual Command Queue and AMD's Command Buffer.
> > > > 
> > > 
> > > is VCMDQ more accurate? AMD also supports fault queue passthrough
> > > then VQUEUE sounds broader than a cmd queue...
> > 
> > Is there a reason VQUEUE couldn't handle the fault/etc queues too? The
> > only difference is direction, there is still a doorbell/etc.
> 
> Yea, SMMU also has Event Queue and PRI queue. Though I haven't
> got time to sit down to look at Baolu's work closely, the uAPI
> seems to be a unified one for all IOMMUs. And though I have no
> intention to be against that design, yet maybe there could be
> an alternative in a somewhat HW specific language as we do for
> invalidation? Or not worth it?

I was thinking not worth it, I expect a gain here is to do as AMD has
done and make the HW dma the queues directly to guest memory.

IMHO the primary issue with the queues is DOS, as having any shared
queue across VMs is dangerous in that way. Allowing each VIOMMU to
have its own private queue and own flow control helps with that.

Jason

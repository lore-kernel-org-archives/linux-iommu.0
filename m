Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD146AF31
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591063; cv=fail; b=YQVwpXQr3gtHdin8afdPnme4RkrsSQDG1tdEQJhVi2BPDkXc5umcYI7RQStugtYwW9Irx+YfigLznLFsWM2VWe7QQhDU8YlC7pw9vhQpyJWsZ4XMlaSZw2ZgI7B+BSF2blx8kwjnoq67GL1JhP0jrZlZVdZKNo6VNmBkhlFrjjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591063; c=relaxed/simple;
	bh=zG21YkLs+wSF9m0ogDoG3zMJx7RQsfCLiPPMEiLH/uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kSoJzI8VMxWjDwYRo0HWiNUzvqovwq6qcC3utgHIQ4YEAL28w9oYWSKr6ycPobwa5hFKzqoRlNWoDOeXYlkaaSyZV1QeA+fX1nUwehJS87h8ZrHdhPQpCSM6oVrTbfooQUsV5TqhXNob0HRifmks4sGj7gYRAZtC668vo0FIKbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TNfOOID9; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TNfOOID9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5br2llUpZibywUSGMv9sO9FMUcml976zHn0lK/vW9moDZAJhSP1wrSdXs1IjfutNgXdytG++IGLxbe4ESzMJaMABOQxdXQ8aEg9S5VBjDPqPw2VCAETkPZPma0cx/iWO4r2NO2pCwmHeK2TMjFl2SVTPI3gefY6oi6WDTOJnz1J/Lt4JiIKvbPssbMj8N2Ptd9pQkBR0OXxNQyKlsRlDm6IVIvYdUIjWEEzA6JucDOX52hqqSuZtlkZGPxO8KhHHQKvowhPFodgba1vBxAMkOEPg1+XR7B3xBiLnyrCzpJC+MyRasiHoRs2kH9lW29kf9cyCPWt9/1fHh85PDKrlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eot/CCGNFq8NNtlu0ZZ5RGeKAa4fpG1YOjoyksOx89U=;
 b=nXykwG4QZ2SK5JQfOnqCrney4kX4/LD1RM1MyKmRKSB6tkyRWW+vMzvfjQ9oUnIPqaZIRLwRllHCJxqADhLAeCAquuimxVsPf0UpI9TfxaDW0mDf67GLT33dijVcVyLb10sGo7OR7m0LxLCqUGP1OQlGup8tYog7xa4O4dUzn8U6Hdn8x+UT2yUPrdUdrt3elfLu/nxeIsITsglTtJ03WNiD15ZG9HcwSW4G++6coXw66KecixpWs8AfCY7lVPuxlgsjLg/ImCeyL6owinwZQYvLwgqTC2aHqwI8WC6VP3WT6aWO7lcYTWI7VM72v/DFd1nmGByExuxmbqSLZIpAgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eot/CCGNFq8NNtlu0ZZ5RGeKAa4fpG1YOjoyksOx89U=;
 b=TNfOOID9gzO7W+VKdsj6bJOSsQTyCDU8KsgSePEfEkRy8W55H5WLtNsuIl/HdGDebvLqG1JK8lyinJUD1+Ny/CEd90XQsjkRqb8J0YMYkvuUyYK2CUawfQGxLVVIo7eXU7accBY5QO7x5eZk7YYjl8VpySfXK3JSG+DHO2QVGKCc6pMpv5CbgcMDIWuBKNJHsefaBmK46wYm1IHdPm9MCdU+rBtdUUcuodXqZErE1Jl4bbbc11JEfIzCKzFDTjYRvCIp9D7wcbW4ljD5djwgvE2lXdKdDEb7b6zo3EK7vqlqqy7/MyQJehOhr/JtwHIIEzV6iiYEUk9ZB0lLTzS9yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 17:04:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:04:18 +0000
Date: Mon, 24 Aug 2026 14:04:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
	tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <20260824170417.GR244917@nvidia.com>
References: <20260821143155.GI244917@nvidia.com>
 <pzlzv2lzik4miqc5oejichltnyqabolyaezbkrufcl7nbttygm@7rdmkig3t56u>
 <20260821161256.GK244917@nvidia.com>
 <dug43layphru76sqleerwtryyerwa4a6n5s4xwrk4iyfru4o7m@al37eknignld>
 <20260821172015.GL244917@nvidia.com>
 <t2l77h22pz2jg5vsgoth6324u36szra3orgr2g2xo7olyuhzlb@53wnsyhz7aqr>
 <20260822140625.GM244917@nvidia.com>
 <r47pwpyoc4ynv57vtwer73dwikqkev5nfy7kqyba7sqzh5pryi@teiqr5a4cw4p>
 <20260824125204.GP244917@nvidia.com>
 <fp5myre5qaersxxshitgoupbzkx2zwo3rsz3q5jfdiarmtwknh@gmfhz3cxuc33>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fp5myre5qaersxxshitgoupbzkx2zwo3rsz3q5jfdiarmtwknh@gmfhz3cxuc33>
X-ClientProxiedBy: YT4PR01CA0503.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adb17a8-0927-47cb-43bb-08df0201bc02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tf1JPDnbHugorPMhwvygNK3J63z5Bfh9pI0KARoGCHJrV5M2Z/jnNMY69AI4doa62h5b8cRo2OX3w9j2+Su0nf/2dhcD/HXFdX0amSdYXq3bRwuLIxoYW7LlCrP/73Hd9ntG+4sZaGWoFlVYsa/sLQA9djhu2HdZaeJfrM/RMtS74SidD3TMKuHkAkxWlkqMP7+2JMY2qSHSjmmBuwHrRHWIOSwTej2CbP4DLZcl7ruYZLIAfJ5jTIRvAkNFvjmMR9/LZo3dz9PZnPdaPfyoeUBJqzbdENRn/VIvTBfyBGnRlqgWqtAGSpofklETYmX0uKtpQ2VYnhKyP3CyE/cBUozV/i10RKrn0nWPso88Z5+O+1wKIjlbWJ7UUTHZLY0HdHcABEhyzb1YEFnD4Sv2Us565CLYg0ih4lQDlXiPFVScM/v70iA3nLUMZfo44jm/fOAMfp+r06Khuoy/OvhZMHoPgCA30UmpW1x8qjmaWXghadGsJ0O0QnafpgT0/Ba5UOiDImbT1hpFxKwCc/00DHQ+6iprfuZnkl46WNBGAGIo3V3YQLE3Zi+jrQKPoZ0T8bRwbzMZfmWOgmi96BlPWicWQwBTneyy6MqHqPCXN7Jj6M+WsuyvjEhLeZhu0ooTMk3cVfPuuH58il4dW81mdx95v1FMJVf+z6xtCkCDaQQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O19NTFyGJQVvIOsm5XB3VueaVFU0LLslhm+X0YqIqTK+Wbx37sghMjt2Jdi5?=
 =?us-ascii?Q?ImdwobfIdIAVdqRzSCC1iuQqTR3IkV8V1Db4V+rtccisWMrcrqlHbn3e9lbL?=
 =?us-ascii?Q?HIzZX/88XSzDSP72aLat1hWuxeiqMOTiaRYHaoOihlqbzuy7i5qBZ1ox2yZI?=
 =?us-ascii?Q?W8cqIEiQ7NbFJBAYED9CdecM3vj3QSe9pbYyVyVxTg60FUw/QjP1MwJNZ5xx?=
 =?us-ascii?Q?MiWRGw48tszxIZUhOdplsfXypob4iwxPJNp8eqJbYb/FbhyIuhdrFHvFEx2u?=
 =?us-ascii?Q?ZYuxvZIsxd3qlpwU0Oxpfsx8WWSmmc16vqpmaHV6ojdVcLC54z7JTv+VVZF8?=
 =?us-ascii?Q?zYp9ZdPbGGKzZWVxv1YtSzzFFQVtcGtoiqrE90zNZ+GN7DJxXdpWGBrxz3Ob?=
 =?us-ascii?Q?VoblwgEZtIfYsDMxASL6CK8X2LjEvaA4IvroxNTy7jpsPVEJcOmULsNFVw4N?=
 =?us-ascii?Q?00R88ZsNJ6RxTRrrKMDV6IDTk7tbBgVnOko1LM2lezWEuJWokchugI1GAp6I?=
 =?us-ascii?Q?gd37RsmHSpC65byLdVJrK0/ldTFY+hKPAzwHGMamk8hlHpIokGBXB3nQmrQL?=
 =?us-ascii?Q?98gVOqCUrXjOCZZ/b3q62FpMDnrNtzORlB3f0uoZ37pV8TsspULr7uIva6X5?=
 =?us-ascii?Q?MsKfkUeGaMvW7QkdgG7XtTB8qIIjFbTz4oH3VZa8Ap2/2Rn94RIXD4GmdcJj?=
 =?us-ascii?Q?W7N+M6dr6tzyspJsjo7U95Fq9iQ86akeccxgVtLzSYxd1eYwNc3LZEbf5+An?=
 =?us-ascii?Q?Js9UtnSmYDfk0Zrs9RbSBoIK9dkzWtCQmBIwK/66bltaodxweAg3ZZcBA5QK?=
 =?us-ascii?Q?MEq/2i/ggv/7Kdb6Cr9U/IsUi33whDlTMBbB/UBDazN0M74f37esM/hS6HnQ?=
 =?us-ascii?Q?M06Zv/IJWefe3mbTzobEv7mBKph2Dqa2oTajnZUKzfHHBFmKATBLLjSYmnHq?=
 =?us-ascii?Q?1bubB0RyJKPdQYZfYPYSuQaXMSnfQ2Xq1EK41zMFvUA0YolCNjJIExXuYJqz?=
 =?us-ascii?Q?Pg01qxZ69ukpyp9RuMY97v3acoGNXAy5ibYRNK7+b8Bzd5lE14/ro48alJuZ?=
 =?us-ascii?Q?DrQMn4HDIU1DqbswEowWBakrsXPQAL4Dmdy42LlyiuODLDCJDnE+RT4PE6kA?=
 =?us-ascii?Q?4I7q5TG0GRU5kG+7KMU2RszrU7akpv2DXZKbt7QsMzmu50fxEMBtWqz0lklq?=
 =?us-ascii?Q?6Dg9TLS8TQ8/Pyo0qqhl1zgBBX63az7ACEb1b1XVf5RYogCwesunf/VU4zNY?=
 =?us-ascii?Q?YHa+L6i8I0fvtuHebj/Z/KAlXJIt7zK98YNDsXj2jNi5WBlQFj7S76ZPBVL0?=
 =?us-ascii?Q?vwdqppNCGfPj837+sZxqKZ4KtR+Kdjfcs4KoO4wkYKJwOwWNJDQDf67yXsFb?=
 =?us-ascii?Q?KLoobv9CXxyBgVR50UiWloAZZkL/l1/xvh5lDp3qkP3rdyUsHpSl91Rp4Yx+?=
 =?us-ascii?Q?85cc9oU6hgQa5/Vgoqc+Wbsddvtu/rXKk8ZRpTH9GcWr4z5oIrXN9qN7VQx/?=
 =?us-ascii?Q?jD6emAVV4M4IdJGYHnE0Tb6uqTpyJCyW2GRLWIaTkJI6bh/9IS2/gI9X/o/4?=
 =?us-ascii?Q?46VyK8d9ZfS6H3ZpM4/t1lPDwTggqEdJY1BUg1yHdgxUX3I/Tm6M3iLmYdAc?=
 =?us-ascii?Q?FdEJ7GO0DKhnNkl6EkNkFaa9zFBEnswOzio3Qy3ghEFdFjF7aa9bRXOrAN2I?=
 =?us-ascii?Q?rHNQMpXMczE4iulpeHNaoUotayVZSf0fEMDdL+Ai2SR4xkBb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adb17a8-0927-47cb-43bb-08df0201bc02
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:04:18.4258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NvpYjJf6lA4M/H64eANXIlVzFXhIaN6kpbgHYvaIezLonzmbKCeulbWIWEsg17M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472

On Mon, Aug 24, 2026 at 05:43:19PM +0200, Andrew Jones wrote:

> VFIO cannot silently switch back to host delivery. We need plumbing
> to establish a guest-owned MSI mode, preserve and mask the guest
> descriptor across the VFIO vector lifecycle, and stop or reject the
> configuration if that mode cannot be maintained.

Yeah

> The guest descriptor itself is already available in
> kvm_arch_update_irqfd_routing(), so RISC-V still does not need to
> interpret or track the guest IOVA. The IOVA can be written directly to the
> device (since the IOMMU MSI table is pre-populated with all vIMSIC GPAs).

Yeah, and now you are getting in "fun" land about how should
information KVM has get shared with the IRQ subsystem and irqdomains
(?)  that need to use it to make decisions.

> Indeed, irq_set_vcpu_affinity() alone will be insufficient for two-stage
> guests due to the VFIO vector lifecycle concerns with guest-owned MSI
> descriptors.
> 
> RISC-V does not need S2 page-table mappings for MSIs, though. The VM's
> IMSIC topology identifies the vIMSIC GPAs used to populate the MSI table,
> and an MSI-table match bypasses the normal S2 page table.

Okay, so that's an odd twist, you won't need to get the physical into
the S2 then, but the VMM does need to reserve off a hole in the S2 for
the MSI table to land and manipulate the physical through a parallel
translation mechanism.

Then that means if an irqdomain wraps this translation it is actually
a *per VM* domain with a *per VM* translation, sitting on top of a
bunch of iommufd viommus, somehow. That's feeling pretty weird now.

> I agree there is some new terrain to travel here. It'd be great to discuss
> this at Plumber's.

I would still try to get basic baseline support landed for a 'bare'
translation using a RMR (?). That doesn't require any new inventions
at least.

Then the question of how to support a S1, guest controlled descriptor,
and per-vm vCPU to pCPU remapping table can be clearly articulated..

Jason

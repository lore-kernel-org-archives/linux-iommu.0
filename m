Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D4F7B
	for <iommu@lists.linux.dev>; Thu, 27 Oct 2022 13:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=migM5MQe+qsR6aOZx/dyQF81/KDpO8n4mDAvX97y6ZbKR3/vTak8B36hYm5e6fBT27U3GTxdpUJjkvVRUx+Lp0/Zl6bbefxNcipl3E8qTrTRCYEbmN0qZf5wOAo82dNq6oShx3putaQu7j8ZGDUWBcing+Q8kUkt2qGQM2z75DXkeXvv+ysGfZie556rrOKUbxFE658ccZUsPIDFdMiESB+7qdQpp9CWpHbi4ukN3zpxfsPxAWPhfHHsoFlwYrnqICURk2dB8rR6LaWbfSwPTJsuAglfG6U83aWvS7QTAOPiUeQK1a0vTMaC8i6d+I6X1p+41uKvkRCGyK93FUiFWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdqHH/1XAwaWUkfXNCsRrdxmZOM3g8OVOTwr6Z8npJw=;
 b=D3OFpLUffNp1E7PoyqUcuA2C8T6aypsbUWlsvG+NJhYq3eyrBfKqWDM42jFDEbZNJKlG27FlZynCQ6ouqU861wzfwyzFowf74Jm4Geap7ezCkS80Ym/JbIq5KBXRxS3/eDBOZ2AqJDDjwdsU4nWvTpJCObK+9L20ggpYwJhBd3ajsu1351PMxtX+9DRiBzxWYeUlIP78swWXsyZ0k2dRvA1mSzOyrJ0WVPZ/U6SYyt4xxPMmcc9zJVabl2E0O5BX8tSJjUM6sFyFgbUH11c49wUgKdKGUnOcyWOEXIubVldLOjmOmpsntG0E1DHfbUT3eW3jPvc3xox4mGyS5lyFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdqHH/1XAwaWUkfXNCsRrdxmZOM3g8OVOTwr6Z8npJw=;
 b=fUbsJbUZ8CPfRLXdlr8DJT+f8S6ThNYpH8PFGpXV1Auc2gtUr9ztsqHaqukWZTVSQVM1MbyxsCH//C+8v+mkKSRk8wz4xepaVc86DDnEvgIaRoxlKT+IL3D6SqbSIHvP7gQqLk/DKMEKU+GKk/Py+4IR2eviPRiM/ugWixW1j0NoZOECn0bK/3itU3PvVIgzwKZUV/C9ErzeivHOEDMdlNo7tsSNgX5ufQ5MRxZ+FwQxr92nlif6LwugpalUJsymfNcsL7lN8HXH4mFcFpSJ1VBP3/zZNteTFLvn9DqA+gcTws65/QPn1VYuvkHoO1YPiv9uVIM9QuIx7poDTsO1dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Thu, 27 Oct
 2022 13:59:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Thu, 27 Oct 2022
 13:59:05 +0000
Date: Thu, 27 Oct 2022 10:59:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev
Subject: lockdep splat with intel iommu
Message-ID: <Y1qOqBXgll9qa7Hm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BL1P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: 246b9fa1-3d8f-45fc-1b8f-08dab8236960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NnMoaTVi+NNVMqn+d8fFLsbT98QrZkfggzLsr9awrAxpj7lsxdfOhVi85O+5T8XKdn8XlrEe+FB6W0Z92wgZRul22c9G4F2c301OgKJPuMuvb1NtVlA8ar0KonLNCnv3N0jPCGnXWHmcolDYxg645Fdm+l5f72KOh7wwiXP5izfCM+7cGkOIbAVDJ4S02asXKeQ8+ycBAcsfo79ko6doJ7rz1nhZAzDSg91byE3XW7Mze/PDOzKbJ1Jfjm5ayUq8nbkzTbNfH/oSwPbGzHDxcRsbxeV39hUzfFo3o7viUAZBh9PtScRbPtrqt7Z0NVlS1GDSCuRv0x8nsK6diqmmsLvKaWXHQUr77JAGUl9Ug9oUzPa1DWYqRD5BCt2qBlEl+OexJ0YcA4Mzpmi6jj1WaER24XPXJNd9FTOE9VmOnrFpQrI1dKZqxmHFRzVAvWs0nHfa0LAIT4L1rMjnwFCA7//KHGnztZOse8lNDmE42UGd2HF3T9cvRyQxswqOLWEaq/7R+z8IDf3lDo9IlwzOv35MHFrPH2PIXoNwF73PQqhl4Ylw3GxupbobADAMGpJK5rqveVb6T/ACMX4oyhYiZLh6tSCQ96R6osDzummBZjShtw8WOg6j/qqW3gYwQopAz4nzbp9Tt2+3G4yFd/EJLU/iXa3fVbsTt9Tb0xp+GKRVwZMnDpml9H2pUAiozFfZvOwDrwJ0iNRKu+bygJezXA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199015)(478600001)(6486002)(110136005)(316002)(5660300002)(2616005)(6506007)(4326008)(66476007)(66556008)(8676002)(66946007)(2906002)(6512007)(8936002)(26005)(38100700002)(86362001)(83380400001)(186003)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KMgycMoKKiDymwSDcqRcDiItfxgKCcP605+7Kf+M3HAer2BjxEQQDUIKEHtG?=
 =?us-ascii?Q?E3hUGHQOPK9Sq2icInXaZgKkSVkPwWf1NwF4z2Or8U5JoGDcdNyCUwyouey+?=
 =?us-ascii?Q?XaGuyTgTbjg+KzJZBaNRklirFbY9B2nqjJW2RxAHMjJUCSASPxrRmtAZ57T4?=
 =?us-ascii?Q?5Fnevd8m9QAIwg2fsB6vBXVq6VxuLjXU0sMAdQZqR7nvOKSGwmpTnwFQH6Xw?=
 =?us-ascii?Q?9TcEllg+3HWuZg1SsPKCgh6DZAOgrj0AVu1vEYioJ2mgAbLAv2K/6ffL1nP+?=
 =?us-ascii?Q?BrplJSpW4QhoZwWs/hUnrBT8sx1fP0SBPTzE6T5K+FHzRkSUfNk/PCWDmnnR?=
 =?us-ascii?Q?/JpB+HbF42RL7sV6pGGvmGJtTUgSFTyWM7Lrqqp3gHHzNmGB+rqPNdizq7pt?=
 =?us-ascii?Q?lMdO1ohhOA7UAwb8u5AO/HR2BVU/b+Awu9ctpvSzo0LgNMASqJXKq11TNHja?=
 =?us-ascii?Q?J0BgcC273N+OXiI8CYJIqdKupXVbww4LF3oyxbiqaJooV/wyc8CWBY0MbxMo?=
 =?us-ascii?Q?nA2pAhfXMhQqLIYz1d75bl5UX4Qn/8Rq1furKbeSARG/ZIilusd0HWRc4mAF?=
 =?us-ascii?Q?CcSsBtaAlRWY2OvfVfUb7RWsiBPd1zV92fjfoAAbn7RLrU6So7L+JUnvVxX0?=
 =?us-ascii?Q?XBNxiIxpIwfb2wmDCi2EfdrECbrybxWDGuEAi6t0fq1BDbFDbXT7c28Te4uh?=
 =?us-ascii?Q?xkB1qYL1Q3UtjbFnQy5PLMHI3LsRYh5zyaXkqUWMnBoRQbkM8vmkF06uP4Ht?=
 =?us-ascii?Q?y+w5+HTEIPLkXSdAI7oCjCkL0LjyZgFlBrbspKg6jlXSgBLsXl+62edoEfI3?=
 =?us-ascii?Q?5uTVcggK9COd1CZdLyFRWy4wBbC/1GRC8UF7WBZl+jUKhQYAtHmMgTVQR2xq?=
 =?us-ascii?Q?X58ayTUjzXbRJMVQB9yjbHcScXH2Q+obi6bvBAdnAJproa6/U1TgaSLOsKBh?=
 =?us-ascii?Q?tCa4T8sHsjEEHUcnHi6l+2ebSyTUYneVZuePHHrkDCs3uFrIOEn68v2O3rB6?=
 =?us-ascii?Q?eumDPWRkQ9UZgSk393AgCk2Q3C+r//vPuN9aVUQbcgqTtmGAwlQSog7oTp7/?=
 =?us-ascii?Q?Sr44NIzRao00FhL0Z+LBsjimGY1DNXFA44/rw7XWA9tNmF3ViMYIGodmYpFg?=
 =?us-ascii?Q?5Xz0d3Vm9QU7sVX3WetDQ3XR1L9vI72SGOPzcOfs2951U8LOjaIg7c2C+dhT?=
 =?us-ascii?Q?SdvSbvk29RCYAkWcK8eDhOR7LqG9/lu+gvbhkU7X/F+cXdqzIraTYGN8Zy+W?=
 =?us-ascii?Q?aT5Kx9LYaZAAGSz37u3Gf/6vPUj0j7QYFUlj4c94luW4z9+/07Yzq5h8dsqH?=
 =?us-ascii?Q?9rZbvrishldxtw+l4xBoCEO+7S81dGMSaWq6BQhLQ6oRN6y8D0rR6TH1Y5pc?=
 =?us-ascii?Q?RHNo6db3ZUdoIcXnapcdB8fvemeQ6yXpbJBC7fGH+cOX1Akwo3e36hFqbvHv?=
 =?us-ascii?Q?teNY9udZq57vSwQMUfwoSC8tqSKEEobQtUWoH1Avc66KrkHBR4ZZLAQnG+Cq?=
 =?us-ascii?Q?6eGCLbgxKKuKYW28wcZ0eUMFXbtG8eE5NZbGJz9Rc8bTDxXfBGHZKeuRFF6Y?=
 =?us-ascii?Q?V0ao0M3nC8Wi4Yxp/IM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246b9fa1-3d8f-45fc-1b8f-08dab8236960
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 13:59:05.9024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qizPNStYZASAWrL257PpGEIbycYlfOKOUnq93uOrjn+/Rl+6gZ+8CSt43d5mLx9b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055

I'm seeing this at every boot, on v6.1-rc2

I've just realized it means lockdep is turned off for the actual
testing I want to do. Very annoying

Lu, is there a solution yet? I saw some patches for a different
lockdep splat but not this one.

[    0.604492] ======================================================
[    0.604838] WARNING: possible circular locking dependency detected
[    0.605221] 6.1.0-rc2+ #24 Not tainted
[    0.605432] ------------------------------------------------------
[    0.605734] swapper/0/1 is trying to acquire lock:
[    0.605985] ffff8880069ab8a0 (&md->mutex){+.+.}-{3:3}, at: msi_get_virq+0x99/0x150
[    0.606281] 
[    0.606281] but task is already holding lock:
[    0.606281] ffffffff82676890 (cpu_hotplug_lock){++++}-{0:0}, at: init_vqs+0x6db/0x940
[    0.606281] 
[    0.606281] which lock already depends on the new lock.
[    0.606281] 
[    0.606281] 
[    0.606281] the existing dependency chain (in reverse order) is:
[    0.606281] 
[    0.606281] -> #3 (cpu_hotplug_lock){++++}-{0:0}:
[    0.606281]        cpus_read_lock+0x36/0xb0
[    0.606281]        __cpuhp_state_add_instance+0x16/0x40
[    0.606281]        iova_domain_init_rcaches+0x22c/0x260
[    0.606281]        iommu_setup_dma_ops+0x15c/0x790
[    0.606281]        intel_iommu_probe_finalize+0x30/0x40
[    0.606281]        bus_iommu_probe+0x47b/0x4c0
[    0.606281]        iommu_device_register+0x135/0x210
[    0.606281]        intel_iommu_init+0x498/0x6a5
[    0.606281]        pci_iommu_init+0x16/0x3b
[    0.606281]        do_one_initcall+0x167/0x3e0
[    0.606281]        do_initcall_level+0xc0/0xd4
[    0.606281]        do_initcalls+0x4b/0x7c
[    0.606281]        do_basic_setup+0x49/0x50
[    0.606281]        kernel_init_freeable+0xd0/0x10a
[    0.606281]        kernel_init+0x18/0x190
[    0.606281]        ret_from_fork+0x1f/0x30
[    0.606281] 
[    0.606281] -> #2 (dmar_global_lock){++++}-{3:3}:
[    0.606281]        down_read+0x37/0x50
[    0.606281]        intel_irq_remapping_alloc+0x10a/0xca0
[    0.606281]        irq_domain_alloc_irqs_parent+0x64/0x80
[    0.606281]        mp_irqdomain_alloc+0xe8/0x420
[    0.606281]        __irq_domain_alloc_irqs+0x22f/0x5b0
[    0.606281]        alloc_isa_irq_from_domain+0x1cd/0x240
[    0.606281]        mp_map_pin_to_irq+0x2d1/0x490
[    0.606281]        setup_IO_APIC_irqs+0xec/0x17b
[    0.606281]        setup_IO_APIC+0xb7/0x193
[    0.606281]        apic_bsp_setup+0x21/0x2f
[    0.606281]        apic_intr_mode_init+0x78/0x7b
[    0.606281]        x86_late_time_init+0x3a/0x4b
[    0.606281]        start_kernel+0x28f/0x36d
[    0.606281]        x86_64_start_reservations+0x2a/0x2c
[    0.606281]        x86_64_start_kernel+0x7c/0x81
[    0.606281]        secondary_startup_64_no_verify+0xce/0xdb
[    0.606281] 
[    0.606281] -> #1 (irq_domain_mutex){+.+.}-{3:3}:
[    0.606281]        __mutex_lock_common+0xf7/0x1410
[    0.606281]        mutex_lock_nested+0x1b/0x30
[    0.606281]        __irq_domain_alloc_irqs+0x1fd/0x5b0
[    0.606281]        __msi_domain_alloc_irqs+0x30d/0x730
[    0.606281]        msi_domain_alloc_irqs_descs_locked+0xad/0x160
[    0.606281]        pci_msi_setup_msi_irqs+0x54/0x60
[    0.606281]        __pci_enable_msix_range+0x755/0xaa0
[    0.606281]        pci_alloc_irq_vectors_affinity+0x80/0x120
[    0.606281]        vp_find_vqs_msix+0x294/0x710
[    0.606281]        vp_find_vqs+0x6c/0x2b0
[    0.606281]        vp_modern_find_vqs+0x16/0x80
[    0.606281]        init_vqs+0x3bb/0x6d0
[    0.606281]        virtcons_probe+0x1ed/0x5f0
[    0.606281]        virtio_dev_probe+0x4d6/0x5c0
[    0.606281]        really_probe+0x1d5/0x590
[    0.606281]        __driver_probe_device+0xea/0x130
[    0.606281]        driver_probe_device+0x4e/0x250
[    0.606281]        __driver_attach+0x19f/0x2f0
[    0.606281]        bus_for_each_dev+0xb3/0xf0
[    0.606281]        driver_attach+0x26/0x30
[    0.606281]        bus_add_driver+0x1d8/0x300
[    0.606281]        driver_register+0x11e/0x1f0
[    0.606281]        register_virtio_driver+0x4c/0x60
[    0.606281]        virtio_console_init+0x6e/0xe1
[    0.606281]        do_one_initcall+0x167/0x3e0
[    0.606281]        do_initcall_level+0xc0/0xd4
[    0.606281]        do_initcalls+0x4b/0x7c
[    0.606281]        do_basic_setup+0x49/0x50
[    0.606281]        kernel_init_freeable+0xd0/0x10a
[    0.606281]        kernel_init+0x18/0x190
[    0.606281]        ret_from_fork+0x1f/0x30
[    0.606281] 
[    0.606281] -> #0 (&md->mutex){+.+.}-{3:3}:
[    0.606281]        __lock_acquire+0x2092/0x3c80
[    0.606281]        lock_acquire+0x1b5/0x300
[    0.606281]        __mutex_lock_common+0xf7/0x1410
[    0.606281]        mutex_lock_nested+0x1b/0x30
[    0.606281]        msi_get_virq+0x99/0x150
[    0.606281]        pci_irq_vector+0x3d/0x70
[    0.606281]        vp_set_vq_affinity+0xb4/0x120
[    0.606281]        virtnet_set_affinity+0x20b/0x2b0
[    0.606281]        init_vqs+0x6e3/0x940
[    0.606281]        virtnet_probe+0xcd2/0x1540
[    0.606281]        virtio_dev_probe+0x4d6/0x5c0
[    0.606281]        really_probe+0x1d5/0x590
[    0.606281]        __driver_probe_device+0xea/0x130
[    0.606281]        driver_probe_device+0x4e/0x250
[    0.606281]        __driver_attach+0x19f/0x2f0
[    0.606281]        bus_for_each_dev+0xb3/0xf0
[    0.606281]        driver_attach+0x26/0x30
[    0.606281]        bus_add_driver+0x1d8/0x300
[    0.606281]        driver_register+0x11e/0x1f0
[    0.606281]        register_virtio_driver+0x4c/0x60
[    0.606281]        virtio_net_driver_init+0x71/0x9b
[    0.606281]        do_one_initcall+0x167/0x3e0
[    0.606281]        do_initcall_level+0xc0/0xd4
[    0.606281]        do_initcalls+0x4b/0x7c
[    0.606281]        do_basic_setup+0x49/0x50
[    0.606281]        kernel_init_freeable+0xd0/0x10a
[    0.606281]        kernel_init+0x18/0x190
[    0.606281]        ret_from_fork+0x1f/0x30
[    0.606281] 
[    0.606281] other info that might help us debug this:
[    0.606281] 
[    0.606281] Chain exists of:
[    0.606281]   &md->mutex --> dmar_global_lock --> cpu_hotplug_lock
[    0.606281] 
[    0.606281]  Possible unsafe locking scenario:
[    0.606281] 
[    0.606281]        CPU0                    CPU1
[    0.606281]        ----                    ----
[    0.606281]   lock(cpu_hotplug_lock);
[    0.606281]                                lock(dmar_global_lock);
[    0.606281]                                lock(cpu_hotplug_lock);
[    0.606281]   lock(&md->mutex);
[    0.606281] 
[    0.606281]  *** DEADLOCK ***
[    0.606281] 
[    0.606281] 2 locks held by swapper/0/1:
[    0.606281]  #0: ffff8880066f5170 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x194/0x2f0
[    0.606281]  #1: ffffffff82676890 (cpu_hotplug_lock){++++}-{0:0}, at: init_vqs+0x6db/0x940
[    0.606281] 
[    0.606281] stack backtrace:
[    0.606281] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc2+ #24
[    0.606281] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[    0.606281] Call Trace:
[    0.606281]  <TASK>
[    0.606281]  dump_stack_lvl+0x72/0xa2
[    0.606281]  dump_stack+0x10/0x12
[    0.606281]  print_circular_bug+0x110/0x120
[    0.606281]  check_noncircular+0x18f/0x1a0
[    0.606281]  __lock_acquire+0x2092/0x3c80
[    0.606281]  ? kfree+0x12a/0x190
[    0.606281]  ? kasan_set_track+0x52/0x60
[    0.606281]  ? kasan_set_track+0x3d/0x60
[    0.606281]  ? lock_is_held_type+0x8e/0x120
[    0.606281]  ? kfree+0x12a/0x190
[    0.606281]  lock_acquire+0x1b5/0x300
[    0.606281]  ? msi_get_virq+0x99/0x150
[    0.606281]  __mutex_lock_common+0xf7/0x1410
[    0.606281]  ? msi_get_virq+0x99/0x150
[    0.606281]  ? msi_get_virq+0x99/0x150
[    0.606281]  ? request_threaded_irq+0x178/0x1d0
[    0.606281]  ? lockdep_hardirqs_on_prepare+0x1cb/0x310
[    0.606281]  mutex_lock_nested+0x1b/0x30
[    0.606281]  msi_get_virq+0x99/0x150
[    0.606281]  pci_irq_vector+0x3d/0x70
[    0.606281]  vp_set_vq_affinity+0xb4/0x120
[    0.606281]  virtnet_set_affinity+0x20b/0x2b0
[    0.606281]  init_vqs+0x6e3/0x940
[    0.606281]  virtnet_probe+0xcd2/0x1540
[    0.606281]  ? virtqueue_enable_cb_delayed+0x1e1/0x320
[    0.606281]  virtio_dev_probe+0x4d6/0x5c0
[    0.606281]  really_probe+0x1d5/0x590
[    0.606281]  __driver_probe_device+0xea/0x130
[    0.606281]  driver_probe_device+0x4e/0x250
[    0.606281]  __driver_attach+0x19f/0x2f0
[    0.606281]  ? driver_attach+0x30/0x30
[    0.606281]  bus_for_each_dev+0xb3/0xf0
[    0.606281]  driver_attach+0x26/0x30
[    0.606281]  bus_add_driver+0x1d8/0x300
[    0.606281]  driver_register+0x11e/0x1f0
[    0.606281]  register_virtio_driver+0x4c/0x60
[    0.606281]  virtio_net_driver_init+0x71/0x9b
[    0.606281]  ? blackhole_netdev_init+0x9c/0x9c
[    0.606281]  do_one_initcall+0x167/0x3e0
[    0.606281]  ? kasan_set_track+0x52/0x60
[    0.606281]  ? kasan_set_track+0x3d/0x60
[    0.606281]  ? kasan_save_alloc_info+0x1f/0x30
[    0.606281]  ? __kasan_kmalloc+0x81/0x90
[    0.606281]  ? __kmalloc+0xa5/0x150
[    0.606281]  ? do_initcalls+0x28/0x7c
[    0.606281]  ? do_basic_setup+0x49/0x50
[    0.606281]  ? kernel_init_freeable+0xd0/0x10a
[    0.606281]  ? kernel_init+0x18/0x190
[    0.606281]  ? ret_from_fork+0x1f/0x30
[    0.606281]  ? mark_lock+0xb3/0x220
[    0.606281]  ? lock_is_held_type+0x8e/0x120
[    0.606281]  ? lock_is_held_type+0x8e/0x120
[    0.606281]  ? skip_spaces+0x31/0x50
[    0.606281]  ? next_arg+0x1ee/0x200
[    0.606281]  ? strlen+0x21/0x40
[    0.606281]  ? parse_args+0x8f/0x4f0
[    0.606281]  ? rcu_read_lock_sched_held+0x44/0xa0
[    0.606281]  do_initcall_level+0xc0/0xd4
[    0.606281]  do_initcalls+0x4b/0x7c
[    0.606281]  do_basic_setup+0x49/0x50
[    0.606281]  kernel_init_freeable+0xd0/0x10a
[    0.606281]  ? rest_init+0x1c0/0x1c0
[    0.606281]  kernel_init+0x18/0x190
[    0.606281]  ? rest_init+0x1c0/0x1c0
[    0.606281]  ret_from_fork+0x1f/0x30
[    0.606281]  </TASK>

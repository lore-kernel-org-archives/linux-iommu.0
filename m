Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0963D379
	for <iommu@lists.linux.dev>; Thu, 15 Jun 2023 02:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686795677; x=1718331677;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Mutn6xCT+aPVbSbHUd52EMeXCfEKkS4LozW+8i8F43E=;
  b=MwGPI0qAKA7D3UDAPjFN7fGMXjoCWlA23FUHzTeqJvs0NiqmRZa1OVDW
   bawCD2wqAZyj95J3FRnuxwwn5s/fA47bopGhmuy1504u2Fi4QX6D3muHq
   dh0OZfHVZ6UpLO784nqGSnarKdOeuIidCDTgaWwEqy2Kn2O2w/hKzG6wQ
   1HNEvW5VU+OikKn01qd8nv8zia92g2WsihNJKPKik/+NThDmdvMqHERFw
   S15KAlXJY1chyoyz4TE5oJCKWjw+bE0xv5IfP6uYBQlrFrNDU/oBvdJDp
   3qjrmHJ1IUDvuBn/XPcefdEwteli6PVSloSCaGgGnNqOhu5E6iL12g97T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="356282912"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="356282912"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 19:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="742071667"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="742071667"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 14 Jun 2023 19:21:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 19:21:14 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 19:21:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 19:21:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 19:21:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FR1uCuA7EkcdApkJeXvjcUT1feH8lQYykYWGODADgRbWaZjlgHUudWzWw865/B4dPtx3zoPVKYn72bPDFTrU2ahwmAvY9WymyusPy8hRXmNeOtZY5KnKta08R23s2pf4eBPgPdKj8HZRu8WGjLbwg/ZOo+kpLRCg3JwolMnompz9QhJHdmMsinxj3dTUcTvuJ6/1ekGW4TmVOEPVsJwek+wLR9XAx2pZaGd/qnkICXhnGVFQfKwoEjn7mzkXPz9rKmnp9iUxLMo91kyNKlh6X80NyZKxVO7Xj7vayCkGGnF5UFc/gpGiwtrn6E420ulS2v2i427PJ+OpaYrOF88liw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmUaBwSgyBj4CHoIRJQ+wEkhnB5sDkJSCBfg29aZW+k=;
 b=dzqlkDVOd4tberg86ik5DyQ7jKJckz448tydzu7AaDQTKcJZC4YUPe56CjSNjY6FT/aXJ08hDtXptkoPupHpEQL9DMNzgAgBua9SyvvnigY6aZ/2pysqDKwfF7gEri17s0PLrZLZvB2IpHjEbL9L0ykyS7JCGwlgiOlX8PC4geL6zHRmbn2REy6Nasp+WlxQOf2OMZio+K+2eWTTnpPXtAyjvklIdwRhqGKNAfDb18046/X2pO57VL9fGNWVuENPqPJcFvgksyEpITA6uU6k7qTV2Td/DOYX38q3dmtyC3wUzEiz+bL76MLtIFREiWVOl+daLfDOx9OCilhKYFH/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CY5PR11MB6534.namprd11.prod.outlook.com (2603:10b6:930:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 02:21:09 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::34ea:3910:8a1a:6a8e]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::34ea:3910:8a1a:6a8e%4]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 02:21:09 +0000
Date: Thu, 15 Jun 2023 10:23:09 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <nicolinc@nvidia.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
	<iommu@lists.linux.dev>, <heng.su@intel.com>, <lkp@intel.com>,
	<pengfei.xu@intel.com>
Subject: [Syzkaller & bisect] There is WARNING in iopt_remove_access in
 upstream patch "iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_REPLACE_IOAS
 coverage"
Message-ID: <ZIp2DZQp/xLMarGi@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CY5PR11MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: ca44e1f7-5ec5-4904-3f99-08db6d472e23
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EH3wNBKgsakpwzkmYjyXQHThDF7aWvUYXn2+ReOBhpJVkJhDXh+BorwxyxQ83kOjL6fx4vYVHYUaJq7VBPFwoU6xXCB6ZpPmzXmYYFGsv1vrb4tsZo3cz9qO2f2x5oA3qVJR2W38QsbvMiLQ+XR3NtK1uyrMSxf+/aq7q5+VUtvzjt9ka++6K0CdD1yH1OfWBDoUAsi68qq9mKnLy55eAvAaPRk/VfXaCRP2ru4Np9FzL+OpLN4R+rqvEB9lmiE4SNlrVi/cfNQuUasyvvBPffR2H0zeSs6VAawMY7GyzwNyxTen+RdxTQvEX04tfyNPkRu3igGu3MPQ+FZzK0x4hkWcRNyNzqMufUiT4RDI4StNhqUNVTm0N5Y9U9muVj5sVJ0z+V5KxIetRlbyYNRF740ayrsJyoTUl6dArFuKLhLm3fkPj66oBcistqxrgkB1WhJ4aQMAtR7N+z9I7BQYqD8DWlFsvpzTVkKljCzifluZQsrIsi4LHTt+pa5QZ2ERkATb0QgvnQRcRlVLBy1+f8Xv9fTqK3XLJjKIPs5AH1vBeJLB5/fENmGn4JTBT/MRSz/KcaaMrhvnYa/QVRYDT0bi1K6FeXQG6L/nNtjrKsagMXFF/J2o5m93GOp8TkfrG3C3e+KNcKMDSDfhwQSWNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(107886003)(26005)(6506007)(186003)(478600001)(6512007)(44832011)(86362001)(6486002)(966005)(6916009)(4326008)(66476007)(66556008)(66946007)(316002)(38100700002)(2906002)(8936002)(8676002)(5660300002)(82960400001)(41300700001)(83380400001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wYDjlcqkeIfWi57mePnJXv9mHnfVro+HHmbIW7uBnis4eP8lCzB7ybrQUxqZ?=
 =?us-ascii?Q?7Ss/6DdeX0h04AskGAgCnXJ9u2/ZFLKhYSBEEUSYyty1WiIw1+xD6fKOaNnh?=
 =?us-ascii?Q?tw3mHo3xN+ERFDoOf7glf+Fg8TAoDS5oUfVTyciyQzg15+AbkE7RJrHjnngt?=
 =?us-ascii?Q?Pd7si5LD1j17+aNFlrD74ywOIXm2YSYXwNh2WqlYGinNgqob+6th5FkKsVwf?=
 =?us-ascii?Q?1CZDeXvKZspvNfDFWajGDHPIWZ/408AeGt4oedMFvRUAZczImuSzuqrVLi6W?=
 =?us-ascii?Q?yrkdV5lKyZZozIkH+4rCiCExSo+aTrcZSsua4l4Upx4zjz7JYAewj0M7xBtn?=
 =?us-ascii?Q?1bCqZwgAwrNwX0mFU/SKYeuF1PGH/ekCxMmBklS668yekAJ/V5M792zFfKLO?=
 =?us-ascii?Q?F5uzuWIffirD+1ySTNY+9SNkXTeeSZRj5lDz3lIaBqHE+xZzvoIqG0yIXaUD?=
 =?us-ascii?Q?txT/uoEftiDufUtD3eJDM9d2W0bq+LVt7bB25h5QcnjBODuwGEn6ARSMamDq?=
 =?us-ascii?Q?8kyWHSHSpBJ7EM9V1LJuRmlIYOctn5Bb+drH1H3hRhcRGRD9obUMru3FbN4B?=
 =?us-ascii?Q?srIqzVIX77dMATMQ4Vyeh22tPpUow+PJ4yV1Xv6OXLGrBQWJJD34/M2iR+1v?=
 =?us-ascii?Q?N9/ty8Hb0oC2mGpTkwjTBM4A8GwJ7JR2UtlxmAPnH8Jbbgf3t3AahhufiBB4?=
 =?us-ascii?Q?t/MneYvpvzW9YAZqcrSk6vuYQf54F4Kh1FyCOTxY+qFAZuu+WXJwhlD8R9a6?=
 =?us-ascii?Q?bl4Hsp6hBkgDobO5Y0XqcW9RdFocTBxHZVUDCpaWduSFNnEypTYvYvaA1sQj?=
 =?us-ascii?Q?N3HDAnDPV4Ij+S4QAIRCMEIdgtSv069wt7KHIi6vlUZmxKtmZkFuZT1mUKd+?=
 =?us-ascii?Q?ejsjnuZco/Hf8rxJ6I4PcxtIbnmG4N/rav6MzBbHNBIjOufYK3N7jcwKsPwx?=
 =?us-ascii?Q?t1NxBwdMx5Bqf/usrgxudWRHtGxirRXHOzpdbjC6F38qFc1C1IQBTGjFx65F?=
 =?us-ascii?Q?vypEV38X9ICJOwG+XB9ggJSFZzaimmFhmgrf/ot9C4npkONi/Pq5PCBvJ7fK?=
 =?us-ascii?Q?2ZZVSwkgENDMkSzTD6ttGOxDS9JrtWMY7g9E2Og3cYpIwJTydrnvAEq0nThB?=
 =?us-ascii?Q?ltMLxtWXVijJtXdVzxe5AdjR/MzrIu0RtqDwgZ9/KTF2elyqBBTUhuMFQtjk?=
 =?us-ascii?Q?iBtuio2bcTyGfhu/Eds6+O5T0B6Vg2IcAdXa0SJhUda5sGRBP4kr6YEGj0vI?=
 =?us-ascii?Q?xMX84UMBaz43YfmTGcaObCDVgqGPnB0c+vS34Vr3Bz3gX/5NEZt1e4N+iyfQ?=
 =?us-ascii?Q?An4GFpMBbEdo08eMlYqIalDXiKqFFfoDASskX1Y40dzgg4jR5p5CZG1vherN?=
 =?us-ascii?Q?YKy/ojgkqv9RwC9OlnogJWWeX20fJUFd0ZRXZrHr1YsIRNiwnEYi6SZ7xdrJ?=
 =?us-ascii?Q?7cmmE60D89TM+UUHt6YtSDxw2dfQDghO6Nbet9Cmjr6LpHnEr7kxWME58Rhj?=
 =?us-ascii?Q?7pwz06iKuUTQZ9e8phkfGRtIV6LkIsBGq1q5B3clUX0F73Lx2UCVcOhXdnoy?=
 =?us-ascii?Q?gYB77B3EbLgCpPY9KkSTz9eDUdpewhIFXuVD8mEW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca44e1f7-5ec5-4904-3f99-08db6d472e23
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 02:21:08.9146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oomZj7jcxI8DQtsvfLWAm2chk7/teOZe0XqSpMi+Fn2xZlY8zsQmknX3E4gUQ9FNEdpUTWlj0pQwz6AoHCruVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6534
X-OriginatorOrg: intel.com

Hi Nicolin,

Greeting!

There is WARNING in iopt_remove_access in related patch:
https://lore.kernel.org/lkml/e93964b04d5b0f45344931fcae0e8696dd649988.1683593831.git.nicolinc@nvidia.com/#t

I tested Intel internal kernel and syzkaller found this issue by accident,
I checked that internal commit:"e93964b04d5b iommufd/selftest: Add
IOMMU_TEST_OP_ACCESS_REPLACE_IOAS coverage" was same as above link patch.

It seems that syzkaller accidentally filled the syscall mutating parameter
during a long fuzzing time and discovered this issue:
" *(uint32_t*)0x20000004 = 0xb; // IOMMU_TEST_OP_ACCESS_REPLACE_IOAS=0xb"
https://github.com/xupengfe/syzkaller_logs/blob/210a8d4069655735cc2bc2756981a944857a734c/230614_070652_iopt_remove_access/repro.c#LL187C3-L187C32

All analysis and detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230614_070652_iopt_remove_access
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230614_070652_iopt_remove_access/repro.c
Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/230614_070652_iopt_remove_access/repro.prog
Kconfig: https://raw.githubusercontent.com/xupengfe/syzkaller_logs/main/230614_070652_iopt_remove_access/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230614_070652_iopt_remove_access/bisect_info.log
Reproduced bzimage: https://github.com/xupengfe/syzkaller_logs/blob/main/230614_070652_iopt_remove_access/bzImage_e93964b04d5b0f45344931fcae0e8696dd649988.xz
e93964b04d5b reproduced dmesg: https://raw.githubusercontent.com/xupengfe/syzkaller_logs/main/230614_070652_iopt_remove_access/e93964b04d5b0f45344931fcae0e8696dd64998_dmesg.log

I hope it's helpful.

Thanks!

---

If you don't need the following environment to reproduce the problem or if you
already have one, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!

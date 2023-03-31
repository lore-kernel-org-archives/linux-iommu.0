Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE6D256F
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 12:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGaS5ObMhocMr3MG5thkZMhNrnqF2yuzsJGo4VyiVPrfYaYaBqbOfm3RPakRAR9lfC8rro5xUFTAykAMSiWBfwrBqdsiioRosQQi7QMb6n/CPaRtFmV3q0b3mseduWF935zDWUY9IcUGYZepSeu0Mts7dOmtBNSsbU5fkGBHhkEs0EBP8FuWqWzxhfIKreJlRZMivgI1qdAf6shv2RMzSxTK6AGMRTFlNYN5mYmpg9FusbN5TmlF6M5Od1sG9K1vqxmeYh3+mT8rr4V1gFSfai8nd16n19XefU996Nxw2pzmuqQ3kXKyMaObZ9KRJ8gCegag8Xcn3RsDWa76JrTycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wscKZ+5x4Twd5W52fRc3NPpGeW2KUsTiugmkdJS5pnQ=;
 b=aus29502+QTiU5pmSvEfrjiutT2NmnmT/6iSPmrlEkYv6e1w7M3wCZiSEtx5WQ9Mqd5BsXVXtF7nVLiIkHR8IRyZPpvwZXbRyk37r0R32uKEupV/tx9zzBqph4K7B5P1QdpeGWPc4Oi16RbYVFsRB8rku5pzJt/WmyGwfi0PbOmD9KOPUL2ocBfCTZst1i3OGypecr9PuzWDpLeyT2lir7u1KfUOJum+QRDt72gcEfDifZbOGPCKL6tBuBGXkBn43C+iv5l6YsZ5VUmEBX0wn1nRTjfAnc1WFwQfxdADvbujVrP7i/hdr858Dr2AF2SfConNXjsvmDrX7J1Ps08fug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wscKZ+5x4Twd5W52fRc3NPpGeW2KUsTiugmkdJS5pnQ=;
 b=eOEXK9GrEdl72eVR5hpXRAXkXNIqTH6iBV+7hllsoRQQ5stBOJ/mhN6svBCOQC+aG+2WUX2eusBfj8o4mQ8P0akeTWol8O9P8spmRXuMp7tkgYWvTaaHkKg20rEBsyjy8j1XGO+cn/0C68Tq1Yyt9GIRcN3w8RnPJASMjYt53I6g7oCbWcC40X2lIh4knHW9ytdpG9nBVA9RUj0VbT4V3siygYIx2ZM1x/I3o7CZ/mXpZYksU9+hyMbtYrqlj3TIVN4OcCuuTONJOZoAHOZJIwZ3KcZOkFCQteBPeABWPehLDi1b6uapaCvfrwKpROJ/C7ogHJQWuQWQNTYkBpX4Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Fri, 31 Mar
 2023 12:24:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 31 Mar 2023
 12:24:43 +0000
Date: Fri, 31 Mar 2023 09:24:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: iommu@lists.linux.dev, kevin.tian@intel.com, yi.l.liu@intel.com,
	heng.su@intel.com, ying.huang@intel.com, lkp@intel.com
Subject: Re: [Syzkaller & bisect] There is "try_grab_folio" WARNING in
 v6.3-rc2 kernel
Message-ID: <ZCbRCvQrzU8jdLlk@nvidia.com>
References: <ZBExkEW/On0ue68q@xpf.sh.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBExkEW/On0ue68q@xpf.sh.intel.com>
X-ClientProxiedBy: BL1P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: a05935f2-da62-417a-850b-08db31e2e840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	STe6RIFQyCFneqWLcGOXegdGmZYti22xvnRqCYnkWj+rxVUhk7gDhqvP177E2E04BxZamIVcqiS4LqmAVnuC3Q0AmK7N26tbszTS5Jz4vKZtrmnHnc0hEl/XHnXtEJi4gNTbDaI4xzPEz07zBLQggYceZq/qa6PVUzkQIXi+WLEBelfBb+2ygE8z1OWfRQPMo2/AsvQZO0hZXLXGGkbmUpbXxt6EMYctEGL2hlijCcKQObhyIUJF1EQ9yY5Ghpi1IvtK5YFT5fm3Trb7ibnsyKF0iqYhruKNdrKGaRxUqVYcRRpMJ1+kS1H9KbzEsa/1aQyH3ox5SF7ySiYx+Yxg079XASA2Vfyzuh42PZ+mI5ZiHMh8AjVzAmlX6D6St3jGf4nGHi5h+e5uXBKIA0T788SEnda3s5D5VFiCF7GVMgSv9s1X6Kx4YmnuVr4/35wbtngZ1D90qx6xb8VUhRwGB7GHNWBBW7olMfIr7uP6pmUHXTCFsI0G9jhUzg40jj673g5OdY71kR8TmkFkBPrWt7fiYC8lYSx4E31tpwXdL5OV3f/hCmGwNRYIg14RjD26I8+Ix95dhLiTGE/UR+S8fJDk8yiMxSNaZvZymkJLmOVLfTRbhUkBnrSDgMEo7L0VNYZO+1KcyMPEkpADfUUTfg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(316002)(8676002)(478600001)(36756003)(86362001)(8936002)(66556008)(4326008)(38100700002)(66476007)(66946007)(6916009)(2906002)(5660300002)(6506007)(41300700001)(186003)(26005)(6512007)(83380400001)(2616005)(6486002)(966005)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0JLHeVTk+Eon2GD6jDlh+3HbgXl3TMf4W3RrvFqePsqPWpiS2MXcrZPea7OL?=
 =?us-ascii?Q?RI2ciDz2Fdv7pexZ9LgzGYER9eIWhrckY0ejpeXPI2LE8TEHE9nRvin26Nbu?=
 =?us-ascii?Q?+Qt1Hz+hG58ooP3sXOH6Baecn62C7OrfIFPjafocPX+OMpu7DN24Qg011jcI?=
 =?us-ascii?Q?oGAoUn7+f28KGmodoYiGhbNTs1ZC2hq0amjCb2M9d27VrT7mqxoz4CLWcMDF?=
 =?us-ascii?Q?20CEocWd7yUBmBIaBZ8dY6HgMm++vIO2dq/zxm5FE8OoqdKzByfYNP4GC+55?=
 =?us-ascii?Q?NIuFrfvPiUyeOSdfcN/O74o/AoP/NHQOZ5xzIlcCOLS8Tx8wB5cCvqxS+yg7?=
 =?us-ascii?Q?4WVr2YmHH5/ceUbZgj1WEEkp0labgQncj4ONqVhwAlL/64K4ILIL6FJV3CcV?=
 =?us-ascii?Q?uDrj5YHFXsyiFwi+F7aYA+Wra2RS2XYEmp3rwjCmrDf628chwqSSsHOfxJrB?=
 =?us-ascii?Q?Dj+MkyMernSi6C2/PFW7voLLHPwO4tiUqRxQSn9DoD3OrAaDXUPArqt7capb?=
 =?us-ascii?Q?V9J332McV5XdGIoM7bDHwa582K8qW4OzJd76W/G901KFxeKb/U1jXfLBpyTY?=
 =?us-ascii?Q?emndXNuzbBFsPYgRFGOC9pfh/BoqfjKFeuyGOK3v0Ceqf1P2Mq4r5QwPFi2X?=
 =?us-ascii?Q?wzZhYYDBpeuzOStRLcz+AulFsG0qC//bnKC3faRt67/R9bCdHTjykwvZ4Hkc?=
 =?us-ascii?Q?VYdTTdxtP76XIgxtvQS6k9QTnebbu6FJbJXP4nDgpc/IrFiLRiMSh2Q+RH7J?=
 =?us-ascii?Q?ZEtRKsLEslLG4OtcDYSJUUml5H0hu/7eiBclUfMrgCJI+FMSM/t9owslIxg4?=
 =?us-ascii?Q?psK6wC/p+Fi2gK+N4JSJVD8G788mbYUXHYcLKo5Iyxz2zMm2z8O0B/zr6U+u?=
 =?us-ascii?Q?U/0Hv1oNw+Bi1JcsMZitLvR56y+lSQsIkTuNegQcrniCaXGAelelU9lC2VTS?=
 =?us-ascii?Q?tVnnWkovFxw4TkgPG8h4+kbRLkLuufw/67g4QnUqbbC95d18fn/ICI6h7XYZ?=
 =?us-ascii?Q?CVwRWzC5bW63/82oVidk6WR5WVQIBjgqXZC0TwWMxkLLeBnqIyJ43wpJtJTk?=
 =?us-ascii?Q?NncA46fDC8skytmyBjtcnvmjia7FQhbhIp/82K+EogCeKX3IAzi31WVJb/zM?=
 =?us-ascii?Q?bz9+rxI+ipjE2WRiGQjVE+qSh3jD1nM2LK1GfCd/owsgVYRL16EoZQeBp7Rp?=
 =?us-ascii?Q?8QEdpQPRj0EJEQZS7mNfx0i2mQ4vaioex9IWOmucjkfE2z+8K5QTOtzu8tik?=
 =?us-ascii?Q?zRdIcACryhN2cSvFqbTwF16+gLbDqCxmGXkGSpHTMuX+ekjCwNm7BQ08A95O?=
 =?us-ascii?Q?kDqUIUUsE9ouKwfh+FeITe1jlpzBqSCR40AacQ0K9QmjK1K/1EO0GVyUaeoT?=
 =?us-ascii?Q?buzuWL8n9b6cZ3oK+f5v0OoeiJFUBbD+Q9ETOcQogkhUojpnk+ZmxqHdJCVM?=
 =?us-ascii?Q?yrHp/3gPA8S8I5tjF/HLyYwj5h8tXQKyPIAaZBiYfB/SzVUXJrsEqZFa7sGV?=
 =?us-ascii?Q?SHQgsM3Mjcx99864cYRLduQnB/ZNxm5mWgXy/FefUjj4bjTUWvjTix772NSU?=
 =?us-ascii?Q?hrVmfcO4BF71MAo0HbSzhPPs9jLVGWtfIMTSNLQk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05935f2-da62-417a-850b-08db31e2e840
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 12:24:43.3531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /J/3EetnsdR1gxFYmLF4tYJsChiOsKH7S0Efd7fVBQ5hwH53Uw0y/45HtXSNCR6K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427

On Wed, Mar 15, 2023 at 10:46:40AM +0800, Pengfei Xu wrote:
> Hi Jason and kernel experts,
> 
> Greeting!
> 
> Platform: x86 platforms
> There is "try_grab_folio" WARNING in v6.3-rc2 kernel:
> 
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230313_234302_try_grab_folio
> Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230313_234302_try_grab_folio/repro.c
> v6.3-rc2 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230313_234302_try_grab_folio/eeac8ede17557680855031c6f305ece2378af326_dmesg.log
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230313_234302_try_grab_folio/bisect_info.log
> Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230313_234302_try_grab_folio/kconfig_origin

Do you have a syzkaller format reproducer for this? It is often
informative.

> If you don't need the following environment to reproduce the problem or if you
> already have one, please ignore the following information.
> 
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>    // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>    // You could change the bzImage_xxx as you want
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost

These instructions did not result in a reproduction for me :(

Nor did the reproduction work in my usual test VM.

It must be timing sensitive?

The trace says it is touching a page with a corrupted refcount, which
suggests a double free, but it is weird that it would trigger here and
not at the point of the double free...

I don't have a guess what this is

Jason

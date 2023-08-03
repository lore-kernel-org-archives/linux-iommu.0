Received: from mgamail.intel.com (unknown [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E44F7F
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 01:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691024514; x=1722560514;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gO48LugQx1pEOPw1AuMBk11tqwawJCSLUYKyC7y3SOE=;
  b=P6Tlc9Qf6f2WetHknd63YKNYoopD85uOwfBKpM8JtrPlhOk7JgbUIA1m
   Fw9J8cMsr3nYLiPI43Z5um0MOePWb/kw0mHqVL/S0XlksUirRdVu4K3zr
   dhXIaPuklKrEEBZCAq+4K4NQGsOOmKVlmPmKo10NVeAywroV+/zkJXL9E
   VCkNSR1JtmGJTwBBTOH9YX54im41qGwwSjUhaZBADNjB+byDyiUJ4n4XL
   csS6xN5KNKxKj8WjjbKd4yQ87jBRgFhh4jvpK/zp20dJu5g7w2vm4rOes
   YLRYZJW+AItmNzcFlMMCYgG5Wkwh5vXr3Jk7cS2EI6hINKqyHz4zCHWit
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="433578847"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="433578847"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 18:01:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="975880573"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="975880573"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 02 Aug 2023 18:01:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:01:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:01:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 18:01:52 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 18:01:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnzoOLZCW74uC3eiFiKaXO8aPNrJFlzD51KCbte4WLiLiMge8dZv04bOgpogaV1ovd5NHs8UTt40M1S3iTieqjkWDlZe3PZkG1hpBILBJfcn8AHKtfo9Ck4fRnKnnEgDHuCVI3ex3XPsMae8rLQpJlh+CCNANN9/4KBMP4e0ySnYbwx01vcRrBignZxBrkW0Af/8WURc/uGTLLyEuOdlUfSUuMTQ3Fct5FeswzyBhLeHKAPKqSqwhi4n03ULZQ6JLqZNC/5XpxltKJ6AaJG4kYDrzV9OXhndfVSKPUBSxJbF1qmIPnGU79tbxrQUuuaODoqkhJegQn8X2C/AEsHjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6TX5Tq3hOoOp/Ra+FbGUnBhu85l7rj6TC3X2k4LqyY=;
 b=ntqZAabAALqw+NO0jzbAF//B8T8s0o+iPaWBl22JkKTiDr6yVOUfG0kPMJ21Q2pkmtaYAPS/xzBGWsjHUjSQqGy9jeBA6VupsT8nPMFSfStFfDH2ea9cDPjAccIRHmFcMkr1ewb2ZSdkLyQSkF5EGJmeHQWXnz/KlrzsJDgP9lOI1Nnwnd8EkYEH/hYD2TOEO9Yzbs4ikrlfBYAOMX5+zYlBXYrH6ZlRiV32IUubvyo+uoWZZz+A7W5lOPUEP5r2XeL2+k3n3IE0x2tYQTVBuczkSk/cSG9W54awy9Y+94aWGTy88N9xW7Rxcr8cHYUQrlgDk9g0y5EBO8Oc3pVoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by IA1PR11MB8152.namprd11.prod.outlook.com (2603:10b6:208:446::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 01:01:50 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::34c:f9c:28bd:e642]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::34c:f9c:28bd:e642%4]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 01:01:50 +0000
Date: Thu, 3 Aug 2023 09:04:20 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <nicolinc@nvidia.com>, <heng.su@intel.com>,
	<rafael.j.wysocki@intel.com>, <lenb@kernel.org>, <lkp@intel.com>
Subject: Re: [Syzkaller & bisect] There is general protection fault in
 iommu_device_unlink in upstream patch
Message-ID: <ZMr9FB7HfHsM3ebQ@xpf.sh.intel.com>
References: <ZMkMt1cTeXhg8yBM@xpf.sh.intel.com>
 <ZMrzJgoQfQFUT7AX@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMrzJgoQfQFUT7AX@nvidia.com>
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|IA1PR11MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a89daa9-6d29-416e-ccd7-08db93bd37f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qtrU+WC2wvoBvWTZnsErwAn8c1XU1G2kZh20fGRX9z07zOQldBIFB+bqFOAhSSV//9hfIo0Rjo8ErLLWEmYZBeP8ZVP95R9XYs3Dh1nbETkzYNU2SKrv+GCoDnG/WOQNXxJUwkflfTuTnfN5LMCIqwZLqvFcXuAT6KM2Q4Kv/5SxL1+QVr5wgSd/glhaAnj/PvGf9aQnJviDV3KBbEeLswZjSWc5LI79aa4HcoeEdQaUxHmUgr1EOq+tiZFeLC6N+hTaw4lwuaOQGYqebviLfWM+wUDWClspst19ZwFtC30Pzv6Y3Cr88/fZa7uje9yKnakZR49ltMn2zz5hZM3UqrUg7OuUV9BanLYYVRg4oIlo9vCoH2dL2J2gtiyxTY5JhjIYag8ExvRKpv7kpeR9LBOFIknJ9bfkC2RLWckcnwsHIHJxjPnFJBC8Gb2shM3usKxEIjDT4Lhs25YMGJFlK0oyTt0ghgPMDbJmtsjQc8gKcdDN5LzNejlXbVPqjL00co6aRo/rcG3BIZ0wwPxZCbEmN7wm094jQAGfW5aZHQ4eEJPc52wgON0jSeYXTyc/7wcI/y4h7YUvtcrEUGwScQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(53546011)(6506007)(26005)(186003)(316002)(2906002)(66946007)(4326008)(6916009)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(966005)(6512007)(478600001)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BwFuiPZScFZjN69zNK2xmskGUxlIP5K9XMtQ139enOK/hGXwCNpxpGh0ZkNC?=
 =?us-ascii?Q?zUpd36s/P+ONn6gXZcAySUlHINjhoOSyRrrOoBe8Txc7XE0WNHJnR6xnqnIZ?=
 =?us-ascii?Q?q6QMqQm8O49Y0Ik9VCD+j5OexEYNGLNmLcxXPK29CSGTHR2GT+A7Zqilu0Nc?=
 =?us-ascii?Q?wwnSi8kdNK2GIQuFDd1ajQCD3Dm4Yy4mrWtAae09NPCCPLTxtD8ITifAVh6E?=
 =?us-ascii?Q?RM36dfOSCY3ALtmsJZcgwcHzBmiJdreKKo8gZFPnm4g9zzsHdlShf/dPXBCj?=
 =?us-ascii?Q?sGKNcZE/ANFxreivk5Sr8GIu8kixuBywFcx1wBcOyUl392Jl0iU2+vS51xgd?=
 =?us-ascii?Q?HQi16dTl2Ebw82GqvQB71Z0BPgjpLz679/Sct5hzqqlxrygtLQh5VFlWGjYY?=
 =?us-ascii?Q?i/KemKx9HHQ9FlmMpd66rw8pbNc7G7aJr/iIbEAazRF+6/tZ+XAB2/O8rx+j?=
 =?us-ascii?Q?zQhVXqqZmRBd7+ZrwsCyf05PjSS8kC78o2LIKQfM4zFTW5Gda3WJpmO5e6dj?=
 =?us-ascii?Q?UGPSl2SLuPSuvlr6tiy6bsVwn3bRSdxF8hvm4xeMGbI8JtEOxs2nQ/gICS2H?=
 =?us-ascii?Q?Bx62BhEFGf83ihkpBsvsMgA7Mpm7/lV8KDZLJ02KV7ZMHBUp8aLxun5Dpv4F?=
 =?us-ascii?Q?pAAHXIPe/7lYEjtUiw5DaKfGAzo7oRDRcRP/Ayel0OW7Zm8ibMukNWhOFm2M?=
 =?us-ascii?Q?o1Xvn/n+5dlphwUvTwcsy4EXl3ZJF5FxJemTn3LUvFE8Z5qPhfWDTxw9pcbB?=
 =?us-ascii?Q?1Jj1oQQAcfLWhV6bR/GLjjnm7umWDGL3DJx8d31MfnJ4L2yJSH8KEjOM0aXA?=
 =?us-ascii?Q?lQ9k3IdUiCOpycLmOY2Fh8kOUuR1sg6v6KDLgGoS1R9gKLOx5/M4wvrX4dqA?=
 =?us-ascii?Q?v8mEtBajouOwnyuLQ7mKb+vd99c0rRV6obR/enJRKNpIxHgiTBIOn4qc5lkv?=
 =?us-ascii?Q?olHFoIUJ4rFtrlxqUpC4slE7NjkmWbAjt29DKyTorYee83F9W/iUUb5tsncx?=
 =?us-ascii?Q?1DJQoUqPkCXkjpIGew/5uOwWgPsA2QlGIi6gIee69Pk1Tzd9dOo8XzW7bjin?=
 =?us-ascii?Q?Ubr0QQvT8dBX/eC7rGbdmbJId6p8wYFp+GxTotFpPUm345Ydukj5JLkqVQGh?=
 =?us-ascii?Q?k6wWh1pI2v4bb1fwjpsnyM8nLsYRszZuT7t8zeJlF/lRjqOqBTdJ+lNljzvs?=
 =?us-ascii?Q?0D8G4VK6IPtbsUnT4lyinCxkHyYxlObiq+lciGjE0szJPmFytRc3+qIEzc9I?=
 =?us-ascii?Q?plfykW2eVa4sTlvzoI9PiDrp+xzS/RNWiRYyahk6zAj3ABHgzwioQLtzS0Ke?=
 =?us-ascii?Q?j09CwdpEvRKH/XDlQhsrILsJrMwaHyQNU6wUbULz4oj9KfEYzSdweEbXOzbT?=
 =?us-ascii?Q?8jLgBuIi9nO0huncKl3laTEsaAqjLZhZH/3TW3OXdSYly48gmfwr9pJ7rakT?=
 =?us-ascii?Q?/ChSaOT4mM9x4nLs1mlCbLfIIHZ+PI9yBbalq0sjZLTdgndsJyhmK+deLPAQ?=
 =?us-ascii?Q?dcMRPph5bm+PIICNZIlzhckbMGlfrOj60rRnqQNg7URWJrAj+XGzNefDnViV?=
 =?us-ascii?Q?+cvcSCTxcKDPSwZm4IKWjzBWamff49fOP6FqglF5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a89daa9-6d29-416e-ccd7-08db93bd37f0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:01:50.1223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BhrQcEWCxaaJX5rm7JxJwThm1W0Z7wRh108FWKhB5909lCMDb6uOVYxJ/ivFxAZzFuxpqG9EPnwwnctuvRP9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8152
X-OriginatorOrg: intel.com

Hi Jason,

On 2023-08-02 at 21:21:58 -0300, Jason Gunthorpe wrote:
> On Tue, Aug 01, 2023 at 09:46:31PM +0800, Pengfei Xu wrote:
> > Hi Jason,
> > 
> > Greeting!
> > 
> > We tested the intel internal kernel and found that:
> > There was general protection fault in iommu_device_unlink issue in kernel
> > and found the problem commit:
> > 14891af3799e iommu: Move the iommu driver sysfs setup into iommu_init/deinit_device()
> > 
> > Above commit is same as following patch:
> > https://lore.kernel.org/linux-iommu/6-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com/
> > 
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230801_150257_iommu_device_unlink
> > Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/repro.c
> > Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/kconfig_origin
> > repro.prog: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/repro.prog
> > repro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/repro.report
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/bisect_info.log
> > Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/a3fe9a2e1692a413d887a6a0f1184c26481d6a2b_dmesg.log
> 
> This is only an issue for the iommufd selftest and it looks very hard
> to fix in a micro way.
> 
> Fortunately I already fixed it here:
> 
> https://lore.kernel.org/linux-iommu/15-v6-e8114faedade+425-iommu_all_defdom_jgg@nvidia.com
> 
> If Joerg doesn't take that series for this cycle I'll feed the above
> patch through the iommufd tree to fix this.

Great! Thanks for your information.

Best Regards,
Thanks!

> 
> Thanks,
> Jason

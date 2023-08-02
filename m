Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA707460
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 12:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPNL6A6LqfJSYoGvuRbkKqxMPDeT4q+hHzVIyCK7Z1Ycoclbv6s+/c8d5sQDSOHv1sncFXlgK86nTIuE9vWAUDqkhhY4bCHhW28Ex2zU1Z+nMIlSfnSaQHU2/jxLz7dV9ogxAmAseWIRtQpsQxyLf3cK106yB1M2sohs6BAwAPTSLAp6I0YjGlRge3bbI6Ae09R30vn0oZI4W7CWjNrediVHSuSRNBRXLEWB2EbRYiYlitGDEk5bz+TxNROOfuZfN8hw9FmppxcCKUwLwnbnEa4BH7gO0ip617GjB5o8dD0QhwE+8FbD/hEE1Bjk4LWD3HLztCF5JYW18zbNvXudhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqXzVNcmWNy9nk1lRjhUrtZUOoaDRgWcrq4mYK4SX7Q=;
 b=Qee66PrNzScX2HytZO8KLK9JkSQpwlnjKPMRLAirADTIdMBkUu55zYOK39o0wQPwm3Sqwg6fNjwT2B/Q4R0u3GcgYrz3xKdgGVEKytXBamEy2wWnFvr2JVtRCoFqIJ/3U/qQkf9Z8EDwk42wCrrUciY9XqPpFd+d/RJBMcnSRRf9AOcerodxRob10WxazXV3HhVKylWzxhoux5lGi6zO1yq3KR5HLk6bK1a+0t2UzOVdPgtRyNQImTOCM4LJHV5aG8nb8rV6DjVw8v3nxFXgXlZhpb3PDq3SofPsQjdnikx2wFHg9ztR0+C1cGJ+dSsTkVNGlxivWcQyC0zAMDqOsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqXzVNcmWNy9nk1lRjhUrtZUOoaDRgWcrq4mYK4SX7Q=;
 b=bBTalQpbZ6H1zge3e6wcqGnQwn03WTHQA2ZgrZ8A8dTDAGjR+jC+7KibHxat8vLT40eDObWv0izZ0YHTPsbrIHif6/AFxpF8nvmdMXMjpPcolzAE5P+xYLfJtIie6rwWQJBcIZA6MOZUMkmoOZV/1dClcQ76GJrEO+unqNddt2GCcbrIMkXH3yx5ZyZfJ6L9+W+BHsf7Mmleat06jrWUfhGhOB1k5nx8MfFvN3DiAO/0MHLBjmazvvgEYLaDs6z+R1sLfXDEPTld1iTFDgkugZbw6ReHw9lP49MUgr5vvVdCQUrIxXvW9hUEEft136DvNBL776hDVuNkJDx9E0Ux0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Wed, 2 Aug
 2023 12:26:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 12:26:52 +0000
Date: Wed, 2 Aug 2023 09:26:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Pengfei Xu <pengfei.xu@intel.com>, iommu@lists.linux.dev,
	kevin.tian@intel.com, nicolinc@nvidia.com, heng.su@intel.com,
	rafael.j.wysocki@intel.com, lenb@kernel.org, lkp@intel.com
Subject: Re: [Syzkaller & bisect] There is general protection fault in
 iommu_device_unlink in upstream patch
Message-ID: <ZMpLi4TP9//n8EU3@nvidia.com>
References: <ZMkMt1cTeXhg8yBM@xpf.sh.intel.com>
 <027e7c04-2d92-0b00-a504-56f51fc48520@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027e7c04-2d92-0b00-a504-56f51fc48520@linux.intel.com>
X-ClientProxiedBy: YT4P288CA0051.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5380:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6eeede-7a48-498d-3614-08db9353c088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cUzp46IEFs6iV2K4/HkMVbsGlWNWYh//cyqVxGqDbarpsf4zAU0KeFg086JaVHWvqb8ANz2IfAMgmYpeNfW2jVYjTsM3MtM49L4mdBVmFCK/T4MoHjA6X144DVTrn+qkH94skxKa0anrEUqVc6J1A+D19weqQFZt65gE/KpQW+nUZY9R5aFwG4dUtmgL7Qi5Uh71nIfeccWsaOBRUOq7ULPIFtnQGYw0uGqjeAqB2sBkKeREe7527Ky/YVnIRVK/72dCQjhcAG68aBjj8tx6D0l8yr9QdxOUaCeMz9Zng0GjzSw5bvhgmiPvXIpaNvPfeNNjK6ULvAK3H0uDjLgxz8p9MVf6EfGrgfMRTmUpAWhbZ88Q0ib69Z7ZqD7EVQDR0JrLTq5ZNW7JgYOffruBqOfIZfe18eU9uXQ7La5MZqw6xtJJKXQTWm8F/ohbYZ8JHnsEwcRJJ1dHBxcmQFyE56Wla7PHQrJzb1YnHXhO/hO7PY0h3BTCQdsKHlFExb2Afk7h8j0X5jS5GPL18Ff9ogUeFPJcgldnfxvcef05/+lSKmwk7PBQQwBH5ygPw5yk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(4744005)(36756003)(86362001)(478600001)(6512007)(6486002)(8676002)(8936002)(41300700001)(316002)(5660300002)(66556008)(4326008)(6916009)(66476007)(2906002)(38100700002)(66946007)(26005)(2616005)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/IFk/O8sr/qief2YmjHCZvF/80P+3cB+pyplYUENv6aUZgn8XjAWYRrNkzLG?=
 =?us-ascii?Q?YwEmxxdAEI41Y/pBN6dIyb1aDERJN/7Os19kHhL8uYwz18WxS4mwJBAnJxld?=
 =?us-ascii?Q?A3zbBsPGTIxLU7ius/xVPGOvgOuaZEe8xXK4nwOUCXyivsWT0MlIZFmhzS9a?=
 =?us-ascii?Q?TyZHDdzGBK2v/2o3QrwsJ8DMLU7Hj7/AhMc9c3kc3D1Bk8oUKER7D+T83/Cd?=
 =?us-ascii?Q?y6JZXY5wVKxRmvA47V5z4HUz+1HvsIyIFu/UkQ1YyVZhO1QanhjVUTkm1IrA?=
 =?us-ascii?Q?FoOsQn6vPUq8cPyarV2p8A5FeSKQSZKM1GmadDiLV+zn2odDWvOAnG+wKAD6?=
 =?us-ascii?Q?DODQJMtg1Yexi1/kq/V0ylmdwXyze5vHUxweNhrcZG9qF6YFgE09bm475tJL?=
 =?us-ascii?Q?OCknghog1Hsylyunxc9MabU5hGklqnQwXmPS2sQnff3NVNB8zph2GUEVQ9vB?=
 =?us-ascii?Q?Q/+pwyypTJyf7PuRy0gUSIEmuxdI+CsqqmafRE1MZtVfVGgtDHvAjPrWgMOe?=
 =?us-ascii?Q?2GAw4CoYOitWrfi/ylFCJsSA2oeym+zBXZRGRy/Ogu7JqB9Zh8KxgURDN1CK?=
 =?us-ascii?Q?UjWkYpm7CBnc6CYv2cNJHx797K0FYWIGv1tjMGrH+AVO8ckkO9aH/LldoVY2?=
 =?us-ascii?Q?oBcQIrIPHhHWaYR2BwZlvZCfVOSUiu1sTGnnSECp9jmEe9kXh3POCc+u1NZ8?=
 =?us-ascii?Q?yRJEf6l3gtkhQ0RTIhpnJjRqBuuWDaloJocK+qSAwKzYWB24jJxFde337OkF?=
 =?us-ascii?Q?zkuF2qC/GT40A17zDXmaMO2cQo9NQYfzdZOhmHQvjsKHLru5i1c6jso5dokQ?=
 =?us-ascii?Q?a0S/RxRPUnjEB55XMKtkNGWtDYjrZSUT0Bqr65awkcdPc67xL375GDDHRz/x?=
 =?us-ascii?Q?YlDXYtGJhoo0DEbrFu3ovVay/h0NWNUo/yZHb5BU2cHEe2FneITsgPoEoYqO?=
 =?us-ascii?Q?IFUcVAAXdLt1oQZNPimkCFLBVHQaYicn2SGjCY4BcwJ7mkFOEG3iliS63sy+?=
 =?us-ascii?Q?A+6fI+u+1NWgy54ykECPB/oYUqZFoFYsq7HswSU2n4dx2Cs3r3G+jar4d0vl?=
 =?us-ascii?Q?2KquYGiKdp0DO73N+9Vb3RundCKABhBOjAc7Z8tlhJ1RXKrRKHkRsnUYXVN3?=
 =?us-ascii?Q?KoIuPBEFesN3y+k4lM848b3BYioSrapxNwj6mj/8V2an2ybpp+HN1JRLFO+4?=
 =?us-ascii?Q?bTiraRy2sH0erZ/jsvUXbCs7VuMQUQkNbOWXx4BVHNJsgsVSnrGNuLVcKuBR?=
 =?us-ascii?Q?9HQW8YR+4FkrJ7VatrNpJtMPMMPQISJL4AppAp+UP/HIpgwjASDLWINblCyQ?=
 =?us-ascii?Q?iErVDedw5p7g9/aLjIo1hJrxzZTNyAICFSETNIOZ07EMhULytVIRrkHr3wIy?=
 =?us-ascii?Q?iVceMHEl7rDd/oLk1t2xD1242a0sfwwTjgwSTXMf+dLeyCuSKvCjBm0AU3bn?=
 =?us-ascii?Q?iMpxmCPij5QIqm397woW/qyzEOqBVg+UfMrBCAJPeF/bB6jz2V0ohyhg/1gz?=
 =?us-ascii?Q?DFbmyoGzq8mDqX6VrAmfdOzl3vh0p4WXOLukvSzZaJ8PTjuVehSf2lKoMBba?=
 =?us-ascii?Q?GIeVqdLbI+JGSNWxQEbwJt7KjdJB4KphzBKVfUwr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6eeede-7a48-498d-3614-08db9353c088
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 12:26:52.6471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrK/bHNFB05Xe3gO99NeH8hi+AtefsawtaFWzQRmp4+KEcPzHz9fNAhS5mR1WXCO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380

On Wed, Aug 02, 2023 at 03:53:03PM +0800, Baolu Lu wrote:

> This bug does not reproduce in the testing of hot adding and removing
> PCI devices on bare metal. Is it possible that this is related to the
> implementation of the mock device for iommufd selftest?

The reproducer works on my test VM, I intend to look into it today..

I guess it is because iommufd mock doesn't use the probe path, I might
have already fixed it when I redid this in the series to fix the
default domains.

Jason

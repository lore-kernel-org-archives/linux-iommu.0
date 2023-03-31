Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863BB8463
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 15:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDfX5cQAzcVHvemqGjeAHPMzSFM/0VGHpTjzCKCAx5RLKdKBlZftlKMJ8BpzE5CJPePAhDkGR05sTuL4XYUD+wIUqlI7+pSOkDqEatiP1GBauV25gvT0m+l2ecliKulzC6KbbQ9aQx9gOm7lG4mht0TELh8jMpQzRqtLfwGL0gPWGy+atx8hq3QNqmNs2AsD5zhZMN/ud8ht+xiEuruHq8PH/NlJUF5jaNjNKpPuUcTSFGcjjjofqN8v+SlNC32pA10dXHCtz3Un9ol4nf72dB2gzKQu+ImIcTSSlZly//48HQ6kBDAU0q+7TGpRmLFzdPoAvtxraGJR8CjL9apeXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mw8M2k8TMxVgnjqHus3FdpDElrV1AU/fmOnc3kaMXR0=;
 b=hG6bqIvkQ8uZx8JCEYf1hxN26mlc6VV/LFm7xq7adX0yORKasHL4YroPl6LcCuJF+c1jKgQSwn7eE10pgunGSCzGeOktzd8fuoF2a+c58QKjF8Y+1LVo78z/YRJ3a7IBJF+vlRXIRW8n4C7m0pXCgLoFh26tEsaDnvogfxVa5hR1upw7bR57XPgCYC6uAYrnZ5TVyDTGCZzEAsHyuJGzWaxP1MwkQifZd9yl9ALogVRsCD6nvL7hS7DHIrTEHpyP6BhlfkA1bbSYEXGP+aj+oOSs4LIp54MdwGrjNhFOdVL0/K/iRc++aGTdrmmaL4f2G6oV4IvmcZxKY1Oasv1BRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mw8M2k8TMxVgnjqHus3FdpDElrV1AU/fmOnc3kaMXR0=;
 b=oO6yyVFvraEBL6MyhSH+oN95hlJ/jB5dLR0h1klfnChtFZWRy7HzqcWS2bsC6XRvSt6SGw/0SD/y/5RP3UVW1ic6lYg2jIi9JeQ1K/eh/K1XO7Ky/6mBcZzPzRH9ydcxlMAwjCPMomEXxzr9TMUQ8XtgT7xvN/pEbZ7Deob4EeKcrehVvghMB4PWOvmFzeAWG1ZFmDCGHmP4nNtl7BKTB8YpZuRYwVasmqP3gkHRdaIH00AYy54dztLuwIc2m27suDr8PzKpSscld7gIJO6U4tsXvADYUOuYCKy13tqKDBcXKivzTDVe91HRoaGY4ad47VcJgBhYQBIdziNHUmqsYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 15:33:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 31 Mar 2023
 15:33:04 +0000
Date: Fri, 31 Mar 2023 12:33:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: iommu@lists.linux.dev, kevin.tian@intel.com, yi.l.liu@intel.com,
	heng.su@intel.com, ying.huang@intel.com, lkp@intel.com
Subject: Re: [Syzkaller & bisect] There is "try_grab_folio" WARNING in
 v6.3-rc2 kernel
Message-ID: <ZCb9L77MUeBl5RzQ@nvidia.com>
References: <ZBExkEW/On0ue68q@xpf.sh.intel.com>
 <ZCbRCvQrzU8jdLlk@nvidia.com>
 <ZCb08lL4ISmEmanj@xpf.sh.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCb08lL4ISmEmanj@xpf.sh.intel.com>
X-ClientProxiedBy: BL1PR13CA0255.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: b72e5bab-6827-46f0-af86-08db31fd37fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R8Jec4y3FlKT/J8GjcrPeW+dPwzIOl6Gss0r4swWsSogTNpN6hGDQkrzBz6cLrOPa53Edg7FhX0aa6loxJFGro5/cIj9yrylCSw9miTlQL68rwZEHzbAu3rIh7BPShiu6Sprbq5rbjcIDhCNCmORxU4ebY9OMGl6VSqfuECrUQ0oKzz+SfhfmYJ8IETFfn+jrH89yUyLDXZYw2twannp1qorVNnBWGwrJBeHJmlBioTWvd4iGzdtBP117/tt0EoT8Q5M+w71wlxYBHfiNZu1xQNI4IlJyCEPdBoX2FppXCZoI0iodNDEGtk2fcOm7dujZGq3FUGIXnzLN6l33szeTNmfsmg/IPkdwqFY+LGWLqZ1dhtZxpwH24qyiqg6GFOoXvLBH7ourwQLQBqD3yAXJaJ2XG/PYpF/t40cJr/1D/D7D2ee6o6dWVNMXjx763hdx3UFaZ2ADESarsvy8mrv/FPNjiqiz/8cd74VBE9wrlzTtHNRseK3haoN+33zgm3KciGwJVgdgKabvOz0bRoihk09EwuIWLp2v7VMwyZAjXr2WsP+wFX8bc95OdEDWyV7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(66556008)(6506007)(2616005)(41300700001)(26005)(6512007)(186003)(38100700002)(86362001)(8936002)(36756003)(5660300002)(8676002)(478600001)(66946007)(6486002)(4326008)(6916009)(316002)(66476007)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5F8jyRPJhJ0s7f8oK4TpXIt0fHXVRZrYSqx4nWV/u6zCWCBxOKp/BUzTHuVT?=
 =?us-ascii?Q?ZlxhBAwcxTnudr0wpbE5sz7nXznuMct2X9oPnpitiTjH9RP4s6ZNW27vIn/v?=
 =?us-ascii?Q?fU5drMrLzGjhMrqlmcGCuxL6f8azLarbV1fiie9sVKkK/Rkkj3n8KmWzTaJK?=
 =?us-ascii?Q?YzqF+l2EkVDtDu+86M93Z0QWhwwG1k+mkfN190bLFnIa/iscZJCSzGTMnzdO?=
 =?us-ascii?Q?iBPad4X3EpwuqWorEsZmvhfGwnEWqRbiA+LF31fcom9WtjX8P4a/U4+bQl2U?=
 =?us-ascii?Q?3Km8wTG9FxvZbrddROdTeFwXfLyKubvJrLJpN+JTs7xYn3AmipYh0KFwSz3+?=
 =?us-ascii?Q?ox6GJlnRNZo6PshYpWqgfBnmsu8eytHT+1FKB3kNKyvF1tvYimFsQgqGB3E8?=
 =?us-ascii?Q?EPrSwcHwa5cE71SfyvAvE6tQp4km0xTm6m7bUVJb9InqiRkdmyRdV+3XSCTK?=
 =?us-ascii?Q?igUDStnddsqHp3ENVslIK1iU2IhHAvyJrs0mo9JRnh/NLawITe0eilKvVL3p?=
 =?us-ascii?Q?DauNkm5ylC/J+gfPP/tHkspgpbLsBLpeCwMz+dDNVb7/l2+iFg2e5OII4qOo?=
 =?us-ascii?Q?8zXQmkbYbnPyx9rDc03Av3KFUP9xmNrdeweqn16dB1g1ozPX4lXBMLRHV9FO?=
 =?us-ascii?Q?JJ4sl875RcdfWtKE6VZ/vFjQxWZzBwx98L6G2sx6EGHh0X5juT6ketT6aZWU?=
 =?us-ascii?Q?gAvmVqyP7NrXCuVoOPF5xnp1sQnZkrNwKQl7ioXMEo/F0+7U8heD5JvlJrhV?=
 =?us-ascii?Q?eF7UGZWsshtvLQwped4VcJjfhB+wAahV+J20b/dadX/fptDJftfTIONZ7cZC?=
 =?us-ascii?Q?vPJSfMWqjJ57iMomJaW/ImaB9//tqzlaFC5dg45ZBz1yAb6tL6UePrgmybPB?=
 =?us-ascii?Q?wjGr44DpzHNFhy8CsH4F5+x+YIlSs3EsG0orT2KYItJGCwKApbsJS6i3cam6?=
 =?us-ascii?Q?xjB6eQpqAl2cO+gd/rnzkoFbLRxwmMHtYcFr9Qv7buIIZlxUrB3xuvEvyxMh?=
 =?us-ascii?Q?1lngUzgUcb7l8llHbwwQiYFCgBQdj9utAroqIemouOZ9cJCS6cFqrR3x7YJH?=
 =?us-ascii?Q?m2Lfl+mzfIlteSrbHgOBlHru0k0z8qcRNYdnsFwfH/fp94D2Jky3ylnLRABJ?=
 =?us-ascii?Q?iXyJfUzEWxzVTG8TUXkGZpK1p8vh7KkKF15wZjdNu9vGiq8SAjeJXwPGku8T?=
 =?us-ascii?Q?T4X7CsH13OKzBJvw9QihllC1YwJivxWvhUqY69FEUMd9vaHXmwjpDTJIK+Cb?=
 =?us-ascii?Q?N5RFAdeOdCrW1Mp9nCaKA5UU0MnL6rtbiW5/JQPpV3k/LiquyZLQwilG6VNa?=
 =?us-ascii?Q?+/pa7P7Wmck6VGtTEpeKC4XiN2WgzXh2RcjGh4gaj3oNx2gsu69bIoaWyrMv?=
 =?us-ascii?Q?8JxITEeEkGVu/kFTPQXNlkItxqHI82c8BWio4Anm3rA3/yKTZsNRxuyp+O64?=
 =?us-ascii?Q?TpZmHLVGspV++X0BfiA5RyonJ/beNZ9RpI/pLk2VhopAEJwUGLWkNj+DghTC?=
 =?us-ascii?Q?0xqRRrXtZhsN51V+k5dTpc8RblvRTrkauVWvqKi0NcnXAHahBmSKglX897Do?=
 =?us-ascii?Q?7AJ2mBZYmt20gpC+IyIPxyV8jt2K0NtEa4ntSnF9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72e5bab-6827-46f0-af86-08db31fd37fc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 15:33:04.0256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03Gv47vhiJCMadTw0Ri3HQ/jAnpAnsDZEuXECvOtgtU3VagbbIDnBHy0iGsQHywU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617

On Fri, Mar 31, 2023 at 10:57:54PM +0800, Pengfei Xu wrote:
>   Ah, seems to be related to platform independence, I can reproduce this
>   problem on RPL-P platform vm in almost 3 seconds after executing bianry.

I think I found it anyhow

Please check the series I just sent against your reproduction for this

Thanks,
Jason

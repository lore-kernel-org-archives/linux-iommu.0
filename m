Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B8DC433F5
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 18:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C0BF4092A;
	Mon, 16 May 2022 18:05:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BfTjFjNcmpFG; Mon, 16 May 2022 18:05:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D1084408E7;
	Mon, 16 May 2022 18:05:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6D02C0039;
	Mon, 16 May 2022 18:05:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 085D9C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 18:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA89D4061C
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 18:05:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G8KmQ00_FHTz for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 18:05:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::609])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ABBB840222
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 18:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvCjAAzLR24EgDMtuJGK9oix54TpRU3g3uES1bY5C4686klhvXAH/lgZy7Poss7zMMgPM50P78Hl07dFHasJ7ibAKsszLLwUcr4kabdcYV6NZ69496+yNSVkP04wwpL357XS7RHAD/4f3UtTFQ3lFYxvZsCmFVR9PNXbpxF1i5T/+y68mlnPBgTK3jjsSX9JAzLQjwaeBXVygXTJNHQ4OkGObJdJd8VSk0ZXSfrPLnvPgSedoawgxNNKMv99o3FEwo0NSMBiQjXT+vpaoOEab4fUdYswaJVPZICcmykwAQKiA1mFbxuXNsbSUdPig7fEkTOjaI0iWRST/Lj58VKpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOghJ5X0gCN9xWKbdCoM0CPRtasFSC9Oja2bGjCPWAo=;
 b=RHgLarUdYMNIZzSCD5B2iEFqLRx/uS5cOe/rE6QM0s3lVQRaBDlDcMKJla4Kz8N0cxEs3xiSHD6g0zBGHB027hFxr4iFbeYPlgP0ACHdKo6VNCgi13CGvERd8hcgfQtBVmNqXg+StwUuLYK8xA5T9NGo8ZfCM9bKHwulfyJX1YkBtxDjVMTVM3OVSVwf8TYvPoaguzAf3hZkVlmV7+FkRvCYLGF3ydV/WMlqG3yEgr05gk43aj1RLg9zSwiH9/KtckJ/IEeuM5FvbaW2aQZTRcQxc33DgLYbN/b1C1O9GQCYBxSI13Q6UnKJ8cJB0PCj6VMHIAQxayguIdinSstiZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOghJ5X0gCN9xWKbdCoM0CPRtasFSC9Oja2bGjCPWAo=;
 b=pycShA7NE8R27BDk9oCScAbI3zETn3PKkkjb39NBRp5IhC5rVQceEyBelua4Lp/pOBfsBAEf52QNxLUoit1imVO35juX84S8IjcFP8Sz45gvVBi7ZlEgdxIPd9jG+G5kP6twF88OmrOHPET9YXK1pBdCmsvYaKlf4tckdgoE95I0/2uRQptxge9lx3UaX5PjuYuVAsQS9CsoXuJWhtW2nOSq2wQ1OWMCj4/DW6XuLj/XJfI7Ay1S9L3FmQYkV0vLjb4nqMO4g5d4DJCQT7yAB12PhG1HEDIDYpzFVsYFmAjkY+MVB1eSzFVSrRL+iW/mMKRu5Jf46jcFikYF7B2tIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Mon, 16 May
 2022 18:05:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 18:05:01 +0000
Date: Mon, 16 May 2022 15:04:59 -0300
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 4/7] drm/i915: Remove unnecessary include
Message-ID: <20220516180459.GJ1343366@nvidia.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
 <20220514014322.2927339-5-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220514014322.2927339-5-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:207:3c::44) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 515d9ce6-b114-4255-91e8-08da3766988c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1337:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1337DE23AD4D2C368C0145F4C2CF9@DM5PR12MB1337.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jyLatWSnw+kpN7luqdqULsrDjMVdG1D8p35toXfKXDwdg9fG6qumWmhZ6vhcglVwVvzHhO9AU3P8kAEM+H+dWm0NRM9/0sYhQk65ttk3mdlxeJGvyXy5ml45lGTOrWXCLwonFsrcj7w1JaSI6h3bn7vZTz/c7r1PJDA/udmevb7jhkYAT/sjVl+1wobuunoCinkoTk/GirEYxw6s+lb3DlmvKklWYa9cBMSopGzwqndKnOyEU82WSpwG5pP/C2Gjo3e82stANHrVYljccxJ4ZxID7RClPhl/mWcybB1Ay8lgBmrqGZG1WgE7cZK+sczG+opfwIRdxOWBfbVCfxwRb2nwg3yM+gVoe/Dy6Xnmbyn4PLT1rhgIv7jnAsOtxaAyt9qSd6eQ1ulBJM947x1TkcAeJGSwP5/ZDZJ+DgflqUk5FmxDDGuGz3heiMNUKTwqX6shpUWCS/1mBwKQCSUBTcSFiw+hFlQENZf0lkCkK5eRidtoXEOpWnZFTwo+h+n/3Ao6CJPfJzrIuR0tQkharqJq2C4ng74X8LfcpQ1Q8SK3OH5kvreGLvVV9yIdAkXNQYQNYJT06dF8jUXIqso6qLu8gno+1XAsDw1krJOabsfgI0nwEiePByXCbbdI7c64f3EC4YA9+I1lK53V8lXDuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(6512007)(7416002)(86362001)(4744005)(6916009)(36756003)(508600001)(6506007)(8936002)(26005)(186003)(6486002)(316002)(66476007)(8676002)(66946007)(4326008)(66556008)(54906003)(83380400001)(1076003)(2906002)(33656002)(38100700002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cdIm4CViuFClDi/qH81oCNPEePZj4bsFRbuUT+wwWwbQOkYCITrrSQjog3CR?=
 =?us-ascii?Q?ah6D66YRooqpm2RCWG3cLaaR2VtFBNdCxdHBPTvsSkBvtkKunGZC35mZr/+/?=
 =?us-ascii?Q?MzTv3zpzE5kzrKv930EP1QHJ9DDpS+92WK+YobWFxCt9krqwCa2J8gp8h0r7?=
 =?us-ascii?Q?7iMgMQLeQL9WVubub3m+IGPPYDq1LwV6Cyd6tSOuU/qgL+w0mtOf/BefZgoh?=
 =?us-ascii?Q?On0Y3VQJ6YS9gT1YCEE+wFLxLdRer8GocI7frrgPHQ8+vlemWMzPZH9rORh+?=
 =?us-ascii?Q?8H+lDTf7P0a3MmaIcoDAcuIEXjDgFbSRTnDWVmMVjjJZccl77bFElHImQ43X?=
 =?us-ascii?Q?u6+cPe0FvsByZSrzoUKtEKaPu9iLvDBdh/X5Gx/yPyIdaPM0Wv/06DgB0K3r?=
 =?us-ascii?Q?f6r/jTJkYjBQTVpzjb2Gi+HkScr6u8Oj7ZOSnOaQ4aQQUEOlXlhNXb7L4Tgc?=
 =?us-ascii?Q?WRwtDc0bkXCNjVXNsuXpMEAXRyE003pNyyrKGwNayKhLxNOLTeBntSggxl5s?=
 =?us-ascii?Q?FaZObp0GwL5O54i5NhrxFPrEGiw2jk+kF/wnbZH4MfC+t9zV6GE+6h1U4eUm?=
 =?us-ascii?Q?gDCYgSAV3c3MBPNRqujJOhwOUL9WWlrk+dc6LWadQdDJaUkCh+I5uvpJVVD7?=
 =?us-ascii?Q?eQhh1a4OWQ5aO2SrqoJtqAAQq2B/VS7HqVGhLqP+FvAx5xDdMYFlqZbNIVKZ?=
 =?us-ascii?Q?ooylJ4umxJEm7x63PeW4qJG/bK74mevUkrwu/rJu1r2RAXfI+pjPA9gWQuoY?=
 =?us-ascii?Q?k+zhS1sEE8bq7HHfLT0JbyfWVAXUsaUbSqUbO8WpvPrnxRNJg884E1eZTGv9?=
 =?us-ascii?Q?oH0JzqTpyjq7cDQCLlnESE3XyByjqGENzlAbTJbAh4W7AYomhyGuVMqpqD1g?=
 =?us-ascii?Q?UFbTDvNFOzinID/2+IrrsMW+h96mThe7kkVltpgCBV2mckAn7FIcrJXmcdTU?=
 =?us-ascii?Q?6GhzbR6bu5B1McYwK9v8HEfCoGwu4SFbiZggj7pFit/VQRiIo6hGm/qIg5um?=
 =?us-ascii?Q?RyHrgDJegifnPPiy8g4hv1hOog6o0LSTdK9dEgWFsEg2QVUw+ZWFDvx+K4dx?=
 =?us-ascii?Q?uljRNYopoQhUpca2Acc+zTzg1Zw/pTfFCsMMBqwGlDu0rJp0cF71y8tN5NBW?=
 =?us-ascii?Q?tDMJbM0UwOyTYTZsFux2qMvglXFLycCfMCGJyDMgKPsY0rAS4PBLiSP1K3Uq?=
 =?us-ascii?Q?0Gk/bDB7IW1f/6A0JlGqgieO9PsA0UUyLE8GrUldDvdAsJZtMVcsG7L8LOS2?=
 =?us-ascii?Q?c9tGQn1yK5QbGiG7Ts3r6lqujCWmJ7t61JwhOGfJ/92D+yfJPeXvyINjves0?=
 =?us-ascii?Q?+bMi7R08rQKXKC3aqEgH6C7LkO2C0onJXf8/hreT6/Jk7cVW+zyDZ85CyOvg?=
 =?us-ascii?Q?xROcgx9rRnYmhOE2ap+eXjWzQD7+R0ylp4SdDiQCW1c+XSZD3D7xT8zBOrUV?=
 =?us-ascii?Q?2r0wswSHkdOZvnYRuS8g59UpkXV7foDzO6w9gHgWD++NE1omi+NCC2NWHuej?=
 =?us-ascii?Q?QgPDALO7BE/N76mQ52XCaLn/RQ/iQ9MmCAfStDJjo22a+RKnt0ksUfFASuiL?=
 =?us-ascii?Q?p7QOXDzQT4yb6oVhfnQ97FwNGX/Kkk/sqJ7CwawbN9lWbHDIknP3W33JLViN?=
 =?us-ascii?Q?r/HtP95TOHT3a6fdMkofuxR0blsquTehsHsyUpNvJOJZjl/DbnFdXMnnqzZx?=
 =?us-ascii?Q?N2kTkjXlx5IKhxizq6mz5jojpaAiADtguCCaG6Qvm2gmLbb/lNTv6MALR5da?=
 =?us-ascii?Q?fknm+JdfjQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515d9ce6-b114-4255-91e8-08da3766988c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 18:05:01.3617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYxCHNZTm9eMlSKTeFYVYM6IJpIZE2x0PhN5ufV7siMgJB3e+yToW6x9bEje+vYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1337
Cc: Steve Wahl <steve.wahl@hpe.com>, David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Ashok Raj <ashok.raj@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Kevin Tian <kevin.tian@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Ning Sun <ning.sun@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Borislav Petkov <bp@alien8.de>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sat, May 14, 2022 at 09:43:19AM +0800, Lu Baolu wrote:
> intel-iommu.h is not needed in drm/i915 anymore. Remove its include.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/i915_drv.h                | 1 -
>  drivers/gpu/drm/i915/display/intel_display.c   | 1 -
>  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 1 -
>  3 files changed, 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

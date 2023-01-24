Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32CE8839
	for <iommu@lists.linux.dev>; Tue, 24 Jan 2023 15:30:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSpuX3yZ20mba2T5idiaKrVOpwT7wWLd9q4/Y0sQ9lc0haQFPwKlX/sW+9KAOhJ5mIJSzQg8PdKSUQjeTMfSR6R6BS2kfImG2zPjJHQtHxAcby3J+Cu9n8duuKyQNiDmMKbBMVFYZ5lhWMKNjRBYc6blLlB2tATd8dXIZiXgwwzprrVn8J1K+6QLC1NXEEAsjsHhqzRxqV5gop7CjDomt40F0afe90S6KuW/ZeiigyQPAH5DTFaCv8a8Y/nfxeRK5M4cgmTkLZoBlPB7YGcgKk81ifKXWnht1K0BxTjQoGW9XoltRP5rUVt+H4g6bwdviQDe2pKg7CCIAU+Zifz/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETsEsw4ekv5bLRhyX/EbhZtclnoND9Id3+75cwaJxS4=;
 b=UEMxf8jejF33VsNAmvmxgtvonypyaBh+++qW60bXcQKWKGvJfk3E45w+OhfOw2xE1rDPGxeqNG3DnDWq3SJjqxaVkcsGnbYIs8YQrBMX7SC5c2k1AtL/+P/jDyjl9xYyIrPrUcoDAA5smUxL5zCqRB7Z2D2sWrJXJbjwj9hM/h/ER2ex0qj9xtpsHExkn0zFn6amfLsnQQaa7+cj3qig5WUTgmZc3yWOYZ5Yfm4h+OrDB9ZU2BaXA8S2jXE1vmnWmBlhmIBUjui3kDn9i5IYuNglmu4XqsNGVcxqUBm0jl1JpmxmUovk8aFD0mu/qbPG4IaJ466YO7UngIJn6BOIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETsEsw4ekv5bLRhyX/EbhZtclnoND9Id3+75cwaJxS4=;
 b=glDiJF3VbKlK8XzPEzCYils8NMmJCr4Eoc62CoNmLgiq0bEjlIUfDcG9tSBzgM6EtjB1j9oObeRTg6NTM7ZwBs9Pl2C52dNxyx0EU4VIaIDwWwEsClrF+H2U5CWe+WTEAJM4BnX4p/g400L7MYwc0Os/4dnwUqyp0F+MaqtBukAVVdMGCqy9uvvn/98lf2ihdii91Qsc+0RFnzLlP1BhHOQY4+eSKSPcMGDFxHLcLf7wm6pEnwTP1xwz8+tcxU+o8ckGCwUMkyARg4mFKsprChk+hpnFMHr5Vy7esaNKhR2KRSurMHO3OriOuawIL76NR948g7nrLiwth6fJwtNL9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 15:30:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 15:30:54 +0000
Date: Tue, 24 Jan 2023 11:30:53 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	Daniel Marcovitch <dmarcovitch@nvidia.com>
Subject: Re: [PATCH 2/3] iommu/amd/iommu_v2: Fix pasid_state->wq race
Message-ID: <Y8/5rTjCZjN9I0ak@nvidia.com>
References: <20230124104355.119166-1-vasant.hegde@amd.com>
 <20230124104355.119166-3-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124104355.119166-3-vasant.hegde@amd.com>
X-ClientProxiedBy: BL1P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 17730022-7298-47f7-67f2-08dafe1ffba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n69qRKV9SMaJhFqS2Isi7xm44GsqxRgYMqP22SRHb3u4eHBdrE4YAv2vSF4i1GGHV6D6Tu5+t34Btn+pebQ+mCtmEie102KFbyKib7Emem7rAJZe6RSfGkc6dKJCjI/5fLAZekZp8/ZiHZv5q/Gtp+aiaLg206Y/vnCwuVmsg+iIP2gigv6IxN55IBoFb6aXUiU+yHGKSvq3W/hs4h/qOeIfFcVbnhEoRH8Z8abkBPO4NTVKLjkmSgF7uqDg6pYHPsZSeR9LTaB10RLUECUpdAa0mXcuL8mr5wW84oi6wUjF9VA7AY6EAKPqm424/2+6ojsGO6PpGJJnsPv6yzFM+uXnD6LrbXPKCebpM4crQ2e6EkVrZnXsiOFwLh8lA/RJcf5VbFLzbkKGUPjNw8LEDa4nvqQeMXFByZwHMYXunQ+ALRuCYRfAMGMAvpNMSBQvGVZNfFCY95xKtRSDmSMPfW6PdQ1EDESvk530R/lnU+L/IOo8YG1mCpALmLE8Eq4Voa+vpO80ZSApsT/8vrWNF3Xuw+W/3zAJUFXUqRU5XARy7+1FOSAm2FaTkc/U8yx8D3o4xCq7J5U4LiHduEseTkOZYxk88m0fcMPmhPqwFg8wyo4fApKmiaDqriRPd0B1AieJ+ueFBUXQRQyGDZiFGQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199015)(83380400001)(38100700002)(41300700001)(86362001)(2906002)(8936002)(5660300002)(4326008)(316002)(6512007)(6916009)(26005)(6506007)(186003)(8676002)(107886003)(66476007)(66556008)(2616005)(478600001)(6486002)(66946007)(66899015)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gTGw8cj0gBPAy3nMwrEN9o1ctcumJYJYljBSssPjHIobrLew0EsjlHj7izkA?=
 =?us-ascii?Q?BKNhKhXne3nmcfZ561d0QCVUctH/6CCemiSQhbeBjTRF1a+KPLnN4GOX1azW?=
 =?us-ascii?Q?U/5EeTNtO0qEEdWghP4BUcD7rGRLEesXWsiqQJ3aJHuoR9Zca3RIJ7AJu94f?=
 =?us-ascii?Q?fV+fuFsJla0Nd5EZtJ5FfqjjoN6M1n3H27jUtgHQXGbtU2U+FeklNbIkuKTa?=
 =?us-ascii?Q?f4JULb1vvx9nmx7ROSqMnqC5FpEaf7T18Uqrvmh6Js3QCXQvqRliBcv6tDJM?=
 =?us-ascii?Q?lZ5arHOEXsIIVv6jfxqm3ltcDKlI3zSGdtlEXabbjHfBHt9aVgxJMQpUfCsu?=
 =?us-ascii?Q?YLZ8oCUg920c+Sf4yEHxaEKeOiWBbV9VytiXiQubqv4STg4dKNAYyNc/Ohyy?=
 =?us-ascii?Q?JLQtdKfrvwjovAmEzuB+uPjpWSv+SUg3sO1s+Z8n4d2CjbQQUPr+rEkmM78h?=
 =?us-ascii?Q?AtdYteUkMLn4W2EOxzH79SkSw5hJoJk5HvlSHZM6Is9AVpBhJVgBPL0rtL+4?=
 =?us-ascii?Q?SuMr8oTwgOPrDPPimdcsl3A9mBkElv/XYUbEEVuNDHyi08HlsR6+jbIwzAsv?=
 =?us-ascii?Q?Wf4UIEnSjRBYQA28FrlbUIK2k4mkmBvNyr+xpPxmPy6w4SWCOG70iw7G/zSv?=
 =?us-ascii?Q?6GfrNF45+KxvPIHkelVm7WCA8meNDfZLjG0H1d4/psdHd/K3HB002hMFg2UY?=
 =?us-ascii?Q?JPKzrGaHuwnA3F/G+AQmbBTELSc+QdlK4bNltyDW0QVaSW2pS5Pu3QURL2nW?=
 =?us-ascii?Q?yFaSqyYNhzAjDgR5Jw9MOFf0oITrVnUoNN0RaMU2Nd98EE0D2Rg6QNFMQ/GJ?=
 =?us-ascii?Q?MTCvetMSRHyBG5FVJyHwqUwNjSiCwi5t7As+EeLfcqhBsmP6GJwnehbgr56R?=
 =?us-ascii?Q?b1TeTgTZymtJrI6qV+D5t65xz7ucViiFVcwje/OfkryIgtPtr49KybuTMLYK?=
 =?us-ascii?Q?HCxu/xccdBIsJ3HO0WKnq5G1FisvXaS17TutGZTN0y7BRu908Ir7F9TmGIMn?=
 =?us-ascii?Q?0KUeAyKelBUPSfr0ZtYNbM71V6Pq/nNYXSlln9ruR60uHAmgajBYwmaHoXgA?=
 =?us-ascii?Q?SZydmAIw7gvv8gM7jWUvq46VX9V/vb3Ja4JMQEJhjo4GJGZdctySdk4WcIOh?=
 =?us-ascii?Q?rLyPijBmcbWSA8CTNcG59Ku1SgUu6msaCAlt4OTjv5Ylr+pEsDFCvqGgcZ1X?=
 =?us-ascii?Q?WSsl2Eed5cJkUzbUZddFp7VymgpmkQDDdeIWqtYp6KMOBpXoZIPnYetMBBXT?=
 =?us-ascii?Q?srCFDl71dpq1xWr4GPhkPbbsbW2OIchdGwcUl9qFzeu2MNUAZv5laBakqBn/?=
 =?us-ascii?Q?1PGSJ5IzJZhPKaH4jeK9rozhUW9IXVX9o0UA8NygFdePONfmKXX+lJpoRpkq?=
 =?us-ascii?Q?eK1BAJgIlxaKPjei/UjIuC7QMvmwBSoL6pC4FrVZM9kr9ncmszqPAxME1Mqn?=
 =?us-ascii?Q?I7rRRQGJwFNPubk+M0HvkCtG6mt2AcPT3HwrklfZEIpFDXBktrlyfg7PsG0o?=
 =?us-ascii?Q?U8EATeNoPfXC4TXKbEv80nlKav4llzJW59tz6DJeK9wRIsgDKlfheOdqPgRk?=
 =?us-ascii?Q?lyuoHUhorGuo/Y1I+j9tUXxQQQbOr5/ao18oIQmX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17730022-7298-47f7-67f2-08dafe1ffba1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 15:30:54.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLbc86vJ56ycqJ+9PfD9fSfJO9It6aNR482aS2Q1I66k68qYGFKH8xjxxIpuIuzo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686

On Tue, Jan 24, 2023 at 10:43:54AM +0000, Vasant Hegde wrote:
> From: Daniel Marcovitch <dmarcovitch@nvidia.com>
> 
> pasid_state->wq is used to wait for all outstanding pri handling prior
> to pasid unbind.
> 
> ppr handler calls the wake_up API on the pasid_state->wq once
> pasid_state refcount has reached 0. Since refcount is initialized to 1,
> this will only occur during pasid unbind.
> 
> However, unbind_pasid may reach refcount check at this point of ppr_handler
> execution. Since refcount is 0, it will not wait on wait_queue - but
> rather proceed with pasid_state deallocation, including wait_queue.
> 
> This can cause unallocated memory access.
> 
> Fixed by adding spinlock to ensure atomicity between refcount check
> and event queue handling. Moved wait_queue APIs to
> wake_up_locked / wake_event_interruptible_locked accordingly.
> 
> Signed-off-by: Daniel Marcovitch <dmarcovitch@nvidia.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu_v2.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
> index 858748baae0b..44fed4ca576f 100644
> --- a/drivers/iommu/amd/iommu_v2.c
> +++ b/drivers/iommu/amd/iommu_v2.c
> @@ -256,14 +256,18 @@ static void free_pasid_state(struct pasid_state *pasid_state)
>  
>  static void put_pasid_state(struct pasid_state *pasid_state)
>  {
> +	spin_lock(&pasid_state->wq.lock);
>  	if (refcount_dec_and_test(&pasid_state->count))
> -		wake_up(&pasid_state->wq);
> +		wake_up_locked(&pasid_state->wq);
> +	spin_unlock(&pasid_state->wq.lock);
>  }
>  
>  static void put_pasid_state_wait(struct pasid_state *pasid_state)
>  {
> +	spin_lock(&pasid_state->wq.lock);
>  	if (!refcount_dec_and_test(&pasid_state->count))
> -		wait_event(pasid_state->wq, !refcount_read(&pasid_state->count));
> +		wait_event_interruptible_locked(pasid_state->wq, !refcount_read(&pasid_state->count));
> +	spin_unlock(&pasid_state->wq.lock);

You can't call wait_event_interruptible_locked() while holding a
spinlock

What this is really trying to make is one of those open coded rwlocks
that can be passed into a WQ.

struct refcount count
struct completion comp

init:
  refcount_set(count, 1)

get:
  if !refcount_inc_not_zero(count)
     // Concurrent destruction, can't get the pasid state!

put:
  if refcount_dec_and_test(count)
     complete(&device->comp)

destroy:
   put() // put back the refcount_set()
   wait_for_completion()
   // Now count == 0

   clear_pasid_state()
   free()

Jason

Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80477183098
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226591; cv=fail; b=FQpGZve8UHYlXD2hRwP5GTdlrN/3PY2+TZWLl+P0TTAGoi4/PSsRh+hpUwdjKwtlgeefEFIoX+YhhK4g/4f38T8+H8Szi9oH1ChLWFAQq2epssUHb3+O3fnDXNhF/TqQugQfpjZ58C7OslwjbvvEeYkk4kMaAAdsdo+MV7IsjvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226591; c=relaxed/simple;
	bh=dbV9PzLbztDZ5QMfPYbp7py7dX+14lEn15Pxf0jZyqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PxH/Re5ueFL0k6rxK1a/BxpUsx5Dn+Gv3JBk30JvXFFPNYZkP2k+xA+UbHgu9SzR+9WBaAfbhyoyYsNCqRAoM8w+TkiWWhhmpnDgErdgF4V8QmX4Qiott1Z04CupfPgqs7Ud9751/siNY4/NqVNK2SOONmw+bRDQ+ZcezG4u/aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aLmWOwNi; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aLmWOwNi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cd2jrAPAGUsNiwu7Dg+l1EFV1fEzVS8PbitVuBuDV90bYGZUo8ra8psPLbEYE7UcJF5nJxIWVKDwy5MuNrQd8Bc3wIvll+NosoPKuQzTZrgpju074EkblzOUWc2t5WjhvpmCRvpGYNDhgqdeVmgt0KlnKttraWWsDiovoOG0UcfCsgcfNOGZVyh5ezzCCieJxAHi5vSn09TigAGW4mj8l8A0ce+cFSHyGwYQGI8mZx51XSE078USv/5xLWirmp8e9Zil/L8HZrLN2NvFj35zNUK+NUEc+NDzE6VJDsOpxRHCIy1SaNVCANUvHIqDkoijADJ5adSa+nMiMNhiJECjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68qCQsZ1MzBvzZ4c9maCP7+w9tTG2EGX0U2EDeur1rw=;
 b=ta3pVaxv+7qb9kfZZJklY9Ri5yzzo84K/yjLES9yezbNTq0BUrTmjVRYsIaBKKtOr1axGYcm0kVUO2S5UObyJ4NRQBFifHXedN/mC8aQqfGnTLQwxymJlOwiqTBEU5hKR5BQkt3qttGL6S6N+swL/JFnEz3svXWGKJm+A20R9g/hAHFBvcypjq9Ss3jmPBlOAccNXMV+hFAQRynxlXVGnhuMEvkjJu7qvfuRDjf+XMYncS0KhVMWkEDHNsL2SqGQxdkgHZxZR5MRJAGk4ZcZE25PWUEgan3YxHcStdts7kPRjV8oRrUEbXi9Zyd+7PtzFD6Q3kIQsnDwZHrevYRaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68qCQsZ1MzBvzZ4c9maCP7+w9tTG2EGX0U2EDeur1rw=;
 b=aLmWOwNiVWRk3muoUtSjNNghkGBil+6LytPxlwE6YpQkq6fhaPnWLAWFLFrqsNx4gNvUQN/VKarWc+/zdNSSgThVUH5zLT4MIXdQz9+xZ0ltliiDCilAZpXBgQRStY+cyjZtuk9XLZGsss9J6WeQzaKQz0ww6C2RHbV4MpvR0zbTwaTWrHI3cOBDQ3PqEemLAsEK3hISu+I/Tg4XuC94ouHXr5M9VBV9iNgVg2vuNP1QV6NAuSofxajVvjFVGMqWUilfO61EtBjzArBaKMTUS1yajBNF4ODC2lAND9GU9MslSHI8/3449MT594IeWruSqJv6KP/Jbqlwav8ESOR7Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 15:49:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 15:49:44 +0000
Date: Mon, 17 Mar 2025 12:49:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/12] iommu/arm-smmu-v3: Put iopf enablement in the
 domain attach path
Message-ID: <20250317154943.GJ9311@nvidia.com>
References: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
 <20250228092631.3425464-2-baolu.lu@linux.intel.com>
 <20250311161337.GD5138@willie-the-truck>
 <b1625daf-b77a-4838-8fed-f5ee2233fd2a@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1625daf-b77a-4838-8fed-f5ee2233fd2a@linux.intel.com>
X-ClientProxiedBy: BN9PR03CA0989.namprd03.prod.outlook.com
 (2603:10b6:408:109::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d01f52-aae2-4966-fc35-08dd656b56a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?waD3T6uyDkRJaZxtg0ZN3hJWLrkb8OpAg74Il0zOE4misPpEOElpS41GEdBe?=
 =?us-ascii?Q?r0ukqXC9fe0lrH53qQ2vIAQrEyqaYqPnUZn9bmXX2gAPa60LcPI+/T/yGFPQ?=
 =?us-ascii?Q?PyZOMLg/4s8WDEiZEYWh+FWIpvDoWtpZCnt5PyMYXOiKrKEAbE/wcIobXaDV?=
 =?us-ascii?Q?I58jkKdoDJAqpaZbe92BbEys4A1hlibGCzyaE9H8FA8FBh+4hZPTQo4ZkFBg?=
 =?us-ascii?Q?UsbGgrT6Hzi9Ea4QsLoj/nahhas1GhixKvvcEtyyuJHxM/iGMHl4HrD7FSOL?=
 =?us-ascii?Q?xTkSdUlSupWSVphnZfXgGEUXfmvUdoLh1HdjgvtjAUux3b+KbdNN2sN8n5ID?=
 =?us-ascii?Q?mhT9/tiQOxK7AXsgl4FhChDzv+F2vDORBJkBtI3A81dPC83e8qjSgLxMUgs+?=
 =?us-ascii?Q?Xvkkuw3rt0murTlcP/7lSHUmVTmTD8kgrJwJXWHov57g++l06aK8K1tyj5pp?=
 =?us-ascii?Q?ajcN6qjU6dNU0ayLYx/5DPi5JbqimHyoDWwVgUkc6hIGsRmpjeNBUZSWrCfH?=
 =?us-ascii?Q?JFylJTfcx8HPuGfN4mYy2cHW7jIsc/H6w01QJ1Vs9oMJ59pwFoi6sA42f5As?=
 =?us-ascii?Q?eOuhTKBuJjixYj7YATfc8Tc3WoQmoXIjwTXReu4feG2NotyjySAgwbihau6n?=
 =?us-ascii?Q?/aHVUxlmtFXS+3QMbJvbCuL95atoh0/Fc8Fpf0yF73g+CcAnXGPksrVNJrLi?=
 =?us-ascii?Q?5clSwyUSdST3zTcYIa9Xhp5FSWKnDHVLa8XnsU56o6FKYx2FVjpTTnlLcmbv?=
 =?us-ascii?Q?Hd/Xxj6tT+yK4PFtHfWHE/AWwc1EozBKluLbPFrcZI0XFdBBAejWPgQbaxXq?=
 =?us-ascii?Q?VhcSmCAhKR7X7dRSqx/xBi5lJdJ9kfkpfLwgyTsG8kS6Vx9AdQQrJAn52KMS?=
 =?us-ascii?Q?pRIdrCbSs03mbvhRjN+zZ0/AiCJIWnv7uum1SApSQxmzVHj9dwkB8B/PqE4k?=
 =?us-ascii?Q?Vr+JBFG9OCQ/BesWMine+ctosVj6dh6cGOgKPBXVIvrmAJFMYO6WtUt5OYwT?=
 =?us-ascii?Q?RAueG9gXpXXRYM2/S+gmofCY2njW8brG/KbNgX1W6yXe6T4KbTdAgn1l2VI1?=
 =?us-ascii?Q?xGqF/bg1IPN0HPdq3pPcw0X0XVpxIi70j/ksHzjMy7mA7FV8fiI0sqWrhuE0?=
 =?us-ascii?Q?7avKu5z/lIpO2d2TP769OGXS6HOQmWolJ6yhNfUy6nY0slOE/jciY+o4zl0X?=
 =?us-ascii?Q?BtxBkEdroZ7fAq6Wr0b2/bEaRH+woB+ORPvH7Rzo7DfILm5qh4O6rxlGWFCe?=
 =?us-ascii?Q?JK4Ju2tZ4z/a3ZxE133Fcult9dr3+vgM2rya5aWdUxSJ3hyVWr0QQsnIZH2r?=
 =?us-ascii?Q?OqG3TOVVqALARDMPRTGNpFvp9AtFFeSFVS6wxQqI+LuFw1ouErUhjoGUBDi4?=
 =?us-ascii?Q?4H65FfPGdMR14ovtEhy54n5+4UnY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XU/SG362r7wkqLve9Jdr0Zv2y91jOs27S7sdQAqJa71nNF10w2cL+Pz+nn7t?=
 =?us-ascii?Q?3aBjB3RIoKStEYzUDjgZ/pxHL2QdfBf2cBLFxaPR3ecpQZUgOGKrzaxTW6ct?=
 =?us-ascii?Q?EzdRQvPUcrmQexmcellxdIjlRp7/19Ff/nagc7WWNmhdGgLlUKJgsYuyyCX2?=
 =?us-ascii?Q?aOKP4JqFMgbW2Dt5P6D0wLbGOST4LS7vO+BvydBlWrHL5tQf2ZZC/eT4KTzD?=
 =?us-ascii?Q?YIaT5i2rGTZClfnomJXFujJSRGjrlXRkyOSdkfiAC/na4HtGYqXZsY4B3w47?=
 =?us-ascii?Q?bphGcSYMCEQtPWmT5YfnmM2D28OKrbI8oZ/5Gx4wINL/x5yRn0QXiZ4imScu?=
 =?us-ascii?Q?l4DKgk/TOwE+vQGfptB3RXReSndPbqqUgPc+Ia4RvjhiQuMLnGVVW7oQuZF8?=
 =?us-ascii?Q?DI5O77ZhWxEARCtiHuiD2SsCEgp7JSmc4P4T34FoY9Fb69fzSZCtuCcrU8Ad?=
 =?us-ascii?Q?QFY43GGpd74glLaJIyisEkgkXraPNnOJ6S8qLJW+9m8sjsv9mZFwptmQUDfN?=
 =?us-ascii?Q?Qn0W4magkYaO3u9Xn2Y9cTBtY/Zokb9BeGsZTTYZ+J21AUXFLcZ9zP45o/CF?=
 =?us-ascii?Q?G0vl9p2bqtTt9I1U6QYiMo1cC8SmrEVB0K2JD7QUvx+jMvBV7rLeyX4klZUW?=
 =?us-ascii?Q?wzs+V2CypuM2kN6yb7qcM93XnI6bUrbh23s0G4mCfgD0p4IsijXf15JpHoeg?=
 =?us-ascii?Q?TYo4aL/rUdD8EsZFNzce7CbdJD7iELfuXZbTLtpKf+fo+bGN+ukdRtEZ6otX?=
 =?us-ascii?Q?aPP5EJz9eJc6zQnshHERTT7GSdRvaBU7o/PHKmakzXCt4qvfRmu4V6OCBKs+?=
 =?us-ascii?Q?ZI37GF+CmVtIeXQAtw5ewVhRKeHsgSQ9jpIK+TwZC6lIeiSTYLmeOb/eeRFE?=
 =?us-ascii?Q?dKgjhAHl390j0GifekuDj3YkSZUPxiRss8rR+hyaZJ+KkP6xeuoASHd/I9vx?=
 =?us-ascii?Q?KXrMzsXCU9pK/29GfJmjcXpVUv9VRys1+BYarFqmNHDsBCtvkImfHiRGC7yb?=
 =?us-ascii?Q?VGMbuVmS1j4l+eqtplA7fPBv7qo8ZQjpDdY9iQAVKghj31USMGxloWuIBMKz?=
 =?us-ascii?Q?3SJ03PVkU2CmN9aEp2taPqdVAN/B3OKGpWBEMQfLUcWWuI9fpGxX+Wx0E2Fc?=
 =?us-ascii?Q?5n4AsumqafDnmxH8exyhsMDVkFwOxfa5S6kp5k/ZJuDHDjrBFlB1e4uhjRtm?=
 =?us-ascii?Q?Z29o1U1gMd4lCFvTkWMZTqfF7xoUTcmuA1Ou36hvT7iFfEUs4G9kaxVre7ar?=
 =?us-ascii?Q?gPSTo5PHXegKYJ3ZFaVJK9vkFEUEEB6O+UlLM5Ku+QnLh/IiNpJmeV1mJN/p?=
 =?us-ascii?Q?kMwxREXO2JZvnzt3b9/Y5pQOMQ+OwvyrOn/KoHhBFycMTCzd4YfdbQdcK25y?=
 =?us-ascii?Q?vmjWsNjIefbLftCEFumG2LrSr1pM1UKAENT5JdLlBThRKzLdP3IuTSp7bHqT?=
 =?us-ascii?Q?tpzMf1AIYKz9BURNgcQowABXH69pskBHZAdijeJN7BFOrMwfnj3JKofQtd8a?=
 =?us-ascii?Q?603QdR5qwmZDyXwM9cfEe8suq0rCdibTm1+2jJaj1ttn5acfXs5NTN9Ads+8?=
 =?us-ascii?Q?eI30AsToA1crYwXrc7YewwXpgA0dppFT3LnfnA3E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d01f52-aae2-4966-fc35-08dd656b56a6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 15:49:44.7955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uaftl1itEmAvHqJ0Q0z7vilb4EL45F9noJUD5T2T8/XCBA2dDz3yIgMb7J4449JB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032

On Wed, Mar 12, 2025 at 11:10:34AM +0800, Baolu Lu wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 4aaf9b7bf862..a519854b3798 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2786,13 +2786,17 @@ static int arm_smmu_enable_iopf(struct
> arm_smmu_master *master,
>         return 0;
>  }
> 
> -static void arm_smmu_disable_iopf(struct arm_smmu_master *master)
> +static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
> +                                 struct arm_smmu_master_domain
> *master_domain)
>  {
>         iommu_group_mutex_assert(master->dev);
> 
>         if (!IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA))
>                 return;
> 
> +       if (!master_domain || !master_domain->using_iopf)
> +               return;
> +
>         master->iopf_refcount--;
>         if (master->iopf_refcount == 0)
>                 iopf_queue_remove_device(master->smmu->evtq.iopf,
> master->dev);
> @@ -2823,11 +2827,8 @@ static void arm_smmu_remove_master_domain(struct
> arm_smmu_master *master,
>         }
>         spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> 
> -       if (master_domain) {
> -               if (master_domain->using_iopf)
> -                       arm_smmu_disable_iopf(master);
> -               kfree(master_domain);
> -       }
> +       arm_smmu_disable_iopf(master, master_domain);
> +       kfree(master_domain);
>  }
> 
>  /*
> @@ -2945,8 +2946,7 @@ int arm_smmu_attach_prepare(struct
> arm_smmu_attach_state *state,
>         return 0;
> 
>  err_iopf:
> -       if (master_domain && master_domain->using_iopf)
> -               arm_smmu_disable_iopf(master);
> +       arm_smmu_disable_iopf(master);
>  err_free_master_domain:
>         kfree(master_domain);
>         return ret;

Looks OK

Thanks,
Jason

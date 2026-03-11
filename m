Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23FA2874ED
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231846; cv=fail; b=jmAbpz4GZQTpLD1kGLJCcInOH2tY8Gapa6keFsVhK4LYllVvUbd+sHKyOJDrL1y3k0L3DaWtCueZYZ6h0f+075QUGVUzfDY6zxtNe3T/FhFPvMgIZZrMFXUZ3Sdq8cUFxHGfjvSQS43T3bxU1xN5B4QzYYfj5Wr/KjNBHLnZl2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231846; c=relaxed/simple;
	bh=9fbePefHMnnUL7aNYczt3oKebUSEROPHmfso4xCqTkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rBXZjeAB4w9x1671rl6E7KcRBO72MeSZYbw5moP+GI3y2aa+hQajsFf6C3AgWIrNzwy4q44tmCaoc6e+T/EQFx1omBY3Q5HE0gakisJ6pJd1QA/b1EqFtKHEUpftbGzUIOg0ntyRX9rXzyccgXdepKMQ34hLe1CHg8DWB2MRvtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tzjH66zZ; arc=fail smtp.client-ip=52.101.61.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tzjH66zZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9oNoRkC6nQP5VOZLxOFr9LSR09jzZO7AZARQep6CbvOuIahRnrHAJ4Yr4lXpleqaqM1Ny3q1ULz6LnCi3iBx41wt4msJEolAwQp0SvChx9dps226D7q+0pVjxue8x3rpFLU5QAsSXFOEI8mFxiUwoLkzVYXbb6LZsjJ6SBbbMBiwiKYqYl9v+8Xw2WMNRix6jj/tlI9cfQMBTngrZTbgQvIKnG4fJ7zcYtqLgJcp449gmgsan9Q67+CRHijQmvUYWshb9jZtvjI7NRHEeqQXeb9/XcFOvhYgNvMd1PbfuYcbAC3OPMwR6eUQtPlnSgk/pCVXOGHWFSN/wedjZtOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg9/7JRzwXXtNa5T3/RqqU5gSfjbNUdhtkv/QS5T/iE=;
 b=fQWD0VVyvUWQHJGEZxbnrj51k23adKs9AZwn9hrEF3eZd8/W5AIwB27TH2WYl2vQwk9KkrSCQEpERb/OYqxD74a2oLyL3WCleG6bi1B7tRf7uWG3Bor6Ru+NqsFc4PquSQ2YSQiwxPyU+4zm8lXhJLER51nUcwvsuUc0KCw4jNzXFyyZwPdaAtkWm6+m0mYEc3DfzVU5+u2h7bzzUwSyKfAicrGyqK60wCdwV3lWC86pH1GzO4v4nLrZSvgQje+XOtvDfEmYafuk7oGXw/gry3PRKUR8u8C1TMjEJE/EztyAaXzqppMd5S6Bu0v9IIycTQ7snGgb6wWWQc8CRZTqdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg9/7JRzwXXtNa5T3/RqqU5gSfjbNUdhtkv/QS5T/iE=;
 b=tzjH66zZnOAxBwDDw98x1EVS/Spjki12eXP+0Yd6FAYStCEkZLtob1zfr3s5xfoL0cwi41pjYjM1bEwpxHTgS8e/a5Jf1epBfAOmhraM9vyIMe2myFnNiVLuKeHCfE4mP5L4kIecWeL6XeNyaZpQZd2JXsOlv5yE0WVcqzn9dZL09XBCLBW/TV7aEgnTANIiUNqZqUyNGVbS2pwtSJ/iOb5VKUT86jUJ1UqQDr3UJ1B3B5y5teVfvJwSZYzjnx7PqzK6Ll8xdu/aoUaE7eRvB8Gqs/MB8q/i0bIWx1lS9Wvk6EVL1fanLAAtwn+0MDruuveBmt6iU6vhvF1HMVqCcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 12:23:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Wed, 11 Mar 2026
 12:23:57 +0000
Date: Wed, 11 Mar 2026 09:23:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] iommu/vt-d: Add entry_sync support for PASID entry
 updates
Message-ID: <20260311122356.GB1448102@nvidia.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-3-baolu.lu@linux.intel.com>
 <20260309134116.GE3717316@nvidia.com>
 <5b4fc87c-6fce-4388-8a03-8c483c5fdcb5@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b4fc87c-6fce-4388-8a03-8c483c5fdcb5@linux.intel.com>
X-ClientProxiedBy: MN2PR19CA0026.namprd19.prod.outlook.com
 (2603:10b6:208:178::39) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6ef81f-d476-4b85-742f-08de7f691162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GXZep68i6YVOEed1AubrgksA1XwuH8cGL7THJ8gonCCjLJ4rxqeXhX6Nt6TFxEQTWQgwxpGgdMc0Ci3yF9SuA+krRKRiQsAxVvhOcWPGV7zLRgB1YWI2mZlTuKZ63ma2Zhv+n1UIA1ylL8KHAIYcd7WeWyjZ2/isUPXhnQeoBAi8Eze5GGnRM1F7zbuZI8Bmo+OvW8846Wu0A5OL4ZAOsjfBZfDRmIXwVxYjPklzPuvCyJkVtm2xHQHBpXmKpjJb4iyuIljg+rKlYQiPoLR1S12KrzHs1yiEc1x9bEHrvpYYHatdXVJ5fw/DxDrivcPfKhdDCuGaXnsHEGnIapIR7uQPTZIUP7wasMdzzdFAK/JFouvovkyh5h1pkNcC0P7F2cjoaNDuKfuiE7DF1lzG/VUhXIRJspE0pl4R4M0vCcoR5GNOZKjiLw+eH+lzCL44hPPPYVCePQwY7ibmxdSv0GyGDhZY6V+3L7HQxPkiMMckYGzEZuoXSqwUGmYJv4eTGbRS71bHm6kZR+tvs0M2KQOAZ+R0iACOaiwLFUakvoo0zXnzNIYjfZlEKf8RWX3zZaXS+QkL6vW+T4A5vF7/bc/jiQNsou5AE4zuBtB0RifsykHXJlBhMC0IV+7AiUDUKWt/vrzv0m6xJX4RN1DbVyi/1HbDEof64ZOklR6BUIvu4Tuu2rewZnOISt0MsbonLxoUxy6b2aGswx3FFAbrvvgmBxOT57LCoz1PUDhM0YQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2qW1MzcE+f/bsBSzdOExi0wGkZj2FXghl7cio+3xMmfYpm5UnSq9CPk/lxm2?=
 =?us-ascii?Q?w6mwAkRF5Ek8WZ7cYZgrA9AEgsBVYpQhJBxQ7qTnyKn7/bDw6E7gVLuqejYG?=
 =?us-ascii?Q?ogBr2ETK/C92saag4r/p10qECSP8Eo96S74ZAJMQiJWefuyACzyeVWyxeZSO?=
 =?us-ascii?Q?gUKZPhXo/vbT2Xq6zBMDh19Kad9WJsWAjlkXuQaRa4FEjWpHkfQzlS7fcasw?=
 =?us-ascii?Q?lGsh+iKHaIf90ZkUjdYE8sE0AticOTZVFa8qwpPzrBYC04IGZLeYt3kpTuar?=
 =?us-ascii?Q?h52mHkrs8cRcTFd9MzQz8qg0kY0w21tgKUaKhoFGF9mvauAPKdPFyv59K0YK?=
 =?us-ascii?Q?VEws5sVeH5oZ513O53BCt1jkkVNHT/HkqDpDm+IuOJCsnGf0bv6tsQ+2/klS?=
 =?us-ascii?Q?ePAB0X76QANzRScWRomXQPHNTPI+PgWi88Yt0by7PL+yQ798BwvQfpPWMR0G?=
 =?us-ascii?Q?5V/wLiQpgIBkCpR3FY4UKj64cGyo5KJ4SEGiWpCi9XoiV1rVNUz1kS1jeqBS?=
 =?us-ascii?Q?GdS7hw6Uswif+0Z0Jj81ZL5tplwduaVO7qshs1ezvb3HZQ3rdIglXLESo8m7?=
 =?us-ascii?Q?+xCpY7KFnGFsgOo9jhen/0xbuwb1l0CKLUrUOxSNOvLTtMw+kOOuXE/em5fM?=
 =?us-ascii?Q?e+NisbfZqjytjvbjH4TIPFNTGLgPYYPKxRncmz/mz1bbF0I4OjsYrTSzpJ1/?=
 =?us-ascii?Q?Mur9UqASES3Iw2uu2iNLFoUWwDGaA14g31ITw9rCFusail78TT676o2kOmoN?=
 =?us-ascii?Q?KJDJnzfY9idsAX7YX40jQj/eI/LgPldAU7vWWz0n4RrXdDQGPopvN0wi+M5z?=
 =?us-ascii?Q?YcG2WCGTu3G+VHT2UhZnMvEuDVCk78bY8s/VBC4sWN+7qXVUWy12w+Kt8dPh?=
 =?us-ascii?Q?zlMYrRb8ePVyqe7l9o/Ot07cP1rd8NK3z4YeGI/IpgozQQ17F0O/6i8ZobcU?=
 =?us-ascii?Q?kVmyOZsZf3mRVG0oD5iLfsHDUrBAkyafgl43i+5wkOHNzOK419/wzTuInRvY?=
 =?us-ascii?Q?oZDw9MLo5RXIAjqyU2TCzRehrS4DUcXRbZvduoCIS6XwRZJW9XIqIMd6pf+l?=
 =?us-ascii?Q?oXT2kaCwbthQYCJSUiqMJOooOB9HTlL3Gh3EWDpPCR7GN1ed1/RgbZ41lYUh?=
 =?us-ascii?Q?jGT/zTvpEKhLXWZ8T+rmp5vyAUH5SQ0XM3UVZajZTVCzthjNRPkuZerRlqid?=
 =?us-ascii?Q?klSosvm2yrRIZi2xAwYRYP39NvypKrKdyDkaQakyphUawvp0YZqh4L2G28jk?=
 =?us-ascii?Q?gCuOOZD5/mVguzcrg85/yRfJzoGI7ujNjpR13TxYoRUmNn8J746u315mcjwW?=
 =?us-ascii?Q?aNiL3FF6Z5N21RuNfzVLSWbUpgJqawAcrbjiFzcufh17Ers24gl0TriWIyKX?=
 =?us-ascii?Q?mSPAkVZnHXf3Sbfmf01G29o4jAMi8S5b/Fl+yBJ66dj9zkR0hEV6pGq1Qxzq?=
 =?us-ascii?Q?Z0PXYkXCTBaYhKzMZeSMsc0kHIdVXpZKfN6hLaFjlmlvbKUZk1Df6WWMDjN1?=
 =?us-ascii?Q?MI2qUgFgoZVvGdxomLPxjZsMkBqDXN86FIOs+fFjzKxE2lRvmb4P0Cr0BAnm?=
 =?us-ascii?Q?JXVTy4dluU09F2yG20rDxjllsjlHHdcwCF9EJ7hHQsICyWr9h/nwfmaivSKO?=
 =?us-ascii?Q?aZH5e7Cr1vFA1+moaOHzxOhUH5wzzlq5wNjrGMsQCfeboWQQEWvbHROz0WrR?=
 =?us-ascii?Q?0YF9UM0caJsOFIWKtETdIzSKFNEl9x0lLzkRnF9AknU5tvFvP0kdpezUcwUY?=
 =?us-ascii?Q?+t8OF2kDrQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6ef81f-d476-4b85-742f-08de7f691162
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:23:57.4431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwh3467ZBJWDdAbZVCggfugsi6oIlGdZUPA6nBIO9L0JkGEhvFZqbGYRRCROxEBP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240

On Wed, Mar 11, 2026 at 04:42:37PM +0800, Baolu Lu wrote:
>         switch (pgtt) {
>         case PASID_ENTRY_PGTT_FL_ONLY:
>                 /* AW, PGTT */
>                 ue->val[0] |= SM_PASID0_AW | SM_PASID0_PGTT;

Probably don't need the comments too :)

Jason

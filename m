Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013035.outbound.protection.outlook.com [40.93.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC0883F
	for <iommu@lists.linux.dev>; Mon, 20 Oct 2025 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961769; cv=fail; b=r3wheapCpHBBdo8KfVFYOJDz+LtqNoKjFE/4a3AKUvH8+z92r+U6rGhKRFdW7tY6NUN2y/BhZB9dwx0HRiM7xOE6g1uS8cjtluY7OK7axP5x68au5e9PJ6/5LY7ucxqPqLTD0zxt/2slsgn8NfJbmkzyR8w4Q+maxj+O1snzPAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961769; c=relaxed/simple;
	bh=2pSAyi9q5FcTOEBMIux954RqaHdtvUQYOoLnhnTsGGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aRpwNCapSr6WSQnnjwLM9Qm23gyDqqP2fJncFW4RiMBjIKCBBnsGQHngqFcoDcjrRLhz/AN+uXjDlvtODiJMwWuFaJ4oOprN6sZ9X5Mv/Y/UBv0wNI+3lOSeZAiVrXQyVtwO9N3V3M9xTTQOsEg4OV9L0W6/pOzrI2s9PyVpgpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NqNMDYk1; arc=fail smtp.client-ip=40.93.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NqNMDYk1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTmWqSkEA9gsuWzhDKfsOZwWLAuRhPcLwEe+XikMWXg6VipKQWwRom+XE7Xrp7wf9O36RONBrse9DerBaC7872Edq5Baqu3aPRRBpBg6pMrRDzxariCT9GCF5op4x5GMoFBTB7urZbn9y32PrtPFDXQXLMezyiXAAHLalRE5hFboq3vT3XrhQ1Cby58coxNPppRsuo6W9z9MBLeRJDZJigzgAAUVsrYUNheGc182Zs8TOJsOjaGEjjEeUmc8wb+EiPl5n/86lf74HoUIciz0cH30MjuAlhWZIE7eT5XgPV2bQ6TGHnho2msiUgveA8XKq2QvQr7BWQhynTYK2wru0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9mSmAv0ww/HtzYI5ob4osslPdeERtU6Mmtozy5OWjs=;
 b=sCOEQCi3hl00ACn2wqUkzrJ19W+f9pMMorsFlpFNUkOK++PO3/v1blCqUsD84fLXBMoJ/yV6pqdrK93Zo+qLYescn50HhJsQwWSTm4ZgILYwt1wSjLYMi+0p8e9E34RU3scKYRpsmDDGhtABK5sYcPS87IcWz0brjiC+PbC2jaRXpGlh5bWZy8BCbeRQY2Gu2Vcofe7xXh2F/tX4dROvlGhyvZNU8ZjuWBygCgNadyaiY0KCIhX/C5JH50QFZycGTyp96eRQbRincPe9J3RuKfFODfhXE+EYDxz41kZCMnn2LpG2uywcXc4GX4wTp69Ro/cYeeJj3FMwFWVWGofG+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9mSmAv0ww/HtzYI5ob4osslPdeERtU6Mmtozy5OWjs=;
 b=NqNMDYk1iuYmsBGzMpkHiy245E+EzWiGzQZ+tQkGQ/3NAoZf2HeYerJmmyqCpCYsQVq9Wf/GyPLRTWrXi4VggZvewhSCm5jRpY15uCawJQ/htaIRtsSpHJY6gHnCR2+fY2wtFd1gTv/mBg/ICLzBQcWurB2wR3NzLQ45zcOKGeOWzDU5VPfJ54rtDN/ydFuYhA0iuctqeuqaOjrKsufKgmO4CAY4WU/PJphcwf2uTLyeM350zKNMQsnJANpNQN/ERJnxVRxmkg74BteTKDG3a/fJfHMCK7j+LqwK4ViypjQDAqFXQHef+/roF6oz/ch5FXBOOyq0IWwg9x0k1HpDgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:02:42 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 12:02:42 +0000
Date: Mon, 20 Oct 2025 09:02:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH 0/2] SMMU v3 CMDQ fix and improvement
Message-ID: <20251020120240.GI316284@nvidia.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
 <aPIhMGnzHiBkIEam@google.com>
 <20251017135145.GL3901471@nvidia.com>
 <20251017095031.00000b84@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017095031.00000b84@linux.microsoft.com>
X-ClientProxiedBy: DM6PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:5:335::33) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 163ba724-03ea-44fc-fbe3-08de0fd092b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1lmYCY/iflwmHMF6jhAJiEf8DyVeyMrRLBeKUSIdxYu0vALhj5meXcn4XQLN?=
 =?us-ascii?Q?ZjcQRA9XxCOET2jYDvlfOs0NIOOYYJHOgwS6OnNTBDi+OkveH6aHiSlOuBxm?=
 =?us-ascii?Q?zvxGsGmwALZrP0xmoJVgZYJGA2OXvET6Ro7Xf7e+o6XaFNOHOLXKzj26jxSx?=
 =?us-ascii?Q?VF4Y8S2ts6ZwW/iafKh+msExWCM74CgIXSvJ2ZGTpmHHlCW07rcyEdN4Qpo0?=
 =?us-ascii?Q?+uAbBcDpEy5Ahw7ZtzDSV4+PIMLh3hgDKj1+EdT1DAgDBr5EAAbawzg4oIU4?=
 =?us-ascii?Q?2MIDG/oY/2DldyG+qQjBdHk5Bh7Ec/phek9i7otSK3+6JjDAFSkRdv64KlaH?=
 =?us-ascii?Q?sZrp3LDlixPgu7oLbJJUgZuzbuTIk6Y4CBfkr3QtrDloBlRc7pZXkZMwTdo5?=
 =?us-ascii?Q?O05Cj9ajDYOpRctMSFVlYjRb88S2HV4LnGs8wlNA4SefZrjMPLnVzq17aleb?=
 =?us-ascii?Q?U9VEYHXq2DgixbdEr2aEakc5TisRT8w3SRckfC8+rURdSUC0BokUyUg4QiRN?=
 =?us-ascii?Q?d0TQbVMW21ongwXSw7esV1PuQrT4K/z/KMMQCCCaF/t2tpxUz9+SiC2gFw5n?=
 =?us-ascii?Q?z+Kco6DdZ9E/MEC0Le9nEmtS+aoTHf1qxtGM0IM4slge/aJ8ixlOG94hw9ux?=
 =?us-ascii?Q?H1FNSuUW08Gl4ofw6uqrtUF4bA//UniZ2DQAM8chiN1bQqgz0sz8aknYEQ5G?=
 =?us-ascii?Q?Q1xIAmi9f0sZxQYhyKXdwRy0UNkY8C1CIfKbnSc3GPkc48IjcSGl3pU+gug1?=
 =?us-ascii?Q?NK/f7jTGq7ubxUJZC8VfQPuSaYz0LdlHdI+klW4Wdr/rR7CMzHfuB2vcqSls?=
 =?us-ascii?Q?07gYMiB/XxS2wPiSKB1rAtTQvfGqTPS9j71LDh6kHSY2a+x/lTWFz9dRQJmS?=
 =?us-ascii?Q?kWxBCZWeoSy14FSN4afxEGX76LplRTCKTolYtZJH2lFetHWPgdAUUEdswQCg?=
 =?us-ascii?Q?/ArWlHRfj6ost6QKpWMuw68D3qDW9Meh+dmpgvqYuAVrPJFo9h85jlUd13gn?=
 =?us-ascii?Q?64/anIlub62s6Lv8u/XbDtGuC7na82haLykyhWU1cVVanunHeae+GkAD03E6?=
 =?us-ascii?Q?X05WDKmKzdsbn9SSoxFd4mrm/pbrjGaaoMpneVKBZGP3wOGZBf99ed9n05jG?=
 =?us-ascii?Q?PxMgYX9qUtbta8znP5rPOwnsWTMYWtT5OHa4dL4n2oDD9wr5wAr8ifuxOuKO?=
 =?us-ascii?Q?fh4j0pqdfNbB8xWZEE3vURIl6uEBdHuT6paTshx4lAsIQpEU81BSM8KeRjYF?=
 =?us-ascii?Q?t5Ej9vJlM9bFCxkkTLxMhWikTPE5z0vtCiTccX1vVkoNx3/DarOBMmN7S/li?=
 =?us-ascii?Q?gCnvOd6ftlmBLmbOowffcCYAntib0bz/D50ubvWwbogCnBbk1onfFrAgeImP?=
 =?us-ascii?Q?pwGjIMTfafZ9vHl+AfBALCWQ7mcAT1bvWgV59V5TIe2YIElUt1vvXLU+EIAV?=
 =?us-ascii?Q?ze6EGe6/h2sXSrP6suA4C9tv6I2tiQ1v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BKWVkAHEm+wwyFA0qf2pfLLdL1eBXmsy812zYFB8VHE8N7iUPKKP5FvJE/aZ?=
 =?us-ascii?Q?fu2t/8ANcIJmTBn4iV26Pezra+Lpf6g5IretH+JxONY+hMEpyCcEmSn7evaS?=
 =?us-ascii?Q?BMQN3fgsjc+K8fkQNWdIoNHDehGuTMMO49k4URpfNpT3eYc2dIlZfG7CqBQv?=
 =?us-ascii?Q?dpTkkEtMM0USz6yyrmN90kRVbdX0YaH0xeZOuvccB1FW3FXqHvFWjfaA8QAN?=
 =?us-ascii?Q?Ouv2gJkphz15hldrcJT5MqKXqkx2tcUj2t5PBtyt0bQyp8PoxFiaEFTkRQa/?=
 =?us-ascii?Q?c7lFq+ASLwL+AkRf/yRDjsos2Gbj6zDaYCZHSlAINCtg2qGg1uM9xrxSXvSm?=
 =?us-ascii?Q?e6HeJMLvxkxr/ensOQIj6s+hpy9jERB87XnXUJeJ1ZrLJf5xlsRSF3fPIfmX?=
 =?us-ascii?Q?Mb+LmCgy11oM2Yr5e8OMEqpZ6+eQqabjz9H56PpCi1InQZnoVckZNamiBjHU?=
 =?us-ascii?Q?VHff3kL9ycjTXH81y6hrT85ZfSpvfo7bAJznFDtUERSsulvmNTI5rh+9XbeL?=
 =?us-ascii?Q?YGfqEPKLtaOXwVHqmX0241KBUvaWo728Ube4cx3ICremerohK37P2uSItDZK?=
 =?us-ascii?Q?6gg4Px+y9NCCewc42K9Fks/9LebbkK4mEdesMNmJ3TzXI8LMeBiBcKT+XwCI?=
 =?us-ascii?Q?0BPn6l4qxU2EAfb1K2i4LvE/eWU6PvRTbGFQRyQmYS4D4mAqy378NTGBDBEZ?=
 =?us-ascii?Q?jkEJ8dMl/VkfqoN+ZK4/N0AGzwoLdi6RcHdPnR4UtMCjsjT3yihZe4qJHVen?=
 =?us-ascii?Q?6RuqCQoW3jMIBhSAV5Y+sr5khp3cBk9rgD3sIns8qjkCrG94tdG0yCA9+6PZ?=
 =?us-ascii?Q?mfQp/VPhhJjXcMjTdaK/8vCpe/1jT9enk2b01NtmqU46R0ryTAEikTO438cu?=
 =?us-ascii?Q?yXswFCDlfZorQrgW7negAvcpHvrzJ6FJrHUCFtvdgyE2ZBIpvEVZN5JrVkfa?=
 =?us-ascii?Q?P8BEqzfoqi9X6lNtWpQDFduK3iAdXG9aPCuTujdnw2n63eesmSu67c6blC7/?=
 =?us-ascii?Q?/R7cWDwrjJvXKJoDlB5JwFLv31A431KRqgqUgyo68yVaUm7Uf5sdgidoamSu?=
 =?us-ascii?Q?KY31oIAcvqrVh4g9Bmw2FcuxGdp8E4wH5ZLd/TirSL40y1uNU+bu9Ab/uhfb?=
 =?us-ascii?Q?C0RP2twhctQpYzqrLZ3X+BayKmvrVVhdYzXDx2+3xFTksQQcPgrWO8XnDnkI?=
 =?us-ascii?Q?eWSEXghQi4ewXVK9VOvpW3eesEgLgM+Vz+Jz4q6u5u2/IkYIirEKXoR3wDFS?=
 =?us-ascii?Q?QBYp02T6rW7M/Nm9Tjz4d1uMSPYazFukEgBB4+I/Jcexwj/cCQbnBIyO54zs?=
 =?us-ascii?Q?Vrsx55ycwbRQFSoOfQytqeRR9Z02AVp4I/QOjNqh/7/DFw6M4WmEpLwwPOWj?=
 =?us-ascii?Q?qif8pk824YBbFZ0k94GNZpegPLPA/14IYbLOQ5E9yCDzJOF93aS2o4D2N4wu?=
 =?us-ascii?Q?lTdhsZVePSzQCmCuePW3/kFW87pEDqfvCtPwcSOvGCjEC4DI29CD6/lqj2u8?=
 =?us-ascii?Q?sEN3gFblA2peP0mpdnaG7ekongvKO+eBvp7aZaq6A8c28kOsARO3spU14C9z?=
 =?us-ascii?Q?dYD9joX1VT0rN+UFVYjf+6EztxAkWkAAK7QrL1V/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163ba724-03ea-44fc-fbe3-08de0fd092b1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:02:42.8591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ap6PSCddNF24v6REgn7VEIhdLMSHDYd3R0fM0zwI1wa143ikZqu9ThI6LEpYXvGK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910

On Fri, Oct 17, 2025 at 09:50:31AM -0700, Jacob Pan wrote:
> On Fri, 17 Oct 2025 10:51:45 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Fri, Oct 17, 2025 at 10:57:52AM +0000, Mostafa Saleh wrote:
> > > On Wed, Sep 24, 2025 at 10:54:36AM -0700, Jacob Pan wrote:  
> > > > Hi Will et al,
> > > > 
> > > > These two patches are derived from testing SMMU driver with
> > > > smaller CMDQ sizes where we see soft lockups.
> > > > 
> > > > This happens on HyperV emulated SMMU v3 as well as baremetal ARM
> > > > servers with artificially reduced queue size and microbenchmark
> > > > to stress test concurrency.  
> > > 
> > > Is it possible to share what are the artificial sizes and does the
> > > HW/emulation support range invalidation (IRD3.RIL)?
> > > 
> > > I'd expect it would be really hard to overwhelm the command queue,
> > > unless the HW doesn't support range invalidation and/or the queue
> > > entries are close to the number of CPUs.  
> > 
> > At least on Jacob's system there is no RIL and there are 72/144 CPU
> > cores potentially banging on this.
> > 
> > I think it is combination of lots of required invalidation commands,
> > low queue depth and slow retirement of commands that make it easier to
> > create a queue full condition.
> > 
> > Without RIL one SVA invalidation may take out the entire small queue,
> > for example.
> Right, no range invalidation and queue depth is 256 in this case.

I think Robin is asking you to justify why the queue depth is 256 when
ARM is recommending much larger depths specifically to fix issues like
this?

Jason

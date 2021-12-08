Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6439C4332F
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 15:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4612F402BC;
	Wed,  8 Dec 2021 15:58:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id we-uhnXPXVar; Wed,  8 Dec 2021 15:58:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A555440106;
	Wed,  8 Dec 2021 15:58:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7665FC002F;
	Wed,  8 Dec 2021 15:58:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 336F2C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11E75829DC
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:58:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LLStFS0F1LYd for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 15:58:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D005F80E00
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chndAGNUgD5BvxKKa3jogynbRMZnPmAPmyVxEZZp6IcGyNTtW9wkUoSUHzMMIHuhqRjpJ/vSg4jNkoP4CyUEbUOBenTXf36FvYMYan4BJQ71hPbo4G/UOngLHrbKJrz4kJLiYrS6e9VvPBQ+PFgNzNCqWx5akz7DNRXK8PJikYx9letxuIk6FrSsJTkEybED6lIQJzqW3W93qjm9DCNPEtzBKFq4IVa/n+AW8EWsnmWhrePV0bVmJNVL6aklGpza1eiilzTzGV3+CbpXD1BQ3h34P1j/hcxo9+/3+Gf17Ov4G5QgdxsjbIIYqZ8Q7pRMXfqThGu4iTkqoRZllbjNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vhhfh1Z4OaRQAiAKVqajt2RcGp0Iv7kNsws6AfW8ZpI=;
 b=Oql9Lrdxw0j7i6nI+IeEjbjtCl+IHI9XXZvlFxODbp2YnmV+OBLRBsR/BI4cQoxN6hB6NrnUXa5mOBRu1e4qGpO61NZ4XhQnOVqvqwP6SVq0bdhZif4vmTlKxC98DjhK+l9zqUcwvn9LdRNhjHfgAmNeLUnMywA6c9xGgrQs3T8zfvL2wsA64JwrSVZyDM/EmpZkhSJyiJ45Qz7psdgzBg9OGvH7Hz9Z7R3m96HkXP3mM0mcj7eO7lnT+BPcU1Tj1OSMJ4pe6NzA+3XjX0qt6eHFVq9JbkPNZgvd0C0mCs1gjtTBRD1Cbm8sWcIarRuG+Dmk9KbBxmqF7J4Nf5PIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vhhfh1Z4OaRQAiAKVqajt2RcGp0Iv7kNsws6AfW8ZpI=;
 b=nMh5CiPeaRGaX/3xcOKLjL4+gmOaTyN9J+rYYY6pBEwdDLCgLHHiDC1YiZQR8OUz6m6OsseL7Ho9jtHT5c8mqJAW2doUKMF1oBCS6g25C60JVsVubSpPgPb7G/Wzp+JzVO7tqi4wO7/re5u6YL642u3i2viKc43CuzG0uCUY/J0+riKX9eWNCMsO4zltTsEW6ijMhl55Y0HAFvJ9uXy6QkxBKODMbkDfg0VvaKuolI51BobZDRKyCIjqEVcHBRYaOFntgD58cre4xsHKwfdzGW6Q/NmgDp3duuFp2HI5REi5rGTvIZ1S49M0B2J/MJ6wgvxMVuvUhSZOKhT3O3UEUg==
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Wed, 8 Dec
 2021 15:58:20 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Wed, 8 Dec
 2021 15:58:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 15:58:19 +0000
Date: Wed, 8 Dec 2021 11:58:16 -0400
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 19/36] PCI/MSI: Store properties in device::msi::data
Message-ID: <20211208155816.GZ6385@nvidia.com>
References: <20211206210307.625116253@linutronix.de>
 <20211206210438.688216619@linutronix.de>
Content-Disposition: inline
In-Reply-To: <20211206210438.688216619@linutronix.de>
X-ClientProxiedBy: SJ0PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28a579de-45b7-4536-909e-08d9ba638dd0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5269:EE_|BL1PR12MB5351:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52692E87C2447367C43FE935C26F9@BL1PR12MB5269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8A6Tqb8bg2+mXXGWrraUraNjt+Dbk+HoakX3aEWnfX58e1AzaV00tQp+0kOxXo6MbMlfHUFse3CgyaL9Y6NWq5XZerzJawx0urbwMgCM/DuLquEWhR0JhzTIuDdLKIyjlYLfacb/bcYXTD+I6/BrqLFw2wl9/UiC8bEKcw41sdVJLEAX6hUsqJHeZHQH43nJ4OCNctXMB/a0pzEJx8bYyJwcWstGzuf53a1/VrtpwA/Ksv2+TNwTjqYlAhdylMQC5/tmVCO1WP/1r+Q7Um33/ZEEtkg+4uvqbyzYiKS67W6OkOfOCFngTg7xPDuWcKhUowMy0aQXvp3WoTHAtK633R4pBQ8q/rcMqhTXNsByN9Up9p8VWhSZQ497W/0F1NeH0zaxSp0c0Ts8nNvNyr/Z3BA07/dLWBbC0/d7XmK3BiEqvzeARQp4g0/eTl9OsxtmL/XSCTvRMp3Zc+wPrpkumA5CNT3cVzigdLqeW9741yUORR0JB3Gb5h+Gm4g4//PVe7tJ2xuNKOoJ544A5cle5kOB2FsD1S2y3shHNJ8sAiWCIGyKq4P+o2G2FTtxbL6QgRRqcdtW/RL3Y9zoOZCcLT2aj4bSoGHavtGjWrzwT9J6/gRAZDwGK7dSptjohhaqJqKBiCYQvxhOiJahzLS7Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(7416002)(508600001)(6512007)(38100700002)(66476007)(6666004)(2616005)(33656002)(4326008)(6486002)(6506007)(26005)(6916009)(66946007)(66556008)(316002)(8676002)(5660300002)(83380400001)(1076003)(54906003)(186003)(2906002)(8936002)(86362001)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+qJJFjN+ab39S6TkbsBWOnrA2Qhu0Lg7bmLz0bRasCyrNSVAZqUoZLH12o/j?=
 =?us-ascii?Q?mwrtjEJf0Xctb7VWN6RaSJ53vsVyLvz1Fy2dia1dSmWRA7CywsiHRgyhsb4b?=
 =?us-ascii?Q?jbR9ifS79g2y8v124mTT6tk6ms6+cFK+Z9zS2T67m79O9DM2FL6wspNmz0eZ?=
 =?us-ascii?Q?4I2qu91XUZRXe2MfipurcsT84ScnfwbpRaFtKn89PE4VxnGxbc/igLU/ouYQ?=
 =?us-ascii?Q?nmx7DVe73HAfxpZMk21wkfA5ohIwmL3UVudBMSsutoFBrsqTcmh7NeoKcAon?=
 =?us-ascii?Q?mG+d0NFiHSD4oxA8MU65HtSGcrz8hctyn03do7ej4RTNVeiHElhRuWgGU/c4?=
 =?us-ascii?Q?BB+QIJ2X6jdO91L0KjIKom1xvPaM/7vkA2xSAGaEmJvjaCQqvNWx7Fbli6Ih?=
 =?us-ascii?Q?eVaQ9+W7SgOtOQywK7zbMol/wvAeV+HHNKl8XPSfWRbnUBzoTQnwrEMK74pe?=
 =?us-ascii?Q?nrqKcMEMy/bB7ricfLzpgCGamVOMGhWkwwhSZHY7WxicAj2dcoOdMgG9fOkR?=
 =?us-ascii?Q?C76ik4/rd84mTeNGFmjq3k+lxFqyFLN9UpHznhtNZQzOdgnNoCEJM9dnDJne?=
 =?us-ascii?Q?GdND7gpDT0RWpO+QPJjFWecVP0FZuc+C9E8OV7QtA/iQVzDb/WKN4tXCGuuA?=
 =?us-ascii?Q?30FtTnyxhcVdsmLqwVS+p5/LK5KLDon04cdNOUOuMPSYsRy2poGtxjsjNnwG?=
 =?us-ascii?Q?F7/RgSW3Xa6gh2W+xiXNiyP2LCS2yMrFQdcf6RTWHj6s90Uge3pWTeMJtmSJ?=
 =?us-ascii?Q?WJUl3lUv44NmZt6HN4foh5a707vA9SrMfND4fKnI55R3LllCG4fy6UTvdVen?=
 =?us-ascii?Q?b86T1q1yHKg7ygoVMz/hflupeWKPqkdgnssoWdfgPgAx2nco/ltxzp+MqO2B?=
 =?us-ascii?Q?wGyH8hubTFZ87EhalIZZfHOZ0ERUun83C6qsZk+iQpm/26+c6z04q47O0fPI?=
 =?us-ascii?Q?b4yezGpgBsOYTa1S5XS6TxVXXqc2w1f07Q5LIskTLxKXiQWUYA3AhEJFd1Cn?=
 =?us-ascii?Q?5iEppfVFqH+wE289Iymmd91AIntcjlcESu1PORIn/Gg9Q/+3sAfHWK96U+9S?=
 =?us-ascii?Q?KNMTt2tDGMZ2xmGlPkfdqN00D8NqmGg2dyWBblDx3v1y8c07A+QSkKvcU2g0?=
 =?us-ascii?Q?wtXqvAFzMYrhdTSc7xDQU8jeLiZ60rNlSlxilRRirigdqDCnnYZAl5RqW0kJ?=
 =?us-ascii?Q?lGRCTiWGgAAwh4xB9NTn7yj9PZXHS4uFXvLsuJbpRdlfBHgUZCKPCnRDlMuy?=
 =?us-ascii?Q?PyScBDWUAM2c3FozhJFemgpfHij5rJDTwGK0UELT5M2/z5sJM+ijo/RCoi2G?=
 =?us-ascii?Q?ndpn6ak6f5e14Bywc8jzVNa9bH7NMLRRgAuJcuWnX7+1q4aynp/q3BMjWNW/?=
 =?us-ascii?Q?vqfX8yojGFkQnfBcnp6mAWSKQ4TCI6AIWf0uS8XOXoGn5fNGe/EEDjou3HQJ?=
 =?us-ascii?Q?I062LqwAc4+sYXt0xjXfw0Eiq1/In/czgSNH4TPbM2RHURw2irHaCDf4Hq12?=
 =?us-ascii?Q?BCLzW1TE6qevIlh9CiTx7pij3hVcw6/O+IbfcW60nwt1k9pOwKguuLBclDMO?=
 =?us-ascii?Q?e72QxSd7SWVGnrL7Zmg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a579de-45b7-4536-909e-08d9ba638dd0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 15:58:19.4670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYAPMq42LAnCm/sVgjoOZU1ZAepIR0bIxzYB/ZUFhj2xhN34MlFNK59fq6POtcTv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Juergen Gross <jgross@suse.com>, Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Dec 06, 2021 at 11:39:26PM +0100, Thomas Gleixner wrote:
> Store the properties which are interesting for various places so the MSI
> descriptor fiddling can be removed.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Use the setter function
> ---
>  drivers/pci/msi/msi.c |    8 ++++++++
>  1 file changed, 8 insertions(+)

I took more time to look at this, to summarize my remarks on the other
patches

I think we don't need properties. The info in the msi_desc can come
from the pci_dev which we have easy access to. This seems overall
clearer

The notable one is the sysfs, but that is probably better handled by
storing a

  const char *sysfs_label

in the dev->msi and emitting that instead of computing it.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

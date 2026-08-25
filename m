Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5667133E36A
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676741; cv=fail; b=hq9GAqU2S2HofkOpAiqEvm+4HJ3URFgEQN0R56+bwxfhgHLY4s2Fj9apKEMiroE1GkT99c7cRSOHlqzcq4RKWlbWxua4QISUNUiuRK9Z+raEwbIE0gOXlq/3pFLB1uowk+G1Teyra9DrN7R4WhFlS2xVpHrgiNKARKSEqwhtdXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676741; c=relaxed/simple;
	bh=3EQ/OY9ShuoomVt3U6TRSFtHqfq66aiTHLL6HQYuvTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iaaQZ7naYhrof52NGGJQ9MPeAtrdAAvXOj45As5GW9FajOyIuR9i79VoFHcovLPpyfrSPhWmPl9vYhVdFO7Tlp7ETsZdfOsKj2Am9BlBGguoY6e8zV0y49HT3V+g5qDYD/xNJt7VGDIe/4Ep9FHw/Nt8dDMSAhGpvazZMEAgl8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jdfnhcoT; arc=fail smtp.client-ip=40.93.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jdfnhcoT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PB5R1ukmn9Au+BoB5ITdlFNDCYOFfsU1QMlktWhsGJND3ytLJ/Y5WKTqfbznVAhKsV0QaUFLuSBZTWx5lI8f9wZhUNLitMhwh+M7NXsAEWow1o+2Pq2XVvnCsSHg1Yubn1t8i3SsNpKKVuuIhVB2aWbzU/v913hAXQhqpmxHgr4JKYqTGEUQ/mz/sLHi16DX7023dOZg7YPIu51B/zyFXIAgQzH7Dj/e0J6F/IwOd0ZITZESCar+ALeaYQAsbubQZsr3biPceX0CHr8oqnhpmJkL77ZpRHhVSsO+7ZCO/oePqnmNPmUa3k0wRjlO2ehOregH0CNi+bcEvDfEcHgcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YD/Qo4DR17ixDSywD+60EWRsTKi7eW2oA34QKyZrmIk=;
 b=S0AqKcOiO5c+IWAfV8C2hlVXGA0kU1HagnFN3Cv0P6UXoQu+GgJkj9W4UXTncdkv4bmukftxyB+qGIjOFY6OqKpX/uYKB/uhe0IAPcMEohxpazUw3TtN2bsBU3YhMomSWVbcAz244dR+ghVm9AE828zkksIw6tvIiv4G23q4Dz4ZRs4A9evMwTPCqXTTmrytPaYrbnKbL15sd0pXXBxxfOROXtUL5wUMMQGVPlJ10mSX1HHCq77BuUsfgVr5PHnQ8ks7UWdksYM8nvX672GBffPhbCPOXJxMu+X2XXWtI4lReMGHM5FjCLx+A1RH9R0Fcdb57y8YMKlch8CsSwJMcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YD/Qo4DR17ixDSywD+60EWRsTKi7eW2oA34QKyZrmIk=;
 b=jdfnhcoTuYAUHBADOOB6xmd/j8SRxr9sXA1NjIa2sxsRO4E53Ldcw4SCpVyWfjdu+Xfr4r1oCAJJES/MHcGzj4sXsy0RLAosf+TFUMRsizX6cFLu+kiFYzGkiaLH38vcbrAEIelBwZ9ofSZYCvJtFrogVhPTm3EJkrhcHc6oMy4xIAmc/+D3Xv5FiPgItaRGK6MSCEJQXX71GPz5wIkynjpMkWtrDoi9ZRJ2AfU7Ut3G3s/sCMMbjZ3crmPfO+TyQsjoGBPbUv3O6+28CzX4QnWY4Dl3pIeHuxvgPTWKMgmD5UEH5KgYG3J2b539tTb8bgQx5yOy+vSLtyUUEBMIdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 16:52:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 16:52:10 +0000
Date: Tue, 25 Aug 2026 13:52:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
	tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <20260825165209.GB3325090@nvidia.com>
References: <20260821172015.GL244917@nvidia.com>
 <t2l77h22pz2jg5vsgoth6324u36szra3orgr2g2xo7olyuhzlb@53wnsyhz7aqr>
 <20260822140625.GM244917@nvidia.com>
 <r47pwpyoc4ynv57vtwer73dwikqkev5nfy7kqyba7sqzh5pryi@teiqr5a4cw4p>
 <20260824125204.GP244917@nvidia.com>
 <fp5myre5qaersxxshitgoupbzkx2zwo3rsz3q5jfdiarmtwknh@gmfhz3cxuc33>
 <20260824170417.GR244917@nvidia.com>
 <3gdj54zcs5dncgom3zlntyredyuh2xe5ueg7nd4pdrcksmnwfl@k3fyky4h6556>
 <20260825140334.GA3325090@nvidia.com>
 <cxbneh42ui3gbkoqrsnoatxoec5exzbprfbgxcy4iekqmbceho@gouiwn5q5uzs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cxbneh42ui3gbkoqrsnoatxoec5exzbprfbgxcy4iekqmbceho@gouiwn5q5uzs>
X-ClientProxiedBy: BN0PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:408:ee::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: bd54c4ec-7902-4622-744e-08df02c93494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|6133799003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vLzjKwm2oKtO6olVo4feeyO2sc/yYpjEMN8tlDBlkGtK040D7J1fOVj2yZoNsC3BUemDT5kZh2zmUJzi+YtUfeO6VO4WKHiT7FS4OkEZJSvZbg1opvjgaNoA+S/l0rYaJeLjN4JYyqB3ZSmFL+05g3zlP+Di37YukrfRVsRhDBotOfc3sdBLjxORu/Hnhg3MGGDyyT9I5R5ebMKamDSc2Gw6W5PEdCR5TfNfayHTbvXvMZjVLoLhn550I0UIBMZ3J02KNSSTcktz6FIvfM9WMZavGShSI3sId1Oc1Xr+WtUg/3DtuX3Dfj6I9x0aNzRg2YcUSKWz2gaGY580gBiwMUjxAlpW+RPGstx6kWqy7G17Qt790XRMu7/hwmLW9EQk5D4Ml6sgJD9qd1EGHlkKvfHx18S/V8mBA7o/9rdavSVeHblL/wjVIQG+8kTvRKeENS53Y+Uu1MvTs5cxOpXiTuTMq2i31qhD9OQWDKxGNfzIA54F/JLw+U1j97xOeYU4+/f12/mAhK0bULxrgXso553WHkYFPQjs9aBtz+a/S1f/09lYuFNkAYPwEZdZW14Qoor5+UPG/KftKzrQxu7iW8TzrHw4sZvBbMZqVqiqanDSec9aa/v0J/flVcKkJdu+nYyXYEFB6r2d/k+jXH3MZV1IULWceQJASKiUGtOT5ak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AD3A8qRUfl0qREU+5Zg19UoMY30owDu5FW1+xKWetsO3zhKt1folUVzIW6+2?=
 =?us-ascii?Q?avZ/jWuGI6SpB7qQERkJcyDbdazJI9LKP6bvF9NGf3sfyrN1cEPHfMq8pCfn?=
 =?us-ascii?Q?z7Y7vruZiQV0RrzWFqotTCfhtDrKlM+7kWlCSe3g6cFeIOHY8d8NMZEwUTQf?=
 =?us-ascii?Q?LY1H0bcnkjYxa2MAlornSMjHIaQHWqUcKOOhi8qPpEFCOp9y7LR1l3jD+qL0?=
 =?us-ascii?Q?LalFtQ8AJzIu7aTpEfdI+g3Wm2M2m6lVliwD2gXttHnGtnAjliYI23qQrPYO?=
 =?us-ascii?Q?gbCJt0+uQ3k4f6IKil/n4yO6Re9kLDTTs1IYO6b7jzyu5vbUxGjRqwt2tRZ+?=
 =?us-ascii?Q?mKrGHyNzUNw1o21oaEw5j1Kk8N6J9f5Jer7LRKMkeuINK5id3vDYylsplla/?=
 =?us-ascii?Q?0Cr2Rp5cDZjDwZgovYbY3LRJi4ILx9gY7zqoUtFK5OdS+xiY32D8w8FrD4qg?=
 =?us-ascii?Q?/s0284uyCu8p0BiZWP7NUBqg/3eU8f0g72afltpWtOV2LnCXuVLLpgt2Br8F?=
 =?us-ascii?Q?uFoykF00pICMMrGkcgBQGT0kt2PWS5uPMeXwqcoxrB9k+9BnYsSrFn5S6aUI?=
 =?us-ascii?Q?4EHTSX1+EAyGVdn7ZMAmtJl30wFk/2qE6FvtEz5rleTtuAXtUOQMdxrA3Upt?=
 =?us-ascii?Q?xyM5SjRDhETT5+taxkVM7+rsfczAaiAe8Mtcsm8KrJgyRGEUJMhN8yJgqHXN?=
 =?us-ascii?Q?UHWFBcmOaJw4eTuZ9ntpwJGKY7FyRhBDdxyCOcbr/Yo5bkB6P1c/JtvwJ7a8?=
 =?us-ascii?Q?NqKBnZ3PCZOMriH4G29cjNM4m1neWuZT6mK2RGIFXGscjzV0HfpTb0jlOeeL?=
 =?us-ascii?Q?OT4xuaXG2Hpq67ZvqRpw3JNmrhG48F0d4ORPtnFBaaSioqmR6/Y+Vwd05cW1?=
 =?us-ascii?Q?dRJfiGhw9YI9lOMcaNSaLT3prszDbKkQ+d0oDmeBfF+POBjQSFdW1fFZI2LQ?=
 =?us-ascii?Q?us2Sc32fqtbbG/3kxlLxVOiqlq8niOKeKW+7k0XPwCur67ziQjZKmtHgi31B?=
 =?us-ascii?Q?whgqhnmeaOqncvoNlwBI+uLOZwjV/qJdS7lnKLuu7/IfOTjCCPVWOEJOfj7F?=
 =?us-ascii?Q?P7+e2Sf2rH/8Gypvzz2W4LgrlmJ67c5e6xI+Ff5rk4TsWfG+ifeVz/fbwplt?=
 =?us-ascii?Q?rG/RqTDEOr9mx6DeErB6OjmE2Trnp4fzJ1aNCgvDnWM7ipm3siQCDEYJpnmb?=
 =?us-ascii?Q?5Zxv+Umis4sVaWhrP3HHChqqG9dNH8D4Fzn7kzin/3I6DU+QZdnktDEUyrs9?=
 =?us-ascii?Q?n+8kk22YczspVIaPgSMlg8gr51wJ83mHdTMzl4JXrt2LpAF/jnwBJrg2J/xa?=
 =?us-ascii?Q?Dq9cspimXVdcNMGl2SilBAg+MbztoEVoOTQyvrF8d4WY90xcs2kmq6+BAr9x?=
 =?us-ascii?Q?jJu/D85OEhkUnDDdcyc5H5cMIwJJMcoYfSr968947k67ycFZLLO0p+MD8Pc3?=
 =?us-ascii?Q?4zNLILPp5wKNvQexRLDdKj67WWTS9CA7OoZqf2PZ+Tb64qi+Xnjf77wlaJBA?=
 =?us-ascii?Q?xlVm1wvu5ckIkoSJF0OSJJdNrW/y6IqLAQKuwMJnZJDusRgx81Yt/1ckc5CS?=
 =?us-ascii?Q?01vZY+bXQusnHZ87jkrf/+DsRFXUHcISh7tqcetK3suY4C1xMSMxZzM/8vF7?=
 =?us-ascii?Q?gHyNstr2U1jAmzIXWsL6OtVXJ+Ds1j75+ofdvuuJGKCWA98gaDjwtCia+0k9?=
 =?us-ascii?Q?OBCnOudOBZA5uDL+SQDPuW90r5AMuXdmhvpLIz33hJUl5UzL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd54c4ec-7902-4622-744e-08df02c93494
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:52:10.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: An7gaBpThcr0mG3lJONFM4yQQq2QC05n09pG128DFGx0y3803r/A/y5lLuzdP6KN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946

On Tue, Aug 25, 2026 at 06:14:55PM +0200, Andrew Jones wrote:
> On Tue, Aug 25, 2026 at 11:03:34AM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 25, 2026 at 03:24:01PM +0200, Andrew Jones wrote:
> > 
> > > The irqdomains remain per-device. The MSI table belongs to the
> > > corresponding S2 IOMMU domain and its configuration is bound to one VM's
> > > IMSIC topology. The current prototype rejects irqbypass from another VM
> > > once the table has an owner. The irqdomain does not sit on top of the
> > > vIOMMUs. A vIOMMU links guest-controlled S1 domains to their S2 parent,
> > > while the per-device irqdomain is the IRQ-side entry point for updating
> > > that parent's MSI table.
> > 
> > Doesn't sound like the right design to me. Pretending it is not bound
> > to the S2 just to make it global then blocking multi-VM is not a good
> > place to start from.
> 
> The MSI table fields are part of the IOMMU device context, and the
> device's irqdomain is how IRQ operations reach the IOMMU driver. The
> table storage is owned by the S2 domain so all devices attached to that
> domain use the same mappings. Sharing an S2 domain between VMs would
> also share their DMA address space, so rejecting a different owner for
> the MSI table is only a sanity check, not an expected limitation.

That's not what I'm saying, having one irqdomain controlling two
msitables based on how the iommu happens to be configured, and what
device the IRQ is is using does not seem like a great arrangement in
general.

We have enough problems keeping the iommu and irq layers in sync, now
this is making them even more split. It makes more sense to me if the
irqdomain has a singular msitable and the iommu progams that into the
device context, not the other way around. This of course implies that
each vm gets its own irqdomain plus table and all its VFIO devices are
joined to it.

This seems broadly similar to the other arches where you do want to
have some kind of per-vm control point that the VFIO devices are
bundled into that programs the remapping HW for that slice of the
system.

IDK what Thomas thinks..

> > And this is an entirely different thing, you don't need a domain just
> > to call irq_compose_msi_msg()..
> 
> The IOMMU irqdomain does not merely call irq_compose_msi_msg(). It
> implements that callback to perform host MSI remapping. Without this
> layer, that remapping logic would have to be put in the IMSIC driver,
> where it does not belong.

You've lost me there, the host does not use the msi table so what
remapping logic is there?

Jason

Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010060.outbound.protection.outlook.com [40.93.198.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EED21FF4D
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768337481; cv=fail; b=j3aNhzTfbWJEa/XsqwRIi3OcdPwK54VpsaCM/SY+nqQ2thnBGZDEZ/JwG25x7Q53BRszjyint/X7wjYBMhuyDJOAwn8kXlLVsemwRQh6VsyPebJW/GnX8zXag+43DKnskU2Eo/LEsvdweZUzCAezFIWSCsSXjE767Wdj536nv38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768337481; c=relaxed/simple;
	bh=k2Y2sVbSk7/CV2q+T31uuVmkjd8TTM5uzo8p4fYW5eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ocTbFLUX37X2BL3fbNFS2HDdSKtGu6aWKZ+rnQgs84RkCoRTBZSkPGnZHWDAeHXynK/oW3erT8svT4gbmXqKTxMwnt8EHq+Ey6fmzhQKA+gK5CNrIYxx5KOdBu129G9usPpCvw64txW/CLChci9L0KF0fqoUBfWqlxSuUhL3UeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nCV/wRSv; arc=fail smtp.client-ip=40.93.198.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nCV/wRSv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yx7w7ivoGqCTrVbNmUieg1cHrJNgBHUCphNDNoWCplGVcY9iFBep+t+DVANmwBhSomInNCoNfII/ewM47HKZVg2Y6CnVbzwzYczHpiPY1wQD9DdZA9r6GXKDH7KHsF1f4opSOwc50Ofn2uCZ60LlYlFbEkQhDzk1llwyYpZB38hzv0DXxEAKorUrRwu0H3f01q3evOOKTSRVW/jWaiUhqUtctTRkZ/J5d2R+4WXN9ugrwjNVt6wX7tyyuLGn9eOY5IsxA8DR0eh0ekzjDs2FITZS9qSf6Z4KJpxpEiMY+vxW8gmWvRPJ9mje5GLQwXCqjNmiPXYwdhLfAx0/w2bk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlHPe2Ns5Ih1TLeOqGcfdsPKgBdfv65bmKZQ3iU3Kqc=;
 b=s/WK8TxSK+gCtxmKtqbzdqAAe5XAKY1DSo2XUn1lYJUCgUF8DpeDn261FFIj7TGwEG9rEzOMAZl62ttj+dwiEIAn7VSWemiKjaZyd6NEJpieIFoJSYVM1hZmVooDEiFWpRsIZkkVi0P11Y5JJOXcJITSnloFouiJuVQHNEj3VsBpNiXN8n4KgyhOvnM0zjCxnnlGy0Rqf4BpdhhDeuksGnO1DXCnOxGXT4oDzd/WEPLMAfNrXOB/Q7w9CMVmUJbBEXJTEHShyKNNdXEHQKUf8K1nK2zq8xQ8r6z59adIaA4yg+pyBnxqZw5GUF1j1Le3oNxy0+cUbiuwYSLXZOo11g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlHPe2Ns5Ih1TLeOqGcfdsPKgBdfv65bmKZQ3iU3Kqc=;
 b=nCV/wRSvDmb7Mbu4Yu0NSQMEKdSR9AjQzGoejg/0JcEDErKlIuTvyknEJcL2xFB7AWUUVkbbiCQxNXaBnFIJctOs5sRa6hMLmEZmg14N7rYrdLtwyc7hAGS72HTIBh7IdpXNxKlsNY2V5BQJ7aaOfMw0TO/5gwzn+y77P/VrdeGae6S+YV8QVl6nOzo/vS/lcOOihuRWcPaTSnmpJS6qfPCjkCNdN1VsS6Gek+SCAHDbEXIZTfUr1jGh1PSVjnCZy/N/6YjTbVN1AgB7+nZvJS2+qFFHTTQMUTZjmwjJLbR/ZGLDeR+lQuq08yBz1Ui7F/Bg7+ff67NJIdO0MHj3nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 20:51:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 20:51:13 +0000
Date: Tue, 13 Jan 2026 16:51:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com, smostafa@google.com
Subject: Re: [PATCH rc v5 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix
 STE update sequence
Message-ID: <20260113205112.GJ812923@nvidia.com>
References: <cover.1766093909.git.nicolinc@nvidia.com>
 <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1766093909.git.nicolinc@nvidia.com>
 <aV7OBrH-TDiGRblt@willie-the-truck>
 <20260108003646.GA537728@nvidia.com>
 <aWUY-f3kvM94z4qh@willie-the-truck>
 <20260112161010.GC812923@nvidia.com>
 <aWVETpwlx9Rhs8Kw@Asurada-Nvidia>
 <aWZfUNXEka3GBf9s@willie-the-truck>
 <20260113161253.GG812923@nvidia.com>
 <aWarF90zBqxD0Gef@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWarF90zBqxD0Gef@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR19CA0067.namprd19.prod.outlook.com
 (2603:10b6:208:19b::44) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe9a5f2-45e4-4ec2-4a22-08de52e57d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Bi7Y2nDq5RrEKSRzjZ9Zz7MSwLanjOFgF/y/agC53neofodPfAH8MxJS4G+?=
 =?us-ascii?Q?hpU9480He+bkrTHdMzx3ZTvXTfRUXpBAvwJd5gaeudMJZ2wkneQ4me3vOBkD?=
 =?us-ascii?Q?Csy0QRNfniGo3oiNyFAeOFFK490jFvScga11xF2HhzCDywG8RicAxpITtVtP?=
 =?us-ascii?Q?Y7CdDvj4L0HizoC1HBCWEYnKYCRW0+Pen4UbxfCyteY0W3m9lbg0dFadffn0?=
 =?us-ascii?Q?j5KnVUzdQ9TbK3VKOrGPzOBphg9GA39EH4pB3+eMFL1ekzswsWfJvyFAIz/3?=
 =?us-ascii?Q?QlilV4a5Rx3Epba+b5eDS+p8mIVMZR335K39Zv9CqK5rmfab2T02bO+JqGSp?=
 =?us-ascii?Q?KlaRbduQzXliUiD6GeJmtPEVxBmMn/ipYH+fi1qNrFEJooMhlUFuGe1Hk+s7?=
 =?us-ascii?Q?AV0LjMfpd1ankCRD6zKx2gG/YNoXSrxSFu4N0CYOvkcYbBOI0E5L1lp8dVsN?=
 =?us-ascii?Q?r5CWcToO9Gpa4Eb8iOluL5phqeeUI3028/Osea7bm5jbFBLQD5tk5em5gvpH?=
 =?us-ascii?Q?tt3p7mL0C2WtX75Ze1hgWXypRuxLCk7xBg0IMVjAlS7qMDSXdADhxpq1GPxV?=
 =?us-ascii?Q?L8TrfrplegcfUJQlYVnrW9V3cvzcAa4x7w9kKvFPCsZEZUkESG/nh/dBgF1I?=
 =?us-ascii?Q?hBlogPH2iYObsxvD3ORfg3PAzID6oiOEmLFyZRu+F7ucHaX3v1E2bbFpqyg4?=
 =?us-ascii?Q?Tx6te7z5acV7ghn/W+xRCz2LP1ch8pthguYe6TlJURw9C/8ECcdZZgvAzGEc?=
 =?us-ascii?Q?oZroj/8cHumf6fS5bvHmMNZEl/2KezDl5R5aLFL7qPYRlZUfQmI61QWQ4BCZ?=
 =?us-ascii?Q?sshur/2rEsbApltL9Ojp0W8WcBD2+lma76Br0IxEt3mpsK+/3Rm0iEhoM3f4?=
 =?us-ascii?Q?BEBDndHcERfYvdghlb8xBmMyOdfWqCrjQldeCRIjcc5rKoTsw2SzRFAqv46a?=
 =?us-ascii?Q?h/yegXMGGxhlEv+lWHlQy/kWT18MNQh/P8Y0gguoxI94ABcVJbwOvqHRh4R4?=
 =?us-ascii?Q?jHPvNfIKFaXE2mrG1rmz6IyPUWnEi28AnAd7AMgcaOJ8STVZX2Ft9LKIhVHT?=
 =?us-ascii?Q?ZlpksvxXnjKstnX/103ll7R/sSVPtxv5xZh+PWMaxz2nw32ewYXToRsHgX2q?=
 =?us-ascii?Q?zZhl16E02daqKFZyxPHgAxOZJwE4nXZOWGp9th0kp5OWt7i4/jF+PyvDySQ1?=
 =?us-ascii?Q?zZ9nUu5c5PKSEBmU4JpCWyZ4eQa1MDVNr/jF7OP5jhdPBP7PYQzGd1KzeM83?=
 =?us-ascii?Q?63V/yBzkj1fs4dZ68YyaNgR1vX8r0/2wKcUpphL0rmEIIHXbYAJ1wbWT4iZS?=
 =?us-ascii?Q?a85xUiI6vLyuLeuPiJWIy95BQBriFAuTH4NM9UourVREOqmTBhXGTYp0AGN2?=
 =?us-ascii?Q?w80UsS3o7SFZJjei8nrw0EuBVOzJcr8hqgGy0+d5ubzjoVeK8IlvLYtM0w4i?=
 =?us-ascii?Q?b0N7btzaEqx+Tv4C/1Z7kc3m4UOWJauz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UXuksFFIWybkd60SEPnxtba8wpB+NdC1Je1e1lQg/tj8d9bqzG+OELDZlRJl?=
 =?us-ascii?Q?tN5TxBZWSGcmIwvCgxy0rgoyhRio8IJ37dIwSSWXXG+45hwIDOX8GqvmorQv?=
 =?us-ascii?Q?otMb6hTNvaoai+9ktf3EoLs3QukytDKPXcrGihhrQHTqsNvlxEXUiru7lPJj?=
 =?us-ascii?Q?F/pQAe4XJJoFEylcr3ALP/W5XfTQ5tRFAr7HemPVJo2l3kjK0iyM/aVDKQfg?=
 =?us-ascii?Q?HiKtyJcDsJELn+XdD7xfgHc/zvMr6uKMOhNqMs4DSo9tzs5F870dpCplkMZq?=
 =?us-ascii?Q?DSPIxhAzezdnZrFjVzTjJEgdRKgtmF36P1ZUYz653sPjbd01B496Xa7/Pjbh?=
 =?us-ascii?Q?DhEiHCGDYPHLYq2mw43ISoHiAlG2vsy5HpCQtU8w5K+H84/Sg32fFAUuOmTt?=
 =?us-ascii?Q?p+t4StfAPkLyyrkFdgrjTtBcmOx3TOy+/IKUZXApCbkae/OyAGsb26fVKab5?=
 =?us-ascii?Q?utFSzkjuKY/ekz3NisW4wXKEBI4mUH+K0p4ym41/PqFVLeSWUdIOqhqqSbF/?=
 =?us-ascii?Q?uCOGbqnSofGbIUvG4VGvdq6j+gxwRjHg0E7K4pkmRnu7Kd4sB8g5xyn1UHbQ?=
 =?us-ascii?Q?cfOmrih9azhcJLYb6PNlzvxJMiaMYy4g/vt4wIt/0o47VGmtFXT0kSNjVrY+?=
 =?us-ascii?Q?4Y5lpWGVJjIhelGENjjHBmxiuXXps8N0ewuw+uthuZ/pnWkQ2DJ+oQIQD7fD?=
 =?us-ascii?Q?grGkcsxyaMfiapUPZcGkkcIbliH5e2sKrOeKw+zhDsM7Kmsa8unL1SNBTBhk?=
 =?us-ascii?Q?w9qxc3LVYxkhJYrJruD0Fsu1o8hUtib1eUf3WZIWO5azncCN3+rzdyW/q5x9?=
 =?us-ascii?Q?/YVn9e2LB1pOOJ+wfCpzwTQFUwWLOS3t8cBNaw6gSTdzGEdyB6y+40jQ0ei/?=
 =?us-ascii?Q?ttm9RSBoUmjknznXwDCHgse58vJ3z3+25c61rreoYxTwUK2N7BJXIFfT3Zyj?=
 =?us-ascii?Q?m3CW1PXlrOZeK+Oei6tD1RqB52VDElE1ob11fgn6XW5Xt+djJ61vPYQssMwa?=
 =?us-ascii?Q?rHMMWEkdXATM2j5OyYx0FFdHWr1783p6qXVgIeFmqAJD3Jzc1EU5H9j/6UGs?=
 =?us-ascii?Q?EQ9IJsGLVtJgx6A2xgUp1QMPA8dWQiv0OxTJgPBT65TU4R9bKsNYqXK2R61g?=
 =?us-ascii?Q?br5+kuqgr4gd8E3gjRYxnp0TaTDGS0hHvdbI90CVrc6R5REZKhTcq1Udwt4e?=
 =?us-ascii?Q?xselan+ySlGPYOkO2zdoQ3hFVG6Cyh5rS+MOZKvpm48zUCJfXvFKBvzAHLBK?=
 =?us-ascii?Q?gx9Oq8xgva3D34CtctZx3dcn/j9bj3qxYXaBxfTCvhs+yNUgoqZEduNePECC?=
 =?us-ascii?Q?uGn+oZK5AMIAMakU86FIzAy1y/a0uzdoqOU+HpxpV8l5ZChMVWXySQo4gFBU?=
 =?us-ascii?Q?TYChUcpk99LguqiF3ZHZyCT0GFYccW29Y9iynD1P8nbNr4pTX7GTLGBQ68hY?=
 =?us-ascii?Q?McigI/GDJgjD1rxoJcCQadmfcf/9s5OybgFIsa1AEvR63BrB0rE+qZ6JyCht?=
 =?us-ascii?Q?wZsMPjHlDB5ZPZVeE3rKTWrkYU8rAMe+lR0PV1F1VY+C8RmjjKdfnBnR03uu?=
 =?us-ascii?Q?0W+xyyz5yyzO6ea8CGThtHnDI+vbhqHfwvUmbS5M3YDGel9BTm0Z6GjASvLe?=
 =?us-ascii?Q?6VdTbsNoPubbqLIt4j03CJ6Kjyo/+95v6DxM2+/JfOMatBdCFwP+Kvt66w90?=
 =?us-ascii?Q?APW5IRzbXo4kPwrxu+gp9FHQdDCfTsJJ8KhYOFj//cxcRp7lUyJRV/sZgn6Y?=
 =?us-ascii?Q?rmhzq8jgXQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe9a5f2-45e4-4ec2-4a22-08de52e57d2d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 20:51:13.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QD10jWmfq78NUFjj5kx+uiQCFRvcSpzzed5VeH4Wq08K4GFUz7qX1N6ZtyJ2PdwV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908

On Tue, Jan 13, 2026 at 12:29:11PM -0800, Nicolin Chen wrote:
> On Tue, Jan 13, 2026 at 12:12:53PM -0400, Jason Gunthorpe wrote:
> > On Tue, Jan 13, 2026 at 03:05:52PM +0000, Will Deacon wrote:
> > > I suppose we shouldn't ever see the case that they both have S2S, but
> > > that's fine.
> > 
> > If they both have S2S then it works correctly? Any S2S forces EATS to
> > follow the normal rules.
> > 
> > > The spec also suggests that there's an additional illegal STE case w/
> > > split-stage ATS (EATS_S1CHK) if Config != S1+S2.
> > 
> > The driver doesn't support that either..
> > 
> > It is fixed by checking if new EATS is valid under old config and old
> > EATS valid under new config.
> > 
> > Also to support S1CHK someday we cannot allow the hypervisor to leave
> > S1_S2 and go to S2, since the HW can't deal with that...
> 
> Perhaps the safe bits should only have EATS_TRANS, excluding S1CHK:
> 
> --------------------------------------------------------------------------
> +        * When an STE changes EATS_TRANS, the sequencing code in the attach
> +        * logic already will have the PCI cap for ATS disabled. Thus at this
> +        * moment we can expect that the device will not generate ATS queries
> +        * and so we don't care about the sequencing of EATS. The purpose of
> +        * EATS_TRANS is to protect the system from hostile untrusted devices
> +        * that issue ATS when the PCI config space is disabled. However, if
> +        * EATS_TRANS is being changed, then we must have already trusted the
> +        * device as the EATS_TRANS security block is being disabled.
> +        *
> +        *  Note: now the EATS_TRANS update is moved to the first entry_set().
> +        *  Changing S2S and EATS might transiently result in S2S=1 and EATS=1
> +        *  which is a bad STE (see "5.2 Stream Table Entry"). In such a case,
> +        *  we can't do a hitless update. Also, STRTAB_STE_1_EATS_S1CHK should
> +        *  not be added to the safe bits because it relies on CFG[2:0]=0b111,
> +        *  to prevent another bad STE.
>          */
> -       safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
> +       if (!((cur[2] | target[2]) & cpu_to_le64(STRTAB_STE_2_S2S)))
> +               safe_bits[1] |= cpu_to_le64(
> +                       FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS));
> --------------------------------------------------------------------------
> 
> @will, does this look good to you? I can send a v7 with this.

That is an easy way to address Will's observation, makes sense to me.

Thanks,
Jason

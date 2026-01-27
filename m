Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2144D2D47E1
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533723; cv=fail; b=UH2sSN9IFhCfz7s8G2p1grLG5RTwMQdn9lVz+KPLrKu0owIotngVVwmJmCmJFF71SeQpq0o5heLA0Dum6R+7FxWvIR5rtRUHPWsW6nUB6AqrZ66z5f+c+dufF36y32y991YCiUJaSHq3FMmBresvzfRgxbExa+eDeszE/pR9I2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533723; c=relaxed/simple;
	bh=C8CrOiI3G9WYAPBhnv8/D/w3ZgYQUj937BuSCtibTDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cVwmHGVu+sC2J59+57hl1DWxpxqRary+dHh0+E2cvBAwqW1y+Q8AYetMfxDvRAeCEFjbtJqFkVKQho0e7GAj5J2HAUakEG+5ikjdZ0cJYTcTOTWe/uNzq3r4L/Ra3JE7Zh6/itBMokWLDaCUqBAfWS1lz2mOB5ioLtOYmVMt7uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WvME8Uy6; arc=fail smtp.client-ip=40.107.200.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WvME8Uy6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHecKM9v25emVuzbC7iLGqcltyNwnIoOw3T6UBE9PWx7z8MRzHR09vAx9irm5IIhVRzfFi04wq47iDaxkbv9xZfm4V3mR+DtiREstIXMVu5CDHAGFiWCII2mttvm8Ls1j6xOAIfMN1dEReINCkindzs9alczr/BHJ10sxiomHK5qGxuH022phPZTfNjyHNOT+YV6Ds8BpbUve2kKEaPforWrPNmpUy4UxEx1QUPWAIc2KjdfW/xq9rMlzmBZ45kDVhxOrSrpsWbZijJNESkIHS7JzocPQP00s3IPz6qj4vX5P4IKyiSpbOyAygIEgK6f7EA24p2CM4gL4pnemzyqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5oHA0+zmzwYetpWm+XG31eoM2Cdg1LA1c61mqMY/cw=;
 b=c/EJ9yKZXUAOGNzb+sguWjwJRghLvPkvDXoY0IovBZdmZlHBSjBj1t6bcJm6h8PhSzSRUaoSeCpwp0oFFt9LAHBOdilS0SPrJ6EbzlQYjw6LruG2sNZ1LwxfmLvsOOjII7BMklw79cPdlLMKF/09oaLyOfyAPAgLn63tBtp9ihaBfsjDb7SaOTJUgZCA8IlRCg2S7eBt0brZy1W81+Kmrm9LbVxVG51lC7izxgFjD70pqoAGAYSIDJbNBVC+PJ5TEQOKtDo2hAHcBXItjBbND+pF43Oye/f/xGz937J6TXZ0iVhjqBmBf0L3zQoNUQ8PTDX+oS6tkisEWve6eefKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5oHA0+zmzwYetpWm+XG31eoM2Cdg1LA1c61mqMY/cw=;
 b=WvME8Uy6lxxXdw34W1H9CH6t5m0ytU5AVuIBIOPld/D6/qK5ckJb7aYCzDHcmDS1EMELGcd7GZM3ovh77mjyyASRKrd4gBUPTsysWisuzOmOhomfeg2p0dOEP+JC8CZRqiyJCxPljFgIUOl1fR/KJxH89OETuwzAkfamETczoigp5oWJtqicvDNZFD/sRl2JOrDuSMQIgMp6CvfekIIlAosP1q3IcjB3vs7pAYq7xQpVLglNM8ohvEzLsI8nybjJoGQPNYhpfwyUo+C8nILGeTt5Z/aS9iKdOv/0q9nxvFJr0QfcTlza4muozAmKFbPTFP1BgQm9Cv1AxbhiwU9AQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 17:08:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 17:08:38 +0000
Date: Tue, 27 Jan 2026 13:08:37 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, will@kernel.org,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	balbirs@nvidia.com, miko.lenczewski@arm.com, peterz@infradead.org,
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <20260127170837.GM1134360@nvidia.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXND9YJTwm6om689@google.com>
 <aXjqBy2sWAUMm/aY@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXjqBy2sWAUMm/aY@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:208:239::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 4544f3e3-2971-40d8-9ab9-08de5dc6b689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C9Ux7IF634nFksuXLNL37GPiUkdXTF98mau8+zJEENb6t58uONp9+HWArGLo?=
 =?us-ascii?Q?lIgiy77Yby0PapTFRiSsCxFOmmjd6UCMbzKc21q6nGu4x3keJxXBNMpMAGv8?=
 =?us-ascii?Q?RZOzEC6eNZtRyRf2moWJO1iJ2TzVfJ7ykBEesC0pnd/s4lS86JwCcLz6ts8X?=
 =?us-ascii?Q?fmxMBq6iDvZwPzmaDfp0jlZF7KE34S8XNCM3zkDGtVzXhXmnX3PB71t2yD0q?=
 =?us-ascii?Q?9Zo69BOCHGd9ClDjhekoRllBQP8Fw5gBWTyJKwk63lY0o7O6KZC3OaJuH1Ia?=
 =?us-ascii?Q?+YbqtsqKQiQ/LIKo8D9oZQJFZbLnYuPd3j/8iEGVvQ9PedQPVBvVwi37Urhd?=
 =?us-ascii?Q?0l1ANMOSGW98dlPSBvYCHlA4O2pzdSPVcOM14zaBfy7flGvxsW+aotgscU/N?=
 =?us-ascii?Q?m77ZGV3pcTkIiZAvipH43nQ2+AD/KrYRquIQyq4Owj4APg6dRSWSzurCbLHY?=
 =?us-ascii?Q?8WQdaOFM077vjEJu3Gw/mOvsMS71SN5WOtuClQ3aDj0kIpfkds5hAoOKBJCT?=
 =?us-ascii?Q?M5s3BOWC8zEQ+Lqp60dw/BdTECUqVtNA//qDcNjaQpaJLr0CR7AVoJ0h4WTL?=
 =?us-ascii?Q?4yTj3+OMYw6uLMfPK4ejAu4n0mtwVyBHYpuh2DAl5uHwW1HJGoL5ySzN7aMK?=
 =?us-ascii?Q?c2hXA9GLipaXbLIhyYdRU1g4wlZgBe/VVpDur8JuEDnvKqpg0x6kaIGQzVBI?=
 =?us-ascii?Q?jt9VLyGZrWi8UMbuXcOzzvs+S9QqUdLUgj4nNYt20qvxPzQBs1WczCcR7SiP?=
 =?us-ascii?Q?gqgvNPNI6De3UfO1BhnpFVkrHyQrsjTWSPJnqAaaRlGCW7cBj/y30gMI3hXT?=
 =?us-ascii?Q?oX2GPf/tGO+68Ij8jUdG4L62Zy5GOyBBG39aIRdNhLKtlkbmEebGANHxm4fr?=
 =?us-ascii?Q?kQELsmuSVncTl/IFJh9BTc1Gl4WuTq7ETZmOBE5UkrLclL1z/lIjbb8T26yw?=
 =?us-ascii?Q?diakrh16+d+q06Nfdbn/RSuqDDyMalX89nWc3xtz87bTA1KwMVRfaBraSghh?=
 =?us-ascii?Q?eZRiCmAtScFxb7y0M0DLWF3gqc94eHjeSot0IODSX8se9L/K8TPKkg6Srq1I?=
 =?us-ascii?Q?/6DA9EVCdtu/92MqPnt6tm/qn51jKv+YVE9A/ZmMTyQ3slmODgDrMVRpdcLZ?=
 =?us-ascii?Q?x0XSlituk1NWH9se+j2d4OxdZFGE52x9Vnq9FHPnrtkLlqsGLU17mmivhkHU?=
 =?us-ascii?Q?uAsKpZTA7NGbdH1lKMfvBZ8GIzh8PWk3mjV8tx5LOP3tNDhKbgvgFS/cr7FR?=
 =?us-ascii?Q?rDdm2h8Sy886dkZACk6BK5Bk3M0FtuYSc6GRRuRcGX8r+0qkCGK8GiXrORXF?=
 =?us-ascii?Q?h1vsH93bcICrN/gMeMinvMwnMDlixe52Y9dpo7VJu0FZzMZpQJNQzw2iaFn9?=
 =?us-ascii?Q?vgVC4U8fTuYiCklsdEB2K51SJujmqatINE/gWNM4ZGZEVM4zwmIrMN1v0Olg?=
 =?us-ascii?Q?ISk3gDIy+rwRdeM+uulNUylNOnmHppynWdDS1f3JDB8Q6bvP3YZ3QhiiYF55?=
 =?us-ascii?Q?LUWC4l9JpbXv6bK19V6Yp4GiKznLri3bOHKfyy4SmjTY4X3Qh5usPTM5JEu0?=
 =?us-ascii?Q?2/rR6oK9KPuTnQaxWQ0ozW6gGqY45kS3k0aoqNOMixfNiraNpIA47T0tdK7h?=
 =?us-ascii?Q?8KiMrGUMy/rE2PHh2qfRxtM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ipjP6jtHTQwBHs0LGM2VyyWj0cz8EU3av/2lC8bzNKax6TJs04DzAR/ADtOd?=
 =?us-ascii?Q?sTKhcdvRCJTz+kxmft+sScxPLeXHeDpuhKJnQ9F5ZZrxozLAiF0+dJqL0VtV?=
 =?us-ascii?Q?OMtm0CAB5isohNZ2TTl2Q7wHPWuzTFGx75OrautU419IyyztXI7pcVziS6Pq?=
 =?us-ascii?Q?/k5zsY7TsjiuHf9pS3onTv1rXujvMvxPO1iJYEQvN+vJEO9GQEZGc2awjyLa?=
 =?us-ascii?Q?Lth6pEKZxhT/0DynUrUqMhe6C0LQM+mDO6egJQvkywFh9C7R6BbuzSIPLNbA?=
 =?us-ascii?Q?uwSgVWa/7yIW3+p0ec7bQ5qgnYWa022/fWu000YMFahF3QgYUwXy/6GcPPyw?=
 =?us-ascii?Q?I17M04KxqKVZ3Lulefg+HzM/T16M75nxUrOidDnrEvahcEsJXOwh9RNdLAay?=
 =?us-ascii?Q?aZ6H4QP7mOi3QYekzzqG849AXmnBWVjvrw9bkowo/L0Fy31Acy8ZCM/7dl/u?=
 =?us-ascii?Q?GUaks/seW2zo+sihXlXBjsEZo6y3YlKlQGd4/gBXsvvHDlcm730EwXAu/eg1?=
 =?us-ascii?Q?AuXQyC/3tghJPROtsT7z/p6GOEGLSxDgtbufXqXYATI5IVd8IZQ2J/fhWPlA?=
 =?us-ascii?Q?7cPqcneVAQNlF9vufYShgJBkyahS9GRQJlZVWTz1d76MnrEF73eNY83zH1Cs?=
 =?us-ascii?Q?DvYkIhaC5v1tiKylMFjaCCWD4FL1ZqkJlat1H99bICkOQITo5AAe5kxfedTM?=
 =?us-ascii?Q?CMbT2PikJEcXXFiU1TfoPJGXDUDDN4pCTwI/UDVzbRFa527k0k+8Sifb3R4B?=
 =?us-ascii?Q?TynUdlSMcabs7xK+OJI4JhfrxnhwdRk9uJWjGNuS8cLhFGecyA4iejDyqvpk?=
 =?us-ascii?Q?KsUIBlruNVzEUQvAy3oP0UdDaiwaGQPflSx2PK5logzpEoAY8YGpJDn2JIc2?=
 =?us-ascii?Q?f30qVf4crGOxOe/c7bd6ioUqTwOyTAr+6EFRsS5yLZP3GysXKb1nHQ8Qn/TP?=
 =?us-ascii?Q?CGeMrXl/de6KQ44rhh64MSrDdgTB4F5+pdgHfBWBufNCcpJGbcjCBH8UjOAL?=
 =?us-ascii?Q?zSYplNamGh8NIQo1ToleaJ7s9FbfnAq+bW82A140uIkTB1dNLAHdVg01fR7B?=
 =?us-ascii?Q?8nBdRs0jk+npq+/uGOF0NiGoPaRBr37J8M+SAoABQpVVeJMpufGnWsMncKVW?=
 =?us-ascii?Q?dCJsuEqSEZduav4uEKYxCvCMgpGlYAurf16ogorkmRkG+snlj/jpH2PWZ53T?=
 =?us-ascii?Q?VIERtIxkpj6XLjaFWA3rHMcR3dhVzl9IBedPxKpJFZ0qAkhJPT4NCvX89hZG?=
 =?us-ascii?Q?Z31yOx4zibdrfTTBZPYO1iLFlNi4zjNxZPh8GlX9mRkEuX57EDkR0Het6Je7?=
 =?us-ascii?Q?csZ3A/MG48o0KJ2mFVyetcbUQWqLo0zSs+F1HKaGWP4llzxk9wn/BLVl8uNv?=
 =?us-ascii?Q?wmK95bXX6hxP4ELtMu0zeZQO7r5Hfo2FRQzpeiLbme9Ayzuwg29ra2dUFktS?=
 =?us-ascii?Q?CiiwGU085G+bpzF8sRH65h7aG1lAVHrmJH+Mtz9CB6nwckh9mB638IlvKE3S?=
 =?us-ascii?Q?XQAWVMfI8gi3stUM61wWhHE/WAd37ZMM9P8UfCfINa+84avyLwjOMOuRgbi/?=
 =?us-ascii?Q?+YEZaKrNlXvL9Lyx9d08eSdmBEsHZclnimeWiqUusHQncU+abJtXtaEQqqNM?=
 =?us-ascii?Q?xqneRDAQMuWxFGRC9JMbgVDKyo7B8pL00uXxmei7aYpwrz/Wgr0o7dRfOXBi?=
 =?us-ascii?Q?JQYnUIFk4biVWV3k7JJlKjHyK8+EzV9ESildPepvablttdzIOSJ3j2w+KyTG?=
 =?us-ascii?Q?UcEkqu95tA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4544f3e3-2971-40d8-9ab9-08de5dc6b689
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 17:08:38.2916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSMxkTYKxbzIzetLUWbn3ntbmgVnYCNV+8Y6TpaOM43b8lM9ZlPygZHvZdw/4dYl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993

On Tue, Jan 27, 2026 at 08:38:31AM -0800, Nicolin Chen wrote:
> Hi Pranjal,
> 
> Sorry, I missed this!
> 
> On Fri, Jan 23, 2026 at 09:48:37AM +0000, Pranjal Shrivastava wrote:
> > On Fri, Dec 19, 2025 at 12:11:28PM -0800, Nicolin Chen wrote:
> > > +	/*
> > > +	 * Avoid locking unless ATS is being used. No ATC invalidation can be
> > > +	 * going on after a domain is detached.
> > > +	 */
> > > +	if (invs->has_ats) {
> > > +		read_lock(&invs->rwlock);
> > 
> > Shouldn't these be read_lock_irqsave for all rwlock variants here? 
> > Invalidations might happen in IRQ context as well..
> > 
> > > +		__arm_smmu_domain_inv_range(invs, iova, size, granule, leaf);
> > > +		read_unlock(&invs->rwlock);
> 
> It was kept from the older versions where we had a trylock. Jason
> had an insight about this, mainly for less latency on invalidation
> threads.
> 
> Yet, now we have a plain locking. TBH, I can't find a good reason
> justifying this. And it does look a bit unsafe to me. So, I think
> I will just change to the _irqsave version. (Jason?)

My understanding has been that this invalidation can run from an IRQ
context - we permit the use of the DMA API from an interrupt handler?

I though that for rwsem the read side does not require the _irqsave,
even if it is in an irq context, unless the write side runs from an
IRQ. 

Here the write side always runs from a process context.

So the write side will block the IRQ which ensures we don't spin
during read in an IRQ.

IOW I think this is OK? Pranjal do you know otherwise?

Jason

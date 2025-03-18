Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5797220AF7C
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301013; cv=fail; b=Zx/SB/abDVNc+L98G30m6DcnqNiIcB2CWXSRSHpao25nDlYi2KaIJncVStZvlSMNtYfD6kmsf1YqnGDnkIqYOu0XBturO+bwHot81RX+SypRSTukBwVG2iyhrVXbY8rysTeL+VWDts9iowRevBwX5K+mDPA5A3/9VuKfYpMm8+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301013; c=relaxed/simple;
	bh=Z9rpnCWti/4u6gMGRdKvYgkGJH8o1lSu0YniUhZLC7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XVSDWuaWgXYFnw3xMgPX8PjDKVxIIoHRnNimyK+9aEYrQXt0O83Icotc2jl06Ay4nONFzvywBHO3v95PyNi44V5V5uwfbrp5HS58vVaG9et8bqwkSgOMZRJ8o1qneZDvDAE3eB5eo4DpAnx2r0s7TktZcY4UBDtjTspthFXGY5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UjTewsMh; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UjTewsMh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqlR40P/NzSbmBevsRMrjwzvhyC53G0FH8drhbsEU4a4VCTHB+29upeSuXh2+So1ruJfgPbDXCPMMQ/XpsGibHaDLrTbenvV4Mvq+TOyps5arGIQMzP4IizJ5iknwvyvWuZJuTmpvQoRjYgOUNOvj0koNtbFxbOpH59P4Ev/H5e9c94yBXQPC6zNvPFT8STFWs68E3+eFakhPNPDuuEt0jIj59uyykm2DsOvdknAmjk0ILx0WuoHcsssTgfWt+ZKUBeg0Rt6IJNUJ6mIvNtCATFmFLeMmqI9Nne6fsBhbLttj1Q1stvlt+uuzGZhXyFFqLp9YTegky5ul1SEda9PgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSEuIa/DzeSRqZ3iZAAuSzd0ZFIDGfGv4QVxzUab54M=;
 b=a373j+5aUg/6P4dGVNaRQ1pxIwEFX04K0/Q6MbvghTIUIeaeapB38f8tMun1q4P1bDX/HQnY+v73RKlult2XT0rF/KQxJnoRZtj/uUmGp4lYH/O98AHx6b4gSpm3vLyDkQf/88YGq9ldpT4Ct/GoB0QshP2a+CRW+5pGxRps8iCWmBkzR+0MIsfX01KV0IVqQSBnWHrn+l0xKUo4E0Y55I/VM4WnHOzv1rmC3PkoCaNhTigW1xRT40id0UiHo115P1ymIkHFY3T24bYAJCrvl2dJ7HaxbeskW0yXaiV+7qJggoelk+GcnXNGFFOQpF75vIuWcLYaMGF96oyXyQXTVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSEuIa/DzeSRqZ3iZAAuSzd0ZFIDGfGv4QVxzUab54M=;
 b=UjTewsMhfqZAMj24scKtw3qLEP4LMeP+1Y36qfsVDSnIisWE2EXmQE2TbEWNKw56ewBVqyQO44UzbSoYTs3XhUpHH604dIgC1YrmxG7Zluw3JYdFjOwiqMrMr+iQSuoPGEssJioOT0wxykLSIOuXrbEWADgm/ZqChJ2K11Vd8JuSQavL4T2iAoLkkZDAHykSkZvdbFN1Ht45CB44ByKDeoXegp6xODMMuY9etZWtP2fQEKquC5+QO0J44Fw/86Ft+V4+/qeNPzyhpM8xfpASNfpNKU5tlg1FLMNDxJHdu2QulMceLMFKYJQ4SuUblLuxf+X+ZpoyC1/vNG46LUMt9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:30:09 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 12:30:09 +0000
Date: Tue, 18 Mar 2025 09:30:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v9 08/21] iommufd/device: Lift iommufd_attach_handle
 handling to upper level helpers
Message-ID: <20250318123008.GI9311@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-9-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313123532.103522-9-yi.l.liu@intel.com>
X-ClientProxiedBy: BN8PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:408:d4::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: 4edc33c6-ac41-4963-7858-08dd66189ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oCLWuDnDI9Q0XCMd/Y8z5WTa9wjFY3eWtmLmxP0pSR963+XZ6Z6j2KfxbF+8?=
 =?us-ascii?Q?lqpNncwzhsRMG1xDIs4dUWFcca5Slo7a3s6arul6hSfJWMuK/tkDYhZRmmV2?=
 =?us-ascii?Q?lwUFz6+uIhxcdth3TxmpiVjqddU42q0uztHy2bRtm8xwLiUCeUhx9cZ3oFkl?=
 =?us-ascii?Q?2crQr86waRnsqK+2NevRU0rIrDWhmG1/nb+kVRprbPo3CEY8FNkc3zIn7unv?=
 =?us-ascii?Q?gT7WFUbeUv6+k7eKw0HKB1XYLWijPeqaTVTZnr4EOprdy/gTimDpQ6YGYjpP?=
 =?us-ascii?Q?ucB8UXdF9bZPqGyaEaLI5Mg8wydrUlU51TQ3u/BKK64/kfeU1PrsWoKWmZiq?=
 =?us-ascii?Q?AxjbzJ8t/uKxCuY1IHZIT209NpwKBth5+l2wezy7GlOChkNeAU7OvYRYM4q3?=
 =?us-ascii?Q?j2CUia4yK2q4/9z0GCrn79lQH5hjb/p//c6aDsI4NgjeDNL8yTodzKrqb5vC?=
 =?us-ascii?Q?LT6WkYb11r+twfG532450cG8Aw46kk3pELFef6YCzG1F8WBs2CBVi3c/wia1?=
 =?us-ascii?Q?4W7negPDLuvKWbEVQr9QqTLM0L3GATiVe4tAVNm5ue3gw8NlW7jUSeFCJrEp?=
 =?us-ascii?Q?zDrAuXLVIVXtTZl4pRbkpvN61njxV+ggIA7TuP3GUDTn+QVZzoF0PgCx/4YP?=
 =?us-ascii?Q?hdTSTnqWReEB9a0GuPi1l/HeLaVLNMEn3qcPxCZjBERXhrXoA4mV5jG6MKrB?=
 =?us-ascii?Q?Emca9AdQfNpGqy+u0XkDmIFkVc0mb4+ufkpqM18+llsVGdNCuzeWNQRezgZ1?=
 =?us-ascii?Q?xLwq8cbNglqtkG89MflMo9xu2oZAHz7FfpVksnFYqe3rNP+MrukOXOtLzc7e?=
 =?us-ascii?Q?Z0kdrJQt/CXXt3qG6pUy/5N/6yk64t5or81T0BdWf22WnsoLN9r3ehPOoYg/?=
 =?us-ascii?Q?2WPqtVJQUR+/NuRpRqH2KFsbJTXnu75WO3XlDpIkfOKd+iLFk3ztqdvYjIt1?=
 =?us-ascii?Q?uoRsNzDXTl7y0wwWJNki3bVL101+6NIzWJMxo9GPErzmwgG0w9hyWRZA9F4n?=
 =?us-ascii?Q?Otpz/Yl3CC29nulzmGhqMbk96dVM3nqxd85XT1FsuKU9onPNKebJQ3QHJmMl?=
 =?us-ascii?Q?akCp+qsH3DHcRrnCkSuKRv0p+VwaVURcnTsnDzJabc7UfVxlHeidrB9J7ZxC?=
 =?us-ascii?Q?yylxU6HBO9lsUyjezMcL4uBfL9TfUcfZobqYwzDLwEJG2fqOs4ZvDE7PmnhA?=
 =?us-ascii?Q?5Ug+W23Mmqk772nl+jrCwc5LEkcyNyAFJLEo8yT5yNQUrbEuDfJGYt3heWv3?=
 =?us-ascii?Q?d+Y5vngnqKEEvlpO/0pSrSfsxIwq4/FgATJzujVCrKu+EWRr3c/OeM6bVNon?=
 =?us-ascii?Q?E8kmxQhmGwJ5j7RvdMOuecdy077rih+BRDZMEbBjAMMTrwcGvZVtRFuLWk0b?=
 =?us-ascii?Q?9KTVIDAks662OLJDymA0DIru3zGm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k2vJmx72sHYYlWx3Bx8woH3m5+nBjRaxgOD3e4omArlKKUfxt1zbwJNu+4Kj?=
 =?us-ascii?Q?AOg2EZmDYTTwyDV36+ihBjjaFJ+QUqIA+zZV3qxptoQAKuPUlmG0OHXLxkHE?=
 =?us-ascii?Q?bxVjx6IxAnZnuvzjedcueZSOARcBKV9VRgo7IGE/3CDRpOfCSIHnPnPbqZ9m?=
 =?us-ascii?Q?kcjJQvdEFiBOMRbRQSL6izvP4W/ipRcF0x0ukuG3oKMRG9zj+f7shgeirGcl?=
 =?us-ascii?Q?Wecd09rumtomDRUDeMi5kTE+C4y+ZVga9Me/RYhnxeK1iGI8pOPKGVKPJc0N?=
 =?us-ascii?Q?A4GW9mHh+seLZ6jPKFkLJi1L/eXJLtzCGcParzVvGOzJBosJBi89JvAwzfZ/?=
 =?us-ascii?Q?9pvGYbhmgtb0Dna8IALEkEPcPlIzFNx+fNeUzQXw5a8QCGSCYFDIkcVQeWwY?=
 =?us-ascii?Q?ooBPjzwHozu+EApvcLFZ4i8RxOf0exCF1a7jrg6m7mBeE2s/UYMMrlAllP1k?=
 =?us-ascii?Q?N9IDwVUi14i/FyLXwD15mfNlcBkLi3pQeEbDZsiemwPHxajunW5h4kzDCKDK?=
 =?us-ascii?Q?HH9b10i/t6TC2/jYWVoMOYXj60LmWObGujsDf1xDuLU4V9DY/jY9bKzc6uge?=
 =?us-ascii?Q?/nYr21d7YbClyKrj3h0x5w3Sw3E3ZbelOrWKFn3xLUU5qxx+9SguEidKLEGn?=
 =?us-ascii?Q?qiqCgtkiZwTuuiURSKIrFNxs+2TPalFKrjqngSHALLDx0fs4rWfX2y+MhR8V?=
 =?us-ascii?Q?OYqZ93gT3Tw0hqYpdQDEtmGvpEhTcmb20Usaa1hmvJoMZZ93bCs2sVSYkw40?=
 =?us-ascii?Q?Y6oV0gLqv3zhKSbui8CTPUgTG0fO7Os0mW1IRXtgJspXsO3zUNY3E9HOw6Jw?=
 =?us-ascii?Q?J26OcxRAhQfMpJ58t+hsnkEF/rHNq3vCtNBQ8jPDA1LOAeY9BtYqUvhi8wLv?=
 =?us-ascii?Q?RcWik6Uk5t9q5W3W0kSRm8//HGJLAY9i4ruk+E90PDTUC+/59a97zevWeElp?=
 =?us-ascii?Q?JfCtK2w97eoMPfssNosrZN800BxpNiMugAR1TDj0TLS9Vq7EbN66Swx3J0Ly?=
 =?us-ascii?Q?Tkl0ZEtqDriFFCPgEH9/bIzmg64Q/k+hW0/T8xMfvis/Jq/5ELbDWvpsoYZH?=
 =?us-ascii?Q?l4VsjrmmkiIV2AfcdkC0jAfaFRckXdTprHI+JCCGWZHFS8lYOsIpnsBRxX/A?=
 =?us-ascii?Q?XXCktmFGhoXJ2aGE3Tqt/Ioq4IkXk4V9D98U7GC0XgqD2N1SMZknZwB7RNtP?=
 =?us-ascii?Q?jjknTnQ4djgHtP00UCpO+RXb/wN210jFcGqfTmyMSeRHxEgPSHmz+wAvaA3O?=
 =?us-ascii?Q?Zv/4YEYhpuSblYF9BgCYRdEJ0eYzZ3m5HpkIIp+9Gso+DQvjfc8NqaGey370?=
 =?us-ascii?Q?TJW1B+s+98Rc7Up952l9wxfUYkjbYe28a/ftWYAG9GVnKoscPRkavdLggmRU?=
 =?us-ascii?Q?OLLQo9KMuX8OksuAXukWV6ciB5IxGr0BPEZozyjXxSus9IHqyrOw5q/BkfcW?=
 =?us-ascii?Q?tZrDAd95BFEwPny6alMGXmlW+oB+LT2NPaw1UwchdGHrLh6xOClM8FVmzF48?=
 =?us-ascii?Q?+w9erxcEwmrtF/d/jysfcOMUCmQpzC2sBAIKysn05RPc352RYWmBNDfP3jUt?=
 =?us-ascii?Q?UYPUfCAcVZY5rFZRUHrzuhnRMjiJQQK6/2SxCDTW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4edc33c6-ac41-4963-7858-08dd66189ee2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 12:30:08.9668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N528X79ZGe6Xw/lRWyTnNO4jUbetbUkWPHEsr9sUHmWZXmIsWHGhI5aU3IZJWLhP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221

On Thu, Mar 13, 2025 at 05:35:19AM -0700, Yi Liu wrote:
> iommufd_attach_handle is allocated when attaching the first device of a
> group, and destroyed when the last device is detached. The life circle is
> aligned with the igroup->hwpt which is used to track attached hwpt of the
> group.
> 
> This lifts the handle allocation/destroy to the upper level helpers. It
> prepares for using the handle to track hwpt attachment.
> 
> No functional change is expected, except for that the replace path reuses
> the old handle instead of allocating a new one. This is needed when using
> handle to track attached devices of a group. Otherwise, the replace path
> would need to move the tracked devices to the new handle.

I see why you have the earlier patches.. Any chance we can not do
this? Reusing a handle is making any of the handle data unstable on
the unlocked fault path which is really tricky to combine with the
fencing semantic for cleanup.

Jason

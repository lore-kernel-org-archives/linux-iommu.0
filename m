Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793846103;
	b=rwWqY0YxiTWUGNKpqtR3+Ru/O4DgcX1XWZw46/6U8SylH4Aav2JXBMAV0F7y1fxYXXGM
	 j3XLFdZ/L+mFPwt5++MYtUzt5zgLdQ8Za+jI5ujx1T+n16S1j+2b6hgRfWovv9mLwBV0p
	 ijXOfEO8jCyiXHaF4X2xbHYfqwlgq1VFz+utpaw+EXINeBXKxpL5VU22e+1SuGeCHY4zh
	 WK6YTy9Z13nAdz5yBxPfk4kpH1/OJxOQ8R8GEpRcRdVs4BwanouojhiM8p7nq6UmWhhsM
	 oAniKT/uNmwMzE5BrusDLI8pAL9HxqLc820AMmeTK76FPPsYtEONV/kCsV2VsMRnGWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846103;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=33l98wbtnjVEPgB56xsbI7luqCxkNi7yBO3e3ae5MBA=;
	b=TP0F8G650tC08oXeQGmmLsc3Wri3alQ5FePql5FKWjsvFZAK2EzESYSTO8t6iNiLQ1mm
	 brb2WawoKdbyHZLQYYoYl4Lg5r2JxFwO92z9Atff3osr5MnbsdbnSbCokUP7/mVLacDZk
	 bnnRBX0O7nKO5bx8DDXOvnsJvuCV6wjnBNOSRk2zas+4AuOY+vLX+EJRO8sLbmbNaFPiu
	 kfSuemSjx6+70OEcF5ep98HPYyruXOM8vSN/yGaLPLoOjYaH9qunHonjqvCruAg/y1auv
	 PDeXjMfuTjEENsg+MceNxdPpQ3k9JdmQ1eUNtc9THRFQnHKk1xdkisD4ITcVUIoKyHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=V0MC0Mob;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.108
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021108.outbound.protection.outlook.com [52.101.125.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB0D606A31B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 02:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EB0D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=V0MC0Mob
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAN4hmYBckT9HqxnJBtuK+MwZjjqDuklXE9lTP5TJuS5xcilLigp6+5q+GXzPu0zedfl69J2tnQfGqSbx3tYNq8bv48R/RF4KxVe0gHlEjhn9xSMTh4szTyzKeGUtIgXzRLVOnQW1vFfs7lZU4/WRxMzeCXOU0YakUfrW6f6tRcQxhXkolbpcmbKDFCAawebgNrsVQ9CWu+bv1W55xuVfMaNFwa4TvV+DQ0nAsyCPAACI9/ahGq4UtHBgn2Fm1QMA6z729HLwIKx0L3R+sUsEdLrFxQeyA2LKllsiLGQt50jeYP9KavjxWmke7ReHYhMC3IB+Cqutxbg/48WvLSiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33l98wbtnjVEPgB56xsbI7luqCxkNi7yBO3e3ae5MBA=;
 b=SbMmrgFOTaySLA+4r8jme8lkaTHQNOFhIXZkC0OBLJLyWT0xQyQrCRUJ/sPmuzF8vE5Z4geMFSVoHJy+zXiI/323F1Wuay3c7YzfY70b1DdkRfNseHY4qih0pjggCxeTWyzipX2HRWmjrTp1/CpV1m6rwu1DMxguLKv5tzrrQsIoQ9BfJnPi0Xo1eD+hjNj86o+Dyy/9Ieb7JTv5TwfJLBkvDeoqQbt2AJkEigeClhiTabLHxbFUXhpJMtDqX4SC6Y4/YUdkwdBOaUcIj82XRunHYUPr+ZHQ7Rx+yGaW6A3I6vd+/TV6kLEtDAR7d0EWgP1NWHiIzD/K4Iq26AgaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33l98wbtnjVEPgB56xsbI7luqCxkNi7yBO3e3ae5MBA=;
 b=V0MC0MobhyzcyYt+ZRIkUssWK3l9rh9L6uiSMHSanypQBJg1jh5E9M18zAGwweCi6G8zEyoStOYkgFrEg0sjRJvj9s7FsY6LuE3URsAlFpXXhlenUqH/HgoUOLe6bFvxji30tZrHXzciKyfHIcJqo7b1cz21g3aej3cb173k+GE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYXP286MB6090.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 02:34:57 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 02:34:56 +0000
Date: Thu, 5 Nov 2026 11:34:55 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Magnus Damm <damm+renesas@opensource.se>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Marek Vasut <marek.vasut@mailbox.org>, iommu@lists.linux.dev, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iommu/ipmmu-vmsa: Keep shared micro-TLBs enabled
 while in use
Message-ID: <pwg6aqv4je2xxkaulozeqnmkvoeftawb3y6lmnezgazeyaqpcq@losutia6dgbe>
References: <20261104162251.1749998-1-den@valinux.co.jp>
 <20261104162251.1749998-4-den@valinux.co.jp>
 <2d0fbfdd-4497-492e-be26-9f4b79fe47bb@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d0fbfdd-4497-492e-be26-9f4b79fe47bb@arm.com>
X-ClientProxiedBy: TY4P286CA0070.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYXP286MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5cf87a-0250-40f9-97ab-08df3ae56152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7416014|23010399003|6133799003|10067099003|22082099003|18002099003|56012099006|4143699003|261026121527099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	o5B1MnpYHdYu+JxiKNzmuOOUOMZWRTYhx+sxneIaDG14O/j+ohueTJGrkSH71jyYMF+OWXYMD00qXeLrRypsb0CMzNTbjNp+q481xnSD3D9e35bjFwN5yM1GE5KWmkezEEKq3Gy/+PHceJqD7LPs7qU56YpS0Uo1NINnuoT6ThF7KfMb0VqojAQan3QMKWXf6JBytwu7XTkP01qWc2xf0OsaKJbKzp0iqMUuMrwmRiMCgAIfgD6H6hqBLAhMOWr3wFFz+c9QOshmUjBtKSdbyyixmwvkgFGaub0+qY2oEP+F58dBOJwczvw1GxSoyUP9cmiZSspLIzWrXGMA0c+qMTRb2MNCPhGQFrUSZGHaPmXjTApoUFOZWuSlCGNGcARUFWiajdW32OjosaVyygyi7kjvQXJSofNXN2BRyR1bxDbUlfJFhzdcT11X7CZDbbRVvY1U5m5hINgMRzoaSkwAa4EKyMTGtqzk5VojStHw6yck0SbOwnkAQIbP88QbaKmzGiKWttyMzOfBSNkqPF1akk2av8hSgS8Zw+yA+4V0902BGROoYJy/nzJb5Jx7SxreVv1sZI9cjanQ94wZueGwmljcvR+Pef93u0M5mRZ5R3GN6dXKukBu97ym6WHEVULnHOXoEDV24EY6fNTdYDdQ39W9APKWQ2fZ6GjMUesbxpk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7416014)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(261026121527099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ciEL65jJAUdsIAjJapLKolIWD+WTSVmO9skn26f/2dS8q5zgjiyumaLJq24E?=
 =?us-ascii?Q?3dZuCDOAwrJFNnOuMzF5L7LOwOjSQPqFDUC3zgqwKfQ4+n57OWCekXxnZFLQ?=
 =?us-ascii?Q?X0yKnZkNMOzzSY/Qzn4vCP5HjPe2uOmV7JunhdOgsUzN5KVjoVaC8lrrYG+l?=
 =?us-ascii?Q?FOZaTOz6doD8+MQL0P44yqhT398Dpiy82jpF2VwopvVC5DPKHCQuyRGiXH6R?=
 =?us-ascii?Q?hPBgCrJNVj4NYbPFhJvtj2WKH4VaNAOUubG2TTJ8BWD5Iw/CGoYXFZzOjwbx?=
 =?us-ascii?Q?guSV3/BmlnYwO3LHMUD0u4D00Sjb9mAdCUDPydOXzRhqZoojvTIfIbKLYKlD?=
 =?us-ascii?Q?YVEpTStZv/AeOzTvodvBA2320+ITKKZ7XpykgMEImguVlyQsgcgHWF/8nqgj?=
 =?us-ascii?Q?odE1GtA+QVbcnhvVSvLHqOVf6kuvhc8nsSnB8FhmFe7lZ8ciSZ3klcHEgNtE?=
 =?us-ascii?Q?0iQlRh1rKNhm72DcZeb3dtN2QxQBE953pcsdu502OyjQzHxNrYH+7wlTjxYk?=
 =?us-ascii?Q?AI6JDAuQEXplzZkz2xsc1n0uXuFta1IV52/rKEF33nbPfEf1VLixIatg7nZm?=
 =?us-ascii?Q?rTWULL0Zt6GMrVscFyEIKCtZMuslp7MmVT65aQ495iY8q15c4t6QHNOsvXzb?=
 =?us-ascii?Q?pMon8C7N6WrTZQBV+8RrMZm+yL2xqioyLMbku3Ma4rrGWixscwgRLc4+YGKs?=
 =?us-ascii?Q?aQNwDredozAdM/QqPtbxZGpUYQRs5MEHFhzEntRWMo0eoGCCek1BI2DrLXv5?=
 =?us-ascii?Q?b7zgOsLGB97Y0A2nFVQubXv5Kcqiv9w9ZfxlZi137wYFr8kGD9JzK7j2zjIz?=
 =?us-ascii?Q?wJ6dZFdReZFfZ2Z7UOxGHkYrHBDT5sXV+CqJIxVk+F3bMYRtkZ6PIIUOOUSH?=
 =?us-ascii?Q?6Se0VNolDL64BKHNnigxqVB620ASLk89n8FKAYolQ7ehlwhhEaRz6HIbc/iR?=
 =?us-ascii?Q?2tEXiqwcG9wRXcwW73EJTYXCyArLAvlkmnKzYnh0Ii0c4VihEiksv6e1flV+?=
 =?us-ascii?Q?/GkgPkcVHnlTetNJeVAnLf1Zpl/Sc+kXs1srrqW5ZO4JmPlkROr16Ne7Q/mu?=
 =?us-ascii?Q?7phuML3fYnN/Z4GTZzrm5lJADmokJ1iwJBdRqftm3CTsywQBdB5HTfnzTkn0?=
 =?us-ascii?Q?GLRV6T40tTYo52tJuAf9Ad+GnFfkpMkMg1Rv7Z30fQFqtY3n8O6N3EyW8Ouh?=
 =?us-ascii?Q?P+92bk7mVBFLbhHkEzi62jzysQ6G55D+SL4gpW3opN9d93i8UnbBR60P6QAL?=
 =?us-ascii?Q?PQ1ogHYlYqIPaLwN6dixgRHjnITHFztMYpnoBcMnbjmMTFi0GOSg0CqxS56F?=
 =?us-ascii?Q?IW7MOHwk2dHJMaVp2Katd9TMuEkL46JW0q5zK+32Ke7MV5eqf/edecB/qJbz?=
 =?us-ascii?Q?mfYBiuk2n42Qy+AL/E+Va8ZfmSXFJ4N7XZRaBaocMdL8nBIYtSd918DRmhNY?=
 =?us-ascii?Q?n+d1yA1XgZxujYooPhVnNF5FQ92NczTN6DfIyb06F2VPhaD3XVHWd9oVglls?=
 =?us-ascii?Q?uQGubMdenX6lDzSUU95JBDAcr5n2/4SP7jdk21kVpHp61J7EjQvprxaIHaTs?=
 =?us-ascii?Q?acqrBRpdt/7zlEPuQGOqTSM4XQi2DGUH/9MY9dM9Rpf80R11dpbFraKtr/zO?=
 =?us-ascii?Q?0mgEgWmQDdhy5A6LT44he4kNfH/KWAIMY4AFqDsP017UKAmH6l05tGK02nD+?=
 =?us-ascii?Q?GKqYgnIYKxfCWimeAe5AmHQBaHMQ9k/L7bFFsfup9wEb/qa11uFAGFPjz/nm?=
 =?us-ascii?Q?XVbNhe07J+lxXwVHImvAfcu+KcztChFcxFsU0qzSZb93gv+dZPxL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5cf87a-0250-40f9-97ab-08df3ae56152
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 02:34:56.6811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4EK6Jjh9amyXx9oq7xRsxhIAMQQs6bOWCFw9Atwfde9U1rfspR4hyuiDzr5oddn+ZV+vf590geQsSeVm99nQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXP286MB6090

On Wed, Nov 04, 2026 at 05:42:52PM +0000, Robin Murphy wrote:
> On 04/11/2026 4:22 pm, Koichiro Den wrote:
> > PCI functions can share a micro-TLB. ipmmu_release_device() disables it
> > unconditionally, so removing one function makes DMA from the others
> > bypass translation even though they remain attached to a paging domain.
> > Switching a device to the identity domain can disable a shared micro-TLB
> > in the same way.
> > 
> > Count the users of each micro-TLB and disable it only when its last user
> > leaves. Track whether each device holds a reference so paging-domain
> > switches do not add another one and release does not drop a reference
> > the device never acquired.
> 
> Shouldn't we just not touch the physical enable/disable state at all in
> release_device? Once the device is removed, if it did happen to be the last
> one in the group then the default domain will be torn down, so at most I
> would think it should just be a case of ipmmu_domain_free() detecting if the
> domain being freed is the currently-attached one, and if so then resetting
> the uTLB to its desired default state.

Agreed, tying uTLB state to the domain lifecycle is indeed much neater.
I'll post v2 with that shortly. Thanks for the review!

Best regards,
Koichiro Den

> 
> Thanks,
> Robin.
> 
> > Cc: stable@vger.kernel.org
> > Fixes: 24dfb197c3b7 ("iommu/ipmmu-vmsa: Call arm_iommu_release_mapping() in release path")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >   drivers/iommu/ipmmu-vmsa.c | 121 ++++++++++++++++++++++++++-----------
> >   1 file changed, 86 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index cea9348ac10d..bfbb6795ec13 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -7,6 +7,7 @@
> >    */
> >   #include <linux/bitmap.h>
> > +#include <linux/cleanup.h>
> >   #include <linux/delay.h>
> >   #include <linux/dma-mapping.h>
> >   #include <linux/err.h>
> > @@ -59,14 +60,26 @@ struct ipmmu_vmsa_device {
> >   	struct ipmmu_vmsa_device *root;
> >   	const struct ipmmu_features *features;
> >   	unsigned int num_ctx;
> > -	spinlock_t lock;			/* Protects ctx and domains[] */
> > +	/* Protects ctx, domains[], utlb_ctx[] and utlb_users[] */
> > +	spinlock_t lock;
> >   	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
> >   	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
> >   	s8 utlb_ctx[IPMMU_UTLB_MAX];
> > +	unsigned int utlb_users[IPMMU_UTLB_MAX];
> >   	struct dma_iommu_mapping *mapping;
> >   };
> > +/*
> > + * Per bus master (device) data. Several bus masters can be connected to the
> > + * same microTLB, which stays enabled until the last translated master using it
> > + * is gone (see ipmmu_vmsa_device.utlb_users[]).
> > + */
> > +struct ipmmu_vmsa_master {
> > +	struct ipmmu_vmsa_device *mmu;
> > +	bool translated;		/* Counted in mmu->utlb_users[] */
> > +};
> > +
> >   struct ipmmu_vmsa_domain {
> >   	struct ipmmu_vmsa_device *mmu;
> >   	struct iommu_domain io_domain;
> > @@ -83,11 +96,18 @@ static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
> >   	return container_of(dom, struct ipmmu_vmsa_domain, io_domain);
> >   }
> > -static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
> > +static struct ipmmu_vmsa_master *to_master(struct device *dev)
> >   {
> >   	return dev_iommu_priv_get(dev);
> >   }
> > +static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
> > +{
> > +	struct ipmmu_vmsa_master *master = to_master(dev);
> > +
> > +	return master ? master->mmu : NULL;
> > +}
> > +
> >   #define TLB_LOOP_TIMEOUT		100	/* 100us */
> >   /* -----------------------------------------------------------------------------
> > @@ -281,11 +301,6 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
> >   {
> >   	struct ipmmu_vmsa_device *mmu = domain->mmu;
> > -	/*
> > -	 * TODO: Reference-count the microTLB as several bus masters can be
> > -	 * connected to the same microTLB.
> > -	 */
> > -
> >   	/* TODO: What should we set the ASID to ? */
> >   	ipmmu_imuasid_write(mmu, utlb, 0);
> >   	/* TODO: Do we need to flush the microTLB ? */
> > @@ -297,15 +312,63 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
> >   /*
> >    * Disable MMU translation for the microTLB.
> >    */
> > -static void ipmmu_utlb_disable(struct ipmmu_vmsa_domain *domain,
> > +static void ipmmu_utlb_disable(struct ipmmu_vmsa_device *mmu,
> >   			       unsigned int utlb)
> >   {
> > -	struct ipmmu_vmsa_device *mmu = domain->mmu;
> > -
> >   	ipmmu_imuctr_write(mmu, utlb, 0);
> >   	mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
> >   }
> > +/*
> > + * Enable this master's micro-TLBs using the domain's context.
> > + *
> > + * Several bus masters can be connected to the same microTLB, so count the
> > + * masters translated through each of them. Moving a master from one paging
> > + * domain to another keeps its reference and only updates the context selection.
> > + */
> > +static void ipmmu_attach_utlbs(struct ipmmu_vmsa_domain *domain,
> > +			       struct device *dev)
> > +{
> > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +	struct ipmmu_vmsa_master *master = to_master(dev);
> > +	struct ipmmu_vmsa_device *mmu = domain->mmu;
> > +	unsigned int i;
> > +
> > +	guard(spinlock_irqsave)(&mmu->lock);
> > +
> > +	for (i = 0; i < fwspec->num_ids; ++i) {
> > +		if (!master->translated)
> > +			mmu->utlb_users[fwspec->ids[i]]++;
> > +		ipmmu_utlb_enable(domain, fwspec->ids[i]);
> > +	}
> > +	master->translated = true;
> > +}
> > +
> > +/*
> > + * Drop this master's references to its micro-TLBs. A micro-TLB stays enabled
> > + * as long as other bus masters connected to it are still translated.
> > + */
> > +static void ipmmu_detach_utlbs(struct device *dev)
> > +{
> > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +	struct ipmmu_vmsa_master *master = to_master(dev);
> > +	struct ipmmu_vmsa_device *mmu = master->mmu;
> > +	unsigned int i;
> > +
> > +	guard(spinlock_irqsave)(&mmu->lock);
> > +
> > +	if (!master->translated)
> > +		return;
> > +
> > +	for (i = 0; i < fwspec->num_ids; ++i) {
> > +		unsigned int utlb = fwspec->ids[i];
> > +
> > +		if (!--mmu->utlb_users[utlb])
> > +			ipmmu_utlb_disable(mmu, utlb);
> > +	}
> > +	master->translated = false;
> > +}
> > +
> >   static void ipmmu_tlb_flush_all(void *cookie)
> >   {
> >   	struct ipmmu_vmsa_domain *domain = cookie;
> > @@ -592,10 +655,8 @@ static void ipmmu_domain_free(struct iommu_domain *io_domain)
> >   static int ipmmu_attach_device(struct iommu_domain *io_domain,
> >   			       struct device *dev, struct iommu_domain *old)
> >   {
> > -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> >   	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
> >   	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
> > -	unsigned int i;
> >   	int ret = 0;
> >   	if (!mmu) {
> > @@ -630,8 +691,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
> >   	if (ret < 0)
> >   		return ret;
> > -	for (i = 0; i < fwspec->num_ids; ++i)
> > -		ipmmu_utlb_enable(domain, fwspec->ids[i]);
> > +	ipmmu_attach_utlbs(domain, dev);
> >   	return 0;
> >   }
> > @@ -640,16 +700,7 @@ static int ipmmu_iommu_identity_attach(struct iommu_domain *identity_domain,
> >   				       struct device *dev,
> >   				       struct iommu_domain *old)
> >   {
> > -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > -	struct ipmmu_vmsa_domain *domain;
> > -	unsigned int i;
> > -
> > -	if (old == identity_domain || !old)
> > -		return 0;
> > -
> > -	domain = to_vmsa_domain(old);
> > -	for (i = 0; i < fwspec->num_ids; ++i)
> > -		ipmmu_utlb_disable(domain, fwspec->ids[i]);
> > +	ipmmu_detach_utlbs(dev);
> >   	/*
> >   	 * TODO: Optimize by disabling the context when no device is attached.
> > @@ -815,6 +866,7 @@ static struct iommu_device *ipmmu_probe_device(struct device *dev)
> >   {
> >   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> >   	struct platform_device *ipmmu_pdev;
> > +	struct ipmmu_vmsa_master *master;
> >   	struct ipmmu_vmsa_device *mmu;
> >   	if (!fwspec)
> > @@ -830,7 +882,12 @@ static struct iommu_device *ipmmu_probe_device(struct device *dev)
> >   	if (!mmu)
> >   		return ERR_PTR(-ENODEV);
> > -	dev_iommu_priv_set(dev, mmu);
> > +	master = kzalloc_obj(*master);
> > +	if (!master)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	master->mmu = mmu;
> > +	dev_iommu_priv_set(dev, master);
> >   	return &mmu->iommu;
> >   }
> > @@ -848,18 +905,12 @@ static void ipmmu_probe_finalize(struct device *dev)
> >   static void ipmmu_release_device(struct device *dev)
> >   {
> > -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > -	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
> > -	unsigned int i;
> > +	struct ipmmu_vmsa_master *master = to_master(dev);
> > -	for (i = 0; i < fwspec->num_ids; ++i) {
> > -		unsigned int utlb = fwspec->ids[i];
> > +	ipmmu_detach_utlbs(dev);
> > -		ipmmu_imuctr_write(mmu, utlb, 0);
> > -		mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
> > -	}
> > -
> > -	arm_iommu_release_mapping(mmu->mapping);
> > +	arm_iommu_release_mapping(master->mmu->mapping);
> > +	kfree(master);
> >   }
> >   static const struct iommu_ops ipmmu_ops = {
> 

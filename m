Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010041.outbound.protection.outlook.com [40.93.198.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327C61EE7DC
	for <iommu@lists.linux.dev>; Sat,  6 Dec 2025 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765051079; cv=fail; b=acdL3oHTepJ9Pr8MrZaLrY0GYpqdBWUYx/HsFLNM18EeS/K3+JBPbFVNm4e5HSD0rCE19xd1Cv8E6LAMobq7x1K1RUYpRA17xMIEns0ApTTCkt1BFRZtiIDqnz2cXFkQWRp4BevbQD8MBzAUsfxGBJgFjZPCqQabGDXmj+/qjd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765051079; c=relaxed/simple;
	bh=+RSYiEKg8Y1S4KwKR8JRr2PLzd6sOVpNsi6PJ4fbTPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YZzgePMZWNhvbWAFSwArPDw8Kk2V/MA3JPCThwt0MAChUTXcVg5TKRg+/PjNDUkJKeMsoDEkEM1uD2dHGlz20jDdpgzBv8LUTRGlz83zzmSlaewW6tBgPj3KqiuNqGFWtx5zPc/stWfZogk1RhcOWxNRmQaD3WjVHBKmhs8kaN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fOWfB/d3; arc=fail smtp.client-ip=40.93.198.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fOWfB/d3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIYpN4lnl2f0gr1LnIKR6yOfhGZ+9n7tWmD7eZA+ZO4hwK6dsGIJsg5gvEO3HXjzmhTyjfjUHcLyrr+QhoU2Nqerb9yUMhX8nZN6BrZ/WBleUtK86+pPfGq/zDe/aNblUPnaR3n7QWqOaPFu4VDLwBqyugEVbLM3Pk0URrAosQl4DiM7wafZ7hsJKtUpzHSlwE8B6gQPMlhW+k+NK/jo0Edpafux1Sro8N2H2j0XZI7nJ9E0lVPat3SKWSIN35Y2VWkNKD1jREh3ix9hBpcbl5DMjkT6UzIWWEdujUQI9T0QlAF9zkLwaQifeLZsFq/US2/F9Tmb6iKR6/jN/HYzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LoH6iGQw1JNf+/uT9SEI31zABz3PamyvqLPOQboPDA=;
 b=kbs6b/K+/Qu3OcAJAwWHEekrTttAH2yfuSC0shHaMyMOdCPfnQom+XIdbmmn1EQtKV71llD3EX5Kr1OCyhJ5E22WVigICPgLb2NcdM9uibuzvCJPDE0sKtGD71mxWbBZaQs7ANwb+SHQzROcf5xKqCZXdHZPkp2C0rm2939cQkCh8FSmenmpx3B6WANW0wzAoCllhvC9J87okO4UiWi32tTMqba2CepJ9AxTu9v2xVqHfhrFZOF3/24rLmS76xi9OiEDn7p268CAdqDdyTRKgetMvupWf/QwRM9qtG86vec/WXMa7aGYOp9hT6pEWfzIclUqFLxAKB4RIzu90UBHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LoH6iGQw1JNf+/uT9SEI31zABz3PamyvqLPOQboPDA=;
 b=fOWfB/d34A5ZwXzqHl9M/HMrwLwtvDoMQC6tuUAr+TVyVgu4QbJPf+cxunRt7ZeeFGginYzKBzueKAKbowUSAS3FXPe/fPYUNhzlnnMId5oQsiQZUbsJnNREuLCmqS8JRe1KlosxGuJEBdyIg4RfZiKXZF9KVDpkRKwWtHX9b31WVCvinAGv+0xpMcQLC4QKra8LvIoSFI3VQ6PrKaKhIM4cZ0rug2VgFFpszv4ynOMlLWSeyd71jZvk0frPC8obp87hps3ib+AaxWl/g+pUl7ANiWzJGH+uZl2gZSUWJ7wnb9IzKB1TGIGwxaOY0GcxxVXlEVPt2MlBxU7NtogrlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sat, 6 Dec
 2025 19:57:54 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9388.012; Sat, 6 Dec 2025
 19:57:54 +0000
Date: Sat, 6 Dec 2025 15:57:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com
Subject: Re: [PATCH rc v1 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE
 update sequence
Message-ID: <20251206195752.GI1219718@nvidia.com>
References: <cover.1764982046.git.nicolinc@nvidia.com>
 <6ec73bb7cd03d90a0764f12c4b14071158163818.1764982046.git.nicolinc@nvidia.com>
 <20251206193408.GD1219718@nvidia.com>
 <aTSH5Eap7leYQtPl@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTSH5Eap7leYQtPl@nvidia.com>
X-ClientProxiedBy: BL0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:208:91::27) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 00570eaa-108f-45c8-9a7d-08de3501be5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lXHxn8nsI2PKA726qnG/gKPw2+hHepqB3zynZbpTngoY76/54Q/F+cy7465E?=
 =?us-ascii?Q?EjzWWLAQfLJTWkJJ94fs3gzJAHAnu31YkBHIp6y5J5OiyKR26P54GUjM1/ME?=
 =?us-ascii?Q?Lm1cMa5hhbUc0hU8xu1sPcf4F6O++k1XbhssmPQVGj7lKN/Fce5OgqtD0+7V?=
 =?us-ascii?Q?wlwjkDS9yv4+lD06MH4z5l3bpB7y0pY93xNDsri4o4MzNna2Gx37oEkHDAck?=
 =?us-ascii?Q?OSuGsi9l2bjGLk1KvcMvAQzfPLPM1bUKWHbXAPghT3JiPc+/SmvHby/zbx+u?=
 =?us-ascii?Q?gispqN1XydornWxCxK14HRr7MA2Kp9S7D1lMhkx6oQoWr+t/tDBwHQm/JNus?=
 =?us-ascii?Q?bzM1k0yN9q5y7xB6UmLmVp3KQhHUmEwZtjsHVFQw0sNX1b8Hrr8gEeCDiE98?=
 =?us-ascii?Q?lSv8B86DyZ8up6NGWh7dlEy42KwpWgjxIbKWqhrzvGwQVB56KhehBt9qKvVo?=
 =?us-ascii?Q?E6TaTkvzQWEMa/no/o4qwNcbCKZegoFQ2eH7rA9TJ6/5owpnoB0ATVvD8hwA?=
 =?us-ascii?Q?J196oE8hwUjU3F9OGq9M9g2UDHTcpZyLM8Nn8XTm94phf/TuHP7Yrn6gs8wW?=
 =?us-ascii?Q?gB5k0PEey5WP/OL3G3y80zIFvKH8jtlL0wHVfQEBPALtMQIjmXyG9LwYGjlR?=
 =?us-ascii?Q?ocnUlfBH/dDrn1lNR4+lC+HTcJCpmjISLtb3X2ZO4EJzZgmAp4VqjLBH4Jnk?=
 =?us-ascii?Q?cOnsJ/hfsiS1lm5VY2jGrlxKlX/zzZX2ReRz6h7QUoTVLjEnOvn97XudO8jN?=
 =?us-ascii?Q?9he1Dgr0yi2WCVGr+D82xpKZagMDZH/iKvfkp1XM++3cDwduhzlUKdJCuC5B?=
 =?us-ascii?Q?HWN4yMHOA36uSnjDsvmPKV4Mzc9azRZoS2QpmYt97kHMCZivecTz9m/dqazY?=
 =?us-ascii?Q?LFqtuGCn4tnHajCvukMTrAssAGkyKLOtoqrqOsFbj9LtNMw8HJiepju2ffQe?=
 =?us-ascii?Q?UZcXEdS2/Lb0ZO6IChntm42wg7B67yoan8uTwF+uLbD4AuRwrnHQC38cWl99?=
 =?us-ascii?Q?ZjWCpzkkDKHJOTwA/l3vzhSRmE5dPeGg9lXIV0Plww+HnLAM4FtA2lKjqNB/?=
 =?us-ascii?Q?S4zEX39wIpLByKPDJU3+01XE82ESZF/O/teiAMe4vQDXNgdT/AYz1DTBkmxP?=
 =?us-ascii?Q?xwd6e89mjDgO4VDx1RlUuVWoOOus7AIK6lIX0nGx3/DcQpUCeLQqLLHUZuss?=
 =?us-ascii?Q?tMBVGMg04Urk8Qhmsg4BXQSnEOIWaLtZ7+JvUNsW4B/rn2NlguGnFh2l8DDm?=
 =?us-ascii?Q?T3CEN6B3+e4hEoB9zOrEb54JuLnv7PPtTyKicsUtvG5VkdedcP0/fufRGmx5?=
 =?us-ascii?Q?uO3txGIMH+IJDhuw4FQ2vOA8fy9v4QARfZsChaY9aGi8mg/iH+Vhc4LhPA9B?=
 =?us-ascii?Q?SG3qj651utHYC7zBL/SiZIvL9jL7etw2XLdvDierqeE+jvnLQw6xm2D/WbTD?=
 =?us-ascii?Q?tTMgmLML9aWzwQXZgZg4ejljLsBA3GeV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kmorJ/M6PvlvjlYLbjHkYBAplPMYPC9vNE0WRJcHkHUXnwY22gh2hKyc266F?=
 =?us-ascii?Q?E5NK1N82Q+kOgbtEHnq+gb2/UY3JSszt3+bMT4LaeJOeTtrIqheF7PVubwUQ?=
 =?us-ascii?Q?fI5HZJGyTxcJgR7d/0OHjKCsqI1hji9Bo8+DZA/xcHM5n47JHFKQ1HJ8MaYT?=
 =?us-ascii?Q?KL4+44j3WbAyPaIv1TEcumghPlmPNpwfn65H5Y5UAjRlpt9/mn+t3PFFg/mj?=
 =?us-ascii?Q?eGyseXJSXJVzcP2sNFqPbsNfQDr2engMUeeaaLTMVCwmtQyHu3fH0BntOiLJ?=
 =?us-ascii?Q?20F7/Nv1kmkO5/TQtDM+zvIzcPawMA0N7znAGquAPE3KwsWu0+Sphy7QWLH5?=
 =?us-ascii?Q?ACaMW7ggak4a8bOSwnPGnhx4HtBdlESER2pB7RRpWZVJ71fabADwJqZQ98v/?=
 =?us-ascii?Q?avbgVKkTSftvwOYAbusalEm3iPHTaxDWue5POvjnZqWLusL5VOegk8xw0Agb?=
 =?us-ascii?Q?th2U1mUMUj2Jp6jXi1+vU8FmgONVNTH40jt4fNcr1Di8TEJn97bh3ePcjbbK?=
 =?us-ascii?Q?oSjFhNQ8f6zkfXHh1Bg8eM2nFpRfngRO628P/eHIFeLww07hQ04BtQQgtwPQ?=
 =?us-ascii?Q?hGQQigG8z1KMK7wM4WlUHpxuslN5dVRP4RvLcEQAr3YiQXqyC1xOaQ7GaUHp?=
 =?us-ascii?Q?GrNZvWR87+5JlOeZQaMDZICSNik63FArkRegUSqUELE1EeDrvS1twP13WtCe?=
 =?us-ascii?Q?6A21SFr6+CMd/jHy4Djxo1Ea/DHk2L0bkN9NPFws5ApHWRU7i/94gH0sT3vI?=
 =?us-ascii?Q?+wL1i0gP11oNuh7j1s4ONUBuWQoyrGi2H7DpPm9zNKiUwDLdp9KhLJGjJFZa?=
 =?us-ascii?Q?LhMqK0jhXUPSnysZrXK80v5Sd9etGlhHD3vzcCBXZjiPZc2iNfyNif03CuDx?=
 =?us-ascii?Q?2Lpu0xf9nQuVa4Y4DpYunUoNV+JXZ0ZJDPja62ocK593j83J6LeoppHNWQqN?=
 =?us-ascii?Q?B9Xw47Jc3FnG6hfX241QP3jErCL4N+0TT6r+QsVX5rddJ1mPCVjlHswyPyBe?=
 =?us-ascii?Q?MislEVLEbBTkD7jqu6ImMTgyeX7FWCTJ+wS2BI7ob3URepMS8FDU45zs3AnS?=
 =?us-ascii?Q?LuidEfZOmtQiR3jtNDPFip3DkvbFIF0VgWZ/1VJrMziL6K3Bx/7raoQouBGC?=
 =?us-ascii?Q?25iXmHGjTCcEDTV7+tANKCorFHwsGwaEXBg70TkxTfr6c/DQxc5IxYEvNlav?=
 =?us-ascii?Q?gYpT/ypTKF6YSOr8mMsKQnazST7lPomHTGJebY+6NHgjMrm5m32g41gvp1cf?=
 =?us-ascii?Q?W+6lNSADsGUCgDsS5ZmDF+n5pahlB5g8AfOOBgWYR+rVXJC1Q9V7Hhz+BHna?=
 =?us-ascii?Q?rVCXWdpeW01UdZ4FrH6DH9O5xGx06UIidZWVXBTX+kC5NjElz/B4COl15YCk?=
 =?us-ascii?Q?W7iCmen4pzqQ/IVMlwnwk3Zu+ryRQZXy4SdeDMMTCPXe7OeeHE0pD61eKw8I?=
 =?us-ascii?Q?96a4DcTOlwFgXag3G/N71aaaA/8YwIu98/5CyWfpcYqp5S0pYUy3OcBuYvR6?=
 =?us-ascii?Q?CBp4s6C3bI6rraJjKokmfpamoTfpWnLNo3NUqdztjgDh523nqQ5waRYCTEL+?=
 =?us-ascii?Q?25qvWxZbNmhCWG/Iu0Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00570eaa-108f-45c8-9a7d-08de3501be5b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 19:57:53.9321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVMQVgavGT0yWNN0sXJVcBhoxwpvsES6LUJG8Xa5fTEDw1FUACznd2EFZdVGN0A2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814

On Sat, Dec 06, 2025 at 11:45:40AM -0800, Nicolin Chen wrote:
> On Sat, Dec 06, 2025 at 03:34:08PM -0400, Jason Gunthorpe wrote:
> > On Fri, Dec 05, 2025 at 04:52:00PM -0800, Nicolin Chen wrote:
> > > @@ -1106,16 +1115,17 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
> > >  		 * allowed to set a bit to 1 if the used function doesn't say it
> > >  		 * is used.
> > >  		 */
> > > -		WARN_ON_ONCE(target[i] & ~target_used[i]);
> > > +		WARN_ON_ONCE(target[i] & ~target_used[i] & ~ignored[i]);
> > >  
> > >  		/* Bits can change because they are not currently being used */
> > > -		unused_update[i] = (entry[i] & cur_used[i]) |
> > > +		unused_update[i] = (entry[i] & (cur_used[i] | ignored[i])) |
> > >  				   (target[i] & ~cur_used[i]);
> > 
> > This can't be right? We don't want to ever copy an ignored bit from
> > entry, the ignored bits should always come from target. The line
> > should be left alone.
> 
> Hmm, without this change, the following coverages will be broken:
>   arm_smmu_v3_write_ste_test_s1dssbypass_to_stebypass
>   arm_smmu_v3_write_ste_test_stebypass_to_s1dssbypass
> 
> Both were expect num_syncs=2, but it would be 3 if we don't include
> the ignored bits to unused_update. Or should we update the num_syncs
> instead?

Hmm!

I think that supports more that we should do what Shuai suggested and
keep used as-is.

Then ignored should be adjusted by the used: Only if both used are 1
should the bit become ignored. Otherwise we can rely on which ever
used is 0 to generate the hitless update.

That will preserve the tests and minimize the cases where we rely on
the ignored exception - though the reasoning for ignore is sound and
the two tests could be updated just fine to num_syncs=2 as well.

Like this?

--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1094,13 +1094,22 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
 {
        __le64 target_used[NUM_ENTRY_QWORDS] = {};
        __le64 cur_used[NUM_ENTRY_QWORDS] = {};
+       __le64 ignored[NUM_ENTRY_QWORDS] = {};
        u8 used_qword_diff = 0;
        unsigned int i;
 
        writer->ops->get_used(entry, cur_used);
        writer->ops->get_used(target, target_used);
+       if (writer->ops->get_ignored)
+               writer->ops->get_ignored(ignored);
 
        for (i = 0; i != NUM_ENTRY_QWORDS; i++) {
+               /*
+                * Ignored is only used for bits that are used by both entries,
+                * otherwise it is sequenced according to the unused entry.
+                */
+               ignored[i] &= target_used[i] & cur_used[i];
+
                /*
                 * Check that masks are up to date, the make functions are not
                 * allowed to set a bit to 1 if the used function doesn't say it
@@ -1109,6 +1118,7 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
                WARN_ON_ONCE(target[i] & ~target_used[i]);
 
                /* Bits can change because they are not currently being used */
+               cur_used[i] &= ~ignored[i];
                unused_update[i] = (entry[i] & cur_used[i]) |
                                   (target[i] & ~cur_used[i]);
                /*

Jason

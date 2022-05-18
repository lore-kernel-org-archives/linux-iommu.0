Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0B8C433EF
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 18:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E092741690;
	Wed, 18 May 2022 18:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TVtHPJPM9cih; Wed, 18 May 2022 18:52:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5916F41577;
	Wed, 18 May 2022 18:52:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38E91C0032;
	Wed, 18 May 2022 18:52:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87807C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 830D0840B6
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:52:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VaOemIYDr2-P for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 18:52:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::627])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A0808406E
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5j8hlqluE2iItZ7a/q+m6Jtn0syIOl7L+2fVc7VW/pR6bVzaRswr2gCPv3mVe5zMwsJrxEmBMOZUjnYKqE/hdm0LlO5R3UC+6Q/9jQC1BBYSJkPOokpdWhCiuFR4VG+Pri2RIf0QwZY3pW+xSX/iENgh1R/3HA5MKdITLxFq96nC6SNN9flfZsUX6rcIbhxv6RltbhDC5PDbjpSH7mrrQbjPzReO4qNnssJSKiZDfClwD7bya4z+hOWpSoFd6SLr23OCFM/+yeMflfYP8z/WoXXox6mYNkgbWPvbdURtAtLqGbTUxngvONN3Vis5VURy2ZE4fq/SXTeC4l9V3Cb9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIQceqIEVvw3xOj7feWIXVsg/be3tgU3M2WirTfNZ9Q=;
 b=iwYTH+Fk3ICySTFyn6KPBxHeYH4/FtG2Vy73hvZx60UECZBAiUdbKNuX/81fYtPqVsWys88ZfTI2MjrSPuNeNPUKYTD7F8ikfLjkJkFJb4Mk86azbjAJfBD+knBi+YpI+P21wLmiw/ioslyTQXwclVNecpq46lZZS5gnL9ePeW3XPJByXIzsfK/KmK5mkcBpvRCRXC6qUDHXvZe8856ng1/XgbAfWGcWVoYeY4A5Qjom/f/ZQmuQI6V91LYVMrS2AcVZnVWzizLop75ZKBuqjS/p3qsROnYrShhq3+5xxRIR4UvZP0JYMiCC83fzDrmAyhmIT2YhUblL9/B0PZfo0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIQceqIEVvw3xOj7feWIXVsg/be3tgU3M2WirTfNZ9Q=;
 b=oWRcyiJN9lcQsfuYTObFvjWRl2ex82GxME0ntXb8jI4RdI6Z82oVO3Yi5NZ1a6NoRIKwgFxcjhxwAJSp5H4ZQiz74uWiuLf+Xl9oOFKyLZXIkYbVQ9bGmDNBu8WVrx9eeUew/uepuoyoeLgvJRlESJFG2uMkV/Vddl5Heapj9TpSnmqVt1GG799s+T5NT+lwG6U2ihMw+WQ40Fnho4qWhYaHVcpiu4GPpEznnhZLO4AL3tKWKW/FG4D7kpAc7neDVWgJrdRupAGI/acNnmFxo43cUbtre/WUTCILYAVUrZHMfuXaXlYUvJ688/3X/Tygi7vMqJP6+sBl50pY32ywuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 18 May
 2022 18:52:06 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%7]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 18:52:06 +0000
Date: Wed, 18 May 2022 15:52:05 -0300
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220518185205.GT1343366@nvidia.com>
References: <20220510232121.GP49344@nvidia.com>
 <20220510172309.3c4e7512@jacob-builder>
 <20220511115427.GU49344@nvidia.com>
 <20220511082958.79d5d8ee@jacob-builder>
 <20220511161237.GB49344@nvidia.com>
 <20220511100216.7615e288@jacob-builder>
 <20220511170025.GF49344@nvidia.com>
 <20220511102521.6b7c578c@jacob-builder>
 <20220511182908.GK49344@nvidia.com>
 <20220518114204.4d251b41@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20220518114204.4d251b41@jacob-builder>
X-ClientProxiedBy: MN2PR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:208:e8::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1a08d54-428d-4c02-9037-08da38ff8120
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3116977470EE16A89BD32868C2D19@DM6PR12MB3116.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eargjN1rnspgXED8i/q+vsZhAvM9itCFqOTkxov7lLhoPrbcBxHytWbqON35jb6/ztAUluBEsrATeJ+8jJzFq3ocRfH488or9NCti6oMHqMyJ0mNzYYO0jaJkSTqbg9FHpeSKBPQmd6YRUNSdnaGWrZolfNHqX9Oo9iusA/O14CNzrp6PTZBVP2FzLATjY/EBGjmQ75pYmMpfv9P2awJD52W4M3lNfpaQRM3jagAaxmxRQaJhAwURBGy2xho29Z1Jl3SJZaWH/oA++UDQMisZOS5LaLvAEx3DUC4m2ZKMZFoBe7FwoCcTugS1RBIbKwM7JDfIIRFuCzXuR2HDCR+MWxkFj2X9CBDiJuW6WzgYwtu+m8GBnQ5HCfy9ypZ43evFhtAizh0d04td0y1Fgueyx4jBjtFiNqKdjuP38OyeCHhVQ0vFG+UAZn9VtTrL9b3UnUy6b0hF36zJQ0PL1l3kfk5LKklWsiW30qbyN4C9t5kGsMJvbj//Vo0AV5j0OeT7wWaFX1epqV7ybjOafhZK9HZM6GefGYsJDOb5SLuuvrWvUMk4hJJnZvYm3sBBGtTTz4ZVj3wC8YwKcyu1Vtxiu3p3aCTg4v33yS5VbdabvHRRexCddkjvajom99LXbw2AmFxyPtTEy5fAU/4PwSoaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(2906002)(508600001)(33656002)(4326008)(8676002)(6916009)(54906003)(316002)(86362001)(66946007)(6506007)(7416002)(83380400001)(66476007)(5660300002)(8936002)(66556008)(36756003)(186003)(2616005)(6512007)(26005)(38100700002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X1H77KxGRJFUoTnU/mxoaVO6hBVf+n5GCobmaaREHeXEi7ipB7hjMR2DiEA5?=
 =?us-ascii?Q?w7BZBQrzFuLIpTa//arOCyDVV4HGVPOsCZqfx2V8XumYGL8/aOogSjddLhBb?=
 =?us-ascii?Q?PRAFQq+DjV00TBRfLelOYUc2+YA6f19alrfLwlgZmGZ7snnTeGc06qgCspNF?=
 =?us-ascii?Q?ANDYg0fGLxgiV8XIMWv78Hwjth6FzN9GU9uz+2Hk/NapB9O8AJJtZ/UQB0Y8?=
 =?us-ascii?Q?BmXPyVKglFSFyGV1pWYTcFxSgb8US8kS6OlarOR4Rb9+xQifrh6nWM9asx9F?=
 =?us-ascii?Q?pPdg+Ha2rKtKPxlehQiAgrlW1RTNsvLvDHlUSp/2rkJ0nIgVL4ahjJh2gYGF?=
 =?us-ascii?Q?MmrfXrwEF9MR0GKBMqakigbU5Sa5IQ5nJceIpQ6Th/6vhN0ixMSItUAtfUQC?=
 =?us-ascii?Q?TcOkOjV9+cjBZvGcQWvhEdmWiWeG+pPqLgy5n19PBn3spkn5dpiwDFUUzskq?=
 =?us-ascii?Q?m3l81uTQvzqAH2d2E6NioLdAyXC0xs9BHpe9S+9nKEFf0bsgwELjEgBzkKNa?=
 =?us-ascii?Q?TEcfNvnh10pjbgDkgJYFYlKYcrBZqpaTsovj9SgwoJE5MOuIG6qQ3wmGp/qh?=
 =?us-ascii?Q?0HwMjxrpNl4jX5R+e9HNJ4qmP1jf3qhMK6MYo4KD1e6Cuplh3IAlggK7qCKQ?=
 =?us-ascii?Q?dIz9DpEV4+hwXHnpA9ojC8V3Bg6c4iOMq81qpu1vXT994Zllc95+RqNI6V+2?=
 =?us-ascii?Q?DI7D3RxUziEmzcD39qYaN94tHIbrfQRX9PliNS05ih+wZsfAqBXvKy6jX2t9?=
 =?us-ascii?Q?8cOGwi//w1aLykA1TSGHzR4mwkTh7kBpesZgAiNknpVVs5C3vml3v/I+QOrm?=
 =?us-ascii?Q?h2HrRhHVUeT7SfBgV73mvhO8S5/B7lOopm9BiYe4zaD3Epv0gUzNn3n3fgoF?=
 =?us-ascii?Q?pO7uVv/AEDr9Tj6XrNCXZW5UG9l+cFcsoljg9x+SM5OwsyPCnhHV/dTUpx2T?=
 =?us-ascii?Q?s70ue8Y2WtRL/mG2ymgrSJYaIHhHlM4dr8ejYmJpzzqUrju/aobZC80RMjlB?=
 =?us-ascii?Q?hgiQW1zIAcpL8+jL6v7CtSbNXeRm+0EYKvPbjyGPlLkBG9u27VSUgriLE6Tr?=
 =?us-ascii?Q?a4x1eI4Ryr+kgYOBaI+hy+AToWdXyEMbIfef2RSLionvK6k8+6pbVCkN3d8p?=
 =?us-ascii?Q?1FiE22dAb8s2G6LWafgJin9CQR7WO8WQRsGAoCu+Mwt/LDeHzQUNl636USBZ?=
 =?us-ascii?Q?JVrdp94vVQQTZSv0cSTjCL0gq8P2TZc0VTMtgUdb4qRiCF1H1HS6zZ23f+1k?=
 =?us-ascii?Q?ah5LzGtDSiRFUbJ9gLNhcNEQ1WFcF3NhhuX3MjnROiBsjzAx7OA8jbWVaq1f?=
 =?us-ascii?Q?xqbgr7p+Y3UZkNIY6GUEmeNcc585RR/n3Rpe8vqTSuj7nGtOAL8ie8l+jWHU?=
 =?us-ascii?Q?i104J1WFmY4kOKhpr/6NH8/m5j1Jy37tFSlAj075kbkH1aVRTBMCRY8g1Zpz?=
 =?us-ascii?Q?R85b1vdtO9AYOf9p+klw3hjyDMO5M6efCwXq/+I6X6ZkBiEA03Nzh4YyDxv/?=
 =?us-ascii?Q?TY8qFXNxBkuqZ0lMuAOpcrcSe58Jj+bTNrfEZOEcNS2kCHiLBwmG7qzCiMKr?=
 =?us-ascii?Q?UDi4sNKvUSABNG5fdZ8UyiS+dSEzBZwp02fDqwZTa+51fcBahs20iptd9gqv?=
 =?us-ascii?Q?81EAb5kjrwSpeAn/wB7ZpBVDkuOswi0b3+Hid8DX0KBol9aEGIi5OkNAHn1C?=
 =?us-ascii?Q?GDhm/K2QMuB1zfKmLlqFICtkDh8b0rFBKOlieejIl2WsxKlO5mdNNtWVxNyz?=
 =?us-ascii?Q?jB2K4TNyHw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a08d54-428d-4c02-9037-08da38ff8120
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 18:52:06.2275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejawhXS5x2EoLWYcPMF7LKhqawI4mv3WOtRowR5j4/PhIOWwkuycTEpXQ4cnfBSy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3116
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 will@kernel.org, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 dmaengine@vger.kernel.org, robin.murphy@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Wed, May 18, 2022 at 11:42:04AM -0700, Jacob Pan wrote:

> > Yes.. It seems inefficient to iterate over that xarray multiple times
> > on the flush hot path, but maybe there is little choice. Try to use
> > use the xas iterators under the xa_lock spinlock..
> > 
> xas_for_each takes a max range, here we don't really have one. So I posted
> v4 w/o using the xas advanced API. Please let me know if you have
> suggestions.

You are supposed to use ULONG_MAX in cases like that.

> xa_for_each takes RCU read lock, it should be fast for tlb flush, right? The
> worst case maybe over flush when we have stale data but should be very rare.

Not really, xa_for_each walks the tree for every iteration, it is
slower than a linked list walk in any cases where the xarray is
multi-node. xas_for_each is able to retain a pointer where it is in
the tree so each iteration is usually just a pointer increment.

The downside is you cannot sleep while doing xas_for_each

> > The challenge will be accessing the group xa in the first place, but
> > maybe the core code can gain a function call to return a pointer to
> > that XA or something..
 
> I added a helper function to find the matching DMA API PASID in v4.

Again, why are we focused on DMA API? Nothing you build here should be
DMA API beyond the fact that the iommu_domain being attached is the
default domain.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

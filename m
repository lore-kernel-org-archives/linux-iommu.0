Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9072C433EF
	for <iommu@archiver.kernel.org>; Thu, 31 Mar 2022 22:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 710386138F;
	Thu, 31 Mar 2022 22:26:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 87JLJcOQaghs; Thu, 31 Mar 2022 22:26:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4706361388;
	Thu, 31 Mar 2022 22:26:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 154C9C001D;
	Thu, 31 Mar 2022 22:26:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39C3DC0012
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 22:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 106E741CAE
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 22:26:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EY9w5ZCk_ooj for <iommu@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 22:26:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 47FEE41CA3
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 22:26:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADUzU/6jtZTMprgxoX2eF2IAindoTFktmj1+0S08Lb5QHa1QK7eXloYJTUVOODxBANsPLx87Yqe+G9W1dR3B3LuQa7m1+yUj/3kWKHiPNO2jZKBQWwswz+YfrgJ7lp3Laej35GAl4pIXGMvq2qQBKTFhAvUHG9Z13r1G0GgRItOw8eKeRtktqHolmt2f9Cf3uNRUv1OW3p7C9FvH7Xqb1iCm7WqWRrswfbjegjmPNLlw4gzRcERjoP5MI7pMbgZPj9/1QU7fTv5coSPjuTmD8RqWpgUWh9AWFQLBaB7rzZ20aXB8/fGa54iYlNyBE0Dt0cVq3/df3f4q3RIKR+GZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtJt4U3XddyaAF6RxBoLcxcD+kNCWxOCVVX3rhUxAcI=;
 b=VgdfL77oq39pKnKOcz969wDPmy2GHokhFWjwM2rlyczI/7uBfx/+UjVGWJ7HPzyDfIepPzpJ+hm7rxWHORpwcQy210iySa0XF1yEuHJGwZLOn4Aea8c6A8fbBQyiqYS0EAM9SPP9v5LChOGWR+3K5KwzB2hfNdt4864QoerXFhHFlAka8fRVLNtMxFRaHj1on8+Fta5wJ6uwLYA2qsfu5rQX6rcyFHFeCZKxu44XYr0I+o9s+Mvkf3RLkeiTYhJ35CGh17CWe7XzhiGsMi9vcrkmfNQVZAYEEeJQZTvhBb5BOOJA3rHcQGouPH3+7x1ZsGJRbm7AFKTiowgf2gexCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtJt4U3XddyaAF6RxBoLcxcD+kNCWxOCVVX3rhUxAcI=;
 b=cVL6iWd2yJnbKDmWHg2YbxgS++wU9G4x6KPrOVpeZ22ZFSEcHGcqh1LJfinKdVuRea81l6+K+KSXO6tS8KAxkXuYpCLWulQwZfC5hgAX8AhSozgb5rTm7lDk6pGAcDq8TStKzsVKZnhiCTC5xK4AaQeYiPdHIc2KktO/8sBdwHTHryvWeEQb+ZAaG9R8jH7j8zSKpz00J0w4kiw2tWTqWEWdTHeJK2KuWvCZ2qgmZ7Ny1fTB8RgNgUUBp+chRGf0fJsqRG8pzut9bqxnkQnuNw1MlBOGmm7b6u0/91H90B3YPCBMqB1hEsH2cpXcAAWco9db4MXXeEk85SCkcVv/wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL0PR12MB2369.namprd12.prod.outlook.com (2603:10b6:207:40::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 22:26:31 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%5]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 22:26:31 +0000
Date: Thu, 31 Mar 2022 19:26:30 -0300
To: Jacob Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH RFC v2 08/11] iommu/sva: Use attach/detach_pasid_dev in
 SVA interfaces
Message-ID: <20220331222630.GI2120790@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-9-baolu.lu@linux.intel.com>
 <20220331135922.6c677117@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20220331135922.6c677117@jacob-builder>
X-ClientProxiedBy: MN2PR18CA0019.namprd18.prod.outlook.com
 (2603:10b6:208:23c::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a95b7e32-7316-49b5-dd3c-08da13658183
X-MS-TrafficTypeDiagnostic: BL0PR12MB2369:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB23694BC39ACA9C6B44485989C2E19@BL0PR12MB2369.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0CcMgBElbWDLK8duQm9OBHehd7CR7knDRGHU2kSxz9xLgr0c/yT2W6FExUa6wLm3nDGgVbRjudo9iGpff7h+OJAzZTlK+lvjbSBei7itl06DJlyM4oWp0Ve9g/LlL50V9UpEfLr3LAenUP7JuzhRX7FvU2/WtI8zKkTmOgS/v58iky69gwwtmedrVq75dVwKqHtqSbs92bFomgLKAz+wkVwwcN+iFYzrcZZrkM4uwfm9P66UDCBN0qkT0y5eNfUpPCVLyf1e9ej8DDJxdgikkN/oO9P0sbt1EIIqd7sKWQxHbTPi8GC6U3WnV64bm9+UWrNzab/GIw+T3amwq+yOrHpa38isC14jFqaziqBSYciNpw9yCGOXvF9zvushX50sfHdR++2NqgVxA6mHWjI+2B8+b35ROl4kr2Q2J+7nYcQSNzJwUdzb91JZm27rcNjrEyB9QlnpAaEhIZayYCUWvOsYuixTk1fVp4dFX8oBVmVS4tUwvJvBtkKsLwUBnSSGR5D581kF728qT8KbjphNo5WjEzQAQar45JqfLEaeDJpJGObYdi1zzIZfcR6vbJcQCxJIuYnhOP8FJ6hHrF6f02yWAzbSqr3MAdCfbTG8UVmosc/pCKhfV/TqGdSj6oANRLC6Pk+Yup24IPpWU5J8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(54906003)(508600001)(6512007)(6506007)(7416002)(316002)(4744005)(6916009)(38100700002)(6486002)(36756003)(8676002)(186003)(33656002)(4326008)(86362001)(26005)(1076003)(5660300002)(2616005)(66556008)(66946007)(66476007)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IYfMq3/am+gASB7bcl6U266yxBwUZu68qxkJWVFNeKRQ73iuvFaFpBlCg08c?=
 =?us-ascii?Q?9xRF35+Wd/VHjofreV0p8Ui9USAnG5DF++zx2VT1eilDU70Efq0pRKC28hVU?=
 =?us-ascii?Q?fzgzCLosCfBnVyRbiVcuyqOkQd9Pg12Bm4vDClEceMGtAaDqXxh63OSOGVec?=
 =?us-ascii?Q?0zyOjyw+powzwf9AJc/VbFjkaBeH6zD28o5NkQRmcWuEzpgsv+6bDhdKoFGM?=
 =?us-ascii?Q?Y8dZsAugA+MYQ2cYoeUYL7zS0/NVhX4CDVrBCsm1GYWpQRq9zX5XLrIXT7Dw?=
 =?us-ascii?Q?MvFdMmdU2peo6aTokWrGL40f1A9G3MGi1dPpHSQwpkCX/fAhvDDgF4v0YaD0?=
 =?us-ascii?Q?nxvxE/+sxHX//VvZPZY+5BsJqu4fuIhT/C5zkLnWeWkoSeYlgqcTi+y+uT2t?=
 =?us-ascii?Q?VcWekxL/wt3r6Ja/ezGxr17l8ZQwrTSAYphLJhwSifl/GPVaiTR4xM+AG/DN?=
 =?us-ascii?Q?YcaKOJq1/f5joN9anDP0gDbNBOWNt13ElymHFImQptb7CFKPEe1F4NXnlgTC?=
 =?us-ascii?Q?YX7g2bBkEec0JNBWepvCD95mWPV2RF9Rn9pmpQqKpkmFfyLhBb5DWas8hpxY?=
 =?us-ascii?Q?uQGrniBvSigP7Te6Jw8bR627hxvPYRYu7kJhrDk5PRDqGc2yN3VdAbuPfU+u?=
 =?us-ascii?Q?d13Ny5W42E4KUtWkb2MyFagZpUgf6Oug/IzuXPKKJ/eeDPQBlw/hwPy6iaUr?=
 =?us-ascii?Q?6buHfjxwU74zbU9hGku8xiAlMYNJrVg4Ut7HsQGs03RKzPho20ECd3ZKglAH?=
 =?us-ascii?Q?7ExiGteh3TjWlJwh5Trt6czpSLsjJWDdFh/QHZCqPap5q/OkxtLOFzUll4VC?=
 =?us-ascii?Q?wxOGLVIIl03Mfknid5c1hHTMTU+PaLbuHbBkmgXydXZfH43VXyKSyIWYseNr?=
 =?us-ascii?Q?AAytLGogWTtjAVLyTxRlKslMx3hpioMFAwkFbXq8TvXBskV8hbPZoUD6zUKx?=
 =?us-ascii?Q?Hg2H/xq9Y9p8VmJhy4gmhfqWLgubyZaepLYKES0UGoumkEo7tB93oeWd6K4I?=
 =?us-ascii?Q?s1teo9RJwCj5301zmIuE1eBJkuxkuZKyd58SwFp52nqsp3QqQk20IsXlHIoO?=
 =?us-ascii?Q?GLhk1K7MSiI1iAi+63lmBLb3W01WC8hAxCyLfV+Ihcji9NNf8yweayAzmNo6?=
 =?us-ascii?Q?YthlLffwOJlXfuy4bVkZZ4PFkXsE3dM458bLJQc0hCZQvkkip5voUJwCx52/?=
 =?us-ascii?Q?zXDLRveN55L39glbWgnuFHJC8a6Ct/bNFuMPKYGfx3ONbKtUL4eQT/7W3Eth?=
 =?us-ascii?Q?OkRiVudlx+q3/80/FM419flw9P+V6ez7Do0cKwZ6W3oFseZwwcJHAEWmRbVC?=
 =?us-ascii?Q?LxlfsXx+DQi6mzP5qemJlbao5vYQFKlQdjDQ9tBzlqSvx5aBpyAEYtJheTev?=
 =?us-ascii?Q?EdRo4WnC2SjIyNjZDvtcTOZoSSu0IOmHft53+0xgnxFiqM1+baosveN9mGPh?=
 =?us-ascii?Q?0cLmwDBficDnMZw5Kl6qEJ6pH1xkNk1nnCmb9PtYJ7Q6H6VDnPCSYB8ZBOKH?=
 =?us-ascii?Q?G2Zzk/3oJPcgSGIgHdCTs7AQGyA4ppGJfH8n25lqVQ3AlerEC/yNeoZnVsC6?=
 =?us-ascii?Q?4S2dJ5vh95k0O3XQb6ktypmVpNm1ECy8AlsjD5VdKy0aCDEniU1zRfaalQIL?=
 =?us-ascii?Q?76lXqNDOQaHEQNGS3ki3k9iNEtHmT5KIjik+zh6eL1HwOoTdO8RWQjyHjL/d?=
 =?us-ascii?Q?7ubfoih2PWG+HBsHhGVgJFa5rDJmdX0QXL10ZbBy6qpjAUSEtOnjliXtfH57?=
 =?us-ascii?Q?6rtqEsaLRg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95b7e32-7316-49b5-dd3c-08da13658183
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 22:26:31.3748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Znn0bg21OUDYdIlOcpP4amhEuUlKyzvLxp+NdoHzFTPWWJHob4NU121XsrbM1Ley
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2369
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On Thu, Mar 31, 2022 at 01:59:22PM -0700, Jacob Pan wrote:

> > +	handle->dev = dev;
> > +	handle->domain = domain;
> > +	handle->pasid = mm->pasid;

> why do we need to store pasid here? Conceptually, pasid is per sva domain
> not per bind. You can get it from handle->domain->sva_cookie.

That is a mistake - SVA needs to follow the general PASID design - the
domain does not encode the PASID, the PASID comes from the device
attachment only.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

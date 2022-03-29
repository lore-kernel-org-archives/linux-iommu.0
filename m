Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BDDC433EF
	for <iommu@archiver.kernel.org>; Tue, 29 Mar 2022 11:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9982F610DC;
	Tue, 29 Mar 2022 11:43:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MctQzeloclfi; Tue, 29 Mar 2022 11:43:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 63FD3610DB;
	Tue, 29 Mar 2022 11:43:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35010C002C;
	Tue, 29 Mar 2022 11:43:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF3A2C0012
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 11:43:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6F98841E7
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 11:43:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ED_L4E_pXe1D for <iommu@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 11:43:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::617])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 275AE841D2
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 11:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0ARWzxBSA1THGcKEQ1gTzjd4qm4/dRdkzvxh3zuQ7IJdJXw3DsXFxzKtzysi1j2rnXh9wKrXk0J0YaX3TrQlyHhkFnC4sE/jvAGK7zGfSZk6NWW56LzpnEX2qrU7izQ8xTUWVUSunwFOKO3V66LTDwTPHhM2feAMl8wHWfkdPFK5Ba8qx+recWHibxpwRZR5JLXr6pX48wd5/kPI1WFUx5pmNx14dOo8omXIagsOEmtHbf7xeCbEfjVFbkw8kXDf+ECYaJDSQO7UD4lVh1r2G5z5JlKnXWYqtWmIvHVIn64t1kzvQd5m0uaTF6h5J5Oc6M1v04h/cUHfuOGUV/1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrOkMw1lfDi3tr3In10mkF2uTHRarQIpZmhNa7Kn8+8=;
 b=GyKwa6QdrI4+M/kjGHl2s6YPX6i7XR9ar+gpMztMOGf2g623F+LVO848ZKciT0Uz5tbfftRu+0WuFKOLFtSlZc5TfksXsn9eavgEsuM5gBSyYIaYqJoHi+nuCrGw5ZWcaDthnO3zk5chb3pAXkJATuopmriibB86TPakvyThnQJE7xlHW4PND3UOsTgMrl3XrOdY/9LnkBHxnTwKqurZ7CzvxBGvLxVM+eTvLEvbG/sICsCLBdoS7GJOZ1kjomYQ91591E2Wm4Dtrzf+gcqgZJAsYcO122qXDLoecB26u03bj30lrcCDlJuEd9HpPhU9ZOBIYQ8efXDzj1Zg6vTC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrOkMw1lfDi3tr3In10mkF2uTHRarQIpZmhNa7Kn8+8=;
 b=nigXbR2tzEaAQWry/CsiScZvyHBYWN5fQkVdHjxSmE1v7MJ0jV0vh9g5L0Jy8pmt/8Ojt/HCFnRiVULm7ZNtcFB2z4A+ws00hVS1bqDEre3MZEw9RgjGCdRzfV0kxds0aoX4AxpL+cYrG98xznD4KW541IbQQrKuvfn9VYtkaQMDyLueK8P06c09ewO+fiB4WBs0MX3IqJdAToX9XfmjJAR+pg9X+FQB2wvyHw8OPe7VFFXwzZxBUNepkzLPFSSp9/yL5Piy8O9SW1AAmSQh9B7dWJkajdkauS+e2LkhQwo5xQW83A1FyrBoYuKXG7O1E4t5eAEOuOB2j0I6UFEjDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB2584.namprd12.prod.outlook.com (2603:10b6:4:b0::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Tue, 29 Mar
 2022 11:43:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 11:43:01 +0000
Date: Tue, 29 Mar 2022 08:42:59 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Message-ID: <20220329114259.GB1716663@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR19CA0062.namprd19.prod.outlook.com
 (2603:10b6:208:19b::39) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 459df7e9-c581-4d6d-c860-08da11794713
X-MS-TrafficTypeDiagnostic: DM5PR12MB2584:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB25841B4432AD18ABD71ED530C21E9@DM5PR12MB2584.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yZg/tiVJGAaiBMEE3y07J0cDWqIgeZG0csJ8qdioRHmjKPs4b6XOpygSPXkMLsMasFcymBEQHg/6PUUraWtkXw8GHWKs/j6BI63kCEIkQo1sY6Cwr9z9EF0N0J4/q8BcbKDYglTjcw141ge6KPeUveZMMgn9xbr2HmzjUEa9mQuGkUNv1kPuvBFnp64+8f7UG62SO3hImEHmMao/0jAjhYAsq6l50uQSLQmzFhK+3TMTbvfPTHyndW9JUU2DBPt/vRBHAQWCkT/2FjtLIaycgPAXS04IjeGK3zQws3ivuSIHcFNm/c6FPQycaLB6iClyDjh5JYxEX1sGzvWmPI/KoRhsUN481tjtZXGtn0FwG5cjaF/pt9euONb3+u0gLFExSFpkt/B41WYirgHpblNB5a5dvdItQqC73PLnbUDCpjGWIkgMuopoy6mYqmnVSs233At5miFKCVuJlGl5gcc9X2/rEVUYMl/NvFJ/JjDZFqPxye7nl39MA8kqSPPERza55z4zQS4O9+UKXasuwq5DMLnvEcO5sqU27W+r+wo0usNw/tx6J+Zdo1yrRMqFBaNL4Hg9vWZjxp+cVDY6oTeG4ojtWXh2yNVbQpUZACk8NhZkuVLO8s6OouAb5mOtVRYox+XCAf+Tkk7MaCbbH5h/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(33656002)(66556008)(4326008)(8676002)(1076003)(2616005)(186003)(26005)(36756003)(66476007)(38100700002)(66946007)(7416002)(6486002)(8936002)(508600001)(6916009)(316002)(5660300002)(6512007)(6506007)(54906003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?epM1y4+rq/aTRIUyjTwbzTOh7+bxOsqPT4CvUFiLuh8wsM2bno6qPd5ekDT7?=
 =?us-ascii?Q?+bT3mp7mdoo9H4N2fPSmRNfeLgjRnnEztn/+Ph025xXv6QU/hds8qdH1EcQV?=
 =?us-ascii?Q?WHZHnwlMOnyCAR/iaTGJe9CnY6frymhj1TMP7E+k9V0igS2a3aV3dK7HhdZ5?=
 =?us-ascii?Q?T6PPwD1gRBvnElivtxrG+0PoDfIdVPgivWecrb3oFkcmWVHTO6KbsZ2Q74NH?=
 =?us-ascii?Q?1NJiQczKKIcY2yWu2RV2nlmpwPyyT8YEpFi1hitJs4M6oH/LQCwlB7j0qetP?=
 =?us-ascii?Q?VNYVsc94rTDzrS+gUTWDJUF/EBuMzRWbJqR2Zc7TTKArDg5fhd4qjBatQpw6?=
 =?us-ascii?Q?wax06KTy2CWKBC4b2Vl1PVR5pDGIZlBMFuu8/ghE8ZP+T+FNXa9sfmoqJS8E?=
 =?us-ascii?Q?bwaoSYpNdE+NNXKxWe2XlnARkpim5tPm+Mtm2LHtMY2o876As/iEr0pX/2XI?=
 =?us-ascii?Q?FTCgyKhoId1uB5AXEnFCo3e9x1fBUF4hxjlwTJRB69vZ12gUPcJ1JiEcihwH?=
 =?us-ascii?Q?cD2QghdmBDzrO66BSfY9tXiP0+wc97xbuwtEeg/moBb/Bo1Z4cFFbdD78Zgf?=
 =?us-ascii?Q?90V6WPnC4QS/IDkxHcVwwvtgOtSkgWnG8JBLs/Z8t/uggoewfmOur6/KC4ky?=
 =?us-ascii?Q?eb4i0/P4OObRZiPNuPQIxnKcDKaX1KH0uXqFDHBszuEN3pPGbvN8GXzl6f0B?=
 =?us-ascii?Q?fFnAkGi7qU/nfn1FjdXx5YaMcmWmYKoXwqHZr3K5uGySOXaKF9dOpWoQ2XXg?=
 =?us-ascii?Q?YidnQNpPE1a40isnFnHGmSYOaFA49qnfD3cigk3XNzlHIS6nXoSVx/ueUXMZ?=
 =?us-ascii?Q?RCU56T4qX/5k7ySElYjOYmpIRoG5l4sAHseC86tgiMkMjmlhm4sTp7smQdUU?=
 =?us-ascii?Q?sHpR37UJBrxKhD2yQXbp9bCeUIX19487yiVamPrxd3HN38jRypVhpANX267l?=
 =?us-ascii?Q?kWtMUySi3+dq0tLRb3GTKD3vWrGUi6SKt8UNm2flnu8kHPHDIzSw+zdGi2Yo?=
 =?us-ascii?Q?e44vSM4g2Pohz4Otdt1ekC0om1gRHCsBbeXVwExE7MtHnsxvK/2eRq+LMlkh?=
 =?us-ascii?Q?OcxNB9/IYWGsNjobmYwTgLtFwLmKz6zMgh5x6pw26Wnj372mZOsNMem1850j?=
 =?us-ascii?Q?VXyltgGE6mzqKfeNt72+VMhS41XIC98QlRVo+HZxn5Ow1XtLmL8ou/2JKKna?=
 =?us-ascii?Q?KucEmfK8BAJPF4wbgXM6IcOH5bTsbEwI5/tnYBH0aNgo7YockhN+rEkr4vjR?=
 =?us-ascii?Q?PFBIqy6CSEQjwP4SouHoZkI45rgpOPT+VOM/N9iVGSgSAwYXnqPnvgSuQxuy?=
 =?us-ascii?Q?P3rr0K4/Hr71BPc8u08e8cibfRAPhkmy2AzNHMiJOFdxGn0ui9T1a+Qwoxwh?=
 =?us-ascii?Q?T4ujRrqVEnTN3kiE86+HLcXuKEO87OZSGFoVs5jDmd0nV/8SAk4+3NrB6JHE?=
 =?us-ascii?Q?j6XWQpXXEndd8lOIK+GiYs6df9Pt4evOkE2yYLRevq2IchIZzcL+XVFS7M1L?=
 =?us-ascii?Q?460dUA3IUwYytdHytCJ+pllF/YQwPlo11PhlK6lz2hKGOWvm4y2A6JALBOL7?=
 =?us-ascii?Q?cmrq0P0fETD6fY9szI6ktjkDkQdxWFVwI9Ys4W9rhC67gCYcY4akaUghQ2Ig?=
 =?us-ascii?Q?uJCK+0ELLH0XXE7V1fd1PEsjMOl7ZnysBDFcg809z8IFvdZrGsT912utoAlS?=
 =?us-ascii?Q?2Kr41y/U8hBAK1D0GPe9MlP8mJeV5Gk9gYKBRYsRm8xBhH48d7e1S7NPmClA?=
 =?us-ascii?Q?QOclUJ0Gsw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459df7e9-c581-4d6d-c860-08da11794713
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 11:43:01.2709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRMzGFqLyLs/BbiEPg0Gq1CZAoUHuhqGUzqE9ODBHAc0e9mUPvMOY5Tts22DflV7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2584
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

On Tue, Mar 29, 2022 at 08:42:13AM +0000, Tian, Kevin wrote:

> btw I'm not sure whether this is what SVA requires. IIRC the problem with
> SVA is because PASID TLP prefix is not counted in PCI packet routing thus
> a DMA target address with PASID might be treated as P2P if the address
> falls into the MMIO BAR of other devices in the group. This is why the
> original code needs to strictly apply SVA in a group containing a single
> device, instead of a group attached by a single driver, unless we want to
> reserve those MMIO ranges in CPU VA space.

I think it is not such a good idea to mix up group with this test

Here you want to say that all TLPs from the RID route to the host
bridge - ie ACS is on/etc. This is subtly different from a group with
a single device. Specifically it is an immutable property of the
fabric and doesn't change after hot plug events.

ie if we have a singleton group that doesn't have ACS and someone
hotplugs in another device on a bridge, then our SVA is completely
broken and we get data corruption.

Testing the group size is inherently the wrong test to make.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

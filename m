Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793190921;
	b=AzRXU9gQh2IbxGFz5e64K85Dlho3OVdplSM4o0IGszs9RJ4sapyxQZnWMyadZSCzB32J
	 8r0VcUXpLBrrL5460ae+6bh1dK0yZRK8Qh5Gh1I4S+P8Qx23AzWXcu0mux6MEUTSu9RjP
	 +E5y63ESQaP2gpd9mgZVcTBFr6VTHLh3/Ub/FOg7GfPEghMQJlqXDCF31Ib3BpXWBqiiz
	 rwyy7AFQ4yi6XTG2JrgIvaRoCz/Rivny+62H+KUv24lmGmTcdBkMSoERl9k/JV6YiznJe
	 W/8yeUsYR4DoJ+NFZwXwlIhQ3DbK2aZjr3cdWIAqOWqTDSufFhC++814JrP8gaOmF+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190921;
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
	bh=gF1gjXOXwA5QkQ9j2yrnXrGuWXOCLEOMQYSLwgL6Sn4=;
	b=PwIy4Y9Is9FmykiMwraZj6eNapQyWFR7+XEQY3z9gd2pXKqecDEQcRF6MvoAu61FeDD1
	 tudvyYlTpv+6zOEqMHvRWRWKyVLxdZchlyuBBNQyqlbwR3DkuiPvQJmX4HzTCUXEL63av
	 76h2YUsJpe1VbwQ0+PwGrrUjD6q10GdTiTWUIQPcvVAA1KJzGpUlGA8+3SvngCUF/t/7p
	 N95iL4Y350509/c1rQnKvwIbSJH+hAchd+8Qns/g7N46e1f/+lmRuLlIyX3lHffsMCEZZ
	 Q1YgX2eBb2oh61o4CyFVJzmV5V+S2Nz7hFmZ6Z1DziPGy4pV+wS2PRaOHnOJNe9ZLRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dOvgg1N+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.60
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0982606A32A;
	Wed, 28 Oct 2026 12:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0982606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dOvgg1N+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AE1dDuhxuqTiFG92X6biTUPJXTgtcTmN5ExRf2jAWEyqZcqCzU1pDyY/Msh1JZVv5DWyFnAs8ci6IzeF6sZpGBc0Ar0yXVbn9monR50OFKHLWO5MVnwyJc7DwB4U0342Q+ssWcLxU2fX2f0rSt4Nf1vQqYTfE/45b0Xb29npua2tfXvsitpJKkit1yddZAogJqnwZMGNA5arvDOoBBa3RQXKAIdIibQf8fSOO6qcM+7J3rVcvMQY6kYSkvJuS5q5hkGNtN8x69SBsiu3qtz+HUY4SCT+vrTTEQsVuXBS4z49fFOkbDY/H2aWkoBlpoYyRuyxsELhbCpa+vT/Czm5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gF1gjXOXwA5QkQ9j2yrnXrGuWXOCLEOMQYSLwgL6Sn4=;
 b=SP0ADaTHADbOJ1cz4+5MBPuH6Gu7HSIrZ6Nr2dCIHQ0Up8UHpsgDG73jmSgxj1lyRBi1HMnbUrti4IyoVmlxqSN/tCKyZ97oMF4T4lLmlGWk28ggHtoyNmVyOu1aCUwp/XckZlhIHz6pmblqPgexjCugWi1SunbTz1eA3I5ZdvaADPQCmoxaKTIPguLLdNAIqv60chKDficYDIu7jC1AG1aZr7RZEiVJkmlOMYUoC6IG4blAJyOxd3usWrxySolDvQXeYP9D6mNKsVXb1eHRo5hluwFv0FuCbqkuSrrPqyPi6ebz+OKVqjptADMKuOiudeKo/FUrBe3369ifA9lizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF1gjXOXwA5QkQ9j2yrnXrGuWXOCLEOMQYSLwgL6Sn4=;
 b=dOvgg1N+I2qyYdr07aUxyNEuDx3NbQbPZQs9ZbBZQZdz0Q6Sot2omoZF+C7YfRbvMDMHhtxEDuMWsF++oMx8Ghn3uM25PDUFIlWrlWs+lALRqGzkYck484dVYCzvY1pqXlVK0+JpFcvR6OKbQQ/hrW7GfoorG2NAIQ9By1inXAZjeoTiVSvcnf4bk2Tprhng1lhy8sVxhzZcrS2goXHRUvNkBp1XJaktjJNwmivBcI4Fj1viLIMkI/52XbJXYwXK/TyIeegL75ZVonGQTpCNgC/cJoBI8FGhMLvr+m18/KwikqatVr37Ek2qxVR7vp7ba8N/crtmMtOdGCBHGyHi2A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH7PR12MB5806.namprd12.prod.outlook.com
 (2603:10b6:510:1d2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 12:35:12 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 12:35:11 +0000
Date: Wed, 28 Oct 2026 09:35:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Gavin Shan <gshan@redhat.com>, Vikram Sethi <vsethi@nvidia.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	"rppt@kernel.org" <rppt@kernel.org>, Thomas Huth <thuth@redhat.com>,
	Marc Zyngier <maz@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	"kas@kernel.org" <kas@kernel.org>,
	Kohei Enju <enju.kohei@fujitsu.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Ard Biesheuvel <ardb@kernel.org>, James Morse <james.morse@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Omar Sandoval <osandov@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Sam Edwards <cfsworks@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Pranjal Shrivastava <praan@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"driver-core@lists.linux.dev" <driver-core@lists.linux.dev>,
	Sonang Patel <sonangp@nvidia.com>,
	Ankit Agrawal <ankita@nvidia.com>
Subject: Re: [PATCH v1 2/8] firmware: arm_rmm: Add VSMMU commands and fields
Message-ID: <20261028123509.GA2541714@nvidia.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
 <0623345baaf550da1339e040b59f1fda902e3390.1789010941.git.nicolinc@nvidia.com>
 <SJ0PR12MB861491CC7A4C567D01F9B951AB6F2@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR12MB861491CC7A4C567D01F9B951AB6F2@SJ0PR12MB8614.namprd12.prod.outlook.com>
X-ClientProxiedBy: DS7PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:8:2a::26) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7dba6b-7620-4926-2dc6-08df34efe8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|261021121427099003|261009223027099003|10067099003|56012099006|6133799003|18002099003|22082099003|3023799007|261026121527099003|11063799006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info:
	StuKpUwxIgDZWweUgBHfTjMUoLzUXUrmkrwv6rjkjYiLAQvQRCT14eN5FrGl6BhZxJCOBxpzotCwiQSHVBGji3QaqOBP38Up1YU20HqTwavK1A8gTMZRB/9F7GaD81K7Vcc+6uzgkq3HtJwKKTw0Bm0PuA9rjeKVBVSXZ7hzG2T9HsnNNSYq2Tnb0JtNA67mpOLBGc+hFeO9Cgw3uh5h9y+Zlj1YG6GTUXU0d2dDTlcQYRkvbnKxDsMNTXiEU0ynlL7euKzoZdevUfoQe+PGpNG+JafyfEMl5vf5H0AAucpbEjJZTSxNVq6WO+ZzATxK1aa2a7nYU4SRO4RaXW+EAaUBiNPIF6HUZsrQyKFglQ60sm7RhlAiizZ23ZjEwowZ+2zKT/lwsI/cYaJvlCkEo6vLIYVJM4ZxcA2jDGDqx4svwb8/nTZqiZT6G+BE9mivA5XB4BuLim0L+eNaD+nzQzBPsXp2Nkko1wMb/epBKeaGZFxwYcTIrD+/Su+BgMquYTuaxltF6dqs/vcp43nKSXzcPCxLu9Jj6Q4v4PbzaSf128sbDU1/p8Ww8IL+ZE9H/wqai9nYM4cCmrlXj7qHq6hLg5gMtKh/cNCwxyCc2kN2ZTsL9z3jRrUsQkS3YN0fFTy8OAhE1iKU596TuBoUjMf/+IafX9hLtwSJnbKHabw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261021121427099003)(261009223027099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007)(261026121527099003)(11063799006)(4143699003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O7rkD/nI5JSdjB4rnimYSHiuaR2JWL58tLdjRYlwXhmBOXmEmN1CJmyUzBBJ?=
 =?us-ascii?Q?+VIsp/TqB0AW0aw83Tu7DN4tqtwAm+lGJ87cDBPyY53F0Hp7EGhOX+GccgDe?=
 =?us-ascii?Q?56MgCcSZewZRVmF6wLnwljGpsvLTvDNHru9Y51KbIiuMFsatzCBRTLGYDOlv?=
 =?us-ascii?Q?ihh8PmXsTOwFV0v1Um6GO2CrMMmgk5zi8VLLYQGjWSNgJzw+UEmBkTxbOEeq?=
 =?us-ascii?Q?Ik/AU7xflccqtCiLiAXSYzTG2BRc5Xnk8JQIuAO6Px6e9mDFad9C1xfDupdf?=
 =?us-ascii?Q?MYIcQ0IFdC6MRMHvm4sQQ5r1eDMfIiCxkgdP/sWGmOmwthbGDJfEnWPoKHn1?=
 =?us-ascii?Q?A+/ZUpbe+69bwKvn9iKngt5VTynRJehpeDgPJrYInnQ/y302NlkxgQ5BQ6aa?=
 =?us-ascii?Q?sAUR0sgpvdAD3gkGRxrI8zaKYFOawuQtkZUI5VGuxBHXfbliripZExyLy4NN?=
 =?us-ascii?Q?J/m7a5JF3S+BTxsFzotN9hOP4S4CQ6UcE+8kUuxKoz0rBVOBs3ATvc+xzi8Q?=
 =?us-ascii?Q?ujufVs9JhQA64ePIM7ozVeroiM4bzvvppVml2uiTTnVPaxx67macmsOW2wf7?=
 =?us-ascii?Q?wxlJ9yy7MS5t05h1tWma3vKfMlpH/wqp8z1zvXhrgMVc6l4ma0wVyNrzCr+x?=
 =?us-ascii?Q?G56QtDu4gnpuk0LllIT6bZrrYLvUcvwpwO7JzXAagt3Ksqm0MhQMBJpfEN4l?=
 =?us-ascii?Q?boxu9ppLuvBNcmRFah8TzZKAZcqJ1aVjr87bd97po/gH6ANEjpLQfb7DlMOy?=
 =?us-ascii?Q?eZQn9TMlLtqplN92O/DZQRZZTAGfeVcoKU0fuoDHhbVPVFRo8R1GGeX0eziM?=
 =?us-ascii?Q?8jCIkBbfU3NZqxQEVX6JbXhP4nWp7rs3ZICK886tEEUAvzcqBGiHB4uXJGLW?=
 =?us-ascii?Q?IT+5PuVmyTnkYhkIVZ9+fHFJK75SW25Kgai4GXBIAYRvSLlWTWJfbjbnriuV?=
 =?us-ascii?Q?GvTIcWRZEjCULOnFAh8EwdNCokD/SlwP1Y75RX0B4V6iriEvDnXZnVv6CcG+?=
 =?us-ascii?Q?+CJYRXCb59TX3adRIn5EP6YKjesFzEP5cJtRD8n4/vYbLGVfSQl+eEuDE7HC?=
 =?us-ascii?Q?gd4m1fFeS4iqjHgWZiaSR4aKBoc1stgf5JvVO4JPxaqSfwayiTf1bErLN4lD?=
 =?us-ascii?Q?01MXYATjts95e+bPoa86HHbyCJKBYxtWnbkd6QCLd7qswDOf7VM88OFsyc5n?=
 =?us-ascii?Q?1oV78yR2p1/ee2TqFSngJNPE1XWjy6LddkzmtwEIUZLGX5zTTgYFt0R0v/F1?=
 =?us-ascii?Q?JhqojgPBxDDSpa1GPeqGfALmfjwuQHGVhSLLaCxloise1EZkiWRwCu591CXc?=
 =?us-ascii?Q?0nZA0lARObXexSkTAUHtr5YVuUGGBtjPdHOQ8dgoyvDaZwn7U+Mpvs8wn2+k?=
 =?us-ascii?Q?bkJji1jFST0L50BzFrjMNZzHtHxtFGELYgRWxkbNHDjvoKoW8gup+S6ZILEn?=
 =?us-ascii?Q?RXxLB7V5pB8r/N9arc9yKcF9zntvIF8Vo9fEVl0OdsrmY/hPJgDT75yPkwRu?=
 =?us-ascii?Q?2Q84mNDBwn3/UYK1F57fF38VBBwos7FmvrA3MPh3XFMtkv71XM1/8QWbKCdi?=
 =?us-ascii?Q?R0v//BbtPtHd63EN12ma08p+oY+RCDGPrEllxFwI3BAqPzDFhR26/65UHGol?=
 =?us-ascii?Q?suIHzSDY6baT34Q00r8+xMPjqXtenmAVxIK7yajvc3b1Y9EVSu6TYq3TIjXm?=
 =?us-ascii?Q?vSldb0ycFOUIdkt4MjAKof0r3xzgPl17F1AvDbLd8dta0AX4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7dba6b-7620-4926-2dc6-08df34efe8a1
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 12:35:11.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7lbMWUY/XFMZCzLcm914RgljMouisQs0wSTF3ZOCS57SMLzD9d4wqPdK5tEyZV4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806

On Wed, Oct 28, 2026 at 09:49:53AM +0000, Shameer Kolothum Thodi wrote:
> > +static inline unsigned long rsi_arch_dev_activate(phys_addr_t base,
> > +						  unsigned long dev_type)
> > +{
> > +	struct arm_smccc_res res;
> > +
> > +	arm_smccc_1_1_invoke(SMC_RSI_ARCH_DEV_ACTIVATE, base,
> > dev_type, &res);
> 
> These calls leave unused input registers unspecified, whereas
> DEN0137 bet3 B1.2 marks them SBZ. Could we explicitly zero them?
> 
> "On calling an RMI or RSI command, any of X1- X16 which are not
>  specified as input values in the command definition SBZ"

That seems too broad, Linux doesn't even support the x8-x16 inputs in
the macros. I think the spec has errd here.

Requiring zeroing of x0-x7 is sort of reasonable. Any future use of
x8-x16 (including outputs) should require a direct opt in of the OS to
indicate it supports this bank of registers.

Otherwise you probably need a new macro helper for this protocol..

Jason

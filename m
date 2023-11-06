Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC13200A5
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FjRdIL4x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy24n5h+mOvnZB8R5Hi8Tb3/+b91HK3QjJdx6SZ9YCELOjrmNBQqu/VIlmTDDzJ10dFyNps1c0vzRnHxkdNOAhBwxRxv3RTc3eUwe18no9HwzPjzCyvTE7psMQ8dhUO9usGLrhe6kU1Q0sK7XrAbFDqcdZuBPqsfEoNLgyInoECN5hbUjPj439iixbjP++QeXYQMnUG1JXdkYt/XUk5abiNbBTf1yI1P/Jz+lsplSGZK+JZfUup6FT6fz4EysboJvzUGi6ZcEzEiCPP4OoDJHJBBg1+0tk/fXDw0Ja/Sebw3ytbln1BYd61j9dizRVwaXplHgj2qcZRNc/wVmP+YLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uChlgny/10MkaUjfanUmc2RFhyTtfdyCnV785rbolCU=;
 b=eTZ11862W1zVR5mTP29KBp5zPd0wDxxaoU4OVNvmUllbQuarF2cPpGhDZstWl7AuPJTgTuUF31//9tSwHpO5HCaG8VwdS/0Ef68DoRpGJmC6ThBzQONEKaD3mBHgMhxdrlXb8rvQo+l0jUmI/oOfLW8uho/ZLdAKV+xvdo5GEiN8zzSa+7ST2taJdzLep83iNNvrzJDyQ5VVSKoTD0YUslNDjP2wNhyvrwjzGQcKta5JDgYKUiNK1L2d8Fd5mIRyn8Cp4e7XtKBcY5hQM4E6TMeAV1usI3ZWmwGQVxJ4qYCV0HS0IWp9GoENrNLt7OhUUkBRUEMIAYV7JJdmhUOmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uChlgny/10MkaUjfanUmc2RFhyTtfdyCnV785rbolCU=;
 b=FjRdIL4xBJBxfIb6KZ37mrV13/bFG8IkjVtvgjrIvfHoZTnYjiMsQzJrF3DMThYqE7yn19XzzMWCKtNLIoIfXzgjv/B/s1kkSla+7xRCcZC0kjeLk4dY5oXO6olPbTRIveSoqhQNNaA13Aq81rZIAPm0TtneG37caL9sXqeEGPdQu6Ok/ALCpXro+wowZ9fgwffOPdAr2/7MxZvNdJ9KYYt5kvTuhv/p15JHkanw6UYwktTkX2jN9wfPrs+5Fo7ewDhRIHuAuqngB8Gg0XyrYJMxxxEmIc/OEtmIkmYY/3AQglvV6Wlvq5RR70Xj5hJVypsS90y06yOJLyYqTZ53BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 12:26:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 12:26:47 +0000
Date: Mon, 6 Nov 2023 08:26:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 16/27] iommu/arm-smmu-v3: Keep track of valid CD
 entries in the cd_table
Message-ID: <20231106122646.GD4488@nvidia.com>
References: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
 <16-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
 <CAKHBV27wTOqkbfY0D+GNiE-aJyJzP6MS6pa23Bqk_tVU37DK2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV27wTOqkbfY0D+GNiE-aJyJzP6MS6pa23Bqk_tVU37DK2A@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0334.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: 514b5c42-aa80-4f97-dc78-08dbdec3a510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fvI54UsvLKAuvX8TCe5LAftqooC2amx+yKVgNzejwIG4SAlaJSD4qAOhAqZS2e+iuQNMG+ORReZgsfDSkR1+PsADAbPqfF+ll8mR1+9VmTikTTG8JF6QVXtgiciHQgGPxmWL8IzX/6IXFMCgx8YL6Of7SS3oaUq0ICCZyaB6DUZPrpjLafFl4rjwlAhEvut7z7ggyFxhM1RoU4pQqwmduVOBAb8FuPOdZ56dLTeOcO8MKZn8e7RsH/n0Lxxs1IL7dO23EB99fiPuwj49lmcloIhEaSzMpdgXM0D8sYA/amANQ1dCbBzS0epsuF3mVIyYvYC9QsLbqG2s25zP1Gzk1gsU0qQs+JQwY81Qcf5A6FA6zlmkP26WeCeTuO1DLWTozM7gsXXkTH0oIGfH93Fyiy+FvVAp6TeJDZg7Two8iBLDiTVtAcntYX46E+XuGo/MMpR2NjrRX0NFOZypV7GOEXVCwdMtpNT8fp4Uc/w1PMq+WMO8jIzOMEIQVHWcb6yDqW//b2tXGs7p20wRCQC804njPmCT5wAgQnzBZzzEKK9lC8g7vLFAe9pnbhECMRA5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2616005)(6506007)(53546011)(6512007)(107886003)(26005)(1076003)(6486002)(478600001)(38100700002)(8676002)(66476007)(8936002)(54906003)(316002)(66946007)(6916009)(66556008)(4326008)(5660300002)(86362001)(2906002)(4744005)(41300700001)(36756003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVBUdlh3TDdaVldMRTFEbkNnUVpBWlp5NjBvZjRYa2VIWFBsWnhidWxyaEh4?=
 =?utf-8?B?NzNrUGxxcjU5c01YYVZTMkYyL2JCTjgwdUxOYmw2M09lUjh5SHJMVkorZzR3?=
 =?utf-8?B?dU51ZFVSWjJ6NnJySGUzYlREOC94Q2ttSHJVRVFkb0sxV0VFaklIMDJmdjZC?=
 =?utf-8?B?SU4xc0tFZDFOTUdFNDZsZnBkMmRMNWMzSkV4LzA4VDFjbnR0NkFGeWFJZGtq?=
 =?utf-8?B?NUhlOTZ5cS9aUXR6dVFPWjczZFhnY0MrM1JVaHZVQVRzaGNGRmZibEg5ODJj?=
 =?utf-8?B?QVF1cXhRamw5SW81S3l5UmlBcy83MWl0VVJtQ0lad0RxbkhWOURxeTlneUZY?=
 =?utf-8?B?RWJNalc0eDNmWmNGS0kvL3ZoMDFRVW1SUEkrTG02eWh1Y05VcFAyZFFHdmg3?=
 =?utf-8?B?SktSanpvNloyUGwxUlRWS0JsSytMNmVJcDVrZjBSMEo3dzhBczdjUE1aeXQ1?=
 =?utf-8?B?aFRCVlRJd2IyMitXQjdGU2c0MHQzUVdKemxzWFZISld6RXdGSFlDYmI5ZXlh?=
 =?utf-8?B?UjRWQ1Bxa09Oc2pFVWZFaWpQaHpBVFRtdlhCTXQzUVhRaTNSRlBKNHkzTUpS?=
 =?utf-8?B?MG5HNGVOdDRURkg3RnVPcHJSbjVmYkhLWExpRzhLRjIwY3RjcTZTVkVFcWda?=
 =?utf-8?B?My90SDZTZ3haRW9FQStXSm85Y1prcWl0QUNCM0ovYXFiejJtZmtmY0V4VS9R?=
 =?utf-8?B?MDFyZEVpT3NTWmN6YlRGWnlLQTd5TTFqMGZDMGNsdE9EeS9TempSYmlJSkds?=
 =?utf-8?B?cUtDTHlDVU9KVm44dEU3bXJXUGdiaDUxRUpTV3dueGVNL25kMGxwZ3pvQ2NE?=
 =?utf-8?B?ZVhWeUdaTFI2TE9lbVloOU9MNHMxeEZVZ0F2dGErbmlZUnpQWDFEekNKRHhC?=
 =?utf-8?B?M3NvK2RHTElWUnFzMFBYUE1VMldqTVNTTFRKRDZRcmQxcnU0eC9ybnhOeHNL?=
 =?utf-8?B?SnhBVEJvMmpPQ3BTa3ROdkovVlVuYnV4VHE1MjVDcCtsOHN6Wmx5dU1Rdm9C?=
 =?utf-8?B?VlBXMnk3VXNxL0lMYjc5S0t2bHNkRmZRN1g1dC9ibVR2RHRGbUxsTmxPYzU2?=
 =?utf-8?B?aEp3Vi9iTW5iaEVLa1FrbVlaVUhpVkprRFcrNGNSR0xXcEpRU1d2V05YZU41?=
 =?utf-8?B?VG9odkFMdURobHVJVUVvTFZUcStCdjk2OGthdFVuYk0zOGVZMXZyb2l0V1Uv?=
 =?utf-8?B?dlZnVk9WYzc5MWVHZ0JoMXUxNkhqdTVWUEttQ0dielVSZmdaVkhscTkxZmdQ?=
 =?utf-8?B?YmlLUmtsc3FVazQrZ2M3YlBFWEpWWXRwK0F3ZHFFOFNZTTF6bk81dXZ6ejBm?=
 =?utf-8?B?MjlWVStRNEV6ZCt4UzhQdmRUdXplS29TUjFhaXRyTncrMjQ1WHlGV05CWmZj?=
 =?utf-8?B?UjJpRlRNTmNIRWZJeVR4czRwTTRsNjV4bWRabmRleGpDZVhub29COEtPbWxm?=
 =?utf-8?B?UjFEa2d2MGk2SmVSa3NRTnBpY0QwSC8yNUVLUXVyUkFpcmdlRFhibVdCSkVz?=
 =?utf-8?B?enRwWmpRN2c5QUo3b0ljZSt0NDBqd0UwMndBcTd0bFJsbGJGdVdKeHNNZSsv?=
 =?utf-8?B?eW1pTVB3RHFYVnl4SEVVVXQ0VjhzclduRzhIa0lLUDNSd1pvQm1xV09FSUJ5?=
 =?utf-8?B?N3pMNUlrQ25INmRHVEU0YnVuZzl6YVlCUUExL01QSkJPaDdKaTh4ekRwYjFx?=
 =?utf-8?B?R1JBaGNrQzdQdDRtRTdYNXUwR25kSUd2RVA0NnhjYjNCT0V4czVLdUNXQmov?=
 =?utf-8?B?US9LdDk1eG43Slp2ZG9NMW5PMlhSN0ZFMy9HZkJ4ZzcvZVRrWHIyUnFlNnJv?=
 =?utf-8?B?NmJzbjdSYitzQzlNNWtFNGNvY2FYM0UrWmNwYlExQ1U1Z1NlaFdZRU5pZlJT?=
 =?utf-8?B?T1dNamlOSmU1QWcyV1pCbTBBKy8yL0dHTmpGYVI5dU93OGZTcGRLdW9RRS9z?=
 =?utf-8?B?NnY5Q1VaR3M3WVJBU1VVWjU1b3dzKzdiNXY1c2hEakJUSkRUcC9TUDF0OUx0?=
 =?utf-8?B?ZmF6OVVTZGR1S0ZEdEE3MHIzbU5IZEFHTERjbC9zWTBTOU43eGpmMDVvZWlu?=
 =?utf-8?B?NytzbjQ2NFlTUGI3SFBkb3c1dnc2L3F1UzAxMXRrY01mOHlHWDk0VlUvQnFs?=
 =?utf-8?Q?MsWYVzB37CC1yJpx07vqsjk0c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514b5c42-aa80-4f97-dc78-08dbdec3a510
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 12:26:47.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdetmzaoRk/yTGxEUrxDscEmhiCJYOh7gG+XemSTIGHigkbPDYNOZ9IAk4Xjx0ZX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464

On Mon, Nov 06, 2023 at 05:02:59PM +0800, Michael Shavit wrote:
> On Thu, Nov 2, 2023 at 7:37 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > We no longer need a master->sva_enable to control what attaches are
> > allowed.
> 
> Doesn't it also guard against attaching a domain before
> arm_smmu_master_sva_enable_iopf is called? Is the idea here to allow
> attaching SVA domains independently of whether it will be functional
> or not?

Yes, at this point. Lu has a series that will let us remove
arm_smmu_master_sva_enable_iopf() and put it in domain attach where it
belongs.

Jason

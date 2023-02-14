Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D90F15B2
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 16:32:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmlDUhfTrLxKKVHMTJqnKQE3PKrQKEUhOmkp+V8UCu95EPZTa+FfUUpY62iixeyOsfNwRZiAKUpLUYrq+6t+XhoCzlpUpiSIsU0nu2Rlz/vOwr3ecJLQMuG6oY+Xgu/O7+ix03gLoGzB0kvuESQWyS4LvV8N8n3F7DjNVvr+XwuHaGQhWd3wBk8XVZ5F6zLdNoy5LXzd3IsYEwMuIcjvcIfXr7ZAZen1MHoM1aaiLA1ykoF1ROzZ2H3zpR1/4zo9uBBSD5ubxjZkdJLa4ks/2P/7c315zedKQ+hblEkyztbtwjBpsVwZGf1i70JLXyevRm1PT5dgcbo4ynj1u2iOrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3wtLr8DAYa3yIZAzwEZIg00WbllN4/9aRbUp4ZyVdA=;
 b=W53AdpWWZl5T+Seo8O3ZzcRBHoTEoM6181hGblO08GPqBb61GnSqQTjlp7D0GifjqReb4Hf/F4dcQGUl6XZ/NvmGNCToUW2ljyVKtNVYnnZeG4CJrJokYCLkzHSbiXWsuws6U1EXhLK1kmzjfzI/fyh0etRg7e2xRDbYNCTmkaSyfi93EDYIlSIBcC8j17mD/3OD8r6Nvx7UrATJDkphIhCirncMWoyX7bQVGgkoyur23g62y7Ig4uXJqrXolkuDub/zx5WUEle5jvLLoqMywakjIg6MmsrHm3H92tsK7MXLdU0gjqSrZb16B53MewMXK7E5Z7iaxWkQ7aejpIJm9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3wtLr8DAYa3yIZAzwEZIg00WbllN4/9aRbUp4ZyVdA=;
 b=TZnc5NC3m+kOftjZoJX4RLKYTDMPRJMB0VT0CnSbYkls4zJ4dSqvUd48tEQt8HkTqdThFvUSmEIkPLiwD4Y4p7sJibTXmkaKeEeGV4cX4ehS1yV08a3msXkdW0JQO+vs9y2HQ/RgqGH7CDRoA43el0i0ySTrVqhtyhOAd9fbXr0V5Ky6Luip8I8kYxge2sJWOwCP3eY8eGnkaPKpf6TVfAIymKHZxAqEwg52xuoUMbg5pcFNAbjAgyDogHi732iQ2l3fZPA4K2VGfOofAZZkhPrDDbet2Bj0SW1H2We7sU1pd9nzW3UqVR/9Ssf69etgo/4KwpRoLd4Fyx7b9QO5ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 14 Feb 2023 16:32:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 16:32:48 +0000
Date: Tue, 14 Feb 2023 12:32:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"Yang, Lixiao" <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 4/4] iommufd: Simplify the lifecycle of a hwpt
Message-ID: <Y+u3ru5HgyNGZdPQ@nvidia.com>
References: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
 <4-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
 <BN9PR11MB5276D5B247C1F93A5FEB46838CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D5B247C1F93A5FEB46838CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0156.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c2c393e-dd08-4a12-f85a-08db0ea91b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YGRIZzgi0KylqkXxd9k8Tvads71rRd+8oB9MSHyfmWASOqBQjuU/aWiK4WpqtNf63pcbVuB7MSf5pNSScsmGUxVONNnYyeZOIoSG9f9TuIufB1A31hR6C7wZAptlwXr48Ase0tqCLrG0YkFYX5iN9BKh0sqdi1TQD2f7vpiIS71SZNbgTU24+QfzYl62V5msfL5VEUIvWssLqm7mp2l48StWyihXN4+W4LQBVe5jd1qemAfQ13wkRnjvn65K/t2gy6Jk/nWb4tpA1ZEDrN/8NVld402VxbaDS2K6moLwFXDEbtVhPaysgG6ipVeu5e3ZfO9W5cVlq8YqocN0fqlIxCTuspFANGiWc5bIsYWvgq1xOClnERM3y7IzcDrq6W5s9jXPHT5+CaeZJktJ7p+5uRfeAEUBwmaHsuNYDCrd8MqH/2/LfsuvTeLTWMih+FNPCUsRW+V+jWbJ4N8xhhssYtYTJvdaO2ohVpTMhOGZkMGLXVbOSP333eiapG1DA3snoTMtko3LcP5lHV2BAXGqjmfZhGxgbsQ7F8usV2ORARwZLWOthZVshnEk9xFcWAWmTFgRlvuTWckuVgX/tO2lllCmLE8+J5NklhN0h3GSiRMGu5xfv5C0xRtzFpAhJ8QizuCvq1/FGVoNuaSV21DL7Mqy/epKUfTrr/VCq0k3BfvTA91VKWUE7KBzTwqFgvLa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199018)(36756003)(41300700001)(54906003)(8676002)(316002)(6916009)(66476007)(4326008)(66946007)(66556008)(86362001)(38100700002)(6512007)(6506007)(26005)(478600001)(2616005)(8936002)(2906002)(186003)(5660300002)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l+598HIjNY/muwUMzew7fM1byCCEYJxWgbhasyjjMc6qOphf3TnvjFCULL8m?=
 =?us-ascii?Q?Mnuzv6yyYRY6s/L/Dp3+Nihi1hHjEdWmKsa2ALo6ySLwCcWTwfMrmo5hYXzd?=
 =?us-ascii?Q?g/t0FxxbRVMKFxz/FkmVbaFquG3eyK4KEyr8GJj0x1WjGNQlm2S4Na8UQPJe?=
 =?us-ascii?Q?BVFd5W8aUtEKVczbag73UlGFW8Hgxgp2/d+59XWKW/cGRh3Tsa7KB7HCM3Lb?=
 =?us-ascii?Q?4I6NzGczVhss/CTwpf7M475o5S8RhO6s9eyr4IvwVi8EKbEvDfxDJCF1ALpD?=
 =?us-ascii?Q?Bap4XH5Zn+WKCs5uRnJb6Np23t7EzgEfX1JVIvANJvGBPoRHXskUO4MUyWOU?=
 =?us-ascii?Q?O8Fa92w0rTXmP64Dc7Me6KCD51OWdcF0MXs62ctY16HzbVjOEYaDtGIaVHKg?=
 =?us-ascii?Q?NlSer49tQ28M1ylV+jEFzDoMq4aGTgihznhepmLcaGjhbWWnjb0wFWo5Jd0h?=
 =?us-ascii?Q?pstdZoHXKeJNUleHDbJGUGtLMzunqpCXJuALawsPAdALPdbOzoCz9u9/8p1m?=
 =?us-ascii?Q?c8QEwpN6PmIBywtzclZrRtUvCYNh7yatnA9q/TzBhImIk2EYzpse4bmrozj8?=
 =?us-ascii?Q?Qo/ygB7/JzhvmUkFGdwZeaJB8kX0PzPxMIA06XX7/FRSpaxC8TaUm0IR68hu?=
 =?us-ascii?Q?XwuDd6s1+S3LOEffINAZXkmOEOr4gUQ5TI7HbkQtkqE3JtvkOV8K+uNalNEc?=
 =?us-ascii?Q?S9uqFbT0Wq6jOs7U8zO5+ngoXS/OMIZ82z0pN07e/9xqMF1uUYdnpUdtQmNF?=
 =?us-ascii?Q?rxAVp/oT8F+OFCao+0Te6RowZVHVHGTKvAWI/wg5va/T/cgWJj1y47a96iio?=
 =?us-ascii?Q?2MxsRoNBx3MXsuqb3yQcO1K3JCMDqFGUy6mLTKvhF4zzpNNGycbObLu0WP20?=
 =?us-ascii?Q?+xpcUfD3bzmWPNS12oGs3UHywGVDMtF79zfBdLazSE7Vsi/OyiD/fHLzGw2U?=
 =?us-ascii?Q?QP4OnCzudq7H357b2yQb8CbS/E9/LY6IC4W70iOixQwgdnytmMGNdQZWNpOp?=
 =?us-ascii?Q?efXGznsJ1t4DK+05q/JAcF9I8bjwACRLTMHuqfEw2hH3C/DnX4kiKlteFAws?=
 =?us-ascii?Q?39FLzSOvsCW+FYxdeOtqjYLRjsYXrSBzqnFdDn+N+xAyD9ztuK+E17viTGo6?=
 =?us-ascii?Q?+pqdlDE952UF2vJ4bth7f509wibYPHscj3CafjfYdOx5bZhCdlIPVgs+1DSk?=
 =?us-ascii?Q?3sZUuNROBNHuXqOWPxAhxox03IUXlWdj8+XqhMlN42Yq/nqFAT9fLrjDLwyK?=
 =?us-ascii?Q?JU2m7iuaoof7SXPBS2iVsB91iH3YopBp71XaA396h4981mMn4x7eYgdMV9lS?=
 =?us-ascii?Q?38i3CVCfp7RxTL98IJbeecaZqIoR10EkBpM4Gby+ruK3X82uwBqm+ybL2qEA?=
 =?us-ascii?Q?sOY7Ek3BRlcqc0+EVl/IPqN/KUnd6Dkmi1FeFSwdRZAu/i1uCs3vVXcq7+/w?=
 =?us-ascii?Q?NiyA6hAE0KaAnyMWrkUUT+Fw1CkY2z+eLv3+fFKEE0/q56fciCdkPFe5vYOY?=
 =?us-ascii?Q?V7/IKUHNsRYTvg9BVhdi9H+fKH+BVgivTISz8KM7RHYW7vKeAJJrvWJFfOix?=
 =?us-ascii?Q?ulMLHEc/DtvFg6s4itbzWuPxvZ5A+PBie+hM//pj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2c393e-dd08-4a12-f85a-08db0ea91b96
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 16:32:47.9760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quc229/uRI9HY60qBHwM1e6GDLfCigA9OsXlJDAHhMpduC5xw5vRh+GtsjSjZZ52
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230

On Tue, Feb 14, 2023 at 06:14:07AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, February 14, 2023 2:03 AM
> > 
> > The HWPT is connected to the ioas when it is finished being created and
> > should remain connected until it is destroyed.
> > 
> > Instead of trying to disconnect the HWPT manually during
> > iommufd_device_detach() simply use the object reference counting
> > mechanism
> > and free it when the refcount reaches 0.
> > 
> > This means the ioas->hwpt_list can have an item with a 0 refcount during
> > races, a prior patch made sure this is safe.
> > 
> > Add a new API iommufd_hw_pagetable_finalize() to formalize this contract.
> 
> Can you add a few words how you expect this to be called in manually
> created hwpt case? the new API requires it to be called after
> iopt_table_add_domain() which is part of iommufd_device_do_attach()
> now. Do you intend to move iopt_table_add_domain() into hwpt
> creation path so this finalize API is also called there or leave it as today
> which means again need to track first device in the group to finalize?

It is all still pretty messy, let me try again.

Jason

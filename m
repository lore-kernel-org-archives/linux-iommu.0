Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1EC2E822
	for <iommu@lists.linux.dev>; Thu, 23 Nov 2023 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t8iFoUw9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MziiGrraLppOKgidc9+RmUZOfENWkETU1s0rrthJnGSMzFkH66RvjD8leAvl/AlKKnEMmEbkxb2kCiRQ+JLKfPzFKkt0rF54q8Uy5KoDxwhyUWvuc2JJorILyfZ6JpEeptEIsTyeUslBXxaFmv6oisXnzYpQlZgqHFOlDjO7CGU5UMo83AYoSZtEpO6568t+mJzYkj13uLB1QT12ICcC7OoAn5b8O8wImDudLknIsk6Mus33MhnTBOPyxlUyg1vF0qA649o9eCGu+1FNcv9JJxf5ebpYHXMkd0AlMnD6x/8o7R8agSOVd+qF9VzzJva6EY6mYWjq5FQKM0eoGgql7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6FutPt5K8r3bW+drA5j1+m0wZShqwcOfUMyht5LhLQ=;
 b=ifynQlGDI4Z+N13vXX6Nn5hVrbKBZh4CPJ0JbYFZZKVq3k1JInRsxlq3nXCqX4suxSx55D0798p/AUXSTiaaiUSK+pcW6DaLf1Wf3nhyjd9pxvRNfeCSP49xQhE9Y0cbnADJIe+KPF/rDbPwQWZjSEo13r+49cHmvmO3GJ3rY7rOH6LI7N61yj4sZyu5drsJPkVFvnpFSJ89XwVsjwcto4N/tt06lXeCM82qkJp2pJvVK+yojz1zxAZK5D66H14MW/UVR/YmLoPYehQ4EVzhufilfPQVQZM+3o9w+IsUuCzklCeRUtMHlD+Ao38OfFXCJJ/tKoo9+SS98gwqr8ZBZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6FutPt5K8r3bW+drA5j1+m0wZShqwcOfUMyht5LhLQ=;
 b=t8iFoUw97ETrOn9pM4FdbNZnkmJ0BE77+gTAc9EMuru7VbKyNJLO+eoeohC6NafPXA4eXclzhwwP8EcBUyn9mM3OAgcLy8mtc/toEWr9mP5+H4e+i5lQ33BRLiGp4uSvnshoYxolYoDXaPkDIhLIVMpgiJGOagoDfKr57z2FUjT1UtLYwzxLCeAo4KpBn8rLJAZHrr7kI1H17qPEPpYHChwFfE3MHK1WMRJuyECTk5A8ufIJ/PySheI1+nQAT6mV5Ud6r95pwmqtx/9r6U9r6dVd4AXxbSkCXAcEFFvJfUI51kelJS74j38ByPRGRCkoSEHHpOksUDZ3fEBPcdDZnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 15:11:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 15:11:19 +0000
Date: Thu, 23 Nov 2023 11:11:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Rob Clark <robdclark@gmail.com>,
	Gaurav Kohli <quic_gkohli@quicinc.com>,
	Steven Price <steven.price@arm.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Sean Christopherson <seanjc@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Light summary of LPC discussions on io page table
Message-ID: <20231123151118.GA436110@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SA9PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:806:6e::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 051313bb-b98f-44ac-1734-08dbec36728b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DOU+Fvd9u782cr3h/k0vsTJltQa3QPIkFG0g+M1+lqZnyq8QJF2pPiJtlSI58Opyq4by5pgxRxsJH7aYwRTTSKi30UHRKP1FUijrOwwpddQiOXVxraitaKbj3taWSFZasuwjJw8c1cglE+hQqsIiV6t9PcTLgpeuirOi5Phwu8VsulIVG7GUzFKvKFH6mO21MoAWfJxiuqkOJYqCnlSyk/bZ+GIPGoaH6VxvXWnSja4SWbf4gexLy1vaF9KL7xBd8ooU/4U7oDWu/e6U7XSgMJ9Vonb7OKXn/cjAs1yGNCHbl7YboTkULpy5i71Y08iuvBhm28FPeuTWcmhTF4m2402O+t3a/+k7yI705CWEhcvzmz+lU7QfkWXLKgwnF+RylgRztuxZHSZtsl7T46S3pQmjCnhxvfjSIyf2toS/MhadRZO2J1jmxwjhXUTJUAf4R6LoAtWrW+DTAJAkCOIAZub2uJE719xERR0CWVal0YCDgd+v+69VRGqkC3CWmntLGhEmSaFc4oemm/dIMHCV9xDgZv3+eS1kAXnkW3tBaw6saeaAc5G+gffLlxZK+/1nCtMpzVy4LbqH+h7hG6h9EmL7u3u8ddT16KNCl9JWA7ssRpzymvWvCaJha6AiSPm8C2d9+jsHOK5d8dSn6GbLBQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(1076003)(26005)(6512007)(6506007)(7416002)(2906002)(5660300002)(8936002)(6916009)(41300700001)(6486002)(966005)(478600001)(66946007)(54906003)(8676002)(4326008)(66476007)(66556008)(316002)(38100700002)(33656002)(36756003)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZjxNxD+eEnWMCgkuQKzjreWCXxt8ehHLgJJGq+D0VX6omfwHiVHuTx/hYEgS?=
 =?us-ascii?Q?6FE0ZjyFaPSlsHJp8P6QNnGkyZ7pts3aV73cpRy0mE8S6iE6wXCGcGZC1UbB?=
 =?us-ascii?Q?m1yg8/GPcTdLFPNvKv7uW+k1PT+Xub0wLliyQwDjDUG3UgguCAY9MpN02062?=
 =?us-ascii?Q?+aa6uo2xXypgTSUoAp+W8TZq3DFDb2YYqsJcDDR0Lq3TrxrMieH996HrDJqw?=
 =?us-ascii?Q?QQnftpw+UF7fgrOoVeO/RNiBElS9oYCIHojuXlnU3Nzv0zlVmZ0UhuuJEt1j?=
 =?us-ascii?Q?KAznpd01h9T0kG0l7k2nYvuQDTEASjFWM64esr9OpvWfYP7Dp2lDkbWGFdkM?=
 =?us-ascii?Q?Z5aod7ts/8GjLLV8sezdPq6C0eouMU26XSY74UUjYDNMzT28f9XsdqH+3Kp9?=
 =?us-ascii?Q?wNUCnJIZVMrhA7LOdjzstR4wa0yUK6bb+PUNtZHdyp+bfh6MnJbrlidO0MKZ?=
 =?us-ascii?Q?InwGEHC34QwHjR7wrFwDM91V3AVpe2BZSW0MaMLN7L19MMKuN6knU6/KGiah?=
 =?us-ascii?Q?CR4QewR7iGPY/9uqSX4vO0m1ivTmmW28v5oIGErd+EuFfvfGzoTF+DMsOCpV?=
 =?us-ascii?Q?8CSKy6TenNq58AEWPAduDMfOUYiBoAPm6S2ewm9rdhguLlaEFGeS0XcLaHA6?=
 =?us-ascii?Q?AgddKZKFYaHoMdg0e/Z6Dm27exdnWRoNJlHjVBKIeoVnjrJIDCEl1Qgo4YNS?=
 =?us-ascii?Q?RMRiuIlrwtrYzQtcGhKkPRKpgTiaAuwI6OVvnjW8fiOutUP8cqEBybO6l3qw?=
 =?us-ascii?Q?waJfcb667p7Ag71And0Rbf56vK98YRzLP7UX0LhWkqjUEhKek9KNfzxBOqsT?=
 =?us-ascii?Q?dfQotm3L+nZFrkf9qA5vqTZlYN/m1X6Qw0JfXJR87mLZ2l5FgTk5ayg7iqhd?=
 =?us-ascii?Q?3OjB2TOKp9EXdTrIoRaWY5OmKIl+6UcuNIB7qCcotJer4yZ2DY2r62i6eQ7F?=
 =?us-ascii?Q?ZCetm6tXQYHBxbru225t5CH22gjpyTcq0+Qu16Xsr0TjLUIDEFqBQxTvVHdu?=
 =?us-ascii?Q?mmL+d6Cjf2NBy5adI8+GfveE1XaZrWzWjUWAR2+9Gx6EDSDd9fhI/0DIZnea?=
 =?us-ascii?Q?FiGx/yqOQ+wDC4lWIWQWcPVu1nZ4pCCfcqhCZpy66qprRI41X0RFXFW2AB0W?=
 =?us-ascii?Q?BE5CkA/7A1+ZXgO9+mhn/XyqjPPufvil74UvGMTLj/bxXrFFHs624s+Gze6A?=
 =?us-ascii?Q?1Bi4ICTK+7WvMmqYhn2bs0F4wr/2vwfNaKNa0nN7g7I3hcoClgA80zJB4/Bd?=
 =?us-ascii?Q?+n9beItaOufUHbw36Ben6XLBIfOWb6qLcfzDuYfw3Qq+vKYscDU0H5rwmVYl?=
 =?us-ascii?Q?cJJ1GdVhaIyh7xRiVckunh5AzpXRnO9YWiZOFytyy7vf8NIB5CSAqUD+gIap?=
 =?us-ascii?Q?EPgH9N9pcQQFzeUHq4WKuJFHnhmi5FsNqOy+Z96rXXmY9QQdeQkamTVupv96?=
 =?us-ascii?Q?fGZl/ZiuIeeSMq+9mEouyxqdMynFfynM1QzH56clswCSWvS/e6NiHWqnWYQP?=
 =?us-ascii?Q?hquRfJxZv9/dyBRu/XyhT+KU2UrfzHH06pdVaklGylZoXkhHxWbyP7DEWfqR?=
 =?us-ascii?Q?p81TKiuFMdU1RqPshMCicKVa+YBAQjSyZCdK2Bjl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051313bb-b98f-44ac-1734-08dbec36728b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 15:11:19.8428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvJ7a6SKN9UMidJmZfMq/t2vohh5vVOA7mAO3ctOXUtZlW+MhEk0Log9Jce7I1m2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086

On Thu, Nov 23, 2023 at 09:51:41AM +0100, Boris Brezillon wrote:

> Can these people please raise their voice here? Or maybe LPC's IOMMU
> discussions were summarized somewhere in an email sent to the IOMMU ML,
> where we could discuss that, instead of this thread.

I think we are using session recordings mostly these days? I have a
bunch of people interested - I'm going to work to launch another group
project to tackle this. Maybe in Jan.

The recordings are not broken up yet, but here is the master:

https://www.youtube.com/live/vO2mAM8wOvU

Pasha's talk is first at 2:21, and there was some discussion in the
room that may be hard to hear including the use of RCU and the
refcount. Pasha is interested in solving the memory waste his VFIO
application causes which is basically an algorithmic problem inside
the io page table.  There was also some side discussion about
optimizations. mm implements a batch free technique that could apply
here too, and a batch alloc is also potentially interesting.

My talk starts at 3:11 and we have another discussion later around
this issue in the context of dirty tracking optimization. Joao has
written and shared some code for what is concerning there in an
earlier email Sean C is the voice at the back sharing the KVM
learnings that getting to a common implementation is highly
recommended

I had an interesting hallway discussion about a use case for bringing
back the old VFIO type 1.0 huge page split behavior and implementing
it in every enterprise iommu.

Then we have this DRM need, which I've come to think of as a
guarenteed map without a table level allocate.

These need touching all the "enterprise" focused page table
formats. There are so many now, doing the algorithm work 5-7 times is
not reasonable. A common radix algorithm and a more complex shared
implementation relying on RCU is the direction I want to head in. mm
shows a template how to achieve this, and I have some rough ideas to
explore.

Thanks,
Jason

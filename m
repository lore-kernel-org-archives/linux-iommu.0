Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5FAEC5
	for <iommu@lists.linux.dev>; Wed,  5 Apr 2023 11:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CByT7pwnA7/Kk2JaHN+PWugBmrnzt/gapW70YX2dPH106VCkfU+VdB+pDRp1MaMTajoRhrUaC42obNwyfsXUB5x7ekDpxALfhabc1UqVkw7giw85KQosw0clAEa84fxdsZFdr4s8QRVrzzlnegtVRTlXzqH86/wK6q/ewve43dWfO9gVp4/H2N3xQawPvslbUodETlbTK3kbFVb05syj5FXvQgZsjyEH1nsPsIUErcs3iNf2NmtHIm9f4jlKIKW7cJPJXUF4Afv3DvnxxR2yHl7L9LAKfNT3wzNf2yG39tY9Jipy38fmNj+h8GkLjThpbvG65wxX3Emx9pVHmr1ZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETnNIeKfM/I70sT4H459T0YedLZFHUq8kRqUiPen8FA=;
 b=GjH7GgKMfkRy6bY0fuzBztc1blOff9+E7Sew23U+Tb0pbMdoe/FvTDgYVFH7T59yscXEu51Tbh0dwTOTAkgnAh1NdRGDKoKHHb4JyHl9i9i57Ok54wdXE+7j9z1lmF8EubG02RB/Ugkv1JV40qMGVuSrnK3ZQPdB7xdQ4OouSwpf7bG68XRb0KH49sgW1UF8nYbK0n2jW1990ibKCArw5Q46if7uP7mWW1tcBx1l/4ajXsIKZWfRgsJMP+RwB+SWtZwm2eN750jm6xLArcLcOwRaQP6sEnTkO0/SPmRzCXbobecUoK6DrRpQveql60BP4jbTzCYrpDKkt1PsErht6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETnNIeKfM/I70sT4H459T0YedLZFHUq8kRqUiPen8FA=;
 b=KMe6U2qwV7PVB9v5Ro6u5XC05JoQA/nFWhn81ng357FCSrHDmObYlnpQmFtKqMRSu3CJbNqDojOlO999B/Zwui2NdkE2d5oF85xR0qa0rh9Z5DNgqww9BFblhKRY8jXhNVwLVSL0eIXW6oWsnq4NZmjpdqii8yTOQOXd8EhRp23Ry4VDYO23w6Phu6MA+GU+goJe+2plOYVRDGkNKTrmTCieretamTvQ8zRE3ijGWY7dUkGzh4x0UIEQWn9uV44y3oDKKzrUbKR4ZR6axQFqEJvZD4iNlPmaZzIA4MnI1Qa3syHj7nYrANrj67G9rplWoT7ANr2luecd0IxkF+mPGQ==
Received: from DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24)
 by DM6PR12MB4944.namprd12.prod.outlook.com (2603:10b6:5:1ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 11:57:55 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Wed, 5 Apr
 2023 11:57:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 11:57:54 +0000
Date: Wed, 5 Apr 2023 08:57:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"yi.l.liu@intel.com" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZC1iQf8HdVNyG80+@nvidia.com>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <ZCrd1wphkCp8uFt0@nvidia.com>
 <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
 <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia>
 <ZCxOMSvR+6rYbIfy@nvidia.com>
 <a3bbd5422897475d8bcd4c110c3722ec@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3bbd5422897475d8bcd4c110c3722ec@huawei.com>
X-ClientProxiedBy: MN2PR01CA0008.prod.exchangelabs.com (2603:10b6:208:10c::21)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|DM4PR12MB5357:EE_|DM6PR12MB4944:EE_
X-MS-Office365-Filtering-Correlation-Id: a001dcbe-feb2-4ac6-4738-08db35ccfd81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c+JaT03HT5xZuNcX1O36wn4T8sMyglkV3a/9N+T8O7rCLmoCPIF29PBxlhfiGcYVn/4+j9IyAoaAEzf6gTCpIyxvIRIX/66+S/P5tzquC/roleV0F/FFdAmnaTze/5bkdFmNBCycf08dpd31Wr9wociXpLIIHSvbCFskQRTcamnJuDpfGyapCRd3PjrStkrrVRUbCOpdrHWacVAHMSb8rz0H57QlG/l+1z2oSlZ+hlKItk3engwkMje60UvrEcKyAx0EiRw0q0b/4rJokrFOdu3ySsnpYeQEZANOVY8PvnyvhFC3M3+CwlaitzHX+axrMvCuz/d22MqYqvMtNihDxaKXCE3yQZVVqFfQsnN7DXjMXZQaCbDHCHFecP1MuGOlNSSCcbgvzufQCqkQr9KtyU9hEUfT8tKoA8W4HPVEEJPj15mDYp27O+pMCj7TDKbY0FCs/koBW1sJnVHC/YH+xeiXo8c9ebta1V/kqEiNMh1ey9fA1lTw6DPqRuBzhklJVZyP8uin/ilWR5BfrorRxQ3mOgKDYwxdxKqRX4DTWjvz+3hD8HMnCXY0lQiKJnLD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5357.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199021)(4326008)(6916009)(8676002)(66946007)(66556008)(66476007)(6486002)(41300700001)(2906002)(2616005)(36756003)(38100700002)(186003)(478600001)(86362001)(5660300002)(54906003)(8936002)(83380400001)(26005)(6506007)(6512007)(53546011)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YdqALQvlqIPDAz56wxx2OqIf/TdFuBZ55P475s5XP8Y9H/Dh7g3DwblJ48B1?=
 =?us-ascii?Q?on6fbTD6+czBKLdREG+cCfCjpdM6NHc4oSROJBUKiPQ59GM7aalcY4GeQHKu?=
 =?us-ascii?Q?1VKcA3zs8Ka26S/F4odIAv3S53ZaDWKuyTkyHNzZg6GcmxahAl/WxRFH9/UC?=
 =?us-ascii?Q?RslIjucWzyd8turllLFClGtFbb0TT0qzPyEaab3RBdH5eT+r8bgo4iw35KDb?=
 =?us-ascii?Q?pqVIgGP/kB7XHSMDhBViwBsKQ9m4LRbaoP5GAaa/WMCxb9CQtVqCUA/DAGAZ?=
 =?us-ascii?Q?Q42BfK0lErOHamF7EnMyJysUu7Wzz8gpwdB1LLm4YWPqdFA87iEsBpaa64k6?=
 =?us-ascii?Q?JZ59xgfpREpUxqTIMEVcpyBTRqyi/DRaW7s8C0tGsMy+GI1slvWRsiEreSzv?=
 =?us-ascii?Q?xjG05yTFg25qjpeP/TiUo9+fJ5Zy7lpCVWzveu//NW9jFomPdhQg6qqshh2H?=
 =?us-ascii?Q?WUGVUdK5YeVKmpkuQC4EWX3Gqyf7vRTvF5rKno0bidrKvEpn2nnc8vgt74bW?=
 =?us-ascii?Q?XXD2sx2LUZwOcr0XF2rYTDb253Uq2Nd7MOiPEpNe50QMF+WZ96W/MFO+L3Hw?=
 =?us-ascii?Q?PCxRDOEUqGBFW3VjGYy2S/zw61/6MXQ6aiwqPT8/dy2MWBqJhSYj6yfj6UrM?=
 =?us-ascii?Q?1eGRWXz4HyWQITdFmubha2lO3JtgzJtfzrjeze7FKkSIWbdlwn2ginpBVq0+?=
 =?us-ascii?Q?obF4fD6yR4cV+SnUOwSbLSv92k0e5EVA5MYUca9M1k6VUuCb5KIqwgT106M2?=
 =?us-ascii?Q?t/Jq12sK/Oc48akFUW7C8CJhulIUPeYXWm38M9PJ0B9Co87gvABMFjK2aC0O?=
 =?us-ascii?Q?xPJwduHpvjdyu+eVNau5KVdmTGyMxAZQNgzWgUxLP2HBJnvTa9d4czJnSvmW?=
 =?us-ascii?Q?oSbSbh4OO2m/9v6clMdYw9jrB88qP0q+XhvkL1mKaIlnZxk3TqWVzYtLgkfR?=
 =?us-ascii?Q?TP2cgZ/yRQ39N2CQPfy07d+ZIOgCpSkSn3qqVEc733kziXmhvblyP0KlMuie?=
 =?us-ascii?Q?5k2XKMHQPaHxlRmeYdjEZrnch3EYSEkAcvOILe/fHRaJ08pbk/JxHmlGse4k?=
 =?us-ascii?Q?STag2gRivqt3KON2hVoXZzWbAUbBkCnYvCKFsEz6b8RT9F4wGhwlwMM1zNSo?=
 =?us-ascii?Q?a8z8nT0JQKJNnC8NyfKRYbSUBsw5tYGbOdOdQev9zn1A0qpW0Sg6LVax4GeE?=
 =?us-ascii?Q?uV90Yk6B3Fn4CobU2AiTDW76E8cwY0/KIIjfkH8sr7IY3ZzvWf69hmgMQjU8?=
 =?us-ascii?Q?FKYKDhNMBWNolm45JYrxWMKHo7lW78y9Kpk7kKDO4UQsVq4NhQ3C7yGw6L0+?=
 =?us-ascii?Q?XsOjRbMMzWW+JKcoi5WMQa/4n+oIfBLUVwdaE7IbM10gi5oQ4h4nJ9EYY+Mk?=
 =?us-ascii?Q?Rrout38zh406WIRIHsuhhERkyt35CLyTwLl5xouHUBnvmGhkAN24gd4/da94?=
 =?us-ascii?Q?AXk0G13/fQ/j7HenQQgKB2nNnohrx7nU/8McuN7vFk0O6ZmvaL9NNn1dF4bM?=
 =?us-ascii?Q?7N57qS4oKzHwoYSXHDGtPPFxIJVvdz3cjH3GXchZbouR9rK9II3UixpnYbHw?=
 =?us-ascii?Q?hVjbbBIAZqX1h6HxkrZYNBJWJRpLr//Yl5amnsNZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a001dcbe-feb2-4ac6-4738-08db35ccfd81
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 11:57:54.7711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBP3OV6l7IscDFINL6/TW7MejXDecTcQIYa1gV5V0dK0A9BrKvfK7h3kgGduwpRs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4944

On Tue, Apr 04, 2023 at 04:50:14PM +0000, Shameerali Kolothum Thodi wrote:
> 
> 
> > -----Original Message-----
> > From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> > Sent: 04 April 2023 17:20
> > To: Nicolin Chen <nicolinc@nvidia.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>; kevin.tian@intel.com;
> > yi.l.liu@intel.com; eric.auger@redhat.com; baolu.lu@linux.intel.com;
> > Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> > jean-philippe@linaro.org; iommu@lists.linux.dev
> > Subject: Re: Cache Invalidation Solution for Nested IOMMU
> > 
> > On Mon, Apr 03, 2023 at 05:02:09PM -0700, Nicolin Chen wrote:
> > 
> > > My preference is to have a mmap'd page, so the interface can
> > > be reused later by VCMDQ too. Performance-wise, it should be
> > > good enough, since it does batching, IMHO.
> > 
> > You can't reuse mmaping the queue page with vcmdq, so it doesn't seem
> > meaningful to me.
> > 
> > There should be no mmap on the SW path. If you need a half step
> > between an ioctl as a batch and a full vhost-like queue scheme then
> > using iouring with pre-registered memory would be appropriate.
> > 
> > I feel like this is a topic Shameerali should share some insight with
> > since the Huawei implementation will rely on this SW path.
> 
> So far the tests we have done are mainly using IOCTL method without
> batching and I don't have any numbers to compare against the batched
> method yet.

The question is more are you happy with the performance of single
ioctl or does this need optimization. It sits in a hot path of the mm,
so it broadly impacts certain workloads once SVA is enabled.

Jason

Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5944F36828B;
	Thu,  5 Mar 2026 23:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753915; cv=fail; b=l64eQMcTL4sUWvpPXPsv+6Db3393t8Ck8zOMsXtz6klkDoEjZCEL051yFOL551cIU7XAv/NB/wcbaBnloy9iLDFmeoae0JwWFvyWUKxWa/qs1Pv7J0hQsxTzseLSNgDOWD5DiyhE+UbFkqBZhWnt3MRdlx+9KGmeJV9pXrMhiFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753915; c=relaxed/simple;
	bh=GAyTa1DhumNHzEZkGQcGgcIsT2U2qhQkimWsflOQOcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ix3VKRua4xBQb98kKRSxkVNRXd0XnKuK1qzgbwP70uUdHeGguRkFIQNapc1Ib2+NFy6SLUaGwDLiYHI8LOneXebnj0ubly6dRKayzj0XyQQLURk3z/mL2psQdRaQUW21hLffPQDwUt7jyDSQ8JSM9YragmGUl0s4NWND5QZpE0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pt8QURIV; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pt8QURIV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUJNINGa1x0e9X8MMxQfDkaxOPpz3snk4/8lv43+BAS65uHZdxjDz0nOZPpoBJqO87tCf4gfYi4qq67OYfsETOSsnzeeaW/TFnK3Lmw50cEDZA6uJqtfBhcFdkYeBML+h+0oDPUoYbOzpfXNbVKrqC7FNG2CNePm2OsHHk4+QLp92VUUJEpWeks0up4sciYf6Q8qM3BjNucUWN1u6IoN/uRMwv28BjLaA83V4GEJ/pHZdCVaks/yMuFz/JjsZJW5rdEtDx2nqt6uE4gWnhlggAPXVEUtGvLxfZid/FX7llRkp8ViyzkIU1kgXnvpl1KkYFfzPzukDNXfqX4T/XLlMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEfvh3VBH0k1+jZ9ep6v3XU+pAxOujHEw1Iaoj6Snpo=;
 b=TY5CXawnge5e56tri7s8ZvmxZ/2BdeSzozb/2uLEwnbzBgpbUAsCzSrf9GdcoLoiyEuq2n/6FBpsg/s7xKDGy4X0nfHTyLn1+1uYI6dSUbpc469frBbfT4ieksMsGOHiiDTI/Tg02HTLCs8K3AvZtlUiybvnSO1FRgJfU/2TrvfTSneZthlkNzKHSr1RMcjR7mC8c5iljducr4t/uZUMwhFfI4BVAgKaE9GPXezFGrZAgzbOQPhrRQa62u9AHFpiGER69D0Tvz4mSctKEKZY0HQLVHBRBbGJC3bql19ddr9DyFFEbQVb219jdM96Ez5jVgfwMD1Nstz7jtB/XdhYyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEfvh3VBH0k1+jZ9ep6v3XU+pAxOujHEw1Iaoj6Snpo=;
 b=Pt8QURIVNu+ZpckK6GMjsVBB5Xldsx1itgj5lLKuHvvhbF60oaJLgB7v+mVgI39qfkS4483cTsi52qrUv5D1yRtyi2IJbQZ8RTLV7zjIs+Mk3LWdbAuf/pHYDZbe/dJsOWf8rQKCp5hxUCxz5Aa+SLp/xkyRGR6y7prSY3kGLwlQt9zODTugfzC2xsB5M8LUOL6o48fH71UzROoUq76VVFij9oyB6ajigx412rcQfLwaYOFVmKxnItSgly3xS5jPmijXeEfjEsR6NsvrdBXT4RrKLUcrrFn1mst2sId8oz0EFmr8isf0uS1gHhWZ9mGeLON6tObhKhXx4xJODA1JTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Thu, 5 Mar 2026 23:38:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 23:38:28 +0000
Date: Thu, 5 Mar 2026 19:38:27 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>, oe-kbuild-all@lists.linux.dev,
	skhawaja@google.com, pasha.tatashin@soleen.com,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 08/11] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260305233827.GA1651202@nvidia.com>
References: <20260227175247.26103-9-jacob.pan@linux.microsoft.com>
 <202602280855.WxyIHCy5-lkp@intel.com>
 <20260228003540.GN5933@nvidia.com>
 <20260305152614.00001a0f@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305152614.00001a0f@linux.microsoft.com>
X-ClientProxiedBy: BL1PR13CA0309.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: d7bb0c66-7be7-4af8-052d-08de7b104d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	txRzG08e6Tpf4gEBibHEhuNkxA5jU49swDVYyHQ4Vm+0mu6G8jLXfOUPPrvMOV6ok2AJ4qS5iu891lGorZlYPytYELh6o69EqfPKxLGNwukMxTywiYCtFy5saTmeDvxKVoGzSEyNZQ5n+ypfn4u+aDTt9ecFgqw2YHtRMBZ1u2Fpx5XkVhgHVf4kkLQOW1fYgmXWdAEjFjqH7EuTlC1CpXYia/t9Z5nNBy1+zVZ3rymEEfr2r52Oj5YdQqLv7lDfTUsz2dJ0voxoNpEhy1bt9USGf9SxQ1+EAoCpkG3hxWGkP1GHBtWe9pzuUNdAV8zWCSj7TeyKy35aQn3QIUH2IdCS7Yh91km7T6LK50NbEilYTroAPEj0wmvfJlzrad67EKV10M467BkBh/28r9KJcn6Vm899MYliXVTFkMPOQciK7mKUJJyhxLaQKy7YNmrBWFxnDq+F9XIxim/O7TjF2qQf9xKDonmkln3aC/Q9SNG80imc0n4Kx0lTV8QH0F2xfW+V4EM/OAP/suaRWi4T2FtoJP6cZZb1ifX3jO5E8NOmmOjbT+G761kcMF8GnZRmK0WQlbwknkiq+BglGevp8bD9wMaxF3TGUJCkBskOD598KlGrM4XWgb3QleiAjAS+d49a0daAyIKBfYN5/Z9J/5dY0V+wEPABORVSsxSRpimzWCWq+7YpsYeSsWOCfFnjtHMqpPGNjXS/Tr4KGBCtuiQJGAn6LxP1wDQKt7duG/I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5apSgkxylugJUtg50678OWcsIVgR/sewSZEwwK+hlMZ/7NpWjGEWbEqdTxuL?=
 =?us-ascii?Q?JcHcSzDqBQZ1TNRrTL4iSR1D/bt1VSwylQ3yiH/wGdO5ekn5gMsX7bJzEcBS?=
 =?us-ascii?Q?fGLJAma7D24nR9/sozSxh1NfOKoRZhIcHfY+mxBmabk9w7Ox/uEgoMQHkIOf?=
 =?us-ascii?Q?YXeBhnQyApl52yewSj4ymcqPikXeCWqsAYGYF4H3G+oygtg3E/qectMSxXrb?=
 =?us-ascii?Q?qbzVE3rbrnFPD+HIF9eHu/ClGVFrIcyJIU7AniXFNi5Z6aWZM5+U6oEHAvPA?=
 =?us-ascii?Q?wkfDR8EWFebe9wjNKwIg9FA7QdjOgdOmbwYn/qM3kunp8IsdP8ZS7prqgES8?=
 =?us-ascii?Q?mOGIJ7ATPeVOgwycWfCk3fdw6S57jdYqAQukgVkSkbmwThqy5F/pkm7V4arI?=
 =?us-ascii?Q?gntQN1aH20e2/2mmVayrrKR5dwb1Vj+aRmoG0+2yOicQLxK9fxuA2RS3zWfU?=
 =?us-ascii?Q?FLBOB2u0ikMxyeVS+PtQL0cdfR0xypW+yh7zwI/KRQwGoAmqKv8n++MwhSEH?=
 =?us-ascii?Q?6Y+SNMRFJd5hWeEoActCPz7OaIkyWMRoyg4Qfxse5Hg4ytIemGwMsRC+tA4u?=
 =?us-ascii?Q?mc3eZApTTsunQ+IgkYKS/3XoIvn442r0nikjs2U0bQAQHBBUOuXDDELlBfCn?=
 =?us-ascii?Q?gr7zJFz1yvWOlBJVTd9UW8cE9YYThC7i5emxjr6hQmOAdlFxG202gHMYFM2u?=
 =?us-ascii?Q?PacNFNFlgu9V2bk5k3io5VvD2wVHDCtj8+HXMBUfv7irN9i5sdacDSiQdqFs?=
 =?us-ascii?Q?k9BvBXkw4wXJ7kXIgyVL6JHTutJzLnsFquXRTQNkYpVQLiz2K4y11aOoDQbE?=
 =?us-ascii?Q?+WvV71DlX470IjK1/qVjKBw5T9iY3hJ2r0MNEq9Oaqgdn+sjWzKxkk4RrR4C?=
 =?us-ascii?Q?Wgul2YzgLtvCQp96eRyXAPheFX+R7SDLKjTEDSV4iy44GGK7YgPT/7uz97aa?=
 =?us-ascii?Q?ttfjd9hm7dW1f2uy11Kf9YK0HfQ/ZInRMuM+yMoqo7xIOpKuoa4QSR75lYF+?=
 =?us-ascii?Q?a8thkn/2tqlJkjM4qx+DBensUgk4NafVe9UUKu4310YcAoF+Ygq6UfqX5Kza?=
 =?us-ascii?Q?E2mMNVVJkZ8tNCn0m+ZjRK4ONjVJI/GbJYPddZaaTy28u/mUc1+QZsWI5xVp?=
 =?us-ascii?Q?psm/cBr80z+02CcyjDfOrj+hBt5KYVzApsAyF5oVAqG7kcHJoypDLK/YxGQ/?=
 =?us-ascii?Q?z8I+U9Akmg3m2KsTEIzFV9fVhLZMLZrObrjjhEXymCRqYUl7AEc5hp3oygc5?=
 =?us-ascii?Q?2urZdfdDQX2VK0zDnZBsXB9UEMLHkk10UGvYxThz1zl0x1mYduq4lZRCoSVG?=
 =?us-ascii?Q?hpn8bYsQ4Z9K1Na2nvjYX79l8RsEIZvVljXv4xtlfHGXIiN/a+UyhWfVaySo?=
 =?us-ascii?Q?Y46vsoiB8DDmXFQOaox5LdIN58jBa2L5u/FjjabOJJSl9yKbHWGLzOMYJa5W?=
 =?us-ascii?Q?vmb4cw8NfTCx8Vlad6yXA2gy9AR8Fur+Hg8lhdwjM5/q7Z3kNytqvzwhVDFc?=
 =?us-ascii?Q?m0MiLe560FZvOFmfZt4/oiTYQSKBkOCIBZK5WtOaQTTmKloJjcVwYmfjdjfN?=
 =?us-ascii?Q?RNvK0uDxzkxnbMe+KHyaqfc3FLGaMNBXfm0idXuzs8copIxodzojuylRu99q?=
 =?us-ascii?Q?bFnmrQ/s7LlvzkafwkqFmq5PjRKjULLEYDoi/1f1Ua/1C5iXO/yJ5pUdi+yO?=
 =?us-ascii?Q?4lszoxV/Z9osvX/tWvnxFhp1cEOD5oSlKU3I9+J9vAwDFp+suIYzKg66r0Ic?=
 =?us-ascii?Q?FCCYPqaZsA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bb0c66-7be7-4af8-052d-08de7b104d66
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 23:38:28.2646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROn+yfQDHlD3q1Y3/6WqLLkh7gh0X+KtskaBbvK3FRR4AVKfm1ntdeWjd8qpt+6n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745

On Thu, Mar 05, 2026 at 03:26:14PM -0800, Jacob Pan wrote:
> Hi Jason,
> 
> On Fri, 27 Feb 2026 20:35:40 -0400
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Sat, Feb 28, 2026 at 08:18:41AM +0800, kernel test robot wrote:
> > > Kconfig warnings: (for reference only)
> > >    WARNING: unmet direct dependencies detected for IOMMU_PT_AMDV1
> > >    Depends on [n]: GENERIC_PT [=y] && IOMMU_PT [=y] &&
> > > !GENERIC_ATOMIC64 [=y] Selected by [y]:
> > >    - VFIO_NOIOMMU [=y] && VFIO [=y] && VFIO_GROUP [=y]  
> > 
> > Some kconfig stuff is missing, the iommufd IOMMU would only work with
> > GENERIC_ATOMIC64
> I don't quite understand this dependency on GENERIC_ATOMIC64, or you
> mean the opposite? since we currently have:

Oh, right the inverse.

> config IOMMU_PT_AMDV1
> 	tristate "IOMMU page table for 64-bit AMD IOMMU v1"
> 	depends on !GENERIC_ATOMIC64 # for cmpxchg64
> 
> And I already have noiommu depends on AMDV1 for mock page tables.

I think it is kconfig not being really transitive with select
dependencies. So things like !GENERIC_ATOMIC64 have to be in the
parent that uses select too.

You could also possibly use depends to avoid this, IIRC.

> Anyway, this particular build issue can be fixed by adding
> IOMMU_SUPPORT. i.e.

That feels indirect, but maybe it is needed too..

Jason

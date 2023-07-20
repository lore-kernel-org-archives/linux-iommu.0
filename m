Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0182A18000;
	Thu, 20 Jul 2023 12:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/jkUC20nxuIe8CRrMyxp4qFb6+MTn5kLlMxwAr/We7iSU3FRnB3hm1TDQmylMmOR4mlAo19WtNrabOsZ0SZTXdS8zwp0skSvLQa5f9vonMNp7hRwA/snr5QIURLFiw9P8escwpCyAqj0ya1OlRGzsyCIZEnjdyG0+W5OPNtKiaaPkXRFqif74G1xtHLEtaW+O20XTRDv4/8F5w0XKnSmiMpzR2U5xtwZjyIaGoXfCgfUASWdxWeRVeSNe6GKr0oktpVaj0bO9wojw7CkfkeR758mnVnpdDPZo3hNoe7c5uo37aDd4mWgxnT1G5PpkHX9IXLAsiT+t8bTdvCkbq4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkyNyjXxYYuLDySnXk5YHZY7tuYfmG1ZJMAeDLATj3Y=;
 b=nHtNDEjR1dQjDwLf+AXG274Vwjk2A6GwxXukUonbVAuUTPnaptIQZyRY5q3FDYAF6f5ztK9DWdyBgsPNUDmh+Azl6/pzj47tCaFl7qBxkR6w7YvKEfjbmd1SmrQWIUxD6cIVS7swNbTkNzQI6g8XdU6JQhTQzJKKbPzs3nC5lC+q8amc8q64xF+X6XA8MG9VQtUi8cCZeUoN3IfXRPMoGZocNcxoKQFDgJwd/+7Ui8/g3C4P8E9yDkwqSAbv5+lh8/xSCSYZmQMmsbO4NU7PYnewpSj9T/+EZPwJ+ktpwJC00+cIZNHzuyqn53A5IghR2bIACstMe9hRbS8CaB04dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkyNyjXxYYuLDySnXk5YHZY7tuYfmG1ZJMAeDLATj3Y=;
 b=RH7oN2lqolwyF0dfxdRWaoaRHH78/k5UFQ6UkWl/stvHLZK+weNvffIoaMenZqAe1CBo0ZbUMyEI26eAeGokzQLTOrOpcvAgZy2edEMSGNf+mOPrkaf8n7DiEUlVdX9IWvyHk43QXq+6s892nBeHq6T3QdylNbeG1qGfBHt4WnnNzBttzJU2YBNlxIswxVExizjgVGYEzxZnZnmCRym++aovyhXxC7mtzuACBBzrH4nxxC2FdgS40lt2FvFA63UszNXdY9+QXxGd5Q+HTbQ6xcWo6Ki8Few2D4c2mUsPBKTMoV1QEi5SSxeoHr4sKdYIDt5pt3E91goGKiIBgYEJvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 12:04:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 12:04:13 +0000
Date: Thu, 20 Jul 2023 09:04:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 03/10] iommu: Add generic_single_device_group()
Message-ID: <ZLkiu7IyimCckiFs@nvidia.com>
References: <3-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
 <32eadc5b-bb39-5bb1-f124-44feead97ce9@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32eadc5b-bb39-5bb1-f124-44feead97ce9@linux.intel.com>
X-ClientProxiedBy: CH0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:610:b1::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a9556c-5a39-4c21-62db-08db89196eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xI58ane6AdFB3uc8zR4evAtdA0Czqulz+LVMEZ5YJP7wGf3BOpygZhLGCS69/W4W0petHuLCdZNqb475FK9mP7JVM22UflNoNXDI9Dn/zIE7qc2rwdCadKF4VHYlKHLx/LXe/lUlJ8oqzb46I4Tlb8t1fyiI+YLkIdc0XURHXq7ZDYn6A2meJkF1SdEQYLYUq6I2loz2qruU3nDNg073AOylhp3XBue58EElo18efM8qL6BSVaGsvgKq3dMktfARBrGyavQXAjRJfk+dRXUuA/Lzu8hwTLkoAsywA/VEmuZhhJaVZ4TSDnw2jday6/HxaEPuFkCqAEmay9426Oni411OadntYSnooqmRBN2cwJa3p053+weDZXRK2AJKmjdJjl8p2eZ1sltMvH3gvlYsc2uT58ivoRnjgMt2UfXB7Bxb6naLs9GbBhMRGXs+Frkhbxjf2gneFO0rjqjbrZEVDL8f5G4Vp7q1lQfZN7AYIrhcMAefvD9+kNrOT+QEp4h2tMStNniZSqN/EB1ERRNZP1conemzSZH+UaPzxL5WUex67Rz/PWaxZnHXo3212DqDoanFhykqLUCKkR4/Ux1Jkkfq4kueCECxp95V5y6BSlc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199021)(66946007)(54906003)(186003)(2616005)(36756003)(53546011)(83380400001)(26005)(6506007)(86362001)(6916009)(2906002)(6486002)(41300700001)(316002)(38100700002)(66476007)(66556008)(478600001)(4326008)(5660300002)(8676002)(8936002)(7416002)(6512007)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MBgmfz2jnS8B1pNhDdzN3Ui4TFiDbgHTOSmgbefy9tSicrZcDK+lCkDv3KzA?=
 =?us-ascii?Q?kOUQLWFnpKqFlpmJWuzl8jNaXCRkTo572ktuMLBg6iW8SbkATtGiBq52npwa?=
 =?us-ascii?Q?WL2hmnp2Kh9Rm0LyaKwCyHbIcSQl4kOj3egPkfqioUFLFhlTdxDAGVxpXQPx?=
 =?us-ascii?Q?rRaeWlnucK6ZCEXqxNbyBX9Qvn3vX87fezJbO21ELFiIP3PNyyE5wRUIrbwC?=
 =?us-ascii?Q?jgz99D+0K1SCrEHoAEgjIo+HJOO/wHu+ILbYeMxkqO4EFF0NUg9BdDiJyT40?=
 =?us-ascii?Q?WnpSkWzfJ0HaFDZ4E8ssl/FcqNvG1/CwaXcu78WtiV0nOY45aKjfDxZEaojC?=
 =?us-ascii?Q?goOniJon9qNM98u+UnPKovjcUhYcgbb4jkzDoi1qEpWuykYzddvgRBgRwNwV?=
 =?us-ascii?Q?VmT1ZhcO0zLBeySFfe93Tn7zWzKuwKid6qWlMkLrqEDlRa+Z4JcRkj4wnehr?=
 =?us-ascii?Q?1qJICVFrbh+Cvhgae6VVY4szBlJ9q3U4vnPkoEP28bHu+Ovod3rEIUWRmHgH?=
 =?us-ascii?Q?B9le1fEFZyUJolPWKZNDs1o1CM2XEhDhxMYzVS/vt4+fkAYKb4ZQRihMi68o?=
 =?us-ascii?Q?rVKYaH8ACd/uswwRcwOcS4nECq3tty59q5XhNRz+rckGkXZwJIk2BgDSxSj3?=
 =?us-ascii?Q?i+jlLcAjAlNhthgM6hlhud86aHFsROj2n4LWDQ/F1SWgZlStR4zOA9GSQVpu?=
 =?us-ascii?Q?EHvieq1T/OdLxytx6uvosNxU8BdUFtM52ECSDF2xyw3shR7CHbMgQQRGzlhX?=
 =?us-ascii?Q?ZzXIVMrDfGN4vHgkGPO5t2X/JHWZ5XukvDXvXILLSMlvYIEMRwTvJ0SmfmFo?=
 =?us-ascii?Q?vT6JaNjKvE/FsHjNhtB0Czd9jfzwThIpd30ADCHgwP3TMbTtuLskELCV+F5s?=
 =?us-ascii?Q?byxaSw4neLteY/Rs8HC5i7Cosk37mhoEA4lUq0Br6mF0iFHLolYv3PXggQVr?=
 =?us-ascii?Q?Rk5cBlfK0u/NIhnDehmR9bxG5jypXGo6zepplwN9GgcFC/IxiodcYAZ3+Fx6?=
 =?us-ascii?Q?CRSY0ydv5AxfB6vDHziAzQqN+YkNwgGUJVe2ix4mq851yJYkEdINIb3eGcPr?=
 =?us-ascii?Q?I0Zk+3t9P7D93sMkCJynPraXpbNoHsB2GcQkR2jtG+q++dJWF5cTGKcPdrjV?=
 =?us-ascii?Q?5E7CNin9myuPGmy6U+Uqvq58HUsopsWMoJ4/aIKL4mwKlMmjmtwPrYB1BTRZ?=
 =?us-ascii?Q?mWVBl0Tf2ynkN/8+F3pZ00gyxhgc34NK3FZ0bprd3bIngMSri8c0zOiUFTwl?=
 =?us-ascii?Q?Mlqx1Ouy8c3/ktccUqvBFJ6e+4Z9nnIER/XgPi0y4cCDrG1ESBCCknNKRj9V?=
 =?us-ascii?Q?VvdD4Y0+vleJTz5qQ7oSO3j1thECbZw+ZF0zcBzA5szLFtkXCVnYthkWTccx?=
 =?us-ascii?Q?J3nQMO0zIAdkUZO0X+dwsqY3CCOI6LkO1WfacxzzAaMXXbqlPbgxY0S99hlh?=
 =?us-ascii?Q?iT8DfgccD2g8bDz4WNqQoqr/GkLX+vlQ3ZrYAFuO1Yv9YgFYr6ZV9iwnk0bz?=
 =?us-ascii?Q?NpMdEFeNbENe4/ApDSLFirHHemW4/+udx+BE0qXwXbXoO7i78AcdsAX0bsiZ?=
 =?us-ascii?Q?VwYAPFXTYF1k3TXbK0tWkx+bbY4dpwQR4Yv/BpVT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a9556c-5a39-4c21-62db-08db89196eb0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 12:04:13.0160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDP+RhfKw65q2MHqjHC3+eUrqEhTlm4atxfthwJKKbJplRnFtm5kOfdEG+Lq3et4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252

On Thu, Jul 20, 2023 at 03:39:27PM +0800, Baolu Lu wrote:
> On 2023/7/19 3:05, Jason Gunthorpe wrote:
> > This implements the common pattern seen in drivers of a single
> > iommu_group for the entire iommu driver. Implement this in core code
> > so the drivers that want this can select it from their ops.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >   drivers/iommu/iommu.c | 25 +++++++++++++++++++++++++
> >   include/linux/iommu.h |  3 +++
> >   2 files changed, 28 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 9e41ad4e3219b6..1e0c5d9a0370fb 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -289,6 +289,9 @@ void iommu_device_unregister(struct iommu_device *iommu)
> >   	spin_lock(&iommu_device_lock);
> >   	list_del(&iommu->list);
> >   	spin_unlock(&iommu_device_lock);
> > +
> > +	/* Pairs with the alloc in generic_single_device_group() */
> > +	iommu_group_put(iommu->singleton_group);
> >   }
> >   EXPORT_SYMBOL_GPL(iommu_device_unregister);
> > @@ -1595,6 +1598,28 @@ struct iommu_group *generic_device_group(struct device *dev)
> >   }
> >   EXPORT_SYMBOL_GPL(generic_device_group);
> > +/*
> > + * Generic device_group call-back function. It just allocates one
> > + * iommu-group per iommu driver.
> > + */
> > +struct iommu_group *generic_single_device_group(struct device *dev)
> > +{
> > +	struct iommu_device *iommu = dev->iommu->iommu_dev;
> > +
> > +	lockdep_assert_held(&dev_iommu_group_lock);
> > +
> > +	if (!iommu->singleton_group) {
> > +		struct iommu_group *group;
> > +
> > +		group = iommu_group_alloc();
> > +		if (IS_ERR(group))
> > +			return group;
> > +		iommu->singleton_group = group;
> > +	}
> > +	return iommu_group_ref_get(iommu->singleton_group);
> > +}
> > +EXPORT_SYMBOL_GPL(generic_single_device_group);
> 
> When allocating the singleton group for the first time, the group's
> refcount is taken twice.

Yes, that is correct.

The refcount from alloc belongs to iommu->singleton_group and the
pair'd put is here:

@@ -289,6 +289,9 @@ void iommu_device_unregister(struct iommu_device *iommu)
 	spin_lock(&iommu_device_lock);
 	list_del(&iommu->list);
 	spin_unlock(&iommu_device_lock);
+
+	/* Pairs with the alloc in generic_single_device_group() */
+	iommu_group_put(iommu->singleton_group);
 }

The refcount from iommu_group_ref_get() belongs to the caller and the
caller must have a paired put.

> struct iommu_group *generic_single_device_group(struct device *dev)
> {
>         struct iommu_device *iommu = dev->iommu->iommu_dev;
>         struct iommu_group *group;
> 
>         lockdep_assert_held(&dev_iommu_group_lock);
> 
>         if (iommu->singleton_group)
>                 return iommu_group_ref_get(iommu->singleton_group);
> 
>         group = iommu_group_alloc();
>         if (!IS_ERR(group))
>                 iommu->singleton_group = group;
> 
>         return group;

This will UAF the iommu->singleton_group, consider a caller that does:

   iommu_group_put(generic_single_device_group(dev))

Jason

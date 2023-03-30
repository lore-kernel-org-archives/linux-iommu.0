Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA006FB1;
	Thu, 30 Mar 2023 14:41:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrEtWE0oX9FD6Ro+AwH9p0IYIiVk9Mor2DBeVE7boYBP1NDv48+KDIzuw3pCe2xfv5aF/Z7XL+80SLAbymF515MN+lpr/rkbUYUW57yphxvxFWKLacKhIGDV8CqcbqGZxE0V+AS2uPdsh4AVVs2z37siO3zJzalIDU78G9JbSsI6tlpWc61gq1USRuF/0QSJwoOLVHXUhRGgE50nM+Cnbg1dMB5Lifkq0mP50NGjfsOOy+Vw6G4zFaacwOHX4RwZ6Bg5LVvtZK0B/ccLyoXDx+JZSqOqjD2CdDTbshDFzxJCWupLnmsZwOr+0seUiZ7P8gB8m04eG1JqhLoj3UWDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waliN/RrGRDmxeqK0Ava/vnOqYlaWI0B+soWJX97r6o=;
 b=cHW2EHCT1sdTul66B8cSR8FagAeReFIwhou7EUmKLv1/nOPN6L4m9HJ2dhZlsjKgZ24ZmjhasgVz+UYtFvHzQt8E93brH25CFy6EbWQDN5BlGpqeIClWVIhQucsUdoG7fbaZ38GB0vHgQOQOnTJFjx23kmCecRPuez7sw4qsa0cNl3Pg2WSE5ArnkatULMVhoCIecHWUpsinLg3/4kJA6lqcQiv4iOCPj78IQsmzA24rmTJsvRj0ihICH0yESMKfHDRYvAcTWQQE4GF+YNBvltZdJpeSWKEmp+w+FR+Jyd/j9blHqz6SdNLgLHC2jCSy+lQLssKhJiM8aGE2CJntJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waliN/RrGRDmxeqK0Ava/vnOqYlaWI0B+soWJX97r6o=;
 b=e5/QoP8uAaqh82HA8eYjo9BCjFmx9ZDQC66W5jzKRbSypYHG4naNJtnYtkKp2s0OR7j9TBQ8lJA5BbPDhZXq+up8IZ4xL9T5wuc8mWIKdrgFULAZ9juFYoo4zYciuE0TOcTUhM4AmcpRi9vNEoBvd5WMsVvdmtFhOmiYi2WHC9Gc3a8PlKDuLnpi9kiRb/0XgcOyu3tposPkLG7cuRP5ni5FgiyLwjVTcf6HVNdjBjHU/D5Rbfh22I4Pny6jionb39z6lRI0Sh+xw7wK0d1J8jHaq5rgHwUTEiKjbsfOiMPmkDe/qIiCaFD7cnj30igP7fIhMdmPuY7KL2MuW1FrIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 30 Mar
 2023 14:41:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 30 Mar 2023
 14:41:39 +0000
Date: Thu, 30 Mar 2023 11:41:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 07/14] iommu: Make iommu_group_do_dma_first_attach()
 simpler
Message-ID: <ZCWfomPrtmG08s9F@nvidia.com>
References: <7-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <5a249f94-7742-a2c8-2eff-88821783a6f2@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a249f94-7742-a2c8-2eff-88821783a6f2@linux.intel.com>
X-ClientProxiedBy: BL0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:91::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2c8e1c-a974-4868-de01-08db312cdf0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oKgMh2yqxGCWyPnzyXCCDFCDB9ytI6EORhDnol12MG6o8YOZJVEFzHicKuGXSjFXe9QGsTBhQ+Uo8y7SzIzXYVOdTNwmA6iQzzuVlCPEAYLlLLh3C5f8/t1cr1JNgvhEpWyTimtQVybKZ9Hprw+LwVuIihqPvouo/VA029kwkLZjqTSo+Ci69+qs69PzX5sWA10/buxFT+P+/X3BcOP0MjTxVv5sB2Iaf0Kxwhpd0JXLk376fMBPypMGj7rpfxiPOx/Agq4JsuDgPenc4qwht+KDMZkzeEuqY90AATegq8vsrHOYwumPDGdNfIwt95X1cw6HTdM8ceoYHZq4rDg7zA5Es94Qy9jRg78mu2vNSd6lrGkVPhlD2RBy9AsAJx+r+w5m4t6wrnDANnWo6RG8vlrRVLperdIn6TRi8lNWqNU6i8oEaHVFUFu1FSMYAdL5IbKDigP3sZBQHNlQP2O7Nqxqbk9kVjl/bvOm0g1SbpVNzt4BQZavYOwUnlC6USx4fhFof08MwVcDrAqtFCOs7sK+CJ65rNYcpC4lPBCHrYjTyeJr0PTonhTS9rB6qQQO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199021)(8676002)(66556008)(83380400001)(2906002)(6486002)(107886003)(54906003)(6506007)(26005)(6512007)(316002)(478600001)(186003)(7416002)(2616005)(5660300002)(66476007)(8936002)(86362001)(38100700002)(6916009)(41300700001)(66946007)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?foAjGk9FYdXrGR4Z5esSFmEBDEReYR0mEsuUIuiYwhZYwxRwTwbIvxD3lRSa?=
 =?us-ascii?Q?I02czv311mao8PyDBkOaaHtTVKS4OgahRB2nw2XYSSM42eY3qu+XA6fMPrHS?=
 =?us-ascii?Q?grpXnBmJRfm8NOEV2bSTd83PdvPHAR1P97YS5YjweeEm9IdqmguuocgjPj0q?=
 =?us-ascii?Q?n5tE3mB9ST4np5KwhXE6Zqb4e2aZIqcK7i/swX9rktTX2eKnafJfpgNSeD61?=
 =?us-ascii?Q?uTaafS36pH6WQ+r6/cf7+P1Yaaa9OcnWjOCTN6WCO4NeP05CPTH2A27tET36?=
 =?us-ascii?Q?EURoa1mxePsgK03ntpC+44tN6sYBx5lTky/A2Y/nMpIgInBc+V0sLwBfrwqt?=
 =?us-ascii?Q?wiiSrXcBa7gRupGe2BpShnVnQzdfyO8FyGxrVvski+rbEpO0A8zUIcT6MX27?=
 =?us-ascii?Q?Ckf0QmPLR9oPM63tbb0/Pk7YAIJPIixbWFJgaC8cdjI4L8rWCMpMcsfqCBH6?=
 =?us-ascii?Q?/r0KmCrFvze4sLWLUvxxYamfXS17uNwJY+RU21U1GOcSf77JhpIvDhK3+81x?=
 =?us-ascii?Q?HdIextbvzGtukjl3+8xMvGVqaVt9/2uAn9IOecMh6zrE7V+bsPBgzwc+N60z?=
 =?us-ascii?Q?ptNiITpwOKjMOBydfGfyvIY/imRc6bwRLyiwtI2mnPkDLyxVAi1moj5B75Ei?=
 =?us-ascii?Q?1AXHVm04xSwY9DZKFnfiUxIbgZU0wjmF0MWmTt2Scoc7Drq2w6836B+8KiQY?=
 =?us-ascii?Q?f/0YNm2zSEu7npG3aeGkUABHLq5XEHOBP0+lukNkBP8odKO/Ya7cBXym+e+Z?=
 =?us-ascii?Q?TsoonyqyULoaKZ2MRQSenj7t8jnbey8wLs9Cbg5YtwDRzVsHWqOlWoY28DFb?=
 =?us-ascii?Q?9lTYwgLj76L4+gwoNASHtpZ5oFfFPC2WdVhtxayX/BycQA9RzOmjaOklVTGJ?=
 =?us-ascii?Q?OB4QO8skSchJ2E3uIjfz7IkhEjm/bbhFFWYVSAZgcQFKbQoRSU2gVwzA0b/V?=
 =?us-ascii?Q?xNFFsI3ao4sf/e2qshFViUpHhMRFee0+K3usVw71ENBB5bZFUtN9Y8W2leE3?=
 =?us-ascii?Q?OZvHIaHwU92oTXqlIoMh6TAOqz1mT0uKQQ0t8h/nkNG4uC3OVRm8CLStflDY?=
 =?us-ascii?Q?HvdNYeNw/VbXVfbfSUHDF0JlXFV50pKQR7+m2S8vBg+eyOfKg07mNWG82ZoG?=
 =?us-ascii?Q?DSgFRvyzYteqeShoHMj7MX/eZU7H6Ctwc5m5ouhb4uXf5+p8N8T/3bEhUvOe?=
 =?us-ascii?Q?THoyS1ZbpO2aiou5AXz75JX3tYMIwy44Bj5djchuGI+pbS7iAEz1q3e924cK?=
 =?us-ascii?Q?S0w+0ThHx06HtYyvBrCqfoqF45xFTnmT7CvM8vJls0xYa9C512WqFfMRD7/p?=
 =?us-ascii?Q?R1tCPFB95xKJ2w6VKodGW+W1R5o2oN3FA+7v8ixEpKPrmRJZDajwpFM/Y4H1?=
 =?us-ascii?Q?DpDNM3WxQTAunSEzXjdyNc6EjBg0IItiuAT46S4nHFFgWwScZp3OBa1JQ0xm?=
 =?us-ascii?Q?W2zXU9ueoTn5gBhrYd+A4sLJXolhLGahQFuYzku9VKVIlO1ExYVmYGSObVAO?=
 =?us-ascii?Q?u8B39NlOC0LNJNfFlVRODetAM10jlC7d5vV7xTzMx7u8nosaB0izWpsamBRu?=
 =?us-ascii?Q?Qc8eylbJV3Yl5mZsHWbtkhuiPdHLxfNhEtJ6pBlE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2c8e1c-a974-4868-de01-08db312cdf0a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:41:39.4972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZj4LgI0J+kiuj0+ismgHlzyiDzubOUZ3xh8+Hj9X4xPln4PTWAzhe5aFA7K+8aS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689

On Thu, Mar 30, 2023 at 02:42:20PM +0800, Baolu Lu wrote:

> > @@ -405,18 +409,10 @@ static bool iommu_is_attach_deferred(struct device *dev)
> >   	return false;
> >   }
> > -static int iommu_group_do_dma_first_attach(struct device *dev, void *data)
> > +static int iommu_group_do_dma_first_attach(struct iommu_group *group, struct device *dev)
> >   {
> > -	struct iommu_domain *domain = data;
> > -
> > -	lockdep_assert_held(&dev->iommu_group->mutex);
> > -
> > -	if (iommu_is_attach_deferred(dev)) {
> > -		dev->iommu->attach_deferred = 1;
> > -		return 0;
> > -	}
> > -
> > -	return __iommu_attach_device(domain, dev);
> > +	return __iommu_device_set_domain(group, dev, group->domain,
> > +					 IOMMU_SET_DOMAIN_WITH_DEFERRED);
> 
> Just out of curiosity, why is this group->domain instead of
> group->default_domain?

The overall invariant is that all devices are attached to
group->domain, whatever it is.

Devices are not attached to the default_domain, the default_domain is
made the current group->domain which changes all the devices.

Eventually the caller is made to look like:

        if (group->domain) {
                ret = iommu_group_do_dma_first_attach(group, dev);
                if (ret)
                        goto err_unlock;
                iommu_create_device_direct_mappings(group->domain, dev);
        } else if (!group->default_domain) {
                ret = iommu_setup_default_domain(group, 0);
                if (ret)
                        goto err_unlock;
        }

Which makes it clear we can't assume that default_domain == domain at
this point.

> > @@ -449,7 +445,7 @@ int iommu_probe_device(struct device *dev)
> >   	 * attach the default domain.
> >   	 */
> >   	if (group->default_domain && !group->owner) {
> > -		ret = iommu_group_do_dma_first_attach(dev, group->default_domain);
> > +		ret = iommu_group_do_dma_first_attach(group, dev);
> >   		if (ret) {
> >   			mutex_unlock(&group->mutex);
> >   			iommu_group_put(group);
> > @@ -1117,7 +1113,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
> >   	mutex_lock(&group->mutex);
> >   	list_add_tail(&device->list, &group->devices);
> >   	if (group->domain)
> > -		ret = iommu_group_do_dma_first_attach(dev, group->domain);
> > +		ret = iommu_group_do_dma_first_attach(group, dev);
> 
> I am wondering whether we need to do dma first attach here.

Correct, this is wonky - I fix this in the followup series.

Jason

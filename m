Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6ADC433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 12:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8953040A01;
	Mon, 21 Mar 2022 12:41:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N5G0JDfcRNmQ; Mon, 21 Mar 2022 12:41:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48E6F4091E;
	Mon, 21 Mar 2022 12:41:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE6BBC0012;
	Mon, 21 Mar 2022 12:41:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A29B7C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 12:41:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 915E860E9A
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 12:41:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KxlK-62_VZsY for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 12:41:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::609])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED14E60B52
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 12:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0TZsmGXHVaMFPANXP2K4Cng+u6VYNak5cupPQksawxvQLZPhh3uOZpryF5WhWvIoXrX+tgSvio0flzPWvsDRqKdb6vrr3i6TWyK9FkwZTd8UjYWcGgtUo3DLXZ7LlTCj5Zq4koXnY+EMqnoLr+Q9YjivBokWnO8cJMj4UrNRyLffo3N2gZM8SAeIU0fzt6LuKs/B8gPsN1YaTG7LHLmMcTI8+16xv/fVp3U0WNHDnk4DmjT7XF0ZTco/ZFnHZ9ZU9kw0zXATMju0nK8ioUbDHusiVuae8v9npwKrxKXh4aWF3guwN+jSspEF1IrTiBYlyBcHifRCsB5NaINy/65Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU6waVwUPlIbIreWd3UbHo0/aO0EXv64rd8dg+9wLos=;
 b=AnNL8pi3dDicdRPgIE+wOBFH0QuB3yIrMotD4nKZQVY0gXwnY1INb0NHmlup5yKrvf7iLMXHW0660TSRzK7i0L/+wq7PYLd3ruP19tFAISWVbrzA01gcbT+KWsgAa3OSJeCYMDp3l3uC4udgLm1rtGTeVn5xGogG50t2zra6w5IVQVEslRJ9q1fPqN+qdTDsba9vuw+mM4mSajQu5yoXiXwEwal1qiR9wnnwqQNNMRi551q3rFIKLhocANwBUHFeb+yhyUJ7ZTr4VTfQ3A2U2n4pseA5alPXBzAzN+kO3dV8rIUZiHlOOb0qRy5wuMX2T4Ds2EjUoqx+IC4JiCUdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU6waVwUPlIbIreWd3UbHo0/aO0EXv64rd8dg+9wLos=;
 b=f9B+ctfmgiyIvWhBkpC6umeSI3wyzrqaAsVDG6lxy2K73yfEaD/X3RrrtFYbQf0A7ERf82jnUjqt+VqMTZ2Uzz7WAXfXMJAPyH9/24Dgupq3nb4qev+NsYW96tAlS7wLo6xHFIbJ+j5dv434IenH3iFDzCpZfbVFL2+vLOpjIgVGNLHcWfq7tYeVwMvJTTrEEhcQB55StGbY/fDMyAm4v/X4+AkvocEjNybWnJa/r1YBAhZ2Ln48F4z4DQ/N46LhPT85FcP4NPjATRmaNsJhwAA/tDCsnOdHm2w2yUP0hvvz3YDkZ7iiCZHJH5849bcrciwo0p84vqWLrWfUsNY8Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 12:40:59 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 12:40:59 +0000
Date: Mon, 21 Mar 2022 09:40:58 -0300
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC 09/11] iommu: Add iommu_get_domain_for_dev_pasid()
Message-ID: <20220321124058.GO11336@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-10-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220320064030.2936936-10-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0419.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64a60bdf-b6bf-48e5-773d-08da0b380d15
X-MS-TrafficTypeDiagnostic: BN8PR12MB2946:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2946744D5F0B123AAB68E692C2169@BN8PR12MB2946.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZBGSNGhiHJ4tUImoUQ/iPJf+RsiIFmaJ5ft9+3pNzMgAuOg1f4tY7AFqWmYxfKH484qrMFB8fnqsQxJG82GlT3ymf6jJCHvnZbRhrIFJXTqjIWqZguyDZ7YxDJjfykju5rvoeaJgZGpYJgfnAx5wdVD43a6WU5Ch/DLsMUYQtCJS+0A540Ky7/BpWFXJR+rnoLI0kybS+qOj6pLWQgb9Lkh/rLXAHhB6awm6sOb1dEa/ucBBCWPFpoTJTb7zuQtphf6coQjZq7C+SyME07K6Ji3O576dYCQuiGfOFaiFiIG2BGPp10WK0EbcUdgtYXfrgNU34G2xUE8F+lJXQWCWe4zzpmBipPuWnbw+npklVgiaxgheNNEJY38ChXaVf7Oj27GzYHk1ZZKb4YNpgw1MNcbMhYI1TJ7G706WGb3p5YDH2/x3rJFs9L8lfeFYqCLLEDEROKiSUknIy2boP5zsmn3yI7N/BwWrWD+GoqLf5xA8uvDuMrkeQ8gCzMn28RsepD+yizVNt8CnVDc+bgFtm7kBt2skTqsj4mme+lIJ6+o+grlb2RVYVVkmeQz1xx5Ry+QTU+4HnBNfHOmTrZJvqVJz8uS5uNgoVLKzSHCUbiQx6diokjclRWU8gnbr06Hw8V7IYxJXjkoq89uHZOFkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(1076003)(7416002)(8936002)(5660300002)(36756003)(6512007)(6506007)(33656002)(26005)(186003)(83380400001)(508600001)(6486002)(86362001)(54906003)(2906002)(6916009)(316002)(66476007)(66556008)(8676002)(66946007)(4326008)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GG7MiUXG/48xb8nydJrkPW3rBCNXRUQ7fXyLBrxWtxvVctd0XMOcy+RxepmI?=
 =?us-ascii?Q?umFC8IIXP80YP08q++hYW5+/lvqzkHNdpDOpoFx35fhK0/qcfsauxPSkaaOT?=
 =?us-ascii?Q?lt44JISjfKIYRKsf081uk8wdgdyVOmN2rjCUlJ/lPF5l0Dsm42JYhszEfsgN?=
 =?us-ascii?Q?x+w9mo4P4znf5bRPb3LUAwnUc0ZfxX6MkJtxXAvHyswvRm7OTcoqbklK5Bn5?=
 =?us-ascii?Q?G7Ow0q64P0h2R7eAYkwGAm6t2ed99hEFuxHSXrQ8x1WP8o1CXQs1jAySxvAB?=
 =?us-ascii?Q?5jsMJnv1UemkYJZqQQ4otyjqTO07pV6cMygVdshB+820mPPPTCMxm9LzNCMT?=
 =?us-ascii?Q?yRy61stgNsMNS8ETSest2zE9pvWCBX2a/h9KxBiE3U2OBOpHOxDFCksE98RV?=
 =?us-ascii?Q?iYjxdXvCpbUBR6HdOzNYsD4OKBHQSq+6OcNtkuJGa0HmfuQhBngj+ioGZXs8?=
 =?us-ascii?Q?JM0Lc04nCBSnCLLjjVkanUtxov3oQ4a7G+DEeyLcjs+Csg5f1B8WnvIHgNUu?=
 =?us-ascii?Q?1ffr9LXvBmxatGCyZQKXwLLNMp0FfW9bB0bvakhbyVP7Z8wCfpBIMaySpXc7?=
 =?us-ascii?Q?P6rrBfEAbTm0rK1IODUHLzOauSkQeXW539DGOXvXMQhr9l8GyWfOiq+4ugG7?=
 =?us-ascii?Q?HEFhAxcL1HRDWfmuF7jIrwUfUMw90LVRWNn1U16G8ATWLm2BHmCYRAIEk4pB?=
 =?us-ascii?Q?igbx7q0E5iumIZSAnEy+i4LMHUMz666885EKoW+EfFHwzBzIdD2SXP20GSDc?=
 =?us-ascii?Q?8F5M92L5FLAlDv0W0B+a6s4LTM0kPFoOdet8CS4abzTin1BzbapWDLbS2/VI?=
 =?us-ascii?Q?aLZxuw+s5OO3uAaMCAMYU3LB9DTAF1XB1Cowkf63zDJwGphfuFO8cUAzxE/P?=
 =?us-ascii?Q?8jXgRjOgZzR9Yb5oLDU0sfDYVn8gX96HN5UFA6X3IfjGDKHOcdNyyDhyygL6?=
 =?us-ascii?Q?MeDQl/3Fy6KWb/LdJTCfeVE3dQbyIKgxTpVDTNVmBUV0WOEE0C0JRLqRIkIZ?=
 =?us-ascii?Q?887mItZXQoy/YqyUjs+rzEKnLuxwBjaa1wtRiXeYelOfDKK2VnQ8khHA4IX2?=
 =?us-ascii?Q?JVQ8xwiNsvyadNBIj9wOsVp8yOr6MjHV7KnO/vEa691As1774ebUwupXs0eq?=
 =?us-ascii?Q?nXP264KDZlZMD9zzByGNk4DPCOR9CFlWWDR8I9c2UzFziYmu8gJAyJLaxWrk?=
 =?us-ascii?Q?CObNwARkATNPl5pahnWhEI8WmUErJ1fEwgo91KiEg0C30Ln/RNpMNgHXgiq5?=
 =?us-ascii?Q?XNbDHy2FUoq1jB/glOF4CJCS0zMWfMC7siA2+hr7b5QAD0ZHewgiUFunKtX4?=
 =?us-ascii?Q?WHiFTCPGzOzOCd3IcC9CyUCIg22Vt0sLHtV6eSjTFwfD0L5yUxKjfiLvIfhL?=
 =?us-ascii?Q?ENUdtEVaeBrb5kEe9A1Gdd12MSHWrWGjDzGe0XP6epIxsJKWt98IAe9/McON?=
 =?us-ascii?Q?D69g6JJ/ckURsWDZd9NKDg9fSh69jRz6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a60bdf-b6bf-48e5-773d-08da0b380d15
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 12:40:59.3649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0Rux7X1Aq9i3YlXQhemhBerz9SiZXKanJ8Vikc3Je87bsHqF7uYvhgh5Bv2Ns3p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2946
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Sun, Mar 20, 2022 at 02:40:28PM +0800, Lu Baolu wrote:
> @@ -3098,7 +3101,16 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>  	if (iommu_group_device_count(group) != 1)
>  		goto out_unlock;
>  
> +	xa_lock(&group->pasid_array);
> +	curr = __xa_cmpxchg(&group->pasid_array, pasid, NULL,
> +			    domain, GFP_KERNEL);
> +	xa_unlock(&group->pasid_array);
> +	if (curr)

curr can be an xa_err that should be propogated.

> +		goto out_unlock;
> +
>  	ret = domain->ops->attach_dev_pasid(domain, dev, pasid);
> +	if (ret)
> +		xa_erase(&group->pasid_array, pasid);
>  
>  out_unlock:
>  	mutex_unlock(&group->mutex);
> @@ -3118,6 +3130,25 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
>  
>  	mutex_lock(&group->mutex);
>  	domain->ops->detach_dev_pasid(domain, dev, pasid);
> +	xa_erase(&group->pasid_array, pasid);
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +}
> +
> +struct iommu_domain *
> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_domain *domain;
> +	struct iommu_group *group;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return NULL;
> +
> +	mutex_lock(&group->mutex);
> +	domain = xa_load(&group->pasid_array, pasid);
>  	mutex_unlock(&group->mutex);
>  	iommu_group_put(group);

This whole API seems sketchy - what is the lifecycle of the returned
iommu_domain and what prevents it from being concurrently freed after
unlocking?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

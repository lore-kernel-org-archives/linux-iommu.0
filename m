Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCB9C433F5
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 19:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAE5684227;
	Wed, 18 May 2022 19:32:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fXPylWNN_TNM; Wed, 18 May 2022 19:32:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A2C548422D;
	Wed, 18 May 2022 19:32:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72578C0039;
	Wed, 18 May 2022 19:32:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A547C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 19:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E2FD4099A
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 19:32:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x4eGtuyEFKZm for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 19:32:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7AB61404CA
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 19:32:18 +0000 (UTC)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IJLGa1030132;
 Wed, 18 May 2022 19:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Fxe9aFY6Nh0q0LOoEm4xDtM6/ML7j5wLwRhhzHMj8mA=;
 b=XCpjpjO4mfe0V1Eum7BaFcM+buxPuEG95dROzvWU6LpS1Sj34P2n2NMF1XQWfNT51Ard
 EA9LWAxhfQAVpZqbaTMaKIFeLOc4uHzEer3YZlc8J791dExy45GtAFvJWNv9/9uYC+M8
 eA/3XugphfHVmL3oW3Je5HuOjLZ9Dx3ke83yvc9VkfLgdf1A6DBcZSRoCIXXN1hEvLxR
 f5rkeBacJtbzwG6xx5HJNXTTbLb/qJEKNJPm353FzB3DCmG9qubWQ0LSb/L5bQZFK1+n
 MIivH13T8Ddi73oIPytuyMXlsxg07tcfCz1LiqS7JL1MIZx1Ld7RjO63nlOk/AvKGH/V vg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g56vt86hj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 May 2022 19:32:07 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24IJPNeN013820;
 Wed, 18 May 2022 19:32:06 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g56vt86hc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 May 2022 19:32:06 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24IJSll7019608;
 Wed, 18 May 2022 19:32:05 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma04wdc.us.ibm.com with ESMTP id 3g4wp5bcjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 May 2022 19:32:05 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 24IJW5w933816928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 May 2022 19:32:05 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 522EB124053;
 Wed, 18 May 2022 19:32:05 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FE88124052;
 Wed, 18 May 2022 19:32:02 +0000 (GMT)
Received: from farman-thinkpad-t470p (unknown [9.211.132.11])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 18 May 2022 19:32:01 +0000 (GMT)
Message-ID: <11018cc1a74293684247775b73459a1ca0e9499a.camel@linux.ibm.com>
Subject: Re: [PATCH v3] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
From: Eric Farman <farman@linux.ibm.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
Date: Wed, 18 May 2022 15:32:00 -0400
In-Reply-To: <20220518191446.GU1343366@nvidia.com>
References: <0-v3-db7f0785022b+149-iommu_dma_block_jgg@nvidia.com>
 <183e155eae268c32e7d02f68846250702fe99065.camel@linux.ibm.com>
 <20220518191446.GU1343366@nvidia.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: or0f3ufRBKqWuLI81cqmLCngF1qhUKin
X-Proofpoint-ORIG-GUID: waVDdFR_nlEopQVE8f-_R5xEXgJG2S-i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180110
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Robin Murphy <robin.murphy@arm.com>, Qian Cai <quic_qiancai@quicinc.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, 2022-05-18 at 16:14 -0300, Jason Gunthorpe wrote:
> On Wed, May 18, 2022 at 02:50:36PM -0400, Eric Farman wrote:
> 
> > I got a heads up from Matt about the s390 KVM vfio- variants
> > failing on
> > linux-next.
> > 
> > For vfio-ap and vfio-ccw, they fail on the above error. Both calls
> > to
> > __iommu_domain_alloc fail because while dev->dev->bus is non-NULL
> > (it
> > points to the mdev bus_type registered in mdev_init()), the bus-
> > > iommu_ops pointer is NULL. Which makes sense; the iommu_group is
> > > vfio-
> > noiommu, via vfio_register_emulated_iommu_dev(), and mdev didn't
> > establish an iommu_ops for its bus.
> 
> Oh, I think this is a VFIO problem, the iommu layer should not have
> to
> deal with these fake non-iommu groups.
> 
> From 9884850a5ceac957e6715beab0888294d4088877 Mon Sep 17 00:00:00
> 2001
> From: Jason Gunthorpe <jgg@nvidia.com>
> Date: Wed, 18 May 2022 16:03:34 -0300
> Subject: [PATCH] vfio: Do not manipulate iommu dma_owner for fake
> iommu groups
> 
> Since asserting dma ownership now causes the group to have its DMA
> blocked
> the iommu layer requires a working iommu. This means the dma_owner
> APIs
> cannot be used on the fake groups that VFIO creates. Test for this
> and
> avoid calling them.
> 
> Otherwise asserting dma ownership will fail for VFIO mdev devices as
> a
> BLOCKING iommu_domain cannot be allocated due to the NULL iommu ops.
> 
> Fixes: 0286300e6045 ("iommu: iommu_group_claim_dma_owner() must
> always assign a domain")
> Reported-by: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Ah, nice. That takes care of it for me, thank you!

Tested-by: Eric Farman <farman@linux.ibm.com>

> ---
>  drivers/vfio/vfio.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> I think this will have to go through Alex's tree due to all the other
> rework
> in this area.
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index cfcff7764403fc..f5ed03897210c3 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -927,7 +927,8 @@ static void __vfio_group_unset_container(struct
> vfio_group *group)
>  		driver->ops->detach_group(container->iommu_data,
>  					  group->iommu_group);
>  
> -	iommu_group_release_dma_owner(group->iommu_group);
> +	if (group->type == VFIO_IOMMU)
> +		iommu_group_release_dma_owner(group->iommu_group);
>  
>  	group->container = NULL;
>  	group->container_users = 0;
> @@ -1001,9 +1002,11 @@ static int vfio_group_set_container(struct
> vfio_group *group, int container_fd)
>  		goto unlock_out;
>  	}
>  
> -	ret = iommu_group_claim_dma_owner(group->iommu_group, f.file);
> -	if (ret)
> -		goto unlock_out;
> +	if (group->type == VFIO_IOMMU) {
> +		ret = iommu_group_claim_dma_owner(group->iommu_group,
> f.file);
> +		if (ret)
> +			goto unlock_out;
> +	}
>  
>  	driver = container->iommu_driver;
>  	if (driver) {
> @@ -1011,7 +1014,9 @@ static int vfio_group_set_container(struct
> vfio_group *group, int container_fd)
>  						group->iommu_group,
>  						group->type);
>  		if (ret) {
> -			iommu_group_release_dma_owner(group-
> >iommu_group);
> +			if (group->type == VFIO_IOMMU)
> +				iommu_group_release_dma_owner(
> +					group->iommu_group);
>  			goto unlock_out;
>  		}
>  	}

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

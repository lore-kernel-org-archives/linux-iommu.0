Return-Path: <SRS0=DRkM=JE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27036C433B4
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 09:37:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3536128D
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 09:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3536128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 897138183D;
	Wed,  7 Apr 2021 09:37:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t53evgJbZYvx; Wed,  7 Apr 2021 09:37:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F58F83A82;
	Wed,  7 Apr 2021 09:37:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47D26C000C;
	Wed,  7 Apr 2021 09:37:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D240C000A
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 09:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39C2440345
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 09:34:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h8swGErauA2P for <iommu@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 09:34:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01AA14043B
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 09:33:42 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FFfJs2YhXzPnwK;
 Wed,  7 Apr 2021 17:30:53 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 17:33:28 +0800
Subject: Re: [PATCH v12 01/13] vfio: VFIO_IOMMU_SET_PASID_TABLE
To: Eric Auger <eric.auger@redhat.com>
References: <20210223210625.604517-1-eric.auger@redhat.com>
 <20210223210625.604517-2-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <d0f254c3-0b63-e4d3-1f58-8940adc7c0bf@huawei.com>
Date: Wed, 7 Apr 2021 17:33:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210223210625.604517-2-eric.auger@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, vivek.gautam@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com, jean-philippe@linaro.org, wangxingang5@huawei.com,
 maz@kernel.org, jiangkunkun@huawei.com, vsethi@nvidia.com,
 zhangfei.gao@linaro.org, will@kernel.org, alex.williamson@redhat.com,
 wanghaibin.wang@huawei.com, linux-kernel@vger.kernel.org,
 lushenming@huawei.com, iommu@lists.linux-foundation.org, robin.murphy@arm.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Eric,

On 2021/2/24 5:06, Eric Auger wrote:
> +/*
> + * VFIO_IOMMU_SET_PASID_TABLE - _IOWR(VFIO_TYPE, VFIO_BASE + 18,
> + *			struct vfio_iommu_type1_set_pasid_table)
> + *
> + * The SET operation passes a PASID table to the host while the
> + * UNSET operation detaches the one currently programmed. Setting
> + * a table while another is already programmed replaces the old table.

It looks to me that this description doesn't match the IOMMU part.

[v14,05/13] iommu/smmuv3: Implement attach/detach_pasid_table

|	case IOMMU_PASID_CONFIG_TRANSLATE:
|		/* we do not support S1 <-> S1 transitions */
|		if (smmu_domain->s1_cfg.set)
|			goto out;

Maybe I've misread something?


Thanks,
Zenghui
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=j2S/=HZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90349C433DB
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 12:57:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2992664E68
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 12:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2992664E68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4E67605ED;
	Tue, 23 Feb 2021 12:57:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PI7TMpJIhPYg; Tue, 23 Feb 2021 12:57:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58B04600C7;
	Tue, 23 Feb 2021 12:57:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 320E6C000A;
	Tue, 23 Feb 2021 12:57:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B977C0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 12:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 29B0C85313
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 12:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ARW-6TYy4mzk for <iommu@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:57:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 92C1785124
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 12:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614085071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ejww2KN9lm9jdMXwKJXUxNSbDO+xho00yxBfGY60kHQ=;
 b=Z5JM1iOxw7XENzneWDBk71LjRuLaFxWj662m94AwUatPh7Z+2BFg347pj6sYj/FvosEXUR
 /6VObk7PHGY6GdTIxWThvlINq2Kh0VTHktv+J3B9Tdswx7z5bczyGZuG3oXG3kOjHTIsE6
 sppOJQje/md42xpyWt/k1N/vWzcrnew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-StTCqMhkNUqtugcRrQksTQ-1; Tue, 23 Feb 2021 07:57:47 -0500
X-MC-Unique: StTCqMhkNUqtugcRrQksTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B85A1005501;
 Tue, 23 Feb 2021 12:57:44 +0000 (UTC)
Received: from [10.36.114.34] (ovpn-114-34.ams2.redhat.com [10.36.114.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 507585D9D0;
 Tue, 23 Feb 2021 12:57:34 +0000 (UTC)
Subject: Re: [PATCH v11 04/13] vfio/pci: Add VFIO_REGION_TYPE_NESTED region
 type
To: Shenming Lu <lushenming@huawei.com>, eric.auger.pro@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 joro@8bytes.org, maz@kernel.org, robin.murphy@arm.com,
 Alex Williamson <alex.williamson@redhat.com>
References: <20201116110030.32335-1-eric.auger@redhat.com>
 <20201116110030.32335-5-eric.auger@redhat.com>
 <2b5031d4-fa1a-c893-e7e4-56c68da600e4@huawei.com>
 <081265c6-a579-6041-5a74-99bf74cc3d5f@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <022eec8e-ae33-720a-b882-d00cc95a2a27@redhat.com>
Date: Tue, 23 Feb 2021 13:57:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <081265c6-a579-6041-5a74-99bf74cc3d5f@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: jean-philippe@linaro.org, Kunkun Jiang <jiangkunkun@huawei.com>,
 vivek.gautam@arm.com, wanghaibin.wang@huawei.com, zhangfei.gao@linaro.org
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

Hi Shenming,

On 2/23/21 1:45 PM, Shenming Lu wrote:
>> +static int vfio_pci_dma_fault_init(struct vfio_pci_device *vdev)
>> +{
>> +	struct vfio_region_dma_fault *header;
>> +	struct iommu_domain *domain;
>> +	size_t size;
>> +	bool nested;
>> +	int ret;
>> +
>> +	domain = iommu_get_domain_for_dev(&vdev->pdev->dev);
>> +	ret = iommu_domain_get_attr(domain, DOMAIN_ATTR_NESTING, &nested);
>> +	if (ret || !nested)
>> +		return ret;
> 
> Hi Eric,
> 
> It seems that the type of nested should be int, the use of bool might trigger
> a panic in arm_smmu_domain_get_attr().

Thank you. That's fixed now.

Best Regards

Eric
> 
> Thanks,
> Shenming
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

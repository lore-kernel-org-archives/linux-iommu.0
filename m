Return-Path: <SRS0=OBKs=IG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541F0C433DB
	for <iommu@archiver.kernel.org>; Mon,  8 Mar 2021 18:12:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E246F652AC
	for <iommu@archiver.kernel.org>; Mon,  8 Mar 2021 18:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E246F652AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D0736F554;
	Mon,  8 Mar 2021 18:12:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4qnRdRk-kN6z; Mon,  8 Mar 2021 18:12:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 896B06F549;
	Mon,  8 Mar 2021 18:12:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68A2EC000A;
	Mon,  8 Mar 2021 18:12:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA3B3C0001
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 18:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB0526F554
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 18:12:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JCzKrwr3MK0B for <iommu@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 18:12:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 04DDE6F549
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 18:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615227162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3PfKhdiqdgUwSWYSwDNbfusFaETS5oAF78BcOmOgew=;
 b=V5HzLVqmBo2IRhyQpvGaToxUDoUjPknV7QOF8m0XaVvSSYyP/zzilLs3PI/YpJRj56zX85
 N8dIJ1YTGHvvZkTQan/yMM99mFk56d3z8RXlL1850dSvnIOyZIqJ652sG3EE6MHm/mwPJ/
 n58/iF5fivE14r1H2WcoV7KtUg8hp0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-LHQEfOXhMzaPdazJnqfR1g-1; Mon, 08 Mar 2021 13:12:40 -0500
X-MC-Unique: LHQEfOXhMzaPdazJnqfR1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1E3980432E;
 Mon,  8 Mar 2021 18:12:35 +0000 (UTC)
Received: from [10.36.112.254] (ovpn-112-254.ams2.redhat.com [10.36.112.254])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29A7D5D756;
 Mon,  8 Mar 2021 18:12:22 +0000 (UTC)
Subject: Re: [PATCH v12 03/13] vfio: VFIO_IOMMU_SET_MSI_BINDING
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210223210625.604517-1-eric.auger@redhat.com>
 <20210223210625.604517-4-eric.auger@redhat.com> <YEIL3qmcRfhUoRGt@myrica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0e23edb9-9923-edb9-ac3d-8fb52d2fe8c6@redhat.com>
Date: Mon, 8 Mar 2021 19:12:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YEIL3qmcRfhUoRGt@myrica>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: kvm@vger.kernel.org, vivek.gautam@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com, wangxingang5@huawei.com, maz@kernel.org,
 jiangkunkun@huawei.com, vsethi@nvidia.com, zhangfei.gao@linaro.org,
 will@kernel.org, alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jean,

On 3/5/21 11:45 AM, Jean-Philippe Brucker wrote:
> Hi,
> 
> On Tue, Feb 23, 2021 at 10:06:15PM +0100, Eric Auger wrote:
>> This patch adds the VFIO_IOMMU_SET_MSI_BINDING ioctl which aim
>> to (un)register the guest MSI binding to the host. This latter
>> then can use those stage 1 bindings to build a nested stage
>> binding targeting the physical MSIs.
> 
> Now that RMR is in the IORT spec, could it be used for the nested MSI
> problem?  For virtio-iommu tables I was planning to do it like this:
> 
> MSI is mapped at stage-2 with an arbitrary IPA->doorbell PA. We report
> this IPA to userspace through iommu_groups/X/reserved_regions. No change
> there. Then to the guest we report a reserved identity mapping at IPA
> (using RMR, an equivalent DT binding, or probed RESV_MEM for
> virtio-iommu).

Is there any DT binding equivalent?

 The guest creates that mapping at stage-1, and that's it.
> Unless I overlooked something we'd only reuse existing infrastructure and
> avoid the SET_MSI_BINDING interface.

Yes at first glance I think this should work. The guest SMMU driver will
continue allocating IOVA for MSIs but I think that's not an issue as
they won't be used.

For the SMMU case this makes the guest behavior different from the
baremetal one though. Typically you will never get any S1 fault. Also
the S1 mapping is static and direct.

I will prototype this too.

Thanks

Eric
> 
> Thanks,
> Jean
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

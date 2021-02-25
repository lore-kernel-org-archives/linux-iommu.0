Return-Path: <SRS0=d1gY=H3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EF3C433E0
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 16:07:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9738764F19
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 16:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9738764F19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C83081A1C;
	Thu, 25 Feb 2021 16:07:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wD9K2eXXqKzD; Thu, 25 Feb 2021 16:07:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B95A8404D;
	Thu, 25 Feb 2021 16:07:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E94DCC000A;
	Thu, 25 Feb 2021 16:07:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56FAAC0001
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 16:07:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 36AD86F817
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 16:07:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VUhvS-Ekzf9l for <iommu@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 16:07:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4CAC46F80E
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 16:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614269226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LjfCkqGhjloMYZKBFmWZZAZ1X89bZmtu6olw3t+15Q=;
 b=JMG5ceaH7c26IUssdZCNq85yGDj6waJ33WEStaDKuDClPbQocr8L7mxd4Bb+rRLRQMTdCw
 TUD0jvJk69JgqvnyTz7iyMIhdd8PKgaoL/3EZxqBJv6K2/J+teHcflTRtzPCcfW+ztrjiM
 RjRihmqiUQLc+8fI+Oj6QyUPNV9E37A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-zc3gSELKMEeARuR0H5u4MA-1; Thu, 25 Feb 2021 11:06:54 -0500
X-MC-Unique: zc3gSELKMEeARuR0H5u4MA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A64AE86A064;
 Thu, 25 Feb 2021 16:06:50 +0000 (UTC)
Received: from [10.36.112.150] (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72AC110013D6;
 Thu, 25 Feb 2021 16:06:39 +0000 (UTC)
Subject: Re: [PATCH v14 00/13] SMMUv3 Nested Stage Setup (IOMMU part)
To: eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, will@kernel.org, maz@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, alex.williamson@redhat.com,
 tn@semihalf.com, zhukeqian1@huawei.com
References: <20210223205634.604221-1-eric.auger@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f99d8af1-425b-f1d5-83db-20e32b856143@redhat.com>
Date: Thu, 25 Feb 2021 17:06:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210223205634.604221-1-eric.auger@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: jean-philippe@linaro.org, wangxingang5@huawei.com, lushenming@huawei.com,
 jiangkunkun@huawei.com, vivek.gautam@arm.com, vsethi@nvidia.com,
 zhangfei.gao@linaro.org
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

Hi Shameer, all

On 2/23/21 9:56 PM, Eric Auger wrote:
> This series brings the IOMMU part of HW nested paging support
> in the SMMUv3. The VFIO part is submitted separately.
> 
> This is based on Jean-Philippe's
> [PATCH v12 00/10] iommu: I/O page faults for SMMUv3
> https://lore.kernel.org/linux-arm-kernel/YBfij71tyYvh8LhB@myrica/T/
> 
> The IOMMU API is extended to support 2 new API functionalities:
> 1) pass the guest stage 1 configuration
> 2) pass stage 1 MSI bindings
> 
> Then those capabilities gets implemented in the SMMUv3 driver.
> 
> The virtualizer passes information through the VFIO user API
> which cascades them to the iommu subsystem. This allows the guest
> to own stage 1 tables and context descriptors (so-called PASID
> table) while the host owns stage 2 tables and main configuration
> structures (STE).
> 
> Best Regards
> 
> Eric
> 
> This series can be found at:
> https://github.com/eauger/linux/tree/v5.11-stallv12-2stage-v14
> (including the VFIO part in its last version: v12)

As committed, I have rebased the iommu + vfio part on top of Jean's
sva/current (5.11-rc4).

https://github.com/eauger/linux/tree/jean_sva_current_2stage_v14

I have not tested the SVA bits but I have tested there is no regression
from my pov.

From the QEMU perspective is works off the shelf with that branch but if
you want to use other SVA related IOCTLs please remind of updating the
linux headers.

Again thank you to all of you who reviewed and tested the previous version.

Thanks

Eric
> 
> The VFIO series is sent separately.
> 
> History:
> 
> Previous version (v13):
> https://github.com/eauger/linux/tree/5.10-rc4-2stage-v13
> 
> v13 -> v14:
> - Took into account all received comments I think. Great
>   thanks to all the testers for their effort and sometimes
>   fixes. I am really grateful to you!
> - numerous fixes including guest running in
>   noiommu, iommu.strict=0, iommu.passthrough=on,
>   enable_unsafe_noiommu_mode
> 
> v12 -> v13:
> - fixed compilation issue with CONFIG_ARM_SMMU_V3_SVA
>   reported by Shameer. This urged me to revisit patch 4 into
>   iommu/smmuv3: Allow s1 and s2 configs to coexist where
>   s1_cfg and s2_cfg are not dynamically allocated anymore.
>   Instead I use a new set field in existing structs
> - fixed 2 others config checks
> - Updated "iommu/arm-smmu-v3: Maintain a SID->device structure"
>   according to the last version
> 
> v11 -> v12:
> - rebase on top of v5.10-rc4
> 
> Eric Auger (13):
>   iommu: Introduce attach/detach_pasid_table API
>   iommu: Introduce bind/unbind_guest_msi
>   iommu/smmuv3: Allow s1 and s2 configs to coexist
>   iommu/smmuv3: Get prepared for nested stage support
>   iommu/smmuv3: Implement attach/detach_pasid_table
>   iommu/smmuv3: Allow stage 1 invalidation with unmanaged ASIDs
>   iommu/smmuv3: Implement cache_invalidate
>   dma-iommu: Implement NESTED_MSI cookie
>   iommu/smmuv3: Nested mode single MSI doorbell per domain enforcement
>   iommu/smmuv3: Enforce incompatibility between nested mode and HW MSI
>     regions
>   iommu/smmuv3: Implement bind/unbind_guest_msi
>   iommu/smmuv3: report additional recoverable faults
>   iommu/smmuv3: Accept configs with more than one context descriptor
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 444 ++++++++++++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  14 +-
>  drivers/iommu/dma-iommu.c                   | 142 ++++++-
>  drivers/iommu/iommu.c                       | 106 +++++
>  include/linux/dma-iommu.h                   |  16 +
>  include/linux/iommu.h                       |  47 +++
>  include/uapi/linux/iommu.h                  |  54 +++
>  7 files changed, 781 insertions(+), 42 deletions(-)
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

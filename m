Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C87C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 10:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 548E283004;
	Tue,  7 Dec 2021 10:22:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f2OOApFqdmtR; Tue,  7 Dec 2021 10:22:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0B0C18300C;
	Tue,  7 Dec 2021 10:22:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D05ADC002F;
	Tue,  7 Dec 2021 10:22:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E69A8C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 10:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB018606C2
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 10:22:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8tBlFQV-itJB for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 10:22:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0A0A60773
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 10:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638872556;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vIblGTzXX40hR9szafjbMCGgx30k6YagvsBGLTnN0YI=;
 b=iFfOarRVgI8cZkql5FIvedwBHmGQMBUSQm9tIli7QHA3GTDnYyOOTAcPggbtGO6N0CaPt/
 dJ7YL7YuB9XJxy+YHrGbFo3ns/or5h3nh6kK8RffoKGog6dTlRvluxCkF3tQkCy20jbbLX
 m+kwVVmEh6RNmLw44vz1UHCrKvPIzDk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-126_3lnFOdC_oaAMhpW2OQ-1; Tue, 07 Dec 2021 05:22:33 -0500
X-MC-Unique: 126_3lnFOdC_oaAMhpW2OQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 l4-20020a05600c1d0400b00332f47a0fa3so1160707wms.8
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 02:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=vIblGTzXX40hR9szafjbMCGgx30k6YagvsBGLTnN0YI=;
 b=IfN40vmTbcOWZLdqjPYm35BgVbeUTlcvrnT1VjPBRVW9fTB/nM2ZVETbgQU63N0mKO
 1modvnl7Ozp8CbVlo4aemqK+33rToOsTi0Mx3y8wJ9X984Ma+amHeh4rX4XYW5YHHpnW
 TLzM6OF4aH1s6TcpcUpvfIPEGqdODhGJLxarHKrHujY76cHZmUQa8ssHKRfY5TgRAcu5
 9/GC4+NTyzBgrp/Djh+MamdIzAWQqedN3PjJWq7lTtKqfmdFDBdfGDtPmSMihAARaiG2
 TDQo6Uy6cIz6OiFSQd1KfGFAK6vEAnaGdUFnzBn25dFPuymEbUXWXEJYdCvABtxK6rAF
 sgmg==
X-Gm-Message-State: AOAM5332KoU25GSkzrT+ckMX66Vrm+DwSzK0lBLQdajxolJ+yWh/HgkK
 nK4n2hUXJQcryBE/Bz/4vMe2fyCon9f1o5iVYnUihf2n2P96/aFVl7XDN8CqEnADLEJGI9+BeL1
 hbQyZIcwF+3jwdj6WcxSHErflYtJerw==
X-Received: by 2002:a05:600c:4f55:: with SMTP id
 m21mr5891530wmq.68.1638872552029; 
 Tue, 07 Dec 2021 02:22:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOgIcH/ywM872FWWEzo4wI3r37JDW61iH1Cfi/iZw3pSmHii9bhQ9WabrWC9ggWBBYhH9xLg==
X-Received: by 2002:a05:600c:4f55:: with SMTP id
 m21mr5891493wmq.68.1638872551786; 
 Tue, 07 Dec 2021 02:22:31 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id k8sm13945681wrn.91.2021.12.07.02.22.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Dec 2021 02:22:31 -0800 (PST)
Subject: Re: [RFC v16 1/9] iommu: Introduce attach/detach_pasid_table API
To: Joerg Roedel <joro@8bytes.org>
References: <20211027104428.1059740-1-eric.auger@redhat.com>
 <20211027104428.1059740-2-eric.auger@redhat.com>
 <Ya3qd6mT/DpceSm8@8bytes.org>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <c7e26722-f78c-a93f-c425-63413aa33dde@redhat.com>
Date: Tue, 7 Dec 2021 11:22:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <Ya3qd6mT/DpceSm8@8bytes.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: peter.maydell@linaro.org, kvm@vger.kernel.org, vivek.gautam@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com,
 jean-philippe@linaro.org, ashok.raj@intel.com, maz@kernel.org,
 vsethi@nvidia.com, zhangfei.gao@linaro.org, kevin.tian@intel.com,
 will@kernel.org, alex.williamson@redhat.com, wangxingang5@huawei.com,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Joerg,

On 12/6/21 11:48 AM, Joerg Roedel wrote:
> On Wed, Oct 27, 2021 at 12:44:20PM +0200, Eric Auger wrote:
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
>> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> This Signed-of-by chain looks dubious, you are the author but the last
> one in the chain?
The 1st RFC in Aug 2018
(https://lists.cs.columbia.edu/pipermail/kvmarm/2018-August/032478.html)
said this was a generalization of Jacob's patch


  [PATCH v5 01/23] iommu: introduce bind_pasid_table API function


  https://lists.linuxfoundation.org/pipermail/iommu/2018-May/027647.html

So indeed Jacob should be the author. I guess the multiple rebases got
this eventually replaced at some point, which is not an excuse. Please
forgive me for that.
Now the original patch already had this list of SoB so I don't know if I
shall simplify it.


>
>> +int iommu_uapi_attach_pasid_table(struct iommu_domain *domain,
>> +				  void __user *uinfo)
>> +{
> [...]
>
>> +	if (pasid_table_data.format == IOMMU_PASID_FORMAT_SMMUV3 &&
>> +	    pasid_table_data.argsz <
>> +		offsetofend(struct iommu_pasid_table_config, vendor_data.smmuv3))
>> +		return -EINVAL;
> This check looks like it belongs in driver specific code.
Indeed, I will fix that in my next respin :-)

Thanks!

Eric
>
> Regards,
>
> 	Joerg
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

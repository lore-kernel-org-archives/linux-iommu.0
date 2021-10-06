Return-Path: <SRS0=yzib=O2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8CDC4332F
	for <iommu@archiver.kernel.org>; Wed,  6 Oct 2021 09:55:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02DB61058
	for <iommu@archiver.kernel.org>; Wed,  6 Oct 2021 09:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E02DB61058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 94D36403F9;
	Wed,  6 Oct 2021 09:55:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PShVJ6xaRjTv; Wed,  6 Oct 2021 09:55:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 396BF40494;
	Wed,  6 Oct 2021 09:55:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F70EC0011;
	Wed,  6 Oct 2021 09:55:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FE89C0022
 for <iommu@lists.linux-foundation.org>; Wed,  6 Oct 2021 09:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECD4F608D2
 for <iommu@lists.linux-foundation.org>; Wed,  6 Oct 2021 09:55:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HU6KaL6BEjga for <iommu@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 09:55:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 508CD60612
 for <iommu@lists.linux-foundation.org>; Wed,  6 Oct 2021 09:55:39 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id o20so7035904wro.3
 for <iommu@lists.linux-foundation.org>; Wed, 06 Oct 2021 02:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=53P0MWqxHQf69YIQTg7++jhQaclFdr/J2LBfnT7Jxag=;
 b=SyqmL0KIwaYYoAnvxjN3cUgFEI9q0HKr8Ar/pWsMkn9kMDGzeCkwbxNr5N5Kc/UWS7
 qniK5NqdpFiEqx+FSrnniWhRiB36WlBCYKNtzy05dCMjzUyTW9QFNaEZ/f4z9YXH30MO
 IEn+GlPNPbZiWY/3MJ/uJXvLCXC/DyO5mBNQTIQJy/+FRS6AC8YCO7GzAia1tIaS52In
 ZmFzmtuOnaCJYRjB58b+zDAHwub8BWctoYeAeSgPq+1yuZ1lQzB34HrNc4dGrF/+kr4F
 r46OH/pMw/2AQQASBIOLJueH5xJxURZBBbE0SHmAeD1lDV/X9+qdhjVkuRQXODpRNfTK
 jVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=53P0MWqxHQf69YIQTg7++jhQaclFdr/J2LBfnT7Jxag=;
 b=ZOKGwPlM45SWSpwF8l9bQasciMup3l7BWGOdoZYSZqs6pTmHEAOJbkvShwwyb/2UwO
 7LSCZnJ3pDcUyFcNGyNTl/kJBHN4/Q3tp3bY8ePGZdfmkZqqKM2Pn3TKqckPCfbqPQ1L
 Ge8Jb0JbhUjYJllx9BBWPtIlfL9WAyzxqc5bVxm9zAikaZoczy/c5SYnp3umhsR4IyIv
 GoDIf0IeEzxiZZBV5l/7oALdJptdP9fqd7ggyhLSk0s53Pb8Jv5jlpK8pwSBsImMEBxX
 SEPDzJWzZ+3LZeA6NeXnD61lkxWfLfxDIz2SIKQFCiPIaFcsA1uyZE0hTf7FUKmlLUtq
 hhAA==
X-Gm-Message-State: AOAM533T6N6LFqRjGKr8r3jxA2jHEjPBXIKME2yK6ndXBfM8xDl+te3X
 eRCsDFeFS3iOccuhBwj8fVPeIQ==
X-Google-Smtp-Source: ABdhPJzxdeXU89q22gyHmthoWcnGdg9zFvCS0EtqufEuzVaX6IYosj6/AmW+M3t0tXGZdbu/vTLWjg==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr8775367wma.53.1633514137346;
 Wed, 06 Oct 2021 02:55:37 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id o6sm378418wri.49.2021.10.06.02.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Oct 2021 02:55:36 -0700 (PDT)
Date: Wed, 6 Oct 2021 10:55:14 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Kumar Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 10/11] uapi/virtio-iommu: Add a new request type
 to send page response
Message-ID: <YV1ygu5URvuHB4qb@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-11-vivek.gautam@arm.com>
 <YUoFSrAK2gi3GWp/@myrica>
 <d40ea85b-3612-10b3-0add-40d07e6d9ca5@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d40ea85b-3612-10b3-0add-40d07e6d9ca5@arm.com>
Cc: kevin.tian@intel.com, mst@redhat.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Sep 30, 2021 at 02:54:05PM +0530, Vivek Kumar Gautam wrote:
> > > +struct virtio_iommu_req_page_resp {
> > > +	struct virtio_iommu_req_head		head;
> > > +	__le32					domain;
> > 
> > I don't think we need this field, since the fault report doesn't come with
> > a domain.
> 
> But here we are sending the response which would be consumed by the vfio
> ultimately. In kvmtool, I am consuming this "virtio_iommu_req_page_resp"
> request in the virtio/iommu driver, extracting the domain from it, and using
> that to call the respective "page_response" ops from "vfio_iommu_ops" in the
> vfio/core driver.
> 
> Is this incorrect way of passing on the page-response back to the host
> kernel?

That works for the host userspace-kernel interface because the device is
always attached to a VFIO container.

For virtio-iommu the domain info is redundant. The endpoint information
needs to be kept through the whole response path in order to target the
right endpoint in the end. In addition the guest could enable PRI without
attaching the endpoint to a domain, or fail to disable PRI before
detaching the endpoint. Sure it's weird, but the host can still inject the
recoverable page fault in this case, and the guest answers with "invalid"
status but no domain. We could mandate domains for recoverable faults but
that forces a synchronization against attach/detach and I think it
needlessly deviates from other IOMMUs.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

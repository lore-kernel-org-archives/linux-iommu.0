Return-Path: <SRS0=uIbQ=ID=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED38FC433E6
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 10:46:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655E564FEE
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 10:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655E564FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 099AB432F6;
	Fri,  5 Mar 2021 10:46:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0bb202p2U4a8; Fri,  5 Mar 2021 10:46:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id E76A5432E9;
	Fri,  5 Mar 2021 10:46:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF1B3C000B;
	Fri,  5 Mar 2021 10:46:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5542AC0001
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 10:46:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 438FA6FB5B
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 10:46:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kcrPpfytqLUo for <iommu@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 10:46:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64B0D6ECE9
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 10:46:14 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id u125so1022197wmg.4
 for <iommu@lists.linux-foundation.org>; Fri, 05 Mar 2021 02:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QYcloRQYqoQYeneB9TUL5LWRoYdegubdAgTSoIagbwI=;
 b=l1f+UOwIgVlt828ar7VR0vnkFXh4cRc5C417MtipeTaqlFL9hi+QxQf/kRpJECja4M
 b1VgvXtLOV2KpkBB58JtxLb1r7x39cua/HRZI9XXxtgnnfrWNKNfRFRTEas45fO773zY
 7mJT+4G1Sc+QLV2KsJ35V7xN27sbUzT0B7bZHtGhOQSugEZHgtKaZ8IjZJJY8KECnj/e
 NDxYvkkIxMp0CEG5YQG2rPAaxqFREGuonfLmWbqP9a2as8Ty/JDljoFuQmk5w49uAPkM
 S2mRfInX6LS/JeefCGRhe0mbClkNBjicwLmnvj5wLTXA7t3Uwhc3PfpgO3P27y1rnfyj
 Tanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QYcloRQYqoQYeneB9TUL5LWRoYdegubdAgTSoIagbwI=;
 b=T6dP4qfiMsbBl3TxJzOKkb2aOkDzA3QST5bTTD12qp1PlajVObx7Rvhv5lQFfUbQLR
 Ts4pEgJauAzf9/LriaikpfNelA8ixkHHCaOjNepu0aWJGpGcQzIftnr7zH7bCZ/5MBK3
 ziOkvTp/FxsivY9cNDXJIDm1hc3g6G9d/m0tQzZszX5WZkcyvS0jDxXkN27ZD15by8NX
 DlJC3bl30t/UkWjIMxIgUG1YH6E2RyrFR4GCqLNUlKvcHYnsyXHvnw+dZTztS2wFh1EB
 oLvCuTd0Supc9AQcQHH/r/cRfp2K0BkN5nHw4XqKs8RsRCzb6w2ZrsUxCZtBu0NaBV50
 oVMQ==
X-Gm-Message-State: AOAM531IVmoKH3XiOzdr+0bXzC+yxVuOegXomWGqoQVo52HBI6XTliSy
 ApkE2yh0KULVtDCUBNzM5vY+Tw==
X-Google-Smtp-Source: ABdhPJyPsHNdCZQ/LIRLnpXLb4jgGrGPiuq6+S8OtX5p5lHKSRBR7HyNChZTX5gDnxX/xPZN/4jXLA==
X-Received: by 2002:a1c:2049:: with SMTP id g70mr8213376wmg.7.1614941172536;
 Fri, 05 Mar 2021 02:46:12 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id o11sm4083278wrq.74.2021.03.05.02.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Mar 2021 02:46:12 -0800 (PST)
Date: Fri, 5 Mar 2021 11:45:50 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v12 03/13] vfio: VFIO_IOMMU_SET_MSI_BINDING
Message-ID: <YEIL3qmcRfhUoRGt@myrica>
References: <20210223210625.604517-1-eric.auger@redhat.com>
 <20210223210625.604517-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210223210625.604517-4-eric.auger@redhat.com>
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

Hi,

On Tue, Feb 23, 2021 at 10:06:15PM +0100, Eric Auger wrote:
> This patch adds the VFIO_IOMMU_SET_MSI_BINDING ioctl which aim
> to (un)register the guest MSI binding to the host. This latter
> then can use those stage 1 bindings to build a nested stage
> binding targeting the physical MSIs.

Now that RMR is in the IORT spec, could it be used for the nested MSI
problem?  For virtio-iommu tables I was planning to do it like this:

MSI is mapped at stage-2 with an arbitrary IPA->doorbell PA. We report
this IPA to userspace through iommu_groups/X/reserved_regions. No change
there. Then to the guest we report a reserved identity mapping at IPA
(using RMR, an equivalent DT binding, or probed RESV_MEM for
virtio-iommu). The guest creates that mapping at stage-1, and that's it.
Unless I overlooked something we'd only reuse existing infrastructure and
avoid the SET_MSI_BINDING interface.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

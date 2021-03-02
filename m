Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C12C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 10:44:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE54764F07
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 10:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE54764F07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 82755430A5;
	Tue,  2 Mar 2021 10:44:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vqFSmt5Z8jni; Tue,  2 Mar 2021 10:44:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 935B4430A4;
	Tue,  2 Mar 2021 10:44:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F732C000A;
	Tue,  2 Mar 2021 10:44:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A2F8C0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 10:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DEF9F6F593
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 10:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R7Z66X_kJDAM for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 10:43:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4CD86F477
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 10:43:59 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id f12so15513157wrx.8
 for <iommu@lists.linux-foundation.org>; Tue, 02 Mar 2021 02:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8fJXMvjxuLDN6bYz0lZym+t1q3/86XVS/pchijcoEVo=;
 b=BSmT+MRdC2Gz86qjV7VPEXzzBopRQ8WplkLVUfh1pECy7yCQRr7+i65WPII2xYcExs
 C3Iopvu1EQmgd87vvjwruLy2aw86vBQNqxt1WhKC/OevwP9WYa4/otAO7y5Bv4Qd6EJH
 Yy0dMKQ3s9AIUfSWWH9cZl8eZ0NHh/bK8aUfuDHbbZ+CmPq8v1KD0zb/BRRCJLsNNzxc
 wwTQ65Hb9JUTEOzIXpI6jflgeKE3ptsWZwYfD/ENTjcLAbsiEyI1zpLPB476q98x3kjn
 3ZHX52999srZNjEzwgqLVWHc5JwOMxMNQsJLtTD9DJGuM61G7xuWpi3oXNeH2VFuiuaG
 j8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8fJXMvjxuLDN6bYz0lZym+t1q3/86XVS/pchijcoEVo=;
 b=Oe1vLp5quThTGS/mwXGwwHxQ91/xKdJ7d1i645QBOzBhHZTerg6qDsyNTQBCD62oh/
 ZrHRHaZ8tJljJJrm80mTSIvHr/tKkQWGig7eqc7hNKuhxz1gtEheFYrGDrbeD7Yd1trs
 kzgWGmnM5RlAE7zyFpXm/zuiy7wtC9kkQd/ORgs1ESZUIOe0UtltBWyPZkjw8QrebSt/
 vKeMt5B+tLLr3SzWFayBo7AGmrrjOQQCvWWMNSAkGfeT0EI0Re4uArdWHFXrFbjwhw13
 75vMZxIOy9MIw4PR0wB0gb+MJuaUhybW1RXfV/xqvEPkbKPjI/8eli6T/LFoYoq2A+n9
 3iiA==
X-Gm-Message-State: AOAM530aiXAdz25T0YNgfawQh3vhWYLv2ctDAfGkMNOXb7MkojCTX5Ly
 jtGEXVUrbl75IL8Bo1WgDDXCKA==
X-Google-Smtp-Source: ABdhPJzVmOgttgWE5aqEn9bZKhAUWJarTt1JNgnA3PjQJT6fyIa7wE85W61yCc7ilp3btYLG3uqQiw==
X-Received: by 2002:a5d:4141:: with SMTP id c1mr22150448wrq.248.1614681837978; 
 Tue, 02 Mar 2021 02:43:57 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id h20sm2220312wmb.1.2021.03.02.02.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Mar 2021 02:43:57 -0800 (PST)
Date: Tue, 2 Mar 2021 11:43:36 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v6 08/12] fork: Clear PASID for new mm
Message-ID: <YD4W2GPg4OUFVWty@myrica>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-9-git-send-email-fenghua.yu@intel.com>
 <YDYoL/zZ9YaGgwSV@myrica>
 <YDgh53AcQHT+T3L0@otcwcpicx3.sc.intel.com>
 <20210301150011.766e70a3@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210301150011.766e70a3@jacob-builder>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 zhangfei.gao@foxmail.com, linux-kernel <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org
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

On Mon, Mar 01, 2021 at 03:00:11PM -0800, Jacob Pan wrote:
> > functionality is not a problem without this patch on x86. But I think
> I feel the reason that x86 doesn't care is that mm->pasid is not used
> unless bind_mm is called.

I think vt-d also maintains the global_svm_list, that tells whether a
PASID is already allocated for the mm. The SMMU driver relies only on
iommu_sva_alloc_pasid() for this.

> For the fork children even mm->pasid is non-zero,
> it has no effect since it is not loaded onto MSRs.
> Perhaps you could also add a check or WARN_ON(!mm->pasid) in load_pasid()?
> 
> > we do need to have this patch in the kernel because PASID is per addr
> > space and two addr spaces shouldn't have the same PASID.
> > 
> Agreed.
> 
> > Who will accept this patch?

It's not clear from get_maintainers.pl, but I guess it should go via
linux-mm. Since the list wasn't cc'd on the original patch, I resent it.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

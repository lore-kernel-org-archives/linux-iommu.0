Return-Path: <SRS0=ZOt4=IV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FF6C433DB
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 10:51:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7152A619BA
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 10:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7152A619BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 368E840377;
	Tue, 23 Mar 2021 10:51:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id udNmuHrGlBi3; Tue, 23 Mar 2021 10:51:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0E4D340374;
	Tue, 23 Mar 2021 10:51:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E30EFC000B;
	Tue, 23 Mar 2021 10:51:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 279E2C0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 10:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0795D60825
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 10:51:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oCdLEsRS00Ya for <iommu@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 10:51:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3BA016068A
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 10:51:33 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id x13so20249855wrs.9
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 03:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+Rm0Eb8opKfQYfpYJDV6Y/tLoSsGpuasG3Yqocn/+wk=;
 b=V460lnV5MQidZ9drlcjju5WKgJWJ4lnAjSvh4/bhA7gqTaBNKu/P50bMFcOlFlrU7g
 3P86p+Fu68NyIPOW6b4N8XvzWPnCOTY6oZwtBN2Wf+NgPRcoOPEXv09i7CGCthKYzz7Q
 +2bT1OTMMIFjDijjUEbJzYNAI2vPkJKcx9en6iPxWyCstDTPrAZK/0H+aaqxy7mtozAY
 50RoU1cq+m0ZD6XgKgFW0T9uHDQvo1V1SjLjjDCd6CRjw8ljVzwPH7DUOTdB5hVFWKQL
 MF7jHtAqOqvXQrpLdx5fWEgKm/rKTmC/YjI/QejxGrLeDYZHCag93xqYU640uNPkcZuZ
 /AUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+Rm0Eb8opKfQYfpYJDV6Y/tLoSsGpuasG3Yqocn/+wk=;
 b=cUn0Nt0DDVoG/dT/UexciuCW/+1X1GDeelzpj1FHfZAx9FJa76SUT7332qrs1LD8v3
 ZP1Xs2o3PeSWeQpc3ttn4ujFIEQXHsBFcY3ggWk2Fx4I6UPb2w1YiBdkG3+lKXaKcylD
 goy8BsktI2i1t6laWEJg8EreP3xq04+RlMTi2096x4W+73K3Z3Owcclv6f1+8AcKKc7Y
 EJks0vItBTkUOeEbAkL6vgQVr6aPL6K3+EXn4uPVN1cQa7kYzHbcMU02KqO40lQmmZtv
 avoWAviSLJISV1QJQLDbWWgBdPUUu7abMXX1YbPQuuqmvHE34k5fLBCqTowmf64P3WSj
 4ilg==
X-Gm-Message-State: AOAM531FAYx5rlSUkz2+O7uKbc088zSGHlw0YpuTsobY6NSWNxmiNaBE
 v+0or/9waesWfv4mzD4XrRcEeg==
X-Google-Smtp-Source: ABdhPJyEzvSO/OvPPWnDWPmPBfRqF7mbRvT971F7XWqd4tOlJNGs3xw7PhQkeJHkjfLb3M4W8l8jRg==
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr3314660wrr.425.1616496691557; 
 Tue, 23 Mar 2021 03:51:31 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s16sm22887746wru.91.2021.03.23.03.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Mar 2021 03:51:31 -0700 (PDT)
Date: Tue, 23 Mar 2021 11:51:13 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v13 06/10] iommu: Add a page fault handler
Message-ID: <YFnIIYW0aMdGXuS/@myrica>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
 <20210302092644.2553014-7-jean-philippe@linaro.org>
 <15ff4704-0fbd-243f-8e49-a9523ae63ce6@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <15ff4704-0fbd-243f-8e49-a9523ae63ce6@linux.intel.com>
Cc: vivek.gautam@arm.com, guohanjun@huawei.com, will@kernel.org,
 Ashok Raj <ashok.raj@intel.com>, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
 robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org
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

On Wed, Mar 03, 2021 at 01:27:34PM +0800, Lu Baolu wrote:
> I have tested this framework with the Intel VT-d implementation. It
> works as expected. Hence,
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks!

> One possible future optimization is that we could allow the system
> administrators to choose between handle PRQs in a workqueue or handle
> them synchronously. One research discovered that most of the software
> latency of handling a single page fault exists in the schedule part.
> Hence, synchronous processing will get shorter software latency if PRQs
> are rare and limited.

Yes, the risk is that processing a fault synchronously will take too much
time, leading to PRI queue overflow if the IOMMU keeps receiving page
faults. That's why I opted for the workqueue initially, but it's
definitely something we can tweak

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

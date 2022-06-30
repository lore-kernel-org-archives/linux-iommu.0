Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA31C43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 09:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4551840A87;
	Thu, 30 Jun 2022 09:59:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4551840A87
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=b/EZPJfC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XQ024VeWPcW1; Thu, 30 Jun 2022 09:59:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0103C40232;
	Thu, 30 Jun 2022 09:59:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0103C40232
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA399C002D;
	Thu, 30 Jun 2022 09:59:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84D70C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55AC441BAF
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:59:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 55AC441BAF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=b/EZPJfC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RPre2ZDKKTRg for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 09:59:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30A1240912
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30A1240912
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:59:17 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id i1so21978249wrb.11
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 02:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1HMqmjT/Hl6eEoSqluU6kzXOVYJu96vbsB8yRH3pJM0=;
 b=b/EZPJfCnVquS1NkGq9KsRSBoCZWR7XOtN+NA+DS6Z90ExfXr1goihQkGLPJKgOpGD
 E41Z7SVhSHeZcyHhReeC5glNz/sMI+cacocAN+FidqgorPd7cmOUipobq8s3bUis9MnM
 qN2to17GprO8783SMo6neHc53795eruPe6diqQbC/ekLR3M7MhW1cfyEJ61Rna83MVqL
 6nlD9F4GRvs/uFvHk2Aa7rCsMyacwzeNcrwQP2n8ntFdc8CqWzQNfHv8NM6Zm86Kj1zY
 ZlVEd7Aoikx9hXwEINGCgvU2Uf2TgLEm2ZqLLW9EV0ImXR0vBTs6xYbWLT8QCxzhNWPs
 qFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1HMqmjT/Hl6eEoSqluU6kzXOVYJu96vbsB8yRH3pJM0=;
 b=z4Fecqg/dr7o23cmoZTNeeghhGjbAKQ9qLT02fRXrEkPY3/WnBoJqHVInfFeRzgcRy
 Sye4D8F7tDi+khSkjgSZ6coZJWcO1wm/Nc3ANsf52eBOJ4V4xWFZA7NcH8sV56ApW/Cs
 cf/TBogiauv8BbKUdpC0u1At2rs3YAjD0DF625xYfH0hlsvOsC9dQ+l4wwN7EAfNSUdE
 7WXe7Q6aoojjjDugKuC1I+Mkh8UoyKgBeuJ1NqFh7fDvFlkUitaPstNIKo97hyiXktK0
 P8GTEMvqQodDpCF6atfmWg4Rf9d2bH1eZrghqsUMdkaGs4u0YbtQ7r+5rStBbvPWrbSZ
 knmQ==
X-Gm-Message-State: AJIora8ok55DYASN7BKWEWHWVEbktXzMd6TvnxbQVhWnIUctZA0QiD4H
 WqdGPDevqLIHVQ+xVag99ho6Og==
X-Google-Smtp-Source: AGRyM1vfHfveCYpKUn92Ua/tYhN63FUv0q/bxKLp7QoY98RJ551Y0CyHmJgnGxT6j3AABaTfE3i9OA==
X-Received: by 2002:adf:d1ca:0:b0:21b:a81c:47f3 with SMTP id
 b10-20020adfd1ca000000b0021ba81c47f3mr7539642wrd.22.1656583155303; 
 Thu, 30 Jun 2022 02:59:15 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 bi18-20020a05600c3d9200b0039c4506bd25sm2572630wmb.14.2022.06.30.02.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jun 2022 02:59:14 -0700 (PDT)
Date: Thu, 30 Jun 2022 10:58:50 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2] ACPI: VIOT: Fix ACS setup
Message-ID: <Yr1z2gC0+8zbzpFf@myrica>
References: <20220630094059.1204283-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220630094059.1204283-1-eric.auger@redhat.com>
Cc: jroedel@suse.de, iommu@lists.linux.dev, jinl@redhat.com, rafael@kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, eric.auger.pro@gmail.com, lenb@kernel.org
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

On Thu, Jun 30, 2022 at 11:40:59AM +0200, Eric Auger wrote:
> Currently acpi_viot_init() gets called after the pci
> device has been scanned and pci_enable_acs() has been called.
> So pci_request_acs() fails to be taken into account leading
> to wrong single iommu group topologies when dealing with
> multi-function root ports for instance.
> 
> We cannot simply move the acpi_viot_init() earlier, similarly
> as the IORT init because the VIOT parsing relies on the pci
> scan. However we can detect VIOT is present earlier and in
> such a case, request ACS. Introduce a new acpi_viot_early_init()
> routine that allows to call pci_request_acs() before the scan.
> 
> While at it, guard the call to pci_request_acs() with #ifdef
> CONFIG_PCI.
> 
> Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Jin Liu <jinl@redhat.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4935C433E0
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 16:36:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E38720758
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 16:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDn/PxtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E38720758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 30E5687E76;
	Mon, 18 May 2020 16:36:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oKCBFGx6NCt5; Mon, 18 May 2020 16:36:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 749A787E59;
	Mon, 18 May 2020 16:36:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A6EBC0881;
	Mon, 18 May 2020 16:36:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E9A2C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 16:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2C44F204AF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 16:36:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N88FA57LojAs for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 16:36:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by silver.osuosl.org (Postfix) with ESMTPS id F270C20474
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 16:36:47 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id y3so12677944wrt.1
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2gB71GDbYw4drdErrFCHDJu6OIFxLC1rGMVvbvndxDM=;
 b=PDn/PxtMfkLDgv/KDv9kB0no5kBMLuhS+qeMDcod8WbYLbhEgkIlgH2u0QFRzcPVOl
 q+awlo77fgxtG8/InLzpp4GGLQGpLlEiXok6uGcW/2hPLhtNyzDv65j8LEsb7LKb91FL
 /05873qUSxmeP3aP/CeuSoF2CSKGIasPqXcq6bkBNvEHYE6U+4ebU86gavemPyFrd8aX
 NIluOhSZEwzye8Yc+0X8snjsraF4P+pCEmcRIx5w7cws889GEJdb55p143NKDwnbn6Ye
 gpxe8iA+sJuxkM1jHcgB2EVidW60koXndSh/pSNwb8s8/rC/w5S5nOIRf80ahCi8J4/m
 AArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2gB71GDbYw4drdErrFCHDJu6OIFxLC1rGMVvbvndxDM=;
 b=e9l0ZHan5cgEN/oTGlMXAt7bXSKQ8Z+tAJC6E4UMEemU67fHYPmfxoLgzrRUa041sc
 VeQYnKRk1kQ1nseamd6C69DzuOjXBD5bcE6oJtQJIC7P/hlHXCmzD0tM97fQGMlehjf7
 KsGhpr7Vt0i4ADqOQ8d7sUPnYyF6b12UpMARNPwt5y7LLbqiDIrHPjAUixUvf6WhJ20r
 Zkh5YsQ/IghYMyKZZYI3kqixtToVrTlwjunVn7Tn453lgkNryNSE11Fngx0bb4rkK5PW
 HFtEQ8OLQ4qTssRqEs0f1KQEuptJ9E0ZJSKeASf3Bt9L901ihULQ/YL2TAgcRrJzISt+
 HUyA==
X-Gm-Message-State: AOAM531sGJNLLTHJZjdekGntU1kwghNZAhw9fORIO517UZgZDO7wg/5y
 7G3tgAteeNwpCgVZa4mR348buw==
X-Google-Smtp-Source: ABdhPJyoblToVYDpynfOZzcoPNIcIPzA/+uGv6r9gM7IsrGshV+QeruKxRwI6mlqXy28BRkRGgWhgA==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr20827860wrp.300.1589819806321; 
 Mon, 18 May 2020 09:36:46 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id 5sm143931wmz.16.2020.05.18.09.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 09:36:45 -0700 (PDT)
Date: Mon, 18 May 2020 18:36:36 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/4] PCI, iommu: Factor 'untrusted' check for ATS
 enablement
Message-ID: <20200518163636.GA1515149@myrica>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
 <20200515154351.GA6546@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200515154351.GA6546@infradead.org>
Cc: ashok.raj@intel.com, linux-pci@vger.kernel.org, alex.williamson@redhat.com,
 iommu@lists.linux-foundation.org, bhelgaas@google.com, will@kernel.org,
 dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org,
 robin.murphy@arm.com
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

On Fri, May 15, 2020 at 08:43:51AM -0700, Christoph Hellwig wrote:
> Can you please lift the untrusted flag into struct device?  It really
> isn't a PCI specific concept, and we should not have code poking into
> pci_dev all over the iommu code.

I suppose that could go in a separate series once other buses need it?
The only methods for setting this bit at the moment apply to PCI ports.
(ACPI ExternalFacingPort and dt external-facing properties declared by
firmware).

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=zuxH=IW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73881C433E0
	for <iommu@archiver.kernel.org>; Wed, 24 Mar 2021 17:22:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135E561A15
	for <iommu@archiver.kernel.org>; Wed, 24 Mar 2021 17:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135E561A15
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8CC940E4D;
	Wed, 24 Mar 2021 17:22:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZY8hYh1iSlEk; Wed, 24 Mar 2021 17:22:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A46B40647;
	Wed, 24 Mar 2021 17:22:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55468C000E;
	Wed, 24 Mar 2021 17:22:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58AA4C000A
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 17:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31C1660690
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 17:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pCjVdkwhVWT7 for <iommu@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 17:22:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D68E46060A
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 17:22:00 +0000 (UTC)
Received: by mail-qt1-x830.google.com with SMTP id f12so18149684qtq.4
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=SrdP9ZidSNfCaSucoColh3TxPDb0AtWOwMrzkk0oHMo=;
 b=VqmHlOv5pk7Z6wF8FHX+TfDJjfjh921rYi4eN41NcDt/fq0DBDJOU7rhGSKU6ufyTm
 xgryyJiAucS8WZzz2ViVbQUPuCpXfg7uEEhpPzzprqcXGMGkBwD6G1BUvjJVBTwjUNRd
 pCXxJXPAOu8fNVQE1dmK+28ONbnNOcRwtDtStbIduQNJhqkB9Esrou8G0LfcvJrhW4fe
 ULycH1dWEtxvx55GhkyZoQPGnapSxw7VUycFCKDpkG8+3sa5snIG53zjQV6wfo7BiGMJ
 HJ9PrsuAPOJka52Tqjh77gZ/r2aV/d7R2K1zypTuv24H1EMPdKj6/CNzp7+bL0NdEvhW
 NVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SrdP9ZidSNfCaSucoColh3TxPDb0AtWOwMrzkk0oHMo=;
 b=p4TpMMRIRDVABz2brnnK9nKktf5RKWPTRBO0WZVQ5sJN2Uwn+sZLPLze3oqDmnpRBP
 5DkX24eBF1iINNFH+Gs+MxM8b6OgwiC02zylwuQKMDulAT4MXZ1gwG3Rh8BWRReHi0kr
 TRtkpSjVlxxHZqeMQ7HlbXCqBSwvXKHn7Gm4sqhDE+13/+xp5FPDGJqJpKf3+kqbMNT4
 3uZoglnzc1mraonzrKExPv94LM4MeCehFD5/VbE6oBM0hs4BLayXsYbijwkv14VI1TWE
 BhTBU4F2isp3eEyJ5nDIphmoDeqBhCTtmT4lGlxQZ90YJUj4UjJmg3zxGbXb6S8szvuB
 e8/w==
X-Gm-Message-State: AOAM5309jcieMsCVpRg7P/jrt18TchMuAeGJjWvg23uRuIQpqOVXl4/l
 4JUaEaApUEEaxavpW/nbCqjz/w==
X-Google-Smtp-Source: ABdhPJyneQA4gaMEWYTu19JnLqKtUSbn29vkpMblQHBkTJsjZw2ELWdLSZfb1xoPTIiUK6qAC7wT3Q==
X-Received: by 2002:ac8:4d02:: with SMTP id w2mr3864955qtv.126.1616606519694; 
 Wed, 24 Mar 2021 10:21:59 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id q125sm2144133qkf.68.2021.03.24.10.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Mar 2021 10:21:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lP7Cf-0025Yq-Vy; Wed, 24 Mar 2021 14:21:58 -0300
Date: Wed, 24 Mar 2021 14:21:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH v2 04/11] PCI/P2PDMA: Introduce
 pci_p2pdma_should_map_bus() and pci_p2pdma_bus_offset()
Message-ID: <20210324172157.GH2710221@ziepe.ca>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-5-logang@deltatee.com>
 <20210313013856.GA3402637@iweiny-DESK2.sc.intel.com>
 <7509243d-b605-953b-6941-72876a60d527@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7509243d-b605-953b-6941-72876a60d527@deltatee.com>
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, linux-pci@vger.kernel.org,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ira Weiny <iweiny@intel.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, linux-block@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>, Jason Ekstrand <jason@jlekstrand.net>,
 John Hubbard <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

On Mon, Mar 15, 2021 at 10:27:08AM -0600, Logan Gunthorpe wrote:

> In this case the WARN_ON is just to guard against misuse of the
> function. It should never happen unless a developer changes the code in
> a way that is incorrect. So I think that's the correct use of WARN_ON.
> Though I might change it to WARN and return, that seems safer.

Right, WARN_ON and return is the right pattern for an assertion that
must never happen:

  if (WARN_ON(foo))
      return -1

Linus wants assertions like this to be able to recover. People runing
the 'panic on warn' mode want the kernel to stop if it detects an
internal malfunction.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

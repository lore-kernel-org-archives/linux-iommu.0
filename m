Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECCFC433EF
	for <iommu@archiver.kernel.org>; Fri, 27 May 2022 12:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E805B84B4F;
	Fri, 27 May 2022 12:55:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y0l9FeGtuM6n; Fri, 27 May 2022 12:55:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D2EFC84B4E;
	Fri, 27 May 2022 12:55:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7787C0032;
	Fri, 27 May 2022 12:55:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0579C002D
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 12:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A78DC41062
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 12:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r8kTgPjEkGhM for <iommu@lists.linux-foundation.org>;
 Fri, 27 May 2022 12:55:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50181404F4
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 12:55:04 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id b200so4784837qkc.7
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 05:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BSsMozD0Lq0iC4EM9lYNlXi49mNRG6l4hCD1Hs5iBXM=;
 b=E1IEYVgSG0+Cp9E27az2DSZCdjooKZRFTIAknVPbxEA24IswYpisrb22a0LCO4Yutp
 4XsJlV3iiAHfEJHOUqZar/+z6eq/RNVnQDFf6R3luEpLOO9ZSoMj2k2S0fC4R/pSwYXU
 DOpBIBWUCslS52Qi/CzJYZEl+JwIDoG+YDkhlb773/e2F0xPQeqxylr+kzCyh268b3ya
 yKVvkB2lJlxnxrNfvpXMgjf4YpupMDYotK/5yJ7lKPpEk0ZuMkyWYAMEIMPhh7qzI2wh
 swLJ7nNqHWA6WZu24/335hmDWzwhZxSHaBFgg7blIZ9gyKzXZY7CMQ39H9PyDicns9IH
 ExdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BSsMozD0Lq0iC4EM9lYNlXi49mNRG6l4hCD1Hs5iBXM=;
 b=rSFgNimpcPkeYmCNXZcE8uAbYUYQ/8ogX62lzFx5MiiTFcFci4zdevVq0wOTjmq/NN
 UTwVYPCMX9TZnY2/VmyS1w2ezhBFFS75eTInG2uLrCrRet+2xeleKKuTNePgbWLLRGt8
 Rilwp3fpEpLxHxtKNKZDLB1tXtmadnh0XBTzEmSW7+KZe5y0owqVSxDiEhv4E/hEO1UG
 eM3EI8izUlpUN8KZC1zRgmALNZhlxqVJVvYObfOF9KZkgmVyD4nHtnns2tovC2N+zyZO
 MxfgmSFeYaNAj6KB7PaGzUMqPTjC0YeYT0p1WG+1srVMnIQda0m8wPMSizeJzW54e3fo
 kfDw==
X-Gm-Message-State: AOAM531BswBx9bOK0P15cl8YKI2ZEwvJiAmy0UVsQXRk1aafwoE+5gjE
 mInWzm5IuYVRGFFqaWKOYOcrCg==
X-Google-Smtp-Source: ABdhPJxcD+5XVE67Aydy9O792T3TtXb3ll0b0WRGBBEtp6VFaNN0UYQTLMiTbm4pLr0b1PVKMYNipA==
X-Received: by 2002:a05:620a:4481:b0:6a3:6326:784 with SMTP id
 x1-20020a05620a448100b006a363260784mr21538514qkp.372.1653656103072; 
 Fri, 27 May 2022 05:55:03 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129]) by smtp.gmail.com with ESMTPSA id
 g5-20020ac87d05000000b002f940249151sm3165272qtb.73.2022.05.27.05.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 May 2022 05:55:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nuZUb-00DTYK-OD; Fri, 27 May 2022 09:55:01 -0300
Date: Fri, 27 May 2022 09:55:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220527125501.GD2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220407154717.7695-21-logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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

On Thu, Apr 07, 2022 at 09:47:16AM -0600, Logan Gunthorpe wrote:
> +static void pci_p2pdma_unmap_mappings(void *data)
> +{
> +	struct pci_dev *pdev = data;
> +	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
> +
> +	/* Ensure no new pages can be allocated in mappings */
> +	p2pdma->active = false;
> +	synchronize_rcu();
> +
> +	unmap_mapping_range(p2pdma->inode->i_mapping, 0, 0, 1);
> +
> +	/*
> +	 * On some architectures, TLB flushes are done with call_rcu()
> +	 * so to ensure GUP fast is done with the pages, call synchronize_rcu()
> +	 * before freeing them.
> +	 */
> +	synchronize_rcu();
> +	pci_p2pdma_free_mappings(p2pdma->inode->i_mapping);

With the series from Felix getting close this should get updated to
not set pte_devmap and use proper natural refcounting without any of
this stuff.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

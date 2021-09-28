Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4FAC433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 20:05:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4841F6044F
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 20:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4841F6044F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB29F405F4;
	Tue, 28 Sep 2021 20:05:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gH4cW1XaItau; Tue, 28 Sep 2021 20:05:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5A226405FB;
	Tue, 28 Sep 2021 20:05:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A43EC0011;
	Tue, 28 Sep 2021 20:05:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA6FCC000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 20:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9CF5D4159D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 20:05:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JufdGB0Lb59Y for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 20:05:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D0D004159E
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 20:05:09 +0000 (UTC)
Received: by mail-qv1-xf2f.google.com with SMTP id x8so99217qvp.1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 13:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cW8g3RMiiX7YozMyBpzJQ3i0X8a1a6uo52SxjKINHuA=;
 b=mXg4nC/0EIy5mcGZgRBdVGh4+PtQ/R7qKfJdIHvckLXvlCgA6RG20VZtoVAC7XwA0/
 1Q9jV1hRPeuiqNHTfiF2xEDf/GmdCrABm9VW4FZUzunFeWsbqWbu0OIpkB0K7pTzfgbd
 6AZsXvNDXNRBaOqQHwB6uloUHcpht9y8ZbZWcpcNkXzVJmyDxhAzyVOeTC4gm52ORmXN
 mB9dfyB6upC6rckPem/56kkVq6mMDb0monvwsJpjKud0G8lLORhrGaRbWZcJi7ULZ9Wj
 5fjO0VyJ8XxtZ4Gi+c3kBFto+M+PTYIof3BPLlQNFsws5BUO2HFuvQyKhOfpgnkZotGZ
 sdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cW8g3RMiiX7YozMyBpzJQ3i0X8a1a6uo52SxjKINHuA=;
 b=quYXto6Bnc0sriIy4oentTAUPbxa4of/2zCmOKUonMB1YeM2mxlMtKiinYKVpOiSao
 z+DxsDweYqTqYbU4m8mN/EJNjV7cAnn0t3ryF9HjDukFTwZr4FuThYA3pu/bBmSdZcE2
 qb9pCBXEybUTOmjBh//dctmeMnlqq2RQsOgndv+Y5zZYK7Ldmk7yHQBscA2HvDWz2+ou
 Yze4eSNKFc12ikdbTRViORWAKhAk/osvxYmsIlmz2LBGC4MNnZTNnIO98NnLjjEM1DcU
 +kbc0KACr37OX0QGYsdlPZhwuXBhzo1kLfrrvFNHyDkc/UcXATmu65Mm1eSZ6eD3wsWL
 /Dzw==
X-Gm-Message-State: AOAM5307V9OcFSqOpFIQ/uGLIL95QlIw+/F/AK4nNqEiINGKONfvaWzx
 CUzuTJvRzSgZ9D0xtyuMLniupw==
X-Google-Smtp-Source: ABdhPJzKbJYaBmt9+b2JfarRag3/wc7athe6CPjiFKF1JovwH1BSJxbPc5yOuJ/qnsZmJUt2zTx5pQ==
X-Received: by 2002:a0c:9043:: with SMTP id o61mr7850968qvo.54.1632859508704; 
 Tue, 28 Sep 2021 13:05:08 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id x125sm118440qkd.8.2021.09.28.13.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 13:05:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVJLe-007GuE-T8; Tue, 28 Sep 2021 17:05:06 -0300
Date: Tue, 28 Sep 2021 17:05:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20210928200506.GX3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-20-logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
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

On Thu, Sep 16, 2021 at 05:40:59PM -0600, Logan Gunthorpe wrote:

> +static void pci_p2pdma_unmap_mappings(void *data)
> +{
> +	struct pci_dev *pdev = data;
> +	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
> +
> +	p2pdma->active = false;
> +	synchronize_rcu();
> +	unmap_mapping_range(p2pdma->inode->i_mapping, 0, 0, 1);
> +	pci_p2pdma_free_mappings(p2pdma->inode->i_mapping);
> +}

If this is going to rely on unmap_mapping_range then GUP should also
reject this memory for FOLL_LONGTERM..

What along this control flow:

> +       error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_unmap_mappings,
> +                                        pdev);

Waits for all the page refcounts to go to zero?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

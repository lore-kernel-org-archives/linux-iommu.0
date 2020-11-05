Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA09AC4741F
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 14:34:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1212078E
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 14:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BpHyF83c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1212078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 23A1686447;
	Thu,  5 Nov 2020 14:34:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jmNm6zU9GzG3; Thu,  5 Nov 2020 14:34:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 07DAA84FB1;
	Thu,  5 Nov 2020 14:34:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDAC0C0893;
	Thu,  5 Nov 2020 14:34:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B416C0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 14:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5AFA987030
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 14:34:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RCVpiJnNE96y for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 14:34:18 +0000 (UTC)
X-Greylist: delayed 20:23:18 by SQLgrey-1.7.6
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3AF8D87010
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 14:34:18 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id i7so1176204qti.6
 for <iommu@lists.linux-foundation.org>; Thu, 05 Nov 2020 06:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=I5rECYk/qu8iCaGcU6CltoiiEiUYjixQTANnN1V5Lm0=;
 b=BpHyF83c8VisTR39W6S5ccfgQByKDmir2lo8vkR5JM3jlQnNqfHGjowVKysk5gpPhK
 n3yULq08kY1GAiqGMRB9cViGD54NkjgicZmuTHbjGHd4p8W3YvAbNV1apoeUoWGJvleo
 iStYaIy2UACtuFhBjWhhB1kBIeW8fP0PWrwozESGAhwPh1ADT0iXE3SBASWtgfJdZeSW
 27x+JBCNX15rSelKQl1Mn2vjkXMLL6LGQcPq6xPi5D3lma2Tb3OUYYatGrDKTE/OILAX
 BQk7LcD1A5qshxOmFxzVxROJjWVpcey/I7oVeqwB+wBWxUTPwukTwcoxwpwYTbu7LC/1
 xixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=I5rECYk/qu8iCaGcU6CltoiiEiUYjixQTANnN1V5Lm0=;
 b=gxdBK8kYrCIr6O2wNFYqOYEi8RzB0F+Wjfy8D0mn24NQD4HSnb3NSNKrpCgJzWEInm
 4rh9C5baCbdTKL8V8xEVGEVnvaxizc0xXRvADzeOc9C+2HIk6d6IUP4L8ZespoXnqYD0
 UZOHQV7nhQCh3BJNJrgElXC+7Wv9YlY2vJQOZ3FAAzSHyGhpFsRuVRkI5BC7ZEwJbL8t
 /HCi2MzaJR6UMRY7ws9MgDI5Rcxw9eafB5Y3RURCCbW7Bo+UWms5oJMrO1RgXa+HH62p
 aRa7OboeUoPIQuaiLAADFBqTphBmoTyzb31EA5ZHfGnAASugOgzG1YcN8DULwnyL5Pvb
 L+Aw==
X-Gm-Message-State: AOAM532lLs9pKML3+5j5J33g/9KRM+DgAbt8f2RTD8AFolEgRpZhNS/p
 NraYwgH9nqeSbCFdNiN8vKZ+hQ==
X-Google-Smtp-Source: ABdhPJx+gEzteow3B6jBiGbKO3tmtMId5XEoAWNmGBpXJ4b46a6vEg/U6TjnTg7sjzUg2oRcIwG5DQ==
X-Received: by 2002:ac8:6f1c:: with SMTP id g28mr2157920qtv.65.1604586857069; 
 Thu, 05 Nov 2020 06:34:17 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id a128sm1090283qkc.68.2020.11.05.06.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 06:34:16 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kagL9-00HNlq-O2; Thu, 05 Nov 2020 10:34:15 -0400
Date: Thu, 5 Nov 2020 10:34:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/6] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201105143415.GB36674@ziepe.ca>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-4-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105074205.1690638-4-hch@lst.de>
Cc: Zhu Yanjun <yanjunz@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Logan Gunthorpe <logang@deltatee.com>
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

On Thu, Nov 05, 2020 at 08:42:02AM +0100, Christoph Hellwig wrote:
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 5f8fd7976034e0..661e4a22b3cb81 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -3950,6 +3950,8 @@ static inline int ib_req_ncomp_notif(struct ib_cq *cq, int wc_cnt)
>   */
>  static inline int ib_dma_mapping_error(struct ib_device *dev, u64 dma_addr)
>  {
> +	if (!dev->dma_device)
> +		return 0;

How about:

static inline bool ib_uses_virt_dma(struct ib_device *dev)
{
	return IS_ENABLED(CONFIG_INFINIBAND_VIRT_DMA) && !dev->dma_device;
}

Which is a a little more guidance that driver authors need to set this
config symbol.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD132C2D0A3
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 18:17:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8312072C
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 18:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CrqhrkR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8312072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B3F95860D1;
	Wed,  4 Nov 2020 18:17:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 052TAbA3tWza; Wed,  4 Nov 2020 18:17:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D30F985FF3;
	Wed,  4 Nov 2020 18:17:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8182C088B;
	Wed,  4 Nov 2020 18:17:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73ECEC0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 18:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5915386738
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 18:17:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rwxCL7KRswXV for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 18:17:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9CA4986760
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 18:17:38 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id z6so20230875qkz.4
 for <iommu@lists.linux-foundation.org>; Wed, 04 Nov 2020 10:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=k0O2tryRBN/txl6awTV8eKioqjAa/NAL5VwW/RaREWI=;
 b=CrqhrkR7HAzUAGqSb60bOMK7qe5EIflczymnySw9Y5+bNjne9otfjktFQ6v+q7J5Bn
 QkYEsfvJoF/V7dNVQyc6aFNIdKrN1rYxwz6brltfl3vKl7GrhGkHBfbp/rhIGXnZsDyO
 q/iG27QnRKzRiEukn1JBcRUnjZMZ/Ak9n8ACm1EiTKdWPIltBuEFSSjrXyLFHI9ot/JV
 8uBpfDuI13wJ7vALHBveYCdpbk+A19p4Bv4z46ArjZXEgsqRrdu1kwYS320gfNeLMlWW
 W2r30op0NjtAJ7YPSSK/BVYOYThngPwmUNlHggeP4WiKmejHxYofVLU4IlsEUP8nocyW
 gCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=k0O2tryRBN/txl6awTV8eKioqjAa/NAL5VwW/RaREWI=;
 b=mHoWTik2F7XkFrhmg9NMpQOfx9hZXAs7dBnNoqNW5Xqj5hxXB3yNbXlwsjRdFW48Ju
 SdwiHbAupJP+tkmrrOLCTGZXRDJADCAvCpIRNWmxOABDoxtV4tKyy+BNfZVlWVEUxoUm
 3fYfWdoAR3aJ1LKMltFRJ2j+HJpkYU0qO6TsW61Q0MTjwCiNmKuUIDQe3k2EESB4Adsf
 t+hpmg3gNL4w2YHqEsAcH9QW4uIlv/tyVnRXAjuuqWwd5yMJAJ5/q8AQLuf8qOdPoCOn
 GI26kdJdd/Z6pbGamzJNL87bkWUD2flBXeovq6VgSZ+Jm0UTPFUxfAjatzz3q/3He4H8
 nd4Q==
X-Gm-Message-State: AOAM533bl49UezepZa8kIrX918mPFOMr0Wjy0Ihvf9p2mggHqptMsk9E
 nZ5/CAdY240MQMVJwUdt766EGVHiuoPW+M5l
X-Google-Smtp-Source: ABdhPJwkADJ1e/NwsQb+VIyXw9DQ2vEHkyjUPuy8BExU4QQfjYg+akP04U4TisV1zRg4p7BfBzttTQ==
X-Received: by 2002:aed:2d82:: with SMTP id i2mr10942501qtd.10.1604513459358; 
 Wed, 04 Nov 2020 10:10:59 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id h65sm969050qkd.95.2020.11.04.10.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:10:58 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kaNFJ-00GaMz-NI; Wed, 04 Nov 2020 14:10:57 -0400
Date: Wed, 4 Nov 2020 14:10:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bernard Metzler <BMT@zurich.ibm.com>
Subject: Re: Re: [PATCH 2/5] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201104181057.GT36674@ziepe.ca>
References: <20201104140108.GA5674@lst.de>
 <20201104095052.1222754-1-hch@lst.de>
 <20201104095052.1222754-3-hch@lst.de>
 <20201104134241.GP36674@ziepe.ca>
 <OFFDBE80DE.245A259C-ON00258616.00528DDA-00258616.00533A9D@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OFFDBE80DE.245A259C-ON00258616.00528DDA-00258616.00533A9D@notes.na.collabserv.com>
Cc: linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
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

On Wed, Nov 04, 2020 at 03:09:04PM +0000, Bernard Metzler wrote:

> lkey of zero to pass a physical buffer, only allowed for
> kernel applications? Very nice idea I think.

It already exists, it is called the local_dma_lkey, just set
IB_DEVICE_LOCAL_DMA_LKEY and provide the value you want to use
in device->local_dma_lkey

> btw.
> It would even get the vain blessing of the old IETF RDMA
> verbs draft ;)
> 
> https://tools.ietf.org/html/draft-hilland-rddp-verbs-00#page-90

IBTA standadized this, they just didn't require HW to use 0 as the
lkey.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

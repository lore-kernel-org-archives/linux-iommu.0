Return-Path: <SRS0=nHvM=OY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D767C4332F
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 13:28:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6AEA610A5
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 13:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B6AEA610A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F3B442755;
	Mon,  4 Oct 2021 13:28:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rkVEjPnhyi3x; Mon,  4 Oct 2021 13:28:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4212542752;
	Mon,  4 Oct 2021 13:28:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16096C0011;
	Mon,  4 Oct 2021 13:28:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AD2BC000D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 13:28:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8842C402A8
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 13:28:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wSZEvM8f4YYf for <iommu@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 13:28:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8FDA640203
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 13:28:01 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id b16so15801524qtt.7
 for <iommu@lists.linux-foundation.org>; Mon, 04 Oct 2021 06:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=6DU7gsbiNP9sjcVSmyhc3kWa3WRl9w7+FTLOGs4ZFN4=;
 b=iDoHZmkGlGlOGmyIALhCRv5d0FGVqcyqzKnkCSrwDERdEycsj9nKdyI4CDCY7dUkfu
 xidxgyjRN5kfHIRBmzvXWUYCVWONcmsNAfVlEJPerQ36OixcgdNf6z6xIX+i983wIGxX
 Fm+2zsmQUKlte1RY1Yvt03JDL8dJLW8PrakA/6MUOUbzXeejqw51g5Eeeoks+5BR2RWt
 8H1t/KDZUmwt+6LpGInv6V0CGPBr9+/eJziRGIauTdgjFf1nuaO3lqEPw168Nple9yyR
 oLcnT0bAheHnXc8spN7mnErr+Hx9iaPz3jI3W/1sr1SvZCmQMtgwq+8Jx3uPm4zXeBnI
 0JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=6DU7gsbiNP9sjcVSmyhc3kWa3WRl9w7+FTLOGs4ZFN4=;
 b=62Uep3zZl1UjcWSQCVk59RgstF1bDDaCZwpC4mrJ8xXgh8YG2/QGNr21wMrEge/hN5
 m5/47dGo3aHa83n4IJh2jlOHIl2rezV3UlC54ghKuD2XIHh1PZK7jU2hgULSzjU/VFjL
 Y9v+tn24ZqNjZ9MN/CLMLiK0F23QMhw2GZyHKApyAyqibF+DNm36/ddpi630BVJQdxG4
 wX0SRGXVfR0SWNOYWivIaBWqEavyQ4JsaOyafr5IGfcB8Taav1hke1/Z9HcUSyCzxLlh
 JfMkTCgsiP1yP2hX8qgVX/lQl/mMI32Nmwtc7IqeSYj4rC/xN6XRGmullk7UofXu1B3Q
 uhkg==
X-Gm-Message-State: AOAM531hkYwRtvjTrLKvFAW0clGXWYJeH2o0z2Xn+d/EiT/2bVquh1gN
 0R1N9+Y+Nj4xzTgDfwq99VNzkA==
X-Google-Smtp-Source: ABdhPJxtUT/KaZLX4EROxMBuImUPAmVtvIoSFGbrT35tFwl+26IbFnsgo9cxZTq9rMwrEpHPo9O3KQ==
X-Received: by 2002:ac8:564d:: with SMTP id 13mr13726534qtt.228.1633354080469; 
 Mon, 04 Oct 2021 06:28:00 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id 205sm7652317qkf.19.2021.10.04.06.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 06:28:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mXO0d-00ATnh-F3; Mon, 04 Oct 2021 10:27:59 -0300
Date: Mon, 4 Oct 2021 10:27:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20211004132759.GX3544071@ziepe.ca>
References: <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca>
 <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <809be72b-efb2-752c-31a6-702c8a307ce7@amd.com>
 <20211004131102.GU3544071@ziepe.ca>
 <1e219386-7547-4f42-d090-2afd62a268d7@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1e219386-7547-4f42-d090-2afd62a268d7@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, linux-mm@kvack.org,
 Jason Ekstrand <jason@jlekstrand.net>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Minturn Dave B <dave.b.minturn@intel.com>,
 Alistair Popple <apopple@nvidia.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Logan Gunthorpe <logang@deltatee.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gTW9uLCBPY3QgMDQsIDIwMjEgYXQgMDM6MjI6MjJQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKCj4gVGhhdCB1c2UgY2FzZSBpcyBjb21wbGV0ZWx5IHVucmVsYXRlZCB0byBHVVAg
YW5kIHdoZW4gdGhpcyBkb2Vzbid0IHdvcmsgd2UKPiBoYXZlIHF1aXRlIGEgcHJvYmxlbS4KCk15
IHJlYWQgaXMgdGhhdCB1bm1hcF9tYXBwaW5nX3JhbmdlKCkgZ3VhcmVudGVlcyB0aGUgcGh5c2lj
YWwgVExCCmhhcmR3YXJlIGlzIHNlcmlhbGl6ZWQgYWNyb3NzIGFsbCBDUFVzIHVwb24gcmV0dXJu
LgoKSXQgYWxzbyBndWFyZW50ZWVzIEdVUCBzbG93IGlzIHNlcmlhbGl6ZWQgZHVlIHRvIHRoZSBw
YWdlIHRhYmxlCnNwaW5sb2Nrcy4KCkphc29uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==

Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09C4C47257
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 14:39:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6D32075B
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 14:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VT6A3yuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6D32075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6D90D22EC9;
	Mon,  4 May 2020 14:39:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ji4DpHJ2T5OB; Mon,  4 May 2020 14:39:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 295F62305A;
	Mon,  4 May 2020 14:39:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DB27C088C;
	Mon,  4 May 2020 14:39:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2F5BC0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 14:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CDAF72305A
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 14:39:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZG8dq8q439qc for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 14:39:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by silver.osuosl.org (Postfix) with ESMTPS id CE99922EC9
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 14:39:43 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id x25so8763630wmc.0
 for <iommu@lists.linux-foundation.org>; Mon, 04 May 2020 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=w4t0U+D/kp+A2G6So+DAelHTG97Zr7f3qIlp9fzkip4=;
 b=VT6A3yuhts/Sup1Aaf3TlojcaThJY4hOWcMYKaz7xPgexle4/kuynbkV7mgcUoEEbw
 Gn/CW2sYLNgTZA45X9XgPW8JrJWgoeIRF3BPeDrgJPKkGIcPRKop0Gyla7rJZz4Ol5w0
 2lpW0x79AXvLKOlbwqjWSR7H42s53C2/AzDy/RZEYO8aimi5hqvmtvnptqLq1VKbO7a3
 hJy0881ArJOTDVsdeKrk0ixZzwswHqdRYytNWMCWIzu3HYx7Dg6+cxeyEeodVUIodnze
 KcHOc3sN/muaK/jcXS+hiuhM9+aCpMI9of01BChv2AdZ+UxLwm0J0i0JNuUhT5jFaKLt
 cvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=w4t0U+D/kp+A2G6So+DAelHTG97Zr7f3qIlp9fzkip4=;
 b=s6+8us4fRMCKx5UtdAp1YBwspl8QiXzBig/aWIfrYgT1GGPOJfccud1gg2LN2O+muJ
 77tWRspG45CvW7P9o1/1DBs189zXj78coqJ8PIQc2/z30PxpR89JvGVsnd1jC7rQRyrZ
 X/hR880Nmpbm7C54PRq3E2/ZlP7mK+meRo5vcU6B02WdtBep9VdvjKA4Q5AZNVUBKqKd
 1r+9KBkh6cUvd5ZGcaOaqoHLxlKstSilag75SBHvrWWQwf3TQfDVjR8IOYmQ/VQZTxzv
 qYFLVqs/REQw8QGmEbBe0usSmzwDbXeDEhZdYnb148BELyvtxcJ8f7cncVX/ATBmdr3b
 8vPQ==
X-Gm-Message-State: AGi0PuYihhAH8ZDTPeg+5Ae95RlKKzFOjbFQSd3Jmjdob2a6YLf4wLHQ
 GJkB0m+QEoBKDjeN7oKMvoQx+A==
X-Google-Smtp-Source: APiQypI2F7wsUGonQC0TZFKc5uxhIN4f0OL+bxJR0Xwpj7YciVqjrvdRQtQdeeCKgcaZ8I7mLJ+60A==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr14822175wmd.67.1588603182395; 
 Mon, 04 May 2020 07:39:42 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id p190sm14130168wmp.38.2020.05.04.07.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:39:41 -0700 (PDT)
Date: Mon, 4 May 2020 16:39:32 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v6 02/25] iommu/ioasid: Add ioasid references
Message-ID: <20200504143932.GC170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-3-jean-philippe@linaro.org>
 <20200430113931.0fbf7a37@jacob-builder>
 <20200430134842.74e596b8@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200430134842.74e596b8@jacob-builder>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, jgg@ziepe.ca,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, fenghua.yu@intel.com,
 hch@infradead.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, catalin.marinas@arm.com, felix.kuehling@amd.com,
 will@kernel.org, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Apr 30, 2020 at 01:48:42PM -0700, Jacob Pan wrote:
> On Thu, 30 Apr 2020 11:39:31 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > > -void ioasid_free(ioasid_t ioasid)
> > > +bool ioasid_free(ioasid_t ioasid)
> > >  {
> Sorry I missed this in the last reply.
> 
> I think free needs to be unconditional since there is not a good way to
> fail it.
> 
> Also can we have more symmetric APIs, seems we don't have ioasid_put()
> in this patchset.

Yes I was thinking of renaming ioasid_free() to ioasid_put() but got lazy. 

> How about?
> ioasid_alloc()
> ioasid_free(); //drop reference, mark inactive, but not reclaimed if
> 		refcount is not zero.
> ioasid_get() // returns err if the ioasid is marked inactive by
> 		ioasid_free()

How does the caller know that the ioasid is in active/inactive state, and
not freed/reallocated?

> ioasid_put();// drop reference, reclaim if refcount is 0.

I'll add ioasid_put() for now. I'd like to avoid introducing the inactive
state in this patch, so shall I change the calls in the Intel driver to
ioasid_put(), and not introduce a new ioasid_free() for the moment?

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=zhz4=4N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBA9C35DF5
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 09:24:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E8521744
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 09:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zl3vF2Dl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E8521744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0CFB5861A7;
	Tue, 25 Feb 2020 09:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B8BV5mcgkclN; Tue, 25 Feb 2020 09:24:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 22B2C8620F;
	Tue, 25 Feb 2020 09:24:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02FC1C18DA;
	Tue, 25 Feb 2020 09:24:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10DECC0177
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 09:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F25FC84410
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 09:24:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q31WO44bVlas for <iommu@lists.linux-foundation.org>;
 Tue, 25 Feb 2020 09:24:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1306683F35
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 09:24:49 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id g3so13758569wrs.12
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 01:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=f/BcuFESeD0nxQhG6MiD0u6r1X/PnHdRmEXqrbWhTtE=;
 b=zl3vF2DlbSqx5eFLLSUdDjI9EBwAJZ4gdDoR9UGpSvUPJOfbkv3eJR3zZrLTOKMU5r
 D1kDFHHNnWKKqrQV7qph5B4gnUnW3MYHNVP9WtLrfnDrCUvQMjwl171h+LwnhrjjAhUL
 ZdjznstMqGMEo0r7R+ZMNgE9YsZkix386pUoowGHr7Xeuj/plf1j8rEUOxYGQi94ARnr
 /AuqGhdu0td5MoZWNt7hEUNQw/YJTSVuPHT+6d5f6XwTZqTqrzty29h/tWMUE+qOVNNo
 O5UynFhd8cMEe83OPT8ZfIyYc0CAYZv4eLxgs1/afMqrI4bm73/HwhckO87ueeMlK+p9
 B/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=f/BcuFESeD0nxQhG6MiD0u6r1X/PnHdRmEXqrbWhTtE=;
 b=NCcrKqOhgfkRycmF5cZcL3P7s+B04Cf63EAMnzBH5lqPylXyn+mMf5MwLqq+Vd+cF5
 E1pwliSSM68lvqR9tO1tIaAarLiKWJouwsfCP8FipNEAsvMMApUxwUU9VDI0P6mAsOjd
 YRZms8YYEn7GHC7oMGqSQjq6N64M1xlCRF6/eogytEhhObCCNPPL4NXYPVajKkKkSp2f
 wL68r2OwX2G+EJ3WCw1vpoUAj0G/fFlFAFkUQGmFTCDiAEhAzSg/BJqudEu7bzf9AHK8
 AJPBxpCLZze0fg3CyGktFkI/iI0xAQiporIpYlnTfhn3T7N/zbGj20AgfYJ6O5jjiI/q
 gfNw==
X-Gm-Message-State: APjAAAXXS2bZtn0790YkulxxzTYETxNrgvhPgZxj6CJdDSxW8rOF9Q34
 /R6RwDoxkkjrF6tK/nXSEvD4HA==
X-Google-Smtp-Source: APXvYqzEBhx+1qou+rx6ieuBuVr+WsrtZbhL85bwQfWbU5iCMd2zUrtZQURsgfjNBpo6KHXv5wrHgA==
X-Received: by 2002:adf:9cca:: with SMTP id h10mr1745887wre.390.1582622687476; 
 Tue, 25 Feb 2020 01:24:47 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id k16sm23442823wru.0.2020.02.25.01.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 01:24:46 -0800 (PST)
Date: Tue, 25 Feb 2020 10:24:39 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200225092439.GB375953@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200224190056.GT31668@ziepe.ca>
Cc: mark.rutland@arm.com, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 will@kernel.org, Dimitri Sivanich <sivanich@sgi.com>, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, devicetree@vger.kernel.org, kevin.tian@intel.com,
 Arnd Bergmann <arnd@arndb.de>, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>,
 robin.murphy@arm.com, christian.koenig@amd.com
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

On Mon, Feb 24, 2020 at 03:00:56PM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 24, 2020 at 07:23:36PM +0100, Jean-Philippe Brucker wrote:
> > The new allocation scheme introduced by 2c7933f53f6b ("mm/mmu_notifiers:
> > add a get/put scheme for the registration") provides a convenient way
> > for users to attach notifier data to an mm. However, it would be even
> > better to create this notifier data atomically.
> > 
> > Since the alloc_notifier() callback only takes an mm argument at the
> > moment, some users have to perform the allocation in two times.
> > alloc_notifier() initially creates an incomplete structure, which is
> > then finalized using more context once mmu_notifier_get() returns. This
> > second step requires carrying an initialization lock in the notifier
> > data and playing dirty tricks to order memory accesses against live
> > invalidation.
> 
> This was the intended pattern. Tthere shouldn't be an real issue as
> there shouldn't be any data on which to invalidate, ie the later patch
> does:
> 
> +       list_for_each_entry_rcu(bond, &io_mm->devices, mm_head)
> 
> And that list is empty post-allocation, so no 'dirty tricks' required.

Before introducing this patch I had the following code:

+	list_for_each_entry_rcu(bond, &io_mm->devices, mm_head) {
+		/*
+		 * To ensure that we observe the initialization of io_mm fields
+		 * by io_mm_finalize() before the registration of this bond to
+		 * the list by io_mm_attach(), introduce an address dependency
+		 * between bond and io_mm. It pairs with the smp_store_release()
+		 * from list_add_rcu().
+		 */
+		io_mm = rcu_dereference(bond->io_mm);
+		io_mm->ops->invalidate(bond->sva.dev, io_mm->pasid, io_mm->ctx,
+				       start, end - start);
+	}

(1) io_mm_get() would obtain an empty io_mm from iommu_notifier_get().
(2) then io_mm_finalize() would initialize io_mm->ops, io_mm->ctx, etc.
(3) finally io_mm_attach() would add the bond to io_mm->devices.

Since the above code can run before (2) it needs to observe valid
io_mm->ctx, io_mm->ops initialized by (2) after obtaining the bond
initialized by (3). Which I believe requires the address dependency from
the rcu_dereference() above or some stronger barrier to pair with the
list_add_rcu(). If io_mm->ctx and io_mm->ops are already valid before the
mmu notifier is published, then we don't need that stuff.

That's the main reason I would have liked moving everything to
alloc_notifier(), the locking below isn't a big deal.

> The other op callback is release, which also cannot be called as the
> caller must hold a mmget to establish the notifier.
> 
> So just use the locking that already exists. There is one function
> that calls io_mm_get() which immediately calls io_mm_attach, which
> immediately grabs the global iommu_sva_lock.
> 
> Thus init the pasid for the first time under that lock and everything
> is fine.

I agree with this, can't remember why I used a separate lock for
initialization rather than reusing iommu_sva_lock.

Thanks,
Jean

> 
> There is nothing inherently wrong with the approach in this patch, but
> it seems unneeded in this case..
> 
> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

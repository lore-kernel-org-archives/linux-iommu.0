Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A283C48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 04:13:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDD66140D
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 04:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDD66140D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F1F040276;
	Tue, 15 Jun 2021 04:13:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mpl10O_mxBnU; Tue, 15 Jun 2021 04:13:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5F6F640201;
	Tue, 15 Jun 2021 04:13:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43E40C000E;
	Tue, 15 Jun 2021 04:13:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9B89C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 04:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 909F783BD9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 04:13:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PmyHZTqIb0lr for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 04:13:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E9D283BD4
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 04:13:48 +0000 (UTC)
Received: by mail-qt1-x836.google.com with SMTP id o20so10265408qtr.8
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 21:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YDA/6rYFbIzGwN3DJJ3v30Ilg60B464lccTuq9RZZyA=;
 b=fMG07OU4hKhOT0Ejr3qOHcrU08EN3G1+RpniZ8liKpsJESj8tYmvpPMQZbf905Arqa
 jTNjk7/cw8NTc05aXCrTOb4W4H63TAdnEqedfWvkUqde8aQCNzpKVfF+WTvNV5ptv2qS
 TsIum45Bdbkm1pBXJPvJDobZEXMxEtOKj24Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YDA/6rYFbIzGwN3DJJ3v30Ilg60B464lccTuq9RZZyA=;
 b=BS6SVIX7zRVPD6n1EF/hT1K+qJ0CZ40z9hElhP001dfcl6jJy6WrvkYPvQJnmfFkOD
 zrIkoUXywyo3UGPbWTvTZneU/NxNQ/QTyfzfg8VDBa7IPWbAlkP5YVl/nPe7SsNPEk8L
 t+tJlRITEhkvM5rJgfhSdF8TWWKFsKsI5iqgF/WniiUDGmxuZmVXDTXmxWKKytNFMks7
 hV9eOiP7YnxSmOyCDZ0WEBSDtHwrVNRf/kXBvRp8ITTpTwF+fU8gbwp257xE48mgATbU
 dkDqXe/Ri0eOOESUihmnHYSfU6U9nZ79G29mypCtL+jYdc2AmHzoki0mB/WsTg7JPKg8
 /w/g==
X-Gm-Message-State: AOAM530NBXcsUSH1DGU7aOQJ+onu6/6gJCCHpOLhJ/JqtWmcL58ANWvY
 6ksm9tskXQwUz93bH3HmpFRgF8e/sw/X7w==
X-Google-Smtp-Source: ABdhPJyjvqDz1dCsN9IBTofNeDHHPvfAKWSzuGte3opWm2t60aY+cSNRYyAvgP03kdprsAShF5CPMg==
X-Received: by 2002:ac8:5c48:: with SMTP id j8mr19854864qtj.154.1623730427242; 
 Mon, 14 Jun 2021 21:13:47 -0700 (PDT)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com.
 [209.85.222.178])
 by smtp.gmail.com with ESMTPSA id q7sm11305355qki.92.2021.06.14.21.13.46
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jun 2021 21:13:46 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id q16so14743660qkm.9
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 21:13:46 -0700 (PDT)
X-Received: by 2002:a02:384b:: with SMTP id v11mr19686288jae.90.1623729977741; 
 Mon, 14 Jun 2021 21:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210611152659.2142983-1-tientzu@chromium.org>
 <20210611152659.2142983-2-tientzu@chromium.org>
 <20210614061644.GA28343@lst.de>
In-Reply-To: <20210614061644.GA28343@lst.de>
From: Claire Chang <tientzu@chromium.org>
Date: Tue, 15 Jun 2021 12:06:06 +0800
X-Gmail-Original-Message-ID: <CALiNf29cE-T7xf+nUZF2pjT8osaXj+wb4MibtdSkAU_K13wuMw@mail.gmail.com>
Message-ID: <CALiNf29cE-T7xf+nUZF2pjT8osaXj+wb4MibtdSkAU_K13wuMw@mail.gmail.com>
Subject: Re: [PATCH v9 01/14] swiotlb: Refactor swiotlb init functions
To: Christoph Hellwig <hch@lst.de>
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 Jianxiong Gao <jxgao@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 maarten.lankhorst@linux.intel.com, airlied@linux.ie,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 jani.nikula@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 Robin Murphy <robin.murphy@arm.com>, bauerman@linux.ibm.com
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

On Mon, Jun 14, 2021 at 2:16 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 11, 2021 at 11:26:46PM +0800, Claire Chang wrote:
> > +     spin_lock_init(&mem->lock);
> > +     for (i = 0; i < mem->nslabs; i++) {
> > +             mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> > +             mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> > +             mem->slots[i].alloc_size = 0;
> > +     }
> > +
> > +     if (memory_decrypted)
> > +             set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
> > +     memset(vaddr, 0, bytes);
>
> We don't really need to do this call before the memset.  Which means we
> can just move it to the callers that care instead of having a bool
> argument.
>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for the review. Will wait more days for other reviews and send
v10 to address the comments in this and other patches.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

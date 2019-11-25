Return-Path: <SRS0=OkKq=ZR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A269C432C0
	for <iommu@archiver.kernel.org>; Mon, 25 Nov 2019 17:48:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7FE20679
	for <iommu@archiver.kernel.org>; Mon, 25 Nov 2019 17:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="avnCZcmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7FE20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EA25120033;
	Mon, 25 Nov 2019 17:48:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id moRyZzea9pUY; Mon, 25 Nov 2019 17:48:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 27C4D203D4;
	Mon, 25 Nov 2019 17:48:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E94FDC0881;
	Mon, 25 Nov 2019 17:48:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8A7BC0878
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 17:48:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C71908797A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 17:48:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HyHtnDUvaU0z for <iommu@lists.linux-foundation.org>;
 Mon, 25 Nov 2019 17:48:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7E7588796C
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 17:48:22 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id z10so19152381wrs.12
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 09:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=BgkOCn6dEkaCecb5ZyLmsM0vtVrRc/X2TTNPZzp0BGs=;
 b=avnCZcmnWQYRn2ejXtbreBr+2fzx+QirQ6jMfKAMwEDo3jyctcQvSS6SM6aBRJCAeP
 kfDeyJNKwf8Ww1fdC45IB/7jKdswYHhGPaF1CAK1k/eHulj1Z8NDM4NLugYgnTl5DEOo
 YefFZFkbA6n3NhXip9hDUOr85MJpTQj4qNSE9VQlJPLdQNIY7YvpyPpEkKFXnyOnZTKk
 zxPRxvEFW8WTSxxiqEYBqSc/EW+pCq8OXdDzqUhlOxxL17HZqZAjCdkw8lFuH7Nliyrm
 MDDF0iP1wW7sCg4O3wkJdWYO3+EHez48clfhcdiT/8bJ80T/RuVV1xpWQm7lYwPafspo
 67oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BgkOCn6dEkaCecb5ZyLmsM0vtVrRc/X2TTNPZzp0BGs=;
 b=NHklXT1uKDspql21Q174cWmuuGkt4Cp8102ATAB+iKCris7uiS0ATwYecUjpP2xb90
 Wo3WnQBdUhSwq6xXaFiD4soUUb+KBNUbwlE8hIffVlKbc6glptkXDsT12vP3ZBcRZHwD
 PtqVACvCx3p4+qKB61ipkSk18D0YUbPyPBVunqb548/dBJEHUJnYoIAk05QPL6oCvGTQ
 yAsEsWJhi+FvuWF9/leZjtU/XTIMwOh0rwk1+6jCVy3VqCr12Mzp27T79/l8WMLviUnA
 gVSv6HwGkpBqzi60CtJ7/c/9g8Owq/K7s2s3iZ5qeZu0H9Ad072ccWWkwrFavNLvQNyi
 YIsQ==
X-Gm-Message-State: APjAAAWZ1zbp2+C8eB4RosqDYLmxP3TNzaZcEjcNmqCT0cy3Na4kIaR8
 DBP2j20P28cksXt+WvqEvKlNLw==
X-Google-Smtp-Source: APXvYqzTUYJqRjRrvNHNtPJwWI/KyemjW5baiqCvdsWHNGy9hgofkwoCe9NS+y/KmUwV3VIZ5E9NFQ==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr12150855wrs.106.1574704100857; 
 Mon, 25 Nov 2019 09:48:20 -0800 (PST)
Received: from lophozonia (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
 by smtp.gmail.com with ESMTPSA id x7sm11127238wrq.41.2019.11.25.09.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 09:48:20 -0800 (PST)
Date: Mon, 25 Nov 2019 18:48:17 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 13/13] iommu/virtio: Add topology description to
Message-ID: <20191125174817.GB945122@lophozonia>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
 <20191122105000.800410-14-jean-philippe@linaro.org>
 <20191122072753-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191122072753-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
 gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, sudeep.holla@arm.com,
 rjw@rjwysocki.net, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, guohanjun@huawei.com,
 bhelgaas@google.com, jasowang@redhat.com, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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

On Fri, Nov 22, 2019 at 07:53:19AM -0500, Michael S. Tsirkin wrote:
> Overall this looks good to me. The only point is that
> I think the way the interface is designed makes writing
> the driver a bit too difficult. Idea: if instead we just
> have a length field and then an array of records
> (preferably unions so we don't need to work hard),
> we can shadow that into memory, then iterate over
> the unions.
> 
> Maybe add a uniform record length + number of records field.
> Then just skip types you do not know how to handle.
> This will also help make sure it's within bounds.
> 
> What do you think?

Sounds good, that should simplify the implementation a bit.

> You will need to do something to address the TODO I think.

Yes, I'll try to figure out a way to test platform devices.

> > +static void viommu_cwrite(struct pci_dev *dev, int cfg,
> > +			  struct viommu_cap_config *cap, u32 length, u32 offset,
> > +			  u32 val)
> 
> A single user with 4 byte parameter. Just open-code?

Ok

> > +		cap.head.type = viommu_cread(dev, pci_cfg, dev_cfg, 2, offset);
> > +		cap.head.next = viommu_cread(dev, pci_cfg, dev_cfg, 2, offset + 2);
> 
> All of this doesn't seem to be endian-clean. Try running sparse I think
> it will complain.

It does, I'll fix this

> > @@ -36,6 +37,31 @@ struct virtio_iommu_config {
> >  	struct virtio_iommu_range_32		domain_range;
> >  	/* Probe buffer size */
> >  	__le32					probe_size;
> > +	/* Offset to the beginning of the topology table */
> > +	__le16					topo_offset;
> 
> why do we need an offset?

I find it awkward to put a variable-size array in the middle of the
config. The virtio_iommu_config struct would be easier to extend later if
we keep the array at the end and only define small static fields here.

> 
> > +};
> > +
> > +struct virtio_iommu_topo_head {
> > +	__le16					type;
> > +	__le16					next;
> > +};
> 
> So this linked list makes things harder than necessary imho.
> It will be easier to just have a counter with # of records.
> Then make all records the same size.
> Then just read each record out into a buffer, and
> handle it there.

Yes, that should simplify things.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

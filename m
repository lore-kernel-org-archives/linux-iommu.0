Return-Path: <SRS0=w+D4=T3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B06C04AB3
	for <iommu@archiver.kernel.org>; Mon, 27 May 2019 15:16:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CE3217F4
	for <iommu@archiver.kernel.org>; Mon, 27 May 2019 15:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CE3217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 13ED419EE;
	Mon, 27 May 2019 15:16:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 60FA11893
	for <iommu@lists.linux-foundation.org>;
	Mon, 27 May 2019 15:15:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f194.google.com (mail-vk1-f194.google.com
	[209.85.221.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5B15F6C5
	for <iommu@lists.linux-foundation.org>;
	Mon, 27 May 2019 15:15:37 +0000 (UTC)
Received: by mail-vk1-f194.google.com with SMTP id j124so3903853vkb.4
	for <iommu@lists.linux-foundation.org>;
	Mon, 27 May 2019 08:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=S3tITZHYfrewmW5oJlisGGiL7wfHqP1R9OVY9cCC4GU=;
	b=rmfAV0c4Itl6X1k6VEPe08w/+NPEZD0QNvRt1PYbJuVcT8Q4TTK2GDQKtzoGt/wMYt
	gAfIs1ca1I6+JDiNFbrMj1bKhOKhzD+BHFPDbT+5IlGikHetMkz8CwME/Q3LC0JWX00L
	XMULnkCKQRx1YEYEi8tSZGMrtuWR84XusZdCEZpPap2BtKrWxn1VwKYjOFyXWmRyjJmM
	Rs+XR4Aw+UJq6+bLvKruNAj5IJESzlTR6udywiW5fymnnu7/K4Eq2IGgOFgJODpUEUsv
	cBh8+lgs1VqAUL+EScIWewYOIMwHOB1HJslgXQSy2EahjNcriwpESRhiGwnaRhniA5rS
	Wy/w==
X-Gm-Message-State: APjAAAXHC1BivPhkDSndUghKV5xWPEPkQaZp6vqUt+cDlbYdarZ5hZ1e
	4h7jVX+axbq0J4boV3sphPuHcw==
X-Google-Smtp-Source: APXvYqxJCHIEBYM/VufOiGYY7G560g6K/dg4+SJBDDD3dVA0O70dd9ZnwStYxTkM8qVIYrC3jk8P+g==
X-Received: by 2002:a1f:7cc7:: with SMTP id x190mr19173038vkc.92.1558970136480;
	Mon, 27 May 2019 08:15:36 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	w131sm6373477vsw.7.2019.05.27.08.15.34
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 27 May 2019 08:15:35 -0700 (PDT)
Date: Mon, 27 May 2019 11:15:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v7 0/7] Add virtio-iommu driver
Message-ID: <20190527111345-mutt-send-email-mst@kernel.org>
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
	<20190512123022-mutt-send-email-mst@kernel.org>
	<20190527092604.GB21613@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190527092604.GB21613@8bytes.org>
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
	tnowicki@caviumnetworks.com, devicetree@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	linux-pci@vger.kernel.org, jasowang@redhat.com,
	will.deacon@arm.com, robin.murphy@arm.com,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux-foundation.org, robh+dt@kernel.org,
	marc.zyngier@arm.com, bhelgaas@google.com,
	frowand.list@gmail.com, kvmarm@lists.cs.columbia.edu
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, May 27, 2019 at 11:26:04AM +0200, Joerg Roedel wrote:
> On Sun, May 12, 2019 at 12:31:59PM -0400, Michael S. Tsirkin wrote:
> > OK this has been in next for a while.
> > 
> > Last time IOMMU maintainers objected. Are objections
> > still in force?
> > 
> > If not could we get acks please?
> 
> No objections against the code, I only hesitated because the Spec was
> not yet official.
> 
> So for the code:
> 
> 	Acked-by: Joerg Roedel <jroedel@suse.de>

Last spec patch had a bunch of comments not yet addressed.
But I do not remember whether comments are just about wording
or about the host/guest interface as well.
Jean-Philippe could you remind me please?

-- 
MST
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

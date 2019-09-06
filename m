Return-Path: <SRS0=rqG6=XB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6131CC00307
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 12:27:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4A7208C3
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 12:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqTvZMOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4A7208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B1D692171;
	Fri,  6 Sep 2019 12:27:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C5200216B
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 12:27:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
	[209.85.208.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2E252887
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 12:27:32 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id a4so5823004ljk.8
	for <iommu@lists.linux-foundation.org>;
	Fri, 06 Sep 2019 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=voMncQMQ4YdYJSbQPybIZCy/AcK0j9pgJUBzJv0XJ0A=;
	b=sqTvZMOg0FK+tbQ5Twd8lIUIdl5cRw7f3mUvyMcKovHkLwtCNr+KhR8ryq4wVIDwmE
	MrBFX2gvgSY3HU2O7p/fa3kIFtwabChkkv1UJeIL2HzkjG5QPDhFYHq8EkK3B24Bgydv
	Fi2qkSQYUx9TdJxWg4stgkl9/pi/wDuDnFFyyRBx/kMYn9jJS/zdvJSGTuo1h2Temozf
	Nvf/Hnfjf2PuJ6a6jToQHWZwxuQcOEfdbQhKzPmea0lJsU/ZNqvBUb+imGx19W9r0HCK
	Hyvu0+zXQQzELhka7MTfPB6km6DSDMOt5IvIpqPyjyiI/acvmccpl7me4YJqAOCRVfA5
	PFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=voMncQMQ4YdYJSbQPybIZCy/AcK0j9pgJUBzJv0XJ0A=;
	b=BaiwxCg7DK2xyZy/3Zf6INsX6DI7qWLoSUywTkcmipXIcQuOUxWJqQLCuOZh6q6Wr0
	T+0K6M+iixo7rhDcFBMl7nR2FhOXqlylte1wg2tguESbosXsRcc9GPJlzi3uKZksBf8z
	GW0kfsxXHteZX+3m+sAm+z5ggKhBne5xHl7HyIaLYdTNSfInWzJXw+2q5vrjO44HFtOe
	uQz6iplaivSCAcjs620TyYlyswTIeRDPuGPAkyzVDqsLkDXQk6VdabQSXwThtqpy9kmb
	sARCXdNYZzkIHGpUJsN9trTxRZzsswmqPW2zuX2+QZaeJINUOOPSOUBTmQdXghHh47SD
	Xh6w==
X-Gm-Message-State: APjAAAWoH8FcgoscbfyBUqm7ALeV+Hz9K5EyFwLQfaab/3w2OUZjG06A
	HpUHgbOG2b3GWSCgIU2+GQyl9oxSkjN+7x0+nGc=
X-Google-Smtp-Source: APXvYqyqVi6A3SK9ZHo9Lzs4psldtYUrV3ugRoL85TI5Orqgiv42bAur5gdeHYcDQujEI1t/u7SSENxNihK+5Pwaths=
X-Received: by 2002:a2e:9602:: with SMTP id v2mr5657222ljh.215.1567772850472; 
	Fri, 06 Sep 2019 05:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <1567413598-4477-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1567413598-4477-1-git-send-email-jrdr.linux@gmail.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 6 Sep 2019 17:57:19 +0530
Message-ID: <CAFqt6zYkFk55gzmfwMFzpWiOp0xP3DXdmWyO2Ce8+mqYW12SNw@mail.gmail.com>
Subject: Re: [PATCH v2] swiotlb-xen: Convert to use macro
To: konrad.wilk@oracle.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Juergen Gross <jgross@suse.com>, sstabellini@kernel.org
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, Sabyasachi Gupta <sabyasachi.linux@gmail.com>
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

On Mon, Sep 2, 2019 at 2:04 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Rather than using static int max_dma_bits, this
> can be coverted to use as macro.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>

If it is still not late, can we get this patch in queue for 5.4 ?

> ---
>  drivers/xen/swiotlb-xen.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index ae1df49..d1eced5 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -38,6 +38,7 @@
>  #include <asm/xen/page-coherent.h>
>
>  #include <trace/events/swiotlb.h>
> +#define MAX_DMA_BITS 32
>  /*
>   * Used to do a quick range check in swiotlb_tbl_unmap_single and
>   * swiotlb_tbl_sync_single_*, to see if the memory was in fact allocated by this
> @@ -114,8 +115,6 @@ static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
>         return 0;
>  }
>
> -static int max_dma_bits = 32;
> -
>  static int
>  xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
>  {
> @@ -135,7 +134,7 @@ static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
>                                 p + (i << IO_TLB_SHIFT),
>                                 get_order(slabs << IO_TLB_SHIFT),
>                                 dma_bits, &dma_handle);
> -               } while (rc && dma_bits++ < max_dma_bits);
> +               } while (rc && dma_bits++ < MAX_DMA_BITS);
>                 if (rc)
>                         return rc;
>
> --
> 1.9.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

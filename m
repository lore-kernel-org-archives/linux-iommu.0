Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C090EC433E6
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 13:58:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DBA264EEB
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 13:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBA264EEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 110EC86078;
	Tue,  9 Feb 2021 13:58:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HGGMcKUbMN4n; Tue,  9 Feb 2021 13:58:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9B88886090;
	Tue,  9 Feb 2021 13:58:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 823E2C1D9F;
	Tue,  9 Feb 2021 13:58:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADC43C013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A7BA78711A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:36:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VsuiuWeiXRNY for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 12:36:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E3EB186FD2
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:36:38 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id p21so28025735lfu.11
 for <iommu@lists.linux-foundation.org>; Tue, 09 Feb 2021 04:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TlO/IHS+gsLGXDK9MI6n2G68BWNFddAvWp2ImdoQBSU=;
 b=ANVoCoLTdRpeNuFdAnXRfBbcVVqmgxnSyOFyu/rCK5rR7OfuDQkZCI++TdUasGDvXJ
 nviLh3US2gOoW/xBZtF+PVDcPxNT2bi5gRCrZrFqVwzF6kLa7gz9OlxonMOJZDYws8kS
 Jxl8F3DWuMvuvjYcX7AVnexOv5+VmEDwuDl6dzqJJDJFopoT0CqK+crFlk3BXpOmXhzD
 qypY8NJYsStm0Zd8qYoTG9LqPDhaxv89+fkQILj8srlfemB9FzdAt+VRhdx/cewYPbe+
 qOAJyhgbIHAeT/eawqUAq+TuBBjRvaKojLG9F3BHhsVDqZ5VWNkk8V29QPmtdr+N29+F
 taGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TlO/IHS+gsLGXDK9MI6n2G68BWNFddAvWp2ImdoQBSU=;
 b=tGoFK7z8TdAe1cosiJqh4BCGUKYEO03EFC3YZTV+54p+0wQObC+IJsqZXZjS7NXM0o
 HpmjO5FVGKsKs/qv6STdfcQhlZCaD1ta0v+SP9xY/T23WNw2Ig5QuMwBEsGOcTKMbgtf
 4lFsBmtLizTH1H7dflq2mrp9rX05L8Ua3Sy6fUKfRbYDQH02li3s8FdJN9/8c/V+J4DD
 Xb6r8AELCYOH4SVBXWp30SM14DqRY2vRCZan2edTSjO9XErthZ74ptbud6/iM8sGjuHz
 FRdOsG5cMYPfvxCjwyw34vzHPYJaJU58AowlbD21uw/anxyrtI1DSeqK8bbh/lk+iNbQ
 EUTg==
X-Gm-Message-State: AOAM5333bWG8f2PaXI+Lx1wZxSFU7NMcNKh6vxjabOZZJM2P2Py8RR3A
 2sxipYUy+/0/LEI6TrJansBPyYf3qkSFLZf3oq8Rsg==
X-Google-Smtp-Source: ABdhPJzLWP2m9ZyklHdcfgz4+xI8GHZZFrzP3zKXNsAXGCce8LymSyD62L38I3SdSjyQcQplaY+oPxoqbLa8Hg7mKj0=
X-Received: by 2002:a19:e308:: with SMTP id a8mr2836867lfh.194.1612874197036; 
 Tue, 09 Feb 2021 04:36:37 -0800 (PST)
MIME-Version: 1.0
References: <CAFA6WYNazCmYN20irLdNV+2vcv5dqR+grvaY-FA7q2WOBMs__g@mail.gmail.com>
 <YCIym62vHfbG+dWf@kroah.com>
 <CAFA6WYM+xJ0YDKenWFPMHrTz4gLWatnog84wyk31Xy2dTiT2RA@mail.gmail.com>
 <YCJCDZGa1Dhqv6Ni@kroah.com>
 <27bbe35deacb4ca49f31307f4ed551b5@SOC-EX02V.e01.socionext.com>
 <YCJUgKDNVjJ4dUqM@kroah.com> <20210209093642.GA1006@lst.de>
In-Reply-To: <20210209093642.GA1006@lst.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 9 Feb 2021 18:06:25 +0530
Message-ID: <CAFA6WYO59w=wif8W16sG6BnzSjFhaY6PmRUTdSCu9A+zA7gzBw@mail.gmail.com>
Subject: Re: DMA direct mapping fix for 5.4 and earlier stable branches
To: Christoph Hellwig <hch@lst.de>
X-Mailman-Approved-At: Tue, 09 Feb 2021 13:58:38 +0000
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
 Greg KH <gregkh@linuxfoundation.org>, obayashi.yoshimasa@socionext.com,
 stable <stable@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

Hi Christoph,

On Tue, 9 Feb 2021 at 15:06, Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Feb 09, 2021 at 10:23:12AM +0100, Greg KH wrote:
> > >   From the view point of ZeroCopy using DMABUF, is 5.4 not
> > > mature enough, and is 5.10 enough mature ?
> > >   This is the most important point for judging migration.
> >
> > How do you judge "mature"?
> >
> > And again, if a feature isn't present in a specific kernel version, why
> > would you think that it would be a viable solution for you to use?
>
> I'm pretty sure dma_get_sgtable has been around much longer and was
> supposed to work, but only really did work properly for arm32, and
> for platforms with coherent DMA.  I bet he is using non-coherent arm64,

It's an arm64 platform using coherent DMA where device coherent DMA
memory pool is defined in the DT as follows:

        reserved-memory {
                #address-cells = <2>;
                #size-cells = <2>;
                ranges;

                <snip>
                encbuffer: encbuffer@0xb0000000 {
                        compatible = "shared-dma-pool";
                        reg = <0 0xb0000000 0 0x08000000>; // this
area used with dma-coherent
                        no-map;
                };
                <snip>
        };

Device is dma-coherent as per following DT property:

                codec {
                        compatible = "socionext,uniphier-pxs3-codec";
                        <snip>
                        memory-region = <&encbuffer>;
                        dma-coherent;
                        <snip>
                };

And call chain to create device coherent DMA pool is as follows:

rmem_dma_device_init();
  dma_init_coherent_memory();
    memremap();
      ioremap_wc();

which simply maps coherent DMA memory into vmalloc space on arm64.

The thing I am unclear is why this is called a new feature rather than
a bug in dma_common_get_sgtable() which is failing to handle vmalloc
addresses? While at the same time DMA debug APIs specifically handle
vmalloc addresses [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/kernel/dma/debug.c?h=linux-5.4.y#n1462

-Sumit

> and it would be broken for other drivers there as well if people did
> test them, which they apparently so far did not.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

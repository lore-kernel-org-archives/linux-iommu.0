Return-Path: <SRS0=1Id5=UF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B053C28EB4
	for <iommu@archiver.kernel.org>; Thu,  6 Jun 2019 14:13:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96FB20665
	for <iommu@archiver.kernel.org>; Thu,  6 Jun 2019 14:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dPVis3py"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96FB20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 987A2A70;
	Thu,  6 Jun 2019 14:13:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9688CA55
	for <iommu@lists.linux-foundation.org>;
	Thu,  6 Jun 2019 14:13:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
	[209.85.214.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3A64234F
	for <iommu@lists.linux-foundation.org>;
	Thu,  6 Jun 2019 14:13:07 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id c5so972595pll.11
	for <iommu@lists.linux-foundation.org>;
	Thu, 06 Jun 2019 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=2YcQi322gU65udmxZ663ZZ4Wmd0vpO9jY2pkneP18U8=;
	b=dPVis3pyGrHlNapFxyZ1x9FyS9jHmd9LaTMqq9zxLdzeQq73zejEUwtK4x5P95VHCi
	WbnjrcVTw0kkko56uuK+VX/DWBgM1VpJFCd01k6qoXzQQtq5xVio6DKcJm6ewlYcOpur
	4SZVbac3X8ApQkp/ZMqoc/JPST/Xr+gZGXi8VKa5d133BKihAWW0jSubtK9BEMlwopWe
	7L860vq3MXyqIsj+4++leoIvxTpF8yJnIP2AiZFrB6iLZeBX8MQWEC+C0Lp2378pgD1f
	bFvIhFlWxE9Cx7pYCOPUTs9+JHwiZYModJGX45diPPvUZXpA4lIYB4iXdVnR1cgeoluJ
	4tKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=2YcQi322gU65udmxZ663ZZ4Wmd0vpO9jY2pkneP18U8=;
	b=czjPtAlPCmv/EqcyKOth4J/kXUtXx3nPNq38kc60cDx/teKZdDJXEulzR5NPjZOcuU
	YiKIleMf+DdKg90wf5vlXTezUDpR3PPnVzgPCvzqfK8SiaN9xhs3N6Z7O89KAiNbTUC/
	0GLrHMPQnCtcitlganNESW2UqSt1XvYbn2RH5dIUY56WBGwBOWj5G7doCMr/wzXYOXPo
	EfiQqQ/MFE9j5R6n9RHBWfMK3Myn9Gz+DLueU2bImk5jZXoHLVnyJuDC2Gj8HRX3NifG
	J9OCW8gPAsURLMvpMQRtxRW74dcD7cTrlyYnIxm75p191KXQ7b08zZ3rQ3sKXRF72UG3
	7rwg==
X-Gm-Message-State: APjAAAWqde7rc7krdKZvgt62yxqn15OnGpJ7ZPCXByoxv5Vi1GQ9F3pV
	ToTR9D4jC4Z5CrcsJ+Ww9ivhIN6hjBUJCCNHV8d3sg==
X-Google-Smtp-Source: APXvYqyCYbjRIpjwEeSGolukiCOTXNw8C4SSP9ycOgfXGLinPd8wUGSRHSVfBirA48MFR9Ix1En/stGzGz8j5P5LvTo=
X-Received: by 2002:a17:902:4c:: with SMTP id
	70mr26034435pla.308.1559830386509; 
	Thu, 06 Jun 2019 07:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190506164440.37399-1-cai@lca.pw> <20190507073901.GC3486@suse.de>
In-Reply-To: <20190507073901.GC3486@suse.de>
Date: Thu, 6 Jun 2019 15:12:54 +0100
Message-ID: <CAPL0++5g+VVGkTJexCn+=ALOgzsfmB2JgE4OJjWsgJ1DUwT3-Q@mail.gmail.com>
Subject: Re: [PATCH -next v2] iommu/amd: fix a null-ptr-deref in map_sg()
To: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org, Qian Cai <cai@lca.pw>,
	linux-kernel@vger.kernel.org
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Joerg,

Is there anything I need to do to get this patch into linux-next? My
patch to convert the amd iommu driver to use the dma-iommu ops depends
on this patch.

Thanks,
Tom

On Tue, May 7, 2019 at 8:39 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> Hi Qian,
>
> On Mon, May 06, 2019 at 12:44:40PM -0400, Qian Cai wrote:
> > The commit 1a1079011da3 ("iommu/amd: Flush not present cache in
> > iommu_map_page") added domain_flush_np_cache() in map_sg() which
> > triggered a crash below during boot. sg_next() could return NULL if
> > sg_is_last() is true, so after for_each_sg(sglist, s, nelems, i), "s"
> > could be NULL which ends up deferencing a NULL pointer later here,
> >
> > domain_flush_np_cache(domain, s->dma_address, s->dma_length);
> >
> > so move domain_flush_np_cache() call inside for_each_sg() to loop over
> > each sg element.
>
> Thanks for the fix, but it is too late to merge it into the tree. I am
> going to revert commit 1a1079011da3 for now and we can try again in the
> next cycle.
>
>
> Thanks,
>
>         Joerg
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

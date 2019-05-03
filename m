Return-Path: <SRS0=zl4V=TD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B980C43219
	for <iommu@archiver.kernel.org>; Fri,  3 May 2019 05:26:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13082081C
	for <iommu@archiver.kernel.org>; Fri,  3 May 2019 05:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AqEzJvbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13082081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A94A23850;
	Fri,  3 May 2019 05:26:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5D921384B
	for <iommu@lists.linux-foundation.org>;
	Fri,  3 May 2019 05:25:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D5E498D
	for <iommu@lists.linux-foundation.org>;
	Fri,  3 May 2019 05:25:36 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id t76so5544596wmt.1
	for <iommu@lists.linux-foundation.org>;
	Thu, 02 May 2019 22:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=fiP1dSzJDSxcySo13/x6XymhVx+VfpZdcVooeC5gJFk=;
	b=AqEzJvbCcfFDntnYU56JtRgeHQPMo0DRo1hQXaws3BJPWPvHxNhO8a2xRjRGbI8P0i
	v4umZt28CK37wTrPQa76i7I4LArx4l90zW0ZIF8ZstoAYirVGXeXmOrFAQPN+nStz0oX
	LkpA/JwpT2+81wqkz/gqGKw6oHFqgRgNEI+zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=fiP1dSzJDSxcySo13/x6XymhVx+VfpZdcVooeC5gJFk=;
	b=Bq65eLMZzYwSGGEDm4g/fNWXCUC3C8/MYKpLnNj57ow+OeJSt3aDgPfAt9B/SX7AZC
	Q469IW/HCcXIFj7jbAd+E/IywXhdWI/1BJGTTWefvG5yYO/uhsVhCG8wH5QFROQc/8Ah
	5Nh6TGOngUcEKSMEUB1aj2LuQJkbMBfCZjxh7VvWYe2wM7Aj8Mo689bpaaqvW3m3CGfj
	YEGy7sqRhV5Rw3QxWuLzjN50jSfXKZuNKkupj14ygddAv2fM+29FEM7YnDiLTTKBW7yj
	aK1NBchamgh54A7vSQJ4AYhkZcyKHNZiSEnNxKOT9yzqSu05VAc3eXXg7omn60q2XsSB
	JPEg==
X-Gm-Message-State: APjAAAWl7wZR9LyC4hhYYmEcLMjNM/Kq4AWuDRhbsHM9iCtvpq8/jky5
	0ByWqqASYbWYNeBSO1RvfuqAaLLo6WimhTNpurRlyA==
X-Google-Smtp-Source: APXvYqyISYH7nKcdjdVCeeugv6IoT9S8/ObRtKGQv/5SEzsVgM1UETN2cuGzb4GZ/x3EBExgqyhrzlVjaHU1k+1xLF4=
X-Received: by 2002:a1c:a843:: with SMTP id r64mr4976939wme.45.1556861135435; 
	Thu, 02 May 2019 22:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
	<20190501113038.GA7961@e121166-lin.cambridge.arm.com>
	<20190501125530.GA15590@google.com>
	<CABe79T5w4hb572KHUhyrwAN7+Xxnz2jF9OGLpfTmAdHuLuO2Fw@mail.gmail.com>
	<7c44526aebb6403890bab8e252c16375@AcuMS.aculab.com>
In-Reply-To: <7c44526aebb6403890bab8e252c16375@AcuMS.aculab.com>
Date: Fri, 3 May 2019 10:55:24 +0530
Message-ID: <CABe79T5h3N3VZd12a51gGzOpw3-vrvNcQxS88q8xMi8=HWr6Tw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
To: David Laight <David.Laight@aculab.com>
Cc: "poza@codeaurora.org" <poza@codeaurora.org>, Ray Jui <rjui@broadcom.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	Robin Murphy <robin.murphy@arm.com>
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
From: Srinath Mannam via iommu <iommu@lists.linux-foundation.org>
Reply-To: Srinath Mannam <srinath.mannam@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi David,

Thanks for review, I will fix in next version of this patch set.

Regards,
Srinath.

On Thu, May 2, 2019 at 3:24 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Srinath Mannam
> > Sent: 01 May 2019 16:23
> ...
> > > > On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
> > > > > Few SOCs have limitation that their PCIe host can't allow few inbound
> > > > > address ranges. Allowed inbound address ranges are listed in dma-ranges
> > > > > DT property and this address ranges are required to do IOVA mapping.
> > > > > Remaining address ranges have to be reserved in IOVA mapping.
>
> You probably want to fix the english in the first sentence.
> The sense is reversed.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

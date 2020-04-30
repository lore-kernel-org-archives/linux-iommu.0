Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E805C8300C
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 10:41:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34657214D8
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 10:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoqNnmeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34657214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1328487E24;
	Thu, 30 Apr 2020 10:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HgOBmY+F9frH; Thu, 30 Apr 2020 10:41:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6D5A787DC2;
	Thu, 30 Apr 2020 10:41:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 555ADC0864;
	Thu, 30 Apr 2020 10:41:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FD92C0864;
 Thu, 30 Apr 2020 10:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7E7DC88569;
 Thu, 30 Apr 2020 10:41:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4X0mWQgl5ezQ; Thu, 30 Apr 2020 10:41:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5BBF088534;
 Thu, 30 Apr 2020 10:41:55 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E9B2320838;
 Thu, 30 Apr 2020 10:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588243315;
 bh=ZcTtHU52BJcfeJg1O8unpT4GgD3JTL20IZWKUTF8TKw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NoqNnmeKkPJyRneJ9nMRoBDO87ZWFjCkgG1ug60/9sKtzuDrOfUH6GYjuV09Epb5Z
 3mfxuTey9BjKXEuQX5GPlVcv4F4fS1W6Yt7XGl2CiupaHTqoL3BnztP8mNgZzFUZd2
 air1XKZM4E8l6ApPlZbshsahzH2kIyfc5OkPZmTc=
Date: Thu, 30 Apr 2020 11:41:50 +0100
From: Will Deacon <will@kernel.org>
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Message-ID: <20200430104149.GG19932@willie-the-truck>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck>
 <20200430103446.GH5097@quicinc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200430103446.GH5097@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, mst@redhat.com,
 jan.kiszka@siemens.com, jasowang@redhat.com, konrad.wilk@oracle.com,
 christoffer.dall@arm.com, virtualization@lists.linux-foundation.org,
 alex.bennee@linaro.org, iommu@lists.linux-foundation.org,
 stefano.stabellini@xilinx.com, pratikp@codeaurora.org,
 linux-kernel@vger.kernel.org
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

On Thu, Apr 30, 2020 at 04:04:46PM +0530, Srivatsa Vaddagiri wrote:
> * Will Deacon <will@kernel.org> [2020-04-30 11:14:32]:
> 
> > > +#ifdef CONFIG_VIRTIO_MMIO_OPS
> > >  
> > > +static struct virtio_mmio_ops *mmio_ops;
> > > +
> > > +#define virtio_readb(a)		mmio_ops->mmio_readl((a))
> > > +#define virtio_readw(a)		mmio_ops->mmio_readl((a))
> > > +#define virtio_readl(a)		mmio_ops->mmio_readl((a))
> > > +#define virtio_writeb(val, a)	mmio_ops->mmio_writeb((val), (a))
> > > +#define virtio_writew(val, a)	mmio_ops->mmio_writew((val), (a))
> > > +#define virtio_writel(val, a)	mmio_ops->mmio_writel((val), (a))
> > 
> > How exactly are these ops hooked up? I'm envisaging something like:
> > 
> > 	ops = spec_compliant_ops;
> > 	[...]
> > 	if (firmware_says_hypervisor_is_buggy())
> > 		ops = magic_qcom_ops;
> > 
> > am I wrong?
> 
> If CONFIG_VIRTIO_MMIO_OPS is defined, then I expect this to be unconditionally
> set to 'magic_qcom_ops' that uses hypervisor-supported interface for IO (for
> example: message_queue_send() and message_queue_recevie() hypercalls).

Hmm, but then how would such a kernel work as a guest under all the
spec-compliant hypervisors out there?

> > > +int register_virtio_mmio_ops(struct virtio_mmio_ops *ops)
> > > +{
> > > +	pr_info("Registered %s as mmio ops\n", ops->name);
> > > +	mmio_ops = ops;
> > 
> > Not looking good, and really defeats the point of standardising this stuff
> > imo.
> 
> Ok. I guess the other option is to standardize on a new virtio transport (like
> ivshmem2-virtio)?

I haven't looked at that, but I suppose it depends on what your hypervisor
folks are willing to accomodate.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

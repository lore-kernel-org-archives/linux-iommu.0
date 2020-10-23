Return-Path: <SRS0=xWGd=D6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF034C4363A
	for <iommu@archiver.kernel.org>; Fri, 23 Oct 2020 13:34:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AFB6208E4
	for <iommu@archiver.kernel.org>; Fri, 23 Oct 2020 13:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNaAR+Oj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFB6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DA3CB2076B;
	Fri, 23 Oct 2020 13:34:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x7qQZgxjhie0; Fri, 23 Oct 2020 13:34:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9DB1720362;
	Fri, 23 Oct 2020 13:34:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 687BEC088B;
	Fri, 23 Oct 2020 13:34:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E837C0052
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 13:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 449582076B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 13:34:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uyahs5Cdvk2t for <iommu@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 13:34:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 22FCD20362
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 13:34:46 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id k3so2395508ejj.10
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ybxYfhP0qOoEv/Z3igcvaiaTXfddpdf7DoEgMqfdT7A=;
 b=bNaAR+OjYmeeEzFzzZBJyzDKMbF4do7AhpOBiv9gsSMgNMqyq5/l4Ywkmo2cc+ESzz
 lH05Ok9PCaR+wHbV3UtzXlRRA8JfrhwHMLbb0Zj4NWXmQ4eNylNbUcFPFq5iZJZ3HE4A
 4A9t44PEBK+fF9Uz9ustwTwn9OxP5fS7OhuPeCnuRonbtMuE6/l3mFYgIYjLd95R3VaS
 dpWDsX5QYk6s/5ms0m/fST6rb3d8AWD5vnd1IhI1k1i/p+mau+CZ/smjsHXHtkBLdSSy
 daqTJeHfA9fXyZGQ5P3D3zhZtf8qMmTy+xx4KaAg3dJBOtHchBp51fOrGZD//kZ/nWsq
 0QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ybxYfhP0qOoEv/Z3igcvaiaTXfddpdf7DoEgMqfdT7A=;
 b=GvYi9okRgM5jny8AyMef0fAhVFudXA320JbpuyZr1eJvUcHiw3T8S/6OYTQe+XQT10
 wlfD2Y5T89qo215StADjID7ZtoMSQ8Q6v7FFYdaCeFTmJsGLrwey/fJoqiS3shRU2iP3
 Y0z0JTxvEm0U3HjZsq0w6I3Z167GLBCyShEKVITT2QF7cAV3KiMo6slWg+vfe1rVUD3M
 xUX44qWLkb0JBqsH+4NRpJRYeMcyc5Dwy7MkMJVGXukUjcyl4I2jbw3uX8v77X3u7NUu
 9HfqUSSzwSLCE+huPNwedHWsm+cLBma12WbRwMwH4bEeEPcET8dtQe8DSOdV5Ftl6+vM
 czHQ==
X-Gm-Message-State: AOAM5321wjxHyQoNrq/1RiFKNZuLLbH7t1ANwDfkEbJrKCvR+5S8jplJ
 b+J5BdjAbO1JUdTHjneu6nDDLQ==
X-Google-Smtp-Source: ABdhPJyJrpSO/TA1CFzr7cbXy98qv9z9QsL9dllO7dHUBx35a7onv2rOqG2fNwzz8c08kIOaSfCzMQ==
X-Received: by 2002:a17:906:1418:: with SMTP id
 p24mr1964123ejc.46.1603460084421; 
 Fri, 23 Oct 2020 06:34:44 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id q3sm788808edv.17.2020.10.23.06.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 06:34:43 -0700 (PDT)
Date: Fri, 23 Oct 2020 15:34:23 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [RFC PATCH 0/2] iommu: Avoid unnecessary PRI queue flushes
Message-ID: <20201023133423.GF2265982@myrica>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
 <20201015182211.GA54780@otc-nc-03>
 <20201016075923.GB1309464@myrica>
 <20201017112525.GA47206@otc-nc-03>
 <20201019140824.GA1478235@myrica>
 <20201019211608.GA79633@otc-nc-03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201019211608.GA79633@otc-nc-03>
Cc: kevin.tian@intel.com, "Lu, Baolu" <baolu.lu@intel.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jacon Jun Pan <jacob.jun.pan@intel.com>,
 linux-pci@vger.kernel.org, zhangfei.gao@linaro.org, dwmw2@infradead.org,
 linux-accelerators@lists.ozlabs.org
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

On Mon, Oct 19, 2020 at 02:16:08PM -0700, Raj, Ashok wrote:
> Hi Jean
> 
> On Mon, Oct 19, 2020 at 04:08:24PM +0200, Jean-Philippe Brucker wrote:
> > On Sat, Oct 17, 2020 at 04:25:25AM -0700, Raj, Ashok wrote:
> > > > For devices that *don't* use a stop marker, the PCIe spec says (10.4.1.2):
> > > > 
> > > >   To stop [using a PASID] without using a Stop Marker Message, the
> > > >   function shall:
> > > >   1. Stop queueing new Page Request Messages for this PASID.
> > > 
> > > The device driver would need to tell stop sending any new PR's.
> > > 
> > > >   2. Finish transmitting any multi-page Page Request Messages for this
> > > >      PASID (i.e. send the Page Request Message with the L bit Set).
> > > >   3. Wait for PRG Response Messages associated any outstanding Page
> > > >      Request Messages for the PASID.
> > > > 
> > > > So they have to flush their PR themselves. And since the device driver
> > > > completes this sequence before calling unbind(), then there shouldn't be
> > > > any oustanding PR for the PASID, and unbind() doesn't need to flush,
> > > > right?
> > > 
> > > I can see how the device can complete #2,3 above. But the device driver
> > > isn't the one managing page-responses right. So in order for the device to
> > > know the above sequence is complete, it would need to get some assist from
> > > IOMMU driver?
> > 
> > No the device driver just waits for the device to indicate that it has
> > completed the sequence. That's what the magic stop-PASID mechanism
> > described by PCIe does. In 6.20.1 "Managing PASID TLP Prefix Usage" it
> > says:
> 
> The goal is we do this when the device is in a messup up state. So we can't
> take for granted the device is properly operating which is why we are going
> to wack the device with a flr().
> 
> The only thing that's supposed to work without a brain freeze is the
> invalidation logic. Spec requires devices to respond to invalidations even when
> they are in the process of flr().
> 
> So when IOMMU does an invalidation wait with a Page-Drain, IOMMU waits till
> the response for that arrives before completing the descriptor. Due to 
> the posted semantics it will ensure any PR's issued and in the fabric are flushed 
> out to memory. 
> 
> I suppose you can wait for the device to vouch for all responses, but that
> is assuming the device is still functioning properly. Given that we use it
> in two places,
> 
> * Reclaiming a PASID - only during a tear down sequence, skipping it
>   doesn't really buy us much.

Yes I was only wondering about normal PASID reclaim operations, in
unbind(). Agreed that for FLR we need to properly clean the queue, though
I do need to do more thinking about this.

Anyway, having a full priq drain in unbind() isn't harmful, just
unnecessary delay in my opinion. I'll drop these patches for now but
thanks for the discussion.

Thanks,
Jean

> * During FLR this can't be skipped anyway due to the above sequence
>   requirement. 
> 
> > 
> > "A Function must have a mechanism to request that it gracefully stop using
> >  a specific PASID. This mechanism is device specific but must satisfy the
> >  following rules:
> >  [...]
> >  * When the stop request mechanism indicates completion, the Function has:
> >    [...]
> >    * Complied with additional rules described in Address Translation
> >      Services (Chapter 10 [10.4.1.2 quoted above]) if Address Translations
> >      or Page Requests were issued on the behalf of this PASID."
> > 
> > So after the device driver initiates this mechanism in the device, the
> > device must be able to indicate completion of the mechanism, which
> > includes completing all in-flight Page Requests. At that point the device
> > driver can call unbind() knowing there is no pending PR for this PASID.
> > 
> 
> Cheers,
> Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

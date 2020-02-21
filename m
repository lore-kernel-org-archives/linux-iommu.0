Return-Path: <SRS0=5edT=4J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FE9C35656
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 15:48:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495E1206E2
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 15:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YA6IJ1Fi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495E1206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 062AA220E5;
	Fri, 21 Feb 2020 15:48:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hOG54OrDerHF; Fri, 21 Feb 2020 15:48:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1943520035;
	Fri, 21 Feb 2020 15:48:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E898CC1D85;
	Fri, 21 Feb 2020 15:48:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12CB5C013E
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 15:48:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0DFD2875A1
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 15:48:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xfVjGmmvSH-R for <iommu@lists.linux-foundation.org>;
 Fri, 21 Feb 2020 15:48:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3E88C86497
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 15:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582300110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nMuXYm/rPXTbSbIyT257TjmGAho8shid8dR0IC6/tX8=;
 b=YA6IJ1FiGji84/q6rQce3E2+uzufjbEMgfq22tcZiwYwyLpIcInMdc0ersQkcU9VNFWIcS
 a7yoPSKShek+JHs3UAJTX/SLbD1we9yHmjqCJiyCpvl7SFxE7aOIrptk3TH7MYsf30ZYeE
 WUOHV5PromM9mpa7+CKhzpJte46dg34=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-qJsJA0eOO7KosT0YCTEf3g-1; Fri, 21 Feb 2020 10:48:27 -0500
X-MC-Unique: qJsJA0eOO7KosT0YCTEf3g-1
Received: by mail-qt1-f198.google.com with SMTP id t9so2063954qtn.2
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 07:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nMuXYm/rPXTbSbIyT257TjmGAho8shid8dR0IC6/tX8=;
 b=E+DZ0QoApL/ieGpkh6uBPBGNsADxYCeUi2gkLGxKGZw9cjsf7K+UeFs9ec149bW+h2
 soH5zYNPT02vw0JhyI24fthMskR5YTA87yO1F/lgeFpIKoltWW618IfVNr7865/61/wt
 4zgWZvN/ynh6VTxVcQz1TplLVwh6m3YuB+3Xu2fQ7L2GRGj+N4DTgTRnD77xm+faiLHY
 ERT5Hc40L4LxsqXKjX9uzZ58KItoOQ2Pob1+zUzrDVI3exvurNBKydYelsTo0bx6UPX9
 9W5Z7xe/t0x2CJV4DaBxge4Tl20RouQtqmDWW0+N85pPU85OFWzZ+u/uk6ZlZq0AS8on
 lEtA==
X-Gm-Message-State: APjAAAV++636e37OY169/HcRZ+lZDc3p556oyMlsCs2lTOMcefp/g9Ng
 fvqtYfs+xdittkEnfld7hOsrEtRkI6MRorcUWLMWQehdJ3KiwFOpyLXbKuclkYcPV4Mvuo2AYYZ
 H3HpK2Y44jvCWlgR0dIdelviYFMDMSg==
X-Received: by 2002:a05:620a:1326:: with SMTP id
 p6mr13887728qkj.50.1582300107004; 
 Fri, 21 Feb 2020 07:48:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZ5r0+jwSBeRkygk9EFdnmUIJfdBlfp8mfZ4GFs+3IU6OZoA6wUKcAnfNUKef1wSipRN9KMw==
X-Received: by 2002:a05:620a:1326:: with SMTP id
 p6mr13887707qkj.50.1582300106779; 
 Fri, 21 Feb 2020 07:48:26 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
 by smtp.gmail.com with ESMTPSA id o55sm1770202qtf.46.2020.02.21.07.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 07:48:25 -0800 (PST)
Date: Fri, 21 Feb 2020 10:48:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
Message-ID: <20200221104724-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-2-pasic@linux.ibm.com>
 <20200220161146.GA12709@lst.de>
 <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
 <20200220163135.GA13192@lst.de>
 <20200221032727.GC2298@umbus.fritz.box>
 <20200221140639.54928efe.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200221140639.54928efe.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Michael Mueller <mimu@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Fri, Feb 21, 2020 at 02:06:39PM +0100, Halil Pasic wrote:
> On Fri, 21 Feb 2020 14:27:27 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > On Thu, Feb 20, 2020 at 05:31:35PM +0100, Christoph Hellwig wrote:
> > > On Thu, Feb 20, 2020 at 05:23:20PM +0100, Christian Borntraeger wrote:
> > > > >From a users perspective it makes absolutely perfect sense to use the
> > > > bounce buffers when they are NEEDED. 
> > > > Forcing the user to specify iommu_platform just because you need bounce buffers
> > > > really feels wrong. And obviously we have a severe performance issue
> > > > because of the indirections.
> > > 
> > > The point is that the user should not have to specify iommu_platform.
> > > We need to make sure any new hypervisor (especially one that might require
> > > bounce buffering) always sets it,
> > 
> > So, I have draft qemu patches which enable iommu_platform by default.
> > But that's really because of other problems with !iommu_platform, not
> > anything to do with bounce buffering or secure VMs.
> > 
> > The thing is that the hypervisor *doesn't* require bounce buffering.
> > In the POWER (and maybe s390 as well) models for Secure VMs, it's the
> > *guest*'s choice to enter secure mode, so the hypervisor has no reason
> > to know whether the guest needs bounce buffering.  As far as the
> > hypervisor and qemu are concerned that's a guest internal detail, it
> > just expects to get addresses it can access whether those are GPAs
> > (iommu_platform=off) or IOVAs (iommu_platform=on).
> 
> I very much agree!
> 
> > 
> > > as was a rather bogus legacy hack
> > 
> > It was certainly a bad idea, but it was a bad idea that went into a
> > public spec and has been widely deployed for many years.  We can't
> > just pretend it didn't happen and move on.
> > 
> > Turning iommu_platform=on by default breaks old guests, some of which
> > we still care about.  We can't (automatically) do it only for guests
> > that need bounce buffering, because the hypervisor doesn't know that
> > ahead of time.
> 
> Turning iommu_platform=on for virtio-ccw makes no sense whatsover,
> because for CCW I/O there is no such thing as IOMMU and the addresses
> are always physical addresses.

Fix the name then. The spec calls is ACCESS_PLATFORM now, which
makes much more sense.

> > 
> > > that isn't extensibe for cases that for example require bounce buffering.
> > 
> > In fact bounce buffering isn't really the issue from the hypervisor
> > (or spec's) point of view.  It's the fact that not all of guest memory
> > is accessible to the hypervisor.  Bounce buffering is just one way the
> > guest might deal with that.
> > 
> 
> Agreed.
> 
> Regards,
> Halil
> 
> 
> 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

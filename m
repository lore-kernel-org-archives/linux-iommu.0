Return-Path: <SRS0=AFVC=6N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56787C8300C
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 04:57:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D822072A
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 04:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I48rqDZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D822072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E2155868CE;
	Wed, 29 Apr 2020 04:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q7S_eh-7td2L; Wed, 29 Apr 2020 04:57:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C991286542;
	Wed, 29 Apr 2020 04:57:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADB39C0888;
	Wed, 29 Apr 2020 04:57:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03B3FC0172
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 04:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E9D9622BCC
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 04:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ILVavoYK2Fnm for <iommu@lists.linux-foundation.org>;
 Wed, 29 Apr 2020 04:57:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id A3DBC20464
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 04:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588136271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3nNJuKtjgttr9/75Tz29rm+bXY1XXpiZYQWZLWivAVY=;
 b=I48rqDZjA9pz6htren1Cj+qL/Vs/kUaF/ee0KzvlUwi1UuLIHeknrsc6h6ZMgbgFbiT3ft
 0wkEnIVO05t9neEG+nRBkSYHb9DWT6HJJzCEtg2H3RBH3yggnaf9A3A5rBQLKCKEv699tG
 7JHIczSG1XamOewj6FYyac6gakB+Bm4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-xyMFmAp1MMazPrkf5aQMjg-1; Wed, 29 Apr 2020 00:57:49 -0400
X-MC-Unique: xyMFmAp1MMazPrkf5aQMjg-1
Received: by mail-wr1-f69.google.com with SMTP id i10so1099074wrq.8
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 21:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3nNJuKtjgttr9/75Tz29rm+bXY1XXpiZYQWZLWivAVY=;
 b=NwA93YyYrkBhEDBy+lQcObijDBYhVU7TLcSSubY3yg9VuwYK23zWqbBuLQd2oZ+38r
 zdOuzo+HyP7YFvpXqoc1bLNKoOMkYr4nWurt+yCyMpEx3PUiRLlMKl/eWk8mTyLCsEQS
 28yYNZlPmuTXQQvKA+GvbzH2ELr68j+6Xu3nMhPvBwVI4/wg0sBzkH5O0g1UTjIQRY5Y
 CC1ijmQGnQRWnfkcgxhuTxfdgfUn5pao1m5mcmp15ihwVKKhXRvg4u9oZsxgiOZf8p3g
 xT4auQMBSF+B8EpWU7VBfz8RikEboi5/zADRZZj3U/cyAOR/wpjMgW2jMNcElS6gcG1L
 +CxA==
X-Gm-Message-State: AGi0PuaGzRmjWUN3A7aCUhC/Ay3AwLUiHkR47Yz1oUHGoMqkiqv09Bt/
 Jhyd8aa0yxEWTIhjBL6/R2DUSO98N7Ewb2G9s4AFXsDVUPaaEnjEiEURS/S4SiZhUNdMIS5YhYQ
 YedjLU8yahylhX6F+jDWeD0c7GnUlWQ==
X-Received: by 2002:adf:f884:: with SMTP id u4mr36138575wrp.171.1588136267246; 
 Tue, 28 Apr 2020 21:57:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypLIkFFOdPPZMhssIAseU7SHZrcOaozQItYfLHySNTFChvxRbYL5g64fDwfcVxKEgSHYYt1vng==
X-Received: by 2002:adf:f884:: with SMTP id u4mr36138548wrp.171.1588136267003; 
 Tue, 28 Apr 2020 21:57:47 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 h17sm5885719wmm.6.2020.04.28.21.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 21:57:46 -0700 (PDT)
Date: Wed, 29 Apr 2020 00:57:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <20200429004531-mutt-send-email-mst@kernel.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, will@kernel.org,
 konrad.wilk@oracle.com, jan.kiszka@siemens.com, jasowang@redhat.com,
 Srivatsa Vaddagiri <vatsa@codeaurora.org>, christoffer.dall@arm.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 stefano.stabellini@xilinx.com, alex.bennee@linaro.org,
 linux-kernel@vger.kernel.org, pratikp@codeaurora.org
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

On Wed, Apr 29, 2020 at 10:22:32AM +0800, Lu Baolu wrote:
> On 2020/4/29 4:41, Michael S. Tsirkin wrote:
> > On Tue, Apr 28, 2020 at 11:19:52PM +0530, Srivatsa Vaddagiri wrote:
> > > * Michael S. Tsirkin<mst@redhat.com>  [2020-04-28 12:17:57]:
> > > 
> > > > Okay, but how is all this virtio specific?  For example, why not allow
> > > > separate swiotlbs for any type of device?
> > > > For example, this might make sense if a given device is from a
> > > > different, less trusted vendor.
> > > Is swiotlb commonly used for multiple devices that may be on different trust
> > > boundaries (and not behind a hardware iommu)?
> > Even a hardware iommu does not imply a 100% security from malicious
> > hardware. First lots of people use iommu=pt for performance reasons.
> > Second even without pt, unmaps are often batched, and sub-page buffers
> > might be used for DMA, so we are not 100% protected at all times.
> > 
> 
> For untrusted devices, IOMMU is forced on even iommu=pt is used;

I think you are talking about untrusted *drivers* like with VFIO.

On the other hand, I am talking about things like thunderbolt
peripherals being less trusted than on-board ones.

Or possibly even using swiotlb for specific use-cases where
speed is less of an issue.

E.g. my wifi is pretty slow anyway, and that card is exposed to
malicious actors all the time, put just that behind swiotlb
for security, and leave my graphics card with pt since
I'm trusting it with secrets anyway.


> and
> iotlb flush is in strict mode (no batched flushes); ATS is also not
> allowed. Swiotlb is used to protect sub-page buffers since IOMMU can
> only apply page granularity protection. Swiotlb is now used for devices
> from different trust zone.
> 
> Best regards,
> baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

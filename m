Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B31C48BCD
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 14:31:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478A8613AE
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 14:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478A8613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 104BD401D9;
	Wed,  9 Jun 2021 14:31:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CwQ-q9WUecB8; Wed,  9 Jun 2021 14:31:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D28374017B;
	Wed,  9 Jun 2021 14:31:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 984B6C000D;
	Wed,  9 Jun 2021 14:31:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3584C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 14:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B86CD608E3
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 14:31:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TMXf5BvPCXCE for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 14:31:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06584608FD
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623249098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKs4cxUwdZYTDh0jeAao9VZnEeCHbGVX5Jimoj8fR6o=;
 b=S3Z+TveI8z2k9mAwKuMH2DVfkrLgjoj0S4PD4LG0IsUMRbE/1KNwzBzzsV/lxXqa/2lt8R
 QL+gdcN1Md6bhMZ7Ia6s06/Bdw29cZ02z/f2sapeh8GlPOvs/cY7uuO4k++GEBOWaQMAoN
 nN0w7OUUlntFeWZ7ePWatqDzKEwhPGM=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-uOnnzUFaO1ugvfQux3tU-w-1; Wed, 09 Jun 2021 10:31:37 -0400
X-MC-Unique: uOnnzUFaO1ugvfQux3tU-w-1
Received: by mail-oo1-f69.google.com with SMTP id
 e10-20020a4ab14a0000b029020e1573bdb7so15637783ooo.9
 for <iommu@lists.linux-foundation.org>; Wed, 09 Jun 2021 07:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=tKs4cxUwdZYTDh0jeAao9VZnEeCHbGVX5Jimoj8fR6o=;
 b=oyBZ1K2CcuRk08OOiUtEQXvZs5c8SXHUCwOr2JRFSdLyF/iwHFJ4ivfv9pGQVNXoiF
 cc/Kl2djgOdwEuHmm0L7knTUUHwUVILSWqse3dZIZ8GgsFpIO3FEW57jWssKziIGddJq
 AqriY5HSgq1erRDWyGPtRebpGgxp0+shYodD0Q11EA6/y4cckF2rTEX5ZPRvvDd8KVuF
 94pK+4mQ4dulAO/EkNsXcqgDqyKhQfKQ0vBigsideaf0tt6ipzvlGjWybdEg3i/UFfP4
 CMj2cmxWQPMfjX/dTGa2lkrMc9RCLEmwwfNCvbGVemeEXwL3L4Iv7W2Zu+nmNXMgW6u7
 aBtQ==
X-Gm-Message-State: AOAM533YVGKJpA3T65Jp8xy5jY3wmp9iOynL9UdBgh4znHVLeqYRkJOd
 6tizeqzjXqpclOYHUdVwiYV7JSBu6T8gJHWvFCJKfgJiCCXsrquaLs2SMP4rmVsKrh5G7dmNv9e
 0gNVb3jMwUIEBkRsvDKIfobFxwjNbfQ==
X-Received: by 2002:a9d:6054:: with SMTP id v20mr13240730otj.39.1623249096588; 
 Wed, 09 Jun 2021 07:31:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAM19Ewy08wPKi3QBA6QQ1RgaDDfMkc/aSlgAItOhMLGMzwR7RPxVpUCrWoFK5Tkcq4qSUxQ==
X-Received: by 2002:a9d:6054:: with SMTP id v20mr13240702otj.39.1623249096396; 
 Wed, 09 Jun 2021 07:31:36 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id u26sm24144ote.53.2021.06.09.07.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jun 2021 07:31:35 -0700 (PDT)
Date: Wed, 9 Jun 2021 08:31:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210609083134.396055e3.alex.williamson@redhat.com>
In-Reply-To: <20210609115445.GX1002214@nvidia.com>
References: <20210604172207.GT1002214@nvidia.com>
 <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
 <20210607175926.GJ1002214@nvidia.com>
 <fdb2f38c-da1f-9c12-af44-22df039fcfea@redhat.com>
 <20210608131547.GE1002214@nvidia.com>
 <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
 <20210608124700.7b9aa5a6.alex.williamson@redhat.com>
 <20210608190022.GM1002214@nvidia.com>
 <ec0b1ef9-ae2f-d6c7-99b7-4699ced146e4@metux.net>
 <671efe89-2430-04fa-5f31-f52589276f01@redhat.com>
 <20210609115445.GX1002214@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Wed, 9 Jun 2021 08:54:45 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jun 09, 2021 at 11:11:17AM +0200, Paolo Bonzini wrote:
> > On 09/06/21 10:51, Enrico Weigelt, metux IT consult wrote:  
> > > On 08.06.21 21:00, Jason Gunthorpe wrote:
> > >   
> > > > Eg I can do open() on a file and I get to keep that FD. I get to keep
> > > > that FD even if someone later does chmod() on that file so I can't
> > > > open it again.
> > > > 
> > > > There are lots of examples where a one time access control check
> > > > provides continuing access to a resource. I feel the ongoing proof is
> > > > the rarity in Unix.. 'revoke' is an uncommon concept in Unix..  
> > > 
> > > Yes, it's even possible that somebody w/ privileges opens an fd and
> > > hands it over to somebody unprivileged (eg. via unix socket). This is
> > > a very basic unix concept. If some (already opened) fd now suddenly
> > > behaves differently based on the current caller, that would be a break
> > > with traditional unix semantics.  

That's not the scenario here, this would work as expected.  It's not a
matter of who uses the fd it's that a property of the fd that provided
elevated access has been removed.  I only need to look as far as sudo
to find examples of protocols where having access at some point in time
does not guarantee ongoing access.

If we go back to the wbinvd ioctl mechanism, if I call that ioctl with
an ioasidfd that contains no devices, then I shouldn't be able to
generate a wbinvd on the processor, right?  If I add a device,
especially in a configuration that can generate non-coherent DMA, now
that ioctl should work.  If I then remove all devices from that ioasid,
what then is the difference from the initial state.  Should the ioctl
now work because it worked once in the past?

If we equate KVM to the process access to the ioctl, then a reference
or notification method should be used to retain or mark the end of that
access.  This is no different than starting a shell via sudo (ie. an
ongoing reference) or having the previous authentication time out, or
in our case be notified it has expired.

> > That's already more or less meaningless for both KVM and VFIO, since they
> > are tied to an mm.  
> 
> vfio isn't supposed to be tied to a mm.

vfio does accounting against an mm, why shouldn't it be tied to an mm?
Maybe you mean in the new model where vfio is just a device driver?
Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

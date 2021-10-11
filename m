Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DD8C433EF
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A93160BD3
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A93160BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF01B81BD4;
	Mon, 11 Oct 2021 14:52:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gux3DofQb5VD; Mon, 11 Oct 2021 14:52:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8ACBE81B70;
	Mon, 11 Oct 2021 14:52:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CB20C0011;
	Mon, 11 Oct 2021 14:52:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2A06C000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 14:52:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A673B60680
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 14:52:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RCQwxE-27Qj6 for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 14:52:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD4BD605F7
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 14:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633963972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89zmHIrU5FNV2xiprQFh1fRhF37l31tX1FhfGy5HLqE=;
 b=cCKrVsTxMGoz1E3ZnLStiEtq0jHQXfkgsnYVJ3kAOza2KFwA9Bjnplk/wSN+RPFZRG9I8k
 DlLQkwRd1my4U/TtGTN8YzyC4WMIWLM4kB0pCuxp7n2YjOEVC3XDeOTikXxWRG1Q5r42J7
 rmr2rU6Of5JXZdVKL7/iiePMKElL+Jg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-wxo8O-4wOkOW1GkFbFLc_A-1; Mon, 11 Oct 2021 10:52:51 -0400
X-MC-Unique: wxo8O-4wOkOW1GkFbFLc_A-1
Received: by mail-oo1-f69.google.com with SMTP id
 f5-20020a4a9d45000000b002b66b1d7496so10175618ook.22
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 07:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=89zmHIrU5FNV2xiprQFh1fRhF37l31tX1FhfGy5HLqE=;
 b=YVGgOrf28mVndTpnQwRhs7JLX9Fjgpz03jNOJtUhOd7MeDWIfemo0U5qAyCuqDFydD
 GbotgAKoYt8mCCnMeOsb4+B6vci6d2XQ1nnGhWnRurWo5NIUlfyRpygXUpAbjCfs2U+H
 5i6wMv/jXelXVfO3BF6c3pxP5cftdUlSgY9yRVklbBX1UGX+zBSijxwdZrOQ/FnK9yiY
 JUA9/Wi2RXH9sOzMJw+ioI4qXmf+9eksikvGvgvD//ouXosJJpU52HBhqd8F3NOkm+ZU
 HHTs4o+Bwk36oJNv+mLJdeMyhFvvxgTu+KWfvl0F64VzU3oKHS9WEkQPxzTxcwVxcSWz
 AvZA==
X-Gm-Message-State: AOAM532+VLgc59yHwv98weE1+Z9vX2lFTkLdM1pshwEMtBGSAj9J7RVq
 jC+ge5HGnqQ5MwP8p6e3IdoYZecVvatjieyyO+7TY81gLnSh5TOuZ0+kX+1P/g4aSc3SKMOXT36
 CcxO4HDhthh+Lzx6f1dd52xFeP6shsQ==
X-Received: by 2002:a4a:9541:: with SMTP id n1mr14720675ooi.62.1633963970705; 
 Mon, 11 Oct 2021 07:52:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9v/DeW+zwCiT+kQifox09JmpwS7WRLrIq2+cIai843pldXiRD31wdX0Bt0DnZuoCVFoc0oQ==
X-Received: by 2002:a4a:9541:: with SMTP id n1mr14720661ooi.62.1633963970465; 
 Mon, 11 Oct 2021 07:52:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
 by smtp.gmail.com with ESMTPSA id d18sm976983ook.14.2021.10.11.07.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Oct 2021 07:52:50 -0700 (PDT)
Date: Mon, 11 Oct 2021 08:52:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ajay Garg <ajaygargnsit@gmail.com>
Subject: Re: [PATCH] iommu: intel: remove flooding of non-error logs, when
 new-DMA-PTE is the same as old-DMA-PTE.
Message-ID: <20211011085247.7f887b12.alex.williamson@redhat.com>
In-Reply-To: <CAHP4M8VPem7xEtx3vQPm3bzCQif7JZFiXgiUGZVErTt5vhOF8A@mail.gmail.com>
References: <20211002124012.18186-1-ajaygargnsit@gmail.com>
 <b9afdade-b121-cc9e-ce85-6e4ff3724ed9@linux.intel.com>
 <CAHP4M8Us753hAeoXL7E-4d29rD9+FzUwAqU6gKNmgd8G0CaQQw@mail.gmail.com>
 <20211004163146.6b34936b.alex.williamson@redhat.com>
 <CAHP4M8UeGRSqHBV+wDPZ=TMYzio0wYzHPzq2Y+JCY0uzZgBkmA@mail.gmail.com>
 <CAHP4M8UD-k76cg0JmeZAwaWh1deSP82RCE=VC1zHQEYQmX6N9A@mail.gmail.com>
 <CAHP4M8VPem7xEtx3vQPm3bzCQif7JZFiXgiUGZVErTt5vhOF8A@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org
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

On Mon, 11 Oct 2021 11:49:33 +0530
Ajay Garg <ajaygargnsit@gmail.com> wrote:

> The flooding was seen today again, after I booted the host-machine in
> the morning.
> Need to look what the heck is going on ...
> 
> On Sun, Oct 10, 2021 at 11:45 AM Ajay Garg <ajaygargnsit@gmail.com> wrote:
> >  
> > > I'll try and backtrack to the userspace process that is sending these ioctls.
> > >  
> >
> > The userspace process is qemu.
> >
> > I compiled qemu from latest source, installed via "sudo make install"
> > on host-machine, rebooted the host-machine, and booted up the
> > guest-machine on the host-machine. Now, no kernel-flooding is seen on
> > the host-machine.
> >
> > For me, the issue is thus closed-invalid; admins may take the
> > necessary action to officially mark ;)

Even this QEMU explanation doesn't make a lot of sense, vfio tracks
userspace mappings and will return an -EEXIST error for duplicate or
overlapping IOVA entries.  We expect to have an entirely empty IOMMU
domain when a device is assigned, but it seems the only way userspace
can trigger duplicate PTEs would be if mappings already exist, or we
have a bug somewhere.

If the most recent instance is purely on bare metal, then it seems the
host itself has conflicting mappings.  I can only speculate with the
limited data presented, but I'm suspicious there's something happening
with RMRRs here (but that should also entirely preclude assignment).
dmesg, lspci -vvv, and VM configuration would be useful.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

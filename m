Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7280AC433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 20:27:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E949A64E3D
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 20:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E949A64E3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B457A870B6;
	Tue,  2 Feb 2021 20:27:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RRnw1ip0gJr1; Tue,  2 Feb 2021 20:27:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E49FC8708D;
	Tue,  2 Feb 2021 20:27:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD233C0FA7;
	Tue,  2 Feb 2021 20:27:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4F6BC013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 20:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A2943863A3
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 20:27:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IJB93r6te3Cy for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 20:27:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 46BC4857D8
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 20:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612297639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tDsrFRMQrIvDDYbEwv88qxOg6G0MNCZtkkWJA4if8U8=;
 b=Oeev9JU8AzTvWfOf9P/ME27l/ieU9ZYj8Za3Xygo8dWPh1QtoSP/j3q5AzbgpFz2NkjLjj
 XnNCL2fhSffX7h6om+rCjUBM1nSwxeAPRiLBNd/VZFSIdibKTQ2Y1tqf9RVmSiZOAY7cv8
 h+ljBiDzD6io1rZv9RnGYref3Uy4Y7Y=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-7IdjqCc7MWaGnGGAYkgAVw-1; Tue, 02 Feb 2021 15:27:15 -0500
X-MC-Unique: 7IdjqCc7MWaGnGGAYkgAVw-1
Received: by mail-io1-f69.google.com with SMTP id x26so19715693ior.7
 for <iommu@lists.linux-foundation.org>; Tue, 02 Feb 2021 12:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tDsrFRMQrIvDDYbEwv88qxOg6G0MNCZtkkWJA4if8U8=;
 b=JTM/Cy1RFDkQ1XpA7HjUo4ZCfU2KdSnPnbqzcFYGOUAJ+LoccB8/6jepJzS8lXTUUf
 Kyj5dSvMVKOxuneyBem5EgcWNzrfvIgPePiHL1px7MH4slM/suQFyHySsRTAfNzpXgjW
 zawel5JVdRb0PzfRc6jzdWF9nDhnf1z56hOcgfFmBcZtoLKK7UYl/ELpXjzn1uQJX3QR
 f7q4Pk28QIO8f3GW5HID3Pq+nmpEEUhKppY30kqzi/IHvPsijlOeunC2dLjO+I+qTWGH
 XD2a+Emo8bmqzDJXbPFYhSA7VLZp7E46tkZreq0OKWiw8BX8l3l4vp0xGYTTe9wq0GVb
 tBLw==
X-Gm-Message-State: AOAM530ENy/YXWwJnuMmL+F+C9A60euOKRv59NKYFuTK/T++ksuht0W+
 c8ecIJLZxteNqxzFMTZeB0Jzw75JxBl8uqNuvfqtSQ7xyFKrwFjPz6TCHba06cBorLz8jjuHnyR
 F9fDRlF9X6fvUSxgfvIstgc3yBHZ/kg==
X-Received: by 2002:a92:d142:: with SMTP id t2mr18783494ilg.38.1612297635270; 
 Tue, 02 Feb 2021 12:27:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFLCZZyPXGZWoCFHD3t7Png1K6HOO/dsSBp7yJg61qjlud7aZ0uDJ+XyjmYIREPsUe0dVdHA==
X-Received: by 2002:a92:d142:: with SMTP id t2mr18783479ilg.38.1612297635087; 
 Tue, 02 Feb 2021 12:27:15 -0800 (PST)
Received: from localhost ([97.118.140.0])
 by smtp.gmail.com with ESMTPSA id z7sm2559259iod.8.2021.02.02.12.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 12:27:14 -0800 (PST)
Date: Tue, 2 Feb 2021 13:27:13 -0700
From: Al Stone <ahs3@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [EXTERNAL] Re: Question regarding VIOT proposal
Message-ID: <20210202202713.GF702808@redhat.com>
References: <MW2PR2101MB1130313B4AE39B7EAC09349B80EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201105134503.GA950007@myrica>
 <MW2PR2101MB113096E822AD835F658808B480EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201106135745.GB974750@myrica>
 <MW2PR2101MB11301F2185D1C9016310728E80F21@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201203230127.GD4343@redhat.com>
 <20201204180924.GA1922896@myrica>
 <20201204201825.GG4343@redhat.com> <YBkYsSHGUfG91NoN@myrica>
MIME-Version: 1.0
In-Reply-To: <YBkYsSHGUfG91NoN@myrica>
User-Agent: Mutt/1.14.6 (2020-07-11)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ahs3@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Boeuf,
 Sebastien" <sebastien.boeuf@intel.com>,
 Alexander Grest <Alexander.Grest@microsoft.com>,
 Yinghan Yang <Yinghan.Yang@microsoft.com>
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

On 02 Feb 2021 10:17, Jean-Philippe Brucker wrote:
> Hi Al,
> 
> On Fri, Dec 04, 2020 at 01:18:25PM -0700, Al Stone wrote:
> > > I updated the doc: https://jpbrucker.net/virtio-iommu/viot/viot-v9.pdf
> > > You can incorporate it into the ASWG proposal.
> > > Changes since v8:
> > > * One typo (s/programing/programming/)
> > > * Modified the PCI Range node to include a segment range.
> > > 
> > > I also updated the Linux and QEMU implementations on branch
> > > virtio-iommu/devel in https://jpbrucker.net/git/linux/ and
> > > https://jpbrucker.net/git/qemu/
> > > 
> > > Thanks again for helping with this
> > > 
> > > Jean
> > 
> > Perfect.  Thanks.  I'll update the ASWG info right away.
> 
> Has there been any more feedback on the VIOT specification? I'm wondering
> when we can start upstreaming support for it.
> 
> Thanks,
> Jean

Ah, sorry, Jean.  I meant to get back to you sooner.  My apologies.

The latest version that resulted from the discussion with Yinghan of
Microsoft is the one in front the ASWG; I think if you upstream that
version, it should be identical to the spec when it is next published
(post ACPI 6.4).

The process is: (1) propose the change, (2) review it in committee,
(3) give people more time to think about it, then (4) have a finale
vote.  We've been iterating over (1), (2) and (3).  Since there was
no new discussion at the last meeting, we should have the final vote
on this (4) in the next meeting.  I had hoped we could do that last
week but the meeting was canceled at the last minute.  I hope to have
the final vote this Thursday and will let you know as soon as it has
been decided.

My apologies for the delays; getting things done by committee always
takes a bazillion times longer than one would think.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

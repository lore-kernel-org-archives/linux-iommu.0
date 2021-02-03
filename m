Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2B5C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 08:47:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17CE164F59
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 08:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CE164F59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B16C7845C7;
	Wed,  3 Feb 2021 08:47:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m0EaVmB2TbFN; Wed,  3 Feb 2021 08:47:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1B5918455D;
	Wed,  3 Feb 2021 08:47:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5A4BC0174;
	Wed,  3 Feb 2021 08:47:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB03FC013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 08:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AA22C204C0
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 08:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sRdkqcbakBna for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 08:47:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by silver.osuosl.org (Postfix) with ESMTPS id 525D62043C
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 08:47:17 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id g10so7595791eds.2
 for <iommu@lists.linux-foundation.org>; Wed, 03 Feb 2021 00:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OmhrGVHvgwNBkootp3ymQtjsbjgQFm9ToO6FCnZ9ME8=;
 b=mtx+TGIM9zHxt4PXU1So+HCzps8PYtnex0ywlLeyPNmIw9YMJtx7Lfth9YbGRRv5yR
 b3wgkrVf4eUUb4Zit0jSqzM6FONFpfeCqbJM0Vhm4CgkCw+mcqpEU7BrOeV4vIB7EMVr
 0VmNtPrB1SzoXxpeLzW2+Zm/K5bl9yQsXyL99sJsjqMo3MBZQhcX8+vBpqpYK3jwHhlU
 qWd5+XuT0J4z1zMrs0/OkJNzJ61kKmdye1LumnzhgpNnDfwHDkf7c1W98r6vYmr1pM4h
 diuRX+4oGKEqD8JtGlijqEgwZwlamssUyIFYFuM5EXwaC0ml2xAmN8ZCPDAol2s55zKW
 rQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OmhrGVHvgwNBkootp3ymQtjsbjgQFm9ToO6FCnZ9ME8=;
 b=RDxW98gqL0VW53I+brpdH3AOIPCnCdrprRUVwJgWQxFR8kc6mw0U6e0DL/esjDfDsL
 4qMBT8jgN3Q4VlJKEAhFBdaPMej0uNxNVRyfitFGw/+Pjx9adgm+lWDtr7Gu3qRCmWNE
 POiXqj2p3+kJTJeZqqKmxmFx4IWCG8ztval/Bs6k+JExTyJt3fKJSLCjZF9y3FCL87GZ
 ZZw00MBbJZBUk2UzEjqCdsE9TTiGx77MznMhuXMu0MIqMOIJXlbt/nDkNlgV56czlf5y
 Zfxk89mcKS/Eaz9lVzWOPW4Bb82kl9pzSKZbN8KbtWEl+CbTKBQ/cL3I7Rnjd6xioL/X
 C4ww==
X-Gm-Message-State: AOAM531/acwgSFs4p01LbTTdNjaoRapCb1qC01EPus5C9mS1ufMbZzJu
 y1ozMYneo7l1M21chXSKorhp7Q==
X-Google-Smtp-Source: ABdhPJyObXqhOwUN/k0V7mCKbWUH/jk5rzKuaiJP3SwYHm8pIY80K7WeGRVLkiKAYGSdvTDjzb7NGg==
X-Received: by 2002:a05:6402:79a:: with SMTP id
 d26mr1866048edy.266.1612342035689; 
 Wed, 03 Feb 2021 00:47:15 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id k9sm667073ejp.83.2021.02.03.00.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Feb 2021 00:47:15 -0800 (PST)
Date: Wed, 3 Feb 2021 09:46:56 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Al Stone <ahs3@redhat.com>
Subject: Re: [EXTERNAL] Re: Question regarding VIOT proposal
Message-ID: <YBpjAF3Q+NeJblE9@myrica>
References: <MW2PR2101MB1130313B4AE39B7EAC09349B80EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201105134503.GA950007@myrica>
 <MW2PR2101MB113096E822AD835F658808B480EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201106135745.GB974750@myrica>
 <MW2PR2101MB11301F2185D1C9016310728E80F21@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201203230127.GD4343@redhat.com>
 <20201204180924.GA1922896@myrica>
 <20201204201825.GG4343@redhat.com> <YBkYsSHGUfG91NoN@myrica>
 <20210202202713.GF702808@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210202202713.GF702808@redhat.com>
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

On Tue, Feb 02, 2021 at 01:27:13PM -0700, Al Stone wrote:
> On 02 Feb 2021 10:17, Jean-Philippe Brucker wrote:
> > Hi Al,
> > 
> > On Fri, Dec 04, 2020 at 01:18:25PM -0700, Al Stone wrote:
> > > > I updated the doc: https://jpbrucker.net/virtio-iommu/viot/viot-v9.pdf
> > > > You can incorporate it into the ASWG proposal.
> > > > Changes since v8:
> > > > * One typo (s/programing/programming/)
> > > > * Modified the PCI Range node to include a segment range.
> > > > 
> > > > I also updated the Linux and QEMU implementations on branch
> > > > virtio-iommu/devel in https://jpbrucker.net/git/linux/ and
> > > > https://jpbrucker.net/git/qemu/
> > > > 
> > > > Thanks again for helping with this
> > > > 
> > > > Jean
> > > 
> > > Perfect.  Thanks.  I'll update the ASWG info right away.
> > 
> > Has there been any more feedback on the VIOT specification? I'm wondering
> > when we can start upstreaming support for it.
> > 
> > Thanks,
> > Jean
> 
> Ah, sorry, Jean.  I meant to get back to you sooner.  My apologies.
> 
> The latest version that resulted from the discussion with Yinghan of
> Microsoft is the one in front the ASWG; I think if you upstream that
> version, it should be identical to the spec when it is next published
> (post ACPI 6.4).
> 
> The process is: (1) propose the change, (2) review it in committee,
> (3) give people more time to think about it, then (4) have a finale
> vote.  We've been iterating over (1), (2) and (3).  Since there was
> no new discussion at the last meeting, we should have the final vote
> on this (4) in the next meeting.  I had hoped we could do that last
> week but the meeting was canceled at the last minute.  I hope to have
> the final vote this Thursday and will let you know as soon as it has
> been decided.
> 
> My apologies for the delays; getting things done by committee always
> takes a bazillion times longer than one would think.

No worries, thanks a lot for the update!

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

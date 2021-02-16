Return-Path: <SRS0=z+Ry=HS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F290C433E0
	for <iommu@archiver.kernel.org>; Tue, 16 Feb 2021 21:31:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0912764D99
	for <iommu@archiver.kernel.org>; Tue, 16 Feb 2021 21:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0912764D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBA8C6F5C6
	for <iommu@archiver.kernel.org>; Tue, 16 Feb 2021 21:31:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZCIWTJ_UHYcG for <iommu@archiver.kernel.org>;
	Tue, 16 Feb 2021 21:31:19 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 35C566F5CB; Tue, 16 Feb 2021 21:31:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DF746F488;
	Tue, 16 Feb 2021 21:31:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4076BC0893;
	Tue, 16 Feb 2021 21:31:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DC6FC013A
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 21:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E98E6F488
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 21:31:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NtoU2Spggzp5 for <iommu@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 21:31:12 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id D60C36F4B8; Tue, 16 Feb 2021 21:31:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B4756F4C8
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 21:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613511069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=35v6EwmU702g+4spdUScpDEt2oPpfCEIKx5/XzY2Gww=;
 b=dlSwIvq7v0QScHUZAP80D+XDiE/jGjun98ZL98mkxYfs1RGi4q24yh6D4eUz1APy7Cjuws
 LMbijrYSeh4IJfvAcrR3naKwnu8wzXjAXrwsT8y8nPwKOFPn7SXABJh3m3Cq8vFx9jMnnb
 eHB69x9cgrujPq4nb1W7fSfg/qpcxpc=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-kO7JTvDzPYmRa7BFphotTg-1; Tue, 16 Feb 2021 16:31:05 -0500
X-MC-Unique: kO7JTvDzPYmRa7BFphotTg-1
Received: by mail-io1-f71.google.com with SMTP id l16so10172244ion.8
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 13:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=35v6EwmU702g+4spdUScpDEt2oPpfCEIKx5/XzY2Gww=;
 b=M9zGyEz0jCGxpNhLkep5V5MjLf/+qCeb59nqf+U27gS9i5cp6NKr9u73ADDTX+H2/u
 9GXhwPSSJraLmOoxB8+MS9LE4XOPxExhmwCdmiHOVrG5s7VJnG8ZRm63dguDFkmbHwDE
 LpEnhLVWHjirYyMbdvXDpcf160+dRblofvvqkv/8AgoQFstsQkX2Lbnyz2pQBe8ymg0i
 bd5hJpy6rBfqpcciZ2Ft4tJEaZgncXm84NESUaazz41zBa1wkpNk8XyE5PzeSpShjWAK
 E4/UDaUJbvjfLnW1bEYT2kKBqMNbElERi1qqEWpp+ks8DxcmsDWSc0lsMVMOb/MWqhAg
 L1cg==
X-Gm-Message-State: AOAM531RhnSBbPqTM8DlK8oavIPuZ026cM8GtIKLo0tVjxlIedG6G0NX
 oyTrpWJ2haO7aW5jqOpO8lC3FHld+OAcWchvROiMxC/SbJurP4DB5Kn87aEobR6+0BWm0SVD2R5
 Spz0dhwwvkgaed9RtR9CKr3aZ9dn4LA==
X-Received: by 2002:a5d:825a:: with SMTP id n26mr17645909ioo.168.1613511064624; 
 Tue, 16 Feb 2021 13:31:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxk0C6iiFvec88tvP6+gpg85QXx/9On6LqD7OBIFLkjy4f1EkacZ3vR6c/00kEtcceVA6kVLA==
X-Received: by 2002:a5d:825a:: with SMTP id n26mr17645897ioo.168.1613511064400; 
 Tue, 16 Feb 2021 13:31:04 -0800 (PST)
Received: from localhost (71-218-248-79.hlrn.qwest.net. [71.218.248.79])
 by smtp.gmail.com with ESMTPSA id j5sm9036914ilo.42.2021.02.16.13.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Feb 2021 13:31:03 -0800 (PST)
Date: Tue, 16 Feb 2021 14:31:03 -0700
From: Al Stone <ahs3@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [EXTERNAL] Re: Question regarding VIOT proposal
Message-ID: <20210216213103.GT702808@redhat.com>
References: <MW2PR2101MB113096E822AD835F658808B480EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201106135745.GB974750@myrica>
 <MW2PR2101MB11301F2185D1C9016310728E80F21@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201203230127.GD4343@redhat.com>
 <20201204180924.GA1922896@myrica>
 <20201204201825.GG4343@redhat.com> <YBkYsSHGUfG91NoN@myrica>
 <20210202202713.GF702808@redhat.com> <YBpjAF3Q+NeJblE9@myrica>
 <20210204202524.GO702808@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210204202524.GO702808@redhat.com>
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

On 04 Feb 2021 13:25, Al Stone wrote:
> On 03 Feb 2021 09:46, Jean-Philippe Brucker wrote:
> > On Tue, Feb 02, 2021 at 01:27:13PM -0700, Al Stone wrote:
> > > On 02 Feb 2021 10:17, Jean-Philippe Brucker wrote:
> > > > Hi Al,
> > > > 
> > > > On Fri, Dec 04, 2020 at 01:18:25PM -0700, Al Stone wrote:
> > > > > > I updated the doc: https://jpbrucker.net/virtio-iommu/viot/viot-v9.pdf
> > > > > > You can incorporate it into the ASWG proposal.
> > > > > > Changes since v8:
> > > > > > * One typo (s/programing/programming/)
> > > > > > * Modified the PCI Range node to include a segment range.
> > > > > > 
> > > > > > I also updated the Linux and QEMU implementations on branch
> > > > > > virtio-iommu/devel in https://jpbrucker.net/git/linux/ and
> > > > > > https://jpbrucker.net/git/qemu/
> > > > > > 
> > > > > > Thanks again for helping with this
> > > > > > 
> > > > > > Jean
> > > > > 
> > > > > Perfect.  Thanks.  I'll update the ASWG info right away.
> > > > 
> > > > Has there been any more feedback on the VIOT specification? I'm wondering
> > > > when we can start upstreaming support for it.
> > > > 
> > > > Thanks,
> > > > Jean
> > > 
> > > Ah, sorry, Jean.  I meant to get back to you sooner.  My apologies.
> > > 
> > > The latest version that resulted from the discussion with Yinghan of
> > > Microsoft is the one in front the ASWG; I think if you upstream that
> > > version, it should be identical to the spec when it is next published
> > > (post ACPI 6.4).
> > > 
> > > The process is: (1) propose the change, (2) review it in committee,
> > > (3) give people more time to think about it, then (4) have a finale
> > > vote.  We've been iterating over (1), (2) and (3).  Since there was
> > > no new discussion at the last meeting, we should have the final vote
> > > on this (4) in the next meeting.  I had hoped we could do that last
> > > week but the meeting was canceled at the last minute.  I hope to have
> > > the final vote this Thursday and will let you know as soon as it has
> > > been decided.
> > > 
> > > My apologies for the delays; getting things done by committee always
> > > takes a bazillion times longer than one would think.
> > 
> > No worries, thanks a lot for the update!
> > 
> > Thanks,
> > Jean
> 
> Sigh.  Just got a note that today's meeting has been canceled :(.
> 
> So, next week for the final vote.  OTOH, there have been no comments
> of any sort on the proposal -- and silence is good, in this case.

Would you believe last week's meeting was canceled, too?  Not sure
why the chair/co-chair are doing this but I'm finding it a little
frustrating.

We'll try again this week ... again, apologies for the delays.  I'd
recommend going with the last version posted just so progress can be
made.  The spec can always be fixed later.

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

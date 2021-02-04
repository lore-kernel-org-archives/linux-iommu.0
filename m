Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39386C433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 20:25:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9674564F48
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 20:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9674564F48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 52CF78726D;
	Thu,  4 Feb 2021 20:25:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EWDF1IJpdjEh; Thu,  4 Feb 2021 20:25:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 98C9E87268;
	Thu,  4 Feb 2021 20:25:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AA45C0174;
	Thu,  4 Feb 2021 20:25:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04263C013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 20:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EA13986813
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 20:25:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W_b1Nw1yLr1T for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 20:25:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AB4708680B
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 20:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612470336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0HKszGpu1NTkG70KhLGBCppG7Db6sBfqpDeGrPhKZVs=;
 b=Ax1BMyVSf+I9EsVjHorJMK2r1ORrp9UnLyvadpkMrigIrBnum/p9+76E12rfqZ2t78VuGC
 cSAMrEZYEeyHzsZx8EEFS/LoVww1lvGEad8+1c+E2Tnn0t8sAKCKhEUaj5wko7axpIZDmc
 6+Rd3yLNXQnT0kBDK4yQuOmz2L3AgX4=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-AXfSX9kGPXyvq2H1-bS7Ug-1; Thu, 04 Feb 2021 15:25:28 -0500
X-MC-Unique: AXfSX9kGPXyvq2H1-bS7Ug-1
Received: by mail-io1-f69.google.com with SMTP id a2so3957829iod.22
 for <iommu@lists.linux-foundation.org>; Thu, 04 Feb 2021 12:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0HKszGpu1NTkG70KhLGBCppG7Db6sBfqpDeGrPhKZVs=;
 b=J9FEpwLMqjXAsKWCk5L+NaPYF3bSIDvj5Hb7sh8U8tv7ntazlvxlswS855717sxwiU
 J7lBk8MfZ3PDYwyEnSigkT8tZ6HWqi6HP/Jr7STZ7UmfAlf5SKGgQzCp+hRzqS/yr7PW
 FouvHZNE4DNyRgN4UAjpbym/D8dJ3pchpvjua9dY4/5mvDxmIAEXqD6uTpbc0m5mAfjO
 xXo0Iw/ZBM/yZ3oxHLoQdXJiEpvEyElS5PKcgQhHFpyGWj90rw70IEVXh80NYLszn2Y7
 ofsOkeyudcq0Db1V88SlIeT2n6bttjv2FAle2mMrUkpWbKlvPsPiqbgpOea5OGDFqAUw
 b3Qw==
X-Gm-Message-State: AOAM5314T/jQoh6HHbx1kHJSbiibYtX6czDz41J8wRgBMzrAtnywvkBS
 2TPz83MTBiqnAXcAp4dpDMvBikoQbvv8xbw1J8E6NfxbkxYIGkvsbIhItN4sksif6sEYhnX4LVR
 mnuuBMaELIY8D86tLyH+Nz7FpPz0VeQ==
X-Received: by 2002:a02:6402:: with SMTP id t2mr1289374jac.90.1612470326265;
 Thu, 04 Feb 2021 12:25:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBVFW6tkM+zQROI6KSYGitD7KHwxfl1DQKMAtzjO/sE8lExVHey66MC8kY6G7y4PjEE50LtA==
X-Received: by 2002:a02:6402:: with SMTP id t2mr1289360jac.90.1612470326108;
 Thu, 04 Feb 2021 12:25:26 -0800 (PST)
Received: from localhost ([97.118.140.0])
 by smtp.gmail.com with ESMTPSA id r7sm3133018ilo.31.2021.02.04.12.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 12:25:25 -0800 (PST)
Date: Thu, 4 Feb 2021 13:25:24 -0700
From: Al Stone <ahs3@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [EXTERNAL] Re: Question regarding VIOT proposal
Message-ID: <20210204202524.GO702808@redhat.com>
References: <20201105134503.GA950007@myrica>
 <MW2PR2101MB113096E822AD835F658808B480EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201106135745.GB974750@myrica>
 <MW2PR2101MB11301F2185D1C9016310728E80F21@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201203230127.GD4343@redhat.com>
 <20201204180924.GA1922896@myrica>
 <20201204201825.GG4343@redhat.com> <YBkYsSHGUfG91NoN@myrica>
 <20210202202713.GF702808@redhat.com> <YBpjAF3Q+NeJblE9@myrica>
MIME-Version: 1.0
In-Reply-To: <YBpjAF3Q+NeJblE9@myrica>
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

On 03 Feb 2021 09:46, Jean-Philippe Brucker wrote:
> On Tue, Feb 02, 2021 at 01:27:13PM -0700, Al Stone wrote:
> > On 02 Feb 2021 10:17, Jean-Philippe Brucker wrote:
> > > Hi Al,
> > > 
> > > On Fri, Dec 04, 2020 at 01:18:25PM -0700, Al Stone wrote:
> > > > > I updated the doc: https://jpbrucker.net/virtio-iommu/viot/viot-v9.pdf
> > > > > You can incorporate it into the ASWG proposal.
> > > > > Changes since v8:
> > > > > * One typo (s/programing/programming/)
> > > > > * Modified the PCI Range node to include a segment range.
> > > > > 
> > > > > I also updated the Linux and QEMU implementations on branch
> > > > > virtio-iommu/devel in https://jpbrucker.net/git/linux/ and
> > > > > https://jpbrucker.net/git/qemu/
> > > > > 
> > > > > Thanks again for helping with this
> > > > > 
> > > > > Jean
> > > > 
> > > > Perfect.  Thanks.  I'll update the ASWG info right away.
> > > 
> > > Has there been any more feedback on the VIOT specification? I'm wondering
> > > when we can start upstreaming support for it.
> > > 
> > > Thanks,
> > > Jean
> > 
> > Ah, sorry, Jean.  I meant to get back to you sooner.  My apologies.
> > 
> > The latest version that resulted from the discussion with Yinghan of
> > Microsoft is the one in front the ASWG; I think if you upstream that
> > version, it should be identical to the spec when it is next published
> > (post ACPI 6.4).
> > 
> > The process is: (1) propose the change, (2) review it in committee,
> > (3) give people more time to think about it, then (4) have a finale
> > vote.  We've been iterating over (1), (2) and (3).  Since there was
> > no new discussion at the last meeting, we should have the final vote
> > on this (4) in the next meeting.  I had hoped we could do that last
> > week but the meeting was canceled at the last minute.  I hope to have
> > the final vote this Thursday and will let you know as soon as it has
> > been decided.
> > 
> > My apologies for the delays; getting things done by committee always
> > takes a bazillion times longer than one would think.
> 
> No worries, thanks a lot for the update!
> 
> Thanks,
> Jean

Sigh.  Just got a note that today's meeting has been canceled :(.

So, next week for the final vote.  OTOH, there have been no comments
of any sort on the proposal -- and silence is good, in this case.

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

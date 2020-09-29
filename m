Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C3C4727C
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 18:55:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4AB2145D
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 18:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dR+Dd2vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4AB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7356D85E12;
	Tue, 29 Sep 2020 18:55:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TONS39jtXAh8; Tue, 29 Sep 2020 18:55:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 21ABA86566;
	Tue, 29 Sep 2020 18:55:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04641C0895;
	Tue, 29 Sep 2020 18:55:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E08DC016F
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 045C3203E4
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qvt0gpfG46zo for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 17:28:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id C6A49203D0
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:28:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601400535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8BuFCHV4DyyyceiFSJkI3cyJ1EYQRloVeaKvvp0HdMc=;
 b=dR+Dd2vbP6FjUtH3neLdGYTzi+Hv4tNMGZ22niYHU/YgAUhj2g+a4OD31DzqkILLuUOGdc
 nS80lKaOfc0w5fJ1vpram4vuocHBpynBWK1sljXClUEYoMbjOni6TMpiNg1qetHhFJrbTF
 oO03pnLSG2cgET30aiUjxDU1TRn5UCg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-LU5_MBDPMn-T0M-UpEAPmA-1; Tue, 29 Sep 2020 13:28:52 -0400
X-MC-Unique: LU5_MBDPMn-T0M-UpEAPmA-1
Received: by mail-oo1-f70.google.com with SMTP id j12so2396555ooi.15
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 10:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8BuFCHV4DyyyceiFSJkI3cyJ1EYQRloVeaKvvp0HdMc=;
 b=czpGg+egaRbsAhg9yyYlazP+TJDQhuUYwUDqHJqlriVaOPJ+kOOPhOixq4B4+qGPwX
 LzzOrkIMnBnHp1jrw/ciPJyOj+qhK8i4dv3qs8DK/59X1nJGygG0RLOjT3gZQaZ4p2/b
 DYPXYix1VZwzAqbk3t/NOdwuHx7cT3seon1CUGbWUXGkU8OLDfM3FbuMxxrNkWiQspQj
 CfZzorX1Luoh3nYyUkJDw5zPo8VgBS3jXUnvudyQmqZ5LJ82gLzvrY/nHIyG8yWz7n9C
 0RdnuDjL8xJk+iDCY9FShnvfxrUUIjbUYbvhRCRy+zdcgTHw1ehIxIPm2PB2nWzJag/M
 FxNQ==
X-Gm-Message-State: AOAM531f9/0b5ojZZU2ohSr3OzJocO1Rai4brooYE+yGjft1BCn5+BIp
 XZlj4+rWDqq1ZQ4sPK9V7rfZwjquPGygyM3pQHXcMvqa4XzWzwVb3IrHa+y5HSVkFgXvbigC7jw
 kDBI6w6BNVi367caByUDwhlyyJzYbNQ==
X-Received: by 2002:aca:1312:: with SMTP id e18mr3259414oii.19.1601400531249; 
 Tue, 29 Sep 2020 10:28:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuBdTi+WL2ru4njoi33T1kboK4M7/85ghf3zubjSkL4Y6DUjJ7A5Y4VxcyHt+ZGTU5MThUsw==
X-Received: by 2002:aca:1312:: with SMTP id e18mr3259396oii.19.1601400530952; 
 Tue, 29 Sep 2020 10:28:50 -0700 (PDT)
Received: from localhost (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
 by smtp.gmail.com with ESMTPSA id p16sm1137448otl.17.2020.09.29.10.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 10:28:50 -0700 (PDT)
Date: Tue, 29 Sep 2020 11:28:48 -0600
From: Al Stone <ahs3@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200929172848.GZ138842@redhat.com>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <d54b674e-2626-fc73-d663-136573c32b8a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d54b674e-2626-fc73-d663-136573c32b8a@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ahs3@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 29 Sep 2020 18:55:45 +0000
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, bhelgaas@google.com, jasowang@redhat.com
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

On 24 Sep 2020 11:54, Auger Eric wrote:
> Hi,
> 
> Adding Al in the loop
> 
> On 9/24/20 11:38 AM, Michael S. Tsirkin wrote:
> > On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
> >> On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
> >>> OK so this looks good. Can you pls repost with the minor tweak
> >>> suggested and all acks included, and I will queue this?
> >>
> >> My NACK still stands, as long as a few questions are open:
> >>
> >> 	1) The format used here will be the same as in the ACPI table? I
> >> 	   think the answer to this questions must be Yes, so this leads
> >> 	   to the real question:
> > 
> > I am not sure it's a must.
> > We can always tweak the parser if there are slight differences
> > between ACPI and virtio formats.
> > 
> > But we do want the virtio format used here to be approved by the virtio
> > TC, so it won't change.

As long as we can convey the same content to the UEFI ASWG, we're
fine.  Format/syntax of the submittal is not absolutely critical
though it does need translating to what the ASWG expects (see
https://github.com/tianocore/tianocore.github.io/wiki/EDK-II-Code-First-Process
for details -- basically a bugzilla with markdown text.

> > Eric, Jean-Philippe, does one of you intend to create a github issue
> > and request a ballot for the TC? It's been posted end of August with no
> > changes ...
> Jean-Philippe, would you?
> > 
> >> 	2) Has the ACPI table format stabalized already? If and only if
> >> 	   the answer is Yes I will Ack these patches. We don't need to
> >> 	   wait until the ACPI table format is published in a
> >> 	   specification update, but at least some certainty that it
> >> 	   will not change in incompatible ways anymore is needed.
> >>
> 
> Al, do you have any news about the the VIOT definition submission to
> the UEFI ASWG?
> 
> Thank you in advance
> 
> Best Regards
> 
> Eric
> 
> 
> > 
> > Not that I know, but I don't see why it's a must.
> > 
> >> So what progress has been made with the ACPI table specification, is it
> >> just a matter of time to get it approved or are there concerns?
> >>
> >> Regards,
> >>
> >> 	Joerg

My apologies for the delay.  No excuses, just not enough hours in the
day.

I will make the proper submission to the ASWG later today to have it
considered later this week -- I had quite a bit of confusion around
how the process is supposed to work but I think we've got that cleared
up (see the link noted above).

The content of the table appears to be in really good shape.  Will it
change?  Possibly, but my expectation is that it will be minor details,
nothing wholesale; having the table in use in code tends to act as a
pretty fierce restraint on making changes (there's a lot of precedent
for that in ASWG).

The biggest question is: are there any objections to having this
table description licensed under Creative Commons Attribution
International 4.0 (see https://spdx.org/licenses/CC-BY-4.0.html)?
This is just for the table description, not the code.  If there
are, that needs to be cleared up first.  If not, then the submittal
this week should happen.

Once submitted to ASWG, there is a very slim chance it will end up
in ACPI 6.4 which is mostly done now -- very, very slim, but stranger
things have happened.  Most likely, once approved it would be in
ACPI 6.5, sometime in 2021.  I'll post the link to the submittal
as soon as I can.

Again, my apologies for the delays; approval in the spec can proceed
pretty much independent of the implementation, and vice versa.  That's
really the whole point of this new process with the UEFI Forum.

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

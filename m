Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE057C388F7
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 20:09:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A43E206DF
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 20:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blRjpJId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A43E206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DD20621537;
	Tue,  3 Nov 2020 20:09:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QcCyKbRH5QHf; Tue,  3 Nov 2020 20:09:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EADCD2039E;
	Tue,  3 Nov 2020 20:09:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7F30C088B;
	Tue,  3 Nov 2020 20:09:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FEC0C0051
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 20:09:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 743622039E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 20:09:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sF0Wyilyo7Cb for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 20:09:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 5B93420525
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 20:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604434148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NqhKVR/2Ajvl50Pd8Ilz+ajONAsW3dvf+1ZyM0gSs30=;
 b=blRjpJIdn+E+jt0iZB6ZcMKxG57jzKeJawkX122wU5i+c9V0yMrBndArvbFA0SWMTn0kzS
 db5PtitwmKeacmmurm3LMO9SOhb1G58evQfWoULoiBKCXMEN+v1XWyeuXWLW8BFtSTk7ls
 zvei0gLEaRA4+65POc5xh70MBq59ZTo=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589--OU-dwPRNH-cnZtrlj1X4A-1; Tue, 03 Nov 2020 15:09:06 -0500
X-MC-Unique: -OU-dwPRNH-cnZtrlj1X4A-1
Received: by mail-il1-f197.google.com with SMTP id p17so13732078ilb.5
 for <iommu@lists.linux-foundation.org>; Tue, 03 Nov 2020 12:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NqhKVR/2Ajvl50Pd8Ilz+ajONAsW3dvf+1ZyM0gSs30=;
 b=MVByy5yX4IE7gbVKcZO03Uuo1kS9YOxYV+guD102ZDgnekNzYUtIE8KaB1WxUdL26d
 n6XMzAoIIfP2jB6Cvx+MOmILDvaZIYE7FL7pPwtCcaL6ZYlz+67ZcQATyv5rNmcNmLey
 bL+onHWNDx8+9LoZGBagqtCT+3lQ/tHR3G42jmLL5fVxaQXhPpMbGWnLkoDNLe1WCtBS
 kFcUCv77FyhGVbBgwEC2dZfmCA1px6AnzpIxAsVFyROU2t2Syxhai24fL5fHNrhj91Eg
 el9qrBhgQ1Ek6x3zhA/LFcNDPyh2I4g/FWdLvQhKBC7roPLxTiU5X/lTx9Zqcg8WbYAv
 j4Lw==
X-Gm-Message-State: AOAM533uu5jYpAKXJhAkSG7V/TjxErhLBVya3ComG6+9mSrm87Bp2yMe
 1YjcVod6XaVkAsSoCs0kY93lLGWzZg+Ak9VU/KydduQZdhy/qlfjiggtvli+8cqJpi211Fny4DY
 na6rGmlz/lyUTatUSLpGTbdtUuMRTlg==
X-Received: by 2002:a92:7a0c:: with SMTP id v12mr14054039ilc.37.1604434146126; 
 Tue, 03 Nov 2020 12:09:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfLVxyBBmzFRGEt1E1I5sfsYYkY/HJFsCafbpR5oigBeFopgLwYltmKHsb4aWM3tTZxIhDAA==
X-Received: by 2002:a92:7a0c:: with SMTP id v12mr14054011ilc.37.1604434145890; 
 Tue, 03 Nov 2020 12:09:05 -0800 (PST)
Received: from localhost (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
 by smtp.gmail.com with ESMTPSA id 9sm14471896ila.61.2020.11.03.12.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 12:09:05 -0800 (PST)
Date: Tue, 3 Nov 2020 13:09:04 -0700
From: Al Stone <ahs3@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20201103200904.GA1557194@redhat.com>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <d54b674e-2626-fc73-d663-136573c32b8a@redhat.com>
 <20201002182348.GO138842@redhat.com>
 <e8a37837-30d0-d7cc-496a-df4c12fff1da@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e8a37837-30d0-d7cc-496a-df4c12fff1da@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ahs3@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On 06 Oct 2020 17:23, Auger Eric wrote:
> Hello Al,
> 
> On 10/2/20 8:23 PM, Al Stone wrote:
> > On 24 Sep 2020 11:54, Auger Eric wrote:
> >> Hi,
> >>
> >> Adding Al in the loop
> >>
> >> On 9/24/20 11:38 AM, Michael S. Tsirkin wrote:
> >>> On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
> >>>> On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
> >>>>> OK so this looks good. Can you pls repost with the minor tweak
> >>>>> suggested and all acks included, and I will queue this?
> >>>>
> >>>> My NACK still stands, as long as a few questions are open:
> >>>>
> >>>> 	1) The format used here will be the same as in the ACPI table? I
> >>>> 	   think the answer to this questions must be Yes, so this leads
> >>>> 	   to the real question:
> >>>
> >>> I am not sure it's a must.
> >>> We can always tweak the parser if there are slight differences
> >>> between ACPI and virtio formats.
> >>>
> >>> But we do want the virtio format used here to be approved by the virtio
> >>> TC, so it won't change.
> >>>
> >>> Eric, Jean-Philippe, does one of you intend to create a github issue
> >>> and request a ballot for the TC? It's been posted end of August with no
> >>> changes ...
> >> Jean-Philippe, would you?
> >>>
> >>>> 	2) Has the ACPI table format stabalized already? If and only if
> >>>> 	   the answer is Yes I will Ack these patches. We don't need to
> >>>> 	   wait until the ACPI table format is published in a
> >>>> 	   specification update, but at least some certainty that it
> >>>> 	   will not change in incompatible ways anymore is needed.
> >>>>
> >>
> >> Al, do you have any news about the the VIOT definition submission to
> >> the UEFI ASWG?
> >>
> >> Thank you in advance
> >>
> >> Best Regards
> >>
> >> Eric
> > 
> > A follow-up to my earlier post ....
> > 
> > Hearing no objection, I've submitted the VIOT table description to
> > the ASWG for consideration under what they call the "code first"
> > process.  The "first reading" -- a brief discussion on what the
> > table is and why we would like to add it -- was held yesterday.
> > No concerns have been raised as yet.  Given the discussions that
> > have already occurred, I don't expect any, either.  I have been
> > wrong at least once before, however.
> > 
> > At this point, ASWG will revisit the request to add VIOT each
> > week.  If there have been no comments in the prior week, and no
> > further discussion during the meeting, then a vote will be taken.
> > Otherwise, there will be discussion and we try again the next
> > week.
> > 
> > The ASWG was also told that the likelihood of this definition of
> > the table changing is pretty low, and that it has been thought out
> > pretty well already.  ASWG's consideration will therefore start
> > from the assumption that it would be best _not_ to make changes.
> > 
> > So, I'll let you know what happens next week.
> 
> Thank you very much for the updates and for your support backing the
> proposal in the best delays.
> 
> Best Regards
> 
> Eric

So, there are some questions about the VIOT definition and I just
don't know enough to be able to answer them.  One of the ASWG members
is trying to understand the semantics behind the subtables.

Is there a particular set of people, or mailing lists, that I can
point to to get the questions answered?  Ideally it would be one
of the public lists where it has already been discussed, but an
individual would be fine, too.  No changes have been proposed, just
some questions asked.

Thanks.

> > 
> >>
> >>>
> >>> Not that I know, but I don't see why it's a must.
> >>>
> >>>> So what progress has been made with the ACPI table specification, is it
> >>>> just a matter of time to get it approved or are there concerns?
> >>>>
> >>>> Regards,
> >>>>
> >>>> 	Joerg
> >>>
> >>
> > 
> 

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

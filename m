Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FCCC4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 18:23:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476DD20795
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 18:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AaCjpbJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476DD20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BDCD1873A8;
	Fri,  2 Oct 2020 18:23:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qr7pNzzrJAA4; Fri,  2 Oct 2020 18:23:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1BD3887398;
	Fri,  2 Oct 2020 18:23:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2E89C016F;
	Fri,  2 Oct 2020 18:23:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18F6CC016F
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 18:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 04AF584837
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 18:23:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n0l7MksP89Wd for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 18:23:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0B9B984647
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 18:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601663032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K5o0jYIGnG/0f5zW82Cze4bYT081fEytdlidzckiyxk=;
 b=AaCjpbJCNqEpnB0aER0qwg7daAd7pBl4IRZjJqv4WeS73E8C6mVssuD80eLVcchEBtoqPJ
 TDbTRMow1aIQkPN3+mo0KTDDWUne5/j2UvncE5leADkomU7TMog0aDU1/1m9jAHkUuCtdt
 qCwuDGE5BuWCsprwlHflwOK2K99/xZA=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-9ITpHIo9MYaC2M5uBS60aw-1; Fri, 02 Oct 2020 14:23:51 -0400
X-MC-Unique: 9ITpHIo9MYaC2M5uBS60aw-1
Received: by mail-il1-f198.google.com with SMTP id 18so1823830ilt.9
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 11:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=K5o0jYIGnG/0f5zW82Cze4bYT081fEytdlidzckiyxk=;
 b=IRel8YwjnKnbsge9rypOHQcs8vCRdyGZNlnmnkbXrhUzGXIh9E9HBL7JLVq8fJAC/7
 DVkpwdP27y+Ijb7zGlvyDEeaTKnET1Uu71xlHuneXpsGcWlOX0jgK/qsDT3fCxCzryzr
 gJSlJqFkCHrOH85YrnNE0UdR1s4xfU8l4sf5z7WfobBh/7HaZ2y9xG71GCM9vubkwFcu
 v4xoGNpKbCanb3Ma9g3L1Amzk5XPAXUqkJbk8KP05LYvHq2qB4D8Nf5pv3lJsx24BNxa
 t1vpUZt3Hh5JrAFnYkhEf4kUyaaCeICwOU4ZRd/IkMo9bM12p17t97S7fiDPFK0QPqJK
 AAhA==
X-Gm-Message-State: AOAM530g85HdgMkvju3jfuLMwNTBQzgVkVSXlMGzz/Vg8X5RsLu1ulnV
 u6kNLf4MPyA+mkRgmTtQdPKQrHQQpquK1nlypErs/Dndv7FbmLVWIk7yeo4zePaNLzcG1LLQuq0
 hhBXyzpV68vlMUWPIa7e9P9wYqOOo2g==
X-Received: by 2002:a5e:dc04:: with SMTP id b4mr2936555iok.208.1601663030550; 
 Fri, 02 Oct 2020 11:23:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym7hhfSAz5RkroqhQVSDKIyKMh66KVDC7NYEDjTn8eT708NnRxui/FuJxqPH3RScDsgKVqBg==
X-Received: by 2002:a5e:dc04:: with SMTP id b4mr2936537iok.208.1601663030343; 
 Fri, 02 Oct 2020 11:23:50 -0700 (PDT)
Received: from localhost (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
 by smtp.gmail.com with ESMTPSA id u15sm1052127ior.6.2020.10.02.11.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 11:23:49 -0700 (PDT)
Date: Fri, 2 Oct 2020 12:23:48 -0600
From: Al Stone <ahs3@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20201002182348.GO138842@redhat.com>
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
> > 
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

A follow-up to my earlier post ....

Hearing no objection, I've submitted the VIOT table description to
the ASWG for consideration under what they call the "code first"
process.  The "first reading" -- a brief discussion on what the
table is and why we would like to add it -- was held yesterday.
No concerns have been raised as yet.  Given the discussions that
have already occurred, I don't expect any, either.  I have been
wrong at least once before, however.

At this point, ASWG will revisit the request to add VIOT each
week.  If there have been no comments in the prior week, and no
further discussion during the meeting, then a vote will be taken.
Otherwise, there will be discussion and we try again the next
week.

The ASWG was also told that the likelihood of this definition of
the table changing is pretty low, and that it has been thought out
pretty well already.  ASWG's consideration will therefore start
from the assumption that it would be best _not_ to make changes.

So, I'll let you know what happens next week.

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

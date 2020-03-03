Return-Path: <SRS0=fiLh=4U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB714C3F2C6
	for <iommu@archiver.kernel.org>; Tue,  3 Mar 2020 16:09:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8157D206E2
	for <iommu@archiver.kernel.org>; Tue,  3 Mar 2020 16:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhSgFAVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8157D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 510468731E;
	Tue,  3 Mar 2020 16:09:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iW0KTN9SO7JD; Tue,  3 Mar 2020 16:09:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C05328567A;
	Tue,  3 Mar 2020 16:09:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7141C07FF;
	Tue,  3 Mar 2020 16:09:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBC0CC013E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 16:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B48BC8731E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 16:09:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LpLwuzbvB4nC for <iommu@lists.linux-foundation.org>;
 Tue,  3 Mar 2020 16:09:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8D91C8567A
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583251790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wKvfdiF15fmxVLHPj5o9eKPjxoX2xTKxmfQEHSXHh40=;
 b=MhSgFAVQmVKTRdNSzAf6WyyGZXkuNtAU7HCbk/Nr1E22JIS7a43liVks7pRbhzEAnlXH/A
 EvEUpBe8fy+YISyyODMGNwanEnoRMHepxVjVztmHzy5TD9LkXP643kz1BWzsg9k8iA6SLD
 sb/Ztif6K4+0XG2RIV4HINSJyvjwqfY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-EgKXIRl8Os2VdHxCSzPdzQ-1; Tue, 03 Mar 2020 11:09:48 -0500
X-MC-Unique: EgKXIRl8Os2VdHxCSzPdzQ-1
Received: by mail-qt1-f200.google.com with SMTP id v20so1020243qtk.21
 for <iommu@lists.linux-foundation.org>; Tue, 03 Mar 2020 08:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wKvfdiF15fmxVLHPj5o9eKPjxoX2xTKxmfQEHSXHh40=;
 b=REUSAXwtJxlfZw6b7su4mHXK31iXWnSrTsTI1xQAlEsCHAW2QTE39wrAGDu54ogY78
 hmDSBpkoFLC8lJkCmIQGUTFVREbud7heV7JAm4pLZ6jkKIhTTHUTpHHxS6IPLilG57oT
 sIC9mx6xd1XjL6ftw2YbgwDyx1p6ZnUcjIhikKrTOi1odg3tZY7Q1L3NRqcJvOS1i6xh
 H5/2FBjnQLq3xlXI/onX9ZstwgzHHPd+GQWWl5g6dzcLk0gtkNJf9l46uuwDf6mZ0wDQ
 TB1z8dRW6yGchlJRdFV8725ZL5tafya56nVzV0M95Y9fAfoh0+jJWIDUGTsmG7MkLJ9i
 gbjA==
X-Gm-Message-State: ANhLgQ0hbehgkYfwLlw+g02d7RaXeFlinw01jpt/tfleq552mRmKp2p7
 UJfMm7Ufn66NS7XnSxMwkhtK440gCnGbGozQC2iZ0eThvs5PH7byRfwU1qOU7C/fIhebGlMviKw
 Up9O8ByyTkiUa9CcDDxAbInCMX+yZ5w==
X-Received: by 2002:a05:6214:17c5:: with SMTP id
 cu5mr4424129qvb.210.1583251788241; 
 Tue, 03 Mar 2020 08:09:48 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtJ9GIyZMaGCJIKTXUVP5hZCrw/gJ9Guh3JYChqVs+dNQ8M4rE5nkP++m1WK1jniaFYOb8e4Q==
X-Received: by 2002:a05:6214:17c5:: with SMTP id
 cu5mr4424097qvb.210.1583251787954; 
 Tue, 03 Mar 2020 08:09:47 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
 by smtp.gmail.com with ESMTPSA id x34sm8269204qta.82.2020.03.03.08.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 08:09:47 -0800 (PST)
Date: Tue, 3 Mar 2020 11:09:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200303105523-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200303155318.GA3954@8bytes.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 linux-pci@vger.kernel.org, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, bhelgaas@google.com,
 robin.murphy@arm.com
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

On Tue, Mar 03, 2020 at 04:53:19PM +0100, Joerg Roedel wrote:
> On Tue, Mar 03, 2020 at 09:00:05AM -0500, Michael S. Tsirkin wrote:
> > Not necessarily. E.g. some power systems have neither.
> > There are also systems looking to bypass ACPI e.g. for boot speed.
> 
> If there is no firmware layer between the hardware and the OS the
> necessary information the OS needs to run on the hardware is probably
> hard-coded into the kernel?

No. It's coded into the hardware. Which might even be practical
for bare-metal (e.g. on-board flash), but is very practical
when the device is part of a hypervisor.

> In that case the same can be done with
> virtio-iommu tolopology.
> 
> > That sentence doesn't really answer the question, does it?
> 
> To be more elaborate, putting this information into config space is a
> layering violation. Hardware is never completly self-descriptive


This "hardware" is actually part of hypervisor so there's no
reason it can't be completely self-descriptive. It's specified
by the same entity as the "firmware".


> and
> that is why there is the firmware which provides the information about
> the hardware to the OS in a generic way.
>
> > Frankly with platform specific interfaces like ACPI, virtio-iommu is
> > much less compelling.  Describing topology as part of the device in a
> > way that is first, portable, and second, is a good fit for hypervisors,
> > is to me one of the main reasons virtio-iommu makes sense at all.
> 
> Virtio-IOMMU makes sense in the first place because it is much faster
> than emulating one of the hardware IOMMUs.

I don't see why it would be much faster. The interface isn't that
different from command queues of VTD.

> And an ACPI table is also
> portable to all ACPI platforms, same with device-tree.
> 
> Regards,
> 
> 	Joerg

Making ACPI meet the goals of embedded projects such as kata containers
would be a gigantic task with huge stability implications.  By
comparison this 400-line parser is well contained and does the job.  I
didn't yet see compelling reasons not to merge this, but I'll be
interested to see some more specific concerns.


-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

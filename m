Return-Path: <SRS0=48ym=4V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF78C3F2CE
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 19:34:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AF621739
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 19:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHXRiSev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AF621739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ADDA586091;
	Wed,  4 Mar 2020 19:34:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DnBTBlLdkvlU; Wed,  4 Mar 2020 19:34:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 564478357B;
	Wed,  4 Mar 2020 19:34:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B51AC1AE2;
	Wed,  4 Mar 2020 19:34:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1A8EC013E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 19:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AC99D203A7
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 19:34:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ufJ6NNIHU0Fz for <iommu@lists.linux-foundation.org>;
 Wed,  4 Mar 2020 19:34:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id B381D203A6
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 19:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583350483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LVZr990W9iLEEqbjHHLM4X6TgtqyzP5bDocd/dkFa7Q=;
 b=jHXRiSev2wxWV10iQltFQ9CpPReiNf5wAB2O7YDEqHcExdNtoRbP4Rk6JeNImVvMDT/rDg
 kAUkn0n+a48AS2ICLoiv0crpoMEeWqxW+70hU/AlK1nn00H0wZmi6iIG37JLkwb5d3aqR5
 fKDcg+7US1Qanu04Bi8TZBsgaHtkzIo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-uQOqg_CfNleAtiqmvvJWxw-1; Wed, 04 Mar 2020 14:34:41 -0500
X-MC-Unique: uQOqg_CfNleAtiqmvvJWxw-1
Received: by mail-qt1-f199.google.com with SMTP id f25so2183037qtp.12
 for <iommu@lists.linux-foundation.org>; Wed, 04 Mar 2020 11:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LVZr990W9iLEEqbjHHLM4X6TgtqyzP5bDocd/dkFa7Q=;
 b=reX78KrnffqMkZVaB37c64RtQfe+w8hvU9SFVW6a3m4Iwy1WxATrIZkt7Z5YyY50a7
 rH2ojsCnKaIp66G83lRwmDjXNFDKsEOVPf27iiab1kAmaaT4iyWHshbLRVyqHJMNNUUF
 oTp1HCKKS7qHCge90ciVohk7cqo0nZYUNE9Bs1cRt5fX+mxWZGIA85vDpLIWVgUOny2E
 DS7lt1Wg6wYEfnxgj2iotNN0IUWTPoSHN1uj8DkJQUAQZvi9j6wJP9d7HKfRE+EQBaNc
 jcWyDCsElHGneABGAZSh7kmBoic9oSratZcNtd8BGMos0cKxQafsdL1JNcQMSKwe440y
 FFuA==
X-Gm-Message-State: ANhLgQ0rpFPhRKP6QnNk6MxJYMrE8yyLo0lM9WrcRuFcR1yw5Ukdeo6X
 ovopKx9b4U1+cUK9MRA5D72A4Riv2vxsq0r6/GRnhUYmBMq9FNjfTlwfGMjrIuhkw6TmzQP1H5b
 pAiIfzpVZLwAt8BrGr+b3HPDt0IJjKA==
X-Received: by 2002:ac8:4581:: with SMTP id l1mr3852950qtn.59.1583350481207;
 Wed, 04 Mar 2020 11:34:41 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsHn2bzjYBh7yhIwOYSFDd0efbpFoWGSCiIqYDJtY0uHAZJqjWQvAouRmL7W3iDyAP6JRkM+g==
X-Received: by 2002:ac8:4581:: with SMTP id l1mr3852927qtn.59.1583350480930;
 Wed, 04 Mar 2020 11:34:40 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
 by smtp.gmail.com with ESMTPSA id k4sm14181293qtj.74.2020.03.04.11.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 11:34:40 -0800 (PST)
Date: Wed, 4 Mar 2020 14:34:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200304142838-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
 <20200303105523-mutt-send-email-mst@kernel.org>
 <20200304133707.GB4177@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200304133707.GB4177@8bytes.org>
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

On Wed, Mar 04, 2020 at 02:37:08PM +0100, Joerg Roedel wrote:
> Hi Michael,
> 
> On Tue, Mar 03, 2020 at 11:09:41AM -0500, Michael S. Tsirkin wrote:
> > No. It's coded into the hardware. Which might even be practical
> > for bare-metal (e.g. on-board flash), but is very practical
> > when the device is part of a hypervisor.
> 
> If its that way on PPC, than fine for them. But since this is enablement
> for x86, it should follow the x86 platform best practices, and that
> means describing hardware through ACPI.

For hardware, sure.  Hypervisors aren't hardware
though and a bunch of hypervisors don't use ACPI.


> > This "hardware" is actually part of hypervisor so there's no
> > reason it can't be completely self-descriptive. It's specified
> > by the same entity as the "firmware".
> 
> That is just an implementation detail. Yes, QEMU emulates the hardware
> and builds the ACPI tables. But it could also be implemented in a way
> where the ACPI tables are build by guest firmware.

All these extra levels of indirection is one of the reasons
hypervisors such as kata try to avoid ACPI.

> > I don't see why it would be much faster. The interface isn't that
> > different from command queues of VTD.
> 
> VirtIO IOMMU doesn't need to build page-tables that the hypervisor then
> has to shadow, which makes things much faster. If you emulate one of the
> other IOMMUs (VT-d or AMD-Vi) the code has to shadow the full page-table
> at once when device passthrough is used. VirtIO-IOMMU doesn't need that,
> and that makes it much faster and efficient.


IIUC VT-d at least supports range invalidations.

> 
> > Making ACPI meet the goals of embedded projects such as kata containers
> > would be a gigantic task with huge stability implications.  By
> > comparison this 400-line parser is well contained and does the job.  I
> > didn't yet see compelling reasons not to merge this, but I'll be
> > interested to see some more specific concerns.
> 
> An ACPI table parse wouldn't need more lines of code.

It realies on ACPI OSPM itself to handle ACPI bytecode, which is huge.


> For embedded
> systems there is still the DT way of describing things.

For some embedded systems.

> Regards,
> 
> 	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

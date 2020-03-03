Return-Path: <SRS0=fiLh=4U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36582C3F2C6
	for <iommu@archiver.kernel.org>; Tue,  3 Mar 2020 14:00:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED87720857
	for <iommu@archiver.kernel.org>; Tue,  3 Mar 2020 14:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZwk8WJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED87720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B004E84D11;
	Tue,  3 Mar 2020 14:00:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6WTbFvXURfHP; Tue,  3 Mar 2020 14:00:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4970A84D0F;
	Tue,  3 Mar 2020 14:00:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 375C0C07FF;
	Tue,  3 Mar 2020 14:00:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2115AC013E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 14:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1D7B284D11
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 14:00:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gWbHuz-k0Km3 for <iommu@lists.linux-foundation.org>;
 Tue,  3 Mar 2020 14:00:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4D71784D0F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583244018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aa6HtSeh49MIF/xjAgoQ7EQau/N+kwzDq7RM+vAw+Uo=;
 b=bZwk8WJKOCrY7/Q1rviGRVTlTrIaoqXI9PKV2kOjz5i6uEQ8SHtktJ7cd1EDbuaZlw1dF+
 yVSP/7bu8DLJfQxWTWQ2DV6T4eChmfm91vBI7bFBHP70EymaTY1RZGLPyiFUyEU+2vqKYO
 CfdAL+7BuX27JvzMgOFq0AiA6Xv1WZM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-CxwYU3DiNXWL9tuECIqlPg-1; Tue, 03 Mar 2020 09:00:12 -0500
X-MC-Unique: CxwYU3DiNXWL9tuECIqlPg-1
Received: by mail-qt1-f200.google.com with SMTP id s5so2239834qtn.7
 for <iommu@lists.linux-foundation.org>; Tue, 03 Mar 2020 06:00:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aa6HtSeh49MIF/xjAgoQ7EQau/N+kwzDq7RM+vAw+Uo=;
 b=jtNEjzJkNdUO5wMdCUow1Gv/efJ+yxlrsfHZ0GeVfMYxQl2pFNlklConIJIs9cytSf
 sxTEEvQ5rgTmWk+e3k4Pa2BhteQgTRO+jrZ4CvHsY1Ep5OV4JmUTkxL2PNOXvTQGYNwK
 nVSRzGpqgzZsgxesV+MyFrfsmPcdnqSu+5rc7TCtLHZi5teFOA5/2NK/GQS6djdIBO/w
 X3vDguQc2YcJq+7B6BhhkanIv9r8HuN4QWWPLKwPofF1Yk60LsCsO4NmDTVnb17IjoT9
 MembYz9G0Sopha7V/f/VvvV4Fxpe3vBAtk0zBrYJ8YgMTY1qNcAAGL+/cqEH0ZL8bTgH
 QdzQ==
X-Gm-Message-State: ANhLgQ3l21/KdsanwHyHRaI3/UuaaTrSMdXe+zE6qhjdfLCwQ68ePBeJ
 8IzKisMSiiamWdNA751PRCBzrDGU+vozlQc622IlePe/xkb2OoMztbsxmz+gTpeSBkY3jhrfaDw
 PjOsgUxw2qpZTcj45Kf867PQhbjNy1Q==
X-Received: by 2002:ac8:1c7a:: with SMTP id j55mr4453356qtk.311.1583244012065; 
 Tue, 03 Mar 2020 06:00:12 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuZwadsAvkhUcJH4/W47LkbDsji9AWmjLQIpqUobhWh56z5UC579vb1nzWGmKUdc6OPFj59sQ==
X-Received: by 2002:ac8:1c7a:: with SMTP id j55mr4453330qtk.311.1583244011778; 
 Tue, 03 Mar 2020 06:00:11 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
 by smtp.gmail.com with ESMTPSA id j1sm9081095qtd.66.2020.03.03.06.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 06:00:10 -0800 (PST)
Date: Tue, 3 Mar 2020 09:00:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200303084753-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200303130155.GA13185@8bytes.org>
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

On Tue, Mar 03, 2020 at 02:01:56PM +0100, Joerg Roedel wrote:
> Hi Eric,
> 
> On Tue, Mar 03, 2020 at 11:19:20AM +0100, Auger Eric wrote:
> > Michael has pushed this solution (putting the "configuration in the PCI
> > config space"), I think for those main reasons:
> > - ACPI may not be supported on some archs/hyps
> 
> But on those there is device-tree, right?

Not necessarily. E.g. some power systems have neither.
There are also systems looking to bypass ACPI e.g. for boot speed.


> > - the virtio-iommu is a PCIe device so binding should not need ACPI
> > description
> 
> The other x86 IOMMUs are PCI devices too and they definitly need a ACPI
> table to be configured.
> 
> > Another issue with ACPI integration is we have different flavours of
> > tables that exist: IORT, DMAR, IVRS
> 
> An integration with IORT might be the best, but if it is not possible
> ther can be a new table-type for Virtio-iommu. That would still follow
> platform best practices.
> 
> > x86 ACPI integration was suggested with IORT. But it seems ARM is
> > reluctant to extend IORT to support para-virtualized IOMMU. So the VIOT
> > was proposed as a different atternative in "[RFC 00/13] virtio-iommu on
> > non-devicetree platforms"
> > (https://patchwork.kernel.org/cover/11257727/). Proposing a table that
> > may be used by different vendors seems to be a challenging issue here.
> 
> Yeah, if I am reading that right this proposes a one-fits-all solution.
> That is not needed as the other x86 IOMMUs already have their tables
> defined and implemented. There is no need to change anything there.
> 
> > So even if the above solution does not look perfect, it looked a
> > sensible compromise given the above arguments. Please could you explain
> > what are the most compelling arguments against it?
> 
> It is a hack and should be avoided if at all possible.

That sentence doesn't really answer the question, does it?

> And defining an
> own ACPI table type seems very much possible.

Frankly with platform specific interfaces like ACPI, virtio-iommu is
much less compelling.  Describing topology as part of the device in a
way that is first, portable, and second, is a good fit for hypervisors,
is to me one of the main reasons virtio-iommu makes sense at all.

> 
> Regards,
> 
> 	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

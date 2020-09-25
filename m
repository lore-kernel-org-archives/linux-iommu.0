Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56BEC4363D
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 13:45:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A392086A
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 13:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbsZEI1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A392086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 35E0A86CB0;
	Fri, 25 Sep 2020 13:45:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sOK9Mh0Hxh3h; Fri, 25 Sep 2020 13:45:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B3DB686C9B;
	Fri, 25 Sep 2020 13:45:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F2E0C1AD5;
	Fri, 25 Sep 2020 13:45:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14113C0051
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 13:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0395486DB5
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 13:45:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4DR8CMPKVb6d for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 13:45:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CE6FE86DB2
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 13:45:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601041506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fZRx9scO9WyM5XbTggDdmGbPU+j83eUOkEATeFu9ti4=;
 b=MbsZEI1sHb7c7jFxO9Y5+lU/YbsZt9UJBa8d/ZkTb5/EjHRT7huDP9JP63ClXEMDWV7+2+
 gm6jw7oLc6rB2olngcmnkAUqM64bHDKJvaK7qN8qRuwIXFUReln+saK7rkuRa/CcwV8A5i
 nrMgQVFVKZGldJ0SFtuaFsjGj+nTo34=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-7geyAOOVOVeJYwFBcKsE5Q-1; Fri, 25 Sep 2020 09:44:57 -0400
X-MC-Unique: 7geyAOOVOVeJYwFBcKsE5Q-1
Received: by mail-wr1-f70.google.com with SMTP id r16so1080692wrm.18
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 06:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fZRx9scO9WyM5XbTggDdmGbPU+j83eUOkEATeFu9ti4=;
 b=ihbCMFkqbu3m5zap2qLkYga2ErGXylaC7NcCsPGJwpqxYnN5sRPtVynQvofS+W0AfM
 l/Ki9/AGmr0AIMAzeeCAjT6yvMBPdy/rCehegIk+l7cW4/MiIO6hv6hDMdR5pyEpTnZj
 bRxP9NrWvljDR7s5nTorcq3quvIHY/iPTSdXkTgbRmAGiiT++FRobsC8c/GzORqgMnf6
 Cly6KrvjnjGldiB9Iz8Vt5hTtIhp/6sPwacCO2iFGkIyqdPBUa/X/XwylROps9GzHcgt
 HatSEnoN6Zn8QkKStFz10L2B2Ilg7PKsYrTaX3a/rS+qF9L2F1dZVeITtpqPdwnI5ZKM
 p7FA==
X-Gm-Message-State: AOAM530o65ykhCDeW/wmmKTdJlvW8BWAX9WfCdjZ/w/Q5YU2aYxJa3k/
 fQyasvrcndjw8ZHykBaH0obWI6sFSmeFq6QapM5Pk6sbCVAn6uV2OYwWjUNVuGhzDee5cLDis09
 3OHXJYY8RRDCdR6DgkTNfHZ0TwgoEgw==
X-Received: by 2002:adf:f586:: with SMTP id f6mr4592264wro.299.1601041496278; 
 Fri, 25 Sep 2020 06:44:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyzirwf5XpSmefqK4OCJ1HWoHY6oYQyzhyq40peFQP4a/fELc27oT+7SBUBLPslSbZBqRMGQ==
X-Received: by 2002:adf:f586:: with SMTP id f6mr4592230wro.299.1601041495971; 
 Fri, 25 Sep 2020 06:44:55 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id p11sm2803109wma.11.2020.09.25.06.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 06:44:54 -0700 (PDT)
Date: Fri, 25 Sep 2020 09:44:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200925094405-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200925084806.GB490533@myrica>
 <20200925062230-mutt-send-email-mst@kernel.org>
 <20200925112629.GA1337555@myrica>
MIME-Version: 1.0
In-Reply-To: <20200925112629.GA1337555@myrica>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
 linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 bhelgaas@google.com, jasowang@redhat.com
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

On Fri, Sep 25, 2020 at 01:26:29PM +0200, Jean-Philippe Brucker wrote:
> On Fri, Sep 25, 2020 at 06:22:57AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Sep 25, 2020 at 10:48:06AM +0200, Jean-Philippe Brucker wrote:
> > > On Fri, Aug 21, 2020 at 03:15:34PM +0200, Jean-Philippe Brucker wrote:
> > > > Add a topology description to the virtio-iommu driver and enable x86
> > > > platforms.
> > > > 
> > > > Since [v2] we have made some progress on adding ACPI support for
> > > > virtio-iommu, which is the preferred boot method on x86. It will be a
> > > > new vendor-agnostic table describing para-virtual topologies in a
> > > > minimal format. However some platforms don't use either ACPI or DT for
> > > > booting (for example microvm), and will need the alternative topology
> > > > description method proposed here. In addition, since the process to get
> > > > a new ACPI table will take a long time, this provides a boot method even
> > > > to ACPI-based platforms, if only temporarily for testing and
> > > > development.
> > > > 
> > > > v3:
> > > > * Add patch 1 that moves virtio-iommu to a subfolder.
> > > > * Split the rest:
> > > >   * Patch 2 adds topology-helper.c, which will be shared with the ACPI
> > > >     support.
> > > >   * Patch 4 adds definitions.
> > > >   * Patch 5 adds parser in topology.c.
> > > > * Address other comments.
> > > > 
> > > > Linux and QEMU patches available at:
> > > > https://jpbrucker.net/git/linux virtio-iommu/devel
> > > > https://jpbrucker.net/git/qemu virtio-iommu/devel
> > > 
> > > I'm parking this work again, until we make progress on the ACPI table, or
> > > until a platform without ACPI and DT needs it. Until then, I've pushed v4
> > > to my virtio-iommu/topo branch and will keep it rebased on master.
> > > 
> > > Thanks,
> > > Jean
> > 
> > I think you guys need to work on virtio spec too, not too much left to
> > do there ...
> 
> I know it's ready and I'd really like to move on with this, but I'd rather
> not commit it to the spec until we know it's going to be used at all. As
> Gerd pointed out the one example we had, microvm, now supports ACPI. Since
> we've kicked off the ACPI work anyway it isn't clear that the built-in
> topology will be useful.
> 
> Thanks,
> Jean

Many power platforms are OF based, thus without ACPI or DT support.

-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEA9C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 12:41:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C63D206D9
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 12:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buUU0/iQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C63D206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 23A9885F8E;
	Thu, 24 Sep 2020 12:41:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BMgu9pkh4v1s; Thu, 24 Sep 2020 12:41:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id ADB608523B;
	Thu, 24 Sep 2020 12:41:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A830BC0890;
	Thu, 24 Sep 2020 12:41:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EB1BC0859
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 12:41:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 12F7D86C1C
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 12:41:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IWGTp7ccBGXW for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 12:41:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EBD5F86C25
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 12:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600951292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aNSiF3HKmN7T9wLSIPvLbtJzDyySplPmYpNDTcjCSdE=;
 b=buUU0/iQJ+2uAYps14NJ/a0x+D+Id26SDB5kjvUVH5naaplnjtKjRp2sUucOAV2eqrrA6l
 iTqlfVTJ9pmUp2kUGjZXhXAqMXDH0VmaCduHRYqLhWfnaA+YonG+C5dq+3g7pkCAgP5LXj
 ThDZOopiRlQxihCEpFlubDq9gbpq1iU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-dCyAYiFMPDa5CLg0TFWNoA-1; Thu, 24 Sep 2020 08:41:28 -0400
X-MC-Unique: dCyAYiFMPDa5CLg0TFWNoA-1
Received: by mail-wm1-f72.google.com with SMTP id b20so3508051wmj.1
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 05:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aNSiF3HKmN7T9wLSIPvLbtJzDyySplPmYpNDTcjCSdE=;
 b=AgkW9zNvBaA+Wzl4L63rkydkadja7TspJdloauxBKx+VshMFejSz4ysYuTDFadfdnO
 q8Q+zldyv2ViZn4TGAOCCDpnm8ztnRC5cmPr90GnFuzlC5VKOyAHH8/gpF5c8S2lWDWV
 Pl+lpNJoXwbnLz7jNQPMtSE/DA43xCYQYi4USMbB/eDIujgVUeQZCQR9RTwsyPoghDe6
 EPYDfI+9dCzK13he6jgOEPnfS+5Wa7Suyeh7ZpOQxmM4aJ4YFR4nA28fKC84GXSfPQ5S
 O9n6xgzHgOOcEFAaqsjobhnLbJfSXS+r6XXHTtpLXnsN5fUvN27pEX8v/5gX435Q8Wch
 zAvQ==
X-Gm-Message-State: AOAM533xI/1W3+SHBieeqeOapUekkBA27U1otRA24JRvz0nSl5Esl9Wv
 QNwntwcp2clPCbqeaBAW1ReoCjfJRTrAtPhDW1nTXKXDTOHynGxTHb8ySym0De32wGkfr5FAoln
 ai9NboxQobgUqVrwM7bonS5vrtoxHpw==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr4746957wrm.320.1600951287638; 
 Thu, 24 Sep 2020 05:41:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEXHb/sRDwgsZMDckSultGUskNu3nU9TGPgRovxnxIBYnpHIZ20/F1hEMcaTVWh90tOc5wHQ==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr4746933wrm.320.1600951287425; 
 Thu, 24 Sep 2020 05:41:27 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id z11sm3575767wru.88.2020.09.24.05.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 05:41:26 -0700 (PDT)
Date: Thu, 24 Sep 2020 08:41:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200924083918-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <20200924100255.GM27174@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200924100255.GM27174@8bytes.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-pci@vger.kernel.org,
 jasowang@redhat.com, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 bhelgaas@google.com
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

On Thu, Sep 24, 2020 at 12:02:55PM +0200, Joerg Roedel wrote:
> On Thu, Sep 24, 2020 at 05:38:13AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
> > > On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
> > > > OK so this looks good. Can you pls repost with the minor tweak
> > > > suggested and all acks included, and I will queue this?
> > > 
> > > My NACK still stands, as long as a few questions are open:
> > > 
> > > 	1) The format used here will be the same as in the ACPI table? I
> > > 	   think the answer to this questions must be Yes, so this leads
> > > 	   to the real question:
> > 
> > I am not sure it's a must.
> 
> It is, having only one parser for the ACPI and MMIO descriptions was one
> of the selling points for MMIO in past discussions and I think it makes
> sense to keep them in sync.
> 
> > We can always tweak the parser if there are slight differences
> > between ACPI and virtio formats.
> 
> There is no guarantee that there only need to be "tweaks" until the
> ACPI table format is stablized.
> 
> Regards,
> 
> 	Joerg

But this has nothing to do with Linux.  There is also no guarantee that
the two committees will decide to use exactly the same format. Once one
of them sets the format in stone, we can add support for that format to
linux. If another one is playing nice and uses the same format, we can
use the same parsers. If it doesn't linux will have to follow suit.

-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

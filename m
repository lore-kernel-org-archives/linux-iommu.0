Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4164C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 09:38:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2435E206C9
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 09:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoTtA2E2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2435E206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BA169854C0;
	Thu, 24 Sep 2020 09:38:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DUZPyxyICc4P; Thu, 24 Sep 2020 09:38:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 447C285374;
	Thu, 24 Sep 2020 09:38:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B67EC0859;
	Thu, 24 Sep 2020 09:38:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80857C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 09:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 75985874BB
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 09:38:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ihrQWVFk7Pav for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:38:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 60B2A872D6
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 09:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600940303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GQMLt7r4p28L0sSJJPMjF6juRbduNigBdA5Pg+z0Rro=;
 b=WoTtA2E2mX+8s1wtC8/nTjHU/aDj88CpLWVhtWoLxMm+K6oeYehARwUpm0kVgWA6yi//e+
 2laNguNMYzYrlLKPWg6nzU7Xz7tvXji7nHGTdTpZ4YyL81w/L2qu6HEZZk0GWyilLA/D1D
 9Sbg2nRGUNjDfz0pLYVZZg1tOOohktk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-F2AIbOEHPcKjzsXmVmGUqA-1; Thu, 24 Sep 2020 05:38:19 -0400
X-MC-Unique: F2AIbOEHPcKjzsXmVmGUqA-1
Received: by mail-wm1-f71.google.com with SMTP id x6so1024312wmi.1
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 02:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GQMLt7r4p28L0sSJJPMjF6juRbduNigBdA5Pg+z0Rro=;
 b=Tj3STBFZWwfG2N7a1PDkjlXP8sWyXt1IE38a96yzyqILymGkBEFTEKVMffHxGW0HEK
 8Zf412SR+dHgtCSBGbBxPQXLhJqjlJsmFi+PMeRdXwp4A0R8uQi4n5Adx3avFcPt71ZW
 86DtzuvHLkbGXA5VPt+fgy9q4NI4URbfMkoQykDBJcJish6cyXcFHkZLAE4LQBekx7Ev
 ECRILgLj+3Wuj5AaRFNzy0LifNb5HNWmewFiGVyHrq335uuaxhppdGHkefZagf9P6+dT
 2ndI+DTATysQfii6kCjjERhCjH8WB45esxcJL+HHQkgSiz1WtTSFLCWIdiDGjkEz11Cg
 xiNQ==
X-Gm-Message-State: AOAM532kZTK0bGWkDHZeWiGIStoQWhLeI6C+h4iLCcqJmt57WyYhqFqy
 Io2SS73npqzLp+blvn6En4aNsPGBtUKZ0uHBI+Zm2BOoGj7ABl75HuCQzV7iak+rXRg9WLkxO7x
 x6pmoqFBYpLmT1UAu7xSL7PONTUAGHQ==
X-Received: by 2002:a5d:568d:: with SMTP id f13mr4007444wrv.303.1600940298005; 
 Thu, 24 Sep 2020 02:38:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNfu1dfe6iZYDmyztM8WdEywh/avjWGmq3NjwJSF1cAVd6SUgRkwNdlaUiQJUtrdpjEEYZSA==
X-Received: by 2002:a5d:568d:: with SMTP id f13mr4007413wrv.303.1600940297782; 
 Thu, 24 Sep 2020 02:38:17 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id c205sm2730814wmd.33.2020.09.24.02.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 02:38:16 -0700 (PDT)
Date: Thu, 24 Sep 2020 05:38:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200924053159-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200924092129.GH27174@8bytes.org>
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

On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
> On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
> > OK so this looks good. Can you pls repost with the minor tweak
> > suggested and all acks included, and I will queue this?
> 
> My NACK still stands, as long as a few questions are open:
> 
> 	1) The format used here will be the same as in the ACPI table? I
> 	   think the answer to this questions must be Yes, so this leads
> 	   to the real question:

I am not sure it's a must.
We can always tweak the parser if there are slight differences
between ACPI and virtio formats.

But we do want the virtio format used here to be approved by the virtio
TC, so it won't change.

Eric, Jean-Philippe, does one of you intend to create a github issue
and request a ballot for the TC? It's been posted end of August with no
changes ...

> 	2) Has the ACPI table format stabalized already? If and only if
> 	   the answer is Yes I will Ack these patches. We don't need to
> 	   wait until the ACPI table format is published in a
> 	   specification update, but at least some certainty that it
> 	   will not change in incompatible ways anymore is needed.
> 

Not that I know, but I don't see why it's a must.

> So what progress has been made with the ACPI table specification, is it
> just a matter of time to get it approved or are there concerns?
> 
> Regards,
> 
> 	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

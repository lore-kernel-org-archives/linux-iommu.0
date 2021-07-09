Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3B5C11F67
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 13:43:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0613E613C3
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 13:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0613E613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C446683D71;
	Fri,  9 Jul 2021 13:43:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JR2uZFwnDLmz; Fri,  9 Jul 2021 13:43:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A544E83D66;
	Fri,  9 Jul 2021 13:43:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DC4FC001A;
	Fri,  9 Jul 2021 13:43:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2BAAC000E;
 Fri,  9 Jul 2021 13:42:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF7A0423C3;
 Fri,  9 Jul 2021 13:42:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4F6rFXtS2hmJ; Fri,  9 Jul 2021 13:42:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83980423C1;
 Fri,  9 Jul 2021 13:42:57 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id l7so11287125wrv.7;
 Fri, 09 Jul 2021 06:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Q7mB1luMo6HbqDXiBnl1Lwdd0jsa0W6EKAtYOrdTCZQ=;
 b=NJOFIxy/hzvIvEcg/rkxXdRHKZyQ67IlcQRPEm84MsXq3HTCSWMVqr67XAfm0C7LIf
 cOvyYmaqeMmu0VOzl9iMhjWsbsJwEFUG8B4XazQaKAlBuDD294yq46njyD5WJE5rKCcT
 eIsFtECLG2BkpuFpnU6M3zm5RIKzEhCIxy7SZMPIWJmFYAejSynttqKsbOUanClO/TPo
 Q5GjRl1iAweMxiEnDxJWmF2tpkaOPhu6Dk2FCrYosQc40tzEcCWbx0vwIKZ+iL5B8cq4
 EzBKGxdchyoUqtUwjEYNWgqdMvVWA+LwCHd6n6b5gXHpLnUilY5HqpvjS/vfAR/bsd2k
 spog==
X-Gm-Message-State: AOAM530hdo5NhHP16C5MCNgNsW3L4KTO26uvozIAN/4zNOxrYOKzQGz5
 ivwWMjzl6PeRw88S58QVJvk=
X-Google-Smtp-Source: ABdhPJy1Vhv89E6JlCPqe86nNsogAgxU+t9rVvrr2JLaDugrBsREJ7+fYhw4wwqlJCIcXWLMD2M1ow==
X-Received: by 2002:adf:fd4d:: with SMTP id h13mr36177102wrs.5.1625838175836; 
 Fri, 09 Jul 2021 06:42:55 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id s9sm5305291wrn.87.2021.07.09.06.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jul 2021 06:42:55 -0700 (PDT)
Date: Fri, 9 Jul 2021 13:42:53 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC v1 3/8] intel/vt-d: make DMAR table parsing code more
 flexible
Message-ID: <20210709134253.274m4dpqukxn43q7@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-4-wei.liu@kernel.org>
 <e1dcc315-4ebb-661e-4289-d176b3db39b5@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e1dcc315-4ebb-661e-4289-d176b3db39b5@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Wei Liu <wei.liu@kernel.org>, pasha.tatashin@soleen.com,
 kumarpraveen@linux.microsoft.com, Will Deacon <will@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 "open list:INTEL IOMMU VT-d" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>, David Woodhouse <dwmw2@infradead.org>,
 Vineeth Pillai <viremana@linux.microsoft.com>
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

On Fri, Jul 09, 2021 at 01:56:46PM +0100, Robin Murphy wrote:
> On 2021-07-09 12:43, Wei Liu wrote:
> > Microsoft Hypervisor provides a set of hypercalls to manage device
> > domains. The root kernel should parse the DMAR so that it can program
> > the IOMMU (with hypercalls) correctly.
> > 
> > The DMAR code was designed to work with Intel IOMMU only. Add two more
> > parameters to make it useful to Microsoft Hypervisor. Microsoft
> > Hypervisor does not need the DMAR parsing code to allocate an Intel
> > IOMMU structure; it also wishes to always reparse the DMAR table even
> > after it has been parsed before.
> 
> We've recently defined the VIOT table for describing paravirtualised IOMMUs
> - would it make more sense to extend that to support the Microsoft
> implementation than to abuse a hardware-specific table? Am I right in

I searched for VIOT and believed I found the correct link
https://lwn.net/Articles/859291/. My understanding is based on the
reading of that series.

VIOT is useful. I think it solves the problem for guests.

It does not solve the problem we have though. The DMAR tables are not
conjured up by some backend software running on the host side. They are
the real tables provided by the firmware. The kernel here is part of the
host setup, dealing with physical hardware.

No matter how much I wish all vendors unified their tables, I don't see
how that's going to happen for readily available servers. :-(

> assuming said hypervisor isn't intended to only ever run on Intel hardware?

Yes, that's correct. We also plan to add support AMD and ARM64.

Wei.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

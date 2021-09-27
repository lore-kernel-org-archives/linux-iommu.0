Return-Path: <SRS0=QBaT=OR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2579C433EF
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 23:13:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CBDD611BD
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 23:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CBDD611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 44A0440519;
	Mon, 27 Sep 2021 23:13:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FjPBLUY24ODZ; Mon, 27 Sep 2021 23:13:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CFD74402A6;
	Mon, 27 Sep 2021 23:13:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3EDDC0011;
	Mon, 27 Sep 2021 23:13:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59DFEC000D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 23:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3AB7480F9F
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 23:13:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sPKMusbeV2jJ for <iommu@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 23:13:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CDD8180F95
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 23:13:49 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id y186so7889040pgd.0
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 16:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l4MzJ0yx9cD5fkatxhkgcIgfFDenItN2Wh8q8r9GPSA=;
 b=y3IML/IiRF9nk6cBsuR66v5EtYFXcqv9+kamXCWPCMEmblkdaeE1LDv5amUzTxiTzH
 smbfxg0LwR2V218iRSPpiFuCgmVRLUSkj7pYqhqmgQnV5vv2TqB24J5ubT28yxUUYXTo
 D0zbXxwlcZAJWgl4utsPM0PlopLNEmdM3vvLKn57U+H86myKPhwnJQq7IG/s2DwoyAAJ
 nYdarsvxXFoR6m5U8Ax9XOiRnxhWpSyPG8W9Gzhas3B0QBaG653TjG/ZCDCl3ABXKDFA
 NhSdzNY1WenPjh42aOdKY/IDxtuxgqRAmxJI5ZgWIONXlzwMUE/HGOxi3qv7aXY9d0cU
 8TFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l4MzJ0yx9cD5fkatxhkgcIgfFDenItN2Wh8q8r9GPSA=;
 b=JA8MXnDXj3IIpOuo0P1Dgvhi7IHcS6tZ6and58o7MBCo8kNkcJu53za4OnxuY5k26Q
 z9+sUwffDje/CaXqKrKtm3dOqJw1xN41D9hcFetu8vx1Vi37y38aeAg8bTEVe8rBHnok
 ahSnmnpdZAZltBE4R1/7YuquN8fph8aZfe7ZZcaDxG0Gok48Wupln3owlH3NJb9uCeYK
 B6GQsP/nDJl/cHTIolMyu288Mt46QwfCkil4lXWzCOl2Pabsxyv+9dQPXZbA5eY6kLKi
 sW9gFj4ZF7kT3+WxdhP0RNHSnzbTniKujIB6fW/mkvvARzT+Z7Lux+npYwpyKpbx+cWk
 XLBQ==
X-Gm-Message-State: AOAM532SRJP/sbbqPuarwR+U+SNfHBp6NL+NMklbP93tAXbdj8LI5wsg
 yJqqyooWooSLkXsE4zl4R7BakkdecHIM4t2MmsSufw==
X-Google-Smtp-Source: ABdhPJzlhMrLY74o1cFWM7LDOyTRznwGcz5LuxyrnypmeeMmsbLgr6YqtHQ2yRKjvE547QjRsLHUH/2m9VYlflG4fcU=
X-Received: by 2002:a62:7f87:0:b0:444:b077:51ef with SMTP id
 a129-20020a627f87000000b00444b07751efmr2120157pfd.61.1632784429227; Mon, 27
 Sep 2021 16:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172647.72738-1-ben.widawsky@intel.com>
 <20210923172647.72738-2-ben.widawsky@intel.com>
In-Reply-To: <20210923172647.72738-2-ben.widawsky@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 27 Sep 2021 16:13:41 -0700
Message-ID: <CAPcyv4gXiW7ap3dULCwcWLy1qkGOrgdJTBonfw5V7h6ZOQ-+AQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] cxl: Convert "RBI" to enum
To: Ben Widawsky <ben.widawsky@intel.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>, Linux PCI <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-cxl@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 "David E. Box" <david.e.box@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Kan Liang <kan.liang@linux.intel.com>
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

Please spell out "register block indicator" in the subject so that the
shortlog remains somewhat readable.

On Thu, Sep 23, 2021 at 10:27 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> In preparation for passing around the Register Block Indicator (RBI) as
> a parameter, it is desirable to convert the type to an enum so that the
> interface can use a well defined type checked parameter.

C wouldn't type check this unless it failed an integer conversion,
right? It would need to be a struct to get useful type checking.

I don't mind this for the self documenting properties it has for the
functions that will take this as a parameter, but maybe clarify what
you mean by type checked parameter?

>
> As a result of this change, should future versions of the spec add
> sparsely defined identifiers, it could become a problem if checking for
> invalid identifiers since the code currently checks for the max
> identifier. This is not an issue with current spec, and the algorithm to
> obtain the register blocks will change before those possible additions
> are made.

In general let's not spend changelog space trying to guess what future
specs may or may not do. I.e. I think this text can be dropped,
especially because enums can support sparse number spaces.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

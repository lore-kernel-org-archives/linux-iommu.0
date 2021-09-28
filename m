Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47BDC433F5
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 17:35:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561566108E
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 17:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 561566108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D30060B16;
	Tue, 28 Sep 2021 17:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hoOhRzi_UNWW; Tue, 28 Sep 2021 17:35:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 03D1A6067A;
	Tue, 28 Sep 2021 17:35:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCE8CC000F;
	Tue, 28 Sep 2021 17:35:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42659C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 17:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3223F60AF7
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 17:35:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z3JKY8sjAMf8 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 17:35:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B9336067A
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 17:35:48 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 lb1-20020a17090b4a4100b001993f863df2so3399933pjb.5
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z4rpZbh5fY0GJmvqTpqKPOJUU3/CkuLxZ3x2vaW47gs=;
 b=wZ2qK0vDwa/x+WmO54A8bVqDnaE4MxcyOEaPNfghMs0xFBaF5wolp8j+kq8NVd53dl
 rsImtXgdg957L8wghBAufVSqgLyC4EmLedX89tGCu9hdbwa/j0bK+igN5QxEz+2sSMn4
 Jkpzph4lS6pupyWbeuUVoT7QYa/faQ1K5gWMxS69D0LVU584l+LYqEdHM36t5UUJP8KZ
 Ox8vtfVgQGLnLqDI7aAS7eftEkVJGtu441BAiHEGfxU6S8AyhzXUAUXd3857Wfq2hmsT
 U/DpbWTh0lWZxkH3nJrhEHTL0R210cPEJQldelq0QNJ765EUoU+wh6cTG8Wqc7Jl6mzu
 QXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z4rpZbh5fY0GJmvqTpqKPOJUU3/CkuLxZ3x2vaW47gs=;
 b=VvNfblEoXpqIoFg6FCWh4qZqZwPRayI2YMyE/QVnbMRRjzShu0PcnwQYEtAo1a/u1G
 j64DidOvdOc2ScX926eLMN4sKGTdzqC/Dy98uSEmvcLXs3mx2CsTIbf+S+GWoQM3Omih
 IR8w68jfGD8zxaFW8/ItcGr2JIiuXCWfUxJZEpMa0I9T6is4YYW/UjeamjhvFJMnQ6VR
 k1oM+Ms+XcksH0576n6Bw7olq3RPvFUVpupVapFzOhakOnGBS0x2NxU+BfF7LPjfVgcg
 qLtNxsYPchB9J2xI3HmToVqZeifHJwMwBVFt2pKde4pxvSC4aGLi+AcTx3G4bS50e80R
 UZ4A==
X-Gm-Message-State: AOAM532MKtzpW7tGznmvRNheSQyGaoChnaVMhJfWaGJlyvTa9WOO8J6+
 I3zrxvJqZH34oWp26OCBkqXPfc/+yi5sTgSSAS1YKw==
X-Google-Smtp-Source: ABdhPJw3YufFCASrMQKrr5qR62jfqEobEWU5JH/XKYq1dn6X8ous0KD9EnMyS9mGmOC2Zwa4E1WW3YScKPZdcYfFVq8=
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr1302865pju.8.1632850547865; 
 Tue, 28 Sep 2021 10:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172647.72738-1-ben.widawsky@intel.com>
 <20210923172647.72738-5-ben.widawsky@intel.com>
In-Reply-To: <20210923172647.72738-5-ben.widawsky@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 28 Sep 2021 10:35:34 -0700
Message-ID: <CAPcyv4i7Dytarp3Hxi_ECtCU+Ve985dNCh07a8wJX0sTgCnR0Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cxl/pci: Refactor cxl_pci_setup_regs
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

On Thu, Sep 23, 2021 at 10:27 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> In preparation for moving parts of register mapping to cxl_core, the
> cxl_pci driver is refactored to utilize a new helper to find register
> blocks by type.
>
> cxl_pci scanned through all register blocks and mapping the ones that
> the driver will use. This logic is inverted so that the driver
> specifically requests the register blocks from a new helper. Under the
> hood, the same implementation of scanning through all register locator
> DVSEC entries exists.
>
> There are 2 behavioral changes (#2 is arguable):
> 1. A dev_err is introduced if cxl_map_regs fails.
> 2. The previous logic would try to map component registers and device
>    registers multiple times if there were present and keep the mapping
>    of the last one found (furthest offset in the register locator).
>    While this is disallowed in the spec, CXL 2.0 8.1.9: "Each register
>    block identifier shall only occur once in the Register Locator DVSEC
>    structure" it was how the driver would respond to the spec violation.
>    The new logic will take the first found register block by type and
>    move on.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> ---
> Changes since v1:

No changes? Luckily git am strips this section...

Overall I think this refactor can be broken down further for
readability and cleanup the long standing problem that the driver maps
component registers for no reason. The main contributing factor to
readability is that cxl_setup_pci_regs() still exists after the
refactor, which also contributes to the component register problem. If
the register mapping is up leveled to the caller of
cxl_setup_pci_regs() (and drops mapping component registers) then a
follow-on patch to rename cxl_setup_pci_regs to find_register_block
becomes easier to read. Moving the cxl_register_map array out of
cxl_setup_pci_regs() also makes a later patch to pass component
register enumeration details to the endpoint-port that much cleaner.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

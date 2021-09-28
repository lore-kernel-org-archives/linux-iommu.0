Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C98C433FE
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 17:41:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD6A61355
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 17:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6BD6A61355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 336F560B2E;
	Tue, 28 Sep 2021 17:41:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C-pN4Ul07yMX; Tue, 28 Sep 2021 17:41:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2F21360B15;
	Tue, 28 Sep 2021 17:41:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 062F9C000F;
	Tue, 28 Sep 2021 17:41:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AC67C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 17:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C84B4029F
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 17:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5lB8PatrDwai for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 17:41:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9FD8240105
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 17:41:37 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id g184so21980263pgc.6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WkidfBLNDflGiXs0oP3mDBZ5il/79hD91IY+k5Xsxuc=;
 b=bA7yAxAI4PivPTDL2tmtUWSug8cFLm+Lp/M/J8tWpOX7VThwyhD1uHRnHWyn1gypjz
 /XzmjC9sfErVDuGFsyJvSSHvvhu9nQ7Kso3E+RGxpZnlV1rpwx4LYj/P5l6Z38Y/UEfp
 dNeWL6kK9unlsA8wG5GEhkIZ+4tvRDOMk+TJy7HzL9rdoix0FJNsfZcPFnfoMkxbst93
 a/G0KXVU8o79EfFIKtiBKh5+QiY7b/PJds1zfTAHCkczgYa7RB5dkQrraBWKo6v3QHEl
 TcfvQ5mM+1T1aqcT9TKMJNtVWXVgUrfew9Eem3OwSym9y2/TAeOib1Yk9gpHI3xIahD9
 clDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WkidfBLNDflGiXs0oP3mDBZ5il/79hD91IY+k5Xsxuc=;
 b=6zarjvKK+jZ6KYITJHEftDQcwRpVniO/YuJG5ItSGrZV2ZmH+CiWjQyi2f896eXlbr
 p1PMP5TXqD6k1SJBnvWIwU1TSVQt6x2m/NGRSzJ+zKF0Nl2Id8yiCtQ/cz2KHaj6lhPb
 BKp8tDMC6JrAkT1EtbJFKMPiGV6yc8K7SPqxYKe4t+Mlu2v01YjsFN7IE8e3AvChfm4I
 Cqjf6ZNesypo8OW/OMDfxdVhymTqtEkOZUT0KrWZZBS3zcu6BPPK7DJhELAsZ5BdkhJ+
 rtJ1QkJqBSdW8pgnT6fBzWtPl37T6m2WbGfmDJ/yaZB6/pTVYG9Hzny1JvO7TUx0SxSx
 r3gQ==
X-Gm-Message-State: AOAM531mbtDfp92IvEl90cpN58DHAEvYbIHr76ImzaODOiyDOxT1Z8yA
 D6xF1q6xHIfp/scveFjsA5DpYwYqN1mtDcmvnk6+wu69jfU=
X-Google-Smtp-Source: ABdhPJxE685ihjSuTSw0+w9d2q6ixqqWA3MsNeG+SfMab1LeeuIrmS8uWL0F1Ylm1UNzWyahPTQwxwoyCoYk+d5LLKY=
X-Received: by 2002:a63:1e0e:: with SMTP id e14mr5684055pge.5.1632850896968;
 Tue, 28 Sep 2021 10:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172647.72738-1-ben.widawsky@intel.com>
 <20210923172647.72738-6-ben.widawsky@intel.com>
In-Reply-To: <20210923172647.72738-6-ben.widawsky@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 28 Sep 2021 10:41:24 -0700
Message-ID: <CAPcyv4j5aRTEX=FDjYv21J0uDWbP66j-xaDPkvjmwdnKmvAWDA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] cxl/pci: Make more use of cxl_register_map
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
> The structure exists to pass around information about register mapping.
> Using it more extensively cleans up many existing functions.

I would have liked to have seen "add @base to cxl_register_map" and
"use @map for @bar and @offset arguments" somewhere in this changelog
to set expectations for what changes are included. That would have
also highlighted that adding a @base to cxl_register_map deserves its
own patch vs the conversion of @bar and @offset to instead use
@map->bar and @map->offset. Can you resend with that split and those
mentions?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

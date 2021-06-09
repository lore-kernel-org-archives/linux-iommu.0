Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53B3C47095
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 09:01:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798EB61185
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 09:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798EB61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E43783C1C;
	Wed,  9 Jun 2021 09:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eN0BNJOLUpBr; Wed,  9 Jun 2021 09:01:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 357C083BF5;
	Wed,  9 Jun 2021 09:01:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB1AEC000D;
	Wed,  9 Jun 2021 09:01:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45BC5C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 09:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1DFB54027F
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 09:01:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P0qUxjVkgQzG for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 09:01:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 786664025D
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 09:01:53 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26F6B6023B;
 Wed,  9 Jun 2021 09:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623229313;
 bh=Z+zI0RDuvSuYN6v7HJscpw3B4/5MAYapaANvzw9NBwc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WmiR2RPPVpg5P331nrK6XjeWdv7pCU0af80mG7uj4/EG2o1tb9LLtohiNLtk8mpOb
 tkFIKDCEKcOcSiIcbIMGVJ/fN1JUvOts/U/6Yw1l97gZt0kPZUy4edDI5lNpXcnIHC
 W5BeTbAVwtq/9WO1fN6mDJoad1oG+A8DlCM4IJCZshJ82bV4+vGfwQkfXHIYfjD0jV
 bEtrvNChyxo6+7hO+YhBAUjFIuWHPM3pjUlKGjLtPl/N1r55hfu6xP0Jm22i9rYpGC
 TnY9mjqjTBAMX7vHcjrSXqStZ8qiBPVsWNoI4f98t6nYhC5euToDZuG5VDhnF8mgAN
 QyqLZFfoTPMdQ==
Date: Wed, 9 Jun 2021 12:01:49 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <YMCDfWLw6r80Wdu3@unreal>
References: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

On Mon, Jun 07, 2021 at 02:58:18AM +0000, Tian, Kevin wrote:
> Hi, all,

<...>

> (Remaining opens in v1)

<...>

> -   Device-centric (Jason) vs. group-centric (David) uAPI. David is not fully
>     convinced yet. Based on discussion v2 will continue to have ioasid uAPI
>     being device-centric (but it's fine for vfio to be group-centric). A new
>     section will be added to elaborate this part;

<...>

> (Adopted suggestions)

<...>

> -   (Jason) Addition of device label allows per-device capability/format 
>     check before IOASIDs are created. This leads to another major uAPI 
>     change in v2 - specify format info when creating an IOASID (mapping 
>     protocol, nesting, coherent, etc.). User is expected to check per-device 
>     format and then set proper format for IOASID upon to-be-attached 
>     device;

Sorry for my naive question, I still didn't read all v1 thread and maybe
the answer is already written, but will ask anyway.

Doesn't this adopted suggestion to allow device-specific configuration
actually means that uAPI should be device-centric?

User already needs to be aware of device, configure it explicitly, maybe
gracefully clean it later, it looks like not so much left to be group-centric.

Thanks
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

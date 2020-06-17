Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8833EC433E0
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 20:04:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2801020897
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 20:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U62EIiVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2801020897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CFF8421549;
	Wed, 17 Jun 2020 20:04:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UXI0gJmo0x0R; Wed, 17 Jun 2020 20:04:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 72718203A7;
	Wed, 17 Jun 2020 20:04:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63BE6C07FF;
	Wed, 17 Jun 2020 20:04:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9DAEC016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 20:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B1652883B8
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 20:04:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nfXSncX5xsYW for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 20:04:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 54D46882C3
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 20:04:40 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E35642193E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 20:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592424279;
 bh=yCtGv9eVlMKw9D6v7Ig4uZ2wW0Tp8uCLu0Xw3XWC5sE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=U62EIiVFSy9+Y5G0+Z8Ru87mRY7pIfuk/Xt1lZwTH1R4Z1sogOcvMrDrqNLe2yrK7
 2jd3b3fMwAwplYIympzqfs+cgg9rJworSDqTRYxZjGdWiqzDuwnsLQqIWmOVr8J44r
 aR/UgDjBY5umc9i7U44UT5xEFKGcMaR5iAQQ33Ac=
Received: by mail-wm1-f49.google.com with SMTP id r15so3337790wmh.5
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 13:04:38 -0700 (PDT)
X-Gm-Message-State: AOAM531IG3Gdw+RRL3kyQe0EUxASJ7stZnwQUNDt/Sg0+HFw4Uq5inri
 Hi+/UsjdlBxeyEoniZK/mX1cGdjNGJax/7/vSRsdKA==
X-Google-Smtp-Source: ABdhPJwF+e7fdqSN9IJOEQH25Ju27rVnKNE0KkLy448jhlRMelw5Y5sP+Yps/00ZoQ2rvoEmHyYyOf2BhJS3yDCf8Yw=
X-Received: by 2002:a05:600c:22da:: with SMTP id
 26mr394359wmg.176.1592424277291; 
 Wed, 17 Jun 2020 13:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com>
 <1592418233-17762-2-git-send-email-fenghua.yu@intel.com>
 <CALCETrXFHa_05-sGAy5M9YGJWUfTn9MfM-ZYk+hp12tqHNJA0Q@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7F67216A@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F67216A@ORSMSX115.amr.corp.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 17 Jun 2020 13:04:25 -0700
X-Gmail-Original-Message-ID: <CALCETrWe=7CoS8j7w5penF9xWndcrvYDhJpEUdymfLBtjmNUkQ@mail.gmail.com>
Message-ID: <CALCETrWe=7CoS8j7w5penF9xWndcrvYDhJpEUdymfLBtjmNUkQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] iommu: Change type of pasid to unsigned int
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Shankar,
 Ravi V" <ravi.v.shankar@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, "Hansen,
 Dave" <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
 H Peter Anvin <hpa@zytor.com>, Christoph Hellwig <hch@infradeed.org>,
 Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw2@infradead.org>
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

On Wed, Jun 17, 2020 at 12:39 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> > Is PASID in the uapi at all?
>
>
> $ grep pasid include/uapi/linux/iommu.h
> * @pasid: Process Address Space ID
>         __u32   pasid;
>  * @pasid: Process Address Space ID
>         __u32   pasid;
>  * @pasid: Process Address Space ID
>         __u32   pasid;
>  * - If the PASID bit is set, the @pasid field is populated and the invalidation
>  * @pasid: process address space ID
>         __u64   pasid;
>  * struct iommu_inv_pasid_info - PASID Selective Invalidation Structure
>  * - If the PASID bit is set, the @pasid field is populated and the invalidation
>  * @pasid: process address space ID
> struct iommu_inv_pasid_info {
>         __u64   pasid;
>  * @pasid_info: invalidation data when @granularity is %IOMMU_INV_GRANU_PASID
>                 struct iommu_inv_pasid_info pasid_info;
>  * struct iommu_gpasid_bind_data_vtd - Intel VT-d specific data on device and guest
> struct iommu_gpasid_bind_data_vtd {
>  * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
>  * @hpasid:     Process address space ID used for the guest mm in host IOMMU
>  * @gpasid:     Process address space ID used for the guest mm in guest IOMMU
> struct iommu_gpasid_bind_data {
>         __u64 hpasid;
>         __u64 gpasid;
>                 struct iommu_gpasid_bind_data_vtd vtd;


Aha.  I guess this is considerably older than I thought.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC7DC433DF
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 19:35:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A297E208D5
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 19:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="agqnsRa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A297E208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 714ED8805A;
	Wed, 17 Jun 2020 19:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ghqYo9zaaWRF; Wed, 17 Jun 2020 19:35:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A42EB87E35;
	Wed, 17 Jun 2020 19:35:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76556C07FF;
	Wed, 17 Jun 2020 19:35:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D05EC016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 19:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5469687E7D
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 19:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1aDPwyyfUtxk for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 19:35:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EB5D387E35
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 19:35:24 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5F6D021883
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592422524;
 bh=kj0CVUWmj6brL8f0EF5vkVooJfxv+yYMAPz+jZjllkU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=agqnsRa/EK56lzeAqjMVgQ1zbGyGoA2svGW8UU92BMH5riL2IDrqXSl30601Let+T
 Fd8XkVT/VcRME6B1M/dEiFsPsHxNWMLiZjMBzMAVNrUqFSFOmUu+FZ/lEU2FxhFz1O
 X6HuTjdQFU2wcbM7p0A8xL+cYsaejBnp+778vd3I=
Received: by mail-wm1-f54.google.com with SMTP id l26so2979980wme.3
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 12:35:24 -0700 (PDT)
X-Gm-Message-State: AOAM531pKriUEUkKtm1gq1mM7e8QBAoa4sD67BAscl/LEUBguG4eclKV
 JfabZz2B2xtSsW/LjuRfzMSRUMxNMicT3/iMDoTAHQ==
X-Google-Smtp-Source: ABdhPJwZufrSC0HSDHfM4LNl3upPjFIP57rAsb579ve9INcvPBLnanr6p4UckI+Bo36Vg5i5NBiwIO759HWAx17PmDw=
X-Received: by 2002:a1c:4804:: with SMTP id v4mr294927wma.21.1592422522886;
 Wed, 17 Jun 2020 12:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com>
 <1592418233-17762-2-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1592418233-17762-2-git-send-email-fenghua.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 17 Jun 2020 12:35:11 -0700
X-Gmail-Original-Message-ID: <CALCETrXFHa_05-sGAy5M9YGJWUfTn9MfM-ZYk+hp12tqHNJA0Q@mail.gmail.com>
Message-ID: <CALCETrXFHa_05-sGAy5M9YGJWUfTn9MfM-ZYk+hp12tqHNJA0Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] iommu: Change type of pasid to unsigned int
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Tony Luck <tony.luck@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Christoph Hellwig <hch@infradeed.org>, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw2@infradead.org>
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

On Wed, Jun 17, 2020 at 11:24 AM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> PASID is defined as a few different types in iommu including "int",
> "u32", and "unsigned int". To be consistent and to match with ioasid's
> type, define PASID and its variations (e.g. max PASID) as "unsigned int".
>
> No PASID type change in uapi.

Is PASID in the uapi at all?

--Andy
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

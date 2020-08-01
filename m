Return-Path: <SRS0=Zw9n=BL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986CFC433E0
	for <iommu@archiver.kernel.org>; Sat,  1 Aug 2020 01:28:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649A920838
	for <iommu@archiver.kernel.org>; Sat,  1 Aug 2020 01:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/IFq9Ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649A920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 64B0C20553;
	Sat,  1 Aug 2020 01:28:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W6w2NiPghfPz; Sat,  1 Aug 2020 01:28:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9006A204E4;
	Sat,  1 Aug 2020 01:28:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 830E8C0050;
	Sat,  1 Aug 2020 01:28:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14371C004D
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 01:28:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 02975887A1
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 01:28:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aHCFP8Mt92L5 for <iommu@lists.linux-foundation.org>;
 Sat,  1 Aug 2020 01:28:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 50C788879F
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 01:28:51 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CA0B622D03
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 01:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596245331;
 bh=iEFTd5J3OaIz2CPblhNjm4HIdHFf3NTyBlaCyk5tBwc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=G/IFq9Ak/z1tIY565HeH9QUdS4I/0ddtRnlM53NrwyyfHN6fvaqz11kqP0IoARvXz
 zvOHrUmIKGOV5kFacyre9XA834GxNVRV4s6VBEYfljjYkJbTzTTvPx7GmZqZt9Z5bu
 qpn1i1Yxce5xcOxluVisee2h1xIpxwlDki8j3zAE=
Received: by mail-wm1-f51.google.com with SMTP id k20so10701793wmi.5
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 18:28:50 -0700 (PDT)
X-Gm-Message-State: AOAM531feiTFB9+meigDtNwTDrtP4/DtFq2Bcwlv6EWIy4BxHG0nzUsk
 86ZS8/bKELxkDSa8mR5d9x0bOQ3sgK+n2q53hj0lXw==
X-Google-Smtp-Source: ABdhPJwqMB4yU9t8y4FC7B3ExHcTCCL1w+nLeHjKE26+trC+5yOlCmBolk7+/lVqfoJLVEkj6eyrxs3QsKfB+JPQNtY=
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr5903705wmk.176.1596245328660; 
 Fri, 31 Jul 2020 18:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-13-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1594684087-61184-13-git-send-email-fenghua.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 31 Jul 2020 18:28:37 -0700
X-Gmail-Original-Message-ID: <CALCETrV6yTjFzuTMEP8T9_QfjAXktHZcMXSqionZGJ=Lj0YdFg@mail.gmail.com>
Message-ID: <CALCETrV6yTjFzuTMEP8T9_QfjAXktHZcMXSqionZGJ=Lj0YdFg@mail.gmail.com>
Subject: Re: [PATCH v6 12/12] x86/traps: Fix up invalid PASID
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 H Peter Anvin <hpa@zytor.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Mon, Jul 13, 2020 at 4:48 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> A #GP fault is generated when ENQCMD instruction is executed without
> a valid PASID value programmed in the current thread's PASID MSR. The
> #GP fault handler will initialize the MSR if a PASID has been allocated
> for this process.

Let's take a step back here.  Why are we trying to avoid IPIs?  If you
call munmap(), you IPI other CPUs running tasks in the current mm.  If
you do perf_event_open() and thus acquire RDPMC permission, you IPI
other CPUs running tasks in the current mm.  If you call modify_ldt(),
you IPI other CPUs running tasks in the current mm.  These events can
all happen more than once per process.

Now we have ENQCMD.  An mm can be assigned a PASID *once* in the model
that these patches support.  Why not just send an IPI using
essentially identical code to the LDT sync or the CR4.PCE sync?

--Andy
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

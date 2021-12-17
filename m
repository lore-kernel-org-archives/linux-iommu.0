Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11EAC433F5
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 22:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C3FB61130;
	Fri, 17 Dec 2021 22:57:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VdjEGZDl9AQP; Fri, 17 Dec 2021 22:57:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7A3BD61119;
	Fri, 17 Dec 2021 22:57:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DE0EC001E;
	Fri, 17 Dec 2021 22:57:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C763C0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:57:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E1E8041E88
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:57:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iHd8eWhn1UDz for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 22:57:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5155E41D44
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639781834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+KxH5v9Eb3o+QR18pfErKc1z+d/J0pC61Cr5tDyvWcc=;
 b=T/s6KfFkc17witCdLdpA3oOAFFgdKw14DMHIOM59huIvyAhmA40NjQoPDgZj/8eTv0tRw7
 zIB/Sejz28Oca0vSN3mTvd/uHZUeKoQocHKfQzkwbphCjjFGgjKxCx1uKjK8Lvwq7a28RM
 mpVjkfqvG6V5ah+ThpBTaY9kS5cKIpA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-49CEf8y0NSC-9UdCOJ3-VQ-1; Fri, 17 Dec 2021 17:57:11 -0500
X-MC-Unique: 49CEf8y0NSC-9UdCOJ3-VQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 jo4-20020a056214500400b003a5cb094fb8so3878184qvb.22
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 14:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+KxH5v9Eb3o+QR18pfErKc1z+d/J0pC61Cr5tDyvWcc=;
 b=y4zK+6jj4QL7RDEezL9f3CIqeytnxyup+eAogYckgbeEBMnSkLsFMz7isLXUtEE3Ug
 RfgLpfyH1r2kx0BiMZ/FAmbkZ7aQz0LkLkBScfKk4ITnrHPmZ3uTavMlN92AwSX0Nmdh
 C9goaHYXcWCnvR+V7oGneafi78e+eLaP3ns2fqqAy/oOn8EbkbuoCQhuPGI5815uq/i9
 0+OVVP4LS0eqvovnF4yhc33jcjrmPNUB+poQOGUzSkmrMni2eW7aYdrWocYRFwhYTSmm
 91uyHYuuD0FNFt13Ewln3DPVtgLHSHDuL6oVGoLcMPQyxHw3OE8zSAjVnE/8iTt0EG7S
 jZpA==
X-Gm-Message-State: AOAM530K36kvrYuwZhhZZyZhK6oAwCv8gGawdO4fhASCJ8lMsKJmb0Cd
 2kVV/kDQYsU6+jlb01lcFzEQUJ54jQWQcsNmDGhQe6J9Zcda4DXsrsfOk3ZdIoikAbNdtcOCwRe
 YSS+EjmOwq5H2LMGAVhJf4Icjy8dx+g==
X-Received: by 2002:a05:620a:c4f:: with SMTP id
 u15mr3355599qki.565.1639781830647; 
 Fri, 17 Dec 2021 14:57:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXTuyfhYWKF4pQk89sjuYVjRKVvS7QNC4FUSVmFAhRcqT4DCDcP4pbJoonGDrl/wkVMlwLfw==
X-Received: by 2002:a05:620a:c4f:: with SMTP id
 u15mr3355589qki.565.1639781830438; 
 Fri, 17 Dec 2021 14:57:10 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
 by smtp.gmail.com with ESMTPSA id g12sm8095977qtk.69.2021.12.17.14.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Dec 2021 14:57:10 -0800 (PST)
Date: Fri, 17 Dec 2021 14:57:06 -0800
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v2 10/11] tools/objtool: Check for use of the ENQCMD
 instruction in the kernel
Message-ID: <20211217225706.32ahbyf5yeuzrhre@treble>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-11-fenghua.yu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20211217220136.2762116-11-fenghua.yu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
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

On Fri, Dec 17, 2021 at 10:01:35PM +0000, Fenghua Yu wrote:
> The ENQCMD implicitly accesses the PASID_MSR to fill in the pasid field
> of the descriptor being submitted to an accelerator. But there is no
> precise (and stable across kernel changes) point at which the PASID_MSR
> is updated from the value for one task to the next.
> 
> Kernel code that uses accelerators must always use the ENQCMDS instruction
> which does not access the PASID_MSR.
> 
> Check for use of the ENQCMD instruction in the kernel and warn on its
> usage.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> v2:
> - Simplify handling ENQCMD (PeterZ and Josh)

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

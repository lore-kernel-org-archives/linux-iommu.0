Return-Path: <SRS0=55Rd=OL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC633C43217
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 21:34:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E72E61131
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 21:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E72E61131
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 52728403CA;
	Tue, 21 Sep 2021 21:34:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U4Dny-truzVE; Tue, 21 Sep 2021 21:34:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 061FD402DB;
	Tue, 21 Sep 2021 21:34:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9761C0011;
	Tue, 21 Sep 2021 21:34:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EFD6C000D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 21:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D7D180EDD
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 21:34:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=shutemov-name.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P4YAoNXQ86J5 for <iommu@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:34:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9193580EDA
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 21:34:02 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id u8so2943986lff.9
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=onYH57UKgRX2y9FA652B6Jil/Y6sRo6kbtM4byaxFbk=;
 b=eBVF3W3VBl8/Kcc3edgbmiaMz5aGtiFcsghvZhSejZhbmeEyK5UQw/1PFkiQyXYHaG
 ep1Qe79XGKoddakjbluJzSSdU6e7ItIa/VyOBVU9ai0Bymzz3iDJtyFjRD39EIPM25vz
 4qz0qSZamNXJd68fq5IJpTDDpau43+mSfg2XWhoKoGxbOFiuRtiRYE7GfxGmSUDaHEJg
 E7kAQREHoi4We6KjgT1K6PZUTHBzzEa/WGaKq/wElm+NwA9Dj3BI08sAZJBTPlkJn2D7
 eFgy10WdV1zv/1WS3CBekNlpT18oJkYC++DPHzSZnogr5FAXrL71q6vwYz/oJyJkBY1z
 HMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=onYH57UKgRX2y9FA652B6Jil/Y6sRo6kbtM4byaxFbk=;
 b=xXj+4eWX4NMxLOJxQ3Gl3lnlLJG3uNsSW1BeEViC4QVtwjuQrwM2JM8lQew24mYG/L
 UAJOwy4OGkKbiQ4CSA7nDiJ23tiDEMgD5fS9/ipLIIYoHmjirLAEi9MCEdbmAnjyy7C6
 ws+n9JHrbKHo7KTtR/qqwm7nuSk8LjE9JMfYjMXRMTQXpbT8MVBCki7S+K+F0cry/EhY
 t+4ioHKGs3YuJJUibZf66h6ee2co5BDlwotX7JO3eV3IOImNlmsMlezHs13sMLyCmMti
 WJa8qN3IJbeB4lTMSGrZ/pmE8D+aHrKyzKfykcufB6MawKj4tqqagC/ObU2qW91l6WeX
 Ky8A==
X-Gm-Message-State: AOAM532wYNzMmQNBy/30lk9SmYMNdvgZ19cbRRX4NlAk4EOzZ57kvOVz
 X+lovfASXlo/1qUHPLzjiT7x/Q==
X-Google-Smtp-Source: ABdhPJwdW58yGabAJZgobn6vaDrfqJrmQRLjEbi4LByZcJNYEBlALvg49HirVUieAeO4lwAN455DSA==
X-Received: by 2002:a05:6512:3096:: with SMTP id
 z22mr19350411lfd.167.1632260040535; 
 Tue, 21 Sep 2021 14:34:00 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
 by smtp.gmail.com with ESMTPSA id t14sm16618lfp.15.2021.09.21.14.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 14:34:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
 id 3890410305C; Wed, 22 Sep 2021 00:34:01 +0300 (+03)
Date: Wed, 22 Sep 2021 00:34:01 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
Message-ID: <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <367624d43d35d61d5c97a8b289d9ddae223636e9.1631141919.git.thomas.lendacky@amd.com>
 <20210920192341.maue7db4lcbdn46x@box.shutemov.name>
 <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com>
 <YUoao0LlqQ6+uBrq@zn.tnic>
 <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
 <YUpONYwM4dQXAOJr@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YUpONYwM4dQXAOJr@zn.tnic>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, linux-graphics-maintainer@vmware.com,
 Tom Lendacky <thomas.lendacky@amd.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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

On Tue, Sep 21, 2021 at 11:27:17PM +0200, Borislav Petkov wrote:
> On Wed, Sep 22, 2021 at 12:20:59AM +0300, Kirill A. Shutemov wrote:
> > I still believe calling cc_platform_has() from __startup_64() is totally
> > broken as it lacks proper wrapping while accessing global variables.
> 
> Well, one of the issues on the AMD side was using boot_cpu_data too
> early and the Intel side uses it too. Can you replace those checks with
> is_tdx_guest() or whatever was the helper's name which would check
> whether the the kernel is running as a TDX guest, and see if that helps?

There's no need in Intel check this early. Only AMD need it. Maybe just
opencode them?

-- 
 Kirill A. Shutemov
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

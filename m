Return-Path: <SRS0=LkSb=OO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E51EC433F5
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 00:55:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EBE610FD
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 00:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86EBE610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E62460687;
	Fri, 24 Sep 2021 00:55:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MMye2bsmTmX3; Fri, 24 Sep 2021 00:55:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D6B5D6064B;
	Fri, 24 Sep 2021 00:55:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0B24C000F;
	Fri, 24 Sep 2021 00:55:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBBF2C000D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 00:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C3311414CB
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 00:55:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D-YD8yvhl53L for <iommu@lists.linux-foundation.org>;
 Fri, 24 Sep 2021 00:55:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 629CC414B9
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 00:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632444945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mg9KP+cx438j5wC5hpIXMnDuPlwL4JuEjwLmUyo/e+c=;
 b=c39OQulmV+/Q3fLMwPsiyH5bK7pPh4SCXMB5k4OiLGmeOrUJkEitw/l0TDsL39PfyJyPv2
 LN/stPWVo5i6xyuhjx8hcMhWT7iEiW/OIaSD8ObCbqk2NVjxRFeTiCkBI+4dcN8CIWpr/r
 a72o7kDiC+tvp810qyO7ia14mvr2mVE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-RUQctZLRN82EnXhNl1oIjw-1; Thu, 23 Sep 2021 20:55:44 -0400
X-MC-Unique: RUQctZLRN82EnXhNl1oIjw-1
Received: by mail-pf1-f200.google.com with SMTP id
 x29-20020aa7941d000000b0043c26e9eeddso5110949pfo.5
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Mg9KP+cx438j5wC5hpIXMnDuPlwL4JuEjwLmUyo/e+c=;
 b=zQLDrzXpaw4VUbowrVkNED3/U8O+PWG9AXswEzJ9ofTv5rB7wXUVPxZvJq1gbRujLh
 YMPt5+JAXlzvNpzhOwxI0XzV+ONTKCaUbledIgBbduLdpv1I1DzfWeLMGXxQa/2NWIep
 yilfU5Xa0jC1BuSEGQrXJMBwElbcmD2EBIPt5Xg4hEb+i21ezKWl3XTlhDqSEt84XxSf
 FH2ikFWwf/AWRKwLJLrXtxbpCDzJJ/HW6P/pYnN8GDH12pndKGVKUL3XkY9S28PuNfSR
 Lca1VuCVxVtQxv1+mb2yd5Q0Lz9gebbDf2fOAqB68KOIznzyoiFjC44kY5RX2fD8oKSm
 dpUw==
X-Gm-Message-State: AOAM532/cW0pI8DLLcesjjO4UI5dNhlalCOIIHqko8Wa5Xy/usTHnOZL
 rw+SqjWYWi8BBK4NCPJB6WOCJ3MouO4LVKVBDWTTgQMTiG0UTZB1g3HNsoqcPkWmT6qwIVJ0HAS
 +NKlgd2gs/vHixgk4gJcgjeV+VHkxDw==
X-Received: by 2002:a17:90a:cb84:: with SMTP id
 a4mr8794382pju.137.1632444943558; 
 Thu, 23 Sep 2021 17:55:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyW0w8hKU+ZiQxzdVApOFafHdkV0+crvkHEidtTlEIsVkstLZwGWrB5bzXHvaiYkJe4KeySrQ==
X-Received: by 2002:a17:90a:cb84:: with SMTP id
 a4mr8794357pju.137.1632444943271; 
 Thu, 23 Sep 2021 17:55:43 -0700 (PDT)
Received: from treble ([50.231.97.170])
 by smtp.gmail.com with ESMTPSA id b11sm7822920pge.57.2021.09.23.17.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Sep 2021 17:55:42 -0700 (PDT)
Date: Thu, 23 Sep 2021 17:55:40 -0700
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 7/8] tools/objtool: Check for use of the ENQCMD
 instruction in the kernel
Message-ID: <20210924005540.kunsfif7hdta6dlp@treble>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-8-fenghua.yu@intel.com>
 <20210922210343.GU4323@worktop.programming.kicks-ass.net>
 <YUu/6YPYwvaDwthy@otcwcpicx3.sc.intel.com>
 <YUwp7VkjApRQr/pb@hirez.programming.kicks-ass.net>
 <YUycliX+lPSMhWfR@otcwcpicx3.sc.intel.com>
MIME-Version: 1.0
In-Reply-To: <YUycliX+lPSMhWfR@otcwcpicx3.sc.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Thu, Sep 23, 2021 at 03:26:14PM +0000, Fenghua Yu wrote:
> > > +		} else if (op2 == 0x38 && op3 == 0xf8) {
> > > +			if (insn.prefixes.nbytes == 1 &&
> > > +			    insn.prefixes.bytes[0] == 0xf2) {
> > > +				/* ENQCMD cannot be used in the kernel. */
> > > +				WARN("ENQCMD instruction at %s:%lx", sec->name,
> > > +				     offset);
> > > +
> > > +				return -1;
> > > +			}
> > 
> > The only concern here is if we want it to be fatal or not. But otherwise
> > this seems to be all that's required.
> 
> objtool doesn't fail kernel build on this fatal warning.
> 
> Returning -1 here stops checking the rest of the file and won't report any
> further warnings unless this ENQCMD warning is fixed. Not returning -1
> continues checking the rest of the file and may report more warnings.
> Seems that's the only difference b/w them.
> 
> Should I keep this "return -1" or not? Please advice.

I'd say remove the "return -1" since it's not a fatal-type analysis
error and there's nothing to prevent objtool from analyzing the rest of
the file.

-- 
Josh

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

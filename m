Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3BFC282DF
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 19:52:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B0B2173C
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 19:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="aQd1aeO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B0B2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 22153C5C;
	Wed, 17 Apr 2019 19:52:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BADC3B4B
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 19:52:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
	[209.85.222.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2305887F
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 19:52:19 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id n68so15143119qka.1
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tycho-ws.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=Uru0Jbz4B8OYoAQYJt2C55pxQlJkGfm/+9nWfpEgZPQ=;
	b=aQd1aeO2CXg7gYGOcvtEUcXMyHfbY37wbHMchotalTNQZ2RxhJxZjLextp8ZWtQKA9
	ElDQno8BAegcG5tWka17SzrohZ4MVbbZKar4D1otZqJs6viRLbUgEjktrlyhXOKFoRRr
	Xqiz5AKyn2cqhIrRtLq2t6y4exSmyJWI+xolW690Pg05j5xcNprdRzKeq2BM/bBe7uD9
	Mna5BBYIALxIoHSfeGneAc4J6qlxgdl4umsVpI32Ws6NYWtDPh57d2uN8d9IDlmzf+34
	LgmN/QkDbE6mdN4NdIUb/v42FYkyBUW0DAfjxZ5Ti4wxRTTn11MCXXYyLy0I5wiy+cup
	dbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Uru0Jbz4B8OYoAQYJt2C55pxQlJkGfm/+9nWfpEgZPQ=;
	b=JvUYozUm0zIyyZMN8bhapTVb+sxfWFyaf+g6v8UB+QtRUiuRhq1rGwTW9q9TXs+Bug
	CxSe/UNh7pcwOT7kB7mOZcVJbc2jfQgfYxfVoDAh6rQ97Um+YwR5GtCd8m9hbe+Wj/hG
	XqjwIHBxOs/DrYHbGXL1R6ZZ7COePf2lS8o+A/FZIOX6l5oApbXa1jR9yXyWtoOzRKMG
	nMxoMuliarLqk8YQBAS4h6AibyhVybV/n9KF/yF8oyX1rVKNEUvEKz9P4A1Wdm87wBFR
	HTfI51H0NGI57fVriXWcJvn/aBf5L4ojg4qxRP5LsIE5Fn1bA7cd2R2bxP6qIWy7fHJ0
	7YJw==
X-Gm-Message-State: APjAAAUEkYWPCgwDYNi25NBzUhUoPf07eiQAmOgBxua8K+5I9e+o2/Vg
	Qy6trWQNJjeSkOx3PXOWswtsuA==
X-Google-Smtp-Source: APXvYqxALLwioQYr156hXrQYUcVxn+eWorINAhsmvLl+aLFkTmy03SLo3tuclnCeyTO/WqSU4/UWYQ==
X-Received: by 2002:ae9:e64d:: with SMTP id x13mr70666110qkl.112.1555530737946;
	Wed, 17 Apr 2019 12:52:17 -0700 (PDT)
Received: from cisco ([2601:282:901:dd7b:7136:cebf:c0d3:8091])
	by smtp.gmail.com with ESMTPSA id
	v30sm28498609qta.4.2019.04.17.12.52.15
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 17 Apr 2019 12:52:17 -0700 (PDT)
Date: Wed, 17 Apr 2019 13:52:13 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
Message-ID: <20190417195213.GE3758@cisco>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
	<20190417161042.GA43453@gmail.com>
	<e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
	<20190417170918.GA68678@gmail.com>
	<8d314750-251c-7e6a-7002-5df2462ada6b@oracle.com>
	<CALCETrXFzWFMrV-zDa4QFjB=4WnC9RZmorBko65dLGhymDpeQw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCETrXFzWFMrV-zDa4QFjB=4WnC9RZmorBko65dLGhymDpeQw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Dave Hansen <dave@sr71.net>, Thomas Gleixner <tglx@linutronix.de>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Khalid Aziz <khalid.aziz@oracle.com>,
	deepa.srinivasan@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
	iommu@lists.linux-foundation.org, jsteckli@amazon.de,
	Arjan van de Ven <arjan@infradead.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jon Masters <jcm@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	chris hyser <chris.hyser@oracle.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Khalid Aziz <khalid@gonehiking.org>, Juerg Haefliger <juergh@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	LKML <linux-kernel@vger.kernel.org>, Tyler Hicks <tyhicks@canonical.com>,
	LSM List <linux-security-module@vger.kernel.org>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Kees Cook <keescook@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, "Woodhouse,
	David" <dwmw@amazon.co.uk>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190417195213.kS4aGmQPqDDgW179Ub10zgQlkE3rLsrxSA0GfQM5Gi8@z>

On Wed, Apr 17, 2019 at 12:49:04PM -0700, Andy Lutomirski wrote:
> I also proposed using a gcc plugin (or upstream gcc feature) to add
> some instrumentation to any code that pops RSP to verify that the
> resulting (unsigned) change in RSP is between 0 and THREAD_SIZE bytes.
> This will make ROP quite a bit harder.

I've been playing around with this for a bit, and hope to have
something to post Soon :)

Tycho
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

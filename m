Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51776C282DC
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 16:15:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8602173C
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 16:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyS/WVic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8602173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DF62C1170;
	Wed, 17 Apr 2019 16:15:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9FD3B116D
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 16:15:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1C28886F
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 16:15:28 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id s15so32682051wra.12
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=2E2gGWXwlEXHD0EdhjliuzLa0L4LUy3dnmNjJuBPY1M=;
	b=nyS/WViclzZJjR30HVMMB/ma7fcLYSTWP9QxF2Fshf4EJq6uRarq3jSaxiVNfV92fh
	zEZfmA69o8F7gNO5JT6uv0zE0OJeE7BWbIRv09fAQTN2l+N2dnFwJ9Lfuiiy6+74FoDp
	uGRo9f5/Goa9H9R9Ca2oLvyjv31O0I5e5WLdLO3tmvoyjg1wNvw+8b2zxVEfd9gJSTwJ
	+SSg2n/omewPli8xLPnvSElOhwgHU9I/P33Tw7RfhZ2LRLr+x5PTn04fXGfMHG1ZHR4/
	XB7f4UjQbIdtenugCUJSD8W8ywk7H6JVByBN8MjE8ZURVuqLb51s1gVwQaBsfh/AY/u/
	6ICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=2E2gGWXwlEXHD0EdhjliuzLa0L4LUy3dnmNjJuBPY1M=;
	b=R3VJNRZZhZfmPskbYEb7altITSnQ/NMCiNjOePzFCbljKRH+FCbhRQJbWTv6bzDbsn
	6tQiOziAoHejdk/D4j+5FfS0X9ifiA1XgJ8YSKNX+7fDGdEymU4XIC99EcWPcd33PPZE
	wrAFrgwmjvISfG8XsyeBivJlDDSBSsisiUxgOXeD7+p5xo605qPlvg74YzxYZuLLNtHs
	WWlwvMc+bE0KuDOGR+g758Ismt9VQQRp50lg0+dUSMxBe6Lxax6e4i05AtkLqpotoVn9
	1sWck/Z9T2LVQ1bhMdBJ9tb7lp2YGXn/QAssmzS7Mma3wjt63zLrSnHOOxbgornrMLr1
	+2Zg==
X-Gm-Message-State: APjAAAVXlVGXNBsT6FEizNiemIeoxicPncztZC3vyr67UaNNUQDSYWkS
	sb320Hw58akxu/1vBymfayw=
X-Google-Smtp-Source: APXvYqy35ID2kalnRZopmGnEWCBLThqKczYiLY/rC35gAIxUEa+THgEb4y2voVmHavCnFbNEpnRFQQ==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr59140093wrj.249.1555517726742;
	Wed, 17 Apr 2019 09:15:26 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
	by smtp.gmail.com with ESMTPSA id
	y1sm154976060wrd.34.2019.04.17.09.15.24
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 17 Apr 2019 09:15:25 -0700 (PDT)
Date: Wed, 17 Apr 2019 18:15:22 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
Message-ID: <20190417161042.GA43453@gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Dave Hansen <dave@sr71.net>, linux-doc@vger.kernel.org, linux-mm@kvack.org,
	deepa.srinivasan@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>, tycho@tycho.ws,
	x86@kernel.org, iommu@lists.linux-foundation.org,
	jsteckli@amazon.de, Arjan van de Ven <arjan@infradead.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, konrad.wilk@oracle.com,
	jcm@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>, boris.ostrovsky@oracle.com,
	chris.hyser@oracle.com, linux-arm-kernel@lists.infradead.org,
	Khalid Aziz <khalid@gonehiking.org>, juergh@gmail.com,
	andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
	tyhicks@canonical.com, linux-security-module@vger.kernel.org,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	keescook@google.com, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, dwmw@amazon.co.uk
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
Message-ID: <20190417161522.2Bq_dIpLgstghE0Xrp8uniKQSAqVrBiOdMdClQVh0kc@z>


[ Sorry, had to trim the Cc: list from hell. Tried to keep all the 
  mailing lists and all x86 developers. ]

* Khalid Aziz <khalid.aziz@oracle.com> wrote:

> From: Juerg Haefliger <juerg.haefliger@canonical.com>
> 
> This patch adds basic support infrastructure for XPFO which protects 
> against 'ret2dir' kernel attacks. The basic idea is to enforce 
> exclusive ownership of page frames by either the kernel or userspace, 
> unless explicitly requested by the kernel. Whenever a page destined for 
> userspace is allocated, it is unmapped from physmap (the kernel's page 
> table). When such a page is reclaimed from userspace, it is mapped back 
> to physmap. Individual architectures can enable full XPFO support using 
> this infrastructure by supplying architecture specific pieces.

I have a higher level, meta question:

Is there any updated analysis outlining why this XPFO overhead would be 
required on x86-64 kernels running on SMAP/SMEP CPUs which should be all 
recent Intel and AMD CPUs, and with kernel that mark all direct kernel 
mappings as non-executable - which should be all reasonably modern 
kernels later than v4.0 or so?

I.e. the original motivation of the XPFO patches was to prevent execution 
of direct kernel mappings. Is this motivation still present if those 
mappings are non-executable?

(Sorry if this has been asked and answered in previous discussions.)

Thanks,

	Ingo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B2BC282DA
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 17:09:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BE62173C
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 17:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQKDMpKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BE62173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BA590B7D;
	Wed, 17 Apr 2019 17:09:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6E0D2B4B
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 17:09:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DED2C881
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 17:09:23 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id j9so32911758wrn.6
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=uI0ONQRkWQ/et5lZr2E50Xppi+adE17aj2er9uc38Ro=;
	b=vQKDMpKZs+jpCV0AtFjtb+IzANhqz3dew5Sd4gG7ITDXSrt8OYeyxzo5885noBmd/k
	M7Y511AnmRuFNpPrRUcL0fx4VCDHC5HbpoQL157ReLzEY+ATmvDFca5O27ddKmW8+E5U
	SWwgB4fqBVviw9oEx6R3qe3lIZgRJYJXc6M3U+vQZTc8SCcbn5I1BqHYSYodcHy/K7y2
	owHfWC5l9Z1dd3sc9ZHcDGWk/J7z+eM+/y7DQCfdM2D1aY4WwXTWnRz28CERITWBN3RI
	OdgGC3tyQYESSIRNzNO6ctsaUz9bT+jioxPBGx1xhp3GL49llo+vdJv4lTzb9yvWN35X
	0F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=uI0ONQRkWQ/et5lZr2E50Xppi+adE17aj2er9uc38Ro=;
	b=n+Qg8UtDoE0V9DEMpyOfJOACKFUtNzqZJPsxF+Dh9ESD4dUy0/ESxfJSaVktEtAwko
	RAs/o70DFXO92IZOS/g1rsRi5RoPCYCQfMnpiLz5WC8GeJiFrXW98Ra7TWSs9jlX6Uzr
	0AZlUsDwILe6H9XEdHFdVHYCzWo5hdE3hQfyKmbwLHXHLnig4B3IFFGjy8aFDwHuopty
	ugTpKunyL/ysKyWcfPqjqG8f4xmR+FCvvtgTAANgRGIPJIMc1ihG1qSSFO9VpfkeKqdp
	BmdG6Toc8THHEE5T0T+rhzbBYzrHY1xW+bzMTNeECiLtZwSUyExyP2toJXUJ5SsMBefP
	1MhA==
X-Gm-Message-State: APjAAAWI+20dnBTcws3D8DB4B8bbTNaIUIwdy9LDCv1O2G3tNsAybc2L
	RsDgOMEMzzDHdtrF52m6mlM=
X-Google-Smtp-Source: APXvYqwzLRhrBX+v0nCWIiRZo+Ww+BhgVCQVN/Z3qzTyGEskFIzDNjOb+l7u4co7KExCIwSw9l38CA==
X-Received: by 2002:adf:f8d0:: with SMTP id f16mr2701431wrq.198.1555520962630; 
	Wed, 17 Apr 2019 10:09:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
	by smtp.gmail.com with ESMTPSA id 67sm2676425wmz.41.2019.04.17.10.09.19
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 17 Apr 2019 10:09:21 -0700 (PDT)
Date: Wed, 17 Apr 2019 19:09:18 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
Message-ID: <20190417170918.GA68678@gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
	<20190417161042.GA43453@gmail.com>
	<e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
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
Message-ID: <20190417170918.n-BEuwFMsMdJHAxWVrJ2e2ORc2EE1Qv5PJrK67ypnIM@z>


* Khalid Aziz <khalid.aziz@oracle.com> wrote:

> > I.e. the original motivation of the XPFO patches was to prevent execution 
> > of direct kernel mappings. Is this motivation still present if those 
> > mappings are non-executable?
> > 
> > (Sorry if this has been asked and answered in previous discussions.)
> 
> Hi Ingo,
> 
> That is a good question. Because of the cost of XPFO, we have to be very
> sure we need this protection. The paper from Vasileios, Michalis and
> Angelos - <http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf>,
> does go into how ret2dir attacks can bypass SMAP/SMEP in sections 6.1
> and 6.2.

So it would be nice if you could generally summarize external arguments 
when defending a patchset, instead of me having to dig through a PDF 
which not only causes me to spend time that you probably already spent 
reading that PDF, but I might also interpret it incorrectly. ;-)

The PDF you cited says this:

  "Unfortunately, as shown in Table 1, the W^X prop-erty is not enforced 
   in many platforms, including x86-64.  In our example, the content of 
   user address 0xBEEF000 is also accessible through kernel address 
   0xFFFF87FF9F080000 as plain, executable code."

Is this actually true of modern x86-64 kernels? We've locked down W^X 
protections in general.

I.e. this conclusion:

  "Therefore, by simply overwriting kfptr with 0xFFFF87FF9F080000 and 
   triggering the kernel to dereference it, an attacker can directly 
   execute shell code with kernel privileges."

... appears to be predicated on imperfect W^X protections on the x86-64 
kernel.

Do such holes exist on the latest x86-64 kernel? If yes, is there a 
reason to believe that these W^X holes cannot be fixed, or that any fix 
would be more expensive than XPFO?

Thanks,

	Ingo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

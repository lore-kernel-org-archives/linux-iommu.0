Return-Path: <SRS0=hyWy=5E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E7CC41620
	for <iommu@archiver.kernel.org>; Thu, 19 Mar 2020 17:42:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB12E20836
	for <iommu@archiver.kernel.org>; Thu, 19 Mar 2020 17:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BstyM5Fy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB12E20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 91E4788457;
	Thu, 19 Mar 2020 17:42:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9nmDZ-d4Ln-L; Thu, 19 Mar 2020 17:42:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D86E988263;
	Thu, 19 Mar 2020 17:42:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE418C18DA;
	Thu, 19 Mar 2020 17:42:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89F36C07FF
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 17:42:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 72B6987F6F
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 17:42:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BgA6wmD2CGVh for <iommu@lists.linux-foundation.org>;
 Thu, 19 Mar 2020 17:42:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 472E987EF0
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 17:42:51 +0000 (UTC)
Received: from zn.tnic (p200300EC2F0A85008DCA7A58643289AE.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0a:8500:8dca:7a58:6432:89ae])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F6271EC0CFA;
 Thu, 19 Mar 2020 18:42:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1584639768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=LJgEl6+GWpjWMprHgQdpvOsZPmZ9T4AgJaJ310Sp15A=;
 b=BstyM5FyzXd4gUjzYEKas19giaR3PryEQgqFuimsLBfSog5uMwWV2b0pL/Te/PSiFpUTow
 +JfuNn7O4THbFfI6nYX7gKJnJsqRVfieDh1pygDl8Ash+cUnvz3cwuI8wH5wfd5vmjqxSm
 qSP7WorzYL+KIIwiwVuKclKRo0SUmHk=
Date: Thu, 19 Mar 2020 18:42:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -v2] treewide: Rename "unencrypted" to "decrypted"
Message-ID: <20200319174254.GE13073@zn.tnic>
References: <20200317111822.GA15609@zn.tnic> <20200319101657.GB13073@zn.tnic>
 <20200319102011.GA3617@lst.de> <20200319102834.GC13073@zn.tnic>
 <8d6d3b6c-7e4e-7d9e-3e19-38f7d4477c72@arm.com>
 <20200319112054.GD13073@zn.tnic>
 <878sjw5k9u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878sjw5k9u.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-s390@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Vasily Gorbik <gor@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 lkml <linux-kernel@vger.kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Andy Lutomirski <luto@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Thu, Mar 19, 2020 at 06:25:49PM +0100, Thomas Gleixner wrote:
> TBH, I don't see how
> 
> 	if (force_dma_decrypted(dev))
> 		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
>
> makes more sense than the above. It's both non-sensical unless there is

9087c37584fb ("dma-direct: Force unencrypted DMA under SME for certain DMA masks")

> a big fat comment explaining what this is about.

ACK to that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

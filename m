Return-Path: <SRS0=lDAf=5C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4000AC5ACD7
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 21:06:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B8B2051A
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 21:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="A1+8yNm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B8B2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8C33E88770;
	Tue, 17 Mar 2020 21:06:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H6orp4PjilWN; Tue, 17 Mar 2020 21:06:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9143D8874A;
	Tue, 17 Mar 2020 21:06:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79491C18DA;
	Tue, 17 Mar 2020 21:06:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22AACC013E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 21:06:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1054B88882
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 21:06:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y+X3t0mCgoQe for <iommu@lists.linux-foundation.org>;
 Tue, 17 Mar 2020 21:06:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B86118887F
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 21:06:01 +0000 (UTC)
Received: from zn.tnic (p200300EC2F0C960029779DE4AAC583E4.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0c:9600:2977:9de4:aac5:83e4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 15F2D1EC0BFD;
 Tue, 17 Mar 2020 22:05:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1584479158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=HFR+t8qs+BETW/cIOn04p67zo0Dmc/q+y8ZzD5mYjgU=;
 b=A1+8yNm1sVm9L2XdYDq9Jn9i3fFQiAY+YK18Dd3iHshwbAShdu/tGs0xXWZNWZ4toGozad
 WRDRFAIPfqS7qTVWEWkoeWh8j7BphzvIGaZ0eWhpSnaSeeyB5oCxzdp9v3VCs7feFCMwzm
 4txEsQKLkI1UDSFIlhaJHoqHMbyNKbI=
Date: Tue, 17 Mar 2020 22:06:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] treewide: Rename "unencrypted" to "decrypted"
Message-ID: <20200317210602.GG15609@zn.tnic>
References: <20200317111822.GA15609@zn.tnic>
 <2cb4a8ae-3b13-67bd-c021-aee47fdf58c5@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2cb4a8ae-3b13-67bd-c021-aee47fdf58c5@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Schofield, Alison" <alison.schofield@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
 Vasily Gorbik <gor@linux.ibm.com>, "Shutemov,
 Kirill" <kirill.shutemov@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Robin Murphy <robin.murphy@arm.com>,
 lkml <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
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

On Tue, Mar 17, 2020 at 01:35:12PM -0700, Dave Hansen wrote:
> On 3/17/20 4:18 AM, Borislav Petkov wrote:
> > Back then when the whole SME machinery started getting mainlined, it
> > was agreed that for simplicity, clarity and sanity's sake, the terms
> > denoting encrypted and not-encrypted memory should be "encrypted" and
> > "decrypted". And the majority of the code sticks to that convention
> > except those two. So rename them.
> 
> Don't "unencrypted" and "decrypted" mean different things?
> 
> Unencrypted to me means "encryption was never used for this data".
> 
> Decrypted means "this was/is encrypted but here is a plaintext copy".

Maybe but linguistical semantics is not the point here.

The idea is to represent a "binary" concept of memory being encrypted
or memory being not encrypted. And at the time we decided to use
"encrypted" and "decrypted" for those two things.

Do you see the need to differentiate a third "state", so to speak, of
memory which was never encrypted?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=lDAf=5C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B543BC2BB1D
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 22:01:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D0320714
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 22:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D0320714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5258F8831B;
	Tue, 17 Mar 2020 22:01:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cBf19fJcJE9Y; Tue, 17 Mar 2020 22:01:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2552288318;
	Tue, 17 Mar 2020 22:01:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B573C1D74;
	Tue, 17 Mar 2020 22:01:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 651D9C013E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 22:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5AC6887591
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 22:01:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UeWP8VxNZ4PJ for <iommu@lists.linux-foundation.org>;
 Tue, 17 Mar 2020 22:01:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C31278758A
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 22:01:40 +0000 (UTC)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11]
 helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1jEKGu-0000tj-1m; Tue, 17 Mar 2020 23:01:12 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
 id 71BBA101161; Tue, 17 Mar 2020 23:01:11 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] treewide: Rename "unencrypted" to "decrypted"
In-Reply-To: <20200317210602.GG15609@zn.tnic>
References: <20200317111822.GA15609@zn.tnic>
 <2cb4a8ae-3b13-67bd-c021-aee47fdf58c5@intel.com>
 <20200317210602.GG15609@zn.tnic>
Date: Tue, 17 Mar 2020 23:01:11 +0100
Message-ID: <87fte6bpzs.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
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
 Robin Murphy <robin.murphy@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
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

Borislav Petkov <bp@alien8.de> writes:

> On Tue, Mar 17, 2020 at 01:35:12PM -0700, Dave Hansen wrote:
>> On 3/17/20 4:18 AM, Borislav Petkov wrote:
>> > Back then when the whole SME machinery started getting mainlined, it
>> > was agreed that for simplicity, clarity and sanity's sake, the terms
>> > denoting encrypted and not-encrypted memory should be "encrypted" and
>> > "decrypted". And the majority of the code sticks to that convention
>> > except those two. So rename them.
>> 
>> Don't "unencrypted" and "decrypted" mean different things?
>> 
>> Unencrypted to me means "encryption was never used for this data".
>> 
>> Decrypted means "this was/is encrypted but here is a plaintext copy".
>
> Maybe but linguistical semantics is not the point here.
>
> The idea is to represent a "binary" concept of memory being encrypted
> or memory being not encrypted. And at the time we decided to use
> "encrypted" and "decrypted" for those two things.
>
> Do you see the need to differentiate a third "state", so to speak, of
> memory which was never encrypted?

I think so.

encrypted data is something you can't use without having the key

decrypted data is the plaintext copy of something encrypted, so
it might be of sensible nature.

unencrypted data can still be sensible, but nothing ever bothered to
encrypt it in the first place.

So having this distinction is useful in terms of setting the context
straight.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

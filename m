Return-Path: <SRS0=lDAf=5C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646ABC1975A
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 21:55:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2566320738
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 21:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2566320738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E784587470;
	Tue, 17 Mar 2020 21:55:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BoY5-QuI58SB; Tue, 17 Mar 2020 21:55:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5EE5D87061;
	Tue, 17 Mar 2020 21:55:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38B1CC1D74;
	Tue, 17 Mar 2020 21:55:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1240FC013E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 21:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F303B87434
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 21:55:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JOCpJMK-eEpX for <iommu@lists.linux-foundation.org>;
 Tue, 17 Mar 2020 21:55:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from smtprelay.hostedemail.com (smtprelay0192.hostedemail.com
 [216.40.44.192])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2CD6387061
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 21:55:45 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 4D0AB180300D3
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 21:36:24 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay02.hostedemail.com (Postfix) with ESMTP id 0B53645A8;
 Tue, 17 Mar 2020 21:36:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tax31_8e64a60b0ff18
X-Filterd-Recvd-Size: 3175
Received: from XPS-9350.home (unknown [47.151.143.254])
 (Authenticated sender: joe@perches.com)
 by omf13.hostedemail.com (Postfix) with ESMTPA;
 Tue, 17 Mar 2020 21:36:18 +0000 (UTC)
Message-ID: <1e52a8441a319e55b913376ad47c6b18843742cd.camel@perches.com>
Subject: Re: [PATCH] treewide: Rename "unencrypted" to "decrypted"
From: Joe Perches <joe@perches.com>
To: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Date: Tue, 17 Mar 2020 14:34:30 -0700
In-Reply-To: <f3e520c6-f455-9c82-abfc-d014ca63eeb5@intel.com>
References: <20200317111822.GA15609@zn.tnic>
 <2cb4a8ae-3b13-67bd-c021-aee47fdf58c5@intel.com>
 <20200317210602.GG15609@zn.tnic>
 <f3e520c6-f455-9c82-abfc-d014ca63eeb5@intel.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
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

On Tue, 2020-03-17 at 14:24 -0700, Dave Hansen wrote:
> On 3/17/20 2:06 PM, Borislav Petkov wrote:
> > On Tue, Mar 17, 2020 at 01:35:12PM -0700, Dave Hansen wrote:
> > > On 3/17/20 4:18 AM, Borislav Petkov wrote:
> > > > Back then when the whole SME machinery started getting mainlined, it
> > > > was agreed that for simplicity, clarity and sanity's sake, the terms
> > > > denoting encrypted and not-encrypted memory should be "encrypted" and
> > > > "decrypted". And the majority of the code sticks to that convention
> > > > except those two. So rename them.
> > > Don't "unencrypted" and "decrypted" mean different things?
> > > 
> > > Unencrypted to me means "encryption was never used for this data".
> > > 
> > > Decrypted means "this was/is encrypted but here is a plaintext copy".
> > Maybe but linguistical semantics is not the point here.
> > 
> > The idea is to represent a "binary" concept of memory being encrypted
> > or memory being not encrypted. And at the time we decided to use
> > "encrypted" and "decrypted" for those two things.
> 
> Yeah, agreed.  We're basically trying to name "!encrypted".
> 
> > Do you see the need to differentiate a third "state", so to speak, of
> > memory which was never encrypted?
> 
> No, there are just two states.  I just think the "!encrypted" case
> should not be called "decrypted".

Nor do I, it's completely misleading.


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

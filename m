Return-Path: <SRS0=hyWy=5E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5511C4332B
	for <iommu@archiver.kernel.org>; Thu, 19 Mar 2020 11:06:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942EB206D7
	for <iommu@archiver.kernel.org>; Thu, 19 Mar 2020 11:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942EB206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 638BB87DB3;
	Thu, 19 Mar 2020 11:06:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tHfxoA2w6zow; Thu, 19 Mar 2020 11:06:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A00D087DBA;
	Thu, 19 Mar 2020 11:06:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D763C18DA;
	Thu, 19 Mar 2020 11:06:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3645C07FF
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 11:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A1E9A86BCB
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 11:06:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wxCwgNqnQG7y for <iommu@lists.linux-foundation.org>;
 Thu, 19 Mar 2020 11:06:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 092C986BBC
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 11:06:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4BB731B;
 Thu, 19 Mar 2020 04:06:31 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2A993F305;
 Thu, 19 Mar 2020 04:06:25 -0700 (PDT)
Subject: Re: [PATCH -v2] treewide: Rename "unencrypted" to "decrypted"
To: Borislav Petkov <bp@alien8.de>, Christoph Hellwig <hch@lst.de>
References: <20200317111822.GA15609@zn.tnic> <20200319101657.GB13073@zn.tnic>
 <20200319102011.GA3617@lst.de> <20200319102834.GC13073@zn.tnic>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8d6d3b6c-7e4e-7d9e-3e19-38f7d4477c72@arm.com>
Date: Thu, 19 Mar 2020 11:06:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319102834.GC13073@zn.tnic>
Content-Language: en-GB
Cc: linux-s390@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 lkml <linux-kernel@vger.kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Andy Lutomirski <luto@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

[since this is in my inbox...]

On 2020-03-19 10:28 am, Borislav Petkov wrote:
> On Thu, Mar 19, 2020 at 11:20:11AM +0100, Christoph Hellwig wrote:
>> I thought we agreed that decrypted is absolutely the wrong term.
> 
> I don't think we did. At least I don't know where we did that.
> 
>> So NAK - if you want to change things it needs to go the other way.
> 
> We are already using "decrypted" everywhere in arch/x86/. Changing that
> would be a *lot* more churn.
> 
> And it is just a term, for chrissakes, to denote memory which is not
> encrypted. And it would make our lifes easier if we had only *two* terms
> instead of three or more. Especially if the concept we denote with this
> is a binary one: encrypted memory and *not* encrypted memory.

Let me add another vote from a native English speaker that "unencrypted" 
is the appropriate term to imply the *absence* of encryption, whereas 
"decrypted" implies the *reversal* of applied encryption.

Naming things is famously hard, for good reason - names are *important* 
for understanding. Just because a decision was already made one way 
doesn't mean that that decision was necessarily right. Churning one area 
to be consistently inaccurate just because it's less work than churning 
another area to be consistently accurate isn't really the best excuse.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

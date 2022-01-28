Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448A5C433F5
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 14:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD47960BED;
	Fri, 28 Jan 2022 14:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lwz4PM0LxhFT; Fri, 28 Jan 2022 14:53:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C40F760BE7;
	Fri, 28 Jan 2022 14:53:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98971C001A;
	Fri, 28 Jan 2022 14:53:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E10F2C000B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 14:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8C5760BEA
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 14:53:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WUqvvhSbs2Eb for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 14:53:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EB88760BE7
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 14:53:46 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1643381623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C5w2S5ndYwVItVkiDPg/uT/UFko3VOhpELYHRGKacXU=;
 b=LFOjhaqC5qvgSmaAH2KNicSXyl3qeriZ/Gj0IQOoWMWNe4v28oznoIF43IiHE0hhxjd4pf
 Dp0SDui1xtKckdpveuc/8T8ybHkXnLDZIR6DFQW0s/b1vSLKuIJ9kSTqQ8TBY23jW6LVGt
 DHUEPv55YkuVVdstdaDU13BUaeb1itS4WUj2Pr0XQ3D7Q0wvLxjguI6VYi3F/x4LOvLDYt
 PF4VvIMrXt0sTvyMKURsjt1wlCvm1vmU4AzRXd45wcmaDcjKm7Ce/ZtjpHCHu7Ph9IaiFp
 h+393lQsyi1qViC4Ll9U2p27LHRbZIm3h9sWyqdC9ACvINqSuQdlxLIx/4AluA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1643381623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C5w2S5ndYwVItVkiDPg/uT/UFko3VOhpELYHRGKacXU=;
 b=r7H3xY7nCZjmcsVrwvUy6GaO5T8z2QBOTJ/TnVehHwHwFxDF2NmH291HC3ZYSLHtC8DAvx
 AgDGj7XNHAFaklBA==
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v2 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <YfNVBzN67rSu/QcE@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com> <87ee4w6g1n.ffs@tglx>
 <87bl006fdb.ffs@tglx> <Ye8RmmKpJT8brmDE@otcwcpicx3.sc.intel.com>
 <878rv46eg3.ffs@tglx> <YfAUutQhqS6ejUFU@otcwcpicx3.sc.intel.com>
 <87k0em4lu9.ffs@tglx> <YfGGk7kWNc9q2YwV@otcwcpicx3.sc.intel.com>
 <8735la41qb.ffs@tglx> <YfNVBzN67rSu/QcE@otcwcpicx3.sc.intel.com>
Date: Fri, 28 Jan 2022 15:53:42 +0100
Message-ID: <87zgnf29op.ffs@tglx>
MIME-Version: 1.0
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>
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

On Thu, Jan 27 2022 at 18:42, Fenghua Yu wrote:
> On Wed, Jan 26, 2022 at 10:38:04PM +0100, Thomas Gleixner wrote:
>> Against Linus tree please so that the bugfix applies.
>> 
>> > I will fold the following patch into patch #5. The patch #11 (the doc patch)
>> > also needs to remove one paragraph talking about refcount.
>> >
>> > So I will send the whole patch set with the following changes:
>> > 1. One new bug fix patch (the above patch)
>
> When I study your above aux_domain bug fix path, I find more aux_domain bugs.
> But then I find aux_domain will be completely removed because all aux_domain
> related callbacks are not called and are dead code (no wonder there are
> so many bugs in aux_domain). Please see this series: https://lore.kernel.org/linux-iommu/20220124071103.2097118-4-baolu.lu@linux.intel.com/
> For the series, Baolu confirms that he is "pretty sure that should be part
> of v5.18". And I don't find the series calls any IOASID function after
> removing the aux_domain code.
>
> So that means we don't need to fix those issues in the dead aux_domain
> code any more because it will be completely removed in 5.18, right?
>
> If you agree, I will not include the aux_domain fix patch or any other
> aux_domain fix patches in the up-coming v3. Is that OK?

Fair enough.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=LkSb=OO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17C0C433F5
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 05:17:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FD36124B
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 05:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97FD36124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5F019401B5;
	Fri, 24 Sep 2021 05:17:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M-Vk0EoXCEXU; Fri, 24 Sep 2021 05:17:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F0BCA400AE;
	Fri, 24 Sep 2021 05:17:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C71A7C000F;
	Fri, 24 Sep 2021 05:17:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E552C000D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 05:17:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DAB7401B4
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 05:17:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W76_prGzAZhZ for <iommu@lists.linux-foundation.org>;
 Fri, 24 Sep 2021 05:17:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4B7AC400AE
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 05:17:52 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAA8560F48;
 Fri, 24 Sep 2021 05:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632460671;
 bh=tvCB6RLTO5rkE1YjhCUTQS2MyJ9piwRTGK5ekwmWQdw=;
 h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
 b=RG/u/IDBnFKjY56AS+uzlhpN+g7UNrU4Di1c/FYPOnWkJqUU1yCyGOJ8n4tp9NHVX
 cGXraKC+y8BPHM2DX5ELnuCrH+f1XvCLuiVXbxrgrfPH47P2LMsEMV4anztf0yJ32Y
 6qWHuApReUlfpabkW/UJjTIkJiPjb60Z2V1Xnx+VLw5KTIqJMY3wm7syzqUsbY3+gv
 wg47gnN6l3D8ayjXYGkxn2smN4vu8c4mBAz1TddaXUB+DVe3apPP+t4rAt5ryb4WIu
 KK0wilZvNTd+kf6yptwjz/4R1XsNdPuwH/0VIwUWGNAdjns8KtxlgFsv8W8QGOpZ4d
 R45jV2mLEaQQQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailauth.nyi.internal (Postfix) with ESMTP id C893A27C0054;
 Fri, 24 Sep 2021 01:17:49 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
 by compute6.internal (MEProxy); Fri, 24 Sep 2021 01:17:49 -0400
X-ME-Sender: <xms:fF9NYfwxrhwBtfXnnlK22-hUAElwKHF800LKUsSlR7q6CGoxEGGloA>
 <xme:fF9NYXTMWZuGWYr6H3FcwoKoDQ2R1HKCIbl1yZ15IX6NADhXPtxD6rS6LuTOty9O9
 fQ9ok2yhaXeoyMlCLI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejtddgleduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
 hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
 frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
 fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
 ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
 drlhhuthhordhush
X-ME-Proxy: <xmx:fF9NYZWdPN2tSyvM04Il7A7PigpnsPJqlryyOkTijOdS6JmASGA5kg>
 <xmx:fF9NYZhiomge_BD3jZQiGbpLV4qKnoIYmQ0Rn-t5boj3eGW1SODMMg>
 <xmx:fF9NYRBPHGKR4yOwDUYD4Fj0epsjuDjU83VWLyVbX6im72FBLprPdw>
 <xmx:fV9NYZagWap2jiBTVzx-5mzQ3NGy9BrXzilyXPqQodigppw3-GLm7w9wyNQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id ACE6121E0063; Fri, 24 Sep 2021 01:17:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <bdb8246a-e157-4ceb-a410-90eebd4043e7@www.fastmail.com>
In-Reply-To: <YU0MO/WJO4rkcl0c@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
 <d5f00e34-f9fc-4421-8571-48c45237141c@www.fastmail.com>
 <YU0MO/WJO4rkcl0c@agluck-desk2.amr.corp.intel.com>
Date: Thu, 23 Sep 2021 22:17:25 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Tony Luck" <tony.luck@intel.com>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Cc: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
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



On Thu, Sep 23, 2021, at 4:22 PM, Luck, Tony wrote:
> On Thu, Sep 23, 2021 at 04:09:18PM -0700, Andy Lutomirski wrote:
>> On Mon, Sep 20, 2021, at 12:23 PM, Fenghua Yu wrote:
>
>> I think this is unnecessarily complicated because it's buying in to the
>> existing ISA misconception that PASID has anything to do with a task.
>> A PASID belongs to an mm, full stop.  Now the ISA is nasty and we have
>> tasks that have *noticed* that their mm has a PASID and tasks that have
>> not noticed this fact, but that should be irrelevant to essentially
>> everything except the fault handler.
>> 
>> So just refcount the thing the obvious way: take a reference when you
>> stick the PASID in the mm_struct and drop the reference in __mmdrop().
>> Problem solved.  You could probably drop it more aggressively in
>> __mmput(), and the comment explaining why is left as an exercise to the
>> reader -- if a kernel thread starts doing ENQCMD, we have worse things
>> to worry about :)
>
> That doesn't match well with the non-x86 usage of PASIDs. The code there
> bumps the reference count on each device bind, and decrements on each
> device unbind.

Can you elaborate on how that works?  Is there an architecture where there is a bona fide per task PASID?

>
> If we don't keep a reference count for each task that has IA32_PASID
> set up we could have this sequence
>
> 1) Process binds to a PASID capable device

Okay, so the mm has that PASID set up and a reference is taken.

> 2) Task uses ENQCMD, so PASID MSR is set up.

Yep.

> 3) Process unbinds the device, reference count on PASID
>    goes to zero. PASID is freed. PASID is reallocated to
>    another task.

It had better not.  We had an entire phone call in which we agreed that the entire lazy-MSR-setup approach only makes any sense if everyone pinky swears that an mm will *never* change its PASID once it has a PASID.

> 4) Task from step #2 uses ENQCMD to submit a descriptor
>    and device now processes virtual addresses based on mappings
>    in the new task.
>
> Now you might say that at step 3 we need to hunt down all the
> tasks that have PASID enabled and disabled ... but that's the
> same painful code that we avoided when we said that we would
> not make Linux hand out a PASID to all existing tasks in a
> process on the first bind operation.
>

Exactly.  Which means that the mm ought to pin that PASID for as long as it exists.  What am I missing?

Sure, one can invent a situation in which you start two threads, and one of those threads binds a device, does ENQCMD, unbinds the device, and exits.  Then the other thread *in the same mm* binds another device and gets a new PASID.  And it all works.  But I really don't think this special case is worth optimizing for.

> -Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

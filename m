Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A71C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 23:09:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF226128B
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 23:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FF226128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6351640025;
	Thu, 23 Sep 2021 23:09:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m0bYpbxRKqJy; Thu, 23 Sep 2021 23:09:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 113B040004;
	Thu, 23 Sep 2021 23:09:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D94C4C000F;
	Thu, 23 Sep 2021 23:09:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11B70C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 23:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E173840025
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 23:09:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ljntTCoipkFw for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 23:09:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4056940004
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 23:09:44 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 837A861107;
 Thu, 23 Sep 2021 23:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632438583;
 bh=N5cuTMmeZEkv0jHourxdJkh/zB3vziTEXWj25gMIcvE=;
 h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
 b=VwhSiUXbg4mGx+IRNOlnUS918ijpj2HG2O8Is2jqB4Oz1ZrnuGA+cFWCCZWYlAXHK
 vcdntZnT5F/brH6v+e9fYJC1EApmRkhmdXyhc1yWG9RpMw31SzH5V58ayjhLM2vcE7
 40xVEbjdkJAqxOI1HGqyMJ68f/SAkPHqI9dY0ENHif0CCMnGGhx9BnLWEbM83bpKa5
 +vbqWClgc6UzmcQB5urCiaMENKHDEM0kFJFEFh7gGHLLihPkJkFWx8o3jygHSJFfie
 R0Cv2ryb6FMDHab3/BkbymwIpJTH6LnlS4iNy7OK4yI3L8ZJpcg7We+tZIlkbMF2Hr
 fn+Uy9mZbZzKg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailauth.nyi.internal (Postfix) with ESMTP id A49FF27C0054;
 Thu, 23 Sep 2021 19:09:41 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
 by compute6.internal (MEProxy); Thu, 23 Sep 2021 19:09:41 -0400
X-ME-Sender: <xms:NAlNYUPxuW4mPlQRY1kmKKFbkWbULHi5tN1tp2V25yzw4RxhuNA4FQ>
 <xme:NAlNYa8HqP9hoU2iNxhr3wQ0nQR5nw24sylsUaxdAjFI6leDkEY3qb662heZa8szp
 5B1xzXDKgtq1ldvf6Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejtddgudejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
 hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
 frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
 fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
 ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
 drlhhuthhordhush
X-ME-Proxy: <xmx:NAlNYbTXJqDoilPp5cJwxwEUVir6uZvRqpNEgC00yT5WrEyURImaYA>
 <xmx:NAlNYcv7KE2E1sOTQk5mRZG-VDoaafqZ87W_AOdD4CsDvKGgKJ_QFg>
 <xmx:NAlNYcdbExK4hyiY5nJU042jB-a_PawzLwTprTOn-Mm74raSBsIuUw>
 <xmx:NQlNYX35C_oPaXrDIfQ7VDo2GM4FoLpk54lU8SsS3723_P1yoRfbYto0Hig>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id AFE5521E0063; Thu, 23 Sep 2021 19:09:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <d5f00e34-f9fc-4421-8571-48c45237141c@www.fastmail.com>
In-Reply-To: <20210920192349.2602141-6-fenghua.yu@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
Date: Thu, 23 Sep 2021 16:09:18 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Fenghua Yu" <fenghua.yu@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Dave Hansen" <dave.hansen@intel.com>, "Tony Luck" <tony.luck@intel.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, "Joerg Roedel" <joro@8bytes.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>, "Dave Jiang" <dave.jiang@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>, "Raj Ashok" <ashok.raj@intel.com>, 
 "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Cc: iommu@lists.linux-foundation.org, the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Sep 20, 2021, at 12:23 PM, Fenghua Yu wrote:
> PASIDs are fundamentally hardware resources in a shared address space.
> There is a limited number of them to use ENQCMD on shared workqueue.
> They must be shared and managed. They can not, for instance, be
> statically allocated to processes.
>
> Free PASID eagerly by sending IPIs in unbind was disabled due to locking
> and other issues in commit 9bfecd058339 ("x86/cpufeatures: Force disable
> X86_FEATURE_ENQCMD and remove update_pasid()").
>
> Lazy PASID free is implemented in order to re-enable the ENQCMD feature.
> PASIDs are currently reference counted and are centered around device
> usage. To support lazy PASID free, reference counts are tracked in the
> following scenarios:
>
> 1. The PASID's reference count is initialized as 1 when the PASID is first
>    allocated in bind. This is already implemented.
> 2. A reference is taken when a device is bound to the mm and dropped
>    when the device is unbound from the mm. This reference tracks device
>    usage of the PASID. This is already implemented.
> 3. A reference is taken when a task's IA32_PASID MSR is initialized in
>    #GP fix up and dropped when the task exits. This reference tracks
>    the task usage of the PASID. It is implemented here.

I think this is unnecessarily complicated because it's buying in to the existing ISA misconception that PASID has anything to do with a task.  A PASID belongs to an mm, full stop.  Now the ISA is nasty and we have tasks that have *noticed* that their mm has a PASID and tasks that have not noticed this fact, but that should be irrelevant to essentially everything except the fault handler.

So just refcount the thing the obvious way: take a reference when you stick the PASID in the mm_struct and drop the reference in __mmdrop().  Problem solved.  You could probably drop it more aggressively in __mmput(), and the comment explaining why is left as an exercise to the reader -- if a kernel thread starts doing ENQCMD, we have worse things to worry about :)

--Andy
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

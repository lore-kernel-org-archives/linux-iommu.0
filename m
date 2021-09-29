Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6278CC433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 17:48:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188A26135E
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 17:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 188A26135E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D924960E66;
	Wed, 29 Sep 2021 17:48:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xFh7QSAsXiBT; Wed, 29 Sep 2021 17:48:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B970C60681;
	Wed, 29 Sep 2021 17:48:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 826C5C0011;
	Wed, 29 Sep 2021 17:48:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBE2AC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 17:48:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD3C560E75
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 17:48:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ivZPlgy6tNj for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 17:48:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5ED5A60E6D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 17:48:47 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9C676135E;
 Wed, 29 Sep 2021 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632937726;
 bh=tLjf7ByYwVhjXqabNGPwxSoclyuNCCE6x80vMFzepIs=;
 h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
 b=bgRwAZa/OUvPVef40TFwaW5Vew0zKg7D/qy68yYtWH6nLUdsKPdin9oRKESfivvo1
 y7+mDtcPM+6MgbUgdX41KcXSYM1QoF9gtl6FYhAqk2e/c1XejiQuNxL6hiQVe+dZJ+
 //dnpz7siCVK1cv5LWQDfZVLu5LYfL4f5oA5a0l8Tl8mMRujeIW3LG62LLpzoWCxkd
 Of6ImemsH0ekP+92CkfeDvmTLqn8SnbQ1CvDJtPiOb0MgcrIe99L7mPx5EtyqHB8Z+
 HHFEe80AF5jAoVR0P3zCnDwHJ2oGMVrBVmcI8IkQNuD8LCUdCgBLRb9ysADMsH+YV4
 QFN0BW3VFXZqg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailauth.nyi.internal (Postfix) with ESMTP id CA65627C0054;
 Wed, 29 Sep 2021 13:48:44 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
 by compute6.internal (MEProxy); Wed, 29 Sep 2021 13:48:44 -0400
X-ME-Sender: <xms:_KZUYf55iZiRX_jgZjz5XjQjgxM2C8RdNcVbWbx3-UgaA0sl5CCCdA>
 <xme:_KZUYU5BQXgK22YM8pA9aK2vEaSb2w4sgSnueDS39rLFMCGojyaTHhCAF6ooGf__a
 R-5s9vBoNkimI_SqgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekvddgudduhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
 ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
 ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
 gfefvdekgeefnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
 homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
 heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
 igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:_KZUYWc6vaORUAEBfRotWtJzav_C2aYW8BFUEeA7ibu9_gCljEvVHg>
 <xmx:_KZUYQLU4SeqlgGnNiUyelTBXFoQm5GHaEOQJEl07uP7IYoG9A09Gg>
 <xmx:_KZUYTLVvElKzoXt4bIJTW9oCMQe8QXuGvmw4ZHiTe3wdnSM6NJ59w>
 <xmx:_KZUYVg7d3CoYrk5YW0rBXSMjWaZWEKEvKqc-Iu_V7t8MOX84w0Q-0ErNbE>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id A023121E0066; Wed, 29 Sep 2021 13:48:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <e396e8d4-9221-4426-bd38-41ccac040e5f@www.fastmail.com>
In-Reply-To: <YVSdauvwzs1HJlLz@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
 <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
 <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
 <3f97b77e-a609-997b-3be7-f44ff7312b0d@intel.com>
 <YVN652x14dMgyE85@agluck-desk2.amr.corp.intel.com>
 <f6014b16-7b4c-cbb6-c975-1ec34092956f@intel.com>
 <YVOg7zgpdQlc7Zjt@agluck-desk2.amr.corp.intel.com>
 <308a72e4-6aa9-0c84-21e6-ee613eea35a8@kernel.org>
 <YVSdauvwzs1HJlLz@agluck-desk2.amr.corp.intel.com>
Date: Wed, 29 Sep 2021 10:48:24 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Tony Luck" <tony.luck@intel.com>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
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



On Wed, Sep 29, 2021, at 10:07 AM, Luck, Tony wrote:
> On Wed, Sep 29, 2021 at 09:58:22AM -0700, Andy Lutomirski wrote:
>> On 9/28/21 16:10, Luck, Tony wrote:
>> > Moving beyond pseudo-code and into compiles-but-probably-broken-code.
>> > 
>> > 
>> > The intent of the functions below is that Fenghua should be able to
>> > do:
>> > 
>> > void fpu__pasid_write(u32 pasid)
>> > {
>> > 	u64 msr_val = pasid | MSR_IA32_PASID_VALID;
>> > 	struct ia32_pasid_state *addr;
>> > 
>> > 	addr = begin_update_one_xsave_feature(current, XFEATURE_PASID, true);
>> > 	addr->pasid = msr_val;
>> > 	finish_update_one_xsave_feature(current);
>> > }
>> > 
>> 
>> This gets gnarly because we would presumably like to optimize the case where
>> we can do the update directly in registers.  I wonder if we can do it with a
>> bit of macro magic in a somewhat generic way:
>
> Can we defere the optimizations until there is a use case that
> cares? The existing use case (fixing up the #GP fault by setting
> the PASID MSR) isn't performance critical.
>
> Let's just have something that is clear (or as clear as any xsave
> code can be) and correct.
>
> 

The goal would be to use the same code for CET and PKRU, I think.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

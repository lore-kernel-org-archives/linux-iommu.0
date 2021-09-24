Return-Path: <SRS0=LkSb=OO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E5AC433EF
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 23:04:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADE461260
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 23:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BADE461260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 900956079C;
	Fri, 24 Sep 2021 23:04:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dTh2_1Qk-BGU; Fri, 24 Sep 2021 23:04:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 79D686067E;
	Fri, 24 Sep 2021 23:04:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BB6CC0011;
	Fri, 24 Sep 2021 23:04:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9687EC000D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 23:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84C7660761
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 23:04:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WQk6PvQ3cbMo for <iommu@lists.linux-foundation.org>;
 Fri, 24 Sep 2021 23:04:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E302C6067E
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 23:04:22 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C63B610C9;
 Fri, 24 Sep 2021 23:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632524662;
 bh=ij9GOSYQivv1qrt6f54DLhTJHRl6BWHJPSjicajML1g=;
 h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
 b=sRTrTEUY4SdMxTf9IShw9sP+12uYYymkueU2tZv5bE7MDcfTo0P5+2/EsWZ6nisKR
 FWWSh2dIQMObBjKhISDRBwbNLuGXGHI4mYWsWNidBp9y3i/CBO3AjgMeKvlH9io3a6
 1FwP9LxpTrjsYcMvAgvAldG1b5z+V6TfcUuNB0bOxVp3dKrezkHq5ENYBaqm9zTeCf
 DEW1EZyOFqNqqssfb6jrwDOogutw9l/8la72kTrDjnGKTJMgO/L+ZNGbV74PP/4t+5
 hX+NjVUWsoN49nCxdpYhIef+ICirQ+7aFvXS+K08qklnipJ3JTs9nAbHh7Vcn1w00v
 xLJPA0PiCBx5A==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailauth.nyi.internal (Postfix) with ESMTP id 6AF9E27C0054;
 Fri, 24 Sep 2021 19:04:20 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
 by compute6.internal (MEProxy); Fri, 24 Sep 2021 19:04:20 -0400
X-ME-Sender: <xms:c1lOYU6XOgKWl3fMxx-T7U8p93re9fiqANFe3tcjLi6j9IrFzEh4DA>
 <xme:c1lOYV6cwP63K6jxFUSWATY1NAP4a7G4Z4MsYBr8wLwbLBEstT2ZjRW7OnsIQHHgV
 tNbLoB6Fs4ZhO9rNN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejvddgudejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
 hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
 frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
 fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
 ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
 drlhhuthhordhush
X-ME-Proxy: <xmx:c1lOYTdghyb-xn5Hr6pgv7WpsOWdeAKJzy24U0-Oy8FWXBzLUjOegg>
 <xmx:c1lOYZLNrLHDMYGjHAeRn9bE1w60c7nBJnZsSZub7H8BqCQ8GTDeaQ>
 <xmx:c1lOYYJ3IEIR-qDMgCmJ46N3SjYMKgyltqDMUBQdhnyJ7yq8uMiFBQ>
 <xmx:dFlOYagmnaddcQqFHSC6H0gDdpudsUcssn3Nf1y-bxqaNhfuC8LFLQ1fX34>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 5ADFD21E0063; Fri, 24 Sep 2021 19:04:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
In-Reply-To: <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com> <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com> <87o88jfajo.ffs@tglx>
 <87k0j6dsdn.ffs@tglx> <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
Date: Fri, 24 Sep 2021 16:03:53 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Tony Luck" <tony.luck@intel.com>, "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Cc: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>
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



On Fri, Sep 24, 2021, at 9:12 AM, Luck, Tony wrote:
> On Fri, Sep 24, 2021 at 03:18:12PM +0200, Thomas Gleixner wrote:
>> On Thu, Sep 23 2021 at 19:48, Thomas Gleixner wrote:
>> > On Thu, Sep 23 2021 at 09:40, Tony Luck wrote:
>> >
>> > fpu_write_task_pasid() can just grab the pasid from current->mm->pasid
>> > and be done with it.
>> >
>> > The task exit code can just call iommu_pasid_put_task_ref() from the
>> > generic code and not from within x86.
>> 
>> But OTOH why do you need a per task reference count on the PASID at all?
>> 
>> The PASID is fundamentaly tied to the mm and the mm can't go away before
>> the threads have gone away unless this magically changed after I checked
>> that ~20 years ago.
>
> It would be possible to avoid a per-task reference to the PASID by
> taking an extra reference when mm->pasid is first allocated using
> the CONFIG_PASID_TASK_REFS you proposed yesterday to define a function
> to take the extra reference, and another to drop it when the mm is
> finally freed ... with stubs to do nothing on architectures that
> don't create per-task PASID context.
>
> This solution works, but is functionally different from Fenghua's
> proposal for this case:
>
> 	Process clones a task
> 	task binds a device
> 	task accesses device using PASID
> 	task unbinds device
> 	task exits (but process lives on)
>
> Fenghua will free the PASID because the reference count goes
> back to zero. The "take an extra reference and keep until the
> mm is freed" option would needlessly hold onto the PASID.
>
> This seems like an odd usage case ... even if it does exist, a process
> that does this may spawn another task that does the same thing.
>
> If you think it is sufficiently simpler to use the "extra reference"
> option (invoking the "perfect is the enemy of good enough" rule) then we
> can change.

I think the perfect and the good are a bit confused here. If we go for "good", then we have an mm owning a PASID for its entire lifetime.  If we want "perfect", then we should actually do it right: teach the kernel to update an entire mm's PASID setting all at once.  This isn't *that* hard -- it involves two things:

1. The context switch code needs to resync PASID.  Unfortunately, this adds some overhead to every context switch, although a static_branch could minimize it for non-PASID users.
2. A change to an mm's PASID needs to sent an IPI, but that IPI can't touch FPU state.  So instead the IPI should use task_work_add() to make sure PASID gets resynced.

And there is still no per-task refcounting.

After all, the not so perfect attempt at perfect in this patch set won't actually work if a thread pool is involved.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

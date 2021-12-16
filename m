Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66290C433F5
	for <iommu@archiver.kernel.org>; Thu, 16 Dec 2021 09:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11DD2416E9;
	Thu, 16 Dec 2021 09:19:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GnZqJVT20zyr; Thu, 16 Dec 2021 09:19:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E6636416D6;
	Thu, 16 Dec 2021 09:19:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFB81C002F;
	Thu, 16 Dec 2021 09:19:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43FBBC0012
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 09:19:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A0ED832BF
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 09:19:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.cz header.b="ZYRquT7w";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.cz header.b="9KCZzAFw"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xmy1lYObIMy9 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 09:19:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DFC22831A7
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 09:19:05 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 817CB1F45E;
 Thu, 16 Dec 2021 09:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639646342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rSmtMs4D/JMgdDSMfUX2HHXghuzhz3dXnYIHGOrCvIE=;
 b=ZYRquT7w/sYhdd9nS/Jw484q+HHCO55WvkA2cWVmui6nm4c72iQb8r0c3s0IqBVotyADay
 itkgxzc+bsXlEOaoTY841FC7HivasogpzrSLz+hjgior+Tg3hL6PIGOa1UD5wbCFbsxcfD
 peX3wzUigyNTyUyonZq3/0tiXN2OZDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639646342;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rSmtMs4D/JMgdDSMfUX2HHXghuzhz3dXnYIHGOrCvIE=;
 b=9KCZzAFwVEmzRi97GXUbGa+7/wo2edOGm5ye9yAA2u98sFHTfmatiOoLOIPRTH48K7/Bkq
 DuxL1c4mixmO7WAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01F1E13C1F;
 Thu, 16 Dec 2021 09:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id taJdO4UEu2FwXQAAMHmgww
 (envelope-from <vbabka@suse.cz>); Thu, 16 Dec 2021 09:19:01 +0000
Message-ID: <956d76e5-a319-7e3d-14b9-af5106b5333f@suse.cz>
Date: Thu, 16 Dec 2021 10:19:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Content-Language: en-US
To: Roman Gushchin <guro@fb.com>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <Ybk+0LKrsAJatILE@carbon.dhcp.thefacebook.com>
 <Ybp8a5JNndgCLy2w@carbon.dhcp.thefacebook.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Ybp8a5JNndgCLy2w@carbon.dhcp.thefacebook.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com,
 "H. Peter Anvin" <hpa@zytor.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>,
 Julia Lawall <julia.lawall@inria.fr>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, x86@kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Vladimir Davydov <vdavydov.dev@gmail.com>,
 David Rientjes <rientjes@google.com>, Nitin Gupta <ngupta@vflare.org>,
 Marco Elver <elver@google.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, cgroups@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 patches@lists.linux.dev, Pekka Enberg <penberg@kernel.org>,
 Minchan Kim <minchan@kernel.org>, iommu@lists.linux-foundation.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On 12/16/21 00:38, Roman Gushchin wrote:
> On Tue, Dec 14, 2021 at 05:03:12PM -0800, Roman Gushchin wrote:
>> On Tue, Dec 14, 2021 at 01:57:22PM +0100, Vlastimil Babka wrote:
>> > On 12/1/21 19:14, Vlastimil Babka wrote:
>> > > Folks from non-slab subsystems are Cc'd only to patches affecting them, and
>> > > this cover letter.
>> > > 
>> > > Series also available in git, based on 5.16-rc3:
>> > > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
>> > 
>> > Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
>> > and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:
>> 
>> Hi Vlastimil!
>> 
>> I've started to review this patchset (btw, a really nice work, I like
>> the resulting code way more). Because I'm looking at v3 and I don't have

Thanks a lot, Roman!

...

> 
> * mm/slab: Convert most struct page to struct slab by spatch
> 
> Another patch with the same title? Rebase error?
> 
> * mm/slab: Finish struct page to struct slab conversion
> 
> And this one too?

No, these are for mm/slab.c, the previous were for mm/slub.c :)

> 
> Thanks!
> 
> Roman

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

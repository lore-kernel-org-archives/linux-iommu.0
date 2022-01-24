Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD846C433EF
	for <iommu@archiver.kernel.org>; Mon, 24 Jan 2022 20:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C84B83F38;
	Mon, 24 Jan 2022 20:36:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NYlcaoBqDg8W; Mon, 24 Jan 2022 20:36:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5D1C3827F3;
	Mon, 24 Jan 2022 20:36:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 347E9C0039;
	Mon, 24 Jan 2022 20:36:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07530C002F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 20:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3DEA82FA9
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 20:36:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KMTCPhxmsx53 for <iommu@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 20:36:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4AFC6827F3
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 20:36:03 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1643056560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZkeR8sx1uJfYl5V+1hDn7Z+OR1HYkHbw79HjnsAp4QY=;
 b=nkPJpLA2yOi+yzdNLC/2FWxejeY1zVZkgybDhWNcCuaClcSm2bzt7VcV1MQvPYNqFSo4+Q
 WHwstVrTl643QT6MMv2QwtlaHQ2QmQUyVTOX0A5i+DLaM0QGE/hv87T5+M9VjRhmijVtvs
 mud10TcJ3WSiYPn0nSuSprneTlnF/PRe/QB6adeMkUmsWnmel/Ig8eO53OIIH8ZrRvc8W7
 5l1g8VRInKtciwBJEh0eV8qVpDD4jfWXXCHTsS6Jt3B0iPNU2lurEpfjlNCv30gyTiIDlR
 vBV8TAKvfJcZ6G99jgEuC0BxiV0Da5jFhMfB7VozCkSDOqizG5z5xp5/oVk3Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1643056560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZkeR8sx1uJfYl5V+1hDn7Z+OR1HYkHbw79HjnsAp4QY=;
 b=h4ZLp5bKuVRuCYbVfeAOg6IS9CjOLBsFAmTC0ad9+KDBLUtxmYqHYPptNWjZhlF6uk2VLc
 bdMceZqau2ihH1BQ==
To: Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Ashok
 Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v2 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <87ee4w6g1n.ffs@tglx>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com> <87ee4w6g1n.ffs@tglx>
Date: Mon, 24 Jan 2022 21:36:00 +0100
Message-ID: <87bl006fdb.ffs@tglx>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
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

On Mon, Jan 24 2022 at 21:21, Thomas Gleixner wrote:
>
> Hrm. This is odd.
>
>> +/* Associate a PASID with an mm_struct: */
>> +static inline void mm_pasid_get(struct mm_struct *mm, u32 pasid)
>> +{
>> +	mm->pasid = pasid;
>> +}
>
> This does not get anything. It sets the allocated PASID in the mm. The
> refcount on the PASID was already taken by the allocation. So this
> should be mm_pasid_set() or mm_pasid_install(), right?

And as a result of all this ioasid_get() is now left without users...

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

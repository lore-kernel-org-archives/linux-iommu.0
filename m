Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C14C433EF
	for <iommu@archiver.kernel.org>; Sat,  5 Feb 2022 00:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0365C82A7F;
	Sat,  5 Feb 2022 00:01:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0bj-s3E7EXYJ; Sat,  5 Feb 2022 00:01:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 92546815AB;
	Sat,  5 Feb 2022 00:01:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C5FBC0011;
	Sat,  5 Feb 2022 00:01:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15A9BC000B
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 00:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB10E82A7F
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 00:01:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QgcV_B4gOLAc for <iommu@lists.linux-foundation.org>;
 Sat,  5 Feb 2022 00:01:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 51ECA815AB
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 00:01:00 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1644019257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ri16KQqpRWhbQ9tq4lko5fBCxFjiFeJpIxcy6locFBk=;
 b=0PiJFv7Q680b0JcJbCwMzoad2gdGuTL+FEqbch9DbiWYQpYC2RzJNQNZR0SEHAWbcpWtmO
 IsEKaNIqVJkah7KNUzl6GTQEN1yhBz0iUDGC0vcmRFKWlSC9VqpPkwrNper5XEnHb/DJjP
 SrCKUni1xCDY7UJy5ocH+9qVsezO30/BSCQi9+xujys3Fu1qdbgeEBpxfYLDbWcjcS0q5h
 TLHfIA47v3BmLAAOzaTPM4sjfMhDFmqOM7aq+4XoMLkGE9v1KKvMlM26Q34aw64G5cVqj2
 YXsJGTku0kJ8hDRdf9JHBDEB5XaM7ST+Y+tpO3YWt6A8XJADAwbXZDt3F0lGzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1644019257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ri16KQqpRWhbQ9tq4lko5fBCxFjiFeJpIxcy6locFBk=;
 b=+I+5521Op1f9Yh9qCYj91UeFSGP9ApszIdo7Uvfz1nweusNn4smNTrk9mfSMbAIRL/ua3G
 rqoCTiOrXMQ9rHCA==
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy
 Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Ashok
 Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v3 09/11] x86/cpufeatures: Re-enable ENQCMD
In-Reply-To: <20220128202905.2274672-10-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-10-fenghua.yu@intel.com>
Date: Sat, 05 Feb 2022 01:00:56 +0100
Message-ID: <87fsoyb2rr.ffs@tglx>
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

On Fri, Jan 28 2022 at 12:29, Fenghua Yu wrote:
> Since ENQCMD is handled by #GP fix up, it can be re-enabled.
>
> The ENQCMD feature can only be used if CONFIG_INTEL_IOMMU_SVM is set. Add
> X86_FEATURE_ENQCMD to the disabled features mask as appropriate so that
> cpu_feature_enabled() can be used to check the feature.
>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

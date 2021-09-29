Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FA9C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 16:58:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1F9613DA
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 16:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB1F9613DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 732A840094;
	Wed, 29 Sep 2021 16:58:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gptmv_ZydzOO; Wed, 29 Sep 2021 16:58:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C1AC6422AF;
	Wed, 29 Sep 2021 16:58:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CD7AC000F;
	Wed, 29 Sep 2021 16:58:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEB7FC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 16:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE0D2422B4
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 16:58:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pWWZPSKsyAEe for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 16:58:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E276422AF
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 16:58:24 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5ACF613DA;
 Wed, 29 Sep 2021 16:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632934704;
 bh=q4dgtgHH+SOQqblaZiTZK7wKV7b2yiFarg51sd83ckI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JcY9Y8FqBZERBzXPm3S4fXyN6inna8kb+CnU5IpBO0rxpRiFjiv3r65E/tMIEUrY2
 LqMxp5k8j2KAyf5NIHvM6jcpCVkjhto8pBaq7kQI2j2scrj8vKcywTGw428dJi3STO
 vbwVmDgF8Uz7X6NWclc/SiTRwi22WKwM4zkVc0mtAsJB9dP84lXxnmo4V8g5N5abjE
 asN1CEN8yku11KWfT/n/0NkVl8Hf9pZQDU4cByXDROlTPmCZQGngn82j2s0o6dHW6L
 YIaij5UxY5T/ugctGR5WzTcQOEGk+dzMci29bxBUqMmk338T2axaQJsC9DeanwKCSA
 cfBPVnZ+aDpkQ==
Message-ID: <308a72e4-6aa9-0c84-21e6-ee613eea35a8@kernel.org>
Date: Wed, 29 Sep 2021 09:58:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, Dave Hansen <dave.hansen@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
 <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
 <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
 <3f97b77e-a609-997b-3be7-f44ff7312b0d@intel.com>
 <YVN652x14dMgyE85@agluck-desk2.amr.corp.intel.com>
 <f6014b16-7b4c-cbb6-c975-1ec34092956f@intel.com>
 <YVOg7zgpdQlc7Zjt@agluck-desk2.amr.corp.intel.com>
From: Andy Lutomirski <luto@kernel.org>
In-Reply-To: <YVOg7zgpdQlc7Zjt@agluck-desk2.amr.corp.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

On 9/28/21 16:10, Luck, Tony wrote:
> Moving beyond pseudo-code and into compiles-but-probably-broken-code.
> 
> 
> The intent of the functions below is that Fenghua should be able to
> do:
> 
> void fpu__pasid_write(u32 pasid)
> {
> 	u64 msr_val = pasid | MSR_IA32_PASID_VALID;
> 	struct ia32_pasid_state *addr;
> 
> 	addr = begin_update_one_xsave_feature(current, XFEATURE_PASID, true);
> 	addr->pasid = msr_val;
> 	finish_update_one_xsave_feature(current);
> }
> 

This gets gnarly because we would presumably like to optimize the case 
where we can do the update directly in registers.  I wonder if we can do 
it with a bit of macro magic in a somewhat generic way:

typedef fpu__pasid_type u32;

static inline void fpu__set_pasid_in_register(const u32 *value)
{
	wrmsr(...);
}

#define DEFINE_FPU_HELPER(name) \
static inline void fpu__set_##name(const fpu__##name##_type *val) \
{ \
	fpregs_lock(); \
	if (should write in memory) { \
		->xfeatures |= XFEATURE_##name; \
		ptr = get_xsave_addr(...); \
		memcpy(ptr, val, sizeof(*val)); \
		__fpu_invalidate_fpregs_state(...); \
	} else { \
		fpu__set_##name##_in_register(val); \
	} \
}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

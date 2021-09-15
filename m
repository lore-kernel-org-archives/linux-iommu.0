Return-Path: <SRS0=KP5g=OF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF50DC4332F
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 00:29:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D86F61242
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 00:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D86F61242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B1E880AD3;
	Wed, 15 Sep 2021 00:29:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rr8AKdzL9tVd; Wed, 15 Sep 2021 00:29:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2FCA180ACF;
	Wed, 15 Sep 2021 00:29:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 059FAC000F;
	Wed, 15 Sep 2021 00:29:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB18FC000D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 00:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C598400B9
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 00:29:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ellerman.id.au
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bN4cM2rxSK8K for <iommu@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 00:29:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4BE63404DD
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 00:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1631665743;
 bh=HgCpSqOauKiPM+dBPwX1rVKc5DllbEYyPqTeHP+eUfA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=nobrDH5nGZu7v+B+3sYvcmgWwQ6HXMJcFwBQJdDWX9HZxhJmSYRfeLJ5bqM1L8nAT
 Zv7FEyFybAcOR9q2SSYXqyD/igi9xudle6V5yasFwsCuG7S0oozCaRNikxkvD596/w
 6l43PVixwL61h3NyNDnNd5sNzqDNGCDn9FEcD1fB6an9gsKEzr5R3Isof7M+Dp+CFm
 Flkym9C4vSI8DMWcOL/ydbmO/xhA1U449O7gqRfyeoJq9Tl/sPJDKQcCHDPv+s1Rp6
 4loBfWLosZBa6f9xlvgT7ZD+EwPUzeNUvScHtwtaoHQpWTi57p46qNn2qlhGqy8rED
 FWCERXkM6X8Sg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4H8LgJ0MSWz9sVq;
 Wed, 15 Sep 2021 10:28:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 4/8] powerpc/pseries/svm: Add a powerpc version of
 cc_platform_has()
In-Reply-To: <YUCOTIPPsJJpLO/d@zn.tnic>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
 <YUCOTIPPsJJpLO/d@zn.tnic>
Date: Wed, 15 Sep 2021 10:28:59 +1000
Message-ID: <87lf3yk7g4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, x86@kernel.org, amd-gfx@lists.freedesktop.org,
 Christoph Hellwig <hch@infradead.org>, linux-graphics-maintainer@vmware.com,
 Tom Lendacky <thomas.lendacky@amd.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Borislav Petkov <bp@alien8.de> writes:
> On Wed, Sep 08, 2021 at 05:58:35PM -0500, Tom Lendacky wrote:
>> Introduce a powerpc version of the cc_platform_has() function. This will
>> be used to replace the powerpc mem_encrypt_active() implementation, so
>> the implementation will initially only support the CC_ATTR_MEM_ENCRYPT
>> attribute.
>> 
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/powerpc/platforms/pseries/Kconfig       |  1 +
>>  arch/powerpc/platforms/pseries/Makefile      |  2 ++
>>  arch/powerpc/platforms/pseries/cc_platform.c | 26 ++++++++++++++++++++
>>  3 files changed, 29 insertions(+)
>>  create mode 100644 arch/powerpc/platforms/pseries/cc_platform.c
>
> Michael,
>
> can I get an ACK for the ppc bits to carry them through the tip tree
> pls?

Yeah.

I don't love it, a new C file and an out-of-line call to then call back
to a static inline that for most configuration will return false ... but
whatever :)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)


> Btw, on a related note, cross-compiling this throws the following error here:
>
> $ make CROSS_COMPILE=/home/share/src/crosstool/gcc-9.4.0-nolibc/powerpc64-linux/bin/powerpc64-linux- V=1 ARCH=powerpc
>
> ...
>
> /home/share/src/crosstool/gcc-9.4.0-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc -Wp,-MD,arch/powerpc/boot/.crt0.o.d -D__ASSEMBLY__ -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -O2 -msoft-float -mno-altivec -mno-vsx -pipe -fomit-frame-pointer -fno-builtin -fPIC -nostdinc -include ./include/linux/compiler_attributes.h -I./arch/powerpc/include -I./arch/powerpc/include/generated  -I./include -I./arch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h -m32 -isystem /home/share/src/crosstool/gcc-9.4.0-nolibc/powerpc64-linux/bin/../lib/gcc/powerpc64-linux/9.4.0/include -mbig-endian -nostdinc -c -o arch/powerpc/boot/crt0.o arch/powerpc/boot/crt0.S
> In file included from <command-line>:
> ././include/linux/compiler_attributes.h:62:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
>    62 | #if __has_attribute(__assume_aligned__)
>       |     ^~~~~~~~~~~~~~~
> ././include/linux/compiler_attributes.h:62:20: error: missing binary operator before token "("
>    62 | #if __has_attribute(__assume_aligned__)
>       |                    ^
> ././include/linux/compiler_attributes.h:88:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
>    88 | #if __has_attribute(__copy__)
>       |     ^~~~~~~~~~~~~~~
> ...
>
> Known issue?

Yeah, fixed in mainline today, thanks for trying to cross compile :)

cheers
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

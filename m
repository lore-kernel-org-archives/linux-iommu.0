Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA08AC433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 11:58:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD55610FB
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 11:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9CD55610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DEE260A58;
	Tue, 14 Sep 2021 11:58:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QY2n1wLcjx46; Tue, 14 Sep 2021 11:58:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 49B27605BA;
	Tue, 14 Sep 2021 11:58:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23EF9C0011;
	Tue, 14 Sep 2021 11:58:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38F5EC000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 11:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C72B80E60
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 11:58:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mg2Wn2C-7kAl for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 11:58:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB83080E5A
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 11:58:18 +0000 (UTC)
Received: from zn.tnic (p200300ec2f1048001e15ef619509992f.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f10:4800:1e15:ef61:9509:992f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B7241EC04EC;
 Tue, 14 Sep 2021 13:58:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1631620690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=b/N09IsvqYn24JfFZ47aDfAefXmwmXR82Pt3awNAfbs=;
 b=bxwwIzIyK+Rg4oIy01BbpgT86ORE1XKclCEYAaQ9uu2p2YFJBhtO9vvO21Z67RPc0ptMoP
 47+Ry7kCX0P48iid+/PmdkrtsbH5uZdiuAmR5uxqjBKZy74znSrvhF2nYkipmdb9VWoPx/
 PSVn04awQpG91qOKWcYNAHUkxFtjb44=
Date: Tue, 14 Sep 2021 13:58:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 4/8] powerpc/pseries/svm: Add a powerpc version of
 cc_platform_has()
Message-ID: <YUCOTIPPsJJpLO/d@zn.tnic>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
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

On Wed, Sep 08, 2021 at 05:58:35PM -0500, Tom Lendacky wrote:
> Introduce a powerpc version of the cc_platform_has() function. This will
> be used to replace the powerpc mem_encrypt_active() implementation, so
> the implementation will initially only support the CC_ATTR_MEM_ENCRYPT
> attribute.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/powerpc/platforms/pseries/Kconfig       |  1 +
>  arch/powerpc/platforms/pseries/Makefile      |  2 ++
>  arch/powerpc/platforms/pseries/cc_platform.c | 26 ++++++++++++++++++++
>  3 files changed, 29 insertions(+)
>  create mode 100644 arch/powerpc/platforms/pseries/cc_platform.c

Michael,

can I get an ACK for the ppc bits to carry them through the tip tree
pls?

Btw, on a related note, cross-compiling this throws the following error here:

$ make CROSS_COMPILE=/home/share/src/crosstool/gcc-9.4.0-nolibc/powerpc64-linux/bin/powerpc64-linux- V=1 ARCH=powerpc

...

/home/share/src/crosstool/gcc-9.4.0-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc -Wp,-MD,arch/powerpc/boot/.crt0.o.d -D__ASSEMBLY__ -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -O2 -msoft-float -mno-altivec -mno-vsx -pipe -fomit-frame-pointer -fno-builtin -fPIC -nostdinc -include ./include/linux/compiler_attributes.h -I./arch/powerpc/include -I./arch/powerpc/include/generated  -I./include -I./arch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h -m32 -isystem /home/share/src/crosstool/gcc-9.4.0-nolibc/powerpc64-linux/bin/../lib/gcc/powerpc64-linux/9.4.0/include -mbig-endian -nostdinc -c -o arch/powerpc/boot/crt0.o arch/powerpc/boot/crt0.S
In file included from <command-line>:
././include/linux/compiler_attributes.h:62:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
   62 | #if __has_attribute(__assume_aligned__)
      |     ^~~~~~~~~~~~~~~
././include/linux/compiler_attributes.h:62:20: error: missing binary operator before token "("
   62 | #if __has_attribute(__assume_aligned__)
      |                    ^
././include/linux/compiler_attributes.h:88:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
   88 | #if __has_attribute(__copy__)
      |     ^~~~~~~~~~~~~~~
...

Known issue?

This __has_attribute() thing is supposed to be supported
in gcc since 5.1 and I'm using the crosstool stuff from
https://www.kernel.org/pub/tools/crosstool/ and gcc-9.4 above is pretty
new so that should not happen actually.

But it does...

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

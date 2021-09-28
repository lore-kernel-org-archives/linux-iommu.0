Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F558C433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:19:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBF761374
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CCBF761374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4AAC4040B;
	Tue, 28 Sep 2021 19:19:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DvGwJTvzGUHB; Tue, 28 Sep 2021 19:19:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 81B26403BB;
	Tue, 28 Sep 2021 19:19:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49DC2C000F;
	Tue, 28 Sep 2021 19:19:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46ADDC000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 28D18403C0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:19:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qqdp3U_1481s for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 19:19:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 748A2403BB
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:19:54 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="212038816"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; d="scan'208";a="212038816"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 12:19:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; d="scan'208";a="554270019"
Received: from oogunmoy-mobl1.amr.corp.intel.com (HELO
 skuppusw-mobl5.amr.corp.intel.com) ([10.212.221.219])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 12:19:51 -0700
Subject: Re: [PATCH v4 0/8] Implement generic cc_platform_has() helper function
To: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
References: <20210928191009.32551-1-bp@alien8.de>
From: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <80593893-c63b-d481-45f1-42a3a6fd762a@linux.intel.com>
Date: Tue, 28 Sep 2021 12:19:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928191009.32551-1-bp@alien8.de>
Content-Language: en-US
Cc: linux-efi@vger.kernel.org, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, linux-s390@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, amd-gfx@lists.freedesktop.org,
 Christoph Hellwig <hch@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Dave Young <dyoung@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, kexec@lists.infradead.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 9/28/21 12:10 PM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Hi all,
> 
> here's v4 of the cc_platform_has() patchset with feedback incorporated.
> 
> I'm going to route this through tip if there are no objections.

Intel CC support patch is not included in this series. You want me
to address the issue raised by Joerg before merging it?

> 
> Thx.
> 
> Tom Lendacky (8):
>    x86/ioremap: Selectively build arch override encryption functions
>    arch/cc: Introduce a function to check for confidential computing
>      features
>    x86/sev: Add an x86 version of cc_platform_has()
>    powerpc/pseries/svm: Add a powerpc version of cc_platform_has()
>    x86/sme: Replace occurrences of sme_active() with cc_platform_has()
>    x86/sev: Replace occurrences of sev_active() with cc_platform_has()
>    x86/sev: Replace occurrences of sev_es_active() with cc_platform_has()
>    treewide: Replace the use of mem_encrypt_active() with
>      cc_platform_has()
> 
>   arch/Kconfig                                 |  3 +
>   arch/powerpc/include/asm/mem_encrypt.h       |  5 --
>   arch/powerpc/platforms/pseries/Kconfig       |  1 +
>   arch/powerpc/platforms/pseries/Makefile      |  2 +
>   arch/powerpc/platforms/pseries/cc_platform.c | 26 ++++++
>   arch/powerpc/platforms/pseries/svm.c         |  5 +-
>   arch/s390/include/asm/mem_encrypt.h          |  2 -
>   arch/x86/Kconfig                             |  1 +
>   arch/x86/include/asm/io.h                    |  8 ++
>   arch/x86/include/asm/kexec.h                 |  2 +-
>   arch/x86/include/asm/mem_encrypt.h           | 12 +--
>   arch/x86/kernel/Makefile                     |  6 ++
>   arch/x86/kernel/cc_platform.c                | 69 +++++++++++++++
>   arch/x86/kernel/crash_dump_64.c              |  4 +-
>   arch/x86/kernel/head64.c                     |  9 +-
>   arch/x86/kernel/kvm.c                        |  3 +-
>   arch/x86/kernel/kvmclock.c                   |  4 +-
>   arch/x86/kernel/machine_kexec_64.c           | 19 +++--
>   arch/x86/kernel/pci-swiotlb.c                |  9 +-
>   arch/x86/kernel/relocate_kernel_64.S         |  2 +-
>   arch/x86/kernel/sev.c                        |  6 +-
>   arch/x86/kvm/svm/svm.c                       |  3 +-
>   arch/x86/mm/ioremap.c                        | 18 ++--
>   arch/x86/mm/mem_encrypt.c                    | 55 ++++--------
>   arch/x86/mm/mem_encrypt_identity.c           |  9 +-
>   arch/x86/mm/pat/set_memory.c                 |  3 +-
>   arch/x86/platform/efi/efi_64.c               |  9 +-
>   arch/x86/realmode/init.c                     |  8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  4 +-
>   drivers/gpu/drm/drm_cache.c                  |  4 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.c          |  4 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_msg.c          |  6 +-
>   drivers/iommu/amd/init.c                     |  7 +-
>   drivers/iommu/amd/iommu.c                    |  3 +-
>   drivers/iommu/amd/iommu_v2.c                 |  3 +-
>   drivers/iommu/iommu.c                        |  3 +-
>   fs/proc/vmcore.c                             |  6 +-
>   include/linux/cc_platform.h                  | 88 ++++++++++++++++++++
>   include/linux/mem_encrypt.h                  |  4 -
>   kernel/dma/swiotlb.c                         |  4 +-
>   40 files changed, 310 insertions(+), 129 deletions(-)
>   create mode 100644 arch/powerpc/platforms/pseries/cc_platform.c
>   create mode 100644 arch/x86/kernel/cc_platform.c
>   create mode 100644 include/linux/cc_platform.h
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

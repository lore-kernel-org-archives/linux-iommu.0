Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9781BC432BE
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 10:37:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5254260FA0
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 10:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5254260FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1268F83A58;
	Mon,  2 Aug 2021 10:37:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4vVcX4vFkxf0; Mon,  2 Aug 2021 10:37:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F19A7839E4;
	Mon,  2 Aug 2021 10:37:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3C9EC001B;
	Mon,  2 Aug 2021 10:37:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5396CC000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 10:37:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42A9083A58
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 10:37:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ADfmSe9WJyUr for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 10:37:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E5D8839E4
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 10:37:50 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 8B4F89A6; Mon,  2 Aug 2021 12:37:48 +0200 (CEST)
Date: Mon, 2 Aug 2021 12:37:45 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 04/11] x86/sme: Replace occurrences of sme_active() with
 prot_guest_has()
Message-ID: <YQfK+cXK+hLW2T0c@8bytes.org>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <1a5604f8fb84702f4ae0787428356d7e3e1d3a99.1627424774.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1a5604f8fb84702f4ae0787428356d7e3e1d3a99.1627424774.git.thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
 amd-gfx@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
 linux-graphics-maintainer@vmware.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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

On Tue, Jul 27, 2021 at 05:26:07PM -0500, Tom Lendacky wrote:
> Replace occurrences of sme_active() with the more generic prot_guest_has()
> using PATTR_HOST_MEM_ENCRYPT, except for in arch/x86/mm/mem_encrypt*.c
> where PATTR_SME will be used. If future support is added for other memory
> encryption technologies, the use of PATTR_HOST_MEM_ENCRYPT can be
> updated, as required, to use PATTR_SME.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Joerg Roedel <jroedel@suse.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

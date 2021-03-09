Return-Path: <SRS0=6QSB=IH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E5BC433E6
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 08:58:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6206186A
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 08:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6206186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2BF7F40178;
	Tue,  9 Mar 2021 08:58:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NLxvB2sVcnk9; Tue,  9 Mar 2021 08:58:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0C7F6400E1;
	Tue,  9 Mar 2021 08:58:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D827CC000A;
	Tue,  9 Mar 2021 08:58:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5278FC0001
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 08:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2BE8342C9F
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 08:58:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nmBHMoPYfxkj for <iommu@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 08:58:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EEBBD40170
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 08:58:54 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 554C764F8E
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 08:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615280334;
 bh=bGrgYHxt1zWRljmNWdTWF89KwQPE/WC7bjxroFUZJHs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=MDRPXWtVs3yMMI2osLWEdRXy9xiKGo9kAp4Cdr1VTzeHhbW/HPaPLJLaeX4AuzpZo
 zAc5ZHRcWCHSVB1NPZOowwzzf2l7TZ7yILtMOO44xoq3OSCSiQGv5XBjtqEu7XOtpa
 R11yFXYTUKGXauoGArGgeBKSPTEHU+mG0b1dyDTGqRRGjD12JLZW24sYpgULzT3x9X
 yfxFvPRwtbz6TAd/snAQtmYm5WNPDougT6CuJYx9K++8A9Q+7tw6b6EL4GZBzKG9oq
 i/7crnr+2//TOewdvwSDZxPApDyeCmEMil4R16x7Z7X0NUOVIO2BZMM7pp5neNQfBa
 mgoSQmGX1TDAw==
Received: by mail-oi1-f175.google.com with SMTP id z126so14155192oiz.6
 for <iommu@lists.linux-foundation.org>; Tue, 09 Mar 2021 00:58:54 -0800 (PST)
X-Gm-Message-State: AOAM531aEigUMCL5l37wSW+7xvuzSurKDhqqISUJE3zDAlNGV3CYGaVY
 iEFJ8NFRVrZ2o8U+q4ZKkfvTIVI/cRUBfl0g3C4=
X-Google-Smtp-Source: ABdhPJy7KwmLHvhrNLftroGyUGQ/t+PND67LUPNySsQX0tVy70CsU1/qFEJEzMXrNv8DMLGhBPueB6t1Sz6S4o59CIs=
X-Received: by 2002:aca:bf44:: with SMTP id p65mr1097765oif.11.1615280333519; 
 Tue, 09 Mar 2021 00:58:53 -0800 (PST)
MIME-Version: 1.0
References: <4c692eff-9d57-278e-8da4-36bc2c293506@amd.com>
 <20210309032356.20800-1-Felix.Kuehling@amd.com>
In-Reply-To: <20210309032356.20800-1-Felix.Kuehling@amd.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 9 Mar 2021 09:58:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1EeHimbufajcHzV+-bBarWtLHzzFSsa=qdUDsip=Wz_A@mail.gmail.com>
Message-ID: <CAK8P3a1EeHimbufajcHzV+-bBarWtLHzzFSsa=qdUDsip=Wz_A@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdkfd: fix build error with AMD_IOMMU_V2=m
To: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Will Deacon <will@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Tue, Mar 9, 2021 at 4:23 AM Felix Kuehling <Felix.Kuehling@amd.com> wrote:
>
> Using 'imply AMD_IOMMU_V2' does not guarantee that the driver can link
> against the exported functions. If the GPU driver is built-in but the
> IOMMU driver is a loadable module, the kfd_iommu.c file is indeed
> built but does not work:
>
> x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_bind_process_to_device':
> kfd_iommu.c:(.text+0x516): undefined reference to `amd_iommu_bind_pasid'
> x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_unbind_process':
> kfd_iommu.c:(.text+0x691): undefined reference to `amd_iommu_unbind_pasid'
> x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_suspend':
> kfd_iommu.c:(.text+0x966): undefined reference to `amd_iommu_set_invalidate_ctx_cb'
> x86_64-linux-ld: kfd_iommu.c:(.text+0x97f): undefined reference to `amd_iommu_set_invalid_ppr_cb'
> x86_64-linux-ld: kfd_iommu.c:(.text+0x9a4): undefined reference to `amd_iommu_free_device'
> x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_resume':
> kfd_iommu.c:(.text+0xa9a): undefined reference to `amd_iommu_init_device'
> x86_64-linux-ld: kfd_iommu.c:(.text+0xadc): undefined reference to `amd_iommu_set_invalidate_ctx_cb'
> x86_64-linux-ld: kfd_iommu.c:(.text+0xaff): undefined reference to `amd_iommu_set_invalid_ppr_cb'
> x86_64-linux-ld: kfd_iommu.c:(.text+0xc72): undefined reference to `amd_iommu_bind_pasid'
> x86_64-linux-ld: kfd_iommu.c:(.text+0xe08): undefined reference to `amd_iommu_set_invalidate_ctx_cb'
> x86_64-linux-ld: kfd_iommu.c:(.text+0xe26): undefined reference to `amd_iommu_set_invalid_ppr_cb'
> x86_64-linux-ld: kfd_iommu.c:(.text+0xe42): undefined reference to `amd_iommu_free_device'
>
> Use IS_REACHABLE to only build IOMMU-V2 support if the amd_iommu symbols
> are reachable by the amdkfd driver. Output a warning if they are not,
> because that may not be what the user was expecting.

This would fix the compile-time failure, but it still fails my CI
because you introduce
a compile-time warning. Can you change it into a runtime warning instead?

Neither type of warning is likely to actually reach the person trying
to debug the
problem, so you still end up with machines that don't do what they should,
but I can live with the runtime warning as long as the build doesn't break.

I think the proper fix would be to not rely on custom hooks into a particular
IOMMU driver, but to instead ensure that the amdgpu driver can do everything
it needs through the regular linux/iommu.h interfaces. I realize this
is more work,
but I wonder if you've tried that, and why it didn't work out.

       Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

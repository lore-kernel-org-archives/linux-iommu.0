Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96648C433F5
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 22:10:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4809861A4F
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 22:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4809861A4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19DB761465;
	Thu, 30 Sep 2021 22:10:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wq_xW9dReMCA; Thu, 30 Sep 2021 22:10:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EA8D8613FD;
	Thu, 30 Sep 2021 22:10:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D270C000F;
	Thu, 30 Sep 2021 22:10:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 060F6C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 22:10:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7BF54030A
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 22:10:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ltw3CLsNm_DW for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 22:10:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76C9240302
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 22:10:48 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 965D361390;
 Thu, 30 Sep 2021 22:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633039847;
 bh=IwzBemW+hy1M1ewr7atFO0cSMjKx7nF1iOUj3EQWXE8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VMFkm4a+fgdg4zYaCkaWnSOTeOZ8uAbKkitUxM0+m4BBfXT2b5oLMM7rDTLawyLAE
 NhhBOznSRQz5yRbiTNsvbV6E0IU3T5qz407KpFRCdUtW5hyDqK4d2pDAOMg4JRadt6
 KWrjYIXEm0KrNBVtP+JPzhB2VrG3+5vrqbM5hiSfUBy+07gwCIoejO0uW/sH7DYI6V
 pgwC0QydyQR/hM9nqnvQyR6gIiVBVoszYMQd2xY8yoPecdNAhtt2AC8GtVh+C0O4VI
 bPLArmwwdAbQbiLreQFVTZM6xuVy7lVHSRkS66W+8O7Twsm9hTlzsCUC2ioP79rEse
 MlAOzYU2R7N3A==
Date: Thu, 30 Sep 2021 15:10:46 -0700
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/6] memblock: cleanup memblock_free interface
Message-ID: <YVY15nd56j8x8udh@kernel.org>
References: <20210930185031.18648-1-rppt@kernel.org>
 <CAHk-=wjS76My8aJLWJAHd-5GnMEVC1D+kV7DgtV9GjcbtqZdig@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wjS76My8aJLWJAHd-5GnMEVC1D+kV7DgtV9GjcbtqZdig@mail.gmail.com>
Cc: linux-efi <linux-efi@vger.kernel.org>, KVM list <kvm@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, kasan-dev <kasan-dev@googlegroups.com>,
 linux-sparc <sparclinux@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Mike Rapoport <rppt@linux.ibm.com>, xen-devel@lists.xenproject.org,
 "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
 devicetree <devicetree@vger.kernel.org>,
 linux-um <linux-um@lists.infradead.org>,
 Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Juergen Gross <jgross@suse.com>, linux-usb@vger.kernel.org,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, alpha <linux-alpha@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

On Thu, Sep 30, 2021 at 02:20:33PM -0700, Linus Torvalds wrote:
> On Thu, Sep 30, 2021 at 11:50 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > The first patch is a cleanup of numa_distance allocation in arch_numa I've
> > spotted during the conversion.
> > The second patch is a fix for Xen memory freeing on some of the error
> > paths.
> 
> Well, at least patch 2 looks like something that should go into 5.15
> and be marked for stable.
> 
> Patch 1 looks like a trivial local cleanup, and could go in
> immediately. Patch 4 might be in that same category.
> 
> The rest look like "next merge window" to me, since they are spread
> out and neither bugfixes nor tiny localized cleanups (iow renaming
> functions, global resulting search-and-replace things).
> 
> So my gut feel is that two (maybe three) of these patches should go in
> asap, with three (maybe four) be left for 5.16.
> 
> IOW, not trat this as a single series.
> 
> Hmm?

Yes, why not :)
I'd keep patch 4 for the next merge window, does not look urgent to me.

Andrew, can you please take care of this or you'd prefer me resending
everything separately?
 
>              Linus

-- 
Sincerely yours,
Mike.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

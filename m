Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D593C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 12:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2750840878;
	Tue,  7 Jun 2022 12:34:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GRGsz-xT4hhb; Tue,  7 Jun 2022 12:34:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A5E5C400D2;
	Tue,  7 Jun 2022 12:34:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74AB3C0032;
	Tue,  7 Jun 2022 12:34:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83E6FC002D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 12:34:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8060B60F43
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 12:34:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ellerman.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cAzxBuct4st7 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 12:34:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DB1860F3E
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 12:34:09 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4LHVCQ55dqz4xD5;
 Tue,  7 Jun 2022 22:33:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1654605238;
 bh=xsqLotJgLRyhHSsJOogHV2acGAb2fC5jAOSFmHOIGA8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=CyKzGazU3+2K8KiXkFolMw7JQl3fOZLWg6z5Qa5Pu4HecLtJDYCw5wZXMKOpJGtNH
 ls59IpcNb+xkojsRvHCc4fWQ+jCa6EIATKhLPnYyeuNIQ3bM/kCbodmjHfgOjgkZkS
 4h1lW8cbZe+o+0DbG3jBJCA91u30ggP5RKfw27leNpg5nQnN6glbcE5esgg3QrVgMC
 F6vtgSRCeacrQYA+phjt3HatLp44B4mYcMY4ThklAxFfrqM77MDq/rb5P0zDTt02T0
 PGQo6ASa5inpNApELNIR+n6jSj0aWCgLFiNBXcmQyCK7Xw/Luq/s+wYpHBJDE3Ehpr
 xujYS3Qf+FLTQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 6/6] arch/*/: remove CONFIG_VIRT_TO_BUS
In-Reply-To: <20220606084109.4108188-7-arnd@kernel.org>
References: <20220606084109.4108188-1-arnd@kernel.org>
 <20220606084109.4108188-7-arnd@kernel.org>
Date: Tue, 07 Jun 2022 22:33:49 +1000
Message-ID: <87y1y8tzyq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-scsi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Martyn Welch <martyn@welchs.me.uk>, Manohar Vanga <manohar.vanga@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Denis Efremov <efremov@linux.com>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Khalid Aziz <khalid@gonehiking.org>,
 Robin Murphy <robin.murphy@arm.com>
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

Arnd Bergmann <arnd@kernel.org> writes:
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index be68c1f02b79..48e1aa0536b6 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -277,7 +277,6 @@ config PPC
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
>  	select TRACE_IRQFLAGS_SUPPORT
> -	select VIRT_TO_BUS			if !PPC64
>  	#
>  	# Please keep this list sorted alphabetically.
>  	#

> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index c5a5f7c9b231..73fcd5cdb662 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -985,8 +985,6 @@ static inline void * bus_to_virt(unsigned long address)
>  }
>  #define bus_to_virt bus_to_virt
>  
> -#define page_to_bus(page)	(page_to_phys(page) + PCI_DRAM_OFFSET)
> -
>  #endif /* CONFIG_PPC32 */
  
Seems that's not used by any drivers, so fine to remove.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

Return-Path: <SRS0=TkeE=TO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E424EC04AB7
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:27:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B6621473
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1laPt4Yc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B6621473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9E964D97;
	Tue, 14 May 2019 14:27:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7F6345AA
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:27:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 28FD882C
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209;
	h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eNvhEe3BMTRaZ1fLMuDOKnrgYFbmEX60UqHNIxHZPnQ=;
	b=1laPt4YcsSByydA6OAeBTkdoPG
	GEisQedgcPbnTOnE5ITOdPgGqPKli8Fm3YkUxv1tV8/brlnLK2OkiCxHxD9S6n74I227kkS5b4KOS
	29QCup7DP9WooAOpTON1XnmqTFEazMGg/3uaC5Bi00d2r4I2G9XX9yNqSCL85MdCWGggxMFleqlge
	mU/pJXFircxoc2K4v3FLEXZyCWpxNLlx/fHs/NrNOYBvG+naStYkxQes3ysF+2hE1KPcQ7jLzJKQh
	8nJiJvZS4WAV3JAYWzDN1dVSR10p7E51BUWAMoR725GoJ4m95xyaUoay2f9G7322GHH+96j1vLU8W
	tNUbutLQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16]
	helo=midway.dunlab)
	by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hQYOS-0008LC-RO; Tue, 14 May 2019 14:27:01 +0000
Subject: Re: [RFC PATCH v3 11/21] x86/watchdog/hardlockup: Add an HPET-based
	hardlockup detector
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@suse.de>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1557842534-4266-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <62576937-50fc-fded-784b-d691e455dfc1@infradead.org>
Date: Tue, 14 May 2019 07:26:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557842534-4266-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
Content-Language: en-US
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Ricardo Neri <ricardo.neri@intel.com>, Mimi Zohar <zohar@linux.ibm.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ashok Raj <ashok.raj@intel.com>, x86@kernel.org,
	Andi Kleen <andi.kleen@intel.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Stephane Eranian <eranian@google.com>,
	Tony Luck <tony.luck@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Nayna Jain <nayna@linux.ibm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 5/14/19 7:02 AM, Ricardo Neri wrote:
> diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
> index 15d0fbe27872..376a5db81aec 100644
> --- a/arch/x86/Kconfig.debug
> +++ b/arch/x86/Kconfig.debug
> @@ -169,6 +169,17 @@ config IOMMU_LEAK
>  config HAVE_MMIOTRACE_SUPPORT
>  	def_bool y
>  
> +config X86_HARDLOCKUP_DETECTOR_HPET
> +	bool "Use HPET Timer for Hard Lockup Detection"
> +	select SOFTLOCKUP_DETECTOR
> +	select HARDLOCKUP_DETECTOR
> +	select HARDLOCKUP_DETECTOR_CORE
> +	depends on HPET_TIMER && HPET && X86_64
> +	help
> +	  Say y to enable a hardlockup detector that is driven by an High-

	                                                       by a

> +	  Precision Event Timer. This option is helpful to not use counters
> +	  from the Performance Monitoring Unit to drive the detector.
> +
>  config X86_DECODER_SELFTEST
>  	bool "x86 instruction decoder selftest"
>  	depends on DEBUG_KERNEL && KPROBES


-- 
~Randy
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

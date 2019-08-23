Return-Path: <SRS0=APMu=WT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54880C3A5A4
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 22:10:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E832133F
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 22:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9Cpyf2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E832133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 106EEDC0;
	Fri, 23 Aug 2019 22:10:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D2735DB9
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 22:09:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 216217FB
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 22:09:58 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id q139so7344934pfc.13
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 15:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=uVhXsajOF/KCvOZ+NXz04+7vR3jmhllE/wdYxY8tOKI=;
	b=Z9Cpyf2nbbjicXl9Mzx1X0g0MCXjlfihbqE8WK/zetN/vOu8UpGIZN9zdw9MN+RoJZ
	wC+JpZyN+ZGwzaYsCycz0iuz2/VEjzb339izeBbzG+z68o9P+rOJv9Wa6hNbOuWXtgz/
	FsVPUU6Uqg0HdaP8v55+TS4c/A1uLdU9Lu93o66NcqJJfpgyrR8bsCrg3ITBsRPFS378
	cr5NChTHTFSJRLSRD9/DTsipjqDixciNTgjoc52B3qTcyrKStVkbouIfdX8c+QrRuqlc
	tzgFHW6n93aorp4HOBaDwgAvd4gJ8Qx1kwOPFA1b5I7Oi41Kt0vd8IE+B6yT3EnamOIW
	5Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=uVhXsajOF/KCvOZ+NXz04+7vR3jmhllE/wdYxY8tOKI=;
	b=lEx/Ye222KFH9ZfThI0MwpPh1o9jPE/ZeM4mC2tHOrsA6vIHdo1UjPUqpHxsKOFGCV
	0XbZzqeM7flOMC9gPLTyYTGEIK01WgRpKUlsFA6aqE4itBY+JyFqfHwCaUG2ER74VJBw
	yyGQpYVYjjvT1ZwRiRjWYrCyPs+rQlxcaUGBVUSyFqSeZz3hXA3UKm/qlfl3U4PFTUF0
	d6Jt2d8ESJIoGrDnHYD2t0PlpkZq6hB9d0X92EV1mzinwr8w+llbgZrMopI0olY+57vz
	kg2c8T832JByOW9CV0/41YTVGeT/0WWTlrCYA6+J2Fu5ogybCGWSw8QyXYHF7YsS7wG6
	PsUQ==
X-Gm-Message-State: APjAAAWMD6Gb4hzB/iC1Jq8als1X1cLPBpf3ynv2zzpFec6xTDr1nd4g
	2YUAmt29wJWLgQk51WdsJbk=
X-Google-Smtp-Source: APXvYqzzM/Guz05FYOq/kgxZTfBhn2/vpiPj+XvyXIGf5JR5RdF9Y750BQvvFgKlO+zwtlHgi7cAUw==
X-Received: by 2002:a63:d315:: with SMTP id b21mr5997142pgg.326.1566598197424; 
	Fri, 23 Aug 2019 15:09:57 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	t4sm4039567pfd.109.2019.08.23.15.09.56
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 23 Aug 2019 15:09:57 -0700 (PDT)
Date: Fri, 23 Aug 2019 15:11:04 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 2/2] dma-contiguous: Use fallback alloc_pages for
	single pages
Message-ID: <20190823221103.GA3604@Asurada-Nvidia.nvidia.com>
References: <20190506223334.1834-1-nicoleotsuka@gmail.com>
	<20190506223334.1834-3-nicoleotsuka@gmail.com>
	<CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Christoph Hellwig <hch@lst.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Russell King <linux@armlinux.org.uk>, Thierry Reding <treding@nvidia.com>,
	linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Chris Zankel <chris@zankel.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org, iamjoonsoo.kim@lge.com,
	David Woodhouse <dwmw2@infradead.org>
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

On Fri, Aug 23, 2019 at 09:49:46PM +0900, Masahiro Yamada wrote:
> On Tue, May 7, 2019 at 7:36 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > The addresses within a single page are always contiguous, so it's
> > not so necessary to always allocate one single page from CMA area.
> > Since the CMA area has a limited predefined size of space, it may
> > run out of space in heavy use cases, where there might be quite a
> > lot CMA pages being allocated for single pages.
> >
> > However, there is also a concern that a device might care where a
> > page comes from -- it might expect the page from CMA area and act
> > differently if the page doesn't.
> >
> > This patch tries to use the fallback alloc_pages path, instead of
> > one-page size allocations from the global CMA area in case that a
> > device does not have its own CMA area. This'd save resources from
> > the CMA global area for more CMA allocations, and also reduce CMA
> > fragmentations resulted from trivial allocations.
> >
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> 
> 
> This commit (bd2e75633c8012fc8a7431c82fda66237133bf7e)
> broke the DMA for my MMC driver in the following way:
> 
> 
> 
> 
> [    1.876755] mmc0: ADMA error
> [    1.883385] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    1.889834] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
> [    1.896284] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000001
> [    1.902733] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> [    1.909182] mmc0: sdhci: Present:   0x01ff02f6 | Host ctl: 0x00000019
> [    1.915631] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000000
> [    1.922081] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07
> [    1.928530] mmc0: sdhci: Timeout:   0x0000000b | Int stat: 0x00000001
> [    1.934981] mmc0: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
> [    1.941429] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
> [    1.947880] mmc0: sdhci: Caps:      0x546ec800 | Caps_1:   0x00000000
> [    1.954329] mmc0: sdhci: Cmd:       0x0000083a | Max curr: 0x00000000
> [    1.960778] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
> [    1.967229] mmc0: sdhci: Resp[2]:   0x320f5903 | Resp[3]:  0x3fd05e00
> [    1.973678] mmc0: sdhci: Host ctl2: 0x00000000
> [    1.978125] mmc0: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x000000013965b200
> [    1.985271] mmc0: sdhci: ============================================
> [    1.991758] mmc0: error -5 whilst initialising MMC card
> [    1.991913] 43fb0000.uart: ttyS1 at MMIO 0x43fb0000 (irq = 0,
> base_baud = 768000) is a 16550A
> [    2.011011] hctosys: unable to open rtc device (rtc0)
> [    2.017694] Freeing unused kernel memory: 2368K
> [    2.027131] Run /init as init process
> Starting syslogd: OK
> Starting klogd: OK
> Initializing random number generator... [    2.074399] random: dd:
> uninitialized urandom read (512 bytes read)
> done.
> Starting network: OK
> [    2.109593] mmc0: ADMA error
> [    2.112488] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    2.118941] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
> [    2.125389] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000001
> [    2.131840] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> [    2.138289] mmc0: sdhci: Present:   0x01ff02f6 | Host ctl: 0x00000019
> [    2.144738] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000000
> [    2.151188] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00004e47
> [    2.157637] mmc0: sdhci: Timeout:   0x0000000b | Int stat: 0x00000001
> [    2.164087] mmc0: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
> [    2.170536] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
> [    2.176987] mmc0: sdhci: Caps:      0x546ec800 | Caps_1:   0x00000000
> [    2.183435] mmc0: sdhci: Cmd:       0x0000083a | Max curr: 0x00000000
> [    2.189886] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
> [    2.196335] mmc0: sdhci: Resp[2]:   0x320f5903 | Resp[3]:  0x3fd05e00
> [    2.202784] mmc0: sdhci: Host ctl2: 0x00000000
> [    2.207232] mmc0: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x000000013965b200
> [    2.214379] mmc0: sdhci: ============================================
> 
> [    2.220881] mmc0: error -5 whilst initialising MMC card
> Welcome to Buildroot
> buildroot login: [    2.332786] mmc0: ADMA error
> [    2.335668] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    2.342119] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
> [    2.348568] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000001
> [    2.355018] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> [    2.361468] mmc0: sdhci: Present:   0x01ff02f6 | Host ctl: 0x00000019
> [    2.367917] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000000
> [    2.374367] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000f447
> [    2.380816] mmc0: sdhci: Timeout:   0x0000000b | Int stat: 0x00000001
> [    2.387267] mmc0: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
> [    2.393716] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
> [    2.400166] mmc0: sdhci: Caps:      0x546ec800 | Caps_1:   0x00000000
> [    2.406615] mmc0: sdhci: Cmd:       0x0000083a | Max curr: 0x00000000
> [    2.413065] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
> [    2.419515] mmc0: sdhci: Resp[2]:   0x320f5903 | Resp[3]:  0x3fd05e00
> [    2.425963] mmc0: sdhci: Host ctl2: 0x00000000
> [    2.430412] mmc0: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x000000013965b200
> [    2.437557] mmc0: sdhci: ============================================
> [    2.444031] mmc0: error -5 whilst initialising MMC card
> [    2.572203] mmc0: ADMA error
> [    2.575089] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    2.581540] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
> [    2.587989] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000001
> [    2.594439] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> [    2.600889] mmc0: sdhci: Present:   0x01ef02f6 | Host ctl: 0x00000019
> [    2.607339] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000000
> [    2.613788] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000e8c7
> [    2.620237] mmc0: sdhci: Timeout:   0x0000000b | Int stat: 0x00000001
> [    2.626686] mmc0: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
> [    2.633137] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
> [    2.639586] mmc0: sdhci: Caps:      0x546ec800 | Caps_1:   0x00000000
> [    2.646036] mmc0: sdhci: Cmd:       0x0000083a | Max curr: 0x00000000
> [    2.652485] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
> [    2.658936] mmc0: sdhci: Resp[2]:   0x320f5903 | Resp[3]:  0x3fd05e00
> [    2.665384] mmc0: sdhci: Host ctl2: 0x00000000
> [    2.669832] mmc0: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x000000013965b200
> [    2.676979] mmc0: sdhci: ============================================
> [    2.683450] mmc0: error -5 whilst initialising MMC card
> 
> CTRL-A Z for help | 115200 8N1 | NOR | Minicom 2.7.1 | VT102 | Offline
> | ttyUSB0
> 
> Reverting this commit fixed the problem.

We are having another problem with the new API and Christoph
submitted a patch at: https://lkml.org/lkml/2019/8/20/86

Would it be possible for you to test to see if it can fix?

We can revert my fallback change after all, if Christoph's
patch doesn't work for you either.

Thanks
Nicolin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

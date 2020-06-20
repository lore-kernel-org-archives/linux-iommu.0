Return-Path: <SRS0=/9Qc=AB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362FFC433DF
	for <iommu@archiver.kernel.org>; Sat, 20 Jun 2020 20:09:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52F92468B
	for <iommu@archiver.kernel.org>; Sat, 20 Jun 2020 20:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp2Fr3N/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52F92468B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6B6DE87598;
	Sat, 20 Jun 2020 20:09:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BWdswLfOgGXJ; Sat, 20 Jun 2020 20:09:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C04CD87592;
	Sat, 20 Jun 2020 20:09:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB130C0178;
	Sat, 20 Jun 2020 20:09:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E9E3C016E
 for <iommu@lists.linux-foundation.org>; Sat, 20 Jun 2020 20:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2AAB285570
 for <iommu@lists.linux-foundation.org>; Sat, 20 Jun 2020 20:09:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tf5T1IyPdaBS for <iommu@lists.linux-foundation.org>;
 Sat, 20 Jun 2020 20:09:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3708B86CE7
 for <iommu@lists.linux-foundation.org>; Sat, 20 Jun 2020 20:09:38 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id u14so573718pjj.2
 for <iommu@lists.linux-foundation.org>; Sat, 20 Jun 2020 13:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=iRX0OPkrMjtIh+IZlLNQE9USdarPLnAiygVqscVAq+o=;
 b=Vp2Fr3N/AURy1KyePwnHI0cazWHmCk7MDLKFosyoUKWLEXQ4LrxbcX32Ph9y8jhALB
 O/eBIuUuZ0qmZKDed/riTNoDf3lzXfgcFJJIPsJX67XzFHWhQ8G7pJ2wh1zIsrrwEPM9
 CFNTTPMeFY4GYmC9ssoJPAG219oQ0sL245dKghz0ZtDTbatuov8erXjNsQmn382/QRB9
 Gf4dfP2cwRwmarUED3grIFRwO3XE5Cc2FMiQPLm9rnK5lzTeOVM/dZmCUhCsy3shikza
 gGGzSX7coIjsty7LdzyQm3k9ci3UJLghu9NnZ2PrsEZZ6s6qI3Nq7F1vjBzA892DhOss
 uLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=iRX0OPkrMjtIh+IZlLNQE9USdarPLnAiygVqscVAq+o=;
 b=hYR/l7Ht+zcRqPKksxsKQ34vwwAEjKoiXchvjZKur5k8EWEfzW+f4eOiUCnLFzg9wn
 dPsMisVqJwgfmbRJdbC9PWalB3bfcJo1CgQ4XKaw/++cYlQlUObaoZaHHID/tfgReE9H
 VUHcWUciut6wk+807W2QUHgC7XFWh15YdDJqiRG2jmgnTQZMdbp1LbVZRtlp2lxQSvRH
 7A+ChoFsbNeI/uyF4a/aibu3Ae+wXJw4c0JdBzqRTgxDioR3hJ1K4ndnXMJK2EhGWLJW
 1VtWYkSNDLD1eJ1jhH112DP+Jq7J7JoPaubbZS1bTy0k56rWAd7DSzz6nAns/kJvxOY1
 bPWQ==
X-Gm-Message-State: AOAM532yQtMZv5mHoMpsan/nNFNmOLXjZ15tWBFtVEWuLzeoImELVOOu
 jCqAV3T+6KTL5K1OY6yewIA=
X-Google-Smtp-Source: ABdhPJx2h6Q5/YN8i8jkpnFIy9lAv1yZIZuQJN/Gz8jrg5CMF1XcnAnB82QayyjUt0WXcyX+62s33g==
X-Received: by 2002:a17:902:8681:: with SMTP id
 g1mr13031314plo.161.1592683777739; 
 Sat, 20 Jun 2020 13:09:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id v9sm9376740pfe.198.2020.06.20.13.09.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 20 Jun 2020 13:09:37 -0700 (PDT)
Date: Sat, 20 Jun 2020 13:09:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
Message-ID: <20200620200936.GA106151@roeck-us.net>
References: <20200608132217.29945-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200608132217.29945-1-geert@linux-m68k.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Mon, Jun 08, 2020 at 03:22:17PM +0200, Geert Uytterhoeven wrote:
> On systems with at least 32 MiB, but less than 32 GiB of RAM, the DMA
> memory pools are much larger than intended (e.g. 2 MiB instead of 128
> KiB on a 256 MiB system).
> 
> Fix this by correcting the calculation of the number of GiBs of RAM in
> the system.  Invert the order of the min/max operations, to keep on
> calculating in pages until the last step, which aids readability.
> 
> Fixes: 1d659236fb43c4d2 ("dma-pool: scale the default DMA coherent pool size with memory capacity")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: David Rientjes <rientjes@google.com>

This patch results in a boot failure in some of my powerpc boot tests,
specifically those testing boots from mptsas1068 devices. Error message:

mptsas 0000:00:02.0: enabling device (0000 -> 0002)
mptbase: ioc0: Initiating bringup
ioc0: LSISAS1068 A0: Capabilities={Initiator}
mptbase: ioc0: ERROR - Unable to allocate Reply, Request, Chain Buffers!
mptbase: ioc0: ERROR - didn't initialize properly! (-3)
mptsas: probe of 0000:00:02.0 failed with error -3

Configuration is bamboo:44x/bamboo_defconfig plus various added drivers.
Qemu command line is

qemu-system-ppc -kernel vmlinux -M bamboo \
     -m 256 -no-reboot -snapshot -device mptsas1068,id=scsi \
     -device scsi-hd,bus=scsi.0,drive=d0,wwn=0x5000c50015ea71ac -drive \
     file=rootfs.ext2,format=raw,if=none,id=d0 \
     --append "panic=-1 slub_debug=FZPUA root=/dev/sda  mem=256M console=ttyS0" \
     -monitor none -nographic

canyonlands_defconfig with sam460ex machine and otherwise similar command line
fails as well.

Reverting this patch fixes the problem.

Guenter
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

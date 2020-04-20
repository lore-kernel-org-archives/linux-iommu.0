Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADB7C3A5A0
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 15:54:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F1620775
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 15:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa8CzRTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F1620775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1A11786D67;
	Mon, 20 Apr 2020 15:54:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6VsgJXpA7VMe; Mon, 20 Apr 2020 15:54:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6345E86D08;
	Mon, 20 Apr 2020 15:54:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46CA2C07FF;
	Mon, 20 Apr 2020 15:54:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FE9CC0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 15:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8490C20497
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 15:54:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QXE8M19S9S+x for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 15:54:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com
 [209.85.219.169])
 by silver.osuosl.org (Postfix) with ESMTPS id 7449A203F0
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 15:54:54 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id o139so5651613ybc.11
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=w3gwnOvN7lPW/9Irv4LBkALcZF5SMNb/5bjU+tsZvxI=;
 b=fa8CzRTLQUEzwwpZGicQ3mcterHo/a6XLZoquGPXJYLG6ZLNsMYMSO2W2fcKeoQCnT
 15Udr+Xp9R3yT8y0b2aEicCGMN6rZ63CpdYH1ByF5OLy8q0gMPVQ4vW/MBt2tgL5Clqm
 n29Z7jgAtNzTbgW8wyCndW/2NEjXuAWDmIQwKGHGUJS2xQlpewCx9Qgn6bImF1wPybjc
 c+AFQ+3SjWe2vaDp31Q8aGroKeyEYMk4r7H3jFTtEQwZ2i5SlvaiqfUk0/OoKN/Y+mXp
 6Wqx3HN3OI69MOI08FDqO/rEnz2uW2arXVYWZBa0ZUQ3eiSZw9j17CTeGhD6RrNcgUy1
 yoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=w3gwnOvN7lPW/9Irv4LBkALcZF5SMNb/5bjU+tsZvxI=;
 b=mHbnekQheE9MjQopcljqQopyKdS+S9wJ1TasxzXJktC1racKEb9uVJix2+39J9637W
 nm0NE9Bw61ve3894FSr+D7jGAfyLK4KyFCWdM3YNdb7ppkHlV3HHPQHwYy7FTwGei0E2
 nJM/N2/FI34n1GI9v21BZzL4Ie6x8h6/isSGlDUQv3+lAWGiaBW5xWIppijj34Tt2Fud
 1T8e40YRSd7cWvB+cu4ChkocMi24fMFa1gdmkTmaTdrPNL0YQ3gvIjPH0ObUpW3V4Djh
 9X9zqOYf5JNuNBr+z7523sqEczeGszp7gRUwzLDAiPoCh+JRC1xBckftqNzjnMpaj4mK
 lv3g==
X-Gm-Message-State: AGi0PuZq+tAxR9dD+ceMiPQxjw9NwPM+2JjII1lghrhPYRyrHQMQPnVq
 8ZA1P5yrGKBpY5Vu9vemQibn9lpK8Of4fmFhxD2g6fmN25Y=
X-Google-Smtp-Source: APiQypKDDO805xi8TiSZlqO9x9hUEm5golTh8A/BDNvQJ6FHCcDOCh2oQIIlSjh3jiULfSlE1egVQqSUzEGuoBgd+Ls=
X-Received: by 2002:a25:b294:: with SMTP id k20mr18170480ybj.394.1587398092987; 
 Mon, 20 Apr 2020 08:54:52 -0700 (PDT)
MIME-Version: 1.0
From: Ajay kumar <ajaynumb@gmail.com>
Date: Mon, 20 Apr 2020 21:24:40 +0530
Message-ID: <CAEC9eQOX9BHX4v5aY2cfCT=T-ZHA7y0xF7aiZhW9xzG4fme36Q@mail.gmail.com>
Subject: IOVA allocation dependency between firmware buffer and remaining
 buffers
To: iommu@lists.linux-foundation.org, 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-mm@kvack.org
Cc: shaik.ameer@samsung.com
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
Content-Type: multipart/mixed; boundary="===============2788016833087001729=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============2788016833087001729==
Content-Type: multipart/alternative; boundary="0000000000007321b805a3baebaf"

--0000000000007321b805a3baebaf
Content-Type: text/plain; charset="UTF-8"

Hi All,

I have an IOMMU master which has limitations as mentioned below:
1) The IOMMU master internally executes a firmware, and the firmware memory
is allocated by the same master driver.
The firmware buffer address should be of the lowest range than other address
allocated by the device, or in other words, all the remaining buffer
addresses
should always be in a higher range than the firmware address.
2) None of the buffer addresses should go beyond 0xC000_0000

example:
If firmware buffer address is buf_fw = 0x8000_5000;
All other addresses given to the device should be greater than
(0x8000_5000 + firmware size) and less than 0xC000_0000

Currently, this is being handled with one of the below hacks:
1) By keeping dma_mask in lower range while allocating firmware buffer,
and then increasing the dma_mask to higher range for other buffers.
2) By reserving IOVA for firmware at the lowest range and creating direct
mappings for the same.

I want to know if there is a better way this can be handled with current
framework, or if anybody is facing similar problems with their devices,
please share how it is taken care.

I also think there should be some way the masters can specify the IOVA
range they want to limit to for current allocation.
Something like a new iommu_ops callback like below:
limit_iova_alloc_range(dev, iova_start, iova_end)

And, in my driver, the sequence will be:
limit_iova_alloc_range(dev, 0x0000_0000, 0x1000_0000); /* via helpers */
alloc( ) firmware buffer using DMA API
limit_iova_alloc_range(dev, 0x1000_0000, 0xC000_0000); /* via helpers */
alloc( ) other buffers using DMA API

Thanks,
Ajay Kumar

--0000000000007321b805a3baebaf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hi All,<div><br></d=
iv><div>I have an IOMMU master which has limitations as mentioned below:</d=
iv><div>1) The IOMMU master internally executes a firmware, and the firmwar=
e memory</div><div>is allocated by the same master driver.</div><div>The fi=
rmware buffer address should be of the lowest range than other address</div=
><div>allocated by the device, or in other words, all the remaining buffer =
addresses</div><div>should=C2=A0always be in a higher range than the firmwa=
re address.</div><div>2) None of the buffer addresses should go beyond 0xC0=
00_0000</div><div><br></div><div>example:</div><div>If firmware buffer addr=
ess is buf_fw =3D 0x8000_5000;</div><div>All other addresses given to the d=
evice should be greater than</div><div>(0x8000_5000 + firmware size) and le=
ss than 0xC000_0000</div><div><br></div><div>Currently, this is being handl=
ed with one of the below hacks:</div><div>1) By keeping=C2=A0dma_mask in lo=
wer range while allocating firmware buffer,</div><div>and then increasing t=
he dma_mask to higher range for other buffers.</div><div>2) By reserving IO=
VA for firmware at the lowest range and creating direct mappings for the sa=
me.=C2=A0</div><div><br></div><div>I want to know if there is a better way =
this can be handled with current framework, or if anybody is facing similar=
 problems with their devices,</div><div>please share how it is taken care.<=
/div><div><br></div><div>I also think there should be some way the masters =
can specify the IOVA<br></div><div>range they want to limit to for current =
allocation.<br>Something like a new iommu_ops callback like below:</div><di=
v>limit_iova_alloc_range(dev, iova_start, iova_end)</div><div><br></div><di=
v>And, in my driver, the sequence will be:</div><div>limit_iova_alloc_range=
(dev, 0x0000_0000, 0x1000_0000); /* via helpers */<br></div><div>alloc( ) f=
irmware buffer using DMA API</div><div><div>limit_iova_alloc_range(dev, 0x1=
000_0000, 0xC000_0000); /* via helpers */<br></div><div>alloc( ) other buff=
ers using DMA API</div></div></div><div><br></div><div>Thanks,</div><div>Aj=
ay Kumar</div></div></div></div>

--0000000000007321b805a3baebaf--

--===============2788016833087001729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2788016833087001729==--

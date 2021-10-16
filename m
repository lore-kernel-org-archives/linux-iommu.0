Return-Path: <SRS0=DCF7=PE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528DDC433F5
	for <iommu@archiver.kernel.org>; Sat, 16 Oct 2021 05:58:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010E361101
	for <iommu@archiver.kernel.org>; Sat, 16 Oct 2021 05:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 010E361101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A289383BD5;
	Sat, 16 Oct 2021 05:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aB5Da3gPiD68; Sat, 16 Oct 2021 05:58:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 79E6883927;
	Sat, 16 Oct 2021 05:58:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 535C9C0011;
	Sat, 16 Oct 2021 05:58:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B181C000D
 for <iommu@lists.linux-foundation.org>; Sat, 16 Oct 2021 05:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 837654039C
 for <iommu@lists.linux-foundation.org>; Sat, 16 Oct 2021 05:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UbprnE-c5u8P for <iommu@lists.linux-foundation.org>;
 Sat, 16 Oct 2021 05:58:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D0FB040388
 for <iommu@lists.linux-foundation.org>; Sat, 16 Oct 2021 05:58:13 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 p6-20020a9d7446000000b0054e6bb223f3so532861otk.3
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 22:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=Q7FUP+N01v+YLqZsoSXz0aSSuxX3vj0T3Lusi7JvYUM=;
 b=QtCDIa8a38GYTygcyzrGAHO1AukOuIuGaYOshJOw1LDDce/dSzxPlU3bFg6tj/AZmY
 dXir1tm0PvUCzpAwiY273TXuGdTKz12J3719Z5/1a71EcVubzrpnASTdHUerBpcj06ME
 di1X2S9R+gnfxksHSWd/BYX6eVyz1HKZLW2Ot3joYoICMbEx8RAuV6kVj3zX0TX9ypda
 XtsPHCBfbEDR69tksjRsth9wyb0wSfAwJ3kFlj302EQLJ+ObNMcaJAIWeMfWh/EjxgiG
 ZzB+9FI3mdh76WAPhN6o0uFhkl58m8JDAbTV1Ca7/M6gxohiMS8mvdKGi/ZJDRjIcsce
 uYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=Q7FUP+N01v+YLqZsoSXz0aSSuxX3vj0T3Lusi7JvYUM=;
 b=k1mrcCaA40y7sI0ligxhzKNIFsXQ+5V+PuGquBm7KedYfxKTlKu1qTsI76EvUA7EhR
 UUFVUbYFLBo+pMTUbnx1GAdlgfIy/BYFk/ByNCnH0KWN9w0uwdBK6y1XsyGdU9vt/0F4
 wdHiJzer25DIfOSqHxVEvSauh+xbLv1ttZDRUiSv5TnfsIICy88ViSKEcdmEk5Sa+GEW
 FjKEqa3IgoxtK0Q+vcQKKhP9o/FwrbPl9AV1MR79C0SwT1g327SFSu+xL3BUTijB90jC
 GvYN3PN2UGdyZzsmFL6nK8Kua/msXRlKDOGJGqzu1F23/arGDnaMRNEUlEK10SQgQISq
 C5Xg==
X-Gm-Message-State: AOAM531Ja8OPjNFAP/86dHQuXBzfumDLDe8dN2NUxvQKYEEuxLUFfCTg
 r//aRqc+NOrQn9C2o9kY+a4Qzr1dgcd/SEj4d/w=
X-Google-Smtp-Source: ABdhPJzhhPes9335wRm9GCuDPQsm3GaZt/d2eYyLCJ3GT0NvRaiteuUtsgHXZb4x+GTn25FpkAJxLAVMv0Q2EelAex4=
X-Received: by 2002:a05:6830:438a:: with SMTP id
 s10mr11499091otv.173.1634363892845; 
 Fri, 15 Oct 2021 22:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHP4M8URVjPEGFLHFXk4iS-7FYpg_=ZCVr2f6ufcFkNnZqAUug@mail.gmail.com>
In-Reply-To: <CAHP4M8URVjPEGFLHFXk4iS-7FYpg_=ZCVr2f6ufcFkNnZqAUug@mail.gmail.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Sat, 16 Oct 2021 11:28:01 +0530
Message-ID: <CAHP4M8XVUwbJ+i8DeH0E5vOFY7zX2QnOsLTC7FGJGO2_aoUJiA@mail.gmail.com>
Subject: Re: Host-PCI-Device mapping
To: QEMU Developers <qemu-devel@nongnu.org>, iommu@lists.linux-foundation.org, 
 linux-pci@vger.kernel.org
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

Never mind, found the answers in kvm_set_user_memory :)

On Fri, Oct 15, 2021 at 9:36 PM Ajay Garg <ajaygargnsit@gmail.com> wrote:
>
> Hello everyone.
>
> I have a x86_64 L1 guest, running on a x86_64 host, with a
> host-pci-device attached to the guest.
> The host runs with IOMMU enabled, and passthrough enabled.
>
> Following are the addresses of the bar0-region of the pci-device, as
> per the output of lspci -v :
>
> * On host (hpa) => e2c20000
> * On guest (gpa) => fc078000
>
>
> Now, if /proc/<qemu-pid>/maps is dumped on the host, following line of
> interest is seen :
>
> #############################################################################
> 7f0b5c5f4000-7f0b5c5f5000 rw-s e2c20000 00:0e 13653
>   anon_inode:[vfio-device]
> #############################################################################
>
> Above indicates that the hva for the pci-device starts from 0x7f0b5c5f4000.
>
>
> Also, upon attaching gdb to the qemu process, and using a slightly
> modified qemugdb/mtree.py (that prints only the information for
> 0000:0a:00.0 name) to dump the memory-regions, following is obtained :
>
> #############################################################################
> (gdb) source qemu-gdb.py
> (gdb) qemu mtree
>     00000000fc078000-00000000fc07c095 0000:0a:00.0 base BAR 0 (I/O) (@
> 0x56540d8c8da0)
>       00000000fc078000-00000000fc07c095 0000:0a:00.0 BAR 0 (I/O) (@
> 0x56540d8c76b0)
>         00000000fc078000-00000000fc07c095 0000:0a:00.0 BAR 0 mmaps[0]
> (I/O) (@ 0x56540d8c7c30)
> (gdb)
> #############################################################################
>
> Above indicates that the hva for the pci-device starts from 0x56540d8c7c30.
>
> As seen, there is a discrepancy in the two results.
>
>
> What am I missing?
> Looking for pointers, will be grateful.
>
>
> Thanks and Regards,
> Ajay
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

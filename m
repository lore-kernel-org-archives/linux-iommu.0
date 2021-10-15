Return-Path: <SRS0=4al/=PD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9F4C433EF
	for <iommu@archiver.kernel.org>; Fri, 15 Oct 2021 16:06:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CFA611C3
	for <iommu@archiver.kernel.org>; Fri, 15 Oct 2021 16:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89CFA611C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56EED60AF6;
	Fri, 15 Oct 2021 16:06:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id suaH1WA2Y9rA; Fri, 15 Oct 2021 16:06:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5660360BBB;
	Fri, 15 Oct 2021 16:06:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3199EC000F;
	Fri, 15 Oct 2021 16:06:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D154C000D
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 16:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B0E8407FF
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 16:06:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DjA3vIkqP2AP for <iommu@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 16:06:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 81D9640623
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 16:06:44 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 62-20020a9d0a44000000b00552a6f8b804so12863077otg.13
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=I1hD65KZvsTUM11Z3+OFqcCldJ1PmlO0xyX0FqNo4g8=;
 b=l7XGJBtJWwSkDWFWzBueb4AOSdvZPd4CkJ2gDdb73FyZEMtgbjYfBINLTJu83ai4hT
 tajsKA8RLPGARMVv0m/Q1I3VOGvUPGjRJNixb/okrR20oTnyWPoGjITcAkKW4pG6s0q/
 zPtHNRSkFDmgBhGlFxfmcOb90crdFxjQ4/xmXZZFiZ2uu9VqpLYi7IXAl8BMc3OPwLHG
 TuwbXZENdhyAH6g2S2+XB9LvSLEkU/wWI02BHGXAzGL7/f9JJlnbl3EryOw1tMojjc2n
 G4LTqIpMCJ4CkTmBgcEMz16PS0TqEPdW5Z/2HDJTb1fdjgWQh1++6o2ABzCWEfNVmmqV
 YcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=I1hD65KZvsTUM11Z3+OFqcCldJ1PmlO0xyX0FqNo4g8=;
 b=GKl4Cv06XKXNejlwjr2aO0kY6R2NGZHhH0r9AkhUgUozxauHr9pXzk65ZNovtdrIzZ
 wiPU6vT30EohmstQvAe3zDDb3Luyw6jaSd899Xgurpql4U8B2KB5MKSmbR19VhDODdxU
 awaiqTnjebAP//dAew+jJ6zW1u8+usTGHcF9abpeB5UzEP9IuRPRQeJrcQhBAMYmzDsI
 7tfR09R7+y11IE7yBqC0dKM+wGFc6Ka9kAbuez2FttsadlzXPZZC9nDk5qxCMPfGfNBU
 GpboVUxB3hvtPwv92AbX2bXLdAyA/fx4UtDRMzR11v1xNrI6YEQ85TOLZbLpWrerRoxA
 OjYg==
X-Gm-Message-State: AOAM532TLDWCr1o/7zd3UKHsCBwJTwcBVF6lv1WSbQTFAAZj00+R/YN5
 KXFRqUY9hLBkOQ14EYsMvGEu88pQNhhRA1+m13g=
X-Google-Smtp-Source: ABdhPJw6yX5L5dezK5z0mmUW9dbMl86S6pg5jOzb/va4JUt41Rwc0U5zQOe0QKe2HobyCq8dSYvnArBjCiA5B7smi5w=
X-Received: by 2002:a05:6830:3148:: with SMTP id
 c8mr5714344ots.351.1634314003564; 
 Fri, 15 Oct 2021 09:06:43 -0700 (PDT)
MIME-Version: 1.0
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Fri, 15 Oct 2021 21:36:31 +0530
Message-ID: <CAHP4M8URVjPEGFLHFXk4iS-7FYpg_=ZCVr2f6ufcFkNnZqAUug@mail.gmail.com>
Subject: Host-PCI-Device mapping
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

Hello everyone.

I have a x86_64 L1 guest, running on a x86_64 host, with a
host-pci-device attached to the guest.
The host runs with IOMMU enabled, and passthrough enabled.

Following are the addresses of the bar0-region of the pci-device, as
per the output of lspci -v :

* On host (hpa) => e2c20000
* On guest (gpa) => fc078000


Now, if /proc/<qemu-pid>/maps is dumped on the host, following line of
interest is seen :

#############################################################################
7f0b5c5f4000-7f0b5c5f5000 rw-s e2c20000 00:0e 13653
  anon_inode:[vfio-device]
#############################################################################

Above indicates that the hva for the pci-device starts from 0x7f0b5c5f4000.


Also, upon attaching gdb to the qemu process, and using a slightly
modified qemugdb/mtree.py (that prints only the information for
0000:0a:00.0 name) to dump the memory-regions, following is obtained :

#############################################################################
(gdb) source qemu-gdb.py
(gdb) qemu mtree
    00000000fc078000-00000000fc07c095 0000:0a:00.0 base BAR 0 (I/O) (@
0x56540d8c8da0)
      00000000fc078000-00000000fc07c095 0000:0a:00.0 BAR 0 (I/O) (@
0x56540d8c76b0)
        00000000fc078000-00000000fc07c095 0000:0a:00.0 BAR 0 mmaps[0]
(I/O) (@ 0x56540d8c7c30)
(gdb)
#############################################################################

Above indicates that the hva for the pci-device starts from 0x56540d8c7c30.

As seen, there is a discrepancy in the two results.


What am I missing?
Looking for pointers, will be grateful.


Thanks and Regards,
Ajay
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

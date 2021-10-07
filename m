Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240E1C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 09:04:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C31610C8
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 09:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B2C31610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 818AF60F65;
	Thu,  7 Oct 2021 09:04:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KjFz7HLdJh-l; Thu,  7 Oct 2021 09:04:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 48D65605AC;
	Thu,  7 Oct 2021 09:04:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C2E3C0011;
	Thu,  7 Oct 2021 09:04:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61BA9C000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 09:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C2C9406C8
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 09:04:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yAl5TBgrOXWZ for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 09:04:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F8A640691
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 09:04:00 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id z11so8104576oih.1
 for <iommu@lists.linux-foundation.org>; Thu, 07 Oct 2021 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PAvueer9aMZMZvA0DKMfvJRj/glamcb5kqpTYRoRQhY=;
 b=lKlD+hr2jcOq+xfOQL+fH4N6Vj8osuEH96ZjBU2A2Kp7fJ7UZ3v8O/r2eeUhQkbxuW
 L0rg32EiIiAjO4rVIxjlpqlt6GKkq1d+szlwe5+cAEqI2w/zczgy9JzsCkXeBOlowsr7
 +8ypz2VNgviy+g/rz8kH8GrRf3eiuxkYnVi+pgEFh+TupL7v0jfwoIpcFWgy0MZYKRN9
 UA/GgRT/lE8se0E429zsIz1I+SAMp8ibWIOltL4tRg5hcBSZvohZK3o1XzuHQC0RogRQ
 CMo6T6um/QxBRpaWkNetoxN6mTxbGdeEn/dyAJ+vsowiYg1FmAdgf7Vykvifx92JjKwY
 Jruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PAvueer9aMZMZvA0DKMfvJRj/glamcb5kqpTYRoRQhY=;
 b=2vNd8YM+5mKt8I9EVfEK5v2A2/t/zOvCka/7Q91SZ93uQWivpqrQkdmNISER6arUxa
 UrKcBO4PeH6sKbLrc4/ymne1QXkjDeHVUQ4ls9zbhIy3zXhkDSD1Kma8fRCRh2M/w5fC
 3lzos/ukgvOjfSQ/3TvrUd7dfSXtH8v+9vAWu164yQ6vH4Rw64DoeykqqnjNJiugHeqp
 kufGivKibDhVJNr2SxfG4qm857Q6xLKZEkywmIIQMmloAkv2B+BKeQ6TQjrBwCv+szrD
 oNygSu1AKycGw64gdIRmJt66IZn5f/EU+ZqyDgOtzqv40LT6OPpRhtufI4+GTW1HdSXV
 UKLQ==
X-Gm-Message-State: AOAM5330tMXa+yb5Wdl1uTzy52ul4K8vqd1JUEBwk0QZBHF7xSTJw7D7
 YmE3gH7abTa4TAoaczOvfisdPcIFCwZRijryhs0=
X-Google-Smtp-Source: ABdhPJy2GrEsiJAKuVqIdJoO4A3ktMZrrc6cWXQ/zErXZkYIiF2eZA4ONUe7M1MJoqWmNIU8yzCFCf3lCmZX5W+8RvA=
X-Received: by 2002:a05:6808:1211:: with SMTP id
 a17mr2142069oil.91.1633597439475; 
 Thu, 07 Oct 2021 02:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211002124012.18186-1-ajaygargnsit@gmail.com>
 <b9afdade-b121-cc9e-ce85-6e4ff3724ed9@linux.intel.com>
 <CAHP4M8Us753hAeoXL7E-4d29rD9+FzUwAqU6gKNmgd8G0CaQQw@mail.gmail.com>
 <20211004163146.6b34936b.alex.williamson@redhat.com>
In-Reply-To: <20211004163146.6b34936b.alex.williamson@redhat.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Thu, 7 Oct 2021 14:33:47 +0530
Message-ID: <CAHP4M8UeGRSqHBV+wDPZ=TMYzio0wYzHPzq2Y+JCY0uzZgBkmA@mail.gmail.com>
Subject: Re: [PATCH] iommu: intel: remove flooding of non-error logs, when
 new-DMA-PTE is the same as old-DMA-PTE.
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org
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

Thanks Alex for the reply.


Lu, Alex :

I got my diagnosis regarding the host-driver wrong, my apologies.
There is no issue with the pci-device's host-driver (confirmed by
preventing the loading of host-driver at host-bootup). Thus, nothing
to be fixed at the host-driver side.

Rather seems some dma mapping/unmapping inconsistency is happening,
when kvm/qemu boots up with the pci-device attached to the guest.

I put up debug-logs in "vfio_iommu_type1_ioctl" method in
"vfio_iommu_type1.c" (on the host-machine).
When the guest boots up, repeated DMA-mappings are observed for the
same address as per the host-machine's logs (without a corresponding
DMA-unmapping first) :

##########################################################################################
ajay@ajay-Latitude-E6320:~$ tail -f /var/log/syslog | grep "ajay: "
Oct  7 14:12:32 ajay-Latitude-E6320 kernel: [  146.202297] ajay:
_MAP_DMA for [0x7ffe724a8670] status [0]
Oct  7 14:12:32 ajay-Latitude-E6320 kernel: [  146.583179] ajay:
_MAP_DMA for [0x7ffe724a8670] status [0]
Oct  7 14:12:32 ajay-Latitude-E6320 kernel: [  146.583253] ajay:
_MAP_DMA for [0x7ffe724a8670] status [0]
Oct  7 14:12:36 ajay-Latitude-E6320 kernel: [  150.105584] ajay:
_MAP_DMA for [0x7ffe724a8670] status [0]
Oct  7 14:13:07 ajay-Latitude-E6320 kernel: [  180.986499] ajay:
_UNMAP_DMA for [0x7ffe724a9840] status [0]
Oct  7 14:13:07 ajay-Latitude-E6320 kernel: [  180.986559] ajay:
_MAP_DMA for [0x7ffe724a97d0] status [0]
Oct  7 14:13:07 ajay-Latitude-E6320 kernel: [  180.986638] ajay:
_MAP_DMA for [0x7ffe724a97d0] status [0]
Oct  7 14:13:07 ajay-Latitude-E6320 kernel: [  181.087359] ajay:
_MAP_DMA for [0x7ffe724a97d0] status [0]
Oct  7 14:13:13 ajay-Latitude-E6320 kernel: [  187.271232] ajay:
_UNMAP_DMA for [0x7fde7b7fcfa0] status [0]
Oct  7 14:13:13 ajay-Latitude-E6320 kernel: [  187.271320] ajay:
_UNMAP_DMA for [0x7fde7b7fcfa0] status [0]
....
##########################################################################################


I'll try and backtrack to the userspace process that is sending these ioctls.


Thanks and Regards,
Ajay






On Tue, Oct 5, 2021 at 4:01 AM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Sat, 2 Oct 2021 22:48:24 +0530
> Ajay Garg <ajaygargnsit@gmail.com> wrote:
>
> > Thanks Lu for the reply.
> >
> > >
> > > Isn't the domain should be switched from a default domain to an
> > > unmanaged domain when the device is assigned to the guest?
> > >
> > > Even you want to r-setup the same mappings, you need to un-map all
> > > existing mappings, right?
> > >
> >
> > Hmm, I guess that's a (design) decision the KVM/QEMU/VFIO communities
> > need to take.
> > May be the patch could suppress the flooding till then?
>
> No, this is wrong.  The pte values should not exist, it doesn't matter
> that they're the same.  Is the host driver failing to remove mappings
> and somehow they persist in the new vfio owned domain?  There's
> definitely a bug beyond logging going on here.  Thanks,
>
> Alex
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

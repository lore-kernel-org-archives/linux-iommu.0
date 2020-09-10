Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BB1C07548
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 10:25:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A626206BE
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 10:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoSxMilj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A626206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 39C2F870B3;
	Thu, 10 Sep 2020 10:25:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vM0VgNZdAaNU; Thu, 10 Sep 2020 10:25:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 40B3087046;
	Thu, 10 Sep 2020 10:25:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 208E6C0894;
	Thu, 10 Sep 2020 10:25:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 873FDC0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 09:24:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6C55A875AD
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 09:24:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sOSd1Isn3MUV for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 09:24:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 89193866BA
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 09:24:37 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id u6so6291280iow.9
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 02:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UyqGiyvWtrvEPIbfLtgakvWHIPcO7f2wwjJnMPORWG0=;
 b=BoSxMiljYiAjMP/XBn/hYGNVKL/oHxnqnEUJ7qSdwoJLG0pxR2qK3V4/fkUTSaV51s
 3pvr292/IyS8ps68VC6dxn72XHdiWpnrMVrw8xogJTOMYamirEZ059PvshX7H4Z5GWuh
 Vr7j8283bIhfaNsK7sxUGLf6s0Z2Efi6Yl4vefoBSqVlIDK265aYxjjSjS69bDYpqbGV
 /GSb5UhzJJFq63scKHt5GhqSRkybY6g2zuA571aN2zohyHumpin0aZgpFfaeOPy0WbSg
 Mpw6iHtgik0cTA/OjEeiGwKuBqjHR2p7i1mxyZ7WrSW4CGvjjQTt8jjc//sWyeGDOFMK
 9KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UyqGiyvWtrvEPIbfLtgakvWHIPcO7f2wwjJnMPORWG0=;
 b=GTcnyiUBpSuN5TaRGGcOGxjYMV0SjYIOCA1tG7gtAe/FZND+L9yX9xGEh+pf+ADckG
 tqWhMDOO7FSyGAhEBFCaJSc7if3/oXgMfimDtkZPD5QxM4aEoRlEN4U/DZ5H0scSuUnF
 GO68idh4RlUPCxuSaIISnIoCbvUJxS7lHPt1y7G+npaWxkAcCCopeeapZ+EVl8rJG5BM
 lvN5S2PaTM7Bh459HcNMhvolcDCHdyxiOVRULOgc4WtiJTd22JLej4yi3fjrKBZznhzi
 KhG+RnULJdHWKmwuSClyjemHg4Mr1awDuObSQx89pIaq2UVeiiy20USJLIHOkfU6zcu4
 rslg==
X-Gm-Message-State: AOAM530S/ienwj1gFqj1k2iVlmfo5CQbrfGVpbJ9AoVZGmkLQUJpPC4U
 MtPLjdvk6L2nh0UM7amKfMcuJoyhZhEKZX1lb/A=
X-Google-Smtp-Source: ABdhPJzJ/LFpexv9kLm1kjwc0/B+7GHCOB8WQagf03Hz+gzhVFwgLWrpkGefOcCCEeSFlcKtCwndocR5oDNlZlvNymM=
X-Received: by 2002:a5d:8846:: with SMTP id t6mr7056972ios.123.1599729876856; 
 Thu, 10 Sep 2020 02:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <e6387578c75736d61b2fe70d9783d91329a97eb4.camel@perches.com>
In-Reply-To: <e6387578c75736d61b2fe70d9783d91329a97eb4.camel@perches.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 10 Sep 2020 11:24:26 +0200
Message-ID: <CAOi1vP-v77pj3G5Ez94CDYVs2jSO828c4uV_wzNi6sRKp=Yvyg@mail.gmail.com>
Subject: Re: [trivial PATCH] treewide: Convert switch/case fallthrough;
 to break; 
To: Joe Perches <joe@perches.com>
X-Mailman-Approved-At: Thu, 10 Sep 2020 10:25:37 +0000
Cc: linux-wireless@vger.kernel.org, linux-fbdev@vger.kernel.org,
 oss-drivers@netronome.com, nouveau@lists.freedesktop.org,
 alsa-devel <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org,
 linux-mips@vger.kernel.org, linux-ide@vger.kernel.org, dm-devel@redhat.com,
 linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org,
 sparclinux@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-rtc@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, dccp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, linux-afs@lists.infradead.org,
 coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org,
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org,
 linux-mmc@vger.kernel.org, Kees Cook <kees.cook@canonical.com>,
 linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-sctp@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org,
 storagedev@microchip.com, Ceph Development <ceph-devel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.org,
 Jiri Kosina <trivial@kernel.org>, linux-parisc@vger.kernel.org,
 netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 netfilter-devel@vger.kernel.org,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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

On Wed, Sep 9, 2020 at 10:10 PM Joe Perches <joe@perches.com> wrote:
>
> fallthrough to a separate case/default label break; isn't very readable.
>
> Convert pseudo-keyword fallthrough; statements to a simple break; when
> the next label is case or default and the only statement in the next
> label block is break;
>
> Found using:
>
> $ grep-2.5.4 -rP --include=*.[ch] -n "fallthrough;(\s*(case\s+\w+|default)\s*:\s*){1,7}break;" *
>
> Miscellanea:
>
> o Move or coalesce a couple label blocks above a default: block.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>
> Compiled allyesconfig x86-64 only.
> A few files for other arches were not compiled.
>
>  arch/arm/mach-mmp/pm-pxa910.c                             |  2 +-
>  arch/arm64/kvm/handle_exit.c                              |  2 +-
>  arch/mips/kernel/cpu-probe.c                              |  2 +-
>  arch/mips/math-emu/cp1emu.c                               |  2 +-
>  arch/s390/pci/pci.c                                       |  2 +-
>  crypto/tcrypt.c                                           |  4 ++--
>  drivers/ata/sata_mv.c                                     |  2 +-
>  drivers/atm/lanai.c                                       |  2 +-
>  drivers/gpu/drm/i915/display/intel_sprite.c               |  2 +-
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmi.c           |  2 +-
>  drivers/hid/wacom_wac.c                                   |  2 +-
>  drivers/i2c/busses/i2c-i801.c                             |  2 +-
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c                    | 14 +++++++-------
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c                    |  6 +++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c               |  2 +-
>  drivers/irqchip/irq-vic.c                                 |  4 ++--
>  drivers/md/dm.c                                           |  2 +-
>  drivers/media/dvb-frontends/drxd_hard.c                   |  2 +-
>  drivers/media/i2c/ov5640.c                                |  2 +-
>  drivers/media/i2c/ov6650.c                                |  5 ++---
>  drivers/media/i2c/smiapp/smiapp-core.c                    |  2 +-
>  drivers/media/i2c/tvp5150.c                               |  2 +-
>  drivers/media/pci/ddbridge/ddbridge-core.c                |  2 +-
>  drivers/media/usb/cpia2/cpia2_core.c                      |  2 +-
>  drivers/mfd/iqs62x.c                                      |  3 +--
>  drivers/mmc/host/atmel-mci.c                              |  2 +-
>  drivers/mtd/nand/raw/nandsim.c                            |  2 +-
>  drivers/net/ethernet/intel/e1000e/phy.c                   |  2 +-
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c               |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c             |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c               |  2 +-
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c               |  2 +-
>  drivers/net/ethernet/intel/igb/e1000_phy.c                |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c            |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c             |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c            |  2 +-
>  drivers/net/ethernet/intel/ixgbevf/vf.c                   |  2 +-
>  drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c |  2 +-
>  drivers/net/ethernet/qlogic/qed/qed_mcp.c                 |  2 +-
>  drivers/net/ethernet/sfc/falcon/farch.c                   |  2 +-
>  drivers/net/ethernet/sfc/farch.c                          |  2 +-
>  drivers/net/phy/adin.c                                    |  3 +--
>  drivers/net/usb/pegasus.c                                 |  4 ++--
>  drivers/net/usb/usbnet.c                                  |  2 +-
>  drivers/net/wireless/ath/ath5k/eeprom.c                   |  2 +-
>  drivers/net/wireless/mediatek/mt7601u/dma.c               |  8 ++++----
>  drivers/nvme/host/core.c                                  | 12 ++++++------
>  drivers/pcmcia/db1xxx_ss.c                                |  4 ++--
>  drivers/power/supply/abx500_chargalg.c                    |  2 +-
>  drivers/power/supply/charger-manager.c                    |  2 +-
>  drivers/rtc/rtc-pcf85063.c                                |  2 +-
>  drivers/s390/scsi/zfcp_fsf.c                              |  2 +-
>  drivers/scsi/aic7xxx/aic79xx_core.c                       |  4 ++--
>  drivers/scsi/aic94xx/aic94xx_tmf.c                        |  2 +-
>  drivers/scsi/lpfc/lpfc_sli.c                              |  2 +-
>  drivers/scsi/smartpqi/smartpqi_init.c                     |  2 +-
>  drivers/scsi/sr.c                                         |  2 +-
>  drivers/tty/serial/sunsu.c                                |  2 +-
>  drivers/tty/serial/sunzilog.c                             |  2 +-
>  drivers/tty/vt/vt_ioctl.c                                 |  2 +-
>  drivers/usb/dwc3/core.c                                   |  2 +-
>  drivers/usb/gadget/legacy/inode.c                         |  2 +-
>  drivers/usb/gadget/udc/pxa25x_udc.c                       |  4 ++--
>  drivers/usb/host/ohci-hcd.c                               |  2 +-
>  drivers/usb/isp1760/isp1760-hcd.c                         |  2 +-
>  drivers/usb/musb/cppi_dma.c                               |  2 +-
>  drivers/usb/phy/phy-fsl-usb.c                             |  2 +-
>  drivers/video/fbdev/stifb.c                               |  2 +-
>  fs/afs/yfsclient.c                                        |  8 ++++----
>  fs/ceph/dir.c                                             |  2 +-

For ceph:

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

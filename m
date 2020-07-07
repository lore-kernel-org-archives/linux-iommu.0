Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D85C433E0
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 14:57:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB0D20775
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 14:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaAXDwnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB0D20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C232D863FF;
	Tue,  7 Jul 2020 14:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JBfQ10G560_d; Tue,  7 Jul 2020 14:57:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 92AA38623F;
	Tue,  7 Jul 2020 14:57:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 730A2C0893;
	Tue,  7 Jul 2020 14:57:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DB9CC016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 14:57:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4C3588904A
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 14:57:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0YyUSr3PA7wn for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 14:57:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 222FE89045
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 14:57:49 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id dg28so38667362edb.3
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jul 2020 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=khu65Pwbl1kNKTb89zOFCrlCO2yNz4sw1thf27kEsfQ=;
 b=jaAXDwnbE/CaK5p1bftSc2YTXzV6lblG73oSqeDq0/3RqUg+H6kxlpO2UlOhqskGTj
 jsv8Z6x5JGoER60nKmqxf8NLbkJAhDrYhEvMEzd9VOU9ATFgQA+ChJB55NpV0Gj1NS+H
 sqUtz9OuC7J1lM7NhOs/Lnuwl/OzTFJ/OeMSZmvom9RETA+EJhjR5cVODwsSPJo/H2I9
 igf46DSpq3jeKyhUK800GmH9Hx8rn1AFxOPPnKgcZ9woQHKH9YIqB3E/m7anxqTtYufZ
 7DzcPfd8sWj1UxcWwESDny9/aZbbD/ompTdYwTuV8YlhKwH8MwQnUP73u2UOVAeVck5W
 yPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=khu65Pwbl1kNKTb89zOFCrlCO2yNz4sw1thf27kEsfQ=;
 b=RbrdrhBgtnl19AmJ8raeHIwR16BMzSBBrMity5NSH+rO3kPI2/mmpT+XAqPOWmNDos
 SZPruCKlm/i1ACiYEWIpaE37I32EART732HzPOko42pOe4uhz/Hg66fBC3aR2PyWECNf
 8RExXi1a6nBKQm7cPCc/kdKUlKRvI3qVYks6yvagtIXC2NzG3cfxjbEcObwl6JJTsRe5
 paI91sIk/foveZP2iE+VxL5cIRmxL2cC00fC1Zj4eQcXeUGgGt97CkT49sbWZPFc8/Gg
 jnBt1+OoCpGkjmgYh0JjVThM6DIZqj7n6xZa8BdS7iZrrAuKGfyEC7Z0rCW24FewW/vb
 SRZA==
X-Gm-Message-State: AOAM5310qFElEyvUKfnfHx8JaaGuLkcV+LJ7k2c1nZEmus1CR1G5w1S/
 KOPmgDRD3Ad+SWupDPcYu7ScYKkEBJY/lRY4Q2Y=
X-Google-Smtp-Source: ABdhPJyDZNWjZFmf40c+Y+boUsk7CQi9jFvF3xqkGvgARdOzu3nM3Ittis1px28gNvEhpp0/KtQJzuCWsqoa4CfOnU0=
X-Received: by 2002:aa7:d792:: with SMTP id s18mr63073213edq.7.1594133867449; 
 Tue, 07 Jul 2020 07:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200626200414.14382-1-jcrouse@codeaurora.org>
 <20200626200414.14382-3-jcrouse@codeaurora.org>
 <99ecd948-7476-b9b4-12b4-1ced0084654f@arm.com>
 <CAF6AEGv2YXu44r9O0ZRkNM2ny4oMStxn4=GoCS3CLpPAKh_KZw@mail.gmail.com>
In-Reply-To: <CAF6AEGv2YXu44r9O0ZRkNM2ny4oMStxn4=GoCS3CLpPAKh_KZw@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 7 Jul 2020 07:58:18 -0700
Message-ID: <CAF6AEGttgRQ3Ug2Nw_vJgjjjUOc0OLPSs+xLv-XFHNrHTOL8sg@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v2 2/6] iommu/io-pgtable: Allow a pgtable
 implementation to skip TLB operations
To: Robin Murphy <robin.murphy@arm.com>
Cc: freedreno <freedreno@lists.freedesktop.org>, Joerg Roedel <jroedel@suse.de>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 John Stultz <john.stultz@linaro.org>, Will Deacon <will@kernel.org>
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

On Tue, Jul 7, 2020 at 7:25 AM Rob Clark <robdclark@gmail.com> wrote:
>
> On Tue, Jul 7, 2020 at 4:34 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2020-06-26 21:04, Jordan Crouse wrote:
> > > Allow a io-pgtable implementation to skip TLB operations by checking for
> > > NULL pointers in the helper functions. It will be up to to the owner
> > > of the io-pgtable instance to make sure that they independently handle
> > > the TLB correctly.
> >
> > I don't really understand what this is for - tricking the IOMMU driver
> > into not performing its TLB maintenance at points when that maintenance
> > has been deemed necessary doesn't seem like the appropriate way to
> > achieve anything good :/
>
> No, for triggering the io-pgtable helpers into not performing TLB
> maintenance.  But seriously, since we are creating pgtables ourselves,
> and we don't want to be ioremap'ing the GPU's SMMU instance, the
> alternative is plugging in no-op helpers.  Which amounts to the same
> thing.

Hmm, that said, since we are just memcpy'ing the io_pgtable_cfg from
arm-smmu, it will already be populated with arm-smmu's fxn ptrs.  I
guess we could maybe make it work without no-op helpers, although in
that case it looks like we need to fix something about aux-domain vs
tlb helpers:

[  +0.004373] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000019
[  +0.004086] Mem abort info:
[  +0.004319]   ESR = 0x96000004
[  +0.003462]   EC = 0x25: DABT (current EL), IL = 32 bits
[  +0.003494]   SET = 0, FnV = 0
[  +0.002812]   EA = 0, S1PTW = 0
[  +0.002873] Data abort info:
[  +0.003031]   ISV = 0, ISS = 0x00000004
[  +0.003785]   CM = 0, WnR = 0
[  +0.003641] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000261d65000
[  +0.003383] [0000000000000019] pgd=0000000000000000, p4d=0000000000000000
[  +0.003715] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[  +0.002744] Modules linked in: xt_CHECKSUM xt_MASQUERADE
xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle
ip6table_nat iptable_mangle iptable_nat nf_nat nf_conntrack
nf_defrag_ipv4 libcrc32c bridge stp llc ip6table_filter ip6_tables
iptable_filter ax88179_178a usbnet uvcvideo videobuf2_vmalloc
videobuf2_memops videobuf2_v4l2 videobuf2_common videodev mc
hid_multitouch i2c_hid some_battery ti_sn65dsi86 hci_uart btqca btbcm
qcom_spmi_adc5 bluetooth qcom_spmi_temp_alarm qcom_vadc_common
ecdh_generic ecc snd_soc_sdm845 snd_soc_rt5663 snd_soc_qcom_common
ath10k_snoc ath10k_core crct10dif_ce ath mac80211 snd_soc_rl6231
soundwire_bus i2c_qcom_geni libarc4 qcom_rng msm phy_qcom_qusb2
reset_qcom_pdc drm_kms_helper cfg80211 rfkill qcom_q6v5_mss
qcom_q6v5_ipa_notify socinfo qrtr ns panel_simple qcom_q6v5_pas
qcom_common qcom_glink_smem slim_qcom_ngd_ctrl qcom_sysmon drm
qcom_q6v5 slimbus qmi_helpers qcom_wdt mdt_loader rmtfs_mem be2iscsi
bnx2i cnic uio cxgb4i cxgb4 cxgb3i cxgb3 mdio
[  +0.000139]  libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp
libiscsi_tcp libiscsi scsi_transport_iscsi fuse ip_tables x_tables
ipv6 nf_defrag_ipv6
[  +0.020933] CPU: 3 PID: 168 Comm: kworker/u16:7 Not tainted
5.8.0-rc1-c630+ #31
[  +0.003828] Hardware name: LENOVO 81JL/LNVNB161216, BIOS
9UCN33WW(V2.06) 06/ 4/2019
[  +0.004039] Workqueue: msm msm_gem_free_work [msm]
[  +0.003885] pstate: 60c00005 (nZCv daif +PAN +UAO BTYPE=--)
[  +0.003859] pc : arm_smmu_tlb_inv_range_s1+0x30/0x148
[  +0.003742] lr : arm_smmu_tlb_add_page_s1+0x1c/0x28
[  +0.003887] sp : ffff800011cdb970
[  +0.003868] x29: ffff800011cdb970 x28: 0000000000000003
[  +0.003930] x27: ffff0001f1882f80 x26: 0000000000000001
[  +0.003886] x25: 0000000000000003 x24: 0000000000000620
[  +0.003932] x23: 0000000000000000 x22: 0000000000001000
[  +0.003886] x21: 0000000000001000 x20: ffff0001cf857300
[  +0.003916] x19: 0000000000000001 x18: 00000000ffffffff
[  +0.003921] x17: ffffd9e6a24ae0e8 x16: 0000000000012577
[  +0.003843] x15: 0000000000012578 x14: 0000000000000000
[  +0.003884] x13: 0000000000012574 x12: ffffd9e6a2550180
[  +0.003834] x11: 0000000000083f80 x10: 0000000000000000
[  +0.003889] x9 : 0000000000000000 x8 : ffff0001f1882f80
[  +0.003812] x7 : 0000000000000001 x6 : 0000000000000048
[  +0.003807] x5 : ffff0001c86e1000 x4 : 0000000000000620
[  +0.003802] x3 : ffff0001ddb57700 x2 : 0000000000001000
[  +0.003809] x1 : 0000000000001000 x0 : 0000000101048000
[  +0.003768] Call trace:
[  +0.003665]  arm_smmu_tlb_inv_range_s1+0x30/0x148
[  +0.003769]  arm_smmu_tlb_add_page_s1+0x1c/0x28
[  +0.003760]  __arm_lpae_unmap+0x3c4/0x498
[  +0.003821]  __arm_lpae_unmap+0xfc/0x498
[  +0.003693]  __arm_lpae_unmap+0xfc/0x498
[  +0.003704]  __arm_lpae_unmap+0xfc/0x498
[  +0.003608]  arm_lpae_unmap+0x60/0x78
[  +0.003653]  msm_iommu_pagetable_unmap+0x5c/0xa0 [msm]
[  +0.003711]  msm_gem_purge_vma+0x48/0x70 [msm]
[  +0.003716]  put_iova+0x68/0xc8 [msm]
[  +0.003792]  msm_gem_free_work+0x118/0x190 [msm]
[  +0.003739]  process_one_work+0x28c/0x6e8
[  +0.003595]  worker_thread+0x4c/0x420
[  +0.003546]  kthread+0x148/0x168
[  +0.003675]  ret_from_fork+0x10/0x1c
[  +0.003596] Code: 2a0403f8 a9046bf9 f9400073 39406077 (b9401a61)

BR,
-R

>
> Currently (in a later patch in the series) we are using
> iommu_flush_tlb_all() when unmapping, which is a bit of a big hammer.
> Although I think we could be a bit more clever and do the TLB ops on
> the GPU (since the GPU knows if pagetables we are unmapping from are
> in-use and could skip the TLB ops otherwise).
>
> On the topic, if we are using unique ASID values per set of
> pagetables, how expensive is tlb invalidate for an ASID that has no
> entries in the TLB?
>
> BR,
> -R
>
> >
> > Robin.
> >
> > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > ---
> > >
> > >   include/linux/io-pgtable.h | 11 +++++++----
> > >   1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> > > index 53d53c6c2be9..bbed1d3925ba 100644
> > > --- a/include/linux/io-pgtable.h
> > > +++ b/include/linux/io-pgtable.h
> > > @@ -210,21 +210,24 @@ struct io_pgtable {
> > >
> > >   static inline void io_pgtable_tlb_flush_all(struct io_pgtable *iop)
> > >   {
> > > -     iop->cfg.tlb->tlb_flush_all(iop->cookie);
> > > +     if (iop->cfg.tlb)
> > > +             iop->cfg.tlb->tlb_flush_all(iop->cookie);
> > >   }
> > >
> > >   static inline void
> > >   io_pgtable_tlb_flush_walk(struct io_pgtable *iop, unsigned long iova,
> > >                         size_t size, size_t granule)
> > >   {
> > > -     iop->cfg.tlb->tlb_flush_walk(iova, size, granule, iop->cookie);
> > > +     if (iop->cfg.tlb)
> > > +             iop->cfg.tlb->tlb_flush_walk(iova, size, granule, iop->cookie);
> > >   }
> > >
> > >   static inline void
> > >   io_pgtable_tlb_flush_leaf(struct io_pgtable *iop, unsigned long iova,
> > >                         size_t size, size_t granule)
> > >   {
> > > -     iop->cfg.tlb->tlb_flush_leaf(iova, size, granule, iop->cookie);
> > > +     if (iop->cfg.tlb)
> > > +             iop->cfg.tlb->tlb_flush_leaf(iova, size, granule, iop->cookie);
> > >   }
> > >
> > >   static inline void
> > > @@ -232,7 +235,7 @@ io_pgtable_tlb_add_page(struct io_pgtable *iop,
> > >                       struct iommu_iotlb_gather * gather, unsigned long iova,
> > >                       size_t granule)
> > >   {
> > > -     if (iop->cfg.tlb->tlb_add_page)
> > > +     if (iop->cfg.tlb && iop->cfg.tlb->tlb_add_page)
> > >               iop->cfg.tlb->tlb_add_page(gather, iova, granule, iop->cookie);
> > >   }
> > >
> > >
> > _______________________________________________
> > Freedreno mailing list
> > Freedreno@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/freedreno
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

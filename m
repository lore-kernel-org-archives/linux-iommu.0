Return-Path: <SRS0=d1gY=H3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8341FC433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 11:50:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D438064F16
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 11:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D438064F16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5FFDD43127;
	Thu, 25 Feb 2021 11:50:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 40wljahKOJ6M; Thu, 25 Feb 2021 11:50:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 275BA43215;
	Thu, 25 Feb 2021 11:50:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF84FC000A;
	Thu, 25 Feb 2021 11:50:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E310FC0001
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 11:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC5C88401E
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 11:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fFu3-3PJrw9q for <iommu@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 11:50:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B34188401D
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 11:50:48 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id s16so3049974plr.9
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 03:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0B9oiEdMqRhfoJWkOju0T0Vr8U2SwLqEx/PSHKI/Odg=;
 b=uqJBc5JHbdZXcLndlbe/UK/jS9f1K26s1fczq5FkBKZszQ3wNjU7uxuOo9kc4BQYZf
 LvI/x67SJdPTTkoAB5mlrmKB5HsMbGWE7IDuhUVZu3tyKPZLiasXBrV70SQxBUg60g2o
 Pd7lyoD/g5E5SsXldlCrrI0P2MB/9KWfQqbp0ntE9HQoO+cRWvuXfxisDXJyW39o4VJo
 dG4a3csLnssLf9hkukYYGvZA/ZqJFh8PhnNTlOC8dwBSCcvrypq8pNkqx1fu1IK88F9q
 4otsBBBgjbnannaYuQ7mO3nQWwIdZZqPRANnDyifuEf2oBjd+o8hhsE9VBMpjYe5RidY
 jHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0B9oiEdMqRhfoJWkOju0T0Vr8U2SwLqEx/PSHKI/Odg=;
 b=cNlsYkBkiCvILDwv+bcKuRToeXPhASKJVcFRm5funKvNowI3ri8UTZ2snmeeqJ7jC6
 vRetQZNX9qujcOnwR167HpKvB+OU4jczhtAWvn+uFK+jfCiB17FzHI499eJht/hOQrVa
 V5YIzaAr7qtW/8kTP+TQpMcke/wOizib8FVFfVebSR0ZudMBOUlajx/lISuh2OGzXT4q
 OSTwpUHE9XYzpfJwOE9IpGW3PNIM/4ckT9c2+ck+W8qcZ1QaYIsuuKAikGCEJTyYJl75
 ikZv40Hgsb+Ic2TqIZL9wE6QI/x3gxmPFkJFf9QYN+3Y+pBdA1xlEILDoYFiHJf+fstV
 2yvA==
X-Gm-Message-State: AOAM533AkSWi88TSpUXSTj5km/XcHyyZ61u2mknwP9qyPMDarnPQYhOr
 XPHZN0SVwtVYjOhYZPuqFCw=
X-Google-Smtp-Source: ABdhPJy8MNShyei2sCwixvz4CPF8UNNkyiWe2b1uImZSkz/o6juJEdDmCp/H30BaZjGm9Sh+EZqp+A==
X-Received: by 2002:a17:90a:2a4f:: with SMTP id
 d15mr2999085pjg.16.1614253848086; 
 Thu, 25 Feb 2021 03:50:48 -0800 (PST)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id w10sm3775276pfj.82.2021.02.25.03.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Feb 2021 03:50:46 -0800 (PST)
Date: Thu, 25 Feb 2021 12:50:40 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: next/master bisection: baseline.login on r8a77960-ulcb
Message-ID: <YDePENfrhpr5M0F2@ulmo.localdomain>
References: <60346234.1c69fb81.cd55e.770d@mx.google.com>
 <7ac4a45f-b95e-acc0-f5bc-e4f870ac0bf1@collabora.com>
 <db197ccf-3b55-098e-bc19-ca8adc98c6b2@gmail.com>
 <YDeFbC8DzsB1GYNY@ulmo.localdomain>
 <6804ffd9-4558-abd4-db17-22eb5617d996@arm.com>
MIME-Version: 1.0
In-Reply-To: <6804ffd9-4558-abd4-db17-22eb5617d996@arm.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Cc: "kernelci-results@groups.io" <kernelci-results@groups.io>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Guillaume Tucker <guillaume.tucker@collabora.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Heiko Thiery <heiko.thiery@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Jianxiong Gao <jxgao@google.com>
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
Content-Type: multipart/mixed; boundary="===============5580056885047360958=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5580056885047360958==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KdnqTXtbr47l87dM"
Content-Disposition: inline


--KdnqTXtbr47l87dM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 25, 2021 at 11:14:57AM +0000, Robin Murphy wrote:
> On 2021-02-25 11:09, Thierry Reding wrote:
> > On Wed, Feb 24, 2021 at 10:39:42PM +0100, Heiko Thiery wrote:
> > > Hi Christoph and all,
> > >=20
> > > On 23.02.21 10:56, Guillaume Tucker wrote:
> > > > Hi Christoph,
> > > >=20
> > > > Please see the bisection report below about a boot failure on
> > > > r8a77960-ulcb on next-20210222.
> > > >=20
> > > > Reports aren't automatically sent to the public while we're
> > > > trialing new bisection features on kernelci.org but this one
> > > > looks valid.
> > > >=20
> > > > The log shows a kernel panic, more details can be found here:
> > > >=20
> > > >     https://kernelci.org/test/case/id/6034bde034504edc9faddd2c/
> > > >=20
> > > > Please let us know if you need any help to debug the issue or try
> > > > a fix on this platform.
> > >=20
> > > I am also seeing this problem on an iMX8MQ board and can help test if=
 you
> > > have a fix.
> >=20
> > This is also causing boot failures on Jetson AGX Xavier. The origin is
> > slightly different from the above kernelci.org report, but the BUG_ON is
> > the same:
> >=20
> >      [    2.650447] ------------[ cut here ]------------
> >      [    2.650588] kernel BUG at include/linux/iommu-helper.h:23!
> >      [    2.650729] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> >      [    2.654330] Modules linked in:
> >      [    2.657474] CPU: 2 PID: 67 Comm: kworker/2:1 Not tainted 5.11.0=
-next-20210225-00025-gfd15609b3a81-dirty #120
> >      [    2.667367] Hardware name: NVIDIA Jetson AGX Xavier Developer K=
it (DT)
> >      [    2.674096] Workqueue: events deferred_probe_work_func
> >      [    2.679169] pstate: 40400089 (nZcv daIf +PAN -UAO -TCO BTYPE=3D=
--)
> >      [    2.684949] pc : find_slots.isra.0+0x118/0x2f0
> >      [    2.689494] lr : find_slots.isra.0+0x88/0x2f0
> >      [    2.693696] sp : ffff800011faf950
> >      [    2.697281] x29: ffff800011faf950 x28: 0000000000000001
> >      [    2.702537] x27: 0000000000000001 x26: 0000000000000000
> >      [    2.708131] x25: 0000000000000001 x24: 0000000105f03148
> >      [    2.713556] x23: 0000000000000001 x22: ffff800011559000
> >      [    2.718835] x21: ffff800011559a80 x20: 00000000edc00000
> >      [    2.724493] x19: 0000000000000000 x18: 0000000000000020
> >      [    2.729770] x17: ffff0003ffd7d160 x16: 0000000000000068
> >      [    2.735173] x15: ffff000080b43150 x14: ffffffffffffffff
> >      [    2.740944] x13: ffff000082b5d791 x12: 0000000000000040
> >      [    2.746113] x11: ffff0000a0000248 x10: 0000000000000000
> >      [    2.751882] x9 : 0000000000000000 x8 : ffff0003fed30000
> >      [    2.757139] x7 : 0000000000000000 x6 : 0000000000000000
> >      [    2.762818] x5 : 0000000000000000 x4 : 0000000000000000
> >      [    2.767984] x3 : 00000001e8303148 x2 : 0000000000008000
> >      [    2.773580] x1 : ffffffffffffffff x0 : 00000000001db800
> >      [    2.778662] Call trace:
> >      [    2.781136]  find_slots.isra.0+0x118/0x2f0
> >      [    2.785137]  swiotlb_tbl_map_single+0x80/0x1b4
> >      [    2.789858]  swiotlb_map+0x58/0x200
> >      [    2.793355]  dma_direct_map_page+0x148/0x1c0
> >      [    2.797386]  dma_map_page_attrs+0x2c/0x54
> >      [    2.801411]  dw_pcie_host_init+0x40c/0x4c0
> >      [    2.805633]  tegra_pcie_config_rp+0x7c/0x1f4
> >      [    2.810155]  tegra_pcie_dw_probe+0x3d0/0x60c
> >      [    2.814185]  platform_probe+0x68/0xe0
> >      [    2.817688]  really_probe+0xe4/0x4c0
> >      [    2.821362]  driver_probe_device+0x58/0xc0
> >      [    2.825386]  __device_attach_driver+0xa8/0x104
> >      [    2.829953]  bus_for_each_drv+0x78/0xd0
> >      [    2.833434]  __device_attach+0xdc/0x17c
> >      [    2.837631]  device_initial_probe+0x14/0x20
> >      [    2.841680]  bus_probe_device+0x9c/0xa4
> >      [    2.845160]  deferred_probe_work_func+0x74/0xb0
> >      [    2.849734]  process_one_work+0x1cc/0x350
> >      [    2.853822]  worker_thread+0x20c/0x3ac
> >      [    2.858018]  kthread+0x128/0x134
> >      [    2.860997]  ret_from_fork+0x10/0x34
> >      [    2.864508] Code: ca180063 ea06007f 54fffee1 b50001e7 (d4210000)
> >      [    2.870547] ---[ end trace e5c50bdcf12b316e ]---
> >      [    2.875087] note: kworker/2:1[67] exited with preempt_count 2
> >      [    2.880836] ------------[ cut here ]------------
> >=20
> > I've confirmed that reverting the following commits makes the system
> > boot again:
> >=20
> >      47cfc5be1934 ("swiotlb: Validate bounce size in the sync/unmap pat=
h")
> >      c6f50c7719e7 ("swiotlb: respect min_align_mask")
> >      e952d9a1bc20 ("swiotlb: don't modify orig_addr in swiotlb_tbl_sync=
_single")
> >      567d877f9a7d ("swiotlb: refactor swiotlb_tbl_map_single")
> >=20
> > Let me know if I can help test any fixes for this.
>=20
> FWIW, this sounds like it's probably the same thing for which a fix should
> be pending:
>=20
> https://lore.kernel.org/linux-iommu/20210223072514.GA18079@lst.de/T/#u

Yep, changing max_slots from unsigned int to unsigned long fixes this as
well. Thanks for the pointer!

Thierry

--KdnqTXtbr47l87dM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmA3jwwACgkQ3SOs138+
s6Egqg/+Ij6DkLI7vIbSTIFsyzc3lQFDP/FvPzGQHQMzHRK/uoKzlV73RrPmcfx3
nILOeWaucoOSN/uiMGkJLdmxEwTOr+x6bJMme1OItD3DQ8O68UMXx/ntWDbPAHVv
sfcqUapmd9TnnZ5xMjyEn3H0ueakHpQOhmX3R9fNxOUPD0TRd5sk+riM9tn9t0sY
q3ZP4bH66a1f5clMeDM3MaXilZmXE2ove1mqrLQPZcygtRmfcNS8n7KeRTS8DZ/p
jh0vEhy5zru+Hsncokp6NrtAKmoOyNiu6P7UDx+Rt69o6Mhm0JdnHLnQyJd4z6jF
gLOTJRM0VTxhpqcGoiJeN62aaw7s57c51hTBU8bzrgyRFfUNIufG9EXIAaJ8aGbw
3fGURuwlQfIWrNS/BwTrOQFc3CIqnn7cd9t8Oo7/C1pNjOPkVOBzmIKV6Au2I4gw
jz43SwwBOct6jRdbBNmwXtSAHaqNVLDvCPNwlr9jokD+CaTcj5F3eIF9AhasHQHr
prdwqAyiVKrOqw7v7VhdkZdv9DhUcPJmRnH+oYFqfP4Y/7bcOG/jVQHNkr8onwVT
orGb+0s4S2ptg6s2q91G4rgf/cDrASXdBembmlv0qCNeIaMtX7zJMyYm+2VuvNCs
l6bqsnPhGPJFb9QjAgnLG46m8T1fFarGssvk5DeHgOJOAHZiYPQ=
=SjT1
-----END PGP SIGNATURE-----

--KdnqTXtbr47l87dM--

--===============5580056885047360958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5580056885047360958==--

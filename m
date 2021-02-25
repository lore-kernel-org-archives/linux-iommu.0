Return-Path: <SRS0=d1gY=H3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAF4C433E0
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 11:09:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F24264ECF
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 11:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F24264ECF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E06AF6F740;
	Thu, 25 Feb 2021 11:09:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LLRE6fDLCy2R; Thu, 25 Feb 2021 11:09:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 824016F733;
	Thu, 25 Feb 2021 11:09:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58B96C000B;
	Thu, 25 Feb 2021 11:09:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4921C0001
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 11:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDAD683FFF
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 11:09:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s6f65ZG5w4wK for <iommu@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 11:09:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C72C83FFE
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 11:09:38 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id v15so4833971wrx.4
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 03:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3ctGBM3oOvi3cpwulix/8QZ7Ac/Ws896zzc4IE99Z6A=;
 b=OUk20K8v1BIRa558hlpVOufBLV+bM1xz+TXswU+tvKAMgcnGThRHeJddjZb0hPZGAY
 ia55ZlIk65gERcAEdX5uHG8yI0U4rENFE7dBS8OkWMIdDcBKo1xTbGZ5+AyeufB1O7Nl
 NcwBbBIoM4K3mLDF/IilnhU2L+wui4FkOvC2p+1iVUSI+4zj0INB39acIFtKFFAFaGUH
 nSthBNjoVou2dQp2ZaawDCzQAWesJBsHyISO03C5c4Kp/8ygPH6mSlyVhf4G8ZRipmgd
 d6AW1rau20lF2Z0FP00iy5YeQKlSfNXUtpjYngMCE4Ns91lwKkjXJrkG02B+hIad5uHE
 s/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3ctGBM3oOvi3cpwulix/8QZ7Ac/Ws896zzc4IE99Z6A=;
 b=JCI04e7VTEs7gWh9DPgf677FzBWRSZKnhZX8+8ttIxlcU1GsmPD60SJ5+b16VGnyMB
 QAVg7Gc0MJNpgxRXuynzQLkWK6s5QEU+eLpwg02QZkbc2V07n9lxYtZUybsCJ8K0SVQK
 zIuCe4Nw0UnDUiPzfBNCceB94EfFhsMVwtY4fkuB8X1S4uQ4d/mqHyH0KS1zlVoRCemZ
 XDLBIVNOTy9vGg1rkWgAaT6ZyfIA6sfN7DPtsmt23ajojqesVLg1VPdoBEWnRo5ocNMJ
 cbS/vVpj8P20b5T5HVmRrR4YD/p0I/y0SP/v9k4A0qUi1d9oI8qhRpqU0WvQHFfDFnkq
 YVGg==
X-Gm-Message-State: AOAM532rkMlvDNHi3UEt9QxnAcJFl0eMC+vXTyzjnJpUQHTIwtUNKz1F
 7pNrJqaBeDTo6ZIuO89eEwk=
X-Google-Smtp-Source: ABdhPJwRv+ClIrkClr1a80/LliaAUwuoO2lnFVTfSIGx5AUqCiKIk2+VOuKbM04e15iSrbN9AxPA3A==
X-Received: by 2002:a5d:4e10:: with SMTP id p16mr2927071wrt.360.1614251376490; 
 Thu, 25 Feb 2021 03:09:36 -0800 (PST)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id h10sm5264187wrp.22.2021.02.25.03.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Feb 2021 03:09:34 -0800 (PST)
Date: Thu, 25 Feb 2021 12:09:32 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Heiko Thiery <heiko.thiery@gmail.com>
Subject: Re: next/master bisection: baseline.login on r8a77960-ulcb
Message-ID: <YDeFbC8DzsB1GYNY@ulmo.localdomain>
References: <60346234.1c69fb81.cd55e.770d@mx.google.com>
 <7ac4a45f-b95e-acc0-f5bc-e4f870ac0bf1@collabora.com>
 <db197ccf-3b55-098e-bc19-ca8adc98c6b2@gmail.com>
MIME-Version: 1.0
In-Reply-To: <db197ccf-3b55-098e-bc19-ca8adc98c6b2@gmail.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Cc: "kernelci-results@groups.io" <kernelci-results@groups.io>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Guillaume Tucker <guillaume.tucker@collabora.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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
Content-Type: multipart/mixed; boundary="===============0083684043895809027=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0083684043895809027==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vAvTUIMDaSUl6gjb"
Content-Disposition: inline


--vAvTUIMDaSUl6gjb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 24, 2021 at 10:39:42PM +0100, Heiko Thiery wrote:
> Hi Christoph and all,
>=20
> On 23.02.21 10:56, Guillaume Tucker wrote:
> > Hi Christoph,
> >=20
> > Please see the bisection report below about a boot failure on
> > r8a77960-ulcb on next-20210222.
> >=20
> > Reports aren't automatically sent to the public while we're
> > trialing new bisection features on kernelci.org but this one
> > looks valid.
> >=20
> > The log shows a kernel panic, more details can be found here:
> >=20
> >    https://kernelci.org/test/case/id/6034bde034504edc9faddd2c/
> >=20
> > Please let us know if you need any help to debug the issue or try
> > a fix on this platform.
>=20
> I am also seeing this problem on an iMX8MQ board and can help test if you
> have a fix.

This is also causing boot failures on Jetson AGX Xavier. The origin is
slightly different from the above kernelci.org report, but the BUG_ON is
the same:

    [    2.650447] ------------[ cut here ]------------
    [    2.650588] kernel BUG at include/linux/iommu-helper.h:23!
    [    2.650729] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
    [    2.654330] Modules linked in:
    [    2.657474] CPU: 2 PID: 67 Comm: kworker/2:1 Not tainted 5.11.0-next=
-20210225-00025-gfd15609b3a81-dirty #120
    [    2.667367] Hardware name: NVIDIA Jetson AGX Xavier Developer Kit (D=
T)
    [    2.674096] Workqueue: events deferred_probe_work_func
    [    2.679169] pstate: 40400089 (nZcv daIf +PAN -UAO -TCO BTYPE=3D--)
    [    2.684949] pc : find_slots.isra.0+0x118/0x2f0
    [    2.689494] lr : find_slots.isra.0+0x88/0x2f0
    [    2.693696] sp : ffff800011faf950
    [    2.697281] x29: ffff800011faf950 x28: 0000000000000001
    [    2.702537] x27: 0000000000000001 x26: 0000000000000000
    [    2.708131] x25: 0000000000000001 x24: 0000000105f03148
    [    2.713556] x23: 0000000000000001 x22: ffff800011559000
    [    2.718835] x21: ffff800011559a80 x20: 00000000edc00000
    [    2.724493] x19: 0000000000000000 x18: 0000000000000020
    [    2.729770] x17: ffff0003ffd7d160 x16: 0000000000000068
    [    2.735173] x15: ffff000080b43150 x14: ffffffffffffffff
    [    2.740944] x13: ffff000082b5d791 x12: 0000000000000040
    [    2.746113] x11: ffff0000a0000248 x10: 0000000000000000
    [    2.751882] x9 : 0000000000000000 x8 : ffff0003fed30000
    [    2.757139] x7 : 0000000000000000 x6 : 0000000000000000
    [    2.762818] x5 : 0000000000000000 x4 : 0000000000000000
    [    2.767984] x3 : 00000001e8303148 x2 : 0000000000008000
    [    2.773580] x1 : ffffffffffffffff x0 : 00000000001db800
    [    2.778662] Call trace:
    [    2.781136]  find_slots.isra.0+0x118/0x2f0
    [    2.785137]  swiotlb_tbl_map_single+0x80/0x1b4
    [    2.789858]  swiotlb_map+0x58/0x200
    [    2.793355]  dma_direct_map_page+0x148/0x1c0
    [    2.797386]  dma_map_page_attrs+0x2c/0x54
    [    2.801411]  dw_pcie_host_init+0x40c/0x4c0
    [    2.805633]  tegra_pcie_config_rp+0x7c/0x1f4
    [    2.810155]  tegra_pcie_dw_probe+0x3d0/0x60c
    [    2.814185]  platform_probe+0x68/0xe0
    [    2.817688]  really_probe+0xe4/0x4c0
    [    2.821362]  driver_probe_device+0x58/0xc0
    [    2.825386]  __device_attach_driver+0xa8/0x104
    [    2.829953]  bus_for_each_drv+0x78/0xd0
    [    2.833434]  __device_attach+0xdc/0x17c
    [    2.837631]  device_initial_probe+0x14/0x20
    [    2.841680]  bus_probe_device+0x9c/0xa4
    [    2.845160]  deferred_probe_work_func+0x74/0xb0
    [    2.849734]  process_one_work+0x1cc/0x350
    [    2.853822]  worker_thread+0x20c/0x3ac
    [    2.858018]  kthread+0x128/0x134
    [    2.860997]  ret_from_fork+0x10/0x34
    [    2.864508] Code: ca180063 ea06007f 54fffee1 b50001e7 (d4210000)
    [    2.870547] ---[ end trace e5c50bdcf12b316e ]---
    [    2.875087] note: kworker/2:1[67] exited with preempt_count 2
    [    2.880836] ------------[ cut here ]------------

I've confirmed that reverting the following commits makes the system
boot again:

    47cfc5be1934 ("swiotlb: Validate bounce size in the sync/unmap path")
    c6f50c7719e7 ("swiotlb: respect min_align_mask")
    e952d9a1bc20 ("swiotlb: don't modify orig_addr in swiotlb_tbl_sync_sing=
le")
    567d877f9a7d ("swiotlb: refactor swiotlb_tbl_map_single")

Let me know if I can help test any fixes for this.

Thierry

--vAvTUIMDaSUl6gjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmA3hWcACgkQ3SOs138+
s6HKQhAAhS7ALuFbl4xxOVHkxKu0YmVjEelr0mC2Yjy7HJoe433HsE8B3NdGoJgM
3vLOsSQsPtlaW9b69QspLyWoG073eHYKZwh2mvEAaAO7U3dWtNrcUs0z0xjTCGsy
dfvkVU2pOQIN5jpeL4nSqhCr/MiAX+4jqvTZE808r9UHTogzmbO4IIQboDq4qsJZ
1/EGWiavl6ToX/Fzcu+TbsYDI8gIlUeW8B3nwMf+hKeTwwyYKi3Alen1bRurfrck
20VGaEaR2eZqcNnz/OzqeQsH+BxQOcjQ8AmQ0IqizqcyuL/euyowr4wBak+K9qYJ
jZU/G/MBnzRj3Hg1LNtqpfogHLGA1RAXnMZcCj1Gq4jaVxF8bfzHu5fCgU0cL2BP
+G/DhxPTNJqkQtTLWQRoSZQ6yzoQ1t/DqSz1QGfBS21N8m/gaSvYNLHr0+H6ehog
2Q+GcXCTiN24k3KoSLYVI90+Earko/3iRd7rvbvDaayZdowwTmAM7uRmuuoYIBwv
Nc1UKRPwGRXJfx6nAMdN2oUwn6Ad8nD1uyIY/Umu7Gy0PUpGYZpX+yjggrudCcZN
U8IFOr8ITW+XeP8zs/JCeVacVLuaqpeJKEXyGlicvcWkvGiyS30Gftvuz8lpzvGZ
06kOg0dM5EzcDv7wLQlFEnb20oSQkNKB80yJQ4GQhENZg9qvLco=
=kU7p
-----END PGP SIGNATURE-----

--vAvTUIMDaSUl6gjb--

--===============0083684043895809027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0083684043895809027==--
